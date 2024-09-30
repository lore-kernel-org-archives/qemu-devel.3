Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFDBCF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svBMp-0003f4-5v; Mon, 30 Sep 2024 04:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBMe-00035X-T6
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:02:42 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBMd-0003rQ-49
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:02:40 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f75c56f16aso48037901fa.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 01:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727683356; x=1728288156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yXipE1vCqUL/2GGIC/pfDOg0/7HE+1Efkqb3qV24aq0=;
 b=tx5YoGJWFUckrveB3VdNhtiMFf8LVpRUmQRun9jJ/lC67d8QYi4SMyMMbXBnljtpoj
 wkyN5usEcONB4tKJsCPpFy1CdBoBoONoZ0aZEmdrxNKBGskQWB0TtVJ3DKAXESyUpQMP
 h9s4KMYR5TtNb0MsYMpCKxhJwZ26hMokWHvFSeU31dYxC8REpQOr39Siiy+/DS1tzmwi
 Dr6+2Z7eDCJZSxl/wDviY5tM3bRno+IGXisK1nQLxJyvUlO7qvwxqHXV08VaCWdkED2b
 4oNM+xmKYbPs9SnVIZtw2L1VinsJdC23dVvjA+mym0hShxbnDk2ywXG2diGM49+OVN2m
 iLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727683356; x=1728288156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yXipE1vCqUL/2GGIC/pfDOg0/7HE+1Efkqb3qV24aq0=;
 b=bqbv1owSjADILEY7McaMNYqeVYV0Qm6hf6IQuiJTh9dwiXzbZ6hBARlsKLg6MQT+FG
 b4lCpbqkp8udT2JOKnMeCNDBvRwRWbU2+zHOs9ujTvlB2vny1T8xrQDqy0GTR5rfoRcm
 AnErrliHxR8QziJ5ygxt6OMiuJxy2H+IhtuCbrm9UoEvdNcwjZ+j7rYVjgCAn+udrtr8
 R2BXhGZOoqqn1gvq0Yt5FUEdkYENkVwqRcNswLZtK+sHy1loE4kuYNLLulgDu5v9IxMI
 bNl/bofMIirqqAaChi+jcpz6Pg0BfS6d0LefGJSLsNfCMI/AeQchqWa6Qucg+QfPDPL8
 xeKw==
X-Gm-Message-State: AOJu0YxWdxrHdF4xDnoXYgesAUTitpLqeqHPp0/a2sVO4J8m6HWR777D
 1NOoBRBlARvm6lK4I2DuEn+RaMX9yJYKhcp8Gyb4LnQg28oEgQZjsu4pVKS9Axqsjd5AbaU2zTB
 ngyo=
X-Google-Smtp-Source: AGHT+IE8wS4WpCF0/bxJggWg+4eccixi5G2yV44Nj13zqRqQ7E/h8vxjwxEQnrMTjigRWr4M/8ssTA==
X-Received: by 2002:a05:600c:4f86:b0:42c:bae0:f066 with SMTP id
 5b1f17b1804b1-42f58434768mr72915825e9.13.1727681712926; 
 Mon, 30 Sep 2024 00:35:12 -0700 (PDT)
Received: from localhost.localdomain (186.red-88-28-13.dynamicip.rima-tde.net.
 [88.28.13.186]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f58c523dbsm91069205e9.38.2024.09.30.00.35.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 00:35:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
Subject: [PATCH 02/13] hw/virtio/virtio-access: Use the ld/st_endian_p() API
Date: Mon, 30 Sep 2024 09:34:39 +0200
Message-ID: <20240930073450.33195-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930073450.33195-1-philmd@linaro.org>
References: <20240930073450.33195-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Refactor to use the recently introduced ld/st_endian_p() API
No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-access.h | 36 ++++++-------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index 07aae69042..b920874be8 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -95,56 +95,32 @@ static inline void virtio_stl_phys(VirtIODevice *vdev, hwaddr pa,
 
 static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
 {
-    if (virtio_access_is_big_endian(vdev)) {
-        stw_be_p(ptr, v);
-    } else {
-        stw_le_p(ptr, v);
-    }
+    stw_endian_p(virtio_access_is_big_endian(vdev), ptr, v);
 }
 
 static inline void virtio_stl_p(VirtIODevice *vdev, void *ptr, uint32_t v)
 {
-    if (virtio_access_is_big_endian(vdev)) {
-        stl_be_p(ptr, v);
-    } else {
-        stl_le_p(ptr, v);
-    }
+    stl_endian_p(virtio_access_is_big_endian(vdev), ptr, v);
 }
 
 static inline void virtio_stq_p(VirtIODevice *vdev, void *ptr, uint64_t v)
 {
-    if (virtio_access_is_big_endian(vdev)) {
-        stq_be_p(ptr, v);
-    } else {
-        stq_le_p(ptr, v);
-    }
+    stq_endian_p(virtio_access_is_big_endian(vdev), ptr, v);
 }
 
 static inline int virtio_lduw_p(VirtIODevice *vdev, const void *ptr)
 {
-    if (virtio_access_is_big_endian(vdev)) {
-        return lduw_be_p(ptr);
-    } else {
-        return lduw_le_p(ptr);
-    }
+    return lduw_endian_p(virtio_access_is_big_endian(vdev), ptr);
 }
 
 static inline int virtio_ldl_p(VirtIODevice *vdev, const void *ptr)
 {
-    if (virtio_access_is_big_endian(vdev)) {
-        return ldl_be_p(ptr);
-    } else {
-        return ldl_le_p(ptr);
-    }
+    return ldl_endian_p(virtio_access_is_big_endian(vdev), ptr);
 }
 
 static inline uint64_t virtio_ldq_p(VirtIODevice *vdev, const void *ptr)
 {
-    if (virtio_access_is_big_endian(vdev)) {
-        return ldq_be_p(ptr);
-    } else {
-        return ldq_le_p(ptr);
-    }
+    return ldq_endian_p(virtio_access_is_big_endian(vdev), ptr);
 }
 
 static inline uint16_t virtio_tswap16(VirtIODevice *vdev, uint16_t s)
-- 
2.45.2


