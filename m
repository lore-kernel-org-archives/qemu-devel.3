Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE86C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 05:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXa5h-0004zg-2c; Wed, 07 Feb 2024 00:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1rXa5e-0004yK-9c; Wed, 07 Feb 2024 00:03:18 -0500
Received: from mail-dm3nam02on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2405::600]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1rXa5b-0000ho-VK; Wed, 07 Feb 2024 00:03:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyLxxOzougZXTXRVQJ3vXLCxAWibUpB/YqusVMwIKr93E2Kav0HL5tIvYz6dLliVkLKf0IgkfTUeJV3KMUUd8lCkGbeirj3/TpmMwVQKLrTrTloGRylINFQ1up3NqsstZxCOZA6MNdSWjt/egq2SRvrYZwo0rfxZH+q74+Y4gyon6ZMe2DSI3gsXsev+ZEGg/EIWVy7ZpjO21bj82TX40pYnhIcV4kK3vPEY0nX+WrBSpQI1TILQNZ0B6mOS18N9dWS+voUj+Axvcqyn6BizVTzDVap7PuihWsjO3zlg9/0jpW3fhQGALeWKWgHuIQDm2LEoqgCKsimjlFGG5iGkUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2O0fD9H/7OxCGOXVCEsk9fEmsriQA2ok6LgnRtZ1oM=;
 b=RxXoHnhNR9/rsVKMEJ2RSHYWtL6PBYuu1nAREpNa1qH9p/ugrxukejBhx1I5eWTemLbLslHESIRxu6ZlZqxvxTb2y5u4gP/bVEI1ARWU9cfQCl/rlw9f7xrnrnvx5AnczFvRKZVYSEBVF/g1qx96ZAPGXst6L3ObFtlygrYTk2xpWCNgBMfP0tNTmQVP7H8Z20hGJQ7C+KIL9ZhmaPRZOsZo7IdcT/pTlUfG/PVi4EMDTb55AdQ87g8QlNRFQMTVMmM42UXHdnw3ddCKO7f5s87DoSv5iDbjQ6JDtvUAQBytk2JGwvHbvrIkLy3zBXCw/JFY/umtwXvVc1PMRdY1Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2O0fD9H/7OxCGOXVCEsk9fEmsriQA2ok6LgnRtZ1oM=;
 b=hYwg/jGM5+h6YFjfh5BRLsVm7G6CssOw/sNIOurU9hSA0iboL+kCA8xJRaCSphj57LQwbt6jOSwcgy9fJVc/t2L+4f1M4vFGwoBQEDwfF6gCbSd/wg+FlKoNDDn64Do7oxbe05M43dNj6ni4n8gGzeNstVKKGih7UE+K/wViGnw=
Received: from CYZPR14CA0014.namprd14.prod.outlook.com (2603:10b6:930:8f::12)
 by DM4PR12MB5184.namprd12.prod.outlook.com (2603:10b6:5:397::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Wed, 7 Feb
 2024 05:03:10 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:8f:cafe::86) by CYZPR14CA0014.outlook.office365.com
 (2603:10b6:930:8f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Wed, 7 Feb 2024 05:03:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.77) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 05:03:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 23:03:09 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 23:03:09 -0600
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 6 Feb 2024 23:03:08 -0600
From: Tong Ho <tong.ho@amd.com>
To: <qemu-arm@nongnu.org>
CC: <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <marcandre.lureau@redhat.com>, <pbonzini@redhat.com>, <tong.ho@amd.com>
Subject: [PATCH] hw/char/pl011: Add support for loopback
Date: Tue, 6 Feb 2024 21:03:08 -0800
Message-ID: <20240207050308.3221396-1-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|DM4PR12MB5184:EE_
X-MS-Office365-Filtering-Correlation-Id: 670866d2-0a41-4117-cd65-08dc279a1490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F6fuWKnm6TNSEEBWMlV8xcC2e2JQdmGHvhGpANNevvL/D4ZLXZsBNI9DOPAnr1aUGmicouBjkSw/poRKB42pmMI2DMrE/Hqrno/mCynygVvhS6vY8uCJ+x2g7Zi5F4N+qZXgcsJSG9Lxs/75C70hC5+pb3Lg07RF30j8SBuj+aJ6Zb7P/mld2W/1vGsfHFLYXbukzY59Zgc/u1RGxKQ6+P+hNwjMJ72uniAphtTjgrxnO141+7/XhMIf5zNVirUf4oWor/6XpbYA3EwfQsILCWxTPz+H+0zv0gey27iKpu10sb3UUqJolh9Y8F/W4C/rpcX7OHyk3uFHwQ7kN+8OQZNwQ8H9rc5IikLIhK0AxfweYGTHD0iMZJINDySQKD7SEu9Yg+Dui7vchagSWXqZIb66dCQLc7MyeCDnvWYByTpv4woqrcV+QICBAjZlF1JtIMlkBdm9QsxvVOQLNqZWhT4Oc+WvXImkG7L1P8QjI0FqeLrFAnzJ1HwU8N2+X5JPlqRQnDpIeKyyRHUi6mMFSYlUx/6TtuHbOEY8BhBhXDDyi4ClHyYukxYCNbdXimlCSjnlKCGK36RPyfxMKde4Y1gdqbGPE/5jp9PAxlYOaT0oWaKKnv1mBjTmGzg+n46ZHPYDbeFnfO9qCsAN4UC/2oP4AUmc80bR/jhelzkKJ7PTJ5agaf021bylEokbh/6kxDDSnPTJ9HhzEdp6gTqh0+s3lv0fMz2nJ9HdFbi4uegNm1zjJBKAacGdW/Q9xzdwzOvAZEnSlxR61J1tRxfOrw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(1800799012)(64100799003)(186009)(451199024)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(41300700001)(478600001)(86362001)(36756003)(83380400001)(426003)(47076005)(336012)(356005)(82740400003)(26005)(2616005)(1076003)(81166007)(44832011)(70586007)(2906002)(5660300002)(70206006)(8936002)(6916009)(8676002)(54906003)(36860700001)(4326008)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 05:03:10.2155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 670866d2-0a41-4117-cd65-08dc279a1490
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5184
Received-SPF: softfail client-ip=2a01:111:f403:2405::600;
 envelope-from=tong.ho@amd.com;
 helo=NAM02-DM3-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

