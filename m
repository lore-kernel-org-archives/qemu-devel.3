Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0D010F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:15:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYJR-0008Ha-DP; Wed, 08 Apr 2026 15:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangjian.3032@bytedance.com>)
 id 1wAYGs-0004sk-Pp
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:09:04 -0400
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangjian.3032@bytedance.com>)
 id 1wAOlt-0002qV-P1
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 05:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1775638818; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=AXQ3rqRgkrvcdUrbgzqGfuWKgQXIm7rubIUcVIGLaTk=;
 b=oOrmm4mxyovBmVaGV8bf4sYxPMDUgLhPUWsFN/hEvtzRRArV7AXMO3H1KToMNpb7Nj+T7X
 o588Sc2H6POXVSJMuRbvs1kz6adO52oGZID8B+fJny3ywW4Ea5wtiVoaU/duCGKA8Tbvus
 yr3ccEFtVhiVkhlyfrTtHIqdS+U/KffMSLLyJMplMIytc65T6atTvANwaJEUY8gVbOPeNO
 WrE6Li6eEG0rsOMb3SBOOGmED8l6O+LQYARJoTCDxhd63auCfa9uCjFhhqn5Ac8vzkLdzB
 DkvHXWb2PhEkt4XikQfnXPbQVe8dIlE/AK+TMqMtvCPbbjoLEGiRPJ4Zs0F+JQ==
References: <20260408085941.3837334-1-zhangjian.3032@bytedance.com>
X-Original-From: Jian Zhang <zhangjian.3032@bytedance.com>
Subject: [PATCH v1 1/2] hw/misc: introduce mctp I2C responder and NCSI support
Mime-Version: 1.0
X-Lms-Return-Path: <lba+269d6191f+a9f76d+nongnu.org+zhangjian.3032@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260408085941.3837334-1-zhangjian.3032@bytedance.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 "Peter Maydell" <peter.maydell@linaro.org>, 
 "Steven Lee" <steven_lee@aspeedtech.com>, "Troy Lee" <leetroy@gmail.com>, 
 "Jamin Lin" <jamin_lin@aspeedtech.com>, 
 "Andrew Jeffery" <andrew@codeconstruct.com.au>, 
 "Joel Stanley" <joel@jms.id.au>, "Paolo Bonzini" <pbonzini@redhat.com>, 
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, 
 "Jeremy Kerr" <jk@codeconstruct.com.au>, 
 "Matt Johnston" <matt@codeconstruct.com.au>
From: "Jian Zhang" <zhangjian.3032@bytedance.com>
Date: Wed,  8 Apr 2026 16:59:40 +0800
Message-Id: <20260408085941.3837334-2-zhangjian.3032@bytedance.com>
Received-SPF: pass client-ip=209.127.230.112;
 envelope-from=zhangjian.3032@bytedance.com; helo=va-1-112.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a minimal MCTP-over-SMBus/I2C responder implementation that handles
basic packet framing, transmission and control message dispatch.

On top of the base responder, introduce an NCSI responder variant with
configurable QOM properties and support for returning link status,
version, capabilities and temperature related responses.

Signed-off-by: Jian Zhang <zhangjian.3032@bytedance.com>
---
 MAINTAINERS                          |   2 +
 hw/misc/Kconfig                      |   5 +
 hw/misc/mctp-i2c-responder-ncsi.c    | 777 +++++++++++++++++++++++++++
 hw/misc/mctp-i2c-responder.c         | 694 ++++++++++++++++++++++++
 hw/misc/meson.build                  |   5 +
 include/hw/misc/mctp-i2c-responder.h | 116 ++++
 6 files changed, 1599 insertions(+)
 create mode 100644 hw/misc/mctp-i2c-responder-ncsi.c
 create mode 100644 hw/misc/mctp-i2c-responder.c
 create mode 100644 include/hw/misc/mctp-i2c-responder.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 63e9ba521bc..a2762dd8585 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1225,6 +1225,8 @@ F: hw/*/*aspeed*
 F: include/hw/*/*aspeed*
 F: hw/net/ftgmac100.c
 F: include/hw/net/ftgmac100.h
