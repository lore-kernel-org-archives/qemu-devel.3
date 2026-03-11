Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99CF71125857
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0NCt-00081D-RE; Wed, 11 Mar 2026 13:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0NCe-0007z7-43
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0NCb-0005aZ-Mh
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773249512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ptmQhjKn8gfhE/3QmoRJXKe1h5nH8MiDy/YRTmOjOKU=;
 b=KbFTpPnUHuYHQ3q9VAA+apP/2Ayqa7zDrRZMky//ElCBXt0YoTdJlvIrZ3faTLnxmZ85FJ
 jev4lZvKn1mkJMrW6stbx6HaxfGGzqO0sPbVWQXLZxbVqLPQtyAD8hgA8RQuqG412kR1ty
 0tGeYm8LW5xV+zSo0E8Unuzo9t7+W1I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-marUYXjsPsavgox3J05sog-1; Wed, 11 Mar 2026 13:18:30 -0400
X-MC-Unique: marUYXjsPsavgox3J05sog-1
X-Mimecast-MFC-AGG-ID: marUYXjsPsavgox3J05sog_1773249510
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4853efceaddso488995e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 10:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773249510; cv=none;
 d=google.com; s=arc-20240605;
 b=AwxU8j9dQVQ25I37JxO4mffDgpE16qxcHa5rN7Zpr3T15xyppg1PWDuXEOeQ/tnjYq
 sAxlr5JCwPlylt9VusfnpVo9LLa/vZNzegdMDgqBM8S3IIM3DrfCRvCj7zKz3a5pLc9d
 VOECCHmFDsrz8VH5k82hv3xkhlmiVXsxPTs+8HfqFFBgnuvpEzVkzg3RqeRLVVdu8YYM
 zsQkHImiofEdL6a2d+IgBbwBSteqSdzd96a8OJK6dDOcbmh/L+aoWi4hk1gicgUaWkkL
 L8XQGR32yz3nKJXUP74vFA29tTrDpbmTBHs2DUvwsiDbaLR7BuRdgCLK1adpPs6HuxFg
 bJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ptmQhjKn8gfhE/3QmoRJXKe1h5nH8MiDy/YRTmOjOKU=;
 fh=ijDg/svWy9AO9ItGVWXfCXejZBBBZWKz8PPVBnke2lo=;
 b=TXaOWWBvUDVPtzHQa+OzOCqfp1qn8TfACEdDEvdoonZHCcxIAT2h+oVflHfG8glgI3
 BKZi5RuD6A/bkRxkvD2NnmvMolXRcUIuaI0pNmhdsVr5leLuiCxLSFeol9QLf79p+d59
 JogY6s3GZto+WrlDB5avTn4ssq2i5DDV+7xQy9AzIsIb/dhOf68nzj3HQxO3oSVvZrtL
 KA+ehB1/AftpOWm9uWwmGGRwLDHNZIDydGjUL+7FLcZkmND6p9eDsk4DaOjbvs9L9z2T
 a53pJ3/u56NqoEKfxxLrfU561F5nE6IW1FlB/7V6IKgxKaMiBxxs5hmwsn3reNb7av/O
 hyQw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773249510; x=1773854310; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptmQhjKn8gfhE/3QmoRJXKe1h5nH8MiDy/YRTmOjOKU=;
 b=f+ruF82MStGJQarPk/1J6pyn+DO/s4bmp8dYncojlCCsG+/QIBUFw9mq4eJrP1SbQp
 HaoK6c08PBuasMnuFzyHqq7mOg3Sc6RpIjRhJLjt+ylKeMQRPRBy2oEBURTXQjjwrAzW
 /uUmPdBwn2olkghoJBJ2Pv6lLBM2HbIcpCeP/TkiDUuUk5qj7PUk+XPBmHCKnCIZYP4j
 1lTz49t0Q6+A7zUov70L4LhPzj+k6OT0gV3vkBiUWGOAPfYYbt2YXuUZ3NKISSsJEpvD
 QBRJFNw7VXLk8LBdBFUvo2TWRqzaZ/5l2Bhao4CQqluIb31IIK+IWLo63vVqxDtJ0M+l
 XDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773249510; x=1773854310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ptmQhjKn8gfhE/3QmoRJXKe1h5nH8MiDy/YRTmOjOKU=;
 b=FC+QdTrwjWC3fv7I4EskAJCGuqNGUAQyGzo95mkyc+uvwjOWLi1En05+IvgXfxFoj9
 XTUca9lfmTq1ML8uEMsTjvG9XeyZKV75hp6+x9NMWzr6XFsxKQ91HeP38l4NUHe0tcQp
 FgQFCZvPeSdAyihTVSALlYVoZpZzS8GYn2hbaaUp0UjELB+goB4j0wv839XrqmqQ5TD5
 f5uU8UvPghcuBdr8zeXnjl+4AI9ENtxVCOCQiuTTXp+MTdDyE4Z1Sl9dTBgksOkr3IA6
 HlQy52SL3pLmv0SrH5NZLojqi74mS1JU7fZImGUrBichsKddkOMC0dOypMV6S3RxTJvs
 P+ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiA7kbyN44RYAd991WE5R88Zz5svHgo2iz+0SLn56Nt3OZla0OXijugPqMEy5u+qsvovr0gFo5sytL@nongnu.org
