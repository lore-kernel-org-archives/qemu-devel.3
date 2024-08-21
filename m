Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CC6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 03:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgcBd-0008WB-Nh; Tue, 20 Aug 2024 23:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sgcBd-0008Vh-0B
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 23:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sgcBb-00088U-2a
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 23:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724211539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mniOU0Jv46Kkr7FC0o+Y7JC9pwzDkeZwe6nNhkfibzQ=;
 b=MA1Qs/3vbPogBrGAe4hUVCLhYpnO4//0bHKVy21ZoH3hOQ5sgreChyGlEVKQj9SzT3ySmf
 ebpUP5ZqFRMuOoLuj5id45L1CibQeYjfuZ5Yh37gWa92WkYK1XELTOSxr1pjaSJYRj4mCW
 uUuvboyggGSTPIQCA/DXyp4pCKrrszg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Kf4inN1SMiy_IveLZh7YJw-1; Tue, 20 Aug 2024 23:38:57 -0400
X-MC-Unique: Kf4inN1SMiy_IveLZh7YJw-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-713d24cf706so4112825b3a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 20:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724211537; x=1724816337;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mniOU0Jv46Kkr7FC0o+Y7JC9pwzDkeZwe6nNhkfibzQ=;
 b=vlN7Vb/n1Z9Gub1xhNaUXOPTuH4ZcoP91z+oDjf1TsivkUKUZViymBnTufF0ubwW4U
 qnxxCZON34U+ZAjMs0z26MCMTUwGqF51vI8ljgwzdOrKYZUUOJMhv4I0v1nb2CAtR2pE
 YOmovL7eigh1u+PW3LUsjG/slT+DyzJF+PyyG4ZMv4g+SdGQS956nj9TodEoNjx6499z
 45e88pKHGkDJAeEi1zLcdOFxRRaP+QrzyMgzzFucZG9dkRhaPQ+3W2LP0XaYSEwBl+hk
 fxLiS3S3Ab0n79OfEywzT4/KjhKEW1ymPbo9SuUfE8Hr5Q67LntHUS0JIFPVzmtTM33w
 cz9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQjp5WgR7Sx1ZQzSg+470S8BsDy/G3r0QLz+d7pnDu/LyS4ce/dwt+d2ee88fT19H3hNQwvI6N0Idx@nongnu.org
X-Gm-Message-State: AOJu0YyyF/gOFIBVVrDykGZy0+7rwPoT/VZTaoEeJ5sK+t6mzqhqk8np
 RnCwgEQjMuuWLs+1BV2uLM79TtrQxQ9NjogJKpna+5+GTilzM1qFDUI5n/zs1PjF+lCdC04Ml3M
 NGUJS82iBhZ9Y1q66hV+xiymC0QmTTA/MK0CTBRanNEilWxHnDZlI
X-Received: by 2002:a05:6a21:a34b:b0:1c6:ee92:e5f4 with SMTP id
 adf61e73a8af0-1cad825ab0bmr1540251637.54.1724211536643; 
 Tue, 20 Aug 2024 20:38:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFbG6jdjOSB9eCmrWvBe4CdhqGwfDb6L5DPmerEcXkT1EbIQjiI4ycCHoVxTXuUByOYQ1aVQ==
X-Received: by 2002:a05:6a21:a34b:b0:1c6:ee92:e5f4 with SMTP id
 adf61e73a8af0-1cad825ab0bmr1540225637.54.1724211536071; 
 Tue, 20 Aug 2024 20:38:56 -0700 (PDT)
Received: from smtpclient.apple ([122.172.87.209])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d5ebb69487sm464692a91.45.2024.08.20.20.38.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Aug 2024 20:38:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v3] kvm: replace fprintf with error_report/printf() in
 kvm_init()
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <31202ec6-d108-4dd9-a103-f534f36c2821@linaro.org>
Date: Wed, 21 Aug 2024 09:08:41 +0530
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-trivial@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B13D1705-CE12-42FD-8EF0-7945F5731A01@redhat.com>
References: <20240809064940.1788169-1-anisinha@redhat.com>
 <8913b8c7-4103-4f69-8567-afdc29f8d0d3@linaro.org>
 <CAK3XEhM+SR39vYxG_ygQ=hCj_bmDE3dOH6EPFQZbLYrE-Yj-ow@mail.gmail.com>
 <CAK3XEhPZ8X1-Ui6pJ+kYY3Er-N-zW0f5MqpLyaU7t2d3qaQXkA@mail.gmail.com>
 <31202ec6-d108-4dd9-a103-f534f36c2821@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3776.700.51)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



