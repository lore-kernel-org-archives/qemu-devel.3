Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E75ECCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 14:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBgp-0003uc-2A; Wed, 12 Nov 2025 09:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vJ8VJ-0006r3-P0
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 05:55:11 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vJ8VH-0006pc-Lh
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 05:55:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tg2q8kaLDKQ5zPRopt1HqcDAiXvzPINxbz8iDjiXeum4vQfNmvkvBSzpMJkd+SsBBFjDFyprOb2mlSRZIjWUuE8cL9Vqc9fI1Jtz3V6Z15g9udPKb+nv54NqTq2ZFHxSDT032C9tH458VbonvHiFwVOvO8redKrQf9xa/MQS+t+pGjVWajw9oL0Dq3rVVhxexHQuP2Gq2cQeBWadaHisk88FHaIT7+PzN753718v9RY6xkRdYXKHX94lnjUU/rcNOl/QKJZHQ9ipQRj+ddhGha07dmyzV+QidxdgAUk4f2gDCPI4J4HY25dVRFA7sEilz7XBXz7lSQ5gBUore/e/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlPEyLH58/0kNLXQzUJgeT6jxZNvptTSn50po6LO1l8=;
 b=HmNt78fhZYsZfSyhCXw6kuUtn/5K7u/3dlx9z/Ls19hcx5EohFZCd5i9KCoszjNbUjodRk8xn9bsuVlViYggAC138fWO6jovjgnfqGRCmLs/gymVjOn0OiBaHfh/mL8wCAe8WfqFEY5icrvqjifengTQ7m/JKT1/TJ2K6c6Ux4GgL1CEdos30ALn9+APzcFybJrlMla52AdJTbR64rVMplOSwLK/pODZquWXuD1xFRqFkWnhzRILUoEJ7e3AFD4Ulnv1fRpGxygU7SKq+jmBs4cRo6oldRDCQXznKoTon77gFtSP1V8C+h77AKJRTH7Hb0TypNVLUSBOupMG0p455w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlPEyLH58/0kNLXQzUJgeT6jxZNvptTSn50po6LO1l8=;
 b=EaPpcol78ApKHSmymMPGHWUFZK8FscbmPqBNdwv1joCnHf7UnlosWWzgWmIiIaR8I/p6D2xmvyO/ol1eqUtu7Osd08NL3zBDHvY9ITaiti3ZtftvCH8WcOI8YHAPTKaZVSQWpZOMLw4F6pZxukf/lm/YqnDJcBsIEC2TwvD/KOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by DS4PR12MB9588.namprd12.prod.outlook.com (2603:10b6:8:282::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 10:55:03 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941%3]) with mapi id 15.20.9275.015; Wed, 12 Nov 2025
 10:55:03 +0000
Message-ID: <9a6dca59-3238-48c8-aff6-b3dd97f391d1@amd.com>
Date: Wed, 12 Nov 2025 18:54:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] virtio-gpu: Add support for
 VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com, dmitry.osipenko@collabora.com,
 alex.bennee@linaro.org
References: <20251112075414.3719917-1-honghuan@amd.com>
 <20251112075414.3719917-2-honghuan@amd.com>
 <c07996e4-1565-4a3b-ba0f-17626f032fbf@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: "Honglei1.Huang@amd.com" <honghuan@amd.com>
