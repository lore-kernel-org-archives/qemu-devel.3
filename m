Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E92C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 19:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uADZT-0008Df-5i; Wed, 30 Apr 2025 15:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uADZR-0008DA-MM; Wed, 30 Apr 2025 15:58:17 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uADZP-000862-NT; Wed, 30 Apr 2025 15:58:17 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43ed8d32a95so1812085e9.3; 
 Wed, 30 Apr 2025 12:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746043093; x=1746647893; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i0EW0r1elhfGNzoz4neMN2bD2fJ7fJCZM/ZUJrAGWPI=;
 b=FRyloNMiLDeGvM73Nc0uPcsEy15cMJrbNoXUKvd+q7C2DGWLXlSYY5cVNmljqYiktq
 GsYImfzHMNbyA8ANgz/DWaM7gBtI4onJU/09pUdSxegsRY3kcyh8k1npnR+WP9OJ0Drr
 FZ1EJV+GYYfdO+SyeBUIu+zTPF+WwppKeIcV3p0Zfw7kkkT2YtnaJr+/fs7EBP5DPSDm
 g18oiDeGW8djb/NHx23kXA0tSvIBYFi4kTHP6Djd7oQpeRob1CHGnDuXdvjlpeEK4oKe
 oruhkisgsVVQWn4AkVUx0pCdpgKAjlHyg8i2LfVI9rXNKO84UluMdAj0wK+Oce0T4Fr0
 COTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746043093; x=1746647893;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i0EW0r1elhfGNzoz4neMN2bD2fJ7fJCZM/ZUJrAGWPI=;
 b=nnnwICcrEInz35VJi2b2L58xOYCjTEEZqgDQzzj4+nxIzD352dvmX8ibsV5eIMpRjF
 r4o0CJ/0n3v70+9lv4Y/SuH3oZdd7CvGG7wL7QOrs+1XmDhfBl2WEaRIaiL0pEcnQuZk
 8pb7+Ft/qaLn125FodhO/ZGLTLYWj314y2IKym7A5VQc2fm+LB7js80cyTWSE9cE6llV
 8gn6ABP7qxilybeAncMZjto5BFbFY9BNqz2qTGPmtwtcjspNEAFXYatfokpIhyAyBHHB
 y8cs4gOungNLvUt9bi2cb51AQgDHz1GMbmZKhhC8DsTYBxujNz1BcL75nBdgIBYRz650
 FJZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzgSruF34+6BWebywMuaPK0/JvwwFZihohLQjPGPKqUuiSXYYIRVsY3Yf6qRHVzl0eCNG5bfIedJdF@nongnu.org,
 AJvYcCVfHenem+YeuUKZz9fx8SVbrfxbHDEST0pkFSEyhffWCDnP//1/uidEjc+ILo5EumV5kDPJKOwniKt0vw==@nongnu.org
X-Gm-Message-State: AOJu0YyGG6fGHhWu4ATXz8RFtTCNebY1HGk5pNUA/6XATw8Ja4J6+UW0
 APLR0jd6m7nCnPfIPydgsrqOl/GrQODzH3dtRu200FiJ1Xsa26mn
X-Gm-Gg: ASbGnctJKX8xVnSJlWpnGnl1kDt+yThDm6ysm/m3Ee2AC4Qu8IiRT2Uw+J7mzZUQHD8
 vFSPxFZxBIMkAHHexgWv31gW2eERkn+f3wKNmt32BB2Y3gy3DUejreQ3CpmyNz2wfpQcoEVIaFe
 hhky1yiE9V+VhgjRuaS1ABz2kTAmQwXvl/lv4Wbb99Wnl5om55grf9/lvJZvNFC+YXVB/9L1x/W
 KpD0zrYOwr2DgSUukRyOrgoPIGPkrX25NImBZt28WaxreuhJjDGq43rVPZDGt9vFqyNvAn0om1Z
 seFpEfO7K8GFcWaRHraYPBcF5dsJLj/n8nbvHUmvSzdp/Sh141GOSYOr27xt/A+MyNF75QBWXKb
 75BoSMiDg81y9f0Sl
