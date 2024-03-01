Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C418C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 18:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg7gT-0006TB-2A; Fri, 01 Mar 2024 13:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg7gJ-0006PP-Oe
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:32:29 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg7gF-0008KA-Ie
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:32:27 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33d61e39912so1129554f8f.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 10:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709317942; x=1709922742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ug89tsgOuUzq4MSu20MZm19VI4nBxO1N6UPUttck1FU=;
 b=BQWWLHIHzvh68hMEDDX9/mbZCmafIcS0q6ZDaWOYJZrtDJnClNV3cTuBP1z+6ZXS2B
 ydjMIdWq1pC/uqu9HrHE5jifA6J9aJ7lfm1fwaFObezQOwDJ0lgxYj0fqI4oHrwEC3Zl
 zJD7dleaH8snaQ4xkWL1bI/QuXJkqugPxLrS3IypMMMLgI9melY4UHWQn+WjmT4cfvc9
 VqRKiXa7AtFVsYMn/x28URTDIuLphXKjxORBOAtu77Onc2FAqagUye7hbEdOLwO6WFSg
 kEHue9AKseQzSo7z3xogZznI3pGCHmGHaTFv/6Axqytlpa1OoD+UJBXAmkrTxqkFg1g5
 jKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709317942; x=1709922742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ug89tsgOuUzq4MSu20MZm19VI4nBxO1N6UPUttck1FU=;
 b=XFjLYXgMJsg9OWwlXr2gdtdrcHSFZLr2cIoo16C8ZrpDg26Vz9ziR3b+ejz81JzVDp
 1u6d7l/IhN7Cbsi4Mal2HpUYLoaS1Oay4e6ya+VLlj44oux9ERKETi/ekg692LHlw3vm
 yAfGgfbHcOUn9okEstpCk5nONHTVC01pfC+pL/G7SD6Cwt+E5NB72sRo92AjrNK20A3S
 /R2ku0IUrGtLC5rMz5oovMQgjqeWGX8c96gBK/yRiXmBgbMwmuhYmAoLsp56vz62Xlb6
 b18VsaDS5NCAHQd/A6I1jsdyrpcYo4T9/1WQakM/cNY/mgfmy1LfEjOh/qKvo3bX9E4G
 i/QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV69bG6YxxHKU6yMv66JVhoJotnMRISOn0sta+061wD8WupmoK65ZfOIGbwTW4jPEVkV6QVpicJ6PrVcez5K+7CyV12PRs=
X-Gm-Message-State: AOJu0YxfXX6JxExsZluBp25KHfysZ7CMuPIEvTwE1VhQc+/+HOAeo+w9
 gZ8u0ervpNsK7xYKPllxlJEH1ln5aGsSyqolZQWytWJOmRgwMa9K82rjJuGKWcg=
X-Google-Smtp-Source: AGHT+IGSxIVHkn5oIZjsAY1kslwbRl5malwilqxnbBQ/2xTGZdMT4X8W280rHhHqp3cmm07IK9o/Fg==
X-Received: by 2002:adf:ec90:0:b0:33d:746b:f365 with SMTP id
 z16-20020adfec90000000b0033d746bf365mr1762332wrn.52.1709317942051; 
 Fri, 01 Mar 2024 10:32:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u2-20020adfeb42000000b0033b483d1abcsm5158934wrn.53.2024.03.01.10.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 10:32:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 2/8] target/arm: Timer _EL02 registers UNDEF for E2H == 0
Date: Fri,  1 Mar 2024 18:32:13 +0000
Message-Id: <20240301183219.2424889-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301183219.2424889-1-peter.maydell@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The timer _EL02 registers should UNDEF for invalid accesses from EL2
or EL3 when HCR_EL2.E2H == 0, not take a cp access trap.  We were
delivering the exception to EL2 with the wrong syndrome.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 90c4fb72ce4..978df6f2823 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6551,7 +6551,7 @@ static CPAccessResult e2h_access(CPUARMState *env, const ARMCPRegInfo *ri,
         return CP_ACCESS_OK;
     }
     if (!(arm_hcr_el2_eff(env) & HCR_E2H)) {
-        return CP_ACCESS_TRAP;
+        return CP_ACCESS_TRAP_UNCATEGORIZED;
     }
     return CP_ACCESS_OK;
 }
-- 
2.34.1


