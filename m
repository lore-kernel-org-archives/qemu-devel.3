Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62094CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSJ5-00065J-DU; Mon, 11 May 2026 11:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wMSIM-0005pF-FG
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:11:46 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wMSIK-0001qT-Ol
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:11:46 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-444826c16ffso3909793f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1778512303; x=1779117103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXtR0f8lswzrNk5sn13Mr7WVfwlNVtnqZBag2y/b9bI=;
 b=XQoaQtpg80PdIAiSa7NTxkmZJYo6oXZfNBbs3lL30/AglU/6wQmj9WPVt21hZ9ntWM
 orAZQ8Xdnm4/hrs7XP7zhjkqehthZPhESUeOWysxwRhmP2bCXBPoxqC7jumDesUPhHcO
 a3tC2igGvJob8/Rma6PnMm8/jb6Dq7AenvOSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778512303; x=1779117103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CXtR0f8lswzrNk5sn13Mr7WVfwlNVtnqZBag2y/b9bI=;
 b=H3KJwBbJyKk1l4fIZxoFyFAeYhCANweq1lofDAv/A+r8RBDd5hIyGmuGqCNr3LZNZ3
 2IjZKL+cETHbOndv8tY4xVBc1wev3NsD/uHBWUlOsRZs3jDB+03b0wyEqZwifm0iJQuf
 TE9/sbhQ2tYrJVoWh/oDqiVoJMHKykcIMbxOpuHaWX7MPEsRZDBOQgoWNPlhjpjgXfOt
 Tyyjc+8P/Tg5pR1akT3a6Va2NmSHtzWAO11U+nl+FLiDoOBsKey0Xi6LpjReC6wMMbu6
 NsFnTokZ6hdC8JZRI8qnl3BiVG5De4uzGrfHXGw8J1uFqJNREFAOSVJz1DnUgVxW+WP7
 Hygg==
X-Gm-Message-State: AOJu0YygWbADoXXwpvaNkoaXMkMSDHGExHFqVm4ybsUKtrSmc21RyVhe
 hR9BFFYOx0d5K0k1RY1OJLhWqrXUT2hJuryLT/Jo5O6rmLpnzZFf1GF6Wyfma4mzvFH51FDEhAy
 MLbPJdag=
X-Gm-Gg: Acq92OG5Wui9doHBGEd5vIlGIfblOmhpLGmk5WElcZPxu85LVk1TJdx/wunN58RtvPE
 iwx30N/B7GsXWy7jFN8eTnY0dlKfvevUqga1HaTODBDGhryzte3PpSYOCAKkxLFO8ABD2dUgEBG
 UDi4tdrDI8oC/496mmB2bvijFbZHUmxsCCpmoHbuNfStVGK6a38uB6v62fg+/11Rdt9Y25p/Fs/
 sTrUoyyw3cT1dWpQUAgcmyOr6RHPbK2HQvbaikZb/3iUptpbtvkolr8wy5AxgDlbuQvlNpFKUgC
 LuaTqMVuEHyNLmCzCvp7ndyG173839s42WCyyWVkBEr52tup46247gLaRQnj91lEh8oEituaVgR
 uYP3UHi6vFZSKoI6f3zlWiQ3OM19TrEcUcWzWTUfWUtfUHiXL/g3aaQYuAD3uGgdqXxov4Btwm+
 E6j+JGqtz2O4VYv1xRLVHtsXsjp3BbwSqSG115fs3uZrGIb9lhFZirJEGnbERbWUtYPh52aRXAu
 DD65yFAqus6JZJUfl5WqolG0+FDSnY=
X-Received: by 2002:a05:600c:8908:b0:48a:7a10:4f17 with SMTP id
 5b1f17b1804b1-48e51f21e0cmr271209205e9.6.1778512298557; 
 Mon, 11 May 2026 08:11:38 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00267b069c8b2d0c7b.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:267b:69c:8b2d:c7b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6d8d6813sm65766925e9.6.2026.05.11.08.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 08:11:37 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Klaus Jensen <its@irrelevant.dk>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v7 4/8] hw/nvme: set CQE.sq_id earlier in nvme_process_sq
Date: Mon, 11 May 2026 17:11:27 +0200
Message-ID: <20260511151131.483217-5-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260511151131.483217-1-alexander@mihalicyn.com>
References: <20260511151131.483217-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42d.google.com
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

Instead of filling req->cqe.sq_id in nvme_post_cqes, let's set it earlier
in nvme_process_sq.

This shouldn't cause any issues, because req->cqe.sq_id never changes
during lifetime of req.

This will help us for migration support.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e79ef536ef8..ffee7ef224c 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1520,7 +1520,6 @@ static void nvme_post_cqes(void *opaque)
 
         sq = req->sq;
         req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
-        req->cqe.sq_id = cpu_to_le16(sq->sqid);
         req->cqe.sq_head = cpu_to_le16(sq->head);
         addr = cq->dma_addr + (cq->tail << NVME_CQES);
         ret = pci_dma_write(PCI_DEVICE(n), addr, (void *)&req->cqe,
@@ -7850,6 +7849,7 @@ static void nvme_process_sq(void *opaque)
         QTAILQ_REMOVE(&sq->req_list, req, entry);
         QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
         nvme_req_clear(req);
+        req->cqe.sq_id = cpu_to_le16(sq->sqid);
         req->cqe.cid = cmd.cid;
         memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
 
-- 
2.47.3


