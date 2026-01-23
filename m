Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DA0D74ECF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjHKC-0007Qm-So; Fri, 23 Jan 2026 08:35:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHKA-0007Pe-PV
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:35:42 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHK9-0004br-8X
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:35:42 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C642143ADE;
 Fri, 23 Jan 2026 13:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CAAC4CEF1;
 Fri, 23 Jan 2026 13:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769175339;
 bh=WozSB70hw7l0eF2mGi4LJ5e4z/TSg/23OXqKtZSZe/4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sAxZBm1LnfThR4wpC1XcIG1osVjYzQYtn5NZOBF3os796VaTEr3LD8MmcBQxcgtEB
 saVjgVYG3KUf8g1YJN5qmXmFLUz4CnQ6YKdOnNKdoQEuuALtU4XNjWpyP4t3FIit11
 TSceiaqp8iL1sIVZRSn5Ib2CQaYF+G2sSH72IxV+o+bNsCSbzbAe69ppRdxtfaLYaI
 WZQFdZ0QI2X9gXQKr+VizAhjzlvhD3l02CneIGsROosAZJvZtjGjZoNzPVITC7ckPS
 NAZlKBKyjAcGZ1heBLaP/TMd1TupAhKC5WVusVFuYPE2PjGxjWTfdLiMz8z3N/yPus
 bIdDSckAfQoYg==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHK5-000000063Jf-3OSj; Fri, 23 Jan 2026 14:35:37 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 03/13] scripts/qmp_helper: add support for FRU Memory Poison
Date: Fri, 23 Jan 2026 14:35:17 +0100
Message-ID: <ab434dde331d38a13fea45af33e3d74b76180781.1769175069.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769175069.git.mchehab+huawei@kernel.org>
References: <cover.1769175069.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This GUID record descriptor was added on UEFI 2.11.
Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 scripts/qmp_helper.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index 46b85d68b793..d37fb0ae11cc 100755
--- a/scripts/qmp_helper.py
+++ b/scripts/qmp_helper.py
@@ -741,3 +741,7 @@ class cper_guid:
     CPER_CXL_EVT_DYNA_CAP = guid(0xCA95AFA7, 0xF183, 0x4018,
                                  [0x8C, 0x2F, 0x95, 0x26,
                                   0x8E, 0x10, 0x1A, 0x2A])
+
+    CPER_FRU_MEM_POISON = guid(0x5E4706C1, 0x5356, 0x48C6,
+                               [0x93, 0x0B, 0x52, 0xF2,
+                                0x12, 0x0A, 0x44, 0x58])
-- 
2.52.0


