Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5F2C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 14:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfH3-0001CE-Cl; Fri, 21 Jun 2024 10:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sKfH0-0001Ac-S3
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:29:55 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sKfGy-0005gE-QN
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:29:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9EAA61FB82;
 Fri, 21 Jun 2024 14:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1718980191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1T+OYuIFZEIYf+KDlnxJ7EzdpiZS5G5Az45HeXIogtg=;
 b=g7/Aj1kgAnd88pr/QfflrOyDby0nxz4SgisK0frcUodk2KzdDM6kazLWtVu5i7dlYStrbb
 nbXJjCl56S9wOnHpOYdnuIh1Kzw8Lj8rGyLF3Q9lfG2wTh4Dem+COb+gMNR1poDVGM809d
 vPbGnYFbFh/XbpgCurQdzLxSjkWliRE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1718980191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1T+OYuIFZEIYf+KDlnxJ7EzdpiZS5G5Az45HeXIogtg=;
 b=g7/Aj1kgAnd88pr/QfflrOyDby0nxz4SgisK0frcUodk2KzdDM6kazLWtVu5i7dlYStrbb
 nbXJjCl56S9wOnHpOYdnuIh1Kzw8Lj8rGyLF3Q9lfG2wTh4Dem+COb+gMNR1poDVGM809d
 vPbGnYFbFh/XbpgCurQdzLxSjkWliRE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2A2413ACD;
 Fri, 21 Jun 2024 14:29:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4JhRNV6OdWbwKQAAD6G6ig
 (envelope-from <roy.hopkins@suse.com>); Fri, 21 Jun 2024 14:29:50 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH v3 06/15] sev: Update launch_update_data functions to use
 Error handling
Date: Fri, 21 Jun 2024 15:29:09 +0100
Message-ID: <cac4ababee3bfed7658a501d5d5810379ac90512.1718979106.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718979106.git.roy.hopkins@suse.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
 RCPT_COUNT_TWELVE(0.00)[19]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 FROM_HAS_DN(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 R_RATELIMIT(0.00)[to_ip_from(RLm8d31jk6dhzwhww9bgqrb1jt)];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The class function and implementations for updating launch data return
a code in case of error. In some cases an error message is generated and
in other cases, just the error return value is used.

This small refactor adds an 'Error **errp' parameter to all functions
which consistently set an error condition if a non-zero value is
returned.

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
---
 target/i386/sev.c | 67 +++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 30b83f1d77..1900c3d9b4 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -121,7 +121,8 @@ struct SevCommonStateClass {
                                        Error **errp);
     int (*launch_start)(SevCommonState *sev_common);
     void (*launch_finish)(SevCommonState *sev_common);
-    int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa, uint8_t *ptr, uint64_t len);
+    int (*launch_update_data)(SevCommonState *sev_common, hwaddr gpa,
+                              uint8_t *ptr, uint64_t len, Error **errp);
     int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
 };
 
@@ -942,14 +943,17 @@ out:
     return ret;
 }
 
-static int
-sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa, uint8_t *addr, uint64_t len)
+static int sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
+                                  uint8_t *addr, uint64_t len, Error **errp)
 {
     int ret, fw_error;
     struct kvm_sev_launch_update_data update;
 
     if (!addr || !len) {
-        return 1;
+        error_setg(errp,
+                   "%s: Invalid parameters provided for updating launch data.",
+                   __func__);
+        return -1;
     }
 
     update.uaddr = (uintptr_t)addr;
@@ -958,8 +962,8 @@ sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa, uint8_t *addr, ui
     ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
                     &update, &fw_error);
     if (ret) {
-        error_report("%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
-                __func__, ret, fw_error, fw_error_to_str(fw_error));
+        error_setg(errp, "%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'", __func__,
+                   ret, fw_error, fw_error_to_str(fw_error));
     }
 
     return ret;
@@ -1087,9 +1091,8 @@ sev_launch_finish(SevCommonState *sev_common)
     migrate_add_blocker(&sev_mig_blocker, &error_fatal);
 }
 
