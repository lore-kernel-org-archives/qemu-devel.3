Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C545D358C8
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 06:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlLmP-0002AH-5U; Thu, 29 Jan 2026 01:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vlLmI-000277-Ei
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 01:45:18 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vlLmF-0004rD-IU
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 01:45:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769669116; x=1801205116;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yoFuMRKr5ffkW84PzaSHE6tvFOZtG39IKhN1J+wqUtE=;
 b=Gr6TQO+MbCKF4vbiNKVfBWpP3oPLzh8F5vYJd6ffEGrEFoL1ngvtCDv3
 EvmyBYjNptk0dqOmrjlkpud9GXv0mTnRF0eOuqpCUEw8R3FfPOUADvD9q
 ZUx8o2V+52ASP2A0Lm70AptYr9l66EYgFA6fDgn8GGTKXa2Au7vL+WzQk
 BhG5bveaN35ycYd6O2oSfHB5IOcuzrlgwpynDRFoijU9eXGvpGYvgGupS
 nZF+4/b+2B4wvAa+cMyjxK89EevSHPbpqIRe0tS04rjO4LNvXsLFFpdbn
 0Ojx5TwAqXXA0Flpj3T9RIbcqixMZDaChrMva9aORHDt1BQuphTsENsS1 w==;
X-CSE-ConnectionGUID: 1J7nNeB1RBqxED5qtjujEg==
X-CSE-MsgGUID: E/mj/zpnTEi82y0YJfPZKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="74520703"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; d="scan'208";a="74520703"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 22:45:14 -0800
X-CSE-ConnectionGUID: cz6HjiU0Q4i6gP/0AjDnMw==
X-CSE-MsgGUID: Tllrp0TFT7akH/3/LOg84g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; d="scan'208";a="213454960"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 22:45:14 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 22:45:13 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 22:45:13 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.20)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 22:45:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIfsmrAP/zZ6ESXxsZvB+eUk/hrwX8Tt0m+Mg83qU5QcoPtl5ICxe9MHV2E+rfq2RWkZzN2fCEBW+4zemtbT8UfigfViSIfbAHAoKPJYPHvHSN9EP4JQbaDS6LHxdBqE+vopTlInnvNOXCIxN5o1+PA2nLINGbdcDzCsehVx+FTc5XG7oKHZuE1mFhUomueaYUR8biuDY1FbdBUTLLIe0gJHNCeksJX6JSVdHhP2WOgyV3cNYl7kBtBCnODSSffnogkWliW5kfrZrF1ZmdVcAmNd8XN1/LUifOVmMju3Y2saiOSJRdk62t9bx1tpoJV0we9uqZCfpUAf7ugnfucCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S6jNSRG70YcyH2cKmcpBi7QY1rhBXsdbZYgmw8CWWk8=;
 b=iHTO43mCMAG/RdHQuYrxqJ92C91YasR14UDFEqLaJV8gGcjyh1Y4OZp+EjkMpFpOwdA+4IJuKPpI6BEcD2t2muMBabGXR1qM4KWkirCbUAq0IOTI4O/y1Sysk0rDTqaXwKxKFFTcGTHUPtgZ9F/k09H+Mh+Zx9ZsfPsZCMYg71znSzqodGd15QXL/7WB4V3JvNS5VCtIMRcoFdf2yrHG4JD5XnxUhN7h5XM2Mk89FX9QsLbU0heKyfWo2i37LHFGR+7qeca3v8/sm0xiqwIIwyaOlfi1bwlow+FlEnbNTMgm3WhzsW48qQhrQAY5AbgOCLQfgNH//VVOyGVIb/4OKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by MW4PR11MB5799.namprd11.prod.outlook.com (2603:10b6:303:181::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 06:45:10 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 06:45:09 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v4 8/8] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v4 8/8] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcjDCjL5JILwxhKUSESHcm3Ev6grVfTecAgAXcUACAAdOngIABg9Gg
Date: Thu, 29 Jan 2026 06:45:09 +0000
Message-ID: <IA0PR11MB718557F2C06B8F0F3ED9089CF89EA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260123062042.568703-1-vivek.kasireddy@intel.com>
 <20260123062042.568703-9-vivek.kasireddy@intel.com>
 <ef2f5779-a23b-44dc-b467-0da00e6b1243@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB718584261475341CB7958A8FF890A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <0c2d8d6b-f93a-4548-ad3d-21253cce6fc4@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <0c2d8d6b-f93a-4548-ad3d-21253cce6fc4@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|MW4PR11MB5799:EE_
