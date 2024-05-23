Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D965BC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 12:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA7wE-0002OF-Lf; Thu, 23 May 2024 08:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron.lu@intel.com>)
 id 1sA7wC-0002Kn-Fx
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:52:52 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron.lu@intel.com>)
 id 1sA7w9-0003Kn-Lm
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716468770; x=1748004770;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=uRTdkEtarRqCy5I4M3DOKYx1608DN6eJU24uUKKPxUg=;
 b=Q4+LYB4SEwELUPW7j0JPmULCKag9gkfCeCx0mmMA796isKz69rI6Q5kn
 p+GsiZuC6M8NGew82cpl85JU3aMsif0mg3TDrZ9vNcg/BwwgTuGjBzKZq
 mhTEFNzbyS92SsGs9WlZDaXYWRurGkHpBcTl1tfcFJoSX/a/81dPuTWZg
 g/5fo7dY+SXBbbDeoRXxIRkRC3+FIrGxHdt0oBnKIrx9XbY4azwhI6+5v
 rsyRHmq+PbtQQvOTEn6L6R+Aa/k4Q5Zn5pItMcq6+LT/6CKDjOMjrI3Wc
 nZXYTw9O3tlaF7MxInJUaNf95RBLw8TcZ84+OcBh0wyXoA2dbgYUr1r8l w==;
