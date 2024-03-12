Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95673C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8i5-0002AU-V4; Tue, 12 Mar 2024 16:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i4-00029t-NS
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:52 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i0-0003Ay-J0
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:52 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CJgASa018660; Tue, 12 Mar 2024 13:26:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=jxChpN1xW9+jt2YWnERa7o6NC/nb8i2+41QdZqBf/
 Mw=; b=qdwpcs2hTeYxG9IkTY4dCwAy0RsKPTxJbXngXny2TOddm6/Zbt/un332C
 Ie3y8ABgBbmXnvn+MshZjxFUBgYWAy4cj/Tfca2TGRN2fYLeXgWC+QevHk48F6Uq
 BEvTKU5L41MXxBy1iOfy/CoCO8TKpw3FbwrU1ah8gy0wFY6YQRDHdgDhk8FM4BsV
 KwoFicgF55KVyxMGSkv/Bv+QjBSM/QS2BdJjF6rd8kIcDnYvS0RikR/M2kTAImCd
 w810omtVx0pkOREL14Q9mQzRxaIvFWXzyDVLjJRr+wP7z/HBBX39jz2BLpIsjIF+
 QkCfUd7/qaySo0QdKfxgWhrdRMhhw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrp6axxgk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5v3YOsK3Vq6Q3XbnlxiPBdLcxxIqttYt6XpjPlSmbzfTpcbtR47rl4Dvn/hZBLjJesVAe9pjlx57WQsVGSCnrohl5QH9K0oPgjkGXO4tmNxomtvBLyT/9KbtJFsIzy3O7B+wTcS5qHvVm06RbjYR9fFq8lC0AM6stZ2l8LnV0CA2QI7fweDllpXmdM71diYOAuhh1yLl37i7BXXvDz5tG/msMxQdWEM4CKRu7yMofwsalpYCIHGKICxxnqNWR5M+ZR8EHooqN5xYY18owN3tjwSc89Eozpk/PD321TzlQWoogMEzWymROsGmT7yE6sHPQz6n0/K5rSKQYQth2yigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxChpN1xW9+jt2YWnERa7o6NC/nb8i2+41QdZqBf/Mw=;
 b=ChrfbosWYZksGX6T/UbIMN2pIbaJzIiI+Y3iIPSxjc37OG4++V9xspEUj8sgy5LWLkBSg9/vNu3bss0I1L3ww4VGue8bHYRxytwmFMxnSBYv1/oZh+Dkab4wJS1VKTrWzuv2106MJfsK2qXeQj63u8pac1zdrWxshSXk8SByrrmmFrOO3PUs44dKx78zLtECh0JCCSTKsqY/l7pfhnXWHLZIoBs6I8aIJ4ET3+a1TS9xOAzPxdAytFRuwwQUKsSdA+IvcHAHWXVhCKrg3PYYp6ukRI7ySHENpwpDp3PWKXBftZN8yGQ4d406xTUlZXKmre6bZTTgGCh9nOiKzyFORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxChpN1xW9+jt2YWnERa7o6NC/nb8i2+41QdZqBf/Mw=;
 b=GSbqg0JYUO8saVRLYR6cI6irisssrWwztIgX/KjGIk7C7O+eY1B00mXvmkCFKbLcRL/ZaHnclkr4awIFuk3ii5ROKNxujkluAh05P5vLpsrTF9RaBqoubWS7hv/t5B9InbqpvzKZEvbPI5HOu4Gz4d9xISS0o6L08XBPaHW5qx8CzTfjuZTKgMeRjegBKuwBAZdPq+YssM2k6PZIbGBvWnWiRmxOfHU8zGB/+Kl34jpOgQV5bpGvvEo3HwTFe4hwFtAHDi82hS4pCxgwtzidViwIgmkfKT5BGm+Elug4WOz48pO63fn7CpQ9dERM57cPuSK1QNWdr1JTK2PwFz5Q+w==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH3PR02MB10057.namprd02.prod.outlook.com (2603:10b6:610:19b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 20:26:44 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 20:26:44 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 6/8] tests/qtest/migration: Add channels parameter in
 migrate_qmp
