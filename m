Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92EFC3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 13:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seEEP-00074t-Q2; Wed, 14 Aug 2024 09:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seEEO-00073j-4j
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:40:04 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1seEEM-0004RB-CE
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 09:40:03 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3684bea9728so3910054f8f.3
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 06:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723642800; x=1724247600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jxLHqx+S5C+GI1KIVnOAvNeyCE7KTQMJVIjAY6qG4kE=;
 b=M1JdrgpRAdN78DDRdwZPpPQ6Rg2uIMpne6tJIlimLIaVcRbH5ucqqfewk9HSm2nupo
 06umrhXuUT/GtIkaA04cNOAvB7TWKA8ISJphj13WrQgjW4hlcVNuFpwFIusGdTwkjzc9
 U+COr1Uml0kAmD5/wojJqM4pcNmOQEk1wkyNOCfw6tm1PwFHUfJp3dFlYHvRL4mbzKmR
 gTJf+/b0nqkdbX7VonjOVQUqhA2fx3SIU5CN+ZVcE5WTE9Qdo3layuwPJEP2Xok3l8X6
 HAUwq0ZfFCXFD/KGPoDARygWptYeRqkVXhbkMCdln1uFqh928wqrL7by6xo25eoj/hRd
 4jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723642800; x=1724247600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jxLHqx+S5C+GI1KIVnOAvNeyCE7KTQMJVIjAY6qG4kE=;
 b=LOEDR9aIVdELHweDaOslm1F+L9AoMW+wfw4lK/x7MFtHcDHK/kuaz3PbHcOMmAM/La
 5Y6KAaFAHF9MCD6DESnaJX86FX3ZT2RZe7oNY/xfwa8vm3u8QkdxjEbNBsmXQ1oMAECt
 1XTpynICXHcouVCM/9Ruuo3WPxefiASO9hUdPP+AxMdfn0/TaAUFf91NaMpjyqQ9hpwp
 v6DThI6fXzTmE9xMjcOnMlDliAiwktKOe2H0gAdtm/OEX3awfQ9fH0hwmuBKq9WUx6xS
 SNAgyAk0uEEWJIkUPnxwv4Imf0Fc2KdlXHMMQA3v5TAurF1h4MSlgp/iWi4+E0KsTI+M
 e7Vw==
X-Gm-Message-State: AOJu0YzmIZnj/XEm1Hwz++VWsmRPqyAj7SlW0HxjMSwvYP/AD8z+W6W7
 Le1Er9PcqUEHfMRhhXjmzNdQNP9z3jTiM7Py1IoROkHadofTC0PdbbKDfhJD0vk4YHk7E9CN+k4
 F+hY=
X-Google-Smtp-Source: AGHT+IGpWkFi07doCplbrzZz3dDjDbBNd+a4oenVB3ShtBAM2SIzkFdS4igdKIPRnNpaw4/eIWu+3g==
X-Received: by 2002:adf:fa4a:0:b0:367:8ff0:e022 with SMTP id
 ffacd0b85a97d-37177837cb2mr1780181f8f.63.1723642800475; 
 Wed, 14 Aug 2024 06:40:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.208.57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4c938280sm12912096f8f.36.2024.08.14.06.39.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Aug 2024 06:40:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 YunQiang Su <syq@debian.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Johnathan=20H=E1=BB=AFu=20Tr=C3=AD?= <nhtri2003@gmail.com>
Subject: [PATCH-for-9.1 2/4] linux-user/mips: Select Octeon68XX CPU for Octeon
 binaries
Date: Wed, 14 Aug 2024 15:39:26 +0200
Message-ID: <20240814133928.6746-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240814133928.6746-1-philmd@linaro.org>
References: <20240814133928.6746-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The Octeon68XX CPU is available since commit 9a6046a655
("target/mips: introduce Cavium Octeon CPU model").

Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1722
Reported-by: Johnathan Hữu Trí <nhtri2003@gmail.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/mips64/target_elf.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index ec55d8542a..ce6fb6541e 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -9,6 +9,14 @@
 #define MIPS64_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
 {
+    switch (eflags & EF_MIPS_MACH) {
+    case EF_MIPS_MACH_OCTEON:
+    case EF_MIPS_MACH_OCTEON2:
+    case EF_MIPS_MACH_OCTEON3:
+        return "Octeon68XX";
+    default:
+        break;
+    }
     if ((eflags & EF_MIPS_ARCH) == EF_MIPS_ARCH_64R6) {
         return "I6400";
     }
-- 
2.45.2


