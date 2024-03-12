Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B6CC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4rs-0003Jb-6K; Tue, 12 Mar 2024 12:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4rq-0003Ir-4F
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:42 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4rn-0000ih-Ef
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:41 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CBVurR027478; Tue, 12 Mar 2024 09:20:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=i4RdRFaxUEsxSzTGZvX2O+moHmZD0N8FE2jJrQg7e
 CU=; b=Rl9ZJkjamGo70QdUbITTeq+8UEmS8o3pTyuPU5uGfpA1E9SUfmb2F1M6F
 HRJtOoSqUgwd+8BZJnWAlgBukZS52HWbrJD3CRh4PULOxnY6N+ZAvcXD6WYeFFGz
 LaMYMcj0thdIdGzo2Xw6B8JIwSPAeWQmk99pYF1uoXbU2CfnJ4hM462he0WkzsJD
 BzPLIiO4jc92871P4AlTcmmWMo8l8iU40lVfaaowu2cTyxwbBvKsJD8twLuhGcci
 oQkBFs9XchOuxL8OGxTPttAW7gSOv78i7mfslzokHzI15ql1REp6O4JWbz+YHfcd
 1fR3BDRjeBYVY0I5OsSUY8nDN8vXg==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrr63pa36-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:20:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4Pf3vEyyn6DJB00EBgzpGw3x7tEfC7qHKr0xEIKHGm9ozsl8NBMotUYBb1Gzj5o8AAmXxoq+EoaeqxQaSMtat2Bf+6QFOgu1VuW9DeEyWqBDTPOZrMompO04o8aoznivBj5LpDrzhrEwcgBDmcWtUd7W4p8fw4YzhcLTwSyir721bvV5sBUQM4Et3PIVpXd5d9NsgwH4o9IHDOTXi55lKMgfV6alJZpR5hBxAlCciIWlB1G/45NvmeZfzQcnDYDNImWFl68jNOIS4MjrGbsGUPqCab9e3z3dgS3OrtOf/4At6GxKVWfyXIt86Ol2rmUlwlcKmp6SoG7L3973oIJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4RdRFaxUEsxSzTGZvX2O+moHmZD0N8FE2jJrQg7eCU=;
 b=jcgNy2FxkkvA13eCD4OnJwCzZT0XOfHlTWW6kAJOsiDhbYP+9tGrh4b9lF0v62ViAogMDJlvA0GF/zHCroYIzotOsQPQLYawM5Q8fS/WS2uDRmCpwIcsjKzs7HStwF/PlQiwE2p4KS6upJQDWI7v1/EBgAHYVQnUCMEDjVImVxZNZoqUTnd9cEiGHwcc7iCVnwfRPgOmHlq9859Oj26l6XqvnALt2uBpG5LEFIYwGvmRSG0c26fGtQBFWkq0KSzkDmD9McuyOUfI/vmq2HhWamRvxQlNeWPfEAdLWut5qHEbxoMBmKjwK+xcqOM2DgO0gxeFLPOsoXWgWUul2ngAWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4RdRFaxUEsxSzTGZvX2O+moHmZD0N8FE2jJrQg7eCU=;
 b=ULCexHpS+fE7/UPh5CGNwuEzsgtIaOdcGf264x+n90JFGBbLwWHyGwFTKbUU7/09x/PEOtb8+esJF8jSsf8yoW1NZDqJhdpVsuC0JrglEQ8L4LX04aKI9tupWLc29EIZ6rkgTzG9b10S/QnJi3+4RBdi9JiFf2bYlvZQ6gMeSUTBBX/q1+2PrCwgRCpN4EXLdYb5Fo9VSALjCiKprteIWD6Irp1bVTWT42y0fCu8p8rBYVQxuoTUulqjjuwU2Xsvoj/xaLHOBV/k2sncZAYecEy5vP+f6cVa4AC5+s1xKoxVfR68IwG5MApTBvs5Cm2ldQpYOCEg5tG02G3bvG5r+g==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CO6PR02MB7570.namprd02.prod.outlook.com (2603:10b6:303:a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 16:20:35 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 16:20:34 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 3/8] Replace migrate_get_connect_uri inplace of
 migrate_get_socket_address
