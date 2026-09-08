Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BCE4C79FAA
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xQX-00051k-QQ; Tue, 08 Sep 2026 11:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQW-0004vc-BS
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:08:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3xQS-0007kE-Pq
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:08:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788880073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YjYJ508BAqYcgxyG0uHrSRKoEMyHPj29y54ceXrIv2k=;
 b=HfUQnp28WfOPOUqWIOUyp7HI96MANV6HnoPfYg0sWJNqVMWmcSCgCRIWwLDg4Dg+SQeZBr
 6YuGfGGv3tpXPhXb0zT3jbArUzYvqgXzYo8oFw0O7o2medY9iZNO04nvWJ75MC27TKll2b
 W+FTikSXWY291EXH49YsgAlVF0mbjdw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620--Jjz_26qPLqcG-BXVALLwQ-1; Tue,
 08 Sep 2026 11:07:49 -0400
X-MC-Unique: -Jjz_26qPLqcG-BXVALLwQ-1
X-Mimecast-MFC-AGG-ID: -Jjz_26qPLqcG-BXVALLwQ_1788880066
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F34ED1955EBA; Tue,  8 Sep 2026 15:07:45 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0FE3430001A2; Tue,  8 Sep 2026 15:07:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 19:06:56 +0400
Subject: [GIT PULL 13/15] spdm-socket: convert SpdmTransportType to QAPI enum
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-qom-qapi-pr-v1-13-a4d75a2573cc@redhat.com>
References: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
In-Reply-To: <20260908-qom-qapi-pr-v1-0-a4d75a2573cc@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Alistair Francis <alistair.francis@wdc.com>, 
 Tao Tang <tangtao1634@phytium.com.cn>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=13661;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=CnrBh8iWBSYVnO+uD2xY5eCx7OtSIYe/BZN7bcI23cs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqoCSPOs9ovBByxqwBsBJecVrCgNxBNDoEGilaV
 /tgUs+Uq3qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqAkjwAKCRDa6OEJdZac
 5XdyD/95BgijL5k5waT1drBAPez3WDxkQbtiY0PO2vdPDuqeMZGj08m4xYO8pYuW1QW2+X5V7+c
 Z4F8NNiYgXeaQ6MjMc7kwyQAoeXXOVxBubs7XDu6LSh31nIVXO7cGrfut9MXVnWEM2CLHYG9Xjt
 bGFxU9e8tpg+fnPDJWh4kyzxmBKKBAvAnMMgOOSYX7i18eKw0M0g24a58NPXD3BO2SlNt/vgsla
 UY+s3EjS1gDioFTP8Y3+LlZY939N1e8htb5wfSdh04coNDKxQbrO/nrBnnlDltdJS3YDPLxnTgU
 tlNNXAcs3K2b+379G5PDS8RbZrRj9643kGDnxvPojREXMrP76fCzf1acrPtfm7lzJFmh9Ocdss8
 SG7Cbmc43jc8wcgZ/rck/cSBTxbwdJnQJCq42DKJk0AkEgHLkbnwLAWpu6WAySt2KDR1Sl8tHsz
 lQh/ExlBneN4cbsCn/fzfkzVI6XFSJ3cl+t6OftR6PLOJfI2au4yMLO0Bwb5xjppDHjdTyKskYQ
 4cvtNvA0oR0oZnnW1rWfBL6T1QXvADOEr+M7Gtx/f/3Wb4xdY2Vozkinpen98SznoSvwxjE7K2u
 qc1/+N08wiIRiKbUXFHbSwPonWG6ZT4519J2ilNhqGPkH7MnGleot9/wEtR3rL986YeVCPlzXaG
 N29wl0qVgEH1u6g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace the hand-written SpdmTransportType C enum and QEnumLookup
table with a QAPI schema definition in qapi/sockets.json. Update
all users in hw/nvme/ctrl.c to use the QAPI-generated enum constants
(SPDM_TRANSPORT_TYPE_* instead of SPDM_SOCKET_TRANSPORT_TYPE_*).

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 backends/spdm-socket.c       | 23 +++++++----------------
 hw/nvme/ctrl.c               | 26 +++++++++++++-------------
 include/system/spdm-socket.h | 28 +++++++++++-----------------
 qapi/sockets.json            | 20 ++++++++++++++++++++
 4 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
index b625a65d28f7..826efc276dcd 100644
--- a/backends/spdm-socket.c
+++ b/backends/spdm-socket.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "system/spdm-socket.h"
 #include "qapi/error.h"
