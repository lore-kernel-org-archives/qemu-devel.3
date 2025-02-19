Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AD8C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 06:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkdk0-0003Wf-1E; Wed, 19 Feb 2025 01:39:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1tkdjw-0003WM-Qs; Wed, 19 Feb 2025 01:39:24 -0500
Received: from mail-mw2nam10on20623.outbound.protection.outlook.com
 ([2a01:111:f403:2412::623]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1tkdju-0008Rt-AS; Wed, 19 Feb 2025 01:39:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJ5WemlNT+gDtEM8+1uOuM4NGe/fKu9Pl7E/GrCotsJRXErS1gVPeEFNr0ZTZVSTX3PEeacDkuWvcXxZi86SQGJvB9MPWe95obDKDSq8exZcyQt0zOAo/6CCLQufPFZR5PEeE8QdBhAnf+68va4cTGeBFvBeZvYqAFIIIxNjw+OnSLiyL6Bv8ykDBu6nv0NXwI/ZudxJieambq19yl31zv0xMRsdmhxCeKG3Gq/7nb+QX9Dc9Yg8dv73O59ssKA+ATd6Yq6OpW2iBJ0WMWQa9iJVCGExEDrGtF/ofaHqDUVsjtHGxhJ49E59KSE3Zc5eXEuaZ7XUIzZSFtb30jhiPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqQ09juogFI+wawxwY1hPwIVodkcEyuxyJNic/yEmxE=;
 b=PdUVPXpShy372Dx2psD36jPteUzETM5a4jtRLTwJPBWda2ymk7OUMmcV2644CBC7eSJvhScGuQA/1l9qHsMPxALa74fRt/G2bAN63JKFud3ZT/Z5pz0a0Tj04Bm+n7XBchsfhq2PlcD4D2fit/ZZVVnQsrnyKuYtE3/pV/jD/SdKzs5u1U4JZ2jTTPRUOjoDzu8owwKK5Tq5oBtc8QX4c8WkuBSZoPQDGDCcnVe8GVG7rr6mhdEKci2e850u6oQLpP5+BmyJE1g/Z4Ab43DHBT9NMGIfx9zAu0xCwmIOTp7vutIQkJSYDNCRhyb7XmoC1cox0iTO+DdOV/Rvq24EtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqQ09juogFI+wawxwY1hPwIVodkcEyuxyJNic/yEmxE=;
 b=kKoOXJ6Z1HHbK4FGq9whx942sMWlcb+xSvOUqKRb6SRPcefiNf/O0gsICtCLWZD/puULR3mEqZJBtVP15ndbIb3t+E5u3PakS6tpabmvHFeZ67n+QHsllTawB/limDwBGHNfQ4EHQ9b7cUZE03WCNlqKI6rncf0SUVzqUAO+d90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 by DM4PR12MB5844.namprd12.prod.outlook.com (2603:10b6:8:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 06:39:12 +0000
Received: from IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48]) by IA1PR12MB8189.namprd12.prod.outlook.com
 ([fe80::193b:bbfd:9894:dc48%7]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 06:39:12 +0000
Message-ID: <6442decd-7576-427c-913b-9da118602db3@amd.com>
Date: Wed, 19 Feb 2025 07:39:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] physmem: replace assertion with error
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-stable@nongnu.org
References: <20250217120812.396522-1-pbonzini@redhat.com>
Content-Language: en-US
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20250217120812.396522-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::15) To IA1PR12MB8189.namprd12.prod.outlook.com
 (2603:10b6:208:3f0::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8189:EE_|DM4PR12MB5844:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc4ab11-3e09-4362-3301-08dd50b01f0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bitLL2VZWWd3d3JLSDllUWRDZnh3Y2xNcnArYUgvSWdYbTU2RWljczB4MGtm?=
 =?utf-8?B?QTFvcDdMY2NnWFlDS3pGLzR6OVZjME5TOExKbDFTaWM0d2RwU0JqUGVFeFh0?=
 =?utf-8?B?Yi9la256VzhRQ2tCelp3MFhvOGRrOFJ6Nmd0UzB6Ly9kaGxOWlBIb0NIQmlC?=
 =?utf-8?B?bWE1ZHFpT0tYYUFybloyWFIrKzdxUUZjQlI3c2gwVjZOVjBtQ2R4WkU1RnBY?=
 =?utf-8?B?WUZoaWIyVHhGRG1DKzRrUEZBeDFvV3ZqaVNqVHZyYTdiSThJVncxT3U0SHBw?=
 =?utf-8?B?NnVOMklpa2tzOWhzcVpwQXU4clpnLzhMejhuRVp6WUdCS0FhNmovS0FaNW81?=
 =?utf-8?B?UG1XeGJlRFNzakxYb3JkZk5Dd09OVVJQZFhYaENpOHJpYkRxYnQzM1pUS2k0?=
 =?utf-8?B?czhEL2RUT1J0dkhqYzB3TEY2YXdJK0lIeExuejE1Mkl4cDF5TE8xYzNnMjVq?=
 =?utf-8?B?azdmMTU4VHBOVE5xYlJGSDJ0dGpZQlVsU1NlVWJ6cWZ5QXJLbFNPbWZ1ZVdV?=
 =?utf-8?B?Q3UwUnFZa2prNjF4M3dhR1Q1R0RUQ3VLL2MyNkdCWkxXSFMxOUorK0I3S3h4?=
 =?utf-8?B?OUxvWkhxNzdSN3k5dFdDSi9aelBLZkZBbDVDVDZzcVpBbWs1YTdWR04zVmpy?=
 =?utf-8?B?VWk5cjhDZ1hjNlcrc1BSUkdHOXRkTk1qbVRzMks2RWZSSWF0cUhQaVJ2N3Rq?=
 =?utf-8?B?MVVtT09EQ3RtdXQwTklLSHA1cEN2SEd4a2trem14aW9FQnRzVjBqU0JVVlF1?=
 =?utf-8?B?MVd1M3d3RmFLekxSaFMyQ1BmdXJHN3hxS3BpeGJ4Z25kenQ4UDdxYU1oYTZO?=
 =?utf-8?B?Smg2YWRoV2ZWTVpQLzVCZGgzenMxK1JKOW0wbnNQZHRVdis4cStFb1ZIZkVU?=
 =?utf-8?B?Rk1JTUQveDhyckdkekxuMlVUZUovUjlrN2xXczJXVTRSQjJpcENvbGExUllC?=
 =?utf-8?B?bWhaVDhTN0lxakk2MXhDd2ZxeVNBZWk2Tzl5WkFCQkRCbDZtQ2JSa0J4aHV0?=
 =?utf-8?B?TDZnczlHcjhjVXM3cENHV1ZhR3dVMDcrTHFiNTg3R01zdzB2N2gvRmpJSHFG?=
 =?utf-8?B?ZE9tTE80Mndaby9SZVl5elZFYTJ5V3NlOW9kanVHWXR2ZlUyUGV1TjNPZ0Fq?=
 =?utf-8?B?bEtXSzl6NDFnTDZ0Qi9sU09TUW1tamd5bSszbEJUMkFOcWRnYVg1aFRIZlM2?=
 =?utf-8?B?R25MS0tka1NPQklLbTBRenAzMDQ5UjVVelBHaGFwQVBLaURwV3FDR3BCQ2hI?=
 =?utf-8?B?LzVMVEhlRkRsM3VBcE1oRjJzR1h5UGVqT1RTRGpsbXQzVmNjakhMSmFvSWVD?=
 =?utf-8?B?Mkk0N0hzcHM3MTdzeHcrV3l0MHp6Q2NhWHlMall0aWRWalRHQmZCRjQ0ZGU1?=
 =?utf-8?B?TGhrWDlzYndGK0JwZmNSUHVtODdzMnIxd1cwWTh4TitTekQrN2w0TVVYc2Uy?=
 =?utf-8?B?d3hDQlpDQUlCTWY3cnczenErekVaVmhORXdmZ3Rzc0RjWWtKM2VJaEx4UVg1?=
 =?utf-8?B?M3RtNmNKWnZZTmZHdnN4UXBjTmVHRStQSnppYXQ1QWRBRUtlOE1walRTOGtV?=
 =?utf-8?B?NEY4Y3hMODZ4YnR2NkxLb1VMKzNlYU9vOWQzTXQwVm1QTTJUQXkzd3pUdUxS?=
 =?utf-8?B?aTZvb09xVlJZVW1zUFFUU1R0aHA2WExkaVh5NjhPZ25HVWpoek5vM3JNOTV3?=
 =?utf-8?B?WGZCYjF5RDJ2T2NrY2tmbzJQUkNSZ2dLZ2VSbmo3L1VXYVkvVlhLVzNFZUd6?=
 =?utf-8?B?dGhDZHZvdDlaRVVpMTNJNUJlL09vU21xT0M3ZGxYREtRZnpmdzZwakcrQmx6?=
 =?utf-8?B?RlZkd3JuSUo1aVJFOG45SENuZnE1WWlCOEYxUE9QamZUamt3aVQ2elROdUto?=
 =?utf-8?Q?s16HKo6aTzHMB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8189.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEVLbktvNWc4MVp2dlJLdktkb0Nkbis3RUlZWkYrbStHOW1aSTd1cHRMdXdO?=
 =?utf-8?B?SmgwNDVFNDRNN3BzK2tEL3hKUFdTQzdKNzlEVlRISWJvN3A2TFd2eisvMVpU?=
 =?utf-8?B?Uzl4bTlUZVRlTUxObjM1UHZ4SzBlWU92eU92LzNFMW9tTVZQZ0txSXI4RU5z?=
 =?utf-8?B?MXM2dUZGemRsY2hrbzFuZHFYQjVMcGQzMXZ3N3JreEptSjZQUnBHNlVCZERY?=
 =?utf-8?B?U2pWek5HZEVYQndzS0ZybVIrUEV5cVZzN3NuNWtqbW5xNjl0U1plMk4ybGJz?=
 =?utf-8?B?MUVuU2JCQnFxUkdweUg1R00weldGYkpJdWlSZ2dwbW5DNXhxNEJqdEZrME8x?=
 =?utf-8?B?elY5ZVErdHpjSjQxdmdZazdFTlo0anlrVTk2eUxMbDJGN1JZdG1sT0F3NzVF?=
 =?utf-8?B?aEs2WHdtNDNHeXdocUNPS096ci9uRnlkUEdpQXRPSnJQMElIZFkvQTF4OFhM?=
 =?utf-8?B?eEZ2d3lnUjZKdEVBR29VREJGZURhdnBNVUdUYmhVR1VzUGJkNVE4Q2RJaXFz?=
 =?utf-8?B?NHZpTWp3SjN0SVJiTVZxczJKNFg1YWhubVF6cmZmdk5MOU54Nm9YdFRFMVJE?=
 =?utf-8?B?VjRKYzh1QXRZajQ4cW1lZVA4ckdUYlRnQ0xuSmF1OFJQT3VFZ3RHYTZqUitI?=
 =?utf-8?B?UzQrSVExL09uVjdNVU1hN2FBaVl6OXhBc0MzUW1qZ1lQTTBMdHpSa3k0M3Np?=
 =?utf-8?B?VEFJU3JaakVvOWxDN2oyUjJId1VZTnVuR05VcUpCR2h6d3F6dFR2TjFOR3Y4?=
 =?utf-8?B?RmYveGdQcWJzOUlvZHJSTHJFSUJjTWJQMXM2aUJXUTM1aFhyZkNhRmJXZFBu?=
 =?utf-8?B?cXlvMllEL2Y0WFFmWkNoV0VtalNRaEtUSzdkRXB1em1Vb29jeWRpZWlxdlhK?=
 =?utf-8?B?N1lkYW80eUR6c3lUcGcxbnZWd3Y5SjArRjFQN0EwOWF0L1h5bXVmSVVUeXBz?=
 =?utf-8?B?QTVsTGVEOTZ0eXI1N2dHK0VSY1RLdklWUWdNeFhySkNaYUcycjE2OFgwTWwy?=
 =?utf-8?B?QVZkS2lVUHRPelhSQnhkdmVYK2pLWmNkT1BkSHMxeFAwVFkyZERya1ZQelU5?=
 =?utf-8?B?UWFsQWFnaFg4SWwreVYzUU5kOURTcVNUUm02WlZGZG1raXhrb3F5YlNzS2J1?=
 =?utf-8?B?SEIrWmo5YXhOb1lEMG52NTBCWFdZTDhRM1NUT0FGa0I1YmFzNUtaVEh3UEhi?=
 =?utf-8?B?RmhzdWpxR2hLeDRkZUp5VE5ERDlhcUtoczFrelkveVZlVjVodlM5d284OTYv?=
 =?utf-8?B?WkJrcEx5QXBnVGxJMWd4N2tOcTVxL0JrQzJ4K096U3Z5WldjdzVSRzcvNGdt?=
 =?utf-8?B?cVJmUk42akhFSUk3TkJYMi85T01ZV2FIUGl6bTBXcUlSR0RKMGdWTVlWcjRR?=
 =?utf-8?B?KzcwL0JjUnFzbSsxS2g0ckdvMnZtbE1tNjI5VUtDaFFNeTJjbzVERi90a3ZK?=
 =?utf-8?B?ajZ5dHg1NUNGOHR2eGVvc3RVSGJXZmxySTc1L2dNSllIcnhNRUsycUVBUFFC?=
 =?utf-8?B?d0lhZTh3U0NUZlBnWlFIMXVwQlJuNkNwOVZIbUFSSEdzYkdpNzYzVjJYWUx2?=
 =?utf-8?B?VDYyN1BqWUs4UjhxcnpSRlkvMnVLSWhodWJmdmtpSW1iNUl1eHc3cTdjLzMw?=
 =?utf-8?B?TjQ0a2oraWViYU5SRFNHSlFZRVN2dXRSSDVlemFucTBXR3g1U3Z0TUh4MmRC?=
 =?utf-8?B?K041RjNBYTVLQXc3SDdOc1UyQURzM3BmR3psWmZkemUrcXdsZUNuZHIvTmt1?=
 =?utf-8?B?RmFCOVBuOWlFK1N1ZlkrVk9GMGsvYW53b1pucUlNWkUrbGMxalhYUlNhNkY1?=
 =?utf-8?B?Wk90QkU2ZCs1SWxCV2ROQ21WS3lSbU9ZZVMrUXJ2MWwxajJLais5Vk0xdDdr?=
 =?utf-8?B?cVczWUpuSEF2UnRUNHJySkhqVkJ3R1llVHRpbzlpeHY1WU5FM3ZYN3dOdzZ3?=
 =?utf-8?B?b3RVR0VVd1l5d2RWcUw1UTEvaVdKSUFmR1dLemZ6SVdGYUF6VnVxSnVmSXVE?=
 =?utf-8?B?OVJpZUtzNEs4MEhUL0Y0L3hINWdDckRpQ0pRc0JYM3cxcllteDhCN1dtb2Fl?=
 =?utf-8?B?SnFXSWFNV0ZlS2ZtZGpzM2VnUDF5ZTl6M2tSS2tSc2ZvbG1KMExLV3g3NlNP?=
 =?utf-8?Q?PGi/ViK4LsJ6WysRFEGTihCRB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc4ab11-3e09-4362-3301-08dd50b01f0b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 06:39:12.4128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEuyB/uv97UDccPcvUAHQlZMp8t9IQnAOx8pilv2uEMKibydEfMGidZAWy+FlYqj9gbolz+ZvD8XKvAH5dqf9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844
Received-SPF: permerror client-ip=2a01:111:f403:2412::623;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

On 2/17/2025 1:08 PM, Paolo Bonzini wrote:
> It is possible to start QEMU with a confidential-guest-support object
> even in TCG mode.  While there is already a check in qemu_machine_creation_done:
> 
>      if (machine->cgs && !machine->cgs->ready) {
>          error_setg(errp, "accelerator does not support confidential guest %s",
>                     object_get_typename(OBJECT(machine->cgs)));
>          exit(1);
>      }
> 
> the creation of RAMBlocks happens earlier, in qemu_init_board(), if
> the command line does not override the default memory backend with
> -M memdev.  Then the RAMBlock will try to use guest_memfd (because
> machine_require_guest_memfd correctly returns true; at least correctly
> according to the current implementation) and trigger the assertion
> failure for kvm_enabled().  This happend with a command line as
> simple as the following:
> 
>      qemu-system-x86_64 -m 512 -nographic -object sev-snp-guest,reduced-phys-bits=48,id=sev0 \
>         -M q35,kernel-irqchip=split,confidential-guest-support=sev0
>      qemu-system-x86_64: ../system/physmem.c:1871: ram_block_add: Assertion `kvm_enabled()' failed.
> 
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>

> ---
>   system/physmem.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 67c9db9daad..1ddf9fb10d0 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -1882,7 +1882,11 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>       if (new_block->flags & RAM_GUEST_MEMFD) {
>           int ret;
>   
> -        assert(kvm_enabled());
> +        if (!kvm_enabled()) {
> +            error_setg(errp, "cannot set up private guest memory for %s: KVM required",
> +                       object_get_typename(OBJECT(current_machine->cgs)));
> +            goto out_free;
> +        }
>           assert(new_block->guest_memfd < 0);
>   
>           ret = ram_block_discard_require(true);


