Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797B2C88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4olS-0007k8-EI; Thu, 10 Sep 2026 20:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x4lYL-0006rO-Eb
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x4lYE-00058F-4H
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6rl/RAWzFReRMV1FRVpVev9fcXwjw8ZA3ctJAlmn/ko=;
 b=MzDOYStpNmBhqaKiQIJ/CWQBwXdJDZaLzI77wyKOf/ZahT6toT8vniv/qLPpa8IGfZ4sjN
 edunn68vxN/tgyk0APFsNPAQvziqLDUx8T6EiPtaS5paT/+Gq2RZO0Cod5JRRlfJn3nihJ
 kfFi8YZ0wYQm+r5+Nk0UKyp9VE+McOM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-PfjfOswTMEiOq0qcOWd0WA-1; Thu,
 10 Sep 2026 16:39:03 -0400
X-MC-Unique: PfjfOswTMEiOq0qcOWd0WA-1
X-Mimecast-MFC-AGG-ID: PfjfOswTMEiOq0qcOWd0WA_1789072742
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4E5118002AB; Thu, 10 Sep 2026 20:39:01 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.67])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C776B46E; Thu, 10 Sep 2026 20:38:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Igor Mammedov <imammedo@redhat.com>, linux-cxl@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Markus Armbruster <armbru@redhat.com>, Jonathan Cameron <jic23@kernel.org>,
 qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 00/10] qapi: convert simple data struct/alternate intro
 sections
Date: Thu, 10 Sep 2026 16:38:46 -0400
Message-ID: <20260910203856.99003-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello, this work converts "simple" intro sections for data struct=0D
definitions (and one alternate) in the QAPI schema to use the new=0D
syntax. This is part of our ongoing effort to add the mythical=0D
"inliner" to our generated QMP documentation.=0D
=0D
"simple" here is a non-technical distinction that means a single=0D
paragraph of text followed by an existing section boundary that=0D
naturally already delineates what comprises the intro.=0D
(This is about 25% of the remaining conversions.)=0D
=0D
"data struct" is another non-technical distinction that means a QAPI=0D
struct that is not used as a branch, argument definition, or the basis=0D
of another struct. In effect, it is only "data" and as a result, is=0D
not *currently* a candidate to be inlined into any other definition.=0D
=0D
Documentation that is to be "inlined"-- to be written into another=0D
definition's documentation-- needs to ensure that the documentation=0D
written in the "intro" segment is not crucial to understanding the=0D
behavior of the individual members. The "intro" does not get inlined,=0D
but the rest of the documentation does. These "data structs" as=0D
isolated in this series currently are not eligible to be inlined. As=0D
such, the precise distinction between intro and details for these=0D
definitions is not presently as crucial - however, these structs may=0D
become inlined in the future, so a closer eye is still warranted.=0D
=0D
If you are a non-QAPI maintainer who has been CC'd on this series, you=0D
may wish to review what information is being counted as the "intro"=0D
(The indented paragraph) and keep in mind that in the future, this=0D
text may not be visible to the end-user reading our QMP documentation=0D
if this structure is utilized as the 'base' for another struct, used=0D
as the arguments for a command or event, or used as branch of a=0D
union. This series keeps it pretty simple, and every conversion herein=0D
is being codified as "the intro", i.e. "not crucial to understanding=0D
the behavior of the members of this struct".=0D
=0D
John Snow (10):=0D
  qapi: convert simple data struct intros for uefi.json=0D
  qapi: convert simple data struct intros for misc-arm.json=0D
  qapi: convert simple data struct intros for acpi.json=0D
  qapi: convert simple data struct intros for run-state.json=0D
  qapi: convert simple data struct intros for yank.json=0D
  qapi: convert simple data struct intros for cxl.json=0D
  qapi: convert simple data struct intros for virtio.json=0D
  qapi: convert simple data struct intros for machine.json=0D
  qapi: convert simple data struct intros for block-core.json=0D
  qapi: convert simple alternate intros for common.json=0D
=0D
 qapi/acpi.json       |  7 +++----=0D
 qapi/block-core.json | 37 ++++++++++++++++---------------------=0D
 qapi/common.json     |  7 +++----=0D
 qapi/cxl.json        |  7 +++----=0D
 qapi/machine.json    | 12 +++++-------=0D
 qapi/misc-arm.json   |  9 ++++-----=0D
 qapi/run-state.json  |  7 +++----=0D
 qapi/uefi.json       |  5 ++---=0D
 qapi/virtio.json     | 37 ++++++++++++++++---------------------=0D
 qapi/yank.json       | 10 ++++------=0D
 10 files changed, 59 insertions(+), 79 deletions(-)=0D
=0D
-- =0D
2.55.0=0D
=0D


