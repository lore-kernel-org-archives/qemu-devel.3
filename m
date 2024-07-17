Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332BFC3DA59
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 02:26:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTuLi-0005HH-9D; Tue, 16 Jul 2024 22:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTuLg-0005An-BI
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:24:56 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sTuLd-0001KH-64
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721183093; x=1752719093;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ixz2jisTOcRyGXcN71iLeEclwaczaQSk7j0CMqTiiWE=;
 b=U2ky/B4Jz4FzZq2YivegQz85qQM3x7KMA8jQoBLc5w+PVpcjHssulJbL
 3JaayILxHFrM0p49tbWZro/d2kF6Lj5p85UJ7gBxzH3aybWWcbUH3y3m5
 TPh/GFNkEC6dLteXipp2gk1yzkB/7fvTT50RtTmoZjzAiP5d9HTw+N8i1
 uzKSbLINws8aui9Q+nvXSBgm9Df7MfNJjx51AM9U7dVA02jKTHKdPBc60
 kI+whOwXCXQ0E6zjOwNkaohHtXeCzpbKB1TqnS7oqHPZAtd81QII7dmKC
 4pKeTYvsD98ClpjeLrBcEnPPP8BulFavuQfyxdtSTSA4vV7bWEZTqb9sh A==;
X-CSE-ConnectionGUID: vDkN90q/S4yra24v8YBHdQ==
X-CSE-MsgGUID: IWdR/KK4Rq2YWo5XpmgQkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="12580760"
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="12580760"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 19:24:49 -0700
X-CSE-ConnectionGUID: 8jlI06swS/2W0sR7xLa4sw==
X-CSE-MsgGUID: lHVhbZPnSkWiODrt2by/rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,213,1716274800"; d="scan'208";a="73436371"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Jul 2024 19:24:49 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 19:24:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 19:24:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 19:24:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 19:24:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzAF9SKuS8pAAGoGrendGwWbNYn6LuUU6Bt8bX2mZxFkZ2DL2BtvmCzbpzwosnK7024cuVnSBmfVIf7K0AQ38/mt6PQlS1HlhhTJyKycEML3B3weyWzXTmqjDaC6EMZR/4xOyUVexQa3z29eCKnqDZy3WTw5TQnSJbcaRCdOYxbCntWNlnT1nn9lQKUfAe4e8AXQV+i4x28SR8kSYzVX6LtkG1fj87ljU2Eviy8uBsP+Kpt5J2PjreY0r3gUI3/UpnQX+z5ws6M+PDoy4Pi+KJtsGDYrmaUMIfZc8nhX7qZLlDPZcJ4S1B5M0POttwFtsBY0gJU1x7DOSFrreOgiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9DXiGfzR9fYuSm0u9BfkOKTW1NWPm3jhmCuw81nTs0=;
 b=KR9y1dYEzErIcnXPHOHR5AK/9lrXtYpe742yYATrMXtrB7hVgplk9yD5Bx652A6wqjki1WczZ7aWiblVLjFtMZXiinIwVWoptp4rDIw2YXFgnqd5qb4tUoAwEjIVnSq5zC2gZpKWADPrlb9dk83TzHU4p+b2sUZw+RA9ppm5CRHssZrYeotpixQ1q4pnSd8/ZNi6DY6oiFymltyFZASIxByjxlXYMhZbgpCz2BL7gi9RHRqVLACePlsuitrQzStkjSlumkHtIKLU+0AW3AjeAAK+z7D8JE1usi2UyCHiCn4C8D4EwTyZ6En/57bw1tL0SIsu9oPw0FolVh3ZcqIcMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW4PR11MB6737.namprd11.prod.outlook.com (2603:10b6:303:20d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 17 Jul
 2024 02:24:45 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Wed, 17 Jul 2024
 02:24:45 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: RE: [PATCH v4 09/12] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
Thread-Topic: [PATCH v4 09/12] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
Thread-Index: AQHa1FFSMrytNe/SgEKr7QW5CKilwLH6N8pw
Date: Wed, 17 Jul 2024 02:24:45 +0000
Message-ID: <SJ0PR11MB6744B9EA05FE77ED2FA9C96C92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-10-joao.m.martins@oracle.com>
In-Reply-To: <20240712114704.8708-10-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW4PR11MB6737:EE_
x-ms-office365-filtering-correlation-id: ad46d51f-2983-4222-4a8d-08dca6079f8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZZMIDSdOVmY4HpxKssOnJXBiDY6O3qokeN0cT8THTZphRVb6dBAdsOheiyRz?=
 =?us-ascii?Q?91FrQ8Uox4MTtq3Ztt2+dpBAV+SwgjRIRVBI59JdUt6WexSHBPzA7ZkxKxMU?=
 =?us-ascii?Q?nuMATu7sz6scUNKhM4QJP/vE8uL1VibcJyrtbH9jK6k0501O+1RN4nuURDJq?=
 =?us-ascii?Q?PMJyYuZ/eeYWjJq0ws6XMoigLc4tRdsW6pOuu00RPep+ssaKP2ecMI6L7GZp?=
 =?us-ascii?Q?SwQY1LHdDRxBqYvMiKnYo6ayO/KKCLhf8009FiUZMlInaqYIjiUSbvP1/lsH?=
 =?us-ascii?Q?Z5vfd+WGHC1z2yCTHty5XOZdA6YoOl38ZeBeZvMYPKJJ8tujc7B4S82X1yuI?=
 =?us-ascii?Q?TuuleWnto22CJSrp/+t2bQKvBgcusuYw/lAksm7XCNqFIfQ1g+EVsGSR/J7P?=
 =?us-ascii?Q?gKEVVoX8hnUeZPa88UmnTWfG1SORJ2khqYbeTzl/TLgK0sbztqj/KmCPjMHN?=
 =?us-ascii?Q?lu9KCulgjCUA8NpOiwzOJjhFbQSk3V2IiuJtrSIrZ9RYVJfczOa25RfX0ugA?=
 =?us-ascii?Q?q82zP7c1ZEZk5vbv0OvEwdcQvyiVm8s0KGZJdGi4G8mfmpqK8513lNK+MzgO?=
 =?us-ascii?Q?K0/Z6Urr0t+8RS8vnLIXBYSJO7eoPlFac9S0kVcN1Z86zPopF4JkUsp4UM25?=
 =?us-ascii?Q?UjJXOkmKRkg3NDslgoNzFtldFWT02Lpg/aQEyYs4qBbAqeiN2lfWA6UL5S9u?=
 =?us-ascii?Q?YoTsS0uDReDTSO4hack16UF242wzVsxTnaOTGRQT2242JHEeq89oM2EJUCh/?=
 =?us-ascii?Q?xcrvlMJGbXyozfv66IDievAYdsJneOKLIr5ywXqZWoxlXg4nyebvtHOvi5vv?=
 =?us-ascii?Q?dTdkdI+T0LGTLDt1I3dFHJfL0If/tTgbu9I32orLrIjBXmMf67c79E62Tw5o?=
 =?us-ascii?Q?dVyq3dZlvods1K/M/oCwD52plNtn/PcZKp8AaqExMT1GO9eA5hr/jbnGV0/I?=
 =?us-ascii?Q?m6efBgzR5IMLqbqiHDeSUadUof273FBts1wxwARS721usHG3ZgMnaINm/sh3?=
 =?us-ascii?Q?s+AYlwmRxb2nuaYJ+GllYEy5dGljHHo7gQQYcL92mMOqqMEQ1P52XRr/HGj1?=
 =?us-ascii?Q?keDC4hze++/QqaaIYF4AuJHx7ZLnF2Qmqs2JF9N5i8vkCiVGDiVVmqaQetEy?=
 =?us-ascii?Q?YPX3oK6fE6h/+d6PwWHrQHrLQ2B5ddtSbosYwgjO0G9jn2LC+crsQ+VoOn+L?=
 =?us-ascii?Q?0UWThmxZMaWbMMP2+B57YDxohbbzfYLnE0HH9SMGwZGWsxnFvCa2Ds450qte?=
 =?us-ascii?Q?TvaTpOQMUeBAI8ei3WP1SKGa7xrZZ1FEzWAgcTD4FdmxnKC/8ZxfsFuJ11/K?=
 =?us-ascii?Q?IeDBv+3k94r12veRb038w/IHS25gqualkdCfK+bPXFqRdTsfv11W007wmq+j?=
 =?us-ascii?Q?DLUoUEtvPmZIV46Miw0stOfwDhi1iqFFOJ2sfSfJxvjblkHgPw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hmMg2f5V6wIKxibnimDj8krJ0ViDC8GAq0rkCD4hq9yzAyOepzTbeN3Sb58q?=
 =?us-ascii?Q?jl9I6damiQx+F7qiPyvIK/Ue+W1YmiJL2xXlesx07GGZVLMg5S5ka8uhp13z?=
 =?us-ascii?Q?NLNWecqevAGwFPG8S+0mGBS6mdSQG+dAQ71gZaNR4T1TGgtHGNNux9J04Ecd?=
 =?us-ascii?Q?NuawJZveJlx0NEFhdPkdP3rAKCbPpBA8LOiJHcI6rZQrOxCHJ/YplSqJDhsB?=
 =?us-ascii?Q?TUlVwNt37zNYtdEteI1BscQeBGpMWHSHdoEckmpUK5sjZjy1Cp+8AYrIUy3F?=
 =?us-ascii?Q?aVrrxvMpO9FvcBBn41dpeh0EN6eJGSiUJIaWvhO6im7xsbgTmSx+9IxnNltf?=
 =?us-ascii?Q?hDnH8dx6LR5ou9n+hDzneKf5DWmxgEsgBdhmOMIMYlqjyJ4ueHtyoABO9AyQ?=
 =?us-ascii?Q?PCEClSGcRulAWCgh4XmLLbN4ggr6bBBV2PVhbXrE440/iVTBC5zUXJlfEQ+m?=
 =?us-ascii?Q?bRfGqL2xRsd0DdAsukqJ3d7UxDy3ta577OMQcdknUUnnTvGa9zZ20VTL4xqB?=
 =?us-ascii?Q?akuwncsSQ6bgoSIX9Dr5GdFZehfo5LmgSY/m/GM3YhlSuFILjIoWD1K7MIcV?=
 =?us-ascii?Q?9glgX8KXb24YKU/34pmYpSeJumraOb8FKSdO1pw23bpOziFC2NweealJxreS?=
 =?us-ascii?Q?gV0H+DDRmTCkwF+ANYnNGqV6avFKEpBc7XzJv3F8ny3P4qbqitgzs/5FZIIH?=
 =?us-ascii?Q?ywSl8xigME819a+B2VTdoA91ut00jE1tGbf+ZwwVYEZxhYOwzgQOEKRLGN2N?=
 =?us-ascii?Q?d7nyYLrLDgR3Cyyq9qklFC2OVd5J8asJZx3MN39znslu5assUapJHNgUX9lN?=
 =?us-ascii?Q?Nora0uqBZb7Tbin0tvlOx+ClMG6lhLb2EOz4tqPWyOCOOCbypjFvCsNon73v?=
 =?us-ascii?Q?7711W+RvPU+USGC4Z9eUDvfNoN3uN68cA3MP7RAm1GIgVs4LZaYjW5FI7s1t?=
 =?us-ascii?Q?MmA0eULG6mfDUBB5FuFEfD7f7Z+EMQ6p6kYDg5OvBIemZ4LXw84ER0eLbadG?=
 =?us-ascii?Q?u+1BMQgp4NocFI/QtZDV32AentBDft+CwmZwc3LpSPcSf92CJ2Z7kI4RiVeh?=
 =?us-ascii?Q?YgbN1Mx1JaQfEMkdDDwjqBfgCMHzYdNrijHnnigEE3pq72xJ4RN/nwOHoPIQ?=
 =?us-ascii?Q?wOtirQy2uofURhWRzNTP39AtqqjaFYfjE6DSx60tKVClEe+Zeh5u/LfuzWGC?=
 =?us-ascii?Q?KAur4Bya0ueHHcaBWK44Fs7d8nnEtUyoR+X2B8d/HkUrqX6hz+bYHMYZ8jdK?=
 =?us-ascii?Q?ec1/qZZmesU8M/gXTtJ4L4Mve0Udvnfa/PM6YilQHQBm329hRBS96a0iN15v?=
 =?us-ascii?Q?WSCyS5r7oHzD51NeSeIG3IMl48wTBMmpZkFdq9DhppkyXwkjyOhWZhzIEWDF?=
 =?us-ascii?Q?nN202KOuzCjZXPUTRBJ+ayy+lVZQVe6jxkumxeKk3yneV4+RhY+gG1u+C8OS?=
 =?us-ascii?Q?i2ysrxOv7Bl8ZA759leTGdAGPUxZK9Rd1QVcj6oBfdE7OFp4+NlBMIdxO89X?=
 =?us-ascii?Q?jSW65zUcIHHLkLRzpqlkT9kVJbdTPgaKJwtcCXm/7Uoi2xdQV3GzPhssXaTL?=
 =?us-ascii?Q?StR/fwr4qnmt42cB0nz8yoL4ezTPW6HjdD3bcmRy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad46d51f-2983-4222-4a8d-08dca6079f8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2024 02:24:45.1444 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zjpO6x987ph8WXaZtVjs6r4h+ICviinTcLAEsWS36eoA0pWidEEYmBWeq+LWjqdPt83lObQ6hziHBuicAo/TOya5aVAw9ERM7uN5++Xpz+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6737
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: [PATCH v4 09/12] vfio/iommufd: Implement
>VFIOIOMMUClass::set_dirty_tracking support
>
>ioctl(iommufd, IOMMU_HWPT_SET_DIRTY_TRACKING, arg) is the UAPI that
>enables or disables dirty page tracking. It is used if the hwpt
>has been created with dirty tracking supported domain (stored in
>hwpt::flags) and it is called on the whole list of iommu domains
>it is are tracking. On failure it rolls it back.
>
>The checking of hwpt::flags is introduced here as a second user
>and thus consolidate such check into a helper function
>iommufd_hwpt_dirty_tracking().
>
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>---
> include/sysemu/iommufd.h |  3 +++
> backends/iommufd.c       | 23 +++++++++++++++++++++++
> hw/vfio/iommufd.c        | 39
>++++++++++++++++++++++++++++++++++++++-
> backends/trace-events    |  1 +
> 4 files changed, 65 insertions(+), 1 deletion(-)
>
>diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>index e917e7591d05..7416d9219703 100644
>--- a/include/sysemu/iommufd.h
>+++ b/include/sysemu/iommufd.h
>@@ -55,6 +55,9 @@ bool
>iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>                                 uint32_t data_type, uint32_t data_len,
>                                 void *data_ptr, uint32_t *out_hwpt,
>                                 Error **errp);
>+bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
>uint32_t hwpt_id,
>+                                        bool start, Error **errp);
>
> #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>TYPE_HOST_IOMMU_DEVICE "-iommufd"
>+
> #endif
>diff --git a/backends/iommufd.c b/backends/iommufd.c
>index 41a9dec3b2c5..239f0976e0ad 100644
>--- a/backends/iommufd.c
>+++ b/backends/iommufd.c
>@@ -239,6 +239,29 @@ bool
>iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>     return true;
> }
>
>+bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
>+                                        uint32_t hwpt_id, bool start,
>+                                        Error **errp)
>+{
>+    int ret;
>+    struct iommu_hwpt_set_dirty_tracking set_dirty =3D {
>+            .size =3D sizeof(set_dirty),
>+            .hwpt_id =3D hwpt_id,
>+            .flags =3D !start ? 0 : IOMMU_HWPT_DIRTY_TRACKING_ENABLE,
>+    };
>+
>+    ret =3D ioctl(be->fd, IOMMU_HWPT_SET_DIRTY_TRACKING, &set_dirty);
>+    trace_iommufd_backend_set_dirty(be->fd, hwpt_id, start, ret ? errno :
>0);
>+    if (ret) {
>+        error_setg_errno(errp, errno,
>+                         "IOMMU_HWPT_SET_DIRTY_TRACKING(hwpt_id %u) faile=
d",
>+                         hwpt_id);
>+        return false;
>+    }
>+
>+    return true;
>+}
>+
> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>devid,
>                                      uint32_t *type, void *data, uint32_t=
 len,
