Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681C1C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 13:51:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBEg-0008D5-Gu; Tue, 09 Jul 2024 09:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sRBEf-0008C2-0H
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:50:25 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sRBEb-0003Qo-UX
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 09:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720533022; x=1752069022;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uXjizRoQT6btR+qqIgDYyDBC2pINkqLz2CoUZzDIXWY=;
 b=U4dzqcOBeW2fDUQBXZbHHvZ1TeaIQcpZF7tUFoYG8E//zjqH7Ep3szro
 NYoaqyxu2l0//xz9pyFnH7xShiBisH1/2QbAsv0e4dc5/xjPJscKAgVhx
 +7k6PhEv+ZMLTCPMlJE4rXj/kHY/LFS2Je05CxLegQyFTFodOOhvXUKBM
 dR36oHnkyIhMu/+F925E8hiNhSSFMd/R68Ann7xiXOy3grVRUXGx3II9t
 +WvAHwbfslYAWdmcTQoknaJWfH0cmjjb2WJ9JLVoj1Qp5Ez6NWZ7/rBbj
 Nk8XEhMFA3iyxamBqOtHm3gQ85yhe3Z1e5+up0lOxMpEIIOgmUMSZWnKj A==;
X-CSE-ConnectionGUID: Sse1InVNSQ+zHxT0le1Mdw==
X-CSE-MsgGUID: kGicWVmFSjas6eoHT8zYfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="17607559"
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; d="scan'208";a="17607559"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 06:50:19 -0700
X-CSE-ConnectionGUID: 8k8GgWWDRAOo6vLOu90HlA==
X-CSE-MsgGUID: V1PZVGYXQUaErpHS/f5kyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,195,1716274800"; d="scan'208";a="48516810"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Jul 2024 06:50:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 06:50:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 06:50:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 06:50:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 06:50:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXadQQVN06/uhihWtFodbqJeqgVQSYIMOzoMv83TuC0kxm9O8w1BA9WGj98vjKpv53BThw5zWGJMOOMtdP3P+rImUi0ldqLg9b9WiOTftO4PX7B3M/jlpJ/F9sFfRhyp/R6nl4vxgPKEcOlNbLBLAavfQL8i0bo8KE9qcYt+ydS+x56jvVMNsXjEBKKUWs9Ob4/l1ZVK7gF5kCAri3P61istczb7rg7A9Ts+ota7gAckvX2wl4AriidCjRVBb5HK8F4LcvGZ9ebvyCiukBbArZ2uco/JgvB9UQ8t9VHDiuCCATWDD1G9aoZvZTNyoXgeHdme+r1aw1oCbLI0T/tQMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JB7gu+3Ae2XlXputLB+2qmymbsTyT+dTznZlmlE2gNs=;
 b=dPoZdh5NONvsg2UKrwd5UYyHfBoE+q+D45BYZObP54DCWmwZP1u1W8Ot4uNM8lnhfZy3FtcNkT0o+7TH3pfrIejfR8U7u86Tn1vlSpwIufVVJC+1cmP+ooMWzCRuXDGqXyleaK6Gh//rtDQA2OEKye44k1/k5c77sE5jWuNIfwkHcLRTj8UBgquclwmFy/26hFsYelTZREQfkSSULjMr1XA0zfoLVJ98txDtJ7xBrDMY4OHyebe00n4RiAVMg4nZNnL8vwseVPThFwmWqGGYPYowfWrcXc71hb0IjepAzXVsox6HlM9eATTBkGTj524GcJ9KoJ+9VoENPO+cuoRiPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA2PR11MB4906.namprd11.prod.outlook.com (2603:10b6:806:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 13:50:10 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 13:50:10 +0000
Message-ID: <95e31b5b-f18b-4111-8c27-8c0af1065cfb@intel.com>
Date: Tue, 9 Jul 2024 21:54:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] intel_iommu: move VTD_FRCD_PV and VTD_FRCD_PP
 declarations
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Minwoo Im
 <minwoo.im@samsung.com>
