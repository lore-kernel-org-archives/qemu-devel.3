Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B47C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8i6-0002AV-5L; Tue, 12 Mar 2024 16:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i4-00029d-G2
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:52 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i0-0003AT-3g
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:52 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CBw4WA019265; Tue, 12 Mar 2024 13:26:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=T0+gkrie4MpAnkSoOjkYys1AqJRplc8D8Lrr8HmCf
 0E=; b=b2xsEvPDjHjRA3mP/UFwXB+fc4s8VQNIjJgPEeZEc8Rrdi/Ig+4V0WVHn
 DF8S7fcZTR6eOJJybJukJuDAWF7+DI8YK6yn+smGguesfDHZPpZJllr6bdWyIuQc
 6w7d7CfW50F7RBrQs5jaguYej1RESwYC/daAeXNdUmX2H4GvQra5siJV/Ua2V3PG
 AXRzcEzNlpi87K0eK/RIkp9e0dMLJhA2nnBRsOhpIUK23Is8ZORZfcwiL8Kbd3LG
 bfjohkNsAzIJEdC7Q/JCVFcYaKcAzaXnH5Nw1jABGMFZ7W6sP+RwLCb7OeeLMlYd
 /1CPFpmMSGvc3NS37UL2k1Oma/iDQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrp6axxgg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqaXkv0T7CdMtVojeuRsXB87JohAGUjjnqrI0P9t2dPC8i5u9Y/LFFSVBxDQlFeaLSDcF67v/1MWHi3BGYxk1JMz8KIOpyu+lLQ8GD21k3BfbXa5Km2ErnJ4wKo3M7hOpDdGg/YAL4WraMxpmK67wL7IoVNHKSijmGztODkhbLTu3LE5H8H303ip6BXAzmrrmGZCZitQ8Yum81zmCnUIN99CCoOjxy6gSwHJsVx/+Of8dZOJp/OnaQk+hlrsUuth9eZJ5aaOlmgKWBIMlmIu5qJnNYgu4fmW8KGR3n0OIxcO+iOgC1drrrLhUC9otsJGuDvADWXoy4eBFjEPe5FF9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0+gkrie4MpAnkSoOjkYys1AqJRplc8D8Lrr8HmCf0E=;
 b=M6JNZgc2lOQ8ziyTUX8RY0A4KdOFYdggysKv/d6i7D0BB5FQPaMgRNGQ3nhizJpFs3//2YZbeJFSzPfbhO9mfVb4BY+q/WKQc51kK6YwHG32Dkhm+GI64qvFwACaAQrlTKwGkh5QkQfVfjkdvysMUBOwA5RwjUy5bWpiaEcwXOVGQi7k19GJibP8j1JDAFn2clIIrksy/0VFBgw0poW/TxKjZ37UPvfgtmnCjKPd5JnJVlTq0/PKm4zXpb270JnCvDsAbiYBcqdtnd6NiVowdN1wWqUZwkb4P1U9X7aWAoZXkmmCy41ILXxMMNNbwjZK36OF97Tb/Kwq4R3rWPJ7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0+gkrie4MpAnkSoOjkYys1AqJRplc8D8Lrr8HmCf0E=;
 b=b6hLq3qPordSNWZhR/kvxWa5wuLo5EQcGJ0xMxEgH3Gc0OYKj7U6sPlCvkkVgA0fv16rcDzJwvTwAtcG5AsIl9Kh1j3/p7diJBi5+4cUnwCKaHeRZFIzeNSHJ48d5R5XKM1bgyEIZCZckXDiOOcWprbMxbK4fumQooFHBZwU2EsEPdvkt3kWJ727pZGp9s94NQAtItCYyWsUKR+7TQOaycHTmqiVysUh/RTNlIz5PrQBnMuWeDI3n0LprDQt68RrWdN1SOXDePqwhB4++XAVEvOKTU02TScImz0YRa8NXi+oyRup8rdG3vh8p8GoawvSzrV6W45YzxOTYXs0KZcgGw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH3PR02MB10057.namprd02.prod.outlook.com (2603:10b6:610:19b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 20:26:42 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 20:26:42 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 4/8] tests/qtest/migration: Add channels parameter in
 migrate_qmp_fail
