Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C44EB4908
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 11:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqUup-0001kC-JG; Thu, 12 Feb 2026 06:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqUul-0001eE-JZ
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 06:31:20 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vqUuj-0001fm-Lq
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 06:31:19 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-79495b1aaa7so78286677b3.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 03:31:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770895876; cv=none;
 d=google.com; s=arc-20240605;
 b=dckIOZXkdWLCVnkJO6ARrn2rxCSOCi01yE/ZhYkNNbZ82KQzojlpGhgWj1MhCoBacr
 UlibjlK/G1Q2VUSW4Yv35HylsVfDb9KQg/CL7L7CfR6LpX9TeP3jjS1rZZaLQ3CuzdMV
 wCRoHKCry+KHvgYBlswM/9xE3wQhrhotjdSQOscb6+URHdhSs56aADHobqq1mPKVibMw
 nw2osbWfvU4YYRQXAM00TUMd0YAZUhvfgij11mlZIaZ2NCN+grpn02Nkd39C0YZ7AbKu
 JGwpcdK9WARkyJybLzxDZRvYlQPj7QYhi9b//Gxco74DKZelHEBnokOqvb8B+EvgPH8A
 EpnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=B1Mra+MuQxRYB0BbkS7yEpmGMAsCsPYKDgnxtJPBXcA=;
 fh=M57BWUN8d8RwwqCbwCUjp8Yr9VFnneq2jWwg9rXn6ag=;
 b=IbOLSKkXXcy8coaQrtu9m+TPKmU5yeKyMFgjoj14a/e61mt15GkXbMRiII1Y1I7dmc
 hfVxBEsyulxmLq3AhFDI5mDUNQjm5TT9VNPCXEDOhMEr2VDtKduIN0LLllQGGim623+t
 EUfMcXNs7invKXGGtholT8VNZL8sw+OLxriSJuK/5afUexXgXpm4GiraHuIDc028T/xt
 I5oKG8TKaCL7Xpd84Li1mR7vD2dybr7FgsT0df+DAePYo/5mogIEEYbo6QnLg/tghKN3
 ylNYYExuKd++MACHEHgxNE+Tcd20z+wSs9PIwzPFpZ05W85ZH/mjilIYCxzvd4yBEhzX
 5aYw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770895876; x=1771500676; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1Mra+MuQxRYB0BbkS7yEpmGMAsCsPYKDgnxtJPBXcA=;
 b=iCgDwLRH8OBxkktHb/I904TMpyZxbqcBLR4qWH2WzKLiQ702ehZiCaiWrRob6skAnu
 l29g1mp8SPn24kdNFC6IXWzgDvThnsVIOacvCUHdoK9LaHeZh0jKFjaQypDqCvSguDaV
 9cmNonjH48Oen2sWEW7LO10ZTpsarhCKLzu+ANUBAl3fANF2gVynKHwwVMWs/kjlQF/1
 vjc898W8hXNOPKmM6XTuSSkNw/R0jtl9angGdn8clIuX1tOsLdS/6XOBSyLAChJNUgGb
 6cj2W9KqvD0jO7Vd9eMwx1xC6boM1YN/9dRK7GLdMZfPRgmFYH0Sko4CvwCaMZ1H3J2P
 NMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770895876; x=1771500676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B1Mra+MuQxRYB0BbkS7yEpmGMAsCsPYKDgnxtJPBXcA=;
 b=BEB6WekGaxui5jcMStf9pI4ACf/IKvVoLYnzJpp6srKLVllU4t86t7qvLCwf14R4s3
 K2sEsHIXzDkOn0L1xgP3SNebOVkNVZkEEFLLfBXB/ufU41esmngjB/9lTX6au7wCDoeB
 Jkbp24bAvhnytqWioJGBCOcXUeDeEn/lXgEDMJ9CqWCrmofUrXFZKMlVx5A1kJJvi6i7
 j/4fDi+jde7yiUkADF1l2O11W7WDyG9pWycX/aPU0sTrvI5YeQ4w8jBKpZM0N3ITzyId
 lJORYBlhC8nidxXxQ6wBmCDbFfRTq5KFyICH+2ZNZjs3Wu/wgtvUyZMSbPZ7UXyzvtud
 5rGQ==
X-Gm-Message-State: AOJu0Yy/JEfdeYbmfDhqutJN8Nvx8TgB+GZuv3oA1MOTG9ImKeGJRtrt
 AxYdai34Zc2BAqpa0WpCzADtgO1/i2Ok1Wc/4hGwroQ3t5m3oCldPJ6xzC/iSugQ6suC40MaBQB
 9sZPS3IsDkZSRlDSfcdbtPkdPSu/NegolBA4eNHm9vA==