x-ms-office365-filtering-correlation-id: 2e3912fa-75e8-4e23-99a1-08de5f01f24f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?KZYfEdkNnUPb0KbYQNB/1o1NAQOo/jM6jCyS1PS4Fl38AMqIWBzKuEvJRm?=
 =?iso-8859-1?Q?7mXDf2+KtT6hQtEO9Zr0eLtl5AyPOadKDYx2pQDv8vI/GMgQbpToLigvku?=
 =?iso-8859-1?Q?5CfxuXbrKFt2o4CAg3AmscjFExNOToWHSHEtlgyv+Oyjj7jFyibkMuFDM6?=
 =?iso-8859-1?Q?qB1wxkIUhUIh23l8/VvNvj8b41drOMQG9WFt7lG60+wle6xNai6IrMycTo?=
 =?iso-8859-1?Q?QFtk+2HgWA5iY4mhvzc4Sq4njZp+Gik2em6hfhU5jLC6NFmjXmI4L1qSBx?=
 =?iso-8859-1?Q?6sc7/PSeB92JWzfcxIkGiB+MypaayinDPyMEo1ChdvNHeYh+bjqsFZp8Ub?=
 =?iso-8859-1?Q?d/f5SamykccT06DFunYqBcyTOWZoh+/GpHBKqQFx4Fr+9wmeGyjI54saYb?=
 =?iso-8859-1?Q?scuhiddAYRdxfzK1/fRdvMWkM1opjmw2DjtSpxLuMBztiw5m9ozbddwRnf?=
 =?iso-8859-1?Q?Q6XBwa4GrKEXnTFDhPEnR6greu3o+rxFRDYPHgUyk7LvH/mwDUlNexYudt?=
 =?iso-8859-1?Q?ghGouwumcUK2los36NzYELG2yTxktAKU1LOoVlDfrQfVymk3j0Pc5EI9tz?=
 =?iso-8859-1?Q?GqddEd7p2/rqM8sf8Ffokb3ir8rhXsW4/cjMh5YEVPGXqpPe+CUF2GwQVI?=
 =?iso-8859-1?Q?nXcoC7fVZ3PkmP7IYwWzwa94ZbfzWRWf0mtgvi0iv97K5Y94k0Tu51Q1TG?=
 =?iso-8859-1?Q?fyx5K64MEBdU+cjMf+0+m82rq6lphNhUV4+glFH/rUq2yNcryEbPoIW+a4?=
 =?iso-8859-1?Q?sGnO5XPlYBMqdX1X2sw7Ci79rkWtAIxF3GYmU5pf7v5InRu6YqxQzv4HjC?=
 =?iso-8859-1?Q?UbamcdKGy48RPeQ+jc1BQotRABA/FfLZC185koy+aqxC1S/l7nKLjky8Ql?=
 =?iso-8859-1?Q?ZzrpAri9PT3vAW4f2NPSTeslLWVi4p1OpG9kKb9nEStlssl7//3bQxu+qN?=
 =?iso-8859-1?Q?XYM+1W/nZn4ByFbgm7RoEijUPi0yZ2ZCP7IaOq9Yb3ZdTeWGQ4/gdug3Wm?=
 =?iso-8859-1?Q?YWUM1uBZRqUrHD75RmAlemxfiMQl+knIy+6NTbL3t6HLxdRmUtfDx9Ldtf?=
 =?iso-8859-1?Q?BcdebTvENDSKujW1xyxOxgCsZ8KwvXA+S5Jq53vI/F9lRVctNA0mCBuVFN?=
 =?iso-8859-1?Q?UcfircCXZov/O9egrA8q+5hl5Up5vJ73G6wX190wymWybXtJLKcPHFpBz6?=
 =?iso-8859-1?Q?ofyUqaBId6Q0Ku70HR9xWHxu+RSzAqE0ASGNqyf7m+5O61z/vwHxstz5+1?=
 =?iso-8859-1?Q?8I4SLqHPkrvhQwAwkKoGUEdSGEUpTuCGO48cDZtenNjQnoB+XcR2tGDB7Z?=
 =?iso-8859-1?Q?7RWhoSnW82cbUNCidqnmaLDX2Ib1/594FNuKypPvhx/ousNan/Wtpfwub5?=
 =?iso-8859-1?Q?Uasy7Qowq3UtyXIiQv9HP3D8RinhoUXfZYipCWyY1QEHhz70xquhtO+0vA?=
 =?iso-8859-1?Q?Q2RAQV6HxKVmbSxqxjlq2cqYL7oG9n3uxqz3qEYY4nbxg2U+YjwUVpVNje?=
 =?iso-8859-1?Q?/184YCyvEOS9Hef9NdWjC7V3a8TsHVxSjKfH+WfpyVrbFBdf1VFqyT4lcF?=
 =?iso-8859-1?Q?w1N50+hxYsSQoon0v3V1xQur8/CzTOKVtp1RxeRd+IXOr6ChMko7eweKnu?=
 =?iso-8859-1?Q?cbYoXI9j4zweDBTpko5od0N/UK2ZkTn6nJZyWNSOFK2C/cxZ+E25kzEsq1?=
 =?iso-8859-1?Q?Caa5cZlYCKaf6xcWhjc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bfkgLb6I7Zv71mVOkjkn2+b4kcaiduqmXr+MBINAtamQWXdaXCRrzxcyM5?=
 =?iso-8859-1?Q?90r1p3vEYX1C4dtdw7EaW73O04u1gBUfVR4EyTEN4BJ7757qqSntbW9q27?=
 =?iso-8859-1?Q?N8JhyrOR7Wp5a6UGsN7wJQElJKFSQK8iW2MSch/ugSQ4qFcBCaFupnm7sn?=
 =?iso-8859-1?Q?AcIx4TxFHrpQoQRJdrusMTHPZQLMvceJ9ivSCoWzmS4nLYN5/VU0XL3Bm0?=
 =?iso-8859-1?Q?lpzmQ9YH73v57c2G0D5WzeK8qBk3bSfWAz2qvaF4rbS8OIaqOW/toY4jIP?=
 =?iso-8859-1?Q?uwtmsvM3VCi/iqMoPZgdh7/5ZDw+eOrztK8LTWnufJKZ8tKXMT5Z2FOYqm?=
 =?iso-8859-1?Q?vIVSF8HWYQUhYDDlrdypwEfq6JWlnc9e4RQv35vRITnpATui2VCnupHk+C?=
 =?iso-8859-1?Q?wCpaLcVluDNgwbpSZ+CHd1v3LEaWEeD6bL6BnGM6Rf5ZEwxsu2myOovhvs?=
 =?iso-8859-1?Q?BwZ2iFyUUhvdlugRCtppCsJYN2YM5PIydTzWIx9FI9/reQ4gw7WvIT4wa0?=
 =?iso-8859-1?Q?7Evl19mqC8g0Veskcdv6KXIfrvknPr/HDtYXMT7TVXT0BfP/d+Nyn5c4sP?=
 =?iso-8859-1?Q?LZ0TvUNH/GPjzz/2QaUcyj3Fw0xXsBxta0HeNBGJDYlUzy1lpLvmLKTgcx?=
 =?iso-8859-1?Q?SYJcZGIN+vu94wBiIgS9EJxW4hF1wukQvGBWfP7kNANwjDuCBD255LNrvq?=
 =?iso-8859-1?Q?RRXdYT4u2AWYBNm0qMGnSSqdKy49iID89ETYgkhJP2U92rJRFuwX+4khaF?=
 =?iso-8859-1?Q?ECPGWnEqsxe6nBpkBTuaw1nybG5Acp2q6rT7In4Kbdsc/dTctqkNVk4W7d?=
 =?iso-8859-1?Q?yGZXf7I54ggl70YZLC4Lp4Mqa86rACy8om+ExbGm9BctSJmjq6NVz36M5s?=
 =?iso-8859-1?Q?tLTYCb5sLUctisoGxql0y8KV0P373o0R68nrnAFzq9qa7qM6AZcfH4AehS?=
 =?iso-8859-1?Q?vp6hw5xTz/bP5GZwaQhOoUeYF7ZtMGf+xWfJe8XhzYtkn4pfiCIthi2afh?=
 =?iso-8859-1?Q?MH8L1d7RTfPBIMowVu1q2hncBoZmd53KpVt1VrY/udE2w+K8iEdkIW/q6c?=
 =?iso-8859-1?Q?VSHLK7a4IeDzT0nk/YrDf/O7cLGnBtZOT0+bdh4Gqk7Scdsw7R0EdLw/AZ?=
 =?iso-8859-1?Q?lNabk1jMoLXEpkOPZgyjhA/4QOZPOOaociKmFvqry/OazMTNDpwMHJF4Cb?=
 =?iso-8859-1?Q?OwPqbjlCCy46iE8eh+dnjGgFnTit1VAV+bOUATxVHUuI9v8942EO4ClLOH?=
 =?iso-8859-1?Q?8urRgDjhiocXVeDo4Et0MIolZs1/8lgOGs2A9mvlUVEjmV2hpDnw08b7cs?=
 =?iso-8859-1?Q?0Vtd0ZDIDlN7PmpagMQZDVb0KOHTr/FNaBGzmUFfStp3YxYkNO/oFDnDbN?=
 =?iso-8859-1?Q?/WoOW/uqmDejMpr4jcMRItAMqrplJqFC+9KxkMhd3RnyHnyVqiJ8TEe9QR?=
 =?iso-8859-1?Q?u3CqC6gb/XDj9awz/JYuF1VCGwhoyJ+yzGPBNnKh/JliE4R7mTfC6y5/xs?=
 =?iso-8859-1?Q?5VUSANwCQ36utHKHh3dpGqvXJF8CR9dYE3xuAXtHKi4GQERTrcmdxaEZoD?=
 =?iso-8859-1?Q?AXk6p4+UStlM0OH1yP3BJ+nLs2vpCir/X9+rb/i+WyqxSMnrEuRpJTK0G1?=
 =?iso-8859-1?Q?h/BO8VIn6IOxvdA+QZXaTs82s7i4i0x4J6XcdDP3lviDqNVNui8u++jOCQ?=
 =?iso-8859-1?Q?F9FKQPyr321eje2AFw+MajhixQqv1C2jwX7CFhkNHmBIRQOAmmGF5PemNX?=
 =?iso-8859-1?Q?el/UuwqsHECOA6lFOOeAB6UHGOMW1VjcPcA6GmkYUQw0mbTw9KgPB1OQtP?=
 =?iso-8859-1?Q?uuRwbxz3/g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3912fa-75e8-4e23-99a1-08de5f01f24f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 06:45:09.8044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fX5XynnZ+NTlQI7UBeR2rRp5wKo54Pj0DysqxptDQunJgzB3HJwCU+uHZuTzbJ2SdWe/+7muHcyGNNnhGPYYvpvVrpmkKiR/NCXHshfpjeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5799
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
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

