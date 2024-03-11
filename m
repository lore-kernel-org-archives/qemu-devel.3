Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06CACC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 21:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjnbU-0002uY-SB; Mon, 11 Mar 2024 17:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbO-0002tX-VE
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:34 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rjnbL-0003BU-S5
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 17:54:34 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BD9aGj009722; Mon, 11 Mar 2024 14:54:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=Qdu0lOdUIKGAiRzLxxb8GL70Wt2g6cWH8JYSv6Mkc
 AY=; b=2uj7T7M6xkl7QSW1bnXIw5qjjcF0bRAqTguz9TYvYhir1LBY7QWUMTUwF
 gQEEe9CoBt/bfqQiQ47D2ya3NHKh04tuIF4oW2MzABvmIGFFn5q9Dm4Fw3xcb4oq
 1Q5CB54Xb5HnMzR/JqMX1BC2gtJi546PqJ9ShWRIfmVJaxwkjGaw4LP2Y2261Y1y
 pwdAfrez1/wU6LXon5zOmuVe4wxGqmwVvgmjocDBHz8mpAAoMOEogYG64BeEDLUz
 T4M5HWvxlRTtePlGsiXR/5e8hRaTEyMx3cvmQTYjnnZ0oJ6FNuihJLpeXUry8gwu
 AeYRFihp0h/CdAQKivoiS2yOplllQ==
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrqygmc7y-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 14:54:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYa+ybYndGrTBvM22HMdCqMz8F5IPj249q3q9GAkIEcrDShUtf1fQwgidHXgU46dTqIkGCVR82JWEjbLEyEI+diBbIAvp/J4ulQ1a9f5UpiC7/R4YmF+kh1t6o3aaf/NoW3ZscXuU1KB+xTo5+Qsaoe/QNudYQ9+qZ6+yplstrdgaEbJGsnE3GOouQrYyf1Z2wCQZhimzxffwICpg4Nclo2JyaFt/W53BnLfbKQov46/Jht5gXtKgQvHueXyFjJUYB1dZ+bjvMcVM0u1X9v3jq3RwPDYMnhGZexqaE2uxj4rBLxHByxfQziA5gt/uLUOZNz7Tvs36O3k8t80xg1NKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qdu0lOdUIKGAiRzLxxb8GL70Wt2g6cWH8JYSv6MkcAY=;
 b=a7MOklWlZr+1TAqu89ishOfMv25q2CNsgBSXloOQK+63B91JYKskkDZ1oqibJ8KfM8Rudj78bHSts64B6Jr/vM094L8VjGLL5bUUAEvgxkQEo7wcaMjsON0ueb8hl+v8/z2zcpSk+IhmLmQ1e5zjY4dvcIBESnHxngZrwxMg0SFU37PUdshEh3sd7FU1Y1y6rnk5hAmF1bPIiU686hb6wGrG9Qg25WyIuuYH8LCJmndSZ19fwiUNj4dQfZJEVDI/DRbgW59X6pUhDAEOiPEFkl9/s7+3CAKQCFiX4edMkVS0S7X1zI6okonHa3Ai1Q2SN0i41t0EFaNmK0OUN2xRFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qdu0lOdUIKGAiRzLxxb8GL70Wt2g6cWH8JYSv6MkcAY=;
 b=gave33ZJzEs2wnbSN7xSWYdEhnW9uws2CWxuRbj2m51ixYmPvkuyCkMRYKy1t+qDdXh0nz3VZW8oXcunuj21EY5wz3XcfO/XAH21mgBLZulV3joJlRjMxL3xasWh5VzEV/dnXslFZTJoDUeG2Zk7tSIRh0IYCq7BVtvXMdcbMIKx9iGaEzyKYEBOKMGfB7U5olXoE7KVTPwxLZA9EZIDe9fbpxP8pEqjkcKJ4pijjNe7XIxud9lihkxYbRPf2x7hY4yssww+qpvmolEAMRGhRalP6nbJuOfFnG3p/+/joqyOVBTHF9hpa9Zj7fKSiUMFmuC6ApqSuwlUu5hEu8Q2Uw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6849.namprd02.prod.outlook.com (2603:10b6:a03:20c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 21:54:24 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 21:54:24 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v5 1/8] Add 'to' object into migrate_qmp()
