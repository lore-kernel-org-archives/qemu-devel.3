Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFFEE68959
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 04:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6MhP-0006ZI-9r; Thu, 31 Oct 2024 00:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MhN-0006Yv-IT
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:22:17 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t6MhL-0006qs-T6
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 00:22:17 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-53c73f01284so637502e87.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 21:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730348534; x=1730953334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wD31lxn0+ab/GE8FyDVCBUwUXNUGOzaYUAIP9ie+DaI=;
 b=ot405l/sRPbjhJqfKpWaRQAn9iYK0BCNrQ3eYAVdwGk0hplEzDwbQabIQpDpWtO/LU
 Q1e40I/1pAzKJ9aVA5oh85Qj5yghA6EtJ3JUwmffctH+SEHxzXMc+Dpp7rsF2Kc1Ki0m
 1ruW2yDQ1g/FxBnixIFgLcjtJjgAyQ6DQNnxabNx+BlZ6mW6k62Ksozn0XS4jM6r6vwO
 fCiLE7iFW+d0DNrImRnSRhNTpJ9HPVU3auyzWka1rZgXgW5IP+LJ+/mMTBxhBC3YXwS+
 EDVX1vVs2qqci3vNxOdORoiIzn5Tx6vwVDfiX8CXD4Ste8+7zCM8E53gfkyhWuIc28Qo
 Kahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730348534; x=1730953334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wD31lxn0+ab/GE8FyDVCBUwUXNUGOzaYUAIP9ie+DaI=;
 b=YebH8tYkTralwbdecwaxrfCj1uHy0srBjoFdAAlTbu4tnce1E995sOPJo0O921mw/K
 0rSX3u2GwMC7DU7Q+GBOnfaxDZZ3HuB8oXxlAUZ6xDNhcGDstF6fd1Fq5zyXMcydCF5U
 c4pkR7vF0yDTHqKqFoICLBal4/7kZC+UqHE1FXw5tDsNdJqEO36g3986BU8qhiITjZa+
 hOIPy9meDIg0fMz1Zu+MP3Os6LDtDc++AsI/MCZdnK7a98IVa4H95bMGS7+55ogXVIfX
 TKtdIx/zZtkS8WArqeK80mPKgaLrhrSYEg32GnDz10ImoUfHg8a7/sU/Djri26YZ74DA
 2zJw==
X-Gm-Message-State: AOJu0Yzz0dzDvKFlhtm8gdBOltZF1uQ+o3tTNcnzeeXWZg6sIXLq0zIq
 fZqbb/dBqVvtZi+BcEUs/r0ZKI64c/oELjQpq8OlAisBZn5E+9zRecroZlfKkVcYLKTLSa9gJtc
 l
X-Google-Smtp-Source: AGHT+IGvCLGR8X0HpPg94V/VP0xEjJaKkPTpC8F7x1Hlm0f1arWoY402Fv/m7oAZOzHifmwuTlt8UQ==
X-Received: by 2002:ac2:4e0b:0:b0:539:d2e2:41ff with SMTP id
 2adb3069b0e04-53c79e3254amr793241e87.23.1730348533491; 
 Wed, 30 Oct 2024 21:22:13 -0700 (PDT)
Received: from localhost.localdomain ([91.223.100.208])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53c7bdcbe17sm76195e87.197.2024.10.30.21.22.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Oct 2024 21:22:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Faraz Shahbazker <fshahbazker@wavecomp.com>,
 Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/14] target/mips: Enable MSA ASE for mips32r6-generic
Date: Thu, 31 Oct 2024 01:21:18 -0300
Message-ID: <20241031042130.98450-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241031042130.98450-1-philmd@linaro.org>
References: <20241031042130.98450-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Enable MSA ASE for mips32r6-generic CPU.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>
Message-ID: <AM9PR09MB485153B7CB706E188DED763484402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu-defs.c.inc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index fbf787d8ce1..1ab026c57e7 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -478,14 +478,15 @@ const mips_def_t mips_defs[] =
                        (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA) |
                        (0 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
         .CP0_Config2 = MIPS_CONFIG2,
-        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_BP) | (1 << CP0C3_BI) |
+        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_MSAP) |
+                       (1 << CP0C3_BP) | (1 << CP0C3_BI) |
                        (2 << CP0C3_ISA) | (1 << CP0C3_ULRI) |
                        (1 << CP0C3_RXI) | (1U << CP0C3_M),
         .CP0_Config4 = MIPS_CONFIG4 | (0xfc << CP0C4_KScrExist) |
                        (3 << CP0C4_IE) | (1U << CP0C4_M),
         .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_LLB),
-        .CP0_Config5_rw_bitmask = (1 << CP0C5_SBRI) | (1 << CP0C5_FRE) |
-                                  (1 << CP0C5_UFE),
+        .CP0_Config5_rw_bitmask = (1 << CP0C5_MSAEn) | (1 << CP0C5_UFE) |
+                                  (1 << CP0C5_FRE) | (1 << CP0C5_SBRI),
         .CP0_LLAddr_rw_bitmask = 0,
         .CP0_LLAddr_shift = 0,
         .SYNCI_Step = 32,
@@ -499,6 +500,7 @@ const mips_def_t mips_defs[] =
                     (1 << FCR0_S) | (0x00 << FCR0_PRID) | (0x0 << FCR0_REV),
         .CP1_fcr31 = (1 << FCR31_ABS2008) | (1 << FCR31_NAN2008),
         .CP1_fcr31_rw_bitmask = 0x0103FFFF,
+        .MSAIR = 0x03 << MSAIR_ProcID,
         .SEGBITS = 32,
         .PABITS = 32,
         .insn_flags = CPU_MIPS32R6 | ASE_MICROMIPS,
-- 
2.45.2


