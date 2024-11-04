Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5B3D111BB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 08:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7sDO-0002rf-Kp; Mon, 04 Nov 2024 03:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t7sDK-0002rL-Qf
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 03:13:32 -0500
Received: from mail-mw2nam10on2047.outbound.protection.outlook.com
 ([40.107.94.47] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t7sDI-0002eq-Oe
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 03:13:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzJnlxPL4+7mZYn9j9PwG/dJVZXj8caK6vkZcwcYuwQt0MP6+WOZ5MvCouJuG7V4z9MTkFuH4kopYmmyb2foORO4pOCgLvdqJ/GOOVK6cno4jOLrpGUhcix0bAz/rP3sieJB2u1N+y62V9D4+F8WYWKfVFm+a8V525UtAaNG5vIdu6rRRK8YheBLf+A8P1nFFHFUYZayj/z/kHNMQX+c2qpfVvvcRYUEwfElxkFkK1YvGg8Tpa6dsTcwAE9qfcuyw6KJ09m/24dOK5I7u/YT57F/9gVAk5hACm1DxfuXjwl3GmTfLuJ98dHqS+asivVtxGqpUlGpfExu7PL8+JVp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIrA2u+9UaqZBBEdcfzs6RJ/63yzPYdXlQlKyAH8Lgs=;
 b=f2bvxG4mLgyLad/M3SL1CCvNjRuy7ZwFgSxeBo0Z7JzHf2fE7hEoVa89ACM+xMt7AQXVzAzBVidGcmnT+ZYJdbxbojqVhBwsIfhp8iFWTbJ4kUGSkaBS03G+JzvEUhfxrJAfpd5T/A9BVQ8VuSHyGHqK7Bpu9YL8p5JwRelwGfOnQ81vVlJv7L4Rq8BkygDhfsZfOQEKgbbEeASg7vFCPQsNkGJgGVfzjQPaUsS/TeXI0huGG4kdRTz8kMmM9/aBE0bvmYdL9G39C/c6bVOmy6xXA72rhMV5M18JPmxzunmWvU6qS5kGrfyjgEvpETQRNyF4H3SS0VurylDPoZf0FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIrA2u+9UaqZBBEdcfzs6RJ/63yzPYdXlQlKyAH8Lgs=;
 b=OJ7gyPlJGvSGtxGvJXt5rydfeLnEVqyVSVyqirXj8TxvIjzBOran+sX7yJu+2m9G31tH9coF5dr16K32e+pfBs8i78fK32YMK3rXxAJLoPWoYJoZLWe2WBzxoGP83m1plwoH4/uTlsLY630vsS7Cd1fYJ2KeHn1mKaS3tDfK36IPI75P8mxcKdNVGOzliS2PmyO7te2daa4qRA1VX9/J3+mLmipttHiCV925FuOq6Jo4wzU7PJaPDCtFnW3gBmiGvHQntCgFx7cUvsWzc0t/p7OuHvrkiU2NYpG5odgyhecf2s09L5QFSwnNYCVMPDcbPzXgwDEW4bLa58zS32wnKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by MN0PR12MB5738.namprd12.prod.outlook.com (2603:10b6:208:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 08:08:16 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 08:08:16 +0000
Message-ID: <cceed8b5-6d56-4da9-8321-7f361f0f74c9@nvidia.com>
Date: Mon, 4 Nov 2024 10:08:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] vfio/migration: Add
 save_{iterate,complete_precopy}_started trace events
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1730203967.git.maciej.szmigiero@oracle.com>
 <68f51cf0eb3daf448ae80219dded4b10984e32db.1730203967.git.maciej.szmigiero@oracle.com>
 <1eac2eb5-c154-438c-91a3-fb7ac7e3baef@nvidia.com>
 <c78686f9-d8a8-4fc1-bd2b-5268aa1aaf4c@maciej.szmigiero.name>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <c78686f9-d8a8-4fc1-bd2b-5268aa1aaf4c@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::12) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|MN0PR12MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1cc5ba-1b99-4f87-4d36-08dcfca7d5e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUYwNnJNcW96UlFrMzNmUVRkMWVkbDZOc2JQcHNNbTlKMUh5aWtENHU1M3Rq?=
 =?utf-8?B?Q3hQeXJaNm55NmxFcW5yREhpMFNtMGs5MzdUUDNIaklOSy9tUzVjaHlpeng0?=
 =?utf-8?B?aDJPci9hck5CZ2RHT1h6UmprWDRRaG5MUVI0WkNLRmJ0d1FEWVlIVlQyUUxl?=
 =?utf-8?B?ZzlwaEhoK25GYlFKbCtPTUJsUnB4U1NFKzcrTFl0a3B5ZXpJbkV0UEhXNFdE?=
 =?utf-8?B?bzlOdnFDdG5jS2ROdW5wN0ROYzgvUG1nYWtqZXpkTitZRC9zMGRVcWpBUDc1?=
 =?utf-8?B?bW1TenJpRUozZ3NKOTFIR3IraS9aTDdsQ2FKTkk1UWd0MmtFQm0wU25pUUJT?=
 =?utf-8?B?dGVxbkRtWmovK1NPdit1b0RGSnA4dFpRV3RzN0VjNmhYVGRRVWl5SC9kUU91?=
 =?utf-8?B?R2xJSWtiSUlZOC8ydjJqQnpEUm1aRGJHd2FBM3lpN1lWOTJWWUY4Mm1oRk9R?=
 =?utf-8?B?YWJQWGZ6SENRTFlQQUQwdVkyaWFJTWVjR1lIbnZNNUxnR3Ryam1QRTZ2VjRv?=
 =?utf-8?B?bWxTOStYVERPUGp3Vzlzb1BhTTFKRkVqWnRxa0JsTm1WaHA5WVNGLzNLVTRw?=
 =?utf-8?B?c1JEZ2ZoMjAyc0YraGp0UXBFZ3ZSSVZqYnJpTzVNcDhSRlZNd3hTRk1vWHlW?=
 =?utf-8?B?WTN1ZDNYYmgzNkRCNUk2bE4wMlV3bC9nYWFRTDBYakpXS1lMV1Y1TGh3Y2N5?=
 =?utf-8?B?WEVBd2NDQ0RCSFpWN3ZZMnNTTWxiNnkrSGZvQWNmQmQ4aE1jbHlpOXhWNzRY?=
 =?utf-8?B?R2FoWHFRZnNHWEpvVWtWOVhtTGRZdldkWnVINzdCN0FkZkZBSU1GMFh1Ry9n?=
 =?utf-8?B?TVNadS9kQnBnNjYxNGtUaEZwRm1td2lDcmJneGh0WGNpMUNhWlRPQnVqOFkr?=
 =?utf-8?B?U1dwR3FKRjhKWkJKUjhXRlNOMkRsWFBCOEZ0UmduUHU1NS8vOGV1eStmYjEz?=
 =?utf-8?B?K3VJNzFvK2dSbkNjbW9yMUFyUW5SWmRRMjJqN2ZQV3VOR2FJSFpsMDJicW80?=
 =?utf-8?B?SzVtVStBazRycEkrRUw5MnpwdHVtUGhhRU5PZnlLU0wyakhlbnFtTm9XSlRZ?=
 =?utf-8?B?YXNCMHoxVDNWaFJuZ2dIdGd6Zm5qR0ppcEc1Rk90czBzbS9LK2x1ZGxhYnlE?=
 =?utf-8?B?UUM0UFBJdkFWKys4TjNaSjFXWk9oNUxhZjhQL3Ivc1p3ZXhvVkJURHJLSUdH?=
 =?utf-8?B?Um1MblBBYktiU0FiN2ZOSzNmNGJQVXQvU0o0RWNzdVhCMURybFE0eDdhZHhB?=
 =?utf-8?B?dmo5b282K2NCODNJNk5WNjNNQzRCV2w2cHFJSTZVZ2JNaGFyY0QxTXhVMEJQ?=
 =?utf-8?B?cnoyVXlqNEZnYW9vbDA3M2ZUNElqSDcybnE5T2szVnRCTGtPbjNLVXh6c2sv?=
 =?utf-8?B?UU1UaUZCM0pFYWZJYi91YmZLTmNXK3VnakEvSFhVRjRPeWpmY0NKSlc5Wm1p?=
 =?utf-8?B?Y1N2QmpMM1NsRGlUYnpURUtJdFArd0x4bTBxMURoUDN6alRSMzNYUHdta1Ex?=
 =?utf-8?B?SEV6NURKL0ZHVmdjWVdQMktPcmtsUnkxc01pSytNNHV0bFlZRnpyR1FxWTlK?=
 =?utf-8?B?OUZhWk4yMXVuakE4cDQ3bm9xMlVwOTZ1Um93alZtZ1ZyZVp6dDVoakhHUStz?=
 =?utf-8?B?RWxOU0Z1ZVBKalFQL0U0cWkyVmdtOGVrcUFYeldwam56WU1vQm10MEtCc1hu?=
 =?utf-8?B?ZTBIL0RvSERQMVlLZy8xWmhwbnU3eXJlcHRNQzZHRlZNWUFLTXB5OGJ3NmVa?=
 =?utf-8?Q?16DZKv1NrZXFb71hItUbgWmDqatozkifmvOZLj0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkliQ0xpdnJOb09xc0lOZDE4TEpESVRsM21ubUFLcjJ6ZFVDa3prbHpGaFRF?=
 =?utf-8?B?N2RjNGNVV1lhWWU5Vyt3Nm5WaXFrd2VMODBPSENUdEQvTnh0UEtTTFRlQVFZ?=
 =?utf-8?B?b0tFTS90MGR0eXQ0djVuVDEweVM1RDB4Qm9qdkVoY2dQZEpMSmUxYjlEK0VZ?=
 =?utf-8?B?UHlFQi9lTVF1bFgyYXNrQjkxNnNvazUvYzVBdU5Wb1dEU3V0Qk10Nms4WkYr?=
 =?utf-8?B?cEp5ay9rUVduSE4wSXQ5SCtBbWtwUUo5MUZ0SXp5QmQyMlFicTJKVW5MMnMv?=
 =?utf-8?B?M2ZSQloxWkVlY2REWW1JSHV0QkRyemgybU82RkNHL3BwVHhVdTZhSUpvUTc1?=
 =?utf-8?B?MkhvRDY0MGM1MXBzRjE4MWZocDZ3RGJrYnpxWU5VSlQ0N285aHNPanpDMExa?=
 =?utf-8?B?OCtVb3ZRVVQxeEd2RjFaZ3VQa01SbWlpdlF0VUNWZ25Wdmx5N1J6S2I0bkc4?=
 =?utf-8?B?Ukp1WU01ekUzWWNQdjBvVVRqeW10bXFuTnlYT2MrcUZJMlBTcEgzUS94SmxV?=
 =?utf-8?B?eVpTdXQwTGQxRVpSeElkejgvdVFiNVFzU3FWYmxaVHI4QTdiZXg1TW9YTTlQ?=
 =?utf-8?B?L3lDdmdzbjI2TkNTeTJNSEU2YWpIalhzcEJjdHByenc2L3ZvUE84ZVJoeWNT?=
 =?utf-8?B?VUpYbU1zWUcrNHZzVjdmNlB2eGU0anFEVXE3cDhtRVRSMUdxVGoyb244aTJv?=
 =?utf-8?B?U2c1Z0ZXSWZSTXRUK2tSaG5SRnFEM3RJQmNSRXFDMHRVWUZjZ2VhSnBvbThp?=
 =?utf-8?B?R3FKSHB0VDJ5Q1F3bkdlbk9NVjVuVWhhWk1ZWlBpQ1lCb0thb3d5cEtsbWF6?=
 =?utf-8?B?aUIzbkdtV2lNaytiUE9yY0tJT1A3UzhvMHNHT0FlcFhKVVVycTJFeFd4Snlo?=
 =?utf-8?B?TVpDeDZCTGRFMGY4cVpTNVJpYWhESGc2eWhQSUNhcU5HT1gyT0g2d1hxQmJx?=
 =?utf-8?B?dFJIbm95NVlUbER5RUVPRXI5WllRTmlJQWhSZXpUbUt1Z0p6N3QxY3ZadWVZ?=
 =?utf-8?B?TS9Kc09yVXo3MWxFb3ZQWDdBeGp2b3hNTlJDMXcrRVhHRUtkSHJVbm0zcVJW?=
 =?utf-8?B?QWM4NXVxMkZwWEhjOUNaQU8xellxSTFoclNiSEs0cjdVempQQk1qWXVuZnM3?=
 =?utf-8?B?dlg1NzR0UkJOYVVPekNodjh2WGd0LzRaYTFuZHNqU1hKbEdzNWhENjYvQXUx?=
 =?utf-8?B?Y0pPdWNCRmpQWTN6NG1HQnk4THZnT3pWYTBDbDFTZlFzZWQvYkwxUmI2cVhL?=
 =?utf-8?B?em9vRm9SZlg0L0lseHFSV0tzcWtVenY5VG1xdytZZmxVTTVEOFpwcTU2SVZo?=
 =?utf-8?B?cnk4TExybC82RDM4TWQ1YUJLT3Y5NTgzQWNzRnVhZkZiSUFlWklYUWZLUFZH?=
 =?utf-8?B?blNPZy9jbGtMcXJ6MEtBMTJJWW5WZU1EeHE1TzNDMkpwZnZTVE80K2l4eWRG?=
 =?utf-8?B?d3lnZ2doOEljalNRZVZNaXo0SkMyWGJHbHFaRENKbk9Pclo5ZjlGTE1EY0I4?=
 =?utf-8?B?MTBvZmJ0dDJLdTlFOUVsMlM2Y0tFVEhhbzJqaDludW04aDE3RkZScjFwYld2?=
 =?utf-8?B?RnRFUE5qVGNOOFlIbHB6MjdQeDFYcVpDbHRwSUhjeVp3dXNRWXlTRk5WMUJB?=
 =?utf-8?B?enh1akZxWnVFeitvd2xaQ2pIeW9rOGNXakdicFlaY1RQYVJET2tydHZHSU1o?=
 =?utf-8?B?d25ZRUtaR1BuUDNvWVFockJ2TlhrRkQzRks4YzZHZ2JtMlBDamx3bDVUM3ZG?=
 =?utf-8?B?SXVidDQ0eHE3NHRoeUxSRHYvazJJOW1XM0NWTGZ6RWtiMkJ4NTRGS3N5NHcz?=
 =?utf-8?B?VndEVDBtZmFCS2FyVUJIMEpXTGczVmdjT2xaWnpjcVMvOEpDOEFKakhkdERO?=
 =?utf-8?B?Yi9zVTZobDY1MmhhOWNLVncwK3lqeWY2K1QwbjZFYy9EYzlEckt0Qkd6QklN?=
 =?utf-8?B?Q2g5akVkakQrczQ3d3RDbm96Vm05cENnZzhWQUo3Z25lTXRnT1UwYUVJOXNY?=
 =?utf-8?B?NjNMUldNUlUrditxQU02M1gvZ3NNbUtBdXh6N0tiMU8yV3phVDJSb2xRMCtV?=
 =?utf-8?B?SVdObXE5M01zWnNaMjF6NWQ5eHJ6VWNMeFhuMlAyQ1A5NHNPVWNNaGtObU5V?=
 =?utf-8?Q?26LvojsbnLri5YzVWXXoadeE8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1cc5ba-1b99-4f87-4d36-08dcfca7d5e3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 08:08:16.0356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+yhqpW9Ag+qbWKSk5FNQLXVotfw4fjwXpV0I7L3CatQvE2V6msboYUJQVnDwJ7TyYTwyPtPJTIh8zBnlk/gTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5738
