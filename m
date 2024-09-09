Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF8FECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 11:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sncgW-0003M5-Am; Mon, 09 Sep 2024 07:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sncgS-00037D-Sr
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 07:35:54 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sncgP-00017e-Qp
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 07:35:52 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2053f6b8201so40502895ad.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 04:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1725881748; x=1726486548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZvPLYaXrT8bFqHr6N5Pat75I88yipYcf/fKAy/sjr4=;
 b=ZWu4xQcNnjE/e8a4zRNWi2C42mEPz7wbxfg98j0LqY9VJUoUNmbpM3HCIJmnc9eBQF
 7LaYGJ+TSOTrHlLnwAHIruetgtyMnuE9r0TmoqCpJ1JgjS+07Tg6cbqgxUZFjpD8Q7Nw
 jJXXg+vq3+VNCC2Bc22ZG6ETPSnByq3yumyIpAi2SkKQISsa1K6QBHnuaAIUnlohxPEm
 1GoLOO+Jt2FFiZfzO0M2/MP1n99YKNWd7XgyY4YYn1Iwjm73wYOXWnJMc7ZFAN8ra+64
 1pnSyL7Ffz0QMAekauEIgnqauK22L6FwGXZUo3rgN1aVOjhIluE3pnOl84JEcFRFINyR
 4Y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725881748; x=1726486548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MZvPLYaXrT8bFqHr6N5Pat75I88yipYcf/fKAy/sjr4=;
 b=n6zbNUP1aSswAjpxrajqoC5aRsc0JYQf7BydSHQmuk07Ln5mrxbQ2azTtNIj/nEMkI
 9q7o4TW2rABQRxOA42J/R1U49lj5tgZ+e491+hgBoVtB32Se6hVlZrlUVex+iT1bKYWx
 SRjoPbq6TDs/4RSR+YHJOVqmOZp/GLLPWx7slmqPJMGedx2u0LWSySVEAg/1+fPhXYLD
 flNIjQ1YAUMTvCCLgM6muB4Z3wPLC3PbWjNLrjAUZRZtJhgOeTocbY02RKAWtoxvXJLo
 JSLb9yp+c3VvsB/tXRXTHimYaGtyqLEktH4YPwITXrEPFVpGtwHCl4S0F6FWl2XntD+E
 3QHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqbtunheMN5IIS/hlRgLPqPvKRXdc48BDBROFXDA5qC6rr6zuxSEObXc12bV1THuHrj9YPrlt+llk0@nongnu.org
X-Gm-Message-State: AOJu0YxunO4afozNWtzT+yyATrImyo/OaVbOmLrv46UB9CxzygyiRrXz
 HfJe+sck1zG1NpFLg53/uv6C5Y16r9NnwrPx6yE4tHE0eFUq8VpJKVYM6oAEKn8=
X-Google-Smtp-Source: AGHT+IEKAEWpv/IeZc6wfpINfDRNhqvI8LlDdAKqX7ogW2UtSGjpaXu/GistfWI4eMNRlhRlBOKbjw==
X-Received: by 2002:a17:903:2343:b0:205:7551:36b0 with SMTP id
 d9443c01a7336-206f04c9cffmr179382095ad.4.1725881747989; 
 Mon, 09 Sep 2024 04:35:47 -0700 (PDT)
