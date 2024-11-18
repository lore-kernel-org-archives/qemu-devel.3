Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509CFD4921A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD1A0-00037i-24; Mon, 18 Nov 2024 07:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD19x-00036l-Mg
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:17 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD19w-0005Oi-3c
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:47:17 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3823cf963f1so992643f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731934034; x=1732538834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ub7X6sJHrjB0SzaYTR/xmHntoa5aUSaWnEy/yeF5Dbw=;
 b=qH3ksDh8AOeUFeTRRfg6RyCDwV92sxwPTl5zouS+2a8tGfTq94nVl2O064Dky83hCH
 HJNyf3LrghGxhO8jRU+MhNLtrWFN2swPYCxrU6TWUrRxVGy9TrivOIvwcVWDr0jVONYq
 bT5abUKR8M5TfAdLFa9WMmsieCYPS85QhYgJjdLvQA3jh8cVDlriRm8SPYlREx1lepO2
 IFRb79IA4HR0Rww7Ah70BYWWbQ3u+hMHyfHla9ju3eyfzh/qQIT8nM/QTSrJqdr8z8eo
 +StbxY1awK9GJZrq2YarU1wAhYE9aHp+4HoDbX3XXhqhwlv5hUSjn1Ab190TkUkgY413
 ODdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731934034; x=1732538834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ub7X6sJHrjB0SzaYTR/xmHntoa5aUSaWnEy/yeF5Dbw=;
 b=OY0CxyvM6Z/mSHZhGkDd5fiq0kptX6j9FPKXgjzOeoHPU1GfU8+DzmfjN8BxKBwzbD
 liu9Et/Akcq9fsyTytGjdBWNXcd5PcgkYjky1OQ18f50PIdcj1/cAg5A/6B4oVl9Nm9p
 ogMhngqlJBwGJezKI2Fm2W3/3JcqOQc1G1bJZ+i0nBF69zA6xKZKbZVToBACiYab+ytt
 TsDUM5oSmX0YV/L3baEq7M6ELcVFYmvIwfDEI1LUWEc1pTQcSUZC0uA0jdNbnIMnI/Ha
 08EG7oTr62jOVpAb8tK6Nc/2AthK3CGz+Nllfos1vNjY2AQSLMQRvwJzvUcMqm1Zoy9l
 Ks0A==
X-Gm-Message-State: AOJu0Yx7nOTPy147JhIEmkPr5RbQ0Mf4z9F3++HUchf3m/6L7oC3SXD9
 tWB+3D31fZxc4CKgx9RwTo+PKwUgFNjAkdBMdxnaFB0nRCnFiJ27Lz+mSnRYeiR2w20Amw+2XQY
 d
X-Google-Smtp-Source: AGHT+IEZUGNePzS+TPyOvqiyJ5vGiJdhhtigcxedUAhIjNsLqs02G43atR8nzMgcPOKKnOkPt1/NZw==
X-Received: by 2002:a5d:5c0e:0:b0:382:4a4e:25bb with SMTP id
 ffacd0b85a97d-3824a4e2883mr1474474f8f.46.1731934034135; 
 Mon, 18 Nov 2024 04:47:14 -0800 (PST)
Received: from localhost.localdomain ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38244355924sm4098904f8f.46.2024.11.18.04.47.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Nov 2024 04:47:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/15] hw/display: check frame buffer can hold blob
Date: Mon, 18 Nov 2024 13:46:32 +0100
Message-ID: <20241118124643.6958-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118124643.6958-1-philmd@linaro.org>
References: <20241118124643.6958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Coverity reports (CID 1564769, 1564770) that we potentially overflow
by doing some 32x32 multiplies for something that ends up in a 64 bit
value. Fix this by first using stride for all lines and casting input
to uint64_t to ensure a 64 bit multiply is used.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20241111230040.68470-3-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.45.2


