Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BA2CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 09:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDg4z-0000pS-Km; Tue, 28 Oct 2025 05:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vDg4t-0000oc-WD
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 05:33:22 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vDg4n-00040b-ID
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 05:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761643994; x=1793179994;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vZRrM68ePwyEMa+SyMmGpDXT69RivZ4smOiYwiR9K/0=;
 b=Mf4f8GA8WwsHtTjV7wh/Hnsy/L6dzS6Ch1TQAV/y4D7/7sUP+PycPjXe
 I+rvgY/QtAmDuI35vm3UhmpT/Z6vDip6Wufi2YxnbTykfhrsdu20o1zfT
 hn5L04YsTSFELqlUvx2amvT23QIEQg/i9jyzW3eO6IOdhyehFZIowFc8p
 WvhsOj6cezz+4SoM7HbRc1i56R+o4v69YDxrQUgUaBV4fyFfnrn0GjRzA
 nFEA6GKT9eqzwl9ya8crPQx1voMrC0k2gXesp46HwaDR2/BYFEV5V0P5S
 qAua6i2yFLQ76JS6GzvbLk66e3diSyTvKLB5313ucZjG0TjslMyTgDHEG A==;
X-CSE-ConnectionGUID: ESPLp5cdSvq1a6n3c7CdfQ==
X-CSE-MsgGUID: GjY9rYWcQnmvC5wUZsGkEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67575712"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="67575712"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 02:33:07 -0700
X-CSE-ConnectionGUID: PK5RLUEtTY2fRGj4ix/hHg==
X-CSE-MsgGUID: fhe5MSY7Q4yLBTrdgiBVpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; d="scan'208";a="208896146"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2025 02:33:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 02:33:05 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 28 Oct 2025 02:33:05 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.60)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 28 Oct 2025 02:33:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wh62/tdHIF3SoVBNjz6yNORCjRUW5m0fXeeSa7Qq8DjN+Zx8jRnwa6bjVclHRPdfdVschtQikDHuSkLfQGKL/9lhqLfsU0/6UVIuvHpwKcjgzZ2bLns3X6UmPyG/VQevu5x0H45L/V4F/2VrydSPHKjsAV/s2H1n55UQQcuvsf+7cH1DOxu6yxLmkW670T5hyyhtCO5SSmdPLkCCUR5M+e0DjCCVh8uq7J/Q8nXqCsdCt58FiXYDQwGZUSdRqi9fdr8q4anjY2gFV3LEy5eLTptWavJJyzd1qN5FImDqvHClIAey+k5wJ+z9hveHvVYoQjZ0+FDQNX+eu2z7O4uQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbLLnWvQzsmMUFTUlX8B+KkR4cYJ2mogkzkZg9/TGPc=;
 b=xn6/WRElWeURaKkwHMuE+O+13vJkqmD8nUp9csrRhbsNfNAeuMj9NoADOY0Qrib0/AOWyNjsa2p5dXLE0gZIVG5tuLvv8cAgQRDrHH4JNNFrf4M/HPF92yIsXinRCe9oLjUYYh5oeUTZA+gydHlBXgTTEDpVb3PEmiXvpie1Wl8OgsXFNMl0USTC4zrFDVUEgsrjVGrAayFBVstnqerMl/ML6lC0qrIzcwQ9UF3V4df2zm4QiifcN6gVYDLRaDVSsMAD73aHVQ/8XvJGfN7JUj7EMLeQ2yomZLCv4i8UqpBtuUKakYH3WHoJwe6+cBQvX298Dnhu3/bab1+B2ZYimg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB8545.namprd11.prod.outlook.com (2603:10b6:610:1bc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 09:32:58 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 09:32:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Avihai Horon <avihaih@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Hao, Xudong" <xudong.hao@intel.com>, "Cabiddu,
 Giovanni" <giovanni.cabiddu@intel.com>, Rohith S R <rohith.s.r@intel.com>,
 "Gross, Mark" <mark.gross@intel.com>, "Van De Ven, Arjan"
 <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH v3 7/8] vfio/migration: Add migration blocker if VM memory
 is too large to cause unmap_bitmap failure
Thread-Topic: [PATCH v3 7/8] vfio/migration: Add migration blocker if VM
 memory is too large to cause unmap_bitmap failure
Thread-Index: AQHcRItd1NuuAkS0QkmUjZpJpRcNK7TV4BKAgAFErXA=
Date: Tue, 28 Oct 2025 09:32:58 +0000
Message-ID: <IA3PR11MB91368D67E7C5D853161B7D0292FDA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024020922.13053-1-zhenzhong.duan@intel.com>
 <20251024020922.13053-8-zhenzhong.duan@intel.com>
 <df474b7c-b210-43ba-9c0f-97526aaf5f93@nvidia.com>
