Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67775C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGL9-0006gF-Jt; Fri, 24 Jan 2025 04:51:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tbGKp-0006JL-HD
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:50:44 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tbGKk-0004gs-CO
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737712239; x=1769248239;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=T1mu45kn43MpjKb73aUP6KdxCq/yDQVdQsl2OOOgQj4=;
 b=nqf8/LTvKw7y9xN1iUWRWPuJD/qVrkeBKU3NLk37rGuSjRJGW9pEfRes
 xSdcTuOtHwV+gitjWk4OTNJXGImldBdMcgaD1WqiVWPoOl7KJyegP3mHD
 tvbkKJEvqRTdwnrnjtJR6mDXfk/28r/QLe/dPYaxJtlLl8RFsNNvX0IDA
 zT/XBiVYJhlkOuKJj2Rea1tjzeO9/8YLp7jU4vIeoNU9OLFHCJJn6vuLE
 IGVGtaWnirPajfOPa2W1rPgw4hGxRhqdZjoev9WDIPTH2OPOq+yeP/Ntr
 ev7MksXFtstJK0sgANVwSLNGtVHRTjZhKq+1WRD/f5x4AENN/KAwA0lPA w==;
X-CSE-ConnectionGUID: zc0ZXR0oS/eFgPRMDbXmlA==
X-CSE-MsgGUID: zT+KTJjIQaWUaeMfzY+NsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="41906439"
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; d="scan'208";a="41906439"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 01:50:35 -0800
X-CSE-ConnectionGUID: kS1snx8VSb6yMaET4Ja53Q==
X-CSE-MsgGUID: NH4lZ+ZrQzyJiug05ZTPRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,230,1732608000"; d="scan'208";a="108270694"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 24 Jan 2025 01:50:33 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 01:50:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 01:50:32 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 01:50:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMl24GGADNjR2BN5igkvDXA4i+aTanZX5oxLaYife9hkaHaU80fkcFh4h8BOD5+PKHT3g4/A7pn5wfEdBQ0dY3ifjz1ixeStJfAt0SF8QGA/NxDET8C7MRNqouNStFGCoNSlJMO1c15gHqvptvLWT9kAHbNFgmO21/V3VlRILoKW3Cfs8hEQ+BE/yhsoL93RS9nv1plhe0lYL0dEEq2IdpMYRUbAdWnQ4A6iI0xc7vKlrQEsRgC011P0Ut17xCSJ46jnl7jB1ikBFKkuOQQiKVjyk2QchYVyPIYM8LBj/1Oq7kuGKdS7R35ucs4FO0xcqdWrCOQqM9/5KHgEZvw5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1mu45kn43MpjKb73aUP6KdxCq/yDQVdQsl2OOOgQj4=;
 b=pu1l5Dlz1Zo5615SQ71ImeaTrnAVTGHD0U8QF/NPoE2Xg5u8MDXcVPv5UZsiglHLaCfKkzG//KzWxzxpgQ9EmFDJXwoS13icXw9mrW3P3ZFYDVAkL3g7ze/ElbV2cRMxlpS29ysd+s/LmJdHf+EedrGta/BllbqEtf6JZOiA9PnT0rq4+BJI5X5fIAiBV0G3wdvmQKvcz3z0LbYHVucnLRYWYNr8SO8hMfykMKe0d+ki2NHBfdId3x1ndUxxPIt+XAYjm6hxuOkhFtQznYaE8oQIcmSRfYB9uWhi72YLmVLZtjr3FsMbsi3NPkhLwRmBlxPbG9u2PZHlikmBGYMe6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB8491.namprd11.prod.outlook.com (2603:10b6:806:3ac::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Fri, 24 Jan
 2025 09:50:30 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.8356.020; Fri, 24 Jan 2025
 09:50:29 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
 "lvivier@redhat.com" <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: RE: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Thread-Topic: [PATCH] hw/virtio/vhost: Disable IOTLB callbacks when IOMMU gets
 disabled
Thread-Index: AQHba2GEeT3q2OY+G0e4DMt12KVy1rMgkh0AgADZNgCAAPlEgIAACqIAgAEnzgCAAHSwAIABLInggAARvgCAAALUgIAABIRwgABadACAAAf94A==
Date: Fri, 24 Jan 2025 09:50:29 +0000
Message-ID: <SJ0PR11MB67442BA7CFE9FB2CFF0E387A92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250120173339.865681-1-eric.auger@redhat.com>
 <CACGkMEu4oMa8Sf9QXtszeoSMj_67Csr0s7kHdYfbNnJWibu2dA@mail.gmail.com>
 <5a55011a-af8f-483a-99fa-5cb2cdf3841f@redhat.com>
 <CACGkMEv6ec3JLZg6ZedSHdNS5_McX7_xoV4d2MG05x_Y5t=uEA@mail.gmail.com>
 <678babb6-f64a-4db5-ad60-494214a4e673@redhat.com>
 <CACGkMEvyYT7-PTOwO-Jg9a8AHA0AJHoV2BY2RBrJTGKEFYL6QA@mail.gmail.com>
 <25b5bb73-abd8-4008-905d-6c2e9e1330e2@redhat.com>
 <SJ0PR11MB6744EBC0BB7C8CD5F33D0A4E92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEtQT2yZf93+a3LxSCyfBEXbEDu5S2cFXuAhprDYd2-vhw@mail.gmail.com>
 <CACGkMEvOht6KaJ=x2LkD=C2o+4xgixdyXMqbfuXq7-KQPdkwgQ@mail.gmail.com>
 <SJ0PR11MB6744A84009D365C4CCA45D9292E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEup5ENfD8OFEtJv7pXyBFhtW9ciUmz2Z=ejN_Pfbp_usA@mail.gmail.com>
