Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B7BC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 08:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR6Rl-0004UR-LC; Tue, 09 Jul 2024 04:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sR6RX-0004Sq-EZ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 04:43:24 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sR6RP-0002nB-1R
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 04:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720514595; x=1752050595;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jjzvbGiDtDGXoNFxCCQ/nBKZ8RVzdnn/UmdSXBGI9uk=;
 b=cB7SEhSWVab2rTKjJn/OytshZvbStGixL7IMqNbesyuql1aEI0mWzSjA
 dcRqFwEci/nk/sZgijnQ5/t1vUIcraNAF52FmpXmUSPi1sDiCljZorXoN
 45YJdMrtkQGsS08YX0pmoqUpizh0FuWddJXt7ONLu316GXiTK8zlWOmLq
 EJzXu8+sGFgUuxztTzXNm7wsPqgIxwfMKJL+ZpTGzaht50FkUoV9PUhBY
 L54xBmE1N2vvRo61wENhuYRyzWfZ07xBfzrVmqN1D9iLlt22+NT7tVSKE
 FpnHlByVzeXH86AfBJrQW/+w8icm1em6XQF4Sicmr6loaI64lY8bPYCZ6 g==;
X-CSE-ConnectionGUID: O6EDamutRtKpY0/gLmQqhw==
X-CSE-MsgGUID: r+Br96/lTjKJEablEzxemA==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="21565016"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; d="scan'208";a="21565016"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 01:43:05 -0700
X-CSE-ConnectionGUID: ITvn7guBQoy3YVx/8nS3NQ==
X-CSE-MsgGUID: rS+vkWZrRzONrhziSy2B4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; d="scan'208";a="47700801"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Jul 2024 01:43:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 01:43:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 9 Jul 2024 01:43:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 9 Jul 2024 01:43:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 9 Jul 2024 01:43:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQDFWeHJ5sx09YZbV3g8qBZNRhN0mZJhqTYLh9chlR2P01eBOWb0mZQQE7GH6nb0wBlzPfcVPsLI5i6qtu6IXiHUQIdRJXG3tUaFpg0f4XklinnGRmCmctqi/eF5LeM0nNiKTewCgjMtCyxte8tbso8KG7Fy+7+EuFlwkIbUfDKjVQaNWqLCi4CHFJ7RbGm945eEBjNrOhHXbrx+U9TSSXUrb1ZLROFkNMderB5nK/oSr0qfI8mzkQlzhm7CoCUVa0KEJu8eAecTCjC+cFAoTWplRZRT6Y106EL4POJDIFJNDtBly6qC24x5OtmVU4BkZ+hIEZX/FBqG/ILnPdc+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+kzNpPQLVLb/MW3SviH5DF/M4ozsq5i9yamDUZyGgE=;
 b=awx6Qfzg+V3dhxFkxd0KZXBN2oLyKD1HNU7gypQIzFFUVzT+ZnhZTCEpIP08cJuUa4mq6PxylpvmNRslO95mB1u/CXBirt4y742WaEXQoN7Q8aER5afubqZg13Zy34sQ+Fn+ch6WCCURjRZECbnbA5oZNFsPjA5L1L6Ql+2CooQ7MT0tyWOtr9zgDd8hCcV6ormpnAAdEF/7BasRX32iP5YixVB4jb/YbqyrK23y+FyvCp1C5axaYbrryn0XxKsG/tKau58C7EgpHOBGfroqLIvhNSUQkExt9JqcLk59ToNYV6mAgvnIsqT6MD2OGJK1U0QaULv4p7inheNhwffs3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by IA1PR11MB6419.namprd11.prod.outlook.com (2603:10b6:208:3a9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 08:42:59 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 08:42:59 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: "Wang, Yichen" <yichen.wang@bytedance.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>, "Thomas
 Huth" <thuth@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Hao Xiang <hao.xiang@linux.dev>, "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, "Wang, Yichen"
 <yichen.wang@bytedance.com>
Subject: RE: [PATCH v4 0/4] Implement using Intel QAT to offload ZLIB
Thread-Topic: [PATCH v4 0/4] Implement using Intel QAT to offload ZLIB
Thread-Index: AQHazwlA8st7GsK/ak2WUIuKtJOJK7Ht++xg
Date: Tue, 9 Jul 2024 08:42:59 +0000
Message-ID: <PH7PR11MB5941B008DD622227FB46E95EA3DB2@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240705182901.48948-1-yichen.wang@bytedance.com>
In-Reply-To: <20240705182901.48948-1-yichen.wang@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|IA1PR11MB6419:EE_
x-ms-office365-filtering-correlation-id: d3285eaa-eaa9-407c-1efc-08dc9ff322e0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?zQ79opyY6VV6fmvIGaMaVu2yYLr0Idp8vlgG0FH+Uv5SU2rG/YABDCEeV/?=
 =?iso-8859-1?Q?vUW2fEyDb8JI17tBV1AZPOdD5ZcCjM8r3BOK7jNyKT7YeGs0qXy6B4fqMl?=
 =?iso-8859-1?Q?KlalirT0iU1DHF3+oy/l06+xvxkheZQzcS1URBmyoOCo8p5xi4rILZQYBf?=
 =?iso-8859-1?Q?awriQ9+BGnXzGK719pq41FgRAwiyXIHwYjF6gL0sf5o6THq+AqtwdHqcoV?=
 =?iso-8859-1?Q?HNLECw2++zPkjXVWgvfXMF3cbnyDs2ruusu2Hw2aeno5ndj6DVUXW5aYhU?=
 =?iso-8859-1?Q?DEXJ7w3HN6F7clmOxTJO0VraKzzZ+oQDp7EpcpfvA5n825f3Y7TUkuwmxu?=
 =?iso-8859-1?Q?GzSttyN9AclUhxKgZRFj1fHfI97/BJRT0o2gHndOUpfkO91fxM+aFAkIhF?=
 =?iso-8859-1?Q?GWyR1f1+mAEySsuTAP2kVjEadpOO5mIHkNx3WFUiyi1pk6XWHle3gwbSgz?=
 =?iso-8859-1?Q?At//TRZGLv2qo7uKOI9tIRGgChRr7WlTB/GlWgHLWM2rJ/1jlsXmWEYiCM?=
 =?iso-8859-1?Q?iilydH/mM4xvAOisCZtVg1l6VZ9zEPKzfehRBJLwGCrCcrwK5GPAhQCFcQ?=
 =?iso-8859-1?Q?+XMpKkgI1g8BTJTFVjobzLyaIOmE2tHEVJ1ZJCB3SieCEZ/ifweNqFqn9M?=
 =?iso-8859-1?Q?hZnlp+L5k5haJ0B8VJTal2vWs59meTCkJ7ujEM5W4qtLq3yvT514OR/IAT?=
 =?iso-8859-1?Q?63L4cqdWuiUHOU8wXyNNM4una40+SM1cdlFVyEGOzG07zvsUrGbsVo4dY5?=
 =?iso-8859-1?Q?aJGuh/AWwRqbPjPC0hzRmLz87EhvGrT34N8/Xhsu9/7MDDUDpMaa4rxmNM?=
 =?iso-8859-1?Q?RQIdTAUONCIZeXB+zNa+0n/m/TRVqOX8h9FCcNC0dvj0m9DUHTA1zpdivT?=
 =?iso-8859-1?Q?a8mUhRY9QopYflZbUFgHqTDF9IJBmF9b4JnlGx4xtjH9SzdsMtRjl+1p83?=
 =?iso-8859-1?Q?P449KreKKn+VX6Bx4azbSH9cGLSUr6q/8BpPfUA4Sftft9tme4R3n85GKV?=
 =?iso-8859-1?Q?XZki959vZimFCQTFq+mijbpe12zA4ylGcjNwc8cE3+V9cgMzW6DUnpKb95?=
 =?iso-8859-1?Q?h0pvqPqcvEUcjqKBKDgeLzsitBGy7NGlSnjNeHrtlXuO+csS2Rkz7AQAy0?=
 =?iso-8859-1?Q?mST5LOztawoeJLWllmQy5jhHvbe4GWF3EsASf0jg/eRavRgrue9rVlSeOI?=
 =?iso-8859-1?Q?5VDzKf7o0fG/dbR79M9+PZjNROxucZrdJXXLr5RtBsWqb1tA0BGJfzqnw1?=
 =?iso-8859-1?Q?XWSfaQb+Cw/sNCStA9dMdAdS+zdO2U0WuRwQX9plpbrNRfOnoPvIf2/OZj?=
 =?iso-8859-1?Q?9OzNGbxEo2Oozp+XWqSUa+IMKl3jNGrxkXE77ak1yZnjAsNEYflTaPpzf3?=
 =?iso-8859-1?Q?pVazs87ZGCx++X4d1GNyZihJNY5eE7DU3WBBpwoZtAPuhivuSOOZc2AkQr?=
 =?iso-8859-1?Q?qAM7q2AsCIshBkc8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?R/X6Dyus2sq3cqqbosf4ISUX1/Iqbn7+d59AP6MAj6szTIMnSVKw6WPCa2?=
 =?iso-8859-1?Q?QD92zB9ff1xn2RSvpmMlQI9WUphy1QC3rrFcqKEAK7hgdr4rdKLUjVaLHc?=
 =?iso-8859-1?Q?J2qyau7vJkVrGTxQTz+1wLmWQ51gWrY0Y5OJ4jycJ0b6MIfL/bVAzvfxpx?=
 =?iso-8859-1?Q?MvQnU7VRUgYhxJ1J+wkSvyOHW4spvMbgDZTqfNXf9a/m+NEI8fHxSDdZ+E?=
 =?iso-8859-1?Q?hukCzJ/MYj2occIVTYWHeswmiyETBDVertEeWYLTwdQQbR3j4c9ZurOl2W?=
 =?iso-8859-1?Q?qMXsJcY3YvRSGIV3IaQU4IHirlivn6oeNbG2RaqzyrW+mrSi/Et6ehStwI?=
 =?iso-8859-1?Q?5BJXIK+FdQzvP5jLq++IzRzoAzRgNevmuh1jdPD1pKlovr6QC+/VXNlPXg?=
 =?iso-8859-1?Q?7LB4sMc1I372LIymOA4X33q1UCbTmOyWYiX22q4fs1fZ6PL5iQoNn0OXA+?=
 =?iso-8859-1?Q?BMyHp6KUeMhr2dVDOpN2FoK1bC0ZUQ6cFKkTfHzBtK1ZYEzId7AOyY3xwa?=
 =?iso-8859-1?Q?W40WTHqGiWF/E+PqUVsLVJD2eCSmod7Sc8rZR3w6BZqLddVP3zHQpq4CZL?=
 =?iso-8859-1?Q?gF6R8sSw+YMbZPMLJ/szqvKKmur47FQvGdscOfXizlsLjAnlcDNgBy4T53?=
 =?iso-8859-1?Q?5b6IX3RAB4Au4P22F9rJSy3yj7rPW07qDc9RJCabWXke6Ct3I8O4z3toig?=
 =?iso-8859-1?Q?6/TBD287k/OiK2YUqy1hwrGjbiX3qgeMLo12bxxeLuMBWgB2ch7IkJf4/8?=
 =?iso-8859-1?Q?3oI8tef5vt5NXzQKKfg/G9Q3U7giSJl9oIW/B6e2VFnPN8sAkHVkeo02bl?=
 =?iso-8859-1?Q?F5/FU4Fcio8OuSEFdgB1BZWzrNaTm5RYjEP5Spf+JEhpHb4g4zmT4MqygL?=
 =?iso-8859-1?Q?7dthC3TGyP9eq0DaEAY1Hb+oKAV3ZR/z7vVPVfiEh+3MH1kQcCsFbPDidj?=
 =?iso-8859-1?Q?2CcsUhT+53GIr4vgEjdMtdqZsD3dqXgo09H9qEll/7//7HJfP0Q23Gq9G1?=
 =?iso-8859-1?Q?zi18tIM1gt+r6ZfGzg8B7E0Gy6ohi4dQ1nAuEEM8VE3YoOwnMY4Uj4IPWs?=
 =?iso-8859-1?Q?tMl4/BEJgJQZhwiBWS6sGEO3SKFbQXF3Mz52M7fuH8y+jDYdhmyFUAXmRJ?=
 =?iso-8859-1?Q?2IlKOPIGqtec2y05aO6wGOudk7Z6gnkngKzavr+YFCmJnu6Apy0eVxK/sZ?=
 =?iso-8859-1?Q?5nECuf25cL+NhZ22HOdYA13ypEvTNy1/tYmKFHi3xivAqXDmTBSE0/nDh7?=
 =?iso-8859-1?Q?kA9tU//812KzhhWJtEihAe+7mqnhu1vqrqBHw6JSo9VZwphneGuCFXqi1J?=
 =?iso-8859-1?Q?08cUgfZZdkW0+QIpoqzo9FvNsCBI2EnbFSOtVaf0ByPBscpMqS/hVBErgK?=
 =?iso-8859-1?Q?vyzLiclGvOlXp8mtTB3gAr/LIJfr9MDjz0e6ig4Z2D3HXMLw84xHnjwjoH?=
 =?iso-8859-1?Q?yvC7qnNaxJUQISjvBZz0L4UVtvR1W9S24CZ5ObC6igiGZkcirLeDGLhLyO?=
 =?iso-8859-1?Q?z59f173VmbIuaHI6lrOZ6FknR2H/4e8343lAHt0VzbdszQA1RFJNbGJQ5j?=
 =?iso-8859-1?Q?KL36e7nLwqmuX3rwY3qbIfMvhN3QvIoDWulGzT+fY8nw8LrzaNXt3NXqVv?=
 =?iso-8859-1?Q?ZRe12WybeqlDpkEEMfZmiWD8e2OxBtAfpt?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3285eaa-eaa9-407c-1efc-08dc9ff322e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 08:42:59.0673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LVu5KnEiizxCo0m033BgZRnZtBMcxZ16A/jABN64MdlOQG0B6yBB//cH0BW0eaK71FhPiEprEDGTybHH/7hATA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6419
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> -----Original Message-----
> From: Yichen Wang <yichen.wang@bytedance.com>
> Sent: Saturday, July 6, 2024 2:29 AM
> To: Paolo Bonzini <pbonzini@redhat.com>; Daniel P. Berrang=E9
> <berrange@redhat.com>; Eduardo Habkost <eduardo@habkost.net>; Marc-Andr=
=E9
> Lureau <marcandre.lureau@redhat.com>; Thomas Huth <thuth@redhat.com>;
> Philippe Mathieu-Daud=E9 <philmd@linaro.org>; Peter Xu <peterx@redhat.com=
>;
> Fabiano Rosas <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus
> Armbruster <armbru@redhat.com>; Laurent Vivier <lvivier@redhat.com>; qemu=
-
> devel@nongnu.org
> Cc: Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1 <yuan1.liu@intel.com>;
> Zou, Nanhai <nanhai.zou@intel.com>; Ho-Ren (Jack) Chuang
> <horenchuang@bytedance.com>; Wang, Yichen <yichen.wang@bytedance.com>
> Subject: [PATCH v4 0/4] Implement using Intel QAT to offload ZLIB
>=20
> v4:
> - Rebase changes on top of 1a2d52c7fcaeaaf4f2fe8d4d5183dccaeab67768
> - Move the IOV initialization to qatzip implementation
> - Only use qatzip to compress normal pages
>=20
> v3:
> - Rebase changes on top of master
> - Merge two patches per Fabiano Rosas's comment
> - Add versions into comments and documentations
>=20
> v2:
> - Rebase changes on top of recent multifd code changes.
> - Use QATzip API 'qzMalloc' and 'qzFree' to allocate QAT buffers.
> - Remove parameter tuning and use QATzip's defaults for better
>   performance.
> - Add parameter to enable QAT software fallback.
>=20
> v1:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-12/msg03761.html
>=20
> * Performance
>=20
> We present updated performance results. For circumstantial reasons, v1
> presented performance on a low-bandwidth (1Gbps) network.
>=20
> Here, we present updated results with a similar setup as before but with
> two main differences:
>=20
> 1. Our machines have a ~50Gbps connection, tested using 'iperf3'.
> 2. We had a bug in our memory allocation causing us to only use ~1/2 of
> the VM's RAM. Now we properly allocate and fill nearly all of the VM's
> RAM.
>=20
> Thus, the test setup is as follows:
>=20
> We perform multifd live migration over TCP using a VM with 64GB memory.
> We prepare the machine's memory by powering it on, allocating a large
> amount of memory (60GB) as a single buffer, and filling the buffer with
> the repeated contents of the Silesia corpus[0]. This is in lieu of a more
> realistic memory snapshot, which proved troublesome to acquire.
>=20
> We analyze CPU usage by averaging the output of 'top' every second
> during migration. This is admittedly imprecise, but we feel that it
> accurately portrays the different degrees of CPU usage of varying
> compression methods.
>=20
> We present the latency, throughput, and CPU usage results for all of the
> compression methods, with varying numbers of multifd threads (4, 8, and
> 16).
>=20
> [0] The Silesia corpus can be accessed here:
> https://sun.aei.polsl.pl//~sdeor/index.php?page=3Dsilesia
>=20
> ** Results
>=20
> 4 multifd threads:
>=20
>     |---------------|---------------|----------------|---------|---------=
|
>     |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%=
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |qatzip         | 23.13         | 8749.94        |117.50   |186.49   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |zlib           |254.35         |  771.87        |388.20   |144.40   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |zstd           | 54.52         | 3442.59        |414.59   |149.77   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |none           | 12.45         |43739.60        |159.71   |204.96   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>=20
> 8 multifd threads:
>=20
>     |---------------|---------------|----------------|---------|---------=
|
>     |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%=
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |qatzip         | 16.91         |12306.52        |186.37   |391.84   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |zlib           |130.11         | 1508.89        |753.86   |289.35   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |zstd           | 27.57         | 6823.23        |786.83   |303.80   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |none           | 11.82         |46072.63        |163.74   |238.56   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>=20
> 16 multifd threads:
>=20
>     |---------------|---------------|----------------|---------|---------=
|
>     |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%=
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |qatzip         |18.64          |11044.52        | 573.61  |437.65   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |zlib           |66.43          | 2955.79        |1469.68  |567.47   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |zstd           |14.17          |13290.66        |1504.08  |615.33   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>     |none           |16.82          |32363.26        | 180.74  |217.17   =
|
>     |---------------|---------------|----------------|---------|---------=
|
>=20
> ** Observations
>=20
> - In general, not using compression outperforms using compression in a
>   non-network-bound environment.
> - 'qatzip' outperforms other compression workers with 4 and 8 workers,
>   achieving a ~91% latency reduction over 'zlib' with 4 workers, and a
> ~58% latency reduction over 'zstd' with 4 workers.
> - 'qatzip' maintains comparable performance with 'zstd' at 16 workers,
>   showing a ~32% increase in latency. This performance difference
> becomes more noticeable with more workers, as CPU compression is highly
> parallelizable.
> - 'qatzip' compression uses considerably less CPU than other compression
>   methods. At 8 workers, 'qatzip' demonstrates a ~75% reduction in
> compression CPU usage compared to 'zstd' and 'zlib'.
> - 'qatzip' decompression CPU usage is less impressive, and is even
>   slightly worse than 'zstd' and 'zlib' CPU usage at 4 and 16 workers.

Hi Peter & Yichen

I have a test based on the V4 patch set
VM configuration:16 vCPU, 64G memory,=20
VM Workload: all vCPUs are idle and 54G memory is filled with Silesia data.
QAT Devices: 4

Sender migration parameters
migrate_set_capability multifd on
migrate_set_parameter multifd-channels 2/4/8
migrate_set_parameter max-bandwidth 1G/10G
migrate_set_parameter multifd-compression qatzip/zstd

Receiver migration parameters
migrate_set_capability multifd on
migrate_set_parameter multifd-channels 2
migrate_set_parameter multifd-compression qatzip/zstd

max-bandwidth: 1GBps
     |-----------|--------|---------|----------|------|------|
     |2 Channels |Total   |down     |throughput| send | recv |
     |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
     |-----------|--------|---------|----------|------|------|
     |qatzip     |   21607|       77|      8051|    88|   125|
     |-----------|--------|---------|----------|------|------|
     |zstd       |   78351|       96|      2199|   204|    80|
     |-----------|--------|---------|----------|------|------|

     |-----------|--------|---------|----------|------|------|
     |4 Channels |Total   |down     |throughput| send | recv |
     |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
     |-----------|--------|---------|----------|------|------|
     |qatzip     |   20336|       25|      8557|   110|   190|
     |-----------|--------|---------|----------|------|------|
     |zstd       |   39324|       31|      4389|   406|   160|
     |-----------|--------|---------|----------|------|------|

     |-----------|--------|---------|----------|------|------|
     |8 Channels |Total   |down     |throughput| send | recv |
     |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
     |-----------|--------|---------|----------|------|------|
     |qatzip     |   20208|       22|      8613|   125|   300|
     |-----------|--------|---------|----------|------|------|
     |zstd       |   20515|       22|      8438|   800|   340|
     |-----------|--------|---------|----------|------|------|

max-bandwidth: 10GBps
     |-----------|--------|---------|----------|------|------|
     |2 Channels |Total   |down     |throughput| send | recv |
     |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
     |-----------|--------|---------|----------|------|------|
     |qatzip     |   22450|       77|      7748|    80|   125|
     |-----------|--------|---------|----------|------|------|
     |zstd       |   78339|       76|      2199|   204|    80|
     |-----------|--------|---------|----------|------|------|

     |-----------|--------|---------|----------|------|------|
     |4 Channels |Total   |down     |throughput| send | recv |
     |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
     |-----------|--------|---------|----------|------|------|
     |qatzip     |   13017|       24|     13401|   180|   285|
     |-----------|--------|---------|----------|------|------|
     |zstd       |   39466|       21|      4373|   406|   160|
     |-----------|--------|---------|----------|------|------|

     |-----------|--------|---------|----------|------|------|
     |8 Channels |Total   |down     |throughput| send | recv |
     |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
     |-----------|--------|---------|----------|------|------|
     |qatzip     |   10255|       22|     17037|   280|   590|
     |-----------|--------|---------|----------|------|------|
     |zstd       |   20126|       77|      8595|   810|   340|
     |-----------|--------|---------|----------|------|------|

If the user has enabled compression in live migration, using QAT
can save the host CPU resources.

When compression is enabled, the bottleneck of migration is usually
the compression throughput on the sender side, since CPU decompression
throughput is higher than compression, some reference data=20
https://github.com/inikep/lzbench, so more CPU resources need to be=20
allocated to the sender side.

Summary:
1. In the 1GBps case, QAT only uses 88% CPU utilization to reach 1GBps,=20
   but ZSTD needs 800%.
2. In the 10Gbps case, QAT uses 180% CPU utilization to reach 10GBps
   But ZSTD still cannot reach 10Gbps even if it uses 810%.
3. The QAT decompression CPU utilization is higher than compression and ZST=
D,
   from my analysis
   3.1 when using QAT compression, the data needs to be copied to the QAT=20
       memory (for DMA operations), and the same for decompression. However=
,=20
       do_user_addr_fault will be triggered during decompression because th=
e=20
       QAT decompressed data is copied to the VM address space for the firs=
t time,
       in addition, both compression and decompression are processed by QAT=
 and=20
       do not consume CPU resources, so the CPU utilization of the receiver=
 is=20
       slightly higher than the sender.
  =20
   3.2 Since zstd decompression decompresses data directly into the VM addr=
ess space,=20
       there is one less memory copy than QAT, so the CPU utilization on th=
e receiver
       is better than QAT. For the 1GBps case, the receiver CPU utilization=
 is 125%,
       and the memory copy occupies ~80% of CPU utilization.

   I think this is acceptable. Considering the overall CPU usage of the sen=
der and receiver,=20
   the QAT benefit is good.

> Bryan Zhang (4):
>   meson: Introduce 'qatzip' feature to the build system
>   migration: Add migration parameters for QATzip
>   migration: Introduce 'qatzip' compression method
>   tests/migration: Add integration test for 'qatzip' compression method
>=20
>  hw/core/qdev-properties-system.c |   6 +-
>  meson.build                      |  10 +
>  meson_options.txt                |   2 +
>  migration/meson.build            |   1 +
>  migration/migration-hmp-cmds.c   |   8 +
>  migration/multifd-qatzip.c       | 391 +++++++++++++++++++++++++++++++
>  migration/multifd.h              |   5 +-
>  migration/options.c              |  57 +++++
>  migration/options.h              |   2 +
>  qapi/migration.json              |  38 +++
>  scripts/meson-buildoptions.sh    |   3 +
>  tests/qtest/meson.build          |   4 +
>  tests/qtest/migration-test.c     |  35 +++
>  13 files changed, 559 insertions(+), 3 deletions(-)
>  create mode 100644 migration/multifd-qatzip.c
>=20
> --
> Yichen Wang


