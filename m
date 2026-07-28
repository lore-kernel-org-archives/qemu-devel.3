Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DEFC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woiNQ-0002bl-Ns; Tue, 28 Jul 2026 10:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1woiN9-0002Zq-U6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:01:34 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1woiN8-0002XR-0O
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 10:01:31 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6983f20a8bfso6228531a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:01:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785247288; cv=none;
 d=google.com; s=arc-20260327;
 b=djnthI/aJPcBGSi42RuCqMacm/Yw2bzQzQ/LfDfR4abB19B6vYiJPmp90bHRcbnKlE
 RTpF3NV5PDxChoLjXqqDA1wTj6IT8JWKa1Rvi31wDpphFW7CGIUFAbLiUAMtnmH0RJQh
 PpIaEzr00oZ4vNj+cVxrPJR6yQC6IoLZ4TnJVUhWXF/gr5GEhjRlYiZS/cDy5F82AqKx
 pla6pQqCEqzo5t+0p/yspvv2Lv2kYS5pUMB1Lk0EpDkvpJuSWQUrPJ6F7luQYIN1eEXC
 MEEUVG62MlXtkQwn5YDQ7/5HBDgYIVIGLJ/09Q38FWs5TMfs8DZjqpQ1ll+fyD55FV1T
 NydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ysWkSe0Lwub/v7h7gyoYanFJSmhcsJE70pdRuA6RUdw=;
 fh=w0/ICDgHyPtBN0aaqM2e/e6O1U8ns+Kzw8RKbU8u91k=;
 b=fKUUpzJGYQ4rF+5WLT6nUFYEmKeNbswNbBgIAOIT9javS5ePYg7ae1sHWKOI/9cwOu
 BX8kxGup6pBQ4V9FiQaZH5QbwtOIbjN3ocBRxRkVwXVNJdYNwlI2OFJxEPOHsDX51UCC
 z7nHTaoJAYU2I0fB1awlSgymSsEV8FGJ6qPW9Jx7mPOx1I6aaWpZIU8Lv1FXCO7Y3Jp7
 14PF79kEz0YCiGKagXiFm7TFLSuwYqptN8Hjab/DDgDAMsoOeaxcjiHTge+OnHFoeAlc
 LMKbndg/uSq+ORMbhoqLTzwjWtmZwZfn6gI9y1rGAP+AfQu+2y7NFKc1jQy2hwVBHSiW
 YVQg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785247288; x=1785852088; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ysWkSe0Lwub/v7h7gyoYanFJSmhcsJE70pdRuA6RUdw=;
 b=mXtULFyKzhsB+V+YvrDqP7MGXJliYo+tMQ/lm6hr7t+OkL8yXqEdr0x77iF33HSeco
 GXFcgLNy2osTEdvmFidu/6xaWqIjZyJJX0ubyv+B0c6o/3fQ7kMwNxzyIIohk0RD7P+u
 qZqf/qrB16cqZ/pGy/vbPnjbK3GCYYyhWUY0FhUrAeixR+SSOGSbovDuU1YJvHty/dYE
 mZtXUexbtLuOMgM4rD400v5zKngYWd1U/8ZZVoZoWsyv7sp7yQfYxiLC1/snE1bDP1sc
 wU/LMQXcPlG9T8UgyTvnZTNd+DmJf4eaL2eM3y6ta2CeLy7VDKdSaQwzsBJz2KGgmBr+
 bzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785247288; x=1785852088;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ysWkSe0Lwub/v7h7gyoYanFJSmhcsJE70pdRuA6RUdw=;
 b=mh3sHDSymoNW1pTmN6J2BlDrPtVi4d1mrefHDaQbEev8KJTRtfaCUKw8MM5cXfUQgt
 lIh8VH+pgUhW/KMTpgFhmY0gr4925hc2Y9KzcSCpn2qaqk6ZbZ8gVqnYBc+HB2+MPbmw
 DoszNdQlPM5WXObXjT3SBB0hIOlEQfyXLIRLnSc2EuUTJRHjB6tn/BRUuIUhKLRg2unu
 dEmVNZ0RD0BRZtYGoDIWa54F44DGZCJGKvPjxyqzs4c8NP72Q0MQWsJg7fqbnCSrWlZ1
 gJlnUpgg6jF581TFxoZRlafL/tjQxdkyGeEMQ+Ehif0u9NtKKsArtG1Pt8CJpLad2MYc
 I+Xw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2Mw7Pr7JxoB+doRnLBuy70u3HWQStBUnbWIn+OshP1RspAp0T2mY+m0JurywISDWZrR6F/6JTx943@nongnu.org
X-Gm-Message-State: AOJu0YzhRM8m/OqdQ/mzlFd9gCFaJJSrHJzdCwLT2K2GYoqY9DfU/WUS
 I7U52P3TWGoXARLeWQOLUaosDAl/LawccZQ1uLJmgte9yPM9bfVPXQkNHAWFo0BoT1hdwYLEAgb
 iEy5LzZzEnpF6Nf8dgIA5/uUv+0z45+o=
X-Gm-Gg: AR+sD10vgJj0s51LWCTbiii7fdS9RC0b30bo21bYjSkIhWh1Akm/H3rNg9Ve8Na95Lu
 K7q+bBs7UQMJAO87xGc4d8TrL3A642106m29pkl/2GAXRlZCZE8G1C6AiK7VxGpbicMOXmvNdDB
 1xtEpuLADaDIpRNWnHNp325FESmCBHluFxQGWAWYC9ykxp28P5d7YVAPt7+5+9bVD3HgrrxCYSD
 LqRcanp6v+0jUI1zyUNqXzq7gRiC2hn10HgQ4xiRZr0HwzANoeazBnLr0hVoXPWegR/lvrGvtcn
 JU0+
