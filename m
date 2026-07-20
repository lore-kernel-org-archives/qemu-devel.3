Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8C4C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 21:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlvGX-00068m-Ba; Mon, 20 Jul 2026 17:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wlvGS-00067t-Ii
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 17:11:04 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wlvGP-0002Mv-Ot
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 17:11:04 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-495590dde14so18478125e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 14:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784581860; x=1785186660; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=elh0ULmb561wyB2NSO0TDpvKBfLd0gt0kUHKNXyeRQ0=;
 b=gX4ORtglSt/4BLm5SWY13FZ23lgBMyt99m2+Af+FTbs/ixziBf+m1zHCVUFvBqADlk
 sXzoXaBckiUVl6U+sqyuOLQKPLfnr0Zl/b7yfovvygmrDP4V26/jfAsbACTghVO1WyIE
 sxNyq5Byo4EsCYLfa75FhCP/L0zusIaP1XbRr7YijkFtyFJUeru3UAnCg/WElMIbuMMU
 uy9Sc8I6AkcEsSwKFAIfI2V0s5/KYKoWGMUNKB5FvYHzqysRAUHLW05GZA6uL23TqmXC
 apTDyZMZgYvtYARApL114727kNhR6G+4aEplJaFqDHbl371km8fIitjuXrZoSby8S9gm
 n9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784581860; x=1785186660;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=elh0ULmb561wyB2NSO0TDpvKBfLd0gt0kUHKNXyeRQ0=;
 b=Vfq9wI4RmSzXabs0008P09iU7wCdMZ1gcWtk0pPus1QwWGLH3UNiD6mJgIUUubkyVk
 AYMryXoOj85EApynUDm/yJ5Ue2eliom+v+UepAFA2eIN9+aLsFwd8yZkaMGNnzEpbCR/
 5wGIkZ9R0NOMBNI6lo03QbhaGhOx/q4RLlVjZeVMuC/gvXtE0AyfCte5kSVx94Q1CSzb
 xrGfcGGht23OiFoJTEiEuoeHNycyxq0JdzJGb4sT5QFWxvVSzXMMB4iXzG1CeqO39CfP
 +VL3hhK+S2qYEnX1mnMEnXhI3RRlcNEsGTJfG2K+lKqLDsstiFIxkeVUFojTqAV6F7JK
 SPeQ==
X-Gm-Message-State: AOJu0Ywzxad2c2dI40X/XsTEMMbkO+K1jn/Lt+bMuLYuM7wTHxvPTAak
 CHjfE9AAiBHN2QUoPYHRKG9oUGRQm5fSwB1fDT/Vj001me15uRMo7dWW
X-Gm-Gg: AfdE7ckkyZkbfxjUEngIdIzoIyR2sZ0HyILsAuGOk1qJCUMaQ8iWrhc1bWVvokzs6S9
 CVkgbNALyioy9d8Fj9MQk15aPuNkhmUX9/7j1WLZQWytqGoRQa3mr6OePSFnrzmcFqpkFWxiQm9
 gx5XpocU11qStOlCNG+TlqAzbrEeqUDt3DiZ/svJQT3ktpbuO+zEpS6flDM4ZTLEeavuC+xX7UR
 dKuwmm92VaUwS6iBoDnlqVwswhDtSNsriKi+q3TPgc53mIq+8gbV+P7Z+ZrP5tWFnsDxJC/anXA
 odEtb2OHNgkLvewz2Kl3JxsR9dA/2kW/+uIJ0syV6e5rtalADMTmgIAXFprHFTPiS0yq0A6K/dO
 fX3iaQSIpK/PSDDnTYsZDDjELyu0rntsAr6Kb6ZBq4jBoGqgQVH3/85Z3t7gbNPCdCu7E1pZeiI
 3KqFSyJUxYqBYGcElFjYDicAFSosgNaUYphRapJ+9mXlTfsZvhAecUXCKVNADqK/HWY/6qi7fss
 f7TZ9TxK/zmXbYyRp2RlRQWxOR2848kCZYp
X-Received: by 2002:a05:600c:48aa:b0:493:b811:e549 with SMTP id
 5b1f17b1804b1-4954a5161cfmr111983765e9.29.1784581859843; 
 Mon, 20 Jul 2026 14:10:59 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-225b-5200-6c3a-7793-fc69-3121.310.pool.telefonica.de.
 [2a02:3100:225b:5200:6c3a:7793:fc69:3121])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49563969482sm86432995e9.3.2026.07.20.14.10.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 14:10:59 -0700 (PDT)
Date: Mon, 20 Jul 2026 21:10:54 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
CC: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@mailo.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH 2/2] hw/sd/sdhci: Extract uSDHC-specific quirk
In-Reply-To: <CAEUhbmWhqc+_7MQA3Y9ZG9vwBjsbE4-w3tsx7Ep1CbBHze3Mcw@mail.gmail.com>
References: <20260719211923.1079282-1-shentey@gmail.com>
 <20260719211923.1079282-3-shentey@gmail.com>
 <CAEUhbmWhqc+_7MQA3Y9ZG9vwBjsbE4-w3tsx7Ep1CbBHze3Mcw@mail.gmail.com>
Message-ID: <897E12B2-A6E5-4524-9983-FA861A7FDDD3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
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



Am 20=2E Juli 2026 14:50:24 UTC schrieb Bin Meng <bmeng=2Ecn@gmail=2Ecom>:

Hi Bin,

Thanks for yor reviews and R-b tags!

