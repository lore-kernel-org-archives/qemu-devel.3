Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9AEC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4rz-0003Lb-MT; Tue, 12 Mar 2024 12:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4rw-0003L8-O2
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4rv-0000jn-2V
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:48 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CBJCvS024444; Tue, 12 Mar 2024 09:20:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=ocLG++Q5rHVmDQ9D/nOzzUa9UAYdVxK1XE3pLuQdU
 GU=; b=wj+zmQRJjjZV6n6UMjnlZfazpgAiiK8N/hXrqGnojD2IYjPrTAvlgSJhW
 c2j63z0TExjAL6hB1cdSYXusjVzOZZcFGFIzjfqsRzZMQSpQpbaRuipVf42jwgUa
 z0j/X+YRtpTeACc6f/RPf0CuyoyDGPKB2rzJqgeNG4lAQwvFtrwiPEcWBCtVyp5k
 0HivlWICiNEK61tAp9Xp1wcSasB+q1FYzmfy9qYESSCkFi5JvH8D8L1LnwnxZj01
 VzkBa92gJMbCUOuZ75hjbfbcifwatyM+TFI+jqY9wYqFY+Vx3Z+AFHY+lkHhtNV3
 RlEtrObGD3LFnsGeQHP5Gb2QVFVTQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrp6axe3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0mzrHTQK3rcH5TUlC2io+AYCSxlXBJjfRDyNHOiqtgNoQw1w7MzgTSbpVRdlA0u2TjCgdCNs4v38pD0MRgT7Mc/5vY4hHtGPtbMUq3+IC+rsUL1quRPmYGjCejf+jtNBQa6RHFi8EWqKbb8qT9QAhRz8xYZvQTuF7ovhuABe4A4jW02ExBHq/YXk37uvqNeOfhw8dxavMqPQQxQqNVMHh/4p+mPe879TO6JcwyL7agH3ub75Z6TFCCz5aJSjMhK9lENO/cGTp61x3A1uts3nxyta4eZO/TQdE0Y1yKdrcMC5NRPJghT3KmXa3wTepTk7d/zJcoZqeHQ4kLH7gOmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocLG++Q5rHVmDQ9D/nOzzUa9UAYdVxK1XE3pLuQdUGU=;
 b=nkn5GsnwUAAA2qdp+c9Kl8eVP0SRI7zhQ3qTndMN5+4maultbkLZevjpI+n0i6k+BALEO8B7c+zebdhVsX4LSl51ExzN21b8c7ScP2+Y6E3TG6hE+m4xqguaa6/XUBh/H8JGzs8I/Dh5pqyhANxtI7jL9fIoZdnwLyjJ/ixI1lMnv8N7R8VV5UmK+UlSFAvuVal+3xj+O9PvzuFBmHXOyaxGZkzbGC+064BRCsfhYU8RGSoPTwllU9xJrgozPNbYNuYaO0PrxcyWho5QYK7x8CTVv0Tm6QyBzRv6gLp0bUeW0pQ5acAe8NvLBjR+OFgiWl4ApYWrymaMxp+rF1Jzzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocLG++Q5rHVmDQ9D/nOzzUa9UAYdVxK1XE3pLuQdUGU=;
 b=wtwCjhjRqvfIIh3pPqF/54VYfvPuepUcdnoBDVoaxBSUpZu9QBKi3kwZhTfbBazBkFk6e/UA13/tbbCnTiqfzMStmePhipvIMxnfNk8ddGCIqeYgtCkX39AAKhb6iZeSOzSAweteJQrZs1q51aw3T6xvdRwoG0f9Uz7HTcmMFf22kwC27V2ThmVzDRoVUbOE9IcfqDViiaYBJWi62KOg8EafeImtUB69v2W03OHdEW9xwOmDxrU4n7S/EBYUPdYHZPcFoMJgFbQzuCNS4SnnErHeTeUyoGPi+JJXn3BwEmmBRei4NiJ2MENBECYJPenoVLrwy5IXE6A9uSqxtTikQA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CO6PR02MB7570.namprd02.prod.outlook.com (2603:10b6:303:a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 16:20:44 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 16:20:44 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 8/8] Add negative tests to validate migration QAPIs
