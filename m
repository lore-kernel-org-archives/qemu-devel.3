Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C5AC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXW6-0000Z0-5V; Fri, 23 Feb 2024 10:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rdXQd-0007Ju-1y
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:25:35 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rdXQZ-00033Q-Oe
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:25:34 -0500
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41NBN8iL030719; Fri, 23 Feb 2024 07:25:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=jPCpuQ+toVNWlXhpAET3psDJO71znfKvGKAJ2dc58
 gg=; b=kpy312Nyk/LDBTK++Gz5yZ/H/wXlIgCMXm2GBCydeBrDYS199xiQ1fzAY
 eWA1JXBGr9schKFTQaf5+ACjmCpSGf7GjJQ1RnFBdIoIkp+WQUR0lcUhataJhYvA
 AgTui+ffUjMMoLAV9eo3yU2+n6uX3yeTiAzKYyT/eysVW39g/IyNxKViWDG9a7JP
 AfHYdq5qwZBe3JoJ8n0oNY6I1AduTyaD/8rua4kFfsOGblA/agP9SNorubcD4T6+
 GrT5qvjqKCLeO3zZdYIgqlpZGsUtdIEJrVrl0KucOp5ExxMB7mBXqHT4O2h2v//A
 qaW+Tx13ClnBCkpey9E5wS2j3FNEA==
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3wd21u7wrn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Feb 2024 07:25:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsCaP5raXCwXSTAPOtsyo/EsE2HHGoPaV7rMLBZlCOGpGsrL1u8lpzT1pgKFAVdhgMvELbyhjYJM33GavRMfNdtZtHJ53cHIE/Q9kaQe5FQN1Ey/Zoss2mcvlHcsDjW2atZWghJ8obJoVg+l+mZRh5VSutJ0qnQ73v4xarbidFIxloXuLHt2zQIu+ybZmsvHLyobaa453fUkr5EqKwAwoz6sdBuQnDH+P0LGNo2JywdUY/Km1IEWlbawORrgiuQhyqBm5NAkrHu5vup9LY8wSqutOJ4lpKGH+N6TAl04iE3quEB2PlFSrP31MxH4B3hKqAGr4tmRJ3rBxVMhPPZoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPCpuQ+toVNWlXhpAET3psDJO71znfKvGKAJ2dc58gg=;
 b=PK9bK9UzGV+ZrSgXvGe4xKgakJiyrYKvaY2uoBzgaUMXzd9XpCFuFFndiWwvoSzThN+NKiZGJIVR3lNLj5NQttbQ3f4czJfN3d74ND3kT7o5AtluAyLg1OF8fNISFDWjaw2a3IMBRGfPy9hAY4sOwLnNrPspNTmOVAI83dNzAKu1cASKAYpE2k1Gcs0IM5lJs6SW0QnnKiJ7aFs6nvntzReK29et+cvkExJFLUe7TeBkmR9eQNGBXAQQv//AQZX6Y+Gb5cZGt89yx317X3onKH8dp6y0rBOFQXpzZhxdVo4TtOub021+D0fU1QaNkL73Bu4Iq6soEEoyTozeNjNiwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPCpuQ+toVNWlXhpAET3psDJO71znfKvGKAJ2dc58gg=;
 b=IWqSIUBy8miOWANd1klll6w6+bStGpBnlGa7sGc9O7Pg4VJsw9sPJstj3rzRTfG3VkH5D7h1DOgLLpWkLXfxPCy1bztvpNsBJgZunpi3y3UfmnSfmHcrEBXfvO6ejfAvoLFj9YpupBQ3aNOso3LoRkU8hlhFWHDbcRi3ynVHMLV8bsBEtTPMrHtobs/lcdt+UTDjNj72JovYGRfCK97uhGUCo5/4FHDhGvXHjQdVqoKGyAr+PFz7jdpFwOgKdt6edUDj9QsPIKJK3rZ7jW87tVUFOrl2/VseqUpAqySwdi8U4gEemPDIxhk0fCFrAuINT1nRX/H2l9L5cQwVbet7cQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM6PR02MB6794.namprd02.prod.outlook.com (2603:10b6:5:214::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 15:25:25 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 15:25:25 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v2 2/3] qtest: migration: Add negative validation tests for
 'uri' and 'channels'