In-Reply-To: <c07996e4-1565-4a3b-ba0f-17626f032fbf@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0121.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::25) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|DS4PR12MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: effab370-fb32-43e8-bd4b-08de21d9ee84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlpUTEhZN1JCSTJEL3lJUWJMdll3VG9HbVc2RndSa2c2aW45NHRvYnZqTDN5?=
 =?utf-8?B?WENXcm5ZMnBoWlh4T2lZTEtWSnU4b3BBY2s3S0VFZXMwZmFsT0s3ZDZMS2hR?=
 =?utf-8?B?bGY1MXJoQzJxUmZBbUswU2hDTHY0YStHejVzNWJuLzlobHJvMlVSazVjTzdk?=
 =?utf-8?B?WEUzeUNuWjNYRmNzTVM1SllnektGbUxYaTFUMVhvdFFWbytQaXZlclRtK3Vp?=
 =?utf-8?B?bzZ6VmVyd0laYUJyeG92ME1paGNXMzFreDdzSHZPUnZOeklxTHpPZ3o3Z0tO?=
 =?utf-8?B?dUg0VWZqRUdaRjdZMmxZaFFkR0ZzdGdzd3pZY3I5c05GU3lXVk9VZFVwTEZn?=
 =?utf-8?B?QTFaalMxTEtWTVNZVFAySmFyTS9KRjJFYmxNSGpmaThvSHVpcisydHJkWkNi?=
 =?utf-8?B?c3J4Z1ByQnd0VjBmb2o2Si9ycVhmQ2tVbEFSZVZCUDYwajdqT0V4MHFwU00r?=
 =?utf-8?B?N0dTb1gxNnlVaFFTL0N3M2VMK0Q5djJQSk8zM1dIcnYrdExBTXpWZ0QwNUxU?=
 =?utf-8?B?bVI0Z3J3ZHE1ZTRXelBkVlpIZUFJclNWdTl0RHJ1RjBEOEhXRTZaUFVpMmkx?=
 =?utf-8?B?MzlXV2tSQnJKZksrYTYzaytpR096MDB1a1dtMnI1THNQRGtTNVVTVStHcGxE?=
 =?utf-8?B?MVlnMFQwMWFmVVdDWGl1Uy9ZYlFwMkNNcmxmWXhWOHZvdnliTHhHNDNUZkw3?=
 =?utf-8?B?eCsvMTVMKy9yMEZkeUc2THJrTTB5dDk3MVFyU1YxR05YSjJJeStJWHl2YU4y?=
 =?utf-8?B?cEVqLy95cG4wQ01rQmx2NC9vY0ErWVpiV1V6TlZjcVM3eW1mc3h2d0gvY1lI?=
 =?utf-8?B?WlZOTWg0aHRWMTVBNmQrTlZKVjZWRHZWVDlsUkVnY0Mzd1JCNEpVUitlVHB0?=
 =?utf-8?B?dGc2TFJkY2tQdnpMNS9kK2hoSFI2cHRIUFRFZXlCcnBmRSs1OEZYMGZVUkk2?=
 =?utf-8?B?MFJjZHdIaW9CYnNvMCtzU2dTN3k0RENHV3NZcFJmbnNnOUhMMk1zQlAzS05K?=
 =?utf-8?B?VmdObGJIQkVMekZHbHhaOG13L1lqeENSMU03bElsTEd3cXFpckFKa2xxSzUv?=
 =?utf-8?B?K1RUTnBWYVpMTGIrUHNTaUtiT0ttQ3grM2krTHczMUVWb1c1K2JsQkFXK2ZW?=
 =?utf-8?B?cEFUT3l1RzQvQTEyK2dDbVNHWWQ3WW1TMzRJVDN2S0JuOElDWjJ0Z245eklU?=
 =?utf-8?B?L3V1UVdXWmRvNWNsREdtYlRCVnZWUmJZd3JYM3V0RGpUelY2YmpPeUhXWnFx?=
 =?utf-8?B?WFBhMUR3YzBkL3Qya0MrSFpoTzlRMFFLZmpBYjlKYXhHVE10RHBxN3l1NEtz?=
 =?utf-8?B?N3Aza3dQelpJUS93bHRIME52c2pVdFVOdTM0dGF3UHMrMmRkOVNaSExsVy80?=
 =?utf-8?B?M2VQZldXMDJ3R3ZCenBnbVN6Z0xaZHFSd2ZCaE9LTlN6djFiQTNlaVo4czhX?=
 =?utf-8?B?RkdSVGpic3ltdXdRNTFQY1UrUWR2TjNJNFBKaWNBQlFOOTVLcWdYajlTS3Fx?=
 =?utf-8?B?RzhFa29YRkt2bjlONEUrTC9RMG5tUk5ndE83c1F4QmJmdDRMcll6eGM0NlNv?=
 =?utf-8?B?ckxheUE4eDhOSTJNMmN1U3o3eCt1R29NdEtjNjgvSTIra0Y5NlpLOWFqZm5W?=
 =?utf-8?B?SDVVdTVxdGlqbDFKVXpxUHFpdXBjZmtFWVVvSTgrNjgxRFlTYmxlOURjYlRD?=
 =?utf-8?B?cDVWcld1MlZEb05RY2NQbGhHZWM1d1RMTzV0Q3IzVkIzZ2JqSkYyS0hHaGtj?=
 =?utf-8?B?UlNYeXBtdm94NE9wcW1ZZC9XZk5lTTlCU0JFTncyNkE2L0lPNUZZcmVNc1pM?=
 =?utf-8?B?dStMSk1lMEp3UG5nMGFhTDVxR3ZRdkd4bURZOTlsMDBjemszTi9HMDkveTQx?=
 =?utf-8?B?azdPTGpyTzhiZWNMMUNyNTRaTmQ1UzdSWjZSa0t5NUdhOWNmZ1ZwRGhxR3Fu?=
 =?utf-8?Q?Gpu77wCFsHCtYh4wND5TyjXihKQX2xc6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDRmTVFXN1ZwZ1B5SUpuLzlsZFRNMGVBejBIa0g5ZzdrU1RvZitWV0UyV3V2?=
 =?utf-8?B?OHIwaDN0MEpleFNSUmVXbEh2YnVtZUx6eEJWUmI1cDNvLzc0bzVwWEpCTm40?=
 =?utf-8?B?eTViVmplR2JCRUVaMThTdzAxUXdyRGhiN2pnU1lEdzBiV1FYd0tHbmFFVjdv?=
 =?utf-8?B?dzR2WTFYa2F4eUl2ampvVmRNcmdDTmJaS1daUWJJZmsybGpGVWtuRHAzaldE?=
 =?utf-8?B?ZW01Szg1NVQ3bnB6VXF5dWVKaXQ4NEpFQ05yU2NOVVdtRTFHTm1obGRVaHUz?=
 =?utf-8?B?RnFLbmFtc2h4cEN5T2cvbGlNTUYvcUsvQUFZby83U2VTV1FsdlRsOXB6ZHY5?=
 =?utf-8?B?aXZuYktnV2VYR2RpQWV6NU1CNldVRk0vd3UzR2k3WTlWOWlQYnljNTNZSTh5?=
 =?utf-8?B?K0J1SzNTZ2FkaXIvQTQyeU9BYXZiR2hiU2UzM1BCODBaRGpmcFQ0NlRWS3VF?=
 =?utf-8?B?OG1IelhGRC9DNVkrYW1zY0pFbDV5dHhPWTdFZm1JUE5TOHFXSG9YVG01VHE0?=
 =?utf-8?B?L1lmMTl0dVl6cnp1Z3haRzRzVXZzSnZpRVJtSHZmSDdIc05ZdXJIeG5XYkI0?=
 =?utf-8?B?QnMxMXMzQTd5bC9HQnZUZ1hmazd1YXdYanNsYW10clRaTDJPMFlvVEhNTkZR?=
 =?utf-8?B?NS9UZGFzV3ArRnFONkMzbTM3SUVMZ041VjFnQzcvYitUY0dEVEphMW9kRkJP?=
 =?utf-8?B?b2Jjd3IzcWlabmRicHAzcjRjdE05d013aWxvVTdpOUxxa2FwYUhmWExWRzJq?=
 =?utf-8?B?UVNvb1pzcGFhMmppK21ZdUVHQlN3cXZNOG1ybC9rMCt3R0hTakxtT25NSlFO?=
 =?utf-8?B?V2R2K0xZTGJuMHlXZ3lvTDY0TnRZL2JPeWIzWlRwV2hmZHNuUVZKamh2dXVy?=
 =?utf-8?B?ZTNtVm8rRVc5OU5uc0ptZW1veWlwekVWZlF5eWRIQS9hd2xkbkxCSEd4bkRj?=
 =?utf-8?B?SFY2Q00xczRmRmtVQ1BxdW1MN0hHK3hvNmtxeEZ0ODM4azBCdGNLek1ubEhh?=
 =?utf-8?B?TEc5Qmd0R0NrK2Z5NXErazZKL2RENXdpUzh2UU50YTBQNitmczh6dzlZSThV?=
 =?utf-8?B?K1JzQ2Zvb0FSelc0ZG41RGtIUjFWQWR0RitZcm1tdStHYjZPcHZVV1VodkxM?=
 =?utf-8?B?WTNDdDRLbURRRXc1c01oZUxvYk5xeU5YMlFzQU4zVjZ2TzhxUDMzTE04NERm?=
 =?utf-8?B?K0MwVmZFK2FCRndkVW5jaVcxR21IRVFuaWVmcmtiMkdWYys4UGk0QUNTNkU3?=
 =?utf-8?B?R3RxaDV6Znp5cWZyZlNIejI3TUZ3MGtPNm9HL2djYkMzZ3RzdDlSMXVzMkpP?=
 =?utf-8?B?VWlwQjR0bmhMejZOdDZNUFlnSy8rL0hJYkRJY0dQSHI0b1Y2bmJab0lKc1lP?=
 =?utf-8?B?cVNkUW81RE8yeVRQS2lpTTF2VHJzRitwSDRldDFVdzVlOGU4czk1RnpOOTJD?=
 =?utf-8?B?VmpvSFN3dGRCQkw0VFNiRUdSVkcrWldkNGFjcUlPVkt6VmhlY0x5VlJtdm9k?=
 =?utf-8?B?RkhIM0tFSUNCd1pKaWR1clIwUDJ4YlBjTkQ2ME5YQkwxaWtpTEd0NUc2QkhX?=
 =?utf-8?B?eUxiay9MQ2gzWHcwL3FLaDZlbTRYMDZNdGtzYjI1Z3lWWk5DVGcrT1lucEhU?=
 =?utf-8?B?MjQyMk9QMlR4YTlOejhLWU1UNDA0d1VsVTQ0eExMcUZMYW9uNU1kemZsMUpW?=
 =?utf-8?B?TERidEVXYkROMUxrV0RCcWZuaEhZeStNbjdlMTRnS3lzL2V2RnhYWTEzMWxD?=
 =?utf-8?B?bmFnVEo1MmdIMTVDU3VrdUlrN0VGcVlHcjhqRi9uNWxWY2NueVlVRjhCb0l3?=
 =?utf-8?B?RUlWaXp0R1lMQmsxZkVoRkRKTU5nU29BSmVSU2ovVWdNVjFYbkVlb25DM3hS?=
 =?utf-8?B?TDlaT2x1aFFEWW1MZmIzTG11Yk9PWXpyTUFpeFZJNGcwZkpkR2E3dGlYT0J6?=
 =?utf-8?B?bUxnaHZJNGFlUU02SkNuU25kejQ0NnJ4UlNWYVBpL3FDVU4wU2xiSkhoZ2dk?=
 =?utf-8?B?YzRtdVhWQzhlOWFvOEtKTkV0WUFsc2E3RlQzcmFseTdudjRwY2dTN0tTWFJ3?=
 =?utf-8?B?amVlMHh6eTc1dHd3WkhPSjJ0aEVOVlAyQU1zSGF4NitQc1I4a0JTZ3lybTNn?=
 =?utf-8?Q?qL4yHS1+M+T185G+uqi5cNyfi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: effab370-fb32-43e8-bd4b-08de21d9ee84
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:55:02.9745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPCh/QNa+NbGnoEQT1tIVWexKAyKUpru1FEKHmmsUubJhjv5tjf+9zEaEiqk9zMi8DVYwSeJF8GdoRq5DRR5Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9588
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=Honglei1.Huang@amd.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NAME_EMAIL_DIFF=1.305, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 12 Nov 2025 09:19:06 -0500
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



