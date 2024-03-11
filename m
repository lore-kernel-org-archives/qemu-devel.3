Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A13C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjkHS-0007XL-Ag; Mon, 11 Mar 2024 14:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFO-0005fu-QH; Mon, 11 Mar 2024 14:19:46 -0400
Received: from mail-am7eur03on20701.outbound.protection.outlook.com
 ([2a01:111:f403:260e::701]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rjkFN-0006tp-AC; Mon, 11 Mar 2024 14:19:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cG2j1RvzDtLyJGdjRLntlobwdqd5v+I6pD5OXqMyeYRLDW5VGOxhY8y0L12jnlmhxvmB3TyxABh5UDvkaZNNc3byyZ2NcnnBE4uPi2JvKmWp4lxYORfAFHQRF/iYcevLBTbw5el6oHVnPOVcRLFG3oWQ5awsU1u8nEQsxvw0p2K2zCMoPl63zxqzQKYglmIEfX4nFfjnpi6+j/SjcSkExp0hIB2EUEIQEm8oNn4OhfVlgrhGsQBrC5/Hbal+VtutqLdyNHHmbYEN6p2qrPy9zBu/FFyqpbKo1u6HNvOE+ug5eMNatrGSovuBTBANTIYX2DVvpDe4s6at7b9X2bZDow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L5qMnrtW+URLLSQA/qmDJG7cxeq/+eDCKAIuYlOL5To=;
 b=KCq9/1mrY+Ff74+ggHtf3sc4EV6c5VekjKY4P8aR6x8QmKks+8Q8rF+ow2FtiR54imXyILBb3WWIlmjCIlRcjpMx4t7FckqonVpJ/hM6fL50UWxhpAhRylDe3xM7jwVXayYVDlrSscuXcc51NHMVau0L+s4WPIFISE3lyhoyn6rveobHDSSAsYg+f3PfY0tXZa5UOBnJ+CCz0gfOdW7tZbFGoHbZTE+9rJmaxzKvo7tFmrmLkUHV/RQQgOA0Keqh76flvIachPBlyWUOHI1j7FUw0fnGhfb0qbDOckZyoArotWZ517Raqqq/jmUmZLtm4ZXWkcm+m2cvoo2gjMAD3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L5qMnrtW+URLLSQA/qmDJG7cxeq/+eDCKAIuYlOL5To=;
 b=bDBm2U7RIIPQVNjn/0ht4DYYX/WXPrd0wkgWpsf7MNcu367m6d+hf1LSsuS4MMUo2n4KIGNmB97pc/WAJXQjItziRHfdjIBOEcZaDZtZBAMA153skU8dkuMHEv3rIFHMhDO+HB41OewdyoLsTBDYybvzsug+ql8gB4Il4uGbvRfQp2thmiL3mgtyuWJLZ8G81zrddsvidkUf6pUC0npU64QD9oUOQ9lTNf8tMJdKVU77M2IzH7IdsI1+QfuTceOPvlWhRj1v8+B88hzoTaHmV+Dmaw6WlQzrPMjS4G49EP4hL9Edsu4SVblh9TOKz6qYV6E+Na5KznSDbyv2Z9iBBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by AS2PR08MB10206.eurprd08.prod.outlook.com (2603:10a6:20b:62f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 18:19:13 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::fe49:a4b:7387:3fde%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 18:19:13 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v5 22/22] tests: Add parallels format support to image-fleecing
Date: Mon, 11 Mar 2024 19:18:50 +0100
Message-Id: <20240311181850.73013-23-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240311181850.73013-1-alexander.ivanov@virtuozzo.com>
References: <20240311181850.73013-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::20) To DBBPR08MB10721.eurprd08.prod.outlook.com
 (2603:10a6:10:530::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10721:EE_|AS2PR08MB10206:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b08d031-4e92-40eb-6a1f-08dc41f7c0e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6oT0fk3o0R6iiXkeM9njUntrwkLGKz9+R9R+CLJ3bSoNtMbePw2JEJH/IBQ39DltXG56tJIhQd0g7qYZHarlZI9foxvCy6/hFP9q+J+cKf/PvLryx2waa7MoAjUOjCoeGDlVTg5/mbvXeizR8TcQruqh1n/DFj8vCJOOTsLq4GpXvrjN+vwjEZzTUEoDSBcH/m5CORYwPNO6fM2vtZR2YC++LXOay81guYTOUYGNQkuQeRAHIKF9HGH85iFje84jcYvp/KaUPopONhbLkwTxVKZVxSbHiYugvNGnIL032DbeaQOxpMBRmN+b2wHd/Bw72cwPoPglVsdWoVgF+E9VHBiQi9GCHowL/pTs03h04EZLVw+yzAFCi99blpl1kqUbF7TK83svOzLs+rpi1NJYz9TVTdZThypBT/gI+noEgfre0JLFVNwwuajp6JCaJlLH9DvLX5zoaP/8UlPbY63+0XTgbQbLzdpAm/P2onXYejA96n2WEuWIZu7iddeF1/Pguczeuhs7a8pR5xVkVFWG65lKl4CfTGnzYUZSRBCis1YupnOmYI+x+tnxI/hYtPhk1c7dv4TsZpQ47uYEqC0wU7LUrdA3L62KrLuKXnNRr9y19WMK35Ez8zqtxrRaZMTWMxoVacLY/sAmwHpk4t3IZA1xrenP1VysZqGGQT2Y7NYC7PlNsd9UbudAaow+SLxMfKfvC3D9uXn45XvX+SEM79aZt6+CiFiVX+1s2mokHXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(52116005)(38350700005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i8Y19/2EVYzGUJ0i6mJJz/WL7TrGnL5FkgM7h1kD4QYOzI+fa8x0Se0NMmKR?=
 =?us-ascii?Q?IlToVCacAVSHaPIAnN4gfcQxyoVRVF937wEmctT1GBucH2q29SnevwtfyYcO?=
 =?us-ascii?Q?DmYaKaei9If2kvvj7YbNhh0e1VSI2qNFIqHaTIxyJqCFCJSrUZxJBDsfjlzl?=
 =?us-ascii?Q?g96BVdcnWuMXqXl54l82nzz1uLWes5Dsnib2DwkyUvLfuw1HU18EHfDbLn8i?=
 =?us-ascii?Q?UmnggRknBZJwi58z2waPFi5m16I46S2+i2HKMcpT9FJ6llevYIfcA3Fot2Mx?=
 =?us-ascii?Q?+2r8VN9nVMaCN/gsRtruzVrgVhOmbKr4KdwaTLShXqeeTDEeQ3CTqcAWUHVJ?=
 =?us-ascii?Q?9Hk2dMWBx+IptVSEaU550D3jp3KjnS+S78ee0Yoprin9GUwa2/k2+0l8Ybe5?=
 =?us-ascii?Q?a6WTcwJ6dt4Qr2xHhaMG1Zcdb3CTZ3ZAlsRTTadZRnH0UWzQ7lN4A2HnAqgS?=
 =?us-ascii?Q?pJ8OU0qMz1JuMNXPBqGT3RWTC9jljACCzB7lkBYSXM7/cGF1gOIeU4Mh6l1J?=
 =?us-ascii?Q?Ko1Og2du4C3ds7DLTrMxDa0qFEvoUKOteFBpC5OzuEjKSIRqxciBpEJ0K5/c?=
 =?us-ascii?Q?nL3Rjomn9qI3FIY75XTQQIaaR5XFqGgdMuCKE+ER6tXAshb137JMHDH9Dp3p?=
 =?us-ascii?Q?08kftx5tVOIu5yg19746pky8C57d9rS/ROqIiqnyvPRZLzChaYD3jJCbzBTE?=
 =?us-ascii?Q?29q6t3bD4YEaYhIHLncZDNfQ4KJRSX0SjQMSHl29Mh1wae29Vnu6HXLTUoXY?=
 =?us-ascii?Q?ELcbTlX387g+bYY+nftcI+RSkPVP4ACUCMEgEid+qM1NoKzhoxM2Pcs+5cW/?=
 =?us-ascii?Q?EiCwzcAs4GRJLY65+WeciYcD6oVHiqKwtZ8llF1+S4g6Z0yiyHuV3oaDOouV?=
 =?us-ascii?Q?e1huV2xXkd8k8iG45c0evJy+ziRraXHfJgS1HbHXlrAso7wO/CU0QVF28O+e?=
 =?us-ascii?Q?yW4qga/reb8NOPqng+s6AUWag9DfWnhfcutfI8MfLqSjyx3GAfMjioKDK+0T?=
 =?us-ascii?Q?lygKZ3SCeKLws0GCEtJcLERexH0c8GeO7WhWG7MyYmjNJKOba9tq6uTnMU3v?=
 =?us-ascii?Q?LNLWJOEikyJ9RtglAK9w6MeuRJM/K1dNRv2s2lHAic1nQUFR6WRpoj0o3ltm?=
 =?us-ascii?Q?rqIBCtfE8kOa4UFwLnZ/03aCe0fxCtn9Ls4g9tSkDCOAVnbhYK7EvKb9EB9a?=
 =?us-ascii?Q?ed1B2ldpVdaO4/sLwNupq1ezVJQW16kpc9jVbfSS6gmHZoZpnp77qgu9mGnE?=
 =?us-ascii?Q?OzVVVpRJC0ZYtuoueozA2RH4TF7goMbXyoRV8EkCQXS3JLp5BHMGooMbdBHp?=
 =?us-ascii?Q?eiRRvuwG+t0Jrr4yTnWp4fGKUjSzge0Vs/n/MM60OVcvDguXR7O6PIpwQ/Pa?=
 =?us-ascii?Q?Y65pVWzLsdxOg2nEHSprRPI8kSabvF1fBNVP8Svglec7Wg0tiogdqauuqrCf?=
 =?us-ascii?Q?tLoU77xkPcuJNmx90WCz3K4JnIDvnxHfBc7spNZpweI3TN/LWOgq2nw03Nno?=
 =?us-ascii?Q?1K20S7uQs0yaWrAuvrjECjwY0Pp7SCxk0u40xDaZeIOhTqnvkuJiNXX5o6EF?=
 =?us-ascii?Q?tphT1L6bJLW9K1PWsPdxSlgorLADgvrlFltFYL3oJsthZZdVv1SB5pcXLA/U?=
 =?us-ascii?Q?V3BF4lMEquWkwdeqfQ8Ey3o=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b08d031-4e92-40eb-6a1f-08dc41f7c0e7
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 18:19:13.0174 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLcC32NjebzfmMFCL5kE9604i4FwuueJnDu0LTl1S9s7Yzcnbs1VCA9RjlrLBPhrGO+sYkZJCVi0N8j9ytJ2xge10QvPFc4NHbLNhuoxhTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10206
Received-SPF: pass client-ip=2a01:111:f403:260e::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use a different bitmap name for parallels images because their has own ID
format, and can't contain an arbitrary string.

Replace hardcoded 'qcow2' format to iotests.imgfmt.

Add 'parallels' to supported formats.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 tests/qemu-iotests/tests/image-fleecing | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/tests/image-fleecing b/tests/qemu-iotests/tests/image-fleecing
index 5e3b2c7e46..dd940b7203 100755
--- a/tests/qemu-iotests/tests/image-fleecing
+++ b/tests/qemu-iotests/tests/image-fleecing
@@ -28,7 +28,7 @@ import iotests
 from iotests import log, qemu_img, qemu_io
 
 iotests.script_initialize(
-    supported_fmts=['qcow2'],
+    supported_fmts=['qcow2', 'parallels'],
     supported_platforms=['linux'],
     required_fmts=['copy-before-write'],
     unsupported_imgopts=['compat']
@@ -61,12 +61,17 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
     if push_backup:
         assert use_cbw
 
+    if iotests.imgfmt == 'parallels':
+        bitmap_name = '00000000-0000-0000-0000-000000000000'
+    else:
+        bitmap_name = 'bitmap0'
+
     log('--- Setting up images ---')
     log('')
 
     qemu_img('create', '-f', iotests.imgfmt, base_img_path, '64M')
     if bitmap:
-        qemu_img('bitmap', '--add', base_img_path, 'bitmap0')
+        qemu_img('bitmap', '--add', base_img_path, bitmap_name)
 
     if use_snapshot_access_filter:
         assert use_cbw
@@ -75,7 +80,7 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
         qemu_img('create', '-f', 'qcow2', fleece_img_path, '64M')
 
     if push_backup:
-        qemu_img('create', '-f', 'qcow2', target_img_path, '64M')
+        qemu_img('create', '-f', iotests.imgfmt, target_img_path, '64M')
 
     for p in patterns:
         qemu_io('-f', iotests.imgfmt,
@@ -130,7 +135,7 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
         }
 
         if bitmap:
-            fl_cbw['bitmap'] = {'node': src_node, 'name': 'bitmap0'}
+            fl_cbw['bitmap'] = {'node': src_node, 'name': bitmap_name}
 
         log(vm.qmp('blockdev-add', fl_cbw))
 
-- 
2.40.1


