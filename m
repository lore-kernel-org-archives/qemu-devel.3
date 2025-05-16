Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0352C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 21:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uG2fL-0008Ij-O2; Fri, 16 May 2025 17:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uG2fJ-00089O-6y; Fri, 16 May 2025 17:32:25 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uG2fG-0001EI-DS; Fri, 16 May 2025 17:32:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-442ea341570so16260595e9.1; 
 Fri, 16 May 2025 14:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747431140; x=1748035940; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtyjIVl3b5mGTVV9h5+2g91KdE7y37iUhpaNahwYAeU=;
 b=b4DXWAA/tELpUnPYtA+30AXAdH41F31vgVILKxkt4h/rLHJrIvECPbKSd8nR7Snb8O
 R6tPnY6TcJJ9ZbYT4dxuAjDwNoO+muEaE5Egvwpy95gRuCcQEOc+lx6cwToni0yZleu6
 MrUlMQQvBvC7Ru7mRt9Nur75Wy1MbGJPJRVzs+FQwLjFdgV/foNx03+zziWo4LII5V0g
 LM7jiAeXuBH65bfAZkFTKUlZ9b1HN9bBWfF1n7AeL9K2ze03pNngrfVWmu1V2C3rdJGQ
 K/d0MjhaITEf5MIP1oqHPyVeCe0naXJh14d+oSxDSekYCPirsFVfumrMmaM0l9q/2iGK
 jEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747431140; x=1748035940;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xtyjIVl3b5mGTVV9h5+2g91KdE7y37iUhpaNahwYAeU=;
 b=AStOItLsKcvA7BqbrM+GvkOvgUijd8Xoas8IYmlwdEbnl/NhmpNrg4qS9w3iZ19yVM
 S+jeAXjJpbkT6yte6VAoRhw2o3Ew8n2IBPSp3elZzuvs6tgdKYFFqqnUodwB18x4OlhC
 H0DKcBqkimZCslpO8c/s3m8mcTiHq+XXt6U7vVkaZZs3vPKdVenKNFZy3XUiK2oa29jV
 uXR6MG2XZIDWqhcr+fVfj2/jnLvrQtBX0HI1TIiofGyMFD0LQeNfvXEBA+V1M/SmpA6c
 AoJFgcB0/r3kaSUSfhXGkx2hrHTJkxtFdiiyNaF5lklKUM/fiDmsVk2/3yBRH43cvfa4
 Wtdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAtTxn4sfU3JAfP0KtYjboe+qQ2PCB0ydbpvfUS8KWEfDpJb5rr8NYUc4WWbCl4KjiJBOaMaHxlW1O@nongnu.org
X-Gm-Message-State: AOJu0YxnVlAhHK3MXaFWLldA8RqWDUqCloLzCk9wtQ8OEM3qGcXn/RZd
 GEOxKXgxQZ6xQU9Inx/+ygCTosxzMEnbYcryl9fDrJa2CI7YZQt77veP6J7HhuUQBNo=
X-Gm-Gg: ASbGnctKbb0XbsqhaihC6K+5aFpR6zLkeLwu0m8ygwBbUtSzemEjape4NAcROJlq3a7
 Y9K/0YFNPBzGTMIc47HnEdnR4HJ+G2hAzgZWqIpcOiTJ+Z/zTxCEEWZ5F8/1Sk/DzxoW8JriRXA
 xr5mQgS4qvYNmv7hJYBLd2XaJlHNtdyloPvV31swvgg0HRmqNPJTlSreUezTZP77F9e7rcOJwsK
 u39+mfXLfqladWYX+6wqKm7CmHzZjiqhqj8HZGAJRiQqwE6oSrWgdJyZRN93wbPmtR1sekLWmj1
 An6IeyAZjIl7PNU5LYtPmBd3QSOWgm3GdWimgJuVq08oytvqkaNL8Y1sv5sBrOPEvDwMv/WAEGJ
 RoVMuqi8QQS4+Wl5ZKCvQ2qGwUAuHbOQ6XLL62ps2l/I=
X-Google-Smtp-Source: AGHT+IEIQkBBd5cm/Cb1nS6dqUa/bNNfx18hpQqas904ZYRXViaZfkoRXIN/bAl8wss+l5AEhXQC5Q==
X-Received: by 2002:a05:6000:1881:b0:399:71d4:a2 with SMTP id
 ffacd0b85a97d-3a35fe673c1mr3782946f8f.14.1747431140345; 
 Fri, 16 May 2025 14:32:20 -0700 (PDT)
