Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5346DC7115A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 09:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR6VZ-0005bY-Oe; Mon, 16 Jun 2025 05:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uR6VQ-0005Ef-P6
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:51:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uR6VN-0002Pf-CW
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:51:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750067512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iFIPgpbJot2n4R+IhDOYD8e6H3UZOAwfnOjuqo4PC9U=;
 b=Q1gNe5tVmVqLgNkHwNUggtx0vixnVLbuoo2OTw3BqX7np2h5nf/bBtdUWzzXzFi/DKQAhc
 z4HeFRzF/KwAvd4OylnX1sUYU0b4kyCSg9bxlD+kr4AbP3KzTU4YclA/htI+ACpAeF5dD9
 3J4H8j8PMITQOrDBJTQiHvI1TbtLeGw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-Bm0n0IaLPPi3r_paCJV3KA-1; Mon,
 16 Jun 2025 05:51:47 -0400
X-MC-Unique: Bm0n0IaLPPi3r_paCJV3KA-1
X-Mimecast-MFC-AGG-ID: Bm0n0IaLPPi3r_paCJV3KA_1750067505
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCB471809C8E; Mon, 16 Jun 2025 09:51:45 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.77])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7440F19560A3; Mon, 16 Jun 2025 09:51:40 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: [PATCH v3 29/29] qtest/bios-tables-test: Create DSDT 'acpipcihp"
 variant blob
Date: Mon, 16 Jun 2025 11:46:58 +0200
Message-ID: <20250616094903.885753-30-eric.auger@redhat.com>
In-Reply-To: <20250616094903.885753-1-eric.auger@redhat.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Update the .acpipcihp blob variant for the aarch64 'virt' machine.
Because this is a new blob, the diff is rather large.

@@ -1,2 +1,2110 @@
+/*
+ * Intel ACPI Component Architecture
+ * AML/ASL+ Disassembler version 20210604 (64-bit version)
+ * Copyright (c) 2000 - 2021 Intel Corporation
+ *
+ * Disassembling to symbolic ASL+ operators
+ *
+ * Disassembly of /tmp/aml-UTAS72, Sun Jun 15 10:03:40 2025
+ *
+ * Original Table Header:
+ *     Signature        "DSDT"
+ *     Length           0x00001755 (5973)
+ *     Revision         0x02
+ *     Checksum         0xF3
+ *     OEM ID           "BOCHS "
+ *     OEM Table ID     "BXPC    "
+ *     OEM Revision     0x00000001 (1)
+ *     Compiler ID      "BXPC"
+ *     Compiler Version 0x00000001 (1)
+ */
+DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
+{
+    Scope (\_SB)
+    {
+        Device (C000)
+        {
+            Name (_HID, "ACPI0007" /* Processor Device */)  // _HID: Hardware ID
+            Name (_UID, Zero)  // _UID: Unique ID
+        }

+        Device (COM0)
+        {
+            Name (_HID, "ARMH0011")  // _HID: Hardware ID
+            Name (_UID, Zero)  // _UID: Unique ID
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x09000000,         // Address Base
+                    0x00001000,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000021,
+                }
+            })
+        }
+
+        Device (FWCF)
+        {
+            Name (_HID, "QEMU0002")  // _HID: Hardware ID
+            Name (_STA, 0x0B)  // _STA: Status
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x09020000,         // Address Base
+                    0x00000018,         // Address Length
+                    )
+            })
+        }
+
+        Device (VR00)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, Zero)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A000000,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000030,
+                }
+            })
+        }
+
+        Device (VR01)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, One)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A000200,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000031,
+                }
+            })
+        }
+
+        Device (VR02)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x02)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A000400,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000032,
+                }
+            })
+        }
+
+        Device (VR03)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x03)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A000600,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000033,
+                }
+            })
+        }
+
+        Device (VR04)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x04)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A000800,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000034,
+                }
+            })
+        }
+
+        Device (VR05)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x05)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A000A00,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000035,
+                }
+            })
+        }
+
+        Device (VR06)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x06)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A000C00,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000036,
+                }
+            })
+        }
+
+        Device (VR07)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x07)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A000E00,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000037,
+                }
+            })
+        }
+
+        Device (VR08)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x08)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A001000,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000038,
+                }
+            })
+        }
+
+        Device (VR09)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x09)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A001200,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000039,
+                }
+            })
+        }
+
+        Device (VR10)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x0A)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A001400,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x0000003A,
+                }
+            })
+        }
+
+        Device (VR11)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x0B)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A001600,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x0000003B,
+                }
+            })
+        }
+
+        Device (VR12)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x0C)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A001800,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x0000003C,
+                }
+            })
+        }
+
+        Device (VR13)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x0D)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A001A00,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x0000003D,
+                }
+            })
+        }
+
+        Device (VR14)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x0E)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A001C00,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x0000003E,
+                }
+            })
+        }
+
+        Device (VR15)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x0F)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A001E00,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x0000003F,
+                }
+            })
+        }
+
+        Device (VR16)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x10)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A002000,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000040,
+                }
+            })
+        }
+
+        Device (VR17)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x11)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A002200,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000041,
+                }
+            })
+        }
+
+        Device (VR18)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x12)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A002400,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000042,
+                }
+            })
+        }
+
+        Device (VR19)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x13)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A002600,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000043,
+                }
+            })
+        }
+
+        Device (VR20)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x14)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A002800,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000044,
+                }
+            })
+        }
+
+        Device (VR21)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x15)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A002A00,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000045,
+                }
+            })
+        }
+
+        Device (VR22)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x16)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A002C00,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000046,
+                }
+            })
+        }
+
+        Device (VR23)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x17)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A002E00,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000047,
+                }
+            })
+        }
+
+        Device (VR24)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x18)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A003000,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000048,
+                }
+            })
+        }
+
+        Device (VR25)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x19)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A003200,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000049,
+                }
+            })
+        }
+
+        Device (VR26)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x1A)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A003400,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x0000004A,
+                }
+            })
+        }
+
+        Device (VR27)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x1B)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A003600,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x0000004B,
+                }
+            })
+        }
+
+        Device (VR28)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x1C)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A003800,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x0000004C,
+                }
+            })
+        }
+
+        Device (VR29)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x1D)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A003A00,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x0000004D,
+                }
+            })
+        }
+
+        Device (VR30)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x1E)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A003C00,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x0000004E,
+                }
+            })
+        }
+
+        Device (VR31)
+        {
+            Name (_HID, "LNRO0005")  // _HID: Hardware ID
+            Name (_UID, 0x1F)  // _UID: Unique ID
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Memory32Fixed (ReadWrite,
+                    0x0A003E00,         // Address Base
+                    0x00000200,         // Address Length
+                    )
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x0000004F,
+                }
+            })
+        }
+
+        Device (L000)
+        {
+            Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)  // _HID: Hardware ID
+            Name (_UID, Zero)  // _UID: Unique ID
+            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
+            {
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000023,
+                }
+            })
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000023,
+                }
+            })
+            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
+            {
+            }
+        }
+
+        Device (L001)
+        {
+            Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)  // _HID: Hardware ID
+            Name (_UID, One)  // _UID: Unique ID
+            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
+            {
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000024,
+                }
+            })
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000024,
+                }
+            })
+            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
+            {
+            }
+        }
+
+        Device (L002)
+        {
+            Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)  // _HID: Hardware ID
+            Name (_UID, 0x02)  // _UID: Unique ID
+            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
+            {
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000025,
+                }
+            })
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000025,
+                }
+            })
+            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
+            {
+            }
+        }
+
+        Device (L003)
+        {
+            Name (_HID, "PNP0C0F" /* PCI Interrupt Link Device */)  // _HID: Hardware ID
+            Name (_UID, 0x03)  // _UID: Unique ID
+            Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
+            {
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000026,
+                }
+            })
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000026,
+                }
+            })
+            Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
+            {
+            }
+        }
+
+        Device (PCI0)
+        {
+            Name (_HID, "PNP0A08" /* PCI Express Bus */)  // _HID: Hardware ID
+            Name (_CID, "PNP0A03" /* PCI Bus */)  // _CID: Compatible ID
+            Name (_SEG, Zero)  // _SEG: PCI Segment
+            Name (_BBN, Zero)  // _BBN: BIOS Bus Number
+            Name (_UID, Zero)  // _UID: Unique ID
+            Name (_STR, Unicode ("PCIe 0 Device"))  // _STR: Description String
+            Name (_CCA, One)  // _CCA: Cache Coherency Attribute
+            Name (_PRT, Package (0x80)  // _PRT: PCI Routing Table
+            {
+                Package (0x04)
+                {
+                    0xFFFF,
+                    Zero,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0xFFFF,
+                    One,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0xFFFF,
+                    0x02,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0xFFFF,
+                    0x03,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0001FFFF,
+                    Zero,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0001FFFF,
+                    One,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0001FFFF,
+                    0x02,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0001FFFF,
+                    0x03,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0002FFFF,
+                    Zero,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0002FFFF,
+                    One,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0002FFFF,
+                    0x02,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0002FFFF,
+                    0x03,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0003FFFF,
+                    Zero,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0003FFFF,
+                    One,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0003FFFF,
+                    0x02,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0003FFFF,
+                    0x03,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0004FFFF,
+                    Zero,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0004FFFF,
+                    One,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0004FFFF,
+                    0x02,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0004FFFF,
+                    0x03,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0005FFFF,
+                    Zero,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0005FFFF,
+                    One,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0005FFFF,
+                    0x02,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0005FFFF,
+                    0x03,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0006FFFF,
+                    Zero,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0006FFFF,
+                    One,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0006FFFF,
+                    0x02,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0006FFFF,
+                    0x03,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0007FFFF,
+                    Zero,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0007FFFF,
+                    One,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0007FFFF,
+                    0x02,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0007FFFF,
+                    0x03,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0008FFFF,
+                    Zero,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0008FFFF,
+                    One,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0008FFFF,
+                    0x02,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0008FFFF,
+                    0x03,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0009FFFF,
+                    Zero,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0009FFFF,
+                    One,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0009FFFF,
+                    0x02,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0009FFFF,
+                    0x03,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000AFFFF,
+                    Zero,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000AFFFF,
+                    One,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000AFFFF,
+                    0x02,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000AFFFF,
+                    0x03,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000BFFFF,
+                    Zero,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000BFFFF,
+                    One,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000BFFFF,
+                    0x02,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000BFFFF,
+                    0x03,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000CFFFF,
+                    Zero,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000CFFFF,
+                    One,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000CFFFF,
+                    0x02,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000CFFFF,
+                    0x03,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000DFFFF,
+                    Zero,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000DFFFF,
+                    One,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000DFFFF,
+                    0x02,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000DFFFF,
+                    0x03,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000EFFFF,
+                    Zero,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000EFFFF,
+                    One,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000EFFFF,
+                    0x02,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000EFFFF,
+                    0x03,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000FFFFF,
+                    Zero,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000FFFFF,
+                    One,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000FFFFF,
+                    0x02,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x000FFFFF,
+                    0x03,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0010FFFF,
+                    Zero,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0010FFFF,
+                    One,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0010FFFF,
+                    0x02,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0010FFFF,
+                    0x03,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0011FFFF,
+                    Zero,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0011FFFF,
+                    One,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0011FFFF,
+                    0x02,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0011FFFF,
+                    0x03,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0012FFFF,
+                    Zero,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0012FFFF,
+                    One,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0012FFFF,
+                    0x02,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0012FFFF,
+                    0x03,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0013FFFF,
+                    Zero,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0013FFFF,
+                    One,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0013FFFF,
+                    0x02,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0013FFFF,
+                    0x03,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0014FFFF,
+                    Zero,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0014FFFF,
+                    One,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0014FFFF,
+                    0x02,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0014FFFF,
+                    0x03,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0015FFFF,
+                    Zero,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0015FFFF,
+                    One,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0015FFFF,
+                    0x02,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0015FFFF,
+                    0x03,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0016FFFF,
+                    Zero,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0016FFFF,
+                    One,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0016FFFF,
+                    0x02,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0016FFFF,
+                    0x03,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0017FFFF,
+                    Zero,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0017FFFF,
+                    One,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0017FFFF,
+                    0x02,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0017FFFF,
+                    0x03,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0018FFFF,
+                    Zero,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0018FFFF,
+                    One,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0018FFFF,
+                    0x02,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0018FFFF,
+                    0x03,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0019FFFF,
+                    Zero,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0019FFFF,
+                    One,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0019FFFF,
+                    0x02,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x0019FFFF,
+                    0x03,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001AFFFF,
+                    Zero,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001AFFFF,
+                    One,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001AFFFF,
+                    0x02,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001AFFFF,
+                    0x03,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001BFFFF,
+                    Zero,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001BFFFF,
+                    One,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001BFFFF,
+                    0x02,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001BFFFF,
+                    0x03,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001CFFFF,
+                    Zero,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001CFFFF,
+                    One,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001CFFFF,
+                    0x02,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001CFFFF,
+                    0x03,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001DFFFF,
+                    Zero,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001DFFFF,
+                    One,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001DFFFF,
+                    0x02,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001DFFFF,
+                    0x03,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001EFFFF,
+                    Zero,
+                    L002,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001EFFFF,
+                    One,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001EFFFF,
+                    0x02,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001EFFFF,
+                    0x03,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001FFFFF,
+                    Zero,
+                    L003,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001FFFFF,
+                    One,
+                    L000,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001FFFFF,
+                    0x02,
+                    L001,
+                    Zero
+                },
+
+                Package (0x04)
+                {
+                    0x001FFFFF,
+                    0x03,
+                    L002,
+                    Zero
+                }
+            })
+            Method (_CBA, 0, NotSerialized)  // _CBA: Configuration Base Address
+            {
+                Return (0x0000004010000000)
+            }
+
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
+                    0x0000,             // Granularity
+                    0x0000,             // Range Minimum
+                    0x00FF,             // Range Maximum
+                    0x0000,             // Translation Offset
+                    0x0100,             // Length
+                    ,, )
+                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
+                    0x00000000,         // Granularity
+                    0x10000000,         // Range Minimum
+                    0x3EFEFFFF,         // Range Maximum
+                    0x00000000,         // Translation Offset
+                    0x2EFF0000,         // Length
+                    ,, , AddressRangeMemory, TypeStatic)
+                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
+                    0x00000000,         // Granularity
+                    0x00000000,         // Range Minimum
+                    0x0000FFFF,         // Range Maximum
+                    0x3EFF0000,         // Translation Offset
+                    0x00010000,         // Length
+                    ,, , TypeStatic, DenseTranslation)
+                QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
+                    0x0000000000000000, // Granularity
+                    0x0000008000000000, // Range Minimum
+                    0x000000FFFFFFFFFF, // Range Maximum
+                    0x0000000000000000, // Translation Offset
+                    0x0000008000000000, // Length
+                    ,, , AddressRangeMemory, TypeStatic)
+            })
+            Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
+            {
+                CreateDWordField (Arg3, Zero, CDW1)
+                If ((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
+                {
+                    CreateDWordField (Arg3, 0x04, CDW2)
+                    CreateDWordField (Arg3, 0x08, CDW3)
+                    Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
+                    Local0 &= 0x1E
+                    If ((Arg1 != One))
+                    {
+                        CDW1 |= 0x08
+                    }
+
+                    If ((CDW3 != Local0))
+                    {
+                        CDW1 |= 0x10
+                    }
+
+                    CDW3 = Local0
+                }
+                Else
+                {
+                    CDW1 |= 0x04
+                }
+
+                Return (Arg3)
+            }
+
+            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
+            {
+                If ((Arg0 == ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
+                {
+                    If ((Arg2 == Zero))
+                    {
+                        Return (Buffer (One)
+                        {
+                             0x01                                             // .
+                        })
+                    }
+                }
+
+                Return (Buffer (One)
+                {
+                     0x00                                             // .
+                })
+            }
+
+            Device (RES0)
+            {
+                Name (_HID, "PNP0C02" /* PNP Motherboard Resources */)  // _HID: Hardware ID
+                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+                {
+                    QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
+                        0x0000000000000000, // Granularity
+                        0x0000004010000000, // Range Minimum
+                        0x000000401FFFFFFF, // Range Maximum
+                        0x0000000000000000, // Translation Offset
+                        0x0000000010000000, // Length
+                        ,, , AddressRangeMemory, TypeStatic)
+                })
+            }
+        }
+
+        Device (\_SB.GED)
+        {
+            Name (_HID, "ACPI0013" /* Generic Event Device */)  // _HID: Hardware ID
+            Name (_UID, "GED")  // _UID: Unique ID
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
+                {
+                    0x00000029,
+                }
+            })
+            OperationRegion (EREG, SystemMemory, 0x09080000, 0x04)
+            Field (EREG, DWordAcc, NoLock, WriteAsZeros)
+            {
+                ESEL,   32
+            }
+
+            Method (_EVT, 1, Serialized)  // _EVT: Event
+            {
+                Local0 = ESEL /* \_SB_.GED_.ESEL */
+                If (((Local0 & 0x02) == 0x02))
+                {
+                    Notify (PWRB, 0x80) // Status Change
+                }
+
+                If (((Local0 & 0x10) == 0x10))
+                {
+                    Acquire (\_SB.PCI0.BLCK, 0xFFFF)
+                    \_SB.PCI0.PCNT ()
+                    Release (\_SB.PCI0.BLCK)
+                }
+            }
+        }
+
+        Device (PWRB)
+        {
+            Name (_HID, "PNP0C0C" /* Power Button Device */)  // _HID: Hardware ID
+            Name (_UID, Zero)  // _UID: Unique ID
+        }
+    }
+
+    Scope (_SB.PCI0)
+    {
+        OperationRegion (PCST, SystemMemory, 0x090C0000, 0x08)
+        Field (PCST, DWordAcc, NoLock, WriteAsZeros)
+        {
+            PCIU,   32,
+            PCID,   32
+        }
+
+        OperationRegion (SEJ, SystemMemory, 0x090C0008, 0x04)
+        Field (SEJ, DWordAcc, NoLock, WriteAsZeros)
+        {
+            B0EJ,   32
+        }
+
+        OperationRegion (BNMR, SystemMemory, 0x090C0010, 0x08)
+        Field (BNMR, DWordAcc, NoLock, WriteAsZeros)
+        {
+            BNUM,   32,
+            PIDX,   32
+        }
+
+        Mutex (BLCK, 0x00)
+        Method (PCEJ, 2, NotSerialized)
+        {
+            Acquire (BLCK, 0xFFFF)
+            BNUM = Arg0
+            B0EJ = (One << Arg1)
+            Release (BLCK)
+            Return (Zero)
+        }
+
+        Method (AIDX, 2, NotSerialized)
+        {
+            Acquire (BLCK, 0xFFFF)
+            BNUM = Arg0
+            PIDX = (One << Arg1)
+            Local0 = PIDX /* \_SB_.PCI0.PIDX */
+            Release (BLCK)
+            Return (Local0)
+        }
+
+        Method (PDSM, 5, Serialized)
+        {
+            If ((Arg2 == Zero))
+            {
+                Local0 = Buffer (One)
+                    {
+                         0x00                                             // .
+                    }
+                If ((Arg0 != ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
+                {
+                    Return (Local0)
+                }
+
+                If ((Arg1 < 0x02))
+                {
+                    Return (Local0)
+                }
+
+                Local1 = Zero
+                Local2 = AIDX (DerefOf (Arg4 [Zero]), DerefOf (Arg4 [One]
+                    ))
+                If (!((Local2 == Zero) | (Local2 == 0xFFFFFFFF)))
+                {
+                    Local1 |= One
+                    Local1 |= (One << 0x07)
+                }
+
+                Local0 [Zero] = Local1
+                Return (Local0)
+            }
+
+            If ((Arg2 == 0x07))
+            {
+                Local2 = AIDX (DerefOf (Arg4 [Zero]), DerefOf (Arg4 [One]
+                    ))
+                Local0 = Package (0x02) {}
+                If (!((Local2 == Zero) || (Local2 == 0xFFFFFFFF)))
+                {
+                    Local0 [Zero] = Local2
+                    Local0 [One] = ""
+                }
+
+                Return (Local0)
+            }
+        }
+    }
+
+    Scope (\_SB.PCI0)
+    {
+        Method (EDSM, 5, Serialized)
+        {
+            If ((Arg2 == Zero))
+            {
+                Local0 = Buffer (One)
+                    {
+                         0x00                                             // .
+                    }
+                If ((Arg0 != ToUUID ("e5c937d0-3553-4d7a-9117-ea4d19c3434d") /* Device Labeling Interface */))
+                {
+                    Return (Local0)
+                }
+
+                If ((Arg1 < 0x02))
+                {
+                    Return (Local0)
+                }
+
+                Local0 [Zero] = 0x81
+                Return (Local0)
+            }
+
+            If ((Arg2 == 0x07))
+            {
+                Local0 = Package (0x02)
+                    {
+                        Zero,
+                        ""
+                    }
+                Local1 = DerefOf (Arg4 [Zero])
+                Local0 [Zero] = Local1
+                Return (Local0)
+            }
+        }
+
+        Device (PHPR)
+        {
+            Name (_HID, "PNP0A06" /* Generic Container Device */)  // _HID: Hardware ID
+            Name (_UID, "PCI Hotplug resources")  // _UID: Unique ID
+            Name (_STA, 0x0B)  // _STA: Status
+            Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
+            {
+                IO (Decode16,
+                    0x0000,             // Range Minimum
+                    0x0000,             // Range Maximum
+                    0x01,               // Alignment
+                    0x18,               // Length
+                    )
+            })
+        }
+
+        Device (S00)
+        {
+            Name (_ADR, Zero)  // _ADR: Address
+        }
+
+        Device (S08)
+        {
+            Name (_ADR, 0x00010000)  // _ADR: Address
+        }
+
+        Device (S20)
+        {
+            Name (_ADR, 0x00040000)  // _ADR: Address
+            Name (BSEL, Zero)
+            Device (S00)
+            {
+                Name (_ADR, Zero)  // _ADR: Address
+                Name (ASUN, Zero)
+                Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
+                {
+                    Local0 = Package (0x02)
+                        {
+                            Zero,
+                            Zero
+                        }
+                    Local0 [Zero] = BSEL /* \_SB_.PCI0.S20_.BSEL */
+                    Local0 [One] = ASUN /* \_SB_.PCI0.S20_.S00_.ASUN */
+                    Return (PDSM (Arg0, Arg1, Arg2, Arg3, Local0))
+                }
+
+                Name (_SUN, Zero)  // _SUN: Slot User Number
+                Method (_EJ0, 1, NotSerialized)  // _EJx: Eject Device, x=0-9
+                {
+                    PCEJ (BSEL, _SUN)
+                }
+            }
+
+            Method (DVNT, 2, NotSerialized)
+            {
+                If ((Arg0 & One))
+                {
+                    Notify (S00, Arg1)
+                }
+            }
+        }
+
+        Scope (S20)
+        {
+            Method (PCNT, 0, NotSerialized)
+            {
+                BNUM = Zero
+                DVNT (PCIU, One)
+                DVNT (PCID, 0x03)
+            }
+        }
+
+        Method (PCNT, 0, NotSerialized)
+        {
+            ^S20.PCNT ()
+        }
+    }
+}

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 tests/data/acpi/aarch64/virt/DSDT.acpipcihp | Bin 0 -> 5973 bytes
 2 files changed, 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dc3ab24d05..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/DSDT.acpipcihp",
