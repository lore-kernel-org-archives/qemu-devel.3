Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03644111224A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 00:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w86DE-0001wy-AD; Wed, 01 Apr 2026 20:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w86Cf-0001dZ-C4
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 20:46:40 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w86Ca-0002OT-AG
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 20:46:31 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-66dd27d4465so695588a12.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 17:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775090787; cv=none;
 d=google.com; s=arc-20240605;
 b=UQb/A194Hz83ITi35da94skuZM5tW/xkYmrpB/mmgWwLdH5JqarHLEKw2ri4CZ9mou
 epsD7desd4HduhLaFeZMDpoStR2DXx0w+y7JBSOhdwnfcbpAdJ3+Ab25TACDSBfGLS4J
 SuItxvWeHM8m8hxukcymsP0uWmWAG5YkCFTZUjVTQvNq8du2Afexsx1OYbpfhlq6bmzq
 /oIM8aen8aSYdJVthXU1AssMWf0gw8VfyWJEq8I8oJMpXk1fSh/dOfzThiZl3Ha33Upo
 E+xADOXBTPLd8LsShPHupckw3npnl6H5yv3dB2LaxO086LkJ1111iiQ5APSsv2bHmnIC
 uHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w7ZjIP4wxwkHbCGk+xqfZg9Y+KuPrsg39riRIKt2IvY=;
 fh=3pe5Mh1z3Fra4qA4Id4JnrrXRQUGebEqwUNjROC+Yjg=;
 b=AsVw0LS/WFUUwxoi9Gd3oAgNbNXjENioOYr6ZF2Ks9P0Ptx9rlCDsEmv9P0l97DuSW
 0vW8dS4ZM2+SA3G88sKU2ybkVa96pfqufTuPB8b+ItiYfg5uDunX0ZqJr2IQyqLYcWUF
 Pqu+Qz5R4IdkjQdEDGtQiuFsB2OahSK2PJqggnabijV4NU+jzvW88KFjRLRZjmdNViXv
 6pr1PCSDOs7naUM07DktDEvdniRIF0eyc6eGHxnxOxD5jv7+in/X50WpPMRdIbOLtE50
 lDgxeOLUBw+xG7VlkVj8R4nO8KwYNHMMmKazQdtpWrrS9ci4RbSGD2VGgJKHz0XxH6HX
 +54Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775090787; x=1775695587; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7ZjIP4wxwkHbCGk+xqfZg9Y+KuPrsg39riRIKt2IvY=;
 b=EaEhwuj7kaC7KQjPATkWD4EqJ5AT8tgziTQJO/aZnmnZ9iVOBLiRd78uHypfAJ6dnX
 JESvVwtDOn2EA5rdWE4PyhiOIoP5KyLhJMhRkq9H3myunvVAZp6e5nL9KFGKlERPme5R
 AfCOpcqa+IsIg4lW8mtRV+zhByEIiO6IKzI59VNn9ZHvei5Yy923EkKqRwNRvTppgDtd
 BmrZC+a+5Si/O+3JCbAfAaHWVHUkpMWbC3fPa44oDeXZbHopD9IIf3DHJ4NruUNM3yV+
 wPHCgLXeF2C0jOgJuZvO117v8ncpcqyJytlENRVzaeelmq5xnYxTybTYtLHMAjckOouI
 oZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775090787; x=1775695587;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w7ZjIP4wxwkHbCGk+xqfZg9Y+KuPrsg39riRIKt2IvY=;
 b=NRk29kHnrRTStt32OEbmglvFq8ADc3jy494iLF9ldw/I1ff3HOVJW1W41zxoqsCoIR
 RdjO4VGDrMIWIh9/nu0EplG/XCO6uwDuyWw+YYsri27hE3CFH0tZDFRJI20MpVOhACEm
 vlZyNsoAH9wDXqDy0XDp5SfS6fQnxkEu4ecsM+HUxA1IC60D14snfl+r6U7oUWCdDrCM
 xJ/11W2TYued2Gt7um+oYDrISgp8aWge/6TJ6b9X/AyDN+BSjo1qLF97+Qd8UWuxSUfC
 fd+raiK0iOjUBxnCuuOdD0UpTWDOlDnYLGhkeG86Ipd7ljwI0jbrNXvuDla6vZ1PA2G/
 VNZA==
X-Gm-Message-State: AOJu0YyFUuwnOdwVSR1BuqPY4lfRpvYgas4pZTedQgTMOxvBeqrc76OC
 UuWJGQAD9OXxqUUjiWIrhpRzJ/b8vko+AAkLexbAm1KuD16ArPUWmFBPqW6cIGjVi+33flCVw0S
 iBR6mJaf5XamAq++cKLR7+W3BjHKvXCM=
