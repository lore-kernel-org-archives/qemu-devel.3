Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBAE4E8FDBE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 14:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaEM7-0000gi-89; Mon, 29 Dec 2025 09:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1vaEM3-0000fX-4J; Mon, 29 Dec 2025 09:36:15 -0500
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1vaEM1-0005eC-3m; Mon, 29 Dec 2025 09:36:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4ZlndFC2R7STACFn1BJiQpKxGWoCW8w6TPi8hDVpVfbRqOOpfCp/ijFfYGHHs7EEDYN+oR5xtmH0V4bvoKwynmKmv6stVT11ewPb/i65AlCc1+aklzbRmX1jrrCFhntYV+5Ck1um0b3WJb4IQwmjGE8AWgmiPs6B0iA9hrkJrBbWKhAGd3nV4vKwkeZq6TKIhRFO7MsBQrlaYvYdBDCm5y/8EUj+xCltGKYRset+1eVcYsagyvq+NvTlDOj+bF4r+4VODfxXbkxjaZjaR1+7uagbqie6NKh4UpDlMpj2MfRwCZXF8y07A9f35NSOw03Gwfj2jFUTJr5zi3TrXAW+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxfo+Q+wc4Hkc55ZdSzJub1za4w118nDT6n/YjXQb+I=;
 b=flAV72EXgsAv0UV7miIEJy0yxCFieZqhpvfYaY/k2B8YGDbmyUvQ3a0ux7XNjvJ04AtJS1qniR70uDNpKfbQgjZeSFmuG9ufFtyvizwBJs5c0aqMRV1rWDNAC/L5RkejYfCAvrkJMwHY5Rqi4PjZBDFAAmrzYDWQcKnXxVNmFnyysCPE2SFzgIqqj6BX74GyfEKuvL3SNCxOIfnOGY/w3iuNRcOQBFj9ljebqrZdCKx65ovHOIqb7r1HdlI2KCEJ8Zd7BRrCa95qlspC6UM6BOGIW2Ilod3CPlFCA18nt+LjChiZb1/m7lk4aFKBNNY5S9mVRb8GUkDLzSus6YbPKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxfo+Q+wc4Hkc55ZdSzJub1za4w118nDT6n/YjXQb+I=;
 b=M3KHzKlwvGikiktn25wOLLDeq2z+8RCB/Dq6DERVEya0wDS34xdu24IRbXObl4kXMPi5mioDplZvkKBrTDVR6MXqJuwDqEYKmcwDTS4VvToFrrUjIaba3jz4tqD+JnGBsNrAUtv/NHUvT6GnivO98BJH9xWbQCf8O5T+2LKeLT/Bp5yPTATAh2Hp83BplqW8CzQuKPF5TH8vnZsZyYVOG+3iwMzXAyr++b0kanhtXokSaxo+T3fsdjQoJLlyxbRU6F9zvGJu9jIOvUerx87pchD0bSknJAibIGFmO/qn81piFEcJCB5IgDKHBZ3Y8mnOyFBoeXxAaWzJlLVvqEPyig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GV2PR08MB8027.eurprd08.prod.outlook.com (2603:10a6:150:77::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 14:36:07 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%7]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 14:36:07 +0000
Message-ID: <e3003fb4-e18f-4181-a00f-b8901a8c0f76@virtuozzo.com>
Date: Mon, 29 Dec 2025 15:36:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] qcow2: add very final sync on QCOW2 image closing -
 BDRV_REQ_FUA processing is broken
