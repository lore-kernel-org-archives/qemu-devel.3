Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDF2EDEC14
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 06:30:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxfja-0008Nr-MU; Wed, 04 Mar 2026 01:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfjN-0008Fe-8p; Wed, 04 Mar 2026 01:29:16 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vxfjE-000581-Ez; Wed, 04 Mar 2026 01:29:08 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6246SbBN071191
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Mar 2026 15:28:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=En1yBiLIRHFeSQzQveGaZuLdWFSDfzKpc6bfIebW9wY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1772605724; v=1;
 b=cAIt0G3D1SbGn51Zh68vptPpMasipzrPeyTqgB6hVnqB4r8a9cRKzpJ1enKS3v28
 xc8TmlWlw+m3ff2CanBLxm4GRizxtpXMRtqWZm6X0DE9guSgIBm2ojKeQNAmPpF/
 eCrlmI4WDpo8StoYLestzRQ9bC5RWbRolNePOgUujqfcWUjEZay2eJlwGgo28a5M
 Pz2D5S7oh1ukgh5ti2fy+6odOTri47fELs4++Bfl0jHbVzBuT8jOXBgK28ldjfC+
 jPlCLTBC8UIZMgq33DN1bQmd7mI9iv9eJllKb+HCQR52+uFHgyoNnRx0JpFewI1n
 gRV3FN3kS5t5hPEH+KYR5w==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 04 Mar 2026 15:28:33 +0900
Subject: [PATCH v3 1/4] contrib/elf2dmp: Grow PDB URL buffer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-nvme-v3-1-bbb1b7fd2d0b@rsg.ci.i.u-tokyo.ac.jp>
References: <20260304-nvme-v3-0-bbb1b7fd2d0b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260304-nvme-v3-0-bbb1b7fd2d0b@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-5ab4c
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The buffers used to construct a PDB URL overflow when the "age" property
is greater than 0xf, so grow it. This also simplifies the logic of the
URL construction to use one buffer instead of two to avoid the chore to
synchronize the sizes of two buffers.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 contrib/elf2dmp/main.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index d046a72ae67f..a62abadcc049 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -494,18 +494,6 @@ static bool pe_check_pdb_name(uint64_t base, void *start_addr,
     return !strcmp(pdb_name, PDB_NAME);
 }
 
-static void pe_get_pdb_symstore_hash(OMFSignatureRSDS *rsds, char *hash)
-{
-    sprintf(hash, "%.08x%.04x%.04x%.02x%.02x", rsds->guid.a, rsds->guid.b,
-            rsds->guid.c, rsds->guid.d[0], rsds->guid.d[1]);
-    hash += 20;
-    for (unsigned int i = 0; i < 6; i++, hash += 2) {
-        sprintf(hash, "%.02x", rsds->guid.e[i]);
-    }
-
-    sprintf(hash, "%.01x", rsds->age);
-}
-
 int main(int argc, char *argv[])
 {
     int err = 1;
@@ -517,9 +505,7 @@ int main(int argc, char *argv[])
     uint64_t KernBase;
     void *nt_start_addr = NULL;
     WinDumpHeader64 header;
-    char pdb_hash[34];
-    char pdb_url[] = SYM_URL_BASE PDB_NAME
-        "/0123456789ABCDEF0123456789ABCDEFx/" PDB_NAME;
+    g_autofree char *pdb_url = NULL;
     struct pdb_reader pdb;
     uint64_t KdDebuggerDataBlock;
     KDDEBUGGER_DATA64 *kdbg;
@@ -583,9 +569,21 @@ int main(int argc, char *argv[])
     printf("KernBase = 0x%016"PRIx64", signature is \'%.2s\'\n", KernBase,
             (char *)nt_start_addr);
 
-    pe_get_pdb_symstore_hash(&rsds, pdb_hash);
+    pdb_url = g_strdup_printf("%s"
+                              "%.08x%.04x%.04x"
+                              "%.02x%.02x"
+                              "%.02x%.02x"
+                              "%.02x%.02x"
+                              "%.02x%.02x%.01x"
+                              "%s",
+                              SYM_URL_BASE PDB_NAME "/",
+                              rsds.guid.a, rsds.guid.b, rsds.guid.c,
+                              rsds.guid.d[0], rsds.guid.d[1],
+                              rsds.guid.e[0], rsds.guid.e[1],
+                              rsds.guid.e[2], rsds.guid.e[3],
+                              rsds.guid.e[4], rsds.guid.e[5], rsds.age,
+                              "/" PDB_NAME);
 
-    sprintf(pdb_url, "%s%s/%s/%s", SYM_URL_BASE, PDB_NAME, pdb_hash, PDB_NAME);
     printf("PDB URL is %s\n", pdb_url);
 
     if (!download_url(PDB_NAME, pdb_url)) {

-- 
2.53.0


