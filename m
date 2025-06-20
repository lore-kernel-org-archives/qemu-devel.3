Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4818AC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 16:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSeos-0007sU-DH; Fri, 20 Jun 2025 12:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeoj-0007MO-1b
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:42:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uSeog-0000Ob-2B
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 12:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750437732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TPCtgHjjOME3wbK++PbqYUj6+yZcq+ob9E7eKp76/bs=;
 b=LIT29kQhHyoQ4cwIao0Hk8g716voZaGUtwVD/YgkNdiuvpPqrTuNWW04Uq6BV5/NqJpFsX
 roJyppfZD85Pqil3ewlBLEzhF5yi8/RVeuk89c08e5YdWPs7kgdnKMHyU/3OD6VXcxcO+O
 JHspICStB7FHyGZYMml+5ax8BnDXNrk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-uVr6mXvEOKC_nfclJ_a2MQ-1; Fri, 20 Jun 2025 12:42:10 -0400
X-MC-Unique: uVr6mXvEOKC_nfclJ_a2MQ-1
X-Mimecast-MFC-AGG-ID: uVr6mXvEOKC_nfclJ_a2MQ_1750437729
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ade6db50bb4so147938366b.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 09:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750437728; x=1751042528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPCtgHjjOME3wbK++PbqYUj6+yZcq+ob9E7eKp76/bs=;
 b=MpIaurjcXZTsB3xBLCSp+eYqUlYYp2sN/dhpxOKNg0pEPyNeLmkuq7rSijROO3O0RJ
 JjxQMH1oLGA2eILMQn/TUYf+z3Gdo66QzLCSdjco+hetJfLbc2hwClQIfmR4q8fTT8Il
 BdgzJygjo01iW/6XXtYr5y0fZ0HTriUD8sdanrUXDTjTMvdkDQIMuLkhtFmjuAMD06Y3
 rra1L83KR0fEPT033ODYmzBPYBuUBpA7AoyGG+d3UJ/SBR/2uSSpPzTiYfKw1d8zOt0D
 kgEzkIx1Bg4CEJh4WwrFrjv4YgRv52OWncOreBSeCsi+pibOqcBY5kFeP/Tp7bYIOSY7
 JsPA==
X-Gm-Message-State: AOJu0YwXA6do4VrJrjxrXTmEnkzWKLtx0BPL82UNaH5/OOqn0dEGw5yX
 3qSMls6uglOIB9/6WcSD8/S5urqAUzjYv89bjOWLi+yzReqevhMdiMJT91fe1PGdAy5z7l5cGTM
 zi/KK/bfftbHU4rJFU5jh6H14oWNm4vnAUqMewOy8g74jHZgSTNIF2snvs6bN8I7gLcdB/6kq9l
 GzDAajCKpdl0mxSxjMMTNB+NLyotI1wkzM9GpX6czg
X-Gm-Gg: ASbGncsXVDAeMh54Wxeh76aSfJ3kW/h0l1+vBRyMZ9phnoFKADzNPOM2CQcGRhR59nI
 HMi82VwwEYPth+vtTDS3CQowM+fmfvMYDlY9Ie854kweEC4/mUhgH2Z1b2Zfg82csqOaQC2lWHa
 GFVQTJHDJEbEZdToRX7rYzRmaFucCUs2G/FL0XrnnHcEZ2R79K9Q6PGK4yFuUHyD/6bbkmInGjc
 UYNEWxbMjUjWh5zCXy3Og0FrpnzkmYjuDz6nfPRY3xQlCOen0DJ7GFH6JeGglsniq10rdAPK53t
 AwAHKacxc3qUUfC4B1N51r71QA==
X-Received: by 2002:a17:907:fdcb:b0:ad2:4b33:ae70 with SMTP id
 a640c23a62f3a-ae057c0f5d5mr367838966b.31.1750437728068; 
 Fri, 20 Jun 2025 09:42:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyL2HHn4raOZ65Ul4V94olhusxFKQi4bRQ3UMdtRDDSnDCCp64kl9NzDU2Eh/teWPEZCYDNg==
X-Received: by 2002:a17:907:fdcb:b0:ad2:4b33:ae70 with SMTP id
 a640c23a62f3a-ae057c0f5d5mr367835766b.31.1750437727389; 
 Fri, 20 Jun 2025 09:42:07 -0700 (PDT)
