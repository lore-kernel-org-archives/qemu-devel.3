Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACF6CA0EED
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 06:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqQGl-0007ZK-KQ; Mon, 25 Aug 2025 02:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uqQGj-0007ZB-Dh
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 02:01:25 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uqQGg-0001Ix-Fr
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 02:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756101682; x=1787637682;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=92/2Y9/Lw7hX4J9Jqs7hZF1piH2aP222GLfSgRjnu0M=;
 b=NUtGaO3oh0Lr1RAtJD2ccQibMxrcIK674p3T+39iUzOnZyhF3s/D69zx
 1eMfB5j7cbvBgLS1t6lxITrJmyn4Y3j/GbW1pdFI5J8BOUZxU0zhWU72+
 NrZfe3lfkDg/kdr9eopcUQMtISuHezKaY8Krhc0j8Bm2GfirnTItcidb6
 e88KX9VeUZ7jXyrXg77C8K+kP7K1zkxep8tI2G2SVGv1MJkWJss02ELol
 Rxtp1w/heWWei/j5tMK4CqcbdKPvXLGuu1ebqoJVIqyZi/L5oYfKhcn9q
 8R0M7TJ4h4Ez54wtv3Z6EcpnYYcLpz86OjKxld0BA6u43SscRxLKR5k2b Q==;
X-CSE-ConnectionGUID: ZcqKFapGQAi7UpTr5Z4/Hw==
X-CSE-MsgGUID: FjWwVMzST3KuvNSw2oHJaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11532"; a="57327770"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="57327770"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2025 23:01:16 -0700
X-CSE-ConnectionGUID: emVaTmV9TKqb/dVkCgxNRw==
X-CSE-MsgGUID: wzqdIV4kSDeZGxB4pGJ06Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="174492546"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2025 23:01:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 24 Aug 2025 23:01:15 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 24 Aug 2025 23:01:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.75) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 24 Aug 2025 23:01:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2VLEp0er8I3+bpA8oJs67pejThytiqQ8i790aQs5psTdJ/30fglPdxhDB7yWC65cqZUWoz3L5ddLbXHnpVZnKZBiNO2lfeXoNgSkbV1XIFt89u85tm5MhDW54QhR+OSweVYY/NYcDSgg9/bm/TzE3HYBUQ+zu7+iYd5fVPowTbkCsSjylxr2jt3ZI26g0S2xBXdHeFeQ3JFbJK8BSfQnLMm4RqcCgGIFX7VfToKe+QUlSntCLmghJuzcz+NSSdiYKKm20uWDGa5BZJYngirtZFntixM8AkFBTYibVhehgACUhbCuyUwKJNs09EcH1H6V4b76t5E62gV07QHB7pdtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1Y480oI4uBKu5irZBA8PRqpdxjQ445EG1qxaCGsBI4=;
 b=DX75QpreACkm40JIR1iXNZlKeS77hxKB+smWb1qcXyyiJu5J7vS66Iaj43NLg45mZZ0Tl5LkZnAuyzs2qzk/2uaMs0/RhtR80BG0muTtJhFU3XD6s6GQ1e7NIkg19ITk8xL6B8dlRahoFWNbpyKuMmZpuZCtfGSunE//hJ/UqyPelRZwRynHY7sScqFTkY8cgj4BOXKJTuTSkVfWmFqglni/5KcTl2njxWiZnPuiAe9NW1XNGxWgWprYZM++AXxt50SNT89KMQJtO2ps1OVt4B3qqc9kvsS6USuOb7AXkuZQKdPO/WQ1RXJqEmVlGQaUy56YnbiXAc+6VaRDL2Sm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB7390.namprd11.prod.outlook.com (2603:10b6:610:14e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 06:01:12 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 06:01:12 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 01/21] intel_iommu: Rename vtd_ce_get_rid2pasid_entry
 to vtd_ce_get_pasid_entry
Thread-Topic: [PATCH v5 01/21] intel_iommu: Rename vtd_ce_get_rid2pasid_entry
 to vtd_ce_get_pasid_entry
