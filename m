Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B7C8C87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLSi-0003hk-Ss; Sat, 02 Aug 2025 19:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSU-0003YS-GS
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:10 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLSS-0002WA-7e
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:16:09 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-741a1ee9366so579566a34.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176567; x=1754781367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QrYvjPXQDsgPgsbdHSjo5YgvdnA/u/5pnjxh7aozN8o=;
 b=zentDnqRrbbNukGHKYbyEjJU0zS8kdDTqLSW2ujnpA74/xdHPNGFPaiF1pFZTvq2bt
 cDlx1c3H/IR8QvawRl306cmkOCLJBNSMitbmd4EMKtdaTTwwydSz2xNzCpZT2PVsqx1x
 LxAgGS6Hb+d+6Hl0YsIAeYK8V4cV9VvI5n0a4+xo//cXPerZh7uACk/4u/gVqrM2uCuH
 +RDOQcuCYid6qrr5ANRalrGdEYxOnf3UdKkNU2sHjCfljXolR3nve6WPC+ZvKtO+9vXV
 nnRi0GnigdAx5Rd6rpSGeOiQev4mcmLvBeuWZdLp2CtE58M77SHZ0nRmjwDfZLFlZGZL
 gilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176567; x=1754781367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QrYvjPXQDsgPgsbdHSjo5YgvdnA/u/5pnjxh7aozN8o=;
 b=lXa8PbqDgWHyIamVVYr4bXQbSDzpf0W4uy5sIB8cIlwGwqPbG6WPTaEKk3TZOtQ8Wp
 ECLUWxxOXDJfzVN1XSBNh9+p8tFImmpQEvNlhIJSj8wVRwkfjGi8qqUlwk9+5vIHcmaQ
 /NGGkyVX4gjlGJdpfNsaZ692EA7dOgD1+ybMT6G58iS19rDGmrCHakZvPUENpkDPqJZ9
 6mscMZl22Y7eTmROpbEeqKf5SGR4ysVOKD2Sd3RzHmthPhw1GxGyka8eUy0u65hF8/Fc
 yiolwgO+/sPbdj3emyRUTWesjpJzcAlFuOOHUwk+qUTGNLEnVEHCFoGu8hwiqP5ladV2
 Yw2Q==
X-Gm-Message-State: AOJu0YxybzrwLPOeH7vLFen8CkqhKE+IVrHBrvH2z3IdXmcY5q9vO2qD
 /O2r8f7I0qcUZ+jj4H4Ht7+dgctS5lNzN7U8p4WyILxmaO4xCifqk3loSkUZ6Ga6oDup0FvC/+P
 gKo3x9H4=
X-Gm-Gg: ASbGncsIp8y23XM5HUqjX8GEowxH1Knf+TZUWlUHMU6iAEXuZZnEuNENGjZBN4XBkVa
 bu1OcuDws8h0uZjJ4gjvAs1yWARH9nLFvw1xSegvpgUwM3ZT/1D1cjZkAP+gg0cpBCU1g0JtyI3
 0kAUDgxax1FgowhD8wYh449guwQ+ksGA2yVyxqs164RVQLGbXUXkIvkSi7Ab97oBGa8nicyjMF8
 lBJvAA9vAMDOJJCgKODsKJ2kR0F5IElzGbQlSJwCz1GZC1+yZYhbe9RCXPNRRXq3Y6T5tZ7v3pu
 8NKC4Oc3UVZepwh1Xw62DF7zP6dBqE9Z7imRIZV/5kPoq2XH6AtrnFfAelmc+gSVigxBObAbHVv
 kjYdiUqWuEzeFU/uNCFcMuI78HpHjGQ5w5vGMbF/B/ug9zTLxFf4ZmIO1xek2ohs=
X-Google-Smtp-Source: AGHT+IEPj056cAah9maOS+6Q93fGBR/hNGnZMwSKEkW7Hmv162JjNjXT9zea/Lsk8SETJqrpEhC+sA==
X-Received: by 2002:a05:6830:6318:b0:73e:96e6:253c with SMTP id
 46e09a7af769-7419cee764cmr2449863a34.0.1754176566908; 
 Sat, 02 Aug 2025 16:16:06 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741930994e2sm1081608a34.1.2025.08.02.16.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:16:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 81/95] linux-user: Move elf parameters to riscv/target_elf.h
Date: Sun,  3 Aug 2025 09:04:45 +1000
Message-ID: <20250802230459.412251-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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
 linux-user/riscv/target_elf.h | 10 ++++++++++
 linux-user/elfload.c          | 14 --------------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.h
index 48d9af557b..51b8def1d1 100644
--- a/linux-user/riscv/target_elf.h
+++ b/linux-user/riscv/target_elf.h
@@ -8,6 +8,16 @@
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
 #define HAVE_ELF_HWCAP          1
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 1025ee5fac..a0b9454f15 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,20 +130,6 @@ typedef abi_uint        target_gid_t;
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