Date: Tue, 12 Mar 2024 20:26:30 +0000
Message-Id: <20240312202634.63349-5-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 50f23675-d054-4df5-569e-08dc42d2ba97
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +K1emRW1d26iHBpzAPDFnft8Ab7K/Q6itATJqrLFGLLokaYxHbvYXjVQrEvmOzV9UP7jqiqRudqnl7RpY8gRjmnGhgMzVkV/Cpf+VCuWC2bTC3r8Jmk8SCjLXTSNlmYh9a2ioXcDPRffV9daQfS6LeVd3sq/va3Z39DdbMyLDNyHEAuiOrZBBVnl0XM2y7yIsLx56fehmd9Dos2mvGo//0e9NWdbdtsvroI2ocxIcEnYceJsNZWlGD0tw7dyKy4Zymqei0PvuJ8WIssfwYvC+5/weZtgQCkESr2KtwF05ufourm1Z4Ed3SYYBHWC0lWUxa5cs6pIES59ReflquCvu4/Taso9ap4uk+X8ZoDdYh8VyVNohf7SROEo+ETsAhBS7F6O9zHbK5r2kku0igtvN84AmnSbf+nC3rTdn91I97MjlfuYw3kw1qbZK55wrY14ewSjzND7xwA/J/R1JVJDeqWE3gC48IScHEvC3KpiRvnsojlFVauaD4bPUUe+MqBeYjyAtYFom33Ynx1kmTWXw/vTBHw6HpF158rncwJGE9q+GjFK7P85mcluyYoB2FTXhe07tB24YScQ6af4Itk1sTX+PALi1hlEPeRfP5hRcbCoUeurYL/0bW9uIED3OrqNj/kgh89xxxh7/hw7DcL05+k9dkXQxhY4Vb6Do7GUXvLvRa1BOxOUB0vulC5S8kkgZPwvPR1/dJqA/tI+1OhHAVSWXm/OtC3FyXcZqAEDJLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HPv31gtnaLfXxRvGaTeKMqt2UdTvTZnJSWLR8kj6pvSdxU9kKYOa8neI4BjY?=
 =?us-ascii?Q?650nL3FyxC80sPklAVcr0Pra+kR5fp/6I9OTzbkv+lO/RaOhHXSPpkU5jAMj?=
 =?us-ascii?Q?pOhrTNVCz0X/OmOmS5zHrbj3IBrjm358PZgnnVHKljY0GliWNzMBQCmCth9B?=
 =?us-ascii?Q?C0VPlogpjrg2FXwku+cJ25bw//11F5w0gpmTqWLTDd7Pvjw2Wc+hyTOXWWYS?=
 =?us-ascii?Q?KTxAz1nGJpw3XwwmLB7eHjcVziuxr5seZRQqGu7VJu/G4eleUS6Fttl14fht?=
 =?us-ascii?Q?c0qTMHwiBm7r4OQ0WJf2MUzQxdFBXKP9UMYfp5vYz2lxU6sUI5hsSRab9RJe?=
 =?us-ascii?Q?ixk0IQ/O8WE5C5AbdQXxRswfREjWFNg7OA8lTbj4hHyh4RFXZ/v9P5Zxee0V?=
 =?us-ascii?Q?GzbA4MVocPSjoL4Iwc8uFswzOYj20KbEAlye61ifmuyj5Mews7GEYCCPns7w?=
 =?us-ascii?Q?tA/0129llwLB6aRC1mV5V73Hb3t3zpGl+kXVzQlwN/ssVKAbOjxLbjTGPI7a?=
 =?us-ascii?Q?UTiGQIxIEDiYkIPYPlxYrCHxFnlYZk6Y2tP2uMxnKjaQKX4kgHrse3+D/OiK?=
 =?us-ascii?Q?Dj1sK7Eu9whjeH7OaqKN+odcAqHfvLj3WGzcLu7y8VW8mIlaxYeLFP5kflua?=
 =?us-ascii?Q?JMjQ6784hHZ4a3D95XpbhZxYyrBi3z52tDjxUy+EbyS74juHmJuC++NfTyfL?=
 =?us-ascii?Q?xgIaAjdQp8Ye9P6Bm82/7oc4c+rIV+pfnIHFSNC9n/9cn2xOXQwqJTtrMNWk?=
 =?us-ascii?Q?NbZZkXfLpsvdQVKYLyFgwrSM2qNxNu3jvbAYOATdPKqe85gZa3oZoVz6RHr8?=
 =?us-ascii?Q?M0ZM3y6VgJCgMGsGRn/1aEb21SCblnSuG2rXtpunoAhH17/2FxpMSnwBEIfN?=
 =?us-ascii?Q?rIuyr9rVmiKQ3Gt9r1olnBzYcavNyHF38PAgBatTl+EYVi1LJ7Ttbek4o8HX?=
 =?us-ascii?Q?LvZm1TXDf6vodUG1NL5IE8JSD1R4BIWN/FiGWApPjwEoxIGms/JJFC+MNcsT?=
 =?us-ascii?Q?1dmgA90Zd8Gpnuc55po3YBeTvy4l5ZbuwZVmpfjFuqp5e0CZRa1Bb8rLpGZk?=
 =?us-ascii?Q?7ruZCdZHoIGnYa7zOo3WTUDx7uPdzA22+z81E/pSt+RWNviBhTPBfPudcAlN?=
 =?us-ascii?Q?tsiNfFzak1mBReEgTcVGsaju+vCvI9GnTiy3DaHjWUZk3blcysO7m+z1bLd3?=
 =?us-ascii?Q?lH8ubpN8pAgAWLQJ46to4WIqqO7DurCsMSb+y2P2FDH047zSSOFpT38213xE?=
 =?us-ascii?Q?Ujl0A/WBZME9SgFeWSt9SWtqbYJoVfUuiKoOptEkdE3jMCLX/37V3Pd1MXj+?=
 =?us-ascii?Q?AWmnvblk5l4F12eYqwb8ooBtpgsUzEx7tNPY2A+xA5t9kQgGPVP0MEH+83ui?=
 =?us-ascii?Q?TGOwsneHcTZV1FQbxjLar9mHAx9dqvlJay3Js71Gi4OB2C1gNgJUSMNn7ajH?=
 =?us-ascii?Q?yeoI9VMwU2SQiYT/xOJft7DmCAxGliL2Ok/a+5Ai4IfwVzcluN3ysF94Zy8i?=
 =?us-ascii?Q?+poyNWgrAM1AOmXCPjJPrSI+ffdMngPZt9GTXbmAh6KL1wuQP0avlC+M311O?=
 =?us-ascii?Q?MIJxbEZ/L+LdSahrHqi1af3IppWfZuUp8oVxGxggUr7SY09i1nP7Q7Vaz2It?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f23675-d054-4df5-569e-08dc42d2ba97
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 20:26:42.2429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pEi7QCyM7Pixxle0hrm1PDRZHTbujfTmrlrfFEDPsUGq731+/xZwc8NS6u+EtZGaNxgedoPxZC48FwpUx0krA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10057
X-Proofpoint-ORIG-GUID: WmOjHEm40b5si5Lt7XQGVNySXQe8H-Pl
X-Proofpoint-GUID: WmOjHEm40b5si5Lt7XQGVNySXQe8H-Pl
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

Alter migrate_qmp_fail() to allow both uri and channels
independently. For channels, convert string to a Dict.
No dealing with migrate_get_socket_address() here because
we will fail before starting the migration anyway.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
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
index 7f6a14b19a..cda07f8f97 100644
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


