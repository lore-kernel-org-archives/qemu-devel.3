Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21183C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENwP-0005LE-RI; Tue, 04 Jun 2024 02:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvZ-0004Of-SG
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvW-0007bE-U5
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mbF+J+6p2qLufxqQCI+qOqAN8ivwoYU4rcfnA1GAKJY=;
 b=OL+msViBW3hIp1zhLNiZfkV9fxq4U1Uo14OYxUL5hsmiPeymrfX0lO98+AvwDxnemDr/t9
 QeOPBLLw1YGl52+jWDoTqQFAIHt2myKxOYB9NjkoDDczQuN59PbgSnlc5ZKaXAHM01AWLN
 y1l2yc27lM/nVOHmPtK5HEsNlluQnec=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-ZYcgEePTPWeE87E06gaZMg-1; Tue, 04 Jun 2024 02:45:45 -0400
X-MC-Unique: ZYcgEePTPWeE87E06gaZMg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57a32f2f782so333486a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483543; x=1718088343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mbF+J+6p2qLufxqQCI+qOqAN8ivwoYU4rcfnA1GAKJY=;
 b=w7OiZOKkaWccQdCc9pg04GKQSHbbL9E4O3LjRR8gUzc0WhuAsHwhD0TUsILATB4BgG
 Z/5XDkmv/P4AQmh9zb6TSxon5eCtgTpT03mDurx6lW1/6iOzXwXA8nY0tuys7ynvQH+3
 /4q3c9jyY+lEWHObzBbRvVcXgyi5HFVapKFLKReom0bXo1FjINzm6/sVjSmQMVDHcXRR
 M252A/nm3r90P8qqjucuGZ9oI7O9b6oUlGW+IwUEvADiqS28PMes8ClxCfxBTBUlJXfV
 B08LNpg+YYh1BM/sj/q1k6BVNenAwMXyERc0knz/zpTDcYs7EQh1p+NAelxZfJh+H3Px
 uNiQ==
X-Gm-Message-State: AOJu0Yzrkp0p7iviMmpWLeNsdBWpLe0WVe0RZS/s736rLz0KdUY8qyOz
 iAkSkL3jdYL6SZwfRcJ2z4aM99FMtRevOE1TE0jliX2b1q2dkSm6VbdP0fzWgAWisRTldwOPqEp
 qGy35XgDGLnjrxP2ey+OOt97Fgn+FZNs0+lP7qlYmCp+cFAXHeqpCFqy2/MujSuy4yvrAZ0nO9P
 vY9N+VTdAv7Pf71f1FCN597aB188hoUiJvOaVO
X-Received: by 2002:a50:8dc8:0:b0:57a:1c9:bf65 with SMTP id
 4fb4d7f45d1cf-57a36542c15mr6934237a12.31.1717483543295; 
 Mon, 03 Jun 2024 23:45:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEArvPLCgbo0ogTlcku11c7Vjhsf5DKhPgRzVJSeW4hFT/Z9n62uT911zOD3QRbjty18m+ytg==
X-Received: by 2002:a50:8dc8:0:b0:57a:1c9:bf65 with SMTP id
 4fb4d7f45d1cf-57a36542c15mr6934223a12.31.1717483542937; 
 Mon, 03 Jun 2024 23:45:42 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31c9cc44sm6835472a12.84.2024.06.03.23.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 32/45] hw/i386/sev: Add function to get SEV metadata from OVMF
 header
Date: Tue,  4 Jun 2024 08:43:56 +0200
Message-ID: <20240604064409.957105-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Brijesh Singh <brijesh.singh@amd.com>

A recent version of OVMF expanded the reset vector GUID list to add
SEV-specific metadata GUID. The SEV metadata describes the reserved
memory regions such as the secrets and CPUID page used during the SEV-SNP
guest launch.

The pc_system_get_ovmf_sev_metadata_ptr() is used to retieve the SEV
metadata pointer from the OVMF GUID list.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-19-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/pc.h          | 26 ++++++++++++++++++++++++++
 target/i386/sev.h             |  2 ++
 hw/i386/pc_sysfw.c            |  4 ++++
 target/i386/sev-sysemu-stub.c |  4 ++++
 target/i386/sev.c             | 32 ++++++++++++++++++++++++++++++++
 5 files changed, 68 insertions(+)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ad9c3d9ba84..c653b8eeb24 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -164,6 +164,32 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 #define PCI_HOST_ABOVE_4G_MEM_SIZE     "above-4g-mem-size"
 #define PCI_HOST_PROP_SMM_RANGES       "smm-ranges"
 
