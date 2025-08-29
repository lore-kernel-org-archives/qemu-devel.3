Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BE3CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:00:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNmU-0007XD-Ip; Sat, 30 Aug 2025 11:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7c9-0004ym-89
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:33 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7c7-00040U-FF
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:30:33 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-771e987b4e6so2093729b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506630; x=1757111430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNzxAeN5cYMiVF+TCph1Cnt9S/tSQ/8beWQa5LB/yac=;
 b=L2HF5bKsoj1jCuz7Ubg/v/U87FAzc9/1gbCUG6pY9QPjaYVTWr3eGMDjvsleo/Xur/
 sFCiUUPFeAM7N2oSljlw+lv/ozip0/ES0jb0LalLZEIZHLsEXRnT2sULuaz8QhtPNgrB
 bS14+FMmL6bBWphX7a2XWusY0Ts+fM9eN286EMsvlud08tiUkIUHwpbUhCLesTLYSxzK
 i3+w2T0bZg/7bspkPdW06An/cusXN9lPYVFLNEFSpeGbibYaCQNVtpOE+hBqf/WNKGef
 ButuWKB/DWhfcDmjxfgR4kOWCevAlKuWEDkHI3zDmClTPzQSloyEKs5lNM5wP1UGUQYr
 9jMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506630; x=1757111430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WNzxAeN5cYMiVF+TCph1Cnt9S/tSQ/8beWQa5LB/yac=;
 b=icPqaZWTsbCh63xrvYtvshNpCULXLLu1xz4I9Vy0fAVeKVGwpMeuq96cjBgmZEKo2O
 GchMh6Tr5ypO+n1VW2KorgR2loNmQGjqAHPaxQXEjp2JI9rK47INiSmPtJazOGHNDTuw
 zSu6nChqwGgE72btPXzlcwN2ZQ4cWUgjCEsDErmOT30bQELG6xoMfaWClYtnTgVQQsve
 2Z+5H5LAltXcaW8UNE2PsbzJ4FX14i/Mk0+mogkiobq8ENFhQj/jfTtYxWdBsHi7ugZz
 FtYPdB/j1yksN9w66I7kuvIczCSxi17O4QTw0wjlkYioJyJZJroCbZIig6G+9hubpaeK
 GxHA==
X-Gm-Message-State: AOJu0YxtIlUI9v80bSBG0lkbX7+cflU9n1QyOl/Fp5SMolaLJ4w75XMh
 Hx0jY9iyehD31t1zoYgbg23cDgfn4JkZh65MKJEBSRcrj/6KgEFqDpcFV2pXOpiz9aKSUOvikgc
 Pa8AcP20=
X-Gm-Gg: ASbGncvUUh0dpF7mo/dDC20fkm5Vljp7wd2MmwQxU3WnFXX3VJi9+xgscL+vkSKt5bp
 KkMGydQxrlfEYIkfX/RdeEHDJM4evC1DuF9s4BojFWa7EM0/qNE9roPRWdlzPv1h5Refy2J/UBw
 zMVBfcR+4o7whlZNCIbD8r+kk9cLfE8keVwnPhRK6LBYcLMEJ4vlJNnNn4I8rOYlmrGOIaHicKh
 vxmcn5hSFxv2ZIhrZwm3eaOhzFOjR7dh38sB3L1SEN1q2XOZVYbr5SBx2BUwd3YPmiPC2b8VNc4
 7Ccyg/CMuDfzJPFIkzorsPzlpaKaYcJZVcRqsw+CVpMr/b+TavDgRGm+jtjf6VMFnGaAxsH0TG/
 rlDc+pksmVu8vNMbo+OPBm9IHXG32QBD9TEDRjU63f2EPVoFhEWecKs+2rlf9+jwKi6Y9qiVcSA
 ==
X-Google-Smtp-Source: AGHT+IHPB3d9t3uZ0w7HXkGZyhm9/Ho4SYmyxATfA/XPEuDPuXmBU+7f3UUkc4AIFJPuZsKA+1MEKw==
X-Received: by 2002:a05:6a00:240c:b0:771:f8b5:d93 with SMTP id
 d2e1a72fcca58-7723e38c01dmr252847b3a.27.1756506629925; 
 Fri, 29 Aug 2025 15:30:29 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a4bb5dasm3364297b3a.55.2025.08.29.15.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:30:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 73/91] linux-user: Move elf parameters to {mips,
 mips64}/target_elf.h
Date: Sat, 30 Aug 2025 08:24:09 +1000
Message-ID: <20250829222427.289668-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
 linux-user/mips/target_elf.h   |  4 ++++
 linux-user/mips64/target_elf.h | 10 ++++++++++
 linux-user/elfload.c           | 18 ------------------
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/linux-user/mips/target_elf.h b/linux-user/mips/target_elf.h
index a4b7fadbd6..f400bc2fdb 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -10,6 +10,10 @@
 
 #include "target_ptrace.h"
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_MIPS
+#define EXSTACK_DEFAULT         true
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_BASE_PLATFORM  1
 #define HAVE_ELF_CORE_DUMP      1
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index 67bc963134..c455985a76 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -10,6 +10,16 @@
 
 #include "target_ptrace.h"
 
+#define ELF_CLASS               ELFCLASS64
+#define ELF_ARCH                EM_MIPS
+#define EXSTACK_DEFAULT         true
+
+#ifdef TARGET_ABI_MIPSN32
+#define elf_check_abi(x)        ((x) & EF_MIPS_ABI2)
+#else
+#define elf_check_abi(x)        (!((x) & EF_MIPS_ABI2))
+#endif
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_BASE_PLATFORM  1
 #define HAVE_ELF_CORE_DUMP      1
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a4005c44ef..a67147d43b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,24 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_MIPS
-
-#ifdef TARGET_MIPS64
-#define ELF_CLASS   ELFCLASS64
-#else
-#define ELF_CLASS   ELFCLASS32
-#endif
-#define ELF_ARCH    EM_MIPS
-#define EXSTACK_DEFAULT true
-
-#ifdef TARGET_ABI_MIPSN32
-#define elf_check_abi(x) ((x) & EF_MIPS_ABI2)
-#else
-#define elf_check_abi(x) (!((x) & EF_MIPS_ABI2))
-#endif
-
-#endif /* TARGET_MIPS */
-
 #ifdef TARGET_MICROBLAZE
 
 #define elf_check_arch(x) ( (x) == EM_MICROBLAZE || (x) == EM_MICROBLAZE_OLD)
-- 
2.43.0


