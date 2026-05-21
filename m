Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE8CCD4F5E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPyTX-0008Ow-7G; Thu, 21 May 2026 04:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wPyTB-0008Jl-9q
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:09:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wPyT8-0008Rp-K8
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779350965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQsz+70+x94megdjqCdLkEeKOXcrzAViPQxLB/gwRGk=;
 b=GxXYnf56Xg1oyvmcTOF60YTh9KWkD3phOgtbwQu7qtF/UYd0QYwMh1xXvQzfK5jw7lL3ng
 at5hNKeXXHkEUSfhTfdObHPMQ/lTsW3HJIQO/Kq9EJO3EehjYPE8UDgyo2UsMAEw0xQOY2
 Aqr1HSOXjDFzc4dt0vsfs5c0qz0/oXA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-73RXfk5OMfSStYdEscFaIg-1; Thu, 21 May 2026 04:09:23 -0400
X-MC-Unique: 73RXfk5OMfSStYdEscFaIg-1
X-Mimecast-MFC-AGG-ID: 73RXfk5OMfSStYdEscFaIg_1779350962
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ba3245a43dso61419785ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 01:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779350962; x=1779955762; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQsz+70+x94megdjqCdLkEeKOXcrzAViPQxLB/gwRGk=;
 b=RRoangZcQrk2Z6/21bSHuVKqt5+Z1Xbd2REFEX2irPghyLIh2mlzFd/0pYP3j+KrCG
 lqNKA3jpjt3h4oZmaMvA8gtfj/ZcgkG5ugP/GV1dFBiNpgBzwg7PjFtjwR37IuHegZjf
 5UftiOG9jOUMjxOV5BHKT6+kEUX8IndD6vJCvrUosVu6JaRNVbeBMhTsNiBcDT9qAY65
 aUJSOj1PmaxbbhCJTsgQ9jVJRiFDHfpLW6GkobEQtqZoFF24z7acmfXakrsyZmimo4fT
 XL8dqbvBYzzNaSfTX2GSI3X+B/5HxniN1YqS1o895y/2k7fO5TMPVps9ItHypGXAX6N5
 uXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779350962; x=1779955762;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CQsz+70+x94megdjqCdLkEeKOXcrzAViPQxLB/gwRGk=;
 b=WJvSt/ERVbTeRIJYltTMhxc0iUbV3nFa70ycOd1YheLer1glUb3Sbgh6uMFMfs/oU6
 P7O8dLPI9iit17jxIbq7HRys90YNzApoCFWOXS+LI33wCpr4ECtATy1LSf0CLceW+0A9
 3bquML15p7B6kyf7GtRYsclvWIo43XuNBIsSFhareDpCNhSdQFHSXiJZwHSNTXH6NzHV
 cQGaHRzQv4D9ZRkstYBv/hFtb1nijDdLauTDhVz3ecVHY7k5SKNDrjBN6y2W23/LSAlE
 Bod9OUxR9mx7Ijds7yn31yp9L/qTvKJf7zrsBWTUoipCED+9T7RS/4sVRliwPiJDSMFk
 EFNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ++ZCkFPYJRP/yaVpr7MpPrLKuTSViMm6F2KpHW5Nd5iVdJ/2ATwGMNYhInjxPB7iiamcG9w7vtwOiL@nongnu.org
X-Gm-Message-State: AOJu0YzfCe+vOyw+TwYACSBHd4Gn7Y5Wq/wMgXpLsNDLQlTqWlmT8W92
 AMCKBN/cQsFBAUieqrdssEallA46ZWkp0cW4fLZWhG3l03mZDI3V1jz8BseYiNsuFljffHG+CY4
 aNP1++4XIxVHitlKvMKTgJA14qA+nlwyxzifkDUR6GP9Di577mdDi3c88
X-Gm-Gg: Acq92OFIwLjSRUBF3ez7w7mqnG7As9kM2R4NLzxPqmTioNmISacOCazEYiUnmvLbrUb
 fPUJFjSUjqS4QMUX09fjDv/Xpaq/6hUYZWavMcNk7w4v54UHAkpVRnGOghqwzyAPMDFOAGLCmIF
 C5xnfwMm2QVnu8Y5/NGTkjflbg58HF/hZzijx6BFndlbU8xMiwO2duDCDVb9M/xDCQpk/BMFUaf
 gldJ34AeBMJWMzMuEegWoSq52s+NdI37Ijp2KMGW7zZ36lXa0A8xA6IWZZDhu+7YzloXSfkznS7
 iUFUVMAsn8NwRF8rBBkR008PQm9hgQCkQpPQQVaUfnvp8r3uaeizLKuq506td8VGiHwUCifEDXs
 PTFat2t7i391jPW0H/tkINH2RpNwRB7foNZI4Md34D0Bxd0Le//dP5MOp6uQQciQnZL+zxBVKaL
 4=
X-Received: by 2002:a17:903:390f:b0:2ad:9b86:ddc2 with SMTP id
 d9443c01a7336-2bea3064217mr20029905ad.22.1779350962450; 
 Thu, 21 May 2026 01:09:22 -0700 (PDT)
