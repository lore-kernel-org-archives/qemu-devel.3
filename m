Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C83EEE6B68
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTh4-0001fM-6f; Fri, 06 Feb 2026 16:48:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTfu-000844-CU
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:45 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTfp-0002mW-S9
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:37 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so24850585e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414451; x=1771019251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4pDpFYj1WOxP0DSIY/DR9eX9oYTZMJu2fUxtJrREkj8=;
 b=ZShoexsvP1QsHQn4ATPJV5XpYcm9fILhHlUxaiGovAkUIEhe//zCaDnorLCPn32Duq
 AJma9fTXxC9Z4ufeVs3PwJLzRlo58Yij93uuw847P42G+Jv+r+zZXwO5Xm5wjvYzKTWN
 9NW0aXgC/SDMrD2RcRRCaih1N58nqCfyp8MaFRYqonguE2ngSZctSnZBbT+fyT0M+WJM
 JjV8VdHSV3Mtpibd5sbGDTszAN/uRn/YZpF9jnuV1EL4vn+9F409SKce53ibV9zipT1X
 5tD/Ef7PFM09le2gDpAg3aOCU5CF5o71dk0IIbddN1ywcWtwkQyZFjWui2hmcNILJUCM
 dOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414451; x=1771019251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4pDpFYj1WOxP0DSIY/DR9eX9oYTZMJu2fUxtJrREkj8=;
 b=cTR7fzfulf0/CLD5lQ8i9xn4xBXpQjuV4/5dLKS7WA0/k10Fl57taATXLeGHacxBSe
 giHmmhdlRWAa2TvtfNDmV2OnlBuUQZHWgbglzhdI0eEOSKgfHH5gLRh4YpSTKDJT4NZB
 W1NSLUrO3cJwnYDlf+Hc1JtgODR02s8GlsNVnvAqnZ3qspffgRP8Cnm9kmUWuh0Mhvb8
 tF5kHug7TGE81UkuSwyky74xdngZPbamRUb02GhHZVCnrBxHmnqGR+w/F/5DS6elh9PO
 UzF2+DNrLfLLPrnpWOYZ4zjB9OhYuPOaxaZQwXMVZ+u6Hx3vVczWMGAZx9usGJYKiN8R
 Rczg==
X-Gm-Message-State: AOJu0Yx1oTm7782n1pqDe44KbCmKoGH6VjbO7NHGa9kTpNu7bvlrm7N6
 h/Wz2+jFq3Q8Wf/b2hnCodCmEFoY9xJ9HnrmjSLftRcLMrG0qiAxOuBMAa8ZhRzrJ44sRc0Ve6i
 d+Vodyrs=
X-Gm-Gg: AZuq6aIazt20rSDg7vf4ywSBI7VHCm04cCNWKyp1Eqa128JXeJT3i2vu18I0CHW9x/4
 HXoDAiNTqUoCbcfQQ6qMhd9/TXfJ3UoBsLWVADIZFqMY0/Zf+zJt0tvoEuLjJKoG6/WkueMtMAZ
 6YiZ2EDoybP16aCZZphG0d1T8zzBBzm3rSWeKlq12HFVBb/BfAnwwiuoQJ2/EdnppBd3kB0FpJ+
 6By2cbnDml3ZBzxpfZ4SaOXXOro8SQ4s/SBeB96bPBvG2EgWN8TKxNW/Ofpg+V8ft2Wp/HScgGB
 982KCojGMVOvvKu8Ca7dRKm/ALVENzERJ/+PlCvQCIH29Z7/0rXZDvwYPQwpQyaiO3wHaFhYn+U
 ll5wXY7hI2Qb3mERdLs3Ww7SMhiTndOv7fwFXCmKnAJ4YDOhXCgfoBPIKMolBf8wVpJA6ewrk8q
 uU6TqW17tZB5VxfJwyk8r9mryiucEa8YDKNUsJFQow52fCT7NAtzN657QS4GKY
