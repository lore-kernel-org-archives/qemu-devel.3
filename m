Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A8EC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLPC-0005mo-4H; Sat, 02 Aug 2025 19:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLP1-00050f-OD
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:35 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLOz-0001uF-LI
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:12:35 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-61585dfc8f8so1028124eaf.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176352; x=1754781152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKhldYKs1QSuxD/L/nGAckx4xf1pBRHHNxpQtiRND84=;
 b=uuL3Z8pw6vIcWTxllj1NADBH2cPgLVFgqJSykp1G/2YUs2wYOV51B7pua1mrypYiYW
 vo9oyWqKb0h9V4QcaRppP2M7Ku9Dn56tGLmDzf3BC/94yO6pYlKHFvv49YaPCCmsdkLv
 W3XEhtrmNc9Ynh0alRCqF7XjWWo3kYs/PJWl7bFNIXe5kCjFt76DqO1hjgpPOXAjoNHv
 9r7jEZQdW7qJzU8zF/YtvhUKExvx69ga2cggf6oU4BGh78yHkrWra1sFA8larJZHQ+Cu
 S8OufyNxufpS3omaXNsF8rPOH/nkrylCMTNkGiEthmLf3IGr5GfsjA6kQdJXVKghXN0D
 Rl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176352; x=1754781152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKhldYKs1QSuxD/L/nGAckx4xf1pBRHHNxpQtiRND84=;
 b=PdBfPQEta/6EQqYM1tl5yRfIlig+FSDQjDihmnw1nLjSiE/o3+CGdYfpJYK75yNAL+
 nBorfjGlMu2OD6W1b09RJSAcWW4P7eS+trL0uFTVOa+NPZNUEVn3SErJCglRv0yRBaHC
 b2h+NpnYgZP2oZeaoKXwLpwZYGWyFlK+Bwk4Bpkj1xAMmHhNqXgu2W7WbFS17XDJDMoG
 r7cedCAmb2J/KUpHWmXR4SMCVOXstq2NGQyTzyQKV/4KsinbobzWCdLyapQYuyAAWb57
 PHHmGWGh1KIKPQ4QNtJ2swL1pOcQppB9iuRdoHINmGiQoKnsjGxjRTlZgj6yCu8SXye0
 nzTg==
X-Gm-Message-State: AOJu0Yw8S63eQO/SNA5W8S40pC8J9jYwqdhYUQqtL27npoVCX3Ab3ZYQ
 0eta+48AxW3IXNy8UIQ6NbGku4I5znhFOtfeCAy6RpzKDDvBbU5/htwtNSIxAHCgAhyTiUQblpv
 ix5kM5hg=
X-Gm-Gg: ASbGncvEORWRNJJEYhV4N+Fi2WpTce3+/5mt2p/qFp51t9+enc5RQxAs3Rwg63nz/Eb
 1p+Yt1wlDM/sL8zcFX2+VO+7k9p+ASqCGWyaMw3w4YPXr1/IVkkoTPeNfUls99dJOItlB3OQSAi
 7SJTL5QEGjG6jeXc380g0ffIR6qe5FuQ8XLRV1XseLYkP3VbnvCQSZrya8HeqnBQSMWoFWw0Vs3
 MMwKfBrXqgVNwKWLLcDFdK6PDaksPWXsjB3W8UXvveEqDeDnukFIMUDQyXw9oW6hLCXSkjS0Y9w
 KmKMy164Xqvs86z1aqDuGW58E+mEqvItfvcF8T+/0JsoLGrtxY4qd5TWCW/cu8OxKzoo+s1IgN/
 QC21C2CCfyPlsc5K3yTfV1b7NnDivBSuWSoGqf57Kg2+5Oh2SwVW9
X-Google-Smtp-Source: AGHT+IGaiPwR84YarFsF8mTRwWpak7D12KdyeVtvDD/5RqSqRy0fcZhBLvuBV6EV4p0tsnnhjSJimA==
X-Received: by 2002:a05:6820:1e10:b0:619:a8f7:dfa6 with SMTP id
 006d021491bc7-619a8f7e0b7mr82595eaf.0.1754176352489; 
 Sat, 02 Aug 2025 16:12:32 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:12:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 74/95] linux-user: Move elf parameters to {mips,
 mips64}/target_elf.h
Date: Sun,  3 Aug 2025 09:04:38 +1000
Message-ID: <20250802230459.412251-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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
index a36ca5a83f..0433de4529 100644
--- a/linux-user/mips/target_elf.h
+++ b/linux-user/mips/target_elf.h
@@ -8,6 +8,10 @@
 #ifndef MIPS_TARGET_ELF_H
 #define MIPS_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_MIPS
+#define EXSTACK_DEFAULT         true
+
 #define HAVE_ELF_HWCAP          1
 #define HAVE_ELF_BASE_PLATFORM  1
 
diff --git a/linux-user/mips64/target_elf.h b/linux-user/mips64/target_elf.h
index ebfd62348f..60ecb4d0ae 100644
--- a/linux-user/mips64/target_elf.h
+++ b/linux-user/mips64/target_elf.h
@@ -8,6 +8,16 @@
 #ifndef MIPS64_TARGET_ELF_H
 #define MIPS64_TARGET_ELF_H
 
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
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6b0d73a6f7..4173a8d619 100644
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


