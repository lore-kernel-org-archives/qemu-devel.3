Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C5DC5321D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 10:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh5W2-00085U-QB; Thu, 22 Aug 2024 06:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1sh5Vz-00084J-U2; Thu, 22 Aug 2024 06:58:04 -0400
Received: from mail-db8eur05on20706.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::706]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1sh5Vv-0003EG-Fi; Thu, 22 Aug 2024 06:58:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhIwyVnbyIVVklaM2LJAOJ/hKdqIo+13NW9mDFumuULZEzCjOvrxLmopNsFrAcMfYixopCDP1XcNnwe6Geyo0g4OvrKZsYlf5lrXLfNd2/2653bFR7pPbCpZP9N6liOhLdhTU5RsWmjaUtSqQmfoXkg6sgeNRWo2/IouxWj7zCWrBHUrXPVf7WNOkkGUazV+ZlnB5wPLofpQIJoCFI51Dq6e2+yogBoQqpEdvNqGrOHe7tWi98lBMVbwOeUO6Sn23PcXLsJrvdScCUGP4MLgaqqqmACVlihNLUnOz/susuFHtT451LEyjrExsM9peisPDfcN6CqkgWDZR5b3ooOeVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTygBMJl5Lls9Vg52jGXOE537r5fwQTQ0v541wLc0Lg=;
 b=MEe6JD7gO+ohDfFs+PD/RexUy/BOuIUKVFg7uhL9HglhLCxZLzw1CsU9dPxh2J86zcp6ln73W14agpkDRXSwe6oMRk9ddAIRR5OHvnAxudaS7Ood+NNFCmCs4xv9qBeJBvm7KQ0X2cMh1/aKOOnHIY+IUI0ZabAymPemOtu0/h/qA1IBFr752T82n+zIjy9pf94SoLlfXdt42+LmNu/Fznj4txPpJx4H+O4rxdG2qVozBriw8oCVZBFNB3l5mQxmY5GnCb1sxl9xbOA2NbBhm7al4gU1JtHqLVTQP0CtMnB8sR3PZL1C/xpjMCDphXad615M5QxY13tmfv12IVGLPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTygBMJl5Lls9Vg52jGXOE537r5fwQTQ0v541wLc0Lg=;
 b=Hp3LyLm/VqTNasz5eZn2ZjIPoyjWVGV988B33Abhnxex/J+BxLJNcV3HrT62UqNUEalhQbe+e8tFs+/tSYGnpo4YLAMsM2Ns7joeDuTOUAoTTA02Q0Bcg7N+VOJ2qFh+7ANTBPZZbPOdhOmBOznwqIykQKt7Du+nzU512mT482gVg4JQebx2CeC8sTxZzJ8xuc5QllxXnWVl4UH8Q56ky8pJuPDwAWxBZM36DGIDIURmKpqgCcz12NvGiwMfLobU3MCGDUVBokJBUHQwN/45OYwHhBtZRjHNVuG4xaBadWAdLyAjzhunGQEoc2G8iu1bVJEVKBn3LkY910i0bcj+3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by PA4PR08MB6269.eurprd08.prod.outlook.com (2603:10a6:102:ed::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Thu, 22 Aug
 2024 10:57:52 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 10:57:52 +0000
Message-ID: <da45bab5-510c-436b-a971-8946f3049a4d@virtuozzo.com>
Date: Thu, 22 Aug 2024 12:57:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v4 0/7] CVE-2024-7409
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 qemu-block@nongnu.org, andrey.drobyshev@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru
References: <20240807174943.771624-9-eblake@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20240807174943.771624-9-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0127.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::11) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|PA4PR08MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: 43be1997-6c28-4622-b73d-08dcc29944ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OE9mT1ZORU9jdnlmNGRTNEFYQ2FncU1DTENHeTFvVmdTSndTUVBXTmFNVkxX?=
 =?utf-8?B?VzQxeGd3bit0dVRFdGdkTXQzblY0djliNFVVWlNOSlJVQk5tN2x2YkVLUHIr?=
 =?utf-8?B?NXNEQVhGK0xrdkNCK2hVelJPeXJBcXlUZncvZzFyV2NuUS9mczkrRnRST2dk?=
 =?utf-8?B?T0ZNdGNzeS9md3d1YWZ1R3ZDVFk0Y0xZZTNlSDJSZmNzMVNla3JZWE85bm1h?=
 =?utf-8?B?N3RscDlSSUQzRzZvL2h6bVE5djVnakdrcm5qd2c2UjR1WFEzcHZDeTRnZzNz?=
 =?utf-8?B?V3RMVHN2R2MrUlVqdVdiK3I4dzRHZjRMdjY5bUdWZld2WVVaNTdrMTNkU3o1?=
 =?utf-8?B?SXVnOHUzRlZpMlMrZ1I0ek5lOGNxaHEvMk1IR3JaUWpkbjJhdSs5V3d6b3RT?=
 =?utf-8?B?ZmZnMGcwYTVBMWpUVXhHUDRCT1UvSWo3QmppN3hFOHVjeklCN2dNNlU4QWxw?=
 =?utf-8?B?aDJHRmxhcWw5ZEY3U3dCZDlKcTg5dHNNV2JISmVHNldNdGRiV29sUGlGNEJp?=
 =?utf-8?B?Und1M01pWTFWMDQ5RjF2WlRqakEwNnN2bTYrcHV4WDFxcGxhaHFzbUNYL1Zn?=
 =?utf-8?B?ai9JK3NyRklHa2JQMjZnczQxRkdURkFmT0E2aHpXM29ZbmxwM09NOVB5U0VR?=
 =?utf-8?B?YUoxRGRibTdPUEs1dXZRMzZqRVdQMFhHSVhucyt0ZFA1TWdrdHBncTZ4eExs?=
 =?utf-8?B?SG56eVQwVDMrRVluUWMzVk1JQU9jc1RBMXN1bHRqNlN0TEwza3FWWG13dE45?=
 =?utf-8?B?SSt4REN5N0pzQ0l5NWcvTzJlSGpmbXhZUXJoSGQ4UW1uQk1KdVo5WGt3VUY5?=
 =?utf-8?B?Q3pDZWdrc0N5SkRvK3EwSVNhTnBlT2hWNk8raG9qTk1RdGlRbE1tY2l2SlJG?=
 =?utf-8?B?ekVHdG10dHVEaW9YWlN4dTF0NldUWHAxM0h2YWdLQUdjUGJJZGJjQ1pHRVFk?=
 =?utf-8?B?RFhxWDlrdUZFZ2YvU3JGSjBOZUtFQkV5ZENHR0R5c016QkdZRDZHa0NyZ1Fi?=
 =?utf-8?B?WjdnZjE3RUgvMTF3Y2VpU0FueVdkUXliaWlDL2dMOWRKaXVHVTdaTWtlTjJW?=
 =?utf-8?B?MHVIbmtlTkpObEh0Z0NOczdmNnN0cTNrS005bVg3MFZpalpSWjlHSHlrLzQx?=
 =?utf-8?B?TllkaHVwcEtmcGp3b1ljSVBCVTdSK1JZS0habGcwZlhYanVndldjNitJNVNo?=
 =?utf-8?B?VTFNREUzOWtNeVROU082Y1Byd2QrQWxPUnRKWTQzRExVQzBWMmgvOXZ0eEcv?=
 =?utf-8?B?Z09OejZacXMwbDQycVJTUHV1NlI3Q2MxTUVlYzY4ZGp2UVIxdGVJd3JtZ3p2?=
 =?utf-8?B?UlBKL3hiUCtGalJ3TFdEbkVuckJFc2xxWlAva3BNNWt0bjJRaDZjRXc2N1NH?=
 =?utf-8?B?UWs1UC81WXA1bEttV1BCejM3UWF1MmVGVWN0U0l3b3RSYlBUM3RyZlJRVGJu?=
 =?utf-8?B?eFI3NDk2VkhXbXp4K3R4TnhoS0FKdUpKUW9FaExzSTNFYW00YWhSMy81UDNI?=
 =?utf-8?B?b3NFMGxFWWFDc2h4T0ZVWTg5NUp3b1pVdGZudDBHVUlwU1dxeGZBMGh0TEEy?=
 =?utf-8?B?K0lUcXVScWJGMUpjREFOQ1VNVU5ydnhaNXpyZG1NRUlLYTExZ1o3WUtRWUVx?=
 =?utf-8?B?dlV4Q1NjYjdsR2Y0ZnBtZmpXYUJQTHZ4bmJGMzNpdERvUG9EcGhVWmFSUWVW?=
 =?utf-8?B?Tk81SkFaSnJ5ZHo5VU1reks1WkYramdHcnlhTzZiR0Y0ODVQRzJ0WXJKSFJN?=
 =?utf-8?Q?9LSTZTYVReRNRO2YxE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHVLcVpyalBkV29ENmdzMmIwWnhoNUEySWFjdVJyalNNRy9neldMZVAwNURl?=
 =?utf-8?B?QmZ4R0lVU3drbndMdGNZcVVHMWNCZER5MmlaQmhSZy91YjdsanRicmxycm5z?=
 =?utf-8?B?M29rRVZGRnlkMloxUW9ZYVVMcWhxUjMwUkZOOFliZ3hQV25HdzBqZFlKOEYx?=
 =?utf-8?B?WllFN01sUzlDaUxNQllnZ3RUS09PV2wyWERJb1F3L0F6TGlmUUVqc01JS1Jw?=
 =?utf-8?B?SmNlVHJyMmhYUjZXWDVLVldGY1o5THR2SFh3cldQekNQU1lHTGpmVjFTL2JB?=
 =?utf-8?B?ZEdoZ0l6bjFSNS9Ha1R2Z0pWbGRlNzYzYXcxOFliRFhOWlQxZHllOWVUd0ts?=
 =?utf-8?B?L0JreG1BTkg2N1c3S2o3aTE0dFp3K2xod01ncFV2RmRTZ2NhbVgydE1hR0RR?=
 =?utf-8?B?SkRQQWlDKzZISFZSSnRNNVJJUXMwbTF4RDdmMU9BaDlOb3JhcTVKLzZqYkdN?=
 =?utf-8?B?RHpvU2VmS3J3OXdUOXdmYVF5R2paWnU4ZGVjT3ZjZmxiYnBidUUydEpjNXZF?=
 =?utf-8?B?NXlnb04wSVZPVU1OdjJhYjhJS3hNK0k4OVhkSnc4RnNnaVB1aVJQYzRsTlVr?=
 =?utf-8?B?WTVSMktBWFdGMG0wOUtMdmd1MVQ4RUFNcWEwTVg1SHRMNWpQcytJNVN5T1Br?=
 =?utf-8?B?TDVyWDAySHk4ZDkwM2g4eFVvRjdXZjI0ZDlSQ0xKUXFtaHRDQ0VoWml5V29Z?=
 =?utf-8?B?K2VEenhnbVNpSGNRWWRMV0lPMmNWT3pRRU14OUFicGpsTWdBbVBFV3NsQ0Z4?=
 =?utf-8?B?YTRlUTlZUnlIUVU0Zmpzb1l4Qmk4cjdRbk9raUxEaGtVU1JONEdPYldVZjAw?=
 =?utf-8?B?VjB1UjdHc29melBDNTNuZWhRemtDSEZpNXhRSUhOc1I4MnJEb1hDMDJORVFk?=
 =?utf-8?B?RDFzOExNa09jMFdGUk5GMkVmM0xUYXo1MjRKejFhZW4xTHpxYklYR2Y1Yjgz?=
 =?utf-8?B?aEoxbnpuYWloMjBvODhXS2pZRU10R29MSUExaEdaWGI3ZFUvUXo1QTJiMVI4?=
 =?utf-8?B?c0tFcWhUd3I4c1dOaHVvRDk4NHlBVjRldTMyN3hleld2Ny80bFdXcnN6KzJ3?=
 =?utf-8?B?S3lCdEJUTXFVMVJVWDBNVDBYc05scnNaeDFsK2haSDlzbG1OdWgwd1FDaXZu?=
 =?utf-8?B?Q2dtcjVwN1JBUFVUQTRmcmRMeWl2MzkrOTlRQXJMeGhsWmRHWmNUUmt6R2hJ?=
 =?utf-8?B?bWgwSlU4MnkvbUkvT2RlYXJyZWlwK3N3Uy91MXFGd1Zza0Z5azRldlNvYjlL?=
 =?utf-8?B?ZUhJV2JFU3FOSm9SQnRJU3JzeUUyb2xsQ3RYTXdQSGZPU3dtcGg4ZlgxT1c2?=
 =?utf-8?B?OS8vU0d1UndaMUxqb054cnJqVlljZ05uQ0FCVEE5UTFMZGVPbjJ6UTFoaFVi?=
 =?utf-8?B?ZEE1YjFybmF0K21jY3p6eWM5WTFYdWxFT3dlZ0t4ejNpdW1naHU1ZWZzU0gw?=
 =?utf-8?B?S2tNQXlpUjJrN1VHWGU5UzBacS9wWmtWRTdFWHNrZEh1U2tOZDRkQm5tcWFz?=
 =?utf-8?B?Sk5xR0pDeE5ZRkJLdXpnWGgzaGxlU2JtYit5US9qajdQRWZUWGVlbXRCMEV4?=
 =?utf-8?B?TjViOEVNUHU2ZGFELzd2REVCd3hqS2t5aGdpR3R3dnEwbjdqM0g1ZkZhNHdz?=
 =?utf-8?B?b2Y5cDQwTEhjRWpPbVNxdFkvK0EvNXB5UEJLYTlqNkVaUDdUWjFmWHp3aVN3?=
 =?utf-8?B?aHVsSjJtSEU0SFBTK0M1VXUwZW9wdVJYaW1SQjJHZ1RqTGJFTktrNGcvamRx?=
 =?utf-8?B?Z2lIN2hNeHRZN1phRllJQzJQZlpFVnJJV1VTVUV1bEsycmNhelZGYkdIdmVY?=
 =?utf-8?B?TkcybklMZkUvYVduditTR01FTDIzS2JaNUhScS94TWVzREE5a3h5NHdpczhV?=
 =?utf-8?B?a0VGeEV1UGdWWnN1NUVaNFBqd3FNSFdtcDlrSTNHejNPbkNzL2ZvQ1FBMXY3?=
 =?utf-8?B?QWtucE5WdnVwemNXTUdUd00xQVhPNUM1UDh6MDU4NWV3MXFVWm1MUURTb3cr?=
 =?utf-8?B?M2E0ZDQrOGJVWGMxek4zTmhvaEVWaldlWm5WSXlsMVdrRHI0bStPcmdQbFJK?=
 =?utf-8?B?NnZVTElEY1pZbXZleU5FZm03OG4ybWhYbHJNZ2NpVVFlQkhudlZMQ3pxK3Bo?=
 =?utf-8?Q?pjpczNsmZ83yHnLzDAXfDYq9V?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43be1997-6c28-4622-b73d-08dcc29944ae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 10:57:51.9539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9Fh7pnnNhKSHhQa8XblMv2iKiFCn2bVAq1+lUrjaeDnLBZZlNA7wWIdmARIdupsV0Vf1LusCtp8VY+vhkhgkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6269
