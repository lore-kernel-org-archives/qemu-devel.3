Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A59EA8121
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 14:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoha-00057z-3q; Tue, 10 Feb 2026 09:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohR-00055o-Qt
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:47 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpohP-0005j9-Ti
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 09:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770733602; x=1771338402; i=lukasstraub2@web.de;
 bh=Ye3cFwI/N8c6RqLVFLAQ/1UDDuW4Gp8NRD9ndorrXik=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=XfE2hS1QS8/s4b1XXH76/gnN2xzG8HnqdWnEk90DMQx0IkqDGWtQjAS4FX/BnKCT
 y4EDDJ1ZXQiBCySmjBk78k/CNo5gI/SJN2RNePjDiJH6/RpBr3bdU2vyWUXfBGIp0
 gE0c7vRdI0JUd1JR3AAgaraCJtt++Tpf9eR3tu58UW5POHqZ6yQzDkcXYBiggNuNA
 OSwHXIFhexPbzyWyNdHEUbQIrUfaXqY7HATY8sS7r6kz1VDRYI0qY0chvrd4lGy28
 8IzmqD6ZfSWOWyphiKtAuVwGnM+lvuzMx7lXKi3JWLQzugjhFbJ+vLU0qFBR6KZvF
 GtK7RRZc6To+Zfy3KA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdfCH-1vGU0u3rur-00lhEd; Tue, 10
 Feb 2026 15:26:41 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 15:26:25 +0100
Subject: [PATCH v7 13/18] colo: Do not hold the BQL while receiving ram state.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v7-13-23bd32f36828@web.de>
References: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v7-0-23bd32f36828@web.de>
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
 h=from:subject:message-id; bh=Fmqd2rrT7W38mHUZ1B3clf4lPLiROghSZwd3S2hNl+E=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi0AciiehjpEwSBxJ9/3DkAGzKkl0FTdp7d7z2
 HA9wDGa5HKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtAHAAKCRA1qwsonF2y
 WGmpD/4zOZogM70XBsnUtdlu5pa9S/BRR9DOAgPsAdXuVP+u5JUGR00NxQsJWGFekHLPgh45GSc
 x4FeQky40ZDVD3pAq94welmQSvd5jb1RkDnTsGIuT3VQ4ZXfAgTRNKbDdAvog4ruGHf47nccoze
 ZayFOdwq7wFl03jh/JacbS+csuI94sjSZ3gyrIwVtapoUxmF30mdI/xWWnACfQ7M30qB/4vecOx
 V6PWh2tvtnnu7nOzvXxRIqKfwYCjBYBvAy18Ts1CODxJn4xOTk/VPhKY4euY57OpivGRvN/14ud
 hVDWtZfWBLfXIZB5i5TfeXmsXZc6TFk55x56vpi6OMJsryQO1Qqv9sSbU/psrACpXy6wtS+avoJ
 D5upfW82ytv33KB/uqc4sh76BwErvEyxxlmML5GP6KAvdarXxMiXLJIu+wn/ihhm8S+GJfYnsdu
 7mGKe0XGTWRKHd2OeWP7wzJBoI63B36rTVmwSwJE2FSxBiG2kFn7GaJA4N0FCqfTdY8LpmGEYLE
 XwIAw2eT+rHI3WBYoc1UMA5bW/jrtCSaJiA59DmvAUavPzwf0hkf0AMKKp77hxjGS55JVdH9jQg
 PEGlnlLo1zv0Krr7oZxcTPaLSLiU0+j8cReaAkaY9dqvnP7yDyFwS5yppvvOtMdcq8lm0DljkPF
 1m+gGAR1hD7WEjQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:y/bQu9xbW0FBomZVUFxn3Hgh+pwCjPtKvrty058/WjFOCE8xihu
 A6W058mLDkzRMgdxc0K4kfCrkLCEmY783vfGFZzTXj15pVHY8CwONZNdapgXOBBsPUjnSi8
 B+Ckj5L33Uo57TnFUN9R6tapEc1+su1JgB+tgFfi+bUgi+a+jhSIYWo5AhDYG06Q4ENe1Cw
 74+d7WIxCRM7o1sP2BTMA==
UI-OutboundReport: notjunk:1;M01:P0:nqjM4UTVMrw=;eZDSoEIlIAfxPx9davFct531y48
 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
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 74338a59b563846f4562161942001889dd6191bc..cd1a2b94f497fcb25609bbe117=
feaa8eed1d7f50 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -684,11 +684,7 @@ static void colo_incoming_process_checkpoint(Migratio=
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
@@ -731,6 +727,8 @@ static void colo_incoming_process_checkpoint(Migration=
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


