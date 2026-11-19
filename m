Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D86E606A330
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WikO3O7f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAv9-0005zM-8c; Thu, 19 Nov 2026 17:47:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUAv5-0005xe-Qk
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:47:55 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xUAv4-0004HN-Bu
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:47:55 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB93261849;
 Thu, 19 Nov 2026 22:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5EA1F000C0;
 Thu, 19 Nov 2026 22:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795128473;
 bh=1tU3sQOooyQUEH1pMr+mfxLG4s0zTHsTWP+g6ic2b8Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WikO3O7f9KvGcvzykANSSdz0exbf5/ZwGFraShupHcnSnj4pym3mdNkJ7mraM0/Mx
 PXGFpN8oWsc6spo4adPdvJ8htrNxOkrw7OsOlv3QT9+WRjyJq0XWSUqUvGXb2/FGaC
 2+OHuOEyVtXbfCuiQ/k2L1/XRELlOmZQ5fN96XV10HG5ZgrcYFfQRK2e6rTSwzo/Jc
 dJgNfN4NzzsOYX3cHTxTa1c17pwIonWJwumQ1547+c1jYq/9kcttPe/TCwxNmyymgH
 0isEbIZuCuOr7s/YHkI3oe6ATBGYDQk2ycJYrXTLTO63OlLrwToPWFKytDO6fsi4oH
 8+Lz7RXhagIkg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 4/4] hw/hppa: preload a BTLB entry for the soft power button
 page
Date: Thu, 19 Nov 2026 23:47:44 +0100
Message-ID: <20261119224744.31309-5-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261119224744.31309-1-deller@kernel.org>
References: <20261119224744.31309-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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

From: Keith Monahan <keith@techtravels.org>

HP-UX 9 reads the soft power button register from its clock interrupt
without mapping it.  The guest boots without
-fw_cfg opt/power-button-enable,string=0 and powers off cleanly on
system_powerdown.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index f23936fc5b..3b83968f33 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -909,6 +909,7 @@ static void hppa_machine_reset(MachineState *ms, ResetType type)
         static const struct { uint32_t start, last; } io_btlb[] = {
             { 0xf0100000, 0xf01fffff },     /* LASI */
             { 0xfff80000, 0xffffffff },     /* central bus */
+            { 0xf00ff000, 0xf00fffff },     /* soft power button register */
         };
         CPUHPPAState *env = &cpu[0]->env;
 
-- 
2.54.0


