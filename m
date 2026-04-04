Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5157E63FF4
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 19:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w96He-0007gb-4q; Sat, 04 Apr 2026 15:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w96Hb-0007aC-HX
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 15:03:47 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w96HY-0007Uc-L2
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 15:03:46 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b9bfcbaa81eso420834166b.1
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2026 12:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775329419; x=1775934219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oA5HpTScKbIUu+VnBKu148a9NooMUH5tp9SYtfDYkuc=;
 b=rtaeLU7fm5HMxrkL2/r+HCN15C6SpFpEvwLKFrCDQ5R8f8Xz11CRySWP5TZDWNC2a8
 Dj5my+OznwnLim8X2cFKrf1i5MWv4QYlvmYsQVAxHPuZEc7rOwmQnJF3HD9GomQhR1Fh
 tRctIbranEUJ9NHuAx45lcJwuDRd8L/fKIi4WWVArN7fPPt9I+7dKzUr7jwYaqv/tH5Y
 S7mbNVpZxUSUbQASQhH1R6QenpVZxPh77ZXKWEioE2k6Y6L3eVioAvSSiKD639wW6KBI
 wkzqt+gZdbtX2HdgGniG1l5IfRMMH6E5wLEKQrNQw7U6brkG8rF3KNeWHvu7IqKO9Gtu
 03Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775329419; x=1775934219;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oA5HpTScKbIUu+VnBKu148a9NooMUH5tp9SYtfDYkuc=;
 b=JamTvwM64GQ6hcEUaayShLtzIzJVGnfrbBstKip6Ygs+qLWWAQvgd/sXeQu/xG6ZpX
 prqPP/SePHjbnak14mUIjyWcWhtrY6VvuudJ7nkuVzRsyP7fSq3mmeMpouzHRGhUNFer
 pr6Y3MXbb2dYHo2vr2SXwt007e9mZsbs4Iorlv1vEB/Ii82vhZPjo0rKRVannXabDnx0
 laXCIyok+O389K3z/SrsPe4oFxYrSPC/S2NW0cxiZdfL2gOdOGKrmA37t4DMLBD565Zr
 1+Ae39kmKx/ceaUxbc7NhivHClH/TNduhDFjDdiiESaDs7pXnaT4URZEu0mqjrLFQkv/
 RKYg==
X-Gm-Message-State: AOJu0Yz7MKeh92BIcDPB+PFagFTyw5UFBtazrfquJQVQnIeeSJqa5zok
 XFbD6OHqBKCgR/NY0bCxDfPFCJOv5D+AbOXtH5dzqRW7CJRP5Tzfsu0KsTS6hgeOdEA=
X-Gm-Gg: AeBDieshmSdhv+E6me0bt/+Az1VwtdWhSLEv19S3Hw6HuPGA09M9ChDrLss0ABZ9gw1
 j0mHks2yKkAd90oWa9zIuOpXwWchEV2mun25P5vxqWL8/uchghAAfB9JsSrgomaEynmQvjCRPXu
 joTcW6u+AKTDSBhpdH/uVsYP6BANTL+Xs+rD9GNn6a2RiOai5nSZzn6RPnPRKQZ9SNQ13SKCPMg
 8TyQfNLAZK/wo01Sjv5JlAfh4GBbKvO8eTG7aNnwcOGf9yOr18VR5pH5yU1uKE7DqsZY6iG7+W0
 OLI8evYOy/qlx6D55+Z9+Bh7LlKKcBp2dM0VKFt17E3ank3KVaawLrhW1dMqDgI6UjstyO7IJyT
 ThErZWFql2vn9Or3MbKDiYiqm4NIW3yw1/Cwh+r++Klkz+u8t7dz9Ng/x78poVU0P5lYpfrfoxx
 ctaU83VQorfKLWbAueaG4VVE8bNtcA5+K0Zw==
X-Received: by 2002:a17:907:c994:b0:b9c:4a6c:7dc7 with SMTP id
 a640c23a62f3a-b9c674473a4mr223681166b.6.1775329419215; 
 Sat, 04 Apr 2026 12:03:39 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3c97229esm319832766b.4.2026.04.04.12.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 12:03:38 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 981E15F82F;
 Sat, 04 Apr 2026 20:03:37 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  Helge Deller <deller@kernel.org>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH for-11.0 0/6] allow building tools and qemu-guest-agent
 on 32bit hosts
In-Reply-To: <20260403104327.1163942-1-mjt@tls.msk.ru> (Michael Tokarev's
 message of "Fri, 3 Apr 2026 13:43:20 +0300")
