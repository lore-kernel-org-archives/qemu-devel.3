Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9927C44503
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWLa-0003Ck-1s; Wed, 21 Jan 2026 06:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1viWLF-0002rT-Ao
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:25:42 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1viWLB-0007n9-Qa
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:25:40 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 76940600CB;
 Wed, 21 Jan 2026 11:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74F8C2BC9E;
 Wed, 21 Jan 2026 11:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768994725;
 bh=OwzMtHSbgVDNyZakvOAJFDH2xXl6OCwOdHlToFrd0Ro=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NKYRrdBINvcp+M7wxheTPHFCZeIvdfD03QERZHavem5esN5aWRmA6JFdC93bhuWd3
 kwEVqyyq510C/eT90c+Maz/+/KF1F24dFEuIgkPl3vmebv5HeCM3wcnBdgJ0JW5EpS
 EyCLYsSqDtThyKYE1zYUknUlRdA3cRYuriD9Uh91+KxJcAbS8+IJa0vwuGn1E3xXEm
 AxhN2wiGGfvfgTd5Lk1BT+bSpzvFbKVwAIfctb9WfFG5AxRrQVxA6h/XaqRGxp5FIQ
 IdJXy2fXKfwf0fliVC4icPuOJ5fKcAm8P7Qy2iTyacZ3G1YiU0ktSYfCdkKZWMSivt
 U3LrWVhOSkAvA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1viWKx-00000003gJS-0Fou; Wed, 21 Jan 2026 12:25:23 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 03/13] scripts/qmp_helper: add support for FRU Memory Poison
Date: Wed, 21 Jan 2026 12:25:11 +0100
Message-ID: <e9c9d9562bc9c71623f39c2b78eb4efcdb1679cc.1768993993.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768993993.git.mchehab+huawei@kernel.org>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
---
 scripts/qmp_helper.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index 7e786c4adfd9..19bf641a13ce 100755
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
2.52.0


