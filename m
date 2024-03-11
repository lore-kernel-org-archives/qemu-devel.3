Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FFEC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 21:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnbc-0002wX-O8; Mon, 11 Mar 2024 17:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbS-0002uX-QA
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:39 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbN-0003Bq-JY
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:37 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BIALuq029947; Mon, 11 Mar 2024 14:54:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=i4RdRFaxUEsxSzTGZvX2O+moHmZD0N8FE2jJrQg7e
 CU=; b=2NJWmWmVrAffd9uGoMvzQ7z7gey+c8CDU+YQv5Lg4nBWvDgtZOJZr4Aw2
 +UuybfYYm2Ys9/sGQhD8Mwzpq7fWesXgeNHLJOnYBzxCuw0X1W7ILXtIzBHQpAc1
 ep6XzVLy+AaynEgcALiRMtshAWqdlBrnaujk1ALKbC0/t6PMUiv7mYXMMTHqrx9j
 tPxpfwKu0ie+zpD/jdSXmwFODXffrFmkl2PYONysWoKvBlSX3FNdXE1SPMs2LRZv
 l+Bj9fP1t9tklXXxcHOZoTIEzDWkd1OHeGZC1W/TCcceM0W1lhH52Rx02OPoqDaX
 1ZAEoJSDkwZOoLW9Mkb5lyrWCiyug==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrqqhm8d5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 14:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ita+0hUOMeOQyN2bdc93ttICwhd5xDwWAra3HE5OT5u01i3eQD2ZwY8ewBBbhNM8OFDaxlt3wW+mfFcBoIqCUs+uTHKXzKkZke0VpMHTGbC6GyCR2TgC27dNQR35O5bUjKHlJg6kKBCubgul2MWwt707IZWKabQNwUan2DehJCFBCBn+MaTQB3Z8DFrB6Kez05c2Xi1J+7/gJiypGh1xYMk6x6leWYr6P/WlzG1WUXTGlE+Q/uhoYI8g/3b2bnC4VVbRogwyOr17ebExTbx7PQpOiG/2+vJ4ZwgzwFxw1uNMAMDCDqIF8gP3NpNR1ZcUekfHC2YGHEXh9fkJGz0YCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i4RdRFaxUEsxSzTGZvX2O+moHmZD0N8FE2jJrQg7eCU=;
 b=RL3c4y8Cy+UB5pRw2dGU+WBL/KYGnEDoX6UYOgxIQX1rNX9X8nAyNyB9UbYLxeNWUmPVIjqGKSNZ3CkYlF7t0SunwKiaGwrBMXTW5GmyE9BH6kZjvwfZIFh0wRAOUjfJIMZjZzTkLULBFQUbNPaVco2X6jxfoTfXBs4tpzZNNUg7snI0+79LeFcFNBuEAeC51XA7UkaiXU1cx897maVlZix4pkd9slVWAe1rS+KDHzdhR3n/kS2d7BT1hx9Cxp6NhRLk4JdKTtfcC16xK7IqEW+acwth2OkBJfqJm9/GMekIB4moHj4ybMepmkizjTsKt7Qkj8QjBb4x69TIkrZ3bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i4RdRFaxUEsxSzTGZvX2O+moHmZD0N8FE2jJrQg7eCU=;
 b=IIguLs2G2hho2BN+oUpK4mxq4mwnV7AGwsNTkmmOjbno2IeqbQHxSFIgkACJIzJbYCn8sPS8OQCnqn+tXaIwx2qX4gk2Z5URe8YfmrJQ2vyft/W2ovISz1+FvzjPHfvIp/E5kAu7tE4F4rrQMroUxCxqkIwjvPp/RKqNbSBMp1Q5xVUfog8G8N8wcRngaR6DG3ffsswX3BQ0RCEz9hKj2bZ8ZcWeaKVZnfQrb5Rfd9b96dH/cxD+bjbZRFQPt0rlBs/1T84ygUW7ktSxPo6xTbwHVDvs2m2F+YTz1f4uYomfglMmXNDXxQn/Q/93S2VYGKVzyG0v6SoR5IAWPRFcWA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6849.namprd02.prod.outlook.com (2603:10b6:a03:20c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 21:54:25 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 21:54:25 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v5 3/8] Replace migrate_get_connect_uri inplace of
 migrate_get_socket_address
