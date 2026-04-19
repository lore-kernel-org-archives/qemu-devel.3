Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC752EA719B
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 13:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wERn9-00013O-Lg; Sun, 19 Apr 2026 09:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wERmk-0000u7-Gy
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 09:02:05 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wERme-0008J5-N0
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 09:01:59 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d77f60944so1657388f8f.3
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 06:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1776603707; x=1777208507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BN9Hs6B25FCaLyK+WKS27HHbG03I3Ib65GOh38oVQqU=;
 b=OusyDXJBoFiBTbKFb9EDNMBGTwnzREwHNbsCY7sNJYHoCMHFBgsi2XUCKUKgN1cqb1
 eW5dXB8+nCFoqryoSX1UvX+mW63WjOxZvv26a06/ESX+w+N4+BXsyVM9EnQTNrIK4o9E
 ZGEbRUjVOJ1oy+V/UWUl/wOJpOgajRwPajUvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776603707; x=1777208507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BN9Hs6B25FCaLyK+WKS27HHbG03I3Ib65GOh38oVQqU=;
 b=X1KSknt9XdRA0QS8h2X4zHLcf8DqPdJf7Q28r/0ZrjIYhU/YPHo+C0T2XB9FJrBcFE
 No1bjYNqSbmGftvACh1cpMQuCwdPLqE1kjPkrn38ACwl2aUVR6LYhrmGH8Vw9fNYLlS+
 Y2j9PQ7S8mph0vdHvoX4lkxyKxkT6wNCKzI+qIC05Z2PEvJHqqPl5L1twho3vlnk75DU
 o4qK2NPFc1lArPwJhK+eN2VSos9LS7IDyzuUu0388dHgCqD4ucpWzX9wWwiGDDed5kMU
 P1LvKtb4KHLHsRgqRSowKkutFeGQr1ZoKbIcDraRgE+x0xhFvSaJ6ueKV5H4x0Ouo1VE
 H8Qg==
X-Gm-Message-State: AOJu0YyHUEBEZQwaXeNv6+3Z8JSYc6Vgtn+CG/InGzm+/e/TUpmDn/GB
 SXcunQG260OuYr7oWsoZPEk8DESMTHMPhotDwwKLDBjV3Mdj1nX4I+vGgpuMT0qeFTj/eclPP5h
 CU8WBoaY=
X-Gm-Gg: AeBDievPzUVkbHzHuAjD7dMi6ahROIYkH+7yh7k5TjsXOJ33DIwq1DLA02G3OEnW8d7
 52Y1tZnwNEcZvNym9yh2G1zu1iXvGssp5GN7h4srMVRa5NrWyXWn+eskdEpX0ToB+DGr/3cVUKQ
 rBmTGzbNLkEsfocJ13zgLcnUr7QUxwrG3omcwHJ7RtEzLPtK25TNTllQ+FlkF+wiWSlklnCEHXp
 r7wdMADYuJX00hoMp3A9DuAzrAVYKQbkCzmShkGLZdU6zGfLyblPqwLEcr63840WwJCyaYd0nFL
 YGjv4Jp/5SDwhJ3ALTyAW+CXE1ORBfTIHWv/hsj3LnQrdkjZ5VYd8O+jtDWdBqQ7gZcQBJ+FaiO
 hgB7fP4t0lh2YPzNXidBY5vNHyUdoUKJFwp9joBPsvEZJqCPyzTV3NASJhnrUDGqUrCPYdzCrq2
 B3iDIAb8bVapOQS386fql8gu4MIzxlgZFKvkNHpch2W1zsPlPik0OA/s3eo7AnK3wegwsPjarJe
 OfwtyaX/G07rNVi1HtkLNmCG24x6xwJnJJNa/mFnZTs
X-Received: by 2002:a05:6000:2511:b0:43d:76d8:5798 with SMTP id
 ffacd0b85a97d-43fe3e0db09mr14977430f8f.27.1776603706568; 
 Sun, 19 Apr 2026 06:01:46 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00995e4e0d3496e07b.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:995e:4e0d:3496:e07b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc2cacsm20734304f8f.13.2026.04.19.06.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 06:01:46 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <its@irrelevant.dk>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Keith Busch <kbusch@kernel.org>,
 Peter Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v6 4/8] hw/nvme: set CQE.sq_id earlier in nvme_process_sq
Date: Sun, 19 Apr 2026 15:01:35 +0200
Message-ID: <20260419130139.15554-5-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260419130139.15554-1-alexander@mihalicyn.com>
References: <20260419130139.15554-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x435.google.com
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

Instead of filling req->cqe.sq_id in nvme_post_cqes, let's set it earlier
in nvme_process_sq.

This shouldn't cause any issues, because req->cqe.sq_id never changes
during lifetime of req.

This will help us for migration support.

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 191398e700f..d9bf32bff2c 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1520,7 +1520,6 @@ static void nvme_post_cqes(void *opaque)
 
         sq = req->sq;
         req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
-        req->cqe.sq_id = cpu_to_le16(sq->sqid);
         req->cqe.sq_head = cpu_to_le16(sq->head);
         addr = cq->dma_addr + (cq->tail << NVME_CQES);
         ret = pci_dma_write(PCI_DEVICE(n), addr, (void *)&req->cqe,
@@ -7848,6 +7847,7 @@ static void nvme_process_sq(void *opaque)
         QTAILQ_REMOVE(&sq->req_list, req, entry);
         QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
         nvme_req_clear(req);
+        req->cqe.sq_id = cpu_to_le16(sq->sqid);
         req->cqe.cid = cmd.cid;
         memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
 
-- 
2.47.3


