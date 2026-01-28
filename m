Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9E5D3F07A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7XE-0008Qj-Pr; Wed, 28 Jan 2026 10:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vl7XA-0008Ox-Ne
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:32:46 -0500
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vl7X8-00058a-Tn
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:32:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQaw7H/TD1PrRkWgoQUAHGS5oSu5BdbY6+X2FZSLNWry2Nmaj/+dW9LNdylnA+WIieYvl9an+PG8md656G8jmvFRosjgh4P+04j26VvxhwBBOJtIfNHO6czk8Vr2tdjPfOaVXtSX4cpqU/tTAwQq4xUXPAnbG9l6rWYU+CtQybhSEhU1jSQajcamOjIQUUWwoxTG8H0q3pXOEEuSx9IYGXCsUn8gHAsqFedvdHos7+0+5eYZ4kFc9j46sUDCetxP12pNbkepHQh575Xyqjyxhli09gPpsYG3E9AkBW2dudkSRrTqCmZjuBodPqEsmNxVKYl2v1g+1QdPV2z6+U3TmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLN85l7n+GFMYoCaFDm3ciPePo0N4xbGYMoJeIYE3UY=;
 b=kBVy2X8+WosAIn2arBsKWlDt7MK8Rcm/SMFDz3X6/TOxHvF2aet11RtrpGQyHaurxEHhsYiadLhfsqk3Gye/kzc49uQYKr9QvbE4QcEM35QM3YO1e714ZpBbz8dT+rfy9+0SgMCiXXMnBb7qBBKsfjyxVri41maxIuUYIulq88CSUzSMHzpCVO0TK9WF5S1RMKt5rssy46TzvJIhPb5NLgE9+K3NlvxiC/W0lnLJPT93rWGHl6EPSVZL4gkHsD1QD3CYOY8u3EBYRJkuzSUhwWM2jx5TmvYfI5scEm57Cv/i/DXPsoqF2CVxpbKJR1wp/2xLJDvG0wzKi/pskTzBFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLN85l7n+GFMYoCaFDm3ciPePo0N4xbGYMoJeIYE3UY=;
 b=LDp3T1kyqwJHpv0WOunLwjUF731CxfZnbfvS2ue0RiOl6N98ofNylYaZ/OYTBojapjJ9PXuqBv2xIByS2k3pPLXyVL932o2D75PYa73WaUwQZzJF8QGt6RAcPVGDi9mywp9te1giHzy8OdgAFz6USwIUYwT62FmkRAB51vJtq8WXIEY6XhwmlEsGerYEzQ2IzoXa6tZhuhr4ImmdmFYu0b5mRj0MeDLsLgchjJZkrBtsS0PW4D46GQqitiQZ5M0op2ykCw1JTBEs0Gl1ftro/kkuzylzq+4hMzqZiMalmUBFXBQRQhB+EQHWZ4E/0b518KvEwML7ztKu0+417YQLMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Wed, 28 Jan
 2026 15:32:32 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9564.007; Wed, 28 Jan 2026
 15:32:32 +0000