Date: Mon, 11 Mar 2024 21:53:53 +0000
Message-Id: <20240311215358.27476-4-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240311215358.27476-1-het.gala@nutanix.com>
References: <20240311215358.27476-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH2PEPF0000385C.namprd17.prod.outlook.com
 (2603:10b6:518:1::6a) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BY5PR02MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 0665de50-1182-4e22-89f7-08dc4215ca85
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3FIUjCb+VqGBVBOjwt6tTGB8TW4BgsJ96HaiBWmfNsZ69SBGDHpokWODwKoPLexdEvtlYaugG4uAcAUC36fuSTZkHwlxXGt5EV94NStvBsTLC+T5x83uddVKdt5xLDnCwYLCYN9uDNFd7vY0ea/eGIoZtRMveam9u2s6ZtnXhVZmOPrkoUZNv6Z0T2yP/dbDRmzBCcq0rQued4+9L9nh3RqVUGURl3V92wZETFTcSWTVPbNJaHI/S2gzJLZhdubYINFv61m22E1tUNOl7ZxzKZpeIB/1mInLvtw+FghRXf6I8zhMWxOsmIHFc4bVga5hGqNwrFzrfSDbaoLKakXiSZ4SR/fPelH9wjFd/e1nuH/E3LjWRKkRPr/QlLybhUAbyFuy3sVuwOiNOmB/0PbeNyy3y9epLMcAu8qiItnfZFoQrgEHQBiB8J9dDj2Vx+CfNjfjKhfnHlvqdXxC9J0I8J383H43wQOBAw1Fg44fOxLpLY1F5tUbzcqSn7vMx3V2RiS2mD0WpLAaVnbD75pncb2MiesnAQYhsKF4Du86vrN9duiEovcud7WwPProv+5Ilxiz1CZSmn3I9MuJo1xAS8KCouL9bj6kjuLdyiirBO30VQojXcHf2MYiiDNrICAd9W6N4Rh1/VJqc1jKDr8UABHEIt7xm3v/h5ASbzsCxQPkNpy1Rbl5Tct7RSWLaKw0Xc8WUvkcpbtdIBP42bJGVUI2SUMFa8QD4Dw12wU4ckU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bfUsEAR0m4X/C1Zp4pP30xMz8vJraLY3kY4xG7QZ5xb7yL1K3P1KVgxwKb+Y?=
 =?us-ascii?Q?+Vl+jsdy3YBwoI8j8xoSOHjNeZFOdAF9OMBJLL0yACLiekSUCZlFy9sZMfry?=
 =?us-ascii?Q?Nzu8E/0EyVgVAiJ9fX9wvvCbd4B50o63soc2P3ZPkMGvznDWPebdnpHGHrxe?=
 =?us-ascii?Q?9DHvlUWh1HcWKfT5Uy+hfIglyIRmP3UbIrPCsNcJydO4LqFFBikoEqwZ1b6N?=
 =?us-ascii?Q?xcZH2tU6X1d8lpkBBOATERpAr6ERZWF43IVVGF66JdXiuArmHY5+sVduRaqR?=
 =?us-ascii?Q?jFs6qIcEmG2v7QyONKB3fU0Dmancj09qRD4HP19UHvZxKinspW7QL2AX+uYJ?=
 =?us-ascii?Q?GaprQOi2CspJVnK4MwVaytPor/YGahvEY87/uT72pPRmhkItgQZZavuNV6p5?=
 =?us-ascii?Q?4GeVpu1Ab9r4SNAAVZXsdgBMr5mpRFLDNJQ2fhvxUTKM9wBNO5aglR+GBgd6?=
 =?us-ascii?Q?ic+46Vq8PzJJ4IZHpPng0Gwp5tvcReCOO300MfPzNwpwv3TuNM/KEjQ4jl0G?=
 =?us-ascii?Q?YS9LFuELWk2x5Wo2MmMYghXMwI1bu8tYOImZMdlN9SEJ2TcJYTkK5I0V/s8C?=
 =?us-ascii?Q?OF1ThvQuWwDqsZHmWBFQJC/I1hL1aQDNeC6paeEVpboR6mymUOE2X+34WBvs?=
 =?us-ascii?Q?eLlTlmRe+qcESi5LcY+rYLUfD1CcFrvDDnJ8DPoFqWQfcbuTWck35p6C2fU0?=
 =?us-ascii?Q?tLK4g97Zv5C6AlL0ZeREWTp76pVxPoY8RkiK7MkAcdhF2clfaG6cioG6ObrZ?=
 =?us-ascii?Q?OFk+Yvanmnu5Tmk//FlxM18EaLLjVSioJmkaV3fDlwCWxjYPsblRJOZ3Prej?=
 =?us-ascii?Q?CY/r9hVGkaZ6Uts+etMn6rFM9qlkghkw6yvdHNtI6EBu0/v/IdsPsA30Ni7G?=
 =?us-ascii?Q?Ps0GZsIdPIZvwUT135Ik9KsnGQKbeI2h3m2MBbTueg+F0bU9V9pcxFPzqA1r?=
 =?us-ascii?Q?ZIC8vhMdNqQy/jcNqvz4nAdq/Vmsy5tTISZgsQ9KDdZs3MrJTD5E0RJA64Wa?=
 =?us-ascii?Q?d2QkB2zu7TEtvUim1B2KStgHm7TKLtxClJdOG6jcYXjmtyC02xDC7UAA6fWy?=
 =?us-ascii?Q?+MHQEILzwjUJXej22UDcdGj0odq492RHzw548LuE4dQ2rZi3KyzHVR6pMbRv?=
 =?us-ascii?Q?tOT3NiswM9QKpHCFaxlPV0XO4dDsuxbTPO+8JQVE18I49Q2uOfxBtVOe68xj?=
 =?us-ascii?Q?YkMZqC04UunPAn2xndwqn6zynX3wkuG/bdcgjKldRN3+on+Yo2IKs30RFEH8?=
 =?us-ascii?Q?UN5oHW25EncOOMeJixWbknmXuRGaJKj9MacRqiQSGO5F4UgDWdSb4WKvyyxe?=
 =?us-ascii?Q?lobQ0V38TC/jwphoOghLY8k+N3YPCFMJYmFwo8NmqLmpc50xM9yFeeeHDTrE?=
 =?us-ascii?Q?cxhGtSrhlIXfuu8Qu9JBbEnCrwaTz4MEBsMU9/KBBp5hLen/vkd7FWo6YkGh?=
 =?us-ascii?Q?MH2B1xsFdaY+USyusBu06q7sIMJOQTmJw/ijKELpeYZ1oiXSceky0VzcTV/k?=
 =?us-ascii?Q?xpOnNOjd6UxLXCkJ+D35TMLVsmjUIejpXDwYzp8XY+lSNKLUuuFtwJJf3yAU?=
 =?us-ascii?Q?RnJvVJYo3i2QmhrkT8360uDzGh1vVFNmRlKcc6Yg8UvvloFK27k5VziftF5o?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0665de50-1182-4e22-89f7-08dc4215ca85
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 21:54:14.0173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bxUXZ+MQz7x2ZXdu6H7GDfjK7GbDW5qbVUWCFBeW5CWQcOjNjiJbLbx8LC3S89zAhvb47oEQRiWopR2ofdCZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6849
X-Proofpoint-ORIG-GUID: N2Yrn_QgdwIFmLI69kuKZespcJlcC0z6
X-Proofpoint-GUID: N2Yrn_QgdwIFmLI69kuKZespcJlcC0z6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
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


