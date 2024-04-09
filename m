Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E79CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 11:00:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru9DK-0006Oy-Gv; Tue, 09 Apr 2024 07:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ru9DI-0006OR-Vm
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:00:29 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ru9DE-0003r0-43
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:00:25 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4393VrWL009211;
 Tue, 9 Apr 2024 04:00:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=wTtLGiQ9X8bULbDgfxVDjY65nNUFDTlW27sczzX+H
 kg=; b=j72+/T/gIZRKua+R3eBP6OOYGDXUw5UPRTG1rDYpnlkPpeGtK7M1ut9Rs
 NWYKmqASfH3jhJC3BaGWbXaSV8xuxLjWxCgr4vOgApyqE/DGZKW4E4BxnQLetxNf
 SEYIemDksKcuse2YB0h4jQl8yQlI7xAH61gCRNICCRli+va3ro61WqKh2nyyfrT9
 defrRe4GcrAtKbaDvmHVjF6+a1QW40CWZoYA/cNwCZtyzs0IOFgryQAlF+zbzDGz
 RUjCg1FFQmt6CO+UZzHZXt/kqX6qRuLVIL+7F4FAhm7HoIFUrntmYhGiWBWV3Csh
 /S89LCf78CXVblf2D4st8xROaL1Bw==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3xcwua0mm6-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Apr 2024 04:00:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5nJ0KIS2V3K9TyErSF32I6yXN0s/WxyNgIYj6K5bPDCK0JxVJxB0qRKmozMO3UQSZg1RRPq5p069DIHNQ5aze4b+G2wxRom/3BeYo6qbDhuMENhculsxVs1aKYwiwWIbAFpYs7QuHC2+UUQp/eZGrYefYKS1hZDdMG4u/s0khV5jHOQcTe/IL6JPaD3JQH3Ht0Wt0ZZ/EwMOJCZGcW0avYfz8WKmeHtGvmFIxVQG1usrj+ORhiumV/AZGPHoB4yw/mRcTT4MPP3tIMzF1KRr0mTV2iWtGhLa3fMotoXO1jGhYUEALeFP2kpr9udbQRsEyfZaLJqP5wIKGLHT7dBfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTtLGiQ9X8bULbDgfxVDjY65nNUFDTlW27sczzX+Hkg=;
 b=CnJ+NG0doePYjRH8m4hF+UykriLj1JMi0ipOWWvs+lXAzwVxy7LfVEJiMk0MigWvYKF4E9UChOZrBpKUscLnjpzHe5vu3DJp4XoHzz1f+4o9Kuzrk4yiOExjGW8NqQsFhk74qaDmgtb21pFh/vZsbYkPdHCaaL1WioVCQf9+kQJQAP2v0LS7Idmw9A8kVU0ijgMBWT6JhYUKn3B5r3A/uernoXJ1/Dy3UhU4u9sv8p3Nuxe2JhRV5qmP99uW4m7EnqA0cAAu5ja+DG4xCH6Cmwh0CHoiP5Giq7O/E0EMnjaueYmWM8OskYb3UHTyjpUwQYxdiIAy4R7FtITzaiNSWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTtLGiQ9X8bULbDgfxVDjY65nNUFDTlW27sczzX+Hkg=;
 b=s7y+UrNhEptzQKIomZoxU0CeYi60A9qqmVkNuTWWAZuaubdnErlIlXqWqhWQl+9uAzJPtahYP8JH/oB6bg5tS1Qjueg8jFSKi4QSYoFv26fzPSUfcPDN3IID36yG5Y41YHbiMzQAEQUzXMK7K62NyYQoj482FHATHvKx496HJ2Ts3WvxuKQh0XbKYKfgg88Vz2f+vFQ0r6BieV++tqoshrk3q5TA2lbEGx+KwWZH366ZH6xZhMM7zMkH6vBGt1fm4KVOkhmr6Y75q4H8UEV98GBiDfHr0yJPD1N06Tn6tBYZv28C92KjZpYnib7MN4nFhL4fd9V7vK5g6456P3BSgg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CYYPR02MB9826.namprd02.prod.outlook.com (2603:10b6:930:c0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 11:00:20 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 11:00:20 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, farosas@suse.de, prerna.saxena@nutanix.com,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v2 1/3] fixup! tests/qtest/migration: Add negative tests to
 validate migration QAPIs
