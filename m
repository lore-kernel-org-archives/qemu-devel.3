Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0192CCCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 06:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDzRU-0000pY-EI; Wed, 29 Oct 2025 02:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.gao@intel.com>)
 id 1vDzRS-0000og-Qi
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 02:13:54 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.gao@intel.com>)
 id 1vDzRP-0006wp-NO
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 02:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761718432; x=1793254432;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=mSM4Y5Fq0jHGySuo/YaSn4uTdFLQIfHl5lMA96v2WuM=;
 b=FxGxU8YT5DdkFxAPJkvDIKOy+7jbLJ9lJ8iDHXvbqRi10UaLI2lVlqio
 r99l/ZSdr/7U8z1cD6juVSQ0QYuaDHyqbg61A6m7KPxTmez+5HI6WTQk4
 AxgITdfa62PnE/rhPx0K37iZizA+IFtuDFDnJgLT4ce/8zJ96iVSZYsrb
 AV8j71CDhHs7V/i0z9wOM4OhjvIo9PQu/LcSes1xl2lnhvcgNKtEw+jyr
 Wx1yyJcGlq0T1yetfTeqonx3PQZtUBzwwtCtg3NKVGUd/xTba+2kZgxmM
 9NCwmLvi++mR1o9ePRx9AhUtY7Wlyfq06x+IzWlK+Xfv7R6gUlPxVc3Mf g==;
X-CSE-ConnectionGUID: eu0k4L/PRIOI+ddWjQdh2Q==
X-CSE-MsgGUID: VF/22/T7Tsip6VI2QCR4eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="75277222"
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="75277222"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 23:13:48 -0700
X-CSE-ConnectionGUID: ko0QEj7DRaebd1/eCntZmQ==
X-CSE-MsgGUID: eXRxQrsMSIaiefbb1qqHNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="185481011"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 23:13:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 23:13:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 23:13:47 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 23:13:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKJC0g/f9m0lFAdCgrzI1nlm+rAu6C/iadOETvAHa7vGef9SAMBwS6zTfN5nEr3/JEfJ5rBCI/+KJH5pGhwqbqNbRSQCngxrHHEpUxMt8z2x830Aqq/N7DCyiMXMpj2qARZou1ZxxMECXP23DGIzCmT7/WmKbXt6ceI5GWMuC5NPmqrfH+4hkVKVHDtg2QUlGL49Rl9rlbzBri0IR1kRXyBeY0aMlA069iuUtWIBQunWG/8SnPsa8s2fhTwU3kNwLNLghvhR8QF8UuSzAyalKVVBWUwx3wFFzUu6IkWQj72w5ilUhWNHIxYgmvIgCcarGMDFWYcxla1ZTbLVEZqtrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnUxBWWIWL5G+IzQ4rBtMu9HumzoePAFM1bxhwQGUCY=;
 b=zQc2e/kr2zAPFhpIM0l7L9i33Lei+H0KAHwzxejSoUvifaPPSIJi804Vz9K/IrEGj7saFf1fCY3AIS4Uiy3XtMgLJP+b6oip9yGduIc7nqu9ajRN3AM9D2LxXChm27QRkfzHRL94efNdMOuK+OPYuqzXA/zpMQCnX6L5L+/UHJLAl9wTns1hdG39s2xbJv2y5LuRcKSaZN8y393nGPuFk9mgGFwmwbPiQABOIIzNsMSQItdOrnJbKPgSBhXC8lLfo/ZEIFJOXqvrmtcGt/A2ps8pPWgw6V62ta3HkOD1TcgLVk11OFbWehRlPsjYVWSUYlh1dbZqdos6XmbcEZBb1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8660.namprd11.prod.outlook.com (2603:10b6:610:1ce::13)
 by CO1PR11MB5170.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Wed, 29 Oct
 2025 06:13:43 +0000
