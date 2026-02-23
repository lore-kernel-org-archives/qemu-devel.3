Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E3AEA4FB5
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 11:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuUSX-0004QU-3s; Mon, 23 Feb 2026 06:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSU-0004PA-AC
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:50:38 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSR-0004qt-1F
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:50:36 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D7E9F44123;
 Mon, 23 Feb 2026 11:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59AFC19424;
 Mon, 23 Feb 2026 11:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771847433;
 bh=apHzXrmtB3K9bS+IcAMBedJ//nuE8l/kc7ig4KubSvc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=V4OK4BUkXdyRoXAVSOw5n+DFtpsiyYjr0yB0QdLvoneqmivWmFDrLvfjnGNWdk7zY
 m6AC3M1y4wKS7zdTz11PACqz0l3iol8zllmGuCiiHdHKzZUkWg4OP6RSXCl2jwwfRi
 s9CZVeZCuhRn4ubKlgvFkMwWUvMwX1gjS2wqIgURjYSaXZ6PbRUf+IdJmEgW2/4ieT
 2EvL1RQ/PDzHBlvkGvAz38GBBtvxGvMth2lSMwCk5q9rnQRoEKBGTjTHEVgA/9809u
 oQS74ktXTmN12Vk9/ZPkk2DOyNaKxm16I3RmDDuOLGgndzKOcARRKTXUE97tHbiAxA
 qfeBnWTYWcEpA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSN-00000007Jnh-3hXo; Mon, 23 Feb 2026 12:50:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v3 03/14] scripts/qmp_helper: add support for FRU Memory Poison
Date: Mon, 23 Feb 2026 12:50:19 +0100
Message-ID: <e9c9d9562bc9c71623f39c2b78eb4efcdb1679cc.1771847176.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771847176.git.mchehab+huawei@kernel.org>
References: <cover.1771847176.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
2.53.0


