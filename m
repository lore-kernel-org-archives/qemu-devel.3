Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84167CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 06:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAjZy-0003Dr-Na; Mon, 20 Oct 2025 02:41:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vAjZx-0003Dg-JO
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 02:41:13 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vAjZr-00016z-OH
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 02:41:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760942468; x=1792478468;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6C3K+GWRScHfH5y0KKjzXDWGfrlr+ftDJXoM5c6M1/I=;
 b=TuyuHRYE7UlxhluFGrhsvfaxVm40pnMoPD6Gu6ZjwgCpeBBlPVciriI8
 xl59LAETiLDuhhJUNwNpX10Jkrc2LXn528E/EOo7PDKLp3o133osA+YLs
 NllHq1acZhv20dmYwESGulb8ZCxT03MSO10PoPV55kodvFpipyueF9loT
 HsMLB3DoxRtzTgbJzkXnHWYJrlSSITcfTBU41iJlVh9HPx7b27i7RO7kH
 Qv2Vg/Qzy1Wp8H/qWkS1kBxWb4VROM4QXwnnVrdIpo3lP6KMwnHhbwf9s
 dYLmLY0RIXoMfxsIvSaEAX/xvsB6XMl3okukh08aJ0qxCN4dRpSMcRH5t A==;
X-CSE-ConnectionGUID: MBoHtW/0SBuNdY1eh1CYnw==
X-CSE-MsgGUID: hvFHA7dyQ7CNLFQDbSP/vA==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="50625741"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="50625741"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2025 23:41:02 -0700
X-CSE-ConnectionGUID: Ztntfyj9TbCIJeh9DxrefQ==
X-CSE-MsgGUID: x3I7xl6dR6KBpBSJtgY1ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="187672233"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2025 23:41:02 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 19 Oct 2025 23:41:01 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 19 Oct 2025 23:41:01 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.3) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 19 Oct 2025 23:41:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clXqHhBy8cnu8LKcIYOxEVa7sFNNR6BSGN9rHqJiH0vTQI3QWSgP9VP9OcAV7rrO/IR/7b3AbWMI3O21XQSi4chwdvwxrin/m+aGCfKI9VdM59+K6OyHGVvEwgwT63KNSYKenOIMrbRB/VCfOjesb31w7Mqc5vRXCC0/x6Ki/N5vBLQldHciiJjUZsmxzbNK9Y6WqOeVLK/ApLf9tzBxXj7zRDKyfuXmnyTqPGVq1NcN+lCXfI9wpNWN0fSnQxc3nVg3MdDEc1cI1mkjV4Bq3eJXxRkBmWr3KdFdI/JLi8XwEE8DCDkXyfyhBSZu1WrszeissocVac4avi1iFS6V9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6C3K+GWRScHfH5y0KKjzXDWGfrlr+ftDJXoM5c6M1/I=;
 b=bOjKSVyV9BfnBIyXoLyvpB2Yt57PgdM3QEaBg15el11SY3KbgJaSESFiPOqYAg/7u2FjwU93gI7pg1twGhMcgz/T5SBlSrP5OHTRr4jQi0io5lcScNB+hDZRi870e6RGvG7eDsGTaad/NYZTbPYg+fAeOks6ZDsvvdPpfLgcEzGQG0qb5QLZxfav74LDFVWZq5J4+FqZzoCCv9lPcfS1jb+F43YK2g+xs2ul64RtYIDScGq55+Acv9q5GFi/OHsFk8NwF9mEwdWn/sGTNST/xSU48yTbJMXzPNk88gaZJO3S5sWon8FwKhUqWqO1b9COz7h80RW9e8rWH1p5KgVokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by DM4PR11MB6192.namprd11.prod.outlook.com (2603:10b6:8:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 06:40:59 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 06:40:59 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: RE: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identify
 blob resources
Thread-Topic: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identify
 blob resources
Thread-Index: AQHcNL+RUYjirTlu+0+SWGS5LfcOTbS60JoAgAQ3pzCAAhCigIABcDrggABCiYCAAGOhAIAA+5vwgAA96YCAANQF8IABGecAgABPohA=
Date: Mon, 20 Oct 2025 06:40:59 +0000
Message-ID: <IA0PR11MB71856839617B01F9CB852880F8F5A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-3-vivek.kasireddy@intel.com>
 <1fd966d9-95a5-45aa-8a20-46f2987cd65a@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB718547E3A9E97A0DD6A4A2D6F8EAA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <ba762750-cab1-4cb8-a629-101de5fdc179@rsg.ci.i.u-tokyo.ac.jp>
 <CH3PR11MB7177C4541131508F53BD27F3F8E8A@CH3PR11MB7177.namprd11.prod.outlook.com>
 <955ea687-ed25-47bd-9ba9-73c6b98c8e29@rsg.ci.i.u-tokyo.ac.jp>
 <1f127ac5-10dd-435e-9ff5-f70596d7aac4@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB71853F97E13556E781AAE104F8E9A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <a0bcfbed-b6a1-42e5-b482-eb056fc2cd25@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185A158F3DC20170E673E7BF8F6A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <096c74d3-ffb7-4555-b8cd-caf88eb4de74@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <096c74d3-ffb7-4555-b8cd-caf88eb4de74@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|DM4PR11MB6192:EE_
x-ms-office365-filtering-correlation-id: 872dd234-7f03-4982-14f4-08de0fa3a16b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?OHrZAueCiEw40RJf6V/M+8Vq29JV0CMT5pXlB5yLs1affNk2i1M0WFiUv0?=
 =?iso-8859-1?Q?ceOoqAdQ4W+oiSrB/fdtNILEsuv2L4jiUxrB624IlP/Tmv04BuBjSxoKJG?=
 =?iso-8859-1?Q?MGNMMoA7Bl35/cNRDzMLyQflczqvtKnCjaGZvyXmrkbIAZ/pzUq0LE/B5c?=
 =?iso-8859-1?Q?4RaDUUYe2HQu+CPd0WX+x9Hdeg33/henjMHRcnksE8VbCVHu2fcVMgoZ54?=
 =?iso-8859-1?Q?ZWD0w4KxJSYFEZNWWwgT14puOQkUnp0j0YhfeoXB4IaicR76LvX4M/XArd?=
 =?iso-8859-1?Q?Qci6CKAWH79R6gGcY/kahEC+Kc8/bUXeK2SNPIK1kRhBmt12rxk48y0Jq0?=
 =?iso-8859-1?Q?xnVu5853oHKjCwcXOzek8MZEj/HHYHL4aSw3hD5bKpfReK7n8hxwO7jklw?=
 =?iso-8859-1?Q?QdtGxUBjv6tNS7tqvR5+KyFryAVWJgw3GqtPdDqoXaoUDn12K6h0kInl1O?=
 =?iso-8859-1?Q?4kDvSUmoCvxfCgTSamdjTptrDnhPNlDRDdiyhhXccug+KmAw1bGdn6bq0o?=
 =?iso-8859-1?Q?KXfNJY2ViPym4Omvlm7U1d20qExnDUNnbe+AmKfSSlpac24pABvB7IVq6O?=
 =?iso-8859-1?Q?rBv7OUvon5/1OI5pr30xGpMbX2enNvRykhAvvsfN2Hj5nxkLxHV5YOEpU0?=
 =?iso-8859-1?Q?P4cBQGaUBNsZ4ksD9Tz/MInobuwHGYsRHm0cXIDdMsRObUNjp9YSBTZBf5?=
 =?iso-8859-1?Q?m6K76VVezou86yPYK6/XjC5M/dsp1AhYuNSRiXlKnDSqIdDOHzp8y4l3gC?=
 =?iso-8859-1?Q?0MiEvx+epvegti2ktsRcnBhwV3bpwLKgHpix7tc8djLluQ0spPd96+iQdf?=
 =?iso-8859-1?Q?z1sjihtvt5d4QcIeFACi4Lwa3TztKqdE+ANzXZuqSSDfk4GkWZswa+K8EU?=
 =?iso-8859-1?Q?wdSkb2bvHaJiTaKH1SZ/drmhN3AuZbjOzmma0IptnrKGp55GFBXDE1gOAA?=
 =?iso-8859-1?Q?9tO2H3bHrIvpwcBm4dkymXO8yGkbC07t7SWeNdUGwbdGISGP9bC2rud8FH?=
 =?iso-8859-1?Q?TxLAWt/XWpy1hY+IlPf2heP1RuTXLlyl11sJC+CtnUHOpB3F5AOxciSRbz?=
 =?iso-8859-1?Q?fH+wXtRL5zl7DLYikjFWCPmfta/Ovw4sw/6E/gnzzG1syGpBF7YKovqjKG?=
 =?iso-8859-1?Q?Mysgswn824qJQKCucMyvitcl2O4pB5qTgPcFnEdcO73GZH22NjIA9o2uJj?=
 =?iso-8859-1?Q?IdW2XAtAWOXwiQ+iOkLFGlhvEWMPbCq1FfrSPRDyqb0MJ9hGJBkA1W/qoO?=
 =?iso-8859-1?Q?el7nLRzZQb8HS4VXZL5t3Q2at4Fj1JmwwUplnpkMkmPuzc9VjxTeF2jccx?=
 =?iso-8859-1?Q?q/CGeybZJUEGt1dBzOkr4F5qdQMGdgNWBy9X1v0quseMdDX/7UbPbRxIV1?=
 =?iso-8859-1?Q?zk/oVzJl9eY3J4TBBuLkLTX/coY1QhFvPj6wVuFLb+In7ZsvuvzDWhyUCo?=
 =?iso-8859-1?Q?AInXwe9h9nc65vVWJbsTPTQKU+AW/w4EX4ErFTsQYM5nCMffetv3IPnmEg?=
 =?iso-8859-1?Q?q/j77I8n0aTuHbIVR+voyRqgf16vI9CWy6+t99zZascg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nmn0iQZMnqYANw5iz2yvn300Q9eqOLaR5hdWjwdRgLyUtDUbSy2oup4kE/?=
 =?iso-8859-1?Q?yJGv/oDaLQZmCJOWE5GMgfKasOktHByYke+S1+u/c/uZl6gjnn4ZSEifYT?=
 =?iso-8859-1?Q?ejtPvCAtYm2jJCMTXayJO3erGhXR7rRXgZpN6duTIGaYDSOR7nsr8nweAJ?=
 =?iso-8859-1?Q?4K2+oDRhk0jqyBKsJHFac2VkbHO6NirXBEl2DuygU8Hloe0wKrAqfRcWsp?=
 =?iso-8859-1?Q?n7M1fICsymUX9v3NQbMzSgOQdHf9le14qOZHKBeuYYHLe9lSOdEzEvd4d9?=
 =?iso-8859-1?Q?tzyOVBnD0QPPfEoLTieRiXF5G8Lg5vug5OHrlT68rxnc1v9KiEOqkI2kSv?=
 =?iso-8859-1?Q?K5DNk7FJxxGs6pK2ik1UuhgPmUzt7LLtDXUZHZ/Lt9a93osnXtRxaqkgGZ?=
 =?iso-8859-1?Q?gy0rkyhSKBO1H6RB6ciQqAEHcKwng9NRHHBP90GtUM5vO4p+B6ORbLOcPB?=
 =?iso-8859-1?Q?TwFLagSb6VkPGrJWDMkm8EXJc+7t2KRIHEVjWh/6wfJ1SGNYaed77vIblZ?=
 =?iso-8859-1?Q?8DZg22KimJSiUoK6YV6NJjB+YWg8xGqHY8SmhmgyGnX/r1NiFX8Ki7mcVw?=
 =?iso-8859-1?Q?sxThcGRd2IGtWAXipIsLP18pa814RcVB4VKJcv6BRja19qTYMXBuG95i+J?=
 =?iso-8859-1?Q?pF4EVvpLI8k/CV7+tW+pcI+ZDHHXBfh3mSaoPVu3MFcLxJXtsMS5NftHzC?=
 =?iso-8859-1?Q?3Fwy6IObtDeEHxXsAX4cLcLqwO8UBf9iPjt5enmVYnLaF1Dz8QWVT/B7aK?=
 =?iso-8859-1?Q?4GyVmR6lLuBPgme4I4M5ZCvG66wWWSCDgOTHwZJwZO3TkPdZrRaFUIkfF5?=
 =?iso-8859-1?Q?TBAadgNabZ1BDo3DJaSb3BT1pKtMoXMbTbqIbjO8Rzf1+CyWt8hdm3l9qD?=
 =?iso-8859-1?Q?VavzxiYM4H/klXUyMEuz7zbi1P0i7IUVqr3T53v79w0eZ6ln9sq+pOL86w?=
 =?iso-8859-1?Q?o2iw6Ixra9o7kwglYQQ8VWYsxakR/3kZLIEiiT6EzcLrRC8OdcSY7eXxWF?=
 =?iso-8859-1?Q?6ZW4PjftIktzYk5RUIE/Boz3e6cspcUqDEzMi1pZ0kGtmVmeHpl0IK3VBX?=
 =?iso-8859-1?Q?kUrg61VYR7PxLp+H1iT2+DSd6IJcC3wTV8VAKW6s18IIiCY7ywaHl+QHml?=
 =?iso-8859-1?Q?NuQ+7HT477LK9sMyHE0hTJHu7MhX+z1jqKloWJGFij3YUZ6xauMhIMtEQQ?=
 =?iso-8859-1?Q?uRWwEes8HXaCpkOIaTsyg+aInVEUEPsEFhGh+t03Vt//9c/DyMiCC0rd7j?=
 =?iso-8859-1?Q?uPfxqRXL6pgRW9HjPzgmdFSBSav5USHhBzGXHpERn/A9SV3XUPErXUxNEF?=
 =?iso-8859-1?Q?cH2/YySwg0p9JvkoWMvykAHVFcWWZlCxkUN7syPkR8/BGYfu3re9spmvW+?=
 =?iso-8859-1?Q?TpuxgVaNWcjE0ETaZs9tWXn8/j4h/dxQCKH99pdgC8Dd5m+sHpvZk441nr?=
 =?iso-8859-1?Q?AB46gHhHdqIL1DE1uHQO4LrjF6DstX7kFbrUV/iMuKNSiSRY83n4CnHqXx?=
 =?iso-8859-1?Q?Bp9M+higc6klul4M8S4e86mkmrxRPXS84XHogP0eyLFzS+HjRKoeXTIQB/?=
 =?iso-8859-1?Q?3IzEuzmHZNwpCxeWn0xa4NM4/uv07AgHg4xQvji/MKSobmnz8/b5s14QoE?=
 =?iso-8859-1?Q?3huOZyayCtptKZxT7EglPwunERQiK/7H76?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872dd234-7f03-4982-14f4-08de0fa3a16b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 06:40:59.5200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XLXkzHCzt+ureONYorkGqsTXuJvpwPlBQVsdKU58DjfMszJWGKtWCspPmiMXWa3xI01w4p3iTn4/OZgyGe6TAbn1rnmSuqKc27Lzy0/nSwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6192
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
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

Hi Akihiko,

> >
> >> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to ide=
ntify
> >> blob resources
> >>
> >>>>>>
> >>>>>>> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob t=
o
> >>>>>>> identify blob
> >>>>>>> resources
> >>>>>>>
> >>>>>>>>
> >>>>>>>>> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob=
 to
> >>>>>>>>> identify
> >>>>>>> blob
> >>>>>>>>> resources
> >>>>>>>>>
> >>>>>>>>> On 2025/10/04 8:35, Vivek Kasireddy wrote:
> >>>>>>>>>> The res->blob pointer may not be valid (non-NULL) for some
> blobs
> >>>>>>>>>> where the backing storage is not memfd based. Therefore, we
> >> cannot
> >>>>>>>>>> use it to determine if a resource is a blob or not. Instead, w=
e
> >>>>>>>>>> could use res->blob_size to make this determination as it is
> >>>>>>>>>> non-zero for blob resources regardless of where their backing
> >>>>>>>>>> storage is located.
> >>>>>>>>>
> >>>>>>>>> I think this patch is no longer necessary since now you add cod=
e to
> >>>>>>>>> mmap() VFIO storage with "[PATCH v1 7/7] virtio-gpu-udmabuf:
> >> Create
> >>>>>>>>> dmabuf for blobs associated with VFIO devices".
> >>>>>>>> Right, but given that mmap() can still fail for various reasons =
and
> >>>>>>>> this
> >>>>>>>> use-case can work as long as dmabuf creation succeeds, I think i=
t
> >> makes
> >>>>>>>> sense to not rely on res->blob to determine if a resource is blo=
b or
> >>>>>>>> not.
> >>>>>>>
> >>>>>>> I think the code will be simpler by making resource creation fail=
 when
> >>>>>>> mmap() fails, and I am concerned that the guest may mulfunction
> >> with
> >>>>>>> such an incomplete resource.
> >>>>>> AFAICT, mmap() is a slow, optional path except for the cursor (whi=
ch
> >>>>>> needs
> >>>>>> further improvement). So, failing resource creation when mmap() fa=
ils
> >>>>>> does not seem like a good idea to me given the fact that supportin=
g
> >>>>>> mmap()
> >>>>>> is considered optional for dmabuf providers. And, even with vfio,
> >> mmap()
> >>>>>> can be blocked for various reasons by the kernel driver IIUC.
> >>>>
> >>>> Reviewing the code again, I don't think mmap() can fail with the cur=
rent
> >>>> version of this series.
> >>>>
> >>>> udmabuf obviously always supports mmap().
> >>>>
> >>>> For VFIO, checking memory_region_is_ram_device() ensures that VFIO
> >>>> supports mmap(); memory_region_init_ram_device_ptr() is called from
> >>>> vfio_region_mmap(), which is only called when VFIO supports mmap().
> >>> My point is not whether a dmabuf provider provides support for mmap()
> >>> or not but about the fact that mmap() can fail (for various reasons
> >> because
> >>> it is not a guarantee) making res->blob NULL. But we are incorrectly =
using
> >>> res->blob pointer to determine whether a resource is a blob (and usab=
le)
> >>> or not which doesn't make sense because even if res->blob is NULL, th=
e
> >>> resource is still valid and usable via the dmabuf fd, which is the pr=
eferred,
> >>> accelerated path.
> >>
> >> Failing to mmap something that is already mmap-ed to another address i=
s
> >> very unrealistic and I can't really think of a possibility of such a
> >> failure aside bugs.
> > The fact that it is already mmap'd to another address would only be tru=
e for
> > VFIO devices but as I mentioned previously, we cannot make such
> assumptions
> > with other (future) dmabuf providers.
>=20
> It is true for udmabuf, though the memfds that back udmabuf are directly
> mapped instead; I don't think the indirection of udmabuf makes any
> difference.
>=20
> If it's only for future DMA-BUF exporter, it is better to make the
> change when the exporter is actually added, or we are adding code that
> cannot be tested right now and may or may not work when such an exporter
> is added.
>=20
> >
> >>
> >> If this condition (a valid resource with a NULL res->blob) could only
> >> happen due to a bug, then, in my opinion, marking such a resource as
> >> invalid is actually a more defensive and desirable approach. If a core
> >> operation like mmap fails unexpectedly on a resource that should suppo=
rt
> > But mmap is not considered as a core operation for dmabuf. It is consid=
ered
> > optional by dmabuf providers. For example, although very unlikely, it m=
ight
> > be possible that support for mmap() can be removed from udmabuf driver
> > driver for some reason. And, when this happens, the only adverse effect
> would
> > be that gl=3Doff would not work, which is not great but definitely not
> catastrophic.
>=20
> We should be able to safely assume it never happens due to the "no
> regressions" rule of Linux. If a userspace program breaks due to a UAPI
I help maintain the udmabuf driver in the kernel and AFAICT, that rule does
not apply here because udmabuf driver providing support for mmap() cannot
be considered UAPI because it is not providing any direct (user visible) in=
terface
to invoke mmap() as described here:
https://docs.kernel.org/admin-guide/reporting-regressions.html#what-is-a-re=
gression-and-what-is-the-no-regressions-rule

> change, the UAPI change is a breaking change, which kernel developers
> carefully avoid.
>=20
> Existing QEMU versions will break if such a change happens. Perhaps the
Qemu should not have assumed that udmabuf driver (or any dmabuf provider)
would always support mmap(), because for dmabuf providers like udmabuf,
supporting mmap() is optional as mentioned here:
https://elixir.bootlin.com/linux/v6.17/source/include/linux/dma-buf.h#L269

And, as mentioned previously, Qemu would not break if a dmabuf provider
does not support mmap() because the preferred, fd based fast path (gl=3Don)
would still be available.

Thanks,
Vivek

> no regressions policy may be exempted if the relevant userspace program
> is so broken that it depends on something never meant to be stable, but
> it is not the case.
>=20
> Regards,
> Akihiko Odaki

