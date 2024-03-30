Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02767C6FD1F
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Mar 2024 01:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqNhE-0003HI-4p; Fri, 29 Mar 2024 21:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rqNhC-0003H5-Ej
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 21:39:46 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rqNhA-00071Z-Pl
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 21:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711762785; x=1743298785;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=SCPklB1Lqm8IC6G11VR8+V5bvccdyLYgQbEigCLs/dU=;
 b=L9kI6Aa2RDNDdK+ryG2SxDh4RUe71Ek71ua/R3yFtnxd4OtzXOzWCGu3
 lX3bvSyzYvAhvUH7Q1L84iKlvaSKgtdfPtd71ETf265O/ECRBpDsDRGLq
 PsfZK3KvWmAXiuvicwsciCv39OgfkLpn/teoozClN4oMiV3n70u3jZR24
 Ms/Px8+xczrcrurVuztsNGZuiZeQSUKyaipiwvW0yQnAqm1kbaKNb/kDN
 kwksrzTYWccoGkuNhBDE7wntiNoz51tWxGoHR1j+eK2G43SPgPzSH+P1X
 cQVBtk3QlDGHrd1VIZXByl4HXPmmPTkwDWt3ekr//1YJufXRLiYSIjvwn g==;
X-CSE-ConnectionGUID: gl7YnrZwSW22ZZv5JcWJcQ==
X-CSE-MsgGUID: F4yuNVajQe60ubgiKjJRAw==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="7067292"
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; 
   d="scan'208";a="7067292"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2024 18:39:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,166,1708416000"; d="scan'208";a="54586549"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Mar 2024 18:39:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 18:39:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Mar 2024 18:39:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Mar 2024 18:39:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Mar 2024 18:39:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lC5cWwpmK1Qzp7+Yq1FyS+6kB7B24MPDD5SSpsKAsQxCfHjpte0MOgcsQJiH/41kuY42kn2CraRqtINmQvF1VadZ+vLvFQU1YdCYdh6thNg8PI4XFk1pCP5hWmuJvU2efYBHvI2/AdnW7bmm6tZ9kWc7XpZuKpbGFwsntdzhOxHYQPRYEbp4j38k9H1tZcZEvnexR0TEkFuKI0idhrv3+m0fidiJ3+JmA59bRAFQPqaUMNwTKXXw27yNu/aGVBStuCj140uWJ/G7OVFjHdipcJg1wAW3NbGuLMTU70Du+kGWH7gStsKbB3S2BpGwIeBvB7XlnSs/1/eaZJJc4GaM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2ki55cbrZjvq1HdlvzMFVMmk7G0v9sYzZ9l/pg8UPI=;
 b=UieF/0+Q/5c5A+8j1mIYnBQ3q0/pOKG8EqU+8jtjG14d+wlPxtaJ7LAm/XFekkr/sjiWuQ4Ym/3VxZCH9y/fEGNUMnRssqs9uuYhVQ10Nz7eiVo3tyZnYDxYgADc2s5R4mz9RooXjsbrJP/XWo888y6KtHAsMODZROStCKoF5Lczq/LN72MLPvNGQRxmJHPojr4AHBpZo6JEYl6f+lGfiJsmiTvbpYqGZ33OcbSuzGYJJxpsGmQt++fCyjY7XLhM93zBGUtilUKBctpyPvcfgmi7XyIV6e2NNFPa10Dj0xYetuN4UF+CrncVo+oPpvZi2emlgtrqD67s4Mv9sm8pOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7946.namprd11.prod.outlook.com (2603:10b6:930:7e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Sat, 30 Mar
 2024 01:39:40 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7409.031; Sat, 30 Mar 2024
 01:39:39 +0000
Date: Fri, 29 Mar 2024 18:39:37 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>,
 <dave@stgolabs.net>, <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2 2/6] cxl/core: introduce cxl_mem_report_poison()
