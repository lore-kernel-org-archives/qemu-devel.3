Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8952FCA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 03:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usvY4-0002UI-BR; Sun, 31 Aug 2025 23:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1usvY2-0002Tu-6B; Sun, 31 Aug 2025 23:49:38 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1usvY0-0005gx-09; Sun, 31 Aug 2025 23:49:37 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-24457f581aeso34943295ad.0; 
 Sun, 31 Aug 2025 20:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756698574; x=1757303374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bv9ktMFP/b/o72KPJB4LY0M1enTVib9W5oP97oH6Wcg=;
 b=SWiZ9dj2/tkj3eHbFwFYpDshu48Uw1AI9DLybtZ4GIBE0u4OS1ey6i7bfXwarOrsjT
 tNKDr+wL9g2QBZ/AXGLXh9Vi9E+wPYDmR9IEY2P63TdN/rEsbuMDkTTjxh8+Z9me5w41
 vsR0ColnWQ5NgZlu1jaQp4oSFwpuO4HgAVtjHj42mkRrZQPT+pAKjgV+uQdm5wanIXsJ
 O298JOcXcNFqlqLPmq1u7x+9Zw/BpdHAI6TH/CF/wfdhWYYh4aVwpqA7bz2mOwaWmP04
 tKn57Af6teq2rSc+3ANQBlx1oXy6cNwrpBdqI8LlDKdFS5vaXja9wQzpAPD/GHMunjXw
 dQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756698574; x=1757303374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bv9ktMFP/b/o72KPJB4LY0M1enTVib9W5oP97oH6Wcg=;
 b=h/ftfb72gmrC2AbNKfhI7VPYGKsba640FrHGenizWSizHgHMB24YE5fjnmBnbATSRE
 tYi5rr+fuNofaOPYjvIMPK1ZPW34T9+IceVf+sYmJxUd6wndrZmTfHeGotS/VSyVL8/x
 8OoaU9K3xoXzzoYzyWlzZQd7+8ANlklW91tHw7AvvDUcOGgUYIdmvJj8Y+gnTw+jCKOc
 IAovhXQNde7+gh2AjBJvB/n1Kf+y/jI/V1UHUWl7UBCx//UdFbbcW6echj5aj03QOdan
 Fr4nI8lVD6Y9gKFQ1a5k//3PK/RmHecSQf+wX/0nVOfWXn3VdlcdJ3mE5gxCQ4PbsVjM
 KqrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi6lemyLRAtVEfVjJsbUs5nZf6pphkh1QfwcUDWr8c3emB+9IsLXxO6MZ7+UH/3HTzEcBDOaTQMq3ykg==@nongnu.org,
 AJvYcCXtTnv2dloZvwhwei6C/DF2yXUuA2Ku5VdXUMTRqIxA6oTMoTI1xgiFduVrGUuZfBdRxYo5TdDzfOVk@nongnu.org
X-Gm-Message-State: AOJu0YxcnS0DauOCLSqGr0yVt82tsDwiIBc4hgl8mNixilZr1OOZ01Mb
 CZ9ODFFLEiJZ/8vat0axCazB8qgmXr2ASPJUTwAvmZAkEcFyaWEWYPt7
X-Gm-Gg: ASbGncuqnH7v+0JeXATGUpuhnmkUqw/57YsUg6P+d09oiW3VoLXO+BfOQCxC5Qb2k5w
 6I6yfFIxwM1JUB004CiKrbkJyx/QPYzbl+U5Ah996LU95eWCTrzO30VtPB7FVVoAG4NYKn2RjE6
 mCNOCWRc6gbayj3ALZoDtUMBvLldUW/rCHwUChcB8cv6dOfR2NC+Wlo4XhwC5v4joElJ/QHstgK
 HEW3ibt1cRAJ8YR48GATYAFA6hZSNnev/bf07MX2F/3JGHjUUV8ajOTEaeqTVmtlTT0qvVGTY3S
 tJHnrwAUk/IcKvEScZEVDVzVL1UPC6EXNGbdbq8kjMCDTHfQBKC4RmU6zcvNclAxIgmSVnPdjRI
 lPdiXfVUjXlEjXEO0QSFNACwMdQ==
X-Google-Smtp-Source: AGHT+IEYeGa9DHNdXR3Lh0wf3HlxJj6ew+zOdo/dw5lZUHMMqCCy5XImckn0fE/XS+JgLAusrn5p7g==
X-Received: by 2002:a17:902:c405:b0:246:d98e:630 with SMTP id
 d9443c01a7336-24944b3dff8mr75992175ad.44.1756698573935; 
 Sun, 31 Aug 2025 20:49:33 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24905da26b9sm89802815ad.93.2025.08.31.20.49.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Aug 2025 20:49:33 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v3 3/5] hw/nvme: add NVMe Admin Security SPDM support
Date: Mon,  1 Sep 2025 13:47:58 +1000
Message-ID: <20250901034759.85042-5-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901034759.85042-2-wilfred.opensource@gmail.com>
References: <20250901034759.85042-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pl1-x635.google.com
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
 hw/nvme/ctrl.c       | 188 ++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h       |   5 ++
 include/block/nvme.h |  15 ++++
 3 files changed, 207 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f5ee6bf260..557f634016 100644
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
@@ -7282,6 +7284,185 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
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
+    transport_transfer_len += sizeof(hdr);
+    if (transport_transfer_len > SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    /* Generate the NVMe transport header */
+    hdr.security_protocol = secp;
+    hdr.security_protocol_specific = cpu_to_le16((spsp1 << 8) | spsp0);
+    hdr.length = cpu_to_le32(transfer_len);
+
+    sec_buf = g_malloc0(transport_transfer_len);
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
+    nvme_cmd_status = cpu_to_be16(nvme_cmd_status);
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
+    nvme_cmd_status = cpu_to_be16(nvme_cmd_status);
+    /* An error here implies the prior if_recv from requester was spurious */
+    if (nvme_cmd_status != NVME_SUCCESS) {
+        return nvme_cmd_status;
+    }
+
+    /* Clear to start receiving data from the server */
+    rsp_spdm_buf = g_malloc0(alloc_len);
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
+        [9] = NVME_SEC_PROT_DMTF_SPDM,
+    };
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
+        return nvme_sec_prot_spdm_receive(n, req);
+    default:
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+}
+
 static uint16_t nvme_directive_send(NvmeCtrl *n, NvmeRequest *req)
 {
     return NVME_INVALID_FIELD | NVME_DNR;
@@ -7389,6 +7570,10 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
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
@@ -8824,7 +9009,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
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