Received: from [192.168.122.1] ([151.62.200.93])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae053ee4c90sm188996866b.62.2025.06.20.09.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 09:42:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Isaku Yamahata <isaku.yamahata@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 24/24] i386/tdx: handle TDG.VP.VMCALL<GetQuote>
Date: Fri, 20 Jun 2025 18:40:52 +0200
Message-ID: <20250620164053.579416-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620164053.579416-1-pbonzini@redhat.com>
References: <20250620164053.579416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add property "quote-generation-socket" to tdx-guest, which is a property
of type SocketAddress to specify Quote Generation Service(QGS).

On request of GetQuote, it connects to the QGS socket, read request
data from shared guest memory, send the request data to the QGS,
and store the response into shared guest memory, at last notify
TD guest by interrupt.

command line example:
  qemu-system-x86_64 \
    -object '{"qom-type":"tdx-guest","id":"tdx0","quote-generation-socket":{"type":"unix", "path":"/var/run/tdx-qgs/qgs.socket"}}' \
    -machine confidential-guest-support=tdx0

Note, above example uses the unix socket. It can be other types, like vsock,
which depends on the implementation of QGS.

To avoid no response from QGS server, setup a timer for the transaction.
If timeout, make it an error and interrupt guest. Define the threshold of
time to 30s at present, maybe change to other value if not appropriate.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Co-developed-by: Chenyi Qiang <chenyi.qiang@intel.com>
Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Tested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qapi/qom.json                         |   8 +-
 target/i386/kvm/tdx-quote-generator.h |  82 +++++++
 target/i386/kvm/tdx.h                 |  10 +
 target/i386/kvm/kvm.c                 |   3 +
 target/i386/kvm/tdx-quote-generator.c | 300 ++++++++++++++++++++++++++
 target/i386/kvm/tdx-stub.c            |   4 +
 target/i386/kvm/tdx.c                 | 176 ++++++++++++++-
 target/i386/kvm/meson.build           |   2 +-
 8 files changed, 582 insertions(+), 3 deletions(-)
 create mode 100644 target/i386/kvm/tdx-quote-generator.h
 create mode 100644 target/i386/kvm/tdx-quote-generator.c

diff --git a/qapi/qom.json b/qapi/qom.json
index 3e8debf78c2..b133b064471 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1071,6 +1071,11 @@
 #     e.g., specific to the workload rather than the run-time or OS
 #     (base64 encoded SHA384 digest).  Defaults to all zeros.
 #
+# @quote-generation-socket: socket address for Quote Generation
+#     Service (QGS).  QGS is a daemon running on the host.  Without
+#     it, the guest will not be able to get a TD quote for
+#     attestation.
+#
 # Since: 10.1
 ##
 { 'struct': 'TdxGuestProperties',
@@ -1078,7 +1083,8 @@
             '*sept-ve-disable': 'bool',
             '*mrconfigid': 'str',
             '*mrowner': 'str',
-            '*mrownerconfig': 'str' } }
+            '*mrownerconfig': 'str',
+            '*quote-generation-socket': 'SocketAddress' } }
 
 ##
 # @ThreadContextProperties:
