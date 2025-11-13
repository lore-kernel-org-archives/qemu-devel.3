Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10026CD4F5F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 08:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJSs0-0004av-VB; Thu, 13 Nov 2025 03:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vJSry-0004Yo-H4
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:39:54 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vJSrw-0005vm-Ds
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763023192; x=1794559192;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NbuG3qc5Ygz6oOwaMQOPwnKzcttVVZdHWFqNdlpBeks=;
 b=DrPublqMvho9W7OrMbmxN/IsmVW/htAu8DUxghxuBDVjxf27a3MSKF7r
 m8GuhaYXekYdIGgsRVF4F2kFCCiMgbwlLAhQIAclpuNZeIZoMaN16faY8
 AXRorI1wzWgkGbGdYDORhnxvbAqvWQE6yV35FqdH+HHzp4YQr/CFu3TjO
 1y0wWxYyo3yj3eYuR4vf349q/bqbD2uSazhXvJyU8+GSuPSI/XNoZhTRO
 n8ByTdu5RLI4QqH+KlEUOYsZ/E9kHf+TbjAPsCKr3r5Y0IpF4EVmbTBIH
 E+qcjp/OWm0F6zoBv2Erwu9bzP+b7i1alQ1XIGIA6+b9e9xRUECa94nby w==;
X-CSE-ConnectionGUID: UmiZkOvUTMmhSNvdwv0HAw==
X-CSE-MsgGUID: iUGRwMrkSNKvwJVIJivNlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="75411707"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="75411707"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 00:39:48 -0800
X-CSE-ConnectionGUID: aSdSn8AFTCCYRqtLsTx2yg==
X-CSE-MsgGUID: h+juxu6+TW2TmXeuUpLBYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="220214403"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 00:39:48 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 00:39:47 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 00:39:47 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.69) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 00:39:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TW/HX1pZGBV9SGKnTf5ZQ/EpveqTgeT6OshcvvWL2chJqnXywWwc9thepZlad5cm3PSamI8F8TRGcOwp/Py3xUQfg3ZaKdW+RpWeeo0IZ7ATUbxf+S2hRDh9YrYiV8BSUxgu+he6R4GSAzpR/M4muXt9zQLSdehquy1bf0Df2qAb8W9l/emqMavNbp/kkMh5/MlmAevvwwCg+/MZiasSs5BNq9CZqCa6j0swj3HuguQg8cm8l/x79oBF4d1g6+Hqh5fT64hZb6nZPyIDJl+0nuFiYfdPbyLrFQwFlQtlQHWDarOpSpcA3l/fEwEnXNxAlHGJ6lzBzY4EJW6CADkTXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbuG3qc5Ygz6oOwaMQOPwnKzcttVVZdHWFqNdlpBeks=;
 b=pIgjpJ5MHZjiVHwdmIrklN/d0ivCAjQbtD6Rk3Oxms7hDL/IlJ1p9HGWMWr9d3u920jciZr6NQd0HM64VpL2oiZPnyKlGcaKzfNUoQBxsaPTZ+4tm2M8bJEcPzsPmIWdmpDl9U6xXJLdjQLEAg4E1Utm0XyrhLTKL+6iEB0Zgb12vQt2lNuFZVtZb2SYcovRiUxXin8d8H8GjIuTk9t+IJvSFvZa65YO8olSpnY+S/1M7WZByLS2vpWrJEtXxD4JFlQs7dYlcf5Z2pgyeFXZ45TRInaGlgtkPQA+a9yyVjtgxYdlITw65y8wdPV+xF6V3HAKcWPzfLD/HyJi2uKBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by BL4PR11MB8845.namprd11.prod.outlook.com (2603:10b6:208:5aa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 08:39:44 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 08:39:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v7 14/23] intel_iommu: Propagate PASID-based iotlb
 invalidation to host
Thread-Topic: [PATCH v7 14/23] intel_iommu: Propagate PASID-based iotlb
 invalidation to host
Thread-Index: AQHcRMKXlR97khqAu0+6PAgMoEEd9rTgyO+AgA9YyiA=
Date: Thu, 13 Nov 2025 08:39:44 +0000
Message-ID: <IA3PR11MB913634F5F762EBDBC23F0D0392CDA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-15-zhenzhong.duan@intel.com>
 <39bd639f-4b67-4e90-bed6-299cd7315a87@redhat.com>
