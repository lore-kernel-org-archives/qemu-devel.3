Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA488D711CA
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 05:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWTPy-0007DM-Gc; Fri, 19 Dec 2025 00:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vWTPw-0007Cb-Hj
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 00:52:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1vWTPu-0005ZD-R7
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 00:52:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766123561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJVwqGdURiRGJsYInZDpCrCMlBUPnbvc668rjGArdHA=;
 b=KFyMpuoW4plc7coBgbUqLALdHop3pU1dVbHaH0lkVP3kgkTcGNOrlM527RHFss7c2Adfho
 Lz8XTDTUZXQZ5/Unm061MxUp93cFySVj8ur4fb7uBzBD2DL+qRA46gt6xEgeUC383dMT6Z
 3HfvKH7e0XJ0sepc3teVGWTyRQEKh5s=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-4SGg0vKSPIWzuXBeChtAUA-1; Fri, 19 Dec 2025 00:52:39 -0500
X-MC-Unique: 4SGg0vKSPIWzuXBeChtAUA-1
X-Mimecast-MFC-AGG-ID: 4SGg0vKSPIWzuXBeChtAUA_1766123559
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7b80de683efso2535283b3a.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 21:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766123559; x=1766728359; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJVwqGdURiRGJsYInZDpCrCMlBUPnbvc668rjGArdHA=;
 b=YiEiNVui+cyrC3GAUqHEbU6YyRWl4CQF2kwpSjcSaWbzYZ+aTabDx6Vt953hLC5tKe
 a2nOMol/lX4eIPf+/e2aU0E6QvowYhbD4dsrlh2cqPRvhZ7mkjRMz/i6Xp3NOwL0pFqI
 6Wmk++rNp6Ssrc75Gyr0x+zSt3zQQdriTALFTFcKTfX+6ipiZEZ8ktTesJ+6ZOqsUy/C
 GRtXwpk27yAF5wWkgHs0nGvgDEq7RKVbAh//t+xmBjZ/1jsd5CWqnIUoICywVumRsPzZ
 0ocTYbeCk9xwf3+86bYTq+/lqsad2Z7SYnyekcHSusXd9sLQ235DwtsmdafIRnAiTunF
 LUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766123559; x=1766728359;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JJVwqGdURiRGJsYInZDpCrCMlBUPnbvc668rjGArdHA=;
 b=iQZdI87GeNNaok8g810V6EsngaHeoXK812xmKgYIU03dP3xJutVGOilYJyiWxekg4+
 U31urfu8tx1LC5AaFyaUAxHd5LfX9yLnOqO8c91nc7ra24CN6EHy+SX/r/OBb7fitOet
 rI7GGQGX2lW6OW9a0Z6Hr82hcXekB7dm5G8fAYz/ZTPFS5fai29pEARo6bR7Nskt6o1B
 +PzK1GJhM+Ba8s5uI446cfMk2kwJxwkGmH2VZH9j64wAisL4uAh1BgQrr/xN1s3zwBSn
 Fzhs8lZHhoPJwbwcMtjpIib1EGmJAbtHZEHcmYoqfz54TzGMDDclwWvmnx1BG70TMgPh
 mfGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA8gNgM+3gZfj9vePh/uvLHT54UGxB16qJMrEGYxO4b0arwQyRxkxBfyYAAVsOKOw8Qds3rhpyrp4Z@nongnu.org
X-Gm-Message-State: AOJu0YzWg9Rw8Jg6AgTuDs8hdeu2w6otBWrlDYH7yTa1QHjRGeMZQPFu
 MXNRXvOFoFlfSj8BvYJVFk4g4w/Elyb/CFy3M3wHEU2Vl6amei207ROWZYala3SvWsQ72MK3CXd
 t9Hg87C4yX+d9lCtgTX3KzB5BWZksgK8YcuDJ3H4F4hglo80CiputlXfH