References: <20240709061756.56347-1-clement.mathieu--drif@eviden.com>
 <20240709061756.56347-3-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240709061756.56347-3-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0179.apcprd04.prod.outlook.com
 (2603:1096:4:14::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA2PR11MB4906:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b6ee8e-d400-48e9-fb3d-08dca01e0cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dW1aaCt0ZnlFTTM3WjY3cTkxTkxtWmxuMG1RbjBnZXVxRW9NbEYzN2JLalpX?=
 =?utf-8?B?WnZLL3o0aXV3MEZMb2xrejE3N01RcXhmZDNycmJaQVQ1UFlJTmZOSEE2UjJD?=
 =?utf-8?B?b1djdlJvbElFTkJ4RkdicmN0RWlQZ1RlVnNpQzh5NUNtWFRZL05LdW9xdjRW?=
 =?utf-8?B?QmxRek1KdWtJZi92a242T2NlZ0tpUTFBRjlMM1BmVEY2RkNtRUZkVXVuYXRL?=
 =?utf-8?B?cFRwSHR0L3QwNjZodDZIcWVjSHN1MUVlUGhiOEZ0MWgxQnF5ckdPUk9hS1Bp?=
 =?utf-8?B?eTJaYU83WnZnOHphWG9DeDZ6U2Z5djBCQTIvbGVQeE5nT3UyY3VNWTIreE8y?=
 =?utf-8?B?MTQrMHRvWk1kdllqalQ1MXhEWmVoNVd1MFdTWFJjaXk1Yk1UdE45ZENkMkh3?=
 =?utf-8?B?dVVEai9TOXMyWmtZeWs4SkNyVndybnlqZXJ6WXZQa2NjNTJVWEVZUmlSem5O?=
 =?utf-8?B?Y2dhQnZzS0paYllzTWZONnV3M0M0cEZPTWYrL0I2YnhOTllSQTBVSTdyd1Ir?=
 =?utf-8?B?QUNyM2J6Qjhic0VxRFdwNWhSOUFEdkp2SWNHMEhHU2VpR296bFZ1KzlrMjFl?=
 =?utf-8?B?UUJmR3VPNzArMkxrT254Y1pjejYwN1orOHB2L2pnTm91QUxQaTV1VEc3Qnpi?=
 =?utf-8?B?Rk9lTUNGTkZNenV3RkMyeXRZUUU5Rm9qYVJzU2tXaDJuT0JYRTB0T215KzBP?=
 =?utf-8?B?aFpmVk84WUtDMEE5S0xxMmQ2bklERjBDeGsrYzhsczBVME9QdGF6NERrRW5M?=
 =?utf-8?B?SHNJSlpNOE1tN1JxR1dheEh0Ky9XeU9RSmlEa1kyRHJGU3FHWFJpY2ZGUlI1?=
 =?utf-8?B?b0U2Q3RYZzdUNG9JQkxjcjY3YnE0NmRRaitYYjRWZ0lCeHEwUUJmSWtiZnd4?=
 =?utf-8?B?azBLMGFFcS9aRG96Y3NwYTdNS1ViWDZDQlBoL3F5Vk41NVdpOWN3VjlCNElj?=
 =?utf-8?B?S2Q2ZkdKcWhvQjU1Vm5VdzZ5MEdReXFJTE5NVG5TUjFCN05OckhTNXhNbk91?=
 =?utf-8?B?dmkvWFc3QTcvZDdhSFpKWlVxVjJUWnBxNE9WenpYSm01RDFFUGhxb1h0ZlBG?=
 =?utf-8?B?bDRUSEFEYkh5c0prV2hmbDYvclZwaHkyNkk4VWNYMmxRNHVUT1lVRFgvdDR2?=
 =?utf-8?B?OXZPY2JXUVlRTjFNQ1ZpWE5rUlJydmFnOWt6Zk1pUmpCbFlJdytWanVyOWVL?=
 =?utf-8?B?RXRzbEx2T3dVWWhHS1lRYzdHYU5FeVdLV2I1aXRNbER5bjRsVkVEWTFNOExq?=
 =?utf-8?B?dUNxZ29CK0g5RW9YQWk4Z2FkWm40TTdRaFlMa1dLYWNQZWZZaC9ubkRURmlT?=
 =?utf-8?B?aVc1a3VDeG5HRjFDSG52QUVZOFZjblhxeXJhT2pQYnlUQS9JZGFVWmY0OXcr?=
 =?utf-8?B?SlBiaStDamxYaDFkOHp0di9QQUZldmVNR0hzN05WWjkwQm5ZL04wN3diYlF5?=
 =?utf-8?B?eWFxOUV6NkZaWDZ4M25IMUhlUFFUOVNpQmhBekNDejNjRHE4QlZveG5sbkQv?=
 =?utf-8?B?YnhQeWZLRDZiT1BiclRmbHhjWVZ4WG1rL1ZXWlJXa3RXNU5haHVRdWtRNVh5?=
 =?utf-8?B?Q3F0Z2tNd3U1QmNvc1o3Z3c0T0dCT1Zob2luNkF3N3RRbEw0N1JKWW53cVBs?=
 =?utf-8?B?anZxb2EyNTdaNU5VWnNtak0xZUtPZmN3ZGZvb3doUm9jQ21ZMzdmY0dDR2U4?=
 =?utf-8?B?TFJPRVZoQnJ6NVd4UkJWN1prUU8yaEN2N2hFYUpXRTM3S1V1eVYveTdlaXk3?=
 =?utf-8?B?bWVGNGFRdEZSR0JDSnVST09DdXVJcEYxcFlpblRoVlN2RkZiNEcrS2M5MjIw?=
 =?utf-8?B?bkp2ZFhISGx1RDZndDJ3QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTNHTGlOSzhLNEZaUGxzUk9mazI1ZXU1MGQ0bTV5UklWYjZJeHFSU2R6OHlN?=
 =?utf-8?B?Vi9CeThWQ2NZaDA2MmZjUnFWcWRjeThUSVRiTFNKbkNnYUxxcSt3SFVRRkVU?=
 =?utf-8?B?Um13NUgrM2JHckhtazFkTlRLdU1hY2s3Rjg2OUNDNGhsNU5RVmNmMG53RWdF?=
 =?utf-8?B?RTI2cUtQcVNaTUtZa2NpWXdFTTZvcmk2Ym8yYnVoYitlbjN1byt5MnBQM0d4?=
 =?utf-8?B?N0Y2T2I5bUdhTUhPbDhLTUZ2cUZCTDVMb0R5eW95RW1DZzdVbW5QRW5nSXFz?=
 =?utf-8?B?SWFZQmpDd2h3Y0JMODE2V2JscmhQT2M5QVFoclVJem5HUHA1ekMrY2xwNmxO?=
 =?utf-8?B?L1BXNytLZUE2Wk5xN2xzRFRBUnNJS1g1NkhDSkFMM0hvQUczUlhlM1ZJR1Nu?=
 =?utf-8?B?ZHdSV2VlUTYzU2xSMWtsMXllRlQweUx3WDZWQU5NdXkrSnc4eWp2ait5L01R?=
 =?utf-8?B?TUJmcFFnMFVVQnp3a3l4aEdvdURaSVUxV3owSXRLUUtXZzE3WldpZXpoT29z?=
 =?utf-8?B?aW13NVJ1MnFoajUrci9hd2tNY2hkSitORDRIblUvb1Z2TkFqKzg0L0E3MkUv?=
 =?utf-8?B?Wk5OeHI0cFdhcnhFd0VUa1lEaGJ0OGJWNm0rNmxCaW1scjJhVW5qMko0cG9u?=
 =?utf-8?B?Tk1VV2FtNU42aDFORlFHcjlGTWN1a0YrWXJ5TTB0UjVhYWVhQVlWdFBRZy9t?=
 =?utf-8?B?WFBXYXk0Z1hsVmNnNTRkbloxMGZidzhvajh4VExFUHZlOGVOMmI5MExxdmVL?=
 =?utf-8?B?cFBGcGdtTkpsSDZvaDM0WDRHbW1YTGJxaHJzTHFuQlJ4MjRNTkQ3d05KWXZL?=
 =?utf-8?B?S0JLMEtPd0ZSYzdjZXpjdEs2Nk1BMGVHVlNpdEJ4M25kbEgxQTkwTGt1dlcx?=
 =?utf-8?B?TlRySGdQVXZINzBqWXJPVXRzOWtsRXcwc3lFeFZkR3FPWXVkN2JsQnRVMjcz?=
 =?utf-8?B?QnI1K2ZCdkJzSEcrWElRUGphYVF2QWF5cjl5UlJScGc2Wm00SkwySTJKQXlj?=
 =?utf-8?B?ZDJldzVtbTN3R0pjZ29kYncyWkhGNldNU3g5cjZIc0RPQ3hoQmpJM2dJcFRU?=
 =?utf-8?B?c2dtMmV4N2RQQnFpYzVLTGpSZFBCSzQvYjE3LzMySFJDUXhVWE5RYnRGeG9y?=
 =?utf-8?B?L3NjNkNhSVgxaDd2NWUwQWVBdGpHS0Y5a2ticXA1Ui9JZXdXMDFvZTQrRU5j?=
 =?utf-8?B?RTJaNHFiMHBDemNKWDJnZ3lzYm9hcm0yajUwZ01xQVRhS3JSTnpudTk2bm50?=
 =?utf-8?B?ZDM5a1RBdFBpTmtLSzh0TE9DWndvK294V2NUZXpIbkYwUlVtMGVaWWJqdlRD?=
 =?utf-8?B?eE9mSTFEOU5OMlhZWmViZkxXVG5wNkNYaFdRVGxsdEZrR0pHM2U1NTdkdU9V?=
 =?utf-8?B?cG1YUnVDRlpwdE1NT3pIN2xlSlhtUHhQZUVCMjhiZkRZZ1kzOVFwT1BheGla?=
 =?utf-8?B?SUxBUGg2dm00QWFJcjZ3RlkvbG9wSnFqSWZWTGJVVEtrM3Vna01ZSlNTN3Zy?=
 =?utf-8?B?QXI1WjBHd2dTc2FmMXd4bFplNzdlS2hkOG8weUNPNGZzUFZEaGdnZWhiL3B4?=
 =?utf-8?B?RnVvcHFwSjVwUTVwMFYyU3hHcGpFdE1WWlRSNUpsN1BJZVhKWFVuUzNaNk9P?=
 =?utf-8?B?TFpPb0sydlVtdVVhT2N3RUcrZTNwWlhlUC96MXhib0V1ckJaRW1vckVMR3Rs?=
 =?utf-8?B?NFRrcGNVZm1nR3I3TlU0WUFYTnQxZFdYM1lhSnl1S0c2M1ZpdmFOalFEVHF4?=
 =?utf-8?B?dGp0LzZMak9xMGxWQjgwVVZ1S3NSMHh6bG8zK0JBMXMyLzd4MHpKQzlhZWQw?=
 =?utf-8?B?RXhOL3RWeXVxZlByNU9seEUyR0NpYkZSdzNPZmlSaHJMbW5NdEczT0YxYVVG?=
 =?utf-8?B?bzBoWmtYaDRZTWdqN1hZU3lYSCtwd1NoNFJmV2tDcFdDbHdDN01FK3p0cnF5?=
 =?utf-8?B?TDZha3p6a0NJRlFXdk50YmdYL2V1TkorTUEwbWRYc1NvS29KWm1Hd0RMV2p2?=
 =?utf-8?B?b2xvQWpJclpKSGRoSjBpYVNxanFFZlRlRFp2THVneGJBMmRhc2dwV0Fsb2xQ?=
 =?utf-8?B?RGZqREZ5UVQ4SWRtdW5jNDRiNFZkTE5hZ1gycDUyRUFSSTNTcUNOeUpYRVJW?=
 =?utf-8?Q?V/Orr1xjDvWVUy7jVGIAGOYO1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b6ee8e-d400-48e9-fb3d-08dca01e0cb5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 13:50:10.6117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcqIDc78kDQYBevMbtORhHllrmchXgEtcuIPVBEOCvYaUcicP2VNByOUjXk4iYMrbLLLsRC7r91A7yCP5mykYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4906
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On 2024/7/9 14:18, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> These 2 macros are for high 64-bit of the FRCD registers.
> Declarations have to be moved accordingly.
> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Reviewed-by: Minwoo Im <minwoo.im@samsung.com>
> ---
>   hw/i386/intel_iommu_internal.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index cbc4030031..faea23e8d6 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -264,10 +264,10 @@
>   #define VTD_FRCD_FR(val)        (((val) & 0xffULL) << 32)
>   #define VTD_FRCD_SID_MASK       0xffffULL
>   #define VTD_FRCD_SID(val)       ((val) & VTD_FRCD_SID_MASK)
> -/* For the low 64-bit of 128-bit */
> -#define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
>   #define VTD_FRCD_PV(val)        (((val) & 0xffffULL) << 40)
>   #define VTD_FRCD_PP(val)        (((val) & 0x1ULL) << 31)
> +/* For the low 64-bit of 128-bit */
> +#define VTD_FRCD_FI(val)        ((val) & ~0xfffULL)
>   #define VTD_FRCD_IR_IDX(val)    (((val) & 0xffffULL) << 48)
>   
>   /* DMA Remapping Fault Conditions */

-- 
Regards,
Yi Liu

