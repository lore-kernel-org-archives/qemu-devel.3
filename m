Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F9FC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 07:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpkFd-0001UL-Kf; Thu, 28 Mar 2024 03:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rpkFb-0001Ty-2V
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 03:32:39 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rpkFY-00077T-IJ
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 03:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711611156; x=1743147156;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fiTv1rcIpBdMTajFStpgh4muPUCjoi2Qapl5F5dev10=;
 b=ab3JDOkOto6mljEmK2njcL+n4vblsY8gWqlMqc+vNdHAmt9kUoZwzBWQ
 ixMaNiu9r9TxGt/0kCvRilacdRL4QJJZca60jlyZPozBWXVJ+KgcisE8R
 zu+pgrlHwG/znIFRBWxApw+0LVeke/uc6IM/62jy9sDiRh/w1TcrOLQDD
 d4/Ib8y+xkbC+W1cuybF7Sx+aVGwYjghTWpkU8r6XRn+2CbSPtgUCVejD
 1907MF6bgaTYGTlLMfjFdqADWTTthjkUH3bHW2nlI9OE80HxwA2J/2y/4
 g15+b++18JMIwAKOMXobx/jmlaOxc/NgFw/rMka5ft8LNzQHoTmuV22It w==;
X-CSE-ConnectionGUID: xAsSxZPfR5yKmnJPr4jv8A==
X-CSE-MsgGUID: oaculvxkQCGWWRfS620/sA==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6610904"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="6610904"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2024 00:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; d="scan'208";a="39682515"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Mar 2024 00:32:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 00:32:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 00:32:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 00:32:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4j6576zRR0GANusBrzcNPovYXYz66qca7bVBaoxiY3uls61a68wrqGZHue2ZrMyM3gwhjPJnn0bb58xnYvdiR2dBH9/UtG2NyvdipkiT7nEIAnX0+LK1vOXN9PR1YWUyye1zXir08L9ei2thTeXP+xH+ZwWAT3zEp8Pz+9O49FpGi/zgUzIe3H5k8xAzhDTrG9PYekHSqrjHMUcE8dYwAExGjbsix2KdwzclRGMe8F5pkJlam/OtQ+C2EKAKzKiAx6s/s1HhzBC5LGWhTCdYKLQv02ic1e2sk/loKQdWcmc3RGKenBxtbyt53KWkf80ZKB3KsO/KVRtIkiz07urvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VsaCA/Tgcl1spsBg4vUzD9HcWom7G5aLEc995yt6dE=;
 b=cxJpoq0EACQN7uAwXOEaQFFXXiBeVZTYrIaWmz5u/CQvia66bMtpcSB8uZ/yes2BXgoe5lR7PKyAMCAv5AtRDgSe4ZOES+7sDjTBCZVJ5Uv4YtJe2CeC6wpWSKEA53Hr4AfcuRwLr5+4R4DoD7orBQ8mW1uhIvXge2L+JgGlY7gw2zGlTUkzWosaJ/DrwvhQwhV+V0Ed7IDI+jKoJ0/as2PRD0HRE5Ek+kKNA2h27R6kvlu3t4/4aXVLseH6OAp047OqfTQtUk7ndGnW+6aoJsFY5wV4w9+k7rZw9MPN/zGHnHQ4+vycgePPxdffpDZyweAWJ+app6Mp34tRigFskg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by CH0PR11MB8165.namprd11.prod.outlook.com (2603:10b6:610:18e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 07:32:25 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52%4]) with mapi id 15.20.7409.010; Thu, 28 Mar 2024
 07:32:25 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Bryan Zhang <bryan.zhang@bytedance.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "berrange@redhat.com" <berrange@redhat.com>, "Zou, Nanhai"
 <nanhai.zou@intel.com>, "hao.xiang@linux.dev" <hao.xiang@linux.dev>
