Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701F4F34C4B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 12:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCGCV-0002Uz-5z; Mon, 13 Apr 2026 08:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCGCN-0002T9-LS
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCGCL-0007eT-PR
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776082524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=98IpbZc1i4m/jkYav02DEme4PH34rmZew/TvIsBqAN0=;
 b=i9I37FxoOeBBtHwqQfzLhSQgFpuAFkG9eLoisO4p/9ILVZA9QDdJcAsU2S8P851+qtXqjB
 acMXuoRhugpZAMla8q0iF6Cyj8CEqoLTqbqt1UnjySMQKMJsHLqNeazsg8kXN2yfWJkKYS
 gGUnh4c+l0i778mgmpfYo1+evsqsJuQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-QanoLqqxMC6IjVtP-YmR5g-1; Mon, 13 Apr 2026 08:15:22 -0400
X-MC-Unique: QanoLqqxMC6IjVtP-YmR5g-1
X-Mimecast-MFC-AGG-ID: QanoLqqxMC6IjVtP-YmR5g_1776082522
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b458add85aso12411555ad.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 05:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776082522; x=1776687322; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98IpbZc1i4m/jkYav02DEme4PH34rmZew/TvIsBqAN0=;
 b=MVxQV6nPkguTSAAuMtyTNa3ScnB09NTmjr4NnGCt7KsydcOafiz5IMF/AztP2kyMtS
 OkKG8G4btOSrWntQ60ulM04XOP2ofKPb8gKl7kTG+V4FCsLi4MSCEuf+wWwP/q7Ty0bI
 pCSYcuuA/b/cFQ+6otrKsanFywBfvtYjTcvBkB8j8hJXTOH3FnqHuJrYkz1proPXYUM3
 V0ZLdHkiNviBSLtkjGooxpCkBmPkWQcqvg5jZZ8oYPzRp08FDjifVfdrbf5OjesSH8Zj
 CuQHVeuvxFHFr1kxXCsS//huUByi25zqJ3kXtiNjyFhaF0Ar0U6tsw1AAZfPFQCrDUv2
 LBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776082522; x=1776687322;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=98IpbZc1i4m/jkYav02DEme4PH34rmZew/TvIsBqAN0=;
 b=DECXhYefWNNRslyZV6cDrHNTlvrx0u9GP4Hs6q7JGpFyFA0prgATS6V8PJUD04YXoD
 BJekhoWJ3uRg7DJvUH2SKBgnvb/vbrFoNowDqYW5xO0Wn4wIHaR4R3l9QAHxseWBlzmt
 spb0jX9qXbpdTXvL/778LbkYM6IQh751y/3hBu/3+7swC9mZs0rH0fxdjgBMRwErhgoO
 m+yOgbd30NvKI6l5ApotJNTgb1fAz41Rmfa+7s6xI9VZdHmMwXX4ChYv5xZRG48Feyds
 T/EBRIIoVFc+LfjqNhFSt+F8wOrR0DwrRK8+cox39+f7jvDAq0Iy76c99DU3mJUCJp1E
 GIeg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CAvUkTADuFfnI7WQMtIYfTiI9bovIBSPscss3x+MlG/T3gXg9AXBd39aG7Leo8vhchJauX7C0dmrL@nongnu.org
X-Gm-Message-State: AOJu0Yz+1YgQ7qnDZvtFMz9qOMJ75yk4PDYSuUaWc2dUmt+IdgQdeQtO
 6wSziWCzuAUAikyndMtEa6TEprv7iHxq+SyCWMqQ8tT/ArAst0BGdC8U6aBNB6gQyUiFy0WGjPX
 m8qn/fU5gvnJI7bYGQjQS+cshpw0CpSANkZeHlD3w524bga+d4TGPFamG
X-Gm-Gg: AeBDiesf7jWNAVCdY9LNty0T6bYWZNx43gKip4Qb55Iquy5lBqo/uKEku1MQ+UZ7P53
 YU58DrNothgle80+oH3BweT3YRCHdXla1IGh3z5+78M4QiHX07jwPYBD/M+4LsMSP33/0lah1RF
 Xihf5ffPONp8IjGDPfigSFndLPKlOzmbZOe9wj7X09pH8EL0tDwW6Z40SFx/3fobvDv10gbxW+U
 lln98naqNqS61azLnuZ+qJZY6deJis7uj/KE5DjDjUxEM53zy0GU88a5wypvDRLscUVkSO3XGYX
 1qolSs0Q0fO0nR8rMIhXTNOh1YNl0fYN1JxtHagmz9weAwF/uK/8xx1KNbv4vt/KwV+ppz/LAac
 uORFZR98Tmu6SY8Dlda2BB59ArGOjIoe/Y+aJHLhjCguR2RLQj6lVkDa+HZU5SSfNqBLrG3iROl
 0=
X-Received: by 2002:a17:903:37c6:b0:2b2:49a7:a5bc with SMTP id
 d9443c01a7336-2b2d5a60603mr132540235ad.39.1776082521415; 
 Mon, 13 Apr 2026 05:15:21 -0700 (PDT)
