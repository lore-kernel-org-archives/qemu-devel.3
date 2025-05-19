Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000CCC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 18:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH587-0002g9-3r; Mon, 19 May 2025 14:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH57q-0002cQ-DU
 for qemu-devel@nongnu.org; Mon, 19 May 2025 14:22:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH57n-0000b3-SD
 for qemu-devel@nongnu.org; Mon, 19 May 2025 14:22:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747678925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BAGH4CxVLLSUE6S1VDaCj0K1vQrrmGMF/XKOGp3qEOc=;
 b=X4coAAKJUxf6uGfZiJfWuEIkD4jgUdizIipRn/dlIrdg4X3yBw421Lviv5Sve5r4Vvf8qC
 ahOC6IzSFGUnVNVuO52QAhZWCEkvwEVXmhzhxiG+m0KRWr1uotKVmuelyMlIavBkTYujFj
 0iLl3rJm4OXqbPMKSS7PSUPvt8XGCv0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-8tyCc0b6OtygnO8OeolZUQ-1; Mon,
 19 May 2025 14:22:02 -0400
X-MC-Unique: 8tyCc0b6OtygnO8OeolZUQ-1
X-Mimecast-MFC-AGG-ID: 8tyCc0b6OtygnO8OeolZUQ_1747678921
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C0B31956086; Mon, 19 May 2025 18:22:00 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.235])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 73FCA19560A3; Mon, 19 May 2025 18:21:55 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org,
 John Snow <jsnow@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 0/8] Python: Fix 'make check-dev' and modernize to 3.9+
Date: Mon, 19 May 2025 14:21:44 -0400
Message-ID: <20250519182153.3835722-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This series does a couple things that I'll probably end up splitting out=0D
into smaller series if history is any guide, but either way, here it=0D
goes:=0D
=0D
A) Convert qemu.git/python/ to a PEP517/pyproject.toml=0D
package. Ultimately this means deleting setup.py and fully migrating to=0D
newer python infrastructure. I think this should be safe to do by now,=0D
but admittedly I am not *confident* as it relies on setuptools versions=0D
in the wild, not python versions. My motivation for trying it is to fix=0D
"make check-dev", which has been broken for the last two Fedora releases=0D
under newer setuptools which have started removing support for the=0D
pre-PEP517 packaging formats, which will only continue to get worse from=0D
here on out.=0D
=0D
B) Sync changes from the qemu.qmp package back over to qemu.git. I know=0D
I need to decouple this badly, but in order to do so, I need to make=0D
sure they're synchronized to be assured that the switch to the=0D
standalone version won't break anything, so this is a necessary=0D
step. It's happening here because of the 3.6+ compat crud we are still=0D
carrying in qemu.git that has since been removed from the standalone=0D
library.=0D
=0D
C) Move us to 3.9+ style type hints. I know it feels like we just got=0D
the type hints settled and we're already changing them. Sorry about=0D
that. They are deprecated in 3.9, and *could* be removed at any time. I=0D
figured now was a good time as any to get rid of them before they become=0D
a problem randomly some day in the future.=0D
=0D
D) Update the mypy configuration to check under multiple Python versions=0D
more effectively and thoroughly.=0D
=0D
Whew.=0D
--js=0D
=0D
John Snow (8):=0D
  python: convert packages to PEP517/pyproject.toml=0D
  python: update pylint ignores=0D
  python: sync changes from external qemu.qmp package=0D
  python: use 3.9+ builtin type hints=0D
  python: convert remaining deprecated type hints for 3.9+=0D
  python: clean up requirements for 3.9+=0D
  python: update mkvenv to type-check under different python versions=0D
  python: remove version restriction for mypy=0D
