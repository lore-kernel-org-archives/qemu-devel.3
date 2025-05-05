Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2C4C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 06:50:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBpeV-0007MQ-2b; Mon, 05 May 2025 02:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uBpeS-0007Le-KS
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:50:09 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uBpeQ-00083k-Lv
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:50:08 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-736ab1c43c4so4039325b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 23:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746427804; x=1747032604; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yefj2KpkBmSVClien34v9/hlgXmoyJU189K/5lXPkGo=;
 b=nRoOCQOG+fDjTDGhqNHMiphet+PHUaBmjOQ+IrV+sUyELcqMNv1U2QQk+2sTbs6Kjv
 43EpnkPqRnCBwC1GVDrZ7Q4dlxG263SXKW7ZqI+i3YwXWU1MuHK5oPpj8Q2ky+Tm3eK/
 4Q1Kwjk16tqPA2mYPpVxCwkUTdynE81ffdnQSvNnoOABWywcABjmq3l3aKJtJ7HNE6vD
 t0PVgffh/NMzz/O199lwWYgJ4lmO/RQ6V2klBBRSOKOOPHP7aOLe5v0sYw73DRDQ4Rl4
 nvNTngNDdFqRRWn3ImW+ydDK3Zg940tq7Te3ET7ua4KdgziPZsLNXsqJN3XqHQNZ1eK1
 l3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746427804; x=1747032604;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Yefj2KpkBmSVClien34v9/hlgXmoyJU189K/5lXPkGo=;
 b=O1/JfvWC1lOvHRT3BgPqeiEEtIBZ44GRBDazOQNwPZcD1WhGnd1SZAmpjNQZFJDzn4
 Mu7WcOqkHe1PbxhhX3VYWJp3zxkyYkszU94Epdq3cQiTfZGWKLXrZnSmzCIiOMn7Ci99
 dKlrwreNOLctFuZVRLbsRvn5259XDDJ37AgWEDNBY0SleV8nyh5HNF35ll7EWhkINtE9
 YCG/5k+xSBLJpsmVZFW+3nR2OObyWDuqXtOjgIPilqzu5JvUdHLjFmR3EmR/a+XjYgLK
 1/rY7q64EPGnLwc2ce/PQgIasrLQoP9SqmbktuCUIHd0jdp3Q0iCx08e9r2xywC4x7yK
 vSpw==
X-Gm-Message-State: AOJu0Ywq2Ck7wQb6+bGoqEqvL9UFnj439Pbjx0h7BLcvPRZFiDXjoK26
 ERcrXiAsTpSLQlRM75VFEeEYBflX4I9Hd8EG0/zj1/p0XPIcAm32
X-Gm-Gg: ASbGnctOw5cHSrqXNV8UxSHB20hGoJX8vxWHP/AQBNe0QdrkBNN7ZVMFQFtOvgr0L7q
 QSww81j+xOtpRaUoghMnZEMXIlBoQt9HdtO2CAbl4lfvCC8ptEQxHq4dBHqVc0oeBvLSeSt/awh
 KZX/UZjDLlvH99ulMeQc7qriLF3uufK3QxxdLc0gFfU0eNnhVEjhFSQlhF/AerLSE/tQtnmDEyl
 pnbMmZJ+NrjBJjh1IoMaocCqFKm26rj60+1F4eOrVJAJAHtKQLgUwDF9CSATmHAlgvOPzisSSJw
 adeodXEsqFIre+F7hcRCNJ1tKZalxB2O
X-Google-Smtp-Source: AGHT+IGUmts1uQ3M08SPkwTgQL+zn7QuUFZ0wN/y8kpDUovWC63qD9H4a2534jElRzrUzRzR/8oL4g==
X-Received: by 2002:a05:6a00:4485:b0:73e:598:7e5b with SMTP id
 d2e1a72fcca58-7406f07fa48mr7582681b3a.1.1746427804177; 
 Sun, 04 May 2025 23:50:04 -0700 (PDT)
Received: from localhost ([1.146.78.151]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058d7ada5sm6023976b3a.20.2025.05.04.23.49.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 23:50:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 May 2025 16:49:57 +1000
Message-Id: <D9O0ZI8EP5J8.2RYFER9KJ3IA5@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Dmitry Fleytman" <dmitry.fleytman@gmail.com>,
 "Jason Wang" <jasowang@redhat.com>, "Sriram Yagnaraman"
 <sriram.yagnaraman@ericsson.com>, "Fabiano Rosas" <farosas@suse.de>,
 "Laurent Vivier" <lvivier@redhat.com>, "Paolo Bonzini"
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 11/12] net/e1000e|igb: Fix interrupt throttling rearming
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Akihiko Odaki" <akihiko.odaki@daynix.com>
X-Mailer: aerc 0.19.0
References: <20250502031705.100768-1-npiggin@gmail.com>
 <20250502031705.100768-12-npiggin@gmail.com>
 <57c9b65a-bfdf-47e6-a438-6559f791f7dd@daynix.com>
