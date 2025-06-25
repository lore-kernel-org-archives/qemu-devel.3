Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E296DC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVpe-00082T-5T; Wed, 25 Jun 2025 15:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpP-000817-IP
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:49 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1uUVpN-0003b6-AC
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:30:39 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PJKsJV020637;
 Wed, 25 Jun 2025 12:30:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=ipwxrd7dvyRiZ3WRkuBCWgYI6rKFvryFDkV4qjtHC
 6o=; b=qjd3A1cQNKQig2vqD5cFep6kdsFMYVXzrOGM7g/oOM6FvzrJwwvxFym72
 tzAru642KInx4XoRLZq1nIAjPWXRzFvble1kFt4nmudTvsvabGeFso78neyQkeDt
 0CucLm6aiod7CXe7xsfYrVn8iHHAJPUrgovCoQgsRREzhvR0Hb9TFiyMlm6wUnn/
 GMMSdUXNEUkQrGDNcXLg5gvaMsqtfOOJOAd0bAXZPOrZ6WWCaE6DWzzHbHfchmEt
 QlMX4GlyAodA1Qme7T1bxw5rS5sgfT1jBVzTfe7JkUcXIaJ4vqL2XNq2I4gqUfA7
 BHIOcKiUPaH323zM9buKxRpXsUM6g==
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2136.outbound.protection.outlook.com [40.107.102.136])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 47dtuhaqnk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Jun 2025 12:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMTpM9CVI+ZLMOQYvRNIyreHHQHRn14CiLleS+q1leMX/iQKa/IWSCQzho96xhanNuFaEqT6o2UlHhAr5eT5DPYMKErkKTK4klxCh+rb6SGugWVIr0x6RurhjkhghaIjOZen7wlVFf0ByJIcLrkCz12Xu7vJIXE76vL5uZP2Alp6prELv9JHwoxAcu6jR3R8DMP0gdFGRVsYrjwedYWGY4pWYlYe7GNtAzuF/PMRBwuLtm1gykd8v1LPKfupbTGNsB048x5hKKFAnd3PGxbvrutp8VHKCU8B5VXxDDcC/97aOGe4mSkTVjlyAYBbQClW6qARxgrPFjlweyk4Fz5Gfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipwxrd7dvyRiZ3WRkuBCWgYI6rKFvryFDkV4qjtHC6o=;
 b=G9dnSHFYBcHuKTqGBK8gM1ancvzhB/Fcf0LuqsCLJoN5daC92iUeeqHY12dKVbm1T4tTTsdgSut7+sKmQ6hpYWeXqj2jJHpzIZ0/i+9AUHlBV99PRKV8pQ/dNiSSSVrjibrLYHC7uXx7bL9cKe3SYnPT7pfbjhuRN/YjNzNtBQyYu6ffs71hMZzb1vHQ691AvQ9fJQTeFUNWkFUR8SQmvluf9ArwpdaZcR26tSi6WNMn76LPvGTGUTXixd8K8RXEOM/vdkWSTtnEPevmmGWDWvaRPw32YeBmlCjoU9Sq1Z+SnGh2stFe686/Rkn6IOO+s5Y2jCCCTHpkZM1G9L9WRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipwxrd7dvyRiZ3WRkuBCWgYI6rKFvryFDkV4qjtHC6o=;
 b=EcIoqUoDynOtbUvYYPyBTWc+kNKPgH2XccFNSzojzCqTVL9LZHhy+0Xo+6DRUqqWV6Qw6nnBYULwmlffTzRxZ8wTRSl+fLRcPXn0v5lThdziTm8Kd51II6D3PlXvX7ncFNen8OY/Px8a8hjXK8+6gDicopVIhCzpvM+EgwlV0F1yf8urbGjlfurE9QUVMG1CYdTNIBzUIzj+v/AA9/rOmnBOlqtoca38OayBOKTdBjVt4yaPYUIklGJHG9OUxwHT8AJ49khmGiHBacjkSID8n8S2J38oNw5jzTq03G/C3aLaHFgzSyQyYenV+U9sOjgoxOGK0/eksT4ah0VKiJ4x+w==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by PH0PR02MB8535.namprd02.prod.outlook.com (2603:10b6:510:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 19:30:33 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%2]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 19:30:33 +0000
