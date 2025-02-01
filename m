Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C2AC0218F
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 14:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teEu2-0005LW-5A; Sat, 01 Feb 2025 09:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1teEu0-0005L8-JQ; Sat, 01 Feb 2025 09:55:20 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1teEty-0004mg-R0; Sat, 01 Feb 2025 09:55:20 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ab34a170526so470651066b.0; 
 Sat, 01 Feb 2025 06:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738421716; x=1739026516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=DtYDNjIyBVO1JYqJQblEL+piWSEx3ul++l6uPyRmxz4=;
 b=WZ78Qyqh2EEmsymb+SHSgX1Ve8NCLADgMLRpLYKM4/v/ghiCuPo8ospombzXmFLryl
 ZlS1Q0sH/o5QDZ4655bvyZD0DqGrooizUYD5XHTgQttMbJTmylTSHqDujEeSJD/rFPRT
 09x/txMf3t2c6JFETIhXQV17th0KHziIKwmmyIhm1fPu5IIhHHyVdy3WRhlB3zw65LmU
 +MVcMe2evMegO8SJfsMUtQEjvI7OT2qynr5FwBJ94Ar+oNHAmRUcBP8bdwFkDX5kPdtE
 rvSNBnnoZnBNeS8DBxe+SEEccDg08NesY5gVPeHpAuDsNa8bQS1zTgbYJoPlb2nc6k/m
 ta7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738421716; x=1739026516;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DtYDNjIyBVO1JYqJQblEL+piWSEx3ul++l6uPyRmxz4=;
 b=j5uFxBmlreHloxwgdkX/XW2xb+9rjOlfeGUC/sEmMIkrH8M1yemElWmnEm85D1PlxT
 HdyIhbGWeoSHT+9tr1xIj2TMVv+NR3c+AOmL03VpstxcfYXIPHCfadKDDV+18shiDdyo
 BXy930r9VV4lARXwOgUbsq6SysEAyP+DWYclHvPL+g7Lmm63fCERosoym2Dk0I5tbCsX
 WW/jYdCXbaHHDeZL2A0BIZVPQWdhhFk8yNaxJxNSyOJ7mjdsSovuhmx6gkWgymDXzywU
 zvKWhO2cyw1NBGAclD/+oOX2KSyupD0nQt4FvqEiVtuMl1jF48UIZ5DixDfsnEHXGHmK
 GKzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXru5E4qwVPrJxXLYihgxpuuv3D0sgAfDuRSbQ07Wx3A6fReu48MvsGzDMt+32oCfnzij/hItKyPfqC@nongnu.org,
 AJvYcCXu3qAFKtuzbrjUzjIihsq1ZfSB0hGks0oZE6TWoIEqRxStwToV/07PE8oOxfBcra0QXROtHZvwLZU=@nongnu.org
X-Gm-Message-State: AOJu0YzOYq8Xk5/KtpxY4uO4gjb2FSSCkTV3ieEybnU94THpXiaVZAja
 eL+Wzqz0tr+0OW0otUpvXbGxvC5NZ/VUVJjl6Q0mYGcn+7ofa9La
X-Gm-Gg: ASbGnctOOw1qZC+RbwgrgoiE3kjcufoh2hujbcRHn/5ELNUfF93Xefx6g8saA44OkGl
 Uxj2Z5+Ttp8ryjGJy5IP47mcm1EMFAkNuMnMU/abokhgS0F9SjavF1Z6qU3LfG1uiglmdMG3rQ2
 BD6ONFEY9Yzz5anFmcB1Wo4OsD3MSaPPmO+EUWPKBd9JbJlYthrqKkjP9J2z+glG5fmSHdonkoh
 JymsRsdF1hw4yBjfJEqJiBVaglpJ80K3Z/21a6RpnAE5WMCYdZLdE4I2BPjuA3VUbyWVmZXz/JY
 fxrCTALwTj3Ybi6nR5wF+n1DSZX0uQyFdhcF0stILY3/G/bb4aKCuoCkTzrGNOb6hDk=
X-Google-Smtp-Source: AGHT+IHpKYCf3TeL2pSs9qhEydh5AbIT09yHWNtJO21mZ11bvLp/KxNyWmnAOxwZPGNnqtjgK1aFtQ==
X-Received: by 2002:a17:907:1c16:b0:aab:c78c:a7ed with SMTP id
 a640c23a62f3a-ab6cfe12c99mr1842404666b.49.1738421716146; 
 Sat, 01 Feb 2025 06:55:16 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-183-083-158.77.183.pool.telefonica.de.
 [77.183.83.158]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47a8005sm450780566b.32.2025.02.01.06.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 01 Feb 2025 06:55:15 -0800 (PST)
Date: Sat, 01 Feb 2025 14:55:15 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_hw/ppc/e500=3A_Partial_impleme?=
 =?US-ASCII?Q?ntation_of_local_access_window_registers?=
In-Reply-To: <22e114ac-2c3f-76f1-2172-9adf0c50ad5f@eik.bme.hu>
References: <20250115211544.307124E602F@zero.eik.bme.hu>
 <22e114ac-2c3f-76f1-2172-9adf0c50ad5f@eik.bme.hu>
Message-ID: <DE6FAB3B-F994-47B8-95A5-9D1BFD6B621F@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x631.google.com
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



Am 30=2E Januar 2025 12:45:58 UTC schrieb BALATON Zoltan <balaton@eik=2Ebm=
e=2Ehu>:
>On Wed, 15 Jan 2025, BALATON Zoltan wrote:
>> This allows guests to set the CCSR base address=2E Also store and retur=
n
>> values of the local access window registers but their functionality
>> isn't implemented=2E
>
>Ping?

