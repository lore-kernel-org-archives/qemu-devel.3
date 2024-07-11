Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798E3C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 11:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRsAn-00053r-Kf; Thu, 11 Jul 2024 07:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1sRsAl-00052g-2r
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:41:15 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1sRsAg-000084-B3
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720698071; x=1752234071;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rrQEsK64S7LtylAUhad+8zNWapcZSNRdZzJJvo+W5PQ=;
 b=G/kyFiQmlYF33P3W9qoKkOyr513tf1vj+5+/U26MJErk4G4WYdYB9NFn
 0WkUvTyDsSKQq/iW0LyGoOK7yoxw0+3XAVTfxA5CzeOi6qTJtD/1AL1JG
 9LiOM/D4zP1DC9grnq3e00q9iDp2eu0MIrpnrJR6QyVsBgqjjmB+Upy8s
 bm1tKnIO8tujRfM9XjJ1A5Uz3Dt/ybXvnwJIgmuBpch8es8BJNCBMYGly
 n/A4ImUMNo2xSCJ+cN1loLTVedEaBuk/EtvJtZ4N3kIdqr/yvaOfQKkzr
 7OeNJ0lywVzv17nPczufUwy2HMh5tZcK3/FgywHn41Ycnob8DgLVpaTVY A==;
X-CSE-ConnectionGUID: jDVFzdxESiiblvpuUU81dw==
X-CSE-MsgGUID: jNxWK5dlR1Kuot9oYQN6Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="21888559"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; d="scan'208";a="21888559"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2024 04:41:01 -0700
X-CSE-ConnectionGUID: GGCSbzVqQ+6tqNaFYzCNww==
X-CSE-MsgGUID: znnQrzL6QNCgt5J8YNJUkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; d="scan'208";a="48427860"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Jul 2024 04:41:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 04:40:59 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 04:40:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 11 Jul 2024 04:40:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 11 Jul 2024 04:40:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwaFT8BAdfbhESewYsDDckRycge2QMHa7RxmbYKuDH7GbeVo6R1ZU5SFcVw8FPHnwZ2KF0oBbAYRVDGxayYRBWWjworsnB5dGCSCl7bT0re4iSVQDttzgXtPVoMe854BbwnfpuxAwE5aAZQsVEEY8wu+IBGxOP0Vy/FPIBsPdNNNmyQfdo1zV6AIZAF5sCjoI6saNNg1tGsuWfbrHHaU7ODRod9bwmSdftiMCgFRVvTxr+S37tJR8KJN9/Vi3hR2ow/TOjZMjakLZp0zL2Gp9tspZjRS3pBA4c1oDKyUfk34dIli+uoAJw7I14n7RYGqUifAuFO+CYCblwJbYjha/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrQEsK64S7LtylAUhad+8zNWapcZSNRdZzJJvo+W5PQ=;
 b=DFY03C7MpVa2MjDeU2aXkO/lgEduQS3HOBFVCigpZO8zKuEwTkoDpnKmsrjio/IFUHD+wQAS2RRKLKBO5E6T7n4w/vRyS6B983FVjCP0adty6dilGRvw2lVjAi632r8LE/LbDNLb997y+IZcIBOYxJBBpcSVP8aFWgqOzDceyD50hqFJ4dsZreMyFD3EmdFczo+3Guq03Klq3CMxJHiuj2XI17tPNVQttedey8igFWIETKgJhWAifrJdi2QxRiK3EdvTvSRwK4w/bbhBEVhLjS6ylC4HntSpNwagEe2RmWKrrYxcWBkdvHhqg30YFRal10d9YI7EFH83NrKp97kzTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 PH0PR11MB5080.namprd11.prod.outlook.com (2603:10b6:510:3f::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Thu, 11 Jul 2024 11:40:52 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e%3]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 11:40:52 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "mtosatti@redhat.com"
 <mtosatti@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wang, Lei4"
 <lei4.wang@intel.com>, Jiri Denemark <jdenemar@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>
Subject: RE: [PATCH v1] target/i386: kvm: Block migration when enfore_cpuid is
 set to false
Thread-Topic: [PATCH v1] target/i386: kvm: Block migration when enfore_cpuid
 is set to false
Thread-Index: AQHazVg5C0RiDxJPOUeRPpagSbRqXrHlS/KAgACmBACAAMmIgIAApEnAgADFj4CACKfV0A==
Date: Thu, 11 Jul 2024 11:40:51 +0000
Message-ID: <DS0PR11MB63735BB23F1E8112F7D8944EDCA52@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20240703144912.130988-1-wei.w.wang@intel.com>
 <ZoWSdR1IOQ0iIxZC@x1n>
 <DS0PR11MB6373852F86A43ED9E1AFC7B7DCDE2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZobGx3KORPLQfBNC@x1n>
 <DS0PR11MB6373F79B4D34DBF5DAB416F2DCDF2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <Zof2UVtNa4yPDRyF@x1n>
