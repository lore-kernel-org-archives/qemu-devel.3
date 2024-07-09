Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D278C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 06:27:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR4JS-0001SA-Kg; Tue, 09 Jul 2024 02:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sR4JI-0001Ob-9I
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:26:45 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sR4JD-0000tu-47
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 02:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720506400; x=1752042400;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zY+unWz7EsvP9zk4XHEwBcy6o5C7gT/cykMZZEj0fh4=;
 b=IAue/UKDIF/HuRAUM2Cm/TqBgZJNQOC/r4Ni1jFAFD6rP6BMLFTljcjK
 rB4HgjgUM1/WQFVD3/CfALTrp6t92mUfkHjCpWK6Ouy90X4Zv1B4Q5oUJ
 Fz9Ip6/n2p5VaAPQ0DrHDjWs6jOyoxFJpOwiUGb+xBB25nI/8K+PoJ0pf
 4IUXv2vpnnQVGDWDahqq5qUa9YnapCPNYglJizCh0Q0YWFSFzHUDYZANP
 Jp/CJn5hRGye46c5+k67CHNrisTVToJrZ+VdaEyC5snYG1/D4E+9TbVn9
 juV8n1vUpb0WK7A39FpOLyynkQcLxGUsFC+iTdBUUMcutcZETKNuGddrC g==;
