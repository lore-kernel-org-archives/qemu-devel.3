Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BC6CA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 08:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqSZI-00051r-8x; Mon, 25 Aug 2025 04:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uqSZG-00051h-Ql
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 04:28:42 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uqSZB-0001GV-99
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 04:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756110517; x=1787646517;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ASRX2nGow2naCE1qYIMJz1kw3+cznfUrjYQvG4Fi7F4=;
 b=L2VmMHTGivqD/nnGzrrUgl7GbaKCjxA6JLP4lnx8/cS3djJKSM90DnsG
 lWdIBuYTqQ3GKDs6oyhBqjP42lfWAs7WXLTFMTMScHAXKyZGHXqyPHHwd
 VnmkWtnMmWD5nhVuZx3T/GjbF+SMwht7SI3pbJRsdjbVLtykB4nOgSJdg
 sMoLtRCR2JfquF2vUTLIJ73INlX4xXJrxZibGghBfJCUFZBH5pHzzy8BF
 O7s330z1nAQHxeah3+uIEusITpXSaMGX7qL3JGkO7AMIaAz2+3/fai/m+
 L5B4zSq2hLzi1bG0sMluHReFFJpZTwIBcpgN2sMuWNFL4RX2hnU1rlJad Q==;
X-CSE-ConnectionGUID: GG1g6yzQSRy+7iFT92hebQ==
X-CSE-MsgGUID: v0x8x3huQQ+fp0LwEWOZKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="75914077"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="75914077"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 01:28:31 -0700
X-CSE-ConnectionGUID: ht7jZ/FnTh6O3mxslBzduA==
X-CSE-MsgGUID: oD0xnkppTEeIDhM0ZcL4/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="206405829"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2025 01:28:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 01:28:30 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 25 Aug 2025 01:28:30 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.70)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 Aug 2025 01:28:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbkVpVeezcskaU5QR7D9gzW3L5aiyiL41DY5NLrvWSi3emJeL+1beyw95asQ5kdEqJbzsv4Kvjnx7bnAf/+XfyCPZKa5cFeSL11vsPnr8YWEQrafhQP2hwAbQ8GImoBdr0/a/OVsXHP3RDkVSYBcabCPm9ilQdHzgeLXdRZxdaYuz+MG69xLYG+oW3gn6QF4uvVLRVmJuY1Ov70JSDJJOb6YGP9bPST0aznRLqQMXWcDLSqnhtYhlOVgfcZaSmr0tDUDvQVMz1YDewDXobusPvrX9zG7GqReQvwvgm2fB8gwIIhgVoxHBL/nPgoolLBgRf1kxbj+oMLZpxts6mJhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gh5Zo4VryDdlzxiYteyTs0jjU+RcNRUBxo10b7LJqbo=;
 b=aMA1zUzlQllr6zFCZz7WwHQ0WcADtlj6XCAPeCwJ/NqZ+WFuRoH49nmFT/uAOL2VD1e8RQqoHiiC3ptj2iY8/8BcooEU1jpQBUGO23vENZcUpdya4GSfPJjiA0DozxNZFWmkemys/m9h0Ufb1CLaguXhuPdKN4rxAhi0fbU14qFU38sSSPD6NSRe9UYETkFFB2riHIAuP+95MO0BUsVnp95UKXeqP+uMBrPoCdLMGNsQZUIXp+kchF5BJ/nXBsHQeLLITKz5GbtjvWZesO2YcmxYQU3JKnmagj28q036K7V1QGwZe5N7bp8jfx3m86ZI//AaWYobLz+Gl72p83D9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB6946.namprd11.prod.outlook.com (2603:10b6:806:2a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 25 Aug
 2025 08:28:27 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 08:28:26 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 05/21] vfio/iommufd: Force creating nested parent domain
Thread-Topic: [PATCH v5 05/21] vfio/iommufd: Force creating nested parent
 domain
Thread-Index: AQHcEy/cU7h1NYrEmkakGdO2tRUzdbRvThaAgAO+noA=
Date: Mon, 25 Aug 2025 08:28:26 +0000
Message-ID: <IA3PR11MB9136B0C89BE79666DD1B40E7923EA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-6-zhenzhong.duan@intel.com>
 <aKj5Xcg4476do8Cs@Asurada-Nvidia>
