Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCDDC3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLR-00044C-Ni; Tue, 30 Jul 2024 05:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLO-0003oo-2g
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:34 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLL-0000cd-RR
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:33 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3685afd0c56so2044926f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332430; x=1722937230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=06XQlRqaiDDlTS/bWwdh4Kb7Kl/gVH3uLLyO2TZuWqM=;
 b=BtIIc3aRF1ZS62sZDoM5oACm8M+d9FWOPGsBpczLqKS0wnEATg0zm6luq8Rm7yi/nJ
 z/xm6UsrxrhMSmxePSX/cSKbG4BChChWvGJ1oDkYq0ORK2iJfe3R19ay6qcEM1PLB3eg
 j+wxKbBax2Jv18HtG/JSu5RHNP7Ap16he5hiWmtNVDLSciaDoKWcB50wmKGVp3RUxFdo
 WWIlY6gK1ntPuo35L4polyl9VSqs/NCuD/nbtvfvbnMyZjj9doUJwNob8YNlWn8cAGP3
 +PNgSY5aY+2n0C4rRht7Gza8PeWs+ymNikHMLgTyq/fuL+GWALgS+diYkQ1YIMJS4BGX
 Nrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332430; x=1722937230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06XQlRqaiDDlTS/bWwdh4Kb7Kl/gVH3uLLyO2TZuWqM=;
 b=Wwi9WuisV5xlyyUG2XpAFyIGRDMUlzEAVhj57oEpYFpg1SsXtIitrCtQazkJjx0JKE
 ChwyenjrgMZdjnAXP3TDiw4EwX2O0JQG65mGZqEMDbg6jMZXtBKIrbwi/AVeL0b3a2CT
 uQjx7EomnxVjujhyY5cYnp3w3qelfkPwxyuKJhrA2cwJ0U8lO0DTEV02BvLxMO+Tjh0B
 18aVm2VPiep8RRKp4zl6guwRDGX1I691Z8lI0Yn8QcpiKstkp1YXI6zTWZ7yTYMtq9QK
 I18RjoFSN0toaWiy2lSSCuX4bmFJC69BesbbgxgDY7icoqHq2aZ+UBNTXOl6uXmzlnsI
 Qe3Q==
X-Gm-Message-State: AOJu0Yw+lMaxcDG5Almge5RHubsyheMjXWcYgY6NMhJFOdjGcfHYokFo
 fBG/+u4YgtYTjXyY0kboGtdSWx9weRLgKrdlXSj07OYmgc7p2vkHsbuP/mUF2EIRy8VN4PFikzc
 k
X-Google-Smtp-Source: AGHT+IGGl+mT0nTJTrpVzaH0YKACvStMEWK3mqHsRzeM5Iowa1ZPPJBzxdbJUsotIkrym+8yWd7FTw==
X-Received: by 2002:a05:6000:186c:b0:368:4e28:47f7 with SMTP id
 ffacd0b85a97d-36b5cefd51dmr8858749f8f.6.1722332430466; 
 Tue, 30 Jul 2024 02:40:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/21] target/arm: Ignore SMCR_EL2.LEN and SVCR_EL2.LEN if EL2
 is not enabled
Date: Tue, 30 Jul 2024 10:40:14 +0100
Message-Id: <20240730094020.2758637-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

When determining the current vector length, the SMCR_EL2.LEN and
SVCR_EL2.LEN settings should only be considered if EL2 is enabled
(compare the pseudocode CurrentSVL and CurrentNSVL which call
EL2Enabled()).

We were checking against ARM_FEATURE_EL2 rather than calling
arm_is_el2_enabled(), which meant that we would look at
SMCR_EL2/SVCR_EL2 when in Secure EL1 or Secure EL0 even if Secure EL2
was not enabled.

Use the correct check in sve_vqm1_for_el_sm().

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240722172957.1041231-5-peter.maydell@linaro.org
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ce319572354..8fb4b474e83 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7232,7 +7232,7 @@ uint32_t sve_vqm1_for_el_sm(CPUARMState *env, int el, bool sm)
     if (el <= 1 && !el_is_in_host(env, el)) {
         len = MIN(len, 0xf & (uint32_t)cr[1]);
     }
-    if (el <= 2 && arm_feature(env, ARM_FEATURE_EL2)) {
+    if (el <= 2 && arm_is_el2_enabled(env)) {
         len = MIN(len, 0xf & (uint32_t)cr[2]);
     }
     if (arm_feature(env, ARM_FEATURE_EL3)) {
-- 
2.34.1


