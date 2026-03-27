Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B7910BA431
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 06:45:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w60wF-0005TP-UO; Fri, 27 Mar 2026 02:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w60wD-0005T8-Cm; Fri, 27 Mar 2026 02:44:57 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w60w8-0004sb-MJ; Fri, 27 Mar 2026 02:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774593892; x=1806129892;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/ameq1ZYvh2TZZoqs7VQcY5wtKq4/zrEwWdUMMpqgIA=;
 b=Hq0AUdkwP9EmmZMmcQMxSm4nvWxj8KLwLbfUbF/hbD4FJmzvqRIG74J+
 MmFS2eVXda8ZbkSFDeZK2Rv1z1Sor6ouqEXSOJWAqQ1siVPfo25mEosJZ
 gtbsUzK1tsk7OTVoFk+KxyX9B184/UkmKi9Ok5Fn7cutWVCW+dpedblOq
 UWLWXh4BggNk98Vb1Z8BkrimhqBINIcs646jGhpyW6wwvdI7C8mVR+U4N
 Rmpx0uE+JU1KAHV3vyR94qrKh2vSM2LE1KVYkqX6r+vWmQvHIoo/X9AjB
 ZDaAnQTp4JqpoJhCPQEqakpdmIQSosA8Wh4AE2P75fxjQL5/FL4lQ66vb Q==;
