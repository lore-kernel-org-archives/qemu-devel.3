Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EE2606A333
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=jRvsxTMA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN4Sr-0001ms-Mu; Sat, 31 Oct 2026 04:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4SV-0001iv-Ck
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:04 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xN4SS-0001s6-NZ
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1793435335; x=1794040135; i=deller@gmx.de;
 bh=er/hjKea1ppe++PqT/djQu/SWXDLClToG46xBj6nuvg=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=jRvsxTMASnJbWAN8Vxg+x35b9hjAH14VgIzXbbpihSd7xtWYDjzVH6YkP2kctllr
 Cw4ysutw+yqfQHZ+9gND/caSGjSNFNsiyb/tWcjfQBFL7qx+AIGyKppeSNaAA06G6
 iei6BC8lJx7iFvR+XkO/ro5hc7I8BZqO4k6HhyvUYO2z5uyzpF0f7FNWQ/N3xaVrD
 1gd6uT/Tvz0AlfyTLGOXab9FjGV35lFEdOP7fkWuYTBGOUaEOmvP3Xe/skTSfwJeA
 Zs4rw0oScpPvbKCVyvRcbDugHFRDRWLfG2hszVVRxiXofytAcCzSKsQCUuZGITqW8
 cWDIJfjGU93NojU5Dg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VHG-1wUXoD23Kc-00w0oJ; Sat, 31
 Oct 2026 09:28:55 +0100
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Fabiano Rosas <farosas@suse.de>,
 "Kirill A . Korinsky" <kirill@korins.ky>,
 Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v3 03/10] target/hppa: Use 15 bit protection IDs on PA1.1 CPUs
Date: Sat, 31 Oct 2026 09:28:43 +0100
Message-ID: <20261031082850.439293-4-deller@gmx.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261031082850.439293-1-deller@gmx.de>
References: <20261031082850.439293-1-deller@gmx.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iPzZ0xiFptPJHKMImmjwbu9c8wu5TPXoAdpmtiwl4bHQnuZe6E4
 wMKyTKCxzc73ZRMS6hfuzQJUAsArgqONFNOclNDt7iSbnmSXPJLC+7CIiWLgG915Rr6qv0H
 gdCDXs74LjUQB8YMNC2UXebozWkzpbbUSyTEKWWIuCS9RpThikBKOsOm1FH1t2jk7dW80MP
 9erQnl6iFWFqYcB87RJJQ==
UI-OutboundReport: notjunk:1;M01:P0:ZDJFxfyGjuM=;tVp4tG7Gs2LIXYSAIzuLIZ4lwiC
 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
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
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


