Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5B9C2D0A6
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPtO-0003qA-9y; Thu, 15 Oct 2026 14:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtL-0003pK-Oy
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:23 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHPtK-00012O-7x
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:09:23 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so613899f8f.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792087761; x=1792692561; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Ry/9sS1LW29XYCnKsN1lhfVB9lTxH1lBj3h2R+KXI4=;
 b=CqPiDjPfbgzVjyWz/mLaAyx1qjXMmJmkp+LQtWXqnF+btNivwMzmlElBdIltfu+sZX
 YhIzgpf/EGb47QGz9AImOmRAThg8duiRjPr2qdEl6R9ex19SBd6jZWPjxsf95NwCAL4W
 XoNSsKcpUxcZDE6UjgweNXuf3VLifHC0ollvEFxyuGlI+MWyWxhy+5g7TV7jhi6r0wR4
 aqI6xbLzD8nyC14tnvx0CQCogCfnxj8u8/V5wPWfVNXbD/xur2DcIPoHY5EjcTvFsEnZ
 yuzZAGwz7cBfFSDyj3MqhVhXTYOVt2K9O9w6j+nQDXdJMXxrvFiUiLogwQTpgjSV2RFY
 QTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087761; x=1792692561;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0Ry/9sS1LW29XYCnKsN1lhfVB9lTxH1lBj3h2R+KXI4=;
 b=h8HF9dof+Fq/qyrHIIC0a9Hr1IPJCi0J2mQ0gB5Kzef14WjgM8SDK8ogFnFobaVBiW
 HklKIUPMnssQ47ytFR9UeKJ7BcVEOmY3voe9aX2d5ISBY7t+po5V2vG3hc/5W5zdN68l
 j44zmOBkWlNFS7+3DlEUdrOr/tRRBxRUnUIPAsPMrW2JKwAMZ+Pd03Zbj905guVAIWPq
 8JVgu0lIZQKdjnBTmLiMdTFgDhAxQ5jvgRd6IExM9qkN+E2iI7Pr9P6FboOfED0Y4sS0
 7PzRDdTSLeE10qDRheCYKNZT3Gf8F4CF8gLjWvBu0WhdZK27FMzquPSV6kmAA4m7EE9w
 JTow==
X-Gm-Message-State: AFq9FYL1tH0B8bnk/HOvFPx94QCYYMCXfDyOVweyQaHcMEJ+7+f9gtcK
 f2vpCViccoz3JGhxAsE0uXTgueIz6s9AAMd4/zEk+qTJbg102jLBB+fcPAzBXEqCXSCmPOjBOVI
 3+56cbfg=
X-Gm-Gg: AYBFou2CDB2drTQkg0IzjDjhmdrxQisQ84BJ5RmsIK2XUz5C3d5R5uNyE2rsv/bSuwD
 Rjv4F7431Xm4kJrx1/eL6PfjjmjW34bajAClx6sSpQQLKkdRh0Pv0zYf1B9eO8j+z3w1rjIfiTT
 W4ZIKvWLb8eF0ZlIV8Pfl3M13p4LvDZtQFh6NB8Dyhvh8vh+UT6XwyYaiLxIpO0zKjJHJV48ACw
 hhA9IIh9t6YnIOx3V9ScjGcf3soVgi5sDh3TlcTmn6jR6s4HXGACo2+ORcbMztIbLx5plM2J0jb
 UpRP3MCeLlPkkQpvTPLUCNoX4GkRDqahJrk/7p1+qAooptwreifoY8SLdqgWSKdroK6nHj861e6
 9uf+ywBu/3alhs1EUdgRXUfkUGwkKiPW5eIO8IJZAbVbQG1kHdhugu0hUTUDEkK64lfWeHBv+N4
 BUUTT7473y96DsRHKqi7IQaKuD6/heU0IJNnGgNMRlLHXOka/knlVE98hCH+FqkikbbkqX9tLUd
 DVIkdUhhs3O9BL18te6IIi2h9RTl7O1ATPGrGBGcellR87CceOLUA4f8snwUcO7bwHEQ2K3QJI+
 GNE=
X-Received: by 2002:a05:6000:987:b0:48d:f14a:9182 with SMTP id
 ffacd0b85a97d-48df14a9367mr8798703f8f.20.1792087760713; 
 Thu, 15 Oct 2026 11:09:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7773d02sm14692701f8f.13.2026.10.15.11.09.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 11:09:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/16] target/arm/tcg/gicv5-cpuif: Fix typo in
 ICC_PPI_SPENDR1_EL1 name
Date: Thu, 15 Oct 2026 19:08:58 +0100
Message-ID: <20261015180858.1863407-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015180858.1863407-1-peter.maydell@linaro.org>
References: <20261015180858.1863407-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

A cut-and-paste error meant that the cpreg for ICC_PPI_SPENDR1_EL1
incorrectly named it SPENDR0; as these regs aren't exposed to gdb the
string here is for debug only, so this has no visible consquences,
but it's confusing.  Fix the error.

Fixes: 585dad9e79e1 ("target/arm: GICv5 cpuif: Implement PPI pending status registers")
Reported-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20261013105704.1071427-1-peter.maydell@linaro.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index a6e6c440849..e847fc722b9 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -893,7 +893,7 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[0]),
         .writefn = gic_ppi_spend_write,
     },
-    {   .name = "ICC_PPI_SPENDR0_EL1", .state = ARM_CP_STATE_AA64,
+    {   .name = "ICC_PPI_SPENDR1_EL1", .state = ARM_CP_STATE_AA64,
         .opc0 = 3, .opc1 = 0, .crn = 12, .crm = 13, .opc2 = 7,
         .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_pend[1]),
-- 
2.43.0


