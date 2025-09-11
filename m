Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FF2CAC583
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 06:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwaNg-0001DX-G6; Thu, 11 Sep 2025 02:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwaNe-0001DD-GC; Thu, 11 Sep 2025 02:02:02 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1uwaNb-0000al-Sr; Thu, 11 Sep 2025 02:02:02 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so326404b3a.1; 
 Wed, 10 Sep 2025 23:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757570518; x=1758175318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2ckIfNbLRICGKZlDZ9lIT2naej4PEPqvIAN7kUTeUXU=;
 b=EZpfohafrbuoVGG8CW3LrEjlelbSrA8LVtbni4MQHSMlc2a0A2IBVKrBQCLcpY+BQR
 vGguzPEOp2RdkkIIx+YmKuCH1GvR4T2zx92TtmRiaMDs8kTp/Ku7wMtk4CgMmOnmQaj2
 XJ2bzcndQwY4v1ahKaDH222zsuT3FjSusHZSIqaiUrQI16btwD/HUAixd0UEJFMv5oxG
 AjejeBCArI0ajOCwZg3iNv4Y4SL5+X0ox6ClMOp+ccOD8gaShysFsXkD8PyGWBT01Y+d
 CIjpzTJe1SdaFVEYCts2IL2cTImxS7yY3FUpD+7vUPD1LbVU2zH80/rcwPbN2fzd5hXs
 5k8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757570518; x=1758175318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ckIfNbLRICGKZlDZ9lIT2naej4PEPqvIAN7kUTeUXU=;
 b=oXMef2icUjrgL7waQrsFWou2nXVDKQCuy/1bFVft4UqYSj1xluNzL0K9mwwyNndw4U
 BsJndyK7Mgsc5HEiv1PoijEVKrZKnejLHslE5wwKbh8p9cifrI8sqsJTINDhI5iPqFP9
 T22s0KVNiyjSsGsBl9RnMSNRfvJRfQTZW7dKMqklsi3ydvlLFsLyGd73lyUYUoumR55U
 EIrqvUcksCNJ1/HA+1XHObdVLVX9izn259WHyDcEc6hmgvLwH3nAkiMhnnnKsP/QOmeo
 0h0jCnB9yYDRQf4rq9R0Mq+Bo6Urw5Nccu+caJFuC3dX1rKZosGeS7PQs0l2PeEi7QVo
 7VMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnlWwPJ3wQLB9q2aIGGlk1u+gq/ABNwTaAf1E1i2Agj5R31EMSk94kD+xz5R51Z3P3WX6BEV5VAV7Dbw==@nongnu.org,
 AJvYcCWkIKUb0l69/TzDv5TL2OjANjAMsQCcc6WDJTUVvkY/jExa5gQT14AGpnEaotc+Fd25FI85LPgbhuDz@nongnu.org
X-Gm-Message-State: AOJu0YxOMeHLuS8h96gxbVe3riotBpsY56VfWpsA/vuXKDqNxei8l/7K
 ewJmJjvjBBo1Hy7bC1H75kyPQeCdwIpgNkl7gExnXLuQJ5c13g8FjGIJ
X-Gm-Gg: ASbGncty5tATvN+r/PIreAdEN9fSqrKpOUzAoD0a9PxlrXSY/i+Fa62h/WwJHkKFcMR
 VTXawBIBhUO5rVy4yM6ozZqrqieQjRR+UppDTcxYCcRYt//UUwmfTlFXsUbdWwudH6UcCS5kTI4
 T1Sw+Ra00C+wzu40uyeWTtBUJK+sOPiDkLNJAwNLjow4QILK/lONV6+rCquXyM+LmkRzGLz2Lmc
 PkP7MtDhe5V/oC9U1KBQvQMpb+UnL2ZMQFgNpH5ISyof16FKLq/DZPzjXxeJa9u+MssnyPNiKrB
 xOyy/iP+glxV3r1DYDw6wxBcxC9MHVxDiHz8r/W5g+xO05eStDvapu5o9FFyNywkD4gFrlWUi+L
 A/EqidokGwQLyy4PFe4HsWig79JbutIr+tEX1m2vtfRyWVb6VKKn0
