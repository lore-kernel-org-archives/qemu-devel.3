Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1E4C53209
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 21:31:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo6QS-0000ZC-84; Sun, 26 Jul 2026 17:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6QN-0000Ay-Jl
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wo6QL-0004cR-Eu
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 17:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785101416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yZu81sJRfUDJ7gSNX62NjmG3vC2DfnNRoaluf11vifQ=;
 b=H4SpHDYwFByirFqqyPh22RDHSifVbWudNEQZgnrgEov076PFhIW00TLhXQTS8Qf1CK82qd
 M2Aw4tbT8pZ8Za62K7Y+riwtp09TmBKZU+7X6MKHj/nJyugzSt+oBo6S5zOFKa6AGyjqoz
 60TeiiIJWeF42OdBMZyJzXBnxW34Joc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-cNS95mLlM8Cc7KmI9ta1WA-1; Sun, 26 Jul 2026 17:30:15 -0400
X-MC-Unique: cNS95mLlM8Cc7KmI9ta1WA-1
X-Mimecast-MFC-AGG-ID: cNS95mLlM8Cc7KmI9ta1WA_1785101414
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-496b61bd846so11640875e9.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 14:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785101414; x=1785706214; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yZu81sJRfUDJ7gSNX62NjmG3vC2DfnNRoaluf11vifQ=;
 b=Kb1qDsCS/RQ4s5EOu/y8NV509rL4hoSWtU6pawtJNd3GoRi5/bLva7MFFUObx4Gvx1
 rc9AzFrRhnfNXPySURo/5zZzx/aepRLda0uJoBSRK264Qtun2+xLxutg9RVktIQ9ftXK
 Nq6niN2paA9Ybgjwcm+YBUrrZEJT299HcEj2opk/WLlxJJRAlUDMKRY1onafy/2uZ9u6
 M+XIa0/1zY+x8UQvEL+ABMjSTMosM9/3I/Ki/CCH276pNUip3gpxr1iF/itz25Z4hpFH
 HaDrMJq7hN91DWfYKpOQOFf/PKjDZNtGQ3DUlTk2lazDb9fO4tMyTCyvkUNCQDBN3ZV0
 PO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785101414; x=1785706214;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yZu81sJRfUDJ7gSNX62NjmG3vC2DfnNRoaluf11vifQ=;
 b=DRc4Lb/NKwV73jauDdrpKpxbsmXCKao+HW4kkGymwyIsbTxDDc5EdMSD5MPlDmdOCV
 Q9CiLqXJ0hBiYh+WgpVzpgrovbsSbNECJREz+2p+m64zAw3pRo+i6iz+eG1pxvlFa1N/
 ydRsyIE9yVoDnskEdYecD92nQadBf/aOMulTOoq927QuisDhmsckhgK+pof/Sue8gvlV
 SUq94hL+QAxuK1pplret4pm0WOZtOImiTxWwY4fC8Cx/sBrkMbJ+iMUOTOt+l73rnSup
 t6T7v/2vmDObfVq7zBx3+9oDValpd8NPVXa0OLYu9L20Ebj1VTomZlCSKPWcSOIMMQt/
 rxPQ==
X-Gm-Message-State: AOJu0YxozGwdkaBNL5egPm0Q2uwl91Qy/1aNF7U57lEQXAlIDBLLWYUM
 3R5ZY2hnLpWs4QAO08SFIhKja7Ez3Jn8rV3zVwCYiLLjTr06EI1pxu9bAIL289gGTKsJ2vMRhMc
 O9NIOPo40dXgrHC+yX2FftuIllGPv17NdP+qFgbEPv5sS8YOa5GukvCTad/EjCSbiFqh+xRPI8A
 uF1KkyLtTNvcDvwDeK69P9rOXevPrHXJ52IQ==
X-Gm-Gg: AR+sD102uMOVgjiuxxBXhLe57xhvlI3YoqFxehBMiemIkct2G6A57OIusYm3OTDTj2g
 5dKoyf+UmgtH8O7mzhaTaJXx2eatY8d4dFW/U7C3UvF+eegKvWWZkz05WfIDG9ue2byg5w2R8dq
 bQTQ+0aH4svjSbn8fwjiaM9e9D5hMiBzPOWBhdflTlBjdBn1SOzBhH98jWGz7IuhW6XkkzgxhcF
 RRtKsgwYgUSpLIOIjssC5vHjiDW30hFn9kNZEzk27lEv3K8ajPUCXG9PMzamreodD+luKQUxRyl
 /7dsrF02cTvzzpYKRatyczoIypkW8jEdJPPXoQRf2RAiqge3dQQcJSk97b3j1CCQUrKCwMxsGOv
 INHnc9wUOfDCVpp5wfIlzzA==
