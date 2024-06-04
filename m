Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DCCC27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENww-0007y3-6q; Tue, 04 Jun 2024 02:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvb-0004Pg-OP
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENvZ-0007bo-MJ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0CNITmejgwIObTGjnEo5dtWm4cNO8mpBT6GYtJujk54=;
 b=LET9G+ujPUgdRZWcFGmvHSGUllwf1JVZ3OHYNh+ACkBG8nHOT2t981T1mIFbRiezh8c7ne
 FhDhWnu725BOF3lUKvpvOec0yq90QVobYV5ooMELP8fL1fWmtiaEgX3SvQpPpyccCgAhZq
 RTg1hWhXd8ytaChlu+uuDOMt587QIpQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-VeoDzl3bNGKUMOrwjjxLEw-1; Tue, 04 Jun 2024 02:45:37 -0400
X-MC-Unique: VeoDzl3bNGKUMOrwjjxLEw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a68afe5b95dso149731166b.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483535; x=1718088335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0CNITmejgwIObTGjnEo5dtWm4cNO8mpBT6GYtJujk54=;
 b=LQ7cc9l8EgbuwLmIrXA5jchWxGCUzeG1N6lRVImhECXQPANi36TAICkG5kPRrmbVsP
 2LAjdn3sAdl9ZPguJpl9NFlOlklvX5ZrUGQxYqOdTfe+iFSkQCKBBw+mGeb3Y1HdCMgV
 1Ufmoys01O2xUkf4QjZ3Kc6Yk8a5X1wHxy3NgSyy5wryqgk22R1tROIdASq0I0rjEbEJ
 +A/0eF1J8GwfOg+pHAQZxxnEVjZmVQD8hxc61zWS9oE5w97t0+CVL/DGrRa+wkuJWQq+
 I3yrZhhzUlta6KBrWolKSb+ewq70fWHjKsNhwNqWd5fnps6CGNFWIRVIeccwI7ST6ka+
 WBTg==
X-Gm-Message-State: AOJu0YxMplxunF6Xr9/3ihZ59alTvsgMWfA++zu8QDKvOSuOJOrXWoQm
 Pq4V1e4HYOPBmHm0FAS/23ZR2voToUx1z5oXtJnlWEFQFsF6tbPcUS7CVm755V8+XPRvJ5c9tt3
 O/nRiDjYDAldl6v3YwMIHdf7i0t6R5kcbAsJqipvfZxQOD/Ar2HNik3wQBQTf+aXWoquoUMdPHy
 0kA72iypzLEldqEuE83o0yk3JdZAq/++OmNxxw
X-Received: by 2002:a17:906:bcd8:b0:a68:f493:4b58 with SMTP id
 a640c23a62f3a-a68f4934d07mr372397066b.40.1717483535461; 
 Mon, 03 Jun 2024 23:45:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsVfzFUIWzr3mcAZ+Xl0ZX5chBrGi/Uk7gmxbKAp37T3VGOZBeaWTJPtCYaLV1wq8crFEWYw==
X-Received: by 2002:a17:906:bcd8:b0:a68:f493:4b58 with SMTP id
 a640c23a62f3a-a68f4934d07mr372395866b.40.1717483535076; 
 Mon, 03 Jun 2024 23:45:35 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68e6b5cdf8sm363755066b.81.2024.06.03.23.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>,
 Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 29/45] i386/sev: Add the SNP launch start context
Date: Tue,  4 Jun 2024 08:43:53 +0200
Message-ID: <20240604064409.957105-30-pbonzini@redhat.com>
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

The SNP_LAUNCH_START is called first to create a cryptographic launch
context within the firmware.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Co-developed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-16-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c        | 39 +++++++++++++++++++++++++++++++++++++++
 target/i386/trace-events |  1 +
 2 files changed, 40 insertions(+)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 43d1c48bd9e..e89b87d2f55 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -39,6 +39,7 @@
 #include "confidential-guest.h"
 #include "hw/i386/pc.h"
 #include "exec/address-spaces.h"
+#include "qemu/queue.h"
 
 OBJECT_DECLARE_TYPE(SevCommonState, SevCommonStateClass, SEV_COMMON)
 OBJECT_DECLARE_TYPE(SevGuestState, SevCommonStateClass, SEV_GUEST)
@@ -115,6 +116,16 @@ struct SevSnpGuestState {
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
 #define DEFAULT_SEV_SNP_POLICY  0x30000
 
+typedef struct SevLaunchUpdateData {
+    QTAILQ_ENTRY(SevLaunchUpdateData) next;
+    hwaddr gpa;
+    void *hva;
+    uint64_t len;
+    int type;
+} SevLaunchUpdateData;
+
+static QTAILQ_HEAD(, SevLaunchUpdateData) launch_update;
+
 #define SEV_INFO_BLOCK_GUID     "00f771de-1a7e-4fcb-890e-68c77e2fb44e"
 typedef struct __attribute__((__packed__)) SevInfoBlock {
     /* SEV-ES Reset Vector Address */
@@ -674,6 +685,31 @@ sev_read_file_base64(const char *filename, guchar **data, gsize *len)
     return 0;
 }
 
+static int
+sev_snp_launch_start(SevCommonState *sev_common)
+{
+    int fw_error, rc;
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(sev_common);
+    struct kvm_sev_snp_launch_start *start = &sev_snp_guest->kvm_start_conf;
+
+    trace_kvm_sev_snp_launch_start(start->policy,
+                                   sev_snp_guest->guest_visible_workarounds);
+
+    rc = sev_ioctl(sev_common->sev_fd, KVM_SEV_SNP_LAUNCH_START,
+                   start, &fw_error);
+    if (rc < 0) {
+        error_report("%s: SNP_LAUNCH_START ret=%d fw_error=%d '%s'",
+                __func__, rc, fw_error, fw_error_to_str(fw_error));
+        return 1;
+    }
+
+    QTAILQ_INIT(&launch_update);
+
+    sev_set_guest_state(sev_common, SEV_STATE_LAUNCH_UPDATE);
+
+    return 0;
+}
+
 static int
 sev_launch_start(SevCommonState *sev_common)
 {
@@ -1003,6 +1039,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     }
 
     ret = klass->launch_start(sev_common);
+
     if (ret) {
         error_setg(errp, "%s: failed to create encryption context", __func__);
         return -1;
@@ -1794,9 +1831,11 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data)
     SevCommonStateClass *klass = SEV_COMMON_CLASS(oc);
     X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
 
+    klass->launch_start = sev_snp_launch_start;
     klass->kvm_init = sev_snp_kvm_init;
     x86_klass->kvm_type = sev_snp_kvm_type;
 
+
     object_class_property_add(oc, "policy", "uint64",
                               sev_snp_guest_get_policy,
                               sev_snp_guest_set_policy, NULL, NULL);
diff --git a/target/i386/trace-events b/target/i386/trace-events
index 2cd8726eebb..cb26d8a9257 100644
--- a/target/i386/trace-events
+++ b/target/i386/trace-events
@@ -11,3 +11,4 @@ kvm_sev_launch_measurement(const char *value) "data %s"
 kvm_sev_launch_finish(void) ""
 kvm_sev_launch_secret(uint64_t hpa, uint64_t hva, uint64_t secret, int len) "hpa 0x%" PRIx64 " hva 0x%" PRIx64 " data 0x%" PRIx64 " len %d"
 kvm_sev_attestation_report(const char *mnonce, const char *data) "mnonce %s data %s"
+kvm_sev_snp_launch_start(uint64_t policy, char *gosvw) "policy 0x%" PRIx64 " gosvw %s"
-- 
2.45.1