Date: Tue, 12 Mar 2024 20:26:32 +0000
Message-Id: <20240312202634.63349-7-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: e2427d43-962c-4918-1af3-08dc42d2bc28
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iEnKuPk3X9hDYEEnk6vxPvXT9CTWuJw5n6w4KGEFl8hqvRHKFtkDOBWwK1vCU5LSg5isBedxM7+B2cVvfkwjdNoDPeJ8qzTI0OgKCAGgLm8mHI9jf3CFVywKYT4P1I4uXX/r/c2AvLM99ENCOTRusTU0JMN6Q/MA8deIyCOUiI2n4/dKcopvJnX7yaVwRTSxrs5yAk1gVBqfODCZL/C8KlGWhVbF6Ns5k7Un/EkKUebX4X4rLMTrDO4j9hEFEiaD6dsYyrhXtPvGN+YV4w6NmvFpZqpEsi9V0jCJKIV/3lhc7smUJOeSDQGoRbhPAeTUsl0FPZPNuiByaQN9Onbj0/diE4DR/7+Xcu2FEGVfGZCtNrak8p6lK7RCCqYKSQHxumanS+qJnTLECYFcr2slG7R0kz5LGza07hJI3C7PApxJczfmXeBV4xKaH9/fr/ui3bOVVbQx10iFvO7Gqps/gv9yge8Jf7Ny6/wamI4E6kEiakv/lycP2GMBr2Vbt1U3b2twKz60XWsWfkcMBf9D5y2xoMjnhTNIVczhk4uMrP7mlZ4+McIqL4fmbWWt7vGEy9XbG/wudNWAJ+EN/OhyI4nqw7XbdrhyIhF1syvDwZadi2zcSZ7Cd3twY6GQ+mYd20K2qCj8l67a5luwhtp0CRwzQvHLK0GYRP9tp6cvpYIjFDLLqW3larT9JpIj9YjOUSZ+IPBpRwU4fgKvF7fMSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VEvtYcZIV1xWUrm+ficI7X+8ZR386E/NVunMs4ykl67HmEknS65OmhfQTG5+?=
 =?us-ascii?Q?gGGPPAC6pSM+iKdbFGmut62BxyCAXkFQwjBOZup+W1KDwrSU//zSu19G6wUR?=
 =?us-ascii?Q?/7ZmdsiuSkKd7RFW9w8R5yt2cUGZKILFB16EYoGaY9Eawh2N+fU0feuHGAnH?=
 =?us-ascii?Q?XXdNesHbJjLtSafQmd4q60YMW1gAHBNBqXgDHqhdpp/kQzR3pNDzcDG2h1Z6?=
 =?us-ascii?Q?s6JE8wcFdRE7P1xJyKyKSgIngMxSrFpOCyIPRsk5tKPjFcNvJLteMJIiFMZC?=
 =?us-ascii?Q?B4sMfZLw8FX2c4/+EcFJAq7OzAcvYBK7a6y5CST5bz9e0IyXpN9ZmEq9DhfP?=
 =?us-ascii?Q?Ec36n0Fw5JIl7mDkf4sApn07DQ5UfttxCS5cyUYeX7H/5szWmM8fezjktG/F?=
 =?us-ascii?Q?kfrgc/5lRXOoGfjbZ3VFQoNvXXkhByKs9sJbD5Y01QiDx1EHfT662WMBe9fP?=
 =?us-ascii?Q?N6WNgJwOatiPFNI0w3mmF4MLNpwrVqEUInaSonCBky4+vMeiv3GJ/4oq1q96?=
 =?us-ascii?Q?0UKDifo6cekCzr8syrlJLHu3fNPNC7kRDkQP66mxbd737nmgWhpCOWoO5pDC?=
 =?us-ascii?Q?EhwxoIHsUv+WsPetuvyBdsobBSveT8idtZyqTeRvwxT5OAlNMwqHXC8W4Fhi?=
 =?us-ascii?Q?i3p5F4F/A0X+dW8RfXNGFf9/T2Ryo/Vh30HPb9x+u5REw1znBf+evCwreY2e?=
 =?us-ascii?Q?pxV7mifCGMYio1Lgd5bIfvzm9WnJh/05Aun2dRQ9QPx5KTm25U2r0NvQBWki?=
 =?us-ascii?Q?igVcIhdKvdQ0K7MA8WNNss5wyF14jy3md6rIdmWLogLZdTK9hGl4/JwEP4Mp?=
 =?us-ascii?Q?trf3HxaJ4IfV6lJqMdqzZjUGsm43SBh+m9Dn7U5oBmVJoxtUPAqUF2/mOUWU?=
 =?us-ascii?Q?vUl3lXpwvovANEsjyaKZj5U9nVd3s7wJ7kM1uJHaYA0vj8NqARTtAZu945du?=
 =?us-ascii?Q?v1CxvhKqkAYXtnvVDr2Y9p5z6LyTNLwO5UcFq7ykrXP80K//JIsXl2pPpc34?=
 =?us-ascii?Q?fPWdqgOruHz515lU3KbYaeXv3y8cSY9TxSjbvKkUXgUNRGpczqNW+shOk95z?=
 =?us-ascii?Q?QDzvQd8/ZBH1rpQtGzx4J6jEU8QIrgdhyGJAcGx/fEKUEtMA7DdHZ8SR3sTJ?=
 =?us-ascii?Q?hjl/9hT4FE5M3QIPMmoB9ZXc6J/j12z3vGHRfvO8H6OFMsqqoIpVjAcalm+q?=
 =?us-ascii?Q?SM347QHzdyWDEj//ypi8XBMgA1Ai59uGecAQT/yrUFRfdeARigYnP4desGqd?=
 =?us-ascii?Q?Ae705W8w1DR/cRQCVkFfHnqfnWcB5aBtDrTy1a/cHe1lL3so1KKdGlXFFd9S?=
 =?us-ascii?Q?t0lWGKqp2unGga7W+PCy3YecVa8oO17j1Gflci1O/+1t2OjSmeKGeOdASArJ?=
 =?us-ascii?Q?CNWBrGO///GncjoZSgpFLihJvbhT62duI7Q1tTJ+e3FA9qfbpRSpurHuXQFQ?=
 =?us-ascii?Q?a3QGmJ/EPIOvBO6jo/fVrfQGwfIvLeV8WN9P9yrXTJ5FDKojJITGmBHSeDHv?=
 =?us-ascii?Q?D2m4oU4/kOC3ZBNjXuZbRZrXOh119DAKtn8aORkSTSmwpKmPotkekce6p2oo?=
 =?us-ascii?Q?bNZ2hHxpC8ZEQX8x/9wJfi01yrNF4wENiFcNvNOB2Q4CSFxwKe57wn87/E4j?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2427d43-962c-4918-1af3-08dc42d2bc28
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 20:26:44.8297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y5L7T50vH/YTvSjqJC7ap758tuNEirbXsXGnOiOiEuZaENAVp2tblIko9hNoRTGJ7V1AuRJ0ptSW/pQuvDEzJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10057
X-Proofpoint-ORIG-GUID: IZx2vQsPIAjDWEyd4YEd6uTUPKKGA0zZ
X-Proofpoint-GUID: IZx2vQsPIAjDWEyd4YEd6uTUPKKGA0zZ
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

