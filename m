Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F186DCD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWyC2-0005ju-QU; Tue, 09 Jun 2026 11:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wWyC0-0005jf-Nu
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:16:40 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wWyBx-00056W-QB
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:16:40 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-687ed9aabb3so11179950a12.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 08:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781018195; cv=none;
 d=google.com; s=arc-20240605;
 b=OdXTYIL9x8NEe3TCyqmrLYXNV6e0J2AQxQ5bbhEKcRET2DzntM8e12ZlUP5xtMRPqA
 q/NtEfvasp2cCqkX1/yZJleGyoSqMmMiSFJZwYOjy9lMeq0zTQ3b2aXGT1qVsAtNG3NJ
 ukByHeZtOzIhUBMORDl6Phn2cc5QZ0vlzsouLLIxMVsXuDA5DvkQKdvfSN/C9JfJJNjq
 WqkRvrBAfNvGYa48QAEYTaRqmkMAw/HTwLeyZsiIAlk5jyevUUMYDxK6VX/ACFZtKg0u
 rzp7DklcISoPwq2Ie9jD4FTvR2WIs6lDX3Sg9bf+rh6xlHvie6nMd0CK9HOdmwWS3RPX
 Q/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=s+E8yDRFz1fyPMeve3TBz2C1MR11wvL1X34BWx9enb0=;
 fh=sFPVMsbhWLeSh/4moRRBHKaN/SwOlqH30sV3Ay3TTtM=;
 b=d4dPUjUhiZtvodgiUU1EOUtg9Vi2TYUN6tLaNPa0g6qk+fVQHqwqIWth+gBb5PH8qc
 TtKZ/FC7+DRTj1RNT6/jBGhhtzLiKIEGE5u4of8pheIU51ewazNCfVJ19FakZ9QmwAah
 2+HHuEZqLiqgEDSA4j4uAX3G1i+d6SQnlv7WXXSE/s3NUVm1x7i1Vp41f85IQx4FXH3t
 dINDk7ATPhW1db6uWjwUCIZAHYXjaIdGsA4i4lFws8S9nTSk96lo6C5SGiNQo9wnLSHT
 D5EfqNlfGG0VN5R64dgN0BfCVq99wUIlLVcrD4aSfXWjcnINUCKN1uoPlc27cItueJeg
 vgYg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781018195; x=1781622995; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+E8yDRFz1fyPMeve3TBz2C1MR11wvL1X34BWx9enb0=;
 b=NvbgWABMGIBYWySgrWL4Sy2bUTTt2ikPBdvXEaaevlibaYhwyxXOOHVg+5yU/5LrsI
 9Go6YmmhC3At83E0QKrlkqArPiTQA1F4IrtNzVKayoQhTq+jFWy4a2YB0wTxZGuPyQfh
 HM9k27eYZTSz/ZoTJkZiLJCFW8jMnTpPYqCRcPJYRyZHBoDH7XQQT4+4Y3jrRbS/uhYf
 MrMz8ZFv0PA75s6HYqd2+fy2UUT2ECS9lxu893FW2oc91HRDv/759FwI9Fl0jwYqsilJ
 7d8PWkj7ThG6F7vkIYc2JnpT0dTeFi6xFqDjIIpxAsfp+qoLGdlia9G7rjgdApvscy/s
 HFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781018195; x=1781622995;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s+E8yDRFz1fyPMeve3TBz2C1MR11wvL1X34BWx9enb0=;
 b=ffpMe+qc2AuMnLaxWfFoef6TZT1fpNM2aKNljeDiChyLsTO1/k7YczhRae56X9m704
 /4bt6JeUTy4JHOQtT2QfW70eBk4Ras3iDH9toEO/4Sqv0Jzpky1rzERfAESNfg3+iDFF
 /3JTDsyUsWbgYf/3h/k6YMrSIaEUWKN1xH3IyFsgn6apbFerhbkYIhZWSRy1sKiUE8gJ
 tHuCyBhT182pURx9ku48beALCZp8QPm4w3KY07JSiljv+l2Y9wrNUeZC8MtcIq3JSDYo
 MLaAxMYNo9o8LEUzUDP0MKZrT2yHICtip8KJcYQk3KluKtBjnKUJXDbsdKa/dBRnyxVM
 KoMg==
X-Gm-Message-State: AOJu0Yyoorwb1YKuS61elsg9u0LT0nPJcT2yZJGBP1xddGmvDuFbb3fT
 e3Af4TUinTNGpqIVm245AmvPfLkfovfBnZ9cnWkBbl+TaDjB7gEqzNSSF1cghVSqkp6UOlJWwqz
 vLAl7NCOy+gaiDF6xAVv97cW70OfY5p0=
