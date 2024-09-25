Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B997CCF9E7
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 17:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stVzz-0000cT-GE; Wed, 25 Sep 2024 13:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1stVzx-0000Zn-Is; Wed, 25 Sep 2024 13:40:21 -0400
Received: from mail-bn8nam11on20716.outbound.protection.outlook.com
 ([2a01:111:f403:2414::716]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gankulkarni@os.amperecomputing.com>)
 id 1stVzv-0004Sq-CP; Wed, 25 Sep 2024 13:40:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaKQcJ1MOPWOIyzbSiEO1QEz56zCN1UEcOi3t/rV+o3UI5YPvaggO/fe0nXK0tWSdMo8XExv2F7gpvu35prI0bxFw0EKPUlZfPyVG8GZRNVHvEpTYjXNGR3Et99Zkr3bC9Ls0MzuMFAG1pjt6/ZatBy0PFZMzfNcHbg1eP4cPaF6q+3I/sGM9Iw0rfTtnh3pieIMEjyZhUe3cMzldQt2l8pk4G7tgVrrA842P89qdpV+Wb0xWz5Tv59+/VS0ZGwHW7zNbV97iiRm/g4FhpoesYsHlRR835MT8u4eJjD3UUjhf3sB9kCCxzXu+1ZVTG/9rikWJ7MZa9fZHVT+I0/3lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2AbhvZM8d6htChmoCzWk93KGDCF6lFEBnnSgZSXwfs=;
 b=Od+4h6X9RpyywFlO2xgvJe3mQcjhsZ0RvAjL8ulGg+TLQDmXETsFLD2sZHm9qkUMjPFWkcjmKvv12QFQomWqwCVGYkri4T1tJOiN2bgL/y4Uljvd2V0Dm1rbS8B/95q/IZOe4sCIakxAGW18gzyE+UeqeyKueAJyjqvcy7UYk16C+AVaebb8xpBhxqN1Iyzm9L4o57q7YqlYTU1IFH6GyESqRSRgXeR42GYe1E26k3CjvOxfJOQ11yTWiuj85nnHHFsirp8g0SgdDjnnxVzf0CtYev/YWdr4LgEin7OPn8vW7W7iYwgXBMPGAaG5ZU5vWeFAWE0DQQvNbaVfZFsx+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2AbhvZM8d6htChmoCzWk93KGDCF6lFEBnnSgZSXwfs=;
 b=fiDSJdltlKH73KUjoBYJBjnsfwA9ClvAIZK7cxXor1pm6V79WYVuJAxGLfmfzGTH9oN+CV14lI+W1f+GaNlLiBaYu2GpbDVZxe88xKdRQh8oyXTypg9GYQcNyW+DfwngihTylGcG+gWuU9NV1fBSoKeXxV9ndsgu8vJYO4ma6JU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SN7PR01MB8116.prod.exchangelabs.com (2603:10b6:806:357::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.25; Wed, 25 Sep 2024 17:40:13 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 17:40:13 +0000
Message-ID: <29815c60-a246-4be3-9685-4d192efcf037@os.amperecomputing.com>
Date: Wed, 25 Sep 2024 23:10:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] arm/kvm: add support for MTE
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, cohuck@redhat.com, darren@os.amperecomputing.com
References: <20240920073725.410373-1-gankulkarni@os.amperecomputing.com>
 <4b1a7f9b-4a69-4c0a-93be-4ecd27b08196@linaro.org>