X-Received: by 2002:a17:903:390f:b0:2ad:9b86:ddc2 with SMTP id
 d9443c01a7336-2bea3064217mr20029655ad.22.1779350961985; 
 Thu, 21 May 2026 01:09:21 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bea91733e5sm3786615ad.11.2026.05.21.01.09.19
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 May 2026 01:09:21 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH for-11.1] accel/kvm: refactor and clean up
 do_kvm_irqchip_create
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CAF7B8BF-9095-4B86-8BC2-EA987BC739F7@redhat.com>
Date: Thu, 21 May 2026 13:39:07 +0530
Cc: peter.maydell@linaro.org, philmd@linaro.org, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <992D68BD-AC1F-457D-B1C4-8DDC79A10327@redhat.com>
References: <20260415063835.85540-1-anisinha@redhat.com>
 <CAF7B8BF-9095-4B86-8BC2-EA987BC739F7@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Ping .. has this patch been queued?


> On 23 Apr 2026, at 7:08=E2=80=AFAM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
> Ping =E2=80=A6 Now that 11.1 dev window is open.
>=20
>> On 15 Apr 2026, at 12:08=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>>=20
>> Refactor do_kvm_irqchip_create() so it has specific return codes for =
specific
>> cases. Clean up the logic and add some clarifying comments. Adjust =
the
>> function call logic accourdingly. Should be no material change.
>>=20
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>> accel/kvm/kvm-all.c | 48 =
++++++++++++++++++++++++++++-----------------
>> 1 file changed, 30 insertions(+), 18 deletions(-)
>>=20
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 92af42503b..788cbf8693 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -2575,6 +2575,13 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, =
qemu_irq irq, int gsi)
>>    g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
>> }
>>=20
>> +/**
>> + * do_kvm_irqchip_create - create irqchip
>> + * @s: The KVMState pointer
>> + *
>> + * Returns: -errno on fatal errors, 0 on success and
>> + *          non-negative on non-fatal errors.
>> + */
>> static int do_kvm_irqchip_create(KVMState *s)
>> {
>>    int ret;
>> @@ -2583,32 +2590,34 @@ static int do_kvm_irqchip_create(KVMState *s)
>>    } else if (kvm_check_extension(s, KVM_CAP_S390_IRQCHIP)) {
>>        ret =3D kvm_vm_enable_cap(s, KVM_CAP_S390_IRQCHIP, 0);
>>        if (ret < 0) {
>> -            fprintf(stderr, "Enable kernel irqchip failed: %s\n", =
strerror(-ret));
>> -            exit(1);
>> +            error_report("Enable kernel irqchip failed: %s", =
strerror(-ret));
>> +            return ret;
>>        }
>>    } else {
>> -        return -EOPNOTSUPP;
>> +        /*
>> +         * neither KVM_CAP_IRQCHIP nor KVM_CAP_S390_IRQCHIP =
capabilities are
>> +         * present. We can't proceed. Bail.
>> +         */
>> +        return 1;
>>    }
>>=20
>> -    if (kvm_check_extension(s, KVM_CAP_IRQFD) <=3D 0) {
>> -        fprintf(stderr, "kvm: irqfd not implemented\n");
>> -        exit(1);
>> -    }
>> +    assert(kvm_check_extension(s, KVM_CAP_IRQFD));
>>=20
>>    /* First probe and see if there's a arch-specific hook to create =
the
>>     * in-kernel irqchip for us */
>>    ret =3D kvm_arch_irqchip_create(s);
>>    if (ret =3D=3D 0) {
>> -        if (s->kernel_irqchip_split =3D=3D ON_OFF_AUTO_ON) {
>> -            error_report("Split IRQ chip mode not supported.");
>> -            exit(1);
>> -        } else {
>> -            ret =3D kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
>> -        }
>> +        /*
>> +         * If we are here, it means we are going to do an in-kernel =
irqchip.
>> +         * Lets make sure that the kernel_irqchip_split setting is =
not set to
>> +         * split mode.
>> +         */
>> +        assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_ON);
>> +        ret =3D kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
>>    }
>>    if (ret < 0) {
>> -        fprintf(stderr, "Create kernel irqchip failed: %s\n", =
strerror(-ret));
>> -        exit(1);
>> +        error_report("Create kernel irqchip failed: %s", =
strerror(-ret));
>> +        return ret;
>>    }
>>=20
>>    return 0;
>> @@ -2616,9 +2625,13 @@ static int do_kvm_irqchip_create(KVMState *s)
>>=20
>> static void kvm_irqchip_create(KVMState *s)
>> {
>> +    int ret;
>>    assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_AUTO);
>>=20
>> -    if (do_kvm_irqchip_create(s) < 0) {
>> +    ret =3D do_kvm_irqchip_create(s);
>> +    assert(ret >=3D 0);
>> +    if (ret) {
>> +        /* required kvm capabilities missing, we can't proceed. */
>>        return;
>>    }
>>    kvm_kernel_irqchip =3D true;
>> @@ -2839,8 +2852,7 @@ static int kvm_reset_vmfd(MachineState *ms)
>>    }
>>=20
>>    if (s->kernel_irqchip_allowed) {
>> -        /* ignore return from this function */
>> -        do_kvm_irqchip_create(s);
>> +        assert(do_kvm_irqchip_create(s) >=3D 0);
>>    }
>>=20
>>    /*
>> --=20
>> 2.49.0
>>=20
>=20