From: John Levon <john.levon@nutanix.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: [PATCH v5 06/19] vfio-user: implement VFIO_USER_DEVICE_GET_REGION_INFO
Date: Wed, 25 Jun 2025 20:29:58 +0100
Message-ID: <20250625193012.2316242-7-john.levon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625193012.2316242-1-john.levon@nutanix.com>
References: <20250625193012.2316242-1-john.levon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::18) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|PH0PR02MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: c288a4cd-5f7c-403d-a1e1-08ddb41ec0d6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?omYpKWD23utHdA8s+l9aDaTTlgnEexk4To2SNAjHLO883z/0aPmjpSesv8G0?=
 =?us-ascii?Q?sKmkHfyK8S8OXf0nxvq9tJs0kPS63fVt1q3t1+YX5wrw8bruKkSUQ7o/IjuX?=
 =?us-ascii?Q?RmPpJpY856MJ0Dl3GcvRu7SeklBaHinUQxPzoooXiERxpTqbmD7cGtSGA26o?=
 =?us-ascii?Q?UHkK9/D1cDWhSet2+U/N95pvP33hOkbx7h0KJylw/53Az52EdXfpidPJyYCP?=
 =?us-ascii?Q?KSa504jwkPY94OhZSJWGDK8gh9U+1QYH17Tg1J9cp5XID9rXf4ZNutpZWv/e?=
 =?us-ascii?Q?EttRFzTprn/zoAe5LLDDwDteS0Km07kN/P9iNb+fbtGH3iy5SQxpTf6dquck?=
 =?us-ascii?Q?+2VOi1KCkYLCBTqe3UGjKklUmjKU2DPq7qgCqU2lc6POzgKleWqf7JjTr7ST?=
 =?us-ascii?Q?KdNARqmFjZ9zfrQX9j/+6q+MXMzE8SexAOTDxsRcdWjXPropSnMXzyj5YOK+?=
 =?us-ascii?Q?Er56MsUpxOOsoUwVZ/bVpkX2DR6Lz1siunZksZH7suYu7a4abG/bd7r3f7Uu?=
 =?us-ascii?Q?Q6QsazDgY9+3JQx03Rpajob9bTqt2lGyayjcF6RvhHqbsQmR8xnkw7UReC+1?=
 =?us-ascii?Q?o4759AYhakN8fBjHqbRZi4rSc0rEdeyESfIirahJoz3yenZbzG0vNy34s5hu?=
 =?us-ascii?Q?Bl+xswReXw5SfuSwbUqZveh2XnxfCaKWiCua2KLB+MDOvecCXeRvz24gW+uP?=
 =?us-ascii?Q?AyD4gJ7zMhHPnNHxa839bg8eL1ifFR+xYSv13rJplkXMNWgzck7NxqUWfEGo?=
 =?us-ascii?Q?eJeQOk5LWMGMy9v6i7QVfBACA++o2JbMYOB2vqA/tocDq0f+/HFdil0B0MR7?=
 =?us-ascii?Q?9gHZz/X4f4HoU5vcGV2fvYb3wWJa4tE+QkII1rVEjWS9F6WfwxVfLIi7sMyB?=
 =?us-ascii?Q?P79/y2ft20bwrLyt4ayB4wS57tB//SVgJK4balkHhwpUzGRG70dJDedxedoK?=
 =?us-ascii?Q?qgnMeUnmc6/fA4LTLd1+vkJ7sdCRGsZnbKiuD8Nk8eoQ4dJryJmZzvj9/zxp?=
 =?us-ascii?Q?VZvG61XVfUxouR8C3sGyAAHMjCRkFqLDeIbp7is+GxoyB/j7dQXb7jTFdhEw?=
 =?us-ascii?Q?cgLVgshHP6hsTJvYUer0Vf1HWfvthqrxu+YbeIoZt3BvP2QDg1r2o8qfcNrK?=
 =?us-ascii?Q?Im6xNKfvc8Ap4cTH5VcS/uuKniOCcNEFT/u39vYiwBXc4CdZibvHDuWKwx8r?=
 =?us-ascii?Q?Aam/Xr3DJtgsnDdNmbtra0F1xGVZSVzQwtFMP/XNoAONCBjpVKaCDpZQb0Gj?=
 =?us-ascii?Q?WSS72TsjjVUNVnTzfF0VwFyjFS16LavjmhlXoKlnz+LICsTYvt09ioYve3Tb?=
 =?us-ascii?Q?jvR31lIkP8F1zAdRW3P7WWGJJN04qC58O1SemgG7SW0v/AtOGyWH7qaub3i1?=
 =?us-ascii?Q?b6h4XqPWACFENXTB/GplrCkJpgJ9l993bIh6obkGXRxF6oau9g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EpubiQDYjTNEDOIQ34VXNl1G9Egq99gaJc78lWTskyEGZawG4XvGf21/2rYi?=
 =?us-ascii?Q?3y/7M07xu9jDnIPXYMEnrOSB0KRZqvxtvPFM30c4ZRRQaVLA47jaNnpCpfLo?=
 =?us-ascii?Q?7dSnWAvE0nrrLH5bmCT/pd/mzcA8gfpVaLdnNCvog1g/fcS/3AWTqSAfnb5K?=
 =?us-ascii?Q?R4lSbPhhizbWSfifoWwKm4ncgyUdWzL4jVvmjI+4UfUfN9IxGv0C/f2sBKJy?=
 =?us-ascii?Q?PXXX5CiwCQebL1XEqcMOxKChl+yyMeDeXvyAdP5kepIp33z7gGSLAuiP37wr?=
 =?us-ascii?Q?CWJLW2JqzX3lR+Ji3whDewwNuQg1wPzwOj2ItEWcSZDHJJo5t2CU/domVKzB?=
 =?us-ascii?Q?yqhHzcD/AiB2Dw2L+m08YtHVqXkWtnihlKpB1ZUx3DZ9RGfOSUBEI3NlgWAw?=
 =?us-ascii?Q?4yuEhp1Zu5PSbHsgaOM2/MGChxD8ETWwfpceXKcLunXMDUxxJlSdOXve8Ezb?=
 =?us-ascii?Q?CBt4wZx9HV0LcFZ3s5JvgKwxqaeriX2GsFXcCFZb+Pn0De2HIVJrHMKAyUkV?=
 =?us-ascii?Q?/SSQbMeDjhftZiCcwUjhPMewsHzTOW1j6v6G4w42gMiIi5tn94qUFPpqeitj?=
 =?us-ascii?Q?8JzajW2cvxPMoQRBZ8VLfBKGm5t9hqxCm5xmE3kFxf6J3l5ZHyzpQ9KnVf33?=
 =?us-ascii?Q?q62GPEFC8KSBC+xHEnOWtJqSHVEvWs0UW3o56iaDndSzFu4q5jX6lxs2naAR?=
 =?us-ascii?Q?oK3pdxkjbaxJXXknZ3FzYOzrijTE42JS3M9I7JZrztdDt9seJkDy4+qbA30q?=
 =?us-ascii?Q?Bnuy6PHkUKbJpLwF7a9vTe97eBvXzPaTI9caFbwf3rV01B/kTgjVaf0C6xvW?=
 =?us-ascii?Q?Dgv/YP9zF7gNHSWy4BDpoLYQfVf/3e6Xt0Vi/P+x2NRRU7IsX2W/lvgfSoxc?=
 =?us-ascii?Q?1UQ/0xfX+dH0TOMqYtRExQLWi4d4DmPu0I1i6QZofXKRU+Vyjc1XquozAHKF?=
 =?us-ascii?Q?xZUBHSomEaczhRszl+jpYVlPybNkVeIplZJ5MhTR3t6QNl7DzgUXzTjuVpZ6?=
 =?us-ascii?Q?xpMofy1kIIKSGzkbdsWRbOPaQOaQdlxojQ2X10gSikJIkloQDu+gbC4LQ5U1?=
 =?us-ascii?Q?MfLiwI1zpqZdAYLi28UHMshgLDz8/Nmi5nw1GtuL8+lYzxui+ayRiIhc+tHC?=
 =?us-ascii?Q?9mqOw1Cpm0CVHXS714ZbyU0T2Pb0biEe6PYOw/R1u4tbWJ8izHtkUhuYxajF?=
 =?us-ascii?Q?rsYTJ46pGOm6CNFBiV5Wvk9eXX1w10DFf1BciLebQRMOFCGFFrlUDlLOR5P8?=
 =?us-ascii?Q?kp0KWHDWee9iT+KWqRI83h/EA0RBuwbLVHrhFwRJ/WZ8uxVIdEP3TPkFY/3x?=
 =?us-ascii?Q?vSYyGryqvJKd/jHCD2hTmLU9mY608MaxnZgr3fIAPlfVV78m2AkI/6BIr3+y?=
 =?us-ascii?Q?YhGxDGw6AvYhvnGtqjbHowvj/ORWg/RglwAMuNwzUHEMNk6XDLFPJwmHALen?=
 =?us-ascii?Q?67uT4/UvnDqZKC31YeTEvmYcT1/RYylAw+I9jQ/4DDLrY1b4xj4gyg3HFRC4?=
 =?us-ascii?Q?z388ljzWr9x9mOc+HIyZuZzosA+aPTKZW85yE85/P+01m3JRmbgScGH1zwsc?=
 =?us-ascii?Q?Cr712C7HNH6hlEhoq5d7JVU4+OuOyPcV3GPEZ+yg?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c288a4cd-5f7c-403d-a1e1-08ddb41ec0d6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 19:30:33.8243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/LFNHhdERoCccu0DSaruz3+ejJXd7ItDwY1LGnqfIEL0lJjZBYnVVl1eGFHSjHWwkPaVEEEiWkSXW9wpQSZnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8535
