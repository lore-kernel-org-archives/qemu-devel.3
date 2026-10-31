Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C2F606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Wzu1U3Xv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN4Sg-0001lI-7O; Sat, 31 Oct 2026 04:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4SX-0001jD-4i
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:06 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4ST-0001sE-T0
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793435339; x=1794040139; i=deller@gmx.de;
 bh=NPSaqlz7Sfk9dhwFR7LeTiiPGoJtY7nIz14pw9WSgIs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Wzu1U3XvLMJpS1XrHGNyOOZ9YQSgoCQ7j22Yva7308c7vIpOqSfHJKtPSHPnCwfR
 yv+ir8G55ve9NewPsz6N6LPpb1ha9VO8A0WIm8YoZ/Li8L0TY3L2aQymFsu/1QP+w
 1soB1LG1j3XGELz2AM+4JYfWnqtR17Mfc+/URhkC8pBSrGHzmC5cbWC+NqpDW7LO3
 O9Tr1l2CcziF1gAZaqet8GzAIDST5z+JyquOZhqC/F87Ok3vCvcFVif6FLFo/cF4m
 bIUdkKwX+xWsxZh08w05ph/BsyLjtwiAvN2NMEVsl2ExHY+jD5pCpwFy+i2NNAEYX
 ENWWFt8AoYBC2yq7Uw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1ps8-1xPHNb1W6S-008oH7; Sat, 31
 Oct 2026 09:28:59 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Fabiano Rosas <farosas@suse.de>,
 "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v3 06/10] target/hppa: Preload I/O-space BTLB entries for LASI
 and the central bus
Date: Sat, 31 Oct 2026 09:28:46 +0100
Message-ID: <20261031082850.439293-7-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031082850.439293-1-deller@gmx.de>
References: <20261031082850.439293-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6aMVeduJ6s8oJoP4idQxno+NfWwG7cVcPN69GWZBfCn9EZwjEsI
 Bpl6JAdPKV+TTG4UtSlR51gXeXNsnQBl2AaCq6CLbKacGWl3yhphW+QSDtBz/mTnFQTz0k3
 I52AN+XACsvhF816PF9LJCQgy2XB/8yqsftLCmXiPtZaetxSpXA6hX6njxqnuk+nEi693zF
 HabGHmjp9Wl9dMvkef+PQ==
UI-OutboundReport: notjunk:1;M01:P0:Ll+KrchMSqA=;o3/lUfIVL/KXJ58Rte/SeGDlqBw
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Keith Monahan <keith@techtravels.org>

Set up the BTLB to allow operating systems to access LASI and central
bus addresses.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/machine.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 8d378385b2..e403ae5fc9 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -896,6 +896,38 @@ static void hppa_machine_reset(MachineState *ms, Rese=
tType type)
         cpu[i]->env.gr[5] =3D CPU_HPA + i * 0x1000;
     }
=20
+    /*
+     * BTLB equivalence maps for the I/O ranges HP-UX 9 uses
+     * without creating page directory entries: the LASI block and the
+     * central bus (CPU HPA, broadcast).  Must not cover other I/O space,=
 as
+     * HP-UX probes with LPA and skips pdir setup for already mapped page=
s.
+     */
+    if (!hppa_is_pa20(&cpu[0]->env)) {
+        static const struct { uint32_t start, last; } io_btlb[] =3D {
+            { 0xf0100000, 0xf01fffff },     /* LASI */
+            { 0xfff80000, 0xffffffff },     /* central bus */
+        };
+        CPUHPPAState *env =3D &cpu[0]->env;
+
+        for (i =3D 0; i < ARRAY_SIZE(io_btlb); i++) {
+            HPPATLBEntry *ent =3D &env->tlb[HPPA_BTLB_ENTRIES(env) - 1 - =
i];
+
+            ent->itree.start =3D io_btlb[i].start;
+            ent->itree.last =3D io_btlb[i].last;
+            ent->pa =3D io_btlb[i].start;
+            ent->access_id =3D 0;
+            ent->u =3D 1;
+            ent->ar_pl2 =3D 0;
+            ent->ar_pl1 =3D 0;
+            ent->ar_type =3D 1;
+            ent->b =3D 0;
+            ent->d =3D 1;
+            ent->t =3D 0;
+            ent->entry_valid =3D 1;
+            interval_tree_insert(&ent->itree, &env->tlb_root);
+        }
+    }
+
     cpu[0]->env.gr[26] =3D ms->ram_size;
     cpu[0]->env.gr[25] =3D cpu[0]->env.kernel_entry;
     cpu[0]->env.gr[24] =3D cpu[0]->env.cmdline_or_bootorder;
=2D-=20
2.56.0


