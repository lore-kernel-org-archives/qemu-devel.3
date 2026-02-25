Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BBEFD3764
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 15:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvGN4-00015N-D8; Wed, 25 Feb 2026 10:00:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guix@demindiro.com>)
 id 1vvGMj-000108-52
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:59:53 -0500
Received: from mail.salt-inc.org ([104.244.79.104] helo=vm0.salt-inc.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guix@demindiro.com>)
 id 1vvGMc-0008MU-JC
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:59:50 -0500
Received: from localhost (209.60-130-109.adsl-dyn.isp.belgacom.be
 [109.130.60.209])
 by vm0.salt-inc.org (Postfix) with ESMTPSA id 6BEBCFF01C;
 Wed, 25 Feb 2026 15:58:32 +0100 (CET)
From: David Hoppenbrouwers <qemu@demindiro.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 David Hoppenbrouwers <qemu@demindiro.com>
Subject: [PATCH 0/2] hw/i386/amd_iommu: fix incorrect page_size hugepages
Date: Wed, 25 Feb 2026 15:58:29 +0100
Message-ID: <20260225145831.28275-1-qemu@demindiro.com>
X-Mailer: git-send-email 2.52.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.244.79.104; envelope-from=guix@demindiro.com;
 helo=vm0.salt-inc.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

I have observed the IOMMU using the page size for the next level instead of
the current level for hugepages, e.g. using 4K for what should be 2M pages.

The issue can be observed under Linux, but only with specific settings as
Linux tends to set NextLevel=7, which directly sets the page size after
the walk.

David Hoppenbrouwers (2):
  hw/i386/amd_iommu.c: trace page walk in fetch_pte()
  hw/i386/amd_iommu.c: fix incorrect page_size for hugepages

 hw/i386/amd_iommu.c  | 21 ++++++++++++++++++---
 hw/i386/trace-events |  4 ++++
 2 files changed, 22 insertions(+), 3 deletions(-)

-- 
2.52.0


