Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F73CD5BD5
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 06:00:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS7Jw-00060e-Jb; Wed, 27 May 2026 02:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS7JZ-0005yX-Ga; Wed, 27 May 2026 02:00:28 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wS7JW-0007xS-6W; Wed, 27 May 2026 02:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779861623; x=1811397623;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wyrNhw35DBwAWbnPQQm/QBYilSPyw1QFjy3aaxDXfWc=;
 b=PodI71shjZokRzljqLkU1x4pMKs6j94Ioa5G6Jk9s5ZpMkNgzjCbeCty
 Rf410umhuY1Vh55aEj3NiXhypNqhtdAzzYrDuj+Y7a76tSUJJTHvo3ofa
 FIpAtpuwJAPDZxpgKf5OLINWYTiJNauUD2pbcO/9eFaGov9m4ahznb8sT
 J2YgBfkSmj2X3XqcxQqUHN+hgZhmNSQ4/UWKx1lqMjtjV8r3j7YapMR9b
 4wEOtdC1rjvxIH0cXLPVrIniUwN6KI5oNr1t4v+g3TS0e0u/W5UkWj6bi
 vBpfF7DJzn/PJzKk/p627PiLyCErMzN4Fm3xlhtMc9BgwLNu/z4uRPjK/ A==;
X-CSE-ConnectionGUID: 3Mqv4/ZESFSVFVIMJtpZRA==
X-CSE-MsgGUID: R0TAscwyQeqzWXLRddErpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80742149"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="80742149"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 23:00:19 -0700
X-CSE-ConnectionGUID: O6CSaX++SauIZ77wqD99tA==
X-CSE-MsgGUID: GT0bcSn8RqOVkQNLGOXGTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="237707758"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 23:00:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 23:00:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 23:00:17 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.64) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 23:00:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdL3B8o768dDKCleAFM7gemT+7cq0e5k6rfy2lcvsF5gUI9ZeAzTV/0KQHkSYkEtNccnd/4xF/VNypCyHujUUoWHpIkNprkPtawNYXGBUg9ovS+4wddgLDL8BwARK6/0z0X/aQjoDQoX85JvbulsRmThyke3g6t/ncfGQo6znmGYNmx504DkVsDdt+Odslfs1eWNmHx8zN9k85irZ4dZd14ZdKZY2yiEWw21S8VPX4FrH3ONOOQm2ed9LyvOq23dsfLk357Tg+ntBv8oQZ0n8lZqEIF8hbf77SCjN4vF0pS+iIOr3ol2mYk18OjbHAU8/aVZ23KOFHxViNprAhXmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyrNhw35DBwAWbnPQQm/QBYilSPyw1QFjy3aaxDXfWc=;
 b=IPPYVNd4ykmv8CHRyNkrY161hNBgQhPx0pUTeLpq3dBTwCKhd2VcrhtvOx4TgsELeTkxw0fY362Vhi/6p8HlnMMR7lEilm7Mx7RY6ZriL5TjCnXGKhljC5REhiPzbDRTJU9X+L3QPSmagb0t4PDku+Wz0sb7iKrPseu+3qaVrHbkPgdUCnSIq72zZMvEjFEdIURV6qODV5wukeFdYLDWXy7zmD1l18AYf5fkM6NcpyxQ5PzyMHxjm1FoBpT5sdK6mSzmWKfqKW04uN1oppMC+4MECUcXr4pQT98D+sOfHen3O1CdOG6ilEoc38kyNK8pYFf8kXTpQ+BzG5soM8q0/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW5PR11MB5929.namprd11.prod.outlook.com (2603:10b6:303:194::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 06:00:08 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.21.0048.016; Wed, 27 May 2026
 06:00:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH 2/5] backends/iommufd: Extend iommufd_backend_alloc_hwpt()
 with fault_id
Thread-Topic: [PATCH 2/5] backends/iommufd: Extend
 iommufd_backend_alloc_hwpt() with fault_id
Thread-Index: AQHcvZTTjBYa4LsKEUuVFzhZpszIs7YYuHAAgAkGnbA=
Date: Wed, 27 May 2026 06:00:08 +0000
Message-ID: <IA3PR11MB913621A7B6A7C219821547AD92082@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260327025228.474257-1-zhenzhong.duan@intel.com>
 <20260327025228.474257-3-zhenzhong.duan@intel.com>
 <aa7b6186-9605-49bf-851f-352ddcc6f55d@intel.com>