diff --git a/target/i386/kvm/tdx-quote-generator.h b/target/i386/kvm/tdx-quote-generator.h
new file mode 100644
index 00000000000..3bd9b8ef331
--- /dev/null
+++ b/target/i386/kvm/tdx-quote-generator.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef QEMU_I386_TDX_QUOTE_GENERATOR_H
+#define QEMU_I386_TDX_QUOTE_GENERATOR_H
+
+#include "qom/object_interfaces.h"
+#include "io/channel-socket.h"
+#include "exec/hwaddr.h"
+
+#define TDX_GET_QUOTE_STRUCTURE_VERSION         1ULL
+
+#define TDX_VP_GET_QUOTE_SUCCESS                0ULL
+#define TDX_VP_GET_QUOTE_IN_FLIGHT              (-1ULL)
+#define TDX_VP_GET_QUOTE_ERROR                  0x8000000000000000ULL
+#define TDX_VP_GET_QUOTE_QGS_UNAVAILABLE        0x8000000000000001ULL
+
+/* Limit to avoid resource starvation. */
+#define TDX_GET_QUOTE_MAX_BUF_LEN       (128 * 1024)
+#define TDX_MAX_GET_QUOTE_REQUEST       16
+
+#define TDX_GET_QUOTE_HDR_SIZE          24
+
+/* Format of pages shared with guest. */
+struct tdx_get_quote_header {
+    /* Format version: must be 1 in little endian. */
+    uint64_t structure_version;
+
+    /*
+     * GetQuote status code in little endian:
+     *   Guest must set error_code to 0 to avoid information leak.
+     *   Qemu sets this before interrupting guest.
+     */
+    uint64_t error_code;
+
+    /*
+     * in-message size in little endian: The message will follow this header.
+     * The in-message will be send to QGS.
+     */
+    uint32_t in_len;
+
+    /*
+     * out-message size in little endian:
+     * On request, out_len must be zero to avoid information leak.
+     * On return, message size from QGS. Qemu overwrites this field.
+     * The message will follows this header.  The in-message is overwritten.
+     */
+    uint32_t out_len;
+
+    /*
+     * Message buffer follows.
+     * Guest sets message that will be send to QGS.  If out_len > in_len, guest
+     * should zero remaining buffer to avoid information leak.
+     * Qemu overwrites this buffer with a message returned from QGS.
+     */
+};
+
+typedef struct TdxGenerateQuoteTask {
+    hwaddr buf_gpa;
+    hwaddr payload_gpa;
+    uint64_t payload_len;
+
+    char *send_data;
+    uint64_t send_data_size;
+    uint64_t send_data_sent;
+
+    char *receive_buf;
+    uint64_t receive_buf_received;
+
+    uint64_t status_code;
+    struct tdx_get_quote_header hdr;
+
+    QIOChannelSocket *sioc;
+    guint watch;
+    QEMUTimer timer;
+
+    void (*completion)(struct TdxGenerateQuoteTask *task);
+    void *opaque;
+} TdxGenerateQuoteTask;
+
+void tdx_generate_quote(TdxGenerateQuoteTask *task, SocketAddress *qg_sock_addr);
+
+#endif /* QEMU_I386_TDX_QUOTE_GENERATOR_H */
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 0dd41d5811a..35a09c19c52 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -11,6 +11,8 @@
 #include "cpu.h"
 #include "hw/i386/tdvf.h"
 
+#include "tdx-quote-generator.h"
+
 #define TYPE_TDX_GUEST "tdx-guest"
 #define TDX_GUEST(obj)  OBJECT_CHECK(TdxGuest, (obj), TYPE_TDX_GUEST)
 
