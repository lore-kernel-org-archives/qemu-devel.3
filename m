Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169ECC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfa21-0007pX-9F; Fri, 03 Jul 2026 05:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wfa1z-0007n5-Ni
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:17:55 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wfa1x-00046v-Om
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 05:17:55 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-46ed4f66256so306193f8f.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 02:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783070271; x=1783675071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZXPY5i/v7Dtwj2B9jCMRsZsJQlojRIr0tVHGi0NRo68=;
 b=whFq4r4zkS+3khsMVBrA3dp1bUMWVIJZox8helPWjq6KcH/OUtDfh9hiugsVDdYZIB
 vilha2lFJUSNvg2t0jbT8YC5imDHtdnEgK7j3IX9DcS5yHZBEROsvhAZZuoalMs8YU51
 O9qGAOdvTZV7f+4dhLFVUCmM/DuYq9saad5sJHTic64s9txyoSl6dINdmdTb9o21Y/Yz
 YzZ/C4fSj5Q4mRKL/WC94woLhxLVHeM176ydUSkTpVA85aGXFiLEJ+aeUEL9j2h+Fiuu
 dWbdBLOSF8HJhZYUz0oecycITbrxxoLqwpLFh95hBcTCqrnvvCrtAOU7fL9uOrIuugvw
 CKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783070271; x=1783675071;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZXPY5i/v7Dtwj2B9jCMRsZsJQlojRIr0tVHGi0NRo68=;
 b=TIsPw3wzvVU+IhtVhUnmcAQFSkEkQzd5GtOmFIzWKMgx7ic7N61kYYGgJGfOYGFi0U
 8LZp65BoqnEAg9IPtgf72YzlatiDGs+GgqF6wWIsj547zgmgy3krqLox8WRacSltbTnJ
 rllI5kEbHN5XYhFwXcpXZJDIzqiqDr23zx045l2aOYvMoN0s34/2NcA5fysZt1sgRTLI
 TsCsovlrp2zq8SZ3YHqe/ZZDSKisVlisAnO3TANX7pXuwmhoW9IZoiHtT4Jzfs7HWmWe
 K3jns7z9jh+17H2whRcKADCadDAh+EB1kjS1bXvFm9Jw2MBSmTBpo4UWyxG43UnQdffO
 E6lA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqP9HIozkICMXHG3sMkIpO7gmajmFQZcxSw3UzAyWIQbrlusVRafBG3JHOxYkJEJrrjezzJjSIuo8uD@nongnu.org
X-Gm-Message-State: AOJu0Yyp2hEIBANweb6wXzsi40S3GA9REvgW8hTyFtR/sQe4oZZWXcYt
 ktKPqMrGhsZP+PT8/NTd0MpS0CLM5VRvIh4vnZw7s2L0681LGWsJdhY09NXzRmD3o8E=
X-Gm-Gg: AfdE7ckQO9dSz9T0t/PLxVJaU+0auMPXXuF037B69L7nBSnOT5PaLZ/Awq+amdjnhv1
 QuWz1akWYfqN6dd4+EdK5AQDOsfIr5/EC26n+qfkXSJp1ihF/c5mQtD2uPJxTnUqjgGPHiPyHpx
 GCHzaBCDf/XisVXuCSAXXq0bb8PQ9WL1EfLnVyc9JDF6w631P3D09ex0eZOekML0iMBvTDssA5j
 JoBvgDg1qfaDKTpbwqVekyRQS5AezoaDnan34TEUwDSIE3wtqglmi3skQIYE/Q6rf44pWMLn4CP
 8Clvr3nVulV4lRaYrv+da0KzDJwYIMkssxn4QEYZwYuPg6Y9PWM04oHpP9x2kdTgDpYkjRprGdu
 hfMxjIZ+El526CgMp5yQjgbsh2mNaSV6EWJny7km/TDe7u9+DxGrVjE20bFv4tP4lBJ9mYPSsXN
 9X0pVTqGcBEttk+iNvqoLbFRo=
X-Received: by 2002:a05:6000:4688:b0:46d:cc92:e00e with SMTP id
 ffacd0b85a97d-4775bd0ed86mr10611018f8f.35.1783070271115; 
 Fri, 03 Jul 2026 02:17:51 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db8a450bsm17552480f8f.10.2026.07.03.02.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 02:17:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EFC4D5F7F7;
 Fri, 03 Jul 2026 10:17:48 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Ziyang Zhang <functioner@sjtu.edu.cn>,  qemu-devel
 <qemu-devel@nongnu.org>,  Riku Voipio <riku.voipio@iki.fi>,  Laurent
 Vivier <laurent@vivier.eu>,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Zhengwei Qi <qizhwei@sjtu.edu.cn>,  Yun
 Wang <yunwang94@sjtu.edu.cn>,  Mingyuan Xia <xiamy@ultrarisc.com>,
 Kailiang Xu <xukl2019@sjtu.edu.cn>
Subject: Re: [PATCH v4 0/1] contrib/plugins: add dlcall to call host
 functions from a guest
