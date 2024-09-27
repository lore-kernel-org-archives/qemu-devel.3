Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C0DCEBF65
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 06:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su4d2-0006ZS-DK; Fri, 27 Sep 2024 02:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1su4d1-0006W0-HE
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 02:38:59 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1su4cz-0006d1-JZ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 02:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727419137; x=1758955137;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+jgFhc58s4/fnMj9oirJivKvbUYj7fhMJB1vNUtlCds=;
 b=Rz8RB3Q67bqiDmUaGZvkwQm+NCyFmaB6KWcd0bkqadU4q1Un3vj0Avho
 xLD1yWe//Z0YSbWdaCppK/iKD2cpZ34IBhgyUYAVpWTq0zpCh94BrXQ16
 nASBogzzJBVs90c0EUJdb4YiZb8R0OQCdfOu+f6RfwMfB5XaU/BjAKRxe
 /R88f/5hstwCX7z41s6qomiyWZ1F7r9PLbs+GWMvsZ+4BUwkRUvIACpz/
 8gGhT2UI8/pwarMnOcgHpvoXBXKWFJCdyM1zbBIqN4k58izBnuz6ppTQV
 zDrp5Beg/PwdMAu8zjfspWkA6hqVqiprcOH168YmSmAgdpSa66eSYAsi0 Q==;
