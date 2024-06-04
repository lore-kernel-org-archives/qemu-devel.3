Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E533C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENwb-0005sc-QG; Tue, 04 Jun 2024 02:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvj-0004Xn-CK
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvc-0007cC-KU
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yQxTyCkViFqK9megWi2GDlafsm2LHU0mRoruP/ycIy0=;
 b=DqNehMoPnqpv3GLHhRaGrBuQSzpMphtfv5uLwiKVLkprnNPSRCUWR/NOZGQ2Eh75LZp9kB
 cIMohC90zGhP1pJHcx4u4T5CjiHX88AKsX0mnJucjYAKfNeqhar4MQ/smrGZc0jyNUGCsR
 /NtpggNB8Cq0LYU+OzFGntwj7LYa/qY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-o4gh8EWnPyeQJ7mmhh5pgA-1; Tue, 04 Jun 2024 02:45:50 -0400
X-MC-Unique: o4gh8EWnPyeQJ7mmhh5pgA-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52b84eb911dso3182086e87.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483548; x=1718088348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQxTyCkViFqK9megWi2GDlafsm2LHU0mRoruP/ycIy0=;
 b=rJWFvjpNqahnrgHR0jh8bSCn5dcqAEHaz9lww4QRwb4MSAwNmrI2H04kHyM01Uy2fs
 dqYy5jtzguU8RuKceo68+MoMJPid7OFrY2UgDX7EsKS1F4zgLZ6xgO+8EDOnKEK5fkYB
 tiXbe864wO4F55ZwiSBOpFcphhWbwTVrXJOsWbYr2J3tPARpTZtxzd1XBesMVaSxXPqc
 /J54j5KuIikxbkrctmGqJ+axq70ANaQL6VH4qqdisGvTV8YbyCqThEAslJVG5TLgb1cK
 FuRTjeQ65WonlcCc3z+5rI9Sa1jh91ntriMXgPbF6wFj8hHwM8YnrIg460SFE/LuHdjn
 fU4Q==
X-Gm-Message-State: AOJu0YxifrWkiFYqKh3k80l7Hr6+HCyi2vTd74tdMfgbC+HoqeAQ3YuI
 pMv9ZqWspF5gZXcRhqrFZj0ddbK1huX3HA/1VvNMdY6vq8Qr4sdAGDUfgmm+69zA+YAy+/lBlPp
 z+sdU+3XviTjjmgtrKxnIbkSKWgNsDdAA8821+v8cxlChFkpgz9Vf6xy3VH8IaFPjOuJQ5Cvawb
 T5SLz0nDEU8g9hyhr0LBYpr3qLrDruYB8+DsKH
X-Received: by 2002:a05:6512:7b:b0:52b:8843:b084 with SMTP id
 2adb3069b0e04-52b896bfa33mr7463253e87.47.1717483548385; 
 Mon, 03 Jun 2024 23:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM1Qtu3YZM5185bh8mBy+tZLZLHFna0aaQXvn57Y/jiYRFD+Wtr96dinCcWnjRKnxBtsdsIQ==
X-Received: by 2002:a05:6512:7b:b0:52b:8843:b084 with SMTP id
 2adb3069b0e04-52b896bfa33mr7463232e87.47.1717483547879; 
 Mon, 03 Jun 2024 23:45:47 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a31b99445sm6719543a12.18.2024.06.03.23.45.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 34/45] i386/sev: Add support for SNP CPUID validation
Date: Tue,  4 Jun 2024 08:43:58 +0200
Message-ID: <20240604064409.957105-35-pbonzini@redhat.com>
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

From: Michael Roth <michael.roth@amd.com>

SEV-SNP firmware allows a special guest page to be populated with a
table of guest CPUID values so that they can be validated through
firmware before being loaded into encrypted guest memory where they can
be used in place of hypervisor-provided values[1].

As part of SEV-SNP guest initialization, use this interface to validate
the CPUID entries reported by KVM_GET_CPUID2 prior to initial guest
start and populate the CPUID page reserved by OVMF with the resulting
encrypted data.

