Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30621CD128A
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Apr 2024 13:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtST0-0004wc-BD; Sun, 07 Apr 2024 09:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rtSSs-0004vQ-Sb
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 09:21:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rtSSr-00008w-BE
 for qemu-devel@nongnu.org; Sun, 07 Apr 2024 09:21:42 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 437BO7FC026789;
 Sun, 7 Apr 2024 06:21:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=wbDXV8VXg8vLSOuikzLXBmMxUznlbOz/OKwHRQaxg
 LQ=; b=fYvbdCTYVaMvsNhaVciumG9JVmpE7WZljnaHflZJpHgFdw2TLaWOXM6Xn
 NbSEvV7dClDgiKE2L+nBG/A7b0kR2DRRY/MJlmRRAINQCaNitUNRzkeCAG+GZYn7
 Jt/DpozlgvO8pu7vuynymdjaohkWnD0EvHk22dvYpFp/XblmehjHgDc0LSCCpfGk
 Nd5Rfj2LPgcziKpyy1wmZ62qrLhVTdaLUOYF4IfxQoPfLlM8jDoZQ1aRQ6H0ydKU
 YYMdaLq8iVq0Dxt/6iDsKYRoyp0IuHTFwZCrur1yJhADGI0jE1pBTejG9KFbt/yJ
 7ZyPmZZAybrDAWZaBECxMVuAwfqfg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3xbtjr039e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 07 Apr 2024 06:21:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7X9BtCYBUFpLnZ/9SyEyUdbdabxI+5h5gXFnqEpEEwSveQn1pY5oSDcjKMVTUmxw6/tVfuIGROeeWxcxb5+Z7E2XqnSW/6EY9MmmdFn/J32/zPbptUIoTb4W2NOu8BXVtZj4TdNRO32aVzGZ858J2P/Q1NkwEOYNJGK1xDvtPDh1mzIwblGVFssjir0cuQdwUGgTfMH8ZRjgusIxvhXrT/d3jooBfMP5OSyS9nF20jumNGfl5jv7Aq+9BXYYKSjBQm/I+0AN/6xxRm9Wgd6iJxQRr0sL6s6qIVjwsVMqjNwxDTvSJQgOmmY+uVzqdKt4Oj1kDC4CzjPNxSkiu1QCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbDXV8VXg8vLSOuikzLXBmMxUznlbOz/OKwHRQaxgLQ=;
 b=mQPj/VWnhzSoBRWVOmVst4oQtCB+UF8WVk6l8+Dh5Be8+lndGissMbtCwDzmC0xJqo7ncbV0CdtUEC8GRvp5rSfjyYi92jLcMui0gPKv4a+cYTCcGEhMtxTHckVd9UrzFwpRoK2dHy1mmIzaTT4x3U/P929ou4kec4GCqFt1YEHFi/WheYj9dAveoeSnj9mbBI+JmnMHsCyMRuRyWwGtE51Q0ly6dqzt8d6a8A8fvdpEX0akPRzaJsDb8/VNef89FPSUya58toEyJmL8ly1ksBDarsSg7CA51IpOBUNrr2wj8Updg0pvNPWmVlFHcoo/0HZMHyNWeHblQ5rJkjbpHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbDXV8VXg8vLSOuikzLXBmMxUznlbOz/OKwHRQaxgLQ=;
 b=YbRquK6cJ79xQnqp7VxLkTMRyQGGCrO5kTKbAWSS3HZrEKbp2H/rqpacQk0qgdO+L9YiRlcywfLuh33LYEfjierAdrBz5wOE3UTEAs+CeZ2gjzCMKLmKs92VPAuuRB2rCyyBuKRgbrNOADCKOjhWa4/5WGMoScwoYSSdqYpAjD79xt8d6by8N5AMRKu4bFMlw9lnBLfDijyYMSmeZ/u718StYr4+JxK/AVlpOxcRw+gQkelKJ4USHvB4Hv7WxyNH1vFk3fryZPUwlZn05EXh3jktyFB8xpyfrTSe1IY+9S2qq0k6iHjMAg6WnrRlgtUlfK8a2T4Xu8Oa9JV0jLOwvw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SJ0PR02MB8625.namprd02.prod.outlook.com (2603:10b6:a03:3f8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 13:21:36 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Sun, 7 Apr 2024
 13:21:36 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, farosas@suse.de, prerna.saxena@nutanix.com,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH 2/2] Call args->connect_channels to actually test
 multifd_tcp_channels_none qtest
