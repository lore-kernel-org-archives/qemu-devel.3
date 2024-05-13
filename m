Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644CBC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Svg-000234-GK; Mon, 13 May 2024 06:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6SvY-00020c-D9
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:29:04 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6SvV-0001Xo-Ce
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715596142; x=1747132142;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iP0W/GgOFWpkouseh3pbWEwvuEbmPqAGpbRpjrXAVdA=;
 b=Cf72bgoTcDzJxpWED4qatoI627jYVnF8UeYjyCy22kVCEJoTSIs+GyCh
 /33BGUaQRKS7D4X2zMwpZwjroamGhZU49PRajJYGK79LkEtNHBeQOBmIF
 FK64/8M4ioQFM92iWko0/KWoc5J6XoK7aZQcj8Y9zHx67nXT3qzmavSzr
 H0OJNQCbAq6RUbXmpwXnSKj8hFfurKKGv3fEBJ+jSJQk/ito/AH8POeQa
 bYZrj/U5BtHds30jq5zQ/wX2o6yFtTEgcrxxuNJTb1TEk8TKnUw8Q4Q1V
 8ukVdbOJCS8zb0x/iIj/ABt8nbKmQAYvgyqIS9vdxuf2a4fMA35uNVzZ7 A==;
X-CSE-ConnectionGUID: EuPLrvgHSviHLGRfXMCY3g==
X-CSE-MsgGUID: 1ck9jMqeR5WqhiAY6sRj2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="22928819"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; d="scan'208";a="22928819"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2024 03:28:57 -0700
X-CSE-ConnectionGUID: NKfkfhQUTRCQrrZX0s6svQ==
X-CSE-MsgGUID: /kqTbgDGSDGjrdxIOMsgKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; d="scan'208";a="53516639"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 May 2024 03:28:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 13 May 2024 03:28:55 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 13 May 2024 03:28:55 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 03:28:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJFGhcm1tHd3d40umBwsvBNhZqCzhaxGRVC3uanrWbXbqSdTucKGVBNUqpWPespAZjK+RlOrAhDQi6mM0dt1pWdRAEr4cFYGk9i3wFW66pZc3tRYn0A34M/yxU2VmwT8rNDQbnVaEapOp8tjG7FugnjeZL6ol6AYMps571THo4L4YeaJfw6rOsKtsLIsh71DOtFZ0UD9y3SFwVwsiMckJ89kGMpXYkpFeTa5WSBiGA1zPGh+PE7WxV9VuSOWoo04t+y9ES+v5WRRZB6p/9VCjz1uMlShbLsl1U3JytNge7xXJojsfaE9Qz9lQEMWuz0PKrtiIhIU+1KMewAAmdYYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iP0W/GgOFWpkouseh3pbWEwvuEbmPqAGpbRpjrXAVdA=;
 b=I+oFJ4EyF9NCzLchER0h0aoBLpPagL8i4N4XbK/KjRQ9gtlSuWmMSp10h6iDcAOVeds7Whnb/FSsqklMHYyg8V5hvyQENqbXMxY6XiY9MT9uwxLoDHS8+VfsYtnl1XZhvYFdHa/b/iPihtVOvKDJP5U3bCG2CMU6W6lGogeQ+l326oOP6A7sr18NXdw3B+iuDLRSddj2E5RXB08Z2MaEs5fbq5ZxIveNx3QBGy9FaQ95QiuqYG4gsqpWilbqHazilUcSNdP+5gHkW3XHCXxSnwsKERQtjNKcr3LTFiLRNQyj7y1xCZlLSF4DxBlxvQgKUEImpDCna/p5wKgA4JiNrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ1PR11MB6107.namprd11.prod.outlook.com (2603:10b6:a03:48a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 10:28:51 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 10:28:51 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [PATCH v5 01/19] backends: Introduce HostIOMMUDevice abstract
Thread-Topic: [PATCH v5 01/19] backends: Introduce HostIOMMUDevice abstract
Thread-Index: AQHaoScc+JbWsWqLKUWgf7FG6s/jBrGU7eyAgAAEbAA=
Date: Mon, 13 May 2024 10:28:51 +0000
Message-ID: <SJ0PR11MB6744EEBF525D7057D396A09292E22@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240508090354.1815561-1-zhenzhong.duan@intel.com>
 <20240508090354.1815561-2-zhenzhong.duan@intel.com>
 <0134a4f2-5a88-42d3-bcb7-f309a0dd62e5@redhat.com>
In-Reply-To: <0134a4f2-5a88-42d3-bcb7-f309a0dd62e5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ1PR11MB6107:EE_
x-ms-office365-filtering-correlation-id: 68f5d1e2-7ca1-467d-d33f-08dc73377b8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|7416005|1800799015|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?SGxYQUJ2cWp0MDBQaVRtNTgrZ2Rsa21HeXNXb21iYmRTemVySlNCU25Ua3Rx?=
 =?utf-8?B?ZXhMV0RHSTRVRVpOajYvUVAvUEN2OGpSQ2RrdEFFUndJbHB6b1ZqNHVNdUdQ?=
 =?utf-8?B?SXVGV3k3UkxWUWZRK25xRnNiWGJuNWdIVDk0NHBJVW9naW9uK3RDTHQxMVZr?=
 =?utf-8?B?a04xMm9WclF3dEtQbGpsanc2YW5nc2RYR2FQYlhFc2ZsdUpKK09Nc2NXcnky?=
 =?utf-8?B?RGIvSFlienN5Z3BWK3NTcTExMWU3TFZjeHd2L2hOZHFtVEFsVEl0b1FacXJK?=
 =?utf-8?B?SVlmc2lYdTFhY25aVDhvVktwNHJLL3VPWXJtOXA3Rmd4d005enlOUmRkaDd4?=
 =?utf-8?B?SnFwWmhUSzliZk9BUWV2alhOMmxUTktDa0dpeENkMjNldHJURUg2WmxxdXpV?=
 =?utf-8?B?UWtGYnNmREJrY3REV0l2eCtmeXAzWDNFdWhjdkxVQlhNYnhUOVlHY3VtK2dG?=
 =?utf-8?B?YUEzcC9JQmtTNHE5QmhhQjM2YTd4L2lvK1AzcE1hWVB6NDc4L2RSNGpmR08z?=
 =?utf-8?B?amhnM1dlcnM5ck52U25xc0VYWENIVnVmYStwQWxRYTJ4S0QvbzZLZE1jL2RG?=
 =?utf-8?B?VEdjeklsZ2JLSitoUi9uM0xiV1h0MVo1ajVZRXVveDc1S0NaelRkcExMUTdy?=
 =?utf-8?B?TEhLWGg0RisvVk5IM0ZDT2crUThMWXJSSm4xc20xSkJrOFJaRXgvTEgyNUll?=
 =?utf-8?B?cXgwQnZsWjVKeTBPMm5KNEJXNmZCNXJIV0QyT2JuR2tzcGpUNG9nK3VWZGRJ?=
 =?utf-8?B?bm1kMUNQZkxJQ0l4ZENUcUplSW9GNWpoRHkzUkdORUptVEhWcXVaLzhDdkN3?=
 =?utf-8?B?NUdRRUU3UzdEQ1ozRzgzRkoyWGFNc3hYTTM4eTdmT2oyMnFVbG5VTmF5NnA4?=
 =?utf-8?B?MGRNYjhNTFhtTkd3R1NldTNZTGkzdHhoeGh6M0RzZXRZa3k5M2RCbCs5bElm?=
 =?utf-8?B?M1l3Y1lPb1FyTXdTcWtCNitZQlJJRnQ1VXJvMyt2UWs2Vi8raGdOWWZGUW03?=
 =?utf-8?B?SnVpSGZtckhmQm1ZRVBOcjRHblBaamJMQ0tGaVFrVEdEU2ducUw3dXVCM2VD?=
 =?utf-8?B?UEVUUGdEVFNYdHd3SnR6enMrZXBZbUtiYlhQNjF4cWo1YU9xb0R3b3JNaUc4?=
 =?utf-8?B?Zklyc09ad3ZZZC9NMEkrSGh3RFY1L3pmWTJ0WG1mZk1FSy9UQVRwbmwrRGNM?=
 =?utf-8?B?empZVEhjWnpyNmpDd0Nlczd4K3hLWkxyV3JIWk1Lb2pOMGVLNXVFSlJQZE5x?=
 =?utf-8?B?Y2xWQ0MxVFJtdUJWTzU1SGowYnV4UzFQWmlpLzdLYjcxTElTMkNvNkJhb3Bh?=
 =?utf-8?B?TnNVbllENld4UmU3dGdjSS96ZWhsVXViR0x6RHVWM0ZNeG9yTE81VDVKRmxF?=
 =?utf-8?B?TGkzcXNKY0Jsem5JdFAyTlZiNmY0M0pqL1RCWHJmQmI3YVc5VUpvaElHTGtw?=
 =?utf-8?B?NS8zVmt5Y2lXaEEwcVcvV3NPVXFiaGFSaDR0bmg1MzNxZmFodVhhVkJnbzVP?=
 =?utf-8?B?OUdxREdMVU4rNVJheUpRRjBoOXdDVGJsVTFsV3hza1VQZzE0anpUR1RqcEYy?=
 =?utf-8?B?ajZtcGVuMjVLTzNndkxFRDVwQkFacGZEbGg2TVM2ZFZGRG1aTnJYK09vclF4?=
 =?utf-8?B?bnN0S0N4SHJWMUttRThYSFBOOXFiTk9sRlJTSEl6QUUrV0xiYllpWm5tM3ls?=
 =?utf-8?B?Qm1vK29BM3VsQ2xNV2VkYmZHcnB0V1NqOE03Tlh2aE9ud2dUc1E4L0JZUUsw?=
 =?utf-8?B?eGlNeGNQSWViRW1TNWRscTYvbU9KWkZtR0k0OExJNmhYMmpOdklVNnIvbFpy?=
 =?utf-8?B?bHdNR25uR3dtNWdFTHJkUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2hncmVEeEFWT3RPZjZLSENxNGVBdVUxeUpUY0xCODFJS25lTDdPcHJuSUJh?=
 =?utf-8?B?aDIwcnlXdlRVcm1KNE9Oa2prOVMrb1JkdEdPazgrZzBnSGxPa1lWVDRGNG9P?=
 =?utf-8?B?TWdiSGk4RktnNDUwOEpVdHVtNXRPK21JS1R6WXZkNHFNTTByV3BsR2F1a1Nn?=
 =?utf-8?B?cm0yL0x1Rmx5MHgvZGV6ZHRWZ2tqSWhPU2ZVVFJtMjV0L2d4MTNGZENONWwy?=
 =?utf-8?B?aEQwNUNDdWR5MmRpUW9CVnhsZldDSDhLVzRkdXhFK2V5Vk5mTko3K2lOVWJX?=
 =?utf-8?B?OGdwUFMzVEZjaWpOTk55ZjVBSml5Ym1FVkhDbzd6Qm85NnZIS1dyZWlKUXBK?=
 =?utf-8?B?Q3ZUUFNuV0tNZVpPT1JydWtVYnBQWHNVWGV1S0EzZkZWaHlVUFdQcjBoN2ZQ?=
 =?utf-8?B?NUhBQ2dtYW5FMk1Fb0dDRW5velY2QVd3b2puajdYekd6NkhOVWJkUWh6ZjU2?=
 =?utf-8?B?eXYwTTc3V0ozcWFEK0hUYWp0VmV4QjIzTGZaNGVEMWMwTDFXY0hKRm1ST2Qx?=
 =?utf-8?B?cjBQd1g4STB0MzRWREtMcUR2T0RTWjBWdXFuZTNoYjNPRDhMbThoK3I1eEMr?=
 =?utf-8?B?bEdaWGN0TlFmb1ZoQnRXNmFHTE5VUlFJSEdZazE5dU0xYnFOTnVQMUdEZWZ6?=
 =?utf-8?B?M1lENEk5UVl3MG50ZElPeS9Kb0tVRVZEWE43TCtnZjloMjJnajYrUnBwYUtt?=
 =?utf-8?B?QXB6NmpkeWhYOVJtSjlySWNlRlZ6UllrVWF2S0hBbm80NFcybzdmQ2RvNHhZ?=
 =?utf-8?B?Z3VjeGwzZGNxbkhJZ2VCb2I0R3BzSG1CWTB5bC85aFZGdGpQQWFnTTh2eVZQ?=
 =?utf-8?B?NVhFUHhFalpZcEJWL0V2MkcwZHBEQ1NEZ1lPSGZjRmYvNjhvUXhPUzRmSEY0?=
 =?utf-8?B?TklQYkdLOFNCcE5nZUUrTVdSWVl1Q1hnL0Q0eS8welRVTGdhc2dVU0IyNDJ4?=
 =?utf-8?B?Z0JVV3A4YVV0NG1LQTNoQkxKczJEUGtGbC9NUng4VkFRTnNnRHltUFRwd2ZF?=
 =?utf-8?B?VTR5ZzhKUjZkN2tTdzhhd2RIT3RidEd1ZWNtNTQ3U0p3L0l4UGRuZVdURUY4?=
 =?utf-8?B?SXFEM0JKdDFNR2htdE5UVzhvenkzeVEyVUQvcmNFcVhyQUhUSVpQLzltWWhv?=
 =?utf-8?B?eStTQ3l6dHNObU40cmZCaDEyeTBtQ3ZKcjdQUjFJVTNkbVg1MzBHWjNjbFpN?=
 =?utf-8?B?R004cmhIRnk0TThLU1Y2Y1dMMDRVQndTcGZabXZZSzYxM08wdEV2NTdJV0pQ?=
 =?utf-8?B?SnQ3N0pHNE9YbUQrUHpFbmlUSWpwdldsMEExcGtXMENzMWVMZWFHcVFCdlNF?=
 =?utf-8?B?ZXlVdjZ0RVlWSkcvcTlRT2E4M2haWlY2Q3p3SldhNlJ6YUVDWU5sZ2JHT0Zi?=
 =?utf-8?B?U0tMTHlLT2pKUmp0SzVUOWJFWm9Ob0RyZGNBRDYwdURPKzJEaDY3cUNKbkdB?=
 =?utf-8?B?Y2ZjVVhadkJDSjF4TW83YW5YcjMydkE3S2VHalp3SU9TcStGbUFjOXRVcEt4?=
 =?utf-8?B?cGt6L3lGNFk4VkpMSVJhQ0hnTHJuZXlMaGZSRXhJNXpyR05hT0xzaG9FdHFL?=
 =?utf-8?B?MGM0MUk4VWlCQzJ0eXk4WmduZzg2c1pHVkR0Zzc2a1FBRWp3M0NrdXRYSndW?=
 =?utf-8?B?TUYrbStoN1ErTTJTUDJIL0FPUnhRK3RGZitwNTl4UHZuUklRdzNTb080cnkr?=
 =?utf-8?B?Tm1CYzVsa1BqeW9TNDZOUzRVRVJuTVYyWHRKb0hJY3RYZ2RsZXNnVTJoZ1Az?=
 =?utf-8?B?LzFwK3J6Rm0vbEJGVHlnRlFPNDlob0FYOVpUaFJlUnU4a3dkeUdpRkw2Y1ZX?=
 =?utf-8?B?a01Zbm11Rmk2RHJKbzZSM1hCSURLOEw0KzJ0Y3NxS2ljTEx3cUVFblZXR1Ju?=
 =?utf-8?B?eE0vMC8xWUJiQ0duVHJxK25RVE9FV3I2UjdzWTdJbVk4QTA4bGYvM2I5MW51?=
 =?utf-8?B?RXRZRkdRSDlHUlNabndmekdUMnJFWGZvSlRTWDVIbHJrSVRrSzJEWXhLT2pF?=
 =?utf-8?B?cHM0N1RFaCtwblZMN1RlN1NRWFpBNnBGMVJQVXFLNVZ6RUxjc0lCUWtvUzQz?=
 =?utf-8?B?RCsyU2k3eVFpdTJ2cjVPVlJTSXMvRnJGMEsxZFhVWjRGKzY3QzBIdFArYTgv?=
 =?utf-8?Q?G+FiSPERL4zKYw4XwjUY95zZ5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f5d1e2-7ca1-467d-d33f-08dc73377b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 10:28:51.2828 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 48eKCjZd/Q3JhUzdkJB6FxdFI472NiGegPct+iBUKPcwdBN6kPezaG6+7xJh93Yamu/5C6JjugLdS4nm+pxtfzw0oC1gtepp/9Xngk31nGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6107
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDEv
MTldIGJhY2tlbmRzOiBJbnRyb2R1Y2UgSG9zdElPTU1VRGV2aWNlDQo+YWJzdHJhY3QNCj4NCj5I
ZWxsbyBaaGVuemhvbmcsDQo+DQo+T24gNS84LzI0IDExOjAzLCBaaGVuemhvbmcgRHVhbiB3cm90
ZToNCj4+IEludHJvZHVjZSBIb3N0SU9NTVVEZXZpY2UgYXMgYW4gYWJzdHJhY3Rpb24gb2YgaG9z
dCBJT01NVSBkZXZpY2UuDQo+Pg0KPj4gSW50cm9kdWNlIC5yZWFsaXplKCkgdG8gaW5pdGlhbGl6
ZSBIb3N0SU9NTVVEZXZpY2UgZnVydGhlciBhZnRlcg0KPj4gaW5zdGFuY2UgaW5pdC4NCj4+DQo+
PiBJbnRyb2R1Y2UgYSBtYWNybyBDT05GSUdfSE9TVF9JT01NVV9ERVZJQ0UgdG8gZGVmaW5lIHRo
ZSB1c2FnZQ0KPj4gZm9yIFZGSU8sIGFuZCBWRFBBIGluIHRoZSBmdXR1cmUuDQo+DQo+VGhpcyBs
b29rcyBsaWtlIGEgd2F5IHRvIHdvcmsgYXJvdW5kIHNvbWUgb3RoZXIgcHJvYmxlbSwgbGlrZQ0K
PmF2b2lkaW5nIGV4cG9zaW5nIExpbnV4IGRlZmluaXRpb25zIG9uIHdpbmRvd3MgYnVpbGQuDQoN
ClllcywgSSBoYXZlIHVzZWQgdGhpcyBNQUNSTyBpbiBwYXRjaDE5IHRvIGZpeCBidWlsZCBmYWls
dXJlIG9uIHdpbmRvd3MuDQpBbHNvIG5lZWQgY2hhbmdlIEhvc3RJT01NVURldmljZUNhcHM6OnR5
cGUgdG8gYmUgdWludDMyX3QgdHlwZS4NCg0KPg0KPlRoYW5rcywNCj4NCj5DLg0KPg0KPg0KPg0K
Pg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29t
Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVs
LmNvbT4NCj4+IC0tLQ0KPj4gICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDIgKysNCj4+ICAgaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaCB8IDUxDQo+Kysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIGJhY2tlbmRzL2hvc3RfaW9tbXVfZGV2
aWNlLmMgICAgICAgfCAzMCArKysrKysrKysrKysrKysrKysNCj4+ICAgYmFja2VuZHMvS2NvbmZp
ZyAgICAgICAgICAgICAgICAgICB8ICA1ICsrKw0KPj4gICBiYWNrZW5kcy9tZXNvbi5idWlsZCAg
ICAgICAgICAgICAgIHwgIDEgKw0KPj4gICA1IGZpbGVzIGNoYW5nZWQsIDg5IGluc2VydGlvbnMo
KykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2
aWNlLmgNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGJhY2tlbmRzL2hvc3RfaW9tbXVfZGV2aWNl
LmMNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPj4gaW5k
ZXggODQzOTE3NzdkYi4uNWRhYjYwYmQwNCAxMDA2NDQNCj4+IC0tLSBhL01BSU5UQUlORVJTDQo+
PiArKysgYi9NQUlOVEFJTkVSUw0KPj4gQEAgLTIxOTEsNiArMjE5MSw4IEBAIE06IFpoZW56aG9u
ZyBEdWFuDQo+PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+ICAgUzogU3VwcG9ydGVkDQo+
PiAgIEY6IGJhY2tlbmRzL2lvbW11ZmQuYw0KPj4gICBGOiBpbmNsdWRlL3N5c2VtdS9pb21tdWZk
LmgNCj4+ICtGOiBiYWNrZW5kcy9ob3N0X2lvbW11X2RldmljZS5jDQo+PiArRjogaW5jbHVkZS9z
eXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaA0KPj4gICBGOiBpbmNsdWRlL3FlbXUvY2hhcmRldl9v
cGVuLmgNCj4+ICAgRjogdXRpbC9jaGFyZGV2X29wZW4uYw0KPj4gICBGOiBkb2NzL2RldmVsL3Zm
aW8taW9tbXVmZC5yc3QNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11
X2RldmljZS5oDQo+Yi9pbmNsdWRlL3N5c2VtdS9ob3N0X2lvbW11X2RldmljZS5oDQo+PiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMC4uMmI1OGE5NGQ2Mg0KPj4gLS0t
IC9kZXYvbnVsbA0KPj4gKysrIGIvaW5jbHVkZS9zeXNlbXUvaG9zdF9pb21tdV9kZXZpY2UuaA0K
Pj4gQEAgLTAsMCArMSw1MSBAQA0KPj4gKy8qDQo+PiArICogSG9zdCBJT01NVSBkZXZpY2UgYWJz
dHJhY3QgZGVjbGFyYXRpb24NCj4+ICsgKg0KPj4gKyAqIENvcHlyaWdodCAoQykgMjAyNCBJbnRl
bCBDb3Jwb3JhdGlvbi4NCj4+ICsgKg0KPj4gKyAqIEF1dGhvcnM6IFpoZW56aG9uZyBEdWFuIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiArICoNCj4+ICsgKiBUaGlzIHdvcmsgaXMgbGlj
ZW5zZWQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR1BMLCB2ZXJzaW9uIDIuICBTZWUNCj4+
ICsgKiB0aGUgQ09QWUlORyBmaWxlIGluIHRoZSB0b3AtbGV2ZWwgZGlyZWN0b3J5Lg0KPj4gKyAq
Lw0KPj4gKw0KPj4gKyNpZm5kZWYgSE9TVF9JT01NVV9ERVZJQ0VfSA0KPj4gKyNkZWZpbmUgSE9T
VF9JT01NVV9ERVZJQ0VfSA0KPj4gKw0KPj4gKyNpbmNsdWRlICJxb20vb2JqZWN0LmgiDQo+PiAr
I2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCj4+ICsNCj4+ICsjZGVmaW5lIFRZUEVfSE9TVF9JT01N
VV9ERVZJQ0UgImhvc3QtaW9tbXUtZGV2aWNlIg0KPj4gK09CSkVDVF9ERUNMQVJFX1RZUEUoSG9z
dElPTU1VRGV2aWNlLCBIb3N0SU9NTVVEZXZpY2VDbGFzcywNCj5IT1NUX0lPTU1VX0RFVklDRSkN
Cj4+ICsNCj4+ICtzdHJ1Y3QgSG9zdElPTU1VRGV2aWNlIHsNCj4+ICsgICAgT2JqZWN0IHBhcmVu
dF9vYmo7DQo+PiArfTsNCj4+ICsNCj4+ICsvKioNCj4+ICsgKiBzdHJ1Y3QgSG9zdElPTU1VRGV2
aWNlQ2xhc3MgLSBUaGUgYmFzZSBjbGFzcyBmb3IgYWxsIGhvc3QgSU9NTVUNCj5kZXZpY2VzLg0K
Pj4gKyAqDQo+PiArICogRGlmZmVyZW50IHR5cGUgb2YgaG9zdCBkZXZpY2VzIChlLmcuLCBWRklP
IG9yIFZEUEEgZGV2aWNlKSBvciBkZXZpY2VzDQo+PiArICogd2l0aCBkaWZmZXJlbnQgYmFja2Vu
ZCAoZS5nLiwgVkZJTyBsZWdhY3kgY29udGFpbmVyIG9yIElPTU1VRkQNCj5iYWNrZW5kKQ0KPj4g
KyAqIGNhbiBoYXZlIGRpZmZlcmVudCBzdWItY2xhc3Nlcy4NCj4+ICsgKi8NCj4+ICtzdHJ1Y3Qg
SG9zdElPTU1VRGV2aWNlQ2xhc3Mgew0KPj4gKyAgICBPYmplY3RDbGFzcyBwYXJlbnRfY2xhc3M7
DQo+PiArDQo+PiArICAgIC8qKg0KPj4gKyAgICAgKiBAcmVhbGl6ZTogaW5pdGlhbGl6ZSBob3N0
IElPTU1VIGRldmljZSBpbnN0YW5jZSBmdXJ0aGVyLg0KPj4gKyAgICAgKg0KPj4gKyAgICAgKiBN
YW5kYXRvcnkgY2FsbGJhY2suDQo+PiArICAgICAqDQo+PiArICAgICAqIEBoaW9kOiBwb2ludGVy
IHRvIGEgaG9zdCBJT01NVSBkZXZpY2UgaW5zdGFuY2UuDQo+PiArICAgICAqDQo+PiArICAgICAq
IEBvcGFxdWU6IHBvaW50ZXIgdG8gYWdlbnQgZGV2aWNlIG9mIHRoaXMgaG9zdCBJT01NVSBkZXZp
Y2UsDQo+PiArICAgICAqICAgICAgICAgIGkuZS4sIGZvciBWRklPLCBwb2ludGVyIHRvIFZGSU9E
ZXZpY2UNCj4+ICsgICAgICoNCj4+ICsgICAgICogQGVycnA6IHBhc3MgYW4gRXJyb3Igb3V0IHdo
ZW4gcmVhbGl6ZSBmYWlscy4NCj4+ICsgICAgICoNCj4+ICsgICAgICogUmV0dXJuczogdHJ1ZSBv
biBzdWNjZXNzLCBmYWxzZSBvbiBmYWlsdXJlLg0KPj4gKyAgICAgKi8NCj4+ICsgICAgYm9vbCAo
KnJlYWxpemUpKEhvc3RJT01NVURldmljZSAqaGlvZCwgdm9pZCAqb3BhcXVlLCBFcnJvciAqKmVy
cnApOw0KPj4gK307DQo+PiArI2VuZGlmDQo+PiBkaWZmIC0tZ2l0IGEvYmFja2VuZHMvaG9zdF9p
b21tdV9kZXZpY2UuYw0KPmIvYmFja2VuZHMvaG9zdF9pb21tdV9kZXZpY2UuYw0KPj4gbmV3IGZp
bGUgbW9kZSAxMDA2NDQNCj4+IGluZGV4IDAwMDAwMDAwMDAuLjQxZjJmZGNlMjANCj4+IC0tLSAv
ZGV2L251bGwNCj4+ICsrKyBiL2JhY2tlbmRzL2hvc3RfaW9tbXVfZGV2aWNlLmMNCj4+IEBAIC0w
LDAgKzEsMzAgQEANCj4+ICsvKg0KPj4gKyAqIEhvc3QgSU9NTVUgZGV2aWNlIGFic3RyYWN0DQo+
PiArICoNCj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjQgSW50ZWwgQ29ycG9yYXRpb24uDQo+PiAr
ICoNCj4+ICsgKiBBdXRob3JzOiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwu
Y29tPg0KPj4gKyAqDQo+PiArICogVGhpcyB3b3JrIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSB0ZXJt
cyBvZiB0aGUgR05VIEdQTCwgdmVyc2lvbiAyLiAgU2VlDQo+PiArICogdGhlIENPUFlJTkcgZmls
ZSBpbiB0aGUgdG9wLWxldmVsIGRpcmVjdG9yeS4NCj4+ICsgKi8NCj4+ICsNCj4+ICsjaW5jbHVk
ZSAicWVtdS9vc2RlcC5oIg0KPj4gKyNpbmNsdWRlICJzeXNlbXUvaG9zdF9pb21tdV9kZXZpY2Uu
aCINCj4+ICsNCj4+ICtPQkpFQ1RfREVGSU5FX0FCU1RSQUNUX1RZUEUoSG9zdElPTU1VRGV2aWNl
LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBob3N0X2lvbW11X2RldmljZSwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgSE9TVF9JT01NVV9ERVZJQ0UsDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE9CSkVDVCkNCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBo
b3N0X2lvbW11X2RldmljZV9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywgdm9pZCAqZGF0YSkN
Cj4+ICt7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIGhvc3RfaW9tbXVfZGV2aWNlX2lu
aXQoT2JqZWN0ICpvYmopDQo+PiArew0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCBob3N0
X2lvbW11X2RldmljZV9maW5hbGl6ZShPYmplY3QgKm9iaikNCj4+ICt7DQo+PiArfQ0KPj4gZGlm
ZiAtLWdpdCBhL2JhY2tlbmRzL0tjb25maWcgYi9iYWNrZW5kcy9LY29uZmlnDQo+PiBpbmRleCAy
Y2IyM2Y2MmZhLi4zNGFiMjllOTk0IDEwMDY0NA0KPj4gLS0tIGEvYmFja2VuZHMvS2NvbmZpZw0K
Pj4gKysrIGIvYmFja2VuZHMvS2NvbmZpZw0KPj4gQEAgLTMsMyArMyw4IEBAIHNvdXJjZSB0cG0v
S2NvbmZpZw0KPj4gICBjb25maWcgSU9NTVVGRA0KPj4gICAgICAgYm9vbA0KPj4gICAgICAgZGVw
ZW5kcyBvbiBWRklPDQo+PiArDQo+PiArY29uZmlnIEhPU1RfSU9NTVVfREVWSUNFDQo+PiArICAg
IGJvb2wNCj4+ICsgICAgZGVmYXVsdCB5DQo+PiArICAgIGRlcGVuZHMgb24gVkZJTw0KPj4gZGlm
ZiAtLWdpdCBhL2JhY2tlbmRzL21lc29uLmJ1aWxkIGIvYmFja2VuZHMvbWVzb24uYnVpbGQNCj4+
IGluZGV4IDhiMmIxMTE0OTcuLjJlOTc1ZDY0MWUgMTAwNjQ0DQo+PiAtLS0gYS9iYWNrZW5kcy9t
ZXNvbi5idWlsZA0KPj4gKysrIGIvYmFja2VuZHMvbWVzb24uYnVpbGQNCj4+IEBAIC0yNSw2ICsy
NSw3IEBAIGlmIGhhdmVfdmhvc3RfdXNlcg0KPj4gICBlbmRpZg0KPj4gICBzeXN0ZW1fc3MuYWRk
KHdoZW46ICdDT05GSUdfVklSVElPX0NSWVBUTycsIGlmX3RydWU6IGZpbGVzKCdjcnlwdG9kZXYt
DQo+dmhvc3QuYycpKQ0KPj4gICBzeXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfSU9NTVVGRCcs
IGlmX3RydWU6IGZpbGVzKCdpb21tdWZkLmMnKSkNCj4+ICtzeXN0ZW1fc3MuYWRkKHdoZW46ICdD
T05GSUdfSE9TVF9JT01NVV9ERVZJQ0UnLCBpZl90cnVlOg0KPmZpbGVzKCdob3N0X2lvbW11X2Rl
dmljZS5jJykpDQo+DQo+RXVoLiBXaHkgaXMgdGhhdCA/DQoNClRyaWVkIHRvIHJlZHVjZSBxZW11
IGJpbmFyeSBzaXplIGEgYml0Lg0KV2hlbiBDT05GSUdfVkZJTz1uIHN1Y2ggYXMgb24gd2luZG93
cywgIENPTkZJR19IT1NUX0lPTU1VX0RFVklDRT1uLg0KVGhlcmUgaXMgbm8gdXNlciBvZiBob3N0
X2lvbW11X2RldmljZS5jLCBzbyBubyBuZWVkIHRvIGJ1aWxkIGl0Lg0KQnV0IHRoaXMgd2F5IG5l
ZWQgdG8gYWRkICcjaWZkZWYgQ09ORklHX0hPU1RfSU9NTVVfREVWSUNFJyBpbiB2dGRfY2hlY2tf
aGRldigpIGluIGludGVsX2lvbW11LmMuDQoNClRoZSBvdGhlciB3YXkgaXMgdG8gZHJvcCB0aGlz
IGJ1aWxkIGNvbmZpZ3VyYXRpb24sIHRoZW4gdGhlcmUgaXMgbm8gbmVlZCB0byBhZGQgJyNpZmRl
ZiBDT05GSUdfSE9TVF9JT01NVV9ERVZJQ0UnIGluIHZ0ZF9jaGVja19oZGV2KCkgaW4gaW50ZWxf
aW9tbXUuYywgYmVjYXVzZQ0KaG9zdF9pb21tdV9kZXZpY2UuYyBpcyBhbHdheXMgYnVpbHQuDQoN
ClRoaXMgc2VyaWVzIHdvcmtzIGluIDFzdCB3YXksIEkgY2FuIGNoYW5nZSB0byAybmQgd2F5IGlm
IHlvdSBwcmVmZXIuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCg0KDQo=

