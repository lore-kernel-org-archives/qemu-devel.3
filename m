Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C501C282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 08:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpNCm-0000od-8Z; Tue, 04 Mar 2025 03:00:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpNBn-0000Br-SD
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:59:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tpNBj-0003Iy-Ge
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 02:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741075178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id; bh=+2wlnOgzoKuQXXvNV7uKsZpQFM56z0CTjpwQnIEson0=;
 b=OxpX18dHJY25guL73iyqmEdYptnIpsSX3xmP8wipE1jm/pWQzr6vT/vboZYwP1+xUfyDPu
 Zg9AKZeNyCGkWJGQfgAZ4Uu4FuqZu7Iw/5Upzi52dLerr7oNHSjhd2Xpg12uBKiRI18Eec
 hqVJ8lIhGh0ZdNJO7GtOnNd9Qha3n/4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-138kN39VNDW45kTNo_chLw-1; Tue,
 04 Mar 2025 02:59:21 -0500
X-MC-Unique: 138kN39VNDW45kTNo_chLw-1
X-Mimecast-MFC-AGG-ID: 138kN39VNDW45kTNo_chLw_1741075160
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7C5919560B5
 for <qemu-devel@nongnu.org>; Tue,  4 Mar 2025 07:59:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F2D119560AA
 for <qemu-devel@nongnu.org>; Tue,  4 Mar 2025 07:59:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3078221E66C1; Tue, 04 Mar 2025 08:59:17 +0100 (CET)
Resent-To: qemu-devel@nongnu.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Tue, 04 Mar 2025 08:59:17 +0100
Resent-Message-ID: <87h649w7je.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com Tue Mar  4 08:43:46 2025
Received: from imap.gmail.com ([2a00:1450:4025:402::6d]:993) by
 dusky.pond.sub.org with IMAP4-SSL getmail6 msgid:11/315747; 04 Mar 2025
 07:43:46 -0000
Received: from blackfin.pond.sub.org (p4fd0400e.dip0.t-ipconnect.de.
 [79.208.64.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47a6a4asm16892954f8f.34.2025.03.03.23.21.17
 for <stefanha@redhat.com>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 23:21:17 -0800 (PST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F88521E66C1; Tue, 04 Mar 2025 08:21:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL v2 0/5] QAPI patches patches for 2025-02-26
Date: Tue,  4 Mar 2025 08:21:12 +0100
Message-ID: <20250304072117.894134-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: [Gmail]/All Mail
X-GMAIL-LABELS: "\\Sent"
X-GMAIL-THRID: 1825647233670125359
X-GMAIL-MSGID: 1825647233670125359
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2025-02-22 05:06:39 +0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2025-02-26-v2

for you to fetch changes up to dde279925c97b614e45351400bfcf9efaf732f9d:

  qapi: pluggable backend code generators (2025-03-04 08:02:29 +0100)

----------------------------------------------------------------
QAPI patches patches for 2025-02-26

----------------------------------------------------------------
Daniel P. Berrangé (1):
      qapi: pluggable backend code generators

John Snow (3):
      qapi: update pylintrc config
      docs/qapidoc: support header-less freeform sections
      docs/qapidoc: remove example section support

Roman Penyaev (1):
      qapi/char.json: minor doc rewording for `hub` device

 docs/sphinx/qapidoc.py          | 11 ++----
 qapi/char.json                  |  2 +-
 scripts/qapi/backend.py         | 63 ++++++++++++++++++++++++++++++++
 scripts/qapi/main.py            | 80 +++++++++++++++++++++++------------------
 scripts/qapi/pylintrc           |  1 +
 tests/qapi-schema/doc-good.json |  4 +++
 tests/qapi-schema/doc-good.out  |  3 ++
 7 files changed, 120 insertions(+), 44 deletions(-)
 create mode 100644 scripts/qapi/backend.py

-- 
2.48.1



