Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B7AC369C7
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 04:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5GYs-0001L9-Ga; Thu, 17 Apr 2025 00:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u5GYr-0001Ky-0Q
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 00:09:13 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1u5GYn-0001Gh-LD
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 00:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744862950; x=1776398950;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7dz8QR7QgpGKsF9qQrm65ai+IrEmjdPajPPD560L2m4=;
 b=QoTw4O8MvLgjhcLamFOnua0GE0jnvi9iK/V2V7nv8YD5sXxXD7RM5ZZ9
 cRBniI7P2nbpN0jdLo75sihxz9qdCt2NYztKaT5RH85DxFiTzLkQIrIPC
 DDk5AEAhznEnRi9CPbYFj/NRdgP+xeRlXWlWhPYKzz8FzAfLiTa3GvrSY
 oQhMk+7WLMUWXos3XHFxwEmA9DQJnsTleh1j2SQR+eO0JJcfo18RdWvHF
 NE1/lkL2XX5aWrhAXhNUtpTlJ3EHc+UPN/L41cx0ZXUFuF9a4G3A3wF/c
 icBxpr06sCXDXLFEcrvTmcegqZle86AfKnfRv7t7NjP+lgfvcRulADShI A==;
X-CSE-ConnectionGUID: fkI1XXfFTTWODF/8FjHI5g==
X-CSE-MsgGUID: X8KUN8j2SmKqm995EVZPGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="45568633"
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; d="scan'208";a="45568633"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2025 21:09:07 -0700
X-CSE-ConnectionGUID: XhePJS9pQZqJRzakyvtnjw==
X-CSE-MsgGUID: OuB1DzK2Tte6KADoXuf0vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,218,1739865600"; d="scan'208";a="135535656"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2025 21:09:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 21:09:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 21:09:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 21:09:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3zbTVMSVrG/43hvKq0k5vFMyq6luGsZGzO+f9pJESm5PniiJIfpw6GQOavM0HRN+gRhhEHS2Q72lWucd65WevGCovbZl9AvSy9UjuSoY14AexSl4M//QVYVxfpOXaEx+tY1ZgmCEe9dXlRDHW/ZF9vafgMUdtT7c2BAUCU89RGN0E1rGZIXg8l8472iBgsvKAdaqYIPFNLnIzTVqQ3vNt5dIMckALvQJ/jofz9d0bGdx9imWSRXgI9Hf1ufx0sOBv6XstEOLK4sdI54xAN2TS7LAFSqRPHCfxnMfqJx/Ui9tP0VVQCPTOzVL9UCGSvSI+KGJWcJXU0GJDwaeF7mJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7dz8QR7QgpGKsF9qQrm65ai+IrEmjdPajPPD560L2m4=;
 b=MpNW+Aq3SUPEU1YJFBzTkNy+70vhsjrq0ioXyD6CuvokB8Z1VrLtRgquakpdV9UXpzYmTamOljNumheYdYlcybrvMcm7NgEC/nyQdFhS8rFue1DX03uZayEUzIo2oZrT8J5YgYpzZ3APveG+rAw8O3X+VtbefDEtyo3PFqxo1TmEp6YIWwx2tSlI3NXvrzsS9ghNDbksUGiUtqpZJNexmAfkh6n3p2poFvlFZoPJ27RAMWUkKfA7AVTOyT2e9rrgSZRSrECD6pWfdZbtoyFsjGM4n6kkyUehZ6vMIuc/CIu5rnJM3UwLirrfUNLfRuOuM3+Cy6ZhNqdNNqyveztG+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB6939.namprd11.prod.outlook.com (2603:10b6:930:59::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Thu, 17 Apr
 2025 04:08:39 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%3]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 04:08:39 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
 VFIODevice.caps
Thread-Topic: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
 VFIODevice.caps
Thread-Index: AQHbqstnyFbNUaToNUifB0k78FO5YLOeVAOAgASGe0CAApXsgIAAXhaAgADYzoCAAJsHgA==
Date: Thu, 17 Apr 2025 04:08:39 +0000
Message-ID: <SJ0PR11MB6744398EAFCEFF36E5318B8392BC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250411101707.3460429-1-zhenzhong.duan@intel.com>
 <20250411101707.3460429-2-zhenzhong.duan@intel.com>
 <08b72d7a-2202-48bc-8b1b-78c93b3e7cfd@redhat.com>
 <SJ0PR11MB67442F23FF7EB269ACFE26A192B32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <Z/7z2RZyqhy43S/O@Asurada-Nvidia>
 <SJ0PR11MB6744E4528936A632F83F3E7492BD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <Z//4pYO/Xs/7U+dW@Asurada-Nvidia>
