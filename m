Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08C2D24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJEi-0003Hu-HF; Fri, 11 Oct 2024 13:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1szJ7h-0003ly-66
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:08:18 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1szEWZ-0004wD-C1
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 08:13:42 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20c805a0753so16929425ad.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 05:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1728648818; x=1729253618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPOuih7QTJeqWd4JETHDI5STMsR4FXqjkFwum7IHLUE=;
 b=QRYiUVWXJ1IvdHqJJDHiVgjd5Bs+VA6M3cgSRGFJm1UNGaIFvlbccXIeIuOL3VoGjB
 /dK3Ba/nxwL0/U+jdmivsOioQKSf1NUYSrGTctyX3NXESxQxfzUSwnPZy9tFBUsxTl/O
 jVdjos9NTsqP+IuVo2jCs4cuuBNDj7NEVjCMLxuItuU07e04VAVyevNnZS6qXC+TwSLF
 uXHnp9F6a2iww5VhBB+c17BwS9mvRpzn7eS8/Lpx4q8088w8bzGATyp77xluS3DPQo9/
 gHD+Qdi08t2lo6lZ000XqU+gNqh1Y8pQGH0k1AfQIuvqmqbWr3bXi+0J5rTQ8zNvh2+j
 mbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728648818; x=1729253618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wPOuih7QTJeqWd4JETHDI5STMsR4FXqjkFwum7IHLUE=;
 b=UpAozjTZEM1emqm1tpABGziA2uHojiupdfEUUS4MG9tti0fqF5e+qVTk79OcPXleMH
 8V1helizuofUQvFVQ9E7AWo6sioGtE3InrafqIezP4793AUItAkNLkLvcPirFmdLEltw
 oNRlSzfED6KxgNhjWg8lCN/E1Venw5wpLpdyDicODCsc4wRuVTYrGH1GBiuKCoy6DZCi
 /pVAI6p90JMU1i7o6FN9078GirOlmaKDbgDnjOH01RCn59d+4At1h1a9C1Pokb8yOTTk
 Y01TrTisSXDSvda07NEWGJqFpVFIUfRkeQ2ZYMyS2EMJtIlx6Q2nT81y8tL82vGEpxA+
 d4iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLbJIo1UXCWdrP8a1A8x6NbDj58vGwCzYYvJ5wB/iKhmffgPO+53lUJuuPviljG6/A1tMqMGmRCYVp@nongnu.org
X-Gm-Message-State: AOJu0YyGvT9HwN7AAO2qsczo8b1PTCnGa31v+RwCqwd/KWJT9LYKym5P
 AVsAftN8aSTOxu1uT8Gt3TJxdNr1IJLy1Ares9Yk7usnyJhxzqjinPOjhq0/Weo=
X-Google-Smtp-Source: AGHT+IEMovayvMXj4r05sgvCypp8tGdDIAvxPd32CnEug7dXxhwU9ddg08be04VWGMtHdVOHuK87vw==
X-Received: by 2002:a17:902:e5ca:b0:20b:5351:f69a with SMTP id
 d9443c01a7336-20ca16fb895mr38159625ad.58.1728648817981; 
 Fri, 11 Oct 2024 05:13:37 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([139.177.225.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8bc13551sm22569305ad.88.2024.10.11.05.13.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 11 Oct 2024 05:13:37 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v14 09/10] hw/nvme: add reservation protocal command
Date: Fri, 11 Oct 2024 20:12:30 +0800
Message-Id: <20241011121231.18333-10-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20241011121231.18333-1-luchangqi.123@bytedance.com>
References: <20241011121231.18333-1-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-pl1-x62e.google.com
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

Add reservation acquire, reservation register,
reservation release and reservation report commands
in the nvme device layer.

By introducing these commands, this enables the nvme
device to perform reservation-related tasks, including
querying keys, querying reservation status, registering
reservation keys, initiating and releasing reservations,
as well as clearing and preempting reservations held by
other keys.

These commands are crucial for management and control of
shared storage resources in a persistent manner.
Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Acked-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c       | 347 +++++++++++++++++++++++++++++++++++++++++++
 hw/nvme/ns.c         |   6 +
 hw/nvme/nvme.h       |   9 ++
 include/block/nvme.h |  58 ++++++++
 4 files changed, 420 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index ad212de723..4821a7ff3b 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -294,6 +294,10 @@ static const uint32_t nvme_cse_iocs_nvm[256] = {
     [NVME_CMD_COMPARE]              = NVME_CMD_EFF_CSUPP,
     [NVME_CMD_IO_MGMT_RECV]         = NVME_CMD_EFF_CSUPP,
     [NVME_CMD_IO_MGMT_SEND]         = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
+    [NVME_CMD_RESV_REGISTER]        = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_RESV_REPORT]          = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_RESV_ACQUIRE]         = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_RESV_RELEASE]         = NVME_CMD_EFF_CSUPP,
 };
 
 static const uint32_t nvme_cse_iocs_zoned[256] = {
@@ -308,6 +312,10 @@ static const uint32_t nvme_cse_iocs_zoned[256] = {
     [NVME_CMD_ZONE_APPEND]          = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_CMD_ZONE_MGMT_SEND]       = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_CMD_ZONE_MGMT_RECV]       = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_RESV_REGISTER]        = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_RESV_REPORT]          = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_RESV_ACQUIRE]         = NVME_CMD_EFF_CSUPP,
