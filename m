Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AEED185FC
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdqTH-0000w0-DE; Thu, 08 Jan 2026 08:54:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@citrix.com>)
 id 1vdqTF-0000vV-Tq
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:54:38 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@citrix.com>)
 id 1vdqTE-0000LW-Cw
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:54:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnWwaei7hz7CgY+nnmcqFMjnxgUCk9FW2AAsHjsuu+hqCsF0LHwPU5jNV7y35Va2G8LOnn5fWOYRRS4vNLgkByjCWBN6ck31IN2gGAnLr5egCEkfgaaBYi4HTNO0G56VP5QZ3L491rCqLeWLEbXK3gGjBz02wthz7jsGt/xqoGF+rRifk5i+FWWp098DtQjMLk/rKt6gPNVZx5MHX5MjMNHTufbZCtj30gL948Gw9eu/X4pTuNINtWKPPyT1uIENzzDIckIzvUOuMfGJzAyaJRm/rDw65mSMJ2Tuj0iKq30I+qNaLaB9SPSuHFLP/xXYUgnGJsxo7Gc2S5f2eZOAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGSvDId2Inso4PWCJXDgXZWZyiGqmVZv4Ud103bPlsk=;
 b=dcezrPxFYEG4S1Bgvdm0JvvC2LTdL+U5njyszbwLqTMpfngvVH9Zqm62hUryC+iRMxf9wO8N7ddShLT6YKe2bskPIPU36yAKn4nG3XsTqjwnuvFjhh66XX7E7BvXPx8vY6biWTYQWZKhYLeVOE+GFfpJiyDkwxQhv/H/3B5P29A9/7I5A1vl9HDCx1N+dyqilkPUDLU2TjNPYAQmxMdipV3SRpCJYvyFc8h/ojOReotOQ2Hj5C22F/a0vzN0MI1dI9TaMv3Kw/TUOWmgT2pDErl4hqlQ1ntgv6yK9zLsZjR4T/fHCx1qwKGLrIqNLxVPJ+Hi5keCt/2kBpc+DBJQeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGSvDId2Inso4PWCJXDgXZWZyiGqmVZv4Ud103bPlsk=;
 b=IpyR+R/BnS9Mif3aGq3mxxZhwjfNqqO8bAq0gDNub9LUJoHrwphGl6RCJMMq9cUFi726HIFbJAAhi5EM8owuH9NQ9lKArapN3xGQAjXMkYNwArCWxqinbps0T9wfVYJjN77xIpJerYs4vG5M1e8iK3Ok6ZYat4caW54Zx5ioVMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8274.namprd03.prod.outlook.com (2603:10b6:610:2ba::5)
 by SA3PR03MB7283.namprd03.prod.outlook.com (2603:10b6:806:2f0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Thu, 8 Jan
 2026 13:54:33 +0000
Received: from CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096]) by CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 13:54:33 +0000
From: Ross Lagerwall <ross.lagerwall@citrix.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PATCH] xen-hvm: Emit RTC_CHANGE upon TIMEOFFSET ioreq
Date: Thu,  8 Jan 2026 13:54:06 +0000
Message-ID: <20260108135406.1879210-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0039.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::18) To CH8PR03MB8274.namprd03.prod.outlook.com
 (2603:10b6:610:2ba::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8274:EE_|SA3PR03MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: e1504919-1268-4e5c-4638-08de4ebd73f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8OEDvoiW0WWIgQbqUfuDmM0SwGmRbOzZaX/Cc3MwZsFA/UyV+H6sVAn6wIIt?=
 =?us-ascii?Q?EPNekyblPB9DtmvYrY0FoQsU2++fQ2oE5HP8VnInOAambXJid9fD1lIA8P6W?=
 =?us-ascii?Q?KFAoRilwC9h7GgbKeZP6R72WKl70nULD0VC8ohgZ6TaDS82fnjd2VyjIdnXN?=
 =?us-ascii?Q?xgft12XVv2GDLW+FiFlEu2fw94oOfGqOFEG7WYnS9C8GJ0aZnq6d37rJl5ng?=
 =?us-ascii?Q?JK1yfr1RLl3CmHw1smwsYHvNNxRySjU9v/U+VuQQydpb9GPV+7arDeFcfDnq?=
 =?us-ascii?Q?LBjwruJ1TwMfSShIINeCL3Gj+2jZW3HOkZhHNGgdYYT12pyZxe5YjMs2EC+L?=
 =?us-ascii?Q?I728QdQbyLGiKRLt0MWJ+f7Iqg8aR5O9Gqc+fN1WcWglW3szOBQGIARGw1fN?=
 =?us-ascii?Q?TJbJgl6BnSdVCOzMr8WWeU6wPIEEisUt4U+XHfx7GOqOjMrGrOnkLq3Yvqq+?=
 =?us-ascii?Q?4itJOBuJ0rA7OSjdUHtTAfMpkPMdPLvbvGj164TuDEipjY2xkujFPqGXOS2i?=
 =?us-ascii?Q?1FbTqzWHEh7xDC18E+6iK7sBGz3N0Cl/O6QgQCyktMORXA1AZBQS2VjA4UwR?=
 =?us-ascii?Q?yWLWSME9cT24vbjlF76sxFpGO9guMQ/O39XJCMmYAIQfGQsbh08xQblVZ5Zg?=
 =?us-ascii?Q?2cyAQzBIFX+KE1IMMALmP50150c1zOOnKZAzsLOBXwWowF40fKQAbqjqBAdP?=
 =?us-ascii?Q?7Cq1zHNFT83TKMl/zxTldnNHLTy6eOxhMZBrw6ftcuzkydoE1e2J5bBk5nva?=
 =?us-ascii?Q?6sArbjNWjYupeOHtZQVrnZHNjYuxZit9sLMYD+QlyHZIoB7QQQahxOs4zpZ1?=
 =?us-ascii?Q?8CbdOsoBYm3Z5ai6pAYwnO+GEuG8TcNIYz2ypNucFBIhuSx1Ff5QM+kA4IL1?=
 =?us-ascii?Q?gTNke+ddDnhQrIUnsZVx1pT5+XKpDQVdQUlg5ebUoGfPkxGCtXXnU1PZZ90m?=
 =?us-ascii?Q?5TtimsULSbDsX3C6RO/b/kAtyhoNg3JF7sTVyf9WH4IEV29XLXxyo3uppHca?=
 =?us-ascii?Q?m96rbnlfHMIeEd3ZZoLe1CLPKkNAzKNBtLqLnwUoz8q8J7s9okD9X1W95TJC?=
 =?us-ascii?Q?piDDxsWz1sHG/AvrQZWa0PoTzNHYjI1a8e4wmi/6K6WbmP91c41KXoEMC5wT?=
 =?us-ascii?Q?+W8t3epYUdb+E7feHn9zkDScC+ZH3Rbgq4tOrclXNucHG96lh9iDliF1WKAs?=
 =?us-ascii?Q?jN295FBVoafMo2hkQ2G8c0JZitHlYwz7nOQua6iznQRHKil0Vcfo6sl/VlRv?=
 =?us-ascii?Q?Jq8WNzw3G8Cw5uLWP1HpuOpgpvxliRjWsIxCbKkWSOXPI3lXNqatAqItcR4W?=
 =?us-ascii?Q?5B/tLafIC1VpjHgjdTb7grbQ3xi3QU02Jdhv3MXsgXAqfm9VkLmZKx7YlNI2?=
 =?us-ascii?Q?gfCyDQ/ygx3o0awuejLNYwuzxvFtHBW7Z2UD8dRHUNIobQWmA7yx1VMUHJgI?=
 =?us-ascii?Q?0oyC3tKTuHCIIRtuvw4ns1TVKMwS6R5E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH8PR03MB8274.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3J9nTRcSVlWCrhFvtO8O4RR4JwHpN1K/Ri802xb5Nsfm94raQChApHUTPyHp?=
 =?us-ascii?Q?MZWoWzvJAgmcFxb7hgrKJfnadd7K5TIVLPwHsp/MGB7He1xoSHwpO8HbVQH5?=
 =?us-ascii?Q?SmmiQzaemE5oVQHx9+cAuFZ6wzKHbwx/LfwIiwjkdwZaPUPM127mtkdq/xok?=
 =?us-ascii?Q?omjkBGMKzcbTzLU1y3NwqgDQYn1gvZtkmhdo0lDTJLriflJKkNqhjU6nfvhg?=
 =?us-ascii?Q?X2csae6kareW7fNbjP9pwB6xH0X1gqLCy79RClPJx+C2k6K3zKDNwqzht8rK?=
 =?us-ascii?Q?mpUAQZOl22VfHs49Tzs2lVU4GB2PClLAN+0Cq3uYggYoIzGlJ6WxBmpomwax?=
 =?us-ascii?Q?drN5j90oaL9ohspUrVBOS4Ce7w95wJBi1byrbS/8cArmsshIJXSNEp4Ujyq6?=
 =?us-ascii?Q?Dfxn/sE4136WbDyoZ/TFmqfjzsOJ5FCyGQdJSqqLmiopHQ51Ekgl4k+1Tve5?=
 =?us-ascii?Q?hX8XhM7MOPSaIrpdKrSu9jvKmgqUPFBW+pxelD2/vMUJhaXkoGDQpKAdwIQC?=
 =?us-ascii?Q?4NO9nQqQhfnGjPQoEdBzb7hY8PzLz9ArsBDzuyeVpNrI4yw9ledMUhY9us/D?=
 =?us-ascii?Q?9PaL2u/qGTf0TBmk6kI1/1es787qY6bucPyFwzBfkLxEGTAGsWLYmOmAo6v1?=
 =?us-ascii?Q?2yho26+Y6Zf66ZBdln5ibeR4zcMBu1gDK9qLa+I8XGxw08zg/u27zWCPZSOh?=
 =?us-ascii?Q?yz/Qe4pTpOsbJJR+9Im6r+SqQby/eUYOpGTpNeP6IMzsNjPVRLsZpSPoE6ui?=
 =?us-ascii?Q?+q1B127xDNEEtSPzUtZW2aOSHM7hgxp+uP29A+irbUH/e6W2355ZX1WMNzYC?=
 =?us-ascii?Q?ZmIWrbdpz7hNOZ1wmKJbcB654nQB0vjEr4Xq7ths+jTMnphmsLoszCwF54Mb?=
 =?us-ascii?Q?wgGhxhQrIXU3B8ryVxYGwcJJ2Ax1gLW1L08aS07Mbq2H9/f+U1Nlq1A1PmJy?=
 =?us-ascii?Q?MPVCoZ37bcZxojsMQxpdEvglDssjqw27Z/RneCMNPtQ7X2BLbWJURWbpNLOz?=
 =?us-ascii?Q?cZ4TPQGbZ1HQ174FaTfYU36OjCuywCsca6lEorlv7vuRnypxoefAa5WZ2eRz?=
 =?us-ascii?Q?ZTBIHOJHbNya0aqz2HkWG2bnIG80/6FCV4uIeuFX/NcujHRNoFU25f+UbXq8?=
 =?us-ascii?Q?zukw/xEgkdDh34PGbnEPAnob2NNqODUGtDyOHPpWOEzd/n/L3b67xFwFHSXq?=
 =?us-ascii?Q?riYl7/h7Ag2IWHKW8vUkuY2HygN6A/ZF7BiVMU4Ex4fDMaG1rhefYrN02nnw?=
 =?us-ascii?Q?ZGxQ9t82Xs+1xddGLjC86NpdTahXnI9VRPOXm1HG8GmKl1W9t/prDKG/uL7b?=
 =?us-ascii?Q?HlwCpEUJ4lRAztssHXxTBSnHlV/xvEVGc8alEr+2ecIFd7g0YKOEqA/AC/OG?=
 =?us-ascii?Q?5A63twZkOr9drxqnvZSX7GyKOXdGnP8H1ZLbSlrp/+UUbVZrFvBOWSqNvs2v?=
 =?us-ascii?Q?Bm6IZVvmmCiv9mr8xpK6mv0xsaeDRW243HF8vrw8WgHhoKZvkGAUGtJTcZE7?=
 =?us-ascii?Q?ZhtGSVWLq45i1mG7H2zsT45yU8H2UQ5Xib5YR9xJMF6r7zSwS5radS3PpJqJ?=
 =?us-ascii?Q?c1kiS+V3f61toHm6wj/mUExd/MaS7j2bAxCVH9/9D/iQA2L+yH7Ny6vcKymp?=
 =?us-ascii?Q?XH4PP06qApb7mansiFAacylUMOAUkux7kmQWahaTk5XpDDR0RhY0fSeV/fT5?=
 =?us-ascii?Q?F3Wfvmc5EH2DPWHFYb9Wmrr3Q/JhRJHLmgw0/4O77bGAbGBiMf6KlbuLnnPb?=
 =?us-ascii?Q?RzxLXIUhasELR5Qlia1hsrIhFSnRW1o=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1504919-1268-4e5c-4638-08de4ebd73f3
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8274.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:54:33.4774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntwSJeCeiGCHcpHGit7lwg4s/3uYjxTIVQJ8RxdZoSACo8FKbepSWc2Y4ZR3UbKQxJ4ixJWNLL5V5yTu1A3QiGqr3oSs73RA2Q3b7ynf6zM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7283
Received-SPF: pass client-ip=2a01:111:f403:c105::5;
 envelope-from=ross.lagerwall@citrix.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

When the guest writes to the RTC, the write is intercepted and emulated
by Xen and the time difference is broadcasted as a TIMEOFFSET ioreq.
Emit an RTC_CHANGE QMP event when this happens rather than ignoring it
so that something can make use of the information (e.g. the toolstack
can persist it between VM starts).

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 hw/xen/xen-hvm-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 59c73dfaeb59..9b539f5c5c56 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -4,6 +4,7 @@
 #include "qemu/error-report.h"
 #include "qemu/target-info.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-misc.h"
 #include "exec/target_page.h"
 #include "trace.h"
 
@@ -471,6 +472,7 @@ static void handle_ioreq(XenIOState *state, ioreq_t *req)
             cpu_ioreq_move(req);
             break;
         case IOREQ_TYPE_TIMEOFFSET:
+            qapi_event_send_rtc_change((int64_t)req->data, NULL);
             break;
         case IOREQ_TYPE_INVALIDATE:
             xen_invalidate_map_cache();
-- 
2.52.0


