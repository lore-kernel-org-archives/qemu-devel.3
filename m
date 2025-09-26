Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C0FCAC5B5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 02:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ycv-0003RE-B7; Thu, 25 Sep 2025 22:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1yct-0003R2-UQ
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:56:03 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1ycj-0001oA-DH
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758855353; x=1790391353;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/ZOFuuzbjYskYLm5kNYqiSOnzQSOvPSjRKgoxnu4QZE=;
 b=R5zgJfirM95r1rmhYP8uAPXVL914XiZtP8ErpaIkPZUxBC47+0RrRJ4w
 oqjAlvMWvr/UmF4fL9M4yDCs7RNNo9NgSfeux0LtNBenXWlQkRwgbnj56
 iyoAhB8T0MRXO5ycLwjvux9YSSfUUZjx4nmwaKCtvWRYUq1ZgeU15mDyp
 +uGsF6QLK0RbCr5VBnI2OEKMdq7zdiQQ1tdVXFxXg1A+8ZPnhtFcbLmx/
 X/vCVXXogFYezlmH0JcrPb1uDWTi0niQcvt1SinR0bBkiFu7aHJeceage
 qG27H3vOoRxxPI9wMMTFKS9Bo/gECn6cQaUc7v6AjsRaz6LTv9i7VmiT5 g==;
X-CSE-ConnectionGUID: nMOGIOZrSAWndiF0Hyr0vQ==
X-CSE-MsgGUID: nj8c4Z0rSfSLHQJVIzgsGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64997677"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="64997677"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:55:15 -0700
X-CSE-ConnectionGUID: gN3D16TARAit27UsKbtptw==
X-CSE-MsgGUID: 4EHtPzGkRBSGNmMAsZcEVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="177890770"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:55:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 19:55:06 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 25 Sep 2025 19:55:06 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.1) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 25 Sep 2025 19:55:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSZj8gpLGXCSilZIQEEQsRNVVR4y5Vj69mkOm0UWNU8kgf3GgGUhmHLc7CWSCDeSKXKJ4fd9sIbthrBJ/Wd8lfj0mJeE9wlEPD3olPYUl3IBnk8sy3RakSXh8THn8B5FIIbzD++uH0zPph1KDl1VvVzJa84Xv4wJ/MClOq1lwtDqWqIOxpW9H9l/zNSDuI2li420jg40j+n1ogY/YWFQdz0FN60IuMuBWlS3MWj+bkv2aV/Bnc6UPOF9qjDFcelKrnc892Oiu3gRkqVzZ/5ihjtlaAdmwRW7gG/qLFIkD5k6VBNazIZyo4ltAcgC4HszujDMh28cJyjG8HWNylxqXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BR0RkOjXs/NN5vwJvS1OFewpGRKAW8PGpljrF4CuqcI=;
 b=hUiA3Hr21IEtxbwUJZJr+1n5mMQu1Ys07DiLQhfq8NBKxEu1IpO1wyIwBobN5VS8q9Gq7Ucl304NqjbZzSYhau8Uf52N7jALlVR0wSJUsWEAxbTzqyoPfZxnTsOgwoAsl9b8zGL1bFXoK2ugZoLQa5KE6rTwk7WBtZj4kPcfdTQB+Yh6k8KoCNBc/I4KVdBdAeKSU3bvVJt+Gz77GzmgKKEIseaU8tHhcDfROwPez94u0CV3oS0C45c0m999Hko4fLWf4Q0yghEdlYgh3+kOf9YNFZshqFoWE254eUn3NMy2x4RF4x2IZZYwzGByVw1npTGlm9Ww8SPFeg1yzRaXMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB7524.namprd11.prod.outlook.com (2603:10b6:510:281::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Fri, 26 Sep
 2025 02:54:56 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Fri, 26 Sep 2025
 02:54:55 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 05/22] hw/pci: Introduce pci_device_get_viommu_flags()
