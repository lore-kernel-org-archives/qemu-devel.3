Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68267EB26E0
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqWR-0000gu-7i; Tue, 10 Feb 2026 11:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWP-0000ff-2v
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:29 -0500
Received: from mout.web.de ([212.227.15.4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vpqWM-0006w0-7m
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1770740604; x=1771345404; i=lukasstraub2@web.de;
 bh=Ye3cFwI/N8c6RqLVFLAQ/1UDDuW4Gp8NRD9ndorrXik=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GQ5nAF0Ei+uITonV7sVPiTC0CS16WwsozIUDFfesjoxPJKIBqzyp1AXXRJaAc8je
 GoNSZ4vDlawrWw1YzMqei9KOs3l+UHHdA72Zfh/vj6FAMhRW/yliaPSSPMcuhFbUN
 mvEQUgSfUFuiUR0aYXUSlP4XGaIjMzp8JAGLsuJMDAmSmanEF8H0WtiGVwjCbJGSg
 4lLoP+XT9D2+sKM5zj4+MOTa3w+ZG+h0hgRos2PaazFjxdlhLHyt4Qs3ygnCXsko+
 zYlYqyeIm2rnvz3j4Kt7rQGfAomxldZ5GgmzCTwZiJYz703+GO0quPwrHwtwDZmOH
 wFoBG3TISR1TGkmysA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([141.58.43.188]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N4vRY-1viFom2ync-010wYt; Tue, 10
 Feb 2026 17:23:24 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Tue, 10 Feb 2026 17:23:10 +0100
Subject: [PATCH v8 12/17] colo: Do not hold the BQL while receiving ram state.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260210-colo_unit_test_multifd-v8-12-7f9e5f7d082b@web.de>
References: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
In-Reply-To: <20260210-colo_unit_test_multifd-v8-0-7f9e5f7d082b@web.de>
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
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpi1t3Ps1v+YjIaKakOw7ARSVm6OI4DM0KsPvlK
 Avg1Wb7jBCJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaYtbdwAKCRA1qwsonF2y
 WLWhEAC0MrCIyQ52rJUUz0nqtQe6oXTXro5I7uUBmQFGopowex/fOyVyyCsVDfdDcjQ1Z40Dt06
 m7t6gZYHB0aEwfKjV8jP7zTK13yAN5yZ93tcN74Wc/X5qHdaA5cAYLUlfkOzlD7IYp08j59bZge
 +in2eTfdbDalMDufWwiEQLcLzjt2evOFjPF68zoxXhDxVdCGPCQtndUvFD3Z0dCVr5VmXqA0Y+8
 cBhRRIDL2G9ct/U6zCXX0+CY4JOHmCpF52b12qz8aIjOIPRrLiBKYogWISmh1JeTjiR405suepj
 puhVoSdbm/SqaekVEDcseo/smyrqqfk9L9KY2T6goSIwGXy60/fSn4BTj58H4ZSVu53+rLytVBn
 9451QL4CxmMAGiFyA/hUFXGy1WCifqQ3JCnsw+FThExRXBH69Hl4St2OqL3dBK9WK3t96wpsZCw
 HhT4jcGe9tGYtHFHsMmdz3HwLm2Y6XO8/GIwSWt1ctGqs6jtQH4XPB4OM7UYTb9tCgVplXQBbak
 XAqD+vtmfdgC8x4ZP9h1tkr/8vuPfJNBQozjKbE8Sb5CNykTiivijXTOjLzlfbyWlDpVCXTR2zP
 HlmupO042MphihC+7hjyQVn2N37rLWCzLyY4LJUOawbhl6WSDzGQ/DRzYH6zyMu7CJwR2kF17vo
 +cMC4uWs2WPxOpQ==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:OeIT0WskO/I2OF2Ai+9crJzonv6IDtbCdky/c8fHqDhItNdshO3
 tvZerGDBO/pJtRKYwI94hfnmpaBp4RLe2FY3/j84QldT/UsQlNC1Q70LqG7jsAQqnah84Ux
 QLItO9VLmnReItPKPavo0iKywTC51hYQ3XAi7VHVGJjdryFkrDs8asVUUSYlVokgo8xdRPx
 kyeH4gULLLlp85/7xxhgg==
UI-OutboundReport: notjunk:1;M01:P0:b7Tqhn9SyQM=;Ec0yLIXpqRJMGWTyYXXogLZ7zcK
 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
 17Q5ztU1rbBZ3896nz8k7p6s0LtGJ
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
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


