Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C356ECC6B2F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHHDr-00072x-Sk; Thu, 15 Oct 2026 04:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHHDn-00072O-Ny
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:53:58 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xHHDl-0001bH-Hh
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 04:53:55 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-5e67a6b3633so1641223e0c.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 01:53:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792054432; cv=none;
 d=google.com; s=arc-20260327;
 b=LxOwDejRnH6fLE3ets0TWafyItbL9/qv27Jko6DwDPtwp8h375TGdXkwNqksLKrSmb
 5OwXziDjgn/fG7RBW7SpwzM6WBevzUjE8aNyY97dT9CUdyCmm4DIzCnb4ftFsHNobU+F
 f5ULiPJZdhnqy34Y+c1DGC9r70yDI+Ag2CSKIX/vjeqmX7m2FhP9mKQYr6WsZoCp+dO5
 TYxfslSz5gMRLZ1ZkW0HaXaGUpvWMGRW2kvHKQCjl1HW3uFbhi+itMSpPHBIfDiM7Sey
 9qwJDGGI93uj/rthXfFELCAlGS5I48isNBHJ5RF+6XyJCWlOj/48Lxt6T5csGo+X7lnj
 SkUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=406KMQUigGvRzu1AjwiH74SUO+NrwwoF8P0vdLfz574=;
 fh=nItVmCbPK/VeZBB7/phH50yao0SMe4YmlQY964pLCOQ=;
 b=WMyW61+UGKGuvV+4WJJSorZZydrJCTxmAXLSJcL6HY6BqfWuIAhlah8yTgLAkXUHIp
 Ymg2xMfLQyNWtvmy9MFCiQ36BdYTYOCq93prArxWc4CjJ/FLQuzHpqJ0oo29kEvnPsn4
 1XiYUOxE7y6DQiOU37VRolfdnuy86iVzqQSTig2CcPEAW7t+9HqVuQqoFZZF6F5lPmXb
 vRJWtM8PwwXyGKF+yxZTzf2XgWwm/fzvJgW3ayEpD6kF0S5b4VlS12v0N95PthfRwK5r
 CLAscSl84XI1lXAF9bXQz5laNYeZwtCf03CF34X8vpQEfUerdGfAvyog757VUc1zviO1
 LlBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792054432; x=1792659232; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=406KMQUigGvRzu1AjwiH74SUO+NrwwoF8P0vdLfz574=;
 b=IVYMNjkJPnV9xgsPO7HmqxiaYtCws2F4qiqD9lZQKl2Ho1HrrW3Hcbtd8e9W50aHFc
 SpkXS4q9nrFvqwn8Bdsy3rU4V6bQAZUHuKs97tH0UyCCRXKXGp1lgb/Bxd0ZSN4UaNa9
 Lmtzfp7miublCmQswv2Sr5qXVK8ok8yscZgj2aBhb+XPtVAOMol7wdrMRPX9Y9Q5nuZl
 fGwFZWf4ytQZo/vxs+pZ1ridfGr4zXFiegtbnkQcJLqdsEBHp+gMeU8ObU/nqkz7ZvAJ
 d6k/dWgO96wuoElAneEzGZWLanbVc/MwpZJZMcnUKcWxfk+MEMmjI6ZVspEo2PhUokr3
 cuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054432; x=1792659232;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=406KMQUigGvRzu1AjwiH74SUO+NrwwoF8P0vdLfz574=;
 b=FDGhj/mDgE+9Uu/jmhDDr2qXKISh2+r4tnucha+121EeuAfYNl6E2H7SF/65fYywG8
 cZAwM1yGnO57u+MeJ8o4Xh4eMwk3VpSSrjVhs5haSpRB3n/2qW+sYou5cCqhn3VsiKGu
 li8hLlYBj4LKi8rNeZXvI6jLp/mgyMdnkJ1NRuxT5/Z2DDlSNSrwSuhNZ7DJk02wNz1J
 eVKwNOb5wO/bs2mXRWVBo9OlFIcYQwAd0SSOWSAdAZ+wgCQv0AG0xHTIBYVtaObX2N+3
 e69EeNnGMcyiCvfyU6y/qUEVOidIf00G2Vd2QWBpx62EZUz028Rt5ea/B0hgAAixgmub
 Djuw==
