Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C6EEE6B66
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTh5-0001nU-Nu; Fri, 06 Feb 2026 16:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTgA-0008L5-2l
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:54 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTfv-0002mq-RV
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:47:53 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4359a316d89so2095047f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414458; x=1771019258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Sabe1ed6ifL0oxwMvrVlOomdFDzX8fb7sz8WwZS9Sw=;
 b=b7OvkmLgqAAVMEV+hpYIdATC4EutswOxXIvI2pS+cE+vkZlAbAWNYgClk9Cibe4mhi
 w4+dRk+K643Tve1dYB7ZMEii7hecexovI8WbXirLGBB7AXu0FM6pJsAejQ1GJK2ia2mu
 KnI21ExGFfp0F1oEsjIswlScGUvI5sTTXYeA3czRe2tcbHpcpWz5ZIsp1s7SXc1Tp7vJ
 ZA0ky/pT4ZJ5SX5+IuxrDUJncf8vFTokdP0qeK8KhvoAUcEnEDdeYgAPb6yeKJc49xuZ
 aUB1cSotZ4D9Ctk9EN0XXE1QOe8SMtvbOiyi9E96AVm1WPDfnHW8NArSmdDanIU+YpNi
 7kwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414458; x=1771019258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7Sabe1ed6ifL0oxwMvrVlOomdFDzX8fb7sz8WwZS9Sw=;
 b=ridNsIpdTt78e6L+AvCxavEfs6SqUzWVLfw6WM57Zr/gT4IGlLmnKH2CIi6V9gIzqy
 R+QEdSD+jONUcFEfZ3OWAqCWUn1aOwgDITk1Qgi+Uj2loZue5+HYDDNqzzc4bLfS1DRM
 PfybF/iP6+Y4BXy0ac7qT44UG+DMilMdI0OCQTVOOKUB5FqZdEpf0DVHYOT4vu2xlKIf
 ZtYkvteeAg0vQFyAFm/0+efRWvB3Q5HcBAXq/gjGsnSNRm5FeiSEtbXfOFa/wCoKbUSB
 IdSp84fWvlizxpa86TsVwnby8C5FiuMDu53Z867MPx9feg9+IBlyGR8coA628e3T1il0
 ZsVQ==
X-Gm-Message-State: AOJu0YxFERoVw08Jqyyv4TLiWKDYsm84XrAmIs+FOH80IN0ZYbaKmEjG
 ZVcdLRDwDNhni2igUE2aKHTInd0uM7nA97HjNA2DAzh86xX+WEjgETclQiPHSE47jOb1+93J25k
 Dj5og8JY=
X-Gm-Gg: AZuq6aIC4maZ064haqbjRJxciT9cWce88TwPu3VJ4s+Le3GL8D/8GTc3aUES5/odfU7
 Buiwb+W4I0AtPKvdifhhuDL7EoutPhDnAN5LN8UbW3gghJIZm4x5OxwNVWFjod0Kp13JTarlW35
 VVqBkEPwv560UzaMIxxpedjyIhw/LWnVHDz6hQbL4bWIxlRquvwUCNuRfeyAxfJ58mMGe/e7UyO
 DhMjLIdao844evXw8GV0Tn6kxa6idr5Y00PKTio9lEsLCKQxceQ8gAJwLgpW91j/Eio2js03fou
 oMKL0XAS77QCc0BSM/bwz9r2zonq++RV8uEEEB7lVG0Qz6espVyZJWSXzLoIfl4/Yu0+RxEibyb
 URFDDRwkdO3FyLZAmV2U2YhfMDAz76Rp6HOwd7LQ28MfTqrS4gSMKnHtuRzu3ODQ20KXnUE0L3G
 ZIHcQHrhypYwzpzvBcu36P3Rr8ovOw2zduPQDoTd8QCprqA8Q3LWmzsSnpr8AC
X-Received: by 2002:a05:6000:60f:b0:435:8a63:b8ba with SMTP id
 ffacd0b85a97d-4362938075amr7197362f8f.62.1770414457757; 
 Fri, 06 Feb 2026 13:47:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972faaasm8318271f8f.27.2026.02.06.13.47.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:47:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 25/30] tests/tcg/or1k: Rename from openrisc
