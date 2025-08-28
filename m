Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD531C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgID-0006Yk-Ck; Thu, 28 Aug 2025 13:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWp-0008J6-IR
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:56 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbWj-0008QB-OS
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:14:51 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76e1fc69f86so1587399b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756383288; x=1756988088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D1To9kj0NUReaVQ1Qmnz3yHyScg57OYykVcZq9vtj4w=;
 b=deyU48iP2aGFrTUSfjSD4JkKKJli6wD4rGinpdACv2w+qA9xtVuUqUnPcrM0nImrKB
 th95ry4zRfLAe0JU8zwZJhqFRW/mclkBAGoF52E2R8M60tTok3Z2VD4tUjjC0L/eRU00
 4q9MXHPYcx6oAmFged+nxvZAxaGhhehLOCQznUFhW3kqTjpZ9qU/G5wgACZDyRbXRuXb
 4xfNoR4jkxayYOLYNgVNuOcZwfGm6g8U4OioLvJ9No+52zbNdW6Elsp/Jk1246uAp9lB
 NPbGHkZGqFn6FTGEDGJMLtRQ4uWWofl7ebX6WtBsEEmOGnHc4n4fcl1mbNeBSVk3hnC2
 aD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383288; x=1756988088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1To9kj0NUReaVQ1Qmnz3yHyScg57OYykVcZq9vtj4w=;
 b=Ig2qYgk9ln7P5w/wyLVY4n9XIMl7TVAb9YZLNh4C4jd7iB5SyNI7LujedG2rBtzjNx
 /E6azgPTKNE459C4qxsISXVDlIrhjFWKrJ+KQI+uOad+nlcH+o9NrhSxm628JYKY/DHh
 oi7BpVMx/XlFpq0Z3DamRIDE9/bj2QkQff1mIQ0eD/zYiX/5WTVHLS5IS+5vrgltDdLt
 hOSCaxU9eLNjIBKwLMb1Jo/dazQdRSlNriHtH2U7Dm1Z2VDPy0Gc8qOTRGIsGmKdOb2+
 v5OiuNgAzo1/ni6p9J+aU07iJJ00hVRavDNESpDoRsrLRkPhTH6YG6UOHbv7dlSXuRzv
 EQVw==
X-Gm-Message-State: AOJu0Yx3cbRH7ADI7IRbMKklfGiBLXTT/4SPKLaAwwpLdx1WSBXPTR4f
 q92U4dq1EjpY4jBUznFAZPe8wDNdxBZBfZlww8wGdVrl4X4uadmmOy2z+zwjwh4t5rrVmR+zlsU
 zWMok1aY=
X-Gm-Gg: ASbGncsehVesDlLBw4mf751sHOG07/HJB+Y3gL5/PW23RI2KrNA68UWnRGERxOuwLHS
 /tpc4s/6r4+LI/HBCduxNtVv+TiTRvD+rmOC593yElcbTSDKSORPnJc3lhIL/ss21Tp05dN2wZm
 KkgNzk2GX3rnNhbd/9DSQdc2zP7yiWttmG1n09AbSCRgsDvW6zzSAMUixl/S7zmYsDtIxREH2yH
 hUBZgvt0pdOuXZRWW0paykYQ4LOfBh14nf8k5hmY+ITMJ2QS/dOu9TqktFeK+rXvhCcJXh26kpK
 G/dwjLqVPqqX88k3uRMMkdv0ACnDWAJxGY/5wLh2lFqHRCl4onRXetEo3Nfqk/tG+vjKkj11mVr
 qvmyXiaIqgWjFdW1K134vSJB/kSKpltU34cPe
X-Google-Smtp-Source: AGHT+IFAboyhrPv9F5pP393/PSTcP0xc/wVsQIecmZWw9bCcKVcxeHPshT4+Fn1mpoaAHCxta8PZsw==
X-Received: by 2002:a17:902:e744:b0:248:96e3:6cf8 with SMTP id
 d9443c01a7336-24896e36f99mr83769385ad.24.1756383288384; 
 Thu, 28 Aug 2025 05:14:48 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-248e3e0b75esm15129025ad.8.2025.08.28.05.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:14:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 66/87] linux-user: Move elf parameters to sparc/target_elf.h
Date: Thu, 28 Aug 2025 22:08:15 +1000
Message-ID: <20250828120836.195358-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
 linux-user/sparc/target_elf.h | 11 +++++++++++
 linux-user/elfload.c          | 15 ---------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/linux-user/sparc/target_elf.h b/linux-user/sparc/target_elf.h
index b7544db0a1..f89c708c46 100644
--- a/linux-user/sparc/target_elf.h
+++ b/linux-user/sparc/target_elf.h
@@ -8,6 +8,17 @@
 #ifndef SPARC_TARGET_ELF_H
 #define SPARC_TARGET_ELF_H
 
+#ifndef TARGET_SPARC64
+# define ELF_CLASS              ELFCLASS32
+# define ELF_ARCH               EM_SPARC
+#elif defined(TARGET_ABI32)
+# define ELF_CLASS              ELFCLASS32
+# define elf_check_arch(x)      ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
+#else
+# define ELF_CLASS              ELFCLASS64
+# define ELF_ARCH               EM_SPARCV9
+#endif
+
 #define HAVE_ELF_HWCAP          1
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 838d7199a6..ccdd87aa12 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,21 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_SPARC
-
-#ifndef TARGET_SPARC64
-# define ELF_CLASS  ELFCLASS32
-# define ELF_ARCH   EM_SPARC
-#elif defined(TARGET_ABI32)
-# define ELF_CLASS  ELFCLASS32
-# define elf_check_arch(x) ((x) == EM_SPARC32PLUS || (x) == EM_SPARC)
-#else
-# define ELF_CLASS  ELFCLASS64
-# define ELF_ARCH   EM_SPARCV9
-#endif
-
-#endif /* TARGET_SPARC */
-
 #ifdef TARGET_PPC
 
 #define ELF_MACHINE    PPC_ELF_MACHINE
-- 
2.43.0


