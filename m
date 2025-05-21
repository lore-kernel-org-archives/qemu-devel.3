Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B57CC3DA6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 03:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHZtj-0004Q7-KG; Tue, 20 May 2025 23:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHZth-0004PA-Cs
 for qemu-devel@nongnu.org; Tue, 20 May 2025 23:13:37 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHZtf-0005A9-2H
 for qemu-devel@nongnu.org; Tue, 20 May 2025 23:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747797215; x=1779333215;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rl52TFSsEgSrs9bdeSX0aEQPE6rh8E8GOwW2i1RowL0=;
 b=KbGySNh9M/s07jEoSG1wVADQ5sHrLK0C1/Hpe1rqpptLE7rsYXaI3W13
 i5fFknI7fO8tKrtk8AeLCpnY67+gtn3tLH6tsXshuRRe5kQ7+qa/U090m
 PzvSvUhidnaqdhmDN0ymbUi2IhsfSwbPrLcwJFeTi8a79D6F9OUNK9EOb
 ldKb6CCwww+uN69b0S+xgbBCXJGfEDr46Q6tfUrlg8BMnZMVUlzBfs2yr
 PL6H7MpqBHt3C4qmCMLMRwKAL25bCxJyx70w5oXco3m685D6q0Vzq7TgP
 JQVLKZuzhnTJmlsFPCpkHhbsmfSmQIVXD0rbsYit/YfeOdG9YlusrqF8b Q==;
X-CSE-ConnectionGUID: ME25DsvTQ/mhmZjXxM8TJQ==
X-CSE-MsgGUID: oGa+ZXSOSQidoFyoVMaj+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="61155987"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="61155987"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 20:13:32 -0700
X-CSE-ConnectionGUID: jWRR1F3tSxiD7yKYtQd1Lw==
X-CSE-MsgGUID: toylY7HjRE+4GnAxtrJUvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="144764163"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2025 20:13:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 20 May 2025 20:13:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 20 May 2025 20:13:30 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 20 May 2025 20:13:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRkW2y3M+4U1enhBWjgMmHYUATHZFTCEKyH3DnvAkXV3vEBGhdZ67JwhL7xyLrG59E9P+FEkISg/kQhhm0TRaDcRMVfKMPFO3J8/ZXQre6EQDRY/DoNqaqwwA+rUEa7G5Sn1FhdGVXIlLqSKuhMozjLobaSPj2k8AYukij2DX0V54PXpFvhtp4sNgGx8pVYa5uwOuM6PsMTLerOU7BiKrYCL+a1qivAgmRXd9UGJdzdZkQ874Zg9qjRHLBM1mVWxMVPCVhzDsOQtuGAZy7ViMWqX7b78cW7Cbk4ql+CClcm0ph/RMWN/1Mig2e1d6Q6bmT7qdEN1WVBG5gbhGveG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QY3JG5WV248zPwkXOkR0uiuyVKJ8otGN3zB0KL+ur6I=;
 b=FompbsLmDd3u/pR7j2a7i76S/G5pXa7GzsQ4UjZAbaqBUdVu0XIvpxcR2dLRDaY9+Ompyi3kZ3MXYDH7Fsjj3yi5fMVXqcP/dBs6QGfSW/mJgNvY9i6M71zgB53Eyj5vCYSARRNKeLv+BDOHAM1w9GjWhBg9deCtM/gaC2GjIzZaL18aeCFpoTJWazl1Yuv8DxZyItUJmLEz5aPT58up2RZhgkIK1RnkBf+p1nXT0qbpRj+lsoem4/zBv3imAB08/ORm3vXionMYC9SNtNoEK3ryp8bbpHYH0Yi/WsHWo+KQk0MvA4Lzd3/ioNU4iWqLARe2j0N0vWaTvGXjlEk2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB6742.namprd11.prod.outlook.com (2603:10b6:a03:47b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 03:13:13 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 03:13:13 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steven Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 31/42] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
Thread-Topic: [PATCH V3 31/42] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
Thread-Index: AQHbw1NeOM38BEFik0GyWuV7ydnDA7PU95jggAUtroCAAdHCAIAAdU7A
Date: Wed, 21 May 2025 03:13:13 +0000
Message-ID: <SJ0PR11MB6744F883C3FF82AE28E34B43929EA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-32-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744E4675DF4622F4414F5B49293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <bed13219-6c24-4f51-86d2-923909d5b18e@oracle.com>
 <1090e1fb-8ab1-41d4-8e9f-36559dd880cf@oracle.com>
