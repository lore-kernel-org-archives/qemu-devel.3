Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0324EC30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 05:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPb6V-0005LS-5B; Fri, 05 Jul 2024 01:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPb6T-0005Kz-DE
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:03:25 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPb6R-0003dq-BM
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 01:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720155803; x=1751691803;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=n+KWipWUJfWSA2mhPfNQC43RVT4lkeLpK+cxoqpKD4E=;
 b=VnOqRd1Lpmc7D01+DqUg8orV9wHWGyE5G2RDg39PDLVlAcyutTjj6pPk
 baikHeNg6wy8ILPP1WPizSaIT2TO69zT3lFmzjWmrd4l9lMcCH8TgirsH
 bRh1Qq6SyxdvgfBcg2Y+We/1w3CuWxAqhyfnSJU2cDDxS/JAQUxuRr1F+
 iRfmqy932ypIhj602v7rFn0oYo64tw3/+dW5bGQbdeRsANx0kM+3i9tIV
 A6EZ0h78/kQodGkPz+ySfoN5t3vxI8WtgnVLpay7LfXJtdx7pYjw02ngZ
 EZk0NZwickOHref8tVo2Mx7h+uqID0g/eofzwnWbnj9qB9ReUuBpYTcMR g==;
X-IronPort-AV: E=Sophos;i="6.09,184,1716242400"; d="scan'208";a="16030231"
X-MGA-submission: =?us-ascii?q?MDGEHUwOIuPgVdBdVf16c1kNXZ42L+f3kxqHpL?=
 =?us-ascii?q?BabrcBpQbhj5jg0Rgy7ECm1tWpS1V6KyJzyn7DPD/xFiQm/aMWQYHdgH?=
 =?us-ascii?q?SK3MzEN79eLg8L2Q9m+kY9YzHEqL5f+39YNtV08440beR2BZv5EPGf/n?=
 =?us-ascii?q?NOIeKawb/mM4L51kxXcjje2w=3D=3D?=
Received: from mail-vi1eur05lp2168.outbound.protection.outlook.com (HELO
 EUR05-VI1-obe.outbound.protection.outlook.com) ([104.47.17.168])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2024 07:03:18 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZeR8yOeCg/GnOujNsxAs9NfKuSsk/9qDxXwjxOCkZ11bALkQk+2SffCu0dSj8A2RyBr3Uk8T71gDrBpeSqeC4QP/1yN7DQDOAE80F68XhRQ+hZwLxy53XLBY3cz+c9828+tBcPkOHDP5Ynsh4suRNjw2/CJL/eIXtAnc6d5gkuM8eRaVH5JGFE2rtrhHIygebNBHGAd+wU/TAs6KaGnGetOyVvPbB4sIm1Ea12cuvConXt6efCVBE/U6atiT5OO1/a/CzchptY6RkilOyxt+ShLFPvUuTY+L6bnMe16/ctf/n2fnT0bgMxOqgcufT/MCj9RMB9jBSz1sntkbgmxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+KWipWUJfWSA2mhPfNQC43RVT4lkeLpK+cxoqpKD4E=;
 b=axgUejzfv28JHZhnt/dwpsGSlco7/2EedyIlQ8GVH/DqPRnlaAk8AGs6YWAd/Huv83P+WleO2pDzTvu1qFNQW9Kh29lGRMf26QFzmTaEr88OgdnUyDjqSlx4oFHLPFSJdcEPLbLCl1GH2tSKnffOIpls4w/RedOOfx/X2JdGMsGAEltEqNYTnN01kVAepwmO/pVbISpOcLRc8ZKFCPGSA92785uqDrIDfYMS962EducTDF/g4ovF074zZmslLbLD6pxlIEm+eC9c3VhVv0lqP+sweRTGPiX0Ao4b6pxVilm7GDBR/4ZZ+ir9XoEIcYeXxNea7BGEEhqOUYZbHuLEKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+KWipWUJfWSA2mhPfNQC43RVT4lkeLpK+cxoqpKD4E=;
 b=Sbf5drm6Ecp832cjI/tgQtbLh37hRy2bfH9p4cgeJAcQGJTwm4WWNheWuhW5CxgM8KJAjjeEGjnp5c/QyjZi1X3G8BojJGGb9IhMn7Vx5JT8W6MN825lFHALFgFEtaNpFUWma5VuSTwR/+BnS8BymorDyXgN8QpG26UJj6rrjZUfVTQP4swwVlZbvyQ+vP6Om4/+9RyWhTvn4WeXPBa2kt1f2iLqxTiCCJ0fGPXIvGmBsrCgkq2tZcMw3KinIN7rkCDPdy+uNEPrP2I0l5gOmbhO2lGH+WAT9p30mwrmslgwezpNWBd5bact0Nep0HFLR8pdMqevY9M1fmz/ekhJLA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6542.eurprd07.prod.outlook.com (2603:10a6:800:179::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.11; Fri, 5 Jul
 2024 05:03:16 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 05:03:16 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH  v3 1/3] intel_iommu: fix FRCD construction macro.
