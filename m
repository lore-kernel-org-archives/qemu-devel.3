Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63EC5FB5183
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9w1x-00038Z-R4; Mon, 06 Apr 2026 22:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w9w1u-000388-Vv
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:19:03 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w9w1t-0006E2-C2
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775528341; x=1807064341;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bgx+ccQ2KzxOMrN3wa3TTHefT+sS1o2RFRrdlmRGPiQ=;
 b=Ppa6DPtQ1zGgRNjgxqCCGgi0LTLOwUppJKZSKWdSaRd/57c1O/53b5cw
 K54d+5fJZbgplEOwpQIr/ACfRT7EBrIIxdmftecr48ukpaSKJlh1RjQue
 f8EfhNbY5ZZqjpkysHR1HAG/Jz6bk14pyfQv2zthUZ2wdJFiAocRRKd/V
 wjjh/BteN0pMublqBqFtrshgDLdQ0qgg1nHxdmknFkkq0abZlN3Vovyw7
 aCYTpLczZifpe1abD+mU3iHbPO7q4TLiLQ9mVFjLImvjQLGKskggLTybr
 Ejf17gCHdpz4Rwl3kZs7VQ58ZCXQbxkJD3MpHCHNIV2S7F/s21L41pz+R w==;
X-CSE-ConnectionGUID: 2s76TNXrTom7x99wGPiRGg==
X-CSE-MsgGUID: 3PKq4DifQ/K4752KUUFh5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="79074390"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; d="scan'208";a="79074390"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 19:18:58 -0700
X-CSE-ConnectionGUID: +R90n5o1TxSRx15Nm9L6QA==
X-CSE-MsgGUID: E+1aoATnRQSxomOfGLp5lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; d="scan'208";a="229697074"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 19:18:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 19:18:52 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 6 Apr 2026 19:18:52 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 19:18:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CX2Mhi81vB/LWhbkINiyFbfhK/v3P+uuIwuhsAe5GCIg0eaRT/oxG7DR5RBKOwyxIvp0bCe+s14FXyQ5bYQ8iF2TwYs8VNRC5B5JpS2NXSwocc+vW5lUFqQM2HTPAYuFxzO4tPV5Km+rV8SS2CidaLCKs2pPkFl4l41gCk6ECePhGFI+Psy752fIqsbDAKL66PJOActKgojWHFdNoJvINuEkcuL0z585e/2cYCRtD7gYIm2LGfp8wHW5hPmYjF4Oh4pphEjgZN/xqItYPklT2dBpUFkVEiHCG/LkMqWHu13gTOK3tP5ENDcEUYsDSC9mVY+ImX092GfwrcFV1Jc/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgx+ccQ2KzxOMrN3wa3TTHefT+sS1o2RFRrdlmRGPiQ=;
 b=lhJJ/nK6bX6LVaoU7HSBOY+KRj7zEREAjjhc8LQNy+MLh//vuiTzCFqAIMendz3Hky44XPa1LdfV4L+AhjFpcIT3M37pIs+5Jr5lc1umCxRZ6q/Igo0DVvFC5nLj9+lseUrHVdY59h6MutWd4RV5sIYtbqJD65e7JK7T4SLhHlDdWjpbmHlgrPYf0m7Q+h5355zbRMpd7YjTmFz3cw9G7LHSgvmDKzi+Sl8EQNua/lG88n95CK2Z8IMaAXVZXMBrci7WfBaqa4g+8TREOZFsJYiKVkTdsf28Ae1qdzpI/7jiyv5l7F0qe7KICHIi4Cds6KfTDCoouvtmj5RBHqs69A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB7633.namprd11.prod.outlook.com (2603:10b6:510:26c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Tue, 7 Apr
 2026 02:18:49 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9769.011; Tue, 7 Apr 2026
 02:18:49 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao,
 Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v3 14/14] intel_iommu: Expose flag
 VIOMMU_FLAG_PASID_SUPPORTED when configured
Thread-Topic: [PATCH v3 14/14] intel_iommu: Expose flag
 VIOMMU_FLAG_PASID_SUPPORTED when configured
Thread-Index: AQHcwx3k2pNcbHIzUEaKw224s7RWerXNFVuAgAXNVzA=
Date: Tue, 7 Apr 2026 02:18:49 +0000
Message-ID: <IA3PR11MB91365C3158521D1D985B7464925AA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260403035541.18355-1-zhenzhong.duan@intel.com>
 <20260403035541.18355-15-zhenzhong.duan@intel.com>
 <4567f32a-2a4f-43a4-aa09-fb669cd9e78e@redhat.com>
