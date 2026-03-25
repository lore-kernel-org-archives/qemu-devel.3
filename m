Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3FEFEA80A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 05:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5GoX-0003ds-55; Wed, 25 Mar 2026 01:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w5GoV-0003dk-3n
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 01:29:55 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w5GoS-0002hX-KJ
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 01:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774416592; x=1805952592;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LZyWXTUFZbhLMCG/sdsfL3SBHwiKrJwUkhHUNzKBCWY=;
 b=WDZ+/3PCczKpM3rDzNHyR+KGPYEgQrYrD/PZrZ8Kcw07g60eOj5oqy1L
 ZOine5pSBc74fHLRGNY+YO3wrcIzQcyloIhuDUm+Ts1WWUS+/UkPbxCAY
 +l3g4OPfV1ANrZ0KEvZL1IXljdQPM9bSm2NIuSiVcYjtSIxlSd7HdLcYB
 5CkabGtQS4Lf0KSpj8EdtBmf0L98G5SK3iOdsZY312Lb3cnuNe/WFlRLA
 FmC5aMj8ConJJwS4Bno9bDglsh9Cx4P1GGEV81b5RJ1DZirIwk52SRZbo
 dobLdQs8ubiPtaULm1pnEpj/r8RlMi7BhUROtaYCGrxUujqtNjA/FUgYT g==;
