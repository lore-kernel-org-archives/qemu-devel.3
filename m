Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8C8CD98CF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQyL-0003XT-MD; Tue, 16 Jun 2026 06:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZQyK-0003XL-HT
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:24:44 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZQyJ-0007a6-4I
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:24:44 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-662bb8b1f93so378481d50.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781605482; cv=none;
 d=google.com; s=arc-20240605;
 b=DR859fVRbKMTRTp4LE3rBHdvDZC/oDrqw+uGvGGaj61j0RsGHO8FPv7kgm1vds6zmL
 w3XV2M2do67As4730krL7L61qI9sDqWdX7puE/be9nz8fEGpWQZ7RQ3nqHghe6j58e97
 0CrO1YcIQzGOmH+GuUgqc5tKm+yDvqLj/oYmTY9Do8TfMoSzloGf9zz5hywGk2nu33h+
 aO5KDQNVd9hySFrRNoQIwcSaPEc1qIDVNvnUr2yXZsfcEM6vNZu70FZ8SviJrZCG1xXj
 oHFsuBiwSUqAAPH7Fns98IDwP/zjJiKHgqk7US2lkTd0opCN43ghyVyGOd9xdSSVLMRx
 pzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rWfMtlR8BCYk/QWMeDj3keDOoD+bQ9KbctfXANo8Zq8=;
 fh=VUZ7eJox894qpEuQTEFSefKlY4l3x+uBmRGBSaSsOHU=;
 b=Mi8DowQAxHenCYQMLR6tpjJnTzxUDo9baFyZavx4kkt1v5t8NcoacHo4yNnnbCE1Wq
 GaE9+ekL5UEVviVYo2eH46vM90bFti4yJWE6RJbKfJlnpBgBgEazhC7LomUDS9j44u2j
 E6qtgQfTq1P5hKdJpGhiczEfyC2tyfA2bER239Iu4mieJrVOte+EhJxbL/F6hae1wEo6
 Eao41OQlMaxvtF7EZJbik1nfxz3+jplxM5CE48/4W8AkmuzFsyW7aRlZ+cKzkWK9Td0S
 /WCH7dqorx2EzkJOuJgicDdc1an+24ja5/b6AceEG+Rum1nh8c5NjgdC+jCH/HahmRTB
 OpvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781605482; x=1782210282; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rWfMtlR8BCYk/QWMeDj3keDOoD+bQ9KbctfXANo8Zq8=;
 b=dUtH2GB1J7wzOiAch8DzEStb23yZST3ECIGNg5/3ZzTAZuJlS0aH3edipHSeYfHA1C
 msZ5IbnB8AZX3fZg7keTF/joJDpxVXDTCCHi7V1UKAqOPIK3qG99azmqOkqfCs4/qZVa
 /5wmxNS4EsFmi/v/4+k1pv1Dzq0teT6wBV5zoCokpyu0PEVxVnu0Hy8llUTUBH62ynUY
 pOrsUwLEp3P6wRzX7rc0mTAglhUY8bOSNmSBxRP0xcBPtwShlDSx16hF1fF6ykOF5pV2
 INWzpiTlpQA++jlF5nudFgqvBuqFeU7praKH/bSEMierGTj1IwSGNhDeRQRHDPNCXHJd
 8xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781605482; x=1782210282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rWfMtlR8BCYk/QWMeDj3keDOoD+bQ9KbctfXANo8Zq8=;
 b=qwxdNxtT6SrTtiNBKF+s0IjoJCTvBE7gbhxD3js2OmKxDeyUPqobILVQliag+a54jx
 pADJUd44Ap4iw+jACLe2Nw1n1bOPpcwWBVH/PrJU2RRKG9UUYyTEwitIwX5BnmUcNy/u
 o/Vt917GP1E+ILIj3JFqseV8qGXM1GWEVTnv1k/96Drc9BT+L3/8cKC+w73LpfuSXCWh
 R8w8s6XvJ2EHcFivFbY1o7enQ0xX6+1Z+HtzIlOxHA5KIUNizQL9NnQW+2trJ9dX/GRZ
 dYds4oVFQ/eJQG6iHsUiCffYsydvNIAjQp4jLfaoASd25c1zFEblf+v5vhalXQGBKgHY
 1kRg==
