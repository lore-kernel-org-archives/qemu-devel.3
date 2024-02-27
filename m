Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B4F2C54E49
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 05:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reqKy-0007kO-Ja; Tue, 27 Feb 2024 00:49:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1reqKw-0007jg-OD; Tue, 27 Feb 2024 00:49:06 -0500
Received: from mail-sn1nam02on20610.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::610]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1reqKu-0006MY-FR; Tue, 27 Feb 2024 00:49:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALu11sFk5V4oWQoJog999lOiaE7hf53nt+pVLUpbJ86sBg/4noZ1DRWnKXdIOeqsSwdJgzY/gzCFHTt8s39eFL/9zNswNa6ZwAK+ydWAN7zbgzUPCs1qmFSN6NkEaUjBCvK8UOMrSl2EXqtK8i0FGepKYIlcqfxEiFGlm2evPh6eGDJGB3canSOAWzLHtT+0VEB/Zyj0tmMXqeOCzeQZkayGwxgS4KcWWZFJ/Mq2EqfhQfBpmxbmfcBS/WliWNjcyPgz92un281K8BgbioOWwxfuESOglFk64zBejqHUwV3M733EWwhPX2sZ8WDsJj3a2T8H2u5x/ou7teal4a8yvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWyy3bu1IBEx02zPLjk0z3Cp0KHpwx0cgiSOf2G5HNA=;
 b=BJ/wp4FupGklJa77dpORLBJkwr9+5oU7tpPjEcDUEC5YIUHFdEBhvzKvTs9M+CSY9ZIb/fVMC5EiZvRaGhiia64v/7h/ZsandDvUTu+hr11+H/Ags8kuqIA2QTzwrkl1h/pJsaCuRPfCdo5eRUhX8PdCFCZ00zj7mz/9dNjLdkDXTWM+01HnVOrLT7mSnK+/TvyqvRIyyoiuCH6LvJn5TyFUaCj5+L/j/Y1BRUPmeHuzuOai+8XmHG02hyS4LfHKHQkvMFsgOYC2RvfPifX9OiXavx4fzzQ2bwwjxNheuH/rGVwmK9S8cEmzm7pJtuJJPzpMosv/U7OeYXvh6RrMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWyy3bu1IBEx02zPLjk0z3Cp0KHpwx0cgiSOf2G5HNA=;
 b=tdGEB4zpxZfNeJTCmZOh/w79O0GMnb2lzZV4+F1U2gwdfKtIB9Br5S8djqnm746wJ707NEX6n3TidHWipf022BYb5ey9gziXSmJ5nOqkssNf8E/8tN9C50wa8kpEzKzAUD47VL18Hsu55vQpy3c6p4wZNeOFbIVuPeYcVhePr0Q=
