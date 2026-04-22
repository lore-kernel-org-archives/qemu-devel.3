Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A93FF9EDC9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFX5a-0006Ng-OM; Wed, 22 Apr 2026 08:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4k-00060O-43
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4g-0005U0-3a
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:05 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488ba840146so49869625e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 05:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862379; x=1777467179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPvaC3auN+3Ca9Dko/At0hA0QqcpQF6nrnCTiO0WhDI=;
 b=U2Gn7jYZATyYZDJF25skhhQfSNxCa83ATsxr24EkTT6dqWxXYKveP65ES76/6fuV/L
 05URbu0Jw67K4hhkgu8MZ2l0h8A3tXKI22WMEl8DNeXv6PrPKT90uBqlV2mNssFLkKT0
 8rFu+Mqr4NxSgUzbe+mwS126deeA6nEyl3jT+MyiHFJX1G8UUMulw7boja8mG2bjTazI
 SwEmhaAFFVmgMLGYXrYnT+c8AJfsPG22iKJWWWALnr1hBiGWshEFfOMcjmtAg3OAW4wP
 Q4nbgHYZ21DB8A917I4q1/ahsmcZTII556rikgUJTyV/4qtEcM8z4RPC6MVWpLS7HYEc
 7ILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862379; x=1777467179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VPvaC3auN+3Ca9Dko/At0hA0QqcpQF6nrnCTiO0WhDI=;
 b=JRCzGXPUW1A8fxDoTGL+PKwXxhgxNLh9bd3UZtIHu1gRRF0t0ss9HgEf5cSF0MMUdK
 mxBKJlRXssNF2eH9uDoX9cdScvC3ZDg3HrSfr4wW/92vcoMOk8a0/dV61d+T1PDBL+Lq
 QYIe/Rw+CIRIZSgwnfOJGAqx88godtWfmKc9i8kp+i6RQ9EiCY57wXC2KIhuNLq2H/Mi
 RJYPJ4Q9XWJduhzEaKI2ShOFDgAD93Ek7AKxPG2P6MscPmFK2TiDVOP8aJRO9qBpB5VS
 r6vWoTb8fvWRQaHM6+CDsQxH/xmejngsqg576NnfSmQ0AyO9FUL9Tuo/yknyuNgEhjxY
 8fTg==
X-Gm-Message-State: AOJu0YyihjNZBKOTgLm5S68Ikpcd3923N57cLFK5ldBalwP7V9FRnzb9
 ED8Bb1t/zq8OMUWUCx10KDJ3muXiunhz2sUKEwqIhKVCj8P7lZzOHsBkVs3xPLu6hVw=
X-Gm-Gg: AeBDiet7VgU4TnqUWP5LHX5uIFHfSl/yJ/Sv6H9hiHvtuh1bEfRpd9KvJeAD/8K5gTd
 7FSsImNLQXjJ5QUb6xbP9OnVVWtXsimxXe5Fp+jVLvguc77ccSAF5sMWQUFYRsJoblpODmgR763
 2YkxusnOIPI/xO9Wfh7v8Rb9lZL+J0MoFG2v6F0Zyq+gdUS9c28CGESWzVzshLow/CmkXQPdW3r
 O97N1wMFGyEDHA1D47rG9sPKO8hphsO4eDpbozWGQ9ESJ0VaTwjHez/8hHgt5NrVEcHeWpafBDx
 GqE+4DOEDcrg6/KWJwphnPloz2e+GPvOsD/N0RQjuPPlJhNa50jHo+znHcrw+Y3LDKromxyJr2F
 G319jomNRiQVTIUVRqE12TKjERJcHESELRXZNJj2wwRg2RCXFsQQ7KG32ioqu7Nl8+PDiYE6k5p
 WJD6I0Phop+CcGImVzIZtSFP+jVKcw8yhbKw==
X-Received: by 2002:a05:600c:450c:b0:487:55c:e0c1 with SMTP id
 5b1f17b1804b1-488fb768816mr309582475e9.14.1776862378790; 
 Wed, 22 Apr 2026 05:52:58 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5aa3ae83sm83319095e9.12.2026.04.22.05.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 05:52:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B7D6C60EE9;
 Wed, 22 Apr 2026 13:52:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 10/32] target/arm: migrate fault syndromes to registerfields
Date: Wed, 22 Apr 2026 13:52:27 +0100
Message-ID: <20260422125250.1303100-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Migrate syn_insn_abort and syn_data_abort_* to the registerfields API.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use !is_16bit directly
---
 target/arm/syndrome.h | 87 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 74 insertions(+), 13 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index bc65106c61a..2031b3704fb 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -494,20 +494,64 @@ static inline uint32_t syn_gpc(int s2ptw, int ind, int gpcsc, int vncr,
     return res;
 }
 