X-Authority-Analysis: v=2.4 cv=UK3dHDfy c=1 sm=1 tr=0 ts=685c4e5b cx=c_pps
 a=52DuV3gV4edYeGGkgF1W5Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=0kUYKlekyDsA:10 a=yPCof4ZbAAAA:8
 a=64Cc0HZtAAAA:8 a=u1fsugoMv0NfKDGiTLIA:9
X-Proofpoint-GUID: uTKFmLj1ZFri8TyOFeRrAst5n0L6GJhq
X-Proofpoint-ORIG-GUID: uTKFmLj1ZFri8TyOFeRrAst5n0L6GJhq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0NyBTYWx0ZWRfX7JBtuUh/0X86
 mFkmHMpYjEceuz2VMWZI/w3iNHyiD6sZPp8x1TxkQ8MGn/3RLqw6DLjonKgynOuP+Sog8zBcO9T
 f470fyxAEDHtnb69LcxfGsOT+e/33jPXuVQ7tdjvl0/y7030PGPLkMe5uQlfSfqKcnk7PMhUWQ9
 n+eO0Dqh2RwKB4nyxtZC/+Tvc1N6U06pz/P+MGDxno5YhCrwG7La0vBzJYWqBsTsYng9wMoa9D6
 YuCvALvXgXm/R+OtuZD+0JXxsMDOnvAxmxYUrQAROu8OXh9OBCA2NjOxsK7leYl4WuwyH3riARm
 dvXvD6CzGJl47bSy83/9sczhcUmySqanpwMhQIzEJYcx8748OEd3/mM+DlSOcWDKJOoSNzjPJjs
 YIJnf2I7g3oYUYUIAMQitEIWnFdgP1VnK/femGD+9H757fNcVe504UymC5LO10Pph5oWOSAf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=john.levon@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add support for getting region info for vfio-user. As vfio-user has one
