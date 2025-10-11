Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132C9CCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 12:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7ZAY-0000d1-CL; Sat, 11 Oct 2025 08:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhuyifei1999@gmail.com>)
 id 1v7ULO-0003pR-Dv
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 03:48:46 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhuyifei1999@gmail.com>)
 id 1v7ULI-0000fg-Ri
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 03:48:46 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-789fb76b466so2553594b3a.0
 for <qemu-devel@nongnu.org>; Sat, 11 Oct 2025 00:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760168916; x=1760773716; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLcttQgu6JlmRoKzeI9W/ReoKRymj15fhIh7JObSZKk=;
 b=XPbzGROMfQwPFmvQnmi7cm52Wmg/c1SkrJRL3f+U6N2NdqlLONg2+ZFZWikdt/E3U3
 VditrpEuEugCzXWdcfk3+ck7ncZ3t5tC9kuSvhkqxIPrCRernRcDFnI327W9FmM7MdCl
 7Adql9kavvhFnnTBQI0qCkowYvT7HN8kAo4iIqKJ4kQpr2jQ/lyHP2mvLuN7gt4dbkST
 dn5v7FM9Zi6zHB6CdWJvPCzRtXCPsct6BoGu/gnhsaSZ+mP27b5EsRZfQehgPTRcLzY4
 +qUVu7PV4M2rhtmvsZtsXtehjTmtBCTvrf3t2nJ+QI3todDlJU3i1vNFlli46fMTtDkk
 ILPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760168916; x=1760773716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KLcttQgu6JlmRoKzeI9W/ReoKRymj15fhIh7JObSZKk=;
 b=lEY3VpxneuhYRKygm849kkqZdbnJTw7CKykSYKQi0r4SvCl4RFgmOpIOlL6eF7GoAl
 DXz5YAJqX1FnGDg6D/gpuIPlpPkstKIIhfF91AWu0F7KzyS/xI7tso7Ppv2oIguXXsOR
 wyK0A2f4LHY17R5xXc2lCemgoHEuny/wl+qcYjUUv2Sal6ykv8Iwt7WVyBoLXNfCm1/x
 4lp4Q5ndFkCA6zuwmdxBJHmP3bTP6wrHEhH17voVYJlJblfk6DNxofJm9YKXWmGHaBhu
 9zoGV6emK1Dx8P5n8Lu9XRilqzktxGEOxAFNSNZjyQwH+C0YZUeK3Lv3jBvEQD3HQg2P
 Q04Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuQv5BrAUrKgm1OSHDfhdpiOSiFci0IC4hbDVDXV98FAVHcZxBTbdC9Lq3u5nLlkqnCpqHs/mtqaLu@nongnu.org
X-Gm-Message-State: AOJu0YzGzEnf/DvDWPFuz+7pOVVpMztxmAm35SPYJiRBSC6Y/S5D8OS1
 2JM3Y8isWOg/5134pYJjU/8y6GqLRLITDvo3D43N9mWDjMKI3DUq5oCr7o/Vu1JLjeLBtnR+9z4
 7ysWKrGan0VQTXSRVRaSgav5Yb5Og2lk=
X-Gm-Gg: ASbGnctb5ua8spTiYl08nY2M0zbU1x86+CvG54daKGDdFDaC3nPjrD0vwPSirDB2dzB
 oosPwaEUfOXWdfdmGD8QMWen3khtsxMF1dLdIsh6ZVKinoB3bn8qKYiKHS+qz28BWzSyHy1e3Ue
 SK9NUU2EIYWagQrPc6cdOzilQgGorBvaoZ4mWY4Ek6xkPv3r+uL0BqzrSBgNfMnJDr1GLDFNtzW
 OlV7v6WQlLg4SH84JuwunC8A+hcNZsTqH0FVA==
X-Google-Smtp-Source: AGHT+IHCsGHPzLb4137hgW6Of85mZSwOHO2NIgEpeV0MuZKNf7xkoXf0IWt7F6YmjVr2wVaH4g/2sYQvyvRh9rUE7tY=
X-Received: by 2002:a17:902:d584:b0:269:6e73:b90a with SMTP id
 d9443c01a7336-290272aeebemr190858405ad.15.1760168915916; Sat, 11 Oct 2025
 00:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1758794468.git.zhuyifei@google.com>
 <ca9b26db036fe39ffcb2ebbf7b8629b08632b8c2.1758794468.git.zhuyifei@google.com>
 <2f1ab909-d220-495e-bb14-c231a0e0bb49@redhat.com>
