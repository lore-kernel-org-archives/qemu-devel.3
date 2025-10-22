Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491D7CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 05:11:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBR7H-0004yc-5K; Wed, 22 Oct 2025 01:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vBR7F-0004yO-BM
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 01:10:29 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vBR7B-00016D-JJ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 01:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761109825; x=1792645825;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RDvuzrr5txdU9QwgdQyr9lc10+du+ZTa22jKgqRvdTg=;
 b=c3snc+AmZRoNTYhEZXzhohbHTtr9GiLcQ551gvLxaAXflCahgwf8L6/1
 RQfZBYxFJDxaQNlhXaV3rntHM7K/k/j5BbcKQFCcn0u7lnQeko8L3lDo4
 nTKNhSEsZ0RhutyIvH4gh4A+DZQKMDce0Bx1BEkdqPUuM2fjnczMYQjCl
 Ac5l1PLkHL+asOVGXIUghiN3FWcbIT+tDrkLPK+/HR/vpsb3J+zlneJ0x
 c/Zww2rA9d0I9A1yE3eALotRw+aN5307XduDXYixEn5rwnsJBbwT2Nvmr
 5IOu5SHYelota0ahZ5+S5QA0I3R7I4MDeyjhI7ReDw4kx7G8TIbmuDL6P g==;
