Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DFDCA101F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 02:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxGKC-0004Yp-Ev; Fri, 12 Sep 2025 22:49:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uxGKA-0004YK-9L
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 22:49:14 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uxGK5-0006BG-7k
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 22:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757731749; x=1789267749;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=H6NvxqZ4ooq694eyPT7DfGfVXuhdcwIjFxbN2300THM=;
 b=G0f1I6PuPZZpe3K05N6WYCrWHxmkT0+dkgUKXDw7+nmleG9bUaieqFNx
 zMPPyqfVqYRbb4Yu41TDidiOeil9SbZojXhrqzsfRAD1a89vAXBasW+7H
 qFcvY7as6BYR4pGtSh8+e+ahPD58gR7Y2cA4Icjd7Q2tre1LCx4O+TmF/
 buAHDxxiJ6lye8pyTrMjDAdJN5WGVNVXepUkVZA2samYuNQMrbPi/hNd4
 wJl4Wy05GZfuPFjLLpvc7X2UVyNR9fi+Ojf4WyTJNQB71BpnUvWcM5NIA
 o7pSozMpdviN78NOIGV6ErVl27KgpeHsq9t6l2hhJdR0oRsFPDNQ2eEV0 w==;
X-CSE-ConnectionGUID: ALtqQY4XQTCuOv+aafuQgQ==
X-CSE-MsgGUID: f72THaiUTi2UGAi51tFF6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="60184199"
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; d="scan'208";a="60184199"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 19:49:00 -0700
X-CSE-ConnectionGUID: QifkPN1XTraq1CucPHkdKA==
X-CSE-MsgGUID: w83QqdkVQwCzmf8M6JWDQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,260,1751266800"; d="scan'208";a="179308099"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Sep 2025 19:49:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 19:48:59 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 12 Sep 2025 19:48:59 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.81) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 12 Sep 2025 19:48:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfiW+gnWx/IY4V+VVfKDtYyppb6pfRmjCSQ2hJECLJ9gPQ8AHEbB7VixqbT7hhvdzFmBShFo5OQQrHP/tgsoh3W/4sj63taABNJ8uYNiYOknJlnk3D3wFCXAdOd2V0reea0wX1nPhKqZcGaZCqr6T56kRcGU3huucK8MWd1EYar/tbc+lA3NJ7Cw8W2CmBmE93HXZL9eStscjrVFxv1rGdqHjjtOGCGeaDMxVbpv/kgB4vGb3b6b3EWVt7+dUwSXWD98WYFavQ3nB7DyUPVj6tlft7d3vbe53CVY8356aOX7CwzKYZurPSIa1IalOtkDc7CmYj7POTnYld4R+n9jgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJea/dLdgecPOuPja+IuQqkEZVUcqNaIAfLABVxA19U=;
 b=HjM7REDksIGCySXtEtLKjnrGGKOoj+mJDcmKZqF0Fb7Adkz+QaFOcvxe12G6Ua4wjKH/iF5HJ7NdqSPNbYwUh8C1zKj1dYS3LiHu2h3fjKQYzIVag9Qu8ff/M2991BhsslM40rYiyt7eiT4ZUuilkS+ne4ODwBqMjJv+VxT5kmygMfCDu18yV77ggVqN6OkDShRThv1tbrQGovxAZqthZRtBrOC+iL6pDQtVZOkBh/EAgm/IIsdjG/BFSe2KloeT/KXoTtrilfTId5UEAfzzKFdhdo2VpDIZjNIsHUtL3c27HOp4gDHDuIbYl4+FmHsWRwXYL2vaYh/wrvLURAIAkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by MN2PR11MB4567.namprd11.prod.outlook.com (2603:10b6:208:26d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Sat, 13 Sep
 2025 02:48:52 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9094.021; Sat, 13 Sep 2025
 02:48:52 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: RE: [RFC 4/6] virtio-gpu: Don't rely on res->blob to identify blob
 resources
Thread-Topic: [RFC 4/6] virtio-gpu: Don't rely on res->blob to identify blob
 resources
Thread-Index: AQHcHJY2YKFPoBQc1k6SDELAvZKU07SFiqKAgAqO7zA=
Date: Sat, 13 Sep 2025 02:48:52 +0000
Message-ID: <IA0PR11MB7185758D6CD5D2774E6373BBF80BA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
 <20250903054438.1179384-5-vivek.kasireddy@intel.com>
 <26c02124-eb57-4d50-bf8d-1fa809984adc@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <26c02124-eb57-4d50-bf8d-1fa809984adc@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|MN2PR11MB4567:EE_
x-ms-office365-filtering-correlation-id: e76bb9bb-c506-4ca4-b480-08ddf270132e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Isvij4aDhNHUJspdmyNqRnrP1WdXmipsmQokWgU+R2dcXbP1ZnSXCh+/p7?=
 =?iso-8859-1?Q?BorsUj8ypCYW5AAVAFBL/6h2G4KlaHZeTMqhTfIHglMrGDUphAnBhWO6Hh?=
 =?iso-8859-1?Q?hrrq8SuboXhu1AF3iEUnGOPWi0BZ9HfZTRArt1sJhFLH6qOVkTYTVKq5P9?=
 =?iso-8859-1?Q?vF+kuGI2U4yMQohQfxQvEmG1U0eRFrbZIfgBuAcvcZswh4fg0bK6+VwwN9?=
 =?iso-8859-1?Q?PqgMavg2PEUJyPc/ZO3p1nWqB3Nfl3gqE0H2soN56oOt4F5Vo3UOf4O7Vz?=
 =?iso-8859-1?Q?94eq/XeSL5PU9DjGEfhfX8FbUIN8HdIR/NqZoFrLg3qh0tG5XSBrelQ7yD?=
 =?iso-8859-1?Q?brc0HAq5Lku13C8SCplUi11cHqG0/ehQ0O9kXJY+Z7jvqoDOfdTn/5ICGA?=
 =?iso-8859-1?Q?27q0/kZ7gKRndCTaCvkDMjc4bvO6ufRnZwHictoeZzjLkx7kQIDlePdxz1?=
 =?iso-8859-1?Q?W+z53DNur8Dh0B1FkUbBl+cX/521qSTGX3BAmImZZe95s22t0g4EFHDbBV?=
 =?iso-8859-1?Q?lS+aR9xQwdfsO6L0B5FUKy2R19OeCHOOkUKhDO+IaakDdK8VkPwjlCLutW?=
 =?iso-8859-1?Q?D9bGWullDvF+wmqg907CRAwqc3uyp3XB2LMAB9JhEMoWQMc9DR0/+89YIb?=
 =?iso-8859-1?Q?aQgffzKa4vt5FjpNcqg/YvdYF9ck8csxPWjADcvmBuIScg5NSFBz9VdPzF?=
 =?iso-8859-1?Q?o7+mjiAVpOFpiGaaNSR1G1x9j8QJwsWUO/lM46yHgw29UhlCyVM2nYGBsp?=
 =?iso-8859-1?Q?8IdpS4TNOOuHbH4Acm3JjaFuXBj0DCgSqjKQLiEPuqYt4TODjc4G6GphAV?=
 =?iso-8859-1?Q?rZRVxfwXt5nJMM86zPpESSFHRMtvEATD1fNwRAspLiqADSBwIJphaEqn8p?=
 =?iso-8859-1?Q?UiNv6R2HwmOzg37PzIkcqVj8JwFS7HeckYPAnr2m5pN8wqVGreANbofQop?=
 =?iso-8859-1?Q?tB22coYttHoSHGp7oebGE/eVO70+jNeQ1PkouWdwpucnpj0V5lda4vriRJ?=
 =?iso-8859-1?Q?AoQT9H1y35JwYX7btJ1sBzLFWyb5r9Dz+cfsu7+P0oXNCRfEHRaW4VEJGi?=
 =?iso-8859-1?Q?khOQmjz8rYyeA0RifZspgaxoypJitngE3A/KQqaAU3vr8vOt+SV3QnD65t?=
 =?iso-8859-1?Q?theZivczON+YZdf6WftXsy/2wj9U9AejPrubzPfikNZ9+oFFV5hXEz9Ojs?=
 =?iso-8859-1?Q?nnc7ScQ1n8HC/okSipfym3NYGoU563DjEhi+iRTrNYDC9Yb19L1wxiDbp9?=
 =?iso-8859-1?Q?b69pmSebebZYS9wSSpQrl3EstIK6MC4P5I6/Sq1ht6sf5NRZ73xOOMwYAn?=
 =?iso-8859-1?Q?0hla9cGWbZTP8c0dQFF8ncJl3xFeavSqu42euEcmkdioe28CpVhAoJ8QFc?=
 =?iso-8859-1?Q?iEbqlaRQgxFliGqqMJmgV0e7QDUdXXnPke0AAAV7XlEnq9ZlYXOyUhzTQ5?=
 =?iso-8859-1?Q?gOp+RddSI4q+v97lEoAaJvHDgbY6L3ny5aDq/Mw1DUdYFReYD8VZbXmaTV?=
 =?iso-8859-1?Q?p76zqjjIHa2bEkFS6TG42LXMqKllQdV2thKETT0HGf1LwT38+B7+acXxvh?=
 =?iso-8859-1?Q?MjexdZc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2d/dAbEmPxcvBtUhdhWTiCHelIkhD7F/xMvsddKO3SKY4m7Pj9t+i3+sYu?=
 =?iso-8859-1?Q?jwtpQTiGhOv+IzijEdHIoswil27rhZK52ad1oAvLtXxyWmgRdeD3bDw+Ro?=
 =?iso-8859-1?Q?9WTwkLVUcveCjUKXWQOPjFjmQ1DRc01dOErAzOL6ASIig84PoiiLPZnetY?=
 =?iso-8859-1?Q?yIdy/hRyLRASR8Ewk9Ru03onKVQwM72DW720pSKkJ/XunR7gXs3b/RriO5?=
 =?iso-8859-1?Q?GL3618RDAC3Aon0s7J8T6Qa21kEX4aeDSySvvObnTtnVZ4ArCeNitTdrq+?=
 =?iso-8859-1?Q?vAina77ro0nZJTMt8Bgoea5QKEZk4ooWib2IZBnxggDWn447FSbBBuoipJ?=
 =?iso-8859-1?Q?pqaGe7/ZuOeIE2LlixkkmVy33+L85608RJoPNLI6f/eyWSNn/iGloh42Lg?=
 =?iso-8859-1?Q?JHWRurAmzE4ii6fjZzpaCrCKJAwIFsCK0igUB+xQx0opDcSS9IcugpCf29?=
 =?iso-8859-1?Q?Fjmwyol8gb5Hkwl4I8rsT2u4/YyjrrjtO2kQ2cZHvI6J5kKpxip/BTI8ix?=
 =?iso-8859-1?Q?cHjE7B6wqBWDF+ZOMtY4GQd/GCOb9p0jbLiR9yyVG9tv3lm5yO+9X05MFs?=
 =?iso-8859-1?Q?++bSxnygB/78Cue9TLFbP8IUBMI/UeSG1UR6hZMFGBi7vF93UYAEtRObP/?=
 =?iso-8859-1?Q?FzZObdDHjcHMYKq/+u2VLgzTur8rYu23WTZzxOya4VQh4rmR3TGzjTWJyU?=
 =?iso-8859-1?Q?ErrJ/44NlMWxj/9933E0F0MgPzqlyj3Va3H6ZvlXnoQB3Z35YZLPklpTer?=
 =?iso-8859-1?Q?iVJ4vXTIYS+SNS325EWeFV9FTQ+7ncRgJCU2uYAwwZFe3C31r9ZAgKP1v0?=
 =?iso-8859-1?Q?LcINEd3/MwZTzuQkXIDQqsFm2YtfA9EbyIBiAOyeSpXpqAcXryM6zwbjY1?=
 =?iso-8859-1?Q?2qjjp4PRjP4/1JfAtzKtXbb4GQTYfRDEV1dTVB/R7bOP2JYlFMOnfMNhpg?=
 =?iso-8859-1?Q?asl2tMcJMDBXvTEObXo2qHuKvg1+YfnRtLdp1WCMnFACLOhtoeUu/hL6Zl?=
 =?iso-8859-1?Q?TCqKwP47u8Xp3h3ExwEOEPQqaihMc4/VKDMGmV9JXeFCrurR1SfquREPDB?=
 =?iso-8859-1?Q?ASjlbtwEVkxWWfLNE2H7CwcXknpqvWMKKtHVyCLtRHau6ZTfB75e1lx/WV?=
 =?iso-8859-1?Q?7qTXX+/oblwVkG5w/VY4Fej+vcemcNNTLufd7vb9Q7tlLA4l92aZbi/vPh?=
 =?iso-8859-1?Q?MKIWZ1hNayawxIT5XMvHqmsAeZra929Y5sSftEE+9MjFvLT/SSCSYj+l4x?=
 =?iso-8859-1?Q?9N3XI+BaVOrQ1Mbza7Y1YxipNM8Wrfpqbkll0zFMuEplZ4/QNu4M/raq6e?=
 =?iso-8859-1?Q?my6a7uEId98+sVtU1HQCx7O1CrQiJgbT1KtQ1rS6DidrpwsikgfFq9VCvC?=
 =?iso-8859-1?Q?hL41Yejw/gvVg35NmekrozbN66f1b1WtfqU75/Y6gv8OnvF4snMyiLM7nX?=
 =?iso-8859-1?Q?YGz+rfsCKsNT13TkVMuVThsEZuIiXSiFE2tulbD81LABPu/JyBtXs6BJB+?=
 =?iso-8859-1?Q?l/cYTPHHMIjnKibGww4WkathyyQJBlmplLjiJiKMm9VcorB19zFx5C7Y+f?=
 =?iso-8859-1?Q?XZfh7V0jRSXDsEInw0NFvuzJmiuMoe0GNma6RV/8LLEMWnSHbhmUPVlaEW?=
 =?iso-8859-1?Q?An83lUbzRAiDa83ZZJM6rAmMPyFPehb3F6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76bb9bb-c506-4ca4-b480-08ddf270132e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2025 02:48:52.8492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rCqtefRvxUvYCyfKV5PRRNdb/96NTa1BSrrrsRlZV2BqboxpYW9GDInjfnxF4XFgsIDGIeWx2ARL+4WgKnXGlHyuuhGNxgLwGH5RMFLr19w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4567
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Akihiko,

> Subject: Re: [RFC 4/6] virtio-gpu: Don't rely on res->blob to identify bl=
ob
> resources
>=20
> On 2025/09/03 7:42, Vivek Kasireddy wrote:
> > The res->blob pointer is only valid for blobs that have their
> > backing storage in memfd. Therefore, we cannot use it to determine
> > if a resource is a blob or not. Instead, we could use res->blob_size
> > to make this determination as it is non-zero for blob resources
> > regardless of where their backing storage is located.
>=20
> I guess this change needs to be applied before "[RFC 3/6]
> virtio-gpu-udmabuf: Create dmabuf for blobs associated with VFIO
> devices"; without this patch, the "create dmabuf" patch will probably
> create an invalid blob.
Ok, makes sense. I'll move it earlier in the patch series.

>=20
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu.c | 19 +++++++++++--------
> >   1 file changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 0a1a625b0e..2f9133c3b6 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -57,7 +57,7 @@ void virtio_gpu_update_cursor_data(VirtIOGPU *g,
> >       }
> >
> >       if (res->blob_size) {
> > -        if (res->blob_size < (s->current_cursor->width *
> > +        if (!res->blob || res->blob_size < (s->current_cursor->width *
>=20
> I doubt that rejecting a valid blob due to an implementation concern
> (whether the backing storage is in memfd) is tolerated in the specificati=
on.
Are you suggesting that the whole if (res->blob_size < (s->current_cursor->=
width *...
check needs to be removed? I think it is just a sanity check to ensure that=
 the blob
size is big enough for cursor.

Thanks,
Vivek

>=20
> >                                 s->current_cursor->height * 4)) {
> >               return;
> >           }
> > @@ -144,7 +144,7 @@ virtio_gpu_find_check_resource(VirtIOGPU *g,
> uint32_t resource_id,
> >       }
> >
> >       if (require_backing) {
> > -        if (!res->iov || (!res->image && !res->blob)) {
> > +        if (!res->iov || (!res->image && !res->blob_size)) {
> >               qemu_log_mask(LOG_GUEST_ERROR, "%s: no backing storage
> %d\n",
> >                             caller, resource_id);
> >               if (error) {
> > @@ -444,7 +444,7 @@ static void
> virtio_gpu_transfer_to_host_2d(VirtIOGPU *g,
> >
> >       res =3D virtio_gpu_find_check_resource(g, t2d.resource_id, true,
> >                                            __func__, &cmd->error);
> > -    if (!res || res->blob) {
> > +    if (!res || res->blob_size) {
> >           return;
> >       }
> >
> > @@ -507,7 +507,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
> >           return;
> >       }
> >
> > -    if (res->blob) {
> > +    if (res->blob_size) {
> >           for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
> >               scanout =3D &g->parent_obj.scanout[i];
> >               if (scanout->resource_id =3D=3D res->resource_id &&
> > @@ -538,7 +538,7 @@ static void virtio_gpu_resource_flush(VirtIOGPU *g,
> >           }
> >       }
> >
> > -    if (!res->blob &&
> > +    if (!res->blob_size &&
> >           (rf.r.x > res->width ||
> >           rf.r.y > res->height ||
> >           rf.r.width > res->width ||
> > @@ -634,7 +634,7 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU
> *g,
> >
> >       g->parent_obj.enable =3D 1;
> >
> > -    if (res->blob) {
> > +    if (res->blob_size) {
> >           if (console_has_gl(scanout->con)) {
> >               if (!virtio_gpu_update_dmabuf(g, scanout_id, res, fb, r))=
 {
> >                   virtio_gpu_update_scanout(g, scanout_id, res, fb, r);
> > @@ -645,13 +645,16 @@ static bool
> virtio_gpu_do_set_scanout(VirtIOGPU *g,
> >               return true;
> >           }
> >
> > +        if (!res->blob) {
> > +            return false;
> > +        }
> >           data =3D res->blob;
> >       } else {
> >           data =3D (uint8_t *)pixman_image_get_data(res->image);
> >       }
> >
> >       /* create a surface for this scanout */
> > -    if ((res->blob && !console_has_gl(scanout->con)) ||
> > +    if ((res->blob_size && !console_has_gl(scanout->con)) ||
> >           !scanout->ds ||
> >           surface_data(scanout->ds) !=3D data + fb->offset ||
> >           scanout->width !=3D r->width ||
> > @@ -899,7 +902,7 @@ void virtio_gpu_cleanup_mapping(VirtIOGPU *g,
> >       g_free(res->addrs);
> >       res->addrs =3D NULL;
> >
> > -    if (res->blob) {
> > +    if (res->blob_size) {
> >           virtio_gpu_fini_udmabuf(res);
> >       }
> >   }


