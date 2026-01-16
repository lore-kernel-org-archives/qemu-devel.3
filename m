Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC732D4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgabo-0007Vr-TH; Thu, 15 Jan 2026 22:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabd-0007Fz-N5
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:40 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgabc-0005ks-0Y
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:34:37 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7b22ffa2a88so705436b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534475; x=1769139275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KL546BRv3o5TBcmNuNTcD1O7NivqyCwfyc6P5AJbIyY=;
 b=PebdVed6IiAeFlUbg9Y3i0KLuwCTinvPIBb1gbDbIoBnAOHtRTFxiz0t9gEcuGEGkJ
 sSFhhhzPIQf94LA22qkuivpJwz6WsnuOoTSl+xjujhRaulSyobhvmWXbsYLF8GDRP+nh
 ed+NQ4pcNdp/GZpviJCvNLUxOvwzb3QtyumaHLVLrySAv310bDcoJD7lRU/rMaF/IVXr
 QA69pcYcmSj0ayNn4A7DKs4ZZ2I/TPXWzipfpXD54go1DmufDgmpkdEKNvO+jWMjQ5tu
 IG0zm3o/TjMeyJ9bdxC/fUfqWn4blWejcKQnC9R/N/U/cXQEhvCQ8Xp6MLPGM1zqlvUT
 N3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534475; x=1769139275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KL546BRv3o5TBcmNuNTcD1O7NivqyCwfyc6P5AJbIyY=;
 b=UaLqJhz5+Lfonhw56w3gaM0XYY7uPJnTYmWM5hoC77kGjIVC+Z6DZe4HNrc4eCsrL2
 7XV7KJZclMbwinSdU0MtCU4OpVRH4k4sRknBbVLea1tEvoiZybs6stQrA/rMOMsTm0r0
 154JSBqd748+tfq551t7KOr/yAvhGrKD0OPMJcr6bDiK0Q2RiCEHSIwJCIDVncUjTUoP
 tYSyb5Qgemosfn3EmRRRkY08hXmBzjQSi0kacuQao7PMG+l2VaaMf941JOveE/NmX07P
 fEhiwnD86ooYIlxzJ3kk4+gZlmFzPzHMh7yrsxdBB3oG6/v/rCi0mGmh5JZBlCVblWrp
 zNzQ==
X-Gm-Message-State: AOJu0YyCnqBPTlbUvnhifU/WE3gIv1VtX0TNLmyfyOfwJ5B42nT0Farl
 e31omeaOqUx04LYzHecWTKIhWTED2YWi2IAk47FBwVQeA2ArEw0pwH3v9t3/unzB7RXbSApm1LS
 +dEmxNn3q5A==
X-Gm-Gg: AY/fxX7wtR/GA6lRTK4LDeMQh6q/M15OfyfSDsIqAJUBI4GMOOTbRyPt8XVQIpDn7D0
 sVyM65qUM02lq+nydUBll/iCgeKCyKKk7jdJSiRhbNwdOFJ+5O/gDrQietUVFw3rNe1ID/i96TQ
 nA44xHvfnpZGZUV2KbTAd6HbyOQmk67sqI4GKv2dNhIR72LmXuHmD4z4XvgAz8mcVs1XrFPN/MI
 3UbH8Ed6PtnfhGbDVvzBW4OTJHVnC+Sg6BzP9hR4vlbTbSjhwNtddKE4k2GuiqcS8yN8keiFKLn
 njA6YibUqAJw2KSJ0URZetOJbY7t/fSCHA+jYjglb78je39mZobbGW1u691oH2+IWYrlmSb1Rj4
 NV9Tmj+MIXalnaGXxxlV3kFOpb0UoSi2Duil3w3geTQQZq+1Xdbblmk0Vfpmzqu4rE17L4QrNK2
 2tsGJdGFYPjKJHygrVYA==
X-Received: by 2002:a05:6a00:2e90:b0:81f:44f9:7c1a with SMTP id
 d2e1a72fcca58-81fa1771ec6mr1122948b3a.3.1768534474569; 
 Thu, 15 Jan 2026 19:34:34 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:34:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 20/58] meson: Drop host_arch rename for mips64
