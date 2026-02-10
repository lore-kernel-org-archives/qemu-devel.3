Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BCBEA8105
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpmdo-0000er-Fp; Tue, 10 Feb 2026 07:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmdm-0000eN-B7; Tue, 10 Feb 2026 07:14:50 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vpmdk-0008P5-Oe; Tue, 10 Feb 2026 07:14:50 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6ED05187D9B;
 Tue, 10 Feb 2026 15:13:51 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0B33C360CBD;
 Tue, 10 Feb 2026 15:14:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.1 57/78] hw/nvme: Fix bootindex suffix use-after-free
Date: Tue, 10 Feb 2026 15:14:10 +0300
Message-ID: <20260210121438.67781-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.1-20260210151332@cover.tls.msk.ru>
References: <qemu-stable-10.2.1-20260210151332@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

The bootindex suffix can be used as long as the property is alive.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260125-nvme-v1-5-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit eda9baa17a2854494709a8094419ba6a6901721d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 58800b3414..38f86a1726 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -944,12 +944,11 @@ static void nvme_ns_class_init(ObjectClass *oc, const void *data)
 static void nvme_ns_instance_init(Object *obj)
 {
     NvmeNamespace *ns = NVME_NS(obj);
-    char *bootindex = g_strdup_printf("/namespace@%d,0", ns->params.nsid);
 
-    device_add_bootindex_property(obj, &ns->bootindex, "bootindex",
-                                  bootindex, DEVICE(obj));
+    sprintf(ns->bootindex_suffix, "/namespace@%" PRIu32 ",0", ns->params.nsid);
 
-    g_free(bootindex);
+    device_add_bootindex_property(obj, &ns->bootindex, "bootindex",
+                                  ns->bootindex_suffix, DEVICE(obj));
 }
 
 static const TypeInfo nvme_ns_info = {
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 8f8c78c850..d66f7dc82d 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -239,6 +239,7 @@ typedef struct NvmeNamespace {
     DeviceState  parent_obj;
     BlockConf    blkconf;
     int32_t      bootindex;
+    char         bootindex_suffix[24];
     int64_t      size;
     int64_t      moff;
     NvmeIdNs     id_ns;
-- 
2.47.3


