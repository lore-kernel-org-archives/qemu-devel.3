Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A017D73EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 05:58:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlhVn-0007tu-RX; Fri, 30 Jan 2026 00:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vlhVi-0007sg-1F
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 00:57:38 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vlhVe-00005P-Ph
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 00:57:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769752655; x=1801288655;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dlbQuEgL2rmxqWtEp8des7oWmmG8piJcGQCbihl61m8=;
 b=dRYgcr9HSyFcxz/GRNTIB/OyvSBlWNitmZbMA8NunJ8YNiy4W1GTc2i1
 SKj8VoBW1lWwRuImzlW6p4NY367olFxpM7NizcSh94q2SeQ8BWonE6M/D
 UuGCFcZw4RRAWSIxhhdBfi5tcxPAKkzjBId8POO7fKM6mDrlokUL63uvW
 pWF27govV+6eEcEuwwX0RRGdYI3YW3L7ZkKYAHitpVqHCQPMKPf7q+8eg
 i8sy16lVT7CWtUt4BHhlPq3MIcRI2CTqsEYLtvz7j5sISWkWgl6pMpUUJ
 ATVUMSXjax4Xkxtx1NPlev+t0lNxYPC8h28hKnHIaRw2pvSqcUtPKeKVa g==;
X-CSE-ConnectionGUID: tX4s8ti1Tpy/W6YEvZjLHA==
X-CSE-MsgGUID: WuHNQkL1SNG2Z629V61t+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="74853478"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="74853478"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2026 21:57:32 -0800
X-CSE-ConnectionGUID: cg3NJjCFReOS3yLLcA5RuA==
X-CSE-MsgGUID: d5nKm8/2RXitOmcKOYTcOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; d="scan'208";a="231694404"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2026 21:57:31 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 21:57:30 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 29 Jan 2026 21:57:30 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.34) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 29 Jan 2026 21:57:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fvpONnZrbTog007YRtegVTnclJXU7nDeWSoH7v6IxeHjjmC9JyBh2NYGa47lpNFfUgQ/Epxc9TyoudQzKP0w/oN7A/Z953lLkw8nEcjHIOfSopbQWMBjvBonh9UKn6ivbFiJTWWtSZYI1zzDx7354NpPCZEu5/U9XIc/8pU7pfgwHvMSsTApTM7wzw22Lgr2DuSkShCtMYMtGvnrjgAQK3jP3879Pp1J0kEwo//C0aL5L4Mvigp24JLS7vOf0EtfPRFvyk+PohyB+8zykk3ROgEpeA4glP0WFo0DugcDwWHpUVtJZmLh0h2PwCJmnsFuDGL3vYma/BuNhizQ7Ju6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3MqD0BMA+EhU5UOiy5gTFj3aJ5AA2D3fC8R75ILNa0=;
 b=hSCEWJniKLGV2gByyoRl/K1MIlJtmiX80BxQE6TjyxadHFTVUFkqfHMo4ORBaqrwSLS0162s67BfnVraIG4sOQFEpg0LHKsbxdp+YYbb2Ux8LBc4r1k2ZYGK0potV3tBS4Pl6saPAk66FF4c6N4aYaZds1RwcF6K/Cw/rvaGpKSWGaJen9OggPP+hPDmGgM1rci//+QBS4EMHk4s/SirL584TrAi4a8r3DWLXqzQqkatPWV0gK1ZmRq+lmSkAdwliVRmDt9QF3OyT5e+8gLNZfzQAiYP/I7dLPG/1sZJXFSHgtRp6YbixUx3g6JNa84tUiq7YKd0q6Noxcs8d+l4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by CH3PR11MB7673.namprd11.prod.outlook.com (2603:10b6:610:126::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 05:57:27 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 05:57:27 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v4 2/8] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
Thread-Topic: [PATCH v4 2/8] virtio-gpu: Find hva for Guest's DMA addr
 associated with a ram device