X-Gm-Message-State: AFq9FYLoVY/4FsOK5wBOCnUtAF8EC54ITLrK1qMUhnSlRSJVKIuXQmgF
 LNHxQHQKBpN+cu0xDeT1teTKJhVyKWNo2gYk48oMwuGR7r4VZK2K6D2RporxmB+Qrj8ddOmHRhJ
 ArGfFxXvhklNW9uuIvGZOOd9auwH7QDzDG4equTXr2A==
X-Gm-Gg: AYBFou0BNAPmvUvTjGq73slXUrqs+L4ApxyxxeWzI4juAsDHvwWVYW0l4KNVoCEnXYM
 r+6bw4NjKt/zpgA4EhJrHe1ZAIDCFfgdDiSo6gjNvY18iDXnlEwt7RM34/F1H+cUxI056rASjIv
 ABevfKvr4m28P7o+7bh9Gsf5nC3kCGZ5MZXIq1wKQ+02mHCvEXxxoiRLaDugER8YdC7WKmtcig4
 6/qFKrx34fNiYGNC9JewdmLVOSNfxWwwVRe9Ox885qQCJrnfr3f8tti9JfuQWAh4CRig16QBvUh
 ZWek4dBbS0IfLYLh/fjnXpkYS5nXsNoQc/zDJlA21k8T84EbRwJcByk=
X-Received: by 2002:a05:6122:3d0a:b0:5c9:a60b:e5c9 with SMTP id
 71dfb90a1353d-5e91f4abfe2mr5939205e0c.12.1792054431793; Thu, 15 Oct 2026
 01:53:51 -0700 (PDT)
MIME-Version: 1.0
References: <20261014184309.664714-17-eblake@redhat.com>
In-Reply-To: <20261014184309.664714-17-eblake@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 15 Oct 2026 10:53:39 +0200
X-Gm-Features: AclHuK8QVzOez0b8t9kpkpKXTNthy7OurY5uN4JzHNfS1iPFYqLlaO2wuARG-vg
Message-ID: <CAFXwXrnm0aNhfwfMXLe6DnM31Z7MKX7h=6UiVNusyVkZC8nGDw@mail.gmail.com>
Subject: Re: [PULL v3 00/15] NBD patches through 2026-10-08
To: Eric Blake <eblake@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000d35bbe065ddd2fd1"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-vk1-xa2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000d35bbe065ddd2fd1
Content-Type: text/plain; charset="UTF-8"

https://gitlab.com/qemu-project/qemu/-/pipelines/2949515618

Still 8 job failures, and this time they're clearly nbd related. Did you
not see these when testing yourself? Or is it a quirk of our k8s ci setup
for merge testing?

r~

On Wed, 14 Oct 2026, 20:43 Eric Blake, <eblake@redhat.com> wrote:

