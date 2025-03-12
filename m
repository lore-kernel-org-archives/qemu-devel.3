Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365C1C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 16:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsOsp-0003gt-P3; Wed, 12 Mar 2025 12:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tsOsI-0003an-P3
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:24:09 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tsOsG-0002RP-5K
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:24:06 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so16059385e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 09:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741796638; x=1742401438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=peQZpPu5TIaCPLsc/J8p31mgJdN5bpaplbVfjQ5rnYc=;
 b=uqmmxRiAAyejwDCstawu4lDTeob1G/Cg1uGzKjmMzFGn6Gcclt96/09SqbUxL1ja0x
 1TsSl7ZeF3GOpD06Oj/+WKJdsSXQtNtW+d7/drkEuChHYQ3Mh8fOrXy+oag6Vg3nOSfh
 E3EKsfeGndD4oPE7uqgNjIQQA5gE6QVPZAkXI+4Gxc3I5Vnic16BsExU3aBNlT9uXMH7
 uVBKjzdGFwwk1p5sOaVcN4Nr8VFi8nDnAT7PQIO1y3CxNW952FkHuk9u3rinSSW/l/3L
 96p+Pg1k2EfSqfXL2AkBfT7fmziQP54NbuREU4DzXSFsDgSw4vKGNqjM+MFh8Irw5QUM
 QOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741796638; x=1742401438;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=peQZpPu5TIaCPLsc/J8p31mgJdN5bpaplbVfjQ5rnYc=;
 b=NK0fd6Trf3irUxBbrBybZfBFWYG1CVbXLJ5buYHgc1wQSMl0TybBm3lrswLpCcbHHI
 Iwy0BBp2ISfCNi7MhKc2o5xnlWoXoSYdXKFyvjaWcKrlf5TN2Oy8GhH5+RqdJd7tz5DW
 lpcKgaafENx/4eOGzrRnziDVXYNVCS8+kUHFZP4fVlWTYbkW3qPxAan/dX7e6/2tTvUF
 He+rEXgGyQhI/YI3YyIQLz07tq1TH1IOYxU8gfentaBPc4swfWaVFtVXzQP5WuRUs5I3
 3fh2JbYlENejDjh2oxxXFdGMpoZvSxqT1dhdT+rJ59xS2nw5Hchs8L62oR/XbzcVukI3
 gfeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXflVjYu0Ix/PRSSl0Zy0pxbgw87YBxAY3u3ghqtQ8ALMlN0m6vL+bljbQUwGBF3f7vZvM77hXuGb9G@nongnu.org
X-Gm-Message-State: AOJu0Yxkdu1GRcmvWUEfK7grBetHt2gVd+yrOSjvaT8gOpTrw7M+xd74
 /38mPZSe9s8L++yr9UfGqks0IGm+qITsoYI6SxCSqUuyALTPLBW4VN+4E1bjwxXPUjsAR6ogh8a
 +
X-Gm-Gg: ASbGnctWM3m6ODHfTZAL3zTNPoaITDIHQzaQRaQXbmvAP/enBk/Ei++S3EyO2oOO0Wx
 z/saM43KwKJv7VXZIZLNEiYx0hTfsajXvPBqS5dITG5GBdylCCG5dVdxEVDmtruz/TAPX921HlW
 2tg5mzX1/OYYVPAX9q43de07DChDHkr6WG2QRljtHbQzhKESJub5jYDgaUJ6Sjdum+5jY7jw81m
 laGsbKmFtfJsiW3+5ys6xxsR551Z6RwfQBAIibsHMOz9qODl2VyCTl1IrgLJOAeMR70gbSVnfCA
 aajmXvzgTh59Yc7ZwjKiUbmAlFfDhfAkNfZHmCs59QWIzhg=