> Subject: Re: [PATCH v4 8/8] virtio-gpu-dmabuf: Create dmabuf for blobs
> associated with VFIO devices
> >>> In addition to memfd, a blob resource can also have its backing
> >>> storage in a VFIO device region. Since, there is no effective way
> >>> to determine where the backing storage is located, we first try to
> >>> create a dmabuf assuming it is in memfd. If that fails, we try to
> >>> create a dmabuf assuming it is in VFIO device region.
> >>>
> >>> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> >>> backing storage is located in a memfd or not. If it is not, we call
> >>> vfio_create_dmabuf() which identifies the right VFIO device and
> >>> eventually invokes the vfio_device_create_dmabuf_fd() API to have
> >>> a dmabuf fd created.
> >>>
> >>> Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> >>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> >>> use the VFIO device fd directly to create the CPU mapping.
> >>>
> >>> While at it, remove the unnecessary rcu_read_lock/rcu_read_unlock
> >>> from virtio_gpu_create_udmabuf() and also replace warn_report()
> >>> with qemu_log_mask().
> >>>
> >>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> Cc: Alex Williamson <alex@shazbot.org>
> >>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>> ---
> >>>    hw/display/Kconfig             |   5 ++
> >>>    hw/display/virtio-gpu-dmabuf.c | 117
> >> ++++++++++++++++++++++++++++++---
> >>>    2 files changed, 113 insertions(+), 9 deletions(-)
> >>>
> >>> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> >>> index 1e95ab28ef..0d090f25f5 100644
> >>> --- a/hw/display/Kconfig
> >>> +++ b/hw/display/Kconfig
> >>> @@ -106,6 +106,11 @@ config VIRTIO_VGA
> >>>        depends on VIRTIO_PCI
> >>>        select VGA
> >>>
> >>> +config VIRTIO_GPU_VFIO_BLOB
> >>> +    bool
> >>> +    default y
> >>> +    depends on VFIO
> >>> +
> >>>    config VHOST_USER_GPU
> >>>        bool
> >>>        default y
> >>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> >> dmabuf.c
> >>> index c34d4c85bc..2dfe70d7eb 100644
> >>> --- a/hw/display/virtio-gpu-dmabuf.c
> >>> +++ b/hw/display/virtio-gpu-dmabuf.c
> >>> @@ -18,6 +18,7 @@
> >>>    #include "ui/console.h"
> >>>    #include "hw/virtio/virtio-gpu.h"
> >>>    #include "hw/virtio/virtio-gpu-pixman.h"
> >>> +#include "hw/vfio/vfio-device.h"
> >>>    #include "trace.h"
> >>>    #include "system/ramblock.h"
> >>>    #include "system/hostmem.h"
> >>> @@ -27,6 +28,38 @@
> >>>    #include "standard-headers/linux/udmabuf.h"
> >>>    #include "standard-headers/drm/drm_fourcc.h"
> >>>
> >>> +static void vfio_create_dmabuf(struct virtio_gpu_simple_resource
> >> *res)
> >>> +{
> >>> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> >>> +    VFIODevice *vbasedev;
> >>> +    RAMBlock *first_rb;
> >>> +    ram_addr_t offset;
> >>> +
> >>> +    first_rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, fals=
e,
> >> &offset);
> >>> +    if (!first_rb) {
> >>> +        qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                      "%s: Could not find ramblock\n", __func__);
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    vbasedev =3D vfio_device_lookup(first_rb->mr);
> >>> +    if (!vbasedev) {
> >>> +        qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                      "%s: No VFIO device found to create dmabuf fro=
m\n",
> >>> +                      __func__);
> >>> +        return;
> >>> +    }
> >>> +
> >>> +    res->dmabuf_fd =3D vfio_device_create_dmabuf_fd(vbasedev,
> >>> +                                                  res->iov, res->iov=
_cnt);
> >>> +    if (res->dmabuf_fd < 0) {
> >>> +        qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                      "%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s\n",
> >>> +                      __func__, strerror(errno));
> >>> +    }
> >>
> >> This API design of vfio_device_create_dmabuf_fd() has some room of
> >> improvements.
> >>
> >> First, this function requires to pass VFIODevice * which is derived fr=
om
> >> res->iov[0]. Since it is getting res->iov[0] anyway, such a parameter =
is
> >> redundant. vfio_device_create_dmabuf_fd() can call
> >> vfio_device_lookup()
> >> itself instead.
> > Yeah, I agree. I'll move the call to lookup into
> vfio_device_create_dmabuf_fd().
> >
> >>
> >> The second problem is the error handling. The error may not be caused
> by
> >> VFIO_DEVICE_FEATURE_DMA_BUF but may be caused by the guest
> >> passing
> >> regions that do not belong to one VFIO device. The two cases should
> be
> >> distinguished for a correct message.
> > Ok, I'll add separate error messages.
> >
> >>
> >>> +#endif
> >>> +}
> >>> +
> >>>    static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>    {
> >>>        struct udmabuf_create_list *list;
> >>> @@ -43,10 +76,7 @@ static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>                         sizeof(struct udmabuf_create_item) * res->iov=
_cnt);
> >>>
> >>>        for (i =3D 0; i < res->iov_cnt; i++) {
> >>> -        rcu_read_lock();
> >>>            rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, fals=
e,
> >> &offset);
> >>> -        rcu_read_unlock();
> >>> -
> >>>            if (!rb || rb->fd < 0) {
> >>>                g_free(list);
> >>>                return;
> >>> @@ -62,17 +92,84 @@ static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>
> >>>        res->dmabuf_fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> >>>        if (res->dmabuf_fd < 0) {
> >>> -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> >>> -                    strerror(errno));
> >>> +        qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                      "%s: UDMABUF_CREATE_LIST: %s\n",
> >>> +                      __func__, strerror(errno));
> >>>        }
> >>>        g_free(list);
> >>>    }
> >>
> >> These changes of virtio_gpu_create_udmabuf() are independent so
> >> should
> >> go into separate patches with explanation.
> > I called these out in the commit message and included them as they
> were
> > trivial but I guess I could move them into separate patches.
>=20
> As docs/devel/submitting-a-patch.rst says,
>  > A commit message that mentions "Also, ..." is often a good candidate
>  > for splitting into multiple patches.
>=20
> I think there will be another round of review so I suggest taking the
> chance to do so.
Ok, I'll split them into separate patches.

