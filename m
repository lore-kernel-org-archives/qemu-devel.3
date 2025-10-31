Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 300BCCCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElo6-0005tp-AL; Fri, 31 Oct 2025 05:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vElo4-0005tO-Qi
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:52:28 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vElo0-00081d-7o
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761904344; x=1793440344;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=O/scdNo09uBP/Je4iUK128GkuRq2bTIVfo/itkOuV2U=;
 b=FPasqCx5t6fvi1WYtThP9q4NjmCpXiEQNsfyD5vlT5HEqkThwFOYoOW3
 axJ9IiweuWj8d9leU2KNLlwa7WHGnyo0IpBozq7mJzBvfua7eXvM/+kIr
 G8+T6oGUCwXaKPRYxm0E9KiFT6wy/Uj/EMds2IIen1ybdPnAjS04/DZHu
 D2JRjA7YWqJQd9SdR54wSPDtfSavI9UoO0k4Fj5y28Xk4Xh913ocOJ8a7
 9CZd5GrH4yIE83QQp9TruaNvVnZYe6RddFpF8zUoOCs2lmxPA6HnvtgtI
 vm2CHDNx+HPyhOCYDnxPA1Q7kr/tbt6Z/JZYAFzm+P4hBSM7L1k5SQWEi A==;
X-CSE-ConnectionGUID: jQNt2n45Q2SEp2xxPoUNMw==
X-CSE-MsgGUID: rkL2TW+ATQiAb1sI0FYLFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="67923788"
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; d="scan'208";a="67923788"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2025 02:52:20 -0700
X-CSE-ConnectionGUID: GgP6Iu9TRMqtAJ4U2ZOgyQ==
X-CSE-MsgGUID: zNvUijLpRnCwjzUEdLaBTA==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2025 02:52:19 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 02:52:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 31 Oct 2025 02:52:19 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 31 Oct 2025 02:52:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmpdEiygCD3aLjlcHNsdurlL9pAzJ6FkMVDONdPyDsrn0bxHz+84Q3k8aRnRy0Kt95OgCIWdEUbLKvx3bumkzm9XMckOBKxhDgDzt8a7blxm0iyiX5dtIc12NCk3PHlCdqR1NStp8tMsFTxIunGZMV0IU9zLbj8bZBB3X40j/MHzfi+Z/BjaZ0lnTwOd1IGul8Ofb5JWjRjb2zKBmUgkQIs1QXeYusjVEaf9gbkKfJXnJaxWkfVLRTSalN4BokI4Ef+0uBVXJMSVrPq8CTclKaeqLNvg4v7g4Z7Z9Kv8tCf2pO76addqIibFYCWZ/ZNP7sx19YYvz0qNIO2dzBzDog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/scdNo09uBP/Je4iUK128GkuRq2bTIVfo/itkOuV2U=;
 b=jpA7f7IVpY208DEYPnx3mNgPmKp65YfgCE5UuI0uOi/E19lksZ9WYkiFXz7fMUBftoxfQKcQSnttTgL7ma+azB5z185eZQ4/FRVrFJ2SCvOZSHKwEBqZjkgJ6MGJXxsSHqSJYcNm6R5/Ovc+Nu03szgTiwEqhItPe0gZSRl2pjy61R8W9yKsarIKGFZqzp9prbUePEA3iVVFrD8IbCBvBNXAass5PuZN1irmnK056red4qeCJ1XkaITvbIoPonbFPiTNx2hrHU1I5514lCxblYmodeNV2P2opwV6wTZD23ilJCvmPJ0/HVMpOxsuuj3x8rY2XZJ9q59Az6p3CuPetg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA1PR11MB6712.namprd11.prod.outlook.com (2603:10b6:806:25c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Fri, 31 Oct
 2025 09:52:16 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 09:52:16 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v7 09/23] intel_iommu: Stick to system MR for IOMMUFD
 backed host device when x-flts=on
Thread-Topic: [PATCH v7 09/23] intel_iommu: Stick to system MR for IOMMUFD
 backed host device when x-flts=on
Thread-Index: AQHcRMKJBSJdriWV/0W9AV5g+if9pLTb8bsAgAAUFKA=
Date: Fri, 31 Oct 2025 09:52:16 +0000
Message-ID: <IA3PR11MB9136B987085148D724C0144092F8A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-10-zhenzhong.duan@intel.com>
 <d9eedc35-1548-4011-8eb3-5f6a4dcefe51@redhat.com>
