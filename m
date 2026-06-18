Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB2CCD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 19:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waHzr-00016v-98; Thu, 18 Jun 2026 15:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1waHzp-00016O-53
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:01:49 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1waHzn-0005c0-CH
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 15:01:48 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6870ad8072eso561350a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:01:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781809305; cv=none;
 d=google.com; s=arc-20240605;
 b=O5uVh7woBdA/wQ9vk+7wcKX1VcwL1+4fgMaSYZPsZpaQmiPThFnve3VnzLOHBqIJoo
 cmk8+QkmrYgUawYjxhgpCdGbQYZOUhJfCrOYorbsbV98VX8XrV0TTCaCMl3vh4tmzjo4
 Iqv3IIRpm1n+0fsKgsTIMi6K+aqkoBuUil/X1/lqzszxZuCsAuAQKDSQhW4h3ZHziU/W
 801FJ8uawwbChE5wL5gNVsJJ36hlRyODCJz6/a1dQ5u45YE4etMGP77ZqCbp9wIh8llb
 tbrc+vRm3lHH9VczqXZGEhKiRmOTDPLQf2p8du3qnSKI9ZVEbuJB+Mzq/BIiadlRlWbT
 lUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bqlZXyxinj4WbnnpWjLIe9kQ2CZpg0LjUu/pyh8eV8U=;
 fh=6oigr5qFpG4fhxcqKOISPZJ8hR5uOaFmuz9yxu5ZPOY=;
 b=dhwdy0ozGUzqQ8rCpmVhzqspntOyUFuYwZQFt7UNmGX4uh4MK2iR9yOnhRKRwN9a+E
 hn9uGsW3Lgf1xQOXgbp2muak+uJU+2x5urEpnTKTTypebbkoY8tSEM9iyV5uPEPIzkGK
 lcdJ/6A5zXmMgWYsOy08aDRzkWZZAN+MwPi6h7Y5qV8asRFC/P+oyOCK247BZFp99TQY
 obqVjOlJmcnYKnWA3NlAnOZzy3eovzuZCDIliUwy79raRWOpKJkmCjSEwFQKF2IYhrV2
 EFh+7np8zeo5qwsPKmtl9QKjjRfwBUt/kFttabhlfc4rtaSMxgimVhuonMK0SD4+vMwu
 E3Hw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781809305; x=1782414105; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqlZXyxinj4WbnnpWjLIe9kQ2CZpg0LjUu/pyh8eV8U=;
 b=o6KltCCLrbI8X0zXXB/rN8MfLwMtrQYsy9Z8J59QGcAtIM5F1R0qsEcTMBj16B2omN
 LFsNnAeaRu9heaTXYnVpvKYzZQxduSCSThgrzpkyRiEmXowc/2cjnvw2BXC/D94Qw1FX
 3UJcjiCkuuwbV5IWBz6tWgsUJC1WDSuCKh8p0PYKZvHbIxPpe35baCQGkdSbh0DAf00s
 8rfZ9RStlJ76yUZlNQ0FOxQ1NtUR5RZVkoQX+4Pc9ygKUG2nFgTFuBMW5zhb/FtBPvMp
 OLLQ0ktsKQxSKvyQKRZmExMqBRtFblK7SaPTrEOhjxHohndIAlwXYqa1i5KS0oodWsNO
 aeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781809305; x=1782414105;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bqlZXyxinj4WbnnpWjLIe9kQ2CZpg0LjUu/pyh8eV8U=;
 b=E9gz8D7GFc/s60G4iy0quEahcg14ljXWb3BIYIV863b48sUGSusWxxgz7/PFXCUVYP
 PhqDSKlkzP8JJavDPZ7JGAwkh87PzLA5z9skaX2aI9iXHhcoV91BDVhEmmEzgxx8Ovpi
 vLThRV1ftepfgLhIs/ManQZ9YvAN6ZzEKxo31DnWpt0WCtXK9Jg9nQkcEFjEvj+es1Sx
 PfsUy3krnM6S7NbQ9G//Yf+T9qntu9cv973m76kopvkYon6Qn/cGtxIIqjefiAHF30Fm
 LW8cyBeDoq2PjXWCt2typJPTzMTcHvkOOxlFWpt/1dvziFfPGSF4NbTAsz9or1kSKUEX
 9ZFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ84RanVKx4KJJADB5JA80hUmUgWiHoApoJ+YJNUZI9TpEMFzCtRMHT337qc8TNeq78JFkLNnCFvMLI1@nongnu.org