>=20
> >
> >>
> >>>
> >>> +static void *vfio_dmabuf_mmap(struct virtio_gpu_simple_resource
> >> *res)
> >>> +{
> >>> +    struct vfio_region_info *info =3D NULL;
> >>> +    VFIODevice *vbasedev =3D NULL;
> >>> +    ram_addr_t offset, len =3D 0;
> >>> +    RAMBlock *first_rb, *rb;
> >>> +    void *map, *submap;
> >>> +    int i, ret =3D -1;
> >>> +
> >>> +    first_rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, fals=
e,
> >> &offset);
> >>> +    if (!first_rb) {
> >>> +        return MAP_FAILED;
> >>> +    }
> >>> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> >>> +    vbasedev =3D vfio_device_lookup(first_rb->mr);
> >>> +#endif
> >>> +    if (!vbasedev) {
> >>> +        return MAP_FAILED;
> >>> +    }
> >>> +
> >>> +    /*
> >>> +     * We first reserve a contiguous chunk of address space for the
> entire
> >>> +     * dmabuf, then replace it with smaller mappings that correspond
> to
> >> the
> >>> +     * individual segments of the dmabuf.
> >>> +     */
> >>> +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> >> vbasedev->fd, 0);
> >>
> >> It should have PROT_NONE instead of PROT_READ to prevent
> accidental
> >> accesses to the placeholder mapping.
> >> Likewise, -1 should be passed instead of vbasedev->fd so that the
> >> placeholder mapping won't result in a mapping to real device.
> > I am OK with both suggestions. However, I don't see any problem if the
> > placeholder mapping is associated with the real device. In other words,
> > what specific problem do you see if we keep vbasedev->fd instead of -1?
>=20
> These two suggestions are to avoid accidents. If the code is right,
> there will be no accesses to the head of the device memory. But if there
> is something wrong with it, these two changes will be safe guards. In
> other words, with these two changes, you will not have such an
> accidental access unless all of the following three happen:
> 1) Accidentally accessing the mapped page.
> 2) The protection is set something else PROT_NONE.
> 3) The mapping points to the device.
>=20
> Each of these conditions make accidents rarer to occur.
Sounds good. I'll add these two suggestions.

