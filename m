Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2A4C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 03:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6MkR-0001Ik-HW; Sun, 12 May 2024 23:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6MkO-0001HA-UR
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:53:09 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1s6MkH-0008K4-RD
 for qemu-devel@nongnu.org; Sun, 12 May 2024 23:53:08 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f472d550cbso3144795b3a.1
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 20:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1715572380; x=1716177180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYGRfK9y8vbQ5I9j+Z7GHui/6a7tYQQ2V6ZhkOmmgME=;
 b=joR/6VhhjuA958v2TLlXzMCRR4/UudBNC1OGyNGHy7V9Hk5l8NFmfDh3tbKiTcmj2H
 aaDITv6wUa2NJBOvuv8UkFznZmGJnTVM9Fmjn51AQM9413L1GNzEgO0Y0Fjiy6SJx8Yg
 X87/7fVy/vRsoCIQL2qOaby8dS3iLDyFr0X54F9Y4m0o964rOCs+1vRrWs51yi1DdRB3
 2dNks8sXrIrarBL1Gm3kyiJTu6jlznQeo28Wvp2vTRfgtj2kcW8DFV9vZmSn4Eg9J3dP
 p15frvr84iM1BW4c43s8U2NzJSXk6fzKoJF7f4puaOpTN3aNscJpyRVoNYXmOvKdNh2y
 fUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715572380; x=1716177180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OYGRfK9y8vbQ5I9j+Z7GHui/6a7tYQQ2V6ZhkOmmgME=;
 b=geBTCJ2K8D0kl0dB3jgQBmGYEDwTZujOgF2naCGnHNdvRe//C0CaEoZjK46F6er4vF
 MROayf70PeB5pXSPvTtyfXzIav1cXPPmky6G60fyGLuvX2c5hpmmk6Aa9fkiBRhbi2iQ
 CrqSgf79a+F63YHPcnCOVAANDRgPE2NuXwyTMR2MJnD/2fOvHYU+GZ3EawHtHF4rVBE7
 5xBT/tO9EYDix5MU6mHXXhMYCyZ1ytn7zL9V81JZq0QKp3bYng0cx3V9C8yKmyYR9c2j
 OPMcMx6AEVJhvACSDT/wQVbqWC5xz/QP/5+KXLphVcVaK77UM9Ue6mDiVPX3PXzzRiPy
 2nFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiYrEHxHkxsA7xddARllyQKOpSDdqAUozhfbQGyhpsfXuSp4i/Gu8js+iRpQhYxzLPmJNVc4sltJ803XjPLPlLjPOm4F8=
X-Gm-Message-State: AOJu0YwHp6Bz1d/8Wy1np+3Qpuz4tKEaIXYpaxWA9yuLmyfbEETr8w1U
 GmbGilP9vFPCHd3iAWB4ZA9tesiV3IQbENBbDYQEoV6pUp4j/6ToC8XSgWTgh2E=
X-Google-Smtp-Source: AGHT+IFE57hQaOy+IiD0rfTe7k0rjec07Vs2FGYXexxF0esCXEgOgxoK4Exzu5vhyC/hZj4AN5mChg==
X-Received: by 2002:a05:6a20:5643:b0:1af:a512:2777 with SMTP id
 adf61e73a8af0-1afde0eccddmr12255613637.36.1715572380080; 
 Sun, 12 May 2024 20:53:00 -0700 (PDT)
Received: from n37-006-243.byted.org ([180.184.51.40])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a8137asm6407947b3a.45.2024.05.12.20.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 20:52:59 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v2 05/11] hw/scsi: add persistent reservation in/out api for
 scsi device
Date: Mon, 13 May 2024 11:52:24 +0800
Message-Id: <20240513035230.60162-6-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240513035230.60162-1-luchangqi.123@bytedance.com>
References: <20240513035230.60162-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
---
 hw/scsi/scsi-disk.c | 348 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 348 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 4bd7af9d0c..0c7c1b4f72 100644
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
@@ -1474,6 +1476,342 @@ static void scsi_disk_emulate_read_data(SCSIRequest *req)
     scsi_req_complete(&r->req, GOOD);
 }
 
