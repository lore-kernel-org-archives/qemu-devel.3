Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C84C55175
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 13:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqWiQ-0003ev-Jv; Sun, 02 Aug 2026 09:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wqWiN-0003eW-VP
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 09:58:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wqWiM-0002w0-Ci
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 09:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785679132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TNFD38u0rw68I7RAfUBGkRxN10CA2c4sPdJYnQw1yrE=;
 b=JRZqhp12c6TfAKe2a5BESa9LzGZjI8g0eVoBm/uITcKb1Gz/xU3iI0AdoE91Wb2kLyqK9D
 vQuEfkYbUM5TsHYopoSyXq59yVtzskyqBxfiwK0ssJVAhMFJ2IBignWoPhgqIAfrG7mt5H
 nCtVJ7lK7zQXCRG8LfBFYngNwnhAfUw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-a4BppoUiNWCp7fXGsw1y4A-1; Sun,
 02 Aug 2026 09:58:50 -0400
X-MC-Unique: a4BppoUiNWCp7fXGsw1y4A-1
X-Mimecast-MFC-AGG-ID: a4BppoUiNWCp7fXGsw1y4A_1785679129
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D89D1800350
 for <qemu-devel@nongnu.org>; Sun,  2 Aug 2026 13:58:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.25])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B14630002E9; Sun,  2 Aug 2026 13:58:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 0/2] vfio queue
Date: Sun,  2 Aug 2026 15:58:44 +0200
Message-ID: <20260802135846.328866-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

The following changes since commit b428fe036233cbd15d37e3c027ab6ca4d3661a80:

  Merge tag 'pull-target-arm-20260731' of https://gitlab.com/pm215/qemu into staging (2026-07-31 16:19:04 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20260802

for you to fetch changes up to 338d81b22b4dc6c45299da1114925a4b086d6e00:

  vfio/pci: Guard accel_irqchip_begin_route_changes() calls (2026-08-02 15:53:05 +0200)

----------------------------------------------------------------
vfio queue:

* Fix accel_irqchip_begin_route_changes() abort under TCG
* Fix SIGSEGV in vfio_connect_kvm_msi_virq() during loadvm

----------------------------------------------------------------
Cédric Le Goater (1):
      vfio/pci: Guard accel_irqchip_begin_route_changes() calls

Tycho Andersen (AMD) (1):
      hw/vfio: Fix liveness check in vfio_connect_kvm_msi_virq()

 hw/vfio/pci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)