Date: Tue, 12 Mar 2024 16:20:20 +0000
Message-Id: <20240312162025.44212-4-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240312162025.44212-1-het.gala@nutanix.com>
References: <20240312162025.44212-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:510:23d::12) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CO6PR02MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d5a5f6-3a76-4b0c-fd80-08dc42b0584f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEIt8AbSz3ycALG7peEYoKH11fnz8pZF8SHhB3o2aUSRQ0r5ByYl57gcCd2tnS7jPntM40/Afx+5wQ6Ps/Eds5BQ+xCxo94UJIUhIPX0n9q4gXLR8t2JoNpT0/E7QRLI/9YXiQc9rw7lq6d3LMRf5TFPyGBuVN2e4oduQBMJGXxStKv9RIvEVZmn/LTAiOub/4PGPUhCy0UHGh29A49q4oTyxxU8p19yoN6w6QbzFoS65PC7Olq23Ua9Xm7oVf7qsKXJyb1Q4EWi54aBdSzSDX7Dcd9a15UrnWRftPJEOUxnENChehmWLZ1hbGGZfny/3pUb5nmMl+Y/t3v0yiJUYv2EE3ZsABFc72BUkAsh1wAaN8s/j7GS3ZDx5IAJspxLTlPvJ2InjXhbSe5qfobksi3NGuiY/I2cdlB+2rdtN7fcjcmBppHymkCgSe0Rb0PVbwB9MdmD6L3tEoh/RdOHyu8+d2mHTLzD96pY0oCsEz5O6Y+OCo6CVvPWA7VhLNvKChmuZH/11sXYOfFJ9tHa2G69Zv1OGQN5e3LRZcUQwLa2FjZ0ybL/zpn/D9Bdm9su6U0OiCgFT6DsZuBfEYEQTyqQoXrbWitWkP3wi3/z6CYYP/RM4lOLu7FfyV+Jsxa2Af6ymqGY9SYTOVnWqFJyuqL0lUEC1pPYZ/t7AyCTwXzl4wFOjBc7JmBLGC/7kFeInc8c+Xy6Oo5mjbBlVlcMLQcSZE5Hmrf+/U5nJXniriw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k+i4r6qwUw+Ia2vbmuVL5IpZtLIG5+Z5DeZecGqgWg4cynnqENAW9bchslrJ?=
 =?us-ascii?Q?tR/SShDZLz8O4jV0eWQwFKZFgYKxgNEkWtQ0aqgJ9uUMARiTAZumi1kPkCut?=
 =?us-ascii?Q?Qq8z70N7ky7B192JSJELM09YOCaOm/BD0Y2w7mtzVgt5XzWhzoK3hLQda/Jc?=
 =?us-ascii?Q?Whj814xKFmOe5hk0/ohbOUcIJPpq2mJT8b8s5inHqd54qqxREnniKTQu6XwJ?=
 =?us-ascii?Q?IbdR/9I+fjqtq5BUnj2DfHwqISWU4rBkujLYj6JDhx3zijPnD/2wprfPBsij?=
 =?us-ascii?Q?tQpUd8N2VSzg236IWazJO3PU5C2GHNB6AiszPZ0Xa8XucRHyWt+R/DC6bxE+?=
 =?us-ascii?Q?N+4nLbFyNv7vT24MBQK3qxXolPw/JomQqVeZwpED0HWyUqCnmBEltySQovNc?=
 =?us-ascii?Q?qdXoJriVhLWaMoILisL+GH7iGGHKtnHmlzmYPHYqAyMaJmFX8/1ZtIIfqMv0?=
 =?us-ascii?Q?VwKALrqZGToGHQyke8s2nbNYoCElNxlmeWtKaye1jobgWD9/W+NBsaXP1LLa?=
 =?us-ascii?Q?2UnZ3BAy5meM4bH4dMmMHJ8D4KuiA/gnz6DDnN+YKWXsuBpO464JSeBYHucq?=
 =?us-ascii?Q?zeWuPFRlC7hio/YqUEKwecMT8JBuCdfuYG8EcWQIRXOGnO/2ZBFJW4IzRhJH?=
 =?us-ascii?Q?iFsTrPjEoMPNLtJj6SFfi/go1TiJH3d6eLpEkrvohdkdrCgHRZLrysQi0ZNr?=
 =?us-ascii?Q?jG7ib7JGdLYJwf7mqHuSD2IPUfTZePNjVwPjZ3XARsXyCu432MnxG9OaXRDr?=
 =?us-ascii?Q?ZZs0Ich0gH3KwZGpZRk3vtnwOPgho9DaPa5uZEzSidMLDKLUwqKo9n29Axu0?=
 =?us-ascii?Q?2oFVf8VWwymtz9iAFoHUFw1FmpKoognU+ebkNuuIGz0t1WgstYDRsQwKylvm?=
 =?us-ascii?Q?8irjBF9iLGQJMGLw1A4sgzkLMHJBzNyG3VTtvgb0dRBIRwjzhoKf/D+Z14hm?=
 =?us-ascii?Q?ZYv2Sr7y/Y21hOKj05madX9Q1lxlybpaGsD8ledpQDcyYddu3kcWQEtDPHed?=
 =?us-ascii?Q?XXLlgSfDcjXgaLvyr7QhjMLBgpA7Oc1WxxZ6OmJ+GBJlxoRD2kPVR/0+GKGQ?=
 =?us-ascii?Q?q6AMKdYktEKGXrndnHo/AX7yWhkBt0OhTzg2ZK2QQ1k2/2CUhlM49AZUg6G8?=
 =?us-ascii?Q?86X8P4/6Tp8RkEOtmsYrvmRhDjQGkFr4Tu3g+Aq31scP+0gJ0kpWVAMJDsUN?=
 =?us-ascii?Q?pMP1ZSmSiVpqllVsi3bT/TXQOrcMyKI8HRhQ66b1G6WFwmSkpHuAriXV4ZU4?=
 =?us-ascii?Q?ijG8QXrsaKSQMvjsQ96YVBy5d9kbatl53WhtPqH7pBU23xmDfNDCrld1ryBg?=
 =?us-ascii?Q?M0LW45Hnt0QCnohvW+eXnfmbjp7TcN+Kk1jjlBrYXjJgJfzlMGxmlGTnxKvo?=
 =?us-ascii?Q?Oe2OCjoeb+ox4VFpDCwiqst3Olqv5IjJTPq7mWOLlP3FJnYzm5wuJOZjnH54?=
 =?us-ascii?Q?Go03sonK837m0rFlLJw/GdQUpH47wMF1iD5BMA2ksb+ZtRA2KsA8emOCYxcE?=
 =?us-ascii?Q?zoAyo3Yn1pb3I5tNK3efXEFpTexpH8iMdUilZZAuw4FO3O3VDYF1ZS4twd89?=
 =?us-ascii?Q?FL0ysGXgSCnNK/wLdxS+yPFSLiWnZcAequS3KN6vrdXBoAXV7/j/4LkOQYPY?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d5a5f6-3a76-4b0c-fd80-08dc42b0584f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 16:20:34.4348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VxgjLfuKjHhlT9gwKEaMVSt/+TkMNoSIvMzHpwRoINZhqgfpip0DIj9tz7rWcggZ+vicpr3hs3zTTVKtD8quA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7570
