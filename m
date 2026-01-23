Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02B8D7237B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 11:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjFoS-00014y-Ck; Fri, 23 Jan 2026 06:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjFoP-000123-3a
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 06:58:49 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vjFoN-000199-A3
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 06:58:48 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-78fc3572431so20271787b3.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 03:58:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769169526; cv=none;
 d=google.com; s=arc-20240605;
 b=GwVNQ9XNhG3vEtUAsra8avbmZxs5n3YGMoMD9CKD1IUVPAU8du9XxyNLzB5RVIBAf9
 LXAKGOJs9aDR8FK20EQ0tSZLjQW8hLYlHSoW709i0elu3WsEBvkKbNzJ2zVQuTijqMQi
 pBWVRNf1z+dSQd2DGwGdGfHbS807YbqgO71NJh/uNmSSl+xBEZPUyR25sAXKRevTztLy
 CSWFwwFTkbxxDGv/QRMYeSGtnGkoY0y3IQnfpfDNqGWHB48veg+zBkoXMulrzhCh7YQP
 Db+0STOWCvtvsO3EyZCGH48/fRQdz9PugSR1sEbN2EA5wwN0rxPf/6I09L5thqbFwrKz
 Ld0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=O+kYNhCktaG6qohxbKdIw5yol+32W9ziCx/YJX3RCnk=;
 fh=4yIqWIZ7rt9TB2gJaNAvVkJPFL4XWWJSRI+nhORgXGc=;
 b=BoM2ba6MJjHLr8meGlQBjVpJMZE3K9IjA6uHhnpNTsGINRKRi61ZauE7ghqyJe/Yfj
 jEbx/6HkMk56K3oeX14fJgj8BPy8VYqCc0ix8DU5MhcT37AXeRM83SxFtxh051spofvP
 d6omOwWVlUDkXDMalfsDCuPHN+SIWb7nZGig988vJLeEPkkgY6mzVNKUi8FwpmXg7vev
 Mqjka+LgNSNUgsWjYwkI8Laz9O2srbvzd57VFoz4XLbcn9jopU9og4I4KBvvrSPNiPKb
 t9e0E9ps42amjTrcubms52zqjaFYoLOsNsxwXHfCDesisCqYi+jMsXcP8tjh0NfDY5k3
 2U8g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769169526; x=1769774326; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+kYNhCktaG6qohxbKdIw5yol+32W9ziCx/YJX3RCnk=;
 b=Ef/1HZXHKs35L8Vu5Syn1ToRsQmURsaYVn38fu1Qcg8BFlPVaC/17Xg3NgnjG+k9vp
 XeU96zH/ZvTsNs7ljNLiYYBYpwTq4OV71BmDBzD0QxUoyWpkkYDfdLeQso9DtPDIESNC
 vjhI7eZMLIUFK4ONiaceXvDwvdT7iOWj141dWm9sSqR64VcsKEpBxIeb7bvBIvWTxepU
 zV9k2q3jFfvvZcu174FGEvOcg4KpPrF6xG6QqmZJlmYC6UxEkhRnFz24C6s4bL2YrFmh
 2LN9oQlhhdMDaTouwo6/QChTs7qwDVdi34waBfz1mWmZBmLWNOP2Hw2S7AcnBFArsBnr
 GJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769169526; x=1769774326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O+kYNhCktaG6qohxbKdIw5yol+32W9ziCx/YJX3RCnk=;
 b=b00Z1snr2600TcasFR5xcgLhMb9PF5JzlBantrQ1t7ouYAPFQ2HWyYvTbvOy50w4GS
 iR2G9nghFSJYsdaCA5eDlwP+0ZqEb9evXJL3mwqyfvwzArm6zf2125pQWRySIJt7zvt9
 ukbQU/WtFpcIL346moV/QHRvHzFwyWDj2+7qjWBSMVQSp0yXFJHTuRN9gSCWXy2BRf37
 PtgEYr2edZXEEeKDuwZKms5tjKTZdVdj7hAArUWVqvxFBP2eRnQKQFDvumOoEASKtbet
 PVm0iOEycQK2EJ3Gs7J20ZrOfpMy4lFfifrHhaWVGxSTz1XDnMc+uBnPGr95BtZKSnhD
 7jOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC/ozsGUsKFGz1PxiwWxVqQiczwU/xF5qSX3lC1NAuuTepTB+zGMJpWL+9K8MtlkoFKl0m/fif0/qs@nongnu.org
X-Gm-Message-State: AOJu0Yw0VngulXDxgjs5HaLDY5Hx8Eurhh99Ek+GLbcW11PqouW9x1Y8
 0hXA0RfuxyqEH55tJ23yls5Gi+mMI50l5EARhW5VOJN/ujgcGKcyM9TwdcVcvzy1FXVs4X7S2+h
 N7nNtAXw20+u/wR6+Mv+54LP7ya5+uaEUHQNixpX8Qg==
X-Gm-Gg: AZuq6aKEuBnzPVSg5qFGmSkQlYs5xVgsuNN0wSRTPxSRi0mMd5cJeWCpWik4wRqPt1N
 jna/lAa3n8pWJfpOzqBL+Iw/j7F3CIRgvwiqssVQVIeQSxJGXqJ5raykQ8sPDVAQgcNbQ3Yv4bE
 HlLvgIkBmQu+Zu2JnoZI0hoSdoTwISa7py/BD3CQjEU39ktRn63MIC/u0pCflB4ChcPYMKWF5os
 6Eg/i8ihM/BwhUi3iEnjQ9qjOb33aYA0T1j5pzv9ms9cDQhGYD3FzLpJewK9TjhMtCF99kqHRln
 UpDk
X-Received: by 2002:a05:690c:e05:b0:788:b84:d4f9 with SMTP id
 00721157ae682-794399f84famr18964537b3.57.1769169526071; Fri, 23 Jan 2026
 03:58:46 -0800 (PST)
MIME-Version: 1.0
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
 <4d1a883b-5465-45af-8dcc-eb905f552c29@redhat.com>
 <20260123114149.000065c5@huawei.com>
In-Reply-To: <20260123114149.000065c5@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jan 2026 11:58:33 +0000
X-Gm-Features: AZwV_QgT8BYnogVp90DI71Fb6xW1aIXYZVtm1aHpBqsYXOGEvUr8F6wWkQX93Lc
Message-ID: <CAFEAcA8RFqO-U5ayU2u=dNhjHCj=1mJiAv26QihfqNfqQVq1Lg@mail.gmail.com>
Subject: Re: [PATCH v8 00/37] hw/arm/virt: Add support for user-creatable
 accelerated SMMUv3
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 jgg@nvidia.com, 
 nicolinc@nvidia.com, ddutile@redhat.com, berrange@redhat.com, clg@redhat.com, 
 alex@shazbot.org, nathanc@nvidia.com, mochs@nvidia.com, smostafa@google.com, 
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com, zhangfei.gao@linaro.org, 
 zhenzhong.duan@intel.com, yi.l.liu@intel.com, kjaju@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Fri, 23 Jan 2026 at 11:41, Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Fri, 23 Jan 2026 08:55:18 +0100
> Eric Auger <eric.auger@redhat.com> wrote:
>
> > Hi Peter, Richard,
> >
> > On 1/21/26 6:52 PM, Shameer Kolothum wrote:
> > > Hi,
> > >
> > > Changes since v7:
> > >  https://lore.kernel.org/qemu-devel/20260111195508.106943-1-skolothum=
tho@nvidia.com/
> > >  -Addressed comments and collected R-by and T-by tags. Thanks!.
> > >  -Rebased to latest master.
> > >  -Reworked PASID support patches (patch #34, #36).
> > >
> > > I think this series is in good shape now and mature enough for inclus=
ion.
> > >
> > > Patch organization:
> > >
> > > 1=E2=80=9328: Enable accelerated SMMUv3 with features aligned to the =
default QEMU
> > > SMMUv3 implementation, including IORT RMR-based MSI support.
> > >
> > > 29=E2=80=9331: Add user-configurable options for RIL, ATS, and OAS fe=
atures.
> > >
> > > 32=E2=80=9337: Add PASID support, including required VFIO changes.
> > >
> > > Please take a look and let me know your feedback.
> >
> > This big series collected R-b's and T-bs for all patches I think. Pleas=
e
> > could you consider pulling it?
>
> I definitely support getting this merged now.
>
> I'm seeing an indent snafu in patch 18 though which either Shameer needs
> to tidy up in a v9 or it needs a bit of hand tweaking by the person
> queuing this up for a pull request.

I can fix that up when I queue it into target-arm.next.

Thanks to everybody who helped with code review on this series:
not having to do that myself has been a big help for my personal
workload :-)

-- PMM

