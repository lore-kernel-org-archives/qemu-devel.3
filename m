Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E083ECED606
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 06:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syPuU-0001v2-53; Wed, 09 Oct 2024 02:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1syPuR-0001uh-PM
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 02:10:55 -0400
Received: from mail-bn7nam10on2085.outbound.protection.outlook.com
 ([40.107.92.85] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1syPuO-0007Kk-95
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 02:10:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7CCzl1i+lTrO1yIwsWjOY9lCGERJsRiwtxTP6TWsc73GS+lVz/LM/IEfNJ8iieC1zGZtMX40QGPKuNWNzBC+5b2WpU7Dqtl9ZNUcsA0cQ16iT4ARZBtSxX0GdPYjUCs/Smg6Jbb6L/Zg3VNC5Ncaz8IvCtevHXSo5udHc081LHzybFq3NWGcg4kGmXLmm3lh2kHYgBvTdaaG9pZ5728MTY0W09+H2Gj0LzJw6AqvEnN4bnSX/zfpYaeY9v/f8KPKgUgg1hnHL9orN2HhL1puvCbI3MRlNA9n7VDQFpKkr8GwrY5dLSDWKK7ImBf6/CGb8VCgYpi4Xkwh0k90aCLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1Lt3KznXWMNHlUECXyUiGHuQiWuGIJ1LnwxfsOKFco=;
 b=lOTxZo8YABIVoruDJTDp6rTLRnmkH91ZxMqxa0GEBwAXz+sU1rd2hnYASR7/gVHGzFm8c6vTnBF3uvOugv6Hfustz2+IKL3pVipjVdMPkZh1q9dQT36tNRXOESrDakA/z23N9wdFuRcFcxJ3q1uqYm7EK+h5vEOjV+wdzc6WlxGDR2w6Q0Xq23bMybxt6RW1GXKIupIw92gKfguvNUXQwl3+wQboq/u/egzXMMHlmkhnPO57c/k5U+Jnv4T4m+E/hgoGZ89aMF5yK/QiZKbKWrb3rPg0l894dpflcfof3uUuq1miwYxgS3eVdcRlOP/WqS4hWSwLn7VI23gjcUGfvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1Lt3KznXWMNHlUECXyUiGHuQiWuGIJ1LnwxfsOKFco=;
 b=wuuarrrmCtsSlQC43Gzt6uUZmI0y8g0IHoWQBpipphTGE7wEmdTMkplkxwQgL/SgZdxYsjGyII8FTQcYbWBWVJr3OnCpD4ZCmMkauqZsXa6q0P3pz5+I1/VElY8mubCWKLBOM6+PPbf5JbGsyj9a+ZldvcZNeRdh3Wp0ZNt6e44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 06:05:44 +0000
Received: from CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750]) by CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::2300:2257:1877:4750%7]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 06:05:44 +0000
Message-ID: <42e3067c-1e87-9e17-2e89-4a0b910d9f61@amd.com>
Date: Wed, 9 Oct 2024 11:35:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 0/5] Interrupt Remap support for emulated amd viommu
Content-Language: en-US
To: qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: joao.m.martins@oracle.com, Suravee.Suthikulpanit@amd.com,
 vasant.hegde@amd.com, mtosatti@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alejandro.j.jimenez@oracle.com
