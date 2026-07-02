Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7450BC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHo2-0000aB-9d; Thu, 02 Jul 2026 09:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wfHo0-0000XG-9b
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:50:16 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wfHnw-0007UU-Gd
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:50:15 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4631679f204so398218f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783000210; x=1783605010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/8XFKB5atkpG7Un6eNnm5DXeYX3y6T++VbUUBe+nSc=;
 b=ia2VgzJey5InrT7UuBANXFN0rp3Gr3MWtUzw3xQ6rNwZ4C2Jq4Lc1knPvcGBl9ZktB
 Xft60dEU9KRYL557PvMHB++0zclpst1zudfmvGRpslRxYsJBK58zCSZgBaq6hLUZet+2
 4dj++TqLjOe4Wu8jxh64UQqSja6P+1JK+VYqCW7/Lyc5UXvml25ITBv0/RXadBvB7+Rq
 /2Qx37xtb6zB64u1DuNpPTBR1ASpPdkVJeVhEbMBV82RR67ijD30opC2ySAK6ooUPrRG
 LRvcsx8DQgDbrC0XmIozStxTNKPzOXtCr8lYW20BuEDOBtlvNKU+E0dRn3TVCEWErwLd
 jh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000210; x=1783605010;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O/8XFKB5atkpG7Un6eNnm5DXeYX3y6T++VbUUBe+nSc=;
 b=TMJ+/njpDzQU/fb47n962FhVcaEFLplcF1RZqkRYQHlxX2CVEbvsjAFQGUkEibfL/6
 cgIhDWOJ1kZ5+Z+eHU3ZFuwjHaspMJ046qpmX85gWXSolH+mopml4GtVK2DskLy7AdBU
 zWUT0wrNbXmrCFkzPDddHC/Vbn6YsdaM6NaaZXPSvoYPcXZtNxwP1G11+D7t4oevH5VO
 Nkt5d8xJwI9li0TlYJnvFjat8mumr6sHC8NOhNPS8LUyIKXBP5pYuzeDUODJ2+Zzf1Vm
 bWLlIIenSiL8J1LyppcxEwPJ9trNSpwo8e8PguYbPT0U41N6CYaU2RqV3DXPXsMLhQsK
 JiqA==
X-Gm-Message-State: AOJu0Yzr6haRzLJZUsj2nNOphyLk6A3HHVGIYuafsmwcbVpbMrdWixWk
 IhBmb+SgsYckPPe7HrQw3MmUWSv9sdIjqcbyRzEeA99h3Q43JkCC6yZ6z6CIdNxWKvo=
X-Gm-Gg: AfdE7cnOQFBAVInm8899e+19dngf8FW9mdKTKKt6WVrbq7hLFVLPOXGI2drNcuIhvV4
 vZhpz7t8jlNHG/EaHZ2rkT+Ahei8vj4GXlTTNY+xrY7R4wZAT2gTI4rPB3TWXD3Jg1/RnrI7cUT
 PyQcgsymZOlcgOsbWcCY+Xkk6MlOlmUh40A3VjZF4ukvGDuSq41phP4Vxf8jPZ11+NgkwL4diNX
 JH2+txq46KtC91TYHMGWLcUaUhNwC0cSPMN5fbH8Rb1xzWmNbJXMEs4KtR8E5JA+WxbMUnvbaaZ
 e1rbcFNJThDvxHsLTSQJNcW0q/NZK+gTIvvGxXVOgaca+7F7av8tae+Sq7xqMfiuB+ttXEpmMKr
 L0NDRrViO4miH/n8k9XDYhDzoZg+kCh8mqwq2S0IH5ofeZmUzFN6WGIud7myrZ1S4nAV+lamDOT
 WJl6dFKOoV/wyZ
X-Received: by 2002:a05:6000:2905:b0:475:f0c2:75ad with SMTP id
 ffacd0b85a97d-47746252564mr8816221f8f.24.1783000210386; 
 Thu, 02 Jul 2026 06:50:10 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477d766e0b4sm8678276f8f.0.2026.07.02.06.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:50:09 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4DFD55F89F;
 Thu, 02 Jul 2026 14:50:08 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  qemu-s390x@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Xiaoyao
 Li <xiaoyao.li@intel.com>,  Chao Liu <chao.liu.zevorn@gmail.com>,  Zhao
 Liu <zhao1.liu@intel.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  qemu-ppc@nongnu.org,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 10/33] accel: Change gdbstub_supported_sstep_flags() ->
 get_gdbstub_config()
