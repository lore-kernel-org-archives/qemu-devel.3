Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 183DBCD98D6
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 01:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXqwM-0002Im-I7; Thu, 11 Jun 2026 21:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wXqwL-0002IO-KB
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 21:44:09 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wXqwK-0003ME-CH
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 21:44:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fj5KJ3mVjQnwdqhzcFX9oLqnTUaan4obcim6f/nQupfMU2+B73PB4DtZzlL//XlHFwp0BDpZIVVujuBUunen1JXQjiBXvHYG0UF59k9plqudpnY6l8InNZ3YM796IninUt5so/mgKhEvDNxuEKK8mNIwPBYucRDFeiGO5wM1VW6QJjyQk6+V+UKcRHlbTrNqUCKyaPHl5Ny1zrc4I6zagx24yxNFmbMbCndhQv53TMcBZg852Rlwl5dJ02Xba/bJXfib+JaT5nIOWyOeTr/qZRaSmSnIWOBvt0Ln98JamzeJoXGTnXinx3/J4FC+lfmXLzb259OmJjyglUEgXGtQow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2g4mOGXiUsM8nGtTsdT4LnNvUp8JVND1sZGUC3b6tY=;
 b=dMDI/aGS/WiHklHsmoGkF3wxgTCJpmwO4/nl9SLB4do7AMl3LXYuOtogWs5dhguxHowxLBefb9/TgxoSwxFBqE+5Ir5pXPFR/WAauUpUguV0a3r6A3QLgQU5UmS8FIq5u875YAXTHmZ1C8tsl1QgStJjWSj9Uavz9DGIb73OwVt1q1jC2fi22dUFnFk3Eyas+jBVwYi3fUN23bGlKGyOg0vCC9sHSJ9a8rh+PeGwLJqqzaJYjHTosSkahO1X01JVPAJlz9PO6/5kxXGT8EpZhwNz6QXaNFv3WXd0ibO6e8F8/07R2ODVDYDAh6mbdQGvzK2edcArD8E9D2rdsWTxMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2g4mOGXiUsM8nGtTsdT4LnNvUp8JVND1sZGUC3b6tY=;
 b=DoTkkoVVXr1OtypMmiR0OWNP2Rx4RX+m+nZCQ1o3hb14onzmzNuuMfHS/aOXqss3nKdFG10OV/i6t63fk93RmN69CTI+8YJoxGVCY6of2UvoKbZZg73aGpY+M3UOFpZXkf2t7L+myVW4XId/VOrV9vkndVOGYCYEzXlDehhYe4CYstCxYIwyAqo0Mwim/2L5Tvlap7pUCGziow6Mm+ZmYKh//pN/epYiaPZkPpiGW9//X5Uh0qnI5Q1McBCKJVLsNykec1aeAZjNEG7zUo0uAOXLpK59/ovfztgkITzAQQF5NntMEYYv2WhoJL/eQgi94SbzV8zNCmtWc2HVI7TI0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5377.namprd12.prod.outlook.com (2603:10b6:208:31f::21)
 by DS4PR12MB9746.namprd12.prod.outlook.com (2603:10b6:8:2a4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 01:43:33 +0000
Received: from BL1PR12MB5377.namprd12.prod.outlook.com
 ([fe80::6432:69b9:5b85:d190]) by BL1PR12MB5377.namprd12.prod.outlook.com
 ([fe80::6432:69b9:5b85:d190%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 01:43:33 +0000
From: Nathan Chen <nathanc@nvidia.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>
Subject: [PATCH 3/3] hw/core/machine: Add new compat for vfio-pci ats property
Date: Thu, 11 Jun 2026 18:43:22 -0700
Message-ID: <20260612014322.2918836-4-nathanc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612014322.2918836-1-nathanc@nvidia.com>
References: <20260612014322.2918836-1-nathanc@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0223.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::18) To BL1PR12MB5377.namprd12.prod.outlook.com
 (2603:10b6:208:31f::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5377:EE_|DS4PR12MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cfc245-52d2-4375-1ce1-08dec8240330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: rAr2cSxXaisXwe3xcg9gDmwUvUwDXg3UwphgrKxPAM13U+rxv2HtK2MHVznrJvkAXw8YYXsVXqEaMas3gOR+p7xXnoXOtrXTgSELGAhcFGLvEVMuFq9+SQIzaNbsjI54Dv/LopszbqaoE1QGmuDP30axhQhvn+oU+IyuinFrpCVMLT1IxzYMMMMreoLNe931FUtO/SeyYqwvFbMpRNOgXQHqHvgzgRWeRtjIOZeRHTnL/dHy0gozaZEyiAv3+jijOLSSf9D95iNtksPDXN+hlmiuW1GY5fP1ExWHh8vpJCW+M/hTITyGvRCvD0m+d26VLA79Xf4GF9fv2WFupFw6yHgZokSRyL6bxLP/W4haJN3JrwpcL4HmEwnAjDKt2n5DUQqYjHTkDb9BbovO1+jlfQE+5sbkVOC4TQdWp+rnGhDqbo/AslYjKXg2Yo1T9/G3bMLCyCgdxPgnKXlvBUlNvpAjxzPYgWLqb3q1uk7A6AEM/Da1odSPKumxOXRcz8e6XHu2A1HiRb/TNNgCiWkig1KukyOnUbDCsc1tbCTpFEz1+IcBVxAp8t5tLYZ3eNYhPMR9PoSLYaLMuaq75DPXuPpwKANyxItCCpMhBZXvnCxwd3GcmlsRVsOD9m6qps3605HV8wZ8AuOaj+5pa1TbMMxwn8BhDsQOJOHyYrYrlR9DSKFZQ+hv6QarA/nmPZZp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5377.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QtyO7nE7sG0iYX468+2ZyrW8wGW3IOFu3PaHjFNPajmZSYmHnN7jwyIhxKBf?=
 =?us-ascii?Q?/Cb/PBX4+z64rzYGU0Ks8+st5fsRi9d3raOueZbyXGc5CS/PHHmcvhpKMQuw?=
 =?us-ascii?Q?RJ7CKcAN9bl7s/9MZgOdmUajzqCayThZ92wDQS17aDSnwg2JApjpIwspyH5C?=
 =?us-ascii?Q?zu+MPmo4sv4Chhsyoxf4aodBYgWhYY7CZclOepuApkbouQIAi2i/rTVEX94v?=
 =?us-ascii?Q?Ld66VsRDdk8M/E/Era3o50CQsNIe6hOQez4rW9s9h0LN8A7hYZY/KyhI7K/d?=
 =?us-ascii?Q?8I1My2E6zNtrFkHRv5OMz/xw9uXSRsqjYB2EPX9clfrpS3qkgJ2TAWsLksdU?=
 =?us-ascii?Q?E5K7u19W3ff+jtto73hErgO0UdUYO+fHIe3eP+/VkEkLIXmp00SY1XuGLwEe?=
 =?us-ascii?Q?6fOG3WKebD3WU+3Jy3aXYNObfobnq1yFrJWXGJTLEno0PcRV4EteD6s8eM7K?=
 =?us-ascii?Q?s070dpVwQmmtHjNYpR9Jcu9JkvollyZQ6ByuC8GyzBKHNOrHtuRGAFtOiRaL?=
 =?us-ascii?Q?Qtte3W4becss7CS2EffoTWMKZY7lRgGpcC8G7qB4URN/vvQ8YjDA0nmz/eVz?=
 =?us-ascii?Q?qXg6tH/8FRuDydFQzWjq59DTy9+9QgVr8FPNdwrssU201H4DjC5D+yfSidgl?=
 =?us-ascii?Q?g3rR6Qu5MmDLXz/K70TOmNxw7I0moLvvBmZg10PDq+1rrW+xJOohpQ6z9HAc?=
 =?us-ascii?Q?lLkx9bFj1lNCA3dQgdISOAgOhqHahk/ZEalRyQwsaOrK+VCzyjXiO7f/CXyV?=
 =?us-ascii?Q?oAm3FdP46DG5tDUecH7nyjqhol0+u0oh8U7XpDD8OxbTXeaepUIpSG+Vrybe?=
 =?us-ascii?Q?i6wdRNB0g7XFCvzKTxCrfY5UIOBPasHokKK6mHgIAgo0aHbeVjzAufvAhA12?=
 =?us-ascii?Q?TtxizsySp7/czorm2auBkQwXyOBlo4yrkExGuer+HZnPDmtiR4fFei8BRsa9?=
 =?us-ascii?Q?Fw0dLcWMososui07dRur+u142iXcHHOLbtyaPq3WilSQ47x5yUQ9SflIjDy5?=
 =?us-ascii?Q?9hUEm6dItrGZkMnNZsFFW+irkGwgeolnD55mtlJgzk5fJJ3etIO6xowMIHGI?=
 =?us-ascii?Q?EmRE5O0ePP9l6WnKz0JOhMT9d9BKp2HK0XboJuIYMe2fAWK7Ar1uxj3hc1f1?=
 =?us-ascii?Q?yn89wAhMCj7/9TahGqS371MNeDn9Tz332wZFcKi8Kv6Rf8UWZDJTnSMWFu0M?=
 =?us-ascii?Q?v3NiVsibY6BhuBS1h2kL4o1PTU/2R+yS4ltHbLJhc/eRFHnCQwKfLATPstRq?=
 =?us-ascii?Q?HaSZAQOaahIem5QOGHAvVjsJAT3VMPfHsUJKuca1kpL4zVgJoicY3RwfLSbE?=
 =?us-ascii?Q?7iE5rAaIiDPz5zb+Zn9muq9TSFNw6iaOAB/f5NI6uoutkZ0iO2jFmbs6IGRt?=
 =?us-ascii?Q?M4kZaPfrqgArKxxFvj3PqKcyeKOIT4u7O1vl419m10mUiF+YZrrX4WBLPS9l?=
 =?us-ascii?Q?aRBuuUj2fLtd+ozaQEeNSkBwl9RIs224LDI5HI0Hz4FFQI2J4GzfJOW2WLiO?=
 =?us-ascii?Q?2hhMRn4CL07VKKq2cpm73+P74goZu5WsqmaUxUBYQRaUHuvF/kA9c19FXNqv?=
 =?us-ascii?Q?6Q0Jz/SGBPd15Ob6unTcl+VTbwwRsHEOw/lzAV+P1bHzyPYEbiFvlsatoIvk?=
 =?us-ascii?Q?SstFjHjfTQpAUHRx20fSEkQ1pVUzgNYO49VFpLYWwrbSKun2avkbQRHNqg1r?=
 =?us-ascii?Q?oYTnhfjHbfyK/LPRZbz5FmvztkEm3pGzsErUfC1UXficm80X4Lihh7FqYMWJ?=
 =?us-ascii?Q?scs1LDFEbQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cfc245-52d2-4375-1ce1-08dec8240330
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5377.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 01:43:33.1842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TL8eDeVVjcsPPeJ/Bq5rTSr0o1JpJ3gdw2S6FX+mgxibyrfh8IUaaR/KnNvGGmuiIRkrXmVYZpLzIIOMxhwgdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9746
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=nathanc@nvidia.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Nathan Chen <nathanc@nvidia.com>

Introduce a new compat for the changed default for vfio-pci device ATS
property, from "on" to "auto".

Signed-off-by: Nathan Chen <nathanc@nvidia.com>
---
 hw/core/machine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4d8b15d99e..c0cdf7c9da 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] = {
     { "chardev-vc", "encoding", "cp437" },
     { "tpm-crb", "cap-chunk", "off" },
     { "tpm-crb", "x-allow-chunk-migration", "off" },
+    { "vfio-pci", "ats", "on" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
-- 
2.43.0


