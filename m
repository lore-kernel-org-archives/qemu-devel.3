Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BAFECA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 03:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu0Oh-00075f-9K; Wed, 03 Sep 2025 23:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uu0Of-00074u-2q; Wed, 03 Sep 2025 23:12:25 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uu0Oc-00017A-UV; Wed, 03 Sep 2025 23:12:24 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b47475cf8ecso320581a12.0; 
 Wed, 03 Sep 2025 20:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756955541; x=1757560341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kEpXSPNDBxCP+cYZ2PtOxfL9NOWp/d6+QbppZ9CHuVk=;
 b=GVF/omIm2b7NwXMjoWv5ASzGGQ8KNeRkJ2wHzcfKgYRiQh+IoIdhv/AUCChNII2WxC
 /v0a4SkeyiI8OaHwPVLffRGWnAlFGLQWmBeRxWLQiRtWBvioa+Cc8NtJ/43vpewqMTvK
 tQ5sBcaLfL4Drr3MpjtiBPIluI+PgMc5NmedLLQ0q9uVz2y5bNshlcGp7kFHI1EfOf76
 WLr8/Z6Vy3AD77oycB5SaSn5r73DrzCa2TxlRBeXeQGtdEVIaRoKgNyaGBsRSfgmGtmZ
 BClpILaooI5TfZmtMCaTTjHbhGbZmbzb66sVnaRvRwqcvsx5bms8filHQ9zjFpq7mh/B
 pz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756955541; x=1757560341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kEpXSPNDBxCP+cYZ2PtOxfL9NOWp/d6+QbppZ9CHuVk=;
 b=QMgBxrz0Jzf8fIjX1orAXJTvMtvTpW2HD10oK8kZiF9DWaqecz6uGwxM/STTBm20co
 N0r4DOm+kI4RVni9ylunpfT18ewbb51WEEt0EZpuBnyFr0Saj6Rfzc4X3TMHP/d3lL7p
 Nf+UwKCzx8BJuHBjLSRIxOtKlc7qeXx4GwySIfxX3Lwja+VXJd1T16/4Fa8e78vqRkZn
 8n5ScgQhOps8oyHMVK6Gb0dN3TEhACM7OYL53Y8XKKI1a+ePK3yQoeYHo6vPK6e1Ldw3
 PqRYckNDSfe01DSmo2f9cqTdFAa6zHtvMC/aJSLA5DVC6jc5k98+MS8HzlZNeZQdihZp
 WEtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9OS8fDh0dXqDBREtJ1xa5kevblnR+GAp49XoDwlxWZfe5tVCr0qXYaC6UQl19xCPRyEHsp890ERVc@nongnu.org,
 AJvYcCXVlRh4JAfC3EfxKRxVMTH5kqDrEZKGnBgvdR/GKnpAYxf3igxKt/OmlvS36it3tePgPgX3CXbGTYT8Vw==@nongnu.org
X-Gm-Message-State: AOJu0Yy+8Vrs81aPlMtkUOAvC0OgIu3BjDkeWkFZqFVDQBomZ1vLaPeS
 D8N3o7RYotLNmAeZFJT1hV+eHzPq96S3rHqbPjA5otnPIzDEaHCmIwqy
X-Gm-Gg: ASbGncv5L32u7UW6xGx3fhW5wB49d0G0/ZNMf0QLxKj3rCD01HVF8CTZgjKb0jc/DPZ
 tg5gSzbYUomS0eppQWLJ9olgNR+PShgeisiJ7q4ltN+GUlW+NVZdEtJDcOnXWBiKCCO31IuZcPt
 0W8YANmjvX/vs1jwAbVZVtYoBTQspjIr3b0/xWSSLg5+FPyKNiy5UOnc6VnmpXDECMThxyyfdzt
 AY6fKTWYmjfGOUWmbNEfxzFWQ9Z37XexpuSs+lhUXlurSrTloldVY4VFJXEqskw1iMuiq82LgMr
 +BaKtCUZuc3dX4i0/dE9mqSdLBSTPKXN7AAEwm8mmz413pZenV6JE1VzTcos2P03gSAjwcR/w4c
 KsotUCncWfnLHZc7v1R7Jblxd5hnp7mf7Km3sK6aVcBXIzzw=
