Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D46CA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu5FD-00029m-3a; Thu, 04 Sep 2025 04:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uu5F3-0001wM-NY
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:22:51 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uu5Ez-0001eE-61
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756974165; x=1788510165;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ObBIymkylvdCFPCk3KGl4XX4/XtxXsNSufN9hTg62gI=;
 b=Qsxu8eSI30KrIpnymr9OJECG99OPoLyFLrnJCXSX1gusNZXlADAH1GS0
 QzHFm4Cow135++MAFp/16M5fBiRE0Mz42yTzt46qXO/Zp5wjopp50eL3j
 czAtQcG5ZIbpBtnGntTzlOsGgQBrHbKB5xtkxYUXdW/Lcybr6rVie+IWO
 AR77LwScCU8aj3EZqAIEal1EXU8J6VJbF3cqfDX/SpH0F8Es6tcnvPleA
 GlpiLe2bFcQb226t8oSzXNL25nhgffUGZcMVH/tpAzCADB7C4lUDmCb2I
 m5X9OG/dK1oibbXxyAjFzjM5QIaCRSS8saoZYvHkDAgeo+c1IA5ZyhYGZ g==;
X-CSE-ConnectionGUID: F07TwhnpTCWpxTp1lxssAg==
X-CSE-MsgGUID: cKdu8/IRSHGiAWA6WSk+cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="70677873"
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; d="scan'208";a="70677873"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 01:22:41 -0700
X-CSE-ConnectionGUID: mJ+CzqwvTbi7NBsVMSwhaQ==
X-CSE-MsgGUID: KC0nLf0tTtaI62tAOvCimQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,237,1751266800"; d="scan'208";a="171408852"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2025 01:22:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 01:22:40 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 4 Sep 2025 01:22:40 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 4 Sep 2025 01:22:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O0OeXGGhIQmmfgHQapasW43Znz7ZjdVIPpo2CfRze04a7DuclbI0YeKPvbuoeflFI1vToih4y5X0R/J7QKWjpH+iR1AJEb5MLHSG1Zur9jz91DO/AHRq0uFADcVdqyF6llVxMFzYBSGKjYgbIDqp6mWHgS3nnN1uHMNhOPfFzyGH8uAuJfYSyZPj3KmnWOm5YKgrO+nXtiZIWWcOn1PK/5MllJ5pe/1nkr0cOUQzeMUcFOu3/3VzCzbh+7X64PgMeGkrCtLlkvw0r+n/nHwYmF9ekOgff1pXnmBy0wA+xnUCn7PxQd8chkH6eAkuRclDwDFGIrdAYn38ZLuBK+6CDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4FB6pvvGisV9lWriNaM4PGEE20oUCGWkdfPWCTfgs0=;
 b=Fj5uCRKuLHT1tRHULO3hz6Qn0+FlrKRTIdTQAEhNM/AQAXf1xaYEyQdAW2riy74d5lN+wf4NvgvC9Wuh5aYGjWBkGLZ+zg1Tsiyr3AqE6ilPVP9tTIPiEHWYuGWevxgzwAPlSJaAeceln+8iCMpSt27qbU+Nodhbz9mVnPWCDIUrHlgDbKArYXTpJY6QlKql4uIx9Yf9E38CMhJ8TUCnBumRyahKWvb5iS0fuuGu3UoaJq5pDB2rNM1PdBAxZMcmN59OazMhUMO7c4AEedRk+GY5NH5UqDY0iZ7jTlrRCfseJ8v6yWB9OpkuwXNJ12m4Khh8+S2J9VUAGfvpBYYKkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM6PR11MB4593.namprd11.prod.outlook.com (2603:10b6:5:2a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 4 Sep
 2025 08:22:33 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 08:22:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "steven.sistare@oracle.com" <steven.sistare@oracle.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH] vfio/pci: Recover sub-page BAR size when base address is
 not aligned
Thread-Topic: [PATCH] vfio/pci: Recover sub-page BAR size when base address is
 not aligned
