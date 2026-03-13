Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E64E107BCCF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 17:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15v9-0005is-SP; Fri, 13 Mar 2026 13:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69b43f90.v1-ed71907461274294b9ba13ad43a5e4b1@bounce.vates.tech>)
 id 1w15v3-0005i5-SD
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 13:03:26 -0400
Received: from mail179-36.suw41.mandrillapp.com ([198.2.179.36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69b43f90.v1-ed71907461274294b9ba13ad43a5e4b1@bounce.vates.tech>)
 id 1w15uz-0000hK-NG
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 13:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1773420432; x=1773690432;
 bh=DC1CKIcFBppLbjt/OuTdGZjS7i/aioQOlGzfj9vAJWw=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=k0ku2VIwGEqAExijDTrZ9hMU+1/XDFglQ3JZw9qL0IHjYV1uIdTst9VmNVUV60qLb
 AFOzH7WTNXgiNLyrQ/ic5nW4f23NFEiBkHfu95pynk24AUHI9NOPw7yJ/+z8jbnPLs
 YJksnZcE7ZlQno6P7MRbTRgYdPP8PkkXlmDNlkeGEgdir98yJlmgXRf5ayGOsiPXDB
 BIujej5YzxWqGg+muz5zhbKBTK+iSIKOSsK8Qe2FiFE5naAC8znscZRmfYa4VLDZbv
 O1W+9VBd5I2GH+qAkKPBnx+43p3lEWMPhdKbrOempUQY8dQY8oIG72CYBbDf/gLnTT
 acAJFsyLLttBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1773420432; x=1773680932; i=thierry.escande@vates.tech;
 bh=DC1CKIcFBppLbjt/OuTdGZjS7i/aioQOlGzfj9vAJWw=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=YYiIzZWBwRFt9nQVfeIo3jEFJTcILCpxtyKehmzwiy23zLD+qLAtF6lFf7FrVprBf
 w9bHX0A/g7sThOj+e6yxdQaDHEVfCjYzXuWrX+U33SV5kPDsKPS7YEvqo3MWyaQjkV
 NqZHPwTdwwRu96eHi9VDl3tNvmJnqgYDYuW0RFiM9gDM6RA6PoU6XjTc6UShiiccyx
 tBPKVb5qHSCk2qwnDpfmZ6K/iE6QARvc/ZdbkzaCN/PluZeb5LdUFlsWqnMpBx3/1E
 Ul0mwyhZpZHUIzL4mPPMSisZbfkbU0OQR1JHN9FHDPweIBEOhakUiptEHwPf1EhSgL
 aKWt1y9d/Ejuw==
Received: from pmta12.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail179-36.suw41.mandrillapp.com (Mailchimp) with ESMTP id 4fXVl41Gjbzlfk15
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 16:47:12 +0000 (GMT)
From: "Thierry Escande" <thierry.escande@vates.tech>
Subject: =?utf-8?Q?[PATCH=202/4]=20q35/xen:=20Add=20Xen=20support=20for=20Q35?=
Received: from [37.26.189.201] by mandrillapp.com id
 ed71907461274294b9ba13ad43a5e4b1; Fri, 13 Mar 2026 16:47:12 +0000
X-Mailer: git-send-email 2.51.0
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1773420431033
To: qemu-devel@nongnu.org
Cc: "Thierry Escande" <thierry.escande@vates.tech>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Eduardo Habkost" <eduardo@habkost.net>,
 "Anthony PERARD" <anthony@xenproject.org>, xen-devel@lists.xenproject.org
Message-Id: <20260313164649.794591-3-thierry.escande@vates.tech>
In-Reply-To: <20260313164649.794591-1-thierry.escande@vates.tech>
References: <20260313164649.794591-1-thierry.escande@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.ed71907461274294b9ba13ad43a5e4b1?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20260313:md
Date: Fri, 13 Mar 2026 16:47:12 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.179.36;
 envelope-from=bounce-md_30504962.69b43f90.v1-ed71907461274294b9ba13ad43a5e4b1@bounce.vates.tech;
 helo=mail179-36.suw41.mandrillapp.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patch intializes HVM pc machine in pc_q35_init() if Xen support is
enabled.

As done for i440 machine, this also cleanups unrealized flash devices.
See commit dd29b5c30c (xen: cleanup unrealized flash devices).

Signed-off-by: Thierry Escande <thierry.escande@vates.tech>
---
 hw/i386/pc_q35.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index cb23322f5a..89dd736d95 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -35,8 +35,10 @@
 #include "hw/core/loader.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/rtc/mc146818rtc.h"
+#include "hw/xen/xen-x86.h"
 #include "system/tcg.h"
 #include "system/kvm.h"
+#include "system/xen.h"
 #include "hw/i386/kvm/clock.h"
 #include "hw/pci-host/q35.h"
 #include "hw/pci/pcie_port.h"
@@ -190,6 +192,10 @@ static void pc_q35_init(MachineState *machine)
         x86ms->below_4g_mem_size = machine->ram_size;
     }
 
+    if (xen_enabled()) {
+        xen_hvm_init_pc(pcms, &machine->ram);
+    }
+
     pc_machine_init_sgx_epc(pcms);
     x86_cpus_init(x86ms, pcmc->default_cpu_version);
 
@@ -206,7 +212,11 @@ static void pc_q35_init(MachineState *machine)
 
     /* allocate ram and load rom/bios */
     memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-    pc_memory_init(pcms, system_memory, pci_memory, pci_hole64_size);
+    if (!xen_enabled()) {
+        pc_memory_init(pcms, system_memory, pci_memory, pci_hole64_size);
+    } else {
+        pc_system_flash_cleanup_unused(pcms);
+    }
 
     object_property_add_child(OBJECT(machine), "q35", phb);
     object_property_set_link(phb, PCI_HOST_PROP_RAM_MEM,
-- 
2.51.0



--
Thierry Escande | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


