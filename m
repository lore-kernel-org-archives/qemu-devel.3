Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52005C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 22:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf62n-00052b-Mh; Tue, 27 Feb 2024 17:35:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rf62m-00052B-IC
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:35:24 -0500
Received: from mail-dm6nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2415::601]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rf62k-0002ef-Rk
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 17:35:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+wvoNjvHGV6H4AXYaKQcu5+HXvA/qX04A7HgEiw8Ee1G3W1xTPqU9uGvNJAjgdBwrMwhgC0v1cSHNelFOmlQgVrK2V8J//HnMQkb9ZLHUKnfqVlEA+r39CaCTEIfJdPs0G+1oDpNHlyzLIOzSQcA7QgdI0dNgfQzVe/CIdRPoKiJXZKAPLBYPoTucJ0YwRqjbBeYku4YfTLVs4vxFw85ybrYsOr/GrelOVm70hu05RdBteKot7Ys6QJG2y4KSF7jIFRTwYi/391JRhn8+exQYDf0PGv/ohrHKqqgawWPlWeMtqm+6Yp+h7+g6ggJlhvz7DbrLdkSaTZoYG/FRZ1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OZlucp+PoJdXp0H7/yZMTJ3c3snBOa8bo8Wnac6SL0=;
 b=aSZg+KfQynp/yG5GSBkWOE3vSOROC10yCZ/0LKp/HhoiZvSe3s7b8wSk7onKSGISECBVXBW+YFhTANBLWFVmKyDW+dqUd2Uxo3ZIPohC9NVUUQHlBq1PNYhJHDL4+ImcgLnv+Y5CbMtmd9L3zC0qmj4Umqw7de8Ee5oLYDrgibEWzSDTbi9sjMFt0uKd+qh52gSuDpogCvMRL/XMEiaP7UzyTGHjuCIg/1OrkKMXgn6Z0hzOtEKBHKAmK2N1D7m+CC4RuiK9aABTTyRIVYBYRMF6imTKM08RCDIozrSzoqKhx1cPWkpV51jlrX7szVLHZpshuNHQywKxvApbR0D3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OZlucp+PoJdXp0H7/yZMTJ3c3snBOa8bo8Wnac6SL0=;
 b=0k4dvU1NkQs9St7CQukJZRnyMZHs+mx8khDu3pNBnV1RVyNznnuwMmS/1J50ds7aa+/xzEDUcRrBbHno7F3DjOmVETfUpj9W5hxHO+8pa14et1iuSq8Q/d9pMvUFPi/Wd1gekkhYyU5+vx9bQt1XRDxKFWqHbNNRAnjztShBpzE=
Received: from DS7PR05CA0050.namprd05.prod.outlook.com (2603:10b6:8:2f::9) by
 DM4PR12MB5085.namprd12.prod.outlook.com (2603:10b6:5:388::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Tue, 27 Feb 2024 22:35:19 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::7f) by DS7PR05CA0050.outlook.office365.com
 (2603:10b6:8:2f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.26 via Frontend
 Transport; Tue, 27 Feb 2024 22:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 22:35:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 27 Feb
 2024 16:35:09 -0600
Received: from xsjfnuv50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 27 Feb 2024 16:35:09 -0600
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: <qemu-devel@nongnu.org>
CC: <sstabellini@kernel.org>, <vikram.garhwal@amd.com>, <jgross@suse.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: [QEMU][PATCH v3 4/7] xen: let xen_ram_addr_from_mapcache() return -1
 in case of not found entry
Date: Tue, 27 Feb 2024 14:34:58 -0800
Message-ID: <20240227223501.28475-5-vikram.garhwal@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240227223501.28475-1-vikram.garhwal@amd.com>
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: vikram.garhwal@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DM4PR12MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: f800fa24-9cb5-4900-4018-08dc37e460c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttUogOJd0iTIkqEQCd/nzbRBJYmOmeXxMNF3sPtwOTMiZB2RJ1iFEO5+Y4HxhBup+iPRbYAveHsIyKzCtkzLEuq8CReCndcXSrYV6xXSoNReTT01XTwawYlGO0/HEFwp6YTpMI7qFUuZO87nVn95QlBH5KwYehdA6b4Y4TH7oU0efT0gu1A8YyBj5PhM4MG3+pVjqYDouXJj+vzsOUwIt4R8fWyy++0QyEzDn8WkYDB4MQx4O+Jcz4cPsjuXwF1vbN1n8x0Kp++ULGQEoy+e5upFQxfLiuDJMKTAFyGbwnLbp5BbJh/gujrOFqLDTKRrk4Z9TCCp/SA6mArFcP4w9kzDiRLyW0Q2KXaOAmvyzbiasAkzdvHH64T2P4oNPXAG+D2eICaTUtji5o7b1YuaO35oBkFWL/Jeoiw9a2+jaYywe7houWkbOaf8XTPD+bTsreb35Go/mcAPpOGMc13uK7XeTx7TGNHanDj8JO656LmMFZNoQ4cMrqKqFSh4hw/YKigI2kJjmKqQcj5HMOdTacBbBI/Hw3CId9CVO0tn2/5smT1AXjnzrZQa/e4DxSAiPSI62Xr2bHQJYAsmw3ZeVwr4RZ8T3GW7VNAOPnZe/VMS8Ae9I7roiPU9Z+EWk4PEwpSOEOoe81ZQ0hrd9EIWiEV51e/h8PFG4LuSdE+T7q9p1hGABHhfaoWSv2MBrr7CTDFdjE6OyVPhzC74G3htX8EUIbE2pOD1i+Gzy75p0tNLQTLyMTd7540SqUw8MlaK
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 22:35:19.4088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f800fa24-9cb5-4900-4018-08dc37e460c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5085
Received-SPF: softfail client-ip=2a01:111:f403:2415::601;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

From: Juergen Gross <jgross@suse.com>

Today xen_ram_addr_from_mapcache() will either abort() or return 0 in
case it can't find a matching entry for a pointer value. Both cases
are bad, so change that to return an invalid address instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen-mapcache.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index dfc412d138..179b7e95b2 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -396,13 +396,8 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
         }
     }
     if (!found) {
-        trace_xen_ram_addr_from_mapcache_not_found(ptr);
-        QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
-            trace_xen_ram_addr_from_mapcache_found(reventry->paddr_index,
-                                                   reventry->vaddr_req);
-        }
-        abort();
-        return 0;
+        mapcache_unlock();
+        return RAM_ADDR_INVALID;
     }
 
     entry = &mapcache->entry[paddr_index % mapcache->nr_buckets];
@@ -411,7 +406,7 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
     }
     if (!entry) {
         trace_xen_ram_addr_from_mapcache_not_in_cache(ptr);
-        raddr = 0;
+        raddr = RAM_ADDR_INVALID;
     } else {
         raddr = (reventry->paddr_index << MCACHE_BUCKET_SHIFT) +
              ((unsigned long) ptr - (unsigned long) entry->vaddr_base);
-- 
2.17.1