> The following changes since commit
> 8ee6c77176cfee03be0ec7665b6652b2f31f1531:
>
>   Merge tag 'pull-ufs-20261012' of https://gitlab.com/jeuk20.kim/qemu
> into staging (2026-10-13 22:01:07 +0200)
>
> are available in the Git repository at:
>
>   https://gitlab.com/ebblake/qemu.git tags/pull-nbd-2026-10-08-v3
>
> for you to fetch changes up to 9c4c3cb45b321b6365a1b03df14ca7449523aac0:
>
>   iotests/iothreads-nbd-export: Skip on s390 (2026-10-14 13:07:56 -0500)
>
> [v3: sending only the updated cover letter and patch 11/15]
>
> ----------------------------------------------------------------
> NBD patches through 2026-10-08
>
> Several fixes, including:
> - Eric Blake: Update MAINTAINERS, support qemu-nbd -s -l
> - Fiona Ebner: Report flush error on qemu-img convert
> - Guillaume Vinke: Fix NBD client on dead connection
> - Denis V. Lunev: Fix postcopy dirty bitmap migration
> - Eric Farman: Several iotest improvements
>
> ----------------------------------------------------------------
> Denis V. Lunev (3):
>       migration: add QEMU_COUNTED_STRING_SIZE for counted string buffers
>       migration/block-dirty-bitmap: fix postcopy abort with bitmaps on
> several nodes
>       iotests/migrate-bitmaps-postcopy-test: add a bitmap on a second node
>
> Eric Blake (2):
>       maint: Update eblake's staging repo
>       qemu-nbd: Support -s and -l at the same time
>
> Eric Farman (4):
>       iotests/nbd-in-qcow2-chain: use default machine
>       iotests/nbd-tls-iothread: skip on non-x86 hardware
>       iotests/fuse-truncate: skip if FUSE is not usable
>       iotests/iothreads-nbd-export: Skip on s390
>
> Fiona Ebner (4):
>       iotests: add test cases for failing flush after qemu-img convert
>       iotests.py: add filter_qemu()
>       block: report flush error during bdrv_close()
>       qemu-img: convert: flush target image after copying
>
> Guillaume Vincke (2):
>       nbd/client-connection: Fix client returning a closed channel
>       iotests: Add coverage for NBD connect thread start delay
>
>  docs/tools/qemu-nbd.rst                            |  7 +-
>  include/migration/qemu-file-types.h                |  6 +-
>  block.c                                            | 13 +++-
>  migration/block-dirty-bitmap.c                     | 62 ++++++++++++++--
>  migration/qemu-file.c                              |  5 +-
>  nbd/client-connection.c                            | 32 +++++++++
>  qemu-img.c                                         |  8 ++-
>  qemu-nbd.c                                         | 22 +++++-
>  MAINTAINERS                                        |  4 +-
>  tests/qemu-iotests/026                             | 10 +--
>  tests/qemu-iotests/026.out                         | 84
> ++++++++++++++++++++++
>  tests/qemu-iotests/071                             |  2 +-
>  tests/qemu-iotests/071.out                         |  2 +
>  tests/qemu-iotests/080.out                         |  2 +
>  tests/qemu-iotests/098.out                         |  4 ++
>  tests/qemu-iotests/122                             | 33 +++++++++
>  tests/qemu-iotests/122.out                         | 17 +++++
>  tests/qemu-iotests/244                             |  2 +-
>  tests/qemu-iotests/244.out                         |  1 +
>  tests/qemu-iotests/iotests.py                      |  4 ++
>  tests/qemu-iotests/tests/file-io-error             |  2 +-
>  tests/qemu-iotests/tests/file-io-error.out         |  2 +
>  tests/qemu-iotests/tests/fuse-truncate             |  9 ++-
>  tests/qemu-iotests/tests/iothreads-nbd-export      |  5 ++
>  .../tests/migrate-bitmaps-postcopy-test            | 22 ++++++
>  tests/qemu-iotests/tests/nbd-in-qcow2-chain        |  2 +-
>  tests/qemu-iotests/tests/nbd-stale-connection      | 62 ++++++++++++++++
>  tests/qemu-iotests/tests/nbd-stale-connection.out  | 17 +++++
>  tests/qemu-iotests/tests/nbd-tls-iothread          |  4 ++
>  tests/qemu-iotests/tests/qemu-nbd-snapshots        | 81
> +++++++++++++++++++++
>  tests/qemu-iotests/tests/qemu-nbd-snapshots.out    | 39 ++++++++++
>  tests/qemu-iotests/tests/qsd-migrate               |  5 +-
>  tests/qemu-iotests/tests/qsd-migrate.out           |  1 +
>  33 files changed, 538 insertions(+), 33 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/nbd-stale-connection
>  create mode 100644 tests/qemu-iotests/tests/nbd-stale-connection.out
>  create mode 100755 tests/qemu-iotests/tests/qemu-nbd-snapshots
>  create mode 100644 tests/qemu-iotests/tests/qemu-nbd-snapshots.out
>
> --
> 2.56.0
>
>
>

