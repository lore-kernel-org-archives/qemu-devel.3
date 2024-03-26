Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B68C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 22:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpFWN-0006B1-JN; Tue, 26 Mar 2024 18:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rpFWM-0006Aj-DY
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 18:43:54 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rpFWJ-0007cB-DX
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 18:43:54 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-789fb1f80f5so405917285a.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 15:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1711493030; x=1712097830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVEzA2HQOLvutvBo/VheWIkAEa4Jjb54H0+Qgm8hF1A=;
 b=dWPrwruukYZbPu0dbg/zL9qWyqiBp+NRUu6ZDl5HVFIn4f9ragBkNY5V86MB8Mh5rm
 LLFWPFej38FSiP9apxTdx758YumuR8nna0r769/80OWgAJ/mCWazOPjpCFvnh0o+aMbz
 //eFVk1OqUtCk0n+jr1wtp2c6qG7aChYSN3iH/xqfdAuLT3c+E0PO79q38oL1meYFbUw
 6d1JnPeRrQHkkzziMqXB/Q2K6fXCl2BgRGb2QVhmRZi1Utd/7WAv7AGoTl/+lqZGp0Sk
 ZobEhl2hrGzXUUE+8PTIE8T1IlGIoHo3HpTqJ803jvlEE4PhBtLIvjOcKNl2JadE1RRL
 pLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711493030; x=1712097830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GVEzA2HQOLvutvBo/VheWIkAEa4Jjb54H0+Qgm8hF1A=;
 b=Fc+785XLEJ7oKhBR6/6kvhDKHzW2O3z52oRsmHSuerlzq2NOeVs6OzwKtJb1+5GvDF
 EnpR0A6t2qkVo/2vkemiOJBOksTBAXRFAbAB52k1oNkhlL1FcqRlUOfXCcamNymAMbUu
 CsFxZr/HKkPqFEm82UNR4Myys6K/V961XvH/WTpheFPSR2gjVXN1WziUSUAB0GfoZUcT
 OtB5OgmqxPMYL3zN0GQYGyiwfFM7dMz+Wjd3kXx2ghWfc+DWtLzHTgwOcCWtYr/rkctG
 l9uC8b6vLSjVb6RTTWdtPNGKZg1BN7jwOY0lnkw/U8HqOryaIgoN3W5rQdu3axbiwz2Z
 M22w==
X-Gm-Message-State: AOJu0YyQzYksNSiF232Rui5qZ2Ah1J/O3PqMdlfnMoMlgvB0oqWR/dQe
 ePmLf+UbOfyq/MrJ/K4zczCcIwXFt60da8IR75oFQ87haxEWvMqs7KUqPOrafsAtW+LMr3OnOOK
 5
X-Google-Smtp-Source: AGHT+IFaGRnvBhZzGDKiaiooinL3258ntccbXK/LzfwnmLaO6BDU2D0xXANtPkck1hoef0nyjEAH1g==
X-Received: by 2002:a05:620a:6207:b0:78a:3913:549 with SMTP id
 ou7-20020a05620a620700b0078a39130549mr10392570qkn.65.1711493030218; 
 Tue, 26 Mar 2024 15:43:50 -0700 (PDT)
Received: from n36-186-108.byted.org. ([147.160.184.146])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a05620a0ecf00b007887d30dbb7sm3397816qkm.60.2024.03.26.15.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 15:43:49 -0700 (PDT)
From: Bryan Zhang <bryan.zhang@bytedance.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, yuan1.liu@intel.com,
 berrange@redhat.com, nanhai.zou@intel.com, hao.xiang@linux.dev,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v2 4/5] migration: Implement 'qatzip' methods using QAT
Date: Tue, 26 Mar 2024 22:42:20 +0000
Message-Id: <20240326224221.3623014-5-bryan.zhang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240326224221.3623014-1-bryan.zhang@bytedance.com>
References: <20240326224221.3623014-1-bryan.zhang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=bryan.zhang@bytedance.com; helo=mail-qk1-x731.google.com
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

Uses QAT to offload deflate compression and decompression in the
'qatzip' compression method for multifd migration.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
---
 migration/multifd-qatzip.c | 331 +++++++++++++++++++++++++++++++++----
 1 file changed, 298 insertions(+), 33 deletions(-)

diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
index f66336a4a7..13835cf76f 100644
--- a/migration/multifd-qatzip.c
+++ b/migration/multifd-qatzip.c
@@ -18,86 +18,351 @@
 #include "migration.h"
 #include "options.h"
 #include "multifd.h"
+#include <qatzip.h>
 
-/*
- * This is an intermediary file to introduce 'qatzip' as an option for multifd
- * compression. The actual method implementations are no-ops.
- */
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
 static int qatzip_send_setup(MultiFDSendParams *p, Error **errp)
 {
-    if (migrate_zero_copy_send()) {
-        p->write_flags |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
+    struct qatzip_data *q;
+    QzSessionParamsDeflate_T params;
+    const char *err_msg;
+    int ret;
+    int sw_fallback;
+
+    q = g_new0(struct qatzip_data, 1);
+    p->data = q;
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
     }
 
     return 0;
+
+err_free_inbuf:
+    qzFree(q->in_buf);
+err_close:
+    qzClose(&q->sess);
+err_free_q:
+    g_free(q);
+    error_setg(errp, "multifd %u: %s", p->id, err_msg);
+    return -1;
 }
 
