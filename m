Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6717ECE57E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 12:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sndt7-0007aT-4l; Mon, 09 Sep 2024 08:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1sndt5-0007Zu-CS
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 08:52:59 -0400
Received: from mail-dm6nam12on20612.outbound.protection.outlook.com
 ([2a01:111:f403:2417::612]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1sndt3-0002Xn-GH
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 08:52:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mm+xN7BmherSDVjnV0sNnmZQzZNTkmS2hCIUDu7X4/L0XTx8G2f69v4gZJAEN3DxqpL4YX5zhPWj0Ltxwfn0ESeg5DrarIfH6D12KZAoEFWi99g52RVTwloQhXZ78wbPnMNiJfBZSdN4CFpHtQiRakM/iwY7wwHFeVvU/x2Gc1hW1oBBAeK0eVCEMslewTrHakgTSWn2HSvOyjjNXX2AAERnKtXd6CwgTSFBdMyFVXscb4m4hrfdOcv9W69hyDalEbNjJVG6hnv9ccjZIbX35lrVVpch3ElvHmJdP+xQUM1mHpX9urqahYgdkdNePH8OUdXo8U1T1VHfNmVPPU6hAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cltW5C2Y940InkpQqMYSNCPzpMB/AtzMXOAGxpCa4k=;
 b=BD9mYGlQe0pxuxhE84t1ko/GlyTFAxT901U4w8wtM9Lo1Rj9Jq6epvjnv+Z0cxmbrfclpCPhceQxuCWB5CyyE5By/FkA2IIJuP/KX4atT2qaBZTMdywhB1e81Wt/9lLd984zc1qkR5fFmBrNt/LysUVDNBaLRUkuVNJfcmqQ+puk32WRv3gl+bvFEgFbdaVA8URhSc9eQdhXyhDnT2M3M4pUYdFwNUTQ9ps7kqndC2TjQuJPUaENUsXWh9EXKfne4QWR+3A6vkD1zQlJQnOdJLb4R0AiHvUA01C+HtPYhcYe7Pt6AlP/mheJXUhAUe1HtaQUE0MKahlcCeGrowLu5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cltW5C2Y940InkpQqMYSNCPzpMB/AtzMXOAGxpCa4k=;
 b=Y0J7e05bB7R1xx11HwfS8jwYtAjXEPdUbebneOC03sQiFx1CO8VdcNzDVh3P7UgcnbcY0nMKda0QugAQqFQguqk0HjL9+ONZ/ucHgAhFQZlXa8FoXeiN+pE3lcXAtTJsC/DTtcJ+LTdxkxfSWnPaNjTE3EX+PnrXiefCba2MEMNBJLnx5GKvMpTMuYh0aTvShNTWRMFCu7Nh0ug2XWq31iY0rKVj+e66uW+PkkxUP3c+ey+bBgU3w/bJjCa9exP5JJl3hlbFHICTgwNCW/d0rCXt2vgne8S1ZsXjBvFYh/BK3EeXEq4ydIBrSdaJlN+gJhd3pzMbDdKpPKPbWnw2lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM4PR12MB5916.namprd12.prod.outlook.com (2603:10b6:8:69::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 12:52:49 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 12:52:49 +0000
Message-ID: <c4eebbbd-00aa-4893-90f8-e6faeb08db90@nvidia.com>
Date: Mon, 9 Sep 2024 15:52:39 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 08/11] vfio/migration: Implement VFIO migration
 protocol v2
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Zhiyi Guo <zhguo@redhat.com>
References: <20230216143630.25610-1-avihaih@nvidia.com>
 <20230216143630.25610-9-avihaih@nvidia.com> <ZthZ1aW_JmO3V9dr@x1n>
 <95d10ed3-33ef-48a9-9684-3a8c402c5db9@nvidia.com> <ZtiHzQHJ4PgWc21e@x1n>
 <b8807171-567b-4e21-af83-bc2f6dbbf606@nvidia.com> <ZtnLhW-2eo8hA7bQ@x1n>
 <812e89c4-35d8-4fc0-ac10-ec36d57f215c@nvidia.com> <ZtnbD69EeXhR6FFc@x1n>
 <22f013dc-6c47-4902-9b28-08e916c3cf54@nvidia.com> <Ztn5CcxhzYR-SFfE@x1n>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <Ztn5CcxhzYR-SFfE@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0077.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::10) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM4PR12MB5916:EE_
