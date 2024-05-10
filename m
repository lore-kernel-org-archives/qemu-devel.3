Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2176C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 13:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Q8N-0005ra-6R; Fri, 10 May 2024 09:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron.lu@intel.com>)
 id 1s5KdY-0007aY-Hr
 for qemu-devel@nongnu.org; Fri, 10 May 2024 03:25:48 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron.lu@intel.com>)
 id 1s5KdP-0005Mk-LM
 for qemu-devel@nongnu.org; Fri, 10 May 2024 03:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715325939; x=1746861939;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=O5b61riPtsNOC3hgBrEPtj2Q0tQ2z4GeUXZ3MFl5CVs=;
 b=IsZRTUA1rA8HyZg1qdjz3bOjN5M14UZFtHsTxTXgbybuOQBE1I53vT85
 c4rlYnjKWLPRHm8ZkW/Y/c8Hrd+2rg8W0GdyrlnVaMkBFONZYkZloSyoq
 rkGwGqz5dMn6XdEaNmq0OA2ISgwCqhyqfEZzTmf+XGOzdkMCfkBHemeb3
 NmG7ZbUQCpDyTMM/qUhobj6YT+dIh/jEDUbVhAS5pwzUqvRbyFcSzu0+E
 itiE4Q1tzo50OpHccCBYvJlDp990lEGGW3tgvdsB7+xUbNIJ+w2f6IL0G
 f9lgdl0E2ozs6O2w2Bcw68abkhfdKhFmbXAOJwEaI+QOhnkNM8/z4bAh5 Q==;
X-CSE-ConnectionGUID: 5eUJrXUqRHSAuS/XnMqrCA==
X-CSE-MsgGUID: A/x5bs6BS3aqAxZGDj65og==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21888886"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
 d="gz'50?scan'50,208,50";a="21888886"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 00:25:33 -0700