In-Reply-To: <20260630220100.1289-11-philmd@oss.qualcomm.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 1 Jul 2026 00:00:37
 +0200")
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-11-philmd@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Thu, 02 Jul 2026 14:50:08 +0100
Message-ID: <87pl15sdpr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> In order to have accelerator return multiple gdbstub parameters,
> pass @supported_sstep_flags as argument instead of returning it.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  include/accel/accel-ops.h |  2 +-
>  include/qemu/accel.h      |  7 ++++---
>  accel/accel-common.c      |  9 +++++----
>  accel/hvf/hvf-all.c       |  6 +++---
>  accel/kvm/kvm-all.c       | 12 +++++++-----
>  accel/tcg/tcg-all.c       |  8 ++++----
>  gdbstub/gdbstub.c         |  2 +-
>  7 files changed, 25 insertions(+), 21 deletions(-)
>
> diff --git a/include/accel/accel-ops.h b/include/accel/accel-ops.h
> index f46492e3fe1..1bc359ff3e5 100644
> --- a/include/accel/accel-ops.h
> +++ b/include/accel/accel-ops.h
> @@ -37,7 +37,7 @@ struct AccelClass {
>                         hwaddr start_addr, hwaddr size);
>=20=20
>      /* gdbstub related hooks */
> -    int (*gdbstub_supported_sstep_flags)(AccelState *as);
> +    void (*get_gdbstub_config)(AccelState *as, int
>      *supported_sstep_flags);

Is there anything wrong with just returning a structure rather than each
individual config being passed by reference?

--8<---------------cut here---------------start------------->8---
modified   =EF=83=BD include/accel/accel-ops.h
@@ -15,6 +15,11 @@ struct AccelState {
     Object parent_obj;
 };
