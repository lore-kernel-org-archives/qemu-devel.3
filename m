Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0C3C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 18:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdZCE-0003ri-DH; Thu, 30 Jan 2025 13:23:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZC9-0003qO-Rj
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:18 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tdZC7-0000Tq-Vl
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 13:23:17 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so1069496f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 10:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738261393; x=1738866193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wlns9GOwYM2bjd4U7krW4vEiipIfGOqidyiNeaIvOXs=;
 b=EVTh20+C8LgriR1TaEM6c+RgLSLMhFHYtKSLu6k+G5b4Q/WspNkpXfL8r2WAvuRMEq
 EmrIMOLuAu+CxsND4ogv2frGW2e8xS75QeCwVOjHoKgtM0UEitlqIkNCkJRDiSgqL69C
 eco/BNgx2oKmqclPWrAUxNWm6pztpvL6XOeayVJNYva3MbtliRLxlQCuLhiQTeVga3pf
 f6TA+5wTc/Q3LZEVb5nzRb/t9E4sSlgzzBfHVcU6ZoiUiGWgLkm7SVCI7Lr/BjS/sAv+
 PF6lLT6SLPuOmUyh+p8lKerdFwo2jJQFF0UB5OngA4HOzjr+xpSGR2GOHf4kTghOIDUb
 ATuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738261393; x=1738866193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wlns9GOwYM2bjd4U7krW4vEiipIfGOqidyiNeaIvOXs=;
 b=eBom7BFhkP3RhFqbg9AsfRzeWScx4RJ4dC6tGORTW3hqA883HpJIxJWqIInViy9Umd
 5FsizDDROVSB9rfadefFfAIouLExEqNZ5MyYufRYHTN+KJLnbnx7sF9t4jcRc4PbGYQT
 MMjp9FGnqgeGTwQy5f7kza8rT/Rv7W1kM7r1hT/IEKLHeu+vKhnPAXfVhCmOSykwNMPS
 IF0FtSdstYRxmHm+5GNemKHSR81kSBoRGy0+GeUKP5KISM61iPIaSoIVnlIDxvF2Sg6L
 S9H68orMaXw4wGJEUNq8kJaPHt5YL8s7oxDIUsNOd1nlTjgurywVjW2M1bn8szrouJeX
 uHPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX29tvHuWcjgJyQNJ5sZ6GyDZKYboYvHsUy9tDlSlkEF3vo/rO/VrT439jF6nCTmmespexGqpsOgwle@nongnu.org
X-Gm-Message-State: AOJu0Yx/aMXRCXEe6nsLUXUbNMH0X6NQwQR55GxWmqYsnfaArN0xJOGp
 0tgh1dIWDV2mwDRynghy3lgyNnF7hdaTAW312c3FCMKlSpffQPSjaaXrBk4T5vA=
X-Gm-Gg: ASbGncsUf5GGz8uuQ5u3D4FEXOim0ZtIXXfghkLSFlUQoIIylje6HCBGkwi+Jxq3XUi
 DcO9+/PNnEvpGHKsBYEweydXdAant7WGjRErYgJs3Yr2XApqaoURpegjvD+IkD5M9CtijSSHEpm
 2hMW+YkV3bVMMpsbr1DxHLqTvUYtReOQnU+gBcq8cQz7IJQ/n88nkohNHt+ZAr3gN5zNFCBuciO
 yEcY3P70OtAPpNPT6HhVaBiciunOu4RvTK/6GUPu4dIb81X4Ueqvssr52Ct+S6SN2EEkXqHIxXc
 jNjqJf8I3GF7f5oPswkVmQ==
X-Google-Smtp-Source: AGHT+IE2UbAKKT+ZDLAy0oJBJeXaNOHA7u6S1jdHO0APO9zbbJCdTYWh7roiFyRaiIozYNmO+XvbdQ==
X-Received: by 2002:a05:6000:4023:b0:385:fa26:f0d9 with SMTP id
 ffacd0b85a97d-38c516583aamr7804506f8f.0.1738261393493; 
 Thu, 30 Jan 2025 10:23:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c101599sm2634426f8f.23.2025.01.30.10.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 10:23:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 02/14] target/arm: Report correct syndrome for UNDEFINED AT
 ops with wrong NSE, NS
Date: Thu, 30 Jan 2025 18:22:57 +0000
Message-Id: <20250130182309.717346-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130182309.717346-1-peter.maydell@linaro.org>
References: <20250130182309.717346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

R_NYXTL says that these AT insns should be UNDEFINED if they
would operate on an EL lower than EL3 and SCR_EL3.{NSE,NS} is
set to the Reserved {1, 0}. We were incorrectly reporting
them with the wrong syndrome; use CP_ACCESS_TRAP_UNCATEGORIZED
so they are reported as UNDEFINED.

Cc: qemu-stable@nongnu.org
Fixes: 1acd00ef1410 ("target/arm/helper: Check SCR_EL3.{NSE, NS} encoding for AT instructions")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index c5245a20aaf..7ddeed0283f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3601,7 +3601,7 @@ static CPAccessResult at_e012_access(CPUARMState *env, const ARMCPRegInfo *ri,
      * scr_write() ensures that the NSE bit is not set otherwise.
      */
     if ((env->cp15.scr_el3 & (SCR_NSE | SCR_NS)) == SCR_NSE) {
-        return CP_ACCESS_TRAP;
+        return CP_ACCESS_TRAP_UNCATEGORIZED;
     }
     return CP_ACCESS_OK;
 }
-- 
2.34.1


