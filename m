Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6C4C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4rn-0003IK-1O; Tue, 12 Mar 2024 12:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4rk-0003HP-HT
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:36 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk4rh-0000iH-Qj
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:20:36 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42C85aIx008282; Tue, 12 Mar 2024 09:20:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=Qdu0lOdUIKGAiRzLxxb8GL70Wt2g6cWH8JYSv6Mkc
 AY=; b=zaLhEcFrU5Y7YfDgkWDbKJVyde1zd8tS20lUTecBXr4x4rWa33wtBrXAH
 A0iqcya9aKSqizGIidq9nxz75VtuN0zd/ekELdE7LlJi4hf+3R+aAKH5POzB3lzZ
 enrn8QxFofaniCwSP1NEdMoZg3lNpG/i9RdTa09uK1Rs8U5bRLtBc8nvvCNuUwIT
 XGhbcrvE9skl9HBLspdFVYTf5tGdsS0dBoufZ+4vsEvNQT1LQ0KRPW+ZiEJkWodu
 38Ix1QBgxN/k1gI90EwDtLUdvOWN7M1Ci6nN24l+Tbl4zDO1F8LgIV/R+GQ269OW
 joas2Td6tRH9OVFmlGN+t1vHcGUTw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrmyw6h15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 09:20:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GO+CtIm/gvG2H7yCqIshgML6RzOENqq1HPDZqBnRpLQy8SNFPX+0fKk0kLKQspdvInJnZ4QVvlaUTS8PMv7+i/+iX9dcA7d15sGZBHgbnVt6V95RPS6BWyADgPuamuIoMVnvvw1wwdLQiw88hpMa/EdjjeJNZtTj7ubbP/nsj3bzVF+rERD9/YRS4TeJPKo6NaFfhl8znDjtMsD1Tfy/jxqFSbuMG0Wk61X9jEL4OtyB22K+jVueRVpOxb4GRzZshbHaSQLEx9moOzyD0vEl1GG1IU3j1VnfWR8A5+1XEms4Mqib8a/NLXPRkKWs4FNKvrE7zEqSqbli4QwMRH8TDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qdu0lOdUIKGAiRzLxxb8GL70Wt2g6cWH8JYSv6MkcAY=;
 b=W+Ok94BiJ303CsfQSGWwFmtdQtulF0SAKTQ+3L5OFJ2e0oWCsTdd2SQmTQOUmm+w4nbUgd8KmIdF9jYfBHtqBOqEuL231i8yXohuSNMxWrYB7EGfwr9n0UUjpWbtxil+HqQ/1Zyhhv80ZnEUbBN51LW3b2VpJTFKSa2YaBeESzDJgzgenZQQJ7XyGG1Kb2PPK/hS2CCktHqVwY63RosNbmBv1YCG3UkzDEjsxzmxc43GD0L/UxZ7QgNQKSSYM9ErjpbFz6JMXyATwsJN3eAiVZGQ9DmiIg1Zms04e5WBZaqjwoJvrnyJQsdQhbel1SQ6leVS1/clZKMZNjwVEWmciA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qdu0lOdUIKGAiRzLxxb8GL70Wt2g6cWH8JYSv6MkcAY=;
 b=cej8pNrSSGOkANwkvq6eiN3SDRXB36C6jwSsTtCi1XJJydtdgne03kX5s7f4PQ8uf/XDXb54lUBCOTzKtkjSBcYJwoBEXYSJ7rK1qz9MQdl70en71s4L/9P7macRFt+a7GJOyvIQuEtRyAbfPW5+Z0iftF1sr2/8poDgC5oWcsAGScLUVlQ+n15TJKuD4V3Hbb5nIJHXAtIGk/IIrviKczlXRcYGqpVAk4JPGIX5bk/MaZuv4x2Xk8++iBQcv2vaEmnsvKScw8uJs5tRTFwp9Hb57/4sqLkXr4R2vD4I/lU1vM7RQGsNcP4/+scVeSs22ob7feDZVI1BrQasv3cxtg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CYXPR02MB10225.namprd02.prod.outlook.com (2603:10b6:930:d7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 16:20:30 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 16:20:30 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v6 1/8] Add 'to' object into migrate_qmp()
