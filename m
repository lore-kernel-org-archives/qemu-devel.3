Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A357C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 10:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvCk8-0004YH-DU; Thu, 20 Mar 2025 06:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvCk6-0004Y3-1p; Thu, 20 Mar 2025 06:03:14 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tvCk2-00073J-3p; Thu, 20 Mar 2025 06:03:12 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-225b5448519so8153565ad.0; 
 Thu, 20 Mar 2025 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742464988; x=1743069788; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8+VP5t2Rq5vqO7Skqn/4MvILzGnZrkl8yI6ldF4A3Y=;
 b=YbHLajciDsG6NSl/MuJ4co84WIMLcZ1Kj6D5WLaMJnPBVlfj7TcEIFwsoxsCMRZqDQ
 AAd939oz4Ueu8dx2FMOjxhopsExsIU774gbU71LgHVmUzjWzcQ7T/tVMx0sl4+H2LXN+
 3KLvezwTReSTohkrfDeb2ptpGhy51peCsii/GfoqeaVj3mjvFMVxagW1jM1Y8PG3Z25n
 MKO/IVJUxj3OsL3aibxqxeS30eZOmMrDxo6D+LIUSSZbPrFSUEi4Mz6GSkxjjUfIFqqN
 YbdKMYT9NWnf0Gn5/mpqU+UzgA/YHxlVQSlg6jZ/WXvrICvCsJHK8s9qGBUwwYMhI+TK
 loCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742464988; x=1743069788;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+8+VP5t2Rq5vqO7Skqn/4MvILzGnZrkl8yI6ldF4A3Y=;
 b=YpXLui+lT8Gh3eFD19TfEZ0US5iwpJQAA88Kpq8AOYY3XMhOytAQst+wI7cbTZ2sq4
 zNKZEgRt6csnoAMP0c7Ov9pISG2pfunBflOJKCfLGjJQpRSeG5hh9U8tQCck7VZ1WngY
 pHlLZ16aJZXFjI3IpyP9RF+b4RojHO0OxOA+7nXNu4LNoPcbC00BoYEqms3ZSEBU03U3
 SsV83zdrSbDDRlxDKdlB5SoV35WGRd+ow7KbiAuVzOkP9EVdNt0YBhfqhWahN4I/rxKc
 L+YZAIokLj+TD1tmB/0/2XGDfLl3/dM34cYiwgK7aMz92t4Iv04Mvz9zqX3RKYz7wV1n
 sJfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8xt76M1AUJUFhYNwF0NKlBYmaHMyTkx7h2b/PQ24SiBZYkspU0DeXN6gAduupHr3KIBhDsd7tMA==@nongnu.org
X-Gm-Message-State: AOJu0YyIlcu+MMhge04FC5cui7KWBm4EwePM2uG9gBF5bJ+VH5DQ9LWh
 zKKxYG7sbhZR++IEEGZz+VIxq8Z0hxfXiIaE0uUrbDZ6/KmI97uP
X-Gm-Gg: ASbGncs4LIoKXuwhMW6CLdOqTc/6nG+VFCPiN1ojICEYp+rrw1wcT/Av75qeS071ebm
 3yb20S/6TvtG+1dIHm2s11j4I5FfswD+hEcEp/xAMtck7b999w/eCkajtjCy1lEFGNrwm4mW0k6
 Wgp6Jn3hkQKFgidSo7kYGHrfzEya08bR1awZNRwxMTF7fMrZ3tt6Ad4JabxkG2x7ujEm+1l0R9b
 qMCYX2dNNHtwLRLUUx0eHpJ1Z2DLMhGltCBedYllwmNUQ4DPl0vlkTamSRQGVXnHnrsBZ8GSF5U
 GIQu/Dwq3I1ulTK6IrHototoflESiSO3u09Lf6E=
X-Google-Smtp-Source: AGHT+IFFZcFM/EbABCm2MKRicJox0httvvLltPrAGNNVEZ2vvvCnuiwkFURqYiQNPGWtzo+QcCvFrw==
X-Received: by 2002:a05:6a00:3a08:b0:736:57cb:f2b6 with SMTP id
 d2e1a72fcca58-7376d62aac5mr8954965b3a.12.1742464987726; 
 Thu, 20 Mar 2025 03:03:07 -0700 (PDT)
