Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1380BCD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ83F-0008TF-3E; Mon, 15 Jun 2026 10:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wZ835-0008Qf-Tz
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:12:24 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wZ833-0005Fj-Sm
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:12:23 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4921e4dd62dso18721905e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 07:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781532740; x=1782137540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uo0uYCVEevWy1HQgBtgrdJB7a8Pps0WzO7ud5lijTbw=;
 b=L4uHaBe5MP/yVJP12vG/3/Kaquwe90v5P+4XpSHNqkJNpSbGZvEnJHdqh8tuAheQQX
 5TKE6BXyJSZVE4VUrA9eI16EQ6rP8io7lkLlAQKHmBfZfTmPfvhbIYQ8dNk4dy3Xb5rn
 Z3YI8dqqmUo39x620jppgKCokaCg4d0DxvlUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781532740; x=1782137540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uo0uYCVEevWy1HQgBtgrdJB7a8Pps0WzO7ud5lijTbw=;
 b=mt1vJMfmpSzXP2svfckjmPeasSCKHAXaNyoieS0X38dE0SVEI1nT2DA9TK+FUn+OXo
 9nOO1VicjQZZcGuEytc6IW5Iof7Wgme9b+K06MJH+hktIi0jmrgjqXJPSmRjNywzYt4x
 9T0ZKRuTY9GNPBAuTXI21LAcgbMpBej1hO5JrCtzyEuc67DKHuVulc23g7EHT19HI8d1
 8oVLkF601+qbelQvVl5aSW2mq0pGW3WySw5813w/wxAI/N5bA0F9sXwrRRx7oZDLhezh
 lBVTnwxPHBfG7xKtdViVOHvlekWCNwFI7ji4bj9ZknYG7UIDDxHyFDlHMlWIosr63RiX
 GSTg==
X-Gm-Message-State: AOJu0Yy7XJ9Qisu6GhdEypfL4ZstlFRTQ+0Y24Qh2KakgGIHSaOHXhie
 wEPxiBvuorl0FzIz+CnYDDK1vhwcRtpFX9xiH4JRCQDcqt4bPirDj3XMeu64bz0W6gYdiNVYl9o
 EsGxPnDA=
X-Gm-Gg: Acq92OHZRBIuok87qafA+4Ek4cV0scA6YIVS0UzIaIL1dyvtcncsOUrzbBRysSVEPkJ
 ilABjvNJNqrc8LnBQ7tPt6+yTDSpITqVIsjKxbfDrkXZ+XGZjWcsGuE30KAil+HCsutFVED1Kmi
 /gsyAM2jWZ13wJlkACnPUM6/l7/nIPpgVabuesQyttsv7ElsAeKPXmLuhgfJ7Nfg9MIQGVW8adt
 0b5FeiIOZzgDUZGKCWpgM1hQZITuk0V9mqe002BcdCNFVCBkvchM+ze38ti6ZJsTTlKxlQZRlti
 ro1aJjSb0Q4pVD4wRhMe3PeYF73SXdwyCVsxaPRmYJXvFeZU+HpfEYZMEXwjAgd9xibHTvSSstn
 Zzt8v5qRgCz0r30P+Gw8JT3na08U3/tqpbrtgVTwSOaztplNTrAlKKp8LudiZDmmsaV6UOXhMR6
 lySVpvfalzJ6gRjQ+uz/EQJaRI6K1V3dGt6YnEi5SHYkPM+2quUWWIVKl2yZz9sBbuD8A87DIr7
 H0=
X-Received: by 2002:a05:600d:6451:20b0:490:e180:2e0 with SMTP id
 5b1f17b1804b1-490ec481088mr113019415e9.3.1781532740133; 
 Mon, 15 Jun 2026 07:12:20 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720000000000000009a8.dip0.t-ipconnect.de.
 [2003:cf:574a:7200::9a8]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4b39e9sm213758215e9.0.2026.06.15.07.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 07:12:19 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Jesper Devantier <foss@defmacro.it>, Keith Busch <kbusch@kernel.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v2 2/2] hw/nvme: support online resize
Date: Mon, 15 Jun 2026 16:12:16 +0200
Message-ID: <20260615141216.162388-3-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260615141216.162388-1-alexander@mihalicyn.com>
References: <20260615141216.162388-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Implement (BlockDevOps *)->resize_cb() for NVMe namespace to enable
online resize support.

