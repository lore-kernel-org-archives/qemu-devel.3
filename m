Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94419CA1013
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 15:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuY51-0007bj-AC; Fri, 05 Sep 2025 11:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1uuY4c-0007UB-Tu; Fri, 05 Sep 2025 11:10:00 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1uuY4U-0005n4-Lh; Fri, 05 Sep 2025 11:09:57 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D1C7844D79;
 Fri,  5 Sep 2025 15:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6441DC4AF0F;
 Fri,  5 Sep 2025 15:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757084974;
 bh=IjJ4y9uy7VcSd8eGrYRNJbPGROxfdzIQhh+NLKCr7+8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nqT3N/rTTzEr6JnYB0txCdej/G7lp2hL5lTPliCw2XM+yOqDR1Fth7bc4em0wwdV9
 UW7yhNNpgYgoGSTsYW+oT/FFl0Rlh2ZsL7O4aNVMMH9X5Eo+/1ZuRE6lUXbasQvpbY
 75Fzymuv/Qq+Psjxc0YW6IUu5rxtneZkh8RVSr8e5VpK7RGkxhR3HaREXfov6uHJ0/
 Js5hO3PIOvQd3D617Z3YbLRBMijs7DVRNqrAzWxc42yx+IsiJ9bqh70gSKVncl4EKd
 4hfVwIwVkARgE6H0AbgTLZER47KsYBIXl7jmh5yZ7RamPMW0jFu1vbJb/lq1tJJWnL
 4j9rEVfB7mOZg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1uuY49-0000000HEVJ-3lfQ; Fri, 05 Sep 2025 17:09:29 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v11 11/17] tests/acpi: virt: allow acpi table changes at DSDT
 and HEST tables
Date: Fri,  5 Sep 2025 17:09:18 +0200
Message-ID: <32fcebe49d990e24d8f048913de00054511294f8.1757084668.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757084668.git.mchehab+huawei@kernel.org>
References: <cover.1757084668.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We'll be adding a new GED device for HEST GPIO notification and
increasing the number of entries at the HEST table.

Blocklist testing HEST and DSDT tables until such changes
are completed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..45f256946751 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,10 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/HEST",
+"tests/data/acpi/aarch64/virt/DSDT",
+"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
+"tests/data/acpi/aarch64/virt/DSDT.hpoffacpiindex",
+"tests/data/acpi/aarch64/virt/DSDT.memhp",
+"tests/data/acpi/aarch64/virt/DSDT.pxb",
+"tests/data/acpi/aarch64/virt/DSDT.topology",
+"tests/data/acpi/aarch64/virt/DSDT.viot",
-- 
2.51.0


