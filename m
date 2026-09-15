Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F00C982C1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:16:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6aUW-0000vp-GR; Tue, 15 Sep 2026 17:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6aUP-0000sv-EQ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6aUK-0002XB-N1
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 17:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789506887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BZVueah+msUygMhG1XzOL//bcmJ5XZmULAiEVul9nb8=;
 b=ExvLXUnOBgZ0oiBjBzqrekSqSZWYuAd3D/Nr/+148IX2mZzV3AlP7OXhWqBOpz1iRLe0bI
 KPlQk88VJ8w2/aTl3Vql8Hk3EOGZbvhjsUUzfUH3CO0whjrONAkmW2KjfYCTW1CwgbFwv1
 mSPi1rW/3vNXobVkHNfl1cf8cwG9Sp4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-YyAlon3BMlKTjyMlMZNt6g-1; Tue,
 15 Sep 2026 17:14:43 -0400
X-MC-Unique: YyAlon3BMlKTjyMlMZNt6g-1
X-Mimecast-MFC-AGG-ID: YyAlon3BMlKTjyMlMZNt6g_1789506881
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8A9018088B7; Tue, 15 Sep 2026 21:14:40 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB5DB1956095; Tue, 15 Sep 2026 21:14:35 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, linux-cxl@vger.kernel.org,
 Lukas Straub <lukasstraub2@web.de>, Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Jason Wang <jasowangio@gmail.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Junjie Cao <junjie.cao@intel.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v3 0/7] qapi: convert remaining "simple" intro sections
Date: Tue, 15 Sep 2026 17:14:27 -0400
Message-ID: <20260915211434.3511110-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

v3:=0D
 - Fix python typing issue with hotfix from below ...=0D
 - Rebase on top of armbru/qapi-not-next=0D
v2:=0D
 - Fix stub insertion algorithm for some "TODO:" replacement cases=0D
=0D
Hello, this work converts the remaining "simple" intro sections in the=0D
QAPI schema to use the new syntax. This is part of our ongoing effort=0D
to add the mythical "inliner" to our generated QMP documentation.=0D
=0D
This batch covers structures that *are* likely to be inlined, and thus=0D
have introductory paragraphs that are quite likely to be omitted when=0D
the member documentation is copied into other contexts (e.g. as=0D
arguments for command documentation, or as members of a branch for=0D
commands that accept union arguments.)=0D
=0D
"simple" here is a non-technical distinction that means a single=0D
paragraph of text followed by an existing section boundary that=0D
naturally already delineates what comprises the intro.=0D
=0D
If you are a non-QAPI maintainer who has been CC'd on this series, you=0D
may wish to review what information is being codified as the "intro"=0D
(The indented paragraph) and keep in mind that in the future, this=0D
text may not be visible to the end-user reading our QMP documentation=0D
if this structure is utilized as the 'base' for another struct, used=0D
as the arguments for a command or event, or used as branch of a=0D
union. This series keeps it pretty simple, and every conversion herein=0D
is being codified as "the intro", i.e. "not crucial to understanding=0D
the behavior of the members of this struct".=0D
=0D
This is the last of the brain-dead, simple conversions apart from any=0D
new cases that may have been merged during the development of this=0D
series. The remaining patches all convert or split longer paragraphs=0D
and require more scrutiny.=0D
=0D
We're almost back to reviewing actual code! Hang in there, everybody.=0D
=0D
John Snow (7):=0D
  qapi: convert remaining simple intros for block-export.json=0D
  qapi: convert remaining simple intros for cxl.json=0D
  qapi: convert remaining simple intros for machine.json=0D
  qapi: convert remaining simple intros for block-core.json=0D
  qapi/parser: fix intermediate "intro" detection=0D
  qapi: convert intro sections with "TODO" markers=0D
  qapi: convert intro sections followed by notes/examples=0D
=0D
 qapi/block-core.json   | 45 ++++++++++++++++++------------------------=0D
 qapi/block-export.json | 19 ++++++++----------=0D
 qapi/cxl.json          | 14 +++++--------=0D
 qapi/machine.json      | 15 +++++---------=0D
 qapi/migration.json    | 25 +++++++++--------------=0D
 qapi/misc.json         |  3 +--=0D
 qapi/net.json          |  9 +++------=0D
 qapi/run-state.json    |  7 +++----=0D
 qapi/yank.json         |  5 +----=0D
 scripts/qapi/parser.py |  7 +++++++=0D
 10 files changed, 61 insertions(+), 88 deletions(-)=0D
=0D
-- =0D
2.55.0=0D
=0D


