Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE3DCCD19A
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 05:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLEER-00028T-P7; Tue, 18 Nov 2025 00:26:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vLEEO-00028D-9T
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 00:26:20 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vLEEK-0005Yf-Qh
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 00:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763443577; x=1794979577;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bIfjtwdDA3qdUny7Gyy7qg188Zp7QWGxrqONJY1cVpY=;
 b=LB09SsDx7Q+CBeae3FU8FYlnwITmaEH3UAKIJIoeluy+IrxvEHvdy0cq
 1DleHFa4AsZMCGUJAtl+nYVO/Mm/FFSOFE9d7Lnz0i7uKri7ejGrtQ+PA
 ASpDMVCY724+DZB9X/KQMFe2pufMo4iRNHHrounFtAjRRgmdIHhyVmZf6
 k6R6tAgJr0NfgETf63Mmly2LcBQcPjcPB+CRBUFUJ2+QMYC1UWdh0afLy
 qSJclj6l1/t69MNE2sK3Vw0KU5AAKw11iK/qrlhlzo2F006u150tlseqJ
 Tn4mPiLHMEiugUbkhX120qe7yThxIK8nKy9WtBJXpn63ne9b3QBMpErUM A==;
X-CSE-ConnectionGUID: BANQN/S1RHyHKux1iplZxA==
X-CSE-MsgGUID: 4x63O7t0S76YmEMrGGfHHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65547914"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="65547914"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 21:26:09 -0800
X-CSE-ConnectionGUID: 032dCIYQRC+5Ije9utBq+w==
X-CSE-MsgGUID: fxsWmm03SCK3kEyj0o0a8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="190322288"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 21:26:09 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 21:26:08 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 17 Nov 2025 21:26:08 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.56) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 17 Nov 2025 21:26:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKzErKKVDbBr7dGbiYtt3undO/OjxpqIwnaG4J7CmTyG6ykxVsrXfuOeYyk7xe/K5UqaVg/MG92+xvtNJMGycInqHhVCDa2YsEaEsZZPL409XrVw0NphcU4LsRO4BWC/qI+3us5Y2i4PXyMO3XIZstoxxsHiXMlbDg3IkGwaNPbTlyQLlcgHWkXQ+jYd8IjeLPLZ/HdQ7pTsipANN52LeHorC9DjLLXx+q1YFJZW0tayFKYer39znufBU4l+Nq9BVHxryOrRSdLzSJjDHhK8K+nq13ci267ZnnyoKbBFY4OlIn2DCJN3X1Et+a+l5U5ccJt/EVLB3NkmPqAo/wt1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDRfCeQk1S+0YTJBiceVLHiwZ4/R41tIZrh/lQlgjWc=;
 b=Im4NsJSHf5Dj80EcXUtb60v3RUJDyoVbvkSzs8975KnXwADjTgpg2aLDRkbf/LWvC8QwV/MhQg8RKeakRi7bYkSS8svV5cK/3nC/sHEbRaPq89rfNs9YPi6dsCLlcTTIncbrxQjzmcfmnAShP/tqkG14h94XSCeMKQ2eA4l0Q9iRcwtHojvqUN29OckmC6BuPU9tIsX2GRlim8ahY/dCitUQWmF0bPGJoNi29TlOQ2xIXlJj/I02Nlifjjd7YSnYTOup41knngFahc3C0VpXzsR3B9xQWtCorWRgokcV4Qa1urRZi3WrTKQ73ZFJpnJTv817v/npAasVzJmu21iP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by CYXPR11MB8709.namprd11.prod.outlook.com (2603:10b6:930:dd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 05:26:00 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 05:26:00 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: RE: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
Thread-Topic: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
Thread-Index: AQHcUTsfaCBAQNqK6UqI5jTHJ6PIg7Ts6XoAgAE6QFCAAJJ2gIAA3p9AgABvJgCAAROboIAFZI8AgAEGRKA=
Date: Tue, 18 Nov 2025 05:26:00 +0000
Message-ID: <IA0PR11MB71852665F80155422F4714E2F8D6A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-3-vivek.kasireddy@intel.com>
 <ea2e1bd7-d681-4929-b902-1948b854e488@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185866AD30B9A73097934CCF8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <8b8e3b19-7696-4b7c-8d74-eab2028dcd02@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71857687EC63A9A8D46476C7F8CDA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <e9424a92-f612-4cce-abc1-5336949ca71b@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71852A2F1894A75CE0B7EB13F8C9A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <a5b4e817-93b2-45c3-8c59-21a4b65174b4@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <a5b4e817-93b2-45c3-8c59-21a4b65174b4@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|CYXPR11MB8709:EE_
x-ms-office365-filtering-correlation-id: b27ba9d9-799b-4e84-05b8-08de2662f58d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?IDPhYHsE1gB+yJPjkMFTLJLbwVxLTMhGrTSLKLNKfOY1mozxEN15uFd16Z?=
 =?iso-8859-1?Q?4b9VWQXAcqTs2qk0cvx52nCFgRSzqslofyDgCENEFMmhP65Pie60I3mKer?=
 =?iso-8859-1?Q?0K5VryQkQmMbGvCJiFjl4qYKrhUyhqaZZ0hQi5Ca9fnsjmBwNmpUpgxnp4?=
 =?iso-8859-1?Q?pOZaOu6owByqCHNjO8OuKv3jxWR+SYegIusXbHiNO8vvtJ7YpRj00TVhPv?=
 =?iso-8859-1?Q?qZAMYfDHyMIQKw+PdpiUt7B+0jlMIc8/oHuiSfk4jFl9/3xm7kBD2NEoWM?=
 =?iso-8859-1?Q?tl3vEsPHvCtW1U96ZsMV6thtkw4YgTjvGvnpf2h5GHP8TqaLtBasStvN7V?=
 =?iso-8859-1?Q?YmgXVsMAWouAr4uAO4HurNfnqUvbAL7YX/agP33EZpXUTmLmcStxBe2ypU?=
 =?iso-8859-1?Q?T7wzkI2a/lsuB1e/6yE2PmE3kwEIpPUIIA01s3OQJGv7TjtMYDzjIM8ZWO?=
 =?iso-8859-1?Q?bpHuagwxMsEyN1WA33KRbS2znV1oYbf9suXQuHgQN14ZS+dpcolmjF960y?=
 =?iso-8859-1?Q?vaPhHuz7NY7PCg/zYfvPa9NmAP9Hlu6lkTNc3K8qqJBKMuuru4FnRV8VWU?=
 =?iso-8859-1?Q?06klYM13AG4JVpQhedgfJp0h/CsQfv2cVEg7j9QDeQ/SQICqXpMOgiSjNZ?=
 =?iso-8859-1?Q?NzNSCQrfv6plYVZ0E0mD6G7D242Iv2P5m3M5ABZCjhYhariL6ju35ChUKC?=
 =?iso-8859-1?Q?UMnnkF/c8cMDJqNR8lGhlPaibwacHy+xFrG+/F4OBmVEq1tkpUchodOUdX?=
 =?iso-8859-1?Q?EUB1lB8ZIrcaacIR0HPkjNG08NzF8y2fkOdkmC8ESlXiIy4skRB9iD5yOp?=
 =?iso-8859-1?Q?rn7s+2EO/xlhRmxoWPPNYK93URn2p8l4Zka3DFVUys6ViDdNJ4arbiYOPW?=
 =?iso-8859-1?Q?71OgqHLA8GexOtn2PqIpY4gLQg3bHnId/XcrIszqeKnetlmwbqVCEBYPAm?=
 =?iso-8859-1?Q?eYJO/IWNscglBTRc5wt52GZYZZSqhpzk465JUUjSqyKthvuwsl1fiXyZRR?=
 =?iso-8859-1?Q?/6+Uk+9FBWzwdd2yCcBjEIM8xkX/kmOD0JrOYaYdcmE1GCOfscY6uyPiD6?=
 =?iso-8859-1?Q?UnwEAq1vhpCvfWTAX9Jt0CBlIQrWFC5Gc1ltC43WsRRXjLBCM9jflCqFsn?=
 =?iso-8859-1?Q?s1eDUGcq7cP5e2144oX8nzr1OMAXtRrWGoPchxnjR9RrRYa9GICHHk5pQO?=
 =?iso-8859-1?Q?5CakRtbNFLpu2awwuHq6uehu8oNoUq5d0WHGxiQ4PTUEUsOBn9m0fP6lXw?=
 =?iso-8859-1?Q?P/nyZnPUhUmUavJUXp/Pf4LRgMe5SMQDPvo5gRcYrjuu9lNrp3pdU1RFvk?=
 =?iso-8859-1?Q?W+l7Xe+SZrW4cQGwKNRgA2QLSpy6aUlrt/Zl+OGsyB6b7op9YJDqyu5UGu?=
 =?iso-8859-1?Q?eqOx4tkMeCnywOOOWfIaA12XlxE9iqEnr1eANL23mSB/G8dA8VSJtDROG1?=
 =?iso-8859-1?Q?EzxbNnoY1M1+I4f7+U3SWno8kIr5VFPAN279+xLZkhi58lE94jscK8UUOb?=
 =?iso-8859-1?Q?0LtEwZFRMb+WGtjVcobYtmvhNamnL7tz3n/A8wNX7ZEkd5/8a6on2KFb7r?=
 =?iso-8859-1?Q?FeMzqpARhMFSQECgcj7+tPSgCOdF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6lBH3ExziVgghkjQDN5OcvLOYQ8/Ot8LxmmQXwR9tcy9tFYmuaTlM/DkYf?=
 =?iso-8859-1?Q?MWitTa5WwwH6kDlJfYMXXOni6vyr467VLo+bVNPv8JibrssiVLUri/q1T5?=
 =?iso-8859-1?Q?OD3Rz/bi+38ogp1B5AFSqGtZaEBs7bI5tL3QOnf5is1AgwYfKktQkmBT01?=
 =?iso-8859-1?Q?KCfLjm2gWZOf2aKIWdMMGHB9QjEDGxWwmB3To21j4eu9Csm0u/hE9THy7U?=
 =?iso-8859-1?Q?jyGhNWzVui0m/gv76BfHY9uN9+T9xE6uf4AABK8zVbQ0vXTIOLNf92e+4X?=
 =?iso-8859-1?Q?t8TNygD76fooDVraSGEM9Y5I4k7f8wyM9WRf8pnydqyQIq+y/VpXCuoEr/?=
 =?iso-8859-1?Q?iywaHAZ2127NwvNO57ZKMKoh+OpAWTnmQrAlAURjn5pkV7Sn9KTYh1ULNB?=
 =?iso-8859-1?Q?rs3M6+LQrkPUFJLZO/VfZPUF86uoWzIcRfNLC1+v+ohfGppIz0dnoRDJJN?=
 =?iso-8859-1?Q?dIAJNGAzHCYR9Wxw5W/e2+xPMbRyL4dY5R36Bl72TLkszJvWNOUFaJUpM9?=
 =?iso-8859-1?Q?LbAq0NU+5oTEDBo2N08J7DHdkPZGm4ycuNKVjVHj/QszoRjfjmlKFn0xgD?=
 =?iso-8859-1?Q?1PfIK/Kt0T5kkC5JYYX1x8TgA4vrqVzs+IUQ2Pah0RrUktHNn6EWk4nvgC?=
 =?iso-8859-1?Q?uPNMAvZ6LiPkjEOClJi41Ro9ZPQplsqKXi5ebObqw6PT3Fp1RieI/OV4q4?=
 =?iso-8859-1?Q?i6oxj7A3oR5GVy1y2boIKLGY+ivUYmTWAubuNIfyKl1J9ZfUbigCG6OiSK?=
 =?iso-8859-1?Q?7+Ko5UzkVPSfhJOnNuo0IYieLcq0y8jM0CEQYFwe0kdqS/Al+xWqYE5+CW?=
 =?iso-8859-1?Q?O9zXmQrs0mChaMHvsmccBXsIoOCfbINtJSe0uv0vJNhMXwZMHL7ozPnXpb?=
 =?iso-8859-1?Q?YtS3qEU7YFrn4JF00ky+Ie3Ynpq+VJN3f2VlFvnK94DFH2f8xcECnSs0kX?=
 =?iso-8859-1?Q?d86Ww/pPIzfNe0f+oSQDuFhyAFlp8M1MNzFSuFH6eq/0LWEh1EDPjRW9R0?=
 =?iso-8859-1?Q?otds09F8dYP6ZKYA6ezhjwxIq+2qSTLA8iNwYuILSLU0CHcgJbgwBkAqot?=
 =?iso-8859-1?Q?yVumOjUEoaTd0+5SDcZiwCS+spiGZKiHFReWAr1RiWxk9j5C3NQkANzem1?=
 =?iso-8859-1?Q?DfLJAZkPdjCsZ/9pEGGZ+VuH1fF01t5H3inW10DEh5aN8RVTl84bOVC3g8?=
 =?iso-8859-1?Q?AhmPC0hbpmNumEXjbyLOXb4gv5tu/ObgFeHG9EI0XH3cEo4aYJ5DhyCmle?=
 =?iso-8859-1?Q?860xAVK4VOvqou7UgxOaRxZgdZgsZxlzAxLYSrey9m7vms4zelMZhc5ImJ?=
 =?iso-8859-1?Q?MBlU4xGltateh9SDP6HNhAfCRgPLPeyxhCm4d5oOJJsVcga4YVZSHQKMd5?=
 =?iso-8859-1?Q?jmMXFy6xpauRzhY02qiZVdXjyJu9GiFAXy05e8JZcVMbbIzBKKE45vE2L5?=
 =?iso-8859-1?Q?KihejdllAfpMGhs/6ROTa9UZhT87NOPWM3VhKP8MFGveK2x8HXei3cWxdA?=
 =?iso-8859-1?Q?6ktITSt6znTt2eZfFKrB+eUaKPGYgHt0AWozSut4qd22VzutgmhPzjfSLF?=
 =?iso-8859-1?Q?hnTdSZB3puwow5aPNyOWs97D1ypfO5fpXE+XPF9aDhQhykJI5+9l2QKP08?=
 =?iso-8859-1?Q?Cz3vqki/WyPpm9lucm8g6vUTW3QSbUB6nT?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27ba9d9-799b-4e84-05b8-08de2662f58d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 05:26:00.0942 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3idErUmICFOeeIGte/MUFYkvElXRneo/IndIR9ADD/W+se9D68hMaSOShzrRyLRyRYIf0Bql9FSPyUsB0juUV5b7o3MJYhvNuW1+aXaPvLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8709
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> Subject: Re: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA addr
> associated with a ram device
>=20
> On 2025/11/17 13:14, Kasireddy, Vivek wrote:
> > Hi Akihiko,
> >
> >> Subject: Re: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA add=
r
> >> associated with a ram device
> >>
> >>
> >>
> >> On 2025/11/13 12:39, Kasireddy, Vivek wrote:
> >>> Hi Akihiko,
> >>>
> >>>> Subject: Re: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA a=
ddr
> >>>> associated with a ram device
> >>>>
> >>>> On 2025/11/12 13:30, Kasireddy, Vivek wrote:
> >>>>> Hi Akihiko,
> >>>>>
> >>>>>> Subject: Re: [PATCH v2 02/10] virtio-gpu: Find hva for Guest's DMA
> >> addr
> >>>>>> associated with a ram device
> >>>>>>
> >>>>>> On 2025/11/09 14:33, Vivek Kasireddy wrote:
> >>>>>>> If the Guest provides a DMA address that is associated with a ram
> >>>>>>> device (such as a PCI device region and not its system memory), t=
hen
> >>>>>>> we can obtain the hva (host virtual address) by invoking
> >>>>>>> address_space_translate() followed by
> >> memory_region_get_ram_ptr().
> >>>>>>>
> >>>>>>> This is because the ram device's address space is not accessible =
to
> >>>>>>> virtio-gpu directly and hence dma_memory_map() cannot be used.
> >>>>>>> Therefore, we first need to identify the memory region associated
> >> with
> >>>>>>> the DMA address and figure out if it belongs to a ram device or n=
ot
> >>>>>>> and decide how to obtain the host address accordingly.
> >>>>>>>
> >>>>>>> Note that we take a reference on the memory region if it belongs =
to a
> >>>>>>> ram device but we would still call dma_memory_unmap() later (to
> >> unref
> >>>>>>> mr) regardless of how we obtained the hva.
> >>>>>>>
> >>>>>>> Cc: Marc-Andr=E9 Lureau<marcandre.lureau@redhat.com>
> >>>>>>> Cc: Alex Benn=E9e<alex.bennee@linaro.org>
> >>>>>>> Cc: Akihiko Odaki<odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>>>>> Cc: Dmitry Osipenko<dmitry.osipenko@collabora.com>
> >>>>>>> Cc: Alex Williamson<alex.williamson@redhat.com>
> >>>>>>> Cc: C=E9dric Le Goater<clg@redhat.com>
> >>>>>>> Signed-off-by: Vivek Kasireddy<vivek.kasireddy@intel.com>
> >>>>>>> ---
> >>>>>>>      hw/display/virtio-gpu.c | 24 +++++++++++++++++++++---
> >>>>>>>      1 file changed, 21 insertions(+), 3 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c in=
dex
> >>>>>>> 199b18c746..d352b5afd6 100644
> >>>>>>> --- a/hw/display/virtio-gpu.c
> >>>>>>> +++ b/hw/display/virtio-gpu.c
> >>>>>>> @@ -798,6 +798,26 @@ static void
> >>>> virtio_gpu_set_scanout_blob(VirtIOGPU
> >>>>>> *g,
> >>>>>>>                                    &fb, res, &ss.r, &cmd->error);
> >>>>>>>      }
> >>>>>>>
> >>>>>>> +static void *virtio_gpu_dma_memory_map(VirtIOGPU *g,
> >>>>>>> +                                       struct virtio_gpu_ctrl_co=
mmand *cmd,
> >>>>>>> +                                       uint64_t a, hwaddr *len) =
{
> >>>>>>> +    MemoryRegion *mr =3D NULL;
> >>>>>>> +    hwaddr xlat;
> >>>>>>> +
> >>>>>>> +    mr =3D address_space_translate(VIRTIO_DEVICE(g)->dma_as, a,
> >> &xlat,
> >>>> len,
> >>>>>>> +                                 DMA_DIRECTION_TO_DEVICE,
> >>>>>>> +                                 MEMTXATTRS_UNSPECIFIED);
> >>>>>>> +    if (memory_region_is_ram_device(mr)) {
> >>>>>>> +        memory_region_ref(mr);
> >>>>>>> +        return memory_region_get_ram_ptr(mr) + xlat;
> >>>>>>> +    }
> >>>>>>> +
> >>>>>>> +    return dma_memory_map(VIRTIO_DEVICE(g)->dma_as, a, len,
> >>>>>>> +                          DMA_DIRECTION_TO_DEVICE,
> >>>>>>> +                          MEMTXATTRS_UNSPECIFIED);
> >>>>>> This function should:
> >>>>>> - call memory_region_get_ram_ptr(mr)
> >>>>>>       if memory_region_is_ram(mr)
> >>>>>> - return NULL otherwise
> >>>>>>
> >>>>>> There are a few reasons. First, the documentation of
> >>>> dma_memory_map()
> >>>>>> tells to use it "only for reads OR writes - not for read-modify-wr=
ite
> >>>>>> operations." It can be used for read-modify-write operations so
> >>>>>> dma_memory_map() should be avoided.
> >>>>> This patch series only deals with non-virgl use-cases where AFAICS
> >>>> resources
> >>>>> are not written to on the Host.
> >>>>>
> >>>>>> Second, it ensures that the mapped pointer is writable.
> >>>>>> "[PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
> >>>> associated
> >>>>>> with VFIO devices" adds checks for memory_region_is_ram() and
> >>>>>> memory_region_is_ram_device() to virtio_gpu_init_dmabuf(), but the
> >>>> other
> >>>>>> callers also use the function to map writable pointers.
> >>>>> Unless I am missing something, I don't see where writable pointers =
are
> >>>> used
> >>>>> in non-virgl use-cases?
> >>>> Rutabaga uses too, but you are right about that 2D operations won't =
use
> >> it.
> >>>>
> >>>> That said, exposing non-writable memory to Virgl and Rutabaga lets t=
he
> >>>> guest corrupt memory so should be avoided. On the other hand, it is
> >>>> unlikely that rejecting non-writable memory will cause any problem. =
You
> >>>> can also add another code path to use
> >>>> memory_region_supports_direct_access() instead of
> >>>> memory_region_is_ram()
> >>>> for virtio-gpu for 2D and avoid calling memory_region_is_ram() in
> >>>> virtio_gpu_init_dmabuf() if you want to keep non-writable memory
> >> working.
> >>> AFAICS, virtio_gpu_init_dmabuf() is only called in non-virgl/non-ruta=
baga
> >> code.
> >>> And, this patch series and my use-case (GPU SRIOV) only needs to deal
> >> with
> >>> non-writeable memory because the rendering is already done by the
> >> Guest and
> >>> the Host only needs to display the Guest's FB.
> >>>
> >>> However, I see that virtio_gpu_create_mapping_iov() is used by
> >> virgl/rutabaga
> >>> code as well, so I am wondering how do things work right now given th=
at
> >>> virtio_gpu_create_mapping_iov() always calls dma_memory_map()?
> >>> In other words, is there no problem currently with non-writeable memo=
ry
> >>> in virgl/rutabaga use-cases?
> >>
> >> The current code is problematic, and using memory_region_is_ram() will
> >> fix it.
> > Ok, I'll make the change.
> >
> >>
> >>>
> >>>>>> It also makes the check of memory_region_is_ram_device() and
> >>>>>> memory_region_is_ram() unnecessary for virtio_gpu_init_dmabuf(),
> >>>> reducing
> >>>>>> the overall complexity.
> >>>>> Since buffers reside completely in either ram or ram_device regions=
,
> >> using
> >>>> both
> >>>>> memory_region_is_ram_device() and memory_region_is_ram() to
> check
> >>>> where
> >>>>> they are located seems necessary and unavoidable.
> >>>> It can unconditionally call virtio_gpu_create_udmabuf(), and if the
> >>>> function finds the memory is incompatible with udmabuf, it can call
> >>>> vfio_device_lookup() to tell if the memory belongs to VFIO or not.
> >>> Yeah, what you suggest is doable but seems a bit convoluted to have t=
o
> >>> first call virtio_gpu_create_udmabuf() and if it fails then call VFIO=
 related
> >>> functions.
> >>>
> >>> I think using memory_region_is_ram_device() and
> >> memory_region_is_ram()
> >>> to identify the right memory region and calling either
> >> virtio_gpu_create_udmabuf()
> >>> or vfio_create_dmabuf() is much more intuitive and readable.
> >>
> >> memory_region_is_ram_device() and memory_region_is_ram() are not
> >> sufficient to identify the right memory region.
> >> memory_region_is_ram_device() returns true for RAM device created by
> >> non-VFIO devices, and memory_region_is_ram() returns true for memory
> >> regions created with memory_region_init_ram_ptr(), which is not backed
> >> with memfd.
> > Right, but structuring the code in the following way would address your
> concerns
> > and make it more robust:
> >          if (memory_region_is_ram_device(rb->mr) && (vdev =3D
> vfio_device_lookup(rb->mr))) {
> > 	vfio_create_dmabuf(vdev, res);
> >          } else if (memory_region_is_ram(rb->mr) &&
> virtio_gpu_have_udmabuf()) {
> > 	virtio_gpu_create_udmabuf(res);
> >          } else {
> > 	...
> >          }
>=20
> One of the concerns I raised is that having such checks has an inherent
> hazard that they can be inconsistent with the actual implementations.
>=20
> The original checks had such inconsistency, and the updated one still
> have too. memory_region_is_ram(rb->mr) && virtio_gpu_have_udmabuf()
> can
> be still true even for memory regions that do not have memfd; please
> refer to the example of memory_region_init_ram_ptr() I pointed out in
> the last email.
>=20
> Even if you somehow managed to write checks that match with the
> implementations, it is still possible that a future change can break it.
> Letting the implementations check their prerequisite conditions
> completely prevents such an error by construction and makes the code
> more robust.
IIUC, your suggestion is to add a check for memory_region_supports_direct_a=
ccess()
inside virtio_gpu_create_udmabuf() and call it unconditionally right?
And, also move the (memory_region_is_ram_device(rb->mr) && (vdev =3D vfio_d=
evice_lookup(rb->mr)))
check inside vfio_create_dmabuf() right?

Thanks,
Vivek
>=20
> Another concern is complexity. Calling another function
> (virtio_gpu_have_udmabuf()) do not reduce complexity.
>=20
> I do not understand why having such extra function calls and
> conditionals will make the code more robust.
>=20
> Regards,
> Akihiko Odaki

