Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22292E9B354
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Hi-0004wZ-MJ; Mon, 02 Mar 2026 05:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HU-0004rx-SJ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:42 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HQ-000628-R2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446414; x=1773051214; i=lukasstraub2@web.de;
 bh=f78P3av60iHXeYLfBcNIb/W7089vNVfF6LL/haLWLTM=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=qBf8Z2UJtQ5rLE9ijeQaAl50oG/pgQ6iSKctTCg9VhHceUU81rQquqqYngzhTiJe
 RAT9NdVlqHzbqaiMYQCU0DxYZnFXXbbOpVqeO85YbtVn7c4uyvSLaPADRGTngymZY
 edNyUzY6MWcywqH1Vi9xrKXOEa1XdLEN2AU2dBlTlfkd9VU14EPnde0q6hiSkKeNZ
 c+Km95VXm/gnz13fLWWojD7ilXpHJ5sJ5vHEhdrGXRdezXZAKM66J1Sak0w5nFAQW
 4pxqeT2bvuLylzi9mWxlAV+sU02O72AylQEQ7XVbQqGKzOChMz1et90RAyYMqbYDQ
 IoW2j1d0gikzE2daIA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZjET-1w9ILZ3KLf-00SJyj for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:34 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 06/21] ram: Remove colo special-casing
Date: Mon,  2 Mar 2026 11:13:17 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-6-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=vR/wp6SYVr5uUbTS+XPqPG4RkOoroNdE8dtNpsOBphM=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAFRb/ijkis+I9elsfqdxE28fYK3vfTiDfBz
 25p7sYqDjuJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBQAKCRA1qwsonF2y
 WGMDD/9f4FaADDga23W9ZLANwKzShih9/DieXv4cqFsq3eAzhnROWWgX2m0vwr3L1/ZDevhGE86
 FPLgjR5zqZLWfXBu/ZODypq8aazOdEMCLEGf3Tc7BnJN7eehAuove16h59Fwzd6SN2dgjFXhLll
 4/eOSnr7cWRh8cK4BPWLrlclQOJr4Ar+0eg+Nmi4UVOt7ckNM1CmRmGLVGdOuzYIWMBW7nGIiw0
 myiBSc4obD9oDot2qwpNhRU+LKRcTY706REAy6iljnL+GsMhDVz4v2+PEjcV7qdSK436sD3HaJF
 mWD/bjEQkzvK14S7qXe12Qqui61RUb2FV8D4onwXJByqoHFzwh8y9aIDtdy79Sulv+4CTWvw7g6
 HIctgpTh6H2g3wTZo3jw80l3u9coNTsTKw9nXwuAPCfoohq4k9iK9Yslpj5DszdDar/qhPHM551
 0bf8nrpxUOMFRomsxVfjro7v271VrOJF0AwEgJQ1jO29oY4o1RRZkFQ74y3rbyxox+NObUyz4ts
 kb9CKP0ILr6A/+igMOheksUnxxomGksDI6AnxSzfpYekaayc5NwjqUI6aqy76K+FsK1nIfJBcpJ
 Hh95BgRiO6LIh4A4WOGZQbCiDWAIvNutj82WXB3nRzMh4n+9tP1MRFmVYmo9WoGdKydvaAdmd7a
 jy3tZ4w8/O1ancQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uryxbsbcF0BJMh6E3oo+L57oneyE7UqqEp56N11aiBAULixTgWZ
 gRiA11TgF76lhxCUhzsmdDvQPuwxdHDn7e5z4kp7LvSUTGVDrMLInllQyONMM//jU1dcQys
 KoVfd/t5pgugF31iwVFT6u/z/J2A2jb/0nv/xrXfQ5F4phsOxgUFkua+XPAQdlq0oOP2VgW
 UlWAK4EU/X+Kla+3Z9V3A==
UI-OutboundReport: notjunk:1;M01:P0:hm90QgHNBFs=;LnQGNHFskg4VBAj8ZZnSdwRYZaK
 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
 Wm4PnCoHMjKS1ZVn8=
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We only enter colo state after the precopy migration is finished
so this if is always taken.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/ram.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index aebf77aa0b861e00516d6f1090aebefdd0d97e54..979751f61b30d6c4b878866b50=
11507e7c519176 100644
=2D-- a/migration/ram.c
+++ b/migration/ram.c
@@ -3116,12 +3116,12 @@ static int ram_save_setup(QEMUFile *f, void *opaqu=
e, Error **errp)
     RAMBlock *block;
     int ret, max_hg_page_size;
=20
-    /* migration has already setup the bitmap, reuse it. */
-    if (!migration_in_colo_state()) {
-        if (ram_init_all(rsp, errp) !=3D 0) {
-            return -1;
-        }
+    assert(!migration_in_colo_state());
+
+    if (ram_init_all(rsp, errp) !=3D 0) {
+        return -1;
     }
+
     (*rsp)->pss[RAM_CHANNEL_PRECOPY].pss_channel =3D f;
=20
     /*

=2D-=20
2.39.5


