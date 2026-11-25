Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFC5606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GyMBBKqM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW3DR-0008Ra-RF; Tue, 24 Nov 2026 21:58:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW3DO-0008Qa-BU
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:58:34 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xW3DL-0003uF-Rf
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 21:58:32 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4020A6113A;
 Wed, 25 Nov 2026 02:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC9A1F000C4;
 Wed, 25 Nov 2026 02:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795575510;
 bh=z+LikMZp46g7l/E7qCWTZFS2ht8MeT4ZA9rOeifvA/w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GyMBBKqMvGu0mxPodFB/XkFoqSmnDWQaCHYl7EoWt7faK3K3KkCfiKtuN0TC+tY6m
 em1fEAn0vbswF/kFP5R4bx79+YGz2394853Qi1UAearSS+MkAMM2sDxEJktqqQYfgC
 5f1BTuvTh9o/TGXs0GgLg0DS7yBOVQMf4gjh/cZ8MQ2bJY9mmtF9PZZMcSdyGZ3vX3
 xqN0bvPsepF4n0FpDwhIWIlRI8TaAdikWZissAG3uxQcfqai+rbtG7m9bHDNxyl30N
 W92SSUnuZi40FZouoiLkVsu+EX1Z/BJrWTgox3u+C0MnOHqJNsV70RbJSmfeX6cYVa
 5t5P92OHdZRGg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PULL for 11.2 3/3] hw/hppa: adjust CPU HPA on 715 to avoid broadcast
 address
Date: Wed, 25 Nov 2026 03:58:22 +0100
Message-ID: <20261125025822.10813-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125025822.10813-1-deller@kernel.org>
References: <20261125025822.10813-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
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

From: Helge Deller <deller@gmx.de>

Change the CPU HPA for the monarch CPU on the 715 machine to 0xfffa0000
if more than 2 CPUs are configured, as otherwise the second CPU would be
on HPA 0xfffc0000 which conflicts with the global broadcast HPA
(HPPA_BROADCAST_HPA).

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 8dd9023058..feb526de3b 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -629,7 +629,8 @@ static void machine_HP_715_init(MachineState *machine)
     ISABus *isa_bus;
 
     /* Create CPUs and RAM.  */
-    translate = machine_HP_common_init_cpus(machine, 0xfffbe000);
+    translate = machine_HP_common_init_cpus(machine,
+                    machine->smp.cpus <= 2 ? 0xfffbe000 : 0xfffa0000);
 
     if (hppa_is_pa20(&cpu[0]->env)) {
         error_report("The HP 715/64 workstation requires a 32-bit "
-- 
2.54.0


