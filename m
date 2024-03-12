Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F73C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4rx-0003LW-V5; Tue, 12 Mar 2024 12:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4rv-0003Kc-7e
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:48 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4rt-0000jR-AM
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:46 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CDUwRr012926; Tue, 12 Mar 2024 09:20:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=lpeZyO/AkWR3UvydOmRQiK24k2sCcPECdlmaeXVTW
 E4=; b=GEmLgCNksGMjbOOsks+lMmAFLxwl7Aj51PlZOH1O65MDdkAXDsPwNIwaU
 zeZrnP0qYc7gZQOkmR3qMN9Vx2nnRE61gTztof3CmJrrq4FZy+Tfqr34vZ+PnwOd
 HtI32O333EXn8tYVkyL2iJvSc6PuAZZTyT1kbPPMRIwepTTtW/8AhKLioyqueO1K
 //zCfl8E6Y4GvfF5FJIhCyepJCSVO2ujInjycAgen8C7azj1/IEOnVvw300SPWWV
 oVaiyn5r2Ja5uLEqsEW4NZPHhVQtrrODM+e6an3O+3smSAUnmMASOoQObp3WWqVH
 UTzHIRvXzC7AhfdTEskKw+YPpeEVw==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrr63pa3e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:20:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyPizOH7CvyknfWXmfOEd0fGXqT4dLtjSODyu888deUxIrq2wO+Cg8jXRos9OKTf92jNzXWVsj2PRbRycGS3CQCpOqys20duOewetseiLUPxxWJdvQWCJTRED7uwvjMT/FmZ51uwnXk6rnYYLgzrcIO3cUjLuhxMiOrHljzcHL0PXz+wvIbiZ0EICihP1OyaWLs+aTWvC+NMVIHjp2n7EPHOjgf/Pxn90vL+Wmak5FYq4y2SSsIlMpa1XOWjYsdBUt/6xvxjhE1hlB3F6Q437r+ISJ/rP/7RJV3jPvnDSYtpsOdUXeOBBqffQAtpdYLgtEGvpT+uDP3to3mtzvB+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpeZyO/AkWR3UvydOmRQiK24k2sCcPECdlmaeXVTWE4=;
 b=ctwxOAuguktpylwUlCeDwqebeAS9Jo5zFNV6SK62JafYd3N55D0qSvfIonlkHPLSErm34KSBIYifj7nSwWYXXEVb5arhJ7XQZG7zhDPLJeNiZVUTQM66kqdTHyGnv7+m9kukcPFhxoUONkkQPHvCpp8vKnTqzMKdxRQC6ovStLSIKxiThEVYIjz7aklxl1aZeE2yQwOwoTHWjBifJ4ship2bWps3y2lCzcw0sju5339Sq21B64eEYEbU3GT/WZiukHCgF0SMPf0Gm5qplIZ8cz/japFHKCTIrFUYDuh9o2Kh/Kz1XpvD20i5h1abWCDwRRTQbYzXiy6Pd7DNZtbqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpeZyO/AkWR3UvydOmRQiK24k2sCcPECdlmaeXVTWE4=;
 b=mF49sz9Ef0zHmzrQyl3aiWigvboLoo+yotZ8/4+Zf+W4v3WDjRomcnt1PF04ZGvv25LcapLTEZgJAvXHsYzCMsv/VEGc/ihmUI5RBD+4f7Zd6daKoM4Ep6pc6jppYAexLpqfO2N9jNL+SXaqD+6PnN3LvPA0KqtlrdAaXrco67einr11mxhnpafmfJ0WABaTapSkolsuVxpRpZX/I+exSoH3m4rQmAjNkhD4QxNYR+uxQtfGXv3JLy3qD0aV+Iln/kCiw97lImpSe2Jml2OqgL2xoWidR2JnxW+e+XbrkvdgtBmLLpR77cI9qL2KuKS6479iSjd/I0ILkJGw6TNTSw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CO6PR02MB7570.namprd02.prod.outlook.com (2603:10b6:303:a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 16:20:40 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 16:20:40 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 6/8] Add channels parameter in migrate_qmp
