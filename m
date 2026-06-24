Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E698FCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 08:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcJHH-0003Nl-I7; Wed, 24 Jun 2026 04:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wcJHF-0003Nd-KW
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 04:48:09 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wcJHD-0005rm-SZ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 04:48:09 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-663b9826fecso345122d50.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 01:48:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782290886; cv=none;
 d=google.com; s=arc-20240605;
 b=ZxZd7cMDzUgTrrb/GDwK0WxPxIWQk4QS6piWVRaJ6XyVCuzGia7ObVtlLMjjnGuagP
 evbrFu1R1R/pRhIuYnbEutex/w7nA9QUmkILSNcAZ50S9MgvGbeZHUjgXyvv0LFD2KAR
 YXMakvLXh3c2BBRDnclx7ZDEo1IrOXbTlLVLjP+JJmb2akHWr8eTIvfAFRpuGfzzfsA3
 cbQ5v9MF1cC4NRNyVjgoD7YedksR40gBBaI8OhJ+JjHpNJBCtcYKSmPrDQKuC50uIrRQ
 gKt2ZI+xyvwRblUU1k5DJhSztKnkQfu+IBcCAVeIlrX94Z7xfRGb0sQHFZ936wz7gbGl
 vDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aExyXByclJzZPf0PYoKEg5/o0gk1wH81Yg5nUVRN6F8=;
 fh=H7nYc8FGxvuZh99xoOFtgEH0WkAQurowH3UZF6kgSvc=;
 b=cwUXqNWt0eEh6CB78T5NoH5ApCutpjLGDgCMIY65goFEb/jx8UtBoRkxNCZ8K5Et+O
 rxnm6vcuiAJlXHG0XR0oUPtShgUKD71bpsPGRUnxG3hHKTtu1/BbSK3t5b1LT5wyPnO+
 MjZipRp5u7kHy7b9s6adDBK40NTeJnkVo86x3VfAkmleZlL3XuxCwN2e6B2iMcv+kvDV
 8pEwhKIapXcKNLqF9II2JuiAMPsW9yXGDL0QNJZJWg49tAfuDkGFmAbHOKHccVBV6zUb
 PKMpi7jhbpHvxcsdfIb262sbKfWmifaB+f9hmlM+mg1W1jxD27MByXNzdFw99vfN4Jep
 yGtg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782290886; x=1782895686; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aExyXByclJzZPf0PYoKEg5/o0gk1wH81Yg5nUVRN6F8=;
 b=Dz3iGz3WxXR5N95cSdX78HkgeEA1AN2ngnLInkv5idBvJoTkJKoh/6jHb+kHZztAXY
 ZlSdRxzl3W2Uv0uKOoTTQk7JOQKiyUo2al+5S9SIgxpHz2zhyfNhO9VHaQYFuPRDemna
 09/Mdy8f7Qw0mh+A1aTwcajKukYGDoc5nkEZYcsjbOXyPhAZvsKV0MdKujKWGGIP7uPE
 T1SznlcctAWllQtfIrxUfVgluYk9VjS5QrYOY4MqDEXSdbCfkDuBkrCvL+wmJjjY0f7a
 KIcHop+G04UyMIMkSRDn6xsZ5V6+NrP48sVf5O4Pkwo9uYsrRCx4MgfAFXW7JuqjH+1i
 qHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782290886; x=1782895686;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aExyXByclJzZPf0PYoKEg5/o0gk1wH81Yg5nUVRN6F8=;
 b=A+N/AHyVzODGgis43621gdgbC3cKlVpIhkHoM0gz41FKY4dt5YdcV3LQDQbgBLZxwZ
 c3hHV+oE3eC64O/jhSJJAfKqskFPf42LfwJwZEsYMH7IluSlV/m7eq4TBd1ZZvbIBbgi
 3aZDKvGSK1ettiY6K/s62fd7JJhfcur15vAhOUnx7lyebEyEOyuMZ1hPbdNhn/SpKWVj
 eV+s/Wy76xwsA3iSeCN2+H68izIXfBnFTkNJB7p3RAVBdRv2BwVoiLdhugfyAEs4UtKe
 eGqFaWnnS+VCxAJ3jdo4SyWBSXYQridiFT3ImRoMStvqAAfceLP9BeVActlsukVv/4Nv
 8PrQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpzoMvZRGthJwafVY/WeojrslezKriorAYyeMefeEpdgdum+dfAlWiP93rwF1cjYBVjjTVJmlit0LLK@nongnu.org
