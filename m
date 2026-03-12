Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38BFFED2C2
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 03:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Wdn-0003wu-Gl; Wed, 11 Mar 2026 23:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w0Wdk-0003wF-I0
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 23:23:12 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w0Wdh-00031S-Sr
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 23:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773285790; x=1804821790;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8jwqbofK7DLT+QeNt+4vNikbzy3Q489J2DNfIZS6iXs=;
 b=lVWkCgeE7QsCjaEIe7Y9J363zG9S4meB/J4AgI4ub+IUuJOc1tBCUhJt
 sWko5VokSfc0iMJnK5w341LDB9Unr4lVZcshXL5VfmeRtrDk9TarEKWzn
 +666IldHV2hah7CM6dKhevByPkQcPFlPG1d37PuD7uktdwL011zDmbLiW
 oDjaDO3HkQIM8jXIaV0Oht2neuNGd0NY1nj/p9bbYLRuLWbZrSJq2qqcN
 Cruw9VZXQJmb/o8ZWf5PnhpW9dTNEU2awh4DeYu57LP1Ro6TjvGz+VByq
 C27ml+6MinS3IQTIwarUnhkb1nC21yxAkBK7qc5Fj88f2Zxt+AwfhmfhU A==;
X-CSE-ConnectionGUID: et14vAfaR0u9BNA3k1hqPQ==
X-CSE-MsgGUID: G4oFnNrpSJyOnGnqGBOiHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="96986284"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; d="scan'208";a="96986284"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 20:23:04 -0700
X-CSE-ConnectionGUID: uKmB9UueQt+0cZY2LAj6Fg==
X-CSE-MsgGUID: +n9eLnPCSMKv5GsVQjGzCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; d="scan'208";a="217273808"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 20:23:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 20:23:02 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 20:23:02 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 20:23:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpqkfjan4C1U3FsCInsetqwdPe0aotck5tjpVx0vv7MdJx1iwdLjY25VWr5pyWPLlk0Qm77PXmSK8HyaabZIUzdnXIZ3CIqTvUQpGSIo7i6VP9x1yOBAxVsM93v66rQmc7+yFLkI00JfUzBkpAXrWxE54vQXPQEFReBafdGlWWIp5CAIS0xHFd57J4Sx7ObclZmi8t+DXSjjveQzR7m84O9yWvdLXPxzPQDsWUlGjioR1Im8AokzFL+wSodLhbotNi9R+0g65iCpYHmgXdvlxNUaqpCmsIjYLcDUIsLlnXBOJhD7V8oyuQRF5dXr9nHuNjn3bvu4irfiWf8saroUVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4hesue6XPpH4rHyJii7BUCfdx3PTEsbIlpzRLrYruA=;
 b=GPeiQCulkEWaDKLrvhLV6rsdFlqHalLX14SMp8+8Gz5YvND7QR4evQVBPlFy1k87uICiriC2ZG8DtCVTU+HxG4dauHzCRQtX5RTVqkw87woltfujwzLm5a5X4VCBYWX2/vfKNE0yyrXF2x4qraoNmcKgoNOe+lW7WYU8Vbpu8N0poEND3QTg/HWQQgYHsN7F8D2pgLDno1CeBnMa7WiEy5tkIIRifPsaLiwd2w/zfUXaCOMbsCatyZ5dQJvkTxMshBs6GjHWoXijluXd33WW8dIkvkKljmPM3ZPXG2ScdmzWYl0nJaNx38ESxegJRmdxsobrfxN9UGnykSY1H5Xx6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DS0PR11MB7264.namprd11.prod.outlook.com (2603:10b6:8:13b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 03:23:00 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 03:23:00 +0000
Message-ID: <0478ab32-cec0-4872-ad09-340a73cce7eb@intel.com>
Date: Thu, 12 Mar 2026 11:30:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] intel_iommu: Only set dirty bit when PTE exposes
 write permission
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>
References: <20260310065644.426838-1-clement.mathieu--drif@bull.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260310065644.426838-1-clement.mathieu--drif@bull.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DS0PR11MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 4610206b-6cf9-4852-e9d9-08de7fe6a9af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|366016|1800799024|376014|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1jR1/TEtB8t0XqzKeVhkEtfUNl326fyu/mTk6z9wQmR9JPXprDFPFi/RlJvUUUBERfAqGzB80w/jvlf4X3Rvu5D2dPOmGEgRC6tk93/BI6shu2g9VOlKii+JSchmQdBNDDeMPmXpelHdF7GeUhzKQD3oP4nZsbjWvK4efm2iG793YOQRDW/nX9Opkpg/xcsVeEYGES3BinqcNxFbhEtKtfCBy/XLW+lDS9c6QsLb11Uaf/PhSbFZo14hlAs25a6TgRocJM5T+Prjz/u0OAME8GplT6hV/TYwJE/m8ac/FbEQAjhjV1cROVu8tTSFguXozpCNXNCz5PzhlkXC1H6ONKy7cNcUyVQCzgVNDVCoA0SAHPQf8NYl+JKnnUANnEoZcv0pqxLN3vNfyJ/auQSxdLPJxKyOO9vNGuP6O9qKYpCOk3Xyt682/am12XXVoMZBdiflic78/qMKS59JvY4PCLmTZlXtoBuCTp5KxMyZ4D7ResLmRLCXItBC8rOjawIglvAOw7m+0Ymr35qgVrgxcml6bnQBNIVYe3QhoB1SdyCZ422H15h8B+pzvHuBMjX1hNw1XFYQOIiQ/Zc+qMEXva4fVGEYcxd0rja+fylOk0gqMN8SZC/Q78gWbPToUBqNJB3Qq1FFM7VbEmhfb0pK0s0A94IyBQlfLQEv9KJYbrCgxs2ro6dzYFh1bRhAQvy94g0ngyR8TZ3iTc1/jRvuyZqdxhuoP2R9k9vnmShoxa4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(1800799024)(376014)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXA5UFJlaFdIaTJGM1BaODRxNjh3TUZwZWp0QUNkYTk4N1hSU1RvY2tpUE5z?=
 =?utf-8?B?dThtUmpZbWV6Zi9XeEdQbTdlZVZxQThzR21GOFhWdFdDL3FvQ1FBOTFKY0h2?=
 =?utf-8?B?emV5K0FIdzF4N1JzVXdhWjJiM3psU2dzYnk5clZkdk9McHRNMFNPUUJvTUNY?=
 =?utf-8?B?M0VuSEtpUEs4L0dIMy8yMytqcmsrSWpXalNDdHMzTi9Ja0pXZ1RqVGJoK2Nn?=
 =?utf-8?B?Q3J6RFpHYWhoMFo1ZEprSlJWZ1BTTlkyV1pUWUg0L1d0NXVCM3lRWG9nSUpX?=
 =?utf-8?B?SXBjcnpPVlpPaVZ6ZG1rTXRFRy9Vdlc4TXQ1NXFQa05teFJxMzFyemt4c2t0?=
 =?utf-8?B?bmg0ZE5wbFZvajdhVnQvQUh6aWlnak1VRmoxaXVtbjlYUHlIQ05QbGhlUHdz?=
 =?utf-8?B?ZkhiZ2ZCRUJCcU9zRHJOa01JV0VQVXVzV1J4S0YrQWFLTGtpVUorQzFsdGhQ?=
 =?utf-8?B?d3Q3bHdtQ2ZCdUVoUnYyWE5xOXpNdGhUS2daWU15QS93TVAvNktROUNmaXlE?=
 =?utf-8?B?bExRekNTMGdaMzlqWXpQOWZER1lhdi9lZ1lyS1pkNlVCclpEdkVoSTZWY2p4?=
 =?utf-8?B?ZDdRSVV5ZkpBMHphaDExOTRHUEpCQkRhRlhBOUJVNXpDOXlNUDRjTFowU0VN?=
 =?utf-8?B?a1Rhc1pGeHQ5bEJ0djB2VU5Oa0V3M3drbnhlZ04ySXNmaitSQkFXeVk4WGI2?=
 =?utf-8?B?UGVWOTByV0hrQU1QOE85WCthRlZiTGNwa1huU0pyRzZIYmttdk9lL3BDMVd1?=
 =?utf-8?B?TDVOaEVISkhsV1dkQXVMSFI2TUUrNlN1SHRIMUJBMzlVZ2JDcVYzUUZTS3ZR?=
 =?utf-8?B?ejB0TTFKVkdKdTFSeGpQMlR2dGptUVpqMnNKTE9RdHZ2U3NKejU0a2ppeDFt?=
 =?utf-8?B?ZXIwdUZGMmhOclFFQUJJNk4rNG9uK1JZaHhkZGw2OVA3WlorRDRDZHFWRWNx?=
 =?utf-8?B?U0djMUFnZW1Qc0NodjhRTld4bnVBb210UUloN0JYY0NOcGZ2OUdxd0NrdCs1?=
 =?utf-8?B?Z1BMSzlLQlBIWnYwUndpVEM4Rml6K1Zka2tsY0xIcW1JRkF6QnlQT2Rjd1ZD?=
 =?utf-8?B?aDh0TDFhMWJaZUo0YzJTYU0xRS94MDROcFFhck50NWRtRWpjeFlUVkZtVE1z?=
 =?utf-8?B?R0RxbXVaL25sSlhlSVRWVG5GOUxwQmV5aGdkVjBPYlZLNXB0Rm13ZFB5eXNN?=
 =?utf-8?B?em95dkZBTlVpWkpvb05ybjN1dDRiNzd0a3ZybUI2aGFOWVlEMFFGeDdhWFhY?=
 =?utf-8?B?dWZDbGMweVdnTlMrUVQ2VEhjdU15cWRCdi9lRmhFMWRTRUFzTDNBbENhcUQz?=
 =?utf-8?B?Y3UzSWpNQlVyKzR2aHh2VlU2ZWJiMk9nRW9zbnhnVkFCM3R2RW9KamZPcFZW?=
 =?utf-8?B?OHFwNDI1R0psckMvdG9td3FDeFk4RHBGMVV1QlBoM3VvRms0OGd2bnNscGVC?=
 =?utf-8?B?TjIxL0F2dmQydThWRW9JNGwzWmUycFpVNTlMT1RuSldyYXdqd3BHMjliSFhl?=
 =?utf-8?B?S1owMHlvSmV4WTRVUlQxaktTL0M1ZzNGWU54Y2pyRHlnTDM0V3FlYnVYZW1k?=
 =?utf-8?B?b3FjUUhRWE9BK3VSTzM0NFI5UE03R1RHZEEwdU5MSVcxY0c0bkl0ZDFkTERj?=
 =?utf-8?B?MkFtSWFkS3ltSVF4enZmNmkzZVJ1eEplVVN0S3NQQlJDQVlWVVBnVlByZlNl?=
 =?utf-8?B?QkIxSzc2aXcvQWFBNjRNZVZQMWFWRnllc2lFZ3RlOW1WenczQ1NFTU5QeW1X?=
 =?utf-8?B?eDVhcjA2QnlhTlNPYS9IQVRFOVJNcE8xblcwdngrSzl6dEdZcmlEUVI4TkU2?=
 =?utf-8?B?Mk1PVGJzUUg0TksrR3lKUE00SlFEMlJVaWs2SHErZjVjVzdBallrcDMyM09v?=
 =?utf-8?B?VHRrdTUxNHF4YUZWVDVxRGJacFk5WXJucnFCeDN6MDlBYjhONDdDS1hzeWpE?=
 =?utf-8?B?eHBydy9LRTRadHEwQVR3bkgrYzVZMnZsUGxFWXM0ZUxOa29DUzUzNUd4WDJI?=
 =?utf-8?B?MDJvbForQUJSRHc0cURtWXF2c0JFOEhyYkdSU2dKUk5iZ1hPRkdqVW5Sckt3?=
 =?utf-8?B?R0laWTVlRWVOcnZqc0pxQ3h1VnpUL291STltRWVVelF3WTBZU0pOaWIwN1gy?=
 =?utf-8?B?WldhWXNuVWgxdWlFMnpGWXdqRWZvVVNmWDdOTU8waG5EVEgxbFdQWm9ncTMx?=
 =?utf-8?B?QmM2YndKNEc0aUdkMG1PRThKWCtsMHpDU0E2VnNlY290eEUvZ2llckJNOGZa?=
 =?utf-8?B?MnVPRVJGMUZjQ09kOW54aG82Nk5IVWtDSVVROVNjSDVvd0lsTVRzRWRLSmpr?=
 =?utf-8?B?TXJEOGZDRFVwQTdLaEpnNjVPQ1hwTklNU3kva2hOSVVDc0pGMFdIQT09?=
