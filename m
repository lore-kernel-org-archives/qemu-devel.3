Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94ABC369A1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 18:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2E7Q-0004eC-J8; Tue, 08 Apr 2025 14:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E7P-0004dg-H4
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:56:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u2E7N-0004Gd-Gl
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 14:56:19 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so46493715e9.1
 for <qemu-devel@nongnu.org>; Tue, 08 Apr 2025 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744138574; x=1744743374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRz4nIs+qjkpvYNEjkdh+J25JpaBnAH+NnKK2uEtRmI=;
 b=YbIq8DIaV8q98oMZ8vSKVIsUwgTJZ8ODzlFxpsHK5aW3xCcUGULFMnMCRMP0TA4ebk
 6CtuA7cHLyHJdLoKD76zGdpmiXhwxeF3Noso0hrRor91pmcnI1PbAaZyl+COOh6Ns7KE
 ltikv1B1fDIIu1F4nGSLykl8PZ+q/7KkNyrlMI4j14yZmgec39eLNYutqUza254ndVOQ
 c9TPDvD6/Z7AkK4/wqqL/nlWVnwEkQ4NBvqs1F86gNM2dx0tCAi6xD5dWVgwkSLeN2Fj
 qDREarmk6CX2heGwFMR6ChEXuTVzDJjYq9qqIH3Bkn6Bj5pxLSfI6nEOFmCD0lbDmEj8
 n3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744138574; x=1744743374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRz4nIs+qjkpvYNEjkdh+J25JpaBnAH+NnKK2uEtRmI=;
 b=R1pYaf2L4DjVgpxT13yQ9+xSToPJ35AaVLgFzDcbhoOEpdFipfcyxJmuGFekz7mdao
 XoGVp+fsB9I3HZc+u48LzmNhTl+a96S/zls8G6SiGzjY8lbNb9nYhzopyi2POYdlrxSA
 zndkDKfh5KL6F/VHYrcTA76eWjWxToV2ZAF0PQvlebIgXsyXTSIBGUoCX+H950sy17Hy
 ugdD0jRANh4ieY6R0t6zqxqNgrUuGey83bxcKu1lQ2Jm2n+0/i5SzoM1K64bzhyhu08+
 RKXCAs5b9ozNgnk5rbBDh3nj21B2sM0Di/R0wLsAi2B6DD6t2SAiecLXq79SEsaaPKKO
 N6ew==
X-Gm-Message-State: AOJu0YxcKJHkOkPl4/W7OkIk7Lxq17RQNJq5QZBFaGooLCKjjhS8DKxn
 2nNFWRUBJiiqNaQG77kQiLucpEqLtq7bq2GxLFMnxkViNok+r9QUtg+wK2yuVZsXwPSIE21xjs+
 rrrw=
X-Gm-Gg: ASbGncuZ78c0vodtw8dOX340vB3Tzg17JeaF14dA+pMFi0G3k8ZxL+3A9bLdiJt0QlT
 8KgIPS+yg44GwbQfqV2gtFneuxCyfd7my/xksZjeyM3YEZYHpeh2E+St5nPAgEEc0pntDWnSebr
 Y7WNi/JeqC7XOhShJXrwI76CD9bVdG6u5jz8kfEaiGjENOttn9Qmj4Gv/ITzOLeKyUnG4/JuXCV
 +xh7JPfL3qlOCELXOc4EVEsq7XhQ2KGyzcRGxBNMdAKUaJPq6oFEX9Gaf9CJavfforQf0jUPrm9
 KRUrjvmg9Y6ieOr3+MufrsBRCS/sLQdILmKzRojMINXuFVznB5RVG7vt80YRV/fkYlegF3m6qsY
 nWDBAzmuHRX1ad/5j+IE=
X-Google-Smtp-Source: AGHT+IFSvHe4OX8T9lALjZ9BgdtFkGN7iF6CUv1IR86NalNHzPLQqWGGjL4awFhDoEBCXV3BTybK4w==
X-Received: by 2002:a5d:648e:0:b0:39c:30d8:3265 with SMTP id
 ffacd0b85a97d-39d87fa8d3bmr119162f8f.15.1744138573574; 
 Tue, 08 Apr 2025 11:56:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301ba17csm15834257f8f.58.2025.04.08.11.56.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 08 Apr 2025 11:56:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>,
 Alan Adamson <alan.adamson@oracle.com>, Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 7/8] hw/nvme: fix attachment of private namespaces
