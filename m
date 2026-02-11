Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4736EB271F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 10:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq7cG-0004Yv-Hp; Wed, 11 Feb 2026 05:38:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vq7cF-0004X1-0B
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:38:39 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vq7cC-0001r0-1M
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770806316; x=1802342316;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fnG6J8fztAp/ia0T4fkttYz4e+qB+INo2VdADv6AdP0=;
 b=M125xxDXsncBJ8EoLkkUhcPnT5ORxx6WUMNIqB+9YXqVRkpoxnq3qmWQ
 pUBDdbzt/6PlsOLqDPoTA5ye5NVFaEQP0GzTFmMIKRVBWevlCegofO31Q
 vLitVOETS8EmYYXwgJFpncfg8VRhU8g1/Qc2JeVnhVHMicZ4x3i1nErh1
 2T4lbXmXnxDD6+qeutTRJnK6lzM76CIY5IcZGL5h7lQkHLfVw61JVJyHD
 Qr/eMY4QiaLq+KFJ7YVtK32Obe8k6gKSSm9xl2e+RUTMDr7DT3fR9w+pj
 BVs2TkVPcE+thJ4V4IDkdQGqi5yjUdtVVd8UONynmdX7aQLGprhywDPr/ g==;
X-CSE-ConnectionGUID: 15xW/hVuQUe/hx8iGlHqzA==
X-CSE-MsgGUID: J/AtyeO8Q1OKHy5KEM/52Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="72045928"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="72045928"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 02:38:32 -0800
X-CSE-ConnectionGUID: wohTUCVnQZ2XN4bj0GjX7g==
X-CSE-MsgGUID: 3AKsDS8tTu+qNTY1AooZEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212304477"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 02:38:32 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 02:38:31 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 02:38:31 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 02:38:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNosFNZA3APGFYfl7UXwNvS29tWLoMqDzmNi+d8ksgYBlHE2txHIhu+4zsqgIjXsvh8raU8SrtC7SEW3xHgK7bZL+Ftm0uic38HWZJyCZSc8mGzE4H6h49v1/EjyZKhJsRfuP2zKXl8zueUrcOsDy0JV/IDiVlKaySmAz+ZcwxNIr5G/40E5wXDb2x2SSwTsxSFGuUko8jrNrwt2mVqKTkf0tUs21Ghv7x/8lPZKquA6g2WXriyu1J9wL3evT1DT2QHwbnHy5ZpVU0/0lh95y0lLoITezPG7nhFllf+fWI33X5qzV9k3UWUgKcU7E2UJZyzP3VBImtEmS9QwYa36DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnG6J8fztAp/ia0T4fkttYz4e+qB+INo2VdADv6AdP0=;
 b=xGbpxJNnqtGKF6MGC39JeuwFNqvOr+EoZtGoMPhaciY70Q3d/xT+AuFHFTLsj/BvopZKH+vDK4NzpdxvvuGBCcW1QGtzqBVuXrILvaRtpxgNRpaLyO/clQJZ5WGQiT/CpLzxE8koUTYBXOOyCr3v+K6vZLIwdA/8iojhiSzEQnZnvliEnKpfOjUIfPbofJsB05920R1ndUFnYdQThpXWU2OGDmFJv67GA4KmPD0P7kXk4oRfXSSRpbNtBs9gsMEeLwbJI3ZRuSsk+VpMhNxpYu8e+nhQlnTfvaZnJoZgk2f2iGbWHLpk+7rvVw5OvSt6pyNrq8/fO6O11oryCmKE3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB6774.namprd11.prod.outlook.com (2603:10b6:806:265::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 10:38:28 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 10:38:28 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao,
 Xudong" <xudong.hao@intel.com>
Subject: RE: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach
 callbacks
Thread-Topic: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach
 callbacks
Thread-Index: AQHclk1HGYQZR/NqT0axcOYTjnZUhrV9Qo0AgAAOM0A=
Date: Wed, 11 Feb 2026 10:38:28 +0000
Message-ID: <IA3PR11MB91367D6A321018EE989FA1899263A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-2-zhenzhong.duan@intel.com>
 <CH3PR12MB754856C12CAD98891555C791AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB754856C12CAD98891555C791AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB6774:EE_
x-ms-office365-filtering-correlation-id: 4e153540-4bb1-43cd-92a5-08de6959b157
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?cjJNZ1VKVENkQUg0MDcyNlNUMWRTNDlMV3N0UnBmUlYrdmF1NGdJb1VXSmJn?=
 =?utf-8?B?OElZeGovdUxrenE0OVJON2NpVVE1SGtHbTRHUDlSZFNtMnFLQm9mVDBZODlR?=
 =?utf-8?B?RCsxZUdQb21OWDlKajBNWFQyVE1kQVRJcE1EbUlNVTNlT0VUNGZwZkp6VUQw?=
 =?utf-8?B?SWIyMXdZUWd3bUFqTUlFSzNPNHVvMnRHR3pOOWNRNG9vbVV2ZkpXSVJnTmpK?=
 =?utf-8?B?eU8yUS9EM0g2UVk5OVd6b0JIekZhT09rdmxDZTl1VW5ZSWFiaEoxL0VKdWRS?=
 =?utf-8?B?NjlQRmN6T0NhdjBid1pzYk01N3JhamdBUW5qT0lWTUltcWhjaWJ4VjFKTHdx?=
 =?utf-8?B?VGNYVVVpSFBTSG5xeTRFRWpPRGdicjFlWmkxejR4WjQ1TERycTVEMHh1TGMr?=
 =?utf-8?B?RGRxanJKODNkL2JpOGduT3ZLMlk1TnFhVFU5R1c4YktVazBzSDhKbWhwbmJo?=
 =?utf-8?B?YXlTRXg3L09sL0JTVC9QV2RsR1pyVjZvbFR1ZXdTMi9uYWZuemptWjN4SmE5?=
 =?utf-8?B?Sk9EL3p5UnlGODFCNEtXRWlIbzk1S2JDakdZYjlLa0luajVCSWN6aXBjcE94?=
 =?utf-8?B?L1V0WDJwUWtlVWc0MmtVdThQemtTMEVUMkVMMjJ2cjZwcVNYVnJyamRid3hy?=
 =?utf-8?B?ZGo1VS9XaThzdHJ1VnFRaXZmdmNwUXJ3UENCc2FJZUNZOHh2QzdaRkU2SXVE?=
 =?utf-8?B?dUJWUUxNbndjVk5XS2pmbzRQMi9QdnFqSW1HMnM0QjFJeTBIODdOcGgyYjdQ?=
 =?utf-8?B?QklCZTJ2SnhNb0VpWHpDNXdVQ1VxcDJvWDl5aE04UDlORlNZU0FzTkduUjVV?=
 =?utf-8?B?Q3FtV2dVNXNEdXFnaCtTOTFIWWFaVFp5YUhXZnRlVkRiZHpFQW1maklBdjZO?=
 =?utf-8?B?VmVWU21lZEJkbWhjck04WlllNmMxNDZwQTZ3SER1VzBDU2RoYWh4b3BUZjBF?=
 =?utf-8?B?NmZXUUNFUFpEYm9vekpVSUphcDhnYm9WMjFOV1U0UzNrWGtTQ0xGdzNOM09U?=
 =?utf-8?B?MjJmNzFib2RNVkZuMGtSMEFyTWt2K2xERU1IWDhKKzFLRFNhWW9INktIQkZq?=
 =?utf-8?B?NjNGcFA5bmxYdjVhbFZQWm1BbnlhTU1PRUFuQVhQSGRybnBhd244L1g3WnBz?=
 =?utf-8?B?dXBKcnFyU3FVWkVyS2M1cjVMeWpNU05uMTlaSHVlR0NEdXhEc0k1R21pTzBk?=
 =?utf-8?B?ZnBvaWJvbGtNS2diWUUzU2F1blgrY0NVdUpBOFpldEMxd1EwT29ReCt6RnRE?=
 =?utf-8?B?bUlpZ3djSVQ1WThNL3hzNnhKT1ZNalR1b3BYbzFtS293MUlBaXRyYlZscnhM?=
 =?utf-8?B?OWVCdW9DSW9CcHljUWNNaDNWYmQrdHc0a0paNWFLYk5OTU40a3V3eEt4Mjd5?=
 =?utf-8?B?cEllSlFuWis0T0JvLzZKZUVGSTh1Rk5OQnBEK0prakNrcDhhY2M5a245c1Zu?=
 =?utf-8?B?V2dSWEtFbFlUV3Rpd3VsY2xmSEovTXBMbk8yaVMvT0p1MC9OUVMxUVZFQ2lV?=
 =?utf-8?B?RXhKTmZVNWRERW1ya01rNThZZkNidHNoUnV1eWcvSEdrY0pLV1dFQXNFUHhR?=
 =?utf-8?B?OUhJbGd3cTFxWjJLcFJDNTRnMDE2WFNDNFFJZVVBbWViRndpU2MzSFk5V3Ey?=
 =?utf-8?B?VFJ3ZFhEMUFlMGsrcEozcFlPMUExM0VLY1kvMUVmNzBjWk5mODZ5RlljZGh6?=
 =?utf-8?B?Y3k3WWl5RmdpYlQ0UXg4UHV6d3dkREZNOXpPby9reVBwNm1VRVNMVnhTRy9G?=
 =?utf-8?B?M1pvSWlzbFJnOVlvZzFSKy9Db2Y3dEgzRTJiVlR4SEd2VVBvenZ5RE10OXZT?=
 =?utf-8?B?V0xBVFhDLzFYWTBETjJRWUt4a0ZPSEN5ZlcwQ1ozYkhmOW92NFJLbFQ5VnRM?=
 =?utf-8?B?WlhzUHI5eVNBREl2aVl2V2Jud2F2Z3p2TkU2YzQ1ckxEaDVpbjV0TjA0aHl1?=
 =?utf-8?B?cytQZ2NaTEMvUVQ3Vkc3UE5peEJhUmRBdnppaGtkODRjdWluZmdaRnVJMEs0?=
 =?utf-8?B?djFoRkdSclprMnRPTlMzV0FWeW0zb2ZzL08vaVlLc2s2Q0hWaTNpUXpLMytn?=
 =?utf-8?B?SC83U0c0aS90M3hRNVc0OGhXVnZNYkx6ejF5d3NiMStxZDBpN3ZaeFhCeDNx?=
 =?utf-8?B?QkZBdktYZHNhTGtXbnJXYnF3ZVMyWVVtQlE3TzFqVVN6Sm13SU56M001WXRW?=
 =?utf-8?Q?UgUOR35zdHVRFTEHA1pFeS8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enpVcVlIRmdCSzF5ajdOUUErdGptMklwYUxqTXdEZHNnbGNOcHUxUERobytV?=
 =?utf-8?B?cTU0bXJOUVZXcHdzbnlKNGd1ZllIS2pJRSt4WHlUU0NwNFlmVzRXYmpUMHZv?=
 =?utf-8?B?RXZoWnk1OGtEZVFZSDdkcjlNdHhYc1RmZDlRMDRidmRDNllibFJESjdINHdr?=
 =?utf-8?B?UUJ5TFVwOGtqTUM3YnJUb3hxdlVpWVZQc284Ry9QWEtNZWlzTFNleDVOTlBQ?=
 =?utf-8?B?WTVZRFg4NG55QzExOFYyRmFLRVFIZmJNNHVHelVhdnpGK2RxcWc2b0x0eG5S?=
 =?utf-8?B?U2JZRG9BTDJHNGNTQzFPYmRFYTRLRDRrZ1Ezc09vZGNFQzR3bGp1TWlxT2M0?=
 =?utf-8?B?TnRPUnh6WjFEWDZsMkh5alNMWHBFelZ5eXlmZ09vVTBHbGpjYnBUQlRVRXpZ?=
 =?utf-8?B?ZS9LdG5TUFZiTEpRU2FnZFF5U0VydndEbE5tZHpGanUvZkY3S3EwZE96eGkw?=
 =?utf-8?B?bnZQWFcwbDFYTmU4Z2dhRWgwNGl1SUxveDJFNU8xYWtTUHQ4MFhMOHVVU1Nq?=
 =?utf-8?B?RnZBVEZXZU8wTXRLczdEZHFEdi9TQzRjR2tRSStYeG9mT3NUTEdUNTR2ZUhr?=
 =?utf-8?B?MitlT1kvSmZnQlhjR0NZb25UanJkWXNhVDJoL1hFZHRjSGl5OHB5SlluMWds?=
 =?utf-8?B?WUk0R1AzdjBVVzJtamhHeXlYZnFiQzZZZDcwMmpoclJuNC9uWlViR1BjdFRu?=
 =?utf-8?B?U2NheWQvQlBuYTNXSHBFSXQ5Tm4za1J0Si85d0lNQU4rNjFyb1gvZ0pMVzYy?=
 =?utf-8?B?V0dLeTMydUY1ci9HT1EyVmszWTZOeXRkaFJBVExtOWtSaGd4cFZGT3J2YUNw?=
 =?utf-8?B?UXRzczVTdFRsSGpaVVZSSEVLUUh5TmlWaTUwcjVUYUpVQ0pxb3ZYbTE3ekF4?=
 =?utf-8?B?cmNlU1JrMmRnV2dXc2hGME1JS2Rnc3B1WjRCSDNXam85bFdwRnF5RXJRNnNV?=
 =?utf-8?B?QzBLNTV0ZmV0Zkl4Si92QXQxV0xyTCsxaGZ1WlZKall4Zm45VEhucGdyR3hH?=
 =?utf-8?B?Q0NkRWlRSytYSEd5TDhkSXJpcCs5MHNpMGFreTAwRTRsc1o3RGkzdDEyZkdk?=
 =?utf-8?B?UklOUUFjeUpNVG1NSkJPWGtkalZwNEZMaHF0ZTRjNm9BUnZvTldWZWtJd0Zs?=
 =?utf-8?B?aVR5VTBqU1dwdnVqT1NTc3JsN29VNVBQTU9vVEpiVWh3UEJGNlgzaGlpTm13?=
 =?utf-8?B?THQ0SEpJQ2hCRkZqQ3RxN2g2YnZ6dHlRTTFCeFlNR0hSWW9hT2ptb2krWHdD?=
 =?utf-8?B?MFVEaUxDUEQzdGVhUnVMZ1Zyck01anJuRUp6NnZDbmg3eDNxU0hTWm1za0k5?=
 =?utf-8?B?UFBEVnZLdklkVm5VcGNJMG5iMk9VOFBKVDBNQVUraXg0UVNMR0lZZ0RqcXhk?=
 =?utf-8?B?WjhEYm5mZzV1QjQxd1NnQ1hXRVA3UW5GOG5hU1RPTC9QamhhcnFoZ3JtOE42?=
 =?utf-8?B?TTBVNGFlRkNZUzlLaksxTE9hTzl2MTdMK2JWV1ZqQUNqMW1qWGtmR2pnSGxZ?=
 =?utf-8?B?czBqUS9FMTczd0hVVDh5YVpKZjNwaUErVC8xTXZzZi9mSEdOMWpJcDhvOTMz?=
 =?utf-8?B?UlJTRS94Mk1OUXRTckJhYm5YZm8wckNmK3VwcGpQb1NueFQ2YnBJL0xNTnE4?=
 =?utf-8?B?cW81VEZuaHlnY0JBNnBCMVlGdUhoZHZndnc2S2ZJN1NJSDdxYWJOMHZGMURi?=
 =?utf-8?B?WnUxUElzeHl0Qk9DRmtrbjRTYkZLSEJaeWxhQ2E1VWJ2dDF4TmFTbGtKbU5l?=
 =?utf-8?B?Z3pvZ3YxaGlDd1JyWUlOWDc4d3MxalJWRHMxaEtEL3Q0L3RuUHM3SnNCS1Zn?=
 =?utf-8?B?MGRQZ3dZdDNhcW9QaDdFSGZaL3JHWmdtMkZ2dzhvaC8rWUJwanJScTFwTlBT?=
 =?utf-8?B?OGFRQVJGdm5CcmZJcWw2TGU1VDlFY1QrL3BtWEJ1T0JiSGZ5RDRRZC9TQitw?=
 =?utf-8?B?S2E5ancxcVMvQWFSdlJmcFV4MW1lOUpnV1RJbzdxK2ovWkh6TFNYdjVkNCt1?=
 =?utf-8?B?bFNPSEliQktoeWlFd3lOYVFHaVJySE8xSTFsbTZ1N2lZdzhBUVRvNmVoZ3Np?=
 =?utf-8?B?WHF6R3c4K3ZkYlVMNldjbUl3VnpuUGZvUnhvN0FpcEp0OFZQbzJXaXlhaXVz?=
 =?utf-8?B?TnA0SDJsVGdtTktUTE81WHhGWXIxUlZwR2pSUHNUNjF1Vi9rdk1xRlZHV2hr?=
 =?utf-8?B?OUJQazlHQkFjbS9BWHlCOEVjcXZOUWwwSUtScEFIcEJZZnlpcUpzUmJKRXBx?=
 =?utf-8?B?SDdzdE5aRUhBQ3Mxcm1oWUxtblE4RzNvVTBTcklSMFhraHBJUWk5R2xBVnJj?=
 =?utf-8?B?UGdaOTZGVGNWamdJL0VNSTRKUG95Q2dMM1BxdWJBV29KN0V5M1VuZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e153540-4bb1-43cd-92a5-08de6959b157
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 10:38:28.0658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ErmEgtEqETKPejUXVnM2ASXwyyK8pJ5e8OoE19cYDMk4CaZeE5wr7qgHilisavi4Nw6tNbQaO4tbwOAfAHR+SL6pB/gfjaDlv1trE7wsUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6774
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFNoYW1lZXIgS29sb3RodW0g
VGhvZGkgPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPg0KPlN1YmplY3Q6IFJFOiBbUkZDIFBBVENI
IDAxLzE0XSBiYWNrZW5kcy9pb21tdWZkOiBBZGQgcGFzaWQgYXR0YWNoL2RldGFjaA0KPmNhbGxi
YWNrcw0KPg0KPg0KPg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IFpo
ZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiBTdWJqZWN0OiBbUkZD
IFBBVENIIDAxLzE0XSBiYWNrZW5kcy9pb21tdWZkOiBBZGQgcGFzaWQgYXR0YWNoL2RldGFjaA0K
Pj4gY2FsbGJhY2tzDQo+Pg0KPj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcg
bGlua3Mgb3IgYXR0YWNobWVudHMNCj4+DQo+Pg0KPj4gQWRkIHR3byB3cmFwcGVycyBob3N0X2lv
bW11X2RldmljZV9pb21tdWZkX3Bhc2lkX1thdHxkZV10YWNoX2h3cHQgdG8NCj4+IHdyYXAgdGhl
IHR3byBjYWxsYmFja3MuDQo+Pg0KPj4gVXNlIGFzc2VydCB0byBlbnN1cmUgdGhlIGNvcnJlc3Bv
bmRpbmcgY2FsbGJhY2tzIGV4aXN0Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWku
bC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56
aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGluY2x1ZGUvc3lzdGVtL2lvbW11ZmQu
aCB8IDQwDQo+PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAg
YmFja2VuZHMvaW9tbXVmZC5jICAgICAgIHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysNCj4+
ICAyIGZpbGVzIGNoYW5nZWQsIDYzIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oIGIvaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oDQo+PiBp
bmRleCA4MGQ3MjQ2OWE5Li42MTViZTEwYWVkIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9zeXN0
ZW0vaW9tbXVmZC5oDQo+PiArKysgYi9pbmNsdWRlL3N5c3RlbS9pb21tdWZkLmgNCj4+IEBAIC0x
NDUsMTAgKzE0NSw1MCBAQCBzdHJ1Y3QgSG9zdElPTU1VRGV2aWNlSU9NTVVGRENsYXNzIHsNCj4+
ICAgICAgICogUmV0dXJuczogdHJ1ZSBvbiBzdWNjZXNzLCBmYWxzZSBvbiBmYWlsdXJlLg0KPj4g
ICAgICAgKi8NCj4+ICAgICAgYm9vbCAoKmRldGFjaF9od3B0KShIb3N0SU9NTVVEZXZpY2VJT01N
VUZEICppZGV2LCBFcnJvciAqKmVycnApOw0KPj4gKyAgICAvKioNCj4+ICsgICAgICogQGF0dGFj
aF9od3B0OiBhdHRhY2ggaG9zdCBJT01NVSBkZXZpY2UncyBwYXNpZCB0byBJT01NVUZEDQo+DQo+
cy9AYXR0YWNoX2h3cHQvQHBhc2lkX2F0dGFjaF9od3B0Lw0KDQpPaCwgd2lsbCBmaXgsIG1pc3Nl
ZCBpdCBhZnRlciBjb3B5L3Bhc3Rl8J+Yig0KDQo+DQo+PiBoYXJkd2FyZSBwYWdlDQo+PiArICAg
ICAqIHRhYmxlLiBWRklPIGFuZCBWRFBBIGRldmljZSBjYW4gaGF2ZSBkaWZmZXJlbnQgaW1wbGVt
ZW50YXRpb24uDQo+PiArICAgICAqDQo+PiArICAgICAqIE1hbmRhdG9yeSBjYWxsYmFjay4NCj4N
Cj5UaGlzIGN1cnJlbnRseSBhcHBlYXJzIEludGVsIHNwZWNpZmljIGFuZCBjYWxsaW5nIGl0ICJN
YW5kYXRvcnkiDQo+bWF5IGJlIGNvbmZ1c2luZy4NCg0KU2FtZSBoZXJlLCB3aWxsIGZpeC4NCg0K
PiBIYXZlIHlvdSBjb25zaWRlcmVkIGV4dGVuZGluZyBhdHRhY2hfaHdwdCgpIHRvDQo+dGFrZSBh
IFBBU0lEIGluc3RlYWQgb2YgaW50cm9kdWNpbmcgYSBzZXBhcmF0ZSBjYWxsYmFjaz8NCg0KWWVz
LCBJIGRpZC4gVG8gZXh0ZW5kaW5nIGF0dGFjaC9kZXRhY2hfaHdwdCgpLCB3ZSBuZWVkIHRvIGFk
ZCB0d28NCnBhcmFtZXRlcnMsICJib29sIGhhc19wYXNpZCwgdWludDMyX3QgcGFzaWQiLiBFLmcu
LA0KDQogICAgYm9vbCAoKmF0dGFjaF9od3B0KShIb3N0SU9NTVVEZXZpY2VJT01NVUZEICppZGV2
LA0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGhhc19wYXNp
ZCwgdWludDMyX3QgcGFzaWQsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHVpbnQzMl90IGh3cHRfaWQsIEVycm9yICoqZXJycCk7DQoNCmFuZCByZWZhY3RvciBpb21t
dWZkX2NkZXZfYXR0YWNoL2RldGFjaF9pb2FzX2h3cHQoKSBhIGJpdC4NCg0KSSdtIGZpbmUgZWl0
aGVyIHdheSwgdHdvIHNlcGFyYXRlIGNhbGxiYWNrcyBqdXN0IGxvb2sgY2xlYW5lciBmb3IgbWUu
DQpMZXQgbWUga25vdyBpZiBleHRlbmRpbmcgaXMgcHJlZmVycmVkLg0KDQo+DQo+PiArICAgICAq
DQo+PiArICAgICAqIEBpZGV2OiBob3N0IElPTU1VIGRldmljZSBiYWNrZWQgYnkgSU9NTVVGRCBi
YWNrZW5kLg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBAcGFzaWQ6IHBhc2lkIG9mIGhvc3QgSU9N
TVUgZGV2aWNlLg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBAaHdwdF9pZDogSUQgb2YgSU9NTVVG
RCBoYXJkd2FyZSBwYWdlIHRhYmxlLg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBAZXJycDogcGFz
cyBhbiBFcnJvciBvdXQgd2hlbiBhdHRhY2htZW50IGZhaWxzLg0KPj4gKyAgICAgKg0KPj4gKyAg
ICAgKiBSZXR1cm5zOiB0cnVlIG9uIHN1Y2Nlc3MsIGZhbHNlIG9uIGZhaWx1cmUuDQo+PiArICAg
ICAqLw0KPj4gKyAgICBib29sICgqcGFzaWRfYXR0YWNoX2h3cHQpKEhvc3RJT01NVURldmljZUlP
TU1VRkQgKmlkZXYsIHVpbnQzMl90DQo+PiBwYXNpZCwNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1aW50MzJfdCBod3B0X2lkLCBFcnJvciAqKmVycnApOw0KPj4gKyAgICAvKioN
Cj4+ICsgICAgICogQGRldGFjaF9od3B0OiBkZXRhY2ggaG9zdCBJT01NVSBkZXZpY2UncyBmcm9t
IElPTU1VRkQgaGFyZHdhcmUNCj4NCj5zL0BkZXRhY2hfaHdwdC9AcGFzaWRfZGV0YWNoX2h3cHQv
DQo+DQo+QWxzbyBjb21tZW50IG5lZWRzIHVwZGF0ZT8NCg0KWWVzLCB3aWxsIGZpeCB0aGF0Lg0K
DQpUaGFua3MNClpoZW56aG9uZw0K