Thread-Topic: [PATCH v6 05/22] hw/pci: Introduce pci_device_get_viommu_flags()
Thread-Index: AQHcKHp7r9gkkae/lESTayfSQ/kwt7ShJAYAgACDWcCAAGA6gIACx6rA
Date: Fri, 26 Sep 2025 02:54:55 +0000
Message-ID: <IA3PR11MB9136110BBC15C20546401288921EA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-6-zhenzhong.duan@intel.com>
 <aNLrOIbBxZy00cS4@Asurada-Nvidia>
 <IA3PR11MB9136AE59AECA079CB61C4165921CA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aNOqH3u3vNFRukew@Asurada-Nvidia>
In-Reply-To: <aNOqH3u3vNFRukew@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB7524:EE_
x-ms-office365-filtering-correlation-id: ef8b2ad1-b051-475c-ccdb-08ddfca812ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Gg7iUk1hhqCMYlgGIhds6ZrDJGRrtx3bucqR9u/z7WqxVYMTwvKW8MnvPdp1?=
 =?us-ascii?Q?fWMipjoydKvB9i8iUp+cNTDvkMvKQfh+7r/oShdcKWZ6rwQ7F+EUM3VtU+vw?=
 =?us-ascii?Q?4tBhrT/RBMZtnrgIa9gD5uswx62J10RrbJunQ1vVVbztrahgfIy4r/XqY/TO?=
 =?us-ascii?Q?nEXEu/c3NV8xE5wPPF6MTECA3LleYtjsdUACL9bxeKcVweQFWV4JRcBMZpeK?=
 =?us-ascii?Q?dlLFQffOkKgqNhcaILgvI+lJAEmmGOe4zuaNmkQsSalh3bLIzgfuy4VO3Mth?=
 =?us-ascii?Q?UYv6ISv2hg+uI8Hks0D6idWo995SdJM9OseJHvAaNoGWKuK4TfhmSvpu2Y2V?=
 =?us-ascii?Q?3nRRRGbCzUbXylw8JS3omrhuKlKTNMyfryfhLs+anq5C/AKVi8wYHTGNyYxt?=
 =?us-ascii?Q?fADXGzp1rBAnQEknxuM+p3KDdZJJcOzJuEinAKG9rgJtitCl0PdsYa8PnRVW?=
 =?us-ascii?Q?koR+35EXXD4UiA46rbv0XC6Zo8of3hceGv7gO4YHXGMA4hasa3XR5u4gFaR0?=
 =?us-ascii?Q?5lZYStCUbxmpacyvbhOCxDSnYW1miTtnwkOG8pN+ElJM9ZtUIiEoYV2SkVq6?=
 =?us-ascii?Q?lbbxiYioDpRxeRB4QwTkDUpPoSWq8kAP/Dr2wDHnAHKUONtJNZvJOlJxYFUv?=
 =?us-ascii?Q?Ol2FOfWCbW6CrHuBlYZ1zq367ydRoZXEldYCrITOjfa+ggqq/Cvnoi8jUWLi?=
 =?us-ascii?Q?wLyEzRMWfJ4RFJzPhWpvzcYz5y8Bn4W2IKXX0tQpBjiDPbE0AfKOEg4DdaXl?=
 =?us-ascii?Q?0YvTZngtbpLk7ZuYK2qKaxmjmMoXOycwHGEtYe3JaFIibeyNKQFl1W89mU0J?=
 =?us-ascii?Q?gbL5RtDpuA58n/qp+6Y4rxb0zXSj/gQXky0hNtRBKcm3n6WVHQ6iv/0kpHtX?=
 =?us-ascii?Q?El9MkbI6Ng4uRW98rzkiqry95zMWLPvxyGNtgNjAR+YYe7dct5kTQp6gPv+G?=
 =?us-ascii?Q?04y91Z6+KBIwS216Jx8D0B1t68n99jOfyZtZGEEACv9RrNixC9DNprjIbqdU?=
 =?us-ascii?Q?gJk0/PlAoUoyypzHYEkgzrKIJa9aWG3dHeaEyRbnayyIZZkgjgaPbSl/iCrL?=
 =?us-ascii?Q?72EdVaVBAbd5ALv+T/s5boKZyh3fIWYGuso0uemC0W3QPaHecOdlwofpWc0i?=
 =?us-ascii?Q?6T3weEycL0bAEZiYZeC/FJjvYWDxI0BEowouh4l1oJPV5FwbBqTOC7kKW2U5?=
 =?us-ascii?Q?gj9qtHT5hXcOQ9XAbSmrgGmeX+LakxXAz7sWMjOnB+WeP85VAtZsN6AF7n8p?=
 =?us-ascii?Q?1dvLo3zpIm36jbjbiZE3Dqj5K6yil5B9bkGq49tsqx0hxZujBGUSmIAGNnIV?=
 =?us-ascii?Q?ZzEVFh7cIDnySc6H2OqmRX0gDItpDWqg+onBCj2tpU0QuRX9mLfOdLprFs/z?=
 =?us-ascii?Q?WZ/SWX8XZWTrpC3Cgb0tME1ZnIBddz0GmWZhaQFV7cZX9VuPvf0bDwpISLRz?=
 =?us-ascii?Q?2ikjOdVXAg3XXdHLlzpo9ztPIja93TJ/6iUDzxMBqwlD+hOIkXPq2g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n2nPCDGabxGbWtSf6puzLTefHs/n/4NqWbCCmR4vdRzKqDan0njt3NqlgQWW?=
 =?us-ascii?Q?/2Cgu5zur99lUavjLrhM49t2WtPYLXZ5TcTlK1p7SI5mDfNPFuN3aPaAIasW?=
 =?us-ascii?Q?v0BG2n0xV82g048SFg5e1jL6YphO+Quxr3mA8Wu9BFzilcD6gkvGFY/GsvU9?=
 =?us-ascii?Q?fXVLtuxnfLIh2yzJsLMMqUcRSr+Cdv6KkwpUw7IDng6C+LSV6u4LEvCWi10c?=
 =?us-ascii?Q?1/ACs1j2Dvboi/FVLM9PxIUuxJnwRF5nWnV/49Li6S6RLWCMOFkCpQqlbllk?=
 =?us-ascii?Q?0NNpIpy/S71JGGQ8KDAAJiAy2t3x1kuhKd0rMVQ8P/CcWg1CE9p7TM7NjmT7?=
 =?us-ascii?Q?UYB8E3KYZaCuFLPZu6QnQMrmXThGJIl+KO5dysj9TJDPYzUQAydXGpZrq+Fg?=
 =?us-ascii?Q?II67mwwON/CQfUEzXnq8UjDQn37vBdoOBLT1EW029AadrvooyW0PCm0PbYat?=
 =?us-ascii?Q?F7Zqdpr+DtOFv/+qo716hH3RRetfwE9zeQhhRWnmQHXnBCvDCG3Y8LRE0obf?=
 =?us-ascii?Q?bI1OIbMoffG0+tHgpEjEWJCLlSdAG42ODHGgd5NOcD+z+Yr20cww+D8Qype+?=
 =?us-ascii?Q?CwM0ZoCoIQ3lottQrz3cpVbQMR53q2Jv+Y9fXhLcAQPD08FzqkSmBDJamz2w?=
 =?us-ascii?Q?VMOgXHZ/jpfDyaEtvQrGokw3YbkTua6B+AeJKYRUrUUi+d3wqCtCaOckg+4T?=
 =?us-ascii?Q?Fj+xtuSKe70yvt4iGT/ysLb7ANw1pu0n0HHdBzJjN/LPL8brD9BgFikSL1yn?=
 =?us-ascii?Q?maFgzmu1sawHl+iZaA9I7hoLzfieZIO/wyevYOuUBQ52FpUVULACNMSIpw92?=
 =?us-ascii?Q?EY9+ZTACYVbkgpUGsyKb2I9f3zuV8dajGHraei9FnzVR1K7H07qMrPhld476?=
 =?us-ascii?Q?kcrxzPc5uQCEzpAgT3b9BSWp811LemICiIz42fXVxq6TwFq48Uxg+zvhRgIx?=
 =?us-ascii?Q?OWUJju9V9yTNoGI0ftBqfM2JEqiiNowGcIEejk66H4IsLksq8JPbAaHOv/SY?=
 =?us-ascii?Q?9MDBmanIHAqULmaxjU3RPf3v1QP2kLSTsFL8kTtjyEm8segdZ0XukyBHapLq?=
 =?us-ascii?Q?GtAhe8Pon12LBzamQsTWkGTwqen91t3ZxfEa4uymCTdanvz4sayAhdkkwWO1?=
 =?us-ascii?Q?tNGwE3v1H11O2kxBClfS08iSw02/B9iX8xfcTdqUiWDUa1okQZ5HUzTzvPSN?=
 =?us-ascii?Q?uMcOzOMVD9OBUJFgg0w1iJdQieP/VDd5HVdj66nqChy88MBx9O7d/odqCsPS?=
 =?us-ascii?Q?aoBkh4DK7jpcA4vO5RGwyRKqOHObTcMVlVTYn6D29ftALST+OrsqCorOmoB3?=
 =?us-ascii?Q?X4WeiAAQvNYhbZ5g29zdIVu9Gn6KYASg+FDNORMEq4v/+4mXt+YpLbdfD4oB?=
 =?us-ascii?Q?ezuTNPwkp5WTOUF+KTXc5yJUdqJz4p2W5f/4NpK25mzs0/U/emmfd7tbTQd8?=
 =?us-ascii?Q?Tg3NaiSIQsw/xlH2pRXhLPVfWYLSUw+wz8KTNDITS+eC8u+5oOIMPXr+I7yK?=
 =?us-ascii?Q?nCVi7Uw9EGa8LEORV233NywCQPQpqRuceW/MIzs2npjfAf12TvhQ0cP8GT38?=
 =?us-ascii?Q?bxS3dcXlppz9il7bo/tFw+Z1VChvibi+yD9n6HIX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8b2ad1-b051-475c-ccdb-08ddfca812ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2025 02:54:55.4063 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdwpuegOwQ6DDJ6b5nTDw3wPwiQGHmbylOyo71AUNvUG6nTe9TXWYOJzc1QVLM9PM3RcwXusI7sjH+zIE/KBm5Jyrau9dqXZB30U1BtgEl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7524
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
>Subject: Re: [PATCH v6 05/22] hw/pci: Introduce
>pci_device_get_viommu_flags()
>
>On Wed, Sep 24, 2025 at 07:05:42AM +0000, Duan, Zhenzhong wrote:
>> >From: Nicolin Chen <nicolinc@nvidia.com>
>> >Subject: Re: [PATCH v6 05/22] hw/pci: Introduce
>> >> get_viommu_flags() is designed to return 64bit bitmap of purely
>vIOMMU
>> >> flags which are only determined by user's configuration, no host
>> >> capabilities involved. Reasons are:
>> >>
>> >> 1. host may has heterogeneous IOMMUs, each with different capabilitie=
s
>> >> 2. this is migration friendly, return value is consistent between sou=
rce
>> >>    and target.
>> >> 3. host IOMMU capabilities are passed to vIOMMU through
>> >set_iommu_device()
>> >>    interface which have to be after attach_device(), when
>> >get_viommu_flags()
>> >>    is called in attach_device(), there is no way for vIOMMU to get ho=
st
>> >>    IOMMU capabilities yet, so only pure vIOMMU flags can be
>returned.
>> >
>> >"no way" sounds too strong..
>> >
>> >There is an iommufd_backend_get_device_info() call there. So, we
>> >could have passed the host IOMMU capabilities to a vIOMMU. Just,
>> >we chose not to (assuming for migration reason?).
>>
>> What about 'it's hard for vIOMMU to get host IOMMU...'?
>
>vfio-iommufd core code gets all the host IOMMU caps via the vfio
>device but chooses to not forward to vIOMMU. So, it's neither "no
>way" nor "hard" :)

Yes, that needs to introduce another callback to forward the caps early,
unnecessarily complex.

>
>To be honest, I don't feel this very related to be the reason 3
>to justify for the new op/API. 1 and 2 are quite okay?
>
>Having said that, it's probably good to add as a side note:
>
>"
>Note that this op will be invoked at the attach_device() stage, at which
>point host IOMMU capabilities are not yet forwarded to the vIOMMU through
>the set_iommu_device() callback that will be after the attach_device().
>
>See the below sequence:
>"

OK, will drop 3 and add the side note.

Thanks
Zhenzhong

