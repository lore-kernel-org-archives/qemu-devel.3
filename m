Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27B7C021A4
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 02:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj7k5-0004HU-H5; Fri, 14 Feb 2025 21:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tj7jz-0004F8-GV
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 21:17:11 -0500
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1tj7jw-0006dT-Fe
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 21:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739585825; bh=T0TGaowpdk7Flput3BYwaWvnKQsX4zXMW7/eTHVce+E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cU9rrJmNhjkJCPHeoNIkpWi05+0TAveSw6Jvfu2btUgmYRd0BoQiI+oB0xJM/xkt9
 /saKF+ZFfgXcvDMulZtMPrQdfTz9JBwDQAFselAdmkkUpFBodrSVwVsgK5nOJX4fHq
 ApGe2bNFw3kvnQ52HwYP1ZvInB48d4LYaVkeA7guNe3qunV6bYBKPkPD8ix3nBImnJ
 aaIHyb0eO6r8hSkoxQd3pGh6r12fIPhzu5ghWmba+L7rcLgT84UyKKKGxxqXq+E3uQ
 /92HpQeHZ9g6ZrNPxir+7PeG+gL40gXt0n3pQCFBrSn2Zl0nh5ITyD4lv8FPNCzIjj
 kL2B0Vaup3vRA==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id E598B3F22BEA
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 18:17:05 -0800 (PST)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id 87LtWDR2-FFZ; Fri, 14 Feb 2025 18:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1739585822; bh=T0TGaowpdk7Flput3BYwaWvnKQsX4zXMW7/eTHVce+E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VmE0ZYgXkEOC7k04Mh9lVuf/J+QnThwl6qmd31rgGtVHuyzfBBk+3H+CqmqZqXpSP
 /hkW1mN9CAauEK3A2wMjIN3+ZzCQUfSTTFWCTuj5dor5Fqv8rkF/jki+LmvV1dY02X
 vEd4QFFcqdjACOUOjWZgFCf2bilmp2ucx27c8mbbFztAp4xbUyRmfDOaDkqDGtNAwb
 DSLEAmyFw+Oa33aN+ttUg93dSSuy1sEYzh8FyQ05uFwTu766EP/l5NMmgqtAZ1kcHM
 QMP1ljchznmcKe0iG5nBzBp4qQ4opzsRtievgwEEjVgSi/43PvXXBTa75kFt4DGdzy
 XMgaoBsK9NmMg==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id 7F3943F2076E;
 Fri, 14 Feb 2025 18:17:02 -0800 (PST)
Received: by keithp.com (Postfix, from userid 1000)
 id 5613E1E6007A; Fri, 14 Feb 2025 18:17:02 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: Keith Packard <keithp@keithp.com>
Subject: [PATCH 1/5] hw/rx: Allow execution without either bios or kernel
Date: Fri, 14 Feb 2025 18:16:50 -0800
Message-ID: <20250215021654.1786679-2-keithp@keithp.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250215021654.1786679-1-keithp@keithp.com>
References: <20250215021654.1786679-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Users can use -device loader to get an ELF file loaded to
memory, so we don't need to require one of these options.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 hw/rx/rx-gdbsim.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 88c8f12c10..4afd77efd5 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -110,9 +110,6 @@ static void rx_gdbsim_init(MachineState *machine)
     if (!kernel_filename) {
         if (machine->firmware) {
             rom_add_file_fixed(machine->firmware, RX62N_CFLASH_BASE, 0);
-        } else if (!qtest_enabled()) {
-            error_report("No bios or kernel specified");
-            exit(1);
         }
     }
 
-- 
2.47.2


