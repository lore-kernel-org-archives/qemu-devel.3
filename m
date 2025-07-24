Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22FFC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 13:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uew3I-0001jz-HV; Thu, 24 Jul 2025 09:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uew2t-0001eU-1p
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 09:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uew2q-0003Oj-9Y
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 09:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753363894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IP82vxLzWgYzmeMEQu/K4hm5xBY1qJLWbAB67U0WW/A=;
 b=KWm0aofo2lTkiNwthUQJeQvZn9c7V5JJtrGt64yGl/ar/+zxQVLC2l5uT+dgQ+QoexGyNH
 DReSPMu2Cj/dcyEm76h9K4KQE238dbcFPcEX8S64ANyatmSqZqvpdUJvq92jgedBE6yR4J
 yHGNf/sPTyuy0B9NAADm8+UcnOzYxUY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-QdDc7-N0PP-Fcjeq_hGYTQ-1; Thu,
 24 Jul 2025 09:31:33 -0400
X-MC-Unique: QdDc7-N0PP-Fcjeq_hGYTQ-1
X-Mimecast-MFC-AGG-ID: QdDc7-N0PP-Fcjeq_hGYTQ_1753363892
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5091A1955D95
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 13:31:32 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D0F721800285; Thu, 24 Jul 2025 13:31:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/7] ppc queue
Date: Thu, 24 Jul 2025 15:31:19 +0200
Message-ID: <20250724133126.1695824-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.45,
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

The following changes since commit 9e601684dc24a521bb1d23215a63e5c6e79ea0bb:

  Update version for the v10.1.0-rc0 release (2025-07-22 15:48:48 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-ppc-20250724

for you to fetch changes up to 0fb961e392e2055adc5429236989b01bb763f12c:

  MAINTAINERS: remove myself as ppc maintainer/reviewer (2025-07-24 15:16:59 +0200)

----------------------------------------------------------------
ppc queue:

* Update maintainers

----------------------------------------------------------------
Aditya Gupta (1):
      MAINTAINERS: Add myself as a reviewer of PowerNV emulation

Chinmay Rath (1):
      MAINTAINERS: Add myself as reviewer for PowerPC TCG CPUs

Cédric Le Goater (1):
      MAINTAINERS: Remove Frédéric as reviewer

Daniel Henrique Barboza (1):
      MAINTAINERS: remove myself as ppc maintainer/reviewer

Gautam Menghani (1):
      MAINTAINERS: Add myself as a reviewer for XIVE

Harsh Prateek Bora (2):
      MAINTAINERS: Adding myself as a co-maintainer for ppc/spapr
      MAINTAINERS: Adding myself as reviewer for PPC KVM cpus.

 MAINTAINERS | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)