X-CSE-ConnectionGUID: f4mlSTzRQom6X5oVCnL5Gw==
X-CSE-MsgGUID: s6WZd1FsQ+GF8Bwl/m5F0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73917301"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; d="scan'208";a="73917301"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2025 22:10:21 -0700
X-CSE-ConnectionGUID: LJ9S4TFPQOenAkJLD1RAxw==
X-CSE-MsgGUID: 505uRUDHS8GVIK/WtB1tig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; d="scan'208";a="183475533"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2025 22:10:21 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 22:10:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 21 Oct 2025 22:10:20 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.44) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 21 Oct 2025 22:10:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLQNGU5OZmgMWI4IMjT4Kf+3NYCT20kuIjYbezLsMc88OVoZ+24rJuALEu/ni9f7zBZ2pSJyVXUKC83ueQBcZUJjdYUcpDp6dyYjuFBDr0oK17v3Fl5C17461cRp2gdQFL9CsWBnPvrvWPeyr1h8eQHWemkzFPaeLM9HuVdekzDez0xqGJq519I6VahR4K57CWI2sL4JGbPjpASSaTI1xZRawIRJd4gFvqxVdKTgLPXws+BLuGi2geqmuBIQGNHEF2+Sva4AGvM8O/F4NXbs64Z6j+uf7R5/TRWOdebfF1i+qh8TCYrmUtj7ZJury0XvmbnaJFRA7Dxj8cmafalv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDvuzrr5txdU9QwgdQyr9lc10+du+ZTa22jKgqRvdTg=;
 b=HYh7upSwRgiV4dmrI4VZLdH/fFV1O1lLreHwZzlSkpwXAMXW0w5ahUrJuKHIP+46eKkuuf/B5wymrLwBjbc562GoBoZSacDQWYfkjhhEUqMCcbJbhxrw9ahboZERLrY5ZgXpgeaRZ3dub2NIBmqB2cPZeV9nnl9io8ZcqBzQhnXR3lGsAiurTxELUVGDJjB3agaZMd68uk7ua2t67YdUBVlDthCPJPc/DjTog3hxDH+MzmRKiGNxJdOBV2W9SRnbmA39rUOTtwMHIHlUafVi3ECWthrcarqK73yavxQ85SH+YX4/X18JIeTSy5RsKTovzNtJOya0lIN3Uk6MYlRF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH0PR11MB4838.namprd11.prod.outlook.com (2603:10b6:510:40::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 05:10:18 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9228.016; Wed, 22 Oct 2025
 05:10:17 +0000
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
Thread-Index: AQHcNL+RUYjirTlu+0+SWGS5LfcOTbS60JoAgAQ3pzCAAhCigIABcDrggABCiYCAAGOhAIAA+5vwgAA96YCAANQF8IABGecAgABPohCABXQMAIABCQfw
Date: Wed, 22 Oct 2025 05:10:17 +0000
Message-ID: <IA0PR11MB718515058F01C0E9F89AAC53F8F3A@IA0PR11MB7185.namprd11.prod.outlook.com>
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
 <IA0PR11MB71856839617B01F9CB852880F8F5A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <d5d9d06c-368f-4098-bc04-41f08945778a@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <d5d9d06c-368f-4098-bc04-41f08945778a@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH0PR11MB4838:EE_
x-ms-office365-filtering-correlation-id: f765f3ad-fbbc-491d-76fc-08de11294a8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?tj0xf6XHx1cLf7wvsQ3nglkE6haVTqOWkhcV2GPCBq5ZJLFABONXJCIRBD?=
 =?iso-8859-1?Q?NztJ8KfxCZjfA3qqvoIfY6PC7xeArJPtojRsZ5IKVACcunQTv5nsz3Qikc?=
 =?iso-8859-1?Q?LNWb8psydlXHtauHpL6cXXbqveQvF4MOsYl0WpSsstlvBKGUX3G5uC/nzb?=
 =?iso-8859-1?Q?BXJIGSEvdSwKBA5JMQL1/lgIa0qE3h+klHsoaztjUFrMmGY3EwE689E8TC?=
 =?iso-8859-1?Q?Wj3KBKwxMzXBFE3M2krNfvxsoVUMCTmqeNMVhRuqVOgjzRH3krK2mFXW3T?=
 =?iso-8859-1?Q?Vdzb+zyIx5m52Xh9xLOInVr/1CaiG79uvznr3XC71dOcKQCkYc/+uKQ+Qy?=
 =?iso-8859-1?Q?C3ZO6uRF/Hu7nUwy9kt4ydj9onUslCUBuolxZ8r2Quyylhl8CWK2XtKJtt?=
 =?iso-8859-1?Q?Hqm/KvcIFcCSFeImOHgHPy64zI9bi8psU9QwvF6RUenjjTuT+6Z2Yodebb?=
 =?iso-8859-1?Q?/qFkVmHxE4SYsBEps3Ix2UXAr2hm3BgOpzCQuFDmpbZZclUO0ngTSA+gi+?=
 =?iso-8859-1?Q?v2ocgAMM8rhEmd9CTdKjc5jX0J9LouZTG4ynj5Jyd4K7zvzwX3dAIHD7Ro?=
 =?iso-8859-1?Q?daZqNf4qi9NnF2qF4VZZbrFtvBN8+2b+tAVzg16oVuKijT+iQHPKVu8yGM?=
 =?iso-8859-1?Q?rx5R1zmUIZYmuDzEobkNC2Ka55iLeI3EiAjB3H1yHNR/vu0ituBxFjnOpC?=
 =?iso-8859-1?Q?AE3fDNcTaujAq49flK0A8eoya195RrLLXmg6TZ0dqzv533ac+16NNWUpJa?=
 =?iso-8859-1?Q?lJRQWTS2n331aQ0+FhejpDjbzHx6ihNKwB6uRLTv/1kuaIH0nEoan1ZpBk?=
 =?iso-8859-1?Q?HgpjFS+/Xz53/yF9QZv6akFSoGPSgdA/qL8GglaTjfO8Wa7MtJAXnFAwwY?=
 =?iso-8859-1?Q?3LnrU9M4fRh5xjPae7L+bD5Jlrw9BERiNth2o5lbGPk9gsUuStS4fYpqij?=
 =?iso-8859-1?Q?1Mf+5eUhUKpZOdOApEUn5z0Q1z+6PppDjHGT+6vZjOMCF5GtK4r1b2v/VV?=
 =?iso-8859-1?Q?Qrk0O3hDfouBCztDHkUEA6KHQF8vPT+a5wPXpnPFvg9dxVm04tmGeH1ve0?=
 =?iso-8859-1?Q?CDb8yA/aKci9dcNNL92ReELaeWpUiR4i7uaGUgIc+oV1tqtWDpKjtDbrD7?=
 =?iso-8859-1?Q?MHFJbYZHZP7pi4D0jlKfhygAiIVQGrpqfKGNPFE5B//i7lSJgGLVsQMbAW?=
 =?iso-8859-1?Q?pcfwoZiMPSgMp1fgeKpwvP2iIzszcUio/QiQpTV3+cLP0E6ApCh6+W6GPM?=
 =?iso-8859-1?Q?8QHkd2ZKqa746OouTdYKrZH04fhsqhBbrCifhu6YjvMt86L3f4Rlsjoq7Z?=
 =?iso-8859-1?Q?dDra7FSEukLPPXVQUht1SA+ZALRCDssnucSsN6VpUapGD0rVzDTsHdfHX5?=
 =?iso-8859-1?Q?Youn48QizQ+f2RrVbuEAvUOEV5GsOz8JTzit57HdTeVdU0cj0xMmQOGxTX?=
 =?iso-8859-1?Q?ViCN3CW9LS6i0DjaGhhkP7IJombWL9Id0WseuvDVy+fTGpt9HKH1E3lq/o?=
 =?iso-8859-1?Q?JjAzP7rey3jUjUrP62GQXGDMOvcdj9a+6M4gSjAWzeUOrS4loZS9kOrODu?=
 =?iso-8859-1?Q?7NwZ/AJHvJvj/giZW4Dsl5kmJh7+uIfGpxW2hAhbay/pWou0lg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?M2i1sp2c6ldWFark1NeWuN9hHcX4zAzgUJU5BJ/y+bpcJYjoHCsdwOowHm?=
 =?iso-8859-1?Q?eoZVht3LhEGyqKCqEtl+iBwXKHKVJoiUKt33d/Z1dkJ7kEYiaabbUg+IFw?=
 =?iso-8859-1?Q?vjEgBitJOpfw03Y3chUxtGZwZd1GjFZd8WkBeUK5nw1PwhoPin+H4vNlo+?=
 =?iso-8859-1?Q?dchJvWSLMAoL4dOXrJMRvEuGLaHfkiey8cMlPg/xLXsek+Q1Ufr2l9RVdy?=
 =?iso-8859-1?Q?jlJQ99B1Kqz9JzxnhDTV4qr4eu1M2n4bBb1I4ygrrGaWVZES9o69L9rVJm?=
 =?iso-8859-1?Q?6i5uV171ERXRF07YlPeR9NxEsbdhzD35jFeQUNuzQv+U/4RRrB9sq7W8zA?=
 =?iso-8859-1?Q?1EDZz8wTJA+7flB+zr0EAGkWz/CqAn5IykIHZqZJMBJmlyY4ZxVcByusys?=
 =?iso-8859-1?Q?ow2Zj5X0XlyduiBxooSrJguNoerJl3edTaXheWsDQz5Qp2vj3l803smEv4?=
 =?iso-8859-1?Q?3rsigpsR411fLnGtsyOZxdb+7k8QHIH83t/U3ehytU5NBom9Yfu40BZZJL?=
 =?iso-8859-1?Q?YL9Qw0al8NAc/ZYbD7A5EWYh3tHbjw2YYhiGAX8+ncgRbDw+VdYnlsmjL7?=
 =?iso-8859-1?Q?RAJjGvrVblqA9/TqC87fl8qF4hnN55tETUM2NhkXXYF+BujMPCEQ0+Lwje?=
 =?iso-8859-1?Q?oQvFdZW9qI1VvA7s50yv0TG6ppt0f+Gil3yNUZ0Gez6cJddiK6FqyZ0+ry?=
 =?iso-8859-1?Q?GgnKAyT+XPvtmVd2XH+GUd/wDRUXsknMKqSzbJTBZLRhEZQLpAyO+8uDpZ?=
 =?iso-8859-1?Q?ufWslce1EUvN+t/mfgc+1Ewto5Fd6TRGmhEIvVdhp6bPyqQZOwUdmk0Q1r?=
 =?iso-8859-1?Q?p6Wt1kOUwu3Ess/vCPwOIHeCwvBG6Htly+fvBdFrYwPrmrvOYJ7ujT7GMa?=
 =?iso-8859-1?Q?+QfIZ+K9LmFiO1+JnMRPtaKF3lspPJ/tLz1c0nvjqOW9O8HSOSFMLuKi1M?=
 =?iso-8859-1?Q?XOAPTa4/gjKkufn6X5hh3LQ5zfW+zQTTFfVXNRCFSmOjqpW8hFdD/GvlQz?=
 =?iso-8859-1?Q?O8nJxVT0RP2QdQwRQqUhuYDTQq+V2pzUMgQ/8AdSjXTVSECzPDPHgEp/6c?=
 =?iso-8859-1?Q?SiIuNn8lvJKcnSZAGsC0LdKRytXVBOAHmXvIRrSJRmXFvNqDDMxOnSwlTl?=
 =?iso-8859-1?Q?VO3+HoNbv2kQ7QYSm9jDpwZwno2o8cIuQTxI7sIBP9mAwLEstv811Wpnrg?=
 =?iso-8859-1?Q?/CGXFzKTjPDfsiuemhX/7EYCHRnVHK0JEUVV8MKpJ3HkhAt3frTxTwPyQS?=
 =?iso-8859-1?Q?d36uDBsVeys7x3UobTxQbIWQnnm80oBNX4g1+rpay2RjbdErreghsT/suY?=
 =?iso-8859-1?Q?oqCxq5EAmF+etbahFPQrHVkGSu17aq/aVfICW2XvT8sEPTRfszHf4uloi6?=
 =?iso-8859-1?Q?sBz1Msls1KzK9xmNiZGgXrdxAMBpZ213JeCeKI97on71iea5xMP2sAIm//?=
 =?iso-8859-1?Q?Okq6teeBQ6jrb/gnl1viU782aLK/1OekL05hY15Rf+EvIdEKdCKSnOSI8d?=
 =?iso-8859-1?Q?mMRsJHuaJTbIwOK7vaipSTzsfEYCWqdV+/mm9j2uO+BXp+jOH53k/oREDg?=
 =?iso-8859-1?Q?XuG5FrRzz3veFdQ6GJzltnQ9nyIzx3+TPOjhe8XCwsp4BLjaIsa8dmZKme?=
 =?iso-8859-1?Q?tYjxvl1Y/8svEIS+d0Dcvm39Jc1l0wjRRE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f765f3ad-fbbc-491d-76fc-08de11294a8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 05:10:17.4801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yexstP+VXv4+B1MXrgcrZ0CGcIVc4L7ezxCBrqkyEjBpr0djQDg8WZ0M8G4EtWhwxICDU6/8nCyIVZQY3fW3vpKa6Z6NEz+yxkg7b3XW6VE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4838
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
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

> >>>
> >>>> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to
> identify
> >>>> blob resources
> >>>>
> >>>>>>>>
> >>>>>>>>> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob=
 to
> >>>>>>>>> identify blob
> >>>>>>>>> resources
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->bl=
ob
> to
> >>>>>>>>>>> identify
> >>>>>>>>> blob
> >>>>>>>>>>> resources
> >>>>>>>>>>>
> >>>>>>>>>>> On 2025/10/04 8:35, Vivek Kasireddy wrote:
> >>>>>>>>>>>> The res->blob pointer may not be valid (non-NULL) for some
> >> blobs
> >>>>>>>>>>>> where the backing storage is not memfd based. Therefore,
> we
> >>>> cannot
> >>>>>>>>>>>> use it to determine if a resource is a blob or not. Instead,=
 we
> >>>>>>>>>>>> could use res->blob_size to make this determination as it is
> >>>>>>>>>>>> non-zero for blob resources regardless of where their backin=
g
> >>>>>>>>>>>> storage is located.
> >>>>>>>>>>>
> >>>>>>>>>>> I think this patch is no longer necessary since now you add
> code to
> >>>>>>>>>>> mmap() VFIO storage with "[PATCH v1 7/7] virtio-gpu-
> udmabuf:
> >>>> Create
> >>>>>>>>>>> dmabuf for blobs associated with VFIO devices".
> >>>>>>>>>> Right, but given that mmap() can still fail for various reason=
s
> and
> >>>>>>>>>> this
> >>>>>>>>>> use-case can work as long as dmabuf creation succeeds, I think
> it
> >>>> makes
> >>>>>>>>>> sense to not rely on res->blob to determine if a resource is b=
lob
> or
> >>>>>>>>>> not.
> >>>>>>>>>
> >>>>>>>>> I think the code will be simpler by making resource creation fa=
il
> when
> >>>>>>>>> mmap() fails, and I am concerned that the guest may
> mulfunction
> >>>> with
> >>>>>>>>> such an incomplete resource.
> >>>>>>>> AFAICT, mmap() is a slow, optional path except for the cursor
> (which
> >>>>>>>> needs
> >>>>>>>> further improvement). So, failing resource creation when mmap()
> fails
> >>>>>>>> does not seem like a good idea to me given the fact that
> supporting
> >>>>>>>> mmap()
> >>>>>>>> is considered optional for dmabuf providers. And, even with vfio=
,
> >>>> mmap()
> >>>>>>>> can be blocked for various reasons by the kernel driver IIUC.
> >>>>>>
> >>>>>> Reviewing the code again, I don't think mmap() can fail with the
> current
> >>>>>> version of this series.
> >>>>>>
> >>>>>> udmabuf obviously always supports mmap().
> >>>>>>
> >>>>>> For VFIO, checking memory_region_is_ram_device() ensures that
> VFIO
> >>>>>> supports mmap(); memory_region_init_ram_device_ptr() is called
> from
> >>>>>> vfio_region_mmap(), which is only called when VFIO supports
> mmap().
> >>>>> My point is not whether a dmabuf provider provides support for
> mmap()
> >>>>> or not but about the fact that mmap() can fail (for various reasons
> >>>> because
> >>>>> it is not a guarantee) making res->blob NULL. But we are incorrectl=
y
> using
> >>>>> res->blob pointer to determine whether a resource is a blob (and
> usable)
> >>>>> or not which doesn't make sense because even if res->blob is NULL,
> the
> >>>>> resource is still valid and usable via the dmabuf fd, which is the
> preferred,
> >>>>> accelerated path.
> >>>>
> >>>> Failing to mmap something that is already mmap-ed to another
> address is
> >>>> very unrealistic and I can't really think of a possibility of such a
> >>>> failure aside bugs.
> >>> The fact that it is already mmap'd to another address would only be
> true for
> >>> VFIO devices but as I mentioned previously, we cannot make such
> >> assumptions
> >>> with other (future) dmabuf providers.
> >>
> >> It is true for udmabuf, though the memfds that back udmabuf are
> directly
> >> mapped instead; I don't think the indirection of udmabuf makes any
> >> difference.
> >>
> >> If it's only for future DMA-BUF exporter, it is better to make the
> >> change when the exporter is actually added, or we are adding code that
> >> cannot be tested right now and may or may not work when such an
> exporter
> >> is added.
> >>
> >>>
> >>>>
> >>>> If this condition (a valid resource with a NULL res->blob) could onl=
y
> >>>> happen due to a bug, then, in my opinion, marking such a resource as
> >>>> invalid is actually a more defensive and desirable approach. If a co=
re
> >>>> operation like mmap fails unexpectedly on a resource that should
> support
> >>> But mmap is not considered as a core operation for dmabuf. It is
> considered
> >>> optional by dmabuf providers. For example, although very unlikely, it
> might
> >>> be possible that support for mmap() can be removed from udmabuf
> driver
> >>> driver for some reason. And, when this happens, the only adverse effe=
ct
> >> would
> >>> be that gl=3Doff would not work, which is not great but definitely no=
t
> >> catastrophic.
> >>
> >> We should be able to safely assume it never happens due to the "no
> >> regressions" rule of Linux. If a userspace program breaks due to a UAP=
I
> > I help maintain the udmabuf driver in the kernel and AFAICT, that rule
> does
> > not apply here because udmabuf driver providing support for mmap()
> cannot
> > be considered UAPI because it is not providing any direct (user visible=
)
> interface
> > to invoke mmap() as described here:
> > https://docs.kernel.org/admin-guide/reporting-regressions.html#what-is-
> a-regression-and-what-is-the-no-regressions-rule
>=20
> I suppose that the result of open("/dev/udmabuf", O_RDWR) and the
> UDMABUF_CREATE_LIST ioctl is always compatible with mmap(). Not sure
> what you mean by "direct" interface, but they are all plain userspace
> interfaces.
>=20
> I suggest asking people maintaining the udmabuf and the DMA-BUF
> infrastructure if you know them.
I am one of the two maintainers of udmabuf driver and I am also involved
in the discussions with dmabuf maintainers regarding upstreaming of
vfio-pci dmabuf feature in the kernel. And, based on these interactions,
it is clear that mmap() is completely optional for dmabuf providers and
userspace should never make any assumptions about whether mmap()
(for dmabuf) works or not. Here is one reference:
https://lore.kernel.org/dri-devel/Zjs2bVVxBHEGUhF_@phenom.ffwll.local/

>=20
> >
> >> change, the UAPI change is a breaking change, which kernel developers
> >> carefully avoid.
> >>
> >> Existing QEMU versions will break if such a change happens. Perhaps th=
e
> > Qemu should not have assumed that udmabuf driver (or any dmabuf
> provider)
> > would always support mmap(), because for dmabuf providers like
> udmabuf,
> > supporting mmap() is optional as mentioned here:
> > https://elixir.bootlin.com/linux/v6.17/source/include/linux/dma-
> buf.h#L269
> >
> > And, as mentioned previously, Qemu would not break if a dmabuf
> provider
> > does not support mmap() because the preferred, fd based fast path
> (gl=3Don)
> > would still be available.
> Just clarification; QEMU will not break in that case only if this patch
> is applied, am I right?
Yes, that's right. It will not break after this patch is applied because we
would no longer rely on res->blob pointer (which is a basically a return va=
lue
of mmap) to identify or determine the usability/validity of blob resources.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki

