Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2920DCFB452
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:00:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxswy-0006um-3b; Mon, 07 Oct 2024 14:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sxsww-0006uZ-3o
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 14:59:18 -0400
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com
 ([40.107.92.71] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1sxswt-0001uH-QQ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 14:59:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WL0umtE3OTRH6hRJcE+1iI/2VH5Zh6tFnjguTXaGrVDVZbKn128s/OkCnbMnarb/lwCkXFT7d/JMWNfXE0tW/fCLanQmsAbUx+XqOjkBvx+vzrsTc+JOr3Rf0iGSRSSS09f/ARGlff8v/bSaY0NOgwybvdjtRq8ImSFtv8ZV9qslLur8H6VtlK0RIAmjUNy+VCwfZSTRarVegzoJM1RYs5Dcl+WTrmLp+NXkWNedELv9VqOPByaowlNW0FOO48dYvTXUKhzukST/1EwXjTbJSX6HtLr3hRTsQlE8AoRuyqBXD2PZo+KVUVaiIp3ggkbJa85Uvfhs1GwsvQkIb63cdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AzweoRXPgD38rSw1rZ+mydJ2oHHUh8nR6coDRVI9Kug=;
 b=rca6Z0BoB/fb+Jp++brmc/6I7QdFrHFeIwn32knGjCSVanZqsqjw08zSbTFVsLgpYDzXq3rflucCbLIxuiIYpDUiMwT84XJIJuts77TO2ExGZZe+ZCBzOrQGgfbgFSpaN6VbjnlG1HZPUTQ7IAHk1m9tOAJT/AOwdGuqtudWl6LpwUjPXDjSetmdefrBaPMszmRci0GgLdTDqwuLtL3ULUdADIKcK3uWbUucMnfB9TYBm1/Bh8bLjuDRilv5fP3O76WLMidywwXP9BAQKc+CU5BMQjnzoi65uAct8sqSDyow2bOxoaX8LYU55x6f/5o05eNHtT/yv1cZ/RZUgPiiDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AzweoRXPgD38rSw1rZ+mydJ2oHHUh8nR6coDRVI9Kug=;
 b=Cw958mur+au8GoqRJNW1JU1yRPpvZDsH/Ni9cRgk0SlvTlXau4bhjiTiVsi68RlpAtDlmJfFYmsKDzUVR8ZQfoVo3f1mWvsh1AD3FMXbXBgeLnUnC18ckoPfYKL/MVxFnsOxbvNCT9AgRwGv3Q2nz7bDfmGc/KKWm5WaPYUwuzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by DS0PR12MB8767.namprd12.prod.outlook.com (2603:10b6:8:14f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 18:54:04 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 18:54:04 +0000
Message-ID: <78028d69-90c8-a295-9393-1f6d6c3826cc@amd.com>
Date: Mon, 7 Oct 2024 20:53:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 05/16] i386/pc_sysfw: Ensure sysfw flash configuration
 does not conflict with IGVM
Content-Language: en-US
To: Roy Hopkins <roy.hopkins@suse.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?J=c3=b6rg_Roedel?=
 <jroedel@suse.com>
References: <cover.1727341768.git.roy.hopkins@suse.com>
 <3255767a6d34297ec47f43f9ae9434116d3f17ba.1727341768.git.roy.hopkins@suse.com>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <3255767a6d34297ec47f43f9ae9434116d3f17ba.1727341768.git.roy.hopkins@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::10) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|DS0PR12MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e87d1b-acd7-46e5-d89c-08dce7016a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHZzR2VDK3JzR0lhZUxpVlVYcVhIckt6WDlNb2ovRVVtMm1hTUs1UlZ4NkJM?=
 =?utf-8?B?Q0YvZG5ycFBpWVVBWGN2T1pObWNodUtGQnhzeFMvd2hFSXhoRktRNXpyQ2Vy?=
 =?utf-8?B?dVRRQ2t2VVNqbVJ4MDZYMDNYRi96b2VDOTg5NGNqNG5JWlRUNHk1T2g3b0hY?=
 =?utf-8?B?Wmd4bWNWaENzN1kvQi9IWFg3T1RtYlpuUjNSOG9aOCtNcTdtNjdFTWp3YVRV?=
 =?utf-8?B?NU83aW1kTGFyMkRnbVNZVjdrQkNMd015UTFUMU1ZZEJlT2orMStOM1VCRE1z?=
 =?utf-8?B?UnlLU1dKZENWcE9HeXJRcE8wNlNtQlZURGFIc21CK2JyMGpsSytVQkltYWV1?=
 =?utf-8?B?RkQxRFFFRWVad3J2TENJRDVTWFVyTjdTY3ZKSU5YUE9KTVc3d3AyRm1ZNmxC?=
 =?utf-8?B?V09zVnYyUDVDdGZyVUl3NFdRTHlrN1QyanhJTjFCMTRHNUhvbkNRQmgxU3NP?=
 =?utf-8?B?bFBPLytJc016cm1SdnAxVmdKSEp5Z21yWkZ6TTZCbXErQ29UamZ5aCtaSERv?=
 =?utf-8?B?OFJPdWt6ei90cFRQTThLOURxSDRLZHpabVF2ZTR5MFMya0V2Kzc2dUZ0ZjBC?=
 =?utf-8?B?ZzhLb0JOSG1wM3FvYUcxejYrN3V3WU1ZZE0xVUQzRFRpOUJLNWswWFJrVEtv?=
 =?utf-8?B?WEhnV1E1UlRJWGJDRTVBdUR0T1JySy9yR29GRzE5NWFrZm12MktCcTRDZmJF?=
 =?utf-8?B?T2d5S2UwRHFDTnA0U0ZMcGtWOEZpVlRuUWxMUEd3Z0IrZVBNT0JnZmsxTjA1?=
 =?utf-8?B?WGVoczcyMDB1SE5WNTRjanRTZGxHQnN3UDZBRUpiKzFOZkRrYVNFMHhIb1Rp?=
 =?utf-8?B?L2l4RnRoeUhjbUJZU0t2WEtvbXJlalBTY0IzU1BNd0huK2MyS2YwR1UxQ0VR?=
 =?utf-8?B?WWM3cldXVlJFUHpPRzZyNnlGYjd4SnZyRENxMGlUMU1KQ2ViN3MvcDA2QUJY?=
 =?utf-8?B?RHBPWE5MKy93ZWxWdkI5bHBaZWxwK2wzUXpaRk5RSmlkRG5aMGZmOTVzYWs0?=
 =?utf-8?B?OG80UlIrQUUremJmOU9BNkNHWkF1SytUVTlKeTVFTU1GdlpBSUs2M1NuNzNL?=
 =?utf-8?B?RkpISUQ3NXpUVHl3WWoranplNC9FbzkweEJKS1Z6Z0hGU0JwRzhpNnFQWDBO?=
 =?utf-8?B?cjBjZkhGMnkwZ1JEaTlwSFFKYkY3QTZndEdqcXdjaTlUL0NEdWlBYUM5b1BG?=
 =?utf-8?B?L2pCR2NQOEZYMTZXZjdUZXNOTnUrODRwQlV2Y0wxY1pWNVRmQm9NMlJGY0k1?=
 =?utf-8?B?UFFDazAvVG02eCtRd1N4TFdDRDVFU0ZkK3JCUlhUcVJWSTNhOGNXRWxONlpS?=
 =?utf-8?B?SnNVMVN0eERybE1VdFQ5MUQ4enRON0FBUVoyNk9aeEh5TlZNUW1sYm5STEc1?=
 =?utf-8?B?UU82VXE3UkZZbklIVUtxOFE2d21ISkFoNUVUWGVZWXY1bmNxbDYrY1g2ZTRH?=
 =?utf-8?B?dmdXaHBSaGhPVUdBWjVIRTlvRllCbjJOZEdaN0EyRHdsN0JJRXJLM011WWdv?=
 =?utf-8?B?R3FnTDg2Mm5QZ0J6QkJRNDZabmNvV1BZczhRSmtSaUdrY3ZWdUMxa2NjcUJF?=
 =?utf-8?B?aWdyZE9neVJMYm1nM0huTlZkNnZyNzVRNUExN01oQVNTSytsMEhubDI1eEw2?=
 =?utf-8?B?UVhFVG83MmlrTStITFQzK0kxSXdtU1dmQUVITlZMN3ZJTWNncjZwWEtGN3lR?=
 =?utf-8?B?c3BOM3ExbEtjNVhkQWV4cjViRkN0MnIyejUzMjVldXBaU2d1ei9ldnlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjR1L2JrKzVsekViZnFFQWVKZU1uc09Pak8wK2VVRVg1Z08zcGhEY3MzWU5V?=
 =?utf-8?B?cUZqbmRSVXZSRDlQTlR3aVkvVnFCK2JpN0VvQkM1SnlDRGV5RXBUQnRlemt5?=
 =?utf-8?B?RjAzQmg5QVRVeUZCVEl4UVRadUJBWitEMkc4c2lkcUR4NjB3YXhhdzFWNEJC?=
 =?utf-8?B?Q0ZDT0hyQjhwdU95c2hMNzE2eG9TYU5FMWZpaTlqQ3ZRcmRwQ1VvQmNkbmpN?=
 =?utf-8?B?WEVxVDhqbTZKSmpaMTc2dzVxZUpuMGl0RUFTUWp3Wk81SEk5QTBwU005TkpS?=
 =?utf-8?B?Z1Q3S212NS9iL3VkTnpMaSttU01YUWVHSjVQK3h4Q3ZzdDAwb0V1VTd4WS9I?=
 =?utf-8?B?NU5wY3RYNXdvNmd6K0NucXl2dERaVGFBSXRma3VkTWJ5b0hQUklXWnZZMklI?=
 =?utf-8?B?b1FidE9jdFdsWlByM290anl2RjRHY2s0U3NtOW5BbytlVEVwbFQyYm9DMzdM?=
 =?utf-8?B?V21lMzFqUEY1a0N1V2lsN0dEaHR3b20wNEdQR3MvYW9PYlQ3clVCWlVUTmxm?=
 =?utf-8?B?TTNJZzlpRzdndmdhUmkzemVHb2wxNkdmMk4rcEF4UzRTZVM4YXZRQ0wvKzhu?=
 =?utf-8?B?MmxQcXUxYm05TXRDemY3dGgvdmlHWGFRYzRjQ200RW5neDVJRTdrZUJOeXVu?=
 =?utf-8?B?VTU2OE0wcXRpWDdCR3RvQ0wyMHdaSDJPM3ROcHNiMFJxK3RGclRFRHg3VHJ6?=
 =?utf-8?B?SDFTMUJJbmYrbmZibUtMcHRPb0pvSnhaY2ZwKzZRR0QrWlEyL1ZvWStNWlNj?=
 =?utf-8?B?V09XaENlZVpLaDg5YkJMNDE2bGFPcTI1NXpVTk1IdFZXc1JaMVJMcWxnd1c0?=
 =?utf-8?B?NE03VmRMV2VHSnlaM2VTSDE0K1ZFUnhkZW1VNmRxNHptMElnMzBNYjNwTW9V?=
 =?utf-8?B?Q0pkTW51V253VTk2TVhOaGYveXh1aklIM0owNlR6OTFvNFV3dXMxdHMwYXhD?=
 =?utf-8?B?eXBVeXZhdmFLaEhTQVRQdTVCTkN3R2RPOWRPWFdUVFBXdE9oTDVEZ2xFT200?=
 =?utf-8?B?TU50N1NHR1NBZmpPbysxOHBnMDRYMDhPZ2Raa0RaeDlhSWFqbnNBaFpkZndx?=
 =?utf-8?B?Z0VydjkybGFBLzArajNEeEJmYmFRZldINE9IN0ZzbElmZ1ZkNk9lb0NhSXVu?=
 =?utf-8?B?RExFNVoyQ241Sm1lZW5qbUs1OHVQaTFrUFNPaU1YdWdWb25VU1JsOEtiSHFN?=
 =?utf-8?B?bSs2SHk5UW1RRzFhdGZTaWVUNDQrTnpmdzBhV2ZGOHVRVitjcEUvaUZhcGRp?=
 =?utf-8?B?RUY4amxreUdMdGpkOFNZMmxJQWpSWS9oOThucmVuN0V4bkR1akVadXZpZVhn?=
 =?utf-8?B?N0JJT2RUUExNWmM0NnlOMHZMUVFCY001bmd0R29Gc2hYeDFmbGpBSjBOT2RN?=
 =?utf-8?B?UlFoTC9pcjYrVUQvM1M1NExneXVSelNyc0xpS0tMU0NMN2owQ09ZMFRMcXM4?=
 =?utf-8?B?OEpuZ2ZwUytGWVNGTnc3b1EzQS9IbUFybThvSFErMFZMTnJxVmVKbTYwSlJQ?=
 =?utf-8?B?UVhIalc0SHVXYWIyUkpIK082dlVBWWh3VHA5dVJPSTJJeTlFUTZFMndkYjVQ?=
 =?utf-8?B?TnRlT2tMT0RDeFpMdFZqc3dsL1pLcUpZWFNyRTIrSGo1Ym54QmRLY1ZuOGVM?=
 =?utf-8?B?V1JhRGVPYmp5dmVzSTdyZ1kvWithTUNHdzBxYnNGRnBlTFJCL2JSUDNIT1Bj?=
 =?utf-8?B?dTNSVThHYVptVytTZ2RuT0gxcGoyeG1wRTNwZkFJSjJIbkxYQWs4UDY1Rk50?=
 =?utf-8?B?K2s2eitaeVc3c25IZWsrTkhJVGc0Nk8wem0xM0FlYnJzT0dZQVRNZnRnckVN?=
 =?utf-8?B?ekxtR3BPMXd4QUVLbFZnMVEwR1ZDWVdjTGZTTEcvckhzai9lYnl3VTRjSGVi?=
 =?utf-8?B?VDhlNDdYYldlbHo0VURWOHoxelQ1c29iZk5XVHVJRUQxWTk1ZXQ5ZEVlUjVk?=
 =?utf-8?B?WXp2TjFCemd6SytKblpFTmw3TWpmRGRJeHFlMmVhdFR2TTlIRWVLYnRGNU1i?=
 =?utf-8?B?T0xXdmM2WUwxeUNtSnFvM0NjclJHYUJHR1JDY294NCt0STBMREhqV1Q3OXpZ?=
 =?utf-8?B?WHJ1V1N1YnZmYitKbUZsWGRrNXNVYzg5OTlBN3FqbVloOUZzRGU1NE5yMUZw?=
 =?utf-8?Q?V4/TzksUO43A0VzmwO2VwEXjl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e87d1b-acd7-46e5-d89c-08dce7016a5f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 18:54:04.7444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wWwFf1lSfCqoXi74gjO69Obj7Y6bYXCC/HxzYgsUA/FyjRnhBZ/1K6/MPgHZRBhCIJRMThzY4P15huSylkCTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8767