Date: Sun,  7 Apr 2024 13:21:25 +0000
Message-Id: <20240407132125.159528-3-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240407132125.159528-1-het.gala@nutanix.com>
References: <20240407132125.159528-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::12) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SJ0PR02MB8625:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H3Si1xx1FjNfM7eb23HKV/DJqboJP5N0TN6dPqRuoTsTKBOBbArQ5zwXKZ3dpZGxnK16H68GlR/pP+CxgATMzmkWAUegcQ+VxD+ZwOkYsuEzaJ64C94RxjKt63VEkqndctuufEwGKs/Gpeb6HFiHbaxZcxcp1Lwx2mhhURSVpdFuCeea0wXKcUPe4bF/SS8UYaArYEWS+CRpfbyB/8wCak4YONQc/VE3jHb6aY5EwOvKlIeFFIAy/N0oQMa6AF9Bpn/whjC6e8RclU3uH1rSlp5IQc19fCWAuZGMeJD2ayrqTOu68bQYo2Oma0LkZzHVQuEFjQOvJ1RxxcOXSVDtGYRKTaKbqRAeVkhyT+LegdpholKDPqgyCSK3/DAQaYzEbmCHWj8Stg+/1R++NDUXnlDDKUyRoz1Cp56Y8NFBM/BvdLYpDlZa+JEGGi018KJdWX2690Dj2pbP3dW8jLLOPGYjb9uNwwsuCMUzV5UOJduUksiHFOlp+atL0uJfYB2W/IbQFpBdyU6EUOo2Gt0uktWUA3KUkphrQLC1rWz2Dxu6mXgzCHV4dBZfNh5OwLj8fEcziq7uiZo2lh0s6GarO2jzOcen+XN9xxwj2oLI8c9qU6iBySRNnIZys65jTLJ/6Et5j5WjI4hH+4di586p0eu7AQiHeMHevpE9q6W8IGABYs0EngGKFp1pX+K3Q6qjjNjXzW3kbtJ/b3L050mL9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RQQi7GO5ir3OckdU5Tp1djgV2MqRpjoSCIVnv8yMtjUGVWvVdJddAUWVHdjQ?=
 =?us-ascii?Q?2zr6NgctHul5XBrqzny3EtXFXnC84fA3kNfw23KPad7VNwcLTcspJtgaxWPl?=
 =?us-ascii?Q?6zbdQXtsfrlfQNEH6cDyZlX8Fj1cZMcvVHqEFypKtHZsBcyVY0HDfTjvsXbT?=
 =?us-ascii?Q?ThaemDvQemkezf/vtNUzDhK9D1nFJx1FiMUqlan1dFO+Lf1ZSXKpE8MO3C4O?=
 =?us-ascii?Q?m+QuOTXISMb5K36Xef2wcBP1nnL5ay/FHR+o+deG/WC6CiJDfnbl+zICnNV2?=
 =?us-ascii?Q?R8oS0h63tpRR/KMfLzpLjXLj5oifKh94zj90DdoNrzeM5gfeG4VoY74XELhe?=
 =?us-ascii?Q?5xqW8mqPtGbkAwLdM42411YStSMJBpiCYedEfYIhO2RTg5K1yl9WiqKk7Qjo?=
 =?us-ascii?Q?4B9tH1BXN6voRl3/MeZHP1VvsVXl1Lp8HFAhEqpwlQwN0mI1UCj7/F+yuZvh?=
 =?us-ascii?Q?xXIqZGE0e/2YYoW2GySqFtu4jpCF3hqo5LqO01O3Y0Ml9XnJnSuAA4M7eqhJ?=
 =?us-ascii?Q?bqrgF70S3VuOCmWkovKmDN7J7BxnTsIWNgHH95E64Ai5ygRonDtIy/1TaH70?=
 =?us-ascii?Q?zTYdOockMU4dc2z+qqGgeJDsvJv95LM3dHqHZDswS7YensfLfWGdDrHj5o7Y?=
 =?us-ascii?Q?QOs+eQTc7Oxif4q290fACp13ZPWveBFqPKpZ0tAjyTq/0ayYe8oPz5KbYkMA?=
 =?us-ascii?Q?3jF/Uum/l1xs5wnrbo3V64f5eCWmw8KVSfOLyP7Ym4vuJL+jyUPjH98FtyjF?=
 =?us-ascii?Q?p0TA8s4qrNW2MhXeqv0G5cHiy1vm4V93E25opnym7zEjDguLMd9qtqgmTEAH?=
 =?us-ascii?Q?mQLyqk15bFjricbrPOd3NfL42Gxncb7/z/vezh4e7tAB2fPL1Qt2l965WTB3?=
 =?us-ascii?Q?IoaSts+1ANCS3RzmZbupDdrmMrOZHInwyOpaP8Y2AimiAvcPiazLrYyJc89f?=
 =?us-ascii?Q?B/SHcPw3+UGDFwEm9+CEgnJIEu54TipSXoESP1yzrOK2x0CnFp/l3x25e8N1?=
 =?us-ascii?Q?zk5eLzRfPQmCyX7Ajxl+rnvUX1z5dD345R/XyB/v1U9jJiWuLHf+/FPXRpMi?=
 =?us-ascii?Q?MGxT3goivunAjjxoNdW55nLyKQbBaYstNXbddGdzXp4hQIB4qnR8+i1NcDuQ?=
 =?us-ascii?Q?/8CUKj+D+lUAXWp/0h+Fy10fuCJxLDMKyVxXKaPolP5x+GpXvvGMMXFILBLI?=
 =?us-ascii?Q?FieNVylg/qNXXD5D+8qKzQOSG6sK41av+c6sHwgJkatBhllP5Tcnp87VyhVf?=
 =?us-ascii?Q?5SJoNS75gYaXHiZHzMAmoS8GdO/cc1/Y41Akst2sWc9fZQvByRq9YtFwAWl1?=
 =?us-ascii?Q?kznp8CGWSBDETpgnb1+e/74sTUBIFAyUSBKq8foz/xD76++4Eln6DoSrZFPx?=
 =?us-ascii?Q?zEzF60J9LulfA9fzE4phZ4VR6SXD8TRgkE2JOneN6I+FGUufwZwd2lAIop/X?=
 =?us-ascii?Q?//avPv1fUSxAEe0kK0VmsiOJ8zu5GKU8v1DX3dYFu0Pg4BdIu52r5zRfJTp9?=
 =?us-ascii?Q?fxkEtuDiI6ctQj5clTUK7oNOZfd2Ga2iTV50fGjD6zSsZgtyp4bApOPADgnA?=
 =?us-ascii?Q?n7bdnbPzx+TuXk3WVky2M8Cll5e2jIt0RWXK492y?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30254182-bd32-45e4-4a85-08dc5705a6e5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 13:21:36.7407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtIhoh8+czNF70LnabjLL+k6fI4dS3QDRuj3pvWxntwjAoFeGwArOMWpQ1XjV+4HUw/pHoy2diOkBwpqVWQKuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8625
X-Proofpoint-GUID: nIDCHfoGeOQn3n8le_R5w9PuFuOGK4nG
X-Proofpoint-ORIG-GUID: nIDCHfoGeOQn3n8le_R5w9PuFuOGK4nG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-07_07,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Earlier, without args->connect_channels, multifd_tcp_channels_none would
call uri internally even though connect_channels was introduced in
function definition. To actually call 'migrate' QAPI with modified syntax,
args->connect_channels need to be passed.
Double free happens while setting correct migration ports. Fix that.

Fixes: (tests/qtest/migration: Add multifd_tcp_plain test using list of
        channels instead of uri)
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-helpers.c | 2 --
 tests/qtest/migration-test.c    | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index b2a90469fb..b1d06187ab 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -146,8 +146,6 @@ static void migrate_set_ports(QTestState *to, QList *channel_list)
                 qdict_put_str(addrdict, "port", addr_port);
         }
     }
-
-    qobject_unref(addr);
 }
 
 bool migrate_watch_for_events(QTestState *who, const char *name,
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


