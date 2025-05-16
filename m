Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A440C3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 21:32:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uG2eW-0005mm-2o; Fri, 16 May 2025 17:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uG2eU-0005j3-0f; Fri, 16 May 2025 17:31:34 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uG2eS-0001CS-3I; Fri, 16 May 2025 17:31:33 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a0ba0b6b76so2248711f8f.1; 
 Fri, 16 May 2025 14:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747431090; x=1748035890; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Muwy0TJbEcYqhtMqmlugADkDHOQPzZbOzU91kRTRzS4=;
 b=IzLn2AuoqS47nWjfI0GoeRd5a6CccGeD5meO17/HYrxnjiOab0IxMU8PcOOyTdaEMA
 87OQyBhciMdCwsH6+1bXq6+/t9pRF05V/CrWJW5Bv7HzBw2QcSJM6VXtKNcNNJ2ztKnL
 tVeH9EVv7HwLJKPFbtOR5pACREkpuMMfApfyCz3UhlZRwcmgteT/mnDAmJsqmAfxWide
 itKNqzLpt78O26jzLkWwlagpLsGhsA3+YkF4uqoCeohMU/lP06HMp387p+kjd8B0QHno
 uafJiSmnieujc8iROg+yIe3lz3qJwoxO4USD/0ym+5JiKuuBu+moY410tmpPMTzmxNxE
 xCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747431090; x=1748035890;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Muwy0TJbEcYqhtMqmlugADkDHOQPzZbOzU91kRTRzS4=;
 b=kJ0c3uhYlXPSP4QlA3xtPVdg5blaaEW4s3K0vhTIamNxqAw7XoifaGJHvTGenYOSUK
 q93zLDNzOwfRZ6oMCWM3bJK6HqQ4BxVsSPbkj7Snro0r1oDAmmvqwhVnC96hvXNK80lz
 iDRI1kVI+wIYdkRo6esdQUu5v8E4KRHrS4/myUUxP42VV1g5NBvvYJ+4d58WPPpNoucN
 nSrirFNyriNkJXnQJW5aXIHZup2QvPS1v2O4nram50tRASahXgXIG17Q5NHxFLxnBg9A
 bXh/qxJDdeeTFgXj7Ww+GA6UslS9ExUZtC8e6xRnyEK5MRYzFlS8zZszBT7a6tqx69He
 EWiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWglGf9wvoTwF/OmwO71o752jiX4kmW8KURMhedkf1R7xSNlLJJN75y2NG+L+9ClMj9nGomA76ucATy@nongnu.org
X-Gm-Message-State: AOJu0YwjAv+NSXl5M55iyJX1d6CqfTp5Q5zLE6uxKdimYPWuLRDVsMVW
 1UnMjyFU9GFPGefeIyZofaXTHCDVkpbDh1vmfx8YBuj3z96i5aEl7MqC
X-Gm-Gg: ASbGncvd99wqid/M1bne4/0jGlrPczM6wLtCMRzHfdE9pElAKzaLomxs46VJEdusjm2
 RFIMz68rO1dI0woTa9nGtI/1xA8C8tXoaGPZ91uTXGwDdH9G3QF30zbbFRXOpTWyuqHLBQNPdmc
 9mQ4uGEG+LHX5TMxmf/Ek0o/JIXc2Lz4MkBkOPxVoOlIYoFAF6xJTXSLFm14F6Djw+OBwM8jowf
 NLAp+5Kzu/Z1Gg8KDrJyLR9oFIgQQwpPtQ0o/xF3FTDUt5e2+WYcOtpjkrtFoMpvgFtvtDjAffq
 7R1qfTB3jfmcvwqFOCZtl7+kNe06XVskaQpf0SyEw1NAVXYBiZ2t5wLdNidMCA0EEbUC02EqWMM
 hBOdgb4PXRWWgO0NBRfpGEt6zllfMPpi+
X-Google-Smtp-Source: AGHT+IHiqDcH636thDaHECYZ26ZfD8hJzX+vElpbuXgAhqJsTlvFhCvRFjPPsYeNcONmBF/ecLYYcw==
X-Received: by 2002:a05:6000:2407:b0:3a3:4baa:3ea3 with SMTP id
 ffacd0b85a97d-3a35ffd2ae4mr3434695f8f.41.1747431089821; 
 Fri, 16 May 2025 14:31:29 -0700 (PDT)