X-Gm-Gg: ATEYQzxMxmYvBZ+8kGCDaxGYL5xwDhq31zm3vJrMtRLpxB+zzoNtTV+r/kr24VtgkyH
 eQP9+eEYuxnnz+32f+7E09qdiTBzv5o6D05jHyGRwvo6PSVby05j+H4l4VuZwwDCfbxJ+VCKv84
 tk/DAGa3R3JYIv1qGqQs0vyM9rn9Hu0p4dY/t2X/DlR37xbTJN4dOg12jZZG25XoFYQgc0t+emk
 RbWlphRpCB2bOJxInja+tvn2n+34GDK7zNTSsz28OszO+OcYMKNEL6NiiD7qF8Q1folRrg55LBe
 sza5VLvELJ5EP9siFxrj1rjRkE3tgXK0Xd1bGQ==
X-Received: by 2002:a17:907:a604:b0:b93:6ae4:aa83 with SMTP id
 a640c23a62f3a-b9c138e7d94mr384586866b.18.1775090786132; Wed, 01 Apr 2026
 17:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260401201753.92290-1-philmd@linaro.org>
 <20260401201753.92290-3-philmd@linaro.org>
In-Reply-To: <20260401201753.92290-3-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Apr 2026 10:45:59 +1000
X-Gm-Features: AQROBzCwwUU-hZsY0U89IfFUHeLh_to88ntKSLA14V2dIF2bIKjclWYrKDf2AmQ
Message-ID: <CAKmqyKM5vdETfiQB6Ls+s4MbudKJjAR9b7t7VUszdS0e6kE0YA@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 2/8] accel/kvm: Remove TARGET_KVM_HAVE_GUEST_DEBUG
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-riscv@nongnu.org, 
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Anton Johansson <anjo@rev.ng>, 
 Song Gao <gaosong@loongson.cn>, Weiwei Li <liwei1518@gmail.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Bibo Mao <maobibo@loongson.cn>,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, 
 Zhao Liu <zhao1.liu@intel.com>, Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Apr 2, 2026 at 6:18=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> All targets except MIPS have TARGET_KVM_HAVE_GUEST_DEBUG=3Dy.
