Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB35CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 05:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqmWo-0000fw-6H; Tue, 26 Aug 2025 01:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uqmWf-0000c7-4E; Tue, 26 Aug 2025 01:47:23 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uqmWY-0007GY-V0; Tue, 26 Aug 2025 01:47:20 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-771f3f89952so610803b3a.0; 
 Mon, 25 Aug 2025 22:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756187230; x=1756792030; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BjzK5ZkTCKLDWpara3x77Oouy5dA+HljQA8qiCuWPI=;
 b=I+Pzxg5jrOCp9Mbpy5YLoC3Ij6QU9pMF7uoDblmrCYC033xaAE+v60IRta88KeAh3B
 UJDoPket4DmvtXb7iGteUCN4I9KStRsE8HBqEiALoMLRbzEN6204ixRSUCFNPPY1Onwg
 lig7ZSGesUeEjoc4FPhh7oudrUdMBz7dnlpBq3VtsAfy+F7/Wzv+kulGLnEyXwkNi0dc
 yqcrdLuaaBkq2mjA+wW3dAohzCZfvzdoIE2JFXbc90z6/VJj0okPfAjbBMhtzbRXSvZY
 xq4BKxw1lPW6EqsXOWKXH3IYo9JlNuvaktLnWQNClVDh7/qHCszwJF+YOgq07t1Db/7N
 C03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756187230; x=1756792030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9BjzK5ZkTCKLDWpara3x77Oouy5dA+HljQA8qiCuWPI=;
 b=J7FXSDy4fjYeQaiYuCbLVr1RS4T8xCS374ZhdhPbtnxQA7eMCivYJLt/OtSIlFl3he
 6KDpk07i1Wc6mH7L92VGM+PngOlNuvURrBwH0TMdXoG2reh9FXJUBMLITXX95UQ0Y1kU
 syefrNCrCXZnRKIoAUG6jQsdJLDVhygm1Rkkq4UF1VGnXKO2BZmOd17C2SMlKRQLJgv6
 XnEHeM7FrssYTfe+9JGobfVxrV23KZcONDQMoZKj9DQM6BF3R3+B26QbzsbY+gFhzbxG
 tmCVVhVqPLXsP019bSggImIgi+SjYDRokEauKe7BrRaTB8ap0RC/k3Tm/bLSRxcIEW+X
 L+GA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmsAvDvot6AvnAWhp0vQU6eGD7WPqv2QUErMVtL0CdoeoozH4CZcOhQNnU6k7CT7GKU0DnTQcePS8esw==@nongnu.org,
 AJvYcCXIWdYIrilbTlEoP3nsLEGrs9kSgyM+SHVBkTm6XDNkADeKmjsLdBwu+vpDBpSK0D4f8X1SsWIUvpDr@nongnu.org
X-Gm-Message-State: AOJu0YwPhuPVbwDdUqtwc1NJblehiUGum0aOWAVJi9YEqJlHpNJ191mc
 5GrZLLwbaFow4wUjh4ppVOK+zg/si3R1jt8dRomflYXuTwtWkeibM2+z
X-Gm-Gg: ASbGncsmYLgfqcJORblbV7Tj652Zt0eiav4YLOPUtsTxaUQ2gYj3aHkdUlBtpNUPWpx
 Lgp9mIExCUF8B9Ya9LSdy0dGybmkrRRCfBPAU8LUtElsLRXvt/2xxltlrkHXlka2S8CYYq9kMtm
 XWTyHmTp4D/rcWLUxznEeVWMEKqRuHFtWR5so/WcbM7x+4qrJlNn6qkPRzckqeW20cINtemUy13
 3QftvQ1pXg4GkXJEcbxsBk6GfhA5L4Ecez3/SPE85kJffFyYcRvBkTQSh8OyvspyVxOAxqYQkAW
 i2o8kVHYRhVhvXXIunmFedwOlWA8a0StjcpAnrijplsuq298BNhf+CF/YduW2UGQEOxGr16ti8A
 f27B/r8V/ME4PRXIASbxH3243XgY+88Bg66qp
