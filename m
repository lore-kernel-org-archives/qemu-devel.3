Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CCBCA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 04:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF2Dt-0008CO-OT; Fri, 09 Oct 2026 00:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xF2CM-0007sB-ET
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 00:27:19 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xF2CK-0000Ax-M1
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 00:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791520029; x=1823056029;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GBYpVo4CxR0bXNqNrUwJJaZkk91vbqNhSJSeDkWZp/E=;
 b=CYIt2+MOJEgiUdItoInp//izE9+YWZM4OnQ9utargY5qV27TLigWlONE
 AVKk5XTbho035Zb2/RicXd8pnB3Scq32mJKx2DPfIQYdzV7IsfeUPvyw2
 /vxGgKOPnQsrtte84A//NpnRUfrPnuyAyOU5P7LPwBGFqnPxB3jSUSR7g
 1sKwPABmkdMAe5XNKG+yk/7Z4uGn7GLlz2wPnqVK9k02LsWijn0Sx7S1F
 xWgsGAW+CDf0B6Bz/PaYS+ETUVbCr9uykqJhlsQm/b+o4aWj/fsXJnYtD
 YPKDmDQY8SspUSHzxV+eQr2kmFS0xTEMWKebTRxNTVNmzrcXFDxQV0RxL A==;
X-CSE-ConnectionGUID: hBdfEzMiROSBcyDfpQBakA==
X-CSE-MsgGUID: JiAMLYrYQY+ddUNEmdXTaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="188189"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="188189"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 21:27:07 -0700
X-CSE-ConnectionGUID: UVbYHim3RbWXg1QdYLDPZA==
X-CSE-MsgGUID: rNtr+DDBRfKw/7ZCCAbb6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="212474"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 21:27:06 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 21:27:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 21:27:05 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.64) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 21:27:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=US/hCkCBagQ0JMd/atD62qCTxILziNMSuLubou1aDSc9HUEuDK8VVGu95kTut819c6SryW31JUEMUMLCMu7KYaNpdIl5Daox5zuAp1LIbjjhVZvCOMIFFo1kPZNez1nMD2dz6OxCflaizBxeZ+HIG0jQJXQ6KVisfxrJyem0jt5/QJ+D0LxvdqeJ3vok65ECC11uUoGiXtMGBp5aiU832XYkkqwmDMGhr98acYbYkzHjpM+7yCl1nqHTYr52rsmEnJflkSwUdN6JxqwVcUSZ0bAlYSEfCn8ITTzmjZqIPab+qtzq/hIlgP45oggAGgjW7aHDAdXyuSaZpwAorXwxSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQVRg3pr5/FmmeTG5Ab8F2wlJFVmTTAgt4j+EqW2hKw=;
 b=f4McVCsbs/gW/3UD5oktIDnr6X1j/LofNW3Xk3L7LHSV/8h+nMbR6n/cIw8g7EqB9RqHtRLHuUv4DC+7ywAjVqZk0Pcd9VsBIhvG9ZksIIhgYhZTPmnhzxihaVzhn110juj9jX7PIFHenNKzeHTVT8eC03NLuoeXjzpQjrepNFdJAJF9ipfU5yqNjOexz7nENhXIvmtLI+udoHMOHcYcXloVQP4bvOpLn5qbqW7Cj85HIOOeOHWxdRcPQXGjxves+07qgGKYF4AAsoA5Fq+HlgARe1o5dk9+bjTH5rWAf+HBW55aFefZvqKJC5z7bkgkG69J4wQsD9JjwZyDN86RZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH3PPF10E309DEE.namprd11.prod.outlook.com (2603:10b6:518:1::d08)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 04:26:57 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%4]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 04:26:57 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v13 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v13 9/9] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHdVphjmjD/24Tm10GKCqp8WfcGzLbzXLIAgACjmZA=
