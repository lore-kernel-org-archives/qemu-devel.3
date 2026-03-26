Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B7A10A62EC
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 14:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5m0y-000141-Eg; Thu, 26 Mar 2026 10:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1w5m0w-00013h-J7
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:48:50 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1w5m0s-0004Nm-JM
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 10:48:49 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1A44E3F624
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1774536522;
 bh=9i07kbNbRKin4ccuX+XEktSQNxeOB3pk6a7DyZCJi1A=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Jr48gHQqmJvnad76ABLEH9cUpBsFe//vzd9KE4o8QyxwHBe5rS65S7QrCRXHoT7FY
 42OK7olCrwy4kbYyMSwyTlKnjdebztwReQ+Sji4We0bE98/9sdPcBeSHqwhnqkwqD4
 p4iCi0Y+VCAQd2XnGg1lnbrgvu+dB5z9kCOdLWlNPivW8CK7bWFe1xP+vzWSOcQIkJ
 9Sk5UsHjk3lj27+GldvbPmxZIzR5yaonVDze5vJD/FS9bg9I3Qt0ZgHuI5hlQdVqZ+
 oZ2sP22zKPuQEWjyrXZYVXG6gn/X57arOOTRAmDFB/mkp/rvLNqoeSpX01uf2MdlfV
 +nYE+gQdCllSz1azHLe3zI+3SKpoP3+VXvbG+k2nq3ZEw4w4AoZfIuQBexjeRS6Vxj
 G2MmrxPoROsvPP10MRe13z4GdZ+gxj/Ai/PHs3Pz+SC+nDgMAsihDLfmyArLdSmtgp
 IthuPn3MvyMvQf93OQ19H/jy77NcJ5FCwkJkwe4GtmvIm3ABZGIl8cvq7vp6XXlbtR
 tCyiuRpkF65ABEiBXCC2SJ7UTpAtYTeNU0jE0RRhXab5oHiao+4QoRyuFBp/uOM5RY
 YYuyjyAJUOBmkEhyJ8xcIzMRXvy9gTc0wTRM63FpO3JQfpZ74t/f9o9nEnXZxrtGge
 NCyMYvwLwZfrq/Q2IVilZG08=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48722073bd2so5333595e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 07:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774536522; x=1775141322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9i07kbNbRKin4ccuX+XEktSQNxeOB3pk6a7DyZCJi1A=;
 b=XSAHIZeXAgji49dmAuc1c6JZQs86c9qzTU4ddv8xkXGcsfZkNBx2d8SU1peMNjENms
 g8WE9OVT5yLc1z/04MOdGfU55UsUUMEUwM0NhJzunbwXtjGKGd7URE4l3Nt+8ovE6pMa
 +pkaWQeGDjQh+OL3SLtdueEx/lBPXx8CH9quiUFmlSS9twIhdP0Wc6Vk2XhDXXJGFM3K
 XVJQmQsPBLLCzIhm8a9dRqsGjxDjsvYU2HT/4jXXCiQgbGKUgrqWlx/b3vgV0XDCTEzO
 eV8tNV5xLLSvgpn/HHOE3bmcJgUcuISrm3IGD3Prq5/YBdxv9MUgnPN5+8fSdcNXqXo/
 zd0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4cna1f2N1KK0deO3Id4dnSv93YC4wFEVY1KsnmuffK4HHXolC6Ew7f/Aea7JXDx27iw18DsyAlDK/@nongnu.org
X-Gm-Message-State: AOJu0Yx/Qk9L8/LXIYN18gy69B4xeVt+QjHNID4Gs4T6jRsRMdy1BgUs
 jnIqO4qL0dj0pvQruoVBQ03NuC+X0te1f4m5IreOPzLst/RXxoLED6ZnwxHEw2MXWXH98cyfrLX
 HysqFxdSay0u2vatringlZl7isnWNu/e3np2mauuymm7oVQanuL74BMzsQkK/zsyn6qvaL1jm
X-Gm-Gg: ATEYQzypG1bHDnst0aABSgwZSaLW5swcqSOcCqIw9wg5cGxn9wp/ywyJMouD7DGMFdj
 xMAaLg0QHXOMfhyq6pfxPGiTa3ZHyVJvhO5A1BmyOBOaUpH0M5qr7k2GU7Wuh9p3qjbATfFJY1I
 eP5UBNe1+GZcsopc/xZsc52hgfK6VvBcvo00torTw8dnglKmwUBh3/S01oA6hlnUp81Aoa1y8yU
 H/DsAiAL4OUNVEBR6W5hbFUI/byQS/nCSUosPfO5Zz/IwVAWB214rcTljcJEhflSQcBn01lsVvw
 Whj1DvQKxsqpGUpmK9IwOA7kbfs1O0njCd1Gvx0Dv/xbXlXAjd9V/Tb09ZW/j5WrLwDdm3uhZwp
 q6eYuR5UHSOM4hcajo21Q4pKZFBhawToQ+6DqVwvCDTLSOFL8wLjrS98eKgBUBZ7dU7sZxozguO
 tSCxz5U/3z6hKHlS/wBZ29/ul/CE8pMxphSValF2nPMEUG
X-Received: by 2002:a05:600c:358f:b0:486:fcc7:6811 with SMTP id
 5b1f17b1804b1-48722be4497mr37234525e9.10.1774536521600; 
 Thu, 26 Mar 2026 07:48:41 -0700 (PDT)
X-Received: by 2002:a05:600c:358f:b0:486:fcc7:6811 with SMTP id
 5b1f17b1804b1-48722be4497mr37234135e9.10.1774536521066; 
 Thu, 26 Mar 2026 07:48:41 -0700 (PDT)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b9192e533sm9845107f8f.2.2026.03.26.07.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 07:48:40 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2] hw/acpi: correct field sequence in SPCR table
Date: Thu, 26 Mar 2026 15:48:35 +0100
Message-ID: <20260326144835.67911-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_TRY_3LD=1.999 autolearn=ham autolearn_force=no
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

On LoongArch and RISC-V invalid SPCR tables are created:

Terrminal Type : 00
Language : 03

The correct values are:

Terrminal Type : 03
Language : 00

This is due to commit 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate
SPCR creation to common location") that swapped the fields.

See the specification of the table in
https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/serial-port-console-redirection-table

This page shows version 1.10. But the sequence of the fields was not changed
since version 1.0.

Our LoongArch and ARM code uses version 1.07 of the specification.
Our RISC-V code uses version 1.10 of the specification.

Fixes: 7dd0b070fa09 ("hw/arm/virt-acpi-build.c: Migrate SPCR creation to common location")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Origin: https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
Bug-Ubuntu: https://bugs.launchpad.net/ubuntu/+source/qemu/+bug/2146419
---
v2:
	Mention the different specification versions used by our code.
v1:
	https://lore.kernel.org/qemu-devel/20260326121947.51200-1-heinrich.schuchardt@canonical.com/T/#u
---
 hw/acpi/aml-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 4b37405088..a999320e61 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2115,10 +2115,10 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
     build_append_int_noprefix(table_data, f->stop_bits, 1);
     /* Flow Control */
     build_append_int_noprefix(table_data, f->flow_control, 1);
-    /* Language */
-    build_append_int_noprefix(table_data, f->language, 1);
     /* Terminal Type */
     build_append_int_noprefix(table_data, f->terminal_type, 1);
+    /* Language */
+    build_append_int_noprefix(table_data, f->language, 1);
     /* PCI Device ID  */
     build_append_int_noprefix(table_data, f->pci_device_id, 2);
     /* PCI Vendor ID */
-- 
2.53.0


