Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94974CD128A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 11:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruVvu-0007Uf-IC; Wed, 10 Apr 2024 07:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruVvs-0007TW-Tt
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:16:00 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruVvo-00019V-UF
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:15:59 -0400
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 439LN4vB015436;
 Wed, 10 Apr 2024 04:15:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=iYRHkU1wThujbv/fRf6aDTYD/3SJveNk0Rs+Of/+2
 fA=; b=sCYrpJoNXiHUTiJJFE1A9UpBLbeWBgjkyMmGjAG7lj2VlERkoL/tvAjuU
 FhCOnJR6R5nItPP6C8Ih9hpu8qBZwGDAD88D2jrvspjzXPb8jG6wA9ikzxKfc9hH
 vVE+b4MfB2RBJe82d/9enEkugS5njboTmu2fvgtF4RZWiFOKZ+B4Xx08yZkDtOJX
 4NIvFe0yA4Ak/oD4Y8MXGquDzcrn2JZSYjQIhuYhy8O34yEANRnz9Fa4tLfLt9Tc
 3VHp+fABap34lGAbp62flPuw5RZgwzc5hs8Q0c9UTwZaD1oe0hbvo679pFgmmTKU
 0DfUBMycDmIliWgDdh78nFHnlIOQA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3xcvwy2v5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Apr 2024 04:15:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LolK81BmEqbPARMZrrJuK8Arj7N+VuICMRud5sPCcJMwmjF9r1EqRZq6NbWQQEyf99KRGyXBbEi+7RjcNFQBFP3yrQ+rRjrfDHA2a2yRzxyf2N3I2eIOB+jAwMKRDLDobPFpPqh4md++WtKq96uGJfLIUD+B/TURG2ZKnuh3aEezEyqdmyumuSi2heisL8PUxrbsK166Eiz+DQDFRKgCdG/hedoCeCJXQUkEsfQltrpSUcE0lkKmyXKlBoqBR7FXESAyRNYOxPxW17jDiGYYsdEFLrJ2K6v/QbGJ7lUnateoKqkRZg52Tc2D6PZhVzHPsVDSbGcg549c6d6BkZz9OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYRHkU1wThujbv/fRf6aDTYD/3SJveNk0Rs+Of/+2fA=;
 b=K/CskzcwDc359bzrinJEjOVJD2hDAxPYaA6U7yQ2lHmkBsCfYlX6YhzyoFyuLnY65quRnTGpY2Tc/yblE2ow8zBetD18WDyTE3hgm/Ty68LvNAE5CW/cT6ogvYvb8lQI0paqhC6IcMKWVOYLrx/Oe3LQPL6M9jbqk2Qh14feYs7DNc8tqDRulbC/WwIigTijGEnUbWbqOH4SZ8rebrBFNIPFgqm0LqzBenGw3gMWWGvDzEt3hi8j7RXtbSGHGClGOJiqXE+AIPoxvolDdDyJH79lgwRjzuBIAsAZNkAFvN31B1xExruzkV16pwKA954MYWU5L7+IKG+aZXC9J7eQaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYRHkU1wThujbv/fRf6aDTYD/3SJveNk0Rs+Of/+2fA=;
 b=wyzVfXVjEeugb19WTyrL8VEqHjPOD9s0yleX1rA1dQkTNDByzno4sBGRB6ls8LZpbFZrjinajSSYPJ4/4hvOKhHmJFRNaDMJINTQzRb1Q7P1BrcwWpH1iDbaVIi50s1pP2PGas8Yc9pl8F5TGRyDUpLe7no0i0gUqiFR5dZznYize54dZpHggRh5x27EuMWu4ZXqFO7iND0uzew5IbmLvYXT5VGgNmE+WL6T2Bp1BP6LNjZ2+wvQjA0SPT9iFlf6N9+7N1BOy0T3d0HqMxUjZ3um6dlKE6375AALtfju3grXepE7d16eNCp25jcFiqWBiujXslWL8dVHWXp1BUTOZw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH2PR02MB6791.namprd02.prod.outlook.com (2603:10b6:610:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 11:15:54 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 11:15:54 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, farosas@suse.de, prerna.saxena@nutanix.com,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH 3/4] tests/qtest/migration: Add channels parameter in
 migrate_incoming_qmp
