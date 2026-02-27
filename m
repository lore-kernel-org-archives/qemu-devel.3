Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D4BFD9E26
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 02:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvnFR-0004qr-UO; Thu, 26 Feb 2026 21:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vvnFR-0004qj-7m
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 21:06:33 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vvnFO-0007TS-HM
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 21:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772157990; x=1803693990;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CnNYfqo+CFmwAGjfqqamgUr88XvbviMlISnfzN7w/fE=;
 b=dDDW2nuG5KfwOsk565mwXaaUjroyILBV6Q7zyQ/SFhirZUVI5I1kizdp
 kBrprAlzbPZ5FNaInmQdhImmvHmgpC0JmO1PQ8G/O0Jss+zLinJzLevrc
 /O3Qn9WGnIGCiV5VrsAOfusK3B1bWKUDEQoporsggnQRrb9LPNbIs2502
 BQT9th5C847v0ZSs7O0Yx6CpFo/r473SkCGW7xb6KAVD5x4r+LhurlwOY
 8zeORdIDOFiZCtQFoahkEfNCg9BWLkriOI/+prGvhoBWXaayVKiTk8Nqv
 XliJ57AOIlGxiG00dQDD3ivYN4jCjpZvQmS/OP/QxxYu4xOdPIyw4FYyS Q==;
