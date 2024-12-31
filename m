Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF47E7718B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSilx-00034K-TX; Tue, 31 Dec 2024 15:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSilv-0002yJ-46
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:23 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSilt-0000rV-7q
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:22 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-436ae3e14b4so11279855e9.1
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676599; x=1736281399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YOJaY0d1Ex8WD3TOwLpxywEdEMi/4x2kRkhM5+bgzLY=;
 b=HOMwW6T7+m/tJ/D/J6OCe/kFymO1rYbQOIuZDaBWw7VNcUeWK6+lcq/bbwdjgMKz6R
 AyXxGx16yIDL44J/kqNTDdfSzBqiRtNgCVTxyxgcPBsT8wExRdbHPWyNSmNeVv0UZRhB
 TAyNgaZdGVX0a/1MlZ2lEVvzkMPS45n9U/Dkj/cRyMZZcv19+bXQPBPMAetjMurPRMEV
 L6PiKksQz8jk/dRYsN6MV9/wiQHP3K9qVcaz5rXYHYhLkWiO9ogeL8umgyKEDWX/dpRm
 fXle0SEBjwkxZldwF6bxsP/4cMLnZSJavDDpfNF+/mi0h7z41N/9/boiQwLaFOd++3Lv
 ZhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676599; x=1736281399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YOJaY0d1Ex8WD3TOwLpxywEdEMi/4x2kRkhM5+bgzLY=;
 b=fzh7CcQTWVqz0gSpG+aOAfdFUqH07hNqTsFDcYR3v0NuC1SDFZpgXIKTVpl1bLwlAC
 WjjsMu/oMYpBObBsko6HDNLCl3q9KwPrXsa2db7nJatDyhc1naMPI6xYch/CPmS35MtL
 TCXQnG4sSIDeiYOcqfXG5ZLJ2c8htcLy9/xh4t+tJz1p3kfwCN1o3RkNEzagI/fDYUt1
 r+TwO1TDKTzGIBVP+ElRnAP/Egbtmb2uEIiY2XphrXpIt6mO1vb3pAJQSnx8GsVg5Ojm
 3waLEe6EsweWd7gYVAQSGs4ZWSFoBhGwaO+ocZkyt6nvf+FQ/NpG1Xpeiy76U2c6lyul
 3TTQ==
X-Gm-Message-State: AOJu0YxSGmq5HlI3N8D2sJ81H4I8NMIuZV6PhVYzMpPjKf8VT9R0mDBe
 V0zG7aL4XtD/hTpl/PGFX7KtTgMm240bC5n310J3KX9l4MKL621lKsZnOIRAvYECsCTkrizWXk7
 x/yk=
X-Gm-Gg: ASbGncti8bMRHNEmFc1ysEzH4xFfTnEGHX4OsJ1bhePOtybrUsWASMUm7FUJ+I+vvp5
 /SDKOUSzIK1JUol3EE/n1RRRj4xQpDCz4hF84Dj6P9Kn7+RNJYR5N5XJ1B4E6o6b/PdY2NucaNp
 Ww0o70mouc/xZV06fLOeyhDYtuSv8kdm20WyU51MuUcz4h4dMO4HIsusmLVetxK8b9yBQr+bsi8
 vFj3KwwlMdYCuLZ4HvTaPcLtrme5fQpK47Jfn+s8sQtWAegqX4wNVSiNjfPLIYGY3TKZjUWRcK0
 ae4aPIqn4uEjYyAW4zoDQl41cjPgON8=
X-Google-Smtp-Source: AGHT+IGwfggwqt5lOH83QJoVJVqqLzRxclJtizeH4a1fXWudLbx92Fhfr0NqhZnAVZ/4CfBnkNwi0A==
X-Received: by 2002:a05:6000:1867:b0:385:df73:2f24 with SMTP id
 ffacd0b85a97d-38a223f5cd1mr36018908f8f.39.1735676599318; 
 Tue, 31 Dec 2024 12:23:19 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b42757sm437392675e9.39.2024.12.31.12.23.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:23:18 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/29] hw/sparc: Mark devices as big-endian
Date: Tue, 31 Dec 2024 21:22:09 +0100
Message-ID: <20241231202228.28819-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

These devices are only used by the SPARC targets, which are
only built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
definition expand to DEVICE_BIG_ENDIAN (besides, the
DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
using DEVICE_BIG_ENDIAN.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241106184612.71897-6-philmd@linaro.org>
---
 hw/sparc/sun4m_iommu.c | 2 +-
 hw/sparc64/sun4u.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index 8c1fc82534f..5a4c1f5e3bd 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -238,7 +238,7 @@ static void iommu_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps iommu_mem_ops = {
     .read = iommu_mem_read,
     .write = iommu_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 5778709b412..0980b446593 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -254,7 +254,7 @@ static void power_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps power_mem_ops = {
     .read = power_mem_read,
     .write = power_mem_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
-- 
2.47.1


