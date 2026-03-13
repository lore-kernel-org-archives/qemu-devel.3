Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB92106FD98
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 08:18:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0xhy-0004Nc-9h; Fri, 13 Mar 2026 04:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w0xhr-0004NM-8E
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 04:17:16 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w0xho-00007K-H9
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 04:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773389833; x=1804925833;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CBIEL/MICSHGmI9iSs9MdGUTnz1Qbv/nBT67XV5lJ0Y=;
 b=bT6UFUC/3MnZ6YuvaT606++QpxCNvDupsHjsd8TsBYqaSU3noL6NBDKA
 3F0L6jCpJlRKN0EgsxOSvankY99oaX0R4w/6c8EIx+l6yGjG/lmqMLusu
 k4EcG3TYXa24RBzXMNeuQ2DVBOQwLuYYI3JeF/sV3AOuPrXo3MdLjLn0u
 ZRcuWVUpAnhIm6ERxErvdflvoyYMpqgBkRfC03GfxpYY03AHQKYLCNuJE
 XWeJiHxTVuSfqaRd8bG3oLNLFOMkNfo9rjuT3+JL8KHWpge02CZ1Ncr8h
 R7fPi4583IRXpavBOfR6kH1HqZIwg5F8+GidgilJSozDyBjEqxBp5hRuy Q==;