+F: hw/misc/mctp-i2c-responder*.c
+F: include/hw/misc/mctp-i2c-responder.h
 F: docs/system/arm/aspeed.rst
 F: docs/system/arm/fby35.rst
 F: tests/functional/*/*aspeed*
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index fccd735c24c..3ff58b9c4e9 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -35,6 +35,11 @@ config I2C_ECHO
     default y if TEST_DEVICES
     depends on I2C
 
+config MCTP_I2C_RESPONDER
+    bool
+    default y
+    depends on I2C
+
 config PL310
     bool
 
diff --git a/hw/misc/mctp-i2c-responder-ncsi.c b/hw/misc/mctp-i2c-responder-ncsi.c
new file mode 100644
index 00000000000..6f8a7f24d9a
--- /dev/null
+++ b/hw/misc/mctp-i2c-responder-ncsi.c
@@ -0,0 +1,777 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * MCTP-over-SMBus/I2C responder: NCSI control message type extension.
+ *
+ * This is intentionally a thin QOM sub-type that only registers an extra
+ * message handler (msg_type=0x02). The detailed NCSI payload parsing and
+ * response building is left to be implemented by the user.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include <arpa/inet.h>
+
+#include "hw/misc/mctp-i2c-responder.h"
+
+#define TYPE_MCTP_I2C_RESPONDER_NCSI "mctp-i2c-responder-ncsi"
+typedef struct MctpI2cResponderNcsi {
+    MctpI2cResponder parent_obj;
+
+    /* Link status */
+    bool link_up;
+    uint8_t link_speed_duplex; /* bits1-4 in link_speed */
+
+    /* Temperatures */
+    uint8_t asic_temp_cur;
+    uint8_t asic_temp_max;
+    uint8_t xcvr_temp;
+    uint8_t xcvr_hi_warn;
+    uint8_t xcvr_hi_alarm;
+
+    /* Version/IDs */
+    char fw_name[13]; /* max 12 bytes used in response */
+    uint32_t fw_version; /* packed, returned as BE */
+    uint16_t pci_did;
+    uint16_t pci_vid;
+    uint16_t pci_ssid;
+    uint16_t pci_svid;
+    uint32_t manufacturer_id; /* returned as BE */
+
+    /* Capabilities */
+    uint8_t channel_count;
+
+    /* Mellanox OEM */
+    uint8_t mlx_temp_base;
+    uint8_t mlx_temp_step;
+    uint8_t mlx_temp_max;
+    uint8_t module_identifier;
+} MctpI2cResponderNcsi;
+
+#define MCTP_I2C_RESPONDER_NCSI(obj) \
+    OBJECT_CHECK(MctpI2cResponderNcsi, (obj), TYPE_MCTP_I2C_RESPONDER_NCSI)
+
+static bool ncsi_prop_get_link_up(Object *obj, Error **errp)
+{
+    MctpI2cResponderNcsi *n = MCTP_I2C_RESPONDER_NCSI(obj);
+    return n->link_up;
+}
+
+static void ncsi_prop_set_link_up(Object *obj, bool value, Error **errp)
+{
+    MctpI2cResponderNcsi *n = MCTP_I2C_RESPONDER_NCSI(obj);
+    n->link_up = value;
+}
+
+static char *ncsi_prop_get_fw_name(Object *obj, Error **errp)
+{
+    MctpI2cResponderNcsi *n = MCTP_I2C_RESPONDER_NCSI(obj);
+    return g_strdup(n->fw_name);
+}
+
+static void ncsi_prop_set_fw_name(Object *obj, const char *value, Error **errp)
+{
+    MctpI2cResponderNcsi *n = MCTP_I2C_RESPONDER_NCSI(obj);
+    if (!value) {
+        n->fw_name[0] = '\0';
+        return;
+    }
+    /* Response uses only 12 bytes, truncate here for predictability. */
+    g_strlcpy(n->fw_name, value, sizeof(n->fw_name));
+    n->fw_name[12] = '\0';
+}
+
+#define NCSI_HDR_REV_1 0x01
+
+/* NCSI control packet types (DSP0222 Table 21). */
+#define NCSI_CMD_CLEAR_INITIAL_STATE        0x00
+#define NCSI_CMD_SELECT_PACKAGE             0x01
+#define NCSI_CMD_DESELECT_PACKAGE           0x02
+#define NCSI_CMD_ENABLE_CHANNEL             0x03
+#define NCSI_CMD_DISABLE_CHANNEL            0x04
+#define NCSI_CMD_RESET_CHANNEL              0x05
+#define NCSI_CMD_SET_LINK                   0x09
+#define NCSI_CMD_GET_LINK_STATUS            0x0a
+#define NCSI_CMD_GET_VERSION_ID             0x15
+#define NCSI_CMD_GET_CAPABILITIES           0x16
+#define NCSI_CMD_GET_MODULE_MGMT_DATA       0x32
+#define NCSI_CMD_GET_ASIC_TEMPERATURE       0x48
+#define NCSI_CMD_GET_AMBIENT_TEMPERATURE    0x49
+#define NCSI_CMD_GET_XCVR_TEMPERATURE       0x4a
+#define NCSI_CMD_OEM_COMMAND                0x50
+#define NCSI_CMD_PLDM_REQUEST               0x51
+
+/* Mellanox OEM definitions */
+#define MELLANOX_MANUFACTURER_ID 0x8119
+#define MLX_OEM_CMD_ID 0x13
+#define MLX_OEM_PARAM_TEMP 0x02
+#define MLX_OEM_PARAM_MODULE_DATA 0x11
+
+typedef struct NcsiCtrlPkgHdr {
+    uint8_t mcId;
+    uint8_t headerRevision;
+    uint8_t reserved1;
+    uint8_t IID;
+    uint8_t ctrlPkgType;
+    uint8_t channelId;
+    uint16_t payloadLength;
+    uint16_t reserved3;
+    uint16_t reserved4;
+    uint16_t reserved5;
+    uint16_t reserved6;
+} QEMU_PACKED NcsiCtrlPkgHdr;
+
+static inline uint8_t ncsi_channel_pkg(uint8_t channel_id)
+{
+    return channel_id >> 5;
+}
+
+static inline uint8_t ncsi_channel_idx(uint8_t channel_id)
+{
+    return channel_id & 0x1f;
+}
+
+static inline uint8_t ncsi_ctrl_rsp_type(uint8_t req_type)
+{
+    return (uint8_t)(req_type + 0x80);
+}
+
+static inline MctpI2cResponderNcsi *ncsi_get_state(MctpI2cResponder *s)
+{
+    return MCTP_I2C_RESPONDER_NCSI(OBJECT(s));
+}
+
+static void ncsi_init_rsp_hdr(NcsiCtrlPkgHdr *rsp, const NcsiCtrlPkgHdr *req,
+                              uint8_t rsp_type, uint16_t payload_len)
+{
+    memset(rsp, 0, sizeof(*rsp));
+    rsp->mcId = 0x00;
+    rsp->headerRevision = NCSI_HDR_REV_1;
+    rsp->IID = req->IID;
+    rsp->ctrlPkgType = rsp_type;
+    rsp->channelId = req->channelId;
+    rsp->payloadLength = htons(payload_len);
+}
+
+static bool ncsi_tx_begin_rsp(MctpI2cResponder *s, const NcsiCtrlPkgHdr *req,
+                              uint8_t rsp_type, uint16_t payload_len)
+{
+    if (!mctp_i2c_responder_tx_begin(s, MCTP_MSG_TYPE_NCSI_CONTROL)) {
+        return false;
+    }
+
+    NcsiCtrlPkgHdr hdr;
+    ncsi_init_rsp_hdr(&hdr, req, rsp_type, payload_len);
+    if (!mctp_i2c_responder_tx_append(s, &hdr, sizeof(hdr))) {
+        return false;
+    }
+
+    uint16_t response_code = 0x0000;
+    uint16_t reason_code = 0x0000;
+    (void)mctp_i2c_responder_tx_append(s, &response_code,
+                                       sizeof(response_code));
+    (void)mctp_i2c_responder_tx_append(s, &reason_code, sizeof(reason_code));
+    return true;
+}
+
+static void ncsi_tx_append_u32be(MctpI2cResponder *s, uint32_t v)
+{
+    v = htonl(v);
+    (void)mctp_i2c_responder_tx_append(s, &v, sizeof(v));
+}
+
+static void ncsi_tx_append_u16be(MctpI2cResponder *s, uint16_t v)
+{
+    v = htons(v);
+    (void)mctp_i2c_responder_tx_append(s, &v, sizeof(v));
+}
+
+static uint8_t mlx_module_byte(MctpI2cResponderNcsi *n,
+                               uint8_t port, uint8_t page,
+                               uint16_t off)
+{
+    /* Provide stable, parsable identifiers for module code paths. */
+    if (page == 0x00 && off == 0x00) {
+        /* Identifier: controlled by property (default QSFP-DD/CMIS=0x18). */
+        return n->module_identifier;
+    }
+    /* Deterministic pattern for debugging. */
+    return (uint8_t)(0x5a ^ (port * 17) ^ (page * 3) ^ (off & 0xff));
+}
+
+static void ncsi_build_min_rsp(MctpI2cResponder *s, const NcsiCtrlPkgHdr *req)
+{
+    /* Minimal response used by checkResponse(): NcsiCommandRes<uint32_t> */
+    if (!ncsi_tx_begin_rsp(s, req, ncsi_ctrl_rsp_type(req->ctrlPkgType), 8)) {
+        return;
+    }
+
+    /* data = checksum (ignored) */
+    ncsi_tx_append_u32be(s, 0);
+}
+
+static void ncsi_handle_get_link_status(MctpI2cResponder *s,
+                                        const NcsiCtrlPkgHdr *req)
+{
+    MctpI2cResponderNcsi *n = ncsi_get_state(s);
+    /* NcsiGetLinkStatusRes = hdr + rcode + reason + GetLinkStatusRes */
+    if (!ncsi_tx_begin_rsp(s, req,
+                           ncsi_ctrl_rsp_type(req->ctrlPkgType), 4 + 16)) {
+        return;
+    }
+
+    /* GetLinkStatusRes layout (16 bytes). */
+    uint8_t extended_speed = 0;
+    uint8_t others3 = 0;
+    uint8_t others2 = 0;
+
+    /* bit0 linkFlag; bits1-4 speedDuplex; bits5-7 others */
+    uint8_t link_speed = (uint8_t)((n->link_up ? 1u : 0u) << 0) |
+                         (uint8_t)((n->link_speed_duplex & 0x0f) << 1);
+
+    uint32_t other_indications = 0;
+    uint32_t oem_link_status = 0;
+    uint32_t checksum = 0;
+
+    (void)mctp_i2c_responder_tx_append(s, &extended_speed, 1);
+    (void)mctp_i2c_responder_tx_append(s, &others3, 1);
+    (void)mctp_i2c_responder_tx_append(s, &others2, 1);
+    (void)mctp_i2c_responder_tx_append(s, &link_speed, 1);
+
+    (void)mctp_i2c_responder_tx_append(s, &other_indications,
+                                       sizeof(other_indications));
+    (void)mctp_i2c_responder_tx_append(s, &oem_link_status,
+                                       sizeof(oem_link_status));
+    (void)mctp_i2c_responder_tx_append(s, &checksum, sizeof(checksum));
+}
+
+static void ncsi_handle_get_version_id(MctpI2cResponder *s,
+                                       const NcsiCtrlPkgHdr *req)
+{
+    MctpI2cResponderNcsi *n = ncsi_get_state(s);
+    /*
+     * NcsiGetVersionIdRes = hdr + rcode + reason
+     * + GetVersionIdRes (40 bytes)
+     */
+    if (!ncsi_tx_begin_rsp(s, req,
+                           ncsi_ctrl_rsp_type(req->ctrlPkgType), 4 + 40)) {
+        return;
+    }
+
+    /* ncsiVersion (uint32) */
+    ncsi_tx_append_u32be(s, 0x01000000);
+
+    /* reserved1..3 + alpha2 (4 bytes) */
+    uint32_t rsvd = 0;
+    (void)mctp_i2c_responder_tx_append(s, &rsvd, sizeof(rsvd));
+
+    /* firmwareNameString[12] */
+    char fw_name[12] = {0};
+    memcpy(fw_name, n->fw_name, MIN((size_t)12, strlen(n->fw_name)));
+    (void)mctp_i2c_responder_tx_append(s, fw_name, sizeof(fw_name));
+
+    /* firmwareVersion (uint32, big-endian) */
+    ncsi_tx_append_u32be(s, n->fw_version);
+
+    /* pciDid/pciVid/pciSsid/pciSvid (uint16 BE) */
+    ncsi_tx_append_u16be(s, n->pci_did);
+    ncsi_tx_append_u16be(s, n->pci_vid);
+    ncsi_tx_append_u16be(s, n->pci_ssid);
+    ncsi_tx_append_u16be(s, n->pci_svid);
+
+    /* manufacturerId (uint32 BE) */
+    ncsi_tx_append_u32be(s, n->manufacturer_id);
+
+    /* checksum (uint32, ignored) */
+    ncsi_tx_append_u32be(s, 0);
+}
+
+static void ncsi_handle_get_capabilities(MctpI2cResponder *s,
+                                         const NcsiCtrlPkgHdr *req)
+{
+    MctpI2cResponderNcsi *n = ncsi_get_state(s);
+    /*
+     * NcsiGetCapabilitiesRes = hdr + rcode + reason
+     * + GetCapabilitiesRes (32 bytes)
+     */
+    if (!ncsi_tx_begin_rsp(s, req,
+                           ncsi_ctrl_rsp_type(req->ctrlPkgType), 4 + 32)) {
+        return;
+    }
+
+    uint32_t zero32 = 0;
+    /* capabilitiesFlags .. aenControlCapabilities */
+    for (int i = 0; i < 5; i++) {
+        (void)mctp_i2c_responder_tx_append(s, &zero32, sizeof(zero32));
+    }
+
+    /* vlanFilterCount/mixed/multicast/unicast (4 bytes) */
+    uint8_t counts[4] = {0, 0, 0, 0};
+    (void)mctp_i2c_responder_tx_append(s, counts, sizeof(counts));
+
+    /* reserved1 (u16), vlanModeSupport(u8), channelCount(u8) */
+    uint16_t reserved1 = 0;
+    uint8_t vlan_mode_support = 0;
+    uint8_t channel_count = n->channel_count;
+    (void)mctp_i2c_responder_tx_append(s, &reserved1, sizeof(reserved1));
+    (void)mctp_i2c_responder_tx_append(s, &vlan_mode_support,
+                                       sizeof(vlan_mode_support));
+    (void)mctp_i2c_responder_tx_append(s, &channel_count,
+                                       sizeof(channel_count));
+
+    /* checksum */
+    (void)mctp_i2c_responder_tx_append(s, &zero32, sizeof(zero32));
+}
+
+static void ncsi_handle_get_asic_temp(MctpI2cResponder *s,
+                                      const NcsiCtrlPkgHdr *req)
+{
+    MctpI2cResponderNcsi *n = ncsi_get_state(s);
+    /* NcsiGetAsicTempRes = hdr + rcode + reason + GetAsicTempRes (8 bytes) */
+    if (!ncsi_tx_begin_rsp(s, req,
+                           ncsi_ctrl_rsp_type(req->ctrlPkgType), 4 + 8)) {
+        return;
+    }
+
+    uint16_t max_temp = htons(n->asic_temp_max);
+    uint16_t cur_temp = htons(n->asic_temp_cur);
+    uint32_t checksum = 0;
+    (void)mctp_i2c_responder_tx_append(s, &max_temp, sizeof(max_temp));
+    (void)mctp_i2c_responder_tx_append(s, &cur_temp, sizeof(cur_temp));
+    (void)mctp_i2c_responder_tx_append(s, &checksum, sizeof(checksum));
+}
+
+static void ncsi_handle_get_xcvr_temp(MctpI2cResponder *s,
+                                      const NcsiCtrlPkgHdr *req)
+{
+    MctpI2cResponderNcsi *n = ncsi_get_state(s);
+    /*
+     * NcsiGetTransceiverTempRes = hdr + rcode + reason
+     * + GetTransceiverTempRes (12 bytes)
+     */
+    if (!ncsi_tx_begin_rsp(s, req,
+                           ncsi_ctrl_rsp_type(req->ctrlPkgType), 4 + 12)) {
+        return;
+    }
+
+    uint16_t hi_alarm = htons(n->xcvr_hi_alarm);
+    uint16_t hi_warn = htons(n->xcvr_hi_warn);
+    uint16_t temp_val = htons(n->xcvr_temp);
+    uint16_t reserved = 0;
+    uint32_t checksum = 0;
+    (void)mctp_i2c_responder_tx_append(s, &hi_alarm, sizeof(hi_alarm));
+    (void)mctp_i2c_responder_tx_append(s, &hi_warn, sizeof(hi_warn));
+    (void)mctp_i2c_responder_tx_append(s, &temp_val, sizeof(temp_val));
+    (void)mctp_i2c_responder_tx_append(s, &reserved, sizeof(reserved));
+    (void)mctp_i2c_responder_tx_append(s, &checksum, sizeof(checksum));
+}
+
+static void ncsi_handle_mlx_oem_temp(MctpI2cResponder *s,
+                                     const NcsiCtrlPkgHdr *req,
+                                     const uint8_t *oem, size_t oem_len)
+{
+    MctpI2cResponderNcsi *n = ncsi_get_state(s);
+    /*
+     * Mellanox Get Temp Req layout:
+     * hdr(16) + manufacturerId(4) + cmdRev(1) + cmdId(1) + parameter(1)
+     * + data(1) + checksum(4)
+     */
+    if (oem_len < 4 + 1 + 1 + 1 + 1) {
+        ncsi_build_min_rsp(s, req);
+        return;
+    }
+
+    uint32_t manufacturer_id_be;
+    memcpy(&manufacturer_id_be, oem, sizeof(manufacturer_id_be));
+    uint32_t manufacturer_id = ntohl(manufacturer_id_be);
+    uint8_t cmd_rev = oem[4];
+    uint8_t cmd_id = oem[5];
+    uint8_t parameter = oem[6];
+    uint8_t temp_req = oem[7];
+
+    uint8_t sp = (temp_req >> 7) & 0x1;
+    uint8_t sensor_index = temp_req & 0x7f;
+
+    if (manufacturer_id != MELLANOX_MANUFACTURER_ID ||
+        cmd_id != MLX_OEM_CMD_ID ||
+        parameter != MLX_OEM_PARAM_TEMP) {
+        ncsi_build_min_rsp(s, req);
+        return;
+    }
+
+    bool is_port = (sp != 0);
+    uint8_t rsp_size = is_port ? 44 : 36;
+    uint16_t payload_len = (uint16_t)(rsp_size - sizeof(NcsiCtrlPkgHdr));
+
+    if (!mctp_i2c_responder_tx_begin(s, MCTP_MSG_TYPE_NCSI_CONTROL)) {
+        return;
+    }
+
+    NcsiCtrlPkgHdr hdr;
+    ncsi_init_rsp_hdr(&hdr, req,
+                      ncsi_ctrl_rsp_type(req->ctrlPkgType), payload_len);
+    (void)mctp_i2c_responder_tx_append(s, &hdr, sizeof(hdr));
+
+    uint16_t response_code = 0x0000;
+    uint16_t reason_code = 0x0000;
+    (void)mctp_i2c_responder_tx_append(s, &response_code,
+                                       sizeof(response_code));
+    (void)mctp_i2c_responder_tx_append(s, &reason_code, sizeof(reason_code));
+
+    uint32_t mid = htonl(MELLANOX_MANUFACTURER_ID);
+    (void)mctp_i2c_responder_tx_append(s, &mid, sizeof(mid));
+    (void)mctp_i2c_responder_tx_append(s, &cmd_rev, 1);
+    (void)mctp_i2c_responder_tx_append(s, &cmd_id, 1);
+    (void)mctp_i2c_responder_tx_append(s, &parameter, 1);
+
+    /* data */
+    uint8_t data0 = (uint8_t)((sp << 7) | (sensor_index & 0x7f));
+    uint16_t pad = 0;
+    uint8_t max_temp = n->mlx_temp_max;
+    uint8_t temp_step = MAX((uint8_t)1, n->mlx_temp_step);
+    uint8_t cur_temp = (uint8_t)(n->mlx_temp_base +
+                                 (uint8_t)((sensor_index % 15) * temp_step));
+    cur_temp = MIN(cur_temp, max_temp);
+
+    (void)mctp_i2c_responder_tx_append(s, &data0, 1);
+    (void)mctp_i2c_responder_tx_append(s, &pad, sizeof(pad));
+    (void)mctp_i2c_responder_tx_append(s, &max_temp, 1);
+    (void)mctp_i2c_responder_tx_append(s, &cur_temp, 1);
+
+    if (is_port) {
+        char str[8] = {0};
+        memcpy(str, "mlxtemp", 6);
+        (void)mctp_i2c_responder_tx_append(s, str, sizeof(str));
+    }
+
+    /* checksum */
+    uint32_t checksum = 0;
+    (void)mctp_i2c_responder_tx_append(s, &checksum, sizeof(checksum));
+}
+
+static void ncsi_handle_mlx_oem_module_data(MctpI2cResponder *s,
+                                            const NcsiCtrlPkgHdr *req,
+                                            const uint8_t *oem, size_t oem_len)
+{
+    MctpI2cResponderNcsi *n = ncsi_get_state(s);
+    /*
+     * Mellanox Get Module Info Req
+     * hdr(16) + manufacturerId(4) + cmdRev(1) + cmdId(1) + parameter(1)
+     * + MellanoxGetModuleDataReq(9) + checksum(4)
+     */
+    if (oem_len < 4 + 1 + 1 + 1 + 9) {
+        ncsi_build_min_rsp(s, req);
+        return;
+    }
+
+    uint32_t manufacturer_id_be;
+    memcpy(&manufacturer_id_be, oem, sizeof(manufacturer_id_be));
+    uint32_t manufacturer_id = ntohl(manufacturer_id_be);
+    uint8_t cmd_rev = oem[4];
+    uint8_t cmd_id = oem[5];
+    uint8_t parameter = oem[6];
+
+    if (manufacturer_id != MELLANOX_MANUFACTURER_ID ||
+        cmd_id != MLX_OEM_CMD_ID ||
+        parameter != MLX_OEM_PARAM_MODULE_DATA) {
+        ncsi_build_min_rsp(s, req);
+        return;
+    }
+
+    /* Parse MellanoxGetModuleDataReq */
+    const uint8_t *p = &oem[7];
+    uint8_t reserved1 = p[0];
+    uint8_t i2c_addr = p[1];
+    uint8_t page = p[2];
+    uint16_t dev_addr_be;
+    memcpy(&dev_addr_be, &p[3], sizeof(dev_addr_be));
+    uint16_t dev_addr = ntohs(dev_addr_be);
+    uint8_t others1 = p[5];
+    uint8_t others2 = p[6];
+    uint16_t xfer_be;
+    memcpy(&xfer_be, &p[7], sizeof(xfer_be));
+    uint16_t xfer = ntohs(xfer_be);
+    (void)xfer;
+
+    /* Response must be exactly sizeof(MellanoxGetModuleInfoRes)=88. */
+    const size_t rsp_size = 88;
+    uint16_t payload_len = (uint16_t)(rsp_size - sizeof(NcsiCtrlPkgHdr));
+
+    if (!mctp_i2c_responder_tx_begin(s, MCTP_MSG_TYPE_NCSI_CONTROL)) {
+        return;
+    }
+
+    NcsiCtrlPkgHdr hdr;
+    ncsi_init_rsp_hdr(&hdr, req,
+                      ncsi_ctrl_rsp_type(req->ctrlPkgType), payload_len);
+    (void)mctp_i2c_responder_tx_append(s, &hdr, sizeof(hdr));
+
+    uint16_t response_code = 0x0000;
+    uint16_t reason_code = 0x0000;
+    (void)mctp_i2c_responder_tx_append(s, &response_code,
+                                       sizeof(response_code));
+    (void)mctp_i2c_responder_tx_append(s, &reason_code, sizeof(reason_code));
+
+    uint32_t mid = htonl(MELLANOX_MANUFACTURER_ID);
+    (void)mctp_i2c_responder_tx_append(s, &mid, sizeof(mid));
+    (void)mctp_i2c_responder_tx_append(s, &cmd_rev, 1);
+    (void)mctp_i2c_responder_tx_append(s, &cmd_id, 1);
+    (void)mctp_i2c_responder_tx_append(s, &parameter, 1);
+
+    /* MellanoxGetModuleDataRes (57 bytes) */
+    (void)mctp_i2c_responder_tx_append(s, &reserved1, 1);
+    (void)mctp_i2c_responder_tx_append(s, &i2c_addr, 1);
+    (void)mctp_i2c_responder_tx_append(s, &page, 1);
+    (void)mctp_i2c_responder_tx_append(s, &dev_addr_be, sizeof(dev_addr_be));
+    (void)mctp_i2c_responder_tx_append(s, &others1, 1);
+    (void)mctp_i2c_responder_tx_append(s, &others2, 1);
+    (void)mctp_i2c_responder_tx_append(s, &xfer_be, sizeof(xfer_be));
+
+    /* Module data decode area (48 bytes). */
+    uint8_t port = ncsi_channel_idx(req->channelId);
+    uint8_t module_data[48];
+    for (int i = 0; i < 48; i++) {
+        uint16_t off = (uint16_t)(dev_addr + i);
+        module_data[i] = mlx_module_byte(n, port, page, off);
+    }
+    (void)mctp_i2c_responder_tx_append(s, module_data, sizeof(module_data));
+
+    /* checksum */
+    uint32_t checksum = 0;
+    (void)mctp_i2c_responder_tx_append(s, &checksum, sizeof(checksum));
+}
+
+static void ncsi_handle_oem(MctpI2cResponder *s, const NcsiCtrlPkgHdr *req,
+                            const uint8_t *payload, size_t payload_len)
+{
+    /* OEM payload starts right after NcsiCtrlPkgHdr. */
+    if (payload_len < 4 + 1 + 1 + 1) {
+        ncsi_build_min_rsp(s, req);
+        return;
+    }
+
+    uint32_t manufacturer_id_be;
+    memcpy(&manufacturer_id_be, payload, sizeof(manufacturer_id_be));
+    uint32_t manufacturer_id = ntohl(manufacturer_id_be);
+
+    if (manufacturer_id == MELLANOX_MANUFACTURER_ID) {
+        uint8_t cmd_id = payload[5];
+        uint8_t param = payload[6];
+        if (cmd_id == MLX_OEM_CMD_ID && param == MLX_OEM_PARAM_TEMP) {
+            ncsi_handle_mlx_oem_temp(s, req, payload, payload_len);
+            return;
+        }
+        if (cmd_id == MLX_OEM_CMD_ID && param == MLX_OEM_PARAM_MODULE_DATA) {
+            ncsi_handle_mlx_oem_module_data(s, req, payload, payload_len);
+            return;
+        }
+    }
+
+    /* Unknown OEM: still return a minimal success response to avoid retries. */
+    ncsi_build_min_rsp(s, req);
+}
+
+static void (*parent_init_handlers)(MctpI2cResponder *s);
+
+static void mctp_ncsi_control_handler_placeholder(MctpI2cResponder *s)
+{
+    size_t rx_len = 0;
+    const uint8_t *rx = mctp_i2c_responder_get_rx_buf(s, &rx_len);
+
+    if (!rx || rx_len < 1) {
+        return;
+    }
+
+    /* Keep a short trace line for quick debugging. */
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "mctp: NCSI control handler placeholder rx_len=%zu, rx[0]=0x%02x\n",
+                  rx_len, rx[0]);
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "mctp: NCSI handler rx_len=%zu, msg_type=0x%02x\n",
+                  rx_len, rx[0]);
+
+    if (rx[0] != MCTP_MSG_TYPE_NCSI_CONTROL) {
+        return;
+    }
+
+    const uint8_t *req_buf = rx + 1;
+    size_t req_len = rx_len - 1;
+    if (req_len < sizeof(NcsiCtrlPkgHdr)) {
+        return;
+    }
+
+    NcsiCtrlPkgHdr req_hdr;
+    memcpy(&req_hdr, req_buf, sizeof(req_hdr));
+
+    /* NCSI payload starts right after header. */
+    const uint8_t *payload = req_buf + sizeof(NcsiCtrlPkgHdr);
+    size_t payload_len = req_len - sizeof(NcsiCtrlPkgHdr);
+
+    switch (req_hdr.ctrlPkgType) {
+    case NCSI_CMD_GET_LINK_STATUS:
+        ncsi_handle_get_link_status(s, &req_hdr);
+        break;
+    case NCSI_CMD_GET_VERSION_ID:
+        ncsi_handle_get_version_id(s, &req_hdr);
+        break;
+    case NCSI_CMD_GET_CAPABILITIES:
+        ncsi_handle_get_capabilities(s, &req_hdr);
+        break;
+    case NCSI_CMD_GET_ASIC_TEMPERATURE:
+    case NCSI_CMD_GET_AMBIENT_TEMPERATURE:
+        ncsi_handle_get_asic_temp(s, &req_hdr);
+        break;
+    case NCSI_CMD_GET_XCVR_TEMPERATURE:
+        ncsi_handle_get_xcvr_temp(s, &req_hdr);
+        break;
+    case NCSI_CMD_OEM_COMMAND:
+        ncsi_handle_oem(s, &req_hdr, payload, payload_len);
+        break;
+    case NCSI_CMD_CLEAR_INITIAL_STATE:
+    case NCSI_CMD_SELECT_PACKAGE:
+    case NCSI_CMD_DESELECT_PACKAGE:
+    case NCSI_CMD_ENABLE_CHANNEL:
+    case NCSI_CMD_DISABLE_CHANNEL:
+    case NCSI_CMD_RESET_CHANNEL:
+    case NCSI_CMD_SET_LINK:
+    case NCSI_CMD_GET_MODULE_MGMT_DATA:
+    case NCSI_CMD_PLDM_REQUEST:
+    default:
+        /* Provide minimal success response so upper layers don't retry. */
+        ncsi_build_min_rsp(s, &req_hdr);
+        break;
+    }
+}
+
+static void mctp_i2c_responder_ncsi_init_handlers(MctpI2cResponder *s)
+{
+    if (parent_init_handlers) {
+        parent_init_handlers(s);
+    }
+
+    mctp_i2c_responder_register_msg_handler(
+        s, MCTP_MSG_TYPE_NCSI_CONTROL,
+        mctp_ncsi_control_handler_placeholder);
+}
+
+static void mctp_i2c_responder_ncsi_class_init(ObjectClass *oc, const void *data)
+{
+    MctpI2cResponderClass *mc = MCTP_I2C_RESPONDER_CLASS(oc);
+    MctpI2cResponderClass *parent_mc =
+        MCTP_I2C_RESPONDER_CLASS(object_class_get_parent(oc));
+
+    parent_init_handlers = parent_mc->init_handlers;
+    mc->init_handlers = mctp_i2c_responder_ncsi_init_handlers;
+}
+
+static void mctp_i2c_responder_ncsi_instance_init(Object *obj)
+{
+    MctpI2cResponderNcsi *n = MCTP_I2C_RESPONDER_NCSI(obj);
+
+    n->link_up = true;
+    n->link_speed_duplex = 0x0d; /* 100Gbps */
+
+    n->asic_temp_cur = 45;
+    n->asic_temp_max = 90;
+    n->xcvr_temp = 50;
+    n->xcvr_hi_warn = 85;
+    n->xcvr_hi_alarm = 100;
+
+    g_strlcpy(n->fw_name, "QEMU-MLX", sizeof(n->fw_name));
+    n->fw_version = 0x162304D2; /* 22.35.1234 */
+    n->pci_did = 0x101d;
+    n->pci_vid = 0x15b3;
+    n->pci_ssid = 0x0107;
+    n->pci_svid = 0x15b3;
+    n->manufacturer_id = MELLANOX_MANUFACTURER_ID;
+
+    n->channel_count = 8;
+
+    n->mlx_temp_base = 40;
+    n->mlx_temp_step = 1;
+    n->mlx_temp_max = 95;
+    n->module_identifier = 0x18; /* QSFP-DD (CMIS) */
+
+    /* QOM properties: runtime writable via qom-set (QMP/HMP). */
+    object_property_add_bool(obj, "link-up",
+                             ncsi_prop_get_link_up,
+                             ncsi_prop_set_link_up);
+
+    object_property_add_uint8_ptr(obj, "link-speed-duplex",
+                                  &n->link_speed_duplex,
+                                  OBJ_PROP_FLAG_READWRITE);
+
+    object_property_add_uint8_ptr(obj, "asic-temp-cur",
+                                  &n->asic_temp_cur,
+                                  OBJ_PROP_FLAG_READWRITE);
+    object_property_add_uint8_ptr(obj, "asic-temp-max",
+                                  &n->asic_temp_max,
+                                  OBJ_PROP_FLAG_READWRITE);
+
+    object_property_add_uint8_ptr(obj, "xcvr-temp",
+                                  &n->xcvr_temp,
+                                  OBJ_PROP_FLAG_READWRITE);
+    object_property_add_uint8_ptr(obj, "xcvr-hi-warn",
+                                  &n->xcvr_hi_warn,
+                                  OBJ_PROP_FLAG_READWRITE);
+    object_property_add_uint8_ptr(obj, "xcvr-hi-alarm",
+                                  &n->xcvr_hi_alarm,
+                                  OBJ_PROP_FLAG_READWRITE);
+
+    object_property_add_str(obj, "fw-name",
+                            ncsi_prop_get_fw_name,
+                            ncsi_prop_set_fw_name);
+    object_property_add_uint32_ptr(obj, "fw-version",
+                                   &n->fw_version,
+                                   OBJ_PROP_FLAG_READWRITE);
+
+    object_property_add_uint16_ptr(obj, "pci-did",
+                                   &n->pci_did,
+                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_add_uint16_ptr(obj, "pci-vid",
+                                   &n->pci_vid,
+                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_add_uint16_ptr(obj, "pci-ssid",
+                                   &n->pci_ssid,
+                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_add_uint16_ptr(obj, "pci-svid",
+                                   &n->pci_svid,
+                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_add_uint32_ptr(obj, "manufacturer-id",
+                                   &n->manufacturer_id,
+                                   OBJ_PROP_FLAG_READWRITE);
+
+    object_property_add_uint8_ptr(obj, "channel-count",
+                                  &n->channel_count,
+                                  OBJ_PROP_FLAG_READWRITE);
+
+    object_property_add_uint8_ptr(obj, "mlx-temp-base",
+                                  &n->mlx_temp_base,
+                                  OBJ_PROP_FLAG_READWRITE);
+    object_property_add_uint8_ptr(obj, "mlx-temp-step",
+                                  &n->mlx_temp_step,
+                                  OBJ_PROP_FLAG_READWRITE);
+    object_property_add_uint8_ptr(obj, "mlx-temp-max",
+                                  &n->mlx_temp_max,
+                                  OBJ_PROP_FLAG_READWRITE);
+
+    object_property_add_uint8_ptr(obj, "module-identifier",
+                                  &n->module_identifier,
+                                  OBJ_PROP_FLAG_READWRITE);
+}
+
+static const TypeInfo mctp_i2c_responder_ncsi_type_info = {
+    .name = TYPE_MCTP_I2C_RESPONDER_NCSI,
+    .parent = TYPE_MCTP_I2C_RESPONDER,
+    .instance_size = sizeof(MctpI2cResponderNcsi),
+    .class_init = mctp_i2c_responder_ncsi_class_init,
+    .instance_init = mctp_i2c_responder_ncsi_instance_init,
+};
+
+static void mctp_i2c_responder_ncsi_register_types(void)
+{
+    type_register_static(&mctp_i2c_responder_ncsi_type_info);
+}
+
+type_init(mctp_i2c_responder_ncsi_register_types)
diff --git a/hw/misc/mctp-i2c-responder.c b/hw/misc/mctp-i2c-responder.c
new file mode 100644
index 00000000000..67e2c49911a
--- /dev/null
+++ b/hw/misc/mctp-i2c-responder.c
@@ -0,0 +1,694 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Minimal MCTP-over-SMBus/I2C responder (I2C slave).
+ * - Replies via SMBus block-read (repeated-start)
+ *   and (optionally) reverse-master push.
+ * - Implements a tiny subset of MCTP Control.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i2c/i2c.h"
+#include "hw/qdev-properties.h"
+#include "qemu/log.h"
+#include "qemu/main-loop.h"
+#include "qemu/module.h"
+#include <glib.h>
+#include "hw/qdev-properties-system.h"
+#include "qemu/uuid.h"
+
+#include "hw/misc/mctp-i2c-responder.h"
+
+#define MCTP_I2C_COMMANDCODE 0x0f
+#define MCTP_I2C_MINLEN 8
+
+#define MCTP_HDR_FLAG_SOM BIT(7)
+#define MCTP_HDR_FLAG_EOM BIT(6)
+#define MCTP_HDR_FLAG_TO BIT(3)
+#define MCTP_HDR_FLAGS 0x38
+#define MCTP_HDR_SEQ_SHIFT 4
+#define MCTP_HDR_SEQ_MASK 0x03
+#define MCTP_HDR_TAG_SHIFT 0
+#define MCTP_HDR_TAG_MASK 0x07
+
+#define MCTP_CC_SUCCESS 0x00
+#define MCTP_CC_INVALID_LENGTH 0x03
+#define MCTP_CC_UNSUPPORTED 0x05
+
+struct mctp_i2c_hdr {
+    uint8_t dest_slave;
+    uint8_t command;
+    /* Count of bytes following byte_count, excluding PEC */
+    uint8_t byte_count;
+    uint8_t source_slave;
+};
+
+/* MCTP packet definitions */
+struct mctp_hdr {
+    uint8_t ver;
+    uint8_t dest;
+    uint8_t src;
+    uint8_t flags_seq_tag;
+};
+
+struct mctp_payload {
+    uint8_t msg_type;
+    uint8_t data[];
+};
+
+static void mctp_i2c_init_handlers_default(MctpI2cResponder *s);
+
+void mctp_i2c_responder_register_msg_handler(
+    MctpI2cResponder *s, uint8_t msg_type,
+    MctpI2cResponderMsgHandler handler)
+{
+    g_hash_table_replace(s->handlers,
+                         GINT_TO_POINTER((int)msg_type),
+                         (gpointer)handler);
+}
+
+const uint8_t *mctp_i2c_responder_get_rx_buf(MctpI2cResponder *s, size_t *len)
+{
+    if (!s->mctp_package.rx_buf) {
+        if (len) {
+            *len = 0;
+        }
+        return NULL;
+    }
+
+    if (len) {
+        *len = s->mctp_package.rx_buf->len;
+    }
+    return (const uint8_t *)s->mctp_package.rx_buf->data;
+}
+
+bool mctp_i2c_responder_tx_begin(MctpI2cResponder *s, uint8_t msg_type)
+{
+    if (!s->mctp_package.tx_buf) {
+        return false;
+    }
+
+    g_array_set_size(s->mctp_package.tx_buf, 0);
+    g_array_append_val(s->mctp_package.tx_buf, msg_type);
+    return true;
+}
+
+bool mctp_i2c_responder_tx_append(MctpI2cResponder *s,
+                                  const void *buf, size_t len)
+{
+    if (!s->mctp_package.tx_buf || !buf || len == 0) {
+        return false;
+    }
+
+    g_array_append_vals(s->mctp_package.tx_buf, buf, len);
+    return true;
+}
+
+static void mctp_i2c_responder_cleanup_after_handler(MctpI2cResponder *s)
+{
+    if (s->mctp_package.rx_buf) {
+        g_array_free(s->mctp_package.rx_buf, true);
+        s->mctp_package.rx_buf = NULL;
+    }
+
+    if (s->mctp_package.tx_buf && s->mctp_package.tx_buf->len == 0) {
+        g_array_free(s->mctp_package.tx_buf, true);
+        s->mctp_package.tx_buf = NULL;
+    }
+}
+
+static uint8_t crc8_pec(const uint8_t *buf, size_t len)
+{
+    uint8_t crc = 0;
+
+    for (size_t i = 0; i < len; i++) {
+        crc ^= buf[i];
+
+        for (int b = 0; b < 8; b++) {
+            crc = (crc & 0x80) ?
+                (uint8_t)((crc << 1) ^ 0x07) :
+                (uint8_t)(crc << 1);
+        }
+    }
+
+    return crc;
+}
+
+static void mctp_ctrl_handler(MctpI2cResponder *s)
+{
+    assert(s->mctp_package.rx_buf != NULL);
+    assert(s->mctp_package.tx_buf != NULL);
+
+#define MCTP_CTRL_HDR_FLAG_REQUEST 0x80
+#define MCTP_CTRL_CMD_SET_ENDPOINT_ID 0x01
+#define MCTP_CTRL_CMD_GET_ENDPOINT_ID 0x02
+#define MCTP_CTRL_CMD_GET_ENDPOINT_UUID 0x03
+#define MCTP_CTRL_CMD_GET_VERSION_SUPPORT 0x04
+#define MCTP_CTRL_CMD_GET_MESSAGE_TYPE_SUPPORT 0x05
+#define MCTP_PHYS_BINDING_SMBUS 0x01
+
+    /* Parse rx payload */
+    struct mctp_payload *rx_payload =
+        (struct mctp_payload *)s->mctp_package.rx_buf->data;
+    size_t rx_payload_len = s->mctp_package.rx_buf->len;
+
+    if (rx_payload_len < 1 + 2) {
+        return;
+    }
+
+    const uint8_t *rx_ctrl = (const uint8_t *)rx_payload->data;
+    uint8_t rq_dgram_inst = rx_ctrl[0];
+    uint8_t cmd = rx_ctrl[1];
+
+    if (!mctp_i2c_responder_tx_begin(s, MCTP_MSG_TYPE_CTRL)) {
+        return;
+    }
+
+    /* Response header: clear request bit, keep instance id. */
+    uint8_t resp_hdr[2] = {
+        (uint8_t)(rq_dgram_inst & ~MCTP_CTRL_HDR_FLAG_REQUEST),
+        cmd,
+    };
+    (void)mctp_i2c_responder_tx_append(s, resp_hdr, sizeof(resp_hdr));
+
+    switch (cmd) {
+    case MCTP_CTRL_CMD_GET_ENDPOINT_ID: {
+        uint8_t cc = MCTP_CC_SUCCESS;
+        uint8_t eid = s->eid;
+        uint8_t eid_type = MCTP_PHYS_BINDING_SMBUS;
+        uint8_t medium_data = 0;
+
+        (void)mctp_i2c_responder_tx_append(s, &cc, sizeof(cc));
+        (void)mctp_i2c_responder_tx_append(s, &eid, sizeof(eid));
+        (void)mctp_i2c_responder_tx_append(s, &eid_type, sizeof(eid_type));
+        (void)mctp_i2c_responder_tx_append(s, &medium_data,
+                                           sizeof(medium_data));
+        break;
+    }
+    case MCTP_CTRL_CMD_SET_ENDPOINT_ID: {
+        /* ctrl_hdr(2) + operation(1) + eid(1) */
+        if (rx_payload_len < 1 + 4) {
+            uint8_t cc = MCTP_CC_INVALID_LENGTH;
+            (void)mctp_i2c_responder_tx_append(s, &cc, sizeof(cc));
+            break;
+        }
+
+        uint8_t operation = rx_ctrl[2];
+        uint8_t new_eid = rx_ctrl[3];
+        (void)operation; /* framework only */
+
+        s->eid = new_eid;
+
+        uint8_t cc = MCTP_CC_SUCCESS;
+        uint8_t status = 0;
+        uint8_t eid_set = s->eid;
+        uint8_t eid_pool_size = 0;
+
+        (void)mctp_i2c_responder_tx_append(s, &cc, sizeof(cc));
+        (void)mctp_i2c_responder_tx_append(s, &status, sizeof(status));
+        (void)mctp_i2c_responder_tx_append(s, &eid_set, sizeof(eid_set));
+        (void)mctp_i2c_responder_tx_append(s, &eid_pool_size,
+                                           sizeof(eid_pool_size));
+        break;
+    }
+    case MCTP_CTRL_CMD_GET_ENDPOINT_UUID: {
+        uint8_t cc = MCTP_CC_SUCCESS;
+        (void)mctp_i2c_responder_tx_append(s, &cc, sizeof(cc));
+        (void)mctp_i2c_responder_tx_append(s, s->uuid.data,
+                                           sizeof(s->uuid.data));
+        break;
+    }
+    case MCTP_CTRL_CMD_GET_VERSION_SUPPORT: {
+        uint8_t cc = MCTP_CC_SUCCESS;
+        uint8_t number_of_entries = 1;
+        (void)mctp_i2c_responder_tx_append(s, &cc, sizeof(cc));
+        (void)mctp_i2c_responder_tx_append(s, &number_of_entries,
+                                           sizeof(number_of_entries));
+        break;
+    }
+    case MCTP_CTRL_CMD_GET_MESSAGE_TYPE_SUPPORT: {
+        uint8_t cc = MCTP_CC_SUCCESS;
+        (void)mctp_i2c_responder_tx_append(s, &cc, sizeof(cc));
+
+        uint8_t cnt = 0;
+        uint8_t types[UINT8_MAX];
+
+        if (s->handlers) {
+            GHashTableIter iter;
+            gpointer key, value;
+            g_hash_table_iter_init(&iter, s->handlers);
+            while (g_hash_table_iter_next(&iter, &key, &value)) {
+                if (cnt == UINT8_MAX) {
+                    break;
+                }
+                types[cnt++] = (uint8_t)GPOINTER_TO_INT(key);
+            }
+        }
+
+        (void)mctp_i2c_responder_tx_append(s, &cnt, sizeof(cnt));
+        for (int i = 0; i < cnt; i++) {
+            (void)mctp_i2c_responder_tx_append(s, &types[i], sizeof(types[i]));
+        }
+        break;
+    }
+    default: {
+        uint8_t cc = MCTP_CC_UNSUPPORTED;
+        (void)mctp_i2c_responder_tx_append(s, &cc, sizeof(cc));
+        break;
+    }
+    }
+}
+
+static bool mctp_i2c_build_tx(MctpI2cResponder *s)
+{
+    struct mctp_per_tx *pkt;
+    size_t tx_payload_len = s->mctp_package.tx_buf->len;
+    size_t tx_offset = 0;
+    struct mctp_i2c_hdr i2c_hdr;
+    struct mctp_hdr mctp_hdr;
+
+    uint8_t seq = 0;
+    uint8_t pec = 0;
+
+    /*
+     * A package should have:
+     * * mctp i2c header ==> 4 bytes, but byte_count only add 1 byte
+     * * mctp header ==> 4 bytes
+     * * payload ==> per_tx_len bytes
+     * * PEC ==> do not add to byte_count
+     */
+    while (tx_offset < tx_payload_len) {
+        size_t per_tx_len = 0;
+
+        pkt = g_malloc0(sizeof(struct mctp_per_tx));
+        memset(&i2c_hdr, 0, sizeof(i2c_hdr));
+        memset(&mctp_hdr, 0, sizeof(mctp_hdr));
+
+        /* mctp i2c header */
+        i2c_hdr.dest_slave = s->mctp_package.metadata.source_slave & 0xfe;
+        i2c_hdr.command = MCTP_I2C_COMMANDCODE;
+        i2c_hdr.byte_count = 0; /* fill later */
+        i2c_hdr.source_slave = s->mctp_package.metadata.dest_slave >> 1;
+
+        /* mctp header */
+        if (tx_offset == 0) {
+            mctp_hdr.flags_seq_tag |= MCTP_HDR_FLAG_SOM;
+        }
+
+        if (tx_offset + s->mtu >= tx_payload_len) {
+            mctp_hdr.flags_seq_tag |= MCTP_HDR_FLAG_EOM;
+        }
+
+        mctp_hdr.flags_seq_tag |= s->mctp_package.metadata.msg_tag;
+        mctp_hdr.flags_seq_tag |=
+            ((seq & MCTP_HDR_SEQ_MASK) << MCTP_HDR_SEQ_SHIFT);
+        mctp_hdr.ver = 1;
+        mctp_hdr.dest = s->mctp_package.metadata.src;
+        mctp_hdr.src = s->eid;
+
+        if (tx_offset + s->mtu >= tx_payload_len) {
+            per_tx_len = tx_payload_len - tx_offset;
+        } else {
+            per_tx_len = s->mtu;
+        }
+
+        /*
+         * fill byte_count
+         * mctp i2c header ==> 1 bytes
+         * (exclude dest_slave, command, byte_count self)
+         * mctp header ==> 4 bytes,
+         */
+        i2c_hdr.byte_count = per_tx_len + 1 + 4;
+
+        /* Fill payload. */
+        memcpy(pkt->buf, &i2c_hdr, sizeof(i2c_hdr));
+        pkt->len += sizeof(i2c_hdr);
+        memcpy(pkt->buf + pkt->len, &mctp_hdr, sizeof(mctp_hdr));
+        pkt->len += sizeof(mctp_hdr);
+        memcpy(pkt->buf + pkt->len,
+               s->mctp_package.tx_buf->data + tx_offset,
+               per_tx_len);
+        pkt->len += per_tx_len;
+
+        pec = crc8_pec(pkt->buf, pkt->len);
+        pkt->buf[pkt->len++] = pec;
+
+        g_queue_push_tail(s->tx_queue, pkt);
+        seq = (seq + 1) % 0x4;
+        tx_offset += per_tx_len;
+    }
+
+    /* Free tx payload. */
+    g_array_free(s->mctp_package.tx_buf, true);
+    s->mctp_package.tx_buf = NULL;
+
+    return true;
+}
+
+static void mctp_i2c_master_bh(void *opaque)
+{
+    MctpI2cResponder *s = opaque;
+    I2CBus *bus = I2C_BUS(qdev_get_parent_bus(&s->parent_obj.qdev));
+    struct mctp_per_tx *pkt = s->active_tx;
+
+    assert(bus->bh == s->bh);
+
+    if (pkt->pos == 0) {
+        if (i2c_start_send_async(bus, pkt->buf[pkt->pos++] >> 1) != 0) {
+            goto out_done;
+        }
+
+        return;
+    }
+
+    if (pkt->pos >= pkt->len) {
+        goto out_done;
+    }
+
+    if (i2c_send_async(bus, pkt->buf[pkt->pos++]) != 0) {
+        goto out_done;
+    }
+
+    return;
+
+out_done:
+    s->active_tx = NULL;
+    g_free(pkt);
+    i2c_end_transfer(bus);
+    i2c_bus_release(bus);
+
+    if (!g_queue_is_empty(s->tx_queue)) {
+        s->active_tx = g_queue_pop_head(s->tx_queue);
+        i2c_bus_master(bus, s->bh);
+        i2c_schedule_pending_master(bus);
+    }
+}
+
+static void mctp_package_response(MctpI2cResponder *s)
+{
+    I2CBus *bus = I2C_BUS(qdev_get_parent_bus(&s->parent_obj.qdev));
+
+    /*
+     * No response payload prepared
+     * (e.g. unknown msg_type / placeholder handler).
+     */
+    if (!s->mctp_package.tx_buf || s->mctp_package.tx_buf->len == 0) {
+        if (s->mctp_package.tx_buf) {
+            g_array_free(s->mctp_package.tx_buf, true);
+            s->mctp_package.tx_buf = NULL;
+        }
+        return;
+    }
+
+    if (!s->bh) {
+        s->bh = qemu_bh_new(mctp_i2c_master_bh, s);
+    }
+
+    mctp_i2c_build_tx(s);
+
+    if (!g_queue_is_empty(s->tx_queue)) {
+        s->active_tx = g_queue_pop_head(s->tx_queue);
+        i2c_bus_master(bus, s->bh);
+        i2c_schedule_pending_master(bus);
+    }
+}
+
+static int mctp_rx_package_verify(MctpI2cResponder *s)
+{
+    const uint8_t *rx = s->rx;
+    struct mctp_i2c_hdr *hdr;
+    size_t len = s->rx_len;
+    size_t recvlen;
+    uint8_t pec, calc_pec;
+
+    qemu_log_mask(LOG_GUEST_ERROR, "mctp: rx package verify, len %zu\n",
+                  len);
+
+    if (!len) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "mctp: rx package verify failed, len %zu\n",
+                      len);
+        return -EINVAL;
+    }
+
+    /* recvlen excludes PEC */
+    recvlen = len - 1;
+    hdr = (struct mctp_i2c_hdr *)rx;
+    if (hdr->command != MCTP_I2C_COMMANDCODE) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "mctp: rx package verify failed, command %d\n",
+                      hdr->command);
+        return -EINVAL;
+    }
+
+    if (hdr->byte_count + offsetof(struct mctp_i2c_hdr, source_slave) !=
+        recvlen) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "mctp: rx package verify failed, byte_count %d, recvlen %zu\n",
+                      hdr->byte_count, recvlen);
+        return -EINVAL;
+    }
+
+    pec = rx[recvlen];
+    calc_pec = crc8_pec(rx, recvlen);
+
+    if (pec != calc_pec) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "mctp: rx package verify failed, pec %d, calc_pec %d\n",
+                      pec, calc_pec);
+        return -EINVAL;
+    }
+
+    /* debug, remove later */
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "mctp: rx package verify passed, len %zu\n",
+                  len);
+    return 0;
+}
+
+static int mctp_package_do_frame(MctpI2cResponder *s)
+{
+    struct mctp_i2c_hdr *i2c_hdr;
+    struct mctp_hdr *hdr;
+    uint8_t payload_offset;
+    uint8_t payload_len;
+
+    i2c_hdr = (struct mctp_i2c_hdr *)s->rx;
+    hdr = (struct mctp_hdr *)(s->rx + sizeof(struct mctp_i2c_hdr));
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "mctp: rx package decode, ver %d, dest %d, src %d, "
+                  "flags_seq_tag %d\n",
+                  hdr->ver, hdr->dest, hdr->src, hdr->flags_seq_tag);
+
+    if (hdr->ver != 1) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "mctp: rx package decode failed, ver %d\n",
+                      hdr->ver);
+        return -EINVAL;
+    }
+
+    if (hdr->flags_seq_tag & MCTP_HDR_FLAG_SOM) {
+        if (s->mctp_package.rx_buf == NULL) {
+            s->mctp_package.rx_buf = g_array_new(false, false, sizeof(uint8_t));
+        }
+
+        if (s->mctp_package.tx_buf == NULL) {
+            s->mctp_package.tx_buf = g_array_new(false, false, sizeof(uint8_t));
+        }
+
+        s->mctp_package.rx_ready = false;
+        s->mctp_package.metadata.dest_slave = i2c_hdr->dest_slave;
+        s->mctp_package.metadata.source_slave = i2c_hdr->source_slave;
+        s->mctp_package.metadata.dest = hdr->dest;
+        s->mctp_package.metadata.src = hdr->src;
+        s->mctp_package.metadata.msg_tag =
+            hdr->flags_seq_tag & MCTP_HDR_TAG_MASK;
+    }
+
+    if (hdr->flags_seq_tag & MCTP_HDR_FLAG_EOM) {
+        s->mctp_package.rx_ready = true;
+    }
+
+    payload_offset = sizeof(struct mctp_i2c_hdr) + sizeof(struct mctp_hdr);
+    payload_len = s->rx_len - payload_offset; /* exclude PEC */
+
+    g_array_append_vals(s->mctp_package.rx_buf,
+                        s->rx + payload_offset, payload_len);
+    qemu_log_mask(LOG_GUEST_ERROR, "rx_buf len %d\n",
+                  s->mctp_package.rx_buf->len);
+
+    return 0;
+}
+
+static void mctp_package_handler(MctpI2cResponder *s)
+{
+    struct mctp_payload *payload =
+        (struct mctp_payload *)s->mctp_package.rx_buf->data;
+    MctpI2cResponderMsgHandler handler = NULL;
+
+    if (s->handlers) {
+        handler = (MctpI2cResponderMsgHandler)
+            g_hash_table_lookup(s->handlers,
+                                GINT_TO_POINTER((int)payload->msg_type));
+    }
+
+    if (handler) {
+        handler(s);
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "mctp: unknown msg_type %d\n",
+                      payload->msg_type);
+    }
+
+    /* Ensure rx/tx buffers don't leak if handler is missing or placeholder. */
+    mctp_i2c_responder_cleanup_after_handler(s);
+}
+
+static void mctp_rx_handler(MctpI2cResponder *s)
+{
+    if (s->rx_len < MCTP_I2C_MINLEN + 1) {
+        goto exit;
+    }
+
+    if (mctp_rx_package_verify(s) != 0) {
+        goto exit;
+    }
+
+    if (mctp_package_do_frame(s) != 0) {
+        goto exit;
+    }
+
+    if (!s->mctp_package.rx_ready) {
+        goto exit;
+    }
+
+    mctp_package_handler(s);
+
+    mctp_package_response(s);
+
+exit:
+    s->rx_len = 0;
+}
+
+static int mctp_i2c_event(I2CSlave *i2c, enum i2c_event event)
+{
+    MctpI2cResponder *s = MCTP_I2C_RESPONDER(i2c);
+
+    switch (event) {
+    case I2C_START_SEND:
+        s->rx[0] = i2c->address << 1 | 0;
+        s->rx_len = 1;
+        return 0;
+    case I2C_FINISH:
+        mctp_rx_handler(s);
+        return 0;
+    default:
+        return 0;
+    }
+}
+
+static int mctp_i2c_send(I2CSlave *i2c, uint8_t data)
+{
+    MctpI2cResponder *s = MCTP_I2C_RESPONDER(i2c);
+
+    if (s->rx_len >= BUF_SZ) {
+        return -1;
+    }
+
+    s->rx[s->rx_len++] = data;
+    return 0;
+}
+
+static uint8_t mctp_i2c_recv(I2CSlave *i2c)
+{
+    MctpI2cResponder *s = MCTP_I2C_RESPONDER(i2c);
+    return (s->tx_pos < s->tx_len) ? s->tx[s->tx_pos++] : 0xff;
+}
+
+static const Property mctp_i2c_props[] = {
+    DEFINE_PROP_UINT8("eid", MctpI2cResponder, eid, 0x00),
+    DEFINE_PROP_UINT16("mtu", MctpI2cResponder, mtu, 64),
+    DEFINE_PROP_UUID("uuid", MctpI2cResponder, uuid),
+};
+
+static void mctp_i2c_class_init(ObjectClass *oc, const void *data)
+{
+    I2CSlaveClass *sc = I2C_SLAVE_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    MctpI2cResponderClass *mc = MCTP_I2C_RESPONDER_CLASS(oc);
+    device_class_set_props(dc, mctp_i2c_props);
+    sc->event = mctp_i2c_event;
+    sc->send = mctp_i2c_send;
+    sc->recv = mctp_i2c_recv;
+
+    /* Base class default: only MCTP Control handler is registered. */
+    mc->init_handlers = mctp_i2c_init_handlers_default;
+}
+
+static void mctp_i2c_init_handlers_default(MctpI2cResponder *s)
+{
+    mctp_i2c_responder_register_msg_handler(s, MCTP_MSG_TYPE_CTRL,
+                                            mctp_ctrl_handler);
+}
+
+static void mctp_i2c_instance_init(Object *obj)
+{
+    MctpI2cResponder *s = MCTP_I2C_RESPONDER(obj);
+    MctpI2cResponderClass *mc = MCTP_I2C_RESPONDER_GET_CLASS(s);
+
+    s->handlers = g_hash_table_new(g_direct_hash, g_direct_equal);
+    s->tx_queue = g_queue_new();
+    /* Allow QOM sub-types to extend supported message types via class hook. */
+    mc->init_handlers(s);
+}
+
+static void mctp_i2c_instance_finalize(Object *obj)
+{
+    MctpI2cResponder *s = MCTP_I2C_RESPONDER(obj);
+
+    if (s->bh) {
+        qemu_bh_delete(s->bh);
+        s->bh = NULL;
+    }
+
+    g_free(s->active_tx);
+    s->active_tx = NULL;
+
+    if (s->tx_queue) {
+        while (!g_queue_is_empty(s->tx_queue)) {
+            g_free(g_queue_pop_head(s->tx_queue));
+        }
+        g_queue_free(s->tx_queue);
+        s->tx_queue = NULL;
+    }
+
+    if (s->mctp_package.rx_buf) {
+        g_array_free(s->mctp_package.rx_buf, true);
+        s->mctp_package.rx_buf = NULL;
+    }
+
+    if (s->mctp_package.tx_buf) {
+        g_array_free(s->mctp_package.tx_buf, true);
+        s->mctp_package.tx_buf = NULL;
+    }
+
+    if (s->handlers) {
+        g_hash_table_destroy(s->handlers);
+        s->handlers = NULL;
+    }
+}
+
+static const TypeInfo mctp_i2c_type_info = {
+    .name = TYPE_MCTP_I2C_RESPONDER,
+    .parent = TYPE_I2C_SLAVE,
+    .instance_size = sizeof(MctpI2cResponder),
+    .class_size = sizeof(MctpI2cResponderClass),
+    .class_init = mctp_i2c_class_init,
+    .instance_init = mctp_i2c_instance_init,
+    .instance_finalize = mctp_i2c_instance_finalize,
+};
+
+static void mctp_i2c_register_types(void)
+{
+    type_register_static(&mctp_i2c_type_info);
+}
+type_init(mctp_i2c_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2a..8b7d3f974ca 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -150,6 +150,11 @@ system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_ahb_apb_pnp.c'))
 
 system_ss.add(when: 'CONFIG_I2C_ECHO', if_true: files('i2c-echo.c'))
 
+system_ss.add(when: 'CONFIG_MCTP_I2C_RESPONDER', if_true: files(
+  'mctp-i2c-responder.c',
+  'mctp-i2c-responder-ncsi.c',
+))
+
 specific_ss.add(when: 'CONFIG_AVR_POWER', if_true: files('avr_power.c'))
 
 specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files('mac_via.c'))
