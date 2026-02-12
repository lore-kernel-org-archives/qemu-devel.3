Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE39BEE36B0
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 17:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqahG-00087l-Ow; Thu, 12 Feb 2026 12:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1vqahF-00086v-02
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 12:41:45 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1vqahC-0002Xa-SR
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 12:41:44 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-408199852c5so50857fac.0
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 09:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard.net; s=google; t=1770918100; x=1771522900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yDTi7HslrZikJ1EUQBDRsEFUZ77CfEi18p0+zH03j1s=;
 b=BnXpnmYTmbTeKxsVMw+N2DHADtgb4qlDeb+wPgX09itJ2CAkIm0td9gc30AkIU5DCy
 eCM4eKFel5o0rlDfa1tdsN3w7nntFL/ApzxWeQIo3aOhmYqHO94SM6h73QxDkcXQDu2/
 XQh0rMQbIMBCS+hecKMixOL9A4XZjAzMIN45yskBSt9SuFPUtbjTz/Y8dtleR9K8tlrn
 bVDbbvWkg/Td9mmrIfwP2Lc21NGPa8p619wLonSnogU+xSJz8bOLVMQpt2gN2/LFHDox
 q3s1wF7fdCSu1iAinAXrwuFku9saDbiqwV2ucCFIR3yjGeJ4aSH4nBw2IOLssWoSCawg
 IT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770918100; x=1771522900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yDTi7HslrZikJ1EUQBDRsEFUZ77CfEi18p0+zH03j1s=;
 b=oenoGzuG9cWjNLMVlf4AGVVr5wM2x7FH+FpRnGLCNbZfpt5DyLjWC3qNLAhFP/AMlS
 Xgg/HIn91jAJ2z6DLGw4BqgJq+OH20Ni207gLn4/kWIro4z0Bqb3nBx3bn3pysrsJsy/
 pI2FOp2P1Kf6TvY/QcB2NwDZkRWOHj+lfUZtpk6rc+zwZG91UxtB9vvuyDjSyWFlXfJk
 QldbMfES0HAO6aeA7GnoEzArQ3sONQzDB5bVs3yEuKqJwn1xmi7g0+1NGyEHg0c1n2s/
 sD8Oj+f/rYsACbk73Vo3u/+8eQ5sEoihzMMxMPFSFZb0K7leDMJ4lllirYA79iX39fcm
 /nkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwkjkICwWYCLqOtF7examEitUjq66wOVHjt5K7sp/apsHObtH6sJ5q0nUTQM3pXwGyTjKw5jD3754U@nongnu.org
X-Gm-Message-State: AOJu0YyZ3URHBsmou8zHED8cfSDPV6v+KK9q5GmtFNtH7HDEbfbXuNYV
 HgYGawPXxpObgHO5qzKnQwnYLKY346oyoFI6YY3kkH53jcEcVjqXekxncivGQrxNXBM=
X-Gm-Gg: AZuq6aJ/V0q1FJQqg3GWIkfDpondWGH+l2Dn7IkcOfLjdtW7i8pnNh6qtX2ajSbw5QI
 LylGuyBt7LyIcv2b3qMsvvHTH+wCZ9Wrae89/GzWuvSXzdD2rj6V5l4fPY4T3nWNINAXbu0UHmh
 UfEhmOZmAVP2cyphUe54bYf0xwppYq13fHvo/dpvLNVCPHufp5LrkTjeiVIKaMzjcjP4mzhd0nn
 /0Nmb/bb7YNHoSzbPMsLUyOoAl1nuZNl8xiKV0GEcRvYpJ47GmrjgYUJxxTha6f7jQKKkqzIset
 UyMZcg4ftMxAbOClkzCR3mEbEcFNQobVK0/Fn+rZZBVE+GC9QnZqT4KZ0kc1oULEpH/EiFC5nZP
 P8PZ9g3Lb/IyIm0k0n8A5m81vhE6LhBi6ocUlwzNB4Vh+u94+wRRMSZ9M1MrqDF831Bp3dqXZi0
 J8IZ2NT+GgxEj2e8Djk8J3F/FI2U5aDClxay5MAANTOG8H80KNi5t25+xNOcBOUgBsgtHAEkudb
 InzPA==
