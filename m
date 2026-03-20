Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C23C1098782
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYg-00035G-EP; Fri, 20 Mar 2026 09:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYT-0002sx-Cl
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:21 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYR-000621-AU
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:21 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6674cba2c50so4140295a12.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011977; x=1774616777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8STStOoYQOEp/cfPPvlXjVBa3GE+wDGGrfV/kvX1ag8=;
 b=boAPTB9eSQnVr5ES+YGqhk6SBBc8NN6Ro7rVZq5//F7DqlEF2IqNGcOWnBfxJx9V/T
 Ctx1OtEvfYMobng9LpyV/Q+aPODn3C/aBMdrUWFxSRsNJBTmB/V1A/VjIvMx5hWHgo9X
 XsDXtKlXK1ujbdOep0L1M4Poqqd401/znnFOpKPzIneNYBREFWVphYoH5uL5YwpLofxg
 Ruuf+b6Vu16xnkV0VvPs2wWTPWusaf1z20tMYH3DGAhDE/IpocwdEU705qLxQ1GY1QGl
 Ehs7JLbiEYwZjSdp0uMBrwZ9GVPVQkQNn3LpFAQehgk6wf+vR/tOkzav7ms0Hi2x5+bA
 xlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011977; x=1774616777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8STStOoYQOEp/cfPPvlXjVBa3GE+wDGGrfV/kvX1ag8=;
 b=r8l+6X1PEFBo/RQZMXUWRmv8Aumt3lNIo5SZBn19k5b1hywlThOoAfs5PAUivYPSPG
 nprDoH8yUTizAOsdBu+gzC3QsaiJCfHEMAPDclNBBqYIphvElIfR4Gm8poX7KqPje0tC
 V7AO9y98D9pqVY/EYfXk/ciVuijcYBnX10t/030Bx+UFM0ykh4tZ0i1WS0tbRnxq6sx+
 FEygdK35HUz9L/ZjwEHL6Yfb2MX34WLxUayVmZTGOoPJ2KmaCdNKGxBLcHIog67BidJh
 rW6l2KWvbrb3rlxpjU2O/a3xc4HknB3gSTQzhMjxt+YnLgqFg+oWYlmzuf+4s/sMfiX0
 mWIw==
X-Gm-Message-State: AOJu0YxjgeUnN1HTuKxL8oM1gPbUcy8GL2oDa23xD4PrvK84ukiTxHZ1
 c84folp8hFowcRGjrMyDqMWacokDWilSslPTkqCwZgFH9RRXOz4NfF/h4Cp1hdpUJyE=
X-Gm-Gg: ATEYQzxvtje/IyEc0Qrp4qcimGEBwCRSWNrrmkda7wetsFWFtjEnUKJYz01gbkCprc0
 JescBHcPBUCWNP93PzsRTLIPLz2TjMyXOLZPq3urZafUZiZy49IfpD0mlEDB6skv4JwmIy4mLOK
 ZPkjXosbYKTsr+qui/jkdHsVx0/ZXXrQZNvHrw1Av97sJKlOM4N246YRiXAmEgpywt9ZLrKvY25
 1XHxgoWwHkDVj8xxm3TI+GtcUu0FAgluuCi55dnVB4WER+9txJ+WIXgkog1pVERuuiz3HiosEoo
 3zJ17lsjRZaVJBBKbpNGJCyOEvVfwERvoPWSBbuaFsfJTyYeXLFqxYRKOLbB12NCe9JrEOSv0Cm
 CEpQl7PiS0DFf41iPZ/tSVTV/YvvG+vtgEzHIb2ZPHxdxTOUCD9owxei6ZFWGqX7UuNiLDvMeNu
 WI4pXIcLstomij3uEUJW/mp2M=
X-Received: by 2002:a17:907:7f86:b0:b98:654:d9eb with SMTP id
 a640c23a62f3a-b980fa92acamr415061866b.22.1774011977490; 
 Fri, 20 Mar 2026 06:06:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b983387085fsm155870666b.52.2026.03.20.06.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:16 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D59F15F9CE;
 Fri, 20 Mar 2026 13:06:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 15/35] target/arm: migrate check_hcr_el2_trap to use
 syndrome helper
Date: Fri, 20 Mar 2026 13:05:46 +0000
Message-ID: <20260320130607.2071996-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

It shares the same COPROC_ISS encoding as the other CP traps although
not all the fields are used.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h       | 16 ++++++++++++++++
 target/arm/tcg/vfp_helper.c |  5 +----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 2e3121aec9c..4fbc35ce7b0 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -251,6 +251,22 @@ FIELD(COPROC_ISS, OP2, 17, 3)
 FIELD(COPROC_ISS, COND, 20, 4)
 FIELD(COPROC_ISS, CV, 24, 1)
 
+static inline uint32_t syn_cp10_rt_trap(int cv, int cond, int opc1,
+                                        int crn, int rt, int isread)
+{
+    uint32_t res = syn_set_ec(0, EC_FPIDTRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, COPROC_ISS, CV, cv);
+    res = FIELD_DP32(res, COPROC_ISS, COND, cond);
+    res = FIELD_DP32(res, COPROC_ISS, OP1, opc1);
+    res = FIELD_DP32(res, COPROC_ISS, CRN, crn);
+    res = FIELD_DP32(res, COPROC_ISS, RT, rt);
+    res = FIELD_DP32(res, COPROC_ISS, ISREAD, isread);
+
+    return res;
+}
+
 static inline uint32_t syn_cp14_rt_trap(int cv, int cond, int opc1, int opc2,
                                         int crn, int crm, int rt, int isread,
                                         bool is_16bit)
diff --git a/target/arm/tcg/vfp_helper.c b/target/arm/tcg/vfp_helper.c
index 45f2eb0930f..e692bc568bd 100644
--- a/target/arm/tcg/vfp_helper.c
+++ b/target/arm/tcg/vfp_helper.c
@@ -1359,10 +1359,7 @@ void HELPER(check_hcr_el2_trap)(CPUARMState *env, uint32_t rt, uint32_t reg)
         g_assert_not_reached();
     }
 
-    syndrome = ((EC_FPIDTRAP << ARM_EL_EC_SHIFT)
-                | ARM_EL_IL
-                | (1 << 24) | (0xe << 20) | (7 << 14)
-                | (reg << 10) | (rt << 5) | 1);
+    syndrome = syn_cp10_rt_trap(1, 0xe, 7, reg, rt, 1);
 
     raise_exception(env, EXCP_HYP_TRAP, syndrome, 2);
 }
-- 
2.47.3


