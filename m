Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46F0C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8iA-0002CE-Ug; Tue, 12 Mar 2024 16:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i6-0002AW-1U
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:54 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i0-0003AH-3r
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:53 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CHa6DW029332; Tue, 12 Mar 2024 13:26:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=CLNPfbaUCeArFvd6JmUcyANr77lFeaCYh/Ads3GND
 I8=; b=LgM3eSGF4hmcCe4LkmuzffbiaFgDlkOuUmx/FozIREe4+WFCK92qpoR99
 gK47WZo3wIaJy+PEQbn/dfL1qtRtWNxUwI4JRSLR4HXO0Nb2oP/RyesJOOlyk9cy
 K6ChGAkVpNuVi0J7oQoNER2F5ys8Sln45TXCoURRd+QIBqLBQYnaQNPKOJTCwPSl
 B8pBFCKJ8/eO9Bnsc+3IWy/ZUhgN/XyOxLhB4LsZ2cuTK2bdptX8fzPPJwRqgv0U
 vQEH2EU76JJcbE4YNWgtzpSP+6D8Ycd2xfxJ0YFgc/bCkKjrfOakUKh1ug5t7V6N
 ynvDjUDIdfQFOzhiBmEn+xSKEq2mQ==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrqqhpvh1-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejOpeDGrK/XDEIaTsJcuHWO8+TGD+qTkMfXDo3107hTWw/Y3h9EQdHnhNZDmkf3BNEowrj2BGQGwpcPDumhQPi6aK3xOCVgJ6K3LEefZi4jRhKwn33NnP5jQPedi4EHbBGt5cGXxaKAH+pZ2Gk38B8G2wa+4AbgVRhCMIqATUgl4mTDzcXVp3/4w/raGY+lK5HIsVuOcn2bPmA0QhN15dJNtJmAcG6sn5awEtdv24xZsNVWGmUMASlWnVipEQeHFmC9Lc9qjseEB1sjTWTXDXMU9MbzCWM4050mYCBXJE4yHIbkCt+9DTwfCs5g2PSq6rHoKSn5IY0qYD0awKJm2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLNPfbaUCeArFvd6JmUcyANr77lFeaCYh/Ads3GNDI8=;
 b=anPfn/bw4hxHWtDZdiuqXjtYKed+HUuzy1Nu2trJ0MRBe6LS0gHzGPNZfY1OYS+4uBBrEcEKyxDd+eHiKaJzkFp3RCzwBAWJLL/xLU/Ixf+1yFCVf+8h7vJZsxdAUwoGHzWuL2iHCwiaeZ27b4qMglXP1c8hujxJQ6FY2kFYjQ/b7XczjTe7/uNoL+cNqErKFJd1ATfpSmVtpwAfYaILAnqhHITuMdKvK2yzTtdKYPbi6tlrEu26Dp3c9Il2RKyqQf3t1sLclVFYYjXiSrH56nfFBQdysc+L39/rQy1s4JNquQXCMn/9p+i06lASTAJjG+vCmqrhucmre7TuZ0ZpZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLNPfbaUCeArFvd6JmUcyANr77lFeaCYh/Ads3GNDI8=;
 b=rDoyVLd86l0u1xUpZ+2hCs4ANE2uZAkxPi3kdf4cCKv3YU++xBH/+dDUWThSBInpxmZfUqLycOlttcZA5BeKLiAa4oeMbHLyBjtBGg8hbKaa4Cd10UdMTS/UZaIajXERRNVNVS4To5aRPY7mtK/FpqcUala7T7e1mVhJRfdougJi9QgVd0B+IPXzlmX765Bxo6muLnKaM9vDsWpox8YQxWEaoDFyAtg6YfsYeEhuING9mxE15FmUCxMzYKwCffTQ6jT+dtSAL+r4FNvcb1uoUeGsbJ0ZMz3m5ws6VemClqiLAd1f8ZWMpXo5i6BBtlkQO+B8icGfoaPBAepwWRzlSg==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH2PR02MB6613.namprd02.prod.outlook.com (2603:10b6:610:79::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 20:26:38 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 20:26:38 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 1/8] tests/qtest/migration: Add 'to' object into
 migrate_qmp()
