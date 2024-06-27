Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB13C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 03:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMfTB-0000Hz-MS; Wed, 26 Jun 2024 23:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sMfT9-0000Hm-0E; Wed, 26 Jun 2024 23:06:43 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sMfT7-0007r9-1N; Wed, 26 Jun 2024 23:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719457601; x=1750993601;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=ylY/0J6G0ADeNXXVFf47MKo+c+YE26z6QwZ1tiwombY=;
 b=dCyjuJ6vohH9LldFnTfv+Uq0Sntpn2gSXKq+Jer7R6iWWbpjVQIQIfmP
 bvhaE0xTsDXHcsVt966qgQo4QUKlCjUorKe3J6Oo3G64mrqlbaXaRthI4
 TKOl7Xx4oMPyW3DgZ/NOytpJ5NenlBEMKKZtPaTUAag9FY5e0D5qkBcem
 zGz+ttcmHmUWQJ9Bc8ewYCypGSi9gDjZt6Aos/wFv8xrwQoTOXR99Q2xV
 3TL9od1zgvM1tnO+qqxPDnlw3tUMYxxVCJE1iKKBtteoPZ2TKgdtrdqLG
 R/9HkDS3u8hAyWaLSqBt/o8mjbuBsRvaDcJBXOlht14r5dMVsNMXhnApn g==;