+#include "qapi/qapi-types-sockets.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/core/qdev-prop-internal.h"
@@ -205,7 +206,7 @@ static bool spdm_socket_command_valid(uint32_t command)
     }
 }
 
-uint32_t spdm_socket_receive(const int socket, uint32_t transport_type,
+uint32_t spdm_socket_receive(const int socket, SpdmTransportType transport_type,
                              void *rsp, uint32_t rsp_len)
 {
     uint32_t command;
@@ -223,13 +224,14 @@ uint32_t spdm_socket_receive(const int socket, uint32_t transport_type,
 }
 
 bool spdm_socket_send(const int socket, uint32_t socket_cmd,
-                      uint32_t transport_type, void *req, uint32_t req_len)
+                      SpdmTransportType transport_type, void *req,
+                      uint32_t req_len)
 {
     return send_platform_data(socket, transport_type, socket_cmd, req,
                               req_len);
 }
 
-uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
+uint32_t spdm_socket_rsp(const int socket, SpdmTransportType transport_type,
                          void *req, uint32_t req_len,
                          void *rsp, uint32_t rsp_len)
 {
@@ -244,27 +246,16 @@ uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
     return spdm_socket_receive(socket, transport_type, rsp, rsp_len);
 }
 
-void spdm_socket_close(const int socket, uint32_t transport_type)
+void spdm_socket_close(const int socket, SpdmTransportType transport_type)
 {
     send_platform_data(socket, transport_type,
                        SPDM_SOCKET_COMMAND_SHUTDOWN, NULL, 0);
 }
 
-const QEnumLookup SpdmTransport_lookup = {
-    .array = (const char *const[]) {
-        [SPDM_SOCKET_TRANSPORT_TYPE_UNSPEC] = "unspecified",
-        [SPDM_SOCKET_TRANSPORT_TYPE_MCTP] = "mctp",
-        [SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE] = "doe",
-        [SPDM_SOCKET_TRANSPORT_TYPE_SCSI] = "scsi",
-        [SPDM_SOCKET_TRANSPORT_TYPE_NVME] = "nvme",
-    },
-    .size = SPDM_SOCKET_TRANSPORT_TYPE_MAX
-};
-
 const PropertyInfo qdev_prop_spdm_trans = {
     .type = "SpdmTransportType",
     .description = "Spdm Transport, doe/nvme/mctp/scsi/unspecified",
-    .enum_table = &SpdmTransport_lookup,
+    .enum_table = &SpdmTransportType_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
     .set_default_value = qdev_propinfo_set_default_value_enum,
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 4893cf7e7418..c662d968db1e 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -7489,14 +7489,14 @@ static uint16_t nvme_sec_prot_spdm_send(NvmeCtrl *n, NvmeRequest *req)
     }
 
     spdm_res = spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CMD_IF_SEND,
-                                SPDM_SOCKET_TRANSPORT_TYPE_NVME, sec_buf,
+                                SPDM_TRANSPORT_TYPE_NVME, sec_buf,
                                 transport_transfer_len);
     if (!spdm_res) {
         return NVME_DATA_TRAS_ERROR | NVME_DNR;
     }
 
     /* The responder shall ack with message status */
-    recvd = spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+    recvd = spdm_socket_receive(n->spdm_socket, SPDM_TRANSPORT_TYPE_NVME,
                                 &nvme_cmd_status,
                                 SPDM_SOCKET_MAX_MSG_STATUS_LEN);
 
@@ -7552,14 +7552,14 @@ static uint16_t nvme_sec_prot_spdm_receive(NvmeCtrl *n, NvmeRequest *req)
 
     /* Forward if_recv to the SPDM Server with SPSP0 */
     spdm_res = spdm_socket_send(n->spdm_socket, SPDM_SOCKET_STORAGE_CMD_IF_RECV,
-                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+                                SPDM_TRANSPORT_TYPE_NVME,
                                 &hdr, sizeof(hdr));
     if (!spdm_res) {
         return NVME_DATA_TRAS_ERROR | NVME_DNR;
     }
 
     /* The responder shall ack with message status */
