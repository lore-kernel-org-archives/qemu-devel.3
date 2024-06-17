Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DCAC27C53
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 01:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ1Ci-0001MY-MW; Sun, 16 Jun 2024 21:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sJ1Cf-0001M7-Aw
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 21:30:37 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sJ1Cd-0002sp-Mx
 for qemu-devel@nongnu.org; Sun, 16 Jun 2024 21:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718587836; x=1750123836;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=q4QGSq3WNBpT0qtw6jiha/AXE8pU5l40t8lcGVUPhrI=;
 b=j8c7BIgXBnRsRKcVSerMJRUNGIgBrqTqTKmi73AqEPL+sBfAkVZsSKy3
 8Yso7fAf0H0jzIheTcr5vZ4/eFf2J4SPjpeethgPRH4Bilq5RT/7kiBCI
 f5lzvQW87fPY8VPvqYVlsYsVGjggHnyJ5xwk7LLXDznT+crrcR9JnD9Ne
 cYZqk0+8yTqrAI9kDXe4aMqr5HVi4AIvCKDfSvB3ZB6o7oPtYhQ+VzXHE
 wJEXUxtuvKHRBld3b0BjAlg6+g4RVxEp/WoKkTvYnO/+6rCgII+IE6ZbT
 BlzY47wapqeTA4yEPWMnWsJKx+UoBc1un4rWvjhDbNpqpEfhZQ4/FEebL g==;
X-CSE-ConnectionGUID: J/gFUZEuSLW6diVA6Ri3Ww==
X-CSE-MsgGUID: qQzLvhNRSgald62bYJpD6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="26823626"
X-IronPort-AV: E=Sophos;i="6.08,243,1712646000"; d="scan'208";a="26823626"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2024 18:30:34 -0700
X-CSE-ConnectionGUID: +7OTVzuaRKeZJ3CIVv23qA==
X-CSE-MsgGUID: 15RW/uwRTOu9QUuJccG1Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,243,1712646000"; d="scan'208";a="41527544"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Jun 2024 18:30:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 16 Jun 2024 18:30:32 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 16 Jun 2024 18:30:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 16 Jun 2024 18:30:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0my4Ct6csA21lDHg5bdlj8+K50yipq3bdg8j9kKfYvEUsRSY8keRUMdtrms7O7S3id+8F/PiRT5hmCMu/LLE8zTNml1MvBTj6GZa0DkyQokZFV4vN5T52d/hVGAwWH8XHfoPA6s3HhoKyhXvArh2GQa3GhNl48RgKdPe8plhK3rh2Vg15zg5lQN1rs3q1NvN1/FyYSK3+N9gDYeTmodgRj9Qab8/AEkavkffA07Tjy3mkY6zVMmrtJ1JRLiDL4YujqPWcfd4P97WZSJEc7rLFTZFO00Cq8fro4n1TGUQuFXA5OnDSAShBN2yw+rAQNAb2X0sIW8sOTw1khyJSzWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4QGSq3WNBpT0qtw6jiha/AXE8pU5l40t8lcGVUPhrI=;
 b=YnDkrQ1ZNSMYDipbKBZQbWTxw/8jXICPnMlg9CRHx+NyNLyzcFp/KbV9AgvOQio0q5l3q/jR1B4mdNQf68KeVYnCOlVQ1uSgIPOX59CTb80qIwvNqsjtaELzC3GKONY5j28YcSI/nDJlWSKV3+nfnJdU4kOdpH2luf5gCH9ZR1/sXcSGKJD6xD39fJAQiWyiz+yq2MwjwypjvsmpaY6xvxlYyN+7AScPeGtupBFZsG58DsbxOo66WBL+aON+c2bv2VYI0MnvS7kRg4h7lv2q6rEc+3rusg/dgo0UehvSCIB9RhubRHdUFJb8ql7yklA7XqHqON0DcDN/yKqxG/JEYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7852.namprd11.prod.outlook.com (2603:10b6:8:fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 01:30:30 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 01:30:30 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v1 00/16] vfio: QOMify VFIOContainer
