Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C21CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGaC2-0007b8-Uw; Tue, 13 Oct 2026 06:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGaBx-0007aW-Rt
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:57:09 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGaBw-0006pp-95
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:57:09 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49d0da752ffso25810035e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 03:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791889026; x=1792493826; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YVTpE+/AZZiNUJGmv/AwVAv8W313++v/rbdBRpNdNkE=;
 b=I1yNLpE6EuJzkzmYzRcdWxvxw9DZsmJAeJuaNmWscSy2DjUP4nB0BOHMvVl5MfPb4e
 LY3fzn5qcFMLw1frzxzTI5miqQu5zaSXvLJY5wRyWop6jO9OfkUNFzQFWZm0MuV0agU1
 cuobePeR0NHkxNkWfhhb5SCYt4tRwd6ZfK7ad57L6/zvtiVpdGvyetcMgEkdVah0gLir
 eF3iLkUpfMv+C/G3yJiNzxFqfbjcSZDPZjaFsyzwjCEtBaY7V32X/A+MVxyPQU4p0R0C
 mdw3C+k+jPBe32OLy+KkXE24vyN+/iYZano5Sa1BSimIYCf/36s+0Vav516e4Hb9verl
 aBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791889026; x=1792493826;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YVTpE+/AZZiNUJGmv/AwVAv8W313++v/rbdBRpNdNkE=;
 b=P4evB17v4D7l4XzhuSBx42hY0tbdHqOujTIduI80GsTJ8X2XfteVSN13axDZLPrD5Z
 fNkSW9zfOrSQgdPNm8YRe52Zol5IlEaCiITe4US8jvjogpSzUPze1ltSINTZ+lKn6iLv
 j/d0VA/HflcIlfoiSTlvj1cjtaBfoYO7E9bYmouRzSsblwRmR8UfKRmxH6htXWMeTa4O
 aOJVMsY9gE4YTT8jedug43iSnrhD0tqxr1Rc0yFKvrBeiapjh1Ns6h9re2pqoYH8Kpnt
 q4NeIPEBBCtQl2u7TNeA/eCEekHsCxAp5lKP4ucyrYGsVlHzN2QeblOkbwYTS3082v5c
 b+Zw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxy6IKQntZgIAvxftA8EhjBcjMpror6EQ+1fax34VYtQ0zs6uDcdI1r0Dh18knncX/NNERfqvv8hwKk@nongnu.org
X-Gm-Message-State: AFq9FYKAMtCH33x6fQZaA1A2t04Po2dGHtMBrs8uO86RJB/bC2pYnFK/
 ovAmTe/3FrwyMaIyEW3d/ImQNI5jFkbpeWS2pQP2LtRhJ5wR/wnm20QbmYvcIj4XH6o=
X-Gm-Gg: AYBFou21tA7qWkmTzhtYvxyoGMzinSmTKT2WorCoVWft1dF0b4m53WreJO3XRWAM+Zr
 Ddo8VUamTOQ5ecWIdqokbrdpxpm+gA/XhtN75jPH765z+IijvYpOcjI2YZnX/v+wtk0MRagam7X
 nC8quQeIKN6i1Ti2XJAgFoupwGHOnZkpLRTz/QolTZTlkKfG+RtydIGQ50DRgVyjJRju3LZ0RhT
 1i/+0Qxfoxt3Kfgj9JyYER1a/7bD9MYlwiPZY8j+nF6OQ+M2GWa56QwM6rRE3Bd2U0WF1GNawcG
 74QPwjB/IHf2WttwiAf9KhUNcBlboeEcuCtn5kx19mfo2wPcDKtXaJYoAvD2h8g2rk6dmGUCTZo
 RMQp6TqibgrDp0Z27Y6s1fpuHPVvNVI5iB8ZAUelit5V1guQzej/ZFlfXlXpBDobGnjGl0XrRWL
 rWxPXQVSHDsBm5h0Ukpq3jefykQwsd33emcXpN/dRl5K5B6LuXpjoaZzAc9/6J8ImGseKXP/o3l
 vFUZYZ7yfEtT8tFGKyu19usyyLkyNLu0Jyah2z0g5ty5tiAOOsjZpESZqH+OEIbfj1dE8NN1mml
 XRs=
X-Received: by 2002:a05:600c:8214:b0:4a1:6425:be69 with SMTP id
 5b1f17b1804b1-4a18e4b4db8mr236641465e9.17.1791889026301; 
 Tue, 13 Oct 2026 03:57:06 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf31b83sm366682725e9.12.2026.10.13.03.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:57:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] target/arm/tcg/gicv5-cpuif: Fix typo in ICC_PPI_SPENDR1_EL1
 name
Date: Tue, 13 Oct 2026 11:57:04 +0100
Message-ID: <20261013105704.1071427-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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


