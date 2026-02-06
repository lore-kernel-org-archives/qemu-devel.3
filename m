Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B91EE6B69
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 22:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voUAe-000652-Km; Fri, 06 Feb 2026 17:19:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAc-00063D-Bp
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:22 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUAZ-00079H-KJ
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:19:22 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81e821c3d4eso2283979b3a.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 14:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770416358; x=1771021158; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=klAu5HgA/rCTewGXJZJRvxMK6aIVCdRxxwUdqNQ0dtE=;
 b=C0VAa9wfAAewNwxVtUayjl1Xo0LCcUgJw0bGDXuw6YZWC1SIxMSDiNbA31gV/yCgi0
 0v9ORdxtkqzZBFU6yHdqH4bw+K0c2iz7TMukQGAA6wzmILS7lNK2IoIccgfoCjg9bHVf
 HgTg4svBTIy3rMk0IwahYR38co4TyGM/rE0MXQx5RzeXBeT8ySSOpUhzmsnlbpzX3d0o
 VIg5/W4BxS1rtNDLRGjWZL5iTiPX9IDFGeJ7OjVGNkqvxdeZuFsjt2zQ9QVaoPhlFm0k
 4kzZNJFr73lKgBKgSlk7PVPpbzwEfGR+Gz5MNpaQE0w7LIf3b9R2kGC4RtM+jNBXrMJZ
 ZCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770416358; x=1771021158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=klAu5HgA/rCTewGXJZJRvxMK6aIVCdRxxwUdqNQ0dtE=;
 b=skwoUouzljRgqQnxwTzSvgooTRMCQV1f+xwlLonqfXXUdt5qNxpa55Qq1Nz8MdP1JJ
 PRDMQ9nrYK2jlROLXtyLv4AxwFcblt7J1hq5kfFuIi0h6PIGhtR7yiC80EwmLplf0aq3
 ZN7pnTsYvfhdRZyc/V1MBx5honOyFuSFrXIbtb7DsIugWb13BnznaYURxmhgU6Y4XfI5
 gApajV3/di8RaHFhWPbAaUR1sEIehPjF+j9GzQ/UBOOfKSRU/LgPMf+yuNrpRiwHPcTQ
 emDgcMVsZ2pYBSnVIN5jdg5E72bwkUI/7/w4zTKXSFPZKG4WPJi6CybydWIaDWYGooxg
 qBgg==
X-Gm-Message-State: AOJu0YyWrGCf/P2NYBFlDMjVgNzAzusVtpfCnrvcI3E9tHmwYxHGo9f/
 ddOvUW3ayRjJs0xAv+J6C1i8cGqrBSbvMugCoNkiLCH05j32KybbpYd08SK1dHdyZA9oNQGobkB
 zM8E0
X-Gm-Gg: AZuq6aIaQ9RfDb5/qXZScYqOkTzqHxLgyxtIcPA6MnU202Nxy16Uqrk1vKOv9w2MRow
 W2wmZ8s+W/MBc/2BIaeat6xv1R1qnTtYcnP0i7LQZbwTa0TZWPrG8ba/86qeGZE6NimdSyUyf9n
 oa2/t5s4U0wRiZfiyCBKLZczT85qMiqClwD476YW8nNkxEhaU1GwZX68v+qznvqbgZ30n0pfw7a
 CRMJaiTt9ZP8xUod1qP19TMnDu5tX+amdLNzeoGnUhA7urHQh+TunaI6q5whYJezOzdgeDMEPir
 0h9DyIszeoeFP394TSer2hlsaj5AW6ZatOjDjRGZETQbSQ7xgjMDQ8Yiqa/9nX4w8WcUEuL3tnr
 nuDGUGc2TdEZEyMaPCn/A1KEwTMF7uqbzOZ1PVbkQO1hk/QsvdmyF+6/Z47upHHqPni5urE+fvj
 TQ3suQq0ArVXU75ugDIui/Vp5gdGfTKpfX7/wZH0uMvVw6ryHlTmIIxC7khwjNLGOf
X-Received: by 2002:a05:6300:618d:b0:384:d0fc:f51b with SMTP id
 adf61e73a8af0-393ad41a505mr4150791637.80.1770416358230; 
 Fri, 06 Feb 2026 14:19:18 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a95bff42f7sm13316575ad.68.2026.02.06.14.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 14:19:17 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, stefanha@redhat.com,
 richard.henderson@linaro.org, qemu-ppc@nongnu.org
Subject: [PATCH v5 3/9] hw/virtio: Use VirtIODevice::access_is_big_endian field
Date: Fri,  6 Feb 2026 14:19:02 -0800
Message-ID: <20260206221908.1451528-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
References: <20260206221908.1451528-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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
index a429ff7de39..c92a70a41c7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -222,7 +222,7 @@ static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
                                                MemoryRegionCache *cache,
                                                hwaddr pa)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (vdev->access_is_big_endian) {
         return lduw_be_phys_cached(cache, pa);
     }
     return lduw_le_phys_cached(cache, pa);
@@ -232,7 +232,7 @@ static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
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