X-Gm-Message-State: AOJu0YzoOL3Ygc8Cd1PTAMd5O/97BdZH8uBHd9r92mOPIv+BWZqPomSS
 oG6S2vIZRaggJdB5EwhbUYbmSmSk8SRC7cTgmDdzJg/01a3ZG5kul2hNRf3u1ediP/f3gDehbBT
 kUSkZNCIn/q/EJswV/fYh4fLeOM+vgY8jCx+QUZp7Pi0XwryWca0nFzkPI7p40cBxhTU+ha4U/4
 cz94VuE7Bik2k30oPpqdN4ZTpoJDCNkw4=
X-Gm-Gg: ATEYQzxdpPewIfIPfBYR3mSQccuFwdmmh4UBHQbpjes27SV024w7rjV95m1wgFcgTqI
 Ig8R2lFWLsCb+G+vMnykTfIPRsJgZEMwMg6u7wSRNogopeCIGInmcWCEa4jeYXlwOuyVNlw/EfU
 v82gBICz0aRDOu0lMGpW282KFcdjhCG8iSQaTxpYX2jOVXT8SoPu92MsSVGMiQQtdBd8RI3h6fz
 ibOi24a+mgZqSsyHmQQX6SAWMBTfzzKGfaeKDhTgV2hsDGlT2cvMaAetkKgEKlxI9n1ECI/QWeb
 X90UK0Y=
X-Received: by 2002:a05:600c:3103:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-4854b0acb1amr53192595e9.5.1773249509607; 
 Wed, 11 Mar 2026 10:18:29 -0700 (PDT)
X-Received: by 2002:a05:600c:3103:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-4854b0acb1amr53192065e9.5.1773249509123; Wed, 11 Mar 2026
 10:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260311095405.26297-1-hi@alyssa.is>
 <CAFEAcA8GCz2c18e3+bwFooAxYZzBrX3OjjQ58CWJOdLfTYL_dA@mail.gmail.com>
In-Reply-To: <CAFEAcA8GCz2c18e3+bwFooAxYZzBrX3OjjQ58CWJOdLfTYL_dA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Mar 2026 18:18:17 +0100
X-Gm-Features: AaiRm50pcEDyXv7xD2lDu3z8yY4Td2KLNxWd2RJSWdw_O47KQFbkXprdMmcDbIo
Message-ID: <CABgObfavGAHLz0FZy66QTbXHTS7YqWxc_eVmEWnCWo+QBPiN1g@mail.gmail.com>
Subject: Re: [PATCH] target/arm/kvm: fall back if nested unsupported
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alyssa Ross <hi@alyssa.is>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
 Miguel Luis <miguel.luis@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 11, 2026 at 6:03=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Wed, 11 Mar 2026 at 09:54, Alyssa Ross <hi@alyssa.is> wrote:
> >
> > If I create a machine with more CPUs than KVM supports, but specify
> > multiple accelerator options, QEMU will fall back to the next
> > accelerator.  This is great, because if I've explicitly specified
> > multiple accelerators, I've told QEMU I'm fine with any of them being
> > used to provide the machine I want.
> >
> > When I create a machine with nested virtualization enabled, though,
> > this doesn't happen.  KVM often doesn't support it, but TCG always
> > does.  The nice thing to do would be for QEMU to fall back to TCG if
> > KVM can't provide, like it does when too many CPUs are requested.
> > This patch adjusts the behaviour to do that.
> >
> > This is very helpful for OS development scripts that run an OS in QEMU
> > =E2=80=94 I want everybody to be able to run the script, always with
> > virtualization enabled because the OS requires it, but for it to take
> > advantage of KVM acceleration when available.
> >
> > Signed-off-by: Alyssa Ross <hi@alyssa.is>
> > ---
> >  hw/arm/virt.c    | 6 ------
> >  target/arm/kvm.c | 8 ++++++++
> >  2 files changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 7456614d05..0b63b2eac3 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -2372,12 +2372,6 @@ static void machvirt_init(MachineState *machine)
> >          exit(1);
> >      }
> >
> > -    if (vms->virt && kvm_enabled() && !kvm_arm_el2_supported()) {
> > -        error_report("mach-virt: host kernel KVM does not support prov=
iding "
> > -                     "Virtualization extensions to the guest CPU");
> > -        exit(1);
> > -    }
> > -
> >      if (vms->virt && !kvm_enabled() && !tcg_enabled() && !qtest_enable=
d()) {
> >          error_report("mach-virt: %s does not support providing "
> >                       "Virtualization extensions to the guest CPU",
>
> I think there is a bigger problem here. The code in the virt
> board init assumes that the accelerator has already been
> selected: based on whether kvm_enabled() or tcg_enabled()
> it decides things like which GIC version can be used, whether
> "-machine gic-version=3Dhost" is valid or not, and so on.
>
> This bit we're deleting here is just one of multiple checks
> we do that assume that we know the accelerator already. If
> we actually don't know if we're going to be using TCG or KVM
> then all this code needs to be rethought.

We do. This code runs at the very end of qemu_init()
(qmp_x_init_preconfig->qemu_init_board->machine_run_board_init).

The bug is on the KVM side, as it lets the configuration slip even
though it's not valid; the above KVM check should really be more of an
abort() if anything. (This is also why I picked it despite it touching
hw/arm/virt.c - from my point of view the KVM fix made the above code
go dead).

> Paolo, can you unqueue this for a bit while we think about it?

Yes, of course.

Paolo