fd per region, enable ->use_region_fds.

Originally-by: John Johnson <john.g.johnson@oracle.com>
Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John Levon <john.levon@nutanix.com>
---
 hw/vfio-user/device.h     |  2 ++
 hw/vfio-user/protocol.h   | 14 ++++++++
 hw/vfio-user/proxy.h      |  1 +
 hw/vfio-user/device.c     | 74 +++++++++++++++++++++++++++++++++++++++
 hw/vfio-user/pci.c        | 11 ++++++
 hw/vfio-user/trace-events |  1 +
 6 files changed, 103 insertions(+)

diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
index ef3f71ee69..619c0f3140 100644
--- a/hw/vfio-user/device.h
+++ b/hw/vfio-user/device.h
@@ -17,4 +17,6 @@
 bool vfio_user_get_device_info(VFIOUserProxy *proxy,
                                struct vfio_device_info *info, Error **errp);
 
+extern VFIODeviceIOOps vfio_user_device_io_ops_sock;
+
 #endif /* VFIO_USER_DEVICE_H */
diff --git a/hw/vfio-user/protocol.h b/hw/vfio-user/protocol.h
index e0bba68739..db88f5fcb1 100644
--- a/hw/vfio-user/protocol.h
+++ b/hw/vfio-user/protocol.h
@@ -124,4 +124,18 @@ typedef struct {
     uint32_t num_irqs;
 } VFIOUserDeviceInfo;
 
+/*
+ * VFIO_USER_DEVICE_GET_REGION_INFO
+ * imported from struct vfio_region_info
+ */
+typedef struct {
+    VFIOUserHdr hdr;
+    uint32_t argsz;
+    uint32_t flags;
+    uint32_t index;
+    uint32_t cap_offset;
+    uint64_t size;
+    uint64_t offset;
+} VFIOUserRegionInfo;
+
 #endif /* VFIO_USER_PROTOCOL_H */
diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
index 837b02a8c4..ba1c33aba8 100644
--- a/hw/vfio-user/proxy.h
+++ b/hw/vfio-user/proxy.h
@@ -15,6 +15,7 @@
 #include "qemu/queue.h"
 #include "qemu/sockets.h"
 #include "qemu/thread.h"
