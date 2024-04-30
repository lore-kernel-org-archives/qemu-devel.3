Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66C9C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jkm-0001EQ-V9; Tue, 30 Apr 2024 05:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1jki-0001Dk-9c
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:26:20 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1jkU-0003V9-Id
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714469166; x=1746005166;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ijB2t20O9AlRFS7diRHoHOOtmlkiC7ST2cOAwfBY7eg=;
 b=cX3glsk3cmuB6MtiDL3OEVpBdAxjvtf47KqgLv5YZNwM0pbZ9LZWrxyH
 rW0m1n12mVaWRTZP1VoEzW89BE5Nrl4S0CHRYfQEzYin0ssBCRCv1ft/0
 gkIttzFrv7UwsKwEAdaiKYBN//WD7QBs922ai+QSAkf4kpDAx16JCZN8F
 02hcGmRlsUhKNZMNCn9u3uvdg1zUi2dDjTKyxPFvGOKIyEaIQHKlN7Pr6
 xtI5dFU6S/JtzoQvT+jwPs0+BbGzGjiX3z8rBbZlJUXyg/uQdsn28A8T8
 RRRas6G3vz/qwa7lehafHyCvP1jPO9z0e327OH7aVOeggszR42ok9EkDP g==;
X-CSE-ConnectionGUID: 5kd63KX0Q3OGBPDrdVqA9A==
X-CSE-MsgGUID: 4wMv8vxTQnmOUX6okp2A2w==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10039235"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; d="scan'208";a="10039235"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2024 02:25:59 -0700
X-CSE-ConnectionGUID: A1uH0BUsSZKGkBHd8sEHBA==
X-CSE-MsgGUID: 5G1X4MXpRMak7KyZ8H8yng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; d="scan'208";a="57575279"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Apr 2024 02:25:52 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 02:25:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 02:25:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 02:25:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7Hzt3aJ1FBeTx5oZcA5coqdEHO0H0psRCktk713gkhrf/KlF9UI5WourQXD9tUZV9zheTsFdZzmeNK7TbdpaEZGlL45KHeC3jorx+BnOc17eDIZiEZGW7tBw4QJhZe4GzjqXkEezckMtXQ0mTbGnk3scPvLtVuVTMcRDVAt2lrfSS4LKYOqdF1Y9XoVqCYkwB5xRWnwPecoKenf5zTX368luiQ9CRRfxPkEx1DR7y5YJLiLA5vL0W2liCgUQT95rhQmDCnBFwe4c9WCW9p9bLQgA6s0zbAxCCCCg0w8SRSmvf06MxWZojU+O0KrVDBaixgbNIOO1cWjwUNWWWNTZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijB2t20O9AlRFS7diRHoHOOtmlkiC7ST2cOAwfBY7eg=;
 b=l/SP+RzqBJyJo/DonwZx4MphROLhp6agGHM7Z34H7kzsDt1d8C9dXGgaVlSFbNIohG9BPuQwppJ5WKz6DjXk6zZ0UCLTQzRbxBFiCVzLlVfiEROLX3W11zV9eBcwClcSS3qIHZI7smudHOGcHv3tZvGfIwCzQgkWKIeW38ot8vWUUx57og7SycczWDGFvmPTrpZix9flm+o/lOedRyM06Knuh6z2u+EGFx0NTZIV59IAMIAHXw2CtutdvID61j36GL20lCjnUxoEJCd7sjkRO2WAeePRhbFWCYa6BgktMN4EgJWKc5uDzMGAEB7XWMQMYzA+psGij4Hmxu+R8uQ/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB7675.namprd11.prod.outlook.com (2603:10b6:610:122::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 09:25:49 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 09:25:49 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 04/19] vfio/iommufd: Introduce
 HostIOMMUDeviceIOMMUFDVFIO device
Thread-Topic: [PATCH v3 04/19] vfio/iommufd: Introduce
 HostIOMMUDeviceIOMMUFDVFIO device
