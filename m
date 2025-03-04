Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB594C282D6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 13:48:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpScZ-00079j-2g; Tue, 04 Mar 2025 08:47:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpScX-00079X-0y
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 08:47:41 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpScV-0001ts-9W
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 08:47:40 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4393dc02b78so36684465e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 05:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741096058; x=1741700858; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WwdOWvSasRTLmCbAeRIjsJSqJ02k3qKHagbpmUPzVqo=;
 b=eM6vHfg174KtqI5kznVtqLt7sB2nNLsxiMRXyRpvEmVoJusKEmIujfq+nqBny48x/h
 WgLYW7+18/A9chsuRPG+fv1WK/nOvyaJt07EsEVZ3bK+QxAlYSLLpQQj8qfJjNdSURSX
 0boydfGRPdqVhBlcAV0luZ7wXRqZckcLOdCKZt4KSjQxIypc79pHOAlfvZkJvr2yMdf+
 BBw4ix/u5GQNDt7IduLkMZEb3v1MLJpoHMz51rKSIeARXtUByEfhGITjc5REdY8FiZr1
 p893kApslzaY50egXAzV/nhJVAGKy+ZP145TfRsKR1KzUOCFz+dQA6ruebAh0E/ixDi5
 LjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741096058; x=1741700858;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WwdOWvSasRTLmCbAeRIjsJSqJ02k3qKHagbpmUPzVqo=;
 b=UuouSpq21DRalGBA6IE2HCuTjPZSABrB205L0Ze3UM/wlEF2sC4wrKQaOBJcQzW5Pa
 hENCf9h2jNV+aewRbO2pDuBQYwJAgwBWaUFbUPhdqprgm2v9zF1+AH0vpRGSIZ2nVI0S
 bLSgsJgZYAAmOGwG8GtmR79iMszr49SRmzVQHxzTrd5XjdIw5D+HJbt1e966Tbx4cmRM
 mB4enVw/CgywKT8boUdKwEOWDDiJbJrfpOsPfFr+96+wgbPS5wXwAREWQ1SpSr/uIN2b
 08netNPMwQ4LRyMT+rtr9mmMyJGflt5u5TcWNbxI/SmOmfno1LixQqSeR8wJv8WUKesK
 lscA==
X-Gm-Message-State: AOJu0YwZajJVk0YTd7GRtgh0RJrDWRDRca4UliP3K2FA65mJMfviTapl
 hmAEcDRj4mxVvWOAISpSsLt5xGEoKikKmDnunTEygnlG1faq9K5GZCEZFyFH/QKjvbbcIpuBgHq
 XyEc=
X-Gm-Gg: ASbGncvlLOF7+7S2E9NiYTUytDwsICOKHKRDz5NeESUTWFz/LBnubxAux6gKqwigBC4
 zhtmVjv35wRQ0nhb13dpiq6g373pdbRkUqcXnQPrbhhEXwW1emnhxwXo33QGXBhgwnjoz31Trnm
 pXtRWXbws17MsvSoKGb+AgL7KsFbYSI5gL1bl9eFHh5EyibgpjLw+QRkclZjnkPRluRpNl9nljf
 QfoGt1DRUVYA87XpbE2aTGI8K5xFa6eQ7RB1QbY5EcF4iaKj84/LI5aEwXERQ4t+fs/ECb9iCMo
 NB2Wmh0479xsDWNEGBTHBh+JljwlMc7VRcB1iEz3jUpTjWY=
X-Google-Smtp-Source: AGHT+IHYjDxqH0+rf0J4dpK7Zt4GhrPXEEV2uY8gt7PaLzbMNXjEMSxKzkK2xgdGWZdg8emol9MHUw==
X-Received: by 2002:a5d:5f84:0:b0:38f:28dc:db58 with SMTP id
 ffacd0b85a97d-390ec7c70fcmr15767050f8f.10.1741096057664; 
 Tue, 04 Mar 2025 05:47:37 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e484489esm18100370f8f.68.2025.03.04.05.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 05:47:37 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4A79D5F93C;
 Tue,  4 Mar 2025 13:47:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH] meson.build: add -gsplit-dwarf to default cflags
