Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4544AC87FCA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 00:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uguf4-0004Re-FE; Tue, 29 Jul 2025 20:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJT-00052M-Fv
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:55 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uguJR-0004iW-Oy
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 20:04:55 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-76b0724d64bso92860b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 17:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753833892; x=1754438692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kWgDhWz4q+LKEdoNajQZaWxu0VZK98DRBw6c95eDtrE=;
 b=lPG9rhgcgjxMOMP5SGN4AkDuTtZn3hzqMk31yMpR6YQwYHrkEsGV80uLVROhYW7Z47
 AH71k0kGP+8878OEyYUKlTwSXHBB3pFvbxT5IjzyAW1DbgEvih2uFEDNcc0rV0D4eQBm
 vJkBaJ2Zq6Cb8Bk5Hcz4HpD5UZmo0/qYLuQyYtKuGuKejRI1r9VPPZKEBjguOssITTlS
 PY8azF1YWUe1De6dTCeu81uRwQ2YfN3mv0FtuNa8GDRCqkh1A0Hw/MwY/iJhKV27C/Mc
 o9GQgOjTUdjPOmtKrsW/6qlUhogGgaBjzuSX/2mZC611M6YautIHBWfqIR8APlgt6AWC
 cx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753833892; x=1754438692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kWgDhWz4q+LKEdoNajQZaWxu0VZK98DRBw6c95eDtrE=;
 b=HhdAlDdN1LCFM0F/O9YbTHAYU6t7YmtuDsiIsMfDCP8f2bt+J+gmrURiifR7QniDuz
 CNHVJPKIKaQ9OJf6I6wx1MVYAyfM5ZjbSpuATgtFITk4/xzFbLah9ByPDcM+NnwwRDxr
 Wx/sUl6VC589gRVKlEGQ4c2/pqRmV9jlLAgAqHh7Xa0azDo3x5A79cmYRTgTdmWUh77O
 v1o8TpV7PdnslXFByRfPMEyyLS9D3hxIwDOFPxXyt1jnO4CL5KrFEAaSewn6Pe+PYT57
 AKtDRZOBVObR+UR4rcy2m0DsPrnXC2TmJKXyh2F5WtP6AIntMTqfK/aWqiVSfzCHFPIc
 7nBg==
X-Gm-Message-State: AOJu0Yx1q1Sd1tXh69JfGpEfoEmwTJC4KDsEDjMpnHtYxh9gq8jPEcp7
 XT3sEc9y0iDQYeSYXuganfTWIil0pM+k7wdkV2uJOFm1hpbN9yTz47SGiLMPBNqQ6lQwq8UF+Eg
 NmXwX
X-Gm-Gg: ASbGncvXHTuURKvXcXOupfw0yu71yYDjZydIgsEaYckG3GG0IUL6p37GoKJ6+5LrFQ6
 aEnrijv0EXVLHD2quYVBG9d8DXlmN8OtBGmyKHvq7jA4otZ+7j/MIBYGwvB2PjIniv+r8TQi9SQ
 b9f55IyACaJOIfgVszyBjhVQSgBoxkVFqSq/3tdUy2A1iuLNkVuZb2M+EG3CmWtQ4bmi3X3ezEg
 O5auvsFGCjm4yKBIY8UcNl7z0kfaSKXU617wS7FiS9lBQrecBbZTM5kzOn2/fOe0UBT5VPcEqUw
 Npk+YHxkM5p6MzljnIwLIZmV5R3awHiVGYX5Qr6gy9dcLOMT9C6YyfhxGDAtxhGVoqSY5WPiqLv
 kz7jPJR/Pp0G5tFtKWwz7CJ4Q2ZhdWKmt5a34f3A3IEIrgZhMfWgDc7bhnasVGoy+pbjvD5YJdF
 ymMMBXkC8FZA==
X-Google-Smtp-Source: AGHT+IFIASPJvEb5WOK8dyCeTTi/C1keyJA4ecT/T/1bIApIXk49QXmUgQMZAkjehmqSYyr+RWoQ7A==
X-Received: by 2002:a05:6a20:734b:b0:232:a762:def with SMTP id
 adf61e73a8af0-23dc0e585c5mr1861809637.30.1753833892068; 
 Tue, 29 Jul 2025 17:04:52 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640ad06762sm9101302b3a.80.2025.07.29.17.04.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 17:04:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 75/89] linux-user: Move elf parameters to riscv/target_elf.h
Date: Tue, 29 Jul 2025 13:59:48 -1000
Message-ID: <20250730000003.599084-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730000003.599084-1-richard.henderson@linaro.org>
References: <20250730000003.599084-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/riscv/target_elf.h | 10 ++++++++++
 linux-user/elfload.c          | 14 --------------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.h
index bfe86105d0..61446dd945 100644
--- a/linux-user/riscv/target_elf.h
+++ b/linux-user/riscv/target_elf.h
@@ -8,4 +8,14 @@
 #ifndef RISCV_TARGET_ELF_H
 #define RISCV_TARGET_ELF_H
 
+#define ELF_ARCH                EM_RISCV
+
+#ifdef TARGET_RISCV32
+#define ELF_CLASS               ELFCLASS32
+#define VDSO_HEADER             "vdso-32.c.inc"
+#else
+#define ELF_CLASS               ELFCLASS64
+#define VDSO_HEADER             "vdso-64.c.inc"
+#endif
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 28407a7a00..5b3bdf58cb 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -138,20 +138,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_RISCV
-
-#define ELF_ARCH  EM_RISCV
-
-#ifdef TARGET_RISCV32
-#define ELF_CLASS ELFCLASS32
-#define VDSO_HEADER "vdso-32.c.inc"
-#else
-#define ELF_CLASS ELFCLASS64
-#define VDSO_HEADER "vdso-64.c.inc"
-#endif
-
-#endif /* TARGET_RISCV */
-
 #ifdef TARGET_HPPA
 
 #define ELF_CLASS       ELFCLASS32
-- 
2.43.0