This patch adds loopback for sent characters as well as
modem-control signals.

Loopback of send and modem-control is often used for uart
self tests in real hardware but missing from current pl011
model, resulting in self-test failures when running in QEMU.

Signed-off-by: Tong Ho <tong.ho@amd.com>
Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 hw/char/pl011.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 855cb82d08..3c0e07aa35 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -121,6 +121,51 @@ static void pl011_update(PL011State *s)
     }
 }
 
+static void pl011_put_fifo(void *opaque, uint32_t value);
+
+static bool pl011_is_loopback(PL011State *s)
+{
+    return !!(s->cr & (1U << 7));
+}
+
+static void pl011_tx_loopback(PL011State *s, uint32_t value)
+{
+    if (pl011_is_loopback(s)) {
+        pl011_put_fifo(s, value);
+    }
+}
+
+static uint32_t pl011_cr_loopback(PL011State *s, bool update)
+{
+    uint32_t cr = s->cr;
+    uint32_t fr = s->flags;
+    uint32_t ri = 1 << 8, dcd = 1 << 2, dsr = 1 << 1, cts = 0;
+    uint32_t out2 = 1 << 13, out1 = 1 << 12, rts = 1 << 11, dtr = 1 << 10;
+
+    if (!pl011_is_loopback(s)) {
+        return fr;
+    }
+
+    fr &= ~(ri | dcd | dsr | cts);
+    fr |= (cr & out2) ?  ri : 0;   /* FR.RI  <= CR.Out2 */
+    fr |= (cr & out1) ? dcd : 0;   /* FR.DCD <= CR.Out1 */
+    fr |= (cr &  rts) ? cts : 0;   /* FR.CTS <= CR.RTS */
+    fr |= (cr &  dtr) ? dsr : 0;   /* FR.DSR <= CR.DTR */
+
+    if (!update) {
+        return fr;
+    }
+
+    s->int_level &= ~(INT_DSR | INT_DCD | INT_CTS | INT_RI);
+    s->int_level |= (fr & dsr) ? INT_DSR : 0;
+    s->int_level |= (fr & dcd) ? INT_DCD : 0;
+    s->int_level |= (fr & cts) ? INT_CTS : 0;
+    s->int_level |= (fr &  ri) ? INT_RI  : 0;
+    pl011_update(s);
+
+    return fr;
+}
+
 static bool pl011_is_fifo_enabled(PL011State *s)
 {
     return (s->lcr & LCR_FEN) != 0;
@@ -172,7 +217,7 @@ static uint64_t pl011_read(void *opaque, hwaddr offset,
         r = s->rsr;
         break;
     case 6: /* UARTFR */
-        r = s->flags;
+        r = pl011_cr_loopback(s, false);
         break;
     case 8: /* UARTILPR */
         r = s->ilpr;
@@ -267,6 +312,7 @@ static void pl011_write(void *opaque, hwaddr offset,
          * qemu_chr_fe_write and background I/O callbacks */
         qemu_chr_fe_write_all(&s->chr, &ch, 1);
         s->int_level |= INT_TX;
+        pl011_tx_loopback(s, ch);
         pl011_update(s);
         break;
     case 1: /* UARTRSR/UARTECR */
@@ -300,8 +346,9 @@ static void pl011_write(void *opaque, hwaddr offset,
         pl011_set_read_trigger(s);
         break;
     case 12: /* UARTCR */
-        /* ??? Need to implement the enable and loopback bits.  */
+        /* ??? Need to implement the enable bit.  */
         s->cr = value;
+        pl011_cr_loopback(s, true);
         break;
     case 13: /* UARTIFS */
         s->ifl = value;
-- 
2.25.1


