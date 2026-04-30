Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1506FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGf-00047C-8Y; Thu, 30 Apr 2026 10:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wIRSy-00043y-FW; Thu, 30 Apr 2026 09:30:08 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wIRSw-0001cq-Kg; Thu, 30 Apr 2026 09:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777555807; x=1809091807;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=3fOxznbjxJUVoK2ZaaKR2iDarqFCoBLdbxEMPKIDvio=;
 b=mDx1xp251c+bPjYaXv3EMZBWVfBGqXA9PDanQKYaNS76OUxISvyDtnKq
 StS7gjlMj4lG1DxFSggsz1b7skMLrrPuCSnnLpIS+Gh48DJ1iz20ZAMUT
 IHvsD48NNLOSCXYQuo/fwiPjUUflAmyQAt3dLx51L7UNwgCXmVRwSX9kU
 bADi2pdVS7ho63elFJ1Y44R8r9M2dkXf/oWV7Ww94SBPNwnC/Khs9Axjw
 kv+fHKRjEqOZvC0fAJMwek9MnkTG9QkN4lexcH1j7h+zl9K73KgoC3gnu
 283Zc2vjM9kIGgrs8C/4MBYNgbM5o2H/qVm3zJL/VwvFYn5EkhrtXOt4/ A==;
X-CSE-ConnectionGUID: yyrkTzhGR9S8lbsUCX9zgg==
X-CSE-MsgGUID: PGIknmRVTj2xgcGI3nJXDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78398949"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78398949"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 06:30:04 -0700
X-CSE-ConnectionGUID: bwRfbpasREytOPpgX8NBow==
X-CSE-MsgGUID: 5iiTmXC0QPmweUts0trv7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="257920659"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 06:30:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 06:30:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 30 Apr 2026 06:30:01 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.2) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 30 Apr 2026 06:30:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nd2eiODFUhTXX2q53b6iVK/+ojPs3OLzZdfdfTpWin+gTSBgCDdgAZc7ZeH6GHBrX8SLz8fVrnaQIzbaBS+iTAvjOpd0S0qTwFo0Y2qgfwUjWdPcDk07dyKdhmLgoVSV5ov/qLkBtHCo+2M8g0WkM4rPASP73pA+l4k60QSpYiGaiVilu2KYfSFAbPVJH5PFDbaF0BHY3zDCpm2pJgTE7EMEe3FDoJCONM+CnqEJhZW2MGOBsjzyC3eosDn4GksHN3ez+XxutJQA7yP5xVzHflpuHP/NZWU4S6jhGTvRmBBOVdrr44qgnsWAxrzqMPmzJGihchzbMueN1ZOkEVPlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fOxznbjxJUVoK2ZaaKR2iDarqFCoBLdbxEMPKIDvio=;
 b=c789WnpOMJ1J5Ku9G6tCU+PSngbvVe3xwO63crvQvalTftlV8VK4j4UMzO8SlIF7MDoleaQbB5eAKxB5wWysYazk7EhhRf1ox4FohY+5JtQSaPnEX7wKHaPX9A6MgQK1FCQ4oDjAzN5U3g5gDx6u8nl6F6TTDplKHcCCpucAFV+oCt+BG5h6bczSilfAgNf4e5XUj5745XFDz+slz+aiBSvwUBxfmJAE2LcSCThZ0x1QBaTMQFIG9ejN807AHel/skOes1ShrBDS8e9i8f5n74l9FnaVXa1I/qc6j4yP6fUvjPG2J9pXBpc+u2tk68Dz2UdR9w5ejruCYljbwFB5dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by LV3PR11MB8743.namprd11.prod.outlook.com (2603:10b6:408:20e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Thu, 30 Apr
 2026 13:29:57 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 13:29:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao,
 Xudong" <xudong.hao@intel.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [PATCH v4 02/15] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Thread-Topic: [PATCH v4 02/15] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
Thread-Index: AQHc2HDkv1c7hQCjqU27t3owxuh0m7X3jPaAgAAMuYA=
Date: Thu, 30 Apr 2026 13:29:57 +0000
Message-ID: <IA3PR11MB91367B0F6EE0419E9BE1977992352@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
 <20260430071315.354333-3-zhenzhong.duan@intel.com>
 <CH3PR12MB7548C598AEDB8C2367E2C123AB352@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB7548C598AEDB8C2367E2C123AB352@CH3PR12MB7548.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|LV3PR11MB8743:EE_
x-ms-office365-filtering-correlation-id: 509f7738-fbbf-48f4-55ea-08dea6bc92af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: iia/DvbMAF+mGZLMsGYIMX02Uu3xCvIFm55karVEMfbU4QUNBkJR4DV48/bgJbJLRx6uwO9b6ropQdOpIVFW903FSwPFqMINZEeDEABFc87CqJ/6LdhkttE4hdpC1sBpJUp/9+xtvjuQw0VlCqNhpK/OuzOrnXmvi2HL3XjjuteWZp8wJ2uIrUEbAcul08zt34gXlkpsVAPk1VS5S5PZh5t1FlzTzt+3h1xDy5/SjQ/BvViGweif+irvvWIPYO2vgsMdCmx2uQ548LNwK4T8gmnvDStqKmquP6B1DRgJmsjOyAcbypZP4BTA/v6bi85nuNB8UH+YFFOBAdkOrg69ZELzgNoyQ3tiAG75QzMDLNO3ABPnffZ5JtqBI+/CdnyzjnyNupxoR+uiOWgaLUwKFCOV+VD1FMQBD7Jwh02lLfnwHms6be4Ej2J5F0NtiAUJMZ5S6Px69rLb/UWa9Pf3AoNW7bt1PIw0ZCZqxxbHdlEXTevTYxL9BCtf4/YbXkgMbm0k5q/RmA+ZBvDrKPOe/bLvpTq43dCly4wxco7Fw0sbPfCoIlnnumjIQWln7O1zBJ+6Jsw9em6mACY+tShUapfbecQguWJ75Y9d+oUalxOZ1ZlMPqZ1fnC+MGlNHwAZpqmHwhcc8B9HgqCT/pPYz2CCdTAhGEgRCsGBv8xrE/N9JUk3Nliis/6Zyb/lBdHP2Pll1fPzkKA7Uj2Oyxq8kE7ItE0aebbhDNJd2xepY4rPLkLTPccDTGzIvHJR+nmtHT0VA2X/Dskc1A0p6DDMGE4qa/TxMq3+LE0ZPUDcLiM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVZDT2RaYkhON0JJK1RwMnhSYnZJbnhQYU9tVmRpK2pKSm1PdWJXRHRxZGNi?=
 =?utf-8?B?SWhXc1hzTjZ3LzdaeXdIVjl3WHd4SytYMTl0WkJNc1k1M1NWcVFmRC9JdFc4?=
 =?utf-8?B?UGd4VEdEeklWY2VDc2lHcGpRSVpXNXVYUGozRWtmendyMHBiWTR4WVFWTnd1?=
 =?utf-8?B?ZGlNRnl6YllTZEpGcCtOZ01ROTQ2bkR5Vlh2MDdiOEl5dWtLWCtHV0xPdEJ4?=
 =?utf-8?B?VjJhd2dObVRzSi83N21Sd3Y3c3pYaUVaNHJRN0w0Qld0Tnl4b2pPU1UzZ3BX?=
 =?utf-8?B?QlJyN09NNkR4RDVsZUNkK0NKYXNtRmFBWkUrNndwd0FDZ2NmT2lzNGhiUnpR?=
 =?utf-8?B?MU5OUjgrMEZiemdhSW1FSjMvd1pVYWZtMXVDblNncU92K2huQ3BCdkpDS1Nn?=
 =?utf-8?B?em4wbzEvTEtncDl0MmNNRXdld3ppUzR1c2hFM2RmalMyRDVXeUxFTXlTVnRW?=
 =?utf-8?B?WkpYTk9UUHZ4K2JQbTk3OFF2aDluTE5rdkxMWkRBWlQrT0lsVXlmT0lhTU9V?=
 =?utf-8?B?L0RSTkZaUXZPdVltV1Y4ZXFMaTg3WEgvUG5ja09aMjllSVhGNDBDM1NudnVL?=
 =?utf-8?B?bEcvZ0MzaEhKVVRaQWVtY1NpVnQ3alRCa3NuSkEzWnRveGNNcHdVc0o1dUxo?=
 =?utf-8?B?QUN1M2svRFBURXdGb2w3L2RCdVFNTW9OYktRSnYzMHhjVUZlUDltL01nZDJD?=
 =?utf-8?B?d3c0dnlrWnNhRE1rRHNZNnpYcmcyVDYwSlhQQVJ4T2xuTFhaZW9NWDM3bTlJ?=
 =?utf-8?B?ZDNIZlRJYlBFcXRsVzJKZ2xCNVhFOTQyUnIyNFp3ek9BODh1TVR6cVp0dEFi?=
 =?utf-8?B?TVZHNUZORVBQY0dodGUrdlhFWE5na3dBSzlCQTlwQlFDVUp1dHZhTHRvaVlS?=
 =?utf-8?B?bHc2L1NLdVo1OWNEYzB6QmpmVFRNbGRLZW1OZXRGV0NXNmNLaGxVSDBnbS9h?=
 =?utf-8?B?eGNwT2cyejNZK2taY2ZYMWN6UXdvM2h5WjhFbEdSam0zRnZVZXkyL2xBTUwv?=
 =?utf-8?B?WnFMUWkrTzNuSTBjMnBodDQ3SWlEa1I3STNOM0diMmY5aFhhNCt6UFFvaXFz?=
 =?utf-8?B?QVpockdiTnJNSUlYYzNweGtQK29VMTBCaVppajNrOUZ3dEhxUndRcjdjY0tl?=
 =?utf-8?B?cFRUTkUyT3RVL1kvcVhrZUNyOXd2R3NnZGZJS2d3Sk15N3JrQTBXdElQb01q?=
 =?utf-8?B?WVV0REFaQ0ZHczhZN1lOY0htR1p5UEpZWEhBQkVpVE95c2tjaytKRDdnVklv?=
 =?utf-8?B?Z0I4Y0h5OUwrWVFua2JzUk96SUxHNHF2NjAyemNzNGwwL3JhckN1RnZPbDNN?=
 =?utf-8?B?Nk5QaHlkK0V0bnhldzhhK1VuZFU4dHUxVCtPWWNOam1sSnZNWnVYUU5CQndn?=
 =?utf-8?B?UEMxNnhnWERSZVcvTWhyY3E1M2hvdTVHZlYra3lzMUJDdDVLMEhvR3R6YWFr?=
 =?utf-8?B?enN2dEthNWJmbmJQOTVHaUZjckUvSGFKdFhUOEdibjNMRkFMYlgyQy9QVGg5?=
 =?utf-8?B?ZnlEMGczZDFyamdQektjK0t4ZlhUNFhzb1VTWFp3MkdLeCtDbE5ZUWZJNjRX?=
 =?utf-8?B?QkJzM3htWnp0RGt4QzdyN2RlazZnbXpsMVdtalNNd3R2dWdzU2JzNTdOaHdi?=
 =?utf-8?B?NDArejl2MXd4MXZFYUd4ZU5kSkRFbUVjaHphRnJjVCswSEdYSEtKSlB6bjBG?=
 =?utf-8?B?VXpOZ3dESUZHaThjRStjUk96WUxSQVlhMEk2UkVWb0tSNjA5K1JhUjVkanRE?=
 =?utf-8?B?QkhVTm1lWEhEclVGT3k0RFhxUTZtaVBDcG9vV2Q1RS85N1J1TzJsd2RiVlps?=
 =?utf-8?B?d3haT0M0MlNlelNsb0k2N3g3VUJPRC9OMWhUdXFNM3NIVzRDb2xaRnU0S0kx?=
 =?utf-8?B?MEhCVnYvRm1tSUVZUmtNT1N3TG01bWJWcnRkdHJQWm5VejhUcUhxYUp6Qzky?=
 =?utf-8?B?VCt1ZzhVWUdwcEMwT21WMjNDL0EwamIyMUg1NUpqcFVXMjgwajVhVDVhTUU0?=
 =?utf-8?B?S1B1Q0pHOW0zVFMxMlVNODNENXdLZEVDdG45WjhOb1RPL2Q3Q0hrTDIwV21E?=
 =?utf-8?B?bW1PV1ZXdC8vTjloc1krZTcyOE5XSElpR3N6RTlrVXZJVWwrUnZNZDN4Z2lt?=
 =?utf-8?B?R21IK0h6OW5RdWVCNlNmRHp2K3FoaGZYc3NxZkt2SDRSS1FLeHIwNU1Qemsv?=
 =?utf-8?B?eU40eVBPZFdNaitZTGRkQjRwcXgrSFNqaXNSZEkvTm0vcmhuSU0vWnh1YzBN?=
 =?utf-8?B?dlYrb3hIVEdoZXdtOFgzbzNnZm5XYU9xNjI0QktaZmcvMHNyMTI5QzNnbnlM?=
 =?utf-8?B?QmRCclY3ait6djZFc1R6SG5aRmk0a3NOaWFvZHU2SjRtZHBMbFFiZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JBzZVflIiLBavWp57jRr+BAxnKX6CL7plPe6XMD6jsDW3G1J0ui2BRw2ZfSmrR8UKSN/ElppLZ3v0wRYT2LIcO6fd1M7mBhTxbxFZ2+EUBQTL0ZV96+n2WFneaRJksXC4ue157rpjYCyNQJmQn34S3osnd++IAo20EEyFPn7zR2FtvOGlgvkY3YWURQR9xGtSY3/TKWO4GSerhdyyizSWVh9Bq9pdrILYn4foFZtk1TlS65laKqXNOxpwpIsbh3k49jMSALGWEzbl81v1Gnv0ma1MdVulMLn77rAuLEHeXiNWndPtFIJU1zhhNaxwPBfqbc00cMEXOLu3pTYlNF43Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509f7738-fbbf-48f4-55ea-08dea6bc92af
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2026 13:29:57.8099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J+qtgEEE8SMJXs39UdFwvZt04wVXvqmsCGN8vKFbv6QLq4oytYyT+223wPP1t6IedWGbJ6/htDJW/y3MR3PwyM3kj8+mINSBhW0NSNfENB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8743
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Pj4gICAgICAvKioNCj4+ICAgICAgICogQGRldGFjaF9od3B0OiBkZXRhY2ggaG9zdCBJT01NVSBk
ZXZpY2UgZnJvbSBJT01NVUZEIGhhcmR3YXJlDQo+PiBwYWdlIHRhYmxlLg0KPj4gICAgICAgKiBW
RklPIGFuZCBWRFBBIGRldmljZSBjYW4gaGF2ZSBkaWZmZXJlbnQgaW1wbGVtZW50YXRpb24uDQo+
PiBAQCAtMTU0LDE1ICsxNTYsMTkgQEAgc3RydWN0IEhvc3RJT01NVURldmljZUlPTU1VRkRDbGFz
cyB7DQo+PiAgICAgICAqDQo+PiAgICAgICAqIEBoaW9kaTogaG9zdCBJT01NVSBkZXZpY2UgYmFj
a2VkIGJ5IElPTU1VRkQgYmFja2VuZC4NCj4+ICAgICAgICoNCj4+ICsgICAgICogQHBhc2lkOiB0
YXJnZXQgcGFzaWQgb2YgdGhlIGRldmljZSB0byBiZSBkZXRhY2hlZC4NCj4+ICsgICAgICoNCj4+
ICAgICAgICogQGVycnA6IHBhc3MgYW4gRXJyb3Igb3V0IHdoZW4gYXR0YWNobWVudCBmYWlscy4N
Cj4+ICAgICAgICoNCj4NCj5XZSBzaG91bGQgY29ycmVjdCBhYm92ZSB0byAid2hlbiBkZXRhY2ht
ZW50IGZhaWxzIg0KDQpHb29kIGNhdGNoLCB3aWxsIGRvLg0KDQpUaGFua3MNClpoZW56aG9uZw0K
DQo+DQo+UmV2aWV3ZWQtYnk6IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEu
Y29tPg0KPg0KPlRoYW5rcywNCj5TaGFtZWVyDQoNCg==

