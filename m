Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DF4CD4F5F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 08:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJT4y-0000rX-Il; Thu, 13 Nov 2025 03:53:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vJT4j-0000Yc-8B
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:53:05 -0500
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vJT4g-0001mh-Em
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763023982; x=1794559982;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ojQjRXodIeedUWhxXszKkWwnOLgxxI6sXRinCgQMPkA=;
 b=IER2pkvm8q5kNhzfKCdroshykkZq0vHVzHGXp2pG3LdmRJu7hb6QgD36
 7aXRgsmJn/MW2TKYKxR7llCyiIUkmpyKH0702VurEciQONJkxWQmrZlN0
 azn6Zm/Gi/jPShAN0cn0A+XGjTbs78AZCdiy/YIq0Iy7V0c50ANWThkMR
 9Nw+J/QL3P44Bp+T3rFbp4JaGpGICoqNU/vZwRAVMMO3keR4PjFmYib04
 D29ZkKunGG7a5IAvb3aJA85c8U8wSjDZXJOYz2WB8f4nKDDYw+NO/2Mw6
 wdG+KUphhYspcohWgcl+4TIaJ8qYT1Jwgm4oGwnGwIP5xFB50qmNbBCIR A==;
X-CSE-ConnectionGUID: vcOkKVgPRS+qzx1kU8G2+g==
X-CSE-MsgGUID: HIdqej2WQveJzpcFFXnCfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64304673"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="64304673"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 00:52:59 -0800
X-CSE-ConnectionGUID: r4XdIHadS2mgrFL2FTZixw==
X-CSE-MsgGUID: l/MJaxuRQnKyhDsA/6YX1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="189290511"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 00:52:59 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 00:52:58 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 13 Nov 2025 00:52:58 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.13) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 13 Nov 2025 00:52:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tM0ei5k7nbZbWIUJTtBDI5HWiaC0DRfTSkwh5iYEADMgSjPAUF+Vb+eO7sBytjCyB4xT/Z+QxibB+vKZPxgppvBmDi2BxRSTvL0EzwyQ+InkB7aAFk9Fk1hPjcN3Ywug2ZA2K28eqdmb6CfJrSKE0YE8fYgwO4SFjZ5jfNeH5A0dlJWBsHcWlxMvXGL4evT3aCBPxMghFcvz03VU6nkKKvNJkaKlk68mSHXU4vpO9JaauhQ6d6DZKS0KsxZg9d0Bf9VaRDXP0vg5KxaHHSzDzIIaa/A+4tX8CsNy4pAs1ruh2Um2Ap6+XEnFZzRUmMCct1ri1XVJiKk9dpK4YL5XSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOWWbFEgp7bgLswspeD5Fw+CQ1vvUVcVCvaQLqBz1tM=;
 b=FTQg/taSce2gGdWbFbzdNP8oyuEzG0vXakd1oXdCm+Zhzv82DnFn3azupBefFD4VsvtZh9t7p6XiJid5u5gMq8RpMM1nGIryMN+AF8oKrArchgrtsTGCeS2M6PIB0SAaMLrfgHbGwIMNBadj8qNt7sbs+P+vYYAfO9tvEW+NB651gCVSqcmOdQ94y8gr8UOhDtmR4Wxd0z/mIUHNytu0HCRLpV+0ofgiTJdocFOWB1kvsxFMM6cx137Vjj5den4UvgNoOSTCECKKv3mDEN/Gn5hV8zAUg+VezOwBeMQQtUcDkXN/ir5wLTRhTrdugrDNHgwL1J8t2poVBwr7XARJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB6402.namprd11.prod.outlook.com (2603:10b6:510:1fa::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 08:52:56 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 08:52:56 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v7 19/23] Workaround for ERRATA_772415_SPR17
Thread-Topic: [PATCH v7 19/23] Workaround for ERRATA_772415_SPR17
Thread-Index: AQHcRMKfeXHyQowlQ0W5iGBKgUDegrTg/igAgA8/jGA=
Date: Thu, 13 Nov 2025 08:52:56 +0000
Message-ID: <IA3PR11MB9136D1A323FFE88DA66E632892CDA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-20-zhenzhong.duan@intel.com>
 <ee36b44e-ba84-462b-be43-bb00b0b4158d@redhat.com>
