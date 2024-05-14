Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195D4C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 08:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6nBz-0004U7-AH; Tue, 14 May 2024 04:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6nBx-0004Tp-Vh
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:07:21 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s6nBv-0006Y1-ES
 for qemu-devel@nongnu.org; Tue, 14 May 2024 04:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715674040; x=1747210040;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2vJvKsoEMtC168GCpICDtJ8euZc88lUsVqqrKTdOR8o=;
 b=N9aojTGdAc6G7p1LNL+ct4iZwmxZaHhPmGLb3qaK9PhXkKNsi1W6qG5Y
 QHPap3a+CD3LoNxjpM2kffgAiMdHilrKlH2NIZoBXPgEU95xGxvIGKRjF
 OWuKLTQPqjaI+ZPtO6IH9OR62DRLVh9fcF//ds9CBsiXq1Oz4n5BmgliH
 4HXCxad26dA12nx+J63T7wVfuVVo66XLwsOlnfzLFWK0I0HwgNOGDxFFW
 ynOI4A4MbS/yKDEw5G4YJtvEiKJpFKHfArWR3hsA7ujHpY8+gbEpFG32p
 iZn6SOdM6Cim8ssAIs1CysCI65WgpCW6nN2N4QPs/n5NqwTHn0GRC2S/v Q==;