Date: Tue, 12 Mar 2024 16:20:18 +0000
Message-Id: <20240312162025.44212-2-het.gala@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CYXPR02MB10225:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e94a9b5-699e-4c3a-cac9-08dc42b05624
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /98UrlvpdV9sc77O9KhrJJvh7TR5JXfyuUUz5aMfRuDg2UJ4++xtWpe/sFeZoGw03+zo5go5HNzg2t3+VCnTMy/AsX2EoUveHumLZ4njvzV/fTZZmqLNsviKOnRSm3Nx1EVXcNbV/ir2QJrc2/BLQpaDpobA5/ObEvIeUUW4qTuPPd15wpz1fJATYsQQHL5OUCQYFpIAhZHsXu2EQQawyiPKwpaSedBhuhQWkH5fL8FhAlvQc+nBc5Q6CTG4+QhzH3gTIF4AmNRFiwSX7Bl6DHltF59ClTPnN5MbLeMOPFAzbDsF4kOBv2wado2HP+rbK3322tDHO8lShmmhfeLS1fjsW7ebuRMMkyYz7LZ0nx4JUTm6PkHAEfmbz+lDN8tCjk4AZwk/PQ9MhF6JYqU6S3BY2oV4CWwD3LRwL3Z4ZfTEQV9ZT2lNbStS3ucIWEFmBCcvc85dak3cQ2vIlhDuEn/qv++2Ouz0G+MJuSEThufxNnA+ujaNRa8DDF+/CsMEECIRIT6xWVtdawzPJgFtVaF1rNZxl1B7b4y17Xm5IGktn7t8pqmvu+m1NarMEDH1CczBmnhPUfoICQ6VT8Gbge6d2D0/mebzt/UY0lVxWHEaZiC+i+oNa8231fxsw1aFbnjzFwGDnk5Xjy/8LxzuS2J0IRvRF3oQwjk6IakG1dvTolWNuEwiLMdozBQiLwqFpAJOc4krb41zmFUWr0VcEfP4S+jaKOo0AfD91HZ85vM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hin7Oxq9A1/435p3FB9S5MDG3jXE3tgmOy/DvAZuIOqdIIvMTk+/oXCF12OP?=
 =?us-ascii?Q?sZMH7dEpHexfJEFsjBlX4bV7w6a9ck97Xdk7evf1yr7QLi6gj+au+4EvUew2?=
 =?us-ascii?Q?VXuLTTIac/PQMhG+PmFXEGnxYcbX1z8V1lXj4sI4HxoMep27+aE1lTgIar1a?=
 =?us-ascii?Q?rJkwk85B7xe32fjUqDRkMgvOp2XzEVDCSXTSMrugI54/pciUoHs9qxrA3jb1?=
 =?us-ascii?Q?NHkIvLSl6e5uiVkeLiTgS7maROYydAUa1LaqFfzwtvvX6yx1OiMrJUs0yNFP?=
 =?us-ascii?Q?NhW0z3l0koqLMrQ5DyJluvU4FAWO/dHTus2ck89VLlhN1g4+uEvffZ4WXrhs?=
 =?us-ascii?Q?+mQkco9mVtobYSi5hlPzLEEUEh8ojano5CGerOjiw6q8FYtozk/JmarouPds?=
 =?us-ascii?Q?vj5DT08OF9XHKbDNCDO7D2/TrgX0XGUFh+Z5ulp+8zkoitIhFJAdVxME2zP7?=
 =?us-ascii?Q?kSs5NykSbZgTLb/WQuRirmpUSOk9vV/tjsvlJ2u1xJPtgOpkF26sh0OEUtJr?=
 =?us-ascii?Q?pXgvlD1rUnlooNUuISrF4578/iFiNov4NZmBJ36YisU01pbURT9NXdjrdDEE?=
 =?us-ascii?Q?1XZlKKwTck9ttJk22JKlZOVYDeeWca4kbBTByK6TYXaj9Jw4dGt3Gdri7Zu5?=
 =?us-ascii?Q?ixG2+g9dZnsVZpUFhcS8jlGgSjkwGY3m03CXBtvBz33LgoSPtQdQ7SvIgFy9?=
 =?us-ascii?Q?v/NFl2VbQ+B8Pe5w1gw5lg/JuFaeRzvmCNpvFSZkBTprg0ut51Us6rT4sIXn?=
 =?us-ascii?Q?NDp32d0e++f0GYDJa00yg3YiGlicnfMcy1aFFOETLEhYCvOrYTZASctNkOWA?=
 =?us-ascii?Q?AUhqNm+5Az05qDbRzLaCAAy04UtBkPCP8MxK9wYqSH1BwQcc7Bpjy8EyJXBP?=
 =?us-ascii?Q?G1GtOvWsR6bbs6tmhmreZQXrZQsh5xs1TSKzaasCnlWnF58tQttIX+UZYa82?=
 =?us-ascii?Q?rK4w/rfKam/IH4+yqN7oT54A9rhklNgAsaQ69eZ813WCZBBv7Tue95Fbl3az?=
 =?us-ascii?Q?NYqh80DEDE/xYGZm4XpSh6FkBPbJxqQuXETRdnTCEVFO2T+yZDOabd153OLQ?=
 =?us-ascii?Q?9wqvkBslorYukMSdPS68ejIUUJ9rMa3auIlL35OKQgfRCG9JyGl6c+xr0MlB?=
 =?us-ascii?Q?TnzZhalonLqhtNTmvBtuqe4xM3jN8t3MP59eOXb4PoEAvAEwyN3n7qjaG0po?=
 =?us-ascii?Q?LvONSjbbF0iSnShtHq63YQITE68MBqnKyNAbRyGvsw6aiN5wKwH+xtN+EW6F?=
 =?us-ascii?Q?LUebgOqwZf4FbzLZmlSPRQCa+3Fmmq/OPfA6ziLTCOCxDjvrkp1cum/k3eD9?=
 =?us-ascii?Q?PBZB9CSS8YBjCzdjofwDZlNlMvNXbLZp+v0KrbXL95H2IHCXhE/AnIGwEZv1?=
 =?us-ascii?Q?XmhXPjV80YXUYV0vHYOF6z6Z5ToxB30+bRRPqiWLwDqVYKguOUvmIXfQoIaN?=
 =?us-ascii?Q?fjqWpEQMLiqn8RNGiQluSWaR8oyXNe7d37UnVy3SGKPWaQrBC//B5GsQCqHB?=
 =?us-ascii?Q?8aebepvcfQZMx/B6J/y7r5s4c3aLuHcyCdvk1Ia5V8jlKucKtknL2iaVbcJZ?=
 =?us-ascii?Q?eMWdjzqOec57jdQpx0YeZ46bo+qm9hJBatFDU/wy7XfSuGZGxea0yBtzzTrf?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e94a9b5-699e-4c3a-cac9-08dc42b05624
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 16:20:30.7955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRSe4aV8SxZgylFa4WJNeuo0tsZVQ2CCLPCRHXYh9cgwRgUyyE+TGShSyNM8TlvEFcnBDc9u3xXQ7FBnk1q7+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR02MB10225
X-Proofpoint-GUID: NadnurzsIzSokPIBzkDo7p1ZQg-R0eK9
X-Proofpoint-ORIG-GUID: NadnurzsIzSokPIBzkDo7p1ZQg-R0eK9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_10,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
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

