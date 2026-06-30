Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB35AC43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weh0B-00017i-R0; Tue, 30 Jun 2026 18:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1weh08-000174-08
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:32:20 -0400
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christianslima@proton.me>)
 id 1weh03-0008Fp-LR
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=mc4mt4vr2vhbzps6izri3ctnwa.protonmail; t=1782858729; x=1783117929;
 bh=GdyzAyxccl5bxMSbIUYTBW1C0tHwD4tBpKVEjbdiMCY=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=iaATYGkZsl9fgT9pfGSV1jWvHSvg9nqODXQq5UCTJvGXIA1COT/8Viv5731lUznmk
 cVDnU+tJ8amCtiH2PNKgNBoafRN/fYTC243KXTF0RQs6NXNeOYMH0r6q+gcUjY2VQB
 IwgyCcWcCjIF4LmD//Zw4gYnRDN2VL4W04yVqMSz+syMXqlOnotLBx34cV3FCFvFBp
 rWRWUovqVUgSq3S5iFm4rVHAyCjfqHx0F4g8v3vD8Lxvd9rZ3n/+q9JOmB975Gc7KK
 xOs44Pxfq8tbeChBmVVmADkLYe6Za+MKX3Bx3HLBHkPbz4fM5ZD1MW0AXrd17XDQc2
 VTW9ucP53FHPA==
Date: Tue, 30 Jun 2026 22:32:04 +0000
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
From: "Christian S. Lima" <christianslima@proton.me>
Subject: [PATCH v2] disas: converts malloc to g_new0
Message-ID: <20260630223159.68737-1-christianslima@proton.me>
Feedback-ID: 169431447:user:proton
X-Pm-Message-ID: d81b2355e94e7fa004395ffaaf2656853aebe49e
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=57.129.93.249;
 envelope-from=christianslima@proton.me; helo=mail-08.mail-europe.com
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

Following the qemu coding style change from malloc to g_new0, the
advantages are that g_new0 catch multiplication overflowing size_t,
allows for better detection of type errors because it returns the type
itself and initialize memory with zeros to detect if something go wrong.

Signed-off-by: Christian S. Lima <christianslima@proton.me>
---
Changes in v2:
    - Change from g_malloc0 to g_new0
---
 disas/m68k.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/disas/m68k.c b/disas/m68k.c
index 800b4145ac..c3571783b0 100644
--- a/disas/m68k.c
+++ b/disas/m68k.c
@@ -1887,8 +1887,7 @@ print_insn_m68k (bfd_vma memaddr, disassemble_info *i=
nfo)
=20
       /* Then create a sorted table of pointers
 =09 that point into the unsorted table.  */
-      opc_pointer[0] =3D malloc (sizeof (struct m68k_opcode *)
-                               * m68k_numopcodes);
+      opc_pointer[0] =3D g_new0(const struct m68k_opcode *, m68k_numopcode=
s);
       opcodes[0] =3D opc_pointer[0];
=20
       for (i =3D 1; i < 16; i++)
--=20
2.53.0



