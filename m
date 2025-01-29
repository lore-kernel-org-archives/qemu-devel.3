Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228E3C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 08:06:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td35E-0000pb-1o; Wed, 29 Jan 2025 03:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1td33p-00086l-Ca; Wed, 29 Jan 2025 03:04:33 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1td33m-00014t-Js; Wed, 29 Jan 2025 03:04:33 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id A19F9A41454;
 Wed, 29 Jan 2025 08:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE44C4CEEA;
 Wed, 29 Jan 2025 08:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738137866;
 bh=0b+60rXVrbu/hiTiZ4OpvRNmenUzwizWLirm4Ep1lTQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CTutfBDyM9KoPCHYDOqxxwbzJlfXn1zqlGPp+gLXftpgbOPyrsynQg8JKhW6W+ufY
 iT0lPXZUnqdDcVkmjPunoZ40eEEAB+dx+c2HqlLEUUXzuxyLhcXnRkGxQENMPnQ/fT
 P4GSnBZIIqxN8i7lcoPpZ9jc7Is2ivoG33EbUBVMcgjZPi3EZ8H3e2/CABOdFg8bOo
 ufC+/lKsInFDU+nQY22IeM6+cUWmG6fSbUCnt58PsbTrVmJUUEqR73VvDC6sFgDtyL
 WNVigzWWczvMb4NX3mZf8Q4dSRyFImjJjoXLkiltp/yPAKERjgy9q8Jx0NV89RMy11
 Kk1aqMOOkLWlw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1td33g-00000004DPe-2uk9; Wed, 29 Jan 2025 09:04:24 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/13] tests/acpi: virt: allow acpi table changes for a new
 table: HEST
Date: Wed, 29 Jan 2025 09:04:08 +0100
Message-ID: <1390b46682f2bac3587239d03a0ba22d18a9a044.1738137123.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738137123.git.mchehab+huawei@kernel.org>
References: <cover.1738137123.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The DSDT table will also be affected by such change.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tests/data/acpi/aarch64/virt/HEST           | 0
 tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
 2 files changed, 2 insertions(+)
 create mode 100644 tests/data/acpi/aarch64/virt/HEST

diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..46298e38e7b8 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,3 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/HEST",
+"tests/data/acpi/aarch64/virt/DSDT",
-- 
2.48.1