X-Gm-Message-State: AOJu0YyvRw8gwP2rr2GFZ9PkZd9qDeo/G2mDNkUCqkMHYbKRAKNGtI/v
 N/Qp5F484DHu3GftvIXMmQf/60YXN1FgU7E8TLnCSIoo+gKB07bClZWUXXWw41ggg9FS1RQq2o5
 bGs7nixxNMMYDPvRm+9MjIGlx4dDI5kkEZaLzfU2L9JLxM51K+TcZ
X-Gm-Gg: Acq92OFyxK3m8z8KLx4gyVmVyzHcPGrTL2qhiolmrGZq55J+fKBl4+dR44dRQkq9r9Y
 W+RUeP5PZFwpyC/gxKPRnH3n0ZC+dZDoJ4pDlI9ECTTrXmNnrdnUw8H0/HjGtMyRTeKxT0O3fic
 XmNoo0w3D98hZkFxwboA2pno+FYxsymYtCozc3O6dphQV+Si8uNDyoxgl6ClI8ZM40ixlk9iVQj
 rQH6GjukVhGUqHvkht3gWlPrxhctK3/M/nyVks8qLaC3f/1vRw44U2aQMXWBPUd1INO8D0YYmka
 7/pgciLq0N+uGhQQkqq1j2oB0ohrQpGG3phPLoDgomhDYX6+II7nxqCf62ka+djn8CEhRPGzzjc
 mlg==
X-Received: by 2002:a05:690e:1441:b0:660:3f57:9fc5 with SMTP id
 956f58d0204a3-66277f91cdcmr14798249d50.27.1781605481857; Tue, 16 Jun 2026
 03:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260602063350.3623723-1-kchiu@axiado.com>
 <20260602063350.3623723-3-kchiu@axiado.com>
 <CAFEAcA_1iWjVskvWBgye6OFGgGAcvwhGUkVPmKZGT44fGMux=g@mail.gmail.com>
In-Reply-To: <CAFEAcA_1iWjVskvWBgye6OFGgGAcvwhGUkVPmKZGT44fGMux=g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 11:24:29 +0100
X-Gm-Features: AVVi8CeQlr4DCFjtJgzWjiUzCcFp93eieU-jOSrYK1SlhxsI06Srjv8zz5yWiZw
Message-ID: <CAFEAcA8_NQhhnk7Or+jmxyDk=3G4h1xFTr7p9RPkBYc482yNJA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] hw/sd: Add Axiado SD host controller with eMMC PHY
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Tue, 16 Jun 2026 at 11:22, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 2 Jun 2026 at 07:34, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
> >
> > This patch add a new model for Axiado SD host controller which is compatible
> > with SDHCI 3.0 spec
> >
> > This device model also includes a eMMC PHY which helps to control SD/eMMC
> >
> > Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
>
> > +static void axiado_sdhci_realize(DeviceState *dev, Error **errp)
> > +{
> > +    AxiadoSDHCIState *s = AXIADO_SDHCI(dev);
> > +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> > +    SysBusDevice *sdhci_sbd;
> > +
> > +    qdev_prop_set_uint64(DEVICE(&s->sdhci), "capareg", 0x216737eed0b0);
> > +    qdev_prop_set_uint64(DEVICE(&s->sdhci), "sd-spec-version", 3);
> > +
> > +    sdhci_sbd = SYS_BUS_DEVICE(&s->sdhci);
> > +    sysbus_realize(sdhci_sbd, errp);
> > +    if (*errp) {
> > +        return;
> > +    }
>
> You need an "ERRP_GUARD();" line at the top of this function,
> because otherwise errp can be NULL here. (There's a long comment
> in include/qapi/error.h that discusses the various ways of
> handling Error objects and the standard patterns to use.)

Actually, better would be to use the return value of sysbus_realize()
instead of looking at errp:

    if (!sysbus_realize(sdhci_sbd, errp)) {
        return;
    }

Then you don't need the ERRP_GUARD.

-- PMM

