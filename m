Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D804FC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 21:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uG2MP-00077a-E1; Fri, 16 May 2025 17:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uG2ML-00073V-Oq; Fri, 16 May 2025 17:12:49 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1uG2MJ-0007O3-GC; Fri, 16 May 2025 17:12:49 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a0bd7f4cd5so2389003f8f.0; 
 Fri, 16 May 2025 14:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747429965; x=1748034765; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s5jPWh1YIMmeVXXNiH9wYf7MeOD1v5MQwdjNu/o3RXM=;
 b=GZMRtjQZMa8XP9Pyt4Gd/wDUB3OyIHYthTESnnsaEE7VUn8PPLz1CMu+z597lH6rzW
 rit27llPnh060HgGxWLOMNCGEnj/6paq3tyNqXN/189DY/9LEcK/t/jYncn+JJJxYPgb
 yGFKZWLECnmhcckswsxp/pIDKbXJ7xG9pYNe3Y6QGtOVvuVZpm2UJjQkrAtcaVlw+qSH
 a4iN72gQnmSQtF5148ECmAp8dDAHhVvzI4DFSLtryo5TESoy1DaWllvRX6jUsmGR1FMI
 LGELMSfnU0Yu6deCXbr5uCZ5o7uxtpsdnS3uKvzQTtKj488LHAbzq89hYXZnh1BQOhQA
 IijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747429965; x=1748034765;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s5jPWh1YIMmeVXXNiH9wYf7MeOD1v5MQwdjNu/o3RXM=;
 b=ljq8NTe2nB1wxfOkUA+zLA2tCMsYJPMTW/vzBHF0L2+lMT0MGc+Em0H3exGIeAKBor
 vwlquhZV6Dtj8moTKPwFSzZ9gTo0wE+gP3x/LbOym+qOAw/FXz9K+TlO8vDPjIqP2o4J
 qmR5QvRs5bcIlwGMqIekNqXHgiZcM/LZBwGgdSOKw90hr+0Ivkw2Zs0z0IHtqgeEOLWQ
 o8je9Xq4ynuf4svaQiVJfBuYL6/y2l/GO9qOdnY/F1kjK9I3sPYoLSTEJDK+7SrjyYm7
 4GqJny+0SEtkNhypdWHmqPNtBQhVS5DlU59JkDwRDthZFKnMZVLzfGagWu4muqppavuo
 J2/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIFKnLU3306NMDGIa/OSZW3DuA0cjH+IoTqlKICPYl+mgYSGDl4TN+PgkPnltM6cyAPNpdCaHIr8oT@nongnu.org
X-Gm-Message-State: AOJu0YwE/ZDwnMXSD3tDo529AfttbHCdRjvXP6ZTooemk95PDohF0J0W
 pBf66GEB7Z86PLMIQR5F9Msx7oUoZ9ZA8x52DtzIbn65LiNVDip5teMeXV863OMFJRk=
X-Gm-Gg: ASbGnctrEkSbgGnA6n6hzUzsTahmCQkpF0EnpqVjKz/3u7/GzjrS81QQxDWr3ylCzje
 j+tSSOpZPawoVRHXaCXZETjLx0Gm4t5i3bCkWFGol/94NlxkRTCyEriXumXy+HwA6Hfc7wtlcVw
 sRnKS3M1Z+cCTO2El20znLE/uA77Pb/Qtu/3yLJ7ACOTsjCKHqIBpx/CGsgotMiKqvlZv+FWm8R
 9DjO6paIt7sXeoykfjA8caSnD9sFFsXht/y2CRpKbYW5SXrWqDzSGl+j2x9WfbxsEwT1QtGPNpm
 FqQfSB5wteeX+PSZFaMk6+GuTAUG8IQtPFRtc+9kIl5ikoKFpYzENZ5SO8n+aLrZlvHXzDsIzvV
 +HCqgw/gaGT/gjG8ncJ18VRhw81yBa/oO
X-Google-Smtp-Source: AGHT+IFHbZCUfPSRFA4YsW9/CJ6usvqu84DhVl87SMIzb+FTCrzcWWccrodY8TEIZcdNS+VPjExFOw==
X-Received: by 2002:a05:6000:2387:b0:3a1:fd60:88d with SMTP id
 ffacd0b85a97d-3a35c8255femr4753369f8f.23.1747429964474; 
 Fri, 16 May 2025 14:12:44 -0700 (PDT)
Received: from smtpclient.apple (46-116-102-127.bb.netvision.net.il.
 [46.116.102.127]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca62910sm4089297f8f.50.2025.05.16.14.12.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 May 2025 14:12:43 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 2/2] block/null: Add read-pattern option
From: Nir Soffer <nirsof@gmail.com>
In-Reply-To: <87h61vekn9.fsf@pond.sub.org>
Date: Sat, 17 May 2025 00:12:32 +0300
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D4B1B6B9-C361-4D49-AD28-A87AE7FD42CB@gmail.com>
References: <20250430203717.16359-1-nirsof@gmail.com>
 <20250430203717.16359-3-nirsof@gmail.com> <87h61vekn9.fsf@pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x42b.google.com
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



> On 8 May 2025, at 8:28, Markus Armbruster <armbru@redhat.com> wrote:
>=20
> Nir Soffer <nirsof@gmail.com> writes:
>=20
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
'100g', 'read-pattern': 255}}" &
>>=20
>>    % time blksum 'nbd+unix:///?socket=3D/tmp/data.sock'
>>    2c122b3ed28c83ede3c08485659fa9b56ee54ba1751db74d8ba9aa13d9866432  =
nbd+unix:///?socket=3D/tmp/data.sock
>>    blksum 'nbd+unix:///?socket=3D/tmp/data.sock'  46.05s user 14.15s =
system 448% cpu 13.414 total
>>=20
>> Specifying both `read-zeroes` and `read-pattern` is an error since
>> `read-zeroes` implies a sparse image. Example errors:
>>=20
>>    % ./qemu-img map --output json \
>>        "json:{'driver': 'raw', 'file': {'driver': 'null-co', =
'read-pattern': -1}}"
>>    qemu-img: Could not open 'json:{...}': read_pattern is out of =
range (0-255)
>>=20
>>    % ./qemu-img map --output json \
>>        "json:{'driver': 'raw', 'file': {'driver': 'null-co', =
'read-pattern': 0, 'read-zeroes': true}}"
>>    qemu-img: Could not open 'json:{...}': The parameters read-zeroes =
and read-pattern are in conflict
>>=20
>> Tested on top of
>> https://lists.gnu.org/archive/html/qemu-devel/2025-04/msg05096.html.
>>=20
>> Signed-off-by: Nir Soffer <nirsof@gmail.com>
>=20
> [...]
>=20
>> diff --git a/docs/devel/secure-coding-practices.rst =
b/docs/devel/secure-coding-practices.rst
>> index 0454cc527e..73830684ea 100644
>> --- a/docs/devel/secure-coding-practices.rst
>> +++ b/docs/devel/secure-coding-practices.rst
>> @@ -111,5 +111,6 @@ Use of null-co block drivers
>> The ``null-co`` block driver is designed for performance: its read =
accesses are
>> not initialized by default. In case this driver has to be used for =
security
>> research, it must be used with the ``read-zeroes=3Don`` option which =
fills read
>> -buffers with zeroes. Security issues reported with the default
>> +buffers with zeroes, or with the ``read-pattern=3DN`` option which =
fills read
>> +buffers with pattern. Security issues reported with the default
>> (``read-zeroes=3Doff``) will be discarded.
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 7c95c9e36a..2205ac9758 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -3295,13 +3295,23 @@
>> #
>> # @read-zeroes: if true, emulate a sparse image, and reads from the
>> #     device produce zeroes; if false, emulate an allocated image but
>> -#     reads from the device leave the buffer unchanged.
>> +#     reads from the device leave the buffer unchanged. Mutually
>> +#     exclusive with @read-pattern.
>> #     (default: false; since: 4.1)
>=20
> Correct before the patch: absent behaves just like present and false.
>=20
> That's no longer the case afterwards.  Hmm.

I don=E2=80=99t get the issue

>=20
>> #
>> +# @read-pattern: if set, emulate an allocated image, and reads from =
the
>> +#     device produce the specified byte value; if unset, reads from =
the
>> +#     device leave the buffer unchanged. Mutually exclusive with
>> +#     @read-zeroes.
>> +#     (since: 10.1)
>=20
> Default?  The usual way to document it would be something like =
(default:
> false), but that's again problematic.

This is optional, so we cannot have a default. Maybe (default absent)?

>=20
>> +#
>> # Since: 2.9
>> ##
>> { 'struct': 'BlockdevOptionsNull',
>> -  'data': { '*size': 'int', '*latency-ns': 'uint64', '*read-zeroes': =
'bool' } }
>> +  'data': { '*size': 'int',
>> +            '*latency-ns': 'uint64',
>> +            '*read-zeroes': 'bool',
>> +            '*read-pattern': 'uint8' } }
>>=20
>> ##
>> # @BlockdevOptionsNVMe:
>=20
> Let's take a step back from the concrete interface and ponder what =
we're
> trying to do.  We want three cases:
>=20
> * Allocated, reads return unspecified crap (security hazard)
>=20
> * Allocated, reads return specified data
>=20
> * Sparse, reads return zeroes
>=20
> How would we do this if we started on a green field?
>=20
> Here's my try:
>=20
>    bool sparse
>    uint8 contents

The names are short and nice, but we need to consider the entire API. =
"read-zeroes" works well with "detect-zeroes". "read-pattern" works well =
with "read-zeroes=E2=80=9D and the term =E2=80=9Cpattern=E2=80=9D works =
well with qemu-io -c:

    read [-abCqrv] [-P pattern [-s off] [-l len]] off len -- reads a =
number of bytes at a specified offset
    write [-bcCfnqruz] [-P pattern | -s source_file] off len -- writes a =
number of bytes at a specified offset

There is also nbdkit pattern plugin in this space:
https://libguestfs.org/nbdkit-pattern-plugin.1.html

>=20
> so that
>=20
> * Allocated, reads return unspecified crap (security hazard)
>=20
>  @sparse is false, and @contents is absent
>=20
> * Allocated, reads return specified data
>=20
>  @sparse is false, and @contents is present
>=20
> * Sparse, reads return zeroes
>=20
>  @sparse is true, and @contents must absent or zero

=E2=80=9Csparse" conflicts with =E2=80=9Ccontents=E2=80=9D. I would not =
make both possible even if contents is 0.=20

>=20
> I'd make @sparse either mandatory

Do you mean must be always specified? Why?

> or default to true, so that we don't
> default to security hazard.

Default sparse sounds good, but it means that we must use:

    =E2=80=9Csparse": false, =E2=80=9Ccontents=E2=80=9D: 42

So we must use the conflicting options together.

=E2=80=9Csparse=E2=80=9D: false is a better default, expect the =
unspecified bytes, but it should not depend on spareness.

>=20
> Unless we want to break compatibility, we're stuck with the name
> @read-zeroes for the bool, and its trap-for-the-unwary default value,
> but cleaner semantics seem possible.
>=20
> Thoughts?

Having "sparse": true default is little better than returning =
unspecified data by default, but sing =E2=80=9Csparse=E2=80=9D: false =
will return unspecified bytes and is not expected - spareness should not =
be related to security.

If we want to make this secure by default, maybe:

   bool sparse: emulate sparse image (default false)
   uint8 contents: read return specified bytes (default 0)
   bool insecure: read return unspecified bytes, for performance testing =
(default false)

Another way is to accept invalid value for unspecified content:

   bool sparse: emulate sparse image (default false)
   uint8 contents: read return specified bytes. -1 to return unspecified =
bytes (default 0)

This may be confusing, users may assume that -1 and 255 will give the =
same result.

Another way is to use lower level terms:

    uint8 block-status: flags to return in block_status: (default 0x0, =
zero 0x1, data 0x2)
    uint8 read-pattern: return specified bytes. -1 to return unspecified =
bytes (default 0)

This is harder to use but allows more combinations that can be useful or =
testing NBD. And the default is secure.

But the important questions are:
- Do we want to keep read-zeros?
- Do we want to keep the insecure default or make insecure behavior =
explicit?


