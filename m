Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5BAD1BDC5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 16:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80Kx-00053J-6Y; Mon, 04 Nov 2024 11:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t80Kv-00052S-HK
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:53:53 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t80Ku-0004gd-1y
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:53:53 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a9abe139088so687875166b.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 08:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730739230; x=1731344030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lB8vB/PMzeP5scWej6wNyd9gn12J752qtp8raWtHWDs=;
 b=rXY+5ddm2uT0pfKnU7GomqUon4As2T2RGhMZsTdpdC8Hd0+B0hEkIbsli1Fa4NFSMc
 UIBedh1gXW85y63Tp3SThPEbwJS/POm9SFk2FYAwChi15mx7UBwbFQthxQt7LqCF/dVZ
 nYdHmpCE8zUFbdvrJDyj3G7QchDRiQ0c3aRmLph7JCQtMrHfUlIZLJbbRNKhZnk+yIvO
 Wk86bwT+W8jj7qF23HY2SIM2bQUbs+uTqEbf9M8/UAudR2Do2PCCnur4bHMxNfGhLtT3
 evwiFxhThQOu6fq7pUmD/HDd46i2nIJV2fSoMtPbR2mk/O7Q56SlPnsc2mJX+u6cOT2l
 1G7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730739230; x=1731344030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lB8vB/PMzeP5scWej6wNyd9gn12J752qtp8raWtHWDs=;
 b=Kn+/1VsVQFfCo5GPSUiHXnAuawgPIbne2CiDhCwn1Nk/PGJR/necF9Ci+kqoLtjPLY
 RvVTPBvG1tjNvho3YwBqaT7vABqYl7X1lA0f144INOl1t/XlQFrbtqPy3DBmJU6eewzt
 p1g7oeLJFNY12ZPIsiLWFwD4MiJlevEA8ovzGZsranKK5Xu6QXujVVBhwCoNSvLR8Ed6
 UNYZBgU8dfuoltz1+0q7ixIelCucQGedOmDF0pFxZeUm37K5OGvTX2RmLvx5qSp39yCZ
 jsuaJgfU9gME9WeUupcoKekTjryZ5//bXGhs/KzVw0VQpicVXpIVDvCc7+4YgJyV4faa
 yA5Q==
X-Gm-Message-State: AOJu0Yy4gAgD9IdOi8eMBN0Wx9v9ug+paMRZK78WLHFqCWhJWR7NmtQw
 bNuOQ2biEbpl7R6xe2JB9WLo/1dWkxwAwSIzH9IrM99jUXZ8PIXcfMmBe0qTuac=
X-Google-Smtp-Source: AGHT+IE6xFMS48rSdWjpI+kN2STgUhu7Kzmv4KaSjCmAhsUcJ/SfX0elJCRcYy1zjxWT1kaMEV1zrg==
X-Received: by 2002:a17:907:e8b:b0:a9a:714:4399 with SMTP id
 a640c23a62f3a-a9de6167a45mr3222665566b.51.1730739230016; 
 Mon, 04 Nov 2024 08:53:50 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9eb17cecb5sm4199966b.99.2024.11.04.08.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 08:53:49 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7864A5F8CF;
 Mon,  4 Nov 2024 16:53:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PATCH 2/2] hw/display: check frame buffer can hold blob
Date: Mon,  4 Nov 2024 16:53:48 +0000
Message-Id: <20241104165348.2361299-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241104165348.2361299-1-alex.bennee@linaro.org>
References: <20241104165348.2361299-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

Coverity reports  (CID 1564769, 1564770) that  we potentially overflow
by doing some 32x32 multiplies for something that ends up in a 64 bit
value. Fix this by casting the first input to uint64_t to ensure a 64
bit multiply is used.

While we are at it note why we split the calculation into stride and
bytes_pp parts.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 hw/display/virtio-gpu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index e7ca8fd1cf..572e4d92c6 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -741,9 +741,14 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_framebuffer *fb,
     fb->stride = ss->strides[0];
     fb->offset = ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * fb->stride;
 
+    /*
+     * We calculate fb->stride for every line but the last which we
+     * calculate purely by its width. The stride will often be larger
+     * than width to meet alignment requirements.
+     */
     fbend = fb->offset;
-    fbend += fb->stride * (ss->r.height - 1);
-    fbend += fb->bytes_pp * ss->r.width;
+    fbend += (uint64_t) fb->stride * (ss->r.height - 1);
+    fbend += (uint64_t) fb->bytes_pp * ss->r.width;
 
     if (fbend > blob_size) {
         qemu_log_mask(LOG_GUEST_ERROR,
-- 
2.39.5


