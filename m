Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2462D172AA
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:30:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgtD-0003ge-7D; Sun, 01 Feb 2026 18:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgtB-0003dW-30
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:29:57 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgt9-0002iV-DT
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:29:56 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so2905872f8f.0
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988593; x=1770593393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mFBINwlnbUzimo0bMmKTtdWLFjMVHtdrIxAzG6it5I=;
 b=ywQUNexV2ybIRA1VPcvXg583cW9MEQo6ZyMwb7tyhmpDW/ii735Dc7Vdd+3fOzEUPU
 hCsDERjoZBSQN7a7UV3neQ71tF/Mq4n1y6xRSoZPvL4td9dyigDAaQQOgoxABvK5OYOn
 W+PE0zIwkuYhR4E+5TW5qHYDeWWNid/kBexfRG2PCy8FsLZfxzgnqDh8YSsILKb0TxcP
 NThBYwksr+NS5fh8ghcY8SPWezVGcOMhRG+pFbrQ5u2URrx5tgIi53zTc9A6h10x+VpJ
 uS6Z3aE3enNBAUnJ8E1Dl6yzqeqYc8Z/z0bE+nAv7LXKnsVt82qN9kmkNrw0MrozOxHT
 ZgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988593; x=1770593393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/mFBINwlnbUzimo0bMmKTtdWLFjMVHtdrIxAzG6it5I=;
 b=UxYhYTigFd69uVikXwvBMKH21f/iyexlR5NLaYlaa8n6VPtpebo/tP2N6rLpG/mAP0
 rc0/nAUmgG0X/rzNZS2NQQjD8VjIa5umaUNIR6nLRVq49OPS4/8pTd7dP0+fcCco0Bz6
 wF7gVDzUhLcakXzOnsqnsFpx8zmsIr6Dx/r2yjpmv3Mubeh7Qk2pDhc00iydfzjTYly0
 5vxqcrMtGjdTVvFghAAfTaYMGoMjylWwuwsqOyo5ADscIMf74ruQqboXo2xPeSmcBRG4
 a+fsgq92Tw4+JwzOw9RAfBYPJk1emhwJkffrJ/foEYON3E9qBegLeMjocmq3gjNTrW5b
 mlMQ==
X-Gm-Message-State: AOJu0Yw8GaS+SOTQWRU82BRT5IExnllgFAEKfxUMA4fBOpuP6zDsXxEE
 VOexk2lLS46fDjUrTxZ4z9UHkpHkjPpL4ZZvEA8ZZ44oTm66dKDfcFfhEk9n/nd/LLZ97KCBWK8
 G3LriJOc=
X-Gm-Gg: AZuq6aKlotMZe1k3ML/JjSFQ9mPmrcyKgJQNbctK2JlRiAvGM2FaJniln8Aw3ThMX6/
 WZjaZ/AqvqboLyWY+ud/i+2Y0EDD5YPIToMbB4V6s7zBjjA7ACb1Xke+zlrXnWViKh3/7vyZWRe
 frc5U1+q/yhbjkBEixc5zeEXsPf7vP1LMqGXH6IPVvrN6s33jG+xXtwNpEDyQZ72M9SoOtRH2FG
 bVpzSx4PBkGccVqENLlRokKmBSPaUIZCvzUCzwJuslg9yVm+SmxoENlETzofEM42XWbudcOs5Zd
 xbt6cb0KX13/0KyG/gS87Nss8mbg+ng2VkGMtAdVOeuDsGFGD9wloGu5ZuBReKaMfm1yZBMafda
 +qro7vTdjDkXXrbuhza0IlHZ8jW054LtsX/TkImKCW1vj3OezB7oyJum/zZMNIhhuPQsRRENIgv
 I4mtU7kNPDP6XMrlrIc6jZfS11Kn1QCGjjEqOvzhYXxGc8XB9j9BdXvv7kmzb3
X-Received: by 2002:a05:600c:818f:b0:47e:e2ec:995b with SMTP id
 5b1f17b1804b1-482db45fa3emr124043035e9.9.1769988593088; 
 Sun, 01 Feb 2026 15:29:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56068sm345846735e9.13.2026.02.01.15.29.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:29:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: [PATCH v3 04/11] hw/virtio: Use VirtIODevice::access_is_big_endian
 field
