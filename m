Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5AEC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonKC-0008Jw-KM; Tue, 28 Jul 2026 15:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wonK6-0008J3-AF
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:18:42 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wonK4-0007F6-9n
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:18:42 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso188747a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:18:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785266319; cv=none;
 d=google.com; s=arc-20260327;
 b=OQ3dS6AwDbr9F4+CAdHzPWipTQ/ezW+LLpI+c12RwlBlnq1FCzY+AKjxBCipX1ei0W
 hCp7cEA6sGdVj8nMSgCqGJdNjYSwMfnLqp81NmrytCZg4JyeIUBoDgiEc3gbsSq1xns/
 cLqEhz7FYHpF2P6NQRkCDmULJumVUbOaHfOPhL8uHleltxoqv9lwWW0N28hj0BLZjaDy
 ntoHbIZjTtiX7xySFp5/vNtJI9lbpjnL3lMMtwFxOjoDeulTFw9OrociIEAvHyvWLyqR
 m/LLLFoFgLE1Wyb/UtFm2E6dml6TBTIMazyZ0MeKwYxiSDO0sdlMPY8+qC1Lnn167zCd
 TYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QiFENo3Nyl9AQtEd4aostqsdQ5U3/B+Snq9ofCy4bLs=;
 fh=CNAgUDLasxz2lYSZNlMG+iH4+MgqX9vF4bvGWaFS8S8=;
 b=lNbRaKvEGtEyrgrYt2DUoQuS83PZKgrwc+DH8tybYzVVeyRnKKnSzHJyvP/VOP6QxE
 J1FNF+Asg06yyuWJGPqIzA4M8QT26H49NmnOXruaYBfHNkflw3I/3ZJcq7Ek2DX7sC6M
 +xHZGmWkwvMwUr/Gmmp4TfqUAdiUxUwgc1zuZoFMvlA7lfwKjodJDq4Y6Pi2wRIJ7Xtt
 QAIbYrai83PH/YdOlNCqPNxvCExvtM4aaq0LXPwYbiEGx3wa5R+hExl/MHbfzhGnhyCb
 vkuzLrW25vlxCwto1e2vnAG2z9uMFiyhV5WIdppuHPQ7Vmhay4g+NMIBakwNKts8gDvH
 ENAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785266319; x=1785871119; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QiFENo3Nyl9AQtEd4aostqsdQ5U3/B+Snq9ofCy4bLs=;
 b=mhFHASGgcdr0PPZxp3ztajxLAfJ/MrsyJoTFQTU4VbWwraH37zVfukEqMv2htCs/jl
 Taupr3NKR+rOgDVZb2O+GM1rpqwJVSTsc37qj49XCERHjvpQ/ctpK9Sn/56Vm5kOZQNg
 E/XGQSHOR1ImQsX2b55Qt+Tp4IkxCrkPkhnzxmiw+8Yqv9dCeVvH/7/RO+CCy09p0vWC
 /LsQ/ZMpalSeOSlV19b311IKJtn12XLlfcp0cbt70zkjcUWpMhZ0P3nud6B+41ORtKQM
 gquX/CyZYMRaCS7yEOSy97gY4B9n7mNb5b2zH+Z/e9VnlH908fdRS4Afb3s4GdfvoI3C
 0X5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266319; x=1785871119;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QiFENo3Nyl9AQtEd4aostqsdQ5U3/B+Snq9ofCy4bLs=;
 b=UPWL1V3oi1a8q7dRmYzzF7DHCyvBTZ41sOTxMllVP0Yc9Ns+ZAA5VQQwj8EHm63wPz
 pCOU/z03HwAqm84WfpouNQl1EWKAN0Pm6hGN6Y5CLiehmFCLLgYLxP8nL+1ccuabKu4V
 6oVlf5z5VP1GkOvZeO9S/jRuFy4IQapoPL+5UPWGLC/TfHmHpGgUuYPjmCg3+NJnH7f/
 Wf0ZI5Vbqp3CPXQS9FZM3AljfissX2gYCScj4GgzBK7o3yRe00FgukEfNgpFd6xLoX3v
 4xr8lJdXwDKVZSQqoan7RFznYO2SOO+8A2YLsJcSEWxioreTDW789h/KyXv6MZ7LBeu5
 6iHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUFJAnxlFiMSZIMVJtDFUYHJ6Al4+giEC+TsFiQQu/mDw/DvXmLYOwBmcz+IBF8agZKCvFYMhOus25@nongnu.org