+typedef struct SCSIPrReadKeys {
+    uint32_t generation;
+    uint32_t num_keys;
+    uint64_t *keys;
+    void     *req;
+} SCSIPrReadKeys;
+
+typedef struct SCSIPrReadReservation {
+    uint32_t generation;
+    uint64_t key;
+    BlockPrType type;
+    void *req;
+} SCSIPrReadReservation;
+
+static void scsi_pr_read_keys_complete(void *opaque, int ret)
+{
+    int num_keys;
+    uint8_t *buf;
+    SCSIPrReadKeys *blk_keys = (SCSIPrReadKeys *)opaque;
+    SCSIDiskReq *r = (SCSIDiskReq *)blk_keys->req;
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
+    num_keys = MIN(blk_keys->num_keys, ret);
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
+static int scsi_disk_emulate_pr_read_keys(SCSIRequest *req)
+{
+    SCSIPrReadKeys *blk_keys;
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+    int buflen = MIN(r->req.cmd.xfer, r->buflen);
+    int num_keys = (buflen - sizeof(uint32_t) * 2) / sizeof(uint64_t);
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
+    return 0;
+}
+
+static void scsi_pr_read_reservation_complete(void *opaque, int ret)
+{
+    uint8_t *buf;
+    uint32_t additional_len = 0;
+    SCSIPrReadReservation *blk_rsv = (SCSIPrReadReservation *)opaque;
+    SCSIDiskReq *r = (SCSIDiskReq *)blk_rsv->req;
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
+static int scsi_disk_emulate_pr_read_reservation(SCSIRequest *req)
+{
+    SCSIPrReadReservation *blk_rsv;
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
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
+    return 0;
+}
+
+static int scsi_disk_emulate_pr_report_capabilities(SCSIRequest *req)
+{
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+    BlockDriverState *bs = blk_bs(s->qdev.conf.blk);
+    uint8_t blk_pr_cap = bs->file->bs->bl.pr_cap;
+    uint8_t *buf = scsi_req_get_buf(req);
+    uint16_t pr_cap;
+    /*
+     * according to response of report_capabilities
+     * command of chapter 6.13 of spc4
+     */
+    int len = sizeof(uint16_t) * 2 + sizeof(uint8_t) * 4;
+
+    if (len > r->buflen) {
+        return -EINVAL;
+    }
+
+    len = cpu_to_be16(len);
+    memcpy(&buf[0], &len, 2);
+    /* enable PTPL_C */
+    buf[2] = 1;
+    /* enable PTPL_A */
+    buf[3] = 1;
+    /* enable TMV */
+    buf[3] |= 1 << 7;
+
+    /* enable persistent reservation type */
+    pr_cap = block_pr_cap_to_scsi(blk_pr_cap);
+    buf[4] = pr_cap >> 8 & 0xff;
+    buf[5] = pr_cap & 0xff;
+
+    scsi_req_data(&r->req, len);
+    return 0;
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
+static int scsi_disk_emulate_pr_register(SCSIDiskReq *r, uint64_t r_key,
+                                         uint64_t sa_key, SCSIPrType type,
+                                         bool ignore_key)
+{
+    SCSIRequest *req = &r->req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+
+    /* The request is used as the AIO opaque value, so add a ref.  */
+    scsi_req_ref(&r->req);
+    r->req.aiocb = blk_aio_pr_register(s->qdev.conf.blk, r_key, sa_key,
+                                       scsi_pr_type_to_block(type),
+                                       ignore_key, scsi_aio_pr_complete, r);
+
+    return 0;
+}
+
+static int scsi_disk_emulate_pr_reserve(SCSIDiskReq *r, uint64_t r_key,
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
+    return 0;
+}
+
+static int scsi_disk_emulate_pr_release(SCSIDiskReq *r, uint64_t r_key,
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
+    return 0;
+}
+
+static int scsi_disk_emulate_pr_clear(SCSIDiskReq *r, uint64_t r_key)
+{
+    SCSIRequest *req = &r->req;
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+
+    /* The request is used as the AIO opaque value, so add a ref.  */
+    scsi_req_ref(&r->req);
+    r->req.aiocb = blk_aio_pr_clear(s->qdev.conf.blk, r_key,
+                                    scsi_aio_pr_complete, r);
+
+    return 0;
+}
+
+static int scsi_disk_emulate_pr_preempt(SCSIDiskReq *r, uint64_t r_key,
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
+    return 0;
+}
+
+static int scsi_disk_emulate_pr_in(SCSIRequest *req)
+{
+    int rc;
+    SCSIPrInAction action = req->cmd.buf[1] & 0x1f;
+
+    switch (action) {
+    case SCSI_PR_IN_READ_KEYS:
+        rc = scsi_disk_emulate_pr_read_keys(req);
+        break;
+    case SCSI_PR_IN_READ_RESERVATION:
+        rc = scsi_disk_emulate_pr_read_reservation(req);
+        break;
+    case SCSI_PR_IN_REPORT_CAPABILITIES:
+        rc = scsi_disk_emulate_pr_report_capabilities(req);
+        break;
+    default:
+        return -ENOTSUP;
+    }
+
+    return rc;
+}
+
+static int scsi_disk_emulate_pr_out(SCSIDiskReq *r, uint8_t *inbuf)
+{
+    int rc;
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
+    action = req->cmd.buf[1] & 0x1f;
+    scope = (req->cmd.buf[2] >> 4) & 0x0f;
+    type = req->cmd.buf[2] & 0x0f;
+
+    if (scope != SCSI_PR_LU_SCOPE) {
+        return -ENOTSUP;
+    }
+
+    switch (action) {
+    case SCSI_PR_OUT_REGISTER:
+        rc = scsi_disk_emulate_pr_register(r, r_key, sa_key, type, false);
+        break;
+    case SCSI_PR_OUT_REG_AND_IGNORE_KEY:
+        rc = scsi_disk_emulate_pr_register(r, r_key, sa_key, type, true);
+        break;
+    case SCSI_PR_OUT_RESERVE:
+        rc = scsi_disk_emulate_pr_reserve(r, r_key, type);
+        break;
+    case SCSI_PR_OUT_RELEASE:
+        rc = scsi_disk_emulate_pr_release(r, r_key, type);
+        break;
+    case SCSI_PR_OUT_CLEAR:
+        rc = scsi_disk_emulate_pr_clear(r, r_key);
+        break;
+    case SCSI_PR_OUT_PREEMPT:
+        rc = scsi_disk_emulate_pr_preempt(r, r_key, sa_key, type, false);
+        break;
+    case SCSI_PR_OUT_PREEMPT_AND_ABORT:
+        rc = scsi_disk_emulate_pr_preempt(r, r_key, sa_key, type, true);
+        break;
+    default:
+        return -ENOTSUP;
+    }
+
+    return rc;
+}
+
 static int scsi_disk_check_mode_select(SCSIDiskState *s, int page,
                                        uint8_t *inbuf, int inlen)
 {
@@ -1957,6 +2295,9 @@ static void scsi_disk_emulate_write_data(SCSIRequest *req)
         scsi_req_complete(&r->req, GOOD);
         break;
 
+    case PERSISTENT_RESERVE_OUT:
+        scsi_disk_emulate_pr_out(r, r->iov.iov_base);
+        break;
     default:
         abort();
     }
@@ -2213,6 +2554,11 @@ static int32_t scsi_disk_emulate_command(SCSIRequest *req, uint8_t *buf)
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
@@ -2632,6 +2978,8 @@ static const SCSIReqOps *const scsi_disk_reqops_dispatch[256] = {
     [VERIFY_12]                       = &scsi_disk_emulate_reqops,
     [VERIFY_16]                       = &scsi_disk_emulate_reqops,
     [FORMAT_UNIT]                     = &scsi_disk_emulate_reqops,
+    [PERSISTENT_RESERVE_IN]           = &scsi_disk_emulate_reqops,
+    [PERSISTENT_RESERVE_OUT]          = &scsi_disk_emulate_reqops,
 
     [READ_6]                          = &scsi_disk_dma_reqops,
     [READ_10]                         = &scsi_disk_dma_reqops,
-- 
2.20.1


