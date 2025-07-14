Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAD6C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 11:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubHEa-000860-T5; Mon, 14 Jul 2025 07:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGza-0000ql-Oo
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ubGzW-0001ez-FG
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 07:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752491101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vaxjfdU0vDkaLBJ9OuBIEHWzWgK9r6h25+trEjoxvo4=;
 b=hZ9ajpD41Rt/odmehK18IcSU1ICpfVrwjWLLdxczPOoZ9AtlPuRVkeLXkFRKDJ6KPamLke
 DCF2PcTCQdPLcOuHxGtCrHw4aTz1K7Xk2wcbD/DKcQvN6wdcTJRMSaUZQbkRsM+WBH980L
 DcIf7UR4f22HJHxsOIxZhQ+9+wMgHp0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-cqzZkWjXNO6mK7yVp0XmlA-1; Mon, 14 Jul 2025 07:05:00 -0400
X-MC-Unique: cqzZkWjXNO6mK7yVp0XmlA-1
X-Mimecast-MFC-AGG-ID: cqzZkWjXNO6mK7yVp0XmlA_1752491099
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450df53d461so32605905e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 04:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752491098; x=1753095898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vaxjfdU0vDkaLBJ9OuBIEHWzWgK9r6h25+trEjoxvo4=;
 b=hS37TD/kYKyrj5hsBLdJqyfmoJ8Vnjx80JborogUGgrzB4QLV+LEq9qDsG3Wqz4bU9
 m0tVuCF74ioHefswPALNWyfixXzno0AsKoXgEjLGcmAXrhREhxq/eorjGYUMVTIWwqEu
 ltrta+qXaGJo5/fTvzK3UD1I+P/En5p0iWIWyYl30upnaoWuRMMvnEEV/oH05U8fP1l9
 YWOWcUXb+EmvoP1QbC76/1EZz0kLmywQGDkZ8e3e+/frduaKgGyNcWFtOsGyauDgyvnc
 C/efx+AU3SNd84g9DPJ/gV5olwf29i7KzoDHtNsZMBbhYjS+GHrAxmpNOyh4YH7WQNaw
 dSZw==
X-Gm-Message-State: AOJu0YzTSjVsAXTlm3S6b4+bhkOhjOSLpNUgR3okQPzPwKZrEWEakcG6
 1lXtAUwZswivWyk45WvqSGXKL94l+wEetwcwBW4FC38pqm5Aascs75ZfPDosCQSkVcrr2JO0r98
 AgRSgghTsUbeqj4niNqyg7Ww907zZ7pq5FXqYBe8qaWZphQ5a+2SIeci0rE0cm47MQV/skNZlk9
 Gr4i5PzupvFzr52kTvTxfakTSxcGYpVIUOe1LMWxPR
X-Gm-Gg: ASbGnctWSp4vcQrP5JfiSmlKtAT8XbAJ0G2AOl5q9CzrJHgoalKzo5oXdllvS2khZCn
 Jp9Ji52oHaoFa4R4Hf8dLLhsc+F6XiAC8zSZ2kAQHQcmwblNOUrSOojaXHEfw3gpytAEAI6lF8g
 I/Ap5e4wtkKJi1G3LnWlgUgr85+1oZLbOS4zvc5p9vBK6NSIGTfmYfg+95MiEbBx7VBVuKV4mQd
 MiBQnVsjSpO7t4wTfeh4Dgp3rvqcCXjGXesypY0GRgLZBr4BIHlbqL4EOydXFfPbiSd7hOV1fpM
 Uyd44ZU4C9e9qP57bJH95n75RKIuCJPAeWMBgYmGFR8=
X-Received: by 2002:a05:600c:1d87:b0:456:2a9:f815 with SMTP id
 5b1f17b1804b1-45602a9fbfcmr69093865e9.4.1752491097963; 
 Mon, 14 Jul 2025 04:04:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsdtCFXik9rtPHoSWaaPmdB8Evf8QfR5Gw6/TJBxfzBk3sMbt3M9UBxP6v6fadb4B5RCpEoA==
X-Received: by 2002:a05:600c:1d87:b0:456:2a9:f815 with SMTP id
 5b1f17b1804b1-45602a9fbfcmr69093575e9.4.1752491097369; 
 Mon, 14 Jul 2025 04:04:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.73.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e14e82sm12162020f8f.71.2025.07.14.04.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 04:04:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 18/77] backends/confidential-guest-support: Add functions to
 support IGVM
Date: Mon, 14 Jul 2025 13:03:07 +0200
Message-ID: <20250714110406.117772-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714110406.117772-1-pbonzini@redhat.com>
References: <20250714110406.117772-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

From: Roy Hopkins <roy.hopkins@randomman.co.uk>

In preparation for supporting the processing of IGVM files to configure
guests, this adds a set of functions to ConfidentialGuestSupport
allowing configuration of secure virtual machines that can be
implemented for each supported isolation platform type such as Intel TDX
or AMD SEV-SNP. These functions will be called by IGVM processing code
in subsequent patches.

This commit provides a default implementation of the functions that
either perform no action or generate an error when they are called.
Targets that support ConfidentalGuestSupport should override these
implementations.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Gerd Hoffman <kraxel@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/23e34a106da87427899f93178102e4a6ef50c966.1751554099.git.roy.hopkins@randomman.co.uk
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/confidential-guest-support.h | 67 +++++++++++++++++++++
 backends/confidential-guest-support.c       | 31 ++++++++++
 2 files changed, 98 insertions(+)

diff --git a/include/system/confidential-guest-support.h b/include/system/confidential-guest-support.h
index ea46b50c56c..79ecd21f42f 100644
--- a/include/system/confidential-guest-support.h
+++ b/include/system/confidential-guest-support.h
@@ -19,6 +19,7 @@
 #define QEMU_CONFIDENTIAL_GUEST_SUPPORT_H
 
 #include "qom/object.h"
