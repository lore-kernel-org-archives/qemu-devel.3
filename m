Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976B5C5B574
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wthM3-0000S5-1p; Tue, 11 Aug 2026 03:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wthLy-0000Ri-J6
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 03:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wthLw-0002Q7-Kc
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 03:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786435011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9R+nnmJErbI9pZf8mubgUFj4Cr7CpLaVqqub9Aq0/g=;
 b=CYPn4afJg1BKwaQk+VO91KETSD7xvy+lbiE0l3Cb2mHnC+CDMA/skiuLysM14Jn3YCkpjB
 Wd9KqFL+3EBoDg730s4DevXFZxYYs/xvGAlxzAcSVlIwHVGQMZuZU+2WMF5MekQgVIzxnF
 C053rwMrTmOKzylzglSdESrju3rkiOQ=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-5qESs2HqNfqSacESNDAxWw-1; Tue, 11 Aug 2026 03:56:49 -0400
X-MC-Unique: 5qESs2HqNfqSacESNDAxWw-1
X-Mimecast-MFC-AGG-ID: 5qESs2HqNfqSacESNDAxWw_1786435009
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c860544c077so6152442a12.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 00:56:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786435009; cv=none;
 d=google.com; s=arc-20260327;
 b=Td9NlN8+KX6Hox94ltR9qssm8cMIrN/TcFZ4P73wUpSeDfBVIVTLZGLm8P7anbfJ7x
 4ajV1oRfyRuCmA8c56i+UP03pFYhXSXIRMtzcDmKVkiC3IztrWcfhzhWLXei9uMVyqtM
 5CkHZMzU0xcv+B86CuksuYVpKYCjtBjMWslWc6jvisA6sEMOBQfQcnFjucOf2SnhPVFd
 uTqkzUZpHb73TByZzM9eAasdmmw0fiYRLAQ27akmkRzWoSPWFY6L4Z7MNfeDnKBFkn/m
 5JOSorgQujMPPR/pZnaiz1xZiTMyZrMd2wBMFe13YBUiGOlMXMKjTazqw3/p65OHPH9w
 WbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L9R+nnmJErbI9pZf8mubgUFj4Cr7CpLaVqqub9Aq0/g=;
 fh=clj/N3aH4K/xfvVAs99VTHE3zWNs21ViYr0khAbs26E=;
 b=Ix943iIvs8Z9YCL7PKXs/3ptnXdePw+Vbslh8NzSsctqTsXLN4GTMU7qZ7m9Jd79W3
 JnnYNtDtdjoEzVb5PDoAoM3fhwQcWfzCu4z+R4uPVA/yOw5wWMpHh55r4TIKnjtVu+Im
 13FVzxpNS8AWr8abTgassGx84F4cFz6SwB5Yb7STbGD3rLbI1Dd3T1jT7DYE1DpLA5Ik
 Gj61A/HNa7f0VdMMzraY/4Gk/RXjaXDE1BKmsEQiEKa26lXTeKMUr4PM8h1yndS5hl2e
 vNwxQIGEhB9vsYSPUfmyFPcnvVQgkq0ESCFX8vXzur9to9r8m5px136wRilB/h4LoL3B
 UfjQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786435009; x=1787039809; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L9R+nnmJErbI9pZf8mubgUFj4Cr7CpLaVqqub9Aq0/g=;
 b=q1G3PQ4r1ebXE6MW+d5ZCiYQqWxNoYOEaFKE3KUoyW57aNWEzcCUGGEmzWUYpv9JS7
 SUiX+2nMglErJ46qmh5mET0uJ6lZewte3HLXo1RpMZ330uZ41d+56Q7A4U2YIogUByMe
 kNCsHAQa2/dVx/IlPuLYBnocLdz10am9PjGgTTSnvQ2Jnqhn/1nJRYRZdfLpMAhwtMPR
 +YV2LXhk3XkLAzLFk2MrJRzW6BVnuRqfZhc+YUiXR7jCG13t3D3w6Alxo9oXbsuiGXIK
 oONCFgPk2fmHZNnfFSmKteAH6ys5ylIPH+W/UQfOPUThvIVtapNHBfZNGGmEHptrON8J
 jGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786435009; x=1787039809;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L9R+nnmJErbI9pZf8mubgUFj4Cr7CpLaVqqub9Aq0/g=;
 b=Wuk9R2wLfF+Jgwj7SrxGnAnX3oG1igPZuVFuty/moChtv/R9rlIoyxw7f3OjXx9zmc
 AhppXXh6pgoxuYIvwOiiPSPj+N1/qiiEhDBhJp9FenZjP26PVo1fAbHcbfAFQ2kwFLVr
 TQAFqpQ5i/JRGvcSbYI7GsiSNj1ChMpNCbf5eOqkbS+PrQFp8TJRBG0yYjSGJSpP2UOf
 +SUVe/NToDTKbNjEoxz8zPZgpEO9xqTwsVAgcCe57+APsih+nCU3X27jLZWaSqcuHcRy
 Gp0RuI+PZ9iqhZA0iYP2TNt3uX/KutbHitx2PuqQsXP9V0ACy/+kDpYzGqHTHk9UHjxN
 euTQ==
