Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFB4C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfi4n-0005wo-6R; Thu, 29 Feb 2024 10:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1rfi4l-0005ur-2w
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:11:59 -0500
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2414::600]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1rfi4i-0000X8-Pw
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:11:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfIa6AfHrKqxs/tHVkbuyr3UVM67wZQkUsfjHoIJX+CNSr8TE3LkYOH7bqV2GpuC5UIzo5Rw8MA0o5j4lJIudGMamAseBmbRnOYGeBV0/YZxNnk7gp7POnrXp083R/0n/suKuPFWBl4EPMR67IwKqhrZ4gXlzmKTh8fwfXRuPXohoN0yNQbwHu32jpBs5Ky0QB6LIxwFAw1qiUnadnmefKo083RkCQtkKDfa38ERlraFRKXRYnJgvjTxp66xksm+jnPRHEP7b24P8Il9O97/w+XXQM8Fr84aGC7lI8AfZXnTAMYo7GgBjj5c0TQpyzHyrdaEuYQbeJXPKrYxUSoYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmUXcB/n3Mk7eMaXDui54dGiiW4p08RmzdWtc3/o/U8=;
 b=gQ4uR2gk52UWL8Qu+d6/GpE29WS1w7mXj2H+GtHnv8P1KrVq07tRBzls0/62hHeokP40PfG+Snxyrf5h9JLsxb2J7m5daCgyk1foCW7vSBJq7AiE7dY3kXICP1PcGRlW7W0dE9D+fs+DdQgLYvFZB5JTNzB7Gq6T9JVm7L+n0c6o1yRQq9VMcBT2AcvNltlVw9VNJbQ4Yn+aUfZm7gVGdiOuG2Sc57reUWGModtse/bvbUwL+T6DL0VtPzzdZpkU+DYq4XTKz0Igc1ZTSMj4zop4YvvYtGmcSKBQG59bjTh3wNUJIobXBgT5zozq0HtQcNnDOu1WxhHmwrKEQTVFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmUXcB/n3Mk7eMaXDui54dGiiW4p08RmzdWtc3/o/U8=;
 b=gLbmik3FqeR8SzIHFPBhaMiLCb1SgbO8vupGVUDjMTuQmgWs8+sZoxs87bBDH29ewJcV+FKHYi1Zl1r6ZbBeV1KQRjTkVOww3ck/XQymo73lpfaHfSgwyABLQRmBToSJIRopnIqYVrqD5cyH5Vm1uctsOuyHWhbXCx0Af31cdBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 15:11:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b49d:bb81:38b6:ce54%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 15:11:52 +0000