Date: Fri, 16 Jan 2026 14:32:26 +1100
Message-ID: <20260116033305.51162-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This requires renaming several directories:
tcg/mips, linux-user/include/host/mips, and
common-user/host/mips.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/include/host/{mips => mips64}/host-signal.h | 0
 tcg/{mips => mips64}/tcg-target-con-set.h              | 0
 tcg/{mips => mips64}/tcg-target-con-str.h              | 0
 tcg/{mips => mips64}/tcg-target-has.h                  | 0
 tcg/{mips => mips64}/tcg-target-mo.h                   | 0
 tcg/{mips => mips64}/tcg-target-reg-bits.h             | 0
 tcg/{mips => mips64}/tcg-target.h                      | 0
 MAINTAINERS                                            | 2 +-
 common-user/host/{mips => mips64}/safe-syscall.inc.S   | 0
 configure                                              | 8 +++-----
 meson.build                                            | 2 --
 tcg/{mips => mips64}/tcg-target-opc.h.inc              | 0
 tcg/{mips => mips64}/tcg-target.c.inc                  | 0
 13 files changed, 4 insertions(+), 8 deletions(-)
 rename linux-user/include/host/{mips => mips64}/host-signal.h (100%)
 rename tcg/{mips => mips64}/tcg-target-con-set.h (100%)
 rename tcg/{mips => mips64}/tcg-target-con-str.h (100%)
 rename tcg/{mips => mips64}/tcg-target-has.h (100%)
 rename tcg/{mips => mips64}/tcg-target-mo.h (100%)
 rename tcg/{mips => mips64}/tcg-target-reg-bits.h (100%)
 rename tcg/{mips => mips64}/tcg-target.h (100%)
 rename common-user/host/{mips => mips64}/safe-syscall.inc.S (100%)
 rename tcg/{mips => mips64}/tcg-target-opc.h.inc (100%)
 rename tcg/{mips => mips64}/tcg-target.c.inc (100%)

diff --git a/linux-user/include/host/mips/host-signal.h b/linux-user/include/host/mips64/host-signal.h
similarity index 100%
rename from linux-user/include/host/mips/host-signal.h
rename to linux-user/include/host/mips64/host-signal.h
diff --git a/tcg/mips/tcg-target-con-set.h b/tcg/mips64/tcg-target-con-set.h
similarity index 100%
rename from tcg/mips/tcg-target-con-set.h
rename to tcg/mips64/tcg-target-con-set.h
diff --git a/tcg/mips/tcg-target-con-str.h b/tcg/mips64/tcg-target-con-str.h
similarity index 100%
rename from tcg/mips/tcg-target-con-str.h
rename to tcg/mips64/tcg-target-con-str.h
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips64/tcg-target-has.h
similarity index 100%
rename from tcg/mips/tcg-target-has.h
rename to tcg/mips64/tcg-target-has.h
diff --git a/tcg/mips/tcg-target-mo.h b/tcg/mips64/tcg-target-mo.h
similarity index 100%
rename from tcg/mips/tcg-target-mo.h
rename to tcg/mips64/tcg-target-mo.h
diff --git a/tcg/mips/tcg-target-reg-bits.h b/tcg/mips64/tcg-target-reg-bits.h
similarity index 100%
rename from tcg/mips/tcg-target-reg-bits.h
rename to tcg/mips64/tcg-target-reg-bits.h
diff --git a/tcg/mips/tcg-target.h b/tcg/mips64/tcg-target.h
similarity index 100%
rename from tcg/mips/tcg-target.h
rename to tcg/mips64/tcg-target.h
diff --git a/MAINTAINERS b/MAINTAINERS
index c58fa93fd5..d3e6041186 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4074,7 +4074,7 @@ R: Huacai Chen <chenhuacai@kernel.org>
 R: Jiaxun Yang <jiaxun.yang@flygoat.com>
 R: Aleksandar Rikalo <arikalo@gmail.com>
 S: Odd Fixes
-F: tcg/mips/
+F: tcg/mips64/
 
 PPC TCG target
 M: Richard Henderson <richard.henderson@linaro.org>
diff --git a/common-user/host/mips/safe-syscall.inc.S b/common-user/host/mips64/safe-syscall.inc.S
similarity index 100%
rename from common-user/host/mips/safe-syscall.inc.S
rename to common-user/host/mips64/safe-syscall.inc.S
diff --git a/configure b/configure
index e9d0b9e2c0..04d0b214b6 100755
--- a/configure
+++ b/configure
@@ -400,10 +400,8 @@ elif check_define _ARCH_PPC64 ; then
   else
     cpu="ppc64"
   fi
-elif check_define __mips__ ; then
-  if check_define __mips64 ; then
-    cpu="mips64"
-  fi
+elif check_define __mips64 ; then
+  cpu="mips64"
 elif check_define __s390__ ; then
   if check_define __s390x__ ; then
     cpu="s390x"
@@ -455,7 +453,7 @@ case "$cpu" in
 
   mips64*|mipsisa64*)
     cpu=mips64
-    host_arch=mips
+    host_arch=mips64
     linux_arch=mips
     ;;
 
diff --git a/meson.build b/meson.build
index 0647ca0c89..c36f2f6962 100644
--- a/meson.build
+++ b/meson.build
@@ -265,8 +265,6 @@ enable_modules = get_option('modules') \
 
 if cpu not in supported_cpus
   host_arch = 'unknown'
-elif cpu == 'mips64'
-  host_arch = 'mips'
 elif cpu in ['riscv32', 'riscv64']
   host_arch = 'riscv'
 else
diff --git a/tcg/mips/tcg-target-opc.h.inc b/tcg/mips64/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/mips/tcg-target-opc.h.inc
rename to tcg/mips64/tcg-target-opc.h.inc
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips64/tcg-target.c.inc
similarity index 100%
rename from tcg/mips/tcg-target.c.inc
rename to tcg/mips64/tcg-target.c.inc
-- 
2.43.0


