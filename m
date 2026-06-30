Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E46C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 00:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weMj4-0005fK-Gd; Mon, 29 Jun 2026 20:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1weMj2-0005f6-Gv
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 20:53:20 -0400
Received: from mail-07.mail-europe.com ([188.165.51.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1weMiz-0002ie-9h
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 20:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1782780784; x=1783039984;
 bh=bBjAfTrIb9Y10u2olbxk1QFjmsldBZWC2wJZIiZJYFk=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ZySVmqanESYfrF4XYiukU6hw9kT8n60nHPz8CtRv49vQw6y1X6Xc5am3vIVsOBF9F
 hJ1MyKoY3RjxHzcGc3H/ZdMvRaqNeqI2ydZitCnEj6FoS64oJIif30hhDqtigOnoxa
 DOZOMtZQooqTj6jcqC3/V4ABiIJcGfRJqXKNcEpRUVRQmAjvZCME1ovuExL1Y5foCA
 RLZsBctnBHMmHzesVcHJgWpkKuUggnBRF9xG9INK8gkVnYeSNETJVrSVyOwoyy16L7
 moqHLq0wRHxxe9WB8Y3STmlf73k+Y4XBskRtjl8jCw3VbvLzbNbqS9T9T84ylHXHKL
 7HJbcqpQc90LA==
Date: Tue, 30 Jun 2026 00:52:56 +0000
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
From: "Christian S. Lima" <christianslima@proton.me>
Subject: [PATCH] disas: converts malloc to g_malloc0
Message-ID: <20260630005249.143976-1-christianslima@proton.me>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: 40579b4f83561569ab02d89be8ca914619536525
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=188.165.51.139;
 envelope-from=christianslima@proton.me; helo=mail-07.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Following the qemu coding style change malloc to g_malloc, the
advantages are that g_malloc will exit if some failure occur and
initialize all memory with zeros.

Signed-off-by: Christian S. Lima <christianslima@proton.me>
---
 disas/m68k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disas/m68k.c b/disas/m68k.c
index 800b4145ac..e629f3c365 100644
--- a/disas/m68k.c
+++ b/disas/m68k.c
@@ -1887,8 +1887,8 @@ print_insn_m68k (bfd_vma memaddr, disassemble_info *i=
nfo)
=20
       /* Then create a sorted table of pointers
 =09 that point into the unsorted table.  */
-      opc_pointer[0] =3D malloc (sizeof (struct m68k_opcode *)
-                               * m68k_numopcodes);
+      opc_pointer[0] =3D g_malloc0 (sizeof (struct m68k_opcode)
+                                  * m68k_numopcodes);
       opcodes[0] =3D opc_pointer[0];
=20
       for (i =3D 1; i < 16; i++)
--=20
2.53.0



