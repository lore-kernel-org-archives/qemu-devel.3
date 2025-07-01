Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD7A7C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSZ-0005fR-Db; Tue, 01 Jul 2025 13:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSW-0005cd-Jm
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:52 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSU-0003ap-NH
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:52 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a522224582so3131546f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389669; x=1751994469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=h3fZQFPQ4yVXaabIEx5Nimz04SLji8Cx5nJ315vJZ3Y=;
 b=Eujdbmao+kqJgWWahwmx3JY4DIpTMvCK9HAq5RHoZY986QchNXi5GdBeyps397ZgmP
 npOA4JJbyCs+IgacpmHvR3ZoRZOg21h9HkcAAxq7fbLglcWz5v4INE6WErNn6FEsBwpF
 5eXqWIE9tV/lhMc6OOyl7+KMu4m96sq0rjokrKe+blHl9i3IW4yVXzRaEhsHCWFFhxRZ
 2SPZhe/zvKxu7WyruteyvNJV6jN8yQAzlkw4gfSstVOCZelj2/vedaHsQvKwkQlqpNlN
 bRzDaWVrgauTxVNOXKBud0cwzBXisTVss67VYazghbUIfns8GpNHcVmwhOzelTm8D0kR
 iFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389669; x=1751994469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h3fZQFPQ4yVXaabIEx5Nimz04SLji8Cx5nJ315vJZ3Y=;
 b=u6nAHDH0T8z25K0kOyoF9vuEps7UbeR8HMrFhRDpqFHWqTEPARfbxFo7h8ttZnawZ6
 6AqlmBLLlJM9N0gVMuIwAD+jJcvLddje0n9knPN8bPl48m08EVZBh23oYr1AbdiPsHAq
 Tnk1Ev2HzQVEeAfpngz9JfacIUB3BODnYfawUU1iR4OsUpQw32AFrOtLOazyndfvUFnx
 dp1X1EmPuaNeCXw1walKS3DEa1y2lVTd+3Ripy6RVkuoqbWnboWTN0s5eIDt/xwo834j
 UWUtmodtvG7fWupEjva5qKHlcY15aZHycxZOSb5BsPYXPFgmykGkeOC2jEzuRpqK1TBw
 f1Ow==
X-Gm-Message-State: AOJu0YwrTvYtd3bnYGuq16Ti00c3aDpYnsGdjDVgPz8hrVXTBQhmlXpP
 53EXwzcbZJv10mjQaGXxlwrH0eppLajdkAfFs3hgCoUuKaqa/xu0naN3phaz/pYRUSoKSoH/k2P
 udVPj
X-Gm-Gg: ASbGncuVO6G+DiO0m+b0XbRP02ZewGmpZrE65cfgKIV35f38Ia4YxiqFCfxNr0wSQfW
 0HGkToBErem8gT7pur7yDTWN/Nw7A8zYxDXHyIK/yds/zAnL2cJy3eaWFEHORRNXk+7lOkDnvWY
 hr4Xg4zRGy6Erms6+eTTioq2VYZcC1wqG8kLSAthu1gLtCuk1SjeK1de8KEtzRPYIKHzRBvD/GG
 6O3L1Gj6mjmCpibiyFmuSNMOme3O/wj/kVUS6enHCUeOYa2TuhICWl2an8ZONu7UPDI4hX0tNWM
 vcrJB6DcM9pgF5WYlpSSsdkeVV5HJE/KTvZfX+L8wPHvSUt2m87yFgT9eBMepdp7hLY2
X-Google-Smtp-Source: AGHT+IGBwfJPcmOwPVVuX7A68FitwOCm++VkfzlPhC3Kd2oIquWByb4GOUscsVc1d1YNCl6NBisd1Q==
X-Received: by 2002:a05:6000:4408:b0:3a4:d8b6:ca3f with SMTP id
 ffacd0b85a97d-3a8ffdbefd5mr11291532f8f.30.1751389668671; 
 Tue, 01 Jul 2025 10:07:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/43] target/arm: Unify gen_exception_internal()
Date: Tue,  1 Jul 2025 18:07:02 +0100
Message-ID: <20250701170720.4072660-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Same code, use the generic variant.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250623121845.7214-4-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
index d0719b5665f..815225b1301 100644
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
2.43.0