In-Reply-To: <2f1ab909-d220-495e-bb14-c231a0e0bb49@redhat.com>
From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Sat, 11 Oct 2025 00:48:24 -0700
X-Gm-Features: AS18NWC-jDwSYCFCC_Nncr3ul7HYDTH85_OGwz3fQNCVl0oxXBsR42iVqwMLlsU
Message-ID: <CABqSeARzRVbz5SGfgh-EtpKaWgR0LxR-b7wQ=9YBDaAOHKXAMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] i386/cpu: Prevent delivering SIPI during SMM in TCG
 mode
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: YiFei Zhu <zhuyifei@google.com>, qemu-devel@nongnu.org, 
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-stable@nongnu.org,
 unvariant.winter@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=zhuyifei1999@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 11 Oct 2025 08:57:52 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Oct 11, 2025 at 12:19=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> On 9/25/25 12:30, YiFei Zhu wrote:
> > A malicious kernel may control the instruction pointer in SMM in a
> > multi-processor VM by sending a sequence of IPIs via APIC:
> >
> > CPU0                  CPU1
> > IPI(CPU1, MODE_INIT)
> >                       x86_cpu_exec_reset()
> >                       apic_init_reset()
> >                       s->wait_for_sipi =3D true
> > IPI(CPU1, MODE_SMI)
> >                       do_smm_enter()
> >                       env->hflags |=3D HF_SMM_MASK;
> > IPI(CPU1, MODE_STARTUP, vector)
> >                       do_cpu_sipi()
> >                       apic_sipi()
> >                       /* s->wait_for_sipi check passes */
> >                       cpu_x86_load_seg_cache_sipi(vector)
> >
> > A different sequence, SMI INIT SIPI, is also buggy in TCG because
> > INIT is not blocked or latched during SMM. However, it is not
> > vulnerable to an instruction pointer control in the same way because
> > x86_cpu_exec_reset clears env->hflags, exiting SMM.
>
> Thanks for the reports!  For this bug, I prefer to have the CPU eat the
> SIPI instead of latching them:

SGTM

> diff --git a/hw/intc/apic.c b/hw/intc/apic.c
> index 6d7859640c2..c7680338563 100644
> --- a/hw/intc/apic.c
> +++ b/hw/intc/apic.c
> @@ -646,8 +646,6 @@ void apic_sipi(DeviceState *dev)
>   {
>       APICCommonState *s =3D APIC(dev);
>
> -    cpu_reset_interrupt(CPU(s->cpu), CPU_INTERRUPT_SIPI);
> -
>       if (!s->wait_for_sipi)
>           return;
>       cpu_x86_load_seg_cache_sipi(s->cpu, s->sipi_vector);
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index 651041ccfa6..a96834c4457 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -621,6 +621,9 @@ void do_cpu_init(X86CPU *cpu)
>
>   void do_cpu_sipi(X86CPU *cpu)
>   {
> +    if (env->hflags & HF_SMM_MASK) {
> +        return;
> +    }
>       apic_sipi(cpu->apic_state);
>   }
>
> diff --git a/target/i386/tcg/system/seg_helper.c
> b/target/i386/tcg/system/seg_helper.c
> index 38072e51d72..8c7856be81e 100644
> --- a/target/i386/tcg/system/seg_helper.c
> +++ b/target/i386/tcg/system/seg_helper.c
> @@ -182,6 +182,7 @@ bool x86_cpu_exec_interrupt(
>           apic_poll_irq(cpu->apic_state);
>           break;
>       case CPU_INTERRUPT_SIPI:
> +        cpu_reset_interrupt(cs, CPU_INTERRUPT_SIPI);
>           do_cpu_sipi(cpu);
>           break;
>       case CPU_INTERRUPT_SMI:
>
>
> Fixing INIT is harder, because it requires splitting CPU_INTERRUPT_INIT
> and CPU_INTERRUPT_RESET, but I'll take a look.

Thanks! And yeah that's the main reason why I didn't attempt to fix
INIT. It seems a lot more complex for something that seems a lot less
exploitable to me.

YiFei Zhu

> Paolo
>
> > Fixes: a9bad65d2c1f ("target-i386: wake up processors that receive an S=
MI")
> > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > ---
> >   target/i386/cpu.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 6d85149e6e..697cc4e63b 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -9762,7 +9762,8 @@ int x86_cpu_pending_interrupt(CPUState *cs, int i=
nterrupt_request)
> >       if (interrupt_request & CPU_INTERRUPT_POLL) {
> >           return CPU_INTERRUPT_POLL;
> >       }
> > -    if (interrupt_request & CPU_INTERRUPT_SIPI) {
> > +    if ((interrupt_request & CPU_INTERRUPT_SIPI) &&
> > +        !(env->hflags & HF_SMM_MASK)) {
> >           return CPU_INTERRUPT_SIPI;
> >       }
> >
>
>

