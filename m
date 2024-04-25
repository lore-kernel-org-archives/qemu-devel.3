Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57154C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 08:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzukZ-0006uj-65; Thu, 25 Apr 2024 04:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rzukU-0006tr-Ow
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 04:46:34 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rzukS-0003G7-Aa
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 04:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714034792; x=1745570792;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6J2ITdT9lLmyInYC+AkvpgBk6eMlGu6AT5v6Z5/lliY=;
 b=RepCYedTLJ/ZC6TzgsjKKo2QxWT+EU5xY67Hgmk4HaKaLQ4g8HvwVSET
 TmRxsQhXlkp0tG16UK2HxdKRprZBSIADc9Y6LxZZsG3rMqwpVib8vNLKf
 aq+wRvVlSxiSOoXYupTbwtOMbzPax7Vws7GIRPHlwi13XKcBgvweVak1V
 mq/bTqpDI8dgtwue5JMVetKDP6oJHjKf9h4aq/MJHX48Xu9AOMaFeYDHW
 h8lgBiSv3nK0cuXb9LidmyMZrYTBzzWIEIebI73//N2RllMDNIVAXqP5u
 qPx1y8X+Jvlmo1XFBibSNrfAH3sUbXFBPcTGscIihSoWPaz1T44B+R8nT Q==;
X-CSE-ConnectionGUID: ewLI0h2WQfKB61j7kGYYhg==
X-CSE-MsgGUID: vbmzIrrdQdKwfq7p6U+1Dg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9571441"
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; 
   d="scan'208";a="9571441"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Apr 2024 01:46:27 -0700
X-CSE-ConnectionGUID: AaUYiXpaTmeWCdW1G33+Sw==
X-CSE-MsgGUID: NhYZ93qCSsqtssz6MWVOOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,228,1708416000"; d="scan'208";a="29631315"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 25 Apr 2024 01:46:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 01:46:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Apr 2024 01:46:26 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 01:46:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxR1iqTT92q87wxm/G7o4IsoY7dtv/I+9uZMeEvU32G4yswMw26OicoLTAclzlHHR+nJfy/EVJM08VB003QbEjGRHFJ1u+PEaNgPuS6OmUHU5AtNJxYQGaFZeTQthNGgGBDHwdXOcUAXvFwL2ebuQAO+exhHYduA/Xf26ORFYUycGduzVTv5HizvQ0mpOWIqrMHKw26cCt9MahRHYcvYES6nae+/4JlUAEi58hi/s50r6O0wcaXTg8HVnbhZQYTGRHLsNUv/V7mprVSm4Y8vhC41t4+q2LB9oeeQaC9hsnf2wnKzGkKnUwxdVv3XludOJ3hCr7M1BtenI9lOjpSDsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6J2ITdT9lLmyInYC+AkvpgBk6eMlGu6AT5v6Z5/lliY=;
 b=cY1h0GLjdn6tr1VKOzSZIDXWt9LC0KCG0UgECL63aN/Zh5OgfdoEZs7Afb0JH5igh7lInKyxrqlY6Eo05OfBBR3AamD5w5cZcylDFgOX1uWMwo4Qe/CyY+xdVVd0JSy1u3XtDR0O0zqzUVirxtGGgvazvXK5ljKO8Y5iSeTVkZOzEtwtilpCkyLHLox/u18OPM0cEN7AYepuE1f8OowBlYsGHI8ldpQxPADtt2tlP1T+00CvjPRNNKAuLdAM5Oecsglp2ox6fBlD9wJDR+vxowyPoyGG/WJGYNMabrMA4+TVBRsO1FHfSQx2M/bquUYDBmzgnxTXs2/rv6dF7+POjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB8343.namprd11.prod.outlook.com (2603:10b6:610:180::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 08:46:19 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 08:46:19 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH v2 3/5] intel_iommu: Add a framework to do compatibility
 check with host IOMMU cap/ecap
Thread-Topic: [PATCH v2 3/5] intel_iommu: Add a framework to do compatibility
 check with host IOMMU cap/ecap
Thread-Index: AQHaiZFH29IOEDl1dk20/jsEyJLG5bFpgLMAgAD2WaCAAIdgAIAA3yKQgABSSQCAAAwBsIABaDUAgAAWTwCAAXXYgIAJkTXA
Date: Thu, 25 Apr 2024 08:46:19 +0000
Message-ID: <SJ0PR11MB6744C9A7EB6DF3413BD4CDE592172@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240408084404.1111628-1-zhenzhong.duan@intel.com>
 <20240408084404.1111628-4-zhenzhong.duan@intel.com>
 <251715ae-5378-4dfb-bc14-47ba2e62f83a@redhat.com>
 <SJ0PR11MB67443BF6BC7CABCE28F482A392082@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <5eb6c665-df8f-4c5e-8426-4678d8433a0c@redhat.com>
 <SJ0PR11MB6744F7A99B9303C8A3699EE9920F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <b67b6ba8-b506-4865-9ab0-e9107cd5b12a@redhat.com>
 <SJ0PR11MB67442AA733CF06B144D33934920F2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <afac1b03-11ea-4bb9-ab79-92cff2c0ea20@redhat.com>
 <SJ0PR11MB6744455DBE4D52AF635403C1920E2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <6d607d16-fe5e-4be2-bea3-f286c78ada53@redhat.com>
