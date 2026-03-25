Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49586109C045
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:50:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RQs-0003uY-3V; Wed, 25 Mar 2026 12:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5RQr-0003uP-1D
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:50:13 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w5RQp-0007lC-6o
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:50:12 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-64e87a81639so97298d50.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:50:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774457409; cv=none;
 d=google.com; s=arc-20240605;
 b=kvhCevjmw5HNVvrBhmXBpCWrXmzp7fFu3R30IwaeTZN/skhFarfeVzVn/L0lJU8GvB
 HpA8+CUjhL+oTGpgUmNO/cl7TIBCtfq5e3BjpqX3dY4eSmVSiBtjwKJhuSyF3AFIZVP5
 2o0PBDKnQj/w+Z0IZUaGdW4OjNvO0hYdvpg+3/F3/ZtHOtkQ4KpBqfFTtBXWELB8HrrN
 WtWW/J2nn7ouULdwrEX6rdSYmInzNf6hYpry7mh2YG2y0OC3Z502D+oO3FA1/BmdJX31
 9wNl8T1C4tEUJNRiS5p6N4yMF6Amx63R5pRLxD9KqLvtT6pjT35qXbAi5KzJdP9hWYa3
 ZeOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1uPpUrJcQq9gvUDmcf2q4qqdOAWnNPgAVB03vvaspD0=;
 fh=XoT/3m2n+5Tb9qQIQk6AFhYpeFMXMsOisqFc1vSJFkE=;
 b=eUtVBTo/TUPXLstPafpX4W/7WrdFkIyv4ec+/dLd1AuRQdkG3LsASzVUiGUFYXXRc8
 dmxXvWGoAXb/spgijLmfNvK9m5zfmfPmDIn/q/HOngAo7z4qc52/3O3tmD2wg+AV+BOt
 pq6m11oTZ9MnGEQz06nZd0C373ZZqS63bYcBL2tf0PipwlRmMLDNAt27AFf9QXijiPiq
 5CNG/9Vv0ZtEOxW+Sw3M+KqqUJFF7UlM01MjyprhTHCigYmY5ZajgxSbRvIjxC5qRnAw
 fEatH/8Xs5Dcux+FQJGz+e/9I9952E1BlUGi3aYVlH51uy9H+LESSwd5wjZLReDoy62/
 fHkA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774457409; x=1775062209; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1uPpUrJcQq9gvUDmcf2q4qqdOAWnNPgAVB03vvaspD0=;
 b=uW3jN0zvNFYZNtH2lzomNtvQgyYSX+c3HdK0bwmW835fP3H5R5C9tBMmQtCFFAzKK+
 ckvds0+nK40MAhKg28hpVXASRcwT81oYt/6gerGWexaI+EbQ2DEiu1m9IW0TdAxwdfIc
 ZvWpH0qpsFGktYSsqCZ4+NVvYiWpmDaehe8/8H9ARqMl4f0Z4thCfmAnxYXdMMKppHow
 B34rFetlRq6Oc+UznOJKQ0EMou2z+sfdecp8cTyKkc+yUKmvv02TKf0GAq2Vq4A5qJ4S
 KFIdem/QxGrM78r6VCYaU82i148usrKiodn9xxdmdw6EDV301uAQLm2I7h0tVpgMVHpd
 hYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457409; x=1775062209;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1uPpUrJcQq9gvUDmcf2q4qqdOAWnNPgAVB03vvaspD0=;
 b=dh1y6QQ1QntIJ5IxjUtVhLm26yUFoOgSGWeGjAJV+aJ1PN3mIjTVNgHrHLX23zEaEi
 FwmOIFhJivrVWqwAEOflVyCxA1Zh6Bl896E5LYWm/0Ni0vuuJselfXWKcb6l6KC4j5hE
 NWaKyJKfsk6AROE2vNq7V8XySCxk+C9E/CDIkzy71iIApEbGf7zotPn+R0hhMTiLgHuQ
 uu+QpCqQcsypoOW3pl77r35nhntXNfIXT9VJlxbxmN8ir+3Kzc6Xd/bQOistAUoIfmOB
 bDzGABGVrZPuKfVJ+RX0GE6y8nVGbaWK06hVNmi5ilZLoCX2BbUZlJIXZ9ewTMZD9mvL
 Glqw==