In-Reply-To: <1090e1fb-8ab1-41d4-8e9f-36559dd880cf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB6742:EE_
x-ms-office365-filtering-correlation-id: 42dfae85-d400-4140-8150-08dd98156c7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?eXYA1eKWOqiIXCFhc335AFPgn2Gt4uApqGyYB8mQBMbx2SAnxppYyThaPn?=
 =?iso-8859-1?Q?WYBqPRv/VT8zVO2mZSS50tdHY/8lPBYPi/iQ2coafJX09WicLVfQXnZhUa?=
 =?iso-8859-1?Q?fXhljBF4ahcn8NXj7SfsH1N6/4vJlCcetQkIiuwEp3mJ5Y/2O3gdKjwQ6u?=
 =?iso-8859-1?Q?qtML6+xoIkvwsoIEd1rKs9J4quLKg3UxG0s0X0W1lFhxT5wopmg/QyD+GP?=
 =?iso-8859-1?Q?QQ2qZe0OwL+iIDQ6+GN9NGPoBBBv8GwFrG0WCYKj6tT5djEpokYPQmlbuc?=
 =?iso-8859-1?Q?I2tt9/G3FCqMpPa/PrS1K8xYT3iK8LaCb7u/GhDRXQODTjsKmhFUDdVUbo?=
 =?iso-8859-1?Q?gHsoNDmomTg/pomivOwf+o2mofVGYRAY3CruQWwQFIZXWvgYQwE+AS6qbP?=
 =?iso-8859-1?Q?nmr8MWWYzD3uKot6oIvttWOCgqfJ9SmvOMzSXwXOrjfQXCXFDMqWDqrDUC?=
 =?iso-8859-1?Q?xqjHprigzJc4+T3jxFyw2eiyDz3lpYZHjNvCblh5rF1t8SU4x89koBYWck?=
 =?iso-8859-1?Q?xCVXsQc6yn23cZePWKafzNlkbacsS+rqsOs+t5R4NnVYTF53segU9A74Wf?=
 =?iso-8859-1?Q?NHM6I9alvdo+2o0/Ri1MmVtSLl9qFOA54UJBpIQAvmSSe1+M22b4YQYsZQ?=
 =?iso-8859-1?Q?Daoqjo/WtNuCQXZFEjVm/FQdW3m/FoXKUb3pmu238rYsWbB3/jDxHs8Pzj?=
 =?iso-8859-1?Q?oErl/PUkyqcgPcXSrjCmLWeF5oENu1mvsiAR9B2aoQzti14vmFR9Sm0Pn5?=
 =?iso-8859-1?Q?k8cDgsa0nuA9a4oSMYvNJruB6f9DytId9pCwu6RTmK9PkL1eqHE612bovj?=
 =?iso-8859-1?Q?WtfJHNtriPD9vn8D6/yo4Anwj6sJeHzhRV5j/IyrvFpN49wEyZLzMDWvt0?=
 =?iso-8859-1?Q?ZsfFSlXjrrkuas2m/WoHASu2QxwMZrUZFdcDJV9ijbikww2EZzqRVAYlP7?=
 =?iso-8859-1?Q?o6OF29UzmhNNUWizyuLltMUAxasXN0Fe/D+aY75hdbdmu2kJKjdqTbV7j1?=
 =?iso-8859-1?Q?s+l8oejoTiOt6POMoRLguWknVBFHF/LkeyZFcs7WWlk7EBTHry6x/9tX4r?=
 =?iso-8859-1?Q?DhWSkBlt+sjnjVgAz681kYl/EelaCZR04Mo7av9W//WCbR49eq0QWj22Rm?=
 =?iso-8859-1?Q?Id6GFsu9ZHW4xaFPAHeA9SPrW5UDHuSBkMSPussiSNy+oqBSnUQUrbPJWF?=
 =?iso-8859-1?Q?r13hFXPw0tAscrYbkGkci4J41chR165pcJU2+Inj5aiERox6AcOpIIedZe?=
 =?iso-8859-1?Q?lWW51tPU2JF6Ua/OH9qKxn4qPgs/KL5RmBctnVBv6uPVnM5rw+dtuXeTjl?=
 =?iso-8859-1?Q?TEkI/rebEjukyww6wofPRma/qMpY+2JcEZnIcPnfE33uDxLcs74bh/hny5?=
 =?iso-8859-1?Q?edJbObFrrGtKPAFtBHnOpu8DfhDAFCd2Jdf1TuSd3na2kWCF00cV9yyaKv?=
 =?iso-8859-1?Q?uBi0n2xwTWLB2N3bfp1B54ma4TrpsK8t5OmfOS45BgI/KewcWwRiDpFRs5?=
 =?iso-8859-1?Q?wbkw+hUKsIoeaSjN94t3vFy4mKWluuYMAYgmaaKDt6PQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eefnj8tWx9Q5kjqgUx4H5PsLjpBFKL3WDAWEmRPAg4kSjghBTUdEZ+vnb0?=
 =?iso-8859-1?Q?N3r0J+DmfzZtnzqXJFUYbucZLza4Dt50qcR6Mv5D1dho9ni8g6/vxAXVwk?=
 =?iso-8859-1?Q?YoQCvczl0zKWG9lBPbSoc5AVIQ1HeO1re83InQ2l5gJhb6tS5O7jjvCuS8?=
 =?iso-8859-1?Q?Adpi/KcUfYDurCccUWs1k+qQJ22i0jDdyHEREJLKC2jmOzoWntKjqSBgS4?=
 =?iso-8859-1?Q?D9ZQ13gKXIgEh2jmVQtlyfQl3Wa09StcPylvM7+3QBUp/jMtnAumtngkLI?=
 =?iso-8859-1?Q?2Zhjaccd0bTwMJJorH/KPABytv4Yz3b8HqMptUpm0gf084wzn0P5ymrNqL?=
 =?iso-8859-1?Q?hCPbCvErxYusXrht1JjumzPG0/LpNCDqaeL5YqPKA7MbPalmknT3ECyPnk?=
 =?iso-8859-1?Q?TGFW42jgwVxD3IdH56ayTWwqZOTdmHgKIv8d+z9z1N7zsGX99W6gSCU1O0?=
 =?iso-8859-1?Q?sChjhlyKNSn7ZFus6btWymvZZKauxYNvqhS3VYGVY4Zqy9L3b4T/xJ0wxj?=
 =?iso-8859-1?Q?7nHTDld35qEhrr8asKRvdbt0B6zz4YDyItBLxFKWsBUZj/eb3ybiYAAwYM?=
 =?iso-8859-1?Q?JKzPvbQI0MOT0vbB0Y2QDH5ZR0dx1rj5ZWeRkef/AI0KTGoHUTHP4QJK4f?=
 =?iso-8859-1?Q?qcsozcm6wKuchxk4YJXAreJRMtFUxcWk4SaFZFZYoQ7CUD9/ye0TNiLvhk?=
 =?iso-8859-1?Q?1rBKBC2AlnW/PxiZx18MqpYIIbdyHYROJQ++VnnPp6a/7OSNfrj6jaIM2l?=
 =?iso-8859-1?Q?bny1eQHTT7tL2jNKC3BagxAJyl5ou9wt1LyYXE1iHgJAs6hsVeokR7QFgX?=
 =?iso-8859-1?Q?W5jm5xF8gO2A35yIpm9oI6rcxcT4pMkrHteVh0cTSQNTKe9pId3++ip6HT?=
 =?iso-8859-1?Q?7YEGvtfOuLtPymxgG8qMY4YUTq8HzNcve5CDhGmfevHfO4LJ0RQYGNWrAj?=
 =?iso-8859-1?Q?DU82XUdL5J0VHUyk8ehIIIA0eP85HFxoIS1W+fPoduVIqCsryJ41OvRHMT?=
 =?iso-8859-1?Q?75NgP94ONtY1l3gF5axo6AhzftQgAu6eERyaZuDYfvHlQVK7WZJT2/zJ98?=
 =?iso-8859-1?Q?ZYdj56g/UmwItRijtSou7LbbB72h4eXmKv6nckLEGSYHBlxdqFfMINIST3?=
 =?iso-8859-1?Q?G4lDhj1+JE3N/Q+hPLlpVGJ+037LvNnsoCbX2Nc/N0Z98YqCPxaVVfKF2I?=
 =?iso-8859-1?Q?ZMGVhEa/FhKZ4cocAwmvStRLm5TaaF6aIfauIG0DmFbz7QYJRf/HKGniNP?=
 =?iso-8859-1?Q?dMLn+Uj6C9FrD0oWAFXn3vOYLf50E9X2+YkLb0EOHGdiIc5ad6pMgeZPP/?=
 =?iso-8859-1?Q?YSTN5r28Nf2VyfgQAuIcL7MuNY0Pq5XX8FiJHz9YJ7/+JNgE943SBwaWeX?=
 =?iso-8859-1?Q?MgbZ9EFbMG2YibH+uxukmlUpTUraPMHTAWINgqvviKuBraHAo279Uvgzzc?=
 =?iso-8859-1?Q?yorhVaMwBqThiy+p8Zr5HQzknnUeWqus+DtKLO0F5CPw2AyG2MQGfYBzQG?=
 =?iso-8859-1?Q?Vi7OJwENyOcqHW+jExngwzm/96izJuamJuJOUgOhz+zYJcspTnNpLaSw9T?=
 =?iso-8859-1?Q?1/douwSoVbtSjJnTlf0UIBiITpYck5LaeKwMgt8bE5GdkSGGwnslZj8BXW?=
 =?iso-8859-1?Q?ZyoK6KjK04JgWCPvy1eBS79pLRPa3fKVYE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42dfae85-d400-4140-8150-08dd98156c7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 03:13:13.7936 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WEucqqRFyw1TMqsXAD1yDahB8axuvTMgee8PtQ4696KCfwqKNb1rrTaci3UpCc+8l+NdiGnAFch4bap1aB5cdjiAg0p/zHfB9hD/l3ZU9RY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6742
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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



