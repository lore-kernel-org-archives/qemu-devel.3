Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092A2E77179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 18:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJcfl-0006sg-MZ; Fri, 06 Dec 2024 13:03:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Zhigang.Luo@amd.com>)
 id 1tJcfe-0006r4-BH
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:03:20 -0500
Received: from mail-dm6nam04on2059.outbound.protection.outlook.com
 ([40.107.102.59] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Zhigang.Luo@amd.com>)
 id 1tJcfZ-0002lK-MA
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:03:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVsgCzUNv6tSbIfSie9qcARb3n034tpezJwQrJJjc9MOusiST1prFhZWKrzjz55UORUxc3jL2ftEdxv0VinRrn+tm69ipGlFTKNeCmeRxQpCFx/An/+e8dh+XbsaT6JAJ2o0X5HkVaAp9XWQi+RnetU5MKxTRM6MfLGXoXI//q99NHXeomMNZBqpLdgXxyYnbwWz4C8c9RbOIYRTd5ykeUHCyddmRV68hn20bizNSieEqibgocMu3O4W2whehb9wr8mcCbRz0NqdEgQh9PADjnKXJv+xj4iYxhAen+v85QdIXIvRE+77GGNeNwTDBji2S1LA5VLBk67qAWDYHqioyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmC2uVXpkB4S/kgUwtxmUMJ5ywuZCqrrhFKoce5kMUk=;
 b=Vj7OrQKxnMXMzQ17TaEn3refMTYTRSx/ODTa7LEusFFfS5irb14hF8sWfyGLaKSDAbdAdVtdpC7L04NsYbF913zxDRHhwGssIQVUkIEi7pYOzRGK+Wa88zKlaWgTToR839UI9Kw9XZ8LTF85cYmriWCUuDN2Nb+xub/hjYwvMPQWAr7Q8XIt7rHkkK//c+gG/zsz9FKCGOFyad+UlddtJeHIJqhcGB1fqsxQQeD1d8xZjai7Pha5vEJ3ZYHWveHTVJZN+GuV2geXDmUyS9J40yQaSbEbLrYGieitdmi8NYQV+N537/rXEe2arA+ftxRzwXKNKS4Lnr67/tWFcK/EPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmC2uVXpkB4S/kgUwtxmUMJ5ywuZCqrrhFKoce5kMUk=;
 b=yk3XfyBEce7ffbAjZTXgxk2EynY7dehzLX6ISvQC5jxZYOp5omXLkoaHK+mE3j/3+yX693yGRiMsdLCIvTY7hHUhJADBY0TGeXvRglwUrBTucFVFG0p7+3Ni49Ayz4y3zVZa0Xhyx2F7S7Dev54s4qOWO3VDsS2Kr5g0R5biPlo=
