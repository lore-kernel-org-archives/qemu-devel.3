Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEB3C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8iB-0002CN-BP; Tue, 12 Mar 2024 16:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i6-0002AY-5J
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i2-0003C2-FS
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:53 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CCE6eK010077; Tue, 12 Mar 2024 13:26:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=5Sf2kCtS0xadPN9mj4qZn01slTsmgbkM5fV3CbjG1
 HY=; b=JCy7lPyRUkEuYP2TM/b5abtnRUZWlOAuurAE1Hovp+42ynHLvHcJbmZi/
 zwhYl/tFtVWTblWp4I4/oVpnWCY0mWz2rGQrePSULsmFshGkufgCOEQoxCd6MyWO
 q8FiBAzzYgD75S2vD7Iongty69re2mTQBDgGNjY0Er/J0N+B8s+u5A5XsHBgtsV6
 95cJpmEphWw8sYhdfE2ryISOsoy64rxl7Xp3faciI3f6gGWslskdd2qV+H8uV8dv
 QR6Ssp1j6jApBIYDF6WvRwXV+IaPVhTe4H2vMI8ty3jJoCLhLkmW/R7K1v1rOQS3
 k2U7GTYathVyqsh/szj9eXZcCQJqg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrr63pt25-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ry/jRsf+0PaA1gnO9VPk2293v0nub+1JvcRvGAbOmS5Cp7o3aIV1lBIrqLb8MT4l7JGyh5CfSLfUYlu/DhqLuXDLVlWQM+PsdPzhKEDo+1/s7BVVmhe0CgqNtXv59fd/m36i+B+ib5y6ryhUCfWiYSnAcDajxlvbR+hc6wb0sWTd52sTG0XvmxpcYYjc2g3pUi5vRYQTNxwqmV6dfF98R1NtI0335tCU24Vgv5Rl/VdekqHs0vZtUZMzul7GSa5Bf6h7/6tHAGv0TUMhTzCtwxrXcW/cogPHbdsU7XHD919yMFUCOlgejkngogFGb//6M7h5jwI7iFauseiKtFgvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Sf2kCtS0xadPN9mj4qZn01slTsmgbkM5fV3CbjG1HY=;
 b=B7HGNoXjuPmUT1Gvc7xnBCpIAK4HuRrCsrYhB46fMXXk5cNCnsAbD2OSnJkFI9ju4QZav/Gu/tO5Ncw+9jVqCAMV28B5erHKZOBSI5JttUiFfSmwrAYTpFLQEdDL28V/Vc3xSI7mVbxm72R4c7a7XaOy1lZhm4SBOpBf2ohjyHfOaKHDbNx61fkBA4Scv7qkIYwOrrcq4dvAtR6nPFvKR0s04ITSeqBa9mLPZCUxWhwWmXxd1d7bV+3sQ9TRe6KScxtaUgMRKG5cdzdaqBSJtWOsnCZ5EQ68IGoFINY4wz/ZNbd556ml5hymCpeZ4L/aowI3YoZzCG2qKhnX5k1+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Sf2kCtS0xadPN9mj4qZn01slTsmgbkM5fV3CbjG1HY=;
 b=NkAUiKQZ6xmOSBvqALoLa3aQTH3aumtOQeF9DdK1Q/KX1opOZHcI68trshsnjw+igQN1hQ6tGiZbb39UXCMy2H+yYkWlzTGlo44ri2tmYJCQYZ+bXXCabpHiKrPiuAo8xyFHBhwBO5V6Kp3NdPfif4ZO1HogUzG2/cOYmVp2LWX4doRFucUM5PMebnMyOFXS5u6CR+mBD52dpqwSfdOHtCFKJiefwy/krcgbERwR29mHtKKaz0P8N3r0VluOvTc8jSy6rTFC31u3fqSh6d5fK/fmqVKoIZW3cKGqAQs7FVZ795X+l4VSiIJUNSI7cgEYPqq3pAunc35UkipZ8WzhZw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH3PR02MB10057.namprd02.prod.outlook.com (2603:10b6:610:19b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 20:26:47 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 20:26:47 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 8/8] tests/qtest/migration: Add negative tests to validate
 migration QAPIs