X-Google-Smtp-Source: AGHT+IF8HMWx7YA1EZNmhYoY9AVjqYpWuvgEzbCnaFaXEt2fC1t4Ao1sgjUegBjCFZ5TO0LDt3DKGQ==
X-Received: by 2002:a17:902:f68a:b0:24c:bc02:78b5 with SMTP id
 d9443c01a7336-24cbc029261mr26492325ad.20.1756955540851; 
 Wed, 03 Sep 2025 20:12:20 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490375a9ccsm176497715ad.63.2025.09.03.20.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 20:12:20 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, dlemoal@kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v4 3/5] hw/nvme: add NVMe Admin Security SPDM support
Date: Thu,  4 Sep 2025 13:10:57 +1000
Message-ID: <20250904031058.367667-5-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904031058.367667-2-wilfred.opensource@gmail.com>
References: <20250904031058.367667-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Adds the NVMe Admin Security Send/Receive command support with support
for DMTFs SPDM. The transport binding for SPDM is defined in the
DMTF DSP0286.

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 hw/nvme/ctrl.c       | 213 ++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h       |   5 +
 include/block/nvme.h |  15 +++
 3 files changed, 232 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f5ee6bf260..df72599bcc 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -282,6 +282,8 @@ static const uint32_t nvme_cse_acs_default[256] = {
     [NVME_ADM_CMD_FORMAT_NVM]       = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_ADM_CMD_DIRECTIVE_RECV]   = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_DIRECTIVE_SEND]   = NVME_CMD_EFF_CSUPP,
