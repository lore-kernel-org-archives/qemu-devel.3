Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A077C98315
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhatk-0002RQ-JX; Sun, 18 Jan 2026 17:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatK-00028n-0A
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:07 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatI-0000ba-B5
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:01 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a12ebe4b74so35806255ad.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773899; x=1769378699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KL546BRv3o5TBcmNuNTcD1O7NivqyCwfyc6P5AJbIyY=;
 b=Bvt0hEl81D1xNi8zeBV5X04qu9FORe3GNBGpMGL6zdPLMkB6Jq1Y+O3EYUIP8lz9Mo
 s6mDP5BP4tg98DUo1RuHs53PuRyfUg/QMrjGebcnWvKqR5DobpGxkaStrkm0IrCmSbOz
 Eu25hnz/ZwRZENAFTZ2CNv8aiUmyCBlSYgRQVtOnexjBsj+5ILGDY/JYIdISh45Wxpr+
 hqk4yHDwv3040bglVn9d+LhsM+j8st2zthMeeVhzgOzjXpEdjU9Jui2xvSsloKS6yULU
 Tzg7hEvadZCK+S9BqsnSc30XQzOROeqepENPnu7BopD40sCnApvcK2/gjyunY+B/joF2
 dEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773899; x=1769378699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KL546BRv3o5TBcmNuNTcD1O7NivqyCwfyc6P5AJbIyY=;
 b=dgbuWGWqPtMCtyz6xMxJAIdmwZy9eOSJUQ1+c9iavNdkkAIgLxrq0lx4gmWU1ytog/
 oFBDCfGHDpSAtAmm3DpWI1Ur8Qhuo6vXmG7kVEHpo/mwreYmJu5Y7EG3SL0ik6JCc83o
 IxzyTvuxAC8f2SBp+0PeccWPNnx6ZGA6B70krYHlj/ZJ3FyrtHw2r9IkFrkiazaHgNus
 MmcVTz23Gs8vMLkobMT+Wg3fY2g5o8ICcG9QW/p7ma6K3erLZBCaUhCg64WzsDxKFVAu
 MpMr+ynyOdX/Nd2AGMYfmKVAFu4EViNRhNySbajmyjuYpApmlqtsKlNcEHAOBJlaKuDX
 SnOA==
X-Gm-Message-State: AOJu0YxAPlx/FUtXnkv9ThiAnrzqqbzmRycZ1CK7pcZYvNP3tMdP/ruT
 7Atc1Wvz9u6Hf2RLeFMWGR1rvFGvoEszV1z8PY+LeJQ3be082F1shk58NOcbhuPyZNaHLL1XcGI
 cdCdBsSUNGw==
X-Gm-Gg: AY/fxX6p1HxE8pKgqEVuAkwOVtt0iw4wChHIJcUbP/I5yKfTb9+fQ8qpnmfBtWAim9N
 NbD65aOgBbEi1aufqLxk7BHDo2AWbciFE+ddxNFEm/kMpRUHK9o4w9sERrm3WZJ/MJQllIr/iYD
 IIxGFdwxUNdLcKvKaBZ20rxlruX7msfEPMX4HrH5/+/eDsTZxu+/qTGWduu+PONKTzTbNVLwv+k
 PS8u5Qd/mllpQ345iyq3hHjtkXSjGYOMJCJsO783qUmxfqQkT6pJLHh0gwe9+wPBYsazgKA2BM9
 SgU5QRLCXf++28yTjU9d0VV0cNsXPZW0W7KUiqQ+SkuSORlbwA69XbhSeS3gtBaW/LOByugnoDp
 x5WJD6KjJQ4H4cXJvnzH+2EVOVKV3JiJhSZttBxRhNU2Ks6oC15QJszyW87eZVOPvyB6hrQIAh6
 CR35/3llvbqwsPoEN5KMHQTaBzii5V
X-Received: by 2002:a17:903:b4e:b0:295:5da6:600c with SMTP id
 d9443c01a7336-2a71752979dmr104849255ad.2.1768773898985; 
 Sun, 18 Jan 2026 14:04:58 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:04:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 16/54] meson: Drop host_arch rename for mips64
Date: Mon, 19 Jan 2026 09:03:36 +1100
Message-ID: <20260118220414.8177-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


