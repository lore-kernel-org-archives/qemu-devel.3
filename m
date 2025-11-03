Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF90CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 08:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFprq-0000yD-Bu; Mon, 03 Nov 2025 03:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vFprR-0000vJ-Hh
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:24:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vFprF-0006iI-FN
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762158240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QfpaDePf0aX+1MWAUIxxzKceL0+jDlmEytvJhXDgncw=;
 b=UANWumt2x61JVCTdYJ/pjtD4/5kDWRnEDCyqplO45DoFqEwCBcGEUcjpHuAOD1NKU+SqkV
 reX46DoNPQe36AUuwklgUnai9z+4bIbvt7l23+Ogq0+vzdbI8OPAfk0LwtIBpVtGExzUnM
 /ttzldh0XshncTNrUx2EnRRXpbjTW00=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-j1CUzwfDOvOjorU6r5IjPA-1; Mon,
 03 Nov 2025 03:23:59 -0500
X-MC-Unique: j1CUzwfDOvOjorU6r5IjPA-1
X-Mimecast-MFC-AGG-ID: j1CUzwfDOvOjorU6r5IjPA_1762158238
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63EDA1955F4A; Mon,  3 Nov 2025 08:23:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9402F1956056; Mon,  3 Nov 2025 08:23:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E9F6B21E6A27; Mon, 03 Nov 2025 09:23:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, vsementsov@yandex-team.ru,
 thuth@redhat.com, berrange@redhat.com, philmd@linaro.org,
 kchamart@redhat.com, mst@redhat.com, sgarzare@redhat.com
Subject: [PATCH v2 0/9] A QAPI schema doc markup fix, and style cleanup
Date: Mon,  3 Nov 2025 09:23:45 +0100
Message-ID: <20251103082354.3273027-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Vladimir Sementsov-Ogievskiy recently posted

    Subject: [PATCH v2 00/33] qapi: docs: width=70 and two spaces between sentences 
    Date: Sat, 11 Oct 2025 17:04:06 +0300
    Message-ID: <20251011140441.297246-1-vsementsov@yandex-team.ru>

His series refills doc comments to conform to the 70 width limit,
tidies up spaces between sentences, and adds code to enforce both
going forward.

In review, we agreed to only refill prose, not the examples, at least
for now.  Vladimir volunteered to adjust his validation code,
accordingly.  I volunteered to take care of the doc comment cleanup.

I decided redoing the cleanup would be less work than splitting.
While doing so, I found a markup bug: PATCH 1.  PATCH 2+4 are the
cleanup.  PATCH 3+5 additionally clean up blank lines.

Testing this with his validation code failed:
docs/interop/firmware.json also needs the treatment, and
docs/interop/vhost-user.json would if we bothered to test it.  PATCH
6+7 take care of both.  PATCH 8 adds proper markup to literal blocks,
so that the validation code can skip them.  PATCH 9 adds the missing
test.

Vladimir's revised validation code is here:

    Subject: [PATCH v5] qapi: Add documentation format validation
    Date: Fri, 31 Oct 2025 21:31:29 +0300
    Message-ID: <20251031183129.246814-1-vsementsov@yandex-team.ru>

It builds fine when applied it on top of this series.

v2:
* Rebased
* [PATCH 1]: Commit message tidied up [Vladimir]
* [PATCH 6+7]: "Example" section conversion split off [Vladimir]


Markus Armbruster (9):
  qapi/audio: Fix description markup of AudiodevDBusOptions @nsamples
  qapi: Refill doc comments to conform to conventions
  qapi: Clean up whitespace between definitions
  qga/qapi-schema: Refill doc comments to conform to conventions
  qga/qapi-schema: Clean up whitespace between definitions
  docs/interop: Refill QAPI doc comments to conform to conventions
  docs/interop/firmware: Belatedly convert "Example" section
  docs/interop/firmware: Literal block markup
  docs/interop: Add test to keep vhost-user.json sane

 docs/interop/firmware.json   | 454 +++++++++++++++++------------------
 docs/interop/vhost-user.json |  59 +++--
 docs/meson.build             |   9 +-
 qapi/accelerator.json        |   3 +-
 qapi/acpi-hest.json          |   5 +-
 qapi/audio.json              |   4 +-
 qapi/block-core.json         | 158 ++++++------
 qapi/block-export.json       |  26 +-
 qapi/char.json               |   1 -
 qapi/crypto.json             |   8 +-
 qapi/cxl.json                |   1 -
 qapi/introspect.json         |   8 +-
 qapi/job.json                |  30 +--
 qapi/machine-common.json     |   4 +-
 qapi/machine-s390x.json      |   4 +-
 qapi/machine.json            |  49 ++--
 qapi/migration.json          | 126 +++++-----
 qapi/misc-i386.json          |   2 -
 qapi/net.json                |  26 +-
 qapi/qdev.json               |   4 +-
 qapi/qom.json                |  47 ++--
 qapi/run-state.json          |  20 +-
 qapi/sockets.json            |  30 +--
 qapi/stats.json              |   4 +-
 qapi/ui.json                 |  17 +-
 qapi/virtio.json             |   6 +-
 qga/qapi-schema.json         |  96 ++++----
 27 files changed, 623 insertions(+), 578 deletions(-)

-- 
2.49.0