Date: Tue, 12 Mar 2024 20:26:34 +0000
Message-Id: <20240312202634.63349-9-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8238d0a7-6354-40d8-8f53-08dc42d2bdcc
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pa6xhp8w0hmLj+UhCGxFf69v6wnBkZm/1JRFQObSffficTQRqxJNelpu823wnBS6m3gPtAahxQl4yZ9VbtkGTtZpn/oeUNjqEeN/FHd1prre/Qhjo0QxEXzgl+3J3x8xgfZEvbhnPR6FQR8obdypzTTuLQ+GY8eWU34BgqYq7mjwWcjquy2cJcnSzkSQhSwlphJiRUDPyDoOwCzbknmedDaRbico4kgl7oFkvh32gjjMDy8CsO5bAsodrLMXmfi2MGNMm2m5ozIUXpdcwlGX7mmMS5vW8Ojf1qFOkxKHSZoN6Ejdpli5SlclTIcTCkZbpSPEDhse+BCOox+wA2VuTX1NBP6CuaUeSDktFdJro+M6FJTlbLe2oOtQekJx1DPePFYcpeTOiQsQtc9aEShxP42tG8bk70VlwIOiU0atoTRgP5SgMy2/bHGnDAuQ+AYbhvo6WK1Y28suIYzgWhkKO9Sedq9AWslJpwmLPCrrer/AwqGqSkSWxt1Z4U1uwGdWsHM1zfSFzqUBvuoJ3zFAdWvBT+TXKFb3zEPGo6uUlPldKK5vV2psh87eLqpBRxgXhzVnGHhiHLk7y1IUy29yuLLUlh/OW3n58RhI8muSSN+0+/S26fZSroD1sMqWq1oHnZi8p4kdE0x6ltb41ESTk6t4jtE5jkEd8HbMAcWLjNou/RlOe1KSxot677QdDgO8aGbqSqa//R72Hiz9XasohV2tXRaLD3eiFckjVh7vGAU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o1EvNWcOC3VJiGEnrCZ6eOH+HXTpGyanidE1OsHkMxU12r9IInbZg8UC2mX5?=
 =?us-ascii?Q?dpY4JM8Du8LxVdUUbY1A7sGysXiZk3sHFb+VNJw6TT3jHwbHY9joWIGlUmaB?=
 =?us-ascii?Q?LGIav1Rh5mzc6nLYBXonkm+UJvCVhAKcaokECDEpTVBcnr9Ig4ykLT0zAzt8?=
 =?us-ascii?Q?JNmx0YO9LSnDiVf+MOBciv1FG+k9ZmEHHofZ157m2P0Va0n6n+B4tRtM82Yu?=
 =?us-ascii?Q?Kd6gKhvV97hja68aNowZLHtsNVhy2WuL+GKr1wj4Dk7TuCt0DbGlimhep4D1?=
 =?us-ascii?Q?0bYQAVNsRsOj9ad9dgi/ReLDfTVKhiNLZ7laa05WSvRaIquVdzsXgpwndWku?=
 =?us-ascii?Q?8/GTMJRGl/RpSVB/DLgoi5rza/N4SLcYxAyRBNSeeUHpiFLASJjmeJf/UO2B?=
 =?us-ascii?Q?F8gkt4A2ZL1LhdYLA3rjJHwpYgxf1OejW4MU6msxvqhxvW6ePqlum0UE8+m8?=
 =?us-ascii?Q?ejwW7VtL854JF0L6WbewOv/DfoUZ6nQwvZF8eVQubxZyzQwSh+JJ2oK7ND2i?=
 =?us-ascii?Q?edLpebzkz7Z1dgI8JehTttIQ0czQOljZGgWGtige7K1o98I//S/tide5hDI7?=
 =?us-ascii?Q?T5npj3FwN0m3QkkliwP3XrguSY74vlmk9LsbRW0I9Jx197W56WhGjp8GXLZD?=
 =?us-ascii?Q?8s/UKQGCJFfNCJwLWlmkIXUQ/WZrBdKevuXa/+5TzWgoZI7XI9j1mdgvr6BJ?=
 =?us-ascii?Q?ZS2ImcrrYSdVc7T4i0E1xl55IiK+/pfc35hvDRJ5LRAAN2hph/7oUxm9OgWm?=
 =?us-ascii?Q?ShcjdazhQHSoJ5fLFNCyU76Krpgg3UplpPi7jEDeD2WS2+FElI0V7tt9DNo5?=
 =?us-ascii?Q?usybLdl4LCMEj4UuFJaCWkeuloYa90/KkPvLJqy1h+aHFmZ93i4yRlXSD0Ml?=
 =?us-ascii?Q?spaWnq3L3/X8WELrAleYVgWK66DzlyO45xXwWz4VeDwJDBcw+DAuZHby76LA?=
 =?us-ascii?Q?cy3NQKZSTG72HC6doEy/b873SbEo6P9VkiOch/Dlgx41+3kr9C3/DLC2rPU4?=
 =?us-ascii?Q?kHUfaoi+5S0PsnFXsL5NX0naRCSCx7W1ZzpjBdN41zrk5Zsfv258nHFZqJtk?=
 =?us-ascii?Q?GtwfI66FM+ZCx1X89NuwYAdM6KzuUmG3oxISumDUo+1llPfIZeWv5g/bUiOz?=
 =?us-ascii?Q?eNcjFArD3utWUqJ2qqMigP658nk86X7Lk7e6fQzm7y1ezKR3vA4qbJl5U6J0?=
 =?us-ascii?Q?8HZN4gpyl83uchjx1+p+iWr9bIPQbHOReTd/+JQLD95EYfwtYJppdviZrCco?=
 =?us-ascii?Q?wO3D8jcowFUaO7xiomOgyaif4T211nC6K3AIwyEG/Wbw9g8zhAFbVs4lvqNW?=
 =?us-ascii?Q?TqyzLoSbv5Pf8OMRUKrwky4DP97z7DwFo1+O29Kh0mBRYaz7xR3459v3Ri2F?=
 =?us-ascii?Q?ub8+YgH5Tz3ux+fPKXM8CUYICEjBaL3O+qKjHYqHBaJiH1l6H6/8Tq3DMlos?=
 =?us-ascii?Q?87iIKS41VC+xeJlzNNwfwmkvHbLsp+ewcK4U9iLHZQL30FTCNsBGLYNHesS9?=
 =?us-ascii?Q?GCg9dhEQhO70tr5akwfU9flOVGVf+9lZJPYsay4k+LNDmu+pBS6pPn8UdOxK?=
 =?us-ascii?Q?w7VdlwEdTtjiizrR+VYCMpWkJVfCuxPGR/PVUxXuAM0t3tNQWCU2DmDsd62W?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8238d0a7-6354-40d8-8f53-08dc42d2bdcc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 20:26:47.5810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTIS2aItBQgjgreibtL3MRP0ClZ/XDE1ZBlOwS5PbevqK+LRR+ZTfGyo+/x1/datiCLJpyO1yC5GCGFG+wgXoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10057
X-Proofpoint-GUID: RBz2EZE6rfVkqvQOGf0XaVYbI9TwDJWX
X-Proofpoint-ORIG-GUID: RBz2EZE6rfVkqvQOGf0XaVYbI9TwDJWX
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

Migration QAPI arguments - uri and channels are mutually exhaustive.
Add negative validation tests, one with both arguments present and
one with none present.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 55 +++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 7ea13c8e5b..bd9f4b9dbb 100644
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
@@ -3722,6 +3771,10 @@ int main(int argc, char **argv)
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