Received-SPF: pass client-ip=2a01:111:f400:7e1a::706;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 8/7/24 19:43, Eric Blake wrote:
> v3 was here:
> https://lists.gnu.org/archive/html/qemu-devel/2024-08/msg00818.html
>
> since then:
>   - re-add a minor patch from v2 (now patch 1)
>   - refactor how the client opaque pointer is handled (patch 2)
>   - add two new patches to prevent malicious clients from consuming
>     inordinate resources: change the default max-connections from
>     unlimited to capped at 100 (patch 3), and add code to kill any
>     client that takes longer than 10 seconds after connect to reach
>     NBD_OPT_GO (patch 4) [Dan]
>   - squash the connection list handling into a single patch (5) [Dan]
>   - two new additional patches for reverting back to 9.0 behavior for
>     integration testing purposes; I'm okay if these last two miss 9.1
>
> Eric Blake (7):
>    nbd: Minor style fixes
>    nbd/server: Plumb in new args to nbd_client_add()
>    nbd/server: CVE-2024-7409: Change default max-connections to 100
>    nbd/server: CVE-2024-7409: Drop non-negotiating clients
>    nbd/server: CVE-2024-7409: Close stray client sockets at shutdown
>    qemu-nbd: Allow users to adjust handshake limit
>    nbd/server: Allow users to adjust handshake limit in QMP
>
>   docs/tools/qemu-nbd.rst        |  5 +++
>   qapi/block-export.json         | 18 +++++++---
>   include/block/nbd.h            | 20 +++++++++--
>   block/monitor/block-hmp-cmds.c |  3 +-
>   blockdev-nbd.c                 | 62 +++++++++++++++++++++++++++++++---
>   nbd/server.c                   | 51 +++++++++++++++++++++++++---
>   qemu-nbd.c                     | 44 ++++++++++++++++--------
>   nbd/trace-events               |  1 +
>   8 files changed, 173 insertions(+), 31 deletions(-)
>
should this go to stable too? 7.5 score is high enough.
We have had CVE-2024-4467 
<https://security-tracker.debian.org/tracker/CVE-2024-4467> with 7.8 
merged to stables too.

Den