Subject: RE: [PATCH v2 0/5] *** Implement using Intel QAT to offload ZLIB
Thread-Topic: [PATCH v2 0/5] *** Implement using Intel QAT to offload ZLIB
Thread-Index: AQHaf88Ke02O15hod0eOMnkRUGJf0bFMwfnQ
Date: Thu, 28 Mar 2024 07:32:25 +0000
Message-ID: <PH7PR11MB5941E186302BEE9F2B337736A33B2@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240326224221.3623014-1-bryan.zhang@bytedance.com>
In-Reply-To: <20240326224221.3623014-1-bryan.zhang@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|CH0PR11MB8165:EE_
x-ms-office365-filtering-correlation-id: 540bdf6b-29f0-4db9-1c77-08dc4ef936fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3KTWoxj9hLSu8ouNcw9uBT9E6TFJaLnUnBC+JLosMX3iCB0axWEsaVyR1WckORxfWkOht2+0jcHZgFeRzOBTeNeF24+dYYSx08+v1w1FTNLAufnigx/vRK/RDqYk8R8UOYQqJrpkoduOkSG1IbE+LeftgAGK61g2LmAVes4kx4Tm2cIBKOH75aUvfTv9f4grIdL3YgLrHY7eyjmK8or3KYZ0f5S7y/9cERyff0zpIN8gIdd3Nvv5S7gcNsT3+plMFerwDHpn8OPk/AZ88jUFyxWE1sz+s/f1310ghJwiHOpp291Vp1MX0sYQxPpNqonkGqbEOeZ/XMNdU9cpdxbvYMY4Yo9yYHkFfKQ/Z+7PoTc8r9khu+cuYVA5AgpEsQ8tzH9RPCsktJ+fn7yaTBX5E+AFtNdYfquhqWQROSlo1VUx/SgbXbFMoct3KR36+8ay1CXkruOZUQu7xxH4QHQ11SB1srXHsbsSGmaGLa+IoyKoTmCCmoHBViLq5N6DsZDDYaKBMAMgbsFkOOKC8obfDlrZ5g/3mJx5IWC3peGZYhcl1tIc52HsGdJRUcgc/d0uANYqXlTTysBcQ3CXFlnnaysdZPVLVbBgiDM38fJTnF9VgARq41qgGKL9PhZDBZ7vvUjo4eB9tTShPQkVzSDBlDesdfthzj5VSUO681bUsb/35s+Av1W+hQNfoD1d6vHk
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RRdBdrd5Mw7hL5N6x4PVczp9ZE6jgyH1ivU9nFauK+4kzdvZs5OKmyuzvugG?=
 =?us-ascii?Q?kofoWG0+REHkd0TOLcHc4lT00+H+IBT85SAylKSpK7UHXB7byAmoDDlSatBW?=
 =?us-ascii?Q?YMmhk3ZVJxBwzkaXnwO2Wcnz0JSNOcdXylwuHe5sICMoIDyB+izo2IPAhT/K?=
 =?us-ascii?Q?qd2meBFhOlVMQo3tJLvnk9H7KwdklTIbpGpgKxkGBG0OpmcOxBeANT4azSyd?=
 =?us-ascii?Q?EcYWouTxwb8GMyCyGlkZ9wevcmPDVgkBiHuK5aZ7OK2amGXlSJiGZMl2sySS?=
 =?us-ascii?Q?2ryAUzr5OUyyxwGFdd7jOCbpJUaspguyeDlE9Yzr1ADA6SSzWXqPBzb/wwi+?=
 =?us-ascii?Q?GhaQGvduOdrHyHlTm6diZj871q0mjBk5vKglmmE/OF2GIdGHDSgd5dafozIp?=
 =?us-ascii?Q?laelhk3ma8dQPfmGce2PSkLWwkEJaQ3D8AZCCNWI3M8u9w8EtIjlRP9FIsOU?=
 =?us-ascii?Q?/liMyW7HgHusqrxHq21mP9IuGGIxcHHN5VKNjaahr4o88aG7HS7G3CMjlt+J?=
 =?us-ascii?Q?WQCUmjtlC03ZFsOeXgeqzZwz62Qsd02c0bXMKpGWrjtJ3miO/fRYOd2Jtbqe?=
 =?us-ascii?Q?N3RC8wfX6nfSJcoWrWDxdjA1Opy05YhVT5lX34pvV1yENyDN20LuTSGTraB8?=
 =?us-ascii?Q?pX72u1OO6kNq+0NbL2VhTeYYh/Ey8mkx2BKERVJOfv0nAHys/fCqeyUeXrjq?=
 =?us-ascii?Q?yj40HGTBNeeSiAV38MZPIO+hyhG3owMzpzkqSoNuUrTDMth1LXJDsQCYjw3J?=
 =?us-ascii?Q?vEVJqQ4akLXjytpbkOQfbnDM9yl2s0GvnE96irnU1TFz3Jk+GovFS+x9gO3A?=
 =?us-ascii?Q?uSvX7j6dENeru85VWEOFat0xYD2CR7Z/IQDvvuzuGUu7jadOK5kDZQbHMXJk?=
 =?us-ascii?Q?8JZY3VE8PTiCFNx+dryXlimjA/JwllCA0ekLXrNIIx5lPX97cDbQmqDBPN9n?=
 =?us-ascii?Q?ZHyv519lXDXZjCxt6pGO61Xiie5aHO8/qhQ3Jd640zzvMYFSAABF15cM1/yU?=
 =?us-ascii?Q?G0j6WYHItSmc84YfJYr1q7wQI7fh/0Xfc0Mthfkilu1EndgfCAqfQWBivss1?=
 =?us-ascii?Q?cb+IrV2XjhJaJONQMdKJcTS1Wi4OPpbu669cBinyPdE7QdeMavo3qxF0mxMX?=
 =?us-ascii?Q?PTQsK4vFn/HK45tAocO3tsis/qZI/0lyuu5gxXOBLPZ1+hT6cIySlwg0DfNt?=
 =?us-ascii?Q?H/gugLXC16MAIL+vEXR5F/GJNal8vDLfo/odOrSvYR3Qa8qokY94+T+ZM/mA?=
 =?us-ascii?Q?AXhyILrX4crkVWBEviDAbSyYhdQgolTfvn7vOGBkMQbH/BaVYlEF7KfNsvoS?=
 =?us-ascii?Q?WrjdSHuXNAVZ9ljtiZc+L/R7d11Znt0YKV+gfWykx2NUP5Xa/a+bpHWMmjOG?=
 =?us-ascii?Q?5pokeOb9DIawNtDcrJIkvS8JG80Q17d4gyTAzoU9zwfGXY2OIKR7AQFK/Wrn?=
 =?us-ascii?Q?yLaWRO+6ZrgECekf5pZmiQrvaUXlL9zg62a2CLHShptmxz6NjaAuaDDjNDCJ?=
 =?us-ascii?Q?Mq0Knvip1QNfxvQBGhVSBYd9p9RKHtiAFklnlinN6o1aL8pDkkncx1wjUkA0?=
 =?us-ascii?Q?Vl9ZHD/G3HhvpmjqaF1sNdGUHtojNwxjKHnlPVOS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 540bdf6b-29f0-4db9-1c77-08dc4ef936fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 07:32:25.5622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a6HYLgabpOb2PYbTTTnj2ivUDsAEIEdRvg8rCcd3iD/A/Tavn7h7Nzif4dPxPSXnaHdAkv+AYMtRDJFTq41Ogw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8165
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
> From: Bryan Zhang <bryan.zhang@bytedance.com>
> Sent: Wednesday, March 27, 2024 6:42 AM
> To: qemu-devel@nongnu.org
> Cc: peterx@redhat.com; farosas@suse.de; Liu, Yuan1 <yuan1.liu@intel.com>;
> berrange@redhat.com; Zou, Nanhai <nanhai.zou@intel.com>;
> hao.xiang@linux.dev; Bryan Zhang <bryan.zhang@bytedance.com>
> Subject: [PATCH v2 0/5] *** Implement using Intel QAT to offload ZLIB
>=20
> v2:
> - Rebase changes on top of recent multifd code changes.
> - Use QATzip API 'qzMalloc' and 'qzFree' to allocate QAT buffers.
> - Remove parameter tuning and use QATzip's defaults for better
>   performance.
> - Add parameter to enable QAT software fallback.
>=20
> v1:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-12/msg03761.html
>=20
> * Performance
>=20
> We present updated performance results. For circumstantial reasons, v1
> presented performance on a low-bandwidth (1Gbps) network.
>=20
> Here, we present updated results with a similar setup as before but with
> two main differences:
>=20
> 1. Our machines have a ~50Gbps connection, tested using 'iperf3'.
> 2. We had a bug in our memory allocation causing us to only use ~1/2 of
> the VM's RAM. Now we properly allocate and fill nearly all of the VM's
> RAM.
>=20
> Thus, the test setup is as follows:
>=20
> We perform multifd live migration over TCP using a VM with 64GB memory.
> We prepare the machine's memory by powering it on, allocating a large
> amount of memory (60GB) as a single buffer, and filling the buffer with
> the repeated contents of the Silesia corpus[0]. This is in lieu of a more
> realistic memory snapshot, which proved troublesome to acquire.
>=20
> We analyze CPU usage by averaging the output of 'top' every second
> during migration. This is admittedly imprecise, but we feel that it
> accurately portrays the different degrees of CPU usage of varying
> compression methods.
>=20
> We present the latency, throughput, and CPU usage results for all of the
> compression methods, with varying numbers of multifd threads (4, 8, and
> 16).
>=20
> [0] The Silesia corpus can be accessed here:
> https://sun.aei.polsl.pl//~sdeor/index.php?page=3Dsilesia
>=20
> ** Results
>=20
> 4 multifd threads:
>=20
>     |---------------|---------------|----------------|---------|---------=
|
>     |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%=
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |qatzip         | 23.13         | 8749.94        |117.50   |186.49   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |zlib           |254.35         |  771.87        |388.20   |144.40   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |zstd           | 54.52         | 3442.59        |414.59   |149.77   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |none           | 12.45         |43739.60        |159.71   |204.96   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>=20
> 8 multifd threads:
>=20
>     |---------------|---------------|----------------|---------|---------=
|
>     |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%=
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |qatzip         | 16.91         |12306.52        |186.37   |391.84   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |zlib           |130.11         | 1508.89        |753.86   |289.35   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |zstd           | 27.57         | 6823.23        |786.83   |303.80   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |none           | 11.82         |46072.63        |163.74   |238.56   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>=20
> 16 multifd threads:
>=20
>     |---------------|---------------|----------------|---------|---------=
|
>     |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%=
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |qatzip         |18.64          |11044.52        | 573.61  |437.65   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |zlib           |66.43          | 2955.79        |1469.68  |567.47   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |zstd           |14.17          |13290.66        |1504.08  |615.33   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |none           |16.82          |32363.26        | 180.74  |217.17   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>=20
> ** Observations