Received: from smtpclient.apple (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8d258sm3974246f8f.100.2025.05.16.14.32.18
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 May 2025 14:32:19 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 1/2] block/null: Report DATA if not reading zeroes
From: Nir Soffer <nirsof@gmail.com>
In-Reply-To: <87wmarelsh.fsf@pond.sub.org>
Date: Sat, 17 May 2025 00:32:08 +0300
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A2815EA-3A03-494B-8EFD-A1E4118650A4@gmail.com>
References: <20250430203717.16359-1-nirsof@gmail.com>
 <20250430203717.16359-2-nirsof@gmail.com> <87plgjg1kh.fsf@pond.sub.org>
 <87wmarelsh.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x32d.google.com
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



> On 8 May 2025, at 8:03, Markus Armbruster <armbru@redhat.com> wrote:
>=20
> Markus Armbruster <armbru@redhat.com> writes:
>=20
>> Nir Soffer <nirsof@gmail.com> writes:
>>=20
>>> If read-zeroes is not set, we did not report BDRV_BLOCK_DATA or
>>> BDRV_BLOCK_ZERO. This is not consistent with other drivers and can
>>> confuse users or other programs:
>>>=20
>>>    % qemu-img map --output json "json:{'driver': 'raw', 'file': =
{'driver': 'null-co', 'size': '1g'}}"
>>>    [{ "start": 0, "length": 1073741824, "depth": 0, "present": =
false, "zero": false, "data": false, "compressed": false}]
>>>=20
>>>    % qemu-nbd "json:{'driver': 'raw', 'file': {'driver': 'null-co', =
'size': '1g'}}" &
>>>=20
>>>    % nbdinfo --map nbd://127.0.0.1
>>>             0  1073741824    1  hole
>>>=20
>>> With this change we report DATA in this case:
>>>=20
>>>    % ./qemu-img map --output json "json:{'driver': 'raw', 'file': =
{'driver': 'null-co', 'size': '1g'}}"
>>>    [{ "start": 0, "length": 1073741824, "depth": 0, "present": true, =
"zero": false, "data": true, "compressed": false, "offset": 0}]
>>>=20
>>>    % ./qemu-nbd "json:{'driver': 'raw', 'file': {'driver': =
'null-co', 'size': '1g'}}" &
>>>=20
>>>    % nbdinfo --map nbd://127.0.0.1
>>>             0  1073741824    0  data
>>>=20
>>> Signed-off-by: Nir Soffer <nirsof@gmail.com>
>>> ---
>>> block/null.c         | 4 +---
>>> qapi/block-core.json | 5 +++--
>>> 2 files changed, 4 insertions(+), 5 deletions(-)
>>>=20
>>> diff --git a/block/null.c b/block/null.c
>>> index dc0b1fdbd9..7ba87bd9a9 100644
>>> --- a/block/null.c
>>> +++ b/block/null.c
>>> @@ -239,9 +239,7 @@ static int coroutine_fn =
null_co_block_status(BlockDriverState *bs,
>>>     *map =3D offset;
>>>     *file =3D bs;
>>>=20
>>> -    if (s->read_zeroes) {
>>> -        ret |=3D BDRV_BLOCK_ZERO;
>>> -    }
>>> +    ret |=3D s->read_zeroes ? BDRV_BLOCK_ZERO : BDRV_BLOCK_DATA;
>>>     return ret;
>>> }
>>>=20
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index b1937780e1..7c95c9e36a 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -3293,8 +3293,9 @@
>>> #     requests.  Default to zero which completes requests =
immediately.
>>> #     (Since 2.4)
>>> #
>>> -# @read-zeroes: if true, reads from the device produce zeroes; if
>>> -#     false, the buffer is left unchanged.
>>> +# @read-zeroes: if true, emulate a sparse image, and reads from the
>>> +#     device produce zeroes; if false, emulate an allocated image =
but
>>> +#     reads from the device leave the buffer unchanged.
>>> #     (default: false; since: 4.1)
>>> #
>>> # Since: 2.9
>>=20
>> Possibly dumb question: how is this doc change related to the code =
fix?
>>=20
>> Suggest to split the sentence for easier reading:
>>=20
>>   # @read-zeroes: If true, emulate a sparse image, and reads from the
>>   #     device produce zeroes.  If false, emulate an allocated image,
>>   #     but reads from the device leave the buffer unchanged.
>=20
> false is a security hazard, as secure-coding-practices.rst points out.
> I think it should be pointed out right here as well.  Especially since
> "security hazard" is the default!
>=20
> I'd do it in a separate patch, but I'm a compulsive patch splitter.
>=20

I agree, we need to warn about this unexpected behavior.


