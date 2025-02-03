Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AD0C02190
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 03:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temvc-00074i-Bx; Sun, 02 Feb 2025 22:15:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <henk@laaksoft.nl>) id 1temva-00073I-J1
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:15:15 -0500
Received: from web5.hostingcp.eu ([2a09:8b00:252:5::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <henk@laaksoft.nl>) id 1temvX-00025C-Tc
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 22:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=laaksoft.nl
 ; s=x;
 h=Content-Transfer-Encoding:Content-Type:Subject:Cc:From:To:
 MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eGsegL9nmdkSK8/jok+tsKCKg3J7UpoE7TRcQKVTZKs=; b=hyPMNq7DjSQGZIwhMffMJBdGUK
 2+usBaM2lFIR9Ugyd3+TxkdK0lMSo1IWk2Wvh0PhYRyKibkJ4xitD66V5g7YVw92XW3iFgF2VhMNO
 tLL2zE6JQ6nod/xkbP2N03aV+BuD7HDeSV9fFb73DT5QU5ANe4GzsvKGThwADomC4cUKYPEdIuB1F
 wJCBORqtxejWZcV1dbNSih60447LkHCuoNYlqMWne4aSRjKIJ2a8YOM/92VpajjNTB526amk6c5bi
 76+YZ0nLDH0h6oG7RSMqPithvjShs+DQr4b9Ws+dYe90Eya5fQXDyGn1/hrD/fxgb36NrzqDNajkE
 2uTDsIIQ==;
Received: from 095-096-130-127.static.chello.nl ([95.96.130.127]
 helo=[192.168.178.10])
 by web5.hostingcp.eu with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <henk@laaksoft.nl>)
 id 1temvW-00000003cwH-0U1j; Mon, 03 Feb 2025 04:15:10 +0100
Message-ID: <eb7fe8ed-e885-48c0-a36f-1f700bc692bf@laaksoft.nl>
Date: Mon, 3 Feb 2025 04:14:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: qemu-devel@nongnu.org
Content-Language: en-US
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: Patch: Sparc prevent segfault when dumping uninitialzed cpu state
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MagicSpam-TUUID: 39480960-a2d1-41e6-8964-b89acd8d2e02
X-MagicSpam-SUUID: 234b6e9d-3dd0-4c7e-bd4d-fdd295376ca6
X-Authenticated-Id: henk@laaksoft.nl
Received-SPF: pass client-ip=2a09:8b00:252:5::10;
 envelope-from=henk@laaksoft.nl; helo=web5.hostingcp.eu
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  "Henk van der Laak (LaakSoft)" <henk@laaksoft.nl>
From:  "Henk van der Laak (LaakSoft)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi all, my first contribution. I checked code style, patch submission 
rules and did a manual test (details on request)

Synopsis:
It's a corner case, where a segfault occurs when logging Sparc CPU state 
in a partially initialized state.

No related bug report.

Open to harsh criticism ;-)

Regards,

Henk van der Laak <henk@laaksoft.nl>


Patch is based off 6fccaa2fba391815308a746d68f7fa197bc93586 
(origin/master) as of Sun Feb 2 11:09:10 2025 -0500
Signed-off-by: Henk van der Laak <henk@laaksoft.nl>

---
  target/sparc/cpu.c | 7 ++++++-
  1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index fbd38ec334..83aaa456fc 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -642,7 +642,12 @@ static void sparc_cpu_dump_state(CPUState *cs, FILE 
*f, int flags)
                               x == 0 ? 'o' : (x == 1 ? 'l' : 'i'),
                               i, i + REGS_PER_LINE - 1);
              }
-            qemu_fprintf(f, TARGET_FMT_lx " ", env->regwptr[i + x * 8]);
+            /*
+             * regwptr may not be initialized yet when logging
+             * e.g. cpu_reset
+             */
+            qemu_fprintf(f, TARGET_FMT_lx " ",
+                env->regwptr ? env->regwptr[i + x * 8] : 0);
              if (i % REGS_PER_LINE == REGS_PER_LINE - 1) {
                  qemu_fprintf(f, "\n");
              }
-- 
2.43.0