X-Received: by 2002:a05:6402:52c2:b0:698:a9de:16e4 with SMTP id
 4fb4d7f45d1cf-6a034a5efd8mr1354158a12.20.1785247287933; Tue, 28 Jul 2026
 07:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260728104221.3981592-1-den@openvz.org>
In-Reply-To: <20260728104221.3981592-1-den@openvz.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 28 Jul 2026 10:01:15 -0400
X-Gm-Features: AUfX_mzCIIiaDMllt4c9IzPT8sk9ZoDZfgVhSXZTrNb3BmyAIklgJOcEy21ND90
Message-ID: <CAJSP0QWsKcV-o=pt9BSbF7pLhAOCZVV6_w_UsTF-Q5Gb_X9PUw@mail.gmail.com>
Subject: Re: [PULL 0/9] parallels: fix reachable assertion and related
 bounds-checking gaps
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x531.google.com
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

The qemu-iotests parallels-checks output has a mismatch:
https://gitlab.com/qemu-project/qemu/-/jobs/15576051278#L143

53/56 block-parallels-optional+block-thorough -
qemu:io-parallels-parallels-checks ERROR 9.82s exit status 1
>>> ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1 R=
UST_BACKTRACE=3D1 PYTHON=3D/builds/qemu-project/qemu/build/pyvenv/bin/pytho=
n3 MSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:pr=
int_stacktrace=3D1 MALLOC_PERTURB_=3D221 MESON_TEST_ITERATION=3D1 UBSAN_OPT=
IONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1:print_stacktr=
ace=3D1 LD_LIBRARY_PATH=3D/builds/qemu-project/qemu/build/subprojects/libvf=
io-user/lib /builds/qemu-project/qemu/build/pyvenv/bin/python3 /builds/qemu=
-project/qemu/build/../tests/qemu-iotests/check -tap -parallels parallels-c=
hecks --source-dir /builds/qemu-project/qemu/tests/qemu-iotests --build-dir=
 /builds/qemu-project/qemu/build/tests/qemu-iotests
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
--- /builds/qemu-project/qemu/tests/qemu-iotests/tests/parallels-checks.out
+++ /builds/qemu-project/qemu/build/scratch/parallels-file-parallels-checks=
/parallels-checks.out.bad
@@ -143,6 +143,8 @@
protocol type: file
file length: 2 GiB (2147483648 bytes)
disk size: 1 MiB
+ Format specific information:
+ extent size hint: 1048576
=3D=3D an unallocated cluster still reads as zeroes =3D=3D
read 1048576/1048576 bytes at offset 0
1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
(test program exited with status code 1)

On Tue, Jul 28, 2026 at 6:43=E2=80=AFAM Denis V. Lunev <den@openvz.org> wro=
te:
>
> The following changes since commit 6333226c2abb72f31648c251624c56e70993d6=
25:
>
>   Merge tag 'pull-9p-20260725' of https://github.com/cschoenebeck/qemu in=
to staging (2026-07-26 08:30:07 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/dlunev/qemu.git tags/pull-parallels-2026-07-22
>
> for you to fetch changes up to 2a1c31578eb96f829f3234fe9da1abecbb11aa1e:
>
>   MAINTAINERS: update parallels tree location (2026-07-27 14:42:24 +0200)
>
> ----------------------------------------------------------------
> Parallels block driver patches
>
> - fix a reachable assert()/process abort on a crafted image with an
>   inconsistent BAT vs. advertised disk size (GitLab #3804)
> - fix related integer overflows capping the format's usable catalog
>   size below its documented maximum
> - reject BAT entries pointing outside the data area in either
>   direction
> - harden the dirty-bitmap extension loader against a reachable
>   abort and an unsafe allocator
>
> This is my first pull request signed with this key:
>
>   RSA rsa4096/0BAEAA87D3020ADC1150E51F5E0771B6CB666CAB
>   Denis V. Lunev <den@openvz.org>
>
> Public key: https://keys.openpgp.org/vks/v1/by-fingerprint/0BAEAA87D3020A=
DC1150E51F5E0771B6CB666CAB
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Thomas Huth <thuth@redhat.com>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
>
> ----------------------------------------------------------------
> Denis V. Lunev (9):
>   parallels: fix integer overflow in header size calculation
>   parallels: read header/BAT table in bounded chunks
>   parallels: fix bat_entries overflow in image creation
>   parallels: reject BAT entries pointing outside backed storage
>   parallels: validate bitmap L1 table size before allocating it
>   parallels: skip loading a genuinely empty bitmap L1 table
>   parallels: avoid fatal abort on large bitmap L1 table
>   parallels: validate BAT capacity against advertised disk size
>   MAINTAINERS: update parallels tree location
>
>  MAINTAINERS                                   |   2 +-
>  block/parallels-ext.c                         |  52 +++++----
>  block/parallels.c                             |  74 ++++++++++---
>  tests/qemu-iotests/212                        |   8 +-
>  tests/qemu-iotests/212.out                    |  10 +-
>  tests/qemu-iotests/tests/parallels-checks     | 102 ++++++++++++++++++
>  tests/qemu-iotests/tests/parallels-checks.out |  59 ++++++++++
>  7 files changed, 270 insertions(+), 37 deletions(-)
>
> --
> 2.53.0
>
>

