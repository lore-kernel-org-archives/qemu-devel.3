Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A36C61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x18UK-0007V7-6O; Mon, 31 Aug 2026 16:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x18UI-0007US-Fg
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 16:20:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x18UD-0007FN-TU
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 16:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788207609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VTKbCZqJIq+C9hQ9iubao4nwFmrh6uAcc4E13Ha33cg=;
 b=YnMqnX8gS4JT2BvIpXjYNCO2RpgVfnh0qQDWMe9VEa0a/5sovRp0WvZP4IC5CyaUhGbfgp
 JUSAN2bNWGt94XEp2Oh/opZBB4c94v8u3rVmV5djUAVuUFgVzYoaEeN4eRxo6PbMYvoOzR
 +uWVZ3MVbq88iUmnBgz25CkV8+0hP9o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-wHjEGSbwPwid_ycwm4CqUQ-1; Mon,
 31 Aug 2026 16:20:04 -0400
X-MC-Unique: wHjEGSbwPwid_ycwm4CqUQ-1
X-Mimecast-MFC-AGG-ID: wHjEGSbwPwid_ycwm4CqUQ_1788207601
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 012BE184BAB6; Mon, 31 Aug 2026 20:19:58 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 547631800577; Mon, 31 Aug 2026 20:19:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 zhenwei pi <zhenwei.pi@linux.dev>, Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, linux-cxl@vger.kernel.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 linux-edac@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-trivial@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 00/43] qapi: convert (very) trivial intro sections
Date: Mon, 31 Aug 2026 16:19:02 -0400
Message-ID: <20260831201945.287730-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

v4:=0D
 - Added r-b's from various folks=0D
 - Dropped a few conversion cases that were just simply not trivial enough.=
=0D
=0D
   If you are a non-qapi/non-docs maintainer being CC'd on this patch,=0D
   there is **very likely** nothing for you to do here; we are only=0D
   changing spacing and syntax, but not modifying content in any way=0D
   in this series in particular. Please feel free to mark-as-read and=0D
   move on with your day.=0D
=0D
v3:=0D
   As per Markus' request, the intro section conversion has been split=0D
   even further into the *very* trivial; leaving the semi-trivial and=0D
   not-trivial conversions for later consideration.=0D
=0D
-=0D
=0D
Hi, this patchset converts trivial "introductory" sections in the QAPI=0D
documentation to use the new, explicit intro section syntax.=0D
=0D
This is being done primarily for the benefit of the forthcoming=0D
"inliner", a feature for the rendered HTML QMP documentation that=0D
seeks to "inline" QMP command argument documentation into the argument=0D
list for each command.=0D
=0D
There are two main motives here:=0D
=0D
(1) We want the split between the "introduction" and "details"=0D
    sections to be mechanically obvious, so that auto-generated or=0D
    inlined documentation has a well-defined, obvious spot to go.=0D
=0D
(2) We do not want to inline irrelevant, introductory text describing=0D
    structures to be copied into command documentation.=0D
