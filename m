Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810E9E8FDA0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Dec 2025 08:06:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZ2pd-0002LS-Sg; Fri, 26 Dec 2025 03:05:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vZ2pb-0002Ko-Tw
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 03:05:51 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vZ2pY-0005h5-LH
 for qemu-devel@nongnu.org; Fri, 26 Dec 2025 03:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766736349; x=1798272349;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ILm5d75gq7FwjuUnLmP2ll3M7IFXJL58IKhr1SP6KhE=;
 b=XB5i1d8Vmt5sEnbA9c+guLOaj20EQgY0D/4xniw9Q1+lk6PTj8HiGb/U
 MRKr3p3gEwYLZVvqi21vDCuQ/rbaGbQJlZPT0Hlf+T8q0pFuuI8v7J3T1
 y5eOx4RTnSqj3DXqUOingrokBzjIfi3u9ZPpbX/aOgTtjBni4B/q1/P5W
 U/AJCn2DoRa1On58S0aIUUIQ/qqxZABqWACZRMrp7bkSfjcYkSCafus/z
 glUMdo0mk6ZAqeOxg8izOaKZMoa7uhQV0cegDWjsCD25U3/TfQAhNtjP1
 GWvqhhekpD86qM6IpGNcm8SlUr2TPRu3NLe/cTXaELpKuKWPxBXzjrfvb Q==;
X-CSE-ConnectionGUID: V6INf88ZR1CzC1pzu7Tjfw==
X-CSE-MsgGUID: TqwMSbAFTAGKuYuXDXQRcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11652"; a="71082156"
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; d="scan'208";a="71082156"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Dec 2025 00:05:46 -0800
X-CSE-ConnectionGUID: 8LYKnyZ+TTqyWru+HnruTA==
X-CSE-MsgGUID: Py185BgrRK6eheLuuiaoOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,177,1763452800"; d="scan'208";a="200094522"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Dec 2025 00:05:47 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 26 Dec 2025 00:05:45 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Fri, 26 Dec 2025 00:05:45 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 26 Dec 2025 00:05:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KA12ShqaYMi7Llz51gZ/kRXWcpgJ1KF3euwUb8ORTml+rXiVdA5cvVgcJpODbEk4Gb+VKrb0koPJW4zaIg+2/rOOc85qu5XuASIgiFwA4im2qmnFgrsNcOL5tNdFwR9vzBAsvfEvWomspf/GJcjRj6s5fbs0uV5OOi58Fo8hvyJAoYqaoJZyD7f2K2T2zTsW8kTHwKX0rX1/eMs4npDSi5F/TDGMbS+/FfVtsYZpoWOErfF4yW933fG6YVhs9M4r0GvKuVXvo408Ropl0PVXrvv/YMsXebBTaSVPKgPCgJ+1fpxpaoc/Ca9vv1I6isj3FgYbV36IoA0mC+x5PXAfTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcZFhU9YMbEqoH32LujIOgu8eRJ0nxNjsIm+SOv8dQE=;
 b=dkjLdClqbeZAuz6mMAxRQ8Hgb64ZNDVR0j6WKDowyqvxt1+jbZxxyN/f8GA9OxuIE2scuTTjoyfyYDc6in+aFrKNE4MbEV6RHt29AmBYhmaUJAm3iVdUEPRDedmT0UGA+5UY3jrOvXHBqCEWbzGbZVDv1VPa6xttR0S4OGE/KeBKwyxs2OBfpGCtmg/BuRxK/2il2aWS6H9hhUuM78qaPBKE7y357nw+j5oy00iOkTQ3qNqX48Zt2QDABmfXtpJU7Rd3vc8ChDUxg/DuArSrbol8gPte6HqCIiFsvoYCyrdH8o03J7tv269NYc4VXZLM6s+cmZ/XGrkoVrxNUd5O7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB8381.namprd11.prod.outlook.com (2603:10b6:610:17b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Fri, 26 Dec
 2025 08:05:44 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9456.008; Fri, 26 Dec 2025
 08:05:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "mst@redhat.com" <mst@redhat.com>, 
 "jasowang@redhat.com" <jasowang@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, Rohith S R <rohith.s.r@intel.com>, "Gross,
 Mark" <mark.gross@intel.com>, "Van De Ven, Arjan"
 <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH v6 0/9] vfio: relax the vIOMMU check