+/*
+ * ISS encoding for an exception from an Instruction Abort
+ *
+ * (aka instruction abort)
+ */
+FIELD(IABORT_ISS, IFSC, 0, 6)
+FIELD(IABORT_ISS, S1PTW, 7, 1)
+FIELD(IABORT_ISS, EA, 9, 1)
+FIELD(IABORT_ISS, FnV, 10, 1) /* FAR not Valid */
+FIELD(IABORT_ISS, SET, 11, 2)
+FIELD(IABORT_ISS, PFV, 14, 1)
+FIELD(IABORT_ISS, TopLevel, 21, 1) /* FEAT_THE */
+
 static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
 {
-    return (EC_INSNABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-        | ARM_EL_IL | (ea << 9) | (s1ptw << 7) | fsc;
+    uint32_t res = syn_set_ec(0, EC_INSNABORT + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, IABORT_ISS, EA, ea);
+    res = FIELD_DP32(res, IABORT_ISS, S1PTW, s1ptw);
+    res = FIELD_DP32(res, IABORT_ISS, IFSC, fsc);
+
+    return res;
 }
 
+/*
+ * ISS encoding for an exception from a Data Abort
+ */
+FIELD(DABORT_ISS, DFSC, 0, 6)
+FIELD(DABORT_ISS, WNR, 6, 1)
+FIELD(DABORT_ISS, S1PTW, 7, 1)
+FIELD(DABORT_ISS, CM, 8, 1)
+FIELD(DABORT_ISS, EA, 9, 1)
+FIELD(DABORT_ISS, FnV, 10, 1)
+FIELD(DABORT_ISS, LST, 11, 2)
+FIELD(DABORT_ISS, VNCR, 13, 1)
+FIELD(DABORT_ISS, AR, 14, 1)
+FIELD(DABORT_ISS, SF, 15, 1)
+FIELD(DABORT_ISS, SRT, 16, 5)
+FIELD(DABORT_ISS, SSE, 21, 1)
+FIELD(DABORT_ISS, SAS, 22, 2)
+FIELD(DABORT_ISS, ISV, 24, 1)
+
 static inline uint32_t syn_data_abort_no_iss(int same_el, int fnv,
                                              int ea, int cm, int s1ptw,
                                              int wnr, int fsc)
 {
-    return (EC_DATAABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-           | ARM_EL_IL
-           | (fnv << 10) | (ea << 9) | (cm << 8) | (s1ptw << 7)
-           | (wnr << 6) | fsc;
+    uint32_t res = syn_set_ec(0, EC_DATAABORT + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, DABORT_ISS, FnV, fnv);
+    res = FIELD_DP32(res, DABORT_ISS, EA, ea);
+    res = FIELD_DP32(res, DABORT_ISS, CM, cm);
+    res = FIELD_DP32(res, DABORT_ISS, S1PTW, s1ptw);
+    res = FIELD_DP32(res, DABORT_ISS, WNR, wnr);
+    res = FIELD_DP32(res, DABORT_ISS, DFSC, fsc);
+
+    return res;
 }
 
 static inline uint32_t syn_data_abort_with_iss(int same_el,
@@ -517,11 +561,22 @@ static inline uint32_t syn_data_abort_with_iss(int same_el,
                                                int wnr, int fsc,
                                                bool is_16bit)
 {
-    return (EC_DATAABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
-           | (is_16bit ? 0 : ARM_EL_IL)
-           | ARM_EL_ISV | (sas << 22) | (sse << 21) | (srt << 16)
-           | (sf << 15) | (ar << 14)
-           | (ea << 9) | (cm << 8) | (s1ptw << 7) | (wnr << 6) | fsc;
+    uint32_t res = syn_set_ec(0, EC_DATAABORT + same_el);
+    res = FIELD_DP32(res, SYNDROME, IL, !is_16bit);
+
+    res = FIELD_DP32(res, DABORT_ISS, ISV, 1);
+    res = FIELD_DP32(res, DABORT_ISS, SAS, sas);
+    res = FIELD_DP32(res, DABORT_ISS, SSE, sse);
+    res = FIELD_DP32(res, DABORT_ISS, SRT, srt);
+    res = FIELD_DP32(res, DABORT_ISS, SF, sf);
+    res = FIELD_DP32(res, DABORT_ISS, AR, ar);
+    res = FIELD_DP32(res, DABORT_ISS, EA, ea);
+    res = FIELD_DP32(res, DABORT_ISS, CM, cm);
+    res = FIELD_DP32(res, DABORT_ISS, S1PTW, s1ptw);
+    res = FIELD_DP32(res, DABORT_ISS, WNR, wnr);
+    res = FIELD_DP32(res, DABORT_ISS, DFSC, fsc);
+
+    return res;
 }
 
 /*
@@ -530,8 +585,14 @@ static inline uint32_t syn_data_abort_with_iss(int same_el,
  */
 static inline uint32_t syn_data_abort_vncr(int ea, int wnr, int fsc)
 {
-    return (EC_DATAABORT << ARM_EL_EC_SHIFT) | (1 << ARM_EL_EC_SHIFT)
-        | ARM_EL_IL | ARM_EL_VNCR | (wnr << 6) | fsc;
+    uint32_t res = syn_set_ec(0, EC_DATAABORT_SAME_EL);
+    res = FIELD_DP32(res, SYNDROME, IL, 1);
+
+    res = FIELD_DP32(res, DABORT_ISS, VNCR, 1);
+    res = FIELD_DP32(res, DABORT_ISS, WNR, wnr);
+    res = FIELD_DP32(res, DABORT_ISS, DFSC, fsc);
+
+    return res;
 }
 
 static inline uint32_t syn_swstep(int same_el, int isv, int ex)
-- 
2.47.3