In-Reply-To: <Z//4pYO/Xs/7U+dW@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB6939:EE_
x-ms-office365-filtering-correlation-id: 43f889bc-5c44-480a-169d-08dd7d65888a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?uoHNv1Mxz7dX6E1Aen5o5OJ86WA3jYAj8dYTCedCQuj35EvmBeVRcdrt6p?=
 =?iso-8859-1?Q?V4hNeAyGzaLOESwfTJjw1BX06EXeCZbWzSY/PW3gCsG8HZXiyb+M71/DVP?=
 =?iso-8859-1?Q?hV10czDT9Csgcff0VssKxr/x3rqzc8r/YHbIaZDYfp1e/frp6By2NLiH9Z?=
 =?iso-8859-1?Q?nxhE3A32Mwc/s7m1rYKDWANC30vbBYZ8Blz1khn+5aTCiQ1nY2laE/OD4F?=
 =?iso-8859-1?Q?/CffYwjAHsd78keNRFDcpbCfrTh4zUgTHt37qpgm7J2OzwbSVfE2hLe973?=
 =?iso-8859-1?Q?Dfs+/g1aDfOHEOu/K0hP5HTr21dw0kdEnJRp3QH+I/71njRcl3cc8BfINU?=
 =?iso-8859-1?Q?2QVUm/51L3SPQY05mHmRvX3lwv0g6Czn4efS8A5b7ch/O+11ElpdPvoQLv?=
 =?iso-8859-1?Q?dr4Umh8AMICcJKZNqjGpQ7/vqzWFL6jPjWhlP+N2Klmw/JdSewZumZtyxO?=
 =?iso-8859-1?Q?ehT79juentofMWeY/R6zMt7pWdr8j3UuNXimcAapxiakU/Bi/7AWdHH47S?=
 =?iso-8859-1?Q?svzv7YYNjMLH7jS0dA21sH2n1JRpTs23QPgfPWI/8L/lzEP41rzHKfvlga?=
 =?iso-8859-1?Q?XBlAPUoUffXT7ngXlHkSXEMpIqP2QrciTNw4POOBkcpSYwtpOqTcjbRC4E?=
 =?iso-8859-1?Q?sGUs4M8sBeioMaH0rBnO/kQ7PWsv2ry8ocaJvNUKkxf9doMx5mCm74j58B?=
 =?iso-8859-1?Q?GHTV7eQzynUMgiCTmcgK5HDfjonxIu1Mqc7/hIDQ7SYzTEuNBWs5+1k3ra?=
 =?iso-8859-1?Q?MAfSaQ/XS33GLarkWFfnjnYX6FIsgoX3tSNPv/2E1aNJGhk3nRilqqxp4z?=
 =?iso-8859-1?Q?0VCSjpyFbXbazTWNAiTe/C5ITLRaVi0abXMSDtIYygPOXQaL159c/GAH8X?=
 =?iso-8859-1?Q?Gd3lcXGm0KTfL9lFjVMdNaM9frTkbOyZQU+7ykANNlrMS+qyyGZRuQHJB8?=
 =?iso-8859-1?Q?Ce9hVq2uSRgGGNBN0AlNbYeaD82OifbU7ss+2QwBLUtvHi/A1+Rhp39iD2?=
 =?iso-8859-1?Q?06CsFw+1LqPAl01N3FJoBuSRNVatg2KnE6I6OFx05ZPJjIytcW9N7ymA8c?=
 =?iso-8859-1?Q?TnQBU/Lq9lJGxfYpKuCDtlllCMepe+ZQbohzKUhEe8ZTVCcgnZWkDsG9Lf?=
 =?iso-8859-1?Q?DkT0SjLtGU5MtN2Uh91r4b/2n5rf/mxNVuGu/mlvOYtQ9YZr0rycENF1Gg?=
 =?iso-8859-1?Q?+zkLan3ULWR6WFF4pq1Znt7+oRWnQTsPiwHwmkMUAVsbZcfChPAnLtJTzc?=
 =?iso-8859-1?Q?xM/SxVtDvU1M3AfdF9UbB1r2tYAblAZ88vY8frkW92M0y1Y83uxC/12iri?=
 =?iso-8859-1?Q?VMF2WXqDBv6Zen/WY0V/bmXJfcupTgNabbzG+8lyh92/2hPt8JlF65XyrI?=
 =?iso-8859-1?Q?BvZoYmUDAtxxt8EtNTutZgqdMi4Rl9A9G7QgpZOCsDOjS/01uvF2VsrZz6?=
 =?iso-8859-1?Q?HsYCsl/p7Ro3x+SrQjRONi7exNpxDVABDsS4vvdvdUOVVU+F0ugG7q+y3c?=
 =?iso-8859-1?Q?I5LUENVqngVbLXiNZsGIR+/GtKVl/ct8jqtuSFbiXuNe5H00ZCPeYHJHl+?=
 =?iso-8859-1?Q?pV7XO/s=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FpEk2ekEJCSw5fHhJKnkXuLa5TCrhp5j6Na1WMhf304DnAxFl5evFQk+HR?=
 =?iso-8859-1?Q?hMBaU+9AwSdeS1u4XE/q7STpaHYzxcxjfYB3RFJ4zjfSmPv0G1i6MzVj+q?=
 =?iso-8859-1?Q?bT9CEVIG0z3TlD0L/IYigCqAcalbFuBanQLaFlsoT6ObrDE/h7WtysuE0N?=
 =?iso-8859-1?Q?pTpkHylyGA3ZPt0YiwdoUrJwzYbQCoC9wybOOfhbkizObHGfT873AqUDxH?=
 =?iso-8859-1?Q?CS6Z5wt8QAv7tfPl0LQSZrWYkLC390IUsf3KncYC9PumXKdD22dTXCncV1?=
 =?iso-8859-1?Q?n5hhJk1/8I/EKZpDkIY8jn333bEmHxkPcy/kYV4FwrMnQQM1Ok5/Y4asSq?=
 =?iso-8859-1?Q?lt9f8BLcq+Wd/XOy+GF4ds3fHNzZn1vmGZF8Fqray3lQk3yuYk9M2AAOLy?=
 =?iso-8859-1?Q?zQ9bzuyeID/k/6nKJCUNHJW2lY7qJayD1d9HdnFmdAkrLyYEu1Idy6Roil?=
 =?iso-8859-1?Q?1Z43mGQmOpoXk8MFRrwbW9Iyl3yZ8cmF4TJRK/8sPxdpfiAlmsmK15rr73?=
 =?iso-8859-1?Q?lttpyipSZuCKcVos0bMVmfBLSjygqUGwVim4qb1PwEgDDueUhB81PDJH8v?=
 =?iso-8859-1?Q?+PAZ6ckn5f9KLqSAeD5t7/ySRR62tGLbtXBWel4lHYm2w9X7nhCSwf+F5F?=
 =?iso-8859-1?Q?O7LkizvcmAcn0CZLOX+R173woQdHoZPwcn8nwDBludjjnhOULZfuQgrgss?=
 =?iso-8859-1?Q?wFhdaAE99ZhUUG8mm6ikglkEjzGWklUZgmLByldyRI8OcAoe/T8fuHjSsd?=
 =?iso-8859-1?Q?DTPAGVU7yyyMOqhEY5CXCtg1luD1Yri6ugaZr5oLkANQkWkh1/mOwxGu8F?=
 =?iso-8859-1?Q?L19tFmv9zlxSHUArh2hlL5eTpdHMQliXfru2Qs6Cxz826CaVKWp3cBBmz4?=
 =?iso-8859-1?Q?blt7/5EpRu+z3j7nCjqmuhIm4SZ9zCV69hVz0OdnwEmqUu1kpc3rgmU/k/?=
 =?iso-8859-1?Q?M43nNMqJc2tsNcTbTjku2L/ER09+kDTqzvPfztUf9GOYSFb6fklAp5/f24?=
 =?iso-8859-1?Q?bVkQk00uJw98E52LPlAUSmaJi9fz4D2f67gX1tA+dLWlns4lPjGex+GOQU?=
 =?iso-8859-1?Q?Vcwhe4XYlGBuT4LoLwd4XVdcGjKApfbAAGfSamu9Muj7ieXNwE4wRTn3g3?=
 =?iso-8859-1?Q?6PW9HNZ4o1bdG/EQRLMq9DIbs3W6cgw8y83bmJlwxFu6Yol352Q1e/OGg0?=
 =?iso-8859-1?Q?LofOJKdzLlfrCQhOyMEnYmZcVNQODoOEpFhfPHC+CKl230NFE7BaXLOBYS?=
 =?iso-8859-1?Q?+DRFcJwi6xG1UAJXxaR3sCs9Hs5RL5V0FSXBlQexOzChy533lCDKa3t15U?=
 =?iso-8859-1?Q?4kWYvYrrdzx87YX5bcoACv8txIXe8Njazf6J7r78DWi17oP1WJXNKrW3UB?=
 =?iso-8859-1?Q?I/KVuGtxSLMWFCFcc9QhQ/0RY+VqyIG0Uy60gXgyQOt14VVR09Z8kQVhcd?=
 =?iso-8859-1?Q?xUjYjclhPJlcjhs8tJiXeicTLEke80ZTUCTFSRRjCOVOJOLwv3GxAvSxaV?=
 =?iso-8859-1?Q?ZXz0Tfp+NjR2DMTpfJBOSpA+SUxxlviFMePw5RMDSqB5SdhMrsix3qicLY?=
 =?iso-8859-1?Q?uQ0HPWcZ6oz9gWLbuR6n7Aa3OmvcF56Ck38AkXSXHpwL5uegtBbukUfv1N?=
 =?iso-8859-1?Q?Dyl8CAKCMvIia2IXwN77+Fl3znPCXqzHEH?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f889bc-5c44-480a-169d-08dd7d65888a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 04:08:39.2293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EGccPO5bYx8II2Ixv6J+Ir600EfXJ6SBFwMpGCb3Ktkh1b8sL92jCg4ZVxcNLg8F2dUU4B0Z1AZjAXZ2tQXpLnUNrH1xR+QaENw7WlPnS28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6939
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
>Subject: Re: [PATCH 1/5] vfio/iommufd: Save host iommu capabilities in
>VFIODevice.caps
>
>On Wed, Apr 16, 2025 at 05:49:09AM +0000, Duan, Zhenzhong wrote:
>> >-----Original Message-----
>> >From: Nicolin Chen <nicolinc@nvidia.com>
>
>> > And I was expecting the
>> >vIOMMU could provide some callback for the core to use so it'll
>> >return a valid caps pointer.
>>
>> Any reason for that?
>> iommufd_backend_get_device_info() need iommufd fd and devid which are
>> all provided by VFIO, why not let VFIO call it directly and let vIOMMU q=
uery
>> cap through .get_cap().
>
>I thought we had an agreement on letting the core code stay away
>from vendor types and handlers, which seems to be a common sense?
>At least the kernel side never handles "VTD" and "SMMU" types, so
>shouldn't we do the same in QEMU?

