Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE77BCD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 11:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNU6x-0008GP-IP; Thu, 14 May 2026 07:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNU6v-0008Eb-Qd
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:20:14 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wNU6t-0001AC-T9
 for qemu-devel@nongnu.org; Thu, 14 May 2026 07:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778757612; x=1810293612;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=e+4D2KJcDHYHuVXu5ibEfOpMKyIgOxhgXjkH1hr/BSk=;
 b=A5Dib2uvOIOSZPRXTOCVPzqeEujoUY6aoZCNPjUx4p8JHHMws1HVdssT
 DeAVX1wQ7AojJFPOCoTkwvDmz/Tx47CrLtHXCI8X8/APU+GsA3Rn/YG2a
 8++/ptzQ1BZBD4nFAKmKyxLXxeri/FfwIQwFBi2E75QLFVJCAzaTyUA3B
 5Jk0YexkpbQToAWClLitdLHgn0AFpz+0w/dfZw/IRoT3VInMrEF/V/rZ/
 gyriNTz8QETLg6mHcIb5AuE1HINwj/9A21fCgOEAf/no9a3O0cbxFM8nK
 V5qYeMzFaESEO3r3cJhzT4Iao1xcQhH24msoqvCY8Z0bavKhKMimZi59T w==;
X-CSE-ConnectionGUID: w9faxP1VQ/SHQJyz23TEPg==
X-CSE-MsgGUID: lmI5pW4STsaNAW59B/oEMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90391689"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="90391689"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:20:09 -0700
X-CSE-ConnectionGUID: kfscChqNShy/ejgUYCkNtQ==
X-CSE-MsgGUID: h+LCh1xsSk6L6ip1lw31Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="237378515"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 04:20:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:20:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 14 May 2026 04:20:08 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 14 May 2026 04:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4tqs4faaXFkKwDgTKvr58FFhGsLlO4ioe3KghfCpfdkwpjxFa1/u/XHCuBT32KTHuoQeGttPJ0DJpTBWkekYHZcUWaIzgrjiWqAcRSfGxNqJ7JvbXmrT9C64SoQW78VPLX8M4yWpquGA3opDyL+jhkgakH+xV8nM595k22ezKOU/HfGKHs7GpuN3QeGZpINKYGlpp7NotfzfIq7G3D4ucYw84dxZq/5EAHXK0TVtL6gMaV/wlP55cd6zhCGqhtoKzdACC5ms25rOeXgQpd+AnRZT6xURzl4vdWKcI3l4SXROHpz4FCJN8szNvY3H2EHWActe61AZAJjDp6PfLL0Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TEy2ytj8JAnSSSe6+dIi4kWtTMgTvPjCSMaBrykXAw=;
 b=PrF+W3lsFfW68KVP57CKxvp6s/cfyHSgiPVnQPwxWcgB1g838rFkeTvNAqJJ8x4GB/628qBT8V8OznQfxxuet8dV+DW5VvfNTBpQ39pMIAT59glvMEN715VEL0OgYakL0BnC0FL22rXt8/DSdPsPlErujsiDAcexsCVyUm/EhpZ+eKkSzl4YbxMzWJfoV2WjzeGvRbSyWGawAUScjyx2jlml/1gQxVUBCAcwk1+28I3yzWgi2hL7uSA0CaoM3bztIajearlINMAL4xDr8805lE9QZxbnWrZYCKlyidLBVD/qfjxFTBliBKI8HXuzUYre48+YycqzabW3se6ht4EF6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by CY8PR11MB7948.namprd11.prod.outlook.com (2603:10b6:930:7f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 11:20:04 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 11:20:04 +0000
Message-ID: <f970879e-ab9e-4565-8270-41f00ff28362@intel.com>
Date: Thu, 14 May 2026 19:28:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/15] intel_iommu_accel: Bypass PASID entry addition
 for just deleted entry
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-12-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260509040819.1044702-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0207.apcprd04.prod.outlook.com
 (2603:1096:4:187::9) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|CY8PR11MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: f970e7de-28d4-4ea1-39af-08deb1aabf08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|42112799006|11063799003|4143699003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: qlAttv5ZtZYM+Gt6elEODk5Ta3n37ke0evCZKfMVdEdkqicQmdDRmZQMW5N91QN27vZF+Glkos/6MUHKByPXRVp24iC6pIMTnqUjusKEqJ7zMROUuEUaAnYgd6qHxdimFT+d4VcjIcvEudgmVHTb6jpcXTw1mzk7TMTiX0Q0h+CsX2NI+qg2waxYUzjDFmOcfycvU2O7BzIAAQzmMxROe0EmzuzBX49Q6HRIiGIlhBf1aq7juSAfJ4oMWHbXwHCFK+dDovZXusqY/WDc6ZuxUASHz1wPbwr2HxVdn/BFjUEpAouRVJkpXWDwZf83y7ILE54+5sFIaOYeP7TwB3Myzwx3UPqeZe/KEYK6b9QxUN2lv4iWw3+dgF/V8NKLwQnguY6y+z4do5tpW/qHT1/SlSwIPgRLtv0QNSVjvtfvvIgRInmbJ3ib6BmWnVcCjeTsKQqfkX8mfMsWkcQb85VAt0lUrBQIqpqZc7MRb77yDYDiCsy14yit4jsOKOVdgMNjJFfW3cDB47UvDSk+2khFvRaY3f3KuqlfdmTLgEWny7HuxHi2Hr95e/et2T8xdzR61g35wsyAYocHj0tZXwLrmSpZqzhfLMTb7BdUekmkdGV1ui8YtYM8oVWm2B1KT+qnuWtktW/aKCyJkBrV0VQo5ow4XorpLAz5Y00eeejFcs1fxw1MmDw22czxQ6Hc8WFf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(42112799006)(11063799003)(4143699003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2JQVVpuME13clRmdUdHQldmTjhLQWtpMG5jNmFzd0xWdWhRcFFBajNrd21T?=
 =?utf-8?B?MnpsZS92QjVhZTRQVlU2NTBENktaVk1FT3pnelcvWDVVeDR4VzNJcDhvK0U3?=
 =?utf-8?B?RFA5MzdLcUVuZS9McGhOalc4aEl3ajBxcUMveUo4UHlkYzlXbmdsMmM5d2Y2?=
 =?utf-8?B?azRKVGNleHpFcDlGU3JQakM5RHlZYzVMMkUzaHJqM3V5eEI4UW9lelJJZ3RU?=
 =?utf-8?B?U3VBNlA3d2d4MmdnZ1lWY09xaTNTOEJkZDU1aXRHY3ZBSktTekM5L0svYm5z?=
 =?utf-8?B?MFlJZ1BweG5TMHdDMGhIUllWK0JKTHEvdm9SRk5LcXZ0b2RMdVdIZCsxMm5M?=
 =?utf-8?B?QTlCa3NzeHk5dEVHSjNraHpjcldtQXRvcW1hckpNbisvdUc5RjV2M2Mwb1ha?=
 =?utf-8?B?d1g2U0ZkTVgyREVPZGxuNWhUUC80SXhjdFV5azJsbmlENnVWZHhQOVRqRFdp?=
 =?utf-8?B?QzdTSm04NExsNk1KTkNyb0xlZldoLzhndXd1RlQwd1VQd1QvWjc0UUQ1ME5X?=
 =?utf-8?B?ekF5UW1qK0tuL0R2ZHVMMmtzSXM4ZUthNWIveld0RGlFRzlXVWk2UnJVQ2Fs?=
 =?utf-8?B?RjhiRjBUaDQ4RUFINTRDdzU4Yk1Lb09uUHRSUjJCdXVoOGd4cW5iZ0NvNytO?=
 =?utf-8?B?bXZSQm1rSWFIcG51eVZmakNBR2h2bXYyazJIRGkrNll4b2RMaThpR0l5OFBJ?=
 =?utf-8?B?Qi9RSjViR2Q4UnBuVm1raVdYcmZPcDFHeUQ5azllbGM0SDVNR2xOcHBmekZy?=
 =?utf-8?B?SFlJVS90VnltdkhMU0MwTUpyL3pYNzhNSG92dFh5NGEvcUFoeGNsWVI4SGdG?=
 =?utf-8?B?VVorTEcrRmpEc1laVVd6Y3RnbHJGTEhWTXdYT1IxV2k5c3owYXR6eW80aEp6?=
 =?utf-8?B?WmV1ZGFrTkFtRDRNREdwbjFkL1FzTlZyWU4vZmNCMjcweFlwUG91bFk1blZN?=
 =?utf-8?B?MlhJNHdabHoyeGszeVE2d21XeE1VVjFxQlhXb0Jpaks2OE90MzBIV1hONW85?=
 =?utf-8?B?SURhWHhGZ0tVT0N0Vms2MlVnaFgxUXJwcExaeElWU3Q1ZXVHWmtlSEs5cjQ1?=
 =?utf-8?B?SHBXWHE3a1p3d1Z3cDVBTUVqaXB5UGxGM2ZVL0lIdUE3V21sWTRMSzFaNWph?=
 =?utf-8?B?WFpOV1RXTElHZUoxc25sNG82MTJDOWVwUjhRVkdBbEhzRURoUGxHaUV3WXBn?=
 =?utf-8?B?OGJqT0ZqZURGN2pad2hHQm1SNEF2OGUxZGN6d2x5eHBmNEFndXZWdERuMGFs?=
 =?utf-8?B?bkNObStjS2F4Q1Zpb3FHTGFubHo4aVNMR2VxQ2Q1dVdzM0VjQnNNenkySHdn?=
 =?utf-8?B?bkhPREN6SFJCVzNlTVVISHNEOTdDSlA0c3AzTGVMZXpPZFF2VWVUMm5lV0R0?=
 =?utf-8?B?MlZRaFFCMloxTVlXdGFQK3RTNEJXV2pBVmxhZHhISjJFYm93ZUc4eUxsQkV5?=
 =?utf-8?B?QkRydEtKVU9remhyODlBWnZrcVMrR1BoVHd6TVFQVVFVOE5oc0xNYStTeW9W?=
 =?utf-8?B?eXJvdnVGbENDY1dUd3I1bVYxRHZnUEFwZmdxbTJ6cGpoYzNTMUpKRGJFd3NL?=
 =?utf-8?B?V3VKc0ZhdmhtWE9iMHZtSG1peEdVNXh5QlRIWkw1V2swTU1ydEZHS1A0ZWhC?=
 =?utf-8?B?Tk5GUFg3b2ZjUHN6NXRSYlJsWTZHVnl2TFdZUHhEQ3g4c0YxR0ZBT3ZNVHpH?=
 =?utf-8?B?dlUyblRPc0tJd0Q5andONzVEaUdWZWhXK051WGFaYm14MTdXNWZaS0NvZFM2?=
 =?utf-8?B?aGVuYkgxRUJMWlBTTVlaSmdKQmVIVnE2dG9tTGdyRE9BMkN2RTIwU1RhR1VX?=
 =?utf-8?B?cldFU0dQMVVOMnNyNWpnS1I3TnY3eEdTNFhCTDlJOE5NdlY4OXBVaklpVGht?=
 =?utf-8?B?azMyemVKMEJHSElRWHFlYzBkM1lhMXRnOTFIU1pEUGJ5Z1k0MlhYNW8wWTBr?=
 =?utf-8?B?bnRDdmR0WmNvYnBxMlE0Z0Y5bC9Ib21MeXd2TW5SY2ljNitrK0o5clkyZnRh?=
 =?utf-8?B?S1NRZkxISGlhQXF5eVd2Qzd6eld0UkVQcHdFenZXdGlHZ2I3cGJTRlhqSUNG?=
 =?utf-8?B?NHYwa0kxYzZnd1V5TVJjc01QU3JLUWkzZWsxcjRqTzFMRVIrS3N2Mi81QzEx?=
 =?utf-8?B?cjZRSnBOak5hSStDWXVHdjNVTkxHeUJUOVh1OVFvTzZDSU9ZS0RsY1BLblY3?=
 =?utf-8?B?dnlmZ2ttSk8veUJPbzlTOGdWRHpJQWg3TnJVd05KMklCbU5Ja2hmNVA0am9S?=
 =?utf-8?B?V3lFQWVQTklNYVJGWFgyNGJHYUxwZUMrQjBBRXhWaHA0c1dMMFRMMUtyQUFB?=
 =?utf-8?B?Ym44WXJGaGNuK2tEem4ydlpWdmg4bW1PUUlrQmpxdkk2eFF2dlRiQT09?=
X-Exchange-RoutingPolicyChecked: tHfHsn5r/MSjjUM092zoUxAhAS89yraMOgzidggb07LaeQNXZ7+41k/KCbQ5jKXrfVAsTbxFEOuot78/cFa3a882SVMWdtL/bflsB/klI9pDrpMzKUHy2RsMhMTXMiuaf0vOKIDd5OwM1A3OSb2xmDW8G5LFtIct/XpLi/fJd+M/hWBkrCLPczOFet8i8ow84Szuwv6qpJFwaNsKckwvaQOUMAr+Xze/VB95Gz0aHFU21RP2bcTYbg2r3usBgF/Oo3oARRd7wZSIq2km7oMHMwoFHAIrR7IAN+G5CNSe0efDg8T/p3DaIt4RRw/2SZ0VI68IyNNVmBaqyhVaI4foPw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f970e7de-28d4-4ea1-39af-08deb1aabf08
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 11:20:04.4773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4UQaKAePFenyppJ3/vJgO7DeAJCZARVhSWYzcLZ7CrxBLdEYap285mVQvFFB1y4xMasB3u1H0GDJeOla1LaAKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7948
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9; envelope-from=yi.l.liu@intel.com;
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
> For VTD_INV_DESC_PASIDC_G_PASID_SI typed pc_inv_dsc invalidation, if an
> pasid entry is just removed, it can never be a new entry to add. So
> calling vtd_replay_pasid_bind_for_dev() is unnecessary.
> 
> Introduce a new field accel_pce_deleted in VTDPASIDCacheInfo to mark
> this case and to do the bypassing.
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  1 +
>   hw/i386/intel_iommu_accel.c    | 16 +++++++++++++---
>   2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 623dc24760..2c716c5297 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -630,6 +630,7 @@ typedef struct VTDPASIDCacheInfo {
>       uint8_t type;
>       uint16_t did;
>       uint32_t pasid;
> +    bool accel_pce_deleted;
>   } VTDPASIDCacheInfo;
>   
>   typedef struct VTDPIOTLBInvInfo {
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index 82bfbdf484..07a1e41a95 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -302,10 +302,15 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
>       QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
>   }
>   
> -static void vtd_accel_delete_pc(VTDAccelPASIDCacheEntry *vtd_pce)
> +static void vtd_accel_delete_pc(VTDAccelPASIDCacheEntry *vtd_pce,
> +                                VTDPASIDCacheInfo *pc_info)
>   {
>       QLIST_REMOVE(vtd_pce, next);
>       g_free(vtd_pce);
> +
> +    if (pc_info->type == VTD_INV_DESC_PASIDC_G_PASID_SI) {
> +        pc_info->accel_pce_deleted = true;
> +    }
>   }
>   
>   static void
> @@ -339,7 +344,7 @@ vtd_accel_pasid_cache_invalidate_one(VTDAccelPASIDCacheEntry *vtd_pce,
>            * to be either all-zero or non-present. Either case means existing
>            * pasid cache should be invalidated.
>            */
> -        vtd_accel_delete_pc(vtd_pce);
> +        vtd_accel_delete_pc(vtd_pce, pc_info);
>       }
>   }
>   
> @@ -491,7 +496,12 @@ void vtd_accel_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
>            * removed.
>            */
>           vtd_accel_pasid_cache_invalidate(vtd_hiod, pc_info);
> -        vtd_accel_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
> +
> +        if (pc_info->accel_pce_deleted) {
> +            pc_info->accel_pce_deleted = false;
> +        } else {
> +            vtd_accel_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
> +        }
>       }
>   }
>   

LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>


