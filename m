Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E653C5AD68
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 19:54:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtWXn-0000Vp-1n; Fri, 20 Feb 2026 14:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXc-0000S6-OY
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:56 -0500
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vtWXa-0001QG-Py
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 14:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1771617108; x=1772221908; i=lukasstraub2@web.de;
 bh=cKo1RcLXnUykLSWo5DXiqn6Y9pPE2FE/DD1aFztALAM=;
 h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=iXIF6aPbVQzX+euq1Ae4d4k0nQX081Uo2tG3gAnUlJx2FsoI/Qsydixlfk+/5bnQ
 xgHGCkRwAJG/9GnLBm17xjrB7VJfrJNcH1k6AOna/EEg61uflHA4/hpzit9u/eTx0
 MeGu4tboDXh9VM4RvYPIm6KhP3DmjNPixRHZMOeg7UraiWBvB+WrsjqwhAaXDjrmN
 lsQRHjMNwOdCBVC6MS09OhudoOtHxl8VOPE05DWfm7usb1hUpdI6Bot9NL777mT2W
 uInLX84BgkJx26UjN/HGecKyBuEwaaGwTC6Bf8m2y7cOmag9mJTmAA+0hr004aL49
 0gQhkAu4MA2Cgj74NA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [127.0.1.1] ([84.133.37.84]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N3Xnj-1vlRYN0E2l-012vEp; Fri, 20
 Feb 2026 20:51:48 +0100
From: Lukas Straub <lukasstraub2@web.de>
Date: Fri, 20 Feb 2026 20:51:26 +0100
Subject: [PATCH v10 04/19] colo: Replace migration_incoming_colo_enabled()
 with migrate_colo()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20260220-colo_unit_test_multifd-v10-4-bfe67d422ef1@web.de>
References: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
In-Reply-To: <20260220-colo_unit_test_multifd-v10-0-bfe67d422ef1@web.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhang Chen <zhangckid@gmail.com>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Lukas Straub <lukasstraub2@web.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3533; i=lukasstraub2@web.de;
 h=from:subject:message-id; bh=n0JNkGWwDvp69U+jS7cX+vJwFoFOUey0gb5uYJ0EtrM=;
 b=owEBbQKS/ZANAwAKATWrCyicXbJYAcsmYgBpmLtNmxIpuVb+c88CC4W1S5Ph0CCfGnf1Woye8
 w9IBVGMq+uJAjMEAAEKAB0WIQSD+rFYoNm4+3Jij6Q1qwsonF2yWAUCaZi7TQAKCRA1qwsonF2y
 WAL0EACdafZC34xmnfKagDY3lYf4YJaZa6+kyLFjHBvDSPujtxi3IRjjBZLmkxgKsRbcu6AH/o9
 drjwI7MpEXQiiCv9J/7uIvND2Aa0mMXCldk+r9OdK1aOArorVTc8HKB0vFgU1tIgwVMKHtxaTyg
 FcDCOglinVjFlaKRZoDVlfslo25Wi2n2TGCSAZv7Cr0lXM0JOkT76c+UnBQM9mIO0tToMKfp6tj
 cpm+DjUrZ4eezr9Eo8FbDweyQHIWGcvAmzNVst+jX9IC3XdZitsGi1divg7tLwcWT7YDlhWPVRL
 ysjX52W04kOrCHicFvjk9gEWoVFKovIvhIa3gGLcXZoqeUYYQuHq6VSL6PaiyoRuP1coSdbz7S/
 PvVycXx/Mvtf4yV2YkMgWcnbnB3NDFNLvZr/CqXkro8/1M+ITsaf2PVIELHTR5jN6S3qHhARbVi
 nV4s9JghDQhC9bi4SVKYJiUgR9t8Op7zDoE58SLJDxD27AJx/DWP5F11rSRJ7kqf/TbKDu4fJQf
 ifFsgfXKhKlUBHwfh0pw4OdGGexjedBHl1uUUlT0jrQ4Px1Ko22vm8sK0Dp20lpkVDlH2YeSXVD
 geaYS2j5qq4S3N0Dyb3EHdDbJVmgLPMJkf4coaV+Zo2CcNpqnfKRoT3NBDK3zxrlKHkN6S6Grpp
 0b5DCvy8q21+lWA==
X-Developer-Key: i=lukasstraub2@web.de; a=openpgp;
 fpr=83FAB158A0D9B8FB72628FA435AB0B289C5DB258
X-Provags-ID: V03:K1:6f2CakCurOdZSo8MvCHlTgSLrE7/uCOWya+iblgo0jShgkElLrF
 p6TqLjeiMQR+ckDkvhHRPHfoXt3ECEWjHLDLTPiKJKN9nRiS5ZWgDM/+xeg/ZZAp6xvwdFA
 2/l6U5JQ+pGxVZRAW8nbyfeF8ct2cI96TXRtkU7QxoZrD7AlsKFayFDW861K5TfTKKkPCBI
 RLT9DWPDTcdf504WLgVuQ==
UI-OutboundReport: notjunk:1;M01:P0:nMcWzjmCkcU=;JQQiLBdDJTCdWjschF3hzFAFwYg
 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
 QQSWPBNzhOaHK0RgOpnJkMmD7CgLX
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Since
121ccedc2b migration: block incoming colo when capability is disabled

x-colo capability needs to be always enabled on the incoming side.
So migration_incoming_colo_enabled() and migrate_colo() are equivalent
with migrate_colo() being easier to reason about since it is always true
during the whole migration.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 include/migration/colo.h | 1 -
 migration/colo.c         | 2 +-
 migration/migration.c    | 9 ++-------
 migration/ram.c          | 2 +-
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/migration/colo.h b/include/migration/colo.h
index d4fe422e4d335d3bef4f860f56400fcd73287a0e..2496a968cc1ce709f706c0efe5=
7e4f765f163d3c 100644
=2D-- a/include/migration/colo.h
+++ b/include/migration/colo.h
@@ -27,7 +27,6 @@ bool migration_in_colo_state(void);
 /* loadvm */
 int migration_incoming_enable_colo(Error **errp);
 void migration_incoming_disable_colo(void);
-bool migration_incoming_colo_enabled(void);
 bool migration_incoming_in_colo_state(void);
=20
 COLOMode get_colo_mode(void);
diff --git a/migration/colo.c b/migration/colo.c
index f7a5bd3619a49a3b4a8306973de7a4411cc0df58..97a224c39c49ff2269f375db47=
112458cab0b4cb 100644
=2D-- a/migration/colo.c
+++ b/migration/colo.c
@@ -935,7 +935,7 @@ void coroutine_fn colo_incoming_co(void)
     QemuThread th;
=20
     assert(bql_locked());
-    assert(migration_incoming_colo_enabled());
+    assert(migrate_colo());
=20
     qemu_thread_create(&th, MIGRATION_THREAD_DST_COLO,
                        colo_process_incoming_thread,
diff --git a/migration/migration.c b/migration/migration.c
index c2b9621190f8678ac6b32d6794d9bcb6ffa5e402..ef6aac53343f2217cd1aa37e49=
3483703068d1ff 100644
=2D-- a/migration/migration.c
+++ b/migration/migration.c
@@ -605,11 +605,6 @@ int migrate_send_rp_req_pages(MigrationIncomingState =
*mis,
 }
=20
 static bool migration_colo_enabled;
-bool migration_incoming_colo_enabled(void)
-{
-    return migration_colo_enabled;
-}
-
 void migration_incoming_disable_colo(void)
 {
     ram_block_discard_disable(false);
@@ -739,7 +734,7 @@ static void process_incoming_migration_bh(void *opaque=
)
         } else {
             runstate_set(RUN_STATE_PAUSED);
         }
-    } else if (migration_incoming_colo_enabled()) {
+    } else if (migrate_colo()) {
         migration_incoming_disable_colo();
         vm_start();
     } else {
@@ -807,7 +802,7 @@ process_incoming_migration_co(void *opaque)
         goto fail;
     }
=20
-    if (migration_incoming_colo_enabled()) {
+    if (migrate_colo()) {
         /* yield until COLO exit */
         colo_incoming_co();
     }
diff --git a/migration/ram.c b/migration/ram.c
index fc7ece2c1a10f34aa5a91f58cbe42ea418d7c078..aebf77aa0b861e00516d6f1090=
aebefdd0d97e54 100644
=2D-- a/migration/ram.c
+++ b/migration/ram.c
@@ -4370,7 +4370,7 @@ static int ram_load_precopy(QEMUFile *f)
              * speed of the migration, but it obviously reduce the downti=
me of
              * back-up all SVM'S memory in COLO preparing stage.
              */
-            if (migration_incoming_colo_enabled()) {
+            if (migrate_colo()) {
                 if (migration_incoming_in_colo_state()) {
                     /* In COLO stage, put all pages into cache temporaril=
y */
                     host =3D colo_cache_from_block_offset(block, addr, tr=
ue);

=2D-=20
2.39.5