In-Reply-To: <Zof2UVtNa4yPDRyF@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|PH0PR11MB5080:EE_
x-ms-office365-filtering-correlation-id: d06e0b28-e378-49c3-b771-08dca19e5147
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V2FwVk1yYlR2QmJ5OUNZbmY5UkY1eFlKNjNlT1duWE9SaGpSM0czV2Y2OTM4?=
 =?utf-8?B?QzU3OHowUVlDR1FEWUdVMEorenFoYS9CMW1DSkp1QjlKbk1FbEkwb3h4SVFr?=
 =?utf-8?B?NkFCS3ZYWE4wWnc3Z1BQNEV0SC9WWWRpTlBDZ1RpbEN0cjYxMTZ5TzM2Z0xH?=
 =?utf-8?B?WTVVYnJYOFRWSUp5dVYrN2VIcGNFd3J3bDZ1d0pxRXAzNFZzUCtQMVRIOTBP?=
 =?utf-8?B?U0hHSjJIZGlhV2dWYWRZMDFPYWlwMTR1YitCZTlHOGgyOU0ycjg4TXFZUlBi?=
 =?utf-8?B?RnhrQTZoR1FnejcyTEpmU3RzV2s2ZW5JVzhiSzludDl0T05YU0hicnNzWjZi?=
 =?utf-8?B?eWRYbnJ0bzQzWmUyc3g2OXluSmxPeFMreVh0K0Z6Z0podnl1UVZNSmxUSTl2?=
 =?utf-8?B?UkJ6em5CY1ZaVkc3V1FqOGg2UGFaeExlNDF2SUNJbWFDV01PcXpmenVJb1JS?=
 =?utf-8?B?Nm9LN1pIdUhpaWsvanNPRkE1Tm1DTXlpVHplNmtzb3h6dDlPTXJxRkxxeVgx?=
 =?utf-8?B?a0ROOHNTZmV3NTBvM2xwYnhxMzRTcEdoODNwU2JLVmRzYURkZjd0VHpRbXlJ?=
 =?utf-8?B?MnZqaGl3bmRYNU1ZaW1mQjh3YU9sWUw1bDd3N3JUY2s4SXVBUkNPaTFJK1dD?=
 =?utf-8?B?VUE2NE50WVJ0b29yNmJ1TDE3M2MxOVRoVWpxcUw0c2p1cUdqRytTbEhXT3Ux?=
 =?utf-8?B?SHVOOVF6U0t6anRySUxDenZJVGpvYkNZUTExamJuc1JsSUJrenppSkZCaGMw?=
 =?utf-8?B?M1VqUkZyQ1UzUzFwbjVGVEsvVHVHSlIwSjlIeTNkOE5wVGh4dGZHTDdVa3pM?=
 =?utf-8?B?dWIvNk9xekJFbmxVNCtsdmFDZ3hBQktOZDR5VEZFbGo5KzdyaTVPTHVYRGlk?=
 =?utf-8?B?Tm93cm8xZWFJb0NDWHROK2dUMHVFSmJXdG5KUkpmMit3RG8yR2hhcWFIME5V?=
 =?utf-8?B?akhtSkhLQW5JaE0za3NjRVZZYi9LNkR3aHF4OGo1YTlsakRUTnFtbXhZeDlS?=
 =?utf-8?B?aFpiOExIKzllVG5jS2dFOEFWdjdDQlpCTlJDMG50TTRrV1NBN3ljVUdqeWxM?=
 =?utf-8?B?QVo4QjVpZnp3aGxraldoeFVXbkVrQzBRNzRETDM4Q0l6UXJDNDV0QUU0bkM4?=
 =?utf-8?B?bXEyeVByZUdsSzUweHBRbXR1dzd4Q25rbE9qbEw1ckZmSjZ6Zit5TmpWVkN0?=
 =?utf-8?B?dmlSdFg4UDZHenFqUmNzUlNvYmUxU2VEME9KZ3lkZEFVeXRpY2pjR29idWFn?=
 =?utf-8?B?RHVTQ3lFVnU0Q3lNSnptazdaWGF3cFIwbis0aERKWlBjZDZLVUZNYXhhZnpR?=
 =?utf-8?B?Tm1YRFZIR2VJUVhSZUZxaWVKRG1KMXdkV0xud3ZtaFdTVlZtbmxkNHh0aXNU?=
 =?utf-8?B?MEI5em82eWM3MHg0bklGaW9ZeEwzcEIvcjhKRDRoVmFOM1UrbTFVNFlnRVlo?=
 =?utf-8?B?OG9VaksydFh1L2xCT0lPYzRvY01NSWgrSm1iMnQxZjRWYlRqN1BBUUhPenFz?=
 =?utf-8?B?L1o3eXpHY2dKVUs5TS9UZm1mM3RsT2ZvNlpCZGVhSUI3UWo4M0tWNGJSbUFR?=
 =?utf-8?B?Q3dDb1RIaVVtMmxSZ2xUMnBpcU1HckUrL0hrOVpXanRrbng3ai93RWgwYnR3?=
 =?utf-8?B?Y2dySnpLYVVISnpDMHpLN2I2dG52QzFoVW5VTUo3MCtYQXJUNnMzemRZemFn?=
 =?utf-8?B?K3Bmc3lsaFlSYm04QUcxSy9VRmJNWW1qVXEwbVpOYjBqSmI5bjBJRjR5cVlS?=
 =?utf-8?B?QWc2UTlFOFJBY3JJVTZ2dWVOU0NFVGpKZURtNFhtcVZTUnBVd09LeUpROVNO?=
 =?utf-8?B?TlB3emUrS2svTnlBd0VKNjVhSHBJRnRKNXRUSTlTcmVjcmY2bnRlZ3pMRXM1?=
 =?utf-8?B?SVBCWktlbEMzcjdYYXpyak5oK3k5eHVQUnA5U25oYnNYcFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEF6dk5xY29icjI0d2tJQTRIakx3VVJZOFRxRDBqOXVXeHljaGN2NzlEakpC?=
 =?utf-8?B?eWpiZUpyMld5WmIrbkRGQ01uenQwaExBaEovb2twVE5SZktPK2dtNyt0VzFp?=
 =?utf-8?B?VFJkdUZidWxBa3ZuMVVwYmNoeXVMaklXVHBScVlnL0pEakg0enMyQWExelpN?=
 =?utf-8?B?bXBjbHVnd3BGcnpzS2hzYWt2QlFENlBIZ2g4NjJWczQ1UHp6eWwyeEVPRkR2?=
 =?utf-8?B?NENtMFVyei9sS3FJWVBLczV4NGd5RjZNTTVldlNlL0N5S3ZnSWk2UXJpVms1?=
 =?utf-8?B?Z3ZEVmVQWVlnQ1MrZzZxR2ZmWWFUcGFmb2RzNU1wWWloWlc2VnkvWlc0RHZQ?=
 =?utf-8?B?cksrdnd4cWFtdEoxR0xLalUwYmxVVlJ6bC93c3VrdXlJVFRLUEUrY1RFdGlD?=
 =?utf-8?B?OUNoQjNJZFU0Ujc1UkkzVlNGWFF3K1pJbldxZzhWUjJMcTc5aGh2Q1hXUGp5?=
 =?utf-8?B?dEdYVzY4d1crVk1wN3RhTGZpYUdXQzZyU1A3czJ4bkh1U3pxKy8waGVVczNB?=
 =?utf-8?B?UVAwdEdSV21od2ZZYSt6QjdJeWg5My83N2tFU0JVUkltN3BUd2V5NDBNYWpm?=
 =?utf-8?B?U2xOLzd0QnlQN0Y0YUJtS2xSS0hUa2g0emo1ZGhUTmJHeWNFN3B1WXU3cU9p?=
 =?utf-8?B?MTRyL3FVZTFPclFqWVlhVzhndlVId2pSbjd6aC8wNm1vQWtzVUZ3NHRubjU1?=
 =?utf-8?B?L2pHa2JIMlh6VmpVbURpdFVtYUJhK1Z4YktuUHdEbkNrU2hWL3JzcVNyd0xT?=
 =?utf-8?B?VGZzcUo1bk9DZDFEK1p5Q1hnNDVCWnJrL1U0M0s5M0Jpc2c3SmV6TlFWSDRx?=
 =?utf-8?B?U2dvaVQrSERrTGxpYmorbmxTeUFrQk9kMzRIRFpLQnhXc09QZ3pLcnVUWEFi?=
 =?utf-8?B?MDN0ZlVIdGtMNXQwbzhTNXhUb25zNGd6RkZsYm9lSTFCOXplTy90MDRJL3lB?=
 =?utf-8?B?dXdHWldBNU93VlI4SHdzRks1UzZ2cVRWdWl1alBiUDNBZmt0Tk1EK2hJbVhV?=
 =?utf-8?B?Nm1ZamxsWVl0OGV5UVp4emhITXBXZWNoWFJlSUFkdWVrTHFMOHM0dzQrdE1F?=
 =?utf-8?B?LytsM3lOVmNqb1NadHRSalg5cHNGKy9mSCtyNUoxUlR3QkhYSWlVMHJweW9F?=
 =?utf-8?B?R3B0OE1OR2NkSmVRWFk0YlBvcHVOTjJMMmEwRW9PRDUwOEhvTGZRMlBzVlox?=
 =?utf-8?B?YzZQZW1nVExlVklkeitvRVZ1MG9WSS9pL1lLbHlxUFdBZGN1RURDWkEyYk5O?=
 =?utf-8?B?Y1liMDBtYjFzMU55S0ZmQ2tWbGhHdHowN0w1RkJEQXByWFhHRmlyQWh1VWpL?=
 =?utf-8?B?ck5qOFpLOGkwMjBuM3ZrNjZHZ1FMZVZPN0ZGYUQ3cmpWQ2xnUTVDc3BDL1BU?=
 =?utf-8?B?U0xtWTBlWjl5VStSenBYZ0JTdTNwbVBwK0JtRHFJd01haU5PN2o5UFBQbDY2?=
 =?utf-8?B?aEFFNjNtQTdzQ1hhQVpsMjQ0Q1pXRnIxUVY3SE54UDMrY1prRDYvMEs0VWpv?=
 =?utf-8?B?RW5zQkpBbXFycWxBTkV3cjh3ZXprTUtrcHNielRSR3BUcEpwNDNzRENHc2l6?=
 =?utf-8?B?NW1oQW1jSTlaSUVFKzdRb1pqUU81ejFNcWNVUFB3alN0aHZuU0tnSTJHS29K?=
 =?utf-8?B?RmpSamtFYlJaNUFOdzR0cjNCOFNzTGZCWFhQNTk2NGdZM0RPMktsbnYzZ0hF?=
 =?utf-8?B?OUJud3ZDWDJqU0JHb3JUY1hINFU1QlZPMDdua0lBNHRBUWZ3a3RzMVVRb1JQ?=
 =?utf-8?B?Z3dKTlZIb0tOS0F2c1R4WDFFNkhkTFYraC9PNENTZFY3OGE3bzZZRXRNek5w?=
 =?utf-8?B?MDNzcm5rek9ObWdsVU1xYllpekZwODFxYWF3VXZQeFB0ZkJGejNtaWhFdEsz?=
 =?utf-8?B?V1dFT2xadjIvblhESGhhU0Rwb0VDcFRXN1lZYVhyZG9DTitEa3lqMi80T0RS?=
 =?utf-8?B?eVowU09ZOE5QeU1SYTcvZ056RzJmdFhyN0hJOHZUK0VPQ2tSajdaRjFRalBU?=
 =?utf-8?B?YXFaazF4YVpOY2x6c0wwWHpaU2kvTnNibjBXazF4THU3WVpPQStMT3I3azd5?=
 =?utf-8?B?KzlzTU1HOUorTkFHRDVWOENuM0kxaEt2dG1TQmlvMFF4a2NlbW5BTVZBOHlo?=
 =?utf-8?Q?v12eh0pjhItrBBe1z5bmugwk9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d06e0b28-e378-49c3-b771-08dca19e5147
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2024 11:40:51.9705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i8PUFElgVVY804EfgllXm2Cffew8KMkdAJ15C8SO1l3Iqdr0afBc+reqnO+/k2kQfxDi8TOBkypXYNmnv33G5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5080
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

