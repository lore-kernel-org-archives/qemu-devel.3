Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC2BC54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 20:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhyLA-0004bw-Od; Wed, 06 Mar 2024 15:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rhyL8-0004b3-P9
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:58:14 -0500
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com
 ([2a01:111:f403:200a::600]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1rhyL7-00033X-Am
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 15:58:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqrF8f4dkuHIgLF4/33RndfrRcJk8nxoSg5NzNZiClBs8q038T3yv8Za3Stltik5GecGqN5XQt70tMJsZGqSQr3WQhkm3TazdIyChL4d3HRnhK4miFbDTguMtfitWYBR+xlLRANfzNB41IDb1/pleaAlpSaLcHefQi1lyjxB3AfcY9T9coiT4Cx9sv5ld0jAspGVMEEJjgAVPObLt2s3W5lxKBdfeY6SgQSmfVFKwqPfYw/gZqcUdlXvn5+OmFQdjzkSDxS2Nl+T3Tq36RCHzDHO5mqB8r4pS01XBEVeTdFfac7De9qM3qVqhIadt9sJZbceWqHKnv2gpibcwKqGYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYyWXV9AfRf1dstHoT+sMNHdlhxK3RrCe83WUpN2zww=;
 b=L1YEXxqT62eRYiTzWEEOh9A6rudKygU+eN9ean2AH6tc7JXHuSujgzv3EM17zXTpBKh3RAKbZA4MWH0I9frXIqagvL9VCsKVAUp9TeIk8a5uUwc1Zewm3zA2byjJkvxRgD5sqabHuPhxBksRM0YbGt8bhOVTnQWEW36fnTUMhVkKGwwc+4XGQFyIPXdLajVzfN/HFsaW0jgDv3yANG3r6OLiGVvlmGjHqSSHJFVOIbp9/rsqX2kkTqyvoAsxET9L8OdWR0KUJA6K8jIbUhJ8De3+neFw+GRabwqp3aVCfNlYwemwYI2uUHDmNLwcjluHIGpw0t/ehK65SHRbgXwETQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYyWXV9AfRf1dstHoT+sMNHdlhxK3RrCe83WUpN2zww=;
 b=T0tsiaasvg6ghc3TB9dUxfLhynUsP/jp/R37rVpmrZjoonkF6VjWWFWE5PzF3m6GqG23MUpxOM8pXeNsRXFGXamopmCshGtQHgeDRXCujnd6JaYBitJiggIl6qxrcEgIyuhKvz371PA90QLNc7qX7JWydpfuW7EJECccwUvscPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 20:58:08 +0000
Received: from MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::312:3543:c506:3207]) by MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::312:3543:c506:3207%7]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 20:58:08 +0000
Date: Wed, 6 Mar 2024 12:58:04 -0800
From: Vikram Garhwal <vikram.garhwal@amd.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [QEMU][PATCH v3 3/7] softmmu: let qemu_map_ram_ptr() use
 qemu_ram_ptr_length()
