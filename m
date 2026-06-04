Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B95ECD6E74
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 10:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV5Mj-00074P-52; Thu, 04 Jun 2026 06:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wV5Mf-0006tn-Ak
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:31:53 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wV5Md-0001mG-Cj
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 06:31:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45ef616daf6so517836f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 03:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1780569109; x=1781173909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mOZX98Bpq7qkTpATuY0W3VavSaB0r+4FZ5Ng89RLv8=;
 b=bvskS59Vpq8zuJaNJbZHk4jvjH0Pcwv6LMPEWbRdgXjfkNEctbZ5gRZJLdkvO1/P/+
 e6rVHwg8TH5qbGP9BSTdrL0Cd0qcvkZ59hCPxzb2EpclQOXEE4L3kT102/K/4dGLnOa3
 qjakW6m5zdAIen4poa/JE30OK+LEyd7iriouQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780569109; x=1781173909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8mOZX98Bpq7qkTpATuY0W3VavSaB0r+4FZ5Ng89RLv8=;
 b=eIhOwbvq2fNG+n/QiSi1TQ42za25sFfJVJO6jPO/GQ59DVKoyL68g1ScacxdqDTZ5X
 +ENF4CUJfo1FfNa/KRu530cPlybXLRaCeGxaXcHhEp+Hpw6Kva1hUACs/DXAh30Iwsr3
 NiNVRCKwBzzpMhla7WvT3ikD+eGfD0vUZ4RMthqdBF/PVYxNkjPOLkioMcGaRre671oQ
 w0QdkGTlDxAN+Vx/kjxFsS0gzi9rOr0CRMlSxYQJkSO+1UF4xtC3K/mQ7mh+pgRd5UZz
 BuaK9SQyEA3ALvwIhPv4uNnTDAIUaCcviiFd3TZcEEiF217ehlRhjg8MfaKjiXwhv1c3
 /Q7A==
X-Gm-Message-State: AOJu0YyBriXnBUUkYX+J6F/nmHUv0eLMb4eK//MF/i/DA39Q/uN9nvUG
 gBFKnwwQJf0p1c266zOQMZ97k2UACDo9Rk85Idx5pkLOn2yT0vjZg8929YTNnSOxLqUcaCRcBfd
 t5xLU
X-Gm-Gg: Acq92OH4lMiB9M+ekLS33wBXlCCXK96daivK8skZuImZE3Zm5KlBsCRHh3PVARR0kp6
 vockL+AgqdjvNs0nk+Nw1lOsh8qZKgemQ3vgzwLvV9iCEX3UQTo0ZRGtpovkzcYR0rWk7Dr1vAs
 0nDrdtL1Uy9A3P/r38fSX3lObpxzGB4Nb7OM6BWd7DaL61ps+bNlVrUNFFKZexGa6NrU4DN0JtW
 wyNqL5H0mBjWCv37nuL5Xkeelsqcd7tl0X5VqBw0vauf6dLLqGBAfZZ8AU/4Iqansxy4nPgOCwg
 b6TH8G7YAY9wUAd5ubi4MpwfdfkCLrr+Oz3sFFUbjd+YEMjPJfpY/9DfMMHib0AUJKHDaIq1veM
 9ht2+l4aYUgFmmt2yolUTfZG1Vh27ep24H/Ry2X7CkAXWpONBAZE+/TG0k3sogl1dEA9bai9sTC
 WLWk2iLSGlVUDW9Xo5FfXmo4Qe/x2bUAhBSDHWqxP9h5lW6mNWMJUXvuCDfUM4mf0zuLyR8zZ9c
 0RXNtI+HGc3gA==
X-Received: by 2002:a5d:5747:0:b0:43d:7c6c:a0dd with SMTP id
 ffacd0b85a97d-4602186d090mr8239365f8f.35.1780569108858; 
 Thu, 04 Jun 2026 03:31:48 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c0000000000000009a8.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00::9a8]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcae2sm15928661f8f.6.2026.06.04.03.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 03:31:48 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-block@nongnu.org,
 Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH 2/2] hw/nvme: support online resize
Date: Thu,  4 Jun 2026 12:31:43 +0200
Message-ID: <20260604103143.462071-3-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604103143.462071-1-alexander@mihalicyn.com>
References: <20260604103143.462071-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/nvme/ctrl.c |  9 +++++++
 hw/nvme/ns.c   | 65 +++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h |  2 ++
 3 files changed, 75 insertions(+), 1 deletion(-)

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
index b0106eaa5c8..ee05b4f3ddf 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -162,6 +162,67 @@ lbaf_found:
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
+    if (!ns->attached)
+        return;
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
+        if (notified_ctrls == ns->attached)
+            break;
+
+        ctrl = nvme_subsys_ctrl(ns->subsys, cntlid);
+        if (!ctrl) {
+            continue;
+        }
+
+        for (uint32_t nsid = 1; nsid <= NVME_MAX_NAMESPACES; nsid++) {
+            NvmeNamespace *ns_iter = ctrl->namespaces[nsid];
+
+            if (!ns_iter || ns_iter != ns)
+                continue;
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
@@ -171,10 +232,12 @@ static int nvme_ns_init_blk(NvmeNamespace *ns, Error **errp)
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


