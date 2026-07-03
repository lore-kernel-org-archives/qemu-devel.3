Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA04C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:55:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfdQB-0004bn-OW; Fri, 03 Jul 2026 08:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfdQ7-0004ax-UC
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:55:03 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfdQ5-0000kz-OW
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 08:55:03 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-664c1cf7445so753174d50.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 05:55:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783083300; cv=none;
 d=google.com; s=arc-20260327;
 b=p1uMqA41dkuXPFmMnnOrez/H72zUFpnoP6lKrrpMCYSJGXLOGcJOdwSSwrIUtQIWC5
 fKZdulbxm3IB6IylYup+EsorWhmYeUA41xrpE6PcACgtylupHn7l/aAhrVLmZgLkDKM8
 sbullB2Cdywb5G6BTJTTs/qTV4US5WYMizseFfVEhCjT95d2b/JJWMirYB/y+XLXNawR
 oSoNd6NbpKIuqC/cQqdpNWSajHTvnDDg3/90haP67KvcZQptpX0SsQf/xf6MtzZzdsaL
 GqAU9gNONpdqAS6s4PgdkLGTNYqPFqnphHh3csf6gH2ywNLJtk44FsR2eZjIqakNHWaZ
 XTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1u2thVlVFjL87EGSVIuQ3xHSUXLpj4VbnSIDZ2PwELc=;
 fh=okfLDfYdbi588im0TT23bty35Y4KzqDVnP/xZ/pwEvg=;
 b=GR7pr8eAC/d0v53tDTaH6v0S53QrhiLHhlLSa5nsMWm1y0WjvloazasG7bYJ6vO4Gv
 hWQOr4L07KfhxUjvr/pQ8iESRAbJ8BR8TTk46W9uQIcgJAsyPQ2pNAlf6vtkqATwON0b
 ATQjObYOz+klJDLbcUfm6C7zjFOWsj19HF1q7YP2Vjj/366w9nrC/tDdr988yLSlY2c9
 RF/86cfZO2P2Q9VlSdoQUBANj4qV3zBlFAC8ypIYth9+Z5tT1cZepzcdQXvKA0h+ZS9g
 zu6DklFftih9yqGJrqNBGcOJE31USsKnKEpfIpUU1pq/oS1Ou96MDG/5+nLcBLgt6gaA
 EDZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783083300; x=1783688100; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1u2thVlVFjL87EGSVIuQ3xHSUXLpj4VbnSIDZ2PwELc=;
 b=tZyuw/UCPppN/HVKscY586oOpwXHu/39DbDCVzyUiechMGJzy2n9g0DD4WxIlgr6/y
 tuzAuMhL1RuWIe1gZZ8FJLqFMokcgvemjsin7qT6yF9UEkQAMXcqFcC+sh8XKXZULhfV
 LpPkskoJWDq2DwVCKGkgoyWYmEO/yMWyeRQ3MuFE/I31yfiHYpcvhVAgW462TyLuWCTL
 +TjV2rxnLz6FrmH+CYRF9yH/ckjkcIvU5HD3Pjmw2xNby+tFkKWb8plmzG/Y19hVdWdP
 FWb4zAQ430K2dy4dzNSzGurnMGocnQJN3GhZ0ZWRZq+lLAzCsQ4PL1rJ8nvX4m2lS8eD
 OkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783083300; x=1783688100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1u2thVlVFjL87EGSVIuQ3xHSUXLpj4VbnSIDZ2PwELc=;
 b=l2bTR9JH6XhvDUCduEW52407EB54kg2GTNYnXlL86BzkFLJf2701bOz/ybVby+UAVg
 Dwoo5qRsQl9uFhCr0H/9LHXME5o/ZKMgu51SvMF/MdLLW0SIr5iAvmpUdxciKLo6ywZ7
 9a0fQFCtkMr9i2IU6dTZyWgUt5Tb65xorcZ73L7kvmlC/CITnpQDJ2wKMltuGgW9Ft//
 58pOCYQtFNJ9SZOPDiMHtIzyN1fQsyYAMsygDSmtmEfatldkpHglA9bcyw1LjD7NJAkr
 N5yJqCdVUfNtyw7wL0ViJbDhJsJhZd3B67RS9Vr5PFZVgJl1/nuwFietRd5IRvaihaN7
 psng==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+qNCNfmGiKx2ZkWqMJdBh1q4gpS0KCApCmlm80nGTMylBZvwsXUYottEpUJj52xiYc8Urkrbosrhb@nongnu.org