Date: Tue, 12 Mar 2024 16:20:25 +0000
Message-Id: <20240312162025.44212-9-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 37327e7b-0168-473d-1953-08dc42b05e3b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /GqaId+/H7dOp87taF92YLcwUKf5E+PkCKNVkeEXayzfzTNgvLzPtFjGYeOPRAnEYefnAtRZ+35p5hXDU5BONLHFgQOpU+YkznXw0r8n58TWA3+2Oj1EXyJK/EFkCMcBc5759O+tXD1X/yqjGNwdkEvFYxVv3GcGKbBRE545hkOgkXITzjOAlbzxuyPK1T2CGxcPQsK2S32chca5TXUIcMcy8DcxBVjTYYOYKf09nzgrlLwgOvKO0Ex4miKO4rjB9JSdgaPgqg0NsvgovcCl2xvvYcbOSPdRneAujs6tRHqn+soKDlfUDPNa4R45FTigxIbTR4x/dA6wtCXuMyij0jKnrkHp3xLAi4sD+z7Tp0tDCraWco0m6UKGQj4ijj8tpfQcaOy834Cf8nSxLFE5u28n9fWWQkSY+F/kiXypfGTQZC4NxAHP1nc/NCQuWugSCAusIACD5aYoP/nACKC1i1EUAm5GSkY+8J8aejU3Q53nqOSSoGiI22n/iFcGPW2xKGGDbVjmjhCoXx2AAyyBMRLquYg6s3fFVyz/zg6zDHAnNSU5yB2zHQfw2QK3f2ZuHlZ3z4mzdseI1woHeMb8s9xfJMVP35qaltC7iNOCHBPCzlyBu4LxhNqyyu20vT4veR8Z0JQNKVRvn7I7BySTYWkVYmE0yjzUnF5fA80w5Dj/r20lYInfhCmg9ovjblURYz3zYV/wW0s0tbYoqZkcS+PvMoa5dh+1U8EIgKwOXtI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C92wQm5t++FNtRdvQNC2a1CI3sEyyFgLKaknGzUM5/8cd8i/+rXfoP9i/x80?=
 =?us-ascii?Q?0crAlzv/t6YQSlZLbL+BI7GB5q890cfuCeVpADcNeKZ/sAslD57Tdm2yHFhp?=
 =?us-ascii?Q?yefjesYKg6dOaFhRIVu+iLMQWn41a71sqKaB4Pihnyfw8RU8P0/8NCHuddlz?=
 =?us-ascii?Q?8p/w/U79Ot/LWo8vSbbYrpG0DbMgDIV2yqNO3aR8flYPsbGFBdsouu2aP+UD?=
 =?us-ascii?Q?5PAye1TmMCE8lcY//XWvMb06pYkwNYcbQ9QkSwoPlqA6oVISlijI4hqzOR0l?=
 =?us-ascii?Q?bU/YqkTJ+zijjQs1BRTyT9bhRnt6OHrGgu8u4mGP1Yer9Agf7VJ+qtfozMq1?=
 =?us-ascii?Q?Kmlkad7aKvX5S+mmezEkNZ5T5BIoWAzuZOGlbk5MatdXdx0yvF0OxITF7C6A?=
 =?us-ascii?Q?SnDCiwYztwUVBDCWv1msi/AKfkfmN8zq0iPpTDvQBBU+dNaFRp0BayvY+fb1?=
 =?us-ascii?Q?zNusBcGac7Lv9rmM6Gi7naS5tEC49l623luk+rKjBKzQhdpFb3JwNpHqjqls?=
 =?us-ascii?Q?YqIqneZ2xi1U3lxgb5/exQj2mZb9vEx+KK/wCeNC0CXaUbHf1nvJN2862+52?=
 =?us-ascii?Q?u43W1nsNjKSmJr4YFdY9a3lTxIyEAt1E9JeZl4L8XRtJCMNoP8C2jmmzJ7X0?=
 =?us-ascii?Q?uIryNp4etrD4gkDbNINFX5uyZ4NfvMpgieVhP06ITpmlNmwabz2bp41qMz/U?=
 =?us-ascii?Q?zF5nCeMZGgF0i8aqytm9wAaEKlJFWAvuL4+DYwupw4jyvDKd55w0ToVjgfi0?=
 =?us-ascii?Q?iplO3nE3QtsBg420Nh8IG6AKrbdH14LqEjZiiv8ceVlS579HUjXIbCttPtbl?=
 =?us-ascii?Q?trKmMTt5fBGX2P3vSLSvSM7SwpJA/DOnKqC6JTwQoVK7IprxKDPTcgupljBT?=
 =?us-ascii?Q?rpBJ8bGbqdfzMSWs6n/MKmk+w94gr9XwBH2n6hdnfNvkWO2jtW3KUGboaEFY?=
 =?us-ascii?Q?WDO3XPW4L6TDjw+HZMQQXz3jo4G4eE1ooOxpTn4KUWkXt6pLzvJ7F7SMumF2?=
 =?us-ascii?Q?7aYij+BShxXuAoi30b8/nwM8jdknn4Tdq2UKWWo8zsO+YSjYb2uxLwlnn+Fx?=
 =?us-ascii?Q?9nftfN+dfX4AwgTBgivROAq9FH8Kcvoqko/HfjsQryLrPL7zYzst17I1jQUM?=
 =?us-ascii?Q?vI5rdpw2roF0uV+ugwunf+r+f7tkjQnZ+NLnSCbZZFWvIAxaLw3p3hlYyVS1?=
 =?us-ascii?Q?5Ad8Gm5yN80gJ44/tiXTQg0XKIL98fA+DMlfzDL0pCDx5ffVqPiPiuQyMaKy?=
 =?us-ascii?Q?ibNzkMgVbOAchP7F1K/LkXycpj9KLaStCQLnvHDHx8Gtq1qSnEKmFs1DM9ji?=
 =?us-ascii?Q?7MMx5OcAyxtU8uosQocImLpQIGAeKQobom2HVNquIE4cLio5iTatEhXOOoRb?=
 =?us-ascii?Q?QfoJMTrZGXGWR5iBwwrer+v554CSOhD8fCNXfSS/h29gNSBa5UGx+ZGWwiPW?=
 =?us-ascii?Q?1Ju/cZ7Ei46sQhAiMuySR+IkYG27kjELNH1esFZomgJrSJNqAoCY2gy217PD?=
 =?us-ascii?Q?9rRiDH3symV7MYwVFG9dFn3zBH64Yvvzc7IzEtOD41GwaaopdKNi/UoGNzFI?=
 =?us-ascii?Q?oklzqa2z94KqyrpDjR7FyZJeazndWJ42uR4fxOOnx9q4jHICiOzBOhMarCkJ?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37327e7b-0168-473d-1953-08dc42b05e3b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 16:20:44.3357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fnE+JJsTkzWUEk1BCnUY0xKv8pUe4A+NOPp24nTHXu8uJLn29dZ1AOR6U50qy2ygKWmLDVRsD6J6CkACag1QfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7570