[1] SEV SNP Firmware ABI Specification, Rev. 0.8, 8.13.2.6

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-21-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 164 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 162 insertions(+), 2 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index c57534fca2b..06401f0526f 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -200,6 +200,36 @@ static const char *const sev_fw_errlist[] = {
 
 #define SEV_FW_MAX_ERROR      ARRAY_SIZE(sev_fw_errlist)
 
+/* <linux/kvm.h> doesn't expose this, so re-use the max from kvm.c */
+#define KVM_MAX_CPUID_ENTRIES 100
+
+typedef struct KvmCpuidInfo {
+    struct kvm_cpuid2 cpuid;
+    struct kvm_cpuid_entry2 entries[KVM_MAX_CPUID_ENTRIES];
+} KvmCpuidInfo;
+
+#define SNP_CPUID_FUNCTION_MAXCOUNT 64
+#define SNP_CPUID_FUNCTION_UNKNOWN 0xFFFFFFFF
+
+typedef struct {
+    uint32_t eax_in;
+    uint32_t ecx_in;
+    uint64_t xcr0_in;
+    uint64_t xss_in;
+    uint32_t eax;
+    uint32_t ebx;
+    uint32_t ecx;
+    uint32_t edx;
+    uint64_t reserved;
+} __attribute__((packed)) SnpCpuidFunc;
+
+typedef struct {
+    uint32_t count;
+    uint32_t reserved1;
+    uint64_t reserved2;
+    SnpCpuidFunc entries[SNP_CPUID_FUNCTION_MAXCOUNT];
+} __attribute__((packed)) SnpCpuidInfo;
+
 static int
 sev_ioctl(int fd, int cmd, void *data, int *error)
 {
@@ -788,6 +818,35 @@ out:
     return ret;
 }
 
+static void
+sev_snp_cpuid_report_mismatches(SnpCpuidInfo *old,
+                                SnpCpuidInfo *new)
+{
+    size_t i;
+
+    if (old->count != new->count) {
+        error_report("SEV-SNP: CPUID validation failed due to count mismatch,"
+                     "provided: %d, expected: %d", old->count, new->count);
+        return;
+    }
+
+    for (i = 0; i < old->count; i++) {
+        SnpCpuidFunc *old_func, *new_func;
+
+        old_func = &old->entries[i];
+        new_func = &new->entries[i];
+
+        if (memcmp(old_func, new_func, sizeof(SnpCpuidFunc))) {
+            error_report("SEV-SNP: CPUID validation failed for function 0x%x, index: 0x%x"
+                         "provided: eax:0x%08x, ebx: 0x%08x, ecx: 0x%08x, edx: 0x%08x"
+                         "expected: eax:0x%08x, ebx: 0x%08x, ecx: 0x%08x, edx: 0x%08x",
+                         old_func->eax_in, old_func->ecx_in,
+                         old_func->eax, old_func->ebx, old_func->ecx, old_func->edx,
+                         new_func->eax, new_func->ebx, new_func->ecx, new_func->edx);
+        }
+    }
+}
+
 static const char *
 snp_page_type_to_str(int type)
 {
@@ -806,6 +865,7 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
                       SevLaunchUpdateData *data)
 {
     int ret, fw_error;
+    SnpCpuidInfo snp_cpuid_info;
     struct kvm_sev_snp_launch_update update = {0};
 
     if (!data->hva || !data->len) {
@@ -815,6 +875,11 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
         return 1;
     }
 
+    if (data->type == KVM_SEV_SNP_PAGE_TYPE_CPUID) {
+        /* Save a copy for comparison in case the LAUNCH_UPDATE fails */
+        memcpy(&snp_cpuid_info, data->hva, sizeof(snp_cpuid_info));
+    }
+
     update.uaddr = (__u64)(unsigned long)data->hva;
     update.gfn_start = data->gpa >> TARGET_PAGE_BITS;
     update.len = data->len;
@@ -842,6 +907,11 @@ sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
         if (ret && ret != -EAGAIN) {
             error_report("SNP_LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
                          ret, fw_error, fw_error_to_str(fw_error));
+
+            if (data->type == KVM_SEV_SNP_PAGE_TYPE_CPUID) {
+                sev_snp_cpuid_report_mismatches(&snp_cpuid_info, data->hva);
+                error_report("SEV-SNP: failed update CPUID page");
+            }
             break;
         }
     }
@@ -1004,7 +1074,8 @@ sev_launch_finish(SevCommonState *sev_common)
 }
 
 static int
-snp_launch_update_data(uint64_t gpa, void *hva, uint32_t len, int type)
+snp_launch_update_data(uint64_t gpa, void *hva,
+                       uint32_t len, int type)
 {
     SevLaunchUpdateData *data;
 
@@ -1019,6 +1090,90 @@ snp_launch_update_data(uint64_t gpa, void *hva, uint32_t len, int type)
     return 0;
 }
 
