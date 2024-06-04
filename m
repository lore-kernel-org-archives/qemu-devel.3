Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86064C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENv3-0003ab-Jz; Tue, 04 Jun 2024 02:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENv0-0003Qy-RK
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuw-0007Vp-Pr
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qT4lx0hXwBoH3iO8Z5ckHNy8tb53i2gxGziTfxvq2x8=;
 b=AAgJ4c7iBnGddFMCI9CNclRtKpbWNtY+NzW750lcEmQ7ne4DkgPkLztqRP9/rcjxRY8ZDx
 eKAkNMw5EdDfkCUc0EOYoxNAnHygSbc51l/HAgLgaqdZkSTgXptSK3Q2F2vjc9V0Y6/ZEb
 t5OCQFldfESErLYmRMoPsfO6lbuWZBE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-NithIj0iPoCFiueC96KCfA-1; Tue, 04 Jun 2024 02:45:08 -0400
X-MC-Unique: NithIj0iPoCFiueC96KCfA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a68c8de89d3so127210066b.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483507; x=1718088307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qT4lx0hXwBoH3iO8Z5ckHNy8tb53i2gxGziTfxvq2x8=;
 b=XqUxEydPgWq0xzllBPxLGNkslmE/1x65aWTAdwhQjhcloDSqk/8P0MpH/3SWkSOrNB
 le7KWh44WXNx2JaFqkJGM9Qw9XFGKYEwA6D0xjj2dME8TxWi9kD/IdPk79H8krSCCvMw
 nmXnV5QqPUPnh0XkQV/tuvYQfTsq0KG5Sg43uFeqDT2zlkT4Jbsl6uk2IYZDCSn1FxOf
 EfeThK+LPSKEZ+R5xIKXQTTL4gyyjVtm/QVrLA9Z3korkcMrKnG3jrRc24UpoRzI/NCg
 ucqsPTDH4V2+LjY6soKj9cWIoCw0quGLSf4tCDqUO7k0SOl4uP6F5uXUhLuPr+e8dJ34
 i01A==
X-Gm-Message-State: AOJu0YxkqZlD4S1ooXeAy4nkSD2k8SCprOXlyc+OrMx63LUvMV5k+a9k
 2grkIsxqAsJZyS6lurOE1nAGb2G2p4IG6SwJpDcoRJ9gtrtiewmYF5y/6iq53sC75iRS+I2a0Pc
 VqNkQe/mxSv3vv5HcBEPTORXUvMA/FVqUOpCv5MNWWkWOXwmDFQWjiYjK1izEXmpYYcXUQqMeKp
 cymkoGo/NKDDiZDnKgrn9Ny3w9otzS4jU3gHrD
X-Received: by 2002:a17:906:c38b:b0:a68:aaee:5fe6 with SMTP id
 a640c23a62f3a-a68aaee6145mr423016266b.38.1717483506469; 
 Mon, 03 Jun 2024 23:45:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGBoz7EiGeJUuSQLJrINW9NDYbnSuTgX/nl6PdpuTY0fGqVFj2T7u4rL/Q5dMr+r40TqV0KQ==
X-Received: by 2002:a17:906:c38b:b0:a68:aaee:5fe6 with SMTP id
 a640c23a62f3a-a68aaee6145mr423014566b.38.1717483505849; 
 Mon, 03 Jun 2024 23:45:05 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68c7892dd5sm411802766b.43.2024.06.03.23.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Dov Murik <dovmurik@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 18/45] i386/sev: Introduce "sev-common" type to encapsulate
 common SEV state
Date: Tue,  4 Jun 2024 08:43:42 +0200
Message-ID: <20240604064409.957105-19-pbonzini@redhat.com>
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

From: Michael Roth <michael.roth@amd.com>

Currently all SEV/SEV-ES functionality is managed through a single
'sev-guest' QOM type. With upcoming support for SEV-SNP, taking this
same approach won't work well since some of the properties/state
managed by 'sev-guest' is not applicable to SEV-SNP, which will instead
rely on a new QOM type with its own set of properties/state.

To prepare for this, this patch moves common state into an abstract
'sev-common' parent type to encapsulate properties/state that are
common to both SEV/SEV-ES and SEV-SNP, leaving only SEV/SEV-ES-specific
properties/state in the current 'sev-guest' type. This should not
affect current behavior or command-line options.

As part of this patch, some related changes are also made:

  - a static 'sev_guest' variable is currently used to keep track of
    the 'sev-guest' instance. SEV-SNP would similarly introduce an
    'sev_snp_guest' static variable. But these instances are now
    available via qdev_get_machine()->cgs, so switch to using that
    instead and drop the static variable.

  - 'sev_guest' is currently used as the name for the static variable
    holding a pointer to the 'sev-guest' instance. Re-purpose the name
    as a local variable referring the 'sev-guest' instance, and use
    that consistently throughout the code so it can be easily
    distinguished from sev-common/sev-snp-guest instances.

  - 'sev' is generally used as the name for local variables holding a
    pointer to the 'sev-guest' instance. In cases where that now points
    to common state, use the name 'sev_common'; in cases where that now
    points to state specific to 'sev-guest' instance, use the name
    'sev_guest'

In order to enable kernel-hashes for SNP, pull it from
SevGuestProperties to its parent SevCommonProperties so
it will be available for both SEV and SNP.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Co-developed-by: Dov Murik <dovmurik@linux.ibm.com>
Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
Acked-by: Markus Armbruster <armbru@redhat.com> (QAPI schema)
Co-developed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-5-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/qom.json     |  40 ++--
 target/i386/sev.h |   3 +
 target/i386/sev.c | 493 ++++++++++++++++++++++++++--------------------
 3 files changed, 303 insertions(+), 233 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 38dde6d785a..056b38f491b 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -875,20 +875,12 @@
   'data': { '*filename': 'str' } }
 
 ##
