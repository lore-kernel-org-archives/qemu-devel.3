Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 056FDC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtwQ-0001XP-Aq; Fri, 30 May 2025 03:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwG-0001NL-3z
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwE-0006v7-2x
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UmlnASzT6uLp8Nbxl99fMI929DWjn8v4QS2tMXfKp4U=;
 b=CDKjcz2yaTxyftUkkSRg1NSJgVL4O2BvrVqPvODYLPiaBAV+YM1bKZT/ugddZRiaEpCUBE
 Sj6V7LAwzV/Piq2+XjX/UXC7oNVA3SFxbXdwq6nMVruq4C9H/qaXEbB7wSL6OE1D0XjBkL
 6R4xuo/kG9AHvjEnRvCpLZatgDp9nes=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-KudR8q1NONWShev_0Jq2HQ-1; Fri, 30 May 2025 03:13:55 -0400
X-MC-Unique: KudR8q1NONWShev_0Jq2HQ-1
X-Mimecast-MFC-AGG-ID: KudR8q1NONWShev_0Jq2HQ_1748589234
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ad212166df4so130926666b.0
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589233; x=1749194033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UmlnASzT6uLp8Nbxl99fMI929DWjn8v4QS2tMXfKp4U=;
 b=G8o9L9YqmNjJFv8ZeMfXMZjUaRZkW2lb9H+7Xk6h3DDVs4TudYm3SdAnwP8eLFuYzq
 9HO0seTyj+u64gxUcVPQzXnUuV6sN28k7vwQ5DO5B47R9ABsPjgV6KVhDPbi4OwEckvF
 z70fVX0rBFhQzpVg3oNM2F+4Ui7d4QYGqxhILzKrz81U9lnQAhmiThpwHMZ7jY3Z1fKS
 hF5HjKJHaRz/XYq+4leUmmMVw8L87qnGBOirtbv7eLBHVoS5YH6/HNv7qTVBjbZT0k5q
 lWV8SstFLB0YV7Bic3G4NDkluCtRUPfVTq0c0lZ50JILIjdwoTIFF7oSd9plq1g/Odvq
 evDA==
X-Gm-Message-State: AOJu0Yw8SdnT2ahnNzi2GCpDviZASuGYH7j7Ucpy/IqkyFmmmcr4AC2/
 LaGYn1KEzsf1SytUSxJOrS/lbh2jrRL0pli2kv8BYjBUUAZiZVcy6LRHXQPWxEkLHE83S7SD4Rd
 TgtDFkqx5ZNfK9XUjN0LCmaZ517SZ6EhcINwSb/Dwps+O307nBqCxhtQ63V1zjVmqr20QHurJos
 hRxMM/uLsVXF8rpA4nh40N66kgL9h8c1Iq428eXc76
X-Gm-Gg: ASbGncuQacpxhw4NT/KBbhX4WdKhg0MSOgNRX2GJAleXBDyG9dLtyE3LA4lfFRjUxAx
 irEtT523GKWGzCF2c7o3yn5OQBLMkN381iiwZexgmrnSWjyG0Z00veIVpPOHMPZvhJpOBCwRXqF
 aSeWhpbQSuZJfexAG7oAA7Bk2/SDmfZ4nubtX0nMq1w2ROQlkwEn6u8HoB88IkniMxuDxiMALwk
 Ybh6BouO3Xnjq9aT6BnysFweQ3GnIDVXZ/vKSdomZFDWcApK+mzoVFaNpC090CC1jxrIL6VhTAr
 NlLm+ADVsUGSSg==
X-Received: by 2002:a17:907:9801:b0:ad1:e4e9:6b4f with SMTP id
 a640c23a62f3a-adb322b2c9cmr206675866b.36.1748589233294; 
 Fri, 30 May 2025 00:13:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWo/qg0Z0qi2XNXq2IH2GCfA63o1nfMQdqL9tPj+Cs59B8OYnZ88SX8dnQr0cvzzxpi1/xAw==
X-Received: by 2002:a17:907:9801:b0:ad1:e4e9:6b4f with SMTP id
 a640c23a62f3a-adb322b2c9cmr206673066b.36.1748589232845; 
 Fri, 30 May 2025 00:13:52 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5eb54d24sm274588666b.123.2025.05.30.00.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:13:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Isaku Yamahata <isaku.yamahata@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 25/77] i386/tdx: Support user configurable
 mrconfigid/mrowner/mrownerconfig
Date: Fri, 30 May 2025 09:11:55 +0200
Message-ID: <20250530071250.2050910-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

Three sha384 hash values, mrconfigid, mrowner and mrownerconfig, of a TD
can be provided for TDX attestation. Detailed meaning of them can be
found: https://lore.kernel.org/qemu-devel/31d6dbc1-f453-4cef-ab08-4813f4e0ff92@intel.com/

Allow user to specify those values via property mrconfigid, mrowner and
mrownerconfig. They are all in base64 format.

example
-object tdx-guest, \
  mrconfigid=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
  mrowner=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v,\
  mrownerconfig=ASNFZ4mrze8BI0VniavN7wEjRWeJq83vASNFZ4mrze8BI0VniavN7wEjRWeJq83v

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-14-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/qom.json         | 16 +++++++-
 target/i386/kvm/tdx.h |  3 ++
 target/i386/kvm/tdx.c | 95 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 5a88d364236..45cd47508b0 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1060,11 +1060,25 @@
 #     pages.  Some guest OS (e.g., Linux TD guest) may require this to
 #     be set, otherwise they refuse to boot.
 #
