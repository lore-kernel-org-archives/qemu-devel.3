Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CE2C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 09:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYiDf-0000pl-8V; Mon, 07 Jul 2025 05:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1uYiDG-0000gC-16; Mon, 07 Jul 2025 05:32:39 -0400
Received: from mail-mw2nam10on20606.outbound.protection.outlook.com
 ([2a01:111:f403:2412::606]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1uYiDC-0005sv-AB; Mon, 07 Jul 2025 05:32:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0bNtCTCMoCI64+WccYpYm/qU8Fe7/v37NVV+f14ypznVGoOxowj+itqoR1M798S45TOKF1fQMWkNAFrg8H11UBRQMfqNDdwsvrxZJqr++vKWAdEdkW2xbANIP8dYQn4WnI6U/rLVrmlcwiP1tYLFVJA5+5gUOt9YyPu2RxHEyHrbYjsQGXlmkZVImI4CyQwwvWwETTNkjb5Ms9JfZoVL5NyRuY65yREjNcak/Ew71yTElVN3lZnSP3yB2nlUZCyh37V4rmlNvMUv/IsSlVWgeSgLKEGMrtXQyxhOJfXAU8u9QCkOWPtR15FQD2njzkWXZ80CQu8agabaX8T4JIQXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pJRuQgLKW9Bq4d+xX80f7qtuzbcRicE3osfhjohyOo=;
 b=CBDYTHqOpCC1lSkpw4ZQ2+dGRqSMF5HzTVtQsftMu+yp5t5tyjqXacXEwI3wUqXOinpU1dPf1yGAlCW/pLenBG694FvWzf1nldjuv2HPWoAAl9c3ISS92cyza9YSA/kuVVnC0GIYVTflU0rhl32IhUcfMxZ4eJ+Z2FwXhjOXaa1MlmnPQ9LDmm/uDvj1N7eqh9P2M99qCJjVbJDsePW0ZzSeE6FcFHoK92k0RYlKSC5bzqMNxnEpg6NUGGyZhRcw+AsgiF0gwyIamRIOBXSgoB8PKJ5jeZw5yIRZQaLTfI7E7fmqkx8oXl7X99wNMMdjF/GzjjnWa84x+7lBq/+jdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pJRuQgLKW9Bq4d+xX80f7qtuzbcRicE3osfhjohyOo=;
 b=FXkdPsAkldvpmLm+YXytPW/hWSi7zAEOnyRQp3vi8sYlCH2ihDQm9ge38EZBGvdxWyS4ocsMqvJoLDbJpP14EmVpY52yPajoTLss0PYCW76S/nWX54/XtngZHH96UkptaSaMjDyXgRJvfL9USXFIiYDlwhufVBHDXaf8Rt1UrfVjDg/2zaq6ZFVaUVrXStLPPbyjX8iNRyN6jQ7koD0vvPQu2lA5JSm901FswP7xIaCxXKLVA9ptMZENFPka/mkxmdDNrL8lXYE7F1LKE2QadGG5vlUJ316d7k+/FkVzNZ0LeeGuYHy2GQfvwFsm2g5C7lD5+ZMbL2eHVueNsThwsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 09:32:28 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 09:32:28 +0000
Message-ID: <65f666d6-0aa1-4117-9e47-d52ac3a0c70d@nvidia.com>
Date: Mon, 7 Jul 2025 12:32:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] vfio/migration: Add also max in-flight VFIO device
 state buffers size limit
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <cover.1750787338.git.maciej.szmigiero@oracle.com>
 <65a132db72807ec6341015e7079b10352d718b96.1750787338.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <65a132db72807ec6341015e7079b10352d718b96.1750787338.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 681b3388-e0e7-414a-2901-08ddbd393077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDNKQ1FMNEpJeXJ5SWpEOE5NR3MwYzVXekpQQkFSS0JsYU85SDNHRGYwY3lE?=
 =?utf-8?B?MUlOWlNwa1JLNUI2V1VUS3FRbXV0eXFpNUJ0MzVtWGQvWXU1SDJ2MVVjeDRr?=
 =?utf-8?B?Y3YvK1J2YWh1ZjRTd0Y0UHlaajhhUGkzTzBmTCtFUjJ5L3ZKUU9PRU5pTm5U?=
 =?utf-8?B?aTdobVpBVWVKNkprL21TS2paQmxKTDVzc3pXeHkvSWVjWXdPbDV5b0NjZy9w?=
 =?utf-8?B?U3o4TzU0b1I3ZmYzeGpLOWorendVRTRraFZFcURFcDNTQ2VkcnlOYi93UitT?=
 =?utf-8?B?SGRqcGlmQU9Vc05XVk5NNGhEYVFudnhCRUxSemZSK3NzMjcrTnI0L0JPdkl3?=
 =?utf-8?B?Zlg4TkxuSTNIMUxhbitKMVV6WEZ3Vi9xbThqM1NTS1UwODljdXR3Y2YwYVpD?=
 =?utf-8?B?Z1RQWXNtMGxhMHZCMUdrWEVTcmdsOGp5TksxaW9mcEw2SDZoWUZyZWE5cXk5?=
 =?utf-8?B?Mk0zYm1rVk5sTm9QVndRSnpsaGN3RjRYVXdkdFVPT2pKRzJWSEhPMFRwSnpF?=
 =?utf-8?B?c3J3TGh1ZFNkemNPNWg3eHE3UUUvYUxhaHhJSUViTW5UcHBjZDYyY2o5c2hD?=
 =?utf-8?B?VGJhclJhNnQrODFodWNlVnpzUVl1UkV3ajV5dVlBRkVhQ0FCdjhJYVJHZDJT?=
 =?utf-8?B?UXpaRWRMamhveGpqUmtpRitjQ21HQjlNdFQ1TVpDTVovU1hoemZxb3FWenlC?=
 =?utf-8?B?VWRvdzNrTU9wb2FnYnRiRkM5cDZXdEVxa3ArWllqZkdZbXFlMG4rVEhsMHMv?=
 =?utf-8?B?eUlGSnFWbXN5d1VkdDQxNTZuN1dsbGJMNlNGZzlRZHFWR1p1TUEzVnQxTUwr?=
 =?utf-8?B?UVd4WkhSa1dyeGgxOHN4QXdodW1HOEZXOGZQU2tibmRtWU9ZZFRTLzBDRXp6?=
 =?utf-8?B?K1VzMGt1UjBVSmEzcHdzemJOVWMzSDF5cjEwckdTRlpTald1WWpVNlZTdnF0?=
 =?utf-8?B?N3VNMmdtVFRyL1VUV0h0NzJ6d3owOXZTUXhhOGNHNWZaVVdJdm5xbE4ya0l4?=
 =?utf-8?B?eGlJUFBJTm5UZjdqQU1FWHJrdUlzT3cyRVh5bXBHY21nalNsQTFSa1FyRHlB?=
 =?utf-8?B?aXd6VGd0QkV3OU03VkRRYWw5UFFlbW1TdFlTVzZDanM4QXlOWWdiSUNsb0JK?=
 =?utf-8?B?NEZpbnBGdmV0cE5ocS9vMXVWRFg2RVBrZXg0N05Tb04vVVN4RlVEdjVjTFY0?=
 =?utf-8?B?WHk2VUVUc3lVRGR5TE1aMUt0dllpYmlZOVByUDR6cnBib0xINmZibGdtRGcy?=
 =?utf-8?B?bS95OGFJOHUxNWZYck9ic3paNVYwQjNJMGoxbkV5azJjcnNSTlc0ZmM2QmR4?=
 =?utf-8?B?Q2t1N2xlTHJEWGNaOG9BNkpyNkczNzdQdGQrMmY3bWRadHZWNmVkTldyMHRS?=
 =?utf-8?B?WEcyUHd5WnFmRHYrUkdUMGk0NDNOOUQzMXlvUC9hQWRxNGVsM2RGUi8rUGdy?=
 =?utf-8?B?OG9CNTU1WnZlK1BHUGM0WHU2dGJPVjh1cWpSYlVrOHdEOE1aMWo0TWNheHNZ?=
 =?utf-8?B?aHFEb05zNXp6Q2sxTG9XeVlaSFA5eVArQUFFbjBOT0puM1VuYW10N0xVdmNT?=
 =?utf-8?B?bFdVWGFvUHYzRnF5ZGdFM29lWU96S3piUGF6K0t0dVpSMTVGZ3A5K01OazRz?=
 =?utf-8?B?REdRNEpnN09tcnJsRFlEaDF0WThaOHJoSHFaZ1ZkbFdpbURGTFd3c1U0a2l0?=
 =?utf-8?B?WkpJdkwyQ2lTVXNpUnRJVG82cll5aE1RMTJMWkRwa1c0OFBBWmdHcUlTVThB?=
 =?utf-8?B?WFhjcDFKem1Ld215RUxLM2dwNy9zcTh1TDBVMHJqbVUwVThKd1I0NU9lV3p0?=
 =?utf-8?B?SjVJWDl1Vm1weUUycGQ2bkd1Qzg3dnFVVTdwTmpPcSsyYWRndThScm9vRE80?=
 =?utf-8?B?cksvZTFKMUo5d2Z5eWordnBNcXhFcHBJT01DeEtYQjltWi95MG5xVzJIQnkv?=
 =?utf-8?Q?KgUMT3cCue4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTF3RERXN2UycDhZRVRRZkhVYUdxeitDOHNTMXViZHJOcHNtQUluUENUQVlE?=
 =?utf-8?B?S0xtcWhMbTlHOTlQejRFSUU2SFArSkpwN3BOK0tocVFGeXdIemtuRzlFaEly?=
 =?utf-8?B?WEQ2bHhEYlNPdlphZStPVEgwTTJVazBrSk1vWTNLN1NvUlNuSjR2ZUxSVHdy?=
 =?utf-8?B?bThpVUdjNzVMOTlMMzRrNXY0Wm5TSmFMNmxYOUdadlVwUmYrZE9yM0FGaXpw?=
 =?utf-8?B?OXpxNnI2ZjhBVk54WkRYbzRBbzlJV3ovRG9UMjkwdjNWU2xpN3I3b1p0VXYr?=
 =?utf-8?B?WHpkM1kzd0cwU3d5dnkzZnBBT1hZaEdtblpFOHJqdXNoZS8rOGlLOHdCWWJO?=
 =?utf-8?B?RUJhYnhDR25SNmE1d2pQU2JyWEFEYmYvQ01DU3dEMFFNbFlJd3NGNHAwN0d2?=
 =?utf-8?B?YWpZQ05jdHg5cUkyczBDaDBQMUU4bTVBR1R3UGp4MTlsTHpKMDNLdXkwZGNq?=
 =?utf-8?B?Mzh2WUxqemRGVXlacWVTRW5LOXd2STNqY2I1QmhEc1NOWW5EaFJXeG9hcElO?=
 =?utf-8?B?ay92NURDMkQxbndvcjJSL3hUQXlyTER2SEFyZFE2cWdEQ0g1ME5NOHBIUnhI?=
 =?utf-8?B?N3I5Nm5uYmJXZFlMdk9vbmV5WUUzWDUwam5yL1NHTGM2bTJDWnE1cHlrb3dE?=
 =?utf-8?B?aGhJTUtvbmdodk9XdmlMN1NPNWkwK0xpc0dnNjdmV3Jua2JXZkRMMGRidWlx?=
 =?utf-8?B?ZnNGUS9Vb2c1aTNoVFFnVnpqa1BlaTBYdGVvL0JRNVgwT3JLWUlkK2pLSHRY?=
 =?utf-8?B?ajFaLzdDRmZtWHY0YlVwMUJ4dTJVNk55ZDBjZzZ5NHRWaE5TdlZQUjVLS1Z6?=
 =?utf-8?B?WXdJUUs3a2VOV2tMSU9Rekw4MEM4TlZMUGR6MTBJaGROTkNSYzVZa2NvbTJv?=
 =?utf-8?B?VVBJdmRORVJ2Ym1RV0VFTytVMUZ3Z3R6WS81T05LVVY4cWxoNmtQTXo5SmMx?=
 =?utf-8?B?MFVlck1aWjZZTHVZZlo2dFVzTUxkVXNkS25CVGJRNUo5blIvWmRIckF1eEU2?=
 =?utf-8?B?by9mNVBKZkxKaUdKTVI5K0N5OG0xcjFlR2w5dWxvd0dkU0MvOXRkYXZ1NVkw?=
 =?utf-8?B?YTJ4UzhlWnpaOVFEcWd6dk9IbGdTU0UxaXIxTmFGNGJKdmdmVTZwWnplS1Fv?=
 =?utf-8?B?MFQxclNhVmJDSzg4dFg4Tm9KZ202bXVtMFlHWkhvamorNVhUeDk0VU9GWTVs?=
 =?utf-8?B?S0pueUc2S3NmZW5kNm9JK0JCN1dTL3Uza1BYZU9Gd1JKRHJsZGtHWFpSeHcr?=
 =?utf-8?B?aW5ITlZOcXlZRkVSellxREtCcXVpbGlzYmJoQ3RRZWRMSE13UjhIbHhtSXpT?=
 =?utf-8?B?NEpadTZ5bE1Gdnp2czFqYzhWUUxlWHhLL0FMTVJSWDNCNzlPVmpqSDVZd3Yz?=
 =?utf-8?B?SWRPdnUvdWZyNTZYdG5xdUEyakVnQ3VBYU1VRGxPWEQ3MmR5UC9rc04vSnZO?=
 =?utf-8?B?MFpsazE2U2tRRjZ1QWJyYXkzVUxaSkd3aXJ2c1N1R2JTNHFqYTd5Y1lXbEtE?=
 =?utf-8?B?UnJQQ2liVXBDUVpkeHhobVJyUk1GOEFxYlhLakJubFJoRTZSZTFyQ1J6L2Vw?=
 =?utf-8?B?czlrbFBwZEhSdnhiRkxJeXFmakJPNmRGWHVSd1BjRW96RS9qMUlJOUxuelhB?=
 =?utf-8?B?WXJhQzhibHhzbUFNWDIyWFc5cHNlVEdMNlFmOWsxUzZMTnpEMVhxb1pxeXJl?=
 =?utf-8?B?RWhhZUJqdXpXV295UkVMTDk0TFpGMHl6WE9kOEM5YldRcVNUM01UNFZ6QVo3?=
 =?utf-8?B?S3R5bS94TkdoZXgrcDlnU285WDFHQnpmSFFqdWg0eHhad2l4aXFRTEx0dGRn?=
 =?utf-8?B?WTRKOEdvNSszVDM1Tlo1TzlJMGFXMGxpQjNCV0JjcGZPYWFIaG9nWmFaRkFm?=
 =?utf-8?B?T1pqUStlOFcyV0tla0ZLU1dkS3QyNjUrNWgzZjM0WVZZQkJhbnVzd0x4MWN4?=
 =?utf-8?B?anA0OTA1bC9TN09Lb1lQMzBob2I5c2pXcXF5TlB6Nk5EeExGeWxpNDM2d3Zq?=
 =?utf-8?B?ZElHcXdsKzRlVFdVSmwwWGpoZGsvRWdaeFFBU2NhL0hveFFRa3kyMzVMVG85?=
 =?utf-8?B?M1ZGSi9qNmNCR1o3NDZlMGZZSUY0Zm85KzBhTEZ2ZFl1WXB3NTV6S3F5WHFE?=
 =?utf-8?Q?nvWgQ5EWDoVEim1Y8nX9OLa5F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681b3388-e0e7-414a-2901-08ddbd393077
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 09:32:28.3456 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEbHVS1WwehBonsoPtQtmsyGW8AoHmbXVm5rluFtsYnMoPVhOYmfPvewI8lD1y9WgxpHadjVmR2Ac9SsIf6PJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138
Received-SPF: permerror client-ip=2a01:111:f403:2412::606;
 envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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


On 24/06/2025 20:51, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> There's already a max in-flight VFIO device state buffers *count* limit,
> add also max queued buffers *size* limit.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Reviewed-by: Avihai Horon <avihaih@nvidia.com>


