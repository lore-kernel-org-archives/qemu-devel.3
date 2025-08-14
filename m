Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E615CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 07:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umS3S-0007nE-9Y; Thu, 14 Aug 2025 03:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umS3N-0007mm-Ic
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:07:13 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1umS3L-000441-BF
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:07:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45a1b05d252so3490185e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 00:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755155226; x=1755760026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4y63sBgCu89vCOom/Py382syDpCGytaJlBl7QZatZ4=;
 b=ar2d1NrOJzQQTT6qNXYCvXRWO7bzqTo+3OwjL4joaDAzjVmu51NH49gjF0bhP+tqzO
 tm8sEiV8DXVD7mDBWgn1ZxEMUblf8uLfmhjrDS410J5N9xz5TcfXfygHtblyDKYz17rj
 kewrYbDHAPCWi/frzbLfEK4fKiaicpsZmjrG7dgVNx/R4VA1ngLrDedeExT4KK5CvRvf
 2SNmqr10rDmCr2R5wLuUeyQwoQq5IZ9PaNW8pSFIzPjZjMhRPO9kL4eGQuwDaXWc2xES
 yOL1ALQ4rwY9CJoH44oBkIpjVq3vrn44guFykJDMv/+dadOOsTqvpJ+ucMPeixWyu+M/
 CRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755155226; x=1755760026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i4y63sBgCu89vCOom/Py382syDpCGytaJlBl7QZatZ4=;
 b=FgzJHNKYzJWYtK1hk1Y6zbOoAcZh6LDnM3wn0BF7NYlD/TGt5t75Y7ZuplfKVPiqk9
 blzNkIVLEffIGgN7fLJaqSz5gzXiUr6QpzYJT2xn4cQyLhleFXxSQl9alU+z/kpr5fSv
 b5jzct49vzUOwwYPYYPk9WFv6wJGQyDYV6dp81xStPcAw/pO2j3yWO6BNDfL25N5M1WN
 2aLNc4nLQX/Y40kcZLYovKUUaX1WcCvbgXfuhC7+voJFyLRllCkHlRhjw4XaqmUzhzu5
 jyE/KSQW8B2EAdSlk48JIY7zBXjrZAQzrrPnTQDV3WIDePtp7UCd+LPXdsN7MzYYaamV
 yLNw==
X-Gm-Message-State: AOJu0Yy9JVhPRrGOaemiMcAvLSTLbwYzjdWP9rY93v5Qou9P8lkSVl1b
 7L94qKgLDXfjBhIQJDC4fCjOyYvDqgeoQntRvtJHEVGpd682xqCZ22+jHGHILvS0s7iFS9BGQmZ
 eFJIa
X-Gm-Gg: ASbGncvW2aaIwZuY1369NZ0ml3EGsVoGW2bhTHU7wvoRWFEBBwQWDHczwleY/rJWpWA
 LGvVx+2iWw3EAShgHaaPCnqT3QzBBgecp8WkftBqHbs06iqwoQ7N+ZdX/DUEJIjMpMZ4U7fVml9
 qhOP2JeJdQ5+ObdKGZaXYYCUx94FHmJujAXG216lvDip520p3EQTGlNwVR7IMFnkpefx0vOCGzc
 SeDWGKXy2I150HDY0tLUQwHtXyZc85TE0pZ4rwTQDJ1brR/44ci7GHcvpOGj3aMo6ZGjtqCwnm4
 KFhZ9RFEiADqi/L/sGToFtXoTMX5rb/Xz6z/aiVt3QnQpBipjtEP8wZ+oODPHZ3njZ4BUEHynVo
 4BamFLQ18GtyAa2thfA3xZitHcp+f6Icc3L3LuWMzT0VJYiXjT/KNv+XeXZGWyerv1IpBLdNUN+
 DTTg==
X-Google-Smtp-Source: AGHT+IFKXJIz5zcyL4jaE8iInG6mZfVeUvQpw491v8UPaUFnbdvUEQi/FZA/txeKOwoXC/O7r2xMFA==
X-Received: by 2002:a05:600c:b95:b0:456:11cc:360d with SMTP id
 5b1f17b1804b1-45a1b61b6a2mr12995335e9.9.1755155226162; 
 Thu, 14 Aug 2025 00:07:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c70cb83sm9638845e9.27.2025.08.14.00.07.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Aug 2025 00:07:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-stable@nongnu.org, Justin Applegate <justink.applegate@gmail.com>
Subject: [PATCH-for-10.1? 3/3] linux-user/mips: Select M14Kc CPU to run
 microMIPS binaries
Date: Thu, 14 Aug 2025 09:06:50 +0200
Message-ID: <20250814070650.78657-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814070650.78657-1-philmd@linaro.org>
References: <20250814070650.78657-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The M14Kc is our latest CPU supporting the microMIPS ASE.

Cc: qemu-stable@nongnu.org
Fixes: 3c824109da0 ("target-mips: microMIPS ASE support")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3054
Reported-by: Justin Applegate <justink.applegate@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/mips/target_elf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index cd8622ce283..d20c6080cc8 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -12,6 +12,9 @@ static inline const char *cpu_get_model(uint32_t eflags)
     if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_32R6) {
         return "mips32r6-generic";
     }
+    if ((eflags & EF_MIPS_ARCH_ASE) == EF_MIPS_ARCH_ASE_MICROMIPS) {
+        return "M14Kc";
+    }
     if ((eflags & EF_MIPS_ARCH_ASE) == EF_MIPS_ARCH_ASE_M16) {
         return "74Kf";
     }
-- 
2.49.0