Received: from CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b]) by CH3PR11MB8660.namprd11.prod.outlook.com
 ([fe80::cfad:add4:daad:fb9b%4]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 06:13:37 +0000
Date: Wed, 29 Oct 2025 14:13:26 +0800
From: Chao Gao <chao.gao@intel.com>
To: Zhao Liu <zhao1.liu@intel.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, "John
 Allen" <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>, Mathias Krause
 <minipli@grsecurity.net>, Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen
 <zide.chen@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>, Xiaoyao Li
 <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v3 16/20] i386/cpu: Mark cet-u & cet-s xstates as
 migratable
Message-ID: <aQGwhpZmA3kp/a3q@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-17-zhao1.liu@intel.com>
 <aP9Y4B1J1W+3Gv/2@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aP9Y4B1J1W+3Gv/2@intel.com>
X-ClientProxiedBy: SG2PR06CA0193.apcprd06.prod.outlook.com (2603:1096:4:1::25)
 To CH3PR11MB8660.namprd11.prod.outlook.com
 (2603:10b6:610:1ce::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8660:EE_|CO1PR11MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: dc00578f-b06e-461a-f053-08de16b24bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ryFMldFzHWywgJWntJ3toeaj3nnYHM+2UVdJgu5VxP3GwwFfQx1g1vXeg6pe?=
 =?us-ascii?Q?iE1kyHpbDVdMM/5LJ/xAkWSjVjcGZcuqu9i0LxnmGAGJLARN6eb3gvFwFlp9?=
 =?us-ascii?Q?DC1Efh7icRymfXpj47XcC+kzvrbA6TaI5IGXHDrIM8xf9JqbI+gDm2lYfJgO?=
 =?us-ascii?Q?7A+rrH8rdg9g9UluZqSgdc7QHhNZYs8PW0yLs4SdvKB4OA8DOeJ0O4Oua3jd?=
 =?us-ascii?Q?1h5olCA4BseXo2y8Kr3UgFjXU50coXXmlUjAX0q3nd7CkswWUn2vXSYIEeG3?=
 =?us-ascii?Q?QR/lFuJeLWrCG7Xfx6S6OtH4quIkeUAq5QPU/ByBflm7AbNuOBH8JKz7ORz3?=
 =?us-ascii?Q?nrIScZdZAoifI0ldIO+SZGIFiTrtjkDGmMWURDV/r4dyBpnJWmvbEzWbT2P3?=
 =?us-ascii?Q?gqQ31dWguNZMMX1O0kBkEZ7DNbAOacWb8SC+g9ZTkanbT3s5c7mBuQItntVu?=
 =?us-ascii?Q?bImltwSlq05XQIS5IVLIbLBE75D3XAXiPx2O9v0zbxbui8epQsahleMQyQNP?=
 =?us-ascii?Q?9BLqVKccJIVnno06sSZeQZ7Z4I1SQLiJhT44YVza+qQ6Nx2+0qxrv2FqXAhz?=
 =?us-ascii?Q?MfjWDo1C6QT+vO8fAbHT2DQW9m73YoqIolIXCY50hcc0IbHu4Z+HyQKq0NGk?=
 =?us-ascii?Q?s8q9Y/i66wCPzFgsLK+GBtEqmjQCN7JK3vjijDtRykShN5OssfkHQfRkFrAd?=
 =?us-ascii?Q?b50Fw9QeAF/0q6nOR2kxKIlI8RG3W8KZn1s395CTJiE5pKDj86Xnh5YxnEA4?=
 =?us-ascii?Q?fu9fVXS9WJZWize8M800KQ1kNrQFbdgN5APg1iQlAuPA93Lfapxm216qZ3f4?=
 =?us-ascii?Q?6sZdaS31Dd1NFPyLqm9F7VTmDif7pLBGpFw/8rE5nXWhUpPW4pj+LnuJfPoJ?=
 =?us-ascii?Q?dwpmKNFQ8bKjwUnzD7a72qFNzDDpbELSqbvJEj6nv86jWCahVOMVMc36XJ05?=
 =?us-ascii?Q?XGduCDw1S9dTE5Ak1drmXqMGWrWjd9GJPl8AwtN2Z/wSN3tPhOfkIJll6IG/?=
 =?us-ascii?Q?bc4rQpi79YW0GOVHaQUo0Az9anEtFRI+sv6lc7CCLTyMSaUDqwfhcCFGtiBt?=
 =?us-ascii?Q?K7IPrXC80ypU4XPX1xGzHjwIPxqBWByxdx8pkxwAqM475UdG+y/wFTDn0Slh?=
 =?us-ascii?Q?GR3k426E1m9QX37B7I8rD24ArEN99JQce1OM/tvUXqTxyEZegyxHXpmga+TY?=
 =?us-ascii?Q?0I0Cmg37wDvVJqi2My4gomSdfbxUrpsgHpTRp9JXB45qpueCFcYxSg10SLay?=
 =?us-ascii?Q?ufUSdj+gHPYts/9z8Vu8/vDL7Ksz9ZP1ZNfQTcfrk2U9VztyvIoPqgF/yTPo?=
 =?us-ascii?Q?b/BIjKNm6QyZvqJOmvWoGJxwAAwFIV+Q7tELN9dVefF0RxISsKtJlM5arkpR?=
 =?us-ascii?Q?XBXSd1IkPmr9dN89pXNYgPY85ycje8gphsqR5SwnoSGq4ruuA95SoGELeWmy?=
 =?us-ascii?Q?EhcdU2pFW5CesM3sqkUa1CWgFf0TkoFe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB8660.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gV8O5WUuhzDKGo+Szwm2uZt/cbxjBBYvOGUiKHMl7iAfjT84qWWfvIUb0Wyk?=
 =?us-ascii?Q?EiTKUMTWzoeyHcNOQt/PBsy7/5zdy9N3VLeYC8e9vY4dZhv1XAgKOa/YtCxG?=
 =?us-ascii?Q?4I199bthDuzbMuqiNgj3hipiyKVDng7qUXs177DFUyrxR12m+tcaUvJpy/wU?=
 =?us-ascii?Q?3JTRKmgmnJqYuiaHhFkVeAGNVsculIr+lVYjCRLeHQHQlW5u+g/I4X8mMu0H?=
 =?us-ascii?Q?au/LYIRD/kC+G/LS/x3064+0P9nN/TpvubAkWM8PRcX/zPopK6dscBnXdldC?=
 =?us-ascii?Q?1XToNYTIzNcjas0SaDUUVYy8Is9JL9Wq0BN+nPeZqjdUWTS4RvVC4kXHOB8N?=
 =?us-ascii?Q?rCp0GHzdgpM88/h/xsD7ua32irRDySdzZ9h9/jeOEEU6YNgNEd9VprKXeSfI?=
 =?us-ascii?Q?XVdg6BG730lSVI2TqHQI3HjKwWG0RPK4v4+E+zXLB6e0xuUdEQBvd6pmr7Sl?=
 =?us-ascii?Q?vS5je8TAdSOuO2vkjzt/H+CatlMTCX27US+/lH3a7TIMDe3Hcg6ItY+bEr60?=
 =?us-ascii?Q?5nP04tbNnnA86z9SABbw9lolfhKpVax8qO5mdT/YfrU2hhXYSF8zBxh/iaAn?=
 =?us-ascii?Q?CH6HYIl7xCwYuDEEGZx6Nu4OFqIpJkgueSr6/HmpkIYMon+qwkQ6TBvTPqXP?=
 =?us-ascii?Q?3Nm0Pt+DKVDQAH+U4FdpgDSSnGHVvFK7zcsjYGmOn7v8gKwaCnXLqQHBaumZ?=
 =?us-ascii?Q?CfJ5BSKfkoPRmR4gK/0ZQYvYaYAIBwjsPclQvujfKz6jrH+h7caRDHk4ik/z?=
 =?us-ascii?Q?024rB1t9QirwohNBv73rdGnvcaUS4Gh1eMRYPurilbeukIX6yLxgSIQdey6C?=
 =?us-ascii?Q?CHmxkh/Iwsp3gLJAN6b7Aj7G+prWqMO8RekWBO4llcb/DMBRAbRSXfPrm0hS?=
 =?us-ascii?Q?5KPvkQ8w0xow8mOwQU1Xwv0aq3laYZAkwVcjkhEwkZqvkbkjFm51ujcg00Ak?=
 =?us-ascii?Q?LOwSbhRmwFwh6uopW6EFYPO081F0LBN3qvtccWpp+q1Egc/mYYjmN7E/rL4o?=
 =?us-ascii?Q?+VWFEbThvOOiQccHrL+c+oAPA1VJ825WvT7Uj2IpkdIDH3Bqmtk8ZSYaM4vx?=
 =?us-ascii?Q?iP4XxJYf5nN+05lDEy/21mfD56ffVxXOo7dn5cBOO6QVSNGBl5z0qAM/hRhu?=
 =?us-ascii?Q?XNNCJN04hxaKRym7v5pih9COLyEe1dPBa9fF3WhIlh8h9XpYpmdSJ8QSlnym?=
 =?us-ascii?Q?xT+BzVD5rJ55S4o25cAgjj0s8BCL93xfp+EokiozHIJWcK9uFEMAInSNNhu9?=
 =?us-ascii?Q?U8iXwFWg9PfFaVSQAVPLCd0CuITw0Ho50+fp42O78n3mwvNbCQwr5CMF0V3z?=
 =?us-ascii?Q?+lcBy5Wuw+4RjN9mnXXrKFlfqJa6H+MBHjIc/t8mMZC/+DpNgMKN0FVJJd1p?=
 =?us-ascii?Q?cFUcB4a2roSodZ9q0v/E/xOZPzIPJsnPSHi3v0O5edMeWLhm05Or8vfA/J+g?=
 =?us-ascii?Q?Fnsp8Z/nETeGhai+eGjgL5hNuwNkI2eZqQUaF0f41nuMoSXqvChixXq+2Pch?=
 =?us-ascii?Q?psciriTgC6FoX37xNTS0hvFo/3r65SFUeaiEVAxH40x9nnhKWVQcN/bkZ7e/?=
 =?us-ascii?Q?Dg3V6HggmOSVK6rceU1dVHSORoLqDfnuOcz9bsjY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dc00578f-b06e-461a-f053-08de16b24bfb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 06:13:37.1141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3t4XJXK3ppHI8+85TSXZFyuE5ru+UzUjqTSL2EUakOiBgo40p2UBfA6MNOdXt1ZTtdghUaTn0ZJEzDyjs6GBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5170
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=chao.gao@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Oct 27, 2025 at 07:34:56PM +0800, Zhao Liu wrote:
>On Fri, Oct 24, 2025 at 02:56:28PM +0800, Zhao Liu wrote:
>> Date: Fri, 24 Oct 2025 14:56:28 +0800
>> From: Zhao Liu <zhao1.liu@intel.com>
>> Subject: [PATCH v3 16/20] i386/cpu: Mark cet-u & cet-s xstates as migratable
>> X-Mailer: git-send-email 2.34.1
>> 
>> Cet-u and cet-s are supervisor xstates. Their states are saved/loaded by
>> saving/loading related CET MSRs. And there's a vmsd "vmstate_cet" to
>> migrate these MSRs.
>> 
>> Thus, it's safe to mark them as migratable.
>> 
>> Tested-by: Farrah Chen <farrah.chen@intel.com>
>> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
>> ---
>>  target/i386/cpu.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 0bb65e8c5321..c08066a338a3 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -1522,7 +1522,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>>          .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
>>              XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
>>              XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
>> -            XSTATE_PKRU_MASK | XSTATE_ARCH_LBR_MASK | XSTATE_XTILE_CFG_MASK |
>> +            XSTATE_PKRU_MASK | XSTATE_CET_U_MASK | XSTATE_CET_S_MASK |
>
>CET-U & CET-S should be added to FEAT_XSAVE_XSS_LO.

Yes. XSTATE_ARCH_LBR_MASK as well.

