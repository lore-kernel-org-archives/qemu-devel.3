Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13704C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 19:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpCdT-0004WY-SB; Tue, 26 Mar 2024 15:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rpCdS-0004W3-Q5
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 15:39:02 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rpCdP-0006eM-Il
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 15:39:02 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42QHQwIT007858; Tue, 26 Mar 2024 12:38:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:content-transfer-encoding
 :content-type:mime-version; s=proofpoint20171006; bh=gcde66LePC4
 stD7yMaQnQhGMGtUN2CGlpinOxj9qwV4=; b=gXTVP9BNtX8asKRjhbiW1KUuH/J
 c6eb99qpPE0voQS7Urmn8IMQS0YsPC++9rFYXtwlGkpvKN1mkOHb8VCTK5mOLIOf
 32M6s/HxQwo+XG8w4voUSyZXx5OtVXCfEaeCKxbqeGH6Qc7/gfnVTaoRlfPsrL5W
 18Qc0axfdTKkvbU11ylcb09P7JRcNAskuim5LmxicrJz38UiA1kcxsSqXYfAAXh7
 xTBj9pcZzv26koOAmBTsxNbr+pgpd7ygvNYWeYDo9lsIPTIFET3rVbhyZTV53/GA
 sEGml+2Gghaa88IxECizw5xQvj/ssT9DRWOBYuXBIfzG/5NaRoGzNtbYY5Q==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3x1x5eenea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 26 Mar 2024 12:38:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8BY5TJXGHshBOdYNidGjg/vlVzUZmNV9MJHfeMW9EmRYxccuzujvMP2zCpsJ1tAjoFefwbOOOWbQdVafP+4tzVTuO72buTMKJryhVEaKQ588BB5+3fLvQK20mfi8He3SrVH2ICH4CAXHF5USZ0l29u6XIkQrn7G1ZK6s1PsokjLZY4rsyP/ktFGRDJ8FJOHq1uObu89SwOTMXzeHv289H0+WtDeg8vzg63XzqKvw3e281zoAs7thz90NtJ497s+2jjh5Tzuwv5zvgadVjncujpn3NKBiDNQ/hT1lDG2Zf5Kp7UUMTDZTwBUpx50yFHgpdI2RyXOurhmp2CdJI2/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcde66LePC4stD7yMaQnQhGMGtUN2CGlpinOxj9qwV4=;
 b=mzJgE4PvUeibNuggUXTRFty3IukhoTNRoSIo11c4sDYSdqC/qPs87y3sruR0f9Dt7O+A1mWxXMDGmJIf60H/cuP89Geq96xycKz2GhZXaSV/ESV+iStcaalnZGcEKc4t0lJ+y51QKasIWExnag0mYPxLJnFRRqORG5pkLXLdGERz7drOV3lLu8fIeAc6OpuWIwvwTchThdWNhFncL2NB3cZCJY6aAUd6VoIrIhhn4Ymu53eVN1JXVQBqTXhtM6H6NJ/bBRJGlNPpoUv+yDxfQ9OqpGyi3+UbNSQm9Jchkd3+nU9/IoHbDOkr1EY2ME8fBWTOTCMvN4LmtnPNf49yqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcde66LePC4stD7yMaQnQhGMGtUN2CGlpinOxj9qwV4=;
 b=WXypaiQ1S5b3qKCmkizsL6I+jD5RY2JgiaC7lh0ZmHkU51/9CReDTpM2NR4u1S4tKAn0RP4zRYGzXwX9/oFOMpWEq1u3tF7lVVY2RDp7xoXySig7JSUsjvMALuFczbsqHXoKecdCu9J+bJrM32a4aDXhPorA/wrUqvxUelwkG7l8+dWP6JGudoJgIfl3GPewL4FUxfU07IiqcL7VALdCHRWWP7WGVBh1UMNSn/m45XjMm7eH0/aWWDmZFbzeVOmWytXCvpPGi8dK5s9TO/YzNOrElWFFw2NACXay/iVOCI/4kXKnZLPJDRT33AaryD9U5VZeZiFMHxUBAz5YyleU/w==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SA3PR02MB10115.namprd02.prod.outlook.com (2603:10b6:806:398::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 19:38:51 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 19:38:50 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, farosas@suse.de, Het Gala <het.gala@nutanix.com>
Subject: [PATCH] tests/qtest: Standardize qtest function caller strings.
Date: Tue, 26 Mar 2024 19:38:43 +0000
Message-Id: <20240326193843.8444-1-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:a03:167::37) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SA3PR02MB10115:EE_
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JETBCx1WdPdDpDfioz13ifOldWoSz7SPeoDUVE+eCruVM1j4fPpwVzfsjariYXH0DDfhGoJtrHVhCVEOENWk9R347VHsRJshz4neYd0683pr4JlZCRLjL6WX6NXNfdRgBU70qPKSY38O5XjJ92WSrlx5ODt9Sp8cn+s2uU+F1oV4NC+YWPD0EExbflPGecr9rPXCtoA5UHa0pshE9mScuNpq64/+KUiSGUkWg5XRllD7lD6M+UkT43qH4GdUMwh8JD7GIY7J0XS6ItcQnkbkexbci0TepxXqgeEjgOAyWZPEXYA2gWYgCmg/7pP0+JoxxM1slRSg8vvlQRs7w3O27rFdHJH0GyvliqBMCJjOkrhV2CLOvXlekjfgc/OhlWYdUX/oOkQe3+rNytvh67V/HVPrNqF1bfOj67DB2dtR7Z3K8TbvKioDkgnSL7Pw97apuBzIw3nbHwH12pSncVqESU/WB4TrZE/HGMYNYpvvRoMtp2FNZjump+w68wrME6RceEsrZuGyDM4GcqstFlwfFeAQvCSED2VCZmb2Ii6DeOQshleB0k8q3bVnxL8QUEphKz5SXT7VRAlxrHkAfZgHffHVd5NR0zJFJhZW8c1KVeMYPRHkjvugKWKE7ZCky2WZ2vWV4xG4Dl/2JAkIbYdVg04YWLN7jGAx3gM7W57QvHC+wfrF8stS4F22ZfVWwNviWtMKa4DwvbVXcaWIk+Og4+S+jRBo4gb2oJ8OPswfQ7M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7WHbgJ/ED1ZFJAmb20O2WRC8y/xpmnZiydPuY0QZWdco4e5LwZgSGMPuR2+W?=
 =?us-ascii?Q?J/EHMbzRsyaUopyEN2LYftDkgiSh/CRHLaIDAA6Up0kGIP98pvwAhGQBDHEk?=
 =?us-ascii?Q?auEh6ZWkS4MgiBUKoHJXAb7UEFOPjUMdPvGZb8pNzIqVg9Wt6Om901Tiv/mV?=
 =?us-ascii?Q?uyazEx7N8PlX7fXHqGi7M+XcUAuWOmab0psnRHorjQ6ZvQAQxN50kE6aapFJ?=
 =?us-ascii?Q?uBNPuvb1E1kqQtGN5O4NKThnjKZ2a1nLcOuMHWXOkqlwhWM7Vp2ybc3TqOg+?=
 =?us-ascii?Q?l94SEOPAi4LpFkb6cC/GO03uR7iAIhYO74zJ8uAOMJbT8ONuFnCNcTFoczhN?=
 =?us-ascii?Q?z1WOa+kyXJ9+SKMmglJoPUhtdwfF4GLNoR5VjEMw7xtyUYpKe3zMOFih/hi4?=
 =?us-ascii?Q?5/BaqgEeofFPBExx5rm3VeaKAyB0acUC21dZMy6fVzhNPA9In2Qay1DoyRdu?=
 =?us-ascii?Q?AEIUycOf/+5mJqt4KrkyIcguRxCHOxPoQL5NW7hnIhQIhX+lQ7+sRtbQ7reV?=
 =?us-ascii?Q?xKsoZW+iqpEAChCj///JIb38T5RGPQnpaMbZdD9jdFIoaBPc6TSYwYoec1MD?=
 =?us-ascii?Q?97HE/csKVCgqNYKzMwYbwA3/te5uCJrUwKaaK/b5e4lnGIM/2uXd8YIe9BdO?=
 =?us-ascii?Q?b1ZBXtSPC3qDLpoiznySj16gqxjeLy4WLPF3gbmLGk89Y1D//9S2B2vYXT97?=
 =?us-ascii?Q?vhgj60yiYV4c3QbqMxjX59XgD4Hd3i4Y69bGGLW/Waghjm+GrG9kBu5bmHEf?=
 =?us-ascii?Q?KKujSxlmWfqIdH8fTu2zJCcMPhiCtYdLMZk8joACT++3sHAmhkfzqFmSHPQP?=
 =?us-ascii?Q?BLv6SII8j9JIkhkcoiW82BobRgdlw4rknHlrsPFhsECU+cCO1DkeRejL16rc?=
 =?us-ascii?Q?u5rn6OGumyr4N5dAMwEDjpn7xZkhBNhhHYncJG/RAgnUtUg6mj/9Dh+fMsjM?=
 =?us-ascii?Q?XbJ8Yi/NxyC/foY4UCQN+VoZAe4lnvMvPesHXSO1x4shGMWeB0DrZbbcSk5H?=
 =?us-ascii?Q?eaNGjW83PanEkhSaCSVc8ECxkeM31+3XjIW4IYb6f1V59o4CIU/+HjJOCKUB?=
 =?us-ascii?Q?5h7rgqL68+GaCHJN6Dcdxt9OEHGUv6QZW/sSBM4do2HUMCsxnmrhvVbehFrH?=
 =?us-ascii?Q?gzb745LFlt0TSU51bpovHyBa6fhLnLVlDDtbCfzgOVamsNO0PYDpWQtvN/Tp?=
 =?us-ascii?Q?4boXPJaLUJ9040ZRry93h19X0GaPtgfQ24/QUrwaS7Qty0JBICJ+/TJtes49?=
 =?us-ascii?Q?TKElOWeDvQA//mlo5psvWMDPWnBFfvXx2xL02hgy+G5dNWamBQnHImgP4TqZ?=
 =?us-ascii?Q?pnhqPAxf7j7pW+lLbe0bCYxyBFAL9MFwBJpgYjZ61Ru/jMLHqs4jF1wu3khE?=
 =?us-ascii?Q?/u86Ti37/4VwJZzYfIPRh9ao8CRkHDvVmetSWYTAEh/XsNmt9wCWXYk9Ls3/?=
 =?us-ascii?Q?t1HeZTzhmxKEhSEhpMoIUbayLnnqhfv59ZBR7yVXioI3/LKM4vhLn+eW6K+W?=
 =?us-ascii?Q?JBPXZp2XEGgeoxEj16Ia205DFpzsTFZSzvBOgAb/OsWH/5qQUnCcq5GQuI3w?=
 =?us-ascii?Q?qUfaVEjFqFccYEPH69L7CU+o5Trgl8p8Hhric1/Z?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c34233a-15a4-4bee-7d68-08dc4dcc5cf2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 19:38:50.9182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZEhh1Ug9vUPnoTTy794NP6lGEavKP288KHYiCikXgTyGBKl6CcGdFe6bSFUs/uUlHe92lSr6KTLfjf7n0jVvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB10115