X-Gm-Message-State: AOJu0YxWFz1cUiUbIf8tGBrSK1BqLBGI1VeQ60uZaRB3Vf7yF943ZPlO
 z1rNl+qP+RgEeUXkW7CnfH2yT9mKMImHW/BZEJMix8krXNwz025ahd7lXvHI1Ktx7vyZUtbe4Wd
 bJdcfBbqvFwKFppVf1+AqoL84l2uxNrhvUt17Na5Txw==
X-Gm-Gg: ATEYQzzeCQdxKC38lUXeGuqVPyHj7mwBTbzr0byqaZzyuKuLHj7PuiCJ9+O6bX1NEsA
 H8cYWkXhd1lGmz2ecCvYROLpLgmGnEG70WNgEP8IFX88E9Ur2T/Nzbmv8vFvbEWluJQWuJ7U6et
 qs1OLVmRdlLN7IUhXwFc55WAXl/zPUQxpxVjkC2arAgYRIV/4o+P0Lc0Xgv7scKPgN+5O8jpZ5b
 mLR09uboujmK9By7B8S4x4z8Ru/wi6fv/xUAZam6+JSZwhFg9XWpOThtiTWbOjpbXQLLVvc7BOe
 zs0u6akUG8F5wuM4ZDYtGVGois9bT4XlvBp8QIV6wTXu2OINA78GomJrhaguXHJGmTg=
X-Received: by 2002:a53:b782:0:b0:64a:ce9a:ace2 with SMTP id
 956f58d0204a3-64ee61584f4mr2984740d50.56.1774457409169; Wed, 25 Mar 2026
 09:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
 <87tsu4m8w4.fsf@pond.sub.org>
In-Reply-To: <87tsu4m8w4.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Mar 2026 16:49:57 +0000
X-Gm-Features: AQROBzB4PGhpbACCDml78xJTmL2ty0HYNOQid75G_YWHXdNc1aGdOYXIFPzDTgM
Message-ID: <CAFEAcA_DEPSoAnEzobryPbqU77QHwqYyxybmdi7KX2wjJqzRhw@mail.gmail.com>
Subject: Re: Cleaning up contrib/ and tools/
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Wed, 25 Mar 2026 at 11:44, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > We have a couple of directories in our source tree which have
> > accumulated things in them that don't really belong there; this is a
> > proposal to clean up by moving things to more appropriate locations
> > (as 11.1 work, obviously).
> >
> > Firstly, contrib/ has a tendency to be a dumping ground for stuff that
> > we didn't think hard enough about finding a good home for, and for
> > things in a weird "not really maintained" state. We should either
> > (a) care enough about something to give it a correct home and to
> > maintain it, or (b) not care about it, and kick it out of our tree.
> >
> > Secondly, tools/ exists but is very under-used. I think it should be
> > for the set of standalone tools that we build if you configure
> > --enable-tools and which we document in docs/tools.  Currently it
> > contains two things, one of which doesn't match that idea...
> >
> > So, starting with tools/:
>
> [...]
>
> > And for contrib/, easy ones first:
> >  * contrib/vhost-user-{blk,bridge,gpu,input,scsi} move to tools/
> >  * contrib/elf2dmp moves to tools/
> >  * contrib/ivshmem-client and contrib/ivshmem-server move to tools/
>
> Absolutely not.  This is example code, provided in the hope of helping
> people understand the protocol, and experiment with it.  It is entirely
> unfit for more serious use, and that's intentional.

So, example code but we don't think it's a good example ? :-)

Our system documentation seems to assume you're going to run
ivshmem-server:

https://www.qemu.org/docs/master/system/devices/ivshmem.html

> Perhaps contrib/ is not a good home for example code.  It seems to
> bother people whose judgement I respect.  Can we find a better home?

I'm not sure to what extent we should be in the business of
providing example code. If we are doing that we should label
it all a bit better...

-- PMM

