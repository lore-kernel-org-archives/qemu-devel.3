Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FADC54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 21:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rihKM-000426-QD; Fri, 08 Mar 2024 16:00:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihKI-00041i-Un
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:22 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rihKH-0001OG-2e
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 16:00:22 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4287pWAj031930; Fri, 8 Mar 2024 13:00:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=Z8nTmlQT5ZeS8q2zI8Whk9TWkFw5aGmL3XBKq6Xty
 cU=; b=QTn9bW/61IaTwjf7usm++rdiXzICNJpygw+Ah0m1tFUxFFx2lAICbOZ+r
 +FiVwQBYmq29t/iJUbepV9ElVwnmnGc96OuhFGPehEsHjhOEGf2JDmMyedGcszNX
 DyNepHmArK6axOXLd3NeHTiZUxl+449gxTjPOwE5LIqiUnH06M3pfdRjkXYvgvU7
 BN1N9Xx84mhfWoFxUo00dZO6sRzi3DqRqs98GXBj33Cbj0C6NbBFtoFs+YJOFjpX
 Kz2mplD5T0iDuk5xO1sKXDyiXErXE4HIc/NzmKUYpvhs95KZ8lgNgPnbZwzRJYd7
 +yXJHTmS80MsX7VlQThOKmdRUMC+A==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazlp17012019.outbound.protection.outlook.com [40.93.11.19])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm33q6vvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 13:00:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cJIYfKG+696s5KEo4qcRWiV0jRHMybwQOARVmks2CjaemSunvVTPp4lsaBrb1vUsV7ySz57/OIlpKFW3OYU4WAbYlmj7gnqDCLIc34GGjGpvC/TAdeyjAKNBl1RykQDjpz9G12K7p3URtkGlUd7/vtg2asfqrzlHTYe5ouNIpkPpra/cDNYaCdwUcFcSXGxwSTEKCP96W7ZnpOCb/+FGrqbrVYy7Fxf4BPNN2Xnu6vp6OlV4B7FDZC4Z0Xwh5mC4vdNQLUEVY7Kj2AaOLO6b21RfFykLvaFzQziwFbFQ6Xhcz21YD/3/hw8n8CAM70CvM6bPbMeQyEHN7i3dkYYFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8nTmlQT5ZeS8q2zI8Whk9TWkFw5aGmL3XBKq6XtycU=;
 b=am3SV/GeQxxguJpH1DZYLzWiFJVXREfYCglZgCjJ3YdAlrnbAnDwMrCcjsX3KPkZ6NwaWjPXPGcPLysL+vauvJnt2+T4Di6/Dan8My+MhV+8M1+q3x46u9BHIbyko6ws4Phf4z/ZY/d45+7yNRyEPeLRfX9NUhntVuFxBbi1xg2gGIetpTMv6xMPnJ/2VSx/Gns1ChpKEL+Tb4ytYqGn6WZEfsM/OdvyuNx0SJMlU6+q5ocNz9NQUUjFfjJoL/yulF5BJZ1CxPP7l4SrsuuCLqctZkLfZvU7pJK5OahPY2bqjeyw9c//EnhgPNM0sH7RSaKUTnJRETx01GhYfnSnDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8nTmlQT5ZeS8q2zI8Whk9TWkFw5aGmL3XBKq6XtycU=;
 b=Ok97QAgiaSuUy3mz9yuY8T3jKknZSry4dTQMT2nnzjYNKtBtMw3ibENJZyicHLBns2hwNPuAFNHHB+wJIbxLS+3phj/HfoD9nm6wbIAqwNTgBnd/NVnF0ckxwycF2gnAb/hfeLrx4UYRp8AWbarImzKpxvfUO8vJTah091isIUO6UjWF3VJfhnJeWS1TXzohPhaHTt9S1uHvUGTUWbiHI4PA4sWU2wfSng+x4BuMR0r+VGj9hOzx1O8rthGKeDmbC5uLvO9MpWF8MNDZR1c/LTwV4Ewy8ftyzWodFxza6UKHUxceylwei/ZDjxhP+KhR52kUJePwYI+38SkoBFYBmg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by BY5PR02MB6786.namprd02.prod.outlook.com (2603:10b6:a03:210::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 21:00:17 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 21:00:17 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, Het Gala <het.gala@nutanix.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 6/8] Add channels parameter in migrate_qmp
