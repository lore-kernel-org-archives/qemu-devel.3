Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C427F34C4B
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 12:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCGEw-0003Vv-Jn; Mon, 13 Apr 2026 08:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCGEv-0003VZ-4N
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1wCGEt-00083D-CE
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776082682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LhKCTcy5AyOM+riI26AKG81BxmHLAlWGjC1qrqkMIsk=;
 b=Z7QFQZ6aY9O0PNwAOj2YPiEp27Iap+mbLxlJIqnGLotAw7IgXemuRoCMrtJT1VVJZcvqzE
 9v3Dc/FO0jida2kj2kx7NsG2Hp4oqSzWHduSLKy+KPZcwZy0SnM8ybwyE9vLTJEtpqOu1M
 o011uFz3bHFXJpZ97eLoQC44zcMOSIw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-BieYjCDENUmFBdvywba5kg-1; Mon, 13 Apr 2026 08:18:01 -0400
X-MC-Unique: BieYjCDENUmFBdvywba5kg-1
X-Mimecast-MFC-AGG-ID: BieYjCDENUmFBdvywba5kg_1776082680
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b258636d16so43461655ad.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 05:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776082680; x=1776687480; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LhKCTcy5AyOM+riI26AKG81BxmHLAlWGjC1qrqkMIsk=;
 b=q/sQ3tiA2HkvZa3LP5jKETvtzl/lMZp7xV6F8IjYYH7mQgGquuPeR8y5UuETXOSRX/
 +OuRbXYlj1zuHhtFuo04V28A+psrtJZFHVcYwUmyXdOb9I9KDIeDeWlFqy7/Ixh+cWDG
 iDBEsC2110YAQ25Tp7QzXp6JrtCAsEbqZftiyKANkcrf/blNluCKkf/aZY6dbyTPXpf6
 2FbsIXkbNgU1J4Gv6pxawOhc+N14E7tJ5eRuUvX7wFSdSg9rlowYgd69DXJA8EuPGwDK
 EdJjkWbgjDueqMbkQQ6wzVdaOmk+H8LhmNnO5mDf5m6rQiQcKjCEXul5aPsR28HobZ2P
 GYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776082680; x=1776687480;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LhKCTcy5AyOM+riI26AKG81BxmHLAlWGjC1qrqkMIsk=;
 b=tRz4wIH/bH+CdkcgYptuk+rbfgiTaUFXcdYBa+L2M8vnfcjyHsp9z6SiA/caRR/5FF
 vJ36Sth0SRgJH7VE3+dRco54wK7ZdYYpw1MvExo5o2ruSMsGQhpJdnYiENcaHLtITAze
 dAin0+Wyx88if4+xj7RmLrRgVBON5vcBpwYkdhKbPi/sYsqZIuNrtSysOgyao0UrHaz4
 vSHczMPTdzS/IhPsV+OxA01nXzaPIgQFZIQ7fLQ1WjtfD2tcyNaCme01l0zOUviry8e5
 uP4XY1BKXYA3j1/7IcH5Z7PYnTv0y6qNXiJw0LLianjlKMkxlT9P7mTuk/M3Sm/jHj9K
 968A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9uAsgcrBScaYMUxFylpv0Mg7hznCoy9o3jnvN4fSoV0ZjboraSCFO2XtIv4Sw0yvrmheDoKs1qTUbz@nongnu.org
X-Gm-Message-State: AOJu0YxHJOwkYMocJwI6Irqg470hCd4Z8KcoiSRmjVdfvblscSO2tgmG
 Whbc5GABGm/FeYR3g0dQPxkN5N6nDnDC9YDV+VRYP9g/xTlSKN+JPuwrkK4c9IVNA+yWpr63tpZ
 dK7GVsffZn/nGHJT3FxqA6ZGOGLqH7OzN7R4wHKCVu/I4IewRjA3swX24
X-Gm-Gg: AeBDiet2s7a6iePJgsZWgew0Ijs2Xc3KxG09b1Nc6GEzGbRL4WXyxwJhaqpvrN3AcBT
 blaqSWS/YqQdcVY4iVF9wtBN2C8YC/xFNqWm2OfQ+qzLjd8eBXxfWi654LksDhCjSVZMuj1OExG
 0vYLxd086uRaVO29L/r0RSLlJYj9U49ENrBPhEE0sWWdILc7WuY6MG8/ahOonxnsaEAYX8NwQRP
 Jf5lVmmUmtmkqVeu9mx0ewz2jkYwMw9rR5tDEQ8BQklpHXaOKWEfNPWmYZ7xQjvNAW4mdvWrLlt
 1ciPHNsZqJtrfD5wk3sy5Od611RqfDkEcvpWh2vmM3B11vTiNnjc2VTh4Wga/MQ+Q0ksArhmmmm
 E54jiDrGb2dz9kSVpS9otB4qWwYzeYxZOQUttuk3OXyp9OXRnXlXqWEZD0K09opGvvPvm25cB9K
 E=