+#include "exec/hwaddr.h"
 
 #define TYPE_CONFIDENTIAL_GUEST_SUPPORT "confidential-guest-support"
 OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
@@ -26,6 +27,36 @@ OBJECT_DECLARE_TYPE(ConfidentialGuestSupport,
                     CONFIDENTIAL_GUEST_SUPPORT)
 
 
+typedef enum ConfidentialGuestPlatformType {
+    CGS_PLATFORM_SEV,
+    CGS_PLATFORM_SEV_ES,
+    CGS_PLATFORM_SEV_SNP,
+} ConfidentialGuestPlatformType;
+
+typedef enum ConfidentialGuestMemoryType {
+    CGS_MEM_RAM,
+    CGS_MEM_RESERVED,
+    CGS_MEM_ACPI,
+    CGS_MEM_NVS,
+    CGS_MEM_UNUSABLE,
+} ConfidentialGuestMemoryType;
+
+typedef struct ConfidentialGuestMemoryMapEntry {
+    uint64_t gpa;
+    uint64_t size;
+    ConfidentialGuestMemoryType type;
+} ConfidentialGuestMemoryMapEntry;
+
+typedef enum ConfidentialGuestPageType {
+    CGS_PAGE_TYPE_NORMAL,
+    CGS_PAGE_TYPE_VMSA,
+    CGS_PAGE_TYPE_ZERO,
+    CGS_PAGE_TYPE_UNMEASURED,
+    CGS_PAGE_TYPE_SECRETS,
+    CGS_PAGE_TYPE_CPUID,
+    CGS_PAGE_TYPE_REQUIRED_MEMORY,
+} ConfidentialGuestPageType;
+
 struct ConfidentialGuestSupport {
     Object parent;
 
@@ -64,6 +95,42 @@ typedef struct ConfidentialGuestSupportClass {
 
     int (*kvm_init)(ConfidentialGuestSupport *cgs, Error **errp);
     int (*kvm_reset)(ConfidentialGuestSupport *cgs, Error **errp);
+
+    /*
+     * Check to see if this confidential guest supports a particular
+     * platform or configuration.
+     *
+     * Return true if supported or false if not supported.
+     */
+    bool (*check_support)(ConfidentialGuestPlatformType platform,
+                         uint16_t platform_version, uint8_t highest_vtl,
+                         uint64_t shared_gpa_boundary);
+
+    /*
+     * Configure part of the state of a guest for a particular set of data, page
+     * type and gpa. This can be used for example to pre-populate and measure
+     * guest memory contents, define private ranges or set the initial CPU state
+     * for one or more CPUs.
+     *
+     * If memory_type is CGS_PAGE_TYPE_VMSA then ptr points to the initial CPU
+     * context for a virtual CPU. The format of the data depends on the type of
+     * confidential virtual machine. For example, for SEV-ES ptr will point to a
+     * vmcb_save_area structure that should be copied into guest memory at the
+     * address specified in gpa. The cpu_index parameter contains the index of
+     * the CPU the VMSA applies to.
+     */
+    int (*set_guest_state)(hwaddr gpa, uint8_t *ptr, uint64_t len,
+                           ConfidentialGuestPageType memory_type,
+                           uint16_t cpu_index, Error **errp);
+
+    /*
+     * Iterate the system memory map, getting the entry with the given index
+     * that can be populated into guest memory.
+     *
+     * Returns 0 for ok, 1 if the index is out of range and -1 on error.
+     */
+    int (*get_mem_map_entry)(int index, ConfidentialGuestMemoryMapEntry *entry,
+                             Error **errp);
 } ConfidentialGuestSupportClass;
 
 static inline int confidential_guest_kvm_init(ConfidentialGuestSupport *cgs,
diff --git a/backends/confidential-guest-support.c b/backends/confidential-guest-support.c
index 8ff7bfa8570..c5bef1fbfa8 100644
--- a/backends/confidential-guest-support.c
+++ b/backends/confidential-guest-support.c
@@ -14,15 +14,46 @@
 #include "qemu/osdep.h"
 
 #include "system/confidential-guest-support.h"
+#include "qapi/error.h"
 
 OBJECT_DEFINE_ABSTRACT_TYPE(ConfidentialGuestSupport,
                             confidential_guest_support,
                             CONFIDENTIAL_GUEST_SUPPORT,
                             OBJECT)
 
+static bool check_support(ConfidentialGuestPlatformType platform,
+                         uint16_t platform_version, uint8_t highest_vtl,
+                         uint64_t shared_gpa_boundary)
+{
+    /* Default: no support. */
+    return false;
+}
+
+static int set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
+                           ConfidentialGuestPageType memory_type,
+                           uint16_t cpu_index, Error **errp)
+{
+    error_setg(errp,
+               "Setting confidential guest state is not supported for this platform");
+    return -1;
+}
+
+static int get_mem_map_entry(int index, ConfidentialGuestMemoryMapEntry *entry,
+                             Error **errp)
+{
+    error_setg(
+        errp,
+        "Obtaining the confidential guest memory map is not supported for this platform");
+    return -1;
+}
+
 static void confidential_guest_support_class_init(ObjectClass *oc,
                                                   const void *data)
 {
+    ConfidentialGuestSupportClass *cgsc = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
+    cgsc->check_support = check_support;
+    cgsc->set_guest_state = set_guest_state;
+    cgsc->get_mem_map_entry = get_mem_map_entry;
 }
 
 static void confidential_guest_support_init(Object *obj)
-- 
2.50.0


