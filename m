Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BEFD58E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 06:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwwev-0007KC-1o; Mon, 02 Mar 2026 01:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vwweo-0007EY-82
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:21:30 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vwwek-0005VU-BQ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 01:21:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772432486; x=1803968486;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tpEjGFXvT1zlXnTldhvrXMd1JZPLZNOZc/am2TaorQE=;
 b=DhoNb8Q2gaWE8tgDbCcH+HY2clmNZWSphkEKSNsVlRZTk5uVJy0e1Tw8
 eTlg/3SAdoBt3E44fLTMJEhRsrHPh4XouihVXZhjhvjDPMcx0UAvh1Iet
 bvXWEmMEA6x2EGNZNygo+hQdRoIWXZOfzENpr4Xsljg68IQcocGQhq0CL
 ZraY7PZ5skEl4y1L0Ehv6Y+HJKT71NAXgq4SQiEVug33SiOgiBHFAGOO3
 MJxweG1HPe6qOaQ5TU/naAu9JwLM62rUYj40sIDIiSfrpcc/nDjWE5c8N
 c1ipE371/UR34i8k1MYBeCD/DwtP40dciG+aEs93Cb6kcKNwNQSko9Iuu Q==;
X-CSE-ConnectionGUID: j/gBn87xTn649/ByFswc4Q==
X-CSE-MsgGUID: uiuz1UJYQ1qUxEkut87gQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73542994"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="73542994"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2026 22:21:20 -0800
X-CSE-ConnectionGUID: aiMloz/mT3uh0nnBA3cIDA==
X-CSE-MsgGUID: s2IrrizGRrCj8Wv/f/10ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; d="scan'208";a="217453700"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2026 22:21:21 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 1 Mar 2026 22:21:20 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 1 Mar 2026 22:21:20 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.57) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 1 Mar 2026 22:21:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uiI9122U19K3NFSUVklerRY2avY7pcvbCzokPZc32PVe2X0XuNvlYqdOn2FMaSvBcgIRgTvkhofutCEQHxE4x6Y5vsslDFNmQRu/sEYs5/0hUh8enFFzosYV8C//jcpTpkAjPhS+7XbnlFvRBYmIaZbquGerEPcbhf50MXqqSRMvSvBt5O0RJGpbzD+ax1XVka8kxGEKrfJtnAboLDOnM6dh+9bmWWiLHbaobeoAK3ABzYmMkwpKe/V8mtRPQdQZWgALJOaHM5W4t8Qjf439d+H1QoCHn21yidBuKzbFqmItg+nUlmMEPVmLlYTiQbEqlt+aznUJJSX271bZ6ie82w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL90qCVhHAAM8+bn/bPVwd14wEq0sTSbwznFCLMLW4M=;
 b=rYo0pSlxkwJXygupTb7I+koKvwoVaPrYDzAbUa4857HY1qpDYGNB9UDOKJpKZprxHvVcHQQbuneOpTPXc+4osx3prWYo/5BtGgI5PLY/R6j0hR9h1qz3Mgpb2FCT/jfICPYFRQwYf7PvRKfGSi17vy5avAI/AgXQHbTqnfvUoNkd7QhN9eyspX6dfuOEbe1xi24+1yb+hbw/9CMFYtCLppWy88uTwAHcXR2ZcyefIvEWJZyw/kVte++gdm76sXa8v5r99dN8hVZWHQdd7fFMhPPqCXQLQO/0U1MnM22fYwOarujg6jlsiMpxO52qW9i0ipA7PCUt4Xs3klf6y1JasA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH7PR11MB7027.namprd11.prod.outlook.com (2603:10b6:510:20a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 06:21:18 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 06:21:18 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v8 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v8 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcqDcyPiGk4Utg+kiAxNQ//lZgfbWXuNmAgALkdmA=
Date: Mon, 2 Mar 2026 06:21:18 +0000
Message-ID: <IA0PR11MB7185AB3D73F775854573939EF87EA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260227221632.827046-1-vivek.kasireddy@intel.com>
 <20260227221632.827046-11-vivek.kasireddy@intel.com>
 <45aee031-3ae5-4334-a9fe-16162336f8a8@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <45aee031-3ae5-4334-a9fe-16162336f8a8@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH7PR11MB7027:EE_
x-ms-office365-filtering-correlation-id: cd75c4d8-e2c1-44d3-a57c-08de7823ea29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: HpI+zRIov6Q6qaFyGf4nE7r42U0LUXtpymHmjYTOIgeKkW2iryCWx0X8xdQGvG2FC33U1jnY93DxQaPm4XvcfIMDgoKCQA+MC932VHHrT2BCzMyx9Al5OcNB9WXygjtHOGfvrS5Fspmq/pf4jQaKvj2R98HF8M3HSPnzgCl1pl0pP3cQcEIHqlxVBEmIK1vqcpsbHWhiyGCwxNXKgeOT1gE8NYNI9sE/UKKS9PAWF1QL6XPPhkSKmPcgBCXrGnh4rTQomSQTi5zaYT1OhIN4/BUiR8uJQjYoQ3I8044WshBu6wrsz3OzqDk2Zl9sB39G5W1KJMtDbOOhDSjDrzwuDyrdo2KhBNQbikq5JhHZDT6zh2U33r/aVJubRhCbuiBnT2uKAN8FoLgWW0Y20tnKIEysLj5qdfnvYC/bYVyt0LVl3HkHvy5YKCIeyJGrhPq1OxoA+J2A1Y2OvZsFVyBeLK15l9G/J9vtv71OQt4+0F99g8GT+t+BNE8kQcmlcOeIxSk/XXuzizb5AdOUn9WlTvMZNuFC7QRKM4PC5Mr3VmUw8AKcn2vSaJsz+J/Ts28kyOKx3SY/dIlkXNBeZl848xke9woZkCL/yr/PehQ+iItNQ8O/mdMoeBbqp3YAojWfNXVB2VyBRyTAgPbeUp+biMdqk61KvWg8vGiHBtQDeNpR44ykT0SzB+fplgjOZ5JxZHSasf9VG/LZb8vhWL39lXnPIHdMk8yboyHEiP9+/L9voAnXW67xpMfNU0xhIPCftRDti2rZ6g6aGFXRuzX6cYZE2K9MeqGF7Mbv106ucwQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RF06ekFPEGb+D2s3GE/4fBRWoTt4eJovh8fum14OXO054aDFi1K1DBkXHe?=
 =?iso-8859-1?Q?/7l8VDqWrcTz7vHRqxdkVqSqhilRXcwt+k2RXyf2kIQPY1cmc01EZPQeE+?=
 =?iso-8859-1?Q?2v/2wqlsl/W0K9VO0IMtUmZ1h37B03IIZz348M5sed9shuREH3mHQg4utB?=
 =?iso-8859-1?Q?I8qn07WkU7F6tOGnz0ZpQ8OVbrhj8kuAYji6OBUSXbXT4kHEIlzO5gkBd9?=
 =?iso-8859-1?Q?dyQIzNNQv+xvKwhC2so83i+RQYwnhhYA+PXRJhvx4VsACACexKy9TmfwqK?=
 =?iso-8859-1?Q?Isecn5ZFT3i7z/+OaxYtZUFBx1GSF14LlGaLuKqCTIzeesA2H+FzdOchvu?=
 =?iso-8859-1?Q?zstwrCuNzDyEqRvp+fNKPdAzJKLGRQJmcpD5ur9ksQfarHjTCLZYCdFo62?=
 =?iso-8859-1?Q?y7Eq111pGdDFAT5jEcVNv+svLX8BKOSP9iyPb/uMYdyaRW92+d4/iO4+IL?=
 =?iso-8859-1?Q?HrUUhfw0zh31JrqoCwPpKiFw9pPZXY4BePWdRh2GjqMlV1NbSqDA5lMWgV?=
 =?iso-8859-1?Q?sN/AFL6fKnxsqCbszV2OBg8v/RPa2MBrVuEpsmNgmKbIHra+uWpfb9hJ9y?=
 =?iso-8859-1?Q?zmGbnOYY/dSKqYwtqQsZ0/xdl/GRw+DLMt+AGPk8wDaVcWmxFCQnV2qo53?=
 =?iso-8859-1?Q?h1zl8OZbUTqQtXwb0pRSm82UcijDabx8iXiNvLHE7pC5w2GcfoPkwwJ4ph?=
 =?iso-8859-1?Q?RgGPDkRB4BkQ1OE4yDUAIe4Ft1QU/UWzHBA9KErt9G6dgwjBCHZEvf0gaY?=
 =?iso-8859-1?Q?/31DAZWsZWoY4qSAGbUSSqicaJIBrzMd/mP7lva5hdqeRry8GOi863RZoy?=
 =?iso-8859-1?Q?pS1/NOeTfUuishQnNOJiOEQx8NqZgm3Egeaa0xaRZPO5zdEnS7Wb331P7i?=
 =?iso-8859-1?Q?+t+6nryZPhJTGhPR1nBPmB21P98+qvdBI/YoVceGbi0SFhoYIlhuImWqLY?=
 =?iso-8859-1?Q?wW4OozO6i8nWgZnbtFLbB+PnqrG9X3ofQrmio7a7l7h5i0zJD8G/cEhllf?=
 =?iso-8859-1?Q?//k3wTdZzLIPqTvR/7vrutOqfyOX1TNpwOa4JZqYHyR6XSgfH1e5Mqrnxi?=
 =?iso-8859-1?Q?3nSZvk+plucWxZ7cGEYBPZDFMXS0IbvwC0c3oZ8Xm4biCA1c63pv1ZJb2B?=
 =?iso-8859-1?Q?zRB2KfjgBtABUT1/4vr07Idxs0kw5zhd+ueqVk7+e8+z1jHhGhkuQvwhAz?=
 =?iso-8859-1?Q?BCKlHR9d5bFKVkbOowid2shFZZDZfRW0J8et1WXJhcKXITHRW2IwLkqrPd?=
 =?iso-8859-1?Q?54+Tg2+gvmbPnTGrgTpXe/EIcRTKaGcDTKD6s9ubKqzrDE7XJUWeAhrT7r?=
 =?iso-8859-1?Q?PAirrsZgpRLztsRmZdIc4/IjgBzeJy4Wxfvuu1n9CC/L0L+xvUeKuClhV2?=
 =?iso-8859-1?Q?/KbNnJGZ9unZvFPpRDvnrDWXC0KvWgJpWS0jnem5AALtA1XLszCkuttefE?=
 =?iso-8859-1?Q?U1+Z6Phwu2z7bdMxf9bv7Gm4ljE/CPb6OBOlejcP/Jb/u4m0QlsaUBhbqz?=
 =?iso-8859-1?Q?4x5AtZSZ2pRer4i37IJ/aLYSZUAmeGfYnGtvhtet9dchgwwTms+E0bkbW7?=
 =?iso-8859-1?Q?00XHprM7ZrWWNpA21pvqK/QM6kAphkBs/mh1moeJfPlzrumTkARH1pL9it?=
 =?iso-8859-1?Q?vARHS+H5HPf7CLcZLhg4nl49anerFtyLmgzEhszxaJ6QPTB+/q9f21MFua?=
 =?iso-8859-1?Q?vfSdcBuQ9AIRvcsx5+2SIvaXHJMObA01GNbtj+2NOu0p8RPbL2LU1PjdEL?=
 =?iso-8859-1?Q?0DufqzEBQcf6Q+lViAeuj2C3ylbVfStGvt7idn+qG/VVRuUX31D/xhuxWn?=
 =?iso-8859-1?Q?zlYqf6ot9w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd75c4d8-e2c1-44d3-a57c-08de7823ea29
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 06:21:18.0558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UIH+dqDrExtb1R8AIuwRyPnCHc+44wCfuu/rNv9xV0GeFT5ihDhsJBgNNjiBl8nKPWsikW/ib2hMKMxMDdCGAJ4dUbun/RIvPri1fOgXc0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7027
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_NONE=0.001,
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

> Subject: Re: [PATCH v8 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
> associated with VFIO devices
>=20
> On 2026/02/28 7:13, Vivek Kasireddy wrote:
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
> > Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> > the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> > fall back to the vfio_device_mmap_dmabuf() API to get a mapping
> > created for the dmabuf.
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu-dmabuf.c | 35 +++++++++++++++++++++++++++-
> ------
> >   1 file changed, 28 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> dmabuf.c
> > index b2badfc1bd..533d3d601c 100644
> > --- a/hw/display/virtio-gpu-dmabuf.c
> > +++ b/hw/display/virtio-gpu-dmabuf.c
> > @@ -74,13 +74,21 @@ static int virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res,
> >   static bool virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource *res,
> >                                       Error **errp)
> >   {
> > +    Error *mmap_err =3D NULL;
> >       void *map;
> >
> >       map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, res-
> >dmabuf_fd, 0);
> >       if (map =3D=3D MAP_FAILED) {
> > -        error_setg_errno(errp, errno, "dmabuf mmap failed");
> > +        error_setg_errno(&mmap_err, errno, "dmabuf mmap failed: ");
> >           res->remapped =3D NULL;
> > -        return false;
> > +
> > +        if (!vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &map,
> > +                                     res->blob_size, errp)) {
>=20
> Let's call vfio_device_mmap_dmabuf() only when
> vfio_device_create_dmabuf_fd() is called. Hopefully it will simplify the
> logic structure.
The logic looks OK to me but are you suggesting that it would be simpler to
remove the call to vfio_device_mmap_dmabuf() from virtio_gpu_remap_dmabuf()
and call it where vfio_device_create_dmabuf_fd() gets called?

Or, if we keep the call to vfio_device_mmap_dmabuf() in virtio_gpu_remap_dm=
abuf(),
then to implement your suggestion, I think we need a flag to identify dmabu=
fs
that are created via VFIO so that we would call vfio_device_mmap_dmabuf()
only for these ones.

Also, for VFIO based dmabufs, should we directly call vfio_device_mmap_dmab=
uf()
or is it ok if we first call mmap() and check if it works or not?

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki
>=20
> > +            error_report_err(mmap_err);
> > +            return false;
> > +        }
> > +        error_free(mmap_err);
> > +        mmap_err =3D NULL;
> >       }
> >       res->remapped =3D map;
> >       return true;
> > @@ -137,7 +145,7 @@ bool virtio_gpu_have_udmabuf(void)
> >
> >   void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > -    Error *local_err =3D NULL;
> > +    Error *local_err =3D NULL, *vfio_err =3D NULL;
> >       void *pdata =3D NULL;
> >       int ret;
> >
> > @@ -151,15 +159,28 @@ void virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >               error_prepend(&local_err, "Cannot create dmabuf: ");
> >
> >               if (ret =3D=3D VFIO_DMABUF_CREATE_GUEST_ERROR) {
> > -                qemu_log_mask(LOG_GUEST_ERROR,
> > -                              "Cannot create dmabuf: incompatible memo=
ry\n");
> > -                error_free(local_err);
> > -                return;
> > +                ret =3D vfio_device_create_dmabuf_fd(res->iov, res->io=
v_cnt,
> > +                                                   &vfio_err);
> > +                if (ret > 0) {
> > +                    error_free(local_err);
> > +                    local_err =3D NULL;
> > +                    goto out;
> > +                }
> > +
> > +                if (ret =3D=3D VFIO_DMABUF_CREATE_GUEST_ERROR) {
> > +                    qemu_log_mask(LOG_GUEST_ERROR,
> > +                                  "Cannot create dmabuf: incompatible =
memory\n");
> > +                    error_free(vfio_err);
> > +                    error_free(local_err);
> > +                    return;
> > +                }
> > +                error_report_err(vfio_err);
> >               }
> >               error_report_err(local_err);
> >               return;
> >           }
> >
> > +out:
> >           res->dmabuf_fd =3D ret;
> >           if (!virtio_gpu_remap_dmabuf(res, &local_err)) {
> >               error_report_err(local_err);


