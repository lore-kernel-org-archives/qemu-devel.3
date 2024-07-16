Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398ADC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjCc-0003CU-Qq; Tue, 16 Jul 2024 10:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTjCZ-00032t-UA
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:30:47 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTjCU-0000Yu-IR
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721140243; x=1752676243;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZAs39km/JYrDCW2a9ODj+SdCWrhk1XSXqtr1TppwM6A=;
 b=eaZ+RFETjxyoUkVBhvbTb5hZ7o7pHKMaBq+tf4TojzSrb3JMePOwW3IR
 at1xubKR5k8aV3fH3EAxhYqpLM0Y2ui4xkZ+tpmOM/DYjEWhLgqsF6KNB
 fu0apDbdoLcpw5D1TdLWpfu6fYX6EAIxZUbADAmrGZQQNwAQ+mJjCqZK6
 qW+6kvNzlgSi9hazk3ICes/9htMHTav9ZZMYmYvBdF14JWEMV9eyXR+qc
 7Hi5VfHxOr3hN43neR7Xx+7GNgvM3s5Wmy39/5fibEby8tdtjLynwN3tg
 HDA6Oc1XWfMBnTm3+TMJIblxAIJZTX4NryO2mwMPIEh13Zfj2ls2ufrKb A==;
X-CSE-ConnectionGUID: WnznF/eEQ/We/fyfCbbBjQ==
X-CSE-MsgGUID: AOrOq4wLQ9ucyWU5n5f1hw==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="29188658"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="29188658"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 07:30:39 -0700
X-CSE-ConnectionGUID: 7XB3IRukQk6XUltKKCajgQ==
X-CSE-MsgGUID: /jw9kNrySqWhkTdYLeJVnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="54563909"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Jul 2024 07:30:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 07:30:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 07:30:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 07:30:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sq+qSw7B+yMsGjPHVHryHFtWK5ZHtY3saM0Z5zBrkbzqvcIXPwj+5O2GWwWU6Ir7nHp3ZHOptKgU4opf09MHCvByKom80JJg5IYZM80Igz1iIGbCBeo2xFs6XfxWN6Nn8Oi5T9Evf3wu1tmBka1u4JsGh3Gy9Dc2RTg2DdGdzkxKpfuDK7MZfIuhkbGxPrnBUfewySl6ykAia4UtTeMZmn8vPFV+1lp0KsoCKzwa80i9UR2z7oHOcQjPTlCH1Qgezh4hFB6rfNyHnF/Qo8RI+e0P713ihueSu3lxwe73DuFGUoXDX73Rx6698MEKmzjRNYsVbP44PcBZPeJotAWQfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rm7PHiKZ8YggG9kdLtK5db7NrFGvy8gvvfaVnBvRjjg=;
 b=VO172wd2oNkPwUaEVGjLacmC/lL4pDKAiT26EROq6p9UNasRWlCHPqt7TSjxHr/bEMaPnH9S39l8Le2vtSglzbmEWfOoJf/vi48Vep4lSuXdp4RRgmhoXr8yrjlVQNgRjqhd4wkYl24ROarmB4XiIYX7TDKmGoD28esIkv/5atzaF/bUj9RnrnAWMbbqc9W6xYDD2WTj1Zrtic4s88dqS+4Qqb7NstCXORbaMcu7+Tdtj3eJ3TjpChubJQq6YiN6CshZcwFAY1qGbaAhem4gTD/oNdsLkMUqVJPgu/OkFnkRf3vXktaU7JoGmc0Hz4IEGkXzEnO8WzcxIsTiIFvfmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by CY5PR11MB6258.namprd11.prod.outlook.com (2603:10b6:930:25::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 14:30:28 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7784.013; Tue, 16 Jul 2024
 14:30:28 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: "Wang, Yichen" <yichen.wang@bytedance.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Hao Xiang <hao.xiang@linux.dev>, "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, "Wang, Yichen"
 <yichen.wang@bytedance.com>, Bryan Zhang <bryan.zhang@bytedance.com>
Subject: RE: [PATCH v6 4/5] migration: Introduce 'qatzip' compression method
Thread-Topic: [PATCH v6 4/5] migration: Introduce 'qatzip' compression method
Thread-Index: AQHa1wQ2Du9f753q9EmXrFoPXoRr2LH5WQyA
Date: Tue, 16 Jul 2024 14:30:28 +0000
Message-ID: <PH7PR11MB594134811395F624636FC3F7A3A22@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240715221245.12435-1-yichen.wang@bytedance.com>
 <20240715221245.12435-5-yichen.wang@bytedance.com>
In-Reply-To: <20240715221245.12435-5-yichen.wang@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|CY5PR11MB6258:EE_
x-ms-office365-filtering-correlation-id: 22b1dcf6-fdb4-4e1b-3ed9-08dca5a3d6ff
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?SCD0o2Lq8WNbnBC1WYicxoLJCwkOpVA8sPm+VO09adOF5RiXRSzo2tUjJ1?=
 =?iso-8859-1?Q?yrBPjhofU2N5MfTCGw3AfJOgHJRuE0I1bqBw2g3S7mrbFO2sjupe5+VoBM?=
 =?iso-8859-1?Q?seqmz1XYLXDba0uWvPWXMfpYjdBa6PEo2LSwpqg43CgCpX2BjDj/SHxY8n?=
 =?iso-8859-1?Q?ZKVCpRCeojFz3T5WZI9x0dQny7DrXQHjgz0O6g8HzncD7toEzB5o3H15IE?=
 =?iso-8859-1?Q?WmJA0onEtYw/B1cLx7bZlXHGZ8dfGzUvLuvIanmwwhmlvco0blVPLIQ5Sr?=
 =?iso-8859-1?Q?0+JWayy81myDviagOx5irZxujHU6dvMrXOiDFTyeXxG7LNwnGP7WqhW2HQ?=
 =?iso-8859-1?Q?TX4acqyoEdoohO3rbmuiY1PMY03ULIh+eBeb9Mf1lLka7duBTsWZEH7vgM?=
 =?iso-8859-1?Q?2l2baDjSMrxq1Ivl/plwU59chuSViKfWrFpzaHbtOOPfVvAEcSF5sclCgJ?=
 =?iso-8859-1?Q?EPODOh3I7e8UT4CHitb+Xi5/3priNOkNiz12Oy88hR1IWkFokNJikOUHSG?=
 =?iso-8859-1?Q?VtuiacNKaakiNxcPLoBFxXZrFotktyl6Zai8+5LJE7j3vzIkRVuTZ4xJei?=
 =?iso-8859-1?Q?FCw8Jlf4uuh2juO0ce6SOXyRGEZ4bZ27BnwLFjjVQT4m993EF+P7rl5JCL?=
 =?iso-8859-1?Q?b6rJs2tFQHRHEOVlz6veGgvdeAniprHmxNwtdkCCTwrw0pp8CIB4FerBqq?=
 =?iso-8859-1?Q?2JbOR3MaX5YIemXPcFqeS0Lfwxx+mrQt1jqjn87dGV/F+3Pkz4ytMAMsrT?=
 =?iso-8859-1?Q?BQ85aCMfdiF7LUPspFnGr+asBQaUJ9ODrhehe/ccaxL516pB8HkK9r4Ovc?=
 =?iso-8859-1?Q?hedbFpsVnxCd2Dv8HC+UW8W/Mh5ESBwnd2ZeTOHMfmHaJ4w9PNdVKGNHWM?=
 =?iso-8859-1?Q?w/Qj0XvbuOJPUI/7htOuoajH0+TwI3yoio5lJkpRk5QcKeBx77JiBX8t3g?=
 =?iso-8859-1?Q?Srwn9XjYkJoK9Zd8xj/MAv0X2cS8RuoW2hSN5RvLD5AwPFvCFhU+N770FC?=
 =?iso-8859-1?Q?0N3YRYivPDavhkGGng1yWaYKEsE+6L7qsk4WtEly2mJGTk+XcpOgL8auqF?=
 =?iso-8859-1?Q?nvbyDuEMPO5+sGVZBBN1hpTJrIxJUQ/1RzLhqwTN5Tr9H7lcMtilt+vulW?=
 =?iso-8859-1?Q?Qn3oJozoovsmi5cd3SxBX8TmE5p+titZQ7C0Dk5Ay1+DLsht0m6LAjjyTx?=
 =?iso-8859-1?Q?Zc/6fEV1CPb1yERz/emtyrRTMvAfBizEPyVgXIPts9eEWlNGVojU3sEY/C?=
 =?iso-8859-1?Q?QDSYaYyjcbSE8WyUnikWX8rre96fHbDQHqkxRd2Zpiw/+J/oH6w61q+rsb?=
 =?iso-8859-1?Q?o7UzweGlJXQA4G8Q+ZnNIrpAPUI+iBhyFFdO0EN6gwNbzNoZ8g88AtOxGQ?=
 =?iso-8859-1?Q?U+sBn1iC+2/oSIawsb6pyGCt09okVV5ALZpp9tPy/xL8nyxaAKeNx8KxBJ?=
 =?iso-8859-1?Q?1lHU2M95tZsQwF5hrEPk7QiJWcKzvQFm8fHxTxWkGw+P8Y+CDMZdFZ1b5d?=
 =?iso-8859-1?Q?k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Xo2qHTMyd0jMH0N3/dINQWZjDF3avl/UDoyTjmiR6T47qXmM57DMGQDh1q?=
 =?iso-8859-1?Q?OSTerogcAQSUUEh9oaeif/RRCWMhO+X34Y4ErGZ3JXHeAzUXadJzCozr1t?=
 =?iso-8859-1?Q?MXQhtbOnbRpZ4Czf/fzSRCak0X9uQ8TVA+IIITrjMMTYVGxsXH5jCjWGI+?=
 =?iso-8859-1?Q?HA0ncQHs70CHMXw4r6duk1n4JEn+eecVV3i0kxhcMfDPSxF/KcRsfJTh3m?=
 =?iso-8859-1?Q?+k7pG8T5/EZRwbO7f6r883DsEMuRxb786zN3qUJSzH98DrIxKlo76Livqf?=
 =?iso-8859-1?Q?sbuTW9ZVCYAj6EfFAVBnxpb9+hb0/+rAR16AtapZKV8NZ5x757Rbto+Mb/?=
 =?iso-8859-1?Q?n5zcs2/FGvmHKOcpe74v0Dwvq3Xvg97TztfGOjoJ5IcmWToSraBGTdguVH?=
 =?iso-8859-1?Q?nGv8CEFP5yz+gSWYdRuYDVyNJFhm+d3dwNlBhnTOnutdTmCjCXeY34mjjO?=
 =?iso-8859-1?Q?zBlV4jqbNcHNx1IFGl6ggLa/GtJWHoGt2/bDRl7ICpjiMkhmiUv0lWtoOK?=
 =?iso-8859-1?Q?gRDLFyg73mvo8bKzL+b6cKRyH98Us6R2/m9/oDWBe+K7hnQSkrZ11rtT3Z?=
 =?iso-8859-1?Q?GGMNd5r5yYWZ7O5/LBh+V8XnVroQQMVoDREF/FbFuLxMPlaEefvRVbKbgn?=
 =?iso-8859-1?Q?NjRBxpd6TV7wsMXou59mF+p8mssM+0/bk1Rxm4mfl/70c+NsNS8759H4eE?=
 =?iso-8859-1?Q?1keoogruZOtF76pg+l0YKzMeXs67o5FqZiQix+1iCOEvxpNGDa+0yzy/iN?=
 =?iso-8859-1?Q?hiIRiai/2gGGOBfy4dacxVAdeIdzj4+zK1GsrtMInXA6bD0Zfib8Ty7Qa/?=
 =?iso-8859-1?Q?Tq/RwOZiu0ek0OqmxLjTNd5EjtY0Y4Z2qN1FlNgQ5Whm8lOGfXkQWN2Efd?=
 =?iso-8859-1?Q?+LWxb/D7wuCjVdBbKOr3cOdHbBRgEmjFnA02lhh03CJRE5wX15CjkGC/kq?=
 =?iso-8859-1?Q?9I4z77blCoV5yl420ORpL9XoV+F+xuZV3Mh0WLSncyn7KkH3Kw/7vC99ji?=
 =?iso-8859-1?Q?9yplOMpfiQWsxG/Z0zTP5KgkMM7KjvhsGRH/8wFeAbAmIGGcdc11R5qQti?=
 =?iso-8859-1?Q?SfJpZr87ux9cwHjUqpLYewQCXe69oc2Bn81yMDiBoUSh5ImObU2QcWpZwB?=
 =?iso-8859-1?Q?DEh5RR4e1fwaSyiltkM+QdEgZ2+TOLGvrTDXVbPOYiCNrCdJGMHC2uVUP2?=
 =?iso-8859-1?Q?wMhYSH42CpmZ67Pta+Q1kMmgcDprCMPoA0OqEkxYTyuLKUxjW9C1EQycH+?=
 =?iso-8859-1?Q?/nXWuWK6aRdJUufxznkecmDOAnCgfdZ6K+Lmu/0bPW1bpzB6eHbtfhvZPm?=
 =?iso-8859-1?Q?MGphDDMLidVWwKcgpV8JGdCrIRRHN4otY816LrqwYzC1nvWd/eWou6VnOQ?=
 =?iso-8859-1?Q?73L+gEodR5x+G0/pvYPMnArMdp1f8CEc3eYBJs9BdT9WQLSqtIIyiEzNpj?=
 =?iso-8859-1?Q?sIiyIbCC19WbBce2yzIpv4Ymurdb4OeXEXjQX1p1n66VLtsxBV+SjM3W5m?=
 =?iso-8859-1?Q?GSEc5TV+uZEmk6WPje3QPLvE/ASdujp4zYEHEeof3au4kMFUersFjQPd93?=
 =?iso-8859-1?Q?PkaY73SeE8X3E9/31XndZskv0OC6Dbz3U2qNSESjEQ2I9Y7iE1vHl/O3Ts?=
 =?iso-8859-1?Q?+fbn0+om6BcLJ9jb9Ih75RjpBvcdcLmI/a?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b1dcf6-fdb4-4e1b-3ed9-08dca5a3d6ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 14:30:28.4804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rCNfWrEQuQcrQnMkPpbNtY6gncgR5Rpr/2nsCxdBrLYfLf8KU2RyNEDE2v15djjqKJdFlc5Yv/K3b66iw49SCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6258
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> -----Original Message-----
> From: Yichen Wang <yichen.wang@bytedance.com>
> Sent: Tuesday, July 16, 2024 6:13 AM
> To: Peter Xu <peterx@redhat.com>; Fabiano Rosas <farosas@suse.de>; Paolo
> Bonzini <pbonzini@redhat.com>; Daniel P. Berrang=E9 <berrange@redhat.com>=
;
> Eduardo Habkost <eduardo@habkost.net>; Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com>; Thomas Huth <thuth@redhat.com>; Philippe
> Mathieu-Daud=E9 <philmd@linaro.org>; Eric Blake <eblake@redhat.com>; Mark=
us
> Armbruster <armbru@redhat.com>; Laurent Vivier <lvivier@redhat.com>; qemu=
-
> devel@nongnu.org
> Cc: Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1 <yuan1.liu@intel.com>;
> Zou, Nanhai <nanhai.zou@intel.com>; Ho-Ren (Jack) Chuang
> <horenchuang@bytedance.com>; Wang, Yichen <yichen.wang@bytedance.com>;
> Bryan Zhang <bryan.zhang@bytedance.com>
> Subject: [PATCH v6 4/5] migration: Introduce 'qatzip' compression method
>=20
> From: Bryan Zhang <bryan.zhang@bytedance.com>
>=20
> Adds support for 'qatzip' as an option for the multifd compression
> method parameter, and implements using QAT for 'qatzip' compression and
> decompression.
>=20
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> ---
>  hw/core/qdev-properties-system.c |   2 +-
>  migration/meson.build            |   1 +
>  migration/multifd-qatzip.c       | 382 +++++++++++++++++++++++++++++++
>  migration/multifd.h              |   5 +-
>  qapi/migration.json              |   3 +
>  tests/qtest/meson.build          |   4 +
>  6 files changed, 394 insertions(+), 3 deletions(-)
>  create mode 100644 migration/multifd-qatzip.c
>=20
> diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-
> system.c
> index f13350b4fb..a56fbf728d 100644
> --- a/hw/core/qdev-properties-system.c
> +++ b/hw/core/qdev-properties-system.c
> @@ -659,7 +659,7 @@ const PropertyInfo qdev_prop_fdc_drive_type =3D {
>  const PropertyInfo qdev_prop_multifd_compression =3D {
>      .name =3D "MultiFDCompression",
>      .description =3D "multifd_compression values, "
> -                   "none/zlib/zstd/qpl/uadk",
> +                   "none/zlib/zstd/qpl/uadk/qatzip",
>      .enum_table =3D &MultiFDCompression_lookup,
>      .get =3D qdev_propinfo_get_enum,
>      .set =3D qdev_propinfo_set_enum,
> diff --git a/migration/meson.build b/migration/meson.build
> index 5ce2acb41e..c9454c26ae 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -41,6 +41,7 @@ system_ss.add(when: rdma, if_true: files('rdma.c'))
>  system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
>  system_ss.add(when: qpl, if_true: files('multifd-qpl.c'))
>  system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
> +system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
>=20
>  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
>                  if_true: files('ram.c',
> diff --git a/migration/multifd-qatzip.c b/migration/multifd-qatzip.c
> new file mode 100644
> index 0000000000..b74cda503a
> --- /dev/null
> +++ b/migration/multifd-qatzip.c
> @@ -0,0 +1,382 @@
> +/*
> + * Multifd QATzip compression implementation
> + *
> + * Copyright (c) Bytedance
> + *
> + * Authors:
> + *  Bryan Zhang <bryan.zhang@bytedance.com>
> + *  Hao Xiang <hao.xiang@bytedance.com>
> + *  Yichen Wang <yichen.wang@bytedance.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "exec/ramblock.h"
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qapi/qapi-types-migration.h"
> +#include "options.h"
> +#include "multifd.h"
> +#include <qatzip.h>
> +
> +typedef struct {
> +    /*
> +     * Unique session for use with QATzip API
> +     */
> +    QzSession_T sess;
> +
> +    /*
> +     * For compression: Buffer for pages to compress
> +     * For decompression: Buffer for data to decompress
> +     */
> +    uint8_t *in_buf;
> +    uint32_t in_len;
> +
> +    /*
> +     * For compression: Output buffer of compressed data
> +     * For decompression: Output buffer of decompressed data
> +     */
> +    uint8_t *out_buf;
> +    uint32_t out_len;
> +} QatzipData;
> +
> +/**
> + * qatzip_send_setup: Set up QATzip session and private buffers.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     0 on success, -1 on error (and *errp will be set)
> + */
> +static int qatzip_send_setup(MultiFDSendParams *p, Error **errp)
> +{
> +    QatzipData *q;
> +    QzSessionParamsDeflate_T params;
> +    const char *err_msg;
> +    int ret;
> +
> +    q =3D g_new0(QatzipData, 1);
> +    p->compress_data =3D q;
> +    /* We need one extra place for the packet header */
> +    p->iov =3D g_new0(struct iovec, 2);
> +
> +    /*
> +     * Prefer without sw_fallback because of bad performance with
> sw_fallback.
> +     * Warn if sw_fallback needs to be used.
> +     */
> +    ret =3D qzInit(&q->sess, false);
> +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> +        /* Warn, and try with sw_fallback. */
> +        warn_report_once(
> +            "[Sender] Initializing QAT with software fallback...");
> +        ret =3D qzInit(&q->sess, true);
> +        if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> +            err_msg =3D "qzInit failed";
> +            goto err;
> +        }
> +    }

I have some concerns here
1. if the QAT hardware and driver do not exist, the
qzMalloc(q->in_len, 0, PINNED_MEM) will fail, since the PINNED_MEM
can't be allocated. So if using the software path, COMMON_MEM should
be used for qzMalloc.

2. And if the QAT software path is enabled, there will be a lot of log
printing, which is a very bad experience, the error log is below, and it
seems that it cannot be disabled.
Error no hardware, switch to SW if permitted status =3D -6
g_process.qz_init_status =3D QZ_NO_HW

I think when the user chooses qatzip, his environment should support
QAT hardware, so we can always use qzInit(&q->sess, true) and PINNED_MEM
to initialization.

However, we may still need to consider the Qemu CI validation that=20
qatzip + no QAT hardware case. Maybe we can complete the migration without
compression after QAT initialization fails including qzInit and qzMalloc
with PINNED_MEM.

Regarding your concern about performance degradation after fallback to
the software path, qatzip will print relevant logs in standard error,
maybe this is enough to notify the user.=20

Regarding the above concerns, you can uninstall the QAT drivers
(qat_4xxx,usdm_drv,intel_qat) and run "make check", the qatzip will fail.

> +    ret =3D qzGetDefaultsDeflate(&params);
> +    if (ret !=3D QZ_OK) {
> +        err_msg =3D "qzGetDefaultsDeflate failed";
> +        goto err;
> +    }
> +
> +    /* Make sure to use configured QATzip compression level. */
> +    params.common_params.comp_lvl =3D migrate_multifd_qatzip_level();
> +    ret =3D qzSetupSessionDeflate(&q->sess, &params);
> +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> +        err_msg =3D "qzSetupSessionDeflate failed";
> +        goto err;
> +    }
> +
> +    if (MULTIFD_PACKET_SIZE > UINT32_MAX) {
> +        err_msg =3D "packet size too large for QAT";
> +        goto err;
> +    }
> +
> +    q->in_len =3D MULTIFD_PACKET_SIZE;
> +    q->in_buf =3D qzMalloc(q->in_len, 0, PINNED_MEM);

Peter previously asked about the memory size used QAT here, we need
to check the QAT memory footprint and update the doc patch.

We need to let users know that the system needs to reserve some memory
when using qatzip.

> +    if (!q->in_buf) {
> +        err_msg =3D "qzMalloc failed";
> +        goto err;
> +    }
> +
> +    q->out_len =3D qzMaxCompressedLength(MULTIFD_PACKET_SIZE, &q->sess);
> +    q->out_buf =3D qzMalloc(q->out_len, 0, PINNED_MEM);
> +    if (!q->out_buf) {
> +        err_msg =3D "qzMalloc failed";
> +        goto err;
> +    }
> +
> +    return 0;
> +
> +err:
> +    error_setg(errp, "multifd %u: [sender] %s", p->id, err_msg);
> +    return -1;
> +}
> +
> +/**
> + * qatzip_send_cleanup: Tear down QATzip session and release private
> buffers.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     None
> + */
> +static void qatzip_send_cleanup(MultiFDSendParams *p, Error **errp)
> +{
> +    QatzipData *q =3D p->compress_data;
> +

Add NULL pointer check here, when the number of channels is more than 1
And if the first channel's qatzip_send_setup returns an error, the Qemu wil=
l
crash here, since it will be called multiple times according to the number
of channels, but only the first channel invokes qatzip_send_setup.

if (!q) {
    return;
}

> +    if (q->in_buf) {
> +        qzFree(q->in_buf);
> +    }
> +    if (q->out_buf) {
> +        qzFree(q->out_buf);
> +    }
> +    (void)qzTeardownSession(&q->sess);
> +    (void)qzClose(&q->sess);
> +
> +    g_free(p->iov);
> +    p->iov =3D NULL;
> +    g_free(q);
> +    p->compress_data =3D NULL;
> +}
> +
> +/**
> + * qatzip_send_prepare: Compress pages and update IO channel info.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     0 on success, -1 on error (and *errp will be set)
> + */
> +static int qatzip_send_prepare(MultiFDSendParams *p, Error **errp)
> +{
> +    MultiFDPages_t *pages =3D p->pages;
> +    QatzipData *q =3D p->compress_data;
> +    int ret;
> +    unsigned int in_len, out_len;
> +
> +    if (!multifd_send_prepare_common(p)) {
> +        goto out;
> +    }
> +
> +    /*
> +     * Unlike other multifd compression implementations, we use a non-
> streaming
> +     * API and place all the data into one buffer, rather than sending
> each
> +     * page to the compression API at a time. Based on initial
> benchmarks, the
> +     * non-streaming API outperforms the streaming API. Plus, the logic
> in QEMU
> +     * is friendly to using the non-streaming API anyway. If either of
> these
> +     * statements becomes no longer true, we can revisit adding a
> streaming
> +     * implementation.
> +     */
> +    for (int i =3D 0; i < pages->normal_num; i++) {
> +        memcpy(q->in_buf + (i * p->page_size),
> +               pages->block->host + pages->offset[i],
> +               p->page_size);
> +    }
> +
> +    in_len =3D pages->normal_num * p->page_size;
> +    if (in_len > q->in_len) {
> +        error_setg(errp, "multifd %u: unexpectedly large input", p->id);
> +        return -1;
> +    }
> +    out_len =3D q->out_len;
> +
> +    ret =3D qzCompress(&q->sess, q->in_buf, &in_len, q->out_buf, &out_le=
n,
> 1);
> +    if (ret !=3D QZ_OK) {
> +        error_setg(errp, "multifd %u: QATzip returned %d instead of
> QZ_OK",
> +                   p->id, ret);
> +        return -1;
> +    }
> +    if (in_len !=3D pages->normal_num * p->page_size) {
> +        error_setg(errp, "multifd %u: QATzip failed to compress all
> input",
> +                   p->id);
> +        return -1;
> +    }
> +
> +    p->iov[p->iovs_num].iov_base =3D q->out_buf;
> +    p->iov[p->iovs_num].iov_len =3D out_len;
> +    p->iovs_num++;
> +    p->next_packet_size =3D out_len;
> +
> +out:
> +    p->flags |=3D MULTIFD_FLAG_QATZIP;
> +    multifd_send_fill_packet(p);
> +    return 0;
> +}
> +
> +/**
> + * qatzip_recv_setup: Set up QATzip session and allocate private buffers=
.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     0 on success, -1 on error (and *errp will be set)
> + */
> +static int qatzip_recv_setup(MultiFDRecvParams *p, Error **errp)
> +{
> +    QatzipData *q;
> +    QzSessionParamsDeflate_T params;
> +    const char *err_msg;
> +    int ret;
> +
> +    q =3D g_new0(QatzipData, 1);
> +    p->compress_data =3D q;
> +
> +    /*
> +     * Prefer without sw_fallback because of bad performance with
> sw_fallback.
> +     * Warn if sw_fallback needs to be used.
> +     */
> +    ret =3D qzInit(&q->sess, false);
> +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> +        /* Warn, and try with sw_fallback. */
> +        warn_report_once(
> +            "[Receiver] Initializing QAT with software fallback...");
> +        ret =3D qzInit(&q->sess, true);
> +        if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> +            err_msg =3D "qzInit failed";
> +            goto err;
> +        }
> +    }
> +
> +    ret =3D qzGetDefaultsDeflate(&params);
> +    if (ret !=3D QZ_OK) {
> +        err_msg =3D "qzGetDefaultsDeflate failed";
> +        goto err;
> +    }
> +
> +    ret =3D qzSetupSessionDeflate(&q->sess, &params);
> +    if (ret !=3D QZ_OK && ret !=3D QZ_DUPLICATE) {
> +        err_msg =3D "qzSetupSessionDeflate failed";
> +        goto err;
> +    }
> +
> +    /*
> +     * Reserve extra spaces for the incoming packets. Current
> implementation
> +     * doesn't send uncompressed pages in case the compression gets too
> big.
> +     */
> +    q->in_len =3D MULTIFD_PACKET_SIZE * 2;
> +    /*
> +     * PINNED_MEM is an enum from qatzip headers, which means to use
> +     * kzalloc_node() to allocate memory for QAT DMA purposes.
> +     */
> +    q->in_buf =3D qzMalloc(q->in_len, 0, PINNED_MEM);
> +    if (!q->in_buf) {
> +        err_msg =3D "qzMalloc failed";
> +        goto err;
> +    }
> +
> +    q->out_len =3D MULTIFD_PACKET_SIZE;
> +    q->out_buf =3D qzMalloc(q->out_len, 0, PINNED_MEM);
> +    if (!q->out_buf) {
> +        err_msg =3D "qzMalloc failed";
> +        goto err;
> +    }
> +
> +    return 0;
> +
> +err:
> +    error_setg(errp, "multifd %u: [receiver] %s", p->id, err_msg);
> +    return -1;
> +}
> +
> +/**
> + * qatzip_recv_cleanup: Tear down QATzip session and release private
> buffers.
> + *
> + * @param p    Multifd channel params
> + * @return     None
> + */
> +static void qatzip_recv_cleanup(MultiFDRecvParams *p)
> +{
> +    QatzipData *q =3D p->compress_data;

ditto

> +    if (q->in_buf) {
> +        qzFree(q->in_buf);
> +    }
> +    if (q->out_buf) {
> +        qzFree(q->out_buf);
> +    }
> +    (void)qzTeardownSession(&q->sess);
> +    (void)qzClose(&q->sess);
> +    g_free(q);
> +    p->compress_data =3D NULL;
> +}
> +
> +
> +/**
> + * qatzip_recv: Decompress pages and copy them to the appropriate
> + * locations.
> + *
> + * @param p    Multifd channel params
> + * @param errp Pointer to error, which will be set in case of error
> + * @return     0 on success, -1 on error (and *errp will be set)
> + */
> +static int qatzip_recv(MultiFDRecvParams *p, Error **errp)
> +{
> +    QatzipData *q =3D p->compress_data;
> +    int ret;
> +    unsigned int in_len, out_len;
> +    uint32_t in_size =3D p->next_packet_size;
> +    uint32_t expected_size =3D p->normal_num * p->page_size;
> +    uint32_t flags =3D p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
> +
> +    if (in_size > q->in_len) {
> +        error_setg(errp, "multifd %u: received unexpectedly large
> packet",
> +                   p->id);
> +        return -1;
> +    }
> +
> +    if (flags !=3D MULTIFD_FLAG_QATZIP) {
> +        error_setg(errp, "multifd %u: flags received %x flags
> expected %x",
> +                   p->id, flags, MULTIFD_FLAG_QATZIP);
> +        return -1;
> +    }
> +
> +    multifd_recv_zero_page_process(p);
> +    if (!p->normal_num) {
> +        assert(in_size =3D=3D 0);
> +        return 0;
> +    }
> +
> +    ret =3D qio_channel_read_all(p->c, (void *)q->in_buf, in_size, errp)=
;
> +    if (ret !=3D 0) {
> +        return ret;
> +    }
> +
> +    in_len =3D in_size;
> +    out_len =3D q->out_len;
> +    ret =3D qzDecompress(&q->sess, q->in_buf, &in_len, q->out_buf,
> &out_len);
> +    if (ret !=3D QZ_OK) {
> +        error_setg(errp, "multifd %u: qzDecompress failed", p->id);
> +        return -1;
> +    }
> +    if (out_len !=3D expected_size) {
> +        error_setg(errp, "multifd %u: packet size received %u size
> expected %u",
> +                   p->id, out_len, expected_size);
> +        return -1;
> +    }
> +
> +    /* Copy each page to its appropriate location. */
> +    for (int i =3D 0; i < p->normal_num; i++) {
> +        memcpy(p->host + p->normal[i],
> +               q->out_buf + p->page_size * i,
> +               p->page_size);
> +    }
> +    return 0;
> +}
> +
> +static MultiFDMethods multifd_qatzip_ops =3D {
> +    .send_setup =3D qatzip_send_setup,
> +    .send_cleanup =3D qatzip_send_cleanup,
> +    .send_prepare =3D qatzip_send_prepare,
> +    .recv_setup =3D qatzip_recv_setup,
> +    .recv_cleanup =3D qatzip_recv_cleanup,
> +    .recv =3D qatzip_recv
> +};
> +
> +static void multifd_qatzip_register(void)
> +{
> +    multifd_register_ops(MULTIFD_COMPRESSION_QATZIP,
> &multifd_qatzip_ops);
> +}
> +
> +migration_init(multifd_qatzip_register);
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 0ecd6f47d7..adceb65050 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -34,14 +34,15 @@ MultiFDRecvData *multifd_get_recv_data(void);
>  /* Multifd Compression flags */
>  #define MULTIFD_FLAG_SYNC (1 << 0)
>=20
> -/* We reserve 4 bits for compression methods */
> -#define MULTIFD_FLAG_COMPRESSION_MASK (0xf << 1)
> +/* We reserve 5 bits for compression methods */
> +#define MULTIFD_FLAG_COMPRESSION_MASK (0x1f << 1)
>  /* we need to be compatible. Before compression value was 0 */
>  #define MULTIFD_FLAG_NOCOMP (0 << 1)
>  #define MULTIFD_FLAG_ZLIB (1 << 1)
>  #define MULTIFD_FLAG_ZSTD (2 << 1)
>  #define MULTIFD_FLAG_QPL (4 << 1)
>  #define MULTIFD_FLAG_UADK (8 << 1)
> +#define MULTIFD_FLAG_QATZIP (16 << 1)
>=20
>  /* This value needs to be a multiple of qemu_target_page_size() */
>  #define MULTIFD_PACKET_SIZE (512 * 1024)
> diff --git a/qapi/migration.json b/qapi/migration.json
> index cd08f2f710..42b5363449 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -558,6 +558,8 @@
>  #
>  # @zstd: use zstd compression method.
>  #
> +# @qatzip: use qatzip compression method. (Since 9.1)
> +#
>  # @qpl: use qpl compression method.  Query Processing Library(qpl) is
>  #       based on the deflate compression algorithm and use the Intel
>  #       In-Memory Analytics Accelerator(IAA) accelerated compression
> @@ -570,6 +572,7 @@
>  { 'enum': 'MultiFDCompression',
>    'data': [ 'none', 'zlib',
>              { 'name': 'zstd', 'if': 'CONFIG_ZSTD' },
> +            { 'name': 'qatzip', 'if': 'CONFIG_QATZIP'},
>              { 'name': 'qpl', 'if': 'CONFIG_QPL' },
>              { 'name': 'uadk', 'if': 'CONFIG_UADK' } ] }
>=20
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 6508bfb1a2..3068d73e08 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -327,6 +327,10 @@ if gnutls.found()
>    endif
>  endif
>=20
> +if qatzip.found()
> +  migration_files +=3D [qatzip]
> +endif
> +

I think this part can be removed, it seems no need for qatzip dependency
in migration tests

>  qtests =3D {
>    'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c']=
,
>    'cdrom-test': files('boot-sector.c'),
> --
> Yichen Wang