>On Mon, Jul 20, 2026 at 5:19=E2=80=AFAM Bernhard Beschow <shentey@gmail=
=2Ecom> wrote:
>>
>> In Linux, the ESDHC_MIX_CTRL qirk is guarded by esdhc_is_usdhc() while
>> the eSDHC code path uses the standard SDHC interface=2E Extract the qui=
rk
>> into a new `usdhc_write()` function=2E
>>
>> Fixes file system corruption on emulated i=2EMX53 where Linux'
>> esdhc_is_usdhc() returns false=2E The same likely happens on e500 and
>> imx25-pdk machines=2E
>>
>> Fixes: 75e98bc4f859 ("hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE")
>> cc: qemu-stable
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> ---
>>  hw/sd/sdhci=2Ec | 73 +++++++++++++++++++++++++++++++------------------=
--
>>  1 file changed, 44 insertions(+), 29 deletions(-)
>>
>> diff --git a/hw/sd/sdhci=2Ec b/hw/sd/sdhci=2Ec
>> index c86dfa281f=2E=2Ee58a610397 100644
>> --- a/hw/sd/sdhci=2Ec
>> +++ b/hw/sd/sdhci=2Ec
>> @@ -1795,34 +1795,6 @@ esdhc_write(void *opaque, hwaddr offset, uint64_=
t val, unsigned size)
>>          sdhci_write(opaque, offset, value, size);
>>          break;
>>
>> -    case ESDHC_MIX_CTRL:
>> -        /*
>> -         * So, when SD/MMC stack in Linux tries to write to "Transfer
>> -         * Mode Register", ESDHC i=2EMX quirk code will translate it
>> -         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
>> -         * order to get where we started
>> -         *
>> -         * Note that Auto CMD23 Enable bit is located in a wrong place
>> -         * on i=2EMX, but since it is not used by QEMU we do not care=
=2E
>> -         *
>> -         * We don't want to call sdhci_write(=2E=2E, SDHC_TRNMOD, =2E=
=2E=2E)
>> -         * here because it will result in a call to
>> -         * sdhci_send_command(s) which we don't want=2E
>> -         *
>> -         */
>> -        s->trnmod =3D value & UINT16_MAX;
>> -        break;
>> -    case SDHC_TRNMOD:
>
>Looks like this register is not eSDHC specific?

Not quite sure what you mean exactly=2E The SDHC_TRNMOD isn't eSDHC specif=
ic but as per the comment above trnmod partial handling is deferred here, i=
=2Ee=2E needs to be intercepted=2E

>I looked at linux
>driver source codes and suspect we may need some more turning here
>other than uSDHC only=2E

Yeah, there is certainly a lot of room for improvement=2E I have some cloc=
k-related and SDMA buffer boundary patches in the pipeline which are necess=
ary for satisfying U-Boot=2E But that's a story for another day=2E

Best regards,
Bernhard

>
>
>> -        /*
>> -         * Similar to above, but this time a write to "Command
>> -         * Register" will be translated into a 4-byte write to
>> -         * "Transfer Mode register" where lower 16-bit of value would
>> -         * be set to zero=2E So what we do is fill those bits with
>> -         * cached value from s->trnmod and let the SDHCI
>> -         * infrastructure handle the rest
>> -         */
>> -        sdhci_write(opaque, offset, val | s->trnmod, size);
>> -        break;
>>      case SDHC_BLKSIZE:
>>          /*
>>           * ESDHCI does not implement "Host SDMA Buffer Boundary", and
>> @@ -1891,9 +1863,52 @@ static void fsl_esdhc_le_init(Object *obj)
>>      qdev_prop_set_uint8(dev, "sd-spec-version", 2);
>>  }
>>
>> +static void
>> +usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>> +{
>> +    SDHCIState *s =3D SYSBUS_SDHCI(opaque);
>> +    uint32_t value =3D (uint32_t)val;
>> +
>> +    switch (offset) {
>> +    case ESDHC_MIX_CTRL:
>> +        /*
>> +         * So, when SD/MMC stack in Linux tries to write to "Transfer
>> +         * Mode Register", uSDHC i=2EMX quirk code will translate it
>> +         * into a write to ESDHC_MIX_CTRL, so we do the opposite in
>> +         * order to get where we started=2E
>> +         *
>> +         * Note that Auto CMD23 Enable bit is located in a wrong place
>> +         * on i=2EMX, but since it is not used by QEMU we do not care=
=2E
>> +         *
>> +         * We don't want to call sdhci_write(=2E=2E, SDHC_TRNMOD, =2E=
=2E=2E)
>> +         * here because it will result in a call to
>> +         * sdhci_send_command(s) which we don't want=2E
>> +         *
>> +         */
>> +        s->trnmod =3D value & UINT16_MAX;
>> +        break;
>> +
>> +    case SDHC_TRNMOD:
>> +        /*
>> +         * Similar to above, but this time a write to "Command
>> +         * Register" will be translated into a 4-byte write to
>> +         * "Transfer Mode register" where lower 16-bit of value would
>> +         * be set to zero=2E So what we do is fill those bits with
>> +         * cached value from s->trnmod and let the SDHCI
>> +         * infrastructure handle the rest
>> +         */
>> +        sdhci_write(opaque, offset, val | s->trnmod, size);
>> +        break;
>> +
>> +    default:
>> +        esdhc_write(opaque, offset, val, size);
>> +        break;
>> +    }
>> +}
>> +
>>  static const MemoryRegionOps usdhc_mmio_ops =3D {
>>      =2Eread =3D esdhc_read,
>> -    =2Ewrite =3D esdhc_write,
>> +    =2Ewrite =3D usdhc_write,
>>      =2Evalid =3D {
>>          =2Emin_access_size =3D 1,
>>          =2Emax_access_size =3D 4,
>> --
>
>Regards,
>Bin