In-Reply-To: <aKj5Xcg4476do8Cs@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB6946:EE_
x-ms-office365-filtering-correlation-id: 878d3480-a0d0-4cd4-7319-08dde3b15d2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?EN3tGF8gptS1dsY5RU98HSEEg3dB3lP1eip9WKousNsq2oR3halvanxmdmr9?=
 =?us-ascii?Q?RrSdpptiowZ0ZPWx53qa9hgANuGlGr9jRInVEqMT40T69ijcxDJYPAPipwrk?=
 =?us-ascii?Q?EdEXOVqqwJWCsBtHCeAsFwBKraMKXb3jvigpnCoWt8Q//v5eS0jH5ioGvebT?=
 =?us-ascii?Q?awb1V4TepTeTVTl0DTCVoTmQ+KGJBUPusKVs4mwBQrpcJ/hGZzgC1wiz34Ef?=
 =?us-ascii?Q?vlb/nTDldHMVGC5zfvYQdvVpPYBaOuejuyGGNtEZEyAiIXVJf67hwdS8Srtn?=
 =?us-ascii?Q?goIUG4vx0fR148lJKl9uN5mzHDxE3pm1qnjpGT0pbkzHn+5rJsS1TmSAeebK?=
 =?us-ascii?Q?tNLhrTiYaTp16LGIJL3zy2behnlw5n6HG+66J5941FbfPK3pTXBXJSHlfaZo?=
 =?us-ascii?Q?NrLmBb/NWx4ZYgyGogsSlwNbBsopY6kIpwoXae9sMFZqm/pkPyW8/bPudgv0?=
 =?us-ascii?Q?mJowV/P3SgRI5DCHgTFMbSpNSE6y35MwKlR0Pe10aDJ2CRsxtfpjX+4H82de?=
 =?us-ascii?Q?VrM2+FdzhmcW9knWodSv8rC5Xvr+7g6a+kayNu5bOBneNmbFQP18MZ4Te642?=
 =?us-ascii?Q?8dVM3HDFbOnBXXodsrSjYZXzZr3u6BiwM5uDBF0m0NSKTWgz0bT1LAdgLiIY?=
 =?us-ascii?Q?QqpiUkhY3XCDCU+GRtFUouekkO1lqVFc2LxOSNqkY9GW058ZIprNhTWzteIK?=
 =?us-ascii?Q?Mhu0/9mNeIvGarkeTF/vUm27ZIPwnLpclmSOM6INJU2YqHC3MDkVtp35t0dP?=
 =?us-ascii?Q?BE11Siqx9VVNoTWb9n/MhEKlA0Ve9eUUUIcRNxb/WAl2lS8Cb4xkfYgqUrw/?=
 =?us-ascii?Q?S651K1NrjRjd4qYXE1buH9ciS/tK2zzrDQIgKGpX76C0ZjpLFZYjB5Q0ZksJ?=
 =?us-ascii?Q?krhtOY6srqkOVBluHMhBFe99JjDThYc/lPPZljvPS0s30bpn7glel6YO9VC3?=
 =?us-ascii?Q?BSxwxPqx9VK1sVUG0L0NxlLYrlzIFlnVU0Y22CqEXTm5hhghuP4Ou+bNatt+?=
 =?us-ascii?Q?EoZc0C8ZuPVFmrxqFFk6Yn5tK9yBCTMzAidFkg9bQrKW3jpFliFbpqrr5ICq?=
 =?us-ascii?Q?D4pHcgB9+nXvU5rR5/P1oyavW2MezlOG0SBQgyke5lSDHHqX9YwsIHlBmJm4?=
 =?us-ascii?Q?Sn/07tOV/9as08y2Rya7fFt3NrvapUVSv090GVGKbcY5usJyxZNsJN4T/W67?=
 =?us-ascii?Q?1h2ZwTYlCMf33QI8Y49z467D0kCql91mml32DkeslfeONOx9HwO+QTslTUvu?=
 =?us-ascii?Q?wnaR75golwy785j30bkZ0q/LCVckbrgaU1Z5W75vn8vuAF67j5aSI2zPunLU?=
 =?us-ascii?Q?WPB3vtIjxU0ghM2heCcqYwo6w+R9K5Rh2AJ71gexE/hoJ/Bzh29xjkmVF5Wa?=
 =?us-ascii?Q?oX9zkd3fzWvHxNOSycmB2W9Ijl41MfbBzi4qNPzos7arC7n6m5+Ok+JeRPkD?=
 =?us-ascii?Q?9HEthUzYuzVv/cqRZ/KPEd2ZhweUp7rcPepVKihhc7T2Q+YYZFLDYQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fu9KY5JKw6x0UBVWk5JTNVyxoFxoWAJqrddohlkV+wOch9s7imt71ZPv/rbJ?=
 =?us-ascii?Q?4s8NKzEGFnVkvzjT8+MOD6tq8/LHwB3l9xM5FyaE6KvpV49BpeEv5oMOvHGu?=
 =?us-ascii?Q?M1wAohJhVwLbu/4G2EWrBl07aSOPwdcZQ4tHmmrVsvMKBBf6jZsZKQeOpTnY?=
 =?us-ascii?Q?UiBXH+D9zbRGYN7RwlGbEMEbSIA1QeNofXkjibuvP7o7ZZQLTuyQXrOjpTII?=
 =?us-ascii?Q?W/DhKbTzcQXxJ4rjjpqCJh99f28ZI9zY8nh2Tg3prcqWz+m7mT+uI/64RN0y?=
 =?us-ascii?Q?AnY/VmKBDL18JowaR2Cpa1yxLz9n2XcteUEAVDa0xPpmDBfnRZxgl2UsGMSy?=
 =?us-ascii?Q?RhtvCwTfgEaIMzV/71weWsJDBlVEdDcLhNKSxv9Hwk7PjCKWB2V1RUYtu2Pp?=
 =?us-ascii?Q?gQtowJw/Ekx6wjzetrC/sa2tdJSM0ZLyVK3FPwBX98LNUfyyrto4/XaHC0LC?=
 =?us-ascii?Q?5kp45SfOqDbGGV+GLjtTmpVG3NKBELwPbaDF42KeRKLPHVo6XyEisrJffyZu?=
 =?us-ascii?Q?hBW4wpsgY5zOCUgE1AyAtRIjlC3BTKlZ7GT7gbJSWaEk9hbdfzzDC3CFguAH?=
 =?us-ascii?Q?u1DONPjiZi6oC0HIJ85UegV+5hnb5Ri86dlIrVJ1RiL/hb5UKdajNuvxDX+X?=
 =?us-ascii?Q?HWpiHd6XTNvXltGD0tt8yhKNh4P0uFeYugMNwzEF3baGBFh7STBTq7FCsN6+?=
 =?us-ascii?Q?9pPqAkDEv3DlIlC/XtMQks9+vKcjlvNE1MdFFRInmA5r9+AHWTNIcn7gAdvx?=
 =?us-ascii?Q?R1FiJSbT/UDaPDL4nu2q0vK7CPHNp4f+O9VAHqsGMMMqe9VF/pK0Wcr5uzKI?=
 =?us-ascii?Q?PcYKOT36kT4dh39foUzkfTf2S4gmcEVz+w5L1O2mnvsjC8GJQ0RfWXLtuG4L?=
 =?us-ascii?Q?0YQbeB5J3jDWMnnCwc4m8TNX7aOW+FZMwYHQj9hgW4YVfn9sNewR4TPhVrfF?=
 =?us-ascii?Q?VruTCc34oOu7LRWARpHR/kdkyqadQJNNczzsA1BmKGe6o/h7ckD0REsrTlr2?=
 =?us-ascii?Q?r73SGPDSjkXXUTgX9PDB7nFbn5mqZbCE0FhXuIN+OcYeqr4I5uRxaai51jAk?=
 =?us-ascii?Q?ip8yxm56NZlbBj9BvASJ0a/CT8PYTcBXKSv3LNjkMJdLlYwEIXChfA2IPpAL?=
 =?us-ascii?Q?plYxY78AqbVZWDgmvFTbtPHQwSbS8S7x/+LfM3qzw+95x+kKQdEO67E26t8I?=
 =?us-ascii?Q?kjPoYAxyGeO0Scd2jlA3OFEHB9DxDUxpU16IU8HZKqMzgTZnnxZmfuKreX89?=
 =?us-ascii?Q?BmmI7ZEu1+jsKRVV3qXRDTJcSG4TFYQuerwI8JXzO0hYeEPeQ8PyKCrf5q8J?=
 =?us-ascii?Q?ZEUcfKArlPPEsFFoI/84RPu2HaLTlp+boxPWtfszrSwuTdsoB1zx1boZLFzh?=
 =?us-ascii?Q?byX78178cG5hxApGTxQpTM+5ka3E40kJG9uzNT90CHDfJ11DnhQJ5zTn5G2C?=
 =?us-ascii?Q?YrhHcNlUV1nyCNXpYFF73zB6xJrq5j6hPzC7Kuosyp17F+3dMhmS07Nm9zxE?=
 =?us-ascii?Q?TG0blvOnpIuz3UL0TIzaQEYfA/gTY4Oy/T2VFeZ/2pAlOU0ufStMi0wD/oAB?=
 =?us-ascii?Q?NzLkAaoX1tvAJ/vGd6OWHWeMtrhMUvRp1DtgM5DK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878d3480-a0d0-4cd4-7319-08dde3b15d2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 08:28:26.8247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ClBFBZ+RaJXNf2pyqJ5GItXE3/6+ih+OKRSJbREA6qRljevMqb72OeY0fxktPY5mk8CNVPqqf8AqAKwbRuC5JzjtxYd0x6067AGsFPzudQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6946
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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



