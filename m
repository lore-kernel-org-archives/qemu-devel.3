Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DACC53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp1cy-0001ar-Nt; Wed, 29 Jul 2026 06:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1wp1cw-0001Zy-CA
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:35:06 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1wp1cu-0000Po-FH
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 06:35:06 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-8485ab7c382so101282b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 03:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785321302; x=1785926102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0UlXNjlJE2bemSLWoFgXckIUgJsEEPT13u89DMLpn18=;
 b=YjglIR+rZJrUtpXgpAvjrWpAmA3z+sl/FkMIAYR8nO5542Gmn8oNAQrWUccLUQXCfh
 Ho5muyANzqstSFqF/7jJRj6+UMncZ86a6aGbNH+HTRbA61439w2iVwyzGGTRdP8IPmio
 qaYxVu7o/QME7SgWB3fTPaTkARwmJg0DiYyfv2MNm3P66ENnydvklcyBbGmeXrw1vHAU
 ++s6MYzEV3yk9qBtK2ODoHo4vzwP/ZxotEDliAz02zujqEnKggkCg5A3YXYOmKaFhKRk
 WRyCVGhprnfEgtuIewi8hYm9tLpbabTuHFnhIDRvKO+zFAaA4CMktfphYpm13hPQ8CuT
 wHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785321302; x=1785926102;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0UlXNjlJE2bemSLWoFgXckIUgJsEEPT13u89DMLpn18=;
 b=NRlDvAC9ISO6L3NnLj5ZmxmkxrS+P7/ZjiEF6RnAQim6MGNyn/xRs0udvrriKAcrtL
 ncKzk/tgRWMEpf5fY3uVmUhGDhh9HflXXSNg+o8UDoovLt1D4SQLd8vr+X3PcO9mOSEF
 XiiVZ4bJKgRgNM9LdXxVv2opICqdSbn71Z8IAwYlZML4Sh+2Tb+3DsmkgF+eajJ78b5n
 00cMydTqEWY9CJQ0waiSZNgj9AzmH7B54B3IjgTpUSz3vC31C9G3GUwwA/uCygKVJoOV
 N3upBALGqBZ6f0pnQAj/c1vullFZkhbgL4Zhc7Cx+ltc/8QUJWrCu9JLMZkjPJ1LRcAH
 2VNw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+hxIZDUidexhfap0bJNj+Os3Nsjs4hp3OtPLzG3IEiYzWVLBAujfrBCTQOpEQgbXRR5Y1Py3y05ag@nongnu.org
X-Gm-Message-State: AOJu0Yy+t9Q8Ut3cyDXdBByc5N/HvQAAZLKlEzCLIooNV8Iocm8kbMp9
 Lq1BHoUVZMKjLQGzLpOnuKZX0O0xmTHsS7P3c+0k1Ifwox1gmPfHD3PL
X-Gm-Gg: AR+sD102Y6jDdjsTnRMNCKDtG40wT7xUdAfmyNXEN7sEP0DFHWjPVyMzncggbemEai9
 Ya+0SiM/S9IZ+t8vgfyZtBDriupi3eRQSs1SH9mjb1/xba7HCNp+UNtZbHKPDgDyLaV53qgqcQI
 l4b/8n+so9OZLywZFhGf12k55iF02vn8oqZXdq0CkS29+qkYbnfhLAnX4BNy8IV7jRSBJn1ZU5Y
 aJYt8pUoY9ZzgHtYTkyT/Lc1oBRyvEqiRNpytyj3wNQUDqXKZ18h6U0RpxWhCjwW9843NLcG6VY
 mjAw3lppvBCO7IVJonuPsLsTWiecEFTIb+1y8z4V4Yt4MFoNsUGaOZNdbGFCmuI2Ntyi+HIgAwo
 cCJDLmFknVUUGoP/JOO0JUczpMqrLXMpyLteFxHMARXBupixeENNd6D+5rPlIeXKts+R9Rj+Pqn
 84MXQRiF/n0DPU3szIxmzGh02rL7+YPJoHVQL/M7K/Qbffqu3bfUEsKKpiiQ==
X-Received: by 2002:a17:90b:2f8d:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-38f6a257aa7mr5541321a91.1.1785321302476; 
 Wed, 29 Jul 2026 03:35:02 -0700 (PDT)
Received: from localhost ([61.98.20.55]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f12ddcesm1171801a91.7.2026.07.29.03.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 03:35:02 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
X-Google-Original-From: Minwoo Im <minwoo.im@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH 1/3] hw/nvme: drop AER requests without aiocb in nvme_del_sq()
Date: Wed, 29 Jul 2026 19:34:52 +0900
Message-Id: <20260729103454.26947-1-minwoo.im@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

nvme_del_sq() asserted r->aiocb was always set when canceling a
queue's inflight requests. A pending Async Event Request has no
aiocb (nvme_aer() parks it without issuing any block I/O), so
deleting a queue with an outstanding AER trips the assert instead of
just dropping the request.

Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
---
 hw/nvme/ctrl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a67e1598891c..e715de8247d1 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4858,12 +4858,14 @@ static uint16_t nvme_del_sq(NvmeCtrl *n, NvmeRequest *req)
     sq = n->sq[qid];
     while (!QTAILQ_EMPTY(&sq->out_req_list)) {
         r = QTAILQ_FIRST(&sq->out_req_list);
-        assert(r->aiocb);
         r->status = NVME_CMD_ABORT_SQ_DEL;
-        blk_aio_cancel(r->aiocb);
-    }
 
-    assert(QTAILQ_EMPTY(&sq->out_req_list));
+        if (r->aiocb) {
+            blk_aio_cancel(r->aiocb);
+        } else {
+            QTAILQ_REMOVE(&sq->out_req_list, r, entry);
+        }
+    }
 
     if (!nvme_check_cqid(n, sq->cqid)) {
         cq = n->cq[sq->cqid];
-- 
2.34.1


