Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236DEFAD3E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 01:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFj1g-000053-0t; Wed, 22 Apr 2026 21:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wFj1e-0008WU-61
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 21:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wFj1b-0001mx-Vk
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 21:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776908317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=umHlt5UmJvkmq7XVNVqyffxS65gP4jhfhVNPZD5Gffk=;
 b=UfmvpaQOMQbo62K/XBAk9ecs1YNvo2HdfKxSlysKQeioQNeQf/21mjyr/Z5f390m33MgIP
 YzvQMSJmO8mHaijKShAnVa33U+aTfZz15Sgzp2goGOatkTLTk79vssHErXoG3kaS7XCb8o
 +7UqxYxs4S2gkKDd7bbG/DiqZTPX108=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-H074Oe4PMrCaVRXgCCcWmA-1; Wed, 22 Apr 2026 21:38:35 -0400
X-MC-Unique: H074Oe4PMrCaVRXgCCcWmA-1
X-Mimecast-MFC-AGG-ID: H074Oe4PMrCaVRXgCCcWmA_1776908315
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b465bf993cso63361375ad.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 18:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776908315; x=1777513115; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=umHlt5UmJvkmq7XVNVqyffxS65gP4jhfhVNPZD5Gffk=;
 b=LELQqfmQCxLyiTP9bI6nTcjJNmFnxHudiY/pfs5Hwd4jfKwgkddaOjwBnReXk42q7e
 owkdS2kwpzgE/1lSlsoszzUr5JZTeRJZxcMMoefnTORd55kZoGyuWGuP4Mhj9YgqNNDR
 ZuKh5VsMJbLT0Dz6cBkhmh5twaHbiPVyiLZJc/3CxisCXciWR7WLQabEKucPJ0Psk0ST
 vqyAB+M0c98CxAsTQEuUqDPs2nQhBdtGmqzsNn6NFJn2jxHA9zWjJRHwA74g2pvrHUtt
 lNJSIwCVKaFOGUPkqZ0swRUENYo7gN25+YQnuqaTjJ2RfdBl7wZeikDxSL4EJ6h8xCoe
 QYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776908315; x=1777513115;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=umHlt5UmJvkmq7XVNVqyffxS65gP4jhfhVNPZD5Gffk=;
 b=sCyh2KEFaVxDcT/eZkU22apWHnJ0S64L5NARdEnc1UE8rV3jnpGiu9UxE8pDWTsy3Z
 1X2T9VjnJ2VEFsCTuBS8NZaIubUrM/UGlEWt7k79PmWt+sB5yVSFt4klpo13npenaOpM
 T1iPnh4l1vdtgUxdWBeIi8Gb0+RuIQhrMmfgs0XnI0CM3jcEKLQY/TPh/znEf49L5FIb
 x0RpH+VOv6V1REgadPhosQI/zRBNfWcSWXuDKuOukCfL+O0cdWXUxTdQQpbyemplGReo
 sW0g5tAsKJaIVhlBeYr1+aFYFeo4Ga6K222gmKNvADd3Q9bytUQwFp5JHj7ZCKPEndh/
 MR+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9D5efZ17Q0cQ7fndEGxb88AROnmQjmtyaP+duh2wTt454aMXutHMMFdMmhJhOBqSTMuaZT/67f3PtM@nongnu.org
X-Gm-Message-State: AOJu0Yz0i9VF5vUz1ajgD38Z2ngLj1e7jQHgrEYO+DL6iInZSAboumNz
 Uy7lxKZw0wT4JbtK7DAs/hfarwCKSR2dGP+G2iEbHikBeMkYB6SiFFRX6fS5RFbMiTnWOxn0oGe
 SKNwvUNdc3YkoVxNp/900YpEdTHTGT48+rWl7c2WhiH3mzpAuysVY8+Ty
X-Gm-Gg: AeBDiescXKxfPrtFjj3tss/6hygMPyueTQqjMX3ze43dm431llnLVhNW4gghTmflK1T
 lEhjIoTD9BVEc6GFK2BIs4XkXH8qT1UXXvMWwU+vGeVEFvqIsLG67YJjT8yu003kOKG4lwsmsXx
 8RFNzchlJnoWBNeuq20KzOCCGCjQKuoGK1/OYx+yGre9/JV81EirdRgUys+Lm/WoW+DLKnvWnWK
 IUrkjZylcRicspdmUqfJTU4EitCxkdA6yVejlXTczCG4ZK1sPGt5Xyxt1u6X1zNXQf2Yg8fTvjZ
 yUQ4EIWoe2ojbkUA9Jkqf8nS/5ATtS2h1C6wllWEpOohQIJaAc74j5a6TIE/B9hqNoYgntY41Jt
 DNnG0MXqa80PS8WrvUOszEZT8CKrPm6hk5XZEY1CeWbb8ZdEG+lGZ0DnZzJ8upzDUIysh+APjAL
 TS2povSB4H0a0uE3C3
X-Received: by 2002:a17:903:2ac4:b0:2b0:41bf:ca83 with SMTP id
 d9443c01a7336-2b5f9f3c616mr257135015ad.23.1776908314611; 
 Wed, 22 Apr 2026 18:38:34 -0700 (PDT)