> On 16 Aug 2024, at 11:51=E2=80=AFAM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 12/8/24 11:59, Ani Sinha wrote:
>> On Mon, 12 Aug, 2024, 3:23 pm Ani Sinha, <anisinha@redhat.com =
<mailto:anisinha@redhat.com>> wrote:
>>    On Fri, Aug 9, 2024 at 2:06=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
>>    <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
>>     >
>>     > Hi Ani,
>>     >
>>     > On 9/8/24 08:49, Ani Sinha wrote:
>>     > > error_report() is more appropriate for error situations.
>>    Replace fprintf with
>>     > > error_report. Cosmetic. No functional change.
>>     > >
>>     > > CC: qemu-trivial@nongnu.org <mailto:qemu-trivial@nongnu.org>
>>     > > CC: zhao1.liu@intel.com <mailto:zhao1.liu@intel.com>
>>     >
>>     > (Pointless to carry Cc line when patch is already reviewed next =
line)
>>     >
>>     > > Reviewed-by: Zhao Liu <zhao1.liu@intel.com
>>    <mailto:zhao1.liu@intel.com>>
>>     > > Signed-off-by: Ani Sinha <anisinha@redhat.com
>>    <mailto:anisinha@redhat.com>>
>>     > > ---
>>     > >   accel/kvm/kvm-all.c | 40 =
++++++++++++++++++----------------------
>>     > >   1 file changed, 18 insertions(+), 22 deletions(-)
>>     > >
>>     > > changelog:
>>     > > v2: fix a bug.
>>     > > v3: replace one instance of error_report() with =
error_printf().
>>    added tags.
>>     > >
>>     > > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>     > > index 75d11a07b2..5bc9d35b61 100644
>>     > > --- a/accel/kvm/kvm-all.c
>>     > > +++ b/accel/kvm/kvm-all.c
>>     > > @@ -2427,7 +2427,7 @@ static int kvm_init(MachineState *ms)
>>     > >       QLIST_INIT(&s->kvm_parked_vcpus);
>>     > >       s->fd =3D qemu_open_old(s->device ?: "/dev/kvm", =
O_RDWR);
>>     > >       if (s->fd =3D=3D -1) {
>>     > > -        fprintf(stderr, "Could not access KVM kernel module:
>>    %m\n");
>>     > > +        error_report("Could not access KVM kernel module: =
%m");
>>     > >           ret =3D -errno;
>>     > >           goto err;
>>     > >       }
>>     > > @@ -2437,13 +2437,13 @@ static int kvm_init(MachineState *ms)
>>     > >           if (ret >=3D 0) {
>>     > >               ret =3D -EINVAL;
>>     > >           }
>>     > > -        fprintf(stderr, "kvm version too old\n");
>>     > > +        error_report("kvm version too old");
>>     > >           goto err;
>>     > >       }
>>     > >
>>     > >       if (ret > KVM_API_VERSION) {
>>     > >           ret =3D -EINVAL;
>>     > > -        fprintf(stderr, "kvm version not supported\n");
>>     > > +        error_report("kvm version not supported");
>>     > >           goto err;
>>     > >       }
>>     > >
>>     > > @@ -2488,26 +2488,22 @@ static int kvm_init(MachineState *ms)
>>     > >       } while (ret =3D=3D -EINTR);
>>     > >
>>     > >       if (ret < 0) {
>>     > > -        fprintf(stderr, "ioctl(KVM_CREATE_VM) failed: %d
>>    %s\n", -ret,
>>     > > -                strerror(-ret));
>>     > > +        error_report("ioctl(KVM_CREATE_VM) failed: %d %s", =
-ret,
>>     > > +                    strerror(-ret));
>>     > >
>>     > >   #ifdef TARGET_S390X
>>     > >           if (ret =3D=3D -EINVAL) {
>>     > > -            fprintf(stderr,
>>     > > -                    "Host kernel setup problem detected.
>>    Please verify:\n");
>>     > > -            fprintf(stderr, "- for kernels supporting the
>>    switch_amode or"
>>     > > -                    " user_mode parameters, whether\n");
>>     > > -            fprintf(stderr,
>>     > > -                    "  user space is running in primary
>>    address space\n");
>>     > > -            fprintf(stderr,
>>     > > -                    "- for kernels supporting the
>>    vm.allocate_pgste sysctl, "
>>     > > -                    "whether it is enabled\n");
>>     > > +            error_report("Host kernel setup problem =
detected.
>>     >
>>     > \n"
>>     >
>>     > Should we use error_printf_unless_qmp() for the following?
>>    Do you believe that qemu_init() -> configure_accelerators() ->
>>    do_configure_accelerator,() -> accel_init_machine() -> kvm_init()  =
can
>>    be called from QMP context?
>> To clarify, that is the only path I saw that calls kvm_init()
>=20
> We don't know whether this code can end refactored or not.

Ok personally I think we can cross the bridge when we get there.

> Personally I rather consistent API uses, since snipped of
> code are often used as example. Up to the maintainer.

OK up to Paolo then :-)=20

>=20
>>     >
>>     > " Please verify:");
>>     > > +            error_report("- for kernels supporting the
>>    switch_amode or"
>>     > > +                        " user_mode parameters, whether");
>>     > > +            error_report("  user space is running in primary
>>    address space");
>>     > > +            error_report("- for kernels supporting the
>>    vm.allocate_pgste "
>>     > > +                        "sysctl, whether it is enabled");
>>     > >           }
>>     > >   #elif defined(TARGET_PPC)
>>     > >           if (ret =3D=3D -EINVAL) {
>>     > > -            fprintf(stderr,
>>     > > -                    "PPC KVM module is not loaded.
>>     >
>>     > \n"
>>     >
>>     > Ditto.
>>     >
>>     > " Try modprobe kvm_%s.\n",
>>     > > -                    (type =3D=3D 2) ? "pr" : "hv");
>>     > > +            error_report("PPC KVM module is not loaded. Try
>>    modprobe kvm_%s.",
>>     > > +                        (type =3D=3D 2) ? "pr" : "hv");
>>     > >           }
>>     > >   #endif
>>     > >           goto err;
>>     > > @@ -2526,9 +2522,9 @@ static int kvm_init(MachineState *ms)
>>     > >                           nc->name, nc->num, =
soft_vcpus_limit);
>>     > >
>>     > >               if (nc->num > hard_vcpus_limit) {
>>     > > -                fprintf(stderr, "Number of %s cpus requested
>>    (%d) exceeds "
>>     > > -                        "the maximum cpus supported by KVM
>>    (%d)\n",
>>     > > -                        nc->name, nc->num, =
hard_vcpus_limit);
>>     > > +                error_report("Number of %s cpus requested =
(%d)
>>    exceeds "
>>     > > +                             "the maximum cpus supported by
>>    KVM (%d)",
>>     > > +                             nc->name, nc->num, =
hard_vcpus_limit);
>>     > >                   exit(1);
>>     > >               }
>>     > >           }
>>     > > @@ -2542,8 +2538,8 @@ static int kvm_init(MachineState *ms)
>>     > >       }
>>     > >       if (missing_cap) {
>>     > >           ret =3D -EINVAL;
>>     > > -        fprintf(stderr, "kvm does not support %s\n%s",
>>     > > -                missing_cap->name, upgrade_note);
>>     > > +        error_printf("kvm does not support %s\n%s",
>>     > > +                     missing_cap->name, upgrade_note);
>>     >
>>     > Similarly, should we print upgrade_note using
>>    error_printf_unless_qmp?
>>     >
>>     > >           goto err;
>>     > >       }
>>     > >
>>     >



