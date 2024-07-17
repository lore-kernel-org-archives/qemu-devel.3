Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C16AC3DA5D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2TS-0005hu-2v; Wed, 17 Jul 2024 07:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2Sj-0001qM-3g
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:47 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2Sa-000734-6H
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:41 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id A7D3038F9CC; Wed, 17 Jul 2024 13:04:06 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, agraf@csgraf.de, pbonzini@redhat.com,
 phil@philjordan.eu, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, akihiko.odaki@daynix.com,
 peter.maydell@linaro.org
Subject: [PATCH v2 6/8] hw/display/apple-gfx: Host GPU picking improvements
Date: Wed, 17 Jul 2024 13:03:24 +0200
Message-Id: <20240717110326.45230-7-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240717110326.45230-1-phil@philjordan.eu>
References: <20240717110326.45230-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=89.104.8.17; envelope-from=phil@intel-mbp.local;
 helo=intel-mbp.local
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, KHOP_HELO_FCRDNS=0.261,
 NO_DNS_FOR_FROM=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 TVD_RCVD_IP=0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

During startup of the PV graphics device, we need to specify the
host GPU to use for PV acceleration of the guest's graphics
operations.

On a host system, this is trivial: pick the only one. The
MTLCreateSystemDefaultDevice() function will do the right thing
in this case.

It gets a little more complicated on systems with more than one
GPU; first and foremost, this applies to x86-64 MacBook Pros
with 15/16" displays. However, with eGPUs, in theory any x86-64
Mac can gain one or more additional GPUs. In these cases, the
default is often not ideal - usually, discrete GPUs are selected.
In my tests, performance tends to be best with iGPUs, however,
and they are usually also best in terms of energy consumption.

Ideally, we will want to allow the user to manually select a GPU
if they so choose. In this patch, I am interested in picking a
sensible default. Instead of the built-in default logic, it is
now:

 1. Select a GPU with unified memory (iGPU)
 2. If (1) fails, select a GPU that is built-in, not an eGPU.
 3. If (2) fails, fall back to system default.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.m | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 6f374455f9..018db8bf19 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -500,6 +500,32 @@ static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
     return mode_array;
 }
 
+static id<MTLDevice> copy_suitable_metal_device(void)
+{
+    id<MTLDevice> dev = nil;
+    NSArray<id<MTLDevice>> *devs = MTLCopyAllDevices();
+
+    /* Prefer a unified memory GPU. Failing that, pick a non-removable GPU. */
+    for (size_t i = 0; i < devs.count; ++i) {
+        if (devs[i].hasUnifiedMemory) {
+            dev = devs[i];
+            break;
+        }
+        if (!devs[i].removable) {
+            dev = devs[i];
+        }
+    }
+
+    if (dev != nil) {
+        [dev retain];
+    } else {
+        dev = MTLCreateSystemDefaultDevice();
+    }
+    [devs release];
+
+    return dev;
+}
+
 void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc)
 {
     PGDisplayDescriptor *disp_desc = nil;
@@ -507,7 +533,7 @@ void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc)
     QTAILQ_INIT(&s->tasks);
     s->render_queue = dispatch_queue_create("apple-gfx.render",
                                             DISPATCH_QUEUE_SERIAL);
-    s->mtl = MTLCreateSystemDefaultDevice();
+    s->mtl = copy_suitable_metal_device();
     s->mtl_queue = [s->mtl newCommandQueue];
 
     desc.device = s->mtl;
-- 
2.39.3 (Apple Git-146)