>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH v5 05/21] vfio/iommufd: Force creating nested parent
>domain
>
>On Fri, Aug 22, 2025 at 02:40:43AM -0400, Zhenzhong Duan wrote:
>> Call pci_device_get_viommu_cap() to get if vIOMMU supports
>VIOMMU_CAP_HW_NESTED,
>> if yes, create nested parent domain which could be reused by vIOMMU to
>create
>> nested domain.
>>
>> Introduce helper vfio_device_viommu_get_nested to facilitate this
>> implementation.
>
>It'd be nicer to slightly mention the benefit of having it. Assuming
>that QEMU commit message can be as long as 80 characters:
>
>-------------------------
>Call pci_device_get_viommu_cap() to get if vIOMMU supports
>VIOMMU_CAP_HW_NESTED.
>
>If yes, create a nesting parent domain and add it to the container's hwpt_=
list,
>letting this parent domain cover the entire stage-2 mappings (gPA=3D>PA).
>
>This allows a VFIO passthrough device to directly attach to this default
>domain
>and then to use the system address space and its listener.
>
>Introduce a vfio_device_viommu_get_nested() helper to facilitate this
>implementation.
>-------------------------

Thanks, will do.

>
>> It is safe because even if VIOMMU_CAP_HW_NESTED is returned, s->flts is
>> forbidden and VFIO device fails in set_iommu_device() call, until we sup=
port
>> passthrough device with x-flts=3Don.
>
>I think this is too vendor specific to be mentioned here. Likely
>the previous VTD patch is the place to have this.
>
>Or you could say:
>
>--------------------------
>It is safe to do so because a vIOMMU will be able to fail in
>set_iommu_device()
>call, if something else related to the VFIO device or vIOMMU isn't compati=
ble.
>--------------------------

Will do.

>
>> +bool vfio_device_viommu_get_nested(VFIODevice *vbasedev)
>> +{
>> +    VFIOPCIDevice *vdev =3D vfio_pci_from_vfio_device(vbasedev);
>> +
>> +    if (vdev) {
>> +        return !!(pci_device_get_viommu_cap(&vdev->pdev) &
>> +                  VIOMMU_CAP_HW_NESTED);
>
>"get_nested" feels too general. Here it particularly means the cap:
>
>bool vfio_device_get_viommu_cap_hw_nested(VFIODevice *vbasedev)

Will use vfio_device_get_viommu_cap_hw_nested()

>
>> @@ -379,6 +379,14 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>          flags =3D IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>      }
>>
>> +    /*
>> +     * If vIOMMU supports stage-1 translation, force to create nested
>parent
>
>"nested parent" is a contradictory phrase. Parent is a container
>holding some nested items. A nested parent sounds like a "parent"
>item that lives inside another parent container.
>
>In kernel kdoc/uAPI, we use:
> - "nesting parent" for stage-2 object
> - "nested hwpt", "nested domain" for stage-1 object

Thanks for sharing this info, I didn't notice that. I will fix the whole se=
ries to use 'nesting parent'.

BRs,
Zhenzhong