X-Received: by 2002:a17:903:2ac4:b0:2b0:41bf:ca83 with SMTP id
 d9443c01a7336-2b5f9f3c616mr257134655ad.23.1776908314054; 
 Wed, 22 Apr 2026 18:38:34 -0700 (PDT)
Received: from smtpclient.apple ([2406:7400:56:9d52:1830:f5d:7353:6235])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa17632sm184179495ad.24.2026.04.22.18.38.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 22 Apr 2026 18:38:33 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH for-11.1] accel/kvm: refactor and clean up
 do_kvm_irqchip_create
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20260415063835.85540-1-anisinha@redhat.com>
Date: Thu, 23 Apr 2026 07:08:18 +0530
Cc: peter.maydell@linaro.org, philmd@linaro.org, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CAF7B8BF-9095-4B86-8BC2-EA987BC739F7@redhat.com>
References: <20260415063835.85540-1-anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Ping =E2=80=A6 Now that 11.1 dev window is open.

> On 15 Apr 2026, at 12:08=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
> Refactor do_kvm_irqchip_create() so it has specific return codes for =
specific
> cases. Clean up the logic and add some clarifying comments. Adjust the
> function call logic accourdingly. Should be no material change.
>=20
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
> accel/kvm/kvm-all.c | 48 ++++++++++++++++++++++++++++-----------------
> 1 file changed, 30 insertions(+), 18 deletions(-)
>=20
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 92af42503b..788cbf8693 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2575,6 +2575,13 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, =
qemu_irq irq, int gsi)
>     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
> }
>=20
> +/**
> + * do_kvm_irqchip_create - create irqchip
> + * @s: The KVMState pointer
> + *
> + * Returns: -errno on fatal errors, 0 on success and
> + *          non-negative on non-fatal errors.
> + */
> static int do_kvm_irqchip_create(KVMState *s)
> {
>     int ret;
> @@ -2583,32 +2590,34 @@ static int do_kvm_irqchip_create(KVMState *s)
>     } else if (kvm_check_extension(s, KVM_CAP_S390_IRQCHIP)) {
>         ret =3D kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP, 0);
>         if (ret < 0) {
> -            fprintf(stderr, "Enable kernel irqchip failed: %s\n", =
strerror(-ret));
> -            exit(1);
> +            error_report("Enable kernel irqchip failed: %s", =
strerror(-ret));
> +            return ret;
>         }
>     } else {
> -        return -EOPNOTSUPP;
> +        /*
> +         * neither KVM_CAP_IRQCHIP nor KVM_CAP_S390_IRQCHIP =
capabilities are
> +         * present. We can't proceed. Bail.
> +         */
> +        return 1;
>     }
>=20
> -    if (kvm_check_extension(s, KVM_CAP_IRQFD) <=3D 0) {
> -        fprintf(stderr, "kvm: irqfd not implemented\n");
> -        exit(1);
> -    }
> +    assert(kvm_check_extension(s, KVM_CAP_IRQFD));
>=20
>     /* First probe and see if there's a arch-specific hook to create =
the
>      * in-kernel irqchip for us */
>     ret =3D kvm_arch_irqchip_create(s);
>     if (ret =3D=3D 0) {
> -        if (s->kernel_irqchip_split =3D=3D ON_OFF_AUTO_ON) {
> -            error_report("Split IRQ chip mode not supported.");
> -            exit(1);
> -        } else {
> -            ret =3D kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
> -        }
> +        /*
> +         * If we are here, it means we are going to do an in-kernel =
irqchip.
> +         * Lets make sure that the kernel_irqchip_split setting is =
not set to
> +         * split mode.
> +         */
> +        assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_ON);
> +        ret =3D kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
>     }
>     if (ret < 0) {
> -        fprintf(stderr, "Create kernel irqchip failed: %s\n", =
strerror(-ret));
> -        exit(1);
> +        error_report("Create kernel irqchip failed: %s", =
strerror(-ret));
> +        return ret;
>     }
>=20
>     return 0;
> @@ -2616,9 +2625,13 @@ static int do_kvm_irqchip_create(KVMState *s)
>=20
> static void kvm_irqchip_create(KVMState *s)
> {
> +    int ret;
>     assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_AUTO);
>=20
> -    if (do_kvm_irqchip_create(s) < 0) {
> +    ret =3D do_kvm_irqchip_create(s);
> +    assert(ret >=3D 0);
> +    if (ret) {
> +        /* required kvm capabilities missing, we can't proceed. */
>         return;
>     }
>     kvm_kernel_irqchip =3D true;
> @@ -2839,8 +2852,7 @@ static int kvm_reset_vmfd(MachineState *ms)
>     }
>=20
>     if (s->kernel_irqchip_allowed) {
> -        /* ignore return from this function */
> -        do_kvm_irqchip_create(s);
> +        assert(do_kvm_irqchip_create(s) >=3D 0);
>     }
>=20
>     /*
> --=20
> 2.49.0
>=20