We must handle cases when multiple namespaces are attached to
a single controller, or namespace is shared across a few
different controllers by iterating over controllers attached to
a NvmeSubsystem and properly notify every controller about a size change.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
v2:
    - check-patch fixes
---
 hw/nvme/ctrl.c |  9 +++++++
 hw/nvme/ns.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h |  2 ++
 3 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 391f8260fc2..d329276e127 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6898,6 +6898,15 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
+void nvme_ctrl_notify_ns_resize(NvmeCtrl *ctrl, NvmeNamespace *ns)
+{
+    if (!test_and_set_bit(ns->params.nsid, ctrl->changed_nsids)) {
+        nvme_enqueue_event(ctrl, NVME_AER_TYPE_NOTICE,
+                           NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,
+                           NVME_LOG_CHANGED_NSLIST);
+    }
+}
+
 typedef struct NvmeFormatAIOCB {
     BlockAIOCB common;
     BlockAIOCB *aiocb;
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index b0106eaa5c8..6814fd74898 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -162,6 +162,70 @@ lbaf_found:
     return 0;
 }
 
+static void nvme_ns_resize_cb(void *opaque)
+{
+    NvmeNamespace *ns = opaque;
+    int64_t size;
+    int cntlid, notified_ctrls;
+
+    size = blk_getlength(ns->blkconf.blk);
+    if (size < 0) {
+        error_report("can't get size of block device %s: %s",
+                     blk_name(ns->blkconf.blk), strerror(-size));
+        return;
+    }
+
+    ns->size = size;
+    nvme_ns_init_format(ns);
+
+    if (!ns->attached) {
+        return;
+    }
+
+    /*
+     * Okay, the namespace is attached so we need to notify all controllers
+     * about size change.
+     *
+     * Let's just take ns->subsys, iterate over all controllers and find
+     * to which of them our namespace is attached.
+     */
+
+    assert(ns->subsys);
+    assert(ns->subsys->ctrls);
+
+    notified_ctrls = 0;
+    for (cntlid = 0; cntlid < ARRAY_SIZE(ns->subsys->ctrls); cntlid++) {
+        NvmeCtrl *ctrl;
+
+        /* notified everyone? */
+        if (notified_ctrls == ns->attached) {
+            break;
+        }
+
+        ctrl = nvme_subsys_ctrl(ns->subsys, cntlid);
+        if (!ctrl) {
+            continue;
+        }
+
+        for (uint32_t nsid = 1; nsid <= NVME_MAX_NAMESPACES; nsid++) {
+            NvmeNamespace *ns_iter = ctrl->namespaces[nsid];
+
+            if (!ns_iter || ns_iter != ns) {
+                continue;
+            }
+
+            nvme_ctrl_notify_ns_resize(ctrl, ns);
+
+            notified_ctrls++;
+            break;
+        }
+    }
+}
+
+static const BlockDevOps nvme_ns_block_ops = {
+    .resize_cb     = nvme_ns_resize_cb,
+};
+
 static int nvme_ns_init_blk(NvmeNamespace *ns, Error **errp)
 {
     bool read_only;
@@ -171,10 +235,12 @@ static int nvme_ns_init_blk(NvmeNamespace *ns, Error **errp)
     }
 
     read_only = !blk_supports_write_perm(ns->blkconf.blk);
-    if (!blkconf_apply_backend_options(&ns->blkconf, read_only, false, errp)) {
+    if (!blkconf_apply_backend_options(&ns->blkconf, read_only, true, errp)) {
         return -1;
     }
 
+    blk_set_dev_ops(ns->blkconf.blk, &nvme_ns_block_ops, ns);
+
     if (ns->blkconf.discard_granularity == -1) {
         ns->blkconf.discard_granularity =
             MAX(ns->blkconf.logical_block_size, MIN_DISCARD_GRANULARITY);
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 5ef3ebee29e..ac94cc72c0f 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -748,4 +748,6 @@ void nvme_atomic_configure_max_write_size(bool dn, uint16_t awun,
 void nvme_ns_atomic_configure_boundary(bool dn, uint16_t nabsn,
                                        uint16_t nabspf, NvmeAtomic *atomic);
 
+void nvme_ctrl_notify_ns_resize(NvmeCtrl *ctrl, NvmeNamespace *ns);
+
 #endif /* HW_NVME_NVME_H */
-- 
2.47.3


