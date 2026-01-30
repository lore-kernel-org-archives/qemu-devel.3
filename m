Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9746AE6BF31
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 17:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vls8s-00048L-7Z; Fri, 30 Jan 2026 12:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1vls8p-00045d-Og; Fri, 30 Jan 2026 12:18:43 -0500
Received: from mail-northeuropeazon11022082.outbound.protection.outlook.com
 ([52.101.66.82] helo=DUZPR83CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1vls8o-0004qh-1x; Fri, 30 Jan 2026 12:18:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKqI5RTtHNdeN6cJxDd517bm1Ar3iNFkw2S0aEGzkK9/PqpI1ZKRza1H3/5hITKOpkryVR8AfxVBTk8rdTDJDf9n6M3SkjOjydKWY6gHZeeabmMd1KPtp+cbjdcOEpURHmJkNFOF8HBDgAtjCFyGcDgxqSyPTAKdz1X76WyJpt9LH8RuWByCyWtT5Il+GCTZ43VG5Y1dHaE/4IDc49QYK5i/fhs0QvpmX4/rOuod46OtXRc1mUoo653JgnwvLi9DRnXVW2q3CCu4PxK5mm8H6JcnDW29tPV2+yfzqwM8DN9TcO3bHA5mck9VqI4ES8bYfmBWL6pEB6hMixEbcuQ6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3t1vf99HwH7yaBxFlROZEWeLVNbhC/VC+CL4t6PJZ4=;
 b=sFACbWwp0KsVEInoGyzdbhGmoJi2uC5X1+/DPYRpOPMEeuYIv2tgpJwcWlNsK+77fdOfNEVhFIE9x/kZ3zy9WOOdsjr5TjAx9X2tw3imkyMX8OxVg3X5NHNJPSgBMV2AqLPFU2Uw3qD8NUC43otNeMZ/K/lhfx6ZsMMJejD/6rkALKjTBrPdkPxOu1OpGO/cqLHspQ3g1mdk6upPdo5SkTSWiqUMLNWt0DSstf3eXaIJwg3TvL0IeXjtbpU1TfPI6TOwvF6osxxxeMvnTxzN/fLtG20XFsJj2B6tx1nkCyO3Vls5NW7vbiOzaB8K2P1smpidEK+x9j8d9B7jP53hJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3t1vf99HwH7yaBxFlROZEWeLVNbhC/VC+CL4t6PJZ4=;
 b=Phsg3/1Se9SJuDKy+ahlzZAMO3W4S2a6XnF8AmCK4RlStN43b3JrazV/vpmMEf5XHX8G0gFfpildDO/d5aDHEaqZ0nRzCYHt31tgUvdEdWsr8OJq5O78Fui5azwENw56dJa74RJJusKU1PMPgYQBu2HXWhMDjzK+V1T0j2ORkSuSvuCEqSBn/38AHVQeecse5ryklrxtIfGBLZNcobUjtL3Qi9I0jVYrxyBY+ZmaF+SN9O9JDmJlEzv2dVA+ACOQ18xieyDkvMQusI+NzgDCGDzDhwADcPzHILKwMZFKzIFEek3Wv6O7SJOCzMG8m0jO403y9rHjCvA19DrX+OgpQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PAWPR08MB11160.eurprd08.prod.outlook.com (2603:10a6:102:46e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 17:13:36 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%4]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 17:13:36 +0000
Message-ID: <00d3a841-dc8a-49d5-8342-8a9dd20f90fb@virtuozzo.com>
Date: Fri, 30 Jan 2026 18:13:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: move bdrv_advance_flush_gen() earlier from
 bdrv_co_write_req_finish
To: Hanna Czenczek <hreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20251229161740.758800-1-den@openvz.org>
 <20251229161740.758800-3-den@openvz.org>
 <f3736856-2dc8-45b0-9c20-b49799aa8d35@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <f3736856-2dc8-45b0-9c20-b49799aa8d35@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR04CA0054.eurprd04.prod.outlook.com
 (2603:10a6:802:2::25) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PAWPR08MB11160:EE_
X-MS-Office365-Filtering-Correlation-Id: 23774535-455f-4608-a5e0-08de6022e766
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajkwVkFxLzYrdWdsaFcwZURnNlNUbTRrcDdKK0FuakpEMWR5Ti93aGZqclRN?=
 =?utf-8?B?aWNKTGZ4TEMxVFlZaGk1YnhacFVDb0dDZVUwWjZjMXRqNWFTMjBVTWNubkFK?=
 =?utf-8?B?YlgxbzUwdlM4SzM1SEMwYlpyTXhwV3JWbGxXMHFVbWoxSkVLMW1BMDJEdVky?=
 =?utf-8?B?OUk4ZEtmZk9UdDZTc1dSRDM4ZUpwRUMrNElCSnRjem9oRUlKU21IWFdackha?=
 =?utf-8?B?azNRTVJyOW5JM0d4bHg1U0hIQzlNOEJUTG5iZ2V0b0huSmpVWGMxZVJKcXJa?=
 =?utf-8?B?THN0SzBXbFZvY1MyU3dzWlFjRlBlMG9wTHlYaE5lTU9mek5OYkM5eHA1bVJS?=
 =?utf-8?B?SHhaMUdPbkVOd2hpZllkTVJtQmNTdWI1V1pPTEs4NHFBUjdlZ1VtWnZuazdB?=
 =?utf-8?B?cW16Q2FSVGxFV2lKT1VWSEpQTE5lb09BT2ZiQ3kyUXRiZ1BOaTF4Tk9uOEdV?=
 =?utf-8?B?cTZENU96dHhjOUdSbTlsSGRtQjhrOTNiSXhQVk5OQUtSUUdPNEY1eGptdmk2?=
 =?utf-8?B?MUoxc1U5WkhNMy9TVnM2dVRNM1Q2Q21LZi8zM1F4RTU0OXlRWE1qRTAwNVQw?=
 =?utf-8?B?V29oM1FLOXJjQ1ZNZWVVTzRsVThhL2dhc3gzem9IcEgxSW1YaWxXbnU5RE5G?=
 =?utf-8?B?YmV3SkRpVHpVU1RuMGxzcWNEQmJJSk9DaCtPQ3JqZUg2M3ROTUFkQjBuUzdE?=
 =?utf-8?B?b3F4cWFFb1RHUlN2MjUwOTRlRjRUNHpWT0llK3FQL0x2L0xiZVFqYm5obW9F?=
 =?utf-8?B?TjdUZFlQY0RacUVpb2h4aVhIVmpVNmxoYk4yYkFNOHdvOGcxOC9HeTM2TEJV?=
 =?utf-8?B?c2RHWDNBV29CMzh1bDBUWm5uM2tIYldBYkkvcmJINUIrVDdiQWNWMXNvK0dI?=
 =?utf-8?B?UmRoUmhpZUIvalJnS1ppSXRWSFY1SHgrakE0aFMzRDgxQVBSSk0vcmpSYTdQ?=
 =?utf-8?B?Z0dpQWwwSjhNbmNtQlBnUzU2cTdvYTBaa3lDaU5sMW9ZMEdCSjRHeHJJTjNr?=
 =?utf-8?B?Tk5NQnFtcW1nN0xxMXZ1b0tFUVFQd2dvNGt3WklUcE1xc0lkdFJTMlV6UFVR?=
 =?utf-8?B?ZmRkNnFBZk0zOUQycm93U3dwSXZXZEM2ejFIY2xkYVJwTFdOUE1rcjlDeFFi?=
 =?utf-8?B?ODVyQVZkTW1yckZUNFRGaXNuT2VpSGZscURVS1dYbDZIR3Q2eDd0RWtOU2Qw?=
 =?utf-8?B?YmhqRWIySmVWTWZEWE5EOHNWd3ZkSWhLbWdCcGJvSUoxVE9KWlE0QW1MYmcy?=
 =?utf-8?B?TERmOEFoZTlMSENOa29EYjZ5enhSbVhBZDQ4VnhvZmw4MGtndS9tR1JZR2xw?=
 =?utf-8?B?Yk45NG9oVElGbjUzQzErY1hCSDI4U1BoWkxsUHlRUnFjZEZNN1lHV3ZrNTR1?=
 =?utf-8?B?S2VaWU5aTkdJWTROTGxIR3NJR1BGdko0Tnhzc3BZckhsb04rNlhYdGhIMENH?=
 =?utf-8?B?MVlWdFpyRDY2V0JvY1RkWTZiM3BkMlpueWlWR3BTZEZ6bjVVb0pTemFCK1RQ?=
 =?utf-8?B?MEVBaHFTUkhpeXdMdE9LVC9jRkJjWlhQWUIxMlhZd01WWjN1SDJoTm5kMm91?=
 =?utf-8?B?UDJWV21TVWNseWN0dk9UK2FrS3o3SWczS1dhZ2pZUGlSUTZYdHBhREM0QlMr?=
 =?utf-8?B?M21YWXQyOVNHU2dyVEtiTDBDWDB5WjRNUkdCT2ZScFRNMVNNQ3l5NkZVdkli?=
 =?utf-8?B?cUg5cDJ0R1M3djQ3cmEvOUl6bXJCcjRiZENWQms4ZXBzam82UnZacFFyQWdL?=
 =?utf-8?B?VkdEZDd3Qm1yN2JLdmVrUE1BUVZlM1ZIeHV4Y2hZZVNiVVYyWGVNRXNKQ2hy?=
 =?utf-8?B?MWNEeDJBUXVZZnJiZy8wWU5WbDdGM1BKN1VickU4L0UrL3ZycDBVWGJyTHFD?=
 =?utf-8?B?Y0s0Vk5kMlBsakp3OElWOHFmK0YxZXNMV0ViU0U2R2V0LzRadHlXcnZ6MmQ5?=
 =?utf-8?B?dlZqcU9LUXgxWjkzdUJTdk50OWdsZ2NKeEVKVStNZWY2SXdXTlI3Wm1zK2hi?=
 =?utf-8?B?dmlMMDdwMmQvUzNoUDRzTFdROHpBRGZGTThiUWVPRDJmc0ZEQzlXZkIwS0x5?=
 =?utf-8?B?V3pwNEJXOWxUcmZ3dDZvQ0E5L1FUZ1gyKzVIUFlKaW0xQ3M4eEJ6eEM5VUFH?=
 =?utf-8?Q?vXmw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aS9PdlhLWFVhOVNDVkVlaVdQdWtWTUo0Y1JYOUp4STNxUlN0T1k3WkdERVpa?=
 =?utf-8?B?a1hZSWx2YTl3QzA1aXZvOVhrTk9uR0J1NlFYNUVxbmxQMGMyMVF5MlZJalB1?=
 =?utf-8?B?Wlc3R085QUl6bElKbFpEa3RWN1pLYWJFQUsxWEIvMmNVZVQ3UW1jSlBySE9Z?=
 =?utf-8?B?RE0zMmxyVEpscnVML2N6dnR6Y2szWDJwSDVqT0g0QmlMZmVSRU1iOWpNaUYz?=
 =?utf-8?B?RURUa2J0QXBGLzBYaUgyWDZ4SFJ3Q0VWWUtCQWJEWFFZOTd0MlI2RGxQVUVn?=
 =?utf-8?B?YzJQekVYcmVoVlREQkowNWZueEtpNmR3Tlo3ZlBrblI5SXFHUEIwdjV3REMw?=
 =?utf-8?B?MnQ4RGVybWozcUtVZk93NXY2TlovRXFLQnhwV09yK3BuanI4ZkNmdzVJaHB2?=
 =?utf-8?B?ZTNIYmU3SFNldlRRWW1SbUNxbDdOYWZ0MkFXM0d0ZHVubWV4RnFGNFl0THpL?=
 =?utf-8?B?cTMvMCtwWTdZWHlKdVRCaWtEa0l6MHNnMi9UVjBUUVkvYlI3NXlQaG9Tb1pU?=
 =?utf-8?B?aGtJMDROUjc1RGdKNmtROE9hQ1V0eDAyQW5NblczR1M2bWFzRnM0L040b2pv?=
 =?utf-8?B?alpWcU12ak5WemNpbUhKQkNIN3N6MERyMWUzdmk3S2NtWkJZYnp4TmM1ZEVB?=
 =?utf-8?B?WjdkV1dGS00weXdaMlVtVVFCL3phaVowc1A3OWNwdXQ5azJmNkk1Y0N6aUFF?=
 =?utf-8?B?R2ZNekVXZHBUNHRIaGtxOWNIYXUyMGFxKzZnRFJja3d1TnpkQ3F4RkdhazdH?=
 =?utf-8?B?ZWoxTTZvZU9rSml2dUNxbFdQdlI3Z3VHZjYwa3A4SUdMVWxnSU1jeHZNRy9G?=
 =?utf-8?B?d2JnNmRiNFFkVHpGSVNaazB6R3JqSDYxUmxNeThMcVc5K1Y4ZVRUclVyRFcy?=
 =?utf-8?B?ZmswMTFtdjhIQ1hKVVBvVWhDbzF5Q25QSDNEUXVXMlBEOHlTT2ZhUU45eis3?=
 =?utf-8?B?ZEZUUm9PYXV0aTltb05TdHhhMUF4ZDdjT0JuQm9IRS8wUnA0UTArODJBRVZI?=
 =?utf-8?B?YllxVWdSYVVlKzc4T0xtcTNXYWlVRE9YVUZaQ3dRbitiK1hZQVZ5bVZUbzda?=
 =?utf-8?B?L1RzcFRNY0kwem1CVWN2SUlqRVJza2E5b0lOVU1FRFZkTmNOMENlL2tqSlFV?=
 =?utf-8?B?ZlFkcWFmS29SeVlYSy9iYk94UE5NWmNZMkZjS042emJySkdPZS9vN25YVVNK?=
 =?utf-8?B?NWhSb1lOdEN2OG4yQUZkMGFSR2QzYUc5Ly9xZTdSWHNUYXlDa3BqZTk4Q2Ux?=
 =?utf-8?B?Zm5vdkxXdDBLN2pwVzJoTEFmSXo1bnJmQkQyY2ROZ3ZxRnFrWlBadUVHYWIz?=
 =?utf-8?B?RnA3c1lqTnZ2UXlNSk1BbDFEcmo0dFAxNjhzMjNSUnhDTnBnSmpUR2tvN0FL?=
 =?utf-8?B?a3J2NWFCdm1DL1JVU3VQZXJsN00ybzBzUW9sMlAxQjNKUWExMnJxaGNNdjJD?=
 =?utf-8?B?UHJPSmZRU1VsZG0wMllqWGRudjg5SUpZSk1mbUt5S0lXVDh1WEcwVy8wTDFv?=
 =?utf-8?B?aXIvcVgrUXNYZUc2K1ZLdTlpQllCN3NmV0tUK2NiVG5CdHJ4bmdZZDRuU1Rh?=
 =?utf-8?B?VGVoMkVBWnJEbDFKQm5ma1ROaUpVS2JkTUVmUnpZZUpGaElKYzBYdUEyempu?=
 =?utf-8?B?M04vaHB2RmRqMGdERzJra1l5dDV3R0VVQkNXNjJ5U3hIK1BOdndBMlQ2dE9q?=
 =?utf-8?B?YVJJVjdrOUVJUkJ2cmVvZFNRMFExbE90MDBmVlRlbDdFcXpLNkloUnlNS1pN?=
 =?utf-8?B?ZlVwK0RPeUFJZDg1Uk1GaUREcEVuSVNYMVZJdlZoUXRLRU96eHhaa3c3U3VP?=
 =?utf-8?B?bDFFVzFSTFhldjBjNi9Tc3p4QmhvUjdtMTFpeG1ncmdaTVo2c21yd2JXcEYz?=
 =?utf-8?B?VGFnQXlHYmZjL2ZaOVRUT214VWgvTjZWV2RzV1JsN3BUYXVyNlkzdE1kNGtH?=
 =?utf-8?B?MWNZMG9INFc5TkdsdUtodzJ5Y0hzM1l0S2dZdldlOCttMHlGT1lBRldpa01D?=
 =?utf-8?B?VWdSb3dxdlJZclNhN3dWVzVERXhubzhMV1RYRVNMckE5M3NzVWpINThsZEw5?=
 =?utf-8?B?QlV3THVVK0dDODVNbXp2NEZHYjNzRDJmdmlhaGRRNG42OWJvQmptU0dLd2Rn?=
 =?utf-8?B?cERGM0U0SnVxMDMzZ1BmUzlSM3UzVDgyNmQ3YmppYXpEbFZyNEpVT1pKVW05?=
 =?utf-8?B?RUk1cHl1Rm12SUp0aWpTaTdmcU5wYUFXZXJUdGQ5eEpFWStDc00xNmw2d3gw?=
 =?utf-8?B?R2hlSjZZR3kyMVhkMmtmTFlYZWdqZTZIbXhEbDJ5M2xKZDJHUklGcWRkSFBR?=
 =?utf-8?Q?EdkJveDzfQ/hFw8IPj?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23774535-455f-4608-a5e0-08de6022e766
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 17:13:36.2348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOqUdKEt+tOukXYjIFqTi0uXf8PW2tSia91wvPXcoXs04KWfBMvaYly0jbj2imr0ts1wyAmEEW+W/6KlU4hhPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11160
Received-SPF: pass client-ip=52.101.66.82; envelope-from=den@virtuozzo.com;
 helo=DUZPR83CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/26/26 16:07, Hanna Czenczek wrote:
> On 29.12.25 17:07, Denis V. Lunev wrote:
>> This helper is mandatory to be called before bdrv_co_flush(). In the
>> other case bdrv_co_flush() will be noop. This helper should be called
>> after actual write is completed for subsequent flush to perform some
>> work.
>>
>> Actually this change is important, without it BDRV_REQ_FUA semantics is
>> broken completely. flush() is not called. This smells like potential
>> data loss if somebody relies on BDRV_REQ_FUA.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Hanna Reitz <hreitz@redhat.com>
>> ---
>>   block/io.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
> Definitely an improvement, but if possible, I would still prefer keeping 
> the increment it in bdrv_co_write_req_finish(), because that is where 
> all write requests eventually end up in, and that’s also where dirty 
> bitmaps are handled.  It seems slightly error-prone to manually have to 
> call this every time the BDS data is modified.
>
> Can we maybe instead pull the FUA emulation out into 
> bdrv_aligned_pwritev(), after bdrv_co_write_req_finish()?
>
> I think we can only pull out the flush, not the FUA emulation detection 
> because for write-zeroes, we have to check either supported_zero_flags 
> or supported_write_flags, depending on whether we fall back or not.  But 
> bdrv_driver_pwritev() and bdrv_co_do_pwrite_zeroes() could return an 
> need_emulate_fua flag via pointer parameter, and if set, 
> bdrv_aligned_pwritev() can then do the flush after 
> bdrv_co_write_req_finish().  (This would also allow dropping both “only 
> flush once at the end” blocks.)
>
> Maybe it would then also make sense to move the bdrv_co_flush() into 
> bdrv_co_write_req_finish(), and add a need_flush parameter to it, so 
> that it can see whether the whole request (write + flush) was successful.
>
> Hanna
>
I have tried to think about this problem in a this and that way
and found yet another missed place in the code. This has
frustrated me even more.

For the reference:

raw_co_prw(BlockDriverState *bs, int64_t *offset_ptr, uint64_t bytes,
           QEMUIOVector *qiov, int type, int flags)
{
    ...
    assert(qiov->size == bytes);
    ret = raw_thread_pool_submit(handle_aiocb_rw, &acb);
    if (ret == 0 && (flags & BDRV_REQ_FUA)) {
        /* TODO Use pwritev2() instead if it's available */
        ret = bdrv_co_flush(bs);
    }
    goto out; /* Avoid the compiler err of unused label */

This definitely states that the code is cumbersome and you
right that I need to try harder to move FUA emulation out
into generic code.

I'll invest more here.

Thank you for the point,
    Den

