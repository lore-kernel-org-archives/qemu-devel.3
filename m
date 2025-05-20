Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AE2C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKn6-0006q9-18; Tue, 20 May 2025 07:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKn4-0006n4-KC
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKn2-00030R-II
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AhJISerm2MBOLD8G5i0s1NB8oNLkNhlk+u12xLmgWOk=;
 b=REtI3QqS5YLG/G8QVUHeK9d/soUdX/JsM/VOnrx2pAriV6ulEKbz1oM62jgqmjtYs4zcQv
 Bk30Jh42dm9mKAr6DtudlD80itKUDxRtpMEVbkjqMaSg2TZhoc3AgKIABq3KBiUHWEFPJg
 tX5zff2orpJeXL1KY19I7zA77AesIJk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-Zpd-C4tYMwaLe_bNx7qIgw-1; Tue, 20 May 2025 07:05:42 -0400
X-MC-Unique: Zpd-C4tYMwaLe_bNx7qIgw-1
X-Mimecast-MFC-AGG-ID: Zpd-C4tYMwaLe_bNx7qIgw_1747739141
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-acb8f9f58ebso439016666b.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739140; x=1748343940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AhJISerm2MBOLD8G5i0s1NB8oNLkNhlk+u12xLmgWOk=;
 b=sp5Ghb/xdYVQZndcN9bEZdfaLqSYdxNrLwqYWw1SryZkHd3OnmGmVZ4IwFCqcFbb0W
 sPHQwxj3gsNCYCltdhEv97P+Po7tlgmb4atCEsPCbOgT/dUYjRROdjfc2xONtXmkHsxT
 Lnolr70ZY5SoKI20ijVBezMYyckkrKJgyvJnzseYZUURIYcn/0BN4QZPCbEjKWcFcGoJ
 4g6etuWHZaq7YzBn6CdBUJd42qsj60W0HcgML78vEXdaWOFbk4aGTeEU0nuwkFAISnW3
 EZKgAffNFpY/3XH5Ti0Uq9chpi6+P9PsJaT4d25accO6KqRfHEXLnHJbdzlAG3uR2bfO
 LZGg==
X-Gm-Message-State: AOJu0YxfLpyS59kajFAuf0fZebSvbm0ZlpTDHnWq7MeUR0OWiQy2xHuB
 4pHjU5uoURR/1rogDveT34SRA1BycNWkwWdjporGJVRi8TkAfta210x3iHRHiHIDQ3GYtBOmbRw
 IlCd+MtU2mSqJoUULylVebe2VAfXv0WbPubMcl9ngIBsgTWTZRfAfUfvE+pp/v5Oka1q+ISfq2z
 eqE3BCGTW87TSa5EBwHecgrw9WuDISZ90wEjvssjRE
X-Gm-Gg: ASbGnct8gKvjXPnMlnAnF5iIcQsLORvUcrYs+I28Az6xQIhqL7H7emg8Uqa8wzQ9feu
 wJabzfaVOQIdHbsVDFpSWiLoXTfyIw7zXjb8+1HDA7du/NpDtNGFOY+5vlux6QRSTZk0E0wjpgy
 UPC8dDyZqgphrlPCmd2rZcqGlg5OiNMrr4X4pUXzetiKmxLhMe0CsMd3AJ3Da2JdarYu45+z72d
 MKIOpsZtgsp902gt/xpUGjAN04m8K5YEVQC0M7wBrGl6x8zEIC23/axyc9BgGPtKiewkeiZA0Q+
 EffHLqV+Y8AYQw==
X-Received: by 2002:a17:907:72d6:b0:ad5:840b:77f0 with SMTP id
 a640c23a62f3a-ad5840b78ccmr371512966b.31.1747739140012; 
 Tue, 20 May 2025 04:05:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvOq5jBynVcxyzdMHlBpyjPtJBpmrihIbS0/LNuXNHfep5N3yGps/aHXD358UGFF/teytWIg==
X-Received: by 2002:a17:907:72d6:b0:ad5:840b:77f0 with SMTP id
 a640c23a62f3a-ad5840b78ccmr371508866b.31.1747739139433; 
 Tue, 20 May 2025 04:05:39 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d04b08bsm721623366b.13.2025.05.20.04.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:05:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Rakesh Jeyasingh <rakeshjb010@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 04/35] hw/pci-host: Remove unused pci_host_data_be_ops
Date: Tue, 20 May 2025 13:04:59 +0200
Message-ID: <20250520110530.366202-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Rakesh Jeyasingh <rakeshjb010@gmail.com>

pci_host_data_be_ops became unused after endianness fixes

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/r/20250429170354.150581-3-rakeshjb010@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/pci-host/dino.h | 4 ----
 include/hw/pci/pci_host.h  | 1 -
 hw/pci/pci_host.c          | 6 ------
 3 files changed, 11 deletions(-)

diff --git a/include/hw/pci-host/dino.h b/include/hw/pci-host/dino.h
index fd7975c7984..5dc8cdf6108 100644
--- a/include/hw/pci-host/dino.h
+++ b/include/hw/pci-host/dino.h
@@ -109,10 +109,6 @@ static const uint32_t reg800_keep_bits[DINO800_REGS] = {
 struct DinoState {
     PCIHostState parent_obj;
 
-    /*
-     * PCI_CONFIG_ADDR is parent_obj.config_reg, via pci_host_conf_be_ops,
-     * so that we can map PCI_CONFIG_DATA to pci_host_data_be_ops.
-     */
     uint32_t config_reg_dino; /* keep original copy, including 2 lowest bits */
 
     uint32_t iar0;
diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index e52d8ec2cdc..954dd446fa4 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -68,6 +68,5 @@ uint32_t pci_data_read(PCIBus *s, uint32_t addr, unsigned len);
 extern const MemoryRegionOps pci_host_conf_le_ops;
 extern const MemoryRegionOps pci_host_conf_be_ops;
 extern const MemoryRegionOps pci_host_data_le_ops;
-extern const MemoryRegionOps pci_host_data_be_ops;
 
 #endif /* PCI_HOST_H */
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index abe83bbab89..7179d99178b 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -217,12 +217,6 @@ const MemoryRegionOps pci_host_data_le_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-const MemoryRegionOps pci_host_data_be_ops = {
-    .read = pci_host_data_read,
-    .write = pci_host_data_write,
-    .endianness = DEVICE_BIG_ENDIAN,
-};
-
 static bool pci_host_needed(void *opaque)
 {
     PCIHostState *s = opaque;
-- 
2.49.0