X-CSE-ConnectionGUID: AvTA2mnlQWWLsqnudGHGgQ==
X-CSE-MsgGUID: AezoPZaOQP66k07LouFs5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="101122922"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="101122922"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 23:44:48 -0700
X-CSE-ConnectionGUID: 4dLqinh8RUSIfkWpuO2+EQ==
X-CSE-MsgGUID: ROjIGfwXQ22743uMZcH6rA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="221912787"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 23:44:47 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 23:44:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 23:44:46 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 23:44:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ff0Dn6y5w3eQPHS/3kv86m3CuW7431EOWAKPBBtqVHjjsts4BSLTOCXzcUc/+nzXs97cpXv1ctJRMcUOqI5qgszELU42muitOKhOM04cMFc0YuUkom92pNpD0XgK2n9tjwf0JDaLXyzisJ1fokQr0Mir/HU24dtI5dQFzIMNaSqtB3Xl19/YGGy3Zh5cBK1rAkG0XZeQBE6XzBDaJZ/GWuHFnapX2lkf97ETqTHR0kqovyLmRBuXPvdoyBGoNMPIF2aqYI3Vxs2zOR7BODr4VrXPgveyvhQG3kEizkIf5rtlB6n9uALggrPsA6Y2yoLQpZtBlogwC9FPUuk2N1vK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Un9fNBKwa13Disgxy1XpTLepXiq+ZZQO8LGYdqgwzI8=;
 b=NZwa1RP7BTuL/0vUo6zmcN7OCerB5HWzyYmdGVUd1uFk6xvg2hhNQqFra5HI9QbPaseXmPrqCDyY8aJTbxHusc395FsFvo3frAjAhUTAePR+KYYm0nBfxnckdWojeNY5teQwSuLOt0OVnSDgCB1YEI+I2usY1FPWAOp5OUdPVgaHAk3nzXKFf1FD5xPKsGf7I0N6JBYcWBA7A5IhOoprxKFZYJiG2hhiBzHJqt4FfpuzZNH452WJtET2TxGG9J+VIYX8GWq0WtS3yOIvDOv7k1HkYJ0n2ugiycvFIQpICcgr6NhJJdBR92xRJ23QqK05OErR9ANVDLjDJn/8Of4CHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB7975.namprd11.prod.outlook.com (2603:10b6:806:2eb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 06:44:42 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Fri, 27 Mar 2026
 06:44:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@bull.com"
 <clement.mathieu--drif@bull.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, 
 Yi L" <yi.l.liu@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Thread-Topic: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Thread-Index: AQHcvQCbR71K6Acm9EmcQazKuEj1x7XBYwGAgABGe0CAABWVgIAALZgg
Date: Fri, 27 Mar 2026 06:44:42 +0000
Message-ID: <IA3PR11MB9136D9DAD0B8698841CEF4429257A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-3-zhenzhong.duan@intel.com>
 <acWwwzfNEzBg4n96@nvidia.com>
 <IA3PR11MB9136FC71017C3B05CE3C881D9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <acX9/RjKaO0bBI/d@nvidia.com>
In-Reply-To: <acX9/RjKaO0bBI/d@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB7975:EE_
x-ms-office365-filtering-correlation-id: e2effd14-a0cf-4b18-156b-08de8bcc5388
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: c/7AGbUP/AokONKTEo2VwD9IuSWbCjuvMU2bGLyXiLT1lps4gtk0Z0gba/BsYF0/P8SnjsrJ9eUlTFmHPoIq3JUq5tUnEHE8rlPAk1+mrwMKG7NjHsXRdXpTj/Mxdkq6qgUiV0b1ZBewYA8Qj7cORBLcH2gVPdw9OBOgt4/EfB3sPbzuHbRikTgZZn3Kk9q1RbOG8+Z12OeY9YL7LIqKldBQbtjAq/rtlHIR0jNdPtRf2C+3LrI/bj4PH4ZC87//94m57YHwFUXezEFp/cPNNfVkqrJqdZNmRnv04njeS2Q0CUTqyGx3ygDuCbrCH3hrYgaiil+totuxRBBuvXcauAXcZDclkqJHRyjl8t+FYQ1rESerSL0cRbXY9jyGt36Q0wqhO9vRFYdjdzMS+7u98IyQk2OIlgmlW0eBpRBCl5FZTu9opQf1uJOTqWR4rLy/Oz7JwRM1LohMiY6TbdJE0qCzyOe090pxknHD19y7zMahrY5VLGD34oYV9OCp8R08UQC4ifTmparGfbcOAIkrDI0P5/dhKQrwTI/UUS07sogTbH8nfBWymmLKCIhD48ColCAhukn/rKBiO2y7C1WZYspxJF5ZG/a/VqkwaqbZC2m6oHOta6wC8z9Gs3Ju1kvOT3YBqMkIGG/A0AwQC01p6iZBgyVbnnYU4T2x7bDTCTVX465HNNvnXrMD7/swAsLw6MCiGrFvy2Y7vUZiclvhofMwJzbOohnbhsVbsTtgw1UjM/b46W8fVHoT3/sNtu2IJ/swDqBMxeuYu3NPkTSf1MWIqslfoCh7NhmQM2yQM8M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xfcvO+xzX3mNfrTdMjVmR085GRdYV4RgAuQHHWpdIHSkaSZoH0kykYmk5Hgb?=
 =?us-ascii?Q?BvZfZxY9sZwTN9NJdd1Dto7daxXT8hXsmM3Yte1sbr4k3VJDcsE1LjiCG/yF?=
 =?us-ascii?Q?2TWM6IGvYXDQUVZ83ztHheUfAiLIOT8TacsuChEH0MZosQJIZYhlroP0vrAr?=
 =?us-ascii?Q?oFzdw42CGwm8vbhMe1Og0xo9T7EiAQjLKIEuTZUqrQ1BUVfWrN20b5JfE+9D?=
 =?us-ascii?Q?yEm0UG+knAvIpiiJ9MekEPXjuSPjFMms0CcYEdC3+eWoxHsjAFSOwr9ne7A4?=
 =?us-ascii?Q?fxHBbqJE0x2jLhOWTpnSUgOnpQcUDPl5PvmrWfvvAsl174LoTwjeJjH0gGPC?=
 =?us-ascii?Q?KZlXyuh6f0rr8Z2v4DhRe8HYCF0LV9fos/FTDPr4jw36Q3WFQEYF0Wx0Usr5?=
 =?us-ascii?Q?qDU8GPUmITy835v08u/8BwYCQmdN87CuromzCH0JdgF5aRofpip1ARIilakZ?=
 =?us-ascii?Q?0EeFUwsmLbDqpzqp2UQTycq/GKxTQFvP0++1ONuEaHCfkn8J5YfgMMucFC5B?=
 =?us-ascii?Q?bIOhmvQa2f+tpXWL9pQH9ScNdM+nMucTTLxWXC/y/WsvJl/lCO8xPQDmW19A?=
 =?us-ascii?Q?lIcE+0XKWsTSpO0DOJ9tlxQtRzwpZqOBgprv8jveIHO4u54N+9JS5cxlIaie?=
 =?us-ascii?Q?bOD/wRTXE2JcGsnJkWG4jM+Clj6Q070kcTI+M+UwIsaYhDzzUI/ThLXicv1p?=
 =?us-ascii?Q?qsIWnYoLbMF+4lcBrZxVy192f7L/j0GPAQ1Zg8Jk/8Nq0W+lcKBMwp0rs6Yb?=
 =?us-ascii?Q?4+zEKDpkj4pZF6c02nD39s2XyhBy9ZzyriI+J81Toz/pt/nt+jg2SwN00FpY?=
 =?us-ascii?Q?gSf9m/fZrX02nALQ/twS4TsdfNgDHz9ooxu/liwtP0nASt/wRgVUpHohAQfY?=
 =?us-ascii?Q?4k1BxD8+KZF3VMqZTCgA14C0cVOuphjnVdMGcZKrYiejuFeq444sQupjAOW6?=
 =?us-ascii?Q?odXTHs3cg/VqkV04ehR55EfzD5NMjFhY8SQlFdA1CI6yM0Y3kCiy2X1NgOWh?=
 =?us-ascii?Q?QJZFBekxsxZXhWHVDQfCwG3shfh4tByuFI1QuROqaqG7jDkJsUwLjCxBw+8Q?=
 =?us-ascii?Q?wJO4DCJK0ijYtS7Z7qqprM2crSuc3fsPfLV1Sj+TYHiSAYKhWcEmytkY8/UU?=
 =?us-ascii?Q?d0PbqB/Lap7/vg+QlDTtWNogX1JlVBiLQxdgo0z68qYSZ85KADp/41sYxtPz?=
 =?us-ascii?Q?oYiWouhigVXhCRGzetlQgLKEk354MxykR53HEWdXAlTPDtR8RC8xWbRdQQ6Z?=
 =?us-ascii?Q?gXk2e490kO5iE6UbCC8A3F3cCUXkkvOGdXl7SECs0QuLsy9+fgWPT2m86NAk?=
 =?us-ascii?Q?b1v773SvNpg8FD9j98VxjyDM6gRgBIIql7EN8tT1QI0ZeD0k/UkASY56SlSr?=
 =?us-ascii?Q?24uWMGtukW+9q8CqXiWno+mn5eiO5mphm1Cng7yTTrrfxIScrE71b9Q1B+4t?=
 =?us-ascii?Q?JOg4y2F8g+Qmj+B4YIMSdWkkSgWGXPeYM0JaeLgGD12eHYYP4g+gf/qnjX+g?=
 =?us-ascii?Q?U9Qgqus/KDWUqvP3+BnjvlLjUhnp38lmzYeo1ZkzEdDp1L3C/FGNxTEmr/sK?=
 =?us-ascii?Q?EkRPtNZOuNPC9rZcXvQDSP3+b4+dGI2g6cEGcFZgi8YtYPep1SK4mNtdkapV?=
 =?us-ascii?Q?fdQXySLYbX1RwM4P9bTFrSKTKoUXY7EMxGt0xxfYOfAGn0dZ42FzDc07jSsY?=
 =?us-ascii?Q?HtGNMK4wjSaruvM/K5nb+qcr93c25lqkZOKCWkhFfMntWpMVaczxNM4rSL87?=
 =?us-ascii?Q?01f54PB7bg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Oz2u+NHpb0NPSRIcP34zDWYGCbMfts6uFK63wmoXn/w93Iq/zTt0T+xymjP4N0iHLa2jgtVw1JtI3TbQ/9HbtFNNK6Ygv4Yg/aEXc4umVDIivDBjbXcauKzLpSlf8ci7oUvHhHGO5osWInxfFIXuoNAay2v5TmoHAaUHxkqpRWlroc73A0YiBJqNQCR32T1RejkhP0OdAZVj7nYcGEvHUyEMTVDsPAoxUohrxKzktb+yrOYYjxnuir0Ee1agYLZ9ugiKfscdSOAcb0w7b8Ml74sBI0ukJoBR9ilJl51cO+9uq4ww8uZnZ6fR+JBHmfsh0NB/5oRAVbhMG4AZsamXuA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2effd14-a0cf-4b18-156b-08de8bcc5388
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 06:44:42.3629 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vyxBnzH0vDxhX4dYGIMLN42nir2/8tfebIaBsPWarNRBZwjdcweo17mYLEhgdNm1ZByeoWeRFsqPctXQo91tFYt8x04/zrGVo3NkD39u/fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7975
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
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



>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks=
 to
>support pasid
>
>On Fri, Mar 27, 2026 at 02:32:57AM +0000, Duan, Zhenzhong wrote:
>> >-----Original Message-----
>> >From: Nicolin Chen <nicolinc@nvidia.com>
>> >Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callba=
cks
>to
>> >support pasid
>> >
>> >On Thu, Mar 26, 2026 at 05:11:16AM -0400, Zhenzhong Duan wrote:
>> >> @@ -138,14 +138,16 @@ struct HostIOMMUDeviceIOMMUFDClass {
>> >>       *
>> >>       * @idev: host IOMMU device backed by IOMMUFD backend.
>> >
>> >Not commenting against this patch, but I just found the "host IOMMU
>> >device" and the "HostIOMMUDeviceIOMMUFD" a bit ambiguous. It's not
>> >an "IOMMU device" right? Perhaps somebody can help me understand :)
>>
>> A host device under host IOMMU?
>
>"host device" would make sense, not "host IOMMU device", right?

We want to emphasize that it's a "host device" backed by "host IOMMU",
"host device" is not enough, I think.

Thanks
Zhenzhong