=0D
 docs/sphinx/compat.py                         |  11 +-=0D
 docs/sphinx/dbusdoc.py                        |  13 +-=0D
 docs/sphinx/dbusdomain.py                     |  32 ++--=0D
 docs/sphinx/fakedbusdoc.py                    |   4 +-=0D
 docs/sphinx/qapi_domain.py                    |  77 ++++----=0D
 docs/sphinx/qapidoc.py                        |  16 +-=0D
 python/README.rst                             |  33 ++--=0D
 python/Makefile                               |  18 +-=0D
 python/pyproject.toml                         |   8 +=0D
 python/qemu/machine/console_socket.py         |   4 +-=0D
 python/qemu/machine/machine.py                |  32 ++--=0D
 python/qemu/machine/qtest.py                  |  13 +-=0D
 python/qemu/qmp/error.py                      |   7 +-=0D
 python/qemu/qmp/events.py                     |  72 +++++--=0D
 python/qemu/qmp/legacy.py                     |  31 +--=0D
 python/qemu/qmp/message.py                    |  38 ++--=0D
 python/qemu/qmp/models.py                     |  26 ++-=0D
 python/qemu/qmp/protocol.py                   | 179 ++++++++++-------=0D
 python/qemu/qmp/qmp_client.py                 | 147 +++++++++-----=0D
 python/qemu/qmp/qmp_shell.py                  | 180 ++++++++++++------=0D
 python/qemu/qmp/qmp_tui.py                    |  55 +++---=0D
 python/qemu/qmp/util.py                       | 116 +----------=0D
 python/qemu/utils/accel.py                    |   4 +-=0D
 python/qemu/utils/qemu_ga_client.py           |  11 +-=0D
 python/qemu/utils/qom_common.py               |  17 +-=0D
 python/qemu/utils/qom_fuse.py                 |  12 +-=0D
 python/scripts/mkvenv.py                      |  38 ++--=0D
 python/setup.cfg                              |   7 +-=0D
 python/setup.py                               |  40 ----=0D
 python/tests/minreqs.txt                      |   4 +-=0D
 python/tests/protocol.py                      |  10 +-=0D
 scripts/block-coroutine-wrapper.py            |   2 +-=0D
 .../codeconverter/codeconverter/patching.py   |  50 ++---=0D
 .../codeconverter/codeconverter/qom_macros.py |  36 ++--=0D
 .../codeconverter/qom_type_info.py            |  16 +-=0D
 scripts/compare-machine-types.py              |  41 ++--=0D
 scripts/qapi/commands.py                      |  13 +-=0D
 scripts/qapi/common.py                        |  20 +-=0D
 scripts/qapi/events.py                        |   8 +-=0D
 scripts/qapi/expr.py                          |  28 ++-=0D
 scripts/qapi/features.py                      |   2 +-=0D
 scripts/qapi/gen.py                           |  13 +-=0D
 scripts/qapi/introspect.py                    |  44 ++---=0D
 scripts/qapi/parser.py                        |  42 ++--=0D
 scripts/qapi/schema.py                        | 117 ++++++------=0D
 scripts/qapi/source.py                        |  10 +-=0D
 scripts/qapi/types.py                         |  20 +-=0D
 scripts/qapi/visit.py                         |  14 +-=0D
 scripts/rust/rustc_args.py                    |   7 +-=0D
 scripts/u2f-setup-gen.py                      |   3 +-=0D
 tests/functional/qemu_test/ports.py           |   3 +-=0D
 tests/functional/test_acpi_bits.py            |   9 +-=0D
 tests/qemu-iotests/151                        |   4 +-=0D
 tests/qemu-iotests/297                        |   5 +-=0D
 tests/qemu-iotests/300                        |   4 +-=0D
 tests/qemu-iotests/fat16.py                   |  11 +-=0D
 tests/qemu-iotests/findtests.py               |  13 +-=0D
 tests/qemu-iotests/iotests.py                 |  38 ++--=0D
 tests/qemu-iotests/linters.py                 |   7 +-=0D
 tests/qemu-iotests/testenv.py                 |  11 +-=0D
 tests/qemu-iotests/testrunner.py              |  19 +-=0D
 .../qemu-iotests/tests/stream-under-throttle  |   3 +-=0D
 62 files changed, 925 insertions(+), 943 deletions(-)=0D
 create mode 100644 python/pyproject.toml=0D
 delete mode 100755 python/setup.py=0D
=0D
-- =0D
2.48.1=0D
=0D


