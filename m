Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF747CA0FE8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 02:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usuOe-0008EO-EJ; Sun, 31 Aug 2025 22:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1usuOU-0008D7-U4
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 22:35:45 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1usuOP-0005jQ-W5
 for qemu-devel@nongnu.org; Sun, 31 Aug 2025 22:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756694138; x=1788230138;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Z1E5q40ie4wUB+N1oV0pPnmHgbTqouSa1602qZqZU48=;
 b=nqF5FxYVbF0gCx3y3B89n3de6fazcGgaf+ulxeqJfySASzyDJPRGuTys
 SNa9ha3NQuG4jLUnPSlTlZec8eJzQG59RaET41Kf/GyNqjkPqzjKzUaDb
 bKYnAtNb1Vx/PoLoTiZMaNCOHQVXGAtlml4IhIkSUnp6JcLOR11sgi+BR
 ycAV+EKFNt3inTL3/FfNcPJYOVTAlLFb0OjUno4bY4oXAFiGATOM9VpAT
 80ozQWfSGgtI7iBNTaq5ZHX3p2DZ1QnDWZEV9Md3cHgt3VB2iNcxsRU0f
 8sLOPEMpOp0MLQRt95TB2I8OQZ8xP2ROw33XRDE6vVcRroTprkRsyN6Ww Q==;
X-CSE-ConnectionGUID: T7c4prtbToWv/ikuAMtH/w==
X-CSE-MsgGUID: +6hU7tPBTra91V38PJ+CWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11539"; a="69483663"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="69483663"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2025 19:35:33 -0700
X-CSE-ConnectionGUID: +lcDdgPyQzScvjpSxETRzQ==
X-CSE-MsgGUID: sw26iB5YQFaGpDkchdb+ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="171235392"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2025 19:35:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 31 Aug 2025 19:35:32 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 31 Aug 2025 19:35:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 31 Aug 2025 19:35:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTIOO1ek1wFwvvqmF7OAPsn/qM0R0wkYVb1a39qZtdy99OGK8q0MpHGpyPzE0lZTcin4giRprG5BftsJXDls+qBwIiIfPmop8z1MOMiozqGh+P6P+6uR/n9QRd8CItgo4hutKxxyvKoTFqNlJ12X0I7i4UF9nP6kehxWpkpoXGe8YKUcm/6Mo/eteaIkp53KYOmEtjzY/R5+JnBJqPevkgYy6datBglIbauyTvM+md6YG+gtZdB+oOmel7LMpWb9dPf5N4j53GoXcgNzDwRWguzUaiJVgI5faExYNaIf7StPbpzAG865/u05vtLSGogdkQiUVnLelJ6Htif3Z8TyIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDaM/qmkbWy2821gyJR4TIJCU8noWHm12oWBGV6ZQVQ=;
 b=BKH77eI/rzGrSHUCuKhm+JZgKoP3rJ0QDZugWL6BK19YIwpRFqEcfSzk7++TNZlxF4GAdw9DaOglyZAYaPNNLbPHZaSlFeEzm+i0Dmi8vlOamMDoD6OC3As4W78P2knenF5214mR20HYgXXZHQ9pZcWJutn9b7CmyUGCJ+rD/zdc5kVj0rL+Mkh7YzkSMHJRO7hTyv5gql9mk5quF20I5OM6DtfXDe0agjDovDGn8eETGPqP2hMIk2Fy4oqVqf1LnV2IjXmnHZLDukslXXpueO/faOmefZ85sIZ4DYMdUu9KrgoLeorsWskfhIv8Gq/sFWGdSJhAD8vq+zOyyZjMlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ2PR11MB7618.namprd11.prod.outlook.com (2603:10b6:a03:4cc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 02:35:29 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 02:35:29 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 02/21] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Topic: [PATCH v5 02/21] hw/pci: Introduce pci_device_get_viommu_cap()
Thread-Index: AQHcEy/SWdP0XuMIEEmlrKJvbaEB37R2YPIAgAACfoCAABL+AIAAAI8AgAAxxICAARvqgIAACdtggAEaboCAABozgIAEp8vA
Date: Mon, 1 Sep 2025 02:35:29 +0000
Message-ID: <IA3PR11MB9136C7C18941F5DFDA44FCF79207A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-3-zhenzhong.duan@intel.com>
 <32c0a5e1-6529-4978-a0e1-32940e806dc0@intel.com>
 <e6300798-19a6-417b-902f-57fa7ae20355@redhat.com>
 <1ee98764-d57f-4ff9-9018-f07d8ee5d68d@intel.com>
 <153e1475-6678-415c-86bf-b7251cb59f3f@redhat.com>
 <aK8kqQOV28V36wtM@Asurada-Nvidia>
 <ecd95fc6-ce8f-484e-b685-d78a382f1705@intel.com>
 <IA3PR11MB913632FB83D138289BB718C2923BA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <IA3PR11MB9136978139DB0DA6A2A06C82923AA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aLEd/YAwfhXD2Lro@Asurada-Nvidia>
