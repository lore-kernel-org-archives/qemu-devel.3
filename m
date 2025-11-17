Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E692CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 07:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKtdA-0007Et-7Y; Mon, 17 Nov 2025 02:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vKtct-00078N-Hz
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:26:16 -0500
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vKtcq-00040E-R6
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:26:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4HVoO/InyjkhINWu/Vcu0LGmbjPilFIi+OdQNLJ38mhOiRGoluc5FafeT8GZs8LdfvVMoI24l+g5df4fQtBPFLYUjA/F/PaDBbOkRGkBcSn6Rrx5G+Me3J/r1dUT89eVeyYPHDVBM/e9DshpVLY8nPBRZNrHZsXytuWtxuPbNKvVJXJycj9mMDSuzGrKZlwig1/dvTMuqXwlVdiebfkgwW6kWLTOJvVS92bahwaXAV6HDuXBuqwJaMWVE7ePzqjmabsIz0dL5XIBMgSSyyUhZ0llXekliGR9k4KhZt3kqGomVY4HL6aGSrDuJMy6ev3LWGC0ACoSSUNqpIXPgUv+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AA8Pf5/F6HlKNXZ5xaUDc8UV56KUxEdONzmy1A0OncE=;
 b=ehZr3McOt7+SC9aykDXlFSfgrZRnFwgxw3ibNMEs0rEARyPhG/rxRlwasmyf/t9YshvbpIiumxSdDqKDPvY8E5yYCQsKwmFkX2LwJycMtcEmKRhEZSlA++IaFutx2TQ8eW4mlIc0LiIQzJUUs/InZO7447RPyvs3/0UA+V6RSzdEwo0RsdbXqYoez9gwi4k99NQyryFKpMfUxbpSC8AeCSs2HeeuZJXYiBpmMiSKUck122w1v/LJlZKgIi0oYDby/dqDXEG0gQTj6EA3vTA76tCegALxBd4/t2NTS3mKhid0qPYh8282yprovYXZJ8xVMxgqdJVtgncc1fDzOPDPYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA8Pf5/F6HlKNXZ5xaUDc8UV56KUxEdONzmy1A0OncE=;
 b=tl9kqVXWK6JA9RRzeA9v3t+wwHoxIsFnvQsiXiCQGR47Hog8HDCNbVTzKZBdFFhF3DXNU1maS2KXho0iubXhoxXP5St5zh8toKVkZ00wzm1cVisC8+1v+rCPsdEHSDESBSUDzw9UTRdmQaWbn/F6xFLOWIyRA8g3VEe7bFb04N0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 07:26:06 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941%3]) with mapi id 15.20.9275.015; Mon, 17 Nov 2025
 07:26:06 +0000
Message-ID: <27e24af2-683a-48f2-9b10-e6f4061d49d4@amd.com>
Date: Mon, 17 Nov 2025 15:26:01 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu-virgl: fix error handling in
 virgl_cmd_resource_create_blob
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com, alex.bennee@linaro.org,
 dmitry.osipenko@collabora.com
References: <20251117055112.99046-1-honghuan@amd.com>
 <5eca552d-31e6-4918-adf1-da2568af18ef@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: "Honglei1.Huang@amd.com" <honghuan@amd.com>
