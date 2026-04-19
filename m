Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75E9EA719C
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Apr 2026 13:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wERnD-00013w-MW; Sun, 19 Apr 2026 09:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wERmk-0000u8-He
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 09:02:05 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wERmc-0008Jr-Cn
 for qemu-devel@nongnu.org; Sun, 19 Apr 2026 09:01:59 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d64313c39so1680202f8f.3
 for <qemu-devel@nongnu.org>; Sun, 19 Apr 2026 06:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1776603708; x=1777208508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQw+kuVjtbO6TkwAkF7eczBsBb+4xiQrsikCv0Jap6c=;
 b=idPypAc9pa6wpOoAO+u1Ftp5iX0eqYyNLBzIzCCDYsMqIIwz7891i116pX+4bPmZPs
 ynRbyMsKUorTt8En7GpI8m7tuCn6lXBHdhK9ZPZdeR6omr2eB2Rbq7NFYoMIgV8tw9CE
 1BBC7NWGVWf838tAPJzd7V0pddXz+1Z7aNjXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776603708; x=1777208508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HQw+kuVjtbO6TkwAkF7eczBsBb+4xiQrsikCv0Jap6c=;
 b=fp/CJ0PSquclpZ2oEsYqoQhCqEhlWoTn+g+0jMlyIVsddVzBS5N59hU5X3ed6vk0OB
 ai/i8JjKcrSZ6JJundeUgteg/nI7NrK5HgIr7WEnfowIkVmCkJvGT9Xh1Vch/mbtlcB4
 2grMhGSsED11LHHSwQZlVnFEOma/OQEXpESfUNDiSw/hd3DEUJ0HbGfuuRNIL0M5Rduv
 U3OL/FO25R6QpXakwxs/0LPLNB16BjGbTJkrTM1bxFC64HnLrtwMhglvWy8IYhFzThqh
 T4SUfLm5ivpB5P0QszZvqwCgg7zrVdg6BFubq79fXWIhXMIPB+4ffRMGDFOZmh0AJ1dl
 soQQ==
X-Gm-Message-State: AOJu0YxWo72yA7479kVgQ2EyaosciAsqSdJiPnqN8fixsBIR2CHtOe52
 MX4Izyj+cFuw6J8UpIsQv4u4GN6VJjrjcPJ1LPuwuawK6EYvy7O83wYvLrqu2CFtBXP10aMT4bl
 c0P7YbU0=
X-Gm-Gg: AeBDiev8FVd6fNeDLtnRuT8JrFHMYdLm9shE7RrxD3L/Coih6Mv9Wy6gzrpgnnCVJWv
 7EC5kRAWDXEDV77GyI+kRmN/nK/PcauQ/f4/DmGyzyhq7rPMzvBjdWa7V07nVUAoQmtv46Pl4A8
 1zokkYWRUFVqgCZeGbcEPd3VXrVUZMlmhSCxY/iFbCeXDBTR5J1YMt6iXUMAKkWsjOe6HQyHJaP
 NOasl9c7udezMZySPiihsiPEJsz63Q2g+OazsZMjqeaYVmIF/rnCZgKTqz6kguXCBM8klrWznje
 n2xiuhERWKZMbnw+m4gWlVigtn2d6kFPMXVPiahM18oOaeD5aEoGYDmyP7DYSr/wAMxlcImLMmD
 1Vemy0tZ0C0VuplEedVL+1RPwfp3Slz8w1eNNNh4FSiKeUVVK5igxdNSbZ55UrrCW8ALHELntQc
 GoPZmb3i4SSVtXEsbL7ISv9SUnOLTi3yweddldEGeWlBv629ci8cY0J0Yy91R3zDhJBMHWgNr0w
 AiaSTTv2EMc1pFhy46hCSCvjg+y6LT95Q==
X-Received: by 2002:a05:6000:25c4:b0:43b:8f56:1e1d with SMTP id
 ffacd0b85a97d-43fe3dc10demr14095668f8f.13.1776603707596; 
 Sun, 19 Apr 2026 06:01:47 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf57228c00995e4e0d3496e07b.dip0.t-ipconnect.de.
 [2003:cf:5722:8c00:995e:4e0d:3496:e07b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc2cacsm20734304f8f.13.2026.04.19.06.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 06:01:47 -0700 (PDT)
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
Subject: [PATCH v6 5/8] hw/nvme: unmap req->sg earlier in
 nvme_enqueue_req_completion
Date: Sun, 19 Apr 2026 15:01:36 +0200
Message-ID: <20260419130139.15554-6-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260419130139.15554-1-alexander@mihalicyn.com>
References: <20260419130139.15554-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x429.google.com
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

Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
---
 hw/nvme/ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index d9bf32bff2c..1ff91493b60 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1534,7 +1534,6 @@ static void nvme_post_cqes(void *opaque)
         QTAILQ_REMOVE(&cq->req_list, req, entry);
 
         nvme_inc_cq_tail(cq);
-        nvme_sg_unmap(&req->sg);
 
         if (QTAILQ_EMPTY(&sq->req_list) && !nvme_sq_empty(sq)) {
             qemu_bh_schedule(sq->bh);
@@ -1564,6 +1563,8 @@ static void nvme_enqueue_req_completion(NvmeCQueue *cq, NvmeRequest *req)
                                       req->status, req->cmd.opcode);
     }
 
+    nvme_sg_unmap(&req->sg);
+
     QTAILQ_REMOVE(&req->sq->out_req_list, req, entry);
     QTAILQ_INSERT_TAIL(&cq->req_list, req, entry);
 
-- 
2.47.3