X-Google-Smtp-Source: AGHT+IFdThN6dFmBweKlCpabGlr2Ear6ZaZNmXxMNLuiW4Ripm6pAn9yMLKB1of1wFK5EPxQ8Rp4cA==
X-Received: by 2002:aa7:9e06:0:b0:746:195b:bf1c with SMTP id
 d2e1a72fcca58-771fc293053mr253765b3a.10.1756187230204; 
 Mon, 25 Aug 2025 22:47:10 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-770401afdaesm9032365b3a.53.2025.08.25.22.47.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 22:47:09 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH 3/4] hw/nvme: add NVMe Admin Security SPDM support
Date: Tue, 26 Aug 2025 15:46:29 +1000
Message-ID: <20250826054630.222052-4-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826054630.222052-1-wilfred.opensource@gmail.com>
References: <20250826054630.222052-1-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pf1-x430.google.com
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
 hw/nvme/ctrl.c       | 202 ++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h       |   5 ++
 include/block/nvme.h |  15 ++++
 3 files changed, 221 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f5ee6bf260..442144642d 100644
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
@@ -7282,6 +7284,199 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
     return NVME_SUCCESS;
 }
 
+static uint16_t nvme_sec_prot_spdm_send(NvmeCtrl *n, NvmeRequest *req)
+{
+    StorageSpdmTransportHeader hdr = {0};
+    uint8_t *sec_buf;
+    uint32_t transfer_len = le32_to_cpu(req->cmd.cdw11);
+    uint32_t transport_transfer_len = transfer_len;
+    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
+    uint32_t recvd;
+    uint16_t nvme_cmd_status;
+    uint16_t ret;
+    uint8_t secp = (dw10 >> 24) & 0xFF;
+    uint8_t spsp1 = (dw10 >> 16) & 0xFF;
+    uint8_t spsp0 = (dw10 >> 8) & 0xFF;
+    bool spdm_res;
+
+    transport_transfer_len += sizeof(hdr);
+    if (transport_transfer_len > SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE) {
+        return NVME_NO_COMPLETE | NVME_DNR;
+    }
+
+    /* Generate the NVMe transport header */
+    hdr.security_protocol = secp;
+    hdr.security_protocol_specific = cpu_to_le16((spsp1 << 8) | spsp0);
+    hdr.length = cpu_to_le32(transfer_len);
+
+    sec_buf = g_malloc0(transport_transfer_len);
+    if (!sec_buf) {
+        return NVME_NO_COMPLETE | NVME_DNR;
+    }
+
+    /* Attach the transport header */
+    memcpy(sec_buf, &hdr, sizeof(hdr));
+    ret = nvme_h2c(n, sec_buf + sizeof(hdr), transfer_len, req);
+    if (ret) {
+        return NVME_NO_COMPLETE | NVME_DNR;
+    }
+
+    spdm_res = spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CMD_IF_SEND,
+                                SPDM_SOCKET_TRANSPORT_TYPE_NVME, sec_buf,
+                                transport_transfer_len);
+    if (!spdm_res) {
+        g_free(sec_buf);
+        return NVME_NO_COMPLETE | NVME_DNR;
+    }
+
+    /* The responder shall ack with message status */
+    recvd = spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+                                (uint8_t *)&nvme_cmd_status,
+                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);
+
+    nvme_cmd_status = cpu_to_be16(nvme_cmd_status);
+
+    if (recvd < SPDM_SOCKET_MAX_MSG_STATUS_LEN) {
+        g_free(sec_buf);
+        return NVME_NO_COMPLETE | NVME_DNR;
+    }
+
+    g_free(sec_buf);
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
+    StorageSpdmTransportHeader hdr = {0};
+    uint8_t *rsp_spdm_buf;
+    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
+    uint32_t alloc_len = le32_to_cpu(req->cmd.cdw11);
+    uint32_t recvd, spdm_res;
+    uint16_t nvme_cmd_status;
+    uint16_t ret;
+    uint8_t secp = (dw10 >> 24) & 0xFF;
+    uint8_t spsp1 = (dw10 >> 16) & 0xFF;
+    uint8_t spsp0 = (dw10 >> 8) & 0xFF;
+
+    if (!alloc_len) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    /* Generate the NVMe transport header */
+    hdr.security_protocol = secp;
+    hdr.security_protocol_specific = cpu_to_le16((spsp1 << 8) | spsp0);
+    hdr.length = cpu_to_le32(alloc_len);
+
+    /* Forward if_recv to the SPDM Server with SPSP0 */
+    spdm_res = spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CMD_IF_RECV,
+                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+                                (uint8_t *)&hdr, sizeof(hdr));
+    if (!spdm_res) {
+        return NVME_NO_COMPLETE | NVME_DNR;
+    }
+
+    /* The responder shall ack with message status */
+    recvd = spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+                                (uint8_t *)&nvme_cmd_status,
+                                SPDM_SOCKET_MAX_MSG_STATUS_LEN);
+
+    nvme_cmd_status = cpu_to_be16(nvme_cmd_status);
+
+
+    if (recvd < SPDM_SOCKET_MAX_MSG_STATUS_LEN) {
+        return NVME_NO_COMPLETE | NVME_DNR;
+    }
+
+    /* An error here implies the prior if_recv from requester was spurious */
+    if (nvme_cmd_status != NVME_SUCCESS) {
+        return nvme_cmd_status;
+    }
+
+    /* Clear to start receiving data from the server */
+    rsp_spdm_buf = g_malloc0(alloc_len);
+    if (!rsp_spdm_buf) {
+        return NVME_NO_COMPLETE | NVME_DNR;
+    }
+
+    recvd = spdm_socket_receive(n->spdm_socket,
+                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+                                rsp_spdm_buf, alloc_len);
+    if (!recvd) {
+        g_free(rsp_spdm_buf);
+        return NVME_NO_COMPLETE | NVME_DNR;
+    }
+
+    ret = nvme_c2h(n, rsp_spdm_buf, MIN(recvd, alloc_len), req);
+    g_free(rsp_spdm_buf);
+
+    if (ret) {
+        return NVME_NO_COMPLETE | NVME_DNR;
+    }
+
+    return NVME_SUCCESS;
+}
+
+static uint16_t nvme_get_sec_prot_info(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint32_t alloc_len = le32_to_cpu(req->cmd.cdw11);
+    uint8_t resp[10] = {0};
+
+    if (alloc_len < 10) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    /* Support Security Protol List Length */
+    resp[6] = 0; /* MSB */
+    resp[7] = 2; /* LSB */
+    /* Support Security Protocol List */
+    resp[8] = SFSC_SECURITY_PROT_INFO;
+    resp[9] = NVME_SEC_PROT_DMTF_SPDM;
+
+    return nvme_c2h(n, resp, sizeof(resp), req);
+}
+
+/* From controller to host */
+static uint16_t nvme_security_receive(NvmeCtrl *n, NvmeRequest *req)
+{
+    uint32_t dw10 = le32_to_cpu(req->cmd.cdw10);
+    uint16_t spsp = (dw10 >> 8) & 0xFFFF;
+    uint8_t secp = (dw10 >> 24) & 0xFF;
+
+    switch (secp) {
+    case SFSC_SECURITY_PROT_INFO:
+        switch (spsp) {
+        case 0:
+            /* Supported security protocol list */
+            return nvme_get_sec_prot_info(n, req);
+        case 1:
+            /* Certificate data */
+        default:
+            return NVME_INVALID_FIELD | NVME_DNR;
+        }
+    case NVME_SEC_PROT_DMTF_SPDM:
+        return nvme_sec_prot_spdm_receive(n, req);
+    default:
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+}
+
 static uint16_t nvme_directive_send(NvmeCtrl *n, NvmeRequest *req)
 {
     return NVME_INVALID_FIELD | NVME_DNR;
@@ -7389,6 +7584,10 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
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
@@ -8824,7 +9023,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
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