Alter migrate_qmp() to allow use of channels parameter, but only
fill the uri with correct port number if there are no channels.
Here we don't want to allow the wrong cases of having both or
none (ex: migrate_qmp_fail).

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 22 +++++++++++++---------
 tests/qtest/migration-helpers.h |  4 ++--
 tests/qtest/migration-test.c    | 28 ++++++++++++++--------------
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index ed8d812e9d..b2a90469fb 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -133,10 +133,6 @@ static void migrate_set_ports(QTestState *to, QList *channel_list)
     QListEntry *entry;
     g_autofree const char *addr_port = NULL;
 
-    if (channel_list == NULL) {
-        return;
-    }
-
     addr = migrate_get_connect_qdict(to);
 
     QLIST_FOREACH_ENTRY(channel_list, entry) {
@@ -208,11 +204,10 @@ void migrate_qmp_fail(QTestState *who, const char *uri,
  * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
  */
 void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
-                 const char *fmt, ...)
+                 const char *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args;
-    QList *channel_list = NULL;
     g_autofree char *connect_uri = NULL;
 
     va_start(ap, fmt);
@@ -220,11 +215,20 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
     va_end(ap);
 
     g_assert(!qdict_haskey(args, "uri"));
-    if (!uri) {
+    if (uri) {
+        qdict_put_str(args, "uri", uri);
+    } else if (!channels) {
         connect_uri = migrate_get_connect_uri(to);
+        qdict_put_str(args, "uri", connect_uri);
+    }
+
+    g_assert(!qdict_haskey(args, "channels"));
+    if (channels) {
+        QObject *channels_obj = qobject_from_json(channels, &error_abort);
+        QList *channel_list = qobject_to(QList, channels_obj);
+        migrate_set_ports(to, channel_list);
+        qdict_put_obj(args, "channels", channels_obj);
     }
-    migrate_set_ports(to, channel_list);
-    qdict_put_str(args, "uri", uri ? uri : connect_uri);
 
     qtest_qmp_assert_success(who,
                              "{ 'execute': 'migrate', 'arguments': %p}", args);
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 4e664148a5..1339835698 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -25,9 +25,9 @@ typedef struct QTestMigrationState {
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque);
 
-G_GNUC_PRINTF(4, 5)
+G_GNUC_PRINTF(5, 6)
 void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
-                 const char *fmt, ...);
+                 const char *channels, const char *fmt, ...);
 
 G_GNUC_PRINTF(3, 4)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index cda07f8f97..62e52a29cc 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1301,7 +1301,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     wait_for_serial("src_serial");
     wait_for_suspend(from, &src_state);
 
