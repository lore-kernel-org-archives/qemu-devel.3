Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3250CCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 19:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBGzN-0003ex-FF; Mon, 28 Sep 2026 15:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBGzL-0003eP-L6
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:26:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBGzJ-00033y-Vu
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 15:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790623568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7oNDHVMZsgXOOeNxpJsa8kA6L1yFUvwSqL/8N6B8bjU=;
 b=IZNTCXkaYU77IEExdXyAuUAMISOnpRcqYyYUeeqwS/BsJUqgB2aXoRUWWLZ4EhFDLWCvJg
 Lr+iRMNIP2Sz5JEyos7TIYnmPsvTvF/h+I0dD3QQk9/lWjDSrBhBjxSR+aSRfhZmWy6ZhN
 yT3Z2OuuTseIby5aK15oxotwSdv/WaY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-cyXClJEYOqWvHtLy6paD3Q-1; Mon,
 28 Sep 2026 15:26:05 -0400
X-MC-Unique: cyXClJEYOqWvHtLy6paD3Q-1
X-Mimecast-MFC-AGG-ID: cyXClJEYOqWvHtLy6paD3Q_1790623563
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7C02182E6A9; Mon, 28 Sep 2026 19:26:02 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.217])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5AF65BC; Mon, 28 Sep 2026 19:25:58 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH v3 00/10] qapi: convert/split remaining QAPI/QMP intro sections
Date: Mon, 28 Sep 2026 15:25:47 -0400
Message-ID: <20260928192557.509157-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series is the last batch of intro conversions.=0D
=0D
V2:=0D
 - Address review comments=0D
 - Adjust commit messages, add S-O-B=0D
=0D
This series covers the trickiest bits of qapi/qapi-schema.json, ones=0D
that involve multiple paragraphs and decisions over where exactly to=0D
place the split. Currently there are only some very minor prose=0D
rewrites the break apart intro statements from paragraphs where deemed=0D
appropriate.=0D
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
John Snow (10):=0D
  qapi: split intro for HV_BALLOON_STATUS_REPORT=0D
  qapi: convert/split intros for block-core.json commands=0D
  qapi: convert/split intros for block commands=0D
  qapi: convert/split intros for job.json commands=0D
  qapi: convert/split intros for misc-i386.json commands=0D
  qapi: convert/split intros for commands=0D
  qapi: convert/split intros for enums=0D
  qapi: split intro sections for events=0D
  qapi: split intro sections for data structs=0D
  qapi: split intro sections for inlinable structs=0D
=0D
 qapi/acpi.json          |   3 +-=0D
 qapi/block-core.json    | 131 +++++++++++++++++-----------------------=0D
 qapi/block-export.json  |   8 +--=0D
 qapi/block.json         |  33 +++++-----=0D
 qapi/compat.json        |   5 +-=0D
 qapi/control.json       |   3 +-=0D
 qapi/crypto.json        |   3 +-=0D
 qapi/introspect.json    |  16 ++---=0D
 qapi/job.json           |  42 ++++++-------=0D
 qapi/machine-s390x.json |   3 +-=0D
 qapi/machine.json       |  78 +++++++++++-------------=0D
 qapi/migration.json     |  12 ++--=0D
 qapi/misc-arm.json      |   5 +-=0D
 qapi/misc-i386.json     |  22 +++----=0D
 qapi/misc.json          |   8 +--=0D
 qapi/net.json           |  37 +++++-------=0D
 qapi/qdev.json          |   9 ++-=0D
 qapi/qom.json           |   9 +--=0D
 qapi/stats.json         |   5 +-=0D
 qapi/transaction.json   |   7 +--=0D
 qapi/ui.json            |   8 +--=0D
 21 files changed, 193 insertions(+), 254 deletions(-)=0D
=0D
-- =0D
2.55.0=0D
=0D


