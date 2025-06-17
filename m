Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031D4C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 16:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRZGQ-0000mc-LR; Tue, 17 Jun 2025 12:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZG2-0000kn-S4
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:33:58 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRZFz-0000cf-Lk
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 12:33:58 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso32505855e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750178034; x=1750782834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/pVLW980tQUeFMbPOSrmbCV35FWVqLGwZwmiSRkT/nc=;
 b=AARro+sgTKnFkmA/pCZGdxHsKke7t5ORNlCD7/asYUSrNRTBhhUfHvudVVNoqG8kkQ
 taO7FDKy+1F3xYzgT5HioSBnmujf5apUsup6Dd4x5aGgLxQdUmmZXcnTmkuiDHSvVfP/
 8VBeIaoNoiETopcMaXNKb/lTKNwzJ11egYrA7P5kyZy1ZYxM5f/r7xw/KWCA86XCchtm
 BtUJxx9nhQ6TQN+/VW3fYby0SoVzHZElzqbn9YPXrzFWidViKSmjswqgJEtKEKRILdrY
 shYahkoVtiLYlF0rE7B6bFD0YE8EgqqSzrE2WNVIDYY08UiGIBFAzXT3gc7Cr/k2buYL
 3s+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750178034; x=1750782834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/pVLW980tQUeFMbPOSrmbCV35FWVqLGwZwmiSRkT/nc=;
 b=ajkONnWGGWWScgyalrRD+lETQtPPKEG9GWg1CeM/qeva5PFeQ1xqmb/Lpzu/ImaasO
 6gF6Pgd+qJDcB8+wHERLigH2Mev9DR5IYLbdEkkvUVEaJ3kE0cbrgbIve59eJjxPlP64
 zBrSJRvoMtx3eMPehkETnxGIB8SN3evhxvxA/HCvgMMx+Zq0/Uk1xMXlMzMQXr/7Nl9u
 dD953cKg6BouhD6W+zQYLnDl8JZRxTv64KAFIAagO8MrDMqEK3gtQcGVsVQ60/niGZ8T
 8Y53M+GkThe5BM5xps7Y46aUnj3913vgFYDsEiDbjhnWzsA2tWSUNozhDmLGnEY1OWlk
 Mulg==
X-Gm-Message-State: AOJu0Yz1F2NKSiktWSNbGrhwLz7nmb5UzUmmLJneUcTHZvbkYUCcVN3I
 Ebs1v34D8pS/ouy92JAR4CSUh4bhXvtDEA1HnHsNMNQkWqYwJODsGr7aDN/f25okK4Y=
X-Gm-Gg: ASbGncvLmj8zzCKb16xIPFq54Df34FJXx9Jjul3gRHwYy64m6bHmLZ4P/lk47ucvClu
 YCB16NflaLXh2QKux3wzegPIkVm1uRLR/30Ir+48Oi4JbHVW+0KD777fJ2uwUYzJ2MsdI3BkeDk
 MUgTump5GmFSsBi3eNBv0eYqJf2N19ma2cg/AmPLU3upLRfUXE8EV/ya1/AP4AXfa8k5K/8E8J6
 avEb10AmaNrliUL6Te60lpaLb3axD9RUGQ61xmbqgYOhBHeIDOvlL6w4idlddU8ZzvDcZxs8MNL
 JVCQHIzWEqs3WELwwn9XpSs5Nld9iabUCcSGH0R0uXHnIEFuaEzgUiUtMsu8lWs=
X-Google-Smtp-Source: AGHT+IE8v8HeR2piaWlFX6bbvfHCxqXZXhONIJkvHNHlEOHHSq+0M0P/3+bbuJRt/SWwiA7WH7QLGg==
X-Received: by 2002:a05:600c:8286:b0:450:cfe1:a827 with SMTP id
 5b1f17b1804b1-4533cb1a7c4mr155107765e9.31.1750178033665; 
 Tue, 17 Jun 2025 09:33:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e268de2sm181468295e9.40.2025.06.17.09.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 09:33:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 15EEF5F873;
 Tue, 17 Jun 2025 17:33:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 Mark Burton <mburton@qti.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <graf@amazon.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH 02/11] target/arm: re-arrange debug_cp_reginfo
Date: Tue, 17 Jun 2025 17:33:42 +0100
Message-ID: <20250617163351.2640572-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250617163351.2640572-1-alex.bennee@linaro.org>
References: <20250617163351.2640572-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Although we are using structure initialisation the order of the
op[012]/cr[nm] fields don't match the rest of the code base.
Re-organise to be consistent and help the poor engineer who is
grepping for system registers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/debug_helper.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 69fb1d0d9f..8130ff78de 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -948,19 +948,21 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
      * DBGDSAR is deprecated and must RAZ from v8 anyway, so it has no AArch64
      * accessor.
      */
-    { .name = "DBGDRAR", .cp = 14, .crn = 1, .crm = 0, .opc1 = 0, .opc2 = 0,
+    { .name = "DBGDRAR", .cp = 14,
+      .opc0 = 0, .crn = 1, .crm = 0, .opc1 = 0, .opc2 = 0,
       .access = PL0_R, .accessfn = access_tdra,
       .type = ARM_CP_CONST | ARM_CP_NO_GDB, .resetvalue = 0 },
     { .name = "MDRAR_EL1", .state = ARM_CP_STATE_AA64,
-      .opc0 = 2, .opc1 = 0, .crn = 1, .crm = 0, .opc2 = 0,
+      .opc0 = 2, .crn = 1, .crm = 0, .opc1 = 0, .opc2 = 0,
       .access = PL1_R, .accessfn = access_tdra,
       .type = ARM_CP_CONST, .resetvalue = 0 },
-    { .name = "DBGDSAR", .cp = 14, .crn = 2, .crm = 0, .opc1 = 0, .opc2 = 0,
+    { .name = "DBGDSAR", .cp = 14,
+      .opc0 = 0, .opc1 = 0, .crn = 2, .crm = 0,.opc2 = 0,
       .access = PL0_R, .accessfn = access_tdra,
       .type = ARM_CP_CONST | ARM_CP_NO_GDB, .resetvalue = 0 },
     /* Monitor debug system control register; the 32-bit alias is DBGDSCRext. */
-    { .name = "MDSCR_EL1", .state = ARM_CP_STATE_BOTH,
-      .cp = 14, .opc0 = 2, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 2,
+    { .name = "MDSCR_EL1", .state = ARM_CP_STATE_BOTH, .cp = 14,
+      .opc0 = 2, .opc1 = 0, .crn = 0, .crm = 2, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tda,
       .fgt = FGT_MDSCR_EL1,
       .nv2_redirect_offset = 0x158,
-- 
2.47.2


