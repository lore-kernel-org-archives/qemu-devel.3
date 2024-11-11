Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E598D3ABFA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 23:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAdOv-0000tw-Ol; Mon, 11 Nov 2024 18:00:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tAdOq-0000tO-JI
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 18:00:48 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tAdOo-0001j9-Lk
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 18:00:48 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d538fe5f2so3655425f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 15:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731366045; x=1731970845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=25/ELZrXiTJuBOlfElpFvmRMWuKeZY3HCvObpFpP1YA=;
 b=Vwx9aVWY8/Sa2DmpcHG69YkDOP1A5fxE3nWq+GcuTa+1TdgJ8rdVWOgfr37Z3M3bpr
 kW87G+f04U5c5nf3gEhGBlD0C4Lu4YdsdQAQNaoqE0CkkFjRZI1xzQ0sWDvIo/576i+z
 Y/9L6kaiwL7rtEKI3exS6Z9SFWi5wU+b+SciMELOnxw0ldETp2gNvBjpQiYHmu9Gd2in
 ipAi4xK8VYy7aOIMosz+lp30tWSc2CtaGh0fXx5+5Vh3z48ltiK4R2Ss0bZVh/TPLuwf
 wnVm9dOPpX1ztrsby/w28T9S7sFAGgy0RNgs00Zz+UK0bHk8DB2G+aMyL8RGZxgcnJfD
 XjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731366045; x=1731970845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=25/ELZrXiTJuBOlfElpFvmRMWuKeZY3HCvObpFpP1YA=;
 b=OCcv0nC2RP4ct3dH0JRghzsc3+JNflpY2KIsmwqEHivOkxEJ8hCSxnxWZFM7YjM9Kd
 qj0//G3gc+RyuyZFdgklIMHZSFwAlWvCRQflTG0mgOJo33awmnOiTYFa0eYcznsj8XkC
 fckIKzXTJ5rSAyCrO6xfhg3+1qhS9xNukd7v1zMCtkj6tLstaGA0MZbaz7681x/IdID3
 NakHoR0vzVIRVHWre8tb8kv5MeqZieiiGesZ+okZkTX2w/3rW9aMUsj0EISWXNMN4LU5
 RBixLajHg1paJlHozv2IZkbwNQaPdizg8e7KmO997vHwRdIhCH0L6TuVcYBKIRXqpi+Z
 6XCA==
X-Gm-Message-State: AOJu0YzVD5RoZIQ1Ko+dCEuZEJRJa9Ptw0sTlXdOo4yXTVU9ZOhGb+Sd
 M5ymd+ig6rZ9S2zTMr/ESt5EurGZHIOeczNf9wZIiZxQ13DRHox1l2TYRyziJfZHiZu7AkqJMWu
 I
X-Google-Smtp-Source: AGHT+IHVXB5PacgudOIDwIcxkvjQoVQZeiIMgCAk6DE4FMbhUBgHOkMnVqkZZQNGdgM/dZwN0aLh+g==
X-Received: by 2002:a05:6000:2d11:b0:381:f443:21d8 with SMTP id
 ffacd0b85a97d-381f443261fmr7728815f8f.0.1731366045115; 
 Mon, 11 Nov 2024 15:00:45 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97f544sm13994532f8f.40.2024.11.11.15.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 15:00:41 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 01D415FA3D;
 Mon, 11 Nov 2024 23:00:41 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH v2 2/2] hw/display: check frame buffer can hold blob
Date: Mon, 11 Nov 2024 23:00:40 +0000
Message-Id: <20241111230040.68470-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241111230040.68470-1-alex.bennee@linaro.org>
References: <20241111230040.68470-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Coverity reports (CID 1564769, 1564770) that we potentially overflow
by doing some 32x32 multiplies for something that ends up in a 64 bit
value. Fix this by first using stride for all lines and casting input
to uint64_t to ensure a 64 bit multiply is used.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>

---
v2
  - just use stride * height
  - tweak comment
---
 include/hw/virtio/virtio-gpu.h | 2 +-
 hw/display/virtio-gpu.c        | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 924eb8737e..8c977beebd 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -340,7 +340,7 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
  * blob_size: size of scanout blob data
  *
  * This will check we have enough space for the frame taking into
- * account that stride for all but the last line.
+ * account that stride.
  *
  * Returns true on success, otherwise logs guest error and returns false
  */
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index e7ca8fd1cf..7d22d03bbf 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -742,8 +742,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
     fb->offset = ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * fb->stride;
 
     fbend = fb->offset;
-    fbend += fb->stride * (ss->r.height - 1);
-    fbend += fb->bytes_pp * ss->r.width;
+    fbend += (uint64_t) fb->stride * ss->r.height;
 
     if (fbend > blob_size) {
         qemu_log_mask(LOG_GUEST_ERROR,
-- 
2.39.5