>                                      uint64_t *caps, Error **errp)
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index edc8f97d8f3d..da678315faeb 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -110,6 +110,42 @@ static void
>iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>     iommufd_backend_disconnect(vbasedev->iommufd);
> }
>
>+static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>+{
>+    return hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>+}
>+
>+static int iommufd_set_dirty_page_tracking(const VFIOContainerBase
>*bcontainer,
>+                                           bool start, Error **errp)
>+{
>+    const VFIOIOMMUFDContainer *container =3D
>+        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>+    VFIOIOASHwpt *hwpt;
>+
>+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>+        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
>+            continue;
>+        }

So the devices under an hwpt that doesn't support dirty tracking are bypass=
ed.
Then how to track dirty pages coming from those devices?

Thanks
Zhenzhong

>+
>+        if (!iommufd_backend_set_dirty_tracking(container->be,
>+                                                hwpt->hwpt_id, start, err=
p)) {
>+            goto err;
>+        }
>+    }
>+
>+    return 0;
>+
>+err:
>+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>+        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
>+            continue;
>+        }
>+        iommufd_backend_set_dirty_tracking(container->be,
>+                                           hwpt->hwpt_id, !start, NULL);
>+    }
>+    return -EINVAL;
>+}
>+
> static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
> {
>     ERRP_GUARD();
>@@ -278,7 +314,7 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>     QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>     container->bcontainer.dirty_pages_supported |=3D
>-                              (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
>+                              iommufd_hwpt_dirty_tracking(hwpt);
>     return true;
> }
>
>@@ -717,6 +753,7 @@ static void
>vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>     vioc->attach_device =3D iommufd_cdev_attach;
>     vioc->detach_device =3D iommufd_cdev_detach;
>     vioc->pci_hot_reset =3D iommufd_cdev_pci_hot_reset;
>+    vioc->set_dirty_page_tracking =3D iommufd_set_dirty_page_tracking;
> };
>
> static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void
>*opaque,
>diff --git a/backends/trace-events b/backends/trace-events
>index 4d8ac02fe7d6..28aca3b859d4 100644
>--- a/backends/trace-events
>+++ b/backends/trace-events
>@@ -16,3 +16,4 @@ iommufd_backend_unmap_dma(int iommufd,
>uint32_t ioas, uint64_t iova, uint64_t si
> iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=3D%d
>ioas=3D%d"
> iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t
>pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr=
,
>uint32_t out_hwpt_id, int ret) " iommufd=3D%d dev_id=3D%u pt_id=3D%u
>flags=3D0x%x hwpt_type=3D%u len=3D%u data_ptr=3D0x%"PRIx64" out_hwpt=3D%u
>(%d)"
> iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=3D%d
>id=3D%d (%d)"
>+iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start,
>int ret) " iommufd=3D%d hwpt=3D%u enable=3D%d (%d)"
>--
>2.17.2