Message-ID: <66076d597cd7b_19e029480@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <20240329063614.362763-3-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240329063614.362763-3-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW4PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:303:16d::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7946:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g0sEkuRh0O4sRahKDXiPeLJpuHSt4MNR4I7zApGwOihs6GWOJMennz94CkyjlK63O5T2WbxssV8Yr6UgNOAr/ExY5jYjJhHGIcJV/jlqqJDnM1vTYbxIROffBahsiszxksdKX/UQ5xHIj5+Bh86yuX0vkuGKK6e+hL/5eiigny6q9xMNmrb/QlCThoo9Tu0KYwEQT0WQqwfQg3a0wefHgKUBMPP4B+Pzw6+pWh4k6E61C6zv6gciY0LfX4ZO5kXOHIPyjD+ZMqAtedbdi8HK4BREcY/f+g+jQ2lIUt4sbgGXnTNtLgsKUNdx3bkSgvXgUVKLyqVjVVBxkodDP3VrDkQ6CYfaa39f3LqvWXkU74Ao/cFBSRqFd0VEzHMEUCO/E0DJNe3VhwEpBcascPQrVa3iZ32owqrvvAU7ETikb99MW2pkJZ8wy/LkQPRGFyZmGiWql3hHtNPNZ71RAgDdQnGO5zjRF67/QvE/1t205J4R9II9WqbUeDr1U0YknW9O3zDyH/kz0qEKztmFX9vtjjJAXcw/nfLwwhJAMwTFCjncyNhqVhbq9gaJ0whh3dxvr6I9MUDtiCUUNro44rMJLzlfRHJBwNUYe3o6LZAR/t2F+1HFSDLBOBRdpjQgWR3yTHQIX8PqmJepVUwkesWH6psaiVx5p9P/w6inqN5hPmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8107.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mQx7NUyv6hKZeCiOW8ltqkDu1owqPlqSlaVa/e4+sg2SCHzAUNbbHJMmJwKn?=
 =?us-ascii?Q?oZGFAjwY2BXlMneXSzhDaWwVgb3i27V9Q1sOkZ4uet7Bo8F2POj/e+rX0l/0?=
 =?us-ascii?Q?U5bTcIF3IHay2XvxQUKHsfxFpXaY/RakaP4+PoWIuwgm/BVgdAbHDK0EnG/z?=
 =?us-ascii?Q?FaUGlBNLn9TXACkdUDOFhO1qzSuCGBxLkpCGzujtd+lyZO49zwJo2N8lHEbT?=
 =?us-ascii?Q?9INkTiqHTdwFBysgg26bipSIpBlkukKeNgBvs8Wuy4gkCTGm74nicki5pM7a?=
 =?us-ascii?Q?0ToOi56C2HKOpYEyxSnPnUTKf8TWPkGc2Msgk/oKc0G2Si6LUU9iXyKHS4y9?=
 =?us-ascii?Q?nsdseIEGHfrUF7oyqTIMGuaOycixVgwtmbX7GKD3s7xIRm3WMKhejdU24JKX?=
 =?us-ascii?Q?jZnHemOUvwKaK54TBXNPtiv27p7jGlLEl/c6fcwnksBTeEPqSeFqXQtktRKE?=
 =?us-ascii?Q?TmJMm2K0RsiC51nTGuxS6TmioDbLvI5Y9swfNIsE45LoWja1j7gauOkCPAyW?=
 =?us-ascii?Q?hAE+DwyXVqOd4z++/LCW1senkg/WBjCIjxdmG335TSrOA6wNQ23tifIsFpSi?=
 =?us-ascii?Q?QGdqZcZvrkcVKqGE06x+O3vZzp3P9D+8K9YOb4tFsdsbeS4iKCCiOJFJhZSS?=
 =?us-ascii?Q?Byj8hW/pwZcvdCYS4y5KGiTTp29jPYt4siRxQ+qCwArcng+xgC+gmu82EKTu?=
 =?us-ascii?Q?SS9s+MH2/nvFBgnGBOpxZ8869qnDg4DhuOK06IpCXiCsE0teeFq2hbBlRo5U?=
 =?us-ascii?Q?ZFotph9iRhlPoILkE07/Zhmu/rgqPn6e/lNKYd/ytTAwHHK56IgpRaH++nxc?=
 =?us-ascii?Q?3QOmTltWRu5kCuS9QO8VwxoxbC7gixstEKho1N4xxvSEEXL9waCYf/j8tAMq?=
 =?us-ascii?Q?UqOzYqb6IrRtD5TyTHWdUnWt1Fyw9sJZSixLsr92qNGxk4IlTEP+ZuINUUi2?=
 =?us-ascii?Q?t/YiD7A0sucNXGA2bOC4DvwSE8VUPKL/yz5gcDiebtgouCPndsayghcMAvt5?=
 =?us-ascii?Q?IqlqCjKc4bD865uz9fcJQQSw3z8g4IcIAsOpA6wINzDVPNLChal2wHgLVo1o?=
 =?us-ascii?Q?GobH7nYRPEGJnOC7zKJz7gXXwtXDkUFS5jqgfgbVxReRHfefERnTS4FYVfw/?=
 =?us-ascii?Q?ctqqUuxUfS58xps7XiIPCy7qIx0UEYHK3NXsZ9XEHbvQ+egX2+1gL+O7o/0m?=
 =?us-ascii?Q?ncCVb6l2PIInDda/Udn1OKZlxRfbXSMV1AjEGguC/DprFfvvnD9QRxWi0+h4?=
 =?us-ascii?Q?4f8Kjn4FqV1sty4jlEXEFMTsqlJiHdOMzwC+4aLhqSgk7sW8H67ts16uv+aN?=
 =?us-ascii?Q?ja4xfWlV50a7jw3SLUUCb41LueQudysH2llKGgr3drvAcPwXIt7TtLcO6z0W?=
 =?us-ascii?Q?csNkMmdiFXcOTl6s9i4VObA99obhm73eRJxSX+Z3DrHHkhQmZ3KOEgQEwXGR?=
 =?us-ascii?Q?QBVSb69TDwWfI+ruVE50okr0dbf616FsdaI7ETxrp8DemLfbHZ6QciXUcN0V?=
 =?us-ascii?Q?ubqmTbQ+ozAlR+YbvXKvFN6qbaZfUI+TIDXDuThUx1nMyTNis3WBSI69ufsQ?=
 =?us-ascii?Q?7B85QKKqz8wXA/xNeMVTu8XHu6EDTMh04TlDF8xDLxMraN27VdbBk7IMFOqr?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bfb77b4-5d70-4dc5-f5c0-08dc505a43ef
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2024 01:39:39.7791 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDVbFQbzHejoWSEDxBLVS8v/0heNArJ0WbPeeRvWKkU5RPxpHqSmgF711b5exlDA92G4WEGkr/KFWOH3/dAPJwhuanQ9RW2D4MaNrRvOLIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7946
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=dan.j.williams@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Shiyang Ruan wrote:
> If poison is detected(reported from cxl memdev), OS should be notified to
> handle it. So, introduce this helper function for later use:
>   1. translate DPA to HPA;
>   2. enqueue records into memory_failure's work queue;
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

This patch is too small, it needs the corresponding caller to make sense
of the proposed change.

> ---
> 
> Currently poison injection from debugfs always create a 64-bytes-length
> record, which is fine.  But the injection from qemu's QMP API:
> qmp_cxl_inject_poison() could create a poison record contains big length,
> which may cause many many times of calling memory_failure_queue().
> Though the MEMORY_FAILURE_FIFO_SIZE is 1 << 4, it seems not enougth.

What matters is what devices do in practice, the kernel should not be
worried about odd corner cases that only exist in QEMU injection
scenarios.

