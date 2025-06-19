Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E56C7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF5L-0003Ya-7a; Thu, 19 Jun 2025 09:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5K-0003YM-7M
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:13:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF5I-0003sY-OT
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:13:41 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-442fda876a6so6669295e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338819; x=1750943619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m13ygoLDvh6s/fst+7Tr47HarqNeCSRYva1lK7z13IU=;
 b=nZUvq2ofQw3FbdzHhfpC+uYa9WFyaVRilvpg0i5hLG4BDV+oWsbSfJS0BVMFbumbTx
 bpC6ooIGqy4gyvz2RBmU0+qbJtCjpKDqKzA+PD3Kj34PprBpsTrl7sWx0M9rv7CnDVTG
 hmvuYcOnCjuxBSAj15svNhDvCeCD1q4q4R73ZwfF/+hbvHCuAhJjSMHA58bi26Z9Qkvl
 h8Ky4wjcBPYokgnPgslzNi013/GaPjXtuGx9hETg2NNbR/4OxU49AzwkKrWWsKmA7+TT
 0zfYS8SWOgMdsQLQIVft8gcfuMEHOxviThvcjpAy86G6fkPiWT4xzYihhmF2qkKI2J2C
 +/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338819; x=1750943619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m13ygoLDvh6s/fst+7Tr47HarqNeCSRYva1lK7z13IU=;
 b=Z7iY3tDXdwHX488nzlShTds7HbkoelR8+QUP/J2K2jX0ed5A6DLBvCBZBk8x5ag/sH
 mPVKbFDvj1V2RjeVuaE7WY8WOlLRf9JTf98w5LU4uIKdU6tVmKxPPA+DN3Vgq/Ebvsk6
 MEUxP8tKtrzmyZ9iPy6AoAGCDWa41Tcu467y6G11tvWNoWfC3gWKE0zfFnBe/Dh9jazA
 SqUdCRgqUiIPbDKBFxLVGJOvpVWyEbtao88jfpMjBUHZzTo1HZQudL8ETQzR8yabp6OE
 DpLpsTIMOMoWJWqNKEm9tGhF4Mzmde0m3VhCg3J2De6fCWzqlZrJMyvJ9u6BmLpqr1PO
 Rcig==
X-Gm-Message-State: AOJu0YyoS7Q/SK5FMRExCBMkxv/PNg3tn03pu0PwwcEHSCgYaJWma6K/
 8Vmo86VrcARDBbwELPmw4RmJcnrF40C6f0YHYqyToNP0osnRk5oDoOtbDuOQMO7E1oGB7AnBQuB
 ltEtLb/s=
X-Gm-Gg: ASbGncsvqCDaK2DW3gQvSPg+GmMs8FH+YzmfChmG+kMHS/TQzvUQDVc+zfGz9G9nMMm
 3VdzqogDtgSbQauX2rSaDNhWeA2n328qCJUG1PePLnARVHmziUj10tsusFVwWtXXNgp7ZXZBNe/
 MUeX8zUV/mFdMZK/4zQpasftgck5kOINjxu0peX7jjJnhnrqRRQ6yrFRP/fU1Tbb35/be3xMqI7
 CrwFRR5M7wH1WAwmFtDu4tTAPMvL2u3EQU/ys0OqJ2C+30Ebcr163bBT8hixZj9lsm9x1UMC+Bw
 N+bsmSjHGhFxSQB54qsRkgbOP5JPzOg2/idxJKC3KPE3XUKonnfceurvGNvgioACbRxg0giMnbP
 C0hYFRC5XBi/v/p9+XX0hmVq4zJfi4p/w/mrI
X-Google-Smtp-Source: AGHT+IEO8Kjb4Mvn+BDG+XfJmXx2Yihaw89GQo0uaRCmp6Vgs4sSa39n5dXH1LqYB+JVnKA8de7+Fw==
X-Received: by 2002:a05:600c:c16a:b0:450:cea0:1781 with SMTP id
 5b1f17b1804b1-4533caad471mr208337255e9.16.1750338818974; 
 Thu, 19 Jun 2025 06:13:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a63a42sm19432884f8f.28.2025.06.19.06.13.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:13:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 03/20] target/arm: Unify gen_exception_internal()
Date: Thu, 19 Jun 2025 15:13:02 +0200
Message-ID: <20250619131319.47301-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Same code, use the generic variant.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/translate.h     | 1 +
 target/arm/tcg/translate-a64.c | 6 ------
 target/arm/tcg/translate.c     | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 1bfdb0fb9bb..0004a97219b 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -347,6 +347,7 @@ void arm_jump_cc(DisasCompare *cmp, TCGLabel *label);
 void arm_gen_test_cc(int cc, TCGLabel *label);
 MemOp pow2_align(unsigned i);
 void unallocated_encoding(DisasContext *s);
+void gen_exception_internal(int excp);
 void gen_exception_insn_el(DisasContext *s, target_long pc_diff, int excp,
                            uint32_t syn, uint32_t target_el);
 void gen_exception_insn(DisasContext *s, target_long pc_diff,
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ac80f572a2d..7c79b8c4401 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -433,12 +433,6 @@ static void gen_rebuild_hflags(DisasContext *s)
     gen_helper_rebuild_hflags_a64(tcg_env, tcg_constant_i32(s->current_el));
 }
 
-static void gen_exception_internal(int excp)
-{
-    assert(excp_is_internal(excp));
-    gen_helper_exception_internal(tcg_env, tcg_constant_i32(excp));
-}
-
 static void gen_exception_internal_insn(DisasContext *s, int excp)
 {
     gen_a64_update_pc(s, 0);
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 9962f43b1d0..f7d6d8ce196 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -372,7 +372,7 @@ static void gen_rebuild_hflags(DisasContext *s, bool new_el)
     }
 }
 
-static void gen_exception_internal(int excp)
+void gen_exception_internal(int excp)
 {
     assert(excp_is_internal(excp));
     gen_helper_exception_internal(tcg_env, tcg_constant_i32(excp));
-- 
2.49.0


