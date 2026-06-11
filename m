Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633B8CD98D2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdV1-0001VC-Dn; Thu, 11 Jun 2026 07:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXdUy-0001Nk-6y
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:23:00 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wXdUv-00017K-TW
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:22:59 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45eee266c6cso6417818f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 04:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781176976; x=1781781776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4uBDjD++ufYkPG4JfE12kYu5daqsRYxf0c/eetggXvQ=;
 b=L+OJ24KpLF5AGEfkMN3D5zkSbG4dEnQzx3A5oGiVdjbunpDHFoonqmt5ik1n/m3NW4
 qUUDs81qrOgGalmKNd0n9kL1SdrC8HjbBmT8XlyzwwGqhvAtnfjGGiSmnLGBkWEzqP19
 1MmLLc3R0OEjF0yS702APK1Nch/w1skAz3Zr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781176976; x=1781781776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4uBDjD++ufYkPG4JfE12kYu5daqsRYxf0c/eetggXvQ=;
 b=fZsxYTK32Jifz6yVNj2/AchvixOx+Ak/ea/pYBNzP584jJ3SU5xU+mkRb7q48LT7NJ
 EB9E4FF3GjrryHGMhGyyjt15CJFWtHTEPGAdgl2kcvWUaDajPXM/BJM+OcLa/6UUlr8z
 zJsoH1z2my/eIQS3ik+2c0WC0XY7nYIjkc3GJbXd+/IEc1zBHsIHQbVPUpVNWEW8Dx/S
 jbKz2Kq5mxSZ48GHt0MSw+nqjCLKXKk2mn3zbqQSmK1RTxZ22nnURmvCRdCUhUejE9x7
 A0BDiUdjAFcEVPZrnUTBlW+Zi0Tz41YNGzoomKuIz4NZGRfFLP33TV0xAxbgEjx3U9cT
 dnoA==
X-Gm-Message-State: AOJu0Yz9IKlzRJ46+Hij6pu6F22KMmnFjkIs7jjLTsk789szdFLUz94I
 lmDAwqlQXuxk1MU9KBKOOkqHR8u2fdqNUWP18j1GsqL6drnyOder1JZPxUuDaWE46430ptV1LTd
 g3gxQS8I=
X-Gm-Gg: Acq92OFYkPdSSP1aSoj/gBXCXWWY56zb1ZxPt2/me7pi0m4Ls1rN4K7JmxXxLKrWwT9
 oxEv5op7nxsH0zx/D5AcPiqKFpIvpuu20sUGiF8S2Y/IKy0wJDhL5QJ8S8xe9ZlmJ8WP4JPJBJi
 GVUwIDl4mCxmcyjEZmnF5/98W9CABxakRJQ0xm0MkiDXd/GcXm4pGP4l0seaeF4zgffr+c8hEpO
 2IvbcP6ot7+6GaR9gUp5a78q6Cxz+5FGqf+GdFBXpqSzB2P5MLSqdAiQt3b7z1yMRPe0Awv26k8
 RtgW4YVK6bERGke6Vl6KJM2CldhO8+GH2DGlEoVfPNEYweLlDn3GV+QIu5BkT1lE5q79z0rWOmG
 GBWa1dsyJuMhYIxs1JyWAmgB7LThc+tl/yiTpBJ9tSxR4ncU4o5+6Mj4+fJp1bPQ3U85HDs3S2q
 5hZTvRe/XX3/N2UnR72ykQWGsOG9EsND5G8/40ET9cJz4YOxNCoTyZqkLllqxReRDn7H1/9psR7
 orMRwjy1AY+3xyCYsnlRSDT7ZjARJazDg==
X-Received: by 2002:a05:6000:4022:b0:43f:e22e:e8da with SMTP id
 ffacd0b85a97d-4606758d0b1mr3825025f8f.5.1781176976412; 
 Thu, 11 Jun 2026 04:22:56 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf570ffe006c26edf58ff062dc.dip0.t-ipconnect.de.
 [2003:cf:570f:fe00:6c26:edf5:8ff0:62dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35fb24sm86375554f8f.34.2026.06.11.04.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 04:22:55 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Kevin Wolf <kwolf@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH v9 5/8] hw/nvme: unmap req->sg earlier in
 nvme_enqueue_req_completion
Date: Thu, 11 Jun 2026 13:22:46 +0200
Message-ID: <20260611112249.165012-6-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260611112249.165012-1-alexander@mihalicyn.com>
References: <20260611112249.165012-1-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x42e.google.com
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
index 5569e6872d6..c65b43a04ca 100644
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