Date: Wed, 10 Apr 2024 11:15:40 +0000
Message-Id: <20240410111541.188504-4-het.gala@nutanix.com>
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
X-Microsoft-Antispam-Message-Info: fd/uxUUh1EQIqAmWZ5EgeXAME1bxY4/SSt/q4PXetgcfaFx2UA7DjPWCPauMed6jzryNvwzwqbR7KFvWKy4qPtWK8OMi4PznbajFTv+P3XiEspuoaM75ZnNDwpI/N1NI1lxjuveEM+uUn5pRPpqhFztTBGwMRFiXMLREauw598ZNB8NnrTasRd0zKkhdsuk/K9erfBB2syLin0585h9WkAS4Fo+J3H2NWTpkNYpQOF/IlcsputlWw0F0bDKdN+/hoiPSndcrDu86mIoDrdFMZunkVMH/pRkkP7UU7/E/WOD7fq9ytRKHofAuuLk7sUToPZMGg10tOXPMbAMna2dRR25/KKOvHiW4iG+1eBiA/nFLzykjfkjeVlYj4XsNMt6Y4KnMR2FIbYEIkHCuncwDcJQ7iQwCGA6bld/YqZkGHKb8lEiGIZXuYDQTZtW5DWZLDUvnXG72jxvA3ufecJbNGINfzZj8s5LG52qmzOqTLyFAleSk84HS6KY/G9SK9lIsX8+iz0L2pnmQUzhgfBBOKHnoTkAmpNcW3CzQ5eHwic2exF4PzXF0kF/gOS6yecj762Rv52gTAkv4bL6fi8Ei7deCAkHRVtLUd7medRDTMtsljhL0D4SWVIL59/cq05v4uk9OycghyB5XOy6ptf6BT1NyqmLUf48ArKTKDFCkFlXVhYQYkyYQiPBY+3i6T1yJSZpMd/kdqgLO2I61ayI7TD7pIIvLyePYi9DtV54teEg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NnbSt8js8e7yHDZydK6Ygp36cGKKVal4FqgbGrhXK2Ijo8ovX2vfrL5AgMXh?=
 =?us-ascii?Q?BPmCbk2nhhSp/7IIe/kWw5IAcEJ1alV99gbv6XM9geD1Nbqf9HNbjaw3F2+l?=
 =?us-ascii?Q?w/oQltmHTDOas6sd3QeFWzBFi9U25N1MZ/sBrEYqXBgkP50U7YLEpSK/ZYKx?=
 =?us-ascii?Q?5OlOzINCljg4WcqwejxkXyqHvMTDEx8Or5axONJf/FI+VKM5Y5sc2YFOLock?=
 =?us-ascii?Q?y3SRUtJ+6B8swv5SLxCI2HmZ8IW2DtN2Jz7QYofdYNjconrkOOObujGzBKab?=
 =?us-ascii?Q?PdOX2JhduaGDvAES7u3KkPNr9Krd1AJnRqiIZbRGMtWWQSXhaJ3rDElYHHLn?=
 =?us-ascii?Q?V4KjTDQlGYxPQkpdMGI+PsYSjo0bmRzkC0Uh/z+2+DwfORq1bCuh2D5raK76?=
 =?us-ascii?Q?L0BtQaKBJv40yGgOjlRuFwSrzV/JB9Z83UJvv8BoUHqVxsLd26RX6AlZUai5?=
 =?us-ascii?Q?bbG9etIPVOmS5nu/rrEVlysNBqRjcsXdjDsIe1ZsYlrtrzbTwDZdkZyA4SSv?=
 =?us-ascii?Q?Y8wJGppuSsPnxUBNnMeMJwC8Vgdmm+sQj25bqrsZdlxhfIdIUFGRsWg9hp2H?=
 =?us-ascii?Q?kErfBfwKooCXSz+aClZ5Qhn2aOoF3LZgl6IQ63toTDmNntUyHxacGGXC+5X1?=
 =?us-ascii?Q?cQ1cPKsjUfU1mg17ZqQviR8LE8TpqrFYpLXeRhvAwkEo/jyX5Usbooss0TaH?=
 =?us-ascii?Q?xoFTRLUG+ZZhPeFKrXmPySJUgupO9LdJ2paCSR8CFNyEqlPVX5+UjGCrvkXM?=
 =?us-ascii?Q?U5VBH4uxbD5wBYk7ahOlh4p9siMaBlTFmD332ZAGCxA6wiBEhGV4ZdaW+T52?=
 =?us-ascii?Q?Bf8eNZvYy+D6oMwXQjmV3RLlYL8Q/95yoiqmyZeYzAo8zXOAhPuSJ4RxcMBL?=
 =?us-ascii?Q?9bMIDPuGWOKprVzPf1K9gEeOOn+Lb4CHSRB/9X7dATxD9F0iTw+z/sJzy0ke?=
 =?us-ascii?Q?6DtUTl06Q/Q03GTcpL+MmqtS0rElUIgDUUlqqDr/9LU9oF35VHpnu0GBltnd?=
 =?us-ascii?Q?AWwyPioEEp+/FIm5fvO2gn7l0DBPhnXbb6x+MMt3loqJa6VXBW70ND3Si7ZB?=
 =?us-ascii?Q?eBD3zLlyr/dBRKiZlViLNIG/jp+0zS0lKbr9zxJXjS7ng9pZrpYd7T7euVUI?=
 =?us-ascii?Q?irItSJZR/IlkC7fWaSbvY1uAny+kMGkf0Vg6DYtVFmKYlJjDkTzibcwJ6oFs?=
 =?us-ascii?Q?p0Nypi8ycIiV7g5DvevSfVKPYHC7uI4675hGr8pzVuK/31z2hn6S665kBY7q?=
 =?us-ascii?Q?jAHfDYtD24KHDjLOe126AKU5+e6TXw0mefn02MzIdw4JJhbZzRba+JlBBovf?=
 =?us-ascii?Q?rSNeOrYU/GLgYJ1nJE2+SOdIMS9BPeQ1JmntYtUISPHMxYvioWz2+q73xqXJ?=
 =?us-ascii?Q?G5SysX++K5r3ysDJNIJqzt8VI/rcHVOOZ64vmuhgLsPkC2rrlE4Cez+eIT2s?=
 =?us-ascii?Q?XhdGmSV6oTqWiWzP6p2OLXIx9KUvVwXUa++Nlryh7NCxAkD8rDoqRfQKLClf?=
 =?us-ascii?Q?TE1O0gdBLMlSFCtle+kOXwMb7pVXsFkFHQ26A3gCcbNexZ5bBbYcquPeelEp?=
 =?us-ascii?Q?Nfx/lo+iEmWlAy13fgYyEJpn3T5rRfBJbHE1GeA/?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 889f0aa2-911b-4c1c-1589-08dc594f9651
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 11:15:54.0028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kA+jDGcNqNd1ZHZrkDa9woGdzXt6A7QUT+NWpRhx3kiJamA/h7ERb2LQXF/zdaxnBPu0OR2shuVn2WgUwA/6iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6791
X-Proofpoint-GUID: 9mJDxOkyM0BVEM8v5XuWhAbgj5FYtkqU
X-Proofpoint-ORIG-GUID: 9mJDxOkyM0BVEM8v5XuWhAbgj5FYtkqU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
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

