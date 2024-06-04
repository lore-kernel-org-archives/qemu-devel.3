Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78648C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENvC-00045M-2p; Tue, 04 Jun 2024 02:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENv9-0003zh-CP
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENv6-0007Wk-NY
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0jNCLcd504FxAEHcD8i/gKCn0CcmYGcfMu+sEXBAAJE=;
 b=T/ofWmX8baM4XBovCn/1rLePZanAOKBJA8c2Y3Yp6f3L/3++QyC0CrRr+i8OjtpHXP9Qp7
 Qa1pxtjJiYvnYR4eq98B0jg5ErxukTYWx3WtOYy4OaIOz/ooZFi9BAaploGWafRORn5MuW
 ogCx4cIS5Wj3Gwi73DEKY8IW4BJOBws=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-S7vzXDK7O3O15ZZLj2E4KQ-1; Tue, 04 Jun 2024 02:45:16 -0400
X-MC-Unique: S7vzXDK7O3O15ZZLj2E4KQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57a22ad0d04so935789a12.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483514; x=1718088314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jNCLcd504FxAEHcD8i/gKCn0CcmYGcfMu+sEXBAAJE=;
 b=ky4dDUaGRumoYxqOL9pxIFMcydLJAWzKpN6IB1Qkgj1WAVeYp9EU7Ne3ENRcVR0ucr
 75eWMsUaEt2Ui7LzxOAkAGfxBL4QiS5RrxGqVjeN6QZ70w839wHPpJLdc+zt/MWN9+RT
 DQt9BIEb0VKu1b8YujpJ828LctIgrZ8VFfzO4uilkYqyhGteAU0NnCpvktORtVSbZWCE
 fu0yHrkRAv46tvIx3sxdprzyrl6FICb4BovaM2NJLkPrD/V0h/6yURGWYgJfJSmleDlk
 zb1r6sB2f3rcvTeB40h9dqcHcqaoZTTpUGhtgvlrXtg+0aAPYZmkBjx5WlzsfPBoB03g
 /Ljg==
X-Gm-Message-State: AOJu0YxQAg3D39RKKUL5hch3ZAfw+CmztKk3LsPxQNjua+fbdJz5jgEI
 Aa5C4hgZrJt/UOXoyJQj/tUVj/3ZeydaDWUqrXw0n8Q+Saz4WPkVkYEQQevSmVwsQan1o3F+APH
 l1yzuuUohtidxM531FyRlAigo+0huZ2RnQ+tCiZmtyWRbqkw9JqeYSIP/1FKqWcw04hiiG4gUhd
 rXwG0b23g9HElPc2iBOCdH5Y1Ztfp01OYBLEwJ
X-Received: by 2002:a50:d641:0:b0:573:55cc:2f50 with SMTP id
 4fb4d7f45d1cf-57a36442156mr9837035a12.37.1717483514499; 
 Mon, 03 Jun 2024 23:45:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0CW4tVdw2yrivh33PhaW6OsP8Xv8AJKZwD4A3/mbomQkt4HSZKNaloKMkWu0A2Z8dWiay3g==
X-Received: by 2002:a50:d641:0:b0:573:55cc:2f50 with SMTP id
 4fb4d7f45d1cf-57a36442156mr9837016a12.37.1717483513967; 
 Mon, 03 Jun 2024 23:45:13 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a4f172062sm5004706a12.90.2024.06.03.23.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 21/45] i386/sev: Introduce 'sev-snp-guest' object
Date: Tue,  4 Jun 2024 08:43:45 +0200
Message-ID: <20240604064409.957105-22-pbonzini@redhat.com>
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

SEV-SNP support relies on a different set of properties/state than the
existing 'sev-guest' object. This patch introduces the 'sev-snp-guest'
object, which can be used to configure an SEV-SNP guest. For example,
a default-configured SEV-SNP guest with no additional information
passed in for use with attestation:

  -object sev-snp-guest,id=sev0