X-CSE-ConnectionGUID: p/bOIAeTQee6Gg09/gonsw==
X-CSE-MsgGUID: X7CxdXLtT4ShSCId5o7/yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74575790"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; d="scan'208";a="74575790"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 01:17:07 -0700
X-CSE-ConnectionGUID: bmVddYBXSdKLKIv2+e9i3Q==
X-CSE-MsgGUID: sqo7pKhIRy+b6bIIWosDXQ==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Mar 2026 01:17:07 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 01:17:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 13 Mar 2026 01:17:06 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 13 Mar 2026 01:17:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/DjFRLjKnHZ+WQsjXy0MfjmKvYGg80On1r9Q0BiTScFwO1C0spjZ4aLOUsZzvrFkc4G9CSTPMZ1Uz6e1haG0Efat9XTXV6JVnRgraGPJjDCBXlk9B80Bla0Ad/5IVRiTS5HyK5/EJC2cM4+bS7UnJxuZ1fX/N6lRsn130nckiptdhErrgOKmIio7ycTgDOhmZTPnVWsg+Qe78V+QmbEBi4y0xaBQPClHgrtNcE55bRA6oo0kEgiSHh3hfE7V1TJEzRxW4S2tlk8v1ZGYv6T1L8T6IzLe3KxzO2Gy87biecm0y0Nh5GL3pI9h3SliyW91jeGhQkBbRkrXzIJSSfu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jk6XOn3Kr4Ky9GxbLCySv+P8NKow1eKzt9CiFfA6SUE=;
 b=NxlvQGcJTwLrBux5LiE/DWyPsvwnEwikgwptvdyXWiCv3b7AAj0TGx1NL/ea9bWYqoVRd7i2cF3pKJ3UVAaT2CAjQGaIuJB0VauNzTwM3r6jTGOumwfg72I5db4+T+a8l/O4YvsGqSFjS+Ov8JODkEin3IawQt2p2jh/XiMRg9+gsMMSmOrTEYpGGvF8yF7igIpTuVFzFCpKBM52lvdLJon2R84FtZzDXzlDVEroQzzp3ZUfWiTlnVzubCFDEvOwBMUjcYZtJ1+HF2USLLaj0KmbMxJKYedXXfw6jMKMB3FyIS66o8dcLN3iYWYv+IIjHxCtoumrhNatfJ2Ox0bgAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SN7PR11MB6995.namprd11.prod.outlook.com (2603:10b6:806:2ae::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 08:17:01 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 08:17:01 +0000
Message-ID: <dca00276-bf80-4cea-81b4-4f81c96d9a2e@intel.com>
Date: Fri, 13 Mar 2026 16:24:46 +0800
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
 <0478ab32-cec0-4872-ad09-340a73cce7eb@intel.com>
 <ca81cba3d96c61558ff3058b6deeff3b7716b658.camel@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ca81cba3d96c61558ff3058b6deeff3b7716b658.camel@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0029.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::6)
 To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SN7PR11MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a85cda1-f2af-4d56-10b5-08de80d8e6e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|42112799006|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: htPmU5b+lJGkfzy5GqGWh3Inh/qW2qO1k579l3k65qIEbPNKHaW+E0zWbfcm3SMorflk9kXf6pUHxL6fFITmdEURscMGYineUQnQj4ew2DHmVAM5HNpZJ0H6i61Nd2AmvXy6t/+N2wXdoRTSD+kNguN5C4XRBZgIPdQWowrkKXAuMm81fllj8PAH2FIhexWjq6uVwHhHd6Vg1HCI8+omL2FLoM//7mLOT7UT2/BzS/s7hhusDNEgpglxjXTVRba4Ag4AN1nLYktPr2aI/3zOC18Ro7NTzcWuIXCTqXpYYY0lMVJ0i/WdAPjSOGWz3DhAJk7bxB8EQwGUMjM8B37Ztax6rUquML0MwNVSzaOPu6UqGN3Xwzq1W6DtlPIGIpMy2cvv6j5/k8ok6GI8PkxREy5RyuO51kovlKWXxz1J9qaQxRu1IBFajzn3tSd0iJlHN8MiuMPro892rI0EB8pG5UsKUzlGr0NCudm29X5joJeeUjTX/SN/bihIZHjLj7krjgpWC9EpeZOr+DOThGdWFaOl1Mac14U2/KnuVSYru/zKqUVGFKppq9N4w0acUJ1mL0cG6YV59GKLju3svKXbCnJlum9u6mCnXhjmlDqw8kFt7n2pF8ktmdL7Ys4rfZqRn8qkUht3/kYSaZWhkWWJA2QSsrvC28rW5NcdgJ41pF8P3jN9l/1ytdsFLBkxSFS2gZumipGGbUsuxu8a4JjoEIwy1SeDOsHGPY456VclLiCcrFw7ziFurF/Up/TTpbV6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(42112799006)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3ZFNUt1bWJWSHpiNTk1dnZ4dmNCRlc0MjBzRlF0UmdHandlZ3JOa08rWVZ1?=
 =?utf-8?B?NCt6UnlDRlN3eFgzdUt2T0NLYXpZRm1WVHhUOFNMSmdRcWwrU3F6UDdFeUhn?=
 =?utf-8?B?OFZtcnRtWDh4aE80OWVrcTJUU1J1aDVoTzEwUXk3N2RGZ0xtVUc3ZTZ3VVZu?=
 =?utf-8?B?SVp5Q1c2VTJ2UmRTUEovS2JWR2pkTTJ0eE15TlhDbzhCNVNFZkJ0bjdMY05y?=
 =?utf-8?B?MUdPZzhJNGtnUDFRdk96amxTOW9TdjU2ZUdWWm85Z01laEROaHVGcFF6Nzda?=
 =?utf-8?B?eTdQendzQlZmTU9qRGxXT21vdkFKRzZUUDdIendpbzdDa0JYd1BUU1hHZkR6?=
 =?utf-8?B?Ny9qenJNTlZWQzg1dm8xelpsYWc0ckh0blVGeVBGaW81R1JYQjZvQ0NMNG9V?=
 =?utf-8?B?bjFEV1FEOHZWWXFVcG5BZDJBWmJjYUIzUm5MSHd0NFQ3dUxVbTRTb1c1bG41?=
 =?utf-8?B?K1MvYTNLZ3lSU1pibHpTZ0NtNmlucXJpY1MweUZZQThFbUNJbVFHSjloK1VG?=
 =?utf-8?B?M0Via2dzbHZvL0VEYXJPaGRBU051UlhnUDZpOXlIM2FhVnRSSFgxWFVMSHc2?=
 =?utf-8?B?T1VvNmZuMGV4eTh4VGJ1S0FsSUFVd1lVcjJBMk9IU2k3b2liZ0xDNkZ6aUVN?=
 =?utf-8?B?RWUwdnovN3MwbHdHUEZzNCtOT3VMbkREait2TTNYVlp4VlNEd3dBM1AzREFp?=
 =?utf-8?B?TDRpWm5pQVFSSVFwc2paTnpNNXc5eFovVWpIS1BjSTVoaHhnVllEUVFndHJ1?=
 =?utf-8?B?N1VlT2MxQlpiem9iSmZsZHgxa3hNZFdSNkF1bUZsT1hjMGl1d0VLU1FCS1Zv?=
 =?utf-8?B?SHoyRm1sYTRKa0hwUVBHYi80U2FnYTk5d3FLbzY5UkI2cGFINlVid0trN2lG?=
 =?utf-8?B?ck15V1lORWtMZHlQYkw0STNhRkVaZkxnTXVGT003bE9iUlkwdVBnN2JEOStv?=
 =?utf-8?B?amc5aFN0YTVlbzFLOUwvNHRONyttMHNhZFhnRXlFakZRRjN3UGRDbUlrZzUz?=
 =?utf-8?B?WGdSSmFJSGZBSnBZTlRzRWZNcjVJc05lYnVSU1crRFVPSElCN3diMVl1dW54?=
 =?utf-8?B?SnNkdnZ0NmdEdDJ0R2FUdkxMTUlocGZBb1lxRlp6WkpnQXJNWndmNFlQOVhx?=
 =?utf-8?B?M1VvOXY5QUJ0N2VuMzVlR2MwckxkelZ0RDdud2dpaEc0UW81TEdrZmR3OU5M?=
 =?utf-8?B?SHRlaUZPbEpPRzVCQlhybVlsejJsUXJ6c2JsWHpBT1ZoM08vV2hWVDFCSk5F?=
 =?utf-8?B?VGVpSUVoMGx6dWJDeU8veUJnN1htSTlLdk9XcmVUdDNQbGV3czNSdlNHVFh6?=
 =?utf-8?B?N25qRzdpZlZDNG9aNHNwWVJiM3poT09vKzNOTjN4L2crRnh4UDk5V0hZL1k2?=
 =?utf-8?B?RXN0U2s2a3YxQ2ZhK29rWE5zYTZFL0xVUnN5WXYwZExDcHk5YVBBeWFVV2Ry?=
 =?utf-8?B?enRyVVQxaU1HUE9ham8rNG1WL0VCMTFTdGRtMmpKNXVZTVBLajJrcjJDZ2Jx?=
 =?utf-8?B?MldHUzZHby9kNFJnRjZmc0h5b1BVcHVOSmlybmtOOGVVVUxLK2ttZStndzNx?=
 =?utf-8?B?aTN4eWE0aVJSMEZFUkJCcUFhSW5QdWVoblNPeUp3c1pKTjRTMFNWMkpjUXJa?=
 =?utf-8?B?VFYrekErRE93cU9JQ0pGUW0zeW52UTIxTkNTM2ZZQUNnS3RuelFPaW1TQUc3?=
 =?utf-8?B?WVNLVzBEN1J5TzhIdUE4SFliNUhMMWdsdjQ3b0tVZFVjbDlPRGc5MnJYdGp2?=
 =?utf-8?B?WHFGTE52akJGb0xqTDBob1JUemNoZDdsenZmQUJIMFZUbUNmNW9oV0lHbmFW?=
 =?utf-8?B?bHZ1a2RwTWtLWUlhd2N3YzNBVFNZQXNWU2NxVUsrMklxdU5OTjlpOWR1UVlX?=
 =?utf-8?B?bFZXUFY3N1o1S0Y1eGZIWm5DdE9xajY0L2NHdTlpVzlVclB1djhiRWFsT2Y3?=
 =?utf-8?B?Z01CT1Y5ZHhCQnh0NmhXcmxVM2xOeDFKT3lRWlZjMFhIeURCMHVpTDR4MTRM?=
 =?utf-8?B?VU0zSTF2cFRrZVREYmdmWEpucUhvbzNtY0lPUmRZeVY3OEt2Q2tSU3BqTUhB?=
 =?utf-8?B?U0JyVHMxSERZUURBUFZERWNGSkF0SnlhclRkSktQRUFoTG1JaG9YblVtNjlF?=
 =?utf-8?B?c0l2NTByMThFdy82bFdMVkFmVWtuYmhBaXAzMmhXYUhmQkluSndHUnpzZU9l?=
 =?utf-8?B?ZVorb1JZV3VwSzhLeDVWWDVIUGhCc2JrUUJYblMvMnBRdU5Eb0s0L2dSVlZY?=
 =?utf-8?B?c0VSNE9XbzVWN1FveFFCMHhKZXJXTnR5blRNZXlnMXMwcVJkcmVGL0owV0lN?=
 =?utf-8?B?M0h0VzNLZmVmK24xSS9FWmhqNSt0Y0dvODZKV3h5UzlFU1YwOGs5dz09?=
