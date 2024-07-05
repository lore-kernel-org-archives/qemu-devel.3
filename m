Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A32C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 18:30:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPnge-00040T-IN; Fri, 05 Jul 2024 14:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sPngZ-0003qg-SN
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 14:29:32 -0400
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sPngS-0006xP-Lh
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 14:29:31 -0400
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b5eb69e04cso11083726d6.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720204162; x=1720808962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9DurkwrUL923+nQ+sm0eRKDreSAPJ+7okeaR/Wthn40=;
 b=aMMokBz002K5z4wU/PddqcdvB2L4zoZBdzZ52nWMrWvpSs9s4HmwItIic0+e9dazX1
 GM+AwamEB99YFKBAGyN4jwxSUTb+E7/SkqhzIkgv3OFYDE7UrQg1E2gld+Chxn8XS60R
 UOQ4UxJ9NIKeXolJL32Qn38fTZjwTGrb3lbT+sMieQv0Z1iltH+6w4VYZwf7GW7HbPBE
 V5wERcDIrHBvCPHw5PWc+XJ34YVYFSkA5knNKaeaDiRIyb+sFdy7efaPRnhPjYjL0PPv
 WR1QG25AnPCHyrQF/VZBE2ED+puChWzf7UbzyvjRQ3ybNiO/xfpq5DOKINQqcO63Ih0e
 TYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720204162; x=1720808962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9DurkwrUL923+nQ+sm0eRKDreSAPJ+7okeaR/Wthn40=;
 b=P872JL4E95YfDMoSMHlrl7o/gQCiQWITshGyjE0lQ5nMT9vuFJYHSOW4q/+yfz7H9T
 PNlFyZPMBxLwhGavKw9IOjQODUTKS46q5V0YHOJKaxbzTvM8cgYgGoRJ3jFb06IjK7Fg
 K7p4e+F2g1200GihbQK1VNG02vx7Tf+spcVvXBv8Fr2cz1wRPDFOtiCzXfEPUlEVOn+D
 RFirHWTgD+vuUa0q4o9v85kacS8+8eL3okBuyCN71jYNq6aR3efT84Dfuda7hl7vkyGn
 LtBJ/YjWUAL5jrLaTYHRqZ0f2ksgRhjjlfboCQMUtvY8e0jbAIS3ReE29d9ZcQDn+Xjx
 AmkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZD1lc9WcahwDhxRs6aAwy0h7WflYKNpmRyoOn3ZmJIkH7BxofgzsqK2HLI1SCP2N7Yf9sPDw2l3fqrm1rml61RyVFizU=
X-Gm-Message-State: AOJu0YxJ7oWY/B1ASP7ThA7n1zU/eNzcVcG5lD+SGzWMwb5PG2T1LCun
 zCENaU2jEdJGCUV/skopKiKWM4hM/Tt6NC9OcQQYzZepDLxoQDZvzEAIryn6Zxg=
X-Google-Smtp-Source: AGHT+IEiz/x8KmS0Olk7V6bCtGA1AkTmQKRkgRUHLMYgSE8Nk9IL5/pidxF/iGmSasrnWDCS7zlL+g==
X-Received: by 2002:a05:6214:5089:b0:6b4:fd84:1cdf with SMTP id
 6a1803df08f44-6b5ecfa1483mr62273396d6.18.1720204162370; 
 Fri, 05 Jul 2024 11:29:22 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net
 (ec2-54-152-246-50.compute-1.amazonaws.com. [54.152.246.50])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b5fb7e316esm4972936d6.30.2024.07.05.11.29.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 11:29:21 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v4 3/4] migration: Introduce 'qatzip' compression method
Date: Fri,  5 Jul 2024 11:29:00 -0700
Message-Id: <20240705182901.48948-4-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240705182901.48948-1-yichen.wang@bytedance.com>
References: <20240705182901.48948-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f34;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Bryan Zhang <bryan.zhang@bytedance.com>

