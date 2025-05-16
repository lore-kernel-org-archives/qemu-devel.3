Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49B6C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqf6-0005X0-1L; Fri, 16 May 2025 04:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFqf3-0005Wh-Pg
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:43:21 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFqf2-0006Sf-0g
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747385000; x=1778921000;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZqWKKVCzPjuSgQ1x53vQismFfkgALKQnxMx765h0urg=;
 b=k40qdCOBYUtgNHb0tXHDmZ1Jz5v21aLpemUOMyLUByEaq4gXhUJxbYbj
 tRalOcS05Bvya1SzKQicw2plUdkJh9E3IkeFYqFvdy34PO6Ev0oq7j9MS
 XtXK6ml8tmMyQM5xtJLuni7k8iIPwIg5scUb+ERaiiskiFswRAbPSC9yX
 fmI/bSrIS2ZtESun26z4MMqvTu1/l25mRyisU4tqiUzaGAjBsAYd6w3vX
 gHKguKNhWj1EhT8puDyTBHl8kFrTJ/sGHoZbXg6IL2+51L464barWJ9OM
 S2AwmYCKvlCPc5dmtWrkCNAO+7x7BAHzaYAE5Awfoc3+FhDuyaO+n4nMs A==;
X-CSE-ConnectionGUID: yy4BzpK/RVKuas4wyaJ0gg==
X-CSE-MsgGUID: FJSI0IY0RkamhLXKDz0H2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49045310"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="49045310"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 01:43:18 -0700
X-CSE-ConnectionGUID: oAVcoFWRRPC0/iWvpH6n4w==
X-CSE-MsgGUID: lX/jvHRSSmOVmmpcN8dSaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="169688054"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 01:43:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 01:43:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 01:43:17 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 01:43:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcftGhjgmWb37uoEK5oIufLNo5RQqXTpjEpo14/O1G+FOWjnh0q/cHEc8a0gk6lJEKfJSB0eaKWvXAUO1LX1zyxvjFyFoVBS5oQtCIQG41MvpvC3izrwhP3Bd1QMnKpHkHIwp5Ex2PM9MS3c/mXRzXYQBYNFzGn0VwJ2B+Hhn3jN6egwvkXNto566N5JAyf16cR8bXjeMUYfm+60E+KBBupS0N1n1+f0QyKlA+5y4Swo+Q2cuvHM9tsRkESiIKWejYfSExEM4Btwxcgx325bla23Saeu+5DJWyCTPI7G/ezoTh80QjkUMMSXVGEUDxoD6538eAlo/M3CIbj6mcF1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4HhXSpHKQacaoSB9H89/uV1zXBtyfR9qXEbTCQshyM=;
 b=FExbzDwQjZ6jwclQGadHJNQoqrSC+cOYmhXgX5YIcnWSayusNHxmfngx7dAxqX3W3znqv3WzmOwhtTf70W3L49htyj/xda2dsOAoESUAcdYh/rZHDx41YHn60aZw4ajOBBaC+ZziT3nAy9twMTRW+6tFfDXEwKO9Kt5EPNg8OERSPM+x7gZTRea40Fy+DOMRT29nc1d1p5PR0VFUnQpwT/oq0AY7hnOQVmOq59WRLLV4VK2kW3O8wyx/CLH8gSo7sVkkxQh5JioCxHFar4ml4e/ujnX5jPvXxoFP9u/lq8lM9RA1MnkqPidfZX4Vw96GDPJ09pGzQWSeguRmnpjI/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Fri, 16 May
 2025 08:42:59 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 08:42:59 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 29/42] backends/iommufd: change process ioctl
