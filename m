Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B95CD98CF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 18:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXjpn-00072R-Hp; Thu, 11 Jun 2026 14:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXjpl-00070D-8e
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:08:53 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXjpi-0002Hi-SX
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 14:08:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso937545e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781201329; x=1781806129; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCPk+l34ucyP8qr+raic5pyiQuMSsix62CIWyGJoUqc=;
 b=SRu6oUPsAKATLhVKWZ7NaL5iBzJDzyB4YsIj8zJjJyW+ySdQZ5REoRSZo7MHWwVGYw
 yRIGUFupbh83ZKxxeLKK4PZVt+3btg90QpxWo/EW7zfb5M8yjvbFckOB5vTpD7n/36/8
 77vhEvvkWL+nCloHzzAncA/BA/5Zy9yj2UxoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201329; x=1781806129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zCPk+l34ucyP8qr+raic5pyiQuMSsix62CIWyGJoUqc=;
 b=F485uQGSiJyMgIyTHPBtB6gUzseV6fDojmBLcX/frraq3+mxdOoQSCEgp1JAA5u1Ut
 gZdm79hin3yEHj8edBz+eL10aNcc9FvMSROtkF1xLAh6r46Y2IXBfkBuHrcj4olKlogQ
 YduTiOr9/Usfc2SeZxvFUcCOBwjJrbWcqA+6nvkVvfYzMFVoRC3eLj8+LX+oEIAdaG0b
 zjtv3Anst3wrWleNeCfuY/jIsE72dr11GX5c1dFuGIQ60A2yFiIK7MxUQ4BnopFrzX4l
 QMXY0wUICHZwyZgRhtDze9l72ornPRV1XSkx2iOrzXspgiLvgIAKs6yoncqBkvrLRJzB
 8Smw==
X-Gm-Message-State: AOJu0Yx1Nb67FiQNWdryPMxt+FTWlBfhnzERH/GFtifrF49zRmbHzuig
 PaHSDj3nclj4IwLpKgy1mbwgCIesmSbkT7Uhdxi8DOYNCkdKxaBKvzzrWr/1hileO8pJuQCdfsv
 2rENKk1U=
X-Gm-Gg: Acq92OHNf0eV+c4aBSz9+fnB2EWO6JNpVAkMIWtiOP5iOIWok0WKDUGsXPCy9ndMnbz
 lMlGfSBjLdojhAcnHIJSOT1xcwBPLlIIMpT+wHOFe8+UOhrdgp763CEKRvIArAYM66an7cWeQcR
 Yof5DIM1CkvOrLRRK3Q8NMqhxo0CH8MvSqayZcqBewh8h2m9DbT6QNdNOvkAHmGBmoTxW54m0/J
 0EO4XIJWsPRpxQXTXywHwEEXhkvHxDPrbgqJvQSu3NuOpy3BisSlZmhEOt3m+XHrvwWrXLIpg31
 rEQCfxK5D0KPqBjSLrxWd3mfWFFF2Z2xp2hhp47AFn2ZKN1H+3onXQiPy3utJWn9AZj3dupL6SN
 ndEBjQ2LVkQjHS7zPNd0pFguV2MKPd1WH1RHyobLZfoUK+MOu6UHws51UEMAfle00qAzoJg3n9u
 VB1OunJOvDg0oDK0G08p8pkZUep+RdUCYMRsgAsXijRacDwx8ouBlZthrQCKkuZaqC5RBzflKnB
 T5G5idGL0ap2KPxKQ1ix2k=
X-Received: by 2002:a05:600c:4691:b0:48f:e249:4094 with SMTP id
 5b1f17b1804b1-490e560b2d5mr54393125e9.18.1781201329469; 
 Thu, 11 Jun 2026 11:08:49 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf570ffe006f778db3bc22ef81.dip0.t-ipconnect.de.
 [2003:cf:570f:fe00:6f77:8db3:bc22:ef81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4a128csm6563345e9.0.2026.06.11.11.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 11:08:48 -0700 (PDT)
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
Subject: [PATCH v10 5/8] hw/nvme: unmap req->sg earlier in
 nvme_enqueue_req_completion
Date: Thu, 11 Jun 2026 20:08:38 +0200
Message-ID: <20260611180842.6390-6-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611180842.6390-1-alexander@mihalicyn.com>
References: <20260611180842.6390-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x334.google.com
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

Instead of unmapping req->sg in nvme_post_cqes(), we can do it earlier in
nvme_enqueue_req_completion(). When req completion is enqueued we don't
need to access req->sg anymore. We only care about req->sq, req->cqe and
req->status.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4040d24073b..8856cae6e65 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1536,7 +1536,6 @@ static void nvme_post_cqes(void *opaque)
         QTAILQ_REMOVE(&cq->req_list, req, entry);
 
         nvme_inc_cq_tail(cq);
-        nvme_sg_unmap(&req->sg);
 
         if (QTAILQ_EMPTY(&sq->req_list) && !nvme_sq_empty(sq)) {
             qemu_bh_schedule(sq->bh);
@@ -1566,6 +1565,8 @@ static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
                                       req->status, req->cmd.opcode);
     }
 
+    nvme_sg_unmap(&req->sg);
+
     QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
     QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
 
-- 
2.47.3


