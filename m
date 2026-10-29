Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF10606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=cO3GKwi8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMYCS-000416-69; Thu, 29 Oct 2026 18:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYC8-0003vB-Cj
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:02:02 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYC2-0006WO-Gt
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793311303; x=1793916103; i=deller@gmx.de;
 bh=NPSaqlz7Sfk9dhwFR7LeTiiPGoJtY7nIz14pw9WSgIs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=cO3GKwi81xs3Be9PbiYmjrCmOlygR7PBpK5IRaZBhTe3R9rJDZw7LF01CHgpicFA
 NNfhrsiqMbnvoMfNE0hFafYH9KHMe0pQCPVpELdp9HqbVVsuzaV717ByxcegyMzqu
 GVLj7CulefLYQftz2n0ZkX42qFldUBfbaZVWQ71D7YibDP7Gw8liY4E+vSb0YIsaZ
 RBSDtpxxAxwSkyJjhgsoqaFFfSDqWho7U5lJCUApcIW0b9V5qCFDydPwZED4gvabO
 nyG0829d7ImqZQREtlY2c4viFf/vdk0t37KBRjTocKcN8NZONGX/WB5I6LBxN74nf
 rGKcK42fEPMg5U+IfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7JzQ-1xUHQg2wY8-000wzt; Thu, 29
 Oct 2026 23:01:42 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 06/10] target/hppa: Preload I/O-space BTLB entries for LASI
 and the central bus
Date: Thu, 29 Oct 2026 23:01:31 +0100
Message-ID: <20261029220135.412284-7-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029220135.412284-1-deller@gmx.de>
References: <20261029220135.412284-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XDRRZfWJcY8V/XpNhIxtpcEbrl37TOZBdwTG703JYQhs63PlapP
 9v8t6JSmr87x8g3RMDu8ADaEF4lZndK8FnBZzsIJQ75dO83lJafPEom1bGPG7Obyjz/r3U4
 olHg/uNLA6fCtNOPLTiPHZyOHI6smFW2sfnemu9VynmpIHLNpPmWCnlRie1avmy/NDEGoIv
 sIGF25ciqs8KMiaw5BiDg==
UI-OutboundReport: notjunk:1;M01:P0:D9D6H+GWHsA=;piuZkWuv9FWgLJemSkHbA0dBwAh
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
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


