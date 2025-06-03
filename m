Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBDDC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 03:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMHxJ-0002nQ-BN; Mon, 02 Jun 2025 23:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMHxG-0002nB-U0
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 23:04:46 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMHxF-0006tP-4I
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 23:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748919885; x=1780455885;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=beu3uMSx0cnzQAPnabUyCFXzhh3qnPCzIFKFwa6DayE=;
 b=ZDlJaYSrvI9P5tX+PKFsjib48mmjl8GwtHkG1/J+1TznbBLnY7Z15BtC
 MKhXDlDD1mV5+zfqDMY7Gr4LpiJGYSiRztK+tpQUx9tk4tbeYnfRFRzg2
 wgKlpunR1Hlv+JTaUM/Udnz3G34a5iDYV9VTaseUhGnx2Vhe+R+OLewUE
 ZzESXaY9oB3TCQaDBflR9bi2blZZ5YlisdM13nFTnZlcs/p3kqUCbBIjM
 GytB90wd4wk4KMTGWEhyGe0fvRD6f5v6GK6eHvr0HFRYLksih02pCQmLr
 ktpYaQ/DEz/OhUjAC5YmzVYlBhco1cnpBS5jexsh69SumvunVT22YgyzL Q==;
X-CSE-ConnectionGUID: sBKeQ2N1T/2yQHtNpuBmOw==
X-CSE-MsgGUID: o4+Q2+JCSWCLouU0g5tf5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="61995800"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="61995800"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 20:04:40 -0700
X-CSE-ConnectionGUID: C0AIGxDATsicqY1WrRyk+w==
X-CSE-MsgGUID: PoBDgfeURFGCb/lK9QPr/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="144689969"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 20:03:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Jun 2025 20:03:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 2 Jun 2025 20:03:23 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.75) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 2 Jun 2025 20:03:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ua5lUNxQhCi0OCRT9aAfSu3WLddHfXVxVldh1CfZQ75Ddrs0osJEurNjhvPjlfZbGDawsKWSRLvsOk1Yx58+eXvqMUaHavx3kMwH9pEYpXgodAnMOX01usI7X2D18FElr/LCvxdPu+/TEI05JqPaeE4Wl9aI2+VWUz63sAJNKiD3VApKnP7fvUgcHEXrEFliQDxrva0jTVwiyPuE8FKy/bFzLePPipneaGNW6lZATjFQxM2O6B0YI6sZfbh7q2B4FPw4Hl5orw+CnKsgPsWASeoajKKtl+2GiHwL++ukLsbZE2A6Ot4JJ+M5kO2JgxXviFDmZrqlRsGhprgLFPsjLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkPY2ZJkTIR5HH07iH9L10BqfnOl4/NuHH7sDaU25Uk=;
 b=VBZEfUkQ0MOpacL79WGphHRtZiiPnKYk0yj7iFyTQyoxGB5Y5xlVPr4HwiUYj6EqI2aCo1L2KkNp5RL/PfUF5tLavXj/YuQYuLmAYmYH09rB1FHxxJ40IowrFo3sHjnDx+teHynjeEw+50uI6CaQfrYDzjMy7fvtwWj/TyM45qDSfAY7A0AP7JxChpWiXi9XpLo+Ujlfza4Xt4ACGKztBSaObH/3cxo6lDrHXeJx/qasdpuMhzU8uVsdA0pmf7GwK9Lm+TI8dQjwojjkJkxKYKHfEAhcGn/8lXIISi/HzN0FayVCmty/ZUxrHrYYnsWv8NfqvVeXkG38mLfDcpd5dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA2PR11MB5194.namprd11.prod.outlook.com (2603:10b6:806:118::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 03:03:02 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 03:03:02 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 3/4] vfio/iommufd: Implement [at|de]tach_hwpt handlers
