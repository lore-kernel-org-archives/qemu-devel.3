Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41318CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRq2O-0007uA-Ne; Tue, 26 May 2026 07:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wRq2D-0007rN-Im
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:33:22 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wRq29-00026z-0z
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:33:21 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49040362e4aso48760985e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1779795189; x=1780399989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yc8Z/WOcW3uh1L6Ec/8nuxoMxkg0ZuToRnjX8Ro9vlY=;
 b=PZfF1Ugj8cfWzncvLjimDOdfXLqnSbeN/V3EO2f9lhkGLP6RXx/M1Ze3ng3MokHkxi
 9Nk/05dOoY/6rbE1Fy5gEmxIqQOP6AbASqRo7PvoZRkkcMX+zGDTC3pyJcvHCKiXf1Du
 3Tzf02zavXtAZcEmyIdt29bIHR1Q/iylfCMVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779795189; x=1780399989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yc8Z/WOcW3uh1L6Ec/8nuxoMxkg0ZuToRnjX8Ro9vlY=;
 b=g5TW09vpTAbEpKrHmPVIfQhLMnZmxxDwSrrjAbbjj6UVK9nnhcC5Sp5MEkDiiUlj0B
 8btY1HcND+RyQ0mw2JIMOmFdM0v+muaEJY6djwfBVnWJ+LqZmMQP3DQzegccW4n7omr8
 /jvAaCfcBumUuV8euAqiZo8j9pEMB3eEfSZ5ZyiYt3GT0bdI5wLRtyASVQyGu5PLMCtg
 QwX07zobyv34ohzVYSmUY/9RR745SvJFJBU2O5tx8yQtDUHU2zEKTRKI//0+ew8gZ1gt
 uXPCdVrneJPDV9MVPrH03pj0grjO1nCmGDsQbo5LNxC02G9loeMIBeZqYGQHa38HYr23
 P8ig==
X-Gm-Message-State: AOJu0YzpJt64Uperj/D/NoTfluh5VzOLs7xcH/CBOa0ll5urIbqqQ6Wa
 rZ/LGDatT/+F+TUo7HhJhP9n1Km/t5udPhUay8yrIOGVmdaeIJMfTkWAelpcXlJx+VLWijfsPSc
 yrMs/nk8=
X-Gm-Gg: Acq92OG3emKDu8sISWsZJw2t/dtmWNXggfzYbIOmte7wqYFGtEdwGq0KkVUdaORBAZk
 yIU9DOhCN83lltQo6fXl6SloGsi3zdZFYdJmlRiKPj2Ddu9zYbTbbBVCC0MuKVXnokGV4qHQoJJ
 NqZ3p69pT4OE/qwvakBetfY+nEnz+0O8wU2CF8Vek3PJmKEa9nYFmfTsohUH6X8wqQ6/WciJk0g
 npPpncXkTnJ1KxE6cykFHctRCVdvOt2ctbOHNo7hkLkWZbgewiLvMCTx/GfIJZts/rOm0Oeqgrl
 iSxHrWMF0wQL7MhQ40cM120UL4HV+Y5aswG8w9J7PDbF/X2UahciD50V3922cDbTcjwkaCjiTgP
 oIbujqF5LmmjYaGteGVaY3A76rC5V1oiGDeLZyJDqhBun0LgNhNFdQrk88LRbOuB2ZW/hCCzt13
 WdBZMREWEDZzIMlQ44sLzOgZYjd+l0ttRhLhuosv17j17lDbk3Y1s8JuPMUfs2pwW2omVYKj/uw
 FNg2KoZDDySw2Hm6/W6+sq5tufQvouhUw==
X-Received: by 2002:a05:600c:35cf:b0:490:3bad:3784 with SMTP id
 5b1f17b1804b1-490426bc6demr347148475e9.18.1779795188823; 
 Tue, 26 May 2026 04:33:08 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00840292fb31d0d80a.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:8402:92fb:31d0:d80a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d4ca0dsm34366870f8f.18.2026.05.26.04.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:33:08 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>, Laurent Vivier <lvivier@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Peter Xu <peterx@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v8 5/8] hw/nvme: unmap req->sg earlier in
 nvme_enqueue_req_completion
Date: Tue, 26 May 2026 13:32:58 +0200
Message-ID: <20260526113301.91492-6-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526113301.91492-1-alexander@mihalicyn.com>
References: <20260526113301.91492-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32f.google.com
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
index 066fd2865c9..27fb854ab4d 100644
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


