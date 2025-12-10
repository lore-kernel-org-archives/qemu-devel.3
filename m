Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17851D3C918
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 14:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTLWa-0007Gn-Bl; Wed, 10 Dec 2025 09:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vTLWG-0007DV-8R
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:50:22 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vTLWD-0003Cg-9k
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 09:50:19 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4779d47be12so62324665e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 06:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765378214; x=1765983014; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=39pxJpy6ZHXUTQRTHCJ6qo/oQbW8XDTa4280QEI5Oos=;
 b=bH0sRNpi4/dFgwoeBb/09+S0r6lRdCAZXtOOAiLGZy2qtitDwk5aCb2MQAEU+z+8by
 Rr8WgaJbbZ5Jfg89f8p8uXHTt0VkKhR4aZMohJvEdfjhJVEVbKger/XFbPafbf+IqEog
 j6Z0wqS2D74YeLEeC+FKRDYfQATa3F0gVvcg2j9Q3/gMRVXxG+psMz37wMYTS3fxONJN
 xs01+g2PWtAUcQdgXs6wOpgR0r811l3GvuyikLaFJNRmJEAbNYM0iiJ2lS7mSa39VOUM
 oRxv0SYdbxktU0QQpsxQqqy6mHtAi3wcHYCV3/E5u6tQ2MmNgH8d9DESwJMYsFpymcW8
 Ipyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765378214; x=1765983014;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=39pxJpy6ZHXUTQRTHCJ6qo/oQbW8XDTa4280QEI5Oos=;
 b=c2g7XofS98EcjLkpI700fbtECqfBDOMKj2vybxr/gpStfyR11WK86N3ovY8+pAxKXe
 fQNZzeo/vnXLhxkmQPh0o5xqkiZRK6FD9Fth6OmMCJoGz0eZuHUFaXNAvIak2UO6oQaJ
 HJq2yVHTv0D3GJ6mrqttCC/QCVKQ397OLmgMacT5IwCUPqOALQKMQPL51lxhDGe9KLot
 OBmgC8+Eb3RgpCRnbHri+hhd250/Jb7s+qqmiLvmaoQD55dTdEsFmKmyG0J6tk6iabGP
 vlka/4FfgrB4zlR8MBtiL5tc7WpsENP5KfH9j/nm2FV9th1CmoDcr7S6wsC/zfozBNCV
 Nqtw==
X-Gm-Message-State: AOJu0Yxy7+PZoAcHGMBP6vUZOOgIpaTpllSgL2rlvgg8dKY9INg0cM1h
 8RHZxnO/WNVdWDvK8R35t6c+nagYOHslHTnFFX4TnC5+KmOx0NXodRvcARkfJvuXHLIX4DPZ7n5
 8JyKK+ZU=
X-Gm-Gg: ASbGncuBbi/YJOHN2KfDItPmbBRX9dk45Q3PucUOX3YyTUmR83zwwG9dH8uVNDvPu8C
 o72pghy8YNKbRvL/DIOTkjuThfzmh9B6WBQ9b0hmLZmgD/uBRK3UOnjctCCKpUBdhxVFXf/8xfZ
 XD9Sc+e9TU5VAbX1N7yKlXzjr1FHuR/LXfZASeyrT2FQgioY0xAHB7WuD+T5IMTMWCWf5Tk34S4
 Rr/YwiIPrqtnQWN2kNKtdLle9A0N+JNnv83u8U1oK5wboG1LUP0Aw2W2+CW6cEY/XTUsChAQntc
 CvM+1tRVl0A/flmywX/xVYv+eZNt2umQiyDL8CmBwnUq6tzZsVPA5AWVd+kOdrqvcohKCCjJR2k
 85+5XXkYii13SeglFEVW20iGnGYx3Y38Tuj0HScZ7C885tu2JuBOplh7Zzo283sDfYLiwPFKlG4
 38WOYsKg0VXCDUMQ==
X-Google-Smtp-Source: AGHT+IH1enndv9zaNa8DYGZLVMXo+kLktjfddPsd9ZzDJZv+o5870wJYadATzR1+RgYf84uKt6jzPQ==
X-Received: by 2002:a05:600c:a49:b0:477:7bca:8b2b with SMTP id
 5b1f17b1804b1-47a83814836mr28753665e9.15.1765378213933; 
 Wed, 10 Dec 2025 06:50:13 -0800 (PST)
Received: from [127.0.1.1] ([2a10:d582:31e:0:62e8:705f:f7a:c7b0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a82d7f778sm56595235e9.11.2025.12.10.06.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:50:13 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Wed, 10 Dec 2025 14:50:13 +0000
Subject: [PATCH v6 3/4] target/arm/tcg/cpu64.c: Enable ASID2 for cpu_max
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-jmac-asid2-v6-3-d3b3acab98c7@linaro.org>
References: <20251210-jmac-asid2-v6-0-d3b3acab98c7@linaro.org>
In-Reply-To: <20251210-jmac-asid2-v6-0-d3b3acab98c7@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x332.google.com
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

docs/system/arm/emulation.rst: Add ASID2

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 docs/system/arm/emulation.rst | 1 +
 target/arm/tcg/cpu64.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 31a5878a8f..3f30ea5a30 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -24,6 +24,7 @@ the following architecture extensions:
 - FEAT_AIE (Memory Attribute Index Enhancement)
 - FEAT_Armv9_Crypto (Armv9 Cryptographic Extension)
 - FEAT_ASID16 (16 bit ASID)
+- FEAT_ASID2 (Concurrent use of two ASIDs)
 - FEAT_ATS1A (Address Translation operations that ignore stage 1 permissions)
 - FEAT_BBM at level 2 (Translation table break-before-make levels)
 - FEAT_BF16 (AArch64 BFloat16 instructions)
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 6871956382..ef4c0c8d73 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1334,6 +1334,10 @@ void aarch64_max_tcg_initfn(Object *obj)
     t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* FEAT_AIE */
     SET_IDREG(isar, ID_AA64MMFR3, t);
 
+    t = GET_IDREG(isar, ID_AA64MMFR4);
+    t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* FEAT_ASID2 */
+    SET_IDREG(isar, ID_AA64MMFR4, t);
+
     t = GET_IDREG(isar, ID_AA64ZFR0);
     t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
     t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */

-- 
2.43.0


