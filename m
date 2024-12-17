Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2A2E7716A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 09:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNTvk-0003Zg-CH; Tue, 17 Dec 2024 04:31:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNTvf-0003Z3-UZ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:31:48 -0500
Received: from mail-co1nam11on20627.outbound.protection.outlook.com
 ([2a01:111:f403:2416::627]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNTvd-0005oy-F2
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 04:31:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrGVic4yH6BiewPOeZ085CZEDKjwDOgekVG4SWheynXoX9S1/XTPNE3qB1hQx7jYuOCczuAcNZC7TMna1HbqmRvS/1d9gUYne5AqVuJ72URnDmTWs8QGJCU9UZ7CNkYEC0I+swDJD/2iYUMzcLl4uYBSW7VRxH8T7NYY53LpXLldD5QC0uGchLqgmBGJL4GwXT85dbEwNHO3O8LhMpIMfT0f/ouadt+SunI5RbRR1lIFMHAsTJ7pMaBue1k/77Svq6QPY8DtkrFpdQjHVhFJMBTTZ8NU4v2aIAD2TNTWIk9QMNsdSfyu5ZKcq+Dk+6ByEsFksq+RhZGrKYXGv9v9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYG5wULttLEDQEUMWkNo6UUGUlV7qhzAwWaqucgTXHc=;
 b=vdoaAlrq3AN+qb2QDjeWXNVm+BpjJ9QMNOxM9FdJ8ENM4I8g5Y7IiUsFm2wXCoaXVo2uehIGub0xuknoBiCIAKyT4yGlXZm9nMlorSi7ZcwyhUjGzccFCP0sx9fOfw/GgVnzVbbr2VKHJSGy7d6wvjRHOe/7UOpekXaq3O0vyIpsMzHV1AdePDyXM1wElIwotMn2/vxhyC+gMdmKhZxH6gmSHmiEcR6PXu2rYbg06XXz/JubfUGZvgxzKaYHtKON/EfWj6DKTsbt3PT44odOhtS1PnFIA7U47w4OXbKwx+Z7GLHeG7XH9oNFnHv8nvpQcGHVxyKrjXr/trX//U9dbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYG5wULttLEDQEUMWkNo6UUGUlV7qhzAwWaqucgTXHc=;
 b=MCSLrcvo1R0WlkiXsY2se3n9aKT6GV37O7aLBSOUysq3CupHHe+z9cJyxWFTA1wOAGzoMJ0ynoxPcaesn21dKhELcgV8IYFRvbhY2s9Wm5cuAep6mqJXhWPNOu0mHbcJZxXITfcXIiFub7gQTekECXzxJzQPJ17CfbpvMQ1Xjhb11577dmZ3D3krKpMkyVtBbwxffXoadfJPm0kQ3DsrccVt5/+ag6A65+WLLNT/L13xvkXhlxlpYugb+vUGMTaVxq9b0aB8fbaNR21rCCcGPaUCoQ2TmfGxNJx65fc/bw7U3PGFr0Gd158fIuCsNHZES5bCFNJ6u4FmdRRIoyxHIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB5544.namprd12.prod.outlook.com (2603:10b6:a03:1d9::22)
 by IA0PR12MB8747.namprd12.prod.outlook.com (2603:10b6:208:48b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Tue, 17 Dec
 2024 09:31:34 +0000
Received: from BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d]) by BY5PR12MB5544.namprd12.prod.outlook.com
 ([fe80::1a4a:10e9:d53c:d25d%4]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 09:31:34 +0000
Message-ID: <85cba40d-59c5-4fc4-b183-58c499e98913@nvidia.com>
Date: Tue, 17 Dec 2024 11:31:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] vfio/migration: Refactor
 vfio_devices_all_dirty_tracking() logic
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-3-avihaih@nvidia.com>
 <7fdc0511-7a31-4e75-a873-c4c67edbc08b@oracle.com>
 <50e6d3f8-0642-4a6c-b6fe-21a68ebe9d39@nvidia.com>
 <9d594215-307e-4014-8df6-6e019999a7fe@oracle.com>
 <b6aef9a0-60e8-4b7f-9a42-9a0cc024b0c7@oracle.com>
 <c73e395d-d32e-4ca8-b94e-98203a77e664@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <c73e395d-d32e-4ca8-b94e-98203a77e664@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::14) To BY5PR12MB5544.namprd12.prod.outlook.com
 (2603:10b6:a03:1d9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB5544:EE_|IA0PR12MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: b64dd1e7-a279-49f6-ffe8-08dd1e7d98e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NllnVU1RSThhS29zU2Z2ZlBEYitCRi9kaXg3Z3VXVWczenZRSHd4NHk1Rzlo?=
 =?utf-8?B?dlNDckJKekFWaUNPWjFNd29ZemlFelYyaUpCdzNPdjBQZHVzakhjT21kQTZl?=
 =?utf-8?B?SVlqdkhtcDZHZm1YM0dlUEF5Uyt4M0JSUUQ3WTE0WU5TYWF4am41aHBZZWVu?=
 =?utf-8?B?NHRqLytKelVXcUZ2ZXh3eFlKS1ZsUnZNYjB1d2VUUXNRL2xPQUgxSVkyMG5U?=
 =?utf-8?B?blB3djE1RDFGMUYxTjNJSlFLVis0RmJxQmZkeDdsSC90NG5hSmlpVVVuaUQ3?=
 =?utf-8?B?MGZleUJjYnQzazI5cVQ4WnZOQ01zelY3VGNidUd5RkV0YUgzR1hRTHJyMVY2?=
 =?utf-8?B?VjlBME9NUDJOdFZGK09TaFZoRTg3TnFFc280d1U5THFnTjlYcU9FNDJLWUor?=
 =?utf-8?B?ZHNNRXFvSjNrSmM1RHY4Uk9EOEVmdzlKNk9KRXlQUmlnSHpoV1hPd0VoWjkz?=
 =?utf-8?B?aHFOWHRkVFJ0aWRidWl5SGRxaXZMQjJGQ2xiR2laNFBWN0pjQmYvZDhGVFB0?=
 =?utf-8?B?Snovc1VlNTdSYmIyMWkvYy9pS21wN3lMYlNxa0dzTUROOFJGdWVPNFMyVEpT?=
 =?utf-8?B?RTlueUVGdVk4WnhOMkpadmdmV3l0Ti82NWYyUUdTcUQrSmlZZkpOMkhHZ2U2?=
 =?utf-8?B?S28xUUNaTWlmZnd6R0VQYUpHcEY2VHJBdGRjRlBuZHE4azdLZlpCMlgzOSs2?=
 =?utf-8?B?V0ZmZVBNd1ZBMGErRWZXRG1KbU5FMFlRTDk3dHFQNkx4SFk4K1RWNDFEYnJB?=
 =?utf-8?B?ME4xVjVYRlJWS1ZsVGZrazRtUVo5UWRFc1BlQXRoc2E0Vm5qZEY1czNrRlZt?=
 =?utf-8?B?bkltVVRaNmQrSnp5U1hTYWVZMExvNEFDRUlMUGdCdlJPOXFWZWFwbU5aYXBm?=
 =?utf-8?B?ZVYwVUFzcHk5Q3c4b05qcVFmeFh4N3lLYngxTk9uakRoVTZPYXpZQllUQ3Rs?=
 =?utf-8?B?eWRYTXpuUnM4YnRwcDBFUFY5bTFhR2h6WVFRY1RscjJWUkx6ZmRYaGIvbXVl?=
 =?utf-8?B?ZW52Q3BoSnpzbWhlSnp6NTdFOEQ2elhhWHBqRzE5YWIxR2liSkhIUHhsYXY4?=
 =?utf-8?B?MnhQNTg3WTJxSEJlOWMvV3J6SDVva3lYUm04Zzd2aUVtbThvZ05rZ2RtNzVF?=
 =?utf-8?B?akNhc0Q2Y0JOWXhGbGcyTmJQbEowZHQ1OTJyK3FIOW00cUs1dWNYYWZianpO?=
 =?utf-8?B?ZmlrbjJEc3k1RnZ3YUp2Q0JSb3dEcTFoUUpYL1dINjZKNnFvc0VNTVJYUEtP?=
 =?utf-8?B?Y3hWSXhTY0xLcHUzZyt6NWtGc1ZBMkRROGNFMmd1TjhxeTNBallUUkhDZWZH?=
 =?utf-8?B?OTF1SHlEVU1rdDRiT1diWmJ5c01neCtGaUhVUTlEV3dCbUd1eHVSS1dEY3hq?=
 =?utf-8?B?VkFRSXRIdkF1YzNidWkwbS85U0lQNkF2OTdqOW12YVV4cUhCcnhQQ2U1UEZm?=
 =?utf-8?B?TEt0aFNIT0QwWk11RS9PVWIxRWdscFloNVg2NWlEWkNhZk1QdWh5MHNqQnZM?=
 =?utf-8?B?WHcxbkxGZDVVNGJtQWJuZThQazZkZjBkc3M4Z2FRd2hXRlFoS3p6WEFTYXdQ?=
 =?utf-8?B?a0hoSnJFV2dTdHlWUm43eksveXNKVHdzQmxiS2xka2FQUktmSkFCR0Eyc1dm?=
 =?utf-8?B?bThadm9uZWxtd0U1b1NKcUUvakViZFQwT2xHbWczMi9tRmVzSVdJVXcwcWJk?=
 =?utf-8?B?THJmRk9sYmhFeTJiTnJEc01aOVpCb1MzZmx5QzhYeFFRcVY4a2grSU8xVDFC?=
 =?utf-8?B?TmkwRSt5cFQyVEVrN3hGdlhEak1oaHdNNnYrRFJnVENJOGVjZytVRFpvMzdW?=
 =?utf-8?B?S0cxVDk1SmhvRmhLTXJoSnVkRm1BbWlSRWZIcm4vcEd3QmtLeVVTRy84Ym1y?=
 =?utf-8?Q?SJ8a5Gj0v30xF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB5544.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0tWd0NPNndBT0xzSG5LbG5McnN4ZEhKbm4zL1kwNUlRYmx6Zk96VVEvWVN4?=
 =?utf-8?B?TitscnBndW5UTmhzazdJVnA3OVA4dkFyZ2tRa0RmN1IwdFkvTjZ0V2ZncjhV?=
 =?utf-8?B?YWF3NHphSW5wLzNjM0xlTVF6QS9JVXZFb3hua3UrUzlJMWdsQTRhUzZhRnJN?=
 =?utf-8?B?TWhXNS9WUkt0RGVLZFV5NloySlcxZkxOY2ZDd1JTQk1iMXBVZy83bmxWcEtQ?=
 =?utf-8?B?RzZJd0RWZVM2OFAyVWtWbzh3WGQvcXhZd2hBQ0FPMFJZdWpIZklWNjBYd05O?=
 =?utf-8?B?UDJ1TzVxYnNhQlE3TzJhUFZyK1ZMS2NKZjRjMGtmNk5wMGU4RjJYU0NQSjly?=
 =?utf-8?B?eDZEZ1c1Q0xVQ0d2WnlOS1FQQ3g4dzhqSWVJcGRhUFVveXVQUGZDSDhLYXZX?=
 =?utf-8?B?WGw3TzRKNmFDUFFrUnIwejM1RWpNSE9JakJObTJxYklQWEZoc2NpS20yOEV3?=
 =?utf-8?B?YnJyNFAveVZaNlNMZGV3N0dyTXhySnhJTmNRekVId01OYUpvckM2QWRPZ3VM?=
 =?utf-8?B?M2lhdjE4KzA1MytzbCtmcC9PWU9KN0Z3dWdtTlJMN1hGSFhoMmdZS3U5T1pK?=
 =?utf-8?B?a2tVTnQ5ZmlVdmZnUXdQdERVWCtDK1FDZjQyeTQ0U3dOZXVYYXo5aW43K2JQ?=
 =?utf-8?B?cTF3Nk02eFhycjJvYmNJME9qOGdTVEVkME83THI5TUZlUFhDRGh6OU9BcnRa?=
 =?utf-8?B?czhsOU9NT3Joc0dURmppT01DZDB3b0hJTGtsN3liVVJ1eVBicHBYc1B0UUs0?=
 =?utf-8?B?SkZVVEcvcWZqVGN4Zk1lenBHakhaWUlpQURva2hNRTVtZ2habVl2aVVnR1kv?=
 =?utf-8?B?NDk3dDJoRWtsNnlXM3REY3lpczBrdW9kQ3pRZDVKWkdlMUZ3Y1lKUDh6eW92?=
 =?utf-8?B?RUNWaWlKOVdCWnBxQXNVSi9JdU83R015NW1wMXJreUQrMXA5N1ZjTzJUYzQx?=
 =?utf-8?B?ZVZaSHg4L1Buc2NDZkxEMFIzUWxKai83ZE9obnY0WU5zK2kwM3JpQ1YyRG0v?=
 =?utf-8?B?OENWbDZYQkdweDdUL1hDUFBHRVBVd0VSMHg2d1d0eTI2ekVFMlJhYW5OUDFY?=
 =?utf-8?B?Mkk0cTJZSkVQNFdmSnV3L1dSa1lodEc1Sk5mTXJQTnhZeEkwdXpLTmFLNE9m?=
 =?utf-8?B?SW1wb0Y1bm5iSjVGbk1OQ0Y3RmhQZ1Rqd2ZTWmptTC9kKzEwZEJxTUk2aS9U?=
 =?utf-8?B?dGpqZnZONzZ6UGorcTlsbk9sWlJlY1NnS3pUblNuSHpJdndxOFhjRG0xWEhQ?=
 =?utf-8?B?WGpZWHprc1dONEJKemlEK1BqVVNrZ3JaUkJPT3VONnpmT0g2dUpqdHYwRUI4?=
 =?utf-8?B?OHYzRzdoWXdzN0QxMkFYSzdKLzRqSHEwM0lkRlRlQmpycWlEZ1ZOdHpoMVE5?=
 =?utf-8?B?d0NqU1kyMjFUVVM0Q3lJNEw3dVpRaUdVZnJYT1VPNEwxSUhoWTVHVmpnQTFO?=
 =?utf-8?B?aGxMS0hwZi9iTGVyYVlBdTBrNVRiRExhemRoZWZMWXAzVEQ1NUozTGk2ZHBB?=
 =?utf-8?B?N3NRa3lGNVBleWpoL0RyMHFLNDJEWUE0Si8vTGwrZlh4Z25kM1VDUlZYQ0JN?=
 =?utf-8?B?MzdZYnB0OFA3VlBtMnpXeC9FNlRacVV3SjRyb1laNTJZYm5WM1Arb08wUEJj?=
 =?utf-8?B?ejQwZU9JRnVzWVlLZ0NsemREMEExcE1Ocks0bUVybGN1M20zbTFwb2g3SEJR?=
 =?utf-8?B?UHJaZWNwbTlsV0lZMjNUMWpSV2JTTkJWTkF1azBCSXJkWkpDcy9VOXRQME5m?=
 =?utf-8?B?Yk9hc0ZkRWZqLytackVhSmUrR09aMUc3VGVqdUJWQm1qcmc0R212MDJha1hN?=
 =?utf-8?B?dXphSFhvWVdrNHJYdDJ0cG1YYy9xRmsrU1R4NFVkMDZEWE5RbFdGZ3RuSlhw?=
 =?utf-8?B?VkdYNWF6bUNyR2xTdVNWZi81ZHNXZWNSMU83bEZUS2VOVnI3cmhBVEJSejlq?=
 =?utf-8?B?clVRUG5HL3E2dUdJR0o3TWQ5c3lZelRNQm5FamFRdzdhQzFFQnpLZUduVktF?=
 =?utf-8?B?LzI0WDB5TUs1Tjh3aEJuQlcxS25SVjRSTlowdDZ2NHpUVWVFNTFOWmI2WGow?=
 =?utf-8?B?R3RIUnRpeGMwaDNNK0dMdjYrNXg3RVBHR1V0TkY3WXp0K1BxNUlZam9kd2ll?=
 =?utf-8?Q?l/wiFDcnBS8YPo0GGn4meTfXZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64dd1e7-a279-49f6-ffe8-08dd1e7d98e1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB5544.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 09:31:34.4594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIKCq4EISOsmLv+X/0CqYF6QdJGv4DgBPnAP8KwJm1ZaMYm8hVp9veSt2f4DJoRhjWBpnEV4q+WM9UmTbTzNcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8747
Received-SPF: softfail client-ip=2a01:111:f403:2416::627;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 16/12/2024 21:53, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> On 16/12/2024 16:05, Joao Martins wrote:
>> On 16/12/2024 15:52, Joao Martins wrote:
>>> On 16/12/2024 14:52, Avihai Horon wrote:
>>>> On 16/12/2024 14:32, Joao Martins wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> On 16/12/2024 09:46, Avihai Horon wrote:
>>>>>> During dirty page log sync, vfio_devices_all_dirty_tracking() is used to
>>>>>> check if dirty tracking has been started in order to avoid errors. The
>>>>>> current logic checks if migration is in ACTIVE or DEVICE states to
>>>>>> ensure dirty tracking has been started.
>>>>>>
>>>>>> However, recently there has been an effort to simplify the migration
>>>>>> status API and reduce it to a single migration_is_running() function.
>>>>>>
>>>>>> To accommodate this, refactor vfio_devices_all_dirty_tracking() logic so
>>>>>> it won't use migration_is_active() and migration_is_device(). Instead,
>>>>>> use internal VFIO dirty tracking flags.
>>>>>>
>>>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>>> The refactor itself is fine except a pre-existing bug:
>>>>>
>>>>>           Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>
>>>>>> ---
>>>>>>    hw/vfio/common.c | 21 ++++++++++++++++++++-
>>>>>>    1 file changed, 20 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>>>> index dcef44fe55..a99796403e 100644
>>>>>> --- a/hw/vfio/common.c
>>>>>> +++ b/hw/vfio/common.c
>>>>>> @@ -170,11 +170,30 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
>>>>>>               migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
>>>>>>    }
>>>>>>
>>>>>> +static bool vfio_devices_all_device_dirty_tracking_started(
>>>>>> +    const VFIOContainerBase *bcontainer)
>>>>>> +{
>>>>>> +    VFIODevice *vbasedev;
>>>>>> +
>>>>>> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>>>>>> +        if (!vbasedev->dirty_tracking) {
>>>>>> +            return false;
>>>>>> +        }
>>>>>> +    }
>>>>>> +
>>>>>> +    return true;
>>>>>> +}
>>>>>> +
>>>>>>    static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>>>>>>    {
>>>>>>        VFIODevice *vbasedev;
>>>>>>
>>>>>> -    if (!migration_is_active() && !migration_is_device()) {
>>>>>> +    if (!migration_is_running()) {
>>>>>> +        return false;
>>>>>> +    }
>>>>>> +
>>>>> Tieing to migration status means that non-KVM dirty trackers cannot be toggled
>>>>> unless somebody starts migration. When really your original intention behind
>>>>> commit ff180c6bd7 ("vfio/migration: Skip log_sync during migration SETUP state")
>>>>> was to avoid the setup state when you are indeed during a migration.
>>>> It was tied to migration even prior to this commit, as VFIO log syncs were
>>>> restricted to run only during migration (we had "if (!
>>>> migration_is_setup_or_active())" check).
>>>> This commit only narrowed it down further to not run during SETUP.
>>>>
>>> Ok, good point.
>>>
>>> Btw you are regressing from that behaviour with this change above, because if
>>> migration has state MIGRATION_STATUS_SETUP and migration_is_running() will
>>> return true and so you will log dirty pages.
>>>
>> Nevermind this comment.
>>
>> Just noticed that it was the point of the whole thread:
>>
>> https://lore.kernel.org/qemu-devel/78729b4b-3747-4408-8146-12d49e70fed1@nvidia.com/#r
>>
>> ... where you discuss this.
>>
> Actually, from the thread quoted in the cover letter[0], at the end of this
> series we rely on status of dirty tracking to go ahead with the syncs instead of
> relying on migration running or not.
> Hence just removing migration_is_running() calls wouldn't regress the bug you
> fixed with commit ff180c6bd7, neither calc-dirty-rate would miss dirty data from
> its reports.

Right.
But since it was previously tied to migration and because I remembered 
you had the calc-dirty-rate series that also added the -d param to 
control the scope of dirty rate, I thought I should only stick to 
refactoring for the migration status API simplification and that the 
calc-dirty-rate series would come after.

But if we simply want to include VFIO DPT in calc-dirty-rate, then yes, 
I can untie it from migration in v2.

> [0]
> https://lore.kernel.org/qemu-devel/58146556-d3fa-4d8b-a1db-9bdc68168c78@nvidia.com/