X-Google-Smtp-Source: AGHT+IECgtJWTq6h4GDc4KbOvUwZvd11ji3pPGW0uvNsjB7pR5yiMKzD0dhSw9h4yLRLSahfO52kSw==
X-Received: by 2002:a05:600c:45d1:b0:439:6118:c188 with SMTP id
 5b1f17b1804b1-43c5a62a276mr153753575e9.19.1741796638377; 
 Wed, 12 Mar 2025 09:23:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d0a757f68sm25400335e9.19.2025.03.12.09.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 09:23:57 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B84A45F767;
 Wed, 12 Mar 2025 16:23:56 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,  QEMU <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,  Yan Vugenfirer <yvugenfi@redhat.com>
Subject: Re: Cross-compilation artifact is broken
In-Reply-To: <Z9GY3l2pTkbpMV8L@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 12 Mar 2025 14:23:26 +0000")
References: <CAPMcbCquaBmWhx3jWBKMC1oLrMZBUVhfWFcW=_5uhVqOep4NWw@mail.gmail.com>
 <Z9GUldol1IQT1uiY@redhat.com> <Z9GY3l2pTkbpMV8L@redhat.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 12 Mar 2025 16:23:56 +0000
Message-ID: <871pv25iar.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

> On Wed, Mar 12, 2025 at 02:05:09PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Mar 12, 2025 at 03:52:45PM +0200, Konstantin Kostiuk wrote:
>> > Hi All,
>> >=20
>> > I cross-compiled qemu-ga from current master branch
>> > (825b96dbcee23d134b691fc75618b59c5f53da32) and found strange behavior.
>> >=20
>> > Configure CLI:
>> > ./configure --disable-docs --disable-system --disable-user
>> > --cross-prefix=3Dx86_64-w64-mingw32- --enable-guest-agent
>> > --disable-guest-agent-msi --disable-qga-vss
>> > Build CLI:
>> > make -j8 qemu-ga
>> >=20
>> > Linker wrote the following information but exited with 0 code:
>> >=20
>> > /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/=
bin/ld:
>> > qga/qemu-ga.exe:/4: section below image base
>> > /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32/=
bin/ld:
>> > qga/qemu-ga.exe:/24: section below image base
>> >=20
>> > As a result, this binary failed to start on Windows without any detail=
s,
>> > just a message that the application is not compatible. I also tried to=
 run
>> > it with wine and got the error:
>> >=20
>> > wine: failed to start
>> > L"Z:\\home\\user\\Documents\\repos\\qemu\\build\\qga\\qemu-ga.exe"
>> > Application could not be started, or no application associated with the
>> > specified file.
>> > ShellExecuteEx failed: Bad EXE format for
>> > Z:\home\user\Documents\repos\qemu\build\qga\qemu-ga.exe.
>> >=20
>> > I bisected the tree and found the commit that caused the problem:
>> > https://gitlab.com/qemu-project/qemu/-/commit/563b1a35ed1f1151505d4fe5=
f723827d1b3fd4bc
>> >=20
>> > Adding --disable-split-debug to the configure CLI fixes the issue.
>> >=20
>> > $ x86_64-w64-mingw32-gcc --version
>> > x86_64-w64-mingw32-gcc (GCC) 14.2.0
>> >=20
>> > My question is, is this expected behavior or is this a bug?
>>=20
>> Your configure args don't include "--enable-debug", so I would
>> not have expected -gsplit-dwarf to have been enabled, so I'm
>> surprised that commit casued a problem.
>
> Hmm it appears that the meson  "get_option('debug')" is entirely
> unconnected to QEMU's --enable-debug configure flag, which I did
> not realize.
>
> IOW, we've got -gsplit-dwarf enabled by default for everyone
> building QEMU, which feels dubious. IMHO only an explicit
> --enable-debug configure arg should have triggered it.

--enable-debug is more than debug info, --enable-debug-info is enabled
by default. If you build with --disable-debug-info then -gsplit-dwarf
won't be applied.

>
> In addition since its breaking Windows builds, it appears we
> need to block its usage on Windows.
>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