Message-ID: <ZejY3HzAXuXI_xPV@amd.com>
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-4-vikram.garhwal@amd.com>
 <87ttlp51e1.fsf@draig.linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttlp51e1.fsf@draig.linaro.org>
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To MW3PR12MB4409.namprd12.prod.outlook.com
 (2603:10b6:303:2d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c426fc0-0fdb-45aa-c14c-08dc3e202027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPZBpyRJrYUR8ZmmWGx5m4kw0FkN7s8bBP6X8r+CX9k4dUlO9ER+7ZMcZ5BPCiHtcc4qSI5HzCcTIryDi5ljc0JiLFXjO0srWmAyf9zoUCrBo4+wtSJMTHBCk0YPG6BCH7+K3Nnq3xTYFcEgdZ4Snl808+xuZTzxVZN49bUrm/MY9ucjR5hXVnLJSePe9vFE+6ndAr9RY6WztTGGg2z9ouX0uH1k1r5+VLAYUEZnw2AeXKwXLpwnUsfRNrtvoZGjWEi5XHCp7tfpAtdgcorV+Pq3ve/njo8RYnUniySMfbJh2NQ15wuh65cArmSEccfjVjqJje9pru7aWemfBMtaUcxUqdGmbf11t33SRR58/JjvFWf1NfyERc72VkNuGGX4BSUGyVuJ6dvVYOSR+CRbWOTUpgAAuAIqmGlNZsuWL1epgey6D9y30cS2dyicD0SLkj8g7NsInckT6tjxrN5znAjcNaGBwps6thu9Eoyyg7iU9f+zv8d3J9yKxd5sh5VDcL56qgAzGwmwBHhlLSfLtV5K8Kxy+moCiiDMPTcsab+IZohykSK/qzsl+yoquEw0DhAQ3MwtESsu1lwDtZl8nTUbFuD3rFCdyT8ad3uu2Xc5wZ5ZeWAkcWUscueo9bqShOthoqGuu4vA+ESH9+MjMcyIXUtSmeyNGh6XikORQww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4409.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uks4d1RxdUFvRlpkN2s3cWtWdWpDVUxxVlVTUlNHTVZEU2x6Tm9xc0sxM0dp?=
 =?utf-8?B?QmNOZkZwUi8yQmJ6UndIMitMQU1lS1ViS3NQZGhaQ1M5V2FDb3R3YVJiQjVQ?=
 =?utf-8?B?cHhTblI2RG5Pbk5YQU9vRkp6RGJQUkRJdVV0ZXc5TytFcExjRWVzS2JkbTJZ?=
 =?utf-8?B?VmxpZDltKzJWcWxnVCtQRWZQUnFIOGpJODhBNUxUbGlaMDhoMUhYSkUyWHJk?=
 =?utf-8?B?ZGk3dlU4aW5sYitEMkx2dGYxQ2xOVk5xRTVBMlRZTHRUMXZMbWcwZ1lqaktq?=
 =?utf-8?B?SDV1VGlxVG9xeXFTRmZyd0JTN1ZxbzZFQk42VFE3bDFhZ0dja2tobDE0YVlK?=
 =?utf-8?B?QlBrbERzKzJHNG9Ha0F6RlJzNkhKUlBPVE1LalI4YTZBZ2lyaGNwUXh6NFpJ?=
 =?utf-8?B?YWIwVDI1YmFwbXRGRG9jQUhUak9BSlVSL0FjdjNuK3JrbzB6Y0dzZnpoN1F2?=
 =?utf-8?B?dldLY2E1TFpQVVdpVkJTQU5Rek8vamFuZWpJUXFPNTBrRmdwMnlDTzFNWWh2?=
 =?utf-8?B?ZDZEWjcyUEFGOHlTZDhCWDFIVmNpSi9rd0wrNjNzZkxZMDNhbERocG1QeE9Q?=
 =?utf-8?B?d2lhUGI3eWp2MkhyMzNzcVA3b05YYWVOQzJiVnRRQk9JOFlDTjk4UVFqQ0c3?=
 =?utf-8?B?VHVvQWFVcUxPUVp4dlNIWkZjQXBvbmEvSk5RYXFad0taRlFqVy9DVEIybk9p?=
 =?utf-8?B?Qnp3RTM5Zmc1YkpVVEJqMUhlaGxWMzQ4d1VVTHI1RDlKMWZnekloU3lQOXlw?=
 =?utf-8?B?cDhmR1hlcEFhZW9hK013djlwSjZ6N3Y2MEFlcXhiNkRpRWluNFhvZEMwclQy?=
 =?utf-8?B?d2lsOVNHU05ac3N6cGlOU2trMkhOS01IeGhWS2hnYU1nUVZLZzIyUzU1b3k5?=
 =?utf-8?B?OEk4eG1yUFRNMVNIYXRQYW5OdUFXaXpCbjBpRlNHTE5Wa2RjekFNOHp1R1FJ?=
 =?utf-8?B?c1U1RnlMUjNnWmEwaG8ySGRYaUUyY0VlcmF3VE9JTVFjQnc2VXhHajYwSEhn?=
 =?utf-8?B?aWFPYmFlTFMrTVZxS1R4UUVoNURlaUU1NWgwcEZGYXVQQWhlMHNwOHJXSUth?=
 =?utf-8?B?Y3czV1k4TnhKUURpTXVvaVdoTnI2Uk8vTTNWeWZsSW02aFBkNzhHMW1oNGdG?=
 =?utf-8?B?TEVyenk3b2FPRk56a2NUQ2JxMnJwSW9PR0MyWlBjUWwrYmlXdXF5SnF4R1BB?=
 =?utf-8?B?eGJrZ2xFeWlDa2NpR0VZY1h0UnZreEc0NjQxU0xZRzJkckN4VVJFWkx3NWhI?=
 =?utf-8?B?ck5HQVMyVGRBaHllOG9YQml2cXlNM0ZZSE5XcjQvWnNuRzFJMUdtQXRsLzNU?=
 =?utf-8?B?dHJITUNTT1ppaW1iTGJzV2Z2aXFTRDdCa2hQSGJvdVpPOGNXZGZBUkp0Tmo0?=
 =?utf-8?B?a3ZGZEYxckZTNkhSVXpyb09PZklXNktFdGVUNFJFallvbUNFNEFhNjBza01X?=
 =?utf-8?B?RzNFYVkvbmxmMGwzTmU4Ujl0WHNIbTcrbDdUdUtEcVNCNk8wQVdIZzlES0RC?=
 =?utf-8?B?UzVYNE13dzU0bjhLYXZWQ0dRSzdKeFZ4VmZzSTdQTWtXN3czaEdZK2NZZFlH?=
 =?utf-8?B?SHRiWXpGN29vN1o2UElCeHFyWmRPSXFPSEJPZ0VYckFGUmJONTM2OVZQUm1U?=
 =?utf-8?B?QlB6b2czc0l0S2NEL2FnSFpnWWE3bFVaZkJSS2tpMW54dDdpbGtneU5Pd0hz?=
 =?utf-8?B?UkdHOHNkcTRsV2o1WUREWllaMnJWNlhSOWhUZTZHQWJVRVpSMVZUK0ZWOHFz?=
 =?utf-8?B?Z0ZMSENFV1VTcDg4aTNrb1ExZSt1UnM2UlhVY2dxZTV1Y0FSWllWaW8yRXov?=
 =?utf-8?B?UGpzd3JEMFY1TXhuNUdxU2t3N3Rxckl2TXJUN0d5amE0T2lBS25HYXZCNXJ1?=
 =?utf-8?B?aTRxdFF3Q1RtYmVXVmh6NzExTGVWMFRQb01udisyNzNXWTZ0WTdwQjM3dWhW?=
 =?utf-8?B?OWJQUkV5SHJIbHorVXdzWEQ4KzFQejd1M2hxNElUR1JGdW9BZmFBb1BzN2RO?=
 =?utf-8?B?U2tBSlk1UGllT0FBVGhVR0JFTGhSUVc4L0JSeURxQStYTHhMUFBoV0k4ekcz?=
 =?utf-8?B?ZERGTG9vdWRUaVJ0R1JsMS9TSk9mbG9OeFJEUEhuUVdMU0QrR1Rnc3VsVTRt?=
 =?utf-8?Q?YdzhaCY62C02vrg21A3CXyemt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c426fc0-0fdb-45aa-c14c-08dc3e202027
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 20:58:08.0393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eqTdzY6spQBVL30h6TgPAbCGvLaqibyawcWicQmTRF+1Wk2Zj77xz6k7CNw8FKR6EvNIMoaiD4byeXTSqdp52g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
Received-SPF: permerror client-ip=2a01:111:f403:200a::600;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 01, 2024 at 05:04:54PM +0000, Alex Bennée wrote:
> Vikram Garhwal <vikram.garhwal@amd.com> writes:
> 
> > From: Juergen Gross <jgross@suse.com>
> >
> > qemu_map_ram_ptr() and qemu_ram_ptr_length() share quite some code, so
> > modify qemu_ram_ptr_length() a little bit and use it for
> > qemu_map_ram_ptr(), too.
> >
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> > Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> > Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> > ---
> >  system/physmem.c | 56 ++++++++++++++++++++----------------------------
> >  1 file changed, 23 insertions(+), 33 deletions(-)
> >
> <snip>
> > -
> > -/* Return a host pointer to guest's ram. Similar to qemu_map_ram_ptr
> > - * but takes a size argument.
> > +/*
> > + * Return a host pointer to guest's ram.
> >   *
> >   * Called within RCU critical section.
> >   */
> 
> If you end up re-spinning it would be nice to kdoc this function and at
> least call out size as a return by ref and optional. 
Will do if re-spinning is needed.
> 
> >  static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
> >                                   hwaddr *size, bool lock)
> >  {
> > -    if (*size == 0) {
> > +    hwaddr len = 0;
> > +
> > +    if (size && *size == 0) {
> >          return NULL;
> >      }
> >  
> > @@ -2207,7 +2181,10 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
> >          block = qemu_get_ram_block(addr);
> >          addr -= block->offset;
> >      }
> > -    *size = MIN(*size, block->max_length - addr);
> > +    if (size) {
> > +        *size = MIN(*size, block->max_length - addr);
> > +        len = *size;
> > +    }
> >  
> >      if (xen_enabled() && block->host == NULL) {
> >          /* We need to check if the requested address is in the RAM
> > @@ -2215,7 +2192,7 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
> >           * In that case just map the requested area.
> >           */
> >          if (block->offset == 0) {
> > -            return xen_map_cache(addr, *size, lock, lock);
> > +            return xen_map_cache(addr, len, lock, lock);
> 
> I did wonder if len == 0 will confuse things but it seems xen_map_cache
> will default to XC_PAGE_SIZE in that case.
> 
> Anyway:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro

