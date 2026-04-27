Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89BF5FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHKqv-0004cd-29; Mon, 27 Apr 2026 08:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHKqY-0004aU-DY
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:13:57 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHKqU-0000uX-Dt
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:13:52 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6501c9903edso10156129d50.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777292029; cv=none;
 d=google.com; s=arc-20240605;
 b=Y1PdSgQOnWRAs3M7W+AIaLn0w01Cz+CgEnbJvJYVPIMtsqjdBaTf17l+YKbnR9pC49
 Y16IiVKRHTLR4pfDO0hKYvngxHqy2uzRBa5ZkSaAkPvKiSLO/D1sNCGnUTIK/kvKOnUa
 H0IebyhXC/XkK3iifTLODbyTMGvEYCYc4+roSdWdqOX+2DmmeQHeiGii0lAhetI3CyGP
 6tXk3djPMwvxd0966hPOxcZiJ+7YjNXy5HElios7fPxZ7jqG4XkPX5Ah8sSx7EnTqspc
 oGel0UISOTQmvWfh8zgtv/chXNU2m4Va39VRU+wHVb66pfYrWBV2IY1l+L8DxIDrNpCE
 ftMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/mpPB4Ix5xE48TU0EQCpMqXtOuf+xSKjioAXXP4tzYY=;
 fh=BBXXBmZbsnh1iUcPA7aYGot0GnoKedpL6BO7ZAJRQVM=;
 b=NkUKaqhr+T7RjCvBoCHWXyMVxjU8icNo2HX8Ren1omqWzUdMrZRTCIg9jE49dEuy4o
 zXNV3Tzz/cXiNrjq7m3FbIJVePRA6+GzPLS0HRjOo+8jwHnyxF245LVswRtM9T8C0Hou
 oZqtILk2Ig+PCkDm3KytCJ5h4qVMXr43foUFkDXBeoeRXLJ33A6FbdDM9HBULpG1PgIR
 vRcLz/k/E7NrEdcOR6J/RdczkBeMOI1x8ak8Cb28+pmkKgZu7Nrhr2uX7mJc3eqjaLU9
 b3fwWc8Gr0KYWqxA0hM8Aqu8UOrSf8S1LC2HuZW0sHjv/YRxflekS8DmxqJ2F4PYTyVO
 PoKQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777292029; x=1777896829; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mpPB4Ix5xE48TU0EQCpMqXtOuf+xSKjioAXXP4tzYY=;
 b=wzwRQxkiQIcXwUp6cE/mEysZalzWxVOzo2qTz0jyAHLdM6aI7xIJl8QGUfg64cntXQ
 LcjGk+xON/xk2jlvG+9NL65BqTtqgMppzKo0lxbNDarx5wh/R0OS1GMRVmD/i9r5Or63
 g6dWwV6cCr9Mjf9A8ZFQkWimAVfumIA65t+ofw+Ny8m4bYjmq7cF6fg5sDk7HJzHEji0
 +B6uLgl1vSzyeB9bSsJF8uuB1f63vzZjpmsMEUYgz2mCUICZYvURnX5ZsiB1U8AM+uyD
 03V7EbeKVKT222tcZ39IQY4zzVCtxVpTzrCyBxnNKbFRJsIgveORzVuELOQ1pb3RZuq1
 PeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777292029; x=1777896829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/mpPB4Ix5xE48TU0EQCpMqXtOuf+xSKjioAXXP4tzYY=;
 b=nUB74yvceeovFGrl8cEXl8O72pGdTeazAJBuFN5awZTWtjoWFFMDi4bkwzK3S3rZBI
 N7R0I8pjYe3bbYRylNPTjJTH9UrhDYrlVQXqA4qPDcSmcK2Q4ZT9xRQ4KGy9jw74+Wlc
 we+WSy6HqJiKtm/KDKzwjX6mNhhFVewfYsA4L9YSMIkJ++68L/ipy6FJwhX469OQ1P39
 57/hq1oT1eMGqYaLrbHYssGgHwcTmJmhtVBusiBvU3Ir+BDmhMlyjpP3ZQWVOJixDf97
 QtHabpsD34jXTDqZlAwVK8V4bz0FWov0BMs29RDYZ7sIuEC33rh60uOdS0oXvB0KGvYP
 9GcA==
