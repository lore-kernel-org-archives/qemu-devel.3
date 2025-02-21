Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F5D9C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 06:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlMHN-0006EP-8G; Fri, 21 Feb 2025 01:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tlMHJ-0006E1-WD
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:12:51 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tlMHI-0000ux-3m
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 01:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740118368; x=1771654368;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wZHtDQVBD1Nruel5DUOsGhUY2/ZDAYOptsrXFetlI1w=;
 b=Sl2Nf5cSwNndcJiQPKnPAivoDLM3oj7C+LKqC8HkeZvfCtrdcIGm6rA5
 rRNX2FwVRRuhwG9DhmCiui3MAD8vIFaP9tzpRp3J32tifDu9zCgyvDqLJ
 uZr63n+nIs9zf7DKQBRG/aMbE1th9ijN2nrq4ocwHSe9OCLFG1FjFO4ZM
 tZ0aUdVCizwwonljaceBr/PA4j9JTQ/1D68Y/Kdaa75SeHLLIti36ViSk
 CQ8ee4oIkg/Bx1/ffkvq9c+VPZiZffRTHCGDJE/bTvpmzdl3c4K5A3VwH
 yj+GmzI3mGEeKtH8rFparA0anAwMtPhY4GZv/cIVJMcbptsXFcurpBqLL w==;
X-CSE-ConnectionGUID: PQ8re1OASP2yXVMDyvZF+w==
X-CSE-MsgGUID: jzliTU+MQjKFPh5yI9F6SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40642017"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; d="scan'208";a="40642017"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 22:12:46 -0800
X-CSE-ConnectionGUID: toqn2HnpRDiO+zgUXHYuWA==
X-CSE-MsgGUID: HZk1/7N6QYynGWsKOCwJOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; d="scan'208";a="120211483"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 22:12:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 22:12:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 22:12:45 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 22:12:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBvjiOTgeIRcNEOfFxuvtbiv+O3eNb9Kn3mEYzdJM97QSO6l2KrmwCE9JWmvNVdeWMhkO1DTsnvYN3vhwvEBm5AD+9Y0wiagLVqIkhZGfweZGIPXu3bySo+8t6SKDSu2e4aVxsw0DdkY3TOyoHGSKPR0CHhHfA+mqOVL2o+o35nkxdHXnmeUKs7MjI13Yhs1JowGUQH9t3uv65aVrdZqcBWHNmZxeEhLzwCrkgN9FdLHkGSYf7FNlpTRoaC4l0GqAg7Hxdv2pTyIrHjI0gXx3ZD8ex3IE0tyJH/hFAYygoBbiK6GsSJMy6MtQR3IqXw8D0Pkp10nbH0x1NF2HjV2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfO3Bq49fsr6tPnfQxpbc+bFc5GAT539Jtvyf6zZWdQ=;
 b=TVOuqOxBXez7b+uLXFTL+8X6h+ZKpC4cntS4TGpPU/2SE3Bgh+aBI9SbBjhsBa9sW1vItChqb5/h4T5Ykfh1A9yu8iDiAKp+wqL2mWxdNNJp5Gal52HHfbeYngCodxxJutAYaWPc7llVrFUvVuWwlk6g2Ek67q2lSXTbBCZmETsLANc/ylaoeHtfPvlktgynTw7n2nXSIjndMuBEVv8nlA/fNOEwb5AdTBeY3i790H/fIymdyBOHPmRPMBQdYgcmxsrdyEAvfETMaPq4/4Yl+agYsRpttqK3edPK73gCUhrDJVd70r4Cg5YP1GpHrLiOTZmKsmkdKeRG1QPGqB2SVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA3PR11MB7556.namprd11.prod.outlook.com (2603:10b6:806:31f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 06:12:29 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8466.013; Fri, 21 Feb 2025
 06:12:29 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH 4/5] pcie, virtio: Remove redundant pm_cap
Thread-Topic: [PATCH 4/5] pcie, virtio: Remove redundant pm_cap
Thread-Index: AQHbg+nIoZcRdmfLyU2LmXS835NR5bNRRkVQ
Date: Fri, 21 Feb 2025 06:12:29 +0000
Message-ID: <SJ0PR11MB674457591D328D9178947A6B92C72@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
 <20250220224918.2520417-5-alex.williamson@redhat.com>
