Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10893CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 20:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPnte-0000wa-3U; Wed, 20 May 2026 16:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wPntb-0000vj-OV
 for qemu-devel@nongnu.org; Wed, 20 May 2026 16:52:03 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wPntZ-0004F2-OQ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 16:52:03 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-67cd93d8affso6867049a12.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 13:52:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779310319; cv=none;
 d=google.com; s=arc-20240605;
 b=ZJis2J1HQ7j2Mnyktg4CMlynMq2OwC4VEQXqI5Bi3Zd2mQ13v6cV3VemWQ8Knsu2q5
 brnCtEkLyAw2Mtjt3C5Cu28CiF1LHZHZJ+XBuChWrCd3PyUdWI0OguzK0hjz3gBNjpgo
 Vhe4miT7a21f92pVnttp/98dtnKgUwg/vWbya6cpjSn3ywVWpT3d7XUAiOXdfztQ4kkm
 tyjYT7GLFuRW5oQ45GBw8+uv6TYyhfo9pIyr9amKANlHCeM1wKjrXD5nOmTor7UDZmfS
 nvUFjKXNJpHSqYW+0K7aGcHaomIWrQBEspdblW0OXfCU+DYbAs9EUaXU8t7gHGf1BMWS
 G4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L9e4lhOFQMiEvm2xzmmhkrZE9pPPr3Kg7fLvu9dwPds=;
 fh=rnLOuVZ13PZymAjPE6rmrIcvGtoFog51zAPZPt+8ds0=;
 b=CNMP/8flFMXStMiCX5L4hC4crkxWb4743br/LkLG2K62/cSy68GZnPxSqXEinW5wW3
 +KvkJj9Wlo2DUGPXFoYR4Y055CoASp4/M8fcds7TFG1LNG7gOJiLvUOTUryf8syY2NMp
 wuwuiHvvwBgGdFQBcZyh4IDsxN6IoQ4BeJ2/8fru1Sq1BFd9PQoifNq8CLcMDd+zeXXY
 ndzuAngb1Flecel8+YAySolda66yYDusmXHHlm8M+Ws1jkRJ6cQzRVKrh8pLB/AYi+LM
 j0j9J6rGi0yflqDDuKuXKy8jWgnL8U3cx1eWV0SRvWxKEu3GtgWSPKU5jEebaIqQNoqK
 1bDA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779310319; x=1779915119; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9e4lhOFQMiEvm2xzmmhkrZE9pPPr3Kg7fLvu9dwPds=;
 b=LaUNzYJIWD3Ns29BQyYkPKN2m+qsMUJVNCndpoLDH50lOlu/bZktcDfrj7pobJ/10z
 zeiEpDNlrSeEKfSySP4TMbpayXW1SUTGwdMSdXJW1c9sEXxTyMhfDy4FvrLHWXXYRgbb
 iGBz25SK+kIK8vJGbIk5ah7HIPIkO1lq3S3OWSm+uHh7ysab/h1VLqdveDdnDGCiVXRC
 p6uKR0n6aptkBS56O3IhD7yDhpMuib/PEG6PDZGSdr1vCINJ3XBp7liZRTnB+uWptZp3
 wCx6A8FJTnPnBCsA8UdhfHKCZGP8aKwJ3vHLyOTuKoRLRoa3wAYWuM9jYwPl71muiat8
 QPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779310319; x=1779915119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L9e4lhOFQMiEvm2xzmmhkrZE9pPPr3Kg7fLvu9dwPds=;
 b=QriqsLljJgQuZjMPLHWWY1mTYr9wXG7+yJgItL9gCvKr6URfVVcSFQjVXgY53Fjntu
 raF31Ycm/IHoAmSdyIS5kC1ufIeNFEv5D8wXBFmu3gesU3V6Mdd9cudBECAnfGspocQD
 gSQBiiOUCcO/M29dzxieLHKFnWUU88xgkzh0dlcEVCl8SdavkB9VFP2TQxSHqRUpOzUi
 SdOFjGTWhVD1vOr2YE4ufu2nKRyE2QLF1ugWmLif17R1UFBh6rfN8eeQev0WW0/adjSd
 X2uOaX//EEFmlITIdzyIuOZOM89dI2/x67cS+THpq2/emc/V66yZx4xB7mz9xO/PtzP2
 2A3Q==