-    recvd = spdm_socket_receive(n->spdm_socket, SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+    recvd = spdm_socket_receive(n->spdm_socket, SPDM_TRANSPORT_TYPE_NVME,
                                 &nvme_cmd_status,
                                 SPDM_SOCKET_MAX_MSG_STATUS_LEN);
     if (recvd < SPDM_SOCKET_MAX_MSG_STATUS_LEN) {
@@ -7579,7 +7579,7 @@ static uint16_t nvme_sec_prot_spdm_receive(NvmeCtrl *n, NvmeRequest *req)
     }
 
     recvd = spdm_socket_receive(n->spdm_socket,
-                                SPDM_SOCKET_TRANSPORT_TYPE_NVME,
+                                SPDM_TRANSPORT_TYPE_NVME,
                                 rsp_spdm_buf, alloc_len);
     if (!recvd) {
         return NVME_DATA_TRAS_ERROR | NVME_DNR;
@@ -9097,7 +9097,7 @@ static bool pcie_doe_spdm_rsp(DOECap *doe_cap)
     uint32_t rsp_len = SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE;
 
     uint32_t recvd = spdm_socket_rsp(doe_cap->spdm_socket,
-                             SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE,
+                             SPDM_TRANSPORT_TYPE_DOE,
                              req, req_len, rsp, rsp_len);
     doe_cap->read_mbox_len += DIV_ROUND_UP(recvd, 4);
 
@@ -9199,7 +9199,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
         uint16_t doe_offset = PCI_CONFIG_SPACE_SIZE;
 
         switch  (pci_dev->spdm_trans) {
-        case SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE:
+        case SPDM_TRANSPORT_TYPE_DOE:
             if (n->params.sriov_max_vfs) {
                 doe_offset += PCI_ARI_SIZEOF;
             }
@@ -9214,7 +9214,7 @@ static bool nvme_init_pci(NvmeCtrl *n, PCIDevice *pci_dev, Error **errp)
                 return false;
             }
             break;
-        case SPDM_SOCKET_TRANSPORT_TYPE_NVME:
+        case SPDM_TRANSPORT_TYPE_NVME:
             n->spdm_socket = spdm_socket_connect(pci_dev->spdm_port, errp);
             if (n->spdm_socket < 0) {
                 return false;
@@ -9716,10 +9716,10 @@ static void nvme_exit(PCIDevice *pci_dev)
     assert(!(pci_dev->doe_spdm.spdm_socket > 0 && n->spdm_socket >= 0));
     if (pci_dev->doe_spdm.spdm_socket > 0) {
         spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
-                          SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE);
+                          SPDM_TRANSPORT_TYPE_DOE);
     } else if (n->spdm_socket >= 0) {
         spdm_socket_close(pci_dev->doe_spdm.spdm_socket,
-                          SPDM_SOCKET_TRANSPORT_TYPE_NVME);
+                          SPDM_TRANSPORT_TYPE_NVME);
     }
 
     if (n->pmr.dev) {
@@ -9778,7 +9778,7 @@ static const Property nvme_props[] = {
     DEFINE_PROP_UINT16("mqes", NvmeCtrl, params.mqes, 0x7ff),
     DEFINE_PROP_UINT16("spdm_port", PCIDevice, spdm_port, 0),
     DEFINE_PROP_SPDM_TRANS("spdm_trans", PCIDevice, spdm_trans,
-                           SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE),
+                           SPDM_TRANSPORT_TYPE_DOE),
     DEFINE_PROP_BOOL("ctratt.mem", NvmeCtrl, params.ctratt.mem, false),
     DEFINE_PROP_BOOL("atomic.dn", NvmeCtrl, params.atomic_dn, 0),
     DEFINE_PROP_UINT16("atomic.awun", NvmeCtrl, params.atomic_awun, 0),
@@ -9856,7 +9856,7 @@ static void nvme_pci_write_config(PCIDevice *dev, uint32_t address,
 
     /* DOE is only initialised if SPDM over DOE is used */
     if (pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE) &&
-        dev->spdm_trans == SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE) {
+        dev->spdm_trans == SPDM_TRANSPORT_TYPE_DOE) {
         pcie_doe_write_config(&dev->doe_spdm, address, val, len);
     }
     pci_default_write_config(dev, address, val, len);
@@ -9869,7 +9869,7 @@ static uint32_t nvme_pci_read_config(PCIDevice *dev, uint32_t address, int len)
     uint32_t val;
 
     if (dev->spdm_port && pcie_find_capability(dev, PCI_EXT_CAP_ID_DOE) &&
-        (dev->spdm_trans == SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE)) {
+        (dev->spdm_trans == SPDM_TRANSPORT_TYPE_DOE)) {
         if (pcie_doe_read_config(&dev->doe_spdm, address, len, &val)) {
             return val;
         }
diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
index 00cb0e97f36e..b5a68d3d60b6 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -23,6 +23,8 @@
 #ifndef SPDM_REQUESTER_H
 #define SPDM_REQUESTER_H
 
+#include "qapi/qapi-types-sockets.h"
+
 /**
  * spdm_socket_connect: connect to an external SPDM socket
  * @port: port to connect to
@@ -37,7 +39,7 @@ int spdm_socket_connect(uint16_t port, Error **errp);
 /**
  * spdm_socket_rsp: send and receive a message to a SPDM server
  * @socket: socket returned from spdm_socket_connect()
- * @transport_type: SPDM_SOCKET_TRANSPORT_TYPE_* macro
+ * @transport_type: the SPDM transport type
  * @req: request buffer
  * @req_len: request buffer length
  * @rsp: response buffer
@@ -46,14 +48,14 @@ int spdm_socket_connect(uint16_t port, Error **errp);
  * Send platform data to a SPDM server on socket and then receive
  * a response.
  */
-uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
+uint32_t spdm_socket_rsp(const int socket, SpdmTransportType transport_type,
                          void *req, uint32_t req_len,
                          void *rsp, uint32_t rsp_len);
 
 /**
  * spdm_socket_rsp: Receive a message from an SPDM server
  * @socket: socket returned from spdm_socket_connect()
- * @transport_type: SPDM_SOCKET_TRANSPORT_TYPE_* macro
+ * @transport_type: the SPDM transport type
  * @rsp: response buffer
  * @rsp_len: response buffer length
  *
@@ -61,14 +63,14 @@ uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
  * received or 0 on failure. This can be used to receive a message from the SPDM
  * server without sending anything first.
  */
-uint32_t spdm_socket_receive(const int socket, uint32_t transport_type,
+uint32_t spdm_socket_receive(const int socket, SpdmTransportType transport_type,
                              void *rsp, uint32_t rsp_len);
 
 /**
  * spdm_socket_rsp: Sends a message to an SPDM server
  * @socket: socket returned from spdm_socket_connect()
  * @socket_cmd: socket command type (normal/if_recv/if_send etc...)
- * @transport_type: SPDM_SOCKET_TRANSPORT_TYPE_* macro
+ * @transport_type: the SPDM transport type
  * @req: request buffer
  * @req_len: request buffer length
  *
@@ -77,16 +79,17 @@ uint32_t spdm_socket_receive(const int socket, uint32_t transport_type,
  * spdm_socket_receive().
  */
 bool spdm_socket_send(const int socket, uint32_t socket_cmd,
-                      uint32_t transport_type, void *req, uint32_t req_len);
+                      SpdmTransportType transport_type, void *req,
+                      uint32_t req_len);
 
 /**
  * spdm_socket_close: send a shutdown command to the server
  * @socket: socket returned from spdm_socket_connect()
- * @transport_type: SPDM_SOCKET_TRANSPORT_TYPE_* macro
+ * @transport_type: the SPDM transport type
  *
  * This will issue a shutdown command to the server.
  */
-void spdm_socket_close(const int socket, uint32_t transport_type);
+void spdm_socket_close(const int socket, SpdmTransportType transport_type);
 
 /*
  * Defines the transport encoding for SPDM, this information shall be passed
@@ -115,15 +118,6 @@ typedef struct {
 #define SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE       0x1200
 #define SPDM_SOCKET_MAX_MSG_STATUS_LEN            0x02
 
-typedef enum SpdmTransportType {
-    SPDM_SOCKET_TRANSPORT_TYPE_UNSPEC = 0,
-    SPDM_SOCKET_TRANSPORT_TYPE_MCTP,
-    SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE,
-    SPDM_SOCKET_TRANSPORT_TYPE_SCSI,
-    SPDM_SOCKET_TRANSPORT_TYPE_NVME,
-    SPDM_SOCKET_TRANSPORT_TYPE_MAX
-} SpdmTransportType;
-
 extern const PropertyInfo qdev_prop_spdm_trans;
 
 #define DEFINE_PROP_SPDM_TRANS(_name, _state, _field, _default) \
diff --git a/qapi/sockets.json b/qapi/sockets.json
index 473be2ac58a2..a9a8006c2274 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -252,3 +252,23 @@
             'unix': 'UnixSocketAddress',
             'vsock': 'VsockSocketAddress',
             'fd': 'FdSocketAddress' } }
+
+##
+# @SpdmTransportType:
+#
+# SPDM transport type
+#
+# @unspecified: Unspecified transport
+#
+# @mctp: MCTP transport
+#
+# @doe: PCI Data Object Exchange (DOE) transport
+#
+# @scsi: SCSI transport
+#
+# @nvme: NVMe transport
+#
+# Since: 11.2
+##
+{ 'enum': 'SpdmTransportType',
+  'data': [ 'unspecified', 'mctp', 'doe', 'scsi', 'nvme' ] }

-- 
2.55.0.543.g5ebe2ebe4ea8