On 2025/11/12 16:44, Akihiko Odaki wrote:
> On 2025/11/12 16:54, Honglei Huang wrote:
>> Add support for the USE_USERPTR blob flag in virtio-gpu to enable
>> user pointer mapping for blob resources. This allows guest applications
>> to use user-allocated memory for GPU resources more efficiently.
>>
>> Changes include:
>> - Add VIRTIO_GPU_BLOB_FLAG_USE_USERPTR flag definition
>> - Enhance blob resource creation to handle userptr flag properly
>> - Remove arbitrary nr_entries limit (16384) in mapping creation
>> - Add conditional handling for userptr vs regular blob mapping
>> - Support guest_blob_mapped parameter for virgl renderer
>>
>> This enables more flexible memory management between guest and host
>> for GPU virtualization scenarios.
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
>> ---
>>   hw/display/virtio-gpu-virgl.c               | 21 +++++++++++++++------
>>   hw/display/virtio-gpu.c                     |  7 -------
>>   include/standard-headers/linux/virtio_gpu.h |  1 +
>>   3 files changed, 16 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu- 
>> virgl.c
>> index 07f6355ad6..9da64bf16f 100644
>> --- a/hw/display/virtio-gpu-virgl.c
>> +++ b/hw/display/virtio-gpu-virgl.c
>> @@ -702,12 +702,21 @@ static void 
>> virgl_cmd_resource_create_blob(VirtIOGPU *g,
>>       res->base.dmabuf_fd = -1;
>>       if (cblob.blob_mem != VIRTIO_GPU_BLOB_MEM_HOST3D) {
>> -        ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, 
>> sizeof(cblob),
>> -                                            cmd, &res->base.addrs,
>> -                                            &res->base.iov, &res- 
>> >base.iov_cnt);
>> -        if (!ret) {
>> -            cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>> -            return;
>> +        if (cblob.blob_flags & VIRTIO_GPU_BLOB_FLAG_USE_USERPTR) {
>> +            ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, 
>> sizeof(cblob), cmd, &res->base.addrs,
>> +                                                &res->base.iov, &res- 
>> >base.iov_cnt);
>> +            if (ret != 0) {
>> +                cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>> +                return;
>> +            }
>> +        } else {
>> +            ret = virtio_gpu_create_mapping_iov(g, cblob.nr_entries, 
>> sizeof(cblob),
>> +                                                cmd, &res->base.addrs,
>> +                                                &res->base.iov, &res- 
>> >base.iov_cnt);
>> +            if (!ret) {
> 
> Why does this check !ret instead of ret != 0?
> 
> Regards,
> Akihiko Odaki
> 
>> +                cmd->error = VIRTIO_GPU_RESP_ERR_UNSPEC;
>> +                return;
>> +            }
>>           }
>>       }
>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
>> index 43e88a4daf..956dc811fa 100644
>> --- a/hw/display/virtio-gpu.c
>> +++ b/hw/display/virtio-gpu.c
>> @@ -808,13 +808,6 @@ int virtio_gpu_create_mapping_iov(VirtIOGPU *g,
>>       size_t esize, s;
>>       int e, v;
>> -    if (nr_entries > 16384) {
>> -        qemu_log_mask(LOG_GUEST_ERROR,
>> -                      "%s: nr_entries is too big (%d > 16384)\n",
>> -                      __func__, nr_entries);
>> -        return -1;
>> -    }
>> -
>>       esize = sizeof(*ents) * nr_entries;
>>       ents = g_malloc(esize);
>>       s = iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
>> diff --git a/include/standard-headers/linux/virtio_gpu.h b/include/ 
>> standard-headers/linux/virtio_gpu.h
>> index 00cd3f04af..b85e781a2d 100644
>> --- a/include/standard-headers/linux/virtio_gpu.h
>> +++ b/include/standard-headers/linux/virtio_gpu.h
>> @@ -405,6 +405,7 @@ struct virtio_gpu_resource_create_blob {
>>   #define VIRTIO_GPU_BLOB_FLAG_USE_MAPPABLE     0x0001
>>   #define VIRTIO_GPU_BLOB_FLAG_USE_SHAREABLE    0x0002
>>   #define VIRTIO_GPU_BLOB_FLAG_USE_CROSS_DEVICE 0x0004
>> +#define VIRTIO_GPU_BLOB_FLAG_USE_USERPTR      0x0008
>>       /* zero is invalid blob mem */
>>       uint32_t blob_mem;
>>       uint32_t blob_flags;
> 


Hi Akihiko,

Thank you for the review!
You're absolutely right. I need to maintain a consistent code style.
I'll fix this in v2 along with making both check consistent.

Regards,
Honglei