+#include "hw/vfio/vfio-device.h"
 #include "hw/vfio-user/protocol.h"
 
 typedef struct {
diff --git a/hw/vfio-user/device.c b/hw/vfio-user/device.c
index 4212fefd44..d90232a08f 100644
--- a/hw/vfio-user/device.c
+++ b/hw/vfio-user/device.c
@@ -53,3 +53,77 @@ bool vfio_user_get_device_info(VFIOUserProxy *proxy,
 
     return true;
 }
+
+static int vfio_user_get_region_info(VFIOUserProxy *proxy,
+                                     struct vfio_region_info *info,
+                                     VFIOUserFDs *fds)
+{
+    g_autofree VFIOUserRegionInfo *msgp = NULL;
+    Error *local_err = NULL;
+    uint32_t size;
+
+    /* data returned can be larger than vfio_region_info */
+    if (info->argsz < sizeof(*info)) {
+        error_printf("vfio_user_get_region_info argsz too small\n");
+        return -E2BIG;
+    }
+    if (fds != NULL && fds->send_fds != 0) {
+        error_printf("vfio_user_get_region_info can't send FDs\n");
+        return -EINVAL;
+    }
+
+    size = info->argsz + sizeof(VFIOUserHdr);
+    msgp = g_malloc0(size);
+
+    vfio_user_request_msg(&msgp->hdr, VFIO_USER_DEVICE_GET_REGION_INFO,
+                          sizeof(*msgp), 0);
+    msgp->argsz = info->argsz;
+    msgp->index = info->index;
+
+    if (!vfio_user_send_wait(proxy, &msgp->hdr, fds, size, &local_err)) {
+        error_prepend(&local_err, "%s: ", __func__);
+        error_report_err(local_err);
+        return -EFAULT;
+    }
+
+    if (msgp->hdr.flags & VFIO_USER_ERROR) {
+        return -msgp->hdr.error_reply;
+    }
+    trace_vfio_user_get_region_info(msgp->index, msgp->flags, msgp->size);
+
+    memcpy(info, &msgp->argsz, info->argsz);
+    return 0;
+}
+
+
+static int vfio_user_device_io_get_region_info(VFIODevice *vbasedev,
+                                               struct vfio_region_info *info,
+                                               int *fd)
+{
+    VFIOUserFDs fds = { 0, 1, fd};
+    int ret;
+
+    if (info->index > vbasedev->num_regions) {
+        return -EINVAL;
+    }
+
+    ret = vfio_user_get_region_info(vbasedev->proxy, info, &fds);
+    if (ret) {
+        return ret;
+    }
+
+    /* cap_offset in valid area */
+    if ((info->flags & VFIO_REGION_INFO_FLAG_CAPS) &&
+        (info->cap_offset < sizeof(*info) || info->cap_offset > info->argsz)) {
+        return -EINVAL;
+    }
+
+    return 0;
+}
+
+/*
+ * Socket-based io_ops
+ */
+VFIODeviceIOOps vfio_user_device_io_ops_sock = {
+    .get_region_info = vfio_user_device_io_get_region_info,
+};
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index 61f525cf4a..d704e3d390 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -12,6 +12,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/vfio/pci.h"
+#include "hw/vfio-user/device.h"
 #include "hw/vfio-user/proxy.h"
 
 #define TYPE_VFIO_USER_PCI "vfio-user-pci"
@@ -103,11 +104,21 @@ static void vfio_user_pci_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
+    /*
+     * Use socket-based device I/O instead of vfio kernel driver.
+     */
+    vbasedev->io_ops = &vfio_user_device_io_ops_sock;
+
     /*
      * vfio-user devices are effectively mdevs (don't use a host iommu).
      */
     vbasedev->mdev = true;
 
+    /*
+     * Enable per-region fds.
+     */
+    vbasedev->use_region_fds = true;
+
     as = pci_device_iommu_address_space(pdev);
     if (!vfio_device_attach_by_iommu_type(TYPE_VFIO_IOMMU_USER,
                                           vbasedev->name, vbasedev,
diff --git a/hw/vfio-user/trace-events b/hw/vfio-user/trace-events
index b7312d6d59..ef3f14c74d 100644
--- a/hw/vfio-user/trace-events
+++ b/hw/vfio-user/trace-events
@@ -9,3 +9,4 @@ vfio_user_recv_request(uint16_t cmd) " command 0x%x"
 vfio_user_send_write(uint16_t id, int wrote) " id 0x%x wrote 0x%x"
 vfio_user_version(uint16_t major, uint16_t minor, const char *caps) " major %d minor %d caps: %s"
 vfio_user_get_info(uint32_t nregions, uint32_t nirqs) " #regions %d #irqs %d"
+vfio_user_get_region_info(uint32_t index, uint32_t flags, uint64_t size) " index %d flags 0x%x size 0x%"PRIx64
-- 
2.43.0