Received: from BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 by DM4PR12MB6613.namprd12.prod.outlook.com (2603:10b6:8:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 17:58:01 +0000
Received: from BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec]) by BL1PR12MB5317.namprd12.prod.outlook.com
 ([fe80::bb8a:785:463:43ec%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 17:58:01 +0000
From: "Luo, Zhigang" <Zhigang.Luo@amd.com>
To: David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "kraxel@redhat.com" <kraxel@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>
Subject: RE: [PATCH] hostmem-file: add the 'hmem' option
Thread-Topic: [PATCH] hostmem-file: add the 'hmem' option
Thread-Index: AQHbRm+T08edT93tD0m94+3Dx5+wM7LZAIAAgAB6QhA=
Date: Fri, 6 Dec 2024 17:58:01 +0000
Message-ID: <BL1PR12MB531759C282DC7A424CBC56E8F1312@BL1PR12MB5317.namprd12.prod.outlook.com>
References: <20241204171114.20033-1-Zhigang.Luo@amd.com>
 <5d4019cd-a3fb-4bed-8bab-e0388ccffee7@redhat.com>
In-Reply-To: <5d4019cd-a3fb-4bed-8bab-e0388ccffee7@redhat.com>
Accept-Language: en-US, en-CA
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5dd22655-eeb7-4b08-bf0c-0de3c86cd09f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-06T17:25:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5317:EE_|DM4PR12MB6613:EE_
x-ms-office365-filtering-correlation-id: a47eb961-d725-4458-dc43-08dd161f86a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M2ZLZjVZYUVqTTFWY3YvNVRkK3JEZTBmN2cvdDdtOGVjdTIxMUlTS0N1bVlk?=
 =?utf-8?B?MEtlL0gyNTliMHhuK1RKWDd1eGZxcU8vK3Y4cDQ1TDg5RHFyZVZHSTRPaDZK?=
 =?utf-8?B?ODd0KzB4MTZOV2F3MkdBOWEwazFGMjk5R0RhOG1nc3dXMlowVTZCQXQ1ekhl?=
 =?utf-8?B?R1orQnpqWWt2VE01c0VDckRLM2lhRVBIN1BFYVVvN255Qk93UjdqVzhXajZi?=
 =?utf-8?B?R1N0dnp5WWo0NlRGaDc5Rmk4eFdUMzRHUWkvSlQ2b2JUWE56NXg2NXJDdjRh?=
 =?utf-8?B?MXViYkVMM21GUklXQ0xpSmlJR2VVdFM0aUprT0dXQ1ZZUkoyMC9xYmp0b2JU?=
 =?utf-8?B?R1pBVUhGUzZMTzk3ZUdzQkpMRzFLbmZpYnUxSjlFaXBzNDRyWmtjNzZ1Zm5C?=
 =?utf-8?B?QjMrQlhxaklxQlZZK1JReHY4MGJzQThxSXBaNGkxZldVa0FPbDRUUGs3NUpM?=
 =?utf-8?B?VzJrdmZpSnVNVWVHQmdpMlpGYkZMbXlxOVYxdjdTc2pDY0hOWHVDNGtlN0lk?=
 =?utf-8?B?N1pQV3l5T1FxVHdaclppMG1aTXRYM3BaWTdiUktXQ2lLMnIvbGJtY2xVdTNs?=
 =?utf-8?B?VGlWbXgrTzRubWs0Q1lRVDJISkd5TmxqTEhPTUJsQ0tYUlJJOVRYdTJ4ZEo4?=
 =?utf-8?B?TFB6UW5hOTgzQWNoOGRiT3BSU25CekFERVBVWndtc2ozYWN6UWpyZ3RqSGlW?=
 =?utf-8?B?bUprZ1NWb3RYcFE3RVA3T0k5T0JtRmZVb0h3ZWkwWHMwaTA1MzZUcjQ2NVVZ?=
 =?utf-8?B?Skw5ckVoenM5bVo3US9EVFFJWCt0bGJTd0ZDWmdKcW5vTjJhMXhINGwrVlBL?=
 =?utf-8?B?LzIveWdJZ0RJQ2NvU2dhcmhLbUE1UHFESDNYcTBXNmVlTS9QRG9qYU9aSFNn?=
 =?utf-8?B?cUUxNlVqR1BpYVR3R3AxS3hJOXltd3FraXpVb2g2ODArc2tKWHlOSmlQQnd4?=
 =?utf-8?B?MWdVc3c4T3d6dllVTnd3TE9MT1BaL2s2Zzg0ZkN1WUQ5dy9xbUJkdWd3SlNU?=
 =?utf-8?B?YUdVakF6SDVyNEp6Z1VrOFdtUWVBaDhPclFQUVZhT291SW12WG0wNmZnWjJF?=
 =?utf-8?B?YVhvQzgyKzZBTGthMjVuY0phbExhdGpTSFVRZGJLbXJRby9XMmk3UXZOOGJo?=
 =?utf-8?B?WW1qeTNMTWFYSlRSMHdPMThlcnBHQm1aWFQ5ejZ1bm4zYnJnWUxTdjRhamt0?=
 =?utf-8?B?anNvS0V6QkVmY2xWOHl4UUYyeEZ1UXRubXV1RVRwMW9EaFZ6bWFqUnFtaW1p?=
 =?utf-8?B?aTlybjFKeGdHVGF6cyt5ekRBUlpXS3ozd0ZWcHZ4VnRZNHMxMUF5VFFnbTcw?=
 =?utf-8?B?ekM3U1ZCVUszd0FRWXZmNVRWYSt6U1VZKzVEVGJqYVRRZ1Z0WmRQZEJYWlBh?=
 =?utf-8?B?SHpyR2ZBNHFibFB2SnBYRVhjbE1STjErRnlNWGlFYUVjZEdMdkx2emFIWTdE?=
 =?utf-8?B?eEhEWWZ5U1gzcGk5Vm0wR2pqRWswYUN2QnIzOCtCRzJ5RVpLUFhPcEpldlRE?=
 =?utf-8?B?MGEwL244WkwyWlQ2clVscnpETFllekFadVpkS0FPQm1OZm56WVhnelcvQWZY?=
 =?utf-8?B?RmUvdkJMNFBhb0dQNGYrN2s3Z0dSMU13d1c2VDRxcTFUUFNReWhpMkZXcWZB?=
 =?utf-8?B?QXU0MnFJeEkzSFlUZW1PdGNBMEVLZ2h0TEtCV0tEVTlRWFJNTUxxRUZHdFk0?=
 =?utf-8?B?ZUpoc1JhTkhmU2hlMllMcDBYY1djb3ZUeDU1UVEwMGJJQ3h4cFRZblVUWjhF?=
 =?utf-8?B?d3VUZlJkSXF3V24vaDRmeFp6QTRra0tmZWpnUzZYVUtSSHd1UFA4cVlmOVc5?=
 =?utf-8?B?QjJOZHNwaU1wTElpMnhtQ2RSVlgwM3gyU0JGY2N5V0FTelRkYmZ0am1tZS9s?=
 =?utf-8?B?ZVZsOWJQSUFFZlpDZm1NbldtblBBdSsrZlF3KzdQZTRkcWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5317.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlViZDNKTmpxMjIvT3JlWDByMlhDNlZPTWlYeWw5Z3VNTXhRdkZETXRSVW80?=
 =?utf-8?B?VUNMblJzVG00UGlRM0lYMDBrTXl0ZjNaN1k2SHJIUTNJNEdwMm5walZXN0s2?=
 =?utf-8?B?YktZT2JZM09rcTQ3V015Z3BqTnJSR21YZU96TkVpZ3pBZHRCejlUdTZRY3dW?=
 =?utf-8?B?bllmbWlSYzduQW9jNGdvL00rb1lCeURQKzBCSFlNV2ZOWTFzdkpzNDNYT2Yy?=
 =?utf-8?B?cFN3QjZnN2xJOTd2VkpUY2NXTTVsc1cvRUxtNnEvMkhPaEh1N0JhMkJWRzJj?=
 =?utf-8?B?UjZSczRGZjArYjBHMjlpMmhsamMvVW4xcGJHT2ViQ1lzVDJyNHJuYTdZQ2ZX?=
 =?utf-8?B?N0d0Q1hqSHhYd0pjSG5ZcGxnNWwyMVd2YXV2ejdWVXhSbWk2UUh3NmV6VmVZ?=
 =?utf-8?B?b2tOZXgwaW80SklWMEhvajdBMjE1MDZBbW1FalV5MTMrME80RnFtQmppZko1?=
 =?utf-8?B?dG1pazZxWlpISTNaeGpmQjhpbmF4TnJyb2tQZEVsajFoVXQzM2xiMFVqdFk0?=
 =?utf-8?B?ZDYxejc1dm9XbHlSK0ZPNUt4LzVBNnBEcUFWaFhtQnppUkc2NDdabTQ1MHNj?=
 =?utf-8?B?NnU4c1NoNmxZeVRaMnB5eVR1bEwvcWkzcUxKMnF1LzUyQ0thUGhIYTVNNkxx?=
 =?utf-8?B?UFVKZ0lWZllLdHh4NVVhM0dJRVY3WE1VWjF2S3IxNEl4Zy9ibG5GWmRxenlR?=
 =?utf-8?B?YWVGQ1VXd1lyK0hlOFkxc09UR0RQOWFRZm81OGpFU1ZUeENSUGpjVUNyeWlu?=
 =?utf-8?B?d3BCclo3UHdLWVBlRWszV3g0ZG85L2lqN0I2b1NuNVdhOGUzZ25DVU8rUUJ4?=
 =?utf-8?B?K1h5Q2ltLzNQKzJ3OUVpejQvNStid1FvU2JoRTdmeUhNeGxDU0U1RHYzTjdx?=
 =?utf-8?B?K29Za2tQby9MU1FvdW52ZGtKUFNaSVkzdjRKV0U3dDJRSTNOSGFpN3FUK2E5?=
 =?utf-8?B?QXo1N05yUnZRcHBIMHBXWjh0L0d3NnlURGQ0QlQ2L2Rrd2pjYTBxby9SMnc4?=
 =?utf-8?B?a3pnNnUzZlRNNGErYkhkbGlXTXJhR1RzWmdsR0JZMkgzQlRMTDdyL25hNExG?=
 =?utf-8?B?dGFPT2h1dEF2WmhOMzBjaEJNaytrODgvZElRdi9CUHU4N1dINFpVdlVFaFk5?=
 =?utf-8?B?ZGl1TzY0TTMwSzlxRWVEMCtxc1BtblFYb3Rva24xOHR5di9Od3MrcURFTTBW?=
 =?utf-8?B?U1RBUVZ6aE1vZ2FRMG01Yk9lTFpsN3U2UTcydHNFeXNTM0tGZVU2TUtOV21h?=
 =?utf-8?B?L0RqL0ZNYzM3YW5SYVdseHlpT2d1d2RBWUNjZkhBalJXa05rYUQxT29pVk5X?=
 =?utf-8?B?SHdJMEpSblpydFUvWHNvZmtDWG5pQ2s3TXFlQms2UjJBcDBGUWZCMThVbWRE?=
 =?utf-8?B?NlB1TDk1MU9iZGExVG41UlpmNG9VZndBSitKTmh0RFUwK1JnK2ZoRUxZSWVo?=
 =?utf-8?B?U1lVeGtFbnF5L2FyYThCYnRYQWxCNU53Z3FaaTZORXBreUNSQVVXUTBZREVh?=
 =?utf-8?B?cGFQYXBub0NHZEE4aWh2ZlBZOVJhdysxWW5MSlQxTHcxS0ZTeGh5Sng2RktX?=
 =?utf-8?B?OVlFL25VZDZpYXZMcWtSZE1iKzJHRmZmWGovc3A4aGdCL2JWOGkrMTdxeUQ1?=
 =?utf-8?B?dDhXVEZuTVZRc1h4Z1plZnI3QjlxQklKeVdxaW0yZi93UzlsWnViTTJYU3Ba?=
 =?utf-8?B?MUxxZkJEYnNUVndBU2thUUZaV3hxVFJlb250VVRMMnF4R240NmJiMUVQeS9I?=
 =?utf-8?B?Z2UxVGVDNVlrejJNcVhTdjR3eTJPMXBoVHRhT3NnLzdmTlVQdncyM2VtZHpa?=
 =?utf-8?B?QWNFK25DTGNVclg2Rzh3a2lsSlkyMytFSDU0UVZWcmZkcDg5S2VLVUlkMGhT?=
 =?utf-8?B?dUdsQWdwNUVQRXhaSVpta2Q1bnYzRWNTeThNQWplMlVmY1QzTzErZ29LZ3Ix?=
 =?utf-8?B?dStTaGpNN20yZjN4UHlwNHY4WHhSR3dmYWJWMXVKSldMV3lqQ3NOcWRmU0Ez?=
 =?utf-8?B?OWVkQldYRVNDTHV6bmNXYjJIYjZFRGJzOVpkdGRGWmdGcnBKSVNUNEhJR3p5?=
 =?utf-8?B?aEZpN1JGUGFrejAzbGp3YUdYM2kyU25sM2diTElFSUs2Q2o2ejBpck90bkFP?=
 =?utf-8?Q?9kfY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5317.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a47eb961-d725-4458-dc43-08dd161f86a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 17:58:01.4590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5uWDmm6bkHf5hpBglDdQADsV2/zOSKAG3c3uh0sjsIIxAaWnJ6fQ41SltX5BiMKX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6613
Received-SPF: permerror client-ip=40.107.102.59;
 envelope-from=Zhigang.Luo@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KSGkgRGF2aWQsDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCkxldCBtZSBnaXZlIHlv
dSBzb21lIGJhY2tncm91bmQgZm9yIHRoaXMgcGF0Y2guDQpJIGFtIGN1cnJlbnRseSBlbmdhZ2Vk
IGluIGEgcHJvamVjdCB0aGF0IHJlcXVpcmVzIHRvIHBhc3MgdGhlIEVGSV9NRU1PUllfU1AgKFNw
ZWNpYWwgUHVycG9zZSBNZW1vcnkpIHR5cGUgbWVtb3J5IGZyb20gaG9zdCB0byBhIHZpcnR1YWwg
bWFjaGluZSB3aXRoaW4gUUVNVS4gVGhpcyBtZW1vcnkgbmVlZHMgdG8gYmUgRUZJX01FTU9SWV9T
UCB0eXBlIGluIHRoZSB2aXJ0dWFsIG1hY2hpbmUgYXMgd2VsbC4NClRoaXMgcGFydGljdWxhciBt
ZW1vcnkgdHlwZSBpcyBlc3NlbnRpYWwgZm9yIHRoZSBmdW5jdGlvbmFsaXR5IG9mIG15IHByb2pl
Y3QuDQpJbiBMaW51eCwgdGhlIFNQTSBtZW1vcnkgd2lsbCBiZSBjbGFpbWVkIGJ5IGhtZW0tZGF4
IGRyaXZlciBieSBkZWZhdWx0LiBXaXRoIHRoaXMgcGF0Y2ggSSBjYW4gdXNlIHRoZSBmb2xsb3dp
bmcgY29uZmlnIHRvIHBhc3MgdGhlIFNQTSBtZW1vcnkgdG8gZ3Vlc3QgVk0uDQotb2JqZWN0IG1l
bW9yeS1iYWNrZW5kLWZpbGUsc2l6ZT0zMEcsaWQ9bTEsbWVtLXBhdGg9L2Rldi9kYXgwLjAscHJl
YWxsb2M9b24sYWxpZ249MUcsaG1lbT1vbg0KDQpJIHdhcyB0aGlua2luZyB0byBjaGFuZ2UgdGhl
IG9wdGlvbiBuYW1lIGZyb20gImhtZW0iIHRvICJzcG0iIHRvIGF2b2lkIGNvbmZ1c2lvbi4NCg0K
RG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zIHRvIGFjaGlldmUgdGhpcyBtb3JlIHJlYXNvbmFi
bGU/DQoNClRoYW5rcywNClpoaWdhbmcNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0KU2VudDogRnJpZGF5LCBE
ZWNlbWJlciA2LCAyMDI0IDU6MDggQU0NClRvOiBMdW8sIFpoaWdhbmcgPFpoaWdhbmcuTHVvQGFt
ZC5jb20+OyBxZW11LWRldmVsQG5vbmdudS5vcmcNCkNjOiBrcmF4ZWxAcmVkaGF0LmNvbTsgSWdv
ciBNYW1tZWRvdiA8aW1hbW1lZG9AcmVkaGF0LmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGhv
c3RtZW0tZmlsZTogYWRkIHRoZSAnaG1lbScgb3B0aW9uDQoNCk9uIDA0LjEyLjI0IDE4OjExLCBa
aGlnYW5nIEx1byB3cm90ZToNCj4gVGhpcyBib29sZWFuIG9wdGlvbiAnaG1lbScgYWxsb3dzIHVz
ZXJzIHRvIHNldCBhIG1lbW9yeSByZWdpb24gZnJvbQ0KPiBtZW1vcnktYmFja2VuZC1maWxlIGFz
IGhldGVyb2dlbmVvdXMgbWVtb3J5LiBJZiAnaG1lbT1vbicsIFFFTVUgd2lsbA0KPiBzZXQgdGhl
IGZsYWcgUkFNX0hNRU0gaW4gdGhlIFJBTSBibG9jayBvZiB0aGUgY29ycmVzcG9uZGluZyBtZW1v
cnkNCj4gcmVnaW9uIGFuZCBzZXQgdGhlIGU4MjAgdHlwZSB0byBFODIwX1NPRlRfUkVTRVJWRUQg
Zm9yIHRoaXMgcmVnaW9uLg0KPg0KDQpIaSwNCg0KLi9zY3JpcHRzL2dldF9tYWludGFpbmVyLnBs
IGlzIHlvdXIgZnJpZW5kIHRvIGZpZ3VyZSBvdXQgd2hvbSB0byBDQyBvbiBwYXRjaGVzLg0KDQpJ
biBnZW5lcmFsOiBub3QgYSBmYW4uIFlvdSBzZWVtIHRvIGJlIGFidXNpbmcgbWVtb3J5IGJhY2tl
bmQgcHJvcGVydGllcw0KKyBSQU0gZmxhZ3MgdG8gbWVyZWx5IG1vZGlmeSBob3cgbWVtb3J5IGlz
IGdvaW5nIHRvIGJlIGV4cG9zZWQgaW4gdGhlDQptZW1vcnkgbWFwIG9uIHg4Ni4NCg0KSXQncyBu
b3QgZXZlbiBjbGVhciB3aHkgaGV0ZXJvZ2VuZW91cyBtZW1vcnkgc2hvdWxkIGJlIGV4cG9zZWQg
bGlrZQ0KdGhhdCwgYW5kIGhvdyByZWFzb25hYmxlIGl0IGlzIHRvIGVzc2VudGlhbGx5IGV4cG9z
ZSBhbGwgb2YgZ3Vlc3QgUkFNIGFzDQpFODIwX1NPRlRfUkVTRVJWRUQuDQoNCg0KTm90ZSB0aGF0
IHRoZSB3aG9sZSAicG1lbT1vbiIgY2FzZSB3YXMgdmVyeSBkaWZmZXJlbnQsIGJlY2F1c2UgaXQN
CnJlcXVpcmVkIG1tYXAoKSBtb2RpZmljYXRpb25zLg0KDQo+IFNpZ25lZC1vZmYtYnk6IFpoaWdh
bmcgTHVvIDxaaGlnYW5nLkx1b0BhbWQuY29tPg0KPiAtLS0NCj4gICBiYWNrZW5kcy9ob3N0bWVt
LWZpbGUuYyAgICAgIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysNCj4gICBody9pMzg2L2U4
MjBfbWVtb3J5X2xheW91dC5oIHwgIDEgKw0KPiAgIGh3L2kzODYvcGMuYyAgICAgICAgICAgICAg
ICAgfCAxNiArKysrKysrKysrKysrKysrDQo+ICAgaW5jbHVkZS9leGVjL2NwdS1jb21tb24uaCAg
ICB8ICAxICsNCj4gICBpbmNsdWRlL2V4ZWMvbWVtb3J5LmggICAgICAgIHwgIDMgKysrDQo+ICAg
cWFwaS9xb20uanNvbiAgICAgICAgICAgICAgICB8ICA0ICsrKysNCj4gICBzeXN0ZW0vcGh5c21l
bS5jICAgICAgICAgICAgIHwgIDcgKysrKysrLQ0KPiAgIDcgZmlsZXMgY2hhbmdlZCwgNTQgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvaG9z
dG1lbS1maWxlLmMgYi9iYWNrZW5kcy9ob3N0bWVtLWZpbGUuYw0KPiBpbmRleCA3ZTUwNzJlMzNl
Li41ZGRmZGJhZjg2IDEwMDY0NA0KPiAtLS0gYS9iYWNrZW5kcy9ob3N0bWVtLWZpbGUuYw0KPiAr
KysgYi9iYWNrZW5kcy9ob3N0bWVtLWZpbGUuYw0KPiBAQCAtMzIsNiArMzIsNyBAQCBzdHJ1Y3Qg
SG9zdE1lbW9yeUJhY2tlbmRGaWxlIHsNCj4gICAgICAgdWludDY0X3Qgb2Zmc2V0Ow0KPiAgICAg
ICBib29sIGRpc2NhcmRfZGF0YTsNCj4gICAgICAgYm9vbCBpc19wbWVtOw0KPiArICAgIGJvb2wg
aXNfaG1lbTsNCj4gICAgICAgYm9vbCByZWFkb25seTsNCj4gICAgICAgT25PZmZBdXRvIHJvbTsN
Cj4gICB9Ow0KPiBAQCAtODgsNiArODksNyBAQCBmaWxlX2JhY2tlbmRfbWVtb3J5X2FsbG9jKEhv
c3RNZW1vcnlCYWNrZW5kICpiYWNrZW5kLCBFcnJvciAqKmVycnApDQo+ICAgICAgIHJhbV9mbGFn
cyB8PSBiYWNrZW5kLT5yZXNlcnZlID8gMCA6IFJBTV9OT1JFU0VSVkU7DQo+ICAgICAgIHJhbV9m
bGFncyB8PSBiYWNrZW5kLT5ndWVzdF9tZW1mZCA/IFJBTV9HVUVTVF9NRU1GRCA6IDA7DQo+ICAg
ICAgIHJhbV9mbGFncyB8PSBmYi0+aXNfcG1lbSA/IFJBTV9QTUVNIDogMDsNCj4gKyAgICByYW1f
ZmxhZ3MgfD0gZmItPmlzX2htZW0gPyBSQU1fSE1FTSA6IDA7DQo+ICAgICAgIHJhbV9mbGFncyB8
PSBSQU1fTkFNRURfRklMRTsNCj4gICAgICAgcmV0dXJuIG1lbW9yeV9yZWdpb25faW5pdF9yYW1f
ZnJvbV9maWxlKCZiYWNrZW5kLT5tciwgT0JKRUNUKGJhY2tlbmQpLCBuYW1lLA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYmFja2VuZC0+c2l6ZSwgZmIt
PmFsaWduLCByYW1fZmxhZ3MsDQo+IEBAIC0yNTYsNiArMjU4LDI1IEBAIHN0YXRpYyB2b2lkIGZp
bGVfbWVtb3J5X2JhY2tlbmRfc2V0X3JvbShPYmplY3QgKm9iaiwgVmlzaXRvciAqdiwNCj4gICAg
ICAgdmlzaXRfdHlwZV9Pbk9mZkF1dG8odiwgbmFtZSwgJmZiLT5yb20sIGVycnApOw0KPiAgIH0N
Cj4NCj4gK3N0YXRpYyBib29sIGZpbGVfbWVtb3J5X2JhY2tlbmRfZ2V0X2htZW0oT2JqZWN0ICpv
LCBFcnJvciAqKmVycnApDQo+ICt7DQo+ICsgICAgcmV0dXJuIE1FTU9SWV9CQUNLRU5EX0ZJTEUo
byktPmlzX2htZW07DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIGZpbGVfbWVtb3J5X2JhY2tl
bmRfc2V0X2htZW0oT2JqZWN0ICpvLCBib29sIHZhbHVlLCBFcnJvciAqKmVycnApDQo+ICt7DQo+
ICsgICAgSG9zdE1lbW9yeUJhY2tlbmQgKmJhY2tlbmQgPSBNRU1PUllfQkFDS0VORChvKTsNCj4g
KyAgICBIb3N0TWVtb3J5QmFja2VuZEZpbGUgKmZiID0gTUVNT1JZX0JBQ0tFTkRfRklMRShvKTsN
Cj4gKw0KPiArICAgIGlmIChob3N0X21lbW9yeV9iYWNrZW5kX21yX2luaXRlZChiYWNrZW5kKSkg
ew0KPiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJjYW5ub3QgY2hhbmdlIHByb3BlcnR5ICdo
bWVtJyBvZiAlcy4iLA0KPiArICAgICAgICAgICAgICAgICAgIG9iamVjdF9nZXRfdHlwZW5hbWUo
bykpOw0KPiArICAgICAgICByZXR1cm47DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgZmItPmlzX2ht
ZW0gPSB2YWx1ZTsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyB2b2lkIGZpbGVfYmFja2VuZF91bnBh
cmVudChPYmplY3QgKm9iaikNCj4gICB7DQo+ICAgICAgIEhvc3RNZW1vcnlCYWNrZW5kICpiYWNr
ZW5kID0gTUVNT1JZX0JBQ0tFTkQob2JqKTsNCj4gQEAgLTI5NSw2ICszMTYsOCBAQCBmaWxlX2Jh
Y2tlbmRfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQgKmRhdGEpDQo+ICAgICAgIG9i
amVjdF9jbGFzc19wcm9wZXJ0eV9hZGRfYm9vbChvYywgInBtZW0iLA0KPiAgICAgICAgICAgZmls
ZV9tZW1vcnlfYmFja2VuZF9nZXRfcG1lbSwgZmlsZV9tZW1vcnlfYmFja2VuZF9zZXRfcG1lbSk7
DQo+ICAgI2VuZGlmDQo+ICsgICAgb2JqZWN0X2NsYXNzX3Byb3BlcnR5X2FkZF9ib29sKG9jLCAi
aG1lbSIsDQo+ICsgICAgICAgIGZpbGVfbWVtb3J5X2JhY2tlbmRfZ2V0X2htZW0sIGZpbGVfbWVt
b3J5X2JhY2tlbmRfc2V0X2htZW0pOw0KPiAgICAgICBvYmplY3RfY2xhc3NfcHJvcGVydHlfYWRk
X2Jvb2wob2MsICJyZWFkb25seSIsDQo+ICAgICAgICAgICBmaWxlX21lbW9yeV9iYWNrZW5kX2dl
dF9yZWFkb25seSwNCj4gICAgICAgICAgIGZpbGVfbWVtb3J5X2JhY2tlbmRfc2V0X3JlYWRvbmx5
KTsNCj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvZTgyMF9tZW1vcnlfbGF5b3V0LmggYi9ody9pMzg2
L2U4MjBfbWVtb3J5X2xheW91dC5oDQo+IGluZGV4IGI1MGFjZmEyMDEuLjhhZjZhOWNmYWMgMTAw
NjQ0DQo+IC0tLSBhL2h3L2kzODYvZTgyMF9tZW1vcnlfbGF5b3V0LmgNCj4gKysrIGIvaHcvaTM4
Ni9lODIwX21lbW9yeV9sYXlvdXQuaA0KPiBAQCAtMTUsNiArMTUsNyBAQA0KPiAgICNkZWZpbmUg
RTgyMF9BQ1BJICAgICAgIDMNCj4gICAjZGVmaW5lIEU4MjBfTlZTICAgICAgICA0DQo+ICAgI2Rl
ZmluZSBFODIwX1VOVVNBQkxFICAgNQ0KPiArI2RlZmluZSBFODIwX1NPRlRfUkVTRVJWRUQgIDB4
RUZGRkZGRkYNCj4NCj4gICBzdHJ1Y3QgZTgyMF9lbnRyeSB7DQo+ICAgICAgIHVpbnQ2NF90IGFk
ZHJlc3M7DQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L3BjLmMgYi9ody9pMzg2L3BjLmMNCj4gaW5k
ZXggMzE3YWFjYTI1YS4uNDFlOWNjMjc2YyAxMDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni9wYy5jDQo+
ICsrKyBiL2h3L2kzODYvcGMuYw0KPiBAQCAtNzg1LDYgKzc4NSwyMSBAQCBzdGF0aWMgaHdhZGRy
IHBjX21heF91c2VkX2dwYShQQ01hY2hpbmVTdGF0ZSAqcGNtcywgdWludDY0X3QgcGNpX2hvbGU2
NF9zaXplKQ0KPiAgICAgICByZXR1cm4gcGNfYWJvdmVfNGdfZW5kKHBjbXMpIC0gMTsNCj4gICB9
DQo+DQo+ICtzdGF0aWMgaW50IHBjX3VwZGF0ZV9obWVtX21lbW9yeShSQU1CbG9jayAqcmIsIHZv
aWQgKm9wYXF1ZSkNCj4gK3sNCj4gKyAgICBYODZNYWNoaW5lU3RhdGUgKng4Nm1zID0gb3BhcXVl
Ow0KPiArICAgIHJhbV9hZGRyX3Qgb2Zmc2V0Ow0KPiArICAgIHJhbV9hZGRyX3QgbGVuZ3RoOw0K
PiArDQo+ICsgICAgaWYgKHFlbXVfcmFtX2lzX2htZW0ocmIpKSB7DQo+ICsgICAgICAgIG9mZnNl
dCA9IHFlbXVfcmFtX2dldF9vZmZzZXQocmIpICsgKDB4MTAwMDAwMDAwVUxMIC0geDg2bXMtPmJl
bG93XzRnX21lbV9zaXplKTsNCj4gKyAgICAgICAgbGVuZ3RoID0gcWVtdV9yYW1fZ2V0X3VzZWRf
bGVuZ3RoKHJiKTsNCj4gKyAgICAgICAgZTgyMF9hZGRfZW50cnkob2Zmc2V0LCBsZW5ndGgsIEU4
MjBfU09GVF9SRVNFUlZFRCk7DQo+ICsgICAgfQ0KDQpJIGFtIHByZXR0eSBzdXJlIHRoaXMgd2ls
bCBicmVhayBpbiBOVU1BIHNldHVwcywgd2hlcmUgd2UgaGF2ZSBtdWx0aXBsZQ0KbWVtb3J5IGJh
Y2tlbmRzIG1hcHBlZCBpbiBkaWZmZXJlbnQgbG9jYXRpb25zLg0KDQpUaGUgd2hvbGUgIigweDEw
MDAwMDAwMFVMTCAtIHg4Nm1zLT5iZWxvd180Z19tZW1fc2l6ZSkiIGxvb2tzIGhhY2t5Lg0KDQot
LQ0KQ2hlZXJzLA0KDQpEYXZpZCAvIGRoaWxkZW5iDQoNCg==