>=20
> >
> >>
> >>> +    if (map =3D=3D MAP_FAILED) {
> >>> +        return map;
> >>> +    }
> >>> +
> >>> +    for (i =3D 0; i < res->iov_cnt; i++) {
> >>> +        rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, false,
> >> &offset);
> >>> +        if (rb !=3D first_rb) {
> >>> +            goto err;
> >>> +        }
> >>> +#if defined(VIRTIO_GPU_VFIO_BLOB)
> >>> +        ret =3D vfio_get_region_index_from_mr(rb->mr);
> >>> +        if (ret < 0) {
> >>> +            goto err;
> >>> +        }
> >>> +
> >>> +        ret =3D vfio_device_get_region_info(vbasedev, ret, &info);
> >>
> >> This function can take rb->mr and call vfio_device_lookup() and
> >> vfio_get_region_index_from_mr() internally to simplify the API as
> >> similar can be done for vfio_device_create_dmabuf_fd().
> > Right, but vfio_device_get_region_info() is an already existing API
> > that is called from various places that I am trying to leverage. I coul=
d
> > create another API to wrap the calls to
> vfio_get_region_index_from_mr()
> > and vfio_device_get_region_info() but not sure if that makes sense
> given
> > that it would only have one caller.
>=20
> vfio_device_get_region_info() should be regarded as an internal function
> of VFIO.
>=20
> Thinking of that, the current API design that relies on
> vfio_device_lookup() to expose VFIODevice * is not optimal. We never
> want virtio-gpu or anyone else VFIO to mess up with it using functions
> declared in include/hw/vfio/vfio-device.h. Likewise, exposing
> vbasedev->fd introduces bunch of hazards.
>=20
> I think this entire function is better moved to VFIO for better
> encapsulation. I also think it should be placed close to
> vfio_device_create_dmabuf_fd(). These functions are quite similar so are
> better reviewed togather. Any future event to change either of the
> function is also likely to require a change to the other, so placing
> them nearby will be convenient.
Ok, I'll try to rename and move this function to VFIO.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki

