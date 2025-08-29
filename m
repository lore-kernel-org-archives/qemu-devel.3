Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A6B8CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNGq-0007bc-Bz; Sat, 30 Aug 2025 11:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryij-0001HU-QN
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryic-0008Rz-Hb
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472436;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IKwTKCGMs/5s/PqIcZfPRIUzTnq5pzaUCRSQnzg/mYU=;
 b=F2ibKxXNILW3v9b9IuaHgtj2Y13bBVQzcTABLAASE1lKx/q7vtyBcPnOiWLcPTFa+TOtNg
 ntpQAtdFiDJUVrTAlZQaYFUAl99mZoYBx4Dpy0g3bxli/oDBpquVUyd8sDuJRLKiI/Af3s
 N1xcMZtXHoyO2wTXj3PF1FE03YE/fn4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-tOlf3thhNFqBTqpnrDMjog-1; Fri, 29 Aug 2025 09:00:33 -0400
X-MC-Unique: tOlf3thhNFqBTqpnrDMjog-1
X-Mimecast-MFC-AGG-ID: tOlf3thhNFqBTqpnrDMjog_1756472433
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b7265febdso13907045e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472432; x=1757077232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IKwTKCGMs/5s/PqIcZfPRIUzTnq5pzaUCRSQnzg/mYU=;
 b=rvUv7Hkzdq/yxSqmbDAwS1PcTPg+FLFsH9qDPqfbv/1z0Pc3Po7hWh3EUhP7pF5s7e
 xANqPjL8mhf/YanyUMtVl2fDNXBt3oXJWNAxyF3Tnk5Sadg/yVBVjt60VM8hlS40Ajr8
 WhZQf7RSpKqEam/75hqbhbWYymImVBNUsSIoEqbZSmVjbqUSve2968kgc56dTLRsIkrU
 y298Zmt4yjHCaolkKfN5JUihma0jAXHw6Zfzu0h122Ci5jjYvCgOmrbfOO5iKER4A9qM
 45FDj4WNgr/9eJrzTBoY/oYuyXLGgeoUaKpXms1QAAirEyfROyIC7f36XHZYKzIi82Rs
 v8vQ==
X-Gm-Message-State: AOJu0YyoDR5pQbOEPA8Y09pXerMSEzYeLfHnQB4p1yDldeEmf9Zfy5dh
 jrdoQxnh+XJyCIcMyJRKgdlIbVC72vGhovJYs/BrgifOus4KNPXOix3XnML+JCpvSKhaCqiztV1
 Gj/OlZPUxjivuXrUGbwOTsR7YXrilgQs5mcRZBI0+/Yl15FbYVf+CWutXH1I5S0OOBmmheavaq3
 OxriahvMsXnE7rLcK2HjDcaa0lLVjny4uG1Bx3WpC/
X-Gm-Gg: ASbGnctoeO4pYcLm5DXotmXz/o8NNlI7ttjO+TpqVsy4WqSYW1a+kda4OwA2Fq5TZrU
 iPGHY+pCtH+Wl2wvJ23LhIPsFTi1yF7LqeBq542Bn2RexOv70SyjtmgCBSkVV6DdldJe9LvoAeg
 WTGUDdJhoKEwpcfqiHe3PQK06YCqlzHu3zSYLTo4L3y75l0IUDXGBK7DkIMQm8wPM2r6+NV/IQa
 7tDN1pw+Y/1lBHrzt3HIpdTg1ipyPmJf0U8UmBy+VXiXutmgDyCTL3AJNaaLPx7qdQlXpCVLWjN
 isnITHgzwm/vAoCuneGdShjbFvw2L7+jMq4iaAzBrEoovRvFFDfyqbcJWFnxsh1QHy5WDyJw6Br
 B1jCuBeKSf6VnWGfQLX81VyI16kIneAEU4IxDVqtaMQo=
X-Received: by 2002:a05:600d:19:b0:459:d3e2:d743 with SMTP id
 5b1f17b1804b1-45b6870de14mr114964525e9.8.1756472432152; 
 Fri, 29 Aug 2025 06:00:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrbXIp/z6ozUS8UyytZ6B0s4SBc/e5GYxtgTLoi9+RrNq9uEW2dfcycZUO4I4Dr9ozcu2Ajw==
X-Received: by 2002:a05:600d:19:b0:459:d3e2:d743 with SMTP id
 5b1f17b1804b1-45b6870de14mr114964295e9.8.1756472431734; 
 Fri, 29 Aug 2025 06:00:31 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d0f85c287fsm1535930f8f.52.2025.08.29.06.00.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:00:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 18/28] hw/i386/pc_piix.c: replace rom_memory with pci_memory
Date: Fri, 29 Aug 2025 14:59:25 +0200
Message-ID: <20250829125935.1526984-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Now that we can guarantee the i440fx-pc machine will always have a PCI bus, any
instances of rom_memory can be replaced by pci_memory and rom_memory removed
completely.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250828111057.468712-19-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 627de09c704..7e78b6daa6d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -113,7 +113,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     GSIState *gsi_state;
     MemoryRegion *ram_memory;
     MemoryRegion *pci_memory = NULL;
-    MemoryRegion *rom_memory = system_memory;
     ram_addr_t lowmem;
     uint64_t hole64_size = 0;
     PCIDevice *pci_dev;
@@ -193,7 +192,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     pci_memory = g_new(MemoryRegion, 1);
     memory_region_init(pci_memory, NULL, "pci", UINT64_MAX);
-    rom_memory = pci_memory;
 
     phb = OBJECT(qdev_new(TYPE_I440FX_PCI_HOST_BRIDGE));
     object_property_add_child(OBJECT(machine), "i440fx", phb);
@@ -224,7 +222,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
 
     /* allocate ram and load rom/bios */
     if (!xen_enabled()) {
-        pc_memory_init(pcms, system_memory, rom_memory, hole64_size);
+        pc_memory_init(pcms, system_memory, pci_memory, hole64_size);
     } else {
         assert(machine->ram_size == x86ms->below_4g_mem_size +
                                     x86ms->above_4g_mem_size);
-- 
2.51.0