-# @SevGuestProperties:
+# @SevCommonProperties:
 #
-# Properties for sev-guest objects.
+# Properties common to objects that are derivatives of sev-common.
 #
 # @sev-device: SEV device to use (default: "/dev/sev")
 #
-# @dh-cert-file: guest owners DH certificate (encoded with base64)
-#
-# @session-file: guest owners session parameters (encoded with base64)
-#
-# @policy: SEV policy value (default: 0x1)
-#
-# @handle: SEV firmware handle (default: 0)
-#
 # @cbitpos: C-bit location in page table entry (default: 0)
 #
 # @reduced-phys-bits: number of bits in physical addresses that become
@@ -898,6 +890,27 @@
 #     designated guest firmware page for measured boot with -kernel
 #     (default: false) (since 6.2)
 #
+# Since: 9.1
+##
+{ 'struct': 'SevCommonProperties',
+  'data': { '*sev-device': 'str',
+            '*cbitpos': 'uint32',
+            'reduced-phys-bits': 'uint32',
+            '*kernel-hashes': 'bool' } }
+
+##
+# @SevGuestProperties:
+#
+# Properties for sev-guest objects.
+#
+# @dh-cert-file: guest owners DH certificate (encoded with base64)
+#
+# @session-file: guest owners session parameters (encoded with base64)
+#
+# @policy: SEV policy value (default: 0x1)
+#
+# @handle: SEV firmware handle (default: 0)
+#
 # @legacy-vm-type: Use legacy KVM_SEV_INIT KVM interface for creating the VM.
 #                  The newer KVM_SEV_INIT2 interface syncs additional vCPU
 #                  state when initializing the VMSA structures, which will