or a fully-specified SEV-SNP guest where all spec-defined binary
blobs are passed in as base64-encoded strings:

  -object sev-snp-guest,id=sev0, \
    policy=0x30000, \
    init-flags=0, \
    id-block=YWFhYWFhYWFhYWFhYWFhCg==, \
    id-auth=CxHK/OKLkXGn/KpAC7Wl1FSiisWDbGTEKz..., \
    author-key-enabled=on, \
    host-data=LNkCWBRC5CcdGXirbNUV1OrsR28s..., \
    guest-visible-workarounds=AA==, \

See the QAPI schema updates included in this patch for more usage
details.

In some cases these blobs may be up to 4096 characters, but this is
generally well below the default limit for linux hosts where
command-line sizes are defined by the sysconf-configurable ARG_MAX
value, which defaults to 2097152 characters for Ubuntu hosts, for
example.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Co-developed-by: Michael Roth <michael.roth@amd.com>
Acked-by: Markus Armbruster <armbru@redhat.com> (for QAPI schema)
Signed-off-by: Michael Roth <michael.roth@amd.com>
Co-developed-by: Pankaj Gupta <pankaj.gupta@amd.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-8-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/i386/amd-memory-encryption.rst |  70 +++++-
 qapi/qom.json                              |  58 +++++
 target/i386/sev.h                          |   1 +
 target/i386/sev.c                          | 253 +++++++++++++++++++++
 4 files changed, 380 insertions(+), 2 deletions(-)

diff --git a/docs/system/i386/amd-memory-encryption.rst b/docs/system/i386/amd-memory-encryption.rst
index e9bc142bc13..748f5094baf 100644
--- a/docs/system/i386/amd-memory-encryption.rst
+++ b/docs/system/i386/amd-memory-encryption.rst
@@ -25,8 +25,8 @@ support for notifying a guest's operating system when certain types of VMEXITs
 are about to occur. This allows the guest to selectively share information with
 the hypervisor to satisfy the requested function.
 
-Launching
----------
+Launching (SEV and SEV-ES)
+--------------------------
 
 Boot images (such as bios) must be encrypted before a guest can be booted. The
 ``MEMORY_ENCRYPT_OP`` ioctl provides commands to encrypt the images: ``LAUNCH_START``,
@@ -161,6 +161,72 @@ The value of GCTX.LD is
 If kernel hashes are not used, or SEV-ES is disabled, use empty blobs for
 ``kernel_hashes_blob`` and ``vmsas_blob`` as needed.
 