+static int
+sev_snp_cpuid_info_fill(SnpCpuidInfo *snp_cpuid_info,
+                        const KvmCpuidInfo *kvm_cpuid_info)
+{
+    size_t i;
+
+    if (kvm_cpuid_info->cpuid.nent > SNP_CPUID_FUNCTION_MAXCOUNT) {
+        error_report("SEV-SNP: CPUID entry count (%d) exceeds max (%d)",
+                     kvm_cpuid_info->cpuid.nent, SNP_CPUID_FUNCTION_MAXCOUNT);
+        return -1;
+    }
+
+    memset(snp_cpuid_info, 0, sizeof(*snp_cpuid_info));
+
+    for (i = 0; i < kvm_cpuid_info->cpuid.nent; i++) {
+        const struct kvm_cpuid_entry2 *kvm_cpuid_entry;
+        SnpCpuidFunc *snp_cpuid_entry;
+
+        kvm_cpuid_entry = &kvm_cpuid_info->entries[i];
+        snp_cpuid_entry = &snp_cpuid_info->entries[i];
+
+        snp_cpuid_entry->eax_in = kvm_cpuid_entry->function;
+        if (kvm_cpuid_entry->flags == KVM_CPUID_FLAG_SIGNIFCANT_INDEX) {
+            snp_cpuid_entry->ecx_in = kvm_cpuid_entry->index;
+        }
+        snp_cpuid_entry->eax = kvm_cpuid_entry->eax;
+        snp_cpuid_entry->ebx = kvm_cpuid_entry->ebx;
+        snp_cpuid_entry->ecx = kvm_cpuid_entry->ecx;
+        snp_cpuid_entry->edx = kvm_cpuid_entry->edx;
+
+        /*
+         * Guest kernels will calculate EBX themselves using the 0xD
+         * subfunctions corresponding to the individual XSAVE areas, so only
+         * encode the base XSAVE size in the initial leaves, corresponding
+         * to the initial XCR0=1 state.
+         */
+        if (snp_cpuid_entry->eax_in == 0xD &&
+            (snp_cpuid_entry->ecx_in == 0x0 || snp_cpuid_entry->ecx_in == 0x1)) {
+            snp_cpuid_entry->ebx = 0x240;
+            snp_cpuid_entry->xcr0_in = 1;
+            snp_cpuid_entry->xss_in = 0;
+        }
+    }
+
+    snp_cpuid_info->count = i;
+
+    return 0;
+}
+
+static int
+snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, uint32_t cpuid_len)
+{
+    KvmCpuidInfo kvm_cpuid_info = {0};
+    SnpCpuidInfo snp_cpuid_info;
+    CPUState *cs = first_cpu;
+    int ret;
+    uint32_t i = 0;
+
+    assert(sizeof(snp_cpuid_info) <= cpuid_len);
+
+    /* get the cpuid list from KVM */
+    do {
+        kvm_cpuid_info.cpuid.nent = ++i;
+        ret = kvm_vcpu_ioctl(cs, KVM_GET_CPUID2, &kvm_cpuid_info);
+    } while (ret == -E2BIG);
+
+    if (ret) {
+        error_report("SEV-SNP: unable to query CPUID values for CPU: '%s'",
+                     strerror(-ret));
+        return 1;
+    }
+
+    ret = sev_snp_cpuid_info_fill(&snp_cpuid_info, &kvm_cpuid_info);
+    if (ret) {
+        error_report("SEV-SNP: failed to generate CPUID table information");
+        return 1;
+    }
+
+    memcpy(hva, &snp_cpuid_info, sizeof(snp_cpuid_info));
+
+    return snp_launch_update_data(cpuid_addr, hva, cpuid_len,
+                                  KVM_SEV_SNP_PAGE_TYPE_CPUID);
+}
+
 static int
 snp_metadata_desc_to_page_type(int desc_type)
 {
@@ -1053,7 +1208,12 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
             exit(1);
         }
 
-        ret = snp_launch_update_data(desc->base, hva, desc->len, type);
+        if (type == KVM_SEV_SNP_PAGE_TYPE_CPUID) {
+            ret = snp_launch_update_cpuid(desc->base, hva, desc->len);
+        } else {
+            ret = snp_launch_update_data(desc->base, hva, desc->len, type);
+        }
+
         if (ret) {
             error_report("%s: Failed to add metadata page gpa 0x%x+%x type %d",
                          __func__, desc->base, desc->len, desc->type);
-- 
2.45.1