X-Gm-Message-State: AOJu0YxDKbdiuMNh0mchR/0p6wLi1Aj4K+d8oj9Iws8lyP4fsySElpTB
 /y4Ai1VgP1IJgCwg0DAJc7hetRguL563yDjLoufaD0J7GgTt9gtay9IeD1eHmo1NS2S2vabXZgi
 85MddWlORIIyq8HzKfRkBQIAWSohpZtb6tDt7uAtruX6f6mf/nralKcLdE86uys7fqijn3Y68uC
 iCLKTGJdseHvNhtDTu3oGI0tk7VsDduKM=
X-Gm-Gg: AR+sD139ltUHZs09k/X93ENoF5KZsJih9w3KjnPximUYBgbtXe48Rsg6W/KvScVHwRg
 96DI4YYowg/DGJbooDJVaxlaD513sc8H9b9HyrQIEXnqsi/OgsCqB4sHCVIOxTpMvUaGekzUA7m
 iUC/xQa0pa6UZgIcCneI5i7ZCrIwJJdW9uCejlURflQSO3JQEMa634/EK/tSgDfbGuuMKGt6WFd
 AuqFiJ40m1AuhIvAcJbHBoSfUo9Ztp1DuE0c1jHh8meYVuHcUmy/G/8xM6nhFGfCOpaVnqKBsJE
 sg==
X-Received: by 2002:a05:6a21:3a43:b0:3c8:e10b:7a9b with SMTP id
 adf61e73a8af0-3cc2b8e1eb5mr2365339637.16.1786435008709; 
 Tue, 11 Aug 2026 00:56:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:3a43:b0:3c8:e10b:7a9b with SMTP id
 adf61e73a8af0-3cc2b8e1eb5mr2365282637.16.1786435008066; Tue, 11 Aug 2026
 00:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <20260626-qemu-no-hmp-v2-4-8af31bc54c61@redhat.com>
 <anoM-GDPeNTNfFR_@redhat.com>
