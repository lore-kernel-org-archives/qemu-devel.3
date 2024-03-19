Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72026C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 20:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgOT-0005JB-Vq; Tue, 19 Mar 2024 16:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rmgOL-0005HD-Hc
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:49:01 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rmgOI-0003f8-CB
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:48:59 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42JKOw6r011175; Tue, 19 Mar 2024 13:48:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=4Jec0bWh62sEWr3eB0M134CnnwPwsbzvlCstBaRfZ
 2c=; b=nCfsnJNwrPqHEaqSFM7hwkB/WKbiSru49Rwx+l3SVs6bS69/V/0ALRvjg
 aYqugtEBjdqA1keEpKwDRj8PLgjWboyrKMm9LmP9/nORXtjEmFCJXqC2ct+bs+YR
 RWkuiwaNYVJTeby/KiP0xqxXZFDwz595nFHpLl2TEBL14qRRomaxDQPbHcaKSv1e
 OKJwzjx8ZkAL5pclOHtJAZLBrzsYBt6ZT9jzZPFF6z2QiXSI2dPUHZ1LsIW9JKP7
 X1QDUjc0y7CBDszft2NpvmnfPq0fUUb33zGO98hEeuFSW6GHgGYlvlYDBYN9n+GJ
 oxLNA+Hgphh1xDZXLGkvZA+qUmMsQ==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wyhqmr1f2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Mar 2024 13:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtVbuckXgwdlZ5G4RReOqFtk77TjwfXpCrOeVwotUrXZvlrx/etxFTnKVimZjnlwPFWDvx45O+nNh/V1ZjhEnWA30grszUgDKgT/4QHLPIz6hv0pFa+Zs5O3rCNmruH3wQlpVbZMe+jNK0lKZRqilXlNqcIfeZ9ehfldD58Dm+snml6Fw1rT/G9kMHC9E28ciUEkBJSJ9RzbCEqpsUYyKqz1doevwlG4C64XCjLYVFFwULHhVBA9z55DxhoBqjOlxto0VSKo/i0eLhG60s8ecu6XIL7U6NgPq+koQr1uP8ea0R0brIn9JFsowiZaAmDRLU2gTkL+BpfqyiWUVU+9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Jec0bWh62sEWr3eB0M134CnnwPwsbzvlCstBaRfZ2c=;
 b=UgMvXt8BaXamMMdbCDmW9/SPBvf9xWkVUR+QtRBWfGkI4PyVdRHHdtUwjM+4yNIayUzz9ZV/r6IrFpo4E08qlq+PRvb6JUzhOQxFPLPiQQmuRbdVRvGGWp778VYz76EnU0CvrWrlenuVjyNVloMOnEBQsvzN/Wz5U3DtOQy3adzOxk2lGWhToUmNCmDZ9zohx/6m+xBV4cvPZH5v0MFW+XKDiMc5YzdU0bzI8QVgGXJOuXl8nNMY8/dWmeB6sNVUD6crWCrNAs2HFPgKVYoBOHTUglcJY7Q6K8sKh0EtSjG8t+BwERdiQ8VorAYc8yQVMLtcwAFWT+yg0c3P+0k5rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Jec0bWh62sEWr3eB0M134CnnwPwsbzvlCstBaRfZ2c=;
 b=dmFiswSBVKG1TKpwdA/s4IPP2fmKhE8H9amsNeSsiTCLWe51zK0PcEItiY0kymHY1AievznK4RfvzE8zWdRW9ANlD6nnnwiDeC8T49sW3lrBOvKTtcUdXrkDo8O3VmQsVtizJLU4EZwmWEWdRFXj8S4gWN9E0m0tPKWKcokR0l6beENQS9UZmjIq94pN0MbJXFIp0WWjAO5dlRfJRizyu8HJA2VNA39HhQ91+/3JjQtQ12RxJCu813pFXZcruJTxtVLSGtAgEz4FrYL/BYIX4Nu+ssuU7osbKtc1+OnLC6EH52Kw9WpGBqf8vcEIb370TcZQ0n/bDdaKtROOfzXVCg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM6PR02MB6732.namprd02.prod.outlook.com (2603:10b6:5:219::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 20:48:54 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 20:48:54 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH 2/2] tests/qtest/migration: Fix typo for vsock in
 SocketAddress_to_str