-static int
-snp_launch_update_data(uint64_t gpa, void *hva,
-                       uint32_t len, int type)
+static int snp_launch_update_data(uint64_t gpa, void *hva, uint32_t len,
+                                  int type, Error **errp)
 {
     SevLaunchUpdateData *data;
 
@@ -1104,13 +1107,12 @@ snp_launch_update_data(uint64_t gpa, void *hva,
     return 0;
 }
 
-static int
-sev_snp_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
-                           uint8_t *ptr, uint64_t len)
+static int sev_snp_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
+                                      uint8_t *ptr, uint64_t len, Error **errp)
 {
-       int ret = snp_launch_update_data(gpa, ptr, len,
-                                         KVM_SEV_SNP_PAGE_TYPE_NORMAL);
-       return ret;
+    int ret = snp_launch_update_data(gpa, ptr, len,
+                                     KVM_SEV_SNP_PAGE_TYPE_NORMAL, errp);
+    return ret;
 }
 
 static int
@@ -1162,8 +1164,8 @@ sev_snp_cpuid_info_fill(SnpCpuidInfo *snp_cpuid_info,
     return 0;
 }
 
-static int
-snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, uint32_t cpuid_len)
+static int snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva,
+                                   uint32_t cpuid_len, Error **errp)
 {
     KvmCpuidInfo kvm_cpuid_info = {0};
     SnpCpuidInfo snp_cpuid_info;
@@ -1180,26 +1182,26 @@ snp_launch_update_cpuid(uint32_t cpuid_addr, void *hva, uint32_t cpuid_len)
     } while (ret == -E2BIG);
 
     if (ret) {
-        error_report("SEV-SNP: unable to query CPUID values for CPU: '%s'",
-                     strerror(-ret));
-        return 1;
+        error_setg(errp, "SEV-SNP: unable to query CPUID values for CPU: '%s'",
+                   strerror(-ret));
+        return -1;
     }
 
     ret = sev_snp_cpuid_info_fill(&snp_cpuid_info, &kvm_cpuid_info);
     if (ret) {
-        error_report("SEV-SNP: failed to generate CPUID table information");
-        return 1;
+        error_setg(errp, "SEV-SNP: failed to generate CPUID table information");
+        return -1;
     }
 
     memcpy(hva, &snp_cpuid_info, sizeof(snp_cpuid_info));
 
     return snp_launch_update_data(cpuid_addr, hva, cpuid_len,
-                                  KVM_SEV_SNP_PAGE_TYPE_CPUID);
+                                  KVM_SEV_SNP_PAGE_TYPE_CPUID, errp);
 }
 
-static int
-snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp, uint32_t addr,
-                                void *hva, uint32_t len)
+static int snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp,
+                                           uint32_t addr, void *hva,
+                                           uint32_t len, Error **errp)
 {
     int type = KVM_SEV_SNP_PAGE_TYPE_ZERO;
     if (sev_snp->parent_obj.kernel_hashes) {
@@ -1211,7 +1213,7 @@ snp_launch_update_kernel_hashes(SevSnpGuestState *sev_snp, uint32_t addr,
                sizeof(*sev_snp->kernel_hashes_data));
         type = KVM_SEV_SNP_PAGE_TYPE_NORMAL;
     }
-    return snp_launch_update_data(addr, hva, len, type);
+    return snp_launch_update_data(addr, hva, len, type, errp);
 }
 
 static int
@@ -1249,12 +1251,14 @@ snp_populate_metadata_pages(SevSnpGuestState *sev_snp,
         }
 
         if (type == KVM_SEV_SNP_PAGE_TYPE_CPUID) {
-            ret = snp_launch_update_cpuid(desc->base, hva, desc->len);
+            ret = snp_launch_update_cpuid(desc->base, hva, desc->len,
+                                          &error_fatal);
         } else if (desc->type == SEV_DESC_TYPE_SNP_KERNEL_HASHES) {
             ret = snp_launch_update_kernel_hashes(sev_snp, desc->base, hva,
-                                                  desc->len);
+                                                  desc->len, &error_fatal);
         } else {
-            ret = snp_launch_update_data(desc->base, hva, desc->len, type);
+            ret = snp_launch_update_data(desc->base, hva, desc->len, type,
+                                         &error_fatal);
         }
 
         if (ret) {
@@ -1541,9 +1545,8 @@ sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp)
     if (sev_check_state(sev_common, SEV_STATE_LAUNCH_UPDATE)) {
         int ret;
 
-        ret = klass->launch_update_data(sev_common, gpa, ptr, len);
+        ret = klass->launch_update_data(sev_common, gpa, ptr, len, errp);
         if (ret < 0) {
-            error_setg(errp, "SEV: Failed to encrypt pflash rom");
             return ret;
         }
     }
-- 
2.43.0