X-CSE-ConnectionGUID: zLLkxdwoRiKRrZNLV6EJfQ==
X-CSE-MsgGUID: e1tnQsG5Qq2Kiuci1ZCnVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73420487"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; d="scan'208";a="73420487"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 18:06:27 -0800
X-CSE-ConnectionGUID: zPYD7VueQsOXk2PDMkTCQg==
X-CSE-MsgGUID: BljTnMTlTdGilsO1CWS12Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; d="scan'208";a="244219272"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2026 18:06:27 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 18:06:26 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 18:06:26 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.53) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 18:06:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAtNJ0yVVZyMYU+jD+KJTpwPwsHyfEGsldR7ZTOOh8pqwkdBdRj0h3p1gHZ1ZPPnmFI9wBy/WXIdevnqF5AuIh01mX98FjX1iE+ARaf4DUhKw61SyLjcOabQUR0uXHfdbc6BP8Oj/qb9nBZIILRK8uy26kHxZ7Hqv15bAJWlIFGTXhQPm+stnIpPTK9UAen69YIBDhHCjhnS8kg7lSKHaAorQkF21KtO/BkdUfBMKWQMNvzMn/moNaejAMBdF0yrikcsfurrXaJAxtmihaMD5yvzy8k8Sjw27tAIRNar2ozQUl6+n8AULc89k1JSDOEnMT2y02jezXVJOc+wtQ01fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRZbDxhIZ4/3p0/lffmLQhylbWB5pBK5pKSx6YshEmU=;
 b=AAC7XqmUS3nkCwezmS6c86ZqszRmOoTYZ47JnkjXmxcwISH33DbnIJ7Dm81PXp67TcaRz1fLYi+WgywUGbrReji9hEF4MxJVrsceTX+3A2qJ9JZp6M2j0mp4NLa1S79eItYbzRJGcsTOCfw8J77l5JWiHThLyFKW65FrVXzOzWVhULNQsPFLmOc6azup+5G7oMT8OxgVC+TAitfN/ycPoOJc29DsVwpQZ6jNpTw/vRJ89y6XvIhXpZwXHhsyPlaQrPK2GF8adtRAvP13wQPyle0hoanH8VKNoOgh/SdLeEGjxUr2KJL0aQLLdCLnuzHq3lkkINYu+vme6+jFW4Escw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by IA0PR11MB7863.namprd11.prod.outlook.com (2603:10b6:208:40c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Fri, 27 Feb
 2026 02:06:23 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 02:06:23 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v7 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v7 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcpJsL0c9wpUJoVEWe9i3pMi0k1bWROJ+AgAEtoFCAAIyRgIABFzfwgAC4+QCAAJU18A==
Date: Fri, 27 Feb 2026 02:06:23 +0000
Message-ID: <IA0PR11MB7185F38C1B73B8516AF413D4F873A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260223080200.468558-1-vivek.kasireddy@intel.com>
 <20260223080200.468558-11-vivek.kasireddy@intel.com>
 <aa496278-274c-4fb1-bb47-bfdda7337628@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185F034A065CCE507F69F14F875A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <d2779f88-735e-4d14-9b5d-8577282c5477@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185B641D5749566273C27E5F872A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <becde56b-90bd-40ca-9329-0c92b9519a67@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <becde56b-90bd-40ca-9329-0c92b9519a67@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|IA0PR11MB7863:EE_
x-ms-office365-filtering-correlation-id: 07b5f1e9-c64a-4eaf-b7a3-08de75a4ce7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: tGZXyeZKUQVyGvie3QkWGLCSG+0uj774/RXpGCFf8PpYpXFRGUt9n14EVqZr1J2aNKAR8Ca6UhdKuRYD2ChXgTlGxmmByv7zpnkx+OAREAn2BZqqt3IPv7lRqaV2Ty58mU6grZsETNSJsBX/5lUYeZjQ/h1kAjgcJTI49UxtTvcF6k0m4C6jcEHCyrm1TL4JrOCmU9V1kQnmSn+a4OiuJHhfcrf4VNklJX+wPr7/2z+yqR5B6JEC874sG4wtjjQAg4RYDHu0VP7QeVA5v1omC2DhFRTuGyZtvzVam6epXSW2lHIjWMCPZ+DjyeDa/fXgr7O+BJKWn9e87FK6Kij50syoGGma/Q+LBRRM/YxcJcbyRWXvENDcZ4JPDQBi1ynIOKYxeqFEYq134/w9/NggMqucWbZGwobUGLQhMKIeRkd6i8H8sbsqz+Y6FcETMJslSUJ24JGC+Kefly9t16ipl7dkdCAg0WfRwm4h74kvlSCm06rzPCeS4DiKL897V1asRncaTTP3GgdhmyhUKugG5Tfi47cFbqyKLGb+9fRUpruZuuZMcY9Wg2r2A+LdFqxZtvF1QwFqKWtQtLj7y6/I9OeWs8Phww9Jyg/Djpd7FKZ3FtYQM415CUfiEl6L5nxjur8ON0+l4iuqE/YOwRmdVP/FtjuMD3ZVXMy0LyPoC6vtFR635Hec+BheyN4BS4o5JBTndhSYf619NgHvHxqWPUtEGkUOG8B1TGJbaicKeXz/ql90otQAAGrYUiFQrw4I
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eenrc8BBXjQWPPaUCkdfvbncZQ8CHRdHaTKT6+0bOKctScvYeqP1eUPLuM?=
 =?iso-8859-1?Q?8/cdj0TXO9rYgfFQYqbJr6Wj76FJ0sXlGE7RTllnJj5V+7F8OBqJIzR/Vn?=
 =?iso-8859-1?Q?v6wt4UKYIPjWpaPFthci8b8yVexKu8xVae7tiCW2eOMoknfImU6X5aPk8o?=
 =?iso-8859-1?Q?hPuEhORBwXB4N6INfRKPShVrLyTm0/H5KZXMtQAHBu/Z0XCewdX2tNrJ6Z?=
 =?iso-8859-1?Q?hUIkcpoEw8CK4xMnvHq/NQJN/6AMIRYlPdHxxsvKST9oE0jLvEa2QV4RMI?=
 =?iso-8859-1?Q?mxbvhiw1Ow5eeEs2x/j+1l/5kf6oiYAKn6fbFGfsfzb45qLTrD2GDxz0Cd?=
 =?iso-8859-1?Q?cFGU+Zp4WC5CHBCFU/iukn6uRcns9b+UgXGzdlas72YF0NR+goDvpcvuYP?=
 =?iso-8859-1?Q?zWxbAl9lWwb2nt5EnbEr9/XaQh7HjoRzJfvSD3wILZkH/8PGtpJCJ8joNQ?=
 =?iso-8859-1?Q?sbrna8dnXSR57KK0iOioRjbQGDShozDa3lXr0N6ssEDmTvSxPe/QRWwtns?=
 =?iso-8859-1?Q?HEKJWp5o6sv7VS8Zdqv0/BXQAJBP2B8a8e20F1WNu7aLvv8Qpka08hYH5+?=
 =?iso-8859-1?Q?CrvrQG6QWvt59xA0CwPGrKSwmTr1GJAAuNSm82zAhPaYQHNmT9ee7wxShg?=
 =?iso-8859-1?Q?orfnMjLOrOW5hYu7C4I3norpgKGc4bUG4E53E3jJVjNB43iWD5JrjUST+e?=
 =?iso-8859-1?Q?doGSQD+gexzajEJfeb7o8EWJQnOLo8MW1mqsfSlyF/a07hzo15rgKXkptP?=
 =?iso-8859-1?Q?oVyaZDpWQRP2YAfqchDMlE6AvEEFcIo/xwY+QU1Tqp5grIIaQstYwO9fiy?=
 =?iso-8859-1?Q?AnGx17UuUImdvCbX+wwR/POGlskh75Lwp67XXqAWXX7ydX6yTU6IjHcOic?=
 =?iso-8859-1?Q?bJKrSyq1i6F7buflv5OW+vY0QthGu755uJbP2FGb47zgSf1oO4SLNFA7n9?=
 =?iso-8859-1?Q?P1awDfJpXP+COCb50KFXcUwU0E7q11ZBuiH6uiShUUk+3F41MuHAc5fiTB?=
 =?iso-8859-1?Q?DqckXs+dOZwn33XPXX+faUIeUopk/S6LDrNYyXVkreTRpddgPDgtsfOUOz?=
 =?iso-8859-1?Q?7fnqa6RuKHILfks3jZAXlTILiV0TNHXPuJU6sNi2/655aT51dXyddWrFru?=
 =?iso-8859-1?Q?zXGtepmTHSkaPKpO//0uq5Q2f4CMz2/0DNw0dLvNHbiHPcaCVOrEV9c4II?=
 =?iso-8859-1?Q?SqmPEsQ5nA4otu6KmqxqUXEUOmsPjOr1ObLPhmUBJ8Fo+fPXYthzESzlYQ?=
 =?iso-8859-1?Q?PxBGvjEy16gFzzcZPfBZBRBznEm6dO0V8li/WSkT4SaNfo7Gzhvxfk8NDK?=
 =?iso-8859-1?Q?1ac9WakZOEoJEO7/mfCOoCCo2BE1El96NBs8lvYix5Ybn3KxAdSAwfak4Z?=
 =?iso-8859-1?Q?4kDZWlB9OZJdXezXqJOGelMUTzDT7GZ8qN4qAsOYfQIQY65YgigPCivVUq?=
 =?iso-8859-1?Q?BHn+W9TeCJVBuWuYpA+Js8uprclL4XxHLvPczhZNDp2clGfrZ8PvrWukb6?=
 =?iso-8859-1?Q?ac990nF5jenSwWuLIfK8ooDzFiw8fJXYF/aUphCxWAMn9v9i3owCUSeR9s?=
 =?iso-8859-1?Q?RCc+/0yZTQbuRF3TnzBJIbrdISaYoADw+6BcbPrmqJrYtYlGJrBOotzp91?=
 =?iso-8859-1?Q?Vqk263p9npyXgb2IPP5b7Z6RbPQaMnrk9c7sVZFXOrtJgAc9t1hNp7Q3YI?=
 =?iso-8859-1?Q?OEacPVeVB1EcEdoav8m4Dj/rFQ75eCfUhch7CEIiDfHXPaB7UpM9qSP3Wj?=
 =?iso-8859-1?Q?4ZQ2HkZwf50kR35PZhcxRRGPQdiQyHgKBqHqTW/U5dCb0++MhLIQLcUD8A?=
 =?iso-8859-1?Q?GqTHaWsxXg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b5f1e9-c64a-4eaf-b7a3-08de75a4ce7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 02:06:23.2055 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26y2qLYljPD9Vf5GsffBH/IwI9QywIJiIA1kgaIi7Skp+XZ85NhvhHZyTF3e+JhRUIJC7dWTUrZvGVjqDySAet9ZV2Wd98kRaD7HpogOteM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7863
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_NONE=0.001,
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

> Subject: Re: [PATCH v7 10/10] virtio-gpu-dmabuf: Create dmabuf for
> blobs associated with VFIO devices
> >>>>
> >>>> On 2026/02/23 17:00, Vivek Kasireddy wrote:
> >>>>> In addition to memfd, a blob resource can also have its backing
> >>>>> storage in a VFIO device region. Since, there is no effective way
> >>>>> to determine where the backing storage is located, we first try to
> >>>>> create a dmabuf assuming it is in memfd. If that fails, we try to
> >>>>> create a dmabuf assuming it is in VFIO device region.
> >>>>>
> >>>>> So, we first call virtio_gpu_create_udmabuf() to check if the
> blob's
> >>>>> backing storage is located in a memfd or not. If it is not, we
> invoke
> >>>>> the vfio_device_create_dmabuf() API which identifies the right
> VFIO
> >>>>> device and eventually creates a dmabuf fd.
> >>>>>
> >>>>> Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> >>>>> the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> >>>>> fall back to the vfio_device_mmap_dmabuf() API to get a
> mapping
> >>>>> created for the dmabuf.
> >>>>>
> >>>>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>>>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>>>> Cc: Alex Williamson <alex@shazbot.org>
> >>>>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>>>> ---
> >>>>>     hw/display/meson.build         |  1 +
> >>>>>     hw/display/vfio-dmabuf-stubs.c | 23
> +++++++++++++++++++++++
> >>>>>     hw/display/virtio-gpu-dmabuf.c | 32
> ++++++++++++++++++++++++--
> >> ---
> >>>> ---
> >>>>>     3 files changed, 48 insertions(+), 8 deletions(-)
> >>>>>     create mode 100644 hw/display/vfio-dmabuf-stubs.c
> >>>>>
> >>>>> diff --git a/hw/display/meson.build b/hw/display/meson.build
> >>>>> index f5f92b1068..7d2bd839cc 100644
> >>>>> --- a/hw/display/meson.build
> >>>>> +++ b/hw/display/meson.build
> >>>>> @@ -70,6 +70,7 @@ if
> >>>> config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> >>>>>                         if_true: [files('virtio-gpu-base.c', 'virti=
o-gpu.c'),
> pixman])
> >>>>>       if host_os =3D=3D 'linux'
> >>>>>         virtio_gpu_ss.add(files('virtio-gpu-dmabuf.c'))
> >>>>> +    virtio_gpu_ss.add(when: 'CONFIG_VFIO', if_false: files('vfio-
> >>>> dmabuf-stubs.c'))
> >>>>>       else
> >>>>>         virtio_gpu_ss.add(files('virtio-gpu-dmabuf-stubs.c'))
> >>>>>       endif
> >>>>> diff --git a/hw/display/vfio-dmabuf-stubs.c b/hw/display/vfio-
> >> dmabuf-
> >>>> stubs.c
> >>>>> new file mode 100644
> >>>>> index 0000000000..12f016f0c5
> >>>>> --- /dev/null
> >>>>> +++ b/hw/display/vfio-dmabuf-stubs.c
> >>>>> @@ -0,0 +1,23 @@
> >>>>> +/*
> >>>>> + * Copyright (c) 2026 Intel and/or its affiliates.
> >>>>> + *
> >>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
> >>>>> + */
> >>>>> +
> >>>>> +#include "qemu/osdep.h"
> >>>>> +#include "qemu/error-report.h"
> >>>>> +#include "qemu/iov.h"
> >>>>> +
> >>>>> +bool vfio_device_create_dmabuf(struct iovec *iov, unsigned int
> >>>> iov_cnt,
> >>>>> +                               int *fd, Error **errp)
> >>>>> +{
> >>>>> +    error_setg(errp, "VFIO dmabuf support is not enabled");
> >>>>> +    return false;
> >>>>> +}
> >>>>> +
> >>>>> +bool vfio_device_mmap_dmabuf(struct iovec *iov, unsigned int
> >>>> iov_cnt,
> >>>>> +                             void **addr, size_t total_size, Error=
 **errp)
> >>>>> +{
> >>>>> +    error_setg(errp, "VFIO mmap dmabuf support is not
> enabled");
> >>>>> +    return false;
> >>>>> +}
> >>>>
> >>>> This is VFIO's implementation and shouldn't be here. Follow what
> >>>> hw/vfio/iommufd-stubs.c, the previously-mentioned example,
> does.
> >>> Ok, I'll move this file to hw/vfio directory.
> >>>
> >>>>
> >>>>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-
> gpu-
> >>>> dmabuf.c
> >>>>> index fdcf8e53a2..3f39371de1 100644
> >>>>> --- a/hw/display/virtio-gpu-dmabuf.c
> >>>>> +++ b/hw/display/virtio-gpu-dmabuf.c
> >>>>> @@ -18,6 +18,7 @@
> >>>>>     #include "ui/console.h"
> >>>>>     #include "hw/virtio/virtio-gpu.h"
> >>>>>     #include "hw/virtio/virtio-gpu-pixman.h"
> >>>>> +#include "hw/vfio/vfio-device.h"
> >>>>>     #include "trace.h"
> >>>>>     #include "system/ramblock.h"
> >>>>>     #include "system/hostmem.h"
> >>>>> @@ -82,13 +83,21 @@ virtio_gpu_create_udmabuf(struct
> >>>> virtio_gpu_simple_resource *res, int *fd,
> >>>>>     static bool virtio_gpu_remap_dmabuf(struct
> >>>> virtio_gpu_simple_resource *res,
> >>>>>                                         Error **errp)
> >>>>>     {
> >>>>> +    Error *mmap_err =3D NULL;
> >>>>>         void *map;
> >>>>>
> >>>>>         map =3D mmap(NULL, res->blob_size, PROT_READ,
> MAP_SHARED,
> >>>> res->dmabuf_fd, 0);
> >>>>>         if (map =3D=3D MAP_FAILED) {
> >>>>> -        error_setg_errno(errp, errno, "dmabuf mmap failed");
> >>>>> +        error_setg_errno(&mmap_err, errno, "dmabuf mmap
> failed: ");
> >>>>>             res->remapped =3D NULL;
> >>>>> -        return false;
> >>>>> +
> >>>>> +        if (!vfio_device_mmap_dmabuf(res->iov, res->iov_cnt,
> &map,
> >>>>> +                                     res->blob_size, errp)) {
> >>>>> +            error_report_err(mmap_err);
> >>>>> +            return false;
> >>>>> +        }
> >>>>> +        error_free(mmap_err);
> >>>>> +        mmap_err =3D NULL;
> >>>>>         }
> >>>>>         res->remapped =3D map;
> >>>>>         return true;
> >>>>> @@ -145,7 +154,7 @@ bool virtio_gpu_have_udmabuf(void)
> >>>>>
> >>>>>     void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource
> >> *res)
> >>>>>     {
> >>>>> -    Error *local_err =3D NULL;
> >>>>> +    Error *local_err =3D NULL, *vfio_err =3D NULL;
> >>>>>         VirtIOGPUErrorType err;
> >>>>>         void *pdata =3D NULL;
> >>>>>         int fd;
> >>>>> @@ -158,12 +167,19 @@ void virtio_gpu_init_dmabuf(struct
> >>>> virtio_gpu_simple_resource *res)
> >>>>>             err =3D virtio_gpu_create_udmabuf(res, &fd, &local_err)=
;
> >>>>>             if (err !=3D VIRTIO_GPU_NO_ERROR) {
> >>>>>                 error_prepend(&local_err, "Cannot create dmabuf: ")=
;
> >>>>> -            if (err =3D=3D VIRTIO_GPU_GUEST_ERROR) {
> >>>>> -                qemu_log_mask(LOG_GUEST_ERROR,
> >>>>> -                              "Cannot create dmabuf: incompatible
> mem\n");
> >>>>> +
> >>>>> +            if (!vfio_device_create_dmabuf(res->iov, res->iov_cnt,
> &fd,
> >>>>> +                                           &vfio_err)) {
> >>>>> +                if (err =3D=3D VIRTIO_GPU_GUEST_ERROR) {
> >>>>> +                    qemu_log_mask(LOG_GUEST_ERROR,
> >>>>> +                                  "Cannot create dmabuf: incompati=
ble
> mem\n");
> >>>>
> >>>> This logic is faulty. err is not set by vfio_device_create_dmabuf(),
> so
> >>>> it reports a guest error even when the memory is compatible with
> >>>> vfio_device_create_dmabuf() and it raised an error for a different
> >>>> reason.
> >>> Maybe I misunderstood your previous comment about this but I
> >> thought
> >>> we are going to assume that if both virtio_gpu_create_udmabuf()
> and
> >>> vfio_device_create_dmabuf() fail (assuming Guest error in case of
> >>> virtio_gpu_create_udmabuf ()) then it is reasonable to assume that
> >> Guest
> >>> is at fault for passing in incompatible memory addresses.
> >>
> >> It's not what I suggested. What I suggested is as follows:
> >>   > virtio_gpu_create_udmabuf(res);
> >>   > if (it turned out the memory is incompatible with udmabuf) {
> >>   >     virtio_gpu_create_vfio_dmabuf(res);
> >>   >     if (it turned out the memory is not backed by VFIO) {
> >>   >         qemu_log_mask(LOG_GUEST_ERROR, "incompatible\n");
> >>   >         return;
> >>   >     }
> >>   > }
> >>
> >> https://lore.kernel.org/qemu-devel/c7c03384-4815-4032-89bd-
> >> de1ef90bb949@rsg.ci.i.u-tokyo.ac.jp/
> >>
> >> It is not correct to assume vfio_device_create_dmabuf() is failed due
> to
> >> a guest error when virtio_gpu_create_udmabuf(). For example, when
> >> mmap()
> >> fails in vfio_device_mmap_dmabuf(), it is a host error, and reporting
> a
> >> guest error in the case is a bug.
> >>
> >>>
> >>> However, in order to fix this properly, I think we would have to
> have
> >>> vfio_device_create_dmabuf() return
> VIRTIO_GPU_GUEST/HOST_ERROR
> >>> (or something equivalent) which I was trying to avoid. Do you see
> any
> >>> other proper way to fix this issue without messing with the return
> type
> >>> of vfio_device_create_dmabuf()?
> >>>
> >>> The reason why I am hesitant to make vfio_device_create_dmabuf()
> >> return
> >>> Guest/Host error is because a future user of this API may not need
> this
> >> info.
> >>
> >> A future user may not need it, but we need it to make this code bug-
> free.
> > Ok, I plan to add the following enum and make it available to VFIO
> and
> > virtio-gpu-dmabuf.c:
> > typedef enum DmabufCreateErrorType {
> >      DMABUF_CREATE_NO_ERROR =3D 1,
>=20
> When there is no error, vfio_device_create_dmabuf() should return the
> file descriptor instead (see e.g., qemu_open()).
Ok, I'll remove DMABUF_CREATE_NO_ERROR from this enum and follow
your suggestion to return fd in case of no error.

>=20
> >      /* Guest is responsible for this error */
> >      DMABUF_CREATE_GUEST_ERROR =3D -1,
> >      /* Host is at fault for this error */
> >      DMABUF_CREATE_HOST_ERROR =3D -2,
> > } DmabufCreateErrorType;
> >
> > Is the naming OK? And, what would be a good location (header) to
> have this in?
> I would prefix the names VFIO and put it into
> include/hw/vfio/vfio-device.h.
>=20
> In that case, using it for udmabuf is cheating, but I think it's fine
> since it's locally-contained in virtio-gpu-dmabuf.c, its intent is still
> clear, and it has no adverse effect for users (at least there will be no
> bug).
Ok, got it. I'll rename and move the enum to vfio-device.h.

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
> >>>
> >>> Thanks,
> >>> Vivek
> >>>
> >>>>
> >>>> Regards,
> >>>> Akihiko Odaki
> >>>>
> >>>>> +                }
> >>>>> +                error_report_err(local_err);
> >>>>> +                error_report_err(vfio_err);
> >>>>> +                return;
> >>>>>                 }
> >>>>> -            error_report_err(local_err);
> >>>>> -            return;
> >>>>> +            error_free(local_err);
> >>>>> +            local_err =3D NULL;
> >>>>>             }
> >>>>>
> >>>>>             res->dmabuf_fd =3D fd;
> >>>
> >