T24gRnJpZGF5LCBKdWx5IDUsIDIwMjQgOTozNCBQTSwgUGV0ZXIgWHUgd3JvdGU6DQo+IE9uIEZy
aSwgSnVsIDA1LCAyMDI0IGF0IDEwOjIyOjIzQU0gKzAwMDAsIFdhbmcsIFdlaSBXIHdyb3RlOg0K
PiA+IE9uIFRodXJzZGF5LCBKdWx5IDQsIDIwMjQgMTE6NTkgUE0sIFBldGVyIFh1IHdyb3RlOg0K
PiA+ID4gT24gVGh1LCBKdWwgMDQsIDIwMjQgYXQgMDM6MTA6MjdQTSArMDAwMCwgV2FuZywgV2Vp
IFcgd3JvdGU6DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L2kzODYvY3B1LmMgYi90
YXJnZXQvaTM4Ni9jcHUuYyBpbmRleA0KPiA+ID4gPiA+ID4gNGMyZTZmM2E3MS4uN2RiNGZlNGVh
ZCAxMDA2NDQNCj4gPiA+ID4gPiA+IC0tLSBhL3RhcmdldC9pMzg2L2NwdS5jDQo+ID4gPiA+ID4g
PiArKysgYi90YXJnZXQvaTM4Ni9jcHUuYw0KPiA+ID4gPiA+ID4gQEAgLTgyNTgsNyArODI1OCw3
IEBAIHN0YXRpYyBQcm9wZXJ0eSB4ODZfY3B1X3Byb3BlcnRpZXNbXSA9IHsNCj4gPiA+ID4gPiA+
ICAgICAgREVGSU5FX1BST1BfVUlOVDMyKCJodi12ZXJzaW9uLWlkLXNudW1iZXIiLCBYODZDUFUs
DQo+ID4gPiA+ID4gPiBoeXBlcnZfdmVyX2lkX3NuLCAwKSwNCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiAgICAgIERFRklORV9QUk9QX0JPT0woImNoZWNrIiwgWDg2Q1BVLCBjaGVja19jcHVpZCwg
dHJ1ZSksDQo+ID4gPiA+ID4gPiAtICAgIERFRklORV9QUk9QX0JPT0woImVuZm9yY2UiLCBYODZD
UFUsIGVuZm9yY2VfY3B1aWQsIGZhbHNlKSwNCj4gPiA+ID4gPiA+ICsgICAgREVGSU5FX1BST1Bf
Qk9PTCgiZW5mb3JjZSIsIFg4NkNQVSwgZW5mb3JjZV9jcHVpZCwgdHJ1ZSksDQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBJIGFzc3VtZSBpbiBtYW55IGNhc2VzIHBlb3BsZSBjYW4gc3RpbGwgcHJvcGVy
bHkgbWlncmF0ZSB3aGVuDQo+ID4gPiA+ID4gdGhlIGhvc3RzIGFyZSBzaW1pbGFyIG9yIGlkZW50
aWNhbCwgc28gbWF5YmUgd2UgYXQgbGVhc3Qgd2FudA0KPiA+ID4gPiA+IHRoZSBvbGQgbWFjaGlu
ZSB0eXBlcyBrZWVwIHdvcmtpbmcgKGJ5IGludHJvZHVjaW5nIGEgbWFjaGluZSBjb21wYXQNCj4g
cHJvcGVydHkpPw0KPiA+ID4gPg0KPiA+ID4gPiBZb3UgbWVhbnQga2VlcGluZyAiZW5mb3JjZV9j
cHVpZD1mYWxzZSIgZm9yIG9sZCBtYWNoaW5lIHR5cGVzDQo+ID4gPiA+IChlLmcuIGJlZm9yZQ0K
PiA+ID4gOS4xKT8NCj4gPiA+ID4gVGhpcyB3aWxsIG1ha2UgdGhlbSBub24tbWlncmF0YWJsZSB3
aXRoIHRoaXMgcGF0Y2gsIGJ1dCB0aGV5IHdlcmUNCj4gPiA+ID4gbWlncmF0YWJsZSAoYnkNCj4g
PiA+ID4gZGVmYXVsdCkgYXMgIm1pZ3JhdGFibGUiIHdhc24ndCBlbmZvcmNlZCBieSAiZW5mb3Jj
ZV9jcHVpZCIuDQo+ID4gPiA+IFNob3VsZCB3ZSBrZWVwIHRoZW0gYmVpbmcgbWlncmF0YWJsZSBi
eSBkZWZhdWx0IChlLmcuDQo+IGVuZm9yY2VfY3B1aWQ9dHJ1ZSkgYXMgd2VsbD8NCj4gPiA+DQo+
ID4gPiBBaCwgdGhpcyBpcyB0cmlja2llciB0aGFuIEkgdGhvdWdodC4uDQo+ID4gPg0KPiA+ID4g
VGhlIGlzc3VlIGlzIGlmIHdlIG1ha2UgdGhlbSBzaWxlbnRseSBzd2l0Y2ggdG8gZW5mb3JjZV9j
cHVpZD10cnVlDQo+ID4gPiBvbiBvbGQgbWFjaGluZXMsIHRoZXJlJ3MgY2hhbmNlIHRoZXkgc3Rh
cnQgdG8gZmFpbCBib290LCBhbSBJIHJpZ2h0Pw0KPiA+DQo+ID4gUmlnaHQgZm9yIG5ld2x5IGxh
dW5jaGVkIGd1ZXN0cywgcmVnYXJkbGVzcyBvZiB3aGV0aGVyIHRoZXkgYXJlIG5ldyBvcg0KPiA+
IG9sZCBtYWNoaW5lIHR5cGVzLCB0aGV5IHdpbGwgZmFpbCB0byBib290IHdoZW4gdGhlIGhvc3Qg
Y2Fubm90IGFmZm9yZA0KPiA+IHRoZSBmZWF0dXJlcyBmb3IgdGhlIGNvbmZpZ3VyZWQgdkNQVSBt
b2RlbHMuIFRoaXMgaXMgZXhwZWN0ZWQsIGFuZA0KPiA+IGFjdHVhbGx5IHBhcnQgb2YgdGhlIGlu
dGVudGlvbnMgb2YgdGhpcyBwYXRjaC4NCj4gPg0KPiA+IFdoZW4gdGhlcmUgaXMgYSBuZWVkIHRv
IGJvb3QgYSBndWVzdCB3aXRoIHJlZHVjZWQgZmVhdHVyZXMsIHVzZXJzIG5lZWQNCj4gPiB0byBl
eHBsaWNpdGx5IGFkZCAiZW5mb3JjZV9jcHVpZD1mYWxzZSIsIHdoaWNoIG1hcmtzIHRoZSBuZXcg
Ym9vdGVkDQo+ID4gZ3Vlc3QgYXMgbm9uLW1pZ3JhdGFibGUsIG9yIGEgX2JldHRlcl8gd2F5LCB0
byBpZGVudGlmeSB0aGUNCj4gPiB1bnN1cHBvcnRlZCBmZWF0dXJlcyBmcm9tIHRoZSBob3N0IGZp
cnN0LCBhbmQgdGhlbiBnZXQgaXQgYm9vdGVkIHdpdGgNCj4gPiAiLWNwdSBDcHVNb2RlbCwtQSwt
QiIsIHRoaXMgY2FuIG1ha2UgaXQgbWlncmF0YWJsZSB3aXRoIHRob3NlIGtub3duDQo+ID4gcmVk
dWNlZCBmZWF0dXJlcywgYW5kIHRoZSBkZXN0aW5hdGlvbiBndWVzdCBpcyByZXF1aXJlZCB0byB1
c2UgdGhlDQo+ID4gc2FtZSBRRU1VIGNvbW1hbmRzIChhcyB1c3VhbCkgdG8gcmVkdWNlIHRoZSBz
YW1lIHNldCBvZiBmZWF0dXJlcyBhcyB0aGUNCj4gc291cmNlIGFuZCBnZXQgYSBlbmZvcmNlZCBj
aGVjayBieSAiZW5mb3JjZV9jcHVpZCIuDQo+ID4NCj4gPiBGb3IgbGl2ZSB1cGRhdGUgb2YgUUVN
VSBmb3IgZXhpc3RpbmcgcnVubmluZyBndWVzdHMgKGFzIHlvdSBtZW50aW9uZWQNCj4gPiBiZWxv
dyksIHRoZSBpbXBhY3QgaXMgb25seSBvbiB0aGUgcnVubmluZyBndWVzdHMgdGhhdCBoYXZlIGhh
ZA0KPiA+IGZlYXR1cmVzIHJlZHVjZWQgZnJvbSB2Q1BVIG1vZGVscyAoYXQgdGhlIHRpbWUgb2Yg
dGhlaXIgb3JpZ2luYWwNCj4gPiBsYXVuY2gpLiBGb3IgdGhpcyBjYXNlLCB0aGUgcmVjb21tZW5k
ZWQgd2F5IHRvIHVwZGF0ZSB0aGVtIHRvIHRoZSBuZXcNCj4gPiBRRU1VIGlzIGFsc28gdG8gZXhw
bGljaXRseSBpZGVudGlmeSB0aGUgcmVkdWNlZCBmZWF0dXJlcyBhbmQgdXBkYXRlIHRoZW0NCj4g
d2l0aCAiLWNwdSBDcHVNb2RlbCwtQSwtQiIuDQo+ID4NCj4gPiBUaGUgcmF0aW9uYWxlIGJlaGlu
ZCB0aGlzIGlzIHRoYXQgdGhlIGZlYXR1cmVzIHJlZHVjZWQgZnJvbSB0aGUgZ3Vlc3QNCj4gPiBu
ZWVkcyB0byBiZSBleHBsaWNpdGx5IGRldGVybWluZWQgYW5kIGNvbnRyb2xsYWJsZS4gSW4gdGVy
bXMgb2YgbGl2ZQ0KPiA+IG1pZ3JhdGlvbiwgdGhlIGRlc3RpbmF0aW9uIGlzIGVuc3VyZWQgdG8g
aGF2ZSB0aGUgc2FtZSBzZXQgb2YgcmVkdWNlZA0KPiA+IGZlYXR1cmVzIGFzIHRoZSBzb3VyY2Ug
c2lkZS4NCj4gPg0KPiA+ID4NCj4gPiA+ICAgICBpZiAoY3B1LT5lbmZvcmNlX2NwdWlkICYmIHg4
Nl9jcHVfaGF2ZV9maWx0ZXJlZF9mZWF0dXJlcyhjcHUpKSB7DQo+ID4gPiAgICAgICAgIGVycm9y
X3NldGcoJmxvY2FsX2VyciwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICBhY2NlbF91c2VzX2hv
c3RfY3B1aWQoKSA/DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICJIb3N0IGRvZXNuJ3Qg
c3VwcG9ydCByZXF1ZXN0ZWQgZmVhdHVyZXMiIDoNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIlRDRyBkb2Vzbid0IHN1cHBvcnQgcmVxdWVzdGVkIGZlYXR1cmVzIik7DQo+ID4gPiAgICAg
ICAgIGdvdG8gb3V0Ow0KPiA+ID4gICAgIH0NCj4gPiA+DQo+ID4gPiBJIHN1cHBvc2Ugd2Ugc3Rp
bGwgbmVlZCB0byBrZWVwIGFsbCB0aGUgb2xkIHdvcmxkcyBydW5uaW5nIGFsbCBmaW5lDQo+ID4g
PiB3aXRob3V0IGJyZWFraW5nIHRoZW0gd2hlbiBwZW9wbGUgZG8gYW4gUUVNVSB1cGdyYWRlLiAg
SXQgbmVlZHMgdG8NCj4gPiA+IHdvcmsgYm90aCBvbiBib290aW5nIGZpbmUsIGFuZCBvbiBhbGxv
d2luZyB0byBtaWdyYXRlLg0KPiA+ID4NCj4gPiA+IFNvIG1heWJlIHdlIGFjdHVhbGx5IG5lZWQg
dHdvIHRoaW5ncz8NCj4gPiA+DQo+ID4gPiAgIC0gT25lIHBhdGNoIGludHJvZHVjZSBmb3JiaXRf
bWlncmF0aW9uX2lmX2NwdWlkX21pc21hdGNoIHByb3BlcnR5LA0KPiB3aGVuDQo+ID4gPiAgICAg
c2V0LCBibG9jayBtaWdyYXRpb24gaWYgbm90IGVuZm9yY2VkLCBvdGhlcndpc2UgaXQgc2hvdWxk
IHN0aWxsIGFsbG93DQo+ID4gPiAgICAgbWlncmF0aW9uIGV2ZW4gaWYgZW5mb3JjZV9jcHVkPWZh
bGVzLiAgSXQgc2hvdWxkIGRlZmF1bHQgdG8gb24sIGJ1dCBvZmYNCj4gPiA+ICAgICBvbiBvbGQg
bWFjaGluZXMuDQo+ID4gPg0KPiA+ID4gICAtIE9uZSBwYXRjaCBjaGFuZ2UgZGVmYXVsdCB2YWx1
ZSBvZiBlbmZvcmNlX2NwdWlkIHRvIG9uLCBidXQgdHVybiBpdCBvZmYNCj4gPiA+ICAgICBvbiBv
bGQgbWFjaGluZXMuDQo+ID4gPg0KPiA+ID4gRG9lcyB0aGF0IGxvb2sgcmlnaHQ/DQo+ID4NCj4g
PiBJIHRoaW5rIHRoaXMgY2FuIHdvcmsuIE5vdCBzdXJlIHdoYXQgeW91IHdvdWxkIHRoaW5rIGFi
b3V0IHRoZSBhYm92ZQ0KPiBleHBsYW5hdGlvbnMuDQo+ID4gSWYgYWdyZWUsIHRoZW4gcHJvYmFi
bHkgd2UgZG9u4oCZdCBuZWVkIHRvIGFkZCB0aGUgZXh0cmEgY29tcGxleGl0eS4NCj4gPg0KPiA+
IEFsc28sIHRoZSBhYm92ZSB0d28gdGhpbmdzIHNlZW0gdG8gaW1wZWRlIHRoZSB1cGdyYWRlIGZv
ciBndWVzdHMgd2l0aA0KPiA+IG9sZGVyIG1hY2hpbmUgdHlwZXMgdG8gaW5jb3Jwb3JhdGUgdGhp
cyBlbmZvcmNlbWVudC4gSSB0aGluayB0aGUNCj4gPiBwcmltYXJ5IGdvYWwgb2YgbGl2ZSB1cGRh
dGluZyB0byBhIG5ld2VyIFFFTVUgdmVyc2lvbiBpcyB0byBiZW5lZml0IGZyb20gdGhlDQo+IGVu
aGFuY2VtZW50cyBvZmZlcmVkIGJ5IHRoZSBuZXcgUUVNVS4NCj4gPiBTbyBpdCBzZWVtcyBtb3Jl
IGJlbmVmaWNpYWwgdG8gYnJpbmcgb2xkIGd1ZXN0cyB1bmRlciBzdWNoDQo+ID4gZW5mb3JjZW1l
bnRzLCBnaXZlbiB0aGF0IHRoaXMgZG9lc24ndCBicmVhayBmdW5jdGlvbmFsaXRpZXMgdGhhdCB0
aGUNCj4gPiBndWVzdCBpcyBydW5uaW5nLiBUaGUgb25seSByZXF1aXJlbWVudCBmb3IgdGhpcyBp
cyB0byB1cGdyYWRlIHVzaW5nDQo+ID4gbW9yZSBleHBsaWNpdCBRRU1VIGNvbW1hbmRzIChpLmUu
LCAtY3B1IENwdU1vZGVsLC1BLC1CKSB3aGVuIG5lZWRlZC4NCj4gDQo+IFdoYXQgeW91IHNhaWQg
bWFrZXMgc2Vuc2UuICBJdCdzIGp1c3QgdGhhdCB0aGUgY29uY2VybiBzdGlsbCBleGlzdHMsIGFu
ZCBJJ20gbm90DQo+IHN1cmUgd2hldGhlciB0aGF0J2xsIGJlIHRvbyBtdWNoIHRvIGFzayBmb3Ig
YSBjdXN0b21lci4NCj4gDQo+IEFsc28sIHNlZSB0aGlzIGNvbW1pdDoNCj4gDQo+IGNvbW1pdCAx
NWU0MTM0NTkwNmQyOWEzMTljYzljZGY1NjYzNDdiZjc5MTM0ZDI0DQo+IEF1dGhvcjogRWR1YXJk
byBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29tPg0KPiBEYXRlOiAgIFdlZCBBdWcgMjYgMTM6
MjU6NDQgMjAxNSAtMDMwMA0KPiANCj4gICAgIHRhcmdldC1pMzg2OiBFbmFibGUgImNoZWNrIiBt
b2RlIGJ5IGRlZmF1bHQNCj4gDQo+ICAgICBDdXJyZW50IGRlZmF1bHQgYmVoYXZpb3Igb2YgUUVN
VSBpcyB0byBzaWxlbnRseSBkaXNhYmxlIGZlYXR1cmVzIHRoYXQNCj4gICAgIGFyZSBub3Qgc3Vw
cG9ydGVkIGJ5IHRoZSBob3N0IHdoZW4gYSBDUFUgbW9kZWwgaXMgcmVxdWVzdGVkIGluIHRoZQ0K
PiAgICAgY29tbWFuZC1saW5lLiBUaGlzIG1lYW5zIHRoYXQgaW4gYWRkaXRpb24gdG8gcmlza2lu
ZyBicmVha2luZyBndWVzdCBBQkkNCj4gICAgIGJ5IGRlZmF1bHQsIHdlIGFyZSBzaWxlbnQgYWJv
dXQgaXQuDQo+IA0KPiAgICAgSSB3b3VsZCBsaWtlIHRvIGVuYWJsZSAiZW5mb3JjZSIgYnkgZGVm
YXVsdCwgYnV0IHRoaXMgY2FuIGVhc2lseSBicmVhaw0KPiAgICAgZXhpc3RpbmcgcHJvZHVjdGlv
biBzeXN0ZW1zIGJlY2F1c2Ugb2YgdGhlIHdheSBsaWJ2aXJ0IG1ha2VzIGFzc3VtcHRpb25zDQo+
ICAgICBhYm91dCBDUFUgbW9kZWxzIHRvZGF5ICh0aGlzIHdpbGwgY2hhbmdlIGluIHRoZSBmdXR1
cmUsIG9uY2UgUUVNVQ0KPiAgICAgcHJvdmlkZSBhIHByb3BlciBpbnRlcmZhY2UgZm9yIGNoZWNr
aW5nIGlmIGEgQ1BVIG1vZGVsIGlzIHJ1bm5hYmxlKS4NCj4gDQo+ICAgICBCdXQgdGhlcmUncyBu
byByZWFzb24gd2Ugc2hvdWxkIGJlIHNpbGVudCBhYm91dCBpdC4gU28sIGNoYW5nZQ0KPiAgICAg
dGFyZ2V0LWkzODYgdG8gZW5hYmxlICJjaGVjayIgbW9kZSBieSBkZWZhdWx0IHNvIGF0IGxlYXN0
IHdlIGhhdmUgc29tZQ0KPiAgICAgd2FybmluZyBwcmludGVkIHRvIHN0ZGVyciAoYW5kIGhvcGVm
dWxseSBsb2dnZWQgc29tZXdoZXJlKSB3aGVuIFFFTVUNCj4gICAgIGRpc2FibGVzIGEgZmVhdHVy
ZSB0aGF0IGlzIG5vdCBzdXBwb3J0ZWQgYnkgdGhlIGhvc3Qgc3lzdGVtLg0KPiANCj4gICAgIFJl
dmlld2VkLWJ5OiBJZ29yIE1hbW1lZG92IDxpbWFtbWVkb0ByZWRoYXQuY29tPg0KPiAgICAgU2ln
bmVkLW9mZi1ieTogRWR1YXJkbyBIYWJrb3N0IDxlaGFia29zdEByZWRoYXQuY29tPg0KPiANCj4g
SSBkb24ndCB0aGluayBJIGtub3cgd2hhdCdzIHRoZSAibGlidmlydCBhc3N1bXB0aW9ucyIgbWVu
dGlvbmVkLCBhbmQgaG93IGl0DQo+IGNoYW5nZWQgYXMgb2YgdG9kYXkuICBJIGhhZCBhIHZhZ3Vl
IG1lbW9yeSBMaWJ2aXJ0IGNvbnN0YW50bHkgc2V0IG9mZiBvbiBzb21lDQo+IG9mIHRoZSByZWxl
dmFudCBmbGFncyBsYXN0IHRpbWUgSmlyaSBleHBsYWluZWQgc29tZSBjcHVpZCBpc3N1ZXMgdG8g
bWU7IG1heWJlIGl0J3MNCj4gImNoZWNrIiBub3QgImVuZm9yY2UiPyBJdCB3b3VsZCBiZSBncmVh
dCBpZiBKaXJpIG9yIERhbiBjYW4gY29tbWVudCBoZXJlLg0KDQpJIGhhZCBhIGNoZWNrIGluIGxp
YnZpcnQgYW5kIGRpZG4ndCBmaW5kICJlbmZvcmNlIiBpcyBzZXQgdG8gZmFsc2UgYW55d2hlcmUg
KGV4Y2VwdA0Kb25seSBpbiBzb21lIHRlc3RzLCB3aGljaCBJIHRoaW5rIHNob3VsZCBiZSBmaW5l
KS4NClNlZW1zIHdlIGhhdmVuJ3QgZ290IHJlc3BvbnNlcyBmcm9tIG1vcmUgZm9sa3MgaGVyZSA6
KQ0KSXMgaXQgYXBwcm9wcmlhdGUgdG8gb3BlbiBhIGRpc2N1c3Npb24gdGhyZWFkIGluIGRldmVs
QGxpc3RzLmxpYnZpcnQub3JnIHRvIGNvbmZpcm0/DQo=