Date: Tue, 12 Mar 2024 16:20:23 +0000
Message-Id: <20240312162025.44212-7-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: fd43090b-41eb-4a6b-95a2-08dc42b05bce
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KbFWpQFxla4atA3w20TvEFgWhUVmKyC86H7E+QcG0EQOIuRXHdviLXd7NiDF+Q4OQVKy9oGr1rXsdE7SRarCdt2bfz8vYHv7XIL2DSBB0VIYdl8D+lp0WJOQe4IA7pNcyWP/kIHBoC/zmsiK6n/+p4RQsLiPA/fqCAgAD2/pJFUKa6Qi1W7w8DdUIEzluHcVr1bAmiOvKxD/uiJE36tw3fvShExnAkZEPyMh9JjmwhaIJDz9dcdsHcTxqUwQiZgRHmkV+tiq+3ULy9qBX2HlFKsucsQnizzE38jyEkKdGCu/dLhZxkmbWuaE4xVlqcg5k5Cele1VFFc3adKRY2rMINGAJim3qQCJrWAlsPqfawDRVKFRX/G8GqMYgOX0G0Mjwae7PDOarBAW6m9fQMOHXaymGGb1QLNp8scOha1hpHMNum4wNJlk9MEvvxxA9nmP+HY+vq+4KZrQ5mUZ//PkGRo8xo0O0kdGKV0K6Q9ZMhKF/qFhRNNIzixHB1aa9oDow4XCc2qlVamsAZclU4cGJosN2xMedwqx1XlCH+2pMRnOYdmajIPuMrKhfaeZ0/wLHAIG3bDTxqNosiTxlBMPuo8qustHetlnKL/A8ELjfVuJaK+YEGQ7zl4O0RbYxUKvjBfcoE6cjVrFtHm2+KKUUxsBY4ZQxJ1Sbrhf2kwXr8RfK/45WvJxSgr2MGul5oeEJnFLl/vE+b/HOh3V84tu6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zycFAJ5K8OHFa75kBXH+2+a2d6YnSkAfdxw2kxOvOBAAW/Jq4y7g7VqNkvCc?=
 =?us-ascii?Q?EgFTJo6QPtFeRLI9gMBTHarzPzwwEASauepZpW3WwsJd1iTo6E6o9m3ZcncT?=
 =?us-ascii?Q?tzQC9CzwacvoiwUGiaRjhWSrp23dqr7NoV7mUX0cfqSVPTcwa7dXKkZ6brWs?=
 =?us-ascii?Q?X0J//srxtss+Av9k8xcG9f7eaCWouB2E4hFSj2oJ/ODMFRA5gy4U3QA7w0/C?=
 =?us-ascii?Q?5Pie9yV1xbN0xsWRCOiUEwtVKm6acDV6afRrR4Q8PgIbE+2DqtXc3JTgQWqB?=
 =?us-ascii?Q?LnmAFw/ZO8tpIEaFqATHV5z4UnDVfQWBYbmouJ+7dgcai+iJcZY9Uz6MSy+6?=
 =?us-ascii?Q?PFtxezEnVhPPOoI+14jkv53hV2qwiNYsqRy806vqqrv9isFOF8lAvuoHB3d/?=
 =?us-ascii?Q?7sN+Ne1/TBBtzdsEstGc2sod8WLaFPGe7AjT3rPHf/Wx4Ug2+0D2aGURcRQu?=
 =?us-ascii?Q?SbIeqDkClV18WUDgiLMdHeQXMgOE5ywEjZsrPD4UYcJYtfSMZwOWrPAWUrrB?=
 =?us-ascii?Q?7/o9KIrfHJhrpc2CQ8ZGX04WjIPYEGrAULlDz0qWzJcTRZqDZWOVR1CydSmL?=
 =?us-ascii?Q?6zOZekVVc6hIXhK1yY9KuSBleJGyr2PyGGSURTzuUTyoOPmZAIxhhXNQnkp7?=
 =?us-ascii?Q?6VfKJscZM4flXZQZYGAuFfhiYxg8wp+JM/OK7kONQZnxQQVv+CNuJ4ZTZLjl?=
 =?us-ascii?Q?OZh2NttcvZPebbKJvAYNpPX6PwtNezPy/h/gAMjbJy1pb9XotdmyctBUchep?=
 =?us-ascii?Q?vkkbBWx8lYs1wbCy1CkmhjpwnRVZY/jcjeuYu5ru0HW45kOqksU5HaPiOvnF?=
 =?us-ascii?Q?Xwikk4HNjzt5gZ3xvQq8z80NdU+TnhYmbL3MRPvKwWsnlhy3P+ZgDzsQGlm2?=
 =?us-ascii?Q?BC5h0H1FrRH8frQPwup9MGugmVEGkOucj+QIPt3naGfikFI16mgPDO0I2TrP?=
 =?us-ascii?Q?8SWWmQCudWVNJcZrujb8b6uuxn23QFxcrZm0tlgLuDToPWRJ+nHrgf7s/lcQ?=
 =?us-ascii?Q?MMlFOUxCtBJ0oZRCfuQ8lSMh2xBcTJ8/0/StzkCmndk5AoH7gryxqpRnbdH7?=
 =?us-ascii?Q?jTMxAVn1ylSThSZa53jR8USuvu8NhEBLQZPpms5rlEUmyBAIIjqRrVUdEFhe?=
 =?us-ascii?Q?dNxfVXaCxzFQjk6E8fl8VL9n0tfbsSV1Ob+A7FE+/U+lnCdtdxBBz5eHBbup?=
 =?us-ascii?Q?ddSV/nxxqov1PT4ILbEURFKBR1s3JjT1UdzXuph+8IH3DmlswrIHJU4goF1F?=
 =?us-ascii?Q?jEda2KnCm6zM+bAlIvBmDjGeyNNuQziJccyXB8Mp/0GA2mPB1hXNdcZe8kPi?=
 =?us-ascii?Q?LBHvpqEvl0lppfNx1LaHNtAV7WW/8DXAHwCwDhbaLxq5DHdal4uPRbwCTFox?=
 =?us-ascii?Q?UJiGxvcahODksYlbkY2jKO018C5imRH7wJUqChnxzKpAuTtxCGtqqM1jF0by?=
 =?us-ascii?Q?3FoykhztNN3zSoHpPg7Z/XHT0NYE3CvUxD/nYIvp062ZakaHcBeCPrzopCQ3?=
 =?us-ascii?Q?1dDMMIXG3AgtufU844uvNFErMiwUVIUQNUAKr4zOOBLLhwwDRYhMpCKTz8rr?=
 =?us-ascii?Q?I8i217YnUI814l1CdGCWsh2MYapO9hXruH09bmZpRvX3lTsRphMgI2QnkRRa?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd43090b-41eb-4a6b-95a2-08dc42b05bce
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 16:20:40.2684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnUcdIDqZNbnd2HHZkVVkVXLJugChC7bf4duUhpWf1AjjuxcALF51HrKAibl0OxKpZWyQ06HIsnYxyFxUt1XoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7570
X-Proofpoint-GUID: 2P2Hbn0xv6L2RD1hT9bn1q3Kj1p6kXtb
X-Proofpoint-ORIG-GUID: 2P2Hbn0xv6L2RD1hT9bn1q3Kj1p6kXtb
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
index da4b0006c7..bf27766eb0 100644
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
@@ -2969,7 +2969,7 @@ static void test_multifd_tcp_cancel(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, to, NULL, "{}");
+    migrate_qmp(from, to, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -2998,7 +2998,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_non_converge(from);
 
-    migrate_qmp(from, to2, NULL, "{}");
+    migrate_qmp(from, to2, NULL, NULL, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
 
@@ -3331,7 +3331,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, to, args.connect_uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3372,7 +3372,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, to, args.connect_uri, "{}");
+    migrate_qmp(from, to, args.connect_uri, NULL, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
-- 
2.22.3


