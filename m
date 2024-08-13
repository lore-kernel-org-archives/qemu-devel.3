Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50197C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 07:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdltD-0007zm-RJ; Tue, 13 Aug 2024 03:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sdltA-0007yx-OW
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:24:16 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sdlt8-0005Fg-N8
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 03:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1723533855; x=1755069855;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=k9A4i9rJ88ZrCDT/VoA6P7RbYvgEYW5FpMmajBujk1U=;
 b=CtJFvh1pIodenALgnVDa62koL0wDrTUqkL4TDBPEJjhU8A/bg7v/byKN
 53Rpvn3wn7vigX0ysnpdZPR4/S8v++0mGkwCWXwoTHlug39dIngSQwd96
 k2juMqsKEi3GJyhb+nY4Jfq1w/R1dl545j8kHpe+5u9LWr4CQKWnEjSAM
 SV7oThb7VZVeb+pcbIK8LHkj565/hg7ueJdqP9iA+uQM9+gcbqPJDeZi0
 LBUtoxTa8B1OxESDetrq85v3Qay5WbdSXG2+Mhkg2XUAmMbcfSvOGDHtn
 mRnIt5SKhNx1CGDmvC7SPzbgdt/wQvvTLSKGhg0dAR4LIJARM5JAGObsI A==;
X-CSE-ConnectionGUID: K7qu883KSMmUUkS6lAIvkg==
X-CSE-MsgGUID: UlNxXrjFTZSNXLlThmTVqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21836659"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="21836659"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2024 00:24:13 -0700
X-CSE-ConnectionGUID: ZZUIDni0R8eTKGi4VCMH4A==
X-CSE-MsgGUID: cPrpdKH2R26Jlth4+WqAzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; d="scan'208";a="89236376"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Aug 2024 00:24:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 00:24:12 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 00:24:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 00:24:11 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 00:24:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XK57+4p54SD52aoSO/AwT9A4OEqEwlnTelZXo7cmyE3kElcJv/dCgd1qs+Z+2lnO6jN11oa5ZxLEoz6Qowy07ZKlm/tr5VqS5SKY4nT5dFhQ34T1gqGrwBZfUXrQD+riS6c3v91XCARtakpZPrEduE6yMeArrPz7PICJzzb7f3jrECEWoVPMaGjz3yzhYFYDLzZpmxxEoKjgf54dqfKT3oI3GPP5c3oU3lnw2nx7b7twMEcAjzgCCwzWmhrNOiOJ5xnkZgBT9aPSfD/Wy3oOQc8+EpQlSVjCMd32fIH6pAJX5xvpg08q/Y6ys3MEkM0sOzGrnChDnGk/EN9yU8iK/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9A4i9rJ88ZrCDT/VoA6P7RbYvgEYW5FpMmajBujk1U=;
 b=nmKLFsLIZaftCGR28AQ1jAMGTcboAxNcCqcB64NHclIBEtZVhDiIeg59FcdRS6LAC2mIc3f8fLdsT3ZWTkKg9ePZjx15Ymbn2qLRa8DJ4ODC26/zEtGyfc+rfFa4ZDW421f7CejzIQbk4X6jMdU3nCr1wnv9WbrChkLutlovn/lgzIiuZ35AlejldQr8m6so08TRO89YvKF179kojouz3mln8kUAyINA66Vk6aA3YHNCGNRnLxojcuzliKkaMypI97XeBYr6aoZlgKg4RWVomsFI7iFG0feZkeoVcrW+MiYSF9wrJmGnDaJmN2MduORsU1oNHHEVQxt0gLJJjLW+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB6224.namprd11.prod.outlook.com (2603:10b6:8:97::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.27; Tue, 13 Aug 2024 07:24:04 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 07:24:04 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Peng, Chao P" <chao.p.peng@intel.com>,
 =?utf-8?B?Q2zDqW1lbnQgTWF0aGlldS0tRHJpZg==?=
 <clement.mathieu--drif@eviden.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH] intel_iommu: Fix invalidation descriptor type field
