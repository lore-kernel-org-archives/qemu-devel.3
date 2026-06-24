Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5C6CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:47:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcIJt-00028r-HQ; Wed, 24 Jun 2026 03:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wcIJq-00028Y-Rl
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:46:47 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wcIJp-0001NO-63
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 03:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782287205; x=1813823205;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Im0gZAxAxtFmvcYrvXsCtSOrxvJr4aGZtujYHjLBgqc=;
 b=IYBKl1s0NIFrUbYz4+Vtbezr1JVRCbpLfmASCTvyk0SXGBqCzhAMRdMh
 o5NMeunus3nImKR5g1wMEhCLNsa90L2wH7u+qQmtoV6yWCaogKCUryZfi
 YMRUIKNGlpTU+8i7R4ZPkB8d8IhqqFExvzGtQB/kdsWz5dJDnJ6sMT8+U
 KcONyKk+YKWy+i+uSfh0XvBTI3co8yW3/r5rtxcA488VweOupXJWKYJW7
 E32D7nQEGE8gbt9PVs6kN88YFcGJqoePzQqw/es9TCHBjPGMSxEq0kDFk
 sFULC/yetuEfuB9JvaIkwD5/8AqEQaJM2SaEgGzWLGHzUqFd3n1+qAIg8 w==;
X-CSE-ConnectionGUID: mbQVGTndS1OHHcBwOEd+5Q==
X-CSE-MsgGUID: dHlKPL3AQjyNfsTwpZEGuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="93400126"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="93400126"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 00:46:42 -0700
X-CSE-ConnectionGUID: JvbexuzNRACxeIenL+N1vw==
X-CSE-MsgGUID: 86YCujI0QcevDtZAwM2PWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="254747826"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 00:46:42 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 00:46:41 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 24 Jun 2026 00:46:41 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.27) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 24 Jun 2026 00:46:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CY92fixmD2Ouf8VBD3y7HKGtp3sGu5k4hPOoMFbh9Cp9SK6IYvdpeFXOi74v+MA/h1U89jSIu2FhTB9Myym44yXUkHGIZNzX3MTLuF3Ba6MojzoXdhkk1DR+hPmkZpNKzFmxkS6DfWLIVIlJYl9HJtm/yx7l8NoImY9qTx2cU1EojpfY19i47xRLKrZsQlPs3oT7ZRO2OfJfH51XscFraLNjDVHeQrg25EHinpxSa0k4u8lbpmq2Yt/vTV55gtnHJlj6IrgQwjRob6ADhH0y6phmF9k7eWU9PeWh+HVz9K8BS9ErqYDwOu0/RmEwqQBAb4QnOu8DddCl5WGrCIpduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Im0gZAxAxtFmvcYrvXsCtSOrxvJr4aGZtujYHjLBgqc=;
 b=PLqb0VLpM+832BdA79iV66/SJnkcr0rKIMa/VTRIkuyC6uMYLD3INd/B4d7CWrY2qD72K6YX8tF3OsQvbki84WIm+6ZFfeLujMTWr7ExPIIZJf05pYnYHGHwFHtMrISEdti7jVWKIO4SFKIF599UGGwz84CD7yWvR/v0wqMs2U5anxl2W2zNshJbV7jCyjZRxQyzHF7AEbcRHTQgBNOz5OwTvxoM0tYZ1QwN7Z0M0qWCQ03anrXr1xZF4NpDCGFFfy6ltoPHWh2m/0OsWqIbSyrMXpot9iPkqjbzv7K06KLfMy9b5iH2q9cjrvMpRMMzc9Yr788FzEv+xmhTfOgISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB6796.namprd11.prod.outlook.com (2603:10b6:510:1ba::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 07:46:38 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0113.015; Wed, 24 Jun 2026
 07:46:38 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>, Jason Wang
 <jasowang@redhat.com>, =?utf-8?B?Q2zDqW1lbnQgTWF0aGlldS0tRHJpZg==?=
 <clement.mathieu--drif@bull.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: RE: [PULL 016/106] intel_iommu_accel: Handle PASID entry addition for
 pc_inv_dsc request
Thread-Topic: [PULL 016/106] intel_iommu_accel: Handle PASID entry addition
 for pc_inv_dsc request
Thread-Index: AQHc/DD1aqG+7fxPaUaK/gcG34ndBbZMBUCAgAEHhIA=
Date: Wed, 24 Jun 2026 07:46:38 +0000
Message-ID: <IA3PR11MB9136FD0ACC5901A0FC8B55F092ED2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <cover.1781463125.git.mst@redhat.com>
 <c93b82e7dde2e9c26ab743e80d19050bde988fdf.1781463125.git.mst@redhat.com>
 <582f27d5-71fd-454d-9bb6-6c2cab574651@oss.qualcomm.com>
In-Reply-To: <582f27d5-71fd-454d-9bb6-6c2cab574651@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB6796:EE_
x-ms-office365-filtering-correlation-id: 180c2ca2-65e3-4aa9-b389-08ded1c4b956
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|38070700021|3613699012|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: utbEIpLF2VTfnz6nmRjdKqquIdPHZvobhpNkufb9seZUX8jtqoX8DLw3rA8Ormzwx2qifxalAGGkRFVUXxnLaquZj4SliZFPmgtlg64x/lor2Xu1zR2pXtMKtocTNO2TmLTsCubQqoSeDDosaCUmaDx4xmoFGvoT1dHs3fXCCGAH2Ic6igXqAmQp6EkkMgBq3K7JlS7ssvCKPSEkRHD5EOUhN5HzdTTCFGs/4XG7jyFmCKVCtbdWqMTfdrztkBDSxhPSf/ggkILi6oKQ1eFXf13Bf+52pCS7prCJ346I5PbqMdjDJkYpsGBOsyCYnC3vXJLYLQCOSaqDIbAqbXf8x2845VxFZU9gmHKoXK2ItVnmaD19aB3BlYCx4mCiwuVsmR7LhEb60GC4/L/BcbDrrG5KtqcVXO6BCfvNhI6Ppg6mwGzN0sIXtMJOJUFQnw+RZKP4sge3D7DoQibye8c5Bpfr4ZA3Pbs65oWPMn8okJ7qn2CU7x8yFR4cPuU4Y3mK7d1R5o4hlPpZlPtYlTX1WeRkC5ZnQYt53rNyJJymKl/lzJdqpR0y2xAIkgUxnXvsXd9OoxHZy63B76rrYZa/hI9te40cLa4HFX2DIsv+OvLCTVKAdD7If+GeoWves1ffETWP8RDvc6P/idFrjwcLdbK6RETBCZ5uWR+tUtSr0Xp6LST+gSLeNtTfXMED12Qggb0RZiuEsmppLkzie/a8HsK5Wifru3yMY8+3am2IcCt3SkLAv9xmYr4HLp4fWDN0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(38070700021)(3613699012)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ai9DRTdxZzJBSDlKVHowOStDUUhWYmtnUEJSWWFkU3VZUjB1Z29EeVN2Q1g2?=
 =?utf-8?B?NlRrdHlLQWRBdGRrNUZIczZrNURSSjNKMmZEWWt3Uk5kb3Q3VGhnTjRmNG1K?=
 =?utf-8?B?RVQ3KzRnTnRra0JZZlV0UEJmK0ZQaGRQMTJjMVh5TlVlYi9rRGZBbExuS1lM?=
 =?utf-8?B?RWFKK3ltMjdDS3RXWDRtMVFZaHpzVFdRTHZ1cTRpbVdVcFpMZ1QyclozL0hk?=
 =?utf-8?B?aFFxWXZwTzBXMHNYdUZQNURaZnV4Y3plZ2JEQmlNK0VaVGc4U0xlZFFNSXJh?=
 =?utf-8?B?ZHpRM1I5T3FnNTJTcm1waVJGSnpsZzA5dEQxOEJvb1hpbW92b1IzSm1mbWpq?=
 =?utf-8?B?WURyWEpQNkJDNGpsU2ZOTEdDcCsvNThnMWZaNnR4eTFRUGZSeXJ0RHVpcUZ4?=
 =?utf-8?B?ajIrMWxLQWxETDhmdWtSb3RiNlQ0cmVoTXI0OHVycUJvOXI2bjJpOEZ5MnZk?=
 =?utf-8?B?eFR2RGR5SnliaXZ2UEVIRE91QS95Y2p4V1NSSUh2ZW1uOXlmeHV5REI4ZlJZ?=
 =?utf-8?B?b08vMlRlbnBua3BkNUpJOVZJUkRMMW1GallrOFFjVDlXd0VqY2dCcHVTY1Qw?=
 =?utf-8?B?cVFyenhUWkxFdGVBQWZQZmhEOGw2YXNReFpNL3g5TDBnNnVvRXpqTFFoVGM5?=
 =?utf-8?B?OTh3TjExUC83SC9WUUpnSXdNUExMdy9acTh5cUlUS1p5cGtScVdFZmE0TUxz?=
 =?utf-8?B?dUQvaS9RT2s1ODhyODJzWUJLa0hrLzhBa095djl0ZlBmNU5WZmp4UVhFRnd4?=
 =?utf-8?B?UUo2dzlybHZBYlVHdjZFcWEyYjZaNDJFdDF5REdSU3VQdmt6QTBiUVd2cGty?=
 =?utf-8?B?RU9UTldMM21RNU5SQzY4dkdXa3ZoZmVIK1ppMFJ4UGVGZFVZVU1iVlFkbVoy?=
 =?utf-8?B?REFLekROTFpRbWlGaDVteEV2cjBCaUdKWGNLVWVNaTBRNmphVTYxUlg2OUh2?=
 =?utf-8?B?dFdwM2tzS09ObkQ0TU1LMFIxVVBZdDQ5K3N6S21iMVN0d1Q1eEt5aHBwS2ps?=
 =?utf-8?B?b0ExOVlOaHlOOGg0Rm9Yd0d0R05pdnB0T0VoaXQvenovaXJvN3gzaHNYRUhV?=
 =?utf-8?B?NVg3OUNOMHdiUDNxQ01PMkJxWGFmTi9UOENsWm4rck42WFY0UEV5WmdGZDdM?=
 =?utf-8?B?MEQ1bDNncWxPWXFxbGF0UU9mdVVPeXFDbGZwWm5qa3JaZW5xd3ZhZXZtK3ZD?=
 =?utf-8?B?VzFFSEMyZWtMbHBTT1JBdXdUTENnbG9qSmloZDFjTU91dERaaU1OSVAxOUZz?=
 =?utf-8?B?VFJPQkhpT1VHbmlaU0ZmMTBuRHg0WE5KVGhzVUVXOFNyb0lEZlRBcTN3YytW?=
 =?utf-8?B?ZmZ2WFJQRVVkbFF3VFdlMk5ZZmJMbTRyeXUweHlwYlBzdEswM241aXM5NU9q?=
 =?utf-8?B?OStON3dic3JlbVhVaFF5UEEraG9SZ2xVUUo4YlljaUV6Y3BhR3lGak5wdDNC?=
 =?utf-8?B?VmUrcHpGb3JJbmsrMW9iNmFzUHVHY1NnSXUwbXJLRmNQRG9KVTU0eGtUZmVC?=
 =?utf-8?B?cW9VYnpieVF3bG52eGx4cy9wcnJVTG5EazhjZHd6N21ueXBETWlPR1hqU3Vw?=
 =?utf-8?B?VXdrWkxXaHJaZVdNYm4ydUgySFpwRllLa2RmakwrN2htQ2VFSlRWSTY2alBO?=
 =?utf-8?B?Z1lWZXhwZEtvVXRXM0pHbWFTdUFCTkV0WTdab29IRjd5ckZ4cnJnc3hhWmlx?=
 =?utf-8?B?OFNSak42WlRpVDJZZDltNUZSQUpTUHBmSEhBaENNbUdvWFVXYlBabktLNzlE?=
 =?utf-8?B?Z2FsRE1JcHh2UHBwMVpFNlNSRlFJd21Xdm01a0VYdFE1NGlDVVcyT2dhNkFS?=
 =?utf-8?B?QjU0eUEyUS85Nis5K2xjTFF1QUxwZHRNU2UvMk9OZ3drMFRtVTFYbm5sK2Fl?=
 =?utf-8?B?QlI3bGl4a3NaRTVoUm9nLzROc2tPc3NrY3VXTnlPUlZ4YTdhUjFkdmFMckZR?=
 =?utf-8?B?dWkwK1FFVHRtR0sxT0l1eHlhZzhkYk5FanlKeHE5NFIvMUxtZFlIYnQyZHdC?=
 =?utf-8?B?UTJQeCtScDR4MGZJdnhJWUcrVi9Dbnd5VkpyekVzNUVkaU94UVlzVzFlV1FJ?=
 =?utf-8?B?eStXbE1pR21TaW5ndjIrcGl5NzAxZXZhSWU0aGNqSTNId1VNY1F6WVNlamlz?=
 =?utf-8?B?R3JFSHhMei91TUVQNnhrYWFiSkpvQVdBc05QQlFnNWZycWplOFNPTGtCNHMx?=
 =?utf-8?B?aUlBY2Z2TzdtZFRzY3pUUnREYnFOWkN4UUVCRU13T0Zqb3RjTXJUa2c2aXVa?=
 =?utf-8?B?SXRZdVlZelUzVE9BaVJ0Wm5TeGpJL0RoVGdZTHRXeHVWcDNLTEpJT1hEYjls?=
 =?utf-8?B?VlUwUUZFYUt2dnlWTFh0cU5LYVJsNUlDSUo1VEhCR1VjdThMSXVrZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: C3BOzfGZxhZ2nuN5UGgISpcInpwliHd96Qzfni+Nf1JowKovZTDnydsSZrFq1Bp6opaAJUYXiljL+rsUYmxeih9QnImFhtiawnQgdCQaGTTQWz8bUqRtdCwg7Q95YVTegG7XUNzIyi3bQPYK8EzKAOO9EOTIn23sUY0cvQcIWRXt+iEAETtyOkalZ1g62DvRd1l82hO8UcVVAGbgT1ZkEjts7WIlezVpzj2goRa+fXvLQ3kfmGczsfe+1hipurKiExIT9crp4pRDtmJzsMvr2slRiFL+vQtliUZB2ppcMJus6wIN6it9XanjkgTx0VS/C/OKf3hL1cZdP5MYjDq+XQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180c2ca2-65e3-4aa9-b389-08ded1c4b956
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2026 07:46:38.5831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7cDLsj7Bs0TOmQ9RbYjudoOKRLwy60YNkEzzRSQnzyphf6AFCgQrnYU3iyZSCXjJs/vUsJBpgO/GrDBDAQq0qZTdnnTfyDFUf2OqF71NOKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6796
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgUGhpbGlwcGUsDQoNCj4+ICt0eXBlZGVmIHN0cnVjdCBWVERBY2NlbFBBU0lEQ2FjaGVFbnRy
eSB7DQo+PiArICAgIFZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2Q7DQo+PiArICAgIFZURFBB
U0lERW50cnkgcGFzaWRfZW50cnk7DQo+PiArICAgIHVpbnQzMl90IHBhc2lkOw0KPj4gKyAgICBR
TElTVF9FTlRSWShWVERBY2NlbFBBU0lEQ2FjaGVFbnRyeSkgbmV4dDsNCj4+ICt9IFZUREFjY2Vs
UEFTSURDYWNoZUVudHJ5Ow0KPg0KPlpoZW56aG9uZywgdGhpcyBzdHJ1Y3R1cmUgc2hvdWxkIGJl
IGRlY2xhcmVkIC4uLg0KPg0KPj4gICAjaWZkZWYgQ09ORklHX1ZURF9BQ0NFTA0KPg0KPi4uLiBh
ZnRlciB0aGlzIGd1YXJkLg0KDQpJbmRlZWQuIEl0IGRvZXNu4oCZdCBpbXBhY3QgYnVpbGQgcHJv
Y2VzcywgYnVpbGQgcGFzcyB3aXRoIG9yIHdpdGhvdXQgZml4Lg0KSSBjYW4gc2VuZCBhIGZpeCB0
b2dldGhlciB3aXRoIFBSUSB2MyBzZXJpZXMgaWYgeW91IHdpbGwgbm90IHNlbmQgaXQuDQoNCkp1
c3QgY3VyaW91cywgaG93IGRvIHlvdSBjYXRjaCB0aGlzPzopDQoNClRoYW5rcw0KWmhlbnpob25n
DQo=

