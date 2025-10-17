Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6378CCD183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 02:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9aGc-0000KO-B7; Thu, 16 Oct 2025 22:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9aGa-0000Ja-CG
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 22:32:28 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v9aGO-0007Pj-Vd
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 22:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760668337; x=1792204337;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2X+d9cldSD1/TbGvERNV3ru6Nyuu5leRkPrQ4sj+/fo=;
 b=J7gaF/nHDOoDs8wLAVnJb9iW3DcMaqpd6SKKoaA4OQAE0w/xnr6YcAwV
 6QthA2cXrwbvtuHJMCiSekffTpglbSeJGlS2jYprk6qh6FwPEO2h9anpS
 jOvstvNgKBVCr0id2nsl6ukOqtfNSxpAzVo3au+eyrbsQSDKotq/V+ljL
 e7PcT5kUSVQbdzEGoJb0FEwxnhsVj2oVVH44icNfr0wZzApTmIeHpawPU
 JpaAqxG3dCJmlsl5Nr6RCWTnlDsr7f50ywCGT1pCikFfIquSuuPnQVZ0+
 HphwLptDZdgrvFmIUW4ONTmLUvjc/EYVtbFRhudRNxEqP2oZjJbu5Vsvm g==;
X-CSE-ConnectionGUID: eFHBuqkNSiqdHlGElSHpwQ==
X-CSE-MsgGUID: qEG1fWJhTU2WHb97+IdNIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73160135"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="73160135"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 19:31:56 -0700
X-CSE-ConnectionGUID: 0hQeMCE0TXS+rpFWyB2D8g==
X-CSE-MsgGUID: G8aHCmBiTjOfAt2SQgty0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; d="scan'208";a="183089788"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2025 19:31:55 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 19:31:55 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 16 Oct 2025 19:31:55 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 16 Oct 2025 19:31:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSORQdkRzzuEbzdmdEyTxY59qDOQ0oRzmez+UssO26BkJoKwLkbcFDh9mMKkDprhShu8EIUax/8ODuZWE75xGpmw8fxg9vTU1Q0ESp/q5gsZbf3GjH7s84Omk1XpD4ZMJ+2S66Tt41y+J49ze1ioozZCf5LFm31ggPy9V7eh5iIk9OQqQWyjNblSftiISE7lszre6kMyeSHIPxaxrymHq/cisJ+rlpjLdhbsgE/UIpGg9iA2Wi227doPiZNJcAyDwOVoWEDj5Ca5OwDK6cEixmbajHr1Sv1dt73sYnr4H7B6eZHQqohd9mpXGAnvb5CiOB0wBMwM43Jr6b1VKfKzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2X+d9cldSD1/TbGvERNV3ru6Nyuu5leRkPrQ4sj+/fo=;
 b=Cc7Ju4vgseqCnMJUbQ/9iOTBCGBn5pxTpMDWWLh+SLsoDp8WhQNfMZBegGKWoTd70Ht34YENPZj0H2TGXs0FRMmFYTgmbrGeQyC29iudenDRK7lKbyA+kDlCIgIVUXSe00Kodx0vkCJnp4zgbBlyfPVdSgDdkwPY3SLtESkrGeV6dt4ULiSKV3O/IqHeKZgLDVZHLr58ssq+SSX9LWOl+6fLwTzt3eEJPbp+y7/hngLUpbPZnPMLtBXeZAJGIR8jtH04DtTZfIGcrEbrpuZlueZhb6EUQLv3OXq9bY9dJzWGVnoUBuSwP1p2/49DQtTf+fkhutU+iOJZnigZ2gbjmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ2PR11MB7715.namprd11.prod.outlook.com (2603:10b6:a03:4f4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 02:31:47 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 02:31:47 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van De
 Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during migration
Thread-Topic: [PATCH 4/5] intel_iommu: Optimize unmap_bitmap during migration
Thread-Index: AQHcIfvpBR8EG6fncUCmXH17xc4ayLS+gq4AgAEL66CAAK7kAIAA3gSggABNBgCAABhnoIAB4aOAgAFLPUCAABOMAIAAbU6AgACpiVA=
Date: Fri, 17 Oct 2025 02:31:47 +0000
Message-ID: <IA3PR11MB91367D756F1ACE3A0655F4AC92F6A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-5-zhenzhong.duan@intel.com>
 <bc51d154-be8e-47d7-abe7-bcb9f93a7348@intel.com>
 <DS4PPF93A1BBECD1A86879EBF071C6D09D792EAA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
 <74930e82-62f7-4b4e-8bdc-217142586dd3@intel.com>
 <IA3PR11MB913676B74FF4A6B74F4959D992EBA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <f6317dfb-4f04-42e8-8350-b47004c64f70@intel.com>
 <IA3PR11MB9136AEE8F0C3A989C964E35092E8A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <9fabdf4a-a781-491a-bbd2-40e51462b8e7@intel.com>
 <IA3PR11MB9136B2CF78F1473BED36E1B492E9A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <cf67c96b-21f2-47eb-b693-704c5657a2a9@intel.com>
 <808ebae7-27c8-49f1-9626-8ed9b7a1f4e7@redhat.com>
In-Reply-To: <808ebae7-27c8-49f1-9626-8ed9b7a1f4e7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ2PR11MB7715:EE_
x-ms-office365-filtering-correlation-id: de75acaf-6897-4f34-ebd3-08de0d2551da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TlB0VmI2NzlqNWQ1emxkMUE1ZTJqZ2JKdEZJcVhaQ0lpVjhMM2Q2ZzdVRnhN?=
 =?utf-8?B?UUZoRUpBTk9IeHNKQzU1VHVxa1piajRqYmZhYVRmNXJQaHVNZGh5NjZyT2VS?=
 =?utf-8?B?TmpsQ2RpMENuSDV4bUUyRDFhejN6QzlGOVFDWVJzWTJIRFI0WDBTU2hXSE9U?=
 =?utf-8?B?OXJtTDE1eGtMVDNQUGo4VjJENTVQTCtqQndGaUltN3hNQ0YrMTdGOVcxanY2?=
 =?utf-8?B?MHBRbHhrblZKa0h4ZUNMOWlJdUIrZ045TUY5Mm1Oa1JMSHFvSWVWTWFva0VX?=
 =?utf-8?B?NlpWN0RTSi9xWHBTQno0dzdFdTlpNnlobEg4YWZpMzExWHhpSHgxWHFoTkFJ?=
 =?utf-8?B?WVdMRGR6VEZHWEFxR1hkZVdTSzhrN1FuR2hzTWtNSEFkMFE0Nk9WMWNyZllZ?=
 =?utf-8?B?aEZXM1Bkb1JVUWgrRVBKS0dzMVVzOXZtT2FZRkdKUkkvelFWS1NSUHB1dmxo?=
 =?utf-8?B?a1I0QklWUEdMM2dlV0pHSjNySEhyellrVDM3Z01SK0RNZjlDOTVxQ0JzMDl1?=
 =?utf-8?B?UWNRbFR2Z3ZVUjNVaGRqVXduSjdPQkRDYW9mdWNGQmsyQlN6M3ErK0tmSS9s?=
 =?utf-8?B?SW5FajFBdjVJVmQ3UjFDZmRPOTdPUzEyRHNWSVVDMWoxYnkrU1U2ejc0Rm5N?=
 =?utf-8?B?NnNsajJwS2RXVVVFSTVHN25BYWRMQzMrNThKR2J3aE5zVGVyTjhub2VWQmcw?=
 =?utf-8?B?L0gvTmFBUDVSbFBOTERqci8zQzV6ekozTkIzUGo4RXpFQ2h6cUYyejNoYWpW?=
 =?utf-8?B?QXhZbzFVemJkam5lOWN3cElpOHhDUG1ERjdhMURNaUkwN0N3QThQQ3JLa0J6?=
 =?utf-8?B?elViWlkybVFaT2dsRFlUbCsrSWQ4RkcwaFdaaU1Pcm13dklhQ3NIY1FuMnZj?=
 =?utf-8?B?K2t3VW8vNGEwekhVTnd2RWdNMW1PYmF5NUFLYUFJUHVoSUVvck5JUU9oVWVq?=
 =?utf-8?B?c2FGci80R0pWbDQ1Ym9VSlozOHFnUDZ0TGhjN0FsSjBjelptbXZPanluOTlO?=
 =?utf-8?B?VS9xeFlCaW9TZ3VDb1IxcVhnaUxSZmNyeFRhOGdlS0FMMTM4b1NCZXFSek1I?=
 =?utf-8?B?OEhqUFMvU05jS1BKOTVMUVdBbFJuTW5hOU5sbDcvS3k1MzU0QzJyRWtUamJu?=
 =?utf-8?B?UnlYLzMxNFhKcDFBTTdkS1ZiYitzYy9YZmlLazZFYU1ER0Urb3JuNWc3WWNL?=
 =?utf-8?B?czh6aU9TUTlmK05kRGZQOUtHUVNtOFBJTUllc3IyOVZxOEg3OU9VRDBxbnhT?=
 =?utf-8?B?WXdjamdzcW1LamtZNWkzN0x4TnZhWFEyQ2M3UVhUUUhTaGRIOVlsVjBZVlNj?=
 =?utf-8?B?RENCTU1EUk9VZmtsT1lQQzBOY2xob1VHenhNMzRJL1Z5THFDYi81enBCamov?=
 =?utf-8?B?ejlaNFRqM1Bvcm5uUk15ZXVSVU8vVUNOcHd4Ykxicm1uK3haU2JRalBIdFRW?=
 =?utf-8?B?bXNNN00rVEdkZGxNQjNwQmM5d2QxZjZQU0JMa1gvM3diNXZuc0ZORnpkVnlY?=
 =?utf-8?B?MkhYWGYvb3ZQWWdKcEJOdVIwWkVIVzRJeDBGRDBzMHUvVVdRRFpQTjc5N2JE?=
 =?utf-8?B?Zk4wUE50ek5leGhRVWhtTWowUjg2TnJWNUJUZ2QyQ1ExYm5BYTJodUUwbyt0?=
 =?utf-8?B?YmxGSjRzZkFvcVNRTmRMaHloSjVzeDh2MEZXcUJ4dmtWN0FobmMrQU5sSkxW?=
 =?utf-8?B?dVkza3dJYW9uVTRVZlE2NVlvTnR3Zi9pQnhqRitiL0R5Y2FwRGQ3WTQ0NmJq?=
 =?utf-8?B?QWlYRlpONzFHQ05rM0VwTFRwTmZiaTM1VzYvN0IxS2xERFVyZWgvakxqRFNm?=
 =?utf-8?B?d2psd0JPa0NyZVVxcjI0c2lGT2FkdVp3V2hWS3l0YjJLSFRLQWdEY0x0YWdp?=
 =?utf-8?B?RHlhMFpGOG1pVjVnS1NjeG1UVmU5d3h4ekpFUk5rK1hkMjBGZ2VMalptMko0?=
 =?utf-8?B?V0N0STl3bVA0V2YwMTlub09iVGk5QVRvUEtEZlhCcEh2VWI3dVhRaGpaRnVK?=
 =?utf-8?B?YllNVkR3REFiektpRDRtT0ZzNVRtWG5QRUtkcjRERzMwM0JFR0xpemdZV0ph?=
 =?utf-8?Q?aBOHBq?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ak9Xd0hxaUZYSERZYVhIaUNUWE9IODNPWVRYOXN1NU9KUTRFMVBzaG83WHZO?=
 =?utf-8?B?alFkNWsxV1dZTEorSUtKa3pESGNtaW44T1RKNTBNcGtEMHJBMy94eVJxSlRP?=
 =?utf-8?B?dlFodFV2LzRDOFZ5YVhzWmRmcFR1cnJRR3F3MFNXRFZnQTBJUWFTSm1rcG9C?=
 =?utf-8?B?MDB6VEZ6dVkwUHdMT2JRVjZEU0hUZUJkNlloOTVhOHJuZnArZUVCQ0JTSXZ0?=
 =?utf-8?B?RUdIbDZkOHVLVTdPeFFoYVB2RWFKanplYW44cG5UZ1M1TVZDQVBZOVA5MTlF?=
 =?utf-8?B?TVlXT1d0RHVRYXllUXEyME5mTXYzVHZEdkFUZEJpT2svb2JrSGJERTdYQ3Rj?=
 =?utf-8?B?UzVSUm95ZGdvbG16QXorVnVGSXhTVE9ZdW1VNVF3ZHdWdWJlWVBCTHY4cy9O?=
 =?utf-8?B?VUhRd1Bja2R0b3l5cG85Z1pjNEt0TU5oYmtRNlkwQXZTalp1TzZRc0lXdk1K?=
 =?utf-8?B?OWkvRnZxRUpkbEliODkrcHV5R3R3RXRFQVV1dUFOdDc3aXRKVERZUzZjM1VO?=
 =?utf-8?B?V2doK2d5Ylp2MGxWTkVSemdjblRHUzZpYmNsekJBbGgzc1ZJNE5XSjJZWTN4?=
 =?utf-8?B?SHBNK1ZDUkRHaHdWYXIvelZHZUU4Q2orUkE5QmhpVzY2dTQ5Z0kvN3IxT3Fv?=
 =?utf-8?B?R1pmeWpxcGw4Z0hRcjQ1R1FTc1F4Z2hLUG5kUlFKSk9xdDFNdk01NGZGSUx1?=
 =?utf-8?B?UjA0UUFXTEZLZ01tVHdqbUxPNnlvcWlZTG1jd0thTDAzbTAxMDlBKzViUDlP?=
 =?utf-8?B?OXVMVmcvS1A3YnNHZVQwWDZHR1FSK2pkYm5qb2h6KzBpWHhCSGJNTENJaVYy?=
 =?utf-8?B?MDJhUVlyZjUzQjZWdUhHYkhDaEU2VlhKK2ZLTU04OEV5ZGJSYVc1eCt4NEZl?=
 =?utf-8?B?S3F1S2pWVzVPbUJ2UEFHakw0dk9IUngrOGFaSDFqYWdnYld6TUMzTXhzS1lT?=
 =?utf-8?B?T2E1QTlBTHQ3ekxBMmd1MjBuZUNvRWxzTHNnU2dLVE5mcW84b2Zva1VjM3Fj?=
 =?utf-8?B?Mk9XRTgvdFExQUU5NUtyRGdTelFDRzJXaldXeXo2b252OTNKaEJybGFGRzBK?=
 =?utf-8?B?RlhMWGRMbkt2S2I5MEd0bHV3Sy9taWt4MGRUS0N5ZjA2K3dJU0FCay9oS1hP?=
 =?utf-8?B?Wjdsc3B4T2ZTWkhObEwvTVpQTXFPRG9yTWJHVVBHYy9KdjY5Y1lWUi80VHBl?=
 =?utf-8?B?Yi9tZldKY08rWU4weDRiQ3RXYzVjb09tUzZXaHY4OHVNVzI3WWJRRzEzdWZt?=
 =?utf-8?B?WDkzbXMxZ0doMmk1MjZTOHlOdE84MnBXcjd3QnZIaG9VZTNIbElpRWdPTlpP?=
 =?utf-8?B?SjVqQ0RsZnhOTTdHcEg5QUI5OFdscC8wYkN1cG4xbzZzRXNSYWNRckhiRlgy?=
 =?utf-8?B?N0pOTDlTQUtMNTJ3VUtYWXpDem05ZzY5elN5ZkFWNUhJbU9nbmx4eWlFQSts?=
 =?utf-8?B?cDVxYkNFTDRuK1BydlREZnJTSTBERE11djQ5RHRTaVZwcUFtNHlsVmpEbXgr?=
 =?utf-8?B?N2hvLzBpUTJpY05pZEJ2azJJWVlmQVptT1llODBzNmNId01WbG1qMkt3L3hB?=
 =?utf-8?B?a0Jlbk1UZ2k0c2lsd0c5bjFOM2hEMDRJQXhIQ3ZKNUFWRFI3L21lOHR6b0lD?=
 =?utf-8?B?Vy9rQlNqK2c4UFoyZHlkTitScW1zRmpJRnVIODk1a2x0R2REWGxZTmRYWU1S?=
 =?utf-8?B?cGtuWVpGZEpqTFQ3OVVReFRqL3BFZ2xxbnppWnI1ZDUzMWUzZjBHYldZUGRW?=
 =?utf-8?B?Y1JOczFKTzY5Z3pNL21LWEQvS29FcTFBRXBBZE8zbDIxQ3FWcVBSU2ROOTFG?=
 =?utf-8?B?TWJqZFhkL2o4dmEzbVlKRkJ2VTc5bGFtUDVjZzhSRDBCV1BJRU85WkpJbEpR?=
 =?utf-8?B?L2ZWMzV4TlBvdW83ZURaRy9wbXR1dkhLUUdlUlROemNGUmdFbVRxNXljbnNF?=
 =?utf-8?B?TXNhb3k3RlJwekZRQm4vNmg3d3ZsQVNOUitkQnRMZjNmWWp1TUdRZUZjQk5G?=
 =?utf-8?B?T0M5elNrSElZOWN0NHl2aDlPbGF5UGd4YjJSZU1sSk1Nbkk4cldJWHViRk9l?=
 =?utf-8?B?MkluL0ZYL294aTVBR1g3NndyWkxWbXNXQ1psMWhnN2VUNldDUSt6UGxFZWFs?=
 =?utf-8?Q?a5cSTWp3g2arydfw/zYt4bPT6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de75acaf-6897-4f34-ebd3-08de0d2551da
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 02:31:47.1263 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0F7H0g+BGNogRo5ThpSxhVN1aGZtYs72Aqj8K0NhVkttBKqIb/0GQHQbqjenpcGLnzdHeH2CcjMLzLFlbaL3sRkN2z7XNzcoUnImZOddhtQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7715
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIDQvNV0gaW50ZWxfaW9tbXU6
IE9wdGltaXplIHVubWFwX2JpdG1hcCBkdXJpbmcNCj5taWdyYXRpb24NCj4NCj5PbiAxMC8xNi8y
NSAxMTo1MywgWWkgTGl1IHdyb3RlOg0KPj4gT24gMjAyNS8xMC8xNiAxNjo0OCwgRHVhbiwgWmhl
bnpob25nIHdyb3RlOg0KPj4+DQo+Pj4+Pj4+Pj4+IGhvdyBhYm91dCBhbiBlbXB0eSBpb3ZhX3Ry
ZWU/IElmIGd1ZXN0IGhhcyBub3QgbWFwcGVkIGFueXRoaW5nDQo+Zm9yDQo+Pj4+Pj4gdGhlDQo+
Pj4+Pj4+Pj4+IGRldmljZSwgdGhlIHRyZWUgaXMgZW1wdHkuIEFuZCBpdCBpcyBmaW5lIHRvIG5v
dCB1bm1hcCBhbnl0aW5nLg0KPldoaWxlLA0KPj4+Pj4+Pj4+PiBpZiB0aGUgZGV2aWNlIGlzIGF0
dGFjaGVkIHRvIGFuIGlkZW50aWZ5IGRvbWFpbiwgdGhlIGlvdmFfdHJlZSBpcw0KPmVtcHR5DQo+
Pj4+Pj4+Pj4+IGFzIHdlbGwuIEFyZSB3ZSBzdXJlIHRoYXQgd2UgbmVlZCBub3QgdG8gdW5tYXAg
YW55dGhpbmcgaGVyZT8gSXQNCj4+Pj4gbG9va3MNCj4+Pj4+Pj4+Pj4gdGhlIGFuc3dlciBpcyB5
ZXMuIEJ1dCBJJ20gc3VzcGVjdGluZyB0aGUgdW5tYXAgZmFpbHVyZSB3aWxsDQo+aGFwcGVuIGlu
DQo+Pj4+Pj4+Pj4+IHRoZSB2ZmlvIHNpZGU/IElmIHllcywgbmVlZCB0byBjb25zaWRlciBhIGNv
bXBsZXRlIGZpeC4gOikNCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IE5vdCBnZXQgd2hhdCBmYWlsdXJl
IHdpbGwgaGFwcGVuLCBjb3VsZCB5b3UgZWxhYm9yYXRlPw0KPj4+Pj4+Pj4+IEluIGNhc2Ugb2Yg
aWRlbnRpdHkgZG9tYWluLCBJT01NVSBtZW1vcnkgcmVnaW9uIGlzIGRpc2FibGVkLCBubw0KPj4+
PiBpb21tdQ0KPj4+Pj4+Pj4+IG5vdGlmaWVyIHdpbGwgZXZlciBiZSB0cmlnZ2VyZWQuIHZmaW9f
bGlzdGVuZXIgbW9uaXRvcnMgbWVtb3J5DQo+YWRkcmVzcw0KPj4+Pj4+Pj4gc3BhY2UsDQo+Pj4+
Pj4+Pj4gaWYgYW55IG1lbW9yeSByZWdpb24gaXMgZGlzYWJsZWQsIHZmaW9fbGlzdGVuZXIgd2ls
bCBjYXRjaCBpdCBhbmQgZG8NCj5kaXJ0eQ0KPj4+Pj4+Pj4gdHJhY2tpbmcuDQo+Pj4+Pj4+Pg0K
Pj4+Pj4+Pj4gTXkgcXVlc3Rpb24gY29tZXMgZnJvbSB0aGUgcmVhc29uIHdoeSBETUEgdW5tYXAg
ZmFpbHMuIEl0IGlzIGR1ZQ0KPnRvDQo+Pj4+Pj4+PiBhIGJpZyByYW5nZSBpcyBnaXZlbiB0byBr
ZXJuZWwgd2hpbGUga2VybmVsIGRvZXMgbm90IHN1cHBvcnQuIFNvIGlmDQo+Pj4+Pj4+PiBWRklP
IGdpdmVzIGEgYmlnIHJhbmdlIGFzIHdlbGwsIGl0IHNob3VsZCBmYWlsIGFzIHdlbGwuIEFuZCB0
aGlzIGlzDQo+Pj4+Pj4+PiBwb3NzaWJsZSB3aGVuIGd1ZXN0IChhIFZNIHdpdGggbGFyZ2Ugc2l6
ZSBtZW1vcnkpIHN3aXRjaGVzIGZyb20NCj4+Pj4gaWRlbnRpZnkNCj4+Pj4+Pj4+IGRvbWFpbiB0
byBhIHBhZ2luZyBkb21haW4uIEluIHRoaXMgY2FzZSwgdmZpb19saXN0ZW5lciB3aWxsIHVubWFw
IGFsbA0KPj4+Pj4+Pj4gdGhlIHN5c3RlbSBNUnMuIEFuZCBpdCBjYW4gYmUgYSBiaWcgcmFuZ2Ug
aWYgVk0gc2l6ZSBpcyBiaWcgZW5vdWdoLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBHb3QgeW91IHBvaW50
LiBZZXMsIGN1cnJlbnRseSB2ZmlvX3R5cGUxIGRyaXZlciBsaW1pdHMgdW5tYXBfYml0bWFwDQo+
dG8NCj4+Pj4gOFRCDQo+Pj4+Pj4gc2l6ZS4NCj4+Pj4+Pj4gSWYgZ3Vlc3QgbWVtb3J5IGlzIGxh
cmdlIGVub3VnaCBhbmQgbGVhZCB0byBhIG1lbW9yeSByZWdpb24gb2YNCj5tb3JlDQo+Pj4+IHRo
YW4NCj4+Pj4+PiA4VEIgc2l6ZSwNCj4+Pj4+Pj4gdW5tYXBfYml0bWFwIHdpbGwgZmFpbC4gSXQn
cyBhIHJhcmUgY2FzZSB0byBsaXZlIG1pZ3JhdGUgVk0gd2l0aCBtb3JlDQo+dGhhbg0KPj4+Pj4+
IDhUQiBtZW1vcnksDQo+Pj4+Pj4+IGluc3RlYWQgb2YgZml4aW5nIGl0IGluIHFlbXUgd2l0aCBj
b21wbGV4IGNoYW5nZSwgSSdkIHN1Z2dlc3QgdG8gYnVtcA0KPj4+PiBiZWxvdw0KPj4+Pj4+IE1B
Q1JPDQo+Pj4+Pj4+IHZhbHVlIHRvIGVubGFyZ2UgdGhlIGxpbWl0IGluIGtlcm5lbCwgb3Igc3dp
dGNoIHRvIHVzZSBpb21tdWZkIHdoaWNoDQo+Pj4+IGRvZXNuJ3QNCj4+Pj4+PiBoYXZlIHN1Y2gg
bGltaXQuDQo+Pj4+Pj4NCj4+Pj4+PiBUaGlzIGxpbWl0IHNoYWxsIG5vdCBhZmZlY3QgdGhlIHVz
YWdlIG9mIGRldmljZSBkaXJ0eSB0cmFja2luZy4gcmlnaHQ/DQo+Pj4+Pj4gSWYgeWVzLCBhZGQg
c29tZXRoaW5nIHRvIHRlbGwgdXNlciB1c2UgaW9tbXVmZCBiYWNrZW5kIGlzIGJldHRlci4gZS5n
DQo+Pj4+Pj4gaWYgbWVtb3J5IHNpemUgaXMgYmlnZ2VyIHRoYW4gdGhlIGxpbWl0IG9mIHZmaW8g
aW9tbXUgdHlwZTEncyBkaXJ0eQ0KPj4+Pj4+IGJpdG1hcCBsaW1pdCAocXVlcnkgY2FwX21pZy5t
YXhfZGlydHlfYml0bWFwX3NpemUpLCB0aGVuIGZhaWwgdXNlciBpZg0KPj4+Pj4+IHVzZXIgd2Fu
dHMgbWlncmF0aW9uIGNhcGFiaWxpdHkuDQo+Pj4+Pg0KPj4+Pj4gRG8geW91IG1lYW4ganVzdCBk
aXJ0eSB0cmFja2luZyBpbnN0ZWFkIG9mIG1pZ3JhdGlvbiwgbGlrZSBkaXJ0eXJhdGU/DQo+Pj4+
PiBJbiB0aGF0IGNhc2UsIHRoZXJlIGlzIGVycm9yIHByaW50IGFzIGFib3ZlLCBJIHRoaW5rIHRo
YXQncyBlbm91Z2ggYXMgYSBoaW50Pw0KPj4+Pg0KPj4+PiBpdCdzIG5vdCByZWxhdGVkIHRvIGRp
cnlyYXRlLg0KPj4+Pg0KPj4+Pj4gSSBndWVzcyB5b3UgbWVhbiB0byBhZGQgYSBtaWdyYXRpb24g
YmxvY2tlciBpZiBsaW1pdCBpcyByZWFjaGVkPyBJdCdzIGhhcmQNCj4+Pj4+IGJlY2F1c2UgdGhl
IGxpbWl0IGlzIG9ubHkgaGVscGZ1bCBmb3IgaWRlbnRpdHkgZG9tYWluLCBETUEgZG9tYWluIGlu
DQo+Z3Vlc3QNCj4+Pj4+IGRvZXNuJ3QgaGF2ZSBzdWNoIGxpbWl0LCBhbmQgd2UgY2FuJ3Qga25v
dyBndWVzdCdzIGNob2ljZSBvZiBkb21haW4NCj50eXBlDQo+Pj4+PiBvZiBlYWNoIFZGSU8gZGV2
aWNlIGF0dGFjaGVkLg0KPj4+Pg0KPj4+PiBJIG1lYW50IGEgYmxvY2tlciB0byBib290IFFFTVUg
aWYgdGhlcmUgaXMgbGltaXQuIHNvbWV0aGluZyBsaWtlIGJlbG93Og0KPj4+Pg0KPj4+PiDCoMKg
wqDCoGlmIChWTSBtZW1vcnkgPiA4VEIgJiYgbGVnYWN5X2NvbnRhaW5lcl9iYWNrZW5kICYmDQo+
Pj4+IG1pZ3JhdGlvbl9lbmFibGVkKQ0KPj4+PiDCoMKgwqDCoMKgwqDCoCBmYWlsIHRoZSBWTSBi
b290Lg0KPj4+DQo+Pj4gT0ssIHdpbGwgYWRkIGJlbG93IHRvIHZmaW9fbWlncmF0aW9uX3JlYWxp
emUoKSB3aXRoIGFuIGV4dHJhIHBhdGNoOg0KPj4NCj4+IHllYWgsIGxldCdzIHNlZSBBbGV4IGFu
ZCBDZWRyaWMncyBmZWVkYmFjay4NCj4+DQo+Pj4gwqDCoMKgwqAgaWYgKCF2YmFzZWRldi0+aW9t
bXVmZCAmJiBjdXJyZW50X21hY2hpbmUtPnJhbV9zaXplID4gOCAqIFRpQikNCj57DQo+Pj4gwqDC
oMKgwqDCoMKgwqDCoCAvKg0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAqIFRoZSA4VEIgY29tZXMg
ZnJvbSBkZWZhdWx0IGtlcm5lbCBhbmQgUUVNVSBjb25maWcsIGl0DQo+bWF5IGJlDQo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgICogY29uc2VydmF0aXZlIGhlcmUgYXMgVk0gY2FuIHVzZSBsYXJnZSBw
YWdlIG9yIHJ1biB3aXRoDQo+dklPTU1VDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgICogc28gdGhl
IGxpbWl0YXRpb24gbWF5IGJlIHJlbGF4ZWQuIEJ1dCA4VEIgaXMgYWxyZWFkeSBxdWl0ZQ0KPj4+
IMKgwqDCoMKgwqDCoMKgwqDCoCAqIGxhcmdlIGZvciBsaXZlIG1pZ3JhdGlvbi4gT25lIGNhbiBh
bHNvIHN3aXRjaCB0byB1c2UNCj5JT01NVUZEDQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgICogYmFj
a2VuZCBpZiB0aGVyZSBpcyBhIG5lZWQgdG8gbWlncmF0ZSBsYXJnZSBWTS4NCj4+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgKi8NCj4+DQo+PiBpbnN0ZWFkIG9mIGhhcmQgY29kZSA4VEIuIE1heSBjb252
ZXJ0IGNhcF9taWcubWF4X2RpcnR5X2JpdG1hcF9zaXplIHRvDQo+PiBtZW1vcnkgc2l6ZS4gOikN
Cj55ZXMuIEl0IHdvdWxkIHJlZmxlY3QgYmV0dGVyIHRoYXQgaXQncyBhIFZGSU8gZGlydHkgdHJh
Y2tpbmcgbGltaXRhdGlvbi4NCj4NCj4NCj5aaGVuemhvbmcsDQo+DQo+U29mdCBmcmVlemUgaXMg
dzQ1LiBJIHBsYW4gdG8gc2VuZCBhIFBSIG5leHQgd2VlaywgdzQzLCBhbmQgSSB3aWxsIGJlIG91
dA0KPnc0NC4gSSB3aWxsIGhhdmUgc29tZSAobGltaXRlZCkgdGltZSB0byBhZGRyZXNzIG1vcmUg
Y2hhbmdlcyBvbiB3NDUuDQoNCkdvdCBpdCwgSSdsbCBzZW5kIGEgbmV3IHZlcnNpb24gc29vbi4N
Cg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