X-Google-Smtp-Source: AGHT+IFn6epG5Ozb+SA1oBM3vuej/uXwdl6+NYjYoVvEPjvS73lxdm3oQiXD8wp+sSHxK4QHxStiMw==
X-Received: by 2002:a05:600c:1f18:b0:43c:f616:f08 with SMTP id
 5b1f17b1804b1-441b1f35e13mr40426415e9.8.1746043093521; 
 Wed, 30 Apr 2025 12:58:13 -0700 (PDT)
Received: from smtpclient.apple (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2af2a5fsm36393115e9.20.2025.04.30.12.58.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Apr 2025 12:58:13 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH 2/2] block/null: Add read-pattern option
From: Nir Soffer <nirsof@gmail.com>
In-Reply-To: <87zffzpkvt.fsf@pond.sub.org>
Date: Wed, 30 Apr 2025 22:58:01 +0300
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <456AFCDD-37BE-4E27-9153-76F45AF764A2@gmail.com>
References: <20250427225900.24316-1-nirsof@gmail.com>
 <20250427225900.24316-3-nirsof@gmail.com>
 <pykbbqg7om2ahqs7h7gfstgvvlbfjc2gx3yobvbego6jrnqo6p@zohvnrrpfwce>
 <87zffzpkvt.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
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



> On 29 Apr 2025, at 9:00, Markus Armbruster <armbru@redhat.com> wrote:
>=20
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On Mon, Apr 28, 2025 at 01:59:00AM +0300, Nir Soffer wrote:
>>> When the `read-zeroes` is set, reads produce zeroes, and block =
status
>>> return BDRV_BLOCK_ZERO, emulating a sparse image.
>>>=20
>>> If we don't set `read-zeros` we report BDRV_BLOCK_DATA, but image =
data
>>> is undefined; posix_memalign, _aligned_malloc, valloc, or memalign =
do
>>> not promise to zero allocated memory.
>>>=20
>>> When computing a blkhash of an image via qemu-nbd, we want to test 3
>>> cases:
>>>=20
>>> 1. Sparse image: skip reading the entire image based on block status
>>>   result, and use a pre-computed zero block hash.
>>> 2. Image full of zeroes: read the entire image, detect block full of
>>>   zeroes and skip block hash computation.
>>> 3. Image full of data: read the entire image and compute a hash of =
all
>>>   blocks.
>>>=20
>>> This change adds `read-pattern` option. If the option is set, reads
>>> produce the specified pattern. With this option we can emulate an =
image
>>> full of zeroes or full of non-zeroes.
>>>=20
>>> Specifying both `read-zeroes` and `read-pattern !=3D 0` is not =
useful
>>> since `read-zeroes` implies a sparse image.  In this case =
`read-zeroes`
>>> wins and we ignore the pattern. Maybe we need to make the options =
mutual
>>> exclusive.
>>=20
>> I would lean towards an error.  It's easier to remove an error later
>> if we find it was too strict, than to be lax up front and then regret
>> it down the road when we wish we had been more strict.
>=20
> Seconded.  Silently "fixing" the user's nonsensical instructions is
> commonly a bad idea.

Thanks, making the options mutually exclusive.