X-Exchange-RoutingPolicyChecked: uULISQiK9EflmcA5OndQhRhHgVGQ7A1f3l9JnpNN8qatGJtiiNm/mOrdrgWFJlAkbxrZFx0FSeiggO7rGpW1UoHeLQHJfHmim0pEGM95gvLK8eXPI2Nh4Ad65uGI/o5sPYuA3Mq28wP1baM76T8W7/71d5j5+/mJWyB8hjq4XX/oQ8QdHS8X5rsVkVmugbCwLuT8fV/8ZmXKUXkOHbKahodG+YBl3j7EBypIWTeYof303LGEEkQRhS5lxz7IuprFXWKsi8jn/aYRysg1/EWxUoaEK1OA2Ng+fprsqvWBK+kn01EqMISlWT0FH6sEZLkHEb5tAd1QYkJ+vkFKIcasvw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a85cda1-f2af-4d56-10b5-08de80d8e6e2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:17:01.1165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xo2qBI7+JWmKKS/awozbyn1fLgRkBRoOqiMYjdF/5uUFbm4Knbin1dsom0Zr94pJIc7uQTEaP36LA/bXNfb1Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6995
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=yi.l.liu@intel.com;
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

On 3/12/26 14:20, CLEMENT MATHIEU--DRIF wrote:
> Hi Yi, Zhenzhong,
> 
> More details here: https://www.kernel.org/doc/html/next/x86/shstk.html
> 
> During my debugging sessions, I got the following flow:
> 
> - Device sends an ATS request to the IOMMU without the no-write flag (so it requests RW permissions)
> - IOMMU walks the first stage page table, finds the last pte and notices that the W permission is not set (I know this page not really RO, I prepared it to make sure it is COW)
> - Because of the condition I update in the patch, the IOMMU sets the dirty bit despite the absence of the R/W bit
> - The devices gets the translation completion and decides to issue a PRI request
> - The kernel runs the handler, schedules the work, and ends up calling iommu_sva_handle_mm (with flag FAULT_FLAG_WRITE)
> - It then calls handle_mm_fault, __handle_mm_fault and handle_pte_fault
> - In handle_pte_fault, it runs the following fragment:
> 
> ```
> if (vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) { /* This is true */
> 	if (!pte_write(entry))
> 		return do_wp_page(vmf);
> 	else if (likely(vmf->flags & FAULT_FLAG_WRITE))
> 		entry = pte_mkdirty(entry);
> }
> ```
> 
> - pte_write is define as follows
> 
> ```
> int pte_write(pte_t pte)
> {
> 	/*
> 	 * Shadow stack pages are logically writable, but do not have
> 	 * _PAGE_RW.  Check for them separately from _PAGE_RW itself.
> 	 */
> 	return (pte_flags(pte) & _PAGE_RW) || pte_shstk(pte);
> }
> 
> bool pte_shstk(pte_t pte)
> {
> 	return cpu_feature_enabled(X86_FEATURE_SHSTK) &&
> 	       (pte_flags(pte) & (_PAGE_RW | _PAGE_DIRTY)) == _PAGE_DIRTY;
> }
> ```
> 
> - The pte has D=1 W=0 so the first half of the pte_write condition is false
> - As the CPU I used for testing has the shstk feature, pte_shstk is true
> - Hence, pte_write is true, which means we will run `entry = pte_mkdirty(entry);` in handle_pte_fault
> - After the fault handler has completed, the write permission is still not granted
> - The PRI request returns a success completion code
> - Device requests the translation again to the IOMMU, and goes back to the first step, trapped forever.
> 
> Note that the second patch you reviewed was masking this behavior as it was preventing the dirty bit from being added to the pte most of the time.
> This is the reason why I fix them in this order o.O