I guess you're trying to boot a real firmware image from SD card? I've imp=
lemented that in my e500-fdt branch which I want to send as an RFC=2E I sti=
ll need to clean it up=2E Once it's on the list we could make a plan how to=
 turn it into a p10xx=2E Would that work for you?

Best regards,
Bernhard

P=2ES=2E The last commit teaches you how to start a firmware from SD card=
=2E

>
>> Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>> ---
>> hw/ppc/e500-ccsr=2Eh |  4 +++
>> hw/ppc/e500=2Ec      | 79 ++++++++++++++++++++++++++++++++++++++++++++-=
-
>> 2 files changed, 80 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/hw/ppc/e500-ccsr=2Eh b/hw/ppc/e500-ccsr=2Eh
>> index 249c17be3b=2E=2Ecfbf96e181 100644
>> --- a/hw/ppc/e500-ccsr=2Eh
>> +++ b/hw/ppc/e500-ccsr=2Eh
>> @@ -4,12 +4,16 @@
>> #include "hw/sysbus=2Eh"
>> #include "qom/object=2Eh"
>>=20
>> +#define NR_LAWS 12
>> +
>> struct PPCE500CCSRState {
>>     /*< private >*/
>>     SysBusDevice parent;
>>     /*< public >*/
>>=20
>>     MemoryRegion ccsr_space;
>> +
>> +    uint32_t law_regs[NR_LAWS * 2];
>> };
>>=20
>> #define TYPE_CCSR "e500-ccsr"
>> diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>> index 64f8c766b4=2E=2E376cb4cb37 100644
>> --- a/hw/ppc/e500=2Ec
>> +++ b/hw/ppc/e500=2Ec
>> @@ -43,6 +43,7 @@
>> #include "qemu/host-utils=2Eh"
>> #include "qemu/option=2Eh"
>> #include "hw/pci-host/ppce500=2Eh"
>> +#include "qemu/log=2Eh"
>> #include "qemu/error-report=2Eh"
>> #include "hw/platform-bus=2Eh"
>> #include "hw/net/fsl_etsec/etsec=2Eh"
>> @@ -1331,11 +1332,83 @@ void ppce500_init(MachineState *machine)
>>     boot_info->dt_size =3D dt_size;
>> }
>>=20
>> +static int law_idx(hwaddr addr)
>> +{
>> +    int idx;
>> +
>> +    addr -=3D 0xc08;
>> +    idx =3D 2 * ((addr >> 5) & 0xf);
>> +    if (addr & 8) {
>> +        idx++;
>> +    }
>> +    assert(idx < 2 * NR_LAWS);
>> +    return idx;
>> +}
>> +
>> +static uint64_t law_read(void *opaque, hwaddr addr, unsigned size)
>> +{
>> +    PPCE500CCSRState *s =3D opaque;
>> +    uint64_t val =3D 0;
>> +
>> +    switch (addr) {
>> +    case 0:
>> +        val =3D s->ccsr_space=2Eaddr >> 12;
>> +        break;
>> +    case 0xc08 =2E=2E=2E 0xd70:
>> +        val =3D s->law_regs[law_idx(addr)];
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid local access register =
read"
>> +                      "0x%" HWADDR_PRIx "\n", addr);
>> +    }
>> +    return val;
>> +}
>> +
>> +static void law_write(void *opaque, hwaddr addr, uint64_t val, unsigne=
d size)
>> +{
>> +    PPCE500CCSRState *s =3D opaque;
>> +
>> +    switch (addr) {
>> +    case 0:
>> +        val &=3D 0xffff00;
>> +        memory_region_set_address(&s->ccsr_space, val << 12);
>> +        break;
>> +    case 0xc08 =2E=2E=2E 0xd70:
>> +    {
>> +        int idx =3D law_idx(addr);
>> +
>> +        qemu_log_mask(LOG_UNIMP, "Unimplemented local access register =
write"
>> +                      "0x%" HWADDR_PRIx " <- 0x%" PRIx64 "\n", addr, v=
al);
>> +        val &=3D (idx & 1) ? 0x80f0003f : 0xffffff;
>> +        s->law_regs[idx] =3D val;
>> +        break;
>> +    }
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "Invalid local access register =
write"
>> +                      "0x%" HWADDR_PRIx "\n", addr);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps law_ops =3D {
>> +    =2Eread =3D law_read,
>> +    =2Ewrite =3D law_write,
>> +    =2Eendianness =3D DEVICE_BIG_ENDIAN,
>> +    =2Evalid =3D {
>> +        =2Emin_access_size =3D 4,
>> +        =2Emax_access_size =3D 4,
>> +    },
>> +};
>> +
>> static void e500_ccsr_initfn(Object *obj)
>> {
>> -    PPCE500CCSRState *ccsr =3D CCSR(obj);
>> -    memory_region_init(&ccsr->ccsr_space, obj, "e500-ccsr",
>> -                       MPC8544_CCSRBAR_SIZE);
>> +    PPCE500CCSRState *s =3D CCSR(obj);
>> +    MemoryRegion *mr;
>> +
>> +    memory_region_init(&s->ccsr_space, obj, "e500-ccsr", MPC8544_CCSRB=
AR_SIZE);
>> +
>> +    mr =3D g_new(MemoryRegion, 1);
>> +    memory_region_init_io(mr, obj, &law_ops, s, "local-access", 4096);
>> +    memory_region_add_subregion(&s->ccsr_space, 0, mr);
>> }
>>=20
>> static const TypeInfo e500_ccsr_info =3D {
>>=20