Message-ID: <cb677add-ef2b-4ec6-9ba5-13aa2a50ec90@nvidia.com>
Date: Wed, 28 Jan 2026 17:32:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/migration: Send migration event before device state
 transition
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20260128105159.10282-1-avihaih@nvidia.com>
 <36062a37-0af5-49fc-ac06-212096fb2c30@redhat.com> <aXoiAsGCWRv1nwW-@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <aXoiAsGCWRv1nwW-@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0013.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::20) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: d0361a19-898d-4170-bb0f-08de5e827401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWtVK3lPYnB1a0wrYlBRdSt6N1doUUtFS2xRUnltWXZrcEErZ1pLTFQrTnpo?=
 =?utf-8?B?K21CTXp1V1U2Y3NHcXpsZWpuSm9Ic2RYa0JMTXJrRHI1NU9mUm1nNElyeXAw?=
 =?utf-8?B?SHgrZ2I4d1VJV0xCaTE0Vy85UG9LS0FZSkE2eGNhK0NPSXpLZHRzTi84QXQ3?=
 =?utf-8?B?dkZmbGVoaEVOOUt1bG9SNTVaU2NjclJQTXE1QksydWh3NnZlZWYrTjlhd096?=
 =?utf-8?B?N3Q3eVdOY01Rd0xwL3dWckRJYU5vRE9GWisyMmk5aGFSbmFrYW1mWmdvcWZj?=
 =?utf-8?B?YnJUbm9sMW00bkJ3SmFtQ09hc0NZNExqUUlDZDByZzZuS3lQalIvZGRYMHRG?=
 =?utf-8?B?bTdvVmlxVjcwQlBFN2oxaW5vVHRRMjhzSWVKUHErVXc4ZXJ6bWd2Q25sZkNm?=
 =?utf-8?B?UlFkcm40ZFA5K3BrNVNWbDkzRGhwSll6dzN3ZFNLb2FZMHIraDdrUUUyOXJJ?=
 =?utf-8?B?QVpncDB0RFdKVFVZTit6aFJFbVM4eHRuWWJVZTJUbG93V2Z4UFpsYjBCK1g5?=
 =?utf-8?B?Y1BrT3NGcjVJSWhpT3pzTkdUWmxjSGNxT0loWlVJaXZvNDBJNy8vSUZyb1hl?=
 =?utf-8?B?NmUxVTJVcnlmdnlzaWxvQnlXZjNBYWMwc0ZvOUtmVVRWcFhWUGVOeGI3eW8w?=
 =?utf-8?B?aGZuZEwrTHA4QjlYR0d0M2xOU1JYOUtidVhBa1hnZW5ZY2hVc2Q4ZVl6ZUc3?=
 =?utf-8?B?RGdjZXhXbEpORUNGTEhiTU51Y1B1NzNYS3V6My95eWRoRjlsUnhYWm92UlI4?=
 =?utf-8?B?NkFHekZTcjI1TkRQbGJ5RXRzdEM2MDg5aHk3VjJlZllpM3BOMjFTV2dpOVlR?=
 =?utf-8?B?ZlVNSGJXNEZvZVQ0bmttVlREMjhFQ21iejBJVWFLL2NWSnpaMWE2Vk4vQWlV?=
 =?utf-8?B?ZkZYSjdtbFZCTUxsbTFySWdZOHNka2lQOUFma0I3NkpjYU01RlE0RkhtbkNh?=
 =?utf-8?B?bnNRQ1Z0MWY2SnYza0dPb0l6SUNscURxbHZYYi84aWpESFhsam9XTVFsa1dZ?=
 =?utf-8?B?NjZNRkpLNGZYZlF2TkFiU2VpSkh5aFV0Z2djWTVBWUNzeFpBd3QrajR4bTk4?=
 =?utf-8?B?MmRWa1pabG5ZeXdtSUlBMzhCV3JIdDVLamVCT1FXOTc2VWpIS0FaT1dMVFFH?=
 =?utf-8?B?NFFoVzl0ZXdrOGt2eHFGN3dLZTFFV0x6VTJub3NhWXBNVzB2VGlVTWxWVTJI?=
 =?utf-8?B?b3hETWFQTFg1UWIrOTAvT3BSMDNVT2NVZTVRdWVTUmJNZnJFV0g0bE5udnVV?=
 =?utf-8?B?ZXZRMUFleEFzS3JWbmRpSERFMEJkRGowNDd1N0hJWjRGR2pMblN3SU9oMGRx?=
 =?utf-8?B?N2RvTWRZcDFxeFpBSXJmUUVnL1JnRmdoS3NFNkhCQWZUWGlXejB4d2RNVGM3?=
 =?utf-8?B?b3VkQ1dOblJIM2h5c1k5R0hlWFlzT3llZEVWSEZwNXBCL0Q5TmZaUlMwYzhz?=
 =?utf-8?B?ZXJtdWVOZno1QXhibVFST2RnU010VHJvUDRjcEQ3SUpwT2FFaVVCMjI5bXZh?=
 =?utf-8?B?Vjd3WDBtZDRtU0ZyaS9ic1hRQkxHNkRDK1NkbmxFdmpwSE53ZDIreTNraTRp?=
 =?utf-8?B?amFpdGdseDJWTEN4czNuNUM3ckhQcVBoakdIUXgzaGdDM0JhSCtpU3JSVENY?=
 =?utf-8?B?OUVUVEFiMTVrc1Y0d2Y2RnVJcHZCS3A1UzQrbXFxUkZ5R0RldzN2RlUwWnNm?=
 =?utf-8?B?R0l0OVNqY2ZxcXB0TE5FUzdIWXRINmdkSU9XcGZ1czR2L3oxWWZTNWRDUVVB?=
 =?utf-8?B?Ly9UR0R0WkttSGl5RVp5NlFmM0NhRXFLeS8vbWtiM0gyZndBYnJkK1RhYVB6?=
 =?utf-8?B?NVpiQkVwdk1kdk9ZYk52RU16ZWhZeE9sa0NwSzk4dWxCbFJ2eHpVY01RaHNz?=
 =?utf-8?B?VzBGL0RMcm1EV2Jray9KTmR1K3VwZkkzcXFMREJkVnVnekljVXdOcTdSRGtv?=
 =?utf-8?B?Y1VHMTh0Mk1nbU1Kc2ZEOW5CSWVjSjhvYVQxYnIvb1AxNE5aRllWb1FkZmZG?=
 =?utf-8?B?VVhpdHZEbnZjNUJXdW5PYy9wbFZlU3dBWU1FTkZvdzNsVXhUazFHVjl3VlIv?=
 =?utf-8?B?N3lScmdmUThIWHpROERsQk9pREp2UytuSmNORXljc1lEMTQwV0RiNkJVYVpq?=
 =?utf-8?Q?hhkE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVRqdEhFdlUxZ0k2UVhxWXBrTzFqb2hkM1pOWEpHS3BxSWt4U1FWTTRCM0JB?=
 =?utf-8?B?a25DSTNaQ2NHVm93Z1ZMK1MwMkhEdUFqTWNDQ1FBb3BXWWhuUDhvQmdZUll1?=
 =?utf-8?B?VUJKRkR4NmlraDg5WXdhem1HR0lJU2I2aUk5UkdDZU9yUXBlWjVDcDFNSjNH?=
 =?utf-8?B?amUybjl0WXRxOWNYYUtDYkxXd2F6QU1PRW1lUExWdWNkS0Z4eWVkYStQRTlY?=
 =?utf-8?B?YlM2U0p3ejkyMUQzQlA3K0M4UEJrck9neWw5Z2ltOHg3c2paYzkzZzJaNmkw?=
 =?utf-8?B?eGhWcllPY1hqRGtFMko4ODVBcEpTQXFTOEtJL0VmdWM5QUVsUmF0QjZrTDl5?=
 =?utf-8?B?MlEwekRKY3VkS2JXcWhGak1vVU40c09FWWlJM0dvUFBxQXFzblN2VFVRUnZs?=
 =?utf-8?B?TFB4MSsrQk53aU52NFdHcFIvajd6eUIveGZpYklYN0JFSm4vSDRMQ240andP?=
 =?utf-8?B?WXVlTjhYOC9IUEVVb2lxWUFGbXdEM3kvblJUUW9hOW1jdkQrUTFxdldYZ241?=
 =?utf-8?B?S05ObGlLcktTb2lpbVRqQXQ2TEczcy9seWExd09zVEpibk1aT1p6UzBuTDEw?=
 =?utf-8?B?OGhmY0U4YTdkNzRMdzMyUHRLaVErYU5mbFh5TkZpdVlyc3BQSGpIeTZSb09K?=
 =?utf-8?B?SWFoNlZBY2JpeWt2L1J5YjkxOTUyK0xUNlEvckNDY3ZxM2hyczBia2tWZndq?=
 =?utf-8?B?dU12OE01S2Z3TlNQOGFxZUQzQnRsMHNpd3VNdWZUZW95Z1ZlTE9hRXQ5ZnJy?=
 =?utf-8?B?eDIyZzZXdEJFYUphTEVIREpJZDFIY2t4UEFVRkVrK1pKVGhkWitLVmtpWW5v?=
 =?utf-8?B?amVHRm1Xb3RweUZPMFMrSDZkRHY4T3FtYVNSajI1enZpWVRYSVE0ZlhDQXFW?=
 =?utf-8?B?OEQ0Lzl2cjFaRmFRdGt1M3U4OFl0WUl4Q1FGUkdYcUhyYncxWnBDTy9pb3hM?=
 =?utf-8?B?Z2JTdHFCTmYyaXduV2FsbDlZTzBTbkEwdndvRS9RalNqM3JnN01HNkZFc1FC?=
 =?utf-8?B?UjNEYjFEd2NKTjVSSTJZYWNkaTczVkM5OXFLVTR3NlBqdEo4SzhYSWF2NjF1?=
 =?utf-8?B?MVI2aExHWUdYRllYdEZyc21ENFBvODgyM2o5dk84dmJ1anJ6SERmSGZ4eDRk?=
 =?utf-8?B?QjVrSVZwYzQzSDJsRnBYVUNPTzFKNG9rQ2NRZHJSSUlHWWNiRnQ4aExTL0V0?=
 =?utf-8?B?dCtESmRzNEdoaFdIMk9aRHFGRC9tU1RBdXJraVN3YlY4cjNXQzFSc0RPbkpR?=
 =?utf-8?B?TlBxZEV3d3NJOSs4dWo3dFNjUEs3bXp1YXdQYS9BZnU4WkwzaUVwOTFwS2Na?=
 =?utf-8?B?eGgxeTQ4OWxMeGV6aklVR21Lb2hFT3lqdnZMTGYwbHlWalRBM3ppYm1USENq?=
 =?utf-8?B?T1pERUxQQklYcndKMTdya3JMSFlXWGdoTnFPVzhOWURnalVNbEk5QmdSMGJj?=
 =?utf-8?B?b1NlT1Z3eDBlb0tDNFNsMk9yWkJieE9PQU9HVHk5UmJiWVBhY2pVNEx1c3VL?=
 =?utf-8?B?aTFBNElldXM5Nmt0dnIyVnRTTUFWUjF4c052UVJRVU0vZUNqdURkWmhXN1dF?=
 =?utf-8?B?NWxBby9iaG1QeS9tL3lxYUE4aEV0eENlQ0JjVitjU3h6ZFpDaWxBczN2OGha?=
 =?utf-8?B?ekFuY0ZsUnRxYUpVTUxuMkQvMXRtTzFiL2pGMXVxVERLa0VNNFZHQWhkTHdy?=
 =?utf-8?B?cC9RRlJPZjd2cWx4dllDb2xRU0QzZzNiVkpLVkg0T3RVRXlDekhRcnZVb0J4?=
 =?utf-8?B?WWJXYmdzZ0V0cTY5ak1CL2YyZlQzVkg3cXd3bTlKY1pmWldsbjlyWmh5amFL?=
 =?utf-8?B?am01K2VBb2ozVzU3MlJhaEUyNEI5MUZkOEJEK0JBbE9hTDI1bVJjMnBjK3Jz?=
 =?utf-8?B?OEpTNk5rcEQ3c01Lc1NlUXJubHNyMGMzaXI4TVdMc2tlZXl3Rlp1VFRYSXRZ?=
 =?utf-8?B?eXF3QWY0WWhka2RSOTd5aHJCNmVSc2YzbWUxRlNGeWRMMHc2VTkvRE5IcGZr?=
 =?utf-8?B?N0VPV29PS3RIOWZNR3lzeVlDYU00dmEzL0llVWMwLzUrYU9HSlhiTU9FanU0?=
 =?utf-8?B?VnFjRHByQlo0SmtRNGx3M1RpZEM0cndoaG80WnYyMVJZbXM4RkhUMlBNVGt2?=
 =?utf-8?B?eUhZMzcxQnBQcE16VDIzOUc2T0tzMnlESVdsOG1xMmVXd0U0QVE1OWJta1Vr?=
 =?utf-8?B?c2VSazFqaTNsaXlkemI5QWZHeDBVdk41dU1mVUtHQlpnZnlSRnZ1UDhMNVBB?=
 =?utf-8?B?UGZVWitaOUdxRGhuUHpPNWppcTZUdTMyaHJqb3gwUkZxWnI0bmd4ejJqY0pz?=
 =?utf-8?B?TWdmSHhhVUtGczlhSHlITHR4N05WMlVMa1pYTmpZL2tUc0FQdDZnZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0361a19-898d-4170-bb0f-08de5e827401
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 15:32:32.1807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0EKBijCQnPM/CMOdomVWH3rW1dhdVPP51AgndhWtErkMVCKdOgaIIXUJFYaz1d9lt/JwghdiDXMJsn9i6HyrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=avihaih@nvidia.com;
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