X-CSE-ConnectionGUID: w+1t+WMQRuO6N+tGQiHitQ==
X-CSE-MsgGUID: Im938rsFS62aFwDHk2U2AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16307043"
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; d="scan'208";a="16307043"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2024 20:06:24 -0700
X-CSE-ConnectionGUID: Fv5GjN1PRH6oeKmDQhkm4A==
X-CSE-MsgGUID: nBwxlxcORnaoltpUPjHZBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,268,1712646000"; d="scan'208";a="44287519"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Jun 2024 20:06:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 20:06:23 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 20:06:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 20:06:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 20:06:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmfktKbi4SLsHT4LU0CBw1iOvEms3/WZYGqwtR5FAnd4Tm0sna/bymkY5BdYoIAfs9CMzcfxruwUey9Lk6K2O0wcPttYavBA0zieu/FEJdBgXmlHByp5wWWIo9mK6T0Tqytq7RpU80A+F7g7dkGdRR3dGpOjcfuz1ptqJ81bHh9E1E7eUckZ0dsTt6+9kXcp1wvgJpQ1RRZ+gsZYk15VjzN8TZryKfACHrQWTaeh8PUKkNUvZgkXrrAMsjFnIw3J67f02s/M3+hnziHkorxaP7nyTrQft0SsNrmS7V9aLtgqmvoW+2uqXyRRXwOAlSZXg+UOP8//0welGsqHjFpm0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONrzFLbzd6dEM4RZla3930TF7LHFcFbWtr12g+hri1s=;
 b=Qodvh5IeS13n6H768J6E7pRIURXPFJ+5HLuTngYeJLZbXfN7fT+9LbhOd7AIOck+oY7FM1EwVlic3yy6Em2sWEO5iOEESK2H875YC1hYnyWsdGJ6JVQE9tvUA3tLOMeX4/g20BfJIEtJyNaHkQTyy4IpGgYFXSxPZP4pKoDEsxrZfeW4fuU+t9AgCOo6TYKcpjJQwgxQVsyYUFXZXrF6B+wnAVMF7+rj20t0whtieo9lA2ey8GWI1d3LOjRZElb+V03MOkgnnhD+HD/ttPeAGxw3wRxKgIPt9wD+cNTKyhC9vn1TC55rMoKomC6x4VZwxr8ohQYvyUWIeUNQPQvJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB4853.namprd11.prod.outlook.com (2603:10b6:510:40::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 03:06:20 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7698.025; Thu, 27 Jun 2024
 03:06:20 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "yanghliu@redhat.com" <yanghliu@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Subject: RE: [PATCH 4/7] HostIOMMUDevice: Introduce get_page_size_mask()
 callback
Thread-Topic: [PATCH 4/7] HostIOMMUDevice: Introduce get_page_size_mask()
 callback
Thread-Index: AQHax6LGeEgfB5oLvkixcGLvIMJYjrHa7h7Q
Date: Thu, 27 Jun 2024 03:06:20 +0000
Message-ID: <SJ0PR11MB6744E5DF82073F17F2FC31D192D72@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240626082727.1278530-1-eric.auger@redhat.com>
 <20240626082727.1278530-5-eric.auger@redhat.com>
In-Reply-To: <20240626082727.1278530-5-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB4853:EE_
x-ms-office365-filtering-correlation-id: 554857f0-86b9-4335-eaee-08dc96561ebe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?XDvlcSHyr4KzWjH0U69fl9fTHCcS4sfdN/Nm0+ohBqwcg6zcLq5ezZ+3G/H/?=
 =?us-ascii?Q?N5EPcJDvyQM7phXF0V34RPto7ZsHPjsXMo+Wkaas2Es+f/Px3zCMRpIUbvUl?=
 =?us-ascii?Q?Qhj/YD8eW+LDBmJm0OakWO9QsTS2sqNLCEu0Pr3BJqLfc3k/q4DReIlgpVUh?=
 =?us-ascii?Q?/8qmLu4LEPiDXkWUyCZkM0BDzku1jSuoRDgC1HUrS+AS4KYn3Gh3w33YLq0y?=
 =?us-ascii?Q?uoxVoPJcRxfCDOI//mgKMeKicSmDL+/qVscbpTUxtdKV5Oe7Wo57T99B2VJg?=
 =?us-ascii?Q?1KIBoY2yfVoSXh/EvhbK65Iug2LT9WnNfzBQfIv5+ooz8RmSYRBIwaBWGjSM?=
 =?us-ascii?Q?2AILopWw/vkw5sUKhG+595IBBZIhhsJw8ApDli3k8A5TRR7UPJ99ysi985Hn?=
 =?us-ascii?Q?Zkb7Y+kLwSVEBW5yNQnxfog7sDL5eWZFXwYNVzPVl8c5bGeVRG+K+El9aUHr?=
 =?us-ascii?Q?b7f9orvf5vsExTGzAykW9+wnyZqaIw6sEnuVBWeBSCPjokjXDHeBo/G05gXd?=
 =?us-ascii?Q?PVKi869/ChhfJZnxmONe8/6g0ivtc0yDMXJ5kx8Qh2F8Eeft7OssXvy0GRSL?=
 =?us-ascii?Q?CBlQeeYR4i+DwHH5BuB++K4ord8qrorOCuPqTz3DucPKaszdOGx9zyUrJZP4?=
 =?us-ascii?Q?mCGFwK0Ws2quPQ/h8WodyYzqx16KZ1DFvje4RBHD9MCQb+nJ8rXd7USgLcnQ?=
 =?us-ascii?Q?Az/YmgDgWMcDisINMHHR5Ers3hL6VnUmH6yMr+CAhTWwiKpNBNDg4q30rEUO?=
 =?us-ascii?Q?6HoFxJpNeP1ZixDN+mxCSiXl7GYf05UYuLx2HjcQHPcqLqvOLs7LlvusndA5?=
 =?us-ascii?Q?5b+KNxA+rvk7eIgUVW3QYdUm+3ghxJvF/qiTjsspoLLv5gRgyrjdZ7n32D4l?=
 =?us-ascii?Q?gcSTQfWLImM5MejMEuiZqr9HCqjnRvQ1hfBJHTXnpK0m1TzqDVOf4+Qg5Dez?=
 =?us-ascii?Q?GLhrJNC9g77bpZMzEqg58dZqoyQAjZ4hZDB8sgoxfwDbQbDjpKNHhDLYIB5I?=
 =?us-ascii?Q?fBEqVMbabSLLbW0MWHRNls0O1BfFB2qGVwA1TJ+W7yNkdCHgUKx3UihDvWof?=
 =?us-ascii?Q?gCyLbSUTEZniuFHYgYmiwmj6VZaV34bzeJayqsQUvsFIluNqBCga8jzucHUB?=
 =?us-ascii?Q?H1wbZkHX5HhmbUJoCfg8Hs8QXsSmRk/H9ziJhPjJGl9WI4hS7s4GchRvtMLo?=
 =?us-ascii?Q?lYYpddUw7ZgKKfPZtTRu8oL5uXw3Uh+c+vgxoxIE+51LbfwC3v5CmpXe6TsC?=
 =?us-ascii?Q?Xi1m/lTxCq1j2wVfJizTVPrdq0TyXJzdyl0U1B/lUJXH1DP7yN9fPbmIgMKf?=
 =?us-ascii?Q?90j4Ab/QaNDFpe7pilaCnWeoCbuy8QZJ1QOt41HJ24GKXLHVDJL417yUruAu?=
 =?us-ascii?Q?rTyAdsrSIUIILNiZzpLs+ExXp8EvWd+b0BizQ3Iu6voW2zsRIhbGu8Q+saU5?=
 =?us-ascii?Q?zsuvqNNGW0k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8QijJyqe4k9b3ABYWY7N/31fUWD7zjRZ024QUE6WqaCB9xYjLCKrG46MtLJE?=
 =?us-ascii?Q?br3XZJzFkm+lVXn2k5UuEoDhLEbapl1A2Rvb1DU7WuP6oeCrgfaSPD1cMyje?=
 =?us-ascii?Q?OI7fBroTeu8GNOp5nksRlU4B8+y+qnPswnIeEuWJ1NjZPSEowRmMx2IfGdsr?=
 =?us-ascii?Q?27tjNjsXX9vd+76AyuIbxMXCPpggzQ2hsh3QXZicjwQ5FFBpGs/yT7BS9lAg?=
 =?us-ascii?Q?amPt4Wa3NZKy1Ka+scugAWWBZebgqOYnvKBybBmcp8YF3Uf+zb7NYGOxJOfJ?=
 =?us-ascii?Q?3e6zwVA1xBfksCp0WFrYs+fkN26v6GexlntAQY56fbtpqSYbL8rnNvIP5gWt?=
 =?us-ascii?Q?elHu90gj3p1rR3hdA0cnE5OWnQmqOVh2TvRRyNgSE1WxhdtG3LWVjztq8Ye1?=
 =?us-ascii?Q?OhSPuc6txPdBYK1F3+JLcJCnoTky56dIyw2kmffhmuXICZ/W7K7Byq8DtymI?=
 =?us-ascii?Q?JlGe4VdoyLKaFGsCK6xYmrN8pQvQp9P/vsAWNA9AHqhgw+ijePp2+RSukSuS?=
 =?us-ascii?Q?h7eq297kVoHLlyeBmtWaXifvWSGg1/QEaiDbDo7nudHomUQft13p7TBU9PB+?=
 =?us-ascii?Q?MCMYAfjoFj5gAygXFOWqNtYh0LFduVtgWVA57plsNsUSN76XllBfl/fHSlxO?=
 =?us-ascii?Q?lEzS00v8fIgfDaOyGu6tXdFbVeMC5Z7VwMQrwd5h1YvnIKPQKd6ozzCQmGgs?=
 =?us-ascii?Q?dtWiyBGiygYse4fmW87KMDdD34+86wc9HqXoehxekjZ31bNDv6hpFaUlsXzT?=
 =?us-ascii?Q?P3YJGLcFAgB2t3KCnz2bREKnsqLCNJwZ4xoZgxWMs6Y9QdLVorvBmmemSNO9?=
 =?us-ascii?Q?IYV7QfulBlDDiJ0NmHQeHRCJzhKpWK7NNCjn2LVIHKSjG9IYB1ihRS+Dfdnz?=
 =?us-ascii?Q?h7IifSTkSjFHtBpDcLQGoWX8lcY2FGxd681Qr3e5PgFXs6ZYsPy1Kw6rgsZr?=
 =?us-ascii?Q?S2RngK8TkYjC2WaAu1s53mj51//uKACxGQTJdBSDkgW+yR/qXIlJsUM771rQ?=
 =?us-ascii?Q?SYaK0xvdqB7BgWVAldnOggwwaCEP4khjrUqaTiFxxwQJJ4x+YhaibyUSmiCd?=
 =?us-ascii?Q?ueYomqFKclnv3icWbQ2YuYFb00Xj5rx+aNT9jKoSWbdBMg1WIsKA0OnMWzD0?=
 =?us-ascii?Q?5w0WfTpkKx3ft9IgWwYiNkg0bdUAJOJm8JQn/SV5MPFmoTy0RR4RuW4vt1wA?=
 =?us-ascii?Q?4jDSweEJCNtMrfsBy6B9UNpwOH06jY6vjRY+dsYYtsL8LRhXgCUrGSIAOGkz?=
 =?us-ascii?Q?soCAh+GWHFHXwF7gWJg2AWUl9es5ZfKI3R9Cse0f0OWc0DpbuE0q/7B5ATBw?=
 =?us-ascii?Q?la8zRTauDwWGPCnPTNFbSorUJz22TWSTvkG1b3EZ9Qf4wVS3MdXHyrdb1znA?=
 =?us-ascii?Q?zHh3QaEmAIGkioD4oLh0zvt20GXZ3b//U8bXYWS1FgMrug/G6QoJ36NTwF4C?=
 =?us-ascii?Q?UDJ6nPKp0VS+re57L6OameJ1g5/D/mCB3RrcNErajs/PMrsRCWCXOmHOC/55?=
 =?us-ascii?Q?ptxlS9/nYYEBnkpr3E0+qQsjeG8FFwSonYmaCMyB2Z593PS2BBs1i1vLVMP1?=
 =?us-ascii?Q?BfOr09vD75ZFG8Qsp53ojRjkikgv59eyaq3+PvTr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554857f0-86b9-4335-eaee-08dc96561ebe
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2024 03:06:20.6879 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9n0M3IkRmgJCbHrUHxe+JugB20olwi6CehN3HAc00Ifu4uuELcoUM7A6gLaXX2BvL7KaZNQSeVdN/Qyx6fzmdSlaK1uH4SmpvdSW0NqmHZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4853
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Eric,

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: [PATCH 4/7] HostIOMMUDevice: Introduce get_page_size_mask()
>callback
>
>This callback will be used to retrieve the page size mask supported
>along a given Host IOMMU device.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>---
> include/hw/vfio/vfio-container-base.h |  7 +++++++
> include/sysemu/host_iommu_device.h    |  8 ++++++++
> hw/vfio/container.c                   | 10 ++++++++++
> hw/vfio/iommufd.c                     | 11 +++++++++++
> 4 files changed, 36 insertions(+)
>
>diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>container-base.h
>index 45d7c40fce..62a8b60d87 100644
>--- a/include/hw/vfio/vfio-container-base.h
>+++ b/include/hw/vfio/vfio-container-base.h
>@@ -88,6 +88,13 @@ int vfio_container_query_dirty_bitmap(const
>VFIOContainerBase *bcontainer,
>
> GList *vfio_container_get_iova_ranges(const VFIOContainerBase
>*bcontainer);
>
>+static inline uint64_t
>+vfio_container_get_page_size_mask(const VFIOContainerBase *bcontainer)
>+{
>+    assert(bcontainer);
>+    return bcontainer->pgsizes;
>+}
>+
> #define TYPE_VFIO_IOMMU "vfio-iommu"
> #define TYPE_VFIO_IOMMU_LEGACY TYPE_VFIO_IOMMU "-legacy"
> #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
>diff --git a/include/sysemu/host_iommu_device.h
>b/include/sysemu/host_iommu_device.h
>index 05c7324a0d..c1bf74ae2c 100644
>--- a/include/sysemu/host_iommu_device.h
>+++ b/include/sysemu/host_iommu_device.h
>@@ -89,6 +89,14 @@ struct HostIOMMUDeviceClass {
>      * @hiod: handle to the host IOMMU device
>      */
>     GList* (*get_iova_ranges)(HostIOMMUDevice *hiod);
>+    /**
>+     *
>+     * @get_page_size_mask: Return the page size mask supported along
>this
>+     * @hiod Host IOMMU device
>+     *
>+     * @hiod: handle to the host IOMMU device
>+     */
>+    uint64_t (*get_page_size_mask)(HostIOMMUDevice *hiod);

Not sure if it's simpler to utilize existing .get_cap() to get pgsizes.

Thanks
Zhenzhong

> };
>
> /*
>diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>index adeab1ac89..b5ce559a0d 100644
>--- a/hw/vfio/container.c
>+++ b/hw/vfio/container.c
>@@ -1174,6 +1174,15 @@
>hiod_legacy_vfio_get_iova_ranges(HostIOMMUDevice *hiod)
>     return vfio_container_get_iova_ranges(vdev->bcontainer);
> }
>
>+static uint64_t
>+hiod_legacy_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
>+{
>+    VFIODevice *vdev =3D hiod->agent;
>+
>+    g_assert(vdev);
>+    return vfio_container_get_page_size_mask(vdev->bcontainer);
>+}
>+
> static void vfio_iommu_legacy_instance_init(Object *obj)
> {
>     VFIOContainer *container =3D VFIO_IOMMU_LEGACY(obj);
>@@ -1188,6 +1197,7 @@ static void
>hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
>     hioc->realize =3D hiod_legacy_vfio_realize;
>     hioc->get_cap =3D hiod_legacy_vfio_get_cap;
>     hioc->get_iova_ranges =3D hiod_legacy_vfio_get_iova_ranges;
>+    hioc->get_page_size_mask =3D hiod_legacy_vfio_get_page_size_mask;
> };
>
> static const TypeInfo types[] =3D {
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index 211e7223f1..7b5f87a148 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -652,12 +652,23 @@
>hiod_iommufd_vfio_get_iova_ranges(HostIOMMUDevice *hiod)
>     return vfio_container_get_iova_ranges(vdev->bcontainer);
> }
>
>+static uint64_t
>+hiod_iommufd_vfio_get_page_size_mask(HostIOMMUDevice *hiod)
>+{
>+    VFIODevice *vdev =3D hiod->agent;
>+
>+    g_assert(vdev);
>+    return vfio_container_get_page_size_mask(vdev->bcontainer);
>+}
>+
>+
> static void hiod_iommufd_vfio_class_init(ObjectClass *oc, void *data)
> {
>     HostIOMMUDeviceClass *hiodc =3D HOST_IOMMU_DEVICE_CLASS(oc);
>
>     hiodc->realize =3D hiod_iommufd_vfio_realize;
>     hiodc->get_iova_ranges =3D hiod_iommufd_vfio_get_iova_ranges;
>+    hiodc->get_page_size_mask =3D hiod_iommufd_vfio_get_page_size_mask;
> };
>
> static const TypeInfo types[] =3D {
>--
>2.41.0


