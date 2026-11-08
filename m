Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717F6606A320
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L91oacFW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPyfh-00039i-VE; Sun, 08 Nov 2026 03:54:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyff-00037j-9Z
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:39 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfc-0000va-Hh
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:38 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1DDEC4363B;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40621F0089F;
 Sun,  8 Nov 2026 08:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794128075;
 bh=u0jUfLYGHmTJKlqAJnMjIixgonBhWmwwfi1Y/EWZfAg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=L91oacFWJhg7obp5TghRm7rIa46l8UIdmG3iDbMWMDZkPZP/1qnzm4j5IJwZmuljq
 9SrkAbJyN3+aUKRNgLOsgRvMAXVgBHDuUF6f3oWA5uYhXWHtkmRNeBWW5Bt1kNP4SZ
 etJV1SK/VDR5tDbiU+X4ChoVGDlvzAWJYKUmY+049Tp1J8CB1gStjt3cey8dm7rFDG
 PtPkNjQkCFaZJTrHgU4cAp8k5QEFCvunIXkefckwSu3+xrKcxyt+1392ivSeqPlUIq
 dGlWtELACaoinqqU0d7K0HyP58Mhypw+PX+S2sXINCLrYWefzmbJWZQZCQyd442//W
 cPHtpx2sIJf0g==
Received: from mchehab by mail.kernel.org with local (Exim 4.100.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfZ-00000005Uip-12aC; Sun, 08 Nov 2026 09:54:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH 03/13] scripts/qmp_helper: add support for FRU Memory Poison
Date: Sun,  8 Nov 2026 09:54:16 +0100
Message-ID: <66ea0a7cb79ea17a06217d56b82b00c21de4565f.1794127710.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794127710.git.mchehab+huawei@kernel.org>
References: <cover.1794127710.git.mchehab+huawei@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This GUID record descriptor was added on UEFI 2.11.
Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 scripts/qmp_helper.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index f51a06bad8d4..7190c988558a 100755
--- a/scripts/qmp_helper.py
+++ b/scripts/qmp_helper.py
@@ -736,3 +736,7 @@ class cper_guid:
     CPER_CXL_EVT_DYNA_CAP = guid(0xCA95AFA7, 0xF183, 0x4018,
                                  [0x8C, 0x2F, 0x95, 0x26,
                                   0x8E, 0x10, 0x1A, 0x2A])
+
+    CPER_FRU_MEM_POISON = guid(0x5E4706C1, 0x5356, 0x48C6,
+                               [0x93, 0x0B, 0x52, 0xF2,
+                                0x12, 0x0A, 0x44, 0x58])
-- 
2.56.0