+    [NVME_CMD_RESV_RELEASE]         = NVME_CMD_EFF_CSUPP,
 };
 
 static void nvme_process_sq(void *opaque);
@@ -1745,6 +1753,7 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
 
     switch (req->cmd.opcode) {
     case NVME_CMD_READ:
+    case NVME_CMD_RESV_REPORT:
         status = NVME_UNRECOVERED_READ;
         break;
     case NVME_CMD_FLUSH:
@@ -1752,6 +1761,9 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
     case NVME_CMD_WRITE_ZEROES:
     case NVME_CMD_ZONE_APPEND:
     case NVME_CMD_COPY:
+    case NVME_CMD_RESV_REGISTER:
+    case NVME_CMD_RESV_ACQUIRE:
+    case NVME_CMD_RESV_RELEASE:
         status = NVME_WRITE_FAULT;
         break;
     default:
@@ -2692,6 +2704,333 @@ static uint16_t nvme_verify(NvmeCtrl *n, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
 
+static uint16_t nvme_resv_register(NvmeCtrl *n, NvmeRequest *req)
+{
+    int ret;
+    NvmeReservationKeyInfo key_info;
+    NvmeNamespace *ns = req->ns;
+    uint32_t cdw10 = le32_to_cpu(req->cmd.cdw10);
+    bool ignore_key = ((cdw10 >> 3) & 0x1);
+    uint8_t action = cdw10 & 0x7;
+    uint8_t cptpl = ((cdw10 >> 30) & 0x3);
+    bool aptpl;
+
+    if (!nvme_support_pr(ns)) {
+        return NVME_INVALID_OPCODE;
+    }
+
+    switch (cptpl) {
+    case NVME_RESV_PTPL_NO_CHANGE:
+        aptpl = (ns->id_ns.rescap & NVME_PR_CAP_PTPL) ? true : false;
+        break;
+    case NVME_RESV_PTPL_DISABLE:
+        aptpl = false;
+        break;
+    case NVME_RESV_PTPL_ENABLE:
+        aptpl = true;
+        break;
+    default:
+        return NVME_INVALID_FIELD;
+    }
+
+    ret = nvme_h2c(n, (uint8_t *)&key_info,
+                   sizeof(NvmeReservationKeyInfo), req);
+    if (ret) {
+        return ret;
+    }
+
+    key_info.cr_key = le64_to_cpu(key_info.cr_key);
+    key_info.nr_key = le64_to_cpu(key_info.nr_key);
+
+    switch (action) {
+    case NVME_RESV_REGISTER_ACTION_REGISTER:
+        req->aiocb = blk_aio_pr_register(ns->blkconf.blk, 0,
+                                         key_info.nr_key, 0, aptpl,
+                                         ignore_key, nvme_misc_cb,
+                                         req);
+        break;
+    case NVME_RESV_REGISTER_ACTION_UNREGISTER:
+        req->aiocb = blk_aio_pr_register(ns->blkconf.blk, key_info.cr_key, 0,
+                                         0, aptpl, ignore_key,
+                                         nvme_misc_cb, req);
+        break;
+    case NVME_RESV_REGISTER_ACTION_REPLACE:
+        req->aiocb = blk_aio_pr_register(ns->blkconf.blk, key_info.cr_key,
+                                         key_info.nr_key, 0, aptpl, ignore_key,
+                                         nvme_misc_cb, req);
+        break;
+    default:
+        return NVME_INVALID_FIELD;
+    }
+
+    return NVME_NO_COMPLETE;
+}
+
+static uint16_t nvme_resv_release(NvmeCtrl *n, NvmeRequest *req)
+{
+    int ret;
+    uint64_t cr_key;
+    NvmeNamespace *ns = req->ns;
+    uint32_t cdw10 = le32_to_cpu(req->cmd.cdw10);
+    uint8_t action = cdw10 & 0x7;
+    NvmeResvType type = ((cdw10 >> 8) & 0xff);
+
+    /*
+     * According to the specification, the 03 bit is set to a '1',
+     * NVME_INVALID_FIELD error should be returned.
+     */
+    if ((cdw10 >> 3) & 1) {
+        return NVME_INVALID_FIELD;
+    }
+
+    if (!nvme_support_pr(ns)) {
+        return NVME_INVALID_OPCODE;
+    }
+
+    ret = nvme_h2c(n, (uint8_t *)&cr_key, sizeof(cr_key), req);
+    if (ret) {
+        return ret;
+    }
+
+    cr_key = le64_to_cpu(cr_key);
+
+    switch (action) {
+    case NVME_RESV_RELEASE_ACTION_RELEASE:
+        req->aiocb = blk_aio_pr_release(ns->blkconf.blk, cr_key,
+                                        nvme_pr_type_to_block(type),
+                                        nvme_misc_cb, req);
+        break;
+    case NVME_RESV_RELEASE_ACTION_CLEAR:
+        req->aiocb = blk_aio_pr_clear(ns->blkconf.blk, cr_key,
+                                      nvme_misc_cb, req);
+        break;
+    default:
+        return NVME_INVALID_FIELD;
+    }
+
+    return NVME_NO_COMPLETE;
+}
+
+static uint16_t nvme_resv_acquire(NvmeCtrl *n, NvmeRequest *req)
+{
+    int ret;
+    NvmeReservationKeyInfo key_info;
+    NvmeNamespace *ns = req->ns;
+    uint32_t cdw10 = le32_to_cpu(req->cmd.cdw10);
+    uint8_t action = cdw10 & 0x7;
+    NvmeResvType type = ((cdw10 >> 8) & 0xff);
+
+    /*
+     * According to the specification, the 03 bit is set to a '1',
+     * NVME_INVALID_FIELD error should be returned.
+     */
+    if ((cdw10 >> 3) & 1) {
+        return NVME_INVALID_FIELD;
+    }
+
+    if (!nvme_support_pr(ns)) {
+        return NVME_INVALID_OPCODE;
+    }
+
+    ret = nvme_h2c(n, (uint8_t *)&key_info,
+                   sizeof(NvmeReservationKeyInfo), req);
+    if (ret) {
+        return ret;
+    }
+
+    key_info.cr_key = le64_to_cpu(key_info.cr_key);
+    key_info.pr_key = le64_to_cpu(key_info.pr_key);
+
+    switch (action) {
+    case NVME_RESV_ACQUIRE_ACTION_ACQUIRE:
+        req->aiocb = blk_aio_pr_reserve(ns->blkconf.blk, key_info.cr_key,
+                                        nvme_pr_type_to_block(type),
+                                        nvme_misc_cb, req);
+        break;
+    case NVME_RESV_ACQUIRE_ACTION_PREEMPT:
+        req->aiocb = blk_aio_pr_preempt(ns->blkconf.blk,
+                     key_info.cr_key, key_info.pr_key,
+                     nvme_pr_type_to_block(type),
+                     false, nvme_misc_cb, req);
+        break;
+    case NVME_RESV_ACQUIRE_ACTION_PREEMPT_AND_ABORT:
+        req->aiocb = blk_aio_pr_preempt(ns->blkconf.blk, key_info.cr_key,
+                                        key_info.pr_key, type, true,
+                                        nvme_misc_cb, req);
+        break;
+    default:
+        return NVME_INVALID_FIELD;
+    }
+
+    return NVME_NO_COMPLETE;
+}
+
+typedef struct NvmeResvKeys {
+    uint32_t generation;
+    uint32_t num_keys;
+    uint64_t *keys;
+    NvmeRequest *req;
+} NvmeResvKeys;
+
+typedef struct NvmeReadReservation {
+    uint32_t generation;
+    uint64_t key;
+    BlockPrType type;
+    NvmeRequest *req;
+    NvmeResvKeys *keys_info;
+} NvmeReadReservation;
+
+static int nvme_read_reservation_cb(NvmeReadReservation *reservation)
+{
+    int rc;
+    NvmeReservationStatus *nvme_status;
+    NvmeRequest *req = reservation->req;
+    NvmeCtrl *n = req->sq->ctrl;
+    NvmeResvKeys *keys_info = reservation->keys_info;
+    int len = sizeof(NvmeReservationStatusHeader) +
+              sizeof(NvmeRegisteredCtrl) * keys_info->num_keys;
+
+    nvme_status = g_malloc0(len);
+    nvme_status->header.gen = cpu_to_le32(reservation->generation);
+    nvme_status->header.rtype = block_pr_type_to_nvme(reservation->type);
+    nvme_status->header.regstrnt = cpu_to_le32(keys_info->num_keys);
+    for (int i = 0; i < keys_info->num_keys; i++) {
+        uint16_t ctnlid = nvme_ctrl(req)->cntlid;
+        nvme_status->regctl_ds[i].cntlid = cpu_to_le16(ctnlid);
+        nvme_status->regctl_ds[i].rkey = cpu_to_le64(keys_info->keys[i]);
+        nvme_status->regctl_ds[i].rcsts = keys_info->keys[i] ==
+                                          reservation->key ? 1 : 0;
+    }
+
+    rc = nvme_c2h(n, (uint8_t *)nvme_status, len, req);
+    g_free(nvme_status);
+    return rc;
+}
+
+static int nvme_read_reservation_ext_cb(NvmeReadReservation *reservation)
+{
+    int rc;
+    NvmeReservationStatusExt *nvme_status_ext;
+    NvmeRequest *req = reservation->req;
+    NvmeCtrl *n = req->sq->ctrl;
+    NvmeResvKeys *keys_info = reservation->keys_info;
+    int len = sizeof(NvmeReservationStatusExt) +
+              sizeof(NvmeRegisteredCtrlExt) * keys_info->num_keys;
+
+    nvme_status_ext = g_malloc0(len);
+    nvme_status_ext->header.gen = cpu_to_le32(reservation->generation);
+    nvme_status_ext->header.rtype = block_pr_type_to_nvme(reservation->type);
+    nvme_status_ext->header.regstrnt = cpu_to_le32(keys_info->num_keys);
+
+    for (int i = 0; i < keys_info->num_keys; i++) {
+        uint16_t ctnlid = nvme_ctrl(req)->cntlid;
+        nvme_status_ext->regctl_eds[i].cntlid = cpu_to_le16(ctnlid);
+        nvme_status_ext->regctl_eds[i].rkey = cpu_to_le64(keys_info->keys[i]);
+        nvme_status_ext->regctl_eds[i].rcsts = keys_info->keys[i] ==
+                                               reservation->key ? 1 : 0;
+    }
+
+    rc = nvme_c2h(n, (uint8_t *)nvme_status_ext, len, req);
+    g_free(nvme_status_ext);
+    return rc;
+}
+
+static void nvme_resv_read_reservation_cb(void *opaque, int ret)
+{
+    NvmeReadReservation *reservation = opaque;
+    NvmeRequest *req = reservation->req;
+    bool eds = le32_to_cpu(req->cmd.cdw11) & 0x1;
+    NvmeResvKeys *keys_info = reservation->keys_info;
+
+    if (ret < 0) {
+        goto out;
+    }
+
+    if (eds) {
+        ret = nvme_read_reservation_ext_cb(reservation);
+    } else {
+        ret = nvme_read_reservation_cb(reservation);
+    }
+
+out:
+    g_free(keys_info->keys);
+    g_free(keys_info);
+    g_free(reservation);
+    nvme_misc_cb(req, ret);
+}
+
+static void nvme_resv_read_keys_cb(void *opaque, int ret)
+{
+    NvmeResvKeys *keys_info = opaque;
+    NvmeRequest *req = keys_info->req;
+    NvmeNamespace *ns = req->ns;
+    NvmeReadReservation *reservation;
+
+    if (ret < 0) {
+        goto out;
+    }
+
+    keys_info->num_keys = MIN(ret, keys_info->num_keys);
+    reservation = g_new0(NvmeReadReservation, 1);
+    reservation->req = req;
+    reservation->keys_info = keys_info;
+
+    req->aiocb = blk_aio_pr_read_reservation(ns->blkconf.blk,
+                 &reservation->generation, &reservation->key,
+                 &reservation->type, nvme_resv_read_reservation_cb,
+                 reservation);
+    return;
+
+out:
+    g_free(keys_info->keys);
+    g_free(keys_info);
+    nvme_misc_cb(req, ret);
+}
+
+
+static uint16_t nvme_resv_report(NvmeCtrl *n, NvmeRequest *req)
+{
+    int num_keys;
+    uint32_t cdw10 = le32_to_cpu(req->cmd.cdw10);
+    uint32_t cdw11 = le32_to_cpu(req->cmd.cdw11);
+    size_t buflen = (cdw10 + 1) * sizeof(uint32_t);
+    bool eds = cdw11 & 0x1;
+    NvmeNamespace *ns = req->ns;
+    NvmeResvKeys *keys_info;
+
+    if (!nvme_support_pr(ns)) {
+        return NVME_INVALID_OPCODE;
+    }
+
+    if (eds) {
+        if (buflen < sizeof(NvmeReservationStatusExt)) {
+            return NVME_INVALID_FIELD;
+        }
+
+        num_keys = (buflen - sizeof(NvmeReservationStatusExt)) /
+                   sizeof(struct NvmeRegisteredCtrlExt);
+    } else {
+        if (buflen < sizeof(NvmeReservationStatusHeader)) {
+            return NVME_INVALID_FIELD;
+        }
+
+        num_keys = (buflen - sizeof(NvmeReservationStatusHeader)) /
+                   sizeof(struct NvmeRegisteredCtrl);
+    }
+
+    keys_info = g_new0(NvmeResvKeys, 1);
+    /* num_keys is the maximum number of keys that can be transmitted */
+    keys_info->num_keys = MAX(num_keys, 0);
+    keys_info->keys = g_malloc(sizeof(uint64_t) * num_keys);
+    keys_info->req = req;
+
+    req->aiocb = blk_aio_pr_read_keys(ns->blkconf.blk, &keys_info->generation,
+                                      keys_info->num_keys, keys_info->keys,
+                                      nvme_resv_read_keys_cb, keys_info);
+
+    return NVME_NO_COMPLETE;
+}
+
 typedef struct NvmeCopyAIOCB {
     BlockAIOCB common;
     BlockAIOCB *aiocb;
@@ -4469,6 +4808,14 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
         return nvme_dsm(n, req);
     case NVME_CMD_VERIFY:
         return nvme_verify(n, req);
+    case NVME_CMD_RESV_REGISTER:
+        return nvme_resv_register(n, req);
+    case NVME_CMD_RESV_REPORT:
+        return nvme_resv_report(n, req);
+    case NVME_CMD_RESV_ACQUIRE:
+        return nvme_resv_acquire(n, req);
+    case NVME_CMD_RESV_RELEASE:
+        return nvme_resv_release(n, req);
     case NVME_CMD_COPY:
         return nvme_copy(n, req);
     case NVME_CMD_ZONE_MGMT_SEND:
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index a5c903d727..833bcbae08 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -60,6 +60,12 @@ void nvme_ns_init_format(NvmeNamespace *ns)
 
     blk_pr_cap = blk_bs(ns->blkconf.blk)->bl.pr_cap;
     id_ns->rescap = block_pr_cap_to_nvme(blk_pr_cap);
+    if (id_ns->rescap != NVME_PR_CAP_ALL &&
+        id_ns->rescap != NVME_PR_CAP_RW) {
+
+        /* Rescap either supports all or none of them */
+        id_ns->rescap = 0;
+    }
 }
 
 static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 6d0e456348..23d7173a36 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -470,6 +470,10 @@ static inline const char *nvme_io_opc_str(uint8_t opc)
     case NVME_CMD_ZONE_MGMT_SEND:   return "NVME_ZONED_CMD_MGMT_SEND";
     case NVME_CMD_ZONE_MGMT_RECV:   return "NVME_ZONED_CMD_MGMT_RECV";
     case NVME_CMD_ZONE_APPEND:      return "NVME_ZONED_CMD_ZONE_APPEND";
+    case NVME_CMD_RESV_REGISTER:    return "NVME_CMD_RESV_REGISTER";
+    case NVME_CMD_RESV_REPORT:      return "NVME_CMD_RESV_REPORT";
+    case NVME_CMD_RESV_ACQUIRE:     return "NVME_CMD_RESV_ACQUIRE";
+    case NVME_CMD_RESV_RELEASE:     return "NVME_CMD_RESV_RELEASE";
     default:                        return "NVME_NVM_CMD_UNKNOWN";
     }
 }
