Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883DAC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 23:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFiEz-0001oL-0B; Thu, 15 May 2025 19:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFiEw-0001le-LD; Thu, 15 May 2025 19:43:50 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFiEt-0000S2-8G; Thu, 15 May 2025 19:43:49 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7410c18bb00so2235863b3a.3; 
 Thu, 15 May 2025 16:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747352625; x=1747957425; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ft/c+MOBFYvtOphGS7eUQ3r3yHFQFRQfqZr1Yh6JMaQ=;
 b=d0RQFQwvfjpm273BkbbrRFTkTZ+wXeg4lpzth8MGXQqknD5a188CHV3YhlxkLgchQp
 xqzx3kRu++DWst04AAHW227sCbuTyGoWcd/Y/qJdei9jjOoet/nxeu6ydeSaQzKdV56P
 BBUEh78O5y1W1caiyDjkeGBafDwBNQH4WLSxGmTFYB12+2GQ3kh2MAwuaxWKr9746SwH
 Kzwwx0Ze74Of70eFxX0eW0Rf3uMF4j7BihqXfIduxNWmgo8cM1ijxlItEh/PQQRaCxnD
 XD0+4I4r6cOABeMiClMCkxkq8+YncBE0C6DaG7/7ZKtG5N6yBrv4PxgU6WtsjFXedUTp
 zLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747352625; x=1747957425;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ft/c+MOBFYvtOphGS7eUQ3r3yHFQFRQfqZr1Yh6JMaQ=;
 b=NcLlzgKtrnYTDNIfkz3fBRX8zQrEWwvwSea29ttJYS152is/A0UlvBf1yjDs9Oj7Bh
 21Uf6xP5mD7KbW60xLXOCPtxE66LtOH+6/rrtu2ZR5Gv6kcAVu1EzpUGwZ99DCpqeu+8
 2WM+hIb0NjLMoyD7KhEH/R0ypmDOoXSry7GbszKaugaFHvjHCPxswbhkuLGtGo4UoAfQ
 +V5CbRBDJ66fT8dU1aXoym7EfF8QbPL3uzpye7HemflMVe8FoqDmdbI+WJohvgzMncbE
 5cLDcPqokl/Cb9Mde6otNLmBHQXLx+8oatRCMdSpXPUj4JE0FJQIPpf80iPo9PVpgxXJ
 rPQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2ms+YwN1Ruo6r/I2MEJPiefVTvq1DjPhmrVH+aaqhWPJU3BZHd55BHAZfx+oA34d9rJ0zRatAFw==@nongnu.org
X-Gm-Message-State: AOJu0YzJ5yKP1LQbrBLPo4FgCZ64iyyMPIvXADW4PL3gblZOSwGy5jqS
 nQtbHoH0+suyjsP5yTUSVuc23NM0HEDQy5ckCETKmh8Rl0mCL02myJVshvvWLA==
X-Gm-Gg: ASbGnctxiBT2n3kl1yD+aK9YlxJ1km/23+dpW+I4gr+sbuDvlhQK/2wiYnpQESnyV11
 BSqcig2Hx3HC3+veG1KHcFJOXx+lswS0i41QtMx+HYwTNdKNYYzGHVEwpbYkH8qH7MOiw1fmLIS
 LWLH2cQ7yG0EQ4Ghh6hs6ZPqsOpcDJ8HN2EHuZYM4Tsxmlo+/dg4z02W9HnK9oNiENpHH77Pi2N
 JP8vEG1Lg8dVPuTSjQkmdjAnWzALw+3GXRXaMyINrnC7A3gOGTr9XnmvnLRX5ATFMpKDn1KZtf3
 kTxEughVJx34uGfPXgOfJ+F9v+jm9M2J6/LReKP5x3by/FhgduRwBAgWmw==