Date: Fri, 23 Feb 2024 15:25:16 +0000
Message-Id: <20240223152517.7834-3-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20240223152517.7834-1-het.gala@nutanix.com>
References: <20240223152517.7834-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::9) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DM6PR02MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e396905-9917-493f-98f7-08dc3483a8ab
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqx3KnsncHSLLYs2kEGCnWnH3KkGvV8PGcQJWTh2wzW54zbu2iRqpbgW7kJjanLXy5nJdwGgIgDfwb9wRkCd2Nls0Baxp9joH/Lj6/dgBwcvsvxyunfxx3BA9BDr3v9ufqTY8/1ErydFNpmITTXKiwXZ67e8YXEZ55pyktGGc1YVElHwQup13La1iPDjmZ09uqoBR163d+WRhJrnjmdHXtKT4P0Ij/CRlh36z26b0q8lOkuiaUQg4VXmIcI8nBQyqyCSWH37BqjqJNfh6NjNca6ijSsZ+DYMWkHyJwlmw79fwMytIjRJfHl+MfHBh4SPj/tksjDNejl0XBxlsQw6DxiLChfBXhJ6BXfpHG17WcECm+oyhfWIQzHPSwT7XvAqB2tCEMxDyVE/kTFAVUuXE4emkN8QcCdJW91HKiIxQgaXRSsDidpPz1Hy9lZ+aPhapC4gkeAK+3clmxWt3zYoqDGp4tL8eNBQlWUolZMlFWHHnNuc1YRTlT262Wv+A6DoKQ6NWtC3sA5G7fvWmUyIF1kMiwFpN1M2MigIK6rsDz7mlO3pU6ITS6+E4vgbMO4zNyZb12xQh2qhPUak2EZ/CWBY9XXh3+NeV5A85nxfBn9P0opPbFfHpLiVe6BgebCG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zXEjDfR5mrtnHxq1AhAHy9MnUFdTp0n2B6lNtaMDqWOvCrTidqm92Rbx0nik?=
 =?us-ascii?Q?KhahxNuHccwtRtBPGN/WqlObWi8PtIBdLZ9CCN73IVHT9NMr+cMSxlS5LAzI?=
 =?us-ascii?Q?ryK7Z5Gx48OXbxSZ0H6AasBvz+VgNHPBXCXc5hFvzLIuqUaXzjEfjfadxrZc?=
 =?us-ascii?Q?Iw+t2aYZekXVqda+5stbTWaRdzRVg2rGTPN41CCEICgs9LIZMlwwbO50sQ2H?=
 =?us-ascii?Q?1wo989+WkIe8zKfT/W1HacuY85T+5Pgr45M/l2Odn2soTScafC6CoXnhstcH?=
 =?us-ascii?Q?ciUPcLsWtmFFyRT0GWrNTQt53uN3Yv3uudoVadmNvLhUBDQzWSwL1o0Ytocp?=
 =?us-ascii?Q?T0bHz5Vt4HlGOlLiZHsNsXwnFocvyJEOWegkKni1tOOX0Kg7LjS5GgHdOqVt?=
 =?us-ascii?Q?f8rR2mPzt1F1SxyGxVT0VhgwpawiUbTVsuDNBJdI7lxGHbKgk0puwfEQ0M6u?=
 =?us-ascii?Q?JvYEiDnGLY1V/S8Cg/4LmePrJX2mzM2JXl3SUVY9zu+IlB729gqR90B0BTp/?=
 =?us-ascii?Q?gyh8mSJ6TqNBsNcTKbLbmDd+f6cDLxAtwKEQpkKPgeBKIsoDjzwkw037tIHE?=
 =?us-ascii?Q?2xQolIu4ZIoYNuNyB9aIw6MOKhsa7UX8c5e94lq1lAvx56tVmAVEVvq61UjU?=
 =?us-ascii?Q?R4SAO/eGD+V1eFkInGq03XwF5sZyeg7XR+BsCMqRz+AL+i+mht32GqJ+8Ih/?=
 =?us-ascii?Q?GHhtfvBlkwP9Kp2me6tWD+ukwF9+aSlk/Jw6TqZi9TtXjw9oEvRWVIo6FVXD?=
 =?us-ascii?Q?Fw3j5GZakhJzKKiWBF2jsxa3xLgySVyiJNE7vrI+ZgD0qlal9lLhgLsgBMIi?=
 =?us-ascii?Q?QLo/1aOQSnign0U+r/1OxOx6X/DIROPN8Orl9VyEPrH7p0V3yVIWj2klRnWr?=
 =?us-ascii?Q?165RmyF2L+Bmx3wVxgT66JeW1VQj8dnPwJ8DNkZG97HYAQTJwkmiQ6jr0KV+?=
 =?us-ascii?Q?JP2f10I8L0vYIf9BvUVBF7KVzCtqlBBrxA2hKlNUU8u9UhkqHY7/87oHw22t?=
 =?us-ascii?Q?3rGWW3ATIV3yTec+msQXXyqzCS/BrTz8zyozhKJaFRdZqn8JksRqPjZ7OnU+?=
 =?us-ascii?Q?8Z2KeTPkoOCZhqOXlzYg22IkJeAg5WdD68ejVFmhHTkSfPCMvL3Uv7rdPj4z?=
 =?us-ascii?Q?9oLecGIDW4pBq9j8kJrpLvTYrB7cSSkX3uGSp3VIlx+A+kRq+ltQxb0HyBI1?=
 =?us-ascii?Q?4d90KJg87U0l73T2jMYiUOT974oQEFBxjMVgSP0lSje7TDhhSIJxnv2P5yAs?=
 =?us-ascii?Q?lnNqZS8RQMRza/3iqIgPp+Co9p8rLirDmfUSmGp7EAdWao4qhJ7+gCKxB4dF?=
 =?us-ascii?Q?x7f5ZtLKGBAihPuFLd4Ub4piYY5vt1EBuF+cbLjfbuErL235u4ruP80iPsiE?=
 =?us-ascii?Q?E5qPYMcr5LRQlb/NUPOXRO9ZJvjEMDNpzZP5eP4YM2OMQDmtiFyyF4sHyx7j?=
 =?us-ascii?Q?uT2nN4ZDHnE+oPjPw03NEfKQHQspJBbRPpGDh+t8JPftubEi50N60XRhnNmB?=
 =?us-ascii?Q?qn0wS2Acm4a5w9GFtcUOKDjaudR3hAUf3NeTHwxQHsmpNjY3APrVwHPLtikf?=
 =?us-ascii?Q?Py0TFAm12XTrIypoulPM7KirMYDvK4e6DNRgCeftZTDs8c7rgZxcf7yY5twB?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e396905-9917-493f-98f7-08dc3483a8ab
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 15:25:25.6099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BxuGc5qjikxNKjApFh1534RIQ/hvGgesLiApHlfOXNZuVgJpid9jxUwt86rvfyahNnbD0I1157xmJIw41mNd1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6794
X-Proofpoint-ORIG-GUID: gdSmFv64r0udfGcP7Q7sghlPFfEDP8Cy
X-Proofpoint-GUID: gdSmFv64r0udfGcP7Q7sghlPFfEDP8Cy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

