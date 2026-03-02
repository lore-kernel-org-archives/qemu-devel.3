Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942EEE9B34B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0O0-0006aH-65; Mon, 02 Mar 2026 05:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Ny-0006Yt-QB
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:22 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0Nv-0007Hp-TO
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446815; x=1773051615; i=lukasstraub2@web.de;
 bh=QnjLUeKSVlL/TnFvcfaE/7Aufpnl6G2wkPqvyU4/A9A=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=bXJH8BTtFWZf6YGwjw+IEeMJZ8Wcr7P6TK5AnGPB5zAvv1Ct/P0rv+mHdlgESVPZ
 PGSn/Iy9eob69/TEZsVZXzLhumtsGUYg3zaUsBmpuKMfEBpIH4vb6BcUJkMsSAY7H
 IrX4USUIG+nmmtBojL8bUYL4gkndsuZzCHqjiGRr/K9yfikREHNd7L+WA8ztLgUCR
 W8Oe9sDvryXO65X1M2Y+lXCr9Ovxc6xkWZy42jJnmF0JTqNXk54ZFKSaSc/g0vKyx
 KRkIWruaJfoWj6300ZTmj3Ok7GoOtk/bSeBPyDg07ObDE0DV8+c6bdS393lB6niDA
 P4LPypnAPQT5OoUM4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDMzC-1vncSm3PWQ-000uCI; Mon, 02
 Mar 2026 11:20:14 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Cc: Lukas Straub <lukasstraub2@web.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v11 12/21] colo: Do not hold the BQL while receiving ram state.
Date: Mon,  2 Mar 2026 11:19:54 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-12-a2d96276c707@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-a2d96276c707@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=5X2xJUQOZtX1vrH3iSE65Qld5dEQ8f6o9Mt01ciNeAY=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWQpF86Li+pUuBDzIKlIZ+bSbKJcDlHmme39z
 YZ0ShE7ok+JAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVkKQAKCRA1qwsonF2y
 WLnhD/9xuw5I6Ockzdrs0/ySugSCPkMIr2pCvgCzZo1kL/wCvFvSYhM+T5xbuFoKhiJDiIeooaO
 AbhnNhvpbOnbAoI9BylkqIi/kY9YODimWh3HItwwQq5wkf3/n/sMwQlR7lno4lvscNMQFYqlCfX
 OUMb5Wrq4h5qpDe0TwxiXVqmXT4yaJn9d2vWIRm4YOc31Y4bcNDAgAPKa7HwNo6zI6JmWTFBgX8
 Kn8bksSNcUUXY1Q7yg+IEUDqYrjJl2yg27g7fp0ChEfKOf+xRlerM3rQlClYvONXEYPFHMVo57z
 v6fAvnREIAvoKFsn/0iXcxoqXVsbLEVMn6WfzmVNLRpaRjfYmfKbaKPAFn1wbiHS4j/XQg54NSt
 0CCHqBlurMtcuCMAOjrneA6m1pAgY4hdxG13JGPrpGtyoMUuh51gT0oboKxG0cxHLA7h3DBGEPM
 sTGc2nlh6wBDQBaRR617+PITtwKWdsZ9h4krXLbBAQGa4L/Kz4fAzbTq6JrZZF9oc6t7RKCmJP6
 STJb7iMXWvwGWC1hEN9cezDsgB5JVHFGfN54/0lIkugEnG6duLtd6xjOvYXwQ1ujfzh+0kOZuN9
 gysJ3yPlhoo527Fmfku4PzqpAUAVWVzPKQ3nhUyUWSxVb/By1g9EO5wbHsz8VM8IzUJTQE5bpjD
 z/OCt4me4z0IDsw==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g881nuHWDgcEetWZrWqnKDK2yMXf2SKrbuVD6Qw+TyDpMlQ9f+e
 Fi6YkCmIb2X2SQISWrv8sffASpi72/hddaoEEeF5mXlcJe7nuHPMYQ/TAA/ZcFSNHOjtH7K
 FE0vXQSVGTZ8nP0iBZD2DrprWjGaX9SmD2lsACzLsNJT40S++t/EjX7KzvF+nb1zws3ahXK
 WGADKbj7k5zOZtCxmMlQA==
UI-OutboundReport: notjunk:1;M01:P0:ymOxUKL1No4=;KS3rFGed2I3Y9eGkwPzu2wYmd00
 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
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
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