Date: Mon, 11 Mar 2024 21:53:51 +0000
Message-Id: <20240311215358.27476-2-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b7f6085-6896-4bf2-915a-08dc4215c83e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7GvQ3pnWbGis/R31fm+/rM66bz+TcMimGeSNaEFrmbIt5C/sgZglqzsLQRK2O/wGfNhau1WQ2/6XU7wmSO5hCz6xLKC0Z5W+Qvq4/FCB5nv0a3C8WpMjnA1oF9rx9Tcpc0WAJmLt1NlPGZU5FadvO4juskpSOkR8SkgwKQPAFFvLVWxDeGHFsO/bIEr7fGG8v5IcjHJJnO+8tjstyF7BJTv9Fae2m2h7adxmEq5jBurPEySkyveSs+ChTwY5BdKPS2NQzo1Ac+ZJCvl8ta0VIqJUo75OjyU3mIUX7R76xLspVUTBTlo2RBElEBIsMFavFfknlffHWdBBMK92n1sHMdclHxhvsLknYOVh3SYE+a0/4u+L3DGDQYdPKvbHHIp7p3GFHehvg5tmXspDtZMijUicgZCV7ABBWeWOdoN9ptEZ/8O1iJxubF5MRqs57p4XOka2v/zIB4kD9Aqh0DQ9sHng2vhAfRO8f0t3HwG5eI7Ep4uAMPp4f0gkuwtUIHv7ZT9gKJDE05bgCij/L8D4CmSGf0hTJoRMLg/ySTYer6nboJI8xJIBjZJyNjfJto3YSq1oQRIVXyHJ+cPh7IYYlqKbesyfZvNH/cRvHJqCdzO0HyvIln5KBC2Ulg/Z1VuFNrVxcR2f44zGiKaTCRBsCW1gWIS/UXcz0BV7ECoVDrsEqSQhJM9sc825u6JbiMNbaJh4A5Kb2V6Aui+6UPllNxJBip7Q35byTjQrGmK+Kc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(1800799015)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZjjQHU+S2lurTWdhcpgT4TORlxi3dFFBPf0Ul4p4Am/1q0WlHETzyb0abwPP?=
 =?us-ascii?Q?plVxHWeHY28PUuiGE/Xyh8lTToKUTpC88Updo9uWHkBrBohLOJN33IOoiJM4?=
 =?us-ascii?Q?0No3H+3azYPGrHI3fOIHOhw9rZZu/j6/gAfdMpsPxrFXYmkmuSrIPeettp2l?=
 =?us-ascii?Q?bMO/WelEUsSf9B2i1c+HXzAc4MmASOL4swjRlE2zMMA+jfSKR3YBcz+6cEQF?=
 =?us-ascii?Q?i8O1dJXib1rMnjAzL/nZ06MnCTndOmflf7cJr5LotKD2OR6vl6oGzTgwzchX?=
 =?us-ascii?Q?5v/z+BMMzMnGUMrGP1KLqcRbGZUhSfg9cg08M6fRI9jzAKeNcW1UutdEu1NU?=
 =?us-ascii?Q?DaN24iWjekWrL7xFba8DYgEx/zmIyC9wX6LUqzGrRPCBHmDwepXYcd/vZeEz?=
 =?us-ascii?Q?QmFp68gExG3qr9eKYFd/NZ+s+fKz7mHABJc+9zvPsvUyyIwqGZOSe+00b8BO?=
 =?us-ascii?Q?fMPv1seWNUFZBeqpCAU12di0nzjZBsLUU9hWN2mEogXpCKW5yzlTgk/E9xOu?=
 =?us-ascii?Q?+IB4UDuLglA9YKMEphD1iBynEQbXLMcVj5j8xJYCIgaiPrONZdWBBwSlXgZt?=
 =?us-ascii?Q?tI66SFDeCdidFeC+gosxH4a8sIP1ISQxNKdh0nISmQ49jazwygmxWRUddw9O?=
 =?us-ascii?Q?TCH1Vp0Xd/hxufPXv0bwoGGANMH245N09bxfvYnX3TuqOob3l2Y6uy6vmTZX?=
 =?us-ascii?Q?Ou5TPQndpuwumgX8XOEUKI2hXSJcvALl7QRQBfGLtpN0yJa5L9UuNCuyK0MO?=
 =?us-ascii?Q?KU/rZa87vqRED1kLck4JjeaGL4T9eVhAWD7kVE+onhYXoXrjlnqI0RjvtgM+?=
 =?us-ascii?Q?XV825KIETw7EQNdGhKgX9xBybi9c31lVSoVZikUVOzxdWbwF1M7ixaK6wGvd?=
 =?us-ascii?Q?tFP23RxQjPU+YAL6tfgtKYK1JgGdqP7nJ2KkrhXCOl4Cq+MXXl5x20RMr9E8?=
 =?us-ascii?Q?xpRzdK+sTIqth6fXBTZYGqF0fyBU16gm8lSZVIoyk9Idch9AE1kjCCqC0Y/g?=
 =?us-ascii?Q?yL9DsH8DYhPcTCOancVd/cZSQxmfGXtjAu5wMbdfAQOlFnNc73aelFGM9SSo?=
 =?us-ascii?Q?XWQDgkNTwM/aYC+Awys+mdmMTO2Adc1Eee3qHnx+uGQ4/GxZVe/v1GQSgAvP?=
 =?us-ascii?Q?2cDyZQgjrjhQJ/UufrJuWr4NpliBAV/6Zfv26I7rDVPmHRmjaGPm7zVQR1aW?=
 =?us-ascii?Q?x5eUi2joPnzKHQTwsvz9pMaG0FhbwdqMCPTRZ3+tQMLsScrFbbd4DW+B7RTp?=
 =?us-ascii?Q?JghzSfiqFnjVKdwOaXtBbVUTa1LEQM3VQwbKXRPUI9bPpLpGLL/d23EIrBwr?=
 =?us-ascii?Q?0WA68l5Jo9NMccrKRI9iTleW/ryocZ5zXIxOq98lFWAVv/w5J922RYK1k837?=
 =?us-ascii?Q?Zdi+ItYpm0k3nMW6SEZyujs6okCnQcWZTMYoImIWMdC7tLBC+V97aZvpphL7?=
 =?us-ascii?Q?ZQ87UNLoVnFfjhiYblZL406ZRDwVVy3caloWFsH5olUMD8XAtgt9dU7bHIZS?=
 =?us-ascii?Q?vNBoitw0ROVmdQ/0vSHGwPZJwoI+lXKG6bhG/7OxwS6hz2Se6mHG/q9RyTO/?=
 =?us-ascii?Q?ovlduLhRt1bV+y/Q/Drm39Xjvv3+ANDbEfNcLzMq?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7f6085-6896-4bf2-915a-08dc4215c83e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 21:54:10.2096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeYlYu/gBDvdssCsN57zmXCGj5VnJrIuST4x+dedMofzPS6YZgxzDq+/ZumVGkQfOdGYTaEi2M3IDK8eu758+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6849