Thread-Topic: [PATCH  v3 1/3] intel_iommu: fix FRCD construction macro.
Thread-Index: AQHazpilPvi8AA6UY0+AS7/gkgP0ZQ==
Date: Fri, 5 Jul 2024 05:03:16 +0000
Message-ID: <20240705050213.1492515-2-clement.mathieu--drif@eviden.com>
References: <20240705050213.1492515-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240705050213.1492515-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6542:EE_
x-ms-office365-filtering-correlation-id: 91f817e6-5f3f-483c-79ab-08dc9cafc7ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bVZIMXBod0kxU0NsL0g0RU5wRy9WRlVPSlVPQmJSQ0xrS0JMRFZhWngzakV0?=
 =?utf-8?B?cVRaMWU3eDNTNTV0QkNtKzY0RTRycmN1Qm9OMWVJM0FyQTVHTTFvVzBxTENX?=
 =?utf-8?B?L2I4dHlSSUY1N21IM0NPbWcyZS9jUDhod2RFOXptUExtZ09ZT1A2blB6NnlC?=
 =?utf-8?B?bVJkeVQ4TDVXaTlNN2VZZlNXQmo2ZWpkUXMzRC96bzFNQ00ybSs5RFNyYm9v?=
 =?utf-8?B?NStsS045dDVXT3FUbG44Z0FKekhpZitaUC9GMHl3OTg0NHJFNUd3OEg3UEdI?=
 =?utf-8?B?ZmdwZ2xEZXNiS3BMdHJmdURzcFhwWWRFZWZKTlpvNzhPUmlhakhQNGxJYUxv?=
 =?utf-8?B?WGFlOExKOFkzMm00SVE0clQ3V0QwK09ZeEFIZk5RMmdObFpnQ3dCUVVndEZ5?=
 =?utf-8?B?ZmdEeVhCd3NMWklVcmZuNUdhdnlsYWxDdGtqY3BTTXRYbldXdUNCbXYydU9S?=
 =?utf-8?B?allnMmZVTUJ6K1VFY1p5M1g1SmJ6djFSMW93TVdJK1podG1seTZFd2tLeU55?=
 =?utf-8?B?VnRUVldPNEZQRkdJWDRmYzBtKzhXYVk5STgyOVJPYVBWVG00Q2ZNVVU0OGo3?=
 =?utf-8?B?bFhFeTZZQjZJVGdtRUpsZldBUElYWWhWbXpjLzJGQnp1R3BJSGxLcHZxdjBY?=
 =?utf-8?B?K1JwR3RjTGVML2lxakhzeFROUU9XdmZJWW9kTzBEM2s3QysvNVZZaGxNS1dm?=
 =?utf-8?B?L29KRXp6Zkw3MjN4dDBENWlOSWZoRFQ0SFlNdFg5VTFjSDdJb0E5QmNxQzFX?=
 =?utf-8?B?bmlVNEhBRytyaWNWQU1pVWtYejZwNFZSbC83bW4rT1lFV0ZabFREc2lsTDdS?=
 =?utf-8?B?bzRNeHVyTHZhSGpZMXpjZ1J4ZXdpOTdoOUtGdWJLYngybW42R3NQdHE2ejkx?=
 =?utf-8?B?dld2UVNYRVhQTDJSSWNiSXBvdkJSL0pTQ2ZsbFNYc1VlNjRkUEM4eFdERWRh?=
 =?utf-8?B?dTh0cXBEMEE2QktsVlA4dXBCdmJ4dm1ZeWZwWUpmdkE5VUZDem1WQktNenhZ?=
 =?utf-8?B?NVFyaFdrRFpEYUx2WHFGVGM4ditYaGhWQTdhc3lCT3A5RkRnOWJQVnBVeVg3?=
 =?utf-8?B?QlpiU3dhb2h6UWpqR2hZZXczQXJSUWVWZ1h4SVBqQ0RzMTFGcUhMV0ZaRVRW?=
 =?utf-8?B?TE5TTDZMRExTWmt6a2o2WndDN1BXTkVIQ3UvdXdsMzNQS1dzSHUxWEw1NDJP?=
 =?utf-8?B?WUU5anJ3U2NXL2luM3QydDhBSUEvYVV0MmRWd0UxQmdlNDB1QnN2UTBCVDZQ?=
 =?utf-8?B?WU92UkUxeGc1TVJzYXM2RXhyK1oyL1JveVg1UE5uYWVmOUhJSFRHNzFVM2Nw?=
 =?utf-8?B?ZGlsSnRlZ0hBdjZhakZvK21JalJ1aFJzS2ZVRjdtYU04SlVIY0NpaFBFRmV2?=
 =?utf-8?B?TUFNUW00cGZvUXdXUUVQaGZyRncyVXJCdVJ3a2ZPZjk4TjJqQkhPRFFWN2pw?=
 =?utf-8?B?K1NVYW81S21FVlhzSjh3MC92RjdIaDBQUHdadnRydXJQZDNBU1pyZjE1U0do?=
 =?utf-8?B?S0lhMUE2Z2ZnV1hsTlRGeXJ6UnBtbTY4WDBXL2h4T1QyL1BXVFV2b1RSNFh2?=
 =?utf-8?B?RmVaR1NycTVUeEJkV2tWZVlOcVpLeEZVbm9RV3lqNGJwOEhpQnIzSlB5REFq?=
 =?utf-8?B?QjBXREtCbGtBZ3N3MVloSHBnN2hFdG16THRRMnpFTEh0UU9laWF0QlU2dVhO?=
 =?utf-8?B?RWxmR3p3bnUyKyt3T1dYeFpaYnMybDAwL1V3aUZYblpKbTVRcEM2eTRRYm1Q?=
 =?utf-8?B?d25acHQ0NjR2NFhHdkdwcFJUakNUWEFJMDVmd29jNS9TK2RCVklmZTJ3clVr?=
 =?utf-8?B?ZFV1YUVrbUlQdW0zbmpYeUNSYVZsMmtwZFdySHZCS3V5bjQ2YVcwYkIyeTIy?=
 =?utf-8?B?LzkwRENVd1NDN0U5anU2WVNmbGl1S2d5ajlYYy9YYmphQ1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVdzMWJvUGNwREQ5M3ZObWc3bmpRcm9qa2ZxK0NwVjRRRDBqaFpGTkFpYUxM?=
 =?utf-8?B?MFVmR3ZJQmpvMkc3TDRPTU9tOElVcFVWdWQyYU9Sak8wWmlrZUYyNWVJaURz?=
 =?utf-8?B?aWNiTk5POGk1MmRaejBZbWZDcGlPZGd2VGVpaFQrbHRRM3dqUXpxc2tJZ25x?=
 =?utf-8?B?Z3Y0cGRUWnN6a2RHMEZONFpsN21PVDRFL1hMdWh6aGFnb1NzNWZET0hnajA5?=
 =?utf-8?B?MkxCVkFjT1FBMVNaZmd6REtWRjgxNUlrRHRUb2xsR1IrS1cxcU5YNTNlRWp5?=
 =?utf-8?B?N0pJZEl6MktpWWtOQVJ2a1BkQWdDWlZLTmJVYjMyVElreGlZMmJhUUJvdWtB?=
 =?utf-8?B?ODAxOFg4YnBqQTlRVW5ZcndKL2g2TEhuQ291YmtYVDVhT2tWcjJNWXNxQXVC?=
 =?utf-8?B?WnNxWlB2aEhlNXZJbUZUb2F0WEYvTm1DeDA3OUkxbXZodEVwK1JNMEJJOXRJ?=
 =?utf-8?B?VG14NEsySHFOS3ZXcktmSEdvNVZoQnBSeWdiNjVmd1VxV3gvSnVtYXdRQmRI?=
 =?utf-8?B?Sm9aczVMZXFZTkdYZVpXd0hJYXNMZW1ua2RvcGZSOUYrd1ZDRGtOK1VYWHV1?=
 =?utf-8?B?ZnMvdllwVGRyamFmMVh5OHd1Q3I5SlNNWHpETEVVL2J3N1FUbWg0SXRXejdh?=
 =?utf-8?B?QnFmQlZFblRyYXJualU0ek1Kb1Q5VVRGYkgyTFJqSGZ0Znc1U2pJWW85dW9X?=
 =?utf-8?B?VE5ScVd2K0tzU3p3V20rMXRSUFFpMzhnUVkybVNsUzRCSllmZmJVb3Y3OW1N?=
 =?utf-8?B?cFd1VFpCSE9vT1QwT0FxakQ0TXVZSDVQUUNzMU00SnhxaGdaNUZrUHp0SGVL?=
 =?utf-8?B?TmRuSmxLcDk2Q0duZGM4R2VDNUZZLzE5MDRaL21WSU5DcGxnZnRuKzZmQUFt?=
 =?utf-8?B?cXZ0MG8wM2cxb3cyYjU3RitId0IramE4NUg0VDVKVWJ5YnJNWlZZcUlSeHFj?=
 =?utf-8?B?M1JTQldva0d4cUUxc1FETGVlVzQ2QW1xM0dudWFlQ3VJa0lhZmJPM3U1eVY3?=
 =?utf-8?B?NlNBdTlwbSt6Q2ZUTVZxa2NIb0F3YUhSVHpQRit3WGNtaVRDZU1mc2k2KzY1?=
 =?utf-8?B?V3VaS0xGMXZGemUzcU9jQVQ0aCszbWhTR3I2UGtBYjFpUW5yZWVMQ20ycmx4?=
 =?utf-8?B?aE5TY096TlpGclRQZm9MSWJRZVI1NGlSSlNtVWFuNHlIbzBCdlJ4UUk0STJE?=
 =?utf-8?B?cDBrQjFLV1ZzWHdqeHFQYTRjdHRwTTViN3c4RzZVUmxmTU5oc29TS2E1QjdS?=
 =?utf-8?B?YjNmMFJva1F3RVpZaERld3VXNHlpT2dZSVhpaDNPK1NxdXZ6b1FFRlo2VFVa?=
 =?utf-8?B?QnhnNTFuSEFjazRKcDJlQUZVaU81OWFmMnpwNitrZzFjbFZ5dks2SEd6Nlpv?=
 =?utf-8?B?UXl2c2I5S3pldjE5ZzU4NEFsN0xDanMwd1l2UHhMSjRZc0NQTGl4LzhiZ1k3?=
 =?utf-8?B?UURJVVVjdVZmQkNoeHNSSEFzdEl3cW1jdXNmZmxLRzQzb3g3ZVNDNDQ3dE5G?=
 =?utf-8?B?WlRKMVkzdzk5bkg5ejAxcVhFaUI1UnRZME9YZFFtWGpzcEE3R1dvRUZoZmor?=
 =?utf-8?B?d0xyZSt0TEpUT0kyOXM0V01DS1dOeUhYNnR6b3VjSzI4eEg2VktINWt4VWoz?=
 =?utf-8?B?cjhBN2RnRlMzb2hhV2Z4RnRYbEkyU1VaVVA3c1hsK3dzaXRoUmdkWDgxRlcw?=
 =?utf-8?B?SzlDTHlTUThWQUh2RXVKUm9hOEZ3aURHZ01sYVFlaVM0K1FMSC9mTXdjL1Fx?=
 =?utf-8?B?M3NweTVkZ3JqSHczWGZvYmRUV2QrZTgvaXpTQUw0cS8vRHo3OHlCWGFSOW1l?=
 =?utf-8?B?WFJ1Z0NrKytzdW9JWlFrU1lmVVFGeHpiN0tET1pHQ1Q0bHlHS2sveXlvc3pr?=
 =?utf-8?B?S3BNWVhUOVUyaFBmenAwQzg4N21ybmVJNnpwNEk1L0FDbFNYOUZFazFsandF?=
 =?utf-8?B?UnhHZEgvUTd2MzNGMmE0a3FQS3FvdU8wQW5renpiQjZDeERsUXpNZWhXZ2Vu?=
 =?utf-8?B?Sk1wVVQ0MWR1cmVKS2RrT0hyOUw0Mmphb3JVYWZLMlpsd2thREtsaTBNT2NL?=
 =?utf-8?B?UzZlTEZTWlNpRy9LcENuTTI5RStndXlnVUU5RGtyK2pHdGE3ZTN1T0JWUU9Z?=
 =?utf-8?B?djYrenhYeFR5NVJXU1NkdVZ0SEZrUVlTY3dKVjQ1eXl6WmlvS0g0VXoybjdB?=
 =?utf-8?Q?l9PjXzsYnfK7cdQOSvK+5vw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2544701311DD0E478C9928077DE812AA@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f817e6-5f3f-483c-79ab-08dc9cafc7ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 05:03:16.3538 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v3wRJh1LyciE6IKtL6Y0lHkVN24JQgS03yEJuRiVo9m92U+oXaFWs8sx5+cYyxb4/zFvhgfljHqJuMyqFuJTJ4UMM6134HlX4C7za08tmHtGHg5FhVGXKVP+2qJ2B6yQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6542
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClRoZSBjb25zdGFudCBtdXN0IGJlIHVuc2lnbmVkLCBvdGhlcndpc2UgdGhlIHR3
bydzIGNvbXBsZW1lbnQNCm92ZXJyaWRlcyB0aGUgb3RoZXIgZmllbGRzIHdoZW4gYSBQQVNJRCBp
cyBwcmVzZW50Lg0KDQpGaXhlczogMWIyYjEyMzc2YzhhICgiaW50ZWwtaW9tbXU6IFBBU0lEIHN1
cHBvcnQiKQ0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50
Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NClJldmlld2VkLWJ5OiBZaSBMaXUgPHlpLmwubGl1
QGludGVsLmNvbT4NCi0tLQ0KIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDIgKy0N
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAt
LWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaA0KaW5kZXggZjhjZjk5YmRkZi4uY2JjNDAzMDAzMSAxMDA2NDQNCi0tLSBh
L2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oDQpAQCAtMjY3LDcgKzI2Nyw3IEBADQogLyogRm9yIHRoZSBsb3cgNjQtYml0
IG9mIDEyOC1iaXQgKi8NCiAjZGVmaW5lIFZURF9GUkNEX0ZJKHZhbCkgICAgICAgICgodmFsKSAm
IH4weGZmZlVMTCkNCiAjZGVmaW5lIFZURF9GUkNEX1BWKHZhbCkgICAgICAgICgoKHZhbCkgJiAw
eGZmZmZVTEwpIDw8IDQwKQ0KLSNkZWZpbmUgVlREX0ZSQ0RfUFAodmFsKSAgICAgICAgKCgodmFs
KSAmIDB4MSkgPDwgMzEpDQorI2RlZmluZSBWVERfRlJDRF9QUCh2YWwpICAgICAgICAoKCh2YWwp
ICYgMHgxVUxMKSA8PCAzMSkNCiAjZGVmaW5lIFZURF9GUkNEX0lSX0lEWCh2YWwpICAgICgoKHZh
bCkgJiAweGZmZmZVTEwpIDw8IDQ4KQ0KIA0KIC8qIERNQSBSZW1hcHBpbmcgRmF1bHQgQ29uZGl0
aW9ucyAqLw0KLS0gDQoyLjQ1LjINCg==

