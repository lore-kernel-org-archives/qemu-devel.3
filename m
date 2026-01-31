Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D195E6BF3C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 02:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm0If-0007UT-O9; Fri, 30 Jan 2026 21:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vm0IW-0007I8-34
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:01:17 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vm0IQ-0000U9-Fv
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:01:13 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-c61343f82d7so1070751a12.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 18:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769824868; x=1770429668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oWd58wnvbFOx8aJINbxb8qM4WgMJ3IcZKS3b5FQOgOA=;
 b=SM/D/HmG3loe4V8GkJXW6Fo6W6PsjoV2fPG6OVzfiN8pU8gMXha9x2HfCtGJiEdKGl
 1KYoHDL2hUCyitu5HR0vJsQWJfRiO66VUGEfVRZIwe9BwusY/P29JfmoqeDMudOnt7PY
 wwDxcQu72VJtzvzgiZvH7nO8ZXCubmHcdpV9SLildZFP/MmEGUGfTv1kZxRa5HPykH+E
 Sq04HlpVoca11VZ2H818UiRRJVza5ftkAaS0fw35xBy8Z+qXL/Uqbr0K7oe4a4OxDGIK
 2zParUNhEsryYWS2DH6W4jtfzjfYSRYJ3SBhXFV1gzfaQnJLmHMlt3wq/+1yzjZOOg6b
 zc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769824868; x=1770429668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oWd58wnvbFOx8aJINbxb8qM4WgMJ3IcZKS3b5FQOgOA=;
 b=VW29iGqN5zMq8gMcsXklTCZIq5JBA5GuxlCKuRErdSPCmIvEifZ6dpedag46dydQbd
 LfNV7/FLUgfY1mR2Yx/tIbhZpD7PnCEfzDFGHtcBcX3zxOvwEy1uxhTXqdhJgsBBsPMh
 OljSsxWlRrJdN7gmyu3iIXQ1jhBipwK665jGk+eKgDpST1Kv6q6dxyejYzrbrQI2XnsE
 cDNU4MK86Epn2gHI1mlZXvONNJ4f81vyI5Q0xjr9Mm/UrNJSAPeqs3AfiAo9YVUcj/5B
 5ktinFgXJhRSsqzblhaT2s4VLv58tP7QqdkZpOK1EIlA4j/N5CGro8SeCRNuic+2C47t
 aMXA==
X-Gm-Message-State: AOJu0YxQhPPpR9KKdr92VDAPQ2umEn8cL/3xsQMN8y1u9t6lLr806/CB
 NyjiBr62ypPEgkwW4IFkYLk18gT1OjjZ+B5vEHfCvjPaCOCIbOGPy1BOHqsiZDGxQDGIc+IjkLv
 3uESL
X-Gm-Gg: AZuq6aJpEZBWWvGcqSP05CYaUmpUyFYQiYNd8qdVqKhxccADpR2SDj7wCW/tNmCIrKj
 DDCdMzNf/MmM8b0kl8nkdQbVcIKfACvDU9OqO8dCqcZbmEZP5Oj0r27NiQC83v9f0mtpM0pzPT2
 aI8bJI4lCy7XBjU/GLQkYNs4saFMWZ10F/yyFzM487mC9criU7JkoEXJIvwS7gc8jxqlH34UXZt
 8Buki7vUEMZCNy9w+NjJfxqxcD0dE0YMlhwUQDXMyFj5KNP2hvptl5wCZRp76MWgjPVcn+EOLuP
 6q2nc0yjBj8n+0MzZUq+4T8p/8sxq8MI/kmMlotHV01IM2/gmKlPTaeXh3JR2WmbPaVXn3XzcDm
 lbzkuQxt7tYujKVI0kD0H839xZ50oafJvSDxLPPV0yLgBIpqa5wYwtSFQgBlL4NVwWr9BTjG28P
 ohaadyrRz3in9M+obc9yQnJaqehyOHvpU9mmkgGAKIyeJgcp8DBu/KOoDdy9WJ8U+UOsK3IWw+f
 LI=
X-Received: by 2002:a17:902:e78c:b0:2a1:3cd9:a73a with SMTP id
 d9443c01a7336-2a8d8163c80mr55269685ad.40.1769824868007; 
 Fri, 30 Jan 2026 18:01:08 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b41390bsm84697975ad.23.2026.01.30.18.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 18:01:07 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/6] include/hw/virtio/virtio-access.h: remove target
 specifics define
Date: Fri, 30 Jan 2026 18:00:56 -0800
Message-ID: <20260131020100.1115203-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/virtio/virtio-access.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index cd17d0c87eb..51d9d725690 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -17,27 +17,27 @@
 #define QEMU_VIRTIO_ACCESS_H
 
 #include "exec/hwaddr.h"
+#include "qemu/target-info.h"
 #include "system/memory_cached.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 
-#if defined(TARGET_PPC64) || defined(TARGET_ARM)
-#define LEGACY_VIRTIO_IS_BIENDIAN 1
-#endif
-
 static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 {
-#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
-    return virtio_is_big_endian(vdev);
-#elif TARGET_BIG_ENDIAN
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
-        return false;
+    if (target_ppc64() || target_base_arm()) {
+        return virtio_is_big_endian(vdev);
     }
-    return true;
-#else
+
+    if (target_big_endian()) {
+        if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+            /* Devices conforming to VIRTIO 1.0 or later are always LE. */
+            return false;
+        } else {
+            return true;
+        }
+    }
+
     return false;
-#endif
 }
 
 static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
-- 
2.47.3