From: "Denis V. Lunev" <den@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
References: <20251219180813.1000884-1-den@openvz.org>
 <62286d8a-eb8b-4753-984e-1e294d96529b@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <62286d8a-eb8b-4753-984e-1e294d96529b@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0011.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::23) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GV2PR08MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c52e45-c187-4fdf-864f-08de46e79a3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1Q4eWhhZlVxVW9RTCt0TDBTaHlZVWpLSFNxRXQ5UUtFdlB2Mmc0ZVF3SWpK?=
 =?utf-8?B?cGNaN3pwTElFaEVFaHhXbE1OQzNHcm1CQWl4T0NlTUhJdWZNRnhCNUhnZlpi?=
 =?utf-8?B?UnNOTkF1V01EeitKRnppMWNJOXZsV29hUFdxeDlUL08rL3JnUjM3d1RvR1ZC?=
 =?utf-8?B?UkN5TUhnaFVQcHlwM0xnQUtPSXFNdmFTM0c3MmxLVzRJQzJ1NVIyaVoySVNa?=
 =?utf-8?B?N0VTOVgrY00zWk5uQ1FMMWxiVVU4RzE1WDBoK1V6bHVuRUdxY3didzZINzla?=
 =?utf-8?B?QUpkdUxrQlc3TzV1a0FuZU1CNVR0OTdwS3NCaTQrQTRZbzdLM24yVHJlRWFn?=
 =?utf-8?B?dmdnNEVGUnRkb0xhK1I5aHFYQVBweW1qSm5KMG5YclU3Y0tUQnR1RjRORjhY?=
 =?utf-8?B?Q0lOc1plOUZpeE04TkRPdGlHM2tIa0RKTjBERDcxZEN4SnVlZzRpQkc5NTMw?=
 =?utf-8?B?dW1qSG84V08vUXhTQjZvb0FycDN1c21ZWHIyeHYxYzl3T3NkWVl3azRPM1JT?=
 =?utf-8?B?K1Z0NnRJNGliWTl2YngrekgrUCt5b2pUc0wrMzNhRWw3WE1PZkdMTm54K2VZ?=
 =?utf-8?B?UkxiaGpCTjZFWGZLNW54STJIQ0UyV1NMSlRoUHRlWGNlNnZOTCtHcHJhb25i?=
 =?utf-8?B?UWpYV2M5K3ZydU1GeU9wamFzeDRXTFhkR25CY2VCSnpoMCt1T1dZVlVGU3Vs?=
 =?utf-8?B?T2JYUnpnWkpJVGcvQ0h5a2h3T09rd3NWVnpYV2xTQkNQemFxbVhVYXlaZ3Qx?=
 =?utf-8?B?QmN0OHd0RlB0NUtWRUJCVE5NVTU4SzVNTklMZjZaYkt4UGdwaWVkMVZ1NnBJ?=
 =?utf-8?B?Tkt1cDNuVm9jZ0ZrNGphWEJFYWlnUE1uRnB5ZU1JN0dOT09RckMrTmhsN3dp?=
 =?utf-8?B?eEpVT2hsY2l6S0t4TnhSNDgvUWhSVTExSTc2cXRUZGd3dzhpSFUzdFV4Z1g1?=
 =?utf-8?B?Tm9ZMHNjdER5NkoxaG1wNDFEbjFNbE4yYkYyaXpOQnk2TGs3bEhocUdFWUxQ?=
 =?utf-8?B?akpQRUc2MEpjS3IvMnBHZHJMWXZqaGp1OURDVUs5ei9EOTU2TU9XMzBCS3Nq?=
 =?utf-8?B?VFcrZlRqM0lzay9BeDNEcEUzMElMcEs2WjRjRnBnaEFlZHErZFdlbURSZU0w?=
 =?utf-8?B?K2Q4TVNrT1l5NzNrWW1Icm5YNjVtUXRhYkJVK2QxRjVDNyt5NTRNejIrRHdL?=
 =?utf-8?B?U29vM25peVdsd2ZvVWdHTEVWekFYWHlld05lQkozbGNLd3g4OEJ0SU55bjdw?=
 =?utf-8?B?OTR0N05ZWm9UR3lUczF3YjNqT0pjY3NLdjJKY0ZtTXZEbUtGQlpkdjlaZEhP?=
 =?utf-8?B?NjFVNmRnL1BySnhCamJZbkJRNXZlcC9xRjNaRjBIN3pSWlRaKzlqL3h3bkVp?=
 =?utf-8?B?eG1oeUtyVFZuRXNiNHpXNUp6V21INm1SVnRseXppZnhoTWE5M3NSYWlXVEhy?=
 =?utf-8?B?SHpHeVAwSUNhWWRiVjVqeTlTcmpGZ1duQmxBQUs0QzlBSUUwVERpcGxsTnJH?=
 =?utf-8?B?OEIwbS9FMEpCTkFFckF0NFZIUWhXenowQ05EN3R0TWcrL2Yxb2tHYUNNUzlP?=
 =?utf-8?B?VlNHM0FGQ21ZUklYVnZaUU14RDhBS1g3RThoaExKZC9HQTBQbkhPckttMlpU?=
 =?utf-8?B?VWkyM00veXZBVW5pTGNWVFlMd0hnbDJmR0NTMndMajJWcFY0bHB6ZlFMdWNj?=
 =?utf-8?B?RzNaREo5Z0k1TUxyaGU2MXVnOUR4Uk1RSzVOSWI3VHBrOEt3eTFLRERWMHpa?=
 =?utf-8?B?bWFpaEJFZDdZR05qQXUrT2ZjcUJWSGNZT3hmQnpaSGpINFYvU2Q4RzdxSngw?=
 =?utf-8?B?TTBGeVVjQ1liendtcy84QkVPUFhpQWV1M2FieUFGOGVjUFdCamJDbjIyQ2w5?=
 =?utf-8?B?N1pMWDFaM1pmcTVJelZ6dlZNN0NBay9pZ0I4bUhsUmNjNTJFV09CdFg3dE1T?=
 =?utf-8?Q?0fxxrF9Snu69l0Fp7zoEoGWk6vIZouFq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnZ6K01OcTNUQ1ZTT0RKQnBPUHpHWEdFanFEcm9EOVpBSEFaRGJwcElWeEFV?=
 =?utf-8?B?eG5CWGdrSDlYWnVxdmxrK3pweUJ0Vi9ZUERobFdIWnpES25BY3huR29jT0Fm?=
 =?utf-8?B?NlpHUmVsS2JGL0RDVkx3RmtnTUFTYlpYRmFSZmsyWGlBVXVHWld1Q2t1dmpF?=
 =?utf-8?B?LzNqNUZXc2wvMzJEaHZmdlVCbUhYbjFXUXZmbC82N2hNdnVUMTVuTEFYUTk0?=
 =?utf-8?B?VjlxMTV6NG1JbDh6OUFsREk3NjVxK2FxYy9sMXlOaVByUHd2OEFGNXlzSWx0?=
 =?utf-8?B?TVpuL1NzNWxEOWI5MWx0OGlPcXc2U0lQc0lSTlNKZ3JqNUZmeUMrVnJqTVIx?=
 =?utf-8?B?MFpNMW8xb2ZwUjltVVdxbWRnMDYvanlGUjVmdmh0RHpVaXZCNzVTaWdGTkNk?=
 =?utf-8?B?Q211di94TXdKeVJlL1ZCYlkzRmV4SE15MVdWWFk4TCtxT0N2b2tXOWRhWGxx?=
 =?utf-8?B?TE1TY0Fsa2d3dVB1TE1nQWJMck1lc2dQM2NPOC9HYllTWGxGUkVUV3RKTUlZ?=
 =?utf-8?B?ZXlyN2k0L0cxak5xVVczQzV6OUhpREN6SzR4Mk1iWnJpd2QxL2h3a2lCWjRL?=
 =?utf-8?B?eHFPUXl2RkZWTDFiSVU2dW1rMlRSVmp5MUZ1S1Y2bzNyQUFHenpRcDdHbnJx?=
 =?utf-8?B?anFhV2hQNlg2UTlIdmFKamJYOVNWVTVFTXo0NjBYYytWdDhOYThkcElNaVRV?=
 =?utf-8?B?ZlYvUStLdXJFZE9GRnZsODExaFloaUlZSEljOFo0cWZydDNacHUwT0FDU0xn?=
 =?utf-8?B?aVBqSHlSZUNmZjIyT2tMRWFkdi84bEJEcVJsNHMrNW16NVRZTkZEc3dlUXFo?=
 =?utf-8?B?S1RwUVJiSEN2QWhPTk5FTlhiRzVNdTNobHVQMmZSQ3F1NVFtcnZuTVpzd1cw?=
 =?utf-8?B?OCtPbll6TElUYi82a1BFei9GaFZpNjNQMS9HWDNlbExScjZFZXhJOXBNVmsx?=
 =?utf-8?B?MWJYK0x5YmZyaFVjUDU1TXJGd01UbVlTcGhYRzRYMlZEUFoyaHJFcVBub1lL?=
 =?utf-8?B?NW9iblhQdmNwRklPZ1I5c3ZkKzFOVVpMZUo1b0F4SnJDQ0xsSWdxSm02TXBy?=
 =?utf-8?B?TmY1aGlBK0hFWmx6ZjhNNXJZMjdkS1oxUFdSYWRiUS80NW9oa2hoUWt4VmdF?=
 =?utf-8?B?R0liczJ2Nzh6VXNHR3lpUlhqN3BGbDIyWGZKbnpYYStBbEtiYTBBZVNDSnVm?=
 =?utf-8?B?STBzakNtRlN0cExKVmMvOWlrcEZ0WXZqQzBob3Z1eGFFWDlJU1hKZFdxRXpP?=
 =?utf-8?B?NHgrWTFhSTk0M1pWZUg1aDdsK3ZqRFdPR09xM3d5T2wrQVdOWXZ2dENyTDdt?=
 =?utf-8?B?SDRmSDY2RWNZVVMwQmdzT0FEM3htVitpNkxJTVljTURoakkzZi8vSlV3dVNZ?=
 =?utf-8?B?WmJUNlhNeEVjYmIyZXBHeUM0M0YvUWdHTkFqbmc4bDlVMndkSG1IVWlRMnN6?=
 =?utf-8?B?bENXdTNKMjV4UGZCYkl3M2ZVQVpDRHA5YlNoUWlsVS9XM0N0SGZoYmVmZ0Z6?=
 =?utf-8?B?bUR6cDZaalM3dUxxM0NGWFA5d2xMZWkxcTFhMGlGNi9YTHJKSzhaOHVKQjQ0?=
 =?utf-8?B?VUFROHcwVHBla3JpbDdETEpmVTgzb011Zyt0T0lRbVQxZ0VaYWE5UVQ2UHA4?=
 =?utf-8?B?cDNSeVJsQkduYXhoMUpaNTlMbEk5aWFvcnRWNktQMURINm5VanhBU1FzUExO?=
 =?utf-8?B?Wkw5YmJDOFE0K280VHphamVDVm5QRTVTVjlNY1BmM2kzREphSHZ2WmJodUJi?=
 =?utf-8?B?UHFLck93RVFWeUxIV29QenExcVJTMkRQVzY5WXBCUE5pdjJFaXJSMzh5bEJ0?=
 =?utf-8?B?ajBqdmoxbU1CYk5NQkd5bUwxZFc3M3IxWVcwSnM5K1UvMDlpTkY2LzhJQTRN?=
 =?utf-8?B?YmlNZ0tLMy94ZlQzY1Rpd0VyeFZsWmJ3N2JScGJEQkV0akF0Y0xZQUtiYzJN?=
 =?utf-8?B?aHlYSUdsSTRaWGx6ejV1VzhTNkFyeEJ2cnBVaE9Vc1dvd2NFWityaEloZjB6?=
 =?utf-8?B?UzJwMXQ4M2ZPcmVBWkhLRmpEV0J1cGU2K3JYbkk2cEN6dzd1TWZ1dEJYTGJ3?=
 =?utf-8?B?LzJaeUdaekcxS2l4ZGdrSEVHenlWMll4U0FpelIrOXdXMU92ZWhDaHVjRzcr?=
 =?utf-8?B?Y1U3Qk5LemlmNXA0SFk3ZmVIWTBKMCtzTFVmSUZ0K3JlZ3R5SlJEQmNWdmZJ?=
 =?utf-8?B?QzdMV1JxTE91YW1DZUpjQ09wTzdFQjE2M0w3bVJHeG9FakRqOHBNZXd1ck81?=
 =?utf-8?B?UWREMHdYeFU2TkVBL2FQWmNDK2UrVkN4NkYyemdzaTBlWWRpelJVWFlldVE1?=
 =?utf-8?B?T2ZqRGZSVklaR3VOTjVRWERiRlRRcitvUWhHU1NaK3hOQVBwVnZJZz09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c52e45-c187-4fdf-864f-08de46e79a3d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 14:36:07.3400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hefRRqN4Wa6MX0wZNW9Qv4pFyyOGjze6p3yN7I4GuxEC7bLJtg2YSjC44vgUwhaS9phqHW9PXTXJXHYcS3UbiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8027
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 12/29/25 15:29, Denis V. Lunev wrote:
> On 12/19/25 19:08, Denis V. Lunev wrote:
>> qcow2_header_updated() is the final call during image close. This means
>> after this point we will have no IO operations on this file descriptor.
>> This assumption has been validated via 'strace' which clearly confirms
>> that this is very final write and there is no sync after this point.
>>
>> There is almost no problem when the image is residing in local
>> filesystem except that we will have image check if the chage will
>> not reach disk before powerloss, but with a network or distributed
>> filesystem we come to trouble. The change could be in flight and we
>> can miss this data on other node like during migration.
>>
>> The patch adds BDRV_REQ_FUA to the write request to do the trick.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Hanna Reitz <hreitz@redhat.com>
>> ---
>>   block/qcow2.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index e29810d86a..abbc4e82ba 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -3252,7 +3252,7 @@ int qcow2_update_header(BlockDriverState *bs)
>>       }
>>   
>>       /* Write the new header */
>> -    ret = bdrv_pwrite(bs->file, 0, s->cluster_size, header, 0);
>> +    ret = bdrv_pwrite(bs->file, 0, s->cluster_size, header, BDRV_REQ_FUA);
>>       if (ret < 0) {
>>           goto fail;
>>       }
> (attempt #2, mailer has rotten the mail. sorry).
>
> Thanks a lot for Andrey Drobyshev who has attempted to review and
> test this patch.
>
> The patch is non-working due to broken BDRV_REQ_FUA processing in QEMU 
> code and this looks more severe than the original problem. bdrv_pwrite() 
> endups in bdrv_aligned_pwritev() which internally calls 
> bdrv_driver_pwritev() -> bdrv_co_flush() bdrv_co_write_req_finish() 
> Please note, that bdrv_co_flush() is in reality noop until bs->write_gen 
> is incremented, which happened only late inside 
> bdrv_co_write_req_finish(). This means that BDRV_REQ_FUA request will be 
> flushed only on the NEXT flush operation, which is definitely wrong. Den

(attempt #3, mailer has rotten the mail. sorry. Finally get it working)

Thanks a lot for Andrey Drobyshev who has attempted to review and
test this patch.

The patch is non-working due to broken BDRV_REQ_FUA processing in QEMU 
code and this looks more severe than the original problem.

bdrv_pwrite()  endups in bdrv_aligned_pwritev() which internally calls 
	bdrv_driver_pwritev() -> bdrv_co_flush()
	bdrv_co_write_req_finish() 
Please note, that bdrv_co_flush() is in reality noop until bs->write_gen 
is incremented, which happened only late inside bdrv_co_write_req_finish().

This means that BDRV_REQ_FUA request will be flushed only on the NEXT
flush operation, which is definitely wrong.

Den