+Launching (SEV-SNP)
+-------------------
+Boot images (such as bios) must be encrypted before a guest can be booted. The
+``MEMORY_ENCRYPT_OP`` ioctl provides commands to encrypt the images:
+``SNP_LAUNCH_START``, ``SNP_LAUNCH_UPDATE``, and ``SNP_LAUNCH_FINISH``. These
+three commands communicate with SEV-SNP firmware to generate a fresh memory
+encryption key for the VM, encrypt the boot images for a successful launch. For
+more details on the SEV-SNP firmware interfaces used by these commands please
+see the SEV-SNP Firmware ABI.
+
+``SNP_LAUNCH_START`` is called first to create a cryptographic launch context
+within the firmware. To create this context, the guest owner must provide a
+guest policy and other parameters as described in the SEV-SNP firmware
+specification. The launch parameters should be specified as described in the
+QAPI schema for the sev-snp-guest object.
+
+The ``SNP_LAUNCH_START`` uses the following parameters, which can be configured
+by the corresponding parameters documented in the QAPI schema for the
+'sev-snp-guest' object.
+
++--------+-------+----------+-------------------------------------------------+
+| key                       | type  | default  | meaning                      |
++---------------------------+-------------------------------------------------+
+| policy                    | hex   | 0x30000  | a 64-bit guest policy        |
++---------------------------+-------------------------------------------------+
+| guest-visible-workarounds | string| 0        | 16-byte base64 encoded string|
+|                           |       |          | for guest OS visible         |
+|                           |       |          | workarounds.                 |
++---------------------------+-------------------------------------------------+
+
+``SNP_LAUNCH_UPDATE`` encrypts the memory region using the cryptographic context
+created via the ``SNP_LAUNCH_START`` command. If required, this command can be
+called multiple times to encrypt different memory regions. The command also
+calculates the measurement of the memory contents as it encrypts.
+
+``SNP_LAUNCH_FINISH`` finalizes the guest launch flow. Optionally, while
+finalizing the launch the firmware can perform checks on the launch digest
+computing through the ``SNP_LAUNCH_UPDATE``. To perform the check the user must
+supply the id block, authentication blob and host data that should be included
+in the attestation report. See the SEV-SNP spec for further details.
+
+The ``SNP_LAUNCH_FINISH`` uses the following parameters, which can be configured
+by the corresponding parameters documented in the QAPI schema for the
+'sev-snp-guest' object.
+
++--------------------+-------+----------+-------------------------------------+
+| key                | type  | default  | meaning                             |
++--------------------+-------+----------+-------------------------------------+
+| id-block           | string| none     | base64 encoded ID block             |
++--------------------+-------+----------+-------------------------------------+
+| id-auth            | string| none     | base64 encoded authentication       |
+|                    |       |          | information                         |
++--------------------+-------+----------+-------------------------------------+
+| author-key-enabled | bool  | 0        | auth block contains author key      |
++--------------------+-------+----------+-------------------------------------+
+| host_data          | string| none     | host provided data                  |
++--------------------+-------+----------+-------------------------------------+
+
+To launch a SEV-SNP guest (additional parameters are documented in the QAPI
+schema for the 'sev-snp-guest' object)::
+
+  # ${QEMU} \
+    -machine ...,confidential-guest-support=sev0 \
+    -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1
+
+
 Debugging
 ---------
 
diff --git a/qapi/qom.json b/qapi/qom.json
index 056b38f491b..8bd299265e3 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -929,6 +929,62 @@
             '*handle': 'uint32',
             '*legacy-vm-type': 'bool' } }
 
+##
+# @SevSnpGuestProperties:
+#
+# Properties for sev-snp-guest objects.  Most of these are direct
+# arguments for the KVM_SNP_* interfaces documented in the Linux
+# kernel source under
+# Documentation/arch/x86/amd-memory-encryption.rst, which are in turn
+# closely coupled with the SNP_INIT/SNP_LAUNCH_* firmware commands
+# documented in the SEV-SNP Firmware ABI Specification (Rev 0.9).
+#
+# More usage information is also available in the QEMU source tree
+# under docs/amd-memory-encryption.
+#
+# @policy: the 'POLICY' parameter to the SNP_LAUNCH_START command, as
+#     defined in the SEV-SNP firmware ABI (default: 0x30000)
+#
+# @guest-visible-workarounds: 16-byte, base64-encoded blob to report
+#     hypervisor-defined workarounds, corresponding to the 'GOSVW'
+#     parameter of the SNP_LAUNCH_START command defined in the SEV-SNP
+#     firmware ABI (default: all-zero)
+#
+# @id-block: 96-byte, base64-encoded blob to provide the 'ID Block'
+#     structure for the SNP_LAUNCH_FINISH command defined in the
+#     SEV-SNP firmware ABI (default: all-zero)
+#
+# @id-auth: 4096-byte, base64-encoded blob to provide the 'ID
+#     Authentication Information Structure' for the SNP_LAUNCH_FINISH
+#     command defined in the SEV-SNP firmware ABI (default: all-zero)
+#
+# @author-key-enabled: true if 'id-auth' blob contains the 'AUTHOR_KEY'
+#     field defined SEV-SNP firmware ABI (default: false)
+#
+# @host-data: 32-byte, base64-encoded, user-defined blob to provide to
+#     the guest, as documented for the 'HOST_DATA' parameter of the
+#     SNP_LAUNCH_FINISH command in the SEV-SNP firmware ABI (default:
+#     all-zero)
+#
+# @vcek-disabled: Guests are by default allowed to choose between VLEK
+#     (Versioned Loaded Endorsement Key) or VCEK (Versioned Chip
+#     Endorsement Key) when requesting attestation reports from
+#     firmware. Set this to true to disable the use of VCEK.
+#     (default: false) (since: 9.1)
+#
+# Since: 9.1
+##
+{ 'struct': 'SevSnpGuestProperties',
+  'base': 'SevCommonProperties',
+  'data': {
+            '*policy': 'uint64',
+            '*guest-visible-workarounds': 'str',
+            '*id-block': 'str',
+            '*id-auth': 'str',
+            '*author-key-enabled': 'bool',
+            '*host-data': 'str',
+            '*vcek-disabled': 'bool' } }
+
 ##
 # @ThreadContextProperties:
 #