In-Reply-To: <4567f32a-2a4f-43a4-aa09-fb669cd9e78e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB7633:EE_
x-ms-office365-filtering-correlation-id: ce7a5177-ff12-497c-574a-08de944c0177
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: wmxzsV4KCY0uFlP8uuqJM6bRSh4Sj9gq8n7tp38S6g/93OSGjswJ/JsJtYUvwXgh+6vODTqASjmgyyr+r6xazGJaBejcRNB/ZRMhg+cV7zxf6OAO1h0Wmui5IGaxR0X4n6s4nsPEczEviiSVasuU+YiXSevzTCpjTyVQ1w5ukVN2yU+9vPfpu6zye0ZVjbCUXZxUIeByg0cKlkjeENr1/tENoBNtE7oGh9rsapj+eaAdA00+WU1yyo31v3vQRns1K42D4EFnyUYaSAjagHopeXYrpBWiUEIsOQM55oy+Jlicgmb7qp60KNsAxFYsmjLbwPCwXYSVoxVapXFQpNO9/vgIWdG2azI0kM4zVqvxOOZaKTyptbPzZXPO6rDEoZGzO6bQLrK3477S82CiA5WDacf7yyFE9HtZfum/+HPWvLNXd08RWQdz9dmi+2MW1/19WaCjRgWEIDv8kiKQop5KJXyMQD7KMsR910pVhhxKw8FLKSuc+Y+ai+vKl4l5c89OihU/+stM7XGE0nyHR07Q5ejdvs7dvW97GVOcuqYn6T1LLoyJhU/tAkbt7dXZQFkxuZXRxwGqsWW846aC7yVpAdW+jGm23Ak+NBynI2R8WzI9A+pxy22hKuHP9pBVtA3ZJ6KO0nsLLCSCeCM5phu8M0XBHnlnNTGsOOP6a3Je4h+4pkHS5S+S2fFxbu0tru1jdmzv3HbL92FwqiNWGQHEpw1joIBmu2TbaaNyrNL0ykMOM99hOlITvgyiJ6klog+cxGJe+tXHa1Ftvrjv/6udgfiHmkdEFb68TCUnJauPxLQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2wzaXVhTmF3UDN6dlRDdXoxTXZLdW1zejRORW45dHBoQ1Q1dDJhNjc3YTVK?=
 =?utf-8?B?L2ZaWW1adFgzcGlEcEJmeU5HL1dQbW5LMG1zb1VCRVkwUXl1UVMvQysrVXF3?=
 =?utf-8?B?VW5HQmE1ZGh1UFVsWDBDWW93UmFNcklvSHczVlhURkFMdDV6MkJJZTErOUxG?=
 =?utf-8?B?NTRoejIycWYwWG9OSW1GWWdWL0pZNGV4bXFIdEcyUzVNTFlsTlVhS0RGak1a?=
 =?utf-8?B?dUIxcUpqUmhHVVBVZWdsZWFic05vdlc1VncyMFhwbXJ4VWYrWFRHR2ltTmdG?=
 =?utf-8?B?Y21SVk16M3BQYjZoUXRra3RjK3dmRVZWRXp6WUo0ZXZiMzB0WE1SR3IxZnpu?=
 =?utf-8?B?a0RlUTlDWUw4Ukxjb0pseWx0ekFMQ2dqOG9kZytQN3ppanhVQjlWSVNubUxR?=
 =?utf-8?B?Y1pYZGJ0NnBFaG1nR3Yrd0k3SFVqeVJtU0Q0ZlB2MnFaTkwzMUJpSjVyeFdy?=
 =?utf-8?B?cnVORmFmZytMaGZvVTV2NFNWb1N3cjNQaGlURWxiM2ZRL1A1OUZRcVcvdGxp?=
 =?utf-8?B?eElhV1JDVEtMWUNJVlEramhCRzZ3Ulc3dDgrOE96eUxZYnNGZGxpODZEZE1R?=
 =?utf-8?B?aExpVVMvY2tOZ2V6ajhnUEJhTkI3d0ltSmJ5U0R6ekRvT3NKakdFRWhlMUtB?=
 =?utf-8?B?NDl6TGJxUlVRT20rSHZieXlMUmEweTA1RVNXRXR5aFRJaUp6aExIZ0F2Zm0v?=
 =?utf-8?B?TTBreERVRUE1SUR4ZEZPS2hNM3F0UUgveCs4TmFZa241S2Y3c0lTUklqeXRv?=
 =?utf-8?B?TDg1UUdnVi9aWFBhaVBVWmg3akIxUUU1c056Nk5WSmdoM2hVR0lMb3RYWHAy?=
 =?utf-8?B?bExjaDZtRmtUbTNnaUZTSmpGVkRwSWFLeUt3QzV6K2ZWeG15WWJuS21lNExK?=
 =?utf-8?B?Zy91YkhpTHZQNWZpaTF0TU1XNTJwRUJueXY2eWtoV3lVU1BNTlRrWTQ1SVFO?=
 =?utf-8?B?OUt2ODlIN1U5TkFHcThVZjB0Q0xza3hLNXR3czJaV2RDTmVubG8xUWVMZDRJ?=
 =?utf-8?B?YnRBVlByKzhGNHJuNXovOEYzVUIxZ3AxWWRJT0R5OUYyNURRbnB1ekFGSmo3?=
 =?utf-8?B?UmZqSjRwamZyRjFyMHQxR09NY2NEeWwvdWxWOVA3dUVNWVNaak5OM0JSM3VO?=
 =?utf-8?B?UDJFVldjbkFaMFlFTFY2eDN4UmJPc21BVHhUMDNpeWpNOUF6ZWZkcks1WHZn?=
 =?utf-8?B?N0d2ZFZCdFhqa2dUM1RyNEJOREhWRllrQ1RiT25SanNKWjJ6ZnlTYXkzQU1M?=
 =?utf-8?B?TWFueThUb05sZ3MxNklWYzZ6UkExQTNzc05ybDU3dThHSmExYjFiU1hlWjJH?=
 =?utf-8?B?M0NkU0tIRDlLcGQ1SDlNZGNwS2pTTGFDUFp1eTNBaVlNOXQrejhxM1dYOVVM?=
 =?utf-8?B?Z1FPaGZ0OE5lQmxaVmlRWmJaNFZuZGY0VCszRzVzVy9PUDlCZmw3S1pVYTNP?=
 =?utf-8?B?cmlOME1ZZnNiai9kYjh5SmV3UUQzaFhTOUNzTnppR0J5RUErRXNacmVrZVhi?=
 =?utf-8?B?TnY4aDQrVTA2RFB2UFVmeEdOYlNPWFF2RnQ4MncvUjI2SzJtZDhKMnNzZzJI?=
 =?utf-8?B?S1dYZmJDbkNZVmpJMGVTZW1wdUw2dzlNY1d5MTk0VmkzS09hVElZT1c5Qnd3?=
 =?utf-8?B?TG9ZMWovby9oRkxkVENISVZvR3lpSGhTYXoyZFU1UVBqT0JGSUsvZld2K2Z1?=
 =?utf-8?B?Z0JoL1gxYWgrQlFjS3V5MXZnOTVJMHNFdUY4UUNwNi82NDQ1L3QxUlRkcVJs?=
 =?utf-8?B?ZVNkZ0kvdFlpaDEzOWNacnh2aEJGZ3prSDVCWWthVjQ5eVBPUiswY1I3T2k5?=
 =?utf-8?B?SVdudzEranJUR0w3L2llMDJIN0M4WWx0aTJ1dWZYQlAxa1FCN2IvTTdra2Qr?=
 =?utf-8?B?L1UyMnpuRlRaK2V2VVU3SjFmcU5Ua09HNzRRVG53YlRnV2pTOVVzcGt5czdu?=
 =?utf-8?B?QWdJaGpvOHpwZEEweWFoUExIRDFOeXdsa3BWc28wRDdsRzJJc3pNUm1nZUV5?=
 =?utf-8?B?MHNiakZwelQ4T25MMndwbndNb3FOcmZwOHpNbVQwTnFjVENwTXZtTElHM2do?=
 =?utf-8?B?TW43NjNXd0dKb3piejJKYm84dHpqQU5FUitJL051cElDczdzZTZ3Smx0dTda?=
 =?utf-8?B?NnF4ai9BMXNDUFRDeDVzUHgwak50ei9qVlZaZ0FRcFpRU2JkWnMxL2xJcnVw?=
 =?utf-8?B?bUV2dWdOcndiRmhnbDJFS2lrR1krOHpRcGxVZ0dVbjUrdFc3REJZR0daVHZ4?=
 =?utf-8?B?VUhCSlVPOFRIa3JnNGNQNnNVNXZzMktjeXY4ZGtmQm84T1lncEhjTHhQcFdy?=
 =?utf-8?B?ZTRRN2lMR3VFeXJ6KzVkblBxNlIxaTNYY0VWaWVETW82RjJGY3Rtdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IxDESLXyItwhMTCHcEox4fFcUVggCfILvBCi4pOLH7D4O1qXVlGkXWEhNlnmC3WKWhuuneHRi0m6gGi8FFdZGe2ptXTajCCVlTQgLFWW1tuYCiSiREZppZVhQi9WDxvrLj+ISzapMqGpy4404lfoAqvqzwGClLDrasIKMHjY473HFGIIyKbnDG6l4KYX5HpvV7jaBWn5+lKQl4uIRFOM1Mj6Vnsx2Wz/WNbSg1KpnUkGr/FQTLx4qIL25pnF4Y4dSB/j+pahBIBYRvieVGyNiOpoIha+mVS7kF4XcKu7wWYkmqyB9WLYONEkYclHQPsLfKEwcJy+VfXsnUzKeO5j+A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7a5177-ff12-497c-574a-08de944c0177
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 02:18:49.5599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nul7fxjN7lBmuoAE+nu0CtJTNT3MPIJMUAjsHnh/s1vAWcC/OLZbU3L+fTnUNukNJ+TB7tZ3HK58ag+RknYl0alAhOOgoK4iEbLf5JLcD0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7633
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDE0LzE0XSBpbnRlbF9p
b21tdTogRXhwb3NlIGZsYWcNCj5WSU9NTVVfRkxBR19QQVNJRF9TVVBQT1JURUQgd2hlbiBjb25m
aWd1cmVkDQo+DQo+T24gNC8zLzI2IDA1OjU1LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFZG
SU8gZGV2aWNlIHdpbGwgY2hlY2sgZmxhZyBWSU9NTVVfRkxBR19QQVNJRF9TVVBQT1JURUQgYW5k
IGV4cG9zZQ0KPlBBU0lEDQo+PiBjYXBhYmlsaXR5LCBvciBlbHNlIGd1ZXN0IGNvdWxkIG5vdCBl
bmFibGUgUEFTSUQgb2YgdGhpcyBkZXZpY2UgZXZlbiBpZg0KPj4gdklPTU1VJ3MgcGFzaWQgaXMg
Y29uZmlndXJlZC4NCj4+DQo+PiBUaGlzIGlzIHRoZSBmaW5hbCBrbm9iIHRvIGVuYWJsZSBQQVNJ
RC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5A
aW50ZWwuY29tPg0KPj4gVGVzdGVkLWJ5OiBYdWRvbmcgSGFvIDx4dWRvbmcuaGFvQGludGVsLmNv
bT4NCj4+IC0tLQ0KPj4gICBody9pMzg2L2ludGVsX2lvbW11LmMgfCAxICsNCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50
ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gaW5kZXggYWJjYjBkZjVkOS4u
M2NiOGE1NDdjNyAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gKysr
IGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBAQCAtNDc5NCw2ICs0Nzk0LDcgQEAgc3RhdGlj
IHVpbnQ2NF90IHZ0ZF9nZXRfdmlvbW11X2ZsYWdzKHZvaWQgKm9wYXF1ZSkNCj4+ICAgICAgIHVp
bnQ2NF90IGZsYWdzOw0KPj4NCj4+ICAgICAgIGZsYWdzID0gcy0+ZnN0cyA/IFZJT01NVV9GTEFH
X1dBTlRfTkVTVElOR19QQVJFTlQgOiAwOw0KPj4gKyAgICBmbGFncyB8PSBzLT5wYXNpZCA/IFZJ
T01NVV9GTEFHX1BBU0lEX1NVUFBPUlRFRCA6IDA7DQo+DQo+VGhlICd8PScgb3BlcmF0b3IgaXMg
dW5leHBlY3RlZC4NCg0KTm90IGdldCwgZG8geW91IHNlZSBhbnkgaXNzdWUgaGVyZT8NCg0KVGhl
IGZsYWdzIGlzIGZpcnN0bHkgYXNzaWduZWQgdG8gVklPTU1VX0ZMQUdfV0FOVF9ORVNUSU5HX1BB
UkVOVCBpZiBzLT5mc3RzPXRydWUsDQpUaGVuIFZJT01NVV9GTEFHX1BBU0lEX1NVUFBPUlRFRCBp
cyBhcHBlbmRlZCBpZiBzLT5wYXNpZD10cnVlLg0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+IEFu
eWhvdywgdGhlIGNvZGUgaGFzIGNoYW5nZWQgc2luY2UuDQo+TmVlZHMgYSByZWJhc2UuDQo+DQo+
VGhhbmtzLA0KPg0KPkMuDQo+DQo+DQo+Pg0KPj4gICAgICAgcmV0dXJuIGZsYWdzOw0KPj4gICB9
DQoNCg==

