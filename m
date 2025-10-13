Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B63CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 06:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8CMl-0006z3-LR; Mon, 13 Oct 2025 02:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8CMj-0006yp-L9
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:49:05 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v8CMf-00010E-8I
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 02:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760338141; x=1791874141;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FZz7Sp3Ehdtt0vypFJgJO31Vd7RCs4X5PzlvE0UeShg=;
 b=GVrjYYleFKqDd0SquwItl1pJ8VgrqSEcSm25pJHjqtLf4LpuO2w1oBiQ
 eHazGYzU4C3KOZWaZkWPcNmziFp6B9euiz02tKYREB69cSmDGEy8PQi2P
 KbfxVzn+h6Rla2K1dOVA5ygfNh6+qXjR2BHM0U9gQ4WkUpUlqgU7PRP8R
 Ux1/xGCDNwfimCt6Y9K2VskSRnHImHX4P0oYmTOadCsPrO0iGt5GmHrG3
 lcG4fzZXsMjJvBqZNU1zUIWzgTAPBo+wzHEIZfKjdsboOqgPnedE67IIJ
 CiexpIK/Ug2yX6BzKhApGbyUFC9TEVzuxWaJGMoYYd4IliPPWfm1ld7L1 A==;
X-CSE-ConnectionGUID: i48zUXp3Q7GNJhOqCZI2KQ==
X-CSE-MsgGUID: SZOxMAZEQqaxhFfTUiasXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="62359524"
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="62359524"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 23:48:56 -0700
X-CSE-ConnectionGUID: C7lebo8USvmK1GXoQmSTIA==
X-CSE-MsgGUID: LlIMkU65QBm/eHaQOIYmvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,224,1754982000"; d="scan'208";a="181199862"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 23:48:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 23:48:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 12 Oct 2025 23:48:55 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.49) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 23:48:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xw3xvRjrTmwJI1efMs88r/XwmGVHu72dxyuN2CWg5biEmfvZwd5nkGQk8mkYBLaQxjZYfu1X3iVm4lSDcLJI7GyGd5ooaZyT8MeZ3N41td2hbm9rAFn6nmjOsmWBERyFr3AqjWSHSO9SDZYYcYdnzCj1HUeAXDR+4I43W8eUlVo8arjOB4mcXWOqzBFeK96+HS6pl8BzNcV/F8hwA0yRuIq8APnv/5DsAFNeiMGHNfSLKQM4SxVzwL4t4nxOtppfQdSaaidVP/q+vmhapRHx+RjQ78F2MseaKfVVfBzQIzd5gW/GUVsVzi7+waJbaksktahcBTTwDWQJApvTHE6Ikw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZz7Sp3Ehdtt0vypFJgJO31Vd7RCs4X5PzlvE0UeShg=;
 b=b+o8H7/DsLIFJTd74hK+iXaEvyvSpgbKzY60xlzS9FGy8nb3WD5GYVud9wTxqm37I0jFbiyT01Vk95AeN0mwx9wXNm5MZLvvpbkfcMHrjgHTHMzcY6qT1NQCalr2tv4taKIfxAs2QV4k2QtqS8sh7hZM4N3EDNxjbqa5P08N9cpHG5yHBfCAj3YSWvRHeftw/bbrFtmvaj5lTfB86Hncx1CZ8rFIZKB67F2Lycta36Xfxb38H//BEF4LmefP0Sixp1P9Fj5UCEYnbRZXttGd1rKy5qrzUF+jjRAnVO+IHADoCO8JgX4sJGcOLQeZMUK6X6cIb3w94Kj7lxhcKar9VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM3PR11MB8672.namprd11.prod.outlook.com (2603:10b6:0:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 06:48:48 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:48:47 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 10/22] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Topic: [PATCH v6 10/22] intel_iommu: Check for compatibility with
 IOMMUFD backed device when x-flts=on
Thread-Index: AQHcKHqHVWj7BS9UhUe+Y5lhcGt+H7S+ne6AgAEroMA=
Date: Mon, 13 Oct 2025 06:48:47 +0000
Message-ID: <IA3PR11MB913625B60DD74FF68324EA9392EAA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-11-zhenzhong.duan@intel.com>
 <3b920606-8550-481f-8f96-77d0605d2684@intel.com>
