Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D9EC3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 01:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTtYx-0002pJ-DE; Tue, 16 Jul 2024 21:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTtYu-0002oe-SH
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 21:34:33 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTtYs-0006yb-IN
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 21:34:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721180071; x=1752716071;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xQr8Zm1UKu2RZUeSHko12TIvGST9P6J2q93xqoCYsyA=;
 b=S5oDU9Z6arRc91BHFseQB1hW2vgB4ULbs/XG9zVb6PQ4ZaWmSu9BPCaK
 oRCy9aDzm0xYmXJ/x5+Jiofq8YVME76Drwk2HWj6c3mSCjHwpWCYY3CVh
 nNw0qngDp8u5tMn9IIwKzE82FXIpSDdfScuzKV3w59W6lEfLd6XdsiKEu
 T3RPvu/gKq8sqgppb99zxq76NDNT8e3Wx1vLty79CRG5YwhNKgDTmVnzM
 S7VW6Zq+Nqa/kfeaKqf7YrSehxd3YnsOTCxd1FlRGKiBirVzr054L13v+
 pTqcI74jNi3QURkqmq4f59raxQYjsRTuBEdleCZP1AlVc59MPRaR3sswx w==;
X-CSE-ConnectionGUID: HKhGYR7tTn+815Xq+XWTqA==
X-CSE-MsgGUID: MzWz42FwT4aPDmpyhb4Kmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="30071367"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="30071367"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 18:34:28 -0700
X-CSE-ConnectionGUID: mgPbsjYQSOic5+f2TrIfrg==
X-CSE-MsgGUID: bUE9xX5WQzO/P6dMZKd4Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="50565648"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Jul 2024 18:34:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 18:34:27 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 18:34:27 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 18:34:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXpFPsEdJpQsFFAPk2S/WehcZ4aJPZgGOqZPgnLT75vWUFc1gYfjNaS/dV62j9X21YRL6NtZMJwpJHCH9mI1LmZNeR5nNDwC5akAVMgT2Os28nPFy+Q/kuOY4m2wdu/paKuioCGo5msYyapthz1B4jUIz4YzcUbwpKnSZNe4EDa9BTjXxyutW0FIoXfWKSEEW8eiWF8uAO6HjmB7FlJHrzJe6gTiHPSpIEyMcKdOAeJQK+ZErX542lHKkh7zbMJ/Kw9v3prIi5JpfP49YMuc4xO0RmVJSUz8SGtRwWx7l4/5J8bh0RYEloMw300nnayK4TZM2NpoH8DhRRYoklewUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7EcUSlTU106vGLXHSt+jUTe1tibKaseSyg/KWIt458=;
 b=o8olM8/1rb3z+pEOmPJJHhwK5pg3pfIl5r2bLHtH/3r26o3u1GUVrTd0HluMjai+UcCZEu/fpijBZxbYhMTH9+mONioCYfIOgsH0g0o9IKiko7JAWWSQT4SSHfcH/VydLiKB2ULd5vEagmXMF6qp/k45L5/jOD1m/0DYYFWKUkKlFDQ2PPd5Y+Qvf29v2to8xIf6rG8w5kP66zafYP0hnPo5z9N3xn7VBXTDjCUNnfh8W3ynFiAw1vlyNZqFCmWVTeezx60MVy7XHTtakZCNfLm0a995R5QEPYpgyMtbOFif1KXz+Az8WOPIXPrfQHZbtkT3/DiTEhSi51i/2BHXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8136.namprd11.prod.outlook.com (2603:10b6:8:159::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Wed, 17 Jul
 2024 01:34:25 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 01:34:24 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>, Alex
 Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
Subject: RE: [PATCH v4 02/12] vfio/iommufd: Don't initialize nor set a
 HOST_IOMMU_DEVICE with mdev
Thread-Topic: [PATCH v4 02/12] vfio/iommufd: Don't initialize nor set a
 HOST_IOMMU_DEVICE with mdev
Thread-Index: AQHa1FFJxHSBrgPOr0eWHaMJio4I1rH6KcJA
Date: Wed, 17 Jul 2024 01:34:24 +0000
Message-ID: <SJ0PR11MB67444D2AD56771E3B973401B92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-3-joao.m.martins@oracle.com>
In-Reply-To: <20240712114704.8708-3-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8136:EE_
x-ms-office365-filtering-correlation-id: 318b94f8-516f-4e0e-d47a-08dca600974b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?huos94rpGYbWOVw/0MxibC0Xa9MPPGJ2PsQN9yxB3h4P5jwGMaO54W7ICeZg?=
 =?us-ascii?Q?1m+5/K3S9MScjBLaXuHg2mRhdpScluMwHAeBmjfMYbDsKzoNL3hQsQNus7Kg?=
 =?us-ascii?Q?eu/Bwp2DVtMzh13ojwgzrUPCqjVgx/MLkwKW25TQ+SBf1fdELmbg9Ht+gLl9?=
 =?us-ascii?Q?82ZGnwxHdPXsUQlalB6LtAWLBYNYX7sDeH6sbt2O3TjCWZN6nx2Cp+aqnfEs?=
 =?us-ascii?Q?NSffUSB6qWIntv3vm5frikTS4wNEA6uVA2z4YBrS316bM1dr0UPp5qyCIlx3?=
 =?us-ascii?Q?1Stl1brKsOVAZU1YtFjo4zH7MS31v4fdcCSijyVZF6c0/nqb9mvv4nQJfDOp?=
 =?us-ascii?Q?uYLMV0t9yBXTf6ZZdciGrg+e4Mtc78DMAKjuMxqSBRbtEnCDUbt3k9WzorkF?=
 =?us-ascii?Q?gdAJIqMLVPOcc47C1f8LoWecLsZsT1k91cwNNCbHX1Jb7L3Ak8fzbM3S+NjR?=
 =?us-ascii?Q?X/bI8tiGYG/5zZ96C/rhXA1XAqkF+ExBL7Yu1wXXPSCU6WsxFUYHxuPJgy6K?=
 =?us-ascii?Q?X3TvG/hqeRdFsW1XYenkIERPWaWws7Tq+AvSvsD6l/NsulevkguPnGdN61Px?=
 =?us-ascii?Q?ErdQSBSibOrE68iTdbi87S1kDCBa26OEQkIzn7THaqbsC7mqHYi8Wmlbh01J?=
 =?us-ascii?Q?x+HTlsrth1Aauwt+BTfy4aOX67HNTjEWVX+aosgikBA/wFsDNIMg2y4NdWVo?=
 =?us-ascii?Q?eLlQ7om2rWTlmSsPsf4zFKdeJ7o6pW+8sio9bGXjuTQnQUUoO4zkl+mlOU4Q?=
 =?us-ascii?Q?Gw6DhqHswILOurCLY+uaTWbDrvPWKEOzUnaKXndHrknPLfbLq4YrcINznWJk?=
 =?us-ascii?Q?tBa1uuqCnofqd9/A7EDyWmhkut1Kop0YGsMWvK2jc8MHZ85JPIEXJLkAg9gl?=
 =?us-ascii?Q?Gj2MECaiRbPtKo1U+OHt4LFyWdrj0jdWm+vrZcYtPtdpC/obE0IpQIEAF+f5?=
 =?us-ascii?Q?Kydb1qPtzMCLSU+XvWj8CQpG8P1JTpiSYmQ2zAfrcUJPT+ysy1uYFQ0LVy7l?=
 =?us-ascii?Q?iA6YPBQbODUg2dZ7Fpht1pDxwMGGDacdIzm3lSGcDoTEQYJviM0/20jRjjK5?=
 =?us-ascii?Q?YrEgcjyMY+KcjjvM+Y3K/FcLFV+lHI6K9O+3Ryi0CpU54asa49HLsyyiqzjg?=
 =?us-ascii?Q?7ijKHM6BVMGaBhWIKYYbI5m42Fe7aLyAAcZ8JfMig6R1rn56uMAr72lh6EU+?=
 =?us-ascii?Q?lMjA9zWo/NfsD0LH1hn9D60crgP61rMMyb9RjI/GbGxv7BP0q3g3p/aOPIBQ?=
 =?us-ascii?Q?r7Zbn4gfXiU8KvrxsyYrJUwp+bDzSx/RiYcIRcHSH7cjagTwk9i3N1rgCzda?=
 =?us-ascii?Q?9j9HFawmleonRhzOGytVqG5Fd7wUNh5F9TdrCsHCO6wSUuJhejXZihUi8+rD?=
 =?us-ascii?Q?J7w0kUYoChOP580tNzWZcH7HXeW0TFLwM3/kIMqIIeP+yqZWkA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uyTpZsiA2T8H9E818yRx76U0tT+sZNzWKlm4fC3AfHjywR257G5R5u+EXUsk?=
 =?us-ascii?Q?9Ra2YfznDdTwKMF/lOmUvfMNzyKzjawWKvDns1tULZkBL5iZ1MQMxyHEw4ad?=
 =?us-ascii?Q?ZhNo/2jpiYuOZ+vWAGP9jsxx6LkkDIIHMf3Ku+/X7yZisjZhCJ28NKxNQlrd?=
 =?us-ascii?Q?B6J76KQiU6EXeeYAP/tcCypE0CxYjCnKFQ2YGeSWHWcFlwgVM3AU8/GrVqVB?=
 =?us-ascii?Q?BUYtecnXJiX+AOU/Y9t8s/LYe/cri1Q3ZDe5+QQgI/hzfal03gc8fA+IXqGj?=
 =?us-ascii?Q?B1f6UK8CGs8vcukPsAgZm4ZjnPHZLhQQ51m3oRRzSlsn8N6bhZtl3+FOh5ZM?=
 =?us-ascii?Q?LWq4Yk2u42YLxhBArCySDjcIi1HUfvk8PiZgqC8jegrufhghT76GEW8G9yze?=
 =?us-ascii?Q?bko/gLtJEclDt0+FCN2wwZN+Kizcm7y8Iz1o0m00mu9IgfoKypWhLneX2i1R?=
 =?us-ascii?Q?vNxwOPZ8pic3+tshavErBxU8UjyvywB6KFDYzjmUGSCA8c8w0M23Rla0JTY6?=
 =?us-ascii?Q?Db9GWyL2jujQD54660a0BOsq3+Bfe21M87ZSabVuh/KtnTXH2d7YXNO6KObb?=
 =?us-ascii?Q?gjc83xdf+jRL4k1OISe0ln/fw6G8/F7tf6W6eI1XF/WPfAHVv0/5kBxOdv1f?=
 =?us-ascii?Q?4dHnsWG/FngBNOb+Ik03blTAr3McvGTzR6bfxiyJHhbLzgGyoMWbqXGLYq6D?=
 =?us-ascii?Q?0Uj0GM86/2SQGf73lkMGJnm/8sPiPY1um9xiA1eGT8TB4tmlzCEbE/oMovD4?=
 =?us-ascii?Q?aZEBi7i0mcbs/AsrmrbYqoBJ4zJlwYQMz3cykca0H7vrP5V/XO16P0/aWRmf?=
 =?us-ascii?Q?ZYa+NSVw5sWKR++lJZse1sKnV/HcPqf5QTFOAty7PCdNVJNIz6vGVW9+LXqq?=
 =?us-ascii?Q?g8M/bGAV4/+j65iVP7RBZ3ZZOnf3uH0P4JhBLQaoy9M0wA6AH7Y4k0mn8OGM?=
 =?us-ascii?Q?sSY0h1fuQoSGyS9LAfBdHxY8U2lB2wHdRCfL/gKEdiw4e5/+Yf0N46Wrniwo?=
 =?us-ascii?Q?wElkG8ivTQLC52bn/K35mS8NrWOO4a5e1K6Qg0HDWzVB58NBkHwtFapVv3Ud?=
 =?us-ascii?Q?tCG6qmM34zjfqOJkZlY/icZO/Szi1d8MnW7xaHZDpCPspP2wW0ca3+GdJ0xL?=
 =?us-ascii?Q?8jBgryDOJGzMkGr9KsdvSzaD1W8Md7lUZKi/Tlx8xODG0LwuNevi767WucPf?=
 =?us-ascii?Q?fVCYUanqM+wb1LH9SNHLcSfZ9mTTzlj82r8j/D4rvWT+HiQ0ul3fQkCjyu+q?=
 =?us-ascii?Q?cky/GwnrUupuhj8fDiNYpn+daFs1UDIS5LQ4kbD4URl2I81lbaOA6nlb56SA?=
 =?us-ascii?Q?BFqP5ZIko1NqsWYE4fuOiNEEP77LR5h47b2Byh+wCDPR0XNZjSOe+9EVgfwE?=
 =?us-ascii?Q?rpoFFECJqLKYxO7axNOPHeMTkrAuuzw0CNOhCqIp5Un0YKtJu3jCV92Pfa2v?=
 =?us-ascii?Q?SMfrA9Hl3o0nVzLXWH+Nw+R8iH+3XQgbGbKTVgonb6fwp3J7GvkS//QDKDnQ?=
 =?us-ascii?Q?4fTMnR3VrETcwH+51fAP8WxmJ5psdmzemKrAN/TSJdviPbmUJYpW5iqEjFjB?=
 =?us-ascii?Q?2o6TQrdHXISwdsSFooYaVlxVYaDgwuWokNb4yp+4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 318b94f8-516f-4e0e-d47a-08dca600974b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 01:34:24.8080 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wlUlTxAeaIOOvELWtjjT9gyvi2Z4KcGfyosY2akT1GwrmfZgThL7CeXW7mgoX+F3gxUBEY1HTGqWRyK0fL9JbFdEfyedcGa6AZxmuosl/kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8136
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hello Joao,

>-----Original Message-----
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: [PATCH v4 02/12] vfio/iommufd: Don't initialize nor set a
>HOST_IOMMU_DEVICE with mdev
>
>mdevs aren't "physical" devices and when asking for backing IOMMU info, it
>fails the entire provisioning of the guest. Fix that by skipping
>HostIOMMUDevice initialization in the presence of mdevs, and skip setting
>an iommu device when it is known to be an mdev.
>
>Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
>Fixes: 930589520128 ("vfio/iommufd: Implement
>HostIOMMUDeviceClass::realize() handler")
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

Thanks for fixing.

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

 BRs.
Zhenzhong

>---
> hw/vfio/common.c |  4 ++++
> hw/vfio/pci.c    | 10 +++++++---
> 2 files changed, 11 insertions(+), 3 deletions(-)
>
>diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>index 7cdb969fd396..b0beed44116e 100644
>--- a/hw/vfio/common.c
>+++ b/hw/vfio/common.c
>@@ -1556,6 +1556,10 @@ bool vfio_attach_device(char *name,
>VFIODevice *vbasedev,
>         return false;
>     }
>
>+    if (vbasedev->mdev) {
>+        return true;
>+    }
>+
>     hiod =3D HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>     if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev,
>errp)) {
>         object_unref(hiod);
>diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>index 585f23a18406..3fc72e898a25 100644
>--- a/hw/vfio/pci.c
>+++ b/hw/vfio/pci.c
>@@ -3116,7 +3116,7 @@ static void vfio_realize(PCIDevice *pdev, Error
>**errp)
>
>     vfio_bars_register(vdev);
>
>-    if (!pci_device_set_iommu_device(pdev, vbasedev->hiod, errp)) {
>+    if (!is_mdev && !pci_device_set_iommu_device(pdev, vbasedev->hiod,
>errp)) {
>         error_prepend(errp, "Failed to set iommu_device: ");
>         goto out_teardown;
>     }
>@@ -3239,7 +3239,9 @@ out_deregister:
>         timer_free(vdev->intx.mmap_timer);
>     }
> out_unset_idev:
>-    pci_device_unset_iommu_device(pdev);
>+    if (!is_mdev) {
>+        pci_device_unset_iommu_device(pdev);
>+    }
> out_teardown:
>     vfio_teardown_msi(vdev);
>     vfio_bars_exit(vdev);
>@@ -3284,7 +3286,9 @@ static void vfio_exitfn(PCIDevice *pdev)
>     vfio_pci_disable_rp_atomics(vdev);
>     vfio_bars_exit(vdev);
>     vfio_migration_exit(vbasedev);
>-    pci_device_unset_iommu_device(pdev);
>+    if (!vbasedev->mdev) {
>+        pci_device_unset_iommu_device(pdev);
>+    }
> }
>
> static void vfio_pci_reset(DeviceState *dev)
>--
>2.17.2