+# @mrconfigid: ID for non-owner-defined configuration of the guest TD,
+#     e.g., run-time or OS configuration (base64 encoded SHA384 digest).
+#     Defaults to all zeros.
+#
+# @mrowner: ID for the guest TD’s owner (base64 encoded SHA384 digest).
+#     Defaults to all zeros.
+#
+# @mrownerconfig: ID for owner-defined configuration of the guest TD,
+#     e.g., specific to the workload rather than the run-time or OS
+#     (base64 encoded SHA384 digest).  Defaults to all zeros.
+#
 # Since: 10.1
 ##
 { 'struct': 'TdxGuestProperties',
   'data': { '*attributes': 'uint64',
-            '*sept-ve-disable': 'bool' } }
+            '*sept-ve-disable': 'bool',
+            '*mrconfigid': 'str',
+            '*mrowner': 'str',
+            '*mrownerconfig': 'str' } }
 
 ##
 # @ThreadContextProperties:
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 4e2b5c61ff5..e472b11fb0d 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -24,6 +24,9 @@ typedef struct TdxGuest {
     bool initialized;
     uint64_t attributes;    /* TD attributes */
     uint64_t xfam;
+    char *mrconfigid;       /* base64 encoded sha348 digest */
+    char *mrowner;          /* base64 encoded sha348 digest */
+    char *mrownerconfig;    /* base64 encoded sha348 digest */
 } TdxGuest;
 
 #ifdef CONFIG_TDX
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index c78a0e8b5ed..671f23d910a 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -11,8 +11,10 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/base64.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
+#include "crypto/hash.h"
 
 #include "hw/i386/x86.h"
 #include "kvm_i386.h"
@@ -240,6 +242,7 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
     CPUX86State *env = &x86cpu->env;
     g_autofree struct kvm_tdx_init_vm *init_vm = NULL;
     Error *local_err = NULL;
+    size_t data_len;
     int retry = 10000;
     int r = 0;
 
@@ -251,6 +254,45 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
     init_vm = g_malloc0(sizeof(struct kvm_tdx_init_vm) +
                         sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
 
+    if (tdx_guest->mrconfigid) {
+        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrconfigid,
+                              strlen(tdx_guest->mrconfigid), &data_len, errp);
+        if (!data) {
+            return -1;
+        }
+        if (data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
+            error_setg(errp, "TDX: failed to decode mrconfigid");
+            return -1;
+        }
+        memcpy(init_vm->mrconfigid, data, data_len);
+    }
+
+    if (tdx_guest->mrowner) {
+        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrowner,
+                              strlen(tdx_guest->mrowner), &data_len, errp);
+        if (!data) {
+            return -1;
+        }
+        if (data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
+            error_setg(errp, "TDX: failed to decode mrowner");
+            return -1;
+        }
+        memcpy(init_vm->mrowner, data, data_len);
+    }
+
+    if (tdx_guest->mrownerconfig) {
+        g_autofree uint8_t *data = qbase64_decode(tdx_guest->mrownerconfig,
+                            strlen(tdx_guest->mrownerconfig), &data_len, errp);
+        if (!data) {
+            return -1;
+        }
+        if (data_len != QCRYPTO_HASH_DIGEST_LEN_SHA384) {
+            error_setg(errp, "TDX: failed to decode mrownerconfig");
+            return -1;
+        }
+        memcpy(init_vm->mrownerconfig, data, data_len);
+    }
+
     r = setup_td_guest_attributes(x86cpu, errp);
     if (r) {
         return r;
@@ -314,6 +356,51 @@ static void tdx_guest_set_sept_ve_disable(Object *obj, bool value, Error **errp)
     }
 }
 
+static char *tdx_guest_get_mrconfigid(Object *obj, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    return g_strdup(tdx->mrconfigid);
+}
+
+static void tdx_guest_set_mrconfigid(Object *obj, const char *value, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    g_free(tdx->mrconfigid);
+    tdx->mrconfigid = g_strdup(value);
+}
+
+static char *tdx_guest_get_mrowner(Object *obj, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    return g_strdup(tdx->mrowner);
+}
+
+static void tdx_guest_set_mrowner(Object *obj, const char *value, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    g_free(tdx->mrowner);
+    tdx->mrowner = g_strdup(value);
+}
+
+static char *tdx_guest_get_mrownerconfig(Object *obj, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    return g_strdup(tdx->mrownerconfig);
+}
+
+static void tdx_guest_set_mrownerconfig(Object *obj, const char *value, Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    g_free(tdx->mrownerconfig);
+    tdx->mrownerconfig = g_strdup(value);
+}
+
 /* tdx guest */
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
                                    tdx_guest,
@@ -337,6 +424,14 @@ static void tdx_guest_init(Object *obj)
     object_property_add_bool(obj, "sept-ve-disable",
                              tdx_guest_get_sept_ve_disable,
                              tdx_guest_set_sept_ve_disable);
+    object_property_add_str(obj, "mrconfigid",
+                            tdx_guest_get_mrconfigid,
+                            tdx_guest_set_mrconfigid);
+    object_property_add_str(obj, "mrowner",
+                            tdx_guest_get_mrowner, tdx_guest_set_mrowner);
+    object_property_add_str(obj, "mrownerconfig",
+                            tdx_guest_get_mrownerconfig,
+                            tdx_guest_set_mrownerconfig);
 }
 
 static void tdx_guest_finalize(Object *obj)
-- 
2.49.0