X-Proofpoint-GUID: USqbM155EbOLzkT-DMQmDZuLL3WZmSCq
X-Proofpoint-ORIG-GUID: USqbM155EbOLzkT-DMQmDZuLL3WZmSCq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_10,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Refactor migrate_get_socket_address to internally utilize 'socket-address'
parameter, reducing redundancy in the function definition.

migrate_get_socket_address implicitly converts SocketAddress into str.
Move migrate_get_socket_address inside migrate_get_connect_uri which
should return the uri string instead.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 3e8c19c4de..8806dc841e 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -48,28 +48,37 @@ static char *SocketAddress_to_str(SocketAddress *addr)
     }
 }
 
-static char *
-migrate_get_socket_address(QTestState *who, const char *parameter)
+static SocketAddress *migrate_get_socket_address(QTestState *who)
 {
     QDict *rsp;
-    char *result;
     SocketAddressList *addrs;
+    SocketAddress *addr;
     Visitor *iv = NULL;
     QObject *object;
 
     rsp = migrate_query(who);
-    object = qdict_get(rsp, parameter);
+    object = qdict_get(rsp, "socket-address");
 
     iv = qobject_input_visitor_new(object);
     visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
+    addr = addrs->value;
     visit_free(iv);
 
-    /* we are only using a single address */
-    result = SocketAddress_to_str(addrs->value);
-
-    qapi_free_SocketAddressList(addrs);
     qobject_unref(rsp);
-    return result;
+    return addr;
+}
+
+static char *
+migrate_get_connect_uri(QTestState *who)
+{
+    SocketAddress *addrs;
+    char *connect_uri;
+
+    addrs = migrate_get_socket_address(who);
+    connect_uri = SocketAddress_to_str(addrs);
+
+    qapi_free_SocketAddress(addrs);
+    return connect_uri;
 }
 
 bool migrate_watch_for_events(QTestState *who, const char *name,
@@ -129,7 +138,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
 
     g_assert(!qdict_haskey(args, "uri"));
     if (!uri) {
-        connect_uri = migrate_get_socket_address(to, "socket-address");
+        connect_uri = migrate_get_connect_uri(to);
     }
     qdict_put_str(args, "uri", uri ? uri : connect_uri);
 
-- 
2.22.3


