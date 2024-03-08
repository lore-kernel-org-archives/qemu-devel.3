Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F5DC54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rihKJ-00041j-7E; Fri, 08 Mar 2024 16:00:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihKC-00040R-NO
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:17 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihK9-0001Nc-OD
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:16 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4287jeWZ031057; Fri, 8 Mar 2024 13:00:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=ZKX6PmgyWUejQgGzS6eT4tHbeRPAJ7rFbqSxbXSJl
 Hc=; b=E7QxIV9Yxr0KlE0P0gJpn9Tk2HFX6SFjBaz6H5YpxpQ0v7flZRPug2K4h
 wLUfCe+V46h00tyqHvRyVJuBH4wDaW3Z5le7LmNJ/W+/1nLE3ubGhCRUCmejSBwj
 436sfX3j1M4kqYf0yHy/PUseXyw3OJWTX52e4mAZuK41fC7EGC7g2ROAiRMg6CnO
 oqXVdPgMS6REDFaZrXpRyuA9W6ezZ8b0wkB4CgPPbeXPBwOwEAgJs11km7R6+3PW
 fI/ukELH2GvCSySw/x15xaZR7l2VUTxtL7ksnuRMaRlnixdQTLXxIinn6sCo5jtV
 WR1dGJ8rjnpCUtHAnz/bKiclN5PZg==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17012019.outbound.protection.outlook.com [40.93.11.19])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm42hp1m1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 13:00:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lrLHg5nmA9lItsWrNvk9JgeujlZ0rOQyoOO0260jsNjPOWpy0LSHx/yxFNZzumx/RqIVUSr5LAtg+q1aNbrB9sNVNj2UqLVNfBv9ofUfDcebMvVg/Tb7PUmGRPB+R7rUi1vMKVZvOoKCCGYqb5No59UCljG5Ve6Cr1uq+Kh3NvBcQkQ9eME5VKVrSA5iHo0A1vd7XmhDtF7SRj568Vepr+3/7WaBHc1S9kz83PSXFgpGgKHzFv7gG0xH7MNYZhWGL4Zu7E5sNrq/eShZsg+LeGo7yqh8I97qUOjvJv9Ac/u3zeI2OI03MGHqD4QTX6pMXOoG0ykMsaplEMZhHmUPng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKX6PmgyWUejQgGzS6eT4tHbeRPAJ7rFbqSxbXSJlHc=;
 b=HJlmASri/eemrUtnGuFVrAmp0DR218MlWc1yjQ80MJz4hPWFgaVTX7aKTv+3hDhabf2MYlYd67DeAVY1sZDrhXHp0337uG4HpF2fR9hUXNVnu9SQr9vz1bX0S1uzi/1gu8j2IA06VdXMl7PQr3qFjLu7CWJgJa2rViTit5fkeBk+nss77E5EHAV8kUwF5VGwO4dd343QL8RQ9YBwVRXQveDlIOCArxbtjd4FdMgO+eh/9jE+JXjKmL/dcoGJo7+hd3RrYiKQ2E/X2YVopU6PENunpfaonryTd0s4rAFk06olMCjebsM8lRzg0qESr7fVcpPahJ46E7PGh8Bl6wg6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKX6PmgyWUejQgGzS6eT4tHbeRPAJ7rFbqSxbXSJlHc=;
 b=CZ7OzJTw6VEOqnUR2t7wpIsLXxHcxXFbqJUG7ww6TYoDFewsGShP7iePgEbVdAZJMfBkG4DkE/fnvj4obTaZpm2FS+e8dfopoMe279m95hIWisGvJkvreF57paFALficJc49CLTUQUPD6Jn2vpGVoNHrPAuJtDvK0vzOolVfe9zEN71M/qIxScz7TLFGPCQ3nJj5HA0qYxiBNFsXXwMADGq4VaS4XhO9w3ussg0mw4bgjzdwFxLVER6fQXMnMDiqIUAQhTLAXYvjRAlZUnfaEwnRmBxhYLm7l5e55w6e5hHkyYJCdUN2bgd7BhgM0d4gdz9FvylrOHzL1/I2mveWzQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6786.namprd02.prod.outlook.com (2603:10b6:a03:210::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 21:00:10 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 21:00:10 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, Het Gala <het.gala@nutanix.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 4/8] Add channels parameter in migrate_qmp_fail