X-Proofpoint-GUID: YG5JWtiL0rbsA_SjSNE-nkcR8x5epDPa
X-Proofpoint-ORIG-GUID: YG5JWtiL0rbsA_SjSNE-nkcR8x5epDPa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

For <test-type> --> migrate
/<test-type>/<migration-mode>/<method>/<transport>/<invocation>/
<compression>/<encryption>/O:<others>/...

For <test-type> --> validate
/<test-type>/<validate-variable>/O:<transport>/O:<invocation>/
<validate-test-result>/O:<test-reason>/O:<others>/...

test-type            :: migrate | validate
migration-mode
  a. migrate -->     :: precopy | postcopy | multifd
  b. validate -->    :: (what to validate)
methods              :: preempt | recovery | reboot | suspend | simple
transport            :: tcp | fd | unix | file
invocation           :: uri | channels | both
CompressionType      :: zlib | zstd | none
encryptionType       :: tls | plain
validate-test-result :: success | failure
others               :: other comments/capability that needs to be
                        addressed. Can be multiple

(more than one applicable, separated by using '-' in between)
O: optional

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 143 ++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 71 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index bd9f4b9dbb..bf4d000b76 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3620,62 +3620,63 @@ int main(int argc, char **argv)
     module_call_init(MODULE_INIT_QOM);
 
     if (is_x86) {
-        migration_test_add("/migration/precopy/unix/suspend/live",
+        migration_test_add("/migrate/precopy/suspend/unix/uri/none/plain/live",
                            test_precopy_unix_suspend_live);
-        migration_test_add("/migration/precopy/unix/suspend/notlive",
+        migration_test_add("/migrate/precopy/suspend/unix/uri/none/plain/notlive",
                            test_precopy_unix_suspend_notlive);
     }
 
     if (has_uffd) {
-        migration_test_add("/migration/postcopy/plain", test_postcopy);
-        migration_test_add("/migration/postcopy/recovery/plain",
-                           test_postcopy_recovery);
-        migration_test_add("/migration/postcopy/preempt/plain",
+        migration_test_add("/migrate/postcopy/simple/tcp/uri/none/plain",
+                           test_postcopy);
+        migration_test_add("/migrate/postcopy/recovery/tcp/uri/none/plain",
+                           test_postcopy_recovery);                         
+        migration_test_add("/migrate/postcopy/preempt/tcp/uri/none/plain",
                            test_postcopy_preempt);
-        migration_test_add("/migration/postcopy/preempt/recovery/plain",
+        migration_test_add("/migrate/postcopy/preempt-recovery/tcp/uri/none/plain",
                            test_postcopy_preempt_recovery);
         if (getenv("QEMU_TEST_FLAKY_TESTS")) {
-            migration_test_add("/migration/postcopy/compress/plain",
+            migration_test_add("/migrate/postcopy/simple/tcp/uri/none/plain/compress",
                                test_postcopy_compress);
-            migration_test_add("/migration/postcopy/recovery/compress/plain",
+            migration_test_add("/migrate/postcopy/recovery/tcp/uri/none/plain/compress",
                                test_postcopy_recovery_compress);
         }
 #ifndef _WIN32
-        migration_test_add("/migration/postcopy/recovery/double-failures",
+        migration_test_add("/migrate/postcopy/recovery/tcp/uri/none/none/plain/double-failures",
                            test_postcopy_recovery_double_fail);
 #endif /* _WIN32 */
         if (is_x86) {
-            migration_test_add("/migration/postcopy/suspend",
+            migration_test_add("/migrate/postcopy/suspend/tcp/uri/none/plain",
                                test_postcopy_suspend);
         }
     }
 
-    migration_test_add("/migration/bad_dest", test_baddest);
+    migration_test_add("/migrate/precopy/simple/tcp/uri/none/plain/bad_dest", test_baddest);
 #ifndef _WIN32
     if (!g_str_equal(arch, "s390x")) {
-        migration_test_add("/migration/analyze-script", test_analyze_script);
+        migration_test_add("/migrate/precopy/simple/file/uri/none/plain/analyze-script", test_analyze_script);
     }
 #endif
-    migration_test_add("/migration/precopy/unix/plain",
+    migration_test_add("/migrate/precopy/simple/unix/uri/none/plain/live",
                        test_precopy_unix_plain);
-    migration_test_add("/migration/precopy/unix/xbzrle",
+    migration_test_add("/migrate/precopy/simple/unix/uri/none/plain/xbzrle-live",
                        test_precopy_unix_xbzrle);
     /*
      * Compression fails from time to time.
      * Put test here but don't enable it until everything is fixed.
      */
     if (getenv("QEMU_TEST_FLAKY_TESTS")) {
-        migration_test_add("/migration/precopy/unix/compress/wait",
+        migration_test_add("/migrate/precopy/simple/unix/uri/none/plain/compress-wait",
                            test_precopy_unix_compress);
-        migration_test_add("/migration/precopy/unix/compress/nowait",
+        migration_test_add("/migrate/precopy/simple/unix/uri/none/plain/compress-nowait",
                            test_precopy_unix_compress_nowait);
     }
 
-    migration_test_add("/migration/precopy/file",
+    migration_test_add("/migrate/precopy/simple/file/uri/none/plain",
                        test_precopy_file);
-    migration_test_add("/migration/precopy/file/offset",
+    migration_test_add("/migrate/precopy/simple/file/uri/none/plain/offset",
                        test_precopy_file_offset);
-    migration_test_add("/migration/precopy/file/offset/bad",
+    migration_test_add("/migrate/precopy/simple/file/uri/none/plain/bad-offset",
                        test_precopy_file_offset_bad);
 
     /*
@@ -3683,25 +3684,25 @@ int main(int argc, char **argv)
      * Don't run this test until we find a workaround.
      */
     if (getenv("QEMU_TEST_FLAKY_TESTS")) {
-        migration_test_add("/migration/mode/reboot", test_mode_reboot);
+        migration_test_add("/migrate/precopy/reboot/file/uri/none/plain", test_mode_reboot);
     }
 
-    migration_test_add("/migration/precopy/file/mapped-ram",
+    migration_test_add("/migrate/precopy/simple/file/uri/none/plain/mapped-ram",
                        test_precopy_file_mapped_ram);
-    migration_test_add("/migration/precopy/file/mapped-ram/live",
+    migration_test_add("/migrate/precopy/simple/file/uri/none/plain/mapped-ram-live",
                        test_precopy_file_mapped_ram_live);
 
-    migration_test_add("/migration/multifd/file/mapped-ram",
+    migration_test_add("/migrate/multifd/simple/file/uri/none/plain/mapped-ram",
                        test_multifd_file_mapped_ram);
-    migration_test_add("/migration/multifd/file/mapped-ram/live",
+    migration_test_add("/migrate/multifd/simple/file/uri/none/plain/mapped-ram-live",
                        test_multifd_file_mapped_ram_live);
 #ifndef _WIN32
-    migration_test_add("/migration/multifd/fd/mapped-ram",
+    migration_test_add("/migrate/multifd/simple/fd/uri/none/plain/mapped-ram",
                        test_multifd_fd_mapped_ram);
 #endif
 
 #ifdef CONFIG_GNUTLS
-    migration_test_add("/migration/precopy/unix/tls/psk",
+    migration_test_add("/migrate/precopy/simple/unix/uri/none/tls/psk",
                        test_precopy_unix_tls_psk);
 
     if (has_uffd) {
@@ -3710,122 +3711,122 @@ int main(int argc, char **argv)
          * channels are tested under precopy.  Here what we want to test is the
          * general postcopy path that has TLS channel enabled.
          */
-        migration_test_add("/migration/postcopy/tls/psk",
+        migration_test_add("/migrate/postcopy/simple/tcp/uri/none/tls/psk",
                            test_postcopy_tls_psk);
-        migration_test_add("/migration/postcopy/recovery/tls/psk",
+        migration_test_add("/migrate/postcopy/recovery/tcp/uri/none/tls/psk",
                            test_postcopy_recovery_tls_psk);
-        migration_test_add("/migration/postcopy/preempt/tls/psk",
+        migration_test_add("/migrate/postcopy/preempt/tcp/uri/none/tls/psk",
                            test_postcopy_preempt_tls_psk);
-        migration_test_add("/migration/postcopy/preempt/recovery/tls/psk",
+        migration_test_add("/migrate/postcopy/preempt-recovery/tcp/uri/none/tls/psk",
                            test_postcopy_preempt_all);
     }
 #ifdef CONFIG_TASN1
-    migration_test_add("/migration/precopy/unix/tls/x509/default-host",
+    migration_test_add("/migrate/precopy/simple/unix/uri/none/tls/x509/default-host",
                        test_precopy_unix_tls_x509_default_host);
-    migration_test_add("/migration/precopy/unix/tls/x509/override-host",
+    migration_test_add("/migrate/precopy/simple/unix/uri/none/tls/x509/override-host",
                        test_precopy_unix_tls_x509_override_host);
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
-    migration_test_add("/migration/precopy/tcp/plain", test_precopy_tcp_plain);
+    migration_test_add("/migrate/precopy/simple/tcp/uri/none/plain", test_precopy_tcp_plain);
 
-    migration_test_add("/migration/precopy/tcp/plain/switchover-ack",
+    migration_test_add("/migrate/precopy/simple/tcp/uri/none/plain/switchover-ack",
                        test_precopy_tcp_switchover_ack);
 
 #ifdef CONFIG_GNUTLS
-    migration_test_add("/migration/precopy/tcp/tls/psk/match",
+    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/psk/match",
                        test_precopy_tcp_tls_psk_match);
-    migration_test_add("/migration/precopy/tcp/tls/psk/mismatch",
+    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/psk/mismatch",
                        test_precopy_tcp_tls_psk_mismatch);
 #ifdef CONFIG_TASN1
-    migration_test_add("/migration/precopy/tcp/tls/x509/default-host",
+    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/x509/default-host",
                        test_precopy_tcp_tls_x509_default_host);
-    migration_test_add("/migration/precopy/tcp/tls/x509/override-host",
+    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/x509/override-host",
                        test_precopy_tcp_tls_x509_override_host);
-    migration_test_add("/migration/precopy/tcp/tls/x509/mismatch-host",
+    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/x509/mismatch-host",
                        test_precopy_tcp_tls_x509_mismatch_host);
-    migration_test_add("/migration/precopy/tcp/tls/x509/friendly-client",
+    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/x509/friendly-client",
                        test_precopy_tcp_tls_x509_friendly_client);
-    migration_test_add("/migration/precopy/tcp/tls/x509/hostile-client",
+    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/x509/hostile-client",
                        test_precopy_tcp_tls_x509_hostile_client);
-    migration_test_add("/migration/precopy/tcp/tls/x509/allow-anon-client",
+    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/x509/allow-anon-client",
                        test_precopy_tcp_tls_x509_allow_anon_client);
-    migration_test_add("/migration/precopy/tcp/tls/x509/reject-anon-client",
+    migration_test_add("/migrate/precopy/simple/tcp/uri/none/tls/x509/reject-anon-client",
                        test_precopy_tcp_tls_x509_reject_anon_client);
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
     /* migration_test_add("/migration/ignore_shared", test_ignore_shared); */
 #ifndef _WIN32
-    migration_test_add("/migration/precopy/fd/tcp",
+    migration_test_add("/migrate/precopy/simple/fd-tcp/uri/none/plain",
                        test_migrate_precopy_fd_socket);
-    migration_test_add("/migration/precopy/fd/file",
+    migration_test_add("/migrate/precopy/simple/fd-file/uri/none/plain",
                        test_migrate_precopy_fd_file);
-    migration_test_add("/migration/precopy/fd/file/mapped-ram",
+    migration_test_add("/migrate/precopy/simple/fd-tcp/uri/none/plain/mapped-ram",
                        test_migrate_precopy_fd_file_mapped_ram);
 #endif
-    migration_test_add("/migration/validate_uuid", test_validate_uuid);
-    migration_test_add("/migration/validate_uuid_error",
+    migration_test_add("/validate/uuid/unix/uri/success", test_validate_uuid);
+    migration_test_add("/validate/uuid/unix/uri/failure/uuid-error",
                        test_validate_uuid_error);
-    migration_test_add("/migration/validate_uuid_src_not_set",
+    migration_test_add("/validate/uuid/unix/uri/failure/src_not_set",
                        test_validate_uuid_src_not_set);
-    migration_test_add("/migration/validate_uuid_dst_not_set",
+    migration_test_add("/validate/uuid/unix/uri/failure/dst_not_set",
                        test_validate_uuid_dst_not_set);
-    migration_test_add("/migration/validate_uri/channels/both_set",
+    migration_test_add("/validate/connect_channels/tcp/both/failure/both_set",
                        test_validate_uri_channels_both_set);
-    migration_test_add("/migration/validate_uri/channels/none_set",
+    migration_test_add("/validate/connect_channels/tcp/both/failure/none_set",
                        test_validate_uri_channels_none_set);
     /*
      * See explanation why this test is slow on function definition
      */
     if (g_test_slow()) {
-        migration_test_add("/migration/auto_converge",
+        migration_test_add("/migrate/precopy/simple/unix/uri/none/plain/auto_converge",
                            test_migrate_auto_converge);
         if (g_str_equal(arch, "x86_64") &&
             has_kvm && kvm_dirty_ring_supported()) {
-            migration_test_add("/migration/dirty_limit",
+            migration_test_add("/migrate/precopy/simple/unix/uri/none/plain/dirty_limit",
                                test_migrate_dirty_limit);
         }
     }
-    migration_test_add("/migration/multifd/tcp/uri/plain/none",
+    migration_test_add("/migrate/multifd/simple/tcp/uri/none/plain",
                        test_multifd_tcp_uri_none);
-    migration_test_add("/migration/multifd/tcp/channels/plain/none",
+    migration_test_add("/migrate/multifd/simple/tcp/channels/none/plain",
                        test_multifd_tcp_channels_none);
-    migration_test_add("/migration/multifd/tcp/plain/zero-page/legacy",
+    migration_test_add("/migrate/multifd/simple/tcp/uri/none/plain/zero-page/legacy",
                        test_multifd_tcp_zero_page_legacy);
-    migration_test_add("/migration/multifd/tcp/plain/zero-page/none",
+    migration_test_add("/migrate/multifd/simple/tcp/uri/none/plain/zero-page/none",
                        test_multifd_tcp_no_zero_page);
-    migration_test_add("/migration/multifd/tcp/plain/cancel",
+    migration_test_add("/migrate/multifd/simple/tcp/uri/none/plain/cancel",
                        test_multifd_tcp_cancel);
-    migration_test_add("/migration/multifd/tcp/plain/zlib",
+    migration_test_add("/migrate/multifd/simple/tcp/uri/zlib/plain",
                        test_multifd_tcp_zlib);
 #ifdef CONFIG_ZSTD
-    migration_test_add("/migration/multifd/tcp/plain/zstd",
+    migration_test_add("/migrate/multifd/simple/tcp/uri/zstd/plain",
                        test_multifd_tcp_zstd);
 #endif
 #ifdef CONFIG_GNUTLS
-    migration_test_add("/migration/multifd/tcp/tls/psk/match",
+    migration_test_add("/migrate/multifd/simple/tcp/uri/none/tls/psk/match",
                        test_multifd_tcp_tls_psk_match);
-    migration_test_add("/migration/multifd/tcp/tls/psk/mismatch",
+    migration_test_add("/migrate/multifd/simple/tcp/uri/none/tls/psk/mismatch",
                        test_multifd_tcp_tls_psk_mismatch);
 #ifdef CONFIG_TASN1
-    migration_test_add("/migration/multifd/tcp/tls/x509/default-host",
+    migration_test_add("/migrate/multifd/simple/tcp/uri/none/tls/x509/default-host",
                        test_multifd_tcp_tls_x509_default_host);
-    migration_test_add("/migration/multifd/tcp/tls/x509/override-host",
+    migration_test_add("/migrate/multifd/simple/tcp/uri/none/tls/x509/override-host",
                        test_multifd_tcp_tls_x509_override_host);
-    migration_test_add("/migration/multifd/tcp/tls/x509/mismatch-host",
+    migration_test_add("/migrate/multifd/simple/tcp/uri/none/tls/x509/mismatch-host",
                        test_multifd_tcp_tls_x509_mismatch_host);
-    migration_test_add("/migration/multifd/tcp/tls/x509/allow-anon-client",
+    migration_test_add("/migrate/multifd/simple/tcp/uri/none/tls/x509/allow-anon-client",
                        test_multifd_tcp_tls_x509_allow_anon_client);
-    migration_test_add("/migration/multifd/tcp/tls/x509/reject-anon-client",
+    migration_test_add("/migrate/multifd/simple/tcp/uri/none/tls/x509/reject-anon-client",
                        test_multifd_tcp_tls_x509_reject_anon_client);
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
     if (g_str_equal(arch, "x86_64") && has_kvm && kvm_dirty_ring_supported()) {
-        migration_test_add("/migration/dirty_ring",
+        migration_test_add("/migrate/precopy/simple/unix/uri/none/plain/dirty_ring",
                            test_precopy_unix_dirty_ring);
-        migration_test_add("/migration/vcpu_dirty_limit",
+        migration_test_add("/validate/vcpu/dirty_limit",
                            test_vcpu_dirty_limit);
     }
 
-- 
2.22.3