Thread-Topic: [PATCH V3 29/42] backends/iommufd: change process ioctl
Thread-Index: AQHbw1yUpeYjtdu/DU2o3xTJaAJiQbPU9flw
Date: Fri, 16 May 2025 08:42:58 +0000
Message-ID: <SJ0PR11MB6744C9B04AE39DE76904CAEE9293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-30-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1747063973-124548-30-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5769:EE_
x-ms-office365-filtering-correlation-id: 37b89764-3f01-4b04-4cdb-08dd9455a950
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8JsSgdpIKn9ph5d2EcjtTfM1YB7DVVtmuxShaI6EzWox6Ek2n1h1qMmxB9QR?=
 =?us-ascii?Q?HegIkScNU5f2d/gV4pVMxvzu+bMRlOlrbyRKAMvGzKNXT/lTfHUpT2GVQF1w?=
 =?us-ascii?Q?kcsPskRNK8K8SkffF+CD6pu6gy7nz97dANfagQZXwtvnV+kPo/O/nguOxDyM?=
 =?us-ascii?Q?S7NA65zvqp9uO9r5zcgNY01A5g1Ysj5E03OweAw3O2R2wlqMnYhg8c8gATV+?=
 =?us-ascii?Q?a3uu3ed/Ngf1wHn/jNsuLLuUmhd7KisRyl8saMt/p1wMY9opNgmvWYRwEgIn?=
 =?us-ascii?Q?wm+hZoiIWrqUyJQo+IriPr44vccLKNDEFOnivpGRs8gEcFj3OezzD6yPYc/N?=
 =?us-ascii?Q?RmUwk3kRGuMETnyb3NQkSEEnGNW8OsNy34clF8UD6oOvxKrsbrqIXPYjASqD?=
 =?us-ascii?Q?L4vPwm+Tle9LYmK6ST0GekoeCClfQ2F94k7Cj49n/K2KjFt9hbk+yX9JZNQg?=
 =?us-ascii?Q?AqY0uP3N3a4Hu93wBA3n0S2bKB4gKpQxmAZOHZm7pa9S5F3aVNOKB9sUIB9K?=
 =?us-ascii?Q?mKM7buBPucALAwUy/dkolfVgXEZkB5V23fBv3VzbaE4gkNUNS+cTsy2yaX3G?=
 =?us-ascii?Q?N1EV1KtgLUFarmCUi/B1yrtfSwVo2c5jjsoB5ybyEWBTrJFtawtEAtAXiQw6?=
 =?us-ascii?Q?t5YdcBOlHlNNQ3fL3S1F5C5aBNTrw/YSKgFY8xQ2tBmcjxXrV/f2OCUhWywc?=
 =?us-ascii?Q?ia8iTr/D9Mjge42GjiyXsX2ys+S5NN+2Dcy0mHkv392kHaRSNmPjXxsL0qWa?=
 =?us-ascii?Q?1vJP4872u3VOWMx1XHbe2NlPxC53uDpAFa4AMPv7IGPsDOdjRZS7LuFJPM67?=
 =?us-ascii?Q?QxEdUwTisfACihyDxeKAe1oS0Rkj7xKE1OaxTVsz2uonGVFERPON3T+iHrsw?=
 =?us-ascii?Q?GQUQ91RTQ7Q0B6jWA2wAoosUm2KIlYQikiaYZIT7lc+k8uBFWyLICsVdGqxb?=
 =?us-ascii?Q?04zbmouDCJKfBeElAIQfNS9qNkjlAl0nSrq6dZGyQsBoHiY1wMHgd/HKP+yu?=
 =?us-ascii?Q?KqLBrzEhuk3a+fgSaIxJi0VQXoSYwarnVM9iMSWmPSj4tNS17t/6hCve0pO2?=
 =?us-ascii?Q?ZM1Ks+4npaY37fOdMfqTbKJHV3Tt/MGUx7jg+AuevE7+oXWO2lE1ZLPeMsV0?=
 =?us-ascii?Q?g/7Tr6GDHw6xiIISLGAq3R2C4rurThdswNeIo5zdgl2W6P1v9dIGjJUd8VYZ?=
 =?us-ascii?Q?9tHFQ0UEGuaZCanPY0IKSOd1Uwgwzv+Da0yrKqGtv5TNNxvXfnQitV8GZB6d?=
 =?us-ascii?Q?sPNWzZx1cC44b7eXzx01TKCdz9juifgH4yOfSbPVZDNvLxcBzbvRGvk0aM4x?=
 =?us-ascii?Q?5nRZdYi1rrZQXNa5TVgFs5qjqwcBpRxaMZdv8h9FbJDPLGBHOn/u8gxUi4Eo?=
 =?us-ascii?Q?bjGRX/8iqLuJQ3NEnr8PILXgEUzgfC/4LlqPRL2FbHYsqEoXRmndCII5+ksZ?=
 =?us-ascii?Q?tMNP65CB97ruKkAK5T0ELPFxRbgvb56yCvT4p2c76wTR99CWZZab3A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C2AssNlNIkdaong0/QP6F5oZ8uFdfWLxexon0ds9COpWBeaXWs73jazYDT+G?=
 =?us-ascii?Q?7HD0XD0KjU+R6OUGNQkuRJNOrU6eAXmQ5HZawK/2r1ipvUO/APye5BUxzrMs?=
 =?us-ascii?Q?rGtiREEaTJmlbfxriE4kKfHXE3dF3Xht3JH+/Yxx0QoCuwHX6bBkbm/yuVc5?=
 =?us-ascii?Q?Q/ay7DrPrczLL9qpPSd2R0QeK2AF//4U6jEj5QlcBXoPSCwsxwXVMKv8VZ4D?=
 =?us-ascii?Q?tthCqk3EBLI65uGsRr5QkPsE4BjS9p4oxzDyWSOxH8s03vIQe3ThbXMQO6Dh?=
 =?us-ascii?Q?aRw4F0iO43hyc2Fzv/68fhJo1AIWoNmK4AG0/46LaTf3r/sQYGXDv73MX0gC?=
 =?us-ascii?Q?INQ7AD4tYV9E8cMY/oJvzUDulnQ04mlXC9xlWaYREr38rQN9CtXvXsBp45n9?=
 =?us-ascii?Q?bL15tt6abECzcKOn8hBJqeolDzi//ICWxQOC5NfroFfpp4ORKaPwbpdZS7kN?=
 =?us-ascii?Q?cDE5hLGJU671sRGZlh/d687gxxJYDiwYcOOX2M1GyM+Y/c4FE6PWU6dkXeqw?=
 =?us-ascii?Q?D9GAmTomBp+kz4LvjpUb2SEoOUexjQ3nKDr8nfiATEq/rVpwT2NHNdX//1/h?=
 =?us-ascii?Q?P4rKN9e9qM4pY4UCo4LJoztI1nTlR2S14sHi3oDby3795EOuqwAHcc1ZbNsK?=
 =?us-ascii?Q?3KQfn3A+5mrhhJjuUeFlHv6+nkYN/TyVuEGT8gl2UUFwrBqiQrPjqtjuBWKa?=
 =?us-ascii?Q?F/p4LHA4vk4300HSBWj41S8YTUBFnq27WaPGp5jlP1WTv5CMKOHTy8tRUX9m?=
 =?us-ascii?Q?2bOm2uazKOg7YxQ0o50sq8xpoYO2rm/Iq0Y7WfdUHt5AMNl8y2ZMJOWqU+3c?=
 =?us-ascii?Q?1R+tsNW3fu7D/CIypnsbL0VWdaPCtNmYSvlAIN3S6Siz8tPw0RqO8fL3PPtL?=
 =?us-ascii?Q?ejEarmPIysCnpG20f9Xlng6a7Z/DacG9D09Q9GoUCm0zfWxEu0JPN7VO/hxl?=
 =?us-ascii?Q?4zU6Z0CrzoQPGKk3BUPK3pIGygUxaeaDwwrjuggFXNFttG8LQbs7Ij5StUol?=
 =?us-ascii?Q?vKlPwY5pqqWKiz8AWE8xVCzn1vcpusCwfTcWBJc/+sX0SOFDu7JP3I5ijXfE?=
 =?us-ascii?Q?P0Qh90asNVCa5HN4mT8OL1fRCMn93BKR79zbkJuEA0txItO+9WrpkkIZQBpE?=
 =?us-ascii?Q?O8ytQXtNULWywQYBca+kSEpu/ayZiTTiQ3Dbi3pYkdpNJ/2FPpZUeilTkhBs?=
 =?us-ascii?Q?wut2eCHrpO7OWhF5eLCUzwOTKg5eeGbu8kOdV2jiq0cSBNao6uEYov4ha1ur?=
 =?us-ascii?Q?k5NkahX0JWGqYT/vPqsDcdgrpIumxAEEDzhnwA79DJ1m42bgqCr+YnZvl02k?=
 =?us-ascii?Q?/I6MawVacZva8/3qpQ4RNNnyPV3+N4HQ74d8Db2QRu5HkeU8JyYiozPkFuWM?=
 =?us-ascii?Q?YbuBMJ2xic/1/+gmzR3qnu09h3ipHG2TeNOg3JWsQlghQpJz/mepqUxpmvNV?=
 =?us-ascii?Q?xtHlfyuk6a5wBhSWqUVu3ckvZ38Pmo13riXWIp9lh6XlDG8u1pKIzyicMMd8?=
 =?us-ascii?Q?Hz6/Cd8++Ggx5eLU/rKArbnb9ArSahv08X6D3f0h9zQGm55jbU9YarSrkqLO?=
 =?us-ascii?Q?voZssljCOtCvUnaWoYFvsdOzL+Vt4RofsiBozffc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b89764-3f01-4b04-4cdb-08dd9455a950
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 08:42:58.9683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q9FnaORaUVZcG0GdTTeFPZ2SZfnyMCGs7ZrPIgxXYBcxfltmg3iscnbu/svU7hGm73tkCeBVVKAHdpV8dUOi5a8J9gSxEB74lSIRG4lFI9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5769
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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
>From: Steve Sistare <steven.sistare@oracle.com>
>Subject: [PATCH V3 29/42] backends/iommufd: change process ioctl
>
>Define the change process ioctl
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> backends/iommufd.c       | 20 ++++++++++++++++++++
> backends/trace-events    |  1 +
> include/system/iommufd.h |  2 ++
> 3 files changed, 23 insertions(+)
>
>diff --git a/backends/iommufd.c b/backends/iommufd.c
>index 5c1958f..6fed1c1 100644
>--- a/backends/iommufd.c
>+++ b/backends/iommufd.c
>@@ -73,6 +73,26 @@ static void iommufd_backend_class_init(ObjectClass *oc,
>const void *data)
>     object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd)=
;
> }
>
>+bool iommufd_change_process_capable(IOMMUFDBackend *be)
>+{
>+    struct iommu_ioas_change_process args =3D {.size =3D sizeof(args)};
>+
>+    return !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
>+}
>+
>+bool iommufd_change_process(IOMMUFDBackend *be, Error **errp)
>+{
>+    struct iommu_ioas_change_process args =3D {.size =3D sizeof(args)};
>+    bool ret =3D !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);