Received: from CH0PR03CA0310.namprd03.prod.outlook.com (2603:10b6:610:118::33)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 05:48:57 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::77) by CH0PR03CA0310.outlook.office365.com
 (2603:10b6:610:118::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Tue, 27 Feb 2024 05:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 05:48:57 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 23:48:56 -0600
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 26 Feb 2024 23:48:56 -0600
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <marcandre.lureau@redhat.com>, <pbonzini@redhat.com>,
 <francisco.iglesias@amd.com>, <tong.ho@amd.com>
Subject: [PATCH v2] hw/char/pl011: Add support for loopback
Date: Mon, 26 Feb 2024 21:48:55 -0800
Message-ID: <20240227054855.44204-1-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: tong.ho@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: 37111edb-ac2c-4bdd-c3d7-08dc3757ca29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ed636DHO4jLb5uVjpSOqBJGSBmTFx8UXNBZEoztSZ77+bSKjHly0H6Ca1Mr9krQ4EkS0nPsBoGl2G9TTzUCSIm2kWQxEa5C/+3ct/LWrmNqPViKy8/4UhHWyx13hgM9KKUEl0NOIcbi4LpQK/5Z1d+yYzOfqEoYGzU85Bj5IU91AtZYhF2nH56XSetZkyB+BrdMmt5wG9K5CrPEVrneCt3q0MqPmsGzBeW2EagzbGX5DFYgtAjBnFYnxFWze5AfmicLgkrflHRlV6wNFyrexoOgaLNtThHeP6/GMaCXz746O5nMfOGY+NVZFQDhDwU9lsn3s7+qWfBxFNK1RiRT+DGANKe3HGU7SZcCL8C2jzAcZJHqMAQM133egJrRy1Lwlfy0EBB+t/NHSb+6xyhYG1fgCre8/Z7TsyiSIPIR3ar/lSq42KN4uhD9mVEcSKke/ok+EDxXgZHUy/kK13Id7LJH9/uHjH9DqR0WPN5Nlouc5+YlsrJZXCBYjwf3ofm6tpiHcsJwThBUVzk6GDNYYdAlRS1gMbTn6J4AnuYy0nlH4S0yyPYLb+IluwbSiAtUKpdUh+qJJKEHm/YXA+rargcLFYz/+JHGtfQylm0LEbj5mXtoiO1wwSa2O89hB2ce7FDyFVu0JtIp07WiZOMbRASRhhTroPaX8+EhR3AkcQu+X89EXzEskpZ3OVJWfxRzDaPzt8u4kBCkHFODG19QL94lCClIDKcnG0mB9Kr6FC3psbD7qg4c9WEVu+SFIOKtG
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 05:48:57.2559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37111edb-ac2c-4bdd-c3d7-08dc3757ca29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841
Received-SPF: softfail client-ip=2a01:111:f400:7ea9::610;
 envelope-from=tong.ho@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch adds loopback for sent characters, sent BREAK,
and modem-control signals.

Loopback of send and modem-control is often used for uart
self tests in real hardware but missing from current pl011
model, resulting in self-test failures when running in QEMU.

This implementation matches what is observed in real pl011
hardware placed in loopback mode:
1. Input characters and BREAK events from serial backend
   are ignored, but
2. Both TX characters and BREAK events are still sent to
   serial backend, in addition to be looped back to RX.

Signed-off-by: Tong Ho <tong.ho@amd.com>
Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/char/pl011.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 855cb82d08..8753b84a84 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -49,10 +49,14 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 }
 
 /* Flag Register, UARTFR */
+#define PL011_FLAG_RI   0x100
 #define PL011_FLAG_TXFE 0x80
 #define PL011_FLAG_RXFF 0x40
 #define PL011_FLAG_TXFF 0x20
 #define PL011_FLAG_RXFE 0x10
+#define PL011_FLAG_DCD  0x04
+#define PL011_FLAG_DSR  0x02
+#define PL011_FLAG_CTS  0x01
 
 /* Data Register, UARTDR */
 #define DR_BE   (1 << 10)
@@ -76,6 +80,13 @@ DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr)
 #define LCR_FEN     (1 << 4)
 #define LCR_BRK     (1 << 0)
 
+/* Control Register, UARTCR */
+#define CR_OUT2     (1 << 13)
+#define CR_OUT1     (1 << 12)
+#define CR_RTS      (1 << 11)
+#define CR_DTR      (1 << 10)
+#define CR_LBE      (1 << 7)
+
 static const unsigned char pl011_id_arm[8] =
   { 0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };
 static const unsigned char pl011_id_luminary[8] =
@@ -251,6 +262,89 @@ static void pl011_trace_baudrate_change(const PL011State *s)
                                 s->ibrd, s->fbrd);
 }
 
