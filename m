Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF7FD111BB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 08:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7sF8-0003dA-Uo; Mon, 04 Nov 2024 03:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7sF3-0003cq-C0
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 03:15:21 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1t7sEx-0002w9-MP
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 03:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730708112; x=1762244112;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iep9v3/ppqNL7VO1ucGn2+/aVFE55tdPal3kOet+GNE=;
 b=joMHfwlU94mSmWNWmKP1FXPDhHGpDeDvJT6s1XomV87ayQ+31nma6dnn
 0DMTKuXU03YcwarUaHzcnKdRRhoL3O+aFsOhySSy9HlWzP0zaXUoZ5bvg
 5+ygvtfn4P0KcxSfU/UxC0N/VsEkN1OhdPgX1S1E6sW3Yc5wphGS56z7A
 2RTmFr7neg2UKNQLD9WFcEtE5maH9zjuNq+jgPiLubpG+2IDIeQAhc3Qf
 wlxtP+oLwXvUZDVUIJPONQRiOjtOMljJbb1nW8fr9EB5Do28zp/XtZ7Ct
 /UcpeccPgAfkByqADDE68KcuoAPL5pTz09HBhuHb1X6Q+7XYyVFQ1Csb/ g==;
X-CSE-ConnectionGUID: C+Kkj73XRBO8nDMmTmX7Vg==
X-CSE-MsgGUID: hbRkumGXTnuP2gfKCOIySw==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30613290"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="30613290"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2024 00:15:07 -0800
X-CSE-ConnectionGUID: XZ8A3g3dRoyXqC8XcZFlfw==
X-CSE-MsgGUID: 4NnYgviiT/OazG2Zc8wODw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="83709632"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Nov 2024 00:15:06 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 00:15:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 00:15:05 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 00:15:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SIwCDvt8Aa9cdl6v/Cp6dywRgE/5dDL5HsFkLXliFhj4HiSTkCRTPntGeaXPnMHVtj1us4/8OuSCMU1nIN9MukcsZoVqOEx3Eo7BKkU0poFMXAu22cvrlKWWnMlSBGzOkAh5Iiy9TTaS7mW4gHJQ2Bdjj6Zlq1nxWooNL4psfkQCKEVHV8+8JVcs0zU60ORPc4nn1i9nC39pQJqvUn3mYkMak77VuoKGyramYQf3O6uzM5t1ueO0uTDlNZqjoTcL7pXz7yAO75M7o0nNl4DpPg6P3dmQ/6WtPRsYOoAkiDrHBPXcnf+RC8vWa7JUExzDCSCF+qlXfK99oZ0ze+wYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iep9v3/ppqNL7VO1ucGn2+/aVFE55tdPal3kOet+GNE=;
 b=axTyOKiEO5v+0t/nKkRY9D/AU66qG+w5H2XllotzhCw0fv05jIzY1YGyQdCw3InfEXpCICluLwwc2h4mI7ADB92CaF/8LRV+4OCc+PqQ/JlsljG2uXbF5BToWl9LiZX3bJD0vaz8TFmJFxsMGbNg30ST/D9RbxiwPWrEKYWFMuew94KJDwTvPgQG3GpC2cAAk9Ouaw+Gak6v9SQg8XE9jVsA7QVuE4vI9Wj82gLEYIQch3x4JbkR8jCj1itDnz+lsvzkvUFVBTLW0JTZgoPUwTqyKul63qepZSUz1uEhk/xflpPPGQrkCRZCSoM68NzYcshTO38h+5lCAM6fG8MkUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5038.namprd11.prod.outlook.com (2603:10b6:a03:2d8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 08:15:03 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 08:15:02 +0000
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
Subject: RE: [PATCH v4 13/17] intel_iommu: piotlb invalidation should notify
 unmap
Thread-Topic: [PATCH v4 13/17] intel_iommu: piotlb invalidation should notify
 unmap
Thread-Index: AQHbExt/KmB69XpnZUKNIck54DJye7KmpouAgABOO8A=
Date: Mon, 4 Nov 2024 08:15:02 +0000
Message-ID: <SJ0PR11MB6744E7B5833C645A0E17A3F692512@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-14-zhenzhong.duan@intel.com>
 <2d2c2515-6a74-4e81-8ab5-0390aa59f6dd@intel.com>
In-Reply-To: <2d2c2515-6a74-4e81-8ab5-0390aa59f6dd@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5038:EE_
x-ms-office365-filtering-correlation-id: 93b0eb53-7e57-46e5-bda4-08dcfca8c87a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?amtreTFVVWRNSWZuMWhqTEovSmlETi9oL1R4WXJOWUN4M2lHWWN6NkxVL2Jq?=
 =?utf-8?B?aUNDQXByTm42NEFNTUFEajBqRVlzRGpJMFNHMzh3THAvdmlidkF4ajU1LzM0?=
 =?utf-8?B?Y0JHTkcrYzRyY21sR2J3bktXWFpDN1pKWWY0YzRqOER1bFFmei9LQlY2OU9W?=
 =?utf-8?B?VnhWbHpKU2p0b2l0NTd4Rk9GMEY3Z1lJSHlIbm9ZbzhRQytvWEhCb0cyZmVs?=
 =?utf-8?B?c0k5bVcrcmdYQnFFTzFUMnlFdVdROVBweUw5dXdjbTZlMHBtZEhHdWN6QVlB?=
 =?utf-8?B?YUtPL1RBUUVEVE91b2NKcldsNzN3ZGVxTXRTL2Y1ZGZrU0oxbzRtK0R1emo1?=
 =?utf-8?B?cUFycnh6cTBaSWsrc2hidEo1YVpnWEJoZWUya3RqU2lCOVB6MmxQNFMyZ3ZJ?=
 =?utf-8?B?SmxQV1JnTVQyL0lodjF6VGNENVlncTBuN0ZrNW5qanBxclJVQnlqMjFnbS9j?=
 =?utf-8?B?T0RYSlNtbDB2TjJIdDhOdElqY0ZKREZIK3dpYnlUdU5PNzZJcGlEYU56d2VR?=
 =?utf-8?B?K3ZlMzczdVZkclo3aE82cFd4MGNzTWxwM0c2Q05xczR2MENZaXZZK0w2cS9z?=
 =?utf-8?B?c1lLSjdraFZLN0h0VExMOE15dm1ZMUVQeDJZU2tLc2E2N3F4WmVUU3JGYlgv?=
 =?utf-8?B?QjVZaGVDelpsWVQ3MmwrQXlzc3lWd1JLVzhCV1FYajZPTkYrKzFaVHo2RHNP?=
 =?utf-8?B?dTFheFQ3YS84Q3VnNkVaTFFkWUFBcVg2Q05ENUIxeGVlR1lTSmIwRlJ1SmdK?=
 =?utf-8?B?TmlUTnpuUk1hcDQ1N1U5WTAyaXFYY0FlWUtOOVVvWnlTdDdkL0NsRkVqNnQz?=
 =?utf-8?B?bGMxZzRobTE1YXNibXplQlVYUGlKRTlvSWR0bVNqUGlwRmRmTG95dndFZ1l5?=
 =?utf-8?B?VmgvM09yWjBzSnhneGh4NkNVdkkxZ0ZMM1dDSjB6UDRyZUNUbGtaUittOTdI?=
 =?utf-8?B?NjhncXc0SnV4MmZLRVI5OEZlRkorNm05RDE3SitJd3ZNbHhZckpwcndlWnB0?=
 =?utf-8?B?RFhKRGwwaUJGU2FIWHZtTzlKdmdHQU1xWkpUY2lCUkJyZXFRZ0oxUHllNVIz?=
 =?utf-8?B?N1YwczdsZ3hUMEZJM3VpK2JUaXkrczVKRWkxZVdSZlBXL1NUTklnOGpsa3Vz?=
 =?utf-8?B?VFN3c3ZWdUhTY0xTNnBHOVJvaitkOU5LUFRKOTVFWk1vdzZnU2s3OU9KaFpS?=
 =?utf-8?B?a1p5Z2UyV1lFdnhIWmRVSFVVR0RScFNhK1BHV3c5dkp3cUxFR1k4WjNYWjhs?=
 =?utf-8?B?ZDJ1a1ZrUnc1N1loekRYSGs3b1ptN0dhSEJqTSs1VDg4enRTdDBSc0JBWEdR?=
 =?utf-8?B?NzdhTTNJKzNKSndTTUNUdytPL3p1V1pOUjdvaHpNZ1pZamFrTHozN1JvL3Er?=
 =?utf-8?B?WUtjaWtPckUxUDJjOFZkc1NUeEg4MmU5Wi9acTh3UU1NazBJUXNMWlFNL25r?=
 =?utf-8?B?c08va1hpOHpHNWZ1UExrS1lsdVNqV1lwZ1F5bnc2N0Q2TEpBQ1dOYkE4OFNM?=
 =?utf-8?B?Tk5DR0dVcTBIVVV0QU8vNnhwZUd6alVCMUJkcVpCRXNnT1NkN2Q3ZHl5Q09r?=
 =?utf-8?B?ZEJQVE9zSGJvYS92cW9xOFVvM1h3bVJMQThKTGttU0FPNWF1dmhEeXd1MTNo?=
 =?utf-8?B?UzhvM0s3K1dBTjBlQy9LeTJZWnpUN1RNS090VUl5a0JPWnVVVEptTGFPS1RB?=
 =?utf-8?B?d1BCVlZpSGxQS2RqM2tLd3MvVlN2aHpnK1ZucE45TXRza1R6bGRSdHQ1Y09E?=
 =?utf-8?B?RkM5ZE4rdEdpcnZ0VXVKK0hxdG4xVGc5MXZ5a2pPcU91VWNpMFBoUkJsSmhP?=
 =?utf-8?Q?rpPZmjyPjijLpSMuSff4V5vmbjDl/MlR5AkxQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qkc3UG40NXNxT3VjREFmZ2FVTmxTclFuc2hVbk1INlBPdkozUlZ2Titic1JF?=
 =?utf-8?B?MUpmSjY1OUVTSjAybDYrRGhRdzdGbWRwWU1zRzcveHkzQy94dnFiYVROdzFH?=
 =?utf-8?B?RzExVXliaUtzQ05DeVZPOFo4ZXVhTSt4N1FRRzhXZ1NMTGZ1VjNoTHFVeS94?=
 =?utf-8?B?MjFGZG1XZG1MRHhrbnBFV3ZUMU83N1pZVEx5OStRSW40dE14SjV3RUdhcFNs?=
 =?utf-8?B?a1hqb2pRSWlaYVpuQ0hMZmM1TU92d2VubzFHK284V1dURno1NjNQa2hjckMw?=
 =?utf-8?B?UFl2VzVUSk5lUGJnaS9ySlA2MUNtcm1ja2tySjd0ZTRxRUJLc05DTkZ2YzN1?=
 =?utf-8?B?MVZHOWJVMVd0Ri9ZRldZVXFJNlprSmxMSUZKZkFVdFQ4dkgyNXEyWDkrdkto?=
 =?utf-8?B?ekVuZ3ZBZzEyV1pBbEJlai9GZS90aStJZHdTRTZFZ0FVcEtGSjJvdEFmQ0J2?=
 =?utf-8?B?Y0NNRnBMZWVsVXZIWnp3ZkhNRHlMMElpYmptK3dpRStIdThFZUR6V014MktF?=
 =?utf-8?B?cWUzM0s2TnlPU1hIOXduUUNKZG0rMUFpUXJFVFQvOEVhdDZzQzJ0Z1d1M3Qr?=
 =?utf-8?B?aGI3WTQrWUYwZkM3Sm1SVkdNYUFqYlFid25oc2RISGtSTTV5YnZRSEtYVjJS?=
 =?utf-8?B?Ni9saG5xd2FXYVFRbWd0Qnh5OXMyZmxZb2JrQzhVQjNaZlVvcldJa3poeW9H?=
 =?utf-8?B?UTZHdHZ4K2NjaVFXRTZ4by9mUzJXTGF3TWt6YTdERjB6VDR0TW5DV05TdnZu?=
 =?utf-8?B?RXQ4My9ENkRFT1VQQmV6Q2h1eHIrVis3RzNydmJwdmhnNzA0M1JZQnZDYmVw?=
 =?utf-8?B?cUgyNGI3VnNxMjFVdmFrbU9wQU9zYUx0S0pMemRJblJUL3U3MDdwU1NlNjBi?=
 =?utf-8?B?NFRzejJVd05HeTJPZ3JtYmlweTdYdFpRL1NvV0Y4UTJWT1BLeFJNQWdxMTBW?=
 =?utf-8?B?M3pIZ1pid0FiSnU3UGdvcTkyS1RLdWJRZUZkYjdqd2h5OE53VktWeFk4VXRK?=
 =?utf-8?B?RG1yMmNwRmw0ZXFjMFVnajF5WnlXRTlFQTJqL3Z2UnlNSllRRlhvYWVpQ0Vy?=
 =?utf-8?B?dXRNbEZmVWZ1Q1J1R25RNmc0K0t6NXpBMGt1b3hKRzcyTmI4azg3cEoyeWlu?=
 =?utf-8?B?Ui9ZbWlBdTBDU1NVU01ncWtLQ0xrMll2dy9SRFo4SkFpbGxMZjlXd2pVTUhX?=
 =?utf-8?B?UVlCeFpCTjI2WEthUEZRQlN1Z1NMU0tHQnZhWlBOK0U5M01nOXU2d2M5dUhL?=
 =?utf-8?B?OUxFeWNXMWdxdUxWcUM1aHFOOTRqQlM4NW5GaGxlNlpmZmMrMTBZU3B5ZTBB?=
 =?utf-8?B?YUphcmNaVHdINmVibDlqUFBKYU5ESFBKRmM3elEvc3JTV2VrQWJDb29XNzRZ?=
 =?utf-8?B?RFF2QjhYQ1RETXN5bTJxazNWZ1o1bmFrY2VKem9rWW4yMEZsNW5jMzZVVXMv?=
 =?utf-8?B?V3d4ZGN0Ti9KN28remNaTFZqQ0pHaDl5VGVKQTY0bVdxK1VkTXhPTnFyMVhD?=
 =?utf-8?B?aUY5VzZrbWwrV0ZUeHN1VU5SalJJZlRZVFBkUGhFOUNyck5ESHJmbDlBWE5I?=
 =?utf-8?B?dklGK0lQTjMxZDNnZUk4NWVkdXpNdnNyL2dacURia2UxVnFFUXEvWnNmbFNM?=
 =?utf-8?B?TGluZVZZSGRicjRKYm91Y01US2grSERhK1N0bFMzUXlSYlgwb3hYZUNnRXcz?=
 =?utf-8?B?NmRsRnRTYzlrdnJtNUZLTHhzbE1iOVl5MWpMeVF1dmtQbWhHRFF3ckdIaVhV?=
 =?utf-8?B?NXI3K2tqM1VWNm9yK0lmWWM1Zmx4MTBLL0R3b2EveGZTTGZoU1pldURBbFZD?=
 =?utf-8?B?NHlPSHhtVW9VVjU2TlpwdDYvTXV1UDUwTU5TNXV6SFJubWhLUEhSbVV0Ukoy?=
 =?utf-8?B?cGdkQ2N6WVlJMUZDYmNLblFaM0wwNXFEb0NvSzM1OUo3ZmxpUEVxaHZtbU9i?=
 =?utf-8?B?RElWWWg5M0hQK0FjVUlXMmtKK1hBK2NDUnlYZXltaHNkMUF5YUFUSUFPeVV0?=
 =?utf-8?B?ZGlSVkpwbUxoV00vZ0dONXJjd1V1a010R3NrK1JmbjZkSTh5aWpCemRBVlc0?=
 =?utf-8?B?c2ZuZ3QzZjZ0L2tEN3UvMVpCVEFUYVNPRHJuTDBNaG5yeXFYeUdPTXRobGhk?=
 =?utf-8?Q?6/rDQYX6Y8ei7ty//kQqjR4Mk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b0eb53-7e57-46e5-bda4-08dcfca8c87a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 08:15:02.7327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGsttb7CHg0VicE607DfbqHfKTPIwj6n5GQAp/GFWefVd+hvxufjU4FA2XoY3fsJyPgdhyTUWcReAjuK+zResLn8cllIo2+0J5HgqVCSmNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5038
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgNCwgMjAyNCAxMTowNSBBTQ0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMTMvMTddIGludGVsX2lvbW11OiBwaW90bGIgaW52YWxp
ZGF0aW9uIHNob3VsZCBub3RpZnkNCj51bm1hcA0KPg0KPk9uIDIwMjQvOS8zMCAxNzoyNiwgWmhl
bnpob25nIER1YW4gd3JvdGU6DQo+PiBUaGlzIGlzIHVzZWQgYnkgc29tZSBlbXVsYXRlZCBkZXZp
Y2VzIHdoaWNoIGNhY2hlcyBhZGRyZXNzDQo+PiB0cmFuc2xhdGlvbiByZXN1bHQuIFdoZW4gcGlv
dGxiIGludmFsaWRhdGlvbiBpc3N1ZWQgaW4gZ3Vlc3QsDQo+PiB0aG9zZSBjYWNoZXMgc2hvdWxk
IGJlIHJlZnJlc2hlZC4NCj4+DQo+PiBGb3IgZGV2aWNlIHRoYXQgZG9lcyBub3QgaW1wbGVtZW50
IEFUUyBjYXBhYmlsaXR5IG9yIGRpc2FibGUNCj4+IGl0IGJ1dCBzdGlsbCBjYWNoZXMgdGhlIHRy
YW5zbGF0aW9uIHJlc3VsdCwgaXQgaXMgYmV0dGVyIHRvDQo+PiBpbXBsZW1lbnQgQVRTIGNhcCBv
ciBlbmFibGUgaXQgaWYgdGhlcmUgaXMgbmVlZCB0byBjYWNoZSB0aGUNCj4+IHRyYW5zbGF0aW9u
IHJlc3VsdC4NCj4NCj5JcyB0aGVyZSBhIGxpc3Qgb2Ygc3VjaCBkZXZpY2VzPyBUaG91Z2ggSSBk
b24ndCBvYmplY3QgdGhpcyBwYXRjaCwNCj5idXQgaXQgbWF5IGJlIGhlbHBmdWwgdG8gbGlzdCBz
dWNoIGRldmljZXMuIE9uZSBkYXkgd2UgbWF5IHJlbW92ZQ0KPnRoaXMgd2hlbiB0aGUgbGlzdCBi
ZWNvbWVzIGVtcHR5Lg0KDQpDdXJyZW50bHkgb25seSB2aXJ0aW8gcGNpIGRldmljZSBzdXBwb3J0
IEFUUyBhbmQgb25seSB2aG9zdCB2YXJpYW50IGNhY2hlcw0KdHJhbnNsYXRpb24gcmVzdWx0IGV2
ZW4gaWYgQVRTIGRpc2FibGVkLg0KDQo+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlpLnku
c3VuQGxpbnV4LmludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiBSZXZpZXdlZC1ieTogQ2zDqW1lbnQgTWF0aGll
dS0tRHJpZjxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCj4+IC0tLQ0KPj4gICBo
dy9pMzg2L2ludGVsX2lvbW11LmMgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4+IGluZGV4IDVlYTU5MTY3YjMuLjkxZDdiMWFiZmEgMTAwNjQ0DQo+PiAt
LS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KPj4gQEAgLTI5MDgsNyArMjkwOCw3IEBAIHN0YXRpYyB2b2lkDQo+dnRkX3Bpb3RsYl9wYXNp
ZF9pbnZhbGlkYXRlKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+ICAgICAgICAgICAgICAgICAgIGNv
bnRpbnVlOw0KPj4gICAgICAgICAgICAgICB9DQo+Pg0KPj4gLSAgICAgICAgICAgIGlmICghcy0+
c2NhbGFibGVfbW9kZXJuKSB7DQo+PiArICAgICAgICAgICAgaWYgKCFzLT5zY2FsYWJsZV9tb2Rl
cm4gfHwgIXZ0ZF9hc19oYXNfbWFwX25vdGlmaWVyKHZ0ZF9hcykpIHsNCj4+ICAgICAgICAgICAg
ICAgICAgIHZ0ZF9hZGRyZXNzX3NwYWNlX3N5bmModnRkX2FzKTsNCj4+ICAgICAgICAgICAgICAg
fQ0KPj4gICAgICAgICAgIH0NCj4+IEBAIC0yOTIwLDYgKzI5MjAsOSBAQCBzdGF0aWMgdm9pZA0K
PnZ0ZF9waW90bGJfcGFnZV9pbnZhbGlkYXRlKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDE2X3Qg
ZG9tYWluX2lkLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBi
b29sIGloKQ0KPj4gICB7DQo+PiAgICAgICBWVERJT1RMQlBhZ2VJbnZJbmZvIGluZm87DQo+PiAr
ICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzOw0KPj4gKyAgICBWVERDb250ZXh0RW50cnkgY2U7
DQo+PiArICAgIGh3YWRkciBzaXplID0gKDEgPDwgYW0pICogVlREX1BBR0VfU0laRTsNCj4+DQo+
PiAgICAgICBpbmZvLmRvbWFpbl9pZCA9IGRvbWFpbl9pZDsNCj4+ICAgICAgIGluZm8ucGFzaWQg
PSBwYXNpZDsNCj4+IEBAIC0yOTMwLDYgKzI5MzMsMzYgQEAgc3RhdGljIHZvaWQNCj52dGRfcGlv
dGxiX3BhZ2VfaW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90IGRvbWFpbl9p
ZCwNCj4+ICAgICAgIGdfaGFzaF90YWJsZV9mb3JlYWNoX3JlbW92ZShzLT5pb3RsYiwNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2dGRfaGFzaF9yZW1vdmVfYnlfcGFnZV9w
aW90bGIsICZpbmZvKTsNCj4+ICAgICAgIHZ0ZF9pb21tdV91bmxvY2socyk7DQo+PiArDQo+PiAr
ICAgIFFMSVNUX0ZPUkVBQ0godnRkX2FzLCAmcy0+dnRkX2FzX3dpdGhfbm90aWZpZXJzLCBuZXh0
KSB7DQo+PiArICAgICAgICBpZiAoIXZ0ZF9kZXZfdG9fY29udGV4dF9lbnRyeShzLCBwY2lfYnVz
X251bSh2dGRfYXMtPmJ1cyksDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB2dGRfYXMtPmRldmZuLCAmY2UpICYmDQo+PiArICAgICAgICAgICAgZG9tYWluX2lkID09
IHZ0ZF9nZXRfZG9tYWluX2lkKHMsICZjZSwgdnRkX2FzLT5wYXNpZCkpIHsNCj4+ICsgICAgICAg
ICAgICB1aW50MzJfdCByaWQycGFzaWQgPSBWVERfQ0VfR0VUX1JJRDJQQVNJRCgmY2UpOw0KPj4g
KyAgICAgICAgICAgIElPTU1VVExCRXZlbnQgZXZlbnQ7DQo+PiArDQo+PiArICAgICAgICAgICAg
aWYgKCh2dGRfYXMtPnBhc2lkICE9IFBDSV9OT19QQVNJRCB8fCBwYXNpZCAhPSByaWQycGFzaWQp
ICYmDQo+PiArICAgICAgICAgICAgICAgIHZ0ZF9hcy0+cGFzaWQgIT0gcGFzaWQpIHsNCj4+ICsg
ICAgICAgICAgICAgICAgY29udGludWU7DQo+DQo+bm90IHF1aXRlIGdldCB0aGUgbG9naWMgaGVy
ZS4gcGF0Y2ggNCBoYXMgYSBzaW1pbGFyIGxvZ2ljLg0KDQpUaGlzIGNvZGUgbWVhbnMgd2UgbmVl
ZCB0byBpbnZhbGlkYXRlIGRldmljZSB0bGIgZWl0aGVyIHdoZW4gcGFzaWQgbWF0Y2hlcyBhZGRy
ZXNzIHNwYWNlJ3MgcGFzaWQgb3Igd2hlbiBwYXNpZCBtYXRjaGVzIHJpZDJwYXNpZCBpZiB0aGlz
IGFkZHJlc3Mgc3BhY2UgaGFzIG5vIHBhc2lkLg0KDQpZZXMsIHBhdGNoNCBvbmx5IGRlYWwgd2l0
aCBzdGFnZS0yLCB3aGlsZSB0aGlzIHBhdGNoIGRlYWwgd2l0aCBzdGFnZS0xLg0KDQpUaGFua3MN
ClpoZW56aG9uZw0KDQo+DQo+PiArICAgICAgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICAgICAg
IC8qDQo+PiArICAgICAgICAgICAgICogUGFnZS1TZWxlY3RpdmUtd2l0aGluLVBBU0lEIFBBU0lE
LWJhc2VkLUlPVExCIEludmFsaWRhdGlvbg0KPj4gKyAgICAgICAgICAgICAqIGRvZXMgbm90IGZs
dXNoIHN0YWdlLTIgZW50cmllcy4gU2VlIHNwZWMgc2VjdGlvbiA2LjUuMi40DQo+PiArICAgICAg
ICAgICAgICovDQo+PiArICAgICAgICAgICAgaWYgKCFzLT5zY2FsYWJsZV9tb2Rlcm4pIHsNCj4+
ICsgICAgICAgICAgICAgICAgY29udGludWU7DQo+PiArICAgICAgICAgICAgfQ0KPj4gKw0KPj4g
KyAgICAgICAgICAgIGV2ZW50LnR5cGUgPSBJT01NVV9OT1RJRklFUl9VTk1BUDsNCj4+ICsgICAg
ICAgICAgICBldmVudC5lbnRyeS50YXJnZXRfYXMgPSAmYWRkcmVzc19zcGFjZV9tZW1vcnk7DQo+
PiArICAgICAgICAgICAgZXZlbnQuZW50cnkuaW92YSA9IGFkZHI7DQo+PiArICAgICAgICAgICAg
ZXZlbnQuZW50cnkucGVybSA9IElPTU1VX05PTkU7DQo+PiArICAgICAgICAgICAgZXZlbnQuZW50
cnkuYWRkcl9tYXNrID0gc2l6ZSAtIDE7DQo+PiArICAgICAgICAgICAgZXZlbnQuZW50cnkudHJh
bnNsYXRlZF9hZGRyID0gMDsNCj4+ICsgICAgICAgICAgICBtZW1vcnlfcmVnaW9uX25vdGlmeV9p
b21tdSgmdnRkX2FzLT5pb21tdSwgMCwgZXZlbnQpOw0KPj4gKyAgICAgICAgfQ0KPj4gKyAgICB9
DQo+PiAgIH0NCj4+DQo+PiAgIHN0YXRpYyBib29sIHZ0ZF9wcm9jZXNzX3Bpb3RsYl9kZXNjKElu
dGVsSU9NTVVTdGF0ZSAqcywNCj4NCj4tLQ0KPlJlZ2FyZHMsDQo+WWkgTGl1DQo=