In-Reply-To: <db0e39ba-ccc1-4e17-8456-c21d3843788c@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Thu, 2 Jul 2026 11:32:43 -0700")
References: <20260622163438.130746-1-functioner@sjtu.edu.cn>
 <20260629160217.1637276-1-functioner@sjtu.edu.cn>
 <42297965-3d92-4d9d-ad6f-4861841d4806@oss.qualcomm.com>
 <faad8fd9-5fa8-4ae8-8437-28864543e34e@sjtu.edu.cn>
 <db0e39ba-ccc1-4e17-8456-c21d3843788c@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Fri, 03 Jul 2026 10:17:48 +0100
Message-ID: <8733y0sa83.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 6/30/2026 6:48 PM, Ziyang Zhang wrote:
>> Hi Pierrick,
>>=20
>> Thanks for the review, and for thinking about the end-user experience.
>>=20
>> On Tue, 30 Jun 2026 12:34:59 -0700, Pierrick Bouvier wrote:
>>> Thanks for publishing it.
>>>
>>> A few ideas to make Lorelei even more easy to use:
>>>
>>> Would that be possible to add binary artifacts to the existing 1.0.0
>>> Lorelei release?
>>> Ideally, it should provide a toolchain (for x64 hosts) with support for
>>> x64, arm64 and riscv64 guest thunks.
>>>
>>> Also, would that possible to provide a script to generate boilerplate
>>> for thunks, and extract list of symbols from a given library?
>>>
>>> My ultimate goal would be to have something as simple as:
>>> $ wget toolchain.hostx64.tar.gz
>>>
>>> # automatically generate boilerplate + compile guest/host thunks
>>> $ toolchain.hostx64/bin/generate-thunks \
>>> =C2=A0=C2=A0 --arch arm64 --library /usr/lib/libfoo.so \
>>> =C2=A0=C2=A0 --header /usr/include/foo.h --out thunks_arm64
>>>
>>> $ aarch64-linux-gnu-gcc main.c -lfoo
>>> $ env LD_LIBRARY_PATH=3D./thunks_arm64 \
>>> =C2=A0=C2=A0 qemu-arm64 ./a.out -plugin contrib/plugins/liblorelei.so
>>>
>>> I understand it asks for more, but we really need to make lorelei as
>>> simple to use as possible, without pushing the internal details to user=
s.
>>>
>>> What do you think about this?
>>=20
>>=20
>> Prebuilt toolchain / instant acceleration
>>=20
>> Agreed: the goal is to install it and feel the speedup right away,
>> with no build step. I'll do this, but as a point release on top of
>> 1.0.0.0 rather than in the initial tag, so it lands as its own
>> increment. The model is FEX's FEXFetchRootFS: a prebuilt host
>> toolchain plus ready-made thunks, so a user goes from download
>> straight to an accelerated guest. Like FEXFetchRootFS, the tool will
>> likely have the user pick their distribution and version, because a
>> thunk is bound to a specific library build: the exported symbols, and
>> sometimes the ABI, differ across distros and releases, so the prebuilt
>> thunks must match the host's real libraries.
>>=20
>> Generating thunks for a new library
>>=20
>> One caveat on the generate-thunks sketch. Lorelei guarantees that
>> thunk *generation* is automatic and reproducible: once a library is
>> described, TLC deterministically emits both sides, including the
>> callback and variadic cases. What it cannot do on its own is
>> *describe* the library, that is, pick the symbols you need and write
>> descriptors for the ones that do not marshal trivially (callbacks by
>> pointer, ownership crossing the boundary). Those stay judgment calls
>> that need a human, or an AI, in the loop.
>>=20
>> So adding a new library is not one fully automatic command. What
>> Lorelei does is drastically cut the effort versus hand-writing every
>> thunk the way Box64 does: the generate-thunks helper automates what
>> is automatable (symbol extraction, boilerplate, building both sides),
>> so simple libraries are close to one-shot and harder ones start from
>> a skeleton rather than a blank file.
>>=20
>> Plugin name
>>=20
>> I would rather keep "dlcall" than rename it to "lorelei". The plugin
>> defines a general interface (the magic-syscall dlopen/dlsym/invoke
>> ABI), and Lorelei is only one userspace implementation of it now:
>>=20
>> =C2=A0 - "dlcall" says what the plugin does and is understood without
>> =C2=A0=C2=A0=C2=A0 leaving the tree. "lorelei" names an external project=
 and says
>> =C2=A0=C2=A0=C2=A0 nothing about the mechanism.
>> =C2=A0 - An in-tree interface should not be tied to the branding or
>> =C2=A0=C2=A0=C2=A0 lifetime of an out-of-tree project. If Lorelei is ren=
amed,
>> =C2=A0=C2=A0=C2=A0 forked, or joined by other toolchains, the name becom=
es
>> =C2=A0=C2=A0=C2=A0 misleading.
>> =C2=A0 - Naming it after one implementation implies it is the blessed one
>> =C2=A0=C2=A0=C2=A0 and discourages alternatives. A generic name keeps QE=
MU neutral.
>> =C2=A0 - It also matches how the other contrib plugins are named, by
>> =C2=A0=C2=A0=C2=A0 functionality (lockstep, cache, ...).
>>
>
> I agree with your arguments, let's keep this name then.
>
>> I do agree Lorelei should be discoverable from the tree, so I'll add
>> docs to docs/about/emulation.rst that introduce the dlcall interface
>> and point at Lorelei as a ready-to-use implementation, with a minimal
>> example and without the internal details.
>>=20
>> Does that sound reasonable?
>>
>
> Yes sounds good to me!

Sounds good to me as well ;-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

