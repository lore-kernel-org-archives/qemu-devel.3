Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3615CC6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 16:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmyih-0004ql-U4; Wed, 20 Mar 2024 12:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmyig-0004qN-5t
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:23:14 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmyia-00053C-GL
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710951788; x=1742487788;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pQq+m7gK3MjdEUly4Rmyo9FNDAg1hTtwV2Ut+jD1/J0=;
 b=RbF6+rRX0OzcNu1bTkJwNe+sCS/3xTJxM9Yds/tSRKIQeRI4jrJNYWzi
 d5o1+5IP7TNak5+BvZizvAx9j9sW3/fBPtLD6pN9IVZp8/w/PpqvRgByY
 8BWgiv69SPrNpN7iSQe34VIyHStojheWB7GSpDj8hJZyUP6Kg4c1onIj9
 xhMBnXW0ApMvr7A0qlx5VBY3qQwrx8QcJSAzwJpOsb5bpS4R5EKwKPgGs
 x6AasBxSwk69CCU0LuyVtcKWUWMcFjUKMmYDJCp5G0jPuNKXdH2a8ZmW2
 1XzVXogwg4Z51kL2QX7EXTdwX2wvNP8l+Fa8Cx8/aptA/8EPVir/Yv8yY g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9655851"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="9655851"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 09:23:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; d="scan'208";a="18926030"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Mar 2024 09:23:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 09:23:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 09:23:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 09:23:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNeKOaTlt+ezWo8pIP4qRin0TwuP+iWdIE2mFbbatsQh0xzujsqoBp0iZUrxh/Z2a04+TWwoe8BWzy/kqzEQxoUlUkvXdDaJUKO1AvxcNVOgSQrrB9wjd04+j4giQSoVgKLYA9Gg2wJSgsHy6M2vAmLfQ2PSO4JsH5mAGnUWD8PDt5idg1AG5My3Fkc81CWfm+Oib29blJxI0rlsAENGlxWYt7A+8iwzUvu+4LjBYMrEs74ii8yrA9CEs7s11EkvB5JWkwvwLohIj3+al7iMRZ5ar0LvifgJMBRr8iCi8G1i8Fdq8c/uHLPiiM0Rtml5/5bxDF/jbW2RB8ybIBA8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQq+m7gK3MjdEUly4Rmyo9FNDAg1hTtwV2Ut+jD1/J0=;
 b=GKA9dEMreOqGzRzPtMc+l6chRwyNf9cFxy3acvUNL60Kkuj+hm5tuId1iVnKg3xh73XZwMbsW6AATltZcldDnPUF6ZvIKRRftBPJ5H0JF7YCLq6m0IA7uFkPDQvs5Yr9RWoFAOGqof76L8ONUm3QqYkDsEElcW5IJwEuzdf7kF/rdXgge6lIAps7UjfRIE9uh8KhAwaEJ4VaDOxSCN3kOQZMx62ISwcXiWOqXEUqwirVirw0x3jo1sUk/oizQhd/DeTku/MJBImHvxgechh8tkVl64JLz5Dbn2QpzWb/1N9Vl09zSopuNBskOwrVunlhpNMsIVrmfFnTXSD/GgCftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by SA2PR11MB5098.namprd11.prod.outlook.com (2603:10b6:806:11c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Wed, 20 Mar
 2024 16:23:01 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52%4]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 16:23:01 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "hao.xiang@bytedance.com" <hao.xiang@bytedance.com>, 
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>, "Zou, Nanhai"
 <nanhai.zou@intel.com>
Subject: RE: [PATCH v5 5/7] migration/multifd: implement initialization of qpl
 compression
Thread-Topic: [PATCH v5 5/7] migration/multifd: implement initialization of
 qpl compression
Thread-Index: AQHaeqFFcriI4s02jkWbmxh5d6Bh27FAcVgAgABDk6CAAA4OAIAACKEg
Date: Wed, 20 Mar 2024 16:23:01 +0000
Message-ID: <PH7PR11MB5941F8AE52DBD0F197798103A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-6-yuan1.liu@intel.com> <Zfq9lBXZWcy3Alhw@redhat.com>
 <PH7PR11MB59410E02C6C7CECD7E30AA4FA3332@PH7PR11MB5941.namprd11.prod.outlook.com>
 <ZfsCDhnYYmjxLTRW@x1n>
