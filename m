Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366EBC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6sxz-0004nb-6G; Wed, 16 Sep 2026 12:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6sxv-0004n3-9F; Wed, 16 Sep 2026 12:58:36 -0400
Received: from mail-northeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c200::3] helo=DU2PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6sxf-0003V9-RT; Wed, 16 Sep 2026 12:58:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFItHn+OgqvCTGNRAN5VeMeTEv7ZulSwWu6CR+3lKr/11DEOsdl6tJFjFUK0YAV+0zWJPmv54PAS/x3W5aLW1OYODjG/wQbmwHUfs7JGl3bDvGjhZx7NgJn0eb/FpUx1qkdqlQOO0l+L/bc5GCNLNkjqsEWNuPU+exwlFAyR9X0qF9+N+W3NLO3G3jL4DVbcd/M2VGs2qmDvZ9X1bsejOU97eo1Mx4J92EcDrY4iCO1YzXayrh4DgN8lex0/ylJRQP/4JSAkTGICN+p9oxkEvCR23KqZfGBHs4XJ+zNob4wgm7EC/MhYU3z8oCGo0c6uJnb5dObbMy5u/D7ISEXiJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMO164mVPpUWbJGQ+TFH6C2RVVRCcGk4rTcr/WGG79k=;
 b=Vv63I6C3NzQURMY4bkAIMWKXTf9n0ADxLfCZzQ7bgV9dFeqavsSFU1OeeRp8GU38/ax31AjsqSVuP/0yH7h8B5L2Sa6Q4A6Z1desv0CDq8TUH91V0ZKXEV7zFHhh7yjrjWvbWioTJlLnv2VKLA9wPg5mHwVZzDGd/IPk8QTJPzxRLVo5X+HhwFExsF7P+gtgTb3X3HB2KyrDWLuxDd5b197Ku8EEBu5gJwIEtE77JrLwP2XhshimT8ThsOrmSMy//TipF7ICK834XTInMr/smQJwr8kvif+rCtYnxhQXbZunboKCTJB4aQfKdFMQ1TOeLdQ6yj3WBsWQ86vPf117Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMO164mVPpUWbJGQ+TFH6C2RVVRCcGk4rTcr/WGG79k=;
 b=bcB0xzoS4y1nhOqx3QrqaDl08RD1+EKilczhEXPZsh02eW1m2zRFpo53d2MgTPKZDJEBb3RVltIKWz5OzeAM5rdeSzsBc1HtxH/lnqMqr4Tq+kYDQkDwATgJ1gxoTJz8tGX76WwewAM2jX+/8oV+pQkV4O1YATz0xs9TI4xS6pJRMwG7dcpfbRqfRhQiDF1vyDHmPduY9kqe9RtZPldv588pAGAIAumhPbGIZ5YDrm1IyB5/TbVdKmZ+0hu+Rkcg39ssm8t9x8ZCHqvSjnjJvYORrEAgzvLOit9DYLDjBtBZIbiFwlgU6fQ0zIivtFNs1Y4Nx/wJyb9bK1nP4N49vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by MMZPR08MB232099.eurprd08.prod.outlook.com
 (2603:10a6:190:3e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Wed, 16 Sep
 2026 16:58:03 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 16:58:03 +0000
Message-ID: <9644d356-47e2-4360-9dee-299c3e442fb2@virtuozzo.com>
Date: Wed, 16 Sep 2026 19:58:02 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] block/block-copy: track known-zero source clusters
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
References: <20260914145250.2792879-1-den@openvz.org>
 <20260914145250.2792879-8-den@openvz.org>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260914145250.2792879-8-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0084.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::17) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|MMZPR08MB232099:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d25e6ba-494f-4c60-b194-08df1413abf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FH+t4sJIwMq3Qe/UHP+hJiMzjbRBMfmludj4OMwjaAxLDCvmS8Rz/5xj3kityTIWZzdFrqj7DkUoCKisddpEiN3Yc7ZYPVjbu4k9NyhMQtFrO4rVN5h/kd6tzvGrBVsfLechBjKG763eEHENuZc8JH/jGznT/IvbvTLh81cYlOd/dcKUwOZMeGXonaifbpIa1GZ40Wsz4mCYa4/Z1X6x3H2zPp9WbPYr9aBJf7ZveHqSMhi1UnqVfX68prNOPZd0uo5dg1DSnIpR8cpzBT4BkSAOz/c+Sd7MTBIW2QpeNJcnVwmsIam08b75aAL2vbxctZ0Ihj21G0UMKO2r1xGm5QhupsW0xuRrPDxuPW5trXPX48IUZ4BdJoR06tSQepp8cXUi2+5i4WnwPKm4u7qWROZ3X8fB1zJQ/geFV0A1lTPhBXJh7scjjd5FQsoAtoHI/dJ3M+76BzjWLDZRRl+fEN8Uxz7i7achW0LQEqG3e8dZMIU7ZPb8MI/bDrWnCIrTQSwOJRQWYTMkF6W/oVlF464RAeiOCjpckcFlRIJZogOa/b3YG+jrs2wy3RqkPtETOXp9Aj3yjkt+NeogSP2T54ErNsJs4TvBPIbyqDZgfUlXT0vYyRNVwuI9KxRdRclhIiYh/FkypUNyxini1QqVmx60F5hcTaN7Y3kx28qgWag=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUxRRFdsUkFkTDZSNGRYOTlIWUVzMFd3cklNWVpiRS8zWUF3b05DdlEwdUcw?=
 =?utf-8?B?U0M5RjhNa213REEzK2dkcThjVGdMY3lxdWVpNHZGRHRvbkhoTThOUVV5NzUw?=
 =?utf-8?B?amZaeG5tUEQvUVY1ampSZGpac2Vvc0JNMU9uVURLYnFMZzlyRlV5NENsUEIw?=
 =?utf-8?B?K0pQMHVWUGdMems3WjY5b3p5UnZ0MFh0ckVDN1djQk5GSUF6dWc0UEZ4bE4z?=
 =?utf-8?B?eEdnaVZac0Y1ZXQwK2NlSjh3dWtjVmlLMUs3TmR6ZTdzOUJTa1lRdFgwaFVn?=
 =?utf-8?B?SnZjSjZUN2o5aVh2SENXMnBCZVR3ZkxZQ2tkcHFscEY1YThMcVVlQTFKem14?=
 =?utf-8?B?Y3JXNXhFemNsNzk5OFp6RHZWTjRZK2Q5TE1Gdi9ucHo5UE0vZVBCZm55dlVi?=
 =?utf-8?B?cGswaEpMY0pMU296bU02M1ZnVFVsYnFpZVRWd2FxTGNMR2VRN3BaTHVGRkY2?=
 =?utf-8?B?cWVLcFJlM2RFK0pjWUtHK2s4dzhqRjR2bWF3VXFDdzVzRXNVYXcwbmRjNVA2?=
 =?utf-8?B?VFN4ZmZkYW1id2Q3YW9nN0w4Z04rTVBTY1loUWFDempHN0hwSEc1MEtWZ05P?=
 =?utf-8?B?VktPbEhZL283bS9RVTYxZ05CZng1UGFkbXRnQXRJeTc2aHJJb1pYaVZuVlJW?=
 =?utf-8?B?KytxOGc2VkJDVmI5Y2w4Yk5jTm5vaEU2K2pHUmsrVkZRaFBjcjh2eTVGa2tn?=
 =?utf-8?B?Ukw0SDZDQ1R1a01qZ0NleTNWSGNEZjFOaGFWOS82VnRWSlFDM2hOamJrcEN2?=
 =?utf-8?B?eUlUNE5vMVJTSkpWcUVUTXFqc2NmWitTbXZnZHI5ZG41QW5LVnprNDFjbC8w?=
 =?utf-8?B?aHhOUmhzU2lMRUZUaytCWmFqaUJ3cXJqWlRYVjA1dEVZVEEvR3ZJT0lPaXlE?=
 =?utf-8?B?VkZkVzNjNThUeThnZkFNaFNxeStpdzV1akV1NDdod0FHQThNMk84b1ErYytj?=
 =?utf-8?B?QzJDUHFicGJ4QlZBM2RVb0RHMXZRamY1SEVaWExyWHZ3YTFWb1NTNVhXeTc1?=
 =?utf-8?B?a09jNC94TSsvYzgvMC9GSCtCWnA1aElXS040bklzZ1dxYzU2eFlzdi9JTGVv?=
 =?utf-8?B?eVFYdGVCNU1VNTEwckYzQ1BxaThUSmNJckRBaWRVTktTbVBlUU1YZGhWVzM4?=
 =?utf-8?B?U1JaeTlqdjhabWFDWTNxeGNRb0RBd3RoaGF3UFZRaWZMZERjR0Y0a0QyOEdp?=
 =?utf-8?B?QUNYLzVkOWRvemhaS0FyWitqTmZWV210ZGpBWGF0YVBRNGhXM2RVZ2RabUJO?=
 =?utf-8?B?ZEoycnRiWGdnUGF0MktsV1p5aEN5NUVNYndFUXF2akhYY1hqcVNOUFlRRWJY?=
 =?utf-8?B?aHludTZROXA0L082WEdBR0hkVHg2ZTRrZ1RkMUFwSGo3ZzJxVDhzaW5RNjQ3?=
 =?utf-8?B?dU1DQU1GUXZzTkI4N0drcGdBY2ZGZjU3bzBxZG5pV0l0Y3BEM3hNaVhFRkNa?=
 =?utf-8?B?ZmowaWVrRFRaSnhrbm53NnB4WnRyVmNqK1VDNVZaSHdlS21JVi8rNTkyOW00?=
 =?utf-8?B?azZ6Z25qSnIzdzdxcWZaOFI4ZW5yUCtOWEY2VFVlRUJSbkp5MDB0SDhwTkdn?=
 =?utf-8?B?anJqODZEbFZ3V05xR2NiUUs3U1pKU2pBaHFFUHVWYy9id2FvUVJSMW1TL3ll?=
 =?utf-8?B?dEMyaXZ6Y29MSzdmTU5GQTB5QmpYWWdMMGZXV0pKeWdhZG5zYkhOK0dsblNZ?=
 =?utf-8?B?aWRUdGdLSUlFMExzUHUxWE1PV2I2cy8vSEw4NzVKT0F3YTdzTFlUWG9pbitm?=
 =?utf-8?B?NDllTDdzNnhBNFZMYkNDL0ZtZUZXYXkrR3NGenNKclZ0aWV1RXlOTHRyYnBR?=
 =?utf-8?B?TVNBcUdFVFZDVmg5V3k2Q3d5TWx1K0w2K0x1TjU5WFZRQmdtWVgyRXkzZFFC?=
 =?utf-8?B?TUl3TFdCTFpBZnB6ZUdva1E2ZUJjNU82VVdNejlpdHhldkdzd3BHbFk1dkk5?=
 =?utf-8?B?R1o2TnRvTDZ3V3l1cXpuZ2dNcG02bVFOQklBMzhsNk1tTE5nc2djbE1rRXYr?=
 =?utf-8?B?MXFyVFUyZFhWbE9rZWNrR3g3WW02K2s4OGpFY0dvRncvL0dTMHdBL0lMNXJt?=
 =?utf-8?B?SUlSTVpPbHo0ZVZCbis3WVlIMXlJOFFwa0pabk1ZbFhScUVydnpGRDQxeG9W?=
 =?utf-8?B?R0s1aE1JaGVCRURKRzJHTEhoTkIyZXg3dzI5U0tqSGFOLzF5RWxRY0N3SkJv?=
 =?utf-8?B?ZGl2cW1uN3ZLVU9YcUZQbTN4bitoMnZWcmpBRFozK3FYWGl5ZjJzQ0dvQVEr?=
 =?utf-8?B?L0FIcUQrOWtVVndid3lEaDU2NWxjdFRnS1RKQ0VWOFdsSThHRUhYTmI1TzBB?=
 =?utf-8?B?dDk3ajZkOUZYVnBOUnQ0ODBySi9WTTNmSWpzdjRUZTRKNDhNYW1BVklHN25V?=
 =?utf-8?Q?2euIlP3Aca1LDM5I=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d25e6ba-494f-4c60-b194-08df1413abf5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 16:58:03.3331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yEfg/e4dxScbfdgrSGK/QHbvV+YPreDgenlIsUJZdN6etrCUCLaMyUtsCvryvDSyyb4wd9f/VXFztiyZCJsVk3ni38cus906rTxC5Wth/bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR08MB232099
Received-SPF: pass client-ip=2a01:111:f403:c200::3;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DU2PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/14/26 5:52 PM, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> block_copy_reset_unallocated()'s up-front scan already queries the
> source, and the same query reports zero-ness. The copy loop re-queries
> per task and, having no answer up front, can only size a task by the
> copy buffer, so a mostly-zero image is cut into thousands of pieces
> that each turn out to read as zero.
> 
> Cache the answer in zero_bitmap, published by zero_bitmap_valid once
> the scan is done. block_copy_task_create() then picks the method from
> the bitmap and ends the task where the answer changes, so a zero task
> never reaches into data and a copy task never swallows a zero run. The
> per-task query stays as the fallback until the flag is set, since CBW
> intercepts guest writes while the scan is still running.
> 
> [...]

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>


