Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3720BCD343E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:42:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUjK-0001RO-Dw; Tue, 03 Sep 2024 10:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUjJ-0001QO-9J
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:42:01 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slUjG-0004gK-Rt
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:42:00 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42bbdf7f860so36794815e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 07:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725374517; x=1725979317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qXN1HxG78/psUtrRyQwZXCfhfBENbvTH4d7ZUVt9NUk=;
 b=gYGQBiTO10xSQqsW8jzO89mp6UzRja53yh+V0cVfq93GRrV1EsBILlszv/8lUmZbnl
 v6FZVN96XOGggYLLtH2PNejzrvZwVk9krUVVhhPh29cl85JDJE/XYU7FN4+FwMGfisym
 JWfLahV6aEzB8SFLnirZtxDFeIsfak4AMHJO2Fc0qoCIUEh6Az4c/zLRfCAFn2noiuRi
 dHTx0ES72ILFX5uwEIM4QuJo5G3ZWjfpNlVnioesNJGv3lom79m+tOkUG3EpIUfFYoGW
 vtMSwmJg1y1WticeDMzq+pG7t4PeSURtNYhvy7W57Qw72MD2woKyXdJ5grNbyiRm4j8P
 dl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725374517; x=1725979317;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qXN1HxG78/psUtrRyQwZXCfhfBENbvTH4d7ZUVt9NUk=;
 b=YH5t+udfFvyKaR2Stw9/KM2LHxVzePhV9cmOr0IsvbnJKzaTxb1lMy07hXnbLe9f+u
 ksjfjRpL8GOqmiLYKIkQm5fWScXg/1MdckKSY8iNwtX0gH887N5fcke8u8aR74/gunIE
 RZbp9tPmTDBW8NQORWp1PYnVpaPvYvIieAyixzlLXxtgraHinczjGMaSB72qCXbT12rR
 gJ3pim6Ca8L5wF/IQ5TRTW+ydsJVSFAZy3klR+oYG7bpkVRkO4egl7pY+2oQx2n1YNul
 YFy2w4RXEma5V1HznYUcf7M2e6utAiS5aaqldDyhJM3pcV7csD1rNsPucZ5Nwv514v2Z
 tfPw==
X-Gm-Message-State: AOJu0YzqsI3i1hzPsva16dZrVR1hh6jmIYhwhkWyp0VpDE8c+XspIyj7
 Xmt0f5W4xj4q5wqjHdKqN770mcYR7OU0JLwlsu+Kgqh5y3THXRW3KK9LP6I/XDdsMXcyEvWZita
 m
X-Google-Smtp-Source: AGHT+IHJl0DpgQmd7+CfcRAfePYisANGAISFLGel9ozo3HIstEMVQSKKvfiG9/y3QXHVnFkaobvS8A==
X-Received: by 2002:a05:600c:154a:b0:428:1b0d:8657 with SMTP id
 5b1f17b1804b1-42bb01c1136mr130767155e9.22.1725374516137; 
 Tue, 03 Sep 2024 07:41:56 -0700 (PDT)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42c89dca8absm27934635e9.27.2024.09.03.07.41.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Sep 2024 07:41:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Changbin Du <changbin.du@huawei.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/arm/boot: Explain why load_elf_hdr() error is ignored
Date: Tue,  3 Sep 2024 16:41:54 +0200
Message-ID: <20240903144154.17135-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

If the file is not an ELF file, arm_setup_direct_kernel_boot()
falls back to try it as a uimage or an AArch64 Image file or as
last resort a bare raw binary. We can discard load_elf_hdr()
error and silently return.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/boot.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d480a7da02..45d0c6b9f2 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -799,14 +799,18 @@ static ssize_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
     } elf_header;
     int data_swab = 0;
     bool big_endian;
-    ssize_t ret = -1;
+    ssize_t ret;
     Error *err = NULL;
 
 
     load_elf_hdr(info->kernel_filename, &elf_header, &elf_is64, &err);
     if (err) {
+        /*
+         * If the file is not an ELF file we silently return.
+         * The caller will fall back to try other formats.
+         */
         error_free(err);
-        return ret;
+        return -1;
     }
 
     if (elf_is64) {
-- 
2.45.2