As Cedric suggested in [1] "The IOMMU backend implementation could be anyth=
ing, legacy, iommufd, iommufd v2, some other framework and the vIOMMU shoul=
dn't be aware of its implementation.", so now we have core code handle the =
vendor data and provide a general capability query through .get_cap() callb=
ack.

>
>IMHO, it's okay to do the ioctl in the core code since it has all
>the inputs as you said. Yet, the core code should only decode the
>IOMMU_HW_CAP_PCI_PASID_ caps out of the out_capabilities, as they
>were filled by the core code in the kernel. For the type/data, it
>can store them in a cap structure, and forward to the vendor code
>via a callback function to decode them there for some common bits
>(e.g. nesting).

This is exactly what I had ever done in an old version, VFIO provides hiodc=
->get_host_iommu_info() callback for vIOMMU to get host IOMMU info.
See https://lists.gnu.org/archive/html/qemu-devel/2024-04/msg00770.html
and https://lists.gnu.org/archive/html/qemu-devel/2024-04/msg00784.html

Cedric suggested a more general interface between VFIO and vIOMMU:

"we could introduce in the vIOMMU <-> HostIOMMUDevice
interface capabilities, or features, to check more precisely the level
of compatibility between the vIOMMU and the host IOMMU device. This is
similar to what is done between QEMU and KVM"

See [1] for discussion details.

[1] https://lists.gnu.org/archive/html/qemu-devel/2024-04/msg02658.html

Thanks
Zhenzhong

>
>The other way around is to do the ioctl in the vendor code via a
>callback function that returns the cap structure. I think this is
>slightly better, since the vendor code knows the exact data size
>and it can validate the returned "type" immediately.
>
>Thanks
>Nicolin

