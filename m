Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3770D591B1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 20:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD8Yt-0001V0-FZ; Mon, 18 Nov 2024 15:41:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tD8Yr-0001U7-WB
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 15:41:30 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tD8Yp-0002Nh-69
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 15:41:29 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a9ed7d8d4e0so392625466b.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 12:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731962485; x=1732567285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUG5srLGbOrkRmSwQBWBypd2vcAod2ucdDn5wmB1EIo=;
 b=KmJ/eriRwfiHvuYuMIb2s1HuIlU0gPpQJU4wTzabn42v5TH+COoC7LIZPmYEqdaHbZ
 kGFkAys5gvn9Fb0LI9a6RmiLo2NDlDlEeTCiXqmHQxGiDFVplRFnn38sc4hii+5AvE/e
 AjMb7726SAI9qNLY93pUXcKAjV0ICv1/EFcYCHwpImRkAD21imkqNRoIopauriwu1Q5Q
 5gQxjDQdGyK7J5Wet+Mss2He7BZ5Qqjo2p8UWvQWJOWI+vH3dPZrM9GRgjIVAutNgZJ8
 VjBlJwbnMy9VFHEJ8BOFcO7lhuRNVT7sc1oOId/a3p+IZs/ZednJsLr/u+Oc1f6QLcyZ
 Xn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731962485; x=1732567285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUG5srLGbOrkRmSwQBWBypd2vcAod2ucdDn5wmB1EIo=;
 b=iBkgqs6n3LNRjEVuGSJuxS4g0CUDz0ds+XgSg9zNQxEUIwWdeJ2GG+SgieA0fCcpR7
 MSqHbWF9MW55KIhA9RChGigP3280eAyXhmqN7uJQk+/nn8a/RhAxhqtRihaHnBB88JMX
 RZNDcAjgW1xN2tCgJJF7yjVQCHxt2YyhHD6dHmmrSNXDT7wUPlAILQjqoUejq35p9mBb
 HQDXiqiOeZC8l4BqD1PpA3bZqwglNprRi2PPzA7PcQgTlIbVpCJcuSjDoISNP31W7mAI
 RE8Jy5KHit4hCpiqaQVrwAk8v3YodhSRaoH51bYIVTUvuhMIcGCgdWkYM95wcOCGvI8+
 c70w==
X-Gm-Message-State: AOJu0YyOUX/RpjUPgTMsvVmD6PqTipx/EoM2b52rkY206Cpg9d/puTWJ
 PlHQ/clDAqL09Zc7VT54zRRgyWVO/jCsWXAJ21IEkLB+pSDtaP4Z8xAepXhXveE=
X-Google-Smtp-Source: AGHT+IEKhYYQG+6IYcN7WCUXjVfxvXcQTuG/swUYF/HaN2yXO3AMY9tCRX9IK//ahbi12jnqVO2/kQ==
X-Received: by 2002:a17:906:fe08:b0:a9a:85b5:2aba with SMTP id
 a640c23a62f3a-aa48341f3bamr1329130266b.21.1731962485227; 
 Mon, 18 Nov 2024 12:41:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa20e048f12sm573462566b.173.2024.11.18.12.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 12:41:24 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7B9E25F95C;
 Mon, 18 Nov 2024 20:41:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 4/4] hw/display: check frame buffer can hold blob
Date: Mon, 18 Nov 2024 20:41:23 +0000
Message-Id: <20241118204123.3083310-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241118204123.3083310-1-alex.bennee@linaro.org>
References: <20241118204123.3083310-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241111230040.68470-3-alex.bennee@linaro.org>

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