Message-ID: <6c8bb202-d921-4b01-9cb5-f9a3c85aa7ca@amd.com>
Date: Thu, 29 Feb 2024 09:11:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 21/21] i386/cpu: Use CPUCacheInfo.share_level to encode
 CPUID[0x8000001D].EAX[bits 25:14]
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Yongwei Ma
 <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <20240227103231.1556302-22-zhao1.liu@linux.intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20240227103231.1556302-22-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0034.prod.exchangelabs.com (2603:10b6:805:b6::47)
 To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: dc0df33b-f124-4dcb-17c8-08dc3938c233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXKH3tBPnpcL5K0pVAIxRHTKHB41hnmM8k5hn8GizzxGAAlNx7RNL2tcI9+k94yK3QXmuxuJBlL0IJYaQOy4yNmaq7LJkYQ0ChSSMjZ+qyGV/ZwNYsmL2gWvMYlHn4Ns0PTMv6OxZU33JMIKApAqCDUE2SSH70P/toUXA/rIZL/IWCZjRHbZtJo3M08Uoh3c8BOnuHakzILS6Xx2H64En3yTBojk0NQ1zhpOXMHlEfqwqY3A/ESiUBV0tcOou9OaSJEm8j87ifoV9sBWczm/fWahOyfkioELI4y4ItOqRnT6SQphhODDpR1wbyaJBkVci5eD534DPtim2Ia3o9da+231OkiVhEAbiMSY4RCqV6RMfBM8ekZnbI7joAKjfjiCj1PNVekBLJfzQF4BY2yvr4LfTrcalcDmK0Ud6J7ylxZg1Pd83uGrLf0We9mCNYNk7I/NRU5tq34d2VBEJKNOIYvkIOiBavMd6M0xkuPPtcULt0hRztA4RbyrlcO8gD5kBlxYncGqWGe9LrNovDzuE5glIAooSTnp3G8oomKkUBLjoAXa9FKtXD7ZtOwORJulCJFcQZdCiVmc8WK25wvy+Zlclf1SwbFUWk23MkCGoz+QBOj8k9WDUHJLZE3s5ccbo1d9vN4UH/OE9d5hPkctv1xrANuKPZRJpjlodTPrSraRXo+WXv1zLAie8eXo3qWy4hFGL+JEcmI9F9Cz4kUPRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(921011); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlBHU2hwamd2RVhlYjN4V1liSVNLV0p4RXArUnJVT1JGdWJyTmdYMkIxK0E2?=
 =?utf-8?B?eXJQcU5iTEZyRFVHR09VRTB6anVXeHNtb3NmenplRFgwcnlRVkpReFVXWHU2?=
 =?utf-8?B?SCtRY1VQRnRJZnVVUlJ6MnZub2lrNDZuODd1RzdodGY5eTZ3S1VRSFdjK1NO?=
 =?utf-8?B?bmlZMkl1RGhyUHNQTUMxL2FSd1hNbDVJbVcxWGhPMXFUUUhWS2xkRG1QbVkw?=
 =?utf-8?B?aWRnVlJCanZ0aE1peFcxZ1gxaUY3eEcvM2E3blpDSmxuM3k3N1pwR21leHhQ?=
 =?utf-8?B?OUt0OFZESFh0WXI5MG9IQ1g1cFBHdXBMdnZSZFdCNFJNTWhTSDRNRDk4Qk9I?=
 =?utf-8?B?dmprTlJCb2JEQUp6UnBMZThoSmZOTE5QdDVkbXVsd3U4YVdCNlNYWEs2aGZi?=
 =?utf-8?B?T28vQk00cUdISFlQRkpKU1huVVdpbVVoQUlsS0tTV1NMV1RnTGN5M1FxbFlM?=
 =?utf-8?B?Sk5HMUJKWTQ2Zmp1dkJuS3g2cUxQS1VFS2VIK3piZXNBbUxibVdIbUlucnN5?=
 =?utf-8?B?Rm8yNldSOW1KV2ZxRy8zM0NrWTZveDRlWjBJcHlsNkJQYWlRdHhmZGx1UUln?=
 =?utf-8?B?MDdGR3N3ZG1JSzNPcVlHOGNVRWVZWHZmK1lzVTVPSnF6bDZ1Yk8zMVBKaFor?=
 =?utf-8?B?N0FqZi9UZWlqeVJNYzlxQmxNTk9jR1FJOEFmc2RlVHoyLzZSaHRFNWhBVUsw?=
 =?utf-8?B?OGIvT2svVXBKdTRZVU1ScEd6NkFKQmMzc2hYYjUvVEEyUmsxM3JrMDdTbjZr?=
 =?utf-8?B?TXpCbHZJVjdncUdDRU9NOFloNm1MMUNtRStMeEE4UGtOdGFYNjI4U2dIbDZa?=
 =?utf-8?B?NzRCM1AzTHdsM1Y0Z3BsRmZNSkgzODhzU1MweHRLeU90SUorS08yZ1FZT3RS?=
 =?utf-8?B?YVUvSVhVNXo3S3VwMExSL1hkdWdmbnM5WWZwYldKNHdhWk9xdDdENStqMkU2?=
 =?utf-8?B?VG9WQ1NDK25adnRkNVJCckRMYUNxdGpSTmJXWkpMTWlOcDRnZWdmaFBjYUIx?=
 =?utf-8?B?T1NRWVhVdWxYdjAzTXBndUdCMklCcXh3NGZiR2RYTWxOL1BzVjNDT3BhSWVT?=
 =?utf-8?B?MkNFNkRRaGwybW8zRWRDbEdMSjZBb0owV0hFa3BsOXE0L2lBdUhtYWlrd1dF?=
 =?utf-8?B?TUZnYWJkdUhwd09DYXA5OHJEeWFkSTl1VVcxRkxGSWFBS08vL1dwRE8xUTd2?=
 =?utf-8?B?dUMvM1FISjRkbUNNZ3RtMVllTnFyZEFQWXFqVHErYlhOTVkvL3VmWnArYWRB?=
 =?utf-8?B?aVZDdThhZ1FlcndzYUNXMVhMWjk3b09mODBndmg5TlUwQmthcTNIT0hpV3Bv?=
 =?utf-8?B?WmFqcmptTGdEUTd0TDFwcDQycHhJKytHT1ZGT0M5dGhyc3RrT2wyeG9Mc1Vy?=
 =?utf-8?B?Q2hPQUNUeHlhdXhjalFQK0hmTG9jeUdraUVwUU5CdndYNEUvUDNqbkpGT1RU?=
 =?utf-8?B?aENuMG8zZ1p1STFYRzdIV1dxS3hLVTRaYzBjZXVLSFhPQVFhRVVOSVZsVDMy?=
 =?utf-8?B?S3ZVemRkdTE1dXNCbXpUL1YzQmh6Ly9ncmJ1elpKZ3ZlNUp6VEhkUTVZUmZm?=
 =?utf-8?B?cWhULzJDbDlkZW5HQWlNZWVwKzJ4ci9PWFptV0R3Zm83dnAzeEVmYmtoK1dS?=
 =?utf-8?B?STl2YUVlUVpMRFdmZmVDQ1h3aS9nbGhHb01zZloxTGg0OSswNW4xQnVrSmlm?=
 =?utf-8?B?azhTUlNsN2RXUVMzT0hLejR2MzVlUVRvbHM1emI3aEd6Z1VuUkVqSXl4SEtu?=
 =?utf-8?B?ZHhLOS8rcXljSGJaVjZKc0E2cVlmRUhPOTk2bWY1Q0ZoZkIvOUJoUUdvditL?=
 =?utf-8?B?WDA0MXZQdGZvWWZGcGNndXd4UnJid2h0S1MzZ0lvNTBjSVlnU1FyTDJoeE9Y?=
 =?utf-8?B?VkJTaHoxeTJKM2tHWkZwV242Ui9GMUo5TEdxbnNXM0NLTm12RXlLbkp5YXNX?=
 =?utf-8?B?NEUrc3ROYTIvU29NNDJEWVFIampaR3Brd3Q2a2RwZGxsam1vVUFnaXI5WVpL?=
 =?utf-8?B?dXJZNWVlMTJpYTRHRWRXZGxTMnhWbE1WTDNDZVNqWURJM2NSZVN4UmZMaUJP?=
 =?utf-8?B?anY1ZnR2cGpuSEsvUytCUnhUNFpqUWxqOGJKSm5UZ1QzRWg2c1N3U2s5UDZ2?=
 =?utf-8?Q?l3bU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0df33b-f124-4dcb-17c8-08dc3938c233
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 15:11:52.0159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rr4HY3KnbnX9lH6yh4ja16mFrF7P8xUt3IfUqUmxpH3FGCqP/0xepIfmE2g6Kof+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319
Received-SPF: softfail client-ip=2a01:111:f403:2414::600;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2/27/24 04:32, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> CPUID[0x8000001D].EAX[bits 25:14] NumSharingCache: number of logical
> processors sharing cache.
> 
> The number of logical processors sharing this cache is
> NumSharingCache + 1.
> 
> After cache models have topology information, we can use
> CPUCacheInfo.share_level to decide which topology level to be encoded
> into CPUID[0x8000001D].EAX[bits 25:14].
> 
> Cc: Babu Moger <babu.moger@amd.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>


