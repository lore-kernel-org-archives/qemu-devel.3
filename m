Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C89E74AC7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 17:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIWbw-0006Df-KR; Tue, 03 Dec 2024 12:22:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tIWbv-0006Cw-Bd
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 12:22:55 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tIWbt-0001H2-Lq
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 12:22:55 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-434a8b94fb5so146265e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 09:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733246572; x=1733851372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxQOgQ7aintAwEXD/WyrxwGkNa9gc/VZ2LXjarllC/I=;
 b=CcFqeZsprHbunnrmLQxmSzNdpSYaqdtd/eTEDgCSH0OansqDGu/f8dk14c7/v75vzx
 xVsEdyTbGzNUq1M7wTCek/y4t81vhRU9EhsvZzxPCmVC3cq8WFgD31MHdPprlm5Ad4YJ
 kP1wAPDzO05Fi1tTT0+NQcl/lQXIrPShbRZN5W6MKWQXeLcUCdBkg5SULh58l4X+/HMJ
 l3unwRHkFSPuMafYyT6gKtubUU6jwbLDkfSqsxBYbS2iYMAXv4GptaybwSJiz41DLWX1
 8jm6m1RlLxi7rl1F38YNNmbQ3ctZcQh2xsUBZb6DNUxzmcDBewKBi/rOKxVXmLTzMCxv
 dCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733246572; x=1733851372;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JxQOgQ7aintAwEXD/WyrxwGkNa9gc/VZ2LXjarllC/I=;
 b=PFmGZNCv2sWUPjJyViEdPqge9Hhknze74QcttVhQYnLVO88f01dvTFUX7cVL4NJkO4
 mD7f668yqhHGvK/pxorDwiMT9FGY3A0hhDvbfowCIJ3gDAmZms8k1fvJlOOTDeb8ZhnJ
 u/iWzFISw0e/kEXaYgND/EnVBOCR2QEziS1ELvVATS1pgI0DYDYqT2SF8ktiVFt1eiFd
 M/f9MvFh5lj7VSiRwJX8/XW5JTx3Cl/G/R3S9pKEYNtUVM4BJAkbK+j6jW8962jO1S8B
 +WUCFKhxitqPPLnykccaAAj9QYr4zjTFVuMXj20AV0Ga9/6wlXzd8GTNdtJQh7tMtM5V
 hXyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpGTq3V00YEu20T2SuatwqPZF5X16Foz27v20jJDEVtJLN51CU2vuTnSMH4MOZ2MPsoOZcr0zJLDTu@nongnu.org
X-Gm-Message-State: AOJu0YylNVhrtMiFT8Zriqvbw1D5ct1dB/CkcNMLmVNlqwrUHgIrjDr6
 JVzotL9yE+htGj/HghqmnGIulT3gqRiexP8Ag5obwTypZslV19TWPkUCTFDzLKE=
X-Gm-Gg: ASbGncu114KuCetBaeQv3sEO/yXKtxxSZMpIVA8JIswBhJuw5Nj83PuzFkeZ0Fi+zbT
 lc8GSvkgib8V6tA0hZReayQRtFSwpsoi0pkEIhfTOQddovla4uU/r1vEZxl0S5dDgS1C3TpRp9z
 Er0B7yyi3ppFVIIXRvpn9W5ukytoZkem87qudRQtBVBEdKVcMKN4epDTxZH1RTIYwuFa6/JzYHD
 1Mqm9hASYp8AAr170PdAh7Ngobgl0PLM6N8c3njHsB72RW5