+/**
+ * qatzip_send_cleanup: Tear down QATzip session and release private buffers.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     None
+ */
 static void qatzip_send_cleanup(MultiFDSendParams *p, Error **errp)
 {
+    struct qatzip_data *q = p->data;
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
+    g_free(p->data);
+    p->data = NULL;
     return;
+
+err:
+    error_setg(errp, "multifd %u: %s", p->id, err_msg);
 }
 
+/**
+ * qatzip_send_prepare: Compress pages and update IO channel info.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     0 on success, -1 on error (and *errp will be set)
+ */
 static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
 {
-    bool use_zero_copy_send = migrate_zero_copy_send();
     MultiFDPages_t *pages = p->pages;
+    struct qatzip_data *q = p->data;
     int ret;
+    unsigned int in_len, out_len;
 
-    if (!use_zero_copy_send) {
-        /*
-         * Only !zerocopy needs the header in IOV; zerocopy will
-         * send it separately.
-         */
-        multifd_send_prepare_header(p);
-    }
+    multifd_send_prepare_header(p);
 
+    /* memcpy all the pages into one buffer. */
     for (int i = 0; i < pages->num; i++) {
-        p->iov[p->iovs_num].iov_base = pages->block->host + pages->offset[i];
-        p->iov[p->iovs_num].iov_len = p->page_size;
-        p->iovs_num++;
+        memcpy(q->in_buf + (i * p->page_size),
+               p->pages->block->host + pages->offset[i],
+               p->page_size);
     }
 
-    p->next_packet_size = pages->num * p->page_size;
-    p->flags |= MULTIFD_FLAG_NOCOMP;
-
-    multifd_send_fill_packet(p);
+    in_len = pages->num * p->page_size;
+    if (in_len > q->in_len) {
+        error_setg(errp, "multifd %u: unexpectedly large input", p->id);
+        return -1;
+    }
+    out_len = q->out_len;
 
-    if (use_zero_copy_send) {
-        /* Send header first, without zerocopy */
-        ret = qio_channel_write_all(p->c, (void *)p->packet,
-                                    p->packet_len, errp);
-        if (ret != 0) {
-            return -1;
-        }
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
+    if (in_len != pages->num * p->page_size) {
+        error_setg(errp, "multifd %u: QATzip failed to compress all input",
+                   p->id);
+        return -1;
     }
 
+    p->iov[p->iovs_num].iov_base = q->out_buf;
+    p->iov[p->iovs_num].iov_len = out_len;
+    p->iovs_num++;
+    p->next_packet_size = out_len;
+    p->flags |= MULTIFD_FLAG_QATZIP;
+
+    multifd_send_fill_packet(p);
+
     return 0;
 }
 
+/**
+ * qatzip_recv_setup: Set up QATzip session and allocate private buffers.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     0 on success, -1 on error (and *errp will be set)
+ */
 static int qatzip_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
+    struct qatzip_data *q;
+    QzSessionParamsDeflate_T params;
+    const char *err_msg;
+    int ret;
+    int sw_fallback;
+
+    q = g_new0(struct qatzip_data, 1);
+    p->data = q;
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
     return 0;
+
+err_free_inbuf:
+    qzFree(q->in_buf);
+err_close:
+    qzClose(&q->sess);
+err_free_q:
+    g_free(q);
+    error_setg(errp, "multifd %u: %s", p->id, err_msg);
+    return -1;
 }
 
+/**
+ * qatzip_recv_cleanup: Tear down QATzip session and release private buffers.
+ *
+ * @param p    Multifd channel params
+ * @return     None
+ */
 static void qatzip_recv_cleanup(MultiFDRecvParams *p)
 {
+    struct qatzip_data *q = p->data;
+
+    /* Ignoring return values here due to function signature. */
+    qzTeardownSession(&q->sess);
+    qzClose(&q->sess);
+    qzFree(q->in_buf);
+    qzFree(q->out_buf);
+    g_free(p->data);
 }
 
+
+/**
+ * qatzip_recv_pages: Decompress pages and copy them to the appropriate
+ * locations.
+ *
+ * @param p    Multifd channel params
+ * @param errp Pointer to error, which will be set in case of error
+ * @return     0 on success, -1 on error (and *errp will be set)
+ */
 static int qatzip_recv_pages(MultiFDRecvParams *p, Error **errp)
 {
+    struct qatzip_data *q = p->data;
+    int ret;
+    unsigned int in_len, out_len;
+    uint32_t in_size = p->next_packet_size;
+    uint32_t expected_size = p->normal_num * p->page_size;
     uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
 
-    if (flags != MULTIFD_FLAG_NOCOMP) {
+    if (in_size > q->in_len) {
+        error_setg(errp, "multifd %u: received unexpectedly large packet",
+                   p->id);
+        return -1;
+    }
+
+    if (flags != MULTIFD_FLAG_QATZIP) {
         error_setg(errp, "multifd %u: flags received %x flags expected %x",
-                   p->id, flags, MULTIFD_FLAG_NOCOMP);
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
         return -1;
     }
+
+    /* Copy each page to its appropriate location. */
     for (int i = 0; i < p->normal_num; i++) {
-        p->iov[i].iov_base = p->host + p->normal[i];
-        p->iov[i].iov_len = p->page_size;
+        memcpy(p->host + p->normal[i],
+               q->out_buf + p->page_size * i,
+               p->page_size);
     }
-    return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
+    return 0;
 }
 
 static MultiFDMethods multifd_qatzip_ops = {
-- 
2.30.2


