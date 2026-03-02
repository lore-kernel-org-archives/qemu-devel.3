Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0AFE9B354
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Hu-000516-Mp; Mon, 02 Mar 2026 05:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HW-0004tR-Rm
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:43 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HQ-00062S-Rn
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446415; x=1773051215; i=lukasstraub2@web.de;
 bh=QnjLUeKSVlL/TnFvcfaE/7Aufpnl6G2wkPqvyU4/A9A=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=FCBXKzoocnX+BIpVzQU2Gf8qwPK8nbTVrAmbtAuDZYZcj2RwCMXtBfLRLTs5I7L6
 tvvD4NYIgN+qw1QO3LZmCyO96RqUqS+cdGimt3b02/kvaeKLARnSgB9KmonOImBCI
 +vP3FMfUfed/YxEj5EAHU2gXJNSvKajDvee+5TvuFvo9AIWuAl6lmsMJhNF5YYoJm
 dASISOB9RtFOB+tb+BB5CXHWDHoT5UfhVq/CjLn7kBBXAvcUXDXXZi4ZO/3QFRd2a
 2QOXDrEdu2p2T9GtSjmgqjCGOIaSW/nNISV7bH17C/0ueqlyFUJVMcWipmUg25JWj
 FAqYzP70P70TZO0Ppw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtPvg-1vh8Jl1gkA-00zObg for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:35 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 12/21] colo: Do not hold the BQL while receiving ram state.
Date: Mon,  2 Mar 2026 11:13:23 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-12-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=5X2xJUQOZtX1vrH3iSE65Qld5dEQ8f6o9Mt01ciNeAY=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAFlo21JiUKbfdwKikD7uZOKtLYH2Ya44xoj
 /MJgvTiJGmJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBQAKCRA1qwsonF2y
 WKwOD/9hRcEq7Hs1CiyPP6SLD1bPMI1vwY+LHg5VjyA+8raWuImj2wztrACFTRxhg/mhMLCgAqh
 UUqnjnvWpTaocYm4nJFnuy2nAVOxez+Ddmqv+urRPOf3riK+FdDTMsPOJIh5fOGS+iNRfYczibG
 bxbvQTn7lI3xjoJrRr90IfhlCTVkzcAuuvo4kCmzHmiiNKmd/EaDI7MW2rYejXTSE435FeE5CwT
 /cUf0hEDCic8s5v/Y3ytuKgdl/FeYYX1qAvIyrvb4U5e9yef00/+X6N6tW9xTjKFuYmwwUIdOQC
 vMS9AjeauZs/xi7N1xGdnrHIgl01N7876Uh0LQNj19YV+7y11wJo0nIgUJrR8TagtEW/WMVkBb9
 a7bE/PPIU7NrH0nZpkT1TMfY6HM6UMUaouOLOf4zOJ6yqAqS+pfY282uXR3z8SZQv3MI8O95xZs
 zZN/gBO78z5+UsZSwJ32ttb4Bmby2gM2ZSa8IT7JXqvfTn/kdp2LwQVKzSYs3qKlAxqIZclbigD
 6Hpb7eCyIqm9SxSqTmUU26C9fOYW1Ca3ni/V+ivxFBy5lWL7IQeq0xvppEiW9dzD0/ClXqzoWPM
 guxxyQVfM1j0iNdnTu6jd5YsUddOEZLC5XHUsS2FJ692kIpxRDlIvK2Ke8kKIHW38/l4WLg8qGY
 jEyqEuvlCrMDiCg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qHywNqfO5/uWMExC+FzyhNKy1IpkONFXpOGlpmrrTl4HgOL4v/k
 w3R1XN5cZhoybfp0sa54uVpkl43Omf6t0o60Huzwo7Wl88u3u2aqYZgv0sP4eJjrWR4QXFw
 6wT4UyKHGvoe1WqA0iSayqYQ+Rh/PkDPB1Kc1DnFWPmeKP8InLFz1SS+NCHon6lkmQN7vuM
 onNgRUOJ3RjMqc2snebjA==
UI-OutboundReport: notjunk:1;M01:P0:lCZuSaQFVNo=;XTAn1KIIYMURvZCwVmQ+H74VZmq
 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
 0ilxM3ncYqrZBDOfg=
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
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

We only receive ram into the colo cache here and don't touch anything
else, so the BQL is not needed here.

Move cpu_synchronize_all_states() downwards, before we apply the received
checkpoint. It turns out that qemu_system_reset() already calls it
for us.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 3297aa593cd9f87bf1013598464cc581a9d23531..ce02c71d8857d470be434bdf3a=
9cacad3baab0d5 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -686,11 +686,7 @@ static void colo_incoming_process_checkpoint(Migratio=
nIncomingState *mis,
         return;
     }
=20
-    bql_lock();
-    cpu_synchronize_all_states();
     ret =3D qemu_loadvm_state_main(mis->from_src_file, mis, errp);
-    bql_unlock();
-
     if (ret < 0) {
         return;
     }
@@ -733,6 +729,8 @@ static void colo_incoming_process_checkpoint(Migration=
IncomingState *mis,
      * With colo we load device vmstate during each checkpoint, on top of
      * a vm that was already running. Some devices expect a reset before
      * loading vmstate on such a previously running vm.
+     *
+     * NOTE: qemu_system_reset() calls cpu_synchronize_all_states() for u=
s
      */
     qemu_system_reset(SHUTDOWN_CAUSE_SNAPSHOT_LOAD);
     colo_flush_ram_cache();

=2D-=20
2.39.5


