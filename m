Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25B3C87FCA
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 06:27:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugdnf-0007fJ-2y; Tue, 29 Jul 2025 02:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugdnS-0007al-GS
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:26:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugdnQ-0007Qq-R8
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753770403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5fqiQa8mSEVA8dpwrTyXFiqCe17+Fg/6kHK32FuFa1s=;
 b=F4SStCFyGyFljE8f0phIPEiGvbZNyO+U1PCK0S0pZ3uVHQ34OIldQ/lff+4DqF5bkS/GR8
 2k1vWhP6TiaCgLcJVgi3jbCT5h3tEsX7B8KpBdRw+xhe+c7be/5QtaxpW/oqB96XINman5
 Ao2/1bAW4gYw9KvGX1O98uDeIgTMq2I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-486-V81_RYUBPJ2rWlkWL4ikeA-1; Tue,
 29 Jul 2025 02:26:41 -0400
X-MC-Unique: V81_RYUBPJ2rWlkWL4ikeA-1
X-Mimecast-MFC-AGG-ID: V81_RYUBPJ2rWlkWL4ikeA_1753770400
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F34CC1800256
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 06:26:39 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.29])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2AC951955F16; Tue, 29 Jul 2025 06:26:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/5] vfio queue
Date: Tue, 29 Jul 2025 08:26:28 +0200
Message-ID: <20250729062633.452522-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 92c05be4dfb59a71033d4c57dac944b29f7dabf0:

  Merge tag 'pull-qga-2025-07-28' of https://repo.or.cz/qemu/armbru into staging (2025-07-28 09:31:19 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20250729

for you to fetch changes up to 0db7e4cb62026196f06755c77f943294d9879e5a:

  vfio/igd: Fix VGA regions are not exposed in legacy mode (2025-07-28 17:52:34 +0200)

----------------------------------------------------------------
vfio queue:

* Fixed regression introduced by the `use-legacy-x86-rom` property
* Fixed regressions on IGD passthrough in legacy mode
* Fixed region mappings of sub-page BARs after CPR
* Removed build of SEV on 32-bit hosts

----------------------------------------------------------------
Cédric Le Goater (2):
      hw/i386: Fix 'use-legacy-x86-rom' property compatibility
      i386: Build SEV only for 64-bit target

Steve Sistare (1):
      vfio: fix sub-page bar after cpr

Tomita Moeko (2):
      vfio/igd: Require host VGA decode for legacy mode
      vfio/igd: Fix VGA regions are not exposed in legacy mode

 docs/igd-assign.txt |  1 +
 hw/vfio/pci.h       |  2 ++
 hw/vfio/types.h     |  2 ++
 hw/core/machine.c   |  2 +-
 hw/i386/microvm.c   |  2 +-
 hw/i386/pc_piix.c   |  2 +-
 hw/i386/pc_q35.c    |  2 +-
 hw/vfio/cpr.c       |  2 ++
 hw/vfio/igd.c       | 19 ++++++++++++-------
 hw/vfio/pci.c       | 29 ++++++++++++++++++++++++-----
 hw/i386/Kconfig     |  2 +-
 11 files changed, 48 insertions(+), 17 deletions(-)


