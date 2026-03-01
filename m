Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA0FFD0047
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 19:19:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwmHg-00012V-4e; Sun, 01 Mar 2026 14:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHe-00012E-Gt
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:16:54 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vwmHc-0003UR-LQ
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 14:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772392609; x=1772997409; i=lukasstraub2@web.de;
 bh=w7yoLFLxOPrYAjZU0Xno21H3kl0o95xRyRJ/F9GznRU=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Inb4PKGwgwV0SzlQ4vRU2997DIYtHkY7gYYTzLuvHicz5E6ZY2nuewaOVVlChQSh
 j2H4DI2L6e7EWdcm2GoMWMTMtCkkbz4aq/Jpuyvb++U5zDoIE91wTgPVC45yp3E0J
 UByCRjvafq85nv+D5O7RjFM3+2eVrIrMIhlRe1HyaIyY5t5IQhOAaSfxdFxGhDspk
 8pyTUPjVAf73hbY0GsfslpuIyyeK9k1nwkxo/mOQVuKohLmKAYXP2qVgpoDlHVVig
 sJLYbqIsIpd2U0IZMGi5EIdxq5+5tDwOzYHB9s9w+3BA3pHjCZxzWmsE2eJ5JPMh2
 QKnhCmmHDddSoBnyuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MidHZ-1vRYbW2mSV-00asS5; Sun, 01
 Mar 2026 20:16:49 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Sun, 01 Mar 2026 20:16:28 +0100
Subject: [PATCH v11 03/21] colo: Setup ram cache in normal migration path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260301-colo_unit_test_multifd-v11-3-a9701e795d7a@web.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2754; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=bZqP64D7rElL++ZH8EUI9LK8uvlG56Ai3ztis+On3P4=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBppJCcRXEzeOU2LiNoN5ADPjtgcVoiR4TACGQxo
 G+CNjFZ8vCJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaaSQnAAKCRA1qwsonF2y
 WIFTD/oDAfNtG2b+zLEHTmqx30I7qZKK00iKala8XwoLyuoF+4E7CZsb2q+EGS6Dhy62exSsfCT
 mmXsych5Q5VvkJvay4cyFvjQCYKb55x3sLmaNS6SSQy/obJbWK8TDHRlMdh3WFBVTwNuqBEHtjZ
 eaygUZ97cpWnKFDtOekhRGbaEtqmi8CoDHRJ294DEJOlmb/sF+vue3/68LLxjvaEFaUNcb1wuof
 XrvACNFLL/Wf3xptpSo7gG37U6X0bw8LmqAvLeRE6ARSNZ5AUtQkct74cktXdR2HKdRmLo+kKRv
 ja4wRIlvEDUsLk0mX1GcxyFw4CPmiUS1o0+a3KT/Zq1ciSOnYRgSlWnrhfDFYATurIt/u6L8NJN
 JyEXTFkktn9HNH6lx1gfUDpUUaYOyI5krQuAGtTcgy+Fji3WZmv4QqJ6Q2BcUiDhMBmB2CyGTZ8
 WmdkGbk8Cr0fn7yvmCfurRCwDy50U36R5hxH5TXKd6S1VHvw/hA2I1jkH1HCFWmekRFcp22VtTE
 w3cDtuEQEd9/FCDma5RuhUROtqGZQrP/9SdKxTbL7GVZnrvFhR0WSM+QhizI5c6Df+TEka1wFzD
 I0KsovK4HB9xftaulGKB+z84XqJ33VZK7w8MiX0qKy7quI9KNXQJQa2srCMLdf9KAeHgoJBzEWH
 uhzOEcWpSE8Qbkg==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:HM4VWvR04JkQb1vb1ul4LTVUkJhQTu2z4HHiavET9O3gXvPgGLS
 xee1K/qqTDW/aMCK/FoEftklzlg0nm1+hcbELdI9l0j5nprP3vJ2NBJi++44BQ5NK/aA7wH
 wRf8VQ27Bra9pi1GKRQkBt76s5jGYLcEdotko9XpouYbS6xC6u0TBw5WWzGRtZAiV6darq4
 FxCa/PEh08K2UEuE3uxAA==
UI-OutboundReport: notjunk:1;M01:P0:9uRHDxQKjis=;ukj8ooy1GSlqXoByV/Doaf9NEoF
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

Since
121ccedc2b migration: block incoming colo when capability is disabled

x-colo capability needs to be always enabled on the incoming side.
So migration_incoming_colo_enabled() and migrate_colo() are equivalent
with migrate_colo() being easier to reason about since it is always true
during the whole migration.

Use migrate_colo() to initialize the ram cache in the normal migration pat=
h.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 migration/migration.c | 18 ++++++++++++++----
 migration/savevm.c    | 14 +-------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index a5b0465ed30cb812cb294ab901c7a37fe6157dc6..c2b9621190f8678ac6b32d6794=
d9bcb6ffa5e402 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -630,10 +630,6 @@ int migration_incoming_enable_colo(Error **errp)
         return -EINVAL;
     }
=20
-    if (ram_block_discard_disable(true)) {
-        error_setg(errp, "COLO: cannot disable RAM discard");
-        return -EBUSY;
-    }
     migration_colo_enabled =3D true;
     return 0;
 }
@@ -770,6 +766,20 @@ process_incoming_migration_co(void *opaque)
=20
     assert(mis->from_src_file);
=20
+    if (migrate_colo()) {
+        if (ram_block_discard_disable(true)) {
+            error_setg(&local_err, "COLO: cannot disable RAM discard");
+            goto fail;
+        }
+
+        ret =3D colo_init_ram_cache(&local_err);
+        if (ret) {
+            error_prepend(&local_err, "failed to init colo RAM cache: %d:=
 ",
+                          ret);
+            goto fail;
+        }
+    }
+
     mis->largest_page_size =3D qemu_ram_pagesize_largest();
     postcopy_state_set(POSTCOPY_INCOMING_NONE);
     migrate_set_state(&mis->state, MIGRATION_STATUS_SETUP,
diff --git a/migration/savevm.c b/migration/savevm.c
index 3a16c467b25b8d93b7d40bd0db751158e0278b4f..b88851cdb7974314b8481646a1=
dd19642887f210 100644
=2D-- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2427,19 +2427,7 @@ static int loadvm_process_enable_colo(MigrationInco=
mingState *mis,
                                       Error **errp)
 {
     ERRP_GUARD();
-    int ret;
-
-    ret =3D migration_incoming_enable_colo(errp);
-    if (ret < 0) {
-        return ret;
-    }
-
-    ret =3D colo_init_ram_cache(errp);
-    if (ret) {
-        error_prepend(errp, "failed to init colo RAM cache: %d: ", ret);
-        migration_incoming_disable_colo();
-    }
-    return ret;
+    return migration_incoming_enable_colo(errp);
 }
=20
 static int loadvm_postcopy_handle_switchover_start(Error **errp)

=2D-=20
2.39.5