Alter migrate_incoming_qmp() to allow both uri and channels
independently. For channels, convert string to a QDict.

Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-helpers.c   | 13 +++++++++++--
 tests/qtest/migration-helpers.h   |  4 ++--
 tests/qtest/migration-test.c      | 12 ++++++------
 tests/qtest/virtio-net-failover.c |  8 ++++----
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 3b72cad6c1..cbd91719ae 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -245,7 +245,8 @@ void migrate_set_capability(QTestState *who, const char *capability,
                              capability, value);
 }
 
-void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
+void migrate_incoming_qmp(QTestState *to, const char *uri,
+                          const char *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *rsp, *data;
@@ -255,7 +256,15 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
     va_end(ap);
 
     g_assert(!qdict_haskey(args, "uri"));
-    qdict_put_str(args, "uri", uri);
+    if (uri) {
+        qdict_put_str(args, "uri", uri);
+    }
+
+    g_assert(!qdict_haskey(args, "channels"));
+    if (channels) {
+        QObject *channels_obj = qobject_from_json(channels, &error_abort);
+        qdict_put_obj(args, "channels", channels_obj);
+    }
 
     migrate_set_capability(to, "events", true);
 
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 1339835698..9f74281aea 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -29,9 +29,9 @@ G_GNUC_PRINTF(5, 6)
 void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
                  const char *channels, const char *fmt, ...);
 
