Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636F7C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 05:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyjUz-0002Ku-CY; Tue, 25 Aug 2026 01:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyjUx-0002Jx-2D
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 01:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyjUv-0004Zs-4I
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 01:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787634895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I4+2my7JXKonUplILUq5ZAYumOFd5fYt9/6QmaX/vGw=;
 b=Y0Yn5Rhx3hJ8fyMmwrrFbfUNytITQUDv8nqIcp9CwL+u19+ix6/PYIYlM28Y49lxo/liAl
 EuixLkdkz5F5LFF8gmHzifDB6LreO1Or2I1Z/esOVD/HD4FHtpKBS2tFTzFWvliSfQj8Bi
 M6qTpAAaw7IYR8r8tjXx5q+qQfuh8vU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-t2R9tUfbOV-JUrcfLVv80w-1; Tue,
 25 Aug 2026 01:14:51 -0400
X-MC-Unique: t2R9tUfbOV-JUrcfLVv80w-1
X-Mimecast-MFC-AGG-ID: t2R9tUfbOV-JUrcfLVv80w_1787634889
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FAD51955F1D; Tue, 25 Aug 2026 05:14:48 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B1271955F76; Tue, 25 Aug 2026 05:14:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Warner Losh <imp@bsdimp.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v2 00/16] python: require python3.12+
Date: Tue, 25 Aug 2026 01:14:25 -0400
Message-ID: <20260825051441.1562454-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The stars have aligned, and we can jump all the way from Python3.9 to=0D
Python3.12.=0D
=0D
GitLab CI: https://gitlab.com/jsnow/qemu/-/pipelines/2787831126=0D
=0D
v2:=0D
 - s/types_seen/objects_seen in patch 8=0D
 - drop python3-devel from mappings.yml=0D
 - add comments explaining contentnode vs content_node in #16=0D
 - fix VM tests to use local QEMU build to support `-object=0D
   qmp-monitor` in order to run tests (Thanks danpb)=0D
 - fix FreeBSD vm test (Pre-existing breakage)=0D
 - fix netBSD vm test (Pre-existing breakage)=0D
 - Known issue: Haiku VM test is broken, but this series makes it=0D
   worse. Existing problem is that tomli has gone missing; new problem=0D
   is that our Haiku image still only offers Python 3.9. This VM test=0D
   has not been meaningfully updated since its introduction in 2020,=0D
   and the 2023 r4 build on vagrant's registry is still the most=0D
   recent version, so... I think if we want Haiku to work, it's up to=0D
   someone else to show it some love.=0D
=0D
Python 3.9 is EOL, and Python 3.10 will be EOL in about two months=0D
(October 2026). Python 3.11 is, to be blunt, perfectly serviceable -=0D
but when investigating our actual minimum dependency requirements, I=0D
realized none of our supported platforms used anything older than=0D
Python 3.12, so we may as well build and test with the version that=0D
all of our build platforms are actually using.=0D
=0D
This reduces the Python compat test matrix by quite a lot and allows=0D
us a few nice things. From memory, the highlights are:=0D
=0D
- Pattern matching syntax (fancy case statements). I am not dying to=0D
  use these anywhere, but they're nice!=0D
- Vastly improved error reporting from CPython=0D
- Ability to annotate exceptions with "notes", which allows us augment=0D
  the default reporting behavior for unhandled exceptions - this can=0D
  be used in e.g. iotests to help give additional information on tool=0D
  crashes that is sometimes hard to discover otherwise=0D
- The ability to use standard library types for typing syntax instead=0D
  of importing from Typing (Technically, valid since 3.9, but...)=0D
- The ability to use "x | y" instead of Union[x, y] in type hint=0D
  syntax. Combined with the above, it's a good time to clean up the=0D
  typing in qapi to make it read much more nicely.=0D
- ExceptionGroups - the ability to capture and report multiple=0D
  exceptions simultaneously. This is extremely useful for async QMP=0D
  and managing multiple VMs from a single python context. Async QMP=0D
  will be able to get a few nice QOL improvements with this.=0D
=0D
My personal favorite:=0D
=0D
- We can move to a much newer Sphinx, which gets rid of an awful lot=0D
  of very ugly compat code. This is the *actual* motivation of this=0D
  series.=0D