X-CSE-ConnectionGUID: pgdKuAbnQaWt8ZCop5CBPQ==
X-CSE-MsgGUID: WrzHn6zcTjWXmyibQFHMsQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12631825"
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="12631825"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2024 05:52:45 -0700
X-CSE-ConnectionGUID: T8lSYSCFRqqwiOp63HYIWQ==
X-CSE-MsgGUID: YAmk0VMFRM2g4yhJBaHdVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,182,1712646000"; d="scan'208";a="33784073"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 May 2024 05:52:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 05:52:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 05:52:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 05:52:44 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 05:52:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYS58yg6WAoRb/aTspWeEZRnuxISldmbZ2T4c/2p+GLaSLe3KLzeGXLMkf9+G10Lf7Uy6cNJkN2vcl0sGJ68LPu2mC18iBt4JlgD+dN/tzWK01tkNfy59aZl0x+4BahMUZvXBO/fL6ObO5NkObrx07WRzcVJEyHfV7AiMONjBRwAdCwgZ69b8fsXbqqsb5vAesNOMHcRrrVsj9/lYfIolKXG44vBLqPZoxqnZH3oMnSAAMDIoNg/ufmvTkNQL3lQLeXOP5H/nOaE0wVPbfevT3eAC4GRrknVCpv0rIlkMIIu8yuFNVCpR+UrsaTDeJBZg+XhdPImbJtllZq+bC7qXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=msPOTM3luKHuRA3jcO8Bc1QU2vWTjydufMiHrKZV2Ew=;
 b=jS/1ZoM9f8ND8CPnFdNugBjwNhRC9qNgCYrf/Ebdq5izYNsDhA2ste2XvoX12oTS+Ydn9JT3q9yFkFcTH+2rZMYgTBHAoJSooU/MD9mZZAoSclt82ystHoKXvGzy4SaRVgoB83VE1MMydLyZnu8pbw9uLHB3EQJx5cEpP44BiZNxVS03R9o/D5WI2iPwuMX/lqah0el/rSYUaJoZc/XHL4Y+yr69trT3KYp3T+5D4FMg8ELywdc4G5/x/7+OlmcgKypOUbZWap71vB1htSHl8Qn3nqK2A69Iv/iAIzchuT6TUr5IYhCigX53dMg7TIH8FlL30EW82vVmlxrIliwtjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB6985.namprd11.prod.outlook.com (2603:10b6:930:57::6)
 by MW4PR11MB6713.namprd11.prod.outlook.com (2603:10b6:303:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.37; Thu, 23 May
 2024 12:52:42 +0000
Received: from CY8PR11MB6985.namprd11.prod.outlook.com
 ([fe80::77ac:889c:cfd9:b9f5]) by CY8PR11MB6985.namprd11.prod.outlook.com
 ([fe80::77ac:889c:cfd9:b9f5%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 12:52:42 +0000
Date: Thu, 23 May 2024 20:52:35 +0800
From: Aaron Lu <aaron.lu@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, Juro Bystricky <juro.bystricky@intel.com>
Subject: Re: [RFC PATCH] docs: Enhance documentation for iommu bypass
Message-ID: <Zk88E2F9WHFa8iUo@ziqianlu-kbl>
References: <20240522074008.GA171222@ziqianlu-desk2>
 <20240522051403-mutt-send-email-mst@kernel.org>
 <Zk3mRaoDGRj6Bw8J@ziqianlu-kbl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zk3mRaoDGRj6Bw8J@ziqianlu-kbl>
X-ClientProxiedBy: TYCPR01CA0190.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::7) To CY8PR11MB6985.namprd11.prod.outlook.com
 (2603:10b6:930:57::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB6985:EE_|MW4PR11MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 217d5426-4ca0-42ad-1487-08dc7b273bf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G12jhYwh/xBABWMfnsNVk09O16fxw0cpL7U4hSTaeUG3Cn2WWN7tliWVewzG?=
 =?us-ascii?Q?5dTM/EbTOqqrE7JO8ZcNCruwnxjvWZLVRnFzJc/wCxoUbEgKmRpW6FT0u8Km?=
 =?us-ascii?Q?0k5IXKr6VOrpvP1iAQgvMkVVfzft4r9N4lZ7iiMeqa1ugMO2Jvu4xU2BoDQE?=
 =?us-ascii?Q?6jOV7bwCBZVWDV/j3EHdz+JJGZfdGQgcHPIQlX2UW01wnqbUWqi5HTzpjaK/?=
 =?us-ascii?Q?VfQdUf8RVQRLIvo1C2G+z9loACEtE41VH+PJcetd+dnYFA1pTCwOJSmWZgVS?=
 =?us-ascii?Q?rP4azH+3M/e8bA0Tvuj8nZ5Ve0uls1uXKcnFu9yrYWh1EuZccmGaDPlXfGx+?=
 =?us-ascii?Q?grV1JO0dMwFvhEPXXNUovjPGM1uF/VpACdKMGv0L2KXMYSGQFXhlUhpJy+uD?=
 =?us-ascii?Q?Ldfo4Btez9w+6hIs3KMdYB+//+FsefDZp96jk3uHHjCXmc4/dTkUWoDujqDF?=
 =?us-ascii?Q?dV4BiBLcMNzCbxgjtcpMWJ4pevJ7Gwiy9+7s6fOohxvqBbLl4vXkJLTYxBKL?=
 =?us-ascii?Q?wmr3wU0I75qk8TYSDOsyTRmiPGmiVRl9caA5/kBOe7fEk6S7xeQvkCShgylE?=
 =?us-ascii?Q?moSauPWEDEfqILK3JBoBlb+ORQZjqklRUlpDFx4HdTHNx+JCka+JvK2zpgA+?=
 =?us-ascii?Q?G+YG6KU31Rxke/8ZMv4NSRVLl/nDxlz/LPYgfO4CbrMq3QH65uNrFK2gQFE7?=
 =?us-ascii?Q?xVDhoOR7pmke0EPxESzoKh0ynUOUoPoJdimUNWBKZqM7TEnDfHHKCfNV9tYI?=
 =?us-ascii?Q?XldmIwJOOSGduN0/zCQMISlxQJcf1L1UAITg+MDmIQaYpBGySAhAHgroEbMg?=
 =?us-ascii?Q?v8Ti74ifbRnSnCTs2a3IPUDea/6XtrsfIWETq+k+qHSGzok5MGSJf/C6KRCb?=
 =?us-ascii?Q?t+Vk4XbnTpzB4Sxp9djGMTeKUJFRVxidR4u5b9SAyTRGat2PmLd43f+jLmUU?=
 =?us-ascii?Q?M10uEDQk7E5ypTSDE7e3+X/ctElaGlIi0W5MIb5bSGNpKG/i5W1ftKENZzSZ?=
 =?us-ascii?Q?5HNihdfR/uJDpdpUvQQgrVFgwxnBI84j3dQTFr5JHHO20AAz2bVoIrDZVGZC?=
 =?us-ascii?Q?rf4FvyFN773dJ06nZtEh7daxEd2ICrhbJVlg5ezyttQYEfN5UrkXv7i1d/0m?=
 =?us-ascii?Q?aeodTWTIAk7ikaUQm4YSILWc2IKnMVwQL2RLU5emGq0RXetkX/EVptPYyuUV?=
 =?us-ascii?Q?gyQ3C01YBbykVzw1LaFxR8/lh8KcxcSRQtF+uHf5/JHJEGxZwtxSe8yjRyus?=
 =?us-ascii?Q?4niuqmDwf9MAeEEGkKn9Dqb24CIZmi0Rg6KVe5Jg+g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB6985.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J2ZbR7sh4noxDdQh+EOhXNLiQKHIL/mV4vNdyml75whHyEWF+b6zrCsciCZ6?=
 =?us-ascii?Q?/X4vj0CFB4gddLdYDIfOBXeXHp6zROGwoNg41XYb+PiCFItFlv89yFsuU4EK?=
 =?us-ascii?Q?+UxitmJJGSgHoFvkSRO+O0mcYM1B39j3KcrrQ0glQSKZNXokkIuEWIq7jdL7?=
 =?us-ascii?Q?0U3r0zOEsTjpMIoy7s7uyT9pe4/8KBJJ8OeMYLZjNPYs4no0n3uGjOp2Y2II?=
 =?us-ascii?Q?qUEolotxbAnWJwLpci7vhqm0CBgom5BZ23vCdBbAR3dX+XqMZP2P2SriYywk?=
 =?us-ascii?Q?N/lzwnjO8WAEZ1Qo6Vld4JIoh9YnmKax6njHaSrtwaUq7z/o/En6nk2G3jkc?=
 =?us-ascii?Q?18AK6bywhheIuVnHJOH6k2pteW3gus5N8iBES9aBAo11E4bd7lPrtX+unfN2?=
 =?us-ascii?Q?Sl2PEAw3NJD6so+Hrciar/Xjj7gekwNorBRZcQIvX5cYe5qFlEyGPTwZ1Dsj?=
 =?us-ascii?Q?aIdUd5qReccpbTHORXvq4PcJO7Dw8jqFXS0JrIZ5bhjdLB6+JYTib6+1fpYE?=
 =?us-ascii?Q?BnADtbVOmQRHOcd8OdRFv/NYIpFDf5TMbC8uD6IdFgKg5UsCHZ7xUh+UV7Rm?=
 =?us-ascii?Q?OMWgGeSdUCe4m9ROOYU9Ux3UKD6vVZcQtlSZ0Xfr48546yeToZAp+w8QHwaR?=
 =?us-ascii?Q?PbNhD4xxIdlYfX+4hOApOOYn+oXCPXjUj5pQkW33NrxRVFjcmCG7PfMu0ghm?=
 =?us-ascii?Q?ENfQI2/JHxiMjtRn2vS+jFP7Z5zGY22uluGgnYlthnoyag9PZbImLiO2rn5F?=
 =?us-ascii?Q?5I+j4yCAGenXF3AhvKJ3PlQwWqN4iFC4AILK3fFqsVbRDK4Z4K/vfWhyAvQR?=
 =?us-ascii?Q?6C5KS9GsZEQJMIyVPrM+w6YVkcDh2SA0LOcMibim4jlYWCO526t9u5awZwhu?=
 =?us-ascii?Q?c6WFX085eH0Za0CmfE+VKIgkOjJtSiwo09IDKGwT9urDCwuqQuchJzT2+TL9?=
 =?us-ascii?Q?+4NLfBzmw4ZW5qwEc/8nlv5DueSBDHYR5xMHPQn0KJPNryDDfPDzirkcOazW?=
 =?us-ascii?Q?TMLbm685wpyCy+pYl7uAPpLVQW+l0v59pVppcd9C/anzqUsSCtl8oWbfYwLK?=
 =?us-ascii?Q?Pa7WhScm7KKV4hjLRF59r9Scp8v31TOGLObO7q9D8QHHRZR2ZOCr4jRzuhP7?=
 =?us-ascii?Q?p561IrRBkksxqM9bkuwBIlfLXtOBdFceNKVCTRnKJhgTErkPNdc0Ln+hDOAB?=
 =?us-ascii?Q?eSEV78+VWDUt05kqbYt5WKkH6qbbBxhBGLY2MnhKGbM2VDEhc6WEPdLGI1Ao?=
 =?us-ascii?Q?JNJWX9k2FbB7ozC9FqhXODOQIueiutN21Wicd+tlmJ08NUr0gBZAxexCjVxH?=
 =?us-ascii?Q?U7ZsUxE9kYg9+IhsCrAqHD5rJw2yjzAo8eaoDlxf4xIPzO/ZHQ/BCQcXk8rd?=
 =?us-ascii?Q?Uwp+r/WJDahSYYfIXwyKutxENqiCpLy1Q+cC9+H4B1oqq6dXqPoVnIAItOsR?=
 =?us-ascii?Q?O612ZBvBsBY4fZnETOc2vxUKr+hccbS2472vguoagwNdxe0Jqo26iq/t5R7b?=
 =?us-ascii?Q?0vv3T9EMYOC2dU4ASjPMyHZaFxIqouz+NpkfG0O9a4asZ2fbsyvdMXBtYTJh?=
 =?us-ascii?Q?uNqGx8+pv+S7DCaNmF7QBVCJUqaFehTy2Mt03I2A?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 217d5426-4ca0-42ad-1487-08dc7b273bf1
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB6985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 12:52:42.0650 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4nDP4YbATc7QyaCnVvdO7j5QvLHfguwlNDZJRaT6zt22L6DvtJYEgk0HEh4Kcwc5USKt5HK/xsh+ZhjTZ23DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6713
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19; envelope-from=aaron.lu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Wed, May 22, 2024 at 08:34:13PM +0800, Aaron Lu wrote:
> 
> I do not have Windows VM right now and will report back once I finished
> testing there.

Tested with a Windows 10 VM and turnes out virtio pci devices always
use MSI no matter vIOMMU and bypass iommu are specified or not.

So according to the test results of Windows VM and FreeBSD VM, yeah,
it looks like this issue is Linux specific.

Maybe change the wording in the doc like below?

diff --git a/docs/bypass-iommu.txt b/docs/bypass-iommu.txt
index e6677bddd3..fa80a5ce1f 100644
--- a/docs/bypass-iommu.txt
+++ b/docs/bypass-iommu.txt
@@ -68,6 +68,12 @@ devices might send malicious dma request to virtual machine if there is no
 iommu isolation. So it would be necessary to only bypass iommu for trusted
 device.
 
+When Intel IOMMU is virtualized, if irq remapping is enabled, PCI and PCIe
+devices that bypassed vIOMMU will have their MSI/MSI-x functionality disabled
+and fall back to IOAPIC under Linux x86_64 guest. If this is not desired,
+disable irq remapping with:
+qemu -device intel-iommu,intremap=off
+
 Implementation
 ==============
 The bypass iommu feature includes:

