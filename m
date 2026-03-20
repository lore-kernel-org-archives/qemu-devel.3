Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 699431098783
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:13:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ZYU-0002uG-TU; Fri, 20 Mar 2026 09:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYQ-0002px-GI
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:18 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3ZYN-0005zz-5u
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:06:17 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b97f9587e6eso236283266b.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774011973; x=1774616773; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1oVoeG3Ip9tmzj6CI2CpooaKW3Tvdm92b0eoQG/BIYs=;
 b=K2oF38nD1Wvjh6aCTRBUcFoFgYoEqfIEYD6OAZtIqhOdMfKd0929vMOiFnnrFuulFn
 Ktm3ppgnnCv1rqk5SIOgYMbKlQnejhmHa9sKoYG+hqnWUxmgz6NPHG8hwkPBdFYSURbQ
 SxBqgntEshHrNrZNgv3VAGDyw3a2eU2wtJEx3984uSeUXP+Agwsjf+XJpzF+ImTOxlcY
 sKg5H8RPXCSGldaP470yGv4HBO99+7fXEMs9K2Wx7pJkr1UzeWOq22K4SeLS2PM/u7Gs
 Qip5uDAgod5NZrkAHMEnfzD8tI0KFKroogGrpIPwwKVDjDYQOTPBA/GZk1bpvRCBeUrX
 lWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774011973; x=1774616773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1oVoeG3Ip9tmzj6CI2CpooaKW3Tvdm92b0eoQG/BIYs=;
 b=DVKiBnaqRiIhPec+s+3hrDtsKsut5J0s1ArKJqKoihnwc5PAfjWn4hoBQHxqd04efk
 fPeOXSIgaycVW0jd68yt9ozOanNCHtJCRhu89i5a7SRBhwdipaaXgEJNgvSt9iqnCM8Z
 SYaImXreM3gAsZPATR/+12ANQr8lsFavaPFaew51ayi1v/hxjQwV4Xn74nn7StZqyBHz
 kNImhy2N3okoQCpfhUovIa3WY6dVHAZ1Ki5buD+fBh1tBdFasxgZewoUU8U2kA6DhfUh
 MxSN8QQkXJ4Sre73mxG3BvS8M5BbpYJp5snzYhSLjJBiBWrBuB48Y3z7mSEGU7Kg8ztu
 Pwxg==
X-Gm-Message-State: AOJu0Yy3RTzOn13WE0AhGEq2ibcHVqlIsqqszuz3gQiF/AU8eCaPaavT
 OnpESOvgl15p81lRI1f5kKNP22lQcdlX2Z0YIaH2BfmZ8NjDSY/E7AJxxG6nECw/xGU=
X-Gm-Gg: ATEYQzx6Ko4O2N3Wr8G9ApP8KNDyGG77MlhkyMOHoGKo46BtrHcJ5eYfa2etgp1Rk1r
 Mj8BsSdLFvDDuu9xTAW8ToZZ73sl8dKrp9Q6CzkN8JiGgHW+dG+a1WhXXKw2mHaD0vigX7CIWUH
 IH25RhlYoxEJDxHtewpxRafCmo80toPHChhbrg6WGbIFfD5g1ue4R3/68ejzsmZTb+3zverVOL9
 umUIbinLkqSyLjaCzRR22mg6uLxLbCfDa2qgTvENgHQk+CALx6kASKi/0WDrc1Nns9FK7IrRvJB
 BNnQ/hmZCo8Vg3vqzn70jzA0d1YbiAbqMtjpTs4Gr/zhOetMOuiEQocRkSM7gzvzJ/N8nV4lsgW
 sRIq7deZcTIKGlJVllTKLRGl5KamUnKclyll6961XynXGrwhdcwrD111UAM+Nbs5f4jIqvyJXW2
 rTyCe8KZldBi5PWcJ+PedYCJ4IAVH6tFK1dQ==
X-Received: by 2002:a17:907:398c:b0:b83:1433:78de with SMTP id
 a640c23a62f3a-b982f0bc06cmr215264466b.12.1774011973226; 
 Fri, 20 Mar 2026 06:06:13 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b983398c140sm159882766b.63.2026.03.20.06.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 06:06:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DC0055F932;
 Fri, 20 Mar 2026 13:06:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 05/35] target/arm: migrate SME trap syndromes to
 registerfields
Date: Fri, 20 Mar 2026 13:05:36 +0000
Message-ID: <20260320130607.2071996-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320130607.2071996-1-alex.bennee@linaro.org>
References: <20260320130607.2071996-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index b145a52769f..abec0a4908e 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -384,10 +384,18 @@ static inline uint32_t syn_erettrap(int eret_op)
     return res;
 }
 
+/*
+ * ISS encoding for an exception due to SME functionality
+ */
+FIELD(SME_ISS, SMTC, 0, 2)
+
 static inline uint32_t syn_smetrap(SMEExceptionType etype, bool is_16bit)
 {
-    return (EC_SMETRAP << ARM_EL_EC_SHIFT)
-        | (is_16bit ? 0 : ARM_EL_IL) | etype;
+    uint32_t res = syn_set_ec(0, EC_SMETRAP);
+    res = FIELD_DP32(res, SYNDROME, IL, is_16bit ? 0 : 1);
+    res = FIELD_DP32(res, SME_ISS, SMTC, etype);
+
+    return res;
 }
 
 static inline uint32_t syn_pacfail(bool data, int keynumber)
-- 
2.47.3


