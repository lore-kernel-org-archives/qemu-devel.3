Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AB0CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 06:25:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Bym-00019m-6n; Mon, 13 Oct 2025 02:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8Byh-00019A-6s
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:24:16 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8Byc-0006cM-6T
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760336651; x=1791872651;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=I7U04ogsRMZ4To8CfOkxfSMDC+CaQ5H7yFlJUQQGX9Y=;
 b=A8VhNyf5WB1jO8za6qJLREcUoVTuQxn0HL7cKwh+sQMH1z4x+4BKH/bs
 8JcUQ++l95+NZYA3hrvSYXBFH3xMcwugNXnV7T/8sZp1Ex33M8Jepd3ra
 H4oi9vr7OYmXqaWJd1H4GkmNbARX8YNpPqs5fOyWeNTc7tjmjDngxgpYn
 shRubMfjjpf4nixY3wqcvcowqj92rDckv7OOve9wJ1nz0YBSF8ucPZ/NE
 tVxAxsehFVFNlSDxnb4UoRSt2kwjnuShnZUWKQug1Pm+cwfQFww1BLQ9i
 DdjqxAj9a/Bn7GX4ghuYzFBSVw4C6Hk0232+f5rAAyczkY+lVtn+xRM1a g==;
X-CSE-ConnectionGUID: Sop5PyDpTBKfDVOlUtxKhw==
X-CSE-MsgGUID: Y0hKfn37SNCRWJx6jjKImg==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="73912776"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="73912776"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 23:24:08 -0700
X-CSE-ConnectionGUID: uKUMCG4TQ/e6DPyU9ZArlQ==
X-CSE-MsgGUID: oXvR0I9CTmW2FnPRjCHrVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="181196421"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 23:24:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 23:24:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 12 Oct 2025 23:24:06 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 23:24:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g74QiqZ4747AJk/tw+1I6h3rY+jaIpf6TbPY5GolNvur87SN6qoIsN0TrtrsrRTSs98M0yy0WMK7PahLE9zTjelyS2OB6rXVLO909wNDQHpN1uZ/WkQUxY6SV+wBGci3KgGXGnXkCTbGq+s8FbM+mASnFGaRuP+Sqelhjkt+XLa3eGLEcDLpnZXAB7e8PMIGyIaQfuTRlDf1FLsYyQurhPYbeuQiAvruaHJbsUg5X6AvDMAlnIIFBMtDeONHWDIzjcxXCjt+YDHMYnauGhxXcbe9zcqFoHiHSRuWU4M6Ndsm6jLv6ud+EWgNmMj7P8BTsZK8XiW5eWSqfeRtxvjIXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7U04ogsRMZ4To8CfOkxfSMDC+CaQ5H7yFlJUQQGX9Y=;
 b=qItx2TEW77VwzI9gUX7ml9MYyTSTwu9csfMuU5NCE7T4A5oEf+t5V/q/jCGh82nciY+Sa34y9vnCnR5fj91ThzNpwjCGwA1ZzCKcI+aJs/A50NQcGj/5zbee+emo6HVYQLnyBN+tnDNO+/GfbB5FazZVAyoYNbj/OVUIME1/Jdl6/vLz1By5KdBPdcORwud3ilCajrZSFZmPhDY1PHTqPecLubXIDT5x4bJczeXG+iS8PJ3Dt15ul39997E0M0u8l7Frf5e2RHZ1FY0fKVaTvvqqM0wS64D8t+OCZextxCYYG62yzSErTkIGArnq4dyL5WqSQ+ObIgGpbM02HOV1nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ2PR11MB7455.namprd11.prod.outlook.com (2603:10b6:a03:4cd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 06:24:03 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:24:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 05/22] hw/pci: Introduce pci_device_get_viommu_flags()
Thread-Topic: [PATCH v6 05/22] hw/pci: Introduce pci_device_get_viommu_flags()
Thread-Index: AQHcKHp7r9gkkae/lESTayfSQ/kwt7S+leyAgAEsiNA=
Date: Mon, 13 Oct 2025 06:24:03 +0000
Message-ID: <IA3PR11MB9136750D9409C68AA7B69C0B92EAA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-6-zhenzhong.duan@intel.com>
 <9e48f6fd-a945-4a40-9ec0-e852280108c9@intel.com>
