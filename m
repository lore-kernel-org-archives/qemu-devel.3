Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE63FC531CD
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 20:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtADQ-0003vu-Li; Thu, 19 Feb 2026 15:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vtADO-0003vZ-Bq
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 15:01:34 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vtADM-0000G4-Mg
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 15:01:34 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64ad8435f46so1188558d50.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 12:01:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771531291; cv=none;
 d=google.com; s=arc-20240605;
 b=lLoZNw30Cthsuz1AIaugdW4Ipu6PN2YwZfzzC8qpbj6pHvpSVh0snnfBvCkuAP7XlF
 /M4SuzVQd/8By+v4tZn2pgFP5gztUbEO5JUuf+s4Ig+ysIMxG/ZP77eLHesYDyEQT3Vl
 6ajKgEtssh8O0NOKFQEroI1yx/in3ovNXSRfHXJvEYLTkYHafG8RMY40MOIEZOmrwZ5B
 fHCVlyGpujiiTRUQPEBUaAy22DO9piG/+Ktcnj0rXcWLX4cbsYiK+dEeHP7dljF6r9Zp
 Cq1WNykFaIu5h2y3bzMmbIU0/d1Pgzf13EQu4cGaJo2CdBEmUK01VFeIXjHyPR6glwI8
 guxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wB7mlzdxEqlEJN7lOXYnIKUh9JBThUAXicIuZcYrF28=;
 fh=DdF1/7YsBq/PoRLPiYXAMmBGVqpLABI7I/G0402L/go=;
 b=cLXsfGagmmNvXUgjTy9yr1/BNGxqYnf6LqyhoB/fErKT12Frqcu1zJ34levnd67jWd
 nvpP7FcjO9JdglWKZUM8fzYvxjAoDs8S9b7rEekoNiBOFOLYJee3DlrOkVqBvbqsPsW3
 Zha24sx38Z2qis3J5u4CrR1EIckWmHmTwFKF9Riq1SdI+JUOeHRXkCtS2AK/bCcuXNQG
 GVntmfpKhWsfGzMgDe4tZZgZawTvRJNt9S9fjcM8MReFpB8ohyIkFh/tyq9P8bI4n0Mk
 JYdYlINC5emNx2Z5xax70++5tnziPeojQbc9hMU/g5ITbouRz3ZnE4kyNIoTF9F4g8le
 98xQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771531291; x=1772136091; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wB7mlzdxEqlEJN7lOXYnIKUh9JBThUAXicIuZcYrF28=;
 b=P/PDuMnoaMLpfagxiOrt0LUfgBv3oXqv+IwEHvzrJRGIiSsnKlxv+wew9gJ5oyg4XG
 c7d90L+3Oj5ptaX9yF7m7FyjAcCrMWinFqVUlOMLQzdy+Z/oDOu3VtPE9RSqGM4oz0oW
 9d6lsIUTf8HZHrjCJpTIb7YfKsFR5XndXTi/OS4kJY9rSep8OggS615gSyCRAgB8p0PM
 Y6f7h8o9G+x0srgEcChV27a78Qtjycpebg31LP1yeTVZ6nUg0EDBkhpqchNnhMaJLeQb
 GEEJ6KgtOxQlDfxWGVFabPR8RKmrlzQOschJdVntIM7WL6AtssEUbC/BloqSuHkbUM1w
 OdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771531291; x=1772136091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wB7mlzdxEqlEJN7lOXYnIKUh9JBThUAXicIuZcYrF28=;
 b=UMKRz2dNEwSTw59vNXDJ3TO9BHNOpKtkHF8r6vkiJtnEW6jthi5n2S9zt1gGmHsDu1
 P5WysARrQMinLeeWL4zmApAzxQFakGIndmH/PAHVcTOB4da6HXzjLtL70YHhZxnT88Zx
 lZV8sQMOldlCSf4a9m8NEsUH/vUzPxo9Zk+D5wSyAennGF10/2x2uyo+wCrDRR9HxYeh
 HbCtwDsqHZCOyQy9YOG1GpmvTAhltU2xUIQlHHLN4EQ25vj2bYUDq7+HA3T1BmBRrX6q
 2AHlIwY23kniniLjxKT5ly3fAt8mJSZmuhWzQExxCI1R+WqsvUuzRN8u9jQ3KT2gdf77
 NncA==