Content-Language: en-US
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <4b1a7f9b-4a69-4c0a-93be-4ecd27b08196@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0087.apcprd01.prod.exchangelabs.com
 (2603:1096:820:2::27) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SN7PR01MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fd8077f-06ac-4da9-f7b1-08dcdd891be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGp0SUwvN0p4VjEwTk1SaTRhUWt6eXd3R21CN05RQlJEcHNuOWRUU0p1MnpI?=
 =?utf-8?B?Rmg2emZxSFFldEFzOXZKOU1QNmExb3pTWEZWd0NpNk9BZkxqYjltZDJ6blNo?=
 =?utf-8?B?cmVHMmgxTnhMemZ3UWovKzN0VUxnMkFseTdhTEhnZTJHMU5lNWswNzZyWWsv?=
 =?utf-8?B?WnNkTDFPeGROOUxZSFdjb2RZOC9pNUJLZWRLeTRURDFkMGd1NkUzeEF0UElK?=
 =?utf-8?B?UTRCMm5lSGs3bk5YNUc0TDNZSEd3d2NYUitVdHpWeXZGQTdPaTNCb3ZocWx2?=
 =?utf-8?B?MG9OUlBXTzlOdmVlT0ZSdm8xcGE2bGRsVjF6ZHV5NTNnaEtHWG5Ib1dGQ3dI?=
 =?utf-8?B?NWROSkFINUx3OTV0ckloL1ZmUVEzUDNoazZGbzllUVhmb1luSW1ZNW90T05m?=
 =?utf-8?B?QStTeWFjYnpuOTE5WXVmaVIwOWppSVEvampHK3AzL3RSR0VycExtaUt1aXp3?=
 =?utf-8?B?eStra2ZmTnRDNFZkSEV0RUdWSFl4a0Q2U1dJcnluRzBCdW1ZQ2tSYmI1TVl3?=
 =?utf-8?B?R3JnaU9OYjMzeGgwVTdJZG40WGcwQ1dLNG0waG8vWE5qYUFmc1gxZ0JCN2tR?=
 =?utf-8?B?NmpEdUVXbWFTRWZHWXdTcU1xVEhJTnVkVzFaNjRDajFrQ3YwMXVvVkQvTHFq?=
 =?utf-8?B?VlRrRi9iN0dUZFhHWmY2aEEyVnFIOThHREdlLzBvUGFyUkZCRUwvNUJrUWN6?=
 =?utf-8?B?NHloN0MzOHFwdiszV0FkNjRNYngyR25lNEpFL0d5SkZwblpmUTVrWG84NkU1?=
 =?utf-8?B?WEpxK1hpMWNaMGpFc1FVcTMvQS9aRDVuVXROV3Evenk4NVhuMVJpNE9RdXZl?=
 =?utf-8?B?TU5Fdmh3TnJTY3hpV3Zra1ZVYk5WaTRQbmtOVmdPd3VJc29Fb3h6WE1TM1hL?=
 =?utf-8?B?K3FOcytMa0llS0tzYTZPRXhRTDlXdUVJa2ExS0h6YU9BVWFDZ1ZpR3JIM3Fk?=
 =?utf-8?B?ejQxQlM3TjNVL0Vyb0xRWmx0UWVnOGFaZXNibVJ3L0d1Ny9tbXpYNEJDWERq?=
 =?utf-8?B?VkRJd0g3Qkp5Tll3MW14bExSRXlLV3ZEdmxoNCtFM2hqYytMcllIVFBYRUcz?=
 =?utf-8?B?L1A0NWxjZlZONTJHUDdnTjZtRHlEWlRCQTJoOFNVL0dRQ3R0dFZUeENYSGNK?=
 =?utf-8?B?OEM0ZmV2NHhVa0FqeDBFWlNrc3JLaE1PdThZWlgyWFFub3pZemxGUzR2UzVo?=
 =?utf-8?B?RUdlTDE5aE5xdE5oMi9BdG04UTc2REpOOHk0OG5rK1NVTmROZ0grSWJhTEVo?=
 =?utf-8?B?c051T0NEZUsrd1V5Zm1zMEVqMlp5empJRGJZVVBXajFtWkdwLzNsL1c4V0Jj?=
 =?utf-8?B?azNkNGNwb3psRjhTa3EvWnNZSVErQ2hqWDl4OUdpN0YveW83aFdrekN5amRt?=
 =?utf-8?B?djRNcGlGOHAyQlFSVmU1YzFXTEVLR3gyc1ZMeFNiQjBabzNsanFjdVRrUXJ1?=
 =?utf-8?B?YmlOS3ZlR1VoMlhWOHdqVjVnT05yakQxY3BjQ3R6ZzVNM05JR0NFQzVrZmNx?=
 =?utf-8?B?Q2o4NVZsYUlHZzM0bnl6SW5IMHZOV0xsZ2I0MENXNTFBMWs2cEltS1FTcExL?=
 =?utf-8?B?ek9LSUNxSDBsSmJOcGZZbHRRSEN4Y2wyN2hQT2o0eE1NOVBicUM4NG9QZkVY?=
 =?utf-8?B?eTV0R0R4OVJMS0puYXBrZGJEdy8wQnJ6dHVkazNzVmVnSitWOHlwNFVCRHdh?=
 =?utf-8?B?OEd6TXZwQklma3BQYUtWMklzZWVSaHdOMkErbElCZDVyWTFWaURyaVN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR01MB8101.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVkzcUlLNFZxakxocGQyejRhbFJ4NlFSQ3ZkVFpPQ3hNN0tway9VTmt1cUFz?=
 =?utf-8?B?ZDNNdHcwanNHVld0dUJBVHRrU1NYNytSeVZoL2VSU1FnM09kUjBYcFBReWxY?=
 =?utf-8?B?N3J1WjJJUEV1WHowTU1sVmtlU0xQSUVYWGJLS3UwR1hEU0t3cVk5YjRwWklL?=
 =?utf-8?B?Z3hEb08vcVZ0UWFzdE5TNGV0TnZybm8zQ21IUFJwOFpiRlJaZDhNaU9xRU8w?=
 =?utf-8?B?SmJTaUJoMStrdTFweTlXRjJqL3Z4SDVOdlk1ZmpHMWpEMWVGTWJSSDU5TlpS?=
 =?utf-8?B?WVhrZjlKa2hjQjhRM3pPd1BmeDVzUWV3MXpIVGhxczhxM3MxUWtCSHNTU1Yx?=
 =?utf-8?B?VmY5M0loOHVWeXBpMWlUNFUvYW1pUlFEZ2pzRFdqY05JUUs4WmlNVklYeEtL?=
 =?utf-8?B?aFRaRDdGZGhQamI4NnpaZ2Jsbkc3SmlNbGI3SkFIaGRVSmtOamlvcEU4RUNL?=
 =?utf-8?B?VElqYjlPNFNTSVBoNUVzR1BSb1RNM2VnRThkRGJYMFRnWTQwZjNmUW9IZFJp?=
 =?utf-8?B?azVGTE95UmRVSCtQbXJPcGJ0Vmtac2ZXSkNrT2w1OHRkSmo1UlV2c094YXRI?=
 =?utf-8?B?K0toSGpnMGxKNnpVa1BtSGZIdlhhSUpqemMvM0JobVM5ZW16QklwakpzbVh0?=
 =?utf-8?B?dUgrZ2xyTXh5cURDN2xUbm9XeVMwWlZiakNTRFhqemNzOFBvM3A4VkVzM1l1?=
 =?utf-8?B?NWIvcmVsNWhmMWJMdHFSNmNNSXYzSFM5dVgxN2dRY3NEbEhuN3ArV2o3VFJ0?=
 =?utf-8?B?eXpteFhWYjNGbVZoVWhzc0Y3bkMyemxxV2wwZGlHTU1qYzYxV0ZWYnByaTBx?=
 =?utf-8?B?bVI5YU9wTGZsVEI3VUhSdVJKWmtzeEpNUG84ZXZzMEVWTURWOGpLK0VYaHFX?=
 =?utf-8?B?MGhGbHpGK0xUYkNiRmFqSEZLVHBNNWZucmxxbUloWDJMZXQvOVJLajBKN3RD?=
 =?utf-8?B?T2dXa0c4dHNuK1VLa2pzSHRycGVuY2xKd0QreVA5WE5wYnVmUmo5Q3ZMMmxL?=
 =?utf-8?B?ck15WEZQQ2RydzBSUlREWWovQyt3SHF2blBPTVVOei9KdEJvSFdGV0Q5RGp6?=
 =?utf-8?B?MzRTSTUrYWxKU2o1NWV3cElyQjZyWUN3K3RSdE5zdzBhV1VFUy91NitVYlVp?=
 =?utf-8?B?TVB1NWVkYk0rYnRsMWF2M1o2OXRkUm94cTh3enBXRGhrNXhJVlJ0YllSdVFH?=
 =?utf-8?B?Q2FSKzczYm9BNTlOWUoyYldlSloxME1ud3BjZ1dUcVZ3QWJGTGdxTzlZQnFY?=
 =?utf-8?B?TW5CSlkzVkw0SitQSGJWTmRKSFJHNGJuY1B6ZmFwT0lpd2h1L1FQSHh4RmYz?=
 =?utf-8?B?YnRvZVcxZmRwU1dkdFZITFpRUGxoNWZ5SUVOQ2xWbzNsbk9aZEtqNVpnM1hz?=
 =?utf-8?B?czZzZDV4dVhWZWJxMUN1MjgzcFZkbVk2QWpEeEMrcHZadXpBb0JwaUowVkVw?=
 =?utf-8?B?NGJWc1BxWkFxZnN0U3VxM2NDVE9ldWltU21DY1J2YmFlcWphLzNYcjNJeXpO?=
 =?utf-8?B?LzhiY3ZBVDFwWnhsakJUaWpGRGNTdFhNeHk3N04veGJTcUV2d09UeEdGRGRq?=
 =?utf-8?B?azMvT0ppamt3ODI2dEYwNERkRTdtek1Zb0M0OFdPWDkxWjAxUWcxQjMxMzdu?=
 =?utf-8?B?aXhLdVgxL0lZYi9vUmQzV2hQb2QwY1dhbXkxcDYwQytUdUJGU1Bmd01aelBz?=
 =?utf-8?B?YUQ5c3k3ZTRkMGVuVEZjcEdoUEJOVm40bGFqd0o3K1hDVUN1a1dHZ05ZQldP?=
 =?utf-8?B?WjdSVDRtOVBJdzM3aFdxRVJRUEhYZW5VSzBnWDVabVRraGhwc3NGUVlEWnhm?=
 =?utf-8?B?NnNJM295L2hZMUdZQk9mcGhPcldaQXYzMmJXaTNIdUdrWnVBVXVXdHNrWFZy?=
 =?utf-8?B?VDFyZVNIMityYVpHamhsM0lkRHpmODRyTDVET29YWkNYZmllRGVHMUl2TXBV?=
 =?utf-8?B?cjFtMUM4Z24xL3FYWkJxK1ZEQ2dwVnBYVk1sSFZwdFpwR0hSWWlNZ1RXL1ZT?=
 =?utf-8?B?TUg5cjNLZFJCWWlWQmFMcGxxNW43b2dPbVRaQUN0MGVxWWd0Qm5SdVEraGNm?=
 =?utf-8?B?TnRhemNjcWZZNkx6aU1WSmtDeUptOTVtWTh4Zk5uSVhUMU1paTBvTmEvOVpi?=
 =?utf-8?B?MFNjUXNnREUwRlNwcXZFR0NMdnBFaXJERG1BaG9RQzMvUnZJUk93OFk1SXNK?=
 =?utf-8?Q?9FORxn9eW1izU9DDyiDCHiM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fd8077f-06ac-4da9-f7b1-08dcdd891be4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 17:40:12.9086 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yk2m0epgtiBV1jmpImwNKCu03Jw0MWMxTyKlKhAaVNeSOSKJZOqFdIzsJat3MG3uEDE0VuvohAKMYJmh+fRWKIPK/YTGX+Wdfrc35ljszP8RFfIloRimiUyhlC72n06Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB8116
