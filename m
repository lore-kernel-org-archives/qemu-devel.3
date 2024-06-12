Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEE6C27C75
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 21:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHVXz-0001mV-Th; Wed, 12 Jun 2024 17:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefano.stabellini@amd.com>)
 id 1sHVXx-0001lI-LU
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 17:30:21 -0400
Received: from mail-co1nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2416::601]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefano.stabellini@amd.com>)
 id 1sHVXv-0002pP-Rk
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 17:30:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGouXfDUR4is1wE367BxdWSA6foMKLV5+SjrFMhTbPwbmPD5gm7KBXLZibcvToli1ehmAr9efXo98OqgJdVXeaU3Py83ROITr7CseSR6npWGNl+xWYH0c0v53IkQkcpL7aaIlrw5D9mKlg1HTuJw/N7b+/CIL3FFJiFpdfDQ3oGH08VEvrlqs+dEnVOb5k4+24MizmiATTv86rCPvFdcwH3IdmRC3pUTmaNh0zns+sajIJYCrNqfMNVCzn/Mngzvf0NBLkPLKA4WU8EtazAKL9TCU17WWSa0jaZC7f1Cb8ryY0eiLbMitqNRgL8VL2u3ZTs+wrc8+O7I1ZFyImnhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS/ufF98+CmPb5JwYQeOLBlumDraNZo+bqd94MBYUeY=;
 b=ktK84kz7CIwZ4cEkPzG98Bul/M7LBKAQQH4jdog6lRxBh/AW+4H4Ntuuxh0E+Mvn6y8UDNN169tZPBDgcBvJI4P/xmUWyXBnIZUBuZXX9mUCS/5oD1k4vF058kYrDx4Pf+27mDPFQEO6qBxV53pmuPe+YMA72XcumiysYbXCMESFBrdgtGQfoIH7Np2a+d17FMbIOMOsS6gspnpq1lqLkIIt7bbr4CKn2U9a1ipNtKSp/oGUXRy7aoqdLlnZHnvy4gQUi0hKFnSi1jOz2e4Z9L3NkzhnlxY164V2RPe0rTZazaQ9LKsgQpYy/kKj4CgDud3IjG8/pmzsXePFvvM3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS/ufF98+CmPb5JwYQeOLBlumDraNZo+bqd94MBYUeY=;
 b=dYfCYD1hNCoNMa+PcWLqba4NzY8HsVeGy5nXYy/caf6c09W9tRFbNdtCsKmk2Rrea4JodICi31RZO6BOgRyzAGzIy34EHRIv0kEXHYWqiBFKHZcmhA1+50G2vYFsrriust6N2TsD9GmOvAIuSim1pXYJ0ASo1UUGNzMYyVkhzx4=