X-Gm-Message-State: AOJu0Ywn8EEcVShMetasRw4EKB1m0d6H2oTsuasHom1HPA9IngYxlend
 456ULAZuuqHh4UfCop911ZFcebP2RZIFdOpKvDK/vGhvTrri+TvQiAdaH1Nips+n3zXlGXqK1xA
 iMEMyfYtGqwVPgV+0PHXRCVT6H+YU33nEw4wgLPtPbQ==
X-Gm-Gg: AZuq6aLGZs5RSnZ+XG1/CQW0LVZQsL1t9O5FsJqjc340NoL/c3OaygbJhPEbDdtn1hb
 G/zvPPEX6rY/v/6027S+Eu89cVkrv2Yain2LkjGEFgmrQnDYavbGYGz/fmDYDAQCgR9igqJUG26
 pvACnFJO0+MMnL8WaO9wCTeEoMXmdkl7aKpywn19BNVypJO5PmX2rtv5Fs8TwgbTxYN+LPLkOf4
 viGfxw2DXo2KN6IbsrW9kN4luqI01A4mYF9MT6AcvNV1+qifqWtRZ9J8CdmnCjcyXtmkIhRqIxI
 doeB4toNPyHpHstDNZboTVYnbPJIi4IgXK5KY8W3irFJtRrdIq5nwWahAU69eYz2lDSDKYos0/h
 iXg==
X-Received: by 2002:a05:690e:23db:b0:649:ccde:d6e0 with SMTP id
 956f58d0204a3-64c21b915f1mr10588661d50.92.1771531291031; Thu, 19 Feb 2026
 12:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20251221105340.2699327-1-buenocalvachejoel@gmail.com>
 <CAPDLHD5HGNAu1=JD=V-9YQMpR_8-tWjONex2jj4ZFHbNe9qVcg@mail.gmail.com>
In-Reply-To: <CAPDLHD5HGNAu1=JD=V-9YQMpR_8-tWjONex2jj4ZFHbNe9qVcg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Feb 2026 20:01:19 +0000
X-Gm-Features: AZwV_QhVXaNLuVQlWFg-34RZjjt04XsdWID_5WI7Fucscr-5oxz6F4ZQkwEYCMA
Message-ID: <CAFEAcA8xsFeCAnvna4+mFQuZCx8gNEJX5BbFzTYkr6rcaX43Lw@mail.gmail.com>
Subject: Re: [PATCH] hw/block/m25p80: Fix Winbond Fast Read dummy cycles
To: Joel Bueno <buenocalvachejoel@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 7 Jan 2026 at 11:30, Joel Bueno <buenocalvachejoel@gmail.com> wrote=
:
>
> Is there any feedback on this patch series?

Which board model(s) does this affect? You might have
some luck cc'ing their maintainers.

I've cc'd C=C3=A9dric who has done review in m25p80.c in the past.

> On Sun, Dec 21, 2025 at 11:53 Joel Bueno <buenocalvachejoel@gmail.com> wr=
ote:
>>
>> The Fast Read (0Bh) instruction requires 8 dummy clock cycles
>> according to Winbond datasheets (e.g., W25Q256JV Section 8.2.12).
>> However, the current code adds 8 to needed_bytes, which represents
>> bytes, not clock cycles. Since 8 clock cycles equals 1 byte in SPI
>> communication (1 bit per clock edge), this results in 64 dummy
>> clock cycles instead of 8.
>>
>> Change the Winbond case to add 1 byte (8 clocks) instead of 8 bytes
>> (64 clocks), matching the existing implementation for SST flash and
>> the datasheet specifications.
>>
>> Signed-off-by: Joel Bueno <buenocalvachejoel@gmail.com>
>> ---
>>  hw/block/m25p80.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
>> index a5336d92ff..21c2118b33 100644
>> --- a/hw/block/m25p80.c
>> +++ b/hw/block/m25p80.c
>> @@ -1001,7 +1001,7 @@ static void decode_fast_read_cmd(Flash *s)
>>          s->needed_bytes +=3D 1;
>>          break;
>>      case MAN_WINBOND:
>> -        s->needed_bytes +=3D 8;
>> +        s->needed_bytes +=3D 1;
>>          break;
>>      case MAN_NUMONYX:
>>          s->needed_bytes +=3D numonyx_extract_cfg_num_dummies(s);
>> --
>> 2.51.0

-- PMM