@@ -22,6 +24,7 @@ typedef struct TdxGuestClass {
 #define TDX_APIC_BUS_CYCLES_NS 40
 
 #define TDVMCALL_GET_TD_VM_CALL_INFO    0x10000
+#define TDVMCALL_GET_QUOTE		 0x10002
 
 #define TDG_VP_VMCALL_SUCCESS           0x0000000000000000ULL
 #define TDG_VP_VMCALL_RETRY             0x0000000000000001ULL
@@ -29,6 +32,8 @@ typedef struct TdxGuestClass {
 #define TDG_VP_VMCALL_GPA_INUSE         0x8000000000000001ULL
 #define TDG_VP_VMCALL_ALIGN_ERROR       0x8000000000000002ULL
 
+#define TDG_VP_VMCALL_SUBFUNC_GET_QUOTE 0x0000000000000001ULL
+
 enum TdxRamType {
     TDX_RAM_UNACCEPTED,
     TDX_RAM_ADDED,
@@ -57,6 +62,10 @@ typedef struct TdxGuest {
 
     uint32_t nr_ram_entries;
     TdxRamEntry *ram_entries;
+
+    /* GetQuote */
+    SocketAddress *qg_sock_addr;
+    int num;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
@@ -69,6 +78,7 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp);
 void tdx_set_tdvf_region(MemoryRegion *tdvf_mr);
 int tdx_parse_tdvf(void *flash_ptr, int size);
 int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run);
+void tdx_handle_get_quote(X86CPU *cpu, struct kvm_run *run);
 void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run);
 
 #endif /* QEMU_I386_TDX_H */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 8ef29fc1fb1..234878c613f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6176,6 +6176,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
          * does not handle the TDVMCALL.
          */
         switch (run->tdx.nr) {
+        case TDVMCALL_GET_QUOTE:
+            tdx_handle_get_quote(cpu, run);
+            break;
         case TDVMCALL_GET_TD_VM_CALL_INFO:
             tdx_handle_get_tdvmcall_info(cpu, run);
             break;
diff --git a/target/i386/kvm/tdx-quote-generator.c b/target/i386/kvm/tdx-quote-generator.c
new file mode 100644
index 00000000000..f59715f6175
--- /dev/null
+++ b/target/i386/kvm/tdx-quote-generator.c
@@ -0,0 +1,300 @@
+/*
+ * QEMU TDX Quote Generation Support
+ *
+ * Copyright (c) 2025 Intel Corporation
+ *
+ * Author:
+ *      Xiaoyao Li <xiaoyao.li@intel.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qapi/qapi-visit-sockets.h"
+
+#include "tdx-quote-generator.h"
+
+#define QGS_MSG_LIB_MAJOR_VER 1
+#define QGS_MSG_LIB_MINOR_VER 1
+
+typedef enum _qgs_msg_type_t {
+    GET_QUOTE_REQ = 0,
+    GET_QUOTE_RESP = 1,
+    GET_COLLATERAL_REQ = 2,
+    GET_COLLATERAL_RESP = 3,
+    GET_PLATFORM_INFO_REQ = 4,
+    GET_PLATFORM_INFO_RESP = 5,
+    QGS_MSG_TYPE_MAX
+} qgs_msg_type_t;
+
+typedef struct _qgs_msg_header_t {
+    uint16_t major_version;
+    uint16_t minor_version;
+    uint32_t type;
+    uint32_t size;              // size of the whole message, include this header, in byte
+    uint32_t error_code;        // used in response only
+} qgs_msg_header_t;
+
+typedef struct _qgs_msg_get_quote_req_t {
+    qgs_msg_header_t header;    // header.type = GET_QUOTE_REQ
+    uint32_t report_size;       // cannot be 0
+    uint32_t id_list_size;      // length of id_list, in byte, can be 0
+} qgs_msg_get_quote_req_t;
+
+typedef struct _qgs_msg_get_quote_resp_s {
+    qgs_msg_header_t header;    // header.type = GET_QUOTE_RESP
+    uint32_t selected_id_size;  // can be 0 in case only one id is sent in request
+    uint32_t quote_size;        // length of quote_data, in byte
+    uint8_t id_quote[];         // selected id followed by quote
+} qgs_msg_get_quote_resp_t;
+
+#define HEADER_SIZE 4
+
+static uint32_t decode_header(const char *buf, size_t len) {
+    if (len < HEADER_SIZE) {
+        return 0;
+    }
+    uint32_t msg_size = 0;
+    for (uint32_t i = 0; i < HEADER_SIZE; ++i) {
+        msg_size = msg_size * 256 + (buf[i] & 0xFF);
+    }
+    return msg_size;
+}
+
+static void encode_header(char *buf, size_t len, uint32_t size) {
+    assert(len >= HEADER_SIZE);
+    buf[0] = ((size >> 24) & 0xFF);
+    buf[1] = ((size >> 16) & 0xFF);
+    buf[2] = ((size >> 8) & 0xFF);
+    buf[3] = (size & 0xFF);
+}
+
+static void tdx_generate_quote_cleanup(TdxGenerateQuoteTask *task)
+{
+    timer_del(&task->timer);
+
+    g_source_remove(task->watch);
+    qio_channel_close(QIO_CHANNEL(task->sioc), NULL);
+    object_unref(OBJECT(task->sioc));
+
+    task->completion(task);
+}
+
+static gboolean tdx_get_quote_read(QIOChannel *ioc, GIOCondition condition,
+                                   gpointer opaque)
+{
+    TdxGenerateQuoteTask *task = opaque;
+    Error *err = NULL;
+    int ret;
+
+    ret = qio_channel_read(ioc, task->receive_buf + task->receive_buf_received,
+                           task->payload_len - task->receive_buf_received, &err);
+    if (ret < 0) {
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            return G_SOURCE_CONTINUE;
+        } else {
+            error_report_err(err);
+            task->status_code = TDX_VP_GET_QUOTE_ERROR;
+            goto end;
+        }
+    }
+
+    if (ret == 0) {
+        error_report("End of file before reply received");
+        task->status_code = TDX_VP_GET_QUOTE_ERROR;
+        goto end;
+    }
+
+    task->receive_buf_received += ret;
+    if (task->receive_buf_received >= HEADER_SIZE) {
+        uint32_t len = decode_header(task->receive_buf,
+                                     task->receive_buf_received);
+        if (len == 0 ||
+            len > (task->payload_len - HEADER_SIZE)) {
+            error_report("Message len %u must be non-zero & less than %zu",
+                         len, (task->payload_len - HEADER_SIZE));
+            task->status_code = TDX_VP_GET_QUOTE_ERROR;
+            goto end;
+        }
+
+        /* Now we know the size, shrink to fit */
+        task->payload_len = HEADER_SIZE + len;
+        task->receive_buf = g_renew(char,
+                                    task->receive_buf,
+                                    task->payload_len);
+    }
+
+    if (task->receive_buf_received >= (sizeof(qgs_msg_header_t) + HEADER_SIZE)) {
+        qgs_msg_header_t *hdr = (qgs_msg_header_t *)(task->receive_buf + HEADER_SIZE);
+        if (hdr->major_version != QGS_MSG_LIB_MAJOR_VER ||
+            hdr->minor_version != QGS_MSG_LIB_MINOR_VER) {
+            error_report("Invalid QGS message header version %d.%d",
+                         hdr->major_version,
+                         hdr->minor_version);
+            task->status_code = TDX_VP_GET_QUOTE_ERROR;
+            goto end;
+        }
+        if (hdr->type != GET_QUOTE_RESP) {
+            error_report("Invalid QGS message type %d",
+                         hdr->type);
+            task->status_code = TDX_VP_GET_QUOTE_ERROR;
+            goto end;
+        }
+        if (hdr->size > (task->payload_len - HEADER_SIZE)) {
+            error_report("QGS message size %d exceeds payload capacity %zu",
+                         hdr->size, task->payload_len);
+            task->status_code = TDX_VP_GET_QUOTE_ERROR;
+            goto end;
+        }
+        if (hdr->error_code != 0) {
+            error_report("QGS message error code %d",
+                         hdr->error_code);
+            task->status_code = TDX_VP_GET_QUOTE_ERROR;
+            goto end;
+        }
+    }
+    if (task->receive_buf_received >= (sizeof(qgs_msg_get_quote_resp_t) + HEADER_SIZE)) {
+        qgs_msg_get_quote_resp_t *msg = (qgs_msg_get_quote_resp_t *)(task->receive_buf + HEADER_SIZE);
+        if (msg->selected_id_size != 0) {
+            error_report("QGS message selected ID was %d not 0",
+                         msg->selected_id_size);
+            task->status_code = TDX_VP_GET_QUOTE_ERROR;
+            goto end;
+        }
+
+        if ((task->payload_len - HEADER_SIZE - sizeof(qgs_msg_get_quote_resp_t)) !=
+            msg->quote_size) {
+            error_report("QGS quote size %d should be %zu",
+                         msg->quote_size,
+                         (task->payload_len - sizeof(qgs_msg_get_quote_resp_t)));
+            task->status_code = TDX_VP_GET_QUOTE_ERROR;
+            goto end;
+        }
+    }
+
+    if (task->receive_buf_received == task->payload_len) {
+        size_t strip = HEADER_SIZE + sizeof(qgs_msg_get_quote_resp_t);
+        memmove(task->receive_buf,
+                task->receive_buf + strip,
+                task->receive_buf_received - strip);
+        task->receive_buf_received -= strip;
+        task->status_code = TDX_VP_GET_QUOTE_SUCCESS;
+        goto end;
+    }
+
+    return G_SOURCE_CONTINUE;
+
+end:
+    tdx_generate_quote_cleanup(task);
+    return G_SOURCE_REMOVE;
+}
+
+static gboolean tdx_send_report(QIOChannel *ioc, GIOCondition condition,
+                                gpointer opaque)
+{
+    TdxGenerateQuoteTask *task = opaque;
+    Error *err = NULL;
+    int ret;
+
+    ret = qio_channel_write(ioc, task->send_data + task->send_data_sent,
+                            task->send_data_size - task->send_data_sent, &err);
+    if (ret < 0) {
+        if (ret == QIO_CHANNEL_ERR_BLOCK) {
+            ret = 0;
+        } else {
+            error_report_err(err);
+            task->status_code = TDX_VP_GET_QUOTE_ERROR;
+            tdx_generate_quote_cleanup(task);
+            goto end;
+        }
+    }
+    task->send_data_sent += ret;
+
+    if (task->send_data_sent == task->send_data_size) {
+        task->watch = qio_channel_add_watch(QIO_CHANNEL(task->sioc), G_IO_IN,
+                                            tdx_get_quote_read, task, NULL);
+        goto end;
+    }
+
+    return G_SOURCE_CONTINUE;
+
+end:
+    return G_SOURCE_REMOVE;
+}
+
+static void tdx_quote_generator_connected(QIOTask *qio_task, gpointer opaque)
+{
+    TdxGenerateQuoteTask *task = opaque;
+    Error *err = NULL;
+    int ret;
+
+    ret = qio_task_propagate_error(qio_task, &err);
+    if (ret) {
+        error_report_err(err);
+        task->status_code = TDX_VP_GET_QUOTE_QGS_UNAVAILABLE;
+        tdx_generate_quote_cleanup(task);
+        return;
+    }
+
+    task->watch = qio_channel_add_watch(QIO_CHANNEL(task->sioc), G_IO_OUT,
+                                        tdx_send_report, task, NULL);
+}
+
+#define TRANSACTION_TIMEOUT 30000
+
+static void getquote_expired(void *opaque)
+{
+    TdxGenerateQuoteTask *task = opaque;
+
+    task->status_code = TDX_VP_GET_QUOTE_ERROR;
+    tdx_generate_quote_cleanup(task);
+}
+
+static void setup_get_quote_timer(TdxGenerateQuoteTask *task)
+{
+    int64_t time;
+
+    timer_init_ms(&task->timer, QEMU_CLOCK_VIRTUAL, getquote_expired, task);
+    time = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    timer_mod(&task->timer, time + TRANSACTION_TIMEOUT);
+}
+
+void tdx_generate_quote(TdxGenerateQuoteTask *task,
+                        SocketAddress *qg_sock_addr)
+{
+    QIOChannelSocket *sioc;
+    qgs_msg_get_quote_req_t msg;
+
+    /* Prepare a QGS message prelude */
+    msg.header.major_version = QGS_MSG_LIB_MAJOR_VER;
+    msg.header.minor_version = QGS_MSG_LIB_MINOR_VER;
+    msg.header.type = GET_QUOTE_REQ;
+    msg.header.size = sizeof(msg) + task->send_data_size;
+    msg.header.error_code = 0;
+    msg.report_size = task->send_data_size;
+    msg.id_list_size = 0;
+
+    /* Make room to add the QGS message prelude */
+    task->send_data = g_renew(char,
+                              task->send_data,
+                              task->send_data_size + sizeof(msg) + HEADER_SIZE);
+    memmove(task->send_data + sizeof(msg) + HEADER_SIZE,
+            task->send_data,
+            task->send_data_size);
+    memcpy(task->send_data + HEADER_SIZE,
+           &msg,
+           sizeof(msg));
+    encode_header(task->send_data, HEADER_SIZE, task->send_data_size + sizeof(msg));
+    task->send_data_size += sizeof(msg) + HEADER_SIZE;
+
+    sioc = qio_channel_socket_new();
+    task->sioc = sioc;
+
+    setup_get_quote_timer(task);
+
+    qio_channel_socket_connect_async(sioc, qg_sock_addr,
+                                     tdx_quote_generator_connected, task,
+                                     NULL, NULL);
+}
diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
index 62a12a06775..76fee49eff0 100644
--- a/target/i386/kvm/tdx-stub.c
+++ b/target/i386/kvm/tdx-stub.c
@@ -19,6 +19,10 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
     return -EINVAL;
 }
 
