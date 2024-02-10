Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF2D7C4829A
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Feb 2024 06:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYhGP-0006gc-2n; Sat, 10 Feb 2024 01:55:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rYhGM-0006gS-NX
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 01:54:59 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rYhGK-0000Uu-GW
 for qemu-devel@nongnu.org; Sat, 10 Feb 2024 01:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707548097; x=1739084097;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Ob54Gv03QfS4gA664Knpx/Vl9fVs0xSVpvajm5NnYic=;
 b=Fmkf8Xttqa42NdQNGucVmg+ryfOw8s6v/ypvIsLBQ24Yf3Ej+MoVpj0S
 6hsFvGqvl04omOQRAdMlp//FxHAL0kX7kxQprtmKjGtanyXq6i5r3Nuhv
 hWbHfoIaxDfI9WXnIedeeYYFtzjNZRlCXYX0Vw4g1jL8UB3PltCBFkQZY
 fbF6e8EqaCYmSNPcyeZdNA8Ikp0obrrmNIhQVALd/o7pTMgRLzYe/0eca
 HFeaxHxUrMg3H4aTfTheI65C99jvS0syGiS/ogoumb+iEhvw4GS5PnyZ7
 yIKIuDhUz7UXizNYOrjnFhBwEewFC5agQ5xspztXzA2XxN+iKiY0+IkmA g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="12632178"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; d="scan'208";a="12632178"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2024 22:54:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="6727477"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Feb 2024 22:54:54 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 22:54:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 22:54:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 22:54:53 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 22:54:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+quISYNMmEQxlAg9wDSgr7+x8vw7uAc0QuL0+uXuyiOC/qxo5RSNkNeJh6Q+DDMDnXWOgtvypp0er2eqBZrD3/ivdUIQRcXlsguIv4J11pOGxzSXoruMJTnr+cNkrv4VnZcwEX22e11F2vezzvumtWCFDPcQzKgQilqhG9QMTId++y+bU0fJn6M2xMPgKBvfYTwjEuoBxf/3PeopN19O4weMjFdl4TGgDVC12Y9g/XQ7M4mH1j8M53X/4868tGS8kaS3/yTGNEN1eIV+9ubS31wKPCDWoox3aR6R0074Gb/bIb4dHxxKiNWtZ3UCKfWjRnIm6IVl9IICdwAMBCrsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efVMsAmcYfOIoDjxkCh92XKLdXXEv5tth7jw7N10LVc=;
 b=Zqcj+ReHNL3pNujL2avlRER2K/ZwIUIQzEH/lssduOkw2RXx3fHVbRkDqebDUEtVUy7VIkBL8owVOB5rwH0ZyzcznT1MITsLsGvXLB02H/UKaRtP3XkSQm+/QJeKVSR511QCCn3rVXm6dhWxP3VC/T3vlJCDze3JjwSn5Ajzp2ZTp0hrY1uZQaH96jtLZe5P8hYIjEGmruJ72EPZV4N3H3XZRhWdRSPnJ5+58lGLHzYneKSbYaUe//dm2Clhtxh7E/IqN0KfHX1PN1QGlcXwHzKFAfsZ9SyKlydJs2lh/Ui62tpWnN17+TPf62Yl3/Qz79abmrocn0ItsEjjBXJobA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB7908.namprd11.prod.outlook.com (2603:10b6:8:ea::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.24; Sat, 10 Feb 2024 06:54:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Sat, 10 Feb 2024
 06:54:50 +0000
