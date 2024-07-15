Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C669CC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2SG-0008TQ-VV; Wed, 17 Jul 2024 07:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SD-0008Fq-HT
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:13 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SB-0006yr-Cj
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:13 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id 6EAE537964D; Mon, 15 Jul 2024 23:07:38 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 23/26] hw/display/apple-gfx: Host GPU picking improvements
Date: Mon, 15 Jul 2024 23:07:02 +0200
Message-Id: <20240715210705.32365-24-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240715210705.32365-1-phil@philjordan.eu>
References: <20240715210705.32365-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=89.104.8.17; envelope-from=phil@intel-mbp.local;
 helo=intel-mbp.local
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, KHOP_HELO_FCRDNS=0.261,
 NO_DNS_FOR_FROM=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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
index cbcbaf0006..6c92f2579b 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -502,6 +502,32 @@ static void apple_gfx_register_task_mapping_handlers(AppleGFXState *s,
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
@@ -509,7 +535,7 @@ void apple_gfx_common_realize(AppleGFXState *s, PGDeviceDescriptor *desc)
     QTAILQ_INIT(&s->tasks);
     s->render_queue = dispatch_queue_create("apple-gfx.render",
                                             DISPATCH_QUEUE_SERIAL);
-    s->mtl = MTLCreateSystemDefaultDevice();
+    s->mtl = copy_suitable_metal_device();
     s->mtl_queue = [s->mtl newCommandQueue];
 
     desc.device = s->mtl;
-- 
2.39.3 (Apple Git-146)