Received: from TF4D9JK212.bytedance.net ([61.213.176.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e328aasm32378605ad.91.2024.09.09.04.35.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Sep 2024 04:35:47 -0700 (PDT)
From: Changqi Lu <luchangqi.123@bytedance.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net,
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de,
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com, k.jensen@samsung.com,
 Changqi Lu <luchangqi.123@bytedance.com>
Subject: [PATCH v11 09/10] hw/nvme: add reservation protocal command
Date: Mon,  9 Sep 2024 19:34:52 +0800
Message-Id: <20240909113453.64527-10-luchangqi.123@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20240909113453.64527-1-luchangqi.123@bytedance.com>
References: <20240909113453.64527-1-luchangqi.123@bytedance.com>
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
 hw/nvme/ctrl.c       | 346 +++++++++++++++++++++++++++++++++++++++++++
 hw/nvme/ns.c         |   6 +
 hw/nvme/nvme.h       |   9 ++
 include/block/nvme.h |  44 ++++++
 4 files changed, 405 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index ad212de723..ba98b86f9c 100644
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
@@ -1747,6 +1755,13 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
     case NVME_CMD_READ:
         status = NVME_UNRECOVERED_READ;
         break;
+    case NVME_CMD_RESV_REPORT:
+        if (ret == -ENOTSUP) {
+            status = NVME_INVALID_OPCODE;
+        } else {
+            status = NVME_UNRECOVERED_READ;
+        }
+        break;
     case NVME_CMD_FLUSH:
     case NVME_CMD_WRITE:
     case NVME_CMD_WRITE_ZEROES:
@@ -1754,6 +1769,15 @@ static void nvme_aio_err(NvmeRequest *req, int ret)
     case NVME_CMD_COPY:
         status = NVME_WRITE_FAULT;
         break;
+    case NVME_CMD_RESV_REGISTER:
+    case NVME_CMD_RESV_ACQUIRE:
+    case NVME_CMD_RESV_RELEASE:
+        if (ret == -ENOTSUP) {
+            status = NVME_INVALID_OPCODE;
+        } else {
+            status = NVME_WRITE_FAULT;
+        }
+        break;
     default:
         status = NVME_INTERNAL_DEV_ERROR;
         break;
@@ -2692,6 +2716,320 @@ static uint16_t nvme_verify(NvmeCtrl *n, NvmeRequest *req)
     return NVME_NO_COMPLETE;
 }
 
+typedef struct NvmeKeyInfo {
+    uint64_t cr_key;
+    uint64_t nr_key;
+} NvmeKeyInfo;
+
+static uint16_t nvme_resv_register(NvmeCtrl *n, NvmeRequest *req)
+{
+    int ret;
+    NvmeKeyInfo key_info;
+    NvmeNamespace *ns = req->ns;
+    uint32_t cdw10 = le32_to_cpu(req->cmd.cdw10);
+    bool ignore_key = cdw10 >> 3 & 0x1;
+    uint8_t action = cdw10 & 0x7;
+    uint8_t ptpl = cdw10 >> 30 & 0x3;
+    bool aptpl;
+
+    if (!nvme_support_pr(ns)) {
+        return NVME_INVALID_OPCODE;
+    }
+
+    switch (ptpl) {
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
+    ret = nvme_h2c(n, (uint8_t *)&key_info, sizeof(NvmeKeyInfo), req);
+    if (ret) {
+        return ret;
+    }
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
+    NvmeResvType type = cdw10 >> 8 & 0xff;
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
+    NvmeKeyInfo key_info;
+    NvmeNamespace *ns = req->ns;
+    uint32_t cdw10 = le32_to_cpu(req->cmd.cdw10);
+    uint8_t action = cdw10 & 0x7;
+    NvmeResvType type = cdw10 >> 8 & 0xff;
+
+    if (!nvme_support_pr(ns)) {
+        return NVME_INVALID_OPCODE;
+    }
+
+    ret = nvme_h2c(n, (uint8_t *)&key_info, sizeof(NvmeKeyInfo), req);
+    if (ret) {
+        return ret;
+    }
+
+    switch (action) {
+    case NVME_RESV_ACQUIRE_ACTION_ACQUIRE:
+        req->aiocb = blk_aio_pr_reserve(ns->blkconf.blk, key_info.cr_key,
+                                        nvme_pr_type_to_block(type),
+                                        nvme_misc_cb, req);
+        break;
+    case NVME_RESV_ACQUIRE_ACTION_PREEMPT:
+        req->aiocb = blk_aio_pr_preempt(ns->blkconf.blk,
+                     key_info.cr_key, key_info.nr_key,
+                     nvme_pr_type_to_block(type),
+                     false, nvme_misc_cb, req);
+        break;
+    case NVME_RESV_ACQUIRE_ACTION_PREEMPT_AND_ABORT:
+        req->aiocb = blk_aio_pr_preempt(ns->blkconf.blk, key_info.cr_key,
+                                        key_info.nr_key, type, true,
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
+    nvme_status = g_malloc(len);
+    nvme_status->header.gen = reservation->generation;
+    nvme_status->header.rtype = block_pr_type_to_nvme(reservation->type);
+    nvme_status->header.regctl = keys_info->num_keys;
+    for (int i = 0; i < keys_info->num_keys; i++) {
+        nvme_status->regctl_ds[i].cntlid = nvme_ctrl(req)->cntlid;
+        nvme_status->regctl_ds[i].rkey = keys_info->keys[i];
+        nvme_status->regctl_ds[i].rcsts = keys_info->keys[i] ==
+                                          reservation->key ? 1 : 0;
+        /* hostid is not supported currently */
+        memset(&nvme_status->regctl_ds[i].hostid, 0, 8);
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
+    int len = sizeof(NvmeReservationStatusHeader) +
+              sizeof(uint8_t) * 40 +
+              sizeof(NvmeRegisteredCtrlExt) * keys_info->num_keys;
+
+    nvme_status_ext = g_malloc(len);
+    nvme_status_ext->header.gen = cpu_to_be32(reservation->generation);
+    nvme_status_ext->header.rtype = block_pr_type_to_nvme(reservation->type);
+    nvme_status_ext->header.regctl = cpu_to_be16(keys_info->num_keys);
+
+    for (int i = 0; i < keys_info->num_keys; i++) {
+        uint16_t ctnlid = nvme_ctrl(req)->cntlid;
+        nvme_status_ext->regctl_eds[i].cntlid = cpu_to_be16(ctnlid);
+        nvme_status_ext->regctl_eds[i].rkey = cpu_to_be64(keys_info->keys[i]);
+        nvme_status_ext->regctl_eds[i].rcsts = keys_info->keys[i] ==
+                                               reservation->key ? 1 : 0;
+        /* hostid is not supported currently */
+        memset(&nvme_status_ext->regctl_eds[i].hostid, 0, 16);
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
+    bool eds = req->cmd.cdw11 & 0x1;
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
+    memset(reservation, 0, sizeof(*reservation));
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
+    uint32_t cdw10 = req->cmd.cdw10;
+    uint32_t cdw11 = req->cmd.cdw11;
+    int buflen = (cdw10 + 1) * sizeof(uint32_t);
+    bool eds = cdw11 & 0x1;
+    NvmeNamespace *ns = req->ns;
+    NvmeResvKeys *keys_info;
+
+    if (!nvme_support_pr(ns)) {
+        return NVME_INVALID_OPCODE;
+    }
+
+    if (eds) {
+        if (buflen < sizeof(NvmeReservationStatusHeader) +
+           sizeof(uint8_t) * 40) {
+            return NVME_INVALID_FIELD;
+        }
+
+        num_keys = (buflen - sizeof(NvmeReservationStatusHeader) -
+                   sizeof(uint8_t) * 40) /
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
+    keys_info->generation = 0;
+    /* num_keys is the maximum number of keys that can be transmitted */
+    keys_info->num_keys = num_keys;
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
@@ -4469,6 +4807,14 @@ static uint16_t nvme_io_cmd(NvmeCtrl *n, NvmeRequest *req)
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
index 9b9eaeb3a7..2eec339028 100644
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
@@ -702,6 +709,43 @@ typedef enum NVMEPrCap {
                       NVME_PR_CAP_EX_AC_AR),
 } NvmePrCap;
 
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
+    uint16_t  regctl;
+    uint16_t  resv5;
+    uint8_t   ptpls;
+    uint8_t   resv10[14];
+} NvmeReservationStatusHeader;
+
+typedef struct QEMU_PACKED NvmeReservationStatus {
+    struct NvmeReservationStatusHeader header;
+    struct NvmeRegisteredCtrl regctl_ds[];
+} NvmeReservationStatus;
+
+typedef struct QEMU_PACKED NvmeReservationStatusExt {
+    struct NvmeReservationStatusHeader header;
+    uint8_t   rsvd24[40];
+    struct NvmeRegisteredCtrlExt regctl_eds[];
+} NvmeReservationStatusExt;
+
 typedef struct QEMU_PACKED NvmeDeleteQ {
     uint8_t     opcode;
     uint8_t     flags;
-- 
2.20.1


