Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A44FD461F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 06:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvUi1-0003gN-PC; Thu, 26 Feb 2026 01:18:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vvUhy-0003g9-Ti
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 01:18:46 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vvUhu-0006iq-GM
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 01:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772086722; x=1803622722;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=t941uabewE7uHpm1XrY/HnttuEe2uAU8gnGP7m3Mbg8=;
 b=Y/iZGTjlf5PsHatbNnekOwEhVnKTnKWD7Kdc6pI+wDimwvA+qp6+Ky4l
 5ArfRqsmzrvBeqnacvghNE6/VA6Gk+ahi9Z/SdLD37POl7Yr/Pf4Z6Gw9
 8+Gd7ZfNCoHrcsyGG+FK2LkEkHHdea6iQX50cQ6wWbWe2c3ETpqlkMcIA
 FSzfzVEnVOU+QOr8RCrmCN+WUzq5/NWJXWBoTOSUthRLIJeySl0zRaeNq
 QU0xWCP9Odt7MUav6btxTfHjrK0xtoCsJ0gp6R2B8ClyQceL3kLZMCBGO
 zaLLZ3h2yvQnuxW0PJlljIodLPvJi+NIWEAMZWeN0kDcfpJG2UirM9Ga8 A==;
X-CSE-ConnectionGUID: 5RyzhLFISlmLEz+U9YxmSA==
X-CSE-MsgGUID: W6cspG45TbydndSmgAJwAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="75744086"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208";a="75744086"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 22:18:36 -0800
X-CSE-ConnectionGUID: rozgHRP/QSWg3KQcds2MSA==
X-CSE-MsgGUID: g0rxgg7ARSio+rqDIUWIuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208";a="216358420"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 22:18:36 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Feb 2026 22:18:35 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Feb 2026 22:18:35 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.37) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 22:18:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrwDDPRUYL3uncBHLF4QHrdhCKT4yFVDXDpo62mChmpHZ1E+TKs3+N5Ymj9iiG3SFmcMWQkwcoIpexDaZT3awhnOIqwbw+zze3jzuLyBubbwCwNB97rVOr3dy4O6KvEepM+yeZytbh6iiEYSy0U/S8tmalb82vEZrQE9nVuNaKIB7w0i1p04KPetXke1lPNwRMG4Xep4GvCIMJQs+7gCuVme6mxbK6k8no8fHThfB+Q65kuNyXx5FafH9XCUVNn2WZvGqz8NknCXCIv3GqNS4eyeovojYAu8OQn43HIAfX91tgkiNtgsyYTPo4tWXrbpL7y42Sf+NEhPyvxQJo1PpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFnsrFgj6jHX4tkvi4wowONPdLzQrwrSlMFicJ/fG5Y=;
 b=FKjrYFKLD+gsqMY6YTxXXhcp58Iz/lRroMHWIOWqHPGy42apHsAhLrxrTmfk/Uuv1obcSIhKrwMy7pxOBgGskQnix/s/muFweqEdt/53GPUbYAUGF8tuHOHeyZ9nmR1dbSzUF9O/lhjKCCOVEmrLDvyDw0dOLQYmsb2Jw1Swt/o2DS25jEAUR+NyIRinKa9Pf1bch0AGWWahIOINAP4ClU2QAJg3Cd1AwS7vj7MeXxJEDqYapqq0BOvLHE4Xs6hnF993FkAXdXhFuUoLJ9Bh7zH8NzHg06HJI3gUEB+mgWA0mlhpKjk0R9Ah3z229yraItC/r0nrqBlHYR33eAbh/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SJ2PR11MB8471.namprd11.prod.outlook.com (2603:10b6:a03:578::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 06:18:29 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 06:18:29 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v7 06/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Topic: [PATCH v7 06/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Index: AQHcpJsNU38pqXozyUy3FaU5XrOP87WROn0AgAEu9BCAAI7CAIABEvsQ
Date: Thu, 26 Feb 2026 06:18:28 +0000
Message-ID: <IA0PR11MB7185E8BDBFB0997CDA82A9F9F872A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260223080200.468558-1-vivek.kasireddy@intel.com>
 <20260223080200.468558-7-vivek.kasireddy@intel.com>
 <829317cc-551b-457d-a27f-9db0fc749c52@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB718522807D0371785F93337CF875A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <4581f48a-5cc0-4584-a01d-0615c3bd5a71@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <4581f48a-5cc0-4584-a01d-0615c3bd5a71@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SJ2PR11MB8471:EE_
x-ms-office365-filtering-correlation-id: 4dec3936-7d03-4f1b-355d-08de74fedbc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 6rdVTUCXENoCm9MnNuEapLberIBPWQtRISUniiWHqQmoHSPlzj4mgXxg9DRynsuzXqQJytvSzt1LWfv9PLHOjQKrlUH5w4wYUYitfTqNSppk5N+2jjkUInlt0R/ABa/C0FSaTk2y1eRhhfuuySN6LvsMEQgYfd/azrT162WfAWz0hABIrV/9sX5WlVuMbf/AQ6drQHcvkGFe+TiATtwHWuCn4PfzhQN87HNKSU3ODOWULbZkJeFqd7IJ63ca96++KwbsVD0FHbBwgFD14d5nV5I3zs83dbCW4Apcxsnhyll/Zk1/JNp2gJfqC1ekTE/AlFQ722oXhppvYEJIZpksQAz8tlvgQPQBo9h8St8VL1lgtz4SpFV32BsE7gXHygF98o2AHMT2Q4x76l+ED12MiRDhIjYABqenANGJGVYxD6Xgqlbxs9Q5BcByaheUpJizGjG03h5y+aSYB2utcoEaz3pkwRXNWgduPHvfgd+VsI6/yKY1eKpvE2nlDbYDsIizP3vrmF9dWqmc+BfLktF89wXBdbanPcOrFyYTcJ3mGGxO3GddkXc0SmcurZHozWEVqWyWqn2tF3ew8SDaiEZqFNUFdmbD9JKtmQPR5qFfVVncbEgiv8A4ZKmlTwY+7PpG0csjFdMiIGBaDCrua4z9eJmhc1tIEpJsY2mpNvKITyJ3SWjEr6mK6+GOp9IaW0pZhndPnHMG5rpAasmTM80IVRaD5PzmpKXY2dx3ZSk1GLLFniKWzTgrLLr4ehu4dC0bul8NCcLXcNg0NDuabILYQ69CN7+mNuZRyk/cbhVxLFs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CkoLcmmFc7vTR2XbREqljPN45/harXsPElhuKA/dU7p3AVVnqHOeA5oa6b?=
 =?iso-8859-1?Q?0AWvAHApokWmNmvMbynchhwqp0Ffudl3iV/BkyAT60hwbSH1O6GUGtz+Aj?=
 =?iso-8859-1?Q?bT+RXWkJ9s9Y6zkSW3o1kFWpkuNBS++0hynePYBT9R/eOaK1/kykEH7aQl?=
 =?iso-8859-1?Q?pnQmoaY3CIz0ciftnZ92sCkoY/aJoYiCn7D9sZFDfFW1ikCiV/rdlBnpMj?=
 =?iso-8859-1?Q?7vzRiB85ekkRtaIIeZGyd47okvKfLxSfpGNlFXaLkNhMQkPX1csT+3Kowx?=
 =?iso-8859-1?Q?v7cu1zf2bU1SEwdl3VdIbagfufw0Z+9xfdO/m8TfYVV6hUloHjWZiMxO0l?=
 =?iso-8859-1?Q?hp8rfeJqZVSp1EIUz7jD8T5aO6fAwsaRGov/sIm5Frj9CAkF5tJcRzKTjR?=
 =?iso-8859-1?Q?wrSOvF4g6sDnzUOA6+6k63JuwmB93edq5FUDYrwM5FpSEThKzIs8ZvZv5V?=
 =?iso-8859-1?Q?8H/lxL2gcNGmxV/sDKeXHegVKyZnLOLhMoRMRGxTAY84chQ86H/thSWk2H?=
 =?iso-8859-1?Q?nSPpnOCoOwOBLfFcPWLVD0Qp9QYvg7UAvnYGLy8ltwH1PJVMepjKSSNI65?=
 =?iso-8859-1?Q?OZrZFhl0Jpiy+eyclUqJCco0ZThvQ362pWv47OGLED0ODgUPihhRfKNZYw?=
 =?iso-8859-1?Q?nC3K/V8DB+PtpS91q4eQegP4ju0MSUentYLQg39EzTiO4hX34cZQJb5rnd?=
 =?iso-8859-1?Q?6aLqt4LJszrsiA9r81K9JLkBjtPIXQ2hdc7UfDaAlaD2diH9fZHiLB50Pg?=
 =?iso-8859-1?Q?YFKo2fJv6zmwQuuch9vvXw+GPWZep1fdzV5rmIiJ3Uy5o/dHOerouw32/f?=
 =?iso-8859-1?Q?wOY5CMXXbGysRI2e4LAz7bb7rNMLKJ8w0D6lI0M9XIUTLE3hI9I0MM1BCM?=
 =?iso-8859-1?Q?QlPYNFK4Rbe6+505gjk8WbCNZO1qb+ik1mdzi2BTVETBq01bkAd0QTD7Om?=
 =?iso-8859-1?Q?+40OEhEH7JaIgWoYeR2GMs8TBZyfjWcbRfWQKc4iArTEQIGCf/Jz0lzilA?=
 =?iso-8859-1?Q?v/R9qgX5wzNtDKJyB2m988fq8m8MjUwdnhn5SEaSLNd8cDSyKpaLMfbgWR?=
 =?iso-8859-1?Q?mvqUDyHl/aYKE8SRi/2WyiekeN4wGEqOYribCJ4HYojhIjAUs02RB7/kJD?=
 =?iso-8859-1?Q?RhOxMWyOxZNHSgGB/X4RCg947ziTPYcjJqEp7AAcArOz2l+wrTkVyPcTkf?=
 =?iso-8859-1?Q?u00HKVj1NxY4IUFSqPX5MUmR8nWSygf8sDBTTXn2qadWfXySRTNLaJ8TLk?=
 =?iso-8859-1?Q?PbDqw3fKcMSTcvVDYKIgCxK7exi2UKOQVg9j9kKMPzd3QcUH3ZgXnExeq5?=
 =?iso-8859-1?Q?RE1WQLRarPIK1vQds53HtMhOK2+yTed8VsMCnIn9eBuXPLgV86SQpe9dTg?=
 =?iso-8859-1?Q?JDPNVQJSBAjCoSS0rYiOb2qgun+kB3eTgehNMVD9gukDCrnaJMPiCmuGZx?=
 =?iso-8859-1?Q?2x9nro2R12uZLO59zNZ7Qay00krSY4jHYBhkFJpOAiefgj1pBRS8x0O9Gz?=
 =?iso-8859-1?Q?XmMWUhzKD+DQI3nvUG1jhtV/7N5F2U6udTMgxuN4WtVB9jeMleJFxEdbXz?=
 =?iso-8859-1?Q?9337J1NwJN6dk4ZHV5mrF5Z7yrvNlWtWyc3L5OfOxtG1jqqWhvaPaeBbcM?=
 =?iso-8859-1?Q?XQEohyWwQXtl3NAEA94GqM70aJKlukIbsCiIx5T6IzYXVntgbtPP47/SeA?=
 =?iso-8859-1?Q?rd+RrzDhPZNETBfGrEaMH4yud0jY0WVKh6LR9Ho2BAFrCgV7P4uim5We4q?=
 =?iso-8859-1?Q?njucgJ7cyNJsxhp0r8G9jiie6yFFQZGlsuBBYV4j4KLXOQdBEEgEPWL7MK?=
 =?iso-8859-1?Q?lT/GLg81xA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dec3936-7d03-4f1b-355d-08de74fedbc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 06:18:28.9451 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxDte03sYatwX2CAv3u2QuYWF6pmZpdrbvwPsw+hm48f40gc7/go6dRXxwzBwIVPSR3odJZtyachlNXQwhM5zupFX7fSijv5NNwdB7f2+Dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8471
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78, SPF_HELO_NONE=0.001,
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

> Subject: Re: [PATCH v7 06/10] virtio-gpu-dmabuf: Improve error handling
> with 'Error **' and err enum
>=20
> >>
> >> On 2026/02/23 17:00, Vivek Kasireddy wrote:
> >>> Make the error handling more robust in virtio_gpu_init_udmabuf()
> >>> by introducing 'Error **' parameter to capture errors and an enum
> >>> to categorize Guest and Host errors. This allows for better error
> >>> reporting and handling of errors from virtio_gpu_create_udmabuf()
> >>> and virtio_gpu_remap_dmabuf().
> >>>
> >>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> Cc: Alex Williamson <alex@shazbot.org>
> >>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>> ---
> >>>    hw/display/virtio-gpu-dmabuf.c | 65 +++++++++++++++++++++++++-
> --
> >> ------
> >>>    1 file changed, 48 insertions(+), 17 deletions(-)
> >>>
> >>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> >> dmabuf.c
> >>> index 8d67ef7c2a..fdcf8e53a2 100644
> >>> --- a/hw/display/virtio-gpu-dmabuf.c
> >>> +++ b/hw/display/virtio-gpu-dmabuf.c
> >>> @@ -27,7 +27,17 @@
> >>>    #include "standard-headers/linux/udmabuf.h"
> >>>    #include "standard-headers/drm/drm_fourcc.h"
> >>>
> >>> -static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>> +typedef enum VirtIOGPUErrorType {
> >>> +    VIRTIO_GPU_NO_ERROR =3D 0,
> >>> +    /* Guest is responsible for this error */
> >>> +    VIRTIO_GPU_GUEST_ERROR =3D 1,
> >>> +    /* Host is at fault for this error */
> >>> +    VIRTIO_GPU_HOST_ERROR =3D 2,
> >>
> >> include/qapi/error.h says:
> >>   > - Whenever practical, also return a value that indicates success /
> >>   >   failure.  This can make the error checking more concise, and can
> >>   >   avoid useless error object creation and destruction.  Note that
> >>   >   we still have many functions returning void.  We recommend
> >>   >   . bool-valued functions return true on success / false on failur=
e,
> >>   >   . pointer-valued functions return non-null / null pointer, and
> >>   >   . integer-valued functions return non-negative / negative.
> >>
> >> Do what it says. Non-negative if *errp is set. Negative otherwise.
> > Ok, I'll change the values in the following way:
> > typedef enum VirtIOGPUErrorType {
> >      VIRTIO_GPU_NO_ERROR =3D 1,
> >      /* Guest is responsible for this error */
> >      VIRTIO_GPU_GUEST_ERROR =3D -1,
> >      /* Host is at fault for this error */
> >      VIRTIO_GPU_HOST_ERROR =3D -2,
> > } VirtIOGPUErrorType;
> >
> >>
> >>> +} VirtIOGPUErrorType;
> >>> +
> >>> +static VirtIOGPUErrorType
> >>> +virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resource *res,
> >> int *fd,
> >>> +                          Error **errp)
> >>>    {
> >>>        g_autofree struct udmabuf_create_list *list =3D NULL;
> >>>        RAMBlock *rb;
> >>> @@ -36,7 +46,8 @@ static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>
> >>>        udmabuf =3D udmabuf_fd();
> >>>        if (udmabuf < 0) {
> >>> -        return;
> >>> +        error_setg(errp, "udmabuf device not available");
> >>> +        return VIRTIO_GPU_HOST_ERROR;
> >>>        }
> >>>
> >>>        list =3D g_malloc0(sizeof(struct udmabuf_create_list) +
> >>> @@ -45,7 +56,8 @@ static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>        for (i =3D 0; i < res->iov_cnt; i++) {
> >>>            rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, fals=
e,
> >> &offset);
> >>>            if (!rb || rb->fd < 0) {
> >>> -            return;
> >>> +            error_setg(errp, "Could not find valid ramblock");
> >>
> >> It is a valid ramblock even if rb->fd < 0. It is just "incompatible"
> >> with udmabuf.
> > Does "IOV memory address incompatible with udmabuf " sound better?
> >
> >>
> >>> +            return VIRTIO_GPU_GUEST_ERROR;
> >>>            }
> >>>
> >>>            list->list[i].memfd  =3D rb->fd;
> >>> @@ -56,22 +68,30 @@ static void virtio_gpu_create_udmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>        list->count =3D res->iov_cnt;
> >>>        list->flags =3D UDMABUF_FLAGS_CLOEXEC;
> >>>
> >>> -    res->dmabuf_fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> >>> -    if (res->dmabuf_fd < 0) {
> >>> -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> >>> -                    strerror(errno));
> >>> +    *fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> >>> +    if (*fd < 0) {
> >>> +        error_setg_errno(errp, errno, "UDMABUF_CREATE_LIST: ioctl
> >> failed");
> >>> +        if (errno =3D=3D EINVAL || errno =3D=3D EBADFD) {
> >>> +            return VIRTIO_GPU_GUEST_ERROR;
> >>> +        }
> >>> +        return VIRTIO_GPU_HOST_ERROR;
> >>>        }
> >>> +    return VIRTIO_GPU_NO_ERROR;
> >>>    }
> >>>
> >>> -static void virtio_gpu_remap_dmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>> +static bool virtio_gpu_remap_dmabuf(struct
> >> virtio_gpu_simple_resource *res,
> >>> +                                    Error **errp)
> >>>    {
> >>> -    res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> >>> -                         MAP_SHARED, res->dmabuf_fd, 0);
> >>> -    if (res->remapped =3D=3D MAP_FAILED) {
> >>> -        warn_report("%s: dmabuf mmap failed: %s", __func__,
> >>> -                    strerror(errno));
> >>> +    void *map;
> >>> +
> >>> +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> >> res->dmabuf_fd, 0);
> >>> +    if (map =3D=3D MAP_FAILED) {
> >>> +        error_setg_errno(errp, errno, "dmabuf mmap failed");
> >>>            res->remapped =3D NULL;
> >>> +        return false;
> >>>        }
> >>> +    res->remapped =3D map;
> >>> +    return true;
> >>>    }
> >>>
> >>>    static void virtio_gpu_destroy_dmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>> @@ -125,19 +145,30 @@ bool virtio_gpu_have_udmabuf(void)
> >>>
> >>>    void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource
> *res)
> >>>    {
> >>> +    Error *local_err =3D NULL;
> >>> +    VirtIOGPUErrorType err;
> >>>        void *pdata =3D NULL;
> >>> +    int fd;
> >>>
> >>>        res->dmabuf_fd =3D -1;
> >>>        if (res->iov_cnt =3D=3D 1 &&
> >>>            res->iov[0].iov_len < 4096) {
> >>>            pdata =3D res->iov[0].iov_base;
> >>>        } else {
> >>> -        virtio_gpu_create_udmabuf(res);
> >>> -        if (res->dmabuf_fd < 0) {
> >>> +        err =3D virtio_gpu_create_udmabuf(res, &fd, &local_err);
> >>> +        if (err !=3D VIRTIO_GPU_NO_ERROR) {
> >>> +            error_prepend(&local_err, "Cannot create dmabuf: ");
> >>> +            if (err =3D=3D VIRTIO_GPU_GUEST_ERROR) {
> >>> +                qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                              "Cannot create dmabuf: incompatible me=
m\n");
> >>
> >> s/mem/memory/
> >>
> >> The log is not that long so we can have a full correct spelling.
> > It was going over the 80 char limit and I was reluctant to split it
> > across lines.
>=20
> scripts/checkpatch.pl explicitly allows to have a longer line for string
> literals. Priotize the user-visible behavior than keeping the code tidy.
Sounds good. I'll replace mem with memory.

>=20
> >
> >>
> >>> +            }
> >>> +            error_report_err(local_err);
> >>
> >> This prints a message even for a guest error.
> > This is intentional. My thinking is that if the user did not enable log=
ging
> > then it will fail silently in the case of Guest error. So, I thought it=
 makes
> > sense to print an error regardless of the type of error.
>=20
> Do not locally override the behavior of the codebase-wide
> infrastructure. If you think a guest error needs to be logged by
> default, you should make a change to the logging infrastructure.
>=20
> I also think the decision of the logging infrastructure not logging
> guest errors by default makes sense since, if you log guest errors by
> default, it will allow the guest to spam the output and can cause
> security and reliability issues.
Ok, I'll change it such that error_report_err(local_err) is only done in th=
e
case of Host error. And, in the case of Guest error, I plan to just have
error_free(local_err) in addition to invoking qemu_log_mask().

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki
>=20
> >
> > Thanks,
> > Vivek
> >
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>>                return;
> >>>            }
> >>> -        virtio_gpu_remap_dmabuf(res);
> >>> -        if (!res->remapped) {
> >>> +
> >>> +        res->dmabuf_fd =3D fd;
> >>> +        if (!virtio_gpu_remap_dmabuf(res, &local_err)) {
> >>> +            error_report_err(local_err);
> >>>                return;
> >>>            }
> >>>            pdata =3D res->remapped;
> >


