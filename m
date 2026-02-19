Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EAAE9A03B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 12:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt3OW-0007Mj-Ay; Thu, 19 Feb 2026 07:44:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vt3OH-0007L1-Cs
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:44:25 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vt3OF-0008BP-Ty
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 07:44:21 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F19726014C;
 Thu, 19 Feb 2026 12:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9240BC116D0;
 Thu, 19 Feb 2026 12:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771505057;
 bh=qvMd5d1PMdTjcI76VzkCpKaGDnzEP43tkvSG313J2hs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EcHHhiQGIX1Zk0oBO0T6I1nOrOyzwsiLtFKcIZ5aFzYwDOd00kql3nm/lGp29CvUW
 qDoVgWZew9FgK5pgXcJW7UQo7R9gj9WtpRlMopO3WAzkO0zMmYsj9SPBnEM03CkeIT
 EA+hSdTCcCc52BvusLFcDAo+HzYe3SrgDHrvKaUbRyCf+cssiqCUvDrSfyxklVSldI
 bLBYSS/2qpN6d8nVUfDojP2UnQllAcuUGe2Go5QyxTlz+o3ZQG0ZfZI5z6TzfsTBtm
 M2qoVaksW9h+isKyTeKV9NOQigfDN6sWNGSo8j48F5iCfFQIciBJ40KsHiMnIpv/kL
 3QVfBIsY571Qw==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 3/4] hw/hppa: Require SeaBIOS version 22 for A400 machine
Date: Thu, 19 Feb 2026 13:44:07 +0100
Message-ID: <20260219124408.3515-4-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219124408.3515-1-deller@kernel.org>
References: <20260219124408.3515-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
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

From: Helge Deller <deller@gmx.de>

Require at least SeaBIOS version 22 before adding the A400 machine.
This is required, because version 22 adds the A400 machine definition
and provides the necessary 64-bit PAT firmware. All other machines up to
now used only the 32- or 64-bit PDC firmware without the PAT extensions.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index d6aeb793c0..5ce4a17915 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -45,7 +45,7 @@ struct HppaMachineState {
     MachineState parent_obj;
 };
 
-#define MIN_SEABIOS_HPPA_VERSION 19 /* require at least this fw version */
+#define MIN_SEABIOS_HPPA_VERSION 22 /* require at least this fw version */
 
 #define HPA_POWER_BUTTON        (FIRMWARE_END - 0x10)
 static hwaddr soft_power_reg;
-- 
2.53.0