X-Proofpoint-ORIG-GUID: gj2yeF_bPgc2APijU6i3VGql8rrMLbMp
X-Proofpoint-GUID: gj2yeF_bPgc2APijU6i3VGql8rrMLbMp
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

Migration QAPI arguments - uri and channels are mutually exhaustive.
Add negative validation tests, one with both arguments present and
one with none present.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 55 +++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 392d5d0b62..e9801da701 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1724,7 +1724,7 @@ static void test_precopy_common(MigrateCommon *args)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
+        migrate_qmp_fail(from, args->connect_uri, args->connect_uri, "{}");
         goto finish;
     }
 
@@ -2608,6 +2608,55 @@ static void test_validate_uuid_dst_not_set(void)
     do_test_validate_uuid(&args, false);
 }
 
+static void do_test_validate_uri_channel(MigrateCommon *args)
+{
+    QTestState *from, *to;
+
+    if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
+        return;
+    }
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    /*
+     * 'uri' and 'channels' validation is checked even before the migration
+     * starts.
+     */
+    migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
+    test_migrate_end(from, to, false);
+}
+
+static void test_validate_uri_channels_both_set(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .listen_uri = "defer",
+        .connect_uri = "tcp:127.0.0.1:0",
+        .connect_channels = "[ { 'channel-type': 'main',"
+                            "    'addr': { 'transport': 'socket',"
+                            "              'type': 'inet',"
+                            "              'host': '127.0.0.1',"
+                            "              'port': '0' } } ]",
+    };
+
+    do_test_validate_uri_channel(&args);
+}
+
+static void test_validate_uri_channels_none_set(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .listen_uri = "defer",
+    };
+
+    do_test_validate_uri_channel(&args);
+}
+
 /*
  * The way auto_converge works, we need to do too many passes to
  * run this test.  Auto_converge logic is only run once every
@@ -3674,6 +3723,10 @@ int main(int argc, char **argv)
                        test_validate_uuid_src_not_set);
     migration_test_add("/migration/validate_uuid_dst_not_set",
                        test_validate_uuid_dst_not_set);
+    migration_test_add("/migration/validate_uri/channels/both_set",
+                       test_validate_uri_channels_both_set);
+    migration_test_add("/migration/validate_uri/channels/none_set",
+                       test_validate_uri_channels_none_set);
     /*
      * See explanation why this test is slow on function definition
      */
-- 
2.22.3


