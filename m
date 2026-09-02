Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C19BC624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1qp2-0008G0-L1; Wed, 02 Sep 2026 15:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1qp1-0008Fr-Cv
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1qoz-0005KR-EE
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788378032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GX4Q+J+nIkxmJqt4DTrqGayOVCpdKiSBRARpLVB6ZvE=;
 b=YPywtEBHCzYtdk7BUKFhK9402YDKlfYdnl9J2vsovXimfvYHGZKazn/atmNs0/G098rJ9w
 LI8yYRB22Xd1znIT82ZbUZqyBbiKvjmfoq6fc4oBoZVQ7EyChjLPfLjeeIK494+oSZC7oH
 Jk3bjDfFFbrqGW/gSGNbd29JHozvlLk=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-tIi56gB_NZWKZ0VHtEW_fg-1; Wed, 02 Sep 2026 15:40:30 -0400
X-MC-Unique: tIi56gB_NZWKZ0VHtEW_fg-1
X-Mimecast-MFC-AGG-ID: tIi56gB_NZWKZ0VHtEW_fg_1788378030
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-66f78d2f2a0so2020127d50.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 12:40:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788378030; cv=none;
 d=google.com; s=arc-20260327;
 b=j9xdlLAva0k61rzDqLVDLROlsZghz56uGO/hP6tdkMEOwBdRgTB0w8gIvVZHV/dINt
 0kMDgSJfcVRVjcSnFWeQKArq3QEWWe6udsdVUeX9QHWyAjXEWUNpDNmXRKRmEEYbJetB
 dMiHeICQvrGvW50xk9ZrfjxgAuk53Bf299Cooy2QpDJQ6cVR9fiiqp+ZBwSCNxtZ6wAJ
 S0hUwCGb2HB+J9gelMYsGoXCy0R2GklfrzqWjbRj+m70rjwIlkrtRd1OpgEbGjrNUyE6
 B9RAmtysaqXnVJf3gi7bHakp2YE9NUYXskn3TkuJwg9RsR145BjOUbx8MAhMyunWFbLw
 mU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GX4Q+J+nIkxmJqt4DTrqGayOVCpdKiSBRARpLVB6ZvE=;
 fh=M1WUnf/R1h1ALMBasio9lTNUN2+DVNiwkacyuf7tUOI=;
 b=nGudBBSNeuZ0wqQglFQcYl8U7DTLAkjCY7PSmudNlJZYLxypBVNVIDKJuG6y2wIkzf
 Ps10Q+EwEBEEHxyDCrIjlGu1/X7CrgOgchAXEzs7LyfJ/FP7ETqTOq17Vz1+h2fqPnly
 UBEQSSIRs/XPvVH5CfjlKPAyHclTBi7X9IPOKmrCd53Grhy6FJbu04ZtM0az/M/gVnzn
 9GCVG8Thd6NGd+ovpB0Fmv+29Xbeuo1vxwn7+qND9Y2lC7oQki0xWswdVphckw18Zz/l
 Eipmz6aDQIfz4zjyiyG106emnyeT2E8vHXSTBM1YgO9slMeyuJ+Sj/RD4xHDjRxTdcet
 Jb5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788378030; x=1788982830; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GX4Q+J+nIkxmJqt4DTrqGayOVCpdKiSBRARpLVB6ZvE=;
 b=f+YdJRpQwA1UPNMFZQdAm1meI12RNBBoumXy/5BXuDScvzr3BA25j9BJ08haE8As1V
 t64j5MbBbng3AmoM3cb4t3tAT93WYxm2xgPipwZ3h8lGA/bLTPIAvTZS8PVibctH7Clz
 p5GGzAZgyQYIDpCLJ3+R16TD7ooNLWI1qHyPI+wEZ/xM86YvMTo8cr+L98WtCvMaosde
 sz7o/wTwtl+0hAvsNZsCKJhYBcgRGvTcZjbPACe4aWJ1ibdLbeaSDdJ8HFyrz671XYu3
 QNoSj+FtReam3+aG2uApGZTttB/glF8O1/9fMCbYCYgBxJowG5hGSO58Zm3Y4F3fSzQv
 eV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788378030; x=1788982830;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GX4Q+J+nIkxmJqt4DTrqGayOVCpdKiSBRARpLVB6ZvE=;
 b=oNXjSFai1sxHvxw854pMNBztq7GRqFS9woQv0cKoXhcPUoXCtI4bn9jpOhpiVJpijZ
 bTQYXrh+1kcn8QI9P378OHO05aTdA/RI/i8uA4b+z89Rfstv4RkO8hrvOg8tIbURJdKK
 q9jxyjegQ7/hSc9E2JJiYBW9pV6ezTPerDo6by6JC26cjIg3CMyDeO/XOSAL1EPAoDkx
 Vet3GQsE3rkxVWAGOck+5OmCiddwNr4mKjcvsAd3MMdnzyOD2uNq4X1wdnAZslRenSrW
 kHKzoIcBbcMCIx96clUA4W2bqfnu4CkubsJ3XCrZgbohoeAuOkXn7kT6sLseQ6/NwSkU
 ZDRA==