Thread-Index: AQHcEy/PUZy81omZ4EOF9pxuV2tq/bRvP0eAgAOhezA=
Date: Mon, 25 Aug 2025 06:01:12 +0000
Message-ID: <IA3PR11MB913670588E4660B5DAEE300F923EA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-2-zhenzhong.duan@intel.com>
 <aKjs8WHmFDIxxUh2@Asurada-Nvidia>
In-Reply-To: <aKjs8WHmFDIxxUh2@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB7390:EE_
x-ms-office365-filtering-correlation-id: 175928f0-26ad-4189-a1cc-08dde39ccb91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?RdDuW7GW15VTctimk2EvcSk/uGcsIm5IqE5AUTGexuN2loHRbyMF6zHrnF?=
 =?iso-8859-1?Q?UuejL3PEMjUt5exFzTV9q+8qpaERZpVld4sVUmWijzON5C7LHSOL4oYpqH?=
 =?iso-8859-1?Q?vwsYZ8wRVc+Ae50TIkgDHe6XSfa1nM3W/vygSbc/+IO01PM0ghAhWKuPsz?=
 =?iso-8859-1?Q?0LFa3cWDMNYfjvXRFr5arVZp70M121aLuc5ZzjoMWX3XdMm8xXggRUnw7m?=
 =?iso-8859-1?Q?p3M9rqRoJqFE+JEUVZs6SftwlBpjSVIhgrAPoR7imR1slEuJ3MqoA87VGC?=
 =?iso-8859-1?Q?d5ZTQnyUjBRy9WSHWoqtzopt47wtqzDeCvmlr9il0EVvn20hFtlQOZI16X?=
 =?iso-8859-1?Q?KAnmMj3XrNhvYHKKmLXnt/fiZoffXpBz4c/vm/BbZyYDg3Y01vMunn7mRQ?=
 =?iso-8859-1?Q?poGE/awU8HzgGLJcI/saUkYu2GEpU1IZikDAWqI+MI9UARdpVsikZE4Ktv?=
 =?iso-8859-1?Q?L+ecdzqoz2Qssu5V0XCDeHaLH7sCEvcvJtTTThceTmY6AMev3wdXPhd8po?=
 =?iso-8859-1?Q?dWCZCr+WY2avE4tZVunq6ABiJZduqliKUWDIJWz43SLPyrNXJ+QXRqQuFX?=
 =?iso-8859-1?Q?VlSfXmqI6Bo/mWBZtjJVduJP1UDd4TQVMmwGGJWMK/3wUWHSnh2OypALNr?=
 =?iso-8859-1?Q?i7uCI4Nu9wTjrW2n2JNeELmwokFMKPKCfsIPCA/NuS4TGa9CwefjJRngsl?=
 =?iso-8859-1?Q?CueKcoS0zB5/Bwtv1fkXxcvQZiIMTHibH1OSJP95I2Zr6Y23pvaXSncBFD?=
 =?iso-8859-1?Q?xx7aiAtM8ue2tp745seQeZdyj7pyliq2VgYbXHRbg0qHblLUkKSqohjf0j?=
 =?iso-8859-1?Q?MqWz/ZkTIBiiIbb1/cWqJWgovax5llwjfVEtCuyhV52pCVikoMW5xHT0uP?=
 =?iso-8859-1?Q?ZVmqUrN+vmBE9BCXe5bZDbEgypCRtPND8lo8r1hPaSL9GNhaZdq+jmFsgi?=
 =?iso-8859-1?Q?BBEHDUpqOFXUr7EctJT1fUKr2ALieP0tAnycEKWHLT+I47GucVYrWdkbWm?=
 =?iso-8859-1?Q?uhzpRJBnqUJaZhu/FhoV3bwY8vx5UAgBkB1F1uGQ3J6T2Cmbhfw7gWRiBY?=
 =?iso-8859-1?Q?Y7Pb7JeCQ7EgKqLxc0SwYN61YDnjRSbIetRSMwiTQEMVtyDnmjYQjX3srD?=
 =?iso-8859-1?Q?hebwQYzsyY2gUe2jVsAPbJNwORBHhvqaoiBZEqBu6u5PXgd96YED4d+qzy?=
 =?iso-8859-1?Q?ik8nDaO8aDuLDCles84wA8G96DJluBEinLn9zWSJu61z/F/xwYQzIn5EVr?=
 =?iso-8859-1?Q?LgnLCswHRY911oHZqpEAiSND0i/QSnfJVg+P1LMR7uyui6f+zdIdXS5PSX?=
 =?iso-8859-1?Q?e81piP7P7aU1GBSvg/OfMXj2F6NA7DoUJbg45MEB+zI0RHxvPjNQgAxp1e?=
 =?iso-8859-1?Q?WrvdOH4LRXPW762YxG24ay8r7MDssEaqZbpwqsgIW9cw8mxzRerIt67+nk?=
 =?iso-8859-1?Q?l7SSLShTlx6L+D4V7GFgIVMZcGri2oM5EGEGc0jbyTlzzbKNGZMXHONylr?=
 =?iso-8859-1?Q?kgPum6rWrpghLW4ZzPYLHT9aecPSr9HNHupC+wpriHBqjwLM31p/rk2/YX?=
 =?iso-8859-1?Q?nPGJI5k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?T7Yq3ilU3HKRd8UWuRb5nss+0r+MsrwfhfMlERAKFOFpVIbSxib7OipPQm?=
 =?iso-8859-1?Q?OqiYcNay0Xii+uyXs05ApU/4n4FICwdp7v2e1EQrDWMEomPYawB/u0fh0C?=
 =?iso-8859-1?Q?uZnMqBmJrpFDvOyMpnZHinrb1XJ2SQlwCAnySvAO5DXRdvAi15rRv/LO76?=
 =?iso-8859-1?Q?1vMpsR5LMpS9alMfTw4GfJuHco09sQ6g62KVNs28m1mq0dAAu3IyZR1IgF?=
 =?iso-8859-1?Q?MBp8YAxWZAIdFRVqS+y9KM6/s0umcMPvt6tI1IMz2NxbMdkVRmAl/8fFcN?=
 =?iso-8859-1?Q?Sf5RZUB6X+X7ORMi3OcBLuZai40TXU+6Fgfv4y70V9WgYTJE9KDnul3Ffn?=
 =?iso-8859-1?Q?RszL+t09SmOWnMVsXq5gUXWXwaH22QICHFzMAFFnnMTaB5zFS0HZJEMeCv?=
 =?iso-8859-1?Q?lamvGpf64o49EOl1MOlIJdg0N/7J+XERlvI5MX1CNQZhVT97RKcn90+DYZ?=
 =?iso-8859-1?Q?hMxA5LghmW3xtzVTzPSHrhZCIjxiAnJ+rrVWUMz65o1DqOYBy1biJo6QtM?=
 =?iso-8859-1?Q?6FM9pkdmJtTqaNy7P13kQ0gSKxQCGQKB9GV3NynrSGI/ccEPkyBN89zAAL?=
 =?iso-8859-1?Q?i4mXPVqGWzIw7euuzaTw3+oR97zurEZnvoverS020sctm/7rcy0fPB41ny?=
 =?iso-8859-1?Q?XcokWIkLT0DsGyUghZ71VgM0IuDke182V5M5Njpfb6yBhcRibnJ4KjzS2i?=
 =?iso-8859-1?Q?hG3atWubOHsNNJaivru31T7WhBKc1bffu8coGxH58ji33nRIWxzmKTZVJZ?=
 =?iso-8859-1?Q?s/fwiVGSufkSum+aK1ca2w335TJhG+ZUZR/LKv3I9VZRF8j1sL4BpwBR5b?=
 =?iso-8859-1?Q?9wtUHIWLFV0teIAEYNYLR0TqgsDw+/9UNHB/zP7Zbqwcwxx75K6wVaLR/D?=
 =?iso-8859-1?Q?tdN7Fo6hXQGNVjnrWJoCB0xisppmodVa70h2Mg5xZGab2gTSrfzoKZgfMl?=
 =?iso-8859-1?Q?XBSVQQgg2RKGzUZFmW86PM2QQtv6OMBbBxsC0nukGkcqCnFR/Y+1kcj/QH?=
 =?iso-8859-1?Q?z2+oCE85DuOnmvWguqJFJyG5PvTFMerfJSaxz876gHLRE8ZwZkBdRY5gqh?=
 =?iso-8859-1?Q?QojBlV8wWl6iZvbBSmR570rJF6EF2IhjGYPcQ/M/D0zWHC7BczMbWvJTKc?=
 =?iso-8859-1?Q?gzlDe9kZ1eHZjvLXRIDhMzvuME0c/52V4hXwdwHlDrH4xQw0ldVQXuduXq?=
 =?iso-8859-1?Q?FlxhEzQmDCATKU24J8vymRJCRanYfgYzZjz3p/7jqKR05jMeohOPqNqAOq?=
 =?iso-8859-1?Q?trH+hyFS3WS3LAx+jlYpFHf3ZKTT+W2nlWj2Pd6tpADt2StEELwrpWV7zn?=
 =?iso-8859-1?Q?tjV1GaKL+SAVUaFjvhpNf9oStGF+fP+piKIdwill2SWYZJp975LTkbVKTs?=
 =?iso-8859-1?Q?tDGYHrzehrQnRNb6hFtgHxwU2UxmKwpEIRffsgBp3yqn2xp58Ij5X3ExtH?=
 =?iso-8859-1?Q?ptZuL1ktSl518jNDNEGKI7W8HC33e/Me1qgyUJxSQ923k/Zcq+Yr6rNLPo?=
 =?iso-8859-1?Q?y2lWiu6AnTr4KtK0/WAxzi1M2e0KOsyu7fnp19X0J7Mp55ijlez6rpq1kQ?=
 =?iso-8859-1?Q?cU6MTum8D7ChvAxkP6l295kN2OXueRC+shR/nqR/TbzutdXGy8oVPLe126?=
 =?iso-8859-1?Q?MXuV++wfX9emN9NPvcADoD4UvyjL0NMmW4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175928f0-26ad-4189-a1cc-08dde39ccb91
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 06:01:12.5958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UVROwnrI0uq4hslll6ajkfab2AO3ctmGTnALUyenSCILp+ETvmIzhWNOfXWbbVjwJ0YkBKZ/rddVK3nhQvlBM5ChP9W0y2p8nDJNSFxmYF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7390
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
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



>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH v5 01/21] intel_iommu: Rename
>vtd_ce_get_rid2pasid_entry to vtd_ce_get_pasid_entry
>
>On Fri, Aug 22, 2025 at 02:40:39AM -0400, Zhenzhong Duan wrote:
>> In early days vtd_ce_get_rid2pasid_entry() was used to get pasid entry
>> of rid2pasid, then it was extended to get any pasid entry. So a new name
>> vtd_ce_get_pasid_entry is better to match what it actually does.
>>
>> No functional change intended.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Reviewed-by: Cl=E9ment Mathieu--Drif<clement.mathieu--drif@eviden.com>
>> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>
>Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>
>> @@ -944,7 +944,7 @@ static int
>vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
>>      return 0;
>>  }
>>
>> -static int vtd_ce_get_rid2pasid_entry(IntelIOMMUState *s,
>> +static int vtd_ce_get_pasid_entry(IntelIOMMUState *s,
>>                                        VTDContextEntry *ce,
>>                                        VTDPASIDEntry *pe,
>>                                        uint32_t pasid)
>
>Nit: it could be re-organized a bit with the shrunk indentation.

Good catch, will do.

Thanks
Zhenzhong