X-Gm-Message-State: AOJu0YzwtCq7ZbKrgIpk1B+chhuem09Qm52Q8tm9mVWTqbmm40PWBgPQ
 vcdIQVnLNvFE0bjAcoposj7k4VRkMWEgZ7sKKa6RVRQ/uUVTNgKrNSQThYaxNV0p/aZkEPutyAR
 sq1uiYfSrMhU++N1HkZ8PD8jkXje/zGF0Uw==
X-Gm-Gg: AfdE7clAqR1zMd6IGrtBy+fQ7NJJdLP6EOxdGwVcMNhqO/+RAsH6zjvEwQfp5ZIlnBB
 xr2gTxPERYY0DeXEg3YWidOqE1OETnWjBinPNawZDtlbbLvvlfn0CnXlypVZsnhHmBQ7Z+ZuT+6
 2zboXUFZKNBCKVI6LMhIKOcWQsqYraEGMQijOhHp8JZEgny3EKhwfmRoMxqoDdnaVm7/HzCXlOH
 KguitniSmEnaiLWCo7t+7KPCuwGKZ/asp6ox3/d7MRMmc9/w0d+P1Fq9fgrqFpb7CCe1d6KQISO
 uSyKAo6OCiK8wbCEx1t/gkVkNOxPgdQ=
X-Received: by 2002:a05:6402:a588:20b0:695:f69b:242 with SMTP id
 4fb4d7f45d1cf-6973b0a37fdmr111887a12.2.1781809305067; Thu, 18 Jun 2026
 12:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260618082623.345255-1-th.huth@posteo.eu>
 <20260618175353.GA748600@fedora>
 <CAFEAcA93R4UXit4UNLf36RXS3k4MaBWOXwqP8rNFzC47B_wAoA@mail.gmail.com>
In-Reply-To: <CAFEAcA93R4UXit4UNLf36RXS3k4MaBWOXwqP8rNFzC47B_wAoA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 18 Jun 2026 15:01:32 -0400
X-Gm-Features: AVVi8CfwXLXmhBb10eJZFrG8i2eL65rUys4ku3nS_7TetsJykBKM4nlmjT5g74M
Message-ID: <CAJSP0QWkjc_rjJ8-=5_fFce1JriFsLnWwGiF9=qWQAZKRz8jHQ@mail.gmail.com>
Subject: Re: [PULL SUBSYSTEM pseries 0/1] pseries: Update SLOF firmware image
 to release 20260618
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <th.huth@posteo.eu>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Jun 18, 2026 at 2:36=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 18 Jun 2026 at 18:54, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
> >
> > Applied, thanks.
> >
> > Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for=
 any user-visible changes.
>
> "PULL SUBSYSTEM" pullreqs are our marker for the oddball ones
> that are for a subsystem maintainer, not direct application to
> master. It also says "not for master" in the cover letter.
>
> cf: https://www.qemu.org/docs/master/devel/submitting-a-pull-request.html
> (last bullet point)
>
> FWIW, my gmail filter for pull requests is
>   "for you to fetch changes up to" list:(qemu-devel.nongnu.org) -{"not
> for master" "PULL SUBSYSTEM"}

Oops. I will filter out "PULL SUBSYSTEM" pull requests, thanks for sharing =
that.

Stefan