Thread-Topic: [PATCH] intel_iommu: Fix invalidation descriptor type field
Thread-Index: AQHa7UWo1+q/uNvYI0KtChNAyQEIVrIkxCwAgAAElNA=
Date: Tue, 13 Aug 2024 07:24:03 +0000
Message-ID: <SJ0PR11MB6744A5397B2211A920045FD492862@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240813055354.2562736-1-zhenzhong.duan@intel.com>
 <9404c6b8-67ea-46bc-a702-85b3992a56f8@intel.com>
In-Reply-To: <9404c6b8-67ea-46bc-a702-85b3992a56f8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB6224:EE_
x-ms-office365-filtering-correlation-id: fff0c261-52d3-49b5-5244-08dcbb68e902
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OWtqVmdybisvWnVxRFMwM3FHUjYyOGZmbUFwNXZjNVQreGdsczhzbzc3N1k0?=
 =?utf-8?B?M3gwMVpRSmkyUmdrb1d3L2NxSFRONTZybmJjcDg3NlREMmM3YVFhWUZzenll?=
 =?utf-8?B?VDhKbnBoTUdlOE53UkpmVzdUaitDTWZ6VDd3Z1paTExpNm9FQ2o2clJaZ2w2?=
 =?utf-8?B?VUdPYTVoUzFsSSs1UUlnSDEvV0grZFpqUXJkZjVSNFAxbW53ZXp6NmN0TlBB?=
 =?utf-8?B?YytvNlJQR1NDQytHdithcXhqeHQ2RUQ2Y3AxaDlPQWlQdk82blltUGpnUmtY?=
 =?utf-8?B?aEJBVHhtd2o2RjNhdjh3Q1IwQ2lMSmY0M09UcStoRmduZWc0dXRPYzdZSjk5?=
 =?utf-8?B?S0ZvcXpqR0VjSFdtZ0pJdkV2UzdKTytGeWg5Qm14UC9xSmsyMGtYVFozQ0ZF?=
 =?utf-8?B?SnFhd1g3Z2ZnTDQycWVmZEJGUGMwZHowUGpFNzdteHZ0d2JCZjRmREd0MEZ6?=
 =?utf-8?B?K1hlUHgrWCtsdHFUMEJ6enlROU52TGpIdGI3eWEyZ0t0OHZ3NVZvRXZ0V1NN?=
 =?utf-8?B?VFZ1bitEVFlUT2w0bnhwbnZZNnpwb3pTVjVJRmNmYXBKQjRsWjV5bENiem00?=
 =?utf-8?B?Y0Jwanl5YmhSUy9uOEpTQ0VMemZDQngweHJ1dEVkSHhxZWxqNGYvQ3RUTFk5?=
 =?utf-8?B?d3NsVVVkQjc3WkNIWnhvOGI5SEZUOVhmdktONmRDNlNzZHl0TWN4NkNPNFh4?=
 =?utf-8?B?cGtmaTk1bExldyt4eXpFRWJKYzJlQ0dLOUdpN3pZWTNRbDlWTUVlV2wrYm80?=
 =?utf-8?B?NXJheHFJWWFBSi9oMEVkUjNIYlk1Y1ZXS29iZk9tdG9LREhOS3NybHRSVzlU?=
 =?utf-8?B?ZE4rNjdrK3JpWGh5OGp4UHZ1cmpNRzFnRWZjQkdFYVQ1QlU3ODArWWFVbWFW?=
 =?utf-8?B?R2l3a1FldkRUM2F5ZUp4cVhmT1RpTEI4MU4wbU10bzY1YUpPbis3aUg2MmtK?=
 =?utf-8?B?TDdxbGR6OXZXaitDV2FXMFFkM29VOUs0Mm41NklSVnFXQnRYNG4zMEZiZlNH?=
 =?utf-8?B?eDJwOUwzdGl4TFk5cUVWN0hmMWxDZms0MWF6OGRBRVdpS1UyY2pZY1M2bWwy?=
 =?utf-8?B?RzA3SXFXeEsxd1hDS1J1REpyL2N5M29XTy9DM04zQTNmcjlOOGVleU1uYnoz?=
 =?utf-8?B?alVqNERVVTdaTVB4Qk9FSHpESmxZWklnQkk1cnV1YVUzYjRpd2tOUUdoQW1L?=
 =?utf-8?B?eVd0alUrTjZqYzNmZ1B1akNGazdSekcyaWVDMEY0TjhERTlCYnB0a2xjOU0v?=
 =?utf-8?B?TGczTDBKdVhNZ0dZSUhvY1hxY2xVTnZJaEw1TTF6QjQ5Qm0wQXJGdkR3UHVT?=
 =?utf-8?B?TU1vTUNmd2FtWFRPaDZuNi9oc0JYekxaN0l2eXhBL01JMnhzQUZMeTI1QzVu?=
 =?utf-8?B?Sy9DZVZpT0pzZGlrTm9wbm8wWVJVWVlNc2VjK2hWZG84bm1mbnpKaG5oc21G?=
 =?utf-8?B?SkhwY2tjQlhrNU1ydW92QkRmQmk3SVowR3NpTERkd0VsVVhSdmlOUW13MElW?=
 =?utf-8?B?b0FLTHpnczU4N0toS2RsOTBydjNjMGwrQ2RtZkN3RzZhYzQvWG1VOCt5a2tr?=
 =?utf-8?B?MU5KL2FQQktrVUxibHFFT2FrQ05FY2RuT25kV1ByQXNyRG1WREU4ejlWOVBX?=
 =?utf-8?B?NkE1ZnUyMEkzU0c3bkJqcjd5NXppSXB5aWtxTy81dEtQUVJQTW91dmN3YVJx?=
 =?utf-8?B?MnFjVkg0ZFZEYmFidzdMSFdBZFZoVjNzT2p3OHBxblkwZEROK0FQWmFTUXhN?=
 =?utf-8?B?anVvcTFyRGViNkQxQWlPNzFBemFFODJ6OWtGbGwzNlZ5RHBPM0c2c2grbnZ5?=
 =?utf-8?B?S1FZRWV2a05kK28xUlkvMTVMMEVnSm1BaTVPYWFjcVRBd1JHQXZCd1FtTFhi?=
 =?utf-8?B?Mm92VkJxVTMrYzJlZE5KeExRc0xHRllqcFB2VWRBcXJNdEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHdzVFJEMVBnM28rbjNXK05tSXg4b1o5OGorSW1xclIxemhhY2RXSlZaUmdL?=
 =?utf-8?B?OS9zYWFmcDBvZDIyUWpKUElYOExKcHJ4Z1M5WVZrdUMwMSt0SWtzTC85TGxh?=
 =?utf-8?B?VWRKZkhLbnJ2ZTIrZkhyeUpFalFmMzJzZFV5SXVaYWgvckp1OVlvUlBaWDgz?=
 =?utf-8?B?WEVsUFp4bExxbWJhbERJSmtuMzJRRnhLcUhRRjZVU2NaWTNIOXNPam8zQXkz?=
 =?utf-8?B?SCs4ajgvUldESkxWQ0VJY3kvTWlYOTZ3UW96dlNDWVp3T3JPOUtxUGtDUTZR?=
 =?utf-8?B?a3lMT3B0TWs0ajB6ZUdzdUhUdzlLL1RjZDcrTEhLcWdlQWRXM1hydzFMQ1cx?=
 =?utf-8?B?d1c1RmhFRFlacTN1UlRBdVU0Qml6b2dXWGVQWXpWTStoZkxZZGY0dStnT1g3?=
 =?utf-8?B?bVB2S2wydnR6MDVVWHZyaU1iWm1UQVQxMDR1bkgxejFodWZmM1FER3lERUUv?=
 =?utf-8?B?bnlaaXlkM0xsL29POHJXRVVML2hBQ2pOOStmMy9JL2pwY3lsd01ZbXpJcGNm?=
 =?utf-8?B?R2szcVlzQzVaek8xbDdQTVNiWERnZll5NUVOL1ZXOEcxYkxqTWNHR2pxV3J2?=
 =?utf-8?B?VjF2MXJuelVPM0ZDMGhwdGwra2MxaUR4dkQ2WVBxRitENzlkK2kvMUh0VEpC?=
 =?utf-8?B?OG10cjJLeXNzbWRhaUhka0cybVl4b1lwUXJhdndxUDY3MCsxam5OQ1dSajE2?=
 =?utf-8?B?K2hYbStCbWlkcGtTcFljNE1NeGd5QW1lOXhYVVhZQWFYWDRzYXNTclVYSWlp?=
 =?utf-8?B?TzZ0WE9KZVBWaXAwOUphVlFCTHo3UmJpZHZqSFFGRlBlZ1ZwbGRxWHhOUlds?=
 =?utf-8?B?SlVMZ0NnRXh1WkFycnV4bmdQVDlCZXZQclg1SC8yQklLTGwvU1RFcWt2eUc0?=
 =?utf-8?B?a29kTHlQa0oxdHZ4UVJ4VVpWajZWTlJRTjlhMjBwc0EycjRuYzZ2UjNPenhi?=
 =?utf-8?B?NkF6Um5wcm9tVll5WERML1hDaHRkZHJNYit4TFBIa3lsWHlOWkFBOUw4ekc3?=
 =?utf-8?B?V0xVOTdKWTNDYzEzTXBKcjU5QjB2YkNCcmhoM1BVOTY0bWhVeFY5SlNzd2Yw?=
 =?utf-8?B?VjZvVzJ4eEY2YnhEeUpGMDhKR1g5VTIrM1kwc0g0RUdPM1RkTUNwclFENkpv?=
 =?utf-8?B?enJRQnJDYXRGdlYrZWxDVWxrQ0NIMmJkL0JLQ1k4YUdDVm5vV094dTdGRnVr?=
 =?utf-8?B?L1pHVmVGYkZ4QjJtYXd5THRRLy9COUlSQmxwZlA2ckMycjcxMVUyUmZvNUpx?=
 =?utf-8?B?cStkb1ordG5hcXEvNWdVK2JHbEpMblY4dCt6anpyU1ZVTUFOM2s5czVLRGtP?=
 =?utf-8?B?NUZ1NCtMbGtzZU5FRlEwYW11VmhUWDFqYjVYSjVGWm9TdzJ3VjNrUk5vc0FJ?=
 =?utf-8?B?QlZaTWRFbVhaSGdqTVU2djVDa0NpUzk1bTRINGowd1lLYm5SOVFWd1NZeGdL?=
 =?utf-8?B?SG8wWUo5cnkrL0VOcVlrUHNwOHJ2aTEyMFIyMzgxZ0x2bUF1ZHorY3NhUVNx?=
 =?utf-8?B?SVRzckp5TWpPOWtpdnFYK3lJOXNQQ0Y0blBBbFhCMThQem5tcHdZK0xWS2Z5?=
 =?utf-8?B?RDhrdWJpU1ByMDVDRlVBZGdzZzRCV0FiYTk1QkpCNkNNaTQ3SythYUlJMHBE?=
 =?utf-8?B?OElrZWMzbHh3ZUVFTWZlK3dRN081bEt0dndqZVlCbnlKY1YxMHhIUERMWEd3?=
 =?utf-8?B?eWhFMW5vR3EvOVlaV0pVbzdyTEExeFhicEYyQnUvbFhIdjBrRHBGZFZKeVhE?=
 =?utf-8?B?eGZ0dHh0TmhwRkdKOFVBcVJQSTZUbmRoVXNOZWFnVytGUFhzenhxOTBBYkxn?=
 =?utf-8?B?ZmNGTlFFMTczOElFcjJvRjdBTGl2TzdKMnBiS3NyMHROK0tmM2F3UnFWSFRZ?=
 =?utf-8?B?em9iMGRWbjNrcDFBM2psQWJMenljNWZ0NWh4emZ5Q2Y5eXZrbWZNZEQ2WmRV?=
 =?utf-8?B?Z0hPOFdjSWplSnIyU1Fab0lKNk85TXdOT3lVanllL3krNlhoSXhFREFKMzR6?=
 =?utf-8?B?ODR5ckpEcWh0WjQxaXJFNndvZmlSU0xQZFNlQVpxQU0zNEVhNXA5dHNJZGty?=
 =?utf-8?B?c2JndkVxTS9zN3V3V3lDajFUV1dVRjJaM2hvSFEwT0wwdXBaMERoejNwR21Q?=
 =?utf-8?Q?5/CrSTaQLTUe+s3j05iy4unkb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fff0c261-52d3-49b5-5244-08dcbb68e902
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 07:24:03.9653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YSiwbDE9bABvm5zCzXSQKqjkD5BU3f6CGGbNFD+Qr/0ZdwAGJBKBWu1g4VABJg9/ezWEqM0WqM/EWj4qbDJfp3gMJP/NnnPEr8lFL6SAJuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6224
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGludGVsX2lvbW11OiBGaXggaW52
YWxpZGF0aW9uIGRlc2NyaXB0b3IgdHlwZSBmaWVsZA0KPg0KPk9uIDIwMjQvOC8xMyAxMzo1Mywg
Wmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBBY2NvcmRpbmcgdG8gc3BlYywgaW52YWxpZGF0aW9u
IGRlc2NyaXB0b3IgdHlwZSBpcyA3Yml0cyB3aGljaCBpcw0KPj4gY29uY2F0ZW5hdGlvbiBvZiBi
aXRzWzExOjldIGFuZCBiaXRzWzM6MF0gb2YgaW52YWxpZGF0aW9uIGRlc2NyaXB0b3IuDQo+Pg0K
Pj4gQ3VycmVudGx5IHdlIG9ubHkgcGljayBiaXRzWzM6MF0gYXMgdGhlIGludmFsaWRhdGlvbiB0
eXBlIGFuZCB0cmVhdA0KPj4gYml0c1sxMTo5XSBhcyByZXNlcnZlZCB6ZXJvLiBUaGlzIGlzIG5v
dCBhIHByb2JsZW0gZm9yIG5vdyBhcyBiaXRzWzExOjldDQo+PiBpcyB6ZXJvIGZvciBhbGwgY3Vy
cmVudCBpbnZhbGlkYXRpb24gdHlwZXMuIEJ1dCBpdCB3aWxsIGJyZWFrIGlmIG5ld2VyDQo+PiB0
eXBlIG9jY3VwaWVzIGJpdHNbMTE6OV0uDQo+Pg0KPj4gRml4IGl0IGJ5IHRha2UgYml0c1sxMTo5
XSBpbnRvIHR5cGUgYW5kIG1ha2UgcmVzZXJ2ZWQgYml0cyBjaGVjayBhY2N1cmF0ZS4NCj4NCj5z
L3Rha2UvdGFraW5nLw0KDQpXaWxsIGZpeC4NCg0KPg0KPlJldmlld2VkLWJ5OiBZaSBMaXUgPHlp
LmwubGl1QGludGVsLmNvbT4NCj4NCj5UaGVyZSBpcyBhbm90aGVyIGZpeCB5b3UgbWF5IGFkZC4g
SW4gdnRkX3Byb2Nlc3NfaW52X2Rlc2MoKSwgaXQgc2hvdWxkDQo+dHJlYXQgdGhlIHR5cGUgVlRE
X0lOVl9ERVNDX1BDIGFuZCBWVERfSU5WX0RFU0NfUElPVExCIGFzIGludmFsaWQgdHlwZQ0KPmlm
IHZJT01NVSBpcyBydW5uaW5nIGluIGxlZ2FjeSBtb2RlLg0KDQpBaCwgaW5kZWVkLCB3aWxsIGZp
eCB3aXRoIGEgbmV3IGFkZGluZyBwYXRjaC4gVGhhbmtzIGZvciBzdWdnZXN0aW5nLg0KDQo+DQo+
PiBTdWdnZXN0ZWQtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWY8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiBUZXN0ZWQgaW50ZWwtaW9tbXUuZmxhdCBp
biBrdm0tdW5pdC10ZXN0OiBQQVNTDQo+PiBUZXN0ZWQgdmZpbyBkZXZpY2UgaG90cGx1ZzogUEFT
Uw0KPj4gLS0tDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDExICsrKysr
Ky0tLS0tDQo+PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8ICAyICstDQo+PiAg
IDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj5iL2h3L2kzODYv
aW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gaW5kZXggNWYzMmMzNjk0My4uMTNkNWQxMjlhZSAx
MDA2NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4gKysrIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+PiBAQCAtMzU2LDcgKzM1Niw4IEBAIHVu
aW9uIFZUREludkRlc2Mgew0KPj4gICB0eXBlZGVmIHVuaW9uIFZUREludkRlc2MgVlRESW52RGVz
YzsNCj4+DQo+PiAgIC8qIE1hc2tzIGZvciBzdHJ1Y3QgVlRESW52RGVzYyAqLw0KPj4gLSNkZWZp
bmUgVlREX0lOVl9ERVNDX1RZUEUgICAgICAgICAgICAgICAweGYNCj4+ICsjZGVmaW5lIFZURF9J
TlZfREVTQ19UWVBFKHZhbCkgICAgICAgICAgKCgoKHZhbCkgPj4gNSkgJiAweDcwVUxMKSB8IFwN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgodmFsKSAmIDB4
ZlVMTCkpDQo+PiAgICNkZWZpbmUgVlREX0lOVl9ERVNDX0NDICAgICAgICAgICAgICAgICAweDEg
LyogQ29udGV4dC1jYWNoZSBJbnZhbGlkYXRlIERlc2MNCj4qLw0KPj4gICAjZGVmaW5lIFZURF9J
TlZfREVTQ19JT1RMQiAgICAgICAgICAgICAgMHgyDQo+PiAgICNkZWZpbmUgVlREX0lOVl9ERVND
X0RFVklDRSAgICAgICAgICAgICAweDMNCj4+IEBAIC0zNzIsNyArMzczLDcgQEAgdHlwZWRlZiB1
bmlvbiBWVERJbnZEZXNjIFZUREludkRlc2M7DQo+PiAgICNkZWZpbmUgVlREX0lOVl9ERVNDX1dB
SVRfSUYgICAgICAgICAgICAoMVVMTCA8PCA0KQ0KPj4gICAjZGVmaW5lIFZURF9JTlZfREVTQ19X
QUlUX0ZOICAgICAgICAgICAgKDFVTEwgPDwgNikNCj4+ICAgI2RlZmluZSBWVERfSU5WX0RFU0Nf
V0FJVF9EQVRBX1NISUZUICAgIDMyDQo+PiAtI2RlZmluZSBWVERfSU5WX0RFU0NfV0FJVF9SU1ZE
X0xPICAgICAgIDBYZmZmZmZmODBVTEwNCj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19XQUlUX1JT
VkRfTE8gICAgICAgMFhmZmZmZjE4MFVMTA0KPj4gICAjZGVmaW5lIFZURF9JTlZfREVTQ19XQUlU
X1JTVkRfSEkgICAgICAgM1VMTA0KPj4NCj4+ICAgLyogTWFza3MgZm9yIENvbnRleHQtY2FjaGUg
SW52YWxpZGF0aW9uIERlc2NyaXB0b3IgKi8NCj4+IEBAIC0zODMsNyArMzg0LDcgQEAgdHlwZWRl
ZiB1bmlvbiBWVERJbnZEZXNjIFZUREludkRlc2M7DQo+PiAgICNkZWZpbmUgVlREX0lOVl9ERVND
X0NDX0RJRCh2YWwpICAgICAgICAoKCh2YWwpID4+IDE2KSAmDQo+VlREX0RPTUFJTl9JRF9NQVNL
KQ0KPj4gICAjZGVmaW5lIFZURF9JTlZfREVTQ19DQ19TSUQodmFsKSAgICAgICAgKCgodmFsKSA+
PiAzMikgJiAweGZmZmZVTCkNCj4+ICAgI2RlZmluZSBWVERfSU5WX0RFU0NfQ0NfRk0odmFsKSAg
ICAgICAgICgoKHZhbCkgPj4gNDgpICYgM1VMKQ0KPj4gLSNkZWZpbmUgVlREX0lOVl9ERVNDX0ND
X1JTVkQgICAgICAgICAgICAweGZmZmMwMDAwMDAwMGZmYzBVTEwNCj4+ICsjZGVmaW5lIFZURF9J
TlZfREVTQ19DQ19SU1ZEICAgICAgICAgICAgMHhmZmZjMDAwMDAwMDBmMWMwVUxMDQo+Pg0KPj4g
ICAvKiBNYXNrcyBmb3IgSU9UTEIgSW52YWxpZGF0ZSBEZXNjcmlwdG9yICovDQo+PiAgICNkZWZp
bmUgVlREX0lOVl9ERVNDX0lPVExCX0cgICAgICAgICAgICAoM1VMTCA8PCA0KQ0KPj4gQEAgLTM5
Myw3ICszOTQsNyBAQCB0eXBlZGVmIHVuaW9uIFZUREludkRlc2MgVlRESW52RGVzYzsNCj4+ICAg
I2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfRElEKHZhbCkgICAgICgoKHZhbCkgPj4gMTYpICYN
Cj5WVERfRE9NQUlOX0lEX01BU0spDQo+PiAgICNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExCX0FE
RFIodmFsKSAgICAoKHZhbCkgJiB+MHhmZmZVTEwpDQo+PiAgICNkZWZpbmUgVlREX0lOVl9ERVND
X0lPVExCX0FNKHZhbCkgICAgICAoKHZhbCkgJiAweDNmVUxMKQ0KPj4gLSNkZWZpbmUgVlREX0lO
Vl9ERVNDX0lPVExCX1JTVkRfTE8gICAgICAweGZmZmZmZmZmMDAwMGZmMDBVTEwNCj4+ICsjZGVm
aW5lIFZURF9JTlZfREVTQ19JT1RMQl9SU1ZEX0xPICAgICAgMHhmZmZmZmZmZjAwMDBmMTAwVUxM
DQo+PiAgICNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExCX1JTVkRfSEkgICAgICAweGY4MFVMTA0K
Pj4gICAjZGVmaW5lIFZURF9JTlZfREVTQ19JT1RMQl9QQVNJRF9QQVNJRCAgKDJVTEwgPDwgNCkN
Cj4+ICAgI2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfUEFTSURfUEFHRSAgICgzVUxMIDw8IDQp
DQo+PiBAQCAtNDA2LDcgKzQwNyw3IEBAIHR5cGVkZWYgdW5pb24gVlRESW52RGVzYyBWVERJbnZE
ZXNjOw0KPj4gICAjZGVmaW5lIFZURF9JTlZfREVTQ19ERVZJQ0VfSU9UTEJfU0laRSh2YWwpICgo
dmFsKSAmIDB4MSkNCj4+ICAgI2RlZmluZSBWVERfSU5WX0RFU0NfREVWSUNFX0lPVExCX1NJRCh2
YWwpICgoKHZhbCkgPj4gMzIpICYgMHhGRkZGVUxMKQ0KPj4gICAjZGVmaW5lIFZURF9JTlZfREVT
Q19ERVZJQ0VfSU9UTEJfUlNWRF9ISSAweGZmZVVMTA0KPj4gLSNkZWZpbmUgVlREX0lOVl9ERVND
X0RFVklDRV9JT1RMQl9SU1ZEX0xPIDB4ZmZmZjAwMDBmZmUwZmZmOA0KPj4gKyNkZWZpbmUgVlRE
X0lOVl9ERVNDX0RFVklDRV9JT1RMQl9SU1ZEX0xPIDB4ZmZmZjAwMDBmZmUwZjFmMA0KPj4NCj4+
ICAgLyogUnN2ZCBmaWVsZCBtYXNrcyBmb3Igc3B0ZSAqLw0KPj4gICAjZGVmaW5lIFZURF9TUFRF
X1NOUCAweDgwMFVMTA0KPj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3
L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gaW5kZXggMTZkMjg4NWZjYy4uNjhjYjcyYTQ4MSAxMDA2
NDQNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdS5jDQo+PiBAQCAtMjc0NCw3ICsyNzQ0LDcgQEAgc3RhdGljIGJvb2wNCj52dGRfcHJv
Y2Vzc19pbnZfZGVzYyhJbnRlbElPTU1VU3RhdGUgKnMpDQo+PiAgICAgICAgICAgcmV0dXJuIGZh
bHNlOw0KPj4gICAgICAgfQ0KPj4NCj4+IC0gICAgZGVzY190eXBlID0gaW52X2Rlc2MubG8gJiBW
VERfSU5WX0RFU0NfVFlQRTsNCj4+ICsgICAgZGVzY190eXBlID0gVlREX0lOVl9ERVNDX1RZUEUo
aW52X2Rlc2MubG8pOw0KPj4gICAgICAgLyogRklYTUU6IHNob3VsZCB1cGRhdGUgYXQgZmlyc3Qg
b3IgYXQgbGFzdD8gKi8NCj4+ICAgICAgIHMtPmlxX2xhc3RfZGVzY190eXBlID0gZGVzY190eXBl
Ow0KPj4NCj4NCj4tLQ0KPlJlZ2FyZHMsDQo+WWkgTGl1DQo=

