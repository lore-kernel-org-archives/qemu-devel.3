Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1742CEDF022
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 02:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqMgc-0006yr-Pq; Wed, 11 Feb 2026 21:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vqMgb-0006ye-L9
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 21:44:09 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vqMgZ-00063a-AE
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 21:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770864247; x=1802400247;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kW8kP31Bx606C1OgbaEK6WUdp02txPVHMd5ZrOELJi8=;
 b=mh7lnSRjID5Xb3kmmfEbUazsM1CiHBEswNzB8CbmD+Ii5PKGTUE31mkl
 xg0DuUMFRcrvqPFyg/D1KGGX8lAOjFt29yhw6YSIxTcD/D7rnUnHQYVX7
 Og0jysp5Oru+tT8hknxbLjj/8bibxEysawY4dSDPHL6GrtthqTcVRRKcH
 xwl88q+B/3WJxs9pEUxB67uGDJ2vEXopw0wTTUMzd9GkwZK6DhTlCY0d/
 E+MBQn+VgzcDwlPZKGxU9URWJ66+QgGcWqxy05JcryN7bS4GO3gm1+DN2
 POHWIvh8STwkUgE1Ie3VGKqxN5hMY2hI+eB/1T7bK3KJrJVMyKWf+KAvC w==;
X-CSE-ConnectionGUID: M71juzd9Q/iF3QPX7CKQag==
X-CSE-MsgGUID: lyrVphwNT7WWvHLnJMS7BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71935726"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="71935726"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 18:44:02 -0800
X-CSE-ConnectionGUID: lvC9mUARTgyjj2qqGWwlYg==
X-CSE-MsgGUID: wfNzjmmdSomevZBvhXaejQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="250110186"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 18:44:03 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 18:44:01 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 18:44:01 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.20) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 18:44:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMnftu3huESEk1IWNf6mAF74LEUe14B1kV/xpHP9tEqRQ5ujSQj1SlB3kjxW9EPaA/OfM6hIx5pz+5F5HvjoyP2QeN9Y3CJjddreVRwziDCo0sLkUPREa8+5uS1u8gqAqrni0EKoM7BoQYwpTgNmK1FRT4f/OTdk34Ucs25Brv6jxXho4exF1ch2VltyemgIjkXfggzilGGQWszJbxiG2X9bao0R8ZtX/IwxPd1z/2e7h0qN+EZ+YjY4kZOjtmqvfwL2/WkK73o6Psy2EmCWEDrJ8y7t82nsJP7qHdtJlITZGD3JVoma1lpaGWM/d+qKY/sgRpvbNPrm1yGXvJRpcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQ2Fqrz2Wo9zgfs3hU0jRIdJ8sS3S0gAl3C1ckJPly8=;
 b=yVXUqz34IR8nd+ZpjMmzY7WjA+AUwwcR2JynnJt3uLxrxjCPfnAq2GAQ5ODljL76444vxGleHJba0ojjeVuUtJB1tuVuyZVOI7BwzqOz+UtQrPF5wG3JQ5kEiXbWQmcTYMvJXOjF90QOADDZ257OztKkNLrhTVj3M2M4Vyah5AV/zfIz3FPrvPyjjwlcRd6feDlbZ9oghxLV0UsDLgnNwXeimuFpQxc1EWRiXFhVmcNx9ADT5FyD4HZd4wiMbcYSiU+GybHUP0JM9fzH9k1QfwueBn7PZ5MaFuenppHgUgxA35Iq56IyX+7t4sqrrtWRuW8iQv93nR0M6nhsKJf8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB6520.namprd11.prod.outlook.com (2603:10b6:8:d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 02:43:59 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 02:43:59 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Shameer Kolothum Thodi
 <skolothumtho@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach
 callbacks
Thread-Topic: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach
 callbacks
Thread-Index: AQHclk1HGYQZR/NqT0axcOYTjnZUhrV9Qo0AgAAOM0CAAHZtgIAABf4AgACWwDA=
Date: Thu, 12 Feb 2026 02:43:59 +0000
Message-ID: <IA3PR11MB91362AA3967AD60A6B27F95A9260A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-2-zhenzhong.duan@intel.com>
 <CH3PR12MB754856C12CAD98891555C791AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB91367D6A321018EE989FA1899263A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB75482AF23DD73B2D37742AFDAB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aYy+AENRSGdWh0Ij@Asurada-Nvidia>
In-Reply-To: <aYy+AENRSGdWh0Ij@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB6520:EE_
x-ms-office365-filtering-correlation-id: 7ba91738-9e71-475e-4500-08de69e09324
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?iwTLOHMlvf7Q1ZoN1WUx3CLfJ62+JfXbiYjrXAga+6OvTTBTwQEv7p6gMxyp?=
 =?us-ascii?Q?yp1ZEbki5lGTLcn+cni488lM5f5AtCiJtPf0NhkuheMY9JlYreIS2ax16EGn?=
 =?us-ascii?Q?EmQNj8lxwYHBk1BS6oIRv9tPuSDsGLEe6YiHnvIjdNINgqczgsA0UrsKyzHW?=
 =?us-ascii?Q?UrXkCvtZOTAsQsiLYgeyHz4fUmSrMWB9If8apq1/YkTl8PYQ2EsdgtgtFCYB?=
 =?us-ascii?Q?gsioJjQeHi3B5NKMa3hsmTxWmdyenuG4lfxb5WQ8/IZY7ATdprBTsedSvVAP?=
 =?us-ascii?Q?pH2l4qUVsB4heRVQFdxuCFBcHqdRsOpBfn3oujCaMmv/slhcdK6arN5vYs5W?=
 =?us-ascii?Q?1rOMJYCnOTBNWL7/a0YDFWJDERl0VYrlZiZSnCSRZx8lwT8RM2P7BW5vCBfX?=
 =?us-ascii?Q?FFCmuJ1BQhyGmlrMzJlXaU8fiuynQC48wYmBUCmsTAWIHHBxDOGd7UEttc7p?=
 =?us-ascii?Q?EKyQHoC1KhA27wJZrhLT/kYrCLCqo0YFvq+2UTppTcUkRT217BVFhCRlPcLu?=
 =?us-ascii?Q?je6mDe4Va/dKVZl23hzsKI0O3sNknayA1d6GF3GrkMtgSrzmZl+adLBAL5X6?=
 =?us-ascii?Q?vLvFY0kgpQWHNyOBP5lRuh3IYBBngF2E6cSO6I4cwuJuVaQQqmpBEecX3XAU?=
 =?us-ascii?Q?geZE3SxzTzx7nN2xiJ4/fzUCYxyCInJ44/nxX0d2m3+FNe97cs8GddIZ7is+?=
 =?us-ascii?Q?3U6MW//5Rf1W8YPjgQLYrGNeqCvDpLptkpAAyaOAebYiSX2CsfLftSmsJMfx?=
 =?us-ascii?Q?eVFIdDxvYYNIH/qusNMUxkJLR9NBBkbD8/VyawrUJIJENI8n79UZDBrx+Wtb?=
 =?us-ascii?Q?hzRQcRP/Hu/vmcqXYz8hBy094Guy4X2MkUJH9M71h0veudLMXnpAogQViiBn?=
 =?us-ascii?Q?D6yVSWElrz4sEYb7rmjdbnG673RdsX+bIc/XNJCp2dQBTQkbX3i+xSsPih3i?=
 =?us-ascii?Q?wNZ2JzcoE82bBtQgpk4lH/wymsbQVSaEhGEPyZ45PJmeJ3PKDZWl0AWmqrO5?=
 =?us-ascii?Q?lfbc4YJoLWaS8Uouj4q58pkbRVdSgtCYE9W3E3Twb6dajRGq+Hivudff5K1n?=
 =?us-ascii?Q?2pQhLGwmrKuGZeLaTO561MshipokosxXBx4GQQfoqBlMfUKfRQGp3dt4yccQ?=
 =?us-ascii?Q?hUSggtVwJy7ubJ9BuMwkwofY36vXkcKQNoj6Y8HF49HWUOeU+zHwQfK16pZn?=
 =?us-ascii?Q?kyP9AEy4LqskWMRoRaeVOZtDPBvX7ycKXQzhvEzRteW+0QFWaEt08LfBHJpn?=
 =?us-ascii?Q?l+cGWuDa1EVrnTGQZWaaXKRQe4SMUJdW/5+t+esD7hppyd5iTcLfP0N5xCN1?=
 =?us-ascii?Q?5z0gebBkcMqKmyLAP0XVLDMV3ch2SFfMLo7cU3nBcyj5Ja33r92yOKPOyEts?=
 =?us-ascii?Q?jMcTEsx7RLnJaV5iZFuTIrFJYbwRGKA61utbO9dPOtitVtQUt7YiD22wBeIv?=
 =?us-ascii?Q?77jhXDTRumnu1iQGuFBelGBOiVr5TYjqzwt2SQCcd1amJ+Jg8ATljWTL9pMA?=
 =?us-ascii?Q?e5YShGarbGFz1OVvSkUtB20WMn3CD8eYw7E2vH0Hw581uQ+PxdoFEE6JDfjf?=
 =?us-ascii?Q?Euwp9ji6tyzolFeX5IkTHsyC7nRdJbZq5wtPvKGCEu9eYzXYuNjwd00GFdom?=
 =?us-ascii?Q?kfEV/EMzMiX6Xn+0s6E9bIs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DF+s+Pw8L+Ya642kwEtI0ovhfDCmn/K2JeKyQ5ELRJGhpd9P3pgXrAN4/0nK?=
 =?us-ascii?Q?cfzF73aOVeNFYtZM8HigEPEOh4ysoS3Koxp7glJ7PLw2csEe21TKzlCJuThm?=
 =?us-ascii?Q?CkWGOktBIcH7WQvCjvfNZLnjrraoVrjPR2kqe7EN+oIviMJlBLxlYgqpx9ww?=
 =?us-ascii?Q?idcN/20dZz73lAEjs1RxMcesbFuU+lq/UgjmnPt7TA5KJW7n3Ks55dXyRjRK?=
 =?us-ascii?Q?bFMMHa9Z0c1J6QEpc/DVfL6EhNzGUT0h7CTMw9ti7rNI1RHItubAAFuzyLYC?=
 =?us-ascii?Q?D7MtA2pDzfUwS4BPKive2H8FL8+CnO0dpYCkkJp7ga1QPBNZrMSAu5yLQMOj?=
 =?us-ascii?Q?+ZIaUD1d/FYDKxg2oLwJ7+EnKHLyriVC/JcaR7qecTwrwgBvlviXQ8v5FfNH?=
 =?us-ascii?Q?WcBE+kWfVTyV7fLitueJIt9FRHVNyHyrAG2q+ejyr6Xc6oVdtDjCns1Kbz3v?=
 =?us-ascii?Q?0HR3pj4z1XDjEfp02+O8+p4S4mGvp5ztAMdUDPY9Tkd7RKPVio/R00LzSIzg?=
 =?us-ascii?Q?qIoSU9nUrowOKHEeEDXT7eCWYoaOVCiuil0NrxZI+5TwpOlSo5LPlO5l0GIE?=
 =?us-ascii?Q?df8AHmiousa8VgAX/JLTL7jkV7GWk1DN6iZrINmPYzB3/fOcQtdLRLCPBuW/?=
 =?us-ascii?Q?vUFKftq1PdWGTAScQgY2aie7Nd4APEQnW5wqr1px7RCYAdBrIOu/GUJjnk4c?=
 =?us-ascii?Q?EHBScfJE6rkFEofXNm5pbzAhX67o1P9+jfXV37aDy5iFeMclFk1vhLc3BXnk?=
 =?us-ascii?Q?HQrKx9obb1ENKU/ais2VAjSpaMj/DlvKfuR/MypOC3WM/Ha2ersIDzy9gQh0?=
 =?us-ascii?Q?Mwf7RAF9bAjYh/hGfqxlJsukvR987BQFHdgqy1xDhwcQU3gcQmhJtfAawuvR?=
 =?us-ascii?Q?FXrOvNQJTlBXmMGLfS1ONXHYtTcYNzRtIxvtVHXgSVGVFJ9Cg/6c443z9M9U?=
 =?us-ascii?Q?YResuavmiz7FnZfSabnHrFm05SwR4u4ptq/4cEUW+/g2B5eSwJT9yOa/dpEF?=
 =?us-ascii?Q?cRplcAVa/dDfpFMW++iI1fnPG2vZtsA64R6hnzeU+bqwWg0AMWPRHaJcFgxH?=
 =?us-ascii?Q?49K7kjsYWeKU6ZzOAi8ZV8WuIP3fENOdhQrTCxYInpNZZ7qS9LYPoqgw7H0N?=
 =?us-ascii?Q?zs6+dHu3SR67jn4f5k6OEQRd07rdd8daFbJ8NbzvHYy4j9CLEaW6Z1v9AOfr?=
 =?us-ascii?Q?wFZ1VgTcrAaOtRT4eozrd5pqS+EZKhJfncIODDv5WatoZ/2SYZdm9qmRy3Ri?=
 =?us-ascii?Q?5WeGpKoat8/W0YOEQBuvp7GDSOwOIqce4uBuSqfQas84xx1THRSJX3TuU3B1?=
 =?us-ascii?Q?z05BrRt+7yGLV60ZbbvDcb4mMwMiT8qEspd9Vm3rlvuisVOjRPcxWembHbtr?=
 =?us-ascii?Q?lwSACZthJq6Tdp7SEnHrlEiVS/2unWz+w+W0hCgNasOVoJh0WAgB7NMyMIR4?=
 =?us-ascii?Q?zZDoh7kEnzcYz+6h5puZdQgTs18lJF7+qNN8tuP4z6Tcml8Rh7NL8LpOmLbA?=
 =?us-ascii?Q?Ck5AN3nIRVpe3AZWuPlD5Ptb+tpqsa4znjzOLwvBem6Xhwk0gG7OXf8LQsfS?=
 =?us-ascii?Q?OE+/E7M6J2IghGjPa/zrjcDdFUFBJimtrk7OU0teW50xJpIikj/MaXZUXG8/?=
 =?us-ascii?Q?JYMbJbR52N55W5IXH6kXk1BUHcIl37qAHnWBkePpUZSU01rI5W6/Q4sGe/Sk?=
 =?us-ascii?Q?WdbxVQEQsYVVFgmQ4foMCQYIj1oJrE4OkiW2GaGmfZ2agFw9xJvz1d/ZbmNK?=
 =?us-ascii?Q?Jw21dCZttg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba91738-9e71-475e-4500-08de69e09324
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 02:43:59.4953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EANgs71Si1hSb44iWEZfrkrTmSvQhwfMNOxFgxrN4gCqFImyUtSJ/D+bPmSI5VPVPg4BLK8C+MyCeDmNMtFgU6ZOkvVSORw8/cd1KC1evLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6520
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
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
>Subject: Re: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach
>callbacks
>
>On Wed, Feb 11, 2026 at 09:14:33AM -0800, Shameer Kolothum Thodi wrote:
>> > > Have you considered extending attach_hwpt() to
>> > >take a PASID instead of introducing a separate callback?
>> >
>> > Yes, I did. To extending attach/detach_hwpt(), we need to add two
>> > parameters, "bool has_pasid, uint32_t pasid". E.g.,
>> >
>> >     bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev,
>> >                                          bool has_pasid, uint32_t pasi=
d,
>> >                                          uint32_t hwpt_id, Error **err=
p);
>
>The RID attach/detach could be just pasid=3DIOMMU_NO_PASID without
>that "has_pasid"?

After further thinking, yes, we could.

IOMMU_NO_PASID isn't export as UAPI, we need to define it in QEMU.

>
>> > and refactor iommufd_cdev_attach/detach_ioas_hwpt() a bit.
>> >
>> > I'm fine either way, two separate callbacks just look cleaner for me.
>> > Let me know if extending is preferred.
>>
>> Since PASID attach/detach is essentially an extension of the existing
>> attach/detach flow, I would prefer extending the current callbacks.
>> I think that keeps the interface simpler and avoids code duplication.
>
>+1

Ok, wll extend attach/detach_hwpt(). Thanks all.

