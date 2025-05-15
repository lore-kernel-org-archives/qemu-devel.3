Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C58C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 23:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFiI7-0005Iq-PO; Thu, 15 May 2025 19:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFiI3-0005IO-Fc; Thu, 15 May 2025 19:47:03 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFiI1-0000kt-OP; Thu, 15 May 2025 19:47:03 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2317d94c9cdso14906865ad.2; 
 Thu, 15 May 2025 16:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747352820; x=1747957620; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EaShiHWwczVAXhFoBV2tbXFJ5Zc7AWXe3Ia/mkw6e/Q=;
 b=C2RRc1oNDrxats3aWzYQGhs0Gf5Du2MPYEIoGti2pAHZQhQedrgHKOX058EumaVg6Q
 O/hm6Mi+vtLTfo35vS+z47TaV451g7PWdQEXgjzcSszPvQuCgSktfLhmUhvEjgObFF0I
 iruSizygUyqj+c9XCM0Mnj+e5jFyAnVW7BSp0X6OLeplQ8NWreEhWhGrgBKdJ7wC4Be/
 gQ61xrfAqM4XWmDC+IwBu/fcxptkydz5Np/ULIoEi/cozMgzh0XAoxwQjFhtYh6HNCai
 Gf8gIlqIr4qxHCcvSFBbvSPUeO64bMqMloz7htUKUzsHyMD6QAsENLoGAtX50pX65vJH
 Iw+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352820; x=1747957620;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EaShiHWwczVAXhFoBV2tbXFJ5Zc7AWXe3Ia/mkw6e/Q=;
 b=DOAOXJwdkyPZHgwMOZij13b0P8aXN+xlZF3YxCQs6bBJe0JFEqay2TWD1zGUhZa+gm
 Cq7/MMpHF7xPoQYcRCt3soccepaObDAFu3KsqNI/nrfHj9mN3gLmFHFj+h2NRRyFfHiC
 JdQbfZl3UkGtDSXh5/5YeZyT1G48vN+jAQU1MNRVawKDVyZowJ3+4t9gZHCdc8H+C8Fc
 Gs1YSChnpwHCzwQ5HZcB6I+DM5nJ3S0EoMosaZXR7obefi5MT1AmiSGBJjPTvIG6+rFh
 OMyw9RkLkse57ZC0If1/bz65DE3J6c94bnSYxogZcvIqxGWP60B2JlbIRgmIgh4OfsDN
 urbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgDaZQU6eXSQaPUDtKNJfCAJkw1Kj5Pgz6uTXJX9/DV5mFkKgeplxZIMWocaFLNeGb0vUxcgdz8A==@nongnu.org
X-Gm-Message-State: AOJu0YwLgVNzFcCnVEateHNHbLrAFlREcLG+Z2WSpwCvX1BepxppyxLa
 6LZCSBOdhTrDrftLUM3vcGE0Y5gAH+bN8XVwGZnnQOxOGarFmFtRv+LcsFvmhw==
X-Gm-Gg: ASbGnctEYmfYzAtDT+65aTZ3hdCLFpT3L8LSysNvHl9Xpx6t9q16aoo1S1UE5vFWVxV
 N9YX/4pNx6TvcrGLR3oCw/sndHxjjsO42woRZpeY2XvRY1BofFl3gJdFFIwbZWhhXeYmnMuhefJ
 G2i960KgxvnmujLSd/n7/WXOFMwFxsxvwCxAQK3Dr3jP0wWnNuGYIG8GuDXJo5712eEPW6HNQdh
 saYLMRA3PXouj781dSDqxjh51cZUe03jSrLey6wR2NHJKis+qCIXK/uLJPDOCN6oVmU/5bUuVSY
 MtjVf7Zcui4dZZgL+IMKUP3F4hM5AmVLDr4+06Qsd6X53gQ=
X-Google-Smtp-Source: AGHT+IFWJ43OEQVSvjHPVqd8HAEtnpnh1pOxu+/lcntY1qKDUom47SNn8dNbERKv0VHiMDVZTvn8Bw==
X-Received: by 2002:a17:902:c951:b0:223:42ca:10ef with SMTP id
 d9443c01a7336-231d45af423mr15660955ad.43.1747352819795; 
 Thu, 15 May 2025 16:46:59 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ed540dsm3176265ad.218.2025.05.15.16.46.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 16:46:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 09:46:54 +1000
