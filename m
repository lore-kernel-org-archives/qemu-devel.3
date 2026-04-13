Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6544AF34C4B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 12:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCGOT-0005W9-7A; Mon, 13 Apr 2026 08:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCGOR-0005Vi-JK
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCGON-0002Fb-NZ
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776083269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bRKspQPq8OXUc15a9NtnUtQGzjqGHbd9RQrfqxefTaQ=;
 b=XMa3l78bUIqUS7UKtD3BSSaO0DE7QG2A0BoXpfAzaUfJef6anzmvxfo+QLiDXhbuFwWXC8
 nwr5uvTRB8I5+RaSl1sjwDZ3JdodCwtbG6Gx6cygDQpfw26FMKS7pCZE4vMiCXTzhmZdqN
 4mm2OS1AnQCkLASyj8Y6sbCrtSyYjQ4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-zsgMbkZoOQmi5nKgxtIfYQ-1; Mon, 13 Apr 2026 08:27:46 -0400
X-MC-Unique: zsgMbkZoOQmi5nKgxtIfYQ-1
X-Mimecast-MFC-AGG-ID: zsgMbkZoOQmi5nKgxtIfYQ_1776083265
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3568090851aso9639696a91.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 05:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776083265; x=1776688065; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bRKspQPq8OXUc15a9NtnUtQGzjqGHbd9RQrfqxefTaQ=;
 b=fOc1OBaja/zLsW4/HWumzRG8Wjd/9OdhVdU2AqBiFOD9fdodpUJGEa1TzyF6niHXlM
 pyWppJrki7QmYRIAvCFTf/s/0YYfHCH6ovMw7jSZANVJaLxZfDkc2+ASUa4r9RU0DhEC
 F+6qv6DBmG0IqxfoSWVo+wDhqFR/pe6IjB5/t7LwxzBgB7gDwBvcdkO3xDe38h/zjKWS
 171aSl/xeQ7IaWdOvdmPXwE8uANTSiRV0kD9uGHFgCe56jG3F+82zNAckAgN2xV27fNh
 cNeqF2AS16WNxwy2Wyszs+B5kXfVAdQlsyfabMLnJTVTBlL1oO8Gw1WzdQKK4zwfSchZ
 DClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776083265; x=1776688065;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bRKspQPq8OXUc15a9NtnUtQGzjqGHbd9RQrfqxefTaQ=;
 b=QPjzOgie0Fn3rq+/zajvw8nVurXu/nSY5xgRkx1tFq9FNVstriA/+eXih5Dgt1pE2i
 qtWAbTXJZH2WAGCvVl1xy6W0zFF0gkdERPF0QKoc8UQKlON3ake/wU4nwTiEVAYnKWXp
 7YHnqTpXsTjR3x98I2dZot+bXpzCRkMXoXQaLTBwuRfY5p6Z9WHTV5EY/PerdOTJKXBN
 68f2eCaK5U9RoGiwTLNdzvHJ7da1qPWkx4pQ1QDm7h/6bohm3z6ZdLwxYe9G+P4LrgMU
 2O89k+93tDPnWHOskdXLqBcPhEspcqxuMTGbwbjwTY89PDuB9z/tPPZSNUvJuX1lxL0S
 Z3AA==
X-Forwarded-Encrypted: i=1;
 AFNElJ87sgFfzF5XJ8XJcexMy3ZMevmT9KYk/snv7v50rT7bx94gsifOrW8sGoGLthrMsjtTC/DV1FF6ghgx@nongnu.org
X-Gm-Message-State: AOJu0YwTu9jY3yC3E275S0ujfyGGZJ3eFXqwox9SalRXB4vt1c4m7rs+
 D5/CVigqKNhAvL9RnekEwlnnyDnRqlVIFXjOeqh96ZY4f2JgsVEH2AkydRBPuCG9YLWkXy0kkWs
 2+B2HjRzJJhZgvAsyWAVwWMHMoDqJ3nM7Ff+iaLGiLZ8qxi0C/DvWxosr
