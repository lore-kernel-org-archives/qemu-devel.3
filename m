Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBA9C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 10:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taBw9-0006hW-Cu; Tue, 21 Jan 2025 05:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taBw6-0006gN-T5
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:56:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taBw3-00057f-Op
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 05:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737457002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rOWdPqUs+IftHtvHWcghIGatiIiKcgenGAsSUpAA+Go=;
 b=MFbbTxPKXOqLLTVLTupHESG5N4RwJUS7kzI5IuhhkTGMwzt2BKu5P0AAg3DHB/u2391Z27
 /OmBLrYLWpikBhbu9nOiF16+9jR34MwIj3SfuDg3CIFJj3N3gpJ74HFKzvYh31yLlwL1ia
 oJmDSVkg3jpjgh5eostlaAPrCbE9elA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-oiGIEKTLPD-xDvhdZcwxug-1; Tue,
 21 Jan 2025 05:56:37 -0500
X-MC-Unique: oiGIEKTLPD-xDvhdZcwxug-1
X-Mimecast-MFC-AGG-ID: oiGIEKTLPD-xDvhdZcwxug
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB48B19560BB; Tue, 21 Jan 2025 10:56:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.56])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CF96919560A7; Tue, 21 Jan 2025 10:56:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 8/9] pc-bios/s390-ccw: Abort IPL on invalid loadparm
Date: Tue, 21 Jan 2025 11:56:10 +0100
Message-ID: <20250121105613.1286672-9-thuth@redhat.com>
In-Reply-To: <20250121105613.1286672-1-thuth@redhat.com>
References: <20250121105613.1286672-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.036,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jared Rossi <jrossi@linux.ibm.com>

Because the loadparm specifies an exact kernel the user wants to boot, if the
loadparm is invalid it must represent a misconfiguration of the guest. Thus we
should abort the IPL immediately, without attempting to use other devices, to
avoid booting into an unintended guest image.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Message-ID: <20250117212235.1324063-2-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/bootmap.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
index 56f2f75640..0f8baa0198 100644
--- a/pc-bios/s390-ccw/bootmap.c
+++ b/pc-bios/s390-ccw/bootmap.c
@@ -336,8 +336,7 @@ static int run_eckd_boot_script(block_number_t bmt_block_nr,
 
     debug_print_int("loadparm", loadparm);
     if (loadparm >= MAX_BOOT_ENTRIES) {
-        puts("loadparm value greater than max number of boot entries allowed");
-        return -EINVAL;
+        panic("loadparm value greater than max number of boot entries allowed");
     }
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
@@ -348,8 +347,8 @@ static int run_eckd_boot_script(block_number_t bmt_block_nr,
 
     block_nr = gen_eckd_block_num(&bmt->entry[loadparm].xeckd, ldipl);
     if (block_nr == NULL_BLOCK_NR) {
-        puts("Cannot find Boot Map Table Entry");
-        return -EIO;
+        printf("The requested boot entry (%d) is invalid\n", loadparm);
+        panic("Invalid loadparm");
     }
 
     memset(sec, FREE_SPACE_FILLER, sizeof(sec));
@@ -792,8 +791,12 @@ static int ipl_scsi(void)
 
     debug_print_int("loadparm", loadparm);
     if (loadparm >= MAX_BOOT_ENTRIES) {
-        puts("loadparm value greater than max number of boot entries allowed");
-        return -EINVAL;
+        panic("loadparm value greater than max number of boot entries allowed");
+    }
+
+    if (!valid_entries[loadparm]) {
+        printf("The requested boot entry (%d) is invalid\n", loadparm);
+        panic("Invalid loadparm");
     }
 
     return zipl_run(&prog_table->entry[loadparm].scsi);
-- 
2.48.1