X-Gm-Message-State: AFuF++k3Uij1hFEFx8gGw/OkHwRNJ1VyPDEsnNxcDXrQ8w4DqqEZL4kT
 1e8wxe311Na3PChz7mJ111Zh3P+YDK2Q0pK4nfMOIkfBoCIt7z6zBRbGo8eiLmw4Tp5copJw+ft
 +6nCUc0bKcS8zYeKiE0Eny94mhb+BiMPWmeZk241uB4G8VigS3YhmYb/cISlkLa7DUeamMuldZN
 Y2rNmiGtFN6le1/HGs9a7KwTOMnUX5UtshWA7d50QMKQ==
X-Gm-Gg: AYBFou2aJiaV6KT/Z+S7CMC11JjIkakzjakaBtdIFV4fy8mFOCpFXGAZqS/Vu5CqLnd
 +73euWZM4qGmOHHrraItCR8tNiPGKIqkKZxhjEd/FVKz2vlqfzolGPsKC1bzC7y/lS/0gwvrYTc
 ACdDUjG2aBB4Zpreogxz9fFgfYjuM+/RNwPjwmxvoDsNVrRb4T9e8AF/ElrI9c3+NnuSC4XKL2V
 KzW8LqeetuLUI+9
X-Received: by 2002:a53:d848:0:b0:66b:163f:57c3 with SMTP id
 956f58d0204a3-66f9be774c1mr1916544d50.42.1788378029878; 
 Wed, 02 Sep 2026 12:40:29 -0700 (PDT)
X-Received: by 2002:a53:d848:0:b0:66b:163f:57c3 with SMTP id
 956f58d0204a3-66f9be774c1mr1916529d50.42.1788378029456; Wed, 02 Sep 2026
 12:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260902193551.582660-1-jsnow@redhat.com>
In-Reply-To: <20260902193551.582660-1-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 2 Sep 2026 15:40:17 -0400
X-Gm-Features: AcwNN1XWko9urs_UOr-oRM6EnzbYuyIn9TZ806y8xoWPxn7Ot0JBpe-oslB24QY
Message-ID: <CAFn=p-ZH7=1_JVudAyY_ZfcSyYGS9KTw1Qb8dgogA3zfUSigtQ@mail.gmail.com>
Subject: Re: [PULL 00/16] Python patches
To: qemu-devel@nongnu.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org, 
 Cleber Rosa <crosa@redhat.com>, Kyle Evans <kevans@freebsd.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Maksim Davydov <davydov-max@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Ed Maste <emaste@freebsd.org>, Kohei Tokunaga <ktokunaga.mail@gmail.com>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Hanna Reitz <hreitz@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Yonggang Luo <luoyonggang@gmail.com>, 
 Warner Losh <imp@bsdimp.com>, Reinoud Zandijk <reinoud@netbsd.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, 
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Sep 2, 2026 at 3:36=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit a925240509d1b4b656cc480f1cc79ba4d7c8bc=
08:
>
>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into=
 staging (2026-09-02 13:40:43 +0100)
>
> are available in the Git repository at:
>
>   git@gitlab.com:jsnow/qemu.git tags/python-pull-request

*cough*, I broke something in my config when switching to non-https
auth, sorry...

https://gitlab.com/jsnow/qemu.git

Let me know if I need to re-send to appease the automated tooling.

Also note that my GPG key has been extended for another two years and
re-signed, you will have to fetch it again to verify the signature on
this PR.

