Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C63DCD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 11:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruVvw-0007XN-BK; Wed, 10 Apr 2024 07:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruVvt-0007Tt-3D
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:16:01 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruVvo-00019N-5g
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:16:00 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 439H5sJm016731;
 Wed, 10 Apr 2024 04:15:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=i319eQzVrMzWZgGm44SUMcldzNGFG5MMhuQv8ox8G
 uw=; b=fRTx92ZTt7HMDHxNicdZnu9mnYmovEjv/mPv2t1D537iV3y6s4Li/kCDe
 WhKpUxTXPxx/T3eVU2zjr+n/zMHiZDDSq6Xtt+XAjmaUioxgY4K7mV831zwsGHSH
 FRiwrYsOBx3P9ltvXCIjeFNVArt7YrGGmELq5XICei8nXsmckBO27DxdTvwef1Rr
 wgnH61KdZpX438Npn1woobvgRE9UvYhoML+d9ymlE+VMz+id0hB+4YTgIzowpIU6
 mfqkH2xUauTIKjvgG7zRKY6VDRv27LHslaG//YZXAj9wFXv//OgERfpuRJX26+nR
 0zjnL+n2jRx3yizkFRawBveObvIsg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3xct2k33fn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Apr 2024 04:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ba+DWqZ2DFPJiFkKoo+wZByr5R3xoHRtVgK97lbjjNM4qNhwkQzhIQtTrlRcjNjCUGDk7DecJkMSg+y0HEMqTRjCcYOrLDkGZxGggENFPb7ziy57QGzIagnbkBLjrourhEnL6G7B4yndLTzuGq5Iu3qy6O7J2MThRIotMcUwjZyuBmchMJyFcNvbKHcwJZnqsWo605yAHaYuGfCCFoSYpotJwRUga/Yfw1SiEmaFV2tX70vf2NZVXadWqs/yyxSvxmZepuroX/pQ0d0SUgk8/nQ1IhJEIRn4Tu6NEPzvjs0Uw+q4f9acGh5+t7C8IZ8SDiIoO0eshXvgl5zp5vAntw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i319eQzVrMzWZgGm44SUMcldzNGFG5MMhuQv8ox8Guw=;
 b=J9tgENLSgIaZUMY/svwzfcxjh8TMTkCrCh0tvuPzBwQqKEEIgRogo4pmL7n/S5SQx1aKQ87GzzZgnHUFl16Fk9uEYq9K/BWY97rqDIS+R+UKa739MnI3q8Im4peTYtATXM/iilA4Uzzl9JwBo4DwvO0UQhgD5MTw1GN8EPBYKnee45fYzH9I+HdKSayPlRJ8IhcKyWjnG3+1RRElNHyBlxBxrSlVhBFYUuMm9K+aY9bmJnpqcJ8NHz1wcatmURtQiyBD0NDuZRTusuBFkBWz29AX2opuc8SEt3vlJZBIr/jnICltSO/dv0o3X56RRkozLiwemwQ5bxjmcsHV+DpHnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i319eQzVrMzWZgGm44SUMcldzNGFG5MMhuQv8ox8Guw=;
 b=gyxSK2mzkYmKPEthZ+ke/Iv8gZta+R0Wfreww9c+wYf73Cerq9O9vMHgJ73LcvTbz1BMND/FXNMSgUKTGW/iMOuR7OVkAS8QHkOk2b1o3LiXgAelzkux1EFsH/89KO5fHn77k7XGPzpquAyeuZEgCULaGx3HNcofeGKLk9pfTK5l4b4Wj5Y+OI7FbUEGhzPLYMKa29MJfyxWDfyJ394/R3dCmZAypyafMxf/MzVLsDWb/HYIhMZfnu1IdJ56MmEfpaa483XZIAsKGeCtcVaI3UGLmp/hEPT/D+jqfhdTBSv6v6oXzV/C8qBELC+ae/1Ddr0phzKV/zqi3LVqlFgokA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH2PR02MB6791.namprd02.prod.outlook.com (2603:10b6:610:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 11:15:52 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 11:15:52 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, farosas@suse.de, prerna.saxena@nutanix.com,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH 2/4] tests/qtest/migration: Replace 'migrate-incoming'
 qtest_qmp_assert_success with migrate_incoming_qmp