X-Gm-Gg: AY/fxX4enaeY6xTSymhU7bd/r3tFGzGszi10BlP3lMIeDJwFvdc5l+OUEbUHQNjWQSh
 Ije73gYK5L+rmlhGRSsvhplHgDmIX3TuTmeInPoqfolqo+GGNYk1NZ/qj/1CXKD9Pxt5Ec3mSza
 ArqhCOGciT/thkqstagzX1ul5wI7Wuzn8Ys/NX945G5XnnoyGJjS9naMQBvf7c/4SML2C2JPJIw
 8m5VdkGJ3PDUBivkdBrsASPSWyE5yH4jeHjDpAlEmvm9NssLLlIHGEaui6DhHf4+YdpfrASNh45
 5JIkS4++Ky1g4zKiA29NSinFMO9kRoMrzr0g9zjFvBanzskMuJGlJkysIK8BuF0x7nfZL1kHhnY
 qOt0bNhPeta628jllGMdpVFKRxnf9gJBWpNgqIuwxhtQoJ6pImLk2rROXyQ==
X-Received: by 2002:a05:6a00:e13:b0:7e8:450c:61bc with SMTP id
 d2e1a72fcca58-7ff6607cfc0mr1791929b3a.44.1766123558557; 
 Thu, 18 Dec 2025 21:52:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqF/m7PhYSoU/kq0rN3DwIEZXBg4VgSAObW4lEgr3/k3Akp1nbvuOll/KxGLrqWsCct67vag==
X-Received: by 2002:a05:6a00:e13:b0:7e8:450c:61bc with SMTP id
 d2e1a72fcca58-7ff6607cfc0mr1791889b3a.44.1766123558070; 
 Thu, 18 Dec 2025 21:52:38 -0800 (PST)
Received: from smtpclient.apple ([122.163.94.242])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7af2b60bsm1134278b3a.15.2025.12.18.21.52.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Dec 2025 21:52:37 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.3\))
Subject: Re: [PATCH v1 04/28] accel/kvm: add changes required to support KVM
 VM file descriptor change
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20251212150359.548787-5-anisinha@redhat.com>
Date: Fri, 19 Dec 2025 11:22:16 +0530
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, kvm@vger.kernel.org,
 qemu-arm <qemu-arm@nongnu.org>, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6725C685-0245-47D9-8DE3-5E2672B22D1B@redhat.com>
References: <20251212150359.548787-1-anisinha@redhat.com>
 <20251212150359.548787-5-anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Thomas Huth <thuth@redhat.com>
X-Mailer: Apple Mail (2.3826.700.81.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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



> On 12 Dec 2025, at 8:33=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
> This change adds common kvm specific support to handle KVM VM file =
descriptor
> change. KVM VM file descriptor can change as a part of confidential =
guest reset
> mechanism. A new function api kvm_arch_vmfd_change_ops() per
> architecture platform is added in order to implement architecture =
specific
> changes required to support it. A subsequent patch will add x86 =
specific
> implementation for kvm_arch_vmfd_change_ops as currently only x86 =
supports
> confidential guest reset.

Some more fixes on this patch are in order which I will include in the =
next spin up.

<snip>

>=20
> +static int kvm_reset_vmfd(MachineState *ms)
> +{
> +    KVMState *s;
> +    KVMMemoryListener *kml;
> +    int ret, type;
> +    Error *err =3D NULL;
> +
> +    s =3D KVM_STATE(ms->accelerator);
> +    kml =3D &s->memory_listener;
> +
> +    memory_listener_unregister(&kml->listener);
> +    memory_listener_unregister(&kvm_io_listener);
> +
> +    if (s->vmfd >=3D 0) {
> +        close(s->vmfd);
> +    }
> +
> +    type =3D find_kvm_machine_type(ms);
> +    if (type < 0) {
> +        return -EINVAL;
> +    }
> +
> +    ret =3D do_kvm_create_vm(s, type);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    s->vmfd =3D ret;
> +
> +    kvm_setup_dirty_ring(s);
> +
> +    /* rebind memory to new vm fd */
> +    ret =3D ram_block_rebind(&err);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +    assert(!err);
> +
> +    ret =3D kvm_arch_vmfd_change_ops(ms, s);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (s->kernel_irqchip_allowed) {
> +        do_kvm_irqchip_create(s);
> +    }
> +
> +    /* these can be only called after ram_block_rebind() */
> +    memory_listener_register(&kml->listener, &address_space_memory);
> +    memory_listener_register(&kvm_io_listener, &address_space_io);
> +
> +    /*
> +     * kvm fd has changed. Commit the irq routes to KVM once more.
> +     */
> +    kvm_irqchip_commit_routes(s);
> +
> +    return ret;
> +}
> +
> static int kvm_init(AccelState *as, MachineState *ms)
> {
>     MachineClass *mc =3D MACHINE_GET_CLASS(ms);
> @@ -4014,6 +4077,7 @@ static void kvm_accel_class_init(ObjectClass =
*oc, const void *data)
>     AccelClass *ac =3D ACCEL_CLASS(oc);
>     ac->name =3D "KVM";
>     ac->init_machine =3D kvm_init;
> +    ac->reset_vmfd =3D kvm_reset_vmfd;
>     ac->has_memory =3D kvm_accel_has_memory;
>     ac->allowed =3D &kvm_allowed;
>     ac->gdbstub_supported_sstep_flags =3D kvm_gdbstub_sstep_flags;
> diff --git a/include/system/kvm.h b/include/system/kvm.h
> index 8f9eecf044..ade13dd8cc 100644
> --- a/include/system/kvm.h
> +++ b/include/system/kvm.h
> @@ -358,6 +358,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s);
> int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
> int kvm_arch_init_vcpu(CPUState *cpu);
> int kvm_arch_destroy_vcpu(CPUState *cpu);
> +int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s);

