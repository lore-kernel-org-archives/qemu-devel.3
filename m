Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64987F506CF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 05:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2NCf-0003Fs-Ec; Tue, 17 Mar 2026 01:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w2NCa-0003FT-1B
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 01:42:48 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w2NCW-00065W-EP
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 01:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773726164; x=1805262164;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=i9LF1FPEDqn7H8p+XdihdxZBDOiN+9kinGwFUzwS16M=;
 b=G9qmpkMgZrLXWZwNKPqXHQWTihJQHupKycpYIgMvYMT+esByuAFCrVec
 B2+idLapywGAFp0pRq7y3qRLkyaJIBv2wYbe3n4WlexfFfpikRDn7Ahmu
 OaQFpFS4cDG8BEkauQBMRPnnegkJYPOH9bn9N3qdOqpAQ5TWWehRDM9T9
 S5CQufHx3OUH3hxfEXnF+ToEeNMq1u0Tt3Va9vpn7QaMjPecg342VUqio
 HBAs9o3JDWoekeRE5WflJZLAtHecPEIi3Oq2yZw3FVHWfrn6ypAxdP5f0
 m1TGzoLkXtYp0nB+O7chzvOjNU6BaLBI4858Egd8a0j7d+gbGZNWxPnlp g==;
X-CSE-ConnectionGUID: vPtR6VbxSfiY55YrOfNspg==
X-CSE-MsgGUID: 5QLNuXD1QXyP8nziG8eQzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="73929624"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="73929624"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 22:42:40 -0700
X-CSE-ConnectionGUID: MFU9lzKzS2KberZ35iwETA==
X-CSE-MsgGUID: cmPlJaVdS4iwMqJvgYFoPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="226272473"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 22:42:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 22:42:39 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 16 Mar 2026 22:42:39 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 16 Mar 2026 22:42:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhODJ/AmLrE0m6k70dRKE1AcrpkkzNEIW6BnCNBtmSBBCawTfGoA64oB/IjZZBFFPPYYd7foTKqBq6FQbmSXsTBJlungzpXOSE1zuGi9lOTSRQimU6wL2990DuA3ImRBmM6uvw85Ki9O6RbYZM9eUmwmSoG3e7HpDUq7ECze9NpHsj6oEOUlUQfjLqgUbzBBw5g+IskdyxvmrbrZVbcNMIolPfaeHynn8QYuqP3TRRBYtYEsVnZ3i+0jwCuN3klSFyStZ6+MbjY6rC7c4Jv1rqqgh0EySwe81SzQhXim7J2WKBb73lRrb6RFm3zA7j+Q3GYocYg3uisBSl0P/8enCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9LF1FPEDqn7H8p+XdihdxZBDOiN+9kinGwFUzwS16M=;
 b=nzpV4wrEsZVlBb+YtlRys3BUBPPCXFQdscFVPi121PmVrC6/xyLiP2ZUVFhhB+7RfysOCYsN3xvbhb0xSXk9NvnV6agKNcj65DoCmRcqaZKavl6yrwqlZNS4IhAuCB6d8wpi2oASnLeCPhP1L0nAPEZ5QOWIn1DRGjd2O0nXGpHkr1tlKNEI02VfBpJz3QQ6BjjyHsfhpVJrUtvgtZqMZOza8GIbHTf5bHcA93OXI6//gSLynLB28tLS2zahAw4Lq2Uzovg5gxoykVgNswYBgUgz0T/ND8plNAnOxtqcJyjx/6Jw3Z47Aup8ooUej1r9mrnven/31zazldent69GXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8)
 by LV1PR11MB8842.namprd11.prod.outlook.com (2603:10b6:408:2b3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 05:42:30 +0000
Received: from CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035]) by CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 05:42:29 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH v11 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v11 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcsQKvhlyWHsvpDkKW/EAlR6lOwLWoy/CAgAFO1hCAArqpUA==
Date: Tue, 17 Mar 2026 05:42:29 +0000
Message-ID: <CH3PR11MB71779A42788AC6E84035F362F841A@CH3PR11MB7177.namprd11.prod.outlook.com>
References: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
 <20260311025340.1335673-11-vivek.kasireddy@intel.com>
 <04fa350a-b181-483b-8cbd-2ba5171174ba@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185D57A5228ACBD883CCA99F844A@IA0PR11MB7185.namprd11.prod.outlook.com>
