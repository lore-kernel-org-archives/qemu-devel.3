Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512CCD64070
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Swq-00046E-2H; Fri, 08 Nov 2024 12:39:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9Swp-00045y-4D
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:39:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9Swn-0007fU-Ip
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731087540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WlWrYmpsyykMxq9th+UoPeQpQpPsd/MHm4v4chl35/U=;
 b=IJ46+vg8NhabJ03RIqUoRj+5XOWfCSS3/6K7DEYZUVXiG5nZD1fQTF7wLg8GBHA7mqE6B/
 6R3fo/HSnexkmpReF5PNnkhwkedk4tc9+3p1ktOh9r2RyDMDxMElob3Jygn7Gk7xjUksfw
 cwvYpU9rFCd+10DzONGh4r9gHjpTxUA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-fyS9gj-dOTCIl269Gq-AJA-1; Fri, 08 Nov 2024 12:38:59 -0500
X-MC-Unique: fyS9gj-dOTCIl269Gq-AJA-1
X-Mimecast-MFC-AGG-ID: fyS9gj-dOTCIl269Gq-AJA
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d5a3afa84so1406148f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:38:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731087537; x=1731692337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WlWrYmpsyykMxq9th+UoPeQpQpPsd/MHm4v4chl35/U=;
 b=chhZaqN8h1NoaEICdRTZNm7oJ2DD9ZQwWDn18XhxwzuxZId69jLwPncNWJJAflzx0E
 pIjqPhPnPQeabuR2hfwcWBSGS/iUbwKMTz6W6lL/gaNkjP+Wz7fHFr4Av/HzL2x4kUTs
 vCK3ARYban6DEmyvVrg+KKLGxD1DrGYVVclCY+/iGdPjenQbq3uofvZos6npseXDYYaB
 54NTyIMlWU+4iGheRf8P/xkt73uNlHfJVZUN0s0WHRRVmy4bsXbq+X5r4+kFo+aasm8q
 VGtcu6XcD/b60VVnhLZRmJ1i7NbTNlObZO4yr/raTWBSYE0rJXCVTfj2emu2x95Xhw6V
 l6KQ==
X-Gm-Message-State: AOJu0Yxdb70aGVW0+DPEUkPJUGqHzM6syYRckJgVv+RrrKZlpSMf2U26
 9pUCS1sdCsXCEg3cU+6iY9aRs5wvcn0SgWGS9LLJOfze1jzVAhJMbdpKNnrOQhQn28sHGzEAaVH
 OIx7AXNpv3ueBceuIrf1NoRVJglQTNrq6wUmO9FmkknOeTxTfKGpw+7n0xB1fiVRwovlHukdAAE
 hLbv7a6aooiqe/HFosgzHgGAJI99xZEDtSVwJ5L6U=
X-Received: by 2002:a05:6000:4023:b0:37d:4c8f:2e1 with SMTP id
 ffacd0b85a97d-381f1867325mr3146506f8f.22.1731087536765; 
 Fri, 08 Nov 2024 09:38:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEx8CrCxzlxcJsOQLJoFo5ikdm+yDSZfYlCcpxVndLPdK1JWBMOTR+XdiTz8PJn0pyif0XQUQ==
X-Received: by 2002:a05:6000:4023:b0:37d:4c8f:2e1 with SMTP id
 ffacd0b85a97d-381f1867325mr3146487f8f.22.1731087536371; 
 Fri, 08 Nov 2024 09:38:56 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda0604bsm5460304f8f.105.2024.11.08.09.38.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 09:38:55 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	qemu-stable@nongnu.org
Subject: [PULL 13/13] hw/i386/pc: Don't try to init PCI NICs if there is no
 PCI bus
Date: Fri,  8 Nov 2024 18:38:28 +0100
Message-ID: <20241108173828.111454-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108173828.111454-1-pbonzini@redhat.com>
References: <20241108173828.111454-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

The 'isapc' machine type has no PCI bus, but pc_nic_init() still
calls pci_init_nic_devices() passing it a NULL bus pointer.  This
causes the clang sanitizer to complain:

$ ./build/clang/qemu-system-i386 -M isapc
../../hw/pci/pci.c:1866:39: runtime error: member access within null pointer of type 'PCIBus' (aka 'struct PCIBus')
SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../hw/pci/pci.c:1866:39 in

This is because pci_init_nic_devices() does
 &bus->qbus
which is undefined behaviour on a NULL pointer even though we're not
actually dereferencing the pointer. (We don't actually crash as
a result, so if you aren't running a sanitizer build then there
are no user-visible effects.)

Make pc_nic_init() avoid trying to initialize PCI NICs on a non-PCI
system.

Cc: qemu-stable@nongnu.org
Fixes: 8d39f9ba14d64 ("hw/i386/pc: use qemu_get_nic_info() and pci_init_nic_devices()")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20241105171813.3031969-1-peter.maydell@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 830614d9303..f9147fecbdc 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1252,7 +1252,9 @@ void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
     }
 
     /* Anything remaining should be a PCI NIC */
-    pci_init_nic_devices(pci_bus, mc->default_nic);
+    if (pci_bus) {
+        pci_init_nic_devices(pci_bus, mc->default_nic);
+    }
 
     rom_reset_order_override();
 }
-- 
2.47.0


