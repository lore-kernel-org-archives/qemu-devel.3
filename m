Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14BCCCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 20:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9qjK-00061G-AN; Fri, 17 Oct 2025 16:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1v9qjH-0005zr-JG
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:07:11 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1v9qjG-0005OW-0F
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:07:11 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0AD2D6059B;
 Fri, 17 Oct 2025 20:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93158C4CEE7;
 Fri, 17 Oct 2025 20:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760731628;
 bh=jKb5dcRMYE6SXdnJJbFPj2oaSvakOW7bh3dzuBx2Q2I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=scn0j4hNvl8VHZDsmrTc++L1dn+sEvHo4G18h17GYHp0K++RPz1NGElbqO0s4DbnT
 1JHBZDm+H5cuHHoXvwUgEtpVEOoTNAhbevwwLARaYUrc35yYMwvhQ9q41mEf/6W5xF
 Pz0N6UEYaDYcu0+0ebPQ4itLNvVRSSzB071KTRPCQczDlM/U4X8KVqg4M+ujpB/UfP
 4plOWItydt/SYsy8g5/e+LRnToXAKq2/36a4FJg0sSJXY4g87HVfNFgyHji8h0Joks
 RO4+79w/PYFsNG+wZDOHBdfCaiIjZgdV1pQ00LY+H+rVckYcYY+QgA7bJoJeeLiFC+
 KRr9HLR3XqqFg==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 07/10] hw/hppa: Add the NCR 710 SCSI driver to hppa machines
Date: Fri, 17 Oct 2025 22:06:50 +0200
Message-ID: <20251017200653.23337-8-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017200653.23337-1-deller@kernel.org>
References: <20251017200653.23337-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Helge Deller <deller@gmx.de>

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index cab21045de..5ea7d9b9bf 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -17,6 +17,7 @@ config HPPA_B160L
     select IDE_CMD646
     select MC146818RTC
     select LSI_SCSI_PCI
+    select NCR710_SCSI
     select LASI_82596
     select LASIPS2
     select PARALLEL
-- 
2.51.0