diff --git a/tests/data/acpi/aarch64/virt/DSDT.acpipcihp b/tests/data/acpi/aarch64/virt/DSDT.acpipcihp
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..2d4ca84457940340ef1cc9fe8245d7b0ccef69fa 100644
GIT binary patch
literal 5973
zcmb7|&u`oI6~G_$lcFe@l4(npWlLR}c3roOk`mj^(lipu*s>*=6YV$vgON_*Esg_}
zXwm^$5WrD^)XQb4h3%{X{zC@rv|DdI?7YjaJM1<MkEHDHTfdj_K=b?KeZKEQJ_=vc
zu#LU_5<u)<on3v)u6G_<dc9t+3jl!E_*eOZE<AGWj_Zsnx~6HOyVW&vZQbf>nzjz2
zyWcgy8Qs=*`?IlOe@oLEjc81C^`Tv;NTs(KKwt(GfZwM;5Z(iTm*9*x?jPv)L+&rl
z{=TMZO%PpsuPtRoSJ&G@h$u+;5E09iqsVsR!ElyRZ!p}|H0{>avX_xpi%SrT7S~ur
zBV3&#aM>RqVho}YAv%~vlZTLEJVt_HG+9QA%ZT$BDTdKv88^9%1dkyyjGHXu7MGFa
zF(ig@i)E~F87Uq^W*BQMW1Y)L^B8%CvCc9!xD1iUP#DGr%lL%L$nY3NhVco*Xhbgu
zEip;rF;s?en`Lmzl)fahQeR{kzhD{sI+b~Olo`eymcg&n9FI|97@x8Xex2rdj4H#p
z%QE<NI>%$IGK|ky2ER@f9;41M?y(GhofdeEA2EzJ%iz~(k;izSVRTpqzfR|Qj1L%w
z&M=z%I#qd$A2SStW$^2Cfyej>!!TI}zfKo<jGr=$`z(WBrzIZa2E*878T>je^B5Y#
z*kT#{I$h#1nhc}MGWc~`;W2J9jBS>|uhV57V~t_#unc~kR(XsKhS6gg{5oCXF>W)A
zKEr77>vWaJxWh08EQ4RCH6G(G!`O`&-9+zlLu3ssP1o*UZa%D`UC2w>V4rg>m>+Ip
zXrG#L?V&9=Au39TpahYi-shmgzDv|LW);0X1cjRsHm&O%R@g^b(OX1WamxCD!wUPZ
zSm&1Bjh-5^+S&%*ldci9TDa#kH$ikeox$aOwD*REnpCwwhb|mJ9W<ze0Y~s#IEK&R
z2mm3$Hq9FD&G(*5r^Rd{JDmbP8wjt3o~AXRC}Y1A!`m}!#Cw|7f?_TqPp1N4OyjbJ
zQB5f3!?7T)b=Aa3Et(q(BAb^jjGRr4g^^km8G|5lwn{vRoMjLXB4<<MVPqqUjE9l4
zRT4quEQ3T4Ih&dYBWKAc!pPYwN#dC#o=NJN3?pZ&q=;vVc&4alih8DrXPS7Xsb`vc
zio{bSo+9-Wsb_|GW{78odS<AnL_8(pDN#>}dS;1dmUw2VXO?=(#8W1oGWC?HXO4L0
zh-Z#^=BQ_$c;<;`o_gk~=N$2zBc5~AbB=l{#8V-j3iVW|XMuPYh-ZO%7N}>DcovCg
zk$M)X=REP8C!X`vbDnyt#8V}nD)m&U=K}FuAf5}<bAfs;63<2Axkx=1sb`6JmWXGG
zdX}hXnRu3oXPJ7Ispk^$Tq2%J)N_e?R)}YXcvh%qg?cU%&t>AdOg)#WXO(zXiD#91
zR;lL-@mwLEE7Ws^dae@BRpPlyJy)q`jd<3GXN`K+W}d3z>YX-R<ngNy{(lqhShmvA
zi?bZWWWZyJC*hkCfQ%n=@KC1H|KPu6IC|ro5(siUYynJz>C?La0=)Z}i3yI=V8%3@
z#2ncF64YMW-L>_^yA#ljgT`c#96u?{ON!I~d+Xn|>b*Z5ylDUB)9-)%?nFxH#zFJl
zi6rXALCeRJ_sWx2y@_%@J{DeMcrezO%%6{g;jmA^5#Pg}Kg(ekq8b+`>d#!m?k6Vi
zg=>Dd{<nYFw|>|Ew)D^b(qHxdBr|>r7lpVW;0c^jKQT0IW^<zlpRn-5S4+}<U>@Av
z>2zAdyUZL4UgH<Bd)Y@f@SEGFX}ICHhwy`212;+gT_d+?8e~Hm7d{F@PtBpZ2{M3~
zkrK|EEH-u1HhXn-C+V6G_A)-UyooY?<w>|Xd21aEJJRXo4t6LYDbBS=Kab<;xL@n^
z^quLH>9F*{p7SBofis-Z5>moc!;PXIZQ&GSF;GF6b86}K9%d(JB++@JU{kmB?tb0U
zyGGqPwasl8WD&<Pdu-|*&D^d#r=3B62(mH@#irgF?Dy+d*LYZW1k3}}>y~bA$DC_n
z-u@Gu;lC7)0V&Rh*nI)&$L+51kT(liKAya2uBRH3W!U}P#7K>wf{%~en^eyEb#dWM
z(tkXbVi%qdhdwUy_1QCkug{(d@OV-=e?5K-<HvGP^REwu!`Fu|1t|@O{^6MiaN$kX
z$4{m7{|5TSSPa+v_A1(ci~)WQ&O8AwJY}aG77X5Hbth>C8L$0c2}^IH9I8PM#bgX}
z;Q4{TWrEIVJ7H~E!>cFV*4Cn$wDfL$>x&ouv#)+r|MKYh7hiq(`O$OcL+;Qn<Rob`
z_}LK3Sms$<(_GPQ8$)nLbGEh-He~#{a7On;yBQ7300|H~w%G$`WG1h|#J0UZ0QDn$
zTV=nPhyi#$&I@i24hA;}pWu_@rzf812J?%qxvdFUDmWMW)S~fVuos(TUp*1vEiQ1Z
hT*vj*8df~`fR%)Euv~@c!jR&s5{&=q22RGy{{okj&^-VE

literal 0
HcmV?d00001

-- 
2.49.0