Date: Fri,  8 Mar 2024 20:59:47 +0000
Message-Id: <20240308205951.111747-5-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240308205951.111747-1-het.gala@nutanix.com>
References: <20240308205951.111747-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:510:324::20) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|BY5PR02MB6786:EE_
X-MS-Office365-Filtering-Correlation-Id: 2df25f46-2044-4034-bf39-08dc3fb2bdac
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fcdjv8lYy0TxTElXAgjgbPdxXPXhNxmfPR2v+K1rHi0NrHjQjoEyDnSAWNJM2Wa7dZjag8nguSbXN3fNfMCmu2xuhbYs+rIFibBSQ7td5OYElGnEBLVCjgf2pAsPkF9KYZiaKwxAGScYfrgQdPN6+bOrScmBOwjJZ/7/ppGPDuavXQ1IWe30J4Pd12DB2Qcf/UJ805QZTNO+AAE+KOL9YsgYPBvsKmVfm5p5rmogmKdMpHT8R3jlyzIBKZ/N2eetmpD02GHP/uVqk3zOW/1MsuISqOe6AqUs+jlCXpiROpGhpDh4GcBbej4hdOPXJJm8WCNFKTNpTFLMPvBtyNm4xim/CeCAjRXRl3pAynWBubbqakXd908r7tWdjnElSuphAZmZchXC04hqjA9MlUiYGGBk0jetohXsHL7cRZsE93rFwOytxJdRXiEC3jaP0DAIwW+WEQrhRXH2Y+0zZfzkR+DezrO0DoZk4u7GauhS+cs8BkFqP7EGlT2AC+CVuTcrdwWLGAjmLk1vELcfOjBdcQut0xfbPuOPh7LfPhLtdyBgscrrDKEXgXJyoW08noLT5Q6FpRTrgQPqHv9CX6LthW5D0f9ARW4wW+7Xh2L+XAGLzvjJovp41H7Rc1JBfdqDeTQ1zoE9mjaHxxyOc1lM2RiN+TaCXXzgAo4nQa4kk2bO37BgkNBA0jAXuMdB/bn4JuPPLCNY27nA7mq7B9IjMAcdy99SQjMYL8WpklpgICo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RYOzJAOeF+7x67zLjwbMe49qZ/EXG5Xin1qHKc1Cc5Xx1LBou8UQ4nCVnf/P?=
 =?us-ascii?Q?mCH5zi7B1wM1KjgWC5CFI0c7jP36FX1xBG08McQGFyI5IYHbrDvqCgGnCl74?=
 =?us-ascii?Q?RHlSQRtOoucoenfyU1ABRmx8aF7pVAdCBWIlYSUFUaU++IiyCQW5sx6EPPBa?=
 =?us-ascii?Q?fOdPP21fktKxFnZyHge5Un0NOWDzw3W5khDr+tL40wbsQYblpc6Q+nurWNQm?=
 =?us-ascii?Q?DBlpN8JBwl+GUxaekVB9moSW2P3FIns3VzNFaGbWuJXkVRSG2wF7wD5WJVXZ?=
 =?us-ascii?Q?qAQJWQFkAVVj+NZNUQL/xLSgMcfwHlUXm4ss6NRC5M0v97aKq6NDFVdoF92V?=
 =?us-ascii?Q?EaNTuauEvRAn8YOnZWLjvSgoyHZcao1MfRv0tl8XihwHFFoYthFqfqzECQjt?=
 =?us-ascii?Q?dv9wiuWcc7XZgeGIUhEzc3/lzkERaMJyEG5oJH2xuHUBKKqXgAOpWpFwfEwn?=
 =?us-ascii?Q?6hC9TtToXZscj8Ij0xkQekeHJvbB0yPcWCsD4Ljz11IpXykjSsYPlmj6U0bk?=
 =?us-ascii?Q?gyRaLG8CFoM+7+EFCWcBZnmH1qaAhK4OmoZ9vyqDOglbocMeQlDDZUMSkkWx?=
 =?us-ascii?Q?28Vd14rSIx6Ecz4VlF09fMJPjpNx5STw+A6UmrMsP+tSTtOljp9hWzB3TuYT?=
 =?us-ascii?Q?MTJgVT/954wlziZtLuHK05voP9WjWcZBwSAivj9foHTEU3+20qtfpYMYraTw?=
 =?us-ascii?Q?8npykXrr625CFxjOQh5etBGLq7tTHtuxuMvAvODlN9XozKZPoyemWTe3hYr/?=
 =?us-ascii?Q?ZQMr3BBkW1DpW8pNsJzGy8i+/boFTrwSJ4PWM7OPJiIOoIDqhhF/r1SVdNX7?=
 =?us-ascii?Q?AnV96WEuEdUKoNZb2N+9C6xdajSdpijFwXDKHRJ/8pV4FxbydQ2HREWWvaIW?=
 =?us-ascii?Q?o3dRbG4oP9JlfNyx89EL1RCnajC5GU5nQPP08dt8casia+J+Mei+YP5UktB9?=
 =?us-ascii?Q?RKz+o8dnVHyvW6K/3X6RlwLeyDl5yl3jfMWC2RvZA2Q2E9MVb4Smlkf5Vz9t?=
 =?us-ascii?Q?hXboWkbh1C0M3M6Fnp8TgXK82GYW4w+jNNNZIa6r/6+k3crfZJ9p8GEu5udZ?=
 =?us-ascii?Q?5EucG/UsYgMjiImVLdUyKFxjr3FhFJE7yyhm2cLaYIV5PIjQTfyOr+ja6ehy?=
 =?us-ascii?Q?uAD1ODMk1pVbnLFFlT6OJaW13bAUnv8x4n3eQGz7R8Zoqcx8wP+Nwsp03KWs?=
 =?us-ascii?Q?5RfSFOYjbDwjDeZRe3eQWyHnKnOKCYPRZux+dJ7CinHJ8CQDaCSCkhgsdsUz?=
 =?us-ascii?Q?kQPP8YIt5jvhgaFNm3Ce5G8nP0QYFqGcI5ScPfrj+6x1HBLpb4DnJfiPYg5J?=
 =?us-ascii?Q?cN8EOIkuam+Qdt3aZIOFEGht84XItGZoaZCS3sB/Kz+8peosdH2a6NvIQ5Wd?=
 =?us-ascii?Q?npMvJ3ifKndCWf+b+ZKpW5fP9R0+Lg7xVX3At48OHU/8WZuEbGlb1iduTnzb?=
 =?us-ascii?Q?WEFnH+pbcIzjEAp8iLY+3ikNvskx2rK2Fuq07C3552QWzmP7F61nuLEeKzVp?=
 =?us-ascii?Q?d6oTBn3uzf7OXByiySm3WB1mvAzR05N9OdVKUBN0DADetokonn97NaOXIb8S?=
 =?us-ascii?Q?Grp50y0XqR/Qq40sdmwqCG0ItiJ6YmHXTaRUofIN?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df25f46-2044-4034-bf39-08dc3fb2bdac
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 21:00:09.9856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHLYJ6R8NNsLruc8UM/4E5VouxyIGmmrAJt7oP1wxLcZoN5ZhiYYTE0VHoqWU5OMSGJJn+dXrpM4PtnuV7hAzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6786
X-Proofpoint-ORIG-GUID: XvhjonXErEAnUb5p8AJvZN1M1oL0WTHX
X-Proofpoint-GUID: XvhjonXErEAnUb5p8AJvZN1M1oL0WTHX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.572,
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
index 3c3fe9d8aa..91c8a817d2 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -102,7 +102,8 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
     return false;
 }
 
-void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
+void migrate_qmp_fail(QTestState *who, const char *uri,
+                      const char *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *err;
@@ -112,7 +113,15 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
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
index 01255e7e7e..61aa53c3f7 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1721,7 +1721,7 @@ static void test_precopy_common(MigrateCommon *args)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, "{}");
+        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
         goto finish;
     }
 
@@ -1816,7 +1816,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
-        migrate_qmp_fail(from, args->connect_uri, "{}");
+        migrate_qmp_fail(from, args->connect_uri, NULL, "{}");
         goto finish;
     }
 
-- 
2.22.3


