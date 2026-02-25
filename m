Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EE1F55449
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6Nn-0005cG-OH; Tue, 24 Feb 2026 23:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv6Nl-0005bi-Cx
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:20:17 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv6Nj-0004qQ-Ke
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:20:17 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso48445675e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771993214; x=1772598014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NqTpTGJG4svOAEeffctm6QW7VYZ7AcyiuZ79wbqVmIA=;
 b=fyImABZUsxbp0OBhuVmdpNGfAQLpwgq8UmJNKBykWRmkEXFErgldslHTT0WNCds9jX
 OSm17wFfAzWMkckKsbGmtuajR6dXUQ/b+cQdy1axdL+fBwTf68yVqDixkwq4kuSyIVXZ
 BE58kaixkWrk4UlEEavNgCDrJ3r9aD+GqxuGa5M9up7iwp3tT0rVnB5D04pbKu1a+zL4
 86tc4/YAXUfelTKG2krOS2jaFSuNpWUMGNDhY3Ls7K8YLBzSTZbihe0zlK9cHA4PLTxF
 Tp1MDnqoXa+IpPn22X+bpTRWF8tktQfpb40yLPXrDnuS4vMhXUmTuoHOgJ8U1Psgl/nt
 JKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771993214; x=1772598014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NqTpTGJG4svOAEeffctm6QW7VYZ7AcyiuZ79wbqVmIA=;
 b=CYZ5ZP8YqLL4CRT9Iw8tcDZ5AyGsGlTwa6mD5O1p9HX6qRKglwJHjwYRwFwEE6MvLj
 5QhVFrqC5OlvR+h3IkuNQWC4CpMHHb32IZVzEHr5LVkM57K8g31qWLhOT3sSQMXOk4J6
 2rlzMLcdMmGUH5QX/gpIsJfMMwphdRU3fLT+xZ1PUlIXcLvZ76ZLdkabGC/YBA4XShh2
 Q+xwj6WgS2h+Tz/k82Znrm/cdd9zPjSD8sGfZoWLYwC9JFNu7bvUpv/QHaDAhy0TQSPI
 6aHSVWe/mvSukutVQAZyd8ELOmSp5SFR8uBCtds7eW4bv/jFIzThHIGU8F1HjbYJCntH
 JYZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX93UzbMMpuyC01/ZsHTGuq6/6zknismNxQKIoup8C4ELbksWWb99YqcLUKTOB8n9xo7YLfBS8vkVuj@nongnu.org
X-Gm-Message-State: AOJu0Yx9fkMwvxZdTPo7tLLmCFMe50C5s7XlS8FtAbGFvOvWjXCiL6ui
 n7KpRb+wA8InEa4+go9oQWgiRnX8Jf8KNCNHj9LRVO6blU94rTjLPzqZkO2z0/z7CCs=
X-Gm-Gg: ATEYQzzWh25KEfNMCSAOBmJkwEZ0hfa+W1pe+b3wu3SIV2gVhVHwEg4x8UE0L2H+2QF
 rkwlY5kq9+509eqK+KQfM42XrLNqUht4IUAFDn9alZY3K27MqtZma6VTLRLxIccNGxOgHILVgc7
 A1/320asLYxFTM8iIigAI9nwcv1tc2HuwJJNqIhavNyUgoNwtl564wRTnkY+DmegJxE/PtWnOlG
 qWCpzzR8iYDe+FPOYdVuxET6z8ImUlD/qFm7Ctbwi89lJixbeoTOVD2U1j1OXhT+iuLqpul/H4K
 YVEPktL+iJ140MhA8opKIiPOFyyDNg5prcm9rvL2acLvQJwvDKMvYHVns4ZBLtrd8Xgm7uHT+8b
 /vjyoLx/EcbEI/HU+nVRQZSuHtMmaM9dX4ydHNfzF1nvYhqZHxHpKnwtdnvXw4ac13VwBF0JIAt
 Qn7xXEFjqI0kVQvXMQs5tyFmmIVeObbquZMBQyA+N95oywY0BmEdiam+Vse0OR4rlk0z4N2HmXX
 KLzGURdzcg=
X-Received: by 2002:a05:600c:6990:b0:483:6a8d:b2f9 with SMTP id
 5b1f17b1804b1-483a95aa328mr247738895e9.5.1771993213936; 
 Tue, 24 Feb 2026 20:20:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfecb8basm1913585e9.32.2026.02.24.20.20.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 20:20:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/6] hw/virtio: Inline virtio_access_is_big_endian()