X-Gm-Message-State: AOJu0Yzc6nTvQMw69IsZ+HaYb4N4sNou+59th3y6rNzQDWhb01A29vrW
 UREtty5IwoekSA0j2BFxK2iqLn5EgtLGoAZLoRUT1lnnhBczUbZMlNfoxoV3pXfeBX1Aa8RtPQQ
 vKY/CF6b4NbUoWPlqeifasd5qcdC0s08=
X-Gm-Gg: AR+sD11Z6niHQWVBpppmmqebAR9z5Z+AXayMvst39ltZnR+UOnhCNcNdBQ56l9+iI6M
 qfc2s9hLa+kJSUoETP7iHNQW99tpTXodHVjDdH2YAkr97wvWuFo3S9wiEyhMrOabfA4+Y78aFpy
 94UASew8S6s5TWycBBOIW7235XdXORaJYPxZwIVQ3STEpmDcOEUtv63J5D3KjISmsHteID58pD5
 2lLZTEjiuJD/v2pv9Lxc5Z7QEfpaTrUuOOIAIYV3N356dvuUbc0oh1mhXk2baZReGc3QSax7g5V
 qOkR7GczhBsKllujDATHE3DJXotXXg==
X-Received: by 2002:a05:6402:42cb:b0:69f:cb2f:7a9f with SMTP id
 4fb4d7f45d1cf-6a0349474ebmr2127025a12.0.1785266318495; Tue, 28 Jul 2026
 12:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260728173739.352078-1-kwolf@redhat.com>
 <20260728173739.352078-15-kwolf@redhat.com>
In-Reply-To: <20260728173739.352078-15-kwolf@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 28 Jul 2026 15:18:24 -0400
X-Gm-Features: AUfX_mzNMtIrag08TP3pfqUBDW3ryVoZkJtXu5c9KyIHGXW4v9mlqMeAyWHm7o4
Message-ID: <CAJSP0QUzVP1eksORFJV0trFDztBWR9WW4B-d-MEaxa7mJpKkxg@mail.gmail.com>
Subject: Re: [PULL 14/17] iotests: test O_TRUNC behavior for fuse exports
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, qemu-devel@nongnu.org
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

Hi Kevin and Fiona,
Please take a look at the following CI failure and send a new pull request:

https://gitlab.com/qemu-project/qemu/-/jobs/15583116603#L174

88/104 block-raw-optional+block-slow - qemu:io-raw-fuse-truncate ERROR
0.24s exit status 1
>>> MESON_TEST_ITERATION=3D1 MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_erro=
r=3D1:print_summary=3D1:print_stacktrace=3D1 RUST_BACKTRACE=3D1 ASAN_OPTION=
S=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1 MALLOC_PERTURB_=
=3D106 UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=
=3D1:print_stacktrace=3D1 LD_LIBRARY_PATH=3D/builds/qemu-project/qemu/build=
/subprojects/libvfio-user/lib PYTHON=3D/builds/qemu-project/qemu/build/pyve=
nv/bin/python3 /builds/qemu-project/qemu/build/pyvenv/bin/python3 /builds/q=
emu-project/qemu/build/../tests/qemu-iotests/check -tap -raw fuse-truncate =
--source-dir /builds/qemu-project/qemu/tests/qemu-iotests --build-dir /buil=
ds/qemu-project/qemu/build/tests/qemu-iotests
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
--- /builds/qemu-project/qemu/tests/qemu-iotests/tests/fuse-truncate.out
+++ /builds/qemu-project/qemu/build/scratch/raw-file-fuse-truncate/fuse-tru=
ncate.out.bad
@@ -1,5 +1,23 @@
-...
+E..
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ERROR: test_o_trunc (__main__.TestTruncateBlockdev)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+ File "/builds/qemu-project/qemu/tests/qemu-iotests/tests/fuse-truncate",
line 93, in setUp
+ self.evaluate_preconditions()
+ File "/builds/qemu-project/qemu/tests/qemu-iotests/tests/fuse-truncate",
line 133, in evaluate_preconditions
+ self.supports_preconditions =3D check_sudo_support()
+ File "/builds/qemu-project/qemu/tests/qemu-iotests/tests/fuse-truncate",
line 41, in check_sudo_support
+ subprocess.run(['sudo', '-n', 'losetup', '--version'],
+ File "/usr/lib64/python3.9/subprocess.py", line 505, in run
+ with Popen(*popenargs, **kwargs) as process:
+ File "/usr/lib64/python3.9/subprocess.py", line 951, in __init__
+ self._execute_child(args, executable, preexec_fn, close_fds,
+ File "/usr/lib64/python3.9/subprocess.py", line 1837, in _execute_child
+ raise child_exception_type(errno_num, err_msg, err_filename)
+FileNotFoundError: [Errno 2] No such file or directory: 'sudo'

