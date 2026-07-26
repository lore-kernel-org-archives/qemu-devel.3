Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A035C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 17:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo2u5-0004Sf-2U; Sun, 26 Jul 2026 13:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anderson@allelesecurity.com>)
 id 1wo2u3-0004S0-IO
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 13:44:43 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anderson@allelesecurity.com>)
 id 1wo2u1-0001fX-SX
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 13:44:43 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-5bfb5e20a90so1228937e0c.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 10:44:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785087880; cv=none;
 d=google.com; s=arc-20260327;
 b=TZ1dEUgooeKKj+VgLD9VcWhm38Mj8Gg4h0oMdrnsfYFP/0oqB/yTRKvB6RV12xhWZx
 e0FvT39SoIT51WZHPAyNo0vus0Z1A8Jz5MplJF4V/o6pQai7ZU1WCe924eFzZMm5B19H
 Ag4ygh76rA7jip84UuYh8cDX8oPf1ag14awGKKrhrUpAY+G39GiJoE1TUzCWgtE2AgB3
 UVeyep2FAEGkPTE0wg+U/6BG6rp0jM/6I69V1ia+5T0zKk0sCjDDCBt1xuv2hhbExtHS
 g3xCtoB9hUDy+jd7mQFC3tlz97kCcxsCp7Ld9nryjWFHeVrywSCDplPpO7Syos3T7H/D
 l+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lBazFeGPDjya1ziFJmG/VIjSjBZuYkaa8woZCk5IgWU=;
 fh=OOeWHJ/xqCQ/wRKDZ2GW2bb3k16C/567Xdpz2E+GssY=;
 b=deDwv8WKIXPoAtlzt82CZf2/3Z+AznPuMkJnzvxXttWfe/QnXez8f/ITVaMLrm/853
 axmmxAPanx6w8lhGkeRuSV6360c6McPuHQoVFrxfmTneKnQ8iAPc5EQjLtt53kzXPBG1
 VGPHo+JJOAxbedzYDCHqAhxSKWrq1LZTMn4mnqGiSNB2WQLfRiwKOVY/Pcsz4qBw8spD
 25x23CiOt4B7l6XSvHoGqGCfXlUmm0Ji02wkAqVyqN+uTMW5nfsb+COnJ4yYxM/LdIrP
 wDEAZaKGYwRymIiK4nfWzBFPXZEwB9JnMxXpM0EUpPsXHS6VR1NYmrKbwfyRZ2xPhtAx
 bhYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=allelesecurity.com; s=google; t=1785087880; x=1785692680; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lBazFeGPDjya1ziFJmG/VIjSjBZuYkaa8woZCk5IgWU=;
 b=eEpMs5rph6zd8WHDxuoY6kHAuDLhWgc2ICpIzbyC1SeEIGmC2jXnOjWTA29t1fM7LT
 A+tjmP0VOqJI6ut88Oa5wD1QVLLa0C4vL2s+eZF3nuEtjlejx40q8mnIb59Nfr53Zq5t
 lWmXw6ODLT4wXD1xkcFtkqGrUU3F2jGFejR2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785087880; x=1785692680;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lBazFeGPDjya1ziFJmG/VIjSjBZuYkaa8woZCk5IgWU=;
 b=Na8Hlup0hIdUpZ58Gx//ndqPXCWkF0TFGawp47MfsmTKJDQlFKmRw5+IJzilctGJRj
 /BjwwDEpvR18YacRZgMZhdJtO42YDi2+5Tvln0V47p3Zl5kDt5t2r0xSbHZ79m3/A6+0
 Hn7/A+HCCll0R2Z1bikWtq8L/8q7RGcrdOqgxM8X+5oc5V+SzRGLpmC3W0dT7oWa0X1c
 An5YPeGUtCR0GrsJuoR6tpulng3dYsUGoWwkRH92mgpX5tM/kENkSq/qFT8Oc79yb4do
 VhYfqcyUhjl7mvWM0Y4nc9+plijuy1qBo5gurEgdbvZGcrmOfitlAo9OZpD0LKUBSWST
 So7Q==
X-Gm-Message-State: AOJu0YyV++ncQtN4GkdbkcT7FXtehBqMLd57zSafS0o9KEYwQLzk5OOM
 n6X0qFM28u3R2rqff3j3Rg6nDvOxTG0kjGIV+mf1JaWZZQ/O1oXSUSyAUWMn2YWbXBGEhXocsng
 PHdoQOM2Oa/3JDH3SApm4bobCJ4t8UBUTXINl80tYPA==
