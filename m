Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2536BF9B608
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUYh-0007E6-PG; Wed, 22 Apr 2026 06:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXs-0006v3-SW
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:11:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFUXp-0000n3-Rv
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:11:00 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso54076505e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776852656; x=1777457456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pBHHqWCNozXOcmQTxKAtN3Av+2DGbBLMiAYtHB54URk=;
 b=w0H4QA3JjLg/z7XLcQpbxljm4pT0/S3Aji7ZeW9E9JwGZtohNcz1vMcGorj2mJgYrQ
 tjEhBXoFqmWJ9RMWEWZ0cZ5qtM04PWm16k6IFo0PUa2SVASguLPt7w4/aFz6FCrBznAM
 syv1maSWn8jesMNjs720hRE+Ki99opb6sr8jn/2MlS9JSXDdKad93db90DPRZ9YTeru9
 oYcBFZC4QYzINWEhUMCNPKIHgBkm7nD+yGmItZE4GAtAYoGpAsGGaIXRtRCNoREC10sr
 4GcZCf0CUvUUCfOjl8s9rQBQPc9Agc29+Zi67LX5U3CGR0RnxmY8+UVF3TJxvR8X02Tj
 Fovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776852656; x=1777457456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pBHHqWCNozXOcmQTxKAtN3Av+2DGbBLMiAYtHB54URk=;
 b=C7lDL0Fdn/6+L10MJ3QpisWgvrSDQYZ8Z1a+8+YLlA3M7jiCQS2y3WTCzP/nzcRViN
 DhdqPSw0mu+/THmZzcmvQhGdd3Je+iuYa33qFxCAazIDKjL1Hdjxj+cdhXe8iBwFKbJB
 bretOL9baios9pW645ClT1iyYAy1aRLPt35/k5DDJxAvucnGaI4Tb0Y8fPZokEbH6tH6
 2XmTITVD44fcuC6nL5uDI/1UdSzsHvWTh6PmuDdLXU1YR2AG2kuHLANUW5hmd3Tqx/NI
 ZG49kkqzqHOPYd6eol1t4mMsVBFzQSY/ozJ6fl4jh/akAe8jAMHzTRprt/Az9LztpcCB
 26Ig==
X-Gm-Message-State: AOJu0YykCwpJdumFkCk0ayc9xhMUKXBg/H+YqzySi+/b8wtkSy89LB0P
 KW6TpCK8oRR6bNFd96A4hCA+bMAk3po9MEqGWeR1C/C+i7a6TzKCavjjBDIb6hsqNSw=
X-Gm-Gg: AeBDievEnGgRryqMHWdSxy83CarSUx1Z0OGXgMK1wNmsj/ViWx3sC+WVRHEogy6Q5nB
 DXgq6qsZNxXuKKlEqakcMTlQt2fJjaURtqmgECF1qxdx3hacbGoEonNM7Le3RejgUaVk3K0LdgL
 MEPAfZQ2nGXLJvTVWkUl1m0fh8A+9X0Qehkhu/+cWvFdW5T9nfhdoSJueEDQW+Rs4qxPdxQHW3b
 rRiUR+4ce+QOdq+IPcDBkJdWAFsEnf6EX0Wr3BiDdj30c8iO8IthxyhKhlUHHV5sk58brypnOdy
 vFpO+PNte6v74SQPsnX8afO2oG1uBA6Aao9385mcV/SJ2zl2OJNrNCAENbEGvytYyN/8NRmH6jC
 gyXmuhTeADbO71J3FwInGeUXcs93G/4Hcxbe77LYZ7ULl+5obic948lBlyIu+ATDwikTcpjf6cN
 xKB1CjBDCDBqEBfcHopAclxh5Y6g4NVd40Bw==
X-Received: by 2002:a05:600c:45d3:b0:48a:5821:5ffc with SMTP id
 5b1f17b1804b1-48a58216a4bmr72951945e9.2.1776852655809; 
 Wed, 22 Apr 2026 03:10:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc2cacsm44153425f8f.13.2026.04.22.03.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:10:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9E97E61063;
 Wed, 22 Apr 2026 11:10:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 15/31] target/arm: migrate check_hcr_el2_trap to use
 syndrome helper
Date: Wed, 22 Apr 2026 11:10:26 +0100
Message-ID: <20260422101043.1234229-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422101043.1234229-1-alex.bennee@linaro.org>
References: <20260422101043.1234229-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/syndrome.h       | 16 ++++++++++++++++
 target/arm/tcg/vfp_helper.c |  5 +----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 841fd3292b8..53137394e28 100644
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


