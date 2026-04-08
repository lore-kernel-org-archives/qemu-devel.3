Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FFF10F996B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXsr-0001FC-CV; Wed, 08 Apr 2026 14:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wAXsZ-0000os-Dx
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wAKxE-0005St-Bw
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775624150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9hOLm5XknLXNzYps7PBO5aaJI5d/9nbRVwZIRPRfnUA=;
 b=dHq06BrknWsPFZeXIF8pxa1aJGK+014UDIqN11AHJqtjTW2MAHtMQrSA9HF9+dwNGRFoM8
 6SrQydgB5BVP1lJkVWPQ5w4C+SJpXLZ3nfiFS/3jTUUYWkAGMEZp1NXSmtvXkN9rv5ufng
 AfqNP7QRWbpVRILoUByJ3NFrPaQ4jn4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-pSc05oKUOCmPtifITVCc2Q-1; Wed,
 08 Apr 2026 00:55:46 -0400
X-MC-Unique: pSc05oKUOCmPtifITVCc2Q-1
X-Mimecast-MFC-AGG-ID: pSc05oKUOCmPtifITVCc2Q_1775624143
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D296C1800344; Wed,  8 Apr 2026 04:55:42 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9CE6319560A6; Wed,  8 Apr 2026 04:55:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 00/10] qapi: enforce section ordering
Date: Wed,  8 Apr 2026 00:55:21 -0400
Message-ID: <20260408045531.3006678-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hiya, this series is meant to accomplish mostly one thing: Enforce a=0D
stricter ordering of sections in QAPI documentation blocks.=0D
=0D
The reason to do this is mostly for the sake of the inliner: if QAPI=0D
documentation blocks have some known, canonical order, it is easier to=0D
merge two documentation blocks together for the purposes of showing all=0D
arguments for commands/etc in a simple, flat list without needing to=0D
follow hyperlink breadcrumbs.=0D
=0D
Another reason to do this is to simplify where we insert autogenerated=0D
documentation. If the order is enforced, then inserting "Not Documented"=0D
stubs for members and generated "Returns:" statements can have a much=0D
simpler algorithm that will always match how manually written=0D
documentation is presented, in the same order.=0D
=0D
This is still pretty RFC quality, the tests have not been implemented=0D
and the implementation of changes in the parser are still pretty=0D
fuzzy. The main point of this series at this point in time is to review=0D
the QAPI source changes and decide if the strategy employed in fixing=0D
the section ordering is the direction we ultimately want to go in.=0D
=0D
V2:=0D
 - Add quite a few FIXME stubs for tests=0D
 - Much more carefully delineate QAPI source changes into ones required=0D
   to prevent visible changes, and ones that explictly create visible=0D
   changes=0D
 - Various commit message / comment changes=0D
 - Fix heuristic for griping about Intro/Details "ambiguity" to also=0D
   ignore generated "Returns" sections, which was missing before and=0D
   missed quite a few cases that did impact rendered output=0D
=0D
To verify rendering changes (or lack thereof), I used this strategy:=0D
=0D
(1) For a reference output before a change, I ran a build:=0D
    > V=3D1 DEBUG=3D1 make -j13;=0D
=0D
(2) Then I created some reference output for the intermediate rST=0D
    debugging output files (fish syntax):=0D
    > for i in *.ir; sed -E 's|\.json:[0-9]{4}|.json:nnnn|g' $i > $i.ref; e=
nd=0D
=0D
(3) Then after applying a patch, to check for any differences, I re-ran=0D
    the build as in (1) and then:=0D
    > for i in *.ir; sed -E 's|\.json:[0-9]{4}|.json:nnnn|g' $i > $i.new; e=
nd=0D
    > for i in *.ir; meld $i.ref $i.new; end=0D
