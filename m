Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED7CC88E56
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 20:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x57tR-0001K7-LQ; Fri, 11 Sep 2026 16:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x57t7-0001Ir-8V
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x57t3-000536-5I
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 16:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789158615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/s/xpATFq9wq1tWXIjSVgZ0DSXchPc5xRfHHA7grfeE=;
 b=cQSZt9n6hXNwxmsNTp8Iu2m2t9YXtu6Xwub4PP5/ycweX5MSU71d7nE/pNzt6us5sPeU9E
 hVX51lpAvQVYBnSbZeFIUHe5ZS2pqwMEycKi3duDPg7rYfdVBY+fmJWArAGcF1FO+y79U5
 Gf9lyuo8JaOrFbooz24on2Df95BtKM4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-IPo6NDagM5SaWBBjus5VPg-1; Fri,
 11 Sep 2026 16:30:11 -0400
X-MC-Unique: IPo6NDagM5SaWBBjus5VPg-1
X-Mimecast-MFC-AGG-ID: IPo6NDagM5SaWBBjus5VPg_1789158610
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 273721953958; Fri, 11 Sep 2026 20:30:09 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D70A041B; Fri, 11 Sep 2026 20:30:03 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowangio@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 0/9] qapi: convert/split remaining QAPI/QMP intro sections
Date: Fri, 11 Sep 2026 16:29:53 -0400
Message-ID: <20260911203002.305316-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

Give or take any that snuck in during this conversion marathon, this=0D
should be the rest - and the trickiest ones that involve multiple=0D
paragraphs and decisions over where exactly to place the=0D
split. Currently there are no prose rewrites, but it is not out of the=0D
question that we will require some after review.=0D
=0D
If you are a non-QAPI maintainer, the TL:DR here is:=0D
    Take a look at what is being indented here and what is=0D
    not. Anything that gets indented is text that is not eligible for=0D
    inlining: that is, the intro text is not copied into command/event=0D
    documentation to replace "The members of ..." placeholders in our=0D
    generated documentation.=0D
=0D
    If any text that you believe is important for end users to=0D
    understand is in the indented section after these patches, please=0D
    review and propose a different prose split.=0D
=0D
    (More info: The intro text is not guaranteed to be dropped from=0D
    generated docs. For example, if a struct is used as a type for an=0D
    argument in its own right, it is guaranteed to be included in the=0D
    generated documentation. It is also always included for commands,=0D
    events, and enums. It is only for structs which are *only* ever=0D
    used as command/event arguments or as a branch type where this=0D
    text is at risk of not being reproduced at all in the output=0D
    documentation.)=0D
=0D
John Snow (9):=0D
  qapi: convert remaining simple intros for block-export.json=0D
  qapi: convert multi-paragraph intros (commands)=0D
  qapi: convert multi-paragraph intros (enums)=0D
  qapi: convert multi-paragraph intros (structs)=0D
  qapi: split intro sections for commands=0D
  qapi: split intro sections for events=0D
  qapi: split intro sections for enums=0D
  qapi: split intro sections for data structs=0D
  qapi: split intro sections for inlinable structs=0D
=0D
 qapi/acpi.json          |   3 +-=0D
 qapi/block-core.json    | 130 ++++++++++++++++++----------------------=0D
 qapi/block-export.json  |  27 ++++-----=0D
 qapi/block.json         |  71 +++++++++++-----------=0D
 qapi/compat.json        |   3 +-=0D
 qapi/control.json       |   3 +-=0D
 qapi/crypto.json        |   3 +-=0D
 qapi/introspect.json    |  16 ++---=0D
 qapi/job.json           |  43 ++++++-------=0D
 qapi/machine-s390x.json |   3 +-=0D
 qapi/machine.json       |  98 +++++++++++++++---------------=0D
 qapi/migration.json     |  18 +++---=0D
 qapi/misc-arm.json      |   9 ++-=0D
 qapi/misc-i386.json     |  22 +++----=0D
 qapi/misc.json          |  18 +++---=0D
 qapi/net.json           |  37 +++++-------=0D
 qapi/qdev.json          |  14 ++---=0D
 qapi/qom.json           |  27 ++++-----=0D
 qapi/stats.json         |   5 +-=0D
 qapi/transaction.json   |   6 +-=0D
 qapi/ui.json            |   8 +--=0D
 21 files changed, 253 insertions(+), 311 deletions(-)=0D
=0D
-- =0D
2.55.0=0D
=0D


