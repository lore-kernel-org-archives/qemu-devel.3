Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C3CC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 10:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhorN-0006jE-A0; Wed, 06 Mar 2024 05:50:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhorL-0006c2-16
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:50:51 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rhorG-0000GC-DU
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 05:50:48 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4269IsHs002777; Wed, 6 Mar 2024 02:50:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=sXbQ2lVahxyj5wDXR/Rtk25By6lJAHCC9qGuKtZYU
 +8=; b=T/9bHKC3pKe7rmOrEv+odQeoi80Y8GHyBIZrdBrQX4mg1iXs0ZZI3FjnH
 9KHneBgyLNM/zwYhGW0KFzOxlN1WeNuh5Ch+cTlDGovVDdAt6yuRwDadiz5Ibpf4
 UEM9GQcJzOE/PbI8dG2hqLakCteirkDRL0rnfD29n7oi4R3TO3QCdnnU5SG9JJ28
 Grbc3fz/Kcs/lk7HBqE9lT7w7j844jZug6NgyzLoiSwMiPOU5zeUX3E9OqRFDHzC
 TGgoh6Nfailr+PaXI2nWjdyAoDvkQzwLZ/Yugtyeytqm+DPLhuscJWmzZvGbmiuW
 zGr17Bwl8BiIpUSXR64WXposjfbQw==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm2hb8h6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Mar 2024 02:50:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLu2M/l3OooPSqlW6gymY6ZoUeeEKvNsbuJals/oPgoN+1lkwuy4aguQWDLqFvzo+5BaVtk2mpp4xn7KPqrTIo8dH2ExC1oZDyrLtnC2N0cPEt2si8B+xMU4Y2Hw6FD1bIYUWVZll2M+WRp7XVeNeJsAj7U0qRufsNhFlxuJrapohlRXCALJkHjjlSLGEpDBou3lvuQaNDcAUrvIhw0K3nm/2+knDEAvw6FvSLLMNSyI8yYP7GC80IfsiC3LuGe+cM44FAxpKhEozNGxtqewahbj3p6+f11UcwmH/MTWf5PopkUa1sEOgyBUcguvuEGtdqHZzZAS6zReziIcD2RRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXbQ2lVahxyj5wDXR/Rtk25By6lJAHCC9qGuKtZYU+8=;
 b=mmo1AMiJtO6Xx27CFZVcC/VVbPCHxvsZpZXaDgMXsaHyJtxbBK6iRxJOwKSd+lmKhmjXJbuKNg5G9Do5mMCP8JfL3uExln7t5PsutwqMx2fU70YEfchi/3XLlZMhRRP5yDB198PPeFFZV5N2yP0Pa1sILl+aoQ5Vl5RGhcCm/nR+iD+XFq7AZxbaOW3s2M9YvUgiYMdfKC5AM0hlBpt6FF5frIxrYTsqVb2MOc5meAgn2sQ6uimCrrnmfEa2cLkYblr8T/geVhgD9P2atkNp4W4i5/N5WbEhHni00dntMvdjb6wAT1hVYZdB3EoYa/DygPSFPwqBkJOyVMvet0ZFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXbQ2lVahxyj5wDXR/Rtk25By6lJAHCC9qGuKtZYU+8=;
 b=Ofro6Sc1+GWyvB1tdxNLrCqI0FxYFHTiVAM3HELAss3MfC3BwSzdf9zWKjlYo9rgc0HvZ6S/Gq6LbZxsdCDy8IuELJG7GrkxfiClknjrgOrXjzeiBfX7MkAOfK58wx8EDVJLen5gqw3lAeOISPk4K1VWcONSmYxgW2WDStbAXrWMSy/CtY7DHsHQPndvavVjzuPivhPWWO+ROfnxRwuh3PtbeoIERf3+rH08m0if6a6KdxIXda7xWlFQlDwODFQXh2rgY+99P83Watd/Pf/XFAQbLkh0uoYJpggb+0JCDETZhxXgZ6QxzKhFMS9eTQo4e9LUQtgchg3DRJyEQqhrMQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DS0PR02MB9617.namprd02.prod.outlook.com (2603:10b6:8:f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.41; Wed, 6 Mar
 2024 10:50:43 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 10:50:43 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v3 7/7] Add negative tests to validate migration QAPIs