diff --git a/include/hw/misc/mctp-i2c-responder.h b/include/hw/misc/mctp-i2c-responder.h
new file mode 100644
index 00000000000..828185b3ed6
--- /dev/null
+++ b/include/hw/misc/mctp-i2c-responder.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Minimal MCTP-over-SMBus/I2C responder (I2C slave) public hooks.
+ *
+ * This header exists to allow QOM sub-types to extend supported MCTP message
+ * types (e.g. NCSI control) without duplicating the base I2C/framing logic.
+ */
+
+#ifndef HW_MISC_MCTP_I2C_RESPONDER_H
+#define HW_MISC_MCTP_I2C_RESPONDER_H
+
+#include <stddef.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <glib.h>
+#include "hw/i2c/i2c.h"
+#include "qemu/main-loop.h"
+#include "qemu/uuid.h"
+#include "qom/object.h"
+
+#define TYPE_MCTP_I2C_RESPONDER "mctp-i2c-responder"
+OBJECT_DECLARE_TYPE(MctpI2cResponder, MctpI2cResponderClass, MCTP_I2C_RESPONDER)
+
+/* MCTP message types (DSP0236). */
+#define MCTP_MSG_TYPE_CTRL         0x00
+#define MCTP_MSG_TYPE_PLDM         0x01
+#define MCTP_MSG_TYPE_NCSI_CONTROL 0x02
+
+typedef void (*MctpI2cResponderMsgHandler)(MctpI2cResponder *s);
+
+#ifndef MCTP_I2C_RESPONDER_BUF_SZ
+#define MCTP_I2C_RESPONDER_BUF_SZ 300
+#endif
+
+/* Keep compatibility with existing .c uses. */
+#ifndef BUF_SZ
+#define BUF_SZ MCTP_I2C_RESPONDER_BUF_SZ
+#endif
+
+/* Internal buffers/queues shared by base and subtypes. */
+struct mctp_metadata {
+    uint8_t dest;
+    uint8_t src;
+    uint8_t msg_tag;
+    uint8_t dest_slave;
+    uint8_t source_slave;
+};
+
+struct mctp_package {
+    struct mctp_metadata metadata;
+
+    GArray *rx_buf;
+    bool rx_ready; /* met eom */
+
+    GArray *tx_buf;
+};
+
+struct mctp_per_tx {
+    uint8_t buf[BUF_SZ];
+    size_t len;
+    size_t pos;
+};
+
+struct MctpI2cResponder {
+    /* i2c controller */
+    I2CSlave parent_obj;
+    QEMUBH *bh;
+
+    /* MCTP rx/tx raw buffer */
+    struct mctp_package mctp_package;
+
+    /* I2C rx buffer */
+    uint8_t rx[BUF_SZ];
+    uint16_t rx_len;
+
+    /* I2C master tx queue */
+    GQueue *tx_queue;
+    struct mctp_per_tx *active_tx;
+
+    uint8_t master_tx[BUF_SZ];
+    uint16_t master_len;
+    uint16_t master_pos;
+
+    /* I2C tx buffer, unused for mctp */
+    uint8_t tx[BUF_SZ];
+    uint16_t tx_len;
+    uint16_t tx_pos;
+
+    /* MCTP properties */
+    uint8_t eid;
+    uint16_t mtu;
+    QemuUUID uuid;
+
+    /* message handlers */
+    GHashTable *handlers;
+    /* key: msg_type (GINT_TO_POINTER(uint8)), value: handler */
+};
+
+struct MctpI2cResponderClass {
+    I2CSlaveClass parent_class;
+
+    /* Optional hook: (re)initialize message handlers for this instance. */
+    void (*init_handlers)(MctpI2cResponder *s);
+};
+
+void mctp_i2c_responder_register_msg_handler(
+    MctpI2cResponder *s, uint8_t msg_type,
+    MctpI2cResponderMsgHandler handler);
+
+/* Minimal helper APIs for out-of-file message handlers. */
+const uint8_t *mctp_i2c_responder_get_rx_buf(MctpI2cResponder *s, size_t *len);
+bool mctp_i2c_responder_tx_begin(MctpI2cResponder *s, uint8_t msg_type);
+bool mctp_i2c_responder_tx_append(MctpI2cResponder *s,
+                                  const void *buf, size_t len);
+
+#endif /* HW_MISC_MCTP_I2C_RESPONDER_H */
-- 
2.20.1