X-CSE-ConnectionGUID: H+HPVXFbSoappVOxsj0dlA==
X-CSE-MsgGUID: qmqxABpeRhGXIPyImCQQ+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="51967785"
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; d="scan'208";a="51967785"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2024 23:38:55 -0700
X-CSE-ConnectionGUID: Bq+mE7u2TYmoTsgtDjl4hg==
X-CSE-MsgGUID: 9O9dcEGTQyaQ+czl5b7Izg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,157,1725346800"; d="scan'208";a="77258984"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Sep 2024 23:38:54 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 23:38:53 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 23:38:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 26 Sep 2024 23:38:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 26 Sep 2024 23:38:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 23:38:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygbSsywOCZnhs727rYpFzCjBswaLPbFQiqoMT4R9La1vxFAImoSIkmHlzvzAwk8RAHUlFL40miC+s+uzxznnGY4n/iLuSGV9Qal+0B8MfQJN2dMwACXmo4EsPWJcUJQ1iBKWl6h9K0uNMGnAkMO2w48TMNBO5xGnSgp9oOe/VDWz9fi8eFTuL+3KfokbKAK5+mjalWDCFKWjDIeFJrXy39nYPU/Xvy8KT4OKAuAre02Fw6Yj7QO0+M5ScePhV5J3PSN4jE/6AeJNg0EFfSM6CNL0stICmik6dah4iPicOcZkcPZpY+15XlOEMx7WwvrvNItLlVAbEWLpm/NpqDiedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jgFhc58s4/fnMj9oirJivKvbUYj7fhMJB1vNUtlCds=;
 b=GrGcIZ7/NhplWMe0o4MqkLJUdSgwNctseSmhN382pbXCv2oodYh2AxNez4LfXfEqkIvV99Cva3GJ6Cg1trDTEFoipEYClg5x1fnwtFppSVrnEQ273gkTU4B3tZY7uDusTDJKNEjVdSR+a+Dpq2x8LaWy9XAHFP+kmd7m3EdJBiS5jqIWjuTA9GkL839xiyFVP+4bqcrw2lVtA2E+gMn71H7b6EaEVrGedw+IZzKaBRUH6fWb20EVWs40Z+xaS3lHvVTTe0nzpJCbLNc0KxK0MrPIOl+ZnQ6wdkc/ltA1TgNMGC/13F2pmhOkwhDprgDkqIUzD+ZPiGDv+KeExeCxvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB6495.namprd11.prod.outlook.com (2603:10b6:8:c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Fri, 27 Sep
 2024 06:38:49 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 06:38:49 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v3 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modern mode
Thread-Topic: [PATCH v3 14/17] intel_iommu: Set default aw_bits to 48 in
 scalable modern mode
Thread-Index: AQHbBAtAgk8I02zLVkit3zw09AVFXrJrHZ8AgAAcKdA=
Date: Fri, 27 Sep 2024 06:38:49 +0000
Message-ID: <SJ0PR11MB6744CF33309D78D902DD052E926B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-15-zhenzhong.duan@intel.com>
 <CACGkMEuV=ZdnGE7N=YehCxpNiVPXai=WUdgJjnxVxwzBnTMEOQ@mail.gmail.com>
In-Reply-To: <CACGkMEuV=ZdnGE7N=YehCxpNiVPXai=WUdgJjnxVxwzBnTMEOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB6495:EE_
x-ms-office365-filtering-correlation-id: 2e847971-330d-40dc-ac23-08dcdebf0b8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TmJnd09IVEl2eFhwU1h4NE9jUmF4Q3NFRGdoV1VDSWRPajNsd1FoR2cyYjJ1?=
 =?utf-8?B?T2NEVW03WHpmVHJMdktpNkxSOW1aOEp1c2VsTEh5aFFIN25JRFUrVWhRMHhF?=
 =?utf-8?B?aEI1MnJUUDZydisrS2pxZHVPUG4zVlhDMmtQeGtZUzR5WmZSb2NlNzJWUW1z?=
 =?utf-8?B?VjJzaWpyQWxPNElqSG1sUXdGQUVTNDZoUTRRcWpEWXV2V1JtVmZDZ2R1aXcv?=
 =?utf-8?B?VDVvRkRwbmFXdkFudnFUdG1zdUNEbnkzaEpHa09tTUtwNURaTDJ1MVdxYnFq?=
 =?utf-8?B?ejJaejdGeUdtbWxSSlIrWnFmSGU0WDcwejdMWnVHM3RvK1o4MFN0MElUWjNX?=
 =?utf-8?B?Uk1xd0ZNVjVGcVRWcjJTbWxsWjZVd3ptVHlGNUNJNXR3dzJST1VaNUhyNjhB?=
 =?utf-8?B?S0dXM1F6OW1KeDJncmpKZUR0RDZRdE4rUlk1akpsSUlnaFJRQm11cUtTQ0Jl?=
 =?utf-8?B?V1ErZVZCbTE1WC8rVHVvS3pLa3FPTTI1WE9uaTFjQkluMXp0WDIwajROZDU0?=
 =?utf-8?B?bytpVDNtWUVPK1lCWWV1Z2pFcnplYUZ0cmU1ei9xMUg2ZXhEN3grZ1VGTDBV?=
 =?utf-8?B?VisvdDhHTXVVNXArSWJOcW5VN1VBQ0p5UnF0YUVUdlM3UnZCZitaUU55Z3JQ?=
 =?utf-8?B?WWxDdzYyM01JK3BkZU9vM3JTV2s5TGUxVnJHWHppQjZrREgyWEMrUTZDczNT?=
 =?utf-8?B?SzMrS2d1c1pRcldNWk56T0l4ODUxYSt1WlJhVm5tVGtnWmlsc3FjUmI2MElP?=
 =?utf-8?B?SEhQaG8rbmJHdi9LSHNtT0VZcDBzbEJ1b0UxYnZvSGxKb21qdExFbkwybkxX?=
 =?utf-8?B?YnVKNThCUHc3YmJTRVUxVTFlU29Ma2kydzlNdC9TbzZvL1lsc0lQUDR6U0s2?=
 =?utf-8?B?WFE3Zm9aMWhNbHVad3J4Q1NQVjEwMXFqSmY3ek03cC94TythOGhCTElIMmM1?=
 =?utf-8?B?TVBRYmJ2azdRaER3a2VpVitUV3lQTnA0RGRETmRvVmdRTGxhdEd6UVgzU3lX?=
 =?utf-8?B?Z3UrbjFPd2lISDNJb3JvR0hkNHpjTjN5dnUzSHBZNjF3dWVCZi81NlpSOGVN?=
 =?utf-8?B?TGJhZWxFelJ1Sll1V1N1QTdDMUVSMVdQUC9HS1pxM0V3c2NYdjdjK3IvcEFF?=
 =?utf-8?B?YzR2SFdQaUE4blpGOFZETlQ0c2ljYjVYb3BHejJ4cXFWSjJvRlgzdHRnVGdC?=
 =?utf-8?B?WmFqS2VNVUFZOTR1RzVkRko3NU85RjBDZXQ4c29NeTNIaENnZ0xTQ2krWXNT?=
 =?utf-8?B?aHc0NHhybzU2SXpKQVhtVHEzUTBjZWtMdkhYdzhhSkpRWFY5Vmw3V2RybHlp?=
 =?utf-8?B?Si9KV2pFVWRyK1pmbzhVbnJ6VXNVNUUvdnBoNGJpaERRQnBPVE5mczhvempJ?=
 =?utf-8?B?ZmIzc1EySFNMQUMxMEJ5Szg0VHRZZ0FoWFFZbGtBT3pJYTN5ak8vOUxLMEpy?=
 =?utf-8?B?Qm1MMzY0dUliaGZBUFZRaW5PWm0rTGhJQlNWSzhqVDAzTkdqM1ZiL3FWOVVz?=
 =?utf-8?B?SzhmT3IxMnk1WGxJYmtFcDhHUlk1YWdLUW1aVEJXMUYyQ3g2bXZLZWZmN1RO?=
 =?utf-8?B?UGQxbmw3alo2WkNNa0tlYmtUQWFEQVpIS0dRbCtDek84emlmaWp5YWVEeXRr?=
 =?utf-8?B?RGtqSFFoYklpVEZwOFJ4QUExaUliRDVrY0JmWW81MzFqK2xlN21IbUV1dW9w?=
 =?utf-8?B?K09TNTFmRXZra0RDQm1SVzFhRmdVWS9NVDlMcEZmK2RxSS8xQS9yUW9vRnhj?=
 =?utf-8?B?Vk84cEFLUDhNRWRPNjFEN1NhcEYveHRCeWpBc1lWcmNBQXhSLzdWQjFGL0lx?=
 =?utf-8?B?dXhndWo5M1NQc2ZRMFFjVE1VOG1FVkFsNTRWaElzTEp2QXRpWGFFSDdsd01U?=
 =?utf-8?B?WGZMMWtEVFFHVXFBeDBMNmxlY00zV0Z3dEh5b1RlM1Jhbmc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFpzK2JFWHpQcTBnSVNCcXZDRDEwa1c2c3RHRmFpeld2L1A0ZWZCTWI4OG5o?=
 =?utf-8?B?K2dpd2piWUxrSXJEZEJGaFBpdGhEUjhVS2hVWVpoOHR5VHlSL2tBWUZnK0kw?=
 =?utf-8?B?aHlwSWtlRVdwT3prUmQ0VjRFcXZsRFF0RkxEK1dmTHBsR0N1UERPZ3Zjdkl5?=
 =?utf-8?B?SUw4NnptYTdTVXZMdElVODFnZUVIMFNUZUdMWlI5a25rbDlnaVRTanF0bU1m?=
 =?utf-8?B?TlpITUFXVVE0bmNiWHhHRi9uUnEyMlhjY0NybjJPOWx5K0FHRUozcVVEUFRl?=
 =?utf-8?B?ekc5eERYN0xOQk9qa2RPTEpoRlQvQnVEU2drRW4yZnNOa3lnUURGS2lKcThx?=
 =?utf-8?B?RWRST08xZ21CSmNvdDlkWWtGTnIzb1hmS3cxMm5NSUxEdlVkMFlaMHJ4S1pI?=
 =?utf-8?B?dm9yNWJKRnQ4UmoxWEJzTEg2L3hiazQyVkxINlUvTDRCNmc0UnVIWjNKRGdv?=
 =?utf-8?B?MlBKVXlLRDRIWE1xZDYxK1VLMlZXZmlEYVdKQVlGMlQ0QWhGRnRyWHFWM0Fx?=
 =?utf-8?B?TzhTN2puTlNDZ3R3aHprS2t1VkhvbTczQWFzQ2o1amhOYTc0bk9Zdmp6T3VM?=
 =?utf-8?B?bmpXZElvQTloNHZrcWRvT3pGdXkxeGlkbk96ZkFIM2VpWmRhWjlCQjFtN3Nv?=
 =?utf-8?B?UjM2dFFsdEJXbHl4aHZTeTBwR2pEWXkvYmErNm1FOWJEbkdYVnZWemFyUXQ0?=
 =?utf-8?B?U3NJM25RTnhPangxMlZNSWIreGZrclhXMC9RMTZSS2Vhb3ZlKzFLeDFWMmdL?=
 =?utf-8?B?c3ZSbFV5MzZZMHlsR25jUHFXY0VHNUgxRTRUVGhBQ0FqWjFob01nYzQwOUJT?=
 =?utf-8?B?NW9hTnpaaXhDQVpTNGR0NW4zSkZiZ2lmNXQ5bGVzbUlqVDFoOEhJU05hNTg4?=
 =?utf-8?B?WXBpMUZPZEE1VWdCUmpnMmFOM0dsY0Z6SnA0V2dkbnV1bXNtQU8wUWpQeUQ4?=
 =?utf-8?B?Q0NCWks2ZWsxMllMYmlpYVFCajlMOXdKWEcyd1JpR25zS3lmcW5KRUxCbXJv?=
 =?utf-8?B?QzNOSit4K1FFdVNPYnhmRGo0Qis0YXFBNWROZGpQZkRJYlRSaUMzV2VrWUVx?=
 =?utf-8?B?dTBaRG1qc0dTTmlKaFcrQjhMdmtEbHpjOHVBWk5UcWkzNUVEME1aeFc4Qm5i?=
 =?utf-8?B?bGdMdG9LVVRZQlBZQWhtbXlWZlpWaXdMUmRNTEtNY01ZVGh2Z3prbDNpWTJ0?=
 =?utf-8?B?dE9RcTgwZ3dyb1lyeDlyR1NqdTNXN1lheE1ieVFHeUYvZWk4M3VFTFFxOXVs?=
 =?utf-8?B?UnRsNWR2MG1EcHREVk5PRm1MUUtwdk5DVWlmSUloY0JPa05sNmFXUDhXeGs0?=
 =?utf-8?B?UFVESHBBV3lUazhvYXYyMjZadFdBeVZSWEl0OVFhY09FWjA2N0d1QzhGMFcw?=
 =?utf-8?B?TlE1UXIxM05pcWJ2RHZnNmxkZGZzL2lkdU9wbCtHYXEweENRNDJMOUNDTXdQ?=
 =?utf-8?B?RGhjZWU1WTRUOXpXNk1FcTJwNFJXcjcyT3pkeTduYkJlK2xyNzVPRm1pM0Uv?=
 =?utf-8?B?ckNuNTBEeE96d0xsTkhWWmtXak9NSlp5N3luYmM5MURzSEVULzhqVVYrbGRO?=
 =?utf-8?B?RmxmQ01xQzl2Q0tESXlheldpNUZFYVBnNmJ3QS83Wm85SHNRU0J1UjhUMVov?=
 =?utf-8?B?b0U4MDVTTzZyVloyN2VsQU5FdzVaaEhWZWpiTFA3OWlacGtSeVhNNE15QjBI?=
 =?utf-8?B?djZNS0RYZ0ppM1JzWExyUndsQzlEQXNDbGxwaWRVWldXT3VTUHBPRHF5Qm1Y?=
 =?utf-8?B?ZVlacEhDaUc2b2MxcXdlRThlL2hrZWVWT1Q0UUQxZVpocDVkY0lmUXBreGMz?=
 =?utf-8?B?ZTNDQ2FpRlNVTGpxb09SRjEzZjJpWWx5djNLTkdacStVMnpBQk8xSHZVbXNK?=
 =?utf-8?B?STREWC9oYkVVOE85a0FPSW1qa3hjbzZISXg1WlZNelFiVzdQQ0NVUUJrczJq?=
 =?utf-8?B?bTB2SEY0Y2FNSW9UM2d6QUdqd1VMRGtaVldrbitpSHBqelE0TFovZnBHN3Bh?=
 =?utf-8?B?QlBNZUNjTjMxelN6Rjl3anZ1NnhLSjVUMHl1ZVhaVnd4c09nekFqZENFZzJI?=
 =?utf-8?B?ZzBsTnpST0h3OW1yb3dhWFZyTm5zU2R5RjVJcXUyKzFCRDd1OW9FMGEyTGIv?=
 =?utf-8?Q?e30JUUVQ4K9+p05JtJ6wlHe5x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e847971-330d-40dc-ac23-08dcdebf0b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2024 06:38:49.3411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fu6B2xvz2Resiy1Q7LcPC/9PgZUKq/gEwPQGaIu9UlJZQm2uUMQjivsSEpTPIgjtNOm5TKrjEa5HIPTnWnze6nYStfSSlxSYdMARMHs3oJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6495
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAxNC8xN10gaW50ZWxfaW9t
bXU6IFNldCBkZWZhdWx0IGF3X2JpdHMgdG8gNDggaW4NCj5zY2FsYWJsZSBtb2Rlcm4gbW9kZQ0K
Pg0KPk9uIFdlZCwgU2VwIDExLCAyMDI0IGF0IDE6MjfigK9QTSBaaGVuemhvbmcgRHVhbg0KPjx6
aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+IHdyb3RlOg0KPj4NCj4+IEFjY29yZGluZyB0byBWVEQg
c3BlYywgc3RhZ2UtMSBwYWdlIHRhYmxlIGNvdWxkIHN1cHBvcnQgNC1sZXZlbCBhbmQNCj4+IDUt
bGV2ZWwgcGFnaW5nLg0KPj4NCj4+IEhvd2V2ZXIsIDUtbGV2ZWwgcGFnaW5nIHRyYW5zbGF0aW9u
IGVtdWxhdGlvbiBpcyB1bnN1cHBvcnRlZCB5ZXQuDQo+PiBUaGF0IG1lYW5zIHRoZSBvbmx5IHN1
cHBvcnRlZCB2YWx1ZSBmb3IgYXdfYml0cyBpcyA0OC4NCj4+DQo+PiBTbyBkZWZhdWx0IGF3X2Jp
dHMgdG8gNDggaW4gc2NhbGFibGUgbW9kZXJuIG1vZGUuIEluIG90aGVyIGNhc2VzLA0KPj4gaXQg
aXMgc3RpbGwgZGVmYXVsdCB0byAzOSBmb3IgY29tcGF0aWJpbGl0eS4NCj4+DQo+PiBBZGQgYSBj
aGVjayB0byBlbnN1cmUgdXNlciBzcGVjaWZpZWQgdmFsdWUgaXMgNDggaW4gbW9kZXJuIG1vZGUN
Cj4+IGZvciBub3cuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56
aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1E
cmlmPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KPj4gLS0tDQo+PiAgaW5jbHVk
ZS9ody9pMzg2L2ludGVsX2lvbW11LmggfCAgMiArLQ0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXUu
YyAgICAgICAgIHwgMTAgKysrKysrKysrLQ0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9p
Mzg2L2ludGVsX2lvbW11LmgNCj5iL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiBp
bmRleCBiODQzZDA2OWNjLi40ODEzNGJkYTExIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody9p
Mzg2L2ludGVsX2lvbW11LmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5o
DQo+PiBAQCAtNDUsNyArNDUsNyBAQCBPQkpFQ1RfREVDTEFSRV9TSU1QTEVfVFlQRShJbnRlbElP
TU1VU3RhdGUsDQo+SU5URUxfSU9NTVVfREVWSUNFKQ0KPj4gICNkZWZpbmUgRE1BUl9SRUdfU0la
RSAgICAgICAgICAgICAgIDB4MjMwDQo+PiAgI2RlZmluZSBWVERfSE9TVF9BV18zOUJJVCAgICAg
ICAgICAgMzkNCj4+ICAjZGVmaW5lIFZURF9IT1NUX0FXXzQ4QklUICAgICAgICAgICA0OA0KPj4g
LSNkZWZpbmUgVlREX0hPU1RfQUREUkVTU19XSURUSCAgICAgIFZURF9IT1NUX0FXXzM5QklUDQo+
PiArI2RlZmluZSBWVERfSE9TVF9BV19BVVRPICAgICAgICAgICAgMHhmZg0KPj4gICNkZWZpbmUg
VlREX0hBV19NQVNLKGF3KSAgICAgICAgICAgICgoMVVMTCA8PCAoYXcpKSAtIDEpDQo+Pg0KPj4g
ICNkZWZpbmUgRE1BUl9SRVBPUlRfRl9JTlRSICAgICAgICAgICgxKQ0KPj4gZGlmZiAtLWdpdCBh
L2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gaW5kZXgg
YzI1MjExZGRhZi4uOTQ5ZjEyMDQ1NiAxMDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9t
bXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiBAQCAtMzc3MSw3ICszNzcx
LDcgQEAgc3RhdGljIFByb3BlcnR5IHZ0ZF9wcm9wZXJ0aWVzW10gPSB7DQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE9OX09GRl9BVVRPX0FVVE8pLA0KPj4gICAgICBERUZJTkVfUFJP
UF9CT09MKCJ4LWJ1Z2d5LWVpbSIsIEludGVsSU9NTVVTdGF0ZSwgYnVnZ3lfZWltLA0KPmZhbHNl
KSwNCj4+ICAgICAgREVGSU5FX1BST1BfVUlOVDgoImF3LWJpdHMiLCBJbnRlbElPTU1VU3RhdGUs
IGF3X2JpdHMsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgIFZURF9IT1NUX0FERFJFU1NfV0lE
VEgpLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICBWVERfSE9TVF9BV19BVVRPKSwNCj4NCj5T
dWNoIGNvbW1hbmQgbGluZSBBUEkgc2VlbXMgdG8gYmUgd2lyZWQuDQo+DQo+SSB0aGluayB3ZSBj
YW4gc3RpY2sgdGhlIGN1cnJlbnQgZGVmYXVsdCBhbmQgd2hlbiBzY2FsYWJsZSBtb2Rlcm4gaXMN
Cj5lbmFibGVkIGJ5IGF3IGlzIG5vdCBzcGVjaWZpZWQsIHdlIGNhbiBjaGFuZ2UgYXcgdG8gNDg/
DQoNCkN1cnJlbnQgZGVmYXVsdCBpcyAzOS4gSSB1c2UgVlREX0hPU1RfQVdfQVVUTyB0byBpbml0
aWFsaXplIGF3IGFzIG5vdCBzcGVjaWZpZWQuDQpEbyB3ZSBoYXZlIG90aGVyIHdheSB0byBjYXRj
aCB0aGUgdXBkYXRlIGlmIHdlIHN0aWNrIHRvIDM5Pw0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+
DQo+PiAgICAgIERFRklORV9QUk9QX0JPT0woImNhY2hpbmctbW9kZSIsIEludGVsSU9NTVVTdGF0
ZSwgY2FjaGluZ19tb2RlLA0KPkZBTFNFKSwNCj4+ICAgICAgREVGSU5FX1BST1BfQk9PTCgieC1z
Y2FsYWJsZS1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLA0KPnNjYWxhYmxlX21vZGUsIEZBTFNFKSwN
Cj4+ICAgICAgREVGSU5FX1BST1BfQk9PTCgic25vb3AtY29udHJvbCIsIEludGVsSU9NTVVTdGF0
ZSwgc25vb3BfY29udHJvbCwNCj5mYWxzZSksDQo+PiBAQCAtNDY4Niw2ICs0Njg2LDE0IEBAIHN0
YXRpYyBib29sDQo+dnRkX2RlY2lkZV9jb25maWcoSW50ZWxJT01NVVN0YXRlICpzLCBFcnJvciAq
KmVycnApDQo+PiAgICAgICAgICB9DQo+PiAgICAgIH0NCj4+DQo+PiArICAgIGlmIChzLT5hd19i
aXRzID09IFZURF9IT1NUX0FXX0FVVE8pIHsNCj4+ICsgICAgICAgIGlmIChzLT5zY2FsYWJsZV9t
b2Rlcm4pIHsNCj4+ICsgICAgICAgICAgICBzLT5hd19iaXRzID0gVlREX0hPU1RfQVdfNDhCSVQ7
DQo+PiArICAgICAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgICAgIHMtPmF3X2JpdHMgPSBWVERf
SE9TVF9BV18zOUJJVDsNCj4+ICsgICAgICAgIH0NCj4+ICsgICAgfQ0KPj4gKw0KPj4gICAgICBp
ZiAoKHMtPmF3X2JpdHMgIT0gVlREX0hPU1RfQVdfMzlCSVQpICYmDQo+PiAgICAgICAgICAocy0+
YXdfYml0cyAhPSBWVERfSE9TVF9BV180OEJJVCkgJiYNCj4+ICAgICAgICAgICFzLT5zY2FsYWJs
ZV9tb2Rlcm4pIHsNCj4+IC0tDQo+PiAyLjM0LjENCj4+DQo+DQo+VGhhbmtzDQoNCg==

