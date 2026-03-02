Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D6EBE9B356
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 10:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx0Hv-000528-Pv; Mon, 02 Mar 2026 05:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HV-0004sE-TL
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:42 -0500
Received: from mout.web.de ([212.227.17.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vx0HQ-00062F-SA
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 05:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772446415; x=1773051215; i=lukasstraub2@web.de;
 bh=8hHLJHabzCk4FfrjTAJvzzHBO1OUkODVuFNUMhqME4c=;
 h=X-UI-Sender-Class:From:To:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Yz7RocO+qBV8o7KHVwDFLlH+7uxgFcsT+coLSk6CH0Q/iZGQSZfNB1HyPLGgbuF6
 Umeew0ukjTQQ2fJ5PD7qkfXqDDOuc4pjWmlOxWMGYg8p1X+grDi0AmqtcA8bj8aFe
 Arjs8wcawTI9zwD16S0ZgWsS2c2lsY5LrS5rB6/3rZYgdjHA+u3DWRiJnmYZh/Q54
 +qTjjLckypEuEiVR82yubexvRZiiwAVrZOMH9CMS/fA+AxMErbzTG/GQFy91g/7hP
 FWUKbyEkAMCCYXKAsFHt8p9RNwEK/rV8lXb5v5UYAcSLkPEA5RGGyKz19XAUz+r3N
 RyMw9dsPRCVWpbHmdQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6JxT-1vczSw0PdZ-011uut for
 <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 11:13:35 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 09/21] Call colo_release_ram_cache() after multifd threads
 terminate
Date: Mon,  2 Mar 2026 11:13:20 +0100
Message-Id: <20260302-colo_unit_test_multifd-v11-9-3dae81d203ff@web.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
References: <20260302-colo_unit_test_multifd-v11-0-3dae81d203ff@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=742UeEMYZJ7tKnjG0Stx7vUAA1BGNxPixG9gIstyBU0=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppWAFoIsMFMV07InVSVLvqyZYG3Ecs+rYkb6JL
 wOLwHl6AZOJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaVgBQAKCRA1qwsonF2y
 WCE1D/0QgzV6y/PCsUqa71JHN8CNbeQUy8khZN9SvWs541HmA+qXUCDqVoRf9wnOcoqoI+wuavQ
 hzC47vyxmUOHumCmeKgbuejBHdGWzSJE2guz1lcj2yRpK40AfsVGRYbfLi/JmpICcgqncssWX6i
 g9uNqHf9/tiuGA5EnAE3odxpODOa+IZ/y+EpykfBFPSC0DUR7URRAUnDg1G0kG+PJvjvtIP/imT
 aY3t3wvZyD9+zb96MU1BtGtVovOQJUifTjxx5m1XG+49vCcdF2oW5jDNyQgSnXJm70VlLJPHjqC
 6SQKNQeT8IaqoQkGE9dZCOD5CHouUQdkvLdytNURxUU2jrSaf7OKL+RXvPiIb7CLKIawrJlGnPX
 eHu4k+e+RDPtVkBlVuaoaeS0jWbLPwiAgDv/7LA8zx9Z5c8v/oJNemQ6odO3rgNUBq6MGGouY/Q
 DEKN+wB4m638aYWKiuGBpD/42KxaHqiEof+67qouMIdzqB6b5N1p4vx7cx1Zs9V4BTynVpRxpB+
 VY+t4SX9gWhQpcpB2ohJAdGm/2Yhcj3Bq7K3unSeiIa+UAlJ3+1TZhPUvsNm0I9f9L7nJGJAzEf
 cPHiZYqDrqISkAByVMKFX41GtbIMLqcc5dtI2CWMYw2xAo2pcsffsPYi2+9pigojT3k0NHKJ4O3
 sNyoth7HwJW4p+A==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i/8f3cGSo6h4hAllgSofb/3b0dplNsnZMj2q7lCCSg0r+NcWssY
 h+MTulThShWVlZLxzVskm/Q4K57yQWJYBfjmVA9U9+btF0PEu4WtnE1MNDRdg/UlaaHyVqr
 F+wo0JLQAKxXFUZQu/gtDQjBOpq1WC43pKjjAaH11G5oMuPLzPLxUhjztbcVEWU/mKn158Z
 2zLZp7lujmiQvQNyiyD0w==
UI-OutboundReport: notjunk:1;M01:P0:MI+1QXhVYo0=;D99HWOZPvthgrunrBcOJTplmsuu
 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
 m/MCSW8pvmFBbtIXOiqTppx6akrKDTMSzaieUZ
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

The multifd threads still may access the colo cache, so release it
only after they terminate.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/colo.c      | 3 ---
 migration/migration.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 97a224c39c49ff2269f375db47112458cab0b4cb..96102c9d0fb3b60e063c81ce07=
b730011bc4919f 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -949,7 +949,4 @@ void coroutine_fn colo_incoming_co(void)
     /* Wait checkpoint incoming thread exit before free resource */
     qemu_thread_join(&th);
     bql_lock();
-
-    /* We hold the global BQL, so it is safe here */
-    colo_release_ram_cache();
 }
diff --git a/migration/migration.c b/migration/migration.c
index dba5d6ede579da42693d5270ede9660fb145238a..f36d42ef657bdf26d78ca642d7=
7a9b76e1c0c174 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -454,6 +454,9 @@ void migration_incoming_state_destroy(void)
      * BQL and retake unconditionally.
      */
     assert(bql_locked());
+    if (migrate_colo()) {
+        colo_release_ram_cache();
+    }
     qemu_loadvm_state_cleanup(mis);
=20
     if (mis->to_src_file) {

=2D-=20
2.39.5