This is same ioctl as above check, could it be called more than once for sa=
me process?

>+
>+    if (!ret) {
>+        error_setg_errno(errp, errno, "IOMMU_IOAS_CHANGE_PROCESS fd %d
>failed",
>+                         be->fd);
>+    }
>+    trace_iommufd_change_process(be->fd, ret);
>+    return ret;
>+}
>+
> bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
> {
>     int fd;
>diff --git a/backends/trace-events b/backends/trace-events
>index f478e18..5ccdf90 100644
>--- a/backends/trace-events
>+++ b/backends/trace-events
>@@ -7,6 +7,7 @@ dbus_vmstate_loading(const char *id) "id: %s"
> dbus_vmstate_saving(const char *id) "id: %s"
>
> # iommufd.c
>+iommufd_change_process(int fd, bool ret) "fd=3D%d (%d)"
> iommufd_backend_connect(int fd, bool owned, uint32_t users) "fd=3D%d
>owned=3D%d users=3D%d"
> iommufd_backend_disconnect(int fd, uint32_t users) "fd=3D%d users=3D%d"
> iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=3D%d"
>diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>index ac700b8..db9ed53 100644
>--- a/include/system/iommufd.h
>+++ b/include/system/iommufd.h
>@@ -64,6 +64,8 @@ bool
>iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                       uint64_t iova, ram_addr_t size,
>                                       uint64_t page_size, uint64_t *data,
>                                       Error **errp);
>+bool iommufd_change_process_capable(IOMMUFDBackend *be);
>+bool iommufd_change_process(IOMMUFDBackend *be, Error **errp);
>
> #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE
>"-iommufd"
> #endif
>--
>1.8.3.1