--000000000000d35bbe065ddd2fd1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><a href=3D"https://gitlab.com/qemu-project/qemu/-/pi=
pelines/2949515618">https://gitlab.com/qemu-project/qemu/-/pipelines/294951=
5618</a></div><div dir=3D"auto"><br></div><div dir=3D"auto">Still 8 job fai=
lures, and this time they&#39;re clearly nbd related. Did you not see these=
 when testing yourself? Or is it a quirk of our k8s ci setup for merge test=
ing?</div><div><br></div><div data-smartmail=3D"gmail_signature">r~</div></=
div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Wed, 14 Oct 2026, 20:43 Eric Blake, &lt;<a href=3D"m=
ailto:eblake@redhat.com">eblake@redhat.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">The following changes since commit 8ee6c77176cfee03b=
e0ec7665b6652b2f31f1531:<br>
<br>
=C2=A0 Merge tag &#39;pull-ufs-20261012&#39; of <a href=3D"https://gitlab.c=
om/jeuk20.kim/qemu" rel=3D"noreferrer noreferrer" target=3D"_blank">https:/=
/gitlab.com/jeuk20.kim/qemu</a> into staging (2026-10-13 22:01:07 +0200)<br=
>
<br>
are available in the Git repository at:<br>
<br>
=C2=A0 <a href=3D"https://gitlab.com/ebblake/qemu.git" rel=3D"noreferrer no=
referrer" target=3D"_blank">https://gitlab.com/ebblake/qemu.git</a> tags/pu=
ll-nbd-2026-10-08-v3<br>
<br>
for you to fetch changes up to 9c4c3cb45b321b6365a1b03df14ca7449523aac0:<br=
>
<br>
=C2=A0 iotests/iothreads-nbd-export: Skip on s390 (2026-10-14 13:07:56 -050=
0)<br>
<br>
[v3: sending only the updated cover letter and patch 11/15]<br>
<br>
----------------------------------------------------------------<br>
NBD patches through 2026-10-08<br>
<br>
Several fixes, including:<br>
- Eric Blake: Update MAINTAINERS, support qemu-nbd -s -l<br>
- Fiona Ebner: Report flush error on qemu-img convert<br>
- Guillaume Vinke: Fix NBD client on dead connection<br>
- Denis V. Lunev: Fix postcopy dirty bitmap migration<br>
- Eric Farman: Several iotest improvements<br>
<br>
----------------------------------------------------------------<br>
Denis V. Lunev (3):<br>
=C2=A0 =C2=A0 =C2=A0 migration: add QEMU_COUNTED_STRING_SIZE for counted st=
ring buffers<br>
=C2=A0 =C2=A0 =C2=A0 migration/block-dirty-bitmap: fix postcopy abort with =
bitmaps on several nodes<br>
=C2=A0 =C2=A0 =C2=A0 iotests/migrate-bitmaps-postcopy-test: add a bitmap on=
 a second node<br>
