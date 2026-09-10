Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A67C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 21:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4mBd-0006IL-7I; Thu, 10 Sep 2026 17:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lIz-00022t-BJ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lIe-0008FP-RB
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s25v9MuORRs6iYLVe6PGLtMBi7BEybbRfKrSYsEB5hA=;
 b=WqPDPB5MJHZ7UQ07uJyt4rUjNKXS3dOVuK2+xaEM0uorkNk2KEK04U+QNeVde1CKuvkErJ
 thYL3OnahJoOhlHVmpBkdHkPp8cMT3jysVP+0uBqd05vlKUFtHGXO8nf6oI2OhCzJmcV77
 CVdvFbBO0nOhab6UbzFR3CzWBJwIu1E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-Rw0vn4NhP5ecdl8olT9EnA-1; Thu, 10 Sep 2026 16:14:15 -0400
X-MC-Unique: Rw0vn4NhP5ecdl8olT9EnA-1
X-Mimecast-MFC-AGG-ID: Rw0vn4NhP5ecdl8olT9EnA_1789071254
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-485f6788029so101970f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071254; x=1789676054; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s25v9MuORRs6iYLVe6PGLtMBi7BEybbRfKrSYsEB5hA=;
 b=a6YNT7DnZl69dZIuELTSv0HRQj4DHefTywWIiVZsEt6BNa3Wj36qeKjmP1fMGWehtX
 QYuLy8Vzw8qn0D5iRA6C3yeNQS4Sf8iRg0FA7ve3YjjRt+/BKMWzCOu1Pm0PbPVTRFSH
 zKbOn2107RPGc73ECmqu8zhwvi3ZsZs2fQIhZ0Ti45KlqcokCks5rbS9CTrCoJA+d+Xh
 4o4RM51+LXnd+1bZ3fsCDCYhLKHNhRronvoQE6rdrLbJj+6v4lEd6TcBQZ+pnvaRAZ7z
 9zY/wa1AIKIySzFx8WWIC6oV/dB60Z0FW+VeqK3USYamIG1S1lOs7SvoTk4BCBxyNqOq
 +Vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071254; x=1789676054;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s25v9MuORRs6iYLVe6PGLtMBi7BEybbRfKrSYsEB5hA=;
 b=nm0HfO5QNqWgtiDJeiDaaFMM5gN7KEUMWDtL6wdovtjO4HqoOP00eMn0BOBEff5PDi
 eax7sO2+j6CvIr80ZwyTF09haRkM3X/P1suC3rKoFrb0cBQlGByrhfNG2Rqin9a8Bfvs
 PJAgpgnUGDP/NJEqrn+b+2xqsSCjTdk27yNfKz3YrCvqRrpFkSdJhiPpXVYUHLe2wznv
 ZepYlet2m8VvtRpqv8TC/vt9IyzasxjPPSdlIQeiglDbTmv0rmQKT3Og7DohrVyGlHQR
 xzWB0YO1Fk8/xVaPJqMVSelJqAQr8yzBmqagdaRLqmrB1Yn8Ec58K5ADOBgbMZccYHm5
 9mbw==
X-Gm-Message-State: AFuF++lo9UNHSCZiOxUwHRi/JjoaUwYpJk2F/FQDkJ60dVXKx7SEjG+N
 gJIofj4bXekmfQWbWX1QFLigqh+gcpmj+fmoSJQ0d0OAzjn4Yrqkc6y9fgK6lytdubjHVa2yF0Q
 Le7QYkqhFwBwbyzhiDZexKWk4O/mVO46xONPoW+5hJV73csbRhNxfh/UD46673D7FLEVNS817Ba
 M2EDbBsRyPvxDZtCiwYhJL2jSOUkRgoolzNw==
X-Gm-Gg: AYBFou22P+kV9yUGjKBUqZsHrk+4h6woAYYCNwLdhS7opDkdDKvLp8or5YquGP3G2VM
 BTQXsMMXJOiP7mhKeAEzpGKVWRd6L8LrLD0/fThYzttnGUJzrpUq4ac3nQyijlzFDW8jxP+GEJW
 LcBFd9QeF/Gd+o9j0l/m7y0SZ/UbEfWRDEkO4ujEyhWLTKMpFseHPUiCImXZlvgc7thOuLP4NyI
 rL3ADcgk6SGJX6R7JU0SY/+1UnJGpegIBLbg3/j//VAYx9oX9ApkPS4/BR7u217hRjVWvbUOPBI
 oi36w/MbcJHkDIWUBNsOhiZjMAuX+mHBThfbHJ01GdCRnrsFVK2VVWjVl4wqv/bgqeG6fmMn56e
 /cp7lbPZIj2mNEVP5AlZe1NE=
X-Received: by 2002:a05:6000:46d0:b0:485:b096:d2d3 with SMTP id
 ffacd0b85a97d-486eb2d9f0amr1164665f8f.7.1789071254210; 
 Thu, 10 Sep 2026 13:14:14 -0700 (PDT)
X-Received: by 2002:a05:6000:46d0:b0:485:b096:d2d3 with SMTP id
 ffacd0b85a97d-486eb2d9f0amr1164588f8f.7.1789071253600; 
 Thu, 10 Sep 2026 13:14:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb2ecfc3sm792759f8f.4.2026.09.10.13.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:14:12 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:14:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 65/90] tests/acpi: x86: update golden masters for IVRS
Message-ID: <6795e746b2aafca99198d3fa0058f9095c2cb2d4.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Differences between disassembled ASL files for IVRS:

 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20200925 (64-bit version)
  * Copyright (c) 2000 - 2020 Intel Corporation
  *
