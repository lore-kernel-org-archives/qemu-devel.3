Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB64DC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4rv-0003Kb-4Z; Tue, 12 Mar 2024 12:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4rr-0003J3-25
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:43 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4rn-0000im-NY
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:42 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CBVurS027478; Tue, 12 Mar 2024 09:20:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=DtGEwYAi4oVRLd7aOP9RYQF/76jQEVXtPhA+MN7nM
 Qw=; b=VhvcB0lSkpJqdBO3JytlrLvsQlCtTf0OhOM5lBEWcvojaTphibw8AXtvn
 HyQLgym38xDRsrQhvQchO15omHaK377CnwNuZfe1sD+XW0bbhPjNumv/ejsnXxQy
 nXFnt7CoMqh4oPkLByhfLRWNfqzzTxo5jA75Mv7wrPwCTxnv6DG4+YYhNAcY6iIr
 zoWNfjYebMHM1P3K9Zws2+q0h0cL9DNl3IWxCnyrswLj0gG7Z1o3tNtBXFLj6FHt
 1knfhljOl0IUzNWqLHPxfwLRTk3n1ToH6cZkgLFjuiZxMrcc+1aC2E8St947RlKH
 Ywz3iCZuw6zoJ1j2dZKvHSg3vhj/A==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrr63pa36-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjTbmROxwhG1uV8sTW4axuMihD4B1OMifVs8O9erOY0rbmp4zFVsesion3itz6FX5X1v05LjkLq4J1U/WvOzhlgYrpvjtTB2Ktw6YXXJzOoaaysIqkWLW3q72puXmhvMceTew6PWa/4NIX1JQwB2bhvU4Wt2Npo5nJeKiEqzqLkAcI3brqDBi7f6Dk0rmO9+w58X4sEpFrW4lZO3eKOkIyIV2OJOS0wy9rDiUlHypB5rDmGsPNbBTku+wuLJ18wconB8NfFlUOa+n9yoA6c0Edb+VYyFGju9F8cjwm2WfENqKj+IDGn6faMbnzkhikuhGnKqHQqo9DUYkyvgVuiIdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtGEwYAi4oVRLd7aOP9RYQF/76jQEVXtPhA+MN7nMQw=;
 b=HTgKavRs9dxtvvZS2BDVcvDWH5mPhCZqYajfpAkKO79chgMWX1FT9Pudvp13tlVzeVWvY2JX93pR1kt4s/ds5awRnwu0ZxdClcVst+8fxz8Y7L9qQbq2FQ/Mse0OwRguv8xd0OAosMHBxj1tOFBpqPx4doTd3KUVdbxw3kCi2F90s7k+862f5+srI6nuliVX6R1qibkwhUWaVxFG0cUJefTwzbHzyw72zXkWOA+K/xIGeLtiK2bhlDtTq2v7rBf3fVoz4DTfkW/34Ni4ioQ4+lDgHeXU7YeL8T3bPOPqsXXXAh1qi/sKC6XY901B9uGO63Hrx/vhczw1SMfV37Xohw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtGEwYAi4oVRLd7aOP9RYQF/76jQEVXtPhA+MN7nMQw=;
 b=XF2+2fATd3so67ML2UdoQ2IJwXKLHZgAKs4ylP5o8uDJlHQYU3DV68/lT9iNBcO6pEcc+sXbcxnopnwD5V4S86RPvwxf6DpJvWSpbtN2y6GNrM/VXlCgPDdu8hygtPAFTu8MbNjaY9xEKsDaUYV37qSpEVpn94SEI9p8ph1T/w4WIGOHwEKwiQDkC6pCWY9L6gxI7gucBkzY7BAs0HMov1Qu2tx5bMdCjzeIqGxnhw953YoFRrZXbQWHycVICTsBWWjv/24RvqEy0tiqpfs/YhzIxilvqtax/i4nSUhCbOhOz2RbiTyb9wlCOxPCPG9ijf11wyMLCl+hot6/OAUyFQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CO6PR02MB7570.namprd02.prod.outlook.com (2603:10b6:303:a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 16:20:36 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 16:20:36 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 4/8] Add channels parameter in migrate_qmp_fail