Thread-Index: AQHamgIOCrPL7vyo60OqI4T0O8AaLbGAcqgAgAAY8+A=
Date: Tue, 30 Apr 2024 09:25:49 +0000
Message-ID: <SJ0PR11MB67448A6AC2AC615B2188BB9A921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-5-zhenzhong.duan@intel.com>
 <9dd29616-43be-46a3-89dd-68f6ec504848@redhat.com>
In-Reply-To: <9dd29616-43be-46a3-89dd-68f6ec504848@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB7675:EE_
x-ms-office365-filtering-correlation-id: dbcc5151-75f3-4817-0bde-08dc68f785da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|1800799015|7416005|366007|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?Y3Rmc1YxOVFmWEJqcFVJeUJtREZwaVdubVkrSHZSSXRTNkVneFVSQ2lTdTRr?=
 =?utf-8?B?SWJLZGZPaU1BNk10SHJLTVJFRVBVaStpQkYvVGRTZXJ3dnZqd3ArMlJweXAz?=
 =?utf-8?B?d0hqVE90bW9aRmJyV3J1Y3JvZlpMSHFwM2JXVFo2a1lqVjBKYUVKSnAyZXhn?=
 =?utf-8?B?QSs0dmNkaTZFWUF6WU55TUJyTVdadDdsMWQ4eGRaeGdwUUxxcXVwbTBEYmVs?=
 =?utf-8?B?alV3U0hGa2gyS2gzME9mRzg5eU96ai9hZWpWekE5a0xTWWFBcVlyYlBNTkl5?=
 =?utf-8?B?WlM0NVVOckFpREVmS2gwR01NcVlFc2Y3VXRJUXdXR3RqQjlyWlpJV0xUanZj?=
 =?utf-8?B?b1VnaXRER0x3Ui9mUVVOa1UyRE1FT0xWSlFQZEJwaEtpaDRNUlpwb3M3OTdZ?=
 =?utf-8?B?cms0Nk5nK3RLQlZ3WldDcjV5U2hnWVY3Q3ZVMUhIUEVBQ2h0eTZrdkVPZlkx?=
 =?utf-8?B?MG4wTFNhczZUdHZOUnpET1lhcE50c0dWTXBxL1lveVJjTm1BN2hzYkRGZXcy?=
 =?utf-8?B?MnZ1L25NNm5CSURYMDd3enFFblZJdll5LzAxalVLQVhsOEZpemdzeExXK3hM?=
 =?utf-8?B?cGRPaUJWSVBCZ2NkQU5oZkFzSDJ2UG1UV0RxKzhKSkIxcmw2bzVzdEl6b0ly?=
 =?utf-8?B?ay9EdmNUOXBhVURPcFdsb29vNjVJcHByOXFaTHVYbnd2Y2xDWUlnRTFEeWhR?=
 =?utf-8?B?d3JLMzhMSE1LOUVyUGRzWnhOYmY1MzA1VEp2bW1nYldUSlAxWHFWRkxoYVNG?=
 =?utf-8?B?c05IRjIwSVU1dUlZSVpUdUhXdThDYlBhbFVqQ3l5bUdJRTUzUzF5UFU3UjZl?=
 =?utf-8?B?aWFxUDNqaXhPRXcxWDdnTnVTcWViU2dVMWJmWXJLNzVnYkZWZHhzV3Rqckcx?=
 =?utf-8?B?SHlNamVBK3F5K011RGp6cXEzalF5ei9zNkdEOWVYQkYxWEY1RnErbENGc2t0?=
 =?utf-8?B?VmhBbG81UDBJdDNqVXJvd2pyWFZ3SFVkbG5CbU9oSHFjdmRocVNLNmxKbmF1?=
 =?utf-8?B?dkIybys0M2lFNm1hNXhSaHZ2dm9kcXpkVy9xKzFHWWR1MFZFVzR4MGhBa29k?=
 =?utf-8?B?cjJoYmVOd3h4UTFRYzBYa2NvQWlnLzBYMVIwb1JyUjhDS2xacVBDRC9oalBT?=
 =?utf-8?B?a0NjQUluenQ3TlVFSll1RUFXaVFDZzl5RjJpaDVIQng0YjV4TXJVNERSNnJL?=
 =?utf-8?B?NHovZGxrYVk1dWNGTzJXT2ZWYksveVRPYmxoNXFUenNiRVlWa01OWGlYSVkz?=
 =?utf-8?B?OEpwT3BEcThBYVRaTU9LRVNpa0NPdVVXTUZNQWFWYklxVXcxdmdyN0VjUDhi?=
 =?utf-8?B?ZlYxazJNWjVFVXRScW1NcVdYYjIyZDBBTkZNMW5vQno0TjJMeG9DQWlDUCtm?=
 =?utf-8?B?RFNjUGVDTWdnRTQ4QXl4RkRhd2pqK1Y3R2JCNTVSRmNEMFZuRjluOWYzQmcv?=
 =?utf-8?B?Rkl0bFp5bnJsajRGckxTeFA5ZXVNR2hJY0ZIRDFveDRZOEk5OGk3Ykk0LzFs?=
 =?utf-8?B?aVhFRE1sWTQxT0hDdmgwd0d2aGkvVEMrSTJRaVZPOUwxQWdlbmQ5MGpLWjRa?=
 =?utf-8?B?eHE4ME83N0huQ3BBMnpkNTZOS2FqOFpIK0tJWEpXN2RuU1V5QytjdzkyckhC?=
 =?utf-8?B?R1NrTU0wcUxsVDJxM29jRHd3ZEdrTDY1c2lhTVBiUmRmQ3FRWVdQU3RIL1Uw?=
 =?utf-8?B?bExvUEJ2OVErdGVJcGNSeEwzSmJ3c0F6WmoyWVlyUUdhR0F4Z1FLdXpYbldY?=
 =?utf-8?B?Y1JZWlVZNTB0MU5OcnVrWkhxTHVIK0dlaXB1dXpGUWtnOFo5NUQ1MzdWL2l6?=
 =?utf-8?B?U1dwMWcyUUlrNnk4MjBFUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3liUUhqdnUxQ3l2TTZQNHBPaG5rN2RaRG9sRGFGb2FPbmhaaUI3RFNXaVJU?=
 =?utf-8?B?ZzlONnBaTWtPT2VhVWVtMkNFWkhDSnVoRERHWjYwNTY2Mjh5aGtQR3BIVzZa?=
 =?utf-8?B?ZHF6L25MZnlRVFZKL245TlZrUkhhL3dmLzRzc3FWT20wVlQ3NFEvNlp5cW1C?=
 =?utf-8?B?dXhEeHJBREZCbklGa0JuNzJCZzlicy83emlxVk5NYlZSQ0lVY0tNdUlwV0hu?=
 =?utf-8?B?T0ZlUCtZd1F6UkVXWkM3WkFyMVF1QWtsRVJRTzdiSHZUL3QzWlpoQ0xoNGRa?=
 =?utf-8?B?cHcrVC9rc0I1VElWK1VsaVEvd1JJcTczbXhORTdXVXF6cm9ORmF2KzY0Zy9Z?=
 =?utf-8?B?TDI1b29Zek1GaWNuZVVHUlg0SkxyTUdwUndRZUlqaC9QRTRiKzAwT0grWU00?=
 =?utf-8?B?U2RiNWlldGxSVlNHVjY1LzRtQklXd2dVd1pXS2xGVzlaeThtTjd2a3ZTU01y?=
 =?utf-8?B?cEgxbENwSTZZNFFBUmR2UEJ3aS8ydzdEcVYwQnlzZjZjb3lyeVAwSGNKamRV?=
 =?utf-8?B?QldaTTdnNVBzYkhUN0p3M2ZmU2dlWTBpU3kzbzdoTmZkUEpCM2xOVnZFcXBY?=
 =?utf-8?B?c0YwamlKbXlMTHdzRFcwcTZVck5YVUcvMkIreStKLzNBVXRmMEVwLy9Ua1c4?=
 =?utf-8?B?Tmk2MTduTFB3OS9vaW0vMXBoeDlPS1hFQmUyQzVhak5yWkFJTm5ORWI0UTVY?=
 =?utf-8?B?Q1BQYkFTbXMxazl1QXlGQnJqTThvSkNTeSttRHZLTWE4TFlUSlQ4WTFNZnE2?=
 =?utf-8?B?QjNMdzRkUStqY3E2TXZnS0t3aWdNRWxWemROUnd4elRLc3ZMQVNIbzduclFC?=
 =?utf-8?B?bGJSQXY2Qi9ZMm5QSlRDdHdLSkQwaEN4Wk0vUnhuT2p5TXFhd3labWREYUJ0?=
 =?utf-8?B?VFFTVFVidnA1cVdNWEJiZWxoRUtSS2k1ZEZNQlllQU5INUZrWWo4U09YK3hn?=
 =?utf-8?B?ak5QVW15UzZXbHVkOHo1dzlyU0hOczZRV2loN1JvQ1lVeWZXQXhDelc3cUFl?=
 =?utf-8?B?VE9adUs4dldqcG5Ub1k4L2IyNzhvVVVWcmlXd0R0RS8vNXIraHoyWFVUY2d6?=
 =?utf-8?B?czRGMWpyWnBYdG5wRCtOTjlTQlhwbkJwTHhhQ0pPMzkyOXl3ejdtY3hnQU9N?=
 =?utf-8?B?QUkyMTZvaGN6cEpKR3ZwS2g4S3lEVWNiK1FyY3RkMmFRM2trR0dKWkg1MzdV?=
 =?utf-8?B?VTV6d3dRb0hJU2hKYUNNekVpcExJYzZ3N2hpVmNRY1prTGM2M2NHNk8zNnVq?=
 =?utf-8?B?SnhObm8zdVRxY1FJS2xPNzBuNkJadmMraytEM0VsekhLdENlcXAxMW9WRERB?=
 =?utf-8?B?Q0gvN2VKRmxaU2IzR1Y4RGpCMFRVT0l4K09pbHVDWkJkT3NSb0MxRERaUFl3?=
 =?utf-8?B?ZFFTTUJVdnN1OTFGUWdmM2I2Q3ZQdFF3cWNxTGhaZjlRWDdlT0ZhbnAyR1JQ?=
 =?utf-8?B?c2tCYVc2WWVpQ0I0cUxuN3F2aVlqTStEdGJZY3VOd3NFQU9rWVNpS2ljVWQ2?=
 =?utf-8?B?V1JoZnBHcVFNQ0ovQUI3dmxmTFd4MXk2M2ZSWHo0M1dTeHhSNUhoQ3k2ZHZR?=
 =?utf-8?B?bElEdTQ3RlUyN2YzYnJZTTBmSUJlQUR4Yk5ITFVJbUhzd1UwWVR2azF3ekNF?=
 =?utf-8?B?eTVXODB0RCtma0NFTnpUY1FzL3B0dUh2VjhOY21lay9aQmowbGxBZHl1T0U3?=
 =?utf-8?B?SjhyNnFJdXUzOFlWL1FLRGwxVk9TZGNqQjlrN3RDekRWbmlUQ2VVZE5jMWVn?=
 =?utf-8?B?TVV3bmg1VklIajB1elF4SzdlU1VCamRFYW9lSDZBK2dWZjhpUTdUUnZkMFNa?=
 =?utf-8?B?YnFUaUxxNENCclEvRnFLUlZTYlE2VitOWHFPaXJWYmNlTVdxZVl3QzNhWGw2?=
 =?utf-8?B?RUtrTmdlOVBDZUV5S1hFTUlDcyt1ZzJhT2hjR2QwcTNOU0k5dnRYb0JobFJE?=
 =?utf-8?B?ekIxaVpPYnhQc3VhM3dQbnFBWVBVRGpYYmRVd0tpUFZMWFhVS0JEMUROZnE4?=
 =?utf-8?B?Y242NlRFL3JoeFZvMWd2MGF5ZTlZZ2lqalltYXJHeDB0bkJYL0NUMjdsSER6?=
 =?utf-8?B?U0NTZ0MxVXlvbk5jTGhqSUw0akFpMjF3UzdKcmNKMEtDTkJuOFZZcnZrZUVl?=
 =?utf-8?Q?P25HL4maNwa34PZQWQyGVOsxH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcc5151-75f3-4817-0bde-08dc68f785da
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 09:25:49.1004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aLRa5MpmiSiaznRBSNyPaf2MsntxTKLw1gm5twMoCPCDXKecDLF5fMyqg2WovnGVSJ7wVGoKqABX2KCJsB5RgdDprJ7D3y6UzLuh+zuskWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7675
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDA0LzE5XSB2ZmlvL2lv
bW11ZmQ6IEludHJvZHVjZQ0KPkhvc3RJT01NVURldmljZUlPTU1VRkRWRklPIGRldmljZQ0KPg0K
Pk9uIDQvMjkvMjQgMDg6NTAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSG9zdElPTU1VRGV2
aWNlSU9NTVVGRFZGSU8gcmVwcmVzZW50cyBhIGhvc3QgSU9NTVUgZGV2aWNlIHVuZGVyDQo+VkZJ
Tw0KPj4gaW9tbXVmZCBiYWNrZW5kLiBJdCB3aWxsIGJlIGNyZWF0ZWQgZHVyaW5nIFZGSU8gZGV2
aWNlIGF0dGFjaGluZyBhbmQNCj4+IHBhc3NlZCB0byB2SU9NTVUuDQo+Pg0KPj4gSXQgaW5jbHVk
ZXMgYSBsaW5rIHRvIFZGSU9EZXZpY2Ugc28gdGhhdCB3ZSBjYW4gZG8gVkZJTyBkZXZpY2UNCj4+
IHNwZWNpZmljIG9wZXJhdGlvbnMsIGkuZS4sIFthdC9kZV10YWNoaW5nIGh3cHQsIGV0Yy4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwu
Y29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oIHwgMTMgKysr
KysrKysrKysrKw0KPj4gICBody92ZmlvL2lvbW11ZmQuYyAgICAgICAgICAgICB8ICA2ICsrKysr
LQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggYi9pbmNs
dWRlL2h3L3ZmaW8vdmZpby0NCj5jb21tb24uaA0KPj4gaW5kZXggYWEzYWJlMGExOC4uMDk0M2Fk
ZDNiYyAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+PiAr
KysgYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4gQEAgLTMyLDYgKzMyLDcgQEAN
Cj4+ICAgI2luY2x1ZGUgInN5c2VtdS9zeXNlbXUuaCINCj4+ICAgI2luY2x1ZGUgImh3L3ZmaW8v
dmZpby1jb250YWluZXItYmFzZS5oIg0KPj4gICAjaW5jbHVkZSAic3lzZW11L2hvc3RfaW9tbXVf
ZGV2aWNlLmgiDQo+PiArI2luY2x1ZGUgInN5c2VtdS9pb21tdWZkLmgiDQo+Pg0KPj4gICAjZGVm
aW5lIFZGSU9fTVNHX1BSRUZJWCAidmZpbyAlczogIg0KPj4NCj4+IEBAIC0xNTksNiArMTYwLDE4
IEBAIHN0cnVjdCBIb3N0SU9NTVVEZXZpY2VMZWdhY3lWRklPIHsNCj4+ICAgICAgIFZGSU9EZXZp
Y2UgKnZkZXY7DQo+PiAgIH07DQo+Pg0KPj4gKyNkZWZpbmUgVFlQRV9IT1NUX0lPTU1VX0RFVklD
RV9JT01NVUZEX1ZGSU8gXA0KPj4gKyAgICAgICAgICAgIFRZUEVfSE9TVF9JT01NVV9ERVZJQ0Vf
SU9NTVVGRCAiLXZmaW8iDQo+PiArT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoSG9zdElPTU1V
RGV2aWNlSU9NTVVGRFZGSU8sDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgSE9TVF9J
T01NVV9ERVZJQ0VfSU9NTVVGRF9WRklPKQ0KPj4gKw0KPj4gKy8qIEFic3RyYWN0aW9uIG9mIGhv
c3QgSU9NTVUgZGV2aWNlIHdpdGggVkZJTyBJT01NVUZEIGJhY2tlbmQgKi8NCj4+ICtzdHJ1Y3Qg
SG9zdElPTU1VRGV2aWNlSU9NTVVGRFZGSU8gew0KPj4gKyAgICBIb3N0SU9NTVVEZXZpY2VJT01N
VUZEIHBhcmVudDsNCj4+ICsNCj4+ICsgICAgVkZJT0RldmljZSAqdmRldjsNCj4NCj5TZWVtcyB1
c2VsZXNzIHRvZGF5Lg0KDQpZZXMsIHVzZWxlc3MgYmVmb3JlIG5lc3Rpbmcgc2VyaWVzLCB3aWxs
IGFkZCBpbiBuZXN0aW5nIHNlcmllcy4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPlRoYW5r
cywNCj4NCj5DLg0KPg0KPg0KPg0KPj4gK307DQo+PiArDQo+PiAgIHR5cGVkZWYgc3RydWN0IFZG
SU9ETUFCdWYgew0KPj4gICAgICAgUWVtdURtYUJ1ZiBidWY7DQo+PiAgICAgICB1aW50MzJfdCBw
b3NfeCwgcG9zX3ksIHBvc191cGRhdGVzOw0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vaW9tbXVm
ZC5jIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+IGluZGV4IDg4MjdmZmU2MzYuLjk5N2Y0YWM0M2Ug
MTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2lvbW11ZmQuYw0KPj4gKysrIGIvaHcvdmZpby9pb21t
dWZkLmMNCj4+IEBAIC02MzksNyArNjM5LDExIEBAIHN0YXRpYyBjb25zdCBUeXBlSW5mbyB0eXBl
c1tdID0gew0KPj4gICAgICAgICAgIC5uYW1lID0gVFlQRV9WRklPX0lPTU1VX0lPTU1VRkQsDQo+
PiAgICAgICAgICAgLnBhcmVudCA9IFRZUEVfVkZJT19JT01NVSwNCj4+ICAgICAgICAgICAuY2xh
c3NfaW5pdCA9IHZmaW9faW9tbXVfaW9tbXVmZF9jbGFzc19pbml0LA0KPj4gLSAgICB9LA0KPj4g
KyAgICB9LCB7DQo+PiArICAgICAgICAubmFtZSA9IFRZUEVfSE9TVF9JT01NVV9ERVZJQ0VfSU9N
TVVGRF9WRklPLA0KPj4gKyAgICAgICAgLnBhcmVudCA9IFRZUEVfSE9TVF9JT01NVV9ERVZJQ0Vf
SU9NTVVGRCwNCj4+ICsgICAgICAgIC5pbnN0YW5jZV9zaXplID0gc2l6ZW9mKEhvc3RJT01NVURl
dmljZUlPTU1VRkRWRklPKSwNCj4+ICsgICAgfQ0KPj4gICB9Ow0KPj4NCj4+ICAgREVGSU5FX1RZ
UEVTKHR5cGVzKQ0KDQo=

