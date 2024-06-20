Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4B0C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 08:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKDJK-0006HK-Oz; Thu, 20 Jun 2024 04:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1sKDJJ-0006GC-0O
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 04:38:25 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1sKDJG-0006kG-Af
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 04:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1718872695;
 bh=4SowQBkGId3dXNyYt4Q/U5N0XFaxSViHih8U7VqRzdM=;
 h=From:To:Cc:Subject:Date:From;
 b=OZjnydu0Jarg8j7fL5YShcCrYx6E3jPCQOPR3R5natCNb0f3LyK+DirW2dkd28pjq
 +nRoLASmmLZIQHlbZo1Ci315bsYK5a4H2k+i/vWUQxCl+S9mr3ydp4PIwuHIZnXCIu
 A7SIMRTppt0eKZE/LgakbAaqT3nzAcOV4MH/w0LIxv5Hz9f+Wm8ShQNLWQEACMoTwG
 y8Sw67vTd8l0yz9lvuTL07mDYuXynm/aHmSmKUvwn+UmZSUZ2F1D5Rd0Z+1wiARwuO
 lBAIk6iKhQM4uWTONogZERJCLIRY3g8SEjvLZN1TrMiuLg46ZxSQgatLWdBqlhZIkm
 a0B84gNUHAlXA==
Received: from mailhub.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 0B2B1402BB;
 Thu, 20 Jun 2024 10:38:15 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
 by mailhub.u-ga.fr (Postfix) with ESMTP id 07D05100067;
 Thu, 20 Jun 2024 10:38:15 +0200 (CEST)
Received: from ravenala.reseau.jussieu.fr (fw-pmc.sorbonne-universite.fr
 [134.157.254.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 9E1D04007F;
 Thu, 20 Jun 2024 10:38:14 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
To: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com,
 pierrick.bouvier@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>
Subject: [PATCH] plugins/execlog.c: correct dump of registers values
Date: Thu, 20 Jun 2024 10:38:05 +0200
Message-Id: <20240620083805.73603-1-frederic.petrot@univ-grenoble-alpes.fr>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Register values are dumped as 'sz' chunks of two nibbles in the execlog
plugin, sz was 1 too big.

Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
---
 contrib/plugins/execlog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 371db97eb1..1c1601cc0b 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -101,7 +101,7 @@ static void insn_check_regs(CPU *cpu)
             GByteArray *temp = reg->last;
             g_string_append_printf(cpu->last_exec, ", %s -> 0x", reg->name);
             /* TODO: handle BE properly */
-            for (int i = sz; i >= 0; i--) {
+            for (int i = sz - 1; i >= 0; i--) {
                 g_string_append_printf(cpu->last_exec, "%02x",
                                        reg->new->data[i]);
             }
-- 
2.39.2


