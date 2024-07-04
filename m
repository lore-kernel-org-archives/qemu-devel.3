Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E11C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 12:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPLtI-00048C-1B; Thu, 04 Jul 2024 08:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPLt6-00047M-So; Thu, 04 Jul 2024 08:48:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sPLt3-0006HL-3k; Thu, 04 Jul 2024 08:48:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E11CB7739B;
 Thu,  4 Jul 2024 15:48:21 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7A3DCFE780;
 Thu,  4 Jul 2024 15:48:26 +0300 (MSK)
Received: (nullmailer pid 1471767 invoked by uid 1000);
 Thu, 04 Jul 2024 12:48:26 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.13 01/17] target/i386: fix size of EBP writeback in
 gen_enter()
Date: Thu,  4 Jul 2024 15:48:08 +0300
Message-Id: <20240704124826.1471715-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.13-20240704143502@cover.tls.msk.ru>
References: <qemu-stable-7.2.13-20240704143502@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The calculation of FrameTemp is done using the size indicated by mo_pushpop()
before being written back to EBP, but the final writeback to EBP is done using
the size indicated by mo_stacksize().

In the case where mo_pushpop() is MO_32 and mo_stacksize() is MO_16 then the
final writeback to EBP is done using MO_16 which can leave junk in the top
16-bits of EBP after executing ENTER.

Change the writeback of EBP to use the same size indicated by mo_pushpop() to
ensure that the full value is written back.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2198
Message-ID: <20240606095319.229650-5-mark.cave-ayland@ilande.co.uk>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 3973615e7fbaeef1deeaa067577e373781ced70a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 417bc26e8f..8eb6a974e5 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2696,7 +2696,7 @@ static void gen_enter(DisasContext *s, int esp_addend, int level)
     }
 
     /* Copy the FrameTemp value to EBP.  */
-    gen_op_mov_reg_v(s, a_ot, R_EBP, s->T1);
+    gen_op_mov_reg_v(s, d_ot, R_EBP, s->T1);
 
     /* Compute the final value of ESP.  */
     tcg_gen_subi_tl(s->T1, s->T1, esp_addend + size * level);
-- 
2.39.2