Received: from PH7P220CA0042.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::25)
 by DS0PR12MB8415.namprd12.prod.outlook.com (2603:10b6:8:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 21:30:14 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::36) by PH7P220CA0042.outlook.office365.com
 (2603:10b6:510:32b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Wed, 12 Jun 2024 21:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 12 Jun 2024 21:30:13 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Jun
 2024 16:30:12 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 12 Jun 2024 16:30:06 -0500
From: Stefano Stabellini <stefano.stabellini@amd.com>
To: <qemu-devel@nongnu.org>
CC: <stefanha@redhat.com>, <peter.maydell@linaro.org>,
 <sstabellini@kernel.org>, <Edgar.Iglesias@amd.com>, "Edgar E. Iglesias"
 <edgar.iglesias@amd.com>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: [PULL 5/5] hw/arm: xen: Enable use of grant mappings
Date: Wed, 12 Jun 2024 16:29:40 -0500
Message-ID: <20240612212940.2178248-5-stefano.stabellini@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alpine.DEB.2.22.394.2406121625590.1328433@ubuntu-linux-20-04-desktop>
References: <alpine.DEB.2.22.394.2406121625590.1328433@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: stefano.stabellini@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|DS0PR12MB8415:EE_
X-MS-Office365-Filtering-Correlation-Id: ace430e1-71d8-4c30-c73e-08dc8b26d8be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230034|376008|1800799018|82310400020|36860700007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUE3V1dkZWxUck1icE9tOUQwTmx0SWFpY0p3aDZHSWhYcjZaRjZOdTgzZ1pI?=
 =?utf-8?B?aGtTQm9pNzI4dkFiUnFkczl4T29SRFMxTDBJVUdXcXUxRVJ5R1dNY1ZTRG51?=
 =?utf-8?B?TXhlZWVJeTlqMWZ5MjU0a05zcVZwMjVmTzJ6a0ZNeW16Yjg3bUdNYkZFWi9I?=
 =?utf-8?B?TlhIS0RQaWo5OERTTzJSQURKTWRnNFRnOVRsUEpudEZ4d0p6VUdHOXhBOVUr?=
 =?utf-8?B?VVVCaXdJVSszU25zVVVNSFBUUG5jU0JxbTEyZU80TXhaWlFhZldnajZ4Y0hK?=
 =?utf-8?B?RktLSzBxSThMWWtScEdhVDBwek1kd25wTkJ0elRDa052TmpFSHE0ZFVVVkJq?=
 =?utf-8?B?OHA4NXlZeExxMzlaTVM2WWhZSndxWUluTHVJSzc4akRwejFuKy9YOTdiUW43?=
 =?utf-8?B?ODdrNkNJNTdBYTVFRjhVNlFlR3hpTVh4UmR1RHo0RldaZWJaYWg5TnVrSkI2?=
 =?utf-8?B?T3VJVXJsVE1NcHloTlRiN3F1ek5oSFRCZERiZWxqZEwwc2c1N1hHZzh3V2xt?=
 =?utf-8?B?ZHZ3RzIvcG5RTW9SUXdhSnlIS3ZRNWo4Yml2MjEzemFwdkVpeVordXlaWWpu?=
 =?utf-8?B?NEdmT0dmMm1JL0tuZlRaZklXZXRxNThSODNaeHhKWVV0TVZYMy9VWHBEa0R2?=
 =?utf-8?B?UjFvaG54bTVldXNad3kxdnYxUFIzVjMvd3k2UVQzeEQxektEYjZxcUtyMlZj?=
 =?utf-8?B?QUJnaFloZzZoQUpaMVp4OW95Q2VJQzFDeGdNV2I3ZzV2dEV3YVhCakhITVNm?=
 =?utf-8?B?dlVGRXVoa2VNWFhzTzkzaW83V1N2SDgxbjdLenp4eWp4NE1ibVlJK3p2R0FD?=
 =?utf-8?B?Q2tLbXBMUmR6eEdJY2prL3VnSU1wbUJhV0JjYVNIQUs4eEY4QjNkdHdBSks0?=
 =?utf-8?B?N2c5MkZtWDVScFhwN256a3Q2TjZZdEJsOHh4ZUFCeWF4Um1EZk45L0cwcmJ2?=
 =?utf-8?B?Y2RmMlYvZ0F1NEM2ZGp3SUhPVjNKdG9SVmtlNHdTVUhMdEtyd2xvRzZhemhW?=
 =?utf-8?B?KzZDYXk2TXBTTE9xZ1VCRWpLMHNqbkpnVG5pSUZuMjI0WVlMSWlUZGIvYk8r?=
 =?utf-8?B?Q3gwOUJybVc0QXVDOVFubVc5ZzFMREYrL0g2YkVuNVBJcWp1bnFsdXQxZTlw?=
 =?utf-8?B?MkhOT0ZCZnpTc1lQUEpDNGhvRVhHSitndWFtc1NSOUl3UVk0djJjN2hLQXA5?=
 =?utf-8?B?V3FYNEVQN09MTWE2OGdxYnVieVN2dkhZa0lmdnluSTM2NE5ZeXNOMkdhdjUw?=
 =?utf-8?B?cGRZdjdJTXhZMXpXQXVPc0VtSGtMeDNkdXIrMjNHWSs5bWhXTmtJY003V0Yr?=
 =?utf-8?B?Tnk5cTBOSGtRWUFSUkZhTzY4Z1NRZ0hheUFYNmRqWHFoQUtqZm51MGRIcVhQ?=
 =?utf-8?B?M3RJMHNreEczS0sva0kyOUMxcW9oT0E2V0krNmZyemY2VVZHVHpHZ3dJMWZI?=
 =?utf-8?B?Si9GZ2tsRXMwR2dPSWE2c3BjVE55LzI5RkplYjczSjRoUTU4Z2V4TWorZXhU?=
 =?utf-8?B?ZkVDWnIxdEx2bEFBRmdBV2ovMWM3bXBpUlZCcHhrZFo2NEdzbkpyZ3pRVkhM?=
 =?utf-8?B?cWVIUmEzVks2bVR1NHlrSk9OQ1ZEK1A2MzBlQ1lONGhvcVFQV2F6MVd5ZHhk?=
 =?utf-8?B?dDdKRTBZVCsyV3F6TEhidElkSjFhV0hSUlZEVTFkdkticHZmclk2NndMQmZF?=
 =?utf-8?B?T2JoMUxlZXVqMXRwakluTVppekJ5cWJPaFFxYzliWmRpNzlIL1NxclNrRHNE?=
 =?utf-8?B?TlZoUENCZDhYeFBqcER6YkdEeE42VFVSUVdSem91QnRHZ1BXMWRLQlhTTlFB?=
 =?utf-8?B?eDNtckZtNUNlSVhrOHBmc1lTbW95bDMrZHdTeWtPek0wMlZHUWgwbVZYY3pC?=
 =?utf-8?B?TkJIMGluWm1XSCtoZkVCZnlPNVVCNUJQdmFvajdjNERvaGc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 21:30:13.8043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ace430e1-71d8-4c30-c73e-08dc8b26d8be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8415
Received-SPF: permerror client-ip=2a01:111:f403:2416::601;
 envelope-from=stefano.stabellini@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/xen_arm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 15fa7dfa84..6fad829ede 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -125,6 +125,11 @@ static void xen_init_ram(MachineState *machine)
                                  GUEST_RAM1_BASE, ram_size[1]);
         memory_region_add_subregion(sysmem, GUEST_RAM1_BASE, &ram_hi);
     }
+
+    /* Setup support for grants.  */
+    memory_region_init_ram(&xen_grants, NULL, "xen.grants", block_len,
+                           &error_fatal);
+    memory_region_add_subregion(sysmem, XEN_GRANT_ADDR_OFF, &xen_grants);
 }
 
 void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
-- 
2.25.1


