Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB60C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wza1C-0004ie-NX; Thu, 27 Aug 2026 09:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wza1B-0004ew-AR
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:19:45 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wza19-0007Bv-Hy
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 09:19:45 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-85a50f6a7f7so22687797b3.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 06:19:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787836782; cv=none;
 d=google.com; s=arc-20260327;
 b=aHW07FUUDacurdeGU0+sKonsEMpWcLLX2gikzYQau26cVrglxrbrXSqufxGUiEVEvw
 0AmPBsYtcuhQQOPPbDQmhyObbp2yIwQjSjRJlQZnLvBPTBBg2DU1dDaUfilUzoUWxE+L
 9wvEt5roK+QHRBt4LCR7h6JRmrHpEY2Tj8PTXGu1USeOEzgPwa75mbg2XYQ/Q8nALLqb
 oOpEJG1i4cq8GHThbeQs9i1Hu9MSJLR4ssHgMe/N0HTkUodCydT4BxMx7kArcyaEWezM
 oyXpWLQlT62+nKgHqc73zJXwSiCkKTibRwGBIDDDBjsnPKod/Jhom41GBxYs3Qacl1CJ
 KjVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XiPuOcNwiQpKQLIWzQaOStCzXolFZok2QJ6bsUDaR3o=;
 fh=AJJQC8UsL25NRH65SN4WtPGIwBnn2JuaVopGicM+qcg=;
 b=mLgVkxUiOf1UeUr2gzfCANcka7kzUHV0okSr93JMTx0laDCFpSDDdQll/e65Aaudi9
 p/e1vsfGBt2R6zNzAMDYhDwWAuHgaJ8le4BmFGQzVHgxp5cYJRHneuK7UHgjpOMMnhxg
 LyPENfmCSIsCBTS1gTorhir5OPO7syvsUYyLoRgQrIMk6RE2/WuPT0whorHiWPmEbHhn
 +nRAh9/PTPmUk+j9GH7pz4Wq3IQ3dnOlUjGm1DnBXJRcPTlWjYXsmg1j4Oi00bVIhn4m
 mg0qvRONE3aCyZZyp9blIvoRj3W7UB9wjt5OaWNmPw6dB96Sf10HD9mCaQwwVsOd+bq2
 wTZg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787836782; x=1788441582; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=XiPuOcNwiQpKQLIWzQaOStCzXolFZok2QJ6bsUDaR3o=;
 b=zx+yxKrPsfj3At5nWGwwK+OD+nM7geMpeqkaumJ6+Bq4z35mSnZShEXAsfMrH6WJVr
 m8q7lz4yUpgdmFDNrP2APByHoP0NguM/c3vCgPwdk1m1tPUCB8yc5B0LYTfXS8fv5tJY
 qJNujjM8vx3JjhJmL+WAFXXTj2cDGPsSpjdy5K/hnLnqONtWgsnaSQUVw457MZKe3Ny2
 CUHPN0dGcX7l5FYUgdliVkk3BwSJbI+peJtNtmZdOS1asb9x12hem9iIp4VVG+kXdXw+
 n5C6BYNIA+TmY9vX/6gf4iehqwGJQDzm0hBVnJ6qX12Fpls/+iTn5sGXaTMkokX2J4jF
 2J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787836782; x=1788441582;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XiPuOcNwiQpKQLIWzQaOStCzXolFZok2QJ6bsUDaR3o=;
 b=Qcew5qbXsDQMeQNHFGOxXhPps/ZmoJGBA1SfLI2U6rOEwqNaT++dwc+ggArGc9vYzf
 jmR8rvldruJaV1h0Y2Zx+ax72gCqAMCpP6rEsVVwj8+WyjCSa4ZKq2mFgLpcP81Lt9zr
 y/xMyqNCyzrgfazvxqFwTSZNLWNGCfjj9gOLZmOdbSt9znStYQU1YL7ScjnVl9XvUbc1
 QBjZcO8eLwxanrv3NMqWnSBA2nMPMDWavANlEeepgxF1Sn3JZSZM/MbAF+qSOJW9VW8O
 68mjXipLWrK3Gjm4lOKJyDo+MHcYKgFXnK1tYbH9oNa1cizbyUD4QAyEEfaicmSRAuUe
 kwJg==
X-Gm-Message-State: AFuF++nsODNvpmhyGbgrnY/N2RjV0btUQAtBSkmS23XjWj11CYtd6hjr
 3jjwZHeSLbdRQICUlqiNLxdE5Ivo+r3JFmKOxFiUCg9VjAIaw5xjjTMjquH4xdw6EtFE2tBRHSI
 +UHgqud4eSa6Vb2u8soXRWvZICBK9d2/532SkYydY+w==