X-CSE-ConnectionGUID: fNgdo1MARFKgHMYgxo3PRQ==
X-CSE-MsgGUID: lC1dqlEVRw+chUZXWU9VGA==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17444270"
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; d="scan'208";a="17444270"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2024 23:26:28 -0700
X-CSE-ConnectionGUID: Do6Ej85MRGyd5AT3bYaNpA==
X-CSE-MsgGUID: p8qaMmUHR6S7lDYMKm+/0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,194,1716274800"; d="scan'208";a="52541242"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Jul 2024 23:26:27 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 23:26:26 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 23:26:26 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 23:26:26 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 23:26:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExMY0XaNIl5zJYmSR8TDU5qX3lEw250+leVv1RE1OzI7mxqmjC52qhUz/7hjhT1wROurBdZhdiqmf1uCN5etq7oBZVUbT0UvQRhRR8/tREaJz8NSyIhbjPNe8WZyZJwGLUJgDtuGFE4t27m+Ob2Oqv0yG3v4AacDJsCGbChQZP646JIkIYKNtUhESFhsJiGpBciDM+u0wUUyki5+RozXoOMA0t7NszrDy1HhYh9Q182GDccSIkNVaBbmaxs1nKsxDRx2UYEdvjOn77itOVoJgR2E5cbfMt42oUPckpYFd7HoTHS47HBPnPLBmIpf2WPc/aYOGn5GheN3ku0v11vr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU7A1LOJcdNhadTKb9qtYADTpZZINRHp25yOqXsic90=;
 b=mq58fv44vrppOsfT9n7rMm1fkUe+KrRoc1Z4vQsKC1Ms4fnNmQsuYIta1w7T924fKrCU3l+aENZ1vI1pcKnBXVRfdYyNW4vg/UIVsZeO0VtI6KpkbSGqco2uur/rzN4FH2y4cFwd2bXZuilm3JLI7gbHSjS0pASMQMCGOMXuVsWTpykXyZovLcBDojAzWcIj4XERouSK7pwyxnr+Sbu7ON7aruGA78VTZIDGUHs033Fs+BUGvSywPYdWb0ITRtgi83HOga7URzyEHGyGXCht9WfLWOYaC4rLzLyJpsOhmGQ+FtaJ3b0KK41cp0Um009PcmnsOLW26p+amg6lmcPFJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY5PR11MB6365.namprd11.prod.outlook.com (2603:10b6:930:3b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 06:26:23 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 06:26:23 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: RE: [PATCH v3 04/10] vfio/iommufd: Introduce auto domain creation
Thread-Topic: [PATCH v3 04/10] vfio/iommufd: Introduce auto domain creation
Thread-Index: AQHa0UP+5mqCLX4DOkad9XZEzDyv3rHt7HYA
Date: Tue, 9 Jul 2024 06:26:23 +0000
Message-ID: <SJ0PR11MB674442102F1373CF95BD245192DB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-5-joao.m.martins@oracle.com>
In-Reply-To: <20240708143420.16953-5-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY5PR11MB6365:EE_
x-ms-office365-filtering-correlation-id: 9540dc1d-229b-4186-20e7-08dc9fe00de0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Qes/1J1OjA6xbjHD4D435fLVa1NOF97QwOZdV8pwrkLB87P6EJ9KI/0CApl3?=
 =?us-ascii?Q?xWC7eo/WyQqNF3k0fVhpwUk6ZieJKclgKHD9HMePTuAJQfwdP0RA+5k+a4oO?=
 =?us-ascii?Q?uvmuVLxRillkXps3Y0pkGfDajFZCKa7SMNxVoDMvfwwzIXII+c+cExR387t5?=
 =?us-ascii?Q?dWIESRpAsbgGqCav3Pq2SjHnmHFKvSvkp+S09QBjnTM5Sual9ypw4K54zG6U?=
 =?us-ascii?Q?5NWbbfYZOX9uY5Hsj3f49DnSAv/vik426eLadl6824uiZJWomqdmNQeDwDH9?=
 =?us-ascii?Q?q0qhkQJa07JAZ2A32kIHFD4XaiLG9GU3PKdaI/kt50ej05erSG2ANWiELkXv?=
 =?us-ascii?Q?XqmFBpY7DXyFV+h4dB33TtSIO8FZc4oBMjzobISg540cz3KzqAWSKIMQbao7?=
 =?us-ascii?Q?yl6pIPM430xswBJAATXVv2SqVE9Kyuj5BPQ/yiUcq0I9Pj8FBoakgWv/45vp?=
 =?us-ascii?Q?uH0GHVSfb4NuYRGEpCGrLb+yXyVUclXTQ9ESOx4yRDPYNqdjQwD0lGxyh5Kw?=
 =?us-ascii?Q?pgaWZqtw/AVhBnBwLGpH7eIKiHjXGJLG+nXDTr6cUMcWbF693AtUxy0uYanC?=
 =?us-ascii?Q?W8Sy8BuZde1JMhgM6mpLPdbr+aGQH1ldi8JhqDrZKZZmBxNOv1sTJ9ygMj0B?=
 =?us-ascii?Q?fDi7HQk/cZBzBQ1Yz+BfaOqau5BkgUuIJwEqxfIqOZc3gBiybkPKJx629QdF?=
 =?us-ascii?Q?lbOWSYO/4Yxs4W5HQfVk8hfFsqWIIrubOFImN7h77kY+xyKsJ2RQSvtn6OhZ?=
 =?us-ascii?Q?EXcBH4dt9+YexqjlYF8r+BwZxkcXU1VHOsyMD51AFOx/1CtDJ0d7953pc9Jg?=
 =?us-ascii?Q?UxRWkqA5Mufgqc+ImRJ+W8tpZrgz9H6zNPg7Yq9SY7832JdHkE3ccdrtYIOg?=
 =?us-ascii?Q?IASwjySNox6UQ60j1u/wIe3DplhvuzyMabtNSUpFcCvcy/XdJpDkwkUzyF59?=
 =?us-ascii?Q?a+paQjN7M7ACmoiO7Z99dRZg3np1VRvBgsYNDSBDttUYtB7RCBxAcwHSPtlm?=
 =?us-ascii?Q?nU2t6f1DDO7xevu5gYmWe6V0aanOdzCb6Pf54wfqcZU5t8LkIn9E55a8KgMY?=
 =?us-ascii?Q?unTOVFT1S19VmEpsM71z1YdantGuJ6LUwaEQvdkIelTu8efEz9q+yFUVLQO5?=
 =?us-ascii?Q?e1MUjaIqdex04FXvFM1t4a3fTA5kR08iBFS9Z+uYOLstv17GlRVcotbQ50qj?=
 =?us-ascii?Q?DjuVgQ7l/XI18aGXWA+y+C7glJC7v0iligNV+rbXegZf42mdPR+dB8dn7uvO?=
 =?us-ascii?Q?aZavmugylf2R2fPOC/s5+ikAbTuwO/bzkFPZYPlLEtWf3TJuu9WVGV54x9Hw?=
 =?us-ascii?Q?35sPzL4dBjyFi1lsUobeCLczTPjy2e17PXMY4HY8+KrIj+JuyS7bPLkqlJjv?=
 =?us-ascii?Q?HM+rVoDdHRgMUSWnJSP3Y2EbQ7RYSkCH+mtGj5gTSPEoGkF0IA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nTy1QwT5DkJTpDEIzET7+xm5X8DCgTauli4oPOUUniAUfhF62+BcSuJxyJS3?=
 =?us-ascii?Q?hjwS8iRrn5EP9jHApyjVJa1U7M2GZ1pYdpb4NuJS0XlK20iws7wlrfouuZ2x?=
 =?us-ascii?Q?6fao1Lzi0fePs3s1tGCLwnTH5FPmJAgwqSn94tMRmN17x+z0MBxf3UNBPVFc?=
 =?us-ascii?Q?u34f8P27IqqEj01ZzG3t+7ID+exwVmelBXTPDFoeuwrX/0t+bBiEhvn287vJ?=
 =?us-ascii?Q?LTbWuN83GWycraEeNEj7IL8YPx4bmf+36jtFVo54vZnN7rrs8cgR8NY2JRv3?=
 =?us-ascii?Q?CbV7rLNswUQorJlxFTLVrHSKc9TILgC5/Ag2/AOUizMIK5uCw/xvZ92+ieB8?=
 =?us-ascii?Q?FCN5T6hGMup6BAe14BGP/KbU1H9w/wT9aoFZjJ4L0H9CUThR/oT8MXKtjx8y?=
 =?us-ascii?Q?FXQyWwcskk02YidvvXkgio7zDKYiiCz+YKnr12S/Pp6KE/6Pv9W2eaaEgwJI?=
 =?us-ascii?Q?p1jE1U+KR+y7JWRAMDTXY9Q7qhZyYjFGzxGyXdmp7OjmFoCXT7yA2V4yILnE?=
 =?us-ascii?Q?Yw8wJq5AOi0d3ooRO2TRHBgGEqnmTPMn3y+C62gdmeN27xePPkQbRhaHD5A7?=
 =?us-ascii?Q?Fso/XfcyKE4JIZn2iXx5XVcUtbQCaPchN/FsYVtr3K7XsuXttOoePYxCDSqG?=
 =?us-ascii?Q?HgvHOW3F7qOkHDCqktg5jIK/LQnUXvMnEYpfbdqxkVaw1FI3N71P4TMQkiiG?=
 =?us-ascii?Q?AAUf7dS94KSI2H1yRCSAfQ3xOFuqL428nZBaaE/SX5Y7XuoHKLcanZlT5pVM?=
 =?us-ascii?Q?HxZ4vAo1I6/15VzXVetUNyIzm3NqENmgJqrKUmN8rCBMDVBaR/A0q1dJ2VZt?=
 =?us-ascii?Q?0/oh8QWfg0FY7316oQ0SF/f9nHwIS1fP2Ts4VG2uj44qGN7PfvjnNqwNhyEx?=
 =?us-ascii?Q?CU2zEOWcb9qbidPa7wJznZd5dTD2vtp9HGthlRKIO6vXmqYS0yzvpaRz5rOr?=
 =?us-ascii?Q?fHSF++5AOyTq+ywKawo34qH0iCGJVWBi31qAFoQAP+dp8/SAGaa/o8wAEGtL?=
 =?us-ascii?Q?q8+ROuqBs79x+UCZfpCAh1J1YzacpSMjhXzqg1Kr6JksNo0xCXsBgUAW6/1w?=
 =?us-ascii?Q?FwSnJ3SvhXmiIE1YgA9wcS21+jcS0bOrlbO1vCrHs/+S6q9j0nHc7zNDJT9Y?=
 =?us-ascii?Q?V5FzUAWBDajLyRKAaHlOwEnFj2Aww2Ff65zz/Ap2hDbxIGp9anGbCofHSE6I?=
 =?us-ascii?Q?Mp8EdK3ey4KcZQ8R/dirgHB1eM0aK1Tc+NZthkfYV0dKbOV+XPRuJiGVmBst?=
 =?us-ascii?Q?9MfhvdN7L8uAXpI5d638DsgLPKJX7HgeYwKllFXdzl8VwBRHUWT2Fl3oL8vG?=
 =?us-ascii?Q?SYeLngCNI/gcYIaqe2InVNSL9+YeKnGVX+CPvuksxeE9Q1CzdDklnISwt3d6?=
 =?us-ascii?Q?QcguPHmd/F9ecfj2OPA4sSN3lDBoxEpvVALla017qAWIvguifM+pmmwVhDUV?=
 =?us-ascii?Q?VljMB3wF2Cyi92NcsCVUepxRB85Nbz+rTY48/FvH1wjKGwxoaImgniUHIfXY?=
 =?us-ascii?Q?PaMr6sL1sUGaJHeefiLOmJU0DQs9+GTsuCKJzOYQGi4+L98A2gfxjFvCpEJ5?=
 =?us-ascii?Q?/y5n4mHcgYj8UDqBafzb1jMWUm07NnvuPLegrOfs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9540dc1d-229b-4186-20e7-08dc9fe00de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 06:26:23.3539 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S4rE0KP2798ehmUEVIySFSZdEx27KuZUv4DDeNW411dWlUfw8lye7TJx3IkovAxC9Tv/jtHjfHFAW926QpOpnQ0aYPmiHkjVEvJuSiGIy6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6365
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: [PATCH v3 04/10] vfio/iommufd: Introduce auto domain creation
>
>There's generally two modes of operation for IOMMUFD:
>
>* The simple user API which intends to perform relatively simple things
>with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
>and mainly performs IOAS_MAP and UNMAP.
>
>* The native IOMMUFD API where you have fine grained control of the
>IOMMU domain and model it accordingly. This is where most new feature
>are being steered to.
>
>For dirty tracking 2) is required, as it needs to ensure that
>the stage-2/parent IOMMU domain will only attach devices
>that support dirty tracking (so far it is all homogeneous in x86, likely
>not the case for smmuv3). Such invariant on dirty tracking provides a
>useful guarantee to VMMs that will refuse incompatible device
>attachments for IOMMU domains.
>
>Dirty tracking insurance is enforced via HWPT_ALLOC, which is
>responsible for creating an IOMMU domain. This is contrast to the
>'simple API' where the IOMMU domain is created by IOMMUFD
>automatically
>when it attaches to VFIO (usually referred as autodomains) but it has
>the needed handling for mdevs.
>
>To support dirty tracking with the advanced IOMMUFD API, it needs
>similar logic, where IOMMU domains are created and devices attached to
>compatible domains. Essentially mimmicing kernel
>iommufd_device_auto_get_domain(). If this fails (i.e. mdevs) it falls back
>to IOAS attach (which again is always the case for mdevs).
>
>The auto domain logic allows different IOMMU domains to be created when
>DMA dirty tracking is not desired (and VF can provide it), and others wher=
e
>it is. Here is not used in this way here given how VFIODevice migration
>state is initialized after the device attachment. But such mixed mode of
>IOMMU dirty tracking + device dirty tracking is an improvement that can
>be added on. Keep the 'all of nothing' approach that we have been using
>so far between container vs device dirty tracking.
>
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>---
> include/hw/vfio/vfio-common.h |  9 ++++
> include/sysemu/iommufd.h      |  4 ++
> backends/iommufd.c            | 29 +++++++++++
> hw/vfio/iommufd.c             | 91
>+++++++++++++++++++++++++++++++++++
> backends/trace-events         |  1 +
> 5 files changed, 134 insertions(+)
>
>diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>common.h
>index e8ddf92bb185..82c5a4aaa61e 100644
>--- a/include/hw/vfio/vfio-common.h
>+++ b/include/hw/vfio/vfio-common.h
>@@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>
> typedef struct IOMMUFDBackend IOMMUFDBackend;
>
>+typedef struct VFIOIOASHwpt {
>+    uint32_t hwpt_id;
>+    QLIST_HEAD(, VFIODevice) device_list;
>+    QLIST_ENTRY(VFIOIOASHwpt) next;
>+} VFIOIOASHwpt;
>+
> typedef struct VFIOIOMMUFDContainer {
>     VFIOContainerBase bcontainer;
>     IOMMUFDBackend *be;
>     uint32_t ioas_id;
>+    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
> } VFIOIOMMUFDContainer;
>
> OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer,
>VFIO_IOMMU_IOMMUFD);
>@@ -134,6 +141,8 @@ typedef struct VFIODevice {
>     HostIOMMUDevice *hiod;
>     int devid;
>     IOMMUFDBackend *iommufd;
>+    VFIOIOASHwpt *hwpt;
>+    QLIST_ENTRY(VFIODevice) hwpt_next;
> } VFIODevice;
>
> struct VFIODeviceOps {
>diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>index 57d502a1c79a..35a8cec9780f 100644
>--- a/include/sysemu/iommufd.h
>+++ b/include/sysemu/iommufd.h
>@@ -50,6 +50,10 @@ int
>iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>devid,
>                                      uint32_t *type, void *data, uint32_t=
 len,
>                                      uint64_t *caps, Error **errp);
>+int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>+                               uint32_t pt_id, uint32_t flags,
>+                               uint32_t data_type, uint32_t data_len,
>+                               void *data_ptr, uint32_t *out_hwpt);
>
> #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>TYPE_HOST_IOMMU_DEVICE "-iommufd"
> #endif
>diff --git a/backends/iommufd.c b/backends/iommufd.c
>index 2b3d51af26d2..f5f73eaf4a1a 100644
>--- a/backends/iommufd.c
>+++ b/backends/iommufd.c
>@@ -208,6 +208,35 @@ int
>iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
>     return ret;
> }
>
>+int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>+                               uint32_t pt_id, uint32_t flags,
>+                               uint32_t data_type, uint32_t data_len,
>+                               void *data_ptr, uint32_t *out_hwpt)
>+{
>+    int ret, fd =3D be->fd;
>+    struct iommu_hwpt_alloc alloc_hwpt =3D {
>+        .size =3D sizeof(struct iommu_hwpt_alloc),
>+        .flags =3D flags,
>+        .dev_id =3D dev_id,
>+        .pt_id =3D pt_id,
>+        .data_type =3D data_type,
>+        .data_len =3D data_len,
>+        .data_uptr =3D (uint64_t)data_ptr,
>+    };
>+
>+    ret =3D ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>+    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
>+                                     data_len, (uint64_t)data_ptr,
>+                                     alloc_hwpt.out_hwpt_id, ret);
>+    if (ret) {
>+        ret =3D -errno;
>+        error_report("IOMMU_HWPT_ALLOC failed: %m");
>+    } else {
>+        *out_hwpt =3D alloc_hwpt.out_hwpt_id;
>+    }
>+    return ret;
>+}
>+
> bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t
>devid,
>                                      uint32_t *type, void *data, uint32_t=
 len,
