Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBCECD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 11:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNU4W-0005PP-Ce; Thu, 14 May 2026 07:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNU4U-0005MQ-Ii
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:17:42 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNU4R-00087B-6N
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778757459; x=1810293459;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=l4iPvmjER6+gabP7JbfJ6dLpaMiuv9FH99K3+RgC4bA=;
 b=jAH1It8GtrFQ4AzzIVH6soHerQPMi3mHRvIWA458PuOf++ENqD62Uyb6
 +8GMjfPXCmqDi4+GGeaW2gzbFfrImdmOHx0fvUVkyhKHD2lKiI9hIEHVn
 QnvIjuo9cBGb9rFLPw6fyjMI+44YXwfUA9PyZ/CjRnS8RjJe2/VHDrEo8
 z1LtNQJVlJnnRFYxz3rN/7BTL9Ea1REsbMffewVxWLlfbMT4MLL6fSIW0
 4wIZjyisQW14xSjgWGXWH1Nqk/ipukljVgflj3rquZwSCtsV9pukEXqUp
 ueFK+vLXDIE2UH6JeWNT3Mo6Z//kq7VuAlnIdqDXUD+dF+jhe+Hfd/APv w==;
X-CSE-ConnectionGUID: zt76ebbgRReJZx6MCHDITQ==
X-CSE-MsgGUID: GYmeRvQhQMmwoKMhIu3X6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90006681"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="90006681"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:17:37 -0700
X-CSE-ConnectionGUID: LYJ8Twl+TrOJ3qDcXQ4BgQ==
X-CSE-MsgGUID: hWJ8JYt9T92jnwcVN+KAKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="237495337"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:17:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:17:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 04:17:36 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:17:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hboWn16leR4WUU7FlfgM/hwgajkeQsHFw08pZT98ZxAj8d77YcxaZ5/3uqxcDROFFUbK+bSfqWGPyd3y06w+4OtTiUD3FhR+mHw8R8qq7+Srisqv11sZcrkasWuFy74/tUGwbaHP4Ffk+YeJhjy2jq8rPXisak6MfIV9JREkOhJ/pd1evxc9kzgcV0ZIoaapqx4piNmchP2ndpf2cvD91vbLQdCN8ef8NvuBaMfUerR4rI4tCdaFS+wC1JXubxPdDt7XdLF9La64KXeuDJSsF4QqvxndPUG1jbewVW7viaCVZp/u1THTZ8UIiOxPutQ3rGcnLunCJ/q4EAfigfI7kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFAXV5ti1dgoJ47ZmH5QdZlEm1lzGxbPW/DiguI4pv0=;
 b=R/0qBx5e1E3ufHLSGQ1BoNb1F3JQP37qzuYeTdtqX8/6npQraPAW0ythq07oHH53KUJEy00CAZqgyQP0cxbXXihESakvFXbVPqOe0m2aINNzGa9rA8j/s1D2ALnTCWxCd3TPyFkp1rj6u4tGqapqXVVYwvuPxNZpolSwGMKjcQAx0GdGsBUztH4WzxhS7s92jqeV51t3/iLmAukxmoMvoiczkquZIP1uM7vJp8nrdIjPZcUfKIDfb8RqzRLnbwHwvRaqsZP0t3b5YLI2TWpPL63RXdpsa8fEBB/uBnfThZGTvDvnWooVRSDtQSFRRRXNiPP0S932SJuz/yeL4akTvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by EAYPR11MB9588.namprd11.prod.outlook.com (2603:10b6:303:2c2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 11:17:33 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 11:17:33 +0000
Message-ID: <33d2536a-6401-4724-a632-5cf5003f2143@intel.com>
Date: Thu, 14 May 2026 19:25:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/15] intel_iommu_accel: Add pasid bits size check
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-15-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260509040819.1044702-15-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0030.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::15) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|EAYPR11MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: 39284e2d-d26b-4d8e-9e36-08deb1aa64dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|1800799024|366016|7416014|376014|11063799003|4143699003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DjsRzs7VWnp4Q8dX1PVTuWeNSpXyKH74ymGmhfVOQnu93IKRfFXKHq6XKOlYYhG8a+wtej6xWxHaCe2qbZLVt3/ChjykZn/EagR0LAxOsUdJBMAIy/XcmyOM6l6rTUXR506iqkM3V4r97a3O61nARTdb6w+bv79tXaIf7CUKlZ1RzAMvvCTDbB0KyjQO0ph49KUe/37q/qqjqeejB56qRdp2ULFY86jjt98859lZt0fYyjktHsQ9HO/yjlPKoofzS6MRwc+qGaoNe47gXR8QSsiEcTlVoxtDj2DGyeFQ+TOyn8JtN8NGMYcm4qfP6Ncpi/eVmiD8trlQe4zDgAS6oezezkncTbdJTnMcrkk+4mFCCtOyHWatStyajBWpnUZfiFAGU2saPwYR+kDEfQjvMCwopR15Gc6dPtB2xyJnmMDfkGaICh4cOLUobeaQtMI7yTFOGxW4BIWiIpAnud2lgmkrWAX+PY0jB92az/wW7zQzmJfGvHUS0C7528+6Cpwr7PQelANRm29Y1eSdFkCzGj+iPPtXX4x/QqLVZGvAWo3ATRQjYtJyjVbPhvCl+PjoZHhumCOmf+lEElcakDo89xSI0vs0j8t5CaNyfBFU7AxhfcwOU/QQJ1lUd6/OX1SdzVWdHZZp9SUcQU1HlT6N/eX/R2snYyklld/uHnyWXWj6rptuQZXvjdXC2P4pHvqs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(1800799024)(366016)(7416014)(376014)(11063799003)(4143699003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmJBMW91a1A5bEdmUy85bU4wVWVjS1dkWUQxNGlZL0Vidlh2WjRTK1RpeU5V?=
 =?utf-8?B?NHFqMlpuRzFjTmoveGFpQjdTMWhqemFNOFloSjhRQVp2SHB3aFJuRmN3MzZQ?=
 =?utf-8?B?em9IalJjZGMvNHBoRzJkaHZrb3gzYjFJaVRrbzhWNXJ0VmJEVVJKSDE0eU13?=
 =?utf-8?B?Z1lvcEpaL3E5TDNkQmVZWHB2Nzk2N1pxSXFWdXE1M0NJb1Y1YTJXb0JHZXpx?=
 =?utf-8?B?OWdYRnBzVXVqcVp1V0h5eFpLb01QNUh1aFlha1UyZjZjMmZRRWRZUUVldkk5?=
 =?utf-8?B?eU11ZUw0TDFUWXd0NXhDa3lPMHA3amFNTk5vQnhEWWlON01lV3RNSmU4V29U?=
 =?utf-8?B?SlBidW82aWZPd3RlS1REQ0QzSUJ1cWt6MjA5MllrbnRRblQxOEFmSlAwLy9q?=
 =?utf-8?B?M0c2Y3ZoUWpUK3ZVUDRXTXluZ0lHVjdGOC9nUnhTYXdqTXQwczgxeGIyK0VO?=
 =?utf-8?B?bGZncmV0YmtnT1ZWb2R1eS92OHJLaHRlZDBYbjVpOElHMitheUVkVERoZ3h3?=
 =?utf-8?B?WUI0WUNwbklKb2w5Y1VkRG9wR3llenJINGlHQkovTFRORVo0YmxtdU1zSHVh?=
 =?utf-8?B?SElHcWRidkdnYnBIMDE1bDIrZ1VvaVFYZGdYU2JocFowMEw0NkE0R3VzZWlT?=
 =?utf-8?B?RUdPTU5YWVYxSnQ5ZjVpMEptQ2VDQjEvSldQTTNlWG1GbEhJMXFoeDVncmh6?=
 =?utf-8?B?SGtBSEpCaUZiTEhHWUpKbGhpeisreVhCVnE4QVJXb0ZRc2IrSWhUKzFwRnBq?=
 =?utf-8?B?WEZQMCthY2tUOVZDbjJZRHljWjdydHZ0d2JGREFab1p1SDNvcEhVWTlzWjg0?=
 =?utf-8?B?NmtrMjlPaXhqL2hTVDg3aFlpWlNXcysvVUx1MTArWUc1VXdEOXAwQVl4UlE5?=
 =?utf-8?B?NU5SeXUyT2h3RUxaemMwZlhyY3RXZy9KYTNEK0hUQmlYRzFBU1luQk9FNlZB?=
 =?utf-8?B?OEF0bUp2Z211c3J4TmlFVkdUS3RyQmZvMzhuR1g0K1Fsdi8wYkkwblkwOEZB?=
 =?utf-8?B?NEN2QlQ2ZXo5R3lIUWErUVd5YmxnTXlCbzc1ZG1sL0xidUNtWm1FVWo4RW5r?=
 =?utf-8?B?V1RDcTNVSEE2Q1p0Z2JxcytsMm9YbEsxTUFFeWRDek9FRVkyekZlVUtNZUc3?=
 =?utf-8?B?dWhRd21XbXE0akpnTUtNY0ZhMG56UW1UdDFpOHVQcW1jRi9QcVd5YmhJVmJH?=
 =?utf-8?B?NWNvbmpZM0xFS3dxMWVOS0E5MVNxQ0E0ajhaTWw3Mk8weVR2dmNXNEQrUUFD?=
 =?utf-8?B?WVJDWW1pRFdWNFVwK3BDdzFIVmlBZFR2UHV3Q0ovWlFRd0pKeE1RaXVyNDZ2?=
 =?utf-8?B?dXhxV1JaZmdtdHFCdGxLWXdpdTJzdnJnRjlycC9vV01SQytUNWtIU2VoSndK?=
 =?utf-8?B?MjBUNEpReWthVzcxOHp4c1ZqMENESmNLWVBWTnFuS1g1bVVpQklhQ2F4RCt0?=
 =?utf-8?B?MmtsM0J5SjNRZTZPaVNwN3hrOGhlYkFrNnNVYTFFY0pXUWVWOEpMekV6d2x0?=
 =?utf-8?B?cC8zODBtdnZ5RTNLVzRyMUROOFQ3b3k5dUFxVVp3bm1CQ0tUeU91SWE0bGly?=
 =?utf-8?B?bDVBVVVyRDl3N2xuajUwZTdJeit0akIvL3ZsSDc4ZUtHa3JFejFiYlJhMk90?=
 =?utf-8?B?NFZxYTF2cWRxQ1FPL1FNbWNYVkhqUXc4UVg1OURvVXY1RDZWYlJNcWptWDFO?=
 =?utf-8?B?UTlVL0VmWGpuYmZ4dUNQNnFDcXVVUVF4SVF3WHJDcEZsTE1ReTZWRitTV1Bw?=
 =?utf-8?B?UUFVWVFVZXRTZmx3L1o0SWdENEs5Sjl1M0pBaE1aOFRLelhwYWJVa2ZvMm56?=
 =?utf-8?B?UWdvNzliTUgzNnl0cy8vUnNid1NPSW1MUFFJemhHYTFJdDREQUI3UU9ld2Fn?=
 =?utf-8?B?TU5lSkFSdXQ1aTFqakVBS0ZOK0pTOWk3bXJkajV5cHVVWE5HRDlpdHRUc3lw?=
 =?utf-8?B?WnBuMDVUUXdIK0htK3krOUh2a3ByaDhKT3R1dXR4S2pjR1pIdGYwRndCTUMv?=
 =?utf-8?B?WnlTWjJ5VzM5SEpPdHVYN3pCYlRRazRpOTZPWTF5bFFoSVhBUTJqQm13OW9J?=
 =?utf-8?B?VkpPVGxRRkhSTFlUMERJb0NXNllzMkU0aUlXbVNQallEcTZvRzRYaXpiWW5S?=
 =?utf-8?B?bmZ4MVlFc3hJMG1wVFM3V2k1YlhRTXZyV2dGbUlQZk1ZRGVFZCtINGNod3dG?=
 =?utf-8?B?ZlV4cGIzVTFRWVgrR0R5cEtPQnQzeHRVN0RzT25UcEEzVTRSelJmYUhOd3o3?=
 =?utf-8?B?UElIeFpNM2hLYlRRUFpGczJKUk1MZjFJYlJFYjA2RGZCazBUako4elRMeFpU?=
 =?utf-8?B?ak1UTlExM1d6bjY2RTZjRi9mMXV6aWFMZnlmQzEwM2FoWkUwdS93Zz09?=
X-Exchange-RoutingPolicyChecked: BnoCgS2BFVyCNawMq6zv+ETZCtFo6zDy3duLLdi5BDV4FxzbCo336Ggk74SOrb2dmP4jysqakHKddp1NC6JCUTY25Rippf3745pouQV2yE/vqDC2Fjg7rSTsEjaS9Yw63wj6nKCMLxm1hQaIAYZ27BKnhe36l+7LBKDdGVkGoyL0TSVxfXFRQrLsf8exgxxfrjIvfwvhG+EPBOoVpFuOYs+GgObWfKMMeTiadwz4PIrQ8wZBxkjnxlClD0BSBl+uz8ciFP55TyPVepEmdm/p/Uc976aqR02y3+lp1aWb864wA8ccGymhFbZI2VYawObQF8FmmCKM4kNozEjnsoRN2Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 39284e2d-d26b-4d8e-9e36-08deb1aa64dd
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 11:17:33.1094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dp9myH5TFX7P5rRPj8imTMOLiI4HvT3LjoT0DPtSaVNP7vZHdWr2nu66BYvadkqiIv1Mz6Ap75LK2zZypbDEhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9588
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/9/26 12:08, Zhenzhong Duan wrote:
> If pasid bits size is bigger than host side, host could fail to emulate
> all bindings in guest. Add a check to fail device plug early.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> ---
>   hw/i386/intel_iommu_internal.h | 1 +
>   hw/i386/intel_iommu_accel.c    | 8 ++++++++
>   2 files changed, 9 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 2c716c5297..519af3fa90 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -196,6 +196,7 @@
>   #define VTD_ECAP_SRS                (1ULL << 31)
>   #define VTD_ECAP_NWFS               (1ULL << 33)
>   #define VTD_ECAP_SET_PSS(x, v)      ((x)->ecap = deposit64((x)->ecap, 35, 5, v))
> +#define VTD_ECAP_GET_PSS(ecap)      extract64(ecap, 35, 5)
>   #define VTD_ECAP_PASID              (1ULL << 40)
>   #define VTD_ECAP_PDS                (1ULL << 42)
>   #define VTD_ECAP_SMTS               (1ULL << 43)
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index 4ddf66262c..a0dd6b0ee0 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>       HostIOMMUDevice *hiod = vtd_hiod->hiod;
>       struct HostIOMMUDeviceCaps *caps = &hiod->caps;
>       struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
> +    uint8_t hpasid = VTD_ECAP_GET_PSS(vtd->ecap_reg) + 1;
>       PCIBus *bus = vtd_hiod->bus;
>       PCIDevice *pdev = bus->devices[vtd_hiod->devfn];
>   
> @@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>           return false;
>       }
>   
> +    /* Only do the check when host device support PASIDs */
> +    if (caps->max_pasid_log2 && s->pasid > hpasid) {

the second comparison looks strange. hpasid is derived from ecap_reg, 
while ecap_reg is from s->pasid... is there any place that changes
the pss filed of ecap_reg afterward? I think this check should be
against caps->max_pasid_log2 as this is the value from hardware. right?

> +        error_setg(errp, "PASID bits size %d > host IOMMU PASID bits size %d",
> +                   s->pasid, hpasid);
> +        return false;
> +    }
> +
>       if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
>           error_setg(errp, "Host device downstream to a PCI bridge is "
>                      "unsupported when x-flts=on");