In-Reply-To: <anoM-GDPeNTNfFR_@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 11 Aug 2026 11:56:35 +0400
X-Gm-Features: AUfX_mwFzf08-gkLbJKbRBQjYShy8VJfVU6jAr0lx9E9rBeCo45cJmziQaTyNjo
Message-ID: <CAMxuvaxjP7trxak3-NMdbW5koGKtY0gsqVL403PJoLSnb16xNA@mail.gmail.com>
Subject: Re: [PATCH v2 04/39] target/i386: decouple cpu_x86_inject_mce() from
 Monitor
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Aug 10, 2026 at 9:40=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Fri, Jun 26, 2026 at 01:19:05AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Replace monitor_printf() error reporting with the standard **errp
> > pattern. Drop the Monitor *mon parameter and return bool to indicate
> > success, improving the function usage from non-HMP contexts. Update the
> > KVM MCE injection path and hmp_mce() accordingly.
> >
> > Notes:
> >  - we may want to print the error in KVM path too
> >  - multiple error prints are now accumulated with error hints
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  target/i386/cpu.h     |  4 ++--
> >  target/i386/helper.c  | 49 ++++++++++++++++++++++++++++---------------=
------
> >  target/i386/kvm/kvm.c |  4 ++--
> >  target/i386/monitor.c |  6 ++++--
> >  4 files changed, 36 insertions(+), 27 deletions(-)
>
>
> >  typedef struct MCEInjectionParams {
> > -    Monitor *mon;
> > +    GString *err;
>
> Why not have "Error **errp"
>
> >      int bank;
> >      uint64_t status;
> >      uint64_t mcg_status;
> > @@ -428,9 +428,9 @@ static void do_inject_x86_mce(CPUState *cs, run_on_=
cpu_data data)
> >           * reporting is disabled
> >           */
> >          if ((cenv->mcg_cap & MCG_CTL_P) && cenv->mcg_ctl !=3D ~(uint64=
_t)0) {
> > -            monitor_printf(params->mon,
> > -                           "CPU %d: Uncorrected error reporting disabl=
ed\n",
> > -                           cs->cpu_index);
> > +            g_string_append_printf(params->err,
> > +                "CPU %d: Uncorrected error reporting disabled\n",
> > +                cs->cpu_index);
>
> and use  error_setg here and the other two places below.
>
> >              return;
> >          }
> >
> > @@ -439,10 +439,9 @@ static void do_inject_x86_mce(CPUState *cs, run_on=
_cpu_data data)
> >           * reporting is disabled for the bank
> >           */
> >          if (banks[0] !=3D ~(uint64_t)0) {
> > -            monitor_printf(params->mon,
> > -                           "CPU %d: Uncorrected error reporting disabl=
ed for"
> > -                           " bank %d\n",
> > -                           cs->cpu_index, params->bank);
> > +            g_string_append_printf(params->err,
> > +                "CPU %d: Uncorrected error reporting disabled for bank=
 %d\n",
> > +                cs->cpu_index, params->bank);
> >              return;
> >          }
> >
> > @@ -459,7 +458,7 @@ static void do_inject_x86_mce(CPUState *cs, run_on_=
cpu_data data)
> >          if (need_reset) {
> >              emit_guest_memory_failure(MEMORY_FAILURE_ACTION_RESET, ar,
> >                                        recursive);
> > -            monitor_printf(params->mon, "%s", msg);
> > +            g_string_append_printf(params->err, "%s\n", msg);
> >              qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
> >              qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
> >              return;
> > @@ -488,14 +487,16 @@ static void do_inject_x86_mce(CPUState *cs, run_o=
n_cpu_data data)
> >      emit_guest_memory_failure(MEMORY_FAILURE_ACTION_INJECT, ar, recurs=
ive);
> >  }
> >
> > -void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
> > +bool cpu_x86_inject_mce(X86CPU *cpu, int bank,
> >                          uint64_t status, uint64_t mcg_status, uint64_t=
 addr,
> > -                        uint64_t misc, int flags)
> > +                        uint64_t misc, int flags, Error **errp)
> >  {
> > +    ERRP_GUARD();
> >      CPUState *cs =3D CPU(cpu);
> >      CPUX86State *cenv =3D &cpu->env;
> > +    g_autoptr(GString) err =3D g_string_new(NULL);
> >      MCEInjectionParams params =3D {
> > -        .mon =3D mon,
> > +        .err =3D err,
>
> This indirection via GString feels overkill when we could
> use directly pass 'errp', given the ERRP_GUARD we have
>
> >          .bank =3D bank,
> >          .status =3D status,
> >          .mcg_status =3D mcg_status,
> > @@ -506,21 +507,21 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu=
, int bank,
> >      unsigned bank_num =3D cenv->mcg_cap & 0xff;
> >
> >      if (!cenv->mcg_cap) {
> > -        monitor_printf(mon, "MCE injection not supported\n");
> > -        return;
> > +        error_setg(errp, "MCE injection not supported");
> > +        return false;
> >      }
> >      if (bank >=3D bank_num) {
> > -        monitor_printf(mon, "Invalid MCE bank number\n");
> > -        return;
> > +        error_setg(errp, "Invalid MCE bank number");
> > +        return false;
> >      }
> >      if (!(status & MCI_STATUS_VAL)) {
> > -        monitor_printf(mon, "Invalid MCE status code\n");
> > -        return;
> > +        error_setg(errp, "Invalid MCE status code");
> > +        return false;
> >      }
> >      if ((flags & MCE_INJECT_BROADCAST)
> >          && !cpu_x86_support_mca_broadcast(cenv)) {
> > -        monitor_printf(mon, "Guest CPU does not support MCA broadcast\=
n");
> > -        return;
> > +        error_setg(errp, "Guest CPU does not support MCA broadcast");
> > +        return false;
> >      }
> >
> >      run_on_cpu(cs, do_inject_x86_mce, RUN_ON_CPU_HOST_PTR(&params));
> > @@ -539,6 +540,12 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu,=
 int bank,
> >              run_on_cpu(other_cs, do_inject_x86_mce, RUN_ON_CPU_HOST_PT=
R(&params));
> >          }
> >      }
> > +    if (params.err->len) {
> > +        error_setg(errp, "Failed to inject MCE");
> > +        error_append_hint(errp, "%s", params.err->str);
> > +        return false;
> > +    }
>
> This could be just
>
>   if (*params.errp) {
>      return false;
>   }
>

Good ideas, I'll do those changes

> > +    return true;
> >  }
> >
> >  static inline target_ulong get_memio_eip(CPUX86State *env)
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