In-Reply-To: <df474b7c-b210-43ba-9c0f-97526aaf5f93@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB8545:EE_
x-ms-office365-filtering-correlation-id: 44aa6614-55bb-4c81-ffac-08de1604fb0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ivjYgwr84pZCoPZjvW66de1W89ZIORKhBLsxaxohkxOsWkJRv1CFMe/FIQ?=
 =?iso-8859-1?Q?6TaC+rU6I2IZEm3Ja+9hgzcdFYWiIWzNc0UUbbhtSnplUGZ28TIXV5wbno?=
 =?iso-8859-1?Q?crF9VwA1QMdV3HKiSOfuONcSN06HLrXGX8oPbYYoMyLH7ob5OXZnh+W2sG?=
 =?iso-8859-1?Q?uLej8Vfz5ybcWROWZFWVp4L5/5BRzINE+L30jTqvLFAp7qYbWmTWaPJh+l?=
 =?iso-8859-1?Q?5Vv+KKsDU/vOj8D61a6Z4P8CbjNTXGqWZ+K9hnFfyFoU1tj+ahx+RuV7M7?=
 =?iso-8859-1?Q?jq5K/fwgcG7Okax7gLZOslVDtLlPJIfeJ9R3/zuc69c8hKC6Tcg6OW+xsC?=
 =?iso-8859-1?Q?g+U5AQ6n1d3s4oAiFFsKHzPA8/Mx6sogPWo0j0mSV4NAg5gy1Fvc+webNo?=
 =?iso-8859-1?Q?29ahaiZmHjO8948PGL5wgtjptVW+bqkUmlX2iFcFIUc0+7zY8qnTMiszJA?=
 =?iso-8859-1?Q?rYAy0xflq9hHfxmQ24ZGkZ6GIS6yjz5zPLm5tkgyBHhvvbSZx8nlmaXn4e?=
 =?iso-8859-1?Q?abcfHCpZXHKXS5D5KLe6+sy+7JI+bjNFzGbNwYYPgqCcKSbslr62B5V0J0?=
 =?iso-8859-1?Q?8XXVEpQiAVT13zNDxpGPcVE6C3EU8mlV4cGWzG6zPvaHLaQBAN0L8KI/G9?=
 =?iso-8859-1?Q?AuGjDOWK0vZbCzi890vlFOFd/VYt9VvF4mwSQ1iSulN31eMGiYGTAx9ont?=
 =?iso-8859-1?Q?0xLmI/Jiu4JiD5F35gzuFLcuxAxoDRqy46m9/G3h+SzrOoYFPfa9BKuBnb?=
 =?iso-8859-1?Q?tOXtX3sRd8Ws/EP3GNwpMzCBBNnlM4vWP0t0HXKawshuwFM4eY2oOP/kjG?=
 =?iso-8859-1?Q?OQ7NrX1QfzO5f4S1pPDI4uVjFKd7LAdDlmNXM3pC0RogTfNEL6xtEvjfgn?=
 =?iso-8859-1?Q?aWSndicEt7zPN58sxCcc29jF9Ns/Az/ydrzVfTcRn46P6lqMoQrBnToraG?=
 =?iso-8859-1?Q?+m75UJ/FG3ibZluyW1xhHs7XlcupIuGlBjBaTImBQBfwMXv8Oy8p8zaP04?=
 =?iso-8859-1?Q?9cyfKn8BKc7sMPG6DQlmZgiSHE2cteuLfH9mHjkncyz4oyNtuJv2MkdBb4?=
 =?iso-8859-1?Q?fhf/Immq8Qr2vypOT2JM7nKKRKSdbbW6q3RNe/STEvybab6JgMJUDfTzB6?=
 =?iso-8859-1?Q?exhkXFkr9Umpqz+vAXA7LExOZj5KVFIwwQams3z8myMk+6czVWr3nw3Cyp?=
 =?iso-8859-1?Q?RBQNTFKR9JK9rgtJU25bvxcE5aevV8P/efNyTFRIeprQ3+DvM2iq6wxgyw?=
 =?iso-8859-1?Q?F5jKxKxBLnoSIsfTjMpueC3Oi98HEYTEjGPuLp8y1b9QtjxJoGbtgEAgjU?=
 =?iso-8859-1?Q?0aXt6aL/tkm61jm2oJhRz+SvIWHXRLgnvCI43BLSwYGRZxd8UyrzXcFn5h?=
 =?iso-8859-1?Q?rFUfa9zwQNfOBh7k5b2xVsqpKNs8VcOkPDfD+LM8Bht3x5nDpSLBLaotf6?=
 =?iso-8859-1?Q?BNdUq8moDL/iLkIkAe4tbq5KkKA/1HVtCfngYttKztNzdoxVfJju5Bxqya?=
 =?iso-8859-1?Q?iDvx6x5KiF8QFDWGMC9sN1DXmHpy9Rhk3LhRU3DEjztrwTVlSiQTq9EF6c?=
 =?iso-8859-1?Q?aftwJ6hN8XymUdVyBfuJ5fSFyUwS?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AtitghQBNBZk+WeapK2Kc9N6+tRQFDWnCKtMu4zyrOTOrOa2W4BTmHt2gJ?=
 =?iso-8859-1?Q?fFSahIhXC7FKHao0yhX3XGpvim8xdHuq8cblWYd6J2oVezAfUzJeHiMQSR?=
 =?iso-8859-1?Q?b3AfheZdnrWSw8Jm2gTEmalcZVwzQoZyjGZgmWFteGtPGD8VvcF6unfn/I?=
 =?iso-8859-1?Q?Y/g7mdh2NVSatKnrp9kxKs/12WomjtNwS6VEe94McWg2iTHRE35sgE/W8N?=
 =?iso-8859-1?Q?2rEMSRW60gK5AzoOBTXfvQc6YaP446sTQ6JOtnrHIwlrFL/Co9cOGDFiBj?=
 =?iso-8859-1?Q?I39OI8vN7APuGsgQ9SpwQPN+KI2PQFFqR0g8njHxCYnzddc6fBYIJA5x1f?=
 =?iso-8859-1?Q?WYeO/bWtOKPDIM+9XFTydYs7ND/RL2c96U3VPp818m9cpZzJkfVwLgnWFG?=
 =?iso-8859-1?Q?WWcBKZTM9yWCRTQU7k9z2xgSmSZuYFxqJyQv9Z7LmIlqLA9a1T0VOyxnSO?=
 =?iso-8859-1?Q?0sdaHu6mHRtM3fy6UCkkQ8o6QeGIy4YK57ChWyOS3Xwud3jNCuhgDDEXg/?=
 =?iso-8859-1?Q?CCEZsh8WvQLgTHWOjRMmMVz26UQR7vUenGfvKnCvkSSUm5q1kHBDLw+r4P?=
 =?iso-8859-1?Q?9lK4GrDFk8VaYkEvKY04fjHHFT1YoZuLUZY0ImFBLnPsS+qU4g/bO2apR/?=
 =?iso-8859-1?Q?SwfAafxEczUGJnt9PA6RU73USMwiafSEx9GDVf3WxAlDP8Wk7yx/xp/XQx?=
 =?iso-8859-1?Q?PqE1jUkZVFr9EQ/RdQQxrdMx7kVdnuyVFAVdwjlkEzzfY5ikZ4X/gZfcjb?=
 =?iso-8859-1?Q?TCElRj9Wj5w6434yxKbNYckkh5xu4a1NBW8YoxnocvcBqcYIyoWwIHOQD4?=
 =?iso-8859-1?Q?GHN/rhEfTNmRLsPxr7bI9WMcWzsvXZ+Dv3/h31DYHTLQXI6EIOIvVXtITx?=
 =?iso-8859-1?Q?rZh84kS7GaYar/bOdQ2e2rP+aNhMFwpsKb/gG1FvLgkWy+d1K8QZolWpVz?=
 =?iso-8859-1?Q?u4uPKpHh2SPGmG/pEldNfVTeZch0hUocIo6/n6B7VPfSpGBiGyyxDJcXjF?=
 =?iso-8859-1?Q?4e7LueY/RAc/vWabT02in/MNu0gShtoD4Njgq4wxLDYwyL7A+VxBfHTwOM?=
 =?iso-8859-1?Q?5uB3TD3LnTNVnG5+reWB/0HsSWTWWxP+qgfR2ET3KPQKu+dZzmyNBORoTs?=
 =?iso-8859-1?Q?RLy9rVRpxQEwkmDqbdGdrPjY93IGVZEbR6oRv/k/vdTalaE1tGdSpZGipI?=
 =?iso-8859-1?Q?pp2B6vRWC4d72T7LycHqQ0+gFcER4b3y01Zb5mCGrNewHJrGpdCDkx66LJ?=
 =?iso-8859-1?Q?JgaKdGNIafGi1fh7ve7cC4vDcouhTcgcw0aK/a8JHgxh04to+1hE6rJS3s?=
 =?iso-8859-1?Q?OCSrY99WspdWmqCwPQiun3Gw7XhjnGn2FQTwJ2GmPa6oW4fdXygDPj+VDP?=
 =?iso-8859-1?Q?pK51N/XJngpHgS7Nua+BLqvnpcD4x7fpob+x/ZC38wnTUm0vi5+YJjGwyd?=
 =?iso-8859-1?Q?wSRYEzdvZZwjE/pfAKd3GszD6mMp+2vg97JRNg3P287ni+6M0ROg7zGXNy?=
 =?iso-8859-1?Q?5clrlb9UxshocD/ccVJ3l2R7CEuzdw4R+ATev693kHFJ8cJCGmW9dibVlI?=
 =?iso-8859-1?Q?Yaqq9BuPsu31HdnlcP2UxJUjDu8TT5696GMuI4EviwR6wmp1lLGiIIeP2z?=
 =?iso-8859-1?Q?Nylwmtu7ppvquxVNu/rdMUwHlQPyc2mQRE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44aa6614-55bb-4c81-ffac-08de1604fb0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 09:32:58.0530 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VeT1nP3dG76AmBTWJN31OjsFCIWph2oW/26HM6WJZnwjdGH0nNM65LNIFRscHQQUImQMG0yL49vmLcXfFbwTsNfLuXR9BWvYraEdhFMe2yQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8545
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
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