X-MS-Office365-Filtering-Correlation-Id: 322569a6-6b97-4ae1-51e1-08dcd0ce4df1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ek54b2Zyc0xXZ3pTWmVoU29SclYwV0NFaGZqTkdYeDhvSlJzd0NsdXNaSTZn?=
 =?utf-8?B?R1dBMXZlcnBUWU9MYkx3RzZBYlE4cHM1YVFTaGt1NjJtekMyMm03dXNJb1ZP?=
 =?utf-8?B?OHZFb1g5MGlGQkIxOUtNaGdsNUNVeStnclV1VSs1SVB2UW1tTkpuZmV3Qk1a?=
 =?utf-8?B?WWhLZTlKRW0yNlZjb2ZkMVBQbjBjajFkcVpxU0JQZ0dCandXUHdUZ3BLY2tS?=
 =?utf-8?B?NFpiOEExK05wbFRrU0dHVlVqS3BuMzM2dm5uc3dYbG1hRTEzb1ZwU1BzM0Na?=
 =?utf-8?B?ZVp0SVVyVTF1WTdwUWxjeG5ZUlpLZE51bWNkZGhJbUdhQXMveU9SM1k5ZlFl?=
 =?utf-8?B?a2MvUmI3ZFovSXBuMnl4QzNmT1dVb29IdTVaV3dnOExDalg0RjlYcmE0d0Ry?=
 =?utf-8?B?YllSdEh1eCtqd0lUSWpnTDBGeUtZektkYTJiNEVVOC9ISzR2aWFsT2x2dkVK?=
 =?utf-8?B?cURHcjM2Y1pMNE9iYmdrRmx5TDlSUEpUOG9BT1NnV0pBVjBwNjdKVFlBc2dB?=
 =?utf-8?B?LzhmNnNSN0p3bFpDOXUyL2ZLWXBTMWQ1YmNGMkVFZFZ2cWRXM1RQL1AxcTZ3?=
 =?utf-8?B?bmlVNzBlMm8wRGlyY014T0sxMzh2Y1VDYkxFNG1Ib21ucEs1L0FBcG1xUlFY?=
 =?utf-8?B?dm4wWExyYlNISVRnMGwyQ0JWd3kzNWtvRmJOdmZVNEF0cUNsdXltYk02MDU5?=
 =?utf-8?B?UnMycmJucTJja2lHU1M5cVJKWDQvR1A0OHdIeG1WVCs0cFlGclc5ZGFmMU5I?=
 =?utf-8?B?MXpLZW5YWmxSdGs4VDNzRnYycUVraWVyV0NzcW5oQno1NTZNVDY2YTFUUVFs?=
 =?utf-8?B?V3dWY1MwWUFQMXRkdWlEdWxGT1hSRUMybGl6eExQMnl3MWVYOEl0a2tsbG5h?=
 =?utf-8?B?eDRtUXRqUE1lMnZha0k3b3JldHZPYjRxS0M1enlIanZZSk9UbENKSVRVRnRX?=
 =?utf-8?B?S2VjQTU3RldQN1VoQWhHK25zd3E2Z1dYWDQ0ZzFUSnpvN3Nrbmd4YjlscDkv?=
 =?utf-8?B?VnJxeTliSzN2aTVlOG5xVmZTOXcrK2VuUjlnT2hHYkJXcDFWYlZmUlJzWHlW?=
 =?utf-8?B?aUNVVkd2UHVLaHFxaUtNa1d0bytyMWhoZk1FRjQybjVNRU43di9tbTFVaWll?=
 =?utf-8?B?VUw3T3lpMTdwaVQzNFZHVWxiV1R1Y0JPWVlhWGVhb2plNVlDY29jMVFJaytr?=
 =?utf-8?B?ZDhFSE5JeHNIZGZVUXkwanJNM2hUTGhwaXJpcGNtMmxzTzZ3eEwvdEJhckN6?=
 =?utf-8?B?YmU4cGJrempTVnNmNWVSb0ViTnVGSGlLQUJRVUNTRzZEKzc0c3c0NGJ3NDFu?=
 =?utf-8?B?Ympwb202L1o0MzhmYjVnRlJ4ZDROQWttelk5ZVlseGhiNUVzb2VINkdYaTNr?=
 =?utf-8?B?aFljbzNMQzliaUV5YlF1eEo2TjRNVHhLM1BrTFptT09PTUNqbkNzd2FHbXYz?=
 =?utf-8?B?ZTJvOWJyN29TVUlhZThFT3hJcGVmN1JyMElVVDFJMWJZclI4SnIrQUFSOHRt?=
 =?utf-8?B?dWRxYThPVjNmT05LazNPYlJSQXR1NzQvWUJCYWlEd01Jc3NWTnJlWnFNM1g3?=
 =?utf-8?B?UXk0c21kbmN6cGVFbk54VE1Ld1pyU0YxVmlvT2g3cVdSemFNbDVKd29pMVQ5?=
 =?utf-8?B?L2VKSGlJWm1ibVl3NzNEZG50aWFmaS9UTFhwOUdEUnQ5dFNXbDQwQVVrS3V0?=
 =?utf-8?B?RVkxeituVlMzUHEyRFNEZ2haRktDUHRmREIvS1ltcENaVW9wZkxiUitocjJi?=
 =?utf-8?B?TlVHV0kvc0pCdnVXRm5CZE8zRGNKT2dpR2oyNmhvRXR5ZC92WnBjOFR6UXZQ?=
 =?utf-8?B?SGNsbExCOFRMakhTMk1jZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm5PZ3ljeDdmT2hVbGhndGRWcmpnVWFzUWNMR0U0QnorR003YkVBUTJNZXVF?=
 =?utf-8?B?aXYrVjVpemg4cXNIUFlpZi81VkQyY1gzcGorZWoxSnRBejFUM1JFOWNjR3lp?=
 =?utf-8?B?UnlJdG0ycHhWNU45RGtkRThWQzVXaDNwUDFheUc3Nlg3Z2NCc0pSZXZOeVBw?=
 =?utf-8?B?K1FVWC9xdnVycDlHbUpqVkpReFk4a1VYalJoQmVqZlF4MnphOTV2UHBVVFZ2?=
 =?utf-8?B?VEFxbE5rTkJkQkdpNWdwaldWU2E4MmQwSEVuRURnUktuQ1F6YkF6NTZ2WHh6?=
 =?utf-8?B?Y0t1bHVNcWRqZythR0VDc09Ua09SSHVpQ09PMWhjeHJQYkxRN0luT3dxT2M0?=
 =?utf-8?B?blpUb09DM0x0Z0lpdXc0OEZoMlMzcFRKZk8vK0NzVWJNYXJhN252ZnJOL01V?=
 =?utf-8?B?RFMrY1VJWGVmUVhVRThSWmNSbmtMNnFSeXpvZ21VQVRLYmFVcDl0alFETTlC?=
 =?utf-8?B?ZU5pZmRWcUk1cUJnNVI1NFhrVjZFOXFQMUovRzB3QmliTGRxaUdHZXVJNUFC?=
 =?utf-8?B?c0k3UUkwRmxVV1E5SEhvNmRBMzNnbUtIdzBHREhCcW0yRVVvUnJKaFZrU2Jx?=
 =?utf-8?B?bnRYRnZNR3RjZmFBbi84OW9kVnUvWEs4dXpKQ0U4RUdoNVdPRHFDRDQvVEdB?=
 =?utf-8?B?enNyd2QvRHdCQnVhN1hPeWFBS2d5VmhoY24rcEVOdVJmRHVOcmxnQXJnRS9X?=
 =?utf-8?B?cmFBRmJ4Zm9VVG43MmhqRTZIR3RkbUZUSjJFR2ZUd3dmdUlJWGFJazhKV01N?=
 =?utf-8?B?NXA3aUtSaFNWUzZUNGFtdGZGN21QOE1CSmlxYmFCanhGdkw5SFJzWmJjdGti?=
 =?utf-8?B?M3p3V3JpYVpyOHdZUVVXUTJOM0Mwa0V3V0NETHlub3RYamxuOWlkQkg2ak40?=
 =?utf-8?B?c2IrOXMvWEl4TFR5NC9KS1RxbjRHSEt0VC82WVhPSUcxT3hJamNVTkZKUUZ2?=
 =?utf-8?B?MHYvTVRNb2p3MVZSY1dnRUVTR2RYT2VrbkVaVkIvd2dNREJoYTkreFQ1YXVj?=
 =?utf-8?B?TmtJNTF3R2xOdWZSSktJd2VFODI1SFRnWXl1NVkyLzNPN01vRVg1aitmREo0?=
 =?utf-8?B?N2dGNXJDS3JodHNPaTczbFEwZm4zb01hQ1hQMGFFdEVwc1k5SCsvVDlFQVl0?=
 =?utf-8?B?RXBINnVZWkZDcFFQV0FmS2dtUjJzZkIvQnBTNWlESHB6bTRqdEU3Zi9xSzFY?=
 =?utf-8?B?czdaZ2NJVFlhSjRYZkdJeWVsaGFNdjZhbEdaVFdyME43NmtONkJlR3ZiUTJL?=
 =?utf-8?B?VXV5dThzN214VGFZZ0ZnUHBDdXh0cjZvM0JaL3Q0WEUzd1pqRG5HdUNqRUZa?=
 =?utf-8?B?L3Z6TUlDUmlTTEtidlNzV0EycnZSRkZJN3d3MjFndnB2THhKTzFScEIrM3RE?=
 =?utf-8?B?dEQ0bzI0Z0JVUkFtMkhYK0xybG92Y0xwUllTWmFnWGVyeDVwQlQxS1RUUHFK?=
 =?utf-8?B?NlJZWm9UTHNkTk8zOWRyVmtPL3RLTlNoOEJia2ROd291bXFNOHVINDI1d3Ju?=
 =?utf-8?B?UzdsUUNRaVpiWWVRb1dySXVlbDFYd2VwNkEzcGt6YmhIczIyWkNUZnR5Z0Vo?=
 =?utf-8?B?c2ttTGpDZTFWN28rUlBrMlNaa3NMeEExcTBMUG1seDdRMTk4YkFLTHFVakJF?=
 =?utf-8?B?SHpHUi9vMkdXbUFNT21teHM5ZUZyd0lBNFVQRUthblR4RXp3OU5GalljbWcr?=
 =?utf-8?B?bWhBNzEvUmlIbFFNZkZpL0s4bFhFNWdyRzJOR3Rkb28wZWNBWXpJTVVjL3lv?=
 =?utf-8?B?M1JkWklSVFB5U2tzdmF0WnZ4c3ZHQkY1dERIU2xCOEg5akMzVS9lQU41d2M5?=
 =?utf-8?B?WHFmVG9IbThrYXNNM0NBa3VqbWJJRzE0WFZyb2s5clNpY0llVHRpMFRURmYx?=
 =?utf-8?B?MXB5NUZWcnllMXp6RHErc1RIOUNEVFVxUHpRSk1vNzh5NXhCWjNUNWY5QUxW?=
 =?utf-8?B?dGlYeG54c1QwMjNrUnUxY3R2YzRoY2Rsc3pJK1N5WmplcGo4V2E2Q2JHaW1t?=
 =?utf-8?B?eFVWdkVmbko2ajVkTlZyZ2kvRFZQd1c2S2lITXo3eVJpV21uak5CRVlsK1Ar?=
 =?utf-8?B?VHcxM3dpUjZuK1RaNE9vTUg1amFYWis5L01ycUZHejJ6a1dYR29sZDBlRjFH?=
 =?utf-8?Q?JY3ar+ferema4X6bqm5Z4jZQM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 322569a6-6b97-4ae1-51e1-08dcd0ce4df1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 12:52:48.8929 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwJFJoqWGjuQLPo0zCM5ptgCLx46IjffcVhUit5Pe3PPHh2lqLdEJeLdGxEvQx0Xm8a7hj/T3QaSv7kyliYA4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5916
