Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F45CD6A220
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 17:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBdda-0002tV-E4; Thu, 14 Nov 2024 12:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tBddZ-0002tN-30
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:28:09 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tBddX-0001pR-7k
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 12:28:08 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-53da2140769so947587e87.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 09:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731605285; x=1732210085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+YuJJzAXccB4jMURXD6G/aVsYpbfMokD5aRjaYAqNRc=;
 b=Zyrw6JFmtNeGN8GCD8iRl2I+IalcV1p4ke65Z6FskhmI4jeB4suNA7Ogiu9nnZYXF9
 iaxfK/6UwdDEnQuStqmLLthBTdbnZ+w3DXI9sobU3M3oKiMGiOPYP5oOIN1eOJVslcFD
 7liwnm0zRFw5yP4HSm7OZiKV0da4tlDX1xpLNMvGlmCJrz9fvofgqp9rbVfda7JmSqOM
 wHANNthh8QMRcE6dwg2GX/I8utBey2uS/a2QRhG66WcY2j5K648vnTbarRjIYSi7LF3g
 B1f6gp0PoyYqFlV9NlAHs8EPYz3bic+34LPQ5MyATS1fTOJaFIhkvRvAMFI+tYn6GDN8
 pRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731605285; x=1732210085;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+YuJJzAXccB4jMURXD6G/aVsYpbfMokD5aRjaYAqNRc=;
 b=ElrBeW+Z7dNsRCdgtl3FRyEpWS7SqPHhpmotWqNGqDX8pulpD24LrWwsXHti1R+wUk
 8hNYKB5VNvWFltPQ2XwWDXcU1+7iTE8jaACj8ZhBB39eELb0MpZCXozOjgWBL8XfkteX
 8l1nsYuuR9+PVmkLuiKVfAwMHhZmlOTaz7JUA65hzlTQd38sezAbTzZfXWTkAVqUU89Z
 oS2ZYwJo+CNsu39V8R0QrKEeIt+fOUpL3rtkRvJjMPyQFGwj8dQNIbi6qoQa0Ikla5wm
 Fu5vq/4aBbwt79bs2x8tSLvEStahjYjJGbXXo1StKwsuIDK+J4Xtu5co1ITdQJoexffj
 KXAQ==
X-Gm-Message-State: AOJu0YxUsoxBjeJqWFeaHqR0BfP7FgO7N3aimIIY8bgC6uC8Dp8nZcX+
 Ph3V+s61S66hcP1D16JXGvtPIMJ19HEJfArULOk7NziuM6CUaaVZEUGDvPI7oMg=
X-Google-Smtp-Source: AGHT+IENPUvVLhgl0PEG1tDAFIkN8wUNc6gBVaDnI+ekcjQNLlNd6y51Kw3VGksIIiNxYfAsg7gW6w==
X-Received: by 2002:ac2:4c51:0:b0:533:d3e:16f5 with SMTP id
 2adb3069b0e04-53da5c79c08mr2062409e87.38.1731605284996; 
 Thu, 14 Nov 2024 09:28:04 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da29989asm29763445e9.42.2024.11.14.09.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 09:28:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 299EA5F867;
 Thu, 14 Nov 2024 17:27:57 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  manos.pitsidianakis@linaro.org,
 kwolf@redhat.com,  junjie.mao@hotmail.com,  zhao1.liu@intel.com,
 qemu-rust@nondevel.org
Subject: Re: [RFC PATCH 00/11] rust: improved integration with cargo
In-Reply-To: <d2813ee7-6500-4145-b767-37d227747944@redhat.com> (Paolo
 Bonzini's message of "Thu, 14 Nov 2024 16:38:39 +0100")
References: <20241108180139.117112-1-pbonzini@redhat.com>
 <87plmyrmjh.fsf@draig.linaro.org>
 <CABgObfZT_jYJqKDnTAdrVjr9KdQXjNVEt2eQfDpoqrh6xEnVsQ@mail.gmail.com>
 <87jzd5suw4.fsf@draig.linaro.org>
 <d2813ee7-6500-4145-b767-37d227747944@redhat.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 14 Nov 2024 17:27:57 +0000
Message-ID: <87ed3dsp2a.fsf@draig.linaro.org>
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

> On 11/14/24 16:22, Alex Benn=C3=A9e wrote:
>> ERROR: Build data file './meson-private/build.dat' references
>> functions or classes that don't exist. This probably means that it
>> was generated with an old version of meson. Try running from the
>> source directory meson setup . --wipe
>> I also tried a wipe and re-configure but the same thing.
>
> Ah, nevermind - you must have an older meson installation in /usr.
> You have to do pyvenv/bin/meson to pick the right one.  I'll adjust
> the docs.

Hmm,

=E2=9C=97  ./pyvenv/bin/meson devenv ../../rust
Traceback (most recent call last):
  File "/home/alex/lsrc/qemu.git/builds/rust/pyvenv/lib/python3.11/site-pac=
kages/mesonbuild/mesonmain.py", line 188, in run
    return options.run_func(options)
           ^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/home/alex/lsrc/qemu.git/builds/rust/pyvenv/lib/python3.11/site-pac=
kages/mesonbuild/mdevenv.py", line 228, in run
    return subprocess.call(args, close_fds=3DFalse,
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/subprocess.py", line 389, in call
    with Popen(*popenargs, **kwargs) as p:
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.11/subprocess.py", line 1024, in __init__
    self._execute_child(args, executable, preexec_fn, close_fds,
  File "/usr/lib/python3.11/subprocess.py", line 1901, in _execute_child
    raise child_exception_type(errno_num, err_msg, err_filename)
PermissionError: [Errno 13] Permission denied: '../../rust'

ERROR: Unhandled python OSError. This is probably not a Meson bug, but an i=
ssue with your build environment.
=F0=9F=95=9917:26:59 alex@draig:qemu.git/builds/rust  on =EE=82=A0 review/r=
ust-cargo-rfc [$!?] [=F0=9F=94=B4 13]=20
=E2=9C=97  ls -l ../../rust/
total 40
-rw-r--r-- 1 alex alex 3237 Nov 12 21:01 Cargo.lock
-rw-r--r-- 1 alex alex 2426 Nov 14 12:15 Cargo.toml
drwxr-xr-x 3 alex alex 4096 Nov 11 23:19 hw/
-rw-r--r-- 1 alex alex   18 Nov 11 23:19 Kconfig
-rw-r--r-- 1 alex alex  437 Nov 14 12:15 meson.build
drwxr-xr-x 4 alex alex 4096 Nov 14 12:15 qemu-api/
drwxr-xr-x 3 alex alex 4096 Nov 14 12:15 qemu-api-macros/
-rw-r--r-- 1 alex alex  191 Nov 11 23:19 rustfmt.toml
drwxr-xr-x 4 alex alex 4096 Nov 14 15:18 target/
-rw-r--r-- 1 alex alex 2262 Nov 12 21:01 wrapper.h

>
> Paolo

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

