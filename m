Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0ACC87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLO0-000252-BM; Sat, 02 Aug 2025 19:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNq-0001PC-OD
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:23 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNp-0001if-06
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:22 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-741a905439eso347858a34.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176280; x=1754781080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y4Q1Srwbs/6+hhmFAOE7PHOfNRos+ZMA10+wsF3+1Y0=;
 b=CrAJiyZh6H4cbQk379o0uR0w+EkkVjRq4bM4YvI8tBb0ite0ySkZe1EtA9xVmxB3J7
 BhypvNYx/GlW9pY2Sfrny7/G/YzMlEP8dUobrcx0215RdCWjOvzjUHOansJS8KpNh00A
 w5oNJjabuPylQF4oa2JLd4C7hDECqqsMX9Ah8dsX3FvCUUzL9loyTHpkYxL46BoSQ9nr
 XcVHvEb8+O4cZKu/v2iNxXlzLINj401vgguWwjqDrFOIxJosoRU8Y74ad0cCWTgH2tst
 XpYc6wMZBeeB29916ch6bTbcWZb26x24NvCYtK/waGiy+P3DTY4Cx+A1Cr7nuDAvlP57
 cdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176280; x=1754781080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y4Q1Srwbs/6+hhmFAOE7PHOfNRos+ZMA10+wsF3+1Y0=;
 b=SThrjz4dvo31uwB338q6LgxxpN7pCFi6SUVFZuaD0k4YexCHTAut4++Rij+YfMgZmU
 oT481ln8/6K8MNW9wsvvbzIz0zEEEpZ212J0TUX9W6ClpRa7OWgE3bBoc62jwqEOjpQf
 Lmfyvo2vA8WSRKcZkHgJu+Dqa38Y+NAJWV7DbtidzkuyENOJG4oO3VwrYq6lvvre/47c
 /Tt5OCreBPGLjnP+dFN35gxTojNz+qTx7ORjWIO6tfDETlv4+YYPCYt44Xr6QJp8hcb0
 d5T/3efOlzL3X11f9CpEiKTCfRIYQI/jiE822IPnfO2EFDTDIJ5M5lyAnikjq8GorURj
 YVwQ==
X-Gm-Message-State: AOJu0YzGkIOrxFQIpNHZg57k1jdJLeJB4IxoAn3QLgInFMA9qBm/H7XI
 zsKazPp3k8ADa0Nqts/SkQe5NAQlOxDReecazVgfRL2r526g6xZ4TdRTicitcfYNFZlRt9mkTiH
 mpeQYkg0=
X-Gm-Gg: ASbGncs0mAvPTpUcLTDjW4kjc8qC6chxL65BxRJ7t4h9zvLAV+bk5RDEGqrvVgP7BQZ
 cfUyrvWy3qi0A7/e4fI2T7Wx7ZUnXYBa5eo0BXMDucb7ofBcVBgFOhb4tv4hN0TZU5+6fydj9Xd
 U0vtx8s1gmrm0Iwn3PU71YTwD49pVtXggKaq0WdsayCLoofyPZf/50+9IMslfcaQY7Y5ylx13vn
 npriokRQFYQP7hlcJ9QrW2LQzJzFnCzy5k48GWWosoUAxV4Nkdzf4s+9WDr7T1S12a1GHc0F9wd
 uhH2ZxwGou/ne8BOZ062Cy3gZEQQL99fcFE++H7OkeV+aK+LzJ80AueMKqLMJcMudWxwAEr7f2n
 6L2cGtK5SnDgD59Sf7TL0OQwyRU4PGXXGeCb3h+4fvuFBsFKPSaI0
X-Google-Smtp-Source: AGHT+IG0BK22dKY4WPy9N4iWkKO3CsXb2QheVvWxaFKbroBnPg+SMDglG0XVhVM23hyFop1sv/p+WA==
X-Received: by 2002:a05:6820:2685:b0:619:a3cf:4d72 with SMTP id
 006d021491bc7-619a3cf5198mr623803eaf.1.1754176279713; 
 Sat, 02 Aug 2025 16:11:19 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 52/95] linux-user: Move elf_core_copy_regs to
 aarch64/elfload.c
Date: Sun,  3 Aug 2025 09:04:16 +1000
Message-ID: <20250802230459.412251-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

Move elf_core_copy_regs to elfload.c.
Move ELF_NREG to target_elf.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_elf.h |  2 ++
 linux-user/aarch64/elfload.c    | 11 +++++++++++
 linux-user/elfload.c            | 13 -------------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/linux-user/aarch64/target_elf.h b/linux-user/aarch64/target_elf.h
index dee79ce0c6..7628904365 100644
--- a/linux-user/aarch64/target_elf.h
+++ b/linux-user/aarch64/target_elf.h
@@ -12,4 +12,6 @@
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
 
+#define ELF_NREG                34
+
 #endif
diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
index 1030cb8094..3581b45d50 100644
--- a/linux-user/aarch64/elfload.c
+++ b/linux-user/aarch64/elfload.c
@@ -347,3 +347,14 @@ const char *get_elf_platform(CPUState *cs)
 {
     return TARGET_BIG_ENDIAN ? "aarch64_be" : "aarch64";
 }
+
+void elf_core_copy_regs(target_ulong *regs, const CPUARMState *env)
+{
+    int i;
+
+    for (i = 0; i < 32; i++) {
+        regs[i] = tswapl(env->xregs[i]);
+    }
+    regs[32] = tswapl(env->pc);
+    regs[33] = tswapl(pstate_read((CPUARMState *)env));
+}
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3fb8106858..9ac530800e 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -283,19 +283,6 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
 
-#define ELF_NREG    34
-
-void elf_core_copy_regs(target_ulong *regs, const CPUARMState *env)
-{
-    int i;
-
-    for (i = 0; i < 32; i++) {
-        regs[i] = tswapl(env->xregs[i]);
-    }
-    regs[32] = tswapl(env->pc);
-    regs[33] = tswapl(pstate_read((CPUARMState *)env));
-}
-
 #define ELF_EXEC_PAGESIZE       4096
 
 #if TARGET_BIG_ENDIAN
-- 
2.43.0


