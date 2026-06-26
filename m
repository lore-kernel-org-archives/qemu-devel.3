Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EFAC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd7kw-0007iD-7G; Fri, 26 Jun 2026 10:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1wd7ks-0007i2-B0
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:42:06 -0400
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1wd7kn-00026l-Sa
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 10:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1782484915; x=1783089715; i=laurent@vivier.eu;
 bh=/wVeCr6T8rkudDfAOgVgnsJ0LRzW/ikYu6FDLdw4uWA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=c2ayWx907pyALpe8mLutXkkTvCFdmhVdBUoSkiTbq1+XFumEPKp4RBc07CD0zAKP
 c6qwkzBOVo9wZTuusN4cbilHk75xrn+XjFfSOeNvbUkQCjXMubZK/M+jsueKJD6QI
 P5JE8KNlhC+fGdVGglbXENFYip1fzZfSJy5ClkjUPWd3awfI11a8qexPHs+NTbt+X
 9E7lgJV69DaI+iMia/3yTPmQ99tVeSx+AzK4t+D9n5Wxk6uFH9XuLMXzpQBU0MKzc
 vTAzY97zBcuxD60UIAOElUVm5lU5xwvAtV2C1KstHEKlvXKp6VSbL4HXZ6raECyBd
 6MI7pbzKFmbu7FMuOQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MVNJ3-1wke0a34tT-00Hu6e; Fri, 26
 Jun 2026 16:41:55 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] target/m68k: fix 68040 TLB permissions for clean pages
Date: Fri, 26 Jun 2026 16:41:54 +0200
Message-ID: <20260626144155.2207356-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:p0kddpllob+24yvDJ7jv2titX4D/Pp9EAwfgQPMvXBURxmesnpm
 VYMNjZkYuh6HVfZzmOdebogo+9YKlUISwfOTlLvjNwgwbYvKJrapDueVtvUET+G88wFSQpN
 pqbSWOSQMFKKZ68C6AYLtnmFTP4oqDB2u6F2cPhrfzh2XIlILkEW/t1RMbISNd7KjLNFvBu
 za+gOE55BWXFDKXasQL2Q==
UI-OutboundReport: notjunk:1;M01:P0:K8W4u5VQN/c=;CzumGBBxHsLpDB5zyxPGNVcNAkw
 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
 a4JcVFBA==
Received-SPF: pass client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

The 68040 MMU must not install write permission in the TLB for a page
that is writable but not yet marked modified. If a read fills the TLB
with write permission before the page descriptor M bit is set, a later
write can bypass the descriptor update and the guest never sees the
page become modified.

Track write protection accumulated from upper-level descriptors and
only grant PAGE_WRITE when no descriptor in the walk is write
protected and the leaf page descriptor is marked modified.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3486
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
=2D--
 target/m68k/helper.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 5f91d206f596..2cc19aa567d5 100644
=2D-- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -737,6 +737,8 @@ static int get_physical_address(CPUM68KState *env, hwa=
ddr *physical,
     uint32_t next;
     target_ulong page_mask;
     bool debug =3D access_type & ACCESS_DEBUG;
+    bool writeprot =3D false;
+    uint32_t ptest_sr;
     int page_bits;
     int i;
     MemTxResult txres;
@@ -756,7 +758,7 @@ static int get_physical_address(CPUM68KState *env, hwa=
ddr *physical,
     }
=20
     /* Page Table Root Pointer */
-    *prot =3D PAGE_READ | PAGE_WRITE;
+    *prot =3D PAGE_READ;
     if (access_type & ACCESS_CODE) {
         *prot |=3D PAGE_EXEC;
     }
@@ -787,7 +789,7 @@ static int get_physical_address(CPUM68KState *env, hwa=
ddr *physical,
         if (access_type & ACCESS_PTEST) {
             env->mmu.mmusr |=3D M68K_MMU_WP_040;
         }
-        *prot &=3D ~PAGE_WRITE;
+        writeprot =3D true;
         if (access_type & ACCESS_STORE) {
             return -1;
         }
@@ -814,7 +816,7 @@ static int get_physical_address(CPUM68KState *env, hwa=
ddr *physical,
         if (access_type & ACCESS_PTEST) {
             env->mmu.mmusr |=3D M68K_MMU_WP_040;
         }
-        *prot &=3D ~PAGE_WRITE;
+        writeprot =3D true;
         if (access_type & ACCESS_STORE) {
             return -1;
         }
@@ -842,10 +844,12 @@ static int get_physical_address(CPUM68KState *env, h=
waddr *physical,
             goto txfail;
         }
     }
+    ptest_sr =3D next & M68K_MMU_SR_MASK_040;
     if (access_type & ACCESS_STORE) {
         if (next & M68K_DESC_WRITEPROT) {
             if (!(next & M68K_DESC_USED) && !debug) {
-                address_space_stl(cs->as, entry, next | M68K_DESC_USED,
+                next |=3D M68K_DESC_USED;
+                address_space_stl(cs->as, entry, next,
                                   MEMTXATTRS_UNSPECIFIED, &txres);
                 if (txres !=3D MEMTX_OK) {
                     goto txfail;
@@ -853,8 +857,8 @@ static int get_physical_address(CPUM68KState *env, hwa=
ddr *physical,
             }
         } else if ((next & (M68K_DESC_MODIFIED | M68K_DESC_USED)) !=3D
                            (M68K_DESC_MODIFIED | M68K_DESC_USED) && !debu=
g) {
-            address_space_stl(cs->as, entry,
-                              next | (M68K_DESC_MODIFIED | M68K_DESC_USED=
),
+            next |=3D M68K_DESC_MODIFIED | M68K_DESC_USED;
+            address_space_stl(cs->as, entry, next,
                               MEMTXATTRS_UNSPECIFIED, &txres);
             if (txres !=3D MEMTX_OK) {
                 goto txfail;
@@ -862,7 +866,8 @@ static int get_physical_address(CPUM68KState *env, hwa=
ddr *physical,
         }
     } else {
         if (!(next & M68K_DESC_USED) && !debug) {
-            address_space_stl(cs->as, entry, next | M68K_DESC_USED,
+            next |=3D M68K_DESC_USED;
+            address_space_stl(cs->as, entry, next,
                               MEMTXATTRS_UNSPECIFIED, &txres);
             if (txres !=3D MEMTX_OK) {
                 goto txfail;
@@ -880,23 +885,28 @@ static int get_physical_address(CPUM68KState *env, h=
waddr *physical,
     *physical =3D (next & page_mask) + (address & (*page_size - 1));
=20
     if (access_type & ACCESS_PTEST) {
-        env->mmu.mmusr |=3D next & M68K_MMU_SR_MASK_040;
+        env->mmu.mmusr |=3D ptest_sr;
         env->mmu.mmusr |=3D *physical & 0xfffff000;
         env->mmu.mmusr |=3D M68K_MMU_R_040;
     }
=20
     if (next & M68K_DESC_WRITEPROT) {
-        *prot &=3D ~PAGE_WRITE;
+        writeprot =3D true;
         if (access_type & ACCESS_STORE) {
             return -1;
         }
     }
+
     if (next & M68K_DESC_SUPERONLY) {
         if ((access_type & ACCESS_SUPER) =3D=3D 0) {
             return -1;
         }
     }
=20
+    if (!writeprot && (next & M68K_DESC_MODIFIED)) {
+        *prot |=3D PAGE_WRITE;
+    }
+
     return 0;
=20
 txfail:
=2D-=20
2.54.0


