Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B863BCD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsme-0000ce-9U; Tue, 26 May 2026 10:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmT-0008Q4-3u
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:20 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmQ-0001Gb-Iy
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:16 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso6825466f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805753; x=1780410553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wCc5uBVlW40H9499LhJ78HGB3MFCEeh30ulrOkWiyxY=;
 b=YCz3eBiZ3JWp6nAztt/omSwz+keaLKQdCQE7WqUhKs1CPEmoXQNBMa05+L8CFXr0oe
 MGGbzMdZJNGhT7cph8eE98BHlq/z/EON6nGAi9sPbK60rf97oqgiTwZZ4IB3caM/G08r
 0vBBuoK8W5oCR3RejJf+XceiaB9ZS8xu2Kq6BjydEfw7z2AjoaocRRzbKxJqI2Q6MRIQ
 yRLWQGPMgZ4a5Siet9RPBC2G/JpgqJDhwRr68yMFDvueJkrcj9c/Yr+x5BS4zl0KN6lU
 0GOg8wI6XqjlsaQSX+0FPnsXNbnCsxgaGjssVdxhEWA4qXI3LCK6ylh4I9H49LaAzsWP
 wxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805753; x=1780410553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wCc5uBVlW40H9499LhJ78HGB3MFCEeh30ulrOkWiyxY=;
 b=tXu65dwT8WwPn8btESNPCoXAAc3MHKF/wA7wBHTYuIKiSu4JIqmiA0sqLcwZ/ZRB+p
 aftQS57KEel2qhkqCECg4POMkAuJX3m1wawyEpPIPzD6c+w4GEh+PlWWMYUHnCPBdk88
 ISwZ4PAm4cLLpqyeW4V8zNx6bSHnLuFaL8PqjH7HaM9bvORsaRRJ2m4/EleJuoE5WPcZ
 RF1dp4hGTE21iMfEvOMdwy/HPSbUqXg1MNeEitukFHi+CL097TnWwL9onky2CxPzlAC6
 g1l6LXwKXXXV3F45OtDOjepokzG/C3qMraN+6kqjqfVtrr7TVcPc9aFmSjo6lq3afu3j
 hJZQ==
X-Gm-Message-State: AOJu0Yzmh9p+/H1isgEex8dFwS0uZp8Idibzf8EQCknO3PSb0PMniwZ+
 iZJ+RplVX+XW/hJb4Yrb9UeBRzaI8oQk/D90nd/HmSQwxZiVbSXeiY+fnaSAuXins0Lf77HmkRJ
 PW0v3
X-Gm-Gg: Acq92OHQeu1OfJvFq07OO0Ljcz4sNFTuk00mcfVlgUf9ij5Ckkugjx7FOYSt75u6nO/
 QbLa3bTf3bM8G/gVJndkoQ9l5Z5NiozVGebkhiLM56ydIMpqX/YLU0zoxstny2mvmpYsE/utL0Q
 FHO5URUz4FplyEl6oCjwOv0hknmEu72k+aelXWapCSv0RkIlrghdnLErkydqu3I9LYwyvekqz60
 UhMe65pU6fitxJPJQrqTh7nyIyyKVGjUDIAtMzwN3QINrmHLm94y3GjOOaqOBpauzSABJTbdt38
 Lnhw6VEf0+RnjyFuwsJCOr/IVx7VN8TEsSavqDS62ektGaynmGDomA2xwmdKvHQD3CgIrv27Tkm
 10BNHfPa/pZl3KVoJCz07N3J40J59jd2TkK6/5jRZX944Oc4rQ/vji6y6miB5HSW1/8NERaW6I/
 xTlnuEGtNOd8KRR/wOGIVFDFwjaad79+euibDDt/JSkdFygJNc3fAVWOPdDbufMRZrQrQGeAABl
 Ou0dcpRAqOTCtC5WNTtkc9tiRaARV4=
X-Received: by 2002:a05:6000:4701:b0:45e:8978:f176 with SMTP id
 ffacd0b85a97d-45eb365f1bfmr30375288f8f.0.1779805753229; 
 Tue, 26 May 2026 07:29:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/54] target/arm/ptw: Flip sense of get_phys_addr_twostage
 return value
Date: Tue, 26 May 2026 15:28:18 +0100
Message-ID: <20260526142850.2326589-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260515142541.571911-10-peter.maydell@linaro.org
---
 target/arm/ptw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index ca4b638c43..fec24f08fd 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3571,7 +3571,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
 
     /* If S1 fails, return early.  */
     if (ret) {
-        return ret;
+        return !ret;
     }
 
     ipa = result->f.phys_addr;
@@ -3602,7 +3602,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
 
     /* If S2 fails, return early.  */
     if (ret) {
-        return ret;
+        return !ret;
     }
 
     /*
@@ -3656,7 +3656,7 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
         result->f.attrs.space = arm_secure_to_space(result->f.attrs.secure);
     }
 
-    return false;
+    return true;
 }
 
 static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
@@ -3724,7 +3724,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
         ptw->in_mmu_idx = mmu_idx = s1_mmu_idx;
         if (arm_feature(env, ARM_FEATURE_EL2) &&
             !regime_translation_disabled(env, ARMMMUIdx_Stage2, ptw->in_space)) {
-            return get_phys_addr_twostage(env, ptw, address, access_type,
+            return !get_phys_addr_twostage(env, ptw, address, access_type,
                                           memop, result, fi);
         }
         /* fall through */
-- 
2.43.0