Date: Fri, 9 Oct 2026 04:26:57 +0000
Message-ID: <IA0PR11MB71857E6DC18C3B4B74CE235EF8922@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-10-vivek.kasireddy@intel.com>
 <b87b6288-4226-442e-8802-d9bf31f5a7dd@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <b87b6288-4226-442e-8802-d9bf31f5a7dd@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH3PPF10E309DEE:EE_
x-ms-office365-filtering-correlation-id: ee0ed074-4356-42a3-c526-08df25bd8e00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|22082099003|10067099003|18002099003|4143699003|11063799006|38070700021|5023799004|56012099006;
x-microsoft-antispam-message-info: NsdUQ1SDvAO9wzi3sR40wc7iXX9lw29lw4RVTr4ZCC7DKfyKf/PMlscAr2NfZATJtyECbG+sGyQOBiaPdgwkRVBVl3hn0urJxNNYkPbfjSKd0LCBN3sOA4LqopMKeLIzdJq83LmXFkjBShjXhN5WytL4+P7jOAeTwL35jnSQYIzAeaxJLT6R6SI8dRFTqGfwyj0pVcATBdAzGw3bA78RQuKdAlWruNwz3M2H3WWMEX77zvU7TOotPCAN4BJNyaE/WpjrfV7/q4EfaqgDK+/8nltiQ7INVtKdHE9xvsCz4NZnbrBvqCofTAjPEaxJ16bd3K57sqGRh/Ni59elw15CE7Wxog1bD7pl6bEsKkNqd+WccE7Xl9G4MTKOCOkhncXP+w1SyoVHFZQQKOFakL+aDFzE7VlBnthIZqdIbjXzNCPsTQZgIPzQefDTTlq51GlgrACWY+5KsZPndt+JqAmH0v0gKTZ1BTieLMa+fk6drwSYixTN6zUj3KUg1hUEV3PBThtvaLMCeNJEzL6K8acJ1BjA/bHS40ILTGn2osR9skU24NXFJJnTxqqT+mNofYTgffSvUALuxPzK6nzsMaqWe2UtXGrB2yue/A7rF0TH5j6XO4Nuv0p/8zbTUDH1TiqfI6py3LQ4ufNmkeNXbniM5HuPKMjleTNUfHaZJoOcLAyC5sb/yioiwLDIXldiRSXJjLksrnXNuIHxi999Jbj/I/HK0tuzHJ5xHb2r8TlFQ4w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(10067099003)(18002099003)(4143699003)(11063799006)(38070700021)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xM0t9bDnpmwD6NWmS6gaRkK5GIwa5bZFYra+snNLIse66vNZEMJJAcXYz2?=
 =?iso-8859-1?Q?QIWY0tDcemRQv5cnUAtGX6i7LITqbhECw2i1AYvwIM7K2bQLPh7M7b0zZo?=
 =?iso-8859-1?Q?jGNDv8WLk/BB4sFEaAC3gbYm9NkF0jcEI2YDwFfbW/w5w3rNCPzgAMho+k?=
 =?iso-8859-1?Q?dyI9qO7NsId0A3ggbDSTF+NAGyFaKp2H7lrLObcFjIiNFIykXOqd7f6v6B?=
 =?iso-8859-1?Q?q4TKm7YmW7CdYRU/LoEddDAIszaS/GtES/x1oCw2qbi8ot7WzhX+fJaJyE?=
 =?iso-8859-1?Q?U62GbLC2jW+LecO9FRdPSbg/RtYfSRnQD4oefyKzVloqSbFvxdXrfWvOui?=
 =?iso-8859-1?Q?yIsRlWoqov5HKuEj+WifvKnVtZtN7JDaYVzPXuaZUBT4pUah87OGQh2EBz?=
 =?iso-8859-1?Q?7DpYVPrcN5akh6YyYy+4cvtE/U5xwMY9wYtxAUhD2/mIFZLY3NVEH0Vz8h?=
 =?iso-8859-1?Q?JmbiyM0inZ53NSJmQ4ew/MGiV+UIMJz20d8Q+fd29Kun3RDKByTB4Q4IAo?=
 =?iso-8859-1?Q?23OTLlMCyNNs6x5VzbIR9sfv+l5Fa0Gw8YpLkOSINEd5uQD2oU6EAlxdcV?=
 =?iso-8859-1?Q?fbRndsXo9JIF+Z9MLtbbKSSO678AE0V6TJoss20sNaWGPPEC3m4evj5EvI?=
 =?iso-8859-1?Q?eOhxPZ8fD7IWV0dUX51hI3Cjow6IMxkTfbJF23HFghdSYTdHJA3As5cSV3?=
 =?iso-8859-1?Q?wRvUqQ+XDRfw3gVn3kBPABtrSDOdvXteMQFNNzz91nZjH3thnpyw9hfIEv?=
 =?iso-8859-1?Q?vW/9aJmxNG8ghffzNvhqSycW9JhFI4ISrjzEaDmXbQAA6HjadNNIECPbwu?=
 =?iso-8859-1?Q?x73EqTL+JYhgU/VHFyhxanMwFo912lrTPhUpeNUOEmDJaJA+MDpjrdLgag?=
 =?iso-8859-1?Q?9kLWCjG5AF5e1iNKcpWmIF2ySf5GkuD5YTMl15vDBq/mynxC5UYtGycNV+?=
 =?iso-8859-1?Q?sO/tJbkFc7dZKpyM3aWfW94a+m3LXuirODgS4towMd9nQ7oUv19jRBTeHC?=
 =?iso-8859-1?Q?rJaUBkCIcdzNyMakWqSabC1gwrefYmszrTX3nfsWC7K1izw1GxFpqX8X/i?=
 =?iso-8859-1?Q?yw8woKmLmK49MLFnp7Jk4iYuzJKK9HAqRPl1GvJ1WJFoggnfTnOMaYox/7?=
 =?iso-8859-1?Q?xOq80qZIRbYKtgP819EwSJbn0Bc/2qU/bN07NFcR/2h3xPlink3oQDEr5N?=
 =?iso-8859-1?Q?z4rm8ZLt6aAoNVUM/aN6Ii14YkyHh1E3QBmdcXMoYuSowLMmjWGST0F23D?=
 =?iso-8859-1?Q?4JKaOx26DbPExJU2xJxUQE17Ji/g3HTo3yvUkryxE6uIC0th8TkD92oPi3?=
 =?iso-8859-1?Q?rSntDVAl4+P6jFBL1gq7hrBgN0QP7X3oEzA22GcTNVsl9WApAa0YGiMT6D?=
 =?iso-8859-1?Q?pXkycc9Zxwj5r888oagao6pEBFZxIRt0+y7eh9aXkBalSdgWmt0vb43pZx?=
 =?iso-8859-1?Q?mMOzAk+6+zp+8YvGE7cjrcXNKdxEEa+7JFTs47EMbGVgdWWoibIhBDt+81?=
 =?iso-8859-1?Q?FDrLSMR1Fotsow+hM9WKQZ7JqonyMLXwLwhzLRXy/WM/rCD370wTi9cvU8?=
 =?iso-8859-1?Q?h7ZUZ4Y5xesyu0czU1JJNnT7GVhr+tFu931Jathu5L6wmlaAfowCq+w/jV?=
 =?iso-8859-1?Q?l1ucL0q7vWCoCLEs5qOw+Y1tNcWexAQ8pXtA9CSxTfBacJbgpnQ8TSNQbS?=
 =?iso-8859-1?Q?z+gZgGWW5QXK/rdE8mZHfA8cotw4iJX1x8Zo0PPPo5/aiWtqiG7FZT9xlF?=
 =?iso-8859-1?Q?LTUI7cRvbN+nP0k2JWd5jp340wf4c4vqiJB3yls4paz1iz+7+5DC4+81ot?=
 =?iso-8859-1?Q?/eCWgloJPg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: OBnuAdlObIwn3u6WKj3awsKmawtHmauKJl+nEEAErVdTKe3Mus9XbBg4PIw3+JKDHQ1GhvhYElo+auBSqfu6XP+beyFnDDEAu25qdVU2nILiq2EwnjNqcOnkW7zkZtWFfZxyyUYY6IkbRu8NgJzx9Eb2xMxPXBuMqbdD5jyw64foch4y9PFbWEkv3T/xhzYjYiZtq1riEkt5uQHNkKzMBy3TpaVv6mntoQ9/RiT8eIpv6ubcSIFzoadPb2AluScDhSdjDNeZBNEQcZCDx3ihvj2sNv+WLl8DhVD3x85oWwVWou2LM8ksr/Dfto3oEn0iZ4B2+clZOy9SCPPvgJY8Gw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee0ed074-4356-42a3-c526-08df25bd8e00
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2026 04:26:57.0984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UFxgVOVtV9ZuEcPJ2nZauTZYDabvG26bleyvEt1FMv1qO/QyZIMyfD+CRol76Z+sILvjQ2Fy5hfoX229AyDHHqRlwFhxm4r9NoJVfbCLTqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF10E309DEE
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