Thread-Topic: [PATCH v1 00/16] vfio: QOMify VFIOContainer
Thread-Index: AQHavMjfG76QWzn6cUaegnojEZMKJ7HLMTUg
Date: Mon, 17 Jun 2024 01:30:30 +0000
Message-ID: <SJ0PR11MB6744DE0A0E679C54CC4A24AD92CD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240612130122.813935-1-clg@redhat.com>
In-Reply-To: <20240612130122.813935-1-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7852:EE_
x-ms-office365-filtering-correlation-id: e1c5e61d-421d-4c5a-0c75-08dc8e6d1310
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?OGdRSnJ4VlpCMm9ucnFVeGZFNUpxc1U0R0R3Sjg0Q3VWNVVDUXp6YU5ZMm5H?=
 =?utf-8?B?c0tnenBlTnVFc3MxV0lFdWlqUERQbElCZ3RmRXZTcUl4T2ZGWFNyUkg5U3FZ?=
 =?utf-8?B?c2RkODhrOHFqSStpMmdiNmxEekNFRkllNUFpZ21MNWNUUWI0c095NUlZV1gv?=
 =?utf-8?B?clB6SlFtUlZ1bUkyZk1rVUNJREVvWTNYdkFmWjhnVlhDUHZyWUJDNFFjOFVx?=
 =?utf-8?B?VTI0bExHdC8rWUZWSXg5QXgzVmY4dHVxUnN3TFg1M1hIRFJsdEJ0TGx3Nzdw?=
 =?utf-8?B?V1l0dWNURkwwN3ZHL3oxeWxBcXIzWmlVT3U3bVlGeTRnZHNMbE9YV0dGd3hK?=
 =?utf-8?B?Rnk4TW9FTTE1Y2FhNS84bkdWa2FscWduQ3lzcHVSQ2QyQno5KzFSdXdUYUlR?=
 =?utf-8?B?bUN2K3lMcmtRQi9BSXVBbzBEYWlPbVI2MGRVcC8zb0RxdHpQaDdQRUk1MzVL?=
 =?utf-8?B?Mmc2RFRzeHZCMzl0T0JjNXRtT3VSV1NWT0xRMGxlQlNESnJyVTNZejNWeWRt?=
 =?utf-8?B?ZnJRbnpRT3NuNTVZUTQrTUIycHZqRDZHNTBCbDJZTDR6UHFmdHpvWS8wMXVm?=
 =?utf-8?B?dHVoRzVKeTBhZ1BTRWdYalRQMVZPTlZpZ0c5QWU5Z1FVeVFqTE1Nc1lJbjM4?=
 =?utf-8?B?dVRlSXNSa1VkQ1JQS2ZmcmR4SEJ4cXZkMmFaZHI1WVhJTlhtM0F2MVh1RE1R?=
 =?utf-8?B?U2ZoWldQMWFDTzJoYVNvK3BjYkdUa05pZDczTUsxL0pSV2x3WW1iMCtSRlRp?=
 =?utf-8?B?aGFKVDJaWk84Rk83MjA2UmcrL3hSR21qeXhBUC9jWVhUWjc1ZU9GRjQ1NUhI?=
 =?utf-8?B?V3dESnMwTmE0T2VDcmhpVlNqZFQrQzl1U0NtZUs3RWR3eFVWQ29iSFBHbkpV?=
 =?utf-8?B?SGQzVkFPZU1iMHFEM2JyWnRWeFVld0FDUElwY25OZE1wTTRYOERVK2tlNDEv?=
 =?utf-8?B?anRVaEhDSHhWTEh1T3lsSVhibmhvM3UxMkVvSUJRdHY4Z0ZNaUV2U0R5OVl5?=
 =?utf-8?B?aURFd1JDWmQyRnZFcldlRzV3RmQ2S1BhTG9MdytXN3dGZjQyc1BBTFFJdERU?=
 =?utf-8?B?WlhVZDh4dzVtWmlPNWpQVXEwZ28rV0VGc3plYmF4Rm5heCt5cklrZVdvSlJH?=
 =?utf-8?B?TFNHMjVHcU9wWVFYTU1RQ0hKdkN3RUlSSDl2TXloamFXUU5kTm0xOWM3MGxt?=
 =?utf-8?B?c2p6aEtMUEdXRUZ5MmJWYVhMUHBGWitNMDhRNDdGVlY5dFdLYTBxWHVOR2JC?=
 =?utf-8?B?VC80QlVqUW94SkVwdWJTcXFCdk1STzQ1K0RVT1pueTVERWJnS3lPTHlTTmlX?=
 =?utf-8?B?b2Z1U09OVSt2SkJHVWI0M29zN0puSWIrOHArWEtibklZeXllL0o0MmRHRE9t?=
 =?utf-8?B?N2pqWXFQbmRETWlTZmFyTTBMVGlzM2RUeERHcSs4T2U5VGZaTXQxdU1aTGtG?=
 =?utf-8?B?Q2JhRWpvRnhLN1d0ZVBXOCswSnJ1VlU5MTFwZXM2ajVuTlJvNU14ZjFVekVX?=
 =?utf-8?B?OE9BMTlJUUZLU0dOZFJkUGhCQjFsRTR1S09WeGhIdVI1NG5UR1hNZ1VTaVhS?=
 =?utf-8?B?d0ViNUxNeTBuQUtsVEwwck9zU0IybjlSUDJxWFYyQjdyYmVEZ3VjbjRDTzBC?=
 =?utf-8?B?aExjY0ZYYk95VXdMekQ1YUN4S0p1R3pEUCtKN3Q3TUZnSmpHaTEwSHpvUFBi?=
 =?utf-8?B?azVoWnlETndSbVg1S0pabXZxQ0JuY1lMQS9uOW9WT3JVR0hEbTEzMnJ6Z29O?=
 =?utf-8?B?NkpDSWgreCtSSGtIc0krc2ZqeEl6cnNvUC9EMUtPeHE3R1NoZy91TUJhRTVJ?=
 =?utf-8?Q?4B64MZ5ImVWIKejqS+sJznRQV0R4ie3GEt6ZU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(376011)(1800799021)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEIvYTZUVE1yclR4c096eHpwQVR6YTZKN2VnVit2VG9CZHlRc3BWdHpiTW1y?=
 =?utf-8?B?ekVvMVFWS1RNcXprTHMzb3EvQlg2YStCT3AwUWM2TjBvRlBHSHZMaFJiNnhq?=
 =?utf-8?B?OUh4VkoxNnVuaTRzVXF5WEJQV0VSRU5hQU5ZS2xFd0J1eDlkRFhoMk1EV21L?=
 =?utf-8?B?dklNVzBaSk9KTzN1TVV4SU5XcGFOWUordjdJc2doYjhTSCtKbFBvWHhsdXp4?=
 =?utf-8?B?YkM4MkpWYjg0Nkg4V0dOalZpOXlWYUV6c3JiRUlFRXRsVHRkMnZGTUUzLzln?=
 =?utf-8?B?Qmg2TXVlVmFqeFdhdDI4M3RHbHIxcjBkWitnK2tOTGwzK3ljOUU2b0g3bGVG?=
 =?utf-8?B?UTJzRFlBMnRpQ3FpaEhFVVNKcXNDTzdoaUdkRHNuaFlSQUlwek9Ub3ZRWnJF?=
 =?utf-8?B?YUx1bmx3blI0MFFKNnJrN2g5ek41TmJtMHRDWXNrcnR1VGM2MGpnamd6WWpM?=
 =?utf-8?B?Mk4vOFI0V3pBelU1RDJhYk0xaGw1UkliV2t5RjBKSGU1VWJadzhyRUNhcE9l?=
 =?utf-8?B?UDlwK1JGcWhnYWlJN1k1SHZxeHljSS9zeHN3MjlqV2x1eHJJWlk1MW12VENR?=
 =?utf-8?B?bUdRNDZ0emh2U3QrbW5TcU52Ly9sbFNkbVlxVG82bG9xUUtpeGhZdUtoYjRD?=
 =?utf-8?B?OHdUU00yMjFLTlFreW11NVMzVmpKTVp1d0ZkSkpVWWxnOEdlQkJETzlsMDRQ?=
 =?utf-8?B?S0kwNERBTXE5YjEvVkRiVGc0UVFWaG1TSGQza2VmSVpQRW9TRzRVOVJzY3Q3?=
 =?utf-8?B?YXRlV3ZPVWpEV2xqbjF2MjhlUkZrTzQrZ1c0WXpHUHRJeEVrN0wxK0FJb09t?=
 =?utf-8?B?NGYxMHoyRFNsVHZKNGdGbEdsZmhTc1U4NGp2WWUwV2l3RUNtRUN0VFdzWEZP?=
 =?utf-8?B?RUh0cGRkL2xzVHBaNWdLNGlyeForMTdUaVBjM0tjRkhMUGVlb25ZOUNhVU5k?=
 =?utf-8?B?OTg4b1d2alBqTTNhUGVJMExHTk1ISUhFbEE5VEFGWnNUcWRURmR0dEJEa3pF?=
 =?utf-8?B?eUZVMXVMdDNBcnJ4ZWNRdk5wMUVZT0F1TTdOOXBScXNFSXpxYVF2UEFSTjFY?=
 =?utf-8?B?NUVJN3pwUUlhWkJ4S0NGYklicHZxK2Z2VHM3cWUwd3U1MUNHWXFPYU84a1pz?=
 =?utf-8?B?K3RxYmZlN1dnREtZQ1h2aEROM01jRmVGVCtMT29ESVFPSWdQZEV0Yi8vVE5h?=
 =?utf-8?B?NVlzaHV1S2dvWk1WSS9xdWZwREtlZUNhLzhTMTQxRFUvVWFmcmFmU1c5dVlx?=
 =?utf-8?B?WXBxaE5ZVitFbk1uczUwUXBYaWY1THllVVkxTFlSQVY5RUszRngzMTJxejhZ?=
 =?utf-8?B?TXJuQk1BVVJmZXV3b1RuOC9BL3VVNXo1ZmRpTWlJbDBVR1RGRFdnZjNBRzdR?=
 =?utf-8?B?VFBINmpvbDNkZ2o3RHFzSE9KRGRvcVVQMi9td0RxY1Q4ZXl5VG1NcW5ZM21S?=
 =?utf-8?B?UHhmRGZ3cW5LQVdtRElsSkErQUc5UjdUUS90T0RhOUYyK3pkUVlQZm16MUlz?=
 =?utf-8?B?L25wb0luQTFuci96KzBtdlUyLytyY3BzNWQzRjdBQWpzbENJWG0vajR2NThV?=
 =?utf-8?B?OTNlL1E3YlNmbmtaK2tBMjVhWVR0TjYrQ1p0eE9oa2g3UUVTUWJ1MFJjNWI1?=
 =?utf-8?B?Q29ORGRCaE13ZmRKTmJPTU5zL0pnSFk4RzVXRWJUY3dvMDNvNDkzOEF0YnpX?=
 =?utf-8?B?TUhHaXlUWWpwa0szVUsvNlFTUlM0QTFkYk5KQjc5cGtBZHRualFwcE5pWjBo?=
 =?utf-8?B?Z3diWGtkbnlma3crbDZMSFBzeFZiSFFPcytnZHpzWnVFa2lkNU5PVU1hdVFD?=
 =?utf-8?B?ajJFSXJJTnVVZWFiU1RJcytJUWNrcVhjdktaRkg2amwwN3lHcURjS3lkR2JL?=
 =?utf-8?B?TysxL1pxYXFnSlpCamtZTDkzd2Vqa00rOWtZWmZZdjRUZHlDSW9ncWZaSWkw?=
 =?utf-8?B?UDgwQkNwLzNJSHA0YUJvU3RsU2M2eUNHWFRPK212Qy9xUFlYSFB6TXJ5RUNY?=
 =?utf-8?B?VDdFWWV2L3M2MVdhQUxvSlNuWW1FNDZ2SVNhREtFc3lkWTRBWER1YmI5QUFT?=
 =?utf-8?B?ZGQyOEQ1N3AwNUtnY3NWN0Rld2FjN01QV0kyVElySU1WSTJ2cGpEczZ6NVRn?=
 =?utf-8?Q?qzN8OqCvIRwW/Yfdl+5OQpvku?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c5e61d-421d-4c5a-0c75-08dc8e6d1310
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2024 01:30:30.2037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1sAQv2UClAmB/9HdQV2e43Y31fOgRMYHen8HUS+4DkvUSTzAc94tid8+7tudaAr9TcAfrR5srZbh6uxyUJzOmkt3tgIg0dFUpSDe14aNXw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7852
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFtQQVRDSCB2MSAwMC8xNl0g
dmZpbzogUU9NaWZ5IFZGSU9Db250YWluZXINCj4NCj5IZWxsbywNCj4NCj5UaGUgc2VyaWVzIHN0
YXJ0cyB3aXRoIHNpbXBsZSBjaGFuZ2VzIChwYXRjaCAxLTQpLiBUd28gb2Ygd2hpY2ggd2VyZQ0K
PmluaXRpYWx5IHNlbnQgYnkgSm9hbyBpbiBhIHNlcmllcyBhZGRpbmcgVkZJTyBtaWdyYXRpb24g
c3VwcG9ydCB3aXRoDQo+dklPTU1VIFsxXS4NCj4NCj5UaGUgY2hhbmdlcyBmb2xsb3dpbmcgcHJl
cGFyZSBWRklPQ29udGFpbmVyIGZvciBRT01pZmljYXRpb24sIHN3aXRjaA0KPnRoZSBjb250YWlu
ZXIgbW9kZWxzIHRvIFFPTSB3aGVuIHJlYWR5IGFuZCBhZGQgc29tZSBmaW5hbCBjbGVhbnVwcy4N
Cg0KRXhjZXB0IGNvbW1lbnQgb24gcGF0Y2ggMTEgYW5kIDE1LA0KT3RoZXJzIExHVE0sIHNvIGZv
ciBvdGhlciBwYXRjaGVzLA0KDQpSZXZpZXdlZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbT4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