In-Reply-To: <ZfsCDhnYYmjxLTRW@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|SA2PR11MB5098:EE_
x-ms-office365-filtering-correlation-id: ed77e92d-e4b9-4cc0-22a2-08dc48fa0383
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uNDYmOawQwSO34RC+MKdHKA23lPhq6RyDv3L69Ut3+EbjIwy0p0pPF0HPIQ5Gvlqm3eKu3vW1nIKJlCnvE5Wa4JqdHTzZTbNsTrCtUK2zLk3SuE2V9Ic+wxhuXZwzwL1RmnDf79/JSnOh8QJkvzBzfsn4nh7sL2Mkg5r2ptQv26yVG2+pOVOumBdyaOaQHmY6eFDZW1wXAdgfScTwWbl89clB8en+ScfXiz/LhSyGj6kwKIkt8M5uGIt7UrvgiS7ySN9jUFtYrTf9BVrYWDx5pg3oSvbjLSkgh2K4nPge8O78KPnJPCdYhzBaYN7/fZ8k4XrGQlvQUvtUTu6ZMyR2ZhEdON1WkXHdIA1CcqWzBSjNlopxlGI/xMZHjP9K1q7PN9rgyhkUCIWA1msS0yi1cM6AAfXm+jS7KedPMIiZQkCTueW4yGy4McJQBsdY7vD6Uep081zgkBCBK0gCvhIw8haI8+zlWgIjb/KWbgfeCnwOGIFW+fxPVF9wp4GUkkLJmOHddhBB6lh+kVgdjtF91ZRLjttzob6eAld63yzEd8Dlm5eyeIUxTCj833jJj9SzQPzsrrGhd/jEQGRrk8djLI9eCY4nXyoxLNT16KbMXcHE1SjMR15QgpSN8vPsIenu9zW9L8/w3SLC+z7aGV8JynY/Lkk0pBYLpDVukTMn8J3WJrbNpVtBOXy/p+t0wayEPF93WxkF7xlxec1BfMJgA0jLlpKd0QKwfbwLlPe5GY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDM5bW9wMjBGWE42T285SEV6RU9pMHcxWUo4azFhSVNLWWhaWU5ZcVNjWjNR?=
 =?utf-8?B?aHVHSDNwUXk4UzJBc09qVWtYWTdHeXZzc1h0Q2NiVDQyMDlHL25YNjdreFdR?=
 =?utf-8?B?cE94RVA0aXBMZEtQMXM0Qk83YkdRbXMrckF3SXFJUldlLzhGcjRiVXp4UUtM?=
 =?utf-8?B?NWxtL2hhM29hVVh3L0o5bVhxQ3B5TFplM1FBWEpjdFhNa25tZ2hvY3B3eGJ1?=
 =?utf-8?B?NDVLNGRiUW5FVHEwLzJ0d0Q1R0t6SlQyYXNHcTQ2ZjAvK1VzVS9aU01IZllu?=
 =?utf-8?B?OVJzNXR2OFl2TVZqRFBTRGJCb0dZTTFscGFuOFBBejFmRjVzY1NxRVBqYy8y?=
 =?utf-8?B?NXlVaUhGdGtNK0xEdjFMZ3JCZnQya084Wkhia2tUYW9SNXFUMWxHM2JJbGEr?=
 =?utf-8?B?R2JwUmpRZEtTYTlYa0FUUDRldFQzMnE5S1h4UDBvR2E0L3RtQTkyMGtRa1E4?=
 =?utf-8?B?OUVpUXYxK1JZSHpTZE9CaDRQMXdWdUNMUFVWUVZmM09TSFo0OE9pS1lTZHZT?=
 =?utf-8?B?eFFlMndhYUIrSnYrb1F1Y05jZy96Mkh0RHZGVGhLVWhzamR0OTZ3MTF1ZzRY?=
 =?utf-8?B?R1R0M3VYZWVLSmN2V012YlRBdG1HT2dsKzFtcVZORVFYQkk1THNXUXM1b2FE?=
 =?utf-8?B?dE1tRHR4ckI2MWlOZXBuZURUdWtpVHBrRW4zcjg3cTRPVnVkUU8rRm1RdC8x?=
 =?utf-8?B?WWIzUUZhaVM1MFVrZFBKVGI2aXFDOWJxdDBMcXA2c0pJbkxQTFBnQ3AzOE5o?=
 =?utf-8?B?Y3Z4Nk5VUkdNWjUxM1pBTzU2RjNMN1V5QTRXYzlqQ21SUEwvWG1zemVmMEZF?=
 =?utf-8?B?eVA3M0hXTUt6Wk1RYVJrc3dBYS9Ka09mWFZFVDNhc3Q0MTVPUE5YVnZnaEt5?=
 =?utf-8?B?MkppLzNDWklFSk9ZRnBqNkN1bmlWS0docGk3NzNBdnN2a0lweWtyeERhcjlJ?=
 =?utf-8?B?aFMwbkh1dVdDaUlpWlJwWlNvQzBJNm5GMitqeFphMzVZVUluRHNXNW5KbUE2?=
 =?utf-8?B?ZWxpdW9JajJpeTNxbVN4L0xFUmZPQ0s4MG5mUjhGREZ0SFNFNFQ1dEk4eUJ4?=
 =?utf-8?B?K0l0ckRyK0NDb0tPeWcwU3p1dG1xSXd2Wit1T0dzaXI1Tm5iQ1B3SUMyejFQ?=
 =?utf-8?B?NjBYSmhTRUR2N1FscXhMNWFvWXpTS0Q0R0d2ekhoOGMxSEQ0QnlFQ1RHNVNm?=
 =?utf-8?B?NlhjdVN3THJLcmNHS0xzdlBxRnhGSVBpQTFWYU5jZHhHK1QybFBmc1FFN1Rh?=
 =?utf-8?B?TFJDaVR5SmU0UnhJc3o2Z2JWNU9uMXA2ZCs2TFNHRlFCencyTFIwTHR3ZU1v?=
 =?utf-8?B?QjVuRnRHanBzRzBXSUphdEtNYjQrMTNyeWxxcTMzc2xxTjRUaXRZa2dyQWw3?=
 =?utf-8?B?ZzRlUjJWbjUvdk1kZzZ2VUJUQlV1bW5WRnZjbExTQWJpeEE5T25DRVM5a0xF?=
 =?utf-8?B?MDhCT3NyVm9UZFFkbEx1bE1UbjlXVFBhMkVHU0haL3J2anBTQk9iSFk3Nm04?=
 =?utf-8?B?NDZJMEd4L2J0eWFkTWd6QWdESlorLzNBUTk5bVFaL0pKUHNXUmlET0w0Vmwz?=
 =?utf-8?B?ZmlMeUpyMk9UYzJUWmJoZDg3Z3VFcGhtQ2VRNEZaQzhNb3BacWZoRnhIMlJ6?=
 =?utf-8?B?SW53QXJnaWlFVFFHaDhvZklQYVhvSGtVU3FGbTBqOFd6OHcvV3o5bmRHNWoz?=
 =?utf-8?B?UGtDNG0yOUZyT05Sc0kyTlFON1ZrYWI3N3FqSXZrM2tCVk9VN1Q3dkZLRlBu?=
 =?utf-8?B?cndadmFqNnRXanU1VEtCOFl3TG9abXNPdEEyQ0xkZ21qVTk0d2I4SEQ3REVh?=
 =?utf-8?B?cURKVXFXNUJMQzVlY0pORFFVcy9NaGJua1RKdmU4YzJ3RFRERElYanp6d1FG?=
 =?utf-8?B?VjdCcGxycUprQW8xbjZzZFZuUDAyY1QzTTYxNDg5dFp5NHdUM1NPVzhJNjZk?=
 =?utf-8?B?alM5cnpxUXBRbFlVclNVV1pUUGU0d1psb0ZwZXdCSVhrWVVYN1VhblFxeUpR?=
 =?utf-8?B?L0tXZHlrTTAxRVZYRlA0SGdTc0pnOThzbDZjL1FsUmRPOHFicXp2bHhwTGsz?=
 =?utf-8?B?VUxMNkxxR1pnMWEzdnVLVDZmM1dUeVVZZ2UxMmZ5bmtQU3B2VzhRUlJqa1hW?=
 =?utf-8?Q?/ueqEO6USBackEwXTnJJ9JeSr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed77e92d-e4b9-4cc0-22a2-08dc48fa0383
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 16:23:01.7693 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBrRklhd/4vMEfpWJXwbJwPDN0+FUF/6CvkUGdoEOnJHWH8240a1ukDOdD55rWbMtTp63J/K7sx7xCrTtQzK0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5098
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
ZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjAsIDIwMjQgMTE6MzUgUE0NCj4g
VG86IExpdSwgWXVhbjEgPHl1YW4xLmxpdUBpbnRlbC5jb20+DQo+IENjOiBEYW5pZWwgUC4gQmVy
cmFuZ8OpIDxiZXJyYW5nZUByZWRoYXQuY29tPjsgZmFyb3Nhc0BzdXNlLmRlOyBxZW11LQ0KPiBk
ZXZlbEBub25nbnUub3JnOyBoYW8ueGlhbmdAYnl0ZWRhbmNlLmNvbTsgYnJ5YW4uemhhbmdAYnl0
ZWRhbmNlLmNvbTsgWm91LA0KPiBOYW5oYWkgPG5hbmhhaS56b3VAaW50ZWwuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY1IDUvN10gbWlncmF0aW9uL211bHRpZmQ6IGltcGxlbWVudCBpbml0
aWFsaXphdGlvbiBvZg0KPiBxcGwgY29tcHJlc3Npb24NCj4gDQo+IE9uIFdlZCwgTWFyIDIwLCAy
MDI0IGF0IDAzOjAyOjU5UE0gKzAwMDAsIExpdSwgWXVhbjEgd3JvdGU6DQo+ID4gPiA+ICtzdGF0
aWMgaW50IGFsbG9jX3pidWYoUXBsRGF0YSAqcXBsLCB1aW50OF90IGNoYW5faWQsIEVycm9yICoq
ZXJycCkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKyAgICBpbnQgZmxhZ3MgPSBNQVBfUFJJVkFURSB8
IE1BUF9QT1BVTEFURSB8IE1BUF9BTk9OWU1PVVM7DQo+ID4gPiA+ICsgICAgdWludDMyX3Qgc2l6
ZSA9IHFwbC0+am9iX251bSAqIHFwbC0+ZGF0YV9zaXplOw0KPiA+ID4gPiArICAgIHVpbnQ4X3Qg
KmJ1ZjsNCj4gPiA+ID4gKw0KPiA+ID4gPiArICAgIGJ1ZiA9ICh1aW50OF90ICopIG1tYXAoTlVM
TCwgc2l6ZSwgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwNCj4gZmxhZ3MsIC0NCj4gPiA+IDEsIDAp
Ow0KPiA+ID4gPiArICAgIGlmIChidWYgPT0gTUFQX0ZBSUxFRCkgew0KPiA+ID4gPiArICAgICAg
ICBlcnJvcl9zZXRnKGVycnAsICJtdWx0aWZkOiAldTogYWxsb2NfemJ1ZiBmYWlsZWQsIGpvYg0K
PiBudW0gJXUsDQo+ID4gPiBzaXplICV1IiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICBj
aGFuX2lkLCBxcGwtPmpvYl9udW0sIHFwbC0+ZGF0YV9zaXplKTsNCj4gPiA+ID4gKyAgICAgICAg
cmV0dXJuIC0xOw0KPiA+ID4gPiArICAgIH0NCj4gPiA+DQo+ID4gPiBXaGF0J3MgdGhlIHJlYXNv
biBmb3IgdXNpbmcgbW1hcCBoZXJlLCByYXRoZXIgdGhhbiBhIG5vcm1hbA0KPiA+ID4gbWFsbG9j
ID8NCj4gPg0KPiA+IEkgd2FudCB0byBwb3B1bGF0ZSB0aGUgbWVtb3J5IGFjY2Vzc2VkIGJ5IHRo
ZSBJQUEgZGV2aWNlIGluIHRoZQ0KPiBpbml0aWFsaXphdGlvbg0KPiA+IHBoYXNlLCBhbmQgdGhl
biBhdm9pZCBpbml0aWF0aW5nIEkvTyBwYWdlIGZhdWx0cyB0aHJvdWdoIHRoZSBJQUEgZGV2aWNl
DQo+IGR1cmluZw0KPiA+IG1pZ3JhdGlvbiwgYSBsYXJnZSBudW1iZXIgb2YgSS9PIHBhZ2UgZmF1
bHRzIGFyZSBub3QgZ29vZCBmb3INCj4gcGVyZm9ybWFuY2UuDQo+IA0KPiBtbWFwKCkgZG9lc24n
dCBwb3B1bGF0ZSBwYWdlcywgdW5sZXNzIHdpdGggTUFQX1BPUFVMQVRFLiAgQW5kIGV2ZW4gd2l0
aA0KPiB0aGF0IGl0IHNob3VsZG4ndCBiZSBndWFyYW50ZWVkLCBhcyB0aGUgcG9wdWxhdGUgcGhh
c2Ugc2hvdWxkIGlnbm9yZSBhbGwNCj4gZXJyb3JzLg0KPiANCj4gICAgICAgIE1BUF9QT1BVTEFU
RSAoc2luY2UgTGludXggMi41LjQ2KQ0KPiAgICAgICAgICAgICAgIFBvcHVsYXRlIChwcmVmYXVs
dCkgcGFnZSB0YWJsZXMgZm9yIGEgbWFwcGluZy4gIEZvciBhIGZpbGUNCj4gbWFw4oCQDQo+ICAg
ICAgICAgICAgICAgcGluZywgdGhpcyBjYXVzZXMgcmVhZC1haGVhZCBvbiB0aGUgZmlsZS4gIFRo
aXMgd2lsbCBoZWxwIHRvDQo+IHJl4oCQDQo+ICAgICAgICAgICAgICAgZHVjZSAgYmxvY2tpbmcg
IG9uICBwYWdlICBmYXVsdHMgbGF0ZXIuICBUaGUgbW1hcCgpIGNhbGwNCj4gZG9lc24ndA0KPiAg
ICAgICAgICAgICAgIGZhaWwgaWYgdGhlIG1hcHBpbmcgY2Fubm90IGJlIHBvcHVsYXRlZCAgKGZv
ciAgZXhhbXBsZSwgIGR1ZQ0KPiB0bw0KPiAgICAgICAgICAgICAgIGxpbWl0YXRpb25zICBvbiAg
dGhlICBudW1iZXIgIG9mICBtYXBwZWQgIGh1Z2UgIHBhZ2VzIHdoZW4NCj4gdXNpbmcNCj4gICAg
ICAgICAgICAgICBNQVBfSFVHRVRMQikuICBTdXBwb3J0IGZvciBNQVBfUE9QVUxBVEUgaW4gY29u
anVuY3Rpb24gd2l0aA0KPiBwcmnigJANCj4gICAgICAgICAgICAgICB2YXRlIG1hcHBpbmdzIHdh
cyBhZGRlZCBpbiBMaW51eCAyLjYuMjMuDQo+IA0KPiBPVE9ILCBJIHRoaW5rIGdfbWFsbG9jMCgp
IHNob3VsZCBndWFyYW50ZWUgdG8gcHJlZmF1bHQgZXZlcnl0aGluZyBpbiBhcw0KPiBsb25nIGFz
IHRoZSBjYWxsIHJldHVybmVkIChldmVuIHRob3VnaCB0aGV5IGNhbiBiZSBzd2FwcGVkIG91dCBs
YXRlciwgYnV0DQo+IHRoYXQgYXBwbGllcyB0byBhbGwgY2FzZXMgYW55d2F5KS4NCg0KVGhhbmtz
LCBQZXRlci4gSSB3aWxsIHRyeSB0aGUgZ19tYWxsb2MwIG1ldGhvZCBoZXJlDQoNCj4gPiBUaGlz
IHByb2JsZW0gYWxzbyBvY2N1cnMgYXQgdGhlIGRlc3RpbmF0aW9uLCB0aGVyZWZvcmUsIEkgcmVj
b21tZW5kIHRoYXQNCj4gPiBjdXN0b21lcnMgbmVlZCB0byBhZGQgLW1lbS1wcmVhbGxvYyBmb3Ig
ZGVzdGluYXRpb24gYm9vdCBwYXJhbWV0ZXJzLg0KPiANCj4gSSdtIG5vdCBzdXJlIHdoYXQgaXNz
dWUgeW91IGhpdCB3aGVuIHRlc3RpbmcgaXQsIGJ1dCAtbWVtLXByZWFsbG9jIGZsYWcNCj4gc2hv
dWxkIG9ubHkgY29udHJvbCB0aGUgZ3Vlc3QgbWVtb3J5IGJhY2tlbmRzIG5vdCB0aGUgYnVmZmVy
cyB0aGF0IFFFTVUNCj4gaW50ZXJuYWxseSB1c2UsIGFmYWl1Lg0KPiANCj4gVGhhbmtzLA0KPiAN
Cj4gLS0NCj4gUGV0ZXIgWHUNCg0KbGV0IG1lIGV4cGxhaW4gaGVyZSwgZHVyaW5nIHRoZSBkZWNv
bXByZXNzaW9uIG9wZXJhdGlvbiBvZiBJQUEsIHRoZSBkZWNvbXByZXNzZWQgZGF0YQ0KY2FuIGJl
IGRpcmVjdGx5IG91dHB1dCB0byB0aGUgdmlydHVhbCBhZGRyZXNzIG9mIHRoZSBndWVzdCBtZW1v
cnkgYnkgSUFBIGhhcmR3YXJlLiANCkl0IGNhbiBhdm9pZCBjb3B5aW5nIHRoZSBkZWNvbXByZXNz
ZWQgZGF0YSB0byBndWVzdCBtZW1vcnkgYnkgQ1BVLg0KDQpXaXRob3V0IC1tZW0tcHJlYWxsb2Ms
IGFsbCB0aGUgZ3Vlc3QgbWVtb3J5IGlzIG5vdCBwb3B1bGF0ZWQsIGFuZCBJQUEgaGFyZHdhcmUg
bmVlZHMgdG8gdHJpZ2dlcg0KSS9PIHBhZ2UgZmF1bHQgZmlyc3QgYW5kIHRoZW4gb3V0cHV0IHRo
ZSBkZWNvbXByZXNzZWQgZGF0YSB0byB0aGUgZ3Vlc3QgbWVtb3J5IHJlZ2lvbi4gDQpCZXNpZGVz
IHRoYXQsIENQVSBwYWdlIGZhdWx0cyB3aWxsIGFsc28gdHJpZ2dlciBJT1RMQiBmbHVzaCBvcGVy
YXRpb24gd2hlbiBJQUEgZGV2aWNlcyB1c2UgU1ZNLiANCg0KRHVlIHRvIHRoZSBpbmFiaWxpdHkg
dG8gcXVpY2tseSByZXNvbHZlIGEgbGFyZ2UgbnVtYmVyIG9mIElPIHBhZ2UgZmF1bHRzIGFuZCBJ
T1RMQiBmbHVzaGVzLCB0aGUNCmRlY29tcHJlc3Npb24gdGhyb3VnaHB1dCBvZiB0aGUgSUFBIGRl
dmljZSB3aWxsIGRlY3JlYXNlIHNpZ25pZmljYW50bHkuDQoNCg==