References: <20260403104327.1163942-1-mjt@tls.msk.ru>
User-Agent: mu4e 1.14.0; emacs 30.1
Date: Sat, 04 Apr 2026 20:03:37 +0100
Message-ID: <878qb27dkm.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> This is a patchset which makes qemu-guest-agent, qemu-img & qemu-nbd
> buildable on 32bit hosts again.  The patches are simple enough to be
> picked up for 11.0.  The one from Helge is marked as RFC still, but
> I'd love for it to be accepted the way it is.
>
> All patches has been on qemu-devel previously, I just collected them
> into a single batch.

How are you configuring the 32bit build. I'm trying:

  '../../configure' '--disable-docs' '--disable-system' '--disable-user' '-=
-cross-prefix=3Di686-linux-gnu-'

but failing with:

  Command line: `i686-linux-gnu-gcc -m64 -I/usr/include/glib-2.0 -I/usr/lib=
/i386-linux-gnu/glib-2.0/include -I/usr/include/sysprof-6 /home/alex/lsrc/q=
emu.git/builds/testing/meson-private/tmpp4ra9pn_/testfile.c -o /home/alex/l=
src/qemu.git/builds/testing/meson-private/tmpp4ra9pn_/output.obj -c -pthrea=
d -D_FILE_OFFSET_BITS=3D64 -O0 -std=3Dgnu11` -> 1
  stderr:
  /home/alex/lsrc/qemu.git/builds/testing/meson-private/tmpp4ra9pn_/testfil=
e.c: In function 'main':
  /home/alex/lsrc/qemu.git/builds/testing/meson-private/tmpp4ra9pn_/testfil=
e.c:6:16: error: size of array 'qemu_build_bug_on' is negative
      6 |   typedef char qemu_build_bug_on[(x)?-1:1] __attribute__((unused)=
);
        |                ^~~~~~~~~~~~~~~~~
  /home/alex/lsrc/qemu.git/builds/testing/meson-private/tmpp4ra9pn_/testfil=
e.c:9:6: note: in expansion of macro 'QEMU_BUILD_BUG_ON'
      9 |      QEMU_BUILD_BUG_ON(sizeof(size_t) !=3D GLIB_SIZEOF_SIZE_T);
        |      ^~~~~~~~~~~~~~~~~
  -----------

  ../../meson.build:1072:2: ERROR: Problem encountered: sizeof(size_t) does=
n't match GLIB_SIZEOF_SIZE_T.
          You probably need to set PKG_CONFIG_LIBDIR" to point
          to the right pkg-config files for your build target.

I've pointed PKG_CONFIG_LIBDIR at the right place I think:

  =E2=9E=9C  echo $PKG_CONFIG_LIBDIR
  /usr/lib/i386-linux-gnu/pkgconfig
  =F0=9F=95=9920:02:58 alex@draig:qemu.git/builds/testing  on =EE=82=A0 202=
60403_mjt_tls_msk_ru [$?]=20
  =E2=9E=9C  pkg-config --path glib-2.0
  /usr/lib/i386-linux-gnu/pkgconfig//glib-2.0.pc

But obviously I must be holding it wrong.

>
> Helge Deller (1):
>   RFC: Allow building qemu tools on 32-bit hosts
>
> Michael Tokarev (1):
>   util/meson.build: do not add cpuinfo-$arch to util_ss for 32bit CPUs
>
> Philippe Mathieu-Daud=C3=A9 (4):
>   hw/core: Move compat_props_add() to 'hw/core/boards.h'
>   qom: Declare GlobalProperty structure in 'qom/compat-properties.h'
>   qom: Declare compat properties API in 'qom/compat-properties.h'
>   qom: Restrict compat properties API to system emulation
>
>  accel/accel-system.c              |   1 +
>  backends/hostmem.c                |   1 +
>  hw/core/machine.c                 |   1 +
>  hw/core/qdev-properties.c         |   1 +
>  hw/core/qdev.c                    |   1 +
>  hw/i386/pc_q35.c                  |   1 +
>  include/hw/core/boards.h          |  11 +++
>  include/hw/core/qdev-properties.h |   1 +
>  include/hw/core/qdev.h            |  27 -------
>  include/qemu/atomic.h             |  16 -----
>  include/qom/compat-properties.h   |  40 +++++++++++
>  include/qom/object.h              |   8 ---
>  meson.build                       |   4 +-
>  qom/compat-properties.c           | 116 ++++++++++++++++++++++++++++++
>  qom/meson.build                   |   3 +
>  qom/object.c                      | 102 +-------------------------
>  system/rtc.c                      |   1 +
>  system/vl.c                       |   1 +
>  target/i386/sev.c                 |   1 +
>  ui/vdagent.c                      |   1 +
>  util/meson.build                  |   6 +-
>  21 files changed, 187 insertions(+), 157 deletions(-)
>  create mode 100644 include/qom/compat-properties.h
>  create mode 100644 qom/compat-properties.c

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