In-Reply-To: <aLEd/YAwfhXD2Lro@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ2PR11MB7618:EE_
x-ms-office365-filtering-correlation-id: 7900f09a-8987-4dba-463d-08dde9003764
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?d4slhpzuxxlgZgfE0QwHsnDSSmXajegagCdy6SqUWX0LhqY2pUW1CvfrnvsT?=
 =?us-ascii?Q?qNlwFyfxj/wtq0IAnpBD7iVhc3/3iQPyVHkoInCKnxWxsWn+M1OWCNa4GBpk?=
 =?us-ascii?Q?Bznk0sr3r59ncO3pFRT8qkK1O8jSALOL8gM6Q5VIw+PP8ybjD64iYhd4YAND?=
 =?us-ascii?Q?Ej9cvNBqf//zPjSTbrgDMpdBt/9120bzoEN4X8me8f01BsuCgBu7rxx99TVC?=
 =?us-ascii?Q?GPZjQEbOxT13hHcHCF5EBIsePYaYu5jpXbBahKWl5oSAJX1cifA1qbH6BTnc?=
 =?us-ascii?Q?55YSXypzGzfZdSApwl9sNN81WL0fmtYui8sM1RY2QQ8QEI6NVOkchwqxQPx1?=
 =?us-ascii?Q?R+seBQOj4tnQBwR6cUbER5keqEL1kMIt9kIsA/rtd3RGMM4PAlJd560NvC13?=
 =?us-ascii?Q?iyL299i485QMRr9c/qgqjxWiF6mWN10Zg6JQW2BEFp/Uix2lDimyCV6wjI8u?=
 =?us-ascii?Q?l4+X8wg/WmqWd+wGJBuPYvrEPEmtg90fI2uQa48V+5xOc/oCj+3a0ldhMv2A?=
 =?us-ascii?Q?DaqMbPCBAQPL7T1Qm1MIBpH0QVGN7BuSf9nScXkk6MsKLJa6INZzaMzRfYH8?=
 =?us-ascii?Q?IbGfwD6Z5GHUQvnGLNaYJOKsTa9dir1MhTf2kwvimOThWpvnAFG15MaWce0G?=
 =?us-ascii?Q?Q4gcTEpmIZE+zCa4xlbzhhxMMSB8dASLQ2NzvrXOAcekWgRlDUGT8wtzT2s+?=
 =?us-ascii?Q?gEUKt4fggjbkGiwhoW8wzq5xe6Ly0bm7qC8RlOR+FqBtcPX51pW1PFkdvDtc?=
 =?us-ascii?Q?B7oqSIpwEtW4bOsTDyY1RrKZj9SIAQsGpe7k9I8kKplFlFId2AQZ7j+OL6qQ?=
 =?us-ascii?Q?Jg4UCKxHDV/dmePqsfvOYVMleD+EuLlILkVZX9xJSQGsDPU/podTMPGZNLeA?=
 =?us-ascii?Q?iAYtv0Un5P54EVbHD7X/zentNgRFG3CoqV6MljCtTFifoyFGUqgIo8DhvACG?=
 =?us-ascii?Q?9jXDAjBGBcmHMQkSGUFVZKfI37/I+hhT0XR2imETDLYwlaYwUCYgsNcjzdCJ?=
 =?us-ascii?Q?hIg1Lcwme4MnWPefgYQSH7FPs3rJBd4/jZWb8B3scGDz/OfFk++keCI+ClJ5?=
 =?us-ascii?Q?HruLGSIUkbMwW/9OL8wlrOeDHx5waG0bWqvOx+k8LkdGVUBLx2fP9CNoqYrb?=
 =?us-ascii?Q?mZVx0ibNICN4+oO7RT5fFeqDYhRTL0F7OLpSR/RmQlXfriWLIQQk54piJsaU?=
 =?us-ascii?Q?AubWpJ74eVhM8cnKVHfC1I4AAGDnOWYP8i9L5Iv7TpSCw9CTqnbPMNG/BCzP?=
 =?us-ascii?Q?1xjroC9IYMGl3C7GfpKLaGJk+phXJZIz0TLo4v006oGSBHprDtbwrCjIc6m1?=
 =?us-ascii?Q?ILryVFQUdjAkDiFpCc3GCx8PsLElNTMmN+teVW+A1EWk9xMrxIqfumS5nZvQ?=
 =?us-ascii?Q?WIDiQWA794d4YIFe4WeueQe4JbZvoTI3R/N1eGuJucVO+AJGNl60fkVPMLtu?=
 =?us-ascii?Q?POXkxFJH85mvIHcIa2+olcC7VL3LGZz+GPxkq+8ROopsSlxromnz7sZolQBl?=
 =?us-ascii?Q?9c3U6rlophQva5I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zlPQv0NOKtPpN07A9bhPc+F8jYFe0RuSDiAa9PN0K+PHXWv0FQYdleBNoPIW?=
 =?us-ascii?Q?1y60F5/E4mEliaiJ5Ny5HZztEIIzV2w/ksqiLwi/4C5nmEUwQfr3v2j3shvz?=
 =?us-ascii?Q?8DIoG6Ddu32ceI6d3vWCRRBkcpCuMIDr9Nah2LW670as6zLESzbPwd1Cs2zv?=
 =?us-ascii?Q?3FHd2qzUzlHMUyO1SF6m12I/0eLwUj9JhIXnAWihbprTzKd4Ig1xDLFEu6Ul?=
 =?us-ascii?Q?wlxVv4/UT3v/ULp/E5wzoBGjy6vMDyRkIh52gz6XrjE5/5fA7WRHmSymcPXF?=
 =?us-ascii?Q?eOs4305hWoIEwGt1wb5dHT5C2dFcSvJiLV9fGLGUfa0EMfVkal61b2Svdc7C?=
 =?us-ascii?Q?Wub1a9uEjCYY0HII+aELkY5B0MpY6uDXPhAjRdy2+aD/oDYwcjfqiimZywAB?=
 =?us-ascii?Q?srp2Z0RaHi+Z0tdhLR4urIB6xHVQmGYjiUvmlc0rCV1Vg4qK+BuN0fqJ/GZd?=
 =?us-ascii?Q?F07xJcbaVguxnOAyXx6s/0KSdCYKuG8R1pnnK1o/dyMbDLnCs6GWuokEdmZq?=
 =?us-ascii?Q?LCIHVXdJ1LTWy/Joeo0jnI648eoM0w53hldU68qE2x8ae1CmWZviu+hjRfR4?=
 =?us-ascii?Q?QjrQNvcT8yHnM/jvtLWspVRrfQXZF3lF0S0FWtIqtXRzMMGXqY9u+rRBpeqB?=
 =?us-ascii?Q?dtRynHW51E52c0iv36HJ7VQeWNNre5VYAgfZuSdQm+66H4h749eUxt8x7CQd?=
 =?us-ascii?Q?bhmwTtj0Ms5hcYtCLz9u1E1K1Fa7TRyJhN4Xk+pl9v8sRfI/qjsHcJPxSCLP?=
 =?us-ascii?Q?F+N70AzErjMmPpedZMWUOdWVx+XKtqKsrHDewvu5BzjmPihxYz4PDLtURDcR?=
 =?us-ascii?Q?1BkGtlRxdIPLR9H1cQhL0LU9/W6yu9HK5WJ7+Xd2xSMCEOxo0IyAGUCO3gnp?=
 =?us-ascii?Q?OEfaon7SFFvL4/aQwaJzD0gPb4dq6SPUfSX6cUxKQXsJ2B4712RNCBcwbDRH?=
 =?us-ascii?Q?epa1+/F2QJgeugoU6AEs1wjx1KMsiEEVAvnu5jiQpjJy7uGKEBxPrfau/zox?=
 =?us-ascii?Q?jR17AkNUTCjgYtPkwalkAJUnY3WnS6YLGBCQXRwIwWlVyWCHT/rEuBcgsWk5?=
 =?us-ascii?Q?9UreyWheLXVNdTmP3iOI12wrGTPAAUQKfyKjH0yk2w8K98Tm7kqlINUJwDuK?=
 =?us-ascii?Q?RuKOf3l+TNln88jYP52qKu/AScx1f1L/XQYjs2Slsn7dMTqhfmCvvEhPn9qx?=
 =?us-ascii?Q?oPOn6pxQ/WH/tgGdSffqndg1ILG7XJj1Fet4VOoSiH9FgDt+VSk+1bajECJs?=
 =?us-ascii?Q?P7Ifx47x19j325spCuh7/ZivT6f0Pt6s+HptKya5Pn9z78PvIT0t4onhMk2Q?=
 =?us-ascii?Q?eHq62XdSahmutnLnoqVl7P4UpNxdwobO/+87cTIXBDWAi3om8GbL4miuTgNe?=
 =?us-ascii?Q?Duq0H0VdxkRG0q7V38yMD5WHwJv/YnEml+ml5fybABlmxS9aDV3hBL2t/i+J?=
 =?us-ascii?Q?3XWVooGhN2DX8hVv7BEStSxfbRAuDG74jgNdKi4eQBGydwviQaioRQERQZJq?=
 =?us-ascii?Q?bCTFUSi6kPma5u0FIXd8pb2GkLZyZU0f1Wl4H//6yOpDq4wEHoUb0bd84FKc?=
 =?us-ascii?Q?csnCmdZ9IW3ueFw7ChOGSsKhjOJcP8aPGL0h6Zgf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7900f09a-8987-4dba-463d-08dde9003764
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 02:35:29.5009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: epZBDPPFoZi7cCHmRg7nO51tfmOyEoGpPnVpvHrpaEvKszRHpYvXM/hpsVD2o9ffCp68xWjdzhjVUmANqmibaGBBfxl163dhYnYtH2mLbWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7618
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
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
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH v5 02/21] hw/pci: Introduce
>pci_device_get_viommu_cap()
>
>On Fri, Aug 29, 2025 at 01:54:50AM +0000, Duan, Zhenzhong wrote:
>> >>On 2025/8/27 23:30, Nicolin Chen wrote:
>> >>> On Wed, Aug 27, 2025 at 02:32:42PM +0200, Eric Auger wrote:
>> >>>> On 8/27/25 2:30 PM, Yi Liu wrote:
>> >>>>> On 2025/8/27 19:22, Eric Auger wrote:
>> >>>>>>> TBH. I'm hesitating to name it as get_viommu_cap. The scope is a
>> >little
>> >>>>>>> larger than what we want so far. So I'm wondering if it can be
>done
>> >>>>>>> in a
>> >>>>>>> more straightforward way. e.g. just a bool op named
>> >>>>>>> iommu_nested_wanted(). Just an example, maybe better naming.
>We
>> >>can
>> >>>>>>> extend the op to be returning a u64 value in the future when we
>see
>> >>>>>>> another request on VFIO from vIOMMU.
>> >>>>>> personnally I am fine with the bitmask which looks more future
>proof.
>> >>>>>
>> >>>>> not quite sure if there is another info that needs to be checked i=
n
>> >>>>> this "VFIO asks vIOMMU" manner. Have you seen one beside this
>> >>>>> nested hwpt requirement by vIOMMU?
>> >>>>
>> >>>> I don't remember any at this point. But I guess with ARM CCA device
>> >>>> passthrough we might have other needs
>> >>>
>> >>> Yea. A Realm vSMMU instance won't allocate IOAS/HWPT. So it will
>> >>> ask the core to bypass those allocations, via the same op.
>> >>>
>> >>> I don't know: does "get_viommu_flags" sound more fitting to have
>> >>> a clear meaning of "want"?
>> >>>
>> >>>    VIOMMU_FLAG_WANT_NESTING_PARENT
>> >>>    VIOMMU_FLAG_WANT_NO_IOAS
>> >>>
>> >>> At least, the 2nd one being a "cap" wouldn't sound nice to me..
>> >>
>> >>this looks good to me.
>> >
>> >OK, will do s/get_viommu_cap/get_viommu_flags and
>> >s/VIOMMU_CAP_HW_NESTED/
>VIOMMU_FLAG_WANT_NESTING_PARENT if
>> >no more suggestions.
>>
>> I just noticed this change will conflict with your suggestion of using
>HW_NESTED terminology.
>> Let me know if you agree with this change or not?
>
>It wouldn't necessarily conflict. VIOMMU_FLAG_WANT_NESTING_PARENT
>is a request, interchangeable with VIOMMU_FLAG_SUPPORT_HW_NESTED,
>i.e. a cap.
>
>At the end of the day, they are fundamentally the same thing that
>is to tell the core to allocate a nesting parent HWPT. The former
>one is just more straightforward, avoiding confusing terms such as
>"stage-1" and "nested".
>
>IMHO, you wouldn't even need the comments in the other thread, as
>the flag explains clearly what it wants and what the core is doing.
>
>Also, once you use the "want" one, the "HW_NESTED" terminology will
>not exist in the code.

OK, will use the *_flags and _WANT_* style, do you have suggestions for the=
 name of vfio_device_viommu_get_nested() since "HW_NESTED" terminology will=
 not exist, what about vfio_device_get_viommu_flags_W_N_P()?

Thanks
Zhenzhong