-    migrate_qmp(from, to, NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -1451,7 +1451,7 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     g_assert_cmpint(ret, ==, 1);
 
     migrate_recover(to, "fd:fd-mig");
-    migrate_qmp(from, to, "fd:fd-mig", "{'resume': true}");
+    migrate_qmp(from, to, "fd:fd-mig", NULL, "{'resume': true}");
 
     /*
      * Make sure both QEMU instances will go into RECOVER stage, then test
@@ -1539,7 +1539,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * Try to rebuild the migration channel using the resume flag and
      * the newly created channel
      */
-    migrate_qmp(from, to, uri, "{'resume': true}");
+    migrate_qmp(from, to, uri, NULL, "{'resume': true}");
 
     /* Restore the postcopy bandwidth to unlimited */
     migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
@@ -1620,7 +1620,7 @@ static void test_baddest(void)
     if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
         return;
     }
-    migrate_qmp(from, to, "tcp:127.0.0.1:0", "{}");
+    migrate_qmp(from, to, "tcp:127.0.0.1:0", NULL, "{}");
     wait_for_migration_fail(from, false);
     test_migrate_end(from, to, false);
 }
@@ -1659,7 +1659,7 @@ static void test_analyze_script(void)
     uri = g_strdup_printf("exec:cat > %s", file);
 
     migrate_ensure_converge(from);
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
     wait_for_migration_complete(from);
 
     pid = fork();
@@ -1721,7 +1721,7 @@ static void test_precopy_common(MigrateCommon *args)
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, "{}");
+    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -1816,7 +1816,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, "{}");
+    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
     wait_for_migration_complete(from);
 
     /*
@@ -1972,7 +1972,7 @@ static void test_ignore_shared(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -2548,7 +2548,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
 
     if (should_fail) {
         qtest_set_expected_status(to, EXIT_FAILURE);
@@ -2651,7 +2651,7 @@ static void test_migrate_auto_converge(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
 
     /* Wait for throttling begins */
     percentage = 0;
@@ -3017,7 +3017,7 @@ static void test_multifd_tcp_cancel(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -3046,7 +3046,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_non_converge(from);
 
-    migrate_qmp(from, to2, NULL, "{}");
+    migrate_qmp(from, to2, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
 
@@ -3379,7 +3379,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, to, args.connect_uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3420,7 +3420,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, to, args.connect_uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
-- 
2.22.3