In-Reply-To: <Z8b96wVB2f88csSN@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 4 Mar 2025 13:20:01 +0000")
References: <20250303221703.1291078-1-alex.bennee@linaro.org>
 <Z8bTy54Jgaddg6V3@redhat.com> <87tt8958tj.fsf@draig.linaro.org>
 <Z8bt7ajRVwdabG7p@redhat.com> <Z8b96wVB2f88csSN@redhat.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 04 Mar 2025 13:47:36 +0000
Message-ID: <87cyew6h6v.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> On Tue, Mar 04, 2025 at 12:11:25PM +0000, Daniel P. Berrang=C3=A9 wrote:
>> On Tue, Mar 04, 2025 at 11:33:44AM +0000, Alex Benn=C3=A9e wrote:
>> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >=20
>> > > On Mon, Mar 03, 2025 at 10:17:03PM +0000, Alex Benn=C3=A9e wrote:
>> > >> This option is supported by both gcc (since 4.7) and clang (since
>> > >> 7.0). Not only does this make the linkers job easier by reducing the
>> > >> amount of ELF it needs to parse it also reduces the total build size
>> > >> quite considerably. In my case a default build went from 5.8G to 3.=
9G.
>> > >
>> > > I've not come across this option before, but the docs say
>> > >
>> > >   =E2=80=98-gsplit-dwarf=E2=80=99
>> > >      If DWARF debugging information is enabled, separate as much
>> > >      debugging information as possible into a separate output file w=
ith
>> > >      the extension =E2=80=98.dwo=E2=80=99.  This option allows the b=
uild system to avoid
>> > >      linking files with debug information.  To be useful, this option
>> > >      requires a debugger capable of reading =E2=80=98.dwo=E2=80=99 f=
iles.
>> > >
>> > > In Fedora and RHEL we build QEMU will full debug enabled, and then a=
 feature
>> > > of the distro RPM build config will post-process all ELF files to ex=
tract
>> > > the debug info into files that we store under /usr/lib/debug. eg for
>> > > /usr/bin/qemu-system-x86_64, we get a separate
>> > > /usr/lib/debug/bin/qemu-system-x86_64-9.1.3-1.fc41.x86_64.debug, and
>> > > tools like GDB, etc know to look for these separate files.
>> >=20
>> > A modern gdb can certainly handle fetching the debug out of the .dwo
>> > files when debugging.
>>=20
>> See this response from one of the upstream GCC maintainers pretty much
>> recommending against (on by default) use of -gsplit-dwarf:
>>=20
>>   https://lists.fedoraproject.org/archives/list/devel@lists.fedoraprojec=
t.org/thread/RXA55BTO62NWWHCTUFYGEVHJKZPL5EKE/
>
> Since lists.fp.o is being rather unreliable today...
>
> [quote]
> On Tue, Mar 04, 2025 at 11:44:18AM +0000, Daniel P. Berrang=C3=A9 wrote:
>> The QEMU community is discussing possible use of -gsplit-dwarf as a defa=
ult
>> option for QEMU's build system:
>>
>>  https://lists.nongnu.org/archive/html/qemu-devel/2025-03/msg00424.html
>>
>> This option causes debug symbols to be written to separate .dwo files
>> instead of the .o files or final executables.
>
> Don't.
> -gsplit-dwarf is something to get faster link times at the expense of slo=
wer
> debugging and more files around.
> So, it can be useful for fast modify/rebuild/test cycles during developme=
nt,
> but is something that is really undesirable for the distro builds.
> There you don't mind slightly longer link times, that is done once per
> build, but having to ship larger debug info and especially when it is spl=
it
> into hundreds or thousands of small files is then a price everybody who
> downloads the package debuginfo pays.
> debugedit can't deal with it, dwz can't either, in order to ship something
> reasonable one would need to dwp the separate debug info back into the
> normal debug info.

Is this not feasible? I large part of the saving is not having the same
set of symbols defined in multiple object files as stuff gets merged
during the build.

Maybe we need a simple --debug-type which defaults to split but can be
selected as unified for the distro builds?

>
>         Jakub
> [/quote]
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