@@ -1007,6 +1063,7 @@
     { 'name': 'secret_keyring',
       'if': 'CONFIG_SECRET_KEYRING' },
     'sev-guest',
+    'sev-snp-guest',
     'thread-context',
     's390-pv-guest',
     'throttle-group',
@@ -1077,6 +1134,7 @@
       'secret_keyring':             { 'type': 'SecretKeyringProperties',
                                       'if': 'CONFIG_SECRET_KEYRING' },
       'sev-guest':                  'SevGuestProperties',
+      'sev-snp-guest':              'SevSnpGuestProperties',
       'thread-context':             'ThreadContextProperties',
       'throttle-group':             'ThrottleGroupProperties',
       'tls-creds-anon':             'TlsCredsAnonProperties',
diff --git a/target/i386/sev.h b/target/i386/sev.h
index 668374eef31..bedc667eeba 100644
--- a/target/i386/sev.h
+++ b/target/i386/sev.h
@@ -22,6 +22,7 @@
 
 #define TYPE_SEV_COMMON "sev-common"
 #define TYPE_SEV_GUEST "sev-guest"
+#define TYPE_SEV_SNP_GUEST "sev-snp-guest"
 
 #define SEV_POLICY_NODBG        0x1
 #define SEV_POLICY_NOKS         0x2
diff --git a/target/i386/sev.c b/target/i386/sev.c
index 28a018ed833..a81b3228d4c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -42,6 +42,7 @@
 
 OBJECT_DECLARE_TYPE(SevCommonState, SevCommonStateClass, SEV_COMMON)
 OBJECT_DECLARE_TYPE(SevGuestState, SevCommonStateClass, SEV_GUEST)
