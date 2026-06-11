Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188CFCD98CF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjpn-000727-AX; Thu, 11 Jun 2026 14:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXjpl-000703-39
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:08:53 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXjph-0002H1-TZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:08:52 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-490c1915793so872095e9.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781201328; x=1781806128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PEkWfPanh7q59TrWlqY0t/+OQLGLErZaOJuxqlzy6nE=;
 b=E8GgoU3UYxtEYUQHfU9Is0oaROwXUJklr5gwEXAnsNVRFakDi4fz0eMG37MTzi4DY7
 kcfmj7/D6Ad2Bj2oHftHseJ4krY6gJ6bqKgVPXZFvSiDJTdkaWHAFE3JYzkF0eUB4wC+
 xNAuZzKDoQwF1kb3HKqvG/ApX1b2uv4odhmM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201328; x=1781806128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PEkWfPanh7q59TrWlqY0t/+OQLGLErZaOJuxqlzy6nE=;
 b=ZY2IeSJPcALmI2wIlq3OCl9R6LieZJGjg4UzQ4VRXnpcG1qBOT5HX8Nwlm8c0ac8a9
 lOvWzaTQiAtlSd0LfM25CNzXqrSJ/TilHpM9EGDrHU8aVOQI9kJ1+fmyvSKD5X+40qOr
 lXVHxQu0RqALoyvKHGDawiawUb3v1WTINvHPn0j/rn1pXBWYWHj0FoHEZFTfckz7CG9T
 9jFBIomKrrSfDcf4YQWNayH8mkYVWhDH3WB58ep+O68GzdZP9lqql8650WW1FAFNavIK
 MTqw6RuZH2en4c3CqWYPB/0fmLrNXfBxIlOyOaRoPstU21FXR9Kax29l6fUalVCE/owt
 5e3Q==
X-Gm-Message-State: AOJu0YxUqF1XW2AKY0TFGiUB7MFPOALvce2n21hxI4UOkyv7anVmcWgC
 4ybWGzSZiUXZpV501s9/QLVhgB7t1WecHYwIEnKZcstQsZis960/kGA/mFdGQ8ofmayg1/pSCHR
 l0idF29U=
X-Gm-Gg: Acq92OG/SzeheTdeCSDIkgO3VqOIHt641C8Um+8NZov9txGpQzo05ldZHa7kP+o/KUQ
 s++vJbT5xTDmBx8t5z9n9alhqn4T34nnQggM5Izp2SnNtDEgGrCVnq/fAFb7YKm6zHE7RY/QCPm
 eLLZ8VT6UNpA0/4xwIj24uRyzmFsanwpk9VyN71cA7PPADINVfl8prbSYJNxmkvsqtGLruQFy9d
 2AdkZuV2hHgbT4boHpMQSzm4ZK1wKxm+0MfS9WuZtRg8EK0hAkftv3Jdlus0P1R+wcdkuZy+CdI
 xbdDmzSHgRCg1bm/tFT2rQshJGhMR1it/QVYONXJzYd3JQSXnAgcL605DJA/Ke3WoQpSWCFp3D/
 MLtNQJDCzdP1T5/eG5oybHFOLgFWPcalWx3N+QqVUOdUC+MXYHNC94VOzbv5t5b7T2nrcpIDWq9
 Fy6BQZ1wl/qAqHT9UyuwKpRaoQhAtaVOsYpqjrbLadP+wGWmxS3c8sqsoQre7r0VFfd0j5Be8Rv
 ql1rW6SxK6FChg+Zx7yWop9NGnrBqiRJA==
X-Received: by 2002:a05:600c:8902:b0:490:e1cd:ea25 with SMTP id
 5b1f17b1804b1-490e55fee98mr51634245e9.23.1781201328261; 
 Thu, 11 Jun 2026 11:08:48 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf570ffe006f778db3bc22ef81.dip0.t-ipconnect.de.
 [2003:cf:570f:fe00:6f77:8db3:bc22:ef81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4a128csm6563345e9.0.2026.06.11.11.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 11:08:47 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-block@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, Fam Zheng <fam@euphon.net>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v10 4/8] hw/nvme: set CQE.sq_id earlier in nvme_process_sq
Date: Thu, 11 Jun 2026 20:08:37 +0200
Message-ID: <20260611180842.6390-5-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611180842.6390-1-alexander@mihalicyn.com>
References: <20260611180842.6390-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32a.google.com
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

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index dcdb9bd66f8..4040d24073b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1522,7 +1522,6 @@ static void nvme_post_cqes(void *opaque)
 
         sq = req->sq;
         req->cqe.status = cpu_to_le16((req->status << 1) | cq->phase);
-        req->cqe.sq_id = cpu_to_le16(sq->sqid);
         req->cqe.sq_head = cpu_to_le16(sq->head);
         addr = cq->dma_addr + (cq->tail << NVME_CQES);
         ret = pci_dma_write(PCI_DEVICE(n), addr, (void *)&req->cqe,
@@ -7852,6 +7851,7 @@ static void nvme_process_sq(void *opaque)
         QTAILQ_REMOVE(&sq->req_list, req, entry);
         QTAILQ_INSERT_TAIL(&sq->out_req_list, req, entry);
         nvme_req_clear(req);
+        req->cqe.sq_id = cpu_to_le16(sq->sqid);
         req->cqe.cid = cmd.cid;
         memcpy(&req->cmd, &cmd, sizeof(NvmeCmd));
 
-- 
2.47.3