Understood. You may want to refine the commit message slightly. In my
opinion, regardless of any bugs, it's essential to set the dirty bit
only when write permission is granted AND the device requests write access.

If you wish to highlight the specific issue: setting the dirty bit
without the write bit in vIOMMU creates a spoofed shadow stack PTE that
misleads the guest OS. This results in infinite PRI requests from the
device, as no actual write permission is ever granted - the guest OS
treats the PTE as a legitimate shadow stack entry and considers the
permissions already correct.

> On Thu, 2026-03-12 at 11:30 +0800, Yi Liu wrote:
>> On 3/10/26 14:57, CLEMENT MATHIEU--DRIF wrote:
>>
>>> Avoid unintentionally flagging the entry as a shadow stack entry.
>>
>>
>> hmmm. not quite get shadow stack...
>>
>>
>>> In the current implementation, the dirty bit is always set in the pte.
>>> Hence, an ATS device requesting an RW translation for a copy-on-write
>>> page is likely to trigger a PRI request for a region that has just been
>>> marked as dirty by the IOMMU. However, CPUs that support shadow stacks
>>> give special meaning to PTEs reporting W=0 and D=1. Setting these values
>>> can cause PRI requests to complete successfully without granting the
>>> expected write permission, which leads the device to enter an infinite
>>> loop of ATS/PRI requests.
>>
>>
>> appreciate a clearer explanation here.
>>
>>
>>
>>> Fixes: 65c4f0999991 ("intel_iommu: Set accessed and dirty bits during stage-1 translation")
>>> Signed-off-by: Clement Mathieu--Drif <[clement.mathieu--drif@bull.com](mailto:clement.mathieu--drif@bull.com)>
>>> ---
>>>    hw/i386/intel_iommu.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>> index d24ba989bf..56146aafc1 100644
>>> --- a/hw/i386/intel_iommu.c
>>> +++ b/hw/i386/intel_iommu.c
>>> @@ -2066,7 +2066,7 @@ static int vtd_iova_to_fspte(IntelIOMMUState *s, VTDContextEntry *ce,
>>>                return -VTD_FR_FS_PAGING_ENTRY_RSVD;
>>>            }
>>>    
>>> -        if (vtd_is_last_pte(fspte, *fspte_level) && is_write) {
>>> +        if (vtd_is_last_pte(fspte, *fspte_level) && *writes && is_write) {
>>>                flag_ad |= VTD_FS_D;
>>>            }
>>>   
>>
>>
>> the change looks reasonable.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>


