Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557FBFD007C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 21:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwoUA-0004BL-Lh; Sun, 01 Mar 2026 16:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU9-0004Ap-0o
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:57 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwoU7-00043e-Hj
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 16:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772401065; x=1773005865; i=lukasstraub2@web.de;
 bh=QnjLUeKSVlL/TnFvcfaE/7Aufpnl6G2wkPqvyU4/A9A=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=w0peG68FFD/9SwR9umuXH10qnSYnf0s2kgoySEEneVL7Lk8iO3x01+OUOiXMRCl9
 ZWpGvtYH9JAN/n+roDiw/oNmjQgXjmwvvga4x42VQEPk9JgtAFuYoqdyfNUY24OXi
 RSCNChysTC7ygZmBbZ3tzR9IDW1qS0QNV7dSWCndXpyyFjiuT6j5Sms/GihA+wMlK
 nd0DSek3NhlpEjYG+TYUB9dxKa6/TmWmTvbnTyjM/6BvFJpoNJNb9DMc6nms/KqOp
 4pmLtovi5TJmKZPlvtC0dzn4lHZySIooI+ZHPL+gXt5Zfz7NzVPVsouSGuQfaWWro
 +abD7bTxQIyxM0gTwQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N01Zk-1viz6644j0-00soda; Sun, 01
 Mar 2026 22:37:45 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 22:37:32 +0100
Subject: [PATCH v11 12/21] colo: Do not hold the BQL while receiving ram state.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-12-14c8a70c36df@web.de>
References: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
In-Reply-To: <20260301-colo_unit_test_multifd-v11-0-14c8a70c36df@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppLGhTQwpasy85VIq1RVPV+Ce/LEJ38B33F89h
 5WVAX7hjluJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSxoQAKCRA1qwsonF2y
 WEpGEACfYMCa18UOi09P78kiUbHnxk8uRk/qYwpU3UEIOq2zjjzYBHCyyGCD9OmlLuka5Q99z2g
 05fYxDEJdu2weQPl2lPxekKpX3oYZ7DeP1S2unyDyfvq/GgUuN58wAQM/WZHVFlzj8zmzMzpoQg
 uO7MSxwoVj6FR6ul++q7Xw43LP2iPmCyvn8ce3a5i5rO1bUrgsqarINrMmvQaXzcb9DfFEHvcCQ
 sieLyLBFmtUU8TQFZNckBYnRGe41D4KD9wSJE6SHfq9hpTroSssZZWgvwcC/xr/VYR7LpF5UsB1
 8vCKE//0302VWstrAXBbDCmS335dFhXTEDnt6+IlLJP62nT+k8bkc7NbFScZkc/xFF533LxHdrC
 Lu33RmdOm0psae7xbdrI6aNaUMUa3ztj0Bm+Rw0zVwGlUsOydD5jJ6gCO2XBiENokRDmQJr9Ti2
 4XDuvAjMxyd5XnOHJkTlR8WImMJBIUcZh5/Syapv43nuV/phJFM5IZk5r4hPHgDJ/4n1yGk/+bj
 wRlc7ePsX743b1v6ujryI1BDYFbaaz7XgpX+xExMYmMphkpkcIQKpQqVsIYXUHTg3nfgbF9udcO
 BiMr7hD/uLwzvPSnTPcxlAivDMnh2Qgp1YNPwQqFsaBD65MVqwX9j72GLgYq3B7ItxYO2uJpI/5
 3OdF7Gx0D7b5F0Q==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:/K/0h091Pq6/F47AUhg5pJspEkqEyF9EXu1Kv2gGOAO+VbR2hHu
 M+x9RimgBYijqwJAkBthHxT6tbaLEP1lUJ00WxCPsXQ32R+KKxgeBGObb62nJGw0c0yd1xq
 gvj0xkLbKFhRZctHdzd79LWeJMLpi3G1DufCm9rekxceD9d071rjELAvQbnZgrJTfyblCx5
 2zceIy6taikiV0s2EfiKQ==
UI-OutboundReport: notjunk:1;M01:P0:bZim7Sz1H30=;EAjwnaa3xJkyyy+XhyJ+X1OE3ic
 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
 8c4drE7g=
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


