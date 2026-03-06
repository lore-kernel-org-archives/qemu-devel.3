Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB89FCC068
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybDJ-0005Xe-ED; Fri, 06 Mar 2026 14:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCV-0004E5-Bz
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:09 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCQ-0000SL-5l
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:03 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48374014a77so115644695e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772826661; x=1773431461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QaOr02l+PpVLKCER1liS5P0axb5tYfgZOqqZ3SJhCzo=;
 b=bseMgFIp0tEYFUHU8xYJ1gr+JgcKPMmWQs29Kn6m+0OEliGbSQOrxbEKKMyID07JDr
 caNu+MfXg0tOQmd9CMMRYsXBdvvR6H2D1p2SbjViYWA3BZm//RmKGmX2r8NYExLijf/+
 /7K9525TycLZXDRll1uHZ+NiWGdQPtnua4UuCMwcuSHscLj44E00IkNTZmF33RpuxE/e
 70h33kbtVjCBLoVJgP5DMhAPjZl2Kul3W3zHEN/se7o08QRuxJPXuyDYQEzhkyNRUXVe
 ZLTo2P4TF0Nbf2TIffAj0cx19q8FQDQVZTqkvJsTx6c9TYGzrEiLwgMEzsOi6LcPaqAH
 Rn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826661; x=1773431461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QaOr02l+PpVLKCER1liS5P0axb5tYfgZOqqZ3SJhCzo=;
 b=mJjHju44OJ23vQg3iq1fzT3MwaHAr1ZuMXgSOf3yrWHSFu1Wg7BjLBwv1kpHRj3wa/
 HcXbl6H93grwu5CoBuvqvslqhkmHKh8Qe+uKjAWTak0LukEsYWpdxa+97fqMSHFVqOcs
 uxWmlwH+aetmUp1Jhp+GbjQOEtVSeU1zbpuU8uAn9VJ7/XQ60RqEQ4K+077tg1zZR887
 S3rtyk91ABrQxRbSKhWwrKwnrvKK7kdPQpc9+bsNjcOQtboHPh6E5WJXNx90YR2OJD+0
 sDCu+FpAhzVHi4vO8Rn9LwGicLengMPqbiVBk3f1zBEVE2/sB+PBV9Ls2H5j/Xf/4oVr
 12Ww==
X-Gm-Message-State: AOJu0Ywvne7rfCdsedHIroq+VyxV3K7vDL1jMBRHBfRdUXVuAmxLj8iU
 l8HzWBecORuGEpmV/aon2qkwIKmVcvow0WaUhGKmzz7JORYaOEgDIx8Gkl6rOfpLMv4=
X-Gm-Gg: ATEYQzzsIUIrEdg8PCP1YOtkpdBTiPS3vJu4NewvgxkO06h4KVLMbvYqFAM29QJEX9U
 Ws6dhLbQaHqZV29ZQl27i/U/QckG6xSxqYnSVJ01Z+YWPFEqklAgWg5Pu0us/KdW7yB2siKccys
 317Z952jrOO3oMoqA0fsESlBQV6nSxjgQv+k4EPVDts/CqADC565TJVJp82zulz5EjxvGRZileE
 3OzMZaaboYkAg2cRuaYeeE4p2O4O/Pgy34XZ5sVIhVmHP6PwqmPB2VRPvE4h+GIwyrqt9wkUkUd
 JesDcdR5zFjgtxjdi48OplXyHsDKtKy/7mGRbRRADQyPc20OC2bQy53hvWtGiPi4UxmdFtvIXZ+
 4GKWcfPHVq6M1E5s/VVnfiwYYDiBjHn5JlA9mjy/7o8zra2j9nbnjcvvce1IUnlU3j3MQpHTA46
 JYLesHTJycMgJPWjdDP23FAtc=
X-Received: by 2002:a05:600c:1912:b0:477:b0b9:3129 with SMTP id
 5b1f17b1804b1-485269188b8mr58494245e9.3.1772826660565; 
 Fri, 06 Mar 2026 11:51:00 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852aac79b3sm12200045e9.19.2026.03.06.11.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:50:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3289F689DC;
 Fri, 06 Mar 2026 19:50:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Yiwei Zhang <zzyiwei@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 13/20] docs/system: virtio-gpu: Add link to Mesa VirGL doc
Date: Fri,  6 Mar 2026 19:50:40 +0000
Message-ID: <20260306195048.2869788-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Extend virtio-gpu documentation with a link to the Mesa VirGL
documentation.

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-12-dmitry.osipenko@collabora.com>
Message-ID: <20260304165043.1437519-14-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index 086e2fcf27b..89153103b9f 100644
--- a/docs/system/devices/virtio/virtio-gpu.rst
+++ b/docs/system/devices/virtio/virtio-gpu.rst
@@ -61,7 +61,7 @@ on typical modern Linux distributions.
 virtio-gpu virglrenderer
 ------------------------
 
-When using virgl accelerated graphics mode in the guest, OpenGL API calls
+When using `virgl`_ accelerated graphics mode in the guest, OpenGL API calls
 are translated into an intermediate representation (see `Gallium3D`_). The
 intermediate representation is communicated to the host and the
 `virglrenderer`_ library on the host translates the intermediate
@@ -70,6 +70,7 @@ representation back to OpenGL API calls.
 .. parsed-literal::
     -device virtio-gpu-gl
 
+.. _virgl: https://docs.mesa3d.org/drivers/virgl.html
 .. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
 .. _virglrenderer: https://gitlab.freedesktop.org/virgl/virglrenderer/
 
-- 
2.47.3