=0D
An observation: Most of the time, the Intro section is only one=0D
paragraph anyway. We might be able to save on some explicit "Details:"=0D
syntax if we just formalize the idea that the intro can only ever be at=0D
most one paragraph. I don't know if we want to do that (Do we want to=0D
keep the ability to run long in the "intro"?) - but it would cut down on=0D
quite a lot of markup that this series adds.=0D
=0D
John Snow (10):=0D
  qapi: differentiate "intro" and "details" sections=0D
  qapi: prohibit 'details' sections between tagged sections=0D
  qapi: add "Details:" disambiguation marker=0D
  qapi: add "Details:" markers where needed=0D
  qapi: add "Details:" markers where potentially needed=0D
  qapi: detect potentially semantically ambiguous intro paragraphs=0D
  qapi: re-order QAPI doc block sections=0D
  qapi: enforce doc block section ordering=0D
  qapi: re-order 'since' sections to always be last=0D
  qapi: enforce strict positioning for "Since:" section=0D
=0D
 docs/devel/qapi-code-gen.rst                 |  33 +++-=0D
 docs/interop/firmware.json                   |   4 +-=0D
 docs/interop/vhost-user.json                 |   3 +-=0D
 docs/sphinx/qapidoc.py                       |   2 +-=0D
 qapi/accelerator.json                        |  12 +-=0D
 qapi/acpi.json                               |   8 +-=0D
 qapi/block-core.json                         | 183 ++++++++++---------=0D
 qapi/block-export.json                       |  20 +-=0D
 qapi/block.json                              |  48 ++---=0D
 qapi/char.json                               |  36 ++--=0D
 qapi/control.json                            |  14 +-=0D
 qapi/dump.json                               |  16 +-=0D
 qapi/machine-s390x.json                      |  16 +-=0D
 qapi/machine.json                            | 144 ++++++++-------=0D
 qapi/migration.json                          | 102 ++++++-----=0D
 qapi/misc-arm.json                           |   6 +-=0D
 qapi/misc-i386.json                          |  40 ++--=0D
 qapi/misc.json                               |  68 ++++---=0D
 qapi/net.json                                |  42 ++---=0D
 qapi/pci.json                                |   4 +-=0D
 qapi/qdev.json                               |  12 +-=0D
 qapi/qom.json                                |  34 ++--=0D
 qapi/replay.json                             |  16 +-=0D
 qapi/rocker.json                             |  16 +-=0D
 qapi/run-state.json                          |  66 ++++---=0D
 qapi/tpm.json                                |  12 +-=0D
 qapi/trace.json                              |   8 +-=0D
 qapi/transaction.json                        |   4 +-=0D
 qapi/ui.json                                 |  76 ++++----=0D
 qapi/vfio.json                               |   4 +-=0D
 qapi/virtio.json                             |  46 ++---=0D
 qapi/yank.json                               |   2 +-=0D
 qga/qapi-schema.json                         |   2 +=0D
 scripts/qapi/parser.py                       | 134 ++++++++++++--=0D
 tests/qapi-schema/doc-good.json              |  12 +-=0D
 tests/qapi-schema/doc-good.out               |  10 +-=0D
 tests/qapi-schema/doc-good.txt               |  18 +-=0D
 tests/qapi-schema/doc-misplaced-details.err  |   0=0D
 tests/qapi-schema/doc-misplaced-details.json |   3 +=0D
 tests/qapi-schema/doc-misplaced-details.out  |  11 ++=0D
 tests/qapi-schema/doc-missing-details.err    |   0=0D
 tests/qapi-schema/doc-missing-details.json   |   3 +=0D
 tests/qapi-schema/doc-missing-details.out    |  11 ++=0D
 tests/qapi-schema/meson.build                |   2 +=0D
 44 files changed, 784 insertions(+), 519 deletions(-)=0D
 create mode 100644 tests/qapi-schema/doc-misplaced-details.err=0D
 create mode 100644 tests/qapi-schema/doc-misplaced-details.json=0D
 create mode 100644 tests/qapi-schema/doc-misplaced-details.out=0D
 create mode 100644 tests/qapi-schema/doc-missing-details.err=0D
 create mode 100644 tests/qapi-schema/doc-missing-details.json=0D
 create mode 100644 tests/qapi-schema/doc-missing-details.out=0D
=0D
-- =0D
2.53.0=0D
=0D


