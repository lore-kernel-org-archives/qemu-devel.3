Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50926CCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 20:09:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9qjM-00062k-LG; Fri, 17 Oct 2025 16:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1v9qjK-00061Y-Kn
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:07:14 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1v9qjI-0005PJ-WA
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 16:07:14 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DEE1045771;
 Fri, 17 Oct 2025 20:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24CAC4CEFB;
 Fri, 17 Oct 2025 20:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760731631;
 bh=B28j9BYJwOe4ZXZ94ncH1Ydbl7b8nu2FwTXAAheA/ow=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BPAeM6RdTH+j0I9u9BJHuZYPnHecUeO3WxV13T8mghpy48aVUVIZW700k5Ur/n1nB
 ApuAVq6ArXUC6KGVIYtSeZVX53Kf1UMHzSXFO/I5ucYX8WM/3QrB6ifWfZ351pfnAl
 WBt+AdUMT0pURIaJAZ0WXc/EPIE3cFQio2W7Dvtqk9hCt4qkWZkWPqvDdmlmpX+yFo
 WdietBDADCbTeNmMpIBtbfldKSNX733ZUVEXIGS91V3ustzDKW9tYZvC1euEI6HuY8
 VOtF3YwLjpQK3JUoEb/EQASJB+JGITpQU83/NcGBce/mSL61xQeculqZTjKAYiV7k+
 uQRv+7yaPL6cg==
From: deller@kernel.org
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Subject: [PATCH 09/10] hw/hppa: Require SeaBIOS version 19 for 715 machine
Date: Fri, 17 Oct 2025 22:06:52 +0200
Message-ID: <20251017200653.23337-10-deller@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017200653.23337-1-deller@kernel.org>
References: <20251017200653.23337-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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

Require at least SeaBIOS version 19 before adding the 715 machine.  This is
required, because the machine inventory of the 715 is provided by the SeaBIOS
firmware.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index b6cdbc74ba..7981a8bb11 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -43,7 +43,7 @@ struct HppaMachineState {
     MachineState parent_obj;
 };
 
-#define MIN_SEABIOS_HPPA_VERSION 12 /* require at least this fw version */
+#define MIN_SEABIOS_HPPA_VERSION 19 /* require at least this fw version */
 
 #define HPA_POWER_BUTTON        (FIRMWARE_END - 0x10)
 static hwaddr soft_power_reg;
-- 
2.51.0