Received: from smtpclient.apple (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8d258sm3974246f8f.100.2025.05.16.14.31.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 May 2025 14:31:29 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 1/2] block/null: Report DATA if not reading zeroes
From: Nir Soffer <nirsof@gmail.com>
In-Reply-To: <87plgjg1kh.fsf@pond.sub.org>
Date: Sat, 17 May 2025 00:31:17 +0300
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5F6E3D44-70D6-4F6E-B4D5-42238E13D759@gmail.com>
References: <20250430203717.16359-1-nirsof@gmail.com>
 <20250430203717.16359-2-nirsof@gmail.com> <87plgjg1kh.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x42a.google.com
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



> On 8 May 2025, at 7:37, Markus Armbruster <armbru@redhat.com> wrote:
>=20
> Nir Soffer <nirsof@gmail.com> writes:
>=20
>> If read-zeroes is not set, we did not report BDRV_BLOCK_DATA or
>> BDRV_BLOCK_ZERO. This is not consistent with other drivers and can
>> confuse users or other programs:
>>=20
>>    % qemu-img map --output json "json:{'driver': 'raw', 'file': =
{'driver': 'null-co', 'size': '1g'}}"
>>    [{ "start": 0, "length": 1073741824, "depth": 0, "present": false, =
"zero": false, "data": false, "compressed": false}]
>>=20
>>    % qemu-nbd "json:{'driver': 'raw', 'file': {'driver': 'null-co', =
'size': '1g'}}" &
>>=20
>>    % nbdinfo --map nbd://127.0.0.1
>>             0  1073741824    1  hole
>>=20
>> With this change we report DATA in this case:
>>=20
>>    % ./qemu-img map --output json "json:{'driver': 'raw', 'file': =
{'driver': 'null-co', 'size': '1g'}}"
>>    [{ "start": 0, "length": 1073741824, "depth": 0, "present": true, =
"zero": false, "data": true, "compressed": false, "offset": 0}]
>>=20
>>    % ./qemu-nbd "json:{'driver': 'raw', 'file': {'driver': 'null-co', =
'size': '1g'}}" &
>>=20
>>    % nbdinfo --map nbd://127.0.0.1
>>             0  1073741824    0  data
>>=20
>> Signed-off-by: Nir Soffer <nirsof@gmail.com>
>> ---
>> block/null.c         | 4 +---
>> qapi/block-core.json | 5 +++--
>> 2 files changed, 4 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/block/null.c b/block/null.c
>> index dc0b1fdbd9..7ba87bd9a9 100644
>> --- a/block/null.c
>> +++ b/block/null.c
>> @@ -239,9 +239,7 @@ static int coroutine_fn =
null_co_block_status(BlockDriverState *bs,
>>     *map =3D offset;
>>     *file =3D bs;
>>=20
>> -    if (s->read_zeroes) {
>> -        ret |=3D BDRV_BLOCK_ZERO;
>> -    }
>> +    ret |=3D s->read_zeroes ? BDRV_BLOCK_ZERO : BDRV_BLOCK_DATA;
>>     return ret;
>> }
>>=20
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index b1937780e1..7c95c9e36a 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -3293,8 +3293,9 @@
>> #     requests.  Default to zero which completes requests =
immediately.
>> #     (Since 2.4)
>> #
>> -# @read-zeroes: if true, reads from the device produce zeroes; if
>> -#     false, the buffer is left unchanged.
>> +# @read-zeroes: if true, emulate a sparse image, and reads from the
>> +#     device produce zeroes; if false, emulate an allocated image =
but
>> +#     reads from the device leave the buffer unchanged.
>> #     (default: false; since: 4.1)
>> #
>> # Since: 2.9
>=20
> Possibly dumb question: how is this doc change related to the code =
fix?

Before this change we returned BDRV_BLOCK_ZERO if read-zeroes is true, =
and no flags when it was false.
Now we return BDRV_BLOCK_ZERO when read-zeroes is true, and =
BDRV_BLOCK_DATA when false.

In other words, we read-zeroes: true emulate a spare image, and =
read-zeros: false an allocated image.

>=20
> Suggest to split the sentence for easier reading:
>=20
>   # @read-zeroes: If true, emulate a sparse image, and reads from the
>   #     device produce zeroes.  If false, emulate an allocated image,
>   #     but reads from the device leave the buffer unchanged.
>=20

Sure, it looks better.


