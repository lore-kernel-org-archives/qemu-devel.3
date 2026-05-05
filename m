Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DA8CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 10:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKCbS-0000eC-7u; Tue, 05 May 2026 06:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wKCbO-0000br-Lj
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wKCbN-00088U-1O
 for qemu-devel@nongnu.org; Tue, 05 May 2026 06:02:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777975322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=weTLYI+YyN3nPUFT7CWcoaWdKKQJSIlqBo9WtVqyjSo=;
 b=Rk+/jWsTC89kegBLZLY+7aPYJ63vpQVBp6NitlF8wPi2Io9o07tnaCievkSZt7h7j8LWRw
 Wyxf8GCwEivZi7UW4miDLO+o1bvBPVIkDDBZHA1IpIc3Iht8p+Tdsc7TOrAUMqG6/rrx/c
 Jd7tW/OXtEGETpNjU/10rx/2BKfhR0k=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-TEc86z_3OP2A_qoStibWgw-1; Tue, 05 May 2026 06:02:01 -0400
X-MC-Unique: TEc86z_3OP2A_qoStibWgw-1
X-Mimecast-MFC-AGG-ID: TEc86z_3OP2A_qoStibWgw_1777975320
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35fb969a4c0so6045839a91.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 03:02:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777975320; cv=none;
 d=google.com; s=arc-20240605;
 b=cVEbYAlejoPWNBCD4WuRo9PLGmk69tqFqB6IVC2taazW7N8iYR9fpwgaMyWJ7thQoJ
 6+V9Fs+dr23ykbpZFPM/PwpAwzoxM0Z9wnEutu89TRQv9pZMh3rUvAtEOF/O5U2SpYdK
 ypaJP1L9k8PDeSsPmw89lFd0MLv6YWFOpOTOotLvvfDui8fhGVp/9D/ZdHflMVLgPZK/
 ZwxKMef+hFynTEoQNFtAArBq5f5lBQHI7k6PmiNrdZ4KR/X1D0t0Ovk6KL3KprSDP3UR
 CmL9wna7fR2QkTRzlMPEbv51dQNNLjjwHngj9q8nGpbLFUTQHels7XynM+l5uiQz3KDR
 AonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=weTLYI+YyN3nPUFT7CWcoaWdKKQJSIlqBo9WtVqyjSo=;
 fh=IIVq14YtGeHsqR1qXM8TWLElWWlW0t0XUfvIwOGX8mQ=;
 b=Whma/JhidRYFhvj6waqpvw4qkP1B6WUPQhhdLFKycYQdAkezZzFLt+z4nszcSBW69b
 FKyUkDzBjrAY/xl9lOBilQT9kRXeh2XaUr3hSFhesxm9Fs1BpWQc1s1u96Mfn7CgGiCN
 GrIgYqOcJZggz5ulkIif0fe2AmforK1NWwSYO8+7Ow8o0SOzk553qAAllbh5hFiQnKGH
 J2rtd7cjCMD/q+vSbgloJJFfE73PCwtnjppKJMx18L0/dt0oW32lsKOP69KEll0bGXYC
 jMTV5DDnP7vcg8fP69rchgqbMLMlIt/SgTXYIjYw+uRJZTEB39SBUPv4LDlRisOLwgPc
 oazg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777975320; x=1778580120; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=weTLYI+YyN3nPUFT7CWcoaWdKKQJSIlqBo9WtVqyjSo=;
 b=U2RjWtMDkj/Bb45ooOqrKDmo7ySj2G3znZhLCgftO2cNssPglUP2aDL940sSDViotk
 7RUjOsNxas0hQMuYKP0fOKuu/dbzfkcUlrT64KE+/yanBvTLff46Uo5R1cNErGuS6u2l
 OqT4Bb4N5rY7HWkZQd/qaC+yVw9a/Mv/fA40h12FVxJZoE2XTtvMssuUmXmlwwi2E/bT
 /niwPkOxeVeJNfRSCA257S9TqivCY+2TAqQSwMgp1wxYwdMjZKVoTSBYr8qtuk5nHrEo
 UlU/RE1cl+XtLlQm3VemAj25BRzNT49914c11C96V+GyZ4f+ICXWt7ZMYsPubZkB0C4X
 p8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777975320; x=1778580120;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=weTLYI+YyN3nPUFT7CWcoaWdKKQJSIlqBo9WtVqyjSo=;
 b=b4DA6jyBxwrwVRxqx5koYbX/By3+4BiE9BSFvhU9luLHMbNJcS//et2FUYawQ9iYH3
 ZqEsFLfpgWD2q1Lw03jFXuxnG9sPoOBJwb94QKrB/xohzW/chU6Q0w9o9E73YccCLrN5
 1OT/B7SluUn+kbMm+K9/jigpmAOgLr+xK6fC/XuBBfOpY2kcNQAlYma1DRmHXffPJp0b
 iaz7+ZUJwgqGv5dZPXRFoqE5KrokSEb6yifdQkS3wwgjq8HQuubXkewFUUgb09b64jkS
 mDezKH64t/vMb24SKmbKUS/8iD4Pr0LjhjcuP6nJaq3akqCbxBNn8OtJm/rdb7g4aCVz
 miMA==