>-----Original Message-----
>From: Steven Sistare <steven.sistare@oracle.com>
>Subject: Re: [PATCH V3 31/42] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
>
>On 5/19/2025 11:52 AM, Steven Sistare wrote:
>> On 5/16/2025 4:48 AM, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>> Subject: [PATCH V3 31/42] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
>>>>
>>>> Use IOMMU_IOAS_MAP_FILE when the mapped region is backed by a file.
>>>> Such a mapping can be preserved without modification during CPR,
>>>> because it depends on the file's address space, which does not change,
>>>> rather than on the process's address space, which does change.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>> hw/vfio/container-base.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 9=
 +++++++++
>>>> hw/vfio/iommufd.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 | 13 +++++++++++++
>>>> include/hw/vfio/vfio-container-base.h |=A0 3 +++
>>>> 3 files changed, 25 insertions(+)
>>>>
>>>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>>>> index 8f43bc8..72a51a6 100644
>>>> --- a/hw/vfio/container-base.c
>>>> +++ b/hw/vfio/container-base.c
>>>> @@ -79,7 +79,16 @@ int vfio_container_dma_map(VFIOContainerBase
>>>> *bcontainer,
>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 RAMBlock *rb)
>>>> {
>>>> =A0=A0=A0=A0 VFIOIOMMUClass *vioc =3D VFIO_IOMMU_GET_CLASS(bcontainer)=
;
>>>> +=A0=A0=A0 int mfd =3D rb ? qemu_ram_get_fd(rb) : -1;
>>>>
>>>> +=A0=A0=A0 if (mfd >=3D 0 && vioc->dma_map_file) {
>>>> +=A0=A0=A0=A0=A0=A0=A0 unsigned long start =3D vaddr - qemu_ram_get_ho=
st_addr(rb);
>>>> +=A0=A0=A0=A0=A0=A0=A0 unsigned long offset =3D qemu_ram_get_fd_offset=
(rb);
>>>> +
>>>> +=A0=A0=A0=A0=A0=A0=A0 vioc->dma_map_file(bcontainer, iova, size, mfd,=
 start + offset,
>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 readonly);
>>>
>>> Shouldn't we return result to call site?
>>
>> Yes!=A0 Good catch, thanks.
>
>With that simple fix:
>   return vioc->dma_map_file(...)
>can I add your RB?
Yes,

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

