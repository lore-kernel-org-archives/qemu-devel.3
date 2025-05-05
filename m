Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE949C369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 06:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBpTs-00026z-Ow; Mon, 05 May 2025 02:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uBpTg-00026M-P6
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:39:01 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uBpTd-0006hV-Bi
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:38:59 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2260c91576aso35060585ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 23:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746427136; x=1747031936; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsrngxiFf9ibjNCxiEKOY70/6BS7Zre24Kh2AW1+M+U=;
 b=MTfc0H0XqXYwEXYvMf1045vIXel4zHPd+9KLn40vo2Qw623nupeu/CNFDnEVZlLl2l
 9tqCdB4opk4MzhA5oE/0LTxqTvkdbC9LKGrj/cmL3zJpSoRNWvsiF5g+psE+lpWnqQod
 PPL628N1jg1ATJMSePGG7PK57rQihy+ULXZ4JXRQXGb9qfyd6wHcqoIOvz0Qp+6V3Jia
 f487tDMCD/PIQu99fJ+M8DRibOKiICrw1NYrW+HWTVHd5i3IRgXYv6gYjMf8FbNHMUx3
 w8REz/8owTD6LUrbs6FnpiFrkMKRp1w6u6t46P8vgM06UytWRA/3P3ieHYXNPfxEWqud
 fZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746427136; x=1747031936;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AsrngxiFf9ibjNCxiEKOY70/6BS7Zre24Kh2AW1+M+U=;
 b=fFuWiiOrHYpfpbPuxOkEACBkzx57aFFTpihsUmxbsReAeFudYUq/uaufP3ts/qeE+A
 45xMPX3sgKHOxbpgnH1vEK/I42XfhNfqW6WIuVW1ieecbV/2L7nJKrIIdxAEcFd2ZAqT
 NfAR3KdhZe2juugxrMdyZcBk/WHHvBCLt0t/78or6wV/+1Yo0ipMf1di64GUijHaHQsn
 nRgv83Ng58pv9r//JDoYudnWiRetXszc2vMJM35MJiZg5rwDAzLGdFLA2NaZxJioMHRH
 gluhUSIuNQ3iXxntbDsAOVBuYBk66go139yCE6ivC6e5+oORGu4432xWKvmBhpm991v8
 kefg==
X-Gm-Message-State: AOJu0YxTlro3HKaQtbILlOVuAHxjGdcrDkceWVjUXJo3LZkXutTeALZ1
 axuwH0RPD8bvIX7ilMuKkml+QYQkip7etPHlWypbtdFMHwH3i1BK
X-Gm-Gg: ASbGncvHHKnqGlWqGN6xhy1Fpo+Jjalw1hi5/G+0iPyMoQvHkkp4XNJh4vHm5zEqptm
 BatJkOAyTjkRxTy2EXLftG/7ZoL5dpELSqKfHaYZdm2+lcYa5wCjhriZ8ZtCA9WViPEniOspJge
 tjz86eOUjFPdaY+tYAMSYbf+aLDL9WiFFE2Qm/5eyOC+dPHEwTqHaun5NaoFkaw3mR8LT29ZVR8
 V7chmFpMfIKGG6K/e3CKLQqyxG92QpSwtDGQCaqZw1OolNitB/uhex2XOCIX4gAnUIn50c0kBP5
 EFvpFzKt9I2+BRMLNEGU+3nxNLRhBVW9
X-Google-Smtp-Source: AGHT+IEdngKXFn8LKPeGjXVwkEOht7C5qSXaYvFB0JgcrZaYqk9iIanCQqdLaHilMiYWszcrekVexA==
X-Received: by 2002:a17:902:c408:b0:223:54e5:bf4b with SMTP id
 d9443c01a7336-22e1ea7f87emr95442615ad.25.1746427135725; 
 Sun, 04 May 2025 23:38:55 -0700 (PDT)
Received: from localhost ([1.146.78.151]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151e9785sm47449495ad.65.2025.05.04.23.38.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 23:38:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 May 2025 16:38:48 +1000
Message-Id: <D9O0QYZ74D10.1V6WWHTCKP2NN@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Dmitry Fleytman" <dmitry.fleytman@gmail.com>,
 "Jason Wang" <jasowang@redhat.com>, "Sriram Yagnaraman"
 <sriram.yagnaraman@ericsson.com>, "Fabiano Rosas" <farosas@suse.de>,
 "Laurent Vivier" <lvivier@redhat.com>, "Paolo Bonzini"
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 03/12] hw/net/e1000e|igb: Remove xitr_guest_value logic
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Akihiko Odaki" <akihiko.odaki@daynix.com>
X-Mailer: aerc 0.19.0
References: <20250502031705.100768-1-npiggin@gmail.com>
 <20250502031705.100768-4-npiggin@gmail.com>
 <5576bcff-aa0a-44b7-a3e2-bc2389f9ffaf@daynix.com>
In-Reply-To: <5576bcff-aa0a-44b7-a3e2-bc2389f9ffaf@daynix.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