X-Gm-Message-State: AOJu0YwBtQmmkWd6xzQ+nRiopsFMH/r4+ufgYI+ClDEc4xfgsowVgSjo
 EWeAgNsPGvCBV9C5ogp9/LVddF8AvfZuzccXbTtWxE8mRYkjsr60oUITG1V/kzHJo4S9YZADXhq
 Hlnadj1UeyneVZAFz4NbgbpjOyl+8jVdRNAObdA5RHt3KXPWX57FAmUCq3Pj/mJxwA5R5arbcuR
 Ix/kn844veEmQDLErzaHCerTLfRVkB0XM=
X-Gm-Gg: AeBDietSxtfyOyB6gj9bAMBo6X6asWaz96GODEytxe2pkoN8UpqVM+xa1dLBtmT3bzi
 2ReUcehThsnxEFSH4iUg4hjwLvuokd2SfiK3M53LJvdcu8lSuhWHWJQA1gJwcc2xQy9L9cvGjz3
 P4uqc8Cqf5vZ5GaQXVF85hL7beVk/YPcMmX1bE69IizyOdqWJjcmaj+s+exrOH+7ykT2zvCLa0t
 jhsBcn5yu8u38ahnkaVgM1xpivY0AZKn2gYbMVJTUsiBd/Q8vRvTar2uv6S5nFhOHLkNUH7msig
X-Received: by 2002:a17:90a:da8e:b0:364:87dd:b2c5 with SMTP id
 98e67ed59e1d1-3650cd70722mr12243207a91.3.1777975319731; 
 Tue, 05 May 2026 03:01:59 -0700 (PDT)
X-Received: by 2002:a17:90a:da8e:b0:364:87dd:b2c5 with SMTP id
 98e67ed59e1d1-3650cd70722mr12243171a91.3.1777975319177; Tue, 05 May 2026
 03:01:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
 <20260504-qom-tests-v2-7-ef7e3dc94f7a@redhat.com>
 <CAFEAcA8BAOvSKUxvE_yn0psM10v+WPZy=9=DLeneXGKeiWSrHg@mail.gmail.com>
In-Reply-To: <CAFEAcA8BAOvSKUxvE_yn0psM10v+WPZy=9=DLeneXGKeiWSrHg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 5 May 2026 14:01:47 +0400
X-Gm-Features: AVHnY4Kmk7L-74HfUZwQwAdkO_KJekDcyRsKZCr_xSrM5oS4ZMCLkaOhnGOB1iY
Message-ID: <CAMxuvawmHjz31dUBeiuHaVy5cgq_vhJe+8Nz8S1iKE8wcGubCQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/46] hw/ipmi: reject NULL 'bmc' property rather than
 crash
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Tue, May 5, 2026 at 1:57=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Mon, 4 May 2026 at 12:36, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > The type-checking macros (IPMI_BMC(val)) which crash on NULL.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/ipmi/ipmi.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
> > index b49affaccec..d532d38e556 100644
> > --- a/hw/ipmi/ipmi.c
> > +++ b/hw/ipmi/ipmi.c
> > @@ -95,7 +95,14 @@ static const TypeInfo ipmi_interface_type_info =3D {
> >  static void isa_ipmi_bmc_check(const Object *obj, const char *name,
> >                                 Object *val, Error **errp)
> >  {
> > -    IPMIBmc *bmc =3D IPMI_BMC(val);
> > +    IPMIBmc *bmc;
> > +
> > +    if (!val) {
> > +        error_setg(errp, "%s cannot be set to NULL", name);
> > +        return;
> > +    }
> > +
> > +    bmc =3D IPMI_BMC(val);
> >
> >      if (bmc->intf)
> >          error_setg(errp, "BMC object is already in use");
>
> I was looking through the code to check where the type macros fall over
> on NULL pointers, and I couldn't find it, so I did this little test,
> and as far as I can tell they don't assert, they just return NULL:
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 2ecad3c503..32569c1f09 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -66,6 +66,7 @@
>  #include "e820_memory_layout.h"
>  #include "trace.h"
>  #include "sev.h"
> +#include "hw/ipmi/ipmi.h"
>  #include CONFIG_DEVICES
>
>  #ifdef CONFIG_XEN_EMU
> @@ -1580,6 +1581,9 @@ static void pc_machine_initfn(Object *obj)
>      PCMachineState *pcms =3D PC_MACHINE(obj);
>      PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>
> +    void *foo =3D IPMI_BMC(NULL);
> +    printf("foo =3D %p\n", foo);
> +
>  #ifdef CONFIG_VMPORT
>      pcms->vmport =3D ON_OFF_AUTO_AUTO;
>  #else
>
> This code runs on the pc machine startup and prints "foo =3D (nil)"
> without problems, even on a debug build (which enables
> CONFIG_QOM_CAST_DEBUG).
>
> Is the problem you saw really with the cast macro, and not with
> this function's explicit dereference of bmc in "bmc->intf" ?


You're right; it's with the "bmc->intf", I'll update the commit message.


