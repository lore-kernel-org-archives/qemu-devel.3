Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2108CC87FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Aug 2025 16:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ul8Ua-0001UP-I6; Sun, 10 Aug 2025 12:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ul8UG-0001KV-SN
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 12:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ul8UD-0008Jv-Ep
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 12:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754841686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BI6H815v8KS5qSpP+hqQD7mbY6YkRLBI1FMbEtJWHnw=;
 b=MMQTvg7gtHLWoq9KAaGU4L9WtCG1qX1Vfpnpay+oTNS6jzi12UB8cqgujLNG7EW7+jSCTz
 JTDpy00G9QxiCurKEJg/EN3ocUyCYMaeNVV+Cl46uKMKeVsp23XvurEt8kZkcq8uEKEUr5
 i9rCbaMWIyrPPBEQxMEsRoPY67aUZ3I=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-muZ1Zye-PliV4EPmd9xWQQ-1; Sun,
 10 Aug 2025 12:01:24 -0400
X-MC-Unique: muZ1Zye-PliV4EPmd9xWQQ-1
X-Mimecast-MFC-AGG-ID: muZ1Zye-PliV4EPmd9xWQQ_1754841684
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C033F195609D
 for <qemu-devel@nongnu.org>; Sun, 10 Aug 2025 16:01:23 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.11])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 714923001455; Sun, 10 Aug 2025 16:01:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/3] vfio queue
Date: Sun, 10 Aug 2025 18:01:15 +0200
Message-ID: <20250810160118.450430-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit a74434580e1051bff12ab5eee5586058295c497f:

  Merge tag 'pull-loongarch-20250808' of https://github.com/gaosong715/qemu into staging (2025-08-08 09:49:06 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20250810

for you to fetch changes up to d9f4b45713e4e000a42ed1f33cb06b806173b559:

  vfio: Document 'use-legacy-x86-rom' property (2025-08-09 00:06:48 +0200)

----------------------------------------------------------------
vfio queue:

* Add documentation for the use-legacy-x86-rom property
* Preserve pending VFIO interrupts during CPR

----------------------------------------------------------------
Cédric Le Goater (1):
      vfio: Document 'use-legacy-x86-rom' property

Steve Sistare (2):
      vfio/pci: augment set_handler
      vfio/pci: preserve pending interrupts

 hw/vfio/pci.h              |  4 +-
 include/hw/vfio/vfio-cpr.h |  6 +++
 hw/vfio/cpr.c              | 93 +++++++++++++++++++++++++++++++++++++++++++++-
 hw/vfio/pci.c              | 18 ++++++++-
 4 files changed, 117 insertions(+), 4 deletions(-)