+static bool pl011_loopback_enabled(PL011State *s)
+{
+    return !!(s->cr & CR_LBE);
+}
+
+static void pl011_loopback_mdmctrl(PL011State *s)
+{
+    uint32_t cr, fr, il;
+
+    if (!pl011_loopback_enabled(s)) {
+        return;
+    }
+
+    /*
+     * Loopback software-driven modem control outputs to modem status inputs:
+     *   FR.RI  <= CR.Out2
+     *   FR.DCD <= CR.Out1
+     *   FR.CTS <= CR.RTS
+     *   FR.DSR <= CR.DTR
+     *
+     * The loopback happens immediately even if this call is triggered
+     * by setting only CR.LBE.
+     *
+     * CTS/RTS updates due to enabled hardware flow controls are not
+     * dealt with here.
+     */
+    cr = s->cr;
+    fr = s->flags & ~(PL011_FLAG_RI | PL011_FLAG_DCD |
+                      PL011_FLAG_DSR | PL011_FLAG_CTS);
+    fr |= (cr & CR_OUT2) ? PL011_FLAG_RI  : 0;
+    fr |= (cr & CR_OUT1) ? PL011_FLAG_DCD : 0;
+    fr |= (cr & CR_RTS)  ? PL011_FLAG_CTS : 0;
+    fr |= (cr & CR_DTR)  ? PL011_FLAG_DSR : 0;
+
+    /* Change interrupts based on updated FR */
+    il = s->int_level & ~(INT_DSR | INT_DCD | INT_CTS | INT_RI);
+    il |= (fr & PL011_FLAG_DSR) ? INT_DSR : 0;
+    il |= (fr & PL011_FLAG_DCD) ? INT_DCD : 0;
+    il |= (fr & PL011_FLAG_CTS) ? INT_CTS : 0;
+    il |= (fr & PL011_FLAG_RI)  ? INT_RI  : 0;
+
+    s->flags = fr;
+    s->int_level = il;
+    pl011_update(s);
+}
+
+static void pl011_put_fifo(void *opaque, uint32_t value);
+
+static void pl011_loopback_tx(PL011State *s, uint32_t value)
+{
+    if (!pl011_loopback_enabled(s)) {
+        return;
+    }
+
+    /*
+     * Caveat:
+     *
+     * In real hardware, TX loopback happens at the serial-bit level
+     * and then reassembled by the RX logics back into bytes and placed
+     * into the RX fifo. That is, loopback happens after TX fifo.
+     *
+     * Because the real hardware TX fifo is time-drained at the frame
+     * rate governed by the configured serial format, some loopback
+     * bytes in TX fifo may still be able to get into the RX fifo
+     * that could be full at times while being drained at software
+     * pace.
+     *
+     * In such scenario, the RX draining pace is the major factor
+     * deciding which loopback bytes get into the RX fifo, unless
+     * hardware flow-control is enabled.
+     *
+     * For simplicity, the above described is not emulated.
+     */
+    pl011_put_fifo(s, value);
+}
+
+static void pl011_loopback_break(PL011State *s, int brk_enable)
+{
+    if (brk_enable) {
+        pl011_loopback_tx(s, DR_BE);
+    }
+}
+
 static void pl011_write(void *opaque, hwaddr offset,
                         uint64_t value, unsigned size)
 {
@@ -266,6 +360,7 @@ static void pl011_write(void *opaque, hwaddr offset,
         /* XXX this blocks entire thread. Rewrite to use
          * qemu_chr_fe_write and background I/O callbacks */
         qemu_chr_fe_write_all(&s->chr, &ch, 1);
+        pl011_loopback_tx(s, ch);
         s->int_level |= INT_TX;
         pl011_update(s);
         break;
@@ -295,13 +390,15 @@ static void pl011_write(void *opaque, hwaddr offset,
             int break_enable = value & LCR_BRK;
             qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
                               &break_enable);
+            pl011_loopback_break(s, break_enable);
         }
         s->lcr = value;
         pl011_set_read_trigger(s);
         break;
     case 12: /* UARTCR */
-        /* ??? Need to implement the enable and loopback bits.  */
+        /* ??? Need to implement the enable bit.  */
         s->cr = value;
+        pl011_loopback_mdmctrl(s);
         break;
     case 13: /* UARTIFS */
         s->ifl = value;
@@ -361,12 +458,21 @@ static void pl011_put_fifo(void *opaque, uint32_t value)
 
 static void pl011_receive(void *opaque, const uint8_t *buf, int size)
 {
+    /*
+     * In loopback mode, the RX input signal is internally disconnected
+     * from the entire receiving logics; thus, all inputs are ignored,
+     * and BREAK detection on RX input signal is also not performed.
+     */
+    if (pl011_loopback_enabled(opaque)) {
+        return;
+    }
+
     pl011_put_fifo(opaque, *buf);
 }
 
 static void pl011_event(void *opaque, QEMUChrEvent event)
 {
-    if (event == CHR_EVENT_BREAK) {
+    if (event == CHR_EVENT_BREAK && !pl011_loopback_enabled(opaque)) {
         pl011_put_fifo(opaque, DR_BE);
     }
 }
-- 
2.25.1