X-Google-Smtp-Source: AGHT+IG6rFd90KQlYLRQW78odC+P9H0MDxHHH7AJBqCSJTfLBBLaoROVhxLXl+oHPK9ikD3qf/hScg==
X-Received: by 2002:a05:6a20:432b:b0:1f5:709d:e0c6 with SMTP id
 adf61e73a8af0-2170ce3c83bmr798253637.42.1747352624956; 
 Thu, 15 May 2025 16:43:44 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb084936sm441973a12.56.2025.05.15.16.43.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 16:43:44 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 09:43:38 +1000
Message-Id: <D9X4T3CULF54.3A9T4PWX619CW@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Mike Kowal" <kowal@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Caleb
 Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 30/50] ppc/xive: Add xive_tctx_pipr_present() to present
 new interrupt
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-31-npiggin@gmail.com>
 <0ed60dc4-0986-46be-adda-0539d356e2db@linux.ibm.com>
In-Reply-To: <0ed60dc4-0986-46be-adda-0539d356e2db@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

On Thu May 15, 2025 at 6:10 AM AEST, Mike Kowal wrote:
>
> On 5/11/2025 10:10 PM, Nicholas Piggin wrote:
>> xive_tctx_pipr_update() is used for multiple things. In an effort
>> to make things simpler and less overloaded, split out the function
>> that is used to present a new interrupt to the tctx.
>
>
> Why is this a separate commit fro 30?=C2=A0=C2=A0 The change here does no=
t do=20
> anything different.

I think you meant 31.

You're right this one doesn't change any function and they could
be squashed. I added the API here, then made the fix to it in the
next patch, but it is a small enough change that it could have
easily been in one patch.

> Regardless, taken this patch set as a whole, it's good by me.
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
>>   hw/intc/xive.c        | 8 +++++++-
>>   hw/intc/xive2.c       | 2 +-
>>   include/hw/ppc/xive.h | 2 ++
>>   3 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 27b5a21371..bf4c0634ca 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -225,6 +225,12 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t =
ring, uint8_t priority,
>>       xive_tctx_notify(tctx, ring, group_level);
>>    }
>>  =20
>> +void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t prior=
ity,
>> +                            uint8_t group_level)
>> +{
>> +    xive_tctx_pipr_update(tctx, ring, priority, group_level);
>> +}
>> +
>>   /*
>>    * XIVE Thread Interrupt Management Area (TIMA)
>>    */
>> @@ -2040,7 +2046,7 @@ void xive_router_end_notify(XiveRouter *xrtr, Xive=
EAS *eas)
>>                                xive_get_field32(END_W7_F1_LOG_SERVER_ID,=
 end.w7),
>>                                &match)) {
>>           trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, 0);
>> -        xive_tctx_pipr_update(match.tctx, match.ring, priority, 0);
>> +        xive_tctx_pipr_present(match.tctx, match.ring, priority, 0);
>>           return;
>>       }
>>  =20
>> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
>> index cae4092198..f91109b84a 100644
>> --- a/hw/intc/xive2.c
>> +++ b/hw/intc/xive2.c
>> @@ -1652,7 +1652,7 @@ static void xive2_router_end_notify(Xive2Router *x=
rtr, uint8_t end_blk,
>>  =20
>>           group_level =3D xive_get_group_level(crowd, cam_ignore, nvx_bl=
k, nvx_idx);
>>           trace_xive_presenter_notify(nvx_blk, nvx_idx, ring, group_leve=
l);
>> -        xive_tctx_pipr_update(tctx, ring, priority, group_level);
>> +        xive_tctx_pipr_present(tctx, ring, priority, group_level);
>>           return;
>>       }
>>  =20
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 8152a9df3d..0d6b11e818 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -562,6 +562,8 @@ void xive_tctx_reset(XiveTCTX *tctx);
>>   void xive_tctx_destroy(XiveTCTX *tctx);
>>   void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t prior=
ity,
>>                              uint8_t group_level);
>> +void xive_tctx_pipr_present(XiveTCTX *tctx, uint8_t ring, uint8_t prior=
ity,
>> +                            uint8_t group_level);
>>   void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
>>   void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_leve=
l);
>>   uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring);


