Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4831C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 15:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRZYH-00058n-Kl; Wed, 10 Jul 2024 11:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sRZYF-00056H-Sp
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:48:16 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sRZYC-0004Qy-Pu
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720626493; x=1752162493;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8exE5unIRQOd2ObdDXTxKNqkOqjiYoQKVHRXLnd/Okg=;
 b=JJpfib0rbvBHp61vegW4oX1SixZAH/+984LYGBsVyyd6ehhbX0m0yZDH
 O0rmBHXgWfw1JvaSZFgkC1yvsj35CH8rxILvnd+fNnOjaTArSrQqv69oq
 37fGzuL9YldOuM4JjTQNXfxb38p76qdhWzmUOVKQGbB7hNQ7Qk30VbBFc
 eRgAuW1/PoNb7Itt/0aT0M0bG8rinsLNg6nAxnl+9uCMA+Zj8r3Qc875A
 iNUlM5b9W8hzUGiWGikiPkDbuQgXTlganGYmWfuC+388NsS3PgCUltq+7
 WaoUkbvSf9PmKxq5/dtQrH/2DTDsXK5vvyJr+AmMpjlBwUJ7DC7V1Jx1M Q==;
X-CSE-ConnectionGUID: otK92ptORdOwlQ04ZVaT9Q==
X-CSE-MsgGUID: M4jpvHexTa+bAFAKTIF0Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="43382356"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; d="scan'208";a="43382356"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2024 08:39:48 -0700
X-CSE-ConnectionGUID: t3JT4b4fRbKXagr8ELJ6GA==
X-CSE-MsgGUID: SV9hEsqAQUOildzRL/qJiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; d="scan'208";a="48229888"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Jul 2024 08:39:49 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 08:39:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 08:39:47 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 08:39:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cH5oHpC1GE5DEw0vsKGiWHZ8xnMref8e/sUFIyAZTUz2c1K0mujL+E92s2oiVvA13xvDQM327okrgKTy+p+NFRUeq9MOxsSVl28QK+qJJAe7bBHK/xUBcS412fgIwMnW7FNQNgGbgkdhBu0OdwoxqY9xyFbc8sgepcOnXcIaR9vZnHNnYgMf5qMGl53Wg8XcVjuJeEI5SW5TgD4vYagWC4LHe1kVn08hff+tKmsvqpnqj1zvsP+vVD47oFtFzuQK2cj0OYN5D4OtIgPVzptNMYLyexbg68LJgp3fH8lk87b/5zXv4DbGakMrJysNLD3ZdKhefPqxy3ZkR8wrzuqu0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8exE5unIRQOd2ObdDXTxKNqkOqjiYoQKVHRXLnd/Okg=;
 b=hdBzdL7rGUQ1bSppHu8N7KgP6sBcE5Tzt1rLcN/je6OvtCX5ZCY4QaPre59L7M3xNGND9nDldhTGyEPEMfgbQw1+KD0c9EnJ5KiRG69V/oe5Js8mqJgizPYTIv9VUi5qwDhVx4Nbr+0LlDxRhQ/lb2KVhwqnxc7rUByWO8zs+KI3bTRnBbTLkj/cKqPSKrinsK0oQmVZEhdqqzNgkeNwiOV2YM1pLtZ9visTwgz4i3XwfefL5weKcrB/Y+Fn1ohDXs620oJNn8sNrdGjjKphIOTI10rvkBA9s8DGKMXsuyY0CiKVhstLd7x6gT4ZA/nkP8HYbKfHL+H3yBKgk+Nl7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by CH3PR11MB8154.namprd11.prod.outlook.com (2603:10b6:610:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 15:39:43 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%7]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 15:39:43 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "Wang, Yichen" <yichen.wang@bytedance.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "Thomas
 Huth" <thuth@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Fabiano Rosas <farosas@suse.de>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Hao
 Xiang" <hao.xiang@linux.dev>, "Zou, Nanhai" <nanhai.zou@intel.com>, "Ho-Ren
 (Jack) Chuang" <horenchuang@bytedance.com>