Thread-Index: AQHcjDCeQw49HQKsGE+uYIqUk8vykLVfT2SAgAW++RCAAfXNgIABdJJwgABGlgCAASRrYA==
Date: Fri, 30 Jan 2026 05:57:27 +0000
Message-ID: <IA0PR11MB7185D3C0DC8118D17DE156E2F89FA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260123062042.568703-1-vivek.kasireddy@intel.com>
 <20260123062042.568703-3-vivek.kasireddy@intel.com>
 <0d57e3df-3ae6-496f-b621-8d979e2ab3f8@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185FE7AA93FDB21AE6F8D14F890A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <2883c714-f03b-4381-920a-959a98380c23@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185A50C661BB777686D16A4F89EA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <462b513c-c505-4570-bd52-a1cfacc7c769@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <462b513c-c505-4570-bd52-a1cfacc7c769@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|CH3PR11MB7673:EE_
x-ms-office365-filtering-correlation-id: 95c3eb96-df65-4963-0806-08de5fc472ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GF7DWN2P9qYtdAFHzkFVsBS9/wSEuJPrHUPuIaApYfxNCPaSjqNq4xyS8m?=
 =?iso-8859-1?Q?DI0cX2zDeeukALRdG2velY4t38NKCEVhyNk45n2AsoRW7QwgtydW3UY2n/?=
 =?iso-8859-1?Q?XAbYyDALcc3bVv5Rz0W8wPLj8+/A/JaZYQf8e9RwaHmX3wAqhNduggVAYn?=
 =?iso-8859-1?Q?4W0onNpEYwRRFP7M6dCSOqOxnPWzO+jmN7RY3flntIebNZVcrAvcoNQRaL?=
 =?iso-8859-1?Q?AjHQwBTBCfUXmOGGTnXFdc7lYkGiQNXqSlVFpuBVABKjysb6+bU7nPehRk?=
 =?iso-8859-1?Q?740qM87bkoyYHa4BLJPABsybV/k+rIKuJstzHGIxtdUffFysGJR+Q3awh2?=
 =?iso-8859-1?Q?ACs3xM48CYod3L1mmUzuZeNlbAV5JX2wkRTKrCN2jPTBxPQtNRoVIEhia/?=
 =?iso-8859-1?Q?PSIfY929cEKCIJ47UBRk6jUJ1113igZy93Hp6RauhEYbgd+YhtdIBs8wwH?=
 =?iso-8859-1?Q?XcRW/n0f4aTGDB2gaTgsKr+ACr9u20GzZiIKEGMTAktrBSbsqlguqlIMf6?=
 =?iso-8859-1?Q?C0nHnm7v1Gi18RAk8swPzz9lq3ArZO1SN15x5etKyyxRFXOxBMLcS7OjRX?=
 =?iso-8859-1?Q?XA9xvP5jm1NGrOH+tkNvLW90PnH48btcUl4cNsK1PPA2UMFPruwkmAV1Qt?=
 =?iso-8859-1?Q?KzFmiXjgH040g/QwfLGj0c/QNDR+berTNL/x4QJDTZKMV6ZaH5tgOOqibf?=
 =?iso-8859-1?Q?9vpgQh24sps2Be0YF3QICaUi2Z9ukBxwmjb56oIoohByh3LuSGigWAm0JV?=
 =?iso-8859-1?Q?hAyG5A0YEhqkiPCqANtiGqQtwCI+73ehoh+qJfgTQMM5ys80Lw/0IvtBlG?=
 =?iso-8859-1?Q?+wr/Gm2wDjmvwxGwibNtoqzHErvK5FF28xHSfk/FanBmxmw+Uox/WYM8Xd?=
 =?iso-8859-1?Q?pFCrf1ksbYr88OhJ/h89FRrznya3kIPbifSmtAWjCQvcNX280FSHkK094I?=
 =?iso-8859-1?Q?P/mQmYsqbzyu/B4a3X9Zak16SxFM5dyXwEjIYSXVYlSSMRBDbALPOhkXgp?=
 =?iso-8859-1?Q?6sDKQOwFd1YeOuRFanjcNNSZJNgSqNhRWdZNQ1LG7i8MLoCmF7L//mMwyI?=
 =?iso-8859-1?Q?c6TjW8sLi2/ehd7hxPR1+U6qs09F9F3OcS8o44Qk5jwbTxC/Xa7bySG8LW?=
 =?iso-8859-1?Q?pwhI+zIJPK2BYdRTErDvJAq7kUM5zW6LHSHxPZdLCnVAwkv4SoXIX9LwNl?=
 =?iso-8859-1?Q?dsloZaseg/FqcWS8LMmmB/eEQJ7D5CwNa4SZ8GasLHD5y+C6Vcuwc7wSER?=
 =?iso-8859-1?Q?syXP+OwCWH9Z85E8HkaYBOr+6K6FTg2wY+tPIDJZ2JdSVFVYlJ+V74y7en?=
 =?iso-8859-1?Q?+2xMCzi+cESadevgkACsRhbXpiwM54okKe/vwAg+ojLZC7ErIMeZghhPeE?=
 =?iso-8859-1?Q?dWKwU8wePrex2scNoYjAVuC6q4NwAbcOfyNJOK6alOKtldfAYf63DOtL/C?=
 =?iso-8859-1?Q?oOcetPuj4VKUpEvg1yoT+FnLFQjqu879LiQsAbJ6kEPVcznZSpCSnQxbyo?=
 =?iso-8859-1?Q?Wy+H2Fks7NSgjfLUvsUaiXs1iohhVYPkmbi0inN5eTx5LLbPBiSGyOCycD?=
 =?iso-8859-1?Q?ZlbolEVpUSHAG+Mo4fsohYsk1UMVbl1TIOovyIiXJnLfkG2clw59KsAxi3?=
 =?iso-8859-1?Q?qI9bMfqUGXujZKM66unfH/oRjwpSe3v2YFem/zeugm9gWwRynBFqtI6hNm?=
 =?iso-8859-1?Q?MqubM2HX8py57UMCnrg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JQ5cpgSjMXn+Tr9nJEIZTTwR+llD23jj82BCH/hz7OD6tBq3nDwz0Xb43A?=
 =?iso-8859-1?Q?QC9nrhu4iyBsx52wuPTQiOpOKATSHEo9isMkwaIb/XSnDpy/I/LC/jklRs?=
 =?iso-8859-1?Q?dWsIcTBblHdXnH1YN08kafZRakuT+/Kx6lZDolqF23PTPqRmuVMH6asfGO?=
 =?iso-8859-1?Q?oVLUwyBUwIzV7CtbmdcUEJcnhtBSzBWwWh2InVHc5/BxVKjMlFJXr+P4ob?=
 =?iso-8859-1?Q?7tFA9blMlgX/+6y7i4uVTIfZXe7l1Ew9QoPG1/goG8PagBhE/3PKCsguNr?=
 =?iso-8859-1?Q?mXHJCBhduLezMLBxL5ziT54j5A5jpRJdqKOYlF1TV3FvePKdWiNggN7Tt0?=
 =?iso-8859-1?Q?7zT/3Zal42JaE8THwwFpMjuwnvG5VCZH3gu8xPcf7sVHjb9Il3QrRYrzVo?=
 =?iso-8859-1?Q?pz2hcSOHGf3NvGqfm+9eGQfK8oCbX98Tfq0zFOi/cUwEjRVlfzjq056SuU?=
 =?iso-8859-1?Q?A6JwIs1gjCEF5JW4qfj1nfMZPMm56VfMu2BR/WoPI4ot6K9KPg5vemyA25?=
 =?iso-8859-1?Q?Nadq6lW+nGq5OGLhCp6CmEj/wtor2v4oq5Fao+9/sw5zlzi+Hqj9KMXnAQ?=
 =?iso-8859-1?Q?UVe/DVqA0E/RGPgG151m/oMA+l0rhU/xmlLaEdayuN3c/U3xIvimW4Nutq?=
 =?iso-8859-1?Q?7jfgbfBtwhLcTIPauI1qPw8kEkqM5T243Y10V3GmvabmTD5SxwAC/IuiFx?=
 =?iso-8859-1?Q?28KZZdCyIRCkhqxrxoo0N7CTPp6JrjYqX0umUIJzzAcXRp5G4jVuJhwyxa?=
 =?iso-8859-1?Q?VNN/mjMw8UfpFOQEi0116BHMau29mRIoib7ekB+Kln0dLdRtUv1XlF9h0R?=
 =?iso-8859-1?Q?gGC6yA3lfBmn/98wC34aOqtcHRTeLsY6it0jTZhEx6f/z6Oq8rIUtxuISO?=
 =?iso-8859-1?Q?aDLuAmjm3bBVjDBH2Qu1ocH24C1x2FUzgfoUTFxkAv0qwOzoTzEneRYwVt?=
 =?iso-8859-1?Q?N+4OQu0TzZ0MBr8qvhObBAJ24kXsQujH35dVSxaMpFfjFOimNMmUdILBXG?=
 =?iso-8859-1?Q?kGXL7Lwpr/o8adlxjLmBS8HK3EQEO8PFdVBo2dSnXlNM5dexeaPPO25+Wj?=
 =?iso-8859-1?Q?en0AN5HUnfklAY3/AeR+XoWWe+2cnr9OGCa8wrgQgPn4N+sD+h/guc03SG?=
 =?iso-8859-1?Q?8yrusH8D0bS+lBoDNT+6coLMNUlnBt0jZt4J5pvo6PvBzDiijrz+hlIHDq?=
 =?iso-8859-1?Q?j5vlc6WiCKyeUYGM3GamIeoZTAsl7oo/ozYLO4IJLu6Xt6nik1mNRxtEzP?=
 =?iso-8859-1?Q?3juJyZXu+PsO0Dkf7wpSF4v1SOlvw8GgRR4p0F+EwLwNZTacdHBO9rMDSh?=
 =?iso-8859-1?Q?c7OSMA3eTQKC7F5bFg2p0zq2mmqhrKiu9jULxOtL0rkKfyk0EoKOeFQNkn?=
 =?iso-8859-1?Q?TgcYrYhtCiwTdZZBRmHM/OF7fckBLGeJs77v15oMLiJhhks/oWS1s0l69Q?=
 =?iso-8859-1?Q?4JN2ME6pHjOwLPdAGgV0Lgy6Cz7RLa2208PigKHI5PYMkQys4Sn0O4tkv0?=
 =?iso-8859-1?Q?6V1gtRngS8L06ZknCRCk39Wgzip0chAgEoKNSUBtbN5dZr0vlAGSJuas4b?=
 =?iso-8859-1?Q?i1r35f/O8greO45uL5UgWChWpMz0MWuxcYEPL5d7OaBY77pfk4RkXpRRno?=
 =?iso-8859-1?Q?hzmQCsqm72xbfW5qxS+9IbgB5OkYiVhXmI64EdT4cA7pcl3ZgCSekXxVm6?=
 =?iso-8859-1?Q?8DPdeRe4h2Lf0Jt/bU0hUcfDrwYGDto2p9fHyoi890WlcRM8QFl00sSlaA?=
 =?iso-8859-1?Q?i6hYXLqbxoW3ueZ4d6RqGKqm2glnL2+e1mBGUIlQd0INExV3SaLuQvY92M?=
 =?iso-8859-1?Q?e7yBMXGohQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c3eb96-df65-4963-0806-08de5fc472ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 05:57:27.5198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HkZNZxdLEqzvSopjP9fVLpgJg/vP0uBZ1KJRqqCuCatPyBLOWsarh3p5+YgMc6dUO/3j5TX8Fly3IoaJ2Vdl5F8gwYmADoBqyuyyKOjsPbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7673
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Akihiko,