Message-Id: <D9X4VL9LW0VY.2Y9M6ID9YK205@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Mike Kowal" <kowal@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Caleb
 Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 32/50] ppc/xive: Split xive recompute from IPB function
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-33-npiggin@gmail.com>
 <015a40ec-5685-4572-a981-29fc40fefcda@linux.ibm.com>
In-Reply-To: <015a40ec-5685-4572-a981-29fc40fefcda@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

On Thu May 15, 2025 at 6:42 AM AEST, Mike Kowal wrote:
>
> On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
>> Further split xive_tctx_pipr_update() by splitting out a new function
>> that is used to re-compute the PIPR from IPB. This is generally only
>> used with XIVE1, because group interrputs require more logic.
>
>
> Previous upstreaming was focused only on XIVE2 as not to impact users of=
=20
> XIVE1.

Yeah it's a balancing act. I didn't want xive1 to diverge too much in
basic APIs like the PIPR updating.

So long as powernv9 gets some basic OPAL testing, hopefully it should be
okay.

>
> But I assume this does not hurt anything.
>
> Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks,
Nick

>
> Thanks,=C2=A0 MAK
>
>
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>   hw/intc/xive.c | 25 ++++++++++++++++++++++---
>>   1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 25f6c69c44..5ff1b8f024 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -225,6 +225,20 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t =
ring, uint8_t priority,
>>       xive_tctx_notify(tctx, ring, group_level);
>>    }
>>  =20
>> +static void xive_tctx_pipr_recompute_from_ipb(XiveTCTX *tctx, uint8_t r=
ing)
>> +{
>> +    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
>> +    uint8_t alt_ring =3D (ring =3D=3D TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS =
: ring;
>> +    uint8_t *aregs =3D &tctx->regs[alt_ring];
>> +    uint8_t *regs =3D &tctx->regs[ring];
>> +
>> +    /* Does not support a presented group interrupt */
>> +    g_assert(!xive_nsr_indicates_group_exception(alt_ring, aregs[TM_NSR=
]));
>> +
>> +    aregs[TM_PIPR] =3D xive_ipb_to_pipr(regs[TM_IPB]);
>> +    xive_tctx_notify(tctx, ring, 0);
>> +}
>> +
>>   void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t prio=
rity,
>>                               uint8_t group_level)
>>   {
>> @@ -517,7 +531,12 @@ static void xive_tm_set_os_lgs(XivePresenter *xptr,=
 XiveTCTX *tctx,
>>   static void xive_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx=
,
>>                                      hwaddr offset, uint64_t value, unsi=
gned size)
>>   {
>> -    xive_tctx_pipr_update(tctx, TM_QW1_OS, value & 0xff, 0);
>> +    uint8_t ring =3D TM_QW1_OS;
>> +    uint8_t *regs =3D &tctx->regs[ring];
>> +
>> +    /* XXX: how should this work exactly? */
>> +    regs[TM_IPB] |=3D xive_priority_to_ipb(value & 0xff);
>> +    xive_tctx_pipr_recompute_from_ipb(tctx, ring);
>>   }
>>  =20
>>   static void xive_os_cam_decode(uint32_t cam, uint8_t *nvt_blk,
>> @@ -601,14 +620,14 @@ static void xive_tctx_need_resend(XiveRouter *xrtr=
, XiveTCTX *tctx,
>>       }
>>  =20
>>       /*
>> -     * Always call xive_tctx_pipr_update(). Even if there were no
>> +     * Always call xive_tctx_recompute_from_ipb(). Even if there were n=
o
>>        * escalation triggered, there could be a pending interrupt which
>>        * was saved when the context was pulled and that we need to take
>>        * into account by recalculating the PIPR (which is not
>>        * saved/restored).
>>        * It will also raise the External interrupt signal if needed.
>>        */
>> -    xive_tctx_pipr_update(tctx, TM_QW1_OS, 0xFF, 0); /* fxb */
>> +    xive_tctx_pipr_recompute_from_ipb(tctx, TM_QW1_OS); /* fxb */
>>   }
>>  =20
>>   /*


