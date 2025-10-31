Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24AACCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwn-0004kF-9j; Fri, 31 Oct 2025 14:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwk-0004hV-JL
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:59 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwO-0006E2-42
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:57 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-429bcddad32so1072574f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935610; x=1762540410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=U9gKnb3/MsOXv7HSh7ovN2NpAyCHwloJjEdIUMYAtFs=;
 b=IGp1EiZgQkxrrkp9L0VExu9njuSfPwc9Dqq4E67pZ+CP7dDMtfW07Qn2HZqv4CKyXP
 MzEqCUlxNKCrEkeS0+Qia7QnLM0XXB6UAwnsfb1t8dw6mOyJIrw/4YO1a+WhrSFtCHtg
 Ym+djANeib5alNIqvtIqNI5EsQk3+rFxaumntdF5ewKgvRo9jVJVDskt9O1TIGAiReGF
 y02g0RSu6XPru5qhxVdi/+e4/69Te84Nj0I07ty74bV1cBevcnu+s5Vbj54hnqToURds
 Olf8aMReX3Ty+Hc1MUdzlr783Loj2KALqcLXG91bKGFzLdMUv8yU7b5mn9W4H49xQkBU
 l63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935610; x=1762540410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U9gKnb3/MsOXv7HSh7ovN2NpAyCHwloJjEdIUMYAtFs=;
 b=f1nYyC1YYGHkS9cDtU0G38vuOMMmtb83njcKr5+ZkZp62fn5JUV7mOkCbRSxEbxX5W
 6Gjqe5VxOOKo2Y18b4fhckjngrIZg/H9LEUv+SrvEddh8o5EBweth2e45Xxu7Oq6TniU
 EnLwUKh7S9esvg+flEm8nHSD3fFnD2xUZ+3GVkrbY/8aKT8oudb4yzza28OLlq7rrlPh
 oRCp/RAy4Dmsy8eJ+qiCOGrrtJT81RcXcFt/N00EGfrfMYCveQkA3Spyp9gw+VECYA6v
 U7yebnFPZvTg3nvx0bwkZJnnPO2V1GOlaf4sGMAUsU6VXtuepulB2ZXXf1QZVq2ylgQO
 WHNg==
X-Gm-Message-State: AOJu0YynpJQLgJ695uwIgvg0oAgEDIbLVaLtF4uuCP9P3wFVuukuw7XQ
 LMjdhUYoNAlOZbVxpqbE5CNE/ZIMlWYqD3JR8M0n7kY7InRVj5ttDtb0iwl9RSUOdoEIZdp2cmQ
 LXo/2
X-Gm-Gg: ASbGncswNrbeHvVuhwUbqlaM/xdzfheVk3szDbdn1iPykSjhTWBoiw1skma68yesDMS
 TBR/ApzadJEmu9DP9hcITe2epodWJfd+bjW9t4bTm/VEMixyIAzSjjMqXkbqGuUHgOh86ukfyT6
 b/Cn6NP4ZTLXZTCtT9H+05jFg0z1bzDjbAtOdyI/2bTPtDlVNQ3E2bFcTvIAxfWDVXy9PeXYSVy
 t3jDamK43qYOK1zLq1VzMS3rJ65puBLnm8KEs2IR3kKb1JVFDunZnIaAA5Mva9MsQjugft/nvYT
 hjxUBGb1LOYZnUHoeJaYrPlouucxhgODXglSqocg2PT4mx10xZo2bTIYtI8ksj62nBUUnWLiY4y
 WDyVNVcNLDHbKrxzrYPlZYWBgS+wzJtmBIQsDSL1F09+shOsSilvU6D1Zq5XbiLlpznbf+z4Isj
 p5JMz+tcENvj30Nip0QpWyrDaCimc=
X-Google-Smtp-Source: AGHT+IFKla6hTfvgUeu3xr1dj98apkFBuF7D/5iavKgGywj5O27W3EikONDNtk7X3C87QAdSuENeHg==
X-Received: by 2002:a05:6000:24c2:b0:426:d5de:e454 with SMTP id
 ffacd0b85a97d-429bd6a4578mr4120053f8f.31.1761935610503; 
 Fri, 31 Oct 2025 11:33:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/38] target/arm/hvf: Mention hvf_arch_set_traps() must run on
 vCPU thread
Date: Fri, 31 Oct 2025 18:32:50 +0000
Message-ID: <20251031183310.3778349-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Since hvf_arch_set_traps() calls hv_vcpu_set_trap_debug_exceptions()
and hv_vcpu_set_trap_debug_reg_accesses(), which must run on a vCPU,
it also must. Mention it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index bfccf5e9a2a..ee04943b0f8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2192,6 +2192,7 @@ static inline bool hvf_arm_hw_debug_active(CPUState *cpu)
     return ((cur_hw_wps > 0) || (cur_hw_bps > 0));
 }
 
+/* Must be called by the owning thread */
 static void hvf_arch_set_traps(CPUState *cpu)
 {
     bool should_enable_traps = false;
-- 
2.43.0