- * Disassembly of tests/data/acpi/x86/q35/IVRS.ivrs, Mon May 11 11:21:47 2026
+ * Disassembly of /tmp/aml-NGQ9O3, Mon May 11 11:21:47 2026
  *
  * ACPI Data Table [IVRS]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue
  */

 [000h 0000   4]                    Signature : "IVRS"    [I/O Virtualization Reporting Structure]
 [004h 0004   4]                 Table Length : 000000B0
 [008h 0008   1]                     Revision : 01
-[009h 0009   1]                     Checksum : 74
+[009h 0009   1]                     Checksum : CB
 [00Ah 0010   6]                       Oem ID : "BOCHS "
 [010h 0016   8]                 Oem Table ID : "BXPC    "
 [018h 0024   4]                 Oem Revision : 00000001
 [01Ch 0028   4]              Asl Compiler ID : "BXPC"
 [020h 0032   4]        Asl Compiler Revision : 00000001

-[024h 0036   4]          Virtualization Info : 00002801
+[024h 0036   4]          Virtualization Info : 00203441
 [028h 0040   8]                     Reserved : 0000000000000000

 [030h 0048   1]                Subtable Type : 10 [Hardware Definition Block]
-[031h 0049   1]                        Flags : D1
+[031h 0049   1]                        Flags : 51
 [032h 0050   2]                       Length : 0038
 [034h 0052   2]                     DeviceId : 0010

 [036h 0054   2]            Capability Offset : 0040
 [038h 0056   8]                 Base Address : 00000000FED80000
 [040h 0064   2]            PCI Segment Group : 0000
 [042h 0066   2]          Virtualization Info : 0000
-[044h 0068   4]            Feature Reporting : 00000044
+[044h 0068   4]            Feature Reporting : A0000064

 [048h 0072   1]                   Entry Type : 02
 [049h 0073   2]                    Device ID : 0000
 [04Bh 0075   1]                 Data Setting : 00

 [04Ch 0076   1]                   Entry Type : 02
 [04Dh 0077   2]                    Device ID : 0008
 [04Fh 0079   1]                 Data Setting : 00

 [050h 0080   1]                   Entry Type : 02
 [051h 0081   2]                    Device ID : 0010
 [053h 0083   1]                 Data Setting : 00

 [054h 0084   1]                   Entry Type : 02
 [055h 0085   2]                    Device ID : 00F8
 [057h 0087   1]                 Data Setting : 00
@@ -62,33 +62,33 @@
 [061h 0097   2]                    Device ID : 0000
 [063h 0099   1]                 Data Setting : 00
 [064h 0100   1]                       Handle : 00
 [065h 0101   2]        Source Used Device ID : 00A0
 [067h 0103   1]                      Variety : 01

 [068h 0104   1]                Subtable Type : 11 [Hardware Definition Block]
 [069h 0105   1]                        Flags : 11
 [06Ah 0106   2]                       Length : 0048
 [06Ch 0108   2]                     DeviceId : 0010

 [06Eh 0110   2]            Capability Offset : 0040
 [070h 0112   8]                 Base Address : 00000000FED80000
 [078h 0120   2]            PCI Segment Group : 0000
 [07Ah 0122   2]          Virtualization Info : 0000
 [07Ch 0124   4]                   Attributes : 00000000
-[080h 0128   8]                    EFR Image : 00000000000029D3
+[080h 0128   8]                    EFR Image : 00000000000028D1
 [088h 0136   8]                     Reserved : 0000000000000000

 [090h 0144   1]                   Entry Type : 02
 [091h 0145   2]                    Device ID : 0000
 [093h 0147   1]                 Data Setting : 00

 [094h 0148   1]                   Entry Type : 02
 [095h 0149   2]                    Device ID : 0008
 [097h 0151   1]                 Data Setting : 00

 [098h 0152   1]                   Entry Type : 02
 [099h 0153   2]                    Device ID : 0010
 [09Bh 0155   1]                 Data Setting : 00

 [09Ch 0156   1]                   Entry Type : 02
 [09Dh 0157   2]                    Device ID : 00F8
@@ -98,27 +98,27 @@
 [0A1h 0161   2]                    Device ID : 00FA
 [0A3h 0163   1]                 Data Setting : 00

 [0A4h 0164   1]                   Entry Type : 02
 [0A5h 0165   2]                    Device ID : 00FB
 [0A7h 0167   1]                 Data Setting : 00

 [0A8h 0168   1]                   Entry Type : 48
 [0A9h 0169   2]                    Device ID : 0000
 [0ABh 0171   1]                 Data Setting : 00
 [0ACh 0172   1]                       Handle : 00
 [0ADh 0173   2]        Source Used Device ID : 00A0
 [0AFh 0175   1]                      Variety : 01

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260807061250.27739-8-sarunkod@amd.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/x86/q35/IVRS.ivrs           | Bin 176 -> 176 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 33e9981655..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-tests/data/acpi/x86/q35/IVRS.ivrs
diff --git a/tests/data/acpi/x86/q35/IVRS.ivrs b/tests/data/acpi/x86/q35/IVRS.ivrs
index 7f9e91aabc0b7777a7efc9f219587a4f91f0edb1..b3b809c65f026fde0a49a2243a3216e7b8c87502 100644
GIT binary patch
delta 67
zcmdnMxPg(&Gb|{00|NsC<LQZ9QYwxn3JfqH5NN?5z~I2Zz;NRqOe}?gVZp=+3KKIV
Lm@aBeY|;Y&z19uv

delta 64
zcmdnMxPg(&Gb|{00|NsCW64A=DMdyN1~?G7Xu%-B;K0DZaN{3L&}Cw;^27`YrpuZW
GoAdyMuMFt`

-- 
MST


