Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6EFC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADVh-0005AO-10; Wed, 30 Apr 2025 15:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uADVf-00059R-TU; Wed, 30 Apr 2025 15:54:23 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uADVd-0007jM-Vc; Wed, 30 Apr 2025 15:54:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so1676125e9.1; 
 Wed, 30 Apr 2025 12:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746042859; x=1746647659; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=af0RpIfRxRc7PQBqcwSL/7UTDJMtLpeau9zL548o/c0=;
 b=ZyK372wFf/nkbQ+7k6FAxcLCZmdE7ohISb1esm59GYV+wFmgcU3pi9JtiYNDqLwIA/
 uiX7Rd5BvM9xE5v5mLz1GlTO0cF7M/aK9piyTWdN+57Jq9Zs4pPKQ6ikm+KNdXyB2Oka
 4GHhvjZ/V0x/jJEF01IwKe3dqsLnbDHGwhlRIZifYEiaAT1+gXn/76i8TK+3Lj43aBpp
 m6LeReGzOtKMnme2JB2DL49lcwmvOXV9NKt2MqCVIPzt8X82/Fpws57YcRjtdKsYaPOX
 hDazyw5RUiv2h4dbUmnjTIMwS72Jy8Qk5LKa8OpVigQpB/PlkYCVdq1b/dYDMMSeaEB+
 LFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746042859; x=1746647659;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=af0RpIfRxRc7PQBqcwSL/7UTDJMtLpeau9zL548o/c0=;
 b=F3WerpT0i7iN+fmDOTSf54qN3l/DAKPXvqLTZYlnwP0TT3fj/BEySA4ojD/vi6rfLo
 kX2VwRscsGk+5/+bGAw6Yf9NwR1G7OgLDgm7vOJer1xOwgpNG0Ekol7OzBPIQIAVEaT1
 RueYIFd+o9xZVa9RO+XzAhyaRPFI9v9qxZ18fkMn1WkR3O+2NVDh5iHlt71U3w/YHMnn
 1UAQjtRLtcfq/7mCcJOV9Knr8hU7Zw/zt+nGDecELGTU6zwr8eXQVMsKWFpNiJGMX9Ot
 gBSgiksif1pMfz95A1BoR9HpcH9V3hSiIAmqdj436lA6Hh6bgSNZuNFsDYuiC5YvtESW
 /3Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIfsPKU67oY1kosEoK1k2Rktn0R/Mm4Vd5weYqouA7lsYfcZ80LVoofQLnXB4R3SSGUK6+hgSwwRUy@nongnu.org
X-Gm-Message-State: AOJu0YxkSR+thdKMpawp+9GcarUY5/Suoh3OQKwiNtES6uxWF85UB4xg
 sxgnS11Rtb6mKAHYArnHH91lC7cPrejLwfJOHKIDK4/oN0u+xpLm
X-Gm-Gg: ASbGncvkAuIq5ifYc4Lz7t3qQiucaGxDPnDhCgXt1PRvoKCBvgqH169fUjZy+aWXLAd
 EU/FxFOptHQjyWkY4Y5cCR4t0BI1zXzXRF1FAmYDqIWLNH8E6Jhq71EkWKEi+v8POVF4ahBi3j+
 bvVIJ+Wmz19+MatucIBDXa6ZsbwmsFZqSnSJMqjg+02J6/KRp4vheyNDZWq78PNdYGynoSe09Ae
 bG+3JNnwjpSj3op632Cp0vaIIIK0QvwCbU0VXEG2BYZKslUfqY6Zp8RotuoTkMOInHAs3yDFHl1
 B16l8L0NbdX6FBE1cc3yPuquvU/jbKQ8rwRodKJ8qozcg80s7XKFFuWCIJTdoZXbZZ4sVtalR0x
 uQibdAtHs0+174oWQ
X-Google-Smtp-Source: AGHT+IF0/wFad//LMra59FvhL/jTUz8qiA3xTcVmVfiUDAh080AOx3LUYMgz8L1FNF4n2cH8tKm/gQ==
X-Received: by 2002:a05:600c:1e87:b0:43c:fa24:873e with SMTP id
 5b1f17b1804b1-441b1f33b69mr42339525e9.13.1746042859274; 
 Wed, 30 Apr 2025 12:54:19 -0700 (PDT)
Received: from smtpclient.apple (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b28dadsm35789185e9.40.2025.04.30.12.54.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Apr 2025 12:54:18 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH 2/2] block/null: Add read-pattern option
From: Nir Soffer <nirsof@gmail.com>
In-Reply-To: <pykbbqg7om2ahqs7h7gfstgvvlbfjc2gx3yobvbego6jrnqo6p@zohvnrrpfwce>
Date: Wed, 30 Apr 2025 22:54:07 +0300
Cc: QEMU Developers <qemu-devel@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3BE3D41F-B81B-4D9D-BE5E-534F60A9A79A@gmail.com>
References: <20250427225900.24316-1-nirsof@gmail.com>
 <20250427225900.24316-3-nirsof@gmail.com>
 <pykbbqg7om2ahqs7h7gfstgvvlbfjc2gx3yobvbego6jrnqo6p@zohvnrrpfwce>
