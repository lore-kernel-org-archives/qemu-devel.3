Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C33C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 13:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmCdU-00031q-3F; Mon, 18 Mar 2024 09:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmCcg-0002Ux-Ra
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:01:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rmCcS-0007fJ-JZ
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 09:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710766892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k4nIB9Y27dnPuMvKHQR1UYUgyWt+BypWOGKXaAXuxQ0=;
 b=YyseSTxpR9kPAmQozDcVYLhWojnbkEG/siae8246r6VIu4xtP5HS7VPr9QzXIlciCQVCIg
 ezb1tSXbvznRm2s6wVdmK5PDIowXwUluvhYc7OqFm7+CVD8hv5sklcQmBTE6cmE5K1+N4c
 4cllAeoRW3cNBv0c0dp5MFr1C6gvRoc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-HN5lEt1zNlm5Onz5UnKxAw-1; Mon, 18 Mar 2024 09:01:30 -0400
X-MC-Unique: HN5lEt1zNlm5Onz5UnKxAw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 100E5891E70;
 Mon, 18 Mar 2024 13:01:30 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 771D82166B4F;
 Mon, 18 Mar 2024 13:01:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 05/15] qemu-img: Fix Column Width and Improve Formatting in
 snapshot list
Date: Mon, 18 Mar 2024 14:01:08 +0100
Message-ID: <20240318130118.358920-6-kwolf@redhat.com>
In-Reply-To: <20240318130118.358920-1-kwolf@redhat.com>
References: <20240318130118.358920-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Abhiram Tilak <atp.exp@gmail.com>

When running the command `qemu-img snapshot -l SNAPSHOT` the output of
VM_CLOCK (measures the offset between host and VM clock) cannot to
accommodate values in the order of thousands (4-digit).

This line [1] hints on the problem. Additionally, the column width for
the VM_CLOCK field was reduced from 15 to 13 spaces in commit b39847a5
in line [2], resulting in a shortage of space.

[1]:
https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L753
[2]:
https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L763

