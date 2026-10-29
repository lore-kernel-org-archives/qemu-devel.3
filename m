Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A6606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=IkTpkoPN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMYCQ-00040c-OS; Thu, 29 Oct 2026 18:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYC8-0003v9-An
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:02:02 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xMYC2-0006WW-G4
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 18:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793311300; x=1793916100; i=deller@gmx.de;
 bh=er/hjKea1ppe++PqT/djQu/SWXDLClToG46xBj6nuvg=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=IkTpkoPNVRpTc2J/rD1e9A7iGZS4KcVxGTi7dzk/Txy4xojzDXfHX8A+Qzb+/4NB
 QFONTZ1y845asfq0s22xBYg2YiJi63Q+rk2zdUspFvTugl3g4xEYB5i3WnoQ9G0vd
 E97o2ejI/hoJGXPZ26Ib3qlpZDARQeljUqiX2ZziTmXeoSZ/ErbdBePRuuo5qMi2I
 tSqMs0G+Ky7Wo7ZoiUHgPF9iLmmEHwqTdeIE6wnWj+GFIhY9wV3S/XqkcSyBxba13
 eD8SG4Ja9wUboSOttFz8T+ceoEyvguAisLvf06v/vjIMTx1laJnckYCJut3J9Z0Ev
 g7WrcQjwwPhz4pDtQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV63q-1wwfaM11xW-00XHxP; Thu, 29
 Oct 2026 23:01:40 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 03/10] target/hppa: Use 15 bit protection IDs on PA1.1 CPUs
Date: Thu, 29 Oct 2026 23:01:28 +0100
Message-ID: <20261029220135.412284-4-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029220135.412284-1-deller@gmx.de>
References: <20261029220135.412284-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MWniqcTUTHFBikg0sThCey0/bqNgThnSWLPCyniNWIBCNRWD/Wu
 W7f+cU2J1YgDG+lpSlmVtLIMOEmakn49/fbFDRWJsqL4rAyfId+zRN9yGr4gUX5/ZP40aKR
 Q4VesK9qCwaq02k5xqPbF4r4AGV+8xh/l+C7wuNOuwAqMzb/R11PA4jEmztvJ23Z3yWfpAm
 mOtXy6cy2FzDMTzBUWERw==
UI-OutboundReport: notjunk:1;M01:P0:WFRu/DE4ak0=;FXqxbn1PX2wyCkSJE+P2+HMT0xV
 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
 IsxXHr
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

HP-UX 9.05 only supports 15-bit protection IDs and gets a protection
fault on its own interrupt stack when allowing 18-bits.

Since the architecture manual states that if smaller than 18-bit access ID=
s
are physically implemented in the CPU, only the appropriate number of
rightmost bits of GR[r]{13..30} are stored in the TLB.
PA7100 and PA7100LC only support 15 bit protection IDs, so use this
amount of bits here.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 target/hppa/mem_helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index a5da0bc851..7a316f59ea 100644
=2D-- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -538,7 +538,15 @@ void HELPER(itlba_pa11)(CPUHPPAState *env, target_ulo=
ng addr, target_ulong reg)
 static void set_access_bits_pa11(CPUHPPAState *env, HPPATLBEntry *ent,
                                  target_ulong reg)
 {
-    ent->access_id =3D extract32(reg, 1, 18);
+    /*
+     * The architecture manual states that if smaller than 18-bit access =
IDs
+     * are physically implemented in the CPU, only the appropriate number=
 of
+     * rightmost bits of GR[r]{13..30} are stored in the TLB.  Older pari=
sc
+     * chips (PCXS, PCXT, PCXL, PCXL2) only support 15 bit protection IDs=
.
+     * PCXT' (pa7200) has 18 bit protection IDs, but only 16 bit spaceids=
.
+     * We currently emulate PA7100 and PA7100LC CPUs, so use 15 bits here=
.
+     */
+    ent->access_id =3D extract32(reg, 1, 15);     /* 15-bit PA1.1 PIDs */
     ent->u =3D extract32(reg, 19, 1);
     ent->ar_pl2 =3D extract32(reg, 20, 2);
     ent->ar_pl1 =3D extract32(reg, 22, 2);
=2D-=20
2.56.0


