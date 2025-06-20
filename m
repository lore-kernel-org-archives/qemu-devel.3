Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895FBC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbT4-0002Of-H4; Fri, 20 Jun 2025 09:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbSt-0002LP-Vw
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbSs-0004Vv-FK
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:07:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so21254345e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424849; x=1751029649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4jpPoIjWAnN20gltB2a/vOsrmaIk3+mmplMj5/YsrY=;
 b=p6uRPjm8nNi3xleXh/tSBi9IPU12pLIq6HmOywtq84fAbVT7UW9DniAD0vBdgYkMKR
 4/g1x67D8S0zX7+XZetZKzMm1iRy73X+KBq/R8kbAoP6K2PuGQ5fhU9ejrqAx0dmCwmF
 UsSEZL5tiCteq24ruL6i7WestJXyLYMZoa9sYJDChV03pjSRaPp4lZqyxu7dr7GEIqP6
 gu6gQWkEfNcouFhUlWy4xIcQeh9sCGuR0gKTPLvQ7VwHCUXJip1byHtNOxcLasW7fwbg
 v7yg4Jg91T/aGGH3F0zj2bu8rltGn0Gvfa2kFlElI8ePOujPdafUb4hXoWBQ8zSP/aF2
 xUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424849; x=1751029649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4jpPoIjWAnN20gltB2a/vOsrmaIk3+mmplMj5/YsrY=;
 b=YCIm9V/efuYehzkonhQ7d0rEVnOIlR1POx/79osE6oUzQwBsYwm3wzbRZSiSADB0hB
 b/gHP5HKW7imcrVOMRcCktt+1n7BsO2TPo30Tv/HSjMqxCOXDDtxIGMCTFmmnuiow1Ea
 GNSMy8K/9zAKcUE98OHOmD4SGZZA1sRLgez/xjA/h/tBs08zTsKuec4yIf0AtPFqYZbr
 AnMvr00MSzH/9B1ITaClROJDmys/1FJxkXiNLtookAVsF6MugZ9/qFbYwofncQhYFQiT
 YnehHW0E6uE6lH8t5qu4kpv8/REzh+SGnuovruLn7Xu2pXnYxcfJApoUtYFJ81GgjDMV
 t7Lw==
X-Gm-Message-State: AOJu0YxxCSM6bE+M6tfUE1cfgibZap1sQlidnpIj5KzSkD6FdggWbAL8
 zYCg7/NSjTInXENUR4jqxv9sTHSgZs3ksAx60Dj9uXuEWdkMKhwj/gSRROuiau4K+xDpQYQzIU1
 BRG69/KM=
X-Gm-Gg: ASbGncvGFT8+ejmWfEN2/jyMU6szHPOUTZO1Aex1RL9fMeQMJWTVYys7pme3XJKO00u
 6wQ/bsqQUxZ0/Al9vAz6Q5b77FTUG8qHV9xeAFSSARgcxXRZ1W7+RD/dz81bmiD+1VUJKRmU5jP
 LvCh6cmmglqhgsOFMhsSbnrjrdsZSGchZh+YcjCp14R8dv+xfV+MzrR7BDYpKAi+ZhBU9sefUaG
 3znTmRflh+sgLaos/+uLOUzEnDnMGfRZpkKmhxrEyxF6a7VNdIGOp98FMdooDsHMbk8B97arnc/
 3delmT8gsO2ZhZiJYESIWCKwCPawPFBh2i40UDnFekfiGaM1nyoeMQHZkQftgyxInrvjc4lyp3X
 SUpMlvAKYMl/OyoZJTCkcL0DJrLRmVp58m9c4
X-Google-Smtp-Source: AGHT+IHvqyAxctyWiDO7wt3FaACda4gkUZk2ECgfjgeswwsSXX3ba2fXpQZsZ/3OnTwR/gx0VWlMzw==
X-Received: by 2002:a05:600c:154b:b0:43d:40b0:5b with SMTP id
 5b1f17b1804b1-453659b885emr24539615e9.25.1750424848387; 
 Fri, 20 Jun 2025 06:07:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535e983a4bsm59724925e9.13.2025.06.20.06.07.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:07:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 03/26] target/arm: Unify gen_exception_internal()
Date: Fri, 20 Jun 2025 15:06:46 +0200
Message-ID: <20250620130709.31073-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