In-Reply-To: <d9eedc35-1548-4011-8eb3-5f6a4dcefe51@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA1PR11MB6712:EE_
x-ms-office365-filtering-correlation-id: ecaba81f-ddc7-4552-14a7-08de18632cd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?QWVKYWJwQUJ2T24vQ2lwR1FoOUh4ZFFyU2JkNGRyOFpVeTFnam00QUN6dHFW?=
 =?utf-8?B?RTlkOElBdzBLR0ErTWFzUTk5dTJ4TkJrcGdQMEJLK01nb2ZSVC9OZzQ0RHBF?=
 =?utf-8?B?WkY4R2VUSUMwK1V4VWdWbXpuUjkzakdoSVR2WDZwU0JJQUFhZEFoVmowQnZp?=
 =?utf-8?B?K2tDTEhMdXFJMCtOQmYzNnBQR0dkcE10dlNSZjVPdmZDdG4yRjdrVXNOMVRi?=
 =?utf-8?B?N21jV2RCT0NqRlNDM2FXUlpCcnd5V3hFUyszLzBaS0NiaDlpaFdvR0tkYnhC?=
 =?utf-8?B?RnN4cmcwMjBrb1FMUVVVamZDQmNmT2FNWFlaNjY1bVg3UWZGTkNsNE44Kys4?=
 =?utf-8?B?TWhPMDBETG55emhaNmdJNXlwK255cFY2QVRmQXgzWkxubkN0UGxZeXBsWGt3?=
 =?utf-8?B?UjR6VlhHTmRYZlArc05IT21xOFA5YStSWW1icmU0dmxIMXcwZ2ZhSU1aZk9W?=
 =?utf-8?B?U0Zma2N0UlRHNzdwSFJ5UjlpRWIycDk5cWJ1V2FiOGpBM2JBN2d6cXN4bVlG?=
 =?utf-8?B?TGh4UzR1dGdoMWt0WTl0OFNKRmVHSms3amRmTm1rZ29LMG1DaEo0aldhL3oy?=
 =?utf-8?B?OWZ3SktqWGhvaDRBVk9WbnhpNGw2SVFPZmNNUmoyQXVlZ3o5cFJBeVQ5Wmw0?=
 =?utf-8?B?RlZONzIrMWJUOHlWSlZGY09iZ244Q20vT1dkUlR5d3BVa2lCQmRmTWN0MzZK?=
 =?utf-8?B?eEFkN2NaVTV5OVJSNloxV2ZoQXhlZTh2K3BtZU1PVWN4N3E0R2MwL2NSdzVP?=
 =?utf-8?B?SXFrYlF5d3hGTlY1dlBnN1oxUUZMc1JrT1dNYXVDckdHc2FOajkvUkVqWG9M?=
 =?utf-8?B?NVE1ZGRINEVCeHJrbWppL0I4MjJDZTB2VjVJVmN3alNhaGl6UmNVRWJIcDFL?=
 =?utf-8?B?aDNJcUQ3VUJhWWtHVHZQeVFpbCswd2g4c0VxUGZBODRlYXpqRE1SQlRGZzVY?=
 =?utf-8?B?eWhOcHRlUG1rbi9aTVFXYkhqNjVNMXpyREpTTmpjVjM4NzJhYWUvRjhmY0s4?=
 =?utf-8?B?MVlHNllWN0ppY2VTY3M2ZHJ5TUNGUUE4RXJNVWlTejhic28wV0ZuOW9XMTBo?=
 =?utf-8?B?dlArenUvMlQvZEtpNjBjaVYxRUNneHcyMCtlNkNBbmJac0FlbHlrOG9ieEFP?=
 =?utf-8?B?T3RJdGpXNGlIcUdyQzNlNTIyZGswYnFVUWl6RWRTMjZCLzBaVnRmbEcxSWF5?=
 =?utf-8?B?S2lWZDM2Tyt1TTF2MVFaS2V3STVQaE9JTXg4eWcrTXJjVkZtRFliZ3crRmZn?=
 =?utf-8?B?TkJLOTl4a2xIQXpUditpRW14OUtlUnp0bXdkOU9zR1p4V20yV2JuSWdoTTVH?=
 =?utf-8?B?TnZTNHo2eDNxdUdWU292VEV6TXUvOGZ4bkN4Z0RPOUROTjlVUlIwUmFWL1p3?=
 =?utf-8?B?SE5XUGhvYm52djdWbURnYmlpVmcydGNWZWNWTTZWaCs3VnFUQVhJNmFaV2VV?=
 =?utf-8?B?OXVMZEpBcFBEMkswYUwwd2tYeXJpQWZZMmtGVkRQcCt0M0k0T1AwbUVYeGIx?=
 =?utf-8?B?VEJZdFljLzg3anUzd3U5dHh3cm5CaUsrSndMRVYwS0VIamhOWFdRdkZUWkU2?=
 =?utf-8?B?Y3VqN2kwZ3ZEempBK3lOeUl5bzlVWTdZVXFrT2U3QVY1RmJhNkdaTUR1Zm0w?=
 =?utf-8?B?eUFJRXNNeTM1WWd1Z0hGOEVhaC9ldUx1Q290cS9lTmQ4ZW9oRnpQYzBUZnh3?=
 =?utf-8?B?S2hUaTZnVWpnYlc4c0tUamtIQUlQcVladkl4NmEvYlBtMU1lTm5UYTJMSFUx?=
 =?utf-8?B?czltOWN0Z3JLenRxdEx2ZDFocE9TYmhFRjNjM2ZjWGVjVG8ydkdYZUsvczha?=
 =?utf-8?B?K1ludElIdkQwNDJzQzI3dnBzY25DRHZDaHV4eEErL2FublVWU0lFRkUzdzRT?=
 =?utf-8?B?aXI5QzB3TUZBdG5RREtZWkRNbmVYQy9pZ0lCNUNCTFZlbFF5Tm9WQ21rS3Vw?=
 =?utf-8?B?QUxiWlgxbis3eXJ6RzZJSDY0a0tlTkZXdytkNURkZmxKeUtFRW14aG02RGgy?=
 =?utf-8?B?b1FvQ3RORk0raFUvMEt5ZEVVMkVRelRHOHdPWmlpTlUwNG1ZVDBUNlZVMStV?=
 =?utf-8?B?Sk5hWVA4MnhrRytGVHRSd3FYbElwdXFaem9ZZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amkrZ25xWEJWZDhpZVpzeTRQdHQvU05leWNta0hKb2puL0MwT1ZGOU4wRFRz?=
 =?utf-8?B?ZjJSNzg0WjJMSTlVL2F3MzNjdnF5UGp3M2pxZ21NVzlkUkdqMldXcXpLeVY4?=
 =?utf-8?B?dWNrdjhUS3RtanZTSGRMKzBhUm5BOElXdTRydVR5ZzROMEJXU0FyZmJmR3R6?=
 =?utf-8?B?VEVkTThhY2pJd01xOHplWDIvVWYrdDA0b1hxNW1Da1RsYnNQbTdGS1Y4ODBJ?=
 =?utf-8?B?bDB0YmFKRDFHc25vaTViSHkyYUNOYjlwVUlEcUkva2UvZ0VKRW1NMzlISm94?=
 =?utf-8?B?VEdTcFgrbmRENkpoVzFZZWlmaVVoWEJ4S2NKQlFLMFN0YWViVUh2aDlzVmhW?=
 =?utf-8?B?eGtRVGlILzJya082QURLNlFwLzcxVUZoNHVWWTArRzZXTmRkWGErVDF0QTBw?=
 =?utf-8?B?Vms2V3c0S3o3RHpSOGVKRm5vKzI5TUprYXRTMFBNbFdmVWNBTkRXc2NOaTFk?=
 =?utf-8?B?UXBjRmhnbkFzZFJjZ2RDNzkrS1JxVllFRVU0T3FhMXkwRFRWTExYNHlpOCtX?=
 =?utf-8?B?VTB4MnpwQlVBbXJxcC9PNFBqVVE0em10bkZzMnRSRC9lTnlqTHVQS2lUa0dF?=
 =?utf-8?B?TXdZeUJKL0VyVmZoTS9hTndXY1psbzFmcGdoQWdFTE51TGJBM1JmK0tRUjFt?=
 =?utf-8?B?MldMclZZT1YrTG1DR3JkeFVZQXhLcmkzOFpDRGlyT0p6OVJ0NG5BWEpuN2Nt?=
 =?utf-8?B?ektpOGI5OXV0KzBrQ3dpZ3hsZzBmeXNITk4xdlJqQ0ptR1VUTHRDWXRWQUxu?=
 =?utf-8?B?WkxzMzJKZDJMK3IzSXV1SWxiQTJDM1VDTmM3UEcwTVhYRWV2YkVkaEQ3alpj?=
 =?utf-8?B?aFFIYWRSdEc3dndNOTdnM3BmL3gwT2hOZHhJWWVFWE50dXE3MlRObStOelJ4?=
 =?utf-8?B?NTlwOUcxTFJRSUFkWE1UL0o3eG5ZdUtoQ2M5bUgvRjJ2SFg5Z1ZudG91d1lZ?=
 =?utf-8?B?czVYOG1zYVJ4TXo4QVVTRUs2aDFNSERBbVhxN2xhaXpsVGxEWmxudlY4VTkv?=
 =?utf-8?B?OXE5WndPZlkzNzdXN2RvWk1IWG1RRklVVnZKaEVmbG1WZHMrMnVoaUhyanNZ?=
 =?utf-8?B?WWJGK1JrdnhjNzJUcmF3dDMybldOcE1nVVZ5ejY3a0lrRXpFVkNJa0o5aHVP?=
 =?utf-8?B?dVJJaW9OMVh2WVFYbFVQc2VNYXpKMnpleVJ4QzlLV3E2Q1VSZEdJZ01qWFlh?=
 =?utf-8?B?NC9EYnh5d1orT1liNjBpWkZpUlc2aXpXK1N0clV4eHZ0cCt3ME5CRlp0Sy9W?=
 =?utf-8?B?ekNCUHlweUZ1Q0p5VzBFU1hhMllzelFpLysyWktkMzF2bWRCVGZJR25yckxw?=
 =?utf-8?B?RkFXWkgzQzVXWSs2UXZvMEhSMk9PS2ExL1VSVzhhc05KUm8rcEU2WkpSbStq?=
 =?utf-8?B?UU1LdVdxSTdTSUJUbW82eVh3UlZ2emFDa1VvUDVrenFDNWxYNFNtcjBFZDRk?=
 =?utf-8?B?YVdpS3NNYlZ5SVN1ME0xWWd3T0t5TGgyRGNBTFZ6VTRiYkNWazIwREhFZmRm?=
 =?utf-8?B?UGVoQi9vTE8vREFaRUNRVnpJR1lpb3VHVGJqUTAwNE1vbndoeDFLSmRtMzRk?=
 =?utf-8?B?SmNxd3NvMXBOVlFLdmJxSzhFbzJZYkYyWHB0VjF1K3l0S3hza3Qvd3dGb2J2?=
 =?utf-8?B?dG9FaXpWMTllOVJvRVgyR3djU09CbmZqbGc0RlNGajdub3VyelBLemFwdkJQ?=
 =?utf-8?B?SWxOWTlDZ1FubFlzbW5oN2V3aXlKd3JLcGtYQWt3VmJnenVycHVoaWoyYXN2?=
 =?utf-8?B?MHZuY2lzSTNicDE2RjVrMHVnNXkwcXd2YXQ4RUgwZlB1RXZGTWtUdGV6Q2U3?=
 =?utf-8?B?cTU0S1Vrc00ycWh2MXpvbkJMdG95amdaQ0RNczhRYWxQM08xUDJZWE1HWllx?=
 =?utf-8?B?OEtZU08xMGorTTBMSDFsNFFwcDdqN1Y1YVUrbE1CakllNDBlVmYrMlBmZFZS?=
 =?utf-8?B?U1c3ekNLY0dCeVNjY1lkVjRQd0lib2ZkTlhDUVBESThSQjkyK0hhTjhTbFpG?=
 =?utf-8?B?b2NwcmJBMnZqelBueEZMd3NhYm54Q2Y2YWpkOG53SGlTZEZiMUNVSE5Dc3pQ?=
 =?utf-8?B?Nk82MnVFMmw5aWdxSEp0Y3M0ajV1dEFZNmZmdHVYOW4vRFZJb21Ybm5Bc0Ru?=
 =?utf-8?Q?dl2f0eOrSiR9ltEauPR+sMvCs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecaba81f-ddc7-4552-14a7-08de18632cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 09:52:16.6022 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xpiN2UmiAbxVoZNSJzVKwTSEsqvHqsu7GxDOQNulwR8J4FNJUidAcXV7S/hY/inbGa5IKsm/NNmvvNULI54zj0V9rHfiKY2o+Rlebbb/nAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6712
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjcgMDkvMjNd
IGludGVsX2lvbW11OiBTdGljayB0byBzeXN0ZW0gTVIgZm9yDQo+SU9NTVVGRCBiYWNrZWQgaG9z
dCBkZXZpY2Ugd2hlbiB4LWZsdHM9b24NCj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+T24gMTAvMjQv
MjUgMTA6NDMgQU0sIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gV2hlbiBndWVzdCBlbmFibGVz
IHNjYWxhYmxlIG1vZGUgYW5kIHNldHVwIGZpcnN0IHN0YWdlIHBhZ2UgdGFibGUsIHdlDQo+ZG9u
J3QNCj4+IHdhbnQgdG8gdXNlIElPTU1VIE1SIGJ1dCByYXRoZXIgY29udGludWUgdXNpbmcgdGhl
IHN5c3RlbSBNUiBmb3INCj5JT01NVUZEDQo+PiBiYWNrZWQgaG9zdCBkZXZpY2UuDQo+Pg0KPj4g
VGhlbiBkZWZhdWx0IEhXUFQgaW4gVkZJTyBjb250YWlucyBHUEEtPkhQQSBtYXBwaW5ncyB3aGlj
aCBjb3VsZCBiZQ0KPnJldXNlZA0KPj4gYXMgbmVzdGluZyBwYXJlbnQgSFdQVCB0byBjb25zdHJ1
Y3QgbmVzdGVkIEhXUFQgaW4gdklPTU1VLg0KPg0KPndlIGhhZCBhIGRpc2N1c3Npb24gdGhyZWFk
IHdpdGggTmljb2xpbiBhbmQgU2hhbWVlciBhYm91dCB1c2FnZSBvZiBBUw0KPmZvciBuZXN0ZWQg
U01NVQ0KPihodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvYWRkMDdlZGQtMzY1Mi00MzBkLWI1
MmMtY2IyYmRiYzdmNTg3QHJlZGhhDQo+dC5jb20vKQ0KPklmIEkgdW5kZXJzdGFuZCBjb3JyZWN0
bHkgeW91IGFsc28gcmVseSBvbiBzeXN0ZW0gTVIgZm9yIG5lc3RlZC4gSSBhbQ0KPm5vdCBzdXJl
IHRoaXMgaXMgYSBnb29kIHVzYWdlIG9mIHRoZSBBUEkvQVMgb2JqZWN0cyBhcyBpbiBwcmFjdGlj
ZSB5b3UNCj5oYXZlIGFuIGFjdHVhbCB0cmFuc2xhdGlvbiBpbiBwbGFjZSAoYWx0aG91dCBpbXBs
ZW1lbnRlZCBieSBIVykgd2hpbGUgYnkNCj51c2luZyB0aGUgc3lzdGVtIE1SIHlvdSBkbyBub3Qg
cmVmbGVjdCB0aGF0LiBJIGVuY291cmFnZWQgU2hhbWVlciB0byB0cnkNCj51c2luZyBhIGR1bW15
IGRlZGljYXRlZCBBUyB0aGF0IGNhbiBiZSBzaGFyZWQuIEkgdGhpbmsgaXQgd291bGQgYmUNCj5i
ZXR0ZXIgaWYgd2UgY291bGQgYWxpZ24gdGhlIHN0cmF0ZWdpZXMuDQoNCkhtbSwgSSB0aGluayBp
dCdzIGhhcmQgZm9yIFZURCB0byB1c2UgZGVkaWNhdGVkIEFTIGp1c3QgbGlrZSBzbW11LCBiZWNh
dXNlDQpWVEQgc3VwcG9ydHMgbGVnYWN5IG1vZGUgZXZlbiB3aXRoICd4LXNjYWxhYmxlLW1vZGU9
b24seC1mbHRzPW9uJywgd2UNCmRvbid0IGtub3cgZ3Vlc3QncyBjaG9pY2UgYXQgcnVudGltZS4g
U28gd2UgYWx3YXlzIHJldHVybiBJT01NVSBBUyB0bw0KVkZJTywgd2Ugc2hvdWxkIG5ldmVyIHJl
dHVybiBhZGRyZXNzX3NwYWNlX21lbW9yeSBvciBhIGRlZGljYXRlZCBBUw0KaW4gdnRkX2ZpbmRf
YWRkX2FzKCkuDQoNClRoZXJlIHdhcyBhIGRpc2N1c3Npb24gd2l0aCBOaWNvbGluIGFuZCBMaXV5
aSBvbiB0aGlzLg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsL1NKMFBSMTFN
QjY3NDQzNDBCODg5RkY2NUQzQkQ1Qjg0NTkyNjdBQFNKMFBSMTFNQjY3NDQubmFtcHJkMTEucHJv
ZC5vdXRsb29rLmNvbS8NCg0KPg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogWWkgTGl1IDx5aS5sLmxp
dUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25n
LmR1YW5AaW50ZWwuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJA
cmVkaGF0LmNvbT4NCj4+IFJldmlld2VkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4N
Cj4+IC0tLQ0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDM2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11
LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IDRjODM1NzhjNTQuLmNlNGM1NDE2
NWUgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTQxLDYgKzQxLDcgQEANCj4+ICAjaW5jbHVkZSAibWln
cmF0aW9uL21pc2MuaCINCj4+ICAjaW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCINCj4+ICAj
aW5jbHVkZSAidHJhY2UuaCINCj4+ICsjaW5jbHVkZSAic3lzdGVtL2lvbW11ZmQuaCINCj4+DQo+
PiAgLyogY29udGV4dCBlbnRyeSBvcGVyYXRpb25zICovDQo+PiAgI2RlZmluZSBQQVNJRF8wICAg
IDANCj4+IEBAIC0xNzEzLDYgKzE3MTQsMjQgQEAgc3RhdGljIGJvb2wNCj52dGRfZGV2X3B0X2Vu
YWJsZWQoSW50ZWxJT01NVVN0YXRlICpzLCBWVERDb250ZXh0RW50cnkgKmNlLA0KPj4NCj4+ICB9
DQo+Pg0KPj4gK3N0YXRpYyBWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9maW5kX2hpb2RfaW9tbXVm
ZChWVERBZGRyZXNzU3BhY2UNCj4qYXMpDQo+PiArew0KPj4gKyAgICBJbnRlbElPTU1VU3RhdGUg
KnMgPSBhcy0+aW9tbXVfc3RhdGU7DQo+PiArICAgIHN0cnVjdCB2dGRfYXNfa2V5IGtleSA9IHsN
Cj4+ICsgICAgICAgIC5idXMgPSBhcy0+YnVzLA0KPj4gKyAgICAgICAgLmRldmZuID0gYXMtPmRl
dmZuLA0KPj4gKyAgICB9Ow0KPj4gKyAgICBWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9oaW9kID0N
Cj5nX2hhc2hfdGFibGVfbG9va3VwKHMtPnZ0ZF9ob3N0X2lvbW11X2RldiwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmtleSk7DQo+
PiArDQo+PiArICAgIGlmICh2dGRfaGlvZCAmJiB2dGRfaGlvZC0+aGlvZCAmJg0KPj4gKyAgICAg
ICAgb2JqZWN0X2R5bmFtaWNfY2FzdChPQkpFQ1QodnRkX2hpb2QtPmhpb2QpLA0KPj4gKw0KPlRZ
UEVfSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVGRCkpIHsNCj4+ICsgICAgICAgIHJldHVybiB2dGRf
aGlvZDsNCj4+ICsgICAgfQ0KPj4gKyAgICByZXR1cm4gTlVMTDsNCj4+ICt9DQo+PiArDQo+PiAg
c3RhdGljIGJvb2wgdnRkX2FzX3B0X2VuYWJsZWQoVlREQWRkcmVzc1NwYWNlICphcykNCj4+ICB7
DQo+PiAgICAgIEludGVsSU9NTVVTdGF0ZSAqczsNCj4+IEBAIC0xNzM4LDEyICsxNzU3LDI1IEBA
IHN0YXRpYyBib29sDQo+dnRkX2FzX3B0X2VuYWJsZWQoVlREQWRkcmVzc1NwYWNlICphcykNCj4+
ICAvKiBSZXR1cm4gd2hldGhlciB0aGUgZGV2aWNlIGlzIHVzaW5nIElPTU1VIHRyYW5zbGF0aW9u
LiAqLw0KPj4gIHN0YXRpYyBib29sIHZ0ZF9zd2l0Y2hfYWRkcmVzc19zcGFjZShWVERBZGRyZXNz
U3BhY2UgKmFzKQ0KPj4gIHsNCj4+ICsgICAgSW50ZWxJT01NVVN0YXRlICpzOw0KPj4gICAgICBi
b29sIHVzZV9pb21tdSwgcHQ7DQo+Pg0KPj4gICAgICBhc3NlcnQoYXMpOw0KPj4NCj4+IC0gICAg
dXNlX2lvbW11ID0gYXMtPmlvbW11X3N0YXRlLT5kbWFyX2VuYWJsZWQNCj4mJiAhdnRkX2FzX3B0
X2VuYWJsZWQoYXMpOw0KPj4gLSAgICBwdCA9IGFzLT5pb21tdV9zdGF0ZS0+ZG1hcl9lbmFibGVk
ICYmIHZ0ZF9hc19wdF9lbmFibGVkKGFzKTsNCj4+ICsgICAgcyA9IGFzLT5pb21tdV9zdGF0ZTsN
Cj4+ICsgICAgdXNlX2lvbW11ID0gcy0+ZG1hcl9lbmFibGVkICYmICF2dGRfYXNfcHRfZW5hYmxl
ZChhcyk7DQo+PiArICAgIHB0ID0gcy0+ZG1hcl9lbmFibGVkICYmIHZ0ZF9hc19wdF9lbmFibGVk
KGFzKTsNCj4+ICsNCj4+ICsgICAgLyoNCj4+ICsgICAgICogV2hlbiBndWVzdCBlbmFibGVzIHNj
YWxhYmxlIG1vZGUgYW5kIHNldHMgdXAgZmlyc3Qgc3RhZ2UgcGFnZQ0KPnRhYmxlLA0KPj4gKyAg
ICAgKiB3ZSBzdGljayB0byBzeXN0ZW0gTVIgZm9yIElPTU1VRkQgYmFja2VkIGhvc3QgZGV2aWNl
LiBUaGVuIGl0cw0KPj4gKyAgICAgKiBkZWZhdWx0IGh3cHQgY29udGFpbnMgR1BBLT5IUEEgbWFw
cGluZ3Mgd2hpY2ggaXMgdXNlZCBkaXJlY3RseSBpZg0KPj4gKyAgICAgKiBQR1RUPVBUIGFuZCB1
c2VkIGFzIG5lc3RpbmcgcGFyZW50IGlmIFBHVFQ9RlNULiBPdGhlcndpc2UgZmFsbA0KPmJhY2sN
Cj4+ICsgICAgICogdG8gb3JpZ2luYWwgcHJvY2Vzc2luZy4NCj5BY2NvcmRpbmcgdG8gdGhlIGFi
b3ZlIGNvbW1lbnQgeW91IGhhdmUgYSBTMSB0cmFuc2xhdGlvbiBpbiBwbGFjZSBidXQNCj55b3Ug
c2V0IHVzZV9pb21tdSA9IGZhbHNlIGFuZCB1c2Ugc3lzdGVtIE1SPw0KDQpZZXMsIHdlIGhhdmUg
ZXh0ZW5kZWQgdGhlIHVzYWdlcyBvZiBNUnMgdW5kZXIgSU9NTVUgQVMgd2l0aCBuZXN0aW5nLg0K
SW4gbmVzdGluZyBtb2RlLCBzeXN0ZW0gTVIgb24vb2ZmIGlzbid0IGFsaWduZWQgd2l0aCBTMSB0
cmFuc2xhdGlvbiBhbnltb3JlLg0KDQo+DQo+UmV2b2tpbmcgbXkgUi1icyBmb3Igbm93IGJlY2F1
c2UgSSBhbSBub3QgY29udmluY2VkIHdlIHNoYWxsIHVzZSBzeXN0ZW0NCj5NUiB3aGVuIFMxK1My
IGlzIHNldHVwLiBJIG1heSBiZSB3cm9uZyBidXQgYXQgbGVhc3QgSSBuZWVkIG1vcmUNCj5leHBs
YW5hdGlvbnMgOy0pDQoNCk9rYXksIGxldCdzIGRpc2N1c3MgZnVydGhlci4NCg0KVGhhbmtzDQpa
aGVuemhvbmcNCg==