X-Proofpoint-ORIG-GUID: Ob-b0qu9O3IqQjzFsAFd3kyZk452T_QO
X-Proofpoint-GUID: Ob-b0qu9O3IqQjzFsAFd3kyZk452T_QO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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

Add the 'to' object into migrate_qmp(), so we can use
migrate_get_socket_address() inside migrate_qmp() to get
the port value. This is not applied to other migrate_qmp*
because they don't need the port.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c |  3 ++-
 tests/qtest/migration-helpers.h |  5 +++--
 tests/qtest/migration-test.c    | 28 ++++++++++++++--------------
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index e451dbdbed..b6206a04fb 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -68,7 +68,8 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
  * Arguments are built from @fmt... (formatted like
  * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
  */
-void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
+void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
+                 const char *fmt, ...)
 {
     va_list ap;
     QDict *args;
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 3bf7ded1b9..e16a34c796 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -25,8 +25,9 @@ typedef struct QTestMigrationState {
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque);
 
-G_GNUC_PRINTF(3, 4)
-void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
+G_GNUC_PRINTF(4, 5)
+void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
+                 const char *fmt, ...);
 
 G_GNUC_PRINTF(3, 4)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 4023d808f9..d9b4e28c12 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1350,7 +1350,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     wait_for_suspend(from, &src_state);
 
     g_autofree char *uri = migrate_get_socket_address(to, "socket-address");
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -1500,7 +1500,7 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     g_assert_cmpint(ret, ==, 1);
 
     migrate_recover(to, "fd:fd-mig");
-    migrate_qmp(from, "fd:fd-mig", "{'resume': true}");
+    migrate_qmp(from, to, "fd:fd-mig", "{'resume': true}");
 
     /*
      * Make sure both QEMU instances will go into RECOVER stage, then test
@@ -1588,7 +1588,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * Try to rebuild the migration channel using the resume flag and
      * the newly created channel
      */
-    migrate_qmp(from, uri, "{'resume': true}");
+    migrate_qmp(from, to, uri, "{'resume': true}");
 
     /* Restore the postcopy bandwidth to unlimited */
     migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
@@ -1669,7 +1669,7 @@ static void test_baddest(void)
     if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
         return;
     }
-    migrate_qmp(from, "tcp:127.0.0.1:0", "{}");
+    migrate_qmp(from, to, "tcp:127.0.0.1:0", "{}");
     wait_for_migration_fail(from, false);
     test_migrate_end(from, to, false);
 }
@@ -1708,7 +1708,7 @@ static void test_analyze_script(void)
     uri = g_strdup_printf("exec:cat > %s", file);
 
     migrate_ensure_converge(from);
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
     wait_for_migration_complete(from);
 
     pid = fork();
@@ -1777,7 +1777,7 @@ static void test_precopy_common(MigrateCommon *args)
         goto finish;
     }
 
-    migrate_qmp(from, connect_uri, "{}");
+    migrate_qmp(from, to, connect_uri, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -1873,7 +1873,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
         goto finish;
     }
 
-    migrate_qmp(from, connect_uri, "{}");
+    migrate_qmp(from, to, connect_uri, "{}");
     wait_for_migration_complete(from);
 
     /*
@@ -2029,7 +2029,7 @@ static void test_ignore_shared(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -2605,7 +2605,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     if (should_fail) {
         qtest_set_expected_status(to, EXIT_FAILURE);
@@ -2708,7 +2708,7 @@ static void test_migrate_auto_converge(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     /* Wait for throttling begins */
     percentage = 0;
@@ -3029,7 +3029,7 @@ static void test_multifd_tcp_cancel(void)
 
     uri = migrate_get_socket_address(to, "socket-address");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -3061,7 +3061,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_non_converge(from);
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to2, uri, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
 
@@ -3394,7 +3394,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3435,7 +3435,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
-- 
2.22.3