X-Gm-Gg: AeBDievCwbWjdwB7ocnm9Z9aziKSGAzlAUv9C9A2r9TayX5WjF5hb0LO6QkEfu2n2vx
 se8Nfnw6mIeW14qZV35YcsbMpCDiXCPMWC+4H5O++zERJRVnX+mLOiw9lT1uwsLDBBWMAbyMp/v
 BFN49Tm2Hq61Q+WGsEG0u8ibqyWHWZUMrjL1yEENKSrcjZl36DWAZPLH6Z++OTOocNTOtVfpd97
 uUHmz7rQfuAE9+bn29iGIB6jQrHFDuu6u/XRXjh2U+P/2KaaCPiSD77H8lKPf94yF1q2VbBQlpt
 xr4ouyLVQiAt+Y9j2xpkeKmBdfzyUNlAe7V9X2gszrkEzlOBrujSv0U9zzgfwd/gizevX+WagVl
 lDNTcmvBrhHSaLBcT+oZiJ33cBZB4km32MClbfFB5lFkPkzZfR8VRSSn6ArL4ugu7IfZMm0m0QY
 o=
X-Received: by 2002:a05:6a20:2455:b0:394:56ae:8a7f with SMTP id
 adf61e73a8af0-39fe40027cemr14040396637.42.1776083264990; 
 Mon, 13 Apr 2026 05:27:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:2455:b0:394:56ae:8a7f with SMTP id
 adf61e73a8af0-39fe40027cemr14040359637.42.1776083264478; 
 Mon, 13 Apr 2026 05:27:44 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79219c618asm10117963a12.18.2026.04.13.05.27.41
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2026 05:27:44 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH V2 for-11.0] accel/kvm: return early from
 kvm_irqchip_create if kvm does not support irqchip
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <980AC83F-DD93-4924-8935-11CBFD624ACE@redhat.com>
Date: Mon, 13 Apr 2026 17:57:29 +0530
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 kvm@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F0A82F77-6F25-4193-88D0-01B24B1459AE@redhat.com>
References: <20260413112151.61261-1-anisinha@redhat.com>
 <0954ef7e-b04e-4542-89fb-796acc452068@linux.ibm.com>
 <980AC83F-DD93-4924-8935-11CBFD624ACE@redhat.com>
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



> On 13 Apr 2026, at 5:45=E2=80=AFPM, Ani Sinha <anisinha@redhat.com> =
wrote:
>=20
>=20
>=20
>> On 13 Apr 2026, at 5:06=E2=80=AFPM, Harsh Prateek Bora =
<harshpb@linux.ibm.com> wrote:
>>=20
>>=20
>>=20
>> On 13/04/26 4:51 pm, Ani Sinha wrote:
>>> During refactoring of kvm_irqchip_create(), the refactored code was =
returning
>>> early from do_kvm_irqchip_create() function if the required =
capabilities were
>>> not present in KVM. This was not translating to an early return from
>>> kvm_irqchip_create() as was the case before refactoring. This is =
because,
>>> do_kvm_irqchip_create() did not have a means to notify the caller of =
the lack
>>> of kvm capabilities. Fix this by making do_notify_irqchip_create() =
return
>>> EOPNOTSUPP error when required capabilities are absent and then the =
caller
>>> can check the return code and return early.
>>> Converted some calls to exit() to assertion checks in order to make =
it cleaner.
>>> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM =
VM file descriptor change")
>>> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
>>> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
>>> Suggested-by: Fabiano Rosas <farosas@suse.de>
>>> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>> accel/kvm/kvm-all.c | 29 ++++++++++++++++-------------
>>> 1 file changed, 16 insertions(+), 13 deletions(-)
>>> changelog:
>>> v2: converted some exit() calls to assertions.
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index 774499d34f..c78bf6a56f 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, =
qemu_irq irq, int gsi)
>>>     g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
>>> }
>>> -static void do_kvm_irqchip_create(KVMState *s)
>>> +static int do_kvm_irqchip_create(KVMState *s)
>>> {
>>>     int ret;
>>>     if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
>>> @@ -2587,36 +2587,38 @@ static void do_kvm_irqchip_create(KVMState =
*s)
>>>             exit(1);
>>>         }
>>>     } else {
>>> -        return;
>>> +        /*
>>> +         * neither KVM_CAP_IRQCHIP nor KVM_CAP_S390_IRQCHIP =
capabilities are
>>> +         * present. Bail.
>>> +         */
>>> +        return -EOPNOTSUPP;
>>>     }
>>> -    if (kvm_check_extension(s, KVM_CAP_IRQFD) <=3D 0) {
>>> -        fprintf(stderr, "kvm: irqfd not implemented\n");
>>> -        exit(1);
>>> -    }
>>> +    assert(kvm_check_extension(s, KVM_CAP_IRQFD));
>>=20
>> again changing behaviour ?
>> previously it was doing exit(1) on returning non-zero.
>=20
> Non-zero is the success case. It was doing exit() for returning <=3D0  =
case
>=20
>> if (kvm_check_extension(s, KVM_CAP_IRQFD) <=3D 0)