Date: Fri,  8 Mar 2024 20:59:49 +0000
Message-Id: <20240308205951.111747-7-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6abd58f6-61d5-4002-0894-08dc3fb2c24f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yD43f+tM3V5kFxvhA5Ze/N3zOGp0m/pP0GkQ2O3FZBzWgqvPCI7iDKPCGuvAgcFdjpvRIVc1psLrDK3EujdhnmWYVh8OmKd9jk222sDqgiDWhEJDZ/zsQENpj17gv88JG9C+JQK+eJelxF0waENlsgyIPh/ngRu/phAHZSMo/60XS8uDwequpkF6KfN2ojwWDX9Lm0xfb84b1+UudDhWRupV56XA8iJobYHTM8WBRxiiAwTHGLbVykD7UdnGENtVLfO0IlLtqU0wqeB3m0Zx/uF3UYPJ7vF405owylIJYgV65qZgbmJhhcCc/OBN1MOqBH/am7mSm9ANGxEG4V6uzlcZbO0GczCOIeNeiJpr+qHxYAlAEFrKZQ/emC5cketqe5mBh7WlVaOIBXfYz0TZQNjKNJlllky3NALMZXS6CLt9+JzXkTjcPvP1XzbXvbmYmiuLpOxLjdxo9Ovcqqx0L9xRNjCSxVj3QpVJwwIkUrVoRMfMiTfZ1DCxD8C6Eh9JseXUBoITxisUkrf+gwF4RDhhtOW/LV1Sk8rjdgzorD+9/kRt9QYjlqhDE6DBKDSnLabOoS6od6CbvDhBmCk8rNG+IGOHRqCK/35BBA+U1ICsitjdv5ic3glseg8PzqR4TZtpiKfCBYxG1HV+QDVheExq5I9SqKs4P0/6mgksKLjVnL3Na8GE03YZYAdiIEO590zF6rv5Su907hcziS0goQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ld+g+YV1dIrGxcr6cUzSAzP2g3ugegzQVOsmcE3FcvxGRUp5JvMmCETYUMuc?=
 =?us-ascii?Q?mrzDL2aolPg0OOf2JOAE+Y9GVWeuyY7XZDyHnh+UV0ACilUkjTDXIcwN0xIi?=
 =?us-ascii?Q?YcMUNw8yuXX/p8/mbkP4UNmj97IP3ayuwm0J3zTjYSFNuLQjSyzE/WOVmcI9?=
 =?us-ascii?Q?hjBhEDNmEPY2FFAFNXs2lG6/43/vf4T9zrANwa40O8BVTtMr0rCJpwREcoYt?=
 =?us-ascii?Q?qSW5Ss52NsIjophB15gFLvULHB6eR9GdjDMMvxNf+KYRgpwy0aMe0PQAgLvg?=
 =?us-ascii?Q?UiubNPoR08Nl8vk5H4tsv23uVr5qaDZ4cjRmEE1NUiEaxXB7uSC11Q5yaXUy?=
 =?us-ascii?Q?dY4I46184b3PtBBlFYOYm3anL5D1Hdt7EUy1XZxS/zRIsHuUt10Ne5UoUH64?=
 =?us-ascii?Q?j/wSEcYejfyNxNKWGFGmRvdB+itR+YVO2GVfpB9Qs2MBEXDU4JicchAkjKE5?=
 =?us-ascii?Q?zI+Bnsf/E+uaZ1CF98SXUwmYPYVLWXoZnxbbLmj5dekUXWUJEDHeq4ck41/6?=
 =?us-ascii?Q?mxN5LIYpHYrOeV4Lo3Iqo23chWuvIbNJ3YDTd8BW1smCdnYDpSUGP3tRHSdC?=
 =?us-ascii?Q?UBKMRwD9xHNy4Ip8a99BjzwsaymAb9EyVBp3W0FZPHCaqmJFmt607MXrVlGy?=
 =?us-ascii?Q?vSx4SvHiM2EEQlk7M7H0j9zqwlTPevuhba9yUhL402sQcOY2ndhGNUDf7Sk2?=
 =?us-ascii?Q?BxZ8esofAL5zBEF01nq5ClsKoaIQ1fKS69pNqZQHclrrrItD/MNXKZXqNvm2?=
 =?us-ascii?Q?UPKv9S/kr+kxwEiOXxMHQMMgXznc1fwmz40MmMEBs80JEhwazane4pYFzvWs?=
 =?us-ascii?Q?mw4eZdIB128ojQGpVu/auoVBHVbk7UZ2A00cTmxt/PgjK91YlcSaMvv/uyK9?=
 =?us-ascii?Q?nQHc6FxZcZpx/PtJX8t7Sw2vRkCQEdt8wKhjIguTsV7+NhVZ4xpZKz4Grwu/?=
 =?us-ascii?Q?NDjt3bohNzEUXAWWcs8LG3hSr587zxPGGJ+2uwBJ5NpgClPuE+tgfFHrvQF4?=
 =?us-ascii?Q?ZoP3UZ5booDFEyWysZxO/HAllUgp1jILlqyC67wUB4y+Is5XmOlMORmnToc3?=
 =?us-ascii?Q?dOgimAxBjZu6Lkow8LRxQqeullEaAhLAJkHy2NbzCICTdS0h4kWuJYwyz4He?=
 =?us-ascii?Q?/+NcKQpnjFRbhS21u1ZNsjCU8pjrRi3boin+9amAElh4R2xpNzAFC+tPkSHF?=
 =?us-ascii?Q?4l0SIWkplSwZ6XR7w1VZT4knp+VuP5ezO1m/ebU/UNN3RPbbr4dY3geh2t3O?=
 =?us-ascii?Q?gVJv6pbKLBK3nxS+GUkL0vQjdTV+hPyrJiDAdaK2QU162C5pdO1Lv3tB8nU7?=
 =?us-ascii?Q?p1yLiAb/KzUWNes+kbaqZNMeFmpFoKNQiIyGjZecKBwa+ydncb+JSefytJuY?=
 =?us-ascii?Q?GivNfyyxstadCCAnulnyZHAqEOsQXVAOx+6mdmp8X3PlVlTbOdoMgAzAtaUj?=
 =?us-ascii?Q?2sCNEsAczVCrqhuhZjqJgBtpGVkFYtX2GEOrVF+1ThILUQ43DrKv+CIb3lUA?=
 =?us-ascii?Q?Fdy69zZuLtoaEvrgTOvEb4ybmvfLgXzrQGKlzzKLVRiEVIUAJXhCVM0cegWr?=
 =?us-ascii?Q?b6h06r+k1HcR29rlPYAsdpUQyU5LicBS4HeKHuoBfzmeYAqvmfst+iO7dWcL?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6abd58f6-61d5-4002-0894-08dc3fb2c24f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 21:00:17.7512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Us+N/pwql9fDFPOaoBhnbo9I0n/r/dxhe14xJbjVoH/3a6s4ECV21cr4UqgM/zb8H8lR8bzBnyzpoM2easMQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6786
