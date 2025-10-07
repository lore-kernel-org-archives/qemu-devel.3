Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B38CCD185
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68R2-00068h-R8; Tue, 07 Oct 2025 10:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qt-00060w-Ly
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:51 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Qc-0002P0-9U
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:51 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso51605195e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846349; x=1760451149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C37HhRfgSBySWdsamOj7MZINphxZR6Xh1rWMZf7fW/Q=;
 b=B7QJHG3x5h6waKMhtH/SO9Bsv341uLYCQ5OcvegXVkPY2h9vUp/dsWPt+sRxj6R1XJ
 9txAcXOLdSngRcRPtfPwMDRdBmvYlT08/1rUvIAqULHeqq6Jl+EUSKFjp1UCHmZ3Oht1
 xxjvFMfmfsJu42OQIYEJHvS8JK47Eir95hAB4qZ+Wt6/8bX02IPyi46hMP8FjBbB0zGi
 ND4kyuDYw9iDsJuuleQHj8cnA2SmFDMVRLk03Un50VgXG5nGYEYDy3GXynH3xH2SEI4G
 kX+pHzMvrj4KtIUtFaQ0/FWbngoN/sHack1/0TMooeK9V03c/9EZyZevMDydyIz5gu8w
 jauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846349; x=1760451149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C37HhRfgSBySWdsamOj7MZINphxZR6Xh1rWMZf7fW/Q=;
 b=EldvkRyZ0r4vzHOfHwX3TuMGKH0j6Fr5Q3RhlzTlHM3QfZLEyX8e7DDKtpnwfYSWTz
 BymymHTbAAKiO0fQpXrV5nMtUh4QT4qk1/+uExkIcduqgQuX0oZv762RyPspbDXI6V89
 EIQTLyUyDQLgFKU8Zxv56ZnfPHuymyxAID2vby+W+2LfLbox82QglxLu9O4R/DJGvmiy
 3qfvb8Jbnvp/4OtOOtwMufubeQHAE/mV/qjGHwnklLqKs9rthcIEQAwJ6zcxDeG3v4cp
 bAY9iQawg1J+pe8ULB08yCtK3nnuX8C2X7Re35T8HRkD4kDBv3PPcSULUT51tPYhTh1f
 +NaQ==
X-Gm-Message-State: AOJu0YygFc9a4uBWVkB2mMVzKqRfbAlLXl6lPmqkrG5yfHjoOeCS9BoJ
 pcGivNotsd/jxejrto6ZJbrogt6eOWhwvlIUlSd1jHwI1II+eU+DKknxLvSrsVPfpx4HpVt5s1h
 yEOfs
X-Gm-Gg: ASbGncsoGWh0IhzQzj0ed+AnbEyDVQnUgD6V8mlSKXwQxKjlzfmmah+MTaPSt4rb/yh
 7xCxoDOeTMyz+KWdqlBJQneECnF92/5132O4Dr5jLNTM9a9DlTD8A8pr415Qqa4uQSLByvhUzYN
 ir8FwVnK2N6eIcKhwFlvR04UACmEZTgHB3De44SAtAFm3E6WXi8cWvd1/E9I0Ly/P+G5shszOdk
 dr9y/f8PrxnU7uJwqkTE1U5n5Ziy+8snKbe4F8MukpK/ijQey0L7sTFRszgGQbNO1KUNPQnBmfO
 Qhg9SSXipcB0Q3hJg+JfUtgbqitVzfhctKaJ5Jd+jcsgRz8NJ52eLMhVguA0lwUP+4Ni/dv58fG
 VL+ChKv4vaPDuhu3lXZPS3bBKK6A07TTNhLkAsAk0tcppLJYpZ0IOGo56
X-Google-Smtp-Source: AGHT+IFy20/v/FzP09YGcvhqe3bHwWx8t/xf+34fq2J7EVNrA++QIbePsDsgDEAkJrD/5ERDrrD02A==
X-Received: by 2002:a05:600c:4fd3:b0:46e:32dd:1b1a with SMTP id
 5b1f17b1804b1-46e710f6d02mr117267845e9.7.1759846348688; 
 Tue, 07 Oct 2025 07:12:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.12.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:12:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 58/62] target/arm: Implement GPT_NonSecureOnly
Date: Tue,  7 Oct 2025 15:11:18 +0100
Message-ID: <20251007141123.3239867-59-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250926001134.295547-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 3df5d4da12f..56a3cd8fa0f 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -318,6 +318,7 @@ static bool regime_translation_disabled(CPUARMState *env, ARMMMUIdx mmu_idx,
 
 static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
                                      ARMSecuritySpace pspace,
+                                     ARMSecuritySpace ss,
                                      ARMMMUFaultInfo *fi)
 {
     MemTxAttrs attrs = {
@@ -490,6 +491,13 @@ static bool granule_protection_check(CPUARMState *env, uint64_t paddress,
             return true;
         }
         break;
+    case 0b1101: /* non-secure only */
+        /* aa64_rme_gpc2 was checked in gpccr_write */
+        if (FIELD_EX64(gpccr, GPCCR, NSO)) {
+            return (pspace == ARMSS_NonSecure &&
+                    (ss == ARMSS_NonSecure || ss == ARMSS_Root));
+        }
+        goto fault_walk;
     default:
         goto fault_walk; /* reserved */
     }
@@ -3553,7 +3561,7 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
         return true;
     }
     if (!granule_protection_check(env, result->f.phys_addr,
-                                  result->f.attrs.space, fi)) {
+                                  result->f.attrs.space, ptw->in_space, fi)) {
         fi->type = ARMFault_GPCFOnOutput;
         return true;
     }
-- 
2.43.0