Add the 'to' object into migrate_qmp(), so we can use
migrate_get_socket_address() inside migrate_qmp() to get
the port value. This is not applied to other migrate_qmp*
because they don't need the port.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c |  3 ++-
 tests/qtest/migration-helpers.h |  5 +++--
 tests/qtest/migration-test.c    | 28 ++++++++++++++--------------
 3 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index e451dbdbed..b6206a04fb 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -68,7 +68,8 @@ void migrate_qmp_fail(QTestState *who, const char *uri, const char *fmt, ...)
  * Arguments are built from @fmt... (formatted like
  * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
  */
-void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
+void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
+                 const char *fmt, ...)
 {
     va_list ap;
     QDict *args;
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 3bf7ded1b9..e16a34c796 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -25,8 +25,9 @@ typedef struct QTestMigrationState {
 bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque);
 
-G_GNUC_PRINTF(3, 4)
-void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
+G_GNUC_PRINTF(4, 5)
+void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
+                 const char *fmt, ...);
 
 G_GNUC_PRINTF(3, 4)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 4023d808f9..d9b4e28c12 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1350,7 +1350,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     wait_for_suspend(from, &src_state);
 
     g_autofree char *uri = migrate_get_socket_address(to, "socket-address");
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -1500,7 +1500,7 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     g_assert_cmpint(ret, ==, 1);
 
     migrate_recover(to, "fd:fd-mig");