> Subject: Re: [PATCH v4 2/8] virtio-gpu: Find hva for Guest's DMA addr
> associated with a ram device
> >>>> On 2026/01/23 15:17, Vivek Kasireddy wrote:
> >>>>> If the Guest provides a DMA address that is associated with a ram
> >>>>> device (such as a PCI device region and not its system memory),
> >>>>> then we can obtain the hva (host virtual address) by invoking
> >>>>> address_space_translate() followed by
> >> memory_region_get_ram_ptr().
> >>>>>
> >>>>> This is because the ram device's address space is not accessible
> >>>>> to virtio-gpu directly and hence dma_memory_map() cannot be
> used.
> >>>>
> >>>> This description is a bit confusing.
> >>> I agree; the description does seem ambiguous.
> >>>
> >>>>
> >>>> The first problem is with the phrase "the ram device's address
> space".
> >>>> The address space we are dealing with is always
> >>>> VIRTIO_DEVICE(g)->dma_as. More precisely it is a memory region,
> not
> >>>> address space.
> >>>>
> >>>> The second problem is that it says the ram device's memory region is
> >> not
> >>>> directly accessible. It is usually true, but here we are directly
> >>>> accessing it anyway because the guest knows how to do so.
> >>> Does this look better:
> >>>      "virtio-gpu: Find hva for Guest's DMA addr associated with a ram
> >> device
> >>>
> >>>       If the Guest provides a DMA address that is associated with a r=
am
> >>>       device (such as a PCI device region and not its system memory),
> >>>       then we can obtain the hva (host virtual address) by invoking
> >>>       address_space_translate() followed by
> >> memory_region_get_ram_ptr().
> >>>
> >>>       We cannot use dma_memory_map() in this case to get the hva
> >> because
> >>>       it can only be used with addresses that are associated with the
> >>>       system (or physical) memory region. Therefore, in order to hand=
le
> >>>       addresses associated with ram devices, we need to use the
> >>>       address_space_translate() API to first identify the right memor=
y
> >>>       region and the appropriate offset within that region and then u=
se
> >>>       memory_region_get_ram_ptr() to get the hva. This approach also
> >>>       works for addresses associated with the system memory region.
> >>
> >> Sorry but I don't think it's improved much. It still contains a phrase
> >> not well-established ("system (or physical) memory region").
> > I think it is well-established given this line in include/system/memory=
.h:
> > /* address_space_map: map a physical memory region into a host
> virtual address
> > and considering the fact that address_space_map() is called by
> > dma_memory_map().
>=20
> I guess not that particular phrase is wrong but the expression "it can
> only be used with addresses that are associated with the system (or
> physical) memory region" is not quite precise as whole.
>=20
> address_space_map() or dma_memory_map() can actually be used with
> any
> memory region. It however creates a bounce buffer if not directly
> accessible.
>=20
> >
> >>
> >> The description of what the logic does is expanded, but it's not reall=
y
> >> useful; it says the logic is to add the offset and the retrieved
> >> pointer, but it's obvious if you read the code. So let's focus on "why=
"
> >> the logic is added instead of what the logic does.
> >>
> >> Below is my analysis on "why":
> >> First, let's stick to the phrase "direct access"; its meaning is
> >> established in include/system/memory.h.
> >>
> >> With the concept of "direct access", the underlying problem being
> solved
> >> can be understood as follows: dma_memory_map() automatically
> >> determines
> >> what is directly accessible, and VFIO devices are considered not
> >> directly accessible because such accesses may be part of MMIO. But
> >> virtio-gpu is not doing MMIO, which leads to a disagreement with the
> >> function and virtio-gpu.
> > Here is another try:
> >      "virtio-gpu: Find hva for Guest's DMA addr associated with a ram
> device
> >
> >      If the Guest provides a DMA address that is associated with a ram
> >      device (such as a VFIO PCI device region and not its system memory=
),
> >      then we can obtain the hva (host virtual address) by invoking
> >      address_space_translate() followed by
> memory_region_get_ram_ptr().
> >
> >      We cannot use dma_memory_map() in this case to get the hva
> because
> >      it can only be used with addresses that are associated with memory
> >      regions that support direct access. Since VFIO device regions are
> >      not considered directly accessible (because they are mostly MMIO
> based),
> >      dma_memory_map() would fail to return the hva for such addresses
> >      when invoked by virtio-gpu.
> >
> >      Therefore, in order to handle addresses associated with VFIO devic=
es,
> >      we need to use the address_space_translate() API to first identify
> >      the right memory region and the appropriate offset within that
> >      region and then use memory_region_get_ram_ptr() to get the hva.
> >      This approach also works for addresses associated with the system
> >      memory region.
> >
> >      Note that, although we take an explicit reference on the memory
> >      region, we would still rely on dma_memory_unmap() to drop that
> >      reference when the dma mapping is eventually unmapped."
>=20
> This is better. Can you also address the inaccuracy of the statement "We
> cannot use dma_memory_map()..." which I noted above?
Just to confirm if my rewrite matches with what you have in mind, here is
how I am planning to replace the 2nd paragraph that starts with
"We cannot use dma_memory_map()" in the next version:
So, instead of
  "We cannot use dma_memory_map() in this case to get the hva because
    it can only be used with addresses that are associated with memory
    regions that support direct access. Since VFIO device regions are
    not considered directly accessible (because they are mostly MMIO based)=
,
    dma_memory_map() would fail to return the hva for such addresses
    when invoked by virtio-gpu."

I am going to replace it with
  "We cannot use dma_memory_map() because for memory regions that do
    not support direct access, it would create bounce buffers instead
    of returning the actual hva, which is not desirable here.
    And, since VFIO device regions are not considered directly accessible
    (because they are mostly MMIO based), virtio-gpu cannot invoke
    dma_memory_map() to obtain the hva in this case."

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki

