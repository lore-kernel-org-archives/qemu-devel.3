Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4905D4417D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 11:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU0sc-0001d2-QN; Fri, 12 Dec 2025 06:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU0sb-0001cg-K5
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 06:00:09 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU0sZ-0007MD-Oc
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 06:00:09 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42b3c5defb2so651358f8f.2
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 03:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765537205; x=1766142005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=duN6vvaY89poE8Q7Ir7RgCJA2pebV5WxwKFB19LHt/Q=;
 b=vOUWeHLe30uKaFBcdPSE0CfsSQsH8Vc+DZ8LzEAJhVYZOOg1OpRqjbdBiO6xJJWXLS
 sN1+P7z4QdHUcmPNPJPYOvz79tthDP8AKHwMEqQn9/GFatOr25U1oT7gCgg4NnqaW8y7
 m6hWdGOVtU/1BZG+3SqLth49kAnV6Gtu97pmOdIFFaB0Z6d8l1IR5/4CzMe0/pd5EwWt
 K5lLhWl7wR5CX2t2c2XDz9FvvsZxELc//66euW2XJTdDIZpuNjXUkBStlCtZnqX8j1yZ
 XccVklal/RIJjlkIqzJQf3GF2NVNfXlzCIPIFQHQxuwelfFbEBjoSxP5Bz0F5ARt0FmC
 byEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765537205; x=1766142005;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=duN6vvaY89poE8Q7Ir7RgCJA2pebV5WxwKFB19LHt/Q=;
 b=jvdNeYuzh9tvWPiQVMKIyZ/Sw95YOioTcAOumNoS1sClbdKVkZUZn7tJRsY4S0cVxm
 BKQQ88SS49uNvmK8O3rXtpjCq7fgI9e0m/HwX9wjxGeKPzsOvEbTDUCs4nuI/jh/RMy4
 quaY0Upt/nQ1SI69bZPvABkB9re9sO0hDXpOW0Wk7baoYXhO+U+Y3hhBQKWX8wvydZ43
 H2kPTejni2PaICpQNbF8ceEzoYb2k1c+sw/ni06VFT9I090uxPBo6p9EDbQZX0yphkqS
 Clsf3O9lrWLuY3FYhX7jAavHANNyngBRO8/q5l4bORrsNc2Z7fAbhVeeYwz0N5uz058U
 wMMw==
X-Gm-Message-State: AOJu0Yx1FotgystqoTK6Nj6o5OIVMPCN3/SqGE8qcOfBrvvGYRP+mgzu
 8pFf5qULJQZJXMkqInfk7fTIR76QiahpEbi74ATFMXOJaGl+h0haZG+X/tGcxf9tBxE=
X-Gm-Gg: AY/fxX4TR5pqkc+Jc1dNkO503lMheX0wVsI23RVoIhSohPuWYX0RZVX/DQP/KHKOn+f
 gH6+IwLJyzxx+fpSJ9ob5HmpCCEyXjEXI2osakGGkU4iZByBNi4qT5xV1/7i3Po/ndRbXLWcmAc
 gD7nguA5bK/7UTS2ody+QB25cKKm8fmCreb3DVw8Gz/ETOGfjYwNtNLVN1uBCsBkmqIjF85xrV+
 0PqwgOPCNgigVD25ZpvPjtcRxdtaEAFOZopu+Dw1lTj54b5qDkMt6gPj3ytcbP+D0BJXx5o7trt
 p0He72RxwgDErJ9+G9MqgUJNVRvykY2WyUxtt1XM1P3165PDsDKd+mI+QK8+t9aJkZETaqatQSJ
 PUqsNw4+tBU4O510qZebh7CatN4IxA/Fy5dpEbori+7RYq9ZU4z0a0UQliwL9oulpkdk7cg5WtC
 OZ9C9apZqIsxs=
X-Google-Smtp-Source: AGHT+IFtm/gKREWEw/b2u+oo0C6KQ42TipD5XmFYI3mjZzwi9/bEi3f6pzHzX7FaehjmG4vIOcF87g==
X-Received: by 2002:a05:6000:420c:b0:42f:8817:7ef with SMTP id
 ffacd0b85a97d-42fb492d36dmr1717804f8f.60.1765537205181; 
 Fri, 12 Dec 2025 03:00:05 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a741c9sm12013754f8f.19.2025.12.12.03.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 03:00:04 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3C8585F82E;
 Fri, 12 Dec 2025 11:00:03 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 0/9] for 11.0 conversion* of get_maintainers.pl to
 python
In-Reply-To: <aTvPDXZjfp4_egTa@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 12 Dec 2025 08:15:28 +0000")
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
 <aTvPDXZjfp4_egTa@redhat.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Fri, 12 Dec 2025 11:00:03 +0000
Message-ID: <87zf7ot170.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Dec 11, 2025 at 06:01:23PM +0000, Alex Benn=C3=A9e wrote:
>> *incomplete
>>=20
>> I wanted to look at adding gitlab tags to MAINTAINERS and baulked
>> slightly at figuring out what I would need to change in the perl
>> script to cleanly handle it.
>>=20
>> While we imported the perl script from the kernel I'm fairly sure we
>> don't use half the features it has and as us grey beards age out less
>> people will be willing to tweak it. Consider this a proof-of-concept
>> for discussion about if it is worth perusing this path.
>>=20
>> It only supports the two main forms:
>>=20
>>   ./scripts/get_maintainer.py -f path/to/file
>>   ./scripts/get_maintainer.py path/to/patch1 path/to/patch2 ...
>>=20
>> But who needs more?
>
> the $QEMU/.gitpublish file contains
>
> cccmd =3D scripts/get_maintainer.pl --noroles --norolestats --nogit --nog=
it-fallback 2>/dev/null
>
> And the .b4-config file contains the same:
>
> send-auto-cc-cmd =3D scripts/get_maintainer.pl --noroles --norolestats --=
nogit --nogit-fallback
>
>
> Is trawling the git history to guess at maintainers useful
> for regular usage, while undesirable for sending patches,
> or should we just pick a behaviour use it unconditionally?

We can certainly add the ability to dig through git but to honest those
doing archaeology are probably better off reading the logs. The default
it just to match paths to MAINTAINERS which I think is what the main use
is. It's not called get_git_blame_info.py ;-)

>
>>=20
>> Future improvements could include some more detailed analysis in
>> conjugation with the repo to analysis:
>>=20
>>   - missing areas of coverage
>>   - maintainer stats
>>=20
>> Who knows maybe the kernel guys will want to import our script one day
>> ;-)
>>=20
>> Alex.
>>=20
>> Alex Benn=C3=A9e (9):
>>   MAINTAINERS: fix missing names
>>   MAINTAINERS: fix libvirt entry
>>   MAINTAINERS: regularise the status fields
>>   scripts/get_maintainer.py: minimal argument parsing
>>   scripts/get_maintainer.py: resolve the source path
>>   scripts/get_maintainer.py: initial parsing of MAINTAINERS
>>   scripts/get_maintainer.py: add support for -f
>>   scripts/get_maintainer.py: add support reading patch files
>>   gitlab: add a check-maintainers task
>>=20
>>  MAINTAINERS                    |  10 +-
>>  .gitlab-ci.d/static_checks.yml |   9 +
>>  scripts/get_maintainer.py      | 356 +++++++++++++++++++++++++++++++++
>>  3 files changed, 370 insertions(+), 5 deletions(-)
>>  create mode 100755 scripts/get_maintainer.py
>>=20
>> --=20
>> 2.47.3
>>=20
>>=20
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