X-Google-Smtp-Source: AGHT+IH+A2sAnSyqyKHUNKtJUPfMaxNBCxCg/ky9pemf/hi3xO41Wbxj1cfLouoVhgUzf3AKZTAf1Q==
X-Received: by 2002:a05:6a00:cce:b0:776:26f:4d20 with SMTP id
 d2e1a72fcca58-77602fcf88fmr2391746b3a.1.1757570518072; 
 Wed, 10 Sep 2025 23:01:58 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77607c54a71sm795381b3a.102.2025.09.10.23.01.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 23:01:57 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v6 3/5] hw/nvme: add NVMe Admin Security SPDM support
Date: Thu, 11 Sep 2025 16:00:29 +1000
Message-ID: <20250911060031.124683-4-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911060031.124683-1-wilfred.opensource@gmail.com>
References: <20250911060031.124683-1-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pf1-x436.google.com
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/nvme/ctrl.c               | 212 ++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h               |   5 +
 include/block/nvme.h         |  15 +++
 include/system/spdm-socket.h |   2 +
 4 files changed, 233 insertions(+), 1 deletion(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f5ee6bf260..ad52e8f569 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -282,6 +282,8 @@ static const uint32_t nvme_cse_acs_default[256] = {
     [NVME_ADM_CMD_FORMAT_NVM]       = NVME_CMD_EFF_CSUPP | NVME_CMD_EFF_LBCC,
     [NVME_ADM_CMD_DIRECTIVE_RECV]   = NVME_CMD_EFF_CSUPP,
     [NVME_ADM_CMD_DIRECTIVE_SEND]   = NVME_CMD_EFF_CSUPP,
+    [NVME_ADM_CMD_SECURITY_SEND]    = NVME_CMD_EFF_CSUPP,
+    [NVME_ADM_CMD_SECURITY_RECV]    = NVME_CMD_EFF_CSUPP,
 };
 
 static const uint32_t nvme_cse_iocs_nvm_default[256] = {
@@ -7282,6 +7284,207 @@ static uint16_t nvme_dbbuf_config(NvmeCtrl *n, const NvmeRequest *req)
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
+    uint16_t spsp = extract32(dw10, 8, 16);
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
+    hdr.security_protocol_specific = cpu_to_le16(spsp);
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
+                                &nvme_cmd_status,
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
+    uint8_t secp = extract32(dw10, 24, 8);
+
+    switch (secp) {
+    case NVME_SEC_PROT_DMTF_SPDM:
+        if (n->spdm_socket < 0) {
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
+    uint8_t spsp = extract32(dw10, 8, 16);
+    if (!alloc_len) {
+        return NVME_INVALID_FIELD | NVME_DNR;
+    }
+
+    /* Generate the NVMe transport header */
+    hdr = (StorageSpdmTransportHeader) {
+        .security_protocol = secp,
+        .security_protocol_specific = cpu_to_le16(spsp),
+        .length = cpu_to_le32(alloc_len),
+    };
+
+    /* Forward if_recv to the SPDM Server with SPSP0 */
+    spdm_res = spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CMD_IF_RECV,
+                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+                                &hdr, sizeof(hdr));
+    if (!spdm_res) {
+        return NVME_DATA_TRAS_ERROR | NVME_DNR;
+    }
+
+    /* The responder shall ack with message status */
+    recvd = spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+                                &nvme_cmd_status,
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
+    if (n->spdm_socket >= 0) {
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
+        if (n->spdm_socket < 0) {
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
@@ -7389,6 +7592,10 @@ static uint16_t nvme_admin_cmd(NvmeCtrl *n, NvmeRequest *req)
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
@@ -8459,6 +8666,8 @@ static void nvme_init_state(NvmeCtrl *n)
         sctrl->vfn = cpu_to_le16(i + 1);
     }
 
+    n->spdm_socket = -1;
+
     cap->cntlid = cpu_to_le16(n->cntlid);
     cap->crt = NVME_CRT_VQ | NVME_CRT_VI;
 
@@ -8824,7 +9033,8 @@ static void nvme_init_ctrl(NvmeCtrl *n, PCIDevice *pci_dev)
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
diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
index 80cd7021c1..f0c8b64d1b 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -112,7 +112,9 @@ typedef struct {
 
 #define SPDM_SOCKET_TRANSPORT_TYPE_MCTP           0x01
 #define SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE        0x02
+#define SPDM_SOCKET_TRANSPORT_TYPE_NVME           0x04
 
 #define SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE       0x1200
+#define SPDM_SOCKET_MAX_MSG_STATUS_LEN            0x02
 
 #endif
-- 
2.51.0