Date: Tue,  9 Apr 2024 11:00:09 +0000
Message-Id: <20240409110011.174426-2-het.gala@nutanix.com>
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
X-Microsoft-Antispam-Message-Info: OAWzV0Gh31PxiXVp/PoDPj79L/P3r/jLh//j8VY/OVF7UJiPT6DdS80mgJ1//iiCLEyfYKbOvX0cJFt1dAYo5sMFRRGOX++w1Lktrs+LZiSTn0rPaPPvSjeoP/L9zRWoW26tD2Wk+9nIJMLHJt2swakLexiFIHQIqg+HEHk4H1fkABER2h6D6cqE0/FAK8Tltf7m1CPCzVXwCesFUNqoor2l/a+971A5MslbXyQIXz9414WmCgkO4Ol9cYN65C4vX/VYRM5ItIw0ToDgjSb06k2gTHAgs9XA9l/eMjz7vS3q+x0bLciMlXz085NiUnFfMJDgTluX0k82JuPEIlQwUgTfbt5N6i8WXuII1AkwVKupqQmrMVk/bXcKKUBwC3R0QMbPRuYANglcVOkgIIyn42Pm04jO31RRglf2nOO1uEdl4OnIps40AhOfOuKYpvPDrAq62FHa0pNbliC6SU21KlBVDmZ2+OrtNdWtUebuOZ/bF4qe5s7B8Nvef9TK3krNkMjebuhcJK+wqPMTUPBZmE6OC3C2M4XH1o5p7aidzfD5gLfn/Miz9yUUdZZUftDW/6XU5KaqaEJCkr/n0pLaM0SeD8XOKIiVKIDSZldx0OcBKwGRxmtedZY4ivs3WL7kjiqD3HCHn5Dzudhkxcg3dZvWPwXfo/+b1CyghUo98DsdlO010sSK+W12U648KxNXXljh6fJQBPgcukdJfECjxBqK7VU6l59wrdTofPfPDA8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C0Afn3YTT0UZVlXMIBcjOCcX4PrNHj+10zUnTp/9pUbYVsx2nuyauFI79P78?=
 =?us-ascii?Q?a9pOdLpvV3UbUb7Mr0GVEleczmIk/wbTwaUU1jlfErpIrdzs5lB47zcaP3JH?=
 =?us-ascii?Q?D2n+dKR80RaLqokNhwG/zTdxIhfzjCWS7Y/008aW92dam3LtwGISdmtFCaK7?=
 =?us-ascii?Q?bTGqZ7zoswjAyBl+eoWP/5ObHVw02WrM8RMk0p/hUzTn4xNF7L+xCJfRPoKp?=
 =?us-ascii?Q?pgJS6iMwcsS/eAfsgovLPYdPHipi9RxqXIMypFJzfik0lfHhWFy3rwVmCyr7?=
 =?us-ascii?Q?BjwvRfcxQuMK0SaOmeR15mBkxUl7MCLBvFb+B9HzDYQkBLOHHniF2qD+TBRO?=
 =?us-ascii?Q?N93vDz9g6JJRapk752BosjHDnDx2ZA25zCvhKDNAp9nVp/aD2Qz9mTbX3oK3?=
 =?us-ascii?Q?Rk5IV3VgQ/YIFtZe/mgdD0V1BP5hiEsvhjZy7rijcHrguiGXJyEsrFb+t3+W?=
 =?us-ascii?Q?IbzhuOxld2MZq1ynDRxXdKHxP83gRI8MCLWoRpiMoUXdo8uKhW6m9YDtVr47?=
 =?us-ascii?Q?/87ABQ7tsPAFkD9xMr+qw2JdP/rxzoLAGpD8KbtS084NT8Awtt3x3VUnHq0+?=
 =?us-ascii?Q?fhwlqQ/DXsnSm9MFW/30NaOEUaWaRZcym907lC+KsW/FTzW5ONPHImeNeo3B?=
 =?us-ascii?Q?qMjb/hNLlqK7YqX/rIIKBOWRBR4S0+0KVQPlQWX8rY0ZRj+7WAMDwJPvTRbu?=
 =?us-ascii?Q?wdwtqHN17cJdJRhumgQCoPqoKD64busvPMcDAvutqmEhHo4ATYMTNp4H3DDX?=
 =?us-ascii?Q?uyWFMTyTIt4ZKc6Y/CdvAsrfHkFzsFhi2tHgb9/v+WZ/4XyaYv+Tka6QVcbj?=
 =?us-ascii?Q?u6NZWleoh/hvnrN/O4UQtp3KdGB1WDYRr8XGU4V0xERFNtByUehEe2c+gf9c?=
 =?us-ascii?Q?BC1ic/m+FqpbbYvVRrjMqmIODQ3kk1WgMvmckCOheVVj9Y3eObez9+QWnLg8?=
 =?us-ascii?Q?qeELoU4KgNPAiMqsjjbETXVfRQ0QxlPWQwdAxhC6eslZVWT90wKcwe9VlNYH?=
 =?us-ascii?Q?5FQQJCSvH0qSssU59q3C+eY6+SnHrewGplpeI2JcQ2ZGEsI3V8kPhtjzUvHy?=
 =?us-ascii?Q?bUalWhZ9UOPEa6KQFbaTT8D0Ter5n/8j8K+wAlXp74SZISg8qqLSbeb820sz?=
 =?us-ascii?Q?xtAsNawwwtZLKJ2uOYYmj96B9S5ooEkM6JFbM3cahXedVdMZho5kWwHkvC/w?=
 =?us-ascii?Q?Qnio/1/zsNrYZyMne+gyRptx+fmVLhLbmLKwS0q52nYYCrc3kWjG9HmgmIEN?=
 =?us-ascii?Q?VGi+asdvrLPnf+kTYZPQtDFzytfAqfWFfZuGvsvdwduBDd6kF19IVDtjrEhu?=
 =?us-ascii?Q?xVN9XCpPWLcQ18DtVmUDvgfvmcwUa/L4BrxevJ/cUqCSLN8mcxpvvnKtXu17?=
 =?us-ascii?Q?Lg5ERIaoAToUnk0AeyEw+wxRqyOqjQvvIn3vsjlnWu1/8en8FmrXDD36g42U?=
 =?us-ascii?Q?NcBfrk8gzIky71pELWOvbdL9oNFczaRIy6xB9HgaAI9rklEsvOewGT8Ywg3e?=
 =?us-ascii?Q?tyBU4i5LoWl720jigKjEJcRShKECEAMOVdqEhQEMMg06167GjRS/AfUjBYtD?=
 =?us-ascii?Q?639gc9oWWYuClFwNeMID1v+tPYjoQtGZMh3b/PJu?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9780bc1-e0c4-4b55-aa68-08dc58843f3f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 11:00:20.1497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXJrMZ/+f97m/s9CMJtLnBHeJBT5Pm0onXycTUYHJAQnN4mEgNA6a3aPV3Rj45EJ64wxMV28dfyJRD1EPvkkLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR02MB9826
X-Proofpoint-ORIG-GUID: xg5xs9tHXy99gD1kgUJr_GdHsjv2Yjta
X-Proofpoint-GUID: xg5xs9tHXy99gD1kgUJr_GdHsjv2Yjta
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
index d03a655f83..584d7c496f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1724,7 +1724,7 @@ static void test_precopy_common(MigrateCommon *args)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, args->connect_uri, "{}");
+        migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
         goto finish;
     }
 
-- 
2.22.3


