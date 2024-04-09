Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4759DC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 11:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru9DV-0006WH-Mo; Tue, 09 Apr 2024 07:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ru9DK-0006Oo-81
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:00:30 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ru9DI-0003tJ-Hw
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:00:29 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4397uftX021855;
 Tue, 9 Apr 2024 04:00:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=q7E5NBxay3UF9V9Nz6wZyiAFunFOP1l2WzZxCxnAc
 CQ=; b=Jzy/mONAyO1qT0uue/mPLahEy3i569Uc52CiSff8udHdM7snJcDBHMWHf
 FEcCxsilY5t7hsZrqjoRE54FLLsVZXf+KtQdMm1N7Tr0ceocjdOazNnIV9Ia4rS3
 go8Q7f7rTG5ZQ19wDKP+49Qf+cEFBlZP+wJQFqXwR0H4EvTcRgC/aE66hKm+enMa
 kh9KOMtstmxcBzzHPJx8MCFGi4hNXrGn6rwYKLuOMGIgAviwP7Wtp0FjJYEXv6qP
 EkDsCRukHoojJIxQrU4Ldbxp/N8dtVvkDneyxh0gtOMxrKoHet2SWKcp2rvygdyu
 NsX2eoE4Ewabg9VUhjbjaKf3NcHKQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3xd1qt87qy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 04:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKDbaDoov5KWS5UXpwM42eB/o+OzwHDes9hv0GQVBzN4drKOGsRF7XhG45aEacgJiCQonzQBPhvaENgmh77H8F4kqt9KUPFVXc9fOupKySieeh6mmTu1B6RtSkQTrczYIcrLEsMwpF2RrWD12JIknjrtG3OpLg0aqH0HlvCrF5sCDpJ+uvMx1GO0YRf/2WZD8WMb9P67soxUWEeV7ngppkHi0a5GkjgXLNf7cPxeBuml61M/1AQji4uOrmCTVt1lFs+t2fKHhcPM0DbU+yJaRAPp/CrNU067MrgGSpL+lp6WkoU7XbRY5+ZydqNvVF6F0Lla70bg+16yQfN1ngQPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7E5NBxay3UF9V9Nz6wZyiAFunFOP1l2WzZxCxnAcCQ=;
 b=OO8HptA6jzdokV9+4aLhbWSAPg75QvirX8HulyLRwwckEhoB9G1RTXslHDfiyMfgCKQk+BQWfZoc6iA2ctxIGDd67VaJYVTAiKlHnkm8Er8W8IbBBgnNLqcJlY0GNBp4cL3gWDqXcEfLidX8u79LVHLhtu5A/yw5bPJV5NFxMCUxnd3bkxnehIWfj9mRyygBH7pNGkZPAk4xhfagad0QiRqRujQKODospbLIM4WIkBLkUU8OBL19NtuBJdX11glJSco/Ku55drASA0KegtKb8a3ZZke9wSKcmnxh0ftPmsjtfi27AMwsWICMnSHOFCdfRIgNidrF5FaK5iuHC7cj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7E5NBxay3UF9V9Nz6wZyiAFunFOP1l2WzZxCxnAcCQ=;
 b=Oxj0dBbS2RI5jpc7VM0HwTrydZqn5veNu2VoIqa0Dsx9PMfY7MCa4nUr7brgzshe2Dgji4TgY0fkpeFOc2dF4h2HedAVRMjP0ChH87FZKCxn5dw8YcBYEkOYDiRrU3Nz4hwE81FutxdwvcN93qb0mzA8AEXBfuL0u+7XoSnOqOIjT6GxJ5p1fZxIH9LSi1BKCDlAj4emDhvWIEpClqSaa8seQuqySjVwO1GdzP4ahzanK8mHUKfgI45citMYXIgwxc9af7UnvHrEWGRFRHKL2GBmGcDqZfQd6LVZx91RHjTExPpGN4sUq1rVDavuM/A4mfaIVv5bndmnwtlRGgH8KA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CYYPR02MB9826.namprd02.prod.outlook.com (2603:10b6:930:c0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 11:00:23 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 11:00:23 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, farosas@suse.de, prerna.saxena@nutanix.com,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v2 3/3] fixup! tests/qtest/migration: Add multifd_tcp_plain
 test using list of channels instead of uri
