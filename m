Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C3CE74AC3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 18:12:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIXMY-0001zF-9w; Tue, 03 Dec 2024 13:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tIXMM-0001xF-UX
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:10:55 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tIXMH-0001Yn-Pk
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 13:10:54 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434ab114753so49674395e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 10:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733249446; x=1733854246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s297ceJ3Kqstoib4SGBhYqKKq3+kBvullARpErKYJCE=;
 b=lmyd8zFtuIoH9nSQ/Us+e2bdH57doTouEyB7YvOtoMB/uyb/pQKpZByUMC41Z4+M29
 YwqIaIobkWpY7HnHZC+t4qXhEx1hbZyAzvDD8LQIHRCtMzl5qznfWSvDiXOS+QqH3ewE
 cykIlPPCjtqzicYrB8yIgFEvXrm2YXxAig94MMmVKgVUxeS3cmCzPMCUXajpX6mfJf1u
 JtaWnZPo6Oo6S6N4327T0NsjT3xYa+DDE59e6FwoEUuPolJhs33eooSQa5MAtPqTbODy
 oD5dZHpnOdydR9UvAae8L7RkT4yMOp5IaULJve0pD1mByfWYfQpN86+3QznLPSauEZm7
 DG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733249446; x=1733854246;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s297ceJ3Kqstoib4SGBhYqKKq3+kBvullARpErKYJCE=;
 b=kU8hI/aWTWffpRK5cqbaNZkxX1ywNGb5FQO+ddy/7mPHKQyOeMTAGU0Nz7U61mTSuc
 z6oCFpxenVJFnV3UMQtzPtwXY6MkB9vVRpVMPdYAurEtYck9Jl5O0CUC8GmPz8ifVVE/
 M+BvomOL49ev2hrd1kQcoC5ycBfbpiP1L4fn1O8ef78OAYcKTubFWt+6TchFzJvwMatd
 qsC9GJwCOtO4wafzKURR5Su1nyyRcdirGXj5Ls0mlayzocc6o6SIyT2c6gjtWZNrmSyt
 nfkzh969LHeo2nZmdb+ptgzh4jPYTgFQeAJTYzUYq2BURn2QgK+7Hpa2gTLxwT5rJpaz
 IeuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC7ZKIqoLTwqeh1yaCTVsljQoHNVqU4jCvxlMQ2U0nIB45tBkp9MwKMVXJ/32e/rwjhw4m5Fd8f4dX@nongnu.org
X-Gm-Message-State: AOJu0Yw9N0nRStiihPJiIq1BT62GfyUsP2KSkjglVoCMRwds0ksGbEeG
 +1xr9BaPda7ebtjf7xKc15zu0CiPGOVchkRWyBBNOgjSCma5svosVvjC7oJvyYI=
X-Gm-Gg: ASbGncuj7hVCJtPivZYZC5gVn//hS/0TXDwNn4jIlWjloYfVIcvKzyu20BmSrJqUDT8
 71rT+BrrbOTVwuSYhHCAAgP2e9wzJgd6YDrAHzJ4Pzh+OS7bGYkQnMqWt6jWMFuSXzaYvlATMGq
 2wYFNwdMJyfbQSvlzZH7Fsf3hiVAiQV1ovoCvvNAl/u65H+YoWoz0fjh0jyCTcMrTNCOfyDxhP9
 AD8b4gKZh2q8RFmdKVZWVynUCasTCsQnV1s/g5Vo9RPAbkd
X-Google-Smtp-Source: AGHT+IFAv/kgIHcNPc70KSxnrAyH9DXdo2jtmJKi5T19CqhdRiA9zNRvlmsZwJ8bqAq6GiMn7qHobQ==
X-Received: by 2002:a05:600c:511a:b0:434:a6af:d333 with SMTP id
 5b1f17b1804b1-434d09c8e18mr33712685e9.16.1733249446236; 
 Tue, 03 Dec 2024 10:10:46 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0d9bed7sm201495695e9.8.2024.12.03.10.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 10:10:45 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 216345F78C;
 Tue,  3 Dec 2024 18:10:44 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Richard
 Henderson
 <richard.henderson@linaro.org>,  Andrew Melnychenko <andrew@daynix.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Jason Wang
 <jasowang@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,  Fabiano Rosas
 <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>,  Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org,  Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org,  qemu-block@nongnu.org,  Michael Roth
 <michael.roth@amd.com>,  Konstantin Kostiuk <kkostiuk@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org
Subject: Re: [PATCH 6/7] docs: add a glossary
In-Reply-To: <CAFEAcA9JdLxi5cr-Z2-YX6Q8nv=j0O3k=f9u6gS-CzSf5BH7Ug@mail.gmail.com>
 (Peter Maydell's message of "Tue, 3 Dec 2024 17:37:22 +0000")
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-7-pierrick.bouvier@linaro.org>
 <CAFEAcA9JdLxi5cr-Z2-YX6Q8nv=j0O3k=f9u6gS-CzSf5BH7Ug@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 03 Dec 2024 18:10:44 +0000
Message-ID: <87ttbkbpsr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=unavailable autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 18 Nov 2024 at 17:24, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>  docs/devel/control-flow-integrity.rst |   2 +
>>  docs/devel/multi-thread-tcg.rst       |   2 +
>>  docs/glossary/index.rst               | 238 ++++++++++++++++++++++++++
>>  docs/index.rst                        |   1 +
>>  docs/system/arm/virt.rst              |   2 +
>>  docs/system/images.rst                |   2 +
>>  docs/tools/qemu-nbd.rst               |   2 +
>>  7 files changed, 249 insertions(+)
>>  create mode 100644 docs/glossary/index.rst
>
> I think this is a good idea; we've had at least one bug
> report from a user pointing out that we had a term in
> our docs which we didn't define ("block driver"):
> https://gitlab.com/qemu-project/qemu/-/issues/2611
> I have some comments on specific entries below.
>
>> diff --git a/docs/devel/control-flow-integrity.rst b/docs/devel/control-=
flow-integrity.rst
>> index e6b73a4fe1a..3d5702fa4cc 100644
>> --- a/docs/devel/control-flow-integrity.rst
<snip>
>> +
>> +Device
>> +------
>> +
>> +QEMU is able to emulate a CPU, and all the hardware interacting with it,
>> +including many devices. When QEMU runs a virtual machine using a hardwa=
re-based
>> +accelerator, it is responsible for emulating, using software, all devic=
es.
>
> This definition doesn't actually define what a device is :-)

Also we can xref to:

  https://qemu.readthedocs.io/en/v9.1.0/system/device-emulation.html

where we go into a bit more detail about what a device, bus, frontend
and backend are.

>
>> +
>> +EDK2
>> +----
>> +
>> +EDK2, as known as `TianoCore <https://www.tianocore.org/>`_, is an open=
 source
>> +implementation of UEFI standard. It's ran by QEMU to support UEFI for v=
irtual
>> +machines.
>
> Replace last sentence with
> "QEMU virtual machines that boot a UEFI BIOS usually use EDK2."
> ?
>
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

