Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E529C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 08:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnwD6-0003M7-4l; Fri, 28 Feb 2025 03:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnwD3-0003HQ-8l
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:59:05 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnwD1-0005t1-HX
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740733144; x=1772269144;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=UcDVa/RLk/V6HXYf7u6zII0qU560QPDV/9Oo6+ZoTug=;
 b=clmI2pFZxLoG/jfksJPvlDPe6DukGLf++qteAB2xj0EOZ1ujbrhinJ9n
 ED8J9CfFbFTUYP0efc4MX39QzaUhvC5iZh/TdMcod+2n89KA1FbUaoNbX
 i/Q/ksywP9JaVdTXAOH0C3xpmMvJbGLq1Jz6YwoynvkuaGTIFeiNYXKs+
 XgEJ6BTypoiCtWi8TTLk5hQ5pMznS7dicBsavQ+P72hk8tn06VBRteGrt
 7lNe7MlNCX+5sz7db+bGoONEmTfBX/SieaQ5LRf9/+B0gAqB3Ial4t6XC
 YkpEM2QfTmLSYW503BEgZ1O6SS5PKXF9uv5m4q099EPlVQMLuZ2qWGxcJ A==;
X-CSE-ConnectionGUID: Nxr8rxM7Qw+t+ANxGlg5bA==
X-CSE-MsgGUID: 0zgrT8aRTnaFYyr/Cjv8rg==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45434831"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="45434831"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:59:02 -0800
X-CSE-ConnectionGUID: a0/M4HhCTgSisCSBpzls0Q==
X-CSE-MsgGUID: 6wFchyYiSKGViMxZF/OlPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="117464524"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:59:00 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Fri, 28 Feb 2025 00:58:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 28 Feb 2025 00:58:59 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 00:58:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5/zlCaZ01IZvlhkfvcFf02HxAyRI+cu8ZQJ34Ny8OlItHc3JiVI4+WWtmgqC9xT+mk1Amf8DaGb1DfcIqMld/3ZOGsIgimnDv7HIt9bOHV0Nmtt34dJT/M5etbDop3VUQ+r+tpzElCHKvrbCXZBrUBBwmVZOzjMutvNx8M7ZTGiYHT61vOlZKm8MkFGYSDKqVWHZ1npmz91dlb5Zu2B+j50vhPzlwp7TzHfN85RoTb9cqlRAYLmKC9OmO0UKLBR3gpcdeXAcdEJm/BBBTy+7cplor2Yci8Jl8YvSkrLeuhQ86rzept0lCYLzX5M6HZumxI2932/kuuNhEPr/zMvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRW6IL+iUdn+5EYKO3oiu9DZWC5U7HeU16xjD4nyx6E=;
 b=RmIVNX7WI3YLx+NWFdlO4bLox/wPwyij6e+8rkMkkiTXRdHzXy2xg5ABIv6+cjRs0dpPK5SeVvwzCybVdNy3RPHG4tfNpdsUa5K4AWgCgrw84W/coCgzfAkIDGb7YFZltTFT15SzlquVbF0nwphI57rkkH79ACIsr3FYnk2gFCjWBnR7FD349tYlnE/Qd634QkDSLNZSCx1Qmbcvp/NNspuoxOT6RRmCDCm5f0haWdqYeuCCoAL5LZiYQ3QLaOzWm4tFbmH4cz7PK149Tu52+wMRtcVS+e7P5jIKCgciMgP/NU2+DUiAOp+vFivOkFr/YK8CYtqXg9Wv4GVIzhgVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB8097.namprd11.prod.outlook.com (2603:10b6:208:457::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 08:58:56 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 08:58:56 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH rfcv2 12/20] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Thread-Topic: [PATCH rfcv2 12/20] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Thread-Index: AQHbgqgVIqtwAhssjkuqrowqH7C7+bNRvMQAgAlFnkA=
