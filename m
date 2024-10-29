Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EF3D2AB30
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5l3m-0004ea-2x; Tue, 29 Oct 2024 08:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3a-0004bc-HI
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:45 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t5l3Y-0007TW-UN
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:10:42 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-431616c23b5so38269945e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730203839; x=1730808639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/BNiYYwKg/cSvehabs3gJ4EqBVuo2qMpFiEegCIxlqY=;
 b=t8z4IMOOm1p9Z8ZJ4QclBKp7vJEIB/1rFbnS7Azlw/NzJLyYphsaAAXbQcnqjD2zIh
 uqo6dSdr3AV8nsJaiZNkIDgKDhmqbKr1ornStlsXmjcEAn+wftkIZhWJbew35P2ZyRd4
 rowjyw6rSRRt0aQQdRLmeqGHS9HYaB9/UlL9A8utvtBMAKj0LTQMMPKx7LklgqZF/FI/
 wg0aXbF4Svx9DIQNF2tyVizxNsca7IqdTXPKMa9VwwGaImQPCycWFXihiimKzzL7sHxY
 Q9rntDNSY0I8bO1XcatPX+tOiD43GX7n/TMVVPyIIkcVbdJKBvtX5PWH6c/zS8Ro0DSH
 YKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730203839; x=1730808639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/BNiYYwKg/cSvehabs3gJ4EqBVuo2qMpFiEegCIxlqY=;
 b=CiU1ujAXsgUCdS9Dt/ApLHyjDMyCRj/co+bd+VfIe342jqj4F7WIF/en0+22hLQemj
 R+J8dC/6R+EUgNVBy6UCINFzSWTYCOxTTamUG/Ky/GiF6kZoy+Yi0evN3Bs09OYXujgf
 QAVHV6g/qbeLei1v5PMR+QQnYkvCXgKhzAaMq1ilaSRHrettLJadx2CKvGquwL5AH8Dd
 Puiw4RDvCwXvWuJPvKDtAMBHUsFqW/BuPA+lok4RYah6583BXa3NuWnZgwAtxQ/hwPyn
 XmrkUXoia24w7401zo6lkCThQ/9si4e5ZuTaNT1tsiHyUT9zqNqgHg/1pMKEItzhwBmO
 9VZw==
X-Gm-Message-State: AOJu0YyQsxL1lEire/DLZmgfCNCMaWtnMqn1FkSGq4rLp34NoFt6JCnN
 I43wCmVyPHYGP9uN2uFMKv8zxpmGGAfy0JHqe9w8w4IAzzqOoMfUIbt/YJLhBq0=
X-Google-Smtp-Source: AGHT+IErSApiK8GCmvsRxKZYIspfX18j/tTInpHCGdDNcwMfZmkUXAtI4N/4btXSLXFEt62fwH0FwQ==
X-Received: by 2002:a05:600c:3042:b0:426:5e32:4857 with SMTP id
 5b1f17b1804b1-431b564f547mr15996905e9.0.1730203839549; 
 Tue, 29 Oct 2024 05:10:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360eb09sm142290695e9.48.2024.10.29.05.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:10:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3C50D5FB2E;
 Tue, 29 Oct 2024 12:10:31 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 08/13] virtio-gpu: Don't require udmabuf when blobs and virgl
 are enabled
Date: Tue, 29 Oct 2024 12:10:25 +0000
Message-Id: <20241029121030.4007014-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241029121030.4007014-1-alex.bennee@linaro.org>
References: <20241029121030.4007014-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

The udmabuf usage is mandatory when virgl is disabled and blobs feature
enabled in the Qemu machine configuration. If virgl and blobs are enabled,
then udmabuf requirement is optional. Since udmabuf isn't widely supported
by a popular Linux distros today, let's relax the udmabuf requirement for
blobs=on,virgl=on. Now, a full-featured virtio-gpu acceleration is
available to Qemu users without a need to have udmabuf available in the
system.

Reviewed-by: Antonio Caggiano <antonio.caggiano@collabora.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-Id: <20241024210311.118220-9-dmitry.osipenko@collabora.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 3fcc434732..3d9679c1ef 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1455,6 +1455,7 @@ void virtio_gpu_device_realize(DeviceState *qdev, Error **errp)
 
     if (virtio_gpu_blob_enabled(g->parent_obj.conf)) {
         if (!virtio_gpu_rutabaga_enabled(g->parent_obj.conf) &&
+            !virtio_gpu_virgl_enabled(g->parent_obj.conf) &&
             !virtio_gpu_have_udmabuf()) {
             error_setg(errp, "need rutabaga or udmabuf for blob resources");
             return;
-- 
2.39.5


