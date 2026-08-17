Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F7EC5DF7D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuqO-0001Pj-77; Mon, 17 Aug 2026 06:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuqI-0001B2-UZ; Mon, 17 Aug 2026 06:45:23 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuqH-0003zL-C7; Mon, 17 Aug 2026 06:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786963486; bh=MKEqkxgN6xcfH6VtMq15ma4NcXGuIpLzcV6ofdHMXl0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CfZ4wvTgfKf4CmT/Vrs6JiijKpISnJp6GQhZnjWWAU5rypx8MXY3lRDdPko517lYo
 2TYYaQAAaIxgZIxg4tnRdi5knbW5Y39DNVZhSePrp9Wu4GHcCa8AmUJDrgmZ7VeX+g
 hs2I7ES2riK+9NaJ9joZFG2s1bKTm3gXZA5Rhxk/02ZNZC+25HgAZui3W7V3JKJnUN
 Hk5FnLdlTRHeoSzDPOG3Mxja/bp2irYW2scRDrTO2KWwSjDb+5TMNM1/CsXV8vsccG
 ju6eiYuEzdAexsXMr1R2I4I/OW3cv3NZTTF224W3EYpVf1WUpRXxXObeD7GSWseRPr
 +Gju46btAAk+A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 753111CBB6E;
 Mon, 17 Aug 2026 13:44:46 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 73E7340D1FF;
 Mon, 17 Aug 2026 13:45:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 072CB30E54; Mon, 17 Aug 2026 13:44:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v2 129/161] hw/char/sclpconsole-lm: avoid guest
 triggerable assert
Date: Mon, 17 Aug 2026 13:42:43 +0300
Message-ID: <20260817104344.2047346-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Borntraeger <borntraeger@linux.ibm.com>

If a guest uses incorrect message length it can trigger an assert in
process_mdb which kills the guest instead of reporting an error.  Fix
this by adding the correct length check.

Fixes: 6a444f8507 ("s390/sclplmconsole: Add support for SCLP line-mode console")
Cc: qemu-stable@nongnu.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260727115052.24289-2-borntraeger@linux.ibm.com
[farman@linux.ibm.com: Fixed typo in commit message, added qemu-stable]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit 4e994ebb01442d90e97e2f94f53f61b1b0b34f62)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/char/sclpconsole-lm.c b/hw/char/sclpconsole-lm.c
index 9a16896d228..f6ed282f1bc 100644
--- a/hw/char/sclpconsole-lm.c
+++ b/hw/char/sclpconsole-lm.c
@@ -243,7 +243,8 @@ static int write_event_data(SCLPEvent *event, EventBufferHeader *ebh)
     SCLPConsoleLM *scon = SCLPLM_CONSOLE(event);
 
     len = be16_to_cpu(data->mdb.header.length);
-    if (len < sizeof(data->mdb.header)) {
+    if (len < sizeof(data->mdb.header) ||
+        len > be16_to_cpu(data->header.length) - sizeof(EventBufferHeader)) {
         return SCLP_RC_INCONSISTENT_LENGTHS;
     }
     len -= sizeof(data->mdb.header);
-- 
2.47.3


