Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4947CCCF9E9
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2024 07:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stjCk-0002tr-C4; Thu, 26 Sep 2024 03:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1stjCj-0002rd-Pk
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 03:46:25 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1stjCh-0006JE-C6
 for qemu-devel@nongnu.org; Thu, 26 Sep 2024 03:46:25 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3e0465e6bd5so358237b6e.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2024 00:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1727336782; x=1727941582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84OioOP0ZM/IAvh4Obcp6J9Lygm5s0teJZRgY3hNxb0=;
 b=eeolH1DAG61HcyMQ6mGyy+iDzmXsi+3VwdC6gxQV8/K9J05X+X7HjSuPkX47eHls5N
 htaqCuV9Kesw+Nj+ATRvy3pS1u2sbPlxRJWBvCKXcxdUm12Oy/d+HsGnqlNzCVfLnlN2
 Y66/ZPO/I4AVnyt5r87E9r0Q7IDolmrC2Mok6CxB1DIEfoN/TauqkAMNyZ3uGzjMtU1K
 O/xTt+wVvn0/wITchirRTr7aGhrP1LqbZOcwTJ4ytTVs0Ob5bFFjOykQpxjRP3Cyl0Ra
 zBPnDNfsbUjTQjqEYFzt2ws1nZx5P0jVEsitafhAcLYLbZ6MjP+9c6uMNOkAj2MfFt/j
 8s5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727336782; x=1727941582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84OioOP0ZM/IAvh4Obcp6J9Lygm5s0teJZRgY3hNxb0=;
 b=FRi1Lfz+RWoaV4C6qqt7xWP2sqogLEd/5A07q+XXTmkeGsmKELMmAzlXoSAEXyP4zz
 uoMPYTqmh66Tmxzg3HVO+Ris5HXejnFnXLBgDRl6mgmZyUAMnM8Oyx+v+ix4zUWCXzmf
 ud76exAr8Kt36N2vkPG95fWnuUhnPWlHLbmfW+NIboa7yjKTvZepDdQne3m5E50I2siS
 K85tvdF2NZsMBpI5bigNFl+36rv2EA1dhqrJoOLvCnVR5yiM1DGg0VnAUbf+KrIvS3+I
 /PFV7SxCXupam/kzG8R2wsSXZ6agpSnFHtfhzHhdJxgVNrvIyXP/ieeN8wmxzPP/urbC
 EjwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKlEULTS3+2wm0O5Z7N/OXEIt0ATwdctJlk6S22mcBDDbrKlTNTMBSMCHbJNQHukHmeA3v7jAMYCzW@nongnu.org
X-Gm-Message-State: AOJu0Yy61PkP+MrMBo2e+3ePtz+Tl6ucLmSy6fBNGcAw+NvzyVqSKwTQ
 fplY9BmhuUlqyOp06M5qzZisO8nAxTgErv3DqUOJ3z2kXwcAfywhvc5yw+ZfRwk=
X-Google-Smtp-Source: AGHT+IEQfZ0QcmSkqc/BQ/19Q+cAkqkwldgKnYXNDZsagYgA39OKn02NIXOU8h8mTdcNWDMacPvcQA==
X-Received: by 2002:a05:6808:1649:b0:3e0:4210:2a10 with SMTP id
 5614622812f47-3e29b107c77mr4342525b6e.0.1727336782221; 
 Thu, 26 Sep 2024 00:46:22 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7e6b7c31bb5sm3683357a12.16.2024.09.26.00.46.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 26 Sep 2024 00:46:21 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v13 05/10] hw/scsi: add persistent reservation in/out api for
 scsi device
Date: Thu, 26 Sep 2024 15:45:41 +0800
Message-Id: <20240926074546.24507-6-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240926074546.24507-1-luchangqi.123@bytedance.com>
References: <20240926074546.24507-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add persistent reservation in/out operations in the
SCSI device layer. By introducing the persistent
reservation in/out api, this enables the SCSI device
to perform reservation-related tasks, including querying
keys, querying reservation status, registering reservation
keys, initiating and releasing reservations, as well as
clearing and preempting reservations held by other keys.

