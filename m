Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8348D606A321
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijI7CU61
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLHjT-0001C2-U7; Mon, 26 Oct 2026 06:15:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHif-00006U-Om; Mon, 26 Oct 2026 06:14:27 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <da.gomez@kernel.org>)
 id 1xLHid-0001ZY-Rr; Mon, 26 Oct 2026 06:14:21 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C780860A66;
 Mon, 26 Oct 2026 10:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85B51F031E0;
 Mon, 26 Oct 2026 10:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793009657;
 bh=ahDBAcdga1S/2B6Tw5tJfRlx9nuZKMSjr9vprPEJgiA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ijI7CU61IM0Om05Ty36Hz16k5VcMjpEJd4wrTxSDAWXiRM8hu0Rx+FiyrEwyOgjrv
 xO4SQPsRwCaI5QU0hNFPyvvTGQafE2xH1pM+0NXL7IOcF9RDz0Hibg6oq8J8rgBZhY
 aXa2W5wkxMsJJ9hUH4t4f9fWDXM2Ts9J1vJUtVsDH3YWjmmE+kFsqqh6FHn16fCT9I
 kfZYwRukOz2NaYdpySlFJTucKTeB56wQl7313CIgBL3eHB7utdQsBx35DN9qrgyPyn
 nThGa+py1EbTRjFYkMb1BWZEdyG6oe7nMuhyQcRk0z5pJrGfzDQ/m/lg7U8HUirxu1
 eXHel2MOCXu6Q==
From: Daniel Gomez <da.gomez@kernel.org>
Date: Mon, 26 Oct 2026 11:14:00 +0100
Subject: [PATCH RESEND 5/5] docs: update hw/nvme atomics with mam
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-nvme-mam-v1-5-5d53b5529ffa@samsung.com>
References: <20261026-nvme-mam-v1-0-5d53b5529ffa@samsung.com>
In-Reply-To: <20261026-nvme-mam-v1-0-5d53b5529ffa@samsung.com>
To: qemu-devel@nongnu.org
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>, 
 Klaus Jensen <k.jensen@samsung.com>, Jesper Devantier <foss@defmacro.it>, 
 Daniel Gomez <da.gomez@kernel.org>, Daniel Gomez <da.gomez@samsung.com>, 
 GOST <gost.dev@samsung.com>, qemu-block@nongnu.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793009644; l=997;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=Oo2lrPGQ8PGX98dEUiRpXkDvWBr+YfCCc7GFeijoINg=;
 b=wKTnavC6oHCY4Kqr48LqUDzl3nDtlANUfbtGnMjRDfLYiVVju+QxQlqTl5L8L3pg82r4t6/HB
 DD8Zws/4LOqAmak1o8Zo3VMVfcptWgt7dfWXheRF/X098/Og+X+dQZt
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

Update hw/nvme atomics section with Multiple Atomicity Mode (MAM)
namespace parameter.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 docs/system/devices/nvme.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index ab3bb395ab4..6a6eb918e71 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -405,6 +405,12 @@ values are in logical block units.
 
 Namespace specific Atomic Boundaries parameters for ``nvme-ns`` devices:
 
+``atomic.mam=BOOL`` (default: ``off``)
+  Set the Multiple Atomicity Mode (``MAM``). ``off`` means the controller
+  works in Single Atomicity Mode ``SAM``. When ``MAM`` is enabled, a write that
+  crosses the Namespace Atomic Boundary is divided into atomic LBA subranges,
+  each written atomically at those boundaries.
+
 ``atomic.nabo=UINT16`` (default: ``0``)
   Set the Namespace Atomic Boundary Offset (``NABO``).
 

-- 
2.56.0


