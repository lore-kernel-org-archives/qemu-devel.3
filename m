Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1171C3ABC0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5Ct-000536-DN; Mon, 05 May 2025 19:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AY-0006z8-FF
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:22 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AV-0003y7-Ti
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:18 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2295d78b45cso65362425ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487454; x=1747092254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lxiqm18+sn4NfhFWpGsu8e9acXNWibaUDGV6AOwg284=;
 b=TjJUDY3LsOwYGRPL6Lweg6VRkTy2xcEd8GGwKXAP4MvlTg5hmq+4gsxmBQ4TSBmwCF
 i9jBiKnFb6tn8BNuRdFC6zesDkOOwXdvLhwbBSaYf995cKNBurM0MoT/EA7rFWEDCQFw
 KD0IDjh2p45wxUDnTNojC8IUJYbPDkcmVQry5KZgVeHcEcqMcMITK0a+7X+gPwzZRvrq
 5R2EaoFlHoCiykdFpotXb2uYlUyR9f0bfuUTu7BCuucD7hGcVOzpszfrQMe+eADKO1kA
 xSr1M2CyDHmqhj4bKIomwq3G4/uauHQ723YVLg7m5KLiA1i2pa14lzL0ey7012fYJvOK
 IZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487454; x=1747092254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lxiqm18+sn4NfhFWpGsu8e9acXNWibaUDGV6AOwg284=;
 b=PGQloaERBeiGQksScOYKkw4VRXcVCHJEM9PbFgmC1PHz1U9UJYPKvTeahnr3DP99NJ
 XON8P90DEdBvA84i14p8d8ixQ/TeM7zGTI6it8ccP3r/YWRuILYEnffnTkUQw6B0K1bD
 Nj+QzX5IpvnenXDNtu8KA8kqdo86dWkwKaOlcohdqpI1izSaheecS7S9Fe2A4CI2TGov
 Deby++QIF8Zul6PWb2+EX6lfRpieY0lf08zpsOXM96OPlzkVBQ1emVCabFlCDjMVBBYc
 IF89weMbptvcSIiXt04WkM8pQ1+WfOT10DbM7XmhfDF1Z1Co0HymyyQ5pIXHIHIxaCgc
 v2FA==
X-Gm-Message-State: AOJu0Yw1tsQchTnYLDFJcEQxVe+GHANb/iiwNNbQZaYnzffsJmrgQKhB
 aiqrtLCGnfJ+NYu+NQEAb/lEvwPn/beA2Hs/mtfs+hbqKfJcUDOrIFikBcUUYPv/Na4bRQonyyd
 kPd4=
X-Gm-Gg: ASbGncubpHqnhYTNjREFwt25T46jlcn8dO5JwIII0/yiul+YZSOEYY4hu6zB0LKiGil
 x/nBbbt1cFeF2BnbcfYuWJK45oWQbBTFgHjhAzZ39hM5s/d37pSSbpPR0B75SPEY9lbpJED8oOZ
 2+ySL62E2Gs+HTBa99Mt3+NDzSUfPFD2w/65zhfD6bCTTNTY1qngYrGloIL0AdV3NsF0sxhhEUN
 y3Iru4y4fzFFDzYjV5OrmrcEPxiyx0qsEirTvMGTAIbNUsZ1D1Df9hgoSx7aO1/0Y9y1aavxLAe
 dNNn21qOw8iG9z4poWhgEgxkVBzm5+pbaiuWmRFk
X-Google-Smtp-Source: AGHT+IH+n+7t3z29C7R6sRRD9PrLWdyQFgHaAF6qg00b9P4xkufJ3wIXXkW4T544/tooWyNTVIcfsw==
X-Received: by 2002:a17:902:e54c:b0:215:7421:262 with SMTP id
 d9443c01a7336-22e328cf694mr20675215ad.12.1746487454294; 
 Mon, 05 May 2025 16:24:14 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e16348edasm58705265ad.28.2025.05.05.16.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:24:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 47/50] target/arm/helper: restrict define_tlb_insn_regs to
 system target
Date: Mon,  5 May 2025 16:20:12 -0700
Message-ID: <20250505232015.130990-48-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

Allows to include target/arm/tcg/tlb-insns.c only for system targets.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ef9594eec29..6eaf6b3a04e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7763,7 +7763,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
         define_arm_cp_regs(cpu, not_v8_cp_reginfo);
     }
 
+#ifndef CONFIG_USER_ONLY
     define_tlb_insn_regs(cpu);
+#endif
 
     if (arm_feature(env, ARM_FEATURE_V6)) {
         /* The ID registers all have impdef reset values */
-- 
2.47.2