In-Reply-To: <3b920606-8550-481f-8f96-77d0605d2684@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM3PR11MB8672:EE_
x-ms-office365-filtering-correlation-id: 61a5b9fe-3915-4771-2c33-08de0a248f93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?MlhOSjlURXJBa01qRGNMMUVQT1ZJOE42SDgxTmp4Kzh3bkVrVE0vdytOTmNh?=
 =?utf-8?B?RzZQWktyMVVEVEZYdmFSMndKVXBra0Iza3RxVlVhUGZkWk5XWlVacGwyV2Vh?=
 =?utf-8?B?WTdDNDQvdWtWL0prVFh6TW4vUnh4TWVrSkZRREdaT2ZkZTdCZFJ5am1kTFN4?=
 =?utf-8?B?b01meW93d0lWWDh1aE1nQmRGNW1la1BKL1dOdmRZbGhraDg5TCtqQUY2M2l2?=
 =?utf-8?B?YUR5NWFtb3pjZUZGaVNPQkdHaWtYRmZEYytSM2c4cmtsZFNOU1ZFSG9rL20x?=
 =?utf-8?B?M0ZHTG5oQjR0TXRGR2VHUmw0NGU3dWo5TUQ5WGhsY21wSUZpeHdVOTExRHhu?=
 =?utf-8?B?S0hIbTJkMWhwdVRpRGhVV2YycnpDem1Ja0Evckhrc25oTlJWa3FtbDZkTUJN?=
 =?utf-8?B?QjdIa1NRQjAvNXExd1gxeWR5SG9EbTgzaEgwWEFhKzduSnIvNzEyWTJFNlNk?=
 =?utf-8?B?cXJXb0NKemhNVmpyWTdhT01Qc3ZPSVA1cWJlVmVSVE4yR282YWYwVmNJeEJ2?=
 =?utf-8?B?ZjJCNDFQYUw3cDNqajFqUEVMWXdJK2JPRG5nK01aSzFXblJ0N3RzZnp4em1p?=
 =?utf-8?B?MHhZeENyZ1oweWtoSEM2NkFxb250WklzajFEOE1velV6aFhBdVl5enZLd1Jx?=
 =?utf-8?B?WWxseFpCKy84VnZWLzhTV2VRMTBDYWNOa0U2Tk5vZFBxd2dTdkg1WkJlQ2Zm?=
 =?utf-8?B?MzdOOUl2a25sbGNwb3lNWDF1NUFmeUQ4TkFVcmhjYlNpRjJyKzdHeUF2dVhI?=
 =?utf-8?B?ZUNWUlhBMmw1dzhmd2tidWhBUnpJdUdJMjlrZEtNR0xCUS9uZGlSS0dqcGVW?=
 =?utf-8?B?QzRNMC9zRk5uWGtYT1N0MGk0b0VXVUlxakFhZU1uazRjU2h2Z2ZZVWtHVjRh?=
 =?utf-8?B?NmJUc1FvZFp3VG41NTNEbHRZbEFybmxxUUR2OC9EckM1ZG1PaVV3VTYrYTJQ?=
 =?utf-8?B?aG1jc3FjUzNyN1RmcEtEN0Q5TWdHQzcxNHNhZUhWOVZacTVsZWYzaXpvRmxx?=
 =?utf-8?B?eVRPT0daQzF3TUxaY2lOMTZvWGxMY1dKV0J1OFMvVGFoaEs1SHlTdi8rbDBS?=
 =?utf-8?B?c0p4cmZQTThRcno0UzBjVHo5UTNac3JKREpBOXJGU2dpRzlLQW1aVWdLYUpz?=
 =?utf-8?B?VzRMR2psMmx3WEF6WkRja0tJd255UWdLUml6a2hFaG5RdHN1czZUQ1pVZG9W?=
 =?utf-8?B?Y1liNUhmcndxLy9NcmxzL0I2U0wwUVRMelRjQlJ5MFk5dmxCYW5sS0dQSHlC?=
 =?utf-8?B?WjhsUFRsMjkwczk5ZzMrSDJpM201cmdqNFRnWXJ0eHhxTk05SHJOc3lDMmJ1?=
 =?utf-8?B?M2FRNzF5c3pncE85Q20vYXZpMU8zemQxNkNneDBIRUYxeHYwYzVYdS9UZUx2?=
 =?utf-8?B?Y2pIYUFvWE50U0RwZXgvcGV3SUJxdUJiazc1WlBpRzBrQzhwZFk1bzJjbTc0?=
 =?utf-8?B?endKdW1IcmVsOFZXM0xVbHFCSEE0ZWlpRzRUaHBneThoTjlEcFdmZHJ3WEt4?=
 =?utf-8?B?MktwbUZzcFdGRHVRYVJldnZOU2hCeVJ2TGs1bUtiMDNhTnpUckl1bW1icFdm?=
 =?utf-8?B?N1hKWWRUTXRGKy9kb2hkSDJvWm9FOWxJLzJpWlhUZDBIaSt4ZVZBaXk2NWlD?=
 =?utf-8?B?SlJGaXBJOUJFci9QWFpoMjNJUjZUU1NGRVg0MGU5cDVaenhrdHpJNlN5YjI5?=
 =?utf-8?B?aURkMGtUb0g3Z1g2ZkxZazNkNTJMZk4wK3lNTmxHRzk2M3YvaUJWZVN5ejdt?=
 =?utf-8?B?ZGp3aCtLOG9MVlRleXYvbHE2SjZxcGpGVDlJd3VpajZHOGpZWkJNQ0V6c0g4?=
 =?utf-8?B?NTg1STh1enBoejFkcXdaRTZEVEJLejlJbnVjNUdHc292SThNdCtXaDZpbjAz?=
 =?utf-8?B?TkZ3ZDdGL1JLZEVtOG42b054ZnQzYTNOZksvR0xTSHZGTDRBa2tsUHBIVDhr?=
 =?utf-8?B?OEZITHFZQzVKL3QxeUdUNTJId3g3VDE2UTI5OFZqVTVuMmp0MXRrL3JLSmY4?=
 =?utf-8?B?K3kvZmg1TTRMRkFZcGkvQXhYNlhxakxNN2lPM3RkbVBpc1JKOW1PRm9Yazlz?=
 =?utf-8?Q?GZKVTi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHozeEt5cno3MnBXellqSi9rQ2FvejdSTCtGL1YvVlBwelBwZkJzZzZmYUNK?=
 =?utf-8?B?MTFGTmE1REdYbU14M3NVOWJFT1ZsUVg5dkNFUnI3bXVEZjVyOWJEUTlsU25L?=
 =?utf-8?B?MmJLek4xc1ZIdjRralhHUTdFenhIdGFlREpVUmxBbHkyS1U0dC9xem1TZWs4?=
 =?utf-8?B?TjBkRWJnRno0enVlRXUrU2lNMzM1cFU3TlNPVjN2cHR3eUw5dGV1M3A2WXhw?=
 =?utf-8?B?YUl1YkxrS3Jxa3RIMXM3dGhTYlhLQk1jbXhtYUg5LzIrOUQvdkFzRDlPWUdj?=
 =?utf-8?B?VUVJVDA3TmIvUXBMYXRuaWlFNHhxVWh5QWltN1Nhbi96d0l4akoxR1RRUC9T?=
 =?utf-8?B?WlFQckJlb0dVN1piaHhjS0R5eUlva1MzN2d3TTY0VWhvK0F6SGd5alltR3p2?=
 =?utf-8?B?alNOYXVHYzlxS3d3Ti9iN2xQQWVEcTFvZmNOa3d5SU1BUzNXdnM1NlVpRlVx?=
 =?utf-8?B?R1NXQzdUWjhDNmpOYW5nNmJabnF4anRKSVRwMk1vaFRkUkxjc3JrREhpZlNV?=
 =?utf-8?B?UDRDekpueU40ZW1WVHJmMkIwVktGK3lCZUFGalhoU1l4WDdXWEh3OU5BbTNQ?=
 =?utf-8?B?STdyZGg3NCtnODUzbGVLcmszMGo2K0I2U1I5VmNwWlY4dHhRaGlOZkhGWTBK?=
 =?utf-8?B?alVManl3YzRzeVExQlpDMDROYTZZZmY5b2FsMk1nZGwyOGM2ejNIUjZseFZ2?=
 =?utf-8?B?T0JmODV3a2kxNWpMQjN0aWhZdFd5dG0vL280cWxkR3h1MjIrVFJNYTZCV2My?=
 =?utf-8?B?ai9kcFNSTGxxTEhudWkrazMzRkQ3amczcWVMWjl5bERPUklhTWFPNkcrdVND?=
 =?utf-8?B?dTd1Mi9OUE1xNFo0d0RObXNhbHZjUXIrQkVqcloyQ0Eybno0YjJ0aXcrQklr?=
 =?utf-8?B?akF3NXFDSDU1TXplajh0cmY4TnNnU1hBSXJqaUhGVzRzN2RSNmRaTEl2bGl4?=
 =?utf-8?B?MUdVL0FKVHhRV0NyN1ZLN2tIS3ZyR2lVTEdPNjdXNTROWXIyL3dPbUQ4L0RP?=
 =?utf-8?B?anJZLzVZY2Z0OWszOTdZaG1Zem9zSmJEUDlHdk9MTzRhMlQwV3VyZ2NpZGcv?=
 =?utf-8?B?ckQrYzBrVjh1S2NudHZFQUxpUzZJK3VJWWlVWXN2cDhucm9SR0RVd0F5TjFB?=
 =?utf-8?B?TmR3KzFwMXk1TzVHWmpLQWwzUFhXWVNxS3o3RkpsQXg4U3Q3OUhYemZEN0RX?=
 =?utf-8?B?K010ZnJ1WFMrYld5QUpqS3E5VVZBTW9Md0VWY3VnQjBnQmE0akJkMlRMdDl6?=
 =?utf-8?B?K2VBcmgzUkppODRtdmpPL2Mzb0dCMmlZWXMydzJ3NkJ3OER3UzVIUjRVSUZ3?=
 =?utf-8?B?RkZZVERUSzVlYWRvUEFqWlA2bjhyeWZSSXQxbGhaSHVRQjczZCt4NC9DemZC?=
 =?utf-8?B?L2VKOFlNZlMzc0pqam80NWNEeWx2Sy9oSzZmYU5XTXJVeGQwY2xQWWFDNW1j?=
 =?utf-8?B?b2s4REc3eEVuN1NMY0ltWWVLbXltaEpQMnFTRm9WWjUvSFM5MlQxblBsUDdO?=
 =?utf-8?B?RFF4eFR0dVhMekxxKzdBYWoxQ2VKZndURzFvcFlsN1JmZXNLK3dtS28wUXJK?=
 =?utf-8?B?Qk1EN0NqbjZBaVNTTmxHR2NFc3EwSDMvcTZLUitKR21LZGFYQnlhRU5GSXY3?=
 =?utf-8?B?NThrcWR3djF4TXNkQ2hVSERwSnlLQkIvMG5WZ3hrTVR0dFVOcEZWalM1RVpO?=
 =?utf-8?B?aUhrT2pOOFc0NnVBSnVTME5Wd2I5TU5Jb21NN0lITVFveGp2NDlRYjA5S2Jk?=
 =?utf-8?B?SXRnbWovZ1V5OWlYVDdxL2lwd3l3a2JnVjVNK2FTb1J6NHVyQ3F1UHJNS29M?=
 =?utf-8?B?M1Q1elg3bXpYcmQxOURwV2xpenlpRFlvL2FVTksvT0FrUnVzWTJjVU9Bd0ZO?=
 =?utf-8?B?bmwwOG5WcGRhdjJEdEd0V0hqa1EzaG12c0pQd05LQXloTisxUDk2b2pjRWpw?=
 =?utf-8?B?T2VIb3dsV0QvOU5tRUROTUM0L3dUOU5pL2JZOE1xUkxhaGxVNzAvTGg1T0FH?=
 =?utf-8?B?aGJaYnpSZHNEK1lhWDJxN2lpWVRoRHpMQ2djMkpuOVFlOUhEbC9VUXhuOUZR?=
 =?utf-8?B?RGozUmZiWnFPMTFiY1NSUjhnWEE2a1dzYW5XL000eXRSWDNrWXRsOEhKL1NC?=
 =?utf-8?Q?LD5tQngTOqMu6JBiFIbyN9cLo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a5b9fe-3915-4771-2c33-08de0a248f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 06:48:47.6984 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIcD4yVGgUVHzGY473JUU05rSGX5WUgEa/L5HwFUdYR7QaPmDq1f2atu2Uo9csGoF7kWhL5DdfQNrHBBZg8KPNipGkU9/bJpT9bgzN56FgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8672
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMTAvMjJdIGludGVsX2lvbW11
OiBDaGVjayBmb3IgY29tcGF0aWJpbGl0eSB3aXRoDQo+SU9NTVVGRCBiYWNrZWQgZGV2aWNlIHdo
ZW4geC1mbHRzPW9uDQo+DQo+T24gMjAyNS85LzE4IDE2OjU3LCBaaGVuemhvbmcgRHVhbiB3cm90
ZToNCj4+IFdoZW4gdklPTU1VIGlzIGNvbmZpZ3VyZWQgeC1mbHRzPW9uIGluIHNjYWxhYmxlIG1v
ZGUsIGZpcnN0IHN0YWdlIHBhZ2UNCj50YWJsZQ0KPj4gaXMgcGFzc2VkIHRvIGhvc3QgdG8gY29u
c3RydWN0IG5lc3RlZCBwYWdlIHRhYmxlIGZvciBwYXNzdGhyb3VnaCBkZXZpY2VzLg0KPj4NCj4+
IFdlIG5lZWQgdG8gY2hlY2sgY29tcGF0aWJpbGl0eSBvZiBzb21lIGNyaXRpY2FsIElPTU1VIGNh
cGFiaWxpdGllcw0KPmJldHdlZW4NCj4+IHZJT01NVSBhbmQgaG9zdCBJT01NVSB0byBlbnN1cmUg
Z3Vlc3QgZmlyc3Qgc3RhZ2UgcGFnZSB0YWJsZSBjb3VsZCBiZQ0KPnVzZWQgYnkNCj4+IGhvc3Qu
DQo+Pg0KPj4gRm9yIGluc3RhbmNlLCB2SU9NTVUgc3VwcG9ydHMgZmlyc3Qgc3RhZ2UgMUdCIGxh
cmdlIHBhZ2UgbWFwcGluZywgYnV0DQo+aG9zdCBkb2VzDQo+PiBub3QsIHRoZW4gdGhpcyBJT01N
VUZEIGJhY2tlZCBkZXZpY2Ugc2hvdWxkIGZhaWwuDQo+Pg0KPj4gRXZlbiBvZiB0aGUgY2hlY2tz
IHBhc3MsIGZvciBub3cgd2Ugd2lsbGluZ2x5IHJlamVjdCB0aGUgYXNzb2NpYXRpb24gYmVjYXVz
ZQ0KPj4gYWxsIHRoZSBiaXRzIGFyZSBub3QgdGhlcmUgeWV0LCBpdCB3aWxsIGJlIHJlbGF4ZWQg
aW4gdGhlIGVuZCBvZiB0aGlzIHNlcmllcy4NCj4NCj5taWdodCBiZSBnb29kIHRvIG5vdGUgdGhh
dCBuZXN0ZWQgY2FwIGlzIHJlcXVpcmVkIGJ1dCBpdCdzIGFscmVhZHkNCj5jb3ZlcmVkIGluIHRo
ZSBjb3JlLCBzbyB0aGlzIHBhdGNoIGRvZXMgbm90IGNoZWNrIGl0LiBPdGhlcndpc2UsIGl0DQo+
d291bGQgYmUgYSBxdWVzdGlvbiB3aHkgaXQgaXMgbm90IGFkZGVkIHdpdGhvdXQgY2hlY2tpbmcg
cHJldmlvdXMgY29tbWVudHMuDQoNClN1cmUsIHdpbGwgYWRkOg0KDQoiTm90ZSB2SU9NTVUgaGFz
IGV4cG9zZWQgSU9NTVVfSFdQVF9BTExPQ19ORVNUX1BBUkVOVCBmbGFnIHRvIGZvcmNlIFZGSU8g
Y29yZSB0bw0KY3JlYXRlIG5lc3RpbmcgcGFyZW50IEhXUFQsIGlmIGhvc3QgZG9lc24ndCBzdXBw
b3J0IG5lc3RlZCB0cmFuc2xhdGlvbiwgdGhlDQpjcmVhdGlvbiB3aWxsIGZhaWwuIFNvIG5vIG5l
ZWQgdG8gY2hlY2sgbmVzdGVkIGNhcGFiaWxpdHkgaGVyZS4iDQoNClRoYW5rcw0KWmhlbnpob25n
DQo=

