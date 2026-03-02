Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1993AE9B36B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1j7-0000mr-Il; Mon, 02 Mar 2026 06:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1io-0000Eg-6J
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:46:01 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx1im-0006GS-JZ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:45:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772451940; x=1773056740; i=lukasstraub2@web.de;
 bh=QnjLUeKSVlL/TnFvcfaE/7Aufpnl6G2wkPqvyU4/A9A=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=CvagSwxz5asMARUn9VyHihCjhfyr1dGamrGoXaSCs3jU1zO0GthIdPmZI7pQ1/5m
 nZT0EpD5Qwf1oUnqcGRHZClmJ/VJFqOPwUPckn0BcYc+9q2uXEsL+U5WpfZAIn5Sp
 47QFdXrKWQzxZ56wxDVndset/dH0qJwNOGy99cSTQSvceavrMmG/TeMwAmTy34nhY
 1lombQIYtt4zc/wsyb5BrBVhN61CBIzuYvdM0Vron28gIhu4U5SIB3BgOu4UaANro
 ynGHdiGN2/2ERf2IIAml2vtpP0TCcAuhw1kqLRR1j7a4RZXjszqgCSzxTg8hb7V5r
 In5J67vw7l5ERbtsBw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0qr9-1viVft0gbt-00rzW7; Mon, 02
 Mar 2026 12:45:40 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v11 12/21] colo: Do not hold the BQL while receiving ram state.
Date: Mon,  2 Mar 2026 12:45:27 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-12-d653fb3b1d80@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-d653fb3b1d80@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=5X2xJUQOZtX1vrH3iSE65Qld5dEQ8f6o9Mt01ciNeAY=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppW6UM3GbEL1JTxQTwWd0bCkjp5XF2dKHM/j2Y
 xY2vxpKNmSJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVulAAKCRA1qwsonF2y
 WCJaD/98+IZ2ZsE1qVOpXkirCkVQGeqzbkyu8nQiQ5FdhyB5lsv476oRsoBDkYVCTti9oPy7WIn
 XXpIsMNj4a36SHrS9XW3c7zBouLS1EdaueHK2FlaRnqxf4Ag0GTFG318bCrWwaZIel3SZTTdJKx
 3ZICeAPYedNDBya6rnu2KO1FCyEIwrMtgIwjcaafMzmdifgdYdmoO0GWa57MRr/udYPX6J3FZWL
 iOtUIiHTKbpX7cjvFsJQHyOzcLrbjxB7/Xwdw7n9+eS6ihdHVjNepaCsRon6WQXO/qwEFAlQQa+
 LeUhITFqgJy1OeawMIODhE/KK513U0OdJ9D2cLK6+MkbhN3XLYnXTKvaYcEDMJQvEJK78CF0MH/
 0HFxlbf8qUQG7o7fzzv4wjK6mJTBiSiKjp51oq4KDbfnh5T8DMcCvOsnymeohNARiMVlQdhL3Bn
 lF8GucPdi48X3/EaOOVXdOqU28iImPDlnGcXlV7ZqZKUfpH+N+qx87X3TgDPws9+RrppVubUP+b
 BhIpD2LUZ7JbgXgx1GKpOY0odiC2rj0RixzWXiQQO1XlV+YH63vYIlPNCbIqTJ8DtELXzgXuQma
 QUa7IbR+SBYH7pWiWsfkHuk3GxsQJe00CptSoFJQjKbgh5CF4bqpejj5fa42LIMzmySFTjSWp4d
 LziWeVJzbrPCc1A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JL2tDA/QryzfxbXc0gGb19eragutbnhZXYYvzUOXG9TmzGaBZDH
 di5i0iZ8K9UjNfi4JLTDADCKYUkbZiaSP4X/xcp4AJLgr5hneMIbYENTSW5sGiFK9OmyFQg
 4RuDCU2c0AOL/AtrmJrL+Qtyb1zlXSr/AmTQVCPs14V7yvGocwPDleuIqbpNhZh7WGVPCpG
 RCGMVR/BJxob73xOk3RkQ==
UI-OutboundReport: notjunk:1;M01:P0:+yQFzDFNMiY=;JFr+60XdaIkS57VMnQV3O6b6U00
 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
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