=0D
This patchset tackles "very trivial" conversions: cases where the=0D
existing leading plaintext is only a single sentence and is=0D
immediately followed by a tagged section, the end of the documentation=0D
block, or some other pre-existing syntactical delineation. (i.e.: not=0D
more plaintext.)=0D
=0D
NOTE: This series *may* miss some conversions; future QAPI changes will=0D
enforce the new syntax and any cases that have appeared since v1 will=0D
be identified and corrected at that time; we are concerned with the=0D
bulk and ease-of-review here, not completeness. This is precisely why=0D
the new intro syntax and parser were carefully designed to allow=0D
gradual conversion.=0D
=0D
NOTE2: Future patches that may require more scrutiny will handle the=0D
remaining conversions - There are some very subtle concerns that are=0D
not readily apparent in the very minor textual changes that will be=0D
spelled out for reviewers in the cover letters for those series.=0D
=0D
This is enough for today, don't you think?=0D
=0D
John Snow (43):=0D
  qapi: convert trivial intro sections for error.json=0D
  qapi: convert trivial intro sections for acpi-hest.json=0D
  qapi: convert trivial intro sections for ebpf.json=0D
  qapi: convert trivial intro sections for compat.json=0D
  qapi: convert trivial intro sections for vfio.json=0D
  qapi: convert trivial intro sections for trace.json=0D
  qapi: convert trivial intro sections for misc-arm.json=0D
  qapi: convert trivial intro sections for cryptodev.json=0D
  qapi: convert trivial intro sections for machine-common.json=0D
  qapi: convert trivial intro sections for accelerator.json=0D
  qapi: convert trivial intro sections for authz.json=0D
  qapi: convert trivial intro sections for yank.json=0D
  qapi: convert trivial intro sections for replay.json=0D
  qapi: convert trivial intro sections for machine-s390x.json=0D
  qapi: convert trivial intro sections for acpi.json=0D
  qapi: convert trivial intro sections for tpm.json=0D
  qapi: convert trivial intro sections for qdev.json=0D
  qapi: convert trivial intro sections for control.json=0D
  qapi: convert trivial intro sections for dump.json=0D
  qapi: convert trivial intro sections for common.json=0D
  qapi: convert trivial intro sections for sockets.json=0D
  qapi: convert trivial intro sections for transaction.json=0D
  qapi: convert trivial intro sections for stats.json=0D
  qapi: convert trivial intro sections for job.json=0D
  qapi: convert trivial intro sections for pci.json=0D
  qapi: convert trivial intro sections for introspect.json=0D
  qapi: convert trivial intro sections for rocker.json=0D
  qapi: convert trivial intro sections for misc-i386.json=0D
  qapi: convert trivial intro sections for block-export.json=0D
  qapi: convert trivial intro sections for audio.json=0D
  qapi: convert trivial intro sections for block.json=0D
  qapi: convert trivial intro sections for misc.json=0D
  qapi: convert trivial intro sections for crypto.json=0D
  qapi: convert trivial intro sections for cxl.json=0D
  qapi: convert trivial intro sections for run-state.json=0D
  qapi: convert trivial intro sections for char.json=0D
  qapi: convert trivial intro sections for virtio.json=0D
  qapi: convert trivial intro sections for net.json=0D
  qapi: convert trivial intro sections for qom.json=0D
  qapi: convert trivial intro sections for ui.json=0D
  qapi: convert trivial intro sections for migration.json=0D
  qapi: convert trivial intro sections for machine.json=0D
  qapi: convert trivial intro sections for block-core.json=0D
=0D
 qapi/accelerator.json    |  18 +-=0D
 qapi/acpi-hest.json      |   4 +-=0D
 qapi/acpi.json           |   8 +-=0D
 qapi/audio.json          |  88 +++-----=0D
 qapi/authz.json          |  21 +-=0D
 qapi/block-core.json     | 431 ++++++++++++++-------------------------=0D
 qapi/block-export.json   |  50 ++---=0D
 qapi/block.json          |  41 ++--=0D
 qapi/char.json           |  90 +++-----=0D
 qapi/common.json         |  29 +--=0D
 qapi/compat.json         |   6 +-=0D
 qapi/control.json        |  30 +--=0D
 qapi/crypto.json         | 100 ++++-----=0D
 qapi/cryptodev.json      |  18 +-=0D
 qapi/cxl.json            |   6 +-=0D
 qapi/dump.json           |  19 +-=0D
 qapi/ebpf.json           |   6 +-=0D
 qapi/error.json          |   3 +-=0D
 qapi/introspect.json     |  40 ++--=0D
 qapi/job.json            |  18 +-=0D
 qapi/machine-common.json |  14 +-=0D
 qapi/machine-s390x.json  |  13 +-=0D
 qapi/machine.json        | 195 ++++++------------=0D
 qapi/migration.json      | 131 +++++-------=0D
 qapi/misc-arm.json       |   6 +-=0D
 qapi/misc-i386.json      |  52 ++---=0D
 qapi/misc.json           |  74 +++----=0D
 qapi/net.json            |  92 +++------=0D
 qapi/pci.json            |  27 +--=0D
 qapi/qdev.json           |  14 +-=0D
 qapi/qom.json            | 150 +++++---------=0D
 qapi/replay.json         |   6 +-=0D
 qapi/rocker.json         |  39 ++--=0D
 qapi/run-state.json      | 113 ++++------=0D
 qapi/sockets.json        |  31 ++-=0D
 qapi/stats.json          |  34 ++-=0D
 qapi/tpm.json            |  29 +--=0D
 qapi/trace.json          |  12 +-=0D
 qapi/transaction.json    |  14 +-=0D
 qapi/ui.json             | 199 ++++++------------=0D
 qapi/vfio.json           |   4 +-=0D
 qapi/virtio.json         |  54 ++---=0D
 qapi/yank.json           |   5 +-=0D
 43 files changed, 833 insertions(+), 1501 deletions(-)=0D
=0D
-- =0D
2.55.0=0D
=0D


