Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB2FC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 05:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCBUA-0006QJ-7M; Wed, 29 May 2024 01:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>) id 1sCBU6-0006PT-KW
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:04:22 -0400
Received: from mail-mw2nam04on2066.outbound.protection.outlook.com
 ([40.107.101.66] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>) id 1sCBU3-0003Eq-AM
 for qemu-devel@nongnu.org; Wed, 29 May 2024 01:04:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dN8IYv1EzQQKadgjbUOjXnQcCCEnhMBXaw1GWWGRY2ReYOayg3DwS1rqosVqaZZ5QPCKRGsw6b7kOlofUxBagmoCJud0U6MpLs3e8n9t4oioeI9nDMknqOiqZrh//cq/wWSPKOcqqC030kqtQJPhCXIaYOPqBliSVACCARP897mfZ9YYmHmODMGj1GMWRN04iuCf/tVeVL6VR82+jj46ZwhQVdUEuIrRx9IpJBYP68INytwICfItrXT/CilLHSXA00PqqHDMCU8szQQJERFqzUeMBAyye4IRKYO59EBzxypE8O94ilFZqrPl/zSpEwIKcXoAxThELKW1fFudUlrZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqxO5HXHjVDJnllkAs2pm4vqlycSZGGcfqEYvBk3skg=;
 b=CQcxJi7S7usCbIYARrrfpSqGSSe9uq5htmaRnSfoznaZPO4QzDtDV7YBzzf3Op2/h3RGuFIFqDAtTyPKHgkbYGifzeqGvC91/C9lKNCF/zKUzueNBIWV/yo0KrjVHNmU/dp1wcL4UPMi6qEwGXblSVaFef9uW3enV/tnaMETwUd5u1VoOsb6B0i6Ql5ycLzKui5j8F8igE2iUkrs+IxTx5hvs/aVnlpJgCjYkk8qQdOX0xpZ9Hokq3DNJ0KzcUJZY3Fj1GhPi/Ag+v2d1qLGVqUqo79vAePbZ7pYPRQFsDMYSqm73IFOx1eXFLcNBkjgPZZR7PE32heBrEzBZt6Vtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqxO5HXHjVDJnllkAs2pm4vqlycSZGGcfqEYvBk3skg=;
 b=leFrUgy7F660R9Abg3XCZY0aDstSf0rQz3uXM92xKskhsq/gG+wr31m4NBt7xQyaErX8tHklrA/JqG5C355zQp2l+od8qQ6xbYbkK+gBRndTqaK9Yap9SkMDruDLFcyvcPCT61RSmcW9iMXRx2ilU4R98vr/nzE7khrTW02/QYY=
