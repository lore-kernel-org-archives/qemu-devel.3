Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7488EFED2D3
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 05:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Ynm-0007rJ-Ri; Thu, 12 Mar 2026 01:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w0Ynk-0007r2-N4
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 01:41:40 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w0Yni-00060b-9h
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 01:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773294098; x=1804830098;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hN0SO9oqrzN+JL/dqZBuVXuH9keRSi0MqTYmQlHTdqU=;
 b=FKPXTts6/P1X6ehRJThU6rd4NqbOrCC+C57NzWuT5yJTJ2WP3FANaz9k
 AGoLh7o+eS+oVfbZz77rwM9B2b6g9wTBcJbljMRZXO3vOKCTAO4owE1Ej
 sXm2XRMvpP/VacrI++Zjp9zag/60zHa3v5dm+/HT2gl6dI3IN51J5HuGk
 d88og/41YNBr5P/3vscBFd5yAD4jHLbSrL5k5ISwvLBkR/3HqTc/+O/ZR
 4LVGx669DfQ/ekdt/WvYsNdcoagysUPqelDJnRyI9A7tDanz4KmY9OpF2
 PwniN8Kx0tHB1c1vlDM2zNCVkUoev8Mf8TIvoiSIPS7tzrgLEk8cnOli2 w==;
X-CSE-ConnectionGUID: n//+l7yzSxKQmTiMDThDCw==
X-CSE-MsgGUID: q6mHP7H8TXW+JViPJxw4aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74254568"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; d="scan'208";a="74254568"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 22:41:32 -0700
X-CSE-ConnectionGUID: C23ubzXLTPelbShucRvJHA==
X-CSE-MsgGUID: hmAuNgBoTxCAppg1GrNIBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; d="scan'208";a="258613633"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 22:41:33 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 22:41:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 22:41:31 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 22:41:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhtpfEL9CLvYH5P2WLew95y14V9ti8oc6CNbNTnukTfPplPBXuTqW4e2kmcQ7DDjwABq/GMEn+5SMEEUj2u8aKSzKARZOt4+9j3J/8brhAts12lT+NzVYddLGAqNSGoemBMmne+WN9onsoCOvu0vV93HaMv+qX4EjTHpFHCCYhDsVh72862h/Z6JhPd74qvePMfriEBQtJy5rSk4AILfor8tMVKbIRPlmlrcFL3JcCgs26Pkg5pL8HKS7CrtnpROITF+t3TI59reHsr3CLrQyzp7TOhyYb4oV8eQYCcx5gjry7nlwYMPv36HapJpVy/ojEV0oDsSQ/j46KQV/zzhGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hN0SO9oqrzN+JL/dqZBuVXuH9keRSi0MqTYmQlHTdqU=;
 b=lGj5Bs5ZR9utmoYBYGW3Hs9hS8pHxdeldYs5RG80N4CMpYUeFlhK7Sk38FZLWpdc5XdzO8yF1amfsw0VecghWHcw+ac/tGAXdsTnFH4fz0mu9gJQfcpaAwnValvtpGwKUDIc+t+BM+eLVtab040PQhd8n7ZhM2cShTn+dUVVWE2FUaN3GcN3kLOH65BnDZErYnsAOZQsxjd/j0VXfZh40SIF2mylLgtm4f+Px9o1tfp5dKEytsDdWCWM8vOVFL5fPTO760PfykoayzNA5NNzw40uj6wZ0wckdKrfnU9CIqadEu0es5js2Za+4Ze1Td/jmy6xJ6syA+kAducnxlINSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DM4PR11MB7253.namprd11.prod.outlook.com (2603:10b6:8:10f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Thu, 12 Mar
 2026 05:41:24 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 05:41:24 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v11 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v11 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcsQKvhlyWHsvpDkKW/EAlR6lOwLWoy/CAgAFO1hA=
Date: Thu, 12 Mar 2026 05:41:23 +0000
Message-ID: <IA0PR11MB7185D57A5228ACBD883CCA99F844A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
 <20260311025340.1335673-11-vivek.kasireddy@intel.com>
 <04fa350a-b181-483b-8cbd-2ba5171174ba@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <04fa350a-b181-483b-8cbd-2ba5171174ba@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DM4PR11MB7253:EE_
x-ms-office365-filtering-correlation-id: f0862584-5902-4e3c-d509-08de7ff9ff59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info: SSKUYpziizrF0QDbWJgHeG7NMnjqMin/28BbOzbqu0MMTbUMyT91eJbxgjD9Gh+NYtugCeFNOockFpyvfWTncQD1sQpA41pxpi2E4PrUrmI5CzGHpUnDbRq82I/G3dG+EksjPIKjV5Ueil8uMNyck140SiDCDzH8DLzv12hJ9zuijIxJEgx05qxOpGVL+25lM29G7flqwpOZ9LA/JY/tHJLGq1CkVaLwDRUozQmUzdiNrK0HBP5zKJjN15kMuEXEk/pNS/rhLDLVebPxk5LEPNv3ffaGnBXB42jyyhntAyrFU+75Nen8uTMYhNjWJQ9ksvcPIeXWfji0Ru6fvP7EiZ9IHLPny1BLRuC7mkQdUITHM+vcXlldoWTcKP8mgfBfQ8tBcaz8T+WLuSdyx9K9Japa26ScKFXXy9lv3uolqBjFYlgQ43IYDi5gTCp21o6NElUo/8LjKLAY2R+7m7u+HHj4TT4l2AAi03UjSwjNm1xZbF2WqcoAHBCE7DC3/zLxKqc9mCYG7g810sV71xaXYqsTMKyemum3tEBJqpOm2nOubizyZigbaPPYPo1MAC5TZ1+ATBd+qYB6UF+jn1b+XOiuGfHLCGNAFUdA9J2Juw+OoXNgfhiJxz81Q8x9koVxkw4FmunBGk7zoQG+17qGUQINTelRQYKErgjSxhbti+k6IWLic3l5cwxb3123dPoNobyxzHSRlHdKZDe04LRbF1dKuB+GH9Srar8J8EyxLhNFw8sEpfVPKlN9Ul25ZbX2Kf107DG3vtOdLiAhlI9uDUZiQMQDAlROK5mZTzst2GE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jHFc3bnzB3XLiClJUvTuERV2mAcyUc1mqhhALrmTsX9Bq0su03HL380udy?=
 =?iso-8859-1?Q?XWpRx7WEyLLpOq/cjkj78fRwl2hsT8BjgreoMkmRtLeVaBri+35EmFO54m?=
 =?iso-8859-1?Q?CjXbWnMN+AVBMW5QtOHPW4iGjLDnpIge/CyEEeU1mKuDkRWUnUmASSrpTq?=
 =?iso-8859-1?Q?jwm9N/+3YhsudWUA0lMOHsJ73vdI+QWd5Rqf1naMxN4wkQbmCnAhoQ8Rp1?=
 =?iso-8859-1?Q?2M+/vFd/wcLpKaEKMXbjs/Q19nI9ZQ8gynLvareJxv5o4lflpwmuauxl5q?=
 =?iso-8859-1?Q?Teu2trgSJ6UmmPgOWzlK/w2MRjEzckM2x2Tdq7nAUkHrxMHDaKjwf5zVbq?=
 =?iso-8859-1?Q?VLcdVL03C/3mmShipHwlqo1B+8S5Pifu7r1+3wDBpV7dCtNPCwn4Jts6wW?=
 =?iso-8859-1?Q?XS02n9PdR++E+fRaaQWX//JW6xOrKFfk8Fa0/pGSUYO+R81baq+O8C1amR?=
 =?iso-8859-1?Q?/fujS3c5aulhMoG91jhx5tAeKDmVyj3D0tkk4UN6fg7fAslgd4CLdTrFI6?=
 =?iso-8859-1?Q?hu/LCIKpa8Njk2n9XYgHuksWHafq2U2kMtkgIC9/Hdt2pAv/5A4pRAmbB3?=
 =?iso-8859-1?Q?o7ix8jbGCXU8MgmKR4QjS8/VKQS19tkq3LKJZvuE1l4/rYrws2BJGcbxrW?=
 =?iso-8859-1?Q?tNxIAKGqKfH7v+Tbz2eepRdntQXJE3uhhVrZLghoXLokSo4HLwlzzpoiVz?=
 =?iso-8859-1?Q?WeFTL1J5Z1vt6Nyz06qvAPsjbF434OnrRiBK1EZWOdY4URkFTPv3bFFtSK?=
 =?iso-8859-1?Q?XOTcCeDxOHmPNPNLurzkf2KRMYBzeW/o7zZqMmTSmlx4XPWRdgGSgd0me4?=
 =?iso-8859-1?Q?aScrv2nY2RIjPJhMKTsrHe9ig6O5RU8Y19nb8jH2BKERqMF7rIT/h5tTQQ?=
 =?iso-8859-1?Q?TQg9XxdD5W/wo4n2nhC1ZxPi4AHGXksiT0CzQwl+LqIxjfKOWK8qoBmlDE?=
 =?iso-8859-1?Q?VL4uE1jl0IYU7s+uCnPuO6AB5X01tDvjirqQLiIEaOqCLmygCzT3d3iTXI?=
 =?iso-8859-1?Q?+KhCtDeL2KIyX44uuyhQrOTUeIaaMyctCOHMLQokgyeGND6J2CIt9WRfuD?=
 =?iso-8859-1?Q?CqzrDfZB1H/rx8bsn7n59n4KVg5kG4r+7M1X6qIuVUMGD7nVOBJrTS/5W5?=
 =?iso-8859-1?Q?D7kUzskR2yx5IM4PJQXnt6GpmcRdNVc0v0J5pcSdxQUy8Vnf6HoumayG0V?=
 =?iso-8859-1?Q?0jU0cqgdY7F9GnyvuEV1b/Uqhh/9oiWhyZqz0yvfpBa3zzQwkxh3zI3S8u?=
 =?iso-8859-1?Q?aEWk39HdIMeMRe8o5GQB7kyf8MX0HBBN4/+Lto+YWwHXsajAy2pn+6I3mZ?=
 =?iso-8859-1?Q?FLfTr1r2Dc0PJFM8XTnwL9KALD+3zw14o4AyMXA+nIXl8VgS8oxxRQxqm4?=
 =?iso-8859-1?Q?5TegViemFwiEJVTJB074iw4H5Kt85rItM6pNXl+ljLBXBx/7gV0kShSEKc?=
 =?iso-8859-1?Q?jHUdsZBMLiU0Rruglzq8PnzYcVsAu2l3Q9cW6vFVOgrlrDsESb43LSp7GG?=
 =?iso-8859-1?Q?JTuFPGjUKP7dHSvoVie65sAqAPTMYiDfpv9gZtw3L56P74ZZpnb6dxhGc8?=
 =?iso-8859-1?Q?L0x3czQzUyUZ8Ogp3KBBgSQG2Cc8BA0sfUsPL5v5PRO+1zPj/CFptEIaQ8?=
 =?iso-8859-1?Q?3iLikX088W3WTLfTlTVQeZYk7CNdfHInYd2SbNPSW99++PriIdyfUgg3gl?=
 =?iso-8859-1?Q?GWge+9+Bv0GKr3K5ZpMr2yCn3KBTT5ekE4DqNJBknuMw3XXDRaF8OvWuIO?=
 =?iso-8859-1?Q?WqkCSWeULv2euBGsIiMxUfNW6/NSLFdX+cBnz5E0NW1SLFvjPdkHonj/Le?=
 =?iso-8859-1?Q?S/eM78u34g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YcOcdS+SqK2nwVwdNFcVCDQECV+L3NmLj3HFrYP5kTn23OoFKrHCoMj+DwKmHJ0WI9t7w3SiF9ZGzxyTcsgvaxrb0W2RCkVyzDxnNQj3CGQqTlTl8fH3vyn/O0b0TIhRfzxm7UNiOVdmNsHav4kUEwBmhfTijbERPBOh5wF8dINCXZERCiQCVkTR34ZVuqG+r0cEvz+rKBU8PKENk9qEiDj9qMO5KUnvtxFdnsGIEfYs/Y4yr5PSLkL+2RS2JSqesDClGWNpRnjeQPUKqdKz3PV9Hgg9P1Cgq+B6vfLLEo42WzwwgQrpnVt/cbOuPOJcXsMLDtZhMdCXWS5sDYllmg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0862584-5902-4e3c-d509-08de7ff9ff59
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2026 05:41:24.0302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yWNzxWCOS3NIaGk0yHI/Dsqox9aA7u3DSzj0Y7FEmXpqCoVA3TA4tGH6aY1+Q0qPsl5v98DGhKElyeI4r7lVVage/Kw+55v5WQhpysSw8wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7253
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
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

Hi Akihiko,

> Subject: Re: [PATCH v11 10/10] virtio-gpu-dmabuf: Create dmabuf for
> blobs associated with VFIO devices
>=20
> On 2026/03/11 11:50, Vivek Kasireddy wrote:
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
> > dmabuf fd was created via virtio_gpu_create_udmabuf() since we know
> > that the udmabuf driver supports mmap(). However, if the dmabuf was
> > created via vfio_device_create_dmabuf_fd(), we use the
> > vfio_device_mmap_dmabuf() API to get a mapping for the dmabuf.
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>=20
> Now I think this patch implements proper handling of all error
> conditions and conforms the convention.
>=20
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Thank you for taking the time to review these patches!

Thanks,
Vivek