X-CSE-ConnectionGUID: 8/3nG+2JRviGN+nBq9JYZg==
X-CSE-MsgGUID: PSFUcPEoTk2CDVPchf4s/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
 d="gz'50?scan'50,208,50";a="29462204"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 May 2024 00:25:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 00:25:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 10 May 2024 00:25:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 10 May 2024 00:25:31 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 00:25:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeIzS1Sm9Z03Y8hVI1ZKvW6ViPjTgSfKWNh/h4Z1yy6W+3A4vE6D5UwkIyYcTT8aCQa+MmBgIH4HrDdtifMPe8tV087GC73+9ZnbRJ84ZcAN+rqzGWkVLDwCHAFz18zcNxsIzRlYTkbc4wM+wkxJYB3YWIdHIO/ndJTVCKKnthxcgNc+iHU7kQFMxNY4hFOK5PG6u9YqSFwEFhSEBMZAXBehuNj2CPCPBi0PqbcotM/fsAn2wiGFcPEOYGVmpa8rU2or0mggWT5+rgtrmbSSOf+JuoOPIVPRJzKReCc9OcKr7ghtv6izgskL/3+YNNnH306nalffD/I+bfsAQ49CsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZC8ZmFxh5UDWGvfbbZ0oKW+KdDkjb3BbpkGRVMjP5s=;
 b=D56qYsTRD7OdTIF2rYBH8uKxHzdM6lByMI1U8BCTW3l+lA+YfNfETIYkl3/kc/Ls4g738V0POidlbs11qob11oRWAf6Wudw53uZ8Dr0OZ9M/a5NL99F5/LMbeE6hhO5V4GQ9DNaJLRY1Zd9omINaAnfGm87iNYUx3Pt8IYPY4YffLYxkKh9hVYZZEn7bpN32hs2INa/oDdNg+vCQab/5VvaH1li3lBYbT+06IDb/3OcMIHVHDG/VzKS1foAgViOkyd/w9RleKrWnEPseIfqum5apQyLNKhOQQC2Xl5iZecgXOyIZD9+lgFdcNbh7yA6bpn0JLk2Hwj/aFV7PVctzNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB6985.namprd11.prod.outlook.com (2603:10b6:930:57::6)
 by SJ0PR11MB5167.namprd11.prod.outlook.com (2603:10b6:a03:2d9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 07:25:28 +0000
Received: from CY8PR11MB6985.namprd11.prod.outlook.com
 ([fe80::77ac:889c:cfd9:b9f5]) by CY8PR11MB6985.namprd11.prod.outlook.com
 ([fe80::77ac:889c:cfd9:b9f5%7]) with mapi id 15.20.7544.036; Fri, 10 May 2024
 07:25:28 +0000
Date: Fri, 10 May 2024 15:25:19 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: <qemu-devel@nongnu.org>
CC: Xingang Wang <wangxingang5@huawei.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Juro Bystricky <juro.bystricky@intel.com>
Subject: Problem with bypass iommu
Message-ID: <20240510072519.GA39314@ziqianlu-desk2>
Content-Type: multipart/mixed; boundary="xQOY1VeyuSFCnncq"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To CY8PR11MB6985.namprd11.prod.outlook.com
 (2603:10b6:930:57::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB6985:EE_|SJ0PR11MB5167:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c3b0e1-e27e-4936-5691-08dc70c25dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bb8twyTmrrlLLf1JT9aTwDLKNj6N71dnnse2lP0melo1dM/LzMtPAjAmhVdC?=
 =?us-ascii?Q?EYcaCm7BvJZu1OfoF2u8+imYnVO2Ut14AA+AoHBIyzHOjhSeqz+eoJwzSM6F?=
 =?us-ascii?Q?OVB7PSe1sjvQqZgtXnvr1WL4IRjxUyjM7doQHlNwviqQpNismTqTtpNf7Op2?=
 =?us-ascii?Q?zfDysbDN3iknhPa7tCtMGa6DGItaG4rOuzfkmHEs3dBRX79exdGD2KEH8AqA?=
 =?us-ascii?Q?SluhpZm1rkf/vqihtUochLvf3I4obKHISn4Y6PiRPXCknR/+LFtUaCERxgWp?=
 =?us-ascii?Q?ePb8LAF6EvOQA7Xke/JjpEI2O+8o3oHKgK+5Ug9XaWvGE50utUnU20hl4/H/?=
 =?us-ascii?Q?OUd8NzoKkuRQggeDpQ0TsxqAGUhNn9kVGbuneuD9+nkQhnjikqVFVfXiY25b?=
 =?us-ascii?Q?DvR3Z3Gs/bWjrCVnGSYj/ceCuuesM30vnmGzuh++Vca4G/ENCLIifLl2ujnV?=
 =?us-ascii?Q?RVKZkQ4CBHTfxHEIRXlrrexktvoYDUwvjiYD9dxTMzkTRV4D7YytlnA9eGpb?=
 =?us-ascii?Q?Frh/1eUp6JC3R5qsDc9YRtCERDpfjshv9nr0tUErDGY2YddSNg3uL1rhF9A8?=
 =?us-ascii?Q?aMjGugyy7pgVZ90a1ACG9DsVDVNbZ85yv4yChsGPubbkewLvBft6TDBPz40g?=
 =?us-ascii?Q?+bmhJ32Dh9l15VMp2tDbEwU5O0pzBthpnF8XQlXn2mXbo/sIZnhMvO+BvZNb?=
 =?us-ascii?Q?wkvqoyAixKVQa53u2oWdGvwSicbom6HfKWRu4Fy5KJM1gf+q5s782Sj06DXl?=
 =?us-ascii?Q?tsbjEt05RY+gDWBRZWXM7EE+zWOzIJoZ6MZ1GEcFDlqjx6h1P1/1RRIAW43x?=
 =?us-ascii?Q?zjXBRZ3/bqnnNLZuJqS8HRuPWv0/B4HfoT4R57c4IKprZn8kDwM/K7Wxw9Sh?=
 =?us-ascii?Q?ZXF+DI4bq6DJToaKY/pLUxtqGD/OznJhDgsndqixdMWLNwKadPbMy9zsLLF7?=
 =?us-ascii?Q?1CjqfWVE5Qq3NBQHbPCMzffNK2lrjl1CVAJWKTBUyq1qKZlcYCr1w4yZzD7u?=
 =?us-ascii?Q?+DwKSSGrHscsLtUEGloEUYgHmOiZT+CJOrcV91+zrM5YWNacl9lSD3O1i5gL?=
 =?us-ascii?Q?twWEt0BrvEYXMEa9PuiFw/ROrl8KXNTHegI8y0ambHFoq0CW9CmV001LOJ3L?=
 =?us-ascii?Q?CYQOdQxkfcniC84p3UfZea/Y6AVAtgRlWWC1CmY3BPdkbBPUuYf/jUK3f9wg?=
 =?us-ascii?Q?YrkQZMBmNEG8oc92ibn+ageUHEjIPmBRwbbvrw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB6985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hUK2hR2QThpVlKFdX7IrfQc13IyyuglzawMxQ+Gu8cbHRFt8Sk9nVkimhwSq?=
 =?us-ascii?Q?hhgCoLtfGG7BsqhhLtm/zGar817a4rbZo8/AJAdhbvHIkg/Omab0SVUWYUCT?=
 =?us-ascii?Q?wTImK7gqK2oeSSLssLN8Qk/KY7DQSPkdUGPRY8AwQchwStQVz7G7fFU+G0bk?=
 =?us-ascii?Q?PKrIJkLBy03W1DuPrAo+xRWZhkdyfIArqAJQDEaBVctfM6JzmxpS6y3a5jCe?=
 =?us-ascii?Q?0+8hO9CHdSz2ufkYAt7yO4H6ubnPMYJwsg/BlEAXXFRX8y9IIOblOXR+cmyB?=
 =?us-ascii?Q?H88UfjYUvh5m+VOD0xYIl8y2Cczy5q7xLHosCeadAcDQvpqdxx8700fq7s/i?=
 =?us-ascii?Q?hI9L+TZ8d3RAoyI8TuBobszS6suEDlt1V+golklSQeDfliTmm/RynQbV1k4g?=
 =?us-ascii?Q?Kwp3uSvPSGZhd6+VX97CVAW4EyVFezHPBtwo1akdQwHrAJCck/ylgWqp4Zyl?=
 =?us-ascii?Q?GO5heNSo1BqsrPGyhnkBJ7J4zlniK0q1a0KEY22vX1LZ44Tmq6xY8usVOI6e?=
 =?us-ascii?Q?1akgXrWMTDPLj8GbuykCmyQop7OV1M1qR0S9gueZxFinWVHh6NQfSZWNCTVH?=
 =?us-ascii?Q?GmJrZN8UwGjyK8017zV4v7f8Vmi33CxSW5/7IWbHCO1FsVS21h0WPT2LiMBq?=
 =?us-ascii?Q?0KcAmQIz9Ny5Y/ia66jclNeFNVBoQocem0/LGkaz9WFsoxD1AhmijSWFLV0P?=
 =?us-ascii?Q?Kv7kTghZFaBbfjdshP3Max5trib+UzEFafVeMuqsjsBhdDCpIGKRrnUTbqj5?=
 =?us-ascii?Q?fYI/QS0bAfXe2lIPtRvJnuZpBAbfCRhvwKe7XYsWl/KI1kdQ7csUifeKGyma?=
 =?us-ascii?Q?XohJg/W1sXLr0F0Cm0c16+y5wXZhhcLL+Lo3Ll4MFk+g67x/xuDRfKuKonx3?=
 =?us-ascii?Q?M3B0x/3J3NtwiHMAG2zUrrTr1ryFij1OquPc+9cFghE4P3/6dBc/QDlm3dW8?=
 =?us-ascii?Q?OEh7UMozRLiIRO7/8gLpv4E70VRnIivBczRy+50E8HWXlB+gUDfrg0CW8D79?=
 =?us-ascii?Q?xLL1uKZ0NKlLDjJrbpSYJs8R2BXCO2bxhJwejfA2Ka8DA56ujv/J5LX73ior?=
 =?us-ascii?Q?YofIx2maW0B1k0//cdu1f4uK/KiVuGnHtIonvnBL9SqAyQPQt+gV0YFThpbD?=
 =?us-ascii?Q?jEjrnM0OtO1VulrsitG+2fl3g21vzEFHIbCTVv6cd44bTNMV+sUeevo/N6Nk?=
 =?us-ascii?Q?DZaImQpueHkNVmOrbcYDz5ETpzJuO3PMt1ottny2Ei6Dpts/qESLY5fOHXJO?=
 =?us-ascii?Q?iwesPVxj0MzXSxD2cIrnYv/bMA1pzhp1w7Yf/i2jMelBEHTdwuIvtyjuHG44?=
 =?us-ascii?Q?A0zvcThWYDwovtTCmiYnO+vT7uK+XzczECOcs/7mNjHOBsztvD0IZ3fGZZVn?=
 =?us-ascii?Q?ATGXkXI4P3yIMAbyeu/KdjeGJWfu2fMj6BRmuzdMh7L+R2BUWT3nUudpMphH?=
 =?us-ascii?Q?6gVvktYyZxcMPqC4l0whJrzKWwSqc9f/VWrRlbG5RXUXUumQX4JC2V4c/wNV?=
 =?us-ascii?Q?u3OLSD/tc+rNZg+xDOzZzpzV8G7E7Wtruya4rbMoWiFbxliyM2FL/WDQPcpT?=
 =?us-ascii?Q?i6JZqCEeQqiX5MfLj9tyDg+VBrJDJ6VCzlE//92y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c3b0e1-e27e-4936-5691-08dc70c25dbb
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB6985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 07:25:28.1878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8o7JYi55j123Vj7QAwZEr0WiGpqBmqtV7AWfiwL3LxJoyTxgFjKgfNPXAQGQvBo6X+O28KIpf27TaMmmhpRtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5167
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=aaron.lu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 May 2024 09:17:57 -0400
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

--xQOY1VeyuSFCnncq
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

Hi,

When bypass iommu is used together with split irqchip, during boot,
kernel would dump 2 callstacks(see attached) and the results are pci
devices attached to root bus will fall back to using IOAPIC instead of
MSIx. This problem was initally noticed by Juro.

This only happens with kernel-irqchip=split since kernel-irqchip=on will
implicitely disable interrupt remap for the virtual IOMMU.

Per my understanding, default_bus_bypass_iommu=true will make pci devices
under the root bus disappear from the DRHD table. But when irq remapping
is enabled, kernel expects all devices appear in some DRHD table or the
device's irq domain will become NULL and that would make the device's MSI
setup fail and the device's irq functionality will fall back to using
IOAPIC. This doesn't look good, since in split mode, IOAPIC is implemented
in user space and can be bad for performance.

I don't see any immediate solution to this problem, except adding
intremap=off explicitely to the iommu device.

Any ideas? Should we enhance the document on bypass iommu by adding that
intremap should be disabled or there is perhaps other way to fix the
issue? Thanks.

The qemu cmdline is like this:
$QEMU -m 4096 -smp 4 \
  -vga none \
  -drive file=$VM_GUEST,if=none,id=mydrive0 \
  -device virtio-blk-pci,drive=mydrive0 \
  -cpu host \
  -machine q35,accel=kvm,kernel-irqchip=split,default_bus_bypass_iommu=true \
  -device virtio-net-pci,netdev=mynet0 \
  -netdev user,id=mynet0,hostfwd=tcp::2022-:22 \
  -device intel-iommu \
  -nographic \
  -kernel $BZIMAGE \
  -append "root=/dev/vda2 console=ttyS0 no_hash_pointers"

Full dmesg attached.

--xQOY1VeyuSFCnncq
Content-Type: application/gzip
Content-Disposition: attachment; filename="dmesg.gz"
Content-Transfer-Encoding: base64

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
YLF5/Q93xlJd9K8AAA==

--xQOY1VeyuSFCnncq--