Date: Tue, 12 Mar 2024 16:20:21 +0000
Message-Id: <20240312162025.44212-5-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6aafc45-1775-409e-ac0d-08dc42b0595f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9X/V91h3EXjNq3faPoQ9KasOF1URxFoF8zatLIzbNE5LBVXcrmkwxoKSxsFkMqw/fa154Z5XYZyxzJpCmistWxKYtivJviPCGhxrXiBIF+YORihBeQesr80B2zzJ6POBKnYD6bio5l3V07XD+pdrWayYkiIZuB/Zzp4AH6WgUN2llVcsQOD3FrTIsqBVzbHzCp5PVXP9QUcrMA/xEGvVPcv4BlaYa3BJV8gvtWAfXyHGx4pwWuwBa5yaE+d8fCwp/kH4DQgGd/SnlVtxzH0GlyOPqg7G0DHcXVoRAb8FdYrCOESRo+TE0pmhNGXOZQ/R5X7U7PPF99MxN8qgh4F2l8WpcHdDNiB4jxq+FrkIh7ltIhQFT8B24PzBmAgZitddU0FBJunrUODq3hNw76Iu6+Wc4V3kF8JlgNHbcLzYZSi0SebuVPZoneiqJ5NQq+IDQMtymsvJhpO8vVzEPeN7HpJ0IiAOtD35Fuy/GYfg+tMBXsuqJJciqZ2EDeDJNiaktGcDt6dZfMi3MoXdhNbTfRZed0xmexBpLJckiqA16kAlrZ1Iy1FoEEhywDVBLINjEUcXKIjtZLIfULC/q2JcUooASwetfzC+5kN22lD5YRwgSxyaR3s3VAIO5K4SfTQOYJyd/QZHx064RSN9uBJvGt1+R3EnWfQGks/TVz96Hhq79ghYlU75WVkabtiLfPC7UAx3BEKBCk2MD+kQIAS86YHjsGvDTWvTg3CiAqe1v5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mPFtGX7hwqPCIxMXIp+nSL+kVK2Cz/y9pHFVrsuPqfNKHUAole0xdKaTwFpQ?=
 =?us-ascii?Q?O2qjYDdFxR3qTVbQq8yEKoO+IMjhE6QX2admhjV7BiCaNZrNM85sdS/jp7t0?=
 =?us-ascii?Q?/CXI55jC6ZdO0nHvJh3T4iWu9uDb62P8QFWHWeMGUCA4gLSOwj66grHRfx7U?=
 =?us-ascii?Q?J1A12Yxe6/4FpR3C7QPvi6Fat4lVKoVK7iDkg3aYakKgkJrssWOfmndik8wu?=
 =?us-ascii?Q?4fp8SVs8JD6ajqT9gEZ4PpUtqNDD8t5RN4MRcHf2bQmgxyV+bw8w1wAIJHUG?=
 =?us-ascii?Q?pyQlYimdLkvLlFql2U86xscdapmJGDCk13lcU4913NbdVSlwPvflSyFPPbTx?=
 =?us-ascii?Q?lNCxeg4HXrGvAySwEhROc2eoMusx3V1NjOj2htDZP/1Qk1s+yafRD9PXh4+z?=
 =?us-ascii?Q?FGerhHh3hOgBuFvVV8/UGpVThY5CdB+UeClJMvLiWokEpsctE6M3Y0tshnFw?=
 =?us-ascii?Q?QPEAO97Fed3+QQwd8StW3Btx7yP3iw88uqN0C6OAEyQ8gPQ1AKpQbwc5p4re?=
 =?us-ascii?Q?rAxQhTT2+FcZ+Yio1J+DToIqdbv3LCU2wWzlO2oHvkQAGXN0ihn37l5zCbfw?=
 =?us-ascii?Q?hh/cW8ADA9Qp7FYgMU8SnvI+y6tneIN/qdzV4aAQnUm/1E2W6/b+edL2rBzu?=
 =?us-ascii?Q?DrmCu8a6flXAChiFRMRvl2TkcdsHRyT8IExcCBynJY2gpo7PFTCWCEvUEaRc?=
 =?us-ascii?Q?pcFwGc/1k9OB0ZbcsQ+MRKezYvW7KjyFTlEWOEIIP1w6yS4G9in1+ZBMC9+Q?=
 =?us-ascii?Q?N3ZFhF0SHbVJ61IYgIQJ3YEX08ftv30PJ7v0JN6cAkxtmUUolX4nWMAwemOX?=
 =?us-ascii?Q?Br5zPzQK3FwP3EUoNeXcMnHPLqz0Qy39jU/OKaj+GB64dbL39ZMvzIbZNj0f?=
 =?us-ascii?Q?yfMqABcT66pXH9YdDbshlQHtnwFpow9NQ7MGScXomaxwpI3M2ZYTtV6xj9ux?=
 =?us-ascii?Q?dQ3lBruZGXPusejOYlU1FlKSAAWS51NpGo1zN/7pVNdz0jCatmTEKbgglU67?=
 =?us-ascii?Q?34xcBnJfSCf1WinB5IzfIfphpPPq+yn/gNgCTI2BUP82jBz6Bxft7zFFhFSn?=
 =?us-ascii?Q?tctl5d2HTqUV9PP8xHVvRMVEonSYCiKPQiTW2Xc2vCRRMuH7uqSYgw7XSc6C?=
 =?us-ascii?Q?/MjzhAnFPk0HJMHEJixfgX7Of3g41vinXA2c89hkLV8UndXYN0TE2auB/tdi?=
 =?us-ascii?Q?Fe41o9Bz4s70PxVVH18UKXCLvbv/6q2yLe0VxQ73yUMbx4jw+W/4wyuOT4Zo?=
 =?us-ascii?Q?tFqnUV0QN6N69bU7klNDtcjhDhywLRUedVXgqlP1TAy5BH06R4SVloPyeq23?=
 =?us-ascii?Q?DBNotW/mrDiJaw/HjzajRtu81u1S2HoAa1R1MUCEfMdAXtVtxt4riRvHESVP?=
 =?us-ascii?Q?ehleYtaaAw0UiYessFKZLTAEO2IbWhn9tvfE676ZzI0zdBq05TlQM827vXsz?=
 =?us-ascii?Q?21nYdxY/AdbC1/eKy1LvFBc4j6a+zP1QoX7T30+Ag+LceXQLfYV7Ah3QvyWw?=
 =?us-ascii?Q?c5Z4DBFdQKeWfQNdH99mqUF6ajdx90x9dRYF6B8lzuwZxDBPTPTQ7ULL3MDy?=
 =?us-ascii?Q?C+9Z4LPiEOyRpHhl6cW+yhMG1RLIIvFkr2wpde+RigGH8zej6H1IzC+tfHgJ?=
 =?us-ascii?Q?UQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6aafc45-1775-409e-ac0d-08dc42b0595f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 16:20:36.2425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4z+ss51lEe0b6heaIs7oacO3ut4ce1oxMXyv3KiMA5PI9jt48s2ygcomKO2afy0Es7hl68J4noBJ3Sio4NMMbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7570
