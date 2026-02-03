Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55619E8B362
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnNSF-0006dG-65; Tue, 03 Feb 2026 15:56:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNSD-0006bc-0m
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:56:57 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNSA-0003Tz-C4
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:56:56 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c61343f82d7so2418125a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 12:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770152213; x=1770757013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rEeBeIO1f0L6BJtdb8+pQt36CSiY4onYarlIZdY/2lc=;
 b=IIrrnY2Sj9KTJn45gI88g1pEd+I0P/xgDAg/u/X9DFgYefYIDCl2MAi5n0UTOuQO4B
 nnMP2G9V0Wq1OIv6Op7ABVlF9tYkMdzvujqYfX1OMCIqbQgkW5b6NDB3GgOIwU0Ifx9n
 KU7UbmGlfahmdlH/loDw6sRyrirFUsIqu+GYSWa9xBz/8UKvTi/M1ULzHV/UOUauIliY
 lod8wuFI0Qk4OrLAkrdqSPZrpR3yuFp2IyoaAVAMivDJMsxB0rl5X7gfOVtxtWUvxEcw
 hlZUR4z710oXn7ubwxHd+RWKDZlHwkxY4F1nCo719P2YyKFBVN5AMSAyWtYcryzC5M4G
 m4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770152213; x=1770757013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rEeBeIO1f0L6BJtdb8+pQt36CSiY4onYarlIZdY/2lc=;
 b=ogaQynmoMUNKlRsD+v1289JevFJlpXm4T9HCnfukIYGwR/8UutmGfg4AvyyDQBatIf
 gv4pgnagAND7EZkMoC6L80nnZX/rqORksulXpuGRg43PpwLzN+8mqZ8eakM5utrKbyYG
 34Nigox5kXufywq1SJj5gnnQu8XB2h4TRmcmn3WzO+jQhdS7fYYap1EfnWxq3tpeNjLA
 u6tgOCf/X8ny/FbNQlGleN/KhD6HG8n6Aiqdz0pIOGqQw08gBVgLXA3+DXEQTQbiHuUL
 qApGE1Yhit4MZ53k0C3XKX/B2nEx45TRHPVjxLp9UN2Fpa9X8Z0RV5r7AVH5hk34p1IT
 mPEQ==
X-Gm-Message-State: AOJu0Yz9ovK/aLMNePgfcVk/v6Q4MTv/EZwVJLWILlT9dzebUY8AmIc9
 8mP/PJRYgJcoeXaEa43Yu8+dqRwlvAzePldIyunB8+NNeEpxe5D6SGVlyf/akoZbcinhFY8sDET
 jCUSZo9o=
X-Gm-Gg: AZuq6aLhw3PNN1hpGD5FRvrc+dTPXFGzjCF0k9ige34be9eVf/3ru0i2DLoktHyTQn4
 iavXPavKnMIMg2VZvdwq24zwBv4r/RS1/NPkbO++ttr77/9Sz9dx/ocsc35vl9kgDTaWYRp5I2M
 PLQo4coW4MoWdEYhl1V/LiEuBraKGdz0nlYrCz/omWZmAKGc2ei3Lvu7ZL0ULlsLuxEPBZfpsEz
 bSQBxX0+WOhgYPnrhCiT5iF6DW2g1Wc+dA2FATSe3CZ6oGFuh/rhvVbcMkS62h5LbsckbpAeHB6
 /nxhcPUkhduX82v5U3whd79LkjhmA/1qSIa3fmy3i6iGX55Y0UFL7ZAgABmbSZCthZCnW6YWbA6
 0ugYFaRwIKQ2Lyz6NGPlWhnODPKotevBz1fe3RJRpY+qvxuDX6YZvQo+WxpOkgymKliiOwOV2sv
 nia7MsehROJ+AN+BHiXOQXHdJV5QJ7wvz8YU0SYTQxaUP002PD7bnvn4qJvh38KGGB
X-Received: by 2002:a17:903:1c1:b0:2a0:d5b0:dd82 with SMTP id
 d9443c01a7336-2a93423edfcmr5689735ad.61.1770152212696; 
 Tue, 03 Feb 2026 12:56:52 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9338512f4sm3612875ad.9.2026.02.03.12.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 12:56:52 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v4 3/9] hw/virtio: Use VirtIODevice::access_is_big_endian field
Date: Tue,  3 Feb 2026 12:56:31 -0800
Message-ID: <20260203205637.3109749-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Endianness access is constant between device resets.
Use the field instead of calling the same function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index df2887e7296..f08e94843ea 100644
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
2.47.3