Date: Wed,  6 Mar 2024 10:49:58 +0000
Message-Id: <20240306104958.39857-8-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240306104958.39857-1-het.gala@nutanix.com>
References: <20240306104958.39857-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:a03:114::21) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DS0PR02MB9617:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c135cc5-c1f4-4369-1b18-08dc3dcb456f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ay8yvhVuilTAuTK65iYs7xLq7YP6bAeH2OYC8A5EVXypdh/DufIxWeQR4+NPkbDU5DO94kV1IF6kar2Exy2LWAZ1qKNnnKUZuPvPMwvNUYtyItCqiLmcm9g2KPTgVnIFi4oig2fL9aaOrB8M9vD/F3jGzmZbuiPfIDXyg+kzk6SAsweSvQKUvpV1mENklN7vu9gUD8HkPeSxNKYPp7gHLmYA0PkrpclfgbLSuwgzNRpJ1gEHWv63gwd56eNb6wcVjrAU53X+FO0pZXFO+y7oGXoBPf078x6ogpfibg5NqelXNZxprT30KBB2v/TPW9HLfARvlSM4/H1n2JH47s0wolgXMQ8YfF62Ved1foRsRolyIryi8e62NAVQW8poMLFqdVjNAzhqk5BA8R3ZfdqNvgf6n6MpAjYR5j5L9S4/87VfTGv7dn/3eyBuSHKGCYXpG/VIyT6gtW+eoG5Ivd77SMZnQjUMFFgapxWLw9AhSqMCD0ouqhN132FVPtpXolLj8HMUN253k9K/9PvdTTjPDbQf7aCij/nxvpCmgU+bM/XNX/nShoZ7uSCOUqVa1cy0e3ZFRZ3EJmhgHNZjomkAvAJCAe9D28RtqN744EX1XVv13PkY4h0wxpRWQfxPpLWuGqv9PZH0GfxiZIRsJukyjdbl1leLkazTxR6xSnf4xPWXAKD9ldSIfGj3r3l3ArXkfvPd1s7leCFEqS+ctg0Vsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kQdZERJ3zbIVkFaAI8MHD+Pki5toqPXc+cHRyNTY+SkIsAjrjHlzLQQycNzV?=
 =?us-ascii?Q?Bu2BoGtKrYUmFj4WuJtSTnLBsB4NVSVJ2JOJtxL0BkJD+FCFMiuuFFQZ43R2?=
 =?us-ascii?Q?yFXjJ8UefCeC4mjeplvYekNgYwKy1tFF9kTw1TzOL5jlfeD1cDhfsCa6EDPV?=
 =?us-ascii?Q?Hznmixuk65hwt4jbdVkC06Q/WY3bmOl24lYvado2BqxBU0xjOpPl2P4IuiR6?=
 =?us-ascii?Q?k91elw8ssrdiUHUpQo3UJYvicCG3+GW/91lXHnneDTcEOn6weVWufSE5dvk5?=
 =?us-ascii?Q?RsrAf+v1RNoIb9WY5oIa/gOU8x9iyi8cDXtk57/VpOvwV6LI1WOZ9FXmrZsq?=
 =?us-ascii?Q?VyAW19WjLhiOBj9EKyrYjDphUpLguXTjktWX/w26XfmI/1NIcB9qmeHIelY5?=
 =?us-ascii?Q?K+k+04FBrE9Ucx3D1TYylnjDf4SIGH4eX6q5ptakacHqYfPPyfG2v0U/qL7p?=
 =?us-ascii?Q?05nk/Q8viNy5usXW5e2+hynX94tkChU+NkMlwRIecIh1WbaVunJnyAJkFGic?=
 =?us-ascii?Q?cEtvKDM4H1s9LmqFTdiaODDl67w9likFeeUJomDrIvXhUaYeSEkmvo7XzM0Y?=
 =?us-ascii?Q?1NGGD9Po40x0euf/haUp4SbbdpZfN55EEj83L6el+dAlwoEPl1eJhWqkzvsV?=
 =?us-ascii?Q?SWbrAomnZx8tPd/9lGx5FHO6Knp/omaZRSCXpc7itf6DHkcHfJIEj/f2Mzcr?=
 =?us-ascii?Q?tJMvnHVm/BGl3DhN9LP/tmE2imD3rDE7+/7+uwSf72Hmg6tzgNNNtQ4gtL4A?=
 =?us-ascii?Q?LkxcJ8UZ7erTtxUfQmQy3L8KkTNkINXGRYqeEqcSLJDbDoF4jZxHazUeStfb?=
 =?us-ascii?Q?oMR3yOvTgzVVRADEzuxpylOsOkX/ntZbDPEM5qHfu9wNz4LqhSuT0y/5VKlp?=
 =?us-ascii?Q?OrdDKFMsd/S6ZCDZB/DtpA40bjbV0i/A7TwQgVrjs6bmGS6PV3AV0piGN5tn?=
 =?us-ascii?Q?P8TOhjoxvLKLSyTb2HC37+abFB7hwORYjNXDIganSgndLZhDFBJEnZ19DTCz?=
 =?us-ascii?Q?sdI6yMUeF4w28wExRT1k0JlPDARirSOeLw02iB30kUvMBBXhRNtQq1vrBCSE?=
 =?us-ascii?Q?IZFZTTKgq3in5B7J8DAHvyFPktYchZhkEoP6FHFKsOmTGzviGlA6546GNubl?=
 =?us-ascii?Q?SHWaFPdYsqRGB0TwkD2JWJaYDgFW1ZkMSpMi7bS3nnXkxORxG62Wci1/mGHt?=
 =?us-ascii?Q?IQLluhmKtHLovLHe9MCVrcvIApWp229Z9bTCEwaNLLyzAmw+t8oGT81sLkmu?=
 =?us-ascii?Q?X5ylXdL5NUyoy5ih+ZQHkHXK/AUGKmMtG89cOmPhn6vt52pLJl83b29j1dNX?=
 =?us-ascii?Q?85+Nd08iFlcE5a0yz948mrV2I/1b8iMLycIlzSSDTf1z+lt+f7zEgWvzeu31?=
 =?us-ascii?Q?pzeXW0IIEfFv2QAOQjobRJ1BiAOwb2JCjPGe354k7jMR/m9EbuvdRVL9A+BB?=
 =?us-ascii?Q?2hMUl+L4ebiRwTQD3y5QdOvEfO2jtgOxxJ5wYS9I/RYMioCHiRoRNNZFpLsH?=
 =?us-ascii?Q?JhGiJsbij3Q9LV+XygSzQczFSsLk9i2QAoDW3y9UR3A0N7DkiHii8hEtUpDr?=
 =?us-ascii?Q?WKyDWcx/pfrW8LEIkZEblelqd2WDkDmecLhXiWh9?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c135cc5-c1f4-4369-1b18-08dc3dcb456f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 10:50:43.3349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxE0OqNOy1s5FfS9YYFZEmto0zR9nL5bjL8+IkLPMhbrYowQuo1eNkhcn31Cc0an5peLiSb45BdgBj9Gs8SYgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9617
X-Proofpoint-ORIG-GUID: PiEHKdwXM-whLRXXy1L_5c8-FfR4r5l1
X-Proofpoint-GUID: PiEHKdwXM-whLRXXy1L_5c8-FfR4r5l1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_06,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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
 tests/qtest/migration-test.c | 54 ++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 05e5f3ebe5..1317f87b22 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2500,6 +2500,56 @@ static void test_validate_uuid_dst_not_set(void)
     do_test_validate_uuid(&args, false);
 }
 
+static void do_test_validate_uri_channel(MigrateCommon *args)
+{
+    QTestState *from, *to;
+    g_autofree char *connect_uri = NULL;
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
@@ -3540,6 +3590,10 @@ int main(int argc, char **argv)
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


