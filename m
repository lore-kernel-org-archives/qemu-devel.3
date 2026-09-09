Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AD2C79FB7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x49k2-0004TQ-5U; Wed, 09 Sep 2026 00:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x49k0-0004SS-ND
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:16:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x49jz-0006BI-5L
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788927413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CHpcQUCCJu+tD+vNfJRpM6VZ0dUJ1767NnLEKGVwkFA=;
 b=ILAYe0EZ+S+vV7erW4FMgbvrAN6dYQdCCx7+r7fHgISwbclvFMrqW8lG39xM6NcUnA8TYn
 ExNvQq0zIj1n8cetKJvNpGB4kbaI8Ktq3UtCj5Wz9ifEYQhZ4iBI2RqfrsiQ8nJ2NgfgRm
 RBSbqGGMLWO1N0pVPRHgZ/Iv8NymE/4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-IypAGub0OSK6NioBu28OHA-1; Wed,
 09 Sep 2026 00:16:49 -0400
X-MC-Unique: IypAGub0OSK6NioBu28OHA-1
X-Mimecast-MFC-AGG-ID: IypAGub0OSK6NioBu28OHA_1788927407
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32DFC180065F; Wed,  9 Sep 2026 04:16:47 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CCEA21800473; Wed,  9 Sep 2026 04:16:41 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>, Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Hanna Reitz <hreitz@redhat.com>,
 linux-cxl@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 00/10] qapi: convert simple enum intro sections
Date: Wed,  9 Sep 2026 00:16:30 -0400
Message-ID: <20260909041640.69080-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello, this work converts "simple" intro sections for enum=0D
definitions in the QAPI schema to use the new syntax. This is part of=0D
our ongoing effort to add the mythical "inliner" to our generated QMP=0D
documentation.=0D
=0D
"simple" here is a non-technical distinction that means a single=0D
paragraph of text followed by an existing section boundary that=0D
naturally already delineates what comprises the intro.=0D
(This is about 25% of the remaining conversions.)=0D
=0D
If you are a non-QAPI maintainer who has been CC'd on this series,=0D
there is likely very little for you to look at in this series. What=0D
you need to know is that indented paragraphs become part of a=0D
command's "intro" and will appear "above the fold" - above additional=0D
detail in our generated QMP documentation (i.e. features, arguments,=0D
return value, errors, etc) and anything else will eventually appear=0D
"below the fold" - below the detail table, alongside examples, notes,=0D
and more verbose prose.=0D
=0D
As enum definitions cannot be inlined by any other definition, the=0D
documentation text for enums will never be re-written or reproduced in=0D
any other context. As such, the distinction between "intro" and=0D
"details" are less important here, but the distinction does still=0D
determine where auto-generated documentation will be inserted, if any:=0D
features will always be inserted "after the intro". (Note that at=0D
present, features do not have any stub text that is automatically=0D
generated.)=0D
=0D
John Snow (10):=0D
  qapi: convert simple enum intros for vfio.json=0D
  qapi: convert simple enum intros for machine-common.json=0D
  qapi: convert simple enum intros for introspect.json=0D
  qapi: convert simple enum intros for block.json=0D
  qapi: convert simple enum intros for cypto.json=0D
  qapi: convert simple enum intros for cxl.json=0D
  qapi: convert simple enum intros for yank.json=0D
  qapi: convert simple enum intros for migration.json=0D
  qapi: convert simple enum intros for machine.json=0D
  qapi: convert simple enum intros for block-core.json=0D
=0D
 qapi/block-core.json     |  7 +++----=0D
 qapi/block.json          |  9 ++++-----=0D
 qapi/crypto.json         | 18 +++++++++---------=0D
 qapi/cxl.json            | 27 ++++++++++++---------------=0D
 qapi/introspect.json     |  5 ++---=0D
 qapi/machine-common.json |  5 ++---=0D
 qapi/machine.json        | 21 +++++++++------------=0D
 qapi/migration.json      | 10 ++++------=0D
 qapi/vfio.json           | 15 +++++++--------=0D
 qapi/yank.json           |  5 ++---=0D
 10 files changed, 54 insertions(+), 68 deletions(-)=0D
=0D
-- =0D
2.55.0=0D
=0D