X-CSE-ConnectionGUID: 4vp9QL+TQmune/3ir4dQ2g==
X-CSE-MsgGUID: QkCGoaerSiCox1VrSi4MsA==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11773319"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="11773319"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2024 01:07:16 -0700
X-CSE-ConnectionGUID: XMGHjRdlTfyYXBgoPrA8Hw==
X-CSE-MsgGUID: 8OsgiitHRC+W8CeNtJ7TMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; d="scan'208";a="30649411"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 May 2024 01:07:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 01:07:15 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 14 May 2024 01:07:15 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 14 May 2024 01:07:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKsBT7zQ3+t5Jc8rMr49GFZLG6aE6gow3AL66ogU2KKYiC09zhSZlKhBeHP2BXRga25DtB8Oq5gTMJ9KPzj7bZlqk5lfLdAZA/dhcf/22PWQ1DJuS8tmIH0bMr19YCkqw6Ze375x3nugWn8UnisFIGqua74p6PI4pzUz4yq9TOn1AAVmS4Z793hqpJ//m/TkyZWImp2R7o3tfqnynHYupQdWbbmg4/mVIOzW69TmSJrkV3MW/Xzewy+g3lLCz5AG2P7uojrpUrQC7w8rzh2AwcKrgr6qZFk3d0Q2RUBaXUVewSNpgOPtSmIPAgvyFhiGIbWOI0gHnooCZJ2QAWuAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vJvKsoEMtC168GCpICDtJ8euZc88lUsVqqrKTdOR8o=;
 b=cHIvBO+8G+vW+HExtKsdXGJV3Bc1GzyMdErWg1qK2CfSXAvMfvCcTtGC1G1GCrrzHz1hsTIo0PLFUrTbeTUzjQYtwE1gdpvKv82LcgnI2kePyk6r080OK8Oe7tTZBgI4t8ekrR7NB5letgzfChp08VoRhEIulvJZ/TqbsWi5omRyB7CnULnYbxvSd6CPfuqRYas6DdJHFhQKX9OMkjoqLFeBVV0Ptq/15bH9hwmeMQIfszPdIezmY6yk9fent0OnZ7X/AKwGafU2rq3boNoVn7JZu3u5r8JPaetivBXdydehSkpeiShDq4FLm6N+VW1oNLObf1grh1oX2k665Mxwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB6918.namprd11.prod.outlook.com (2603:10b6:806:2bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Tue, 14 May
 2024 08:07:13 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7544.052; Tue, 14 May 2024
 08:07:13 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>
Subject: RE: [PATCH ats_vtd v1 06/24] intel_iommu: do not consider wait_desc
 as an invalid descriptor
Thread-Topic: [PATCH ats_vtd v1 06/24] intel_iommu: do not consider wait_desc
 as an invalid descriptor
Thread-Index: AQHanKV/hE21IWhVrEugDPFECrFAVLGWcefA
Date: Tue, 14 May 2024 08:07:13 +0000
Message-ID: <SJ0PR11MB674447FE9F78865920BF2A3D92E32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
 <20240502152810.187492-7-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-7-clement.mathieu--drif@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA1PR11MB6918:EE_
x-ms-office365-filtering-correlation-id: 1fbd4f18-3bc6-4380-d2f4-08dc73ecdcb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?bWtkc0ZmeGUyZlhKM0YxZVV5Tjk2Q1RvQnh3MzFXWCtNcHExdTVQa0FkUEJ2?=
 =?utf-8?B?MUJma1dVdXk5USsrMVpSQTNrUjltS0FFckF0NnFsSnRZWjk1TFdUUitDOVNZ?=
 =?utf-8?B?LzV5Q1AvZ25pUDdxMHh1TiszRnNucFI5TzdkWlNYVTRlVUU3MW84UmhoSUF5?=
 =?utf-8?B?V0VUejhwWTlXSEZ1N3M1SHdYSnBJMWE0aGZKWWJWTzRnSkg2c2t6SzVPVFJk?=
 =?utf-8?B?dHVYR2xzcWFCbzZBUkIyMW1aK3hjNkdFOG5qc29TU01aY1d2dFhVKzVEQ3dW?=
 =?utf-8?B?VTRaRE9SL1c1SmNuM0tVVS9RaklVRHNqVjVPeXN1RXlnakp1NEpoVUIreS9E?=
 =?utf-8?B?YnVZR1ZVL1c4dUpPSm9wdFRrSTBMZnc1SHBSMUpXTmFFU1RqSDRQdmdaS2cv?=
 =?utf-8?B?REU0V0ZnbzZNRktrb21PbTR0NTkrU3VMenprZ0VZS0NUYklDL0VlZENvYXNJ?=
 =?utf-8?B?OFkwa3lybzZWblJHeG9Cb053ZE83TmJCZEROQ3NMSlB5aldQS0FwSjJBNmsy?=
 =?utf-8?B?dERXeEtldU56SSsrN3FDZERLVFpxQlpNd01XV3RTV0dRTWMyczFsYkdGV3Va?=
 =?utf-8?B?alpTRDgvcW13c1ZGb1dBQ0VrM2Y4b1pHMlJLeUdZTldPQ1M3TnpSd2xJTVZX?=
 =?utf-8?B?SWxDUVBnMis3aS96ZWwwZitwZndCY2UzR3h0RnBFL2hYeHgrYk5GZnNCZ2Jh?=
 =?utf-8?B?bWZYcXZ2ck54Ti9ra1crUEZrb0l2dW8zNkIxVHVrWXAzV3dQNlQwWjVUSnBP?=
 =?utf-8?B?cUNreWJac0M0bXFKdGlXTXhpb0YxNVNtZlVDRUR1MHhTb2FjRXlTK2RubFpU?=
 =?utf-8?B?NVFyN1JHUWVIb01PMzlhMGlqU2FIOUlqbVhHNXdYYUNpQ3RuMDdmNHZoU1BL?=
 =?utf-8?B?cTlyTDQ5R0JlNkJwOExhUUFrR3NmT3JUdlNrRXNhRnpxVXk2V2Zsd2EwZHQw?=
 =?utf-8?B?TS92emx5UldmTlVzSFM1YXRpdU1VMUxrRnhEZEVodTROMnVpNVJ2a3NIaGZQ?=
 =?utf-8?B?dVcreUV2SjQ2UlBnRWxKQXB0OU1Zb1M4WHByUk9wanNoZ0pFVWM1Mmp0ZzU2?=
 =?utf-8?B?dm5ENmF6Y0xqU3pNd1UxRE01SXhVTjBya1g5Zmhmb0NZR0NIYnVOZVlOdFZl?=
 =?utf-8?B?UFhpTWVXTy9ERFludW1VRmRKMlV1d2VHTmo1aUJuUDZzNk5EMTV5REVYSnJ0?=
 =?utf-8?B?Unh5N2dpbW1kMHF0R1VxR0ZwTzVjWDdDbkMwSGs1Z25lV2JxU2xZZGRFbnVn?=
 =?utf-8?B?cjNQQkk5Z2RzOUZ5WFgrZ01EWFNOcTl3QnYvWllzY3A2WW9Kbk5xblM5dHVO?=
 =?utf-8?B?VUFhT0ZpQ29lWTFuMUdUYmFjRHp5QVp6NXpaeXBacGRVY213UmFLOTc0SUVE?=
 =?utf-8?B?Q1JrczFRSjRPeUh4cXFQVEo5bUJJNlBjRXd5REZUTHJHbksrQzJOL3ZsWThX?=
 =?utf-8?B?YndaMlhZOC9RNEdLZXU2dTFRNWl0R2h6eDhuUklzQ0ExY09VK1dmSzhjMHRO?=
 =?utf-8?B?aVh1Y2JPTThvcE5wY2pmZWVtczE5Vi9pcVZMRHlSTUErTVlKQm9kcGdCdndX?=
 =?utf-8?B?MlVCRXp6ZzVqOGdnNUVSZWtoZkNYbkp0ajRKTjNUbDBtZkIxQUd4YWxmZmQ1?=
 =?utf-8?B?SkdxelNVczBqSUpYdUpkRlJEenkzRjRNa2lmNzlZQ25MdnZvNjFocVdXTzl3?=
 =?utf-8?B?akUyNlRPOUVFSytnN1d4WjBCU2pHZ3VUc2hoVEFYTE1lOElpN2ZBcVI4Vkgw?=
 =?utf-8?Q?kRpcZlzKG4SeLkGJ3bxPf8pXZ0BPWNQ6JIeRVlA?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STFFMzJxcE4reEtGbFV4YzJyaS9oVWx4QSttNlZIY2hpWFA0Q3NLaDRiMUl4?=
 =?utf-8?B?L0xQYVBvdllTSlJqdG9KRXNZcnoyQzBiL1VKcSs2QzNQMngybStlWFlHTTZO?=
 =?utf-8?B?V0NWZ1J5UWZRMDl5V0N1d2JNTkorc1NsOVZSSU5BOU5jLzhPdzJmS0owbVdV?=
 =?utf-8?B?VldWaWFyMCtna0svYkxMTUZlME92N1lSaDhDajhxMkNOS295UG4wd1pDRFRT?=
 =?utf-8?B?UFpFQU1SNzhNb2p0RUFzOFl4NjFpK05BQ3NCMlNOdW1sNkNiTCtGS3BWWmZh?=
 =?utf-8?B?N3ZEOXltUk56ZUtEa3BMK0dPRGVMUlNCRWdFK202Rlh2dFRSVmg3c2lxRlZV?=
 =?utf-8?B?Q1UzQTR4Q01Kc3J0bFFnbXNEUUo2M3NmK0YrZWxnaUpPUENTMXcrcG80clFa?=
 =?utf-8?B?c0syVjBxdG9mb2lOdEdXVFlVd1daM0Vic3JvQU9VbWNuTHJsMldRVlRPaVY3?=
 =?utf-8?B?Zk5SUkNCZXJaRlZ5eHJSSWViTkk5RnljWlMxUjExWnloQzVkK3pDRlByTHo4?=
 =?utf-8?B?YjN3dGY1dzN5QnFiWFRiNjJSaWJySVdSM2dlMEw2Sy9qa3ZqUERZOW85Z2tt?=
 =?utf-8?B?dDZXSDN1NEhUQ2lNWlhEUUlLbVk0eU1qQkN2Mm5CZHArWWI4MjBUbHArdTVx?=
 =?utf-8?B?amFoSEovaGxiZVprTElSczJiZ1pSQ2swK0VDNCtGamhxbEF1ODQxbjZ4OFRP?=
 =?utf-8?B?SUk2UUpXcUhkQ2RsRlFrRzR2Z2VFbFBWb1Vnd01SRUdJQ3VOSncvcDVYcXFN?=
 =?utf-8?B?UkYwQmNnSm5OQmVQQnZlMEpSdnUvdWI3cnBpWWlkNUZaSERuVUEyV2R4dFF6?=
 =?utf-8?B?SzN6VSt5Q2RtZU1pOEV5bEZ6OVJuMEdlamMrZkRXSjhGV0xkUEVvYXRhVVZN?=
 =?utf-8?B?UFNHUDlTRWpVWDl4bUNyS0k0anh6RHRnNlBRMzQ4UmYyWUZkZVVqbGJwczNj?=
 =?utf-8?B?cHh5L0tJNWhGQXR1aHRjcEt2YzdXajJKZ1hmRHNWaDlhQU1wMGZlWG9SeUVp?=
 =?utf-8?B?czI5ZWNRR2F4a2tnK0wrVWZ4Yy9Nazl2NS8wd0JXaW9PRWVHbXdLQUNKeGpr?=
 =?utf-8?B?ZS9UakdQOHVycUxWcjZYazA2TFYxUWF6Ym5GOFBiai9uZ3cwaFpkOGdEdFlt?=
 =?utf-8?B?dHovaDJNTWpyZ1htWUgwdGIvekE5ODNOYUV5UXRQS0J2L2ZyeitoMkljTnRl?=
 =?utf-8?B?SldESVpTZ3ZtV2R2cm9rNkFpUXhEcXd4b0ZSK1dBdjZNT2pQYUNpN3drQXhY?=
 =?utf-8?B?VUZRRGYzQk1lc2hlaHVMQ1UxeWludnhlYnViNHVqUWdXcHZFWUxOZG51MWMy?=
 =?utf-8?B?Zy82Tk9DbmJ2V1pYMVBSczdib1B4b1o3eG9yMWRwZzlmZXdGSUEvTVhTdzR4?=
 =?utf-8?B?ZHhHTU5QV3FqWDhyakZ3NVRXa1VHQWhrWUdWcHI0Vzk1WTVBbXVHcHV6MytY?=
 =?utf-8?B?bHJwTld4aXUvd2k1dEZvK0t3dFIyUnhsZmQ3cHVXaTFneHhabVBMeVZCRnBL?=
 =?utf-8?B?em1MSWtCTmdrRVdyckN2bHJKeVNreWtlbStaSFcwMFRmRnBGSGlrWDRsc1hD?=
 =?utf-8?B?V251b01JM09aZFFJcmo2RnRUQWphV2oyRDNZYk1RTFBzSU5NUWJneGw5cnND?=
 =?utf-8?B?bXdJMFZ3WkkvNG54MTdzNUIvenlmZXBZQXhYbXJJMFp4OFduZEY1QUozeXl6?=
 =?utf-8?B?RW9JazV5T2ZmMm15TzMzSUE3bHlYcUxMaUVrczd2bWxkZW4xTitrWEtsKzgz?=
 =?utf-8?B?L3ZmbUhJZnd6VEpQeFlOLzFRSkkxM1RpMjk2ODJKeDVjSVZXaU5BU0syeVht?=
 =?utf-8?B?ZUJCR1FQR0pWWW9YdWUvakU2ZEpVcWJBeERIa0szS25ieFdPb1F5Yldwc3lL?=
 =?utf-8?B?VUludU5KeWRMdkgyWHFXU2F5QWgvdHpsZGZDVU5QT3RmWlU4TnVvYjhGTVlt?=
 =?utf-8?B?aWl1T2EwTk5rQ2xrc0RPdDlOaHpCUGZyUk5XWDhDTXBHTE5uVU5KaHdWVHl6?=
 =?utf-8?B?a3ZzMDJHcUIyQ0drR1RGVzh4SzVUOGJ1RHpRb3B3S0JLaS9wK3drSWYzOTBo?=
 =?utf-8?B?SDg0eTY1Y2FnemhRZ3N3bnp6QWdySzV4RDBtVm1xZjZHM3NtcmF5TFhuOGJr?=
 =?utf-8?Q?HEvt+1tHVpPepvW8xjoTu2B4q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbd4f18-3bc6-4380-d2f4-08dc73ecdcb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 08:07:13.1573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uE/1MPCFJT7R+A8xLq/QkorFT21X6eseU21gmiJSHsV8HLPo0ipo6cLeXxTorkMf9Jjanj2OzWbE7HVKH3e55xc37q8mAJBqztQ2ah2CmQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6918
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENMRU1FTlQgTUFUSElFVS0t
RFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+U3ViamVjdDogW1BBVENI
IGF0c192dGQgdjEgMDYvMjRdIGludGVsX2lvbW11OiBkbyBub3QgY29uc2lkZXIgd2FpdF9kZXNj
DQo+YXMgYW4gaW52YWxpZCBkZXNjcmlwdG9yDQo+DQo+U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQg
TWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRlbi5jb20+DQo+LS0tDQo+
IGh3L2kzODYvaW50ZWxfaW9tbXUuYyB8IDUgKysrKysNCj4gMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQ0KPg0KPmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9p
Mzg2L2ludGVsX2lvbW11LmMNCj5pbmRleCA4NWE3ZWJhYzY3Li5jNDc1YTM1NGEwIDEwMDY0NA0K
Pi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KPkBAIC0zMzY1LDYgKzMzNjUsMTEgQEAgc3RhdGljIGJvb2wNCj52dGRfcHJvY2Vzc193YWl0
X2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLCBWVERJbnZEZXNjICppbnZfZGVzYykNCj4gICAgIH0g
ZWxzZSBpZiAoaW52X2Rlc2MtPmxvICYgVlREX0lOVl9ERVNDX1dBSVRfSUYpIHsNCj4gICAgICAg
ICAvKiBJbnRlcnJ1cHQgZmxhZyAqLw0KPiAgICAgICAgIHZ0ZF9nZW5lcmF0ZV9jb21wbGV0aW9u
X2V2ZW50KHMpOw0KPisgICAgfSBlbHNlIGlmIChpbnZfZGVzYy0+bG8gJiBWVERfSU5WX0RFU0Nf
V0FJVF9GTikgew0KPisgICAgICAgIC8qDQo+KyAgICAgICAgICogU1cgPSAwLCBJRiA9IDAsIEZO
ID0gMQ0KPisgICAgICAgICAqIE5vdGhpbmcgdG8gZG8gYXMgd2UgcHJvY2VzcyB0aGUgZXZlbnRz
IHNlcXVlbnRpYWxseQ0KPisgICAgICAgICAqLw0KPiAgICAgfSBlbHNlIHsNCj4gICAgICAgICBl
cnJvcl9yZXBvcnRfb25jZSgiJXM6IGludmFsaWQgd2FpdCBkZXNjOiBoaT0lIlBSSXg2NCIsIGxv
PSUiUFJJeDY0DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIiAodW5rbm93biB0eXBlKSIs
IF9fZnVuY19fLCBpbnZfZGVzYy0+aGksDQoNCkxHVE0uDQoNClRoYW5rcw0KWmhlbnpob25nIA0K