X-Gm-Gg: Acq92OHaq4hxHWmqNC5OMl7UcD4dYnNnuMMP3JmBuQDWd/7d5BtYldVRa5/8ho2xbJD
 lanE429Pxsv0lWpTA3cl1gf1apGNyfe+NXWIjFBxa6Tq6R78wqn11X/gK2g+GKkrkYVzGN63HtW
 F8jdvjDAjTzUtNqzCl1TboK+IK0KPJZRxvT6vWgaArSMF1oJWfCnakT2DlmOmG9JmaLsPjUqSAQ
 MdEnzPadIthXFIFGLeDr+xJyi6UdudJbgusN6zFG7FvBhGZ90yKY6qiG2Wu20XC+rFYP24mKYTh
 QwM/zD0u1v/feO0/2HK7XI94kmRMWZB5WZBpSffAMh9fEzRXeMyh
X-Received: by 2002:a05:6402:4301:b0:691:5f30:37ec with SMTP id
 4fb4d7f45d1cf-6915f303b38mr7037816a12.25.1781018194793; Tue, 09 Jun 2026
 08:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260608194256.13794-1-deller@kernel.org>
In-Reply-To: <20260608194256.13794-1-deller@kernel.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 9 Jun 2026 11:16:21 -0400
X-Gm-Features: AVVi8Ceu-w1zuis2qfRWbZ4Um4OBKEbTvyEnPPTuAH4CDb5c23r9cfytTDGKjXg
Message-ID: <CAJSP0QWtOGdNx-hQnmcDhagKdB7iEwoQyc9b1_YxP9RbQHYfJQ@mail.gmail.com>
Subject: Re: [PULL 0/8] Linux user patches
To: Helge Deller <deller@kernel.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 Helge Deller <deller@gmx.de>, Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
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

On Mon, Jun 8, 2026 at 3:43=E2=80=AFPM Helge Deller <deller@kernel.org> wro=
te:
>
> From: Helge Deller <deller@gmx.de>
>
> The following changes since commit 29c042c6e9d4a09d4a0ac3fa54aeb7ee08ce0b=
dc:
>
>   lcitool: remove Cirrus CI support (2026-06-03 12:45:38 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/hdeller/qemu-hppa.git tags/linux-user-pull-request
>
> for you to fetch changes up to fd8da2844c4354ecf54bd73a2fa7babe669b7a12:
>
>   target/sh4: decode_gusa: recognize add#imm with prior mov Rm, Rn (2026-=
06-07 17:56:24 +0200)
>
> ----------------------------------------------------------------
> linux-user patches for alpha, sparc and sh4
>
> Various linux-user related patches from Matt Turner with coredump support=
 for
> alpha and sparc, as well as some fixes for the signal handler in sparc.
>
> The patches from Xinhui Yang add the missing fsmount series syscalls supp=
ort
> for systemd.
>
> ----------------------------------------------------------------
>
> Matt Turner (6):
>   linux-user/alpha: add coredump support
>   linux-user/sparc: add coredump support
>   linux-user/sparc: restore L/I registers from RSA in
>     sparc64_set_context
>   linux-user/sparc: call block_signals() before set_sigmask() in
>     setcontext
>   linux-user/sparc: flush register windows before core dump
>   target/sh4: decode_gusa: recognize add#imm with prior mov Rm, Rn
>
> Xinhui Yang (2):
>   linux-user: implement fsmount(2) series of syscalls
>   linux-user/strace: add fsmount series of syscalls

Hi Xinhui Yang,
Please take a look at the CI failures below. It will probably be
necessary to detect the availability of the fs syscalls at build time
and avoid them when the host lacks support.

Please send a fixed patch series to the list so Helge can pick it up
again in a future pull request. Thanks!

- https://gitlab.com/qemu-project/qemu/-/jobs/14769379047#L3283

../linux-user/syscall.c: In function =E2=80=98do_syscall1=E2=80=99:
../linux-user/syscall.c:14422:29: error: implicit declaration of
function =E2=80=98fsopen=E2=80=99; did you mean =E2=80=98fdopen=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
14422 | ret =3D get_errno(fsopen(p, arg2));
| ^~~~~~
| fdopen
../linux-user/syscall.c:14422:29: error: nested extern declaration of
=E2=80=98fsopen=E2=80=99 [-Werror=3Dnested-externs]
../linux-user/syscall.c:14457:33: error: implicit declaration of
function =E2=80=98fsconfig=E2=80=99; did you mean =E2=80=98fscanf=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
14457 | ret =3D get_errno(fsconfig(arg1, arg2, p3, p4, arg5));
| ^~~~~~~~
| fscanf
../linux-user/syscall.c:14457:33: error: nested extern declaration of
=E2=80=98fsconfig=E2=80=99 [-Werror=3Dnested-externs]
../linux-user/syscall.c:14496:25: error: implicit declaration of
function =E2=80=98fsmount=E2=80=99; did you mean =E2=80=98umount=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
14496 | ret =3D get_errno(fsmount(arg1, arg2, arg3));
| ^~~~~~~
| umount
../linux-user/syscall.c:14496:25: error: nested extern declaration of
=E2=80=98fsmount=E2=80=99 [-Werror=3Dnested-externs]
../linux-user/syscall.c:14501:29: error: implicit declaration of
function =E2=80=98fspick=E2=80=99 [-Werror=3Dimplicit-function-declaration]
14501 | ret =3D get_errno(fspick(arg1, p, arg3));
| ^~~~~~
../linux-user/syscall.c:14501:29: error: nested extern declaration of
=E2=80=98fspick=E2=80=99 [-Werror=3Dnested-externs]