Adds support for 'qatzip' as an option for the multifd compression
method parameter, and implements using QAT for 'qatzip' compression and
decompression.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
---
 hw/core/qdev-properties-system.c |   6 +-
 migration/meson.build            |   1 +
 migration/multifd-qatzip.c       | 391 +++++++++++++++++++++++++++++++
 migration/multifd.h              |   5 +-
 qapi/migration.json              |   3 +
 tests/qtest/meson.build          |   4 +
 6 files changed, 407 insertions(+), 3 deletions(-)
 create mode 100644 migration/multifd-qatzip.c

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index f13350b4fb..eb50d6ec5b 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -659,7 +659,11 @@ const PropertyInfo qdev_prop_fdc_drive_type = {
 const PropertyInfo qdev_prop_multifd_compression = {
     .name = "MultiFDCompression",
     .description = "multifd_compression values, "
-                   "none/zlib/zstd/qpl/uadk",
+                   "none/zlib/zstd/qpl/uadk"
+#ifdef CONFIG_QATZIP
+                   "/qatzip"
+#endif
+                   ,
     .enum_table = &MultiFDCompression_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
diff --git a/migration/meson.build b/migration/meson.build
index 5ce2acb41e..c9454c26ae 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -41,6 +41,7 @@ system_ss.add(when: rdma, if_true: files('rdma.c'))
 system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
 system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
 system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
+system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
                 if_true: files('ram.c',
diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
new file mode 100644
index 0000000000..a1502a5589
--- /dev/null
+++ b/migration/multifd-qatzip.c
@@ -0,0 +1,391 @@
+/*
+ * Multifd QATzip compression implementation
+ *
+ * Copyright (c) Bytedance
+ *
+ * Authors:
+ *  Bryan Zhang <bryan.zhang@bytedance.com>
+ *  Hao Xiang <hao.xiang@bytedance.com>
+ *  Yichen Wang <yichen.wang@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "exec/ramblock.h"
+#include "exec/target_page.h"
+#include "qapi/error.h"
+#include "migration.h"
+#include "options.h"
+#include "multifd.h"
+#include <qatzip.h>
+
+struct qatzip_data {
+    /*
+     * Unique session for use with QATzip API
+     */
+    QzSession_T sess;
+
+    /*
+     * For compression: Buffer for pages to compress
+     * For decompression: Buffer for data to decompress
+     */
+    uint8_t *in_buf;
+    uint32_t in_len;
+
+    /*
+     * For compression: Output buffer of compressed data
+     * For decompression: Output buffer of decompressed data
+     */
+    uint8_t *out_buf;
+    uint32_t out_len;
+};
+
+/**
+ * qatzip_send_setup: Set up QATzip session and private buffers.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     0 on success, -1 on error (and *errp will be set)
+ */
+static int qatzip_send_setup(MultiFDSendParams *p, Error **errp)
+{
+    struct qatzip_data *q;
+    QzSessionParamsDeflate_T params;
+    const char *err_msg;
+    int ret;
+    int sw_fallback;
+
+    q = g_new0(struct qatzip_data, 1);
+    p->compress_data = q;
+    /* We need one extra place for the packet header */
+    p->iov = g_new0(struct iovec, 2);
+
+    sw_fallback = 0;
+    if (migrate_multifd_qatzip_sw_fallback()) {
+        sw_fallback = 1;
+    }
+
+    ret = qzInit(&q->sess, sw_fallback);
+    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+        err_msg = "qzInit failed";
+        goto err_free_q;
+    }
+
+    ret = qzGetDefaultsDeflate(&params);
+    if (ret != QZ_OK) {
+        err_msg = "qzGetDefaultsDeflate failed";
+        goto err_close;
+    }
+
+    /* Make sure to use configured QATzip compression level. */
+    params.common_params.comp_lvl = migrate_multifd_qatzip_level();
+
+    ret = qzSetupSessionDeflate(&q->sess, &params);
+    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+        err_msg = "qzSetupSessionDeflate failed";
+        goto err_close;
+    }
+
+    /* TODO Add support for larger packets. */
+    if (MULTIFD_PACKET_SIZE > UINT32_MAX) {
+        err_msg = "packet size too large for QAT";
+        goto err_close;
+    }
+
+    q->in_len = MULTIFD_PACKET_SIZE;
+    q->in_buf = qzMalloc(q->in_len, 0, PINNED_MEM);
+    if (!q->in_buf) {
+        err_msg = "qzMalloc failed";
+        goto err_close;
+    }
+
+    q->out_len = qzMaxCompressedLength(MULTIFD_PACKET_SIZE, &q->sess);
+    q->out_buf = qzMalloc(q->out_len, 0, PINNED_MEM);
+    if (!q->out_buf) {
+        err_msg = "qzMalloc failed";
+        goto err_free_inbuf;
+    }
+
+    return 0;
+
+err_free_inbuf:
+    qzFree(q->in_buf);
+err_close:
+    qzClose(&q->sess);
+err_free_q:
+    g_free(q);
+    g_free(p->iov);
+    p->iov = NULL;
+    error_setg(errp, "multifd %u: %s", p->id, err_msg);
+    return -1;
+}
+
+/**
+ * qatzip_send_cleanup: Tear down QATzip session and release private buffers.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     None
+ */
+static void qatzip_send_cleanup(MultiFDSendParams *p, Error **errp)
+{
+    struct qatzip_data *q = p->compress_data;
+    const char *err_msg;
+    int ret;
+
+    ret = qzTeardownSession(&q->sess);
+    if (ret != QZ_OK) {
+        err_msg = "qzTeardownSession failed";
+        goto err;
+    }
+
+    ret = qzClose(&q->sess);
+    if (ret != QZ_OK) {
+        err_msg = "qzClose failed";
+        goto err;
+    }
+
+    qzFree(q->in_buf);
+    q->in_buf = NULL;
+    qzFree(q->out_buf);
+    q->out_buf = NULL;
+    g_free(p->iov);
+    p->iov = NULL;
+    g_free(p->compress_data);
+    p->compress_data = NULL;
+    return;
+
+err:
+    error_setg(errp, "multifd %u: %s", p->id, err_msg);
+}
+
+/**
+ * qatzip_send_prepare: Compress pages and update IO channel info.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     0 on success, -1 on error (and *errp will be set)
+ */
+static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
+{
+    MultiFDPages_t *pages = p->pages;
+    struct qatzip_data *q = p->compress_data;
+    int ret;
+    unsigned int in_len, out_len;
+
+    if (!multifd_send_prepare_common(p)) {
+        goto out;
+    }
+
+    /* memcpy all the pages into one buffer. */
+    for (int i = 0; i < pages->normal_num; i++) {
+        memcpy(q->in_buf + (i * p->page_size),
+               p->pages->block->host + pages->offset[i],
+               p->page_size);
+    }
+
+    in_len = pages->normal_num * p->page_size;
+    if (in_len > q->in_len) {
+        error_setg(errp, "multifd %u: unexpectedly large input", p->id);
+        return -1;
+    }
+    out_len = q->out_len;
+
+    /*
+     * Unlike other multifd compression implementations, we use a non-streaming
+     * API and place all the data into one buffer, rather than sending each page
+     * to the compression API at a time. Based on initial benchmarks, the
+     * non-streaming API outperforms the streaming API. Plus, the logic in QEMU
+     * is friendly to using the non-streaming API anyway. If either of these
+     * statements becomes no longer true, we can revisit adding a streaming
+     * implementation.
+     */
+    ret = qzCompress(&q->sess, q->in_buf, &in_len, q->out_buf, &out_len, 1);
+    if (ret != QZ_OK) {
+        error_setg(errp, "multifd %u: QATzip returned %d instead of QZ_OK",
+                   p->id, ret);
+        return -1;
+    }
+    if (in_len != pages->normal_num * p->page_size) {
+        error_setg(errp, "multifd %u: QATzip failed to compress all input",
+                   p->id);
+        return -1;
+    }
+
+    p->iov[p->iovs_num].iov_base = q->out_buf;
+    p->iov[p->iovs_num].iov_len = out_len;
+    p->iovs_num++;
+    p->next_packet_size = out_len;
+
+out:
+    p->flags |= MULTIFD_FLAG_QATZIP;
+    multifd_send_fill_packet(p);
+    return 0;
+}
+
+/**
+ * qatzip_recv_setup: Set up QATzip session and allocate private buffers.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     0 on success, -1 on error (and *errp will be set)
+ */
+static int qatzip_recv_setup(MultiFDRecvParams *p, Error **errp)
+{
+    struct qatzip_data *q;
+    QzSessionParamsDeflate_T params;
+    const char *err_msg;
+    int ret;
+    int sw_fallback;
+
+    q = g_new0(struct qatzip_data, 1);
+    p->compress_data = q;
+
+    sw_fallback = 0;
+    if (migrate_multifd_qatzip_sw_fallback()) {
+        sw_fallback = 1;
+    }
+
+    ret = qzInit(&q->sess, sw_fallback);
+    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+        err_msg = "qzInit failed";
+        goto err_free_q;
+    }
+
+    ret = qzGetDefaultsDeflate(&params);
+    if (ret != QZ_OK) {
+        err_msg = "qzGetDefaultsDeflate failed";
+        goto err_close;
+    }
+
+    /* Make sure to use configured QATzip compression level. */
+    params.common_params.comp_lvl = migrate_multifd_qatzip_level();
+
+    ret = qzSetupSessionDeflate(&q->sess, &params);
+    if (ret != QZ_OK && ret != QZ_DUPLICATE) {
+        err_msg = "qzSetupSessionDeflate failed";
+        goto err_close;
+    }
+
+    /*
+     * Mimic multifd-zlib, which reserves extra space for the
+     * incoming packet.
+     */
+    q->in_len = MULTIFD_PACKET_SIZE * 2;
+    q->in_buf = qzMalloc(q->in_len, 0, PINNED_MEM);
+    if (!q->in_buf) {
+        err_msg = "qzMalloc failed";
+        goto err_close;
+    }
+
+    q->out_len = MULTIFD_PACKET_SIZE;
+    q->out_buf = qzMalloc(q->out_len, 0, PINNED_MEM);
+    if (!q->out_buf) {
+        err_msg = "qzMalloc failed";
+        goto err_free_inbuf;
+    }
+
+    return 0;
+
+err_free_inbuf:
+    qzFree(q->in_buf);
+err_close:
+    qzClose(&q->sess);
+err_free_q:
+    g_free(q);
+    error_setg(errp, "multifd %u: %s", p->id, err_msg);
+    return -1;
+}
+
+/**
+ * qatzip_recv_cleanup: Tear down QATzip session and release private buffers.
+ *
+ * @param p    Multifd channel params
+ * @return     None
+ */
+static void qatzip_recv_cleanup(MultiFDRecvParams *p)
+{
+    struct qatzip_data *q = p->compress_data;
+
+    /* Ignoring return values here due to function signature. */
+    qzTeardownSession(&q->sess);
+    qzClose(&q->sess);
+    qzFree(q->in_buf);
+    qzFree(q->out_buf);
+    g_free(p->compress_data);
+}
+
+
+/**
+ * qatzip_recv: Decompress pages and copy them to the appropriate
+ * locations.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     0 on success, -1 on error (and *errp will be set)
+ */
+static int qatzip_recv(MultiFDRecvParams *p, Error **errp)
+{
+    struct qatzip_data *q = p->compress_data;
+    int ret;
+    unsigned int in_len, out_len;
+    uint32_t in_size = p->next_packet_size;
+    uint32_t expected_size = p->normal_num * p->page_size;
+    uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
+
+    if (in_size > q->in_len) {
+        error_setg(errp, "multifd %u: received unexpectedly large packet",
+                   p->id);
+        return -1;
+    }
+
+    if (flags != MULTIFD_FLAG_QATZIP) {
+        error_setg(errp, "multifd %u: flags received %x flags expected %x",
+                   p->id, flags, MULTIFD_FLAG_QATZIP);
+        return -1;
+    }
+
+    ret = qio_channel_read_all(p->c, (void *)q->in_buf, in_size, errp);
+    if (ret != 0) {
+        return ret;
+    }
+
+    in_len = in_size;
+    out_len = q->out_len;
+    ret = qzDecompress(&q->sess, q->in_buf, &in_len, q->out_buf, &out_len);
+    if (ret != QZ_OK) {
+        error_setg(errp, "multifd %u: qzDecompress failed", p->id);
+        return -1;
+    }
+    if (out_len != expected_size) {
+        error_setg(errp, "multifd %u: packet size received %u size expected %u",
+                   p->id, out_len, expected_size);
+        return -1;
+    }
+
+    /* Copy each page to its appropriate location. */
+    for (int i = 0; i < p->normal_num; i++) {
+        memcpy(p->host + p->normal[i],
+               q->out_buf + p->page_size * i,
+               p->page_size);
+    }
+    return 0;
+}
+
+static MultiFDMethods multifd_qatzip_ops = {
+    .send_setup = qatzip_send_setup,
+    .send_cleanup = qatzip_send_cleanup,
+    .send_prepare = qatzip_send_prepare,
+    .recv_setup = qatzip_recv_setup,
+    .recv_cleanup = qatzip_recv_cleanup,
+    .recv = qatzip_recv
+};
+
+static void multifd_qatzip_register(void)
+{
+    multifd_register_ops(MULTIFD_COMPRESSION_QATZIP, &multifd_qatzip_ops);
+}
+
+migration_init(multifd_qatzip_register);
diff --git a/migration/multifd.h b/migration/multifd.h
index 0ecd6f47d7..adceb65050 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -34,14 +34,15 @@ MultiFDRecvData *multifd_get_recv_data(void);
 /* Multifd Compression flags */
 #define MULTIFD_FLAG_SYNC (1 << 0)
 