=0D
Anyway, here's the version chart for our supported build platforms and=0D
why this is safe to do:=0D
=0D
distro            EOS         python3  pip     setuptools  sphinx  wheel=0D
-------------------------------------------------------------------------=0D
centos_stream_9   2026-12-12  3.9.25   21.3.1  53.0.0      3.4.3   0.36.2=0D
centos_stream_9+  2026-12-12  3.12.13  23.2.1  68.2.2      ---     0.41.2=0D
freebsd           --          3.12.14  23.3.2  63.1.0      9.0.4   0.48.0=0D
ubuntu_24_04      2028-04-23  3.12.3   24.0    68.1.2      7.2.6   0.42.0=0D
centos_stream_10  2030-01-01  3.12.13  23.3.2  69.0.3      7.2.6   0.41.2=0D
alpine_3_21       2026-11-01  3.12.14  24.3.1  70.3.0      8.1.3   0.43.0=0D
debian_13         2028-08-09  3.13.5   25.1.1  78.1.1      8.1.3   0.46.1=0D
fedora_43         2026-12-09  3.14.7   25.1.1  78.1.1      8.2.3   0.45.1=0D
ubuntu_26_04      2031-05-29  3.14.4   25.1.1  78.1.1      8.2.3   0.46.3=0D
fedora_44         2027-06-02  3.14.7   26.0.1  80.10.2     8.2.3   0.45.1=0D
macports          --          3.14.7   26.0.1  80.10.2     9.1.0   0.48.0=0D
alpine_3_22       2027-05-01  3.12.14  25.1.1  80.9.0      8.2.3   0.46.3=0D
alpine_3_23       2027-11-01  3.12.14  25.1.1  80.9.0      8.2.3   0.46.3=0D
openbsd           --          3.14.6   26.2.1  80.9.0      9.1.0   0.48.0=0D
alpine_3_24       2028-06-01  3.14.7   26.1.2  82.0.1      9.1.0   0.47.0=0D
pkgsrc_current    --          3.13.15  26.2.1  84.0.0      9.1.0   0.48.0=0D
=0D
CentOS stream 9 note: python3.12, python3.12-pip,=0D
python3.12-setuptools and python3.12-wheel are available as optional=0D
packages in the standard repository. Sphinx is not available, but can=0D
be side-loaded from PyPI using pip3.12.=0D
=0D
More cleanups to follow: we may have the chance to upgrade to=0D
pyproject.toml packaging once and for all now that FreeBSD has moved=0D
to Python3.12, which will get us off the legacy packaging we've been=0D
using. This isn't a problem *currently*, but it has been the cause of=0D
a lot of pain in the past, and the sooner we can ditch it the better.=0D
=0D
toodles,=0D
--js=0D
=0D
John Snow (16):=0D
  tests: update vm tests to prefer locally-built QEMU=0D
  tests: update FreeBSD dependencies=0D
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
 .../dockerfiles/debian-amd64-cross.docker     |   2 +=0D
 .../dockerfiles/debian-arm64-cross.docker     |   2 +=0D
 .../dockerfiles/debian-armhf-cross.docker     |   2 +=0D
 .../dockerfiles/debian-i686-cross.docker      |   2 +=0D
 .../dockerfiles/debian-ppc64el-cross.docker   |   2 +=0D
 .../dockerfiles/debian-riscv64-cross.docker   |   2 +=0D
 .../dockerfiles/debian-s390x-cross.docker     |   2 +=0D
 tests/docker/dockerfiles/debian.docker        |   2 +=0D
 .../dockerfiles/emsdk-wasm64-cross.docker     |   4 +-=0D
 .../dockerfiles/fedora-rust-nightly.docker    |   2 +=0D
 .../dockerfiles/fedora-win64-cross.docker     |   2 +=0D
 tests/docker/dockerfiles/fedora.docker        |   2 +=0D
 tests/docker/dockerfiles/opensuse-leap.docker |   2 +=0D
 tests/docker/dockerfiles/ubuntu2404.docker    |   2 +=0D
 .gitlab-ci.d/macos-14.vars                    |   2 +-=0D
 python/Makefile                               |  10 +-=0D
 python/scripts/mkvenv.py                      |  63 +----=0D
 python/setup.cfg                              |  33 +--=0D
 python/tests/linters.py                       |  11 -=0D
 python/tests/minreqs.txt                      |  66 ++---=0D
 pythondeps.toml                               |  13 +-=0D
 .../ci/setup/debian/debian-13-ppc64le.yaml    |   2 +=0D
 .../ci/setup/ubuntu/ubuntu-2404-aarch64.yaml  |   2 +=0D
 .../ci/setup/ubuntu/ubuntu-2404-s390x.yaml    |   2 +=0D
 scripts/qapi/types.py                         |   2 +-=0D
 tests/lcitool/mappings.yml                    |  32 ++-=0D
 tests/lcitool/projects/qemu.yml               |   2 +=0D
 tests/lcitool/targets/centos-stream-9.yml     |   4 +-=0D
 tests/vm/Makefile.include                     |   2 +-=0D
 tests/vm/generated/freebsd.json               |  14 +-=0D
 tests/vm/netbsd                               |   1 +=0D
 42 files changed, 178 insertions(+), 507 deletions(-)=0D
 delete mode 100644 docs/sphinx/compat.py=0D
 delete mode 100644 docs/sphinx/fakedbusdoc.py=0D
=0D
-- =0D
2.55.0=0D
=0D


