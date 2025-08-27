Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD88FCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPRe-0001V1-7P; Wed, 27 Aug 2025 19:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRc-0001S6-42
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:44 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRa-00047o-BY
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:43 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so343309b3a.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336840; x=1756941640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qyfttuYrb2FmFhaTWAEnRHcv+c+b5Ku1UMCZw0CnHd8=;
 b=HGnVQo2HMhSAWAwNZ9VEMs+yus2JmQOLaKhfw3Uovo7T8/3RNpzMc17Ho6vrcSvYj1
 1rwZ7cd4lgNy2BbIyXteBHiU5MotAscOaU1iLnphF+/L4aXcwsCSspKgRe1I/mr+OyQx
 EsPkeK+lEWb+nAm9fGj3KiTKOk/bzNwzh/OQ5d0SKQYHI1BwEdr225EnezL2i8Vh212c
 wCYyrC+dxHv6Ega+JzFRmtE40kzlvgB05FHrDMvR956RugARDuEkgTJK2POaF+Kaz1Qn
 7+cPRZWUx/zgcYWTBYCezbwoZDVt83CTMM60ZtqlBgrxUb3rH77W/gikeHpRtTl5oFE8
 tc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336840; x=1756941640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qyfttuYrb2FmFhaTWAEnRHcv+c+b5Ku1UMCZw0CnHd8=;
 b=YryLwhpaxszEjO+p+cz3WJbZhlfG73GZqx/T3/vTmDZtuFf4RXVwS1U5dk4S5nKdhu
 HyfSK4XJyIlEKYYoLBBpXF5eFZLxI7cUX+zNNs33d64CG5WdmYizxoMH6MEq9prd2fnk
 B3YrYp9ukMojRWz3Sph2gXfyNTGlCaGaYm5KEqgqLrIuurfJ74VS7EiOS2MvLo+c361D
 TsAWiTY+E4mBeAm+M9Vw+uyQjE5Eq1tjXww+5TVXg2Y19hHiylG7UV8ND6XGBPOahVwC
 Cxo06zQ846iJR2w5YPY68QDYZS4l4niyZqFHPMuM3U7RVJvD36l3AyWJtsUAB7y7ocpN
 eBsQ==
X-Gm-Message-State: AOJu0Yzq2T3JBUbotazQxWn2MAEvudSppK8sw+0H4attVSD5R4+Rlg/U
 3UovBRqoTDwrTxlN2b11uWL/rwNqjNftA7wYLPYi81fn4TL5FIMygwfl4bLxQLrXjkVJyQV1A1a
 zHlR3/Gw=
X-Gm-Gg: ASbGncuGRSyU6O1nMQaw3/Jlbaf4xEOI/yB9RbjghpbqJeGcNVEbWP5do8PgjO9SGHc
 GbLQuebJlwvdORL9oiSaB7KzO17jHGd4FE3n0cI948ki+t+lzTBhqLdo1p2mc95sOwAnfpknmKk
 JHxxE2+3+PIdSWx53AaXtuYrsoFGVE6YInkLPm5Rf9pfu9aQBggS9BJi4l9eQKC7CitXjMs05ik
 zZnKnsAEYHVAPAnUVawI43zAOE+DOiQN+ZYC9xDugSEurPSUd01J21kfTa8Em63r633PAgDXyz9
 eIGtB/uHwmiG1q2rT1lrE+VR4UCJjiuTyYiEmLQA18UNtyG+BnKXhY8pifWK9vfTO3+xxI62pgo
 GhqG6+LZDGQaduuUE/ni/3OSCWA==
X-Google-Smtp-Source: AGHT+IGwR1nndh/yCqx3qKqeXTIGz242sb8KTpasaaEsXm7l7tScuAUJvJi07rhTyDJUsQAq7skqYQ==
X-Received: by 2002:a05:6a00:1789:b0:770:3dc0:a4ad with SMTP id
 d2e1a72fcca58-771fc292de2mr8743767b3a.5.1756336840323; 
 Wed, 27 Aug 2025 16:20:40 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:20:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 04/46] linux-user: Move ppc uabi/asm/elf.h workaround to osdep.h
Date: Thu, 28 Aug 2025 09:19:41 +1000
Message-ID: <20250827232023.50398-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Move the workaround out of linux-user/elfload.c, so that
we don't have to replicate it in many places.  Place it
immediately after the include of <signal.h>, which draws
in the relevant symbols.

Note that ARCH_DLINFO is not defined by the kernel header,
and so there's no need to undef it either.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/osdep.h |  8 ++++++++
 hw/core/loader.c     |  4 ----
 linux-user/elfload.c | 10 ----------
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 96fe51bc39..be3460b32f 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -133,6 +133,14 @@ QEMU_EXTERN_C int daemon(int, int);
 #include <setjmp.h>
 #include <signal.h>
 
+/*
+ * Avoid conflict with linux/arch/powerpc/include/uapi/asm/elf.h, included
+ * from <asm/sigcontext.h>, but we might as well do this unconditionally.
+ */
+#undef ELF_CLASS
+#undef ELF_DATA
+#undef ELF_ARCH
+
 #ifdef CONFIG_IOVEC
 #include <sys/uio.h>
 #endif
diff --git a/hw/core/loader.c b/hw/core/loader.c
index e7056ba4bd..524af6f14a 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -295,10 +295,6 @@ static void *load_at(int fd, off_t offset, size_t size)
     return ptr;
 }
 
-#ifdef ELF_CLASS
-#undef ELF_CLASS
-#endif
-
 #define ELF_CLASS   ELFCLASS32
 #include "elf.h"
 
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ea214105ff..4ca8c39dc2 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -35,16 +35,6 @@
 #include "target/arm/cpu-features.h"
 #endif
 
-#ifdef _ARCH_PPC64
-#undef ARCH_DLINFO
-#undef ELF_PLATFORM
-#undef ELF_HWCAP
-#undef ELF_HWCAP2
-#undef ELF_CLASS
-#undef ELF_DATA
-#undef ELF_ARCH
-#endif
-
 #ifndef TARGET_ARCH_HAS_SIGTRAMP_PAGE
 #define TARGET_ARCH_HAS_SIGTRAMP_PAGE 0
 #endif
-- 
2.43.0


