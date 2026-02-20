Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5D7C5AD68
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXg-0000UM-Bm; Fri, 20 Feb 2026 14:52:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXb-0000Rr-LT
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:55 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXZ-0001Pt-KF
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617110; x=1772221910; i=lukasstraub2@web.de;
 bh=QnjLUeKSVlL/TnFvcfaE/7Aufpnl6G2wkPqvyU4/A9A=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Tei7qqSG+yuCG5hTZiP4AY8XkGNgrIsKxJWrfvVrBc8R9LkqmUCWk3hLQDW+Mi5g
 mk6oQYaYMcQeRJ5jBjct9ZTeM9y7ouq4T1lIGNfMTv4bIkmxeZd3c7PxLkQzYARq1
 Sv78eD2+6Iq3zjMhCwfXqwE0FcRR/UX5MIujj0cwTMpG9hKR1I3/yKjbBOMIWLo4I
 YvNsbHNUe90BHxXkK9x+Mn+siomPzA/injcu0FilMIFiJdQnHlwxRLdHb1ONzAXyv
 6QBfcXWr+aKmFCZs5IW22BHrUaTyT6D+WUxVbNUsp1JkSBl2bFyniE6oH/mYDCWb2
 Xg+MaW64YC15y3ueFA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mr7ac-1vQBns28m6-00ox7W; Fri, 20
 Feb 2026 20:51:50 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:34 +0100
Subject: [PATCH v10 12/19] colo: Do not hold the BQL while receiving ram state.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-12-bfe67d422ef1@web.de>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
In-Reply-To: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=5X2xJUQOZtX1vrH3iSE65Qld5dEQ8f6o9Mt01ciNeAY=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtOx5xoFuuv2+1WnpVFY0rvJEkEvS8aYO14T
 S/P3qysLSuJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TgAKCRA1qwsonF2y
 WMgED/0ahO/2mIt1oPBWswq58e29zNZ0kb3pTZTIkC8g5i1Nh5HSck0djdZnbKM2kLKmlE62BCa
 K918oPzh+GQXGnhRJNSoc8BfT2sxuhDOS11RKPzdre+zgWBvWZhUaI+0PsTDx1VR59rvthp8VLW
 7K/1Dej9JiR35+jIKtcmLtU5VgKo1XR40ytGSbUeUad6CHsp3CIjoDKRUGUJgtn4SHnwqyOZHgx
 rbwmExFbVth5ZEfkYCxnBZeE94Q+2jou8qGw9sstjN/PLdaIxqWGz95nzZa1psVOlfAxJKBJDc8
 NoB+yp2h14UH85Y2tsRWNhEWcEOYmaQHm1S2P4HTP2gyYRQcg3B2JJ8yjQ2wsjHStl/QFsc+pOp
 ejhdlla5skjhTB9twCJnhL1P5yS9pZG0t/D/BEhycnSRyjWct9MJArzuL1iQBLUn1qGjTYicDdW
 5aiAAxDY56Gv4bfZiWp+Nkg8dyNUQgxJniBgjz0ziuPOLuLjINNLsLI07Yk68MSjLdUoY8UZxB0
 DeefcqsMjCoIqCNOLcjAF1K8IbDpZSvtu4dhFaot72D26u07AY+GdwV9qF4Bih/7+ozqcZxfr0U
 xaAkH4cT6i5Rxrr/egStKLjlEEZTJCUjRMG7jBFu5ZGziUllk2YSkpw1DEmLMNLYr2BxBKbRB7G
 kmEMp64Xnm6K8Cg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:JcS18YjSgDLEh8brrmFR0fOq7k4cO7Qee1u8wz1yuH2DwhsWCFl
 GU/80QjtGwosmDMNP/o+ZZX7es1EBbJ4MGVb+DaSuwbwk05gUh1blmlRDeJmVGj5rVHh23f
 byXyDRGqSzh9YBu3c+Srf8G8cYiWCed8N4U33Pz0msKLSvw+kRV+Hlxe0vkk17lrYYwntc2
 4XQ7SEN8iJpuCMy83lw3g==
UI-OutboundReport: notjunk:1;M01:P0:Z67JpTiCL6k=;Akg4fXzDMFLq3IkFB3p9ELOzoy+
 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
 jRqqjNuI=
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


