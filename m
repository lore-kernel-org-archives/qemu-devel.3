Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B745F53D81
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2CeI-00027n-M6; Mon, 16 Mar 2026 14:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w2Ce8-00027Q-By
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:26:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w2Ce6-0007uH-6a
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773685589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RX5K/AyExwyFs/tqKESmjuPGgFyWVfxnkCz4YsOyov8=;
 b=H9J/raDtTwx3Gyaeo9ZWj3sXVVv7YvvdsS7UKaa/vo2So1Fa6Kmn7VDdNoOMFypoiPpU70
 Z/DaLEz5X9mYISEouI32UMT15pYOqUnKcgDmL8YHVRh7/n8BxIoLIZpisSXs14uy6jPC7U
 LXdnxlyK9hjalTuQi9wItfcqEvmBEqg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-9BAmQprcMFO3YP8rVaIlag-1; Mon,
 16 Mar 2026 14:26:25 -0400
X-MC-Unique: 9BAmQprcMFO3YP8rVaIlag-1
X-Mimecast-MFC-AGG-ID: 9BAmQprcMFO3YP8rVaIlag_1773685582
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C5EB19560A7; Mon, 16 Mar 2026 18:26:22 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.45])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D25FB30001A2; Mon, 16 Mar 2026 18:26:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 0/8] qapi: enforce section ordering
Date: Mon, 16 Mar 2026 14:25:59 -0400
Message-ID: <20260316182608.148628-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

This is RFC quality and mostly meant for Markus to review, but if you're=0D
curious about what we're up to, you're welcome to nose around :)=0D
=0D
It's a hackish application of enforcing a strict source section ordering=0D
in QAPIDoc and the accompanying patches that mend the source to respect=0D
that order. The point of the series is to, ultimately, make it easier to=0D
"inject" auto-generated documentation by enforcing a specific order to=0D
sections so that it is easier to insert documentation that is missing or=0D
can be implied from the source. A secondary goal is to more closely=0D
align the source documentation ordering with what gets rendered on the=0D
HTML documentation.=0D
=0D
I am sending it to the list in this RFC state mostly to illustrate what=0D
each specific imposition requires in terms of source doc changes, and as=0D
a refresher for the specific restrictions I want to make to facilitate=0D
the inliner feature.=0D
=0D
I am not neccessarily married to any specific technique/implementation=0D
for each specific restriction, but if it looks broadly OK to you=0D
(Markus), I can work on any requested polish or corollary cleanups. If=0D
you'd like to see a different approach, that's fine too. We may wish to=0D
discuss the ability to add notes/addendums to sections and what syntax=0D
would support that.=0D
=0D
I had originally thought I'd work on the @oob project, but quickly=0D
remembered that my approach to that feature required yet-another place=0D
where we inject a doc section, and decided it would be best if I solved=0D
"where do we inject this autogenerated section?" once and for all,=0D
hence, you are getting this series first.=0D
=0D
John Snow (8):=0D
  qapi: differentiate "intro" and "details" sections=0D
  qapi: prohibit 'details' sections between tagged sections=0D
  qapi: add "Details:" disambiguation marker=0D
  qapi: detect potentially semantically ambiguous intro paragraphs=0D
  qapi: re-order QAPI doc block sections=0D
  qapi: enforce doc block section ordering=0D
  qapi: re-order 'since' sections to always be last=0D
  qapi: enforce strict positioning for "Since:" section=0D
=0D
 docs/interop/firmware.json      |   4 +-=0D
 docs/interop/vhost-user.json    |   3 +-=0D
 docs/sphinx/qapidoc.py          |   2 +-=0D
 qapi/accelerator.json           |  12 +--=0D
 qapi/acpi.json                  |   8 +-=0D
 qapi/block-core.json            | 183 ++++++++++++++++----------------=0D
 qapi/block-export.json          |  20 ++--=0D
 qapi/block.json                 |  48 ++++-----=0D
 qapi/char.json                  |  36 +++----=0D
 qapi/control.json               |  14 +--=0D
 qapi/dump.json                  |  16 +--=0D
 qapi/machine-s390x.json         |  16 +--=0D
 qapi/machine.json               | 144 +++++++++++++------------=0D
 qapi/migration.json             | 102 ++++++++++--------=0D
 qapi/misc-arm.json              |   6 +-=0D
 qapi/misc-i386.json             |  40 ++++---=0D
 qapi/misc.json                  |  68 ++++++------=0D
 qapi/net.json                   |  42 ++++----=0D
 qapi/pci.json                   |   4 +-=0D
 qapi/qdev.json                  |  12 +--=0D
 qapi/qom.json                   |  34 +++---=0D
 qapi/replay.json                |  16 +--=0D
 qapi/rocker.json                |  16 +--=0D
 qapi/run-state.json             |  66 +++++++-----=0D
 qapi/tpm.json                   |  12 +--=0D
 qapi/trace.json                 |   8 +-=0D
 qapi/transaction.json           |   4 +-=0D
 qapi/ui.json                    |  76 +++++++------=0D
 qapi/vfio.json                  |   4 +-=0D
 qapi/virtio.json                |  46 ++++----=0D
 qapi/yank.json                  |   2 +-=0D
 scripts/qapi/parser.py          | 121 ++++++++++++++++++---=0D
 tests/qapi-schema/doc-good.json |  12 +--=0D
 tests/qapi-schema/doc-good.out  |  10 +-=0D
 tests/qapi-schema/doc-good.txt  |  18 ++--=0D
 35 files changed, 695 insertions(+), 530 deletions(-)=0D
=0D
-- =0D
2.53.0=0D
=0D