>                                      uint64_t *caps, Error **errp)
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index 5a5993b17c2e..2ca9a32cc7b6 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -212,10 +212,95 @@ static bool
>iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>     return true;
> }
>
>+static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>+                                         VFIOIOMMUFDContainer *container,
>+                                         Error **errp)
>+{
>+    IOMMUFDBackend *iommufd =3D vbasedev->iommufd;
>+    uint32_t flags =3D 0;
>+    VFIOIOASHwpt *hwpt;
>+    uint32_t hwpt_id;
>+    int ret;
>+
>+    /* Try to find a domain */
>+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>+        ret =3D iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id,
>NULL);
>+        if (ret) {
>+            /* -EINVAL means the domain is incompatible with the device. =
*/
>+            if (ret =3D=3D -EINVAL) {
>+                continue;
>+            }
>+
>+            return false;
>+        } else {
>+            vbasedev->hwpt =3D hwpt;
>+            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>+            return true;
>+        }
>+    }
>+
>+    ret =3D iommufd_backend_alloc_hwpt(iommufd,
>+                                     vbasedev->devid,
>+                                     container->ioas_id, flags,
>+                                     IOMMU_HWPT_DATA_NONE, 0, NULL, &hwpt=
_id);
>+    if (ret) {
>+        /*
>+         * When there's no domains allocated we can still attempt a hardw=
are
>+         * pagetable allocation for an mdev, which ends up returning -ENO=
ENT
>+         * This is benign and meant to fallback into IOAS attach, hence d=
on't
>+         * set errp.
>+         */
>+        return false;
>+    }
>+
>+    hwpt =3D g_malloc0(sizeof(*hwpt));
>+    hwpt->hwpt_id =3D hwpt_id;
>+    QLIST_INIT(&hwpt->device_list);
>+
>+    ret =3D iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>+    if (ret) {
>+        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>+        g_free(hwpt);
>+        return false;
>+    }
>+
>+    vbasedev->hwpt =3D hwpt;
>+    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>+    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>+    return true;
>+}
>+
>+static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
>+                                         VFIOIOMMUFDContainer *container)
>+{
>+    VFIOIOASHwpt *hwpt =3D vbasedev->hwpt;
>+
>+    QLIST_REMOVE(vbasedev, hwpt_next);
>+    if (QLIST_EMPTY(&hwpt->device_list)) {
>+        QLIST_REMOVE(hwpt, next);
>+        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>+        g_free(hwpt);
>+    }
>+}
>+
> static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>                                           VFIOIOMMUFDContainer *container=
,
>                                           Error **errp)
> {
>+    if (iommufd_cdev_autodomains_get(vbasedev, container, errp)) {
>+        return true;
>+    }
>+
>+    /*
>+     * iommufd_cdev_autodomains_get() may have an expected failure (-
>ENOENT)
>+     * for mdevs as they aren't real physical devices. @errp is only set
>+     * when real failures happened i.e. failing to attach to a newly crea=
ted
>+     * hardware pagetable. These are fatal and should fail the attachment=
.
>+     */
>+    if (*errp) {

Better to use ERRP_GUARD()

Thanks
Zhenzhong

>+        return false;
>+    }
>+
>     return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id,
>errp);
> }
>
>@@ -224,6 +309,11 @@ static void
>iommufd_cdev_detach_container(VFIODevice *vbasedev,
> {
>     Error *err =3D NULL;
>
>+    if (vbasedev->hwpt) {
>+        iommufd_cdev_autodomains_put(vbasedev, container);
>+        return;
>+    }
>+
>     if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
>         error_report_err(err);
>     }
>@@ -354,6 +444,7 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>     container =3D
>VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>     container->be =3D vbasedev->iommufd;
>     container->ioas_id =3D ioas_id;
>+    QLIST_INIT(&container->hwpt_list);
>
>     bcontainer =3D &container->bcontainer;
>     vfio_address_space_insert(space, bcontainer);
>diff --git a/backends/trace-events b/backends/trace-events
>index 211e6f374adc..4d8ac02fe7d6 100644
>--- a/backends/trace-events
>+++ b/backends/trace-events
>@@ -14,4 +14,5 @@ iommufd_backend_map_dma(int iommufd, uint32_t
>ioas, uint64_t iova, uint64_t size
> iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas,
>uint64_t iova, uint64_t size, int ret) " Unmap nonexistent mapping:
>iommufd=3D%d ioas=3D%d iova=3D0x%"PRIx64" size=3D0x%"PRIx64" (%d)"
> iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova,
>uint64_t size, int ret) " iommufd=3D%d ioas=3D%d iova=3D0x%"PRIx64"
>size=3D0x%"PRIx64" (%d)"
> iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=3D%d
>ioas=3D%d"
>+iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t
>pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr=
,
>uint32_t out_hwpt_id, int ret) " iommufd=3D%d dev_id=3D%u pt_id=3D%u
>flags=3D0x%x hwpt_type=3D%u len=3D%u data_ptr=3D0x%"PRIx64" out_hwpt=3D%u
>(%d)"
> iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=3D%d
>id=3D%d (%d)"
>--
>2.17.2