Date: Tue, 19 Mar 2024 20:48:40 +0000
Message-Id: <20240319204840.211632-2-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240319204840.211632-1-het.gala@nutanix.com>
References: <20240319204840.211632-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0118.namprd05.prod.outlook.com
 (2603:10b6:a03:334::33) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DM6PR02MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: abe6ed21-ac2c-42eb-9a12-08dc4855fd5f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgs5HCPcU4nSZYgRfjG/kU/WrqP3tX1JQb8ch7HbO7kgPYj4c56WfUhHOC/6YtqZvyjFACe7fLo+nZbWC724svlxXtfD+X/PTOla586oIJwD6ZAjNIRrvBbKVNqB3ixun92WSdzqrGHnu7tsVOtEq3Td0fVMPV0WIeC2Y2YHVobQBULz/k9Pb4VL7Igj4AWMiw2V3WnrVqw+7gq7nhqZrmOnRYKsPiLwPWT22jXlcGEjGvX3spkG0bBbFP7bb5fGCgjg2TBObCtP2nCVwi7E2F/TJ+kNnFPF5dFJ8BMdIYcEI/oaCrj8lSJgfQbBWFXdbxdPByU0sSc/eA/ig0QViQp2iJGfDJvv91J3r98XETV4j0oqEE87cssfeRvQ3+uthajIH5SQ+quJXckNs0UQoAThYNosif//u1UVHqgLCV3Iqf7EAJdBDhFQRTWsGckeP51j/baYWJJPcoFCaYEn02qe1YiKiXc1EvBh0/2FKK6zgUfLL8+zr3pBiCYsoVZv2IuCiZWmFsnjGe6Tq6vgdVw6l/GxxqH7lIcajus0sE047re6Jve96oTeiWc281eiiTUIIK5SJQIPTmgdBh4bNChyTRDB9qhgYdum56rzo6sAVhk2j+UJbM2HDLU+oQYnMNHnwtBsJYrMyBwaX9Kj/UVrZ0OLmZd39o49glIvAx7kXyVgJIre+/kHzr5H5ioHm/89ameWdthdQiG84FhoahwPI7T2PYlT4Bia3wDBArY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DnKSJOoV+qa3lQUrBPHGEZAaENYRWERjlQug4FkyxkN12HIiYXTICzruKys6?=
 =?us-ascii?Q?E4HbNyM/YTVM0AJxJmdPqJKBkFFKnteg0bGQfQz0FB06HwLtgtZJSgXqtCM7?=
 =?us-ascii?Q?2WGaFrjGKjddKZlMGUTAI3OYV0yClYIAKqg7Kf/dP/mOI+XVQgB1pZRQAbEp?=
 =?us-ascii?Q?JK4LR9NcMnitFsS1Dro8F5+mt8nd3brFcA6O+AOt6n7UhpSFXYiLPVlt9Ami?=
 =?us-ascii?Q?Kpmn+iTONef7cyguFDB7eBGSyxCi9/q9u7qZUPTqaQdZGnRVwktprHe+vX+A?=
 =?us-ascii?Q?bMpDCQNVcwan3BbSh7lgtbYFGkkeJqGIUHuDR8U5hx/ne2xHpgVBvPdPjZIj?=
 =?us-ascii?Q?DaAn+YKOt7O+DPJg/FDN/U0rrpG+PzZyt7yckoH5wLtyN9FgrgI9kSYBVtf9?=
 =?us-ascii?Q?9QWfitZKUzaWevaLPZrvVKg8ihRdY6et+gE+yoyb2duo+YeXwb7xZ85Kvgsg?=
 =?us-ascii?Q?Omvrgoa6FM53Tm1SBENflWgmyUzRq+G9pPIf5lu6y3KaJ/CcYA28pGQgOq7z?=
 =?us-ascii?Q?BnsbCuIw2wyw3TqgCB9j8KGuAqNi9WCyB9m20erV2QV+QGbEx0KPnvp/aH0r?=
 =?us-ascii?Q?vasoha77FsvQJJqK/UXk6TH412PRqZI5jx3EjT3zKt5T5Tdps2OdwcEW88Ls?=
 =?us-ascii?Q?ueiPtXlipAMueaoln5EdvTrgs93j/LeNZtpRo26p7mu8mLx1NMjd2ney+JMg?=
 =?us-ascii?Q?MjPRWzo6aNflhIyuYwAREdlQPROonf9JJjIERVI+F+q0vSzBPgS80e5/cB8G?=
 =?us-ascii?Q?Bo05PgwmmDaCSWcQ+sNP/vs/jWMUsRGhDoYg6W4hv3QOBksmqYBaDWqpmHO4?=
 =?us-ascii?Q?XvdwwGBlRE8m4Ads58ODUgXdngEyHsYA0k7x0Og86yCuHMx4I964MeUzP9E5?=
 =?us-ascii?Q?xhSWMvNebiVpAqnv7C/bD+JcuxVAnn54GPw9ASPc46ExLCr/WQE/5DS10f2L?=
 =?us-ascii?Q?scsn43h31vJRxiT62hPT2BbtLm9cX9b4RqEOcjuog4IVFkivstlexcp8TCJC?=
 =?us-ascii?Q?79IA64m81xGtrvi9DPX0s+z5ajDLcrPZY6sDgMiLNngEoD0BCYnTKioBJokc?=
 =?us-ascii?Q?ah/hZW7tDJhnxWnuQtiKEc+UY22GvZJ6hKAhm3BEu0e/IvBWETXB9MWhQ16O?=
 =?us-ascii?Q?IBdvW3GlAt5eQm58zU12PPmLgVMxtLXAhgFb2ZLNddolRhAazYU1znZfmlo8?=
 =?us-ascii?Q?0M16n4jCIvmsb26xjA3DaQEYWtic7j7/k1BDPRM7BAyXbj8XMJl5vOdPu8Yw?=
 =?us-ascii?Q?IOfFvLAcD1Dz9jJT9M7pLlPEySSf9sfYuGA3CPxIu+knEcWDLBYBSiHXVmsg?=
 =?us-ascii?Q?MyLzFP03QFdGfo+fU150/HGwNJDPZHVqEqKVhzMZTpFj1gMHttOuTK9FNi1X?=
 =?us-ascii?Q?Ppb/f0kvy+L2tojmVUK//yH8S6WcLDcJjMS/VyKYRiktn773vFejy/bV4/ZV?=
 =?us-ascii?Q?xN1ABLolG1bB9DH/YKw0zfMjbEdtC2Q5T1akYJV3wLtY6npy3pZJCm91U1wa?=
 =?us-ascii?Q?m0rBR8UqSO4YQKupI7P0b4KZpIS/vDvvx4A2XfL+XhgwgWbfO6gOa3EjW+Pp?=
 =?us-ascii?Q?/1883KthPUYGdiWeItavCtsMNpbRAe9AcnepZwC4?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abe6ed21-ac2c-42eb-9a12-08dc4855fd5f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 20:48:54.1740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eMgtfmTqsnpKYA2Q8YW+ehXooJ885B1Fbr1ePPTRR1AyEPbTJD0gNtaY23K98aAUvt1jFe8SIrJJSwUthgT3KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6732
X-Proofpoint-ORIG-GUID: ExkcjpyxHImKr15jRFijNd8oaG5H_0db
X-Proofpoint-GUID: ExkcjpyxHImKr15jRFijNd8oaG5H_0db
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_08,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index fb7156f09a..651c6c555a 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -42,7 +42,7 @@ static char *SocketAddress_to_str(SocketAddress *addr)
     case SOCKET_ADDRESS_TYPE_FD:
         return g_strdup_printf("fd:%s", addr->u.fd.str);
     case SOCKET_ADDRESS_TYPE_VSOCK:
-        return g_strdup_printf("tcp:%s:%s",
+        return g_strdup_printf("vsock:%s:%s",
                                addr->u.vsock.cid,
                                addr->u.vsock.port);
     default:
-- 
2.22.3


