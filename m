Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0707BE65298
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:21:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgkA-0005CW-D4; Sun, 01 Feb 2026 18:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgk8-0005C7-9F
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:20:36 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgk6-0000KK-Md
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:20:36 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so3177582f8f.1
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988032; x=1770592832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mFBINwlnbUzimo0bMmKTtdWLFjMVHtdrIxAzG6it5I=;
 b=V25oD4Heiwy9BJTKIQV8ps+zVLIchM2dhTd9HketsyQJIaQr0MuoB4rwQTM0v+a+bl
 Ql3Q7aASIW8+180qXe4U0pgjGaGVTdBR4WqlsE0B427fmdP1a/IE2BZ//ReMX7obk4na
 qn76GUJ/fQalFOXBLyfOjrAwukWRp3L48Nqpe81heIOXnpYtjmUDo2I3ykATWi7FPgem
 a4av8P+5Rt/VLg7G8OxkX8wXPl6bVyg10KX5YqZAkOdZl0fTUvVY9ymVBd/hv4rwZtpj
 Y+bdno+vaYdDMlndlifzzX6PGxim3uzFv+zpRkz5zClc4y73EsAl7Xlcah4a+jpRigey
 P1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988032; x=1770592832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/mFBINwlnbUzimo0bMmKTtdWLFjMVHtdrIxAzG6it5I=;
 b=aShuS3/oNh7+DQnncJQ4u75IqtBT3eVDR3zwJexMhMwgjuXen3DCfCFv84G+H7bIhR
 4AT16vzvhwwYvp9wuo48TXoCCV9srRckTWr8QmEXPO4hr1W21Z1CV9HRSffj0gRBI02V
 EOGq9IPt5Y+elsVqgEAd6y4IbMI1hlgiS4Fwhbc98Z4dTHJhjePzkn0OZZkaEcRQTqWR
 eiuVd/U7n77wSwESrOUQOwzF5gNVqiu1PTxlWYhXe4OCFHq7a1shZO4hJEilnOmHD0tg
 qtgUwAtlesEmZTd8o9JJCu/KaaZXroF+RL5vHUA3MY/8aqYMLjQ7bzJzj3BpO1woK2D3
 Tayw==
X-Gm-Message-State: AOJu0YxqpauRMO43pVPjhEw3GHvOOrdAxwrd7r+T/2NtuPtDdY7FOypA
 bmmyPCJRYxYTaTPEptFBZrPXc2wJxsCjH5So26Ctli5qTShTFLmxeo+S8PE6bcry5xjScMD6zuK
 6Sgk/oDQ=
X-Gm-Gg: AZuq6aKIlJRG8sOxFHvThF/uczxlJHsh8mBY6Egg4cFgbSMhYAm/Ufnej3/41kyHxJQ
 H1mF5y/+Xn8m5yvgMqVyGXQDVEHfn/XtbKJyTNfzI/dA5XGicDCAjW+w9JgugbhnvQ7lj/vBN+T
 m+/dC5LNQZdSRWQCTUX5CCzLK1Mdg3tQbF7SpsM6BZvTfCiyXXMQON7gEaN8134tzrSx4pzsteD
 YgrnCSDqtJZfMMyhpF5SZOoaVyS+HhZ3JsQpLnsKafoNgTFPSGen3UHTLxqcutk8A5c0uwet2R2
 YYhlt+2fgdqbYWS8qH1NKbskqeqh3XPxzoT6hWOlcfdeoigqNmDcrnJpIDnPMcLXaWJYImZ1lQc
 tbzaBs968ZAx7FDD5w29lYZob7YDiZwU1W8P4Gaykt13caqjeLnwLahvid3pgMa/ABDov004hmw
 73CyCk4Gw7lGhJGKCoV9/qTU2YZ+JOvci9BW9xhjEq9xOGNYOd2SUhoNfLGNUN
X-Received: by 2002:a05:6000:4205:b0:435:e3d5:cf7a with SMTP id
 ffacd0b85a97d-435f3aaf745mr13627492f8f.44.1769988032147; 
 Sun, 01 Feb 2026 15:20:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce64sm40883981f8f.26.2026.02.01.15.20.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:20:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 04/10] hw/virtio: Use VirtIODevice::access_is_big_endian
 field
Date: Mon,  2 Feb 2026 00:19:53 +0100
Message-ID: <20260201231959.88559-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201231959.88559-1-philmd@linaro.org>
References: <20260201231959.88559-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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