Date: Tue,  9 Apr 2024 11:00:11 +0000
Message-Id: <20240409110011.174426-4-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240409110011.174426-1-het.gala@nutanix.com>
References: <20240409110011.174426-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::22) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CYYPR02MB9826:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X40yX2ZC61qJnefKNE6h5SIno4EcgIdiLfeyzJaCTJY2P2MwU6wHseWq7V1kaM5q5iV0iGS2HM1qfwP5jfU7hk9Imo5iyNcMyFHePisIKZCJ1dp7NRg7ZIF8QJ6MOY8GX0fhCau8baXC9MHeOr82RDBNteqxZTQRBiKJR0kXzIBs+8ihgOnEKq7DfBHz6yCG8LxL2/sd8kbu9EwsF5VDpO4ppnAgseQ25x9PqP6Svxc+MHzx/LSaxnalItGYciBO0mPbhfTERLj9I71IOCrJi3/uPocncaLDXNS2tsxwJiFtSjQgtuJL67P+RFuVKPaOO5AyuS6pVa0Livomkym/vuuzV/Qjg2+Hg+O1Ix8APTOZHv7HXP1btBAAxws9SEQUwPDgr3DaG9kivXwzJ8x3xlC+lalpj97FK+CeMvZ0c/WjAja7kLXlDsyzjrK9QUkjcYEVjA32058nKWMbO0FxDSSvhdGy7sml+/HEYNF8EJJeZtdOGcxvWbkDLI43jpt/i4164F1WbEoPdTvHWAiEzq4KgsZSaw5FNtX5qvNQuXCEBtahpQZV4cAmuVUKbXpFel5hty6O0mynMxRsDnzwqVCoP+rvO82PI4eqAjTiG76qqCNu9Bvi8mF6JBa2g6x7yYzND1hGoxEZuQ9ToT+6M6haf6HZVnmO3rwkJk6W/XYBG2Cb/8QFzi1qTMZWyhVCkaLT2gF/3PjThFd7vvohxl5+dGOLWRsGV49oW7yxPRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1XV6Iq64z492+ZZlR20oF8Bq6Ccfhvddvu6pzXDVgIDOcVgxbxSPy1L1J2Y+?=
 =?us-ascii?Q?HIiffTwgFRB9ZAYTXaIwuUIXAxG7B0B5TH5DqdWVVyugKRCDK4NM9HNsSOwq?=
 =?us-ascii?Q?zn9KXVdyiWCfBEfN8WTU8RpXG+MIcnEnEdVbqkl0rnMwaG8NWZEWLmRCAhRa?=
 =?us-ascii?Q?jdqkW3Q2CcAfXtE9iWpIpVi2M8smxMcgCU/zVm46Kaw1zyl/GCoSespF0CeM?=
 =?us-ascii?Q?d1pInjTJU1J4Zdc9LFcX9ra2qtKNPHDm1D3ur/9F+KcHlOTMowLW4XbcEuHr?=
 =?us-ascii?Q?bJoPR1s50nraneF1O9+dwllEtTwzU2VeGaTuvJrAW6sQ2kAIueoKGf3H8ByL?=
 =?us-ascii?Q?6PF9V6sPcixKIa210WiQeFfshpd0xIbeIiF6u71fdbYcecZ8OKAzdk6gHO7V?=
 =?us-ascii?Q?uiREZZAAHCP+8opYSYVDitiaBZOPVHap2Nba31qrVNl9eaSC9uMSnNFVz2cT?=
 =?us-ascii?Q?mf0l/gRAP+pSXC5YbQyoAQh0LR8H0/3pJSi2kWxcck6uuH+2lq9HCow7syue?=
 =?us-ascii?Q?ju2t859B8eWGbKjlxGlBQbBweZogOa1wjSMy/eldDyNJXwub6vnbVolSyB68?=
 =?us-ascii?Q?Ew/JhQ0wJaqPBBc5Mrw1JPzW/V05J/FP8Opw98GBYeKJNDq5tqDAsN0pV3pn?=
 =?us-ascii?Q?hfN1krZ5l0mPfmSZiVWvuzTNzsYirTPsOrrhCsSI8nrosl4r/PsxO8VaIQ15?=
 =?us-ascii?Q?Q1VWlcpG7FIHAP0g6ruLcICRq0Jf40uj6/uEMAyxgzTULai+iI2w1YeNSXFj?=
 =?us-ascii?Q?KUo5YecbuR7bb/j4JjcdewPsH/NOmnFykOvbolJ9u07kBjJ/7fLNXT1c51ua?=
 =?us-ascii?Q?U4ueiaFe/MO4vfkXsOkV3/ndRuTrqHoJGZimNaLZWYWhW5N5oF5aF7R1aGyM?=
 =?us-ascii?Q?CqGPMdjqmFVFtdpFU0LtFM6ZeScaOHp4CM2NXSSoB/Na0RDQX0dNLPO9+OsM?=
 =?us-ascii?Q?rnfePb6Pm2CB8MonmaKawf4yUQtXQe7yizcENbBHkXwl9+DYAWufM5Kj9oxw?=
 =?us-ascii?Q?7stihOs5vt9gZdcL6TvlIHF7HPvkGqmtfADkbxztp7ypoPkLbP070y86sEe4?=
 =?us-ascii?Q?Q72tq3VqMhaLT/69T55wbES8G2dYoU+u8Kq/dynvaH6wI9SWJ4mLT4Z/nJG6?=
 =?us-ascii?Q?rSTiy1hG//Kin+UrjeA7BwanhRZy89a/WYry4e6z+6d2qmADu0CTmNSLJkFy?=
 =?us-ascii?Q?WpfCuJUVeoy4+u/Ns7HSJTLpNGnYE+V9ki0ExueS1ReZzDXnfBw4zDPrXC7o?=
 =?us-ascii?Q?bufnCtJcOM4RqZaqo5KeB9kz+XvK+hLvFu7lGJOQAcB8fULL6oB9hXcn5dFF?=
 =?us-ascii?Q?hynuVZHIeA1p7+CHFm4pTLvi/FLyboRBIBbrqbCT+UsD7Idjbaxqc4OQTotL?=
 =?us-ascii?Q?MrC2Fg6CqEECtP2ScEXtyQKNUATHuKkGHhGuy+F74vFweAirS1fkMcF6kzsT?=
 =?us-ascii?Q?sjw/LYHjtsMWtIM99+0vNBsbUAg6VN7wPdTBBcAo9k0vtXAZ2fqVNPRXy+Gs?=
 =?us-ascii?Q?4Sb9p/C4YQMtWtCzkWZKzez1qT41eXHqUfpUvt/J7qEc5EgtzUIApNJ4xpp8?=
 =?us-ascii?Q?iC9XEzGU30e1g9czTPbF++ouDxp3lS/pHZ+wKMkG?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a71a8f-6f08-4aa4-f78e-08dc588440f8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 11:00:23.0311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsdEeuyojdpr5h9Ng07TnR/Qyn/n6Z4pR7ZARD3sC8APGS0b2evPefynLJDxI4VPv4+Oh6sJ1pPt4nCPyP7fWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9826
X-Proofpoint-ORIG-GUID: SKn8ckZfShgmTDwgqVaJm6kbNAsf22hz
X-Proofpoint-GUID: SKn8ckZfShgmTDwgqVaJm6kbNAsf22hz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_08,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 584d7c496f..5d6d8cd634 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1728,7 +1728,7 @@ static void test_precopy_common(MigrateCommon *args)
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
+    migrate_qmp(from, to, args->connect_uri, args->connect_channels, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
-- 
2.22.3