X-Received: by 2002:a05:600c:3e14:b0:46f:a2ba:581f with SMTP id
 5b1f17b1804b1-483203db77emr59501305e9.16.1770414451212; 
 Fri, 06 Feb 2026 13:47:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48320728ac7sm75241615e9.13.2026.02.06.13.47.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:47:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 24/30] hw/or1k: Rename from openrisc
Date: Fri,  6 Feb 2026 22:44:42 +0100
Message-ID: <20260206214448.22008-25-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260205030244.266447-4-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                          | 4 ++--
 hw/{openrisc => or1k}/boot.c         | 0
 hw/{openrisc => or1k}/cputimer.c     | 0
 hw/{openrisc => or1k}/openrisc_sim.c | 0
 hw/{openrisc => or1k}/virt.c         | 0
 hw/Kconfig                           | 2 +-
 hw/meson.build                       | 2 +-
 hw/{openrisc => or1k}/Kconfig        | 0
 hw/{openrisc => or1k}/meson.build    | 0
 9 files changed, 4 insertions(+), 4 deletions(-)
 rename hw/{openrisc => or1k}/boot.c (100%)
 rename hw/{openrisc => or1k}/cputimer.c (100%)
 rename hw/{openrisc => or1k}/openrisc_sim.c (100%)
 rename hw/{openrisc => or1k}/virt.c (100%)
 rename hw/{openrisc => or1k}/Kconfig (100%)
 rename hw/{openrisc => or1k}/meson.build (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea52060bfe7..5f06f8ba512 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -304,7 +304,7 @@ M: Stafford Horne <shorne@gmail.com>
 S: Odd Fixes
 F: docs/system/openrisc/cpu-features.rst
 F: target/or1k/
-F: hw/openrisc/
+F: hw/or1k/
 F: include/hw/or1k/
 F: tests/functional/or1k/meson.build
 F: tests/tcg/openrisc/
@@ -1495,7 +1495,7 @@ M: Jia Liu <proljc@gmail.com>
 S: Maintained
 F: docs/system/openrisc/or1k-sim.rst
 F: hw/intc/ompic.c
-F: hw/openrisc/openrisc_sim.c
+F: hw/or1k/openrisc_sim.c
 F: tests/functional/or1k/test_sim.py
 
 PowerPC Machines
diff --git a/hw/openrisc/boot.c b/hw/or1k/boot.c
similarity index 100%
rename from hw/openrisc/boot.c
rename to hw/or1k/boot.c
diff --git a/hw/openrisc/cputimer.c b/hw/or1k/cputimer.c
similarity index 100%
rename from hw/openrisc/cputimer.c
rename to hw/or1k/cputimer.c
diff --git a/hw/openrisc/openrisc_sim.c b/hw/or1k/openrisc_sim.c
similarity index 100%
rename from hw/openrisc/openrisc_sim.c
rename to hw/or1k/openrisc_sim.c
diff --git a/hw/openrisc/virt.c b/hw/or1k/virt.c
similarity index 100%
rename from hw/openrisc/virt.c
rename to hw/or1k/virt.c
diff --git a/hw/Kconfig b/hw/Kconfig
index 9e6c789ae7e..f8f92b5d03d 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -58,7 +58,7 @@ source loongarch/Kconfig
 source m68k/Kconfig
 source microblaze/Kconfig
 source mips/Kconfig
-source openrisc/Kconfig
+source or1k/Kconfig
 source ppc/Kconfig
 source riscv/Kconfig
 source rx/Kconfig
diff --git a/hw/meson.build b/hw/meson.build
index 1022bdb8069..66e46b8090d 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -9,7 +9,7 @@ subdir('loongarch')
 subdir('m68k')
 subdir('microblaze')
 subdir('mips')
-subdir('openrisc')
+subdir('or1k')
 subdir('ppc')
 subdir('remote')
 subdir('riscv')
diff --git a/hw/openrisc/Kconfig b/hw/or1k/Kconfig
similarity index 100%
rename from hw/openrisc/Kconfig
rename to hw/or1k/Kconfig
diff --git a/hw/openrisc/meson.build b/hw/or1k/meson.build
similarity index 100%
rename from hw/openrisc/meson.build
rename to hw/or1k/meson.build
-- 
2.52.0


