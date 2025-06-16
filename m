Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60A9C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 08:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR5cc-0002ra-1p; Mon, 16 Jun 2025 04:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uR5cZ-0002qh-15
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 04:55:15 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uR5cW-0005Q7-Al
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 04:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750064112; x=1781600112;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7MheW+LWB30fO2UpcTphwh2dysPxg8TQclrf2sXA8I8=;
 b=R/bPICSFtJ9CNfZlbkLl11pY4SLpEsvdF3vdsPNYkBYU+TjslPM0YcGQ
 vrBLj9oh2zAxaL4T4RkDHmZGvGGIpJh/qnB7HD+a4+Jw5wJ5OvxYdonrG
 DDQCKWc3YLKArpZs+OMMCnjoGcAtbDyVtDLARWhBf3DKoiJd+FKBL+sur
 S6iYF4PF8EmsGUFa9o59wdLp3fO3RomVJFkMPUgxy+90YV3EGx8lfKkh5
 RXKAokno74bUDAMwzHv/rcMrd/v5RRIJqUKJXCjKOCroi4w8bZzksYSU8
 z2+g6SRXCqTAqHeoqWXwFXP9BdDwBMKcXsWTgD0wLfALL3tKzpNFtUPs8 w==;
X-CSE-ConnectionGUID: miNfKTMcS6+Ox9baN9GG8A==
X-CSE-MsgGUID: 8zeJlq4+RPSWwUJ6kaJKLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="63231766"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="63231766"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 01:55:02 -0700
X-CSE-ConnectionGUID: 3WaINpwuQtOAuAy7JAB6fg==
X-CSE-MsgGUID: jx7vrbgsRZK8SK9mzRN2/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="153176319"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 01:54:59 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 01:54:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 01:54:58 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.50)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 01:54:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPVXu89m8kXhH0zVxqvdbfmyy5pXtokO1dBY5wNouum/DucyCdEfPvDCWle90V/Ntu4zvBfVPD/SOU315CE9xtp60T2MrHF4GXseWY7Jfmdo2jRo3HKO67k3khIXQNBUGiBQj2irG4hEqXeDvtqUXRV8ZU4+ERC+nI2aVcLMbqe1L5pNFj7jv3qxALv57XiYGswlWowcO3lLd90e0P635JH4zdXD3dX8pw89HRD5QxCTMH4R/ChntK07TSzPES/Bo4l5Zl0fezfsoUAymg8s8JBw3aQ3M0LRtZsahkAq2h427EjFMY/7p4ouVWVV+HxRWupyn41K3otTc4TIVQZ8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jE1LNo6PrrIL7OT01OM99QSan/ZdTpBGrPy1NX5V/Ts=;
 b=AMCxLFUz6oOqSaVNDfwGjDL8sGbF9K1SFWjfQrXmHfKW7WoLqKpmx+JMfGXOMENV3XQJG9OnDfUW5zhYJnzXHMdNviTwFGoVNHfEHgDYbyeo+gWkSDqbr29Yx8Tsw5KVCrK+3+bmv6lAJW6d9qvEk4B/HijIfBlDIC1SCgOfFn3z6N4DBM4Roa8NWCJCMqd/YhTQAnWmO6WCN2eM/iQ78iC/fHYQFX2GN0ARG6pi0iT2f6ocnTD5s/SF11rjejKyyrQMH8yWdhBjfGeMOWMXObICWhXGdeKyLPPvNN+0T6CHL01Gz/wz6DYZ+uBEJmp+sXNMYCZoyq+5G7j/hGmKyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB6374.namprd11.prod.outlook.com (2603:10b6:8:ca::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.28; Mon, 16 Jun 2025 08:54:26 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 16 Jun 2025
 08:54:26 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Topic: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Index: AQHbykJMfKt9Mfha3Ee+klVeu6JiiLPdsMoAgAIQvoCAAPjWAIADz6UAgACqsQCAAnMkMIAX9a0AgAWgn1CAAD69AIAAIZ9Q
Date: Mon, 16 Jun 2025 08:54:26 +0000
Message-ID: <IA3PR11MB91362B306AA38B1180E3FC5A9270A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f6baaea1-a60c-41dc-a9a8-d2389ed14679@intel.com>
 <IA3PR11MB91365922FBD407DD25E382C39270A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aE+68E03aAXEynBd@nvidia.com>
In-Reply-To: <aE+68E03aAXEynBd@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: yi.l.liu@intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB6374:EE_
x-ms-office365-filtering-correlation-id: 9a34e653-655d-4c83-fcbb-08ddacb36616
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?03Ay8gSjYpcyAjg04mQM+UQYlUbmUT3KKGaUoEfoYR8pYZdWg9/4TmYP70aA?=
 =?us-ascii?Q?TmAt6QqJUtnI6g2BYua/dNMH91eYX5KivXSdtSgyapAB6com9W9jUSYeNwRw?=
 =?us-ascii?Q?wYK2Dt0+apAmU7aZzsyXZXjggZY5+/28ICISwRocGL4LK6HLlLHSHwMjlHxo?=
 =?us-ascii?Q?kmEI0FzacsYiSYbjINGf/vS38deiQnAo9KB6N0wN0vBpgQiBzVAi3naqlY6V?=
 =?us-ascii?Q?WuB97+Tw+WEU4Cfoc+7+mdaoX8GNkFxlWqieSra0HtlpA4UZmyxFmV3TcSJP?=
 =?us-ascii?Q?I+9asW6F9b0k+zUvnVrBOuaUve9GXe7EsOr7X+iTZHGFPL+K1DaBSWLhDjSv?=
 =?us-ascii?Q?fP2ixjs8wG+oWRNAE6Zt+2Dkg2ca+YX+7ADvQdN3f1DOFsfRT7tzLg3WQxix?=
 =?us-ascii?Q?l2dEd5EQOqFD2eXnaWBLsAFTpBFHCm3RaTJkYUgLXMldWz1XX1JB2D0V8NKO?=
 =?us-ascii?Q?4Hz4XA0YUFRVD7d2j2CF1cyxhhb9Y06NTZHaPW1hY7ozL7OWIisQ/kjfiLzJ?=
 =?us-ascii?Q?wmeGdx+BFqzSJPMAEF9QMs61LSSKEg9yn+3TZzBpG94JpZQbGk1B0OFsPfvP?=
 =?us-ascii?Q?WRVloIlxnT5QAYBoCvB52F46qFAls6hSw/ksx0BzuYdrF/GWjMRbmFRwKDcU?=
 =?us-ascii?Q?ekI/X8cnp8iFZjTGtsd/41Bo6O4Ve6TFe53YXn9SFcnj7RtW+7gy/viBp3YL?=
 =?us-ascii?Q?yDrepY010Mx3ILkpEAzIV/nsyndNhjh3oMLxJCnCg3EnhpGOX6R+3FjvQpB7?=
 =?us-ascii?Q?rz4E+hc0Fh6toaFKan+OsPkU5HAfHcqnswjaYVrK9zvLgfnQJJ9O+X0rRqGR?=
 =?us-ascii?Q?z8OPq/prmfJe/GnoNutYZY4CYc+SRS5nvkheN7LfjRfQSecAfraPpm+6dvsl?=
 =?us-ascii?Q?OmH8mDEzLOoOZYCdIsq2+Y56qD8XhjHNtE6QkKoLv4zjAD9OxlAv8HRMs4ZA?=
 =?us-ascii?Q?mZa8rHQhBqxmwShemaElpdsOeaFX+2fh2CXkM3K2OCxaCGIngcWiIfMloM3A?=
 =?us-ascii?Q?ZfXFU37IIqUnJ/ptN+GnLCRoMaRD8e3G/p8D0yriohIN8ursMi1jaXASzGZE?=
 =?us-ascii?Q?UxkbFL5A+haC3QZZ/msMHoJOwr7xnrVH37QW7QSzxn15Ata/NTZ/dVwCV/i/?=
 =?us-ascii?Q?5eFj72hkClu57QWhoaBHis67ftoVdJvPo9IfC2tyfqXGlL8cLP+JdqjzJNxg?=
 =?us-ascii?Q?tVyuJ+xDGUaoCvK8P3/qT9E6t3ztNFOgKtJg/8VYRmAh61N2aFB132iUYctg?=
 =?us-ascii?Q?r4w4GwBtU5JmuGESvNE73wRfHOV20a3V8uOTS3ObxRQqrEFQx4EgT8aW8YSB?=
 =?us-ascii?Q?tpyyxTJNqVKP93rcc7zwJKv6ss+QEDX6uJZPyTy85Uh+bZFoWCAqAAmV39hU?=
 =?us-ascii?Q?TUs3yQbQSPkWb9111xCyWZ8cuomDan2FkuYUq+2Zq010YF0wCGaHduFjiXom?=
 =?us-ascii?Q?lqNvBsvFghTQybIIgZvd/8KqSAvUCI9TCWrpaXyuTRriOIw7gD3Cqg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q+3pmxzPwzxo/9ICavL3K8wKpK8cAkchL3q8EJf03DyPLVFCjdMMx2Xlo3x9?=
 =?us-ascii?Q?7cC4SkjQoud1PkefmnWc/KQE4eQ4At05gMxk5VnWjq4CylzAkGALTo+KkwBl?=
 =?us-ascii?Q?99VVL/jes4V4phG5hAjnC5Bt50u5CHxq9g+kAyC6K1loDWpMXj/IPuEPzTlk?=
 =?us-ascii?Q?67TtXjngVQdh7NTajVDNJzMo24Jm5cfuidi3GEhvDcW3hXT5Jx7xu4mtEaVZ?=
 =?us-ascii?Q?vZTWqmDqaZQQ0Rcy+BwGT20qH4bR0VPJruXka4VV6sUm5yKouiZ7jjYmaQJY?=
 =?us-ascii?Q?4ytKnJnQti6mYofZo+KVpKWD3y+aAzmbcpjGB1GYB6ZT1t1g4dkfbaIqpRsH?=
 =?us-ascii?Q?s0wGMOyg1mSDLIJQeeVU+QzSH/o8rUQCdEu7FWu061XqiQF3UYuD90hF0wpK?=
 =?us-ascii?Q?E5pq25fNcnhZETX4aXdHROlrmnduacjaQL22vrJ8z6o73kO689eZLF8aLetl?=
 =?us-ascii?Q?HA2DTUjEKBoay02DyoFTwWpEgHw39t+VcNhhIZ93A0a6hrPO4FfgSVB7ji0s?=
 =?us-ascii?Q?59ooz0Yq1kUd7e75sg3OJ6AdDxYdIORlC9gDKEZtFy4jJGM9WSGzREDE2F9u?=
 =?us-ascii?Q?j6SY540Vx14Zs/zqsneBEruTODQjBBKoNkRbv40xZeizJX6+W2p8VlUIJhhE?=
 =?us-ascii?Q?yVSBfHL3ZgHPv1uClQIBLyN0ZaVz/0U8Sonl4FukpCpqedwR5/t1RauzguKF?=
 =?us-ascii?Q?ESAbpnnPI0/aRYvBAb/fxitAPofGSSZMX/wOjQbE4WwGsTpBpGjkCmGzaaqR?=
 =?us-ascii?Q?yD5HNryJOXmX3TvS5wRNXr6sWvwlmNe2F1Fkb9jLd6gEEAUjKu4Y24bc7M+i?=
 =?us-ascii?Q?G91LScrE25mt8f47zdkJIk6ZgPuOZluOLHfvf6ta2ZB1H3PP9wFQP4DRORa8?=
 =?us-ascii?Q?GLBZjyfA80F2RHX50DU0TzIX3o3Np9Ug9s2xj23MoLKxcV/bWKnq+F77MUMG?=
 =?us-ascii?Q?itWuv8QdihxFzY/8vXFcTS3+0+iePm0QQwE0ILdTX2+0RYzVzJ4hb0tf8fmh?=
 =?us-ascii?Q?lnQOwxVdv5ie7SNtcwB+BjIuJr/26U73O+i3BldGpYiYCJgCtPEsOb9SNIow?=
 =?us-ascii?Q?oOdgmFh941segQBsdY/JYRZbYzMF3EzRFf9ygFFCSIEM4QC6hiii7ZdBazp1?=
 =?us-ascii?Q?1S2NeWGXUJ/V27r9u53ROvJK7KX3Oytags8oIxoOCsjtxcluEq5NCafQvAUl?=
 =?us-ascii?Q?OVt2fEzxm3w5QeWydKGUsn8ak94atlSiGRFpidRfivc9AxtyVE7MIXpL9Tl8?=
 =?us-ascii?Q?PkAkvGD/iYOUJCecxQ22EP+gW52IgaeXf1TZalu7TIzO2+vSnH6Gg/Y+pQT3?=
 =?us-ascii?Q?JCz+uqWmH2FdLtPTEK0OpGmiZ3uLzypQ0Toc6IZD8vqJ4lC2C3hqCXRd4+hE?=
 =?us-ascii?Q?+KPRnvfnteUW0QGJZMD5hypONyu+d+QV78xrY27BeeDuRyaedykPSI/N/Bmp?=
 =?us-ascii?Q?GeFL8io3/dJpZdmLIroCjEhanWDgPpkk7Z3FInTlyJ8KFppB8Rlov8NGaFz/?=
 =?us-ascii?Q?bljerayNdAG+aINuFPezDut4eZI+tEpC6eh7ZqdfshCaK8jivBuDcw1ieRKQ?=
 =?us-ascii?Q?aKYj2WlAa9/UVzqpvIiRnkSEuS1PUAS3F8IHatlC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a34e653-655d-4c83-fcbb-08ddacb36616
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 08:54:26.7993 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0hhD2JN6p1Yl5bXVxvE/Sf9Lx2iL3veA42GfTHVDuju4aORgnXr57fK0nItINYazOe2G5lFco7Hn1xq78nI5GcYDgrZPt75ceZaE88MSAyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6374
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
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
>Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table=
 to
>host
>
>On Mon, Jun 16, 2025 at 03:24:06AM +0000, Duan, Zhenzhong wrote:
>> Hi @Liu, Yi L @Nicolin Chen, for emulated/passthru devices
>> behind the same pcie-pci bridge, I think of an idea, adding
>> a new PCI callback:
>>
>> AddressSpace * (*get_address_space_extend)(PCIBus *bus,
>> void *opaque, int devfn, bool accel_dev);
>>
>> which pass in real bus/devfn and a new param accel_dev which
>> is true for vfio device.
>
>Just =3Dy for all vfio (passthrough) devices?
>
>ARM tentatively does this for get_address_space using Shameer's
>trick to detect if the device is a passthrough VFIO one:
>
>    PCIDevice *pdev =3D pci_find_device(bus, pci_bus_num(bus), devfn);
>    bool has_iommufd =3D !!object_property_find(OBJECT(pdev), "iommufd");
>
>    if (smmu->nested && ... && has_iommufd) {
>        return &sdev->as_sysmem;
>    }
>
>So, I guess "accel_dev" could be just:
>    !!object_property_find(OBJECT(pdev), "iommufd")
>?

You are right, we don't need param accel_dev. Below should work:

object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)

