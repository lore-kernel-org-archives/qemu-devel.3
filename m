Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E90C606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I/e23uSe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMq8i-0008OP-3U; Fri, 30 Oct 2026 13:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xMq8R-0008FK-0F; Fri, 30 Oct 2026 13:11:24 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xMq8P-0004C5-Ek; Fri, 30 Oct 2026 13:11:22 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2586D601F8;
 Fri, 30 Oct 2026 17:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECA61F0093A;
 Fri, 30 Oct 2026 17:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793380278;
 bh=bFTsZY9toM/MqLYhYsDGg9N0OwuUe9slHgbPNNF3HRs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=I/e23uSetfDPNbQJ73VVjKK9nZ1bthfpS3Zql35PcCNoj5NV5N6xR197PPB2Arrts
 TRXgPzfxizFarxuSQD1btAuq6RoftDsxW06yyytjhe6QvdQcgmEnnuoSokgY/sboOt
 0IiiDy2rS6OX/90MmeVpKl+N2Y6OucBr9QMb9qeiK4KRPiPoZkiyZUfCCp8gtsAnut
 9r6oJfTHPMMYXgS6oIGDm/eZ3FsSv3BfPZCTPccRZRW7pW1b8q2WJRpKq9wecdoalH
 SJmG6KB+i1NrjrmDg1l5RiWqWCUd4ZTqBgrXTU+cgVxmxVhPyTCD7bG5fttqqGwbmj
 0dZ/0yOAJMI+w==
From: Niklas Cassel <cassel@kernel.org>
To: qemu-devel@nongnu.org
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
Subject: [PATCH v16 9/9] scsi: add the sense codes of zoned block devices
Date: Fri, 30 Oct 2026 18:10:36 +0100
Message-ID: <20261030171038.702962-10-cassel@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030171038.702962-1-cassel@kernel.org>
References: <20261030171038.702962-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the sense codes that a zoned block device reports when a request
violates the zone model (ZBC-3 and ZAC-3):

  ILLEGAL REQUEST, UNALIGNED WRITE COMMAND (21h/04h): a write that
  does not start at the write pointer of a sequential write required
  zone

  ILLEGAL REQUEST, WRITE BOUNDARY VIOLATION (21h/05h): a write that
  crosses the end of the writable part of a zone

  DATA PROTECT, INSUFFICIENT ZONE RESOURCES (55h/0Eh): a request that
  would open or activate more zones than the device allows

The IDE device is going to report them for zoned devices.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 include/scsi/utils.h |  6 ++++++
 scsi/utils.c         | 15 +++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/scsi/utils.h b/include/scsi/utils.h
index d5c8efa16e..d16c264b22 100644
--- a/include/scsi/utils.h
+++ b/include/scsi/utils.h
@@ -69,6 +69,10 @@ extern const struct SCSISense sense_code_TARGET_FAILURE;
 extern const struct SCSISense sense_code_INVALID_OPCODE;
 /* Illegal request, LBA out of range */
 extern const struct SCSISense sense_code_LBA_OUT_OF_RANGE;
+/* Illegal request, Unaligned write command */
+extern const struct SCSISense sense_code_UNALIGNED_WRITE;
+/* Illegal request, Write boundary violation */
+extern const struct SCSISense sense_code_WRITE_BOUNDARY_VIOLATION;
 /* Illegal request, Invalid field in CDB */
 extern const struct SCSISense sense_code_INVALID_FIELD;
 /* Illegal request, Invalid field in parameter list */
@@ -119,6 +123,8 @@ extern const struct SCSISense sense_code_DEVICE_INTERNAL_RESET;
 extern const struct SCSISense sense_code_WRITE_PROTECTED;
 /* Data Protection, Space Allocation Failed Write Protect */
 extern const struct SCSISense sense_code_SPACE_ALLOC_FAILED;
+/* Data Protection, Insufficient zone resources */
+extern const struct SCSISense sense_code_INSUFFICIENT_ZONE_RESOURCES;
 
 #define SENSE_CODE(x) sense_code_ ## x
 
diff --git a/scsi/utils.c b/scsi/utils.c
index 1ee68e6822..9eb41aefdf 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -190,6 +190,16 @@ const struct SCSISense sense_code_LBA_OUT_OF_RANGE = {
     .key = ILLEGAL_REQUEST, .asc = 0x21, .ascq = 0x00
 };
 
+/* Illegal request, Unaligned write command */
+const struct SCSISense sense_code_UNALIGNED_WRITE = {
+    .key = ILLEGAL_REQUEST, .asc = 0x21, .ascq = 0x04
+};
+
+/* Illegal request, Write boundary violation */
+const struct SCSISense sense_code_WRITE_BOUNDARY_VIOLATION = {
+    .key = ILLEGAL_REQUEST, .asc = 0x21, .ascq = 0x05
+};
+
 /* Illegal request, Invalid field in CDB */
 const struct SCSISense sense_code_INVALID_FIELD = {
     .key = ILLEGAL_REQUEST, .asc = 0x24, .ascq = 0x00
@@ -330,6 +340,11 @@ const struct SCSISense sense_code_SPACE_ALLOC_FAILED = {
     .key = DATA_PROTECT, .asc = 0x27, .ascq = 0x07
 };
 
+/* Data Protection, Insufficient zone resources */
+const struct SCSISense sense_code_INSUFFICIENT_ZONE_RESOURCES = {
+    .key = DATA_PROTECT, .asc = 0x55, .ascq = 0x0e
+};
+
 /*
  * scsi_convert_sense
  *
-- 
2.56.0


