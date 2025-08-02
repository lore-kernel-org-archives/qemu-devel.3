Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4853C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLP7-0005Kq-6m; Sat, 02 Aug 2025 19:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOn-00044n-Cm
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:21 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOl-0001sC-Pq
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:21 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-60402c94319so2042664eaf.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176339; x=1754781139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bk5EntNhtj6cVgm0qRFlXwzo87uUlNI/Hb/uQV355fw=;
 b=kQSEiiH6RVhMkxqu1Nbsqsbl6+FXvVv0aWwFJs62mim0rx1i0xukTMma3bnQuNabgi
 +hao7Xw34siJbW+K39fSWbf0ABW6l4+CCX42mKh5dDnHb9bLNIzQtswLmqJiGGsYysDv
 yFUxcL9s3CdmwlIAz4tjeMKp0Uz0XJ7bDpH/dse7H5ISBsKLTHlzxK3f/29H7DCFwiGP
 s+xe2FmVvHVbjW6VIZ/lVpymNavgfKlQd7eTGSwzTYTApxOy6gEeVBq3YsVkOMCZXChi
 QVMUNbjGL9ObWbuB9ynDilb4iq7wAkGdAzAAXJdf8+L28ETb5Gr68zqchph2JoisHz4l
 YGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176339; x=1754781139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bk5EntNhtj6cVgm0qRFlXwzo87uUlNI/Hb/uQV355fw=;
 b=QSIvV9RWZzjjYkS92YBFE3641Cmd13Tos8xx03t7ClSRAv4g1X5rnj+8fQ+dOMCC+Q
 NMnoZlr6giB+qWPKbHsm46AxCsDiqb9OGOQ2RkvFoWpVuEe5vKZUuUrMVEakKm8mbQqR
 ubA2gvRO3Hy1H9CL+9Fs2rN4bCPZG/9PNB/BqINhWkGq5HEuPz3PEglSuOzC8xRdlTGU
 /EVtws1b7uRaLhHVdw1QP9MV5YvqU4BZz028Vc60CF9CoI/8r8y8QpiBwPgQxv+5M2d9
 DTssinvmTmmxeyL1NqLVQZlcfWBe5wejOx+OD/O448CtY9fm4ALIH5Uc5EhG2AxUK3jV
 FUlA==
X-Gm-Message-State: AOJu0YxZfG1BArqbGcQ7BHEv8F2ZC9Id4CFMaE6qRuFVBbEoBcg9mhuN
 oyOSDGPUvyAovQLzYWlu/YYS2USRO5qW/y/1M1GdhFYMQXp2940hHbK2GIcv39nAXsEp/FQU4CI
 7NbiVyGs=
X-Gm-Gg: ASbGncsUKJGHbsB38Xtg9mzC0t0YHEryBRBK+EvH+ADDDo31vJPrJ4PSxz/HuYML5kZ
 p9JOsOhEl0az7hVB7JkZ646c1r8ZCXUzXzHF2zk4tB34HDV+qtktfhHA/+9AIaA3FAh/KZR3pih
 z6gO3qYGCzfJh+w7DizewRYIwfn3EmOo+G/dpOHuDlcx4FT946FulDf9+dZn2oUABnd/f5HJL0i
 lkUJnUjSfx5aLuCsSCmAom5lUXt8+n7QNXLapXFk6G/3hnENjWB9HUOWoPsbJKgk4sJckjQrI0h
 XCmy/5KEJw9G17iMRYlgOqzy2safN952TBgDU1oGWyPTQtOGS+58JZJmQ24vuFHQfFUq0tDVPjZ
 5w56GwQzAK6s4I2ydDLaFUV/NoKjxUxnJgm9L/86DF3rmtT1E89tj
X-Google-Smtp-Source: AGHT+IHxtSIWg9yWKEbhc8ssMdGUeZ3gaCidGUPCtSTqdrf9qrXeYYPZR0SukhM+XLAJzod4X5nXMA==
X-Received: by 2002:a4a:edc5:0:b0:615:ecc5:c07b with SMTP id
 006d021491bc7-6198ef76654mr2701491eaf.0.1754176338664; 
 Sat, 02 Aug 2025 16:12:18 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.12.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:12:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 70/95] linux-user: Move elf parameters to {arm,
 aarch64}/target_elf.h
Date: Sun,  3 Aug 2025 09:04:34 +1000
Message-ID: <20250802230459.412251-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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
 linux-user/aarch64/target_elf.h |  9 +++++++++
 linux-user/arm/target_elf.h     |  4 ++++
 linux-user/elfload.c            | 25 -------------------------
 3 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
index 7628904365..9e09bfbf12 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -8,10 +8,19 @@
 #ifndef AARCH64_TARGET_ELF_H
 #define AARCH64_TARGET_ELF_H
 
+#define ELF_ARCH                EM_AARCH64
+#define ELF_CLASS               ELFCLASS64
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
 
 #define ELF_NREG                34
 
+#if TARGET_BIG_ENDIAN
+# define VDSO_HEADER            "vdso-be.c.inc"
+#else
+# define VDSO_HEADER            "vdso-le.c.inc"
+#endif
+
 #endif
diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index 0fbeffae64..4614acb7c0 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -8,6 +8,10 @@
 #ifndef ARM_TARGET_ELF_H
 #define ARM_TARGET_ELF_H
 
+#define ELF_ARCH                EM_ARM
+#define ELF_CLASS               ELFCLASS32
+#define EXSTACK_DEFAULT         true
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a017c2162c..fb1c125566 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,31 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_ARM
-
-#ifndef TARGET_AARCH64
-/* 32 bit ARM definitions */
-
-#define ELF_ARCH        EM_ARM
-#define ELF_CLASS       ELFCLASS32
-#define EXSTACK_DEFAULT true
-
-#else
-/* 64 bit ARM definitions */
-
-#define ELF_ARCH        EM_AARCH64
-#define ELF_CLASS       ELFCLASS64
-
-#if TARGET_BIG_ENDIAN
-# define VDSO_HEADER  "vdso-be.c.inc"
-#else
-# define VDSO_HEADER  "vdso-le.c.inc"
-#endif
-
-#endif /* not TARGET_AARCH64 */
-
-#endif /* TARGET_ARM */
-
 #ifdef TARGET_SPARC
 
 #ifndef TARGET_SPARC64
-- 
2.43.0