In-Reply-To: <aa7b6186-9605-49bf-851f-352ddcc6f55d@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW5PR11MB5929:EE_
x-ms-office365-filtering-correlation-id: d3fc5edf-da90-413a-f540-08debbb534cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|11063799006|22082099003|18002099003|4143699003|56012099006;
x-microsoft-antispam-message-info: 6y+Th6B7g5zctvxig/gZvYnfWwQlvW4WLFs6cz1mZsfgFv87I4HGR8XzgXqcCs7DHw64zIBAtXICSAADa03cpOmIOW7x+VgJmdrhIFOINUv5or16fBC4QbZRXhDKGrvTm1wsm0gkLI9pv69TcIRZFujT9+kUq+SUsrQZr0qmSOBad5XfbVh9WCtlK2VC8BsGQYJchit+BOoGkJ3ac7bc1IQRryuHCKnUtWwxYAP+vStrcatGypJxxgewp7xn8xO60l37bkt+sFEVzQd2crlQyONx1eswbTs7HjMKV/ynbYrFwhiiX8UEUjro9vkjJcz41OFLMs1RxTBNSTrqumNK/RE/irUP1pkGAIJx2xjkuXEohuLZ0CjOmig1FwFwMblE6X4JmgIBEZZZN6bBSxyg72rmGm7yWvM13RvoyuDYnS3LkGvc94Tz6UxmwEWLNWtBpGV6Z5GyDpxGCPlR2/PVADM629lzO+0FPeigbARF/W7Z3Eo7ESDt2Qii/bNV99hJGtFVFChShfhHA7WXKJCh3TqKA3jOl2u8m/hlEzPpELucF1ylwlrqCGXyeCqOUpslBYDxaIL56Ztqeufq3qTpi51TNUnCaNtSPEVnma4kX09GyM+n6UszbV2rejbWGhKzJ8O1F/UPDW0m0Ep8MdgAo3fqv04ZlhRf5zLjrmQ0ZgPp44vK/Lyhs2SzprcxN9i+JwyrMknwNqF9Vjd4wGuS5w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(11063799006)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlErTlVSSVJ6WHZ0MnYveUROZm1jSDFxNDBpaU5RSTVvdjcwVE93WTBuQXBv?=
 =?utf-8?B?bWxNMUR2dXo0d1d2ZFd5WFlvVm9RTkVIaXZnazU4VnJLYzNUL01vN3l6b2JI?=
 =?utf-8?B?VVRaWlcxRGROVXRzRTRUZHdueVdzUkJNMW1MN3dpaXhZS0dFZFI4czhGNmJE?=
 =?utf-8?B?alJDb0VyMjVIYjE2bE5hdS9ZTUNzbEtXcXB0THVMV1lJSVlEM1MzWnFGRnFa?=
 =?utf-8?B?TGZaN2k3WXprRFV5VVJhMGx0TnJBTnArQlMrdUR4Zy80K3diYTltV0dqUnRi?=
 =?utf-8?B?MzVnOW1XY0l0R1hXNlVCSnF5WUc2Z1NSRlN2OVRnaTd3RGtVTkx0RXJxQy9K?=
 =?utf-8?B?NklWenNXNFQ0QytRSW51Z2NtTFMrMHZ3WnlzUUxCVm4vK1NIbThoSE9HSHhK?=
 =?utf-8?B?eEFuZGs3R0tobWFCVzlJK0FXS1ZQS1NzdFdOOUo4ZFYrVTh5M1h6dmZZL05k?=
 =?utf-8?B?elZVMXcrdEFTQUpDaVhyWGVMaTAraldXQm5SRUlXZkw1NVdyVE10cTlSNHlh?=
 =?utf-8?B?L3NvNjBBUWNLNmFhRGJ4T1E5ZDNzdjBnTTNTVitKekk1ZXJvKzEzVVV6OENI?=
 =?utf-8?B?eVluNFBtbW9pa29SZ1plYXBSazJ0Wko5MVQ1YUVYUWhDZ2k0bDM2YW1Yc1Vu?=
 =?utf-8?B?VHZuWU1OK2V1ZzdSUVVsUU1TeXE0YW1RbWZVWHVaaHZJcnlmWC9pb1Uzdkl0?=
 =?utf-8?B?WnIxRmZEOHM5WE96b3BBY1ljZlFBOERoSTNUOTFsc2tmcnplb0NqVWRLcnpW?=
 =?utf-8?B?V0s1NlpIQzZqRU96b0tLdndJY1EvZkdCQmZwS0NzblpsK3VDS3ZUajUyVlhX?=
 =?utf-8?B?eG9IRkhHYUd5OEEzVFNNUWdNQ2l6MlZPN1lCaXV2MlNuTXptNVp3bHVYTjR4?=
 =?utf-8?B?My9RbVR6U0NyY0tOdEhwcGJKc2FLOVJPZ1FkSWM3cWNVU004bFAva09rOEVz?=
 =?utf-8?B?aHl1TVBpbENhR09LZ0ljNE5RWjRhTUpNbncrRGxwakJQRkxzQURWcUY2akF1?=
 =?utf-8?B?VjIvWTVSemdpdXlWWjljSXhMcjF0QUNRelRmQklERHYxTGk1c1IvUWdCOVZK?=
 =?utf-8?B?Ri9TdzFyaE5XUnM5bzcvb2t3WmRoSGNXZGlaN1BrdHJ1dkxWMnoxck9tdm1z?=
 =?utf-8?B?RS9UVjVMLzRlQzdGME5DMDdzZGt5V0tNNENoaFBqTEY5S1RQb2RnWFFmcDhl?=
 =?utf-8?B?T0R3blYyaU1JcGF2bERFV2RFaUkrVFNiRWRqSzFKQkdaelpteUYyM0Mranpk?=
 =?utf-8?B?SGVVNVllM2h2cGtaajR6SlE0eDFVekNJc3U5djZZMml3b0UxRDdEVWJuVFFO?=
 =?utf-8?B?d0c0cUJsbzhDRzJCU2hZVzhVdVJQYndCaGwxZDUwOGcxWGwrenVKSjA2aUZ6?=
 =?utf-8?B?aXZtVmZDSTZOUEZqRjQ3RkJvRVAzME9mL3dqQWJOU2t6eWw2MkVKWk5SZE9M?=
 =?utf-8?B?amN6R1VjMmV6cXB2bHhMb2tkZUxkL0FRbTBsM1lsRHhVZXFNYTgvQlRBTitR?=
 =?utf-8?B?VDdEK1lzanZyblZhbzROYkh1SjBsUjJjQ29pdTZRcDNXMzZ1VVlMZDdYcTRQ?=
 =?utf-8?B?ZGgyR0gzZUtvcitzbDhiK3lBRjZnVElmM0hPeFpQYlZBbzhWVEY3aVExTU5v?=
 =?utf-8?B?TnRVdFJzQkxjeXEyS1FJQUh5MUY3QllVYmZJSUJ2QnRLQkM3WnVSR21WK3VP?=
 =?utf-8?B?WVJlaXZMWDdrY2FaME1OcFM5R3N1a1Z2Wm9kYVhkdTNIaFV5QjVhNTR0WmhN?=
 =?utf-8?B?Q0szNW9kaWtkTm5McDdRcElFZk9GSzZ5ZHZpaklPcDFOK3ArUjIyL0d6QW1R?=
 =?utf-8?B?YmJQd3NlWiszSkVhZWlzNWlSMnZmK20wL2JSeGloS29SUWZlaFZaSW1neXZT?=
 =?utf-8?B?MkJPUXFmMnJoak1yV3FYRWpiVGNINkZ1NWw1Vmx4eXhrZnQ5endmZ1phZ2hl?=
 =?utf-8?B?NzRFd3FyeDFtVzZHSDBDbllUS1QzMHBVd1JLd0VOYUJXWTZwMjdXdlZZdVdn?=
 =?utf-8?B?UjZ2S21Dbk5WU2RDRmY1TjdGSGR1VXZsWjRWYmR0a1NFUmozSjd0NFpEajFp?=
 =?utf-8?B?UlY0cXVWajBqK3RjcktCTnNHcjc2NWt6U1RoRzh6dWJhaDY2b00xcDlobXhP?=
 =?utf-8?B?T1AweERJZzRXdnI2NTNzcjlIYkpPNlJlWDRsYkZLMmJVd0tLVEFKTFhlT2Zp?=
 =?utf-8?B?Z2FRb0NWeUJMN3U4VUtPRmJDUnBWcHhBcDdDeVlMaGdWUmlNTEl4R0pMRHdH?=
 =?utf-8?B?aVVoQzJHTTJVOUxObnUrbGllejJNdnNUL0tVNEdqd1BSY0t5R25ZQ2s0U3pI?=
 =?utf-8?B?ZjNrRDRpeGpjT2VGWURMTHZvcGtLU2I2bzZuRXlVaUhXWWg1V0pHdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DUSOgw1MiByi/JLEbQ3texpYnvTGAbn5wVGrKrU+7IziMlLJfBzgr1xq9Eqo62REr9ABEYQNS5N6gcf8dhxtnG/AqCVugNES45/TjpqAcyvmWQnWzOsxwUX3c0Jb9rYsJQSQ12p96s95WJQKIpr6Dg/7l6YbvJU77eU3O9eKfFYjTFhGrref1imEXnjJgmUWttrVnEmglLDtlwWuy79H3PPdBIiBDr6/yTBH5iIRTFA0jCUT4l0iRlUIITJ2HdFFYXSSwsuK4sfoxfijy0WcjPffLtxd6yVFzl2t448QWk34P43Ps4WP+RR/L2Vy+ds6bJ96JFd14qB7yoFPuYn0BQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fc5edf-da90-413a-f540-08debbb534cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 06:00:08.2480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/9vYWntNUMqkUCmhc4OP2t+YJfhX5IianM/gUSXkgBnMesxQS4QpQM7RrCd+lqA0b5ir8/BphFBIgWyDoksuLJgaZOn+J0bjGQTfxotKg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5929
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMi81XSBiYWNrZW5kcy9pb21tdWZk
OiBFeHRlbmQNCj5pb21tdWZkX2JhY2tlbmRfYWxsb2NfaHdwdCgpIHdpdGggZmF1bHRfaWQNCj4N
Cj5PbiAzLzI3LzI2IDEwOjUyLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IE5vIG5lZWQgdG8g
Zm9yY2UgY2FsbGVyIHRvIHNldCBJT01NVV9IV1BUX0ZBVUxUX0lEX1ZBTElELCB3ZSB0YWtlIGl0
DQo+PiBieSBjaGVja2luZyBmYXVsdF9pZCBub256ZXJvLg0KPg0KPnRoaXMgaXMgbm90IHJlbGlh
YmxlLiBUaGVyZSBpcyBubyBkb2MgdGhhdCBjbGFpbXMgZmF1bHRfaWQgc2hvdWxkIGJlDQo+bm9u
LXplcm8uDQoNClllcywgZnJvbSBrZXJuZWwgY29kZSwgMCBpcyBuZXZlciBhbGxvY2F0ZWQgYXMg
YW4gb2JqZWN0IGlkIGJ1dCBpdCdzIG5vdCBkb2N1bWVudGVkIGNsZWFybHkuDQpFcmljIGV2ZXIg
YXNrZWQgdGhlIHNhbWUgcXVlc3Rpb24gYmVmb3JlLiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvYVR1RnFObGx1RDVmUXc0QUBudmlkaWEuY29tLw0KDQpATmljb2xpbiwgQEphc29uRywganVz
dCB3YW50IHRvIGFzayBpZiB5b3UgaGF2ZSBwbGFuIHRvIGRvYyBpdCBpbiBrZXJuZWwuIElmIG5v
LCBJJ2xsIHVwZGF0ZSB0aGlzIHBhdGNoIGZvbGxvd2luZyBZaSdzIHN1Z2dlc3Rpb24uDQoNClRo
YW5rcw0KWmhlbnpob25nDQoNCj4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVh
biA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvc3lzdGVt
L2lvbW11ZmQuaCAgICB8ICA0ICsrLS0NCj4+ICAgYmFja2VuZHMvaW9tbXVmZC5jICAgICAgICAg
IHwgMTMgKysrKysrKysrLS0tLQ0KPj4gICBody9hcm0vc21tdXYzLWFjY2VsLmMgICAgICAgfCAg
NiArKystLS0NCj4+ICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jIHwgIDIgKy0NCj4+ICAg
aHcvdmZpby9pb21tdWZkLmMgICAgICAgICAgIHwgIDIgKy0NCj4+ICAgYmFja2VuZHMvdHJhY2Ut
ZXZlbnRzICAgICAgIHwgIDIgKy0NCj4+ICAgNiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25z
KCspLCAxMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9zeXN0ZW0v
aW9tbXVmZC5oIGIvaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oDQo+PiBpbmRleCBkNGJhODQzNGE1
Li5mNzUzYmZhZjY5IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oDQo+
PiArKysgYi9pbmNsdWRlL3N5c3RlbS9pb21tdWZkLmgNCj4+IEBAIC04NSw4ICs4NSw4IEBAIGJv
b2wNCj5pb21tdWZkX2JhY2tlbmRfZ2V0X2RldmljZV9pbmZvKElPTU1VRkRCYWNrZW5kICpiZSwg
dWludDMyX3QgZGV2aWQsDQo+PiAgIGJvb2wgaW9tbXVmZF9iYWNrZW5kX2FsbG9jX2h3cHQoSU9N
TVVGREJhY2tlbmQgKmJlLCB1aW50MzJfdCBkZXZfaWQsDQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDMyX3QgcHRfaWQsIHVpbnQzMl90IGZsYWdzLA0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGRhdGFfdHlwZSwgdWludDMyX3Qg
ZGF0YV9sZW4sDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpkYXRh
X3B0ciwgdWludDMyX3QgKm91dF9od3B0LA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgRXJyb3IgKiplcnJwKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHZvaWQgKmRhdGFfcHRyLCB1aW50MzJfdCBmYXVsdF9pZCwNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHVpbnQzMl90ICpvdXRfaHdwdCwgRXJyb3IgKiplcnJwKTsNCj4+ICAg
Ym9vbCBpb21tdWZkX2JhY2tlbmRfYWxsb2NfdmlvbW11KElPTU1VRkRCYWNrZW5kICpiZSwgdWlu
dDMyX3QNCj5kZXZfaWQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1
aW50MzJfdCB2aW9tbXVfdHlwZSwgdWludDMyX3QgaHdwdF9pZCwNCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICpvdXRfaHdwdCwgRXJyb3IgKiplcnJwKTsN
Cj4+IGRpZmYgLS1naXQgYS9iYWNrZW5kcy9pb21tdWZkLmMgYi9iYWNrZW5kcy9pb21tdWZkLmMN
Cj4+IGluZGV4IDk0OTYzNzdhMjUuLmZlNjRiYWRlYTAgMTAwNjQ0DQo+PiAtLS0gYS9iYWNrZW5k
cy9pb21tdWZkLmMNCj4+ICsrKyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4gQEAgLTMxMCwyMyAr
MzEwLDI4IEBAIGludA0KPmlvbW11ZmRfYmFja2VuZF91bm1hcF9kbWEoSU9NTVVGREJhY2tlbmQg
KmJlLCB1aW50MzJfdCBpb2FzX2lkLA0KPj4gICBib29sIGlvbW11ZmRfYmFja2VuZF9hbGxvY19o
d3B0KElPTU1VRkRCYWNrZW5kICpiZSwgdWludDMyX3QgZGV2X2lkLA0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHB0X2lkLCB1aW50MzJfdCBmbGFncywNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBkYXRhX3R5cGUsIHVp
bnQzMl90IGRhdGFfbGVuLA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9p
ZCAqZGF0YV9wdHIsIHVpbnQzMl90ICpvdXRfaHdwdCwNCj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHZvaWQgKmRhdGFfcHRyLCB1aW50MzJfdCBmYXVsdF9pZCwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICpvdXRfaHdwdCwgRXJyb3IgKiplcnJwKQ0K
Pj4gICB7DQo+PiAgICAgICBpbnQgcmV0LCBmZCA9IGJlLT5mZDsNCj4+ICAgICAgIHN0cnVjdCBp
b21tdV9od3B0X2FsbG9jIGFsbG9jX2h3cHQgPSB7DQo+PiAgICAgICAgICAgLnNpemUgPSBzaXpl
b2Yoc3RydWN0IGlvbW11X2h3cHRfYWxsb2MpLA0KPj4gLSAgICAgICAgLmZsYWdzID0gZmxhZ3Ms
DQo+PiAgICAgICAgICAgLmRldl9pZCA9IGRldl9pZCwNCj4+ICAgICAgICAgICAucHRfaWQgPSBw
dF9pZCwNCj4+ICAgICAgICAgICAuZGF0YV90eXBlID0gZGF0YV90eXBlLA0KPj4gICAgICAgICAg
IC5kYXRhX2xlbiA9IGRhdGFfbGVuLA0KPj4gICAgICAgICAgIC5kYXRhX3VwdHIgPSAodWludHB0
cl90KWRhdGFfcHRyLA0KPj4gKyAgICAgICAgLmZhdWx0X2lkID0gZmF1bHRfaWQsDQo+PiAgICAg
ICB9Ow0KPj4NCj4+ICsgICAgaWYgKGZhdWx0X2lkKSB7DQo+PiArICAgICAgICBmbGFncyB8PSBJ
T01NVV9IV1BUX0ZBVUxUX0lEX1ZBTElEOw0KPj4gKyAgICB9DQo+PiArICAgIGFsbG9jX2h3cHQu
ZmxhZ3MgPSBmbGFnczsNCj4+ICsNCj4+ICAgICAgIHJldCA9IGlvY3RsKGZkLCBJT01NVV9IV1BU
X0FMTE9DLCAmYWxsb2NfaHdwdCk7DQo+PiAgICAgICB0cmFjZV9pb21tdWZkX2JhY2tlbmRfYWxs
b2NfaHdwdChmZCwgZGV2X2lkLCBwdF9pZCwgZmxhZ3MsIGRhdGFfdHlwZSwNCj4+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGF0YV9sZW4sICh1aW50cHRyX3QpZGF0YV9w
dHIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhdGFfbGVuLCAo
dWludHB0cl90KWRhdGFfcHRyLCBmYXVsdF9pZCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGFsbG9jX2h3cHQub3V0X2h3cHRfaWQsIHJldCk7DQo+PiAgICAgICBp
ZiAocmV0KSB7DQo+PiAgICAgICAgICAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCBlcnJubywgIkZh
aWxlZCB0byBhbGxvY2F0ZSBod3B0Iik7DQo+PiBkaWZmIC0tZ2l0IGEvaHcvYXJtL3NtbXV2My1h
Y2NlbC5jIGIvaHcvYXJtL3NtbXV2My1hY2NlbC5jDQo+PiBpbmRleCAwYWY2YjMyOTZkLi4xZTJm
YjFlNzQ4IDEwMDY0NA0KPj4gLS0tIGEvaHcvYXJtL3NtbXV2My1hY2NlbC5jDQo+PiArKysgYi9o
dy9hcm0vc21tdXYzLWFjY2VsLmMNCj4+IEBAIC0yMjQsNyArMjI0LDcgQEANCj5zbW11djNfYWNj
ZWxfZGV2X2FsbG9jX3RyYW5zbGF0ZShTTU1VdjNBY2NlbERldmljZSAqYWNjZWxfZGV2LCBTVEUg
KnN0ZSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWNjZWwtPnZp
b21tdS0+dmlvbW11X2lkLCBmbGFncywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgSU9NTVVfSFdQVF9EQVRBX0FSTV9TTU1VVjMsDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihuZXN0ZWRfZGF0YSksICZuZXN0ZWRfZGF0YSwN
Cj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmaHdwdF9pZCwgZXJycCkp
IHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLCAmaHdwdF9pZCwg
ZXJycCkpIHsNCj4NCj5zYW1lIHJlbWFyay4gcGFzc2luZyAwIGlzIG5vdCByZWxpYWJsZS4gOigN
Cj4NCj4+ICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+PiAgICAgICB9DQo+Pg0KPj4gQEAg
LTU1OCwxNCArNTU4LDE0IEBAIHNtbXV2M19hY2NlbF9hbGxvY192aW9tbXUoU01NVXYzU3RhdGUg
KnMsDQo+SG9zdElPTU1VRGV2aWNlSU9NTVVGRCAqaWRldiwNCj4+ICAgICAgIGlmICghaW9tbXVm
ZF9iYWNrZW5kX2FsbG9jX2h3cHQoaWRldi0+aW9tbXVmZCwgaWRldi0+ZGV2aWQsIHZpb21tdV9p
ZCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMCwgSU9NTVVfSFdQ
VF9EQVRBX0FSTV9TTU1VVjMsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHNpemVvZihhYm9ydF9kYXRhKSwgJmFib3J0X2RhdGEsDQo+PiAtICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJmFjY2VsLT5hYm9ydF9od3B0X2lkLCBlcnJwKSkgew0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsICZhY2NlbC0+YWJvcnRfaHdw
dF9pZCwgZXJycCkpIHsNCj4+ICAgICAgICAgICBnb3RvIGZyZWVfdmlvbW11Ow0KPj4gICAgICAg
fQ0KPj4NCj4+ICAgICAgIGlmICghaW9tbXVmZF9iYWNrZW5kX2FsbG9jX2h3cHQoaWRldi0+aW9t
bXVmZCwgaWRldi0+ZGV2aWQsIHZpb21tdV9pZCwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgMCwgSU9NTVVfSFdQVF9EQVRBX0FSTV9TTU1VVjMsDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihieXBhc3NfZGF0YSksICZieXBh
c3NfZGF0YSwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmYWNjZWwt
PmJ5cGFzc19od3B0X2lkLCBlcnJwKSkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDAsICZhY2NlbC0+YnlwYXNzX2h3cHRfaWQsIGVycnApKSB7DQo+PiAgICAgICAg
ICAgZ290byBmcmVlX2Fib3J0X2h3cHQ7DQo+PiAgICAgICB9DQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwu
Yw0KPj4gaW5kZXggZTczNjk1ZmY4My4uMzJjY2E3NjcyYSAxMDA2NDQNCj4+IC0tLSBhL2h3L2kz
ODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2Nl
bC5jDQo+PiBAQCAtMTE1LDcgKzExNSw3IEBAIHN0YXRpYyBib29sIHZ0ZF9jcmVhdGVfZnNfaHdw
dChWVERIb3N0SU9NTVVEZXZpY2UNCj4qdnRkX2hpb2QsDQo+Pg0KPj4gICAgICAgcmV0dXJuIGlv
bW11ZmRfYmFja2VuZF9hbGxvY19od3B0KGlkZXYtPmlvbW11ZmQsIGlkZXYtPmRldmlkLCBpZGV2
LQ0KPj5od3B0X2lkLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGZsYWdzLCBJT01NVV9IV1BUX0RBVEFfVlREX1MxLA0KPj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc2l6ZW9mKHZ0ZCksICZ2dGQsIGZzX2h3cHRfaWQsIGVycnApOw0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZW9mKHZ0ZCksICZ2
dGQsIDAsIGZzX2h3cHRfaWQsIGVycnApOw0KPj4gICB9DQo+Pg0KPj4gICBzdGF0aWMgdm9pZCB2
dGRfZGVzdHJveV9vbGRfZnNfaHdwdChWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9oaW9kLA0KPj4g
ZGlmZiAtLWdpdCBhL2h3L3ZmaW8vaW9tbXVmZC5jIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+IGlu
ZGV4IGRjZTRlNGNlNzIuLmU0ZThiMjY2YWIgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2lvbW11
ZmQuYw0KPj4gKysrIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+IEBAIC00NDQsNyArNDQ0LDcgQEAg
c3RhdGljIGJvb2wNCj5pb21tdWZkX2NkZXZfYXV0b2RvbWFpbnNfZ2V0KFZGSU9EZXZpY2UgKnZi
YXNlZGV2LA0KPj4gICAgICAgaWYgKCFpb21tdWZkX2JhY2tlbmRfYWxsb2NfaHdwdChpb21tdWZk
LCB2YmFzZWRldi0+ZGV2aWQsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnRhaW5lci0+aW9hc19pZCwgZmxhZ3MsDQo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIElPTU1VX0hXUFRfREFUQV9OT05FLCAwLCBOVUxMLA0KPj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZod3B0X2lkLCBlcnJwKSkgew0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAsICZod3B0X2lkLCBlcnJwKSkgew0K
Pj4gICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4+ICAgICAgIH0NCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvYmFja2VuZHMvdHJhY2UtZXZlbnRzIGIvYmFja2VuZHMvdHJhY2UtZXZlbnRzDQo+PiBpbmRl
eCA2ODIwYTk5MzllLi44YTIwNGZjYjczIDEwMDY0NA0KPj4gLS0tIGEvYmFja2VuZHMvdHJhY2Ut
ZXZlbnRzDQo+PiArKysgYi9iYWNrZW5kcy90cmFjZS1ldmVudHMNCj4+IEBAIC0xNiw3ICsxNiw3
IEBAIGlvbW11ZmRfYmFja2VuZF9tYXBfZmlsZV9kbWEoaW50IGlvbW11ZmQsIHVpbnQzMl90DQo+
aW9hcywgdWludDY0X3QgaW92YSwgdWludDY0X3QNCj4+ICAgaW9tbXVmZF9iYWNrZW5kX3VubWFw
X2RtYV9ub25fZXhpc3QoaW50IGlvbW11ZmQsIHVpbnQzMl90IGlvYXMsDQo+dWludDY0X3QgaW92
YSwgdWludDY0X3Qgc2l6ZSwgaW50IHJldCkgIiBVbm1hcCBub25leGlzdGVudCBtYXBwaW5nOiBp
b21tdWZkPSVkDQo+aW9hcz0lZCBpb3ZhPTB4JSJQUkl4NjQiIHNpemU9MHglIlBSSXg2NCIgKCVk
KSINCj4+ICAgaW9tbXVmZF9iYWNrZW5kX3VubWFwX2RtYShpbnQgaW9tbXVmZCwgdWludDMyX3Qg
aW9hcywgdWludDY0X3QgaW92YSwNCj51aW50NjRfdCBzaXplLCBpbnQgcmV0KSAiIGlvbW11ZmQ9
JWQgaW9hcz0lZCBpb3ZhPTB4JSJQUkl4NjQiIHNpemU9MHglIlBSSXg2NCINCj4oJWQpIg0KPj4g
ICBpb21tdWZkX2JhY2tlbmRfYWxsb2NfaW9hcyhpbnQgaW9tbXVmZCwgdWludDMyX3QgaW9hcykg
IiBpb21tdWZkPSVkDQo+aW9hcz0lZCINCj4+IC1pb21tdWZkX2JhY2tlbmRfYWxsb2NfaHdwdChp
bnQgaW9tbXVmZCwgdWludDMyX3QgZGV2X2lkLCB1aW50MzJfdCBwdF9pZCwNCj51aW50MzJfdCBm
bGFncywgdWludDMyX3QgaHdwdF90eXBlLCB1aW50MzJfdCBsZW4sIHVpbnQ2NF90IGRhdGFfcHRy
LCB1aW50MzJfdA0KPm91dF9od3B0X2lkLCBpbnQgcmV0KSAiIGlvbW11ZmQ9JWQgZGV2X2lkPSV1
IHB0X2lkPSV1IGZsYWdzPTB4JXgNCj5od3B0X3R5cGU9JXUgbGVuPSV1IGRhdGFfcHRyPTB4JSJQ
Ukl4NjQiIG91dF9od3B0PSV1ICglZCkiDQo+PiAraW9tbXVmZF9iYWNrZW5kX2FsbG9jX2h3cHQo
aW50IGlvbW11ZmQsIHVpbnQzMl90IGRldl9pZCwgdWludDMyX3QgcHRfaWQsDQo+dWludDMyX3Qg
ZmxhZ3MsIHVpbnQzMl90IGh3cHRfdHlwZSwgdWludDMyX3QgbGVuLCB1aW50NjRfdCBkYXRhX3B0
ciwgdWludDMyX3QNCj5mYXVsdF9pZCwgdWludDMyX3Qgb3V0X2h3cHRfaWQsIGludCByZXQpICIg
aW9tbXVmZD0lZCBkZXZfaWQ9JXUgcHRfaWQ9JXUNCj5mbGFncz0weCV4IGh3cHRfdHlwZT0ldSBs
ZW49JXUgZGF0YV9wdHI9MHglIlBSSXg2NCIgZmF1bHRfaWQ9JXUNCj5vdXRfaHdwdD0ldSAoJWQp
Ig0KPj4gICBpb21tdWZkX2JhY2tlbmRfYWxsb2NfZmF1bHRxKGludCBpb21tdWZkLCB1aW50MzJf
dCBmYXVsdF9pZCwgdWludDMyX3QNCj5mYXVsdF9mZCwgaW50IHJldCkgIiBpb21tdWZkPSVkIGZh
dWx0X2lkPSVkIGZhdWx0X2ZkPSVkICglZCkiDQo+PiAgIGlvbW11ZmRfYmFja2VuZF9mcmVlX2lk
KGludCBpb21tdWZkLCB1aW50MzJfdCBpZCwgaW50IHJldCkgIiBpb21tdWZkPSVkDQo+aWQ9JWQg
KCVkKSINCj4+ICAgaW9tbXVmZF9iYWNrZW5kX3NldF9kaXJ0eShpbnQgaW9tbXVmZCwgdWludDMy
X3QgaHdwdF9pZCwgYm9vbCBzdGFydCwgaW50IHJldCkNCj4iIGlvbW11ZmQ9JWQgaHdwdD0ldSBl
bmFibGU9JWQgKCVkKSINCg0K

