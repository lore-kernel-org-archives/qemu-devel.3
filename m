Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8179FC53209
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 19:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woQt5-0001tU-VI; Mon, 27 Jul 2026 15:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsY-0000t3-5g
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woQsW-0000gc-EJ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 15:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785180043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yZu81sJRfUDJ7gSNX62NjmG3vC2DfnNRoaluf11vifQ=;
 b=Dd/221DIwAblHUnFdbKEWQtPXmuPET19/bEZHpvFWxGVWjv2RXMwDiFe08imWimx++mAjp
 QY+0OkLnx07wHTLO/Yz/kRrv4puCTbim60YoddUus3ZiBqS9UqsycLiCDk8PVb6JhNVaHo
 kGibaTG+pEMfHVPIlDTW5uoxtULj6AU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-7NkdR8pJNjmwNkyJpXbm4g-1; Mon, 27 Jul 2026 15:20:41 -0400
X-MC-Unique: 7NkdR8pJNjmwNkyJpXbm4g-1
X-Mimecast-MFC-AGG-ID: 7NkdR8pJNjmwNkyJpXbm4g_1785180040
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-495495ad5ddso17017945e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 12:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785180040; x=1785784840; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yZu81sJRfUDJ7gSNX62NjmG3vC2DfnNRoaluf11vifQ=;
 b=s4mctFqx0aN9XuZZWTo3eoAXL/vSlHWa/Xu2pYD/pwIBx/RXSh7CUmWAvzwXgceFia
 RvhfWh2s+XaD5LLErrdeOWwBIJ/PzIx9jMRl2ksRMv3lVv4Y+uOb8MqAeWpq5I9DI8QZ
 wXSHRQVe3Gtr2pA79CU6yJd+AjqjAc6X2ZHSDPBYBpIJRCIe/gcUi7MlF2kcDSJhURnC
 iYMdgcQ8K0o74nbS4qn833NaLJ5JfMO1kHeaAT/SDgflnUghCDP+Wf9dyNH/LpGfYCPG
 obTGIOdB4Aeyp2rHBncEqdBU8hmB6aUEGBMrexFeikJKwoviEyGcvEMKdrr9LUem6rtL
 FwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785180040; x=1785784840;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yZu81sJRfUDJ7gSNX62NjmG3vC2DfnNRoaluf11vifQ=;
 b=F9bH69tr4UniXcfoKJHhYBYJprEwoXpCQRyRVOBkaRGueq/++7h/T//hueGz6HNFfJ
 cHu6RukIp58h0I6L2+bGTQBOfaiUnDeCgdgjNKGVfIbyIlRsGB96IJ/Bbi9QLyO5yemU
 VuIAPL6C0cA11ZuvH0Ph9HFdPk5W+LSuE+8ngNNQ9PoTKLjeE5pViMWlj50OzPj6l3as
 rSSQT9JhWmAdR5d/mo4r5zUrlvO6+s2bNnUYCyQYZousPDUTHmwYX37QKk7z9xUr4hZS
 UEuxB24WlsZAiy4p05t/RrQS+i6m5MpMLa26qKXCzw3wpXVhCxwcL0SF9b16BNSvNqWS
 cFmw==
X-Gm-Message-State: AOJu0YzCkaFZU1zV2gCwlw5O0I5IwT4ysASndp02O3C30k2DGo03VHqP
 j1cHO+cL4GrL2BtlujUU5MN1+RReVZ331R9oq9fuOcJXlAnheSqvfxCyN5Fs721DVv6hU1ehfzW
 auANcWCZfP5jR9hpJt7KJsDlu+uMb4n7Gdjs2olRaC9D+mydMoK7MlxNCQo+9a1E2X05WxEi1mO
 BvujmufvbCgBbzmn/CxfxerbtAEVfGE0ijTQ==
X-Gm-Gg: AR+sD13Qedk9cbe2g+Hjjk5K6OstCAm2NFPQv1j9I48tW6rgGKzRuMwDMbxlgsD8qSV
 xCcOZqjuck13gNIJYC8lPK18bYugwrGR6VYjLXEe7PFzoYu0xhZwPb21v5HuknAvwYV5cgVqvES
 ovKhq4qh9qEVdBqbTsIHnB6lMJ0BaqxXyoS7X4gkporXTwkuygx4aZUsub3ZRfCLGR0NGZV43ke
 DL0/y5PVPDQ7byoI7unjDeCjMwrhSj4cfx6H7xnrZ2++ZCGhWwnZJxUKFez04aky4uMoI8ULlfk
 eU5pr740zHJrQ60iz8Og2FWIwyfLBRukD96nHWp5MOe8wQgxzM+uSOjZsfq5AUwE+Yy4Bv7dJlm
 6Bk+bDCwK1YlV6L9nPurB8Q==
X-Received: by 2002:a05:600c:a4f:b0:493:d741:5d72 with SMTP id
 5b1f17b1804b1-496b57116e2mr154280405e9.38.1785180040001; 
 Mon, 27 Jul 2026 12:20:40 -0700 (PDT)
X-Received: by 2002:a05:600c:a4f:b0:493:d741:5d72 with SMTP id
 5b1f17b1804b1-496b57116e2mr154280075e9.38.1785180039456; 
 Mon, 27 Jul 2026 12:20:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44a9451sm16951185e9.1.2026.07.27.12.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 12:20:39 -0700 (PDT)
Date: Mon, 27 Jul 2026 15:20:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jia Jia <physicalmtea@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Amit Shah <amit@kernel.org>
Subject: [PULL v2 28/30] hw/virtio-rng: Fix host use-after-free
 (CVE-2026-50624)
Message-ID: <0be94d8d9c28e6b7235b34133d057090fe93be6c.1785179875.git.mst@redhat.com>
References: <cover.1785179875.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1785179875.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


