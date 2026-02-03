Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E8A6E8307E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 10:17:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnDSG-0007Y8-4P; Tue, 03 Feb 2026 05:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDS3-0007FH-BF
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:09 -0500
Received: from mout.web.de ([212.227.17.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vnDS0-0002De-2K
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 05:16:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770113748; x=1770718548; i=lukasstraub2@web.de;
 bh=CnwVz8XWBmqHpe67zT//2crJ7bk/SW6My44mPIi5+mw=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=P67fbSvSoPHsba5E5BX4sQHJ0FVxtIvDD9vzpcHlMQk1so1RQ7gsduzaGM7o+fUd
 bw6B515/xHg+dmm7t8N1k8gB2duk0mvBdgTVQZD1F//4LjWmCy2kp4fX/6w+1ovWw
 mtz8RMDlpFcxVm5+xqF/gW6eJJQ7v6G52mmOFd1fGvwkMLcr0J+iSn+EnqyBo15xo
 4JLpoVy+0HP+l38RW9HDVSiEtBEFPmIKTEOENa6MubQMilpRNW8AxVQQfLIlaWarp
 iKActVJv9IRWBKh+i9jCw0wMfcHVcxY+DVn3F6X4o/vQE5RhIGVVC25eO3up4gQwL
 G8rf1B8tTrqfu94TMA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([217.247.97.172]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmho4-1vOMl82DIc-00bJ9s; Tue, 03
 Feb 2026 11:15:48 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 03 Feb 2026 11:15:11 +0100
Subject: [PATCH v5 05/16] colo: Remove ENABLE_COLO loadvm command functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260203-colo_unit_test_multifd-v5-5-57508b7389f6@web.de>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
In-Reply-To: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpgcrPwl2MjbCTGsdBCqEEd1eczq9dy2BwEzPp6
 /unZYi6tyOJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYHKzwAKCRA1qwsonF2y
 WFyPD/4qwuH/ZcI9OCcUre5Ptw5L66Cp2K1ZTTa00qdqKlT0QhBHEVL64qKF/2QTWEE4SFbbXTe
 nflpBYEKUMbNzaEYx3F6mnLdJQMrUaMJsiCLZZ9sxXJuDKRGaln0aHPB2RzJEIcp5dXYMk1SZOy
 79AzBF48Goz9Kjo2wIjgAEev8frDuYi7WBp+Bdy2G/IL4QqLq0zeZ3b5pv/envbJB1CumpPN/gh
 dlO9h4NVytJOwlUaPzFuKhlvhElj4gg2nnMpPVZwAqzhv8bAI0iyfLEBGD05bn+1lDQ/XoHP0nU
 +9Suf3EJsAE8Uvws/5ayXRmmol1fLjW20xzYmFcwQ6lRSUSOJREP83azF1WbXkcu9wBNztnUzXR
 j5oCszq6LbmAHsPfz5SDICytdnMQoiaes8K7n2ZXuNT3tzt02eg8TD5PbACuCyDQ8y4jlvXJABX
 A9KWT9YKws8YRSdvc7YWKW5g+fol0iWwqDLHOQMIxxfBsF00PNdKxgacUDrNRyQ7pSHs+sI3YSA
 IGmFG0VOc72nUglDDdj7PfOql18cp1PWVjxNbWKEWqrDpLrWLXMhsShu/JqnwsLoAEIMGIS17Pq
 AUPmfrBAZrWk+scy70uIzJyXeRx+e1QV2ibaKuzzUgDs4yjSf+2fWtqsiavuSe88EvQfEzudKUe
 kvy66jhQS2IBWXg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:iDKiNTdpQieCHHxuKzeDUdsHiZp/Y4+O8jD+Il4OJO0dcjc060g
 vsFlg7wOsUo9jGsw4g0+HBqD3Ng+OuSgy8X1ZyYdCgUNiIdAvAN5LKVxahiqv2QAM0eyQrd
 Ng24GixQPaWjLZETOf5w4KezPORpV+krIpI62ixHPw/MZ+O4QQ8BHdS30zUmd+tQkVXlvKs
 6TX+46tNweiRVbSBcDuzg==
UI-OutboundReport: notjunk:1;M01:P0:OAi6a9w2eGE=;6rL6H0WGY4MyGxkz5pW7mzqLFqb
 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
 MVk4WQw7WAjB/0tai2VrcOrsGHjT6
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
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