X-Gm-Gg: AR+sD136TL4sxcqU5uw7QWzdDUXTMvtZ+vcFZnUlzcxycsLPqHHJLtszEJxhJtUxUkB
 /EA4NQD3zpTUShP009dwWAbwjJ+Yt+aXPcOurIQeugJYETMgy3XVuelaLloXwJfNXs+StuPt94+
 Jze7nYn5+DDsemimYvqjqHgvH6u2Z/LEqwGyNn95Tux1D7aienHUb021wot3tp6YcJN9LW54q7w
 DYKRKbXk+bnxv6EX9suOF8ZGfJvEJ/WcYC0O3QIN1kmTrUCmq5iRQHO3jMMpUNT
X-Received: by 2002:a05:6122:e146:b0:5c2:c0de:d291 with SMTP id
 71dfb90a1353d-5c306d29141mr2758869e0c.9.1785087880421; Sun, 26 Jul 2026
 10:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260602140348.774203-1-anderson@allelesecurity.com>
 <20260602140348.774203-2-anderson@allelesecurity.com>
 <amHVTvcDeQXdrIbg@intel.com>
In-Reply-To: <amHVTvcDeQXdrIbg@intel.com>
From: Anderson Nascimento <anderson@allelesecurity.com>
Date: Sun, 26 Jul 2026 14:44:29 -0300
X-Gm-Features: AUfX_mwEM1sAVwfqQ9KFEyeMfXQrvaiScXIYhW_fw1yntHE0S9k3iwwVP-VnFrA
Message-ID: <CAPhRvkze0VmWDZb2+w0ZiDvT6rzkb6j3+sZe_tUM3p1-DRrk0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/i386: Add support for KVM APERF/MPERF
 passthrough
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com, 
 mtosatti@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=anderson@allelesecurity.com; helo=mail-vk1-xa35.google.com
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

Hi Zhao,

On Thu, Jul 23, 2026 at 5:48=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> Hi Anderson,
>
> > +    [FEAT_6_ECX] =3D {
> > +        .type =3D CPUID_FEATURE_WORD,
> > +        .feat_names =3D {
> > +            "aperfmperf", NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +            NULL, NULL, NULL, NULL,
> > +        },
> > +        .cpuid =3D { .eax =3D 6, .reg =3D R_ECX, },
> > +        .tcg_features =3D 0,
> > +        .unmigratable_flags =3D CPUID_6_ECX_APERFMPERF,
>
> Considerring APER/MPERF passthrough have many specific restrictions
> (listed in KVM's api.rst, "7.13 KVM_CAP_X86_DISABLE_EXITS"), I think
> we also need not to enable it by default for max/host CPUs:
>
> .no_autoenable_flags =3D CPUID_6_ECX_APERFMPERF
>
> This indicates that users must manually enable this feature, and it is
> assumed that they are aware of its limitations and have implemented
> appropriate policies (such as no preemption, vCPU affinity, no idle or
> C state in the guest, etc.).
>

It makes sense! I didn't know that, thanks.

> > +    },
>
> ...
>
> >  /* CPUID[0x80000007].EDX flags: */
> >  #define CPUID_APM_INVTSC       (1U << 8)
> > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > index 9e352882c8..ca722ff9e9 100644
> > --- a/target/i386/kvm/kvm.c
> > +++ b/target/i386/kvm/kvm.c
> > @@ -498,6 +498,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, =
uint32_t function,
> >          }
> >      } else if (function =3D=3D 6 && reg =3D=3D R_EAX) {
> >          ret |=3D CPUID_6_EAX_ARAT; /* safe to allow because of emulate=
d APIC */
> > +    } else if (function =3D=3D 6 && reg =3D=3D R_ECX) {
> > +        ret |=3D CPUID_6_ECX_APERFMPERF;
>
> if we bind this feature to cpu-pm, then we should check enable_cpu_pm
> before setting CPUID. Otherwise, if this CPUID is present but
> cpu-pm=3Doff, Guest may try to access related MSRs and triggers #GP.
>
>         if (enable_cpu_pm) {
>             int disable_exits =3D kvm_check_extension(s,
>                                                     KVM_CAP_X86_DISABLE_E=
XITS);
>
>             if (disable_exits & KVM_X86_DISABLE_EXITS_APERFMPERF) {
>                 ret |=3D CPUID_6_ECX_APERFMPERF;
>             }
>         }
>
> But on the other hande, maybe we don't need to bind this feature to
> cpu-pm?
>
> For example, a compute-intensive workload doesn't allow the Guest to
> enter idle, then it still seems make sense to estimate performance
> using aperf and mperf?
>

I had put it under the cpu-pm option because it seemed like the
easiest step to enable that feature, as it already talks to KVM to do
a few pass-throughs (MWAIT, PAUSE, and so on). But re-checking this
now, I agree that the aperf/mperf feature doesn't have much to do with
the other cpu-pm options. I'll try a v3 with it as a standalone
feature as soon as possible. If there's anything else, please let me
know. Thanks again!

> Thanks,
> Zhao
>

--
Anderson Nascimento
Allele Security Intelligence
https://www.allelesecurity.com

