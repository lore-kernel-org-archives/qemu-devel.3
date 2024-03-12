Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CDCC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8i9-0002CC-Ne; Tue, 12 Mar 2024 16:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i6-0002Aa-6F
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:54 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1rk8i1-0003Bm-1v
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:26:53 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42CJgASb018660; Tue, 12 Mar 2024 13:26:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=a8i/sEB0bP9Bt3NfwKvZ0XupNjb/yphsk7Y4bu8rd
 F0=; b=hAV6bdf7y26zntFkjWUxIu9bNegIYgnswNaCeTfLzYqAYkyi4rSatjV1y
 vbcDE74kdDmUXqOo6phNFmz4jbk828v8U34zvT+nxS/jAbnWB181wC3Jk6dmULz8
 JfATkNsIvPpFnpAgsF4CuJq3eViL4aRCTN/FhzqduAEhID+DI4zLItgokZ02zhg/
 vtICUzN+fJMYBU9vMTA7vjd7PiE7Nb3RvJxJETHZhBaNeJM0TuriaJcQW0ABtPGc
 W4wGpqpV9fGMqZH8NQEQT7ZknziVKGyK3rORKv1VDYZ6l+qcKscXgqIgyqzP0Cha
 bU5EnUN3Cu0j4Lgd0CkJeYvmWHWlg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wrp6axxgk-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Mar 2024 13:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZYHd8QmaPFfH84GiMAwYPyC6dT832+0qgoGf7NJ0zazcnt1vEaiin4BKHggHx2NJ/S47/EHIHE1abswk/fBVyqmPSIscYCpNqxR4SAJP5el2IpIq6aE3WBqfRmImXsT0aoka5J5z3W2fGeoaD/mu5A0Da2Ys7/JxK1Xx8HddqdVee2vwMtASVMah3FxziUdBO1Jz80J+QlpKSJuJHghrR1F2v7y367mTapD1Dj5vs4BcTCQc25arB26wVXsmdrVcQ3vnrTggis5rEOwqRkgBf4grKN72a6V4ilzwPVjoUGWIHPeNveBcb9HwFs9pmPIOTe0TqsSoZzJ0ypTE1ft7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8i/sEB0bP9Bt3NfwKvZ0XupNjb/yphsk7Y4bu8rdF0=;
 b=ES4NZ+pgPsr+kdQQOLFGdBsJy3FvQOi2chp/baj1rV7UVr36t5qqHS1RgNioTwcJYS+WdpO+in8sOpLccJD9DOuR7Eu5RP+jBwNPdnvkCcFa3TTGJj+1ck36k94ipNXLkso+H0hhrZPX6M2vDZvwJLUr2qmMi39vUtwBYYoYWjdaLNfU27FolDEJ4InQaGKhNwjAijSP7Fns6G9OX8Mx1YdbufkBnQs1gv8U7DYkPu4AeaN6X+RSkptayIdkhd4uIErhwjMZMvwAhlrJnA6iENaUxM7VEO60KsK9EeDEWGwfqH9GEXsr1z42uRtiaoJPaS7xlBx2ALR/CYLCF5katw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8i/sEB0bP9Bt3NfwKvZ0XupNjb/yphsk7Y4bu8rdF0=;
 b=GkFSRXC8DJDWpw6QsT3tgAQjARUfNrJWVgw76A7HRxUaWzf7H8HWrV1tGTPP0gGQ1QCRcm0dOWlfOkx2wAiu6NIhA1oy5TO/Q03HCRIsh6G/xiubR3u4XOW7Y+WwBDO2oL7Q2V03FNVQrwaH79UvgvcFvUMcIGi+pQm/08h/4QenU7dNOgsbFcfWm9Paviks3o9Uj5KiAu9Folfg9TggsBJij7cbS8b9LZ4SMt58SOqZ9nnjTVhUTclOfkru24NIY6C9ZatvzXveF8aAS5ciKGCixXD7socn0WTB9Qd57gZr/P7aehdyk8GVxnQ/3u5X25gR710YR/QVHfGA7ieiOQ==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by CH3PR02MB10057.namprd02.prod.outlook.com (2603:10b6:610:19b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 20:26:46 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 20:26:46 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com, farosas@suse.de,
 Het Gala <het.gala@nutanix.com>
Subject: [PATCH v7 7/8] tests/qtest/migration: Add multifd_tcp_plain test
 using list of channels instead of uri
Date: Tue, 12 Mar 2024 20:26:33 +0000
Message-Id: <20240312202634.63349-8-het.gala@nutanix.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8ddd55d1-1c2b-4602-95bf-08dc42d2bceb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfou6iCIyBtzfuDd8LiirIjGNqqouIt8wpGaASPneEOrs8AHYaWaM8ZEjhlaAxzkRAQZC+hCBaD588fiXgJoTPlIFtpjpyRALfTw9XKLmBJO2nY3CnGbIawgxAJ/MXao3D0TklDJy+TRGLSdY5SiRAG1Hk9MG3m3PudTxiVvRqpC0vYM3Q909lQuunF5DeCuU65MIlZ/UIGjLp72TkmlvkVG9CvUntfIdYkUcRBh0xeMIxAOvzx+BKgXemtxApIz/MKP/xpUXUdPxZpHT6yS3zCQOganQSKzmbMhgiuhFy5Bph2/4/z5fCiLdzQiBMtUtH8jXTZju6UdyQiYxuWzPS8bGAl18GZbJLPdyFdluuTS9vCq7HvH/TWT6U7L1t5mq67h4CEaSwwV4MPQhW+Q13U0W7O1G14D0dxtSGekrAGcCCUndQjylN2kwUxLCZKbg9blafXCnxUHsfEQ9XAI4ddOFBEWf2OACKTNfpLoR4EK4QuzEO8gKrwc/qudQ1N4c9inPf9MDhDN7OtJcx9aBLcUBoAPyQs+8B/TTsn26rZvtCTMTrbEr+x1xSRFQXsyosGr6EheeO+dMWJLa124tKHUSKSs3Wz86QnNftObzUlyGfSdLhej8OwUpbdb6R/ek1blwGkR+j2MVjjT/WfGW/v5cTrACKZLm/cPQ0ZIOzTPOjnkr6Fqdx2faV8dQb3EINQSGtxkoOFkE7mLxxbiRUrEJyu6YMB1VTT1pGKewQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(52116005)(1800799015)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pfC41BoOnzmc46IXQNV7rIRSdqx6gmPFGedKgXAx3Kkfc/CghIPxUCFt9+Vf?=
 =?us-ascii?Q?jUimAC9zaeWtUpGKPswZRNIB14VqsK5s6hQxBmLdUOZnohUV3v5P0f2Hqhx6?=
 =?us-ascii?Q?TkGXCJbdOK1oULHdDEgXjY9/zq62gPmNNKKurvoa8xep4q9r51jVpkxDd7Or?=
 =?us-ascii?Q?eciCjdYLCfwdMXBmoUtH7KpFQjaS3gVXa0xacz21dmCDIHqXvC7QomCOnop2?=
 =?us-ascii?Q?MV6w3aDMmlM9JayXrCN+INr+avjLWAim5KdAS4NC0ey6fIFcAYCcCuJt4ntx?=
 =?us-ascii?Q?t3fN+VlhezqU1ahNYibxYWm8Xz1HL51jaUOc40BhrQ+hN9NNnSnKosrwhKh5?=
 =?us-ascii?Q?mebbJv1pRjTK0SMfDf6RnZvHiEPC89A4vrkKhrFYKVzQ2bSc2J0IbV4VPLDW?=
 =?us-ascii?Q?CWpDuJbdEB9U50BiqENxlv65aZUELps4I4He7oNLtFMxKmC7IhOFl1mUxjgc?=
 =?us-ascii?Q?wbxlAIZFznIg82RVMIZpsXElteQmNDXdZ1NIGUSlrkwV3IYoGCRt0LKI2VsL?=
 =?us-ascii?Q?MhBGvRy9ousGixvdF8WpPA3FHGjHeJUWX+lBsmF5kXEF/Fve/ZxfDM4WQKzn?=
 =?us-ascii?Q?N37WB7MfmZmI56Q31zbOS8lqbm8UFumY6vWTmwBmJPnMsrxFxKTG8bsF1Sul?=
 =?us-ascii?Q?ovgA9OSJ78FpvgdQhtTr9ZxKLHqSdCV18yuHywqsKImGw2pCljzJ5F3i8jmz?=
 =?us-ascii?Q?EW1LZCdecqOP15VadAkYwRkRjkrZFs9H7SJJI9LGOMky6QVechhweDyvTa56?=
 =?us-ascii?Q?orJoz4NFoDYWReB0rtNZVk/xQbsx5iONi1DI9TJun+4JyAvpkiMtWApfZ/FR?=
 =?us-ascii?Q?a8cBdZmG4arCKLDXPtBtiGQEA/33bYUtLKKUgNad2MaTx1eAjGhBhDVy3kDA?=
 =?us-ascii?Q?R33FUQpAnWcfMbO3UnvNKIxwM2vhfUx48RkulJL+Y9iNT6WgvWgAFosQHhiE?=
 =?us-ascii?Q?B0dlXDYnmAhG1VkVLFN1lfpkFANfbIeCaW54gEy+MY1nAVfTILJE9yz/u/uO?=
 =?us-ascii?Q?dYVGZbh+9Cd0a7JS9nJ6IpVqHbZlZGVtyyvvpB++iwUGTnjiVcTPXpzNvqSZ?=
 =?us-ascii?Q?XeUvOjRgMMlLeC2uIhUrGj4igJcD016+MqCTcJBqbK1rsoas12lnkdNyviVC?=
 =?us-ascii?Q?wglrEW+hhRYYpWcQ8T9bOPfBxLhKh3uzoizWMXWtIdITlkorUd1OvKLGgfvF?=
 =?us-ascii?Q?RTZ9GWdx4DiVEuGf2tc6vmrJib0TfE793cQkeNXngIoSNi+VfPT+uCYeiiHN?=
 =?us-ascii?Q?XJ5MIw3XVdXmaMN0d1KbZ8hYAK6bE3jUHsoJxw4ZfZ+d+Z9rc2SnCF+XLEF8?=
 =?us-ascii?Q?LgCxY6zESTO15P3KatYGUN6u2qN4Vx8Su+ZdGNxnx7rhzyBq52j4l9kthPjZ?=
 =?us-ascii?Q?ltfVZU0nw1MQdIbJ6VWe9h0zq7s9VT3UNBiiC/NO4EKaxr+P35mZNN8Lozik?=
 =?us-ascii?Q?6+TG2fAiA3BMXkxgAGr/1h0pNxykKf3/zCoKYi43qbQxhz0zxEAMIFvOqjjC?=
 =?us-ascii?Q?CRcT2zXFTC/sC0jTUkmJVNco+JcA74OSqoJ+eQMJeQqcK0EOPb5DwZYi/usF?=
 =?us-ascii?Q?/WV3pTz2sXb2WRxGRmGow3XzbU4xJ/eFvVovJhm+shaPPit+xS7SJRuNn090?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddd55d1-1c2b-4602-95bf-08dc42d2bceb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 20:26:46.1346 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zn8CWeHljR9zK3O6GJlu7T29XF4XVBCJCmWzDrnMzcu5O6kqE+6+cGK8oJzVQalZ0dmgQSiJjHr3FBY6Qevr5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10057
X-Proofpoint-ORIG-GUID: jWXKO766XxKOX_RUqmDRxCdOYktGy7bq
X-Proofpoint-GUID: jWXKO766XxKOX_RUqmDRxCdOYktGy7bq
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

Add a positive test to check multifd live migration but this time
using list of channels (restricted to 1) as the starting point
instead of simple uri string.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 62e52a29cc..7ea13c8e5b 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -655,6 +655,13 @@ typedef struct {
      */
     const char *connect_uri;
 
+    /*
+     * Optional: JSON-formatted list of src QEMU URIs. If a port is
+     * defined as '0' in any QDict key a value of '0' will be
+     * automatically converted to the correct destination port.
+     */
+    const char *connect_channels;
+
     /* Optional: callback to run at start to set migration parameters */
     TestMigrateStartHook start_hook;
     /* Optional: callback to run at finish to cleanup */
@@ -2758,7 +2765,7 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
 }
 #endif /* CONFIG_ZSTD */
 
-static void test_multifd_tcp_none(void)
+static void test_multifd_tcp_uri_none(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
@@ -2803,6 +2810,21 @@ static void test_multifd_tcp_no_zero_page(void)
     test_precopy_common(&args);
 }
 
+static void test_multifd_tcp_channels_none(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_start,
+        .live = true,
+        .connect_channels = "[ { 'channel-type': 'main',"
+                            "    'addr': { 'transport': 'socket',"
+                            "              'type': 'inet',"
+                            "              'host': '127.0.0.1',"
+                            "              'port': '0' } } ]",
+    };
+    test_precopy_common(&args);
+}
+
 static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
@@ -3712,8 +3734,10 @@ int main(int argc, char **argv)
                                test_migrate_dirty_limit);
         }
     }
-    migration_test_add("/migration/multifd/tcp/plain/none",
-                       test_multifd_tcp_none);
+    migration_test_add("/migration/multifd/tcp/uri/plain/none",
+                       test_multifd_tcp_uri_none);
+    migration_test_add("/migration/multifd/tcp/channels/plain/none",
+                       test_multifd_tcp_channels_none);
     migration_test_add("/migration/multifd/tcp/plain/zero-page/legacy",
                        test_multifd_tcp_zero_page_legacy);
     migration_test_add("/migration/multifd/tcp/plain/zero-page/none",
-- 
2.22.3


