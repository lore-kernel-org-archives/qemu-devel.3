Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432B2FD0062
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmHk-00014v-Is; Sun, 01 Mar 2026 14:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHj-00013k-0e
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:16:59 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHg-0003VR-Ch
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392613; x=1772997413; i=lukasstraub2@web.de;
 bh=QnjLUeKSVlL/TnFvcfaE/7Aufpnl6G2wkPqvyU4/A9A=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Uh3wqqlws9NqfN4CNLPrrzC4oZUJnR/614DLnVrWVRa4CPotSxDdamSK2ju74L7e
 91+IQDxWAmpTb9il6rWb+b0+ihZKYWgJCqlzy2/F7S4aacoyECknszr1JtMZmSlzA
 r6U+r0uRHicvTYDqNXACplETWg8e80oHj06vm/ZhsXDVJZQl2EsR6mAaMeavDXVCm
 5tV8bf6kzdtD1tkR+WiY09I4qAk21fxzr64E4Pn7sggHGhUEBItUjr0EQ2yoT25st
 +6eg8UdCslPZr2JafWpgG7marSjHCY70NWIqzxDN9+gFOTnX2QUuh+R4qtD3eNqqT
 uSHSwND4lIbvtlifaw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzCED-1vkJwV3G2l-00rROj; Sun, 01
 Mar 2026 20:16:52 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:37 +0100
Subject: [PATCH v11 12/21] colo: Do not hold the BQL while receiving ram state.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-12-a9701e795d7a@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-a9701e795d7a@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCd8eEdsLFEBB2z1lkOOT6cGqgrfEKhscBdk
 my76N6GJFeJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQnQAKCRA1qwsonF2y
 WM6pD/4pEQxQkU4SYMv9E2Ng7cbRVw1vk47Wt+NB4A2UVQIlH4edzYH+LuGqyh94++oSoDi4aqF
 37710X7oLSIEXkJ1V4FHSKui/oBgPfoJQeen8jK8utIkg3BJTA650yB9UEb2TEtz2X+qmR4bEoG
 P2vFT5H3wFdI19w1+Aj1werkSL1oPZ52G6flsjpZ4tpJcrgvwY8tsZtMMTHb+LJ54cFseGHfvKF
 t1XtbgFxN8TkHsqmA2qnXnjGHKyP1KeOwTR2QJbhcRqjb5sowhjkEE0eXDK/hE6pVEenjY3jRil
 hmo1yTsonSZqGKkEObswE50Nv/F/sCzWRoQLpWRg3JljxAcAcR9t7p4i1jgZDxvyl6gFLJWB7LC
 /LBmhRm1jMI4ybCpIXvLCGYUplz7UKFU9mMJo3LCo73qXjIOE1tB3kCrCpqWatSywigCc4QDXpw
 E8xrIBc2nWY37r+cLIxFLKS+YyhU0c2fkRAgFZrwfKiFzdlRERL52F2v/6Tx5s4mrCgNQr6fqbC
 kfQDT8Sr0dUwfXGWEjjTC3WFawJElMxFKzaHykZABtf7npMYyL0ICbWgw+9Db5OLu5F4b84dLIN
 kmx7r0Mr3bnNPaZdei+z5HPu1/Dr9nVd/I2n7J6/d0UnUYjPn5cAadBIyaF1YfhFGMv5XuQlkYc
 leybeRfyv+iy/Tg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:pj8Y9YlzlJnyWZj0yp3c6JATmHiP5LsV94+YjCTymMwJ7Hf7mld
 JGBU+Unp8b0fNlFZANlB59fYJ7vkfcUpXaGlALB1UQ+abnf+vatZcVqdozZqx4MtFU2rxTU
 2IIDq/7uD/bjjjbr7BrByVmjZp9ELpAb5GEg+ljzzDYYBArwqV4/B0CK3PasTR5ly8vns5X
 iaeBJ1JI1685PWCWrp52w==
UI-OutboundReport: notjunk:1;M01:P0:H6sjbsadCAc=;7ZJ2TdrPN9Ecz3Au7TBWK0JCSyC
 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
 1mst3VVA=
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