X-Gm-Message-State: AOJu0YwPLxzSdBPSvG2E1okPFmGGPTKld6gp6hyqz1ashO+7UFVPKz9k
 aY501LTPPddJeCR2jkaWLuyakL1DwXv1B569Xqj1uLmCwjTUAvOxMvcUIpaibFWx7BBzkKdPRAt
 sebHy5BNzi5Th+dGBHlWv0cq0bJKuX2tzwHHcAB/OJQ==
X-Gm-Gg: AeBDievtiDbyqI8J4HVWE71m2Fxf1FVdI2gxsTDuEIFNPRRpNmDfh2pmR0htpAE6E7B
 vtQLHrmvMhGj0YqlmzJZgBgxXdxCYoY/sArZ/tm6sRXs9p2p612Bhc1TnYga4IKnRldDPm70G82
 FjHTw/1pPnlpteQTKDudNbNAiNUKRltMulbUwv65K76ORpcgYzXVh3LynFzT5HuQq2mgi2ahqhm
 5PiquEgkebATRzH+beV6bXvEKJsk5VbPblVvAlpDLDeCCPlUEWiN8jfvfoajZ9Q2/4qdUHVR0kB
 BZWYkms+EQkYlQiEOeBAw0OdA73FrLVczzttaE6vWHP6sj/K+x1K4IFf8jEuTjpKPHBt5LItAmK
 FJw==
X-Received: by 2002:a05:690e:400d:b0:651:cc5e:b8d7 with SMTP id
 956f58d0204a3-65310859d9emr40894427d50.22.1777292028942; Mon, 27 Apr 2026
 05:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260308203516.160103-1-shentey@gmail.com>
 <20260308203516.160103-3-shentey@gmail.com>
 <CAFEAcA9cfiDB3+=K+MsHptujVhcPexwaf+1y8kHaV692ORAdgQ@mail.gmail.com>
 <A91F1062-BD9E-45B4-B0C2-12354C356A71@gmail.com>
In-Reply-To: <A91F1062-BD9E-45B4-B0C2-12354C356A71@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2026 13:13:37 +0100
X-Gm-Features: AVHnY4JyPLZckVqrXZRMRBkmijYqNWu2Tkm9CD8bMajRKFQ_NWWMKACul_02ipQ
Message-ID: <CAFEAcA92UbkBiMZTYaDUnOc__w+LEhfDw3=rWCxHRkECpLYi6g@mail.gmail.com>
Subject: Re: [PATCH 2/5] hw/arm/fsl-imx8mp: Fix parent of ocram memory region
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org, 
 qemu-arm@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 27 Apr 2026 at 13:09, Bernhard Beschow <shentey@gmail.com> wrote:
>
>
>
> Am 10. M=C3=A4rz 2026 10:00:31 UTC schrieb Peter Maydell <peter.maydell@l=
inaro.org>:
> >On Sun, 8 Mar 2026 at 20:35, Bernhard Beschow <shentey@gmail.com> wrote:
> >>
> >> Rather than having a NULL parent, let the containing SoC object be the
> >> parent. This cleans up the QOM composition tree a bit.
> >>
> >> Fixes:  ("hw/arm/fsl-imx8mp: Add on-chip RAM")
> >> cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> >> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> >> ---
> >>  hw/arm/fsl-imx8mp.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
> >> index 0119a18416..839c925e4a 100644
> >> --- a/hw/arm/fsl-imx8mp.c
> >> +++ b/hw/arm/fsl-imx8mp.c
> >> @@ -671,7 +671,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, E=
rror **errp)
> >>                      fsl_imx8mp_memmap[FSL_IMX8MP_PCIE_PHY1].addr);
> >>
> >>      /* On-Chip RAM */
> >> -    if (!memory_region_init_ram(&s->ocram, NULL, "imx8mp.ocram",
> >> +    if (!memory_region_init_ram(&s->ocram, OBJECT(dev), "imx8mp.ocram=
",
> >>                                  fsl_imx8mp_memmap[FSL_IMX8MP_OCRAM].s=
ize,
> >>                                  errp)) {
> >>          return;
> >
> >
> >This is a migration break, because qemu_ram_set_idstr()
> >includes the qdev path of the owning device when it
> >creates the name of the ramblock for migrating it.
> >But since we haven't released anything with this change in
> >it and this board isn't versioned either, that's not a problem.
>
> Do we still need to catch that? If so, how?

The code change is fine; we just need to mention in the commit message
that it's a migration compat break but that it's OK to do that for this
board because it isn't versioned.

-- PMM

