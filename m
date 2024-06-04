Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B567C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENx5-00087v-GL; Tue, 04 Jun 2024 02:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvb-0004Ph-Oi
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvZ-0007bm-M6
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdzc0pnme++SQh28YLBWqEPjMSsoA3eLg+edwlgf8UI=;
 b=B7LfIYJi3qCRH+Sl1YTCE9oVr2jtGEWWuQaNrIPwjtPPL0TORaiZvwNfmxFhZk4UGGkZSR
 X70PxuwQ3ZIAjXLuww/gbVWpYgaSQ2PG7OQugQX9gYR4vmPvF+hXq5sd1+HHVrex7rUAYw
 H8sKjip8UAJ1GODYt7tQlmOPvKKHg/g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-xF_kAWUjNOWGLnfo3jo6ZA-1; Tue, 04 Jun 2024 02:45:47 -0400
X-MC-Unique: xF_kAWUjNOWGLnfo3jo6ZA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6840dde124so353644566b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483546; x=1718088346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fdzc0pnme++SQh28YLBWqEPjMSsoA3eLg+edwlgf8UI=;
 b=MX/fwvcm6zProuk7HNkSg+DRa+6ak1Xt+v8jZk8vNvgtm/sIrRCEgb0uVt9nZPp6eM
 9RXIwiaC+gAE9Lc/LxvUc6mnMJ1dtrVoD0ctz2WhorAUwCxEcpBYZVk8LP+27zcYJnZL
 a3jbEf+hCLobSTiQcq6mkohLqFvJn18E2VOrGwEf3LuYqW5IDGYnNbRzvdziXluK5+dn
 ICYDdgNxqTTq1bFGxVJZnsD5pi+UOCc/0X/VrHV7JWcP5Ys16m4VB+T1xYwwYytZiWPa
 kY+DhY8GgyecdP17Ir6vwDMayxPg4ewp724KiApWwyz+2zmGrw08S0Q652wRLoD562fO
 pbZg==
X-Gm-Message-State: AOJu0Ywi8VCiraPuyMkS9nS2AUalIGzr4hLZAacNYsQ/8JV+fKg0q7GQ
 hk70wN9Zf4p7VIa392OOOZYVNEYLoz4fC29YhYTNpNSLK1W7ARk94Ub2Yqf6yHmwbZj/pjQEvI3
 qQ9APRsl5wpDlHINVrjjWy/Kyho02WAoEOxWpQXqejG9xhUL7Iy+aKMZDlMeYlERnMzWdfCDHMZ
 x8IaKTZmb3w78h4xEtGA40CSDgrm4iJxwzVTD3
X-Received: by 2002:a17:907:36c:b0:a65:2b64:f84a with SMTP id
 a640c23a62f3a-a69546b0a23mr122950866b.25.1717483545787; 
 Mon, 03 Jun 2024 23:45:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMJL2vePRvJXiQ9VNn+qDYdfNVtvBaD9K2HF91LoWdjkGZvpP0r6NfVIDWy6i4WX5QSltPaQ==
X-Received: by 2002:a17:907:36c:b0:a65:2b64:f84a with SMTP id
 a640c23a62f3a-a69546b0a23mr122949166b.25.1717483545352; 
 Mon, 03 Jun 2024 23:45:45 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a681c4f2b6fsm576670566b.144.2024.06.03.23.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 33/45] i386/sev: Add support for populating OVMF metadata pages
Date: Tue,  4 Jun 2024 08:43:57 +0200
Message-ID: <20240604064409.957105-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

OVMF reserves various pages so they can be pre-initialized/validated
prior to launching the guest. Add support for populating these pages
with the expected content.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Co-developed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-20-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 17281bb2c74..c57534fca2b 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1003,15 +1003,89 @@ sev_launch_finish(SevCommonState *sev_common)
     migrate_add_blocker(&sev_mig_blocker, &error_fatal);
 }
 
+static int
+snp_launch_update_data(uint64_t gpa, void *hva, uint32_t len, int type)
+{
+    SevLaunchUpdateData *data;
+
+    data = g_new0(SevLaunchUpdateData, 1);
+    data->gpa = gpa;
+    data->hva = hva;
+    data->len = len;
+    data->type = type;
+
+    QTAILQ_INSERT_TAIL(&launch_update, data, next);
+
+    return 0;
+}
+
+static int
+snp_metadata_desc_to_page_type(int desc_type)
+{
+    switch (desc_type) {
+    /* Add the umeasured prevalidated pages as a zero page */
+    case SEV_DESC_TYPE_SNP_SEC_MEM: return KVM_SEV_SNP_PAGE_TYPE_ZERO;
+    case SEV_DESC_TYPE_SNP_SECRETS: return KVM_SEV_SNP_PAGE_TYPE_SECRETS;
+    case SEV_DESC_TYPE_CPUID: return KVM_SEV_SNP_PAGE_TYPE_CPUID;
+    default:
+         return KVM_SEV_SNP_PAGE_TYPE_ZERO;
+    }
+}
+
+static void
+snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
+                            OvmfSevMetadata *metadata)
+{
+    OvmfSevMetadataDesc *desc;
+    int type, ret, i;
+    void *hva;
+    MemoryRegion *mr = NULL;
+
+    for (i = 0; i < metadata->num_desc; i++) {
+        desc = &metadata->descs[i];
+
+        type = snp_metadata_desc_to_page_type(desc->type);
+
+        hva = gpa2hva(&mr, desc->base, desc->len, NULL);
+        if (!hva) {
+            error_report("%s: Failed to get HVA for GPA 0x%x sz 0x%x",
+                         __func__, desc->base, desc->len);
+            exit(1);
+        }
+
+        ret = snp_launch_update_data(desc->base, hva, desc->len, type);
+        if (ret) {
+            error_report("%s: Failed to add metadata page gpa 0x%x+%x type %d",
+                         __func__, desc->base, desc->len, desc->type);
+            exit(1);
+        }
+    }
+}
+
 static void
 sev_snp_launch_finish(SevCommonState *sev_common)
 {
     int ret, error;
     Error *local_err = NULL;
+    OvmfSevMetadata *metadata;
     SevLaunchUpdateData *data;
     SevSnpGuestState *sev_snp = SEV_SNP_GUEST(sev_common);
     struct kvm_sev_snp_launch_finish *finish = &sev_snp->kvm_finish_conf;
 
+    /*
+     * To boot the SNP guest, the hypervisor is required to populate the CPUID
+     * and Secrets page before finalizing the launch flow. The location of
+     * the secrets and CPUID page is available through the OVMF metadata GUID.
+     */
+    metadata = pc_system_get_ovmf_sev_metadata_ptr();
+    if (metadata == NULL) {
+        error_report("%s: Failed to locate SEV metadata header", __func__);
+        exit(1);
+    }
+
+    /* Populate all the metadata pages */
+    snp_populate_metadata_pages(sev_snp, metadata);
+
     QTAILQ_FOREACH(data, &launch_update, next) {
         ret = sev_snp_launch_update(sev_snp, data);
         if (ret) {
-- 
2.45.1