Date: Tue,  8 Apr 2025 20:55:37 +0200
Message-ID: <20250408185538.85538-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250408185538.85538-1-philmd@linaro.org>
References: <20250408185538.85538-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Klaus Jensen <k.jensen@samsung.com>

Fix regression when attaching private namespaces that gets attached to
the wrong controller.

Keep track of the original controller "owner" of private namespaces, and
only attach if this matches on controller enablement.

Fixes: 6ccca4b6bb9f ("hw/nvme: rework csi handling")
Reported-by: Alan Adamson <alan.adamson@oracle.com>
Suggested-by: Alan Adamson <alan.adamson@oracle.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Tested-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: Alan Adamson <alan.adamson@oracle.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Message-ID: <20250408-fix-private-ns-v1-1-28e169b6b60b@samsung.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvme/nvme.h   | 3 +++
 hw/nvme/ctrl.c   | 7 ++++++-
 hw/nvme/ns.c     | 4 ++++
 hw/nvme/subsys.c | 9 +--------
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 6f782ba1882..b5c9378ea4e 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -268,6 +268,9 @@ typedef struct NvmeNamespace {
     NvmeSubsystem *subsys;
     NvmeEnduranceGroup *endgrp;
 
+    /* NULL for shared namespaces; set to specific controller if private */
+    NvmeCtrl *ctrl;
+
     struct {
         uint32_t err_rec;
     } features;
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 518d02dc667..d6b77d4fbc9 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7755,7 +7755,11 @@ static int nvme_start_ctrl(NvmeCtrl *n)
     for (int i = 1; i <= NVME_MAX_NAMESPACES; i++) {
         NvmeNamespace *ns = nvme_subsys_ns(n->subsys, i);
 
-        if (ns && nvme_csi_supported(n, ns->csi) && !ns->params.detached) {
+        if (!ns || (!ns->params.shared && ns->ctrl != n)) {
+            continue;
+        }
+
+        if (nvme_csi_supported(n, ns->csi) && !ns->params.detached) {
             if (!ns->attached || ns->params.shared) {
                 nvme_attach_ns(n, ns);
             }
@@ -8988,6 +8992,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     if (n->namespace.blkconf.blk) {
         ns = &n->namespace;
         ns->params.nsid = 1;
+        ns->ctrl = n;
 
         if (nvme_ns_setup(ns, errp)) {
             return;
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 98c1e75a5d2..4ab8ba74f51 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -763,6 +763,10 @@ static void nvme_ns_realize(DeviceState *dev, Error **errp)
 
     ns->id_ns.endgid = cpu_to_le16(0x1);
     ns->id_ns_ind.endgrpid = cpu_to_le16(0x1);
+
+    if (!ns->params.shared) {
+        ns->ctrl = n;
+    }
 }
 
 static const Property nvme_ns_props[] = {
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 2ae56f12a59..b617ac3892a 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -56,7 +56,7 @@ int nvme_subsys_register_ctrl(NvmeCtrl *n, Error **errp)
 {
     NvmeSubsystem *subsys = n->subsys;
     NvmeSecCtrlEntry *sctrl = nvme_sctrl(n);
-    int cntlid, nsid, num_rsvd, num_vfs = n->params.sriov_max_vfs;
+    int cntlid, num_rsvd, num_vfs = n->params.sriov_max_vfs;
 
     if (pci_is_vf(&n->parent_obj)) {
         cntlid = le16_to_cpu(sctrl->scid);
@@ -92,13 +92,6 @@ int nvme_subsys_register_ctrl(NvmeCtrl *n, Error **errp)
 
     subsys->ctrls[cntlid] = n;
 
-    for (nsid = 1; nsid < ARRAY_SIZE(subsys->namespaces); nsid++) {
-        NvmeNamespace *ns = subsys->namespaces[nsid];
-        if (ns && ns->params.shared && !ns->params.detached) {
-            nvme_attach_ns(n, ns);
-        }
-    }
-
     return cntlid;
 }
 
-- 
2.47.1