+    [NVME_ADM_CMD_SECURITY_SEND]   = NVME_CMD_EFF_CSUPP,
+    [NVME_ADM_CMD_SECURITY_RECV]   = NVME_CMD_EFF_CSUPP,
 };
 
 static const uint32_t nvme_cse_iocs_nvm_default[256] = {
@@ -7282,6 +7284,210 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
+static uint16_t nvme_sec_prot_spdm_send(NvmeCtrl *n, NvmeRequest *req)
+{
+    StorageSpdmTransportHeader hdr = {0};
+    g_autofree uint8_t *sec_buf = NULL;
+    uint32_t transfer_len = le32_to_cpu(req->cmd.cdw11);
+    uint32_t transport_transfer_len = transfer_len;
+    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
+    uint32_t recvd;
+    uint16_t nvme_cmd_status, ret;
+    uint8_t secp = extract32(dw10, 24, 8);
+    uint8_t spsp1 = extract32(dw10, 16, 8);
+    uint8_t spsp0 = extract32(dw10, 8, 8);
+    bool spdm_res;
+
+    if (transport_transfer_len > UINT32_MAX - sizeof(hdr)) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    transport_transfer_len += sizeof(hdr);
+    if (transport_transfer_len > SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    ret = nvme_check_mdts(n, transport_transfer_len);
+    if (ret != NVME_SUCCESS) {
+        return ret;
+    }
+
+    /* Generate the NVMe transport header */
+    hdr.security_protocol = secp;
+    hdr.security_protocol_specific = cpu_to_le16((spsp1 << 8) | spsp0);
+    hdr.length = cpu_to_le32(transfer_len);
+
+    sec_buf = g_try_malloc0(transport_transfer_len);
+    if (!sec_buf) {
+        return NVME_INTERNAL_DEV_ERROR;
+    }
+
+    /* Attach the transport header */
+    memcpy(sec_buf, &hdr, sizeof(hdr));
+    ret = nvme_h2c(n, sec_buf + sizeof(hdr), transfer_len, req);
+    if (ret) {
+        return ret;
+    }
+
+    spdm_res = spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CMD_IF_SEND,
+                                SPDM_SOCKET_TRANSPORT_TYPE_NVME, sec_buf,
+                                transport_transfer_len);
+    if (!spdm_res) {
+        return NVME_DATA_TRAS_ERROR | NVME_DNR;
+    }
+
+    /* The responder shall ack with message status */
+    recvd = spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+                                (uint8_t *)&nvme_cmd_status,
+                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);
+
+    nvme_cmd_status = be16_to_cpu(nvme_cmd_status);
+
+    if (recvd < SPDM_SOCKET_MAX_MSG_STATUS_LEN) {
+        return NVME_DATA_TRAS_ERROR | NVME_DNR;
+    }
+
+    return nvme_cmd_status;
+}
+
+/* From host to controller */
+static uint16_t nvme_security_send(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
+    uint8_t secp = (dw10 >> 24) & 0xff;
+
+    switch (secp) {
+    case NVME_SEC_PROT_DMTF_SPDM:
+        if (n->spdm_socket <= 0) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+        return nvme_sec_prot_spdm_send(n, req);
+    default:
+        /* Unsupported Security Protocol Type */
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return NVME_INVALID_FIELD | NVME_DNR;
+}
+
+static uint16_t nvme_sec_prot_spdm_receive(NvmeCtrl *n, NvmeRequest *req)
+{
+    StorageSpdmTransportHeader hdr;
+    g_autofree uint8_t *rsp_spdm_buf = NULL;
+    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
+    uint32_t alloc_len = le32_to_cpu(req->cmd.cdw11);
+    uint32_t recvd, spdm_res;
+    uint16_t nvme_cmd_status, ret;
+    uint8_t secp = extract32(dw10, 24, 8);
+    uint8_t spsp1 = extract32(dw10, 16, 8);
+    uint8_t spsp0 = extract32(dw10, 8, 8);
+
+    if (!alloc_len) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    /* Generate the NVMe transport header */
+    hdr = (StorageSpdmTransportHeader) {
+        .security_protocol = secp,
+        .security_protocol_specific = cpu_to_le16((spsp1 << 8) | spsp0),
+        .length = cpu_to_le32(alloc_len),
+    };
+
+    /* Forward if_recv to the SPDM Server with SPSP0 */
+    spdm_res = spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CMD_IF_RECV,
+                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+                                (uint8_t *)&hdr, sizeof(hdr));
+    if (!spdm_res) {
+        return NVME_DATA_TRAS_ERROR | NVME_DNR;
+    }
+
+    /* The responder shall ack with message status */
+    recvd = spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+                                (uint8_t *)&nvme_cmd_status,
+                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);
+    if (recvd < SPDM_SOCKET_MAX_MSG_STATUS_LEN) {
+        return NVME_DATA_TRAS_ERROR | NVME_DNR;
+    }
+
+    nvme_cmd_status = be16_to_cpu(nvme_cmd_status);
+    /* An error here implies the prior if_recv from requester was spurious */
+    if (nvme_cmd_status != NVME_SUCCESS) {
+        return nvme_cmd_status;
+    }
+
+    /* Clear to start receiving data from the server */
+    rsp_spdm_buf = g_try_malloc0(alloc_len);
+    if (!rsp_spdm_buf) {
+        return NVME_INTERNAL_DEV_ERROR;
+    }
+
+    recvd = spdm_socket_receive(n->spdm_socket,
+                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+                                rsp_spdm_buf, alloc_len);
+    if (!recvd) {
+        return NVME_DATA_TRAS_ERROR | NVME_DNR;
+    }
+
+    ret = nvme_c2h(n, rsp_spdm_buf, MIN(recvd, alloc_len), req);
+    if (ret) {
+        return ret;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_get_sec_prot_info(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint32_t alloc_len = le32_to_cpu(req->cmd.cdw11);
+    uint8_t resp[10] = {
+        /* Support Security Protol List Length */
+        [6] = 0, /* MSB */
+        [7] = 2, /* LSB */
+        /* Support Security Protocol List */
+        [8] = SFSC_SECURITY_PROT_INFO,
+        [9] = 0,
+    };
+
+    if (n->spdm_socket > 0) {
+        resp[9] = NVME_SEC_PROT_DMTF_SPDM;
+    }
+
+    if (alloc_len < 10) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    return nvme_c2h(n, resp, sizeof(resp), req);
+}
+
+/* From controller to host */
+static uint16_t nvme_security_receive(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
+    uint16_t spsp = extract32(dw10, 8, 16);
+    uint8_t secp = extract32(dw10, 24, 8);
+
+    switch (secp) {
+    case SFSC_SECURITY_PROT_INFO:
+        switch (spsp) {
+        case 0:
+            /* Supported security protocol list */
+            return nvme_get_sec_prot_info(n, req);
+        case 1:
+            /* Certificate data */
+            /* fallthrough */
+        default:
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+    case NVME_SEC_PROT_DMTF_SPDM:
+        if (n->spdm_socket <= 0) {
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+        return nvme_sec_prot_spdm_receive(n, req);
+    default:
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+}
+
 static uint16_t nvme_directive_send(NvmeCtrl *n, NvmeRequest *req)
 {
     return NVME_INVALID_FIELD | NVME_DNR;
@@ -7389,6 +7595,10 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
         return nvme_directive_send(n, req);
     case NVME_ADM_CMD_DIRECTIVE_RECV:
         return nvme_directive_receive(n, req);
+    case NVME_ADM_CMD_SECURITY_SEND:
+        return nvme_security_send(n, req);
+    case NVME_ADM_CMD_SECURITY_RECV:
+        return nvme_security_receive(n, req);
     default:
         g_assert_not_reached();
     }
@@ -8824,7 +9034,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
     id->mdts = n->params.mdts;
     id->ver = cpu_to_le32(NVME_SPEC_VER);
 
-    oacs = NVME_OACS_NMS | NVME_OACS_FORMAT | NVME_OACS_DIRECTIVES;
+    oacs = NVME_OACS_NMS | NVME_OACS_FORMAT | NVME_OACS_DIRECTIVES |
+           NVME_OACS_SECURITY;
 
     if (n->params.dbcs) {
         oacs |= NVME_OACS_DBCS;
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index b5c9378ea4..67ed562e00 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -461,6 +461,8 @@ static inline const char *nvme_adm_opc_str(uint8_t opc)
     case NVME_ADM_CMD_DIRECTIVE_RECV:   return "NVME_ADM_CMD_DIRECTIVE_RECV";
     case NVME_ADM_CMD_DBBUF_CONFIG:     return "NVME_ADM_CMD_DBBUF_CONFIG";
     case NVME_ADM_CMD_FORMAT_NVM:       return "NVME_ADM_CMD_FORMAT_NVM";
+    case NVME_ADM_CMD_SECURITY_SEND:    return "NVME_ADM_CMD_SECURITY_SEND";
+    case NVME_ADM_CMD_SECURITY_RECV:    return "NVME_ADM_CMD_SECURITY_RECV";
     default:                            return "NVME_ADM_CMD_UNKNOWN";
     }
 }
@@ -648,6 +650,9 @@ typedef struct NvmeCtrl {
     } next_pri_ctrl_cap;    /* These override pri_ctrl_cap after reset */
     uint32_t    dn; /* Disable Normal */
     NvmeAtomic  atomic;
+
+    /* Socket mapping to SPDM over NVMe Security In/Out commands */
+    int spdm_socket;
 } NvmeCtrl;
 
 typedef enum NvmeResetType {
diff --git a/include/block/nvme.h b/include/block/nvme.h
index 358e516e38..9fa2ecaf28 100644
--- a/include/block/nvme.h
+++ b/include/block/nvme.h
@@ -1779,6 +1779,21 @@ enum NvmeDirectiveOperations {
     NVME_DIRECTIVE_RETURN_PARAMS = 0x1,
 };
 
+typedef enum SfscSecurityProtocol {
+    SFSC_SECURITY_PROT_INFO = 0x00,
+} SfscSecurityProtocol;
+
+typedef enum NvmeSecurityProtocols {
+    NVME_SEC_PROT_DMTF_SPDM    = 0xE8,
+} NvmeSecurityProtocols;
+
+typedef enum SpdmOperationCodes {
+    SPDM_STORAGE_DISCOVERY      = 0x1, /* Mandatory */
+    SPDM_STORAGE_PENDING_INFO   = 0x2, /* Optional */
+    SPDM_STORAGE_MSG            = 0x5, /* Mandatory */
+    SPDM_STORAGE_SEC_MSG        = 0x6, /* Optional */
+} SpdmOperationCodes;
+
 typedef struct QEMU_PACKED NvmeFdpConfsHdr {
     uint16_t num_confs;
     uint8_t  version;
-- 
2.51.0