Thread-Topic: [PATCH v2 3/4] vfio/iommufd: Implement [at|de]tach_hwpt handlers
Thread-Index: AQHb0Ua6fF6ODe7WSUqxwN69+6rljbProReAgAUhJxA=
Date: Tue, 3 Jun 2025 03:03:02 +0000
Message-ID: <IA3PR11MB91360E167F283C667F4A6FEB926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
 <20250530093512.3959484-4-zhenzhong.duan@intel.com>
 <aDoVoaWGIdnQYenM@Asurada-Nvidia>
In-Reply-To: <aDoVoaWGIdnQYenM@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA2PR11MB5194:EE_
x-ms-office365-filtering-correlation-id: b70362d4-b021-4b47-d649-08dda24b2748
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?sHGqMKcCf6I4jVYm3Uth+Zmhg2Qbup8ZUeBG4aDCKLTBokeT5GExnCWfMJ?=
 =?iso-8859-1?Q?fd2/lO5/Kpo+NsxpR0rAwsjstoYZ0nxWM+nW+J903+UF3nYfWazCo0dksg?=
 =?iso-8859-1?Q?rCaSzm2VO56grP/OmK3GcqcAd4UgNUzHQS3qEKGLmur3FJA5bCg3ev/YIp?=
 =?iso-8859-1?Q?vlG4jt40KaiQNvJAd/pVLsoSwStgi5ICPiAovR6IiiJRiBdUSqBHP/ZUEu?=
 =?iso-8859-1?Q?ua/Ac76enrV/IK1QPZ0YA2vHk5FdU+iJFovPyIxuuWp5Anrskjbk5pHUVP?=
 =?iso-8859-1?Q?KkkVfobTl1ZD1K4rYzM3qtU5W9aFsYppFR9qac9GOhGKTwDOrdkJvpnlpS?=
 =?iso-8859-1?Q?JMQfXNP5Ltinw8HAhZjPme65yW66eQjQ5j0a8jbsUdx4nYQrjWiM1n1++a?=
 =?iso-8859-1?Q?5MU0rIjVEKhNaKansSRicRLEbwOxPYfG3xr1sJ5lsNOIrObZCR9de5r7gZ?=
 =?iso-8859-1?Q?LCReOpWeBQbj2G/hT9Pw2Wi1A6SLICDZD6Sd9KRE3sh5qqC90GhrYWBGFi?=
 =?iso-8859-1?Q?vJpjThKTcnCzkpFlZHxnInCtbrZGU+Xk7KWqsmfugCexxX9ia5LDZxLal6?=
 =?iso-8859-1?Q?A44Cggr9jgOMx3vz3toUj+zvDkjn25bweDL0nFzmjT7ZUWeMI3UzbQK6EI?=
 =?iso-8859-1?Q?StOORRsjejBjEseieXeJxjPGQi9fWwMeCGgPntENc5B7ls2wMtgXDBRs1/?=
 =?iso-8859-1?Q?kosnGeSdb4DtvTnvyKyvD5++QxF4jZJvHNOY9gIQiN4nTnvvQuFN5ji5Wc?=
 =?iso-8859-1?Q?ZZXGu6PP02oIn6K+sOZY6hTirOx+YJSAJHFVKcCIe+KsXfR35HpVlHwMjg?=
 =?iso-8859-1?Q?Hct78n1K1+xc8VFuD0ITdo/t6toR8QBi0GzHbyVhiiPrF1gzbUvOIaMtFn?=
 =?iso-8859-1?Q?6V/7g2najzHByx7aDD29D9gP5BKljHAJzus8s0XnHOD9hSAzcTZkuI9GWy?=
 =?iso-8859-1?Q?UevSC5v9CxGBZ7M8SZoLAEeEsJIrMaXH+JJL+rx9DhWn7oM8d6w3MOpuPy?=
 =?iso-8859-1?Q?uY1hBBdA+qPWOzO+fUZC1b6tIyXDQvYcMvuatZMIVQ0mZQF2W9wLxsiXBR?=
 =?iso-8859-1?Q?tnpnvNmu4Uwj7u1wRuaivMkhVv6lZUzJT6dusOMVUGv8K54ENWH4QAniDp?=
 =?iso-8859-1?Q?VoQqQbc9OcM3DQd5RXjCJ8wZ0006FFhkRkUHPZLgqOiZFN0pLk6VTH1Ve2?=
 =?iso-8859-1?Q?A7LACVDLm1QTZuXO1/cF5iXqteDlvGynJlnS1Sfdj4+PBCq3HdoPo2pSBO?=
 =?iso-8859-1?Q?s3TF9tMhoaiox3hkckEVom7nkhYjkcmfU2bLy8FSRj7F8XeUFWnbyHLclj?=
 =?iso-8859-1?Q?lvgEnBs7tHtJ6HNfT1HtpAfdQitvFhlS8MT85rYCh4KH2oSLZSN3cBzds5?=
 =?iso-8859-1?Q?+L0ONpmVZ830OBzExVn9JF3AL909Elnva/xRKZHZ7QTuHBPDkykvgxC91N?=
 =?iso-8859-1?Q?8YFK0wEOLItXIEAnmNz3o1lUFYyBvQddVigk8N4UBL+TiXAO/BOPndRrXk?=
 =?iso-8859-1?Q?vaV/sDkYAiEEcJ0wId0HdHMx0YxYJt73OOn25AIcBWIg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LaA3nsbycyTETfOGSxJ8x1dr3gWVgKCMNrIcXctX8nf/l+83tx6XyItGQr?=
 =?iso-8859-1?Q?Ul4+Nm1pmoSLNZbxMR8zPkixoKS9x0nhsPJo8TzTJl80/UuhDQPAsl1EZB?=
 =?iso-8859-1?Q?DHQOBggjtPDh6XdArA4chN/kM9OYW40hKrOZ6Uw2seuYGMEgfyl5QhfKtS?=
 =?iso-8859-1?Q?nMm7NLYV9BrHB5AyTRdALlsRevUV9zTq6SvhbtMp1M7cPSBIiSgT/aVkp5?=
 =?iso-8859-1?Q?yGGqDeST8SRO8/41Liw9cSzkYeTEF8tSfHAzypHvgDSLLpr8oDtEDWhKrl?=
 =?iso-8859-1?Q?caSlMvt8OOtOGBJ8oAURBPRKvYy+yfGzgr2Byc+4pa2F4FdhLkdl0hQSye?=
 =?iso-8859-1?Q?ZXM6Fye8Q5Ccdj6a/7JL9TSnrzso38QXmpxt0wrbdRnF6ENgkWujGhfmbY?=
 =?iso-8859-1?Q?J6jX0tZLCAgLYYLAeILXur0EtCiJCayfhZsxvE+d5jHOCDzf5kg5JFTyyT?=
 =?iso-8859-1?Q?b6DLEP/NovX3j0jqJ7AQvCyL1fhZNL/bYHanX38arspmRNUq1LrN/oHu/3?=
 =?iso-8859-1?Q?ggLI4/8pvGGRGkd+hWJCIAz4bzXFeu6NvKcltteKp8EkwLcSracrQvyfRl?=
 =?iso-8859-1?Q?TSaj38qc/tIgdbX7yRTLZVUfdTwShCuGdQhGhGRIA+82Z2DyjaD1GcjpMC?=
 =?iso-8859-1?Q?IBa9BAUhPnj1DrzOpxP3id1QgANj75tgJPo1PKsHib4JRomU+1NE10SsJ1?=
 =?iso-8859-1?Q?wcGs1NrLh30xVAz4rpnWb2ILwfHqw1CEsUzfzWKlhHdXYFN/1nx2y5oIIP?=
 =?iso-8859-1?Q?jQkMNVL+KeZvgN6wb9ZvkSQT2qqi6IGaR+enibcIwV+SXCxhh9A0Crz3/7?=
 =?iso-8859-1?Q?nQrddmzzl6YZouKjbTsxNJUAXdEIH1vQd5RpcmbOuI2EVxICsgWg61s/Gy?=
 =?iso-8859-1?Q?PdTM7wVllctJgOSQGELSF+dH5BscIYxL7cLkigIpj3lUym0KZfWHe+FYE7?=
 =?iso-8859-1?Q?lFrSTgrPLgTkhLh8QsstIEOgmMLIuYjwLHOmWYc6JfwSEiWEQHxqlc8y2D?=
 =?iso-8859-1?Q?J+W4NnUdd7vQXJuGkFBIS9ULy5d4UAMH0OKTAejX6eXGRMUo3TZ9upIjWE?=
 =?iso-8859-1?Q?Gm/giIXv6Ek3rAUjvJdD5kOLHPDT6G3Bok7XSHe2gg7IzYPs8vom12Ijo2?=
 =?iso-8859-1?Q?1MdkMZqlZXeIrriuXjFA1cDLiosdLtamQp14Gb450x5PblanxxcTs/vsn9?=
 =?iso-8859-1?Q?hHtDPxY4c0kWJJrPsaJVHHmZ9v0y/VPZYFBKng+2nQwN6EuS0yUvI+hBIy?=
 =?iso-8859-1?Q?/T0dBSJeDcVxbGCt4ySdYoN2J4707apoer0+YRRMW+I8KiaJDQnjxcP4WR?=
 =?iso-8859-1?Q?nSmWW0WVZM47O8qRMoN+490nxqiSLVNUYSQN/YCO6jX+STM3ZzIJFPmUsL?=
 =?iso-8859-1?Q?tdNVLGHd1xuIINYS2WiRPIxQAjHC+LAH6AtuYaRADQaVkbEswz88eZkGI2?=
 =?iso-8859-1?Q?4dBHgmZsGgGmolvue0zKawUky7wyIFLZIuIbz40EsUSSHSPooBDNh2CGT4?=
 =?iso-8859-1?Q?AIWtl0nm8MoT5plvi93IizejZ3r2WftCuMBn9Ivt5o4r00IzyPl83XccTR?=
 =?iso-8859-1?Q?N6J70WQ+BqSydvoXtPhfxlHz7OthgiGm+XwyNPUa0pmLr+liQGawxadLct?=
 =?iso-8859-1?Q?tYcq+PGxeuCmNusxKb8xgEtG3uhCOF98XQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70362d4-b021-4b47-d649-08dda24b2748
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 03:03:02.1596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z0Eq02ioy4HQfuX3xCfPAbFMbq3avFlLPp81mvAle3GxOf9phqt4iI8M1Kd9nygCUz1MQKKIaq0oQjP6Jabeiz2f2gVmhc3UcpYgRSN5wxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5194
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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
>Subject: Re: [PATCH v2 3/4] vfio/iommufd: Implement [at|de]tach_hwpt handl=
ers
>
>On Fri, May 30, 2025 at 05:35:11PM +0800, Zhenzhong Duan wrote:
>> Implement [at|de]tach_hwpt handlers in VFIO subsystem. vIOMMU
>> utilizes them to attach to or detach from hwpt on host side.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Reviewed-by: C=E9dric Le Goater <clg@redhat.com>
>
>Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>
>> +static bool
>>
>+host_iommu_device_iommufd_vfio_attach_hwpt(HostIOMMUDeviceIOMMUFD
>*idev,
>> +                                           uint32_t hwpt_id, Error **er=
rp)
>> +{
>> +    VFIODevice *vbasedev =3D HOST_IOMMU_DEVICE(idev)->agent;
>> +
>> +    return !iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, errp);
>> +}
>> +
>> +static bool
>>
>+host_iommu_device_iommufd_vfio_detach_hwpt(HostIOMMUDeviceIOMMUF
>D *idev,
>> +                                           Error **errp)
>> +{
>> +    VFIODevice *vbasedev =3D HOST_IOMMU_DEVICE(idev)->agent;
>> +
>> +    return iommufd_cdev_detach_ioas_hwpt(vbasedev, errp);
>> +}
>
>Could be a separate patch though:
>
>So, we have the attach API returning "int" while the detach API
>returning "bool". Is errno returned back to the attach caller(s)
>so the attach API can be a "bool" type too?

Errno is returned through errp. We didn't check errno here,
just treat all errors as incompatible.

Zhenzhong

