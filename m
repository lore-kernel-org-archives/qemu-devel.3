Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BA6D1CA31
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 06:04:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8CfQ-0007Br-6s; Tue, 05 Nov 2024 01:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t8CfO-0007AT-L5
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:03:50 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t8CfM-00075J-DT
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 01:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730786628; x=1762322628;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=B3rFTW+tM/8OI40K8JMBt45kduzlLpNrRzpl8jNp9m8=;
 b=m1CtUwIV0M2t1sCCbhS+xiOnOw7Z1k9Z+s74eir6PpZ5xRA4vb7bQKHo
 nnnlraRpRcd56ikEaXDTq2cQJIjCvhpTcuoUhcE9Vy6u2ep57O3EfLEMh
 1XBvQs8H8Cd5auU1IJJt8agmaRSF3hMVgc0iowDRzuedgpIS4rvvRmcqF
 KiI0wjN6Ka/mpfv2l5UdgH+XTPqiz5CsBbDm6xlFjxpY7odI+gYIrUSsw
 yqqrNa0Fjl1ASGaxqgaz8dN4b8dNNTty9c1RzXAeTLMq8XdkxZKLlhtnu
 SnJ7m2Gbj1Jm2rmZ1JWb6Kw9ETh325h/SM831RRSn/8VGKuZdzZ+6wDEo Q==;
X-CSE-ConnectionGUID: jQQqUpdySSy2JNorKEOdxg==
X-CSE-MsgGUID: RxBL4HtBRzOjzz6CpQ2zgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="18132115"
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="18132115"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 22:03:45 -0800
X-CSE-ConnectionGUID: T/7amxHcR++0bGBRqVRO1A==
X-CSE-MsgGUID: Fip6U82oT4Sv/nJXHIN/ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,259,1725346800"; d="scan'208";a="83997824"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 22:03:45 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 22:03:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 22:03:44 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 22:03:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIe0sCVUIratNW8s6IFokgyU83SuKrd2hqqrvw2IZ1hLP9GhQUib1A4ySgk4q4AUxPjBEGFGBmzFWmwAC6wbhpZ7tA5HfVqvq2aVl6rF5G2hQSz+v+Dzl9Emof/qn6bUvX0JoFod/+gg3K55cNboZXYBEZav9vPc1OckcEpGGbb0WPLvLIl24iPPYKfMRE9lf2TEfGkBegF1V4WDaBotJbZPTSnfie4/gUUKWAADpqT3JMIevvOs7YKO/zzzURR7xeVe8LiYrZspyEpiRH60OV4JI9xWW9RY6xPJqB8ZHrSqczSKpzwP7MmJwpdoV6wthsqEF6mEjBCU6o9hdB9UOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3rFTW+tM/8OI40K8JMBt45kduzlLpNrRzpl8jNp9m8=;
 b=LygheBpkvuN2A3Or48K3ovnJcgfvPRNJT5vL+I5dmWVLqFKsPOZcvVhkzy0bNzxQ3m3b35CRES6J8+kT++LOATOedW5ScRm+vSAdBCNDedhMMYiUi4EGUXipfYXcp5PNj6quQYIhKlDyAhM336ewYoFrsHjpWghCptgUiLgKckUBCXC1rZuCda03YBoRXxiRAOEeuXE9/EbEHC+YU1FRaQAt5CmmrU9ENx5bjv4K7AoN0f3926EGlB3Y9WgStFHTET2QgB5G556YnmsscOx7tK9omi66kNgWSgud4QUwjGjsjLu2P9eNWXELNjnAp1ypfqCr2zHIVdo42KRhkkLibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB4901.namprd11.prod.outlook.com (2603:10b6:510:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 06:03:42 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 06:03:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v4 15/17] intel_iommu: Introduce a property x-fls for
 scalable modern mode
Thread-Topic: [PATCH v4 15/17] intel_iommu: Introduce a property x-fls for
 scalable modern mode
