Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F822CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNtt-0000KC-J7; Sat, 30 Aug 2025 11:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELl-0005tK-8R
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:07 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usELj-00046c-OK
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:05 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-772301f8a4cso1455631b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532522; x=1757137322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEj8duxAu1Pam82WhtcHKlYlFMg89KDGm3ClOoILo48=;
 b=sc2rhVPr1Fst/iXFm9DjJ9jA1CsfekitiLQhc7hjGgd+tq9PnvlwDd+6G3+bRopXqZ
 PuXNIGnR5UWXYkKrhAFbt5v2amIOATTuSS0l6Fl9w7Su1xrXAgLPbk8i6wuJi3wzK8/3
 1lkXOGuOly8jiReLBMX0hOG9vs9iCEKrb99D1icmn7+/5BQZD7BZL+L8wPtiyN9AKMwO
 sNrpQnr2izSVqogeXBCrkt8tWg0UQO44H/8BukR/OrU5HzWdp02yayMc9hdAgIoKt8Dg
 STEY5R6ce6N8GUm/bHZgJz2ymG7c4OFZHUWLoaZjzha4L7X7PK6OiZqcbplFQnieGE3O
 8uPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532522; x=1757137322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kEj8duxAu1Pam82WhtcHKlYlFMg89KDGm3ClOoILo48=;
 b=Jbgk/yBWiV6JvTFvDcwFh+Xw0obxKN40hxTbC/p9jw62MyMQTY+SMvRL/3e84dBzZL
 L5OBxrs081PpygTfVpipUjYnDTiOiqHhzl4SQYP2X1ka3Ing8l/yemAYk6wqL0rXfPw1
 VsUXo9wy5bDj4gVa3M5p/Msm/rvgaADWravG5w6Cil629nm3DH2nM5aYTzbO2e/G4lKL
 yAh3D31mYy7OqARmOsEEvgwPLYwySF0QLhwHOuDCu7RgZFAylUrhIQaQu3MqvkECZKNB
 zUUBse+snp6N/jg2SxoPjKyEg68D62MErZ70C88OODyxISXZSzXSSBBAwEpJtvi57S3P
 rcbA==
X-Gm-Message-State: AOJu0Yxo6ooi3eaMNV2DH6k17jubndZE6bxGlcVA16yNe/pnKObVnwyr
 5n88tKsrkHZnrdN12SqYo7DUTsPjH/jtE1pd8Fj5Qy5OeOR/QOQgSepg4LvJNSgcA9CKZnWv1gw
 tXbjzQ/g=
X-Gm-Gg: ASbGnctQACWT5Rqs0RNY9o6AhUaD9kRr1vvVyP6SsSncYnl/hHMeSRzks++nHR1tgPd
 kwxP74e1E9nZbxY4Sk7NVOHc7fdlGuxIIHBVpQ9CfUdCZxImrEyBc9CNIN4EVyXlF8KuI3M8A2j
 Q75kviaysQ24AAaLlmdCkPx1y/9jWE9OSfL4thB5S3n12mi/KTJ5fZq7Cv6CZreLQvE3K6og56X
 ZbY/yGAwy3CrzRtIiKmE8BObDa1duaEYWJhHTXXMt85UsPu9efSco5Iii/IQVczZxPzBtTfFmDT
 EPI0zZTIv4Jc09qSUs6IoMe7A5wkUDC/fleDUnlUIaOQyDjt91b2pk7qzqX1uDqiqyHIxmVEtkn
 93/wzRPm5NHmFqJWbYRYhYVacOgHaZmA2/DVwbo8kCOpJyoDDlWIVlCIKTNba
X-Google-Smtp-Source: AGHT+IHPtBOFiEzfRefyZUtWHaBtI2tu0RAWhXNiugpnHWR+ub1KWfwokwz+lWmTlQTScu4hMzSOnA==
X-Received: by 2002:a05:6a20:918c:b0:23f:fa6e:912a with SMTP id
 adf61e73a8af0-243d6e007b3mr1600596637.16.1756532521709; 
 Fri, 29 Aug 2025 22:42:01 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:42:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 10/84] target/arm: Fill in HFG[RWI]TR_EL2 bits for Arm v9.5
