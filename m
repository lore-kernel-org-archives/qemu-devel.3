Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC0BCA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 22:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBJyJ-0006vH-Ca; Mon, 28 Sep 2026 18:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJyH-0006uv-Kq
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:37:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJyF-0006AJ-Rd
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790635034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EcdqR8yfZnJFx6zAbSPvacnduVF8qe+alEzjfLEUZMs=;
 b=TiRE/qWd8ttOK7RWHyYTsWXUpdFiIhkrFpI8MeXHEtL5TQwScTXxN3OG2XI7ARpfKndFXT
 PLcc7Y+drrCRSE373Xs/Ec+1f/1mshuHN9GpP+PPIrG0b+OwIIk6ET0pmf+cAZxk+opLr7
 oIwD1UyLeq8AaXeu5xBPA7C7HRoADfc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-hkCwNPtMPZyt6TK1Xlmy4g-1; Mon,
 28 Sep 2026 18:37:10 -0400
X-MC-Unique: hkCwNPtMPZyt6TK1Xlmy4g-1
X-Mimecast-MFC-AGG-ID: hkCwNPtMPZyt6TK1Xlmy4g_1790635028
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 803361944D33; Mon, 28 Sep 2026 22:37:07 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E8FB11956047; Mon, 28 Sep 2026 22:36:59 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kevin Wolf <kwolf@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiri Pirko <jiri@resnulli.us>, Alex Williamson <alex@shazbot.org>,
 Markus Armbruster <armbru@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 00/14] qapi: enforce section ordering
Date: Mon, 28 Sep 2026 18:36:43 -0400
Message-ID: <20260928223657.2303684-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

howdy,=0D
=0D
this series begins enforcing a strict section ordering in the QAPI=0D
parser. This allows us to change how we store sections internally in=0D
QAPIDoc so that we always have well-defined points in any=0D
documentation block where we may insert auto-generated documentation=0D
sections when applicable.=0D
=0D
This series is effectively RFC quality; I am aware that we will need=0D
more unit tests for the new negative cases at a minimum.=0D
=0D
This is the last series messing around with the QAPIDoc format before=0D
I move on to directly working on the inliner again.=0D
=0D
John Snow (14):=0D
  qapi: rename "plain" sections to "details"=0D
  docs/qapi-code-gen: expand each section's syntax into a mini-section=0D
  qapi: re-order QAPI doc block sections=0D
  qapi/parser: enforce doc block section ordering=0D
  qapi: move 'details' sections to the bottom of doc blocks=0D
  qapi/parser: enforce 'details' sections' relative position=0D
  qapi: re-order 'since' sections to always be last=0D
  qapi/parser: enforce strict positioning for "Since:" section=0D
  qapi/parser: remove _insert_after_intro() helper=0D
  qapi/parser: add _append() method=0D
  qapi/parser: privatize "all_sections" field as "_sections"=0D
  qapi/parser: add _active_section private member=0D
  qapi/parser: add new _sections mapping=0D
  qapi/parser: convert single-section properties to getter properties=0D
=0D
 docs/devel/qapi-code-gen.rst    | 117 ++++++--=0D
 docs/interop/firmware.json      |  54 ++--=0D
 docs/interop/vhost-user.json    |  29 +-=0D
 docs/sphinx/qapidoc.py          |  15 +-=0D
 qapi/accelerator.json           |  16 +-=0D
 qapi/acpi.json                  |  36 +--=0D
 qapi/block-core.json            | 476 ++++++++++++++++----------------=0D
 qapi/block-export.json          |  38 +--=0D
 qapi/block.json                 | 114 ++++----=0D
 qapi/char.json                  |  36 +--=0D
 qapi/compat.json                |  14 +-=0D
 qapi/control.json               |  12 +-=0D
 qapi/crypto.json                |   4 +-=0D
 qapi/dump.json                  |  16 +-=0D
 qapi/introspect.json            |  14 +-=0D
 qapi/job.json                   |  26 +-=0D
 qapi/machine-s390x.json         |  28 +-=0D
 qapi/machine.json               | 324 +++++++++++-----------=0D
 qapi/migration.json             | 144 +++++-----=0D
 qapi/misc-arm.json              |   4 +-=0D
 qapi/misc-i386.json             |  58 ++--=0D
 qapi/misc.json                  |  84 +++---=0D
 qapi/net.json                   |  64 ++---=0D
 qapi/pci.json                   |   4 +-=0D
 qapi/qdev.json                  |  24 +-=0D
 qapi/qom.json                   |  56 ++--=0D
 qapi/replay.json                |  16 +-=0D
 qapi/rocker.json                |  16 +-=0D
 qapi/run-state.json             |  64 ++---=0D
 qapi/stats.json                 |   6 +-=0D
 qapi/tpm.json                   |  12 +-=0D
 qapi/trace.json                 |   8 +-=0D
 qapi/transaction.json           |  34 +--=0D
 qapi/ui.json                    |  90 +++---=0D
 qapi/vfio.json                  |   4 +-=0D
 qapi/virtio.json                |  46 +--=0D
 qga/qapi-schema.json            |  80 +++---=0D
 scripts/qapi/parser.py          | 232 ++++++++--------=0D
 tests/qapi-schema/doc-good.json |  16 +-=0D
 tests/qapi-schema/doc-good.out  |  34 +--=0D
 tests/qapi-schema/doc-good.txt  |  22 +-=0D
 tests/qapi-schema/test-qapi.py  |   2 +-=0D
 42 files changed, 1274 insertions(+), 1215 deletions(-)=0D
=0D
-- =0D
2.55.0=0D
=0D