X-Gm-Message-State: AOJu0Yztkc+yA3CTHESBnsu0v57btGVv0ty+gRi1P+teaIgnKeFto6ng
 bkk8QokmSmfsBw5NT+NHdC6PjrL2lU3LB8NBg9pXr3DT6Kd29TKpTrSoidA3eSoc1PU0p3b3yOH
 ciINlU9JnyX79dzZeB1qWgt2dq8oXTUDMrX+dlaoKtw==
X-Gm-Gg: AfdE7cl6SeyTKPPN+z/ura9TrnESg3ee5IQU0oBXc5081Se0/8SNMZzHh97/1FnwKIs
 N2ihzgRyIQCUIPrqP+HE5M1C40XlV+9AUtai34C7r1SgsOyIe78UES4Mxayea3l2qK8p6uqV6NH
 isFUAnOzoK0oqU1coHBMv2blNYLI7a7AB/1YEK0Xt7W1qWVHcOMiiSuQejXb8t1FhPWDg6S5dRx
 U0VGjYp+dy5QdfU1KAXvhsqHygKfJyox5gWP2HPXuo0mw1ndUCBJy2JxU8Wt09uCem6tU4ZR06q
 OARn0sZmvLvE+szOhW9PLPkbnwJpInzCyR9MPCvq+Rqjc6nW0cM1VChd
X-Received: by 2002:a05:690e:1918:b0:664:eac2:b394 with SMTP id
 956f58d0204a3-66521ceff4fmr9105449d50.65.1783083300316; Fri, 03 Jul 2026
 05:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260701091209.2860306-1-eric.auger@redhat.com>
 <20260701091209.2860306-4-eric.auger@redhat.com>
In-Reply-To: <20260701091209.2860306-4-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 13:54:48 +0100
X-Gm-Features: AVVi8CcRuAFalwoMTAbI7ZQ4dYf1E7O6ETSL-m--vFfkn3jGqWaNHIWsmkUOOlw
Message-ID: <CAFEAcA8kHPouGSrxb7+NkTRonEoJiub4JNuThSJBr6hncrX0vA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] hw/arm/smmuv3: Sanitize
 SMMU_S_STRTAB_BASE_CFG.LOG2SIZE
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 berrange@redhat.com, skolothumtho@nvidia.com, nicolinc@nvidia.com, 
 nathanc@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 1 Jul 2026 at 10:12, Eric Auger <eric.auger@redhat.com> wrote:
>
> STRTAB_BASE_CFG.LOG2SIZE is programmed by the guest through the
> emulated SMMUv3 MMIO register interface. Currently the value is
> not checked and used directly in smmu_find_ste() for strtab_base
> alignment computation with risk that MAKE_64BIT_MASK() runs out
> of bounds. On FMT==1 the strtab_size cannot be greater than 64 after
> the SPLIT being at minimum 6 (log2size is max 64).
>
> However on FMT=0 path, strtab_size= log2size + 6 can potentially
> exceed 64. Let's abort in that case.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3632
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 285e6164a07..5ec3700d0d5 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1696,6 +1696,14 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>                  s->sid_split = 6;
>              }
>              s->features |= SMMU_FEATURE_2LVL_STE;
> +        } else {
> +            uint32_t log2size = FIELD_EX32(data, STRTAB_BASE_CFG, LOG2SIZE);
> +
> +            if (log2size + 6 > 64) {
> +                qemu_log_mask(LOG_GUEST_ERROR,
> +                              "Invalid STRTAB_BASE_CFG.LOG2SIZE: %d", log2size);
> +                g_assert_not_reached();

This doesn't look right. Either:
 (a) the guest can do something silly that gets us to this code path:
     in that case we mustn't assert, but must continue (doing whatever
     the spec permits and that is reasonably straightforward to implement)
 (b) we can't actually get here in practice: in that case the logging
     isn't needed and we could just assert(log2size + 6 <= 64);

It sounds like we're in case (a) here.

thanks
-- PMM