X-Received: by 2002:a17:903:37c6:b0:2b2:49a7:a5bc with SMTP id
 d9443c01a7336-2b2d5a60603mr132539505ad.39.1776082520751; 
 Mon, 13 Apr 2026 05:15:20 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4db198asm115235855ad.3.2026.04.13.05.15.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2026 05:15:20 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH V2 for-11.0] accel/kvm: return early from
 kvm_irqchip_create if kvm does not support irqchip
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <0954ef7e-b04e-4542-89fb-796acc452068@linux.ibm.com>
Date: Mon, 13 Apr 2026 17:45:05 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 kvm@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <980AC83F-DD93-4924-8935-11CBFD624ACE@redhat.com>
References: <20260413112151.61261-1-anisinha@redhat.com>
 <0954ef7e-b04e-4542-89fb-796acc452068@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



> On 13 Apr 2026, at 5:06=E2=80=AFPM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>=20
>=20
>=20
> On 13/04/26 4:51 pm, Ani Sinha wrote:
>> During refactoring of kvm_irqchip_create(), the refactored code was =
returning
>> early from do_kvm_irqchip_create() function if the required =
capabilities were
>> not present in KVM. This was not translating to an early return from
>> kvm_irqchip_create() as was the case before refactoring. This is =
because,
>> do_kvm_irqchip_create() did not have a means to notify the caller of =
the lack
>> of kvm capabilities. Fix this by making do_notify_irqchip_create() =
return
>> EOPNOTSUPP error when required capabilities are absent and then the =
caller
>> can check the return code and return early.
>> Converted some calls to exit() to assertion checks in order to make =
it cleaner.
>> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM =
file descriptor change")
>> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
>> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
>> Suggested-by: Fabiano Rosas <farosas@suse.de>
>> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>  accel/kvm/kvm-all.c | 29 ++++++++++++++++-------------
>>  1 file changed, 16 insertions(+), 13 deletions(-)
>> changelog:
>> v2: converted some exit() calls to assertions.
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 774499d34f..c78bf6a56f 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, =
qemu_irq irq, int gsi)
>>      g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
>>  }
>>  -static void do_kvm_irqchip_create(KVMState *s)
>> +static int do_kvm_irqchip_create(KVMState *s)
>>  {
>>      int ret;
>>      if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
>> @@ -2587,36 +2587,38 @@ static void do_kvm_irqchip_create(KVMState =
*s)
>>              exit(1);
>>          }
>>      } else {
>> -        return;
>> +        /*
>> +         * neither KVM_CAP_IRQCHIP nor KVM_CAP_S390_IRQCHIP =
capabilities are
>> +         * present. Bail.
>> +         */
>> +        return -EOPNOTSUPP;
>>      }
>>  -    if (kvm_check_extension(s, KVM_CAP_IRQFD) <=3D 0) {
>> -        fprintf(stderr, "kvm: irqfd not implemented\n");
>> -        exit(1);
>> -    }
>> +    assert(kvm_check_extension(s, KVM_CAP_IRQFD));
>=20
> again changing behaviour ?
> previously it was doing exit(1) on returning non-zero.

Non-zero is the success case. It was doing exit() for returning <=3D0  =
case

> if (kvm_check_extension(s, KVM_CAP_IRQFD) <=3D 0)


> Now, it will assert on returning zero ?
> May be split the patch to keep the exit -> assert changes separate ?
>=20
>>        /* First probe and see if there's a arch-specific hook to =
create the
>>       * in-kernel irqchip for us */
>>      ret =3D kvm_arch_irqchip_create(s);
>>      if (ret =3D=3D 0) {
>> -        if (s->kernel_irqchip_split =3D=3D ON_OFF_AUTO_ON) {
>> -            error_report("Split IRQ chip mode not supported.");
>> -            exit(1);
>> -        } else {
>> -            ret =3D kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
>> -        }
>> +        /* assert that split IRQ chip mode is supported. */
>> +        assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_ON);
>> +        ret =3D kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
>>      }
>>      if (ret < 0) {
>>          fprintf(stderr, "Create kernel irqchip failed: %s\n", =
strerror(-ret));
>>          exit(1);
>>      }
>> +
>> +    return 0;
>>  }
>>    static void kvm_irqchip_create(KVMState *s)
>>  {
>>      assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_AUTO);
>>  -    do_kvm_irqchip_create(s);
>> +    if (do_kvm_irqchip_create(s) < 0) {
>> +        return;
>> +    }
>>      kvm_kernel_irqchip =3D true;
>>      /* If we have an in-kernel IRQ chip then we must have =
asynchronous
>>       * interrupt delivery (though the reverse is not necessarily =
true)
>> @@ -2835,6 +2837,7 @@ static int kvm_reset_vmfd(MachineState *ms)
>>      }
>>        if (s->kernel_irqchip_allowed) {
>> +        /* ignore return from this function */
>>          do_kvm_irqchip_create(s);
>>      }
>> =20
>=20