X-Proofpoint-GUID: aCJnmSSe6hhyd3Qjn565o43vWBJ55zal
X-Proofpoint-ORIG-GUID: aCJnmSSe6hhyd3Qjn565o43vWBJ55zal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
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

Alter migrate_qmp() to allow use of channels parameter, but only
fill the uri with correct port number if there are no channels.
Here we don't want to allow the wrong cases of having both or
none (ex: migrate_qmp_fail).

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 22 +++++++++++++---------
 tests/qtest/migration-helpers.h |  4 ++--
 tests/qtest/migration-test.c    | 28 ++++++++++++++--------------
 3 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 7c17d78d6b..bf9fd61035 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -135,10 +135,6 @@ static void migrate_set_ports(QTestState *to, QList *channel_list)
     QListEntry *entry;
     g_autofree const char *addr_port = NULL;
 
-    if (channel_list == NULL) {
-        return;
-    }
-
     addr = migrate_get_connect_qdict(to, "socket-address");
 
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
         connect_uri = migrate_get_connect_uri(to, "socket-address");
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
index 61aa53c3f7..b1e5660dbf 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1305,7 +1305,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     wait_for_serial("src_serial");
     wait_for_suspend(from, &src_state);
 
-    migrate_qmp(from, to, NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -1455,7 +1455,7 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     g_assert_cmpint(ret, ==, 1);
 
     migrate_recover(to, "fd:fd-mig");
-    migrate_qmp(from, to, "fd:fd-mig", "{'resume': true}");
+    migrate_qmp(from, to, "fd:fd-mig", NULL, "{'resume': true}");
 
     /*
      * Make sure both QEMU instances will go into RECOVER stage, then test
@@ -1543,7 +1543,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * Try to rebuild the migration channel using the resume flag and
      * the newly created channel
      */
-    migrate_qmp(from, to, uri, "{'resume': true}");
+    migrate_qmp(from, to, uri, NULL, "{'resume': true}");
 
     /* Restore the postcopy bandwidth to unlimited */
     migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
@@ -1624,7 +1624,7 @@ static void test_baddest(void)
     if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
         return;
     }
-    migrate_qmp(from, to, "tcp:127.0.0.1:0", "{}");
+    migrate_qmp(from, to, "tcp:127.0.0.1:0", NULL, "{}");
     wait_for_migration_fail(from, false);
     test_migrate_end(from, to, false);
 }
@@ -1663,7 +1663,7 @@ static void test_analyze_script(void)
     uri = g_strdup_printf("exec:cat > %s", file);
 
     migrate_ensure_converge(from);
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
     wait_for_migration_complete(from);
 
     pid = fork();
@@ -1725,7 +1725,7 @@ static void test_precopy_common(MigrateCommon *args)
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, "{}");
+    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -1820,7 +1820,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
         goto finish;
     }
 
-    migrate_qmp(from, to, args->connect_uri, "{}");
+    migrate_qmp(from, to, args->connect_uri, NULL, "{}");
     wait_for_migration_complete(from);
 
     /*
@@ -1976,7 +1976,7 @@ static void test_ignore_shared(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -2552,7 +2552,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
 
     if (should_fail) {
         qtest_set_expected_status(to, EXIT_FAILURE);
@@ -2655,7 +2655,7 @@ static void test_migrate_auto_converge(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, uri, "{}");
+    migrate_qmp(from, to, uri, NULL, "{}");
 
     /* Wait for throttling begins */
     percentage = 0;
@@ -2973,7 +2973,7 @@ static void test_multifd_tcp_cancel(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -3002,7 +3002,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_non_converge(from);
 
-    migrate_qmp(from, to2, NULL, "{}");
+    migrate_qmp(from, to2, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
 
@@ -3335,7 +3335,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, to, args.connect_uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3376,7 +3376,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, to, args.connect_uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
-- 
2.22.3