I'm a little confused about the CPU utilization on the destination for=20
decompression, it seems the CPU is decompressing instead of QAT, I check
the code about qzDecompress, it is the same with qzCompress if the decompre=
ssion
task is not completed, it will try to stay sleep state as much as possible.

Maybe I understand it incorrectly, but I think QAT should help save more CP=
U resources=20
in both compression and decompression.

Thank you very much for providing this version. I will set up an environmen=
t on your patch=20
set to test the performance.
=20
> - In general, not using compression outperforms using compression in a
>   non-network-bound environment.
> - 'qatzip' outperforms other compression workers with 4 and 8 workers,
>   achieving a ~91% latency reduction over 'zlib' with 4 workers, and a
> ~58% latency reduction over 'zstd' with 4 workers.
> - 'qatzip' maintains comparable performance with 'zstd' at 16 workers,
>   showing a ~32% increase in latency. This performance difference
> becomes more noticeable with more workers, as CPU compression is highly
> parallelizable.
> - 'qatzip' compression uses considerably less CPU than other compression
>   methods. At 8 workers, 'qatzip' demonstrates a ~75% reduction in
> compression CPU usage compared to 'zstd' and 'zlib'.
> - 'qatzip' decompression CPU usage is less impressive, and is even
>   slightly worse than 'zstd' and 'zlib' CPU usage at 4 and 16 workers.
>=20
> Bryan Zhang (5):
>   meson: Introduce 'qatzip' feature to the build system
>   migration: Add migration parameters for QATzip
>   migration: Introduce unimplemented 'qatzip' compression method
>   migration: Implement 'qatzip' methods using QAT
>   tests/migration: Add integration test for 'qatzip' compression method
>=20
>  hw/core/qdev-properties-system.c |   6 +-
>  meson.build                      |  10 +
>  meson_options.txt                |   2 +
>  migration/meson.build            |   1 +
>  migration/migration-hmp-cmds.c   |   8 +
>  migration/multifd-qatzip.c       | 382 +++++++++++++++++++++++++++++++
>  migration/multifd.h              |   1 +
>  migration/options.c              |  57 +++++
>  migration/options.h              |   2 +
>  qapi/migration.json              |  40 +++-
>  scripts/meson-buildoptions.sh    |   3 +
>  tests/qtest/meson.build          |   4 +
>  tests/qtest/migration-test.c     |  35 +++
>  13 files changed, 549 insertions(+), 2 deletions(-)
>  create mode 100644 migration/multifd-qatzip.c
>=20
> --
> 2.30.2