X-CSE-ConnectionGUID: gUNo3xMqSaqUaWH8v+YlvQ==
X-CSE-MsgGUID: oxQ2N6UeRnKvJV36XjPokA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86523695"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="86523695"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 22:29:49 -0700
X-CSE-ConnectionGUID: 9XT4xhbVT6iEGUmrokCBnA==
X-CSE-MsgGUID: rZnCR3M8SN++dYiFqE/PWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; d="scan'208";a="255075984"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 22:29:50 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 22:29:49 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 24 Mar 2026 22:29:49 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 24 Mar 2026 22:29:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/0HWaGDaAjSJSi9WDc+hw24AEXQXcqZMTBHaH4/ojV3siZbOY5ocLaPdn38ibeKirmPfgcMiB8e+faDS5vWmBYFXIdHqpMf/D+pRTe6HX86K1v50IyyC+BWVRlMsvVeLjPrQSXixy2Qm7J3EO09StJfyamR8bqlO4C8kPVAQdKX/oJWCzdG7L/0kKPIYAnJp9IHEdDKhGL1TTSG7HATvjVIKwyHXWCfmskqk50TTgTG/y7DvBajrgHHIbhTFSZCtFML/hW8kFtdPMgOH9mgu8BzkyeTFEg7/ms9zcxL/1Gk5g8mPuwDMQFbYI/I+GTGA/2Y6jUPjdUAX6irfmtNsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGfGABRE5Awm9fwrXqXR+cE9ZBHcWYgye/YfH/Hf2r4=;
 b=IR20alEwVjOj7i6C+189d5tlTcajUfALQabeiAz1FT7VaKjXWeAHK3GFoylCTwtkgwTADxBBCyoxtpWkVNcHJkm5deqP/CUACXEGrmUhAFZIcS2MXDlEAXo6t/NQROLIjvMe4oRJ2cHMfCJDxyneVJej6d49jm1mby23e695xCs2zycuIOJdPlc8ky5WxBWheRKIrR+gb82gOuXdvfSfYGgR45jCsClYVH0poVzkZc+AtCz1XD16OEqOHRNl13T2y4A5q7eYKDjrMCXHNAUpKuvClzUobdwwm8kNAxiljHVevtFyJyZK2bsFfUVoa+OQ1BSn0qaEa48ZX+pCIC4OuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SA1PR11MB7015.namprd11.prod.outlook.com (2603:10b6:806:2b8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 05:29:46 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 05:29:45 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v12 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v12 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHct2CA3PoU5m7UCkOD5oPtmDIfc7W9baeAgACyxqA=
Date: Wed, 25 Mar 2026 05:29:45 +0000
Message-ID: <IA0PR11MB71851291496AF53CF79309DAF849A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260319052023.2088685-1-vivek.kasireddy@intel.com>
 <20260319052023.2088685-11-vivek.kasireddy@intel.com>
 <6af4e73c-4ad5-4684-9982-04276b6b7daa@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <6af4e73c-4ad5-4684-9982-04276b6b7daa@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SA1PR11MB7015:EE_
x-ms-office365-filtering-correlation-id: 237a6067-f387-4c72-96c0-08de8a2f866a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: z0+qOb+GcDs8Tfx031lnBZf5Tj6S/fYRZkVWHH05UTbRU+DDeQlLUeesbP17ETlTd4sroXcFjc3UqfwHp/IsrsJMG0fwKp50hKxOJtlkObBM1tDckjaqLwq9AjMobburpmUhptR1C4MC7wCz8RAFnW1Ts7JSqoML99w4z7VYvfbI5WGZmKEDK4q2vxVUL5PVaCVqRcdpfeN7+9oWggbAg3ToBNHot78EuDP5TeOIpS9hB6Wg64Z+n1lp6HOY9/CtDJFL/pu8LfpTIGMVb+E+bFlMNhMyPBgas7mXeyfdWU0b6pl+kKSVuQWyIUuwW+N+5zs37ZjQm6/HINBimP+zxgsCuzQz5nmEAWbYHlaOSWQPdCzK84/RcPt0qaX+TI/PpLX+NnbxC6/ghkdel6tk3kws441VNDiL4I9brPtdWHt6K4+8ZA8fy1egwEXcS/IAZ3l0MdpItokQ6Fq5qvFyNYALkxgq0R1JuJeXZTrpDKZigj46xJNYBrFVU4G/Zm2u9PWoxce3W1n2UZ+mFUZ8HHLW5zhR9eH6WRvYIMBvljQnE5zPOfmRRZLaTH8qMwcTaErb7R1EV05YDrnpOlJwIf2LUlp5A8rltHlpxs/I/f2cW2L8i82i76P6vqNLoTq01VTvedrTI6zS+BjbIZ/ZQYT+HtkEpQvwIjdmW38Bvia3mSgC+FcZp5555FlS1TREsCYU09yNiqBB51WHgAXG6lPyKMS1vcrXFm93tcydt0JJi+jghpVxsVoSajaCbxgrqEfGCdKA1krY+8if3zGagUVRyePgur143mMqyTPdDdE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DDPLZpMoZaCOyZxHIAST/IRpYyxW9ACpl9TomLdiUxUAv5HOosy7Jvmkde?=
 =?iso-8859-1?Q?X92MhJHKhi773FUnz18+4Y+kVphX9EYQ1vghlMN5LV0hPtJdLSmTPj1K6O?=
 =?iso-8859-1?Q?dZoNtzDn9p/92rv++0FbwjUkCqe6d7EP8gQmvWk/7lCGubPy0TsBpNb126?=
 =?iso-8859-1?Q?Dv780StV+RjuGHP5gfMc2OQz/uy9ePeVRaywkA1+LBb9PRvMBDFyfzZIdt?=
 =?iso-8859-1?Q?pqjTUFvhYP+2NfscxG9IDzpaEAFCYEUDTkYAD0BzGo8u+cMZBtI3DttGC4?=
 =?iso-8859-1?Q?WTBpWn7ANH8++E8PSPSJwofhZQZ0zo+aVjOw/336cAc0ts8/8OG6sZN8R1?=
 =?iso-8859-1?Q?b6wAkhMiNFWWW9SwkgaKqKjCaTzTg4LySWibiKcYnBerw/JIQpySRu5h81?=
 =?iso-8859-1?Q?OTfBgyS6zFwdLfzgmM2a6NWdCbsYXsjsZDIyyfl8aJLQmRKJcfHYhrz/SO?=
 =?iso-8859-1?Q?4p7iuIjnlA+DtX8lcNeL+x5vd2vqi9DXli3ANh4AGMjrIwghRKFrSQLIiR?=
 =?iso-8859-1?Q?fWPbHJ3wwF0RJKhzluxXBF1MmhIWzR0zR/Y10Qt/aavXg6X95TBTTm+MSj?=
 =?iso-8859-1?Q?7QwIGV+k33s2Db3C9slkGWRCjcM+hVjCoo65UhLpKyP9AOmNXavuJadgPp?=
 =?iso-8859-1?Q?lUETR204dY73QMVDfWGLy8SqLxsrh+8t966rD8eUqUZUgwYX4zo9b8fg60?=
 =?iso-8859-1?Q?1gpxNzCBMlzQdDaJTjmo0psT8iqV79hV2Upme0gFaglfyvsLQX4pGIheMO?=
 =?iso-8859-1?Q?dVi6vv5loP//Lmqv1CE3/tBFDrFSechNIXX4to4FclPKJdlBgTw/T1/YeJ?=
 =?iso-8859-1?Q?ymEmCOLt+F6At8QsCqFMtgbkEacVc3z+OtNWyFwjxuulCj5vklhcNK4kLh?=
 =?iso-8859-1?Q?i/CilyYejUe4abZdqMWBHTzQU9syP2sH81VSviDCL6y+HFW/R9Coa5Z+Z1?=
 =?iso-8859-1?Q?I1PIhgjn3/1CwBYSxe3R57k+l0kJJmMwoHpNqpih8Xw7Y09Sl/Gtyxzr1q?=
 =?iso-8859-1?Q?gRMZIzYudeSATsWw/SR6j4xF/YYb90M8q7+LKbr5iDkiByLgnhXQc+rMje?=
 =?iso-8859-1?Q?ogwLaHRUJ5fuoudBKsM4FQyKGg+zF6eZbtuOnPmnebUyv6M+lDJZzD+2V/?=
 =?iso-8859-1?Q?SaVMeHXG9Kaad+cGjsS4imuNMUj3KNgTna7kLA8BlGQcwAjiBYo6oQWFKz?=
 =?iso-8859-1?Q?wcSDYJgjBx8GtJ53n+/vVHohYT+kZxJtPG5xkdxxIqyShg4nNUUMsy2lCD?=
 =?iso-8859-1?Q?XZDLO7z77QOixjmyiGqb/vIBkHMAzIZWaGgSTEVspkTQkJlq1VNQhYu6Rt?=
 =?iso-8859-1?Q?iWcFZCe8xf0svVycnFdAkoRS65xSh7JXHnDxSPT7w0Qx4f5KOfI0UK3Com?=
 =?iso-8859-1?Q?iktCLctsgOuClo5uE/zrAYnaRIpt2Id3sOsTqT5E8s3glGdutvhhD9L4AL?=
 =?iso-8859-1?Q?5OUW063HMlMUIR0ZdSgqcgo8BRPoqrq3mH25lREtLPFI7X87rHNmhKpe5S?=
 =?iso-8859-1?Q?bOxMiItHtTSnLtd4kMrFKGTE2SVqpF8IDO2Ya6rBgSS1E/d3wZLxJP8AeB?=
 =?iso-8859-1?Q?3n56ZH6wrqAixd/t6q5VSCJYA39A2aHztb0AsVgG8M7MgNQY2nolEagYmd?=
 =?iso-8859-1?Q?tzpWf1bntOVNISZvE1YD/o/yqqydlOCGuAoFRBLqnzPEJHCqQNgHmeFpN0?=
 =?iso-8859-1?Q?RigYQNW8ctB4XfR2+LnRj16VSjVAv9UXfignz6HvmEzqWrRo9wpP/rbDdm?=
 =?iso-8859-1?Q?+4b/BVmYW/rMIt2aumhPJ09Pf2dsrAsAThBjMzRlswNWT2vUZNbynh56dg?=
 =?iso-8859-1?Q?hFsJhR6kew=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rVrqMn6dBMChOy1aIPWzimkvxjSwv6olbS5ixI2gQDRneJW6UTpobKLP/4rjy2A7bd22A8VCThM1UXkK80u60DwrXMUrPTHOHNHAEa/3z5NUruzYi0vJgBZ4Ck2gsUr2gjB/frpzRiDtSy+2C7CUzEsXE3zWL06Y312swjandJO8dACsqXxbQemcXaWkprIG37HoZvOv/upWSEI6Z8ZGHSKg0qHSR95yPsSdz6FaWOyG5v8BshiamOWoG8gi8p+ki+iwDMhcMIoGpyDQ/bWkAs2vWQ4kNFcvDeF50KJABVKiYJVnVIoIv8zAEcuqWqK8OibikMv+2l9MbUDD1bDIiQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 237a6067-f387-4c72-96c0-08de8a2f866a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 05:29:45.6180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HNgIxk22ghEVvjNPc8dfCOsCVHRWvyZnErf8mOipT1WiNyCCmBq8lMZVTI5dwQYjADqSPO8sPNI9siGpeQtd2bY6WJAyq0mRwd63GPMOwrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7015
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
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

> Subject: Re: [PATCH v12 10/10] virtio-gpu-dmabuf: Create dmabuf for
> blobs associated with VFIO devices
>=20
> On 2026/03/19 14:15, Vivek Kasireddy wrote:
> > In addition to memfd, a blob resource can also have its backing
> > storage in a VFIO device region. Since, there is no effective way
> > to determine where the backing storage is located, we first try to
> > create a dmabuf assuming it is in memfd. If that fails, we try to
> > create a dmabuf assuming it is in VFIO device region.
> >
> > So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> > backing storage is located in a memfd or not. If it is not, we invoke
> > the vfio_device_create_dmabuf_fd() API which identifies the right
> > VFIO device and eventually creates a dmabuf fd.
> >
> > Note that, for mmapping the dmabuf, we directly call mmap() if the
> > dmabuf fd was created via virtio_gpu_create_udmabuf() since we
> know
> > that the udmabuf driver supports mmap(). However, if the dmabuf
> was
> > created via vfio_device_create_dmabuf_fd(), we use the
> > vfio_device_mmap_dmabuf() API to get a mapping for the dmabuf.
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu-dmabuf.c | 23 ++++++++++++++++++++---
> >   1 file changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> dmabuf.c
> > index 89aa487654..f953db0fbe 100644
> > --- a/hw/display/virtio-gpu-dmabuf.c
> > +++ b/hw/display/virtio-gpu-dmabuf.c
> > @@ -147,9 +147,26 @@ void virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >           if (res->dmabuf_fd =3D=3D
> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> >               error_free_or_abort(&local_err);
> >
> > -            qemu_log_mask(LOG_GUEST_ERROR,
> > -                          "Cannot create dmabuf: incompatible memory\n=
");
> > -            return;
> > +            res->dmabuf_fd =3D vfio_device_create_dmabuf_fd(res->iov,
> > +                                                          res->iov_cnt=
,
> > +                                                          res->blob_si=
ze,
>=20
> The correspondence between (iov, iov_cnt) and blob_size is more of a
> internal concern of virtio-gpu, not of VFIO. This parameter is better
> removed from vfio_device_create_dmabuf_fd() and
> vfio_device_mmap_dmabuf().
I don't disagree. So, should we add the following check in
virtio_gpu_init_dmabuf() or somewhere?
if (iov_size(iov, iov_cnt) !=3D blob_size)

Thanks,
Vivek
>=20
> Regards,
> Akihiko Odaki
>=20
> > +                                                          &local_err);
> > +            if (res->dmabuf_fd =3D=3D
> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> > +                error_free_or_abort(&local_err);
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              "Cannot create dmabuf: incompatible memo=
ry\n");
> > +                return;
> > +            }
> > +
> > +            if (res->dmabuf_fd >=3D 0) {
> > +                pdata =3D vfio_device_mmap_dmabuf(res->iov, res->iov_c=
nt,
> > +                                                res->blob_size, &local=
_err);
> > +                if (!pdata) {
> > +                    virtio_gpu_destroy_dmabuf(res);
> > +                }
> > +            } else {
> > +                res->dmabuf_fd =3D -1;
> > +            }
> >           } else if (res->dmabuf_fd >=3D 0) {
> >               pdata =3D virtio_gpu_remap_dmabuf(res, &local_err);
> >               if (!pdata) {