In-Reply-To: <5eca552d-31e6-4918-adf1-da2568af18ef@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0169.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::12) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: e4844c72-9cf3-4594-b6a1-08de25aa9248
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWlIc0MwOXkxc0IwZTJjWEhNNGZ5emRQOTVELzBxTDlNQXBHeGR1MktqZ2cw?=
 =?utf-8?B?TUkxeWs0MlJaZjk5dHJLUFFrSmVMWmZWVlYrSmFhZ1ZQSENyTWFOTXV3YkM3?=
 =?utf-8?B?RVF4WnBqT2ZtTlU5WHlHaFVPQ1Y5anN4bnBBSUEreVp5OGNiVUw1ZnA3NHkv?=
 =?utf-8?B?TEszbDAvcURyb3ZZVjZmQW0zUnNmNFFVOElkTEUzQ1M3VG5mSTZCM0FxU2kz?=
 =?utf-8?B?b0Zaelh4bG0zbUR5THQ4a1lmc0ZXVmVuTUYzTE5jSkc4NForeTM4VDc1RG5q?=
 =?utf-8?B?QVh2R0VkV1VFaENqVHlVZjEzUWVWa0xiQVk5NlE4VlNtck82eWVHTWpFTUN5?=
 =?utf-8?B?ODZmUnQ5ZklxekdmWlJmeUhqWVBCVnIvUW02SDd1d280T05BdjFEMkRIZ3dp?=
 =?utf-8?B?OGZjbzN5K2xGNjYwcHNZZXNYQmVKSUR4Ym1OcUI5bThSOGxDVmUwaXFxUy9a?=
 =?utf-8?B?N3hob3ZxejRMUHB5S0UyY2lqREVSSEdra2svTDczaXVnTkJqMzFCSytXN2lr?=
 =?utf-8?B?VjRMemF0YnpTdmF5Q3J3dU93VUkwQ2ViSUVYS2JaWU50VVFOa2NLZFlockFa?=
 =?utf-8?B?Uy9QdW9QYzdpTWZRK2k4NXUveGhwYjJJM3RDRWhiejFPc0FiallobERVK255?=
 =?utf-8?B?dVRhVnNKdkprbXU1bENKYjN3QmpiN3pXRkNGQXE2MzZiWVVrMytPc3JEMXli?=
 =?utf-8?B?aVBoaXZOQjdicUkzV1JrZlBFYnA4Uy8xcTF0OWxwS216bm83aVNISWdvUk9y?=
 =?utf-8?B?cy9aSXVHWUJ2d3dmc1MyNjcxRloxbGh3czlVd1FhUnVHWnBtbnRDdTZqM0cv?=
 =?utf-8?B?NlBrUjc4M0JzOHJIS2UxT1ZqM2xmVG4zZmQxWkVNazY1VDB6T0RQT0lpcTBM?=
 =?utf-8?B?YlhkRnR3djlIYlp4QWJLR0dCdGtFT2JFeW8rdndPR3kyclIzZnZWOEpGajN6?=
 =?utf-8?B?R1dZdk55bGF4c2p4a2F3ZEdObEZJUGVsTjZpRUwvdzFTSUx2VEFOdHlxZTBa?=
 =?utf-8?B?bkprc0RtUHFnbndlU09LY0tONHQ5VjhYVStYZDI5WFZSWmZmWDc5YjdGWTBk?=
 =?utf-8?B?dXBlejIzdmxkcVJKSjdMd2pLd1h4QTUxaXhoLzk2MnBDeWF0M2paSnM0bm0z?=
 =?utf-8?B?SXdLVlZENWRpV3NjQnMyOXdtVGN0OHVRVGdvQm53M3hzcHdzNVQySW1qaXh0?=
 =?utf-8?B?dG51SitaZm1xWm1sdjNPSWs0a3NsOWh5eTEzUi92WTRwbDEwR2RLQjh0NkRs?=
 =?utf-8?B?ek9OZnExNGh2OTVuTkgvZGRkcDVIM2FuZ0p1OXhoRU53U3JnSGZjelk1aXph?=
 =?utf-8?B?M2V4Qnc1TGFDVzNXSlVlT0h0U2MvRTdPdDJWTEZnR3VwNU1zNXB1djVyZ0Fw?=
 =?utf-8?B?Y3JUNUZnYVBSbExKRjlMMDBaTlhtc29BYmo4SHpSUmhtV1l4SHh4Nm1odUE0?=
 =?utf-8?B?b3dRcm1rNDZoNUtBRkxUQ05jcitQWFpnVnY2M3JvRzBGRWNXdEg4bjArT09v?=
 =?utf-8?B?S01KVjhtZ0hyeUQ1cFkwY2N4Rllra3ZTZk5uN0psT2h0elNuSW0zZFVkUVEz?=
 =?utf-8?B?ZlZldFpzRTVXSTBabll2L2E4Snc1R2IwS01IMXcwUUNWaGVYN1E3YjM4UUlV?=
 =?utf-8?B?elEweWw1UDJDUU54VUlHcHhCNUJITjlONW5FYkZOOGFOalpxVHBtLy9BUGN1?=
 =?utf-8?B?Nm5wUnFVazRNN0ROc2JycGZhbTFacFVVbnpwT3kxazB0NDBvM0cyemNxbWhn?=
 =?utf-8?B?Vmo2aGpVdkQ0Z1hrOVpsTTczb1ljM1lXeHE3MlY4U3Q0d2pWU2xiTEJGdlQ2?=
 =?utf-8?B?WXhlMk9Ga2o0OC9jb0NqTUQwZWpoZkJ0a3h1YlhRUzFwSmlEUENJZVgzT1Zv?=
 =?utf-8?B?SlhHV2dHZ05XV1JaQlU5ZlVQellQdDBXNXBFNzBNb1ZYM1IrMVkrSXdmNDNS?=
 =?utf-8?Q?ZJ7/oEjECZqszVpT1LRlqtqKCqQvr3pu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z05XSGRkSisxaXplVEVOYndKMFVWam51bVZ5bi90VzF4WEZNUEV5TjNYakJp?=
 =?utf-8?B?TUY4YkN2M0FkMlNtWS9QY2hZTXlBc3h5THhDeVY0a1lpa3N2clRWUUxobVh5?=
 =?utf-8?B?Wi9SWW9uRzNwSXk2VXpNbGRiZmc3U01IOEcwNmltSlc4R2h2ampvSnNHdnVW?=
 =?utf-8?B?MEl6QlMvdm40dkRzWXR4QUFHdWViZW1WUmg5cEdseWRuL2g4a1hRYmRrd3lD?=
 =?utf-8?B?QUNKaTkvZDlPZnFzZ1Z3dzZDZFlYUVF6Y0dBL0tvdStKelgwTlpwWmRGQzd5?=
 =?utf-8?B?bHJhcCtYWlBIRHpLMFl6T1VNNWpwSDU1QUsyUnhFV1dPUzFSZElBdE04YVRT?=
 =?utf-8?B?M0N0S2trOXl0NEhnQkZmKzd0OXpBRHZwcHJiZDJpYnVyVHJIbG5GeWZrREsr?=
 =?utf-8?B?NXkwdjRWdVJ4LzlTN0Uvb1kxN210eWlaTGc5ZDdlZFVJOGgzSmdtRlBMNzJq?=
 =?utf-8?B?d21IMkp0azJrSExZd1hMQmpYL2xVMlBEZFQveHFqdnhBZ2owVm9LWlZyd3pi?=
 =?utf-8?B?eGo3VlU5bDZ2RkpHV2thYW5HVkRWRVBqVXRvemVnMW56dUF0TCtYMy9IaFBS?=
 =?utf-8?B?RjFuNk1Ya2Z4ZWFaOWdOeWNOSllPTi9nRlZVWGdFd0RMM3huQmYrcjJVTzhp?=
 =?utf-8?B?SFVCcFhIZWVsNzdIWjIvYUJWcmM0RDg4OG05WEkxdDVQUmp4aklXRnZYd2h1?=
 =?utf-8?B?WXJwT05KTmZFRFV0Mm9jUy9UeFJOYXFWZmxCUlJGUjFtUkY3YVl4WUpPSXAz?=
 =?utf-8?B?cDQyTFplYU5uUnBrWit1NkVCcU01NHhkbUJnOE5wZmFNbFMrQy9JQTU1NTVZ?=
 =?utf-8?B?aUxmWkpJOXpMNXUrQXJSRjhGbms2aG1RSDlZZU5QTDBrVnJjaUlvVituTVlj?=
 =?utf-8?B?UUc1aU4rUEhOTVpyVnE3UHJxRUZicHlaRXUyQklyTGxSZGdDS2FPRHZWWlhQ?=
 =?utf-8?B?cVJSUzA5Y29oM01uTFh3eXNxb3UyNVRQV2drWXh6UW1uOVZrb2VVdE1OUldY?=
 =?utf-8?B?SHhQaFQ0R0QzRHFYRUozc0g2Ny9lNUhmZ2N5Szlsang0cGFodFFHdHY2NVR0?=
 =?utf-8?B?WXU5d3lnYnYxVGgwcllQV2V4cmJQdDl4dTlWNUkrQ2tQSWczaWdVd0cvQXh1?=
 =?utf-8?B?NWxZTDFGU0hUZjVqYjJ0cjNLS2c5TGV0cldZOTJ3Y2xqRUhZMW5peGdxVHha?=
 =?utf-8?B?bnE4Sk1ZSlQrYktCMEd4aTcxa3c3N2x6Q2c5T2xvb1ZSemZMZ0xKSU9heEt3?=
 =?utf-8?B?bTc0bVF0VEQ2eWNxZmRXM2ZnOG0zT2xyYUdmNWpjSEZwbjlLUUhNWnpVNEkx?=
 =?utf-8?B?Wno3a2I1anBBalQ5V2tKT2FkNHpNVHN0Sm9Kb0ZlQUlIOW40K1pkTUpGSCtQ?=
 =?utf-8?B?UE9xeStlQ2dGY2NwK1M1T2U2QzAzdVVWWnpsTmlyWTZWQjBOUVpUU3VkbVFL?=
 =?utf-8?B?ck5tZkt5MFM1WkI1bUpoQU40ZEdwT2tOZzZ1WUN5bkhJcHV3U09zMDJ0MnQ4?=
 =?utf-8?B?S2tNSFIwOVl5aFpFZTZSb0hzaXVWbW8vSlN1MkQ0ZkNmMlQ4RGZPZXNTcllK?=
 =?utf-8?B?US9OVzlUdTRkWHlDNkthczFodG81MTd1NVpyZDF0elB5QVY0ODA1WUFiSXo3?=
 =?utf-8?B?Y0lYSU11eVJsMDZmWEp1c1Vtb01nL3R2VHhqL0YzNDNJa0ZMWUxkd3VqdmFi?=
 =?utf-8?B?czZ5WndTbmJvQ0RkeStnTWExSGxoaHRaMlZveksxbmdHVWVKZ3g0N2plam9O?=
 =?utf-8?B?cGdxaG5OamtnUGkwdCt2S3dHSTViMFRmTi9heHg2NzN5V1M4U3hrcGc1akdC?=
 =?utf-8?B?YnNrUVlBeWxMelU5VHEvQnpxRWxmVHp0SW5TdlRkckFYdDYxeFNjQUpJRUc2?=
 =?utf-8?B?c1ZjSDdTL2JHOVhwb21EYk5mWnh0TE4xdkhwNjJiYXNnalN2NXpOQ2ROdzF5?=
 =?utf-8?B?YWZxME4xMHl5YWZCV3c2eWloVkxwcjB4dkFpdzJ3eG9ZUUhvMkZTeTdRMCtQ?=
 =?utf-8?B?b1dweFE3ZENLajV3bkJHS0hwSjhxelpMVVF3aUY5VGkwQ1J4OWFZMEV0MmNq?=
 =?utf-8?B?N29Kb3NDRmV4L1NuYjJHWGN0dC9BYTlnVmhidkIvZGZ4YnFGUlZVM0h4elhI?=
 =?utf-8?Q?Vb7Hsn7esF5oS4txJ6maWNrDp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4844c72-9cf3-4594-b6a1-08de25aa9248
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:26:06.4601 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p04/RGccoYWfkvdHW4BOhUy+ADmzYHEmJhpDUnQ3amTnmG7G2hiZOYxEZvS7Oa3RpAnDz2rs73MdzZ3hk2L0Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=Honglei1.Huang@amd.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NAME_EMAIL_DIFF=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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



On 2025/11/17 14:39, Akihiko Odaki wrote:
> On 2025/11/17 14:51, Honglei Huang wrote:
>> The error handling logic was incorrect in virgl_cmd_resource_create_blob.
>> virtio_gpu_create_mapping_iov() returns 0 on success and non-zero on
>> failure, but the code was checking whether to set the error response.
>>
>> The fix changes the condition from 'if (!ret)' to 'if (ret != 0)' to
>> properly handle the return value, consistent with other usage patterns
>> in the same codebase (see virtio-gpu.c:932 and virtio-gpu.c:354).
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> This should also have:
> 
> Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")

Really thanks for the review, will add fixes tag in v2.

Regards,
Honglei