Date: Wed, 10 Apr 2024 11:15:39 +0000
Message-Id: <20240410111541.188504-3-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240410111541.188504-1-het.gala@nutanix.com>
References: <20240410111541.188504-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0016.namprd07.prod.outlook.com
 (2603:10b6:510:5::21) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH2PR02MB6791:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z75nrkwnB9DDL1d7ifCnaId1UtIurbqSlGysXiBN4I7q7YY7BVU9aAqHyPh5QgWUHRKgjtBX8kPPvC4DOcsWM+3wlUhZ2sj792jQuipL8FGKNAo9d9SlH+wp+K6qDY7AxjqNn++mFEOSAtb+T2xBXUz8xWrewO5rIFbIUFB8WJH4bTSL1dbpf61x+B1t5ZGnRhWDtb6C5/vbw30WuUAGWDoT9wX6xBkVqrRp+eX1TwIWzFZP2Gpzn2GYjQoRjd61Ru2eWnf904eeCOEDDUy8JwQBbtvm2YQtgOXNx6V8BaHgVTC5BmvmRVeX6w3jXpkwTsdubyxGCvNoOoX5F1Zna0sFqyBWzyx/YAhOvCkKQqCV3A4onLm7n5jlW4MXheK7APhrn3c25nLz2LQZjL2xZK33MSELgwSReEYc8T4rLamMDcw26C0PyrPgvxrSHpi2H7Wu/h3iYLNWq+x/U9EpKR4sIKfRWJSyZqLOSxScNSSDBdOat9GIg4nFQVCa4nH4ZpMAIyNMmjUPl12W/5JqXP156dniKxmQyDPNQiaKsoBJPY8G7NbjBElVL/JN6J00bfx7SD79aUmeCjhqjSJ4EZZ7EWeLq//1lo+UCAXmVExx5HyB4cbxySJXU9dOHkYVepez7M9zVDNMDZvb4AgCCqfbNSZrcxnKXsySwkOirIim5F3POIMvYq41mkT0muguYNnpS9Z4NSipA7xG2ThijUCbrQrJXM6xSg9beGjKXXk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kkXJ1+/cp7ESUBkr6/70bCrJjNmA+h8E37JhVboneboUVZDg9LDhMPy9F9U0?=
 =?us-ascii?Q?wMGt7vO5Roec9uvHNcgO3d6aWMS25bfmVmPbGRoTBaooU71KaiPM2WANPy+L?=
 =?us-ascii?Q?W6Xng0aizu2CbsSbYKXyWx2HlSjupWNpygNeIB3kV5HMFv0StIgebC7YD4Ea?=
 =?us-ascii?Q?wKDFMZxgJerlbYrcemqAUl2Cap6myoBzlR6FC4sR1l6r9IVwqnH+CIIxy8P1?=
 =?us-ascii?Q?AWRNA/h2tK8fcmAnt7eh6izcpGKXlTW0iL0xlRZCm3MOxvx9X7enjcAbUeD/?=
 =?us-ascii?Q?l+gDAQglTkAIigZ7QKwPO/2ebJ9G0eHxY/YAMAt/LnaqIrzH5Fftrv3Hpamp?=
 =?us-ascii?Q?H877mJVKm7zPWStCNIDVmuFBuiegMUCn6DGwtQ5kOXyI1B2AyFl2pXDmbcmc?=
 =?us-ascii?Q?HZXDSiHfyLGm9Jn26BTPbfY7D91mKB8PYT/d5qDM0l1bwQypvnY0DocBZHQ3?=
 =?us-ascii?Q?xPZYZrzD5M8X8BHW/d2XvrpgoGUw62xuEduRCcdMNhuPPPZuDWaQ9IGCh4XT?=
 =?us-ascii?Q?qx6dNroQYQX/+zMNrwFIj6UXjbLTGcv6E9Da1fwjGNpjykCk5hkfjAUlAMQk?=
 =?us-ascii?Q?x/Y0Eobu8nyyaZafvHD6TAG0MT4ZNI2Gh3zL9faqdq5FwLN5T7uUF33Xc5O3?=
 =?us-ascii?Q?EZ13UeI0JWJ1cavvb08awdJcPjL3Fd/TyunN70ThOITt6LgTbxJ9XmnzuEm8?=
 =?us-ascii?Q?2r6NHlD+ob8jrtir0reHf8PJ0xvfoUcZNEkDGsauPD18xQH1KoubBNR3iuTY?=
 =?us-ascii?Q?PwtZ3k7f2a7zowpiBVzsqHa197Y2qbOPyiDNOWs2ZRwSNf19YpG5kmBwC1ts?=
 =?us-ascii?Q?Vjo144BoVQXrSYp3OWpkVz+qk7aMSfnuABRfaZCsO2Fx/sfgyY7IU1v5k771?=
 =?us-ascii?Q?JrDidzRVjE2R9v+O8+HfBR6MLxZfrPWG0y+Y8AI3IGuQsNk0IRV6qeQ3keyG?=
 =?us-ascii?Q?bACnvWTKNOwzeAlalGAOqR/fi2n5VeRVLH9aMPpq/JYsWSbr+5/eQRXiF8Fn?=
 =?us-ascii?Q?wlNE2j63zkyDl7ZSOZd56Ay0FmjQbjbV1XmfrZ1HS0a9JrOwEdtXZ61BbabY?=
 =?us-ascii?Q?BLx4ld83sLfAFbDBxM9dOXxi0/Kl07xDVA5ZfNnjpilZLcVR9qUUsFfYH6UI?=
 =?us-ascii?Q?Pef+D8e9Q0E30YVThPGI1tZW1QC5m+67u0/It1y7FaJN/JMyboiRieY0TRDg?=
 =?us-ascii?Q?9T5I2/dT9B38OqbLzR3QHIpiA7qkYnk0XPFGspwQfaOr76KW1DltvKzOeTHJ?=
 =?us-ascii?Q?ZTxaBggOxBCk5gGYRgXOF/T3zCUGhnRfhdC0CdF9hbru2MZ/I84Yy8Vo2r/G?=
 =?us-ascii?Q?wPI0jkIEvntFsvPv4+GldB21DiXKUlz/p4DHl9xNzplgRQ7nBduNgTilX5N8?=
 =?us-ascii?Q?Gd2hUhhZp3dQsiWrkAL8O69/HTX+fcq9/TdT7Xe/ZnxcuZcZi7Z5sN/slr13?=
 =?us-ascii?Q?/tVxaAnKnTQF/bzzfbigu7NXFJzr0NuUdJUtap6/jv3CzFopTlEjp+dI4+y5?=
 =?us-ascii?Q?vozsuGPFMCC0ExsigxNz3woVtKcTtwZHj2a2ly3g5JS929Ys15Nc1wwj78oJ?=
 =?us-ascii?Q?mlT4rRfJ/xq/9QEfN9dHnfwZ4avhQ+r1vRSVbDFD?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a1f9d7-8bab-45fa-2638-08dc594f956f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 11:15:52.5639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1W6jDnfiNSaRpZtZ8flDEx5bebknR0pJZLCN6F7gGlGoZ3abcksKTkmsof6RrP4BxY78zgPtX2U2GSola2JSJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6791
X-Proofpoint-GUID: idOI-0jltp-Xk1deT2I6d8aedo1GO8R0
X-Proofpoint-ORIG-GUID: idOI-0jltp-Xk1deT2I6d8aedo1GO8R0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

Already have a migrate_incoming_qmp helper function to initiate
'migrate-incoming' QMP command with some additional checks.
Replace 'migrate-incoming' qtest_qmp_assert_success command with
calling migrate_incoming_qmp helper function for postcopy qtests.

Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 27a1066ae4..f2c27d611c 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1296,8 +1296,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     migrate_ensure_non_converge(from);
 
     migrate_prepare_for_dirty_mem(from);
-    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
-- 
2.22.3


