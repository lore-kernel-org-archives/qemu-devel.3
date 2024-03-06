Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846C1C54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhoqs-00065x-PV; Wed, 06 Mar 2024 05:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhoqr-00062M-4E
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:50:21 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhoql-0000BP-GQ
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:50:20 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42601jJI011994; Wed, 6 Mar 2024 02:50:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=AxfJsyoAaQGqnvSFQ0VUM51frhJpCCmnofKwbnNyH
 5Y=; b=d0I/nfFa+JsPjlA5fn2AAY1I0nyzRPoTfUlI617I2sD2/DA8cU0i1gWFi
 gp6Ky3jwBvkNG6o2FQR0MGRroMTxW1qxeQur3bvy2cyehxVGT2hCs0CXC8dh7hvg
 baO2KKJREbxnS5I/t/D7Krt6GG5uzh1D3a+vxeZdjaLrqXuKYOJZN/etNsJrS+cP
 h8HztU3YbPqpg2PbIsFnnmcdnTvdUKv4rv7h6Keeyvk1LwN9o1RRvPyCAJEgBLoW
 wYU5YDqbpo21NfCf6Z6N8Fr5qECVgcUY7eF7XfStNTMXjvUxT+nJk20qaiyzZzpF
 TRwub6VfX7GzNtEjJAFNoxiKOtsAw==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm1avrphj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 02:50:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zy2h/s9AKVWtBo3OKEULbu7Ok4WNw0UZks43bfv4EI6uDZor+U/h4IgXVDKAB7kt49jow5sjQAeLrEvkmWYvJdfyYHkMy51ij3+Urbw1D/p8MBclIALK+Jwv46Zz3Eqs2H/9yV2jMvvhKWhs5PjF3JRlgERCAczjtE/BGe7gMEQlbdUI2PlePan2ZapslE+YgRwOviX8GPG5gW4lqfn5JeyRrkKgrbOmLX/ZtT51PTEi8SXhLV98ibO2OsrvUAKLpJu8oOHB4fMq/v/kv3+nV0Xtg/JAqywpSQF3QX2ukZcofGmktX1gA9Iv9KRNKUjQIPMPdsNEJaAm/1iognnmpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxfJsyoAaQGqnvSFQ0VUM51frhJpCCmnofKwbnNyH5Y=;
 b=FevMCeS+IDAObPjIYD+6bhjNT7639McNrPv+eWsJHlkVMOsjv1ecnyLz+zKfdsZS8L/5XvW7nKIbAsbSrUoFA3cSGUu2qiOOqHZlHhzkj+em28oYrQgy/0rQAcKotxtgbHlPzCW66jtRGwpzhW0w8kq/B6TmtaOq5ZAWwYDyOcct8TmJYA/uldTVrycjKfSk1QAddr9EUhupT+WDQ4HylYaqFbutDhTIvk6JZLW9AJp92Km+Kd9wwX8PLBxGpOfftQjKaoUpTbws19vMOUaAR3ThxIWCYasrnIGXTh4JDfn/sJy3fuZqAezJZ5UK1zDDWhvH2JQJur2qNuhcM3z4JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxfJsyoAaQGqnvSFQ0VUM51frhJpCCmnofKwbnNyH5Y=;
 b=hbbGV2YywFr+2ZGxV4o0s0RXVMn/ff2UkJ7Xm0SzfJ2JYCOtr8dQ2OO6MmU2C1jmI4X/bWcQMcyhPcMJiccjrDmCqdnYk0zR9kE1mRHGlwp36ryFVHknwAUEycZ1SbQ/n1D3xdaWeL1QYtZURpss/qJtyJTSx8kdFBvuOyNmO/3mI5F1lSmoq5rCLV8YOlHaSdg9EjLfe/t6m4F9B7+FcM7kMI3NBAHfoKr9/ginqv13L9+yLJ6owRAJRXxrkhmrrd2P1zbl2LJ6k4kb+dPpON2PuAGNiCezGWQDbUL+Z4sGOCpmuB86+ydFSN6mdlag40uLoFo63qaX/n/MxT0jzw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CY8PR02MB9594.namprd02.prod.outlook.com (2603:10b6:930:79::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 10:50:10 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 10:50:10 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v3 1/7] Add 'to' object into migrate_qmp()