In-Reply-To: <20250220224918.2520417-5-alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA3PR11MB7556:EE_
x-ms-office365-filtering-correlation-id: e929f12f-7d96-4c0e-ef77-08dd523eb896
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BRMm98RXwl01EeceJrVJ7dEThT4HTjgV1aTReAAx0eZW2m3O3TVYxSpzX6ex?=
 =?us-ascii?Q?2O4p5M6jt8p91spVLWVyzRO0oWedo1OvJr9+pPxgedyxZS+06uQ1NsZvTwW+?=
 =?us-ascii?Q?eZ3MFnnWuqUuyjmAo+5sQOp+9IppxZB7FMq1EBY8D1bAO914ekIwOJKWkZ4+?=
 =?us-ascii?Q?Fc0k3bu4fp1bnKBrrjjg9E9INdDjfTsjf5e/qd7+ETsjHeK84Se77NsgXDH+?=
 =?us-ascii?Q?4Hz2OrK2rFDTNWSfDuTOo+IXgIAuOOLxCcF81kYLeCOlQyeoNS9jrOAfxR+Z?=
 =?us-ascii?Q?iiykatpLtGx/rI9vS911x1rXoa22s2joRLnf5qHeIgWBPO9aGMZ2NED8FwcD?=
 =?us-ascii?Q?rgjkCOEslWf0/RqL9hxK26/mtN7Y/NxyD1nkQnFv8l+zLE21wBHyxvranKTo?=
 =?us-ascii?Q?HFFMjwO/eKq9gyf392BhBK9Qih0WpKC/UCTxEGLSLli1+7uLE74Cla+cJOkb?=
 =?us-ascii?Q?NwYznd8rLhxiUirgte6/JHiaUSuUPO7dQM79X/Y9mEyLlQblfpd/WlDXRwa5?=
 =?us-ascii?Q?38280CXob0+3fOKeRKoEvzjyF5yPgH5d2hu+JjvJSvaESndE0l6n514zU5J/?=
 =?us-ascii?Q?Ic6omffwX+M/jNJB/KydU2ikr7mbKnhh+ra2cZpbmiRvNNRuJxWIrYax1xC+?=
 =?us-ascii?Q?me2CeCr06XJuPSm62eAH7LDRlVY5x51TqWw0rVOPizz0k4orY7PVJUvl4wSh?=
 =?us-ascii?Q?Eiz6Wl9GxQfVf84xWABMxkOC3tJtGUTxdv+4OED6TremRDMKHvXb6fDBSdcu?=
 =?us-ascii?Q?XEgmj92htRA6t4oC9mRkjCsLReucIy10SAduryU9YF35bT+CRNuHYDkF48RK?=
 =?us-ascii?Q?ukD0/BKcKXB5p6ovfjZ9j+yr8th6ksDxEzYlVWOSizKRnzi8qlazsK8UV4fJ?=
 =?us-ascii?Q?ecKu8u2XoOBZls0F0O5rP5Ded2nVXv4qgbXa5JrCZFIRh/u3cOG5qKRMvsTX?=
 =?us-ascii?Q?/8L1hUq87a0V17FvlpdL9aYtnnc+nVD/mnXPGMT1Qo64GiwS0BPE3oMvz5Rl?=
 =?us-ascii?Q?1S8XwqWqlL16/RaDSoLyeqgeEMZPRI+dsrxQkdq846/RasAknKN+88bVDeVx?=
 =?us-ascii?Q?zq7N4pl5oAOKCfsNv5oR4CPwtXiSZkYctaD23Ih7J3jZNxnAAUGDn54UwH9E?=
 =?us-ascii?Q?TJq2mBNX0XsGxEPO46329W1RUQ9jxaE5vMCWx+68PlcHx8RRGtl5TQcc4rCe?=
 =?us-ascii?Q?YlPC33PJ8zRv86sdU/MjsDS8VXr1f+3AcJ/GBq2aMcKfWGgy5EtmpIWguT/Q?=
 =?us-ascii?Q?oa2XRlyiEhrrKvMFmEXgO4GxxMo3jfrb6Gf3ENEcFvMycjhC5DeTZq8spefp?=
 =?us-ascii?Q?/doOavihZ1n+kGuN/TD5VyNMvqSEOPb3iERGQvTGC53brI0JVaIPXJ3GQl8a?=
 =?us-ascii?Q?Pce9A8m4u86YN4EvV89OJ+s/2KCzCHie6QDO5ZupthBszjuL8ke4AucSMMnh?=
 =?us-ascii?Q?bPgnFtZSegI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?91YSGnnCTPKJ0Zb753x7n2WpZ0Dw3F9yq9OX0FWG0FzjsnLIu2AEP/WHucOs?=
 =?us-ascii?Q?irIlpAp1hzg80iKAXpyz3m5mTUw2LXoQ5lVTvh46AaxZmEE1wJqyATeX27FR?=
 =?us-ascii?Q?KEqK4PPaLGuBfiNET5ldTLpWWWDdLVgZf7trmbSXL45zfApLsk3ws85ZZ7df?=
 =?us-ascii?Q?P3KrSNArV3Vp9soKKdv6j5e7Tzyf/ELA6/EmWfgz6H5ouyy9Lb+3oaV25KMd?=
 =?us-ascii?Q?ShhHDUqObBq6Rx4LU8LKq0OoP+tyRZ4o73+Iv1hXNkHaRvkMPAi/kg20W8/o?=
 =?us-ascii?Q?Ax0Nn2EADxIgI1kKGSG6ibOmpcmCxwJDS9WiMq70pAPCw5POLjCMsgCFTumC?=
 =?us-ascii?Q?gdWCDTx4u1rvrjoei5tMP56jOpbmjqBdgiGcAgyvQthPHuCy0RNpzWanOBPd?=
 =?us-ascii?Q?IA+h9+7l42qD+tgRRu/gnT8R1r/S7yenHQTCAfDD54uJSn3vS79JdrRjn3TQ?=
 =?us-ascii?Q?Rb5+JFjKLcsd7JzO8kL9iQxBqdjP1jfo7zuof+RvZzM1wL+oplSxIxd73HFS?=
 =?us-ascii?Q?HCWa1UWUky8TiZefkceDU+kx0e8kwuEmm9/wC9iXR3vkmcDlMVI8yT17+1/Q?=
 =?us-ascii?Q?r/7d9KtKvtJXgXIbYjF5/AuTPPx26oTAVuyZD9HMlnKDlowxExOamwxswIFD?=
 =?us-ascii?Q?c22RSk9iWW+kbW9C7oZJ/03DXkpI3Nkmhbm2jcyeJOTZHhdWeYYwREhx2DUE?=
 =?us-ascii?Q?r7M3BD1LsgVcGfmf/tTuZF59gKIvEwwPLPQ1kTIX7k9F/s2SJy1EoBHiFBS5?=
 =?us-ascii?Q?wXUpWM+AUjUKFVoZPfR/Xm5T7hD+oJCGfqN5x+JTHSEDqz4gW2ENwprb4g8y?=
 =?us-ascii?Q?YR6UHitSyhlFAR65KDZVnEPn0rh9k1ZsgR65BW59tt746Lbw2N644G0uU+ZK?=
 =?us-ascii?Q?yGiVVocmxm9m66T7KLgmHnNemveI/S2mwLc2EH9FCSRruTwMr7TY6HMIFXWA?=
 =?us-ascii?Q?Zab1WNQbQ/5VxqCrTkUYXeVHEe3Y8mTY8jyK5+UShY8ZK1hiXoX0L3wGME/+?=
 =?us-ascii?Q?7TIicyCvuJIC5Gasz+KSCUWBWDcPTq27EO9AeRMapJCFtEEtRI9TAXX6Z+OS?=
 =?us-ascii?Q?ju3Z+9RU+7AX37fMrwJ3rSI+lAeZkHFqfbhnyw0/7aWMUEYJ6lxQUilk+NPN?=
 =?us-ascii?Q?MnfDEU/pUYzX5A6gx+mDh+aYhA4LERgIWt6Z6JD2aVZC3YqVURe6vPLhG6a6?=
 =?us-ascii?Q?wLkVK0pBxI1mHOdf+aIap/BrNt01odsr2Ks1Wq3spIF7450iJJFP2uTJAf0A?=
 =?us-ascii?Q?Yg5Yv80Gdc/uXducXMd8yBJhju6ArWvSjs5MInWzrHViRywJ3hMS4kD/ZKqi?=
 =?us-ascii?Q?GYZeyOe2UXdgMnSCuqNL+tg4ICmk9Oub2EVXmt7QFcwgkcaxz769P0+rYBN7?=
 =?us-ascii?Q?IzcdhjUyM8ct0NSKgkITpSfLiWgYf9sbMYa3n4osEB4Sqhi6ucHurRrc7EaZ?=
 =?us-ascii?Q?ek/o0a3BX6em9IxuDXpsYsn1DTAPAOKIMPOqvMGi0l/EplZf887yLBPiKfVa?=
 =?us-ascii?Q?SV6BBgKfiPnnzciYOPeKzalt1fi9uNIFPHt0auL70KdJ4BKzPLFhK4+osmZw?=
 =?us-ascii?Q?JytAW7izqbo9CTgPsu6MQOrYNYl1Y9p8pAHfQnmr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e929f12f-7d96-4c0e-ef77-08dd523eb896
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 06:12:29.4590 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 23Ca/aXDO7snOVqgh989B3txevevEb6G+A6SlP/FJUGylykXuUBzisaybLx99VT7ntVoCfr8eXsQn0fL7SmpMX8b+F0obksZ6p5hjjIA8fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7556
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
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
>From: Alex Williamson <alex.williamson@redhat.com>
>Subject: [PATCH 4/5] pcie, virtio: Remove redundant pm_cap
>
>The pm_cap on the PCIExpressDevice object can be distilled down
>to the new instance on the PCIDevice object.
>
>Cc: Michael S. Tsirkin <mst@redhat.com>
>Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
>Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>---
> hw/pci-bridge/pcie_pci_bridge.c | 1 -
> hw/virtio/virtio-pci.c          | 8 +++-----
> include/hw/pci/pcie.h           | 2 --
> 3 files changed, 3 insertions(+), 8 deletions(-)
>
>diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_brid=
ge.c
>index 9fa656b43b42..2429503cfbbf 100644
>--- a/hw/pci-bridge/pcie_pci_bridge.c
>+++ b/hw/pci-bridge/pcie_pci_bridge.c
>@@ -56,7 +56,6 @@ static void pcie_pci_bridge_realize(PCIDevice *d, Error
>**errp)
>     if (pos < 0) {
>         goto pm_error;
>     }
>-    d->exp.pm_cap =3D pos;
>     pci_set_word(d->config + pos + PCI_PM_PMC, 0x3);
>
>     pcie_cap_arifwd_init(d);
>diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>index afe8b5551c5c..3ca3f849d391 100644
>--- a/hw/virtio/virtio-pci.c
>+++ b/hw/virtio/virtio-pci.c
>@@ -2209,8 +2209,6 @@ static void virtio_pci_realize(PCIDevice *pci_dev, E=
rror
>**errp)
>             return;
>         }
>
>-        pci_dev->exp.pm_cap =3D pos;
>-
>         /*
>          * Indicates that this function complies with revision 1.2 of the
>          * PCI Power Management Interface Specification.
>@@ -2309,11 +2307,11 @@ static bool virtio_pci_no_soft_reset(PCIDevice *de=
v)
> {
>     uint16_t pmcsr;
>
>-    if (!pci_is_express(dev) || !dev->exp.pm_cap) {
>+    if (!pci_is_express(dev) || !(dev->cap_present & QEMU_PCI_CAP_PM)) {

Maybe a bit more optimized by checking dev->pm_cap,
but it's also ok checking present bit. For the whole series,

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>         return false;
>     }
>
>-    pmcsr =3D pci_get_word(dev->config + dev->exp.pm_cap + PCI_PM_CTRL);
>+    pmcsr =3D pci_get_word(dev->config + dev->pm_cap + PCI_PM_CTRL);
>
>     /*
>      * When No_Soft_Reset bit is set and the device
>@@ -2342,7 +2340,7 @@ static void virtio_pci_bus_reset_hold(Object *obj,
>ResetType type)
>
>         if (proxy->flags & VIRTIO_PCI_FLAG_INIT_PM) {
>             pci_word_test_and_clear_mask(
>-                dev->config + dev->exp.pm_cap + PCI_PM_CTRL,
>+                dev->config + dev->pm_cap + PCI_PM_CTRL,
>                 PCI_PM_CTRL_STATE_MASK);
>         }
>     }
>diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
>index b8d59732bc63..70a5de09de39 100644
>--- a/include/hw/pci/pcie.h
>+++ b/include/hw/pci/pcie.h
>@@ -58,8 +58,6 @@ typedef enum {
> struct PCIExpressDevice {
>     /* Offset of express capability in config space */
>     uint8_t exp_cap;
>-    /* Offset of Power Management capability in config space */
>-    uint8_t pm_cap;
>
>     /* SLOT */
>     bool hpev_notified; /* Logical AND of conditions for hot plug event.
>--
>2.48.1