<br>
Eric Blake (2):<br>
=C2=A0 =C2=A0 =C2=A0 maint: Update eblake&#39;s staging repo<br>
=C2=A0 =C2=A0 =C2=A0 qemu-nbd: Support -s and -l at the same time<br>
<br>
Eric Farman (4):<br>
=C2=A0 =C2=A0 =C2=A0 iotests/nbd-in-qcow2-chain: use default machine<br>
=C2=A0 =C2=A0 =C2=A0 iotests/nbd-tls-iothread: skip on non-x86 hardware<br>
=C2=A0 =C2=A0 =C2=A0 iotests/fuse-truncate: skip if FUSE is not usable<br>
=C2=A0 =C2=A0 =C2=A0 iotests/iothreads-nbd-export: Skip on s390<br>
<br>
Fiona Ebner (4):<br>
=C2=A0 =C2=A0 =C2=A0 iotests: add test cases for failing flush after qemu-i=
mg convert<br>
=C2=A0 =C2=A0 =C2=A0 iotests.py: add filter_qemu()<br>
=C2=A0 =C2=A0 =C2=A0 block: report flush error during bdrv_close()<br>
=C2=A0 =C2=A0 =C2=A0 qemu-img: convert: flush target image after copying<br=
>
<br>
Guillaume Vincke (2):<br>
=C2=A0 =C2=A0 =C2=A0 nbd/client-connection: Fix client returning a closed c=
hannel<br>
=C2=A0 =C2=A0 =C2=A0 iotests: Add coverage for NBD connect thread start del=
ay<br>
<br>
=C2=A0docs/tools/qemu-nbd.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7 +-<br>
=C2=A0include/migration/qemu-file-types.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +-<br>
=C2=A0block.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | 13 +++-<br>
=C2=A0migration/block-dirty-bitmap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 62 ++++++++++++++--<br>
=C2=A0migration/qemu-file.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +-<br>
=C2=A0nbd/client-connection.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 32 +++++++++<br>
=C2=A0qemu-img.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 8 ++-<br>
=C2=A0qemu-nbd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 22 +++++-<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 4 +-<br>
=C2=A0tests/qemu-iotests/026=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 +--<br>
=C2=A0tests/qemu-iotests/026.out=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 84 ++++++++++++++++++++++=
<br>
=C2=A0tests/qemu-iotests/071=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0tests/qemu-iotests/071.out=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +<br>
=C2=A0tests/qemu-iotests/080.out=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +<br>
=C2=A0tests/qemu-iotests/098.out=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ++<br>
=C2=A0tests/qemu-iotests/122=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 33 +++++++++<b=
r>
=C2=A0tests/qemu-iotests/122.out=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 17 +++++<br>
=C2=A0tests/qemu-iotests/244=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0tests/qemu-iotests/244.out=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0tests/qemu-iotests/iotests.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++<br>
=C2=A0tests/qemu-iotests/tests/file-io-error=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0tests/qemu-iotests/tests/file-io-error.out=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 2 +<br>
=C2=A0tests/qemu-iotests/tests/fuse-truncate=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 9 ++-<br>
=C2=A0tests/qemu-iotests/tests/iothreads-nbd-export=C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 5 ++<br>
=C2=A0.../tests/migrate-bitmaps-postcopy-test=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 22 ++++++<br>
=C2=A0tests/qemu-iotests/tests/nbd-in-qcow2-chain=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 2 +-<br>
=C2=A0tests/qemu-iotests/tests/nbd-stale-connection=C2=A0 =C2=A0 =C2=A0 | 6=
2 ++++++++++++++++<br>
=C2=A0tests/qemu-iotests/tests/nbd-stale-connection.out=C2=A0 | 17 +++++<br=
>
=C2=A0tests/qemu-iotests/tests/nbd-tls-iothread=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 4 ++<br>
=C2=A0tests/qemu-iotests/tests/qemu-nbd-snapshots=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 81 +++++++++++++++++++++<br>
=C2=A0tests/qemu-iotests/tests/qemu-nbd-snapshots.out=C2=A0 =C2=A0 | 39 +++=
+++++++<br>
=C2=A0tests/qemu-iotests/tests/qsd-migrate=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5 +-<br>
=C2=A0tests/qemu-iotests/tests/qsd-migrate.out=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A033 files changed, 538 insertions(+), 33 deletions(-)<br>
=C2=A0create mode 100755 tests/qemu-iotests/tests/nbd-stale-connection<br>
=C2=A0create mode 100644 tests/qemu-iotests/tests/nbd-stale-connection.out<=
br>
=C2=A0create mode 100755 tests/qemu-iotests/tests/qemu-nbd-snapshots<br>
=C2=A0create mode 100644 tests/qemu-iotests/tests/qemu-nbd-snapshots.out<br=
>
<br>
-- <br>
2.56.0<br>
<br>
<br>
</blockquote></div>

--000000000000d35bbe065ddd2fd1--

