Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AF6C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 01:48:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3nS2-00019X-57; Sun, 05 May 2024 21:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s3nRt-00015r-GJ
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:47:25 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s3nRq-0003IS-QL
 for qemu-devel@nongnu.org; Sun, 05 May 2024 21:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714960044; x=1746496044;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IJeGVtcaKMRFyOSzI9r6lv4s44eF9OqggwCtiJykImA=;
 b=PuqIvd8BWJtOlcqVAlVnpsA/XA3HNyHev3+1nH8+CrnX6nScsS18/jC6
 7lgQXQ1Xw9ZrvjXyjAufC/3FZ0Uu2VHJe1aEVlsS7VCLHIT7qe4qB6QW5
 MYvKrhNfKbxnCb06+8+dUjqFS7cV7GypwJmi0w96ZjiH+Hf7KWsrOW7Bc
 F77Au/ic8KyAMGQCb+2+ck9W4NNAHTMPWDKubZ3pz6toz8b8mzKO3+9gE
 +7p9OSvlzkNvqXaG6dGhn9dE5flzvymC0Y5WXufvFM+TTRvgbjtpxxte9
 R0czUsv3YqIXtdKPnDIQysjphIK4oeb1W4jT1ZxYv4m1eCz/s3qPp5XIa A==;
X-CSE-ConnectionGUID: 1ZKyA7g4RHW96drsWRvoJw==
X-CSE-MsgGUID: mDMHvaR0QrWQ/EDT9TetIA==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="11223844"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="11223844"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2024 18:47:21 -0700
X-CSE-ConnectionGUID: sjbLnqmXTZGXFLH1s0pWWA==
X-CSE-MsgGUID: V6h5RNoeT/Wo/4N3SLuW1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="28519027"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 05 May 2024 18:47:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 5 May 2024 18:47:19 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 5 May 2024 18:47:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 5 May 2024 18:47:19 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 5 May 2024 18:47:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbhDrC5HRAIdH+rQCMdgpLuFLmZPvNF4Y33qIXLFxwa5T94yroEgwK8TxYbDSwiBytDzIIqWIZPjU0Jg0Wi/5PyNbBKLfsQ2mG7Bapgs/8kt/ixj8cuyylPFVUHlvmdSjOIJBDtFudoPLYB06oU4WgobC+9Jlyknkr8uMl5yN3plJZXABivUGS7DWpoENXGIud9k0Bos3QoL0sKlK881U9U7512Bd8TWo5GBMyvD07UldUh8gb5NisX0vDa1Gnv52fcf6yAy/HBpHGc2IjWaXAlViL7vjWiJ67uk5z6FIAvKR+RqsTzyH2Qwq3nvZo+zYZH4krUXq1gsByXuwjLPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJeGVtcaKMRFyOSzI9r6lv4s44eF9OqggwCtiJykImA=;
 b=kJqcqzgH6SWaesrvjPnjoR48UkcBaNNjo80k4YYk9GWYHMh0asyQO7Ncrv49iJoUCFORxjWyzag9d4QLD+DUPj3p/uFOAz9EBQlcxh4eq/t0SDLtcZrSLPJtTJs64U4h8sXkFBN1ScOj95t1rswdsROtPl5d4jQVGAMz3yRFnEW+10fai6JWa0iqt5ZxVvQs3udoIPHpEEkh5mGzRSt2Zcdx2dFVsnA1bH0I4fx7RAKTGXcioqpAX+4KlkZhtWn/OMBCsTOaM72n8/FhDbUxeHrT/OTPzkx6xMt5J+46UDt7kp8N5UXTC1BEjCBJlRl7IwyISiL0hbXXGrod5KrNXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6380.namprd11.prod.outlook.com (2603:10b6:510:1f8::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Mon, 6 May
 2024 01:47:12 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 01:47:12 +0000
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
Subject: RE: [PATCH v3 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::check_cap() handler
Thread-Topic: [PATCH v3 11/19] backends/iommufd: Implement
 HostIOMMUDeviceClass::check_cap() handler
Thread-Index: AQHamgISrtOEAFqTuEa3yBgglOPHg7GAkSsAgAAE4yCAACVMgIAA38OggAIDW4CABdq38A==
Date: Mon, 6 May 2024 01:47:12 +0000
Message-ID: <SJ0PR11MB6744798B79008487584F84F3921C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
 <20240429065046.3688701-12-zhenzhong.duan@intel.com>
 <dccbba66-57c9-45de-9fa9-beb7b528e0b1@redhat.com>
 <SJ0PR11MB6744DC907835CB7FEF992EA7921A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <47877e84-cf7d-4b51-997a-f61cd208a55c@redhat.com>
 <SJ0PR11MB674486E8B903DF6B182936F492192@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <241f5575-b177-4d38-91e5-e6f3ad276a05@redhat.com>
In-Reply-To: <241f5575-b177-4d38-91e5-e6f3ad276a05@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6380:EE_
x-ms-office365-filtering-correlation-id: 8ac8693f-fd4b-412f-2230-08dc6d6e7334
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|7416005|366007|1800799015|376005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?ZDJuM1ZjeVNCOWI4RVN1Z0ZiZ0h4bDNveldVdEw2UWhRVHo3dUlCZ015RjJ3?=
 =?utf-8?B?WUlRaU93QVFXZ3BhbUp6OUdPTVRNeXVndUh5MkgyV25HUUh5eCtWRnNnTWFn?=
 =?utf-8?B?cVNFQVhNT1B2aVdJUzNaRzc2WmtKaTc5OHVwdngrUE5rcndSTkJDYUFrZnBk?=
 =?utf-8?B?TG1yOVZmRU12MXNySEVHQ3pkMU8xQXlXVTFxYlYvTGZsUU9CNGJPOWJmaE9O?=
 =?utf-8?B?TUJSVnZzS2t0ZTFrb3dMN1VMWkd0OHpuU0szOC8rZFdrcDZVM3A1Q3NwNlZP?=
 =?utf-8?B?R3E0Y01WTExIRjFXNmxKbFRhaXN2U29jUnhKeC8xRllWTzh5SDB0M2JjbWlr?=
 =?utf-8?B?cUFFYkU2cUVOM0FnY1p3MllVUmdMMTJrcFN3bkVRay9DT0ppaE9QQzJrajNh?=
 =?utf-8?B?NW1maUl2U2hYV3g4R0IxRzZxL2h6b3NDZWxCMDJuaVkrMDNETEswNWV3SFZ0?=
 =?utf-8?B?elZpSU0yQnFFRXJTZ1lLNlRlSzZSc3gvQkJmN0RoazZPWHVHZlU5WlVYVTNO?=
 =?utf-8?B?OUxBdDJGZ2p2M0d5U2V2NVJ2NWtIL0xnUFRkalBFL0xwcG9lazUwaWNiWWZn?=
 =?utf-8?B?WmpxOWtuRmt2UWNtVTJsZG9iN0YxN0VNL01nTW9jeXhnUUx1ZTFNUjZqOEN3?=
 =?utf-8?B?K3dObEovU2dSZlVGSkxOZXlJcjZyK1NwT01Sampvczg2M1BDcDVKWE1VM3hn?=
 =?utf-8?B?c1hJdWJSbDlOTFFncnRuNFV2cmd0SlQ2ZGJQMWJVMHNjTW9tWnhLZGpmVFZS?=
 =?utf-8?B?NFNhRmdkaEhsRUUvamhLYXcyWWNsWHkvL0tFT1ZUMnlXUkVXR1hhMUxienFl?=
 =?utf-8?B?WHVIbUNUNkMwcENFSm9DeUNaYzRiRVk0QzNUWEp2TDdQSE9DZEdMMUEzcCtT?=
 =?utf-8?B?aTRURmtIS01TVWdZMjQrRjlFNklCcHhsam9PVVZBQ2JJT3doM3Zib2tnSTlZ?=
 =?utf-8?B?Y2t5ZVhCejRnc2xuYzdJOEhERllCa0M5VC96MDFBMmdFV2plYi9rWDBnL1A0?=
 =?utf-8?B?TkVYWE1Xd2o1c0RQaTZFNmdEd2l5REdFZVJQaHRWS0UzcWRDcVYyS1BaUlE1?=
 =?utf-8?B?WXBwNkYwWEhrNXpuYWZyUWZxK2srbHcyN0h5U1hTNG8xWmRwZ0hmblZDcDBB?=
 =?utf-8?B?bnF0eDdqYTQxbjhVNXEvYnV1bndCVEMybENweHc0U2tKcG9RNVpBeFR5bG1Z?=
 =?utf-8?B?SzFkMVlFbVpSdGtxMmhtVHZpcEdMcGVWS0swTjNoY1UvRGFVRS9pN2ZTb0Z0?=
 =?utf-8?B?RjhHTUIrOTNXQmZmdVcvZllqZmtkRXlVTmpZdDF4Z01XUFJMeWRMR1F6T29W?=
 =?utf-8?B?R09QSVFYY21ha09MUU8wejFTaXZPWkt5Z3dGWUZCVGpxL3Brc3JnQ2NEWXV2?=
 =?utf-8?B?cmVaUGEvU0I3bGxHVWVsRS9XRURtcVN0V1ZNWlBnRDF3WC9hcE9aOWo0NFFQ?=
 =?utf-8?B?S3pEZWdtWkVwakhmRXkrYkR1NENvWVBzemVQRmQwUXNWakZ4QVh5SWxlNmV2?=
 =?utf-8?B?cVFsYTI5YW9wb2xGTWo1dzhySEpSc0E4cCs4Y2tMK01oNXlRNndjdlZFV3BK?=
 =?utf-8?B?NGZLakllRjdJcmhhZjArbzR3UlRtTk13MnowUHFSck1HY0ljRk5CUGpwWld5?=
 =?utf-8?B?aERycGplbmNLSUJPUzZLRW9IRlhjZGNIUXVRMDlnNkkzaks3K3AyK005Mkdt?=
 =?utf-8?B?L3VVazRNdlNFQ2d5Qkdyak9ETGdkTzNRWlZxZU5sWXFxeHVCOXF0cTBlRGIr?=
 =?utf-8?B?dzZpT1JvNDBXTStsM2VHVUhldFhDRy9RZG5hYmtHdXMrU1JXcmZIMWZLZkd4?=
 =?utf-8?B?ZFQ0akpxeW00VU0rQ3UvZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(366007)(1800799015)(376005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHk4WFp6MWhHdGVDVk5iL3I4dHJKMUE3RTBXT3d3T3lmdi9ZTzVKZ25wSFVz?=
 =?utf-8?B?VnVteUUyeGFNdFpXay9jdmxlR2VRUm9qMlNkVXRZRWNhaU4rZmF1VmU0NVRy?=
 =?utf-8?B?TFdRcDZZMXlVUSt6VG52QUZqS2l4blpQQ2l1RUQ0aGk3cW9sZHZpSjZrTUtW?=
 =?utf-8?B?NldNUFVyQmw4THhBQVM3QUZxTklxZXEra2JBZ1dFV3BMRXYyODB2RUw2dmtk?=
 =?utf-8?B?RXJpUi90ZlhzRUU0RkJHRlgzUGszejNKMVl4b1hxc2R4QW10NnlCalp6ellI?=
 =?utf-8?B?cG5vMStrb0I3d3BNbnVnbzdnRTNFTkpxa29PeXdnNWFCZkk0cDBjUWI1YStB?=
 =?utf-8?B?dnhjTjVsRlFac3VkdTA4bFNGcUZzTjNNaFRMdisyV3BBYURycUdreGVxd1V1?=
 =?utf-8?B?OWltNHNDc0N5NmNuNzg3aktLY29iL0wrS3VWUk5haXIxdWFEZkdSYitJU0th?=
 =?utf-8?B?YVVpRDNDU0VibmNRQllQOE03Mys2amIweGp5czZIWXFjMElmRHQ0bGJ3RW9D?=
 =?utf-8?B?ZTNoYUJoQkJrQ0RBSUl4M0lZcnlGdDFyYWhsbStNRk02aXdkYlliWkFxNGl2?=
 =?utf-8?B?WWgwbG5RMWxjMzNUSUJOcDEyZW51cmFCNEtYeS9MS2hndWM4Y1cvRG9LazlX?=
 =?utf-8?B?aHN2eEdINVRyTUdicXhPRWZmQXdybnU4RFRaRG1UYWkvS0w0NXJheG0zMWNo?=
 =?utf-8?B?S01IczAxUUlHcHVwdlRoOHV4L0VGOEZYWWlVLytXZ0swVXREdE5QZzZ5b2NH?=
 =?utf-8?B?bHE1VTk5UG1FM3JEN2x2S0hQNVNnSlI5QlNCVVBDM0w3RUlIeWtIQy8vVk1a?=
 =?utf-8?B?bGh3M045NlBoclpDd05tQWtGcGZPMnFSZWd4aStBKzdoVVJidXArNDhhQ3V1?=
 =?utf-8?B?TmlmaXB0TktVMHRYZEVUaThmUzlIZm1QK3ZIZXZnSjNuZjBURkZSM0Y4RjJV?=
 =?utf-8?B?bmpsZDIydWNYYUxPNEE3Z2RqaDFXSzFKSU9CcFZnVmVYTksxakpNVWwvdnMv?=
 =?utf-8?B?R3ZXUmtkbEhxYllkMjUwNWIwZndLNHFaSFNYYnJhS2tGNHJ2d3V5OWlOeGFk?=
 =?utf-8?B?WSt5dnZ4RXJ5NmJETmdGWW8rMWxkRGhNN0RGb1hzcHh0cTEwd3lXemlzVVpD?=
 =?utf-8?B?RFlJTDBxTzEzRkRXSUFkUjBEc3lsUGthM3F1K0NqM01QcmtZZmlhUkZnL1Zp?=
 =?utf-8?B?YU5Db09qQVJzQW1TUFZvT1o2OE9Rdkd4OVZNNmc0S1NhTjdJUGpFS3ZFVVdZ?=
 =?utf-8?B?QUVWSitqUEdEaGJZWHZnZmVvVWxoL2pxQndYaUhpSW9sbzE4NEpLM1hBVXVS?=
 =?utf-8?B?ZlZ2WC9hK0FMblU3MXFQeDFGb3QwRE10QUtrNVYyWXpCVm5aTXRpdEpsbnpq?=
 =?utf-8?B?TjFjVkJmT3J4WkdINlY2VWE3R1FzOFlONkVqZ1FXdmhTdk11b1c3WHFXelRs?=
 =?utf-8?B?M2xvMlloeDhsMHpNRHdxSExGMzRyeUlPVS80SmppN20vYitVcVc4bCtXU2d4?=
 =?utf-8?B?T1JuQ0dXTFRQT3FkUDl3R0gza2Q4UmhBeDd3Y2NEUk1PMXFBZ2U5Z2VibGhM?=
 =?utf-8?B?cDZEZXVZSTVxSWROandlcFZkbGdmODVKRUYydkdZOUNxWVBMR2lpZmRJZWdG?=
 =?utf-8?B?TldjVkJvUFZ5UENjVjFGS0R3YVNscjZlOVQ3cHJMd2hTNFpHNDAxd0xuM1lR?=
 =?utf-8?B?WWhLRGM3WFMxK2lkRGl4ajBra3YzNlFxeG1kSFZ1aVlNeXVkQkZhZjRPS3VF?=
 =?utf-8?B?cFlsZmNicUpCbjZEc1JwekpkWWtjcytHaklnYVpjc1Z5RlVMVE5PMnRnM2Fi?=
 =?utf-8?B?VmhjaUt4WTR0MTJQZHdsam5aTlFHdzFWa05Qa0xDektEZGdseTY0YUV2SDNi?=
 =?utf-8?B?MWJnbFNmc09lVGhaYXFqMXBPYmYveWt4R09NSUZIalRPeitMWS8xdWdYRjJN?=
 =?utf-8?B?UjZySGRZVk0vc1hUT21kRUlVOXBpNVk1cmN5Wi9jZk11a2ZDNnBqWElIYm1r?=
 =?utf-8?B?ZlhSb2RCWno5UmhnWUhxbUlxQ0JpTytEc2VvVzR5N1ErUDU5VzFONHFXNHNV?=
 =?utf-8?B?OHIzRFNhN1dPMDhBRjhhZ2JhSnZ3N3VObjFsTHBHUy9HdlhaVGM2b1QvdmVN?=
 =?utf-8?Q?2lb9evobJyx7szJX8pgDCMxx6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac8693f-fd4b-412f-2230-08dc6d6e7334
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2024 01:47:12.6134 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rtVZYseBdD9wecOYvz8hebTuZgFX5oFesHh0S8DShFAvAxkVJHNg5RMJhpulImsqflmLa51jQWMaIji+8xWUOXRN8jJB9HHREBp0prTWIug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6380
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNs
Z0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMTEvMTldIGJhY2tlbmRzL2lv
bW11ZmQ6IEltcGxlbWVudA0KPkhvc3RJT01NVURldmljZUNsYXNzOjpjaGVja19jYXAoKSBoYW5k
bGVyDQo+DQo+Pj4+Pj4gK3N0YXRpYyBpbnQgaGlvZF9pb21tdWZkX2NoZWNrX2NhcChIb3N0SU9N
TVVEZXZpY2UgKmhpb2QsIGludA0KPmNhcCwNCj4+Pj4+IEVycm9yICoqZXJycCkNCj4+Pj4+PiAr
ew0KPj4+Pj4+ICsgICAgc3dpdGNoIChjYXApIHsNCj4+Pj4+PiArICAgIGNhc2UgSE9TVF9JT01N
VV9ERVZJQ0VfQ0FQX0lPTU1VRkQ6DQo+Pj4+Pj4gKyAgICAgICAgcmV0dXJuIDE7DQo+Pj4+Pg0K
Pj4+Pj4gSSBkb24ndCB1bmRlcnN0YW5kIHRoaXMgdmFsdWUuDQo+Pj4+DQo+Pj4+IDEgbWVhbnMg
dGhpcyBob3N0IGlvbW11IGRldmljZSBpcyBhdHRhY2hlZCB0byBJT01NVUZEIGJhY2tlbmQsDQo+
Pj4+IG9yIGVsc2UgMCBpZiBhdHRhY2hlZCB0byBsZWdhY3kgYmFja2VuZC4NCj4+Pg0KPj4+IEht
bSwgdGhpcyBsb29rcyBoYWNreSB0byBtZSBhbmQgaXQgaXMgbm90IHVzZWQgYW55d2hlcmUgaW4g
dGhlIHBhdGNoc2V0Lg0KPj4+IExldCdzIHJlY29uc2lkZXIgd2hlbiB0aGVyZSBpcyBhY3R1YWxs
eSBhIHVzZSBmb3IgaXQuIFVudGlsIHRoZW4sIHBsZWFzZQ0KPj4+IGRyb3AuIE15IGZlZWxpbmcg
aXMgdGhhdCBhIG5ldyBIb3N0SU9NTVVEZXZpY2VDbGFzcw0KPmhhbmRsZXIvYXR0cmlidXRlZA0K
Pj4+IHNob3VsZCBiZSBpbnRyb2R1Y2VkIGluc3RlYWQuDQo+Pg0KPj4gR290IGl0LCB3aWxsIGRy
b3AgaXQgaW4gdGhpcyBzZXJpZXMuDQo+Pg0KPj4gSXMgInJldHVybiAxIiBkaXJlY3RseSB0aGUg
Y29uY2VybiBvbiB5b3VyIHNpZGU/DQo+DQo+SSBkb24ndCBrbm93IHlldCB3aHkgdGhlIGltcGxl
bWVudGF0aW9uIHdvdWxkIG5lZWQgdG8ga25vdyBpZiB0aGUgaG9zdA0KPklPTU1VIGRldmljZSBp
cyBvZiB0eXBlIElPTU1VRkQuIElmIHRoYXQncyB0aGUgY2FzZSwgdGhlcmUgYXJlIGFsdGVybmF0
aXZlDQo+d2F5cywgbGlrZSB1c2luZyBPQkpFQ1RfQ0hFQ0soIC4uLiwgVFlQRV9IT1NUX0lPTU1V
X0RFVklDRV9JT01NVUZEKQ0KPm9yDQo+YSBjbGFzcyBhdHRyaWJ1dGUgZGVmaW5lZCBhdCBidWls
ZCB0aW1lIGJ1dCB0aGF0J3MgYSBiaXQgdGhlIHNhbWUuIExldCdzDQo+c2VlIHdoZW4gdGhlIG5l
ZWQgYXJpc2VzLg0KDQpHb3QgaXQsIGxldCdzIHJldmlzaXQgaXQgaW4gbmVzdGluZyBzZXJpZXMs
IHdpbGwgZHJvcCBpdCBmb3Igbm93Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K