Date: Fri, 9 Feb 2024 22:54:48 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>
CC: <Jonathan.Cameron@huawei.com>, <dan.j.williams@intel.com>
Subject: RE: [RFC PATCH 5/5] cxl/core: add poison injection event handler
Message-ID: <65c71db8caace_d2d4294b6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-8-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240209115417.724638-8-ruansy.fnst@fujitsu.com>
X-ClientProxiedBy: MW3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:303:2b::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB7908:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d71f8f4-8aa3-45a9-7c7c-08dc2a052d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aoRMWW5dk9qzeY4oYFAJddcwr7lGmlqJm2CGnpiOffm9tSSm/mua/Nvqi7pz2/l4xYOXcRHHLfNQm3hHDNXnnDBdT1k6B/tODJROR6izLu9Il3OK4A7qweVeOtWL2PFqbBxjfV/hyuLBZ1YxQ3YDixilm/rnblLJR8wSn2nWXR8DjVpCXOvOHr9r1lApmkXd5AzZZ1+0VAtYTLc1hMJJxvjJIfC3oRPevnTm3XiYbsOd+8GqEwSN0lPS2+hMtG3K6AvCVbZeUHMXA0+jB8YrveV87TrxLD8sZdzbilgV/+h9Lj43utH/kJQZRHeXNXNhKdgxzYwzzTvnBu2T3HojrJqluNp3JIcm5QIVgDt+GOhd6QvuNDNAFuDeUM1bm7zcz0lZHBFTpGw0hva7Qux/u2PyWrhZyanDMj3cL0lmSpsAXRhlB8qNpSSjKB8zAHCnCYkGzBJBA2wJzSfQnGNsrWwgEDf4BTO6arAmzFk9BCzaAcG66kcLHPIMEwY5xdR4AUkifzhv7fcAKU/N/p1lmIBdDhOSenneWnwq6uin4b/tkjqKFhmBhZE6IkaRjphn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8107.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(39860400002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(107886003)(9686003)(26005)(83380400001)(41300700001)(66556008)(66946007)(6506007)(6512007)(4326008)(86362001)(478600001)(6486002)(66476007)(8676002)(2906002)(38100700002)(5660300002)(82960400001)(316002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k+HAc9P/9gvgGFnPuxTbvKsiyJoZ2I14MVAdJ6NC4Od5Fmncx/B2yuWUyq7D?=
 =?us-ascii?Q?37eHuJJcA8kLoADo6lm6Q9JRAjGY9LYWY6PF8d4CObYDxtOz60cr+XHE8sty?=
 =?us-ascii?Q?4WrjDk8Ye8VoyLmpK++bJOY7jgeBMUntxrSRQXKCfNlV6aiBdzsTblFXjT+h?=
 =?us-ascii?Q?o967bMWsv9A1Xlu7GcOt6yCQQ1WvA2TUqRMu8XvsWY2LvqaEXoqcgdVUbKbT?=
 =?us-ascii?Q?sX0d8eVqdaNVu6IyOtjqVKbuA1x2kWCMw2k6r33RgD5vRiEKCfWZ+zO7+9p8?=
 =?us-ascii?Q?YNRyThGkrpy8E7IPuyllQpnYlvmKI5sLQNK6iRqLTltCtvmVZM4yR5LFoELM?=
 =?us-ascii?Q?S5OMWuB9ezDJ8ukVbgkjJvPGeb3IfrLo2cVjPP5FJf/n9nceWwR9wRK1bw0z?=
 =?us-ascii?Q?p/88wgeLiwR2lN4i0vJyur3O5bODCWnjzpEcYDgkQQenzAt2zm6VTpcat0wO?=
 =?us-ascii?Q?rTJOZ2XdhpPZ4j0NtM3XDgXEx9vwAc16OVTfawkYl9HmeuvKfEl18hdnrgGn?=
 =?us-ascii?Q?EUdy3xKKFQSufFwmCzbNqq0Xhk3DHQAscXiDuHIu5XZWAsT6Q874OSt79hoU?=
 =?us-ascii?Q?VToAa3TV+CpHhvDfsPBHgRsSR27mYEan59vsLac0DWZrsajqqaABV06jTFvW?=
 =?us-ascii?Q?WdPlA2gpNQdEktsTM68FKZ5u+TtoZyjomLmwgfxGFz5hu0BJ+OH5XW2CAS9t?=
 =?us-ascii?Q?6+FH1iydz0buipS+WCelt9rpAEyJMgMgfCUqtdfQk1u9POpV9DIFE2Qa3Uyj?=
 =?us-ascii?Q?iTcYKL3eMxIbaZBpa/ivECBIl54BRusgIYiPawGTG8Q9GvolDH0U4cZQYPHD?=
 =?us-ascii?Q?Cgso6/BxAxLXBL6waSxq6bTvLZb9rpTGkxa1d3JAcTCk+wuPzh9Fd9rLruMm?=
 =?us-ascii?Q?KFNnJX3dqvI3SpSFdhnGEmcNjLGtAW3cnnbguNTH08+yLLT9gWr1mMEKd7jO?=
 =?us-ascii?Q?rELz8KJvft6oQ9wZaqKmC0NTIe+OBao2idiqG75hiw1eMwkLhkq7c7wyOyur?=
 =?us-ascii?Q?xL1Wb8jpjLLYFHBlPYOdamkCFrxwAqMa3qPs5b6mqpKjr+rYSBqbu+tDNsGR?=
 =?us-ascii?Q?YT0cw+JD39Yjzu6T6Y0115MD7ZeuYaWurTvKBYCTyf12EAugG7038iH82D7W?=
 =?us-ascii?Q?lzwu8puPSXirjCYGIjLA9dQDaA67Cm//tKgMsS1s0pAq1P6xAGJwuIvd9R6c?=
 =?us-ascii?Q?LTRoDTxkIry1bR26DPZ12vcKruSng5MAn7HRUcPqvzCY9Cpbx6gN3HoZE+nf?=
 =?us-ascii?Q?XzSOvkzV490jNFIIC/oU3cIjXE1iZSA1M54StNevNueRcLd/wQqou/WgaFnM?=
 =?us-ascii?Q?9GAOysv0h/rvYw3XG/zjHUr8xY1NtvnpY2ZLBVF/FqWCYbBB5qUYYh5UaKAe?=
 =?us-ascii?Q?N802VhBeSa6bCAzfaD5dr5mV3MG8p/fET4RwTTa3fo7DRyf1NBPpfF9KJOF/?=
 =?us-ascii?Q?GIt7JBa7fbZMvGr76YAUYPsAnvyJw4cZUMge1lADvzn+JhX3etM1Jaz70M0M?=
 =?us-ascii?Q?nE1RKgt2A4/pAhwaEg+jMOGHo79ufv9RNHSHx+7SKXKjbnXoTk4O350ZI33L?=
 =?us-ascii?Q?cCcjKanPHPbwW44Nj9sChSbGXO8U3qfNW/3duvEj9xGIN9BrnlVyrQsxP6Zq?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d71f8f4-8aa3-45a9-7c7c-08dc2a052d5f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 06:54:50.5175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9k3/dNtKw1zZuaBYNfYqwrYCf2hgIsKWRNaBrn6L1tvzl5xXNF0CQgd5ahwg9haE4x4m9AMPLSy3VHPsRqKMjzITNLMg29ybj2+IrX5KV5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7908
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
> Currently driver only trace cxl events, poison injection on cxl memdev
> is silent.  OS needs to be notified then it could handle poison range
> in time.  Per CXL spec, the device error event could be signaled through
> FW-First and OS-First methods.
> 
> So, add poison event handler in OS-First method:
>   - qemu:
>     - CXL device report POISON event to OS by MSI by sending GMER after
>       injecting a poison record

QEMU details do not belong in a kernel changelog. It is ok for an RFC,
but my hope is that this can be tested on hardware after being proven on
QEMU.

>   - CXL driver
>     a. read the POISON event through GMER;   <-- this patch
>     b. get POISON list;
>     c. translate DPA to HPA;
>     d. construct a mce instance, then call mce_log() to queue this mce
>        instance;

It is not clear to me why the kernel should proactively fire machine
check notifications on injection? The changelog needs to make clear why
the kernel should do this, and the consequences of not going it.

For CPU consumed poison the machine check event will already fire. For
background discovery of poison, that should translate to a
memory_failure() notification with teh MF_ACTION_REQUIRED flag cleared.
Userspace, like rasdaemon, can then make a page offline decision.

