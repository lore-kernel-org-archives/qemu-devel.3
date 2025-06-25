Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1738C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 11:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUOV9-00059A-9E; Wed, 25 Jun 2025 07:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUOUr-00054H-7G
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 07:40:57 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUOUo-0000TR-0H
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 07:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750851654; x=1782387654;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=txtdnm9b7rBMtoLN5OisYBjYP3TcP9PGzOQiq5y5Cgo=;
 b=QEhD+mdjB3HIhykATrYkoCchLvoKCO3RiCNs5jIDi9Sf9D8+jT3lOAN+
 2vL2wCSH43iMM9MoJlViegeaA1r+VWYRS6ea2P9KtCzKE7oili3PclpPN
 Wqz7D+6lhn/mLHg0OF2sinWFkdGb0+QN6kMM39HEp7cZ8XYCG52zC+y3F
 ag4M3zlWJhizgtvmIq1KQWghFgYNps5JVUHfMjjpll5C86Ex6zkELh27s
 B11t/BaNN41uKzn3vXoVHPg1TEJ71Xl+oTV8aVFWdK3I964NfS1yT3Voq
 5QO5YXxkIitptNQoIFuPRkJhqRBSEAOyxD9fu6JnKi2blmz5NsgWWxsE3 g==;
X-CSE-ConnectionGUID: vo8hWo3fRP2CGkOPmbWycg==
X-CSE-MsgGUID: AxHVoC4RT2GcKLF4fmZYTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64473622"
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="64473622"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 04:40:28 -0700
X-CSE-ConnectionGUID: QUNelMYoSBGqfy/1X4xlog==
X-CSE-MsgGUID: PEcpVacnQu639XRje8aSmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,264,1744095600"; d="scan'208";a="152367919"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2025 04:40:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 04:40:27 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 25 Jun 2025 04:40:27 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.63)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 25 Jun 2025 04:40:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfAo1TlCe7T8T1R5ayuUnsY7h601a9vJz32HIEd2g2qc9AL7mz+i8VHqL4xaoExEpAn+aiuxt2LeThyRF7CFzlLW52wWubt+W9qcwVWNdwUdtwPOLikWCcCU9lrJonPHtiD2/aDuMS+C1xA6nsfrNImYkNlwaGHB2jncAnaZBsDkjcWY7h5JI839N/HPnY3Y6yTWoSz6tsGNQ0tcO+XSUN+cgjtQzdQjNcSbXq2MU+Paj3nRPBpROG+T9iH7l3sRewGUaxh81yFjmKDKyFPcgftQ+hiz2PPQ7P7f4K5vB6nfC5eIkIidcanwl7+1t/l5pSG5n3mdz0x1ioxWTehq6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkg2bhCJdSW45weBtZ0xF9uFhx5HYFBB1jGx/60MbyA=;
 b=p+GgZEf77RHazQuCp2zC5p8nnK9tATmq4g5pH2O6yW7qcTy9zd4Zw45W5nwIQ75OYchhHpo/Dv42J1tXTXuwXHlntTBWVjs7eJ3lzOScx5F254VCaJE0kSnRrvVO7zape4DthFpDsV0OO3dO+ibyfVc/JeqVAYcB1CtvRZ4vghOE/D8uXKPO+5r7INJEKX/BIithQMw2IDmC58qO9Z6xnDcsazFcmHlSYnYRJlU5Em08lF2FSeVsVyaZPVwoy/+OVb3PXK/x7QOME6Kq4Qb9HCIsWt2n+p9aB5zUEEjJNAl72pny0SXSF1OYZAqnnMNRvkmwZroIHTyabxvvaS5mcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CY8PR11MB7135.namprd11.prod.outlook.com (2603:10b6:930:61::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 25 Jun
 2025 11:40:18 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 25 Jun 2025
 11:40:18 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 37/38] vfio/container: delete old cpr register