Thread-Topic: [PATCH v6 0/9] vfio: relax the vIOMMU check
Thread-Index: AQHcb+dem0RbSnC2M0maML1A0NE5KrUpJ84AgAp0c8A=
Date: Fri, 26 Dec 2025 08:05:43 +0000
Message-ID: <IA3PR11MB9136E6B463CC8D03979F73CC92B0A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251218062643.624796-1-zhenzhong.duan@intel.com>
 <6b359b40-2bad-4cfe-9cf5-4d8319bd3cd5@redhat.com>
In-Reply-To: <6b359b40-2bad-4cfe-9cf5-4d8319bd3cd5@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB8381:EE_
x-ms-office365-filtering-correlation-id: 72a7f2a8-ca12-4633-6a59-08de445591a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?6YFX1dtDF6cXCBPF4t8kYiYNtXgKL/zFDeXJywmU5Yf3+UaRAfgMaN3UFk?=
 =?iso-8859-1?Q?BFvj96FOMQbnU2GETltw5SMI4fxyB2qMskObatLg1CHpr4GKnrXgewiXM5?=
 =?iso-8859-1?Q?R+6WyS7c8ySU9Ad9ATAM9he+Kp57vwMcd/f6Bb/VG8+YPVZq1V4CTCY86S?=
 =?iso-8859-1?Q?voNRgfzbn6vKC24H28kfP3eQ/uyKrdSWGqybqmo3diBkaoo7VXhDZfEMBl?=
 =?iso-8859-1?Q?Dvc5eP4eFSr3pxV+pMguW9xseEsNaSG7Zg5PedDHhA8zP0GMGr1nTd4mpO?=
 =?iso-8859-1?Q?gl3k98BtkYC4qGLVrh0vGsJlcD70NqXZjx5i48vU1Yh0amIVLGhv09xMgw?=
 =?iso-8859-1?Q?XBMGGZqb47O1fYV6gVXMoKAYf5HEDvtx31PMfnR6BStR0eei8YAnRGK+hC?=
 =?iso-8859-1?Q?RALKZN/VFGHqTBiujr5lahCt7sjWlw0fO88tlha80/wihYFH3dZVc1abBc?=
 =?iso-8859-1?Q?q8e/J2FstNkUwIjOYz7YicH3+vq/yl8VtwLd3DkpLrQqml/U9caSsd3PN2?=
 =?iso-8859-1?Q?MozFzcfMBKvWVy6r2ZLxdAIAMQVwejDd7T89bDyVAL3ifhWAsU3Ya4vgV+?=
 =?iso-8859-1?Q?FSRU39asMRfToiz+nzoxNVr8xpug9a1jpJl/6CGqBtXYUAyPGVt/Y2VxlP?=
 =?iso-8859-1?Q?xss35Yh3PRe6xUXv8Wn/79KZqzjBmau1NGN3hJDYKvqHVum7Ykm+ZAPfxC?=
 =?iso-8859-1?Q?kFfIq4msQTRi2PefsyfKIRob08ohTp6Y3wvU0qBmNThsMw03jgGg550yug?=
 =?iso-8859-1?Q?s5UjzKWLbFpQU6OVxgcQ5/pW/eHn6tiwtblE4UwYbHF38/kaV+2nIXBNPP?=
 =?iso-8859-1?Q?UYau/J940thuuudF1aaYt9qbOQ3rr6z0l2/8ukh/Pya82+PvKca4+75dzj?=
 =?iso-8859-1?Q?jKIBCfMahjW74FEyutgaaQMtltpDZ113QDphz59m1t/0RKMRm7iQxAuRy0?=
 =?iso-8859-1?Q?UgvX5lc9vVHlvd1i/zPxG6Qr57PjvfmR9kPkDE8RuwTjPzS0kB6fWv1vAE?=
 =?iso-8859-1?Q?zkqKyvz9D9d6k+IM6uIEyDtdsVV2/jhqIqsiTIAZqlOy10oKltYKZCwC4N?=
 =?iso-8859-1?Q?buriR3KvCjp7X3LTZ8OVZQQBVRNX+2dL9hhMAloGpCUrKhxkUBP0S+XWEf?=
 =?iso-8859-1?Q?8df1JMZziNUl0cPhZZGQNQiaCa/KdCrONQIBLrPZgiVlT0GYedecUCWEgK?=
 =?iso-8859-1?Q?00Vv2vON/CKkdAOU4h0h0SVe3dI7K6mBFYRD+qh5wAmA2URMxxd8lvJSrB?=
 =?iso-8859-1?Q?MU3/t5do7vvmNQZnFuynsonMyqw8s8W2Me4cfvGTj4hVRIZUr9+J5IycRo?=
 =?iso-8859-1?Q?w98p0g5dkYu5l8LquNFQBJAZtMcDlUJz2FJkwyhnsFzIY3Y1DTiNOZ5DW0?=
 =?iso-8859-1?Q?VnTUaMiGfuyaTWZXXbVgT3B6Jqy26X6LB+5a/CgIBDLUERb5eafFXQMCXE?=
 =?iso-8859-1?Q?p6oJzdbEV8Mh79K8K697oBFw1wrIxky07VUgHEysZ1mhQ5NVpfd8D35GUR?=
 =?iso-8859-1?Q?1RHsLEA9edSRBCZ8wIqE1OINU4oqUCq9yS//RIR+hjPbIWWHJ++PcMAPne?=
 =?iso-8859-1?Q?FcUn3nU7IosX+9sx1rZpyrCG7BCi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rZJ4JqWQqZHdHyT55fSDmoy7jGQhLGhrM0mLZv8Esm8ZmnnaLyRI71YS2M?=
 =?iso-8859-1?Q?BueepkVhPz/F1uxHIJdBgHl+XHB3uHZDtaUxGXNbY7CH6K/7NpVmuFTJd5?=
 =?iso-8859-1?Q?Ver4Eszf1YYH9ANnXPaaWOoGTuCy3II9oezmkeLUIxoxl+9N85t6/HJ4Rj?=
 =?iso-8859-1?Q?tZkM/f26Eq6ptOQV/uw2wUVJvGhA9tZxAiCSaQHx/4/d2+4bMVOwGfM0qH?=
 =?iso-8859-1?Q?Vx4z/qWDx5reUxoFjpbYxI1THiY7Ljsl2B+PB3yTcx2Z6HEh0RnxGlm33c?=
 =?iso-8859-1?Q?y/rFb9Qm6eX/sfv9LxEXOANt+ccxOnqpNK3KpJepLgAnaqjvd2w5w48XGS?=
 =?iso-8859-1?Q?payPceYxYbOZugJEe5sF0UaEzm4OzakUolQ5twgy+0xOf809KfEhZipdrs?=
 =?iso-8859-1?Q?ZlWbMWyjBhgdbEySLg5CK/59U3WUljl4ENOAs5jwS6AUJTv0Dq8cm4aA1p?=
 =?iso-8859-1?Q?r3mQary6a5dt1LFsqhUy5Wh6nhg7b99o364lbu+M3K8WodTXt6eyCy5lwK?=
 =?iso-8859-1?Q?Yk6LpZ/jtDu2xLPlsM/RqfdY6oAhcFHZgolWpTCjWQSi7g3DwcwBjAtZ6H?=
 =?iso-8859-1?Q?aOT3VV+W3HPq3+ByYt+nkaQR2ffecJVt+RRRUExdamgOGKEv+uX8Y2m5vE?=
 =?iso-8859-1?Q?H+DfeG2OrmdqlML+qJjGUuMRRqexqLYmmI9Kp5vkRiT/XYg88pfvHf7oxe?=
 =?iso-8859-1?Q?zVNZIoQ3t7HHAbdOOw4j62ERGhuqMgFuU8EeXQm4inZSnktupDc8lO+fNw?=
 =?iso-8859-1?Q?6wAbTWxH6MHbRxzTZMLIPMVLNDf1gzaWcFt7sDnruUYyk0kcDvRxj8cEyH?=
 =?iso-8859-1?Q?dl056A08w5N96DOdr3hR4/+SJXE1v1EgbPtYGwgwe/a/LJmgoJ2qjImx/u?=
 =?iso-8859-1?Q?2/sHhvHz5Lz5pYWwrJCwqw4EpJLIFtGqva2cKXyE9zGSoG2cs6vdHOwJqx?=
 =?iso-8859-1?Q?C8CtTRmBeuvX3gRgC3tJfx9le9dSCy1Yv45WV8SEWckEatWEvs0P9FDZW7?=
 =?iso-8859-1?Q?RRLJb374g3bWWzvo+4ooqcj9z8dulQGTNPVOYZmMuTwlzQ5MqhN0hftPlp?=
 =?iso-8859-1?Q?jU2TB7QyFP/pVMUxO0MW1vIfj6MLd/c5PxF9lFq9Xwj0EJka9B9JiXYxxD?=
 =?iso-8859-1?Q?hzlbtxAwbs8HL9++5N/KgE7aNIknF/DArTqNn7FTFcgAEP3rezujgrpv8x?=
 =?iso-8859-1?Q?3cxKc1lcp3/H2KdfEHOvJkHIndugO2ITqRYklnML77usO80CmvL/6F0qN7?=
 =?iso-8859-1?Q?a7+ILimQeKN3iVRwPGfqRMSAVk4fnW58fkg/tw2U5Rxvmz3uIFPFkttodJ?=
 =?iso-8859-1?Q?umRJnDdDgGkmVrEl1K2vgjwT63us57Ul5WTBQASbdSw4GEbw6GVfQW395/?=
 =?iso-8859-1?Q?YVBkGrFlG1t4TX15t47sQ03fChqgZPUBq1zAucdIaZb3ETSGq6ogWIJUNh?=
 =?iso-8859-1?Q?nUPwejnH1dZGkdGZObKA8iEwE5wd6hjOx2u6XcgCUyklIcZpw+yATq805d?=
 =?iso-8859-1?Q?J81SnyCFT+I03CwU4HwTQx+//hG3qrgQxb+bACJEYMnGEbJg26KlYUOwNe?=
 =?iso-8859-1?Q?/zob1l1afsCg0s4TW/YM6DQqalaVfdGmZGIsuqP8zad+5Z4yRhqneK++d1?=
 =?iso-8859-1?Q?LmKGUdSi3FFdYTR4Up4QdpmGMHcNiHUMlXqztzjO0aR+kOTKrSErTyIG4G?=
 =?iso-8859-1?Q?9pqOs783JBX93jYlkAI54EYzbr+Ano1zDRwE/UJijYTGrGNl0Uv6dTLYUD?=
 =?iso-8859-1?Q?NfbUuPHEhMSfd2Cyg4MB6kWs9jxxsvN9pJWDhe+r/kIfH7qko2JWnLY6nF?=
 =?iso-8859-1?Q?Xco7K7TOsQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a7f2a8-ca12-4633-6a59-08de445591a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2025 08:05:43.9606 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 44A6iJ8q6FeRiwZx3oSoqAb+8KR0GJQ9dTE67ZN9SrcAoyC6ED4hRoPLo34HoovcwPr02+V2wc+Ap0VvtH9H+QYQQCbbBRbnTdO99Yjc5uI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8381
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
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