-G_GNUC_PRINTF(3, 4)
+G_GNUC_PRINTF(4, 5)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
-                          const char *fmt, ...);
+                          const char *channels, const char *fmt, ...);
 
 G_GNUC_PRINTF(4, 5)
 void migrate_qmp_fail(QTestState *who, const char *uri,
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index f2c27d611c..fa8a860811 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1296,7 +1296,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     migrate_ensure_non_converge(from);
 
     migrate_prepare_for_dirty_mem(from);
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
@@ -1824,7 +1824,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
      * We need to wait for the source to finish before starting the
      * destination.
      */
-    migrate_incoming_qmp(to, args->connect_uri, "{}");
+    migrate_incoming_qmp(to, args->connect_uri, NULL, "{}");
     wait_for_migration_complete(to);
 
     if (stop_src) {
@@ -2405,7 +2405,7 @@ static void *test_migrate_fd_start_hook(QTestState *from,
     close(pair[0]);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "fd:fd-mig", "{}");
+    migrate_incoming_qmp(to, "fd:fd-mig", NULL, "{}");
 
     /* Send the 2nd socket to the target */
     qtest_qmp_fds_assert_success(from, &pair[1], 1,
@@ -2715,7 +2715,7 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
     migrate_set_capability(to, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
 
     return NULL;
 }
@@ -3040,7 +3040,7 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(to, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
+    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
 
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
@@ -3068,7 +3068,7 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(to2, "multifd", true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", "{}");
+    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", NULL, "{}");
 
     wait_for_migration_status(from, "cancelled", NULL);
 
diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
index 73dfabc272..e263ecd80e 100644
--- a/tests/qtest/virtio-net-failover.c
+++ b/tests/qtest/virtio-net-failover.c
@@ -772,7 +772,7 @@ static void test_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, "{}");
+    migrate_incoming_qmp(qts, uri, NULL, "{}");
 
     resp = get_failover_negociated_event(qts);
     g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");
@@ -894,7 +894,7 @@ static void test_off_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, true, "primary0", MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, "{}");
+    migrate_incoming_qmp(qts, uri, NULL, "{}");
 
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, true, "primary0", MAC_PRIMARY0);
@@ -1021,7 +1021,7 @@ static void test_guest_off_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, "{}");
+    migrate_incoming_qmp(qts, uri, NULL, "{}");
 
     check_one_card(qts, true, "standby0", MAC_STANDBY0);
     check_one_card(qts, false, "primary0", MAC_PRIMARY0);
@@ -1746,7 +1746,7 @@ static void test_multi_in(gconstpointer opaque)
     check_one_card(qts, true, "standby1", MAC_STANDBY1);
     check_one_card(qts, false, "primary1", MAC_PRIMARY1);
 
-    migrate_incoming_qmp(qts, uri, "{}");
+    migrate_incoming_qmp(qts, uri, NULL, "{}");
 
     resp = get_failover_negociated_event(qts);
     g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");
-- 
2.22.3