X-Google-Smtp-Source: AGHT+IEsrgxyquVHw0E2iaRThvSCWjedkPCRbBUJkEckzLBhZ/3OSm5kipya69rwvnQbGK0QTPSUgg==
X-Received: by 2002:a05:600c:1f91:b0:431:7ccd:ff8a with SMTP id
 5b1f17b1804b1-434d0d7b89bmr29758465e9.14.1733246571757; 
 Tue, 03 Dec 2024 09:22:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd36557sm15926486f8f.24.2024.12.03.09.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 09:22:51 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 68D665F89C;
 Tue,  3 Dec 2024 17:22:50 +0000 (GMT)
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
Subject: Re: [PATCH 5/7] docs: add a codebase section
In-Reply-To: <CAFEAcA-UkmPvyNW_6o22-WhaLxnnji55UsBp3UcPA-gYH7kvVg@mail.gmail.com>
 (Peter Maydell's message of "Tue, 3 Dec 2024 15:53:42 +0000")
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-6-pierrick.bouvier@linaro.org>
 <CAFEAcA-UkmPvyNW_6o22-WhaLxnnji55UsBp3UcPA-gYH7kvVg@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 03 Dec 2024 17:22:50 +0000
Message-ID: <87zflcbs0l.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 18 Nov 2024 at 17:24, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> Present the various parts of QEMU and organization of codebase.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>
> I like this; it's something I've thought for a while would
> be good to have, but which I never got round to trying to
> put together. Thanks for doing this!
>
> Mostly my comments below are spelling/typo nits and
> other minor stuff.
>
>> ---
>>  docs/about/emulation.rst               |   2 +
>>  docs/codebase/index.rst                | 211 +++++++++++++++++++++++++
>>  docs/devel/decodetree.rst              |   2 +
>>  docs/devel/ebpf_rss.rst                |   2 +
>>  docs/devel/index-internals.rst         |   2 +
>>  docs/devel/migration/main.rst          |   2 +
>>  docs/devel/qapi-code-gen.rst           |   1 +
>>  docs/devel/testing/main.rst            |   9 +-
>>  docs/devel/testing/qtest.rst           |   2 +
>>  docs/index.rst                         |   3 +
>>  docs/interop/qemu-ga.rst               |   2 +
>>  docs/system/qemu-block-drivers.rst.inc |   2 +
>>  docs/tools/qemu-storage-daemon.rst     |   2 +
>>  docs/user/main.rst                     |   6 +
>>  14 files changed, 247 insertions(+), 1 deletion(-)
>>  create mode 100644 docs/codebase/index.rst
>>
<snip>
>> +  Block devices and `image formats<disk images>` implementation.
>> +* `bsd-user <https://gitlab.com/qemu-project/qemu/-/tree/master/bsd-use=
r>`_:
>> +  `BSD User mode<bsd-user-mode>`.
>> +* build: Where the code built goes!
>
> The built code doesn't have to be in 'build'. We could say:
>
>  * build: You can tell the QEMU build system to put the built code
>    anywhere you like. By default it will go into a directory named
>    ``build``. Sometimes documentation will assume this default
>    for convenience when describing command lines; you can always
>    replace it with the path to your build tree.
>
> ?

I always recommend creating a builds directory and having multiple build
trees under it:

  =F0=9F=95=9917:22:02 alex@draig:qemu.git  on =EE=82=A0 testing/next [$!?]=
=20
  =E2=9E=9C  tree -L 1 builds
  builds
  =E2=94=9C=E2=94=80=E2=94=80 all
  =E2=94=9C=E2=94=80=E2=94=80 all.clang
  =E2=94=9C=E2=94=80=E2=94=80 all.disabled
  =E2=94=9C=E2=94=80=E2=94=80 arm64-system.crossbuild
  =E2=94=9C=E2=94=80=E2=94=80 arm.afl
  =E2=94=9C=E2=94=80=E2=94=80 arm.all
  =E2=94=9C=E2=94=80=E2=94=80 arm.debug
  =E2=94=9C=E2=94=80=E2=94=80 arm.gcovr
  =E2=94=9C=E2=94=80=E2=94=80 arm.user.32bit
  =E2=94=9C=E2=94=80=E2=94=80 bisect
  =E2=94=9C=E2=94=80=E2=94=80 debug
  =E2=94=9C=E2=94=80=E2=94=80 debug.clang
  =E2=94=9C=E2=94=80=E2=94=80 deprecated
  =E2=94=9C=E2=94=80=E2=94=80 disable-misc
  =E2=94=9C=E2=94=80=E2=94=80 disable.plugins
  =E2=94=9C=E2=94=80=E2=94=80 disable-tcg
  =E2=94=9C=E2=94=80=E2=94=80 disable-user
  =E2=94=9C=E2=94=80=E2=94=80 extra.libs
  =E2=94=9C=E2=94=80=E2=94=80 gcov
  =E2=94=9C=E2=94=80=E2=94=80 gcov2
  =E2=94=9C=E2=94=80=E2=94=80 lto
  =E2=94=9C=E2=94=80=E2=94=80 profiling
  =E2=94=9C=E2=94=80=E2=94=80 qemu-system-arm
  =E2=94=9C=E2=94=80=E2=94=80 rust
  =E2=94=9C=E2=94=80=E2=94=80 sanitisers
  =E2=94=9C=E2=94=80=E2=94=80 sanitizer.clang
  =E2=94=9C=E2=94=80=E2=94=80 system
  =E2=94=9C=E2=94=80=E2=94=80 system.i386
  =E2=94=9C=E2=94=80=E2=94=80 system.nodefaults
  =E2=94=9C=E2=94=80=E2=94=80 system.threadsan
  =E2=94=9C=E2=94=80=E2=94=80 tcg
  =E2=94=9C=E2=94=80=E2=94=80 tci
  =E2=94=9C=E2=94=80=E2=94=80 tools-and-docs
  =E2=94=9C=E2=94=80=E2=94=80 trs.debug
  =E2=94=9C=E2=94=80=E2=94=80 tsan
  =E2=94=9C=E2=94=80=E2=94=80 user
  =E2=94=9C=E2=94=80=E2=94=80 user.static
  =E2=94=9C=E2=94=80=E2=94=80 virtio-gpu
  =E2=94=94=E2=94=80=E2=94=80 xen


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

