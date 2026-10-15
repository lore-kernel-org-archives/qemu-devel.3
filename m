Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09167CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ88-0002bN-E0; Thu, 15 Oct 2026 06:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHJ81-0001xl-M8
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:56:07 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHJ7z-0008KE-M2
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:56:05 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so1301264066b.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:56:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792061762; cv=none;
 d=google.com; s=arc-20260327;
 b=bSA9qs8dGrJv21Zzj1qRasQflZSEd9ThFqHhLpQm0nwsn7WkOOZDytq/Ct3ZUl8mrP
 eFOe5f1oOaUrxTOB3TbAjLG4AuKXuUh1ofo2UU8GD0EAMTHdvMUkGJAljcf8lp3lxRPc
 aqRsiOUj4EH9KTXXNJIENW9zPVOH0jEhsGFE9gLPrqp2fVhaeIJbtew/MguWBLDRMR9p
 xtXfckWPMCm3zpxUu1M1oC19ghG1pjKpkv4WEAwgtyGlEAkRzLwn6fUlnWGbECN3cjdq
 +m8jkMbeT8Ij/Hw4hACzRc7lz96cMu9iV9GkwO3GZHzUl1xnHHo6/uvY+uETQgttSbDD
 p5QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oScWekFJ96snPBtgZ523TK9+Pu6LVvXGNcKMBHQ6H/Y=;
 fh=nghmT7Shd1ufp37gomHRMqgte1cYL0zMU00hINva8Hc=;
 b=XsT2d3EUBWe0NHVZC5UUu9VlMvTvSm4GdkQcbhQY/ccoIGhbHe+PaXDfg/mDjOr3n4
 Nx8TXtH/UMaftsPZZOjnNhAXZ+C9sAAqgeWfKC520WfXA/gVZ9380NidyVzik3LR+LoB
 yRxrDdWjmc+EGaxm68vkqkN/EyCuZw/ewQQC1kyi5mxN/RTRkDx/FP4YNCS/aWzVWDZV
 jRYD3cm1jiaqSiU51qR+Zxb3pMJZEikRIeFDuApZ6lyH+802LAg1kG9hNaRxAs4KLl8r
 2TXiBaWeuydKoM1dtWzy+p739iazEbvTf2wH0kIBcuJVqMlyb9mdRTrt9RhXYjLb/phx
 NygA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792061762; x=1792666562; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oScWekFJ96snPBtgZ523TK9+Pu6LVvXGNcKMBHQ6H/Y=;
 b=cUKCNj9muaxXPIm9347f3RRPCQMjEzgETQagMriVjk1JawIkO3E4hnn4bY0eqy1MyL
 ZLJY/kLnUReNxn/aqnKmGUJCbbfGWw50brjYjLdAXNQyGqFkdaE4fsXaC7YtmxDRkk+k
 +hgiQLW3mgPjKWYWtmX9Z58qxGOpVZNYoHrbDG+oI+y0FKjalYC79OvMxXO2faIACiSf
 7AjHLqWE6ezIghm4r6wEh2gBcZVP0yeqkju3N9aZcHbSxPJ+Zuhciu1FCQosTRp6CpJJ
 pk9UlGNjZM5UcSaHqjrs/MhCn1HZ+W0glaBZEy9mSk3ycYHFtVnSYRi0Ip2//MZCSkZw
 Z+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061762; x=1792666562;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oScWekFJ96snPBtgZ523TK9+Pu6LVvXGNcKMBHQ6H/Y=;
 b=T3UIDmee4WheA39JeZkXAMNhZJns8ewk+niLhWY+yQZRKGEy7EMUEok4xpEzdsj0KP
 lVdD6VExI7x7Q1wqgja4NGlNu0rhNbKszo5aog/le68w+rSca0C/WlSzrNU6KTnvQSDp
 D1xqasRgbfMXrr8fqY5ipdGUISuTjJdy+OHQMc0mtrYMqtvpLB/j6ZOnlTcjstlnUGkJ
 egKBd0Hi+tEPkkAV0miXBbxqaag7LqubENz1qVdKBIKrdxlOxP1mePv3YZnVcGDpZq1Z
 fxLG6wMWw9EZJidWzIoeg24GVr8W8mI6xtDLCHUXC5xac3lEcBgjg/+TRdwI058ZRTEW
 RVwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw6hLEBKvsjyaEDGYGe45/fmiRcD6e3MKKRvGrMopcE1NmaxoMwrfJkOnRb+Nv7bRtGEORCML9R7gLy@nongnu.org
