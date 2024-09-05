Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8893EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 16:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smFeY-0006G6-HP; Thu, 05 Sep 2024 12:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1smFeN-0006Eu-6y
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:48:04 -0400
Received: from mail-mw2nam04on20626.outbound.protection.outlook.com
 ([2a01:111:f403:240a::626]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1smFeK-000423-Pl
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:48:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYLRKBRUJc1G2EUu0PRuyGb81Nqi7CJ1rHAks0PnYEBfCmVa6UflKcJ84uC7xwrQJzxcHGturpzvwbKOMgeaLvJ3NQjyHwGRV4UjX9xmf55ZubFVidTBLycA6XGI8DynsqtPN61kYPFq/8QVSEqWlIptu8L1KAmx3FBUkvusbycajnHftk0SKwgN6oLw84Ci0VzDcD4H82mIEiHHR8X3gh5YA/O49aiPzo7AdTgCj6YX0tjC41ls+Kb074VqQPHOHXZQizLIFOLuojuvq+3rb2ppdwaZkRVkihaei5KGy4a6Xg2ZL6gmFYPU0646LIZmkyMMIHGU/JAiflBZn/iYIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTnF4z+pxcYYoVztiw67Q5yIco6DPDt9NLv/gbKPKYc=;
 b=h/z/K+3EETVOpsOsSaegaxMzmdzsuYG8ygIrThTgoCwjR/7cg4ZOLb/higdrsrDYbNij6WRQujHm8Ma67+2QBGU1ChH5LQMN+OuStboLFI5XWIFlG5rHT2+aBz4/9uc+uOOs37k5OLr3FPYufd+EaAxhlWbRDMtfG7YjNlGNaGHaO8jfJoi6AW+Uv9V6Vx/tMP3VykFD9hndqhlw5qld/UDcz1t4tMeh9/euvAiToM2xLAWRjBSKbiSbK/DVvRbJICkL6DIQ6yzHiY+RBkn4wj77UFYTkgjLcneAyQm2iXbhDLBm7SYNkNjeRT7t9C8Afp2ZR0DsE6IV6XA1A2ONeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTnF4z+pxcYYoVztiw67Q5yIco6DPDt9NLv/gbKPKYc=;
 b=HdFSEa5ywrMwr0I5WCxwU9omApSlAUJuxrdRZ64cQWHA8HRXVXWroWhkbf+e0NdzK87TbAN/uzY+y/JDIiL4q4t4mjb3MmAZlvIezOFudAxhdr+l/Mz54frrCuiJir8IJBBtgJ0V2S3bBqOylEIgYmNXm49Q3d534AGRbc/pp3LDYwVzeH6UURvhNuUffSMSaOSqHU3xd8kKzq/7cpO13ItCtwXvV4aGCD1toyRDlClMvFeFN9wxajiKN5B3/AEoQd0zzYqWRsNS1ij/oVYNpt24gEPFpjIoB10guxO2guzlZmTZHHjJY6Tm//eeQJn3Sz2pVlR/tZomJ+u7EF2zLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 16:47:53 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 16:47:53 +0000
Message-ID: <2a9d1c5d-6453-4b33-99cd-824f0002e305@nvidia.com>
Date: Thu, 5 Sep 2024 19:47:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/17] migration/multifd: Device state transfer support
 - receive side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <84141182083a8417c25b4d82a9c4b6228b22ac67.1724701542.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <84141182083a8417c25b4d82a9c4b6228b22ac67.1724701542.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0107.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::12) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|BL1PR12MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: baf4a9bc-a859-4869-5d42-08dccdca7b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1VZcms2dkJyOW1IaVBRVlRKTGh5enNnM3JsUTBxR1dmL0JiTDRCS1cyUjdq?=
 =?utf-8?B?bTMvM0drZmdzZWtvN1RSeVBKc3JhYzJmczQvRFNKeFkraDRUQlBYZ2NMNGdG?=
 =?utf-8?B?eXg1NlJxc1VSa3ZKMkM4clBtcEowNENCUVZ3eGRNdWxDMFdBcllxTlp5cUdJ?=
 =?utf-8?B?YkRPM1BucjZvQ1UxTWJFODBEa0ovMU1DWVcwdVlRbGdqNUFid09JQU1EN0xp?=
 =?utf-8?B?SkdpeVozWVNJSmx2eXpHYU1CSWlMcUFTdiswRG9rTnVZdVQzSGhiYWZQZnVm?=
 =?utf-8?B?aDdrM2ZjSUJaTGExbWlyWmVpRkdNTFpQTlo2M29QQy9HSERUYTltSmFDQ3E3?=
 =?utf-8?B?YVdWSUFrMjFQUkRnamkzdkNQTHFJdnNTTkExaFNKZjUySmFMRi9yM3BqY0NM?=
 =?utf-8?B?VmhiZ21GVythTzJmVUFwNGN0TnFVblJrSzJ3OGI5Qmp4WnQ1OFJzQ0grdHdY?=
 =?utf-8?B?N3pISTN4YURHZHpZT0FNV2ZLRC9ZT0kwa1VNbHFFRDJLbEFQWnRlRlRTbGN3?=
 =?utf-8?B?MVZxT2VDRHF4YTRNWkhrVzQ0ckZ5OVRiSjErVmo3dm1KamkrL2h0MjdXdVoy?=
 =?utf-8?B?L0NwQzcvRC9QWEk4eXM3cFBWejJmQVpRSkpXMm52SzVRaDI4dkxIdDBwbDVC?=
 =?utf-8?B?aHdUdVYyRWVGM2MyZ1FBdVVORW5sSW0zTzVOQnJHenZKeThhMFE3TVVXRkdX?=
 =?utf-8?B?bzJhbzJZOUtjWGwxeU9vaWJ4OXNHNWQxZFNBNUhQRSt6Y3I0L2Z5Vm5ycG5x?=
 =?utf-8?B?cXFKUG1kWUl1am9NN2xna0ZZQmx6WVVCU2dqd1hVNHYrN0IyZWxjcWlQanlx?=
 =?utf-8?B?Qk9RZTVyeGVKaVg0YW15NEdrUW9sckFzWEs3Vk9xb1RoWHVtRngxdFJ5OHRJ?=
 =?utf-8?B?dWJoWDhWRm1xUXIzeWQ5aGNtb0txWnI0cnVjVGoxS0JCbUtoUHRicG94Tkls?=
 =?utf-8?B?QmtXcjJPaitXY2hBbE5kdDlKaEZtUzZTOVovYXh6eVFSbTk0bUJtZkJBVHgx?=
 =?utf-8?B?bFUrRlNSVFhKdG9DS0pubmlFTmluM3ZTdlB2SW9wTzBMM1FxdDdkT0tEa2sz?=
 =?utf-8?B?SnJCejFULy9vQnJXR1lNak5vYkZFTGFPdWtoK3pSM0ZtaTRLNkJOZFM2aDNx?=
 =?utf-8?B?TCtab2FFWUF3bHY2UWduUlA0dWRNSkR5NTZqUUhnbzBaMk9mRms1UG8xbnEv?=
 =?utf-8?B?QkMxbVBpR1RUSG1TYUh1WHluMFRPNEt4K3diMGVuVzZUV3ZQejVxUXh4RkI4?=
 =?utf-8?B?YWprdHVFQzBMK0JLelErU1loa1ZMd1BSaWo2YkVGcW9QZUVPZXpoYmZIUlp2?=
 =?utf-8?B?TDRka000NUNDemJRQzVycWRRbk5LWDBOdTFGNmczLzBZaUplREJLMlR2WTJk?=
 =?utf-8?B?am5ZWG81S3MzQVczOXdFZDVKZkg5S29qbGRKcmJXY0pWSGJiVGxib1VwMGdT?=
 =?utf-8?B?dHZGMXRGTmVUdWZQQnpRMXVPbDVsV0NRRkU0aU1JaVZPQm84cTgwbDYydndy?=
 =?utf-8?B?RFVrSiszNE41bHBTWUxZM1h3WXpZN3E0OThMdUVTeDJMMDJFM0hrTnp1TFV5?=
 =?utf-8?B?dFJqU0lqMktOTHAvemsxMURWU3lqbVRCTjM1aFJtTmhBMXVKTzdacExmNE92?=
 =?utf-8?B?WVBkaXpVMWR6a0dZelNoKzlGRVpEVTdjb0lkVHBXd25qYnd5Z2ZDWjk2bThJ?=
 =?utf-8?B?eS85UTA1eDhvNXJqbVRhQXhLaHllQjdVNDF4dXdMUTFKRm8vTjZpblFHZDZw?=
 =?utf-8?B?aXQ0NEVRamdBZUtjTzdIYVg3VHBZMVBzY0dwN1I5VDFheU5OMDN0TDFBUldH?=
 =?utf-8?B?OFpUR2x3OUxJcUNjUmMwQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXRwRnd2dXV0V2laMy9NMndGcGh0SS9FNjF2aHpjQytzOXN5anAvQ25wbmhq?=
 =?utf-8?B?TzZFQXZWckt3Ujd5aDNMUUY0SThRdnpaWXIyOHluYWlUeTg4NzBUaWZvWWtw?=
 =?utf-8?B?eE9qclJScERIRGc1TnNFbVRiUG91Q1NOQkltKzJsbDZXMHFMQW5yUEJSa05w?=
 =?utf-8?B?K3JIMFhIT0FoTWdnb28zMWsvUGJGOUxNZ1lXa2hBb3VvQlpLbElyZlUzYytW?=
 =?utf-8?B?NkZFck82QUovckREUCtHb3ByYTQ4U1RjcXZ3UEdXWkhtenNoQVMzMzhRUzRW?=
 =?utf-8?B?Y1d1Z0sydGJIdncwZTQ5MXZuUWJMeUNGM1Z4OGpJbXhHNmZlY2NZWXkzWUJR?=
 =?utf-8?B?NnNQZWg5SEthbmhWUVZCZFhqeU9ETFpNdHQ5V1BxblVRL21ObWIxSm5nYm9y?=
 =?utf-8?B?OW83dm9RaGVzQ0RpMnNkbStiU2ZmTHNaNEo1Z3dpWjhHR1VQa0tHRlE4MEov?=
 =?utf-8?B?R1F1Vi9ncTVFR2h6aFZVQ0lNTGpwVzUzYzY0YXZ3MStOMy93cEg2ZDNjK2Zx?=
 =?utf-8?B?cm45N2FXTFFLK0N2N2piZXhFWk1vWm9Ja2JJZmxhc0Zlcy9OZnhoVi9ZMlhC?=
 =?utf-8?B?eEhSK0xOazUydDdzZytsU0ZhYmZjWkliYkVFMHEzU2s1eUdnR0dNSDVBM1Jn?=
 =?utf-8?B?WDBTUTlHbytBM0tXWGVMbXpvalFSTTF6RzJJL245U3JnL3RuOHNMeUEwUTJ4?=
 =?utf-8?B?WEEycm9MaXUxeEJkTGE2RWtIRzlNdGlNOWNBTi81UG1yVi8rODN5SHF3S1k4?=
 =?utf-8?B?Y1BXRzVEL3ByZVJ6ZTJSc1djckFjY1FiRmxPYWVRY3dWZFdCOVJLMXBGem5l?=
 =?utf-8?B?Nit4VGY2RDMzUGlHMzJSOUk4Sm9jTFhuZVlpam9Oc2V1WVk3Vk5VNVAwZnp0?=
 =?utf-8?B?TlBXWk9sNWc5YmdnWDJXeitoY1hBRlcvVjJ0U1Q5dldoM3UzdndxTWk3Z29s?=
 =?utf-8?B?eFdBc0RRY2hJc2ZWRXpPdTdQMVB6WDlrWXY2aDV5YmNlc0JYMG9DeVhzRGlB?=
 =?utf-8?B?UVlmRldxU0NZT25yT0p2RWJhV3g2S1plUHdCWmo1YjBFdHY5MGtZcys2MVpm?=
 =?utf-8?B?TTA5bHVQWWNveDNZZ3BoUm5wWkM5b3B4bjVaZ2pacFBiUGg2QWxmeW4wNTJh?=
 =?utf-8?B?bW83eVV6Nk1ZNi9wK1UwdGJuSTdjTldDV2g3NGsrbHpuKzdBbjZuNjF2d1NC?=
 =?utf-8?B?cWRQb1B3Mkg1am9JSWVMVWlUOXB6YzZ2VzJJSFY3aGswZ0M2L1NhWDRXN0xH?=
 =?utf-8?B?NUI5QmlFQXZTRUI2ZzRPTHpNMzNKc1hKa3RWc2g4YmE4MjF2cG8vUjlPSTBL?=
 =?utf-8?B?L0pqQnJxaXdJR1JsakxUMnJTNWFhWkNXUVR5RXlxN1RwNlQ5eDhWWCtpK1NS?=
 =?utf-8?B?eWRTemxYRjVKK0xBcHpHd0xHWko5bHgzTXBSUjdCb1hkY2xQZURYM2lKYW1R?=
 =?utf-8?B?YTJUNE1KUG52ZGNUcUNiSkpUcXpRSXpnSkRrT0JYZVFRVVpPZDcxakJuMGEv?=
 =?utf-8?B?ekZjVjJ1ek00dnFxR2Q5bXN0d1EwWkdaZmkwLzEyWTFIclVZMjg0elVTaHhW?=
 =?utf-8?B?MnJWVEN3enhWcjFFWG9xNXlINDd6Q2dYZ2Z5UmVKcDBlVk9rOGkrQ2YyMDR2?=
 =?utf-8?B?cFZXMHpPeWl5ZEJBdHY2YkpyOExvV2ZhTTB3N0s1ZUlHVllacjVYd0dWZkV3?=
 =?utf-8?B?c05rQUdlRFhaU2JMOTV6UHlxZTJoODRoSWNzSll3UWdxdFJ1MHVldjcvVDl5?=
 =?utf-8?B?emdwd2VVbmw2RURrUDhKMG9qTWsvanQrVDFxTVZpT0d3RUUzVjJKcmx6OW1U?=
 =?utf-8?B?Q291bkEzekQxaXd2Skt3NXBUVlE5cGdITGdoZTRqTzBMd3hITmhDbEcwbDd5?=
 =?utf-8?B?a3hDQUJRWERJUzBuZkRSRTFJWEVmNy9ya0RGbjhLaVQ4bjRlSDFOWmdmUjVN?=
 =?utf-8?B?ZndrMUFGR3FpSTZCYnM2MmI1ZDU3MzVUeXZFS1c1cXphdzdVeXpBRURsTFpW?=
 =?utf-8?B?bFExRzMvcStDcnpEbHpqaFdZdUljcEdXNVdNZGtPTXJ3OHNKQ29UTWlYc2R1?=
 =?utf-8?B?U0tIL0JiTWFFR2V1TXprOEowQlAvaE5DcG1FVTM0MEtTaUhtak1PVllaL3dI?=
 =?utf-8?Q?Xs5wSxp1TKGUiHVYCVoGK1/SL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf4a9bc-a859-4869-5d42-08dccdca7b58
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 16:47:53.8101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpxuHCZKr9PHmFpEVMOCKlgMV6qI02137itFTLHMtO3+X9q8/izi4Vl6wfTVRCxbX3rrx4FS4/15b0Uunj9s7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948
Received-SPF: softfail client-ip=2a01:111:f403:240a::626;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 27/08/2024 20:54, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Add a basic support for receiving device state via multifd channels -
> channels that are shared with RAM transfers.
>
> To differentiate between a device state and a RAM packet the packet
> header is read first.
>
> Depending whether MULTIFD_FLAG_DEVICE_STATE flag is present or not in the
> packet header either device state (MultiFDPacketDeviceState_t) or RAM
> data (existing MultiFDPacket_t) is then read.
>
> The received device state data is provided to
> qemu_loadvm_load_state_buffer() function for processing in the
> device's load_state_buffer handler.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   migration/multifd.c | 127 +++++++++++++++++++++++++++++++++++++-------
>   migration/multifd.h |  31 ++++++++++-
>   2 files changed, 138 insertions(+), 20 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b06a9fab500e..d5a8e5a9c9b5 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -21,6 +21,7 @@
>   #include "file.h"
>   #include "migration.h"
>   #include "migration-stats.h"
> +#include "savevm.h"
>   #include "socket.h"
>   #include "tls.h"
>   #include "qemu-file.h"
> @@ -209,10 +210,10 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
>
>       memset(packet, 0, p->packet_len);
>
> -    packet->magic = cpu_to_be32(MULTIFD_MAGIC);
> -    packet->version = cpu_to_be32(MULTIFD_VERSION);
> +    packet->hdr.magic = cpu_to_be32(MULTIFD_MAGIC);
> +    packet->hdr.version = cpu_to_be32(MULTIFD_VERSION);
>
> -    packet->flags = cpu_to_be32(p->flags);
> +    packet->hdr.flags = cpu_to_be32(p->flags);
>       packet->next_packet_size = cpu_to_be32(p->next_packet_size);
>
>       packet_num = qatomic_fetch_inc(&multifd_send_state->packet_num);
> @@ -228,31 +229,49 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
>                               p->flags, p->next_packet_size);
>   }
>
> -static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
> +static int multifd_recv_unfill_packet_header(MultiFDRecvParams *p,
> +                                             MultiFDPacketHdr_t *hdr,
> +                                             Error **errp)
>   {
> -    MultiFDPacket_t *packet = p->packet;
> -    int ret = 0;
> -
> -    packet->magic = be32_to_cpu(packet->magic);
> -    if (packet->magic != MULTIFD_MAGIC) {
> +    hdr->magic = be32_to_cpu(hdr->magic);
> +    if (hdr->magic != MULTIFD_MAGIC) {
>           error_setg(errp, "multifd: received packet "
>                      "magic %x and expected magic %x",
> -                   packet->magic, MULTIFD_MAGIC);
> +                   hdr->magic, MULTIFD_MAGIC);
>           return -1;
>       }
>
> -    packet->version = be32_to_cpu(packet->version);
> -    if (packet->version != MULTIFD_VERSION) {
> +    hdr->version = be32_to_cpu(hdr->version);
> +    if (hdr->version != MULTIFD_VERSION) {
>           error_setg(errp, "multifd: received packet "
>                      "version %u and expected version %u",
> -                   packet->version, MULTIFD_VERSION);
> +                   hdr->version, MULTIFD_VERSION);
>           return -1;
>       }
>
> -    p->flags = be32_to_cpu(packet->flags);
> +    p->flags = be32_to_cpu(hdr->flags);
> +
> +    return 0;
> +}
> +
> +static int multifd_recv_unfill_packet_device_state(MultiFDRecvParams *p,
> +                                                   Error **errp)
> +{
> +    MultiFDPacketDeviceState_t *packet = p->packet_dev_state;
> +
> +    packet->instance_id = be32_to_cpu(packet->instance_id);
> +    p->next_packet_size = be32_to_cpu(packet->next_packet_size);
> +
> +    return 0;
> +}
> +
> +static int multifd_recv_unfill_packet_ram(MultiFDRecvParams *p, Error **errp)
> +{
> +    MultiFDPacket_t *packet = p->packet;
> +    int ret = 0;
> +
>       p->next_packet_size = be32_to_cpu(packet->next_packet_size);
>       p->packet_num = be64_to_cpu(packet->packet_num);
> -    p->packets_recved++;
>
>       if (!(p->flags & MULTIFD_FLAG_SYNC)) {
>           ret = multifd_ram_unfill_packet(p, errp);
> @@ -264,6 +283,19 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
>       return ret;
>   }
>
> +static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
> +{
> +    p->packets_recved++;
> +
> +    if (p->flags & MULTIFD_FLAG_DEVICE_STATE) {
> +        return multifd_recv_unfill_packet_device_state(p, errp);
> +    } else {
> +        return multifd_recv_unfill_packet_ram(p, errp);
> +    }
> +
> +    g_assert_not_reached();

We can drop the assert and the "else":
if (p->flags & MULTIFD_FLAG_DEVICE_STATE) {
     return multifd_recv_unfill_packet_device_state(p, errp);
}

return multifd_recv_unfill_packet_ram(p, errp);

> +}
> +
>   static bool multifd_send_should_exit(void)
>   {
>       return qatomic_read(&multifd_send_state->exiting);
> @@ -1014,6 +1046,7 @@ static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
>       p->packet_len = 0;
>       g_free(p->packet);
>       p->packet = NULL;
> +    g_clear_pointer(&p->packet_dev_state, g_free);
>       g_free(p->normal);
>       p->normal = NULL;
>       g_free(p->zero);
> @@ -1126,8 +1159,13 @@ static void *multifd_recv_thread(void *opaque)
>       rcu_register_thread();
>
>       while (true) {
> +        MultiFDPacketHdr_t hdr;
>           uint32_t flags = 0;
> +        bool is_device_state = false;
>           bool has_data = false;
> +        uint8_t *pkt_buf;
> +        size_t pkt_len;
> +
>           p->normal_num = 0;
>
>           if (use_packets) {
> @@ -1135,8 +1173,28 @@ static void *multifd_recv_thread(void *opaque)
>                   break;
>               }
>
> -            ret = qio_channel_read_all_eof(p->c, (void *)p->packet,
> -                                           p->packet_len, &local_err);
> +            ret = qio_channel_read_all_eof(p->c, (void *)&hdr,
> +                                           sizeof(hdr), &local_err);
> +            if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
> +                break;
> +            }
> +
> +            ret = multifd_recv_unfill_packet_header(p, &hdr, &local_err);
> +            if (ret) {
> +                break;
> +            }
> +
> +            is_device_state = p->flags & MULTIFD_FLAG_DEVICE_STATE;
> +            if (is_device_state) {
> +                pkt_buf = (uint8_t *)p->packet_dev_state + sizeof(hdr);
> +                pkt_len = sizeof(*p->packet_dev_state) - sizeof(hdr);
> +            } else {
> +                pkt_buf = (uint8_t *)p->packet + sizeof(hdr);
> +                pkt_len = p->packet_len - sizeof(hdr);
> +            }
> +
> +            ret = qio_channel_read_all_eof(p->c, (char *)pkt_buf, pkt_len,
> +                                           &local_err);
>               if (ret == 0 || ret == -1) {   /* 0: EOF  -1: Error */
>                   break;
>               }
> @@ -1181,8 +1239,33 @@ static void *multifd_recv_thread(void *opaque)
>               has_data = !!p->data->size;
>           }
>
> -        if (has_data) {
> -            ret = multifd_recv_state->ops->recv(p, &local_err);
> +        if (!is_device_state) {
> +            if (has_data) {
> +                ret = multifd_recv_state->ops->recv(p, &local_err);
> +                if (ret != 0) {
> +                    break;
> +                }
> +            }
> +        } else {
> +            g_autofree char *idstr = NULL;
> +            g_autofree char *dev_state_buf = NULL;
> +
> +            assert(use_packets);
> +
> +            if (p->next_packet_size > 0) {
> +                dev_state_buf = g_malloc(p->next_packet_size);
> +
> +                ret = qio_channel_read_all(p->c, dev_state_buf, p->next_packet_size, &local_err);
> +                if (ret != 0) {
> +                    break;
> +                }
> +            }
> +
> +            idstr = g_strndup(p->packet_dev_state->idstr, sizeof(p->packet_dev_state->idstr));
> +            ret = qemu_loadvm_load_state_buffer(idstr,
> +                                                p->packet_dev_state->instance_id,
> +                                                dev_state_buf, p->next_packet_size,
> +                                                &local_err);
>               if (ret != 0) {
>                   break;
>               }
> @@ -1190,6 +1273,11 @@ static void *multifd_recv_thread(void *opaque)
>
>           if (use_packets) {
>               if (flags & MULTIFD_FLAG_SYNC) {
> +                if (is_device_state) {
> +                    error_setg(&local_err, "multifd: received SYNC device state packet");
> +                    break;
> +                }
> +
>                   qemu_sem_post(&multifd_recv_state->sem_sync);
>                   qemu_sem_wait(&p->sem_sync);
>               }
> @@ -1258,6 +1346,7 @@ int multifd_recv_setup(Error **errp)
>               p->packet_len = sizeof(MultiFDPacket_t)
>                   + sizeof(uint64_t) * page_count;
>               p->packet = g_malloc0(p->packet_len);
> +            p->packet_dev_state = g_malloc0(sizeof(*p->packet_dev_state));
>           }
>           p->name = g_strdup_printf("mig/dst/recv_%d", i);
>           p->normal = g_new0(ram_addr_t, page_count);
> diff --git a/migration/multifd.h b/migration/multifd.h
> index a3e35196d179..a8f3e4838c01 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -45,6 +45,12 @@ MultiFDRecvData *multifd_get_recv_data(void);
>   #define MULTIFD_FLAG_QPL (4 << 1)
>   #define MULTIFD_FLAG_UADK (8 << 1)
>
> +/*
> + * If set it means that this packet contains device state
> + * (MultiFDPacketDeviceState_t), not RAM data (MultiFDPacket_t).
> + */
> +#define MULTIFD_FLAG_DEVICE_STATE (1 << 4)
> +
>   /* This value needs to be a multiple of qemu_target_page_size() */
>   #define MULTIFD_PACKET_SIZE (512 * 1024)
>
> @@ -52,6 +58,11 @@ typedef struct {
>       uint32_t magic;
>       uint32_t version;
>       uint32_t flags;
> +} __attribute__((packed)) MultiFDPacketHdr_t;

Maybe split this patch into two: one that adds the packet header concept 
and another that adds the new device packet?

> +
> +typedef struct {
> +    MultiFDPacketHdr_t hdr;
> +
>       /* maximum number of allocated pages */
>       uint32_t pages_alloc;
>       /* non zero pages */
> @@ -72,6 +83,16 @@ typedef struct {
>       uint64_t offset[];
>   } __attribute__((packed)) MultiFDPacket_t;
>
> +typedef struct {
> +    MultiFDPacketHdr_t hdr;
> +
> +    char idstr[256] QEMU_NONSTRING;

idstr should be null terminated, or am I missing something?

Thanks.

> +    uint32_t instance_id;
> +
> +    /* size of the next packet that contains the actual data */
> +    uint32_t next_packet_size;
> +} __attribute__((packed)) MultiFDPacketDeviceState_t;
> +
>   typedef struct {
>       /* number of used pages */
>       uint32_t num;
> @@ -89,6 +110,13 @@ struct MultiFDRecvData {
>       off_t file_offset;
>   };
>
> +typedef struct {
> +    char *idstr;
> +    uint32_t instance_id;
> +    char *buf;
> +    size_t buf_len;
> +} MultiFDDeviceState_t;
> +
>   typedef enum {
>       MULTIFD_PAYLOAD_NONE,
>       MULTIFD_PAYLOAD_RAM,
> @@ -204,8 +232,9 @@ typedef struct {
>
>       /* thread local variables. No locking required */
>
> -    /* pointer to the packet */
> +    /* pointers to the possible packet types */
>       MultiFDPacket_t *packet;
> +    MultiFDPacketDeviceState_t *packet_dev_state;
>       /* size of the next packet that contains pages */
>       uint32_t next_packet_size;
>       /* packets received through this channel */