X-Gm-Message-State: AOJu0Yw+0Lj1lhLQIuVi55YDcppD5mhNpFwFfzDEGqPb2XdMsFpP3mRp
 TGUPdpZ8b0DAeXGvolfU6WL0q/wsZ1x2iWj2FFzn3poXRYakC0+AwgPHaDYfeI8snPdO0OJkSrk
 6G4nIz6k7bsAT8kQAW9bs2eK/TytOJN+sXCVpzEsYtg==
X-Gm-Gg: AfdE7cl8tFyiZzl0BwHHfjebZI57fHqQhHpddD4EveSjJtER4IGrsVGROIEUM3Y5xad
 Vh0K0fWaIFmnnkBO/E61JgSeAg9NceiE9Tdvzg/psSx8EWnV1kQugIu3n4lB1hFlW+0FB8TO1Gp
 6+aD4KiRqQA3VYBZsFPagXga+whYm7eiNNKcxpSX90qC2NBGmejzNKmOFBAO5VpQkFbsxFWu1Sp
 lKedwt0xkBJttm7V/nEy4N5Plz+nsiDJ90Q4QgiVI644LyneVq5/3WKrugSys6NZ10sAC3V8WxL
 k/c/H7aX8PZ/ZvdeqiW9yvBruI2yJK8WUYP4g8ABk1wkMn4ZA7kheS8U
X-Received: by 2002:a05:690e:b4a:b0:660:406f:61a2 with SMTP id
 956f58d0204a3-66313058569mr16970558d50.63.1782290886427; Wed, 24 Jun 2026
 01:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260623205839.1294-1-linisha232@gmail.com>
 <ajuD4L_ZDEg8TI2R@redhat.com>
In-Reply-To: <ajuD4L_ZDEg8TI2R@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Jun 2026 09:47:54 +0100
X-Gm-Features: AVVi8Cce7p9_cBF8Fgjb5ztbrUKc9SJimH7ljd8Zvr8cMLCK9S8XUjD2UrxLiR8
Message-ID: <CAFEAcA9GSZXV5z=KDMLvM7enC1EqHwBt--=YOYb8HW6m=EHnqQ@mail.gmail.com>
Subject: Re: [PATCH] docs/system: clarify pflash0 and pflash1 are virt-only
 options
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Linisha <linisha232@gmail.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, 
 pbonzini@redhat.com, mjt@tls.msk.ru, philmd@mailo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Wed, 24 Jun 2026 at 08:15, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, Jun 24, 2026 at 02:28:39AM +0530, Linisha wrote:
> > The pflash0 and pflash1 machine options shown in the Aarch64 virt examp=
le are only available for virt machine types on Arm, RISC-V, and LoongArch =
architectures. Add a note to clarify this for users who may try these optio=
ns on x86 machines and be confused when they are not available.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3254
> > Signed-off-by: Linisha <linisha232@gmail.com>
> > ---
> >  docs/system/introduction.rst | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/docs/system/introduction.rst b/docs/system/introduction.rs=
t
> > index bec7291e47..0c400aefb6 100644
> > --- a/docs/system/introduction.rst
> > +++ b/docs/system/introduction.rst
> > @@ -158,6 +158,12 @@ virtualisation so we can use KVM inside the emulat=
ed guest. As the
> >  ``virt`` machine comes with some built in pflash devices we give them
> >  names so we can override the defaults later.
> >
> > +.. note::
> > +   The ``pflash0`` and ``pflash1`` machine options are specific to the
> > +   ``virt`` machine type on Arm, RISC-V, and LoongArch architectures.
> > +   They are not available on x86 machines, which use ``-bios`` or
> > +   ``-pflash`` for firmware instead.
>
> No this is wrong.
>
> The pflash0 and pflash1 properties apply to x86 pc & q35 machines too.
>
> -pflash is a legacy syntax which remaps to pflash0 and pflash1 internally=
,
> but also applies to other machines which don't use the new pflash0/pflash=
1
> properties.

I think it is probably worth having something in the intro text that
makes the point that for QEMU all architectures and machines are
potentially different, and that options and command lines that work
on for example an x86 PC machine will not necessarily work on
an Arm machine, and so on. But we should do that as a kind of
general warning somewhere near the start.

The bug report notes that "./build/x86/qemu-system-x86_64 -M pc,help"
does not list the pflash0 and pflash1 options. I think this is
because we set these up as alias properties on the actual flash
device object in pc_pflash_create(), so they don't exist as class
properties that "help" can introspect on.

-- PMM

