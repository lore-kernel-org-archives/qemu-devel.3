Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E86C8302F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 10:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWYIJ-0004h7-Jh; Tue, 01 Jul 2025 06:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYIH-0004ai-Iy; Tue, 01 Jul 2025 06:32:53 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kosasihwilliam4@gmail.com>)
 id 1uWYIF-0002H0-Md; Tue, 01 Jul 2025 06:32:53 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b2c4e46a89fso2844098a12.2; 
 Tue, 01 Jul 2025 03:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751365968; x=1751970768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wnu/gBrofYGPtwFVydQpKrmYxzDenOFmEobdvM+2Gm8=;
 b=EPqbGeW1vlk+Qkeas2Y2W9DpUXGs2R9z3SoZGfnTPnU/maUmz2XcIVoOZtYHxEFobd
 BxMjFoHdoPpRO30kEnsh3ZthlJtnggDZYBAxvtqOSmMiAvL7ki1sH5WioX8PRXMmjQ+O
 Vx/702c+egZpDftzBT4Vw++l04ei3MVrb0QH3eqTeNg9savPmwAYdMDYC1r8knyaMj17
 qwpMgODgsxTp+ONspahZ+nrP7yJEAFV9vs960qlkm7qJI9b6annJnn6xkG2QCfYIWTQ9
 E5M5esmRzfsH7prnRI7RMB1hLeDQZDQ3CQaKfyJzI80VpSBBGgztipO3PFtVhCNUBmgq
 fw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751365968; x=1751970768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wnu/gBrofYGPtwFVydQpKrmYxzDenOFmEobdvM+2Gm8=;
 b=jEcNHnM79yY5ehk8HrBfbHHi/YKc05+XCkooXWrgAiep2bScCkuPlwM/+QXimW1KhM
 wILXJ9XHg1x1Ok9iRBGVjcRPhnhq51SkDwWnKHzfMiJwtVDgPRc9DEoLftcbDykjcEkm
 nQgBhxei7gjKc9AkbOhFH7RnEySFOARCH2UJlzo4QLFb77UDfw6Ylz8dp1xeSENZzkZQ
 j6xA54grRHaSd6vqntpzrsNF+hn2yx1llEBaW/rSSmztpVYhteRZwS6Ad43VAd64A9E/
 ws1f0nSjn1V/aExJNamfrHT1UL0YPa+rxTL9w7DQoGTgW7G12oh/VYAhqPZ6uE9aHhFx
 YKeA==
X-Gm-Message-State: AOJu0YyGK6F751BDmzXMJRWmFmsBwEOUdF1/kpUm0rENYbcRFdie3XXI
 7X8JDgHlZxGODWdF+EKgin40gOZYjWt8Aq46zl9zf/ni5DkMl+jZucqAQ8RzLjKZcl8=
X-Gm-Gg: ASbGncsSWCMgExJ9rGgNRx++qFdNQ73E6qrcX+fOOOYz1iOdtsNisesGshz2oEBE8c2
 qJGn0yzpfFEeal82gX12caLW5m0NmUMLDdSHgUgnfHzpGw0FINM8LB4cNXPQb+td6IQtgBTLd1z
 qfL7CDRwGk3cEMln4AF3aaAb0CRFA2hNHlc5VaZY9QhfEPM0/1q9qqW7Nnp4fksdDqzjgYz2dP1
 HnI+StGE3KZFGffIdNdJ6vxfSmnxGbjLLCgcUi0cf+2KLHixQkqag7zD0AItdMLBUm+WUicPkZM
 3gMio4XPRSUDnJmj4dUzXm0T0gDj/HCcl8ifa2fKA7QZZVJzbUGrC1zvTsDc5sJm1uHocQf0xc4
 wXB9XIRSBxJJaNGemwYke6gz1Nc9Dz5jIp52pQZmxa/I=
X-Google-Smtp-Source: AGHT+IH01rCbS22b4X9Zpsx5hBSu+tVjO1ARxIQWAZgfMMlaqZHL4xeAb2R6uSaNb8kM70Y2Kq7yJg==
X-Received: by 2002:a17:90b:1f89:b0:312:1cd7:b337 with SMTP id
 98e67ed59e1d1-318c911e00dmr23172062a91.5.1751365967787; 
 Tue, 01 Jul 2025 03:32:47 -0700 (PDT)
Received: from localhost (pa49-178-74-199.pa.nsw.optusnet.com.au.
 [49.178.74.199]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-318c14e18bbsm10938410a91.23.2025.07.01.03.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 03:32:47 -0700 (PDT)
From: William Kosasih <kosasihwilliam4@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 William Kosasih <kosasihwilliam4@gmail.com>
Subject: [PATCH v2 03/12] target/arm: Fix function_return helper load
 alignment checks
Date: Tue,  1 Jul 2025 20:01:50 +0930
Message-ID: <20250701103159.62661-4-kosasihwilliam4@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
References: <20250701103159.62661-1-kosasihwilliam4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=kosasihwilliam4@gmail.com; helo=mail-pg1-x534.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

This patch adds alignment checks in the load operations (when unstacking the
return pc and psr) in the FunctionReturn pseudocode.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
---
 target/arm/tcg/m_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index f342d93489..28307b5615 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -1946,7 +1946,7 @@ static bool do_v7m_function_return(ARMCPU *cpu)
          * do them as secure, so work out what MMU index that is.
          */
         mmu_idx = arm_v7m_mmu_idx_for_secstate(env, true);
-        oi = make_memop_idx(MO_LEUL, arm_to_core_mmu_idx(mmu_idx));
+        oi = make_memop_idx(MO_LEUL | MO_ALIGN, arm_to_core_mmu_idx(mmu_idx));
         newpc = cpu_ldl_mmu(env, frameptr, oi, 0);
         newpsr = cpu_ldl_mmu(env, frameptr + 4, oi, 0);
 
-- 
2.48.1