Thread-Index: AQHcHB/zipcVbt0doEmDwzVAjMlKnLSCrd2g
Date: Thu, 4 Sep 2025 08:22:33 +0000
Message-ID: <IA3PR11MB913691FA2E2EE7C457B623549200A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250715065952.213057-1-zhenzhong.duan@intel.com>
 <20250902094002.20842f39.alex.williamson@redhat.com>
In-Reply-To: <20250902094002.20842f39.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM6PR11MB4593:EE_
x-ms-office365-filtering-correlation-id: 28f2abbf-5bd7-4279-da7d-08ddeb8c3285
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Gw69NGoxPWZ2AwbTXMl2RCTkEBt4WJGXQzqDt5+ugGTGPooWbMnsc5DEMdrU?=
 =?us-ascii?Q?f8T0RqUZJJdwAec71PPybUqVCyjY8LmL/DoU7x5c3CjPDB9DLd5yqluneu7z?=
 =?us-ascii?Q?9gnDQALiCe8Z9MsyWeiRZ25NUhvg8dYWwXYe6lvuA1t8D2+c2coikGctQ7nj?=
 =?us-ascii?Q?bBr4+1bmQGyfaPi4xfJij9AiTOShPl90d9f1qg/637vStOCffoOvPk4c55+A?=
 =?us-ascii?Q?BHz15fIhBgroYjEnf9YNmcDhaZkuGsK0GGN2Y7rOxGAT7JavdaICFKPCScsf?=
 =?us-ascii?Q?8vIO+JrYvp6B8riLcaWkUEC/ttHmJOW+LMrcEOoSjFmwerVVQoUMjXPqNoQB?=
 =?us-ascii?Q?qCEg0sfiWNJJ+t8rGFfBRwbW463LqV8npZ6ZDy0PCn0AwJ8sWhGNg983KgDO?=
 =?us-ascii?Q?UGmvX/1S9vlHlw30QoQbTkDcqAHWgbuvD8PVJSCH1VEZ1WD6isb+p0DlLWFA?=
 =?us-ascii?Q?PddFP9pG6R/9VPZdNVksLVbCjddn7LnnbR8rZsdP7h69a3DWcx1yihlsxd0k?=
 =?us-ascii?Q?2ljykbs7Eh9ZTpecTDcfX9dPBrxBVqmgRFMZFWcF4hIDFbxdfZtjcMBNBLDj?=
 =?us-ascii?Q?oI7tO3BZOlS2x7Z7IAXKHLijFinYNTslBWZl2BTBooFfR0BUyTzqBHIDaz5d?=
 =?us-ascii?Q?i4l1t1Lag94+AW7PJIETSaQbmqnRz/dmn8f81R++4Ziuqd5ZP7wCqNwRyHo3?=
 =?us-ascii?Q?eSJIze+r1amocR06TLapaH46dRFGJafsK/KTsaiVEngalZRvEBZc0cY1qVPu?=
 =?us-ascii?Q?9Gj+5JgaoZ9wcr3lemZpjKSuqTkr1u1FO/qatsiTDtZxQCy+k6jbsIzUPX37?=
 =?us-ascii?Q?fWOFWG4GA0qd0K8kSLevYCFUwIWnO2bUFswD6/PBMzkwTdqs0k8ajZ7vxZxK?=
 =?us-ascii?Q?LUujJjJvfOZnJ0dUwUFmN4lUoRmYrxhJgCu/kfhedurIcR3Q2EZUR8wS3ngj?=
 =?us-ascii?Q?BD9qfz0gJgKTa6qfUrRX+jQ1OBT3Tc/xrYpQLiYJPWMIVfZBSQQbK9fdZWaT?=
 =?us-ascii?Q?Mob9/gMXfGo75xX7kvZGIlXUis9CB2kZF64h5bTCbF9lPrzuCFnyc/rxpuGl?=
 =?us-ascii?Q?3E2ZlZZvkGDIXBCj3lJfhm+Voltg9YGW0ZtZyiHlCZskLhTvyOPUmCLP45qq?=
 =?us-ascii?Q?IUCwPnOz8WngDeeaXogLEZg9qnh0ocAQwzWzbQVYwPc4c86uxoaEyBddoCv9?=
 =?us-ascii?Q?L8yKARIHpB0aVHJEzSlCNh+f4HZQdrlBdEYXIRi166i8pPupF/PPFmeWbfsB?=
 =?us-ascii?Q?YK7AborP8CIUzeNlVeo9T1+7cWscs6LQFI5R/M7vsAoaZNssbFgMKE1m1TKS?=
 =?us-ascii?Q?qAQuSTHX6z3uTuIRxjPR1J44RUxzU8MGVhcdhSZUCjuURrutIO3MTm9mozJu?=
 =?us-ascii?Q?MzM40wIxkyOQME6742Qvxa0/aqBelEvSuV0kD6fW00uz+reZjYoA83qCZYb9?=
 =?us-ascii?Q?2YnJ5ikNPCeSS/Ske3suhg8ebwnb4jsKMgSdy+YpUe9YLgWJp1ufvA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fYldKDzkD5QYqP2tVWoJ3VdvzszXmSlxqca64kEJqtNjNjD7MVZITH7zpNKn?=
 =?us-ascii?Q?+tC35TywX8zLjy0VC7jmHdzA5zMZhkpHd4TLQ7cqDLICg/ukluHgCkGk+ruA?=
 =?us-ascii?Q?yob1ZBQ+1u4qpNZ/JPUhvMNHTriNXgVyb35OwJH9UFp9qRCOq84qELGXKLd6?=
 =?us-ascii?Q?xGDGqLS8LwJPJYnw0i9sJEk+ojfD1ykueZOnMrOGTIF1QdQNskLFIp87pwxt?=
 =?us-ascii?Q?qJYOlDEc5NqsfUY8+3VfTGnjG+6zi0MJykpFapHZqbHDVmcKXI5ww7543CZV?=
 =?us-ascii?Q?63e5Lml0B6mIyaBb0SgSlxJs7dysdyqVrNCR/08ZG5BPVijU0YdTpZ3x+55K?=
 =?us-ascii?Q?z4+oIX9y2TRufabpCpoCAynlyDmKMIsX5CDl8fsfOM3EEh3kDKerLQf7kiAa?=
 =?us-ascii?Q?KLhwA1JBCDOYlob7MpHtBTYm/+0W9VaiRWO6WtINCbuRY1/KheuY12ONeO9p?=
 =?us-ascii?Q?ip+pnGY6uSBi4wkVuOHQyipxVkZp3ovJGaqWWirEsc7kr1tyNxZaAMXzmrLG?=
 =?us-ascii?Q?j7F/0d4cwPjpaHQq+aoITS+06r/2vklnFRK1oKtIRtIF6x4MS3Ufm5KajWZK?=
 =?us-ascii?Q?KByR9aFHSMjwiQZ7JmUA9LEMVJ1c2gL1779bDSiQpzpTMvTonxpNYHxxiYHa?=
 =?us-ascii?Q?2Kq4tkkDDNfK/VXCIFVOnk1ceOSL6T/b4XK0G8X7FLNaTktZbsW59572Ystx?=
 =?us-ascii?Q?+YvAIwlOGuomO4zWsTIbSDIyVNMbRCqsw4yNu38rv5wKFo5XNWlIPtFvt2Ys?=
 =?us-ascii?Q?9o9qNJQ04Y7edPi1KKg39NWcNd8RZ6vBLmRrcSx0DK9JhjvIaOm+/ViJZa4X?=
 =?us-ascii?Q?hwNtBqdmWAO0VCeoeGRIjIS1v9S+9duvxtOCt/gu0utoM3al2TOK/nKMjqSL?=
 =?us-ascii?Q?Ws8JRDO50zkebr4xjm4H+/amambqeCT82ET3CSV+BfF73LbBe+V/5E7cXJk0?=
 =?us-ascii?Q?BM50Ie4w0wtpycdD2pDffL3lPd+sFASeZzUbBIPC0o2rHmUdZlmpAUghEIRv?=
 =?us-ascii?Q?CyKslGV1wwyncFg364t8o7Eov4gxfBRjQU7+OrUpULhPxWI5RYnjN+m4pUXh?=
 =?us-ascii?Q?bDWgdhlXTnFcV/DQQLsxCdHFKJlltmi/IrlKZxn8uiW464xNDAtwShNDnnT8?=
 =?us-ascii?Q?uQVRNo9MaR41pR5lDjnJNlaIRT38562OJxM9b/0tOELcK+ZNsq9KD6GyZ6O2?=
 =?us-ascii?Q?mi+N5cgYhph0/gJNHyx3jbRLpqFg9iTE9J4sx+XBeo8mQcvseTlEcZ5ZymrJ?=
 =?us-ascii?Q?R6sFDer0lTR12xd6KNcggBY3KOgA1Rpx7o8H95LN/Y03gutxnSzAZPChKbYP?=
 =?us-ascii?Q?tyWMIivTcRXeB2yhteVhqHaczjxhesw51Zh5S8zGGjvPfl3I7I27w8QHWksP?=
 =?us-ascii?Q?rcbVDB0JemSabco4ogtfOex+ZC/nfTUTeFDqqhQeRbjyaMcAcO4eljMbGxvr?=
 =?us-ascii?Q?RvVcG0PIfrCIU7iCZX3rPA/lwWL0SzbVByNCNSTHxyJDEsPUJIMxUoM93dYH?=
 =?us-ascii?Q?ZL0zF/m9hRp4MyfiLhTHK1VCqRuLr6Lk6TzSqGN7nc2zHRWyhXGb/gvQNwel?=
 =?us-ascii?Q?qvKBd7yNG6VGDrueuIZWGYe6bVrQfKPw5Zpyt9Z9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f2abbf-5bd7-4279-da7d-08ddeb8c3285
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 08:22:33.1984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1pRpLdcSELp0lC6teHpUPB3hVToiK+eb0BQQsEa6Bp/ZJOWtS27fdB1YtoYXoEQH5OCRP56KBoKm8Qo1kk+5knYrw+4IKfrQ5qBo5lXjhi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4593
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
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