On Mon May 5, 2025 at 3:45 PM AEST, Akihiko Odaki wrote:
> On 2025/05/02 12:16, Nicholas Piggin wrote:
>> The guest value xITR logic is not required now that the write functions
>> store necessary data to be read back, and internal users mask and shift
>> fields they need as they go.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   hw/net/e1000e_core.c | 31 +++++++++++++++----------------
>>   hw/net/igb_core.c    | 16 +++++++++++++---
>>   2 files changed, 28 insertions(+), 19 deletions(-)
>>=20
>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>> index 96f74f1ea14..f8e6522f810 100644
>> --- a/hw/net/e1000e_core.c
>> +++ b/hw/net/e1000e_core.c
>> @@ -2563,18 +2563,6 @@ e1000e_mac_swsm_read(E1000ECore *core, int index)
>>       return val;
>>   }
>>  =20
>> -static uint32_t
>> -e1000e_mac_itr_read(E1000ECore *core, int index)
>> -{
>> -    return core->itr_guest_value;
>> -}
>> -
>> -static uint32_t
>> -e1000e_mac_eitr_read(E1000ECore *core, int index)
>> -{
>> -    return core->eitr_guest_value[index - EITR];
>> -}
>> -
>>   static uint32_t
>>   e1000e_mac_icr_read(E1000ECore *core, int index)
>>   {
>> @@ -2792,7 +2780,6 @@ e1000e_set_itr(E1000ECore *core, int index, uint32=
_t val)
>>  =20
>>       trace_e1000e_irq_itr_set(val);
>>  =20
>> -    core->itr_guest_value =3D interval;
>>       core->mac[index] =3D interval;
>>   }
>>  =20
>> @@ -2804,7 +2791,6 @@ e1000e_set_eitr(E1000ECore *core, int index, uint3=
2_t val)
>>  =20
>>       trace_e1000e_irq_eitr_set(eitr_num, val);
>>  =20
>> -    core->eitr_guest_value[eitr_num] =3D interval;
>>       core->mac[index] =3D interval;
>>   }
>>  =20
>> @@ -3029,6 +3015,7 @@ static const readops e1000e_macreg_readops[] =3D {
>>       e1000e_getreg(GSCN_1),
>>       e1000e_getreg(FCAL),
>>       e1000e_getreg(FLSWCNT),
>> +    e1000e_getreg(ITR),
>>  =20
>>       [TOTH]    =3D e1000e_mac_read_clr8,
>>       [GOTCH]   =3D e1000e_mac_read_clr8,
>> @@ -3062,7 +3049,6 @@ static const readops e1000e_macreg_readops[] =3D {
>>       [MPRC]    =3D e1000e_mac_read_clr4,
>>       [BPTC]    =3D e1000e_mac_read_clr4,
>>       [TSCTC]   =3D e1000e_mac_read_clr4,
>> -    [ITR]     =3D e1000e_mac_itr_read,
>>       [CTRL]    =3D e1000e_get_ctrl,
>>       [TARC1]   =3D e1000e_get_tarc,
>>       [SWSM]    =3D e1000e_mac_swsm_read,
>> @@ -3087,7 +3073,7 @@ static const readops e1000e_macreg_readops[] =3D {
>>       [RETA ... RETA + 31]   =3D e1000e_mac_readreg,
>>       [RSSRK ... RSSRK + 31] =3D e1000e_mac_readreg,
>>       [MAVTV0 ... MAVTV3]    =3D e1000e_mac_readreg,
>> -    [EITR...EITR + E1000E_MSIX_VEC_NUM - 1] =3D e1000e_mac_eitr_read
>> +    [EITR...EITR + E1000E_MSIX_VEC_NUM - 1] =3D e1000e_mac_readreg,
>>   };
>>   enum { E1000E_NREADOPS =3D ARRAY_SIZE(e1000e_macreg_readops) };
>>  =20
>> @@ -3517,13 +3503,26 @@ void e1000e_core_pre_save(E1000ECore *core)
>>               core->tx[i].skip_cp =3D true;
>>           }
>>       }
>> +
>> +    /* back compat, QEMU moves xITR in itr_guest_value state */
>> +    core->itr_guest_value =3D core->mac[ITR];
>> +    for (i =3D 0; i < E1000E_MSIX_VEC_NUM; i++) {
>> +        core->eitr_guest_value[i] =3D core->mac[EITR + i];
>> +    }
>>   }
>>  =20
>>   int
>>   e1000e_core_post_load(E1000ECore *core)
>>   {
>> +    int i;
>>       NetClientState *nc =3D qemu_get_queue(core->owner_nic);
>>  =20
>> +    /* back compat */
>> +    core->mac[ITR] =3D core->itr_guest_value;
>> +    for (i =3D 0; i < E1000E_MSIX_VEC_NUM; i++) {
>> +        core->mac[EITR + i] =3D core->eitr_guest_value[i];
>> +    }
>> +
>>       /*
>>        * nc.link_down can't be migrated, so infer link_down according
>>        * to link status bit in core.mac[STATUS].
>> diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
>> index 39e3ce1c8fe..271c54380e9 100644
>> --- a/hw/net/igb_core.c
>> +++ b/hw/net/igb_core.c
>> @@ -2880,7 +2880,7 @@ igb_mac_swsm_read(IGBCore *core, int index)
>>   static uint32_t
>>   igb_mac_eitr_read(IGBCore *core, int index)
>>   {
>> -    return core->eitr_guest_value[index - EITR0];
>> +    return core->mac[index - EITR0];
>>   }
>>  =20
>>   static uint32_t igb_mac_vfmailbox_read(IGBCore *core, int index)
>> @@ -3046,8 +3046,7 @@ igb_set_eitr(IGBCore *core, int index, uint32_t va=
l)
>>  =20
>>       trace_igb_irq_eitr_set(eitr_num, val);
>>  =20
>> -    core->eitr_guest_value[eitr_num] =3D val & ~E1000_EITR_CNT_IGNR;
>> -    core->mac[index] =3D val & 0x7FFE;
>> +    core->mac[index] =3D val;
>
> This change will keep the CNT_INGR although the specification says it=20
> "is always read as zero".

I will fix.

Thanks,
Nick