Received-SPF: softfail client-ip=40.107.94.47; envelope-from=avihaih@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


On 01/11/2024 0:17, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Avihai,
>
> On 31.10.2024 15:21, Avihai Horon wrote:
>> Hi Maciej,
>>
>> On 29/10/2024 16:58, Maciej S. Szmigiero wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>
>>> This way both the start and end points of migrating a particular VFIO
>>> device are known.
>>>
>>> Add also a vfio_save_iterate_empty_hit trace event so it is known when
>>> there's no more data to send for that device.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>> ---
>>>   hw/vfio/migration.c           | 13 +++++++++++++
>>>   hw/vfio/trace-events          |  3 +++
>>>   include/hw/vfio/vfio-common.h |  3 +++
>>>   3 files changed, 19 insertions(+)
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 992dc3b10257..1b1ddf527d69 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -472,6 +472,9 @@ static int vfio_save_setup(QEMUFile *f, void 
>>> *opaque, Error **errp)
>>>           return -ENOMEM;
>>>       }
>>>
>>> +    migration->save_iterate_started = false;
>>> +    migration->save_iterate_empty_hit = false;
>>> +
>>>       if (vfio_precopy_supported(vbasedev)) {
>>>           switch (migration->device_state) {
>>>           case VFIO_DEVICE_STATE_RUNNING:
>>> @@ -602,9 +605,17 @@ static int vfio_save_iterate(QEMUFile *f, void 
>>> *opaque)
>>>       VFIOMigration *migration = vbasedev->migration;
>>>       ssize_t data_size;
>>>
>>> +    if (!migration->save_iterate_started) {
>>> +        trace_vfio_save_iterate_started(vbasedev->name);
>>> +        migration->save_iterate_started = true;
>>> +    }
>>> +
>>>       data_size = vfio_save_block(f, migration);
>>>       if (data_size < 0) {
>>>           return data_size;
>>> +    } else if (data_size == 0 && !migration->save_iterate_empty_hit) {
>>> +        trace_vfio_save_iterate_empty_hit(vbasedev->name);
>>> +        migration->save_iterate_empty_hit = true;
>>>       }
>>
>> Can we instead use trace_vfio_save_iterate to understand if the 
>> device reached 0?
>
> AFAIK there's not way to filter trace events by their parameters,
> like only logging vfio_save_iterate trace event if both parameters
> are zero.
>
> It means that vfio_save_iterate has to be enabled unconditionally to
> serve as a replacement for vfio_save_iterate_empty_hit, which could
> result in it being logged/emitted many extra times (with non-zero
> parameters).
>
> Because of that I think having a dedicated trace event for such
> occasion makes sense (it is also easily grep-able).

Ahh, I understand.

>
>> In any case, I think the above could fit better in vfio_save_block(), 
>> where ENOMSG indicates that the device has no more data to send 
>> during pre-copy phase:
>>
>> ...
>> if (data_size < 0) {
>>      /*
>>       * Pre-copy emptied all the device state for now. For more 
>> information,
>>       * please refer to the Linux kernel VFIO uAPI.
>>       */
>>      if (errno == ENOMSG) {
>> trace_vfio_save_iterate_empty_hit(vbasedev->name) <--------------- 
>> move it here
>>          return 0;
>>      }
>>
>>      return -errno;
>> }
>> ...
>>
>> If you move the trace there, maybe renaming it to 
>> trace_vfio_precopy_empty_hit() will be more accurate?
>
> This move and rename seems sensible to me.
>
>> And trying to avoid adding the extra 
>> VFIOMigration->save_iterate_empty_hit flag, can we simply trace it 
>> every time?
>
> Will have to do some tests to be sure but if there's possibility that
> we get ENOMSG many times then obviously we don't want to flood logs with
> this trace event in this case - we want to only log the
> "data present" -> "data not present" edge/change.

OK, so I guess a flag is really needed.
BTW, there is also trace_vfio_state_pending_exact, maybe it could do the 
job? It might get called multiple times but not as many as 
vfio_save_iterate.

>
>>>
>>>       vfio_update_estimated_pending_data(migration, data_size);
>>> @@ -630,6 +641,8 @@ static int vfio_save_complete_precopy(QEMUFile 
>>> *f, void *opaque)
>>>       int ret;
>>>       Error *local_err = NULL;
>>>
>>> + trace_vfio_save_complete_precopy_started(vbasedev->name);
>>
>> I assume this trace is used to measure how long it takes for 
>> vfio_save_complete_precopy() to run? If so, can we use 
>> trace_vmstate_downtime_save to achieve the same goal?
>
> With an appropriate filtering I guess it could be used to
> extract the same data, although explicit VFIO trace point
> makes it easier to just look at these traces directly
> (less noise from other devices).

I see. Well, I don't have a strong opinion if it makes life easier.

Thanks.

>
> But at the same time trace_vfio_save_complete_precopy
> already exists and by this metric it would also be
> unnecessary.
>
>> Thanks.
>
> Thanks,
> Maciej
>