>=20
>>> The following examples shows how the new option can be used with =
blksum
>>> (or nbdcopy --blkhash) to compute a blkhash of an image using the
>>> null-co driver.
>>>=20
>>> Sparse image - the very fast path:
>>>=20
>>>    % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/sparse.sock \
>>>        "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': =
'100g', 'read-zeroes': true}}" &
>>>=20
>>>    % time blksum 'nbd+unix:///?socket=3D/tmp/sparse.sock'
>>>    300ad1efddb063822fea65ae3174cd35320939d4d0b050613628c6e1e876f8f6  =
nbd+unix:///?socket=3D/tmp/sparse.sock
>>>    blksum 'nbd+unix:///?socket=3D/tmp/sparse.sock'  0.05s user 0.01s =
system 92% cpu 0.061 total
>>>=20
>>> Image full of zeros - same hash, 268 times slower:
>>>=20
>>>    % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/zero.sock \
>>>        "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': =
'100g', 'read-pattern': 0}}" &
>>>=20
>>>    % time blksum 'nbd+unix:///?socket=3D/tmp/zero.sock'
>>>    300ad1efddb063822fea65ae3174cd35320939d4d0b050613628c6e1e876f8f6  =
nbd+unix:///?socket=3D/tmp/zero.sock
>>>    blksum 'nbd+unix:///?socket=3D/tmp/zero.sock'  7.45s user 22.57s =
system 183% cpu 16.347 total
>>>=20
>>> Image full of data - difference hash, heavy cpu usage:
>>>=20
>>>    % ./qemu-nbd -r -t -e 0 -f raw -k /tmp/data.sock \
>>>        "json:{'driver': 'raw', 'file': {'driver': 'null-co', 'size': =
'100g', 'read-pattern': -1}}" &
>>>=20
>>>    % time blksum 'nbd+unix:///?socket=3D/tmp/data.sock'
>>>    2c122b3ed28c83ede3c08485659fa9b56ee54ba1751db74d8ba9aa13d9866432  =
nbd+unix:///?socket=3D/tmp/data.sock
>>>    blksum 'nbd+unix:///?socket=3D/tmp/data.sock'  46.05s user 14.15s =
system 448% cpu 13.414 total
>>>=20
>>> Tested on top of
>>> https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg05096.html.
>>>=20
>>> Signed-off-by: Nir Soffer <nirsof@gmail.com>
>>> ---
>>> block/null.c         | 17 +++++++++++++++++
>>> qapi/block-core.json |  9 ++++++++-
>>> 2 files changed, 25 insertions(+), 1 deletion(-)
>>=20
>> Should block status return ZERO|DATA when read-pattern=3D0 is =
present?
>>=20
>   diff --git a/qapi/block-core.json b/qapi/block-core.json
>   index b1937780e1..7d576cccbb 100644
>   --- a/qapi/block-core.json
>   +++ b/qapi/block-core.json
>   @@ -3297,10 +3297,17 @@
>    # @read-zeroes: if true, reads from the device produce zeroes; if
>    #     false, the buffer is left unchanged.
>    #     (default: false; since: 4.1)
>=20
> The commit message explains "read-zeroes": true behaves like a sparse
> image.  The existing doc comment does not.  I suspect it should.
>=20
>    #
>>> +# @read-pattern: if set, reads from the device produce the =
specified
>>> +#     pattern; if unset, the buffer is left unchanged.
>>> +#     (since: 10.1)
>>> +#
>>> # Since: 2.9
>>> ##
>>> { 'struct': 'BlockdevOptionsNull',
>>> -  'data': { '*size': 'int', '*latency-ns': 'uint64', =
'*read-zeroes': 'bool' } }
>>> +  'data': { '*size': 'int',
>>> +            '*latency-ns': 'uint64',
>>> +            '*read-zeroes': 'bool',
>>> +            '*read-pattern': 'int' } }
>>=20
>> Should this be 'uint8' instead of 'int', so that we aren't silently
>> truncating spurious upper bits when passing it to memset()?
>=20
> Yes, please.
>=20
> Without this, the doc comment does not sufficiently specify the =
contents
> of the image.  "The specified pattern" could be read as
>=20
> * Four bytes given by the 32 bit value of @read-pattern in big endian
>=20
> * or in little endian
>=20
> * or in host endian
>=20
> In fact, it's none of the above, it's the least significant byte.
>=20
> Please try to clarify the doc comment in addition to narrowing the =
type.

Fixing in v2.



