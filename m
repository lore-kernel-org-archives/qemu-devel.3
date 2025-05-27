Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72000C5AE59
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 02:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJjri-00051T-Vs; Mon, 26 May 2025 22:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uJjrg-00051F-M4
 for qemu-devel@nongnu.org; Mon, 26 May 2025 22:16:28 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uJjre-0005TI-HZ
 for qemu-devel@nongnu.org; Mon, 26 May 2025 22:16:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748312186; x=1779848186;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=C+XDbyA8ylC4wQLyeYp1X44dFjrZCtFV77gpWmY7Hsc=;
 b=KKadPCyAckkwBxLGowQ6bxIP3BjmCGLK/UA03ot6b0eSJkkCVJgy2K7z
 Y+yxYqiFUbhbg2Uq0/ZisqAcveTwi6p6lSGYCievGVb1Bjj9smtmu2KaR
 rb/ypqfMgtLt/mVghtO6sc0YOHgZQwOyLjJ9AxHyHSzwkPZkf30WxvbAN
 3UYFvkIKH8bx1rlwpe4FeGQbcpabx70N2woi4e0BcrQ+XoTl7tlDOD1Jm
 cZM7CC4+Cq3TVMArS6CsS0G+cq3YRFW5dKy+NYVwT7fYA19Wm5jKtnOCi
 gMwgL3bZudCjWOnG8SzuI0oftnxjpYSl4fLuWLbVVA45ShiMpzBMe/IZ0 A==;
X-CSE-ConnectionGUID: QeZ5vrCbQ02Ly4WaqpHCuQ==
X-CSE-MsgGUID: o6xpgYuTR3CUqnZpG48RMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="67696882"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="67696882"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 19:16:24 -0700
X-CSE-ConnectionGUID: Z4VlViFrSfOZPNkoPBhMZA==
X-CSE-MsgGUID: 3F9ebWFZRiGVd1N0DSLnnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; d="scan'208";a="143042265"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2025 19:16:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 26 May 2025 19:16:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 26 May 2025 19:16:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.86)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 26 May 2025 19:16:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1LIKuoF/Rw7r9YDnoSygtdHNtn2vqN38FNhpeWPwXBdbrDopduU81g0yasFTlkgIVlGMR3pJ1c/kpn+oIbSPepN7CiXjHDhzrhfrC6lH80HsIo4qurAmAOQCC2woPDfWDGL4LPU1IasS5NP84Bz5RjDPugpKjG1yEZNlTHkf079E1DiOokWxo7FC4SCRCRX+/rRd9He3KnLdP+6LisrvzKr12SfAcnmDPklsckpWs8iPv322eYoo0rDj8D0H5Gxt7w6O5PhJwWHVgzNFw7CbQAdru8fzsY72o4UD6n5CPeYEGowV/heY6HbxQNXZdwmNK4Chwf/DufMofha9nZzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+XDbyA8ylC4wQLyeYp1X44dFjrZCtFV77gpWmY7Hsc=;
 b=x5Cf/KaMtQDdF5PbW+g3z1mmDluve8xydLCJ+UD9NJs3PHnBWAm1HT/vx2ah9eAEprBGDmJ1xptBFUNsoYAxDeibDjtZi5HI3oKWdSugk0E+omC3/zXYG1oSVNdwiYkOMyVhsF4JLWKfBPcNAFy2eNm7E7uNAKuKwS04TVMe4ICwv2EaMRaBh03M8AhK2lw0cjCqaFHeGDGO7DwCvyogmQmMay9uxmBPbLQoLhVlTBPq3f555m7AsC3OKKwUaCyRka3e+deTsPUhizOSasD6lV9P9O+AQKLc+K3Zze4KplPAs95zk9ITG7UcgtLHtz4ivqnAs1pTUqNc7s7f8UcFCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB6829.namprd11.prod.outlook.com (2603:10b6:510:22f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Tue, 27 May
 2025 02:16:06 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8769.021; Tue, 27 May 2025
 02:16:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv3 00/21] intel_iommu: Enable stage-1 translation for
 passthrough device
Thread-Topic: [PATCH rfcv3 00/21] intel_iommu: Enable stage-1 translation for
 passthrough device