X-Gm-Message-State: AOJu0Ywdl96238UCeiuRzt9yfhCQGmAFw9I3pyCbLQJOswfFOFI91jXe
 7KYMFll7aQQKAv1L1Hqb9nD7Eeb4+W8aJsg6X5LHlp5pIdBTnIWpU11wftpTfODhh7um+iljwfT
 Cb0SilJ3dcP7IyMO+jLS4tUxWtF8KiCg=
X-Gm-Gg: Acq92OEO/QK6OS8FtEeBDyci0b22w5AR43fzIvWh9wY5n4jb6oztI5bWrC9yQmetGgd
 GLmnrDbxtFBElGDq3Mpp4ddqtQ7i2kMydbX+1rtOee5nSd+1AYiqNFLpxOwF12/tIP4hNX6YyKv
 F7cHK/hR6CxzcRcVTts1Kzmu7F4dIBUVHsX7TbO0NsBZUfWPm3SWSlwcllrdmVi3pcAlPAJuHd8
 xZziBycNkjQZEmA0RHZayG42rdaMkFEpu0TCnyOWGkeKO/zkKySDuPnJgoUJ3LT02iTexbHZmgN
 cMBThw4eMIZFebmTXFYbE+BcGo7pOsynACelJL9hfg==
X-Received: by 2002:aa7:d5d6:0:b0:67b:7a8f:3e2c with SMTP id
 4fb4d7f45d1cf-683bd38d8b7mr10075744a12.25.1779310319315; Wed, 20 May 2026
 13:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260520091351.1160442-1-berrange@redhat.com>