On 1/28/2026 4:49 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, Jan 28, 2026 at 12:03:46PM +0100, Cédric Le Goater wrote:
>> +Peter, + Fabiano
> Thanks, looks benign to me from migration POV. I have one question though,
> and not sure if I'm the only one wondering..
>
>> On 1/28/26 11:51, Avihai Horon wrote:
>>> Currently, VFIO device migration event is sent after the device state
>>> transition has been completed. However, it may be useful to additionally
>>> send a "prepare" event before the state transition, to notify users that
>>> it's about to happen.
>>>
>>> For example, in some cases with heavy resource utilization, stopping the
>>> VFIO device may take a long time. In time-sensitive scenarios, the
>>> management application that consumes the event may be notified about the
>>> state transition too late.
> Could there be more elaborations on the problem?

Of course.

>    For example:
>
> (1) What would the mgmt do when receiving the notification?  What would go
>      wrong if the state notification will be very late?

In our case, upon receiving an event that the VFIO device is stopped 
(during migration switchover), the mgmt app prevents timeout of RDMA 
connections to the migrated VFIO device.
This is needed because RDMA connections may have very low timeout, even 
a few tens of ms, which is far below the migration downtime we have.

As I wrote in the commit message, if the VFIO device has a lot of 
resources it may take long time (even a few hundreds of ms) to stop it 
and in that case, by the time the event is sent (after the state 
transition), the RDMA connection can already timeout.
This is an issue we actually experienced.