Hi

>-----Original Message-----
>From: Avihai Horon <avihaih@nvidia.com>
>Subject: Re: [PATCH v3 7/8] vfio/migration: Add migration blocker if VM
>memory is too large to cause unmap_bitmap failure
>
>Hi,
>
>On 24/10/2025 5:09, Zhenzhong Duan wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> With default config, kernel VFIO IOMMU type1 driver limits dirty bitmap =
to
>> 256MB for unmap_bitmap ioctl so the maximum guest memory region is no
>more
>> than 8TB size for the ioctl to succeed.
>>
>> Be conservative here to limit total guest memory to max value supported
>> by unmap_bitmap ioctl or else add a migration blocker. IOMMUFD backend
>> doesn't have such limit, one can use IOMMUFD backed device if there is a
>> need to migration such large VM.
>>
>> Suggested-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/vfio/iommufd.c   |  5 +++++
>>   hw/vfio/migration.c | 33 +++++++++++++++++++++++++++++++++
>>   2 files changed, 38 insertions(+)
>>
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index ba5c6b6586..8de765c769 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -633,6 +633,11 @@ skip_ioas_alloc:
>>       QLIST_INIT(&container->hwpt_list);
>>
>>       bcontainer =3D VFIO_IOMMU(container);
>> +
>> +    /* There is no limitation on dirty bitmap size in IOMMUFD */
>> +    bcontainer->max_dirty_bitmap_size =3D UINT64_MAX;
>> +    bcontainer->dirty_pgsizes =3D qemu_real_host_page_size();
>> +
>>       vfio_address_space_insert(space, bcontainer);
>>
>>       if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 4c06e3db93..44bab024b7 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -16,6 +16,7 @@
>>   #include <sys/ioctl.h>
>>
>>   #include "system/runstate.h"
>> +#include "hw/boards.h"
>>   #include "hw/vfio/vfio-device.h"
>>   #include "hw/vfio/vfio-migration.h"
>>   #include "migration/misc.h"
>> @@ -1152,6 +1153,31 @@ static bool vfio_viommu_preset(VFIODevice
>*vbasedev)
>>       return vbasedev->bcontainer->space->as !=3D
>&address_space_memory;
>>   }
>>
>> +static bool vfio_dirty_tracking_exceed_limit(VFIODevice *vbasedev)
>> +{
>> +    VFIOContainer *bcontainer =3D vbasedev->bcontainer;
>> +    uint64_t max_size, page_size;
>> +
>
>IIUC, this check is not relevant when using VFIO device dirty tracking,
>so maybe bail early if VFIO device dirty tracking is used?
>E.g.:
>
>if (vbasedev->dirty_pages_supported
>&&=A0vbasedev->device_dirty_page_tracking !=3D ON_OFF_AUTO_OFF) {
> =A0 =A0 return false;
>}
>
>And replace this with vfio_device_dirty_pages_disabled() in patch #8?

OK, will do.
Previously, I thought 8TB is a size of super large that device dirty tracki=
ng will never support due to hardware limit.

Thanks
Zhenzhong

