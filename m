Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96B2C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:36:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1qkj-0001OF-3K; Wed, 02 Sep 2026 15:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1qki-0001O5-06
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1qkg-0004j2-5V
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788377764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=z+GcPTBTK0gjMeTEHiRlKRN7oYoOykWJBNhfGUsmCpw=;
 b=IhMstZZ1svoR8pUezBMHKbYYwIjOuv0z8GcXZZHGRAaDd1IUE5DLdTkpSlBObGV0nRjopb
 qw5QFZ1/aWM9Jp6jQoUiq1Yjdas3HTnqWRpCDPfBcujBWiAVx/5efm640z+qBkOHudmZz2
 aQDuatGcorwijUM/izKyvQWOznWTMKc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-W_gdS0eONgiZ4MuaGy0bxg-1; Wed,
 02 Sep 2026 15:36:03 -0400
X-MC-Unique: W_gdS0eONgiZ4MuaGy0bxg-1
X-Mimecast-MFC-AGG-ID: W_gdS0eONgiZ4MuaGy0bxg_1788377760
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2B5E195D03C; Wed,  2 Sep 2026 19:35:59 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 845451800261; Wed,  2 Sep 2026 19:35:52 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Hanna Reitz <hreitz@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Yonggang Luo <luoyonggang@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 00/16] Python patches
Date: Wed,  2 Sep 2026 15:35:35 -0400
Message-ID: <20260902193551.582660-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

The following changes since commit a925240509d1b4b656cc480f1cc79ba4d7c8bc08=
:=0D
=0D
  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into s=
taging (2026-09-02 13:40:43 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  git@gitlab.com:jsnow/qemu.git tags/python-pull-request=0D
=0D
for you to fetch changes up to 4061c0e95c6e2736926ab8723606cddf582f58e6:=0D
=0D
  sphinx: drop qapidoc back-compat overboiled spaghetti dinner (2026-09-02 =
15:02:58 -0400)=0D
=0D
----------------------------------------------------------------=0D
python=0D
=0D
upgrade to py312=0D
=0D
----------------------------------------------------------------=0D
=0D
John Snow (16):=0D
  tests: update vm tests to prefer locally-built QEMU=0D
  tests: update libvirt-ci, lcitool=0D
  tests: update netbsd dependencies=0D
  tests: drop python3-devel mapping=0D
  tests: re-add opencv2 and numpy dependencies=0D
  tests: add Python3.12 to centos9.docker=0D
  tests: update emsdk-wasm64-cross=0D
  qapi: update type hint for objects_seen=0D
  python: upgrade to Python3.12+=0D
  python: fix license configuration=0D
  python: allow mypy to run as the current python version=0D
  python: remove distutils workarounds=0D
  python: remove stale setup.cfg options=0D
  sphinx: require sphinx 7.2.6=0D
  sphinx: drop fakedbusdoc=0D
  sphinx: drop qapidoc back-compat overboiled spaghetti dinner=0D
=0D
 docs/conf.py                                  |  11 +-=0D
 docs/interop/dbus-display.rst                 |  14 +-=0D
 docs/interop/dbus-vmstate.rst                 |  14 +-=0D
 docs/interop/dbus-vnc.rst                     |  14 +-=0D
 docs/requirements.txt                         |   2 +-=0D
 docs/sphinx/compat.py                         | 230 ------------------=0D
 docs/sphinx/fakedbusdoc.py                    |  30 ---=0D
 docs/sphinx/qapi_domain.py                    |  53 ++--=0D
 configure                                     |  11 +-=0D
 tests/docker/dockerfiles/alpine.docker        |   1 +=0D
 tests/docker/dockerfiles/centos9.docker       |  14 +-=0D
 .../dockerfiles/debian-amd64-cross.docker     |   4 +-=0D
 .../dockerfiles/debian-arm64-cross.docker     |   4 +-=0D
 .../dockerfiles/debian-armhf-cross.docker     |   4 +-=0D
 .../dockerfiles/debian-i686-cross.docker      |   4 +-=0D
 .../dockerfiles/debian-ppc64el-cross.docker   |   4 +-=0D
 .../dockerfiles/debian-riscv64-cross.docker   |   4 +-=0D
 .../dockerfiles/debian-s390x-cross.docker     |   4 +-=0D
 tests/docker/dockerfiles/debian.docker        |   4 +-=0D
 .../dockerfiles/emsdk-wasm64-cross.docker     |   4 +-=0D
 .../dockerfiles/fedora-rust-nightly.docker    |   2 +=0D
 .../dockerfiles/fedora-win64-cross.docker     |   2 +=0D
 tests/docker/dockerfiles/fedora.docker        |   2 +=0D
 tests/docker/dockerfiles/opensuse-leap.docker |   4 +-=0D
 tests/docker/dockerfiles/ubuntu2404.docker    |   4 +-=0D
 .gitlab-ci.d/macos-14.vars                    |   2 +-=0D
 python/Makefile                               |  10 +-=0D
 python/scripts/mkvenv.py                      |  63 +----=0D
 python/setup.cfg                              |  33 +--=0D
 python/tests/linters.py                       |  11 -=0D
 python/tests/minreqs.txt                      |  66 ++---=0D
 pythondeps.toml                               |  13 +-=0D
 .../ci/setup/debian/debian-13-ppc64le.yaml    |   4 +-=0D
 .../ci/setup/ubuntu/ubuntu-2404-aarch64.yaml  |   4 +-=0D
 .../ci/setup/ubuntu/ubuntu-2404-s390x.yaml    |   4 +-=0D
 scripts/qapi/types.py                         |   2 +-=0D
 tests/lcitool/libvirt-ci                      |   2 +-=0D
 tests/lcitool/mappings.yml                    |  25 +-=0D
 tests/lcitool/projects/qemu.yml               |   2 +=0D
 tests/lcitool/targets/centos-stream-9.yml     |   4 +-=0D
 tests/vm/Makefile.include                     |   2 +-=0D
 tests/vm/generated/freebsd.json               |  14 +-=0D
 tests/vm/netbsd                               |   1 +=0D
 43 files changed, 185 insertions(+), 521 deletions(-)=0D
 delete mode 100644 docs/sphinx/compat.py=0D
 delete mode 100644 docs/sphinx/fakedbusdoc.py=0D
=0D
-- =0D
2.55.0=0D
=0D