@@ -558,6 +562,11 @@ static inline uint8_t block_pr_cap_to_nvme(uint8_t block_pr_cap)
     return res;
 }
 
+static inline bool nvme_support_pr(NvmeNamespace *ns)
+{
+    return (ns->id_ns.rescap & NVME_PR_CAP_RW) == NVME_PR_CAP_RW;
+}
+
 typedef struct NvmeSQueue {
     struct NvmeCtrl *ctrl;
     uint16_t    sqid;
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 9b9eaeb3a7..c6436fc4bb 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -692,6 +692,13 @@ typedef enum NVMEPrCap {
     NVME_PR_CAP_WR_EX_AR = 1 << 5,
     /* Exclusive Access All Registrants reservation type */
     NVME_PR_CAP_EX_AC_AR = 1 << 6,
+    /* Write and Read reservation type */
+    NVME_PR_CAP_RW = (NVME_PR_CAP_WR_EX |
+                      NVME_PR_CAP_EX_AC |
+                      NVME_PR_CAP_WR_EX_RO |
+                      NVME_PR_CAP_EX_AC_RO |
+                      NVME_PR_CAP_WR_EX_AR |
+                      NVME_PR_CAP_EX_AC_AR),
 
     NVME_PR_CAP_ALL = (NVME_PR_CAP_PTPL |
                       NVME_PR_CAP_WR_EX |
@@ -702,6 +709,51 @@ typedef enum NVMEPrCap {
                       NVME_PR_CAP_EX_AC_AR),
 } NvmePrCap;
 
+typedef struct QEMU_PACKED NvmeReservationKeyInfo {
+    uint64_t cr_key;
+    union {
+        uint64_t nr_key;
+        uint64_t pr_key;
+    };
+} NvmeReservationKeyInfo;
+
+typedef struct QEMU_PACKED NvmeRegisteredCtrl {
+    uint16_t    cntlid;
+    uint8_t     rcsts;
+    uint8_t     rsvd3[5];
+    uint8_t     hostid[8];
+    uint64_t    rkey;
+} NvmeRegisteredCtrl;
+
+typedef struct QEMU_PACKED NvmeRegisteredCtrlExt {
+    uint16_t  cntlid;
+    uint8_t   rcsts;
+    uint8_t   rsvd3[5];
+    uint64_t  rkey;
+    uint8_t   hostid[16];
+    uint8_t   rsvd32[32];
+} NvmeRegisteredCtrlExt;
+
+typedef struct QEMU_PACKED NvmeReservationStatusHeader {
+    uint32_t  gen;
+    uint8_t   rtype;
+    uint16_t  regstrnt;
+    uint16_t  resv5;
+    uint8_t   ptpls;
+    uint8_t   resv10[14];
+} NvmeReservationStatusHeader;
+
+typedef struct QEMU_PACKED NvmeReservationStatus {
+    NvmeReservationStatusHeader header;
+    NvmeRegisteredCtrl regctl_ds[];
+} NvmeReservationStatus;
+
+typedef struct QEMU_PACKED NvmeReservationStatusExt {
+    NvmeReservationStatusHeader header;
+    uint8_t rsvd24[40];
+    NvmeRegisteredCtrlExt regctl_eds[];
+} NvmeReservationStatusExt;
+
 typedef struct QEMU_PACKED NvmeDeleteQ {
     uint8_t     opcode;
     uint8_t     flags;
@@ -1926,5 +1978,11 @@ static inline void _nvme_check_size(void)
     QEMU_BUILD_BUG_ON(sizeof(NvmeSecCtrlList) != 4096);
     QEMU_BUILD_BUG_ON(sizeof(NvmeEndGrpLog) != 512);
     QEMU_BUILD_BUG_ON(sizeof(NvmeDirectiveIdentify) != 4096);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeReservationKeyInfo) != 16);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeRegisteredCtrl) != 24);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeRegisteredCtrlExt) != 64);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeReservationStatusHeader) != 24);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeReservationStatus) != 24);
+    QEMU_BUILD_BUG_ON(sizeof(NvmeReservationStatusExt) != 64);
 }
 #endif
-- 
2.20.1