X-Exchange-RoutingPolicyChecked: VuTIMQ1ngnYNaYTUGQ2NbAf4IhPkai8K9jg0BKLaEQ2WVN4+7PISeCU4EO4rFxb1SQC69P2rJ/4hLrRvZipsZ/oPGHlQgcqDLNnh9EKbVh6N7mvQvHWyU6vVAQw26OZPBM90K96hnOQVKyV70t78wK+W5bVHz39Pc3G2EDMxDjAW0E0szuAKRf2gzLEvy417faCNdzkmP5mBMeDNIg/LC8w5W6XYZLlsshv8htN71zmcKs/ONzhR70Rrlx0+6OErGq6HIRqF37w90w4D4wIurfaTvfZBGIKCyXyeJ/AwAyamzpv/gRI/7D8De1taFWBFgYXyfszrEjEFCggDclb7Dg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4610206b-6cf9-4852-e9d9-08de7fe6a9af
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 03:23:00.2796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uohk0R3mIUY7e6M/p7LLP0YeDFGF3pxT/80lXvyqzPr/KrHY4boT6xG80V627rmyC6WmZeaJ4yAIcS5ACX9AWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7264
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/10/26 14:57, CLEMENT MATHIEU--DRIF wrote:
> Avoid unintentionally flagging the entry as a shadow stack entry.

hmmm. not quite get shadow stack...

> In the current implementation, the dirty bit is always set in the pte.
> Hence, an ATS device requesting an RW translation for a copy-on-write
> page is likely to trigger a PRI request for a region that has just been
> marked as dirty by the IOMMU. However, CPUs that support shadow stacks
> give special meaning to PTEs reporting W=0 and D=1. Setting these values
> can cause PRI requests to complete successfully without granting the
> expected write permission, which leads the device to enter an infinite
> loop of ATS/PRI requests.

appreciate a clearer explanation here.

> 
> Fixes: 65c4f0999991 ("intel_iommu: Set accessed and dirty bits during stage-1 translation")
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> ---
>   hw/i386/intel_iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index d24ba989bf..56146aafc1 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2066,7 +2066,7 @@ static int vtd_iova_to_fspte(IntelIOMMUState *s, VTDContextEntry *ce,
>               return -VTD_FR_FS_PAGING_ENTRY_RSVD;
>           }
>   
> -        if (vtd_is_last_pte(fspte, *fspte_level) && is_write) {
> +        if (vtd_is_last_pte(fspte, *fspte_level) && *writes && is_write) {
>               flag_ad |= VTD_FS_D;
>           }
>   

the change looks reasonable.