Received-SPF: permerror client-ip=40.107.92.71;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.369, RCVD_IN_MSPIKE_H2=-0.001,
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

> When using an IGVM file the configuration of the system firmware is
> defined by IGVM directives contained in the file. In this case the user
> should not configure any pflash devices.
> 
> This commit skips initialization of the ROM mode when pflash0 is not set
> then checks to ensure no pflash devices have been configured when using
> IGVM, exiting with an error message if this is not the case.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   hw/i386/pc_sysfw.c | 31 ++++++++++++++++++++++++++++---
>   1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index ef80281d28..f5e40b3ef6 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -219,7 +219,13 @@ void pc_system_firmware_init(PCMachineState *pcms,
>       BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
>   
>       if (!pcmc->pci_enabled) {
> -        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);
> +        /*
> +         * If an IGVM file is specified then the firmware must be provided
> +         * in the IGVM file.
> +         */
> +        if (!X86_MACHINE(pcms)->igvm) {
> +            x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, true);
> +        }
>           return;
>       }
>   
> @@ -239,8 +245,13 @@ void pc_system_firmware_init(PCMachineState *pcms,
>       }
>   
>       if (!pflash_blk[0]) {
> -        /* Machine property pflash0 not set, use ROM mode */
> -        x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, false);
> +        /*
> +         * Machine property pflash0 not set, use ROM mode unless using IGVM,
> +         * in which case the firmware must be provided by the IGVM file.
> +         */
> +        if (!X86_MACHINE(pcms)->igvm) {
> +            x86_bios_rom_init(X86_MACHINE(pcms), "bios.bin", rom_memory, false);
> +        }
>       } else {
>           if (kvm_enabled() && !kvm_readonly_mem_enabled()) {
>               /*
> @@ -256,6 +267,20 @@ void pc_system_firmware_init(PCMachineState *pcms,
>       }
>   
>       pc_system_flash_cleanup_unused(pcms);
> +
> +    /*
> +     * The user should not have specified any pflash devices when using IGVM
> +     * to configure the guest.
> +     */
> +    if (X86_MACHINE(pcms)->igvm) {
> +        for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
> +            if (pcms->flash[i]) {
> +                error_report("pflash devices cannot be configured when "
> +                             "using IGVM");
> +                exit(1);
> +            }
> +        }
> +    }
>   }
>   
>   void x86_firmware_configure(hwaddr gpa, void *ptr, int size)