Date: Mon,  2 Feb 2026 00:29:16 +0100
Message-ID: <20260201232924.93399-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201232924.93399-1-philmd@linaro.org>
References: <20260201232924.93399-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Endianness access is constant between device resets.
Use the field instead of calling the same function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-access.h | 24 ++++++++++++------------
 hw/virtio/virtio.c                |  4 ++--
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index cd17d0c87eb..f3b4d0075b5 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -42,7 +42,7 @@ static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 
 static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (vdev->access_is_big_endian) {
         stw_be_p(ptr, v);
     } else {
         stw_le_p(ptr, v);
@@ -51,7 +51,7 @@ static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
 
 static inline void virtio_stl_p(VirtIODevice *vdev, void *ptr, uint32_t v)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (vdev->access_is_big_endian) {
         stl_be_p(ptr, v);
     } else {
         stl_le_p(ptr, v);
@@ -60,7 +60,7 @@ static inline void virtio_stl_p(VirtIODevice *vdev, void *ptr, uint32_t v)
 
 static inline void virtio_stq_p(VirtIODevice *vdev, void *ptr, uint64_t v)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (vdev->access_is_big_endian) {
         stq_be_p(ptr, v);
     } else {
         stq_le_p(ptr, v);
@@ -69,7 +69,7 @@ static inline void virtio_stq_p(VirtIODevice *vdev, void *ptr, uint64_t v)
 
 static inline int virtio_lduw_p(VirtIODevice *vdev, const void *ptr)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (vdev->access_is_big_endian) {
         return lduw_be_p(ptr);
     } else {
         return lduw_le_p(ptr);
@@ -78,7 +78,7 @@ static inline int virtio_lduw_p(VirtIODevice *vdev, const void *ptr)
 
 static inline int virtio_ldl_p(VirtIODevice *vdev, const void *ptr)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (vdev->access_is_big_endian) {
         return ldl_be_p(ptr);
     } else {
         return ldl_le_p(ptr);
@@ -87,7 +87,7 @@ static inline int virtio_ldl_p(VirtIODevice *vdev, const void *ptr)
 
 static inline uint64_t virtio_ldq_p(VirtIODevice *vdev, const void *ptr)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (vdev->access_is_big_endian) {
         return ldq_be_p(ptr);
     } else {
         return ldq_le_p(ptr);
@@ -97,9 +97,9 @@ static inline uint64_t virtio_ldq_p(VirtIODevice *vdev, const void *ptr)
 static inline uint16_t virtio_tswap16(VirtIODevice *vdev, uint16_t s)
 {
 #if HOST_BIG_ENDIAN
-    return virtio_access_is_big_endian(vdev) ? s : bswap16(s);
+    return vdev->access_is_big_endian ? s : bswap16(s);
 #else
-    return virtio_access_is_big_endian(vdev) ? bswap16(s) : s;
+    return vdev->access_is_big_endian ? bswap16(s) : s;
 #endif
 }
 
@@ -111,9 +111,9 @@ static inline void virtio_tswap16s(VirtIODevice *vdev, uint16_t *s)
 static inline uint32_t virtio_tswap32(VirtIODevice *vdev, uint32_t s)
 {
 #if HOST_BIG_ENDIAN
-    return virtio_access_is_big_endian(vdev) ? s : bswap32(s);
+    return vdev->access_is_big_endian ? s : bswap32(s);
 #else
-    return virtio_access_is_big_endian(vdev) ? bswap32(s) : s;
+    return vdev->access_is_big_endian ? bswap32(s) : s;
 #endif
 }
 
@@ -125,9 +125,9 @@ static inline void virtio_tswap32s(VirtIODevice *vdev, uint32_t *s)
 static inline uint64_t virtio_tswap64(VirtIODevice *vdev, uint64_t s)
 {
 #if HOST_BIG_ENDIAN
-    return virtio_access_is_big_endian(vdev) ? s : bswap64(s);
+    return vdev->access_is_big_endian ? s : bswap64(s);
 #else
-    return virtio_access_is_big_endian(vdev) ? bswap64(s) : s;
+    return vdev->access_is_big_endian ? bswap64(s) : s;
 #endif
 }
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 242c207a591..1dc60d37cb4 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -220,7 +220,7 @@ static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
                                                MemoryRegionCache *cache,
                                                hwaddr pa)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (vdev->access_is_big_endian) {
         return lduw_be_phys_cached(cache, pa);
     }
     return lduw_le_phys_cached(cache, pa);
@@ -230,7 +230,7 @@ static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
                                           MemoryRegionCache *cache,
                                           hwaddr pa, uint16_t value)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (vdev->access_is_big_endian) {
         stw_be_phys_cached(cache, pa, value);
     } else {
         stw_le_phys_cached(cache, pa, value);
-- 
2.52.0