Date: Sat, 30 Aug 2025 15:40:14 +1000
Message-ID: <20250830054128.448363-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpregs.h | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
index c9506aa6d5..1d103b577f 100644
--- a/target/arm/cpregs.h
+++ b/target/arm/cpregs.h
@@ -408,10 +408,19 @@ FIELD(HFGRTR_EL2, ERXPFGCTL_EL1, 47, 1)
 FIELD(HFGRTR_EL2, ERXPFGCDN_EL1, 48, 1)
 FIELD(HFGRTR_EL2, ERXADDR_EL1, 49, 1)
 FIELD(HFGRTR_EL2, NACCDATA_EL1, 50, 1)
-/* 51-53: RES0 */
+/* 51: RES0 */
+FIELD(HFGRTR_EL2, NGCS_EL0, 52, 1)
+FIELD(HFGRTR_EL2, NGCS_EL1, 53, 1)
 FIELD(HFGRTR_EL2, NSMPRI_EL1, 54, 1)
 FIELD(HFGRTR_EL2, NTPIDR2_EL0, 55, 1)
-/* 56-63: RES0 */
+FIELD(HFGRTR_EL2, NRCWMASK_EL1, 56, 1)
+FIELD(HFGRTR_EL2, NPIRE0_EL1, 57, 1)
+FIELD(HFGRTR_EL2, NPIR_EL1, 58, 1)
+FIELD(HFGRTR_EL2, NPOR_EL0, 59, 1)
+FIELD(HFGRTR_EL2, NPOR_EL1, 60, 1)
+FIELD(HFGRTR_EL2, NS2POR_EL1, 61, 1)
+FIELD(HFGRTR_EL2, NMAIR2_EL1, 62, 1)
+FIELD(HFGRTR_EL2, NAMAIR2_EL1, 63, 1)
 
 /* These match HFGRTR but bits for RO registers are RES0 */
 FIELD(HFGWTR_EL2, AFSR0_EL1, 0, 1)
@@ -452,8 +461,18 @@ FIELD(HFGWTR_EL2, ERXPFGCTL_EL1, 47, 1)
 FIELD(HFGWTR_EL2, ERXPFGCDN_EL1, 48, 1)
 FIELD(HFGWTR_EL2, ERXADDR_EL1, 49, 1)
 FIELD(HFGWTR_EL2, NACCDATA_EL1, 50, 1)
+FIELD(HFGWTR_EL2, NGCS_EL0, 52, 1)
+FIELD(HFGWTR_EL2, NGCS_EL1, 53, 1)
 FIELD(HFGWTR_EL2, NSMPRI_EL1, 54, 1)
 FIELD(HFGWTR_EL2, NTPIDR2_EL0, 55, 1)
+FIELD(HFGWTR_EL2, NRCWMASK_EL1, 56, 1)
+FIELD(HFGWTR_EL2, NPIRE0_EL1, 57, 1)
+FIELD(HFGWTR_EL2, NPIR_EL1, 58, 1)
+FIELD(HFGWTR_EL2, NPOR_EL0, 59, 1)
+FIELD(HFGWTR_EL2, NPOR_EL1, 60, 1)
+FIELD(HFGWTR_EL2, NS2POR_EL1, 61, 1)
+FIELD(HFGWTR_EL2, NMAIR2_EL1, 62, 1)
+FIELD(HFGWTR_EL2, NAMAIR2_EL1, 63, 1)
 
 FIELD(HFGITR_EL2, ICIALLUIS, 0, 1)
 FIELD(HFGITR_EL2, ICIALLU, 1, 1)
@@ -512,6 +531,11 @@ FIELD(HFGITR_EL2, SVC_EL1, 53, 1)
 FIELD(HFGITR_EL2, DCCVAC, 54, 1)
 FIELD(HFGITR_EL2, NBRBINJ, 55, 1)
 FIELD(HFGITR_EL2, NBRBIALL, 56, 1)
+FIELD(HFGITR_EL2, NGCSPUSHM_EL1, 57, 1)
+FIELD(HFGITR_EL2, NGCSSTR_EL1, 58, 1)
+FIELD(HFGITR_EL2, NGCSEPP, 59, 1)
+FIELD(HFGITR_EL2, COSPRCTX, 60, 1)
+FIELD(HFGITR_EL2, ATS1E1A, 62, 1)
 
 FIELD(HDFGRTR_EL2, DBGBCRN_EL1, 0, 1)
 FIELD(HDFGRTR_EL2, DBGBVRN_EL1, 1, 1)
-- 
2.43.0