Date: Tue, 12 Mar 2024 20:26:27 +0000
Message-Id: <20240312202634.63349-2-het.gala@nutanix.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|CH2PR02MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 340d67aa-9d13-45ba-66d3-08dc42d2b828
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYkNuSmQjBWuBBw1L5n4tSMVxSb1OCXZprS91hErKIgBQakAmboOL1rYoOx7v4a/NSh3+x9BREr0xrC158S0/Z2iJM85N1He79Dt8wUsQekNTQewmwxBhNMRrpxW2/tg+5CQc160DAN6sAjS5lxuTtIhnmkeonCT+p0w8CihF+ywu/dL5gWf7Jyd4gHuay9LYshhww33z1g39563ijcw+Cbkt5qts3o84qYBBuuan2yVE5CUbvG9OYxfXLkKxAyl99Dm8X2mN6GeIslqpUKx5Cb0MaxImeqxfm3gfPV1Wc1OGR6qNuMHILwV7VEvrBqYzl2Aiqm2DcgenBNtt+6SEyw3mVTcEgYhEmMNHv6psaS6cWEbLwv8dNLVDqY9HSalKCZDXp2c0M+InxUV1Ewc4JiH6vEHMh3iYnxhYSy7XpjEwPwXHhoSeL86fHYSlfd45ekx+Le7yChLuC/6W7etS/QKjb/Y7Rw8BQDPOGf7q6fCl77tK773+vI/J+c4bcZujnf+d/xPM+4uK0OW2Y6J5JXDctEr45j/jypyIxc6NO27ht+/EB7zuNANM9/bZY4J36lBZRXfRbgYUROW0+xzGLoC/pWDdhacfN8Lr5WsczTYNPo3zO0YnYvBLoQW1PFVMoZS/NBpFPiIOHY2KLLFRDbfT5twwesHYmCuaCm0eCY4ciOFqIr9uczWcNZyRQjN1UzphaepeWJnA3AwHLB2mf70Xfu3BLMM2ODQI+iM9D4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tq6SoIxLFyV6dU3pvwLkSp4McCL5gWET9NrbyWDioTPB9D85kJlh94aa0s7u?=
 =?us-ascii?Q?Kl2dH6f9nf7WbY19bo5FtbOd1EDBiP8FPJe4XHmWgbjYZ/HL39GdF0zTHwMV?=
 =?us-ascii?Q?GYNv1RTOlGaqwc0pUilMuT6hPXSc7/ckKmsOcr/MxhtMd7jzmzwXIwiZJ4oK?=
 =?us-ascii?Q?M1JeGoZQNWlBtsb8UMSGSpefEIcUmTrNkjRi9Tyvfm7f49zi6dWp7EUJm5Uq?=
 =?us-ascii?Q?x6Pq3lRF2+7kwLJnWIavAtKDhX4r3woDeTnJpO8qWI+HpzZYL5xaRn+b3uwP?=
 =?us-ascii?Q?PyBwN/9ghAMTmsI1wzAXhZ1ZuaXJabrJLNiWDTJWs5pK3cDX6ReHrQ7XLsMT?=
 =?us-ascii?Q?jzfwWX452FUF0DQvP4WPEhnznyaKxTSv3FQyitZlJIK4hU7oCmC29zrGrX2K?=
 =?us-ascii?Q?KLx2l/mBqZVy2W0UPd2NJvENz9t8E+tMQYv8/1NDgr9vjlqcG7PN0T3vVt86?=
 =?us-ascii?Q?1ier4Hml6F9g2MpcYAm4WBlhwcuV8kssLtzGbHSkBRl7+LPVLjhZZ4cnfWxA?=
 =?us-ascii?Q?7dFIcCj5OVyc6iSGOAk2N357XL5XVH46BVStDH8WVQVCJMyi1mpd7a7u+PUr?=
 =?us-ascii?Q?RPoTqittTBQvtCBVOsx1jT4K9ERvWbEUFY5scdUEwCYO6OPCjRAXOfPjys37?=
 =?us-ascii?Q?JbTcuGM9bAbqzMzwAwdwuF/dhleRHoehNdgsGNCmucRv85tlTseqpl5lnTj9?=
 =?us-ascii?Q?3c74IINSW0Z5xo4hiKYOc/HXe3ToiHq6+T9dC4jnJ5jHIjOLsq8mJX/XNkTH?=
 =?us-ascii?Q?2Q5cAerh/Hd6mY17Rc9vhBKEn7ae6gMRn9psTF+S3TpCxJ3x+ceUiyid2uDi?=
 =?us-ascii?Q?GEzkcnEXQjJYYGQxtHzl+XOHGZ9mtuec+SNF06sHkz7KR73CwYC66V2RFTbx?=
 =?us-ascii?Q?An5211d+Y8htIEfnhBi90aUeut/gTj6KHf+mvyU4KvFnfFX355kqvopPIYwD?=
 =?us-ascii?Q?584TSHzGCFHUyKTi/i05UhbuNAErKw6QHQ1J5gCm1cWuEmKxxBMe4S+cB9Zu?=
 =?us-ascii?Q?RNH4C2WghnRQ6+UdCHAz6eYttY8yuLJY5xzDdMMsEM4sWTiHhFlslAeFfSBN?=
 =?us-ascii?Q?SlQ2zVR3XDbkdy5gJQumXxCDdBHGNMW6LjckoeHc391N6CDIKm8nqVdPOxDV?=
 =?us-ascii?Q?AseUsZQL3sS9/7T1JbNxrdtIGgp0E+EAS1lXCDj08FWw/EwL0v2FaOTa8tji?=
 =?us-ascii?Q?J6KO5kEW56DIcBqSWI6bV2CBCZsrvKYC5Oeo6/3Ztwj0zr7jTsa23x2AM6S1?=
 =?us-ascii?Q?b2Gl7rKVD4ZAzF94gp4fGQglmdJy5m/vlB1nbsO/gKuVRRIn9M6Ej0zmBcRh?=
 =?us-ascii?Q?HxQJ5dyl7TjdRvk5wwfCBJh4TD/e+3An6uTwXCbDQXQHG5wxl+2sLQzuI9Yx?=
 =?us-ascii?Q?h5HCBHOPDgzIGU+aNlEyVHdEZUQhog8qtSqrSv52g/LX4JHL1968l/pdshwH?=
 =?us-ascii?Q?u+1bo1HMHE3qYDQ3hTCYFLmVwkN4FUKyJeDfqRxKU/hM9uJCJSVXszXkJ+bG?=
 =?us-ascii?Q?E9SxynmFQCJwJPG6kQy+WPPzPQ2KgNTyWEXiSgPMkANiHX2cam3H+W3zjBlk?=
 =?us-ascii?Q?BdtWhZraF0IavzauzxdEtxbZCMq1ej6PZBQMii9BtXTfZxSPmJZ2CMAaoYN0?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340d67aa-9d13-45ba-66d3-08dc42d2b828
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 20:26:38.1225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNc6wj6yXRS4yY/LyKN/AWrRAPa10DCtVim9H0wUUxCZBjF6/R0i6nvB6iaNsdntjV+CBUraDpeQZsdXsWTrQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6613
X-Proofpoint-ORIG-GUID: 4rJwEF564LvkDXsHc2NVDBOM1F-MyiRG
X-Proofpoint-GUID: 4rJwEF564LvkDXsHc2NVDBOM1F-MyiRG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_13,2024-03-12_01,2023-05-22_02
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
index 71895abb7f..dc1fc002f5 100644
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
@@ -3077,7 +3077,7 @@ static void test_multifd_tcp_cancel(void)
 
     uri = migrate_get_socket_address(to, "socket-address");
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     migrate_wait_for_dirty_mem(from, to);
 
@@ -3109,7 +3109,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_non_converge(from);
 
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to2, uri, "{}");
 
     migrate_wait_for_dirty_mem(from, to2);
 
@@ -3442,7 +3442,7 @@ static void test_migrate_dirty_limit(void)
     migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
 
     /* Start migrate */
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
@@ -3483,7 +3483,7 @@ static void test_migrate_dirty_limit(void)
     }
 
     /* Start migrate */
-    migrate_qmp(from, uri, "{}");
+    migrate_qmp(from, to, uri, "{}");
 
     /* Wait for dirty limit throttle begin */
     throttle_us_per_full = 0;
-- 
2.22.3


