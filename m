Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDD5C982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rUu-0008Sb-UB; Wed, 16 Sep 2026 11:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rUs-0008SA-IR
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:24:30 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x6rUq-0008PN-Cd
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:24:30 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so6177115e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789572267; x=1790177067; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=F1lVPgrVXosJs0Xgh5TYc5jGRt/0w7i6lwMbv5skEgs=;
 b=WUtbZZf9eiumeUiLCrpx3r3Xfwug9zKgEtDDntMfkp9MYQCGKhpUWlWjm5TVwBBkgm
 +9xPafpu1r2ud+F8k0VntPsI3MQ4WDTnulvUtEY+bs4GqXwTRRQueCoOXPQwSvgYuhpz
 qua2WMaztxT49TNVjjIAUO8D+ub1B1fRDiEXWF3qexoPJtrbo3aOPh6dnF/HQwXThOwN
 h9la5MrkeLHVHTU37bugQoxqdReTp0dH168h8zKBDatGJp1IskZphdkvl7FljalGJIfT
 PPCU9728lBECg+SmvcnDoiWRyDsaYeBTM/m9YlUG1YuXfglq7pMMU4oFZZWPB/+P8qil
 9YHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789572267; x=1790177067;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F1lVPgrVXosJs0Xgh5TYc5jGRt/0w7i6lwMbv5skEgs=;
 b=zjQ6/7V0ts/UhPuPPY0jlVgBNi6iqxJBHJRWiRfMnXBBB2bggrkimtdzrQlubScQYE
 57kANN4Ic4qfykNIi03z8VvPUSAqQcpVIaWJgw2pu/STRgNv78jcpO66A/cL2HEEXVwY
 X5kc7xjVUgN3eevwDgQA3x8/Mui6md1sO1WDIj9sy4JUgM6CQruCkPwsbQSU43qXZATF
 CbV7JddZUcY2veJUFRrMbCwUHOFyh+1EurKhTIW0pBdmD5rKS/oTSa6bK1selvj+zxpW
 zn9sCk2eGykyb6H80ZiwMH+vKs4mXzjLYCVbhuTJQTkgxLA2IbvHdfrosOBMz9yzQO3K
 +vwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxp4EqYZcaOOBhjvcig+VXpJ7xIhFiyyE/4twTyC+Heva+YrsOOlFP1cb45nGMJwXlc68nqUrplrxoo@nongnu.org
X-Gm-Message-State: AFuF++mSiu8qN/arf93VG9yBtg7/aDQTg1S7nyjlxCapuv3RUhy7Ux4p
 aU4gjm9OsI/O1paAGVSixh1KVnm0fbU1KeNj9mB636dV7sJ2PIMe7ZY3jjrBDb+7syk=
X-Gm-Gg: AYBFou0wq96Gzwiy8E51ZVZxX8CLrsgT9YX1q1ppKXM1t/bwy5hwaYO155Mx53Wnorc
 LjBJ6LMCQmfDwWBE5POgDSNY2NkYVX4S4cbPs9Lc7Rf9Ab52iH9n+d3ItfyEnCew/4NqtYGyLyQ
 8MfuqFM8SGWWqWnumP32B4pp5WuovxJm1knTwNPdKxLkYCsjG9I+v2bplxy0+bp1JoQWbVWhgYZ
 a9J0R3QmrABavWTI2Yvd4v+T0+xhhvEuWwppCKOGVf8hrl8azzLiDP0xcrjug2IzsHQuq2YmTU0
 NUKRNt+EOvn/dUUXUW1lgjnjB657nC/jiO+m6pyBtwi9b2iX8dTy+RNBYIid34kVSHA0mXm7qhV
 KwNZL/VrvvoXteOkdyC6DHU1qzH6Z6/cKE3oqb8sTvpr23j8tC6e37OAfyBnUvna+SeaDD87DUH
 dVKoemxHrAMZ5nkga529+It+BSbrAFnpKFflfQ44W0AwS4kFQWGX8a9WhPehLT3Sma/H2GCJDIy
 X7EQTx/RA==
X-Received: by 2002:a05:600c:4705:b0:49c:fa21:e73c with SMTP id
 5b1f17b1804b1-49eb7326258mr33154515e9.18.1789572266596; 
 Wed, 16 Sep 2026 08:24:26 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbbd951a0sm16747455e9.4.2026.09.16.08.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:24:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DF6EC618BA;
 Wed, 16 Sep 2026 16:24:22 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org,  John Snow <jsnow@redhat.com>,  Helge Deller
 <deller@gmx.de>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas Huth
 <th.huth+qemu@posteo.eu>,  Richard Henderson
 <richard.henderson@linaro.org>,  Brad Smith <brad@comstyle.com>,
 qemu-arm@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Warner Losh
 <imp@bsdimp.com>,  Cleber Rosa <crosa@redhat.com>,  Philippe =?utf-8?Q?Ma?=
 =?utf-8?Q?thieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Cornelia Huck
 <cohuck@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Song Gao <gaosong@loongson.cn>,  Kyle
 Evans <kevans@freebsd.org>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,  Eric
 Farman <farman@linux.ibm.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v3 16/17] scripts/make2mtest: add docker dependencies
 for check-tcg-% targets
In-Reply-To: <aqppcizE7rzIfwCL@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 16 Sep 2026 11:03:30 +0100")
References: <20260916085341.1692742-1-alex.bennee@linaro.org>
 <20260916085341.1692742-17-alex.bennee@linaro.org>
 <b58e25cd-0b41-4060-9946-cc5675aea67c@oss.qualcomm.com>
 <aqppcizE7rzIfwCL@redhat.com>
User-Agent: mu4e 1.14.4-pre3; emacs 30.1
Date: Wed, 16 Sep 2026 16:24:22 +0100
Message-ID: <877bkl9q3d.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Sep 16, 2026 at 02:56:09AM -0700, Pierrick Bouvier wrote:
>> On 9/16/2026 1:53 AM, Alex Benn=C3=A9e wrote:
>> > This should trigger the building of the docker image when the user
>> > calls "make check-tcg" or one of the arch specific targets such as
>> > "make check-tcg-m68k-linux-user".
>> >
>>=20
>> Maybe there is some confusion, patch 2 only reverts option
>> enable/disable-containers + --container-command for meson. It does not
>> disable container support for meson tcg tests, which is there and
>> enabled by default. Thus, container image dependencies are already
>> there, with ninja or make.
>>=20
>> $ ./configure && make check-tcg-m68k-linux-user --dry-run |& grep debian
>> [246/1052] Generating tests/tcg/image-debian-all-test-cross with a
>> custom command
>>=20
>> Given that dependencies are already there, what is the goal of current
>> patch?
>>=20
>> > We still keep the internal meson dependency so individual tests can
>> > launched and the docker build verified.
>> >
>>=20
>> As a side note, since patch 3 removes existing meson options, there will
>> be no way to disable container build and run. It might be a (new)
>> problem if some people were relying on this to avoid using
>> docker/podman, which is the current workaround for John Snow's issue for
>> instance.
>>=20
>> At minimum, current series should at least keep meson implementation of
>> --disable-containers, which implies to keep this entry in
>> meson_options.txt. The rest is less important, as risk is only to skip
>> tests, which is not blocking for users.
>
> Yes, if we're keeping meson.build rules that rely on containers,
> then meson stll needs to honour the --disable-containers arg that
> configure is processing now.

I've modified the revert to ensure we don't loose the options being
passed down to meson.

>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