Thread-Topic: [PATCH V5 37/38] vfio/container: delete old cpr register
Thread-Index: AQHb2h4UEWUklP/JP0ijlEnQ5UZwnbQT1Uow
Date: Wed, 25 Jun 2025 11:40:18 +0000
Message-ID: <IA3PR11MB9136996F0E3BF64CBDAE9AC1927BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-38-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-38-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CY8PR11MB7135:EE_
x-ms-office365-filtering-correlation-id: 15a8c40f-0e52-4236-b12b-08ddb3dd0f6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?HqDzGoQQiTgbUstuBVPbOkEZ67I5Bs2L3GhSf4O1zi+Ln9/tBD78OYbnUN?=
 =?iso-8859-1?Q?4UPdQ008whyqBm4fOoXicSQP8RKY0/ilZsDMf4Mp4wdTzWjhMbxAAoP5P4?=
 =?iso-8859-1?Q?fSCfUlE68VdMdGxEs14MKfVbL7BAUaMzPymK+qwlrivNiXhOVyqLdsoy51?=
 =?iso-8859-1?Q?tlHhLjIOL0z/GVcdCkpH9+4WVp0olIwoCRuNGKOxnhooDKZxQGqV70v5KT?=
 =?iso-8859-1?Q?wP4bgo6EjemUAgx4N9qSSZ/mMhoVwxO7tB+KlARPEH2UOOdFInhWcYWZhD?=
 =?iso-8859-1?Q?g+BSfOJKcmJC7qKmpc+jbSLTeYkItjNCRl0l2GQZpvs/TrInzU9ErRy/3N?=
 =?iso-8859-1?Q?h6JvCMFullO1Z107TTBB0tUogJPkiopDahsVCRhOQsOeYDUA8N8g3UnMMb?=
 =?iso-8859-1?Q?fksOv4UgP+sOJBMxpH6mxbi+LmhNtiAei7mbzvsv9LkiqAljyVQfXMz3r4?=
 =?iso-8859-1?Q?FWyV+TOX9NLKOX4UXNfxAHWFZxU6fUckpEpacP+7y+2Qd9SGd+jSjw9mX4?=
 =?iso-8859-1?Q?xF9beEui+x9tF+edN4nLNB0u+1bzW9Ojk5v25E65oNKKlpCU+boOymdnSj?=
 =?iso-8859-1?Q?pJ2bSsnwxfQBHjNuAWqq44aT4lxpEnFuJ2qwQe8AdDF8wF8ZOyoUUzr/2i?=
 =?iso-8859-1?Q?0eNoE5UestE62F0qaf8pzZ9mHkgJlh537squp2MydlYG02rJB4FvGznNHn?=
 =?iso-8859-1?Q?4ypCl45pZIY+rY96GvXN+C7cPZK95FoN35ZDotiHYiZEBwLLeTkeVE9PJ/?=
 =?iso-8859-1?Q?BUolmywJRwUv0pJCL4Fk6QOm+JQnaEnX1wtMR8L+CwjObsuX8eA2P+43TN?=
 =?iso-8859-1?Q?cFQIQkFVK3YJSSI9+9cU7Q4BUeoO1Os3Z7OVS+D/J7kW1kHqzvXmHy5rb0?=
 =?iso-8859-1?Q?7t4EMCg4FyHkM6Ne8Q1DXKTJx4PMl0hS7ObAupxIAHJpiFhsdRS+ptohPn?=
 =?iso-8859-1?Q?1V2DxtP/yORTaJ5TxtRUW+90PAjtZF/K2k64sBwgBwDTh8Vfm/sJYuqtTZ?=
 =?iso-8859-1?Q?Y01SgXwBrKNZgubvmtd4Z8DzGVmwck+SIeVKScVwgwA/V5wodi0R4XC5bn?=
 =?iso-8859-1?Q?d/s/gg2BfFkOwnX6jfChsB+HlBlx71qquAkRkDNxGq25e8Nf8UnZ/rBvp5?=
 =?iso-8859-1?Q?/Vg4ULTNH7duk9r5M9oXoNQMuRQgdyIL20jjfop9tZpc/2AVZcXpYVPyQN?=
 =?iso-8859-1?Q?gko3ucl4WCLejk1uoeMljgxS83qldrz292PRoSrYCbwmNlU0fTBxoiNDoi?=
 =?iso-8859-1?Q?wfAVGSrFTaVmO+Cor/tHbcmV2Wh9nxvM72hXbkW7da0swtxET2oB8hadWj?=
 =?iso-8859-1?Q?EE2Jd+l/C+wGIuKPO3OHkpHgMTKKiRAPuiKLPhdOQmlyjjsevP4OYrsCZh?=
 =?iso-8859-1?Q?gwEi44sVWY+9O/FnsPtqMMQczVGthXfOtYKByBDIuvvWGZ5vA8xOr24VhI?=
 =?iso-8859-1?Q?fkYSFj6gVcceuRO6pfv3bhHVLLCIbJAx5MDe5PeZv6Teswy+JtP0eKJBtv?=
 =?iso-8859-1?Q?UpANNpFkfJ1RvS693p1teXL30tkTmq9JLO437q8uv5+pB3OrNZVvrSH1Cr?=
 =?iso-8859-1?Q?66psA2I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3D5y4GXUx0Tdn+qklxiIDyN9jKaZZfrkaTmnNM+BJ4Tj7s/Gtx/pdhtkvE?=
 =?iso-8859-1?Q?4Yc9AgpWkjh2nWOGsprl4KlAwbnGabTpAfA5yRI0QEZ/CRcvtkSsvyQl8S?=
 =?iso-8859-1?Q?Ur1SulzwMU2uiPLF0ZC1Bw5tZoK/r8Iri4Vjz0tfxvOerucG4drIyC7JBF?=
 =?iso-8859-1?Q?3QSucJk92g0nboNCAIn+jbVIwVMHVuJbmBRPMR5rDrjBmIaeEU4CmOwKO9?=
 =?iso-8859-1?Q?UZ79M+eWeUB6aoi4Yyx7B6Qn2lERYLW9wqc+GjOIbrDlww5Y/mIyps93YS?=
 =?iso-8859-1?Q?6jZ3FluFdSI0BJfwrSdmzTeM8ZLM2AkqUD5OVES+1kcZBqh3aj92QL9rk0?=
 =?iso-8859-1?Q?3qtWJW28RWIeE+Ff4gBSIwtGR0DaE0FRCyl45fJOcfb65rHuAoYNYVxg6p?=
 =?iso-8859-1?Q?TZE4qUVso9W/k8vWss8fGE3aRwhUCtOl24KgcAKs7EYBwmua05sx/kr0ia?=
 =?iso-8859-1?Q?Z4gFVbvGqlVxpvVF5ZiIltLfdvFWhK+EALtJf3TnbNdW6nWC+t+pc1GQDQ?=
 =?iso-8859-1?Q?tsBBMcihEkldTVYmPLQC7TYKSm9JWO2un2r2VpdHnBeE8VECZx+rk61g6T?=
 =?iso-8859-1?Q?/5Kw9hz0pnKbmD1whVtjcUIq1FO6sm8bABFlf8twJlO5EopTsHVGY6sDHG?=
 =?iso-8859-1?Q?max7QOTO2jk17CSTb7TV2TGCyxkhdnSoJdJ9ntftvrQvPo3iDZWFg1WTiT?=
 =?iso-8859-1?Q?DlfKglbQ+wkgibmH64KAK57/9DirCLsIIXqe2K7vox02huXDiivf+ZCWtG?=
 =?iso-8859-1?Q?qbp7T2QihZg7zf25ZicJUIL6VR9Sg3yB9RuHad5J0ZZVSmGtcsvto3vVAV?=
 =?iso-8859-1?Q?3DIIGpqquc+5r05Bq/HoR8qb+33cSCM3VMINENn37eTRY9AeC9M29K1Tnk?=
 =?iso-8859-1?Q?fB7KTMfZ800S2voj8DGBB4LjpwWcCrjZR+IP9sStehEbv3j6Ht/B0HW3TZ?=
 =?iso-8859-1?Q?tu6/Kg2tAWX+QQd61bvC/dndLxURgpHRH6rcRbaLqs9ThmzJmNPB2mo2Ib?=
 =?iso-8859-1?Q?y4pIjvfU4V/cfvoBFk+pSxZga2tAeObgzTW44JRebsFx3meK5wcC5KnpNI?=
 =?iso-8859-1?Q?vqt231L2GgNulzIa0krm9dWbFlrC4xV4zMrXZbzVpkJM5lg1ta9/fD561I?=
 =?iso-8859-1?Q?Lx6cTyrWkXSxQswN+P4lfXTL1GvyIqI1bbTBeSSGFhyH7/bWsS2FJ9Q5Ax?=
 =?iso-8859-1?Q?cfByVIFymiAdiZZHl5DXvP5JJoJoxjltRO1Vh80xt5ohnSV37New0lFQxZ?=
 =?iso-8859-1?Q?bySEzmsdN67cBZ9op9pFQ4EWI9tXr/2w92dzUGZ0uKpZyysfo15Wh8+gNe?=
 =?iso-8859-1?Q?9bPuy23aoeLAXU65B847B/wnqu8H0dvd+/3N/gQdgHQO9ywCZnq7zrxmfJ?=
 =?iso-8859-1?Q?loY6NIbT1e2dG3z3LS07VJDXSGQV0dswheP+DxH7eLFfOGI5E4r+pvXlf/?=
 =?iso-8859-1?Q?laIZUh2OXT8XgydRO3nog3Pa9E1Xnxt6nh4sS+sUyQsNYJB/AIMKYrfxcX?=
 =?iso-8859-1?Q?vEBoplMyCS0V8K9u+F+vcDo10KVzTKJVTR7IXG7VeTwHGSGqskz7+hrQ5K?=
 =?iso-8859-1?Q?h0uLTAIfKxx6dU39TXVKmLVVJ7HfT7hZ0WOVHxQiHq25lu2DWDfCHIOf6X?=
 =?iso-8859-1?Q?81GwR1qwsrz3kZ1ac+xHdcME01/llK34xO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a8c40f-0e52-4236-b12b-08ddb3dd0f6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:40:18.3960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ylYeYwW6X28sFYn55cJJPCouOrKAwLuqQ+fngKfXz4LXCbxr4qUjfP+AhVSVnG2a7jx05Lf/7O1Tt5z+ET/+Uk9c16JoOp6ZIm+603xBDSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7135
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
>From: Steve Sistare <steven.sistare@oracle.com>
>Subject: [PATCH V5 37/38] vfio/container: delete old cpr register
>
>vfio_cpr_[un]register_container is no longer used since they were
>subsumed by container type-specific registration.  Delete them.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>Reviewed-by: C=E9dric Le Goater <clg@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