Another API should be added here:
bool kvm_arch_supports_vmfd_change(void)

It should tell kvm_reset_vmfd() whether the underlying architectures =
would support all operations that need to be redone after vm file =
descriptor change. If not, it should bail. Something like:

    /*                                                                   =
                                                                 =20
     * bail if the current architecture does not support VM file         =
                                                                 =20
     * descriptor change.                                                =
                                                                 =20
     */                                                                  =
                                                                 =20
    if (!kvm_arch_supports_vmfd_change()) {                              =
                                                                 =20
        error_report("This target architecture does not support KVM VM " =
                                                                        =20=

                     "file descriptor change.");                         =
                                                                 =20
        return -EOPNOTSUPP;                                              =
                                                                 =20
    }=20

>=20
> #ifdef TARGET_KVM_HAVE_RESET_PARKED_VCPU
> void kvm_arch_reset_parked_vcpu(unsigned long vcpu_id, int kvm_fd);
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 0d57081e69..919bf95ae1 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1568,6 +1568,11 @@ void kvm_arch_init_irq_routing(KVMState *s)
> {
> }
>=20
> +int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
> +{
> +    abort();
> +}
> +
> int kvm_arch_irqchip_create(KVMState *s)
> {
>     if (kvm_kernel_irqchip_split()) {
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 02819de625..cdfcb70f40 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -3252,6 +3252,11 @@ static int kvm_vm_enable_energy_msrs(KVMState =
*s)
>     return 0;
> }
>=20
> +int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
> +{
> +    abort();
> +}
> +
> int kvm_arch_init(MachineState *ms, KVMState *s)
> {
>     int ret;
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 26e40c9bdc..4171781346 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -1312,6 +1312,11 @@ int kvm_arch_irqchip_create(KVMState *s)
>     return kvm_check_extension(s, KVM_CAP_DEVICE_CTRL);
> }
>=20
> +int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
> +{
> +    return 0;

These and others should abort() uniformly instead of silently returning =
sucess.

> +}
> +
> void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
> {
> }
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index 912cd5dfa0..28730da06b 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -44,6 +44,11 @@ unsigned long kvm_arch_vcpu_id(CPUState *cs)
>     return cs->cpu_index;
> }
>=20
> +int kvm_arch_vmfd_change_ops(MachineState *ms, KVMState *s)
> +{
> +    return 0;
> +}
> +
> int kvm_arch_init(MachineState *ms, KVMState *s)
> {
>     /* MIPS has 128 signals */
> dif