+void tdx_handle_get_quote(X86CPU *cpu, struct kvm_run *run)
+{
+}
+
 void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
 {
 }
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index ef10a193474..e809e4b2dfa 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -14,12 +14,14 @@
 #include "qemu/base64.h"
 #include "qemu/mmap-alloc.h"
 #include "qapi/error.h"
+#include "qapi/qapi-visit-sockets.h"
 #include "qom/object_interfaces.h"
 #include "crypto/hash.h"
 #include "system/kvm_int.h"
 #include "system/runstate.h"
 #include "system/system.h"
 #include "system/ramblock.h"
+#include "system/address-spaces.h"
 
 #include <linux/kvm_para.h>
 
@@ -32,6 +34,7 @@
 #include "hw/i386/tdvf-hob.h"
 #include "kvm_i386.h"
 #include "tdx.h"
+#include "tdx-quote-generator.h"
 
 #include "standard-headers/asm-x86/kvm_para.h"
 
@@ -1120,13 +1123,146 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
     return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
 }
 
+static void tdx_get_quote_completion(TdxGenerateQuoteTask *task)
+{
+    TdxGuest *tdx = task->opaque;
+    int ret;
+
+    /* Maintain the number of in-flight requests. */
+    qemu_mutex_lock(&tdx->lock);
+    tdx->num--;
+    qemu_mutex_unlock(&tdx->lock);
+
+    if (task->status_code == TDX_VP_GET_QUOTE_SUCCESS) {
+        ret = address_space_write(&address_space_memory, task->payload_gpa,
+                                  MEMTXATTRS_UNSPECIFIED, task->receive_buf,
+                                  task->receive_buf_received);
+        if (ret != MEMTX_OK) {
+            error_report("TDX: get-quote: failed to write quote data.");
+        } else {
+            task->hdr.out_len = cpu_to_le64(task->receive_buf_received);
+        }
+    }
+    task->hdr.error_code = cpu_to_le64(task->status_code);
+
+    /* Publish the response contents before marking this request completed. */
+    smp_wmb();
+    ret = address_space_write(&address_space_memory, task->buf_gpa,
+                              MEMTXATTRS_UNSPECIFIED, &task->hdr,
+                              TDX_GET_QUOTE_HDR_SIZE);
+    if (ret != MEMTX_OK) {
+        error_report("TDX: get-quote: failed to update GetQuote header.");
+    }
+
+    g_free(task->send_data);
+    g_free(task->receive_buf);
+    g_free(task);
+    object_unref(tdx);
+}
+
+void tdx_handle_get_quote(X86CPU *cpu, struct kvm_run *run)
+{
+    TdxGenerateQuoteTask *task;
+    struct tdx_get_quote_header hdr;
+    hwaddr buf_gpa = run->tdx.get_quote.gpa;
+    uint64_t buf_len = run->tdx.get_quote.size;
+
+    QEMU_BUILD_BUG_ON(sizeof(struct tdx_get_quote_header) != TDX_GET_QUOTE_HDR_SIZE);
+
+    run->tdx.get_quote.ret = TDG_VP_VMCALL_INVALID_OPERAND;
+
+    if (buf_len == 0) {
+        return;
+    }
+
+    if (!QEMU_IS_ALIGNED(buf_gpa, 4096) || !QEMU_IS_ALIGNED(buf_len, 4096)) {
+        run->tdx.get_quote.ret = TDG_VP_VMCALL_ALIGN_ERROR;
+        return;
+    }
+
+    if (address_space_read(&address_space_memory, buf_gpa, MEMTXATTRS_UNSPECIFIED,
+                           &hdr, TDX_GET_QUOTE_HDR_SIZE) != MEMTX_OK) {
+        error_report("TDX: get-quote: failed to read GetQuote header.");
+        return;
+    }
+
+    if (le64_to_cpu(hdr.structure_version) != TDX_GET_QUOTE_STRUCTURE_VERSION) {
+        return;
+    }
+
+    /* Only safe-guard check to avoid too large buffer size. */
+    if (buf_len > TDX_GET_QUOTE_MAX_BUF_LEN ||
+        le32_to_cpu(hdr.in_len) > buf_len - TDX_GET_QUOTE_HDR_SIZE) {
+        return;
+    }
+
+    if (!tdx_guest->qg_sock_addr) {
+        hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_QGS_UNAVAILABLE);
+        if (address_space_write(&address_space_memory, buf_gpa,
+                                MEMTXATTRS_UNSPECIFIED,
+                                &hdr, TDX_GET_QUOTE_HDR_SIZE) != MEMTX_OK) {
+            error_report("TDX: failed to update GetQuote header.");
+            return;
+        }
+        run->tdx.get_quote.ret = TDG_VP_VMCALL_SUCCESS;
+        return;
+    }
+
+    qemu_mutex_lock(&tdx_guest->lock);
+    if (tdx_guest->num >= TDX_MAX_GET_QUOTE_REQUEST) {
+        qemu_mutex_unlock(&tdx_guest->lock);
+        run->tdx.get_quote.ret = TDG_VP_VMCALL_RETRY;
+        return;
+    }
+    tdx_guest->num++;
+    qemu_mutex_unlock(&tdx_guest->lock);
+
+    task = g_new(TdxGenerateQuoteTask, 1);
+    task->buf_gpa = buf_gpa;
+    task->payload_gpa = buf_gpa + TDX_GET_QUOTE_HDR_SIZE;
+    task->payload_len = buf_len - TDX_GET_QUOTE_HDR_SIZE;
+    task->hdr = hdr;
+    task->completion = tdx_get_quote_completion;
+
+    task->send_data_size = le32_to_cpu(hdr.in_len);
+    task->send_data = g_malloc(task->send_data_size);
+    task->send_data_sent = 0;
+
+    if (address_space_read(&address_space_memory, task->payload_gpa,
+                           MEMTXATTRS_UNSPECIFIED, task->send_data,
+                           task->send_data_size) != MEMTX_OK) {
+        goto out_free;
+    }
+
+    /* Mark the buffer in-flight. */
+    hdr.error_code = cpu_to_le64(TDX_VP_GET_QUOTE_IN_FLIGHT);
+    if (address_space_write(&address_space_memory, buf_gpa,
+                            MEMTXATTRS_UNSPECIFIED,
+                            &hdr, TDX_GET_QUOTE_HDR_SIZE) != MEMTX_OK) {
+        goto out_free;
+    }
+
+    task->receive_buf = g_malloc0(task->payload_len);
+    task->receive_buf_received = 0;
+    task->opaque = tdx_guest;
+
+    object_ref(tdx_guest);
+    tdx_generate_quote(task, tdx_guest->qg_sock_addr);
+    run->tdx.get_quote.ret = TDG_VP_VMCALL_SUCCESS;
+    return;
+
+out_free:
+    g_free(task->send_data);
+    g_free(task);
+}
+
 void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
 {
     if (run->tdx.get_tdvmcall_info.leaf != 1) {
 	return;
     }
 
-    run->tdx.get_tdvmcall_info.r11 = 0;
+    run->tdx.get_tdvmcall_info.r11 = TDG_VP_VMCALL_SUBFUNC_GET_QUOTE;
     run->tdx.get_tdvmcall_info.r12 = 0;
     run->tdx.get_tdvmcall_info.r13 = 0;
     run->tdx.get_tdvmcall_info.r14 = 0;
@@ -1263,6 +1399,37 @@ static void tdx_guest_set_mrownerconfig(Object *obj, const char *value, Error **
     tdx->mrownerconfig = g_strdup(value);
 }
 
+static void tdx_guest_get_qgs(Object *obj, Visitor *v,
+                              const char *name, void *opaque,
+                              Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+
+    if (!tdx->qg_sock_addr) {
+        error_setg(errp, "quote-generation-socket is not set");
+        return;
+    }
+    visit_type_SocketAddress(v, name, &tdx->qg_sock_addr, errp);
+}
+
+static void tdx_guest_set_qgs(Object *obj, Visitor *v,
+                              const char *name, void *opaque,
+                              Error **errp)
+{
+    TdxGuest *tdx = TDX_GUEST(obj);
+    SocketAddress *sock = NULL;
+
+    if (!visit_type_SocketAddress(v, name, &sock, errp)) {
+        return;
+    }
+
+    if (tdx->qg_sock_addr) {
+        qapi_free_SocketAddress(tdx->qg_sock_addr);
+    }
+
+    tdx->qg_sock_addr = sock;
+}
+
 /* tdx guest */
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(TdxGuest,
                                    tdx_guest,
@@ -1294,6 +1461,13 @@ static void tdx_guest_init(Object *obj)
     object_property_add_str(obj, "mrownerconfig",
                             tdx_guest_get_mrownerconfig,
                             tdx_guest_set_mrownerconfig);
+
+    object_property_add(obj, "quote-generation-socket", "SocketAddress",
+                            tdx_guest_get_qgs,
+                            tdx_guest_set_qgs,
+                            NULL, NULL);
+
+    qemu_mutex_init(&tdx->lock);
 }
 
 static void tdx_guest_finalize(Object *obj)
diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
index 3f44cdedb75..2675bf89027 100644
--- a/target/i386/kvm/meson.build
+++ b/target/i386/kvm/meson.build
@@ -8,7 +8,7 @@ i386_kvm_ss.add(files(
 
 i386_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
 
-i386_kvm_ss.add(when: 'CONFIG_TDX', if_true: files('tdx.c'), if_false: files('tdx-stub.c'))
+i386_kvm_ss.add(when: 'CONFIG_TDX', if_true: files('tdx.c', 'tdx-quote-generator.c'), if_false: files('tdx-stub.c'))
 
 i386_system_ss.add(when: 'CONFIG_HYPERV', if_true: files('hyperv.c'), if_false: files('hyperv-stub.c'))
 
-- 
2.49.0


