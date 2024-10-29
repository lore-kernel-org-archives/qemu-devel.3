Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391AAD3A66B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nsM-0001BO-IU; Tue, 29 Oct 2024 11:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns2-0000cm-P7
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:02 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5nrx-0007fr-Rv
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:10:57 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-539e59dadebso6613955e87.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730214652; x=1730819452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f2QKx5PpJ0hXtnqWhwoUN1/2lKp8MIaOWL67xtGys9o=;
 b=E1Nyz3YmZGywQBNltH5GKjLZVLTJ1jNxOqrCRchR0IjdHTpXdbGzF2dsOmSoWoSA31
 CM35yhzaZAfa56AjZK8xZzxwJKyt7FabY/1h0EAbCbU7FcWriZ6171pAXTr39baCqfxp
 h0Wiv9KSORtDGR8nda9z5+psxXZGi+dkY5SidjgJTem0a3bk6ujxYd/vLLF7mQgWneay
 ONLfgPFnf/xiLuYongMZMwu08Ff3I7vjjTSWR9HMD2iMzuRogKuN2KMsNisxCiMtgUZV
 FuJeElbbQtywcGcwp8Z8DjdHzxyFucvj70u34gfVWSkAbdzsrCTtdTtSQc1SYUqpWLMH
 xtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730214652; x=1730819452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f2QKx5PpJ0hXtnqWhwoUN1/2lKp8MIaOWL67xtGys9o=;
 b=t+LMNmMNN2OFLN4V3XMecTeCTrkwWX5WzABPxUnb8H6dQQq2ubrk9v9wbkFkclXEXo
 7GMcNnMC1ax2pJI6UwbE8ok/P6lBF/3H5zWwhYvVFaYtWRCDNLbBuqUwwQBjbcXjoTeN
 E5uwyPsPaplNNP0CECHxtYA1XbtJPJOah99dWddXRdMYPxR31cEWp8yo9+vqbRXf4Fzp
 JQzw+Y3UlfFbwV95hNtyQk4ux1O8AYUZEA/inc8R8EAqjvYNMfe2/xkKBW6UrjsIb7eW
 G2YH62vMa9XWfdb7M6CUpKkOPpr+Fwi1UvAhwtoLOdAh1tH095la+xNUg0Q9n+m6nZV+
 F/9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhMAIRXd9pXQcR/zR8G5QPDvLwtmlO6WDVBv+VFflXunKKlJhUgwHW8VLHtuckbfO+gxjVGYGi8RHj@nongnu.org
X-Gm-Message-State: AOJu0YwGn0m9wrL80phJ73+F2xtQqx6Ne+6blzBE1gFoIQD/SD2kG+rG
 GEleHu90SVbpVSFFrbn+Z86U6ZTw1PxtW/M1COW1E+qQH+2mxNOyQb/gNAp+nBY=
X-Google-Smtp-Source: AGHT+IE6Wsxffs1U0fP35sK4re6uBkFb3OJvbZUdFxO1gEBa/1SQH2NGXCKzJtzq2IsQs4gTj2qrJQ==
X-Received: by 2002:a05:6512:e91:b0:536:54df:bffa with SMTP id
 2adb3069b0e04-53b34c5f7e3mr5416157e87.45.1730214651888; 
 Tue, 29 Oct 2024 08:10:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm146835865e9.44.2024.10.29.08.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:10:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PULL 04/18] target/arm: Don't assert in regime_is_user() for E10
 mmuidx values
Date: Tue, 29 Oct 2024 15:10:34 +0000
Message-Id: <20241029151048.1047247-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029151048.1047247-1-peter.maydell@linaro.org>
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

In regime_is_user() we assert if we're passed an ARMMMUIdx_E10_*
mmuidx value. This used to make sense because we only used this
function in ptw.c and would never use it on this kind of stage 1+2
mmuidx, only for an individual stage 1 or stage 2 mmuidx.

However, when we implemented FEAT_E0PD we added a callsite in
aa64_va_parameters(), which means this can now be called for
stage 1+2 mmuidx values if the guest sets the TCG_ELX.{E0PD0,E0PD1}
bits to enable use of the feature. This will then result in
an assertion failure later, for instance on a TLBI operation:

#6  0x00007ffff6d0e70f in g_assertion_message_expr
    (domain=0x0, file=0x55555676eeba "../../target/arm/internals.h", line=978, func=0x555556771d48 <__func__.5> "regime_is_user", expr=<optimised out>)
    at ../../../glib/gtestutils.c:3279
#7  0x0000555555f286d2 in regime_is_user (env=0x555557f2fe00, mmu_idx=ARMMMUIdx_E10_0) at ../../target/arm/internals.h:978
#8  0x0000555555f3e31c in aa64_va_parameters (env=0x555557f2fe00, va=18446744073709551615, mmu_idx=ARMMMUIdx_E10_0, data=true, el1_is_aa32=false)
    at ../../target/arm/helper.c:12048
#9  0x0000555555f3163b in tlbi_aa64_get_range (env=0x555557f2fe00, mmuidx=ARMMMUIdx_E10_0, value=106721347371041) at ../../target/arm/helper.c:5214
#10 0x0000555555f317e8 in do_rvae_write (env=0x555557f2fe00, value=106721347371041, idxmap=21, synced=true) at ../../target/arm/helper.c:5260
#11 0x0000555555f31925 in tlbi_aa64_rvae1is_write (env=0x555557f2fe00, ri=0x555557fbeae0, value=106721347371041) at ../../target/arm/helper.c:5302
#12 0x0000555556036f8f in helper_set_cp_reg64 (env=0x555557f2fe00, rip=0x555557fbeae0, value=106721347371041) at ../../target/arm/tcg/op_helper.c:965

Since we do know whether these mmuidx values are for usermode
or not, we can easily make regime_is_user() handle them:
ARMMMUIdx_E10_0 is user, and the other two are not.

Cc: qemu-stable@nongnu.org
Fixes: e4c93e44ab103f ("target/arm: Implement FEAT_E0PD")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20241017172331.822587-1-peter.maydell@linaro.org
---
 target/arm/internals.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 299a96a81a7..fd8f7c82aa3 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -963,6 +963,7 @@ static inline uint32_t regime_el(CPUARMState *env, ARMMMUIdx mmu_idx)
 static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
+    case ARMMMUIdx_E10_0:
     case ARMMMUIdx_E20_0:
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_MUser:
@@ -972,10 +973,6 @@ static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
         return true;
     default:
         return false;
-    case ARMMMUIdx_E10_0:
-    case ARMMMUIdx_E10_1:
-    case ARMMMUIdx_E10_1_PAN:
-        g_assert_not_reached();
     }
 }
 
-- 
2.34.1