Hi C=E9dric,

>-----Original Message-----
>From: C=E9dric Le Goater <clg@redhat.com>
>Subject: Re: [PATCH v6 0/9] vfio: relax the vIOMMU check
>
>Zhenzhong,
>
>On 12/18/25 07:26, Zhenzhong Duan wrote:
>> Hi
>>
>> This series relax the vIOMMU check and allows live migration with vIOMMU
>> without VFs using device dirty tracking. It's rewritten based on first 4
>> patches of [1] from Joao.
>>
>> Currently what block us is the lack of dirty bitmap query with iommufd
>> before unmap. By adding that query and handle some corner case we can
>> relax the check.
>>
>> Based on vfio-next branch:
>>
>> patch1-2: add dirty bitmap query with iommufd
>> patch3:   a ranaming cleanup
>> patch4-5: unmap_bitmap optimization
>> patch6-7: fixes to avoid losing dirty pages
>> patch8:   add a blocker if VM memory is really quite large for
>unmap_bitmap
>> patch9:   relax vIOMMU check
>>
>> Qemu code can be found at [2], it's based on vfio-next + base nesting se=
ries.
>>
>> We tested VM live migration (running QAT workload in VM) with QAT device
>> passthrough, below matrix configs with guest config 'iommu=3Dpt' and
>'iommu=3Dnopt':
>> 1.Scalable mode vIOMMU + IOMMUFD cdev mode
>> 2.Scalable mode vIOMMU + legacy VFIO mode
>> 3.legacy mode vIOMMU + IOMMUFD cdev mode
>> 4.legacy mode vIOMMU + legacy VFIO mode
>>
>> The QAT workload is a user level app that utilizes VFIO to control QAT
>device.
>
>
>FYI,
>
>There is a conflict with :
>
>   [PATCH v9 00/19] intel_iommu: Enable first stage translation for
>passthrough device
>
>which one should come first ?

The order is as below following your suggestion at [1]:

[PATCH v9 00/19] intel_iommu: Enable first stage translation for passthroug=
h device
[PATCH v6 0/9] vfio: relax the vIOMMU check
[PATCH v9 0/4] Implement ERRATA_772415 quirk for VTD

[1] https://lore.kernel.org/qemu-devel/bbc8412b-25c3-4c95-9fde-a1c9c29b54ce=
@redhat.com/

Thanks
Zhenzhong