X-Received: by 2002:a05:6871:2ea8:b0:3d4:6fba:31ff with SMTP id
 586e51a60fabf-40ec9fc322fmr1340835fac.1.1770918100191; 
 Thu, 12 Feb 2026 09:41:40 -0800 (PST)
Received: from localhost ([2001:470:b8f6:1b:ac4f:9c7a:97e9:f745])
 by smtp.gmail.com with UTF8SMTPSA id
 586e51a60fabf-40ee90ba325sm148055fac.8.2026.02.12.09.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Feb 2026 09:41:39 -0800 (PST)
From: Corey Minyard <corey@minyard.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Yunpeng Yang <yunpeng.yang@nutanix.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jonathan Davies <jond@nutanix.com>, Corey Minyard <corey@minyard.net>
Subject: [PULL 2/2] hw/ipmi/ipmi_bmc_sim: Support setting fake LAN channel
 config
Date: Thu, 12 Feb 2026 11:40:50 -0600
Message-ID: <20260212174103.504520-3-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212174103.504520-1-corey@minyard.net>
References: <20260212174103.504520-1-corey@minyard.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=corey@minyard.net; helo=mail-oa1-x2d.google.com
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

From: Yunpeng Yang <yunpeng.yang@nutanix.com>

The "Set LAN Configuration Parameters" IPMI command is added to the
`ipmi_bmc_sim` device to support dynamically setting fake LAN channel
configurations. With the fake LAN channel enabled, inside the guest OS,
tools such as `ipmitool` can be used to modify the configurations.

Signed-off-by: Yunpeng Yang <yunpeng.yang@nutanix.com>
Message-ID: <20260105155648.1037077-3-yunpeng.yang@nutanix.com>
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 hw/ipmi/ipmi_bmc_sim.c      | 110 +++++++++++++++++++++++++++
 tests/qtest/ipmi-kcs-test.c | 143 ++++++++++++++++++++++++++++++++++++
 2 files changed, 253 insertions(+)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index d88aa22b72..012e2ee4fe 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -106,6 +106,7 @@
 
 #define IPMI_NETFN_TRANSPORT          0x0c
 
+#define IPMI_CMD_SET_LAN_CONFIG           0x01
 #define IPMI_CMD_GET_LAN_CONFIG           0x02
 
 
@@ -300,6 +301,7 @@ struct IPMIBmcSim {
     ((ibs)->lan.channel != 0 && (ibs)->lan.channel == (c))
 
 #define IPMI_BMC_LAN_CFG_CC_PARAM_NOT_SUPPORTED    0x80
+#define IPMI_BMC_LAN_CFG_CC_PARAM_READONLY         0x82
 
 #define IPMI_BMC_LAN_CFG_PARAM_SET_IN_PROGRESS        0x00
 #define IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_SUPPORT      0x01
@@ -2126,6 +2128,113 @@ static inline bool is_ipv4_netmask_valid(const void *buf)
     return netmask != 0 && clo32(netmask) + ctz32(netmask) == 32;
 }
 