Received: from BN8PR03CA0007.namprd03.prod.outlook.com (2603:10b6:408:94::20)
 by BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Wed, 29 May
 2024 04:59:11 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:94:cafe::a5) by BN8PR03CA0007.outlook.office365.com
 (2603:10b6:408:94::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 04:59:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7656.0 via Frontend Transport; Wed, 29 May 2024 04:59:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 23:59:10 -0500
Received: from xsjtongh40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 28 May 2024 23:59:10 -0500
From: Tong Ho <tong.ho@amd.com>
To: <qemu-devel@nongnu.org>
CC: <tong.ho@amd.com>
Subject: [PATCH] qemu/bitops.h: Locate changed bits
Date: Tue, 28 May 2024 21:59:09 -0700
Message-ID: <20240529045909.1796787-1-tong.ho@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: tong.ho@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|BL1PR12MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: 202766dd-519f-47a7-5b9a-08dc7f9c1417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dEWWD98sPBoCGUG1ZMrTDoVgDSN9Msj1nGDpu1LN9Vwz+SGbsI2uSXJJRedx?=
 =?us-ascii?Q?h+WcqaW7a3ImarNcqZ8XgkP16Jv+QWwoL66UehTHNjZcvS3iykjkD7ADJTzw?=
 =?us-ascii?Q?G5j8opPdehc1GrjcDaiD/nzbky0XGztLfysFtlic6kMJyEoycLgfSkx8bQJ9?=
 =?us-ascii?Q?xKQfBXJGBFW3c4xGWbG/sZ0E+/7dyewBtxdv9/8Q2jhippWLQJWUJs8re9PK?=
 =?us-ascii?Q?4UVwIho0T9YBrd6NQ4FcVtOaC7gm4MX7gJg/p2j0coxOnF0zYwe5BUJNTHi2?=
 =?us-ascii?Q?19LAoz8OCsgWxrYOaBJMXPWt4pUfGaTAdRFGFkv03sfXy/In9mxDkl2cuyhY?=
 =?us-ascii?Q?JND40IOGVjgOYDeLWCee/Tcmpzs6fC1aHyKovsM9YTgiL0/cWeyUIuedYxS2?=
 =?us-ascii?Q?lC+ASJrn6Q2FxMEce3M8Ph5wFQSVxcc6/qZBxrP9MoMvd/GGy2oCmfgjT5BQ?=
 =?us-ascii?Q?3xfgezyhtD5BlMXMkspMVn24XHviL/xh+NF2EqUvU/KpZXnWaJRy9ZTAbjH5?=
 =?us-ascii?Q?T5XR0b8B9l8TF2rIzajJZOgQ/GYVZlasmlNk2Z3kqrxlbZyCRxxsH9cQJ771?=
 =?us-ascii?Q?L5w4YB8aG34fRkkZdhGa/Sj34r3hOzZul1qyVS6M5yEWF+Gq1RgAdSN9RSG5?=
 =?us-ascii?Q?miqgi7vozwKlg5wcFOvuPUpwzJWZShfot+zkFr9oIN+tGZLl4YW/tZrJU+Cn?=
 =?us-ascii?Q?NJngbCF576R2sFxkiEG4t8FG5aaO1tPVlTuzvf09uqcDgacnuwXKVEhfoRww?=
 =?us-ascii?Q?vpZ+TzAFYj/H1ABvJJ6+0hd5xjtuNB5uPnRvqS96oL6Bilenag6/0D6rVNH3?=
 =?us-ascii?Q?ftpfnPF6TuAf2q2DnorSshZGrR53boDdGf9OFOK5GQ4Bdl7Fmg6BnA5wB47D?=
 =?us-ascii?Q?I/9czSh5+lnTrJe9j8lwmFQe/wTH91g45YIZ2eu9+tKFNcWNA/JTU2q6t7nL?=
 =?us-ascii?Q?ncG09Jn0iu70+Ogwg5BTix6Je/wBf6lMW82QRpLNJUzumF8FwJIfGHoSoy7F?=
 =?us-ascii?Q?qKCnTPOANjA4mYqQw8KaxXndk9W4UVxYU3s/lruQyjHPJtlaJDcb+7MhEuzO?=
 =?us-ascii?Q?D0Ld5FbiWN7nATi74mV7qLrr3nK6m/8XHVPPEVloB58Hz9i71Nfn9I2TGy/0?=
 =?us-ascii?Q?L4YnxJbVgH4yITc8BaQ31vo5SnJ7ar7S8aCKIq6myX0suwsVx7cvckQTbuny?=
 =?us-ascii?Q?WeIoN4W1jB72XL/nWpbUZoBVhk7AleQATz0nkpbUR0W/uXmpfs4Wv6WhrR4A?=
 =?us-ascii?Q?HvkU0OqggvJ6LHGZK77BKlW+PBGq4jNqzo8NYbsQHPObbyg6TpKdMo7edxz/?=
 =?us-ascii?Q?BTlOkOBUeTMvJ9oaNou5UiI8PGKxHZA6rEHly9FuWOa+27JLnkgiXgnPBz1G?=
 =?us-ascii?Q?1GR+aa0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 04:59:10.7999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 202766dd-519f-47a7-5b9a-08dc7f9c1417
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828
Received-SPF: permerror client-ip=40.107.101.66; envelope-from=tong.ho@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add inlined functions to obtain a mask of changed bits.  3 flavors
are added: toggled, changed to 1, changed to 0.

These newly added utilities aid common device behaviors where
actions are taken only when a register's bit(s) are changed.

Signed-off-by: Tong Ho <tong.ho@amd.com>
---
 include/qemu/bitops.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index 2c0a2fe751..7a701474ea 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -148,6 +148,39 @@ static inline int test_bit(long nr, const unsigned long *addr)
     return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
 }
 
+/**
+ * find_bits_changed - Returns a mask of bits changed.
+ * @ref_bits: the reference bits against which the test is made.
+ * @chk_bits: the bits to be checked.
+ */
+static inline unsigned long find_bits_changed(unsigned long ref_bits,
+                                              unsigned long chk_bits)
+{
+    return ref_bits ^ chk_bits;
+}
+
+/**
+ * find_bits_to_1 - Returns a mask of bits changed from 0 to 1.
+ * @ref_bits: the reference bits against which the test is made.
+ * @chk_bits: the bits to be checked.
+ */
+static inline unsigned long find_bits_to_1(unsigned long ref_bits,
+                                           unsigned long chk_bits)
+{
+    return find_bits_changed(ref_bits, chk_bits) & chk_bits;
+}
+
+/**
+ * find_bits_to_0 - Returns a mask of bits changed from 1 to 0.
+ * @ref_bits: the reference bits against which the test is made.
+ * @chk_bits: the bits to be checked.
+ */
+static inline unsigned long find_bits_to_0(unsigned long ref_bits,
+                                           unsigned long chk_bits)
+{
+    return find_bits_to_1(chk_bits, ref_bits);
+}
+
 /**
  * find_last_bit - find the last set bit in a memory region
  * @addr: The address to start the search at
-- 
2.25.1


