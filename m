Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EC7D68B30
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 15:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBbfg-0004dl-Bo; Thu, 14 Nov 2024 10:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tBbfd-0004dG-UR
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 10:22:09 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tBbfb-00080t-3J
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 10:22:09 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-539ee1acb86so752480e87.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 07:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731597725; x=1732202525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lIrsDtygNM2LdbbxxBhnk030aqjLrUc1+0ltWCQU+q4=;
 b=A0coFPQvPz05HeA1clePeFljvghmnX/uYLofvNotxKw2555cL6O31kUPRI0bWyzwJr
 Kbge8LEJcuME2xQRpgXqHXwRxfX1AHUiEzT0rQfKWJmRZy9tT7EgBP9BVGSCrHM+lcys
 intcMy7e8MwTqjTfh7k2SWREz0NU2zHz5dV8CJGLD//VEqlRQ97bSVNfclAjL80a1VoJ
 WxRk2d896UrmmWoPSIEfH/o/SM2UPYgqWiKhK5bfNF0izRUwiZubWRAl4tCuaAZJI3TN
 7yMzNzln42gFl5ZpnJQ/0ySnbyNxFEMGQCCa/ON5C6OBlsVygYbo1AO+o0QAMgq/IwUi
 rtpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731597725; x=1732202525;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lIrsDtygNM2LdbbxxBhnk030aqjLrUc1+0ltWCQU+q4=;
 b=OEFJgZVBmlA787BW1HBErWc5j7Skn25ajN04FqX5pEneD/RubbmXzrkiFeFyL9sFhm
 mMibSm/Sy8cWN2W89jqJIT3R3FtgoRTD1eSfSg76A5FdEwF1FXk2zDge4ktsu+nuDno+
 Vh+x+SoyQPdt3IkrCXBfr5SXYf8Phb2JLiXURMd7ltzQubD35bnosVd+pwJIoTyG1Jz3
 FZuc/ab4gs1byolqo6KRNHqnTPt+eiTgjbMQBcdcyQtvjdIOlvwRB2Eo+QeVGaFQ7wCz
 q2zslwmd97vmNmEpgyf+kYV9kzJGBT/m2oQiUMd3dxceeaXttQnDC6h2/jEdZWU1cnpp
 1awA==
X-Gm-Message-State: AOJu0YwTLx/YScCsmCpjaKbJA/WNzziqRtCwT52vghLTQ3uDy22ART6q
 CBpxkvdnhOfidHC7RETrunDh2IvbZB3vk50j8bD74AS9oREAm9P4KZUw93MHaHU=
X-Google-Smtp-Source: AGHT+IHtq7xB6Rga4AuJsoSXMrPg2HJ1w6Qgd7LunkNeOs4ZsXBSkk38jmJItn0za6H96PrbY45i5g==
X-Received: by 2002:a05:6512:3e01:b0:536:741a:6bad with SMTP id
 2adb3069b0e04-53da5c28d7dmr1536019e87.12.1731597725189; 
 Thu, 14 Nov 2024 07:22:05 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821adad9c2sm1713279f8f.33.2024.11.14.07.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 07:22:04 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A846B5F867;
 Thu, 14 Nov 2024 15:22:03 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  manos.pitsidianakis@linaro.org,
 kwolf@redhat.com,  junjie.mao@hotmail.com,  zhao1.liu@intel.com,
 qemu-rust@nondevel.org