Date: Fri, 28 Feb 2025 08:58:56 +0000
Message-ID: <SJ0PR11MB6744AB90A3E8E519B17FE09392CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-13-zhenzhong.duan@intel.com>
 <d74a5804-4a93-4eb9-b8dd-62426663e8b2@redhat.com>
In-Reply-To: <d74a5804-4a93-4eb9-b8dd-62426663e8b2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB8097:EE_
x-ms-office365-filtering-correlation-id: 4980bb8f-d3a6-4599-5119-08dd57d6225d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KMahnA31NWsXXmjA5ti9p2mnjFy8QLVdSapTeMKyG31fooU1+ecPlVkKxAX3?=
 =?us-ascii?Q?cSetnV+Xeqnk/UGbJJKOPJnfZbxybd2/gm4xazaXI001EybMs2Ry64LbAsQe?=
 =?us-ascii?Q?RBebg/7zMPn0N2hHPeBBIlTcx17jL05QXZ7gwYL7c2AWoBt82UsS97EIBWGq?=
 =?us-ascii?Q?pK6e83/l56k2/MnEAw/MEHkZ+fJDHbXdK/f0hEeJ5cAm4kJULtqCm54T8CYD?=
 =?us-ascii?Q?x9IY8qBjTQRGOhjconleivFd+2nt167wX5oCl7eddwVeHPo/Q5ChelneUWrd?=
 =?us-ascii?Q?g0XeY/hZGnFqGZ9M5kakJsyKXQwG4yCwWYlnl0wVqm4yimbD26QQUja2ZIyI?=
 =?us-ascii?Q?PFbH1Lxb25UzUq3Hy3IISHHSDP+9wClxUatzJauY7hBNL50iSnTwK7y20p5P?=
 =?us-ascii?Q?/RLmP+xqfdnRExLRLO8ylYV6ElkcmDDsgXvBsuNQVRXwnODbtx7tDsEOylQL?=
 =?us-ascii?Q?14ZSAogUCSTE0MQPjlN29PlR0uRSA0pG0EjYVXfwX6acW3VWB1ZEH2P9djl8?=
 =?us-ascii?Q?SBt+n4BcuGkfova8qCy5XKYS3R+cxEu/7q/zDzP9d3929KhFzfRIModBiQlp?=
 =?us-ascii?Q?Qa54GzuZC5qBR5j1cmeVum4lL6cght5RspKH0GvZIMPJKZpmqrpelwXg1Pdc?=
 =?us-ascii?Q?SZVOxIUScFLN+J/2gXAZJTMQjt8hLni8RwepeA5EerRrtSOErzc4mpeM+IcI?=
 =?us-ascii?Q?ZQuIr+plcCt0m3vSWQ0X5CNsWLvZu74Jba0kGTExSiWPlhZn+F17VeRLXHB4?=
 =?us-ascii?Q?teGF+g5UWHZbiQL/FIkO9slvlwjKRp5FZAnm5/1k5wTClglpF2HYH4cJse69?=
 =?us-ascii?Q?GFnULunNc11cTtKUt8JRo45g91bzseEoXKSHGchrv0yUNZEJxdV8AiXByKBH?=
 =?us-ascii?Q?e4fI3b7BoWFhY721zalwAGpLesExS5yRFbCav2i4oVbEK/HoyPt1YRPsWEyZ?=
 =?us-ascii?Q?KJTlmIouDyBJbyapXX2QjN8MEQ+rFR0eQ0zn+7r6nTcyHgQw03L+G77ebpJd?=
 =?us-ascii?Q?CwKyQK1SbPi0MRdt44cBVdc7v0lb906grDtubsYJAK0Tcr5DWYM38YaEg+yR?=
 =?us-ascii?Q?7rcUfQVE2b9dj19oJ7iRu/gzZ/Age/ETtTk353JYqWVvm+w7aUMF8en/lGf3?=
 =?us-ascii?Q?LENwy44oa/0ZpGG18jLMd+WT12LNYkIEfRvG0i77ncjHVJkpmrXqVwykpX2z?=
 =?us-ascii?Q?EXpSBP7O1aFV9PYt8qQ2kE90DT2WdebYAmUPIxDA5UAskR6aHgGi1ZbAOhEN?=
 =?us-ascii?Q?yEOZ6/jw4Dp9+v5d44hfwQl4NySXR+YjtVY7fylKwVmGlIT90d7hEBJCg399?=
 =?us-ascii?Q?adBOSd9phtixC2qEL3pjEgHs0uA48vaRRZSwNrMGuHjAUrMAlGeAxdFycvzZ?=
 =?us-ascii?Q?v5nJhbFAqFcWxOX9j6xsxJy5DgM59NgeeU2c4b5Z6OBMxHuRWExnvl98L8T4?=
 =?us-ascii?Q?dn/Rp7sH+xxhziLawE7V46Onol8Jno01?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T/LGXapLyhnGuagDLSygAIG8c/vjPKAMt1lz8FjkUes7xRQIbiLVb3RQoOQ1?=
 =?us-ascii?Q?xnUFjVqqJkRD56Pt/47ht0kVWp3vAp0ddpzmLKPxX9QT74sZxH5qz5G/sqKm?=
 =?us-ascii?Q?IX3m8Ej/fzOicABbWjOrV2kHszvS3khTOmDQF+GXD+/jNWExZEqZ3VxzpoHf?=
 =?us-ascii?Q?xdKchIE/k1txIxwR1xSYuhk1nssoeDM4AhkmBsD+tOohgEb7RPcjPfPj4igw?=
 =?us-ascii?Q?33RxKtR4wIbMacfALx/t94GzqpRdPB0zbKJ6wHSMLBYkucgEyxjnF1NbUQvV?=
 =?us-ascii?Q?kthVBIJb3MEqRchqe+CeTp9lzJoV9QZjU0VDJ5El/oVf0v8Ixmftc80pL38m?=
 =?us-ascii?Q?9fQ35X1fSsbwIMWIBbhSFb94EEwcL/W4GGTTrA4MMjCaqTwN8py3Ap0A33Fh?=
 =?us-ascii?Q?mD/Ug3BwJw7vxsRqcjS8yedRceDoctb+6D/JQug9xa9jOLFOi8yFcgA25dTF?=
 =?us-ascii?Q?wUHPbZ7TJFIC/BY75q+dPRpuhoR90ktL7QRQlPk62d2e+HfwpznXJs5gGSMc?=
 =?us-ascii?Q?/5P7+90S6SnsipJSFvphxbZY5lvOWF6+U7+0kkDruGpz8QG590GoBvx5uhM3?=
 =?us-ascii?Q?7s6K4oCj9N4hEdGXy1G+zZp9i2gsjsa9k8Mw/p6kTcXJnAvKqzq65uzouvlV?=
 =?us-ascii?Q?Scci8qtKhkicCvPnzqzLnO8TnzhY64y5upfZFBS1aJUPo1ppbOlBcqCDsgt5?=
 =?us-ascii?Q?AB/IdzfcEQvA5KHXOsJL8Aur5edIPd7ENJmyOg8cmrrcf9LB7yPm0qVHecDn?=
 =?us-ascii?Q?yjYNId3qHps9sP3w7+pBlFkw49w54zPEEqaltFDTQlnsia4G6OJ7/gH5sK6i?=
 =?us-ascii?Q?uZ2XUD/tOCOudmEQBJLOP9K/e8A9M5PnEtEXN9CB6OcVeo1ZFk7Sdj+0uOWe?=
 =?us-ascii?Q?w+LaWsK/nmg5BeINmB/rcNDKbg8oEHDuVKGBaq9/7H+yA0+NpupO4BRmHaCA?=
 =?us-ascii?Q?rH8XEEGWMIVyzfLosL+y3ZMLACt8X63KiS6lvIC8xP4K349sxXmVCJF56K4D?=
 =?us-ascii?Q?cQRfhx7Ors3a1325g8X00G1rs9EIG82YDqfj7RPfCX5bmVQHZs7oZouqsiMM?=
 =?us-ascii?Q?0kGckhrVQzmuyCe5Fprm0apgHpb8qd9T5CPW4PTbIfCsZ/mLgXLQ/X9L9LMT?=
 =?us-ascii?Q?ykwRkxnL2DriG8HXU3dbAj71hfyG54R3vOp/dJf5zc0Rn/dvVthZomaL38+m?=
 =?us-ascii?Q?Erbd8fLg3oZ3jlLUP9fkM2SDfhParvBhQiJUViaxLvKVtjbiJWNxf6aWS2M2?=
 =?us-ascii?Q?/m/EtRVbbMhm7Hm7r23SKWiwauiOWC09nNPB9X8r178AFTFpO+RBmf18wX4S?=
 =?us-ascii?Q?8dKrtmrrMpeVjove5kyVYgu6IaJ33oI7eWeYlixx/Wn/x9QwOkLaufdJxqAN?=
 =?us-ascii?Q?Em7eMWSM/3vFq6TMryYfQ79pfUYDIw6UW0gESxXXUl+iba4UorXAH8mSbo3w?=
 =?us-ascii?Q?WKOAzjkzSoyKZ2crYVuf3m3gSusiS/05DcRyDlOSjZ2VrWmKOryzOvr0Oneb?=
 =?us-ascii?Q?Bs64b8JrvypCAoshEW3DfzrXrLCZXMwfizOuxWxXzyjrFF8wgiGYnuP5FbQ/?=
 =?us-ascii?Q?8bNe1f77rQDkcs/uc983GVRTfSZGzPWLSkI+v1Z0fldr7grThHY94ydly56A?=
 =?us-ascii?Q?1g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4980bb8f-d3a6-4599-5119-08dd57d6225d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 08:58:56.7430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ThD9XZDrawRYpMByvghD+5rOv0EIpPnj2S3tZfTqncRJnCDAT2jDWFOIc0blkkjxEOTjUeRsghINC65ZNPEiNxRcDawyY2S+w89a/bKp5hM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8097
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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



