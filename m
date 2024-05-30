Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE4AC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCgXs-0003SI-J7; Thu, 30 May 2024 10:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sCgXj-0003Ep-De
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:14:12 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sCgXe-000296-Ao
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717078446; x=1748614446;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7fRMixbiT0ciYQsvYj6E6RdQE9TYk5IJhUsKzAPVSBs=;
 b=Om0rTh8snPF2LcO6hLhzvP9OfW5zGONdk5lsIRj8ao924GMaZsNC2F7W
 GexIsjRhJDjcYIYhbUeVGcoNQriwIKIkQUw+LgI89np9QxQQc2t7h0KhW
 jtYAnSlY6795yOxrCLvTgCsCT4rHfYRRd6oimtH+Xef03cAwKD/ENuwdx
 8eCFch9V6exYrFxWVJrDIxMnA3JdCHV5rVzoTTLKKPfkA+HXpOoRJwwDE
 wM2MfWZnOdBrr9eF0Lr5Xl7l26N/FStS+wl8+PqeBWbQdQw1bDqhmJJqn
 6IH4pcgCiVoD0S4RHOSRXbGFlAb51Z+mWERfnWIRY1XayCVfHg1EK2suJ A==;
X-CSE-ConnectionGUID: XpGOU88ZTCKwS0sG6MLF/A==
X-CSE-MsgGUID: qNXShfJbRAacn/deQ3iKYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="11809230"
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="11809230"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 07:13:59 -0700
X-CSE-ConnectionGUID: B5JDK/QUSNuCaSupXQ/zxw==
X-CSE-MsgGUID: Xw5+gfo4SBanVIa13jN7OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,201,1712646000"; d="scan'208";a="40287698"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 May 2024 07:13:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 07:13:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 07:13:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 07:13:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VraIrufcS3g7t1RLpIN+wX/x0kGZJqOQAojaLA8SU9SoRzScC5f2OtzriraJYeBKlPxt/i6iP08t3Xc7XOltp+NXYTx0r1Stt65PBJp0kaBvN0FpGmBw69lKkOdxR5tKEszMOgZqfnfxtsg57YiKQoGzOw/I1vkh6VnbmyBh2XVYH3H6Xm7w7sI8Cit7vsxr1MR845PbHoXpzlEnQhnG4m30RQjQvsL5uDWPXQmqjrkuK/aZlbw7ha2kCJ1KxZ7cKTlY52ojIjGbiUGO70EWHdLROGKPpb2a/iT3NFZE5tcsGJOvMZ6tPDFRiaE+eA7pICjdZ2eb/fYcBs6zHxTR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fRMixbiT0ciYQsvYj6E6RdQE9TYk5IJhUsKzAPVSBs=;
 b=B5CmQ7FyDyv8i5Z2U+yO2otv1y2P5j/bvbkaGB7Qp4B2cUe2jqp5bBm5js/ldmLWGyyPls01OjOVWt4YcrJhFjoH4mJbuIcYhbEJMeNg46LzpwipV3gLyj6LOmPNL7xVOHCL02sxZCzrUEr2bv70GRpusH5tWzh0scjgLm3O++Pnpyz/z5njlYSyokuQ05Ys45P0549ii9oPFQda41kwCr3uX0OcJjw/KoTEQF46H8RCf4/j2LkmKMZSEhq2uAu6OWeABiRDhBrTLL9qPDj6nniSbars56bGm50gL3uAqK9Lx0SkqeVOkF53evsNEf2eUYKsPZADtvqMvp97lf2BVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by BY1PR11MB7984.namprd11.prod.outlook.com (2603:10b6:a03:531::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 14:13:56 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 14:13:56 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de" <farosas@suse.de>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Linuxarm
 <linuxarm@huawei.com>, "linwenkai (C)" <linwenkai6@hisilicon.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>, huangchenghai
 <huangchenghai2@huawei.com>
Subject: RE: [PATCH 1/7] docs/migration: add uadk compression feature
Thread-Topic: [PATCH 1/7] docs/migration: add uadk compression feature
Thread-Index: AQHasaz8E0yBf65W/0WETt9KQ8yyZLGvvhFAgAASSoCAAADtgA==
Date: Thu, 30 May 2024 14:13:56 +0000
Message-ID: <PH7PR11MB59416CCBF8B21376B7505A9BA3F32@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240529094435.11140-1-shameerali.kolothum.thodi@huawei.com>
 <20240529094435.11140-2-shameerali.kolothum.thodi@huawei.com>
 <PH7PR11MB59417BE6DD3AE194C24E8367A3F32@PH7PR11MB5941.namprd11.prod.outlook.com>
 <e2637ebede1947d99549fe6db38325fb@huawei.com>
In-Reply-To: <e2637ebede1947d99549fe6db38325fb@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|BY1PR11MB7984:EE_
x-ms-office365-filtering-correlation-id: 1b0ae5e3-28e9-4672-6b77-08dc80b2be44
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?ZXVES3NRQUNCZmNtT0pDYWRtYkF4d0FiUGlkL3pLbmtkandhQ2E1TFZQTTJa?=
 =?utf-8?B?Q0IxbkJNZGZ4dkEzMnZvMS9aVkpVbmpXWVVQTGtyWGFiRnEyZzA5eVUra29t?=
 =?utf-8?B?NnhFdXZyM1greGpSSFdYVGJMZjQzQjArOFA1QUh5ZjlvV2FwSlJxc3NGNXlp?=
 =?utf-8?B?K1FRQWV2S2xIdTNwTnVyLzJIUHRoYTlZTE5ERHZJV3BDZWRCdEcxK3JKWTcv?=
 =?utf-8?B?RDU0REZndWErMm1XeHQzRTVYT1NTUTZ6a0ZKYXNoc2p2UzdyaGxrKytDQ3BN?=
 =?utf-8?B?Rk1tbTBEWFA4Z2gxenovNmtraUtqMThzS2pTb2pERWFYai96Qi9PTFBoRHhR?=
 =?utf-8?B?aEFLVnRQOWd0ZnNnTW5GZzFEZ3NHcHp0eWJGa0lvYkwvYUc4L0NsZGhwZHRo?=
 =?utf-8?B?OFNuWTU0ZzhPVVNyQndvVVA2cGlTZlk5ZVJuMWUxSXhDR2FqMkMwZGRvMVI3?=
 =?utf-8?B?NHh0cUhsSzQrSWlUMi9QMDZUbzFaWnZhbDBIakRVU2NsZE55eEVqZ21yT0xj?=
 =?utf-8?B?Ulhod3Y3bnJheDF0ZlRQRHVBRmxYR3hyRjhZQ3hYZENiSGVMK280RDVsalgv?=
 =?utf-8?B?WkExOUtFVkQ3N0VFbEw4VDB1bHZFeUJleE4zRVVkTUdRb1BRbk4wVnRtN2o4?=
 =?utf-8?B?azA3dWFRaGhRSDN0cXJTaC9ZUDR3a3BRTm1oZHJ3ekZ6ZTlrTTZqY01DQjBL?=
 =?utf-8?B?eFhtUHdBRGlMZVhLZHNlY09Ma0plQmk0dlNXTGpJd1JXaHkrZFQvSGN3eHVF?=
 =?utf-8?B?dGV5Y2haZGlJRVlSRmZGMXJjV3hHU2FoQjRSRDcyRWVNYnlMVW11QnJPWm1m?=
 =?utf-8?B?STJZWndtazREcjkwd20wbHR2bXpRWEcwa1J3MHpXK2xTd0FhWUFqRlN4UVNL?=
 =?utf-8?B?VjZjeXpON3pXS0U1U3VPaXUxSVNFMmxNcURjbmZreTMzc0xtVGJWTFIvelpF?=
 =?utf-8?B?RlRnU3ZVK3VjN3BldHViSlJZVGJQcWtxTnlKeFFRbEdvT0VKSkQ0ZmFKTVo4?=
 =?utf-8?B?aTQ5M0I2dVpFZ2sydDNacG1LdWtNamFSSWFOT1owVnc1UEdHak1NY2NiVFUw?=
 =?utf-8?B?T2dPT1c1UStoZGc2bzZpVzhCTGM5RHZySVhGQ1U0c1hHQnAzaDBWZWhQWGFY?=
 =?utf-8?B?OWVXdTJWTFhrWlAvL1R2dG9qeWc0ZWZiNVZrcnZsbWgySHpvOHk4TjZ3MDk3?=
 =?utf-8?B?S3BFODYvMm5WOUV5eVpMTzRwYkIrTmFEL2ZoSENFWmRiY2xiOXJjV1ArUFZr?=
 =?utf-8?B?aTFkMFN1UDNOM2pTRGgrUngycW82b0pQcVFET1B1MVd6cVQ5aEZ4d2dZTUov?=
 =?utf-8?B?a3l2aGR5V1drK0VLejRQZlc3alJlY2g1dFdBUWQwcDc0QWljMTF2b0tyUzRE?=
 =?utf-8?B?dys0RUlUc0tIMmxPM2pGREU1VGFHVGswMzJ5bDhaNE15aGhhZmkyNFFuU3Ez?=
 =?utf-8?B?RXdNNE81cTI4TEw0SUg3Y2lBMVYyV3d3bGkrTGZTZDNJcXIybDUwY2tqdllK?=
 =?utf-8?B?LzlRVTRsVVpwUnV3TzhFSitaMGJkNmU1OFVaYWYyUUZOT3gzS21wRTVLVzNy?=
 =?utf-8?B?c3Arb1ZMR2V3K0pqM21UL0VmYk0wUTU4d3dDOVBwbHdpYWN3dElzaVM3Sklj?=
 =?utf-8?B?WDB4N2k3R2IwQXR0RE9BYVkvenhuSTAyeXBxeGIvMUNmSXYvaDA5NXB0WFNy?=
 =?utf-8?B?aVh4OS9mM3lvQWI3ekZ1Mlg3Z0N6emIrUm93QTdrd2pac211WjdyZ09BPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eG51ZGdaN25pR01yZE1wbmp0RldXN25KOFcwZk5QS0M0bnRySFZmdnE5cE5K?=
 =?utf-8?B?MnIwb0ViSjZSa3QyZ1RzVUpTZEV6TVVMZnBTVU5oTzBta2pzTUtDRUFRU3lx?=
 =?utf-8?B?SGFvZjA0SEVnZWJXM1hsTWszKzArT0hmaUhjTllZSkNPYWtPTkpBVmhYRGg0?=
 =?utf-8?B?L2dDNUVFcWtJL0hRTEhUK08wVnd3WkFKSTZMbGhQUHV6SWQ0by9qbVVFVTFx?=
 =?utf-8?B?U3BuT3k3WjJUSzErL0NQRjYrdXphNHZJTzkvaEpCbHVFa0tDT1VxRXI3ZGpV?=
 =?utf-8?B?L0FaanNFOUZ2MlVPdE8rV1RDWUdwMVdudVpJWWxDaDk4WUtQLzU2QmlHOHZD?=
 =?utf-8?B?ZDl0eUpwSEJENHZlem43cDZYbzhzTEhRcGp6cDZNWFQ5VlRrc3RDV3J3bytJ?=
 =?utf-8?B?ZWpDdk9JNlM2Y1N0ay9GeXl6UHcxNDFQSytmc0o1VEF0b2wzNmRsSjFmVGlY?=
 =?utf-8?B?TXZ0SDd3WFNTNElNY0MwR3p6M0RKay9Tb1E1UzNtMTRTNzJQYXhKQXlpNnpr?=
 =?utf-8?B?U2NlQk15WnBZVDZUcG9RMG5FSG9zSGxtTUlmaXRWdm1kOHpTcVoxTFhlWDI3?=
 =?utf-8?B?VGdoYUxURllJWnRMaldCaVdZQmtOUW9ScTVHZzJMZ3lDdnFoQnUxMVp3cEV1?=
 =?utf-8?B?L1hpNGFaZUJQVCt4b2xxUU82WFhKUUJOcWxWRWNGZzBiY0JrS0dFSG9EYzIr?=
 =?utf-8?B?b0VnK2lhZW1wU2ljNjRMYXJEVklyMHBVaExaRDc1YzNKZTN1eUNGbStxNUJq?=
 =?utf-8?B?cGJXQ3luRjM2QWF0dkluQkJHUU9pUDNyTkdIL2JjN1d4ZFNVYUI3NVcvSGpq?=
 =?utf-8?B?WDJudW1GSUVFSmpjZlVkdFgxL2djaW5MVGU2OWxUTmVQOG4vMThyMXE2dzA0?=
 =?utf-8?B?Y09iaWRUZnBPWnJIS0dQcWlWazk4c2tpc1Jrc1RsSTVCbXFmYUZocU1HZ2s3?=
 =?utf-8?B?TEpLcHdjaU84SVFKU2VEZWh0S1haUWhqSHRhb1pYNk50dXkzRGF2dnlVUU1h?=
 =?utf-8?B?L3BlcnFxazZtMlkxNzhUSmV5RG1BYWFkTlZXQm1ndm9ScXp3YUJucWNkeDlN?=
 =?utf-8?B?SXdHeTZ5QnVIemdDOFhpdlNUNEN2bHo5WGlhUUhvWGVaUmpHUTh4NGlzVEZ6?=
 =?utf-8?B?MUJadFRzeFBJdVNWaGx5eVd2NjZCaVh1bFhXRkExcThaY0FpN0tOQ3o4WUI2?=
 =?utf-8?B?VDVBM1MrZzh2YWU3Smp5bGx0U2lrTmRXSGRheWtSbW1BYlRTdnUwWFRaTEhR?=
 =?utf-8?B?MUZpL1krenUrYjJOUnFpUkFxYjJTRFMzZit3T2cvL04rWVpWS1JXbGNnT0F0?=
 =?utf-8?B?ZjJVYzVTZFpxTzlmUnN3dlVrQ0ZwaS96RnBNKzU3YXlNRWJDSy9RQ2NXNDNu?=
 =?utf-8?B?a1lFaXN5MDIrNGVLTm84RW9qRklUaVNOM0ZIazdnMHAvRVBPekZMcGY3UVpK?=
 =?utf-8?B?czNlYmFpNk41RXJaYjc1M3o5OUN6blpIWVdFcjlGaVNEdzlGTkh6cmt6S3VY?=
 =?utf-8?B?QmU2T0RVMklYTVk2ejVWLzAzL09nTUNQY3RLMjQ2QW5EYVFQQmZ0ME54R3RJ?=
 =?utf-8?B?RmIrRTBoRHNkTDFzZy8zRmdLcHdTd21rdTlrN3JRdndNNk9uSmpFajZkWXN4?=
 =?utf-8?B?bHdiZ1FVZ0tORC9KU3VMMkVlMVA0RDFib3VSR1krNnQwREp1NUVMR2JscUg2?=
 =?utf-8?B?d1dIOFd6UmlFU3pzNEw2Y25jeGF2MUxOVlkvR3BOVmlHR1E1b3A2NEtRQXZ5?=
 =?utf-8?B?bEJDOUpxZjFNRnE4aUk0Y3Vpckd4NytJV3ZrNDhubGR2OFc5ZGVnd2RNVEpO?=
 =?utf-8?B?aUZDbzNLa1YxRzNnNTVEbVZWKzFlWFZFcCs2T3M3Ky8yeVFpTnRNMkxmZVVL?=
 =?utf-8?B?K3RJVXpjWFg2eXIwcTVPenZsYnUzUktXdVkvNkRQSDFPcHl4OXB2eVNRL0xy?=
 =?utf-8?B?TnAyUW5aWnc0RS9FZTFBOE52MnZSMTU4L01ObTNwVHRGcDVhZWVyUHlRa0p6?=
 =?utf-8?B?N1JidGhJdVRaMGdZdk1ucUlHSk9ENU01RlU3WFY5TnFGOWtYYnFvaStnRzFa?=
 =?utf-8?B?R3hCaXU5SHU4aWx4a2RENXFWcFNEUTREOE42UHk2Und3QWNYVGt6ZHdWdFUv?=
 =?utf-8?Q?Ax91NEF+giqXuyxwAXDZSLSAy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0ae5e3-28e9-4672-6b77-08dc80b2be44
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 14:13:56.4296 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SFSLoXcP//Sa+c+cIV6IskfGTey7yQDSvQcu6hvMBAqEmOex7PYqyxNEqRrR2DsFxxPP5ddZR965f4iQ/lqf0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB7984
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGFtZWVyYWxpIEtvbG90aHVt
IFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBNYXkgMzAsIDIwMjQgMTA6MDEgUE0NCj4gVG86IExpdSwgWXVhbjEgPHl1YW4xLmxp
dUBpbnRlbC5jb20+OyBwZXRlcnhAcmVkaGF0LmNvbTsgZmFyb3Nhc0BzdXNlLmRlDQo+IENjOiBx
ZW11LWRldmVsQG5vbmdudS5vcmc7IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgbGlu
d2Vua2FpIChDKQ0KPiA8bGlud2Vua2FpNkBoaXNpbGljb24uY29tPjsgemhhbmdmZWkuZ2FvQGxp
bmFyby5vcmc7IGh1YW5nY2hlbmdoYWkNCj4gPGh1YW5nY2hlbmdoYWkyQGh1YXdlaS5jb20+DQo+
IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMS83XSBkb2NzL21pZ3JhdGlvbjogYWRkIHVhZGsgY29tcHJl
c3Npb24gZmVhdHVyZQ0KPiANCj4gDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4gRnJvbTogTGl1LCBZdWFuMSA8eXVhbjEubGl1QGludGVsLmNvbT4NCj4gPiBTZW50OiBU
aHVyc2RheSwgTWF5IDMwLCAyMDI0IDI6MjUgUE0NCj4gPiBUbzogU2hhbWVlcmFsaSBLb2xvdGh1
bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tPjsNCj4gPiBwZXRl
cnhAcmVkaGF0LmNvbTsgZmFyb3Nhc0BzdXNlLmRlDQo+ID4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZzsgTGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+OyBsaW53ZW5rYWkgKEMpDQo+ID4g
PGxpbndlbmthaTZAaGlzaWxpY29uLmNvbT47IHpoYW5nZmVpLmdhb0BsaW5hcm8ub3JnOyBodWFu
Z2NoZW5naGFpDQo+ID4gPGh1YW5nY2hlbmdoYWkyQGh1YXdlaS5jb20+DQo+ID4gU3ViamVjdDog
UkU6IFtQQVRDSCAxLzddIGRvY3MvbWlncmF0aW9uOiBhZGQgdWFkayBjb21wcmVzc2lvbiBmZWF0
dXJlDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBT
aGFtZWVyIEtvbG90aHVtIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+
ID4gPiBTZW50OiBXZWRuZXNkYXksIE1heSAyOSwgMjAyNCA1OjQ0IFBNDQo+ID4gPiBUbzogcGV0
ZXJ4QHJlZGhhdC5jb207IGZhcm9zYXNAc3VzZS5kZTsgTGl1LCBZdWFuMQ0KPiA8eXVhbjEubGl1
QGludGVsLmNvbT4NCj4gPiA+IENjOiBxZW11LWRldmVsQG5vbmdudS5vcmc7IGxpbnV4YXJtQGh1
YXdlaS5jb207DQo+ID4gbGlud2Vua2FpNkBoaXNpbGljb24uY29tOw0KPiA+ID4gemhhbmdmZWku
Z2FvQGxpbmFyby5vcmc7IGh1YW5nY2hlbmdoYWkyQGh1YXdlaS5jb20NCj4gPiA+IFN1YmplY3Q6
IFtQQVRDSCAxLzddIGRvY3MvbWlncmF0aW9uOiBhZGQgdWFkayBjb21wcmVzc2lvbiBmZWF0dXJl
DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiA+ICtTaW5jZSBVQURLIHVzZXMgU2hhcmVkIFZpcnR1YWwg
QWRkcmVzc2luZyhTVkEpIGFuZCBkZXZpY2UgYWNjZXNzDQo+IHZpcnR1YWwNCj4gPiA+IG1lbW9y
eQ0KPiA+ID4gK2RpcmVjdGx5IGl0IGlzIHBvc3NpYmxlIHRoYXQgU01NVXYzIG1heSBlbm91bnRl
ciBwYWdlIGZhdWx0cyB3aGlsZQ0KPiA+ID4gd2Fsa2luZyB0aGUNCj4gPiA+ICtJTyBwYWdlIHRh
Ymxlcy4gVGhpcyBtYXkgaW1wYWN0IHRoZSBwZXJmb3JtYW5jZS4gSW4gb3JkZXIgdG8gbWl0aWdh
dGUNCj4gPiA+IHRoaXMsDQo+ID4gPiArcGxlYXNlIG1ha2Ugc3VyZSB0byBzcGVjaWZ5IGBgLW1l
bS1wcmVhbGxvY2BgIHBhcmFtZXRlciB0byB0aGUNCj4gPiA+IGRlc3RpbmF0aW9uIFZNDQo+ID4g
PiArYm9vdCBwYXJhbWV0ZXJzLg0KPiA+DQo+ID4gVGhhbmsgeW91IHNvIG11Y2ggZm9yIHB1dHRp
bmcgdGhlIElBQSBzb2x1dGlvbiBhdCB0aGUgdG9wIGFuZCBjYyBtZS4NCj4gPg0KPiA+IEkgdGhp
bmsgbWlncmF0aW9uIHBlcmZvcm1hbmNlIHdpbGwgYmUgYmV0dGVyIHdpdGggJy1tZW0tcHJlYWxs
b2MnDQo+IG9wdGlvbiwNCj4gPiBidXQgSSBhbSBjb25zaWRlcmluZyB3aGV0aGVyICctbWVtLXBy
ZWFsbG9jJyBpcyBhIG1hbmRhdG9yeSBvcHRpb24sIGZyb20NCj4gbXkNCj4gPiBleHBlcmllbmNl
LCBTVkEgcGVyZm9ybWFuY2UgZHJvcHMgbWFpbmx5IGNhdXNlZCBieSBJT1RMQiBmbHVzaCBhbmQg
SU8NCj4gcGFnZQ0KPiA+IGZhdWx0LA0KPiA+IEkgaGFkIHNvbWUgZGlzY3Vzc2lvbnMgd2l0aCBQ
ZXRlciBYdSBhYm91dCB0aGUgSU9UTEIgZmx1c2ggaXNzdWUsIGFuZCBpdA0KPiBoYXMNCj4gPiBi
ZWVuIGltcHJvdmVkLg0KPiA+IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9QSDdQUjExTUI1OTQx
RjA0RkJGQjk2NENCMkM5Njg4NjZBMzNFMkANCj4gPiBQSDdQUjExTUI1OTQxLm5hbXByZDExLnBy
b2Qub3V0bG9vay5jb20vDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBsaW5rLiBZZXMgSSBoYXZlIHNl
ZW4gdGhhdCBkaXNjdXNzaW9uIGFuZCB0aGlzIHNlcmllcyBpcyBvbg0KPiB0b3Agb2YgIHRoYXQN
Cj4gcGF0Y2ggZm9yIGF2b2lkaW5nIHRoZSB6ZXJvIHBhZ2UgcmVhZCBmYXVsdC4NCj4gDQo+ID4N
Cj4gPiBGb3IgSU8gcGFnZSBmYXVsdCwgdGhlIFFQTChJQUEgdXNlcnNwYWNlIGxpYnJhcnkpIGNh
biBwcm9jZXNzIHBhZ2UgZmF1bHQNCj4gPiByZXF1ZXN0IGluc3RlYWQgb2YgSU9NTVUsDQo+IA0K
PiBTb3JyeSBJIGRpZG4ndCBnZXQgdGhpcyBwYXJ0IGNvbXBsZXRlbHkuIFNvIGlmIHRoZSBwYWdl
IGZhdWx0IGhhcHBlbnMgaG93DQo+IHRoZSBsaWJyYXJ5DQo+IGNhbiBoYW5kbGUgaXQgd2l0aG91
dCBJT01NVT8gT3IgeW91IG1lYW50IGxpYnJhcnkgd2lsbCBkbyBtZW1vcnkNCj4gcGVyZmVjdGlu
ZyBiZWZvcmUNCj4gdG8gYXZvaWQgdGhlIHBhZ2UgZmF1bHQ/DQoNClllcywgd2hlbiB0aGUgSS9P
IHBhZ2UgZmF1bHQgaGFwcGVucywgdGhlIGhhcmR3YXJlIHdpbGwgcmV0dXJuIHRoZSBmYXVsdCBh
ZGRyZXNzDQp0byB0aGUgUVBMLCBRUEwgd2lsbCBwb3B1bGF0ZSB0aGUgbWVtb3J5IGFzIGJlbG93
LCB0aGVuIHJlc3VibWl0IHRoZSBqb2IgdG8NCmhhcmR3YXJlIGFnYWluLg0KDQppZiAoQURfU1RB
VFVTX1JFQURfUEFHRV9GQVVMVCA9PSBjb21wbGV0aW9uX3JlY29yZF9wdHItPnN0YXR1cykgew0K
ICAgIHZvbGF0aWxlIGNoYXIqIHJlYWRfZmF1bHRfYWRkcmVzcyA9IChjaGFyICopZmF1bHRfYWRk
cmVzczsNCiAgICAqcmVhZF9mYXVsdF9hZGRyZXNzOw0KfSANCmVsc2UgeyAvLyBBRF9TVEFUVVNf
V1JJVEVfUEFHRV9GQVVMVA0KICAgIHZvbGF0aWxlIGNoYXIqIHdyaXRlX2ZhdWx0X2FkZHJlc3Mg
PSAoY2hhciAqKWZhdWx0X2FkZHJlc3M7DQogICAgKndyaXRlX2ZhdWx0X2FkZHJlc3MgPSAqd3Jp
dGVfZmF1bHRfYWRkcmVzczsNCn0NCg0KPiAgaXQgbWVhbnMgd2UgY2FuIGRpc2FibGUgdGhlIEkv
TyBwYWdlIGZhdWx0IGZlYXR1cmUNCj4gPiBvbiB0aGUgSUFBIGRldmljZSwgYW5kIGxldCB0aGUg
ZGV2aWNlIHN0aWxsIHVzZSBTVkEgdGVjaG5vbG9neSB0byBhdm9pZA0KPiBtZW1vcnkNCj4gPiBj
b3B5Lg0KPiA+DQo+ID4gSSB3aWxsIHByb3ZpZGUgdGhlIHRlc3QgcmVzdWx0cyBpbiBteSBuZXh0
IHZlcnNpb24sIGRvIHlvdSBoYXZlIGFueQ0KPiBpZGVhcyBvcg0KPiA+IHN1Z2dlc3Rpb25zIGFi
b3V0IHRoaXMsIHRoYW5rcy4NCj4gDQo+IEkgdGhpbmsgb3VyIFVBREsgdGVzdCB0b29sIGhhZCBh
biBvcHRpb24gdG8gcHJlZmVjdCB0aGUgbWVtb3J5KHdyaXRlIHNvbWUNCj4gcmFuZG9tIGRhdGEN
Cj4gdG8gbWVtb3J5KSB0byBhdm9pZCBwYWdlIGZhdWx0IHBlbmFsdHkuIEkgYW0gbm90IHN1cmUg
dGhhdCBpcyBleHBvc2VkDQo+IHRocm91Z2ggdGhlIEFQSSBvciBub3QuDQo+IEkgd2lsbCBjaGVj
ayB3aXRoIG91ciBVQURLIHRlYW0uDQo+IA0KPiBQbGVhc2UgZG8gQ0MgbWUgd2hlbiB5b3UgcG9z
dCB5b3VyIG5leHQgcmV2aXNpb24uDQoNClN1cmUNCg0KPiBUaGFua3MsDQo+IFNoYW1lZXINCg==