> Declare the kvm_update_guest_debug() stub to MIPS and have
> TARGET_KVM_HAVE_GUEST_DEBUG be the default.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  configs/targets/aarch64-softmmu.mak     |  1 -
>  configs/targets/i386-softmmu.mak        |  1 -
>  configs/targets/loongarch64-softmmu.mak |  1 -
>  configs/targets/ppc-softmmu.mak         |  1 -
>  configs/targets/ppc64-softmmu.mak       |  1 -
>  configs/targets/riscv64-softmmu.mak     |  1 -
>  configs/targets/s390x-softmmu.mak       |  1 -
>  configs/targets/x86_64-softmmu.mak      |  1 -
>  include/system/kvm.h                    |  7 -------
>  include/system/kvm_int.h                |  2 --
>  accel/kvm/kvm-accel-ops.c               |  4 ----
>  accel/kvm/kvm-all.c                     | 13 ++-----------
>  target/mips/kvm.c                       |  5 +++++
>  13 files changed, 7 insertions(+), 32 deletions(-)
>
> diff --git a/configs/targets/aarch64-softmmu.mak b/configs/targets/aarch6=
4-softmmu.mak
> index d34aead41c4..6f60ca6505c 100644
> --- a/configs/targets/aarch64-softmmu.mak
> +++ b/configs/targets/aarch64-softmmu.mak
> @@ -1,6 +1,5 @@
>  TARGET_ARCH=3Daarch64
>  TARGET_BASE_ARCH=3Darm
> -TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_XML_FILES=3D aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vf=
p.xml arm-vfp3.xml arm-vfp-sysregs.xml arm-neon.xml arm-m-profile.xml arm-m=
-profile-mve.xml aarch64-pauth.xml aarch64-sme2.xml
>  # needed by boot.c
>  TARGET_NEED_FDT=3Dy
> diff --git a/configs/targets/i386-softmmu.mak b/configs/targets/i386-soft=
mmu.mak
> index 38a8f85201f..2eef68dc55e 100644
> --- a/configs/targets/i386-softmmu.mak
> +++ b/configs/targets/i386-softmmu.mak
> @@ -1,5 +1,4 @@
>  TARGET_ARCH=3Di386
> -TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_KVM_HAVE_RESET_PARKED_VCPU=3Dy
>  TARGET_XML_FILES=3D i386-32bit.xml
>  TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/lo=
ongarch64-softmmu.mak
> index 476407f9413..7e0b1ab5d05 100644
> --- a/configs/targets/loongarch64-softmmu.mak
> +++ b/configs/targets/loongarch64-softmmu.mak
> @@ -1,6 +1,5 @@
>  TARGET_ARCH=3Dloongarch64
>  TARGET_BASE_ARCH=3Dloongarch
> -TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_XML_FILES=3D loongarch-base32.xml loongarch-base64.xml loongarch-=
fpu.xml loongarch-lsx.xml loongarch-lasx.xml
>  # all boards require libfdt
>  TARGET_NEED_FDT=3Dy
> diff --git a/configs/targets/ppc-softmmu.mak b/configs/targets/ppc-softmm=
u.mak
> index 867898bd47c..c47887f8992 100644
> --- a/configs/targets/ppc-softmmu.mak
> +++ b/configs/targets/ppc-softmmu.mak
> @@ -1,5 +1,4 @@
>  TARGET_ARCH=3Dppc
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_XML_FILES=3D power-core.xml power-fpu.xml power-altivec.xml power=
-spe.xml
>  TARGET_LONG_BITS=3D32
> diff --git a/configs/targets/ppc64-softmmu.mak b/configs/targets/ppc64-so=
ftmmu.mak
> index 10d7a2681e7..8c6dc84b821 100644
> --- a/configs/targets/ppc64-softmmu.mak
> +++ b/configs/targets/ppc64-softmmu.mak
> @@ -1,7 +1,6 @@
>  TARGET_ARCH=3Dppc64
>  TARGET_BASE_ARCH=3Dppc
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_XML_FILES=3D power64-core.xml power-fpu.xml power-altivec.xml pow=
er-spe.xml power-vsx.xml
>  # all boards require libfdt
>  TARGET_NEED_FDT=3Dy
> diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv6=
4-softmmu.mak
> index 5059c550480..e0d2c7032d6 100644
> --- a/configs/targets/riscv64-softmmu.mak
> +++ b/configs/targets/riscv64-softmmu.mak
> @@ -1,6 +1,5 @@
>  TARGET_ARCH=3Driscv64
>  TARGET_BASE_ARCH=3Driscv
> -TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_XML_FILES=3D riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-=
fpu.xml riscv-64bit-virtual.xml riscv-32bit-cpu.xml riscv-32bit-virtual.xml
>  # needed by boot.c
>  TARGET_NEED_FDT=3Dy
> diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-so=
ftmmu.mak
> index e273075f1a9..699e5ced96f 100644
> --- a/configs/targets/s390x-softmmu.mak
> +++ b/configs/targets/s390x-softmmu.mak
> @@ -1,6 +1,5 @@
>  TARGET_ARCH=3Ds390x
>  TARGET_BIG_ENDIAN=3Dy
> -TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_XML_FILES=3D s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.x=
ml s390-cr.xml s390-virt.xml s390-virt-kvm.xml s390-gs.xml
>  TARGET_LONG_BITS=3D64
>  TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=3Dy
> diff --git a/configs/targets/x86_64-softmmu.mak b/configs/targets/x86_64-=
softmmu.mak
> index c7f8746b4f5..491173df466 100644
> --- a/configs/targets/x86_64-softmmu.mak
> +++ b/configs/targets/x86_64-softmmu.mak
> @@ -1,6 +1,5 @@
>  TARGET_ARCH=3Dx86_64
>  TARGET_BASE_ARCH=3Di386
> -TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_KVM_HAVE_RESET_PARKED_VCPU=3Dy
>  TARGET_XML_FILES=3D i386-64bit.xml i386-64bit-apx.xml
>  TARGET_LONG_BITS=3D64
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 12f7fc8fb58..a2463a3ac3f 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -236,14 +236,7 @@ void kvm_irqchip_change_notify(void);
>   * calling down to kvm_arch_update_guest_debug after the generic
>   * fields have been set.
>   */
> -#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>  int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
> -#else
> -static inline int kvm_update_guest_debug(CPUState *cpu, unsigned long re=
inject_trap)
> -{
> -    return -EINVAL;
> -}
> -#endif
>
>  /* internal API */
>
> diff --git a/include/system/kvm_int.h b/include/system/kvm_int.h
> index 0876aac938d..9d1d3fd3deb 100644
> --- a/include/system/kvm_int.h
> +++ b/include/system/kvm_int.h
> @@ -113,9 +113,7 @@ struct KVMState
>      struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
>      bool coalesced_flush_in_progress;
>      int vcpu_events;
> -#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>      QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
> -#endif
>      int max_nested_state_len;
>      int kvm_shadow_mem;
>      bool kernel_irqchip_allowed;
> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
> index 6d9140e549f..d4af6b416c3 100644
> --- a/accel/kvm/kvm-accel-ops.c
> +++ b/accel/kvm/kvm-accel-ops.c
> @@ -85,12 +85,10 @@ static bool kvm_cpus_are_resettable(void)
>      return !kvm_enabled() || !kvm_state->guest_state_protected;
>  }
>
> -#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>  static int kvm_update_guest_debug_ops(CPUState *cpu)
>  {
>      return kvm_update_guest_debug(cpu, 0);
>  }
> -#endif
>
>  static void kvm_accel_ops_class_init(ObjectClass *oc, const void *data)
>  {
> @@ -105,13 +103,11 @@ static void kvm_accel_ops_class_init(ObjectClass *o=
c, const void *data)
>      ops->synchronize_pre_loadvm =3D kvm_cpu_synchronize_pre_loadvm;
>      ops->handle_interrupt =3D generic_handle_interrupt;
>
> -#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>      ops->update_guest_debug =3D kvm_update_guest_debug_ops;
>      ops->supports_guest_debug =3D kvm_supports_guest_debug;
>      ops->insert_breakpoint =3D kvm_insert_breakpoint;
>      ops->remove_breakpoint =3D kvm_remove_breakpoint;
>      ops->remove_all_breakpoints =3D kvm_remove_all_breakpoints;
> -#endif
>  }
>
>  static const TypeInfo kvm_accel_ops_type =3D {
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 774499d34f8..9a46a61b7f5 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2919,9 +2919,7 @@ static int kvm_init(AccelState *as, MachineState *m=
s)
>      s->sigmask_len =3D 8;
>      accel_blocker_init();
>
> -#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>      QTAILQ_INIT(&s->kvm_sw_breakpoints);
> -#endif
>      QLIST_INIT(&s->kvm_parked_vcpus);
>      s->fd =3D qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
>      if (s->fd =3D=3D -1) {
> @@ -3032,23 +3030,19 @@ static int kvm_init(AccelState *as, MachineState =
*ms)
>      kvm_vm_attributes_allowed =3D
>          (kvm_check_extension(s, KVM_CAP_VM_ATTRIBUTES) > 0);
>
> -#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>      kvm_has_guest_debug =3D
>          (kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG) > 0);
> -#endif
>
>      kvm_sstep_flags =3D 0;
>      if (kvm_has_guest_debug) {
> -        kvm_sstep_flags =3D SSTEP_ENABLE;
> -
> -#if defined TARGET_KVM_HAVE_GUEST_DEBUG
>          int guest_debug_flags =3D
>              kvm_check_extension(s, KVM_CAP_SET_GUEST_DEBUG2);
>
> +        kvm_sstep_flags =3D SSTEP_ENABLE;
> +
>          if (guest_debug_flags & KVM_GUESTDBG_BLOCKIRQ) {
>              kvm_sstep_flags |=3D SSTEP_NOIRQ;
>          }
> -#endif
>      }
>
>      kvm_state =3D s;
> @@ -3781,7 +3775,6 @@ bool kvm_arm_supports_user_irq(void)
>      return kvm_check_extension(kvm_state, KVM_CAP_ARM_USER_IRQ);
>  }
>
> -#ifdef TARGET_KVM_HAVE_GUEST_DEBUG
>  struct kvm_sw_breakpoint *kvm_find_sw_breakpoint(CPUState *cpu, vaddr pc=
)
>  {
>      struct kvm_sw_breakpoint *bp;
> @@ -3941,8 +3934,6 @@ void kvm_remove_all_breakpoints(CPUState *cpu)
>      }
>  }
>
> -#endif /* !TARGET_KVM_HAVE_GUEST_DEBUG */
> -
>  static int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
>  {
>      KVMState *s =3D kvm_state;
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index a85e162409c..49bff68b137 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -1262,6 +1262,11 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
>      abort();
>  }
>
> +int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap)
> +{
> +    return -EINVAL;
> +}
> +
>  int kvm_arch_get_default_type(MachineState *machine)
>  {
>  #if defined(KVM_CAP_MIPS_VZ)
> --
> 2.53.0
>
>