-    migrate_qmp(from, "fd:fd-mig", "{'resume': true}");
+    migrate_qmp(from, to, "fd:fd-mig", "{'resume': true}");
 
     /*
      * Make sure both QEMU instances will go into RECOVER stage, then test
@@ -1588,7 +1588,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * Try to rebuild the migration channel using the resume flag and
      * the newly created channel
      */
-    migrate_qmp(from, uri, "{'resume': true}");
+    migrate_qmp(from, to, uri, "{'resume': true}");
 
     /* Restore the postcopy bandwidth to unlimited */
     migrate_set_parameter_int(from, "max-postcopy-bandwidth", 0);
@@ -1669,7 +1669,7 @@ static void test_baddest(void)
     if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
         return;
     }
-    migrate_qmp(from, "tcp:127.0.0.1:0", "{}");
+    migrate_qmp(from, to, "tcp:127.0.0.1:0", "{}");
     wait_for_migration_fail(from, false);
     test_migrate_end(from, to, false);
 }
@@ -1708,7 +1708,7 @@ static void test_analyze_script(void)
     uri = g_strdup_printf("exec:cat > %s", file);
 
     migrate_ensure_converge(from);
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
     wait_for_migration_complete(from);
 
     pid = fork();
@@ -1777,7 +1777,7 @@ static void test_precopy_common(MigrateCommon *args)
         goto finish;
     }
 
-    migrate_qmp(from, connect_uri, "{}");
+    migrate_qmp(from, to, connect_uri, "{}");
 
     if (args->result != MIG_TEST_SUCCEED) {
         bool allow_active = args->result == MIG_TEST_FAIL;
@@ -1873,7 +1873,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
         goto finish;
     }
 
-    migrate_qmp(from, connect_uri, "{}");
+    migrate_qmp(from, to, connect_uri, "{}");
     wait_for_migration_complete(from);
 
     /*
@@ -2029,7 +2029,7 @@ static void test_ignore_shared(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -2605,7 +2605,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     if (should_fail) {
         qtest_set_expected_status(to, EXIT_FAILURE);
@@ -2708,7 +2708,7 @@ static void test_migrate_auto_converge(void)
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     /* Wait for throttling begins */
     percentage = 0;
@@ -3029,7 +3029,7 @@ static void test_multifd_tcp_cancel(void)
 
     uri = migrate_get_socket_address(to, "socket-address");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -3061,7 +3061,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_non_converge(from);
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to2, uri, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
 
@@ -3394,7 +3394,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3435,7 +3435,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
-- 
2.22.3