>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: Re: [PATCH rfcv2 12/20] intel_iommu: Introduce a new structure
>VTDHostIOMMUDevice
>
>
>
>
>On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
>> Introduce a new structure VTDHostIOMMUDevice which replaces
>> HostIOMMUDevice to be stored in hash table.
>>
>> It includes a reference to HostIOMMUDevice and IntelIOMMUState,
>> also includes BDF information which will be used in future
>> patches.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  hw/i386/intel_iommu_internal.h |  7 +++++++
>>  include/hw/i386/intel_iommu.h  |  2 +-
>>  hw/i386/intel_iommu.c          | 14 ++++++++++++--
>>  3 files changed, 20 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_intern=
al.h
>> index 2cda744786..18bc22fc72 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -28,6 +28,7 @@
>>  #ifndef HW_I386_INTEL_IOMMU_INTERNAL_H
>>  #define HW_I386_INTEL_IOMMU_INTERNAL_H
>>  #include "hw/i386/intel_iommu.h"
>> +#include "system/host_iommu_device.h"
>>
>>  /*
>>   * Intel IOMMU register specification
>> @@ -608,4 +609,10 @@ typedef struct VTDRootEntry VTDRootEntry;
>>  /* Bits to decide the offset for each level */
>>  #define VTD_LEVEL_BITS           9
>>
>> +typedef struct VTDHostIOMMUDevice {
>> +    IntelIOMMUState *iommu_state;
>> +    PCIBus *bus;
>> +    uint8_t devfn;
>Just to make sure the parent
>
>HostIOMMUDevice has aliased_bus and aliased_devfn. Can you explain why do
>you need both aliased and non aliased info?

Virtual vtd only need non aliased bdf, it uses non aliased bdf to index
HostIOMMUDevice to do attachment/detachment.

I remember virtio-iommu need aliased bdf to rebuild reserved regions
for aliased IOMMUDevice.

Thanks
Zhenzhong