In-Reply-To: <ee36b44e-ba84-462b-be43-bb00b0b4158d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB6402:EE_
x-ms-office365-filtering-correlation-id: a3ce1ed5-3eb7-403d-34ad-08de22920a19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Zddg2QlDa+1PotL275anEaq6GmSu+RuJifBwOSV3wNyIKNRhFcs+9EyINJqf?=
 =?us-ascii?Q?CF2v0j/ES14fYE7Xfn48QHYoxLn7KWqHCkhEE8Ez4tsnblaZU08gjyVFSvMB?=
 =?us-ascii?Q?J9ATazEVyWjXCPnV80VAXTBnfZ4tuo68SRaS8KuqaCzkyfFquyGP3aMSDxni?=
 =?us-ascii?Q?yvxsZ3LzHF2RBba9scVOFlZYOedgPsWrH4B5ko2o2aywgIx4En+ji05rtPwd?=
 =?us-ascii?Q?fg9BAfLbeYSJadv1tZ0g/nuuTXX/aoYq4Mu4utR8mU6D/ApRY62bFCShc1/C?=
 =?us-ascii?Q?+zPjbgiqsNrEoTCXHZmB/Z0nYmNNV9WIsrNbtR3rprHGuRFfh1lqdSOVYXHg?=
 =?us-ascii?Q?eYud3z/EvYrX4DzF4H05CfF9d5ek9K78E4EeH9ayslmh4uwR/1RXlYwZMruu?=
 =?us-ascii?Q?6fbaauhN2LZZNdel5VuaxTu07sr8oPAxRV1KVU6s9KjBGorPGCAminIT81Fh?=
 =?us-ascii?Q?A2bZ5nVXFnVUrHLcTbt4lYZxqh5389+XzI8FnYAxZ4AnA7L9HyO5K9dcGu7U?=
 =?us-ascii?Q?5mmmal0dfGJeai4PfTdmhZnztTyLCJPqLiAbz3V7fQEn6OLAqKpUH+keO4Ae?=
 =?us-ascii?Q?7K5FwchbkYXKW3U/LVF8+wdZaGmZ/lMxwct1QCWBPvWQNH0Y3Ch0lVcohJvH?=
 =?us-ascii?Q?zJQQLc5uq7edd7C5kUhqRhcuWuYYV/1d3/tA+5pEhZ0dHqoviPqFWw7G3WbV?=
 =?us-ascii?Q?CycEfdI9Qv8B4OMbHvOgesJTuHqoO40A2jXVmeHXnSmv9lzH8UEHOfgU+tte?=
 =?us-ascii?Q?Eo3DjkEdt48Dv1pbCMLIu8evTzfzUhIW4DihCMNJpftDoYi7grmEF8tJxLOK?=
 =?us-ascii?Q?UNG9wfllEfY28hgWd5PDa7GrcovGsYuWPJZbXWe6j/sdAYFPH6RI9U1pJt7R?=
 =?us-ascii?Q?apF4zYbykEE60hwXzVZTFM5foHjT9Yg2dP9dmyzj0WlgPmP6xbjpM1u2TaRW?=
 =?us-ascii?Q?KSadlRwOgiKB7CRJ8Pj3mOE9YaHjHU09z+VRN2ggr6Z+0inVpYocHUt/K3EG?=
 =?us-ascii?Q?SKXIXg2m/W9s65zkfbn7hd4uX8mQ+AlBfvKpghoJKOHOylpmc6WX5/Dgrjps?=
 =?us-ascii?Q?VLThm4xwrHBkGK6YXmU/USyFSDInMtF6LDKV1VPuuJ9XP2iRIhHLmsyUVmPQ?=
 =?us-ascii?Q?ezT91V4eOjtVHxUKkCm5BjEdwhxq3Tceee+4DXp3SuyHf3z5EDd4CqROrxw2?=
 =?us-ascii?Q?l2qRo+wfV4UZ9wcy5HDd6AyqqwG2IiAW/SgFEKDE5ChEkqBS/2mOiZJvYwib?=
 =?us-ascii?Q?IKO+q22HVwHMGfBSomvWeumU3BJdrCWKkd/00cTCd6W3DqhuBhop3KV2C8Af?=
 =?us-ascii?Q?bcYpRE06LVsJVIrMrETdVIV8Q6XgfOJS2u5grqzyA4tdTIVzHBznSg2YjcmN?=
 =?us-ascii?Q?Q1r1Cdf1COUM/J4H0zxNAjD5dkHCyMHsVskEJ7qGLBeUe7Q9skfpbDugQrun?=
 =?us-ascii?Q?bC30Z5yJnqQPmHnQUqdKtEogsatHqiUt9hqz1PUv3+oEZuQTBogbtPrIfthd?=
 =?us-ascii?Q?Q8mdtoj6pB/YtCaEPktnUanbR5yDNHeTGfcn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mPf/MwoqXdnw0kzKtjCQkcw5Eq3NgVMROHJcUhifZkcplc/ro68FQgdDSD5R?=
 =?us-ascii?Q?yeTTC7wEq/3/q20FnWMLy5je+lyfVWx7YpzYFSonRcTgvyQcqeG5WcMHov80?=
 =?us-ascii?Q?9Ffqd6kboSbHQxg5k69bFba97Jg/alZhWrnOtAqU+FYc4bP0/B1SmTXdl0B3?=
 =?us-ascii?Q?Gvt+GkyaGWs6NwMrB+2N66sd7dci0S8d/DTUtsdrsWYG31KgLYQm5WpdQAvn?=
 =?us-ascii?Q?zyyL+KMd+SgI8lktH4GdSdzbERpYXmDCHg2fPstPKmYA2A7KXGscbLkaoJAI?=
 =?us-ascii?Q?F/VwRowzm2GO3TasgjYlySn9YZv2KcEd/APMqyXdU6Z3KRjxhla0cXFaS0ML?=
 =?us-ascii?Q?FC5YCSoSw1aQIQl3cd5s3wegps/wwn0eRw0yBdkpa9EoDy/tO2hlvm/N+Y4B?=
 =?us-ascii?Q?bQrqPo81KIvbbM9gYg9LYmNw+S3o4S31xGMr+Y4TS0i7FN36Kqkug7pNih1T?=
 =?us-ascii?Q?huv0bMkfBdgXnSEUBCVK5aTb9uqb9ghPHyoqmU8s2XOzZ2s3mkxOB6QMtSUI?=
 =?us-ascii?Q?te8VnrSMsYzuY0ovzUko5cQvdGQijS9jVXHbINSkQO1bMZ89sTotDH0zZJ5X?=
 =?us-ascii?Q?peRYA4trVpl1/VpDsLgMoxofeLDurN8+LB2Ssup0T4UN1zldu1ip0iCg51G5?=
 =?us-ascii?Q?laYC0r79fSnbxfCvRH3xg4sRruwv1OLSPHUfLU9ihZjO2w8++bK5cwx6rajC?=
 =?us-ascii?Q?HumhLDw41A0L1pVi2VI+Bqac3gg8LYU8Fivayy7bdH9RFkGH2FM/0kVKuapB?=
 =?us-ascii?Q?MCrIhQAT/Yk1i3iFlUx89ShMoCYnLNIg8gylOQt94GKRSXmunhLuNOqeVPvX?=
 =?us-ascii?Q?MfPyvfTQ86OwrxEF9mW2FPAYaVBBH/C0mn7afuW8BAD8+mxBDYvleWYa9Hvi?=
 =?us-ascii?Q?jPUXXzCOCBim0bh2wHv1gau7CN19/uHs5iKiidFNk5dMwO7IkWh2dDEthsM6?=
 =?us-ascii?Q?1l1djJp3C5B7ZrVHVEpzhQAHfZ9zSYyW5VMgag+W18nvueLBD4Qbx5mEeLDN?=
 =?us-ascii?Q?iF3i7dLiIaCew1Pm7vgld9VKCKkgyuV+RpCSTLuRL7Iv9iC52t0a7rXHLRwY?=
 =?us-ascii?Q?i6gZWICTES9tSYoAjFzi0lDsgsPtdUlTs8Icym8fncWNSMd3zo7eflGNbxdQ?=
 =?us-ascii?Q?4IyEMnMejY+U/NzSPPay5AjK4Gp5PuKC/ZFADijRKF/XOnlcgmiz/xRj8ZGT?=
 =?us-ascii?Q?JcS/7k9pNiMN9RbSi2EUa8byex4rbEggzChFd0SOuE/ZpLK7g+AH8J8hjs3W?=
 =?us-ascii?Q?46Jw4IbO7PmCnVTq9q9xKZ7GGds0kTZzpQf/9yELk5lZZut2SdajIVUuOvPD?=
 =?us-ascii?Q?hDCSgvNj9GBrTUSW3pQe0Ht21k3PyntyQLqM/Kk9xwx70yy7lc6NMnklEQdU?=
 =?us-ascii?Q?j+5REKC5qY5V804k0zdBCG6vwIrX6VBbmjsH4vGPhq5k17TMaaG18g41d7vX?=
 =?us-ascii?Q?cXxzRltKtoJ4t5c585cbCYmpu/XnG65x6acfqXjU1bMgRuZtSirJBA0wU5/H?=
 =?us-ascii?Q?LGd4WWFsJF61rspOccadkoKDlyy5roUYf70c9xQQWJLeNBiG21cP81I79wHX?=
 =?us-ascii?Q?xAcbM9Qhcbh9s/VWgDK+J/PvBxyqODGPVuZDFImM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ce1ed5-3eb7-403d-34ad-08de22920a19
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 08:52:56.2914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wyn5J7V4fbGvlRubwceLghiPyrJmk3CAYhtiK7bZEfyK2BjvSbFCC6UveHR65vols7oe/ci1fno0U0aKLSX7VPdpjU+ZFg2qF+RYzHbdwYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6402
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
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
>From: Eric Auger <eric.auger@redhat.com>
>Subject: Re: [PATCH v7 19/23] Workaround for ERRATA_772415_SPR17
>
>
>
>On 10/24/25 10:43 AM, Zhenzhong Duan wrote:
>> On a system influenced by ERRATA_772415,
>IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17
>> is repored by IOMMU_DEVICE_GET_HW_INFO. Due to this errata, even the
>readonly
>> range mapped on second stage page table could still be written.
>>
>> Reference from 4th Gen Intel Xeon Processor Scalable Family Specificatio=
n
>> Update, Errata Details, SPR17.
>>
>https://edc.intel.com/content/www/us/en/design/products-and-solutions/pr
>ocessors-and-chipsets/eagle-stream/sapphire-rapids-specification-update/
>>
>> Also copied the SPR17 details from above link:
>> "Problem: When remapping hardware is configured by system software in
>> scalable mode as Nested (PGTT=3D011b) and with PWSNP field Set in the
>> PASID-table-entry, it may Set Accessed bit and Dirty bit (and Extended
>> Access bit if enabled) in first-stage page-table entries even when
>> second-stage mappings indicate that corresponding first-stage page-table
>> is Read-Only.
>>
>> Implication: Due to this erratum, pages mapped as Read-only in
>second-stage
>> page-tables may be modified by remapping hardware Access/Dirty bit
>updates.
>>
>> Workaround: None identified. System software enabling nested translation=
s
>> for a VM should ensure that there are no read-only pages in the
>> corresponding second-stage mappings."
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  hw/vfio/iommufd.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index f9d0926274..f9da0e79cc 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -15,6 +15,7 @@
>>  #include <linux/vfio.h>
>>  #include <linux/iommufd.h>
>>
>> +#include "hw/iommu.h"
>>  #include "hw/vfio/vfio-device.h"
>>  #include "qemu/error-report.h"
>>  #include "trace.h"
>> @@ -351,6 +352,7 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>      VFIOContainer *bcontainer =3D VFIO_IOMMU(container);
>>      uint32_t type, flags =3D 0;
>>      uint64_t hw_caps;
>> +    VendorCaps caps;
>>      VFIOIOASHwpt *hwpt;
>>      uint32_t hwpt_id;
>>      int ret;
>> @@ -396,7 +398,8 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>       * instead.
>>       */
>>      if (!iommufd_backend_get_device_info(vbasedev->iommufd,
>vbasedev->devid,
>> -                                         &type, NULL, 0,
>&hw_caps, errp)) {
>> +                                         &type, &caps,
>sizeof(caps), &hw_caps,
>> +                                         errp)) {
>>          return false;
>>      }
>>
>> @@ -411,6 +414,11 @@ static bool
>iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>       */
>>      if (vfio_device_get_viommu_flags_want_nesting(vbasedev)) {
>>          flags |=3D IOMMU_HWPT_ALLOC_NEST_PARENT;
>> +
>> +        if (host_iommu_extract_quirks(type, &caps) &
>Given that call site, I would rather implement a new PCIIOMMUOps, no?

OK, will move CONFIG_IOMMUFD guarded code from intel_iommu.c to intel_iommu=
_accel.c
and add new PCIIOMMUOps to call into intel_iommu_accel.c

Thanks
Zhenzhong

Thanks
Zhenzhong

