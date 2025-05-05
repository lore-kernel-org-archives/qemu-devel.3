Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639EBC369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl4J-0001lj-IM; Sun, 04 May 2025 21:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4G-0001aF-6K
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:29 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl4E-00035K-0O
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:56:27 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-30820167b47so3570993a91.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746410184; x=1747014984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F6rvyCptpZZum3a3XLfgy4KbKHlT47oeB0wfjegrLwc=;
 b=aOhfybohgMYFAzsfTi21/eJq4JPPiiA3mPkHsIexipuBBej1mw8eP1zaxUU3QIVkTb
 o0ypWSrbOcdQiRX6r4xn4XttyXAxxOEf78/ZS1q2ANPpRQUt40/WHmULK5OS4Zlqx0qx
 +58J1mB2zl4MsC/GjlJgL/d9l8PAAVp+CrUEqUO0qcWGBwBwnpVyVTF8u1PbslntweDj
 IR9as6a9Nib0N1iidL1+zlCcO8t6aTtk1l8j8Hi+YA1nha42L9yIXCl4nD5y2bwYnaMY
 1EFckAzn9GAls/uNF16QIom1ii1luRqRgzGF7MA+CyCJ1XTEiBnmPkXfoRxdAtpodEeK
 kz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746410184; x=1747014984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F6rvyCptpZZum3a3XLfgy4KbKHlT47oeB0wfjegrLwc=;
 b=vT0tN0WuCW9XUXuAMkzcusWlv5HsZhDqOEo7dsl7bKsy99zhAe3KQt1GHsxtX+iObG
 UZjJ9oYLs0DJWP3kgP3lQOeJ2MNCsnTC4waAIZtMf+7ZzGwuEb19GHlHZkuw/HhbnS3M
 Do5NJ8QFuFBPV8dObcCCQllcaTXNokPOAW2I0rNSTVly03k9nL6PoNKGuBl4YMwYf2fq
 wq3PqJ/aQuhy0FmOFOjNvBbhxl1grRbX5EqtZ0+WTtVl5DZ2EO6JmD+WM3LCfYtp7ywE
 NuJoo3jNs9bOdI+GuDVCCujxgx7CPpc1xvCJffbfS7Nz+TjzeKZrv5q+c3kISLGFP6yo
 ndkQ==
X-Gm-Message-State: AOJu0Yz0ym7jTSoKDNdlfdbbgUQrupVQnXtMUjGGrCAPY7995Czqh1SE
 bDeKqlwh2XgL5fOxWfjk4z+umyVMnzWtMk2X/hz//3i/1S1q5b3Ell6EXaSap55VCuGcQWa/XbV
 lQ98=
X-Gm-Gg: ASbGncsNdfDHdvqUIAlB8xFWsS695FAS1faPbtal+MkGV2ALTqTlD6+E0hCDb+nVQuq
 FdhVTW0ko3fcmyL1msM1LLR3PaoIM1e2WusnaVS8EuN23bf/V73vb49KR41YXT5A+XMhCTbMMGd
 rhOgzHhXfBt4GliUC3b0M7GUjSWjLU1gqBej8LMpqE2Ltl/WouzukMkBFYzRak40862qGlybb1w
 LSnq9JO97aKDWIACNFAGz/pmOGK5P3GCRY6IXLNjufcUOdmS5fsigFuLY6bR8hygq0J+D2kZPBy
 di1Pi5/W+OhrJ5xZrvJC2qOR9xRiI7vMCEPhHz8d
X-Google-Smtp-Source: AGHT+IGit+JLh7j94oEa65elMcYUy5zCoUjV9A6bao3GjfXJLsS5Z1ncHzwZWCairFLXqpsh9XIIvA==
X-Received: by 2002:a17:90b:548c:b0:2ee:c30f:33c9 with SMTP id
 98e67ed59e1d1-30a4e228570mr16054269a91.14.1746410184424; 
 Sun, 04 May 2025 18:56:24 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a47640279sm7516495a91.44.2025.05.04.18.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:56:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 40/48] target/arm/machine: compile file once (system)
Date: Sun,  4 May 2025 18:52:15 -0700
Message-ID: <20250505015223.3895275-41-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index bb1c09676d5..b404fa54863 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -13,7 +13,6 @@ arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
-  'machine.c',
 ))
 arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
@@ -39,6 +38,7 @@ arm_common_system_ss.add(files(
   'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
+  'machine.c',
   'ptw.c',
   'vfp_fpscr.c',
 ))
-- 
2.47.2