Received-SPF: pass client-ip=2a01:111:f403:2414::716;
 envelope-from=gankulkarni@os.amperecomputing.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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


Hi Gustavo,

On 25-09-2024 09:17 pm, Gustavo Romero wrote:
> Hi Ganapatrao,
> 
> Sorry for the delay on replying it. I was attending KVM Forum and 
> commuting.
> 
> On 9/20/24 09:37, Ganapatrao Kulkarni wrote:
>> Extend the 'mte' property for the virt machine to cover KVM as
>> well. For KVM, we don't allocate tag memory, but instead enable
>> the capability.
>>
>> If MTE has been enabled, we need to disable migration, as we do not
>> yet have a way to migrate the tags as well. Therefore, MTE will stay
>> off with KVM unless requested explicitly.
>>
>> This patch is rework of commit b320e21c48ce64853904bea6631c0158cc2ef227
>> which broke TCG since it made the TCG -cpu max
>> report the presence of MTE to the guest even if the board hadn't
>> enabled MTE by wiring up the tag RAM. This meant that if the guest
>> then tried to use MTE QEMU would segfault accessing the
>> non-existent tag RAM.
>>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>> ---
>>
>> Changes since V2:
>>     Updated with review comments.
>>
>> Changes since V1:
>>     Added code to enable MTE before reading register
>> id_aa64pfr1 (unmasked MTE bits).
>>
>> This patch is boot tested on ARM64 with KVM and on X86 with TCG for 
>> mte=on
>> and default case(i.e, no mte).
>>
>>   hw/arm/virt.c        | 72 ++++++++++++++++++++++++++------------------
>>   target/arm/cpu.c     | 11 +++++--
>>   target/arm/cpu.h     |  2 ++
>>   target/arm/kvm.c     | 57 +++++++++++++++++++++++++++++++++++
>>   target/arm/kvm_arm.h | 19 ++++++++++++
>>   5 files changed, 129 insertions(+), 32 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 7934b23651..a33af7d996 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -2211,7 +2211,7 @@ static void machvirt_init(MachineState *machine)
>>           exit(1);
>>       }
>> -    if (vms->mte && (kvm_enabled() || hvf_enabled())) {
>> +    if (vms->mte && hvf_enabled()) {
>>           error_report("mach-virt: %s does not support providing "
>>                        "MTE to the guest CPU",
>>                        current_accel_name());
>> @@ -2281,39 +2281,51 @@ static void machvirt_init(MachineState *machine)
>>           }
>>           if (vms->mte) {
>> -            /* Create the memory region only once, but link to all 
>> cpus. */
>> -            if (!tag_sysmem) {
>> -                /*
>> -                 * The property exists only if MemTag is supported.
>> -                 * If it is, we must allocate the ram to back that up.
>> -                 */
>> -                if (!object_property_find(cpuobj, "tag-memory")) {
>> -                    error_report("MTE requested, but not supported "
>> -                                 "by the guest CPU");
>> -                    exit(1);
>> +            if (tcg_enabled()) {
>> +                /* Create the memory region only once, but link to 
>> all cpus. */
>> +                if (!tag_sysmem) {
>> +                    /*
>> +                     * The property exists only if MemTag is supported.
>> +                     * If it is, we must allocate the ram to back 
>> that up.
>> +                     */
>> +                    if (!object_property_find(cpuobj, "tag-memory")) {
>> +                        error_report("MTE requested, but not supported "
>> +                                     "by the guest CPU");
>> +                        exit(1);
>> +                    }
>> +
>> +                    tag_sysmem = g_new(MemoryRegion, 1);
>> +                    memory_region_init(tag_sysmem, OBJECT(machine),
>> +                                       "tag-memory", UINT64_MAX / 32);
>> +
>> +                    if (vms->secure) {
>> +                        secure_tag_sysmem = g_new(MemoryRegion, 1);
>> +                        memory_region_init(secure_tag_sysmem, 
>> OBJECT(machine),
>> +                                           "secure-tag-memory",
>> +                                           UINT64_MAX / 32);
>> +
>> +                        /* As with ram, secure-tag takes precedence 
>> over tag. */
>> +                        
>> memory_region_add_subregion_overlap(secure_tag_sysmem,
>> +                                                            0, 
>> tag_sysmem, -1);
>> +                    }
>>                   }
>> -                tag_sysmem = g_new(MemoryRegion, 1);
>> -                memory_region_init(tag_sysmem, OBJECT(machine),
>> -                                   "tag-memory", UINT64_MAX / 32);
>> -
>> +                object_property_set_link(cpuobj, "tag-memory",
>> +                                         OBJECT(tag_sysmem), 
>> &error_abort);
>>                   if (vms->secure) {
>> -                    secure_tag_sysmem = g_new(MemoryRegion, 1);
>> -                    memory_region_init(secure_tag_sysmem, 
>> OBJECT(machine),
>> -                                       "secure-tag-memory", 
>> UINT64_MAX / 32);
>> -
>> -                    /* As with ram, secure-tag takes precedence over 
>> tag.  */
>> -                    
>> memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
>> -                                                        tag_sysmem, -1);
>> +                    object_property_set_link(cpuobj, 
>> "secure-tag-memory",
>> +                                             OBJECT(secure_tag_sysmem),
>> +                                             &error_abort);
>>                   }
>> -            }
>> -
>> -            object_property_set_link(cpuobj, "tag-memory", 
>> OBJECT(tag_sysmem),
>> -                                     &error_abort);
>> -            if (vms->secure) {
>> -                object_property_set_link(cpuobj, "secure-tag-memory",
>> -                                         OBJECT(secure_tag_sysmem),
>> -                                         &error_abort);
>> +            } else if (kvm_enabled()) {
>> +                if (!kvm_arm_mte_supported()) {
>> +                    error_report("MTE requested, but not supported by 
>> KVM");
>> +                    exit(1);
>> +                }
>> +                kvm_arm_enable_mte(cpuobj, &error_abort);
>> +            } else {
>> +                    error_report("MTE requested, but not supported ");
>> +                    exit(1);
>>               }
>>           }
>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>> index 19191c2391..8a2fc471ce 100644
>> --- a/target/arm/cpu.c
>> +++ b/target/arm/cpu.c
>> @@ -2390,14 +2390,21 @@ static void arm_cpu_realizefn(DeviceState 
>> *dev, Error **errp)
>>   #ifndef CONFIG_USER_ONLY
>>           /*
>> -         * If we do not have tag-memory provided by the machine,
>> +         * If we do not have tag-memory provided by the TCG,
>>            * reduce MTE support to instructions enabled at EL0.
>>            * This matches Cortex-A710 BROADCASTMTE input being LOW.
>>            */
>> -        if (cpu->tag_memory == NULL) {
>> +        if (tcg_enabled() && cpu->tag_memory == NULL) {
>>               cpu->isar.id_aa64pfr1 =
>>                   FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
>>           }
>> +
>> +        /*
>> +         * Clear MTE bits, if not enabled in KVM mode.
>> +         */
>> +        if (kvm_enabled() && !cpu->kvm_mte) {
>> +                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
>> +        }
> 
> I 've discussed a bit with Richard about the need of setting the MTE 
> field here
> 
> to 0. This is already a reduction since it's inside the condition block:
> 
> if (cpu_isar_feature(aa64_mte, cpu)) { ... }, which is only taken if we 
> already
> 
> have MTE field >= 1. At this point the MTE bits in cpu->isar.id_aa64pfr1 
> should
> 
> already be set correctly accordingly to the host bits since 
> kvm_arm_get_host_cpu_features()
> 
> was called.
> 
> 
> The check for TCG (cpu->tag_memory == NULL) exists because even if MTE 
> instructions
> 
> are supported by the CPU it's possible that the machine's memory does 
> not support tags,
> 
> but we don't check for that in KVM afaics.
> 
> 
> For KVM, isn't the cpu->isar.id_aa64pfr1 MTE bits already correct here 
> so we don't need to touch them?

id_aa64pfr1.MTE bits are masked/zero when we read without enabling the 
MTE(KVM_CAP_ARM_MTE). Hence to read the real value we are enabling MTE 
while reading the register.

Later, If user is not passed argument "mte=on", we want to revert the 
value that is read with MTE enabled since we are enabling MTE on actual 
VM  only if "mte=on".

Are you saying, let us have the MTE enabled for KVM by default and 
disable only if user passes mte=off?.

> 
> cpu->kvm_mte is false here only if kvm_check_extension(kvm_state, 
> KVM_CAP_ARM_MTE) is true but
> 
> kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_MTE, 0) is false -- can that 
> happen ever happen? _or_ when

This can be, if hardware is not supporting it.
Since user is trying to enable with mte=on but hardware is not capable, 
in that case qemu aborts with error message.

> 
> we can't block migration? So basically we are telling to the guest that 
> MTE is not supported if we have
> 
> MTE supported in the host _but_ we can't block migration?
> 
> 
> 
> Cheers,
> 
> Gustavo
> 

-- 
Thanks,
Ganapat/GK

