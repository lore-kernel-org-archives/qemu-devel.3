Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E48BCCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 11:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGbyh-00065U-GO; Wed, 05 Nov 2025 06:47:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGby8-0005k2-2j
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:46:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGby6-0002be-29
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:46:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762343185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1SsWOpMbdBPgivPXJMMIje/cYCywerwREolwMo1XTrI=;
 b=QH6LlJb78Z6/rAwA+IjegfiD/g2m/KuMy6Wb4llK2D4tlV9chc+ie0723W302AMbvJhWLE
 GChTCjfpGWojSXjP6XQfOuNw5RymczD2kcdqVKqcf/y0Hl9qdora4vje/iGHYq90eaOm7O
 fkXapEbnCEseP2vsx4WkPtzYHM+ioOY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-nAUfivNhPl6FjbcWHQUF9Q-1; Wed,
 05 Nov 2025 06:46:20 -0500
X-MC-Unique: nAUfivNhPl6FjbcWHQUF9Q-1
X-Mimecast-MFC-AGG-ID: nAUfivNhPl6FjbcWHQUF9Q_1762343179
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8AB21801234; Wed,  5 Nov 2025 11:46:18 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B44B1800451; Wed,  5 Nov 2025 11:46:12 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v3 3/8] tests/qtest/bios-tables-test: Update HEST table
Date: Wed,  5 Nov 2025 21:44:48 +1000
Message-ID: <20251105114453.2164073-4-gshan@redhat.com>
In-Reply-To: <20251105114453.2164073-1-gshan@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Update HEST table since GHES raw data maximal length has been increased
from 1KiB to 4KiB.

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/HEST
+ * Disassembly of /tmp/aml-28KMF3
  *
  * ACPI Data Table [HEST]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "HEST"    [Hardware Error Source Table]
 [004h 0004 004h]                Table Length : 000000E0
 [008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : 6C
+[009h 0009 001h]                    Checksum : 3C
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

 [024h 0036 004h]          Error Source Count : 00000002

 [028h 0040 002h]               Subtable Type : 000A [Generic Hardware Error Source V2]
 [02Ah 0042 002h]                   Source Id : 0000
 [02Ch 0044 002h]           Related Source Id : FFFF
 [02Eh 0046 001h]                    Reserved : 00
 [02Fh 0047 001h]                     Enabled : 01
 [030h 0048 004h]      Records To Preallocate : 00000001
 [034h 0052 004h]     Max Sections Per Record : 00000001
-[038h 0056 004h]         Max Raw Data Length : 00000400
+[038h 0056 004h]         Max Raw Data Length : 00001000

 [03Ch 0060 00Ch]        Error Status Address : [Generic Address Structure]
 [03Ch 0060 001h]                    Space ID : 00 [SystemMemory]
 [03Dh 0061 001h]                   Bit Width : 40
 [03Eh 0062 001h]                  Bit Offset : 00
 [03Fh 0063 001h]        Encoded Access Width : 04 [QWord Access:64]
 [040h 0064 008h]                     Address : 0000000043DA0000

 [048h 0072 01Ch]                      Notify : [Hardware Error Notification Structure]
 [048h 0072 001h]                 Notify Type : 08 [SEA]
 [049h 0073 001h]               Notify Length : 1C
 [04Ah 0074 002h]  Configuration Write Enable : 0000
 [04Ch 0076 004h]                PollInterval : 00000000
 [050h 0080 004h]                      Vector : 00000000
 [054h 0084 004h]     Polling Threshold Value : 00000000
 [058h 0088 004h]    Polling Threshold Window : 00000000
 [05Ch 0092 004h]       Error Threshold Value : 00000000
 [060h 0096 004h]      Error Threshold Window : 00000000

-[064h 0100 004h]   Error Status Block Length : 00000400
+[064h 0100 004h]   Error Status Block Length : 00001000
 [068h 0104 00Ch]           Read Ack Register : [Generic Address Structure]
 [068h 0104 001h]                    Space ID : 00 [SystemMemory]
 [069h 0105 001h]                   Bit Width : 40
 [06Ah 0106 001h]                  Bit Offset : 00
 [06Bh 0107 001h]        Encoded Access Width : 04 [QWord Access:64]
 [06Ch 0108 008h]                     Address : 0000000043DA0010

 [074h 0116 008h]           Read Ack Preserve : FFFFFFFFFFFFFFFE
 [07Ch 0124 008h]              Read Ack Write : 0000000000000001

 [084h 0132 002h]               Subtable Type : 000A [Generic Hardware Error Source V2]
 [086h 0134 002h]                   Source Id : 0001
 [088h 0136 002h]           Related Source Id : FFFF
 [08Ah 0138 001h]                    Reserved : 00
 [08Bh 0139 001h]                     Enabled : 01
 [08Ch 0140 004h]      Records To Preallocate : 00000001
 [090h 0144 004h]     Max Sections Per Record : 00000001
-[094h 0148 004h]         Max Raw Data Length : 00000400
+[094h 0148 004h]         Max Raw Data Length : 00001000

 [098h 0152 00Ch]        Error Status Address : [Generic Address Structure]
 [098h 0152 001h]                    Space ID : 00 [SystemMemory]
 [099h 0153 001h]                   Bit Width : 40
 [09Ah 0154 001h]                  Bit Offset : 00
 [09Bh 0155 001h]        Encoded Access Width : 04 [QWord Access:64]
 [09Ch 0156 008h]                     Address : 0000000043DA0008

 [0A4h 0164 01Ch]                      Notify : [Hardware Error Notification Structure]
 [0A4h 0164 001h]                 Notify Type : 07 [GPIO]
 [0A5h 0165 001h]               Notify Length : 1C
 [0A6h 0166 002h]  Configuration Write Enable : 0000
 [0A8h 0168 004h]                PollInterval : 00000000
 [0ACh 0172 004h]                      Vector : 00000000
 [0B0h 0176 004h]     Polling Threshold Value : 00000000
 [0B4h 0180 004h]    Polling Threshold Window : 00000000
 [0B8h 0184 004h]       Error Threshold Value : 00000000
 [0BCh 0188 004h]      Error Threshold Window : 00000000

-[0C0h 0192 004h]   Error Status Block Length : 00000400
+[0C0h 0192 004h]   Error Status Block Length : 00001000
 [0C4h 0196 00Ch]           Read Ack Register : [Generic Address Structure]
 [0C4h 0196 001h]                    Space ID : 00 [SystemMemory]
 [0C5h 0197 001h]                   Bit Width : 40
 [0C6h 0198 001h]                  Bit Offset : 00
 [0C7h 0199 001h]        Encoded Access Width : 04 [QWord Access:64]
 [0C8h 0200 008h]                     Address : 0000000043DA0018

 [0D0h 0208 008h]           Read Ack Preserve : FFFFFFFFFFFFFFFE
 [0D8h 0216 008h]              Read Ack Write : 0000000000000001

 Raw Table Data: Length 224 (0xE0)

-    0000: 48 45 53 54 E0 00 00 00 01 6C 42 4F 43 48 53 20  // HEST.....lBOCHS
+    0000: 48 45 53 54 E0 00 00 00 01 3C 42 4F 43 48 53 20  // HEST.....<BOCHS
     0010: 42 58 50 43 20 20 20 20 01 00 00 00 42 58 50 43  // BXPC    ....BXPC
     0020: 01 00 00 00 02 00 00 00 0A 00 00 00 FF FF 00 01  // ................
-    0030: 01 00 00 00 01 00 00 00 00 04 00 00 00 40 00 04  // .............@..
+    0030: 01 00 00 00 01 00 00 00 00 10 00 00 00 40 00 04  // .............@..
     0040: 00 00 DA 43 00 00 00 00 08 1C 00 00 00 00 00 00  // ...C............
     0050: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
-    0060: 00 00 00 00 00 04 00 00 00 40 00 04 10 00 DA 43  // .........@.....C
+    0060: 00 00 00 00 00 10 00 00 00 40 00 04 10 00 DA 43  // .........@.....C
     0070: 00 00 00 00 FE FF FF FF FF FF FF FF 01 00 00 00  // ................
     0080: 00 00 00 00 0A 00 01 00 FF FF 00 01 01 00 00 00  // ................
-    0090: 01 00 00 00 00 04 00 00 00 40 00 04 08 00 DA 43  // .........@.....C
+    0090: 01 00 00 00 00 10 00 00 00 40 00 04 08 00 DA 43  // .........@.....C
     00A0: 00 00 00 00 07 1C 00 00 00 00 00 00 00 00 00 00  // ................
     00B0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  // ................
-    00C0: 00 04 00 00 00 40 00 04 18 00 DA 43 00 00 00 00  // .....@.....C....
+    00C0: 00 10 00 00 00 40 00 04 18 00 DA 43 00 00 00 00  // .....@.....C....
     00D0: FE FF FF FF FF FF FF FF 01 00 00 00 00 00 00 00  // ................

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 tests/data/acpi/aarch64/virt/HEST           | Bin 224 -> 224 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
index 674272922db7d48f7821aa7c83ec76bb3b556d2a..247345901b9be41a86c51bcced59287f74f9e918 100644
GIT binary patch
delta 45
ycmaFB_<)hi!!<bM0RsaAqs>GveMW(aR@#gL6VpJfY1$kD3=9ko3@j28bHxD$GYS#_

delta 45
ycmaFB_<)hi!!<bM0RsaAW6ne_eMXjvR@#g#6VpJfY1$kt3=9ko3@j28bHxD&iwY6|

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 39901c58d6..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/HEST",
-- 
2.51.0


