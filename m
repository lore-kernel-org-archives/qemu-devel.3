Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BCFCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:05:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN7J-0007vR-Ko; Sat, 30 Aug 2025 11:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urt4U-000579-Mo
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 02:58:51 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urt4R-0003N6-7J
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 02:58:50 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3c854b6459fso1366177f8f.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 23:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756450723; x=1757055523; darn=nongnu.org;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=evoy54U7aEmzZ9F35YDylbpt0gv0hDdNSMweUaQNRic=;
 b=v5vijYRu1yhpDppeDcW4hmCr+5Y8FfMDuoMgiOWBSbaJq7xKxUQh8GHo1v2T7IONfr
 8SkpV1PulhjUsqtPEnMOHCLJkN1sZ+fCaUHz4mReiyW7+IEhdDGtdWnw69sIMop8Bv9/
 ues5yfsrnt9foX4wsKkC9mLOBeUSh7uwSCu78KEM/SiT6/DUeStCdgM/tHfxF7KwoCq0
 LdKyZn40d4UE56HNLtD0+osdWSdVuwVbyxtupeZyCROmq0jS61FFTkFLr9zFbZVaH93E
 xJysLzS2Zq/9BY120vmWR8yVj1Ds6QIu4ZaZuGrqtSHGyNPK5E/5KcN7JubFhX655xhT
 WFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756450723; x=1757055523;
 h=mime-version:message-id:in-reply-to:references:user-agent:subject
 :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evoy54U7aEmzZ9F35YDylbpt0gv0hDdNSMweUaQNRic=;
 b=h4CT2uaQjrAGKMfEGYo1dkrdk6IqnRfoJNEC7ygfveTVtx0runJruRLLT9F2J1As6Z
 pSsc6HQy2+VQ5ClPOgd7CbSUCI32wnbzVhvgaJxAhGmCopyTvA8vP1VMPuilYs/q+A5A
 cBfXlUvQlQar0BsGYWmbs3kbgrvVj65Q21WAeINUAdtqi3vgY6qizMv+U6Hy4dm53Omd
 nEeyUf4hCEQvU/4dVfKDWwh9xIZfr8NULbL6AuNsqwMBGN8BUteA7/STwwTg6LHqQZtY
 V4qBqWdb3tuHKIUaNEN0lrcaZ730Jo7P//BtS0+OOUVuG6fdDw82z8USzNzc28ypLs1V
 znzA==
X-Gm-Message-State: AOJu0Yx3pciq/CdIx0CEp/5PAPOg1anErO6KgAPnPc7O1e2kagtAqKqQ
 K1yTSOnTRa0fQM7Zx+tnY+gRdg5tN1lmn59EqzCN+mwXK2l6AhdQdNRvsLHH75/xNHaLO8Wm4mB
 za9sxZ9g=
X-Gm-Gg: ASbGnctiJZGVr8WnbvHyIRtnWKWRzscA9WraxZuvvN35RzS4LuYrK27F5laM7cXL04x
 TWSMSeoupg1B3Tf52DzNvrt6n4VQ17nARp+DhIO37mAgvKrqjBboTdkskAN1pW7DHbt2stO51nX
 mFTuT7swh2FqqPYSaQvVesqZNO7wO8oYJMThMr8Y+e7XWLiy3nt9x7djgPhZSqmxR0dsAqZyQRv
 VNUdoCYTVX9KLN3hc2YpXPYDVpFSe5lMbEx0fGFsDzVy577ZMeSIEacTdVbyrvW74woy7ReXwCB
 1UHJ5H117GTGcZxHBKG+1up50BXb6ADKgeNzBPwr2TX1xEgf0EaidkxQIgEODj7zCDQJe5jFifm
 EX63K52CEuslQP092XJFijWY0h7ov27E/VQ0DLE5YLk+4jEgOVOzlnNFrVUrv17bIY/SM/VjQ5c
 RrZlDL1Kg=
X-Google-Smtp-Source: AGHT+IGqWEhOsaAHDh/EL9r/5wu5+dHOAyYumIh1BpDO3BbQk0nXfebg8E9tIGLbXZoDBAYl8Drsqw==
X-Received: by 2002:a5d:64e1:0:b0:3c8:2fd:60c1 with SMTP id
 ffacd0b85a97d-3c802fd6376mr14900337f8f.18.1756450723243; 
 Thu, 28 Aug 2025 23:58:43 -0700 (PDT)