Thread-Index: AQHbykIhat6YuWW4iUy/zgTf90XUSLPk3EUAgADozDA=
Date: Tue, 27 May 2025 02:16:06 +0000
Message-ID: <SJ0PR11MB6744985FCDC4D2CC8E1FBFCC9264A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <946512ca-7fb6-4d56-a1f7-c14e507c00e4@redhat.com>
In-Reply-To: <946512ca-7fb6-4d56-a1f7-c14e507c00e4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB6829:EE_
x-ms-office365-filtering-correlation-id: d7ebe929-246d-4059-19a2-08dd9cc47010
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?QWZkeUpLeSt6Q0VjM1F3cU43WU1UOVV3YzhPNUk2MHFldnA1UEl5aEZURDBN?=
 =?utf-8?B?TGtTRTBXWk9YSklySmxIdERIZk5SUlY5akp4MW1lUnJCandleHhRbmdMK2x4?=
 =?utf-8?B?MGF3QjlGUjR6eHBZLzdpZTR4aHdvMDI2S3lnQ0NRY0RCRXlOMTlSZjRnc0FQ?=
 =?utf-8?B?MVJZRTdobHBZMms0aXlTVnFDczZLcFZRSktUU0Jmc21ZZGh0a0tLYmpPdlhW?=
 =?utf-8?B?ZGd6dEl6WXAyNWp5WW91d3pOUmgvWVI3dGMxNzFyTVoyeUJ4ZGtsUXBKYlZj?=
 =?utf-8?B?RjdPOWlBaEJZWjErdlJFWmxINmVtVkoyY24yalVvYUQ2UlA3R3U5eHBaTkhz?=
 =?utf-8?B?NXBmUGQrZ2Fubzdwc2RpZGpuKzJkZm5oMkZsWVgyWTFZUkRRczkzNVM2YlBh?=
 =?utf-8?B?bXpJa2FaclRrdGZDaXpkVEVZNEFQdHdpTlpKN0VTNGtDK1ZLSnh2SkhHa3l5?=
 =?utf-8?B?VTJaWFpBeFlMUExkckdiRUlQd1VleSs4bFZ1Mk5LblQrSkYycjRCMnB0RG9Z?=
 =?utf-8?B?WDQ3TnJKYUtsK2JaWDUzWHFuSFhBN25YZUNmL25mQVZiUFZkQXFsR05SMkR4?=
 =?utf-8?B?UGhua0NFTjZha2lsOEZNMzVkVUxoR3J1dktHdWpuVEhsV0RtMC9Ydk5GM3lj?=
 =?utf-8?B?d2lGK2kvcDBUYW9SSERZRHlVcjEwRnc1SkFWMHJnKytjY0g5a082ZnJiQmpo?=
 =?utf-8?B?OVd4cDc5K2tZcWtVNFBmRDNrczR1YkNBczlnN1lIMlJkVndoTUcxcWVUcTAy?=
 =?utf-8?B?a0JjY1hubXdyRGRNYWhQUHU2K05TRWJZK2VUd3hmTXFxSUs2a2pKbWladUxI?=
 =?utf-8?B?T2NaYTJBcmwrVWljdndod2p1cy9nT1pxR0NWMDh5ZjFHWTBUeHIzeVBOOUJv?=
 =?utf-8?B?ZGdsaUYwbktHcnY2eFVzOHl4QWNyaUJiRWY3QTY4VkxJTHJWV3pYeEo1SWpv?=
 =?utf-8?B?MnhxQStyRzJhQXE5UDRmRCtpRjRBZ3FPaUNDYzR5akQ0MFFUajhrbHpOY0Yy?=
 =?utf-8?B?RUZ1NzRqRkxBbEgybDIzWlUzYkhFQ29lbkRMWW9qa2RZRHMvNHZmZFo5QUt3?=
 =?utf-8?B?UmJpdlRXT3RsYzNUTEVNR1hKTnl1NUliMTZ3eGJZZEJBcVVTRERMQXdwTTdS?=
 =?utf-8?B?MWF1L1pMZ1RjbmY4MS9CVXdRaFMrOHZyaUVQVGs4QlhWRTZUVzI5U1QyamEz?=
 =?utf-8?B?TjAwS3kwdmhwSEVrNmxRNmtXU3FmTDlNdXRFY3RMQjhveFAzUm1wTnJXYmdV?=
 =?utf-8?B?WG9FOXc4bFVxTFNnMVV3aWFoUW1FOGxITEpWWHRxckNqTnYvcTdCQ2tjQWYw?=
 =?utf-8?B?MFkrVDczSDRudVNLOG9yUGpLdEFjRHdFVFRaNUlEcDEwZ0RibVNVRGVtUXpm?=
 =?utf-8?B?c3lzN3RvdVdwTHhGNTFmSmh6RGo0dXBsVlNaek8walJGTUlwM2RxRlFxay9N?=
 =?utf-8?B?bkZkc1JkUGttK2czSkNlUW51c0ZEZEl2anEwN3lFUnU0Q0VpOEQxT0FDK2pT?=
 =?utf-8?B?VG5VWFlCWCtXS1RNY0pWUWU3SjU3L29YVDdpZ1BQNXRjTXRRZlFoVXl2d3pz?=
 =?utf-8?B?WGVPZEJ4R3JHVnpVQWhHVzRmS1VBMEZab2huWGtlODFoNjNRRWZ2WGRqdzFy?=
 =?utf-8?B?Z095S085VG0yNmZMZHVoN1BRQlcvWm44NjN4VStyUE52WG94TlhXZ25NSldt?=
 =?utf-8?B?V0VtZTFPQkFMeXR3QW1nd3Bnc3BaMVpST20xMEVaOVk5T2ViYjRBZnJNUklj?=
 =?utf-8?B?RTBGcGJuQklQTXhyT0JwbnhQNWhJSGFzYldoUFF3VU5oK2Jtc0I2aWxrRlRk?=
 =?utf-8?B?eXNBNUtMV1N0Z0hlVDlVTHErMlNtY01tSlFpOVdSMitQd3l3eDhHOCtnQ1Fl?=
 =?utf-8?B?T1ROcmtBdUswVjdDbS9lL0dEYzdjQUdzNGFhUUpBZDJqVmFCSHp0VHJKYmlo?=
 =?utf-8?B?bkhnZ0JhRlowSW95MFpyM3JzZzdnT3NpWk5BclN6UEx2ZmVKTm1WNkNRay9n?=
 =?utf-8?Q?pLqXzK1aVLTKHbPOAGVlf7zJ9CnFyI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWZiK2V0RVUrMmZpenR1K3NENXRud1V5ZkVTZmFiNHpDaldaa3pDZjllaFBN?=
 =?utf-8?B?NE9LSFh3U29DZHlNWmc1cUl6YkJxdXJGTHFMTkpJa1hzdUNGdHRGcXp6YkV2?=
 =?utf-8?B?WHk4SHJ0a3hWVUVnTTMrUi9pKzkvU0cwdDcrOU9RTDgzQnZyT1RlUnh0cHM1?=
 =?utf-8?B?K1IxTUM1aVVtNFYxSTdIeHhTaHFRei96ODhZUGV1SkZNQS9sNXRRMTUzakF0?=
 =?utf-8?B?TmxDTFpFUURRdUkzdDhOZmlicm5qTFdrOVlGaTdKUmw4YXloOXhmVERhM1NE?=
 =?utf-8?B?V3hNMTU0akpmNCtjeVhKM1B0QVVNYzBiU0VGMXQzV0xPbmxUaVhsaXhxa1kv?=
 =?utf-8?B?RTlrNDdFeXlOMmswaEpKU1JSYTEyWk5OcEVnUmRZd0NuUmJrUDQ2VHo5ak5l?=
 =?utf-8?B?dUtiNERwYUxOc0R6dk5pNVN6b1I2UUlNNlZBVTFkWVREeVNDOG5telQxUkVG?=
 =?utf-8?B?eGM2eWsxZkF4V2NZTlljWEVKRk1RS1pYeUJJTFgyRzV1dWU5UDZCK25RQ1hJ?=
 =?utf-8?B?dUFvRllmajRiKzNCNVVUd0FFT0Z0RmRSaDE0QnpuejQyaVpOMklwL2RMTWtm?=
 =?utf-8?B?MEh0S2F3VjFaWE5oUDRGeHhGZGdGTXNsWTJpZ2hObXFUY0pyc0hKRTlpSTN0?=
 =?utf-8?B?WUp2SHZaK0lUd2czazhmaXN2djNGSUxqaTRGMFlQcytSQkFucndxK3dPUGYz?=
 =?utf-8?B?eHRQTStSUTZqcXJuWlA2SGd4UU1SNU93UmcxZFVESEkrYXB6emFUTzRYTkZ0?=
 =?utf-8?B?dC9hVDAyVUF4NzFLbTkzQVMwOWsxdFhSWllzMGNvWGZEZVY1UC9xSnUvZWxU?=
 =?utf-8?B?WWYwVFdoUUFPYkdtcnRZS3BuRUxncFVRSUh3ZGZ3ZTZoKzBsUTQzSmswajZi?=
 =?utf-8?B?bW1xTTlCZzJrVEw0aUNMUzQzQkZReU13Y3pwV1VPNjRGYXhsNTZDWmVXNUcy?=
 =?utf-8?B?MkIwT2NaKzh1ajBGQisrYW84bHZMTjEreFlRSHdxcDFWUWI1a2w0UWkwRm5D?=
 =?utf-8?B?S2t0UkRxMXNKaStITFBaTnk3SzRsV0lCcG8yQ1FBbHNyTHExRUR2QjJ4djQ2?=
 =?utf-8?B?RVQ4cnM5cXhTNmFlTFV3cTZhNFZ6aWxrb0o2Q0Y2VnE2WG1iK3orQjhHckZw?=
 =?utf-8?B?Q0FLeEI5OW92RlpqNWVlWFRPd1hHYkxCZmR6NE5qR1ZIaFlkNk5IU0Uzd3Ri?=
 =?utf-8?B?VEdyRnlkVTRmem05WGRWL0JZL3BzUjRFaWM5NGFzZVdSOTg3WXZpSExIZmly?=
 =?utf-8?B?TnNsTUZQbWZEbnRqUHpnYUJVMHc1R3drWStTcjEzUTMxSkdCOTB0dWdaSjhj?=
 =?utf-8?B?clZ3TW1hOFA3SElKUEdiOXE3UEJwM1VNdDY4SE5ZNW1aT1BMbnAxeG5yMVJK?=
 =?utf-8?B?UEhzUXlwT3VLUWFvZGxYckJIeWxQZWNBcnJHcjNzTFZLMW5jMXdKcVBNUS9V?=
 =?utf-8?B?MGFoYXVyZDhZeFBmZmc3WlpTMEJiQ0dIdUVia0wvZWtLU2ZtZm9ReHlUWE4r?=
 =?utf-8?B?bDBHSDlBa1NvckpzOHlWSnM5Y0RjNmRlZElrODRhaWpPa0JpR3dnZDdOUkxp?=
 =?utf-8?B?UmlVT2tVUTJ2endMU3BlZmYwZm1VemY5eUl0SThlZkFwcGtGbkxIcVpwV0tN?=
 =?utf-8?B?Um1acUNhSjQ5VDV5T1c0Z21zR2JXMlYrZER4dXZJQVlyOGI2ZTVTTnhhb1R5?=
 =?utf-8?B?aW5qbEEyMTJpaTdLR2hOazlZNUlQcXBXZmxDQW9pVnFnZno5WVVlZVNmY2Qy?=
 =?utf-8?B?bUJlUkNnMFFlZXlIc1REMlhZU0ZYYlJOZ0ExVnJxRXZaU200K0JUUFpTNzFn?=
 =?utf-8?B?alc2b21BZ2FTRkU5MnhoVXVJN1lNUEVGQjlNZm9TenNrWUlRd3ExZ2RkbTNq?=
 =?utf-8?B?L2hZTC9QR1FjRUxnbEsvTWsrbzhkMlhUeEJpb3ZTLzZmZmt0bE8vNFc1K1pm?=
 =?utf-8?B?WFRNZXV1Q05JU0V1MkgrVDRTbCs0WHlFb3ZnclRhZjVBdHdGb2p0NGFmV0pL?=
 =?utf-8?B?bG05VGxNZUdZQUFLUDZTUXdoUVZNUDlkRnBPK21UL2JQWVp5YmRGRVhuTlFm?=
 =?utf-8?B?SlVxQy9QNEUxUmM3UXBVblFDZnpteEc1NlYvZ0ZEQ0d5Z05wYjhFejhUcEND?=
 =?utf-8?Q?vq0ImixtNqSw/vSJL+smjmAw1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ebe929-246d-4059-19a2-08dd9cc47010
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 02:16:06.3918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mZDIbtGu/7luRVCCYV/dLOQoClx3xHvTpstWPmtC7t3gnE2vhGnnm2SP5k2+V0j7IgLfGjgOahgvZbUOtnl61ay8sn7oyf4P1NNr0hM20Lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6829
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YzIDAwLzIxXSBpbnRl
bF9pb21tdTogRW5hYmxlIHN0YWdlLTEgdHJhbnNsYXRpb24gZm9yDQo+cGFzc3Rocm91Z2ggZGV2
aWNlDQo+DQo+T24gNS8yMS8yNSAxMzoxNCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBIaSwN
Cj4+DQo+PiBQZXIgSmFzb24gV2FuZydzIHN1Z2dlc3Rpb24sIGlvbW11ZmQgbmVzdGluZyBzZXJp
ZXNbMV0gaXMgc3BsaXQgaW50bw0KPj4gIkVuYWJsZSBzdGFnZS0xIHRyYW5zbGF0aW9uIGZvciBl
bXVsYXRlZCBkZXZpY2UiIHNlcmllcyBhbmQNCj4+ICJFbmFibGUgc3RhZ2UtMSB0cmFuc2xhdGlv
biBmb3IgcGFzc3Rocm91Z2ggZGV2aWNlIiBzZXJpZXMuDQo+Pg0KPj4gVGhpcyBzZXJpZXMgaXMg
Mm5kIHBhcnQgZm9jdXNpbmcgb24gcGFzc3Rocm91Z2ggZGV2aWNlLiBXZSBkb24ndCBkbw0KPj4g
c2hhZG93aW5nIG9mIGd1ZXN0IHBhZ2UgdGFibGUgZm9yIHBhc3N0aHJvdWdoIGRldmljZSBidXQg
cGFzcyBzdGFnZS0xDQo+PiBwYWdlIHRhYmxlIHRvIGhvc3Qgc2lkZSB0byBjb25zdHJ1Y3QgYSBu
ZXN0ZWQgZG9tYWluLiBUaGVyZSB3YXMgc29tZQ0KPj4gZWZmb3J0IHRvIGVuYWJsZSB0aGlzIGZl
YXR1cmUgaW4gb2xkIGRheXMsIHNlZSBbMl0gZm9yIGRldGFpbHMuDQo+Pg0KPj4gVGhlIGtleSBk
ZXNpZ24gaXMgdG8gdXRpbGl6ZSB0aGUgZHVhbC1zdGFnZSBJT01NVSB0cmFuc2xhdGlvbg0KPj4g
KGFsc28ga25vd24gYXMgSU9NTVUgbmVzdGVkIHRyYW5zbGF0aW9uKSBjYXBhYmlsaXR5IGluIGhv
c3QgSU9NTVUuDQo+PiBBcyB0aGUgYmVsb3cgZGlhZ3JhbSBzaG93cywgZ3Vlc3QgSS9PIHBhZ2Ug
dGFibGUgcG9pbnRlciBpbiBHUEENCj4+IChndWVzdCBwaHlzaWNhbCBhZGRyZXNzKSBpcyBwYXNz
ZWQgdG8gaG9zdCBhbmQgYmUgdXNlZCB0byBwZXJmb3JtDQo+PiB0aGUgc3RhZ2UtMSBhZGRyZXNz
IHRyYW5zbGF0aW9uLiBBbG9uZyB3aXRoIGl0LCBtb2RpZmljYXRpb25zIHRvDQo+PiBwcmVzZW50
IG1hcHBpbmdzIGluIHRoZSBndWVzdCBJL08gcGFnZSB0YWJsZSBzaG91bGQgYmUgZm9sbG93ZWQN
Cj4+IHdpdGggYW4gSU9UTEIgaW52YWxpZGF0aW9uLg0KPj4NCj4+ICAgICAgICAgIC4tLS0tLS0t
LS0tLS0tLiAgLi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS4NCj4+ICAgICAgICAgIHwgICB2
SU9NTVUgICAgfCAgfCBHdWVzdCBJL08gcGFnZSB0YWJsZSAgICAgIHwNCj4+ICAgICAgICAgIHwg
ICAgICAgICAgICAgfCAgJy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLScNCj4+ICAgICAgICAg
IC4tLS0tLS0tLS0tLS0tLS0tLw0KPj4gICAgICAgICAgfCBQQVNJRCBFbnRyeSB8LS0tIFBBU0lE
IGNhY2hlIGZsdXNoIC0tKw0KPj4gICAgICAgICAgJy0tLS0tLS0tLS0tLS0nICAgICAgICAgICAg
ICAgICAgICAgICAgfA0KPj4gICAgICAgICAgfCAgICAgICAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICAgVg0KPj4gICAgICAgICAgfCAgICAgICAgICAgICB8ICAgICAgICAgICBJL08gcGFn
ZSB0YWJsZSBwb2ludGVyIGluIEdQQQ0KPj4gICAgICAgICAgJy0tLS0tLS0tLS0tLS0nDQo+PiAg
ICAgIEd1ZXN0DQo+PiAgICAgIC0tLS0tLXwgU2hhZG93IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS18LS0tLS0tLS0NCj4+ICAgICAgICAgICAgdiAgICAgICAgdiAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHYNCj4+ICAgICAgSG9zdA0KPj4gICAgICAgICAgLi0tLS0tLS0tLS0tLS0uICAu
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLg0KPj4gICAgICAgICAgfCAgIHBJT01NVSAgICB8ICB8
IFN0YWdlMSBmb3IgR0lPVkEtPkdQQSAgfA0KPj4gICAgICAgICAgfCAgICAgICAgICAgICB8ICAn
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tJw0KPj4gICAgICAgICAgLi0tLS0tLS0tLS0tLS0tLS0v
ICB8DQo+PiAgICAgICAgICB8IFBBU0lEIEVudHJ5IHwgICAgIFYgKE5lc3RlZCB4bGF0ZSkNCj4+
ICAgICAgICAgICctLS0tLS0tLS0tLS0tLS0tXC4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS4NCj4+ICAgICAgICAgIHwgICAgICAgICAgICAgfCAgIHwgU3RhZ2UyIGZvciBH
UEEtPkhQQSwgdW5tYW5hZ2VkIGRvbWFpbnwNCj4+ICAgICAgICAgIHwgICAgICAgICAgICAgfCAg
ICctLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLScNCj4+ICAgICAgICAgICct
LS0tLS0tLS0tLS0tJw0KPj4gRm9yIGhpc3RvcnkgcmVhc29uLCB0aGVyZSBhcmUgZGlmZmVyZW50
IG5hbWluZ3MgaW4gZGlmZmVyZW50IFZURCBzcGVjIHJldiwNCj4+IFdoZXJlOg0KPj4gICAtIFN0
YWdlMSA9IEZpcnN0IHN0YWdlID0gRmlyc3QgbGV2ZWwgPSBmbHRzDQo+PiAgIC0gU3RhZ2UyID0g
U2Vjb25kIHN0YWdlID0gU2Vjb25kIGxldmVsID0gc2x0cw0KPj4gPEludGVsIFZULWQgTmVzdGVk
IHRyYW5zbGF0aW9uPg0KPj4NCj4+IFRoZXJlIGFyZSBzb21lIGludGVyYWN0aW9ucyBiZXR3ZWVu
IFZGSU8gYW5kIHZJT01NVQ0KPj4gKiB2SU9NTVUgcmVnaXN0ZXJzIFBDSUlPTU1VT3BzIFtzZXR8
dW5zZXRdX2lvbW11X2RldmljZSB0byBQQ0kNCj4+ICAgIHN1YnN5c3RlbS4gVkZJTyBjYWxscyB0
aGVtIHRvIHJlZ2lzdGVyL3VucmVnaXN0ZXIgSG9zdElPTU1VRGV2aWNlDQo+PiAgICBpbnN0YW5j
ZSB0byB2SU9NTVUgYXQgdmZpbyBkZXZpY2UgcmVhbGl6ZSBzdGFnZS4NCj4+ICogdklPTU1VIGNh
bGxzIEhvc3RJT01NVURldmljZUlPTU1VRkQgaW50ZXJmYWNlIFthdHxkZV10YWNoX2h3cHQNCj4+
ICAgIHRvIGJpbmQvdW5iaW5kIGRldmljZSB0byBJT01NVUZEIGJhY2tlZCBkb21haW5zLCBlaXRo
ZXIgbmVzdGVkDQo+PiAgICBkb21haW4gb3Igbm90Lg0KPj4NCj4+IFNlZSBiZWxvdyBkaWFncmFt
Og0KPj4NCj4+ICAgICAgICAgIFZGSU8gRGV2aWNlICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgSW50ZWwgSU9NTVUNCj4+ICAgICAgLi0tLS0tLS0tLS0tLS0tLS0tLiAgICAgICAgICAg
ICAgICAgICAgICAgICAuLS0tLS0tLS0tLS0tLS0tLS0tLS4NCj4+ICAgICAgfCAgICAgICAgICAg
ICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgIHwNCj4+
ICAgICAgfCAgICAgICAuLS0tLS0tLS0tfFBDSUlPTU1VT3BzICAgICAgICAgICAgICB8Li0tLS0t
LS0tLS0tLS0uICAgIHwNCj4+ICAgICAgfCAgICAgICB8IElPTU1VRkQgfChzZXRfaW9tbXVfZGV2
aWNlKSAgICAgICB8fCBIb3N0IElPTU1VICB8ICAgIHwNCj4+ICAgICAgfCAgICAgICB8IERldmlj
ZSAgfC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLT58fCBEZXZpY2UgbGlzdCB8ICAgIHwNCj4+ICAg
ICAgfCAgICAgICAuLS0tLS0tLS0tfCh1bnNldF9pb21tdV9kZXZpY2UpICAgICB8Li0tLS0tLS0t
LS0tLS0uICAgIHwNCj4+ICAgICAgfCAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICB8ICAgICAgIHwgICAgICAgICAgIHwNCj4+ICAgICAgfCAgICAgICAgICAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgIFYgICAgICAgICAgIHwNCj4+ICAgICAg
fCAgICAgICAuLS0tLS0tLS0tfCAgSG9zdElPTU1VRGV2aWNlSU9NTVVGRCB8ICAuLS0tLS0tLS0t
LS0tLS4gIHwNCj4+ICAgICAgfCAgICAgICB8IElPTU1VRkQgfCAgICAgICAgICAgIChhdHRhY2hf
aHdwdCl8ICB8IEhvc3QgSU9NTVUgIHwgIHwNCj4+ICAgICAgfCAgICAgICB8IGxpbmsgICAgfDwt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18ICB8ICAgRGV2aWNlICAgIHwgIHwNCj4+ICAgICAgfCAg
ICAgICAuLS0tLS0tLS0tfCAgICAgICAgICAgIChkZXRhY2hfaHdwdCl8ICAuLS0tLS0tLS0tLS0t
LS4gIHwNCj4+ICAgICAgfCAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAgICAgIHwgICAgICAgICAgIHwNCj4+ICAgICAgfCAgICAgICAgICAgICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgICAgIC4uLiAgICAgICAgIHwNCj4+ICAgICAgLi0tLS0t
LS0tLS0tLS0tLS0tLiAgICAgICAgICAgICAgICAgICAgICAgICAuLS0tLS0tLS0tLS0tLS0tLS0t
LS4NCj4+DQo+PiBCYXNlZCBvbiBZaSdzIHN1Z2dlc3Rpb24sIHRoaXMgZGVzaWduIGlzIG9wdGlt
YWwgaW4gc2hhcmluZyBpb2FzL2h3cHQNCj4+IHdoZW5ldmVyIHBvc3NpYmxlIGFuZCBjcmVhdGUg
bmV3IG9uZSBvbiBkZW1hbmQsIGFsc28gc3VwcG9ydHMgbXVsdGlwbGUNCj4+IGlvbW11ZmQgb2Jq
ZWN0cyBhbmQgRVJSQVRBXzc3MjQxNS4NCj4+DQo+PiBFLmcuLCBVbmRlciBvbmUgZ3Vlc3QncyBz
Y29wZSwgU3RhZ2UtMiBwYWdlIHRhYmxlIGNvdWxkIGJlIHNoYXJlZCBieSBkaWZmZXJlbnQNCj4+
IGRldmljZXMgaWYgdGhlcmUgaXMgbm8gY29uZmxpY3QgYW5kIGRldmljZXMgbGluayB0byBzYW1l
IGlvbW11ZmQgb2JqZWN0LA0KPj4gaS5lLiBkZXZpY2VzIHVuZGVyIHNhbWUgaG9zdCBJT01NVSBj
YW4gc2hhcmUgc2FtZSBzdGFnZS0yIHBhZ2UgdGFibGUuIElmDQo+dGhlcmUNCj4+IGlzIGNvbmZs
aWN0LCBpLmUuIHRoZXJlIGlzIG9uZSBkZXZpY2UgdW5kZXIgbm9uIGNhY2hlIGNvaGVyZW5jeSBt
b2RlIHdoaWNoIGlzDQo+PiBkaWZmZXJlbnQgZnJvbSBvdGhlcnMsIGl0IHJlcXVpcmVzIGEgc2Vw
YXJhdGUgc3RhZ2UtMiBwYWdlIHRhYmxlIGluIG5vbi1DQyBtb2RlLg0KPj4NCj4+IFNQUiBwbGF0
Zm9ybSBoYXMgRVJSQVRBXzc3MjQxNSB3aGljaCByZXF1aXJlcyBubyByZWFkb25seSBtYXBwaW5n
cw0KPj4gaW4gc3RhZ2UtMiBwYWdlIHRhYmxlLiBUaGlzIHNlcmllcyBzdXBwb3J0cyBjcmVhdGlu
ZyBWVERJT0FTQ29udGFpbmVyDQo+PiB3aXRoIG5vIHJlYWRvbmx5IG1hcHBpbmdzLiBJZiB0aGVy
ZSBpcyBhIHJhcmUgY2FzZSB0aGF0IHNvbWUgSU9NTVVzDQo+PiBvbiBhIG11bHRpcGxlIElPTU1V
IGhvc3QgaGF2ZSBFUlJBVEFfNzcyNDE1IGFuZCBvdGhlcnMgbm90LCB0aGlzDQo+PiBkZXNpZ24g
Y2FuIHN0aWxsIHN1cnZpdmUuDQo+Pg0KPj4gU2VlIGJlbG93IGV4YW1wbGUgZGlhZ3JhbSBmb3Ig
YSBmdWxsIHZpZXc6DQo+Pg0KPj4gICAgICAgIEludGVsSU9NTVVTdGF0ZQ0KPj4gICAgICAgICAg
ICAgICB8DQo+PiAgICAgICAgICAgICAgIFYNCj4+ICAgICAgLi0tLS0tLS0tLS0tLS0tLS0tLS4g
ICAgLi0tLS0tLS0tLS0tLS0tLS0tLS4gICAgLi0tLS0tLS0tLS0tLS0tLS0tLS0uDQo+PiAgICAg
IHwgVlRESU9BU0NvbnRhaW5lciB8LS0tPnwgVlRESU9BU0NvbnRhaW5lciB8LS0tPnwgVlRESU9B
U0NvbnRhaW5lciAgfC0tDQo+Pi4uLg0KPj4gICAgICB8IChpb21tdWZkMCxSVyZSTykgfCAgICB8
IChpb21tdWZkMSxSVyZSTykgfCAgICB8IChpb21tdWZkMCxvbmx5IFJXKXwNCj4+ICAgICAgLi0t
LS0tLS0tLS0tLS0tLS0tLS4gICAgLi0tLS0tLS0tLS0tLS0tLS0tLS4gICAgLi0tLS0tLS0tLS0t
LS0tLS0tLS0uDQo+PiAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+PiAgICAgICAgICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgICAgIC4tLT4uLi4gICAgICAgICAgICAgICAgICAgICAgICB8DQo+PiAgICAgICAg
ICAgICAgIFYgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBWDQo+PiAgICAgICAgLi0tLS0tLS0tLS0tLS0tLS0tLS0uICAgIC4tLS0tLS0tLS0tLS0t
LS0tLS0tLiAgICAgICAgICAuLS0tLS0tLS0tLS0tLS0tLg0KPj4gICAgICAgIHwgICBWVERTMkh3
cHQoQ0MpICAgfC0tLT58IFZURFMySHdwdChub24tQ0MpIHwtLT4uLi4gICAgfCBWVERTMkh3cHQo
Q0MpIHwtDQo+LT4uLi4NCj4+ICAgICAgICAuLS0tLS0tLS0tLS0tLS0tLS0tLS4gICAgLi0tLS0t
LS0tLS0tLS0tLS0tLS0uICAgICAgICAgIC4tLS0tLS0tLS0tLS0tLS0uDQo+PiAgICAgICAgICAg
IHwgICAgICAgICAgICB8ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8DQo+PiAgICAgICAgICAgIHwgICAgICAgICAgICB8ICAgICAgICAgICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB8DQo+PiAgICAgIC4tLS0tLS0tLS0tLS4gIC4tLS0tLS0tLS0t
LS4gIC4tLS0tLS0tLS0tLS0uICAgICAgICAgICAgICAuLS0tLS0tLS0tLS0tLg0KPj4gICAgICB8
IElPTU1VRkQgICB8ICB8IElPTU1VRkQgICB8ICB8IElPTU1VRkQgICAgfCAgICAgICAgICAgICAg
fCBJT01NVUZEICAgIHwNCj4+ICAgICAgfCBEZXZpY2UoQ0MpfCAgfCBEZXZpY2UoQ0MpfCAgfCBE
ZXZpY2UgICAgIHwgICAgICAgICAgICAgIHwgRGV2aWNlKENDKSB8DQo+PiAgICAgIHwgKGlvbW11
ZmQwKXwgIHwgKGlvbW11ZmQwKXwgIHwgKG5vbi1DQykgICB8ICAgICAgICAgICAgICB8IChlcnJh
dGEpICAgfA0KPj4gICAgICB8ICAgICAgICAgICB8ICB8ICAgICAgICAgICB8ICB8IChpb21tdWZk
MCkgfCAgICAgICAgICAgICAgfCAoaW9tbXVmZDApIHwNCj4+ICAgICAgLi0tLS0tLS0tLS0tLiAg
Li0tLS0tLS0tLS0tLiAgLi0tLS0tLS0tLS0tLS4gICAgICAgICAgICAgIC4tLS0tLS0tLS0tLS0u
DQo+Pg0KPj4gVGhpcyBzZXJpZXMgaXMgYWxzbyBhIHByZXJlcXVpc2l0ZSB3b3JrIGZvciB2U1ZB
LCBpLmUuIFNoYXJpbmcNCj4+IGd1ZXN0IGFwcGxpY2F0aW9uIGFkZHJlc3Mgc3BhY2Ugd2l0aCBw
YXNzdGhyb3VnaCBkZXZpY2VzLg0KPj4NCj4+IFRvIGVuYWJsZSBzdGFnZS0xIHRyYW5zbGF0aW9u
LCBvbmx5IG5lZWQgdG8gYWRkICJ4LXNjYWxhYmxlLW1vZGU9b24seC1mbHRzPW9uIi4NCj4+IGku
ZS4gLWRldmljZSBpbnRlbC1pb21tdSx4LXNjYWxhYmxlLW1vZGU9b24seC1mbHRzPW9uLi4uDQo+
Pg0KPj4gUGFzc3Rocm91Z2ggZGV2aWNlIHNob3VsZCB1c2UgaW9tbXVmZCBiYWNrZW5kIHRvIHdv
cmsgd2l0aCBzdGFnZS0xDQo+dHJhbnNsYXRpb24uDQo+PiBpLmUuIC1vYmplY3QgaW9tbXVmZCxp
ZD1pb21tdWZkMCAtZGV2aWNlIHZmaW8tcGNpLGlvbW11ZmQ9aW9tbXVmZDAsLi4uDQo+Pg0KPj4g
SWYgaG9zdCBkb2Vzbid0IHN1cHBvcnQgbmVzdGVkIHRyYW5zbGF0aW9uLCBxZW11IHdpbGwgZmFp
bCB3aXRoIGFuIHVuc3VwcG9ydGVkDQo+PiByZXBvcnQuDQo+Pg0KPj4gVGVzdCBkb25lOg0KPj4g
LSBWRklPIGRldmljZXMgaG90cGx1Zy91bnBsdWcNCj4+IC0gZGlmZmVyZW50IFZGSU8gZGV2aWNl
cyBsaW5rZWQgdG8gZGlmZmVyZW50IGlvbW11ZmRzDQo+PiAtIHZob3N0IG5ldCBkZXZpY2UgcGlu
ZyB0ZXN0DQo+Pg0KPj4gRmF1bHQgcmVwb3J0IGlzbid0IHN1cHBvcnRlZCBpbiB0aGlzIHNlcmll
cywgd2UgcHJlc3VtZSBndWVzdCBrZXJuZWwgYWx3YXlzDQo+PiBjb25zdHJ1Y3QgY29ycmVjdCBT
MSBwYWdlIHRhYmxlIGZvciBwYXNzdGhyb3VnaCBkZXZpY2UuIEZvciBlbXVsYXRlZCBkZXZpY2Vz
LA0KPj4gdGhlIGVtdWxhdGlvbiBjb2RlIGFscmVhZHkgcHJvdmlkZWQgUzEgZmF1bHQgaW5qZWN0
aW9uLg0KPj4NCj4+IFBBVENIMS02OiAgQWRkIEhXUFQtYmFzZWQgbmVzdGluZyBpbmZyYXN0cnVj
dHVyZSBzdXBwb3J0DQo+DQo+VGhlIGZpcnN0IDYgcGF0Y2hlcyBhcmUgYWxsIFZGSU8gb3IgSU9N
TVVGRCByZWxhdGVkLiBUaGV5IGFyZQ0KPm1vc3RseSAgYWRkaXRpb25zIGFuZCBJIGRpZG4ndCBz
ZWUgYW55dGhpbmcgd3JvbmcuIFRoZXkgY291bGQNCj5iZSBtZXJnZWQgaW4gYWR2YW5jZSB0aHJv
dWdoIHRoZSBWRklPIHRyZWUuDQoNCk9LLCBJJ2xsIHNlbmQgYSBwcmVyZXF1aXNpdGUgc2VyaWVz
IGNvbnRhaW5pbmcgb25seSB0aGUgZmlyc3QgNiBwYXRjaGVzDQp3aXRoIHN1Z2dlc3RlZCBjaGFu
Z2VzIHJlY2VudGx5Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K