-/* We reserve 4 bits for compression methods */
-#define MULTIFD_FLAG_COMPRESSION_MASK (0xf << 1)
+/* We reserve 5 bits for compression methods */
+#define MULTIFD_FLAG_COMPRESSION_MASK (0x1f << 1)
 /* we need to be compatible. Before compression value was 0 */
 #define MULTIFD_FLAG_NOCOMP (0 << 1)
 #define MULTIFD_FLAG_ZLIB (1 << 1)
 #define MULTIFD_FLAG_ZSTD (2 << 1)
 #define MULTIFD_FLAG_QPL (4 << 1)
 #define MULTIFD_FLAG_UADK (8 << 1)
+#define MULTIFD_FLAG_QATZIP (16 << 1)
 
 /* This value needs to be a multiple of qemu_target_page_size() */
 #define MULTIFD_PACKET_SIZE (512 * 1024)
diff --git a/qapi/migration.json b/qapi/migration.json
index 8c9f2a8aa7..ea62f983b1 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -558,6 +558,8 @@
 #
 # @zstd: use zstd compression method.
 #
+# @qatzip: use qatzip compression method. (Since 9.1)
+#
 # @qpl: use qpl compression method.  Query Processing Library(qpl) is
 #       based on the deflate compression algorithm and use the Intel
 #       In-Memory Analytics Accelerator(IAA) accelerated compression
@@ -570,6 +572,7 @@
 { 'enum': 'MultiFDCompression',
   'data': [ 'none', 'zlib',
             { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
+            { 'name': 'qatzip', 'if': 'CONFIG_QATZIP'},
             { 'name': 'qpl', 'if': 'CONFIG_QPL' },
             { 'name': 'uadk', 'if': 'CONFIG_UADK' } ] }
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 12792948ff..23e46144d7 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -324,6 +324,10 @@ if gnutls.found()
   endif
 endif
 
+if qatzip.found()
+  migration_files += [qatzip]
+endif
+
 qtests = {
   'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
   'cdrom-test': files('boot-sector.c'),
-- 
Yichen Wang