@@ -909,14 +922,11 @@
 # Since: 2.12
 ##
 { 'struct': 'SevGuestProperties',
-  'data': { '*sev-device': 'str',
-            '*dh-cert-file': 'str',
+  'base': 'SevCommonProperties',
+  'data': { '*dh-cert-file': 'str',
             '*session-file': 'str',
             '*policy': 'uint32',
             '*handle': 'uint32',
-            '*cbitpos': 'uint32',
-            'reduced-phys-bits': 'uint32',
-            '*kernel-hashes': 'bool',
             '*legacy-vm-type': 'bool' } }
 
 ##
diff --git a/target/i386/sev.h b/target/i386/sev.h
index 9e10d09539a..668374eef31 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -20,6 +20,9 @@
 
 #include "exec/confidential-guest-support.h"
 
+#define TYPE_SEV_COMMON "sev-common"
+#define TYPE_SEV_GUEST "sev-guest"
+
 #define SEV_POLICY_NODBG        0x1
 #define SEV_POLICY_NOKS         0x2
 #define SEV_POLICY_ES           0x4
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 67ed32e5ea9..33e606eea00 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -40,9 +40,36 @@
 #include "hw/i386/pc.h"
 #include "exec/address-spaces.h"
 
-#define TYPE_SEV_GUEST "sev-guest"
-OBJECT_DECLARE_SIMPLE_TYPE(SevGuestState, SEV_GUEST)
+OBJECT_DECLARE_TYPE(SevCommonState, SevCommonStateClass, SEV_COMMON)
+OBJECT_DECLARE_TYPE(SevGuestState, SevCommonStateClass, SEV_GUEST)
 
+struct SevCommonState {
+    X86ConfidentialGuest parent_obj;
+
+    int kvm_type;
+
+    /* configuration parameters */
+    char *sev_device;
+    uint32_t cbitpos;
+    uint32_t reduced_phys_bits;
+    bool kernel_hashes;
+
+    /* runtime state */
+    uint8_t api_major;
+    uint8_t api_minor;
+    uint8_t build_id;
+    int sev_fd;
+    SevState state;
+
+    uint32_t reset_cs;
+    uint32_t reset_ip;
+    bool reset_data_valid;
+};
+
+struct SevCommonStateClass {
+    X86ConfidentialGuestClass parent_class;
+
+};
 
 /**
  * SevGuestState:
@@ -55,32 +82,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(SevGuestState, SEV_GUEST)
  *         -machine ...,memory-encryption=sev0
  */
 struct SevGuestState {
-    X86ConfidentialGuest parent_obj;
-
-    int kvm_type;
+    SevCommonState parent_obj;
+    gchar *measurement;
 
     /* configuration parameters */
-    char *sev_device;
+    uint32_t handle;
     uint32_t policy;
     char *dh_cert_file;
     char *session_file;
-    uint32_t cbitpos;
-    uint32_t reduced_phys_bits;
-    bool kernel_hashes;
     bool legacy_vm_type;
-
-    /* runtime state */
-    uint32_t handle;
-    uint8_t api_major;
-    uint8_t api_minor;
-    uint8_t build_id;
-    int sev_fd;
-    SevState state;
-    gchar *measurement;
-
-    uint32_t reset_cs;
-    uint32_t reset_ip;
-    bool reset_data_valid;
 };
 
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
@@ -128,7 +138,6 @@ typedef struct QEMU_PACKED PaddedSevHashTable {
 
 QEMU_BUILD_BUG_ON(sizeof(PaddedSevHashTable) % 16 != 0);
 
-static SevGuestState *sev_guest;
 static Error *sev_mig_blocker;
 
 static const char *const sev_fw_errlist[] = {
@@ -209,21 +218,21 @@ fw_error_to_str(int code)
 }
 
 static bool
-sev_check_state(const SevGuestState *sev, SevState state)
+sev_check_state(const SevCommonState *sev_common, SevState state)
 {
-    assert(sev);
-    return sev->state == state ? true : false;
+    assert(sev_common);
+    return sev_common->state == state ? true : false;
 }
 
 static void
-sev_set_guest_state(SevGuestState *sev, SevState new_state)
+sev_set_guest_state(SevCommonState *sev_common, SevState new_state)
 {
     assert(new_state < SEV_STATE__MAX);
-    assert(sev);
+    assert(sev_common);
 
-    trace_kvm_sev_change_state(SevState_str(sev->state),
+    trace_kvm_sev_change_state(SevState_str(sev_common->state),
                                SevState_str(new_state));
-    sev->state = new_state;
+    sev_common->state = new_state;
 }
 
 static void
@@ -290,121 +299,61 @@ static struct RAMBlockNotifier sev_ram_notifier = {
     .ram_block_removed = sev_ram_block_removed,
 };
 
-static void
-sev_guest_finalize(Object *obj)
-{
-}
-
-static char *
-sev_guest_get_session_file(Object *obj, Error **errp)
-{
-    SevGuestState *s = SEV_GUEST(obj);
-
-    return s->session_file ? g_strdup(s->session_file) : NULL;
-}
-
-static void
-sev_guest_set_session_file(Object *obj, const char *value, Error **errp)
-{
-    SevGuestState *s = SEV_GUEST(obj);
-
-    s->session_file = g_strdup(value);
-}
-
-static char *
-sev_guest_get_dh_cert_file(Object *obj, Error **errp)
-{
-    SevGuestState *s = SEV_GUEST(obj);
-
-    return g_strdup(s->dh_cert_file);
-}
-
-static void
-sev_guest_set_dh_cert_file(Object *obj, const char *value, Error **errp)
-{
-    SevGuestState *s = SEV_GUEST(obj);
-
-    s->dh_cert_file = g_strdup(value);
-}
-
-static char *
-sev_guest_get_sev_device(Object *obj, Error **errp)
-{
-    SevGuestState *sev = SEV_GUEST(obj);
-
-    return g_strdup(sev->sev_device);
-}
-
-static void
-sev_guest_set_sev_device(Object *obj, const char *value, Error **errp)
-{
-    SevGuestState *sev = SEV_GUEST(obj);
-
-    sev->sev_device = g_strdup(value);
-}
-
-static bool sev_guest_get_kernel_hashes(Object *obj, Error **errp)
-{
-    SevGuestState *sev = SEV_GUEST(obj);
-
-    return sev->kernel_hashes;
-}
-
-static void sev_guest_set_kernel_hashes(Object *obj, bool value, Error **errp)
-{
-    SevGuestState *sev = SEV_GUEST(obj);
-
-    sev->kernel_hashes = value;
-}
-
-static bool sev_guest_get_legacy_vm_type(Object *obj, Error **errp)
-{
-    return SEV_GUEST(obj)->legacy_vm_type;
-}
-
-static void sev_guest_set_legacy_vm_type(Object *obj, bool value, Error **errp)
-{
-    SEV_GUEST(obj)->legacy_vm_type = value;
-}
-
 bool
 sev_enabled(void)
 {
-    return !!sev_guest;
+    ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
+
+    return !!object_dynamic_cast(OBJECT(cgs), TYPE_SEV_COMMON);
 }
 
 bool
 sev_es_enabled(void)
 {
-    return sev_enabled() && (sev_guest->policy & SEV_POLICY_ES);
+    ConfidentialGuestSupport *cgs = MACHINE(qdev_get_machine())->cgs;
+
+    return sev_enabled() && (SEV_GUEST(cgs)->policy & SEV_POLICY_ES);
 }
 
 uint32_t
 sev_get_cbit_position(void)
 {
-    return sev_guest ? sev_guest->cbitpos : 0;
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+
+    return sev_common ? sev_common->cbitpos : 0;
 }
 
 uint32_t
 sev_get_reduced_phys_bits(void)
 {
-    return sev_guest ? sev_guest->reduced_phys_bits : 0;
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+
+    return sev_common ? sev_common->reduced_phys_bits : 0;
 }
 
 static SevInfo *sev_get_info(void)
 {
     SevInfo *info;
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    SevGuestState *sev_guest =
+        (SevGuestState *)object_dynamic_cast(OBJECT(sev_common),
+                                             TYPE_SEV_GUEST);
 
     info = g_new0(SevInfo, 1);
     info->enabled = sev_enabled();
 
     if (info->enabled) {
-        info->api_major = sev_guest->api_major;
-        info->api_minor = sev_guest->api_minor;
-        info->build_id = sev_guest->build_id;
-        info->policy = sev_guest->policy;
-        info->state = sev_guest->state;
-        info->handle = sev_guest->handle;
+        if (sev_guest) {
+            info->handle = sev_guest->handle;
+        }
+        info->api_major = sev_common->api_major;
+        info->api_minor = sev_common->api_minor;
+        info->build_id = sev_common->build_id;
+        info->state = sev_common->state;
+        /* we only report the lower 32-bits of policy for SNP, ok for now... */
+        info->policy =
+            (uint32_t)object_property_get_uint(OBJECT(sev_common),
+                                               "policy", NULL);
     }
 
     return info;
@@ -530,6 +479,8 @@ static SevCapability *sev_get_capabilities(Error **errp)
     size_t pdh_len = 0, cert_chain_len = 0, cpu0_id_len = 0;
     uint32_t ebx;
     int fd;
+    SevCommonState *sev_common;
+    char *sev_device;
 
     if (!kvm_enabled()) {
         error_setg(errp, "KVM not enabled");
@@ -540,12 +491,21 @@ static SevCapability *sev_get_capabilities(Error **errp)
         return NULL;
     }
 
-    fd = open(DEFAULT_SEV_DEVICE, O_RDWR);
+    sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    if (!sev_common) {
+        error_setg(errp, "SEV is not configured");
+    }
+
+    sev_device = object_property_get_str(OBJECT(sev_common), "sev-device",
+                                         &error_abort);
+    fd = open(sev_device, O_RDWR);
     if (fd < 0) {
         error_setg_errno(errp, errno, "SEV: Failed to open %s",
                          DEFAULT_SEV_DEVICE);
+        g_free(sev_device);
         return NULL;
     }
+    g_free(sev_device);
 
     if (sev_get_pdh_info(fd, &pdh_data, &pdh_len,
                          &cert_chain_data, &cert_chain_len, errp)) {
@@ -588,7 +548,7 @@ static SevAttestationReport *sev_get_attestation_report(const char *mnonce,
 {
     struct kvm_sev_attestation_report input = {};
     SevAttestationReport *report = NULL;
-    SevGuestState *sev = sev_guest;
+    SevCommonState *sev_common;
     g_autofree guchar *data = NULL;
     g_autofree guchar *buf = NULL;
     gsize len;
@@ -613,8 +573,10 @@ static SevAttestationReport *sev_get_attestation_report(const char *mnonce,
         return NULL;
     }
 
+    sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+
     /* Query the report length */
-    ret = sev_ioctl(sev->sev_fd, KVM_SEV_GET_ATTESTATION_REPORT,
+    ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_GET_ATTESTATION_REPORT,
             &input, &err);
     if (ret < 0) {
         if (err != SEV_RET_INVALID_LEN) {
@@ -630,7 +592,7 @@ static SevAttestationReport *sev_get_attestation_report(const char *mnonce,
     memcpy(input.mnonce, buf, sizeof(input.mnonce));
 
     /* Query the report */
-    ret = sev_ioctl(sev->sev_fd, KVM_SEV_GET_ATTESTATION_REPORT,
+    ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_GET_ATTESTATION_REPORT,
             &input, &err);
     if (ret) {
         error_setg_errno(errp, errno, "SEV: Failed to get attestation report"
@@ -670,26 +632,27 @@ sev_read_file_base64(const char *filename, guchar **data, gsize *len)
 }
 
 static int
-sev_launch_start(SevGuestState *sev)
+sev_launch_start(SevGuestState *sev_guest)
 {
     gsize sz;
     int ret = 1;
     int fw_error, rc;
     struct kvm_sev_launch_start start = {
-        .handle = sev->handle, .policy = sev->policy
+        .handle = sev_guest->handle, .policy = sev_guest->policy
     };
     guchar *session = NULL, *dh_cert = NULL;
+    SevCommonState *sev_common = SEV_COMMON(sev_guest);
 
-    if (sev->session_file) {
-        if (sev_read_file_base64(sev->session_file, &session, &sz) < 0) {
+    if (sev_guest->session_file) {
+        if (sev_read_file_base64(sev_guest->session_file, &session, &sz) < 0) {
             goto out;
         }
         start.session_uaddr = (unsigned long)session;
         start.session_len = sz;
     }
 
-    if (sev->dh_cert_file) {
-        if (sev_read_file_base64(sev->dh_cert_file, &dh_cert, &sz) < 0) {
+    if (sev_guest->dh_cert_file) {
+        if (sev_read_file_base64(sev_guest->dh_cert_file, &dh_cert, &sz) < 0) {
             goto out;
         }
         start.dh_uaddr = (unsigned long)dh_cert;
@@ -697,15 +660,15 @@ sev_launch_start(SevGuestState *sev)
     }
 
     trace_kvm_sev_launch_start(start.policy, session, dh_cert);
-    rc = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_START, &start, &fw_error);
+    rc = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_START, &start, &fw_error);
     if (rc < 0) {
         error_report("%s: LAUNCH_START ret=%d fw_error=%d '%s'",
                 __func__, ret, fw_error, fw_error_to_str(fw_error));
         goto out;
     }
 
-    sev_set_guest_state(sev, SEV_STATE_LAUNCH_UPDATE);
-    sev->handle = start.handle;
+    sev_set_guest_state(sev_common, SEV_STATE_LAUNCH_UPDATE);
+    sev_guest->handle = start.handle;
     ret = 0;
 
 out:
@@ -715,7 +678,7 @@ out:
 }
 
 static int
-sev_launch_update_data(SevGuestState *sev, uint8_t *addr, uint64_t len)
+sev_launch_update_data(SevGuestState *sev_guest, uint8_t *addr, uint64_t len)
 {
     int ret, fw_error;
     struct kvm_sev_launch_update_data update;
@@ -727,7 +690,7 @@ sev_launch_update_data(SevGuestState *sev, uint8_t *addr, uint64_t len)
     update.uaddr = (uintptr_t)addr;
     update.len = len;
     trace_kvm_sev_launch_update_data(addr, len);
-    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
+    ret = sev_ioctl(SEV_COMMON(sev_guest)->sev_fd, KVM_SEV_LAUNCH_UPDATE_DATA,
                     &update, &fw_error);
     if (ret) {
         error_report("%s: LAUNCH_UPDATE ret=%d fw_error=%d '%s'",
@@ -738,11 +701,12 @@ sev_launch_update_data(SevGuestState *sev, uint8_t *addr, uint64_t len)
 }
 
 static int
-sev_launch_update_vmsa(SevGuestState *sev)
+sev_launch_update_vmsa(SevGuestState *sev_guest)
 {
     int ret, fw_error;
 
-    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL, &fw_error);
+    ret = sev_ioctl(SEV_COMMON(sev_guest)->sev_fd, KVM_SEV_LAUNCH_UPDATE_VMSA,
+                    NULL, &fw_error);
     if (ret) {
         error_report("%s: LAUNCH_UPDATE_VMSA ret=%d fw_error=%d '%s'",
                 __func__, ret, fw_error, fw_error_to_str(fw_error));
@@ -754,18 +718,19 @@ sev_launch_update_vmsa(SevGuestState *sev)
 static void
 sev_launch_get_measure(Notifier *notifier, void *unused)
 {
-    SevGuestState *sev = sev_guest;
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+    SevGuestState *sev_guest = SEV_GUEST(sev_common);
     int ret, error;
     g_autofree guchar *data = NULL;
     struct kvm_sev_launch_measure measurement = {};
 
-    if (!sev_check_state(sev, SEV_STATE_LAUNCH_UPDATE)) {
+    if (!sev_check_state(sev_common, SEV_STATE_LAUNCH_UPDATE)) {
         return;
     }
 
     if (sev_es_enabled()) {
         /* measure all the VM save areas before getting launch_measure */
-        ret = sev_launch_update_vmsa(sev);
+        ret = sev_launch_update_vmsa(sev_guest);
         if (ret) {
             exit(1);
         }
@@ -773,7 +738,7 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
     }
 
     /* query the measurement blob length */
-    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_MEASURE,
+    ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_MEASURE,
                     &measurement, &error);
     if (!measurement.len) {
         error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
@@ -785,7 +750,7 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
     measurement.uaddr = (unsigned long)data;
 
     /* get the measurement blob */
-    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_MEASURE,
+    ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_MEASURE,
                     &measurement, &error);
     if (ret) {
         error_report("%s: LAUNCH_MEASURE ret=%d fw_error=%d '%s'",
@@ -793,17 +758,19 @@ sev_launch_get_measure(Notifier *notifier, void *unused)
         return;
     }
 
-    sev_set_guest_state(sev, SEV_STATE_LAUNCH_SECRET);
+    sev_set_guest_state(sev_common, SEV_STATE_LAUNCH_SECRET);
 
     /* encode the measurement value and emit the event */
-    sev->measurement = g_base64_encode(data, measurement.len);
-    trace_kvm_sev_launch_measurement(sev->measurement);
+    sev_guest->measurement = g_base64_encode(data, measurement.len);
+    trace_kvm_sev_launch_measurement(sev_guest->measurement);
 }
 
 static char *sev_get_launch_measurement(void)
 {
+    SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
+
     if (sev_guest &&
-        sev_guest->state >= SEV_STATE_LAUNCH_SECRET) {
+        SEV_COMMON(sev_guest)->state >= SEV_STATE_LAUNCH_SECRET) {
         return g_strdup(sev_guest->measurement);
     }
 
@@ -832,19 +799,20 @@ static Notifier sev_machine_done_notify = {
 };
 
 static void
-sev_launch_finish(SevGuestState *sev)
+sev_launch_finish(SevGuestState *sev_guest)
 {
     int ret, error;
 
     trace_kvm_sev_launch_finish();
-    ret = sev_ioctl(sev->sev_fd, KVM_SEV_LAUNCH_FINISH, 0, &error);
+    ret = sev_ioctl(SEV_COMMON(sev_guest)->sev_fd, KVM_SEV_LAUNCH_FINISH, 0,
+                    &error);
     if (ret) {
         error_report("%s: LAUNCH_FINISH ret=%d fw_error=%d '%s'",
                      __func__, ret, error, fw_error_to_str(error));
         exit(1);
     }
 
-    sev_set_guest_state(sev, SEV_STATE_RUNNING);
+    sev_set_guest_state(SEV_COMMON(sev_guest), SEV_STATE_RUNNING);
 
     /* add migration blocker */
     error_setg(&sev_mig_blocker,
@@ -855,38 +823,40 @@ sev_launch_finish(SevGuestState *sev)
 static void
 sev_vm_state_change(void *opaque, bool running, RunState state)
 {
-    SevGuestState *sev = opaque;
+    SevCommonState *sev_common = opaque;
 
     if (running) {
-        if (!sev_check_state(sev, SEV_STATE_RUNNING)) {
-            sev_launch_finish(sev);
+        if (!sev_check_state(sev_common, SEV_STATE_RUNNING)) {
+            sev_launch_finish(SEV_GUEST(sev_common));
         }
     }
 }
 
 static int sev_kvm_type(X86ConfidentialGuest *cg)
 {
-    SevGuestState *sev = SEV_GUEST(cg);
+    SevCommonState *sev_common = SEV_COMMON(cg);
+    SevGuestState *sev_guest = SEV_GUEST(sev_common);
     int kvm_type;
 
-    if (sev->kvm_type != -1) {
+    if (sev_common->kvm_type != -1) {
         goto out;
     }
 
-    kvm_type = (sev->policy & SEV_POLICY_ES) ? KVM_X86_SEV_ES_VM : KVM_X86_SEV_VM;
-    if (kvm_is_vm_type_supported(kvm_type) && !sev->legacy_vm_type) {
-        sev->kvm_type = kvm_type;
+    kvm_type = (sev_guest->policy & SEV_POLICY_ES) ?
+                KVM_X86_SEV_ES_VM : KVM_X86_SEV_VM;
+    if (kvm_is_vm_type_supported(kvm_type) && !sev_guest->legacy_vm_type) {
+        sev_common->kvm_type = kvm_type;
     } else {
-        sev->kvm_type = KVM_X86_DEFAULT_VM;
+        sev_common->kvm_type = KVM_X86_DEFAULT_VM;
     }
 
 out:
-    return sev->kvm_type;
+    return sev_common->kvm_type;
 }
 
 static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
-    SevGuestState *sev = SEV_GUEST(cgs);
+    SevCommonState *sev_common = SEV_COMMON(cgs);
     char *devname;
     int ret, fw_error, cmd;
     uint32_t ebx;
@@ -899,8 +869,7 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return -1;
     }
 
-    sev_guest = sev;
-    sev->state = SEV_STATE_UNINIT;
+    sev_common->state = SEV_STATE_UNINIT;
 
     host_cpuid(0x8000001F, 0, NULL, &ebx, NULL, NULL);
     host_cbitpos = ebx & 0x3f;
@@ -910,9 +879,9 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
      * register of CPUID 0x8000001F. No need to verify the range as the
      * comparison against the host value accomplishes that.
      */
-    if (host_cbitpos != sev->cbitpos) {
+    if (host_cbitpos != sev_common->cbitpos) {
         error_setg(errp, "%s: cbitpos check failed, host '%d' requested '%d'",
-                   __func__, host_cbitpos, sev->cbitpos);
+                   __func__, host_cbitpos, sev_common->cbitpos);
         goto err;
     }
 
@@ -921,16 +890,17 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
      * the EBX register of CPUID 0x8000001F, so verify the supplied value
      * is in the range of 1 to 63.
      */
-    if (sev->reduced_phys_bits < 1 || sev->reduced_phys_bits > 63) {
+    if (sev_common->reduced_phys_bits < 1 ||
+        sev_common->reduced_phys_bits > 63) {
         error_setg(errp, "%s: reduced_phys_bits check failed,"
                    " it should be in the range of 1 to 63, requested '%d'",
-                   __func__, sev->reduced_phys_bits);
+                   __func__, sev_common->reduced_phys_bits);
         goto err;
     }
 
-    devname = object_property_get_str(OBJECT(sev), "sev-device", NULL);
-    sev->sev_fd = open(devname, O_RDWR);
-    if (sev->sev_fd < 0) {
+    devname = object_property_get_str(OBJECT(sev_common), "sev-device", NULL);
+    sev_common->sev_fd = open(devname, O_RDWR);
+    if (sev_common->sev_fd < 0) {
         error_setg(errp, "%s: Failed to open %s '%s'", __func__,
                    devname, strerror(errno));
         g_free(devname);
@@ -938,7 +908,7 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     }
     g_free(devname);
 
-    ret = sev_platform_ioctl(sev->sev_fd, SEV_PLATFORM_STATUS, &status,
+    ret = sev_platform_ioctl(sev_common->sev_fd, SEV_PLATFORM_STATUS, &status,
                              &fw_error);
     if (ret) {
         error_setg(errp, "%s: failed to get platform status ret=%d "
@@ -946,9 +916,9 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
                    fw_error_to_str(fw_error));
         goto err;
     }
-    sev->build_id = status.build;
-    sev->api_major = status.api_major;
-    sev->api_minor = status.api_minor;
+    sev_common->build_id = status.build;
+    sev_common->api_major = status.api_major;
+    sev_common->api_minor = status.api_minor;
 
     if (sev_es_enabled()) {
         if (!kvm_kernel_irqchip_allowed()) {
@@ -966,14 +936,14 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
     }
 
     trace_kvm_sev_init();
-    if (sev_kvm_type(X86_CONFIDENTIAL_GUEST(sev)) == KVM_X86_DEFAULT_VM) {
+    if (sev_kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) == KVM_X86_DEFAULT_VM) {
         cmd = sev_es_enabled() ? KVM_SEV_ES_INIT : KVM_SEV_INIT;
 
-        ret = sev_ioctl(sev->sev_fd, cmd, NULL, &fw_error);
+        ret = sev_ioctl(sev_common->sev_fd, cmd, NULL, &fw_error);
     } else {
         struct kvm_sev_init args = { 0 };
 
-        ret = sev_ioctl(sev->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
+        ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
     }
 
     if (ret) {
@@ -982,7 +952,7 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         goto err;
     }
 
-    ret = sev_launch_start(sev);
+    sev_launch_start(SEV_GUEST(sev_common));
     if (ret) {
         error_setg(errp, "%s: failed to create encryption context", __func__);
         goto err;
@@ -990,13 +960,12 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 
     ram_block_notifier_add(&sev_ram_notifier);
     qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
-    qemu_add_vm_change_state_handler(sev_vm_state_change, sev);
+    qemu_add_vm_change_state_handler(sev_vm_state_change, sev_common);
 
     cgs->ready = true;
 
     return 0;
 err:
-    sev_guest = NULL;
     ram_block_discard_disable(false);
     return -1;
 }
@@ -1004,13 +973,15 @@ err:
 int
 sev_encrypt_flash(uint8_t *ptr, uint64_t len, Error **errp)
 {
-    if (!sev_guest) {
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
+
+    if (!sev_common) {
         return 0;
     }
 
     /* if SEV is in update state then encrypt the data else do nothing */
-    if (sev_check_state(sev_guest, SEV_STATE_LAUNCH_UPDATE)) {
-        int ret = sev_launch_update_data(sev_guest, ptr, len);
+    if (sev_check_state(sev_common, SEV_STATE_LAUNCH_UPDATE)) {
+        int ret = sev_launch_update_data(SEV_GUEST(sev_common), ptr, len);
         if (ret < 0) {
             error_setg(errp, "SEV: Failed to encrypt pflash rom");
             return ret;
@@ -1030,16 +1001,17 @@ int sev_inject_launch_secret(const char *packet_hdr, const char *secret,
     void *hva;
     gsize hdr_sz = 0, data_sz = 0;
     MemoryRegion *mr = NULL;
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
 
-    if (!sev_guest) {
+    if (!sev_common) {
         error_setg(errp, "SEV not enabled for guest");
         return 1;
     }
 
     /* secret can be injected only in this state */
-    if (!sev_check_state(sev_guest, SEV_STATE_LAUNCH_SECRET)) {
+    if (!sev_check_state(sev_common, SEV_STATE_LAUNCH_SECRET)) {
         error_setg(errp, "SEV: Not in correct state. (LSECRET) %x",
-                     sev_guest->state);
+                   sev_common->state);
         return 1;
     }
 
@@ -1073,7 +1045,7 @@ int sev_inject_launch_secret(const char *packet_hdr, const char *secret,
     trace_kvm_sev_launch_secret(gpa, input.guest_uaddr,
                                 input.trans_uaddr, input.trans_len);
 
-    ret = sev_ioctl(sev_guest->sev_fd, KVM_SEV_LAUNCH_SECRET,
+    ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_LAUNCH_SECRET,
                     &input, &error);
     if (ret) {
         error_setg(errp, "SEV: failed to inject secret ret=%d fw_error=%d '%s'",
@@ -1180,9 +1152,10 @@ void sev_es_set_reset_vector(CPUState *cpu)
 {
     X86CPU *x86;
     CPUX86State *env;
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
 
     /* Only update if we have valid reset information */
-    if (!sev_guest || !sev_guest->reset_data_valid) {
+    if (!sev_common || !sev_common->reset_data_valid) {
         return;
     }
 
@@ -1194,11 +1167,11 @@ void sev_es_set_reset_vector(CPUState *cpu)
     x86 = X86_CPU(cpu);
     env = &x86->env;
 
-    cpu_x86_load_seg_cache(env, R_CS, 0xf000, sev_guest->reset_cs, 0xffff,
+    cpu_x86_load_seg_cache(env, R_CS, 0xf000, sev_common->reset_cs, 0xffff,
                            DESC_P_MASK | DESC_S_MASK | DESC_CS_MASK |
                            DESC_R_MASK | DESC_A_MASK);
 
-    env->eip = sev_guest->reset_ip;
+    env->eip = sev_common->reset_ip;
 }
 
 int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size)
@@ -1206,6 +1179,7 @@ int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size)
     CPUState *cpu;
     uint32_t addr;
     int ret;
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
 
     if (!sev_es_enabled()) {
         return 0;
@@ -1219,9 +1193,9 @@ int sev_es_save_reset_vector(void *flash_ptr, uint64_t flash_size)
     }
 
     if (addr) {
-        sev_guest->reset_cs = addr & 0xffff0000;
-        sev_guest->reset_ip = addr & 0x0000ffff;
-        sev_guest->reset_data_valid = true;
+        sev_common->reset_cs = addr & 0xffff0000;
+        sev_common->reset_ip = addr & 0x0000ffff;
+        sev_common->reset_data_valid = true;
 
         CPU_FOREACH(cpu) {
             sev_es_set_reset_vector(cpu);
@@ -1267,12 +1241,13 @@ bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp)
     hwaddr mapped_len = sizeof(*padded_ht);
     MemTxAttrs attrs = { 0 };
     bool ret = true;
+    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
 
     /*
      * Only add the kernel hashes if the sev-guest configuration explicitly
      * stated kernel-hashes=on.
      */
-    if (!sev_guest->kernel_hashes) {
+    if (!sev_common->kernel_hashes) {
         return false;
     }
 
@@ -1363,8 +1338,30 @@ bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp)
     return ret;
 }
 
+static char *
+sev_common_get_sev_device(Object *obj, Error **errp)
+{
+    return g_strdup(SEV_COMMON(obj)->sev_device);
+}
+
 static void
-sev_guest_class_init(ObjectClass *oc, void *data)
+sev_common_set_sev_device(Object *obj, const char *value, Error **errp)
+{
+    SEV_COMMON(obj)->sev_device = g_strdup(value);
+}
+
+static bool sev_common_get_kernel_hashes(Object *obj, Error **errp)
+{
+    return SEV_COMMON(obj)->kernel_hashes;
+}
+
+static void sev_common_set_kernel_hashes(Object *obj, bool value, Error **errp)
+{
+    SEV_COMMON(obj)->kernel_hashes = value;
+}
+
+static void
+sev_common_class_init(ObjectClass *oc, void *data)
 {
     ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
     X86ConfidentialGuestClass *x86_klass = X86_CONFIDENTIAL_GUEST_CLASS(oc);
@@ -1373,10 +1370,87 @@ sev_guest_class_init(ObjectClass *oc, void *data)
     x86_klass->kvm_type = sev_kvm_type;
 
     object_class_property_add_str(oc, "sev-device",
-                                  sev_guest_get_sev_device,
-                                  sev_guest_set_sev_device);
+                                  sev_common_get_sev_device,
+                                  sev_common_set_sev_device);
     object_class_property_set_description(oc, "sev-device",
             "SEV device to use");
+    object_class_property_add_bool(oc, "kernel-hashes",
+                                   sev_common_get_kernel_hashes,
+                                   sev_common_set_kernel_hashes);
+    object_class_property_set_description(oc, "kernel-hashes",
+            "add kernel hashes to guest firmware for measured Linux boot");
+}
+
+static void
+sev_common_instance_init(Object *obj)
+{
+    SevCommonState *sev_common = SEV_COMMON(obj);
+
+    sev_common->kvm_type = -1;
+
+    sev_common->sev_device = g_strdup(DEFAULT_SEV_DEVICE);
+
+    object_property_add_uint32_ptr(obj, "cbitpos", &sev_common->cbitpos,
+                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_add_uint32_ptr(obj, "reduced-phys-bits",
+                                   &sev_common->reduced_phys_bits,
+                                   OBJ_PROP_FLAG_READWRITE);
+}
+
+/* sev guest info common to sev/sev-es/sev-snp */
+static const TypeInfo sev_common_info = {
+    .parent = TYPE_X86_CONFIDENTIAL_GUEST,
+    .name = TYPE_SEV_COMMON,
+    .instance_size = sizeof(SevCommonState),
+    .instance_init = sev_common_instance_init,
+    .class_size = sizeof(SevCommonStateClass),
+    .class_init = sev_common_class_init,
+    .abstract = true,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+static char *
+sev_guest_get_dh_cert_file(Object *obj, Error **errp)
+{
+    return g_strdup(SEV_GUEST(obj)->dh_cert_file);
+}
+
+static void
+sev_guest_set_dh_cert_file(Object *obj, const char *value, Error **errp)
+{
+    SEV_GUEST(obj)->dh_cert_file = g_strdup(value);
+}
+
+static char *
+sev_guest_get_session_file(Object *obj, Error **errp)
+{
+    SevGuestState *sev_guest = SEV_GUEST(obj);
+
+    return sev_guest->session_file ? g_strdup(sev_guest->session_file) : NULL;
+}
+
+static void
+sev_guest_set_session_file(Object *obj, const char *value, Error **errp)
+{
+    SEV_GUEST(obj)->session_file = g_strdup(value);
+}
+
+static bool sev_guest_get_legacy_vm_type(Object *obj, Error **errp)
+{
+    return SEV_GUEST(obj)->legacy_vm_type;
+}
+
+static void sev_guest_set_legacy_vm_type(Object *obj, bool value, Error **errp)
+{
+    SEV_GUEST(obj)->legacy_vm_type = value;
+}
+
+static void
+sev_guest_class_init(ObjectClass *oc, void *data)
+{
     object_class_property_add_str(oc, "dh-cert-file",
                                   sev_guest_get_dh_cert_file,
                                   sev_guest_set_dh_cert_file);
@@ -1387,11 +1461,6 @@ sev_guest_class_init(ObjectClass *oc, void *data)
                                   sev_guest_set_session_file);
     object_class_property_set_description(oc, "session-file",
             "guest owners session parameters (encoded with base64)");
-    object_class_property_add_bool(oc, "kernel-hashes",
-                                   sev_guest_get_kernel_hashes,
-                                   sev_guest_set_kernel_hashes);
-    object_class_property_set_description(oc, "kernel-hashes",
-            "add kernel hashes to guest firmware for measured Linux boot");
     object_class_property_add_bool(oc, "legacy-vm-type",
                                    sev_guest_get_legacy_vm_type,
                                    sev_guest_set_legacy_vm_type);
@@ -1402,41 +1471,29 @@ sev_guest_class_init(ObjectClass *oc, void *data)
 static void
 sev_guest_instance_init(Object *obj)
 {
-    SevGuestState *sev = SEV_GUEST(obj);
+    SevGuestState *sev_guest = SEV_GUEST(obj);
 
-    sev->kvm_type = -1;
-
-    sev->sev_device = g_strdup(DEFAULT_SEV_DEVICE);
-    sev->policy = DEFAULT_GUEST_POLICY;
-    object_property_add_uint32_ptr(obj, "policy", &sev->policy,
+    sev_guest->policy = DEFAULT_GUEST_POLICY;
+    object_property_add_uint32_ptr(obj, "handle", &sev_guest->handle,
                                    OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint32_ptr(obj, "handle", &sev->handle,
-                                   OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint32_ptr(obj, "cbitpos", &sev->cbitpos,
-                                   OBJ_PROP_FLAG_READWRITE);
-    object_property_add_uint32_ptr(obj, "reduced-phys-bits",
-                                   &sev->reduced_phys_bits,
+    object_property_add_uint32_ptr(obj, "policy", &sev_guest->policy,
                                    OBJ_PROP_FLAG_READWRITE);
     object_apply_compat_props(obj);
 }
 
-/* sev guest info */
+/* guest info specific sev/sev-es */
 static const TypeInfo sev_guest_info = {
-    .parent = TYPE_X86_CONFIDENTIAL_GUEST,
+    .parent = TYPE_SEV_COMMON,
     .name = TYPE_SEV_GUEST,
     .instance_size = sizeof(SevGuestState),
-    .instance_finalize = sev_guest_finalize,
-    .class_init = sev_guest_class_init,
     .instance_init = sev_guest_instance_init,
-    .interfaces = (InterfaceInfo[]) {
-        { TYPE_USER_CREATABLE },
-        { }
-    }
+    .class_init = sev_guest_class_init,
 };
 
 static void
 sev_register_types(void)
 {
+    type_register_static(&sev_common_info);
     type_register_static(&sev_guest_info);
 }
 
-- 
2.45.1


