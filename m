Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F06EE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 20:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voS3Y-0004LJ-7N; Fri, 06 Feb 2026 15:03:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3I-0004FR-NI
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:45 -0500
Received: from mout.web.de ([212.227.15.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1voS3E-0008OG-Lm
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 15:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770408204; x=1771013004; i=lukasstraub2@web.de;
 bh=CnwVz8XWBmqHpe67zT//2crJ7bk/SW6My44mPIi5+mw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=EfP+bzg5MGnxJiIAP9XCIdg+mLmXzBR7EjtKdPYksS9UxZUhJB2zg32lbyS2oZHJ
 GRSLp4sXurEOCReLZ8M719yFqRQljANlwskk85DksAr1XMtPfrCLIW1CLq3bNP+dm
 bvRBgRiIsuYzAoZFYEkc4Jrb20QetSGbf1yPDnmbX/J7IND5nB9A2MVox/3V4gu96
 IkG3ii/5Dq6b6W+oR+HW5Rlk1YvKn6x1nXnyQpxoI88/2yL2LP2XEwKyakpWfrkIW
 TW6piWWuKJ6crR8roo+uKJ/488NFFBqtdXiN6R0SLHjwVoE2AgDmwiA19kUIjLtwR
 S8BOqURXYjC08//ibQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ma0PY-1wI8Yi3J12-00X5PC; Fri, 06
 Feb 2026 21:03:24 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 06 Feb 2026 21:03:03 +0100
Subject: [PATCH v6 05/18] colo: Remove ENABLE_COLO loadvm command functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260206-colo_unit_test_multifd-v6-5-27779dda139d@web.de>
References: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
In-Reply-To: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3390; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=SGXPHYdQMG52/VIHBHNTHrlp7HQYjrDtfkgWimh5FOg=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBphkkFlsBSmyK79MY3XD9eDASQgxzl5fZBy1a4i
 s6NXma1voSJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYZJBQAKCRA1qwsonF2y
 WF6jD/wIwgLiUglv0R9o/mx6HBzkW822NGIKEWKmF1Ed+LNYMdzG5akRFhRZbrZ5Iu9dIds2dr9
 t3OwpKhu5HDZ+s4Yb5tpTXNMxwd42WJIEITHrtvRc+XG0TWQN6+GtxAvW6F2X50mhhzYG4VOvrN
 y+9BU0k9aaIBiQLVHGFY/8duZm4vwTWaPit44/kVkvhB6eAPdc43uOg7QecgRGI/63SRVPLpCCj
 Kq4thztxmZ7Xh6fyw4Ki3KmbsCgnK5H0SH0gvS3DkbJNrqOVPXiHnLwo/q+2Cot9YoL+X2uzmpf
 wg03yi/n13iTSTSkYx2wWnDWE4ZmdHGRflFJHbs3MZbVZWfc5hfKacycP5W4T+CQAV622oVtlLV
 laUU6zbFEDxGV2mcZuTZKiF62uWIkQicRRMeqNDOOwLAB3zZmCIjhTko7zJKCNoi54LIRPy/+3n
 LYOeBrOzh+DLsU6lEq4OmtIJfO3YX2POP0avtVKq8Sd24cnffn4QWm3f4r+13bStYZFX33cJEDe
 Yax6OPr2IpArP7Cd5mxU7jJk68nOpA+7NA0rF3tUhT4IfZ09rJr3T6Ks496UX5NuIm74gBFHcxR
 38Kd9Gvy9Nm32blF0uWGVEz1YgBjLoHrFSRbS6e4Z4Tk2RI5M2vSl2BWNys/nRJDRfNGK9VQXzZ
 chXleCb2ck5tdGA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:wXdRUNlEKpfnHOkDQ76dMv+ZJiW7FsjSDcKJVkRMmCG5BbAbg8P
 Vd3+AqMYQ+Hg4gt8V7Y1kyYZI3f7BRnpxBlH+AuCzh4DoqnwGo0E9GME2+r09mgLLN3lQ79
 ZYUQrVk4bg9k3rKcyDTMe+AEdxByCQVnOGfCkoTpAOtiIKUyk7e/4Rh/ND2UaZVJFMyr+PH
 ToMo+hZ+sdYzkdTw+MyeA==
UI-OutboundReport: notjunk:1;M01:P0:MBflqHW7uYo=;200T32OSy5Z2K3F7hGyOSowscMr
 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
Received-SPF: pass client-ip=212.227.15.3; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

No need for it anymore now that x-colo capability is required
on incoming side.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 include/migration/colo.h |  2 --
 migration/migration.c    | 26 --------------------------
 migration/savevm.c       | 10 ----------
 3 files changed, 38 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index 2496a968cc1ce709f706c0efe57e4f765f163d3c..8f94054a10760d0f2598f08064=
3f45f9944cf051 100644
=2D-- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -25,8 +25,6 @@ void migrate_start_colo_process(MigrationState *s);
 bool migration_in_colo_state(void);
=20
 /* loadvm */
-int migration_incoming_enable_colo(Error **errp);
-void migration_incoming_disable_colo(void);
 bool migration_incoming_in_colo_state(void);
=20
 COLOMode get_colo_mode(void);
diff --git a/migration/migration.c b/migration/migration.c
index bc8ce64ff5000b0eb634a20b22e5f3e3289b9707..3f3fc5276bb067ae1960e4b675=
b33208ad641b23 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -604,31 +604,6 @@ int migrate_send_rp_req_pages(MigrationIncomingState =
*mis,
     return migrate_send_rp_message_req_pages(mis, rb, start);
 }
=20
-static bool migration_colo_enabled;
-void migration_incoming_disable_colo(void)
-{
-    ram_block_discard_disable(false);
-    migration_colo_enabled =3D false;
-}
-
-int migration_incoming_enable_colo(Error **errp)
-{
-#ifndef CONFIG_REPLICATION
-    error_setg(errp, "ENABLE_COLO command come in migration stream, but t=
he "
-               "replication module is not built in");
-    return -ENOTSUP;
-#endif
-
-    if (!migrate_colo()) {
-        error_setg(errp, "ENABLE_COLO command come in migration stream"
-                   ", but x-colo capability is not set");
-        return -EINVAL;
-    }
-
-    migration_colo_enabled =3D true;
-    return 0;
-}
-
 void migrate_add_address(SocketAddress *address)
 {
     MigrationIncomingState *mis =3D migration_incoming_get_current();
@@ -735,7 +710,6 @@ static void process_incoming_migration_bh(void *opaque=
)
             runstate_set(RUN_STATE_PAUSED);
         }
     } else if (migrate_colo()) {
-        migration_incoming_disable_colo();
         vm_start();
     } else {
         runstate_set(global_state_get_runstate());
diff --git a/migration/savevm.c b/migration/savevm.c
index 0353ac2d0de819b6547a1f771e6a4c3b8fb1e4ef..413688b75f4bee6cb10878eb51=
886cf6ba14872d 100644
=2D-- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2403,13 +2403,6 @@ static int loadvm_handle_recv_bitmap(MigrationIncom=
ingState *mis,
     return 0;
 }
=20
-static int loadvm_process_enable_colo(MigrationIncomingState *mis,
-                                      Error **errp)
-{
-    ERRP_GUARD();
-    return migration_incoming_enable_colo(errp);
-}
-
 static int loadvm_postcopy_handle_switchover_start(Error **errp)
 {
     SaveStateEntry *se;
@@ -2528,9 +2521,6 @@ static int loadvm_process_command(QEMUFile *f, Error=
 **errp)
     case MIG_CMD_RECV_BITMAP:
         return loadvm_handle_recv_bitmap(mis, len, errp);
=20
-    case MIG_CMD_ENABLE_COLO:
-        return loadvm_process_enable_colo(mis, errp);
-
     case MIG_CMD_SWITCHOVER_START:
         return loadvm_postcopy_handle_switchover_start(errp);
     }

=2D-=20
2.39.5