>
> (2) Why would a prepare message help this situation?

Sending the event before the state transition will allow the mgmt app to 
act on time, regardless of how long the VFIO state transition takes.

>
> (3) Doc below says, the prepare message does not imply the event will be
>      guaranteed to happen.  Would it confuse the mgmt?

The expectation is for the mgmt app to be robust and handle these kind 
of scenarios.

Hope that clarifies the use case/need.

Thanks.

>
> Thanks,
>
>>> To overcome this issue, send an additional "prepare" migration event
>>> before the device state transition.
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> ---
>>>    qapi/vfio.json      | 33 +++++++++++++++++++++++++++++++++
>>>    hw/vfio/migration.c | 18 +++++++++++++-----
>>>    2 files changed, 46 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/qapi/vfio.json b/qapi/vfio.json
>>> index a1a9c5b673..de41211f1d 100644
>>> --- a/qapi/vfio.json
>>> +++ b/qapi/vfio.json
>>> @@ -66,3 +66,36 @@
>>>          'qom-path': 'str',
>>>          'device-state': 'QapiVfioMigrationState'
>>>      } }
>>> +
>>> +##
>>> +# @VFIO_MIGRATION_PREPARE:
>>> +#
>>> +# This event is emitted when a VFIO device migration state is about to
>>> +# be changed.  Note that even if this event is received for state X,
>>> +# the VFIO device may transition to a different state if the original
>>> +# state transition to X failed.
>>> +#
>>> +# @device-id: The device's id, if it has one.
>>> +#
>>> +# @qom-path: The device's QOM path.
>>> +#
>>> +# @device-state: The new device migration state that is about to be
>>> +#     changed.
>>> +#
>>> +# Since: 11.0
>>> +#
>>> +# .. qmp-example::
>>> +#
>>> +#     <- { "timestamp": { "seconds": 1713771323, "microseconds": 212268 },
>>> +#          "event": "VFIO_MIGRATION_PREPARE",
>>> +#          "data": {
>>> +#              "device-id": "vfio_dev1",
>>> +#              "qom-path": "/machine/peripheral/vfio_dev1",
>>> +#              "device-state": "stop" } }
>>> +##
>>> +{ 'event': 'VFIO_MIGRATION_PREPARE',
>>> +  'data': {
>>> +      'device-id': 'str',
>>> +      'qom-path': 'str',
>>> +      'device-state': 'QapiVfioMigrationState'
>>> +  } }
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index b4695030c7..9f887c148f 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -90,9 +90,11 @@ mig_state_to_qapi_state(enum vfio_device_mig_state state)
>>>        }
>>>    }
>>> -static void vfio_migration_send_event(VFIODevice *vbasedev)
>>> +static void vfio_migration_send_event(VFIODevice *vbasedev,
>>> +                                      enum vfio_device_mig_state state,
>>> +                                      bool prep)
>>>    {
>>> -    VFIOMigration *migration = vbasedev->migration;
>>> +    QapiVfioMigrationState qapi_state;
>>>        DeviceState *dev = vbasedev->dev;
>>>        g_autofree char *qom_path = NULL;
>>>        Object *obj;
>>> @@ -105,9 +107,13 @@ static void vfio_migration_send_event(VFIODevice *vbasedev)
>>>        obj = vbasedev->ops->vfio_get_object(vbasedev);
>>>        g_assert(obj);
>>>        qom_path = object_get_canonical_path(obj);
>>> +    qapi_state = mig_state_to_qapi_state(state);
>>> -    qapi_event_send_vfio_migration(
>>> -        dev->id, qom_path, mig_state_to_qapi_state(migration->device_state));
>>> +    if (prep) {
>>> +        qapi_event_send_vfio_migration_prepare(dev->id, qom_path, qapi_state);
>>> +    } else {
>>> +        qapi_event_send_vfio_migration(dev->id, qom_path, qapi_state);
>>> +    }
>>>    }
>>>    static void vfio_migration_set_device_state(VFIODevice *vbasedev,
>>> @@ -119,7 +125,7 @@ static void vfio_migration_set_device_state(VFIODevice *vbasedev,
>>>                                              mig_state_to_str(state));
>>>        migration->device_state = state;
>>> -    vfio_migration_send_event(vbasedev);
>>> +    vfio_migration_send_event(vbasedev, state, false);
>>>    }
>>>    int vfio_migration_set_state(VFIODevice *vbasedev,
>>> @@ -146,6 +152,8 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
>>>            return 0;
>>>        }
>>> +    vfio_migration_send_event(vbasedev, new_state, true);
>>> +
>>>        feature->argsz = sizeof(buf);
>>>        feature->flags =
>>>            VFIO_DEVICE_FEATURE_SET | VFIO_DEVICE_FEATURE_MIG_DEVICE_STATE;
> --
> Peter Xu
>