+/*
+ * Request data (from cmd[2] on):
+ * bytes   meaning
+ *    1    [bits 3:0] channel number
+ *    2    parameter selector
+ * [3:N]   configuration parameter data (from cmd[4] on)
+ */
+static void set_lan_config(IPMIBmcSim *ibs,
+                           uint8_t *cmd, unsigned int cmd_len,
+                           RspBuffer *rsp)
+{
+    uint8_t channel;
+    uint8_t *param;  /* pointer to configuration parameter data */
+    unsigned int param_len;
+
+    if (ibs->lan.channel == 0) {
+        /* LAN channel disabled. Fail as if this command were not defined. */
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_CMD);
+        return;
+    }
+    if (cmd_len < 5) {
+        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);
+        return;
+    }
+    channel = cmd[2] & 0xf;
+    param = cmd + 4;
+    param_len = cmd_len - 4;
+
+    if (!IPMI_BMC_CHANNEL_IS_LAN(ibs, channel)) {
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    switch (cmd[3]) {
+    case IPMI_BMC_LAN_CFG_PARAM_IP_ADDR:
+        if (param_len < NBYTES_IP) {
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);
+            return;
+        }
+        memcpy(ibs->lan.ipaddr, param, NBYTES_IP);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_IP_ADDR_SOURCE:
+        if (param_len < 1) {
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);
+            return;
+        }
+        if (!IPMI_BMC_LAN_CFG_IS_VALID_IP_SOURCE(*param)) {
+            rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+            return;
+        }
+        ibs->lan.ipsrc = *param;
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_MAC_ADDR:
+        if (param_len < NBYTES_MAC) {
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);
+            return;
+        }
+        memcpy(ibs->lan.macaddr.a, param, NBYTES_MAC);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_SUBNET_MASK:
+        if (param_len < NBYTES_IP) {
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);
+            return;
+        }
+        if (!is_ipv4_netmask_valid(param)) {
+            rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+            return;
+        }
+        memcpy(ibs->lan.netmask, param, NBYTES_IP);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_IP_ADDR:
+        if (param_len < NBYTES_IP) {
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);
+            return;
+        }
+        memcpy(ibs->lan.defgw_ipaddr, param, NBYTES_IP);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_DEFAULT_GW_MAC_ADDR:
+        if (param_len < NBYTES_MAC) {
+            rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_LENGTH_INVALID);
+            return;
+        }
+        memcpy(ibs->lan.defgw_macaddr.a, param, NBYTES_MAC);
+        break;
+
+    case IPMI_BMC_LAN_CFG_PARAM_SET_IN_PROGRESS:
+    case IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_SUPPORT:
+    case IPMI_BMC_LAN_CFG_PARAM_AUTH_TYPE_ENABLES:
+    case IPMI_BMC_LAN_CFG_PARAM_IPV4_HDR_PARAMS:
+    case IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_ADDR:
+    case IPMI_BMC_LAN_CFG_PARAM_BACKUP_GW_MAC_ADDR:
+    case IPMI_BMC_LAN_CFG_PARAM_COMMUNITY_STRING:
+    case IPMI_BMC_LAN_CFG_PARAM_NUM_DESTINATIONS:
+        rsp_buffer_set_error(rsp, IPMI_BMC_LAN_CFG_CC_PARAM_READONLY);
+        return;
+
+    default:
+        rsp_buffer_set_error(rsp, IPMI_BMC_LAN_CFG_CC_PARAM_NOT_SUPPORTED);
+        return;
+    }
+}
+
 /*
  * Request data (from cmd[2] to cmd[5] inclusive):
  * bytes   meaning
@@ -2324,6 +2433,7 @@ static const IPMINetfn storage_netfn = {
 };
 
 static const IPMICmdHandler transport_cmds[] = {
+    [IPMI_CMD_SET_LAN_CONFIG] = { set_lan_config },
     [IPMI_CMD_GET_LAN_CONFIG] = { get_lan_config },
 };
 static const IPMINetfn transport_netfn = {
diff --git a/tests/qtest/ipmi-kcs-test.c b/tests/qtest/ipmi-kcs-test.c
index 3186c6ad64..9bab0d84ad 100644
--- a/tests/qtest/ipmi-kcs-test.c
+++ b/tests/qtest/ipmi-kcs-test.c
@@ -262,6 +262,144 @@ static void test_enable_irq(void)
     kcs_ints_enabled = 1;
 }
 
+
+static uint8_t get_channel_access_cmd[] = { 0x18, 0x41, 0x01, 0x40 };
+static uint8_t get_channel_access_rsp[] = { 0x1c, 0x41, 0x00, 0x3a, 0x04 };
+
+/*
+ * Get channel access
+ */
+static void test_kcs_channel_access(void)
+{
+    uint8_t rsp[20];
+    unsigned int rsplen = sizeof(rsp);
+
+    kcs_cmd(get_channel_access_cmd, sizeof(get_channel_access_cmd),
+            rsp, &rsplen);
+    g_assert(rsplen == sizeof(get_channel_access_rsp));
+    g_assert(memcmp(get_channel_access_rsp, rsp, rsplen) == 0);
+}
+
+
+static uint8_t get_channel_info_cmd[] = { 0x18, 0x42, 0x01 };
+static uint8_t get_channel_info_rsp[] = { 0x1c, 0x42, 0x00, 0x01, 0x04, 0x01,
+                                          0x00, 0xf2, 0x1b, 0x00, 0x00, 0x00 };
+
+/*
+ * Get channel info
+ */
+static void test_kcs_channel_info(void)
+{
+    uint8_t rsp[20];
+    unsigned int rsplen = sizeof(rsp);
+
+    kcs_cmd(get_channel_info_cmd, sizeof(get_channel_info_cmd), rsp, &rsplen);
+    g_assert(rsplen == sizeof(get_channel_info_rsp));
+    g_assert(memcmp(get_channel_info_rsp, rsp, rsplen) == 0);
+}
+
+
+/* get ip address (specified in cmdline): 10.0.0.2 */
+static uint8_t get_ipaddr_cmd[] = { 0x30, 0x02, 0x01, 0x03, 0x00, 0x00 };
+static uint8_t get_ipaddr_rsp[] = { 0x34, 0x02, 0x00, 0x11,
+                                    0x0a, 0x00, 0x00, 0x02 };
+
+/*
+ * Get LAN configurations
+ */
+static void test_kcs_lan_get(void)
+{
+    uint8_t rsp[20];
+    unsigned int rsplen = sizeof(rsp);
+
+    kcs_cmd(get_ipaddr_cmd, sizeof(get_ipaddr_cmd), rsp, &rsplen);
+    g_assert(rsplen == sizeof(get_ipaddr_rsp));
+    g_assert(memcmp(get_ipaddr_rsp, rsp, rsplen) == 0);
+}
+
+
+/* set/get ip address: 192.0.2.2 */
+static uint8_t lan_set_ipaddr_cmd[] = { 0x30, 0x01, 0x01, 0x03,
+                                        0xc0, 0x00, 0x02, 0x02 };
+static uint8_t lan_set_ipaddr_rsp[] = { 0x34, 0x01, 0x00 };
+static uint8_t lan_get_ipaddr_cmd[] = { 0x30, 0x02, 0x01, 0x03, 0x00, 0x00 };
+static uint8_t lan_get_ipaddr_rsp[] = { 0x34, 0x02, 0x00, 0x11,
+                                        0xc0, 0x00, 0x02, 0x02 };
+/* set ip address source: static */
+static uint8_t lan_set_ipsrc_cmd[] = { 0x30, 0x01, 0x01, 0x04, 0x01 };
+static uint8_t lan_set_ipsrc_rsp[] = { 0x34, 0x01, 0x00 };
+
+/* set/get subnet mask: 255.255.255.0 */
+static uint8_t lan_set_netmask_cmd[] = { 0x30, 0x01, 0x01, 0x06,
+                                         0xff, 0xff, 0xff, 0x00 };
+static uint8_t lan_set_netmask_rsp[] = { 0x34, 0x01, 0x00 };
+static uint8_t lan_get_netmask_cmd[] = { 0x30, 0x02, 0x01, 0x06, 0x00, 0x00 };
+static uint8_t lan_get_netmask_rsp[] = { 0x34, 0x02, 0x00, 0x11,
+                                         0xff, 0xff, 0xff, 0x00 };
+
+/* set/get default gateway ip address: 192.0.2.1 */
+static uint8_t lan_set_defgw_ipaddr_cmd[] = { 0x30, 0x01, 0x01, 0x0c,
+                                              0xc0, 0x00, 0x02, 0x01 };
+static uint8_t lan_set_defgw_ipaddr_rsp[] = { 0x34, 0x01, 0x00 };
+static uint8_t lan_get_defgw_ipaddr_cmd[] = { 0x30, 0x02, 0x01, 0x0c,
+                                              0x00, 0x00 };
+static uint8_t lan_get_defgw_ipaddr_rsp[] = { 0x34, 0x02, 0x00, 0x11,
+                                              0xc0, 0x00, 0x02, 0x01 };
+
+/*
+ * Set and then get LAN configurations
+ */
+static void test_kcs_lan_set_get(void)
+{
+    uint8_t rsp[20];
+    unsigned int rsplen = 0;
+
+    /* set ip address */
+    rsplen = sizeof(rsp);
+    kcs_cmd(lan_set_ipaddr_cmd, sizeof(lan_set_ipaddr_cmd), rsp, &rsplen);
+    g_assert(rsplen == sizeof(lan_set_ipaddr_rsp));
+    g_assert(memcmp(lan_set_ipaddr_rsp, rsp, rsplen) == 0);
+
+    /* get ip address */
+    rsplen = sizeof(rsp);
+    kcs_cmd(lan_get_ipaddr_cmd, sizeof(lan_get_ipaddr_cmd), rsp, &rsplen);
+    g_assert(rsplen == sizeof(lan_get_ipaddr_rsp));
+    g_assert(memcmp(lan_get_ipaddr_rsp, rsp, rsplen) == 0);
+
+    /* set ip address source */
+    rsplen = sizeof(rsp);
+    kcs_cmd(lan_set_ipsrc_cmd, sizeof(lan_set_ipsrc_cmd), rsp, &rsplen);
+    g_assert(rsplen == sizeof(lan_set_ipsrc_rsp));
+    g_assert(memcmp(lan_set_ipsrc_rsp, rsp, rsplen) == 0);
+
+    /* set subnet mask */
+    rsplen = sizeof(rsp);
+    kcs_cmd(lan_set_netmask_cmd, sizeof(lan_set_netmask_cmd), rsp, &rsplen);
+    g_assert(rsplen == sizeof(lan_set_netmask_rsp));
+    g_assert(memcmp(lan_set_netmask_rsp, rsp, rsplen) == 0);
+
+    /* get subnet mask */
+    rsplen = sizeof(rsp);
+    kcs_cmd(lan_get_netmask_cmd, sizeof(lan_get_netmask_cmd), rsp, &rsplen);
+    g_assert(rsplen == sizeof(lan_get_netmask_rsp));
+    g_assert(memcmp(lan_get_netmask_rsp, rsp, rsplen) == 0);
+
+    /* set default gateway ip address */
+    rsplen = sizeof(rsp);
+    kcs_cmd(lan_set_defgw_ipaddr_cmd, sizeof(lan_set_defgw_ipaddr_cmd),
+            rsp, &rsplen);
+    g_assert(rsplen == sizeof(lan_set_defgw_ipaddr_rsp));
+    g_assert(memcmp(lan_set_defgw_ipaddr_rsp, rsp, rsplen) == 0);
+
+    /* get default gateway ip address */
+    rsplen = sizeof(rsp);
+    kcs_cmd(lan_get_defgw_ipaddr_cmd, sizeof(lan_get_defgw_ipaddr_cmd),
+            rsp, &rsplen);
+    g_assert(rsplen == sizeof(lan_get_defgw_ipaddr_rsp));
+    g_assert(memcmp(lan_get_defgw_ipaddr_rsp, rsp, rsplen) == 0);
+}
+
+
 int main(int argc, char **argv)
 {
     char *cmdline;
@@ -271,6 +409,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     cmdline = g_strdup_printf("-device ipmi-bmc-sim,id=bmc0"
+                                       ",lan.channel=1,lan.ipaddr=10.0.0.2"
                               " -device isa-ipmi-kcs,bmc=bmc0");
     qtest_start(cmdline);
     g_free(cmdline);
@@ -280,6 +419,10 @@ int main(int argc, char **argv)
     qtest_add_func("/ipmi/local/kcs_enable_irq", test_enable_irq);
     qtest_add_func("/ipmi/local/kcs_base_irq", test_kcs_base);
     qtest_add_func("/ipmi/local/kcs_abort_irq", test_kcs_abort);
+    qtest_add_func("/ipmi/local/kcs_channel_access", test_kcs_channel_access);
+    qtest_add_func("/ipmi/local/kcs_channel_info", test_kcs_channel_info);
+    qtest_add_func("/ipmi/local/kcs_lan_get", test_kcs_lan_get);
+    qtest_add_func("/ipmi/local/kcs_lan_set_get", test_kcs_lan_set_get);
     ret = g_test_run();
     qtest_quit(global_qtest);
 
-- 
2.43.0