In-Reply-To: <9e48f6fd-a945-4a40-9ec0-e852280108c9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ2PR11MB7455:EE_
x-ms-office365-filtering-correlation-id: 9bdd8e84-e410-4ab5-c64a-08de0a211afe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dWxabGJKV0tSeXZtemNiZjZ1bFNyUUZ3QnVTQW9nYjcwdktqWTExQ1RHUmlj?=
 =?utf-8?B?RXZ3Q1luRHFPa1BHcDk1R29FcVpNSFExQlFvdngxdmRyTytvQVVyT0FSbGRZ?=
 =?utf-8?B?UGZTcThmUkJucjhPMzc3MXp4TUR5emZnSWUzYmVIcHRnd0lqUW1LQ09mcnpR?=
 =?utf-8?B?d28zOFFzRDIwbW9uaFhNWU5YRVNZLzVrVHpWdnpTbUJpendqeE1QcXUxdkRF?=
 =?utf-8?B?Yi8rVUdlY3BWVGVPbnE2dWpja004cDMwMGI5bzFCWWVqZlBiZzZjeXM3azBh?=
 =?utf-8?B?NHBuSVBzWEZWYTdtYkw4QmpzQnppSTN5dlVnVVdzbnh3cTlOejZTdWtnNEd2?=
 =?utf-8?B?c3h3dDZNZVBuQ2Y0OVJ4N2wwNE9LRmRSclNWMTM2OU9ZS2lXZHZWVVBqT3dM?=
 =?utf-8?B?YXFDZW5rSFlDQ1VrdjRBYWtXaUVDSkNaV0hjVWFzNlpDRGNiRHdxQnhPUnIx?=
 =?utf-8?B?SVNoZVFoWlFrT3hjd3g5REc4VHhnTVp1eG1FdFh2ODEzcCtYOG9vZXZCWnBG?=
 =?utf-8?B?ZkdOWVpJbXFkU1ZtNEh5RnMrenpFeWp3WnlyY0VRUGU5MDZ3cFpDNWY2UVh2?=
 =?utf-8?B?T1pTSnRCUzRqcWtEd1YrTWg1bC8xUHhTVVltTkpPTEE4SFpGNUd0ekM1d3E3?=
 =?utf-8?B?V1pQMmdKNjVBR1B1dHh4MDNjM1ZsT0NlcWJOV3FSeFQrUnQycGJXb292Z2Nq?=
 =?utf-8?B?MXltUHh3RloycU1tNzV3V01NTFQyZEZxaHQ2RGpoMysxdjNOdGtYd2VyMUZY?=
 =?utf-8?B?QWorTk92ZUU3NkJhaHpOOWs0ZFR6ZlI5dUxpQ01JUXhqRG5HS1FnOXNlMHFh?=
 =?utf-8?B?V2I1aVJuS1U2ZFV6OHF1ZjkvTmFXZDUvTjczQ2ZaQ1g5ZUFNN1dNdjlyR2Iz?=
 =?utf-8?B?S1RzYWxwdmtuZGdvaVNDVU43VmhWZ3JDV2dBTEZpNTgrb3dxZ0o1OWNZdm1n?=
 =?utf-8?B?SENnQ0M5WHRVMGRvdVlJNy93SWVNalA0NGhneUZoS09PbFZ6cXZ3MHpSdnNx?=
 =?utf-8?B?bEhkdHkxTndCaFJvMXdLdmIrRE5SSzRueWNNWW9rZG0yNnBsMTQxVGFRS2ZY?=
 =?utf-8?B?cHNOc2cxd29KVWR2MDlkNmR3YXJOTkh5TzlrbEpFdENXRDlYdHB5TTNKc2tJ?=
 =?utf-8?B?QUk2L3JLTTFsVHZpekVFa09PcFIwTHQyWE45bFlDWG1zVFBDbHE5bGk5RFAv?=
 =?utf-8?B?dHBzb2J0ZkJET1FwNXh2TVkvdHQ5clBRT09iTVQwc2tNQzRuWGN3YWNrNHoz?=
 =?utf-8?B?VlQvb1hlcjdRQXhkY2hMMVAzMXFQQTIrTlUvbXQrNk5wS1NreHVRZ1JHR0Rk?=
 =?utf-8?B?cFNPTVplbzcyMEMxOFVxYk1SUjNQTmVyd3hsbHZJeURsbWRMaVZIMEpMZ3RI?=
 =?utf-8?B?d3lpNmZZT2llMlV5cWNHR1U3NVZ4bml3Q1l6cENnTGtld3B5R2lKU1dDWk5T?=
 =?utf-8?B?K2hDNllONDd4eUg3QVNoMEVQdTJvOERSODBvbHFrREtYTndleWRIR0ExTFM4?=
 =?utf-8?B?VVFZemx1UFNaaEEwQVNDbVJLMytIaklQd3hwT05rMWF1WXpieWQvMjAvd1BT?=
 =?utf-8?B?Z3JaNXNMNWFGZjcyZ1FIZy84RUZkWjlvTGsrSmZXR2RVZHRCbE9uYlNoQmxF?=
 =?utf-8?B?NStCNTNYZmFuRmFic1ZaU08wMkIwYnNzWWgyeFU0c21GcXQwaTF0QXdJL0Nl?=
 =?utf-8?B?RGFjVStjdWRoTkc4ZURCeU8xVUxka2RCUWNPQThUSGdvS09JRnZJSmdGYlZF?=
 =?utf-8?B?L0NmcFFPNVVCTkRURFl3cnpHTWlFQUxzMGx6aWtsSVIxbDVXdkY3Ym1GUVRX?=
 =?utf-8?B?Z1lhVWxmVjhUa0ZiZUpqK0k2bW85YVFSZG1LWkMwNjcwb3J4T04rdEIrM21M?=
 =?utf-8?B?OWFnRm5CNHJCOS9HaEhYalpsczIrY2F4eEFFVVkvaWJqL3NMTHZWVGlWRmpS?=
 =?utf-8?B?cllGb0IxbktVYUF0SUhVSWFZS29hTjU4djJNSldoV2V4Y0dxZlFmUDBobGJO?=
 =?utf-8?B?MjBDMC9WYm5UR1lQWnlpR0lOUXd3eFllQ3pmdE5sYmtIeFRTSHpuTHBWTU9x?=
 =?utf-8?Q?Hm+y6C?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0VZc0hONkR4NFlFb3hFQ04rNjQwanB3YXBXMHRYczBqdnNCV0NTTS9wa1hJ?=
 =?utf-8?B?ZHdoNXdJQXNpcklBOG01dkFjcm84RE5ER1RiK1Y5YjRmY0xPOVZ4cG5xRnN5?=
 =?utf-8?B?VTVNTk01b0w3MThjZG1ueW1WTlQ3MG9rckhMZFJoSHNqcnRWNjlNeThycUcy?=
 =?utf-8?B?cmFyWHZKZEZhd3R4YjZEem1ydTllNlpTT2UyRDNuU2cwN2plTHU4NDhTMWds?=
 =?utf-8?B?RW0zYXNZQlpMK1hIc3FDVWlXUjRRS2lWNDRLSDBJNXJROXA2b0tsZEw1R2Nr?=
 =?utf-8?B?YVY3MFBMUXBBQldHOVJDektyejA5bHJHSWxKcEc3MlVTZ010eVBPTFRvbWdJ?=
 =?utf-8?B?UjI2THdiZ1pPVk9qSDczNGhGRk5SSmNJRnZwYlNiOFhLNnF5QXBYblFleElY?=
 =?utf-8?B?ejlnUnA2bE9IL1R1V2FMaXNEV2pvNmhYb3hmaXFpVE5Da0Z1S3d1RTZnN0xN?=
 =?utf-8?B?UXZQZHVHcHovczdCWkk2UGpHSlk5UmNZQWhDRG4xdXhXY2dPS3l5YkllUnVW?=
 =?utf-8?B?UTlyTGFFTXZGckNTSVI1bEhkSUphMjBLMnlUSzdZci9ObmdBY2p0WXh1NUpm?=
 =?utf-8?B?R251d0pKblE4cW5palVWR2FFUnRoVDVpQ2hiY0FwYnlXTk0veklCTHlaajFF?=
 =?utf-8?B?c0VrcGxvWjNPSmhtY28ydmlUd1pCRm80K0NMK1JRcHQrakdtdnRZenZoci9U?=
 =?utf-8?B?ckYyV3dRU2lEQnJhV1VwN2RMSVJuL3lDbUMwUXBGUTlaZFlBaGl1d0NQRVBQ?=
 =?utf-8?B?VzVxL2NaV254ZzRxU0h3ODRjQlJwR0lYR2NYaThka2dPSi9WUUIzdUZLWFJn?=
 =?utf-8?B?T2VHOWJITlVLRWcrN0F0UHd6cUxRc0VmaGZkRVpGTEFzRlRRa2JwM054S3kr?=
 =?utf-8?B?ckNMWG9tMFUvQVAxQUVzOGpCdHdWZlVVMCtHa2RyQ1ZtQ0lVSnpsL3FRTEd0?=
 =?utf-8?B?YjhuR3o1Rkt0bHV5aDFaNG9IbHhyZnBBZkt3OTA2bHZBZlRGRkVtejI3TUIr?=
 =?utf-8?B?OUJ2ais5eXVRNDlaKzFTQjdXY2J2eUhFaDdFdzA1b2ZYb2JndWo0VFVOMS9J?=
 =?utf-8?B?TGVCYXl3aks3TEdhbDFNQUZXbGVseGJseExqaHRBVGQrTUZUUWNjUEZoQ2tG?=
 =?utf-8?B?M1QvYXZqMmZjaDFwd0lDOURMWFRWMWZMRTNKR1VId0o3R1NzclJRZEpuOWc1?=
 =?utf-8?B?ZHdlc2F5TCsyT1AvK2tUd205dHI4T3hGK1NHUmNmQXA4aXBscTMvcDY5djhp?=
 =?utf-8?B?MlBrQi9MbmNSbHVpdlhaWjJHOGlwZFZaUXNJSWwvRGZDcDN1L1JTelo2c0ZS?=
 =?utf-8?B?T3JyY1R0TVVBQVRkSGwxdVF6ZGFvbXJLUUxSbEkyNERic1RJL2l3c2RYaTRU?=
 =?utf-8?B?K2V3Z0VzbWJ5WEhQQklMd3F4SlNsR3NTRmo0NFRmVjNpV1JFaS94c1Z6T0Qz?=
 =?utf-8?B?RFpMYTMzRjNEL1hyKzM0ZnNuakQ2L09DMnBscW41YjFRb0RqelAwQnZ6VFN0?=
 =?utf-8?B?WU50YVF2V3pwbzh3eUJlTWx2bDJtMnNKbDVJMDJJbXBma1FVclhrWU9NelM2?=
 =?utf-8?B?ZCs5cWtScCs3cGNNd3lIeGpSYlRicjNoVjRSUzR3c2gxK2lYU0VhK2VnMy9q?=
 =?utf-8?B?czFsMzR0ek5FZ1lSRU05QzRkUzdFQjZueDhuclNoSk54K281V2xJNm1PdUs1?=
 =?utf-8?B?cUtTUkRLcWpNenJsdkl6Qit4cmZHK0hnMDV3bkxYbkxiQUhXK3dtNTZKWFhs?=
 =?utf-8?B?aTFOSDVSVzBCajJVNllrL0VvY1JoSXMxY2Z5SzYxY1hNUXVrN1ozcUlpMk5F?=
 =?utf-8?B?WlRCWjVIenl3dEJsNEx6cWtJcmFOK1JLSzVpanZHN1NydWRjL1Z6dlQyc0FU?=
 =?utf-8?B?T1MrSnJiYTVYeGp4RER3a2E5aVhibUM5YWQ5SkdEYlhST1RESU9mdVgyRVd4?=
 =?utf-8?B?RHFTNXpyakhlMDhoaFhYRGF4MnRJVzZ6SzdCRlBrK1ZOVjdvK0NjcTR5czEr?=
 =?utf-8?B?T2s4OXFtUlJkN1BMSTdDem9lRUNLdzVaSjlCRlhuTDhOdEN3aEpYRVZVZTlL?=
 =?utf-8?B?QUxsK1pZaXdpcnhQVWVlNWY5bDV4U0RXVjdrb2VwTVhDdzZuWGhhWitmM3Er?=
 =?utf-8?Q?exi1OV13JUpXNKLBTPxkY+uei?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bdd8e84-e410-4ab5-c64a-08de0a211afe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 06:24:03.6097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fcK4viknJJOXBm/vPDpr1yleGFhbrNV58OPbGbeNBKfnpVKQNf4vp4GFJxEWZ79KlpAu6q4CiBENBCid2vHW8/gdIxGohGCOcRwdNr/7oQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7455
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDUvMjJdIGh3L3BjaTogSW50
cm9kdWNlDQo+cGNpX2RldmljZV9nZXRfdmlvbW11X2ZsYWdzKCkNCj4NCj5PbiAyMDI1LzkvMTgg
MTY6NTcsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSW50cm9kdWNlIGEgbmV3IFBDSUlPTU1V
T3BzIG9wdGlvbmFsIGNhbGxiYWNrLCBnZXRfdmlvbW11X2ZsYWdzKCkNCj53aGljaA0KPj4gYWxs
b3dzIHRvIHJldHJpZXZlIGZsYWdzIGV4cG9zZWQgYnkgYSB2SU9NTVUuIFRoZSBmaXJzdCBwbGFu
bmVkIHZJT01NVQ0KPj4gZGV2aWNlIGZsYWcgaXMgVklPTU1VX0ZMQUdfV0FOVF9ORVNUSU5HX1BB
UkVOVCB0aGF0IGFkdmVydGlzZXMgdGhlDQo+PiBzdXBwb3J0IG9mIEhXIG5lc3RlZCBzdGFnZSB0
cmFuc2xhdGlvbiBzY2hlbWUgYW5kIHdhbnRzIG90aGVyIHN1Yi1zeXN0ZW0NCj4+IGxpa2UgVkZJ
TydzIGNvb3BlcmF0aW9uIHRvIGNyZWF0ZSBuZXN0aW5nIHBhcmVudCBIV1BULg0KPj4NCj4+IHBj
aV9kZXZpY2VfZ2V0X3Zpb21tdV9mbGFncygpIGlzIGEgd3JhcHBlciB0aGF0IGNhbiBiZSBjYWxs
ZWQgb24gYSBQQ0kNCj4+IGRldmljZSBwb3RlbnRpYWxseSBwcm90ZWN0ZWQgYnkgYSB2SU9NTVUu
DQo+Pg0KPj4gZ2V0X3Zpb21tdV9mbGFncygpIGlzIGRlc2lnbmVkIHRvIHJldHVybiA2NGJpdCBi
aXRtYXAgb2YgcHVyZWx5IHZJT01NVQ0KPj4gZmxhZ3Mgd2hpY2ggYXJlIG9ubHkgZGV0ZXJtaW5l
ZCBieSB1c2VyJ3MgY29uZmlndXJhdGlvbiwgbm8gaG9zdA0KPj4gY2FwYWJpbGl0aWVzIGludm9s
dmVkLiBSZWFzb25zIGFyZToNCj4+DQo+PiAxLiBob3N0IG1heSBoYXMgaGV0ZXJvZ2VuZW91cyBJ
T01NVXMsIGVhY2ggd2l0aCBkaWZmZXJlbnQgY2FwYWJpbGl0aWVzDQo+PiAyLiB0aGlzIGlzIG1p
Z3JhdGlvbiBmcmllbmRseSwgcmV0dXJuIHZhbHVlIGlzIGNvbnNpc3RlbnQgYmV0d2VlbiBzb3Vy
Y2UNCj4+ICAgICBhbmQgdGFyZ2V0Lg0KPj4gMy4gaG9zdCBJT01NVSBjYXBhYmlsaXRpZXMgYXJl
IHBhc3NlZCB0byB2SU9NTVUgdGhyb3VnaA0KPnNldF9pb21tdV9kZXZpY2UoKQ0KPj4gICAgIGlu
dGVyZmFjZSB3aGljaCBoYXZlIHRvIGJlIGFmdGVyIGF0dGFjaF9kZXZpY2UoKSwgd2hlbg0KPmdl
dF92aW9tbXVfZmxhZ3MoKQ0KPj4gICAgIGlzIGNhbGxlZCBpbiBhdHRhY2hfZGV2aWNlKCksIHRo
ZXJlIGlzIG5vIHdheSBmb3IgdklPTU1VIHRvIGdldCBob3N0DQo+PiAgICAgSU9NTVUgY2FwYWJp
bGl0aWVzIHlldCwgc28gb25seSBwdXJlIHZJT01NVSBmbGFncyBjYW4gYmUgcmV0dXJuZWQuDQo+
PiAgICAgU2VlIGJlbG93IHNlcXVlbmNlOg0KPj4NCj4+ICAgICAgIHZmaW9fZGV2aWNlX2F0dGFj
aCgpOg0KPj4gICAgICAgICAgIGlvbW11ZmRfY2Rldl9hdHRhY2goKToNCj4+ICAgICAgICAgICAg
ICAgcGNpX2RldmljZV9nZXRfdmlvbW11X2ZsYWdzKCkgZm9yIEhXIG5lc3RpbmcgY2FwDQo+PiAg
ICAgICAgICAgICAgIGNyZWF0ZSBhIG5lc3RpbmcgcGFyZW50IEhXUFQNCj4+ICAgICAgICAgICAg
ICAgYXR0YWNoIGRldmljZSB0byB0aGUgSFdQVA0KPj4gICAgICAgICAgICAgICB2ZmlvX2Rldmlj
ZV9oaW9kX2NyZWF0ZV9hbmRfcmVhbGl6ZSgpIGNyZWF0aW5nIGhpb2QNCj4+ICAgICAgIC4uLg0K
Pj4gICAgICAgcGNpX2RldmljZV9zZXRfaW9tbXVfZGV2aWNlKGhpb2QpDQo+Pg0KPj4gU3VnZ2Vz
dGVkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpo
ZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgTUFJ
TlRBSU5FUlMgICAgICAgICAgfCAgMSArDQo+PiAgIGluY2x1ZGUvaHcvaW9tbXUuaCAgIHwgMTkg
KysrKysrKysrKysrKysrKysrKw0KPj4gICBpbmNsdWRlL2h3L3BjaS9wY2kuaCB8IDI3ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBody9wY2kvcGNpLmMgICAgICAgICB8IDExICsr
KysrKysrKysrDQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKQ0KPj4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9ody9pb21tdS5oDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4+IGluZGV4IGY4Y2Q1MTNkOGIuLjcxNDU3ZTRj
ZGUgMTAwNjQ0DQo+PiAtLS0gYS9NQUlOVEFJTkVSUw0KPj4gKysrIGIvTUFJTlRBSU5FUlMNCj4+
IEBAIC0yMzA3LDYgKzIzMDcsNyBAQCBGOiBpbmNsdWRlL3N5c3RlbS9pb21tdWZkLmgNCj4+ICAg
RjogYmFja2VuZHMvaG9zdF9pb21tdV9kZXZpY2UuYw0KPj4gICBGOiBpbmNsdWRlL3N5c3RlbS9o
b3N0X2lvbW11X2RldmljZS5oDQo+PiAgIEY6IGluY2x1ZGUvcWVtdS9jaGFyZGV2X29wZW4uaA0K
Pj4gK0Y6IGluY2x1ZGUvaHcvaW9tbXUuaA0KPj4gICBGOiB1dGlsL2NoYXJkZXZfb3Blbi5jDQo+
PiAgIEY6IGRvY3MvZGV2ZWwvdmZpby1pb21tdWZkLnJzdA0KPj4NCj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2h3L2lvbW11LmggYi9pbmNsdWRlL2h3L2lvbW11LmgNCj4+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwLi42NWQ2NTI5NTBhDQo+PiAtLS0gL2Rldi9udWxs
DQo+PiArKysgYi9pbmNsdWRlL2h3L2lvbW11LmgNCj4+IEBAIC0wLDAgKzEsMTkgQEANCj4+ICsv
Kg0KPj4gKyAqIEdlbmVyYWwgdklPTU1VIGZsYWdzDQo+PiArICoNCj4+ICsgKiBDb3B5cmlnaHQg
KEMpIDIwMjUgSW50ZWwgQ29ycG9yYXRpb24uDQo+PiArICoNCj4+ICsgKiBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPj4gKyAqLw0KPj4gKw0KPj4gKyNpZm5kZWYg
SFdfSU9NTVVfSA0KPj4gKyNkZWZpbmUgSFdfSU9NTVVfSA0KPj4gKw0KPj4gKyNpbmNsdWRlICJx
ZW11L2JpdG9wcy5oIg0KPj4gKw0KPj4gK2VudW0gew0KPj4gKyAgICAvKiBOZXN0aW5nIHBhcmVu
dCBIV1BUIHdpbGwgYmUgcmV1c2VkIGJ5IHZJT01NVSB0byBjcmVhdGUgbmVzdGVkDQo+SFdQVCAq
Lw0KPg0KPnZJT01NVSBuZWVkcyBuZXN0aW5nIHBhcmVudCBIV1BUIHRvIGNyZWF0ZSBuZXN0ZWQg
SFdQVA0KDQpXaWxsIGRvLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