X-Gm-Message-State: AFq9FYLVa2pcxl6Gw5h8OAsw83RMpvFnWax7ggB3Oo+Uakp98a5U7ABR
 qPuTfhU9r96oD/ycaE+N/TSe+s7Yg5D4PR9OZncqjaBIlkQ9e21QWbQD2BBwCB4lf3I8avkqvOV
 4gHWHCuqG4CoSz3Qbxagq1i9nx7sK3ZuxKLTYFuuUxg==
X-Gm-Gg: AYBFou3EsHrVD3SUFqRTX9biivQv+Weeik5JSOsOi5SLigBzLzlcJ+FuEz8i8FQaPUq
 MyRE43J7RKttn3v+1lEYXxSr/+Ei+ko+hY/GgOeVLzwln7gOcjeDX0mKRF4iDXlfvb84Mb7+iFX
 pfTHkEJBI4lN2CPohms0EP294ptPAXqfcimCWiuCR1XQ0xMB7FQG+D/tMtSw8maAH7qFykssdAx
 wZN5xYAjNWHSEfLaHIN95+zTxgeRn97f4yLH+NAXH+VF97qpaXFfx2R5XGfy7X00h7qNvKO4dNV
 wRFkviIHdog5G30JJzzkTSEXGrQGeZimCzH+/eK+3qO1pmNOeHWdBEXJx5l1Zc7V1ntMmL76PIn
 ydn8GkJHxCAm5JeuF17H3xrfvhGmcXrIiFJzj4CE=
X-Received: by 2002:a17:907:1c86:b0:c2d:b9b4:f4de with SMTP id
 a640c23a62f3a-c31a7065cc3mr1937537566b.18.1792061761789; Thu, 15 Oct 2026
 03:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-63-peter.maydell@linaro.org>
 <047c7b05-ca11-4194-a6db-c0dd2f4f2b2c@oss.qualcomm.com>
In-Reply-To: <047c7b05-ca11-4194-a6db-c0dd2f4f2b2c@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 11:55:46 +0100
X-Gm-Features: AclHuK_OztquhqhUEscw50NZkYUdNCx9w0OkfwCiIfaCDB2YhVWrFmBXXQ75xWY
Message-ID: <CAFEAcA-Kjrp43ZROn9a2HJtW-FckAgOO5yNgODvck5CWZnAxTA@mail.gmail.com>
Subject: Re: [PATCH 62/86] hw/intc/arm_gicv5: Implement IRS_VMAP_L2_VISTR
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

On Tue, 13 Oct 2026 at 11:25, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 13/10/26 10:39, Peter Maydell wrote:
> > The IRS_VMAP_L2_VISTR allows the guest to make an L2 entry in the
> > VM's VLPI or VSPI IST valid; it is the equivalent of what
> > IRS_MAP_L2_ISTR does for the physical LPI IST.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/intc/arm_gicv5.c                | 76 +++++++++++++++++++++++++++++=
+
> >   hw/intc/arm_gicv5_common.c         |  1 +
> >   include/hw/intc/arm_gicv5_common.h |  1 +
> >   3 files changed, 78 insertions(+)
>
>
> > @@ -2128,6 +2184,15 @@ static bool config_writel(GICv5 *s, GICv5Domain =
domain, hwaddr offset,
> >                                deposit64(cs->irs_vmap_vistr[domain],
> >                                          32, 32, data));
> >           return true;
> > +    case A_IRS_VMAP_L2_VISTR:
> > +        irs_vmap_l2_vistr_write(s, domain,
> > +                                deposit64(cs->irs_vmap_vistr[domain], =
0, 32, data));
>
> irs_vmap_l2_vistr[] typo?
>
> > +        return true;
> > +    case A_IRS_VMAP_L2_VISTR + 4:
> > +        irs_vmap_l2_vistr_write(s, domain,
> > +                                deposit64(cs->irs_vmap_vistr[domain],
> > +                                          32, 32, data));
>
> (ditto?)
>

Yep, more cut-n-paste mistakes; thanks for spotting them.

-- PMM

