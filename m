Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FAFCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 18:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNkR-0002VZ-KY; Sat, 30 Aug 2025 11:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7cD-0004zv-Kx
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:39 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7cB-00041g-Qw
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:37 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-771f90a45easo2235600b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506634; x=1757111434; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lowHNs0QIQ4pb8gQYo2rhZhqRLDHpO1LE/Cpq00H8f0=;
 b=ZFemviTs0Alg/ZdcKrwhTUImlzJ2SvrUfVWQ0CEuuBQHn6anrzfkfQa8cHz2pvmeAz
 YqATdjZDg6c4XT3wgDiSlu2vfpU/j1v1tz9FXaObcZ8oj5kUGvT8EdrzOgKaT6UTSCr6
 42uI3N8czC+Tt9M2Za3wyD46E2irPHGJt0qoSeu38jfrGl4/SipbK48hCNOzCJq+K+k4
 kKc21iatN+uloNx0fVnDTsX4aO7O5lNsmk3CRb1FKpDQbmt2UUvRqH0u1Sq/tERBnA4Q
 0u95I2gb3LZD89f4eUnz7w5V+xEWin2YUz+G1H+V7+GnLFBHGfuy122vFBNSv92GLp+y
 gZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506634; x=1757111434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lowHNs0QIQ4pb8gQYo2rhZhqRLDHpO1LE/Cpq00H8f0=;
 b=YofYzm+/+b4g3oRRUxweNilV2bwnpdRQnz748ZULNQEwqAkSVamFLGkc+xBGY0vjpd
 yBe08QxMAYl/zaSByGm9e6e6y15teD6zQilmpSchWnQy3hl0NPtBcvByN2ow58lSs/Jt
 DqWAMraJwN2xB3NBqL8iTgBneIX5pRuPEBk5AIAChMDR3OS8Xgh0I6+x56tmLobi0o97
 VdlLjipMb+TkLLLmJHeBvJGb7d9N0cxD1zqMvMZ2+26eU2b5DlIsX1Sm3NVcVXu0cpNX
 5xJyuZGwRRSQeHhDk08mBn5z1pQf7+Vn9J/h82v1LUFMuDmlrcjHNUsK3OV9DsRQhHyX
 ++xA==
X-Gm-Message-State: AOJu0YzERC2mAyv7iWa2gBUI7MsK4kDIGuTc2XOXZvYm0s6dkBoPrBZg
 NTUYdl88vWyjsUD3FYnNSumv5q4MKAChqTDKhqdQuVXcPTWmC8QjkO1rdMRz6tKt1l9qQKe9jxU
 iDx9ldeI=
X-Gm-Gg: ASbGncuuW/Frc87ZROLEvZnSW4jCIU20KhJXt0+ohYrzmIqyH3gLQ4jKaJCRmxoZ2W5
 46Ysrvu5CwmRgd7Aa49QtMV8Uh0SfYemCUcahRlfQ+5Jb2HX9u6SZ4CRoCldM0PzPcPrqLX966i
 7bklpDqgJjHNQX8WRq/poDatL+UWdFXT+H545IYOU1nT9xdwdAj3FsrEw4mFv/xH3NHc6ghg33Q
 fqrzjIMBaFiyEK3Gwd9ggKcfab+ifmrxpNurfhRGX5dDlBAo/usgPQvYl/oY50nB3gxGghlU7Gs
 w2JJLkW0NLSNFndhd4xkU1n00NcWpPG+9eYwV1ntPKU9XhD8rKqLL+i5Tl1qxFC+fOLmnjQcnGK
 DlA5VFkJdTKOwnzkxySpYiSQtRM9MuZuyzO1j2CrMXD/6KYuZxvXiFUuPF/25/aw=
X-Google-Smtp-Source: AGHT+IHVPuJYhQjRxJNIkWzGnVz47GMqSwcr6dCnUDpBo3EL+TR2CsSecz9fTUDA7SfSj/ZioM8UIg==
X-Received: by 2002:a05:6a00:14d6:b0:76b:c9b9:a11b with SMTP id
 d2e1a72fcca58-7723e21e594mr291155b3a.3.1756506634329; 
 Fri, 29 Aug 2025 15:30:34 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 75/91] linux-user: Move elf parameters to openrisc/target_elf.h
Date: Sat, 30 Aug 2025 08:24:11 +1000
Message-ID: <20250829222427.289668-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/openrisc/target_elf.h | 3 +++
 linux-user/elfload.c             | 7 -------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/linux-user/openrisc/target_elf.h b/linux-user/openrisc/target_elf.h
index ad80e4b41a..ed9739380f 100644
--- a/linux-user/openrisc/target_elf.h
+++ b/linux-user/openrisc/target_elf.h
@@ -10,6 +10,9 @@
 
 #include "target_ptrace.h"
 
+#define ELF_ARCH                EM_OPENRISC
+#define ELF_CLASS               ELFCLASS32
+
 #define HAVE_ELF_CORE_DUMP      1
 
 /*
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6c8771d804..d0993621c1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,13 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_OPENRISC
-
-#define ELF_ARCH EM_OPENRISC
-#define ELF_CLASS ELFCLASS32
-
-#endif /* TARGET_OPENRISC */
-
 #ifdef TARGET_SH4
 
 #define ELF_CLASS ELFCLASS32
-- 
2.43.0


