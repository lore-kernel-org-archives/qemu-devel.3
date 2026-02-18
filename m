Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3B6E9A049
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 21:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsp7H-00078A-U7; Wed, 18 Feb 2026 16:29:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp7C-00076c-54
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:46 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vsp78-00078a-Ql
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 16:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771450180; x=1772054980; i=lukasstraub2@web.de;
 bh=8hHLJHabzCk4FfrjTAJvzzHBO1OUkODVuFNUMhqME4c=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=eVHKzi5oVv00Qx1MiU9sOHUGk5KZs28Yk2h61oG9+osAkv2a9b+XOt26WIZLg+ES
 ZwFpP64oUs08XEF/qfXPEEcAvR9dm9Xw4gJ5CYX05y8RyjkXmVx5enCGeGZ2t4Q++
 hpV8KuCzdRGfYD/Rmo7eSqSPGjP0uKxWtehasK2scbP1xgm6nkjfc+dVB2iKoZJM1
 OFEtsD8Psjeldt2NJnzOcE8SSE1zP1RpxYsnVF/bTsumTNsOdVZYjRcEqwwpO3XsA
 CFnMRadGJJSx7NLoZssi5iqAAligAz/wDruOmp9pmipHxqjmwh240lIXkJ4T1V9T7
 SJfQ6tXTAA5Nq9iiew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Elg-1vfoW40dDk-01882F; Wed, 18
 Feb 2026 22:29:40 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Wed, 18 Feb 2026 22:29:29 +0100
Subject: [PATCH v9 09/19] Call colo_release_ram_cache() after multifd
 threads terminate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260218-colo_unit_test_multifd-v9-9-d8dbdb0ca6f6@web.de>
References: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
In-Reply-To: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1345; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=742UeEMYZJ7tKnjG0Stx7vUAA1BGNxPixG9gIstyBU0=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpli89dHfNaIWb7gy6ksI2hyhhm5cXWq4svDNO4
 +V/SWFLtkKJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZYvPQAKCRA1qwsonF2y
 WFblD/0ftCdLWFfgjPIQDWylJy1d9d/5e9dzA6iO490l4PMJVPe28MPPdUYkgBSeI8M9QyvVpAG
 dBUxXpIv9zP/OIXds7mlhx306fFfQWOd5QMxCoqtbe5GzQ0VJCgkEJcdulqlkslejh5fDK0noAr
 2B1s/vPhEOGMQVaYl52xiggwCVzvo0i8jzhvlrZRTKmmmGp+ehjZRNvshaZbchajFgAU6CpYW21
 7eoJ6hkfXI7VgT9LLo9MJ003LjxkUVLsGTfsTG5rK5jwGRLAJbN3p7emZc4BBZLd/NNJhkbdCw8
 HrH1OIo0fm2RmRS/0hINE/MoDmE+iO5+lY2OXWdW0SEBjNI/ik5HTxDC8GSvoLcVO5YFKbEB6AZ
 7QM61iDHX4lTFlGVoIJgxXBBLCEWxWFBfRVHj0tyTqSQLoVsEPo/CPUXVg11lMRbXkuHjLRGf6X
 vkoWbRvHTteqmYCi4pHf2kuPAP8sT0O0r9CrZCXqe11v0w9E3vq/udJOWWVM7EzP2PN3JLpLpMN
 /9zl90zEGOaxTbTzA/mmbpgZ7ywyBWUT98rqe4J15FztlNcrRjvEx6CIrbnvHXRKYnd4FAqTzxa
 oEJNTPV6r3oLsIAjSOsjWD3tstEH8eaFncXXMwKgcwAiylTKsy2Pp3XuE63VPwi7wPwYRtGUQTh
 CCsb93Bno83Zr/Q==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:Yu1VI+s9IglV90Cr2q/p59KjHW6B7PfelaR7NYkfA5LcZvzsiV+
 auaWJqIkP6s+my9JMQ5aRJVm2w0k9x3Z0u9MEG+0RFRARgKLbZTz+LEl9Pe6JHOoUsqHsq9
 nBhmb4ghkqqxFJATPwg8fx6KYN2tSrtkSIrKrkIj/GQgCscq858iukIU5N3cYPC5slJMHu9
 2dqeivl0fxu0rLsEAMVfA==
UI-OutboundReport: notjunk:1;M01:P0:/KeNvotC5s4=;by3BzVHzPLoYOLaetX9K9CTyZf7
 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
 JC9pH/N0=
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


