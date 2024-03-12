Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1F8C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:27:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8i4-00029c-IP; Tue, 12 Mar 2024 16:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i3-00029R-1L
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:51 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i0-0003AP-4K
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:50 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CCX4uR012798; Tue, 12 Mar 2024 13:26:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=O6TeGdLuTKgLcGcj5ZcEavvYgy5Xsqp/pD9DTS15T
 gw=; b=X2gG3PEiW8uvVQMhqR3T8MGU4pvVzFYDKY0aA2/nX6RYMhsGiUZ1o1CpT
 vPEVHVC8M2Nm+smPkDD67P/3asM6DznRChkS/2Ojs3WFNprulik/bLG62lSIWXF6
 KDljF8YiJTbO+NGAEisIuvEzSQihDW9AG8H/p/w/Utp2mVQNApg3CCJmpVr3uavo
 1sz+9SGa6+zk0/yEj0qAZmFSV/Ie4kggBE7gXF5fSR4PmJW1+nm92XyrBhgkBiq1
 XEK+f0/wM8DRNCh2Pvn/r9qpz2+JWl6EymjxeYcAlxgghn9hZsLqiNeazHFwoRML
 HHMWytjwfxG6JTrQWSH0Zj4iLgMaw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrqygpuec-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:26:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRp23H6P2Ohh2G6Xc8pMj7zjhIGukdfjqXKl8aD8cwsBy3krtKzWaWwEY/q2I+Jk1FDUN78oxTs4Ke/Od9dDClxeGjhbfH4Ezjd8DB9FJB+K6jqxPyg76GkDnl5b2yoHJS+6vXrb9TTk8KL24jNdoabsiQIQS6dW+BCfN/Tdmb/rVxYBB2Lpq67jGoHfpVA+BGmjig7ehsaTV+/TSwURTZTTkVEX8Ke4mZ1a5h7cy5HWBn7z5Dwn/QQVMrUV7DE/AggXAqR5L6t0C92QqsD5NJKEiib4nJGRHMw/5cHfLGax3Az/1cUPLMzgyXTBX7IA2QmK7x/AfxqjfPvlg79V4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6TeGdLuTKgLcGcj5ZcEavvYgy5Xsqp/pD9DTS15Tgw=;
 b=bfU5HUpneQlOw8R8aEca+3Lz9/kvBAA3Ukzu2DgJQxh8kHQWYbFNYQyN1JTgVxHjZKmQ6kASanTYLyj4Qa9ZQgz9RL3tFYwb0TotdmxGNgN8EwzrDL8Mr3OTBzQU2ydyGV4EYK1e04pDKFa4bXKk3Sm8YFiXyGS7APNAChVnQNIKW3Lcz1Y88r8cul+XdmQnHiOV+kEK/pjBTn8yN+dxoKtzxJa+P6dPHO4T78TABWIRZkKp8UNWMgi4LP94tGKB/j4yxJmWfmMJ9/ymcOnCezUWD1GAbBaathhWYsqxElaiEYrTsrqBK0BsZpJ+V/D6jFn2lx9oJyqA5EPuIFqKcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6TeGdLuTKgLcGcj5ZcEavvYgy5Xsqp/pD9DTS15Tgw=;
 b=aN5+eHvtYeHbgSSrG5iWQUwuBtCZF38bh2A2NRs5IHT8c5g95/txEzHWIw5fem8pFZI0qPar+ux8udJt9Y9uzCRJHDm3zT1bdayFWUvF2ODiiuNdM7PyA0PRX7BzmldO/LBm4qOoJzBKS2H286iNoEbnIdz0bF8IW7WrkR4BvYxrDn1mEpdgjWvN3zLW9p5WK+OnGLAaBD6NwpCoSsgChgz1Tts50mZg45T81g/GYx6njg3W+hXCOjkH3ppyUE7X/PbS5OdPwv1ltscIXiECETQHykorye+5jVNTsJa+vMHaqmXe/Jeg3ALlBNOv7oDnke7FfK82rRWEmxgQrBMm7g==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH3PR02MB10057.namprd02.prod.outlook.com (2603:10b6:610:19b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 20:26:41 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 20:26:41 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 3/8] tests/qtest/migration: Replace migrate_get_connect_uri
 inplace of migrate_get_socket_address