In-Reply-To: <CACGkMEup5ENfD8OFEtJv7pXyBFhtW9ciUmz2Z=ejN_Pfbp_usA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA1PR11MB8491:EE_
x-ms-office365-filtering-correlation-id: ac4aba79-6d3c-4212-e69e-08dd3c5c8993
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SGtCbmw2RlUzN3RxMHdWOHRUcFpkMFEyV290K2JCNzUyRHk1UnQ0cTRhVzFN?=
 =?utf-8?B?YUNxc1BDVmk5Y2J5ZjhVWWgrbDgvcStHdEVybFUrVTFoMmk3THRQbk1FTzB1?=
 =?utf-8?B?Vks5eGphWXN6OC9mcURYZmZlOHBDdlBmMXZSMS9lZTFDQ3J3OVJQZ285TFl2?=
 =?utf-8?B?U3pUNm1QTklPZXRERm1DSHE4eHhoK1hmYmRZZlNYOWNTbnpZUkN2QUducnZw?=
 =?utf-8?B?RmJObkw5ZnBNd3VhUlZ3QnRKMHdWNjhWVXpNTDlwSmFpS09sNE9qK2lZcVkv?=
 =?utf-8?B?T3RlQVoyeGRSSkJmTFJIZUVGNHBuUjB4c1Z5R0VMRUlvYkVPSDNtQVFSb2ZH?=
 =?utf-8?B?bUh1ZEhaUEpqSndSa0hIQkxpSi9Ya2lVYlNFVlk1V0hQRVV2TU52cTV4Nmw3?=
 =?utf-8?B?MUdkZzhhdDRtQjhPVy9UUlBHUTMwZWJGMDBrbzhIZ2ZXM01YNkdhTE5vak1E?=
 =?utf-8?B?YTFCRkJ1dXNzOXd4L3NnRjdVSko1b2xua0N1REY3UlNzd1ZuQmZJcEV0UmlI?=
 =?utf-8?B?R1h5V0g3T2FHL1Y5RktjN3pLL202ZUJVT0g3OE1YbVBtbi9uWUFQOC94Qmo3?=
 =?utf-8?B?U3dydzRYZFp3SWgzend1eGhHNjk1S3dGbUZPQStRZFM5bFVJTzB3azdPOGNx?=
 =?utf-8?B?R2EwUjdFZ1F2TjhlSndOcVF0Qk1JVmI1SkFQTHhsSWM5UGcrdkhYR2VSZnhy?=
 =?utf-8?B?c1lzM01rcHNCbUJTcmgzYUtudHpOVHR4cHdGTVU3bWdyQ0ZUMVJjOU9zNGpl?=
 =?utf-8?B?cEJQeHl3Y3JUd0IwQmRTZ0NkbHVhRjFpNTM2cFpPQzRGZVpncGxNMTF5U2h3?=
 =?utf-8?B?WWFlOVk5V1piREpsUEVEUGxlKzdTd0NKckFlWEJVSERSSnNmNE1GK21vd056?=
 =?utf-8?B?U25Xb3p4TWdUbmd5d3U0Y3BnTFlzc2g4UVdTdEp5WFhrbVlBTGRxV3B6TmRa?=
 =?utf-8?B?eUFEdGhqNWFJWTlmSmk3M0RjRXpLQWZuNFZYMGIrNjV6dXRJUDZvTC9uY2VK?=
 =?utf-8?B?Tjk5WXd4NFRNVUN1TDFrS2VGaDRBMGU0WHI1Rld3MHZYdC9ZZjVRWEJodmxC?=
 =?utf-8?B?ME0ybytwWWVpN05nNGJXd25YSEtFNjZ1VUxKZlFoSzl5T2xkVzY4MXhCTzd3?=
 =?utf-8?B?MmlyRTllaUVPa0hxYjE1YzRIanV4aGZCaTVqekd1cGhTTmVueU82TlZldGRM?=
 =?utf-8?B?QmdvK1JvZmcvSDluaHgvYWZ0ZEJGTDVmZ3lEWU9lOEp6SVVGcEUyaGZCL1Nu?=
 =?utf-8?B?aEJsdlJhaEoyYzc4R1lCSGN2V2FnOC9nUjRMMWJCUjFOcEFRaXc4b2U5MFdy?=
 =?utf-8?B?c1pqWVJZdXg3aERSeDN1QWdwZjY2T3Nvc2tIYm43VHhCUHE1UUFoUnhwTWVI?=
 =?utf-8?B?NHl6OUY5MGptNkk2ZWlSeFA1NGhVdndVdGN6Zkp5cWNxZHdEc01SWkdlb3py?=
 =?utf-8?B?ZmJZNEJNMHpybW9kaHk4ZmhBOG03NmY5OS81di9PVHRoSmZhczZWNGI3ZUdP?=
 =?utf-8?B?R1pwRVNuc1FWZXl2bkxPekFFdDlES1ErU3hrUHBEekNBbFhpYTROeTUyTWlv?=
 =?utf-8?B?ZlZHSlNSaWlDZUVwT0pkMHBGTXRyQTFaYWtnV09BT0taNDRuOEtzRWNQTUxH?=
 =?utf-8?B?T3R5NFpkOHV3cnpmSS80ZWtQOS9XNzhqRlVwVi9icWdzeVpwMjViS0V2V0M1?=
 =?utf-8?B?TEs4QldoRElmUDNmOG9BaG9icnBkQmc1UStnbldodG1ReG1xa3hpNVhZWEY0?=
 =?utf-8?B?NEJHbVVCVnZ1WkNkRTBlWXNGY1AwWkdxUTBJVWF1RzJMZkpBckNqVnFJZjNj?=
 =?utf-8?B?OUp3NEo2ZzhEUkNYSFhJbC9rWi9oSUU5S3dGenZZUXRpdWswc0pkSWJXU0VO?=
 =?utf-8?B?V2VqRDRnelo4RGZ5Z0I1SUxqYjNiRFk3UnJTZ2xKWHRhcnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmtKSFdtdjk1eVlFT2g5ZXRPaXJ2MVBoZFRSbHNyVXdiVWw3RWViZFQwaFEr?=
 =?utf-8?B?THI2UEphblJ6VHVURlBOM0MzNWRoZnBhcmlXYkFKVzlpVDJJZk16dEtQYStl?=
 =?utf-8?B?MFJDdnc3WitvcHdzR2QwY1cyR1A0Q3pKdGtTYUc4ZmQxQzg5Y1FrM3hzdGtI?=
 =?utf-8?B?UkJaRXM2a08zRzJyYS95c3JTa2RyVWJoUy9JZ1lXQmJ1MmhRM01pdWlOMVlG?=
 =?utf-8?B?SEp3LzB5bXFIbllZKzY3SVhFZXdkQmVJZ2dCTjZkTHFlZXA0dmdZdCtuZW9V?=
 =?utf-8?B?OE96eWQ5YUUrU1c5OFFSRGp5QkdhVWZYd3YwTDZpSjNiTk9iTm15N1gxQnc2?=
 =?utf-8?B?dWcyUUwyeXN4dTQ2TWlsNTlUL0hyRC9PVnpZeFdTcFFoejI3bnRDU3krMk5n?=
 =?utf-8?B?TXhjSFUzcjNSY0R1SUxXdFcyOVpDUkxxY0s5K2xILzJlRUJjVkVpT3hrald2?=
 =?utf-8?B?VjlYMjlsRHBRZGd0VEdqbnlIMFgyM2lsRklIMXdkZm83WWVTUUhoTC9hMHJp?=
 =?utf-8?B?cW9ncTBRZDlja2FLWjBPNU8xZkNwQlBqTTNBOEdtOC9HSk9sZ3I0TmdXaUZL?=
 =?utf-8?B?eXJJNkhnaFBTenphUGdRUkJkVzVodUN2YUprNDZLOERGalhPR2RKbVNvcUlC?=
 =?utf-8?B?VUg3dHZUaFRyRER1aVJyUWtaSE5yWDVybVZ0K1lvN2M4OWgxUEdzV3NRanlZ?=
 =?utf-8?B?QzhsUnFWVFRMK0xWaG9zVWttbFpMajdnelNOTlM1UGcvRHpnTUcvZk9lOWp4?=
 =?utf-8?B?M1RyQjhEdWpoZmxtUmtDRS9CYTlzVDhzVWNNbElBU0tsWGZCTzhJZFkxVzhD?=
 =?utf-8?B?RDF1bjBwY29sOUdxbnNjWkM5cmRyeXkvdXhhcGY4ekRzenMzcjFTQ3dTdjUw?=
 =?utf-8?B?UTBkOXV3dENPL1pwYmhTSXRBaEJUeHRDaXc2RXFCYVRORnZQd1pWYmZNWVVK?=
 =?utf-8?B?dnFmampIL2wxOFlxSjdPNW5yZEpZeHVLdWI4aVYvNUJkSGRIQi84MDBFd0pz?=
 =?utf-8?B?d1NhQUQwLzBXY1FyektQaUdDdFRJSk1acEhwbHhxeTZBSkxLeGM0akMranBj?=
 =?utf-8?B?NU42RTBOalprZXFNOXpNaHBXL1lOSDNHcTl0SVRUUk52NGFPdHlwRVM5QjFv?=
 =?utf-8?B?cFdESkRabzczd2NZODRnOXd2akc2YjBCeGdoS0hwTFV2cU9WUHVGM2ZNSTIw?=
 =?utf-8?B?cDFWa21uRlBsVzJpempzU0FKNk9EZE54MVZKd05OTWFYcGRhN08vSENGenFI?=
 =?utf-8?B?UStwMmdzb2pCM09wUDZsSWNEZ3IwSWgwajdpbkVlb2RSL1Zub3NSQlpiaGMx?=
 =?utf-8?B?aTg2T2VNUWRoc0J2QXZZdi9xZDZrMnVlcTBjS2R3aTI0cHZ6cDJyeDM5WXpz?=
 =?utf-8?B?cnJFQnhXQ2NNdHFLZ0tCNFc2b0VHNUVrV2I0TDhQaFAvU3FkbkJ3aU94UUlK?=
 =?utf-8?B?ejNjKy9QVU83RTcxRUNoQWVQbTcxcGs2U0swL3c0ditzb2lXRytJMHlGekJ3?=
 =?utf-8?B?MDNqWDVSbzI2QjZET2NtWHF2S3RxYis3Y0srdDRuTU9WbTJPZ0Y4ZzI3UEIv?=
 =?utf-8?B?YUJMQTJFYTRhZFlranNaU1g1bzVkeXJGRDhJS3VzelVuUDBON2hSUjI2ZUEz?=
 =?utf-8?B?TE9uejlpWGhFYzJpS0k4cmplZXlsQXhTRVdSaUkveklqSk1mTnlpMVZSZzFZ?=
 =?utf-8?B?bmI5YTRnUmpDell6ak1NTlI5bnNQWHkzTC9ZOTJQMjY5eG5HRkNuaDlHTy8v?=
 =?utf-8?B?QkM0eXR0eDRXdVJXTDJkam8vOFF6R1lqR1h6K1VoUEU5RW5RNVd0MVJzcVg2?=
 =?utf-8?B?NzN6cEU0K3g2QnlwR0JicllDSXluY3ExY3p3OVFFSXNxNlIvOWluUlhvUHBv?=
 =?utf-8?B?UytIYSt1b3djb1JZRjZHS2thS2pxeFdpQTltRDVtNVVITDRaNm44TWk5elJM?=
 =?utf-8?B?NmdaZGxSVXRsejI1bC9wcVk0VVIva29LVUZYeWEvNHdnZXpaejZsWGFIaFFF?=
 =?utf-8?B?N0ZpMFpOUE4wVURhdlhBNjdjNmgyVkdKRTgrSTNGaHd3SVU5TlN3Z0NHN1dh?=
 =?utf-8?B?aGRiSDMxU0cvQzF5V3N5d0VXaG90VjRweTNJNjAzNmRTdWpnOWtwTlNDR1U0?=
 =?utf-8?Q?q3stWr/pe3OZzXhi8jX79LMuo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4aba79-6d3c-4212-e69e-08dd3c5c8993
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2025 09:50:29.8708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GKM+xEHiQEUDDzyWoTJqDBDibPBm1c6JYHBo3l2+7jrVHPkk8UhZU7M+08lAppiCvHvWRqr37QzXIt/nId6sWhXEAwsx/HDlWgsQ9SWEIio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8491
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSF0gaHcvdmlydGlvL3Zob3N0OiBE
aXNhYmxlIElPVExCIGNhbGxiYWNrcyB3aGVuIElPTU1VIGdldHMNCj5kaXNhYmxlZA0KPg0KPk9u
IEZyaSwgSmFuIDI0LCAyMDI1IGF0IDEyOjAx4oCvUE0gRHVhbiwgWmhlbnpob25nDQo+PHpoZW56
aG9uZy5kdWFuQGludGVsLmNvbT4gd3JvdGU6DQo+Pg0KPj4NCj4+DQo+PiA+LS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4+ID5Gcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
Pg0KPj4gPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGh3L3ZpcnRpby92aG9zdDogRGlzYWJsZSBJT1RM
QiBjYWxsYmFja3Mgd2hlbiBJT01NVQ0KPmdldHMNCj4+ID5kaXNhYmxlZA0KPj4gPg0KPj4gPk9u
IEZyaSwgSmFuIDI0LCAyMDI1IGF0IDExOjMw4oCvQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6DQo+PiA+Pg0KPj4gPj4gT24gRnJpLCBKYW4gMjQsIDIwMjUgYXQgMTA6
NDTigK9BTSBEdWFuLCBaaGVuemhvbmcNCj4+ID4+IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+
IHdyb3RlOg0KPj4gPj4gPg0KPj4gPj4gPg0KPj4gPj4gPg0KPj4gPj4gPiA+LS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4+ID4+ID4gPkZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVk
aGF0LmNvbT4NCj4+ID4+ID4gPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGh3L3ZpcnRpby92aG9zdDog
RGlzYWJsZSBJT1RMQiBjYWxsYmFja3Mgd2hlbg0KPklPTU1VDQo+PiA+Z2V0cw0KPj4gPj4gPiA+
ZGlzYWJsZWQNCj4+ID4+ID4gPg0KPj4gPj4gPiA+SGkgSmFzb24sDQo+PiA+PiA+ID4NCj4+ID4+
ID4gPg0KPj4gPj4gPiA+T24gMS8yMy8yNSAyOjM0IEFNLCBKYXNvbiBXYW5nIHdyb3RlOg0KPj4g
Pj4gPiA+PiBPbiBXZWQsIEphbiAyMiwgMjAyNSBhdCAzOjU14oCvUE0gRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPj4gPndyb3RlOg0KPj4gPj4gPiA+Pj4gSGkgSmFzb24sDQo+
PiA+PiA+ID4+Pg0KPj4gPj4gPiA+Pj4NCj4+ID4+ID4gPj4+IE9uIDEvMjIvMjUgODoxNyBBTSwg
SmFzb24gV2FuZyB3cm90ZToNCj4+ID4+ID4gPj4+PiBPbiBXZWQsIEphbiAyMiwgMjAyNSBhdCAx
MjoyNeKAr0FNIEVyaWMgQXVnZXINCj48ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4gPj4gPiA+
d3JvdGU6DQo+PiA+PiA+ID4+Pj4+IEhpIEphc29uLA0KPj4gPj4gPiA+Pj4+Pg0KPj4gPj4gPiA+
Pj4+PiBPbiAxLzIxLzI1IDQ6MjcgQU0sIEphc29uIFdhbmcgd3JvdGU6DQo+PiA+PiA+ID4+Pj4+
PiBPbiBUdWUsIEphbiAyMSwgMjAyNSBhdCAxOjMz4oCvQU0gRXJpYyBBdWdlcg0KPjxlcmljLmF1
Z2VyQHJlZGhhdC5jb20+DQo+PiA+PiA+ID53cm90ZToNCj4+ID4+ID4gPj4+Pj4+PiBXaGVuIGEg
Z3Vlc3QgZXhwb3NlZCB3aXRoIGEgdmhvc3QgZGV2aWNlIGFuZCBwcm90ZWN0ZWQgYnkgYW4NCj4+
ID4+ID4gPj4+Pj4+PiBpbnRlbCBJT01NVSBnZXRzIHJlYm9vdGVkLCB3ZSBzb21ldGltZXMgb2Jz
ZXJ2ZSBhIHNwdXJpb3VzDQo+PiA+d2FybmluZzoNCj4+ID4+ID4gPj4+Pj4+Pg0KPj4gPj4gPiA+
Pj4+Pj4+IEZhaWwgdG8gbG9va3VwIHRoZSB0cmFuc2xhdGVkIGFkZHJlc3MgZmZmZmUwMDANCj4+
ID4+ID4gPj4+Pj4+Pg0KPj4gPj4gPiA+Pj4+Pj4+IFdlIG9ic2VydmUgdGhhdCB0aGUgSU9NTVUg
Z2V0cyBkaXNhYmxlZCB0aHJvdWdoIGEgd3JpdGUgdG8gdGhlDQo+PiA+Z2xvYmFsDQo+PiA+PiA+
ID4+Pj4+Pj4gY29tbWFuZCByZWdpc3RlciAoQ01BUl9HQ01ELlRFKSBiZWZvcmUgdGhlIHZob3N0
IGRldmljZQ0KPmdldHMNCj4+ID4+ID4gPnN0b3BwZWQuDQo+PiA+PiA+ID4+Pj4+Pj4gV2hlbiB0
aGlzIHdhcm5pbmcgaGFwcGVucyBpdCBjYW4gYmUgb2JzZXJ2ZWQgYW4gaW5mbGlnaHQgSU9UTEIN
Cj4+ID4+ID4gPj4+Pj4+PiBtaXNzIG9jY3VycyBhZnRlciB0aGUgSU9NTVUgZGlzYWJsZSBhbmQg
YmVmb3JlIHRoZSB2aG9zdCBzdG9wLg0KPkluDQo+PiA+PiA+ID4+Pj4+Pj4gdGhhdCBjYXNlIGEg
ZmxhdCB0cmFuc2xhdGlvbiBvY2N1cnMgYW5kIHRoZSBjaGVjayBpbg0KPj4gPj4gPiA+Pj4+Pj4+
IHZob3N0X21lbW9yeV9yZWdpb25fbG9va3VwKCkgZmFpbHMuDQo+PiA+PiA+ID4+Pj4+Pj4NCj4+
ID4+ID4gPj4+Pj4+PiBMZXQncyBkaXNhYmxlIHRoZSBJT1RMQiBjYWxsYmFja3Mgd2hlbiBhbGwg
SU9NTVUgTVJzIGhhdmUgYmVlbg0KPj4gPj4gPiA+Pj4+Pj4+IHVucmVnaXN0ZXJlZC4NCj4+ID4+
ID4gPj4+Pj4+Pg0KPj4gPj4gPiA+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEVyaWMgQXVnZXIgPGVy
aWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+ID4+ID4gPj4+Pj4+PiAtLS0NCj4+ID4+ID4gPj4+Pj4+
PiAgaHcvdmlydGlvL3Zob3N0LmMgfCA0ICsrKysNCj4+ID4+ID4gPj4+Pj4+PiAgMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPj4gPj4gPiA+Pj4+Pj4+DQo+PiA+PiA+ID4+Pj4+Pj4g
ZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC5jIGIvaHcvdmlydGlvL3Zob3N0LmMNCj4+ID4+
ID4gPj4+Pj4+PiBpbmRleCA2YWE3MmZkNDM0Li4xMjhjMmFiMDk0IDEwMDY0NA0KPj4gPj4gPiA+
Pj4+Pj4+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC5jDQo+PiA+PiA+ID4+Pj4+Pj4gKysrIGIvaHcv
dmlydGlvL3Zob3N0LmMNCj4+ID4+ID4gPj4+Pj4+PiBAQCAtOTMxLDYgKzkzMSwxMCBAQCBzdGF0
aWMgdm9pZA0KPj4gPj4gPiA+dmhvc3RfaW9tbXVfcmVnaW9uX2RlbChNZW1vcnlMaXN0ZW5lciAq
bGlzdGVuZXIsDQo+PiA+PiA+ID4+Pj4+Pj4gICAgICAgICAgICAgIGJyZWFrOw0KPj4gPj4gPiA+
Pj4+Pj4+ICAgICAgICAgIH0NCj4+ID4+ID4gPj4+Pj4+PiAgICAgIH0NCj4+ID4+ID4gPj4+Pj4+
PiArICAgIGlmIChRTElTVF9FTVBUWSgmZGV2LT5pb21tdV9saXN0KSAmJg0KPj4gPj4gPiA+Pj4+
Pj4+ICsgICAgICAgIGRldi0+dmhvc3Rfb3BzLT52aG9zdF9zZXRfaW90bGJfY2FsbGJhY2spIHsN
Cj4+ID4+ID4gPj4+Pj4+PiArICAgICAgICBkZXYtPnZob3N0X29wcy0+dmhvc3Rfc2V0X2lvdGxi
X2NhbGxiYWNrKGRldiwgZmFsc2UpOw0KPj4gPj4gPiA+Pj4+Pj4+ICsgICAgfQ0KPj4gPj4gPiA+
Pj4+Pj4gU28gdGhlIGN1cnJlbnQgY29kZSBhc3N1bWVzOg0KPj4gPj4gPiA+Pj4+Pj4NCj4+ID4+
ID4gPj4+Pj4+IDEpIElPTU1VIGlzIGVuYWJsZWQgYmVmb3JlIHZob3N0IHN0YXJ0cw0KPj4gPj4g
PiA+Pj4+Pj4gMikgSU9NTVUgaXMgZGlzYWJsZWQgYWZ0ZXIgdmhvc3Qgc3RvcHMNCj4+ID4+ID4g
Pj4+Pj4+DQo+PiA+PiA+ID4+Pj4+PiBUaGlzIHBhdGNoIHNlZW1zIHRvIGZpeCAyKSBidXQgbm90
IDEpLiBEbyB3ZSBuZWVkIHRvIGRlYWwgd2l0aCB0aGUNCj4+ID4+ID4gPj4+Pj4+IElPTU1VIGVu
YWJsZWQgYWZ0ZXIgdmhvc3Qgc3RhcnRzPw0KPj4gPj4gPiA+Pj4+PiBzb3JyeSBJIGluaXRpYWxs
eSBtaXN1bmRlcnN0b29kIHRoZSBhYm92ZSBjb21tZW50LiBJbmRlZWQgaW4gdGhlDQo+PiA+cmVi
b290DQo+PiA+PiA+ID4+Pj4+IGNhc2UgYXNzdW1wdGlvbiAyKSBoYXBwZW5zIHRvIGJlIHdyb25n
LiBIb3dldmVyIHdoYXQgSSBjdXJyZW50bHkNCj5kbw0KPj4gPmlzOg0KPj4gPj4gPiA+Pj4+PiBz
dG9wIGxpc3RlbmluZyB0byBpb3RsYiBtaXNzIHJlcXVlc3RzIGZyb20gdGhlIGtlcm5lbCBiZWNh
dXNlIG15DQo+PiA+PiA+ID4+Pj4+IHVuZGVyc3RhbmRpbmcgaXMgdGhvc2UgcmVxdWVzdHMgYXJl
IGp1c3Qgc3B1cmlvdXMgb25lcywgZ2VuZXJhdGUNCj4+ID4+ID4gPj4+Pj4gd2FybmluZ3MgYW5k
IHdlIGRvIG5vdCBjYXJlIHNpbmNlIHdlIGFyZSByZWJvb3RpbmcgdGhlIHN5c3RlbS4NCj4+ID4+
ID4gPj4+Pj4NCj4+ID4+ID4gPj4+Pj4gSG93ZXZlciBJIGRvIG5vdCBjbGFpbSB0aGlzIGNvdWxk
IGhhbmRsZSB0aGUgY2FzZSB3aGVyZSB0aGUNCj5JT01NVQ0KPj4gPk1SDQo+PiA+PiA+ID4+Pj4+
IHdvdWxkIGJlIHR1cm5lZCBvZmYgYW5kIHRoZW4gdHVybmVkIG9uLiBJIHRoaW5rIGluIHRoYXQg
Y2FzZSB3ZQ0KPnNob3VsZA0KPj4gPj4gPiA+Pj4+PiBhbHNvIGZsdXNoIHRoZSBrZXJuZWwgSU9U
TEIgYW5kIHRoaXMgaXMgbm90IHRha2VuIGNhcmUgb2YgaW4gdGhpcyBwYXRjaC4NCj4+ID4+ID4g
Pj4+Pj4gSXMgaXQgYSByZWxldmFudCB1c2UgY2FzZT8NCj4+ID4+ID4gPj4+PiBOb3Qgc3VyZS4N
Cj4+ID4+ID4gPj4+Pg0KPj4gPj4gPiA+Pj4+PiB3cnQgcmVtb3ZpbmcgYXNzdW1wdGlvbiAxKSBh
bmQgYWxsb3cgSU9NTVUgZW5hYmxlZCBhZnRlciB2aG9zdA0KPj4gPnN0YXJ0LiBJcw0KPj4gPj4g
PiA+Pj4+PiB0aGF0IGEgdmFsaWQgdXNlIGNhc2UgYXMgdGhlIHZpcnRpbyBkcml2ZXIgaXMgdXNp
bmcgdGhlIGRtYSBhcGk/DQo+PiA+PiA+ID4+Pj4gSXQgc2hvdWxkIG5vdCBiZSBidXQgd2UgY2Fu
J3QgYXNzdW1lIHRoZSBiZWhhdmlvdXIgb2YgdGhlIGd1ZXN0LiBJdA0KPj4gPj4gPiA+Pj4+IGNv
dWxkIGJlIGJ1Z2d5IG9yIGV2ZW4gbWFsaWNpb3VzLg0KPj4gPj4gPiA+Pj4gYWdyZWVkDQo+PiA+
PiA+ID4+Pj4gQnR3LCB3ZSBoYWQgdGhlIGZvbGxvd2luZyBjb2RlcyB3aGlsZSBoYW5kbGluZyB0
ZToNCj4+ID4+ID4gPj4+Pg0KPj4gPj4gPiA+Pj4+IC8qIEhhbmRsZSBUcmFuc2xhdGlvbiBFbmFi
bGUvRGlzYWJsZSAqLw0KPj4gPj4gPiA+Pj4+IHN0YXRpYyB2b2lkIHZ0ZF9oYW5kbGVfZ2NtZF90
ZShJbnRlbElPTU1VU3RhdGUgKnMsIGJvb2wgZW4pDQo+PiA+PiA+ID4+Pj4gew0KPj4gPj4gPiA+
Pj4+ICAgICBpZiAocy0+ZG1hcl9lbmFibGVkID09IGVuKSB7DQo+PiA+PiA+ID4+Pj4gICAgICAg
ICByZXR1cm47DQo+PiA+PiA+ID4+Pj4gICAgIH0NCj4+ID4+ID4gPj4+Pg0KPj4gPj4gPiA+Pj4+
ICAgICB0cmFjZV92dGRfZG1hcl9lbmFibGUoZW4pOw0KPj4gPj4gPiA+Pj4+DQo+PiA+PiA+ID4+
Pj4gLi4uDQo+PiA+PiA+ID4+Pj4NCj4+ID4+ID4gPj4+PiAgICAgdnRkX3Jlc2V0X2NhY2hlcyhz
KTsNCj4+ID4+ID4gPj4+PiAgICAgdnRkX2FkZHJlc3Nfc3BhY2VfcmVmcmVzaF9hbGwocyk7DQo+
PiA+PiA+ID4+Pj4gfQ0KPj4gPj4gPiA+Pj4+DQo+PiA+PiA+ID4+Pj4gdnRkX2FkZHJlc3Nfc3Bh
Y2VfcmVmcmVzaF9hbGwoKSB3aWxsIGJhc2ljYWxseSBkaXNhYmxlIHRoZSBpb21tdQ0KPj4gPj4g
PiA+Pj4+IG1lbW9yeSByZWdpb24uIEl0IGxvb2tzIG5vdCBzdWZmaWNpZW50IHRvIHRyaWdnZXIg
dGhlIHJlZ2lvbl9kZWwNCj4+ID4+ID4gPj4+PiBjYWxsYmFjaywgbWF5YmUgd2Ugc2hvdWxkIGRl
bGV0ZSB0aGUgcmVnaW9uIG9yIGludHJvZHVjZSBsaXN0ZW5lcg0KPj4gPj4gPiA+Pj4+IGNhbGxi
YWNrPw0KPj4gPj4gPiA+Pj4gVGhpcyBpcyBleGFjdGx5IHRoZSBjb2RlIHBhdGggd2hpY2ggaXMg
ZW50ZXJlZCBpbiBteSB1c2UgY2FzZS4NCj4+ID4+ID4gPj4+DQo+PiA+PiA+ID4+PiB2dGRfYWRk
cmVzc19zcGFjZV9yZWZyZXNoX2FsbChzKSBpbmR1Y2VzIHRoZQ0KPnZob3N0X2lvbW11X3JlZ2lv
bl9kZWwuDQo+PiA+QnV0DQo+PiA+PiA+ID5naXZlbiB0aGUgY3VycmVudCBpbXBsZW1lbnQgb2Yg
dGhpcyBsYXR0ZXIgdGhlIElPVExCIGNhbGxiYWNrIGlzIG5vdCB1bnNldA0KPmFuZA0KPj4gPnRo
ZQ0KPj4gPj4gPiA+a2VybmVsIElPVExCIGlzIG5vdCByZWZyZXNoZWQuIEFsc28gYXMgSSBwb2lu
dGVkIG91dCB0aGUgIGhkZXYtPm1lbS0NCj4+cmVnaW9ucw0KPj4gPmFyZQ0KPj4gPj4gPiA+bm90
IHVwZGF0ZWQ/IHNob3VsZG4ndCB0aGV5LiBDYW4geW91IGV4cGxhaW4gd2hhdCB0aGV5IGNvcnJl
c3BvbmQgdG8/DQo+PiA+PiA+ID4+IEFkZGluZyBQZXRlciBmb3IgbW9yZSBpZGVhcy4NCj4+ID4+
ID4gPj4NCj4+ID4+ID4gPj4gSSB0aGluayBpdCdzIGJldHRlciB0byBmaW5kIGEgd2F5IHRvIHRy
aWdnZXIgdGhlIGxpc3RlbmVyIGhlcmUsIHByb2JhYmx5Og0KPj4gPj4gPiA+Pg0KPj4gPj4gPiA+
PiAxKSBhZGQvZGVsZXRlIHRoZSBtZW1vcnkgcmVnaW9ucyBpbnN0ZWFkIG9mIGVuYWJsZS9kaXNh
YmxlDQo+PiA+PiA+ID5zb3JyeSBJIGRvbid0IHVuZGVyc3RhbmQgd2hhdCB5b3UgbWVhbi4gVGhl
IHZob3N0X2lvbW11X3JlZ2lvbl9kZWwNCj5jYWxsDQo+PiA+PiA+ID5zdGFjayBpcyBwcm92aWRl
ZCBiZWxvdyBbMV0uIFdyaXRlIHRvIHRoZSBpbnRlbCBpb21tdSBHQ01EIFRFIGJpdA0KPj4gPj4g
PiA+aW5kdWNlcyBhIGNhbGwgdG8gdmhvc3RfaW9tbXVfcmVnaW9uX2RlbC4gVGhpcyBoYXBwZW5z
IGJlZm9yZSB0aGUNCj4+ID4+ID4gPnZob3N0X2Rldl9zdG9wIHdob3NlIGNhbGwgc3RhY2sgaXMg
cHJvdmlkZWQgYmVsb3cgWzJdIGFuZCBvcmlnaW5hdGVzDQo+PiA+PiA+ID5mcm9tIGEgYnVzIHJl
c2V0Lg0KPj4gPj4gPiA+DQo+PiA+PiA+ID5XZSBtYXkgaGF2ZSBpbmZsaWdodCBJT1RMQiBtaXNz
IHJlcXVlc3RzIGhhcHBlbmluZyBiZXR3ZWVuIGJvdGguDQo+PiA+PiA+ID4NCj4+ID4+ID4gPklm
IHRoaXMgaGFwcGVucywgdmhvc3RfZGV2aWNlX2lvdGxiX21pc3MoKSBmYWlscyBiZWNhdXNlIHRo
ZSBJT1ZBIGlzIG5vdA0KPj4gPj4gPiA+dHJhbnNsYXRlZCBhbnltb3JlIGJ5IHRoZSBJT01NVSBh
bmQgdGhlIGlvdGxiLnRyYW5zbGF0ZWRfYWRkciByZXR1cm5lZA0KPj4gPj4gPiA+YnkgYWRkcmVz
c19zcGFjZV9nZXRfaW90bGJfZW50cnkoKSBpcyBub3Qgd2l0aGluIHRoZSByZWdpc3RlcmVkDQo+
PiA+PiA+ID52aG9zdF9tZW1vcnlfcmVnaW9ucyBsb29rZWQgdXAgaW4gdmhvc3RfbWVtb3J5X3Jl
Z2lvbl9sb29rdXAoKSwNCj5oZW5jZQ0KPj4gPj4gPiA+dGhlICJGYWlsIHRvIGxvb2t1cCB0aGUg
dHJhbnNsYXRlZCBhZGRyZXNzIiBtZXNzYWdlLg0KPj4gPj4gPiA+DQo+PiA+PiA+ID5JdCBzb3Vu
ZHMgd3JvbmcgdGhhdCB2aG9zdCBrZWVwcyBvbiB1c2luZyBJT1ZBcyB0aGF0IGFyZSBub3QgdHJh
bnNsYXRlZA0KPj4gPj4gPiA+YW55bW9yZS4gSXQgbG9va3Mgd2UgaGF2ZSBhIHJlc2V0IG9yZGVy
aW5nIGlzc3VlIGFuZCB0aGlzIHBhdGNoIGlzIGp1c3QNCj4+ID4+ID4gPnJlbW92aW5nIHRoZSBz
eW1wdG9uIGFuZCBub3QgdGhlIGNhdXNlLg0KPj4gPj4gPiA+DQo+PiA+PiA+ID5BdCB0aGUgbW9t
ZW50IEkgZG9uJ3QgcmVhbGx5IGdldCB3aGF0IGlzIGluaXRpYXRpbmcgdGhlIGludGVsIGlvbW11
IFRFDQo+PiA+PiA+ID5iaXQgd3JpdGUuIFRoaXMgaXMgYSBndWVzdCBhY3Rpb24gYnV0IGlzIGl0
IGluaXRpYXRlZCBmcm9tIGEgbWlzb3JkZXJlZA0KPj4gPj4gPiA+cWVtdSBldmVudD8NCj4+ID4+
ID4NCj4+ID4+ID4gRHVyaW5nIHJlYm9vdCwgbmF0aXZlX21hY2hpbmVfc2h1dGRvd24oKSBjYWxs
cw0KPj4gPng4Nl9wbGF0Zm9ybS5pb21tdV9zaHV0ZG93bigpDQo+PiA+PiA+IHRvIGRpc2FibGUg
aW9tbXUgYmVmb3JlIHJlc2V0LiBTbyBQZXRlcidzIHBhdGNoIHdpbGwgbm90IGFkZHJlc3MgeW91
ciBpc3N1ZS4NCj4+ID4+ID4NCj4+ID4+ID4gQmVmb3JlIGlvbW11IHNodXRkb3duLCBkZXZpY2Vf
c2h1dGRvd24oKSBpcyBjYWxsZWQgdG8gc2h1dGRvd24gYWxsDQo+ZGV2aWNlcy4NCj4+ID4+ID4g
Tm90IGNsZWFyIHdoeSB2aG9zdCBpcyBzdGlsbCBhY3RpdmUuDQo+PiA+Pg0KPj4gPj4gSXQgbWln
aHQgYmUgYmVjYXVzZSBuZWl0aGVyIHZpcnRpbyBidXMgbm9yIHZpcnRpby1uZXQgcHJvdmlkZXMg
YQ0KPj4gPj4gc2h1dGRvd24gbWV0aG9kLg0KPj4NCj4+IE9oLCBJIHNlZS4NCj4+DQo+PiA+Pg0K
Pj4gPj4gVGhlcmUgdXNlZCB0byBiZSByZXF1ZXN0cyB0byBwcm92aWRlIHRob3NlIHRvIHVuYnJl
YWsgdGhlIGtleGVjLg0KPj4gPg0KPj4gPk1vcmUgY291bGQgYmUgc2VlbiBhdCBodHRwczovL2lz
c3Vlcy5yZWRoYXQuY29tL2Jyb3dzZS9SSEVMLTMzMQ0KPj4gPg0KPj4gPlRoaXMgbG9va3MgZXhh
Y3RseSB0aGUgc2FtZSBpc3N1ZS4NCj4+DQo+PiBIYXZlIG5vdCBhY2Nlc3Pwn5iKDQo+DQo+SXQg
c2hvdWxkIHdvcmsgbm93Lg0KDQpZZXMsIGV4YWN0bHkgc2FtZSBpc3N1ZS4NCg0KVGhhbmtzDQpa
aGVuemhvbmcNCg==