Received: from localhost ([118.208.135.36]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711694430sm13244742b3a.122.2025.03.20.03.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 03:03:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Mar 2025 20:03:02 +1000
Message-Id: <D8L0AAFJP96T.2NT2MNFPJWKI5@gmail.com>
Subject: Re: [PATCH] ppc/amigaone: Check blk_pwrite return value
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250314200140.2DBE74E6069@zero.eik.bme.hu>
 <30852eb7-ef37-4da1-b014-ad4131d74c29@redhat.com>
 <e183986d-6d2c-7fef-ac8b-9388241b32e0@eik.bme.hu>
In-Reply-To: <e183986d-6d2c-7fef-ac8b-9388241b32e0@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

On Mon Mar 17, 2025 at 11:13 PM AEST, BALATON Zoltan wrote:
> On Mon, 17 Mar 2025, C=C3=A9dric Le Goater wrote:
>> On 3/14/25 21:01, BALATON Zoltan wrote:
>>> Coverity reported that return value of blk_pwrite() maybe should not
>>> be ignored. We can't do much if this happens other than report an
>>> error but let's do that to silence this report.
>>>=20
>>> Resolves: Coverity CID 1593725
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>>   hw/ppc/amigaone.c | 14 ++++++++------
>>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>>=20
>>> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
>>> index 483512125f..5d787c3059 100644
>>> --- a/hw/ppc/amigaone.c
>>> +++ b/hw/ppc/amigaone.c
>>> @@ -108,8 +108,8 @@ static void nvram_write(void *opaque, hwaddr addr,=
=20
>>> uint64_t val,
>>>       uint8_t *p =3D memory_region_get_ram_ptr(&s->mr);
>>
>> why is the nvram never read ?
>
> There's a comment about that. It's a rom_device which maps the memory=20
> region directly so does not go through the read callback. But I thin ther=
e=20
> must be a read callback and cannot be null so we have an empty one.=20
> Previously I had one that worked in case romd mode is turned off but Nick=
=20
> said having dead code is not wanted and better to mark it unreachable.
>
>>>         p[addr] =3D val;
>>> -    if (s->blk) {
>>> -        blk_pwrite(s->blk, addr, 1, &val, 0);
>>> +    if (s->blk && blk_pwrite(s->blk, addr, 1, &val, 0) < 0) {
>>> +        error_report("%s: could not write %s", __func__,=20
>>> blk_name(s->blk));
>>
>> hmm, guest_error maybe ? since this is a runtime error.
>
> It's not a guest error but some problem on the host with the backing file=
.
>
>>>       }
>>>   }
>>>   @@ -151,15 +151,17 @@ static void nvram_realize(DeviceState *dev, Err=
or=20
>>> **errp)
>>>           *c =3D cpu_to_be32(CRC32_DEFAULT_ENV);
>>>           /* Also copies terminating \0 as env is terminated by \0\0 */
>>>           memcpy(p + 4, default_env, sizeof(default_env));
>>> -        if (s->blk) {
>>> -            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p=
,=20
>>> 0);
>>> +        if (s->blk &&
>>> +            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p=
, 0)=20
>>> < 0
>>> +           ) {
>>> +            error_report("%s: could not write %s", __func__,=20
>>> blk_name(s->blk));
>>
>> This should use the errp parameter.
>>
>>>           }
>>>           return;
>>>       }
>>>       if (*c =3D=3D 0) {
>>>           *c =3D cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
>>> -        if (s->blk) {
>>> -            blk_pwrite(s->blk, 0, 4, p, 0);
>>> +        if (s->blk && blk_pwrite(s->blk, 0, 4, p, 0) < 0) {
>>> +            error_report("%s: could not write %s", __func__,=20
>>> blk_name(s->blk));
>>
>> same here.
>
> It could but I think it's not needed. It still works without the backing=
=20
> file and the guest works, just may not save the NVRAM contents which is a=
=20
> problem on the host. So the error is reported but I'm not sure it should=
=20
> abort. In practice if there's some fatal error with the backing file the
>
> blk_set_perm(s->blk, BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE,
>                       BLK_PERM_ALL, &error_fatal);
>
> earlier will catch that so it won't even get here.

I'll take it as is since it seems to be an improvement. Some other nvram
devices with backing files do the same thing with write failures.

Thanks,
Nick