Date: Wed,  6 Mar 2024 10:49:52 +0000
Message-Id: <20240306104958.39857-2-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240306104958.39857-1-het.gala@nutanix.com>
References: <20240306104958.39857-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CY8PR02MB9594:EE_
X-MS-Office365-Filtering-Correlation-Id: ee264850-669e-4122-9243-08dc3dcb31ed
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yHQpmF5nMLWd5U5PxuWIlHPcJOE4GQAAqpXvQu9cK8dGWjAqR6XYpOQZ7y/Mpxbs9LPn2I6SjosEiSBPgHr/zzGYYGGvEE30gSsd4ic37YAC3FhG9CF5Rb/Nej0WsX6ABUg2zXdC4nYAvAWOdzajtMHQFcUlf4yiaX93l/h6XKa5FATMs3HTG0M43kxEWuC7rw77XEnL6KSSmmT50SQzqheg/FZI9ESJbYJY5M7m3FyPtxc2FHOHyNQTtiAoWRzqqxKTVcK1X78bvJUfyBN87+RX92hyaXUnJ62x/AIH2SFKYTzE4k0HW7M/nAB/aVv3Ztrs/Nu1JrlMCLTkxlfxp3QEOvkmrizlQ0j+Kzj489ruWKDSUOJiqMSmtF0boOJlXrvHl1k3lKefYUkWrejaigA98QJghQUUBqrXQ9UGsIrxq+pOJwPqOsb8utYGyU/bS7Uy2XFjlEx6xYrJblcVqPF/VbDGp0Vqs12nGsgVawyJpcMbcSrFkvL5gUGP0TAv+/8QGycdLWK/j9sCzGrHlw6rrRm00VaMLac3rw0e4HequxQ6qOQ7L1AOK5VVGhyO8n5DCNTHtU07JWE+4/HjakQsQRQmJ7QtnqGVbZvZ1M5UHIvwWSqts7x2uB2RsrYUQkWgEaQeUVfTA2pB9vmMzf3y/uSGYSd6fquo12iwyxgK+0S3zlY2JOUmEpQbj8xzp3OU0Qk0SxtQfdqrRacGOmeaEr8WcoPtx/nGJsLsRBU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vEl1Z9pPwU7dh2RTY6EuFjxvMAZk69YGRl4tuR71nSqrcul6AUQ/Xob/qBOu?=
 =?us-ascii?Q?+eDr+J6f68f23zoAeaiQGr/y2iBHoJCadym+8wYQOYXsNutcF1T3oO0CXvUP?=
 =?us-ascii?Q?e5o7Uf5DO8ciLqgwPuPat4jO40hBK20gw6/rRUksKJEJ1xegX9nGgr8GOWdt?=
 =?us-ascii?Q?IwwsPaWli7M74acvPY/9l5YfUEqOy0XM+sbAkSuawG4bnLGaqJY8tWph2fB9?=
 =?us-ascii?Q?kVSIcu9ErOMD2yfrFLL8l7e0loHt/lqPsilGDwLzmqvXVWLVJNB+GtmhOrR3?=
 =?us-ascii?Q?5VzCVz8ldFdDdm/TINo5NxDf5jSJuO5c2/kL/d2Z2PIKxDuiS6b/fRO+p3sT?=
 =?us-ascii?Q?PhBpsaXT7KMgo0C9dLPEBGGwLtFGaMly5h57kftCzjKNIpxNWikxxJrXFauH?=
 =?us-ascii?Q?pir48x1coyaxEuJJl458CnfruG8kddEQgohMuR95QcXo5FRljQ9Z42zSHxrL?=
 =?us-ascii?Q?nbCO67GNYpCBaFVfEOJG1ZAoVIsd2IoN6TFmR0iA4iR9OPwYXa5KST7BMjIw?=
 =?us-ascii?Q?hxu/SgltCoHh+hxE0Ac+O/BM3xyZupWYakxwZwYjKUSv1FhsfQc14acwS60p?=
 =?us-ascii?Q?oHC1NoH7LXMfKPFNDtBjmdyHNwG4sY05WKDRIaCWpXVZ/617kasbLY9NjITM?=
 =?us-ascii?Q?ghS4WXiO0Kn5O++gTy7uradvpZH4y9gDufcBXCVGDeaHtlKswyKWuIja/YpV?=
 =?us-ascii?Q?IHAQwZyeJhK2eI7FDtDeM7urxJv1zJEyV2fspLISVjd2DH9crOPDoQBDIhJW?=
 =?us-ascii?Q?Wcg4dEEv7BfEWiDXtNVCl67RXNGA1xlzmS1wnttuXYLttoVtwebRo4XNF3/o?=
 =?us-ascii?Q?P+mKpiFfPLTpI9OP4hgXrCiyWgghauwNwD3EYI2IuEXG5XmpKPf5vCFA2vTF?=
 =?us-ascii?Q?usETkfSpFn9lvPnVikDHjxOq9sR9DAkLVH5LBQ2zdz6fKl43BAORC42kAJFN?=
 =?us-ascii?Q?UYlqV8F8H3eQcDiOD0eGK72NHA+NxDwEd6+Aks10o09TG+I1I/HsTxMFm5Hy?=
 =?us-ascii?Q?m5M6l1fw/j5th6tawqXAbRiUQE1AUAJRAn0yJKbhuwFoghzWJH23cv1MlYIO?=
 =?us-ascii?Q?kfKae+b8DM/K9nVijTwtcBpP7jnVRYBNpdH5PIruFR3qKuaDC5qY2f6EoSm2?=
 =?us-ascii?Q?+BeYDL0aiTPRDqW63/ZD/+EX44Xe7UWCD3bar19trs6rxY49NE16YPP8bBaT?=
 =?us-ascii?Q?xpS0GbDCTsUF0LiG6r2uKh9wv6+LJBP1bRnAqm/DuM8FbZ+ImtrEhug79wx7?=
 =?us-ascii?Q?YvNDuHOLUMbF9DTdftFdBP27MFRBPrN4oATrc/9dSbTFvGDC9JckfUvR9bXR?=
 =?us-ascii?Q?4byrvzswe5ZeC4tXUq5h9yKPSdcPAXfZa34WQksmlj4pOGv9H/ocxbhrlaK9?=
 =?us-ascii?Q?fsDbRAdYjg5q5lANNbhr9c5uXsLMeIj6GeeKNpSTE4x7vS1l6Bll7f8/+ZUm?=
 =?us-ascii?Q?2n4kFFfpnTt1my8nW4Ldod+4w1/DRsBiJb2nkH6jreDIaRT4ky6azL5Kn+px?=
 =?us-ascii?Q?u+7uS+WW0VsxPS8eO0I8ckfIjXkrZZ9Mbxuwet/2kwJlXNE+68duyhfOfS/c?=
 =?us-ascii?Q?t7ayOIE26+hJT4rvpI9RWLDhSclrMrp1hQljddkr?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee264850-669e-4122-9243-08dc3dcb31ed
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 10:50:10.6127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tO6DNLa+MCTIhqcsJX8kzOglfwpSC8+p4Pbn2ReHbXcbThzcF3P6brbnI+iFlM3v6YNFjNIFGyqZDMPMjNgpCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9594
X-Proofpoint-GUID: o8Rm1OyLVJ9eLdPENrS8-MqYki_kQjhP
X-Proofpoint-ORIG-GUID: o8Rm1OyLVJ9eLdPENrS8-MqYki_kQjhP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_06,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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
index 83512bce85..f645ab26f2 100644
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
 
@@ -2494,7 +2494,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     if (should_fail) {
         qtest_set_expected_status(to, EXIT_FAILURE);
@@ -2597,7 +2597,7 @@ static void test_migrate_auto_converge(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     /* Wait for throttling begins */
     percentage = 0;
@@ -2908,7 +2908,7 @@ static void test_multifd_tcp_cancel(void)
 
     uri = migrate_get_socket_address(to, "socket-address");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -2940,7 +2940,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_non_converge(from);
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to2, uri, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
 
@@ -3273,7 +3273,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3314,7 +3314,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
-- 
2.22.3