Subject: Re: [RFC PATCH 00/11] rust: improved integration with cargo
In-Reply-To: <CABgObfZT_jYJqKDnTAdrVjr9KdQXjNVEt2eQfDpoqrh6xEnVsQ@mail.gmail.com>
 (Paolo Bonzini's message of "Thu, 14 Nov 2024 14:11:25 +0100")
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <87plmyrmjh.fsf@draig.linaro.org>
 <CABgObfZT_jYJqKDnTAdrVjr9KdQXjNVEt2eQfDpoqrh6xEnVsQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 14 Nov 2024 15:22:03 +0000
Message-ID: <87jzd5suw4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12f.google.com
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On Thu, Nov 14, 2024 at 2:07=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>> > First, while it is currently possible to run cargo on the rust/ direct=
ory,
>> > it has the issue that the bindings.rs must be placed by hand in
>> > the build directory.  Therefore, this series starts by allowing
>> > cargo to "just work" when run in a "meson devenv" environment:
>> >
>> >     meson devenv -w ../rust cargo clippy --tests
>> >     meson devenv -w ../rust cargo fmt
>>
>> Is this meant to be the rust source root, or the root of the rust
>> builddir:
>>
>> $ meson devenv ../../rust
>
> rust/ in the source directory.  You also need to run "meson devenv"
> from the root of the build directory.
>
> In practice you can just use "make clippy" or similar.

make clippy certainly works

>> ERROR: Build data file './meson-private/build.dat' references
>> functions or classes that don't exist. This probably means that it
>> was generated with an old version of meson. Try running from the
>> source directory meson setup . --wipe
>> =F0=9F=95=9913:05:22 alex@draig:qemu.git/builds/rust  on =EE=82=A0 revie=
w/rust-cargo-rfc [$!?] [=F0=9F=94=B4 ERROR]
>> $ meson devenv rust
>
> Your meson-private/ directory is stale.  Any "make" or "ninja" invocation=
 will
> fix it.

=E2=9C=97  make -j30
[1/53] Generating tests/include/QAPI test (include) with a custom command
[2/21] Generating rust_arm_softmmu.rs with a custom command (wrapped by mes=
on to capture output)
[3/21] Generating rust_aarch64_softmmu.rs with a custom command (wrapped by=
 meson to capture output)
[4/21] Generating qemu-version.h with a custom command (wrapped by meson to=
 capture output)
=F0=9F=95=9915:18:58 alex@draig:qemu.git/builds/rust  on =EE=82=A0 review/r=
ust-cargo-rfc [$!?]=20
=E2=9E=9C  meson devenv ../../rust

ERROR: Build data file './meson-private/build.dat' references functions or =
classes that don't exist. This probably means that it was generated with an=
 old version of meson. Try running from the source directory meson setup . =
--wipe

I also tried a wipe and re-configure but the same thing.

=E2=9E=9C  ls -la meson-private/
total 24768
drwxr-xr-x  4 alex alex     4096 Nov 14 15:20 ./
drwxr-xr-x 77 alex alex     4096 Nov 14 15:21 ../
-rw-r--r--  1 alex alex     7569 Nov 14 15:20 aarch64-softmmu-config-device=
s.mak.d
-rw-r--r--  1 alex alex     7084 Nov 14 15:20 arm-softmmu-config-devices.ma=
k.d
-rw-r--r--  1 alex alex  1877658 Nov 14 15:20 build.dat
-rw-r--r--  1 alex alex    27208 Nov 14 15:20 cleantrees.dat
drwxr-xr-x  3 alex alex     4096 Nov 14 15:20 __CMake_compiler_info__/
drwxr-xr-x  3 alex alex     4096 Nov 14 15:20 cmake_libcbor/
-rw-r--r--  1 alex alex      162 Nov 14 15:20 cmd_line.txt
-rw-r--r--  1 alex alex   333651 Nov 14 15:20 coredata.dat
-rw-r--r--  1 alex alex    24920 Nov 14 15:20 install.dat
-rw-r--r--  1 alex alex 19049522 Nov 14 15:20 libsanity.a
-rw-r--r--  1 alex alex     1748 Nov 14 15:20 meson_benchmark_setup.dat
-rw-r--r--  1 alex alex        0 Nov 14 15:20 meson.lock
-rw-r--r--  1 alex alex   140166 Nov 14 15:20 meson_test_setup.dat
-rwxr-xr-x  1 alex alex  3826912 Nov 14 15:20 rusttest*
-rw-r--r--  1 alex alex       46 Nov 14 15:20 sanitycheckc.c
-rwxr-xr-x  1 alex alex    15840 Nov 14 15:20 sanitycheckc.exe*
-rw-r--r--  1 alex alex       30 Nov 14 15:20 sanity.rs
=F0=9F=95=9915:21:27 alex@draig:qemu.git/builds/rust  on =EE=82=A0 review/r=
ust-cargo-rfc [$!?]=20
=E2=9E=9C  meson devenv ../../rust

ERROR: Build data file './meson-private/build.dat' references functions or =
classes that don't exist. This probably means that it was generated with an=
 old version of meson. Try running from the source directory meson setup . =
--wipe
=F0=9F=95=9915:21:43 alex@draig:qemu.git/builds/rust  on =EE=82=A0 review/r=
ust-cargo-rfc [$!?] [=F0=9F=94=B4 ERROR]=20
=E2=9C=97=20=20

>
> Paolo

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