To: Eric Blake <eblake@redhat.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x335.google.com
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



> On 29 Apr 2025, at 0:55, Eric Blake <eblake@redhat.com> wrote:
>=20
> On Mon, Apr 28, 2025 at 01:59:00AM +0300, Nir Soffer wrote:
>> When the `read-zeroes` is set, reads produce zeroes, and block status
>> return BDRV_BLOCK_ZERO, emulating a sparse image.
>>=20
>> If we don't set `read-zeros` we report BDRV_BLOCK_DATA, but image =
data
>> is undefined; posix_memalign, _aligned_malloc, valloc, or memalign do
>> not promise to zero allocated memory.
>>=20
>> When computing a blkhash of an image via qemu-nbd, we want to test 3
>> cases:
>>=20
>> 1. Sparse image: skip reading the entire image based on block status
>>   result, and use a pre-computed zero block hash.
>> 2. Image full of zeroes: read the entire image, detect block full of
>>   zeroes and skip block hash computation.
>> 3. Image full of data: read the entire image and compute a hash of =
all
>>   blocks.
>>=20
>> This change adds `read-pattern` option. If the option is set, reads
>> produce the specified pattern. With this option we can emulate an =
image
>> full of zeroes or full of non-zeroes.
>>=20
>> Specifying both `read-zeroes` and `read-pattern !=3D 0` is not useful
>> since `read-zeroes` implies a sparse image.  In this case =
`read-zeroes`
>> wins and we ignore the pattern. Maybe we need to make the options =
mutual
>> exclusive.
>=20
> I would lean towards an error.  It's easier to remove an error later
> if we find it was too strict, than to be lax up front and then regret
> it down the road when we wish we had been more strict.

Good point

>=20
>>=20
>> The following examples shows how the new option can be used with =
blksum
>> (or nbdcopy --blkhash) to compute a blkhash of an image using the
>> null-co driver.
>>=20
>> Sparse image - the very fast path:
>>=20
>>    % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/sparse.sock \
>>        "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': =
'100g', 'read-zeroes': true}}" &
>>=20
>>    % time blksum 'nbd+unix:///?socket=3D/tmp/sparse.sock'
>>    300ad1efddb063822fea65ae3174cd35320939d4d0b050613628c6e1e876f8f6  =
nbd+unix:///?socket=3D/tmp/sparse.sock
>>    blksum 'nbd+unix:///?socket=3D/tmp/sparse.sock'  0.05s user 0.01s =
system 92% cpu 0.061 total
>>=20
>> Image full of zeros - same hash, 268 times slower:
>>=20
>>    % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/zero.sock \
>>        "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': =
'100g', 'read-pattern': 0}}" &
>>=20
>>    % time blksum 'nbd+unix:///?socket=3D/tmp/zero.sock'
>>    300ad1efddb063822fea65ae3174cd35320939d4d0b050613628c6e1e876f8f6  =
nbd+unix:///?socket=3D/tmp/zero.sock
>>    blksum 'nbd+unix:///?socket=3D/tmp/zero.sock'  7.45s user 22.57s =
system 183% cpu 16.347 total
>>=20
>> Image full of data - difference hash, heavy cpu usage:
>>=20
>>    % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/data.sock \
>>        "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': =
'100g', 'read-pattern': -1}}" &
>>=20
>>    % time blksum 'nbd+unix:///?socket=3D/tmp/data.sock'
>>    2c122b3ed28c83ede3c08485659fa9b56ee54ba1751db74d8ba9aa13d9866432  =
nbd+unix:///?socket=3D/tmp/data.sock
>>    blksum 'nbd+unix:///?socket=3D/tmp/data.sock'  46.05s user 14.15s =
system 448% cpu 13.414 total
>>=20
>> Tested on top of
>> https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg05096.html.
>>=20
>> Signed-off-by: Nir Soffer <nirsof@gmail.com>
>> ---
>> block/null.c         | 17 +++++++++++++++++
>> qapi/block-core.json |  9 ++++++++-
>> 2 files changed, 25 insertions(+), 1 deletion(-)
>=20
> Should block status return ZERO|DATA when read-pattern=3D0 is present?

This will make it useless for testing image full of zeros which is the =
reason I added it. qemu-img convert, nbdcopy, and blksum look only at =
the zero bit and skip reading the extent.



