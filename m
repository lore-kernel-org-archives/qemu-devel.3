Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FB1C55190
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:31:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqo4W-0007xj-Df; Mon, 03 Aug 2026 04:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqo4U-0007wS-Q5
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:30:54 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqo4S-0005sP-5S
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:30:54 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-495437bb891so14299695e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 01:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1785745851; x=1786350651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JzG4apXpiNocLsXpog0bsCdeoy9IhVdLqM3yABb24X8=;
 b=HdwNkx7JW5cfC5sXOxbzRnPyl7shYpxYjj7AUrSZmJP3aUCvFZNqfFJ4mCSEWbQMPt
 sixkIZGRtCPsJDQbkfQfMjLc2l35MMAtLfPcrROXYvKazrhN92RZ7LrhCVrtfaWhY89C
 w7AUpLKwXQ+662PQmO50PlZ8N/P1EOdGy/RGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785745851; x=1786350651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JzG4apXpiNocLsXpog0bsCdeoy9IhVdLqM3yABb24X8=;
 b=C3GNfgJccvLalo5ssWh6N6Boh2igzqUsif27dRK2HXFL7sdEQrS0gu0d+MXLbLwhcb
 p3hzfWYwitRrCVP1YYdX9KEbhMWRJEXkYgZ0sE3B8Pu8liNaeoUv6wgipXrG3bk5rESh
 34bFrv9h4140UhvtCcKKHZymlWps1BduC5c6Ks1gTFaa1ckkOCMOJFF5EIM63+8/k9u9
 p4nHFuJvpCapk9XbAIJVxoFAhH18vXR+0S/yoHup1ePpiaC/etrFg/lSXnccFStOcM9m
 SQ9yojvq6n10SpIbxtg5pIn5WLKtdyMlT9fGYL4bBPN7X+XcUf6Q52T7WCjj9tqk5uMa
 LnOA==
X-Gm-Message-State: AOJu0YzTT9ySs2p/rwkIovFPxLNtepuPgvgBhutlSFMsKBZQhRBzkWp1
 jUMWH/o1gTxefTHCq4g0PX1wl89+1XhdczTIJzXZt7m7FmDTjzwtWumhn/CKkO0bd/rrlju3Qwc
 BH6cX
X-Gm-Gg: AR+sD13LU6b/82qVITjmnAPv8gs6qGKonJzWbF9UwFnbbPqX//aLlrg2CRdSWpb2xXi
 Ed3EpGbZpgNFnZy+NS8hY5xX7l/VwnEIc+i9H4HTaX7N1q48VsnwLNw25hyQpebNxnub2cYdb6H
 9kCe9fP41W1SS0pM3DNkdqJwposAUczjLZz4m0lrQGNATbaRKNfMmtBeDDyji7DS0Wu1fKVYJRL
 +s9ABPdE4haT0eWVhKVNMKsnwUfO+h/Ec7N0Nxa0Ks1eFvkJj3yZhO1cpV/YfblrQpEUhUo6J8d
 CwyLyTj0xj6bapkGbXJh+eS7lWg+jUxFlx3yXMC5bGYlZz4BR1e0eDtkGHjpVtNnidsYqOjPSrj
 0h3tUdevMldL9WHMMz+kwl45lBWmqrRDAG2ouaiYvif+djmbbq/dKrfrIbDm0fVeHSiStj31XoU
 lrzOTiOiQUtQU5QomJr+lkOt7AEv0L5UWWpixgLZrqyrvR8K4x6JSIP32rpS2hVa3hsfHfMI3Zb
 bacKiqzRQ9vxa1DS5zLaenodWWQlmhoC4uLyUbCRMLmU6mJGOAfPtAD9SPOJA==
X-Received: by 2002:a05:600c:3506:b0:495:3bc6:d381 with SMTP id
 5b1f17b1804b1-4980eb8e287mr133749885e9.2.1785745850629; 
 Mon, 03 Aug 2026 01:30:50 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200803110ea947f174a.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:8031:10ea:947f:174a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807bb45ebsm152286045e9.4.2026.08.03.01.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 01:30:50 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v3 2/2] hw/nvme: support online resize
Date: Mon,  3 Aug 2026 10:30:46 +0200
Message-ID: <20260803083046.110121-3-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260803083046.110121-1-alexander@mihalicyn.com>
References: <20260803083046.110121-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x329.google.com
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
v3:
    - rebased
v2:
    - check-patch fixes
---
 hw/nvme/ctrl.c |  9 +++++++
 hw/nvme/ns.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h |  2 ++
 3 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 710c3e0d77d..d60b3e105a1 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7009,6 +7009,15 @@ static uint16_t nvme_ns_attachment(NvmeCtrl *n, NvmeRequest *req)
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
index 7f0f9ac7662..e2954fd91b3 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -163,6 +163,70 @@ lbaf_found:
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
@@ -172,10 +236,12 @@ static int nvme_ns_init_blk(NvmeNamespace *ns, Error **errp)
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
index 43e3c916f73..a4b2c01a2cc 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -764,6 +764,8 @@ void nvme_atomic_configure_max_write_size(bool dn, uint16_t awun,
 void nvme_ns_atomic_configure_boundary(bool dn, uint16_t nabsn,
                                        uint16_t nabspf, NvmeAtomic *atomic);
 
+void nvme_ctrl_notify_ns_resize(NvmeCtrl *ctrl, NvmeNamespace *ns);
+
 extern const VMStateDescription nvme_vmstate_atomic;
 extern const VMStateDescription nvme_vmstate_ns;
 
-- 
2.47.3