> Subject: Re: [PATCH v13 9/9] virtio-gpu-dmabuf: Create dmabuf for
> blobs associated with VFIO devices
>=20
> On 2026/10/08 5:09, Vivek Kasireddy wrote:
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
> > dmabuf fd was created via virtio_gpu_create_udmabuf() since we
> know
> > that the udmabuf driver supports mmap(). However, if the dmabuf
> was
> > created via vfio_device_create_dmabuf_fd(), we use the
> > vfio_device_mmap_dmabuf() API to get a mapping for the dmabuf.
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu-dmabuf.c | 22 +++++++++++++++++++---
> >   1 file changed, 19 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> dmabuf.c
> > index c9de8e9ba3..f59a5e76ff 100644
> > --- a/hw/display/virtio-gpu-dmabuf.c
> > +++ b/hw/display/virtio-gpu-dmabuf.c
> > @@ -153,9 +153,25 @@ bool virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >           if (res->dmabuf_fd =3D=3D
> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> >               error_free_or_abort(&local_err);
> >
> > -            qemu_log_mask(LOG_GUEST_ERROR,
> > -                          "Cannot create dmabuf: incompatible memory\n=
");
> > -            return false;
> > +            res->dmabuf_fd =3D vfio_device_create_dmabuf_fd(res->iov,
> > +                                                          res->iov_cnt=
,
> > +                                                          &local_err);
> > +            if (res->dmabuf_fd =3D=3D
> VFIO_DMABUF_CREATE_ERR_INVALID_IOV) {
> > +                error_free_or_abort(&local_err);
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              "Cannot create dmabuf: incompatible memo=
ry\n");
> > +                return false;
> > +            }
> > +
> > +            if (res->dmabuf_fd >=3D 0) {
> > +                pdata =3D vfio_device_mmap_dmabuf(res->iov, res->iov_c=
nt,
> > +                                                &local_err);
>=20
> This maps the complete IOV size, while virtio_gpu_fini_dmabuf()
> unmaps
> only blob_size. Create and attach accept backing larger than the blob,
> so excess pages remain mapped after detach, unref or reset.
Good catch. I'll add a check in virtio_gpu_fini_dmabuf() to determine if
IOV size > blob_size, then do munmap(res->remapped, IOV size);
I think this should be safe even if the mapping (created with mmap)
size is blob_size. Or, is there a better solution you can think of such as
tracking the exact mapping size in res object?

Thanks,
Vivek
>=20
> Regards,
> Akihiko Odaki
>=20
> > +                if (!pdata) {
> > +                    virtio_gpu_fini_dmabuf(res);
> > +                }
> > +            } else {
> > +                res->dmabuf_fd =3D -1;
> > +            }
> >           } else if (res->dmabuf_fd >=3D 0) {
> >               pdata =3D virtio_gpu_remap_dmabuf(res, &local_err);
> >               if (!pdata) {