>
> for you to fetch changes up to 4061c0e95c6e2736926ab8723606cddf582f58e6:
>
>   sphinx: drop qapidoc back-compat overboiled spaghetti dinner (2026-09-0=
2 15:02:58 -0400)
>
> ----------------------------------------------------------------
> python
>
> upgrade to py312
>
> ----------------------------------------------------------------
>
> John Snow (16):
>   tests: update vm tests to prefer locally-built QEMU
>   tests: update libvirt-ci, lcitool
>   tests: update netbsd dependencies
>   tests: drop python3-devel mapping
>   tests: re-add opencv2 and numpy dependencies
>   tests: add Python3.12 to centos9.docker
>   tests: update emsdk-wasm64-cross
>   qapi: update type hint for objects_seen
>   python: upgrade to Python3.12+
>   python: fix license configuration
>   python: allow mypy to run as the current python version
>   python: remove distutils workarounds
>   python: remove stale setup.cfg options
>   sphinx: require sphinx 7.2.6
>   sphinx: drop fakedbusdoc
>   sphinx: drop qapidoc back-compat overboiled spaghetti dinner
>
>  docs/conf.py                                  |  11 +-
>  docs/interop/dbus-display.rst                 |  14 +-
>  docs/interop/dbus-vmstate.rst                 |  14 +-
>  docs/interop/dbus-vnc.rst                     |  14 +-
>  docs/requirements.txt                         |   2 +-
>  docs/sphinx/compat.py                         | 230 ------------------
>  docs/sphinx/fakedbusdoc.py                    |  30 ---
>  docs/sphinx/qapi_domain.py                    |  53 ++--
>  configure                                     |  11 +-
>  tests/docker/dockerfiles/alpine.docker        |   1 +
>  tests/docker/dockerfiles/centos9.docker       |  14 +-
>  .../dockerfiles/debian-amd64-cross.docker     |   4 +-
>  .../dockerfiles/debian-arm64-cross.docker     |   4 +-
>  .../dockerfiles/debian-armhf-cross.docker     |   4 +-
>  .../dockerfiles/debian-i686-cross.docker      |   4 +-
>  .../dockerfiles/debian-ppc64el-cross.docker   |   4 +-
>  .../dockerfiles/debian-riscv64-cross.docker   |   4 +-
>  .../dockerfiles/debian-s390x-cross.docker     |   4 +-
>  tests/docker/dockerfiles/debian.docker        |   4 +-
>  .../dockerfiles/emsdk-wasm64-cross.docker     |   4 +-
>  .../dockerfiles/fedora-rust-nightly.docker    |   2 +
>  .../dockerfiles/fedora-win64-cross.docker     |   2 +
>  tests/docker/dockerfiles/fedora.docker        |   2 +
>  tests/docker/dockerfiles/opensuse-leap.docker |   4 +-
>  tests/docker/dockerfiles/ubuntu2404.docker    |   4 +-
>  .gitlab-ci.d/macos-14.vars                    |   2 +-
>  python/Makefile                               |  10 +-
>  python/scripts/mkvenv.py                      |  63 +----
>  python/setup.cfg                              |  33 +--
>  python/tests/linters.py                       |  11 -
>  python/tests/minreqs.txt                      |  66 ++---
>  pythondeps.toml                               |  13 +-
>  .../ci/setup/debian/debian-13-ppc64le.yaml    |   4 +-
>  .../ci/setup/ubuntu/ubuntu-2404-aarch64.yaml  |   4 +-
>  .../ci/setup/ubuntu/ubuntu-2404-s390x.yaml    |   4 +-
>  scripts/qapi/types.py                         |   2 +-
>  tests/lcitool/libvirt-ci                      |   2 +-
>  tests/lcitool/mappings.yml                    |  25 +-
>  tests/lcitool/projects/qemu.yml               |   2 +
>  tests/lcitool/targets/centos-stream-9.yml     |   4 +-
>  tests/vm/Makefile.include                     |   2 +-
>  tests/vm/generated/freebsd.json               |  14 +-
>  tests/vm/netbsd                               |   1 +
>  43 files changed, 185 insertions(+), 521 deletions(-)
>  delete mode 100644 docs/sphinx/compat.py
>  delete mode 100644 docs/sphinx/fakedbusdoc.py
>
> --
> 2.55.0
>
>