Received: from meli-email.org (athedsl-4441256.home.otenet.gr.
 [79.129.180.152]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d0f85c287fsm349493f8f.52.2025.08.28.23.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 23:58:42 -0700 (PDT)
Date: Fri, 29 Aug 2025 09:58:05 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: Re: [PATCH 03/61] target/arm/hvf: Split out sysreg.c.inc
User-Agent: meli/0.8.12
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-4-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-4-richard.henderson@linaro.org>
Message-ID: <t1qu1t.3evqxo96xccsr@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On Wed, 27 Aug 2025 04:03, Richard Henderson <richard.henderson@linaro.org> wrote:
>Move the list of supported sysregs to a reuseable file.
>
>Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> target/arm/hvf/hvf.c        | 147 ++----------------------------------
> target/arm/hvf/sysreg.c.inc | 146 +++++++++++++++++++++++++++++++++++
> 2 files changed, 152 insertions(+), 141 deletions(-)
> create mode 100644 target/arm/hvf/sysreg.c.inc
>
>diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>index 47b0cd3a35..f0e4b75e6a 100644
>--- a/target/arm/hvf/hvf.c
>+++ b/target/arm/hvf/hvf.c
>@@ -403,150 +403,15 @@ struct hvf_sreg_match {
>     uint32_t cp_idx;
> };
> 
>+#define DEF_SYSREG(HVF_ID, crn, crm, op0, op1, op2) \
>+    { HVF_ID, HVF_SYSREG(crn, crm, op0, op1, op2) },
>+
> static struct hvf_sreg_match hvf_sreg_match[] = {
>-    { HV_SYS_REG_DBGBVR0_EL1, HVF_SYSREG(0, 0, 2, 0, 4) },
>-    { HV_SYS_REG_DBGBCR0_EL1, HVF_SYSREG(0, 0, 2, 0, 5) },
>-    { HV_SYS_REG_DBGWVR0_EL1, HVF_SYSREG(0, 0, 2, 0, 6) },
>-    { HV_SYS_REG_DBGWCR0_EL1, HVF_SYSREG(0, 0, 2, 0, 7) },
>-
>-    { HV_SYS_REG_DBGBVR1_EL1, HVF_SYSREG(0, 1, 2, 0, 4) },
>-    { HV_SYS_REG_DBGBCR1_EL1, HVF_SYSREG(0, 1, 2, 0, 5) },
>-    { HV_SYS_REG_DBGWVR1_EL1, HVF_SYSREG(0, 1, 2, 0, 6) },
>-    { HV_SYS_REG_DBGWCR1_EL1, HVF_SYSREG(0, 1, 2, 0, 7) },
>-
>-    { HV_SYS_REG_DBGBVR2_EL1, HVF_SYSREG(0, 2, 2, 0, 4) },
>-    { HV_SYS_REG_DBGBCR2_EL1, HVF_SYSREG(0, 2, 2, 0, 5) },
>-    { HV_SYS_REG_DBGWVR2_EL1, HVF_SYSREG(0, 2, 2, 0, 6) },
>-    { HV_SYS_REG_DBGWCR2_EL1, HVF_SYSREG(0, 2, 2, 0, 7) },
>-
>-    { HV_SYS_REG_DBGBVR3_EL1, HVF_SYSREG(0, 3, 2, 0, 4) },
>-    { HV_SYS_REG_DBGBCR3_EL1, HVF_SYSREG(0, 3, 2, 0, 5) },
>-    { HV_SYS_REG_DBGWVR3_EL1, HVF_SYSREG(0, 3, 2, 0, 6) },
>-    { HV_SYS_REG_DBGWCR3_EL1, HVF_SYSREG(0, 3, 2, 0, 7) },
>-
>-    { HV_SYS_REG_DBGBVR4_EL1, HVF_SYSREG(0, 4, 2, 0, 4) },
>-    { HV_SYS_REG_DBGBCR4_EL1, HVF_SYSREG(0, 4, 2, 0, 5) },
>-    { HV_SYS_REG_DBGWVR4_EL1, HVF_SYSREG(0, 4, 2, 0, 6) },
>-    { HV_SYS_REG_DBGWCR4_EL1, HVF_SYSREG(0, 4, 2, 0, 7) },
>-
>-    { HV_SYS_REG_DBGBVR5_EL1, HVF_SYSREG(0, 5, 2, 0, 4) },
>-    { HV_SYS_REG_DBGBCR5_EL1, HVF_SYSREG(0, 5, 2, 0, 5) },
>-    { HV_SYS_REG_DBGWVR5_EL1, HVF_SYSREG(0, 5, 2, 0, 6) },
>-    { HV_SYS_REG_DBGWCR5_EL1, HVF_SYSREG(0, 5, 2, 0, 7) },
>-
>-    { HV_SYS_REG_DBGBVR6_EL1, HVF_SYSREG(0, 6, 2, 0, 4) },
>-    { HV_SYS_REG_DBGBCR6_EL1, HVF_SYSREG(0, 6, 2, 0, 5) },
>-    { HV_SYS_REG_DBGWVR6_EL1, HVF_SYSREG(0, 6, 2, 0, 6) },
>-    { HV_SYS_REG_DBGWCR6_EL1, HVF_SYSREG(0, 6, 2, 0, 7) },
>-
>-    { HV_SYS_REG_DBGBVR7_EL1, HVF_SYSREG(0, 7, 2, 0, 4) },
>-    { HV_SYS_REG_DBGBCR7_EL1, HVF_SYSREG(0, 7, 2, 0, 5) },
>-    { HV_SYS_REG_DBGWVR7_EL1, HVF_SYSREG(0, 7, 2, 0, 6) },
>-    { HV_SYS_REG_DBGWCR7_EL1, HVF_SYSREG(0, 7, 2, 0, 7) },
>-
>-    { HV_SYS_REG_DBGBVR8_EL1, HVF_SYSREG(0, 8, 2, 0, 4) },
>-    { HV_SYS_REG_DBGBCR8_EL1, HVF_SYSREG(0, 8, 2, 0, 5) },
>-    { HV_SYS_REG_DBGWVR8_EL1, HVF_SYSREG(0, 8, 2, 0, 6) },
>-    { HV_SYS_REG_DBGWCR8_EL1, HVF_SYSREG(0, 8, 2, 0, 7) },
>-
>-    { HV_SYS_REG_DBGBVR9_EL1, HVF_SYSREG(0, 9, 2, 0, 4) },
>-    { HV_SYS_REG_DBGBCR9_EL1, HVF_SYSREG(0, 9, 2, 0, 5) },
>-    { HV_SYS_REG_DBGWVR9_EL1, HVF_SYSREG(0, 9, 2, 0, 6) },
>-    { HV_SYS_REG_DBGWCR9_EL1, HVF_SYSREG(0, 9, 2, 0, 7) },
>-
>-    { HV_SYS_REG_DBGBVR10_EL1, HVF_SYSREG(0, 10, 2, 0, 4) },
>-    { HV_SYS_REG_DBGBCR10_EL1, HVF_SYSREG(0, 10, 2, 0, 5) },
>-    { HV_SYS_REG_DBGWVR10_EL1, HVF_SYSREG(0, 10, 2, 0, 6) },
>-    { HV_SYS_REG_DBGWCR10_EL1, HVF_SYSREG(0, 10, 2, 0, 7) },
>-
>-    { HV_SYS_REG_DBGBVR11_EL1, HVF_SYSREG(0, 11, 2, 0, 4) },
>-    { HV_SYS_REG_DBGBCR11_EL1, HVF_SYSREG(0, 11, 2, 0, 5) },
>-    { HV_SYS_REG_DBGWVR11_EL1, HVF_SYSREG(0, 11, 2, 0, 6) },
>-    { HV_SYS_REG_DBGWCR11_EL1, HVF_SYSREG(0, 11, 2, 0, 7) },
>-
>-    { HV_SYS_REG_DBGBVR12_EL1, HVF_SYSREG(0, 12, 2, 0, 4) },
>-    { HV_SYS_REG_DBGBCR12_EL1, HVF_SYSREG(0, 12, 2, 0, 5) },
>-    { HV_SYS_REG_DBGWVR12_EL1, HVF_SYSREG(0, 12, 2, 0, 6) },
>-    { HV_SYS_REG_DBGWCR12_EL1, HVF_SYSREG(0, 12, 2, 0, 7) },
>-
>-    { HV_SYS_REG_DBGBVR13_EL1, HVF_SYSREG(0, 13, 2, 0, 4) },
>-    { HV_SYS_REG_DBGBCR13_EL1, HVF_SYSREG(0, 13, 2, 0, 5) },
>-    { HV_SYS_REG_DBGWVR13_EL1, HVF_SYSREG(0, 13, 2, 0, 6) },
>-    { HV_SYS_REG_DBGWCR13_EL1, HVF_SYSREG(0, 13, 2, 0, 7) },
>-
>-    { HV_SYS_REG_DBGBVR14_EL1, HVF_SYSREG(0, 14, 2, 0, 4) },
>-    { HV_SYS_REG_DBGBCR14_EL1, HVF_SYSREG(0, 14, 2, 0, 5) },
>-    { HV_SYS_REG_DBGWVR14_EL1, HVF_SYSREG(0, 14, 2, 0, 6) },
>-    { HV_SYS_REG_DBGWCR14_EL1, HVF_SYSREG(0, 14, 2, 0, 7) },
>-
>-    { HV_SYS_REG_DBGBVR15_EL1, HVF_SYSREG(0, 15, 2, 0, 4) },
>-    { HV_SYS_REG_DBGBCR15_EL1, HVF_SYSREG(0, 15, 2, 0, 5) },
>-    { HV_SYS_REG_DBGWVR15_EL1, HVF_SYSREG(0, 15, 2, 0, 6) },
>-    { HV_SYS_REG_DBGWCR15_EL1, HVF_SYSREG(0, 15, 2, 0, 7) },
>-
>-#ifdef SYNC_NO_RAW_REGS
>-    /*
>-     * The registers below are manually synced on init because they are
>-     * marked as NO_RAW. We still list them to make number space sync easier.
>-     */
>-    { HV_SYS_REG_MDCCINT_EL1, HVF_SYSREG(0, 2, 2, 0, 0) },
>-    { HV_SYS_REG_MIDR_EL1, HVF_SYSREG(0, 0, 3, 0, 0) },
>-    { HV_SYS_REG_MPIDR_EL1, HVF_SYSREG(0, 0, 3, 0, 5) },
>-    { HV_SYS_REG_ID_AA64PFR0_EL1, HVF_SYSREG(0, 4, 3, 0, 0) },
>-#endif
>-    { HV_SYS_REG_ID_AA64PFR1_EL1, HVF_SYSREG(0, 4, 3, 0, 1) },
>-    { HV_SYS_REG_ID_AA64DFR0_EL1, HVF_SYSREG(0, 5, 3, 0, 0) },
>-    { HV_SYS_REG_ID_AA64DFR1_EL1, HVF_SYSREG(0, 5, 3, 0, 1) },
>-    { HV_SYS_REG_ID_AA64ISAR0_EL1, HVF_SYSREG(0, 6, 3, 0, 0) },
>-    { HV_SYS_REG_ID_AA64ISAR1_EL1, HVF_SYSREG(0, 6, 3, 0, 1) },
>-#ifdef SYNC_NO_MMFR0
>-    /* We keep the hardware MMFR0 around. HW limits are there anyway */
>-    { HV_SYS_REG_ID_AA64MMFR0_EL1, HVF_SYSREG(0, 7, 3, 0, 0) },
>-#endif
>-    { HV_SYS_REG_ID_AA64MMFR1_EL1, HVF_SYSREG(0, 7, 3, 0, 1) },
>-    { HV_SYS_REG_ID_AA64MMFR2_EL1, HVF_SYSREG(0, 7, 3, 0, 2) },
>-    /* Add ID_AA64MMFR3_EL1 here when HVF supports it */
>-
>-    { HV_SYS_REG_MDSCR_EL1, HVF_SYSREG(0, 2, 2, 0, 2) },
>-    { HV_SYS_REG_SCTLR_EL1, HVF_SYSREG(1, 0, 3, 0, 0) },
>-    { HV_SYS_REG_CPACR_EL1, HVF_SYSREG(1, 0, 3, 0, 2) },
>-    { HV_SYS_REG_TTBR0_EL1, HVF_SYSREG(2, 0, 3, 0, 0) },
>-    { HV_SYS_REG_TTBR1_EL1, HVF_SYSREG(2, 0, 3, 0, 1) },
>-    { HV_SYS_REG_TCR_EL1, HVF_SYSREG(2, 0, 3, 0, 2) },
>-
>-    { HV_SYS_REG_APIAKEYLO_EL1, HVF_SYSREG(2, 1, 3, 0, 0) },
>-    { HV_SYS_REG_APIAKEYHI_EL1, HVF_SYSREG(2, 1, 3, 0, 1) },
>-    { HV_SYS_REG_APIBKEYLO_EL1, HVF_SYSREG(2, 1, 3, 0, 2) },
>-    { HV_SYS_REG_APIBKEYHI_EL1, HVF_SYSREG(2, 1, 3, 0, 3) },
>-    { HV_SYS_REG_APDAKEYLO_EL1, HVF_SYSREG(2, 2, 3, 0, 0) },
>-    { HV_SYS_REG_APDAKEYHI_EL1, HVF_SYSREG(2, 2, 3, 0, 1) },
>-    { HV_SYS_REG_APDBKEYLO_EL1, HVF_SYSREG(2, 2, 3, 0, 2) },
>-    { HV_SYS_REG_APDBKEYHI_EL1, HVF_SYSREG(2, 2, 3, 0, 3) },
>-    { HV_SYS_REG_APGAKEYLO_EL1, HVF_SYSREG(2, 3, 3, 0, 0) },
>-    { HV_SYS_REG_APGAKEYHI_EL1, HVF_SYSREG(2, 3, 3, 0, 1) },
>-
>-    { HV_SYS_REG_SPSR_EL1, HVF_SYSREG(4, 0, 3, 0, 0) },
>-    { HV_SYS_REG_ELR_EL1, HVF_SYSREG(4, 0, 3, 0, 1) },
>-    { HV_SYS_REG_SP_EL0, HVF_SYSREG(4, 1, 3, 0, 0) },
>-    { HV_SYS_REG_AFSR0_EL1, HVF_SYSREG(5, 1, 3, 0, 0) },
>-    { HV_SYS_REG_AFSR1_EL1, HVF_SYSREG(5, 1, 3, 0, 1) },
>-    { HV_SYS_REG_ESR_EL1, HVF_SYSREG(5, 2, 3, 0, 0) },
>-    { HV_SYS_REG_FAR_EL1, HVF_SYSREG(6, 0, 3, 0, 0) },
>-    { HV_SYS_REG_PAR_EL1, HVF_SYSREG(7, 4, 3, 0, 0) },
>-    { HV_SYS_REG_MAIR_EL1, HVF_SYSREG(10, 2, 3, 0, 0) },
>-    { HV_SYS_REG_AMAIR_EL1, HVF_SYSREG(10, 3, 3, 0, 0) },
>-    { HV_SYS_REG_VBAR_EL1, HVF_SYSREG(12, 0, 3, 0, 0) },
>-    { HV_SYS_REG_CONTEXTIDR_EL1, HVF_SYSREG(13, 0, 3, 0, 1) },
>-    { HV_SYS_REG_TPIDR_EL1, HVF_SYSREG(13, 0, 3, 0, 4) },
>-    { HV_SYS_REG_CNTKCTL_EL1, HVF_SYSREG(14, 1, 3, 0, 0) },
>-    { HV_SYS_REG_CSSELR_EL1, HVF_SYSREG(0, 0, 3, 2, 0) },
>-    { HV_SYS_REG_TPIDR_EL0, HVF_SYSREG(13, 0, 3, 3, 2) },
>-    { HV_SYS_REG_TPIDRRO_EL0, HVF_SYSREG(13, 0, 3, 3, 3) },
>-    { HV_SYS_REG_CNTV_CTL_EL0, HVF_SYSREG(14, 3, 3, 3, 1) },
>-    { HV_SYS_REG_CNTV_CVAL_EL0, HVF_SYSREG(14, 3, 3, 3, 2) },
>-    { HV_SYS_REG_SP_EL1, HVF_SYSREG(4, 1, 3, 4, 0) },
>+#include "sysreg.c.inc"
> };
> 
>+#undef DEF_SYSREG
>+
> int hvf_get_registers(CPUState *cpu)
> {
>     ARMCPU *arm_cpu = ARM_CPU(cpu);
>diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
>new file mode 100644
>index 0000000000..222698f1d1
>--- /dev/null
>+++ b/target/arm/hvf/sysreg.c.inc
>@@ -0,0 +1,146 @@
>+/* SPDX-License-Identifier: GPL-2.0-or-later */
>+
>+DEF_SYSREG(HV_SYS_REG_DBGBVR0_EL1, 0, 0, 2, 0, 4)
>+DEF_SYSREG(HV_SYS_REG_DBGBCR0_EL1, 0, 0, 2, 0, 5)
>+DEF_SYSREG(HV_SYS_REG_DBGWVR0_EL1, 0, 0, 2, 0, 6)
>+DEF_SYSREG(HV_SYS_REG_DBGWCR0_EL1, 0, 0, 2, 0, 7)
>+
>+DEF_SYSREG(HV_SYS_REG_DBGBVR1_EL1, 0, 1, 2, 0, 4)
>+DEF_SYSREG(HV_SYS_REG_DBGBCR1_EL1, 0, 1, 2, 0, 5)
>+DEF_SYSREG(HV_SYS_REG_DBGWVR1_EL1, 0, 1, 2, 0, 6)
>+DEF_SYSREG(HV_SYS_REG_DBGWCR1_EL1, 0, 1, 2, 0, 7)
>+
>+DEF_SYSREG(HV_SYS_REG_DBGBVR2_EL1, 0, 2, 2, 0, 4)
>+DEF_SYSREG(HV_SYS_REG_DBGBCR2_EL1, 0, 2, 2, 0, 5)
>+DEF_SYSREG(HV_SYS_REG_DBGWVR2_EL1, 0, 2, 2, 0, 6)
>+DEF_SYSREG(HV_SYS_REG_DBGWCR2_EL1, 0, 2, 2, 0, 7)
>+
>+DEF_SYSREG(HV_SYS_REG_DBGBVR3_EL1, 0, 3, 2, 0, 4)
>+DEF_SYSREG(HV_SYS_REG_DBGBCR3_EL1, 0, 3, 2, 0, 5)
>+DEF_SYSREG(HV_SYS_REG_DBGWVR3_EL1, 0, 3, 2, 0, 6)
>+DEF_SYSREG(HV_SYS_REG_DBGWCR3_EL1, 0, 3, 2, 0, 7)
>+
>+DEF_SYSREG(HV_SYS_REG_DBGBVR4_EL1, 0, 4, 2, 0, 4)
>+DEF_SYSREG(HV_SYS_REG_DBGBCR4_EL1, 0, 4, 2, 0, 5)
>+DEF_SYSREG(HV_SYS_REG_DBGWVR4_EL1, 0, 4, 2, 0, 6)
>+DEF_SYSREG(HV_SYS_REG_DBGWCR4_EL1, 0, 4, 2, 0, 7)
>+
>+DEF_SYSREG(HV_SYS_REG_DBGBVR5_EL1, 0, 5, 2, 0, 4)
>+DEF_SYSREG(HV_SYS_REG_DBGBCR5_EL1, 0, 5, 2, 0, 5)
>+DEF_SYSREG(HV_SYS_REG_DBGWVR5_EL1, 0, 5, 2, 0, 6)
>+DEF_SYSREG(HV_SYS_REG_DBGWCR5_EL1, 0, 5, 2, 0, 7)
>+
>+DEF_SYSREG(HV_SYS_REG_DBGBVR6_EL1, 0, 6, 2, 0, 4)
>+DEF_SYSREG(HV_SYS_REG_DBGBCR6_EL1, 0, 6, 2, 0, 5)
>+DEF_SYSREG(HV_SYS_REG_DBGWVR6_EL1, 0, 6, 2, 0, 6)
>+DEF_SYSREG(HV_SYS_REG_DBGWCR6_EL1, 0, 6, 2, 0, 7)
>+
>+DEF_SYSREG(HV_SYS_REG_DBGBVR7_EL1, 0, 7, 2, 0, 4)
>+DEF_SYSREG(HV_SYS_REG_DBGBCR7_EL1, 0, 7, 2, 0, 5)
>+DEF_SYSREG(HV_SYS_REG_DBGWVR7_EL1, 0, 7, 2, 0, 6)
>+DEF_SYSREG(HV_SYS_REG_DBGWCR7_EL1, 0, 7, 2, 0, 7)
>+
>+DEF_SYSREG(HV_SYS_REG_DBGBVR8_EL1, 0, 8, 2, 0, 4)
>+DEF_SYSREG(HV_SYS_REG_DBGBCR8_EL1, 0, 8, 2, 0, 5)
>+DEF_SYSREG(HV_SYS_REG_DBGWVR8_EL1, 0, 8, 2, 0, 6)
>+DEF_SYSREG(HV_SYS_REG_DBGWCR8_EL1, 0, 8, 2, 0, 7)
>+
>+DEF_SYSREG(HV_SYS_REG_DBGBVR9_EL1, 0, 9, 2, 0, 4)
>+DEF_SYSREG(HV_SYS_REG_DBGBCR9_EL1, 0, 9, 2, 0, 5)
>+DEF_SYSREG(HV_SYS_REG_DBGWVR9_EL1, 0, 9, 2, 0, 6)
>+DEF_SYSREG(HV_SYS_REG_DBGWCR9_EL1, 0, 9, 2, 0, 7)
>+
>+DEF_SYSREG(HV_SYS_REG_DBGBVR10_EL1, 0, 10, 2, 0, 4)
>+DEF_SYSREG(HV_SYS_REG_DBGBCR10_EL1, 0, 10, 2, 0, 5)
>+DEF_SYSREG(HV_SYS_REG_DBGWVR10_EL1, 0, 10, 2, 0, 6)
>+DEF_SYSREG(HV_SYS_REG_DBGWCR10_EL1, 0, 10, 2, 0, 7)
>+
>+DEF_SYSREG(HV_SYS_REG_DBGBVR11_EL1, 0, 11, 2, 0, 4)
>+DEF_SYSREG(HV_SYS_REG_DBGBCR11_EL1, 0, 11, 2, 0, 5)
>+DEF_SYSREG(HV_SYS_REG_DBGWVR11_EL1, 0, 11, 2, 0, 6)
>+DEF_SYSREG(HV_SYS_REG_DBGWCR11_EL1, 0, 11, 2, 0, 7)
>+
>+DEF_SYSREG(HV_SYS_REG_DBGBVR12_EL1, 0, 12, 2, 0, 4)
>+DEF_SYSREG(HV_SYS_REG_DBGBCR12_EL1, 0, 12, 2, 0, 5)
>+DEF_SYSREG(HV_SYS_REG_DBGWVR12_EL1, 0, 12, 2, 0, 6)
>+DEF_SYSREG(HV_SYS_REG_DBGWCR12_EL1, 0, 12, 2, 0, 7)
>+
>+DEF_SYSREG(HV_SYS_REG_DBGBVR13_EL1, 0, 13, 2, 0, 4)
>+DEF_SYSREG(HV_SYS_REG_DBGBCR13_EL1, 0, 13, 2, 0, 5)
>+DEF_SYSREG(HV_SYS_REG_DBGWVR13_EL1, 0, 13, 2, 0, 6)
>+DEF_SYSREG(HV_SYS_REG_DBGWCR13_EL1, 0, 13, 2, 0, 7)
>+
>+DEF_SYSREG(HV_SYS_REG_DBGBVR14_EL1, 0, 14, 2, 0, 4)
>+DEF_SYSREG(HV_SYS_REG_DBGBCR14_EL1, 0, 14, 2, 0, 5)
>+DEF_SYSREG(HV_SYS_REG_DBGWVR14_EL1, 0, 14, 2, 0, 6)
>+DEF_SYSREG(HV_SYS_REG_DBGWCR14_EL1, 0, 14, 2, 0, 7)
>+
>+DEF_SYSREG(HV_SYS_REG_DBGBVR15_EL1, 0, 15, 2, 0, 4)
>+DEF_SYSREG(HV_SYS_REG_DBGBCR15_EL1, 0, 15, 2, 0, 5)
>+DEF_SYSREG(HV_SYS_REG_DBGWVR15_EL1, 0, 15, 2, 0, 6)
>+DEF_SYSREG(HV_SYS_REG_DBGWCR15_EL1, 0, 15, 2, 0, 7)
>+
>+#ifdef SYNC_NO_RAW_REGS
>+/*
>+ * The registers below are manually synced on init because they are
>+ * marked as NO_RAW. We still list them to make number space sync easier.
>+ */
>+DEF_SYSREG(HV_SYS_REG_MDCCINT_EL1, 0, 2, 2, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_MIDR_EL1, 0, 0, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_MPIDR_EL1, 0, 0, 3, 0, 5)
>+DEF_SYSREG(HV_SYS_REG_ID_AA64PFR0_EL1, 0, 4, 3, 0, 0)
>+#endif
>+
>+DEF_SYSREG(HV_SYS_REG_ID_AA64PFR1_EL1, 0, 4, 3, 0, 1)
>+DEF_SYSREG(HV_SYS_REG_ID_AA64DFR0_EL1, 0, 5, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_ID_AA64DFR1_EL1, 0, 5, 3, 0, 1)
>+DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR0_EL1, 0, 6, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_ID_AA64ISAR1_EL1, 0, 6, 3, 0, 1)
>+
>+#ifdef SYNC_NO_MMFR0
>+/* We keep the hardware MMFR0 around. HW limits are there anyway */
>+DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR0_EL1, 0, 7, 3, 0, 0)
>+#endif
>+
>+DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR1_EL1, 0, 7, 3, 0, 1)
>+DEF_SYSREG(HV_SYS_REG_ID_AA64MMFR2_EL1, 0, 7, 3, 0, 2)
>+/* Add ID_AA64MMFR3_EL1 here when HVF supports it */
>+
>+DEF_SYSREG(HV_SYS_REG_MDSCR_EL1, 0, 2, 2, 0, 2)
>+DEF_SYSREG(HV_SYS_REG_SCTLR_EL1, 1, 0, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_CPACR_EL1, 1, 0, 3, 0, 2)
>+DEF_SYSREG(HV_SYS_REG_TTBR0_EL1, 2, 0, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_TTBR1_EL1, 2, 0, 3, 0, 1)
>+DEF_SYSREG(HV_SYS_REG_TCR_EL1, 2, 0, 3, 0, 2)
>+
>+DEF_SYSREG(HV_SYS_REG_APIAKEYLO_EL1, 2, 1, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_APIAKEYHI_EL1, 2, 1, 3, 0, 1)
>+DEF_SYSREG(HV_SYS_REG_APIBKEYLO_EL1, 2, 1, 3, 0, 2)
>+DEF_SYSREG(HV_SYS_REG_APIBKEYHI_EL1, 2, 1, 3, 0, 3)
>+DEF_SYSREG(HV_SYS_REG_APDAKEYLO_EL1, 2, 2, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_APDAKEYHI_EL1, 2, 2, 3, 0, 1)
>+DEF_SYSREG(HV_SYS_REG_APDBKEYLO_EL1, 2, 2, 3, 0, 2)
>+DEF_SYSREG(HV_SYS_REG_APDBKEYHI_EL1, 2, 2, 3, 0, 3)
>+DEF_SYSREG(HV_SYS_REG_APGAKEYLO_EL1, 2, 3, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_APGAKEYHI_EL1, 2, 3, 3, 0, 1)
>+
>+DEF_SYSREG(HV_SYS_REG_SPSR_EL1, 4, 0, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_ELR_EL1, 4, 0, 3, 0, 1)
>+DEF_SYSREG(HV_SYS_REG_SP_EL0, 4, 1, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_AFSR0_EL1, 5, 1, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_AFSR1_EL1, 5, 1, 3, 0, 1)
>+DEF_SYSREG(HV_SYS_REG_ESR_EL1, 5, 2, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_FAR_EL1, 6, 0, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_PAR_EL1, 7, 4, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_MAIR_EL1, 10, 2, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_AMAIR_EL1, 10, 3, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_VBAR_EL1, 12, 0, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_CONTEXTIDR_EL1, 13, 0, 3, 0, 1)
>+DEF_SYSREG(HV_SYS_REG_TPIDR_EL1, 13, 0, 3, 0, 4)
>+DEF_SYSREG(HV_SYS_REG_CNTKCTL_EL1, 14, 1, 3, 0, 0)
>+DEF_SYSREG(HV_SYS_REG_CSSELR_EL1, 0, 0, 3, 2, 0)
>+DEF_SYSREG(HV_SYS_REG_TPIDR_EL0, 13, 0, 3, 3, 2)
>+DEF_SYSREG(HV_SYS_REG_TPIDRRO_EL0, 13, 0, 3, 3, 3)
>+DEF_SYSREG(HV_SYS_REG_CNTV_CTL_EL0, 14, 3, 3, 3, 1)
>+DEF_SYSREG(HV_SYS_REG_CNTV_CVAL_EL0, 14, 3, 3, 3, 2)
>+DEF_SYSREG(HV_SYS_REG_SP_EL1, 4, 1, 3, 4, 0)
>-- 
>2.43.0
>
>