X-Proofpoint-GUID: BZjP_BNq1AaFkUk2w1ZAr96iBjkQEue0
X-Proofpoint-ORIG-GUID: BZjP_BNq1AaFkUk2w1ZAr96iBjkQEue0
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

Alter migrate_qmp_fail() to allow both uri and channels
independently. For channels, convert string to a Dict.
No dealing with migrate_get_socket_address() here because
we will fail before starting the migration anyway.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 13 +++++++++++--
 tests/qtest/migration-helpers.h |  5 +++--
 tests/qtest/migration-test.c    |  4 ++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 8806dc841e..f215f44467 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -100,7 +100,8 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
     return false;
 }
 
-void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
+void migrate_qmp_fail(QTestState *who, const char *uri,
+                      const char *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *err;
@@ -110,7 +111,15 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
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
 
     err = qtest_qmp_assert_failure_ref(
         who, "{ 'execute': 'migrate', 'arguments': %p}", args);
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index e16a34c796..4e664148a5 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -33,8 +33,9 @@ G_GNUC_PRINTF(3, 4)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
                           const char *fmt, ...);
 
-G_GNUC_PRINTF(3, 4)
-void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...);
+G_GNUC_PRINTF(4, 5)
+void migrate_qmp_fail(QTestState *who, const char *uri,
+                      const char *channels, const char *fmt, ...);
 
 void migrate_set_capability(QTestState *who, const char *capability,
                             bool value);
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 9bb24fd7c5..da4b0006c7 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1717,7 +1717,7 @@ static void test_precopy_common(MigrateCommon *args)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, "{}");
+        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
         goto finish;
     }
 
@@ -1812,7 +1812,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, "{}");
+        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
         goto finish;
     }
 
-- 
2.22.3