Reviewed-by: Babu Moger <babu.moger@amd.com>

> ---
> Changes since v7:
>  * Renamed max_processor_ids_for_cache() to max_thread_ids_for_cache().
>  * Dropped Michael/Babu's ACKed/Tested tags since the code change.
>  * Re-added Yongwei's Tested tag For his re-testing.
> 
> Changes since v3:
>  * Explained what "CPUID[0x8000001D].EAX[bits 25:14]" means in the
>    commit message. (Babu)
> 
> Changes since v1:
>  * Used cache->share_level as the parameter in
>    max_processor_ids_for_cache().
> ---
>  target/i386/cpu.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 07cd729c3524..bc21c2d537b3 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -481,20 +481,12 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
>                                         uint32_t *eax, uint32_t *ebx,
>                                         uint32_t *ecx, uint32_t *edx)
>  {
> -    uint32_t num_sharing_cache;
>      assert(cache->size == cache->line_size * cache->associativity *
>                            cache->partitions * cache->sets);
>  
>      *eax = CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
>                 (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
> -
> -    /* L3 is shared among multiple cores */
> -    if (cache->level == 3) {
> -        num_sharing_cache = 1 << apicid_die_offset(topo_info);
> -    } else {
> -        num_sharing_cache = 1 << apicid_core_offset(topo_info);
> -    }
> -    *eax |= (num_sharing_cache - 1) << 14;
> +    *eax |= max_thread_ids_for_cache(topo_info, cache->share_level) << 14;
>  
>      assert(cache->line_size > 0);
>      assert(cache->partitions > 0);

-- 
Thanks
Babu Moger