>
>> Vtd implements this callback and return separate AS for vfio
>> device if it's under an pcie-pci bridge and flts=3Don;
>> otherwise it fallback to call .get_address_space(). This way
>> emulated devices and passthru devices behind the same pcie-pci
>> bridge can have different AS.
>
>Again, if "vfio-device" tag with "iommufd" property is enough to
>identify devices to separate their address spaces, perhaps the
>existing get_address_space is enough.

We need get_address_space_extend() to pass real BDF.
get_address_space pass group's BDF which made pci_find_device return wrong =
device.

>
>> If above idea is acceptable, then only obstacle is ERRATA_772415,
>> maybe we can let VFIO check this errata and bypass RO mapping from
>> beginning?
>
>Yes. There can be some communication between vIOMMU and the VFIO
>core.
>
>> Or we just block this VFIO device running with flts=3Don if
>> ERRATA_772415 and suggesting running with flts=3Doff?
>
>That sounds like a simpler solution, so long as nobody complains
>about this limitation :)

I plan to apply this simpler solution except there is objection, because
I don't want to bring complexity to VFIO just for an Errata. I remember
ERRATA_772415 exists only on old SPR, @Liu, Yi L can correct me if I'm wron=
g.

We can also introduce a new vtd option ignore_errata to force ignore the er=
rata
with a warning message in case user care more on performance over security.

With these two solutions, vtd can reuse VFIO container's IOAS and HWPT just
like ARM, so we are common on this part.

Comments welcome! If no objection, I will apply these solutions in v2.

Thanks
Zhenzhong