+OBJECT_DECLARE_TYPE(SevSnpGuestState, SevCommonStateClass, SEV_SNP_GUEST)
 
 struct SevCommonState {
     X86ConfidentialGuest parent_obj;
@@ -96,8 +97,22 @@ struct SevGuestState {
     bool legacy_vm_type;
 };
 
+struct SevSnpGuestState {
+    SevCommonState parent_obj;
+
+    /* configuration parameters */
+    char *guest_visible_workarounds;
+    char *id_block;
+    char *id_auth;
+    char *host_data;
+
+    struct kvm_sev_snp_launch_start kvm_start_conf;
+    struct kvm_sev_snp_launch_finish kvm_finish_conf;
+};
+
 #define DEFAULT_GUEST_POLICY    0x1 /* disable debug */
 #define DEFAULT_SEV_DEVICE      "/dev/sev"
+#define DEFAULT_SEV_SNP_POLICY  0x30000
 
 #define SEV_INFO_BLOCK_GUID     "00f771de-1a7e-4fcb-890e-68c77e2fb44e"
 typedef struct __attribute__((__packed__)) SevInfoBlock {
@@ -1500,11 +1515,249 @@ static const TypeInfo sev_guest_info = {
     .class_init = sev_guest_class_init,
 };
 
+static void
+sev_snp_guest_get_policy(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    visit_type_uint64(v, name,
+                      (uint64_t *)&SEV_SNP_GUEST(obj)->kvm_start_conf.policy,
+                      errp);
+}
+
+static void
+sev_snp_guest_set_policy(Object *obj, Visitor *v, const char *name,
+                         void *opaque, Error **errp)
+{
+    visit_type_uint64(v, name,
+                      (uint64_t *)&SEV_SNP_GUEST(obj)->kvm_start_conf.policy,
+                      errp);
+}
+
+static char *
+sev_snp_guest_get_guest_visible_workarounds(Object *obj, Error **errp)
+{
+    return g_strdup(SEV_SNP_GUEST(obj)->guest_visible_workarounds);
+}
+
+static void
+sev_snp_guest_set_guest_visible_workarounds(Object *obj, const char *value,
+                                            Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+    struct kvm_sev_snp_launch_start *start = &sev_snp_guest->kvm_start_conf;
+    g_autofree guchar *blob;
+    gsize len;
+
+    g_free(sev_snp_guest->guest_visible_workarounds);
+
+    /* store the base64 str so we don't need to re-encode in getter */
+    sev_snp_guest->guest_visible_workarounds = g_strdup(value);
+
+    blob = qbase64_decode(sev_snp_guest->guest_visible_workarounds,
+                          -1, &len, errp);
+    if (!blob) {
+        return;
+    }
+
+    if (len != sizeof(start->gosvw)) {
+        error_setg(errp, "parameter length of %lu exceeds max of %lu",
+                   len, sizeof(start->gosvw));
+        return;
+    }
+
+    memcpy(start->gosvw, blob, len);
+}
+
+static char *
+sev_snp_guest_get_id_block(Object *obj, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    return g_strdup(sev_snp_guest->id_block);
+}
+
+static void
+sev_snp_guest_set_id_block(Object *obj, const char *value, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+    struct kvm_sev_snp_launch_finish *finish = &sev_snp_guest->kvm_finish_conf;
+    gsize len;
+
+    g_free(sev_snp_guest->id_block);
+    g_free((guchar *)finish->id_block_uaddr);
+
+    /* store the base64 str so we don't need to re-encode in getter */
+    sev_snp_guest->id_block = g_strdup(value);
+
+    finish->id_block_uaddr =
+        (uint64_t)qbase64_decode(sev_snp_guest->id_block, -1, &len, errp);
+
+    if (!finish->id_block_uaddr) {
+        return;
+    }
+
+    if (len != KVM_SEV_SNP_ID_BLOCK_SIZE) {
+        error_setg(errp, "parameter length of %lu not equal to %u",
+                   len, KVM_SEV_SNP_ID_BLOCK_SIZE);
+        return;
+    }
+
+    finish->id_block_en = (len) ? 1 : 0;
+}
+
+static char *
+sev_snp_guest_get_id_auth(Object *obj, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    return g_strdup(sev_snp_guest->id_auth);
+}
+
+static void
+sev_snp_guest_set_id_auth(Object *obj, const char *value, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+    struct kvm_sev_snp_launch_finish *finish = &sev_snp_guest->kvm_finish_conf;
+    gsize len;
+
+    g_free(sev_snp_guest->id_auth);
+    g_free((guchar *)finish->id_auth_uaddr);
+
+    /* store the base64 str so we don't need to re-encode in getter */
+    sev_snp_guest->id_auth = g_strdup(value);
+
+    finish->id_auth_uaddr =
+        (uint64_t)qbase64_decode(sev_snp_guest->id_auth, -1, &len, errp);
+
+    if (!finish->id_auth_uaddr) {
+        return;
+    }
+
+    if (len > KVM_SEV_SNP_ID_AUTH_SIZE) {
+        error_setg(errp, "parameter length:ID_AUTH %lu exceeds max of %u",
+                   len, KVM_SEV_SNP_ID_AUTH_SIZE);
+        return;
+    }
+}
+
+static bool
+sev_snp_guest_get_author_key_enabled(Object *obj, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    return !!sev_snp_guest->kvm_finish_conf.auth_key_en;
+}
+
+static void
+sev_snp_guest_set_author_key_enabled(Object *obj, bool value, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    sev_snp_guest->kvm_finish_conf.auth_key_en = value;
+}
+
+static bool
+sev_snp_guest_get_vcek_disabled(Object *obj, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    return !!sev_snp_guest->kvm_finish_conf.vcek_disabled;
+}
+
+static void
+sev_snp_guest_set_vcek_disabled(Object *obj, bool value, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    sev_snp_guest->kvm_finish_conf.vcek_disabled = value;
+}
+
+static char *
+sev_snp_guest_get_host_data(Object *obj, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    return g_strdup(sev_snp_guest->host_data);
+}
+
+static void
+sev_snp_guest_set_host_data(Object *obj, const char *value, Error **errp)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+    struct kvm_sev_snp_launch_finish *finish = &sev_snp_guest->kvm_finish_conf;
+    g_autofree guchar *blob;
+    gsize len;
+
+    g_free(sev_snp_guest->host_data);
+
+    /* store the base64 str so we don't need to re-encode in getter */
+    sev_snp_guest->host_data = g_strdup(value);
+
+    blob = qbase64_decode(sev_snp_guest->host_data, -1, &len, errp);
+
+    if (!blob) {
+        return;
+    }
+
+    if (len != sizeof(finish->host_data)) {
+        error_setg(errp, "parameter length of %lu not equal to %lu",
+                   len, sizeof(finish->host_data));
+        return;
+    }
+
+    memcpy(finish->host_data, blob, len);
+}
+
+static void
+sev_snp_guest_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add(oc, "policy", "uint64",
+                              sev_snp_guest_get_policy,
+                              sev_snp_guest_set_policy, NULL, NULL);
+    object_class_property_add_str(oc, "guest-visible-workarounds",
+                                  sev_snp_guest_get_guest_visible_workarounds,
+                                  sev_snp_guest_set_guest_visible_workarounds);
+    object_class_property_add_str(oc, "id-block",
+                                  sev_snp_guest_get_id_block,
+                                  sev_snp_guest_set_id_block);
+    object_class_property_add_str(oc, "id-auth",
+                                  sev_snp_guest_get_id_auth,
+                                  sev_snp_guest_set_id_auth);
+    object_class_property_add_bool(oc, "author-key-enabled",
+                                   sev_snp_guest_get_author_key_enabled,
+                                   sev_snp_guest_set_author_key_enabled);
+    object_class_property_add_bool(oc, "vcek-required",
+                                   sev_snp_guest_get_vcek_disabled,
+                                   sev_snp_guest_set_vcek_disabled);
+    object_class_property_add_str(oc, "host-data",
+                                  sev_snp_guest_get_host_data,
+                                  sev_snp_guest_set_host_data);
+}
+
+static void
+sev_snp_guest_instance_init(Object *obj)
+{
+    SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
+
+    /* default init/start/finish params for kvm */
+    sev_snp_guest->kvm_start_conf.policy = DEFAULT_SEV_SNP_POLICY;
+}
+
+/* guest info specific to sev-snp */
+static const TypeInfo sev_snp_guest_info = {
+    .parent = TYPE_SEV_COMMON,
+    .name = TYPE_SEV_SNP_GUEST,
+    .instance_size = sizeof(SevSnpGuestState),
+    .class_init = sev_snp_guest_class_init,
+    .instance_init = sev_snp_guest_instance_init,
+};
+
 static void
 sev_register_types(void)
 {
     type_register_static(&sev_common_info);
     type_register_static(&sev_guest_info);
+    type_register_static(&sev_snp_guest_info);
 }
 
 type_init(sev_register_types);
-- 
2.45.1