X-Gm-Gg: AZuq6aKzkEeexpzvlp1IsRy79MgsFac+Z+CqUdszseYpWzZsglJk2jXnlbQA4ni4PJ/
 MfKuYLFlnd4lPJ8edXFOgfTf76CH+SRyzgnduqpg5630R12XB7ag3/RJ1d/kcBeZMUJfQ2yqOEQ
 RkT+tgmJ3OwI3r+w2TMc3guhsS/BbSzYWzoHPnAYDS08tNm3EeqDJpiHv+yK7pXKtKae1ulU0Wg
 m2T/ztJEHBqUpQbKi32uuA1+yLMn2dcmi7DJWmB1SQFt2iNHj7MvwAf9nYg5NZ1RavX1BzIdEDS
 lQMwsJGjEt2ptbTwwfPVedwNn0wrymAVPnu0WWImZcBRnSsQpicKr3VCN+CBy0jsb3s=
X-Received: by 2002:a05:690c:46c6:b0:796:5a14:87c1 with SMTP id
 00721157ae682-797376443b7mr23220977b3.44.1770895875852; Thu, 12 Feb 2026
 03:31:15 -0800 (PST)
MIME-Version: 1.0
References: <20260211195804.135144-1-jsnow@redhat.com>
In-Reply-To: <20260211195804.135144-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Feb 2026 11:31:04 +0000
X-Gm-Features: AZwV_QhbvqfHciMGacAoV_7LA3ALg6VL5SrodRmynmiCRaYQOC6pJCA1o-NI480
Message-ID: <CAFEAcA9Lv8hAoM=kcGAACkRRy3MLHWp9sLoZ1n7_dNngMa6cVg@mail.gmail.com>
Subject: Re: [PATCH 0/2] python: fix python-minreqs test failure et al
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 11 Feb 2026 at 19:59, John Snow <jsnow@redhat.com> wrote:
>
> GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2320293005
>
> The tox test is still broken because our use of avocado uses
> pkg_resources, it will have to be removed but in a separate
> series. Let's get the core tests green first and then worry about deeper
> surgeries later.
>
> John Snow (2):
>   python: fix minreqs test under newest pip/setuptools
>   python: drop uses of pkg_resources
>
>  python/Makefile          |  5 ++---
>  python/setup.py          |  4 ----
>  python/tests/minreqs.txt | 10 +++++-----
>  tests/Makefile.include   |  2 +-
>  4 files changed, 8 insertions(+), 13 deletions(-)

Applying this series locally fixes the "No module named 'pkg_resources'"
error, but instead I get:

lanath:noble:qemu$ make -C build/clang/ check-functional
make: Entering directory '/home/pm215/qemu/build/clang'
  VENVPIP install --no-build-isolation -e /home/pm215/qemu/python/
  error: subprocess-exited-with-error

  =C3=97 Preparing editable metadata (pyproject.toml) did not run successfu=
lly.
  =E2=94=82 exit code: 1
  =E2=95=B0=E2=94=80> [13 lines of output]
      running dist_info
      creating /tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info
      writing /tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info/PKG-INFO
      writing dependency_links to
/tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info/dependency_links.txt
      writing entry points to
/tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info/entry_points.txt
      writing requirements to
/tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info/requires.txt
      writing top-level names to
/tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info/top_level.txt
      writing manifest file
'/tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info/SOURCES.txt'
      reading manifest file
'/tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info/SOURCES.txt'
      reading manifest template 'MANIFEST.in'
      writing manifest file
'/tmp/pip-modern-metadata-bj38p2z_/qemu.egg-info/SOURCES.txt'
      creating '/tmp/pip-modern-metadata-bj38p2z_/qemu-0.6.1.0a1.dist-info'
      error: invalid command 'bdist_wheel'
      [end of output]

  note: This error originates from a subprocess, and is likely not a
problem with pip.
error: metadata-generation-failed

=C3=97 Encountered error while generating package metadata.
=E2=95=B0=E2=94=80> See above for output.

note: This is an issue with the package mentioned above, not pip.
hint: See above for details.
make: *** [/home/pm215/qemu/tests/Makefile.include:109:
/home/pm215/qemu/build/clang/pyvenv/tests.group] Error 1
make: Leaving directory '/home/pm215/qemu/build/clang'

Applying only patch 2 and not patch 1 avoids this and allows
check-functional to work.

thanks
-- PMM