References: <20240927172913.121477-1-santosh.shukla@amd.com>
From: "Shukla, Santosh" <santosh.shukla@amd.com>
In-Reply-To: <20240927172913.121477-1-santosh.shukla@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0131.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::16) To CY5PR12MB6323.namprd12.prod.outlook.com
 (2603:10b6:930:20::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6323:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f2e727-89f2-4e9e-67e9-08dce82868eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czdwR0xUMkFrcEV6aFZ6UVppZ1ZMZWZOTHFyNk0ybTdwWlBTSXc5K2s2OFdU?=
 =?utf-8?B?MEVyWUtBYXZPa1BtUGp3SVRjcnhEdnZybHVDNjl4cEp2ZzlXSEVqbXFISFBU?=
 =?utf-8?B?S0dwKzgyMEhvaVNRTmx4QUJoMFgyYmJyWkVXVk5CZ3NYVkI3eHMxajFBOFQ5?=
 =?utf-8?B?NC9icTA2SDRBQ0lmNXZzRWxmRGVnVEl3UTIzUkpXTDYzMW9yNFV5LzRPcDY4?=
 =?utf-8?B?UFg0RE1zTC91UW04d1o0ZGM5NmZWalBNaHpnWWkyY01aWFlMbm5aWjJkYnVo?=
 =?utf-8?B?b3FLajRZcTNlY3lrWkNNSW9BeVpvbmkzZjRXN1laTkJyTkhOSkpya2xmZ1lr?=
 =?utf-8?B?amlaODFMeVZpeDE3dDB2VW5GQmFnd2syWUw2S3RLTVhMRU9sRzJ2N0dObXRD?=
 =?utf-8?B?UEFxWGlic3VMQnNBNW1rVEpHTnllSHp0T1k4K2h4S1NyYmdsMG5YWjdKbE5u?=
 =?utf-8?B?UkIyakdXZStHOE5ndWNUSndjaXRpYkNpekN0azVWY280Z0sxdHJodXBCSS8x?=
 =?utf-8?B?Zk9lQkRYQXpNZ0Q1M2pndHlQWVpUTVZzbnptRkExeVlaNlVEV0FCbmtaUmZx?=
 =?utf-8?B?UVJ4REFUUzhGV2hwWHJ3V3Q1MzFYdFFudHM3eDI0TUpJRnhOVTNpTkN1dDds?=
 =?utf-8?B?Q1FiRWhuRSt0ckUxQnhKQytvSktid3dOVVl4SjVZL2RkdytrRTVNZVBSZFBk?=
 =?utf-8?B?SjF4Nys2ankrM3ZLZkxpcnVOZGFoa0xIaVl1dmxJSkRlVWRPTXhCVll5UkV1?=
 =?utf-8?B?SHFQeTY1bDRVL0JFN1hoN3AxZTY3RkJPOUJGUVZoVVlobmhCN09PemF6TjNN?=
 =?utf-8?B?Y3BiTmc0cERGYVdFVWZub05tdTNadWFiSHkwY296cm11MVlielJwbzJmMzhS?=
 =?utf-8?B?ZEROWEU5ZlNHVzFuY2RTZzdkQkpPVUMzSURtK2k1NW9IaktyVzc2WVNIQTFB?=
 =?utf-8?B?QkVTd0FMRjB1cS94RGFRZy9wU2hrODdHS0g1dEVUYnJPSHQzZVlTQTJBSzc5?=
 =?utf-8?B?RmJYN1M1cDRlcWFNd3J1NjdIVytVcFduRC8wcnZpMUxwQnVUQVQ3UVJWbUNx?=
 =?utf-8?B?K1VsbGc0SmhwMEdzS0ZZaEtTTlhaM2w4V2RSTGtlRTNGNmVpNkZXWElJSHRE?=
 =?utf-8?B?aTFhZjJidUord1ZrS21QczlBTWdYMjhNSTQrVkt3YWRCRyt5aUJ2ZzJUaUNv?=
 =?utf-8?B?b2Vmc01RNi9VMHlmeWp1aEJUUjRXM2hPdnJrU2pXSWR5OXNVUWxoNFFtS0tr?=
 =?utf-8?B?US9ldWh2dUhDQVRLMmV2b1V5YlFyUTlXc25EL2V4NGkyVS9yWi9IaExDdld2?=
 =?utf-8?B?MUZPY1BXK045eWFXMWEvMUlBSWZscVNPcWl5SlNMRkdwZWswTTYreEFleUUv?=
 =?utf-8?B?S2trdFlSTkt4QnI0eS95dW5Uam9WK0RYekFKQ0dzd1BVMG56dm5DT28rb2Fr?=
 =?utf-8?B?ZEtrOStXQWI0bHo0TGRBZkw2L244UEVYYm5sYU5WTVUzYXAydndsNGo2YVpC?=
 =?utf-8?B?cXdyMEErZkpzaVFJUnI5UmtJZEJLQi9UeTVUZysvZk0yZEVWaStROVZQajRZ?=
 =?utf-8?B?WFBNeWdWVUt0dFVwTEg5Q1RKOHU2U0tkVnhMYzBrWmFzUlpQS2Z4QmtsL1o1?=
 =?utf-8?B?TzYvODFFc1YzbmJta3ZoaDJkTk45NWRNUFdic1AyY3lKUXdnRm4yakc0RVFT?=
 =?utf-8?B?aVdIbEZvZ0ZnQStTV3YrV25uWlJrekJBc2gyYTE2QjNieElCeVVhZlg2WDE2?=
 =?utf-8?Q?NE6pHgMZPLFK7jZc0A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXBPUk1WYU5JY2FHT2hqUjA3Z05wbGNMV0hUU3k5OTd6eFlrMUUyK1MrVHdC?=
 =?utf-8?B?bUVaOVZzN0R6UWE2WE13bGNqWjBHSUhkOTlaaEUxOGFRTjRMMUE4UDZHRm5t?=
 =?utf-8?B?Mkx0WnFYM0hiUUdMV2IxY2U2UlB4L0VKSlhiS1ZNb0NwMUs1QmhzcmJxK3lw?=
 =?utf-8?B?SmplNWd5dzJMZVRNOUNRclphUkNnZUI2VnBrWHpMaHJURHg1NWdReUhLNnEv?=
 =?utf-8?B?b1d5bjFjcHBEV2wrd2o1dFN2TXZQM0h0SUl5TEFJYWFDWVZxOFA2UzhBdm5o?=
 =?utf-8?B?SlBPbDI4YlJ1bXhJc3poakM2L3I0ejhLMVFTSzlSbHk3ZS9PbkNpWjRabTBO?=
 =?utf-8?B?Vld4UlRMSW4yVXcwYVRlMTVJTW1ub00wWjRRcTF3bk13b3BPejNiajVlZkZl?=
 =?utf-8?B?cGZMdjI0d1lUUnZZbXpRL2kyVnkvczcwcTAvZVgxQ1NsdGU2aCtsUEhoQjBB?=
 =?utf-8?B?MGRyV3dKTFN1QUVLNFZINlVnd3FqcWlwaFlrQjgrZHI2VWoySllGZXVhd1dI?=
 =?utf-8?B?a2xoSVJEc1BLeWVVNkJzTURBZ2daNVVrZFN0NlJscUZaclpDSUpsUy8vSzBR?=
 =?utf-8?B?bXVWa0htSnppYjIyME8vU3FNTXRaZ0hUTWJwQXF0K1RpTitJRzFoVHBpcEVv?=
 =?utf-8?B?Nm53VG4yWE9laE9QZEFpZnRJamRTOHRjazNFOFN2amx3T2gwU0VoN1BaYlFl?=
 =?utf-8?B?b2hodDZhanR6bU5XTEIwWmhTdEFRdUdxaldxR05Ia2V5eSthRkw1eFFVL3pS?=
 =?utf-8?B?Zmh2Qm1IZEs5MXFpTldUS1lab2xNMm9qeTN5NWxVL1NPUDZockcvTVJ5RE9V?=
 =?utf-8?B?T1RzQ090N2hicGNiZnFEV08vL2VZRThtVGl6RXQzWmpJUThnZGhLOXZlN0h6?=
 =?utf-8?B?UGhLUTJxempqeENNbDR3L3ZSem96RXR2dmppRlk3b2JISEhQc29pSnltKzht?=
 =?utf-8?B?enFma1dmc0dNZXlOODRWK3BCMklycnQ0L2p3UC8vNm1PY05SZEpHL2FUc09j?=
 =?utf-8?B?K29Tcmw1KzV5bnFzaXJrTG02aVprMjhidGZTSmJZQllwSVhLUyt4eVZ0WVVT?=
 =?utf-8?B?K3RqMGhkTUh1c2dxUWgxWE16cHFOTUdNZWc3emF3OHQ0L1VDUTVSQUh4QWI4?=
 =?utf-8?B?QThrWGRGb255bnZkaHYyeEtTaFlTVXhqTlhwUDRhTVZPNVFWajM4OGg3eWdw?=
 =?utf-8?B?bjRoanltNWtTbkp3M1pIbFFzYmJBTTRPdUF6Wis2K0hZajlOcVN5YWdHcGZm?=
 =?utf-8?B?TWFjR2VCTndkNWN3ZUI1eWs5bno4eU5EbmZuUU5RdDkwZTZyS2R5by9kYjha?=
 =?utf-8?B?Sld3TG5uMHdJWXVyZjVOeklZU25ORVAyZ3hJWkxRK0FJYkJZaG5kY2RhdjNy?=
 =?utf-8?B?dGp5d2xGMzNwMS9wRUN4WTJ4cjRWYmNxZFNMMndRRnZ6OXoxOGdXZjZ2U2d0?=
 =?utf-8?B?c2JaNFFDNmZmazdadS96YXNlT1Y2RVB1c2hqNzhjSG8vMHkwZkVqd0w3bGoz?=
 =?utf-8?B?YkdEekVlZ0g4SFdZUjlITXhYMlltby95WmplWTZ0TWxFSGNlUlA3MDR5UHRj?=
 =?utf-8?B?YTdDYnl1SEc0MlFuRkx0NG1za0VjWUN1YlhDbWlqN29FaTJOYWpySkhETFFH?=
 =?utf-8?B?aFd2V1B5OTBmbmh4cFlvUGlnY1BhMUhMQlhCcG1nbzRGL1VmWDVQc2l5djAv?=
 =?utf-8?B?QXN3aUNSRVhhYU9PcDNQdDloalZkYVNzWHo1K2p1WGNSRlYzV0U2N2JFY0R2?=
 =?utf-8?B?OXpzOUtZelRQakhlYkk1VnI0ZjhzNVJNdHZsSU84UVBDMnJrcDB3N0V3VTAv?=
 =?utf-8?B?cFh0cC9pM3ZPU2NtdVkzZlJVaFdZakxiSWFhSmtuTnZ6clJoNStVM2c5KzBm?=
 =?utf-8?B?bWpKWGR5SmxSTGh4ZnJvSXVSOWJFR0QrQnhWR3dNY3IxMFN0ZWtVdnRURTE5?=
 =?utf-8?B?V092aUlEcGFtWmlPMkxJTldnVVlTNnU2MFFwWjh5NnVER29pTXFhckJVbGhC?=
 =?utf-8?B?OGRZYXl0eUc0bGlaYnlOYkZoQ3ErZlJxaTNncmZwV0NPUVRLV2ZIaUFPei9i?=
 =?utf-8?B?aklOa0lnUFEwdFgvQnEweUZVdkZRdlBHSFhiVXVTcHl6ZVN3eituZlEzZnd6?=
 =?utf-8?Q?z5vjI31Q2rCSGbr8jPq0Pkc6F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f2e727-89f2-4e9e-67e9-08dce82868eb
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 06:05:43.9750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTK9jtzrOvT0lAVYBStGJJYEbMS5TTPrVoqSREyKBDhkUXvIDofxvWlUUbgV9C+/QZH+Avkjmf4LMQ0J29NrlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080
Received-SPF: permerror client-ip=40.107.92.85;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.649, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


Ping?
Gentle reminder.

Thanks,
Santosh

On 9/27/2024 10:59 PM, Santosh Shukla wrote:
> Series adds following feature support for emulated amd vIOMMU
> 1) Pass Through(PT) mode
> 2) Interrupt Remapping(IR) mode
> 
> 1) PT mode
> Introducing the shared 'nodma' memory region that can be aliased
> by all the devices in the PT mode. Shared memory with aliasing
> approach will help run VM faster when lot of devices attached to
> VM.
> 
> 2) IR mode
> Shared IR memory region with aliasing approach proposed for the
> reason mentioned in 1). Also add support to invalidate Interrupt
> remaping table(IRT).
> 
> Series based on e10cd93872c31332b002c933a798ab0bc51705a4
> 
> Testing:
> 1. nvme/fio testing for VM with > 255 vCPU with xtsup=on and x2apic
> enabled
> 2. Windows Server 2022 VM testing for > 255 vCPU.
> 
> Change History:
> 
> v3:
> - Incorporated Alejandro's v2 nits comment.
> 
> V2:
> - https://lore.kernel.org/qemu-devel/20240916143116.169693-1-santosh.shukla@amd.com/
> 
> V1:
> - https://lore.kernel.org/all/20240904100257.184851-3-santosh.shukla@amd.com/T/
> 
> Suravee Suthikulpanit (5):
>   amd_iommu: Rename variable mmio to mr_mmio
>   amd_iommu: Add support for pass though mode
>   amd_iommu: Use shared memory region for Interrupt Remapping
>   amd_iommu: Send notification when invalidate interrupt entry cache
>   amd_iommu: Check APIC ID > 255 for XTSup
> 
>  hw/i386/acpi-build.c |  4 +-
>  hw/i386/amd_iommu.c  | 98 +++++++++++++++++++++++++++++++++++---------
>  hw/i386/amd_iommu.h  |  5 ++-
>  3 files changed, 85 insertions(+), 22 deletions(-)
> 