Actually maybe I should make this clearer

int kvm_check_extension(KVMState *s, unsaigned int extension)            =
                                                            =20
{                                                                        =
                                                           =20
    int ret;                                                             =
                                                           =20
                                                                         =
                                                           =20
    ret =3D kvm_ioctl(s, KVM_CHECK_EXTENSION, extension);                =
                                                             =20
    if (ret < 0) {                                                       =
                                                           =20
        ret =3D 0;                                                       =
                                                             =20
    }                                                                    =
                                                           =20
                                                                         =
                                                           =20
    return ret;                                                          =
                                                           =20
}                      =20

So non-zero positive value is success. 0 is unsupported. Also see =
https://docs.kernel.org/virt/kvm/api.html#kvm-check-extension
So asserting on non-zero is fine.

>=20
>=20
>> Now, it will assert on returning zero ?
>> May be split the patch to keep the exit -> assert changes separate ?
>>=20
>>>       /* First probe and see if there's a arch-specific hook to =
create the
>>>      * in-kernel irqchip for us */
>>>     ret =3D kvm_arch_irqchip_create(s);
>>>     if (ret =3D=3D 0) {
>>> -        if (s->kernel_irqchip_split =3D=3D ON_OFF_AUTO_ON) {
>>> -            error_report("Split IRQ chip mode not supported.");
>>> -            exit(1);
>>> -        } else {
>>> -            ret =3D kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
>>> -        }
>>> +        /* assert that split IRQ chip mode is supported. */
>>> +        assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_ON);
>>> +        ret =3D kvm_vm_ioctl(s, KVM_CREATE_IRQCHIP);
>>>     }
>>>     if (ret < 0) {
>>>         fprintf(stderr, "Create kernel irqchip failed: %s\n", =
strerror(-ret));
>>>         exit(1);
>>>     }
>>> +
>>> +    return 0;
>>> }
>>>   static void kvm_irqchip_create(KVMState *s)
>>> {
>>>     assert(s->kernel_irqchip_split !=3D ON_OFF_AUTO_AUTO);
>>> -    do_kvm_irqchip_create(s);
>>> +    if (do_kvm_irqchip_create(s) < 0) {
>>> +        return;
>>> +    }
>>>     kvm_kernel_irqchip =3D true;
>>>     /* If we have an in-kernel IRQ chip then we must have =
asynchronous
>>>      * interrupt delivery (though the reverse is not necessarily =
true)
>>> @@ -2835,6 +2837,7 @@ static int kvm_reset_vmfd(MachineState *ms)
>>>     }
>>>       if (s->kernel_irqchip_allowed) {
>>> +        /* ignore return from this function */
>>>         do_kvm_irqchip_create(s);
>>>     }



