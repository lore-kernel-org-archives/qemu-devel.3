Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D6BCC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPtN-0003q9-KR; Thu, 15 Oct 2026 14:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtJ-0003nw-S6
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:21 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtI-000123-9t
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:21 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48de72fc832so579456f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792087759; x=1792692559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/kkR/kQSuLB2juZ+1dQ9xVaYrFx9M1NCIhHwZztGJYE=;
 b=YIW/bn0wuvvWgwK3jH56AbHYvbBJ7ImelZZzzdlCi81b0v+OoCJH4VWlc6FWffJSdV
 o4Y9dJM9TL9FgyWF+0KiyBXmgybM8oyqKbZEvHgs9G+fta93M9iBo7sy3qF0iGvlphU3
 klkWelsmM7RORQOo8KjUBRITZeXQBXyF147yS9luuqxpgVn0ApolvuszAE8St4g+XFSo
 F9IKIn2ax/5waGfV5i9s4E8L78GShFg0Zg6hKMscx72F+GGa8EhvDrUmHWr+UnF2/ibw
 m4L9XlP/4tKT8pZq2eT8AnEuK/asGTZn7idRub3c5k7Om6Kb7UMEIgT7IR+yGTVTHYTW
 5oLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087759; x=1792692559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/kkR/kQSuLB2juZ+1dQ9xVaYrFx9M1NCIhHwZztGJYE=;
 b=XJxyOKTz2Yy5QB0Km/3DxNsro4cZESyYkNARfHaRaFuhXIe5LUH9FmoN2std0z7MN4
 oJNnhP6XjkfEfDphfZUKNCKQNHZoGcgtFbJC6t+FYox3jQorMUz5dkgMUnf14ZlLqYM1
 MvaCJmAjR7BrJq5yotthLFJBtl+l1i99dMEgml1Uz+Te87xljfjEpxxRkARTh0SbZFvz
 LFXZuCYBwCwDg3JASlRHbdneD65LT7HJ3RtdyM9iPV0H6Aqb6e5MiFDJc3vEf8LfBSqV
 2GLNEC+iOE29Psis4nbzMhK6ZlfaebiiOcmh0OxzXJkCSmYVyhxKA3jpP/x8dKYZRbMU
 HzPQ==
X-Gm-Message-State: AFq9FYLb5jZZ//PqIuELPWkC2D/fDhKrIOSv6CRO6FXKFfAosWp0jz3d
 AVBN2RBmJfLrhu4Z56VKEw3P8ixmFHzFl1tH5LWw649TavVb2Pf8+l2GAIiQrfZcX91B0dPQuoo
 1XJiTYWA=
X-Gm-Gg: AYBFou1tb71zsdVWOConrhlt/wqQ9rKauso1Q/2ljDJa5Y06qzaZ1SJklSanD9mTLSX
 Hq2mn0iJC8IuAjqk15HHhbLlPxrTVmzDRMfoLUSW7P3fbbeRsnF5AFm9SWzlaPT0QvGp3kYZhra
 ueCsYdOFnZbXAb408H8O3cmRS9908WrNajCsz3nnCPzV4wzzWoMTcDTtg64i+DucOMRV2A49bEu
 i/njIAw+sr2n/eLmrHYe7q70MTmJPc8BzQx6ib49c7+OpFDH2OVa2KAt2s+N3i09H465XOLMwxO
 tfv6NZ9MOM5J3i49pEVKg+tUeJJB6AZdpNdq3V2HOY2tKiFXt3lHAuU0Xwh2ZlhuAM+AEC2EtF2
 OaRYNK7rWBJNm0KGIf7jUOcjsalmSR1Y8Rmfo7+W//ft6YcdzARKVljJiM5PA44d+cAcRNA30bP
 TGCjyuRl9db43H/odhVakCXW/y2uNdf2W+boLoHU+81xswG7VdPAnVxkkhwSq6XZY3HmpyX6qjS
 tkXqIR0o6W93YwSZP5sAbH+JrygAKSISR7leFmGGbG1WigzgUmkGcJdlc2PW23uqPhCuKKYiM6A
 Y97C/C9oC+Izig==
X-Received: by 2002:a5d:6046:0:b0:488:8384:c382 with SMTP id
 ffacd0b85a97d-48dbacef9acmr32096815f8f.49.1792087758713; 
 Thu, 15 Oct 2026 11:09:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm14692701f8f.13.2026.10.15.11.09.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:09:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/16] target/arm: Enable FEAT_IDTE3 for -cpu max
Date: Thu, 15 Oct 2026 19:08:56 +0100
Message-ID: <20261015180858.1863407-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015180858.1863407-1-peter.maydell@linaro.org>
References: <20261015180858.1863407-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20261010070952.323466-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 3bd5c42a664..d1467ef4bfb 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -105,6 +105,7 @@ the following architecture extensions:
 - FEAT_HPMN0 (Setting of MDCR_EL2.HPMN to zero)
 - FEAT_I8MM (AArch64 Int8 matrix multiplication instructions)
 - FEAT_IDST (ID space trap handling)
+- FEAT_IDTE3 (Trapping ID register accesses to EL3)
 - FEAT_IESB (Implicit error synchronization event)
 - FEAT_IVIPT (The IVIPT Extension)
 - FEAT_JSCVT (JavaScript conversion instructions)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 59692dddcfa..c92e331e731 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1461,6 +1461,10 @@ void aarch64_max_v9_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64PFR2, FPMR, 1);      /* v9.2: FEAT_FPMR */
     SET_IDREG(isar, ID_AA64PFR2, t);
 
+    t = GET_IDREG(isar, ID_AA64MMFR2);
+    t = FIELD_DP64(t, ID_AA64MMFR2, IDS, 2);      /* v9.0: FEAT_IDTE3 */
+    SET_IDREG(isar, ID_AA64MMFR2, t);
+
     t = GET_IDREG(isar, ID_AA64MMFR3);
     t = FIELD_DP64(t, ID_AA64MMFR3, MEC, 1);      /* v9.2: FEAT_MEC */
     SET_IDREG(isar, ID_AA64MMFR3, t);
-- 
2.43.0