This patch restores the column width to 15 spaces and makes adjustments
to the affected iotests accordingly. Furthermore, addresses a potential
source
of confusion by removing whitespace in column headers. Example, VM CLOCK
is modified to VM_CLOCK. Additionally a '--' symbol is introduced when
ICOUNT returns no output for clarity.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2062
Fixes: b39847a50553 ("migration: introduce icount field for snapshots")
Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>
Message-ID: <20240123050354.22152-2-atp.exp@gmail.com>
[kwolf: Fixed up qemu-iotests 261 and 286]
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qapi.c                                  | 10 ++--
 tests/qemu-iotests/176.out                    | 16 +++----
 tests/qemu-iotests/261                        |  4 +-
 tests/qemu-iotests/267.out                    | 48 +++++++++----------
 tests/qemu-iotests/286                        |  3 +-
 tests/qemu-iotests/286.out                    |  2 +-
 .../tests/qcow2-internal-snapshots.out        | 14 +++---
 7 files changed, 50 insertions(+), 47 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 31183d4933..2b5793f1d9 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -742,15 +742,15 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
     char *sizing = NULL;
 
     if (!sn) {
-        qemu_printf("%-10s%-17s%8s%20s%13s%11s",
-                    "ID", "TAG", "VM SIZE", "DATE", "VM CLOCK", "ICOUNT");
+        qemu_printf("%-7s %-16s %8s %19s %15s %10s",
+                    "ID", "TAG", "VM_SIZE", "DATE", "VM_CLOCK", "ICOUNT");
     } else {
         g_autoptr(GDateTime) date = g_date_time_new_from_unix_local(sn->date_sec);
         g_autofree char *date_buf = g_date_time_format(date, "%Y-%m-%d %H:%M:%S");
 
         secs = sn->vm_clock_nsec / 1000000000;
         snprintf(clock_buf, sizeof(clock_buf),
-                 "%02d:%02d:%02d.%03d",
+                 "%04d:%02d:%02d.%03d",
                  (int)(secs / 3600),
                  (int)((secs / 60) % 60),
                  (int)(secs % 60),
@@ -759,8 +759,10 @@ void bdrv_snapshot_dump(QEMUSnapshotInfo *sn)
         if (sn->icount != -1ULL) {
             snprintf(icount_buf, sizeof(icount_buf),
                 "%"PRId64, sn->icount);
+        } else {
+            snprintf(icount_buf, sizeof(icount_buf), "--");
         }
-        qemu_printf("%-9s %-16s %8s%20s%13s%11s",
+        qemu_printf("%-7s %-16s %8s %19s %15s %10s",
                     sn->id_str, sn->name,
                     sizing,
                     date_buf,
diff --git a/tests/qemu-iotests/176.out b/tests/qemu-iotests/176.out
index 45e9153ef3..9c73ef2eea 100644
--- a/tests/qemu-iotests/176.out
+++ b/tests/qemu-iotests/176.out
@@ -37,8 +37,8 @@ Offset          Length          File
 0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
 0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
 Snapshot list:
-ID        TAG
-1         snap
+ID      TAG
+1       snap
 
 === Test pass snapshot.1 ===
 
@@ -78,8 +78,8 @@ Offset          Length          File
 0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
 0x83400000      0x200           TEST_DIR/t.IMGFMT
 Snapshot list:
-ID        TAG
-1         snap
+ID      TAG
+1       snap
 
 === Test pass snapshot.2 ===
 
@@ -119,8 +119,8 @@ Offset          Length          File
 0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
 0x83400000      0x200           TEST_DIR/t.IMGFMT
 Snapshot list:
-ID        TAG
-1         snap
+ID      TAG
+1       snap
 
 === Test pass snapshot.3 ===
 
@@ -157,8 +157,8 @@ Offset          Length          File
 0x7fff0000      0x10000         TEST_DIR/t.IMGFMT
 0x83400000      0x200           TEST_DIR/t.IMGFMT
 Snapshot list:
-ID        TAG
-1         snap
+ID      TAG
+1       snap
 
 === Test pass bitmap.0 ===
 
diff --git a/tests/qemu-iotests/261 b/tests/qemu-iotests/261
index b73da565da..22b969d310 100755
--- a/tests/qemu-iotests/261
+++ b/tests/qemu-iotests/261
@@ -393,7 +393,7 @@ _check_test_img -r all
 
 echo
 echo "$((sn_count - 1)) snapshots should remain:"
-echo "  qemu-img info reports $(_img_info | grep -c '^ \{32\}') snapshots"
+echo "  qemu-img info reports $(_img_info | grep -c '^ \{30\}') snapshots"
 echo "  Image header reports $(peek_file_be "$TEST_IMG" 60 4) snapshots"
 
 echo
@@ -520,7 +520,7 @@ _check_test_img -r all
 
 echo
 echo '65536 snapshots should remain:'
-echo "  qemu-img info reports $(_img_info | grep -c '^ \{32\}') snapshots"
+echo "  qemu-img info reports $(_img_info | grep -c '^ \{30\}') snapshots"
 echo "  Image header reports $(peek_file_be "$TEST_IMG" 60 4) snapshots"
 
 # success, all done
diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
index 7176e376e1..f6f5d8715a 100644
--- a/tests/qemu-iotests/267.out
+++ b/tests/qemu-iotests/267.out
@@ -33,8 +33,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -44,8 +44,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -69,8 +69,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -94,8 +94,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -105,8 +105,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -119,8 +119,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -134,8 +134,8 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
@@ -145,15 +145,15 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
 Internal snapshots on overlay:
 Snapshot list:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 Internal snapshots on backing file:
 
 === -blockdev with NBD server on the backing file ===
@@ -166,17 +166,17 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 (qemu) info snapshots
 List of snapshots present on all disks:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
---        snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+--      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 (qemu) loadvm snap0
 (qemu) quit
 
 Internal snapshots on overlay:
 Snapshot list:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 Internal snapshots on backing file:
 Snapshot list:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000           
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 *** done
diff --git a/tests/qemu-iotests/286 b/tests/qemu-iotests/286
index 120a8375b7..38216c2a0e 100755
--- a/tests/qemu-iotests/286
+++ b/tests/qemu-iotests/286
@@ -69,7 +69,8 @@ $QEMU_IMG snapshot -l "$TEST_IMG" | tail -n 1 | tr -s ' ' \
           -e 's/\./(VM state size unit)/' \
           -e 's/\./(snapshot date)/' \
           -e 's/\./(snapshot time)/' \
-          -e 's/\./(VM clock)/'
+          -e 's/\./(VM clock)/' \
+          -e 's/\./(icount)/'
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/286.out b/tests/qemu-iotests/286.out
index 39ff07e12c..bb04748e08 100644
--- a/tests/qemu-iotests/286.out
+++ b/tests/qemu-iotests/286.out
@@ -4,5 +4,5 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
 (qemu) quit
 Output structure:
-(snapshot ID) (snapshot name) (VM state size value) (VM state size unit) (snapshot date) (snapshot time) (VM clock)
+(snapshot ID) (snapshot name) (VM state size value) (VM state size unit) (snapshot date) (snapshot time) (VM clock) (icount)
 *** done
diff --git a/tests/qemu-iotests/tests/qcow2-internal-snapshots.out b/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
index 438f535e6a..fedb09224e 100644
--- a/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
+++ b/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
@@ -14,8 +14,8 @@ wrote 524288/524288 bytes at offset 0
 (qemu) quit
 
 Snapshot list:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 No errors were found on the image.
 
 === Verify that loading the snapshot reverts to the old content ===
@@ -47,9 +47,9 @@ read 64512/64512 bytes at offset 66560
 (qemu) quit
 
 Snapshot list:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
-2         snap1                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
+2       snap1                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 No errors were found on the image.
 
 === qemu-img snapshot can revert to snapshots ===
@@ -79,8 +79,8 @@ read 64512/64512 bytes at offset 66560
 (qemu) quit
 
 Snapshot list:
-ID        TAG               VM SIZE                DATE     VM CLOCK     ICOUNT
-1         snap0                SIZE yyyy-mm-dd hh:mm:ss 00:00:00.000
+ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 No errors were found on the image.
 
 === Error cases ===
-- 
2.44.0