Ideally 'migrate' and 'migrate-incoming' QAPIs should  not allow 'uri' and
'channels' both arguments to be present simultaneously, but also one of
them should be present in the QAPI. IOW they are mututally exhaustive
arguments for QAPI

Add negative test cases to validate the same. Even before the migration
connection is established, qmp command should error out with
MIG_TEST_QMP_ERROR.

Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 tests/qtest/migration-test.c | 91 ++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e5547b8746..c1d9ee6466 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -370,6 +370,30 @@ static void cleanup(const char *filename)
     unlink(path);
 }
 
+static MigrationChannelList *uri_to_channels(const char *uri)
+{
+    MigrationChannelList *channels = g_new0(MigrationChannelList, 1);
+    MigrationChannel *val = g_new0(MigrationChannel, 1);
+    MigrationAddress *addr = g_new0(MigrationAddress, 1);
+    char **saddr;
+
+    addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
+
+    saddr = g_strsplit((char *)uri, ":", 3);
+    g_assert(saddr[0] && strcmp(saddr[0], "tcp") == 0);
+
+    addr->u.socket.type = SOCKET_ADDRESS_TYPE_INET;
+    addr->u.socket.u.inet.host = g_strdup(saddr[1]);
+    addr->u.socket.u.inet.port = g_strdup(saddr[2]);
+    g_strfreev(saddr);
+
+    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
+    val->addr = addr;
+    channels->value = val;
+
+    return channels;
+}
+
 static char *SocketAddress_to_str(SocketAddress *addr)
 {
     switch (addr->type) {
@@ -704,6 +728,13 @@ typedef struct {
      */
     const char *connect_uri;
 
+    /*
+     * Optional:  bool variable to connect list of migration stream
+     * channels, to a dest QEMU, can be utilized instead of a URI to
+     * accomplish the same task as listen_uri or connect_uri.
+     */
+    bool connect_channels;
+
     /* Optional: callback to run at start to set migration parameters */
     TestMigrateStartHook start_hook;
     /* Optional: callback to run at finish to cleanup */
@@ -2509,6 +2540,62 @@ static void test_validate_uuid_dst_not_set(void)
     do_test_validate_uuid(&args, false);
 }
 
+static void do_test_validate_uri_channel(MigrateCommon *args)
+{
+    QTestState *from, *to;
+    g_autofree char *connect_uri = NULL;
+    g_autofree MigrationChannelList *connect_channels = NULL;
+
+    if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
+        return;
+    }
+
+    /* Wait for the first serial output from the source */
+    wait_for_serial("src_serial");
+
+    if (strcmp(args->listen_uri, "defer") != 0) {
+        connect_uri = migrate_get_socket_address(to, "socket-address");
+    }
+
+    if (args->connect_channels) {
+        connect_channels = uri_to_channels(connect_uri);
+    }
+    /*
+     * 'uri' and 'channels' validation is checked even before the migration
+     * starts.
+     */
+    migrate_qmp_fail(from, connect_uri, connect_channels, "{}");
+    test_migrate_end(from, to, false);
+}
+
+static void
+test_validate_uri_channels_both_set(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .connect_channels = true,
+        .listen_uri = "tcp:127.0.0.1:0",
+    };
+
+    do_test_validate_uri_channel(&args);
+}
+
+static void
+test_validate_uri_channels_none_set(void)
+{
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+        },
+        .connect_channels = false,
+        .listen_uri = "defer",
+    };
+
+    do_test_validate_uri_channel(&args);
+}
+
 /*
  * The way auto_converge works, we need to do too many passes to
  * run this test.  Auto_converge logic is only run once every
@@ -3537,6 +3624,10 @@ int main(int argc, char **argv)
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