Thread-Index: AQHbExuAfv1IrXwu+EKkvlrbZNnFPLKmvOsAgAAeNBCAABN0AIABSpGAgAAviwCAAACjgA==
Date: Tue, 5 Nov 2024 06:03:42 +0000
Message-ID: <SJ0PR11MB674438005FA244B7CD16278292522@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-16-zhenzhong.duan@intel.com>
 <5cbe6426-e64c-45f1-b276-c7dbb70ff3ed@intel.com>
 <SJ0PR11MB6744F2BFCE29E91D6180609292512@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <df02d9d4-3a54-449f-8d99-cca10bd28cf5@intel.com>
 <SJ0PR11MB6744C2B6BF0942C17720B23B92522@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <0780dca7-d5a7-4554-abf1-0cb92d49a2a1@intel.com>
In-Reply-To: <0780dca7-d5a7-4554-abf1-0cb92d49a2a1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB4901:EE_
x-ms-office365-filtering-correlation-id: 3550aec7-9d4b-45de-014c-08dcfd5f99db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?c2dISWFjaTdmTTB6aHVmQ1lPNTR4dkZZbS9rNGJuVDBiU1M3cWQvYkZKOXho?=
 =?utf-8?B?NEtoUEZLM004aTlrUFBGTkhzWStVU0NFOXoxaERvSXRhUUFhSU5XZnVYRmJO?=
 =?utf-8?B?VHAxQkZJc3U3Q1ZGbkcwOTFwSitSU2RYWS9OSFVodEdzMXlzR3hTWjl0ZVdn?=
 =?utf-8?B?V1N1dWZJUXZFNi9oUnV5RzhFV21seUFNQlpYVG5qcmxoTWM2bGM4SG0wNzFI?=
 =?utf-8?B?bHROdGVpMS9SWm54c3dLOFpYOEd0eVg2QlIrY2x5NEZDQnJ1QWt2eHh1SXl6?=
 =?utf-8?B?S0NkTzlGOWdCTnlsSXppY3hUV0Rrc0RzWk94T3Fxb3ZWdVoxRUVhU0VHdnNs?=
 =?utf-8?B?c2M1VDRxdklUL3lqRzVNampKcUxXQTluaTJCMHV6QmFmVjdteE1CQVBvRkVE?=
 =?utf-8?B?VG9KRnNsQjQ2aWVEWEdTa09kOWNwT2RiREpSNzY2VW8yYlNZWEk2ZnlUNCs1?=
 =?utf-8?B?Wk5ma1Nna3VlcUs4akd2Q1IzTEtza0VkMlJrajdPZDNMQk5xS2twOHFuK2JY?=
 =?utf-8?B?em9XZ0xKVWVteGYzZGQ2dzdLeVFhRndtZk02VnRYQkVxdFpIdWJPd0h1SWds?=
 =?utf-8?B?N3BCNm02WkxDN0drZk1mM2RzNStNOWY2NjFORGJsdHZtMFVIWHFMSHgrRkZU?=
 =?utf-8?B?TEJsampvRzFMY3QzRlZ1Vm04TmJQblYvMDUxK0s0bFFNRktSKzh5VDY3VnBT?=
 =?utf-8?B?dytTZDlQdE1Ja3BuSnV3SnpqcHd1WXRJcFQycVN5R3FibHpiNDBIOGF0Zjh2?=
 =?utf-8?B?ang4YWoyNkYrY2NyLzBHU0JScktNYjZjV2ZLQmZaV2x3ZmJ4aXdLRGRZdkRu?=
 =?utf-8?B?S1JWWlF6NUhJZXlCYnhyMVNSMzIydDJuRHR6UVowNTNqZkRiZG9SQ1RIMXlW?=
 =?utf-8?B?Ujk5TktuS0NhbEM0SDVFQUwzcHdhYWpqdkgzZXViRGpocUpiZGJXeTZsVjhL?=
 =?utf-8?B?M0E5MzM3TU9zUVBuWSsxazhxWVRDZk0wTTdlUTFmSnczRDJWU2k1d1c1eC9i?=
 =?utf-8?B?VUxkL2RFSEtjMHE3cWtlZkZNc0RDSC9abFBCV2dJM3VoWlBUd2MycTE5SzNv?=
 =?utf-8?B?dmxQckdXanVqcTY2Mnk3SzJKdTNqM2xDZTBJOGROcHlrZTE5Z3NzY2JXZ0dh?=
 =?utf-8?B?eU9vUmxJT2xhM29tbXhHdFZBeFloOWJGR004Ui9MQTdncWdFelJnc0k4Szhl?=
 =?utf-8?B?bVFCbEd1b05lVU0vRDdiMjFLYmNXenlRcXJXSkZnMXZYQTNKZXB3MWV1Rk43?=
 =?utf-8?B?MzJKaGZVOVZLYlJFMmtqeWlYZjlYMGVKYi9tSzByTE92RTAvWTc3REJzdkdF?=
 =?utf-8?B?QVVJNEtudjZ6Zm5NR3RoZmQrb2U0UHkrMStLQzJZZmNpYVlUQjlvZ3c4bEdw?=
 =?utf-8?B?d3Nibk5hNTliVmQ2Q21VYi8zNEttU0VXcTd4ZUt3TXVyNVRyYnFZRm1Vbzl4?=
 =?utf-8?B?OXJHSkJjOXpOeDhyMTdqM1krR3ZQOEFoYzlDd3d1LzFmeGU0dFBXaHU1Vk50?=
 =?utf-8?B?WjFDTFh5K3BNT2xRdExIMExBN1c5Rm9BcEl2YlVPVUUzS2Y0dVpQTXlpNGU4?=
 =?utf-8?B?cjR1emhHNkxEK1h1bWdSYW1renZYeDdGUU5DRzkrNStRL1Nidk1qdGNQaWRB?=
 =?utf-8?B?NldtMzNTY0hyUUtiYndXa29NdHBLTHpocEN4eWtGaVRFMVFrOFdaVGk2N21E?=
 =?utf-8?B?WDArdTIyLzVJWHVyYng4UHBOZkZvV0QzTkYvbEcyZTcrWENrVk9LNWlCY3Vu?=
 =?utf-8?B?aUtXeEhiNzRsRGMxN05sY0dlMExUU3pRcTM0OEZkV3NibndiV2F2QndhYWJn?=
 =?utf-8?Q?l/fP1GGsNMIuYzFJD2zc6LlSzJCPQOkwk1cGY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODd1dTZQUWh6dG5MYW9FdnBNYVJFWUVJN00zeXdCajR0UVlZV2NBc3lVVXgv?=
 =?utf-8?B?N2d1K1R2ZXZxM20wRkhmRlJ1MWFlemlaWG9IYXNnVWtWMEJqRHBIcWY3TDc4?=
 =?utf-8?B?NTUvWUVtcHJVcEE5cFpLbjRnNzdUUndXYmxyb3VGbXRQVWdnUkY4OGIxaUxH?=
 =?utf-8?B?cVV5ODhNYWFtc2xWcFRZTzlBS1VWYnc3REVNWEs5RlR1bGJxdXRiSDJNbFdi?=
 =?utf-8?B?bHM5R1grRUpaZE9vOUJCZnpod2pXQnFHZmM5MW8zTFlWbTFGQXZUM0lONzFH?=
 =?utf-8?B?WGFia0JHQjJ4L3FXK3l6L2huUkQ3akhFeXg4NXp6TEdvY1NLY2pzMUVvcUlR?=
 =?utf-8?B?enlDeThFSFlXcnI0MjhxSjAvdXFLeUtZdFdDK2Z4OHN3a0ovSzVHMzQwb3NQ?=
 =?utf-8?B?QVorOUhkMjZOMXZiYXRDU2EwTnA2aXBnMFlqNU9EUzQ3ajFEWFpMUzNRWURs?=
 =?utf-8?B?RUJ0MkRMTE5PYTZ3d1JvRnFmUE1aUzdmeTF4Yk8yMVVlSjB2aUpWWTliSjJR?=
 =?utf-8?B?MXFrOTlJU3duMTlNeHA4T0hTQ0hERm5SMEtWQ2ZTSE5jeUNLYm03US9IU0kr?=
 =?utf-8?B?UVJodWUvR0Q0VDI3anZBcmZ5djRoTFVmWm1vOGpyUEhFc255eEk2TWRvc2xM?=
 =?utf-8?B?UWpLWDdOdDk4eU9VWmhJUkhiNkRwZnlqd0dyQzBUVUZ3UG9DcGlUbHFrazZw?=
 =?utf-8?B?a2VicmpTTmxoQURpRzh5QTBJL3o0VysyV3FKRkh1NE04YXgzR0o3RXhZLy82?=
 =?utf-8?B?dXk3VjBncEJoV3VuRGNSMWhTd25wVSs0YWhXSmcvN3c1R3J4bHpGV3pKSnV0?=
 =?utf-8?B?aktIT0xXVmt2YVo0V0FNdGpuazQxeHZJcXB1ZlRRRHNPSkhGWUx4Mkd3L0l3?=
 =?utf-8?B?VWxnRzdWeHZDVk5hZHV3ZGVtNVpUSmk4dW9YT2E2T0xUeSs4ZnRSN0E3MXoz?=
 =?utf-8?B?cG1HSmlIQkVmNzV5ZHMwY2tsbXNxNE0zYlEyRDR3S1NzclV6OUFGYzBqeG1L?=
 =?utf-8?B?YmU5UnpOcFE1K3lVcUF2bEI4NDJWVUxsY2ZsRWc2a1FDTWkrTFA5eFg1YWN3?=
 =?utf-8?B?SFBUckVKWFp5eWpRZitHK1F1dXgxbTRtdjFMdzlyaUpJekNzWFNIS05FOWRB?=
 =?utf-8?B?eUVueDlkelRuMXlxSk4zSndRdFRwNUN5NUZaOGpUV0RJTGdPQjRMa1JzRmZy?=
 =?utf-8?B?SjMzbk1YbXZJVkwvekNFaVVzSFN5ejcyQ3M2LzRsQ3ppQVVVMnU5TiszaWVy?=
 =?utf-8?B?Smx2WWVLb0VZQzFpcnd2ZnYyeTZpNG1raG9MTEdPbDRjOXRFUWZKUnhCVGFE?=
 =?utf-8?B?WktWcTBMOUkzZmFCSHlEYUNteVZVQ3ZjT29nUzN5SCtDQ2lBRmk4YTVxVEZG?=
 =?utf-8?B?U3Q1MFVpdE01a2JCN3NmWndJcFBEbGxpYytZSlNWWjlLUC9JRUwxSWxWMEdY?=
 =?utf-8?B?cm1LSHErWlRCM0dkYVdIVEI1dFJUa3J0ZXM1YVFwME1ySXZ5ZjZQYTUxOWpU?=
 =?utf-8?B?b252YTRxaFRzQW1BMUN3RUNWWitidFQrYmNBYit2c0FtYkZuVXpwUlN1V1N4?=
 =?utf-8?B?UlBsRWlqZXFFUExPaGVWa0RPMEdmZnhrR1R1a0tXaTdyOVR3SjdzSUc3dDFt?=
 =?utf-8?B?dnZoSDBZNTBYc1plRmc3bDV6dno0cjVHeWhpZmtrYzVualpzWG1GODNsZFFH?=
 =?utf-8?B?UEQzcmJpTFZvcHo2V0dKb1FKd3BSdXlheTg3SHhOYlNLMEFKYTRaQmNVQTdq?=
 =?utf-8?B?UFJLY3BYQWlVaW1CU2VVN1I5SS94MStYekZtQVl0TjlRQlJOOEhNeTkrNEhX?=
 =?utf-8?B?cU92Z1N0ek5TNG5EZXhlVE5yMEFsc0pZMDdOZnUzUUlkVk5DeGdWdUllQkZX?=
 =?utf-8?B?V01Xc3d3SXBKWklpZHN1OU5uOC94T2Iwa01CWmluZmtaeHdpOHFPUUF6bngr?=
 =?utf-8?B?N0k1aUtJMk1qSTVzcmVFa04wYys5bTgxQ2pVQ1JvNEJ1Yyt6R1A4bFh5OEQx?=
 =?utf-8?B?WHpsM0o3RnJSYklURHFqYkN2cklROWp1RkMvVUlBWm04NFN2ZnpxM0FrVERO?=
 =?utf-8?B?REJqd2h2Y0Q0UHg4RGZBSk5ib0dmUC9iTlRoMityU3ZwcFMxUklKQ2ZZVWZs?=
 =?utf-8?Q?r4NCSlzdo0DeN0LTSLiJNaYWD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3550aec7-9d4b-45de-014c-08dcfd5f99db
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 06:03:42.4490 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /aJfZUhgUsfoJFjs6WKJyxAfc3slGgYnI3zVRI7nZprIwKd+ft4XBZzSzUW0C9OxqaJO7F/BfxpBcq8JVYlpLLSW9B8NLuGSraclKSX7DX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4901
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDUsIDIwMjQgMTo1NiBQTQ0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMTUvMTddIGludGVsX2lvbW11OiBJbnRyb2R1Y2UgYSBw
cm9wZXJ0eSB4LWZscyBmb3INCj5zY2FsYWJsZSBtb2Rlcm4gbW9kZQ0KPg0KPk9uIDIwMjQvMTEv
NSAxMToxMSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPg0KPj4+Pj4+ICsgICAgREVGSU5FX1BS
T1BfQk9PTCgieC1mbHMiLCBJbnRlbElPTU1VU3RhdGUsIHNjYWxhYmxlX21vZGVybiwNCj5GQUxT
RSksDQo+Pj4+Pj4gICAgICAgICBERUZJTkVfUFJPUF9CT09MKCJzbm9vcC1jb250cm9sIiwgSW50
ZWxJT01NVVN0YXRlLA0KPnNub29wX2NvbnRyb2wsDQo+Pj4+PiBmYWxzZSksDQo+Pj4+Pg0KPj4+
Pj4gYSBxdWVzdGlvbjogaXMgdGhlcmUgYW55IHJlcXVpcmVtZW50IG9uIHRoZSBsYXlvdXQgb2Yg
dGhpcyBhcnJheT8gU2hvdWxkDQo+Pj4+PiBuZXcgZmllbGRzIGFkZGVkIGluIHRoZSBlbmQ/DQo+
Pj4+DQo+Pj4+IExvb2tlZCBvdmVyIHRoZSBoaXN0b3J5LCBzZWVtcyB3ZSBkaWRuJ3QgaGF2ZSBh
biBleHBsaWNpdCBydWxlIGluDQo+dnRkX3Byb3BlcnRpZXMuDQo+Pj4+IEkgcHV0ICJ4LWZscyIg
anVzdCB1bmRlciAieC1zY2FsYWJsZS1tb2RlIiBhcyBzdGFnZS0xIGlzIGEgc3ViLWZlYXR1cmUg
b2YNCj5zY2FsYWJsZQ0KPj4+IG1vZGUuDQo+Pj4+IExldCBtZSBrbm93IGlmIHlvdSBoYXZlIHBy
ZWZlcmVuY2UgdG8gYWRkIGluIHRoZSBlbmQuDQo+Pj4NCj4+PiBJIGRvbid0IGhhdmUgYSBwcmVm
ZXJlbmNlIGZvciBub3cgYXMgbG9uZyBhcyBpdCBkb2VzIG5vdCBicmVhayBhbnkNCj4+PiBmdW5j
dGlvbmFsaXR5LiBCVFcuIFdpbGwgeC1mbHQgb3IgeC1mbHRzIGJldHRlcj8NCj4+DQo+PiBTbyBm
aXJzdCBsZXZlbCBzdXBwb3J0KGZscykgdnMuIGZpcnN0IGxldmVsIHRyYW5zbGF0aW9uKGZsdCkg
b3IgZmlyc3QgbGV2ZWwgdHJhbnNsYXRpb24NCj5zdXBwb3J0KGZsdHMpLA0KPj4gbG9va3Mgc2Ft
ZSBmb3IgbWUsIGJ1dCBJIGNhbiBjaGFuZ2UgdG8geC1mbHQgb3IgeC1mbHRzIGlmIHlvdSBwcmVm
ZXIuDQo+DQo+eC1mbHRzIGxvb2tzIGJldHRlciBhcyBpdCBzdWl0cyBtb3JlIGhvdyBzcGVjIHRl
bGxzIGl0IChGU1RTIGluIHRoZSBlYXANCj5yZWdpc3RlcikuIDopDQoNCkdvdCBpdCwganVzdCBk
b3VibGUgY29uZmlybSB5b3UgcHJlZmVyIHgtZmx0cywgbm90IHgtZnN0cz8NCg0KVGhhbmtzDQpa
aGVuemhvbmcNCg==