- https://gitlab.com/qemu-project/qemu/-/jobs/14769379043#L4371

../linux-user/strace.c:4352:10: error: use of undeclared identifier
'FSCONFIG_SET_FLAG'
case FSCONFIG_SET_FLAG:
^
../linux-user/strace.c:4355:10: error: use of undeclared identifier
'FSCONFIG_SET_STRING'
case FSCONFIG_SET_STRING:
^
../linux-user/strace.c:4358:10: error: use of undeclared identifier
'FSCONFIG_SET_BINARY'
case FSCONFIG_SET_BINARY:
^
../linux-user/strace.c:4361:10: error: use of undeclared identifier
'FSCONFIG_SET_PATH'
case FSCONFIG_SET_PATH:
^
../linux-user/strace.c:4364:10: error: use of undeclared identifier
'FSCONFIG_SET_PATH_EMPTY'
case FSCONFIG_SET_PATH_EMPTY:
^
../linux-user/strace.c:4367:10: error: use of undeclared identifier
'FSCONFIG_SET_FD'
case FSCONFIG_SET_FD:
^
../linux-user/strace.c:4370:10: error: use of undeclared identifier
'FSCONFIG_CMD_CREATE'
case FSCONFIG_CMD_CREATE:
^
../linux-user/strace.c:4373:10: error: use of undeclared identifier
'FSCONFIG_CMD_RECONFIGURE'
case FSCONFIG_CMD_RECONFIGURE:
^
../linux-user/strace.c:4408:10: error: use of undeclared identifier
'FSCONFIG_SET_FLAG'
case FSCONFIG_SET_FLAG:
^
../linux-user/strace.c:4409:10: error: use of undeclared identifier
'FSCONFIG_SET_STRING'
case FSCONFIG_SET_STRING:
^
../linux-user/strace.c:4410:10: error: use of undeclared identifier
'FSCONFIG_SET_BINARY'
case FSCONFIG_SET_BINARY:
^
../linux-user/strace.c:4411:10: error: use of undeclared identifier
'FSCONFIG_SET_PATH'
case FSCONFIG_SET_PATH:
^
../linux-user/strace.c:4412:10: error: use of undeclared identifier
'FSCONFIG_SET_PATH_EMPTY'
case FSCONFIG_SET_PATH_EMPTY:
^
../linux-user/strace.c:4413:10: error: use of undeclared identifier
'FSCONFIG_SET_FD'
case FSCONFIG_SET_FD:
^
../linux-user/strace.c:4422:10: error: use of undeclared identifier
'FSCONFIG_SET_STRING'
case FSCONFIG_SET_STRING:
^
../linux-user/strace.c:4423:10: error: use of undeclared identifier
'FSCONFIG_SET_PATH'
case FSCONFIG_SET_PATH:
^
../linux-user/strace.c:4424:10: error: use of undeclared identifier
'FSCONFIG_SET_PATH_EMPTY'
case FSCONFIG_SET_PATH_EMPTY:
^
../linux-user/strace.c:4440:10: error: use of undeclared identifier
'FSCONFIG_SET_PATH'
case FSCONFIG_SET_PATH:
^
../linux-user/strace.c:4441:10: error: use of undeclared identifier
'FSCONFIG_SET_PATH_EMPTY'
case FSCONFIG_SET_PATH_EMPTY:
^

Stefan

>
>  linux-user/alpha/elfload.c    |  12 ++++
>  linux-user/alpha/target_elf.h |  13 +++++
>  linux-user/elfload.c          |   9 +++
>  linux-user/sparc/cpu_loop.c   |   3 +-
>  linux-user/sparc/cpu_loop.h   |   7 +++
>  linux-user/sparc/elfload.c    |  54 +++++++++++++++++
>  linux-user/sparc/signal.c     |  27 +++++++++
>  linux-user/sparc/target_elf.h |  20 +++++++
>  linux-user/strace.c           | 105 ++++++++++++++++++++++++++++++++++
>  linux-user/strace.list        |  15 +++++
>  linux-user/syscall.c          |  91 +++++++++++++++++++++++++++++
>  target/sh4/translate.c        |   2 +-
>  12 files changed, 356 insertions(+), 2 deletions(-)
>  create mode 100644 linux-user/sparc/cpu_loop.h
>
> --
> 2.54.0
>
>