X-Gm-Gg: AR+sD11qMmnm3D3fXGlBo0Nk9eYYWz33IO2gXc6UXstZx7tTryJtveywnDuPt5MVRW6
 e60tkmEdMQBLhhq/tmgojfQUKKoBT6tVNyJGGjeP9u8wQnLkwGeUwv2pK7olYDAfau/KHBsbLcn
 Voiqi/R6u9osAbQxo+o1vax8po5OcMgC/0bgzqicsUNakkwXcUILKYP4bYT27WQT+rRhDld6sbA
 Kik42ij8SV5RE1TnFLW6DsMU56mcZ1g7RB1IfYDxRNrHQKvbilSd04t0jNTuxXIiDI0ol7wx509
 0r/0r9khRwlUoqdrPnOcS5YC4O7fzPlpe+fc5nnEgsjhnYc8qN/hbzwRjJ8FQse2jTo+tGL1I6k
 bqd7eubD4udJILcj36tPMq5eUWXve
X-Received: by 2002:a05:690c:e154:b0:7fd:4ef9:e5a4 with SMTP id
 00721157ae682-8574088a19bmr57630267b3.29.1787836781914; Thu, 27 Aug 2026
 06:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <LVXPR21MB7009C0007D22503C38FE053EADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
In-Reply-To: <LVXPR21MB7009C0007D22503C38FE053EADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Aug 2026 14:19:30 +0100
X-Gm-Features: AcwNN1VzKwjSYzN6qDs6MWLartAja_0p_2ov5eA7xvLgf-mJJGHJIVnslsHgeDk
Message-ID: <CAFEAcA9h98dHUim+rsaebTtmbpD3LLPKenyD8U07+vxwqASxfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] target/arm/whpx: Don't try to sync ARM_CP_CONST
 registers
To: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "Pedro d'Aquino Filocre F S Barbuda" <pbarbuda@microsoft.com>, 
 "mohamed@unpredictable.fr" <mohamed@unpredictable.fr>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Thu, 20 Aug 2026 at 01:31, Doug Cook (WINDOWS) <dcook@microsoft.com> wrote:
>
> ARM_CP_CONST registers ignore writes, so readback assertion fails.
>
> Not asserting now because all entries in the whpx_sreg_match table are
> invalid. Needs to be fixed now so that we can fix the table entries.
>
> Signed-off-by: Doug Cook <dcook@microsoft.com>
> ---
>  target/arm/whpx/whpx-all.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index 00a5de8cdc..9a5a575b5e 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -223,6 +223,8 @@ static struct whpx_sreg_match whpx_sreg_match[] = {
>      { WHvArm64RegisterMpidrEl1, ENCODE_AA64_CP_REG(0, 0, 3, 0, 5) },
>      { WHvArm64RegisterIdPfr0El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 0) },
>  #endif
> +#ifdef SYNC_CONST_ID_REGS

What is this ifdef intended to do? We never seem to define
SYNC_CONST_ID_REGS anywhere. If we never do anything with these
array entries, why have them at all?

> +    /* ID registers are ARM_CP_CONST (writes ignored).  */
>      { WHvArm64RegisterIdAa64Pfr1El1, ENCODE_AA64_CP_REG(0, 4, 3, 0, 1), true },
>      { WHvArm64RegisterIdAa64Dfr0El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 0), true },
>      { WHvArm64RegisterIdAa64Dfr1El1, ENCODE_AA64_CP_REG(0, 5, 3, 0, 1), true },
> @@ -235,6 +237,7 @@ static struct whpx_sreg_match whpx_sreg_match[] = {
>      { WHvArm64RegisterIdAa64Mmfr1El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 1), true },
>      { WHvArm64RegisterIdAa64Mmfr2El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 2), true },
>      { WHvArm64RegisterIdAa64Mmfr3El1, ENCODE_AA64_CP_REG(0, 7, 3, 0, 3), true },
> +#endif
>
>      { WHvArm64RegisterMdscrEl1, ENCODE_AA64_CP_REG(0, 2, 2, 0, 2) },
>      { WHvArm64RegisterSctlrEl1, ENCODE_AA64_CP_REG(1, 0, 3, 0, 0) },
> @@ -790,7 +793,7 @@ int whpx_init_vcpu(CPUState *cpu)
>
>          ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
>          if (ri) {
> -            assert(!(ri->type & ARM_CP_NO_RAW));
> +            assert(!(ri->type & (ARM_CP_NO_RAW | ARM_CP_CONST)));

Generally speaking the idea behind having ID registers in the
cpregs array is that it catches cases like attempted migration
between different CPU types -- writing the ID register on the
destination fails because it's the wrong value for the host.

>              whpx_sreg_match[i].cp_idx = sregs_cnt;
>              arm_cpu->cpreg_indexes[sregs_cnt++] = cpreg_to_kvm_id(key);
>          } else {
> --

-- PMM

