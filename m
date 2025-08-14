Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2976ECA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 07:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umS3L-0007m7-Ci; Thu, 14 Aug 2025 03:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umS3I-0007l6-9n
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:07:08 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umS3F-00041o-Ri
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:07:07 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b9e4148134so292336f8f.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 00:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755155221; x=1755760021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5JW+/0ItkEipJlqLSPg29sThOTAq485WSDBW9nj3d0k=;
 b=IIRbsEtIsi4TBPlNJXn2Vw+M1JByU6ldRzeCvdA+/GCprzSbGckJ7tlDpwmNdvTVtu
 4aGBGHoTWGy146vpmPJG0lZayZQndbysP19O1OzCiatyU/1olcpNAePuOVSM/KzbXl8h
 dMKNj7pqjINaT1h+AuFDn9XusqPj6kuFpbYTgsgC1N+Xqw4wk28qJcJ89f+6HW4zudDr
 kwiH7SOJGAbA5G4AU6B+YI7cT2x/YRSsfUgLVwKMZkLN7KKgzFoJ1Z0OWaUQ6sLd8PnH
 cnP23+HAGsufUz92k1dwgMKU7V1Z5MadQTTgKOe/v78AIG3Tt5CusUAI1oKwoAWqNeSB
 reGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755155221; x=1755760021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5JW+/0ItkEipJlqLSPg29sThOTAq485WSDBW9nj3d0k=;
 b=YA+c4ngCWE8+gpE0XAXLHgz8fY7KYqQIpyvvctgnOgjg9Yq9pE9dRuMwcYJTclHn01
 iOZeQeHJlV9w7NMzNbjuReIPu8QqupTfyrs9BwAAx+XI+3OCbvXsEBaw9XeXjGVfMAFH
 gSzZQUmyARYh0kGOaP9rDF4n5iu/5E2qFtBO1h5t3eCrc6nKs47Rp7BGFCnGPFgbOcCd
 j7vF7KE7dX3xZPF0Zp9pgdqcDeGwa6bdJNt/6+2xKdmjWVnJmYF/N+jhTzYApbVMHbp7
 6kuIB7Hl6kAKcUV3zEAQbjgh237Iqx5mVYBuMwa4Ry2LFccHZM4/GY61EtnFo58GDsUM
 7QTg==
X-Gm-Message-State: AOJu0Yxzb/b7NsSFLYCUqTlBu+RdI8yeGsfYWnkJSQv/01Ld1cUu6e2V
 lB36L8+hxIxnTgnQsQwQt/s5laMSGsWecdSYtLdA36DWkkFklsOz7tWjoU0MJAScFcU9Q5Jdjf8
 ngx0n
X-Gm-Gg: ASbGncvvYsgTiBCHBpPSgJEeffIQHPg8amn4+X2eaLfM2/fQ9E/JxR2qCrCj3rIT86B
 LL6B1zkNAkd2YDv+GF18XNiHR0FASzfeUVo58tNE2k/ud5hOVW4yYxl2CWreZZyyyfm/HZcN3iJ
 hj/gyhwvIp+J5AOAxATb4lJItU6x9AqBTEYvx3WWeTW3ltitLnA8R01/4F46vD5wuoEzUr+/M6L
 YIamMA8iTCIORlo5+RiQp4Va0Beowjn8jQDSHqk7Pp8BMEGihetQM9Xcu0vEoyP8sNmWyrenqNK
 LfAcwOO4eXF5REeox8dPu1p/z+MYLxQBVbQdnFePcsGExwkZzqNOoE7iByGIPjtQTNgk0D59hgY
 SKd5S5D9iIT4h8HGV4h430t1zper/IINGWCzCS4pCrZQusl2mksQVc8x6FSIweuUzCgzeVnghlp
 SHkg==
X-Google-Smtp-Source: AGHT+IEHUUk5S9DDVcjkfWJATnf2kgCHWy8qgjco54AwiGxXQbCcYlw4nA0WQq2Ea4V28zkkypx+pw==
X-Received: by 2002:a05:6000:2510:b0:3a4:d6ed:8df8 with SMTP id
 ffacd0b85a97d-3b9fc340f86mr1460034f8f.39.1755155221425; 
 Thu, 14 Aug 2025 00:07:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c6dbb51sm9964065e9.14.2025.08.14.00.07.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Aug 2025 00:07:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-stable@nongnu.org, Justin Applegate <justink.applegate@gmail.com>
Subject: [PATCH-for-10.1? 2/3] linux-user/mips: Select 74Kf CPU to run MIPS16e
 binaries
Date: Thu, 14 Aug 2025 09:06:49 +0200
Message-ID: <20250814070650.78657-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814070650.78657-1-philmd@linaro.org>
References: <20250814070650.78657-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The 74Kf is our latest CPU supporting MIPS16e ASE.

Cc: qemu-stable@nongnu.org
Fixes: 6ea219d0196..d19954f46df ("target-mips: MIPS16 support")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3054
Reported-by: Justin Applegate <justink.applegate@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/mips/target_elf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index 71a32315a85..cd8622ce283 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -12,6 +12,9 @@ static inline const char *cpu_get_model(uint32_t eflags)
     if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_32R6) {
         return "mips32r6-generic";
     }
+    if ((eflags & EF_MIPS_ARCH_ASE) == EF_MIPS_ARCH_ASE_M16) {
+        return "74Kf";
+    }
     if (eflags & EF_MIPS_NAN2008) {
         return "P5600";
     }
-- 
2.49.0