In-Reply-To: <6d607d16-fe5e-4be2-bea3-f286c78ada53@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH3PR11MB8343:EE_
x-ms-office365-filtering-correlation-id: 7d4b998e-143a-4fa5-614f-08dc65042d3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|366007|376005|7416005|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?NmoyQkpmK3F0UmNSNDlXUnBqQTVBazI2Nk42MnErdVdkbDJpNzhqKzBjWWNs?=
 =?utf-8?B?cjdqdmxsZXhSYW9qNE5HYXA2R2g5VE4xSkplQzdlNGU0blpuaUdabUtIWVl4?=
 =?utf-8?B?OGJpSEpXRkg4cWwrK3JmdVlmNnA2WXEzUFFIVnhaRTZ3MmdvaHozQXBacmVB?=
 =?utf-8?B?MFY4enR0Wmg2cVJvWlcvSFdKMUtuRDhpTmFTd0p0YzdrNHA1Z3hRcHBrVUdH?=
 =?utf-8?B?eUg5MU9wOUp6NHVTVFkrcDVkOVYzdE9veWNBTi9tOWd2bW1odmhoWENuczIz?=
 =?utf-8?B?a2dNbUcxSElta21sL2ZjNnlvZVUwSXFnVWtVNGlDYVdQR3FISWQ2MUsrcUVQ?=
 =?utf-8?B?dFBqSEszaFdtM0hiYUdGWG1odHg4RENkazgya0NydVdtT212eDFmR1oyMG52?=
 =?utf-8?B?UmM1Q2dMQkdiZC9mOC9zdFdpMDM5ZkcyYXkzMWdKTEUwZjIyYWx6WVJTbHZI?=
 =?utf-8?B?ZVYxQ2V1WmgwUFNaOU9NUUJGRUlSR1BGK3dxNmxhT1ZJOXk0Z3psaTN3TjQ2?=
 =?utf-8?B?R0svNnhmamRBNVRkMXRSa29iVm1yZk1DaVM2cFkrYkNBZ3RkazNybkdLUnh4?=
 =?utf-8?B?WlhzN3ViUUpzVFNBU0RrejRlWERISGVETk1tS002Wm1FNURmSjBBc1kzWHhY?=
 =?utf-8?B?S0N6VnhwNEFwRzFmTXhrR0NFczBmRGs4Y1BxVWJ6QlBoYndNcVJyQXkxcEc4?=
 =?utf-8?B?dXUvOE5KMEk3d3FFaFJvQTRjUjFHR05MWGZPYkcvMy9FeE44NDBkZXJ2VEp6?=
 =?utf-8?B?ZFNzcFVCY3dTQVE2UStjMzM2SGtyWDJqaXRRemFXQjNRcTNKUDk2QUNwUXR6?=
 =?utf-8?B?RVQydW9FYWpLTGhTb0wzRlR1TkpDZDJBK05RM0M5Nlg0YU1rSzM3UTgxMHNS?=
 =?utf-8?B?ZWlEQ2pQSkowK04vL1Z2VGVMUFJmNUE3SG53VEg1Z25RenlCNnREbWtHcTQy?=
 =?utf-8?B?eHFGVmRmcnBRdm9EbVZtbW5yY0krOVl5UDJQL2R6cnp6WkJMQnorRWJkWWFN?=
 =?utf-8?B?YlkreEpyUzZSUmdZaTkwenRkd0lMeSsyTm5Xa091ME9LNEdQV1VmQzNuUnlJ?=
 =?utf-8?B?RWtXTlNub2pINm1Fem5xWDNrQ0dDNXp5SWVzTUFkWTFGTHlNamlnQUwvR0U3?=
 =?utf-8?B?NWZpUmJYeXZoR1UweStidlBSWkRoakgrOFNiSkdESk5wZG11dlI3ZmZZUkxZ?=
 =?utf-8?B?eDJIR1dTQkxWa1Bza3pMdVVMTFBYMTRvdWxrcVZtblNBQ281UUNHdzE5Wmc5?=
 =?utf-8?B?OFgyYm8zenJhV08yTEdOcXdwRTBCVk5HZk85UDh6d0IyK2hFZVBhSDQ4dlRz?=
 =?utf-8?B?TWw0REZ4UWdRRWFSSTlFd1lvZ0hFUjdUaW5nTzVYM2g4WWNTU3NlRnNGc3Bs?=
 =?utf-8?B?UWJvejRCNzhybWplRlRIeGpyQ0VwSDU3VHJ0S1hxVXZZR2N3RThlckgvL0lI?=
 =?utf-8?B?R1Q3R2lMY3NoMVV0Q25GY2RoaDNxaXFtSjNjdGlqdmpRRGtvN3dTT3hWTklQ?=
 =?utf-8?B?TjZhcmRDaVJtM2w1eTlTUnMwa3BzZENCM3RoaXRqZlNaTEx0cDhIWU5UUXAv?=
 =?utf-8?B?T1Z4ZFI0TklCZUFKYkp1N1lnRlFUV3V0UzNaYnJwNVp5WVJnMXgyb0RubUFB?=
 =?utf-8?B?QzVNcnhqMDhnWmU4cVNDalJLV0xjNG5XMnIzUWtFVWNjNU92Ukt4aVQrNU5x?=
 =?utf-8?B?bjBWUG5FcWlGdDIwSUFMcjBhdXpJUmF2YVpPS3hZa3ZFNDR2anAzU3J3WGk5?=
 =?utf-8?B?amhMWS9iMFZBcEk3elE3elBMemF6U3ExL2xzNE1VSDFUUi9WTmN1YVlNMDNO?=
 =?utf-8?B?bHVsSEdiOTdzSEpONmJZZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGxXcmFCZitXSnZQQ3VUeXN0NCtVU3BnRVhXR2hSTC9EUHhvcUpBVGhtQllt?=
 =?utf-8?B?V2FyZ2UzbEo3cjhGTnVybE5Rd0RhRjdSc1pJa0JKSXdNQ3lwMURYNmtzYmdM?=
 =?utf-8?B?LzEybmM2eTNNM2k2TDAydERVYWRqUDJpcklvN0RWc0xpemZManFSRXVZbURu?=
 =?utf-8?B?QjhEOXBCbm9MVE1GQUhzbVU5bzZhNWh2UkVOWGZOemZ4eVJIc1hZeDU5SEd4?=
 =?utf-8?B?MFFKTHRoRjhtV21DVC83ZWFGN2liNTdUZVdhNVR2OGtqYUxsYUJGdXVWSDBF?=
 =?utf-8?B?MS9qRjVjeDQ4NGNIK0lxR2VyaUNaWjRNTXJoTURtbzg0ZWRpR2I3eWpnZmNo?=
 =?utf-8?B?c0ZSVCtmWENSVTJRem1JbS8vYkNJVno5MVVXYXd3V01BakVIOU96dUZ2ZnRq?=
 =?utf-8?B?UUVhRm4xd3hXRXNWWTdiSGFtNlBFUHZkd0NFNjVPSjdiMjA4cWY3N1hkZEY4?=
 =?utf-8?B?cHJMY2NYYTYxWG54OHpZU2hhWFR3ZzhZWjVYbEtJbGU4TVpkdmJTQ2svbUhn?=
 =?utf-8?B?U0hxM2F3cFEvQnQ0bnFlVXc0a1dFeXY1WlBwUlJ6bmZpdWdOeEhobytBOVk1?=
 =?utf-8?B?ZWRKQk1iQVdpS2dLVUxSYndxOXpxY1pUV2xUcFp2UytpU2ZPZ2FvOG00MjNn?=
 =?utf-8?B?a3ZMV0VxK3N5a2h1ZStiWVdlVW42eUkydHZPcWFpY2NtaVJobVpvWXh0bUVa?=
 =?utf-8?B?S0lqaXN1aFhJZzJiTFVWSERQam8yVS9SZnBTc3VhbkMzb2JBNUM4aERkUmdu?=
 =?utf-8?B?MUFmcGFwckJyVWgvNjdXcGFPR0xyclJwZW9WT2ZJSVREVGh6ZHRBQ1RTU1Zn?=
 =?utf-8?B?T0NOSkNmS0FnNTRuY3pwbGlldTlYcjd1czU4eFc5REhMOEZKcnlJcmJtTFlV?=
 =?utf-8?B?cEtGTm5wT0ZsZktRSDM5TjRWNy9JY0gzNVFnNU9DeDhLYWl0OHVnMGUrUlNk?=
 =?utf-8?B?c0xmVTJ6cUFOSHVRdU91VkkxZjRYNWhQa2JUaHduYlRtclh6Mzh6V3NzRUVn?=
 =?utf-8?B?TTlsUjdsTjFsSmx0UzhTd25FR29xU0JtblZRYlA4R2M2ZWNzM1VVSmZpMGhs?=
 =?utf-8?B?VHBpcDVNRHdDZHFQWlJjSVdHK1lXZTE1VHlhc2xkYTNQemRpRnZxTSt2bDVQ?=
 =?utf-8?B?MW81Q24zVndTVUxZbnlhMTlKZHo3UEdkQnJCVDdxdWc4ZlhoMUEvVEpWS1BS?=
 =?utf-8?B?eVFoeE4zcUdwT1BQOFFjK3dKeEJzWmVWeCtKNElLQXJ3T2k1eWQxWXdINkcr?=
 =?utf-8?B?TnBDaTI4VnlJVkNYUmhLemczS2ZvWk9RVUZzSXBpMEpPMDRJWTZzaDAyV0ZW?=
 =?utf-8?B?ZGRxcjloYXRmOWl1Rkt5YXpMeWlGQ0dDc1FPckluN3RKYjg3dkhQMUtHTEJo?=
 =?utf-8?B?RjB1VmczcjRQeUhqU2FYalA1Z2NPeU40OGUyY0Y0WFVaK1ZCTy9nMkhqZEFM?=
 =?utf-8?B?WUhWRCttK2ZJT2VhSDhzT1RFaGlpVU5YK0tPZm9nSVZKR2dIZk1IZCs5RlBW?=
 =?utf-8?B?Ny9GOUh0Vlhib2RQYmtQUjNaSk1XNUYrN3lxVFNzM2g1L1E3NUtSNy9EckpW?=
 =?utf-8?B?aGJPWDlUdUV1L0ROTm1KWndtb2p2QW5KV2pMR1FSRm9FbDJkRWl3aXIrUjF6?=
 =?utf-8?B?VXNUYk9JRjh5WW9CUG1mY1E2Nm9uWTFnV0JrbTU0ZjR5UyttYXl2RnlXQ01y?=
 =?utf-8?B?MnpkbE44NFpGenkxeGo1Z0lLSGtUYUQrZzlEOE11dmJmQTVFQjZYN0E2aUNV?=
 =?utf-8?B?T1BLbndhNnpIS3RVVjhFdmlLNTliN2NvZHNlSmpzYzRxcnRrd1VEQXJxV3NN?=
 =?utf-8?B?M2hFTkVFUkxPU3RmOVVkRFozMFczSWlpVlRuZDcvUHNVZ0NxVHc2TG5VTitp?=
 =?utf-8?B?dFh2UmRTaWZoYzhteXhqbEJ4RUxtT25IdVc4MW5aajV3R3dETzQ2UkducVg3?=
 =?utf-8?B?WkxlQWlHSTBhanBPb3Nad0d2ZVJVbUsxMzIrWTZCaUNlbTRjUXczZmFzUEho?=
 =?utf-8?B?UGVSZ1h1UnVjM1QwOUowcnh1TlB0YzFkUStYWEVlbWRQN085R3p1c1BacjdO?=
 =?utf-8?B?U2RndDdmYzNKWnhJOGhsOFd5cFVuTlpvVmFDVU9iajQ5WEl4MnFxTXg2SXZj?=
 =?utf-8?Q?nlv/+w5EEEfxVMsGKTuudvKsD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4b998e-143a-4fa5-614f-08dc65042d3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 08:46:19.2818 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TnIFX3akSWCWZM2Td7V/zZQuoKY0rGBJok7ZfHG9/D9XzUjlioXXo44kNtVsWbMgi5OWFserZYzUz9+VfX5moB2qLv5+aYxv+WACCgdE7bU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8343
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.668,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMy81
XSBpbnRlbF9pb21tdTogQWRkIGEgZnJhbWV3b3JrIHRvIGRvDQo+Y29tcGF0aWJpbGl0eSBjaGVj
ayB3aXRoIGhvc3QgSU9NTVUgY2FwL2VjYXANCj4NCj5IZWxsbyBaaGVuemhvbmcsDQo+DQo+T24g
NC8xOC8yNCAxMDo0MiwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gSGkgQ8OpZHJpYywNCj4+
DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBDw6lkcmljIExlIEdv
YXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzVdIGlu
dGVsX2lvbW11OiBBZGQgYSBmcmFtZXdvcmsgdG8gZG8NCj4+PiBjb21wYXRpYmlsaXR5IGNoZWNr
IHdpdGggaG9zdCBJT01NVSBjYXAvZWNhcA0KPj4+DQo+Pj4gSGVsbG8gWmhlbnpob25nDQo+Pj4N
Cj4+PiBPbiA0LzE3LzI0IDExOjI0LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4+DQo+Pj4+
DQo+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+Pj4gRnJvbTogQ8OpZHJpYyBM
ZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAz
LzVdIGludGVsX2lvbW11OiBBZGQgYSBmcmFtZXdvcmsgdG8gZG8NCj4+Pj4+IGNvbXBhdGliaWxp
dHkgY2hlY2sgd2l0aCBob3N0IElPTU1VIGNhcC9lY2FwDQo+Pj4+Pg0KPj4+Pj4gT24gNC8xNy8y
NCAwNjoyMSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+Pj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+Pj4+Pj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDMvNV0g
aW50ZWxfaW9tbXU6IEFkZCBhIGZyYW1ld29yayB0byBkbw0KPj4+Pj4+PiBjb21wYXRpYmlsaXR5
IGNoZWNrIHdpdGggaG9zdCBJT01NVSBjYXAvZWNhcA0KPj4+Pj4+Pg0KPj4+Pj4+PiBIZWxsbywN
Cj4+Pj4+Pj4NCj4+Pj4+Pj4gT24gNC8xNi8yNCAwOTowOSwgRHVhbiwgWmhlbnpob25nIHdyb3Rl
Og0KPj4+Pj4+Pj4gSGkgQ8OpZHJpYywNCj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4+Pj4+Pj4+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJl
ZGhhdC5jb20+DQo+Pj4+Pj4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzVdIGludGVsX2lv
bW11OiBBZGQgYSBmcmFtZXdvcmsgdG8gZG8NCj4+Pj4+Pj4+PiBjb21wYXRpYmlsaXR5IGNoZWNr
IHdpdGggaG9zdCBJT01NVSBjYXAvZWNhcA0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gT24gNC84LzI0
IDEwOjQ0LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4+Pj4+Pj4gRnJvbTogWWkgTGl1IDx5
aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+IElmIGNoZWNrIGZhaWxz
LCB0aGUgaG9zdCBzaWRlIGRldmljZShlaXRoZXIgdmZpbyBvciB2ZHBhIGRldmljZSkNCj5zaG91
bGQNCj4+Pj4+IG5vdA0KPj4+Pj4+Pj4+PiBiZSBwYXNzZWQgdG8gZ3Vlc3QuDQo+Pj4+Pj4+Pj4+
DQo+Pj4+Pj4+Pj4+IEltcGxlbWVudGF0aW9uIGRldGFpbHMgZm9yIGRpZmZlcmVudCBiYWNrZW5k
cyB3aWxsIGJlIGluDQo+Zm9sbG93aW5nDQo+Pj4+Pj4+IHBhdGNoZXMuDQo+Pj4+Pj4+Pj4+DQo+
Pj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+
Pj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4N
Cj4+Pj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFu
QGludGVsLmNvbT4NCj4+Pj4+Pj4+Pj4gLS0tDQo+Pj4+Pj4+Pj4+ICAgICAgIGh3L2kzODYvaW50
ZWxfaW9tbXUuYyB8IDM1DQo+Pj4+Pj4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4+Pj4+Pj4+Pj4gICAgICAgMSBmaWxlIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKykN
Cj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUu
YyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+Pj4+Pj4+PiBpbmRleCA0Zjg0ZTJlODAxLi5h
NDliNTg3YzczIDEwMDY0NA0KPj4+Pj4+Pj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMN
Cj4+Pj4+Pj4+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+Pj4+Pj4+IEBAIC0z
NSw2ICszNSw3IEBADQo+Pj4+Pj4+Pj4+ICAgICAgICNpbmNsdWRlICJzeXNlbXUva3ZtLmgiDQo+
Pj4+Pj4+Pj4+ICAgICAgICNpbmNsdWRlICJzeXNlbXUvZG1hLmgiDQo+Pj4+Pj4+Pj4+ICAgICAg
ICNpbmNsdWRlICJzeXNlbXUvc3lzZW11LmgiDQo+Pj4+Pj4+Pj4+ICsjaW5jbHVkZSAic3lzZW11
L2lvbW11ZmQuaCINCj4+Pj4+Pj4+Pj4gICAgICAgI2luY2x1ZGUgImh3L2kzODYvYXBpY19pbnRl
cm5hbC5oIg0KPj4+Pj4+Pj4+PiAgICAgICAjaW5jbHVkZSAia3ZtL2t2bV9pMzg2LmgiDQo+Pj4+
Pj4+Pj4+ICAgICAgICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIg0KPj4+Pj4+Pj4+PiBA
QCAtMzgxOSw2ICszODIwLDMyIEBAIFZUREFkZHJlc3NTcGFjZQ0KPj4+Pj4+Pj4+ICp2dGRfZmlu
ZF9hZGRfYXMoSW50ZWxJT01NVVN0YXRlICpzLCBQQ0lCdXMgKmJ1cywNCj4+Pj4+Pj4+Pj4gICAg
ICAgICAgIHJldHVybiB2dGRfZGV2X2FzOw0KPj4+Pj4+Pj4+PiAgICAgICB9DQo+Pj4+Pj4+Pj4+
DQo+Pj4+Pj4+Pj4+ICtzdGF0aWMgaW50IHZ0ZF9jaGVja19sZWdhY3lfaGRldihJbnRlbElPTU1V
U3RhdGUgKnMsDQo+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBI
b3N0SU9NTVVEZXZpY2UgKmhpb2QsDQo+Pj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBFcnJvciAqKmVycnApDQo+Pj4+Pj4+Pj4+ICt7DQo+Pj4+Pj4+Pj4+ICsgICAg
cmV0dXJuIDA7DQo+Pj4+Pj4+Pj4+ICt9DQo+Pj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+Pj4gK3N0YXRp
YyBpbnQgdnRkX2NoZWNrX2lvbW11ZmRfaGRldihJbnRlbElPTU1VU3RhdGUgKnMsDQo+Pj4+Pj4+
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSG9zdElPTU1VRGV2aWNlICpo
aW9kLA0KPj4+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9y
ICoqZXJycCkNCj4+Pj4+Pj4+Pj4gK3sNCj4+Pj4+Pj4+Pj4gKyAgICByZXR1cm4gMDsNCj4+Pj4+
Pj4+Pj4gK30NCj4+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+PiArc3RhdGljIGludCB2dGRfY2hlY2tf
aGRldihJbnRlbElPTU1VU3RhdGUgKnMsDQo+Pj4+Pj4+IFZUREhvc3RJT01NVURldmljZQ0KPj4+
Pj4+Pj4+ICp2dGRfaGRldiwNCj4+Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
RXJyb3IgKiplcnJwKQ0KPj4+Pj4+Pj4+PiArew0KPj4+Pj4+Pj4+PiArICAgIEhvc3RJT01NVURl
dmljZSAqaGlvZCA9IHZ0ZF9oZGV2LT5kZXY7DQo+Pj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+Pj4gKyAg
ICBpZiAob2JqZWN0X2R5bmFtaWNfY2FzdChPQkpFQ1QoaGlvZCksDQo+VFlQRV9ISU9EX0lPTU1V
RkQpKQ0KPj4+IHsNCj4+Pj4+Pj4+Pj4gKyAgICAgICAgcmV0dXJuIHZ0ZF9jaGVja19pb21tdWZk
X2hkZXYocywgaGlvZCwgZXJycCk7DQo+Pj4+Pj4+Pj4+ICsgICAgfQ0KPj4+Pj4+Pj4+PiArDQo+
Pj4+Pj4+Pj4+ICsgICAgcmV0dXJuIHZ0ZF9jaGVja19sZWdhY3lfaGRldihzLCBoaW9kLCBlcnJw
KTsNCj4+Pj4+Pj4+Pj4gK30NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gSSB0aGlu
ayB3ZSBzaG91bGQgYmUgdXNpbmcgdGhlIC5nZXRfaG9zdF9pb21tdV9pbmZvKCkgY2xhc3MNCj5o
YW5kbGVyDQo+Pj4+Pj4+Pj4gaW5zdGVhZC4gQ2FuIHdlIHJlZmFjdG9yIHRoZSBjb2RlIHNsaWdo
dGx5IHRvIGF2b2lkIHRoaXMgY2hlY2sgb24NCj4+Pj4+Pj4+PiB0aGUgdHlwZSA/DQo+Pj4+Pj4+
Pg0KPj4+Pj4+Pj4gVGhlcmUgaXMgc29tZSBkaWZmaWN1bHR5IGluaSBhdm9pZGluZyB0aGlzIGNo
ZWNrLCB0aGUgYmVoYXZpb3Igb2YNCj4+Pj4+Pj4gdnRkX2NoZWNrX2xlZ2FjeV9oZGV2DQo+Pj4+
Pj4+PiBhbmQgdnRkX2NoZWNrX2lvbW11ZmRfaGRldiBhcmUgZGlmZmVyZW50IGVzcGVjaWFsbHkg
YWZ0ZXINCj5uZXN0aW5nDQo+Pj4+Pj4+IHN1cHBvcnQgaW50cm9kdWNlZC4NCj4+Pj4+Pj4+IHZ0
ZF9jaGVja19pb21tdWZkX2hkZXYoKSBoYXMgbXVjaCB3aWRlciBjaGVjayBvdmVyIGNhcC9lY2Fw
DQo+Yml0cw0KPj4+Pj4+PiBiZXNpZGVzIGF3X2JpdHMuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IEkgdGhp
bmsgaXQgaXMgaW1wb3J0YW50IHRvIGZ1bGx5IHNlcGFyYXRlIHRoZSB2SU9NTVUgbW9kZWwgZnJv
bSB0aGUNCj4+Pj4+Pj4gaG9zdCBJT01NVSBiYWNraW5nIGRldmljZS4NCj4+Pg0KPj4+IFRoaXMg
Y29tbWVudCBpcyB0cnVlIGZvciB0aGUgc3RydWN0dXJlcyBhbHNvLg0KPj4+DQo+Pj4+Pj4+IENv
dWxkIHdlIGludHJvZHVjZSBhIG5ldyBIb3N0SU9NTVVEZXZpY2VDbGFzcw0KPj4+Pj4+PiBoYW5k
bGVyIC5jaGVja19oZGV2KCkgaGFuZGxlciwgd2hpY2ggd291bGQNCj4+PiBjYWxsIC5nZXRfaG9z
dF9pb21tdV9pbmZvKCkgPw0KPj4+DQo+Pj4gVGhpcyBtZWFucyB0aGF0IEhJT0RfTEVHQUNZX0lO
Rk8gYW5kIEhJT0RfSU9NTVVGRF9JTkZPIHNob3VsZA0KPmJlDQo+Pj4gYSBjb21tb24gc3RydWN0
dXJlICdIb3N0SU9NTVVEZXZpY2VJbmZvJyBob2xkaW5nIGFsbCBhdHRyaWJ1dGVzDQo+Pj4gZm9y
IHRoZSBkaWZmZXJlbnQgYmFja2VuZHMuIEVhY2ggLmdldF9ob3N0X2lvbW11X2luZm8oKSBpbXBs
ZW1lbnRhdGlvbg0KPj4+IHdvdWxkIHRyYW5zbGF0ZSB0aGUgc3BlY2lmaWMgaG9zdCBpb21tdSBk
ZXZpY2UgZGF0YSBwcmVzZW50YXRpb24NCj4+PiBpbnRvIHRoZSBjb21tb24gJ0hvc3RJT01NVURl
dmljZUluZm8nLCB0aGlzIGlzIHRydWUgZm9yIGhvc3RfYXdfYml0cy4NCj4+DQo+PiBJIHNlZSwg
aXQncyBqdXN0IG5vdCBlYXN5IHRvIGRlZmluZSB0aGUgdW5pZmllZCBlbGVtZW50cyBpbg0KPkhv
c3RJT01NVURldmljZUluZm8NCj4+IHNvIHRoYXQgdGhleSBtYXBzIHRvIGJpdHMgb3IgZmllbGRz
IGluIGhvc3QgcmV0dXJuIElPTU1VIGluZm8uDQo+DQo+VGhlIHByb3Bvc2FsIGlzIGFkZGluZyBh
IHZJT01NVSA8LT4gSG9zdElPTU1VRGV2aWNlIGludGVyZmFjZSBhbmQgYQ0KPm5ldw0KPkFQSSBu
ZWVkcyB0byBiZSBjb21wbGV0ZWx5IGRlZmluZWQgZm9yIGl0LiBUaGUgSU9NTVUgYmFja2VuZA0K
PmltcGxlbWVudGF0aW9uDQo+Y291bGQgYmUgYW55dGhpbmcsIGxlZ2FjeSwgaW9tbXVmZCwgaW9t
bXVmZCB2Miwgc29tZSBvdGhlciBmcmFtZXdvcmsNCj5hbmQNCj50aGUgdklPTU1VIHNob3VsZG4n
dCBiZSBhd2FyZSBvZiBpdHMgaW1wbGVtZW50YXRpb24uDQo+DQo+RXhwb3NpbmcgdGhlIGtlcm5l
bCBzdHJ1Y3R1cmVzIGFzIGRvbmUgYmVsb3cgc2hvdWxkIGJlIGF2b2lkZWQgYmVjYXVzZQ0KPnRo
ZXkgYXJlIHBhcnQgb2YgdGhlIFFFTVUgPC0+IGtlcm5lbCBJT01NVUZEIGludGVyZmFjZS4NCj4N
Cj4NCj4+IERpZmZlcmVudCBwbGF0Zm9ybSByZXR1cm5lZCBob3N0IElPTU1VIGluZm8gaXMgcGxh
dGZvcm0gc3BlY2lmaWMuDQo+PiBGb3IgdnRkIGFuZCBzaW9tbXU6DQo+Pg0KPj4gc3RydWN0IGlv
bW11X2h3X2luZm9fdnRkIHsNCj4+ICAgICAgICAgIF9fdTMyIGZsYWdzOw0KPj4gICAgICAgICAg
X191MzIgX19yZXNlcnZlZDsNCj4+ICAgICAgICAgIF9fYWxpZ25lZF91NjQgY2FwX3JlZzsNCj4+
ICAgICAgICAgIF9fYWxpZ25lZF91NjQgZWNhcF9yZWc7DQo+PiB9Ow0KPj4NCj4+IHN0cnVjdCBp
b21tdV9od19pbmZvX2FybV9zbW11djMgew0KPj4gICAgICAgICBfX3UzMiBmbGFnczsNCj4+ICAg
ICAgICAgX191MzIgX19yZXNlcnZlZDsNCj4+ICAgICAgICAgX191MzIgaWRyWzZdOw0KPj4gICAg
ICAgICBfX3UzMiBpaWRyOw0KPj4gICAgICAgICBfX3UzMiBhaWRyOw0KPj4gfTsNCj4+DQo+PiBJ
IGNhbiB0aGluayBvZiB0d28ga2luZHMgb2YgZGVjbGFyYXRpb24gb2YgSG9zdElPTU1VRGV2aWNl
SW5mbzoNCj4+DQo+PiBzdHJ1Y3QgSG9zdElPTU1VRGV2aWNlSW5mbyB7DQo+PiAgICAgIHVpbnQ4
X3QgYXdfYml0czsNCj4+ICAgICAgZW51bSBpb21tdV9od19pbmZvX3R5cGUgdHlwZTsNCj4+ICAg
ICAgdW5pb24gew0KPj4gICAgICAgICAgc3RydWN0IGlvbW11X2h3X2luZm9fdnRkIHZ0ZDsNCj4+
ICAgICAgICAgIHN0cnVjdCBpb21tdV9od19pbmZvX2FybV9zbW11djM7DQo+PiAgICAgICAgICAu
Li4uLi4NCj4+ICAgICAgfSBkYXRhOw0KPj4gfQ0KPj4NCj4+IG9yDQo+Pg0KPj4gc3RydWN0IEhv
c3RJT01NVURldmljZUluZm8gew0KPj4gICAgICB1aW50OF90IGF3X2JpdHM7DQo+PiAgICAgIGVu
dW0gaW9tbXVfaHdfaW5mb190eXBlIHR5cGU7DQo+PiAgICAgIF9fdTMyIGZsYWdzOw0KPj4gICAg
ICBfX2FsaWduZWRfdTY0IGNhcF9yZWc7DQo+PiAgICAgIF9fYWxpZ25lZF91NjQgZWNhcF9yZWc7
DQo+PiAgICAgIF9fdTMyIGlkcls2XTsNCj4+ICAgICAgX191MzIgaWlkcjsNCj4+ICAgICAgX191
MzIgYWlkcjsNCj4+ICAgICAuLi4uLi4NCj4+IH0NCj4+DQo+PiBOb3QgY2xlYXIgaWYgYW55IGlz
IHlvdXIgZXhwZWN0ZWQgZm9ybWF0Lg0KPj4NCj4+PiAndHlwZScgY291bGQgYmUgaGFuZGxlZCB0
aGUgc2FtZSB3YXksIHdpdGggYSAnSG9zdElPTU1VRGV2aWNlSW5mbycNCj4+PiB0eXBlIGF0dHJp
YnV0ZSBhbmQgaG9zdCBpb21tdSBkZXZpY2UgdHlwZSBkZWZpbml0aW9ucywgb3IgYXMgeW91DQo+
Pj4gc3VnZ2VzdGVkIHdpdGggYSBRT00gaW50ZXJmYWNlLiBUaGlzIGlzIG1vcmUgY29tcGxleCBo
b3dldmVyLiBJbg0KPj4+IHRoaXMgY2FzZSwgSSB3b3VsZCBzdWdnZXN0IHRvIGltcGxlbWVudCBh
IC5jb21wYXRpYmxlKCkgaGFuZGxlciB0bw0KPj4+IGNvbXBhcmUgdGhlIGhvc3QgaW9tbXUgZGV2
aWNlIHR5cGUgd2l0aCB0aGUgdklPTU1VIHR5cGUuDQo+Pj4NCj4+PiBUaGUgcmVzdWx0aW5nIGNo
ZWNrX2hkZXYgcm91dGluZSB3b3VsZCBsb29rIHNvbWV0aGluZyBsaWtlIDoNCj4+Pg0KPj4+IHN0
YXRpYyBpbnQgdnRkX2NoZWNrX2hkZXYoSW50ZWxJT01NVVN0YXRlICpzLCBWVERIb3N0SU9NTVVE
ZXZpY2UNCj4+PiAqdnRkX2hkZXYsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJy
b3IgKiplcnJwKQ0KPj4+IHsNCj4+PiAgICAgIEhvc3RJT01NVURldmljZSAqaGlvZCA9IHZ0ZF9o
ZGV2LT5kZXY7DQo+Pj4gICAgICBIb3N0SU9NTVVEZXZpY2VDbGFzcyAqaGlvZGMgPQ0KPj4+IEhP
U1RfSU9NTVVfREVWSUNFX0dFVF9DTEFTUyhoaW9kKTsNCj4+PiAgICAgIEhvc3RJT01NVURldmlj
ZSBpbmZvOw0KPj4+ICAgICAgaW50IGhvc3RfYXdfYml0cywgcmV0Ow0KPj4+DQo+Pj4gICAgICBy
ZXQgPSBoaW9kYy0+Z2V0X2hvc3RfaW9tbXVfaW5mbyhoaW9kLCAmaW5mbywgc2l6ZW9mKGluZm8p
LCBlcnJwKTsNCj4+PiAgICAgIGlmIChyZXQpIHsNCj4+PiAgICAgICAgICByZXR1cm4gcmV0Ow0K
Pj4+ICAgICAgfQ0KPj4+DQo+Pj4gICAgICByZXQgPSBoaW9kYy0+aXNfY29tcGF0aWJsZShoaW9k
LCBWSU9NTVVfSU5URVJGQUNFKHMpKTsNCj4+PiAgICAgIGlmIChyZXQpIHsNCj4+PiAgICAgICAg
ICByZXR1cm4gcmV0Ow0KPj4+ICAgICAgfQ0KPj4+DQo+Pj4gICAgICBpZiAocy0+YXdfYml0cyA+
IGluZm8uYXdfYml0cykgew0KPj4+ICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgImF3LWJpdHMg
JWQgPiBob3N0IGF3LWJpdHMgJWQiLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgcy0+YXdfYml0
cywgaW5mby5hd19iaXRzKTsNCj4+PiAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+PiAgICAg
IH0NCj4+PiB9DQo+Pj4NCj4+PiBhbmQgdGhlIEhvc3RJT01NVURldmljZUNsYXNzOjppc19jb21w
YXRpYmxlKCkgaGFuZGxlciB3b3VsZCBjYWxsIGENCj4+PiB2SU9NTVVJbnRlcmZhY2U6OmNvbXBh
dGlibGUoKSBoYW5kbGVyIHNpbXBseSByZXR1cm5pbmcNCj4+PiBJT01NVV9IV19JTkZPX1RZUEVf
SU5URUxfVlRELiBIb3cgZG9lcyB0aGF0IHNvdW5kID8NCj4+DQo+PiBOb3QgcXVpdGUgZ2V0IHdo
YXQgSG9zdElPTU1VRGV2aWNlQ2xhc3M6OmlzX2NvbXBhdGlibGUoKSBkb2VzLg0KPg0KPkhvc3RJ
T01NVURldmljZUNsYXNzOjppc19jb21wYXRpYmxlKCkgY2FsbHMgaW4gdGhlIGhvc3QgSU9NTVUg
YmFja2VuZA0KPnRvIGRldGVybWluZSB3aGljaCBJT01NVSB0eXBlcyBhcmUgZXhwb3NlZCBieSB0
aGUgaG9zdCwgdGhlbiBjYWxscyB0aGUNCj52SU9NTVVJbnRlcmZhY2U6OmNvbXBhdGlibGUoKSBo
YW5kbGVyIHRvIGRvIHRoZSBjb21wYXJlLiBBUEkgaXMgdG8gYmUNCj5kZWZpbmVkLg0KPg0KPkFz
IGEgcmVmaW5lbWVudCwgd2UgY291bGQgaW50cm9kdWNlIGluIHRoZSB2SU9NTVUgPC0+IEhvc3RJ
T01NVURldmljZQ0KPmludGVyZmFjZSBjYXBhYmlsaXRpZXMsIG9yIGZlYXR1cmVzLCB0byBjaGVj
ayBtb3JlIHByZWNpc2VseSB0aGUgbGV2ZWwNCj5vZiBjb21wYXRpYmlsaXR5IGJldHdlZW4gdGhl
IHZJT01NVSBhbmQgdGhlIGhvc3QgSU9NTVUgZGV2aWNlLiBUaGlzIGlzDQo+c2ltaWxhciB0byB3
aGF0IGlzIGRvbmUgYmV0d2VlbiBRRU1VIGFuZCBLVk0uDQo+DQo+SWYgeW91IHRoaW5rIHRoaXMg
aXMgdG9vIGNvbXBsZXgsIGluY2x1ZGUgdHlwZSBpbiBIb3N0SU9NTVVEZXZpY2VJbmZvLg0KPg0K
Pj4gQ3VycmVudGx5IGxlZ2FjeSBhbmQgSU9NTVVGRCBob3N0IGRldmljZSBoYXMgZGlmZmVyZW50
IGNoZWNrIGxvZ2ljLCBob3cNCj5pdCBjYW4gaGVscA0KPj4gaW4gbWVyZ2luZyB2dGRfY2hlY2tf
bGVnYWN5X2hkZXYoKSBhbmQgdnRkX2NoZWNrX2lvbW11ZmRfaGRldigpIGludG8NCj5hIHNpbmds
ZSB2dGRfY2hlY2tfaGRldigpPw0KPg0KPklNSE8sIElPTU1VIHNob3VsZG4ndCBiZSBhd2FyZSBv
ZiB0aGUgSU9NTVUgYmFja2VuZCBpbXBsZW1lbnRhdGlvbiwNCj5idXQNCj5pZiB5b3UgdGhpbmsg
dGhlIEludGVsIHZJT01NVSBzaG91bGQgYWNjZXNzIGRpcmVjdGx5IHRoZSBpb21tdWZkIGJhY2tl
bmQNCj53aGVuIGF2YWlsYWJsZSwgdGhlbiB3ZSBzaG91bGQgZHJvcCB0aGlzIHByb3Bvc2FsIGFu
ZCByZXZpc2l0IHRoZSBkZXNpZ24NCj50byB0YWtlIGEgZGlmZmVyZW50IGFwcHJvYWNoLg0KDQpJ
IGltcGxlbWVudGVkIGEgZHJhZnQgZm9sbG93aW5nIHlvdXIgc3VnZ2VzdGlvbnMgc28gd2UgY291
bGQgZXhwbG9yZSBmdXJ0aGVyLg0KU2VlIGh0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVt
dS90cmVlL3poZW56aG9uZy9pb21tdWZkX25lc3RpbmdfcHJlcV92M190bXANCg0KSW4gdGhpcyBk
cmFmdCwgaXQgdXNlcyAuY2hlY2tfY2FwKCkgdG8gcXVlcnkgSE9TVF9JT01NVV9ERVZJQ0VfQ0FQ
X3h4eA0KanVzdCBsaWtlIEtWTSBDQVBzLg0KQSBjb21tb24gSG9zdElPTU1VRGV2aWNlQ2FwcyBz
dHJ1Y3R1cmUgaXMgaW50cm9kdWNlZCB0byBiZSB1c2VkIGJ5DQpib3RoIGxlZ2FjeSBhbmQgaW9t
bXVmZCBiYWNrZW5kLg0KDQpJdCBpbmRlZWQgaXMgY2xlYW5lci4gT25seSBwcm9ibGVtIGlzIEkg
ZmFpbGVkIHRvIGltcGxlbWVudCAuY29tcGF0aWJsZSgpDQphcyBhbGwgdGhlIGNoZWNrIGNvdWxk
IGdvIGFoZWFkIGJ5IGp1c3QgY2FsbGluZyBjaGVja19jYXAoKS4NCkNvdWxkIHlvdSBoZWxwIGEg
cXVpY2sgY2hlY2sgdG8gc2VlIGlmIEkgbWlzdW5kZXJzdG9vZCBhbnkgb2YgeW91ciBzdWdnZXN0
aW9uPw0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+PiBCZWxvdyBpcyB0aGUgdHdvIGZ1bmN0
aW9ucyBhZnRlciBuZXN0aW5nIHNlcmllcywgZm9yIHlvdXIgZWFzeSByZWZlcmVuY2U6DQo+Pg0K
Pj4gc3RhdGljIGludCB2dGRfY2hlY2tfbGVnYWN5X2hkZXYoKQ0KPj4gew0KPj4gICAgICBpZiAo
cy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+PiAgICAgICAgICAvKiBNb2Rlcm4gdklPTU1VIGFuZCBs
ZWdhY3kgYmFja2VuZCAqLw0KPj4gICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiTmVlZCBJT01N
VUZEIGJhY2tlbmQgaW4gc2NhbGFibGUgbW9kZXJuDQo+bW9kZSIpOw0KPj4gICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7DQo+PiAgICAgIH0NCj4NCj5UaGlzIHBhcnQgd291bGQgdHlwaWNhbGx5IGdv
IGluIHRoZSBjb21wYXRpYmxlKCkgaGFuZGxlci4NCj4NCj4+DQo+PiAgICAgIHJldCA9IGhpb2Rj
LT5nZXRfaG9zdF9pb21tdV9pbmZvKGhpb2QsICZpbmZvLCBzaXplb2YoaW5mbyksIGVycnApOw0K
Pj4gICAgICBpZiAocmV0KSB7DQo+PiAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gICAgICB9DQo+
Pg0KPj4gICAgICBpZiAocy0+YXdfYml0cyA+IGluZm8uYXdfYml0cykgew0KPj4gICAgICAgICAg
ZXJyb3Jfc2V0ZyhlcnJwLCAiYXctYml0cyAlZCA+IGhvc3QgYXctYml0cyAlZCIsDQo+PiAgICAg
ICAgICAgICAgICAgICAgIHMtPmF3X2JpdHMsIGluZm8uYXdfYml0cyk7DQo+PiAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsNCj4+ICAgICAgfQ0KPj4NCj4+ICAgICAgcmV0dXJuIDA7DQo+PiB9DQo+
Pg0KPj4gc3RhdGljIGludCB2dGRfY2hlY2tfaW9tbXVmZF9oZGV2KEludGVsSU9NTVVTdGF0ZSAq
cywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlRESG9zdElPTU1VRGV2
aWNlICp2dGRfaGRldiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJy
b3IgKiplcnJwKQ0KPj4gew0KPj4gICAgICByZXQgPSBoaW9kYy0+Z2V0X2hvc3RfaW9tbXVfaW5m
byhoaW9kLCAmaW5mbywgc2l6ZW9mKGluZm8pLCBlcnJwKTsNCj4+ICAgICAgaWYgKHJldCkgew0K
Pj4gICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICAgICAgfQ0KPj4NCj4+ICAgICAgaWYgKGluZm8u
dHlwZSAhPSBJT01NVV9IV19JTkZPX1RZUEVfSU5URUxfVlREKSB7DQo+PiAgICAgICAgICBlcnJv
cl9zZXRnKGVycnAsICJJT01NVSBoYXJkd2FyZSBpcyBub3QgY29tcGF0aWJsZSIpOw0KPj4gICAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+PiAgICAgIH0NCj4+DQo+PiAgICAgIHZ0ZCA9ICZpbmZv
LmRhdGEudnRkOw0KPj4gICAgICBob3N0X2F3X2JpdHMgPSBWVERfTUdBV19GUk9NX0NBUCh2dGQt
PmNhcF9yZWcpICsgMTsNCj4+ICAgICAgaWYgKHMtPmF3X2JpdHMgPiBob3N0X2F3X2JpdHMpIHsN
Cj4+ICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgImF3LWJpdHMgJWQgPiBob3N0IGF3LWJpdHMg
JWQiLA0KPj4gICAgICAgICAgICAgICAgICAgICBzLT5hd19iaXRzLCBob3N0X2F3X2JpdHMpOw0K
Pj4gICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+PiAgICAgIH0NCj4+DQo+PiAgICAgIGlmICgh
cy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+PiAgICAgICAgICBnb3RvIGRvbmU7DQo+PiAgICAgIH0N
Cj4+DQo+PiAgICAgIGlmICghKHZ0ZC0+ZWNhcF9yZWcgJiBWVERfRUNBUF9ORVNUKSkgew0KPj4g
ICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiSG9zdCBJT01NVSBkb2Vzbid0IHN1cHBvcnQgbmVz
dGVkIHRyYW5zbGF0aW9uIik7DQo+PiAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4+ICAgICAg
fQ0KPj4NCj4+ICAgICAgaWYgKHMtPmZsMWdwICYmICEodnRkLT5jYXBfcmVnICYgVlREX0NBUF9G
TDFHUCkpIHsNCj4+ICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIlN0YWdlLTEgMUdCIGh1Z2Ug
cGFnZSBpcyB1bnN1cHBvcnRlZCBieSBob3N0DQo+SU9NTVUiKTsNCj4+ICAgICAgICAgIHJldHVy
biAtRUlOVkFMOw0KPj4gICAgICB9DQo+DQo+VGhlc2UgY2hlY2tzIGFib3ZlIHdvdWxkIHR5cGlj
YWxseSBnbyBpbiB0aGUgY29tcGF0aWJsZSgpIGhhbmRsZXIgYWxzby4NCj4NCj5Ob3csIHRoZSBx
dWVzdGlvbiBpcyBob3cgdXNlZnVsIHdpbGwgdGhhdCBmcmFtZXdvcmsgYmUgaWYgaG90cGx1Z2dp
bmcNCj5kZXZpY2VzIGFsd2F5cyBmYWlsIGJlY2F1c2UgdGhlIHZJT01NVSBhbmQgaG9zdCBJT01N
VSBkZXZpY2VzIGhhdmUNCj5pbmNvbXBhdGlibGUgc2V0dGluZ3MvY2FwYWJpbGl0aWVzID8gU2hv
dWxkbid0IHdlIGFsc28gYWRkIHByb3BlcnRpZXMNCj5hdCB0aGUgdklPTU1VIGxldmVsID8NCj4N
Cj4NCj5UaGFua3MsDQo+DQo+Qy4NCg0K