X-Received: by 2002:a05:600c:4fc4:b0:495:5022:71b9 with SMTP id
 5b1f17b1804b1-496b572485cmr73763825e9.33.1785101413805; 
 Sun, 26 Jul 2026 14:30:13 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc4:b0:495:5022:71b9 with SMTP id
 5b1f17b1804b1-496b572485cmr73763575e9.33.1785101413353; 
 Sun, 26 Jul 2026 14:30:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b485ff2csm213158315e9.6.2026.07.26.14.30.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jul 2026 14:30:12 -0700 (PDT)
Date: Sun, 26 Jul 2026 17:30:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jia Jia <physicalmtea@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Amit Shah <amit@kernel.org>
Subject: [PULL 29/30] hw/virtio-rng: Fix host use-after-free (CVE-2026-50624)
Message-ID: <10c27280beb13e41f3d3309d0985912002ce3bf2.1785101237.git.mst@redhat.com>
References: <cover.1785101237.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1785101237.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Laurent Vivier <lvivier@redhat.com>

Fix a heap-use-after-free in the virtio-rng frontend when a delayed
rng-random backend completion arrives after the virtio-rng device has been
hot-unplugged.

Fixes: CVE-2026-50624
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3917
Reported-by: Jia Jia <physicalmtea@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260724094931.3005968-1-lvivier@redhat.com>
---
 include/system/rng.h   | 14 ++++++++++++++
 backends/rng.c         | 16 ++++++++++++++++
 hw/virtio/virtio-rng.c |  2 ++
 3 files changed, 32 insertions(+)

diff --git a/include/system/rng.h b/include/system/rng.h
index e383f87d20..a2667d75ef 100644
--- a/include/system/rng.h
+++ b/include/system/rng.h
@@ -86,4 +86,18 @@ void rng_backend_request_entropy(RngBackend *s, size_t size,
  * deleted.
  */
 void rng_backend_finalize_request(RngBackend *s, RngRequest *req);
+
+/**
+ * rng_backend_cancel_requests:
+ * @s: the backend that created the request
+ * @receive_entropy: the function invoked when entropy is available
+ * @opaque: data passed to @receive_entropy
+ *
+ * This function is used by the front-end to cancel all requests to a
+ * given backend. Requests to cancel are identified by the receive_entropy
+ * function and the data passed to the function.
+ */
+void rng_backend_cancel_requests(RngBackend *s,
+                                 EntropyReceiveFunc *receive_entropy,
+                                 const void *opaque);
 #endif
diff --git a/backends/rng.c b/backends/rng.c
index ab94dfea85..7bed62616a 100644
--- a/backends/rng.c
+++ b/backends/rng.c
@@ -68,6 +68,22 @@ static void rng_backend_free_request(RngRequest *req)
     g_free(req);
 }
 
+void rng_backend_cancel_requests(RngBackend *s,
+                                 EntropyReceiveFunc *receive_entropy,
+                                 const void *opaque)
+{
+    RngRequest *req, *next;
+
+    QSIMPLEQ_FOREACH_SAFE(req, &s->requests, next, next) {
+        if (req->receive_entropy != receive_entropy ||
+            req->opaque != opaque) {
+            continue;
+        }
+        QSIMPLEQ_REMOVE(&s->requests, req, RngRequest, next);
+        rng_backend_free_request(req);
+    }
+}
+
 static void rng_backend_free_requests(RngBackend *s)
 {
     RngRequest *req, *next;
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 66690a34dc..d68d901195 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -234,6 +234,8 @@ static void virtio_rng_device_unrealize(DeviceState *dev)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIORNG *vrng = VIRTIO_RNG(dev);
 
+    rng_backend_cancel_requests(vrng->rng, chr_read, vrng);
+
     qemu_del_vm_change_state_handler(vrng->vmstate);
     timer_free(vrng->rate_limit_timer);
     virtio_del_queue(vdev, 0);
-- 
MST


