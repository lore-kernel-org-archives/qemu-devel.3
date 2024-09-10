Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C197EDE99A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 15:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so2x3-00030C-E3; Tue, 10 Sep 2024 11:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1so2x2-0002zX-4S
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:38:44 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1so2x0-0008Ch-9s
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 11:38:43 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c3c34e3c39so8042181a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725982720; x=1726587520; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+MwTWjJmVFM4I7GiuFCQ7keM3v9tcNhGnqLV5Q2Rz4=;
 b=waLEF2XRVtXvR9kSebzgpCjf5s4LZmGI8hHnbbDmJnPV0OxQsfh3iPsF6Yn7a4/LlN
 nmDwJLgvB5nqmjD0u/wJLmfU7OvN1g4F/nDmQppSqy7iqhGqFRqJNKXQm77ldDDTlzqS
 ioMBy6o4k7zUHzMBrj0zWf9/vXJdNxlVl3oBJwBJVPNz9TV0YJhmbTBCL5iN+i5kNoqe
 pF14OKlLUtqgECJGI7S70nItzcZ+1K1chmubfdIF6D68kM/Dlk0abccTFXVErayFQI2U
 LlZpRt+r6cpyV2L5Vjf0RSnkdpTg6YKbkJ7cKVUq7Z6N3W+g6zA48arhhkjQGzklh3nq
 vbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725982720; x=1726587520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+MwTWjJmVFM4I7GiuFCQ7keM3v9tcNhGnqLV5Q2Rz4=;
 b=Di1WK/6NjKAUP/VIxzRdERSlvGeV+y+/lvHTXpCFJ5iLLME4SfXHj09K5fLnrQyavI
 6qkMx6Jhb1PRHTqzl4GQ2zc1fOUsqvgEpTQiE9MLCnLGnjvsBe5Gq8qDvxN9mOoQyAT/
 RocMwZOLOEL9J5bQZvnOOjGG90KAUlQA4wKXCL+YYbNF/yy7dp2pCAfLLlf3yDcAhEgo
 Lvo/CA3Nnsy+60feOCxWUK44xzVU4kd/rsj4vIoLDEL+jUIqTrw++FivUVeBk0j1df2k
 0NgieQdtQwn3zcIfZ28N9k3IiDS62NeuGqZPg7X6pzLwT9Ih7flaCzqC8b/h3gOGJzx7
 iCMg==
X-Gm-Message-State: AOJu0Yw08nW9nX0hYuEGyyZFm4W9bqcf03/hrA0VNueWvNAdzDi0Csn0
 EMDlao+8K+D8k+Sk7liyGHHnEnDEQ0IiYvYA8eToP4IWze2/1d8M/WxtIyaRcMBvBPsY7JPlwtQ
 Arlw8JohlCYDu7N3KSQVWkqXFII/7CIMacou7fg==
X-Google-Smtp-Source: AGHT+IFltW0FXlVBO/2oGhw98eHaaIy2YGqQ3IiIzVga0arBw4ir0jaQxRUdisIvMg01EzckZZVCSDerX7RBuKD94lA=
X-Received: by 2002:a05:6402:3705:b0:5c0:ad94:1d3 with SMTP id
 4fb4d7f45d1cf-5c3dc7c52b7mr9164528a12.32.1725982719941; Tue, 10 Sep 2024
 08:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240910123726.182975-1-thuth@redhat.com>
In-Reply-To: <20240910123726.182975-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2024 16:38:29 +0100
Message-ID: <CAFEAcA_f1hMj=6wXzv2ZYuFVGDbaOpDOPzZrh3VAYqup06dXDg@mail.gmail.com>
Subject: Re: [PULL 00/22] Tests and misc patches
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 10 Sept 2024 at 13:37, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit 7bbadc60b58b742494555f06cd342311ddab93=
51:
>
>   Merge tag 'crypto-fixes-pull-request' of https://gitlab.com/berrange/qe=
mu into staging (2024-09-09 15:19:32 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-09-10
>
> for you to fetch changes up to cc3e005eb22332ba277bff2e39025d0087f3795e:
>
>   tests/functional: Fix bad usage of has_cmd (2024-09-10 13:44:42 +0200)
>
> ----------------------------------------------------------------
> * Split --enable-sanitizers to --enable-{asan, ubsan}
> * Build MSYS2 job using multiple CPUs
> * Fix "make distclean" wrt contrib/plugins/
> * Convert more Avocado tests to plain standalone functional tests
> * Fix bug that breaks "make check-functional" when tesseract is missing
>
> ----------------------------------------------------------------

On the 'make check-vm-openbsd' test I run:

595/944 qemu:func-quick+func-mips64el /
func-mips64el-mips64el_fuloong2e          ERROR            6.16s
exit status 1
602/944 qemu:func-quick+func-or1k / func-or1k-or1k_sim
           ERROR            6.91s   exit status 1

Slightly more detail further up in the log:


595/944 qemu:func-quick+func-mips64el /
func-mips64el-mips64el_fuloong2e          ERROR            6.16s
exit status 1
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
Traceback (most recent call last):
  File "/home/qemu/qemu-test.fsnflZ/src/tests/functional/test_mips64el_fulo=
ong2e.py",
line 29, in test_linux_kernel_3_16
    deb_path =3D self.ASSET_KERNEL.fetch()
  File "/home/qemu/qemu-test.fsnflZ/src/tests/functional/qemu_test/asset.py=
",
line 135, in fetch
    if not self._check(tmp_cache_file):
  File "/home/qemu/qemu-test.fsnflZ/src/tests/functional/qemu_test/asset.py=
",
line 52, in _check
    checksum =3D subprocess.check_output(
  File "/usr/local/lib/python3.10/subprocess.py", line 421, in check_output
    return run(*popenargs, stdout=3DPIPE, timeout=3Dtimeout, check=3DTrue,
  File "/usr/local/lib/python3.10/subprocess.py", line 503, in run
    with Popen(*popenargs, **kwargs) as process:
  File "/usr/local/lib/python3.10/subprocess.py", line 971, in __init__
    self._execute_child(args, executable, preexec_fn, close_fds,
  File "/usr/local/lib/python3.10/subprocess.py", line 1863, in _execute_ch=
ild
    raise child_exception_type(errno_num, err_msg, err_filename)
FileNotFoundError: [Errno 2] No such file or directory: 'sha256sum'


(test program exited with status code 1)


Similarly for the or1k failure.

If you want to use sha256sum in "make check" then we should
ensure that it's installed in these BSD VM images.

Also, does this mean that "make check" is now going to run
a lot of the tests that were previously in "make check-avocado"?
That seems like it might make our CI jobs take longer...

thanks
-- PMM