Date: Wed, 25 Feb 2026 05:19:44 +0100
Message-ID: <20260225041948.52929-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225041948.52929-1-philmd@linaro.org>
References: <20260225041948.52929-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-access.h | 29 ++++++++++++-----------------
 hw/virtio/virtio.c                |  4 ++--
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index e3148c23881..506be642c9f 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -21,14 +21,9 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 
-static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
-{
-    return virtio_vdev_is_big_endian(vdev);
-}
-
 static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         stw_be_p(ptr, v);
     } else {
         stw_le_p(ptr, v);
@@ -37,7 +32,7 @@ static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
 
 static inline void virtio_stl_p(VirtIODevice *vdev, void *ptr, uint32_t v)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         stl_be_p(ptr, v);
     } else {
         stl_le_p(ptr, v);
@@ -46,7 +41,7 @@ static inline void virtio_stl_p(VirtIODevice *vdev, void *ptr, uint32_t v)
 
 static inline void virtio_stq_p(VirtIODevice *vdev, void *ptr, uint64_t v)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         stq_be_p(ptr, v);
     } else {
         stq_le_p(ptr, v);
@@ -55,7 +50,7 @@ static inline void virtio_stq_p(VirtIODevice *vdev, void *ptr, uint64_t v)
 
 static inline int virtio_lduw_p(VirtIODevice *vdev, const void *ptr)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         return lduw_be_p(ptr);
     } else {
         return lduw_le_p(ptr);
@@ -64,7 +59,7 @@ static inline int virtio_lduw_p(VirtIODevice *vdev, const void *ptr)
 
 static inline int virtio_ldl_p(VirtIODevice *vdev, const void *ptr)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         return ldl_be_p(ptr);
     } else {
         return ldl_le_p(ptr);
@@ -73,7 +68,7 @@ static inline int virtio_ldl_p(VirtIODevice *vdev, const void *ptr)
 
 static inline uint64_t virtio_ldq_p(VirtIODevice *vdev, const void *ptr)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         return ldq_be_p(ptr);
     } else {
         return ldq_le_p(ptr);
@@ -83,9 +78,9 @@ static inline uint64_t virtio_ldq_p(VirtIODevice *vdev, const void *ptr)
 static inline uint16_t virtio_tswap16(VirtIODevice *vdev, uint16_t s)
 {
 #if HOST_BIG_ENDIAN
-    return virtio_access_is_big_endian(vdev) ? s : bswap16(s);
+    return virtio_vdev_is_big_endian(vdev) ? s : bswap16(s);
 #else
-    return virtio_access_is_big_endian(vdev) ? bswap16(s) : s;
+    return virtio_vdev_is_big_endian(vdev) ? bswap16(s) : s;
 #endif
 }
 
@@ -97,9 +92,9 @@ static inline void virtio_tswap16s(VirtIODevice *vdev, uint16_t *s)
 static inline uint32_t virtio_tswap32(VirtIODevice *vdev, uint32_t s)
 {
 #if HOST_BIG_ENDIAN
-    return virtio_access_is_big_endian(vdev) ? s : bswap32(s);
+    return virtio_vdev_is_big_endian(vdev) ? s : bswap32(s);
 #else
-    return virtio_access_is_big_endian(vdev) ? bswap32(s) : s;
+    return virtio_vdev_is_big_endian(vdev) ? bswap32(s) : s;
 #endif
 }
 
@@ -111,9 +106,9 @@ static inline void virtio_tswap32s(VirtIODevice *vdev, uint32_t *s)
 static inline uint64_t virtio_tswap64(VirtIODevice *vdev, uint64_t s)
 {
 #if HOST_BIG_ENDIAN
-    return virtio_access_is_big_endian(vdev) ? s : bswap64(s);
+    return virtio_vdev_is_big_endian(vdev) ? s : bswap64(s);
 #else
-    return virtio_access_is_big_endian(vdev) ? bswap64(s) : s;
+    return virtio_vdev_is_big_endian(vdev) ? bswap64(s) : s;
 #endif
 }
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index c0c4599b586..22d798e6cdd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -222,7 +222,7 @@ static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
                                                MemoryRegionCache *cache,
                                                hwaddr pa)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         return lduw_be_phys_cached(cache, pa);
     }
     return lduw_le_phys_cached(cache, pa);
@@ -232,7 +232,7 @@ static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
                                           MemoryRegionCache *cache,
                                           hwaddr pa, uint16_t value)
 {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
         stw_be_phys_cached(cache, pa, value);
     } else {
         stw_le_phys_cached(cache, pa, value);
-- 
2.52.0


