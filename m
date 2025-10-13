Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADA3CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 10:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Fe0-0003SP-Mb; Mon, 13 Oct 2025 06:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v8Fdy-0003SC-OW
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 06:19:06 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v8Fdv-0004HA-Ug
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 06:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760350744; x=1791886744;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yw0u+1OS+IBziMzp/EY6bNAdyzAddEIfhTVCr8YM9AQ=;
 b=WXOgLq1VlXALPy/pdD5KKi47cit1Qr9nuqe0Ra/jPFNa0hNgI/ldPfZF
 uI64r9lCGqD6/N0DPZnTdNhWSAO7mnk0C6tUlqJ6M3i5x3ZsiWxOFxABL
 Ez8jKzhKZBpsvL17u9kpk/vMqSnw7Biuc1E2trgkW/J7C5psWFRRMwS9E
 DstUI1nZrY2UDr2hlbGH5VnHy4DmxZTvYCv8AoIjgfF5zVz4JB/9VWVr6
 P1YpytAflwNUgNxUGj0M6JArIFJl6P84vJbZv/hT2Mv74kIDKB+DVLVhu
 DCcEoPFCI5vVPCdUsbfUqpGNufvbXDYUYo3ifWGU0LaqUueVOYJK6Si/O g==;
X-CSE-ConnectionGUID: PwXi1irlTriDaXTxAyHAEQ==
X-CSE-MsgGUID: WFzVGHmXTfW1sWYYY4ZErQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="73832495"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="73832495"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 03:18:58 -0700
X-CSE-ConnectionGUID: uo7piouOSUO4BDm5RKoedQ==
X-CSE-MsgGUID: WkkHAN2dSOafe/SDq7R6xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="181374883"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 03:18:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 03:18:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 13 Oct 2025 03:18:58 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 13 Oct 2025 03:18:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPtQUx88YspqYxi2oTCXk3EcAu8MEZtu0ZJDFHGnSuH3Q1aanXQJal65B/UUNgeRQ/67NKTHWsPZG4QXgUOI+Vyla2SmvUYn0T8PRtmQhsY1dtmroskPq43hBUEMyvK/zNgQdE8lOy3OCqOYiU54sKnKtnewekkycgSclBCavZTfc/EAxbGMabyZGBXDmzye2jp5PavapoIUOM7Z48xTb/L0VeEEFyuRZdezwB8C5QK8CzBCxKOmZZGlcJDaGe2OT+8GMizvOB+q7LnTiek4bGJ3/Pdn0aYwWi+pdj/ZeK8hXoqg52oZchxLLIgmZNlAHIkrLxbO2rFGpXXekv2vQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdHwAtAQyA4BGPHs7vqv/raQoLyNZoRbUHx/RUEs7FA=;
 b=G6z9OqIRXGv5QbrH9ZgTi+LH2gSUPVdDdHubuXasUJAXU8+8haalDhiau3v9HuFG007ct7/RF/6ee4fAMlq5yRxEDtHa585qRmg+Bi/aErX6PlfueFLp0tzRJk5WnnByCfPxK436TMFKi6Synaqv8NCkAe4IJHVKSvpwyBukWpe/eq8YnVn6FkvPHuDD7R7EjQ2/LIoEokgZCuC5AgXRolzvKO8MfUjWNtHhPoDo+TPMLLjGdcq/pKwJiDjzSijH4eAhvringMsAQLBr9qlsXqYhb3rg+lfSaRvv1FURQin3sHyUHbWJ0ymXLCtLDld3asbBrURXglPvY11rJlDmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by SN7PR11MB6828.namprd11.prod.outlook.com (2603:10b6:806:2a3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 10:18:56 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 10:18:56 +0000
Message-ID: <50fcdab9-b635-43f4-b3ba-21fef152459b@intel.com>
Date: Mon, 13 Oct 2025 18:25:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/22] intel_iommu: Add some macros and inline functions
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-15-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250918085803.796942-15-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY0PR01CA0015.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::23) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|SN7PR11MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d35291-8d54-4c42-31ff-08de0a41ea86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|376014|7416014|366016|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eE9KMFliNVlwamp4R3dHLzI4dlJGTGFvQlpaTEMvVnhXRnRmN2ZZUUVyR3hi?=
 =?utf-8?B?THlzSGk3a3NFcmNMTWtVVE1WUnNDbnJQczZOOFpJNHd4Z241WkU2Z21Bckx0?=
 =?utf-8?B?SmJIaGdzUW12ZjBmcTVXWUtxVzI5RzRUSDFVUDNSUVBseS8xTjA2YUY0UEE2?=
 =?utf-8?B?V3g5YVdIekFvWmFSTU9WcjFQWWNPRjYxM0xQUVhuNEU1TXBsd3F4aC9iK3ZR?=
 =?utf-8?B?anQ5eG5ac2pNWHdWUGVlNWhVS3FWNklhTk1FcWNUWkJTc3dNNWwrUU5UZmt1?=
 =?utf-8?B?VTN5MHNGTnUwMkNkZjhFUUJDMEJLZDJ6WlJOaFBhZ0JSd1lUVjlIcE9GR0xn?=
 =?utf-8?B?KzBwejlYbFlOTzFzUXRxaDA0aHlGTi9mK1hJUTVUbU1OTW1vdlgyL1E4Sml1?=
 =?utf-8?B?U1RYOWlDcmRDUXNQaFR1dGN3TnQvaTI0OVUxcHQvdWlOOU01RG5ZcVFwMENj?=
 =?utf-8?B?cW5Nc0sxa3BSVTNTR3pSdnMrNWZKUC9uem5adkI2NHlqcDlvUXI5cXB5U2l1?=
 =?utf-8?B?MEQ0WXB4UGd5Sk9DNW1xRS8yUDNnMFgwSDI1b0JzU1lnNk9RUzRJeHZOaEtQ?=
 =?utf-8?B?cUdEbXlQa1V6ZlMrdHJNNXdJLzdWUWRnUnVpczdkc2dFaUYwVGVMZkpLTzF1?=
 =?utf-8?B?eE9QZi83ZS83RlduUWxUNjNtUGNOVlVaR1NZMmp0VlFkcVQ4dVNFL2llVzhn?=
 =?utf-8?B?YloyWjkxNEtRdFRocGJVWTBNdHdPaTdjOFA3bDU2b2Nuank4Q2pmanpYdmFW?=
 =?utf-8?B?TlB5ejNqNTFwU2Vtd0hDeEovaUNIclgzN2RWSHlUK3JZR1R6U3lvclVVU0s4?=
 =?utf-8?B?T3RmOU1mMzFsdS9uaDJ2bXRaeFhzRUVsTmdCNEN4V3llOU1DZExHYUNyS0hv?=
 =?utf-8?B?cnlIaHZkc3p6RWhCU0t6NFhFeHNmbGRUNXhlNUYyT1kzZXJrZkh5aFp4NHBV?=
 =?utf-8?B?aXpRZ2M0QnFKY2gyN3dvVjhFbW1YMUQ2aDRtQmVzNnJxQ2tkS2NwWVZzMTFR?=
 =?utf-8?B?VURaQXEzRzY5SXNTMHlyZ2k4SUZObHFPeGVXdiszL1FQMGpIWkVpbEM4eTky?=
 =?utf-8?B?U0RqRXhIK3RBVjk0YlQ3K1pKcW9meE5FaFVkcm1YMzNtWW1UQ2xrNCtnYmVm?=
 =?utf-8?B?L2E3WVU3bjcrSFBmRzB5cVNqZ0pCY3FoYmtHVlE2RUxHMGQ5UjFKQjlESloz?=
 =?utf-8?B?UWk5RXljcEtrbnFGaDUwamc2MUxBcTFpM1krRGZjOS82VEsrMm5oc2ovaXND?=
 =?utf-8?B?aGErQmFuazg5eWZLYnhydUxqbm5LWmxSSGhnRVZaSHVvcmRpc2NGUmdGQlow?=
 =?utf-8?B?bXR0b3Z3S2tDVjkxV3VoMExxdC9CUnRQRU11dmdvbmNUeWVmc2F2QURBVjVJ?=
 =?utf-8?B?cDFCclZpbktDMGJ1emY2clRSTEt5SmVoYVVQbFhBWCswbWFIdHpoaE5CeVpB?=
 =?utf-8?B?YnVsdTZLS0RvTTBiK0NTQXkvRmdRSVNjaXlYT3k0NFRMNTJqd25ZekZxNHNE?=
 =?utf-8?B?d29zcjBnYTBtbEh4Wkh1MlFNUVRnYzNheVlUTlJoYWFPUkJoMmRtdUdMZUw4?=
 =?utf-8?B?dGh6QXFzU1lnMk9SY0lHbVN1TnpPb1dNMlpaMWNWREhWMDA0NmU3RXFqbU5O?=
 =?utf-8?B?WWNENkw0ei9Jd0l3NmlqaXpKN1ZRb3lMZk9OWC9zWGw4b1o4Z2hNWnU5amoy?=
 =?utf-8?B?M2ZISjVROHB2bjkvbmo2MjllTEV2UjNRSmU5Y3MwS3Q5U0J6OVlRaDR3R1Zy?=
 =?utf-8?B?R1NNK0ZZL2FGWlFBc1pIdFFqU1hsNGd5MHFaUFo3Lzg4YVN4aFlMZlZwMDdx?=
 =?utf-8?B?bkdEMzREdXd0YWQ1VHVqU0FaMlBlVUpxRG5YUzdlRjlvYkZQMFJmQ1E1L01i?=
 =?utf-8?B?ZzlpV1JhZ3FkNitQZjhETFAxUTYyZGYyWDR0UnpwdFNXdnBERWZ5UzdCaFg1?=
 =?utf-8?Q?sTigQWZhdsIx5tDe2MH1jrA3H4FA4BTN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(376014)(7416014)(366016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0x3SmwvYWEyWkUyVGZJRDJhbmd6WlBNZ3N2QVd2ZjBBUElOd1JkZ2Y3L0k5?=
 =?utf-8?B?OHpyYitMSDBOR3JxSmFyYzhYbjNtUWlFclBkdjhZMzZpZzdKYUtwV0pCMEp4?=
 =?utf-8?B?QkErQWhROVJqVTdRdTM5YWJIcUJYek90UUhDZjd0RngycTRHNDB0NFQ2WEtW?=
 =?utf-8?B?a2RqSVpRa2RwWEoydlFzMGF4cW5IU2VoVk14djB3MnVBbDk5d2FvQWFiS2M2?=
 =?utf-8?B?dHd0dWFUbTJoVmNwT3ZDWlpsSnhDaFZ4M01ESU5uTlY2dzhSKytaNnNuSExM?=
 =?utf-8?B?SG1XZFBub3NOTExUaDdCcFNlb0dEVXhiY01GNmxNemVnVjJ4TytnTHA2cVJ3?=
 =?utf-8?B?clZ0MEJBMUNnWXQwYWxTU05hSDBDYU9CYllaL05mUllWRVRvbmlnM2NYZS9Z?=
 =?utf-8?B?Nmo1VnNBV3c5bm9JMGQ4RTkyWWduMFM4SzhwN2NWMUJ4WFlrL0tQY2NhQjNQ?=
 =?utf-8?B?azBsaVhTaVp1U3FzWkZQc1BDQjJoWUFtYVphTU95MURweVlhSW9jSFdqQTZK?=
 =?utf-8?B?ek5mdkpCTVY5ajloc3lsVVdEQm5WS3VwRmtHWXhtU2t1Z1hQZmgzV0lkWDBZ?=
 =?utf-8?B?V0dON08yKzNVQzZvelVjVStBdzRKSEJPKzQyd0ZnVUFKczJqaTlZYS8wQUlo?=
 =?utf-8?B?SXdUSjQyaEpDdllYSkVMV21Oa3VuUHgzS1R5dC9ibWRYMmNqdGhmOHFBRldH?=
 =?utf-8?B?UmpmT0pzMGxDcWpzOHYwRitIMk1UOFpLTE4xOStRZDErV2xpY1I5L3drUkU5?=
 =?utf-8?B?Q21HNHA4THNQZWlVN0FVNDJuekloUzJuZHpSL1ZGakJidVhGWjZBK0VuV3V1?=
 =?utf-8?B?Z2tSdmRoempnQVAxbDVGN3hxMEZ6OG1kdWZGWU5qdzdYdkZjZkVGdVpBZjJF?=
 =?utf-8?B?SjFmU1FTdUdCczA4NVczMHpWaVRoZ3lkZnFoaGF1ZDBFWkQ2dWREem5Nem9v?=
 =?utf-8?B?WkdETDBoalhBOHdGZFZaRldFQjE5dTR6QVlUUFlYLzRRKzhCRmxTRTNPMW5E?=
 =?utf-8?B?cCtVbk5HYW8yQ1ZOZlZLQmZPWS94VzYvdGNYN1REQURtdTd4NG8yWFZmaWs1?=
 =?utf-8?B?ZDhNQUFKbk5INWVmVkdsWUkyL2tBYXBJZmQ3MUVydUJSc2dGL3VQb1lYTEN4?=
 =?utf-8?B?bnl3Y0k1NXZWMXFCZ25ZYVZ3TnRrbXRJQWhWZ25nbXhzRnF1UUtvR1U3V1BS?=
 =?utf-8?B?aFA0WGVvWFA1OWtWSU43bUgvY1NUbm42RDRmS3BXMlVSTGpxNTNsL0lqMmZY?=
 =?utf-8?B?L0laVjFpQ1RlbkQ0TVcwcU1tSFU5OXVGKzJYOEdyRTZ2aTJRZWw2THZLdE1B?=
 =?utf-8?B?TFhMR2ZVUEY2ZXI1NWZpR2ZkUGdndktjVXJpRkN1SUFpUlNWb0w0cnprcDY1?=
 =?utf-8?B?R1lqdTVqclIvMlhjbDUzWVFVN1pyMEo2S08xVjV3aHk5MHUycW00alF0OWpN?=
 =?utf-8?B?RWFIbHllWFY4Q016WmpSb3E3eHI1eU00N29UbFYvNi9xNGhHOTNZanE5UHV0?=
 =?utf-8?B?NTRFdXh0SlNVUkFlYzlzendJTmhBMnJQWmQ3K1gzTzh6ZDY5QVZERXE3RlVE?=
 =?utf-8?B?ZVA5dTEzcHNFNk1mbGVJajdQMXpJaTNCZzNOaTFLTkdLRi9rQW1STXhZWmFh?=
 =?utf-8?B?Z2k0czkyVDZKUEFMaDJNR0RpUk5zelBxN3pSSW5EK2tEUUZsMnV4ZWVJWFR1?=
 =?utf-8?B?TExtRSsrZmoreUxUcHhUVE1wVnA5NUlWODBpM0hGc0ViWmtmQmVMYkNTZER1?=
 =?utf-8?B?MENBcWYrVlk5TUFtUVlzeUhzMldsTzJXbmNuQ2RqWmRaUTRGZEJLdXkwR29p?=
 =?utf-8?B?MCszS3FlRGZTbVhQenROQlRyTzY1UGtVZEZnUnhEeVdVN2lWbzFoTG5MWjgv?=
 =?utf-8?B?bTlNb2xoUzRnK1g0b0hRVlFDak1WNXplN0RCcm5ER2JqS1lZdmhwbFNHcXFy?=
 =?utf-8?B?MjMreGJhMFlCWDBMWlFpK3hRTCt1N1dKOWYrRHR0Q2dDQzdnR29YMThmWWNt?=
 =?utf-8?B?WkgrdGowcU9BMGdNUHB6UWVzZHRLbmZueGZ2cDVmbjk2UlJNeCtMNmJVRHBj?=
 =?utf-8?B?dnhpTHU1aTE5bFpDUENEVm1od216cUdYSmF0ZVl1Qy82bmpPaThmdU53RDdB?=
 =?utf-8?Q?y0P0XK8vfDbG0IjL9I66/Qsg8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d35291-8d54-4c42-31ff-08de0a41ea86
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 10:18:55.9461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xtv+mXbw+tLgbb5uz9b/V4dHz24iopXJzhg4CNjQQZQSkR25wn70oG3kYJ1lpXpJTBH3dFxfQORzYKyMjhHfLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6828
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10; envelope-from=yi.l.liu@intel.com;
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

On 2025/9/18 16:57, Zhenzhong Duan wrote:
> Add some macros and inline functions that will be used by following
> patch.
> 
> This patch also make a cleanup to change macro VTD_SM_PASID_ENTRY_FSPM
> to use extract64() just like what smmu does, because this macro is used
> indirectly by new introduced inline functions. But we doesn't aim to
> change the huge amount of bit mask style macro definitions in this patch,
> that should be in a separate patch.
> 
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  6 +++++-
>   hw/i386/intel_iommu.c          | 30 +++++++++++++++++++++++++++---
>   2 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index d400bcee21..3d5ee5ed52 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -592,8 +592,12 @@ typedef struct VTDPASIDCacheInfo {
>   #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
>   #define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
>   
> -#define VTD_SM_PASID_ENTRY_FSPM          3ULL
>   #define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
> +#define VTD_SM_PASID_ENTRY_SRE_BIT(x)    extract64((x)->val[2], 0, 1)
> +/* 00: 4-level paging, 01: 5-level paging, 10-11: Reserved */
> +#define VTD_SM_PASID_ENTRY_FSPM(x)       extract64((x)->val[2], 2, 2)
> +#define VTD_SM_PASID_ENTRY_WPE_BIT(x)    extract64((x)->val[2], 4, 1)
> +#define VTD_SM_PASID_ENTRY_EAFE_BIT(x)   extract64((x)->val[2], 7, 1)
>   
>   /* First Level Paging Structure */
>   /* Masks for First Level Paging Entry */

hmmm. is this missed by patch 02 which cleans up the FL/SL naming to
FS/SS?

> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index a6638e13be..5908368c44 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -49,8 +49,7 @@
>   
>   /* pe operations */
>   #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
> -#define VTD_PE_GET_FS_LEVEL(pe) \
> -    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FSPM))
> +#define VTD_PE_GET_FS_LEVEL(pe) (VTD_SM_PASID_ENTRY_FSPM(pe) + 4)
>   #define VTD_PE_GET_SS_LEVEL(pe) \
>       (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
>   
> @@ -838,6 +837,31 @@ static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>       }
>   }
>   
> +static inline dma_addr_t vtd_pe_get_fspt_base(VTDPASIDEntry *pe)
> +{
> +    return pe->val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
> +}
> +
> +/*
> + * First stage IOVA address width: 48 bits for 4-level paging(FSPM=00)
> + *                                 57 bits for 5-level paging(FSPM=01)
> + */
> +static inline uint32_t vtd_pe_get_fs_aw(VTDPASIDEntry *pe)
> +{
> +    return 48 + VTD_SM_PASID_ENTRY_FSPM(pe) * 9;
> +}
> +
> +static inline bool vtd_pe_pgtt_is_pt(VTDPASIDEntry *pe)
> +{
> +    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_PT);
> +}
> +
> +/* check if pgtt is first stage translation */
> +static inline bool vtd_pe_pgtt_is_fst(VTDPASIDEntry *pe)
> +{
> +    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_FST);
> +}
> +
>   static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
>   {
>       return pdire->val & 1;
> @@ -1709,7 +1733,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>                */
>               return false;
>           }
> -        return (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_PT);
> +        return vtd_pe_pgtt_is_pt(&pe);
>       }
>   
>       return (vtd_ce_get_type(ce) == VTD_CONTEXT_TT_PASS_THROUGH);

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

