Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35590C282D0
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 08:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toeb8-0006Fc-Fo; Sun, 02 Mar 2025 03:22:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1toean-0005cw-G7; Sun, 02 Mar 2025 03:22:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1toeak-0005gv-0G; Sun, 02 Mar 2025 03:22:32 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 802DD5C2765;
 Sun,  2 Mar 2025 08:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0185EC4CEE2;
 Sun,  2 Mar 2025 08:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1740903737;
 bh=VNVwBUg9DLb/+TaZToRj4L6G17tMKOtxkr5IyNsYATU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qSS40f6RsePRcoG1/rYkVGoLkR2C7kKknBwDYui3B8sniBfETUV1lSGmrX1qJXEn4
 FlFtlQFwEQeB1iDzeuLqZ2NQ488z5qV/nmPzOuYMni/7ainwxXv46cwUcjUI0bFI2k
 UocUlG5Ip6J0LrDEaO6MOlNrJ6O7g8b4DynlZ8Gj/CwyhIBeTS18iAkwUUAVQKqyfL
 z4qy166UDBfT/6uV4OsOexLfPw3Qf8da/F4Il1X2O/Ej5LCBx7ZRaazhJfkzkNlCvg
 0MIysfcskChwwm+NcAeuegxZZCNz1raIvUBiUoqcWWI9/Wmx2+NizgeOVEFPaVcFNy
 O1HMOYlaC4oLA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1toeaU-000000043Rg-2GEO; Sun, 02 Mar 2025 09:22:14 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Ani Sinha <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v7 03/19] tests/acpi: virt: update HEST file with its current
 data
Date: Sun,  2 Mar 2025 09:21:50 +0100
Message-ID: <fd2ca5357efb92aede7e6101b7bf7a1b46fad50d.1740903110.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740903110.git.mchehab+huawei@kernel.org>
References: <cover.1740903110.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -74
X-Spam_score: -7.5
X-Spam_bar: -------
X-Spam_report: (-7.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that HEST table is checked for aarch64, add the current
firmware file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/data/acpi/aarch64/virt/HEST           | Bin 0 -> 132 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..4c5d8c5b5da5b3241f93cd0839e94272bf6b1486 100644
GIT binary patch
literal 132
zcmeZp4Gw8xU|?W;<mB({5v<@85#X$#prF9Wz`y`vgJ=-uVqjqS|DS;o#%Ew*U|?_n
dk++-~7#J8hWI!Yi09DHYRr~Kh1c1x}0RY>66afGL

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 39901c58d647..dfb8523c8bf4 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/HEST",
-- 
2.48.1