X-Received: by 2002:a17:903:144e:b0:2b2:58c7:2ce1 with SMTP id
 d9443c01a7336-2b2d5a7773emr130760285ad.36.1776082679515; 
 Mon, 13 Apr 2026 05:17:59 -0700 (PDT)
X-Received: by 2002:a17:903:144e:b0:2b2:58c7:2ce1 with SMTP id
 d9443c01a7336-2b2d5a7773emr130759795ad.36.1776082678793; 
 Mon, 13 Apr 2026 05:17:58 -0700 (PDT)
Received: from smtpclient.apple ([122.163.114.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b45cbf11b1sm37595655ad.17.2026.04.13.05.17.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 13 Apr 2026 05:17:58 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH V2 for-11.0] accel/kvm: return early from
 kvm_irqchip_create if kvm does not support irqchip
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CAFEAcA8wJY6o3x1HNZrPu-=JG0Jyu_gJ+SKpcLHwHXvz+ZDGDQ@mail.gmail.com>
Date: Mon, 13 Apr 2026 17:47:43 +0530
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 kvm@vger.kernel.org, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <212B6DEC-AD6C-4727-8F43-10EFB1836A68@redhat.com>
References: <20260413112151.61261-1-anisinha@redhat.com>
 <0954ef7e-b04e-4542-89fb-796acc452068@linux.ibm.com>
 <CAFEAcA8wJY6o3x1HNZrPu-=JG0Jyu_gJ+SKpcLHwHXvz+ZDGDQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.500.181)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 13 Apr 2026, at 5:31=E2=80=AFPM, Peter Maydell =
<peter.maydell@linaro.org> wrote:
>=20
> On Mon, 13 Apr 2026 at 12:37, Harsh Prateek Bora =
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
>>>=20
>>> Converted some calls to exit() to assertion checks in order to make =
it cleaner.
>>>=20
>>> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM =
VM file descriptor change")
>>> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
>>> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
>>> Suggested-by: Fabiano Rosas <farosas@suse.de>
>>> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>>  accel/kvm/kvm-all.c | 29 ++++++++++++++++-------------
>>>  1 file changed, 16 insertions(+), 13 deletions(-)
>>>=20
>>> changelog:
>>> v2: converted some exit() calls to assertions.
>>>=20
>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>> index 774499d34f..c78bf6a56f 100644
>>> --- a/accel/kvm/kvm-all.c
>>> +++ b/accel/kvm/kvm-all.c
>>> @@ -2575,7 +2575,7 @@ void kvm_irqchip_set_qemuirq_gsi(KVMState *s, =
qemu_irq irq, int gsi)
>>>      g_hash_table_insert(s->gsimap, irq, GINT_TO_POINTER(gsi));
>>>  }
>>>=20
>>> -static void do_kvm_irqchip_create(KVMState *s)
>>> +static int do_kvm_irqchip_create(KVMState *s)
>>>  {
>>>      int ret;
>>>      if (kvm_check_extension(s, KVM_CAP_IRQCHIP)) {
>>> @@ -2587,36 +2587,38 @@ static void do_kvm_irqchip_create(KVMState =
*s)
>>>              exit(1);
>>>          }
>>>      } else {
>>> -        return;
>>> +        /*
>>> +         * neither KVM_CAP_IRQCHIP nor KVM_CAP_S390_IRQCHIP =
capabilities are
>>> +         * present. Bail.
>>> +         */
>>> +        return -EOPNOTSUPP;
>>>      }
>>>=20
>>> -    if (kvm_check_extension(s, KVM_CAP_IRQFD) <=3D 0) {
>>> -        fprintf(stderr, "kvm: irqfd not implemented\n");
>>> -        exit(1);
>>> -    }
>>> +    assert(kvm_check_extension(s, KVM_CAP_IRQFD));
>>=20
>> again changing behaviour ?
>> previously it was doing exit(1) on returning non-zero.
>> Now, it will assert on returning zero ?
>> May be split the patch to keep the exit -> assert changes separate ?
>=20
> I think for 11.0 it's probably best to do the minimum necessary
> change to fix the logic error introduced by 98884e0cc1. For
> that I think the v1 of this patch is OK.

Agreed.

>=20
> There do seem to be some cleanup opportunities that we
> have here, but we can do those in 11.1.

cool.

>=20
> -- PMM