In-Reply-To: <IA0PR11MB7185D57A5228ACBD883CCA99F844A@IA0PR11MB7185.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7177:EE_|LV1PR11MB8842:EE_
x-ms-office365-filtering-correlation-id: 760da5f3-3d75-4293-12e7-08de83e7faad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: UxshT1i5G5ooLEN5f3gBNLVgm0c/ntNR46DcFU8XmN5di7hOqRFxARVr1ucNmMauHQr/BVzxBvypGsvCAQDfx7Elel1vj5FscKPJ9SfAR+W6b+tb/9GSc1X2PzaSPMWenCCLYkjejIsZkVH6GC8oM1Ajh5m/0yNmUeKw+RfVF275HD1VmkUeuUka9QCZBqq/nPMIbx3FgUD9lH4y/G6IWUp+tlLDJbF3Q3gxMrouOToYlcnLlrUqH77c3jiivICjKBk0/Cpa91JQWx56PONrGNDEpIulTcEEUjF5mcnUPG/e38QmLwBNDIb5fCtbJRbkCLhb4VmpskYY9o4kNS7raorEY5WmreGiLb0zAU4xX6D8dl3ZP30O66Zh5H2sYizRC6RuutuKDxTvxYHF4sWqVqjyb2GuHtg7OlCGJjXhMVZ7tJZqI+XwEp8ibbgh4KUDHbm15Hbj1sEK4uTvSVGjqA1AS5eIpTfQsfXoRi57Od1Xwd3r3MDO4eMa1ODYVDQ9cCN6cwHuJyeBMgVdTHfOqO/izKCdC6KROvHelPCqpYyMJrDUY/fHssJvAQwIkfwY7fkurlbwipzM+zI1OTyohpWIvI3hmiRR5cFQhqbgOH+55afEQRTqY8kM0diPCvqDuKJV5dqblfPbZ+buJokdksrZR80CffE496MX1mrGgSkEO2sXxLhoSZ0/DhU0eIR4CdC5TgiQeWiUe0EExk/tmsS9rlEuk/8ZPmuSr7q6bJXuPP502I4NeeXOkpfN5ipGHUDcItk/InTiAoeC9/p+2/nKfpTSz7is27FuB/ssxUI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7177.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?P6txnuE8kAZpVRUEl9KWFlflLfIXdcxgK+q3Nm0LNnAA29O3ux2Q01xhgF?=
 =?iso-8859-1?Q?ELL69XATyQVgFccjd9Z0XYEGF1dfsjoaE2LU6wybfW9U7HRuo1pm9XX8ml?=
 =?iso-8859-1?Q?lZMDgSqjjLoSAlTt49CFwx3Najk0V+awYTnz7V3jP+7l5mpQGEJ15aE3RM?=
 =?iso-8859-1?Q?iu36nrXAUWeJj3UavgNgCU+Ph49rxXySsgnBJORVFOuHpdHwN3VzFIWPgL?=
 =?iso-8859-1?Q?mSnVRgim2y6Pr0nnMSsN+4iC2CoJ9aMroYqvQ2EazoHNhYIyAJ2RLRb4d7?=
 =?iso-8859-1?Q?BZwvhh2KIAjxHUy8qAS7AqqJewbWMgXk4Ec1rG+SSgRZ1xf/RyiYLpglCC?=
 =?iso-8859-1?Q?ACrnV7t0Zcapl5/U6qZfmN6iDyTYXtO+LKMdT2ZwAyYaMaK9EPLK4CupcH?=
 =?iso-8859-1?Q?vvqgJ3Um5N/jY9nRfO3ecwG3158vf0stG4nMEj7HkqIN313sok9cAtGpyR?=
 =?iso-8859-1?Q?AytEK+s1P3z1W8zlgBbU9oW3uibseRGrLWm9yHBqZNknmQ4B9JnHgBZ3u7?=
 =?iso-8859-1?Q?UwSSNBjNm7o7U4IZSuae00Mawne6GzbbyuPDy0CV/o/7aC+CGZq2gjGEUU?=
 =?iso-8859-1?Q?Cx97hnqP44LAXGbaW1yxusskJgbkfgwG2xkVGBAc6D0OaTSyXVZH/2c8ob?=
 =?iso-8859-1?Q?yGd6Hx8zruhKPN6Bph1lGaUtklmqplcBzRQwD01rUGOyRLPoxJr+oP07I0?=
 =?iso-8859-1?Q?ivwj+QsILyKjkuz5WGbgH0PnMlNbFiMh6qa6PkuELLegQfm5YSF7df3CeR?=
 =?iso-8859-1?Q?jtFYhgGpwRWSQz7VRF/FBrp+90MGEoAet9TIO6iuPDfUhRKmnDcRmhf8zc?=
 =?iso-8859-1?Q?1zpT7EhEhltWJSkjNFSpRMt9bRrnguUehJRY2r5n1bfscCYbfG4Z6IsRuZ?=
 =?iso-8859-1?Q?E6ZDzgXQH8b8HqHKlaM12R1g51TnHoIhXkE3ZWR+MkGd5iXBL3zy+nEZ0X?=
 =?iso-8859-1?Q?U3gtH1JHkm3tf1wde8zNYW3tYsLyMoBmmxYyk+A/bjnNsUiWLqI9CKSKxZ?=
 =?iso-8859-1?Q?tTXccmuEEkrK3YWVKzPaBEuwK4PtETh6ANvtD/rTV4dvdUCLahF8P52HHh?=
 =?iso-8859-1?Q?hjlTSQ7JBXIWjYa6h63hBKFaU0vAJNLypLI3afNZqq1rUgYocMT7ClW43B?=
 =?iso-8859-1?Q?lrPkwU5uKcU2oClTHxcui13v+6Akpi8qMwMcHS1EtEZuFrocjsWLGMfEzH?=
 =?iso-8859-1?Q?iM6EtpRdRdlqt44Q6gxaXgAy9ryQ+NcTCqNLuDvoZq5dWWGoR5OwBeidF2?=
 =?iso-8859-1?Q?X29wB8TsV28g6gfx5wvHPBiygU3pq9zDC0kqpjFz6MrF8rB3tA/jZ5zclZ?=
 =?iso-8859-1?Q?N/kFvSv0o3TYMB5YRe/jcFAZ0grEkK6huPH2MtYjYowG1kWF3hiNqR0oW5?=
 =?iso-8859-1?Q?FPpW4oa656Kk6IyWZq68RXsmCAHLeWitOj/4KOM8oS3A31HZiXKnVA8VvM?=
 =?iso-8859-1?Q?TtoNL9+gpbGaoPH6Z2boQaDBkxaA5W3Wpy/dscF5fMW7YhfKX9Jb/JxNET?=
 =?iso-8859-1?Q?ZJ1yaqvPxlF5LAlJgcEjwd1sBA7srwBrjyfD6KyTLherEJpKnupgbkxtoY?=
 =?iso-8859-1?Q?YFJAGDn92iNnRwzC03d2A/sxiV7WcPFxcpEvWbvT9KEl3Kwxftxhyubj+Y?=
 =?iso-8859-1?Q?3JUlHOABzdVQmpmmGsFfH1eJjDiCtro8zt5ElHYrP8rJOJ0DtFxU6EmqP1?=
 =?iso-8859-1?Q?vvn+HO67FldFNg1h+CbfacZB6f3k4GovCj+awfnhBr57gmAbzFMyzh3tMu?=
 =?iso-8859-1?Q?8GbGkrr/uxjLED9bgTnQVhu/pQM3/cpH6xOjwHwUL8iYIXMyD0cGR32Ikl?=
 =?iso-8859-1?Q?v+ykkpj60Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: X/GafmNMuaxlSX/d3x6DJeK6Tz67nESUEjF/CTiBB1zjfYbOJ3mLNIYpzz8cxwIsytboCR3gyxfkdDj3B5eB8sUBkElI5LT++UxqjG5yxLdrkvjtUArggszC/eZX/0a5DmAwVhMoXTg3KzwDmuJqzvU3xZyYUUzjgRpvT0UNd4zYdXYPHnChCvIBtVI8esI+SktKhtj41E3F/S2pZwgzIq0KDnhjQ5Uc9fBbaMBH08VVKkOSxiRzzUhG+Nb1SNdCXLQmVit2FU8yGa6Xl2iQhiDJz8h6Bv7z6WctCpwge25CTlXe1fhRtRbojHGpoIa6AZeyg+ZYMlH6gUCTvABE+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7177.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760da5f3-3d75-4293-12e7-08de83e7faad
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 05:42:29.9294 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E3Vyn290p8lCUIKpSWLSV6JnDnbBs0Z/CHclsCc9XJnlhltg+ixVQZs210eJLI7WrCmDJLMzbFmty/JUIdwM0B4+KSMPtJOBK6DTOAtkYg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8842
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Hi Cedric,