Subject: RE: [PATCH v4 0/4] Implement using Intel QAT to offload ZLIB
Thread-Topic: [PATCH v4 0/4] Implement using Intel QAT to offload ZLIB
Thread-Index: AQHazwlA8st7GsK/ak2WUIuKtJOJK7Ht++xggADFoQCAAMwAQIAAjVCAgAAA1vA=
Date: Wed, 10 Jul 2024 15:39:43 +0000
Message-ID: <PH7PR11MB5941A602FCA617659E0105A9A3A42@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240705182901.48948-1-yichen.wang@bytedance.com>
 <PH7PR11MB5941B008DD622227FB46E95EA3DB2@PH7PR11MB5941.namprd11.prod.outlook.com>
 <Zo2EsEqAY5KnkO1V@x1n>
 <PH7PR11MB594133AD3E08A6E35D07DD97A3A42@PH7PR11MB5941.namprd11.prod.outlook.com>
 <Zo6mWzuxFET1q81j@x1n>
In-Reply-To: <Zo6mWzuxFET1q81j@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|CH3PR11MB8154:EE_
x-ms-office365-filtering-correlation-id: a322dcc0-7fb0-452e-4086-08dca0f6853e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TFY4OSt3aXhzSUIvbWRqaTEvdm5hK1AzLzQvNUQ2OG5uWm8vcEIrRE4yMHEy?=
 =?utf-8?B?M1JtalArQktFcGV6R3EwTUFwQ0FFMC83VDJieEY4MG1GeHFaYkx2OVdleXpr?=
 =?utf-8?B?NWJCYjR0eWZybTR4TXpLbTNYZXBScTRSREFPUFN3L0tKR01xempnSnVvbEZW?=
 =?utf-8?B?NmJzUG5vdUJPWG10N29TV3l0ci9sOGlNa3ZDRHFNa0lza1duakhCa2pjQTJH?=
 =?utf-8?B?Smg4QnJXc2dMRTBlVHJRYXdDck12a2s0am10MzFhZktVSEY5Ujh0bkZQdStI?=
 =?utf-8?B?ZGFXeGNZdHdyVnh0UzhYQk5sZHROQ3dTc1pGaGg1ODVkbEJKbHpsdFBOQW1B?=
 =?utf-8?B?d2U0anpXOFI3M01kOUkreldCS1VhYjJEclJmWkQzU1I3cHloczcwbW02bHBY?=
 =?utf-8?B?a2Q5dDVKVm04VzVjNHBTS0xScWRTcEgzUG9kbUdDeHhBZGZMdkl3ZWJ3YWF0?=
 =?utf-8?B?YlZFVkUxaGRlV0dVeEJNMWs0aVg3bWVHaEE1MTdhcjFSbCtRQ0REWFZtclpT?=
 =?utf-8?B?OG5TZVlYMXRZR3JuS2xNOCtuZnlsakd4RzFYaWRkclFYRC9EeVJNdEc4U28w?=
 =?utf-8?B?SDRQOHNRdHFrb3ZPVG10eHJwcEVIVUhzYUVxNFU1VGxacGRnSWRTRUcvR1Fn?=
 =?utf-8?B?c3dwNlAyN2ZnbGpEWmlWYmdZaVVLUVhpTTZZTkU5RnJvRHl6TjZuVVIzeVZC?=
 =?utf-8?B?NXJtdmtpS1JrLzViam52OXIvaEY2S1JyMDVGUDA2RC9MU21jU1NzZmlJZ2lP?=
 =?utf-8?B?RXpBazZtNENiSVo3aW4wWDBpUEo2TDBGYXhzenpJL1JXYkhBcjFQaW4zSitZ?=
 =?utf-8?B?U1Fmd1VxN3RGNSs2UXI5MENEMTFRWlVMek1DZ2daKys4UllXcnRhZGVLeVlq?=
 =?utf-8?B?R1hqWkV6VUtNYkhRQndqcXR0aWtKNmRSbElSbWw5V09LWWEvcERZNUpjWktk?=
 =?utf-8?B?T09Ja1dYUW1IRWY0N1RuS2ZrcVMzU1JPVmNLREVKRnhPeHBYdHh1bmc1cXov?=
 =?utf-8?B?NXB2SmJnUWs3ekZLOTRwQ3hTajFocnNYRm8wSjAwdExObUExTkZSSTZNWGha?=
 =?utf-8?B?TERoTzA1L1BrSXNvYWFhK25tNlIrVWM3cXB3WDY5NVRFUFFBajhiNTd0KzI4?=
 =?utf-8?B?aytocUFvWnd6QzZvMkVvVGpEeENVdzFkVnlNZnc1NVNhd3N6K0t4aVo1eXZK?=
 =?utf-8?B?VEp6WTJYOUcvK05LR3pDNkp6d2l2Tm5Hc095bnIzTFhwS2FhZlU1TWNReHc5?=
 =?utf-8?B?L0NzUFkrelo3QkYvSFNBcTVRR2pLN01sb09WbFlFSFltcG9XeE5rd0NQNjBN?=
 =?utf-8?B?ejJWNlFLV0c3N2Q5cFJwZlpTT3c4U2IyVnRxQ3F3SmZUVTJwU2dVcjlueno3?=
 =?utf-8?B?S3JDdXd6SWprNEdVaUdmVmYvQUVrTzhOVEVsVTFmNUZxQndaMExnRUl3bGxt?=
 =?utf-8?B?aG1SaWxsQlUxajRuZ2ttVjIzTnJqQmdmeitQYWl3UlFxTGVURmU2MXFpMTJY?=
 =?utf-8?B?bDk5OXFqTkpPY0ZqTnczWkVVUkJyOG12dWlBRmRlVG1zU0dzL3V4VW1aZkFZ?=
 =?utf-8?B?QlpmbWpkY3ZOK3kzTWhkY2lob3FNZzRHQVM2RXY5TDFxL0MyNTZEcFhUQkVQ?=
 =?utf-8?B?Z1p1V1c1NG9RanFnV1htVFJIRGhhWitxTWo2d0pFZ3BjSEVnUjNvWVk1eGlt?=
 =?utf-8?B?WVFNbE5nV0wzOVRHNDNaNzRuUW5iNTEzS3FIb3RzT0dMeG9KaHNrS2ROKzl4?=
 =?utf-8?B?K3VvWFV4RElueG5BZy9IRWhvRU02NnBKTkhwRXM2emFIa3RuMWE3TFY1UmRa?=
 =?utf-8?B?ZmJvUnRJL3hIWWFxdHdsekJrY0hFZERjN0xGMW5JaGNLdm0wbVlNQ0J0ZVlq?=
 =?utf-8?B?WENBUFQ2ZjFwb3IzN0Q5UlRpM0hZaUkxcEU2MUp0K0QvaXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFdZSXZzWWlYVjFjZlFlTGRtNVJRTnpDWjkwdGpxUUx4c0FqT1NrNlJXU243?=
 =?utf-8?B?TVhQZ0h4Yy9zUlpUdkNNY1gvYmRWRHZwZmo3UFg3UkpQeStNK3lreUdYcW1t?=
 =?utf-8?B?R3RaVHBZZDR2RzYvZTZ2WHRPWi9lQVlzNW4vSmgvNG1CMEVQNU5zQ2hBaWt3?=
 =?utf-8?B?a01qU2VRZ3JYM3VhRTNxRTdST0w2UkdJRWtzR0w4SUw5QkpJS2VWeERLcmdU?=
 =?utf-8?B?NmVyZDB0Sjl6cXlwWkhYaFZLNG1RdHF4clZwMVBRaU00NVJjcHdTRm5nT1NS?=
 =?utf-8?B?cWNVQWlkU1dIOHpiWnU5N2swcjVPVHljd1BVQ3hQd1JVekg5VWJLc28vM05Q?=
 =?utf-8?B?QlB6U3V6U2pCM1hvbmo1MzNWQjlHdXVVY0NMaHkvZUhoNWhZKzB5RkltWGpK?=
 =?utf-8?B?UE5RVVg3SWUzZ0lhRFUwNEgzbm1IdkVTcVdlQklMTERXQlVWUzNyQTUyVmhF?=
 =?utf-8?B?b1dOWStQTklDK2VFQ3dqS0dWVkVZWVExVzgxQ2JOTDhyUDN4aTgyc0tkYi9h?=
 =?utf-8?B?K3Y4T3R0UktVUTUrc05DcjFjRjhYYzVOcTBOTDhTQXB5SFdJTWFuVS9PYVF5?=
 =?utf-8?B?WkhBUWFwUGFRWkQ3TUkvREU5VW1KTjhSY3ZTME9uaWgrSW9mc2VNRUNaRXlN?=
 =?utf-8?B?WFRXS2hEWnhmT25CT2NJTTZhWnpYRnpPMmp4dU1XMUhibUZERTcyMEgwUzhC?=
 =?utf-8?B?RkV5UzlTTXkvU25TVzdNOGJMYkxiald4WG9jdzNJRVFuQ2s1WEVjd2MyVTg4?=
 =?utf-8?B?SFFlSXpaRGpCdUQyWWdJVE01WE1SUmZCTzRTVC8vRUR0bWpwK3BXWXhkUlVt?=
 =?utf-8?B?TU9HTkp6T05IVWFMVTJ3dXpsRGg1a3lSWnA3ZU9XbkpnbjFoUnd2UW1HR1U0?=
 =?utf-8?B?cTVqaElFN0JSVzhTNzRuR2VEZTdhNkJUTGF0RnFQbUR5eldMVDZ0U1JTU1lX?=
 =?utf-8?B?TGhXNEJVbmxsNThoTS9GcnlRQ3M5NGtlTjdxQWhXbFhjY3dFZUkzVG1QYkt0?=
 =?utf-8?B?T0oxdzEvWGk2YnVuYW1IN1RYUlk0c3BpZS9kVnoxY1VyRzFWWnlMMGlmMlIz?=
 =?utf-8?B?UjJ1WlBJQVo4aW1CY3MvdU8wTW5jakNtaHFab0NSaHFTSkFqSzRNbUUvTzhJ?=
 =?utf-8?B?MFY4UzFBVUIvbWh3eFEvL09XUWtLWHlTT0IzaUdWZWZkbERuS1R1ZGloTkF5?=
 =?utf-8?B?aG94R0xvemNpSy9SRS8rQ0ZMb0oyTCthVFY4czJmUGhIMTJPdmZLZ2NrN1RW?=
 =?utf-8?B?aC85ajByemJpNEhNYTBxUkNURHVvMGdpT2xPNmtHbThsOXpkazl4KytUZWV3?=
 =?utf-8?B?aWdxVktUSndaTUdkVTRxNXhtRkdwR0swY2VqU0gxSGZ5YWduQ3lQWmhaSzdP?=
 =?utf-8?B?dzA5K21aQmVxcklobG1xeW9LV24yMGlVbzFoY2JpS3UzSkY1VUJxZ0FpbVRX?=
 =?utf-8?B?Tll0NHBVNVZudFUxcVpRMDRtdGcxWHlFRUd4bGdqV0c5QS9VUjZydUlDQVhG?=
 =?utf-8?B?RFB2aWZiTG9Rc0FrLzZnZEdDQ0ZjL1RBQ1ZyUllCbzRSbDVuMGFTM0cyV1Mx?=
 =?utf-8?B?U01jUVV3ZnVGMGJ6Y1Ntb1c2UG9SZ00vSTZGZHZITFU0VVVFZWlpNlZDRVpR?=
 =?utf-8?B?Z21VUHJHbk5odjUrVnNCMXN5eGNGdmN4cnNTN21KdlUzb2kveDl6VTRGbmdW?=
 =?utf-8?B?YmlQYkh6VTdxWStRVVBaOCtERzZZVGErenhKYkhOTFBlY3A4SUpWMVgwMlpp?=
 =?utf-8?B?THlXUVBVK2FQMlBHSkF5WmpWanVSOUhTWTlQdlkzV2d4NS8vL3MzUlcyTlNv?=
 =?utf-8?B?U1R2ZE9JN1BBNG53dUJBSnMwWmJpLzMzNjFRbEtFL0dTSVR4dWpUQUVMVjlt?=
 =?utf-8?B?bm1CZ093L0N4TC9IbThDcjhlVk12OTJpcjliVHJDaG4vYkdUbXpMTUQ1bVVN?=
 =?utf-8?B?Vy82SjJieWN3bFlaU3lhK0V6QVdNV2Y2eXJEaVE2cFczM2ljWkNKNmJxZHN4?=
 =?utf-8?B?VURoWnVmUCt4ZGwwNHh1ZmgzS2VaNWZTeVg3S1hRRFVHclg0cWVVQ00vOEhK?=
 =?utf-8?B?alBVNEtkNlYyQkVzM1NBNXhPUTJlYmNQY2xhdGtwUWh6SmZIYjMyK1lsZUsv?=
 =?utf-8?Q?+sPQImI0xr9m5IUrvsWGqpBb/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a322dcc0-7fb0-452e-4086-08dca0f6853e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 15:39:43.7430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbZwupwf51sSqreTgVsE7p+UcxNkEMLFKYOU9RRVMCmiOruxhfKgwW90/Kj7g8Gzh9elUbumtvI2LwWDUvpNsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8154
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZXRlciBYdSA8cGV0ZXJ4QHJl
ZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVseSAxMCwgMjAyNCAxMToxOSBQTQ0KPiBU
bzogTGl1LCBZdWFuMSA8eXVhbjEubGl1QGludGVsLmNvbT4NCj4gQ2M6IFdhbmcsIFlpY2hlbiA8
eWljaGVuLndhbmdAYnl0ZWRhbmNlLmNvbT47IFBhb2xvIEJvbnppbmkNCj4gPHBib256aW5pQHJl
ZGhhdC5jb20+OyBEYW5pZWwgUC4gQmVycmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPjsgRWR1
YXJkbw0KPiBIYWJrb3N0IDxlZHVhcmRvQGhhYmtvc3QubmV0PjsgTWFyYy1BbmRyw6kgTHVyZWF1
DQo+IDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+OyBUaG9tYXMgSHV0aCA8dGh1dGhAcmVk
aGF0LmNvbT47IFBoaWxpcHBlDQo+IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz47
IEZhYmlhbm8gUm9zYXMgPGZhcm9zYXNAc3VzZS5kZT47IEVyaWMNCj4gQmxha2UgPGVibGFrZUBy
ZWRoYXQuY29tPjsgTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPjsgTGF1cmVu
dA0KPiBWaXZpZXIgPGx2aXZpZXJAcmVkaGF0LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsg
SGFvIFhpYW5nDQo+IDxoYW8ueGlhbmdAbGludXguZGV2PjsgWm91LCBOYW5oYWkgPG5hbmhhaS56
b3VAaW50ZWwuY29tPjsgSG8tUmVuIChKYWNrKQ0KPiBDaHVhbmcgPGhvcmVuY2h1YW5nQGJ5dGVk
YW5jZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMC80XSBJbXBsZW1lbnQgdXNpbmcg
SW50ZWwgUUFUIHRvIG9mZmxvYWQgWkxJQg0KPiANCj4gT24gV2VkLCBKdWwgMTAsIDIwMjQgYXQg
MDE6NTU6MjNQTSArMDAwMCwgTGl1LCBZdWFuMSB3cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0KPiA+
IG1pZ3JhdGVfc2V0X3BhcmFtZXRlciBtYXgtYmFuZHdpZHRoIDEyNTBNDQo+ID4gfC0tLS0tLS0t
LS0tfC0tLS0tLS0tfC0tLS0tLS0tLXwtLS0tLS0tLS0tfC0tLS0tLS0tLS18LS0tLS0tfC0tLS0t
LXwNCj4gPiB8OCBDaGFubmVscyB8VG90YWwgICB8ZG93biAgICAgfHRocm91Z2hwdXR8cGFnZXMg
cGVyIHwgc2VuZCB8IHJlY3YgfA0KPiA+IHwgICAgICAgICAgIHx0aW1lKG1zKXx0aW1lKG1zKSB8
KG1icHMpICAgIHxzZWNvbmQgICAgfCBjcHUgJXwgY3B1JSB8DQo+ID4gfC0tLS0tLS0tLS0tfC0t
LS0tLS0tfC0tLS0tLS0tLXwtLS0tLS0tLS0tfC0tLS0tLS0tLS18LS0tLS0tfC0tLS0tLXwNCj4g
PiB8cWF0emlwICAgICB8ICAgMTY2MzB8ICAgICAgIDI4fCAgICAgMTA0Njd8ICAgMjk0MDIzNXwg
ICAxNjB8ICAgMzYwfA0KPiA+IHwtLS0tLS0tLS0tLXwtLS0tLS0tLXwtLS0tLS0tLS18LS0tLS0t
LS0tLXwtLS0tLS0tLS0tfC0tLS0tLXwtLS0tLS18DQo+ID4gfHpzdGQgICAgICAgfCAgIDIwMTY1
fCAgICAgICAyNHwgICAgICA4NTc5fCAgIDIzOTE0NjV8ICAgODEwfCAgIDM0MHwNCj4gPiB8LS0t
LS0tLS0tLS18LS0tLS0tLS18LS0tLS0tLS0tfC0tLS0tLS0tLS18LS0tLS0tLS0tLXwtLS0tLS18
LS0tLS0tfA0KPiA+IHxub25lICAgICAgIHwgICA0NjA2M3wgICAgICAgNDB8ICAgICAxMDg0OHwg
ICAgMzMwMjQwfCAgICA0NXwgICAgODV8DQo+ID4gfC0tLS0tLS0tLS0tfC0tLS0tLS0tfC0tLS0t
LS0tLXwtLS0tLS0tLS0tfC0tLS0tLS0tLS18LS0tLS0tfC0tLS0tLXwNCj4gPg0KPiA+IFFBVHpp
cCdzIGRpcnR5IHBhZ2UgcHJvY2Vzc2luZyB0aHJvdWdocHV0IGlzIG11Y2ggaGlnaGVyIHRoYW4g
dGhhdCBubw0KPiBjb21wcmVzc2lvbi4NCj4gPiBJbiB0aGlzIHRlc3QsIHRoZSB2Q1BVcyBhcmUg
aW4gaWRsZSBzdGF0ZSwgc28gdGhlIG1pZ3JhdGlvbiBjYW4gYmUNCj4gc3VjY2Vzc2Z1bCBldmVu
DQo+ID4gd2l0aG91dCBjb21wcmVzc2lvbi4NCj4gDQo+IFRoYW5rcyEgIE1heWJlIGdvb2QgbWF0
ZXJpYWwgdG8gYmUgcHV0IGludG8gdGhlIGRvY3MvIHRvbywgaWYgWWljaGVuJ3MNCj4gZ29pbmcg
dG8gcGljayB1cCB5b3VyIGRvYyBwYXRjaCB3aGVuIHJlcG9zdC4NCg0KU3VyZSwgWWljaGVuIHdp
bGwgYWRkIG15IGRvYyBwYXRjaCwgaWYgaGUgZG9lc24ndCBhZGQgdGhpcyBwYXJ0IGluIA0KdGhl
IG5leHQgdmVyc2lvbiwgSSB3aWxsIGFkZCBpdCBsYXRlci4NCg0KPiBbLi4uXQ0KPiANCj4gPiBJ
IGRvbuKAmXQgaGF2ZSBtdWNoIGV4cGVyaWVuY2Ugd2l0aCBwb3N0Y29weSwgaGVyZSBhcmUgc29t
ZSBvZiBteSB0aG91Z2h0cw0KPiA+IDEuIEZvciB3cml0ZS1pbnRlbnNpdmUgVk1zLCB0aGlzIHNv
bHV0aW9uIGNhbiBpbXByb3ZlIHRoZSBtaWdyYXRpb24NCj4gc3VjY2VzcywNCj4gPiAgICBiZWNh
dXNlIGluIGEgbGltaXRlZCBiYW5kd2lkdGggbmV0d29yayBzY2VuYXJpbywgdGhlIGRpcnR5IHBh
Z2UNCj4gcHJvY2Vzc2luZw0KPiA+ICAgIHRocm91Z2hwdXQgd2lsbCBiZSBzaWduaWZpY2FudGx5
IHJlZHVjZWQgZm9yIG5vIGNvbXByZXNzaW9uLCB0aGUNCj4gcHJldmlvdXMNCj4gPiAgICBkYXRh
IGluY2x1ZGVzIHRoaXMocGFnZXNfcGVyX3NlY29uZCksIGl0IG1lYW5zIHRoYXQgaW4gdGhlIG5v
DQo+IGNvbXByZXNzaW9uDQo+ID4gICAgcHJlY29weSwgdGhlIGRpcnR5IHBhZ2VzIGdlbmVyYXRl
ZCBieSB0aGUgd29ya2xvYWQgYXJlIGdyZWF0ZXIgdGhhbg0KPiB0aGUNCj4gPiAgICBtaWdyYXRp
b24gcHJvY2Vzc2luZywgcmVzdWx0aW5nIGluIG1pZ3JhdGlvbiBmYWlsdXJlLg0KPiANCj4gWWVz
Lg0KPiANCj4gPg0KPiA+IDIuIElmIHRoZSBWTSBpcyByZWFkLWludGVuc2l2ZSBvciBoYXMgbG93
IHZDUFUgdXRpbGl6YXRpb24gKGZvciBleGFtcGxlLA0KPiBteQ0KPiA+ICAgIGN1cnJlbnQgdGVz
dCBzY2VuYXJpbyBpcyB0aGF0IHRoZSB2Q1BVcyBhcmUgYWxsIGlkbGUpLiBJIHRoaW5rIG5vDQo+
IGNvbXByZXNzaW9uICsNCj4gPiAgICBwcmVjb3B5ICsgcG9zdGNvcHkgYWxzbyBjYW5ub3QgaW1w
cm92ZSB0aGUgbWlncmF0aW9uIHBlcmZvcm1hbmNlLCBhbmQNCj4gbWF5IGFsc28NCj4gPiAgICBj
YXVzZSB0aW1lb3V0IGZhaWx1cmUgZHVlIHRvIGxvbmcgbWlncmF0aW9uIHRpbWUsIHNhbWUgd2l0
aCBubw0KPiBjb21wcmVzc2lvbiBwcmVjb3B5Lg0KPiANCj4gSSBkb24ndCB0aGluayBwb3N0Y29w
eSB3aWxsIHRyaWdnZXIgdGltZW91dCBmYWlsdXJlcyAtIHBvc3Rjb3B5IHNob3VsZCB1c2UNCj4g
Y29uc3RhbnQgdGltZSB0byBjb21wbGV0ZSBhIG1pZ3JhdGlvbiwgdGhhdCBpcyBndWVzdCBtZW1z
aXplIC8gYncuDQoNClllcywgdGhlIG1pZ3JhdGlvbiB0b3RhbCB0aW1lIGlzIHByZWRpY3RhYmxl
LCBmYWlsdXJlIGR1ZSB0byB0aW1lb3V0IGlzIGluY29ycmVjdCwgDQptaWdyYXRpb24gdGFraW5n
IGEgbG9uZyB0aW1lIG1heSBiZSBtb3JlIGFjY3VyYXRlLg0KDQo+IFRoZSBjaGFsbGVuZ2UgaXMg
bm9ybWFsbHkgb24gdGhlIGRlbGF5IG9mIHBhZ2UgcmVxdWVzdHMgaGlnaGVyIHRoYW4NCj4gcHJl
Y29weSwgYnV0IGluIHRoaXMgY2FzZSBpdCBtaWdodCBub3QgYmUgYSBiaWcgZGVhbC4gQW5kIEkg
d29uZGVyIGlmIG9uDQo+IDEwMEcqMiBjYXJkcyBpdCBjYW4gYWxzbyBwZXJmb3JtIHByZXR0eSB3
ZWxsLCBhcyB0aGUgZGVsYXkgbWlnaHQgYmUNCj4gbWluaW1hbA0KPiBldmVuIGlmIGJhbmR3aWR0
aCBpcyB0aHJvdHRsZWQuDQoNCkkgZ290IHlvdXIgcG9pbnQsIEkgZG9uJ3QgaGF2ZSBtdWNoIGV4
cGVyaWVuY2UgaW4gdGhpcyBhcmVhLg0KU28geW91IG1lYW4gdG8gcmVzZXJ2ZSBhIHNtYWxsIGFt
b3VudCBvZiBiYW5kd2lkdGggb24gYSBOSUMgZm9yIHBvc3Rjb3B5IA0KbWlncmF0aW9uLCBhbmQg
Y29tcGFyZSB0aGUgbWlncmF0aW9uIHBlcmZvcm1hbmNlIHdpdGggYW5kIHdpdGhvdXQgdHJhZmZp
Yw0Kb24gdGhlIE5JQz8gV2lsbCBkYXRhIHBsYW5lIHRyYWZmaWMgYWZmZWN0IHBhZ2UgcmVxdWVz
dCBkZWxheXMgaW4gcG9zdGNvcHk/DQoNCj4gPg0KPiA+IDMuIEluIG15IG9waW5pb24sIHRoZSBw
b3N0Y29weSBpcyBhIGdvb2Qgc29sdXRpb24gaW4gdGhpcyBzY2VuYXJpbyhsb3cNCj4gbmV0d29y
ayBiYW5kd2lkdGgsDQo+ID4gICAgVk0gaXMgbm90IGNyaXRpY2FsKSwgYmVjYXVzZSBldmVuIGlm
IGNvbXByZXNzaW9uIGlzIHR1cm5lZCBvbiwgdGhlDQo+IG1pZ3JhdGlvbiBtYXkgc3RpbGwNCj4g
PiAgICBmYWlsKHBhZ2VfcGVyX3NlY29uZCBtYXkgc3RpbGwgbGVzcyB0aGFuIHRoZSBuZXcgZGly
dHkgcGFnZXMpLCBhbmQgaXQNCj4gaXMgaGFyZCB0byBwcmVkaWN0DQo+ID4gICAgd2hldGhlciBW
TSBtZW1vcnkgaXMgY29tcHJlc3Npb24tZnJpZW5kbHkuDQo+IA0KPiBZZXMuDQo+IA0KPiBUaGFu
a3MsDQo+IA0KPiAtLQ0KPiBQZXRlciBYdQ0KDQo=

