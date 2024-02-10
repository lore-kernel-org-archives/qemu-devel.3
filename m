Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A520C48260
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Feb 2024 06:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYgwo-0001WH-9v; Sat, 10 Feb 2024 01:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rYgwm-0001Vy-GL
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 01:34:44 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rYgwk-0005gc-7V
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 01:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707546882; x=1739082882;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=NhhyJK1jBsFgxVq1fisk/NSwwFaqHBsE1uEV/S0q2h0=;
 b=oFRPcJAk2ajn9boLVDwVqWgAzkJNowK9Gmw3lzF7WcYViOgER8HxApB1
 5Kp4LzukRYwtWavmIU1dzw2Yatwi0p6ajrbXjuLkBqQCXytIXFX/0x025
 dZrDdlBk7BWdaoq0Yuau9dKWMkUCnUgPiDs8u/jifM/RlgT9jWGrmBJAC
 tSaoquJmPlZmY1xCwmiemj3zH/whFNMNrlvvt5X6y6m+GBwx975wcUrre
 /jI+xWK2T9D7xF16iPNiN6a9MHvMqPxd4csteCMUHlNQRT9z0p0vC9OlL
 nId4pmSp3j9/YdNfZce2O3PoALuMA82xPVxyjmlMp1W2CO2YYPR2RpP8n A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="12631070"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; d="scan'208";a="12631070"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2024 22:34:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; d="scan'208";a="25347289"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Feb 2024 22:34:37 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 22:34:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 22:34:36 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 22:34:36 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 22:34:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLdJ+pZpKTSN28CFvuv5zXwmcMj5qGnA2bHvOtVNTIVMElodsLP1y1V2VV3MACZErRJ2N/fRWvsAEjcJskRhZDPQfA6CddGQh0p8aBPpajLvknxnp43jpy6f0fH04EiV1DRnUaykZRKivMRv8o3kx1G+C/WS5oRI7XMg2DWF95luDnnvBUG31IZ/5JaSjFciPJflF2Js6xc50fxbJ55wYnW4B/IsVDf2+2LNpGtyfBqe8txjdF+55LVADg4xxQ19vfXDNrVvGDiAEkwoHSDgjx1Gctv0CsM2bC8LPBaZIh93X4AUM7FVwXD5KeMWiIydAmx7zaN8fzL4z04kFTfAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcuxsOIXMrl52e/ZNE0nA2VN5v73gSmBnBtfblFLa+0=;
 b=MkG3imWiP4548XneGxk7XfvqUXIEmJtgqPexQyjvfFQKdc1MWgvK6Xo+iYZxWAa12CzLAqr1wiIQgWj04325C+5YhDyYOZYWnGm4VZeNxhJkmkrHdITxFQoiakOTV3FBbsiWaWzzFZRvmWQPIDeIQpK1Os4QiyzhMHyPKU72xbQidkrUemmzk99lj7SOH2AwakeCmbHQhVGHmjmw4eiP+y/bFgpEzI23XNUN+NJsVhcQS75WWwgnpwOgQjReFgO7a5zmgCRfm3FUxpsO6wIlppbiCvInHXOxrkhB2MiIwPsczSaahuSuDIAReSC5ijNDgnlgVE1xbaUfKACIty9hkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6319.namprd11.prod.outlook.com (2603:10b6:930:3d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.33; Sat, 10 Feb
 2024 06:34:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Sat, 10 Feb 2024
 06:34:33 +0000
Date: Fri, 9 Feb 2024 22:34:31 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>
Subject: RE: [RFC PATCH 1/5] cxl/core: correct length of DPA field masks
Message-ID: <65c718f786340_d2d4294b9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-4-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240209115417.724638-4-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW4P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b39c2aa-9d75-487e-d0b4-08dc2a025802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yN/R08mR+HVMMNA8/wxVPv4KZo2mDs2XgAoRgnaxKcnRhi9W31UTQYbkGxOAap4Ko7DUhDp63tS3OY77h7KaUG9QkAoaAI8Zdd24iBUOWasNlyUdxEYBUbZbmYY8brMpkfud7DQaUX2nG+qEbLiTS07n4LLV9+zWvNXoPpXz1a6RdMoMVt0luAQQ4gxKKx9VoGS/KRGeENf5QsVPqVla17FOdie/LQZEsnG3Ryn8hm7qxRCkep+Q/Ei8xKda/csRD3WwTkmqFitEokVURmPJtq9VjjQINaJozCgHPlHOZQKcocVtF+M3LajUmjgJJe34u8RqUnUbpNaeibVLyp7YjWbcRdJfMKTFpSoYkcW5dKbYV6E9JRx5QZYPBj7SZeGuswKXWFIIgfvquIvoViv0kGJhrnumhC8bq3bK1ujyiWBLPgzPd+1KTPiOEW9N7yHOuF9EEXeiBx4WM9rhFQgDJOXoh9Zific9F4i+PdohZtKZyZxX7FYA24Z0eZ5GccRh7NygE7AcZTMN0gR9TaqH8zKgGv/qlhUh0bVs7GkswEMUZKpojwMxLvfx8K5ReU3t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8107.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(4326008)(8936002)(8676002)(5660300002)(2906002)(83380400001)(107886003)(26005)(38100700002)(82960400001)(86362001)(66946007)(66556008)(66476007)(316002)(6506007)(9686003)(6512007)(6486002)(478600001)(41300700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GVQQOiy3DjhfT1v1bBKbyJSx8Wx75k+C08w2t5+rHxTlChNjIcV/NitbEhCF?=
 =?us-ascii?Q?vApDukCZdwkdt3f+/cDO8WwyUeR5jB3Q9Qw3z1UivLts7NJEf5JWlbbs8Hak?=
 =?us-ascii?Q?C3FXxKkfJkGfGCPKLZE9E2xT1CAQ8TowG9wIxjDqFFd98gHZpWC5776G12NW?=
 =?us-ascii?Q?VIuqKsJO3j4w5RM1A3PxOUluTu9goNzGBXjUNIe6I+KjtTCrf1rClHJ5jzRu?=
 =?us-ascii?Q?y0NZp05gPLRA0xtvFZHpd7jXnKuU69OHqdNmMSiR4QzBYKobMHxoHW2aXR6p?=
 =?us-ascii?Q?grsVoURIiq2pHK1loG3xlsXi4Mnh0v2tZERoym1RcxmCbnUCoXmGmfuPFTO2?=
 =?us-ascii?Q?dAZX2whSBkjnlIdO/gtRSZxA20EKDNNg82lbisiJ9EpXwCl2/ap70q1jPyho?=
 =?us-ascii?Q?KYYEr1hsO8wrLYpc17SOpudnQljkC9/gXIo5Mm2Ab1QAJwwVi328QD6fdHFi?=
 =?us-ascii?Q?Xkj9WFk5iCGPznPjm4zJbLOEykA+kMMFhTtgrmuJn7286Z9X3ocoFpep/ZFG?=
 =?us-ascii?Q?2FcV6BLmvriHo6Kj/shiuNRpiBfCcp/MMLbGhVJdWD8RFI84tH0FhxfUTWTr?=
 =?us-ascii?Q?nZgSltKJOyr4pmEpMH/K7cJWoX3c+lNWhK9pXD99j3P2mfL1XT+nR32c/2NE?=
 =?us-ascii?Q?DGPTYMd2vLfa857PcsNxxwtC6kOLZRvpDSOXF6mPs9Yk1k1vFG5AWtzvUpRo?=
 =?us-ascii?Q?mtuNkkWIWp7FqGkbJyjprUjq1B2CWtw/Amb2nf4UQ+OS9yI6Y+Psd6x1t47A?=
 =?us-ascii?Q?WV87nhy9UP9/4nIzUdqu7r1B8b8E8v8G4of1BMjmczJZmEw08IJ5L/MGdmCU?=
 =?us-ascii?Q?qlqhuCjKq3s7k6XoIav2PMdrCTDLBVED96UHVN8WbHfV7uskcF6NGy1K/ROT?=
 =?us-ascii?Q?pVR4m0Cb+NLaljMjCGXUX0sHB6TJQkRZQZxnKlo2nV6S8WBlHQb3SpQ1Vgey?=
 =?us-ascii?Q?r3XaCqt1aGkhErp4xDEJdQLje/qcSeIFIfwn9LUZUs7AZMldW6L/PWu2Pfnp?=
 =?us-ascii?Q?uCnbfoKEFgVYoGACzf1BTSvNiSh5iHpg3rzzQTGyai+BytkzwrMurV7CVWlh?=
 =?us-ascii?Q?MhmwGC8a9Igp9qmxdwGEYf2CxV1Xh8/qdMVghG+mChGXu8Xvy6E/71w/3wqm?=
 =?us-ascii?Q?SCRyk+5uckvCW5IFc5/YbAVTlQvAdFmYVkwAs/f23hwQI+2H0QosAM08fofV?=
 =?us-ascii?Q?QveK1JOkWkcHaW7IdvnxaWgySnMJn1/I4fqMRAbx80WcrrG0oWMQzdSxx19m?=
 =?us-ascii?Q?Xyg1vtOnqdCgYwOuEYEZlCQCfwYfwvW9pzN/ynliBzUIyJkKY0KmyOZiR0Ep?=
 =?us-ascii?Q?DvI396Ha95QAi6Z4fpsgMhBg7resjLur4KDm9ns3XnlC3pr7FB6fsDewlmvN?=
 =?us-ascii?Q?tMwil7UPGezB0NqEnKTt9mfrXxnAY3PmLMvs2jZmU7KWJbNM2z/dcLYD7Z/F?=
 =?us-ascii?Q?gtNZ98R9S2fG1Hu8jBCCHVvV2fj0xhXvTPZhIIFGFTqawn7ntlMEcTh2xAe0?=
 =?us-ascii?Q?Aae2vb4w5eAwJ7ISJBldenHbD0ecLP0mTwvq83LnCsiHgvlw8VlbXNIXTfJs?=
 =?us-ascii?Q?PxEOysN8a3+WM087xHSOMJVteuA6XTC4JGpvp3wLHpRzvj4Z2DqVz29MGnx2?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b39c2aa-9d75-487e-d0b4-08dc2a025802
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 06:34:33.6495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IK0DhNIUj3kZlpUtUERvdOF66JNrGiPRDJeaLAgQtHyCkpq4moNm/qaXejUTn9zrmSmSyiNUjpCNxgp2cu+HZdTcraIZB8szWO+66ShdPYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6319
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=dan.j.williams@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Shiyang Ruan wrote:
> The length of Physical Address in General Media Event Record/DRAM Event
> Record is 64-bit, so the field mask should be defined as such length.

Can you include this user visible side-effect of this change. Looks like
this could cause usages of CXL_DPA_FLAGS_MASK to return an incorrect
result?

> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/trace.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 89445435303a..388a87d972c2 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -253,11 +253,11 @@ TRACE_EVENT(cxl_generic_event,
>   * DRAM Event Record
>   * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
>   */
> -#define CXL_DPA_FLAGS_MASK			0x3F
> +#define CXL_DPA_FLAGS_MASK			0x3FULL
>  #define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
>  
> -#define CXL_DPA_VOLATILE			BIT(0)
> -#define CXL_DPA_NOT_REPAIRABLE			BIT(1)
> +#define CXL_DPA_VOLATILE			BIT_ULL(0)
> +#define CXL_DPA_NOT_REPAIRABLE			BIT_ULL(1)
>  #define show_dpa_flags(flags)	__print_flags(flags, "|",		   \
>  	{ CXL_DPA_VOLATILE,			"VOLATILE"		}, \
>  	{ CXL_DPA_NOT_REPAIRABLE,		"NOT_REPAIRABLE"	}  \
> -- 
> 2.34.1
> 