=20
+struct AccelGdbConfig {
+    int supported_sstep_flags;
+    bool can_reverse;
+};
+
 struct AccelClass {
     ObjectClass parent_class;
=20
@@ -38,8 +43,7 @@ struct AccelClass {
=20
     /* gdbstub related hooks */
     bool (*supports_guest_debug)(AccelState *as);
-    void (*get_gdbstub_config)(AccelState *as, int *supported_sstep_flags,
-                               bool *can_reverse);
+    struct AccelGdbConfig (*get_gdbstub_config)(AccelState *as);
=20
     bool *allowed;
--8<---------------cut here---------------end--------------->8---


>=20=20
>      bool *allowed;
>      /*
> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
> index d3638c7bfda..92f9c538f31 100644
> --- a/include/qemu/accel.h
> +++ b/include/qemu/accel.h
> @@ -74,11 +74,12 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **=
errp);
>  void accel_cpu_common_unrealize(CPUState *cpu);
>=20=20
>  /**
> - * accel_supported_gdbstub_sstep_flags:
> + * accel_get_gdbstub_config:
> + * @supported_sstep_flags: pointer to store the single step modes in
>   *
> - * Returns the supported single step modes for the configured
> + * Set the supported single step modes for the configured
>   * accelerator.
>   */
> -int accel_supported_gdbstub_sstep_flags(void);
> +void accel_get_gdbstub_config(int *supported_sstep_flags);
>=20=20
>  #endif /* QEMU_ACCEL_H */
> diff --git a/accel/accel-common.c b/accel/accel-common.c
> index 62590a7d9a6..526ab2a0cfb 100644
> --- a/accel/accel-common.c
> +++ b/accel/accel-common.c
> @@ -113,14 +113,15 @@ void accel_cpu_common_unrealize(CPUState *cpu)
>      }
>  }
>=20=20
> -int accel_supported_gdbstub_sstep_flags(void)
> +void accel_get_gdbstub_config(int *supported_sstep_flags)
>  {
>      AccelState *accel =3D current_accel();
>      AccelClass *acc =3D ACCEL_GET_CLASS(accel);
> -    if (acc->gdbstub_supported_sstep_flags) {
> -        return acc->gdbstub_supported_sstep_flags(accel);
> +    if (acc->get_gdbstub_config) {
> +        acc->get_gdbstub_config(accel, supported_sstep_flags);
> +    } else {
> +        *supported_sstep_flags =3D 0;
>      }
> -    return 0;
>  }
>=20=20
>  static const TypeInfo accel_types[] =3D {
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index 21b9b71a6df..284ce8ebff1 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -228,9 +228,9 @@ static int hvf_accel_init(AccelState *as, MachineStat=
e *ms)
>      return hvf_arch_init();
>  }
>=20=20
> -static int hvf_gdbstub_sstep_flags(AccelState *as)
> +static void hvf_gdbstub_config(AccelState *as, int *supported_sstep_flag=
s)
>  {
> -    return SSTEP_ENABLE | SSTEP_NOIRQ;
> +    *supported_sstep_flags =3D SSTEP_ENABLE | SSTEP_NOIRQ;
>  }
>=20=20
>  static void hvf_set_kernel_irqchip(Object *obj, Visitor *v,
> @@ -278,7 +278,7 @@ static void hvf_accel_class_init(ObjectClass *oc, con=
st void *data)
>      ac->name =3D "HVF";
>      ac->init_machine =3D hvf_accel_init;
>      ac->allowed =3D &hvf_allowed;
> -    ac->gdbstub_supported_sstep_flags =3D hvf_gdbstub_sstep_flags;
> +    ac->get_gdbstub_config =3D hvf_gdbstub_config;
>      hvf_kernel_irqchip_override =3D false;
>      hvf_kernel_irqchip =3D false;
>      object_class_property_add(oc, "kernel-irqchip", "on|off|split",
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 6cd5f95d06e..72d6eb464db 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -4281,14 +4281,16 @@ static void kvm_accel_instance_init(Object *obj)
>  }
>=20=20
>  /**
> - * kvm_gdbstub_sstep_flags():
> + * kvm_gdbstub_config():
>   *
> - * Returns: SSTEP_* flags that KVM supports for guest debug. The
> + * Set SSTEP_* flags that KVM supports for guest debug. The
>   * support is probed during kvm_init()
>   */
> -static int kvm_gdbstub_sstep_flags(AccelState *as)
> +static void kvm_gdbstub_config(AccelState *as, int *supported_sstep_flag=
s)
>  {
> -    return kvm_sstep_flags;
> +    KVMState *s =3D KVM_STATE(as);
> +
> +    *supported_sstep_flags =3D s->gdbstub_sstep_flags;
>  }
>=20=20
>  static void kvm_accel_class_init(ObjectClass *oc, const void *data)
> @@ -4299,7 +4301,7 @@ static void kvm_accel_class_init(ObjectClass *oc, c=
onst void *data)
>      ac->rebuild_guest =3D kvm_reset_vmfd;
>      ac->has_memory =3D kvm_accel_has_memory;
>      ac->allowed =3D &kvm_allowed;
> -    ac->gdbstub_supported_sstep_flags =3D kvm_gdbstub_sstep_flags;
> +    ac->get_gdbstub_config =3D kvm_gdbstub_config;
>=20=20
>      object_class_property_add(oc, "kernel-irqchip", "on|off|split",
>          NULL, kvm_set_kernel_irqchip,
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 8eb4a6b89e8..89f7e025021 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -242,7 +242,7 @@ static void tcg_set_one_insn_per_tb(Object *obj, bool=
 value, Error **errp)
>      qatomic_set(&one_insn_per_tb, value);
>  }
>=20=20
> -static int tcg_gdbstub_supported_sstep_flags(AccelState *as)
> +static void tcg_gdbstub_config(AccelState *as, int *supported_sstep_flag=
s)
>  {
>      /*
>       * In replay mode all events will come from the log and can't be
> @@ -251,9 +251,9 @@ static int tcg_gdbstub_supported_sstep_flags(AccelSta=
te *as)
>       * them occurring every time we single step.
>       */
>      if (replay_mode !=3D REPLAY_MODE_NONE) {
> -        return SSTEP_ENABLE;
> +        *supported_sstep_flags =3D SSTEP_ENABLE;
>      } else {
> -        return SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
> +        *supported_sstep_flags =3D SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NO=
TIMER;
>      }
>  }
>=20=20
> @@ -266,7 +266,7 @@ static void tcg_accel_class_init(ObjectClass *oc, con=
st void *data)
>      ac->cpu_common_unrealize =3D tcg_exec_unrealizefn;
>      ac->get_stats =3D tcg_get_stats;
>      ac->allowed =3D &tcg_allowed;
> -    ac->gdbstub_supported_sstep_flags =3D tcg_gdbstub_supported_sstep_fl=
ags;
> +    ac->get_gdbstub_config =3D tcg_gdbstub_config;
>=20=20
>      object_class_property_add_str(oc, "thread",
>                                    tcg_get_thread,
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index f54415a9db7..1e0a6638bff 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -72,7 +72,7 @@ void gdb_init_gdbserver_state(void)
>       * By default try to use no IRQs and no timers while single
>       * stepping so as to make single stepping like a typical ICE HW step.
>       */
> -    gdbserver_state.supported_sstep_flags =3D accel_supported_gdbstub_ss=
tep_flags();
> +    accel_get_gdbstub_config(&gdbserver_state.supported_sstep_flags);
>      gdbserver_state.sstep_flags =3D SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_N=
OTIMER;
>      gdbserver_state.sstep_flags &=3D gdbserver_state.supported_sstep_fla=
gs;
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