These operations are crucial for management and control of
shared storage resources in a persistent manner.

Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/scsi-disk.c | 374 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 374 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 0812d39c02..581dffa5c0 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -32,6 +32,7 @@
 #include "migration/vmstate.h"
 #include "hw/scsi/emulation.h"
 #include "scsi/constants.h"
+#include "scsi/utils.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
@@ -42,6 +43,7 @@
 #include "qemu/cutils.h"
 #include "trace.h"
 #include "qom/object.h"
+#include "block/block_int.h"
 
 #ifdef __linux
 #include <scsi/sg.h>
@@ -61,6 +63,8 @@
 #define MAX_SERIAL_LEN              36
 #define MAX_SERIAL_LEN_FOR_DEVID    20
 
+#define SCSI_MAX_RESERVATION_KEYS   128
+
 OBJECT_DECLARE_TYPE(SCSIDiskState, SCSIDiskClass, SCSI_DISK_BASE)
 
 struct SCSIDiskClass {
@@ -1477,6 +1481,366 @@ static void scsi_disk_emulate_read_data(SCSIRequest *req)
     scsi_req_complete(&r->req, GOOD);
 }
 
+typedef struct SCSIPrReadKeys {
+    uint32_t generation;
+    uint32_t num_keys;
+    uint64_t *keys;
+    SCSIDiskReq *req;
+} SCSIPrReadKeys;
+
+typedef struct SCSIPrReadReservation {
+    uint32_t generation;
+    uint64_t key;
+    BlockPrType type;
+    SCSIDiskReq *req;
+} SCSIPrReadReservation;
+
+static void scsi_pr_read_keys_complete(void *opaque, int ret)
+{
+    int num_keys;
+    uint8_t *buf;
+    SCSIPrReadKeys *blk_keys = (SCSIPrReadKeys *)opaque;
+    SCSIDiskReq *r = blk_keys->req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+
+    assert(blk_get_aio_context(s->qdev.conf.blk) ==
+            qemu_get_current_aio_context());
+
+    assert(r->req.aiocb != NULL);
+    r->req.aiocb = NULL;
+
+    if (scsi_disk_req_check_error(r, ret, true)) {
+        goto done;
+    }
+
+    buf = scsi_req_get_buf(&r->req);
+    num_keys = MIN(blk_keys->num_keys, ret > 0 ? ret : 0);
+    blk_keys->generation = cpu_to_be32(blk_keys->generation);
+    memcpy(&buf[0], &blk_keys->generation, 4);
+    for (int i = 0; i < num_keys; i++) {
+        blk_keys->keys[i] = cpu_to_be64(blk_keys->keys[i]);
+        memcpy(&buf[8 + i * 8], &blk_keys->keys[i], 8);
+    }
+    num_keys = cpu_to_be32(num_keys * 8);
+    memcpy(&buf[4], &num_keys, 4);
+
+    scsi_req_data(&r->req, r->buflen);
+done:
+    scsi_req_unref(&r->req);
+    g_free(blk_keys->keys);
+    g_free(blk_keys);
+}
+
+static void scsi_disk_emulate_pr_read_keys(SCSIRequest *req)
+{
+    SCSIPrReadKeys *blk_keys;
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+    int buflen = MIN(r->req.cmd.xfer, r->buflen);
+    int num_keys = (buflen - sizeof(uint32_t) * 2) / sizeof(uint64_t);
+
+    /*
+     * The maximum number of keys that can be transmitted is 128.
+     */
+    num_keys = MIN(num_keys, SCSI_MAX_RESERVATION_KEYS);
+    if (num_keys <= 0) {
+        scsi_check_condition(r, SENSE_CODE(INVALID_PARAM_LEN));
+        return;
+    }
+
+    blk_keys = g_new0(SCSIPrReadKeys, 1);
+    blk_keys->generation = 0;
+    /* num_keys is the maximum number of keys that can be transmitted */
+    blk_keys->num_keys = num_keys;
+    blk_keys->keys = g_malloc(sizeof(uint64_t) * num_keys);
+    blk_keys->req = r;
+
+    /* The request is used as the AIO opaque value, so add a ref.  */
+    scsi_req_ref(&r->req);
+    r->req.aiocb = blk_aio_pr_read_keys(s->qdev.conf.blk, &blk_keys->generation,
+                                        blk_keys->num_keys, blk_keys->keys,
+                                        scsi_pr_read_keys_complete, blk_keys);
+    return;
+}
+
+static void scsi_pr_read_reservation_complete(void *opaque, int ret)
+{
+    uint8_t *buf;
+    uint32_t additional_len = 0;
+    SCSIPrReadReservation *blk_rsv = (SCSIPrReadReservation *)opaque;
+    SCSIDiskReq *r = blk_rsv->req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+
+    assert(blk_get_aio_context(s->qdev.conf.blk) ==
+            qemu_get_current_aio_context());
+
+    assert(r->req.aiocb != NULL);
+    r->req.aiocb = NULL;
+
+    if (scsi_disk_req_check_error(r, ret, true)) {
+        goto done;
+    }
+
+    buf = scsi_req_get_buf(&r->req);
+    blk_rsv->generation = cpu_to_be32(blk_rsv->generation);
+    memcpy(&buf[0], &blk_rsv->generation, 4);
+    if (ret) {
+        additional_len = cpu_to_be32(16);
+        blk_rsv->key = cpu_to_be64(blk_rsv->key);
+        memcpy(&buf[8], &blk_rsv->key, 8);
+        buf[21] = block_pr_type_to_scsi(blk_rsv->type) & 0xf;
+    } else {
+        additional_len = cpu_to_be32(0);
+    }
+
+    memcpy(&buf[4], &additional_len, 4);
+    scsi_req_data(&r->req, r->buflen);
+
+done:
+    scsi_req_unref(&r->req);
+    g_free(blk_rsv);
+}
+
+static void scsi_disk_emulate_pr_read_reservation(SCSIRequest *req)
+{
+    SCSIPrReadReservation *blk_rsv;
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+    int buflen = MIN(r->req.cmd.xfer, r->buflen);
+    int count = sizeof(uint32_t) * 2 + sizeof(uint64_t) +
+                sizeof(uint32_t) + sizeof(uint8_t) * 2;
+
+    if (buflen < count) {
+        scsi_check_condition(r, SENSE_CODE(INVALID_PARAM_LEN));
+        return;
+    }
+
+    blk_rsv = g_malloc(sizeof(*blk_rsv));
+    blk_rsv->generation = 0;
+    blk_rsv->key = 0;
+    blk_rsv->type = 0;
+    blk_rsv->req = r;
+
+    /* The request is used as the AIO opaque value, so add a ref.  */
+    scsi_req_ref(&r->req);
+    r->req.aiocb = blk_aio_pr_read_reservation(s->qdev.conf.blk,
+                   &blk_rsv->generation, &blk_rsv->key, &blk_rsv->type,
+                   scsi_pr_read_reservation_complete, blk_rsv);
+    return;
+}
+
+static void scsi_disk_emulate_pr_report_capabilities(SCSIRequest *req)
+{
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+    BlockDriverState *bs = blk_bs(s->qdev.conf.blk);
+    uint8_t blk_pr_cap = bs->bl.pr_cap;
+    uint8_t *buf = scsi_req_get_buf(req);
+    uint16_t pr_cap;
+    /*
+     * according to response of report_capabilities
+     * command of chapter 6.13 of spc4
+     */
+    int len = sizeof(uint16_t) * 2 + sizeof(uint8_t) * 4;
+
+    if (len > r->buflen) {
+        scsi_check_condition(r, SENSE_CODE(INVALID_PARAM_LEN));
+        return;
+    }
+
+    len = cpu_to_be16(len);
+    memcpy(&buf[0], &len, 2);
+    /* enable PTPL_C */
+    buf[2] = 1;
+    buf[3] = (blk_pr_cap & BLK_PR_CAP_PTPL) ? 1 : 0;
+    /* enable TMV */
+    buf[3] |= 1 << 7;
+
+    /* enable persistent reservation type */
+    pr_cap = block_pr_cap_to_scsi(blk_pr_cap);
+    buf[4] = pr_cap >> 8 & 0xff;
+    buf[5] = pr_cap & 0xff;
+
+    scsi_req_data(&r->req, len);
+    return;
+}
+
+static void scsi_aio_pr_complete(void *opaque, int ret)
+{
+    SCSIDiskReq *r = (SCSIDiskReq *)opaque;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+
+    /* The request must only run in the BlockBackend's AioContext */
+    assert(blk_get_aio_context(s->qdev.conf.blk) ==
+           qemu_get_current_aio_context());
+
+    assert(r->req.aiocb != NULL);
+    r->req.aiocb = NULL;
+
+    if (scsi_disk_req_check_error(r, ret, true)) {
+        goto done;
+    }
+
+    scsi_req_complete(&r->req, GOOD);
+
+done:
+    scsi_req_unref(&r->req);
+}
+
+static void scsi_disk_emulate_pr_register(SCSIDiskReq *r, uint64_t r_key,
+                                         uint64_t sa_key, SCSIPrType type,
+                                         uint8_t aptpl, bool ignore_key)
+{
+    SCSIRequest *req = &r->req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+
+    /* The request is used as the AIO opaque value, so add a ref.  */
+    scsi_req_ref(&r->req);
+    r->req.aiocb = blk_aio_pr_register(s->qdev.conf.blk, r_key, sa_key,
+                                       scsi_pr_type_to_block(type),
+                                       aptpl ? true : false,
+                                       ignore_key, scsi_aio_pr_complete, r);
+
+    return;
+}
+
+static void scsi_disk_emulate_pr_reserve(SCSIDiskReq *r, uint64_t r_key,
+                                        SCSIPrType type)
+{
+    SCSIRequest *req = &r->req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+
+    /* The request is used as the AIO opaque value, so add a ref.  */
+    scsi_req_ref(&r->req);
+    r->req.aiocb = blk_aio_pr_reserve(s->qdev.conf.blk, r_key,
+                                      scsi_pr_type_to_block(type),
+                                      scsi_aio_pr_complete, r);
+
+    return;
+}
+
+static void scsi_disk_emulate_pr_release(SCSIDiskReq *r, uint64_t r_key,
+                                        SCSIPrType type)
+{
+    SCSIRequest *req = &r->req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+
+    /* The request is used as the AIO opaque value, so add a ref.  */
+    scsi_req_ref(&r->req);
+    r->req.aiocb = blk_aio_pr_release(s->qdev.conf.blk, r_key,
+                                      scsi_pr_type_to_block(type),
+                                      scsi_aio_pr_complete, r);
+
+    return;
+}
+
+static void scsi_disk_emulate_pr_clear(SCSIDiskReq *r, uint64_t r_key)
+{
+    SCSIRequest *req = &r->req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+
+    /* The request is used as the AIO opaque value, so add a ref.  */
+    scsi_req_ref(&r->req);
+    r->req.aiocb = blk_aio_pr_clear(s->qdev.conf.blk, r_key,
+                                    scsi_aio_pr_complete, r);
+
+    return;
+}
+
+static void scsi_disk_emulate_pr_preempt(SCSIDiskReq *r, uint64_t r_key,
+                                        uint64_t sa_key, SCSIPrType type,
+                                        bool abort)
+{
+    SCSIRequest *req = &r->req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+
+    /* The request is used as the AIO opaque value, so add a ref.  */
+    scsi_req_ref(&r->req);
+    r->req.aiocb = blk_aio_pr_preempt(s->qdev.conf.blk, r_key, sa_key,
+                                      scsi_pr_type_to_block(type), abort,
+                                      scsi_aio_pr_complete, r);
+
+    return;
+}
+
+static void scsi_disk_emulate_pr_in(SCSIRequest *req)
+{
+    SCSIPrInAction action = req->cmd.buf[1] & 0x1f;
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+
+    switch (action) {
+    case SCSI_PR_IN_READ_KEYS:
+        scsi_disk_emulate_pr_read_keys(req);
+        break;
+    case SCSI_PR_IN_READ_RESERVATION:
+        scsi_disk_emulate_pr_read_reservation(req);
+        break;
+    case SCSI_PR_IN_REPORT_CAPABILITIES:
+        scsi_disk_emulate_pr_report_capabilities(req);
+        break;
+    default:
+        scsi_check_condition(r, SENSE_CODE(INVALID_OPCODE));
+        return;
+    }
+
+    return;
+}
+
+static void scsi_disk_emulate_pr_out(SCSIDiskReq *r, uint8_t *inbuf)
+{
+    uint8_t aptpl;
+    uint64_t r_key, sa_key;
+    SCSIPrOutAction action;
+    SCSIPrScope scope;
+    SCSIPrType type;
+    SCSIRequest *req = &r->req;
+
+    memcpy(&r_key, &inbuf[0], 8);
+    r_key = be64_to_cpu(r_key);
+    memcpy(&sa_key, &inbuf[8], 8);
+    sa_key = be64_to_cpu(sa_key);
+    memcpy(&aptpl, &inbuf[20], 1);
+    aptpl =  aptpl & 0x01;
+    action = req->cmd.buf[1] & 0x1f;
+    scope = (req->cmd.buf[2] >> 4) & 0x0f;
+    type = req->cmd.buf[2] & 0x0f;
+
+    if (scope != SCSI_PR_LU_SCOPE) {
+        scsi_req_complete(&r->req, TASK_ABORTED);
+        return;
+    }
+
+    switch (action) {
+    case SCSI_PR_OUT_REGISTER:
+        scsi_disk_emulate_pr_register(r, r_key, sa_key, type,
+                                      aptpl, false);
+        break;
+    case SCSI_PR_OUT_REG_AND_IGNORE_KEY:
+        scsi_disk_emulate_pr_register(r, r_key, sa_key, type, aptpl, true);
+        break;
+    case SCSI_PR_OUT_RESERVE:
+        scsi_disk_emulate_pr_reserve(r, r_key, type);
+        break;
+    case SCSI_PR_OUT_RELEASE:
+        scsi_disk_emulate_pr_release(r, r_key, type);
+        break;
+    case SCSI_PR_OUT_CLEAR:
+        scsi_disk_emulate_pr_clear(r, r_key);
+        break;
+    case SCSI_PR_OUT_PREEMPT:
+        scsi_disk_emulate_pr_preempt(r, r_key, sa_key, type, false);
+        break;
+    case SCSI_PR_OUT_PREEMPT_AND_ABORT:
+        scsi_disk_emulate_pr_preempt(r, r_key, sa_key, type, true);
+        break;
+    default:
+        scsi_check_condition(r, SENSE_CODE(INVALID_OPCODE));
+        return;
+    }
+
+    return;
+}
+
 static int scsi_disk_check_mode_select(SCSIDiskState *s, int page,
                                        uint8_t *inbuf, int inlen)
 {
@@ -1960,6 +2324,9 @@ static void scsi_disk_emulate_write_data(SCSIRequest *req)
         scsi_req_complete(&r->req, GOOD);
         break;
 
+    case PERSISTENT_RESERVE_OUT:
+        scsi_disk_emulate_pr_out(r, r->iov.iov_base);
+        break;
     default:
         abort();
     }
@@ -2216,6 +2583,11 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
     case FORMAT_UNIT:
         trace_scsi_disk_emulate_command_FORMAT_UNIT(r->req.cmd.xfer);
         break;
+    case PERSISTENT_RESERVE_OUT:
+        break;
+    case PERSISTENT_RESERVE_IN:
+        scsi_disk_emulate_pr_in(req);
+        return 0;
     default:
         trace_scsi_disk_emulate_command_UNKNOWN(buf[0],
                                                 scsi_command_name(buf[0]));
@@ -2646,6 +3018,8 @@ static const SCSIReqOps *const scsi_disk_reqops_dispatch[256] = {
     [VERIFY_12]                       = &scsi_disk_emulate_reqops,
     [VERIFY_16]                       = &scsi_disk_emulate_reqops,
     [FORMAT_UNIT]                     = &scsi_disk_emulate_reqops,
+    [PERSISTENT_RESERVE_IN]           = &scsi_disk_emulate_reqops,
+    [PERSISTENT_RESERVE_OUT]          = &scsi_disk_emulate_reqops,
 
     [READ_6]                          = &scsi_disk_dma_reqops,
     [READ_10]                         = &scsi_disk_dma_reqops,
-- 
2.20.1