In-Reply-To: <39bd639f-4b67-4e90-bed6-299cd7315a87@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|BL4PR11MB8845:EE_
x-ms-office365-filtering-correlation-id: 9599debd-3c9f-4bc4-a6de-08de2290320c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?MkZHZnlBbWpHMnVIUXRkbnNOTHJTdkhVWnE1RVN6d2xOeWI3dG1ORm03c1NP?=
 =?utf-8?B?NHVySm1uREJWeFdINHFQcTBwSW9aZDBmWmhqTzJ3UlhjUE05TUZmSTY5bWlG?=
 =?utf-8?B?L05YWnJwbW5OS1JQeWs2L29iTXRJMjhNMHQ0bTgrNTBtVHV6NWx1TGlqcFNW?=
 =?utf-8?B?cnNwZE1CVU5jalBqOWhqVzdscTE2MUdHRHlBL1JQcTBSR0Z5WDZrNlYwQWow?=
 =?utf-8?B?UHVoQjRIN3ZpRGw3enJBeWlLUWRUdmlLQktrbFdtbHF2RGM4ZWRJdmczUUVO?=
 =?utf-8?B?ak4zbDdyWUthY1ArM2ptSnRIZTVhU2tFUHFQb1ZvUVdiUE1DZDAzcGxUS1Js?=
 =?utf-8?B?dTlueXNrb3hXMVhibTdvdHp0S2VGVG13YWp4RU8wU0JqQmRtNVJSeUkvZWQw?=
 =?utf-8?B?STYvRmt0RzY4MFpCQzNXRTZ6V2lTLzlHM1cyNk1yVnRvOHF1dkk5b3pybEty?=
 =?utf-8?B?dkUwUWlDZVJOUlhFOUN1dlJCRFl3c3hua2FWTXJ1dlFEMW10UHlvM3NSSm0z?=
 =?utf-8?B?MW1aUVJ2SVdLNXRrNlo1UlhFbmtJbVNBcWJtaXVUR2Z2UW5oZWxpTktNWkxn?=
 =?utf-8?B?NGUrRUxDZU11NG9iS2tmbGJ4SzNoNG5DN0N2OUpzV3VWTDZwS2xlVTA5alRv?=
 =?utf-8?B?WXBLb3gzVmlzdXY5d0NlRHl3eUt2cEtKQ3pwRVpUK3RiZjhoU2UxSnBKbDlH?=
 =?utf-8?B?T29uMkU0NkNMVDVKRXVXZE1NOG9oNjJSeVc0TncrM0d6QkN0cU9XUzhzWUhR?=
 =?utf-8?B?VU5RYnYxKzh2YU4rQTEyZ3lrQzliSkUySmI4Uzc4M3k4cGFMNnRpKzJmSnl1?=
 =?utf-8?B?Q25xNXNHZEdaTWZ0OVlaWXc3R1ZKd0FuTHJISlU0WEh2TnF3M3djSmIzZS9O?=
 =?utf-8?B?SHYrNDlic1lSOXZHd0xBMlNrZzBzZVo0UkFockVxa0Q0RGsrT3JWem5GN0Yz?=
 =?utf-8?B?STJXRmFCS3pCZHFFNHJaUU1lVkpRdlRGb2pOZVZCVThtMnZXVThDR3RWWW02?=
 =?utf-8?B?b1AxUXlsV0IrTzZPb09SV0FwWGhDdUJySFFvUWtCYjVBZnBHeWR5TGF3K2Na?=
 =?utf-8?B?YWF6Ym5Uc1ZYT2pXUEwxay9oK2d5NmJBQU9IdkduRklvdU9vRklwazVYSmdt?=
 =?utf-8?B?SEdDam9GRW9SNDl0aGs0eWZHTmlhNCtvdGZCNEQ1MHdYb0V5ajlJRHpXZVNM?=
 =?utf-8?B?ellEUGt4UTQvUDl3WFhObURBdlRUa01HN2ZkZThOWmRlaUQremlJN2RINDBU?=
 =?utf-8?B?NVVGSVhTMjkzRFVlU212eUEvL1pGYXlheWNrZ3NXVm5ZYndMODlpbWlVa3I5?=
 =?utf-8?B?TVBuS3NqYTZSOHJJRTV0SENZU1NueERHMnZ5Q0Z1eExlbWhRVDJxN1E3SU1T?=
 =?utf-8?B?cXZFK1pnMlcyWnRTYXhYQWRKdkxZbHNrWFB0MUthTlZpY2kwcGRXajU0U3o4?=
 =?utf-8?B?MVZuOU9QVUpCYm5xMDRlRHlGbzEyUUNDS0p2YkFYcDZ5OWQ1a0xKVDIyVHpX?=
 =?utf-8?B?YUthWVhMZHErYW9GSFNKdDB1UDc3Z2g2MG9BS2ltMTJKcE00QmNubk1tcnpn?=
 =?utf-8?B?TVlxT1RGMkd6TWErdjRhYklRWjRReVlvb1NKMW5WZEJtYi90b1JQbVBQQklS?=
 =?utf-8?B?TldoWDhUMjNZTFdGT0VCbDRialVzQnRhdDJPZWhxSHM4YmlsczlOSGdwRGdZ?=
 =?utf-8?B?bmNxQTNNUWtoSHJxcWZ0MG4zMjNKdFFDaElqMFJsQ21SZXFUNVM4VWU1ZHdN?=
 =?utf-8?B?YmIrR3k0bkl5VFlRazFxNjNodUJXQzhFNVZLT0xrZkhUcWh0NTA3L3BHakJ1?=
 =?utf-8?B?Rm5MZU05UnBOK2ZIMnNreU1ONnlvQjA2S3lRSWlKTzNMbmM3QzI3MTZMUFZP?=
 =?utf-8?B?UjFYQ1pyc3NnU0ExQ1NWeHowcGtNZW5YMElIWXVsMXZmc0VkdFd2MG9pMFMv?=
 =?utf-8?B?b0x4ZlRiNjIrU0NBbTlHT3ZDZHBpUmdFbzdCRjlQYWhIbWJOZENaUkhCc0R1?=
 =?utf-8?B?Z3Nob2t6aENGeDRtd3pDdnY5NHI3UjNXR21maGUzbTlHMWpZM20reFN1em1Q?=
 =?utf-8?Q?faOpar?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUdCUFQ0UHVMUlJUNm9HV3MrWFdiZEFocld1M1NSRHdUQWd2VVhabkZpbTZz?=
 =?utf-8?B?VkcyNzVKTk9MUDVPbCtFbzBPSDhLWmdyNHR5dmNqYmpDRFFONTVaKzNlY3JH?=
 =?utf-8?B?VWJLTFRhMVBTNkdUbGpocjljUkNaNS9OTTRqVWxnQmJ1dkFtUWxnMkNaWlZl?=
 =?utf-8?B?YnJGek5VRVRjZ0JIdC9pajRmVVAzQ3Y1YVBKNDlna1lpd0t5WkJiQUxndDla?=
 =?utf-8?B?YjJuUXNoem1qKzJOblNIaFNOUThFMWNYQzd6SGRKUTVZakxScDc4NG9UUDYv?=
 =?utf-8?B?eEM0RC9uT2xxMnNmbmFZUGlSQmxzQWxYYk5BWVlsYThWZyswRjcvUitqZ2ho?=
 =?utf-8?B?UnNwcTRxK0tsTXB2VzhYUDh5SGpTdnd2djJubW5YaWV1VUhzRHdLcWFjbVJU?=
 =?utf-8?B?bTBzRmVOUmF2OE1sNHhXOVRoV0dJR21iQmxzZVlFVytZenp1azVEMWJieTIx?=
 =?utf-8?B?dlZSTytLVm1ESU9zYXQ2VUdxa0pxQmNaRkp5dGgwVlhtb0E1RGtaUzdnVFJD?=
 =?utf-8?B?N3F6cnl5L0RoaWNhU3hsYjNUTkwvaEJrQkdzeVMrM2hURFlKME9POWtNOG9V?=
 =?utf-8?B?UGxaQlhaYjlWL0VBR3grb1I3N1ZzenJsKzVVRGFtZHU4TDN4R2RSSnkyd2di?=
 =?utf-8?B?YXRSY0pPaFp2K1A4ZXhGSWRTZHo5ZHZlZWxoK1E0eE1rSWJsckloUzhGcHpn?=
 =?utf-8?B?QWV5ZnNqZnNOdUoyV2dGYUNxUEd6UldKdDVDd1RUNFNUK0FzaEZYZDAvMEdW?=
 =?utf-8?B?UjhCbUJNazh5c3k0TXlrWERtT1lSRXJtall2RXdNSERkNWRuSFdTL3owZjEx?=
 =?utf-8?B?MnJEcXByeXp5ZVA2ejBUQTVrQWhCR0hWZmsxMENDYzBiN3NYbUhUTXh4ZUZW?=
 =?utf-8?B?QXJTWHN6RlVsYTQ4Q2VYSVIzeXhaNm1mZyt5dXVBUkxYUS8yajVDRG9CUkdF?=
 =?utf-8?B?Zi8xL2M0M200eDFuVEJ5RHByRmMvd3VxWEhEejFzN2FqdUtPOHJiWTFNQlEw?=
 =?utf-8?B?UktkZWx0KzBUZFFBNTRDTENybFptL05iNTducjhnVjAvUlFpaTROM3pRRkRm?=
 =?utf-8?B?T01rSjJ2WnkwdmZpL3ppRlJ6RW9XVko0dWJHWGl2L1VKQUtGb2JncXl6TjFy?=
 =?utf-8?B?TnlEdExZdWRGN3dGQVNxQWM0UTVvS3Rpb1RyRUxsV0lLSkdnTVI5cU1ObVg3?=
 =?utf-8?B?d2grMytXL1JjaHh3NXZlU0I1ZFBoTkZpc3RpWDhVRU51clhLSFFLQ0JjVGJr?=
 =?utf-8?B?Q1Z6S3VWL2ZWZzlFdzlWTjRVVUJRa3kyVFZDTXNINjBTODh0eU92TE5wLzlm?=
 =?utf-8?B?R0k4QUJXNWZpVnJQLzZ3dXJINVpZdXMxQTNRck9jTERucWpyM3pqWjVVUTVY?=
 =?utf-8?B?ZlMwUlRROURqa0NXcTRPbTBaUFppY0Zoc1FNUmVmb2xOK1R5TXhpTVJNV28r?=
 =?utf-8?B?aklOSU84VmkxWkNCL004S3FiWGpOeVJyMTlwTmdEQnBtcDhXeS8xQjdsNURn?=
 =?utf-8?B?bU9UaTRxZ2ZiQjJKL21pNTlnNXozQTM1V3VEUlUzUnpPTnFCVzhGelNVcjU1?=
 =?utf-8?B?N3JrUkxWOFNUV1A3YjhmSGV1a0lqcWtVTUZCeXV6SWUwaHlUSkNST1ZVQ3Ja?=
 =?utf-8?B?TE56NDh0YjJzeWRKYndRZER4R29kUUs3T3lybENzekRtWkJ1bUpWY095QlVW?=
 =?utf-8?B?MDBYV0FJd0xra0hwSVQvdnlSc0lNT1k1d2dmWUpHWHA0YzUrZytnQlhWdUh5?=
 =?utf-8?B?M1BMYUtOMS9sazlQUEF1cWFMQnlpV0xrZDdYWk9BVGl4U1JZZ3lxNkhpQTRB?=
 =?utf-8?B?YnQ4eEpIaTJwNXQ0UHpHS2tMYXYvL0lhWmgxWC9CTTRQeXlxNUZxK2dHaFFo?=
 =?utf-8?B?ZEZEOXVHTVg0S1hhaHZSZjFROE95cTdFci81NGxxRU8vUmRFSXRUcmlOT1Rv?=
 =?utf-8?B?RHlsL2dWOTdwY3l3TEk4TzNxNlNEVXcvcForN1F3ZjJHL0NiRnRKTWxuYjND?=
 =?utf-8?B?RWdnNllCWU1ZMGRGTXZLRXVmVklWSXg2YXZxektqSHRYRzl6cXNxa3ZsRFdh?=
 =?utf-8?B?QWNOZk84cWZkOEpHcis0VkRyZnhTV2NRTy8vVHBQYnBWRGl0OGtncWNFZk9T?=
 =?utf-8?Q?YnscZxNZH6Sb3LMOE1y786Dnk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9599debd-3c9f-4bc4-a6de-08de2290320c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 08:39:44.3422 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S95EPxVR8z2c0/YhzCJHnst6iUnHfgttapbDzAcvR7xHoSxxhFdqTDaFU0H8SBHuwNdUZmhs+CPkO0AgJIFIgt7PMFHTPAdgONwlaft4LqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8845
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY3IDE0LzIzXSBpbnRlbF9p
b21tdTogUHJvcGFnYXRlIFBBU0lELWJhc2VkIGlvdGxiDQo+aW52YWxpZGF0aW9uIHRvIGhvc3QN
Cj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+T24gMTAvMjQvMjUgMTA6NDMgQU0sIFpoZW56aG9uZyBE
dWFuIHdyb3RlOg0KPj4gRnJvbTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pg0KPj4g
VGhpcyB0cmFwcyB0aGUgZ3Vlc3QgUEFTSUQtYmFzZWQgaW90bGIgaW52YWxpZGF0aW9uIHJlcXVl
c3QgYW5kIHByb3BhZ2F0ZSBpdA0KPj4gdG8gaG9zdC4NCj4+DQo+PiBJbnRlbCBWVC1kIDMuMCBz
dXBwb3J0cyBuZXN0ZWQgdHJhbnNsYXRpb24gaW4gUEFTSUQgZ3JhbnVsYXJpdHkuIEd1ZXN0IFNW
QQ0KPj4gc3VwcG9ydCBjb3VsZCBiZSBpbXBsZW1lbnRlZCBieSBjb25maWd1cmluZyBuZXN0ZWQg
dHJhbnNsYXRpb24gb24gc3BlY2lmaWMNCj4+IHBhc2lkLiBUaGlzIGlzIGFsc28ga25vd24gYXMg
ZHVhbCBzdGFnZSBETUEgdHJhbnNsYXRpb24uDQo+Pg0KPj4gVW5kZXIgc3VjaCBjb25maWd1cmF0
aW9uLCBndWVzdCBvd25zIHRoZSBHVkEtPkdQQSB0cmFuc2xhdGlvbiB3aGljaCBpcw0KPj4gY29u
ZmlndXJlZCBhcyBmaXJzdCBzdGFnZSBwYWdlIHRhYmxlIG9uIGhvc3Qgc2lkZSBmb3IgYSBzcGVj
aWZpYyBwYXNpZCwgYW5kDQo+PiBob3N0IG93bnMgR1BBLT5IUEEgdHJhbnNsYXRpb24uIEFzIGd1
ZXN0IG93bnMgZmlyc3Qgc3RhZ2UgdHJhbnNsYXRpb24gdGFibGUsDQo+PiBwaW90bGIgaW52YWxp
ZGF0aW9uIHNob3VsZCBiZSBwcm9wYWdhdGVkIHRvIGhvc3Qgc2luY2UgaG9zdCBJT01NVSB3aWxs
DQo+Y2FjaGUNCj4+IGZpcnN0IGxldmVsIHBhZ2UgdGFibGUgcmVsYXRlZCBtYXBwaW5ncyBkdXJp
bmcgRE1BIGFkZHJlc3MgdHJhbnNsYXRpb24uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1
IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlpLnkuc3Vu
QGxpbnV4LmludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVu
emhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICBody9pMzg2L2ludGVsX2lvbW11X2lu
dGVybmFsLmggfCAgNiArKysNCj4+ICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA4
Nw0KPisrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4+ICAyIGZpbGVzIGNoYW5n
ZWQsIDkwIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPmIvaHcvaTM4Ni9pbnRlbF9pb21tdV9p
bnRlcm5hbC5oDQo+PiBpbmRleCBkZjgwYWY4MzlkLi45N2I0ODU0NGQyIDEwMDY0NA0KPj4gLS0t
IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiArKysgYi9ody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmgNCj4+IEBAIC02MjEsNiArNjIxLDEyIEBAIHR5cGVkZWYgc3RydWN0
IFZURFBBU0lEQ2FjaGVJbmZvIHsNCj4+ICAgICAgdWludDMyX3QgcGFzaWQ7DQo+PiAgfSBWVERQ
QVNJRENhY2hlSW5mbzsNCj4+DQo+PiArdHlwZWRlZiBzdHJ1Y3QgVlREUElPVExCSW52SW5mbyB7
DQo+PiArICAgIHVpbnQxNl90IGRvbWFpbl9pZDsNCj4+ICsgICAgdWludDMyX3QgcGFzaWQ7DQo+
PiArICAgIHN0cnVjdCBpb21tdV9od3B0X3Z0ZF9zMV9pbnZhbGlkYXRlICppbnZfZGF0YTsNCj4+
ICt9IFZURFBJT1RMQkludkluZm87DQo+PiArDQo+PiAgLyogUEFTSUQgVGFibGUgUmVsYXRlZCBE
ZWZpbml0aW9ucyAqLw0KPj4gICNkZWZpbmUgVlREX1BBU0lEX0RJUl9CQVNFX0FERFJfTUFTSyAg
KH4weGZmZlVMTCkNCj4+ICAjZGVmaW5lIFZURF9QQVNJRF9UQUJMRV9CQVNFX0FERFJfTUFTSyAo
fjB4ZmZmVUxMKQ0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KPj4gaW5kZXggMzc4OWEzNjE0Ny4uZWY2NDc3ZGU1MyAxMDA2NDQN
Cj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQo+PiBAQCAtMjUwNCwxMSArMjUwNCw4OCBAQCBzdGF0aWMgaW50DQo+dnRkX2JpbmRf
Z3Vlc3RfcGFzaWQoVlREQWRkcmVzc1NwYWNlICp2dGRfYXMsIEVycm9yICoqZXJycCkNCj4+DQo+
PiAgICAgIHJldHVybiByZXQ7DQo+PiAgfQ0KPj4gKw0KPj4gKy8qDQo+PiArICogVGhpcyBmdW5j
dGlvbiBpcyBhIGxvb3AgZnVuY3Rpb24gZm9yIHRoZSBzLT52dGRfYWRkcmVzc19zcGFjZXMNCj4+
ICsgKiBsaXN0IHdpdGggVlREUElPVExCSW52SW5mbyBhcyBleGVjdXRpb24gZmlsdGVyLiBJdCBw
cm9wYWdhdGVzDQo+PiArICogdGhlIHBpb3RsYiBpbnZhbGlkYXRpb24gdG8gaG9zdC4NCj4+ICsg
Ki8NCj4+ICtzdGF0aWMgdm9pZCB2dGRfZmx1c2hfaG9zdF9waW90bGJfbG9ja2VkKGdwb2ludGVy
IGtleSwgZ3BvaW50ZXIgdmFsdWUsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBncG9pbnRlciB1c2VyX2RhdGEpDQo+PiArew0KPj4gKyAgICBWVERQSU9UTEJJ
bnZJbmZvICpwaW90bGJfaW5mbyA9IHVzZXJfZGF0YTsNCj4+ICsgICAgVlREQWRkcmVzc1NwYWNl
ICp2dGRfYXMgPSB2YWx1ZTsNCj4+ICsgICAgVlRESG9zdElPTU1VRGV2aWNlICp2dGRfaGlvZCA9
IHZ0ZF9maW5kX2hpb2RfaW9tbXVmZCh2dGRfYXMpOw0KPj4gKyAgICBWVERQQVNJRENhY2hlRW50
cnkgKnBjX2VudHJ5ID0gJnZ0ZF9hcy0+cGFzaWRfY2FjaGVfZW50cnk7DQo+PiArICAgIHVpbnQx
Nl90IGRpZDsNCj4+ICsNCj4+ICsgICAgaWYgKCF2dGRfaGlvZCkgew0KPj4gKyAgICAgICAgcmV0
dXJuOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGFzc2VydCh2dGRfYXMtPnBhc2lkID09IFBD
SV9OT19QQVNJRCk7DQo+PiArDQo+PiArICAgIC8qIE5vdGhpbmcgdG8gZG8gaWYgdGhlcmUgaXMg
bm8gZmlyc3Qgc3RhZ2UgSFdQVCBhdHRhY2hlZCAqLw0KPj4gKyAgICBpZiAoIXBjX2VudHJ5LT52
YWxpZCB8fA0KPj4gKyAgICAgICAgIXZ0ZF9wZV9wZ3R0X2lzX2ZzdCgmcGNfZW50cnktPnBhc2lk
X2VudHJ5KSkgew0KPj4gKyAgICAgICAgcmV0dXJuOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAg
IGRpZCA9IFZURF9TTV9QQVNJRF9FTlRSWV9ESUQoJnBjX2VudHJ5LT5wYXNpZF9lbnRyeSk7DQo+
PiArDQo+PiArICAgIGlmIChwaW90bGJfaW5mby0+ZG9tYWluX2lkID09IGRpZCAmJiBwaW90bGJf
aW5mby0+cGFzaWQgPT0gUEFTSURfMCkgew0KPj4gKyAgICAgICAgSG9zdElPTU1VRGV2aWNlSU9N
TVVGRCAqaWRldiA9DQo+PiArICAgICAgICAgICAgSE9TVF9JT01NVV9ERVZJQ0VfSU9NTVVGRCh2
dGRfaGlvZC0+aGlvZCk7DQo+PiArICAgICAgICB1aW50MzJfdCBlbnRyeV9udW0gPSAxOyAvKiBP
bmx5IGltcGxlbWVudCBvbmUgcmVxdWVzdCBmb3INCj5zaW1wbGljaXR5ICovDQo+PiArICAgICAg
ICBFcnJvciAqbG9jYWxfZXJyID0gTlVMTDsNCj4+ICsgICAgICAgIHN0cnVjdCBpb21tdV9od3B0
X3Z0ZF9zMV9pbnZhbGlkYXRlICpjYWNoZSA9DQo+cGlvdGxiX2luZm8tPmludl9kYXRhOw0KPj4g
Kw0KPj4gKyAgICAgICAgaWYgKCFpb21tdWZkX2JhY2tlbmRfaW52YWxpZGF0ZV9jYWNoZShpZGV2
LT5pb21tdWZkLA0KPnZ0ZF9hcy0+ZnNfaHdwdCwNCj4+ICsNCj5JT01NVV9IV1BUX0lOVkFMSURB
VEVfREFUQV9WVERfUzEsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHNpemVvZigqY2FjaGUpLA0KPiZlbnRyeV9udW0sIGNhY2hlLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmbG9jYWxfZXJyKSkgew0K
Pj4gKyAgICAgICAgICAgIC8qIFNvbWV0aGluZyB3cm9uZyBpbiBrZXJuZWwsIGJ1dCB0cnlpbmcg
dG8gY29udGludWUgKi8NCj4+ICsgICAgICAgICAgICBlcnJvcl9yZXBvcnRfZXJyKGxvY2FsX2Vy
cik7DQo+PiArICAgICAgICB9DQo+PiArICAgIH0NCj4+ICt9DQo+PiArDQo+PiArc3RhdGljIHZv
aWQNCj4+ICt2dGRfZmx1c2hfaG9zdF9waW90bGJfYWxsX2xvY2tlZChJbnRlbElPTU1VU3RhdGUg
KnMsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDE2X3QgZG9tYWlu
X2lkLCB1aW50MzJfdA0KPnBhc2lkLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGh3YWRkciBhZGRyLCB1aW50NjRfdCBucGFnZXMsDQo+Ym9vbCBpaCkNCj4+ICt7DQo+PiAr
ICAgIHN0cnVjdCBpb21tdV9od3B0X3Z0ZF9zMV9pbnZhbGlkYXRlIGNhY2hlX2luZm8gPSB7IDAg
fTsNCj4+ICsgICAgVlREUElPVExCSW52SW5mbyBwaW90bGJfaW5mbzsNCj4+ICsNCj4+ICsgICAg
Y2FjaGVfaW5mby5hZGRyID0gYWRkcjsNCj4+ICsgICAgY2FjaGVfaW5mby5ucGFnZXMgPSBucGFn
ZXM7DQo+PiArICAgIGNhY2hlX2luZm8uZmxhZ3MgPSBpaCA/IElPTU1VX1ZURF9JTlZfRkxBR1Nf
TEVBRiA6IDA7DQo+PiArDQo+PiArICAgIHBpb3RsYl9pbmZvLmRvbWFpbl9pZCA9IGRvbWFpbl9p
ZDsNCj4+ICsgICAgcGlvdGxiX2luZm8ucGFzaWQgPSBwYXNpZDsNCj4+ICsgICAgcGlvdGxiX2lu
Zm8uaW52X2RhdGEgPSAmY2FjaGVfaW5mbzsNCj4+ICsNCj4+ICsgICAgLyoNCj4+ICsgICAgICog
R28gdGhyb3VnaCBlYWNoIHZ0ZF9hcyBpbnN0YW5jZSBpbiBzLT52dGRfYWRkcmVzc19zcGFjZXMs
IGZpbmQNCj5vdXQNCj4+ICsgICAgICogdGhlIGFmZmVjdGVkIGhvc3QgZGV2aWNlIHdoaWNoIG5l
ZWQgaG9zdCBwaW90bGIgaW52YWxpZGF0aW9uLiBQaW90bGINCj50aGUgYWZmZWN0ZWQgaG9zdCBk
ZXZpY2VzPyBUaGVyZSBtaWdodCBiZSBzZXZlcmFsIG9mIHRoZW0sIGlzbid0IGl0Pw0KDQpZZXMs
IGl0J3MgcG9zc2libGUsIGVzcGVjaWFsbHkgaWYgdGhleSBhcmUgdW5kZXIgc2FtZSBpb21tdSBn
cm91cCBpbiB0aGUgZ3Vlc3QuDQoNCj4+ICsgICAgICogaW52YWxpZGF0aW9uIHNob3VsZCBjaGVj
ayBwYXNpZCBjYWNoZSBwZXIgYXJjaGl0ZWN0dXJlIHBvaW50IG9mDQo+dmlldy4NCj4+ICsgICAg
ICovDQo+PiArICAgIGdfaGFzaF90YWJsZV9mb3JlYWNoKHMtPnZ0ZF9hZGRyZXNzX3NwYWNlcywN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgdnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2xvY2tl
ZCwNCj4mcGlvdGxiX2luZm8pOw0KPj4gK30NCj4+ICAjZWxzZQ0KPj4gIHN0YXRpYyBpbnQgdnRk
X2JpbmRfZ3Vlc3RfcGFzaWQoVlREQWRkcmVzc1NwYWNlICp2dGRfYXMsIEVycm9yICoqZXJycCkN
Cj4+ICB7DQo+PiAgICAgIHJldHVybiAwOw0KPj4gIH0NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZA0K
Pj4gK3Z0ZF9mbHVzaF9ob3N0X3Bpb3RsYl9hbGxfbG9ja2VkKEludGVsSU9NTVVTdGF0ZSAqcywN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MTZfdCBkb21haW5faWQs
IHVpbnQzMl90DQo+cGFzaWQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aHdhZGRyIGFkZHIsIHVpbnQ2NF90IG5wYWdlcywNCj5ib29sIGloKQ0KPj4gK3sNCj4+ICt9DQo+
PiAgI2VuZGlmDQo+Pg0KPj4gIC8qIERvIGEgY29udGV4dC1jYWNoZSBkZXZpY2Utc2VsZWN0aXZl
IGludmFsaWRhdGlvbi4NCj4+IEBAIC0zMTU1LDYgKzMyMzIsNyBAQCBzdGF0aWMgdm9pZA0KPnZ0
ZF9waW90bGJfcGFzaWRfaW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiAgICAgIHZ0
ZF9pb21tdV9sb2NrKHMpOw0KPj4gICAgICBnX2hhc2hfdGFibGVfZm9yZWFjaF9yZW1vdmUocy0+
aW90bGIsDQo+dnRkX2hhc2hfcmVtb3ZlX2J5X3Bhc2lkLA0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgJmluZm8pOw0KPj4gKyAgICB2dGRfZmx1c2hfaG9zdF9waW90bGJfYWxs
X2xvY2tlZChzLCBkb21haW5faWQsIHBhc2lkLCAwLCAodWludDY0X3QpLTEsDQo+MCk7DQo+VUlO
VDY0X01BWA0KPg0KPj4gICAgICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KPj4NCj4+ICAgICAgUUxJ
U1RfRk9SRUFDSCh2dGRfYXMsICZzLT52dGRfYXNfd2l0aF9ub3RpZmllcnMsIG5leHQpIHsNCj4+
IEBAIC0zMTc0LDcgKzMyNTIsOCBAQCBzdGF0aWMgdm9pZA0KPnZ0ZF9waW90bGJfcGFzaWRfaW52
YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiAgfQ0KPj4NCj4+ICBzdGF0aWMgdm9pZCB2
dGRfcGlvdGxiX3BhZ2VfaW52YWxpZGF0ZShJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90DQo+
ZG9tYWluX2lkLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQzMl90IHBhc2lkLCBod2FkZHINCj5hZGRyLCB1aW50OF90IGFtKQ0KPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBhc2lkLCBod2FkZHINCj5hZGRy
LCB1aW50OF90IGFtLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGJvb2wgaWgpDQo+PiAgew0KPj4gICAgICBWVERJT1RMQlBhZ2VJbnZJbmZvIGluZm87DQo+Pg0K
Pj4gQEAgLTMxODYsNiArMzI2NSw3IEBAIHN0YXRpYyB2b2lkDQo+dnRkX3Bpb3RsYl9wYWdlX2lu
dmFsaWRhdGUoSW50ZWxJT01NVVN0YXRlICpzLCB1aW50MTZfdCBkb21haW5faWQsDQo+PiAgICAg
IHZ0ZF9pb21tdV9sb2NrKHMpOw0KPj4gICAgICBnX2hhc2hfdGFibGVfZm9yZWFjaF9yZW1vdmUo
cy0+aW90bGIsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2dGRfaGFzaF9y
ZW1vdmVfYnlfcGFnZV9waW90bGIsDQo+JmluZm8pOw0KPj4gKyAgICB2dGRfZmx1c2hfaG9zdF9w
aW90bGJfYWxsX2xvY2tlZChzLCBkb21haW5faWQsIHBhc2lkLCBhZGRyLCAxIDw8IGFtLA0KPmlo
KTsNCj4+ICAgICAgdnRkX2lvbW11X3VubG9jayhzKTsNCj4+DQo+PiAgICAgIHZ0ZF9pb3RsYl9w
YWdlX2ludmFsaWRhdGVfbm90aWZ5KHMsIGRvbWFpbl9pZCwgYWRkciwgYW0sIHBhc2lkKTsNCj4+
IEBAIC0zMjE3LDcgKzMyOTcsOCBAQCBzdGF0aWMgYm9vbA0KPnZ0ZF9wcm9jZXNzX3Bpb3RsYl9k
ZXNjKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+ICAgICAgY2FzZSBWVERfSU5WX0RFU0NfUElPVExC
X1BTSV9JTl9QQVNJRDoNCj4+ICAgICAgICAgIGFtID0gVlREX0lOVl9ERVNDX1BJT1RMQl9BTShp
bnZfZGVzYy0+dmFsWzFdKTsNCj4+ICAgICAgICAgIGFkZHIgPSAoaHdhZGRyKQ0KPlZURF9JTlZf
REVTQ19QSU9UTEJfQUREUihpbnZfZGVzYy0+dmFsWzFdKTsNCj4+IC0gICAgICAgIHZ0ZF9waW90
bGJfcGFnZV9pbnZhbGlkYXRlKHMsIGRvbWFpbl9pZCwgcGFzaWQsIGFkZHIsIGFtKTsNCj5pdCBp
cyBub3Qgb2J2aW91cyB3ZSBob2xkIHRoZSBsb2NrIGhlcmUNCg0KRG8geW91IG1lYW4gdnRkX2lv
bW11X2xvY2s/IEl0J3MgaG9sZCBpbnNpZGUgdnRkX3Bpb3RsYl9wYWdlX2ludmFsaWRhdGUoKS4N
Cg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K

