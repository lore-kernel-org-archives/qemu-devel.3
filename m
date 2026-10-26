Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4273606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2swD1rM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHjP-0000hJ-Ne; Mon, 26 Oct 2026 06:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHiZ-0008Vu-Vx; Mon, 26 Oct 2026 06:14:20 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHiW-0001YY-Fo; Mon, 26 Oct 2026 06:14:13 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2AE5160A64;
 Mon, 26 Oct 2026 10:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B6781F01825;
 Mon, 26 Oct 2026 10:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793009650;
 bh=K/5okVc3H25Vjl+GBSjw9bpgOOlXYj+bjJdzAvb30IY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=g2swD1rMxTUxNVC/0osvsaKNpbDz4wFhZYlZeHHxp9xNmWToO2WV0jprnp2Vjluhj
 Ckzs7iT4ZtL0sU4f+Nrw1ihm+Rx70sCeKCGw7zu9n3wybDqIhN40m8JbmdnXKc9mqs
 cLVOmQ1/V8eFBXX0l6k6ouFrVkfNFyWxOgNwHgV5F6SeQfrawUGnm8CxyFzd4ivi52
 x1r0l9R9cbuBtJjy84S0lDHMKmFk50I5BfweL4Jy0eu8VYQzm4m6hO3nYnIdVAhF6P
 sY1XKw0Ei0jKIjveLabIJs6b/wKygtRHghxCdzsSSs3i7mBGImWjjfEU35gSMXwK1N
 Z2PhOOQ+jGrHw==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Mon, 26 Oct 2026 11:13:57 +0100
Subject: [PATCH RESEND 2/5] hw/nvme: add missing atomic.* fields in usage
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-nvme-mam-v1-2-5d53b5529ffa@samsung.com>
References: <20261026-nvme-mam-v1-0-5d53b5529ffa@samsung.com>
In-Reply-To: <20261026-nvme-mam-v1-0-5d53b5529ffa@samsung.com>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 Daniel Gomez <da.gomez@kernel.org>, Daniel Gomez <da.gomez@samsung.com>, 
 GOST <gost.dev@samsung.com>, qemu-block@nongnu.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793009644; l=1619;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=aAftdHixIF17PP6pzbuHHVFqMHxrLGpY3QQFqJzk7iU=;
 b=zI+4o1eB+jM708KXS/dM5SG+CvbL+MQI69oNL7p/fwuxYM+VcdYtmIMMDe2Gjf/9T0squKmHt
 0eVP9UY8ucYCAJl5CY7Z7oq61o4iWjPW4uOmZD7rbkbqs6lez5IX3i5
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=da.gomez@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel Gomez <da.gomez@samsung.com>

Add the missing atomic.* namespace fields in the usage comment section.
While at it, fix the missing '=' in the atomic.{awun,awupf} fields.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 hw/nvme/ctrl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index c884ca8a181..3baf57af634 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -41,8 +41,8 @@
  *              sriov_max_vi_per_vf=<N[optional]> \
  *              sriov_max_vq_per_vf=<N[optional]> \
  *              atomic.dn=<on|off[optional]>, \
- *              atomic.awun<N[optional]>, \
- *              atomic.awupf<N[optional]>, \
+ *              atomic.awun=<N[optional]>, \
+ *              atomic.awupf=<N[optional]>, \
  *              subsys=<subsys_id>, \
  *              model=<model-str>, \
  *              firmware-version=<version-str>
@@ -55,7 +55,12 @@
  *              zoned.descr_ext_size=<N[optional]>, \
  *              zoned.max_active=<N[optional]>, \
  *              zoned.max_open=<N[optional]>, \
- *              zoned.cross_read=<true|false[optional]>
+ *              zoned.cross_read=<true|false[optional]>, \
+ *              atomic.nabo=<N[optional]>, \
+ *              atomic.nabsn=<N[optional]>, \
+ *              atomic.nabspf=<N[optional]>, \
+ *              atomic.nawun=<N[optional]>, \
+ *              atomic.nawupf=<N[optional]>
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now. By default, the

-- 
2.56.0