> Subject: RE: [PATCH v11 10/10] virtio-gpu-dmabuf: Create dmabuf for
> blobs associated with VFIO devices
> >
> > On 2026/03/11 11:50, Vivek Kasireddy wrote:
> > > In addition to memfd, a blob resource can also have its backing
> > > storage in a VFIO device region. Since, there is no effective way to
> > > determine where the backing storage is located, we first try to
> > > create a dmabuf assuming it is in memfd. If that fails, we try to
> > > create a dmabuf assuming it is in VFIO device region.
> > >
> > > So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> > > backing storage is located in a memfd or not. If it is not, we
> > > invoke the vfio_device_create_dmabuf_fd() API which identifies the
> > > right VFIO device and eventually creates a dmabuf fd.
> > >
> > > Note that, for mmapping the dmabuf, we directly call mmap() if the
> > > dmabuf fd was created via virtio_gpu_create_udmabuf() since we
> know
> > > that the udmabuf driver supports mmap(). However, if the dmabuf
> was
> > > created via vfio_device_create_dmabuf_fd(), we use the
> > > vfio_device_mmap_dmabuf() API to get a mapping for the dmabuf.
> > >
> > > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > > Cc: Alex Williamson <alex@shazbot.org>
> > > Cc: C=E9dric Le Goater <clg@redhat.com>
> > > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >
> > Now I think this patch implements proper handling of all error
> > conditions and conforms the convention.
> >
> > Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Thank you for taking the time to review these patches!
Can this series be merged to vfio-next given the dependencies on
the newly added VFIO APIs?

Thanks,
Vivek