Date: Fri,  6 Feb 2026 22:44:43 +0100
Message-ID: <20260206214448.22008-26-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
Acked-by: Stafford Horne <shorne@gmail.com>
Message-ID: <20260205030244.266447-5-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                | 2 +-
 tests/tcg/{openrisc => or1k}/test_add.c    | 0
 tests/tcg/{openrisc => or1k}/test_addc.c   | 0
 tests/tcg/{openrisc => or1k}/test_addi.c   | 0
 tests/tcg/{openrisc => or1k}/test_addic.c  | 0
 tests/tcg/{openrisc => or1k}/test_and_or.c | 0
 tests/tcg/{openrisc => or1k}/test_bf.c     | 0
 tests/tcg/{openrisc => or1k}/test_bnf.c    | 0
 tests/tcg/{openrisc => or1k}/test_div.c    | 0
 tests/tcg/{openrisc => or1k}/test_divu.c   | 0
 tests/tcg/{openrisc => or1k}/test_extx.c   | 0
 tests/tcg/{openrisc => or1k}/test_fx.c     | 0
 tests/tcg/{openrisc => or1k}/test_j.c      | 0
 tests/tcg/{openrisc => or1k}/test_jal.c    | 0
 tests/tcg/{openrisc => or1k}/test_lf_add.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_div.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_eqs.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_ges.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_gts.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_les.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_lts.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_mul.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_nes.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_rem.c | 0
 tests/tcg/{openrisc => or1k}/test_lf_sub.c | 0
 tests/tcg/{openrisc => or1k}/test_logic.c  | 0
 tests/tcg/{openrisc => or1k}/test_lx.c     | 0
 tests/tcg/{openrisc => or1k}/test_movhi.c  | 0
 tests/tcg/{openrisc => or1k}/test_mul.c    | 0
 tests/tcg/{openrisc => or1k}/test_muli.c   | 0
 tests/tcg/{openrisc => or1k}/test_mulu.c   | 0
 tests/tcg/{openrisc => or1k}/test_sfeq.c   | 0
 tests/tcg/{openrisc => or1k}/test_sfeqi.c  | 0
 tests/tcg/{openrisc => or1k}/test_sfges.c  | 0
 tests/tcg/{openrisc => or1k}/test_sfgesi.c | 0
 tests/tcg/{openrisc => or1k}/test_sfgeu.c  | 0
 tests/tcg/{openrisc => or1k}/test_sfgeui.c | 0
 tests/tcg/{openrisc => or1k}/test_sfgts.c  | 0
 tests/tcg/{openrisc => or1k}/test_sfgtsi.c | 0
 tests/tcg/{openrisc => or1k}/test_sfgtu.c  | 0
 tests/tcg/{openrisc => or1k}/test_sfgtui.c | 0
 tests/tcg/{openrisc => or1k}/test_sfles.c  | 0
 tests/tcg/{openrisc => or1k}/test_sflesi.c | 0
 tests/tcg/{openrisc => or1k}/test_sfleu.c  | 0
 tests/tcg/{openrisc => or1k}/test_sfleui.c | 0
 tests/tcg/{openrisc => or1k}/test_sflts.c  | 0
 tests/tcg/{openrisc => or1k}/test_sfltsi.c | 0
 tests/tcg/{openrisc => or1k}/test_sfltu.c  | 0
 tests/tcg/{openrisc => or1k}/test_sfltui.c | 0
 tests/tcg/{openrisc => or1k}/test_sfne.c   | 0
 tests/tcg/{openrisc => or1k}/test_sfnei.c  | 0
 tests/tcg/{openrisc => or1k}/test_sub.c    | 0
 tests/tcg/{openrisc => or1k}/Makefile      | 0
 53 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/tcg/{openrisc => or1k}/test_add.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_addc.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_addi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_addic.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_and_or.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_bf.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_bnf.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_div.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_divu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_extx.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_fx.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_j.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_jal.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_add.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_div.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_eqs.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_ges.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_gts.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_les.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_lts.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_mul.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_nes.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_rem.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lf_sub.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_logic.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_lx.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_movhi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_mul.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_muli.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_mulu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfeq.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfeqi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfges.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgesi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgeu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgeui.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgts.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgtsi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgtu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfgtui.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfles.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sflesi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfleu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfleui.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sflts.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfltsi.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfltu.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfltui.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfne.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sfnei.c (100%)
 rename tests/tcg/{openrisc => or1k}/test_sub.c (100%)
 rename tests/tcg/{openrisc => or1k}/Makefile (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f06f8ba512..660a0c78461 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -307,7 +307,7 @@ F: target/or1k/
 F: hw/or1k/
 F: include/hw/or1k/
 F: tests/functional/or1k/meson.build
-F: tests/tcg/openrisc/
+F: tests/tcg/or1k/
 
 PowerPC TCG CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
diff --git a/tests/tcg/openrisc/test_add.c b/tests/tcg/or1k/test_add.c
similarity index 100%
rename from tests/tcg/openrisc/test_add.c
rename to tests/tcg/or1k/test_add.c
diff --git a/tests/tcg/openrisc/test_addc.c b/tests/tcg/or1k/test_addc.c
similarity index 100%
rename from tests/tcg/openrisc/test_addc.c
rename to tests/tcg/or1k/test_addc.c
diff --git a/tests/tcg/openrisc/test_addi.c b/tests/tcg/or1k/test_addi.c
similarity index 100%
rename from tests/tcg/openrisc/test_addi.c
rename to tests/tcg/or1k/test_addi.c
diff --git a/tests/tcg/openrisc/test_addic.c b/tests/tcg/or1k/test_addic.c
similarity index 100%
rename from tests/tcg/openrisc/test_addic.c
rename to tests/tcg/or1k/test_addic.c
diff --git a/tests/tcg/openrisc/test_and_or.c b/tests/tcg/or1k/test_and_or.c
similarity index 100%
rename from tests/tcg/openrisc/test_and_or.c
rename to tests/tcg/or1k/test_and_or.c
diff --git a/tests/tcg/openrisc/test_bf.c b/tests/tcg/or1k/test_bf.c
similarity index 100%
rename from tests/tcg/openrisc/test_bf.c
rename to tests/tcg/or1k/test_bf.c
diff --git a/tests/tcg/openrisc/test_bnf.c b/tests/tcg/or1k/test_bnf.c
similarity index 100%
rename from tests/tcg/openrisc/test_bnf.c
rename to tests/tcg/or1k/test_bnf.c
diff --git a/tests/tcg/openrisc/test_div.c b/tests/tcg/or1k/test_div.c
similarity index 100%
rename from tests/tcg/openrisc/test_div.c
rename to tests/tcg/or1k/test_div.c
diff --git a/tests/tcg/openrisc/test_divu.c b/tests/tcg/or1k/test_divu.c
similarity index 100%
rename from tests/tcg/openrisc/test_divu.c
rename to tests/tcg/or1k/test_divu.c
diff --git a/tests/tcg/openrisc/test_extx.c b/tests/tcg/or1k/test_extx.c
similarity index 100%
rename from tests/tcg/openrisc/test_extx.c
rename to tests/tcg/or1k/test_extx.c
diff --git a/tests/tcg/openrisc/test_fx.c b/tests/tcg/or1k/test_fx.c
similarity index 100%
rename from tests/tcg/openrisc/test_fx.c
rename to tests/tcg/or1k/test_fx.c
diff --git a/tests/tcg/openrisc/test_j.c b/tests/tcg/or1k/test_j.c
similarity index 100%
rename from tests/tcg/openrisc/test_j.c
rename to tests/tcg/or1k/test_j.c
diff --git a/tests/tcg/openrisc/test_jal.c b/tests/tcg/or1k/test_jal.c
similarity index 100%
rename from tests/tcg/openrisc/test_jal.c
rename to tests/tcg/or1k/test_jal.c
diff --git a/tests/tcg/openrisc/test_lf_add.c b/tests/tcg/or1k/test_lf_add.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_add.c
rename to tests/tcg/or1k/test_lf_add.c
diff --git a/tests/tcg/openrisc/test_lf_div.c b/tests/tcg/or1k/test_lf_div.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_div.c
rename to tests/tcg/or1k/test_lf_div.c
diff --git a/tests/tcg/openrisc/test_lf_eqs.c b/tests/tcg/or1k/test_lf_eqs.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_eqs.c
rename to tests/tcg/or1k/test_lf_eqs.c
diff --git a/tests/tcg/openrisc/test_lf_ges.c b/tests/tcg/or1k/test_lf_ges.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_ges.c
rename to tests/tcg/or1k/test_lf_ges.c
diff --git a/tests/tcg/openrisc/test_lf_gts.c b/tests/tcg/or1k/test_lf_gts.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_gts.c
rename to tests/tcg/or1k/test_lf_gts.c
diff --git a/tests/tcg/openrisc/test_lf_les.c b/tests/tcg/or1k/test_lf_les.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_les.c
rename to tests/tcg/or1k/test_lf_les.c
diff --git a/tests/tcg/openrisc/test_lf_lts.c b/tests/tcg/or1k/test_lf_lts.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_lts.c
rename to tests/tcg/or1k/test_lf_lts.c
diff --git a/tests/tcg/openrisc/test_lf_mul.c b/tests/tcg/or1k/test_lf_mul.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_mul.c
rename to tests/tcg/or1k/test_lf_mul.c
diff --git a/tests/tcg/openrisc/test_lf_nes.c b/tests/tcg/or1k/test_lf_nes.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_nes.c
rename to tests/tcg/or1k/test_lf_nes.c
diff --git a/tests/tcg/openrisc/test_lf_rem.c b/tests/tcg/or1k/test_lf_rem.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_rem.c
rename to tests/tcg/or1k/test_lf_rem.c
diff --git a/tests/tcg/openrisc/test_lf_sub.c b/tests/tcg/or1k/test_lf_sub.c
similarity index 100%
rename from tests/tcg/openrisc/test_lf_sub.c
rename to tests/tcg/or1k/test_lf_sub.c
diff --git a/tests/tcg/openrisc/test_logic.c b/tests/tcg/or1k/test_logic.c
similarity index 100%
rename from tests/tcg/openrisc/test_logic.c
rename to tests/tcg/or1k/test_logic.c
diff --git a/tests/tcg/openrisc/test_lx.c b/tests/tcg/or1k/test_lx.c
similarity index 100%
rename from tests/tcg/openrisc/test_lx.c
rename to tests/tcg/or1k/test_lx.c
diff --git a/tests/tcg/openrisc/test_movhi.c b/tests/tcg/or1k/test_movhi.c
similarity index 100%
rename from tests/tcg/openrisc/test_movhi.c
rename to tests/tcg/or1k/test_movhi.c
diff --git a/tests/tcg/openrisc/test_mul.c b/tests/tcg/or1k/test_mul.c
similarity index 100%
rename from tests/tcg/openrisc/test_mul.c
rename to tests/tcg/or1k/test_mul.c
diff --git a/tests/tcg/openrisc/test_muli.c b/tests/tcg/or1k/test_muli.c
similarity index 100%
rename from tests/tcg/openrisc/test_muli.c
rename to tests/tcg/or1k/test_muli.c
diff --git a/tests/tcg/openrisc/test_mulu.c b/tests/tcg/or1k/test_mulu.c
similarity index 100%
rename from tests/tcg/openrisc/test_mulu.c
rename to tests/tcg/or1k/test_mulu.c
diff --git a/tests/tcg/openrisc/test_sfeq.c b/tests/tcg/or1k/test_sfeq.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfeq.c
rename to tests/tcg/or1k/test_sfeq.c
diff --git a/tests/tcg/openrisc/test_sfeqi.c b/tests/tcg/or1k/test_sfeqi.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfeqi.c
rename to tests/tcg/or1k/test_sfeqi.c
diff --git a/tests/tcg/openrisc/test_sfges.c b/tests/tcg/or1k/test_sfges.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfges.c
rename to tests/tcg/or1k/test_sfges.c
diff --git a/tests/tcg/openrisc/test_sfgesi.c b/tests/tcg/or1k/test_sfgesi.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfgesi.c
rename to tests/tcg/or1k/test_sfgesi.c
diff --git a/tests/tcg/openrisc/test_sfgeu.c b/tests/tcg/or1k/test_sfgeu.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfgeu.c
rename to tests/tcg/or1k/test_sfgeu.c
diff --git a/tests/tcg/openrisc/test_sfgeui.c b/tests/tcg/or1k/test_sfgeui.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfgeui.c
rename to tests/tcg/or1k/test_sfgeui.c
diff --git a/tests/tcg/openrisc/test_sfgts.c b/tests/tcg/or1k/test_sfgts.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfgts.c
rename to tests/tcg/or1k/test_sfgts.c
diff --git a/tests/tcg/openrisc/test_sfgtsi.c b/tests/tcg/or1k/test_sfgtsi.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfgtsi.c
rename to tests/tcg/or1k/test_sfgtsi.c
diff --git a/tests/tcg/openrisc/test_sfgtu.c b/tests/tcg/or1k/test_sfgtu.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfgtu.c
rename to tests/tcg/or1k/test_sfgtu.c
diff --git a/tests/tcg/openrisc/test_sfgtui.c b/tests/tcg/or1k/test_sfgtui.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfgtui.c
rename to tests/tcg/or1k/test_sfgtui.c
diff --git a/tests/tcg/openrisc/test_sfles.c b/tests/tcg/or1k/test_sfles.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfles.c
rename to tests/tcg/or1k/test_sfles.c
diff --git a/tests/tcg/openrisc/test_sflesi.c b/tests/tcg/or1k/test_sflesi.c
similarity index 100%
rename from tests/tcg/openrisc/test_sflesi.c
rename to tests/tcg/or1k/test_sflesi.c
diff --git a/tests/tcg/openrisc/test_sfleu.c b/tests/tcg/or1k/test_sfleu.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfleu.c
rename to tests/tcg/or1k/test_sfleu.c
diff --git a/tests/tcg/openrisc/test_sfleui.c b/tests/tcg/or1k/test_sfleui.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfleui.c
rename to tests/tcg/or1k/test_sfleui.c
diff --git a/tests/tcg/openrisc/test_sflts.c b/tests/tcg/or1k/test_sflts.c
similarity index 100%
rename from tests/tcg/openrisc/test_sflts.c
rename to tests/tcg/or1k/test_sflts.c
diff --git a/tests/tcg/openrisc/test_sfltsi.c b/tests/tcg/or1k/test_sfltsi.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfltsi.c
rename to tests/tcg/or1k/test_sfltsi.c
diff --git a/tests/tcg/openrisc/test_sfltu.c b/tests/tcg/or1k/test_sfltu.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfltu.c
rename to tests/tcg/or1k/test_sfltu.c
diff --git a/tests/tcg/openrisc/test_sfltui.c b/tests/tcg/or1k/test_sfltui.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfltui.c
rename to tests/tcg/or1k/test_sfltui.c
diff --git a/tests/tcg/openrisc/test_sfne.c b/tests/tcg/or1k/test_sfne.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfne.c
rename to tests/tcg/or1k/test_sfne.c
diff --git a/tests/tcg/openrisc/test_sfnei.c b/tests/tcg/or1k/test_sfnei.c
similarity index 100%
rename from tests/tcg/openrisc/test_sfnei.c
rename to tests/tcg/or1k/test_sfnei.c
diff --git a/tests/tcg/openrisc/test_sub.c b/tests/tcg/or1k/test_sub.c
similarity index 100%
rename from tests/tcg/openrisc/test_sub.c
rename to tests/tcg/or1k/test_sub.c
diff --git a/tests/tcg/openrisc/Makefile b/tests/tcg/or1k/Makefile
similarity index 100%
rename from tests/tcg/openrisc/Makefile
rename to tests/tcg/or1k/Makefile
-- 
2.52.0