In-Reply-To: <57c9b65a-bfdf-47e6-a438-6559f791f7dd@daynix.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon May 5, 2025 at 4:03 PM AEST, Akihiko Odaki wrote:
> On 2025/05/02 12:17, Nicholas Piggin wrote:
>> Timer expiry that results in an interrupt does not rearm the timer so
>> an interrupt can appear immediately after the interrupt generated by
>> timer expiry.
>>=20
>> Fix this by rearming the throttle timer when a delayed interrupt is
>> processed. e1000e gets this by reusing the e1000e_msix_notify()
>> logic, igb calls igb_intrmgr_rearm_timer() directly.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   hw/net/e1000e_core.c |  5 ++--
>>   hw/net/igb_core.c    | 55 ++++++++++++++++++++++++++------------------
>>   2 files changed, 35 insertions(+), 25 deletions(-)
>>=20
>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>> index d53f70065ef..2932122c04b 100644
>> --- a/hw/net/e1000e_core.c
>> +++ b/hw/net/e1000e_core.c
>> @@ -218,7 +218,7 @@ static uint32_t find_msix_causes(E1000ECore *core, i=
nt vec)
>>   }
>>  =20
>>   static void
>> -e1000e_msix_auto_clear_mask(E1000ECore *core, uint32_t cause);
>> +e1000e_msix_notify(E1000ECore *core, uint32_t causes);
>>  =20
>>   static void
>>   e1000e_intrmgr_on_msix_throttling_timer(void *opaque)
>> @@ -233,8 +233,7 @@ e1000e_intrmgr_on_msix_throttling_timer(void *opaque=
)
>>       causes =3D find_msix_causes(core, idx) & core->mac[IMS] & core->ma=
c[ICR];
>>       if (causes) {
>>           trace_e1000e_irq_msix_notify_postponed_vec(idx);
>> -        msix_notify(core->owner, causes);
>> -        e1000e_msix_auto_clear_mask(core, causes);
>> +        e1000e_msix_notify(core, causes);
>>       }
>>   }
>>  =20
>> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
>> index 035637f81f8..cc25a1d5baa 100644
>> --- a/hw/net/igb_core.c
>> +++ b/hw/net/igb_core.c
>> @@ -152,11 +152,14 @@ igb_intrmgr_arm_timer(IGBIntrDelayTimer *timer, in=
t64_t delay_ns)
>>   static inline void
>>   igb_intrmgr_rearm_timer(IGBIntrDelayTimer *timer)
>>   {
>> -    uint32_t interval =3D (timer->core->mac[timer->delay_reg] &
>> -                         E1000_EITR_INTERVAL) >> 2;
>> -    int64_t delay_ns =3D (int64_t)interval * timer->delay_resolution_ns=
;
>> +    uint32_t eitr =3D timer->core->mac[timer->delay_reg];
>>  =20
>> -    igb_intrmgr_arm_timer(timer, delay_ns);
>> +    if (eitr !=3D 0) {
>> +        uint32_t interval =3D (eitr & E1000_EITR_INTERVAL) >> 2;
>> +        int64_t delay_ns =3D (int64_t)interval * timer->delay_resolutio=
n_ns;
>> +
>> +        igb_intrmgr_arm_timer(timer, delay_ns);
>> +    }
>>   }
>>  =20
>>   static void
>> @@ -168,21 +171,7 @@ igb_intmgr_timer_resume(IGBIntrDelayTimer *timer)
>>   }
>>  =20
>>   static void
>> -igb_intrmgr_on_msix_throttling_timer(void *opaque)
>> -{
>> -    IGBIntrDelayTimer *timer =3D opaque;
>> -    IGBCore *core =3D timer->core;
>> -    int vector =3D timer - &core->eitr[0];
>> -    uint32_t causes;
>> -
>> -    timer->running =3D false;
>> -
>> -    causes =3D core->mac[EICR] & core->mac[EIMS];
>> -    if (causes & BIT(vector)) {
>> -        trace_e1000e_irq_msix_notify_postponed_vec(vector);
>> -        igb_msix_notify(core, vector);
>> -    }
>> -}
>> +igb_intrmgr_on_msix_throttling_timer(void *opaque);
>>  =20
>>   static void
>>   igb_intrmgr_initialize_all_timers(IGBCore *core, bool create)
>> @@ -2258,9 +2247,7 @@ igb_postpone_interrupt(IGBIntrDelayTimer *timer)
>>           return true;
>>       }
>>  =20
>> -    if (timer->core->mac[timer->delay_reg] !=3D 0) {
>> -        igb_intrmgr_rearm_timer(timer);
>> -    }
>> +    igb_intrmgr_rearm_timer(timer);
>>  =20
>>       return false;
>>   }
>> @@ -2284,6 +2271,30 @@ static void igb_send_msix(IGBCore *core, uint32_t=
 causes)
>>       }
>>   }
>>  =20
>> +static void
>> +igb_intrmgr_on_msix_throttling_timer(void *opaque)
>> +{
>> +    IGBIntrDelayTimer *timer =3D opaque;
>> +    IGBCore *core =3D timer->core;
>> +    int vector =3D timer - &core->eitr[0];
>> +    uint32_t causes;
>> +
>> +    timer->running =3D false;
>> +
>> +    causes =3D core->mac[EICR] & core->mac[EIMS];
>> +    if (causes & BIT(vector)) {
>> +        /*
>> +         * The moderation counter is loaded with interval value wheneve=
r the
>> +         * interrupt is signaled. This includes when the interrupt is s=
ignaled
>> +         * by the counter reaching 0.
>> +         */
>> +        igb_intrmgr_rearm_timer(timer);
>> +
>> +        trace_e1000e_irq_msix_notify_postponed_vec(vector);
>> +        igb_msix_notify(core, vector);
>> +    }
>> +}
>> +
>
> I wonder why the definition is moved. This patch adds a=20
> igb_intrmgr_rearm_timer() call but it's already placed earlier than this=
=20
> function.

Hmm, I did require moving it at one point, but I must have reworked it
enough to avoid it. That makes the patch smaller and nicer. Another
good catch.

Thanks,
Nick