In-Reply-To: <20260520091351.1160442-1-berrange@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 20 May 2026 16:51:46 -0400
X-Gm-Features: AVHnY4IjUeR_r23YDEpwSviadOS6ayYjetBmM-zt5_gLCeFSLgwkoTvOt1i-AEk
Message-ID: <CAJSP0QWmfyiNYm0YXQysywq9Ry4Rt+xRCEC_d8PSJJxv9LPcug@mail.gmail.com>
Subject: Re: [PULL 00/29] Misc next patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Thanos Makatos <thanos.makatos@nutanix.com>, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 John Snow <jsnow@redhat.com>, John Levon <john.levon@nutanix.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, May 20, 2026 at 5:14=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> The following changes since commit e89049b3ba5f1f0468bc0d294173345597514a=
1b:
>
>   Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging =
(2026-05-19 15:23:10 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/berrange/qemu tags/misc-next-pull-request
>
> for you to fetch changes up to 5236113844128157c68ea9230cbb56f2ab485f31:
>
>   qom: drop user_creatable_add_type method (2026-05-20 10:12:38 +0100)
>
> ----------------------------------------------------------------
> Misc patches for iotests, qom, crypt & io
>
>  * Fix client side anoymous TLS credentials
>  * Fix return value semantics for qio_channel_flush
>  * Add ID validation of internal QOM constructor
>  * Fix ability to create internal QOM objects
>    without a parent
>  * Merge user creatable object constructor into
>    main QOM file
>  * Print reason for skipping I/O tests
>  * Remove redundant meson suits for I/O tests
>  * Add optional suites for many block drivers I/O tests
>  * Run I/O tests for 10 block drivers in GitLab CI

Hi Dan,
The following image format tests are failing:
https://gitlab.com/qemu-project/qemu/-/jobs/14470148602
https://gitlab.com/qemu-project/qemu/-/jobs/14470148603

Please resend either together with fixes or with changes to the test
set to keep the failing tests disabled for now.

Thanks,
Stefan

>  * Fix sudo check for LUKS I/O test
>  * Mark I/O test 185 as flaky
>  * Fix vfio-user iothread ID to be well-formed
>
> ----------------------------------------------------------------
>
> Daniel P. Berrang=C3=A9 (27):
>   crypto: fix client side anonymous TLS credentials
>   gitlab: ensure all meson jobs capture build/meson-logs by default
>   iotests: print reason when I/O test is skipped in TAP mode
>   iotests: remove redundant meson suite for iotests
>   iotests: ensure all qcow2 I/O tests are able to be run via make
>   scripts/mtest2make: ensure output has stable sorting
>   scripts/mtest2make: support optional tests grouping
>   iotests: add a meson suite / make target per block I/O tests format
>   docs/devel/testing: expand documentation for 'make check-block'
>   iotests: add nbd and luks to the I/O test suites
>   iotests: use 'driver' as collective term for either format or protocol
>   iotests: validate dmsetup result in test 128
>   iotests: fix check for sudo access in LUKS I/O test
>   iotests: mark 185 as a flaky test
>   gitlab: add jobs for thorough block tests
>   gitlab: remove I/O tests from build-tcg-disabled job
>   qom: add trace events for object/property lifecycle
>   hw/vfio-user: use a valid object ID for iothread
>   qom: validate ID format when creating objects
>   qom: make errp last param in methods taking va_list
>   qom: shorten name of object_set_properties_from_keyval
>   qom: have object_set_props_keyval return bool
>   qom: move object_set_prop_keyval into object.c
>   qom: add object_new_with_props_from_qdict
>   qom: fix ability to create objects without a parent
>   qom: allow object_new_with_prop* to trigger module loading
>   qom: drop user_creatable_add_type method
>
> John Snow (1):
>   python: bump qemu.qmp to v0.0.6
>
> Tejus GK (1):
>   io: invert the return semantics of qio_channel_flush
>
>  .gitlab-ci.d/buildtest-template.yml           |  30 ++-
>  .gitlab-ci.d/buildtest.yml                    |  27 +-
>  authz/listfile.c                              |   4 +-
>  crypto/tlscredsanon.c                         |   2 +
>  docs/devel/testing/main.rst                   |  26 +-
>  hw/vfio-user/proxy.c                          |   2 +-
>  include/io/channel-socket.h                   |   6 +-
>  include/io/channel.h                          |   4 +-
>  include/qom/object.h                          | 121 +++++++--
>  include/qom/object_interfaces.h               |  18 --
>  io/channel-socket.c                           |  16 +-
>  python/scripts/vendor.py                      |   4 +-
>  ...ny.whl =3D> qemu_qmp-0.0.6-py3-none-any.whl} | Bin 72263 -> 72379 byt=
es
>  pythondeps.toml                               |   2 +-
>  qom/object.c                                  | 230 ++++++++++++++++--
>  qom/object_interfaces.c                       | 101 +-------
>  qom/trace-events                              |  12 +-
>  scripts/mtest2make.py                         |  30 ++-
>  system/qdev-monitor.c                         |   4 +-
>  system/vl.c                                   |   7 +-
>  tests/Makefile.include                        |   3 +-
>  tests/qemu-iotests/128                        |   6 +
>  tests/qemu-iotests/149                        |  13 +-
>  tests/qemu-iotests/185                        |   1 +
>  tests/qemu-iotests/common.rc                  |  16 ++
>  tests/qemu-iotests/meson.build                |  65 ++++-
>  tests/qemu-iotests/testrunner.py              |   2 +-
>  tests/unit/check-qom-proplist.c               |  97 ++++++--
>  tests/unit/test-crypto-tlssession.c           | 120 ++++++++-
>  29 files changed, 713 insertions(+), 256 deletions(-)
>  rename python/wheels/{qemu_qmp-0.0.5-py3-none-any.whl =3D> qemu_qmp-0.0.=
6-py3-none-any.whl} (64%)
>
> --
> 2.54.0
>
>

