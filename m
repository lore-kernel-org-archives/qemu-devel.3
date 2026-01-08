Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7B2D185F6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdq1V-0008V5-BD; Thu, 08 Jan 2026 08:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@citrix.com>)
 id 1vdq1T-0008Ux-Fy
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:25:55 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ross.lagerwall@citrix.com>)
 id 1vdq1R-0003P4-R2
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:25:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdN1FNR3v4H4+6v/dJ9NcOk0nOjW0WhtEmOT8Gm3Ef9sSy15V413PM6ydpRwwl+CO4OBwxQnUbLDPwyd2EapAAc18jYyUc6m06ud35i7vhaOfcenQY/wVKwgsBwfeAoDTdfqrhsEAqCuScTAkNFv12ovR9FC+XT6jWKD5ft0IzjFXU5UIkpoIUqzxcDzUHp1FfJ3qPFoMIDEuIEoIg/QvgtiV/L3+b9YULFdJqH+T2kONttiK0H8sAFHIwyy7j/7rWm6SQgHpRNGf9vTee/wshRyTG2Eau+zr4MzEmKlSWzaxpBTln9ASMbKjTZR+V23YVpEqjQsJDXMg89r/siEow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwdHsnQoHkSJj8QoKGodjLp0yJa0kP8O6NcLImZqVUg=;
 b=ypqG43lwgmqvCVNQnd50rWOJR3qTk4X5+392lWzFlMnyCZl677iEybZSFR3f2C8IfDUDvYCBZZjaDnum9V9TE1mvpiU9hIzu11VFooLPrUP4W1Xwhzy/OZU8rcvp4kBgbBWegOs/vR/hAchAwoUawgqobzi3Zy7HvCasoVnt7eMMgOUnIWspDt5izDD+Cf9kFgeJOkew9sVB/m9p7dMBlm3ZtNcDwLWm4/l0xkH4eChAKvoHvZSBi1Y2Og8U/n6rdLdDX30OHElnfAH26QvbdfpuykRsiAEsvD2tCV25fXyHCAlBaFXbv65nort3iE600LOq7pYYheAIFaGS5B5M4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwdHsnQoHkSJj8QoKGodjLp0yJa0kP8O6NcLImZqVUg=;
 b=eOZ+UR0LorRx6CVo6rJONsOGZ20uxPmvGx3FRUQmNQj5ZfhLXW+2upKK/zlwBB0NjhFcAQ4tJAi8NVdMoASp8XQw9Y8inI3DdK7K2HgK31vbNo5ioEsOKbDJUlEO6iA6ptI/GD75sZvjYUaDduT0ANgsWdyV4b3WY5JQdxe3KI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8274.namprd03.prod.outlook.com (2603:10b6:610:2ba::5)
 by BY5PR03MB5265.namprd03.prod.outlook.com (2603:10b6:a03:22c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 8 Jan
 2026 13:25:49 +0000
Received: from CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096]) by CH8PR03MB8274.namprd03.prod.outlook.com
 ([fe80::ebe2:32c1:d2be:a096%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 13:25:49 +0000
From: Ross Lagerwall <ross.lagerwall@citrix.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PATCH] xen-hvm: Handle framebuffer relocation
Date: Thu,  8 Jan 2026 13:25:14 +0000
Message-ID: <20260108132514.1862552-1-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0324.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::23) To CH8PR03MB8274.namprd03.prod.outlook.com
 (2603:10b6:610:2ba::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8274:EE_|BY5PR03MB5265:EE_
X-MS-Office365-Filtering-Correlation-Id: 078f95d4-d0f9-4362-e827-08de4eb97012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GeirLS5s2ecbh+cBeeBZ5QG3YVgahGIiByIiEWXznV00qxsaCD0wT8VXd8S4?=
 =?us-ascii?Q?JdnDZnm09xu6ZnFbtQGc45eHQ/Fgs9DfyeJSjLGWNqw4jFlC2Va6Bz/MLA/j?=
 =?us-ascii?Q?Org8KCffsEVY2vmsJZVQREuvI6YM0CEpBxoJagc8hhmYECeKcy5rMlgCJQ6t?=
 =?us-ascii?Q?4/poOP3JO2iKEDuqIKv6Nq+Ir/PR9Ic2csD7rbVitBr8IefjSbK7CEjrGAm0?=
 =?us-ascii?Q?mwXtP18iC/8ws2efA2XKZvzDSCRjsa/7ZCvnzoOtPcqc+jI88zOJiUgKUIlu?=
 =?us-ascii?Q?IYVmIq9REEFWE/E+n19/Vc4ZvYN79wtzn/MNy6RV73D1m+ccnDO43JywS/Sa?=
 =?us-ascii?Q?GxMmfRfbR9u44Gtcs4VpIKxDnHSSKnPMKeXEP//QYxmH9Ba58XOf/93b4Dr5?=
 =?us-ascii?Q?wyTr+Ly+WdFpo7jTU46oWQR3q2gxrWv4QXMnD2xuW15CPdzWP+5IfRPe69lA?=
 =?us-ascii?Q?xVSvnz1ARm5uPxVtuCigvYfjWGKqcJ6mdEheH/LhQQ6lWh2CjmxFxAIxsVXh?=
 =?us-ascii?Q?w0Uqx0LkiEmuFNT002dHKgNaZyBAHUUw3YJiE9tVufxxr53mlVUIxCJHwqKd?=
 =?us-ascii?Q?LoiB/VuBr+0OH+Dz90rZMAd2jgaBdJCfKISCnbuMVKBwiJa1XPtJ6Qqef4Gf?=
 =?us-ascii?Q?tDWSIIPs6QIIy3Ccm1PJjYpDrQOnkFkYprwpfINDwjLdTAf98vNEgT68+Icu?=
 =?us-ascii?Q?z+IU3bjIaE1cx8heJnZH1+iD/QXNgeIWVR3MMIoH8xChUjmCOEsu2VYBdRMh?=
 =?us-ascii?Q?CJhFyvA+6YSY8S3l40EAmNmatfvaG5fcI+VBzft4k/jjOYFC3E/FWXO8AfFR?=
 =?us-ascii?Q?fcWeydrX6V4j+cuTU4ZbKz3JBRafVzNdLWefSpmpMpSJFfIhE4dXhMwqrbP3?=
 =?us-ascii?Q?z95prFTKTNqTRyhd2RcNQqQnA2GcG/OnFzXdjUTWUKYcU4ufHuvNonuY1+bE?=
 =?us-ascii?Q?PD46gUj8GV7YgO90PWhFSKmPGsvgNtc0bM5MKfFHWLh8bIPvoR7iOWGiQlhA?=
 =?us-ascii?Q?ZJEpZ+9QRIQeVKPW+KV2cQiCm6trJ736sPBMTsINQR2kTyKyNAsqYhmjHM2p?=
 =?us-ascii?Q?rMOdPYPTEYsi3lu/CNKezEhjAkD2q7H4mpc8xTqHj684ap7lzcAaVEqtSj++?=
 =?us-ascii?Q?FBVB8FZ4N3NlhlGVfU6yb1ibpUEIlgfoQtLTcCKwFXiMNaotlpE49zvXqsAT?=
 =?us-ascii?Q?8CT+6xHIBnCOkQ4WZvBdYPhYlwgR3Lu3IIkJslqSU06/9Y5kyM6yW0jToRQW?=
 =?us-ascii?Q?V6aqDjFWUqi0nb7lXBrOh+oJ6mxPftjz4HUw3x976w9y25urrrNUv18z3XwA?=
 =?us-ascii?Q?LnK7gyp+N5S6F5+9+JFQsjgVmCdSyEk1KyWgvMwaqHrzWW+qWZgshPLBzUtC?=
 =?us-ascii?Q?tI78Lg7KlWhGBhko5buQhyMVOUg5nZRMsrR1UCX2nj8f0lSESW0D6wjj2n8m?=
 =?us-ascii?Q?0uHZq2aE/WbNk3UrT9fZUxuPS73Vq0cz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH8PR03MB8274.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nA7yLrCAmLSbiZbk4cgW4l0ijXzM+NovV9eUQhc25JfeMlP2DGWvrxfdlrHK?=
 =?us-ascii?Q?VdNnwHGO3oO5png511/sMElPmVwmfX+UkkfFDBNEo2h/JS45gPJZ8x66ZzqQ?=
 =?us-ascii?Q?UIxIEQnAc7rNed1adXPs6hmxwvuD5sOnsWV9MyQWBs2SvQVpiJr8I0EZeMh/?=
 =?us-ascii?Q?HFy+rFMpfDqQuHK1QMFaW5aKd8+sjLkomTFfjAaspDBkAJVDjhkXaVXA1IDx?=
 =?us-ascii?Q?DZrH7Bwu1Zl8Wxjo/DQEYhaTywrL1J5Lm1rt+E4FnryXnbBTt8zYKriQpU2R?=
 =?us-ascii?Q?AC6UJhmn7w/FExjjOPTm+rj2pZMWclp2oZFxA+vDCVlZL2yNTD1Ofg+PrN5Z?=
 =?us-ascii?Q?ehS7pNNA+tqZSkSeo/C4GNjKp38TvZkWZUCPYB+pGWt5sE8ykSc7caiSZKkA?=
 =?us-ascii?Q?Fj2FcxEpDp/tKdE6OqkrTQJzI3AOoJsNzzHO40RvkVHpwkk7wwK7TLxfUrXU?=
 =?us-ascii?Q?SPCRsc7isHpejFJKbmGhIt8TB9l+CoUWh7tdTrvJvmlsw5Gthd0wfpgUC1fo?=
 =?us-ascii?Q?zWaiM0Z8QcrdUo7tYxLAWKrWsJ582dFwYAaa8BjrT2ADDwx0K68fJkbhqox3?=
 =?us-ascii?Q?U4dw8YRUYkNnNWZQit5fXk29iizXPJQXcG8XKGW41hMAPZG2RyXmYBk3nlve?=
 =?us-ascii?Q?qvLMoHS9twYba81EbJsF3dZ9yMf1KZd24XPdgXD2ph2jip9EvjEccb0UdFfE?=
 =?us-ascii?Q?OgwY2fZkIaIENIMFcp1w4iisi8Jv+rsP2fcS9JOGyBYV/i1NrHH6DQamqBLZ?=
 =?us-ascii?Q?kLuyM7Qo7WeZzb3nB/QyjhxYqyyP5K9HXl4ebH1iCKYM8ia4bXaMtwN9nsHr?=
 =?us-ascii?Q?Y8DkIwd3NLiYUAxRsz7cZp22daS4z2dVze2WoU+OjuMtpGSICUBEtz+Mpmhd?=
 =?us-ascii?Q?DzFo+pxHKSMTxlLFugZG4PtGp8Qo1UuLG7wdq/57on75Kzktc9oVsmmVJS51?=
 =?us-ascii?Q?o0UtpqH5oD78OJM/JdvxXeerRQ6ertsxJGunSKwZpRW0NLtatMKw9WVU3pol?=
 =?us-ascii?Q?1T3D4lH/kAmqs45z5V7gXAzRhVt40PX6eBsw4Gk8fzVP8vR0UGb1/kTesy0t?=
 =?us-ascii?Q?XId1CaLpFmHRshKKkvP26Ouep2g2SuH8UXPDDoV1kSl66Ju6qXHzmmqLkRy5?=
 =?us-ascii?Q?2wiN4/5TqyDQisqMTbaKdllth0V0gdvk6c+HMKWlDrNVVR1RBCDUIa0LigNt?=
 =?us-ascii?Q?3OEqsWRwIJMbvtjhBXFXKyuKsZlQnGZEySA9XedpgMigd6irK9IPjzE6KLu1?=
 =?us-ascii?Q?un2NxlYd2VCxUSdWa5t29LR7qKOweOWBSmkrMmn+xs+CDYWP8yh6DmXKMm8K?=
 =?us-ascii?Q?uhpUGDprtpJORHJWfiU2uuRNxB3NP9RjXHK8DhFL+kHak8aLlvdb4/orJey8?=
 =?us-ascii?Q?ADPHIgWXE4Ry295qFu7Viap0gsf0Nwyzzco+bW59QUt9sdZBYnXAwkRcpRGP?=
 =?us-ascii?Q?g6sXGDZv5aJED8ST9UKuRZwS7BuGlU/bEU5Jhd/iCL5NYLSvW5d/IhCSHVeZ?=
 =?us-ascii?Q?kpdDi9xNPnZtnaZLGL+QRluSYt5ZB4LXGh21TYlyCDasPElNpl6HJ39/2e7G?=
 =?us-ascii?Q?Z5BSCgtfTexcnWhag1NKToewGoReVGbMb9yVtW6FukhT18i1FRt4TJS4tuIV?=
 =?us-ascii?Q?jVb/00dj8d0C9LECrSuo0bIgtVrT2T4W2Exn0fntqSV8Q0iHaqcvKKkLEJWF?=
 =?us-ascii?Q?DQ3g+gZPaac7CsjZ1jkuec4FbnMiRlVkdYV87Q6oPNqf+en6q6jYB19vWnIb?=
 =?us-ascii?Q?EWchuAUM7Ds2APSEMCelCOBnBkvEL4k=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078f95d4-d0f9-4362-e827-08de4eb97012
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8274.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:25:49.0310 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7mP9jkEXaohgWVEDlo2DMPmoU8ZGPEzTX0kiHubUPziSxSuZd1U4TLmmy3jCAJjKOOhVJn+ANIIoXjFvzCfJXlpD6hxobrr6glX31IQKq5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5265
Received-SPF: pass client-ip=2a01:111:f403:c107::3;
 envelope-from=ross.lagerwall@citrix.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

It is possible for a guest to relocate the linear framebuffer by writing
to the VGA device's BAR. This causes QEMU to report an error and if the
VM is migrated, the destination QEMU hits an assertion.
The problem is that updating the BAR causes the PCI core code to call
the del region callback followed by the add region callback but the
xen-hvm code ignores the del region call and therefore the subsequent
call to xen_relocate_memory() during the add region callback fails
because the source address is not correct.

Fix it by calling in to xen_remove_from_physmap() in response to a
del region callback for the linear framebuffer so that the subsequent
add region callback succeeds.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 hw/i386/xen/xen-hvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index a6e1683885a0..fd7ef56bdba9 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -720,7 +720,8 @@ void arch_xen_set_memory(XenIOState *state, MemoryRegionSection *section,
         return;
     }
 
-    if (log_dirty != add) {
+    if (log_dirty != add &&
+        !(section->mr == framebuffer && start_addr > 0xbffff)) {
         return;
     }
 
-- 
2.52.0