Received-SPF: softfail client-ip=2a01:111:f403:2417::612;
 envelope-from=avihaih@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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


On 05/09/2024 21:31, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Sep 05, 2024 at 07:45:43PM +0300, Avihai Horon wrote:
>>> Does it also mean then that the currently reported stop-size - precopy-size
>>> will be very close to the constant non-iterable data size?
>> It's not constant, while the VM is running it can change.
> I wonder how heavy is VFIO_DEVICE_FEATURE_MIG_DATA_SIZE ioctl.
>
> I just gave it a quick shot with a busy VM migrating and estimate() is
> invoked only every ~100ms.
>
> VFIO might be different, but I wonder whether we can fetch stop-size in
> estimate() somehow, so it's still a pretty fast estimate() meanwhile we
> avoid the rest of exact() calls (which are destined to be useless without
> VFIO).
>
> IIUC so far the estimate()/exact() was because ram sync is heavy when
> exact().  When idle it's 80+ms now for 32G VM with current master (which
> has a bug and I'm fixing it up [1]..), even if after the fix it's 3ms (I
> think both numbers contain dirty bitmap sync for both vfio and kvm).  So in
> that case maybe we can still try fetching stop-size only for both
> estimate() and exact(), but only sync bitmap in exact().

IIUC, the end goal is to prevent migration thread spinning uselessly in 
pre-copy in such scenarios, right?
If eventually we do call get stop-copy-size in estimate(), we will move 
the spinning from "exact() -> estimate() -> exact() -> estimate() ..." 
to "estimate() -> estimate() -> ...".
If so, what benefit would we get from this? We only move the useless 
work to other place.
Shouldn't we directly go for the non precopy-able vs precopy-able report 
that you suggested?

Thanks.