>-----Original Message-----
>From: Alex Williamson <alex.williamson@redhat.com>
>Subject: Re: [PATCH] vfio/pci: Recover sub-page BAR size when base address
>is not aligned
>
>On Tue, 15 Jul 2025 02:59:52 -0400
>Zhenzhong Duan <zhenzhong.duan@intel.com> wrote:
>
>> Currently region_mr and mmap_mr size are recovered to original size when
>> base address is updated to non-PAGE_SIZE aligned, but still leave base_m=
r
>> with PAGE_SIZE size. This is harmless as base_mr is a only container but
>> still a bit confusing when executing hmp command mtree.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  hw/vfio/pci.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 1093b28df7..0455e6ce30 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -1348,9 +1348,7 @@ static void
>vfio_sub_page_bar_update_mapping(PCIDevice *pdev, int bar)
>>
>>      memory_region_transaction_begin();
>>
>> -    if (vdev->bars[bar].size < size) {
>> -        memory_region_set_size(base_mr, size);
>> -    }
>> +    memory_region_set_size(base_mr, size);
>>      memory_region_set_size(region_mr, size);
>>      memory_region_set_size(mmap_mr, size);
>>      if (size !=3D vdev->bars[bar].size &&
>memory_region_is_mapped(base_mr)) {
>
>Has this been tested with MSI-X relocation to the sub-page BAR?  The
>lowest level MR here is meant to fill the gaps not backed by other MRs,
>for example between the region MR and the MSI-X emulation MR.  We call
>this function based on the region size, not the BAR size.  For example I
>think if we had a 4K host, 2K BAR, and >2K MSI-X table, bars[bar].size
>might be 8K, with the MSI-X table offset at 4K.  We'd want the
>underlying container BAR MR to cover the full 8K, not just the 4K that
>we're expanding the region access to.  OTOH, if host page size were
>64K, then we would want to expand the base MR to page size.

Oh, I see, my patch may lead to truncation of relocated MSI-X region if it =
is relocated to sub-page BAR, that's not correct, thanks Alex!

>
>I think that's the original reason this is conditional, but maybe you
>could share the confusing mtree output and provide any comments
>relative to the scenario above.  Thanks,

Sorry, I don't have a device with sub-page BAR and a guest kernel writing a=
 non-PAGE_SIZE base  addr. I made this patch by code inspecting.

BRs,
Zhenzhong