+typedef enum {
+    SEV_DESC_TYPE_UNDEF,
+    /* The section contains the region that must be validated by the VMM. */
+    SEV_DESC_TYPE_SNP_SEC_MEM,
+    /* The section contains the SNP secrets page */
+    SEV_DESC_TYPE_SNP_SECRETS,
+    /* The section contains address that can be used as a CPUID page */
+    SEV_DESC_TYPE_CPUID,
+
+} ovmf_sev_metadata_desc_type;
+
+typedef struct __attribute__((__packed__)) OvmfSevMetadataDesc {
+    uint32_t base;
+    uint32_t len;
+    ovmf_sev_metadata_desc_type type;
+} OvmfSevMetadataDesc;
+
+typedef struct __attribute__((__packed__)) OvmfSevMetadata {
+    uint8_t signature[4];
+    uint32_t len;
+    uint32_t version;
+    uint32_t num_desc;
+    OvmfSevMetadataDesc descs[];
+} OvmfSevMetadata;
+
+OvmfSevMetadata *pc_system_get_ovmf_sev_metadata_ptr(void);
 
 void pc_pci_as_mapping_init(MemoryRegion *system_memory,
                             MemoryRegion *pci_address_space);
diff --git a/target/i386/sev.h b/target/i386/sev.h
index 5dc4767b1e9..cc12824dd65 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -66,4 +66,6 @@ int sev_inject_launch_secret(const char *hdr, const char *secret,
 int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size);
 void sev_es_set_reset_vector(CPUState *cpu);
 
+void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size);
+
 #endif
diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index ac88ad4eb91..9b8671c4412 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -260,6 +260,10 @@ void x86_firmware_configure(void *ptr, int size)
     pc_system_parse_ovmf_flash(ptr, size);
 
     if (sev_enabled()) {
+
+        /* Copy the SEV metadata table (if it exists) */
+        pc_system_parse_sev_metadata(ptr, size);
+
         ret = sev_es_save_reset_vector(ptr, size);
         if (ret) {
             error_report("failed to locate and/or save reset vector");
diff --git a/target/i386/sev-sysemu-stub.c b/target/i386/sev-sysemu-stub.c
index 96e1c15cc3f..fc1c57c4113 100644
--- a/target/i386/sev-sysemu-stub.c
+++ b/target/i386/sev-sysemu-stub.c
@@ -67,3 +67,7 @@ void hmp_info_sev(Monitor *mon, const QDict *qdict)
 {
     monitor_printf(mon, "SEV is not available in this QEMU\n");
 }
+
+void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size)
+{
+}
diff --git a/target/i386/sev.c b/target/i386/sev.c
index e84e4395a53..17281bb2c74 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -597,6 +597,38 @@ SevCapability *qmp_query_sev_capabilities(Error **errp)
     return sev_get_capabilities(errp);
 }
 
+static OvmfSevMetadata *ovmf_sev_metadata_table;
+
+#define OVMF_SEV_META_DATA_GUID "dc886566-984a-4798-A75e-5585a7bf67cc"
+typedef struct __attribute__((__packed__)) OvmfSevMetadataOffset {
+    uint32_t offset;
+} OvmfSevMetadataOffset;
+
+OvmfSevMetadata *pc_system_get_ovmf_sev_metadata_ptr(void)
+{
+    return ovmf_sev_metadata_table;
+}
+
+void pc_system_parse_sev_metadata(uint8_t *flash_ptr, size_t flash_size)
+{
+    OvmfSevMetadata     *metadata;
+    OvmfSevMetadataOffset  *data;
+
+    if (!pc_system_ovmf_table_find(OVMF_SEV_META_DATA_GUID, (uint8_t **)&data,
+                                   NULL)) {
+        return;
+    }
+
+    metadata = (OvmfSevMetadata *)(flash_ptr + flash_size - data->offset);
+    if (memcmp(metadata->signature, "ASEV", 4) != 0 ||
+        metadata->len < sizeof(OvmfSevMetadata) ||
+        metadata->len > flash_size - data->offset) {
+        return;
+    }
+
+    ovmf_sev_metadata_table = g_memdup2(metadata, metadata->len);
+}
+
 static SevAttestationReport *sev_get_attestation_report(const char *mnonce,
                                                         Error **errp)
 {
-- 
2.45.1