Date: Tue, 12 Mar 2024 20:26:29 +0000
Message-Id: <20240312202634.63349-4-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240312202634.63349-1-het.gala@nutanix.com>
References: <20240312202634.63349-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::34) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH3PR02MB10057:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e137920-1592-4864-1b36-08dc42d2b9d7
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UNghYDrz+dfEzfhSegmnH7uhYkjhS1ApjmUWulRYjdLPddzMx7wB1pwuYYJgtIf09RZjc5+XuUgdZ86dKjLodozaM2Jju6wG8ItOLz7WbukwB0thCWmogUQQpjruRjwYvCHbWRA7135IMDiJfQF4XVo7O6nwd7x8Zl8C5kUNeKUUR+m7atfEVYlHsOOMvyx6n3boNDw5y83tpsiyEfY6xfURctOjaVbw9vUX7AwsSEWIVyRde6k85JpfYU+rZU01wWs2809jQM4NeNi4AS/BZSmpMgZ7ThfudzdVrYVf8AnawJsEe7hTi6h16XwX++UJlkN9jkd41bWDF9ihcwsjzvtA7J/0rPtPL+rfQdIQJQ+ZSPtvs/An9B8T9TJ+ZIxM1/68QRRvEQ/LZuSAOFEPyE9YK3NVrJXA/GOZ3zQBQDC7XhhA3BfeoCJY4q3m3qSmUwl63LoftfIur0JfIyuTxEOeCI5QbdsmAc+QV9QF9933H7mdrzMDoRGImi2jTidSdMCTyzsUJoo9/Bc32QXI5N0zHFHPIA5PlihgKBc2I6W7tUgYFcjilakNSFN/NSl6+HvZZJXA6zx4PN11X2SPWfVYCrSldtD06u0pkN9tS3PF+26MyWEZ1dKGE/ZPOMg0KBFBouI6VvJOj2ZPrwx6OBHvd+RT6cb1vcWKjRMXTHhG75HfoChSmgzFlcuJdri0CBw65dW9iml2xHcH+kaVhnoz4X4iXu5dRhscbqTScBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rdtiXwcuY3MVWPQHkOKmWSJnsmAggGawPCQ6/gjCFCVrG5jjBXHHzOlW+37T?=
 =?us-ascii?Q?hfjHGXyRjPflgKABm4qhDDeCoPICWL4VRZdQ42LdsPUtO5jtobmZk7wEsoys?=
 =?us-ascii?Q?RavCSaaYDPZPCRmJPv8QxLiziwxLk9AnqaR8gPJQJEPvzE4isNLVPvdf7qM7?=
 =?us-ascii?Q?pMlwUu1AsKKOXn5DYB7x1K0i8ttmaCQJHkgGntoym3/DEL168/fghIZdafl9?=
 =?us-ascii?Q?p5TAYOgookucftY8DNZVYPZo0YTASm4t5+HvPxPcMvSr96NdsGbusN5to9Bv?=
 =?us-ascii?Q?bQAmXRO5t7d3ZgZ/dd4Dff47AxXMqUio01axVnc4DcUQYUT5J7Utc2gwc+Hk?=
 =?us-ascii?Q?2rnMANn6Ev2IEo+5rmn6PgCeJBYGPFszSv1VpmEhL0QLcy/h6tbP7ae6ghsE?=
 =?us-ascii?Q?dPmKD5WHi6ZFpmTqwzYnOdXi66U2f4KBVl1+yB4vSBYITZW8LtmxybujLHln?=
 =?us-ascii?Q?oRUgP+THphdXWyfJUeKptd1FoaMho16QjNwz8W51m9i4VLfo4SVayN5g44aj?=
 =?us-ascii?Q?O4JwaWrVZ7HvsUlqHspimWKDyt+nLPJkpVZXg4aMz9P3QP8zXNvFjmsXXpj5?=
 =?us-ascii?Q?1iKs5xosZJeQdvAVFV9jleAKr9uBl25rRlAR0h9ci4EGv4az14/JCVT0KweE?=
 =?us-ascii?Q?QOvmhsGZKKMq+DvTdXyMlA9gWM08Cmsl+9qqN6nnoa6ZAcUYiwdHi++DShDC?=
 =?us-ascii?Q?K/qF7ggf2T70prXZykPnkhMXhm8WA5Pa1hGbOb+KQ9R5C5Rufb2bDSltjiKx?=
 =?us-ascii?Q?c+DBNRmBT/08Y0PT9sXU3mcZKTiIQ45cdOZfxQsogUH3Lvbv9MhH6u2f3Ol2?=
 =?us-ascii?Q?0X8j51hgKDxcMMBpQyKB++8aZxy5pfTvNePHZRRIQx2+bUdZkjSmenjcz/qY?=
 =?us-ascii?Q?pHX4700I/a/4XuE6blGEgZZrZabKDTkxwAIM4SctBRkpwf/U9mi3qQ+yZKJd?=
 =?us-ascii?Q?pJg+KYMjsRbD4JJudHfzXvMku55jMWDfCVhbI6KDtwELX3ky5T9dgIntOSgo?=
 =?us-ascii?Q?oNmGn0mgQeNi4naUY01H9X9Mii5yf+Pmg4fE20i2erOMWubvItc8mF9IN8Lq?=
 =?us-ascii?Q?c9U3pCe1NsmRSkU/PbQNBWi5irRJ/zWjcyIuWmll7+XwcL1GdfuUCYwd1c7J?=
 =?us-ascii?Q?eVYvzIg/CmL7EN4Xu9pfFED9k9N5yuzHcjk0V4QmZ1nRbZ+VWukz5pSD8e6p?=
 =?us-ascii?Q?uALcm05w7b84E1mv4pYuloODs5mxwy1XnysiQGpB6KQG3fr2ro37EoKYGJCQ?=
 =?us-ascii?Q?FIBD2u9xtUxuDFxkvOMpPo9o0Es0Av5/84+InCAROFiHSOC59efnknnNOmnG?=
 =?us-ascii?Q?2dw6wRCuXnKNrCXpvbuX/w4cvTDkGoiEMj82KQ/m1pAXY6YDMNRju5u2qrBm?=
 =?us-ascii?Q?ngcshVCrPc/yTELYsD4iUo1JR7e+ZuMsM9Eqh1ZtaWKwUXsbMiGR+QLIplG5?=
 =?us-ascii?Q?1GhZmPyyG1lVtgiij9TBV0N4Xalj8Gpx6a3Lhp+e8OUDrNyuyUKCOWzZpTB1?=
 =?us-ascii?Q?3cqp71gMTMqF7rdLQFDzCf5bfOHETogDVLser/mPVrQDbGobEFxDda9CKPm/?=
 =?us-ascii?Q?2Tt2EjAwZT3CL/K0ias3pVFjpJOeSPEhc3Do7sII3gtrRqqrM6KCnTP/18gr?=
 =?us-ascii?Q?+g=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e137920-1592-4864-1b36-08dc42d2b9d7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 20:26:40.9270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2iK0/jfHOoK8kYsywLFepEt8Ho2tnDFlfajPzx+gNTS77K/KhzN5KR3xZMun1Y169YHM81DbDodUZa4/MFxWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10057
X-Proofpoint-ORIG-GUID: HLe2Pjeaag9fNKCKjiml7_kAxqXJ32f-
X-Proofpoint-GUID: HLe2Pjeaag9fNKCKjiml7_kAxqXJ32f-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_13,2024-03-12_01,2023-05-22_02
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
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


