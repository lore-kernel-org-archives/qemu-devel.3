Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07878C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8aMw-0000Xe-O8; Mon, 21 Sep 2026 05:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x8aMv-0000XM-AO
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 05:31:25 -0400
Received: from mgamail.intel.com ([192.198.163.6])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x8aMs-00047a-P3
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 05:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789983083; x=1821519083;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HQvWNF+Yql8F4H38dub8d1iLHg174iARiLGNbA/2j7w=;
 b=Jl8DrBSJn+k5B59G9Je9sP4BvHGM2+ucjmNf6qdQXSVWdtCuAx4SsqSz
 ksNvwlSiIBOsj6rzwQf6gWY+VZnsNFjguY0Z+cFwc69F0EShPsEiVqHwK
 0H0NY+h5voR6aLu4qX0D3CrwxOPaLWgJidvUvH90QdoniFsJJRjXZfybg
 Jpo4BMAcyEdzMcxTVjcPjpovDwIp70lS28OJiN+vu65WaBVifkEZUNM2m
 NGDm8PfnkgqRKoVLdSFj5iaL6ns2h4PxnxhfG18bgeECCSul6GCwUQhTT
 Q6DH1CpcK7cRR2kq91y3b2jwgDaVuUNd6gHXYYeMdzKdehrehmLt2uYNE w==;
X-CSE-ConnectionGUID: 2ZQxoJY4Tiy03xgDHoFcrw==
X-CSE-MsgGUID: P+8PEC8ZSMKQFbtuIrZVow==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="991310"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; 
   d="scan'208";a="991310"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa116.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 02:31:18 -0700
X-CSE-ConnectionGUID: jz6+Bqo0TT61gaiHbzEyyw==
X-CSE-MsgGUID: 7fUuE//7S+Wz0WnHcYjA/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="271732898"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 02:31:18 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 02:31:17 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 02:31:17 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.1) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 02:31:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvnkzS+2tFowPAAalRXtF5IYAW965TEYy4106pVzCPJyvsVHFaJ6zdeOF0047H7ABPpsyWVApx3dlnSPdSCckl8BkbPkxB9Ac7mby4Y0vQpCZy/fofAAU7o3iq6yHCRJSdFe7i5gVEYVy9Sn65b9aBBfIw6xscsck02Wyt6NOG+LFntfLKkdlHdfSp4kBHGObVp3GYpb1CXW01FggDLWOp1ZcdiPIn5IEH5uSHOMiLwLTMARpD10OpgYiGVsS+HTbiRC1WbRDRPOiV1biNo4X6hMAn1XayRuVe+u2kjXOBqKgSidCIoRGG0Iu2U1dx3PPrF7snY8f7ssWEDXZqNtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQvWNF+Yql8F4H38dub8d1iLHg174iARiLGNbA/2j7w=;
 b=dyiaAPioJ3JVCFa+dFqmL8NiFCkbdwC2prVmNGVeAdpBW+YXmufsbhAdn4cSUegPGGHiyO75kbWnPjE4wsZo8RVMuV3D3LB02eUc4RqecB8Gvf2tdLzfP5rLDmFpP/U41QSJGM8kasUEG4zXtZxjI14otwefJhWs8GO54TE3wl2eCyrt/ZeBB/DkmZML8uLKoSqbVSvBZaNlHnWdaHNbQhv+L9/kIxiHsmBzjvLpjOIrinNT7aXzyuVfIZEOZ2wQDhl1yspR4rnTu1DDdZMaItGX2ZL1dy2yTzXZBV61ohMK760Jg2jisn1qSvVv1rpVUN27W7YvDRxFOnMw62RXFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by MW3PR11MB4538.namprd11.prod.outlook.com (2603:10b6:303:57::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Mon, 21 Sep
 2026 09:31:11 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 09:31:11 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v7 6/6] intel_iommu_accel: teardown FAULTQ resources in
 bottom half
Thread-Topic: [PATCH v7 6/6] intel_iommu_accel: teardown FAULTQ resources in
 bottom half
Thread-Index: AQHdRcLzONMHxTTxMkuc/ucVb1TP+bbYn92AgAAgXAA=
Date: Mon, 21 Sep 2026 09:31:11 +0000
Message-ID: <IA3PR11MB91366BBC0FA349F3351BAC6492842@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260916100442.1034043-1-zhenzhong.duan@intel.com>
 <20260916100442.1034043-7-zhenzhong.duan@intel.com>
 <287990529392c887cb53369260b08b728694a9bd.camel@bull.com>
In-Reply-To: <287990529392c887cb53369260b08b728694a9bd.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|MW3PR11MB4538:EE_
x-ms-office365-filtering-correlation-id: e1261d3c-6e45-4680-853a-08df17c312dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|11063799006|18002099003|22082099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: 9TK6R4TBZYNTwEDjmwGPqxlJylpehBR57zRDXTHdJNakyKQJ1Bsd+drhMIyhHjfDq6yVCk0wkgpHz6oDCkxgbinwuo3i54MzOoL7wCsRlz80YD8LrgxGlKcZmDP7sVVm2T8jNuVa+6WGHQPqJmdqFE/o7rzkMT17t+9Hee7ptXuf+ZppRBBoUTx3r3oUMoEUNhw1P1Bfn2TSm6zC52QMbCR4cYTbnWnoeaMcCczyE8D4w28rI5SkXi6UvuTym2cuhBGVvqbrbFeto23Re6WHrXDKW1D3TGCIhdTUNLGNPmH/gfkTSJvhY7ztrOVBv5TukbLGgeC6s/lv4KI8xmSVUiZ20ViMYjycszYSMt/J/P2nbWA22PMsRqd8WZq6b/jnZIZs+LyAwbivnxR1KXvCNbwzU65Ls+o1eiVxejyFl/OhMumcJCTFfFw1vCQpiMyFxWcTapPq7vwHJXIY+OHXLfbV264mN0Bzsj9K/zn6T3z+73ShVZziSpGBQGnf9Eq5LyTR0+QLyCREetQAe6CCSZGfBuLUijecOQe6zTgSL0HbhapIusPUOe+BE+oWoBdaNZxM7faWPPD4HN008KcucH5J627jOTGEnJ7f1Hy23gmRRGLiJsGs1LriwUrLODJenOaMayJRWjBWmQFwusDpgqi09Zpmt9WqSrsPAyT8OjoWapqNCB9ncjJ4vjXL2GXZetvDjBY+87QnPxQWFesIylsuTVEDfWuOzdR4emVo6ik=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(4143699003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUE2ZEFlZHpIOXhjUDFucFRXQmE1dWJnV0h4bzNieXdsRmIvc2xMUk03UzFi?=
 =?utf-8?B?RXkrdm9sVExaOEp5QkptYXd2aVFoU0U1MDBpV3lobnN5aUhneCtHQzZ3Z1Jm?=
 =?utf-8?B?QmYvTWhueFZDbDJndXJOZ25SSVRoMU83TndHdlFPR3VwcHJlWnhsZ1Q0dmU4?=
 =?utf-8?B?alB4ZlY5SWlQSVJlY3o4dFk3YkZTRkdLTUNDZXN2clB6WmM3d2Z2Y3JNUk9Z?=
 =?utf-8?B?UnY4NEp0dFphY3I3bXJXbnNDZ3I5NUxKYi80cXRyeW5iUTJkTzlHV1FDeWRQ?=
 =?utf-8?B?UFlubDBRb2hxWTR0QitodkNvSllvbm9ML1RlaVl1dHNydStnczMrNWl2UlJN?=
 =?utf-8?B?QitFYjBGdlE5Z1U5K08yYXFFdVU0WG9kcDl3bzZrMno4Vk1VTDA4eWhoYnVE?=
 =?utf-8?B?QThFOWE5dGdkYzdwMnhnbnUzdlN5Y0w0V0txandkL05LclIvbHZBelpmV0Ex?=
 =?utf-8?B?bHpEY3ZxbzIvQ2dKeVNrakFheXNEQ2t0bjlWNFBFMldhWEo2aWVEdytITmtw?=
 =?utf-8?B?MDR2MGpFLy9BWVNQT2dPcXE3UUJRQ05mMnJiVVd0Vi9DdDUydnF4elNuZXpQ?=
 =?utf-8?B?dkFWTk1wbTNZOTBMLzErOFZrbnBzb3ExS0tIZDVCSzhhT1M3NnlXRzlueVZY?=
 =?utf-8?B?WU5UVVhmVWFXS09OMTZhanpWQVRDMlZ4cCsyb0tUZ2E1c1hHeUlOOEtKcm9W?=
 =?utf-8?B?Z29kOFllREdqQ1BXTml1K0RtTWZ5WWliQUcybk56YjN3dFJxNVFkblF3dGpR?=
 =?utf-8?B?SmkzM2JYODZTbjlpUnpPWi9mMDlDcjE5M3ZrNTY2MUF0NzZ5cDFGOEZqelVj?=
 =?utf-8?B?OGlTdUJDb0hQa2V3TDc3aklFUlovbDJOYnZsOGZXYTZpenhEa3FWMVJncTMy?=
 =?utf-8?B?SjJhaVZ3SlVFQjdQR3NIa1BDTnlZbHgxa1hJVWJiQVZwMmJiMGtoV2VrZ1JZ?=
 =?utf-8?B?ZmFWQjZpSko4a0pvV01TYW93M1ByblJraDZKUzNUQWlnWTc0bVZnWk1MbEVt?=
 =?utf-8?B?MGJveE9BWUliSitaSi9nWWN5UldwZkRwQnhqZ2VZazVQN0taM2s0a1cwanU1?=
 =?utf-8?B?ZUQ4d2RNRDd0WFlJM1MzbWJzRk5FUzNVU1lGWEJiWGdJOVhJZGFpZnN5UDhk?=
 =?utf-8?B?WFpBTXNjQnA5OWZYQWVUc1Rwa3NZMWtyMnlxU09SVzZwSm53c3A2bENiZGVU?=
 =?utf-8?B?SVdzdmZNdDZSdW92VWl4YVU1UXlMQWRSM2huMWhVcmZCSTEzc0tBTU1NVUh4?=
 =?utf-8?B?VFM0eHlzQjBJaFhKaHdhbWxEUFA4OE5lSlZrTGZHbkJ3dmxNNkRuem5wOXNh?=
 =?utf-8?B?ZFFMMklwS0MxVnJ1cXorMGUxOXF4TkorczVuKytJbGY0WFhyQngyTWRNVERD?=
 =?utf-8?B?QTJCSDBrMVM3Z3VHM2wyVGFxalVpZG5hMCtiQjR5cXplcFpjdysyY2FTTU0w?=
 =?utf-8?B?LzFYT3hxaFdBMGxTb0VtckwyQXlxa282dElXeTNNZHp4MUtVYjM0Z2dMZ29L?=
 =?utf-8?B?OW1VdDRYQlJIZ2ZzMS9QVlMxMzIzeWR2d21rVmRJdzJNWVd1ZlZLbXdnL24y?=
 =?utf-8?B?RDBxaXBzZlZsQjllaDlTRDI4ZStVQUZMVjVYTC9DVDNvTHBBcDZZbDIrWmNz?=
 =?utf-8?B?dm0vWHNNc09FQjcrOXNCQ0R1UVBsTnM1QU9TeTNUZE9vT1cyU01peFdiMVlt?=
 =?utf-8?B?TkE3elA2aVMxbVU4UWtEVGhMTU8zZnNYMEpjb24xQUw1ZU1rVTVmVEhHK1VY?=
 =?utf-8?B?eHBsRFZyOUNmeXFyWnVjSmdJWFo2QU1FcGFkUXhIV1U1QVY1cWRRZ2hPQjl6?=
 =?utf-8?B?czkyN3pCNllZbkxNZ243MGZYR1ZhVEkzUllNSEZWUXFqUm9sNUYrS0hjVGU0?=
 =?utf-8?B?OEJMRk1Jb242a0V6WDJORW5GRmYyaVdnVXpBZ1FFekpzUCtscFFPVjc0a1Vk?=
 =?utf-8?B?clZrWklibWEwczQ0NE52VzBGLzEwM0lWUSsrdlY4bzY3TS8rL3N1YU81ejhS?=
 =?utf-8?B?ZmhvbDlxMWhDRzh6U2l2V0xBSm9oRGh3blkydmZjaDJyZmx0VTRhWUJmZEhp?=
 =?utf-8?B?ejVWVjdsS01nTVpPbGE5eVdhR0Q0ZTI1TTVHVklyam14VFZ1MklRNS9FRmxt?=
 =?utf-8?B?bGxyYXJQbjFhajliaFpSUVlieVdnSzdGZ2dxU3FUWkp0N3Y3VmRzdDZrSmx6?=
 =?utf-8?B?bk5EK01kd1BFN1l3ZVlpQlpGZzh4UDB3dklha3J1TlgxemVGTDdZT0ZVL0hi?=
 =?utf-8?B?VjhFbG9BcUJXSUlBU2xja3RZNjh2T1htOUYwR3V1V29LY0FMZWdqSE9DMXFL?=
 =?utf-8?B?bVFiR3lJeTBMa3BUb1N4b1BNRnYxdmJPclFEK05YcHRYaHNaSjFMQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EPqKzz/iuqPETcK+8+8+rEEjDEYx725pBsjIF6J3u+i4j9LuBOHe/VSdBbQ+XLokjEO6rT5KFYAIF3cva5Gv20DoamZiOxBcXwYGd+OY+6HIwvrThN/2FCg4Uu+G4fP6kHv/tnMr7LfHMfbJtIlCUFoOd2HQA3EhfATO0WtKVzcyfSqarOkq/gxSVDJ2PdQ6EQ9GvubhlzVcUc+an83hB3Lc0Mkbsszg0Tcx60i7/+6s2PcUiB7DN1proFosExakN3iOvBM21RfbHomRGOgcMXXxDaJiSflPAeKLP0pJBCgjmdcc1388AcYWtzqsJov227BXqtSEIQrc5DYks/3ouQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1261d3c-6e45-4680-853a-08df17c312dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 09:31:11.1806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgtmmcdqeaY8utNUj8KseFP7p8Rq6aHubfDrp0C2RTm6TmeckCgqbJiTbWtCZ4wd2IoV7mhklZ15OZjF7IHs7lLA7oOHH4XBqM6BxrLMt7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4538
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.6;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

SGkgQ2xlbWVudCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ2zDqW1l
bnQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tPg0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjcgNi82XSBpbnRlbF9pb21tdV9hY2NlbDogdGVhcmRvd24gRkFVTFRR
IHJlc291cmNlcyBpbg0KPmJvdHRvbSBoYWxmDQo+DQo+DQo+T24gV2VkLCAyMDI2LTA5LTE2IGF0
IDE4OjA0ICswODAwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IENhdXRpb246IEV4dGVybmFs
IGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRo
aXMgZW1haWwNCj5jb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29u
dGVudCBpcyBzYWZlLg0KPj4NCj4+DQo+PiBXaGVuIGEgcGFzaWQgZW50cnkgYmVjb21lcyBpbnZh
bGlkLCB3ZSBuZWVkIHRvIHJlbGVhc2UgYWxsIHJlc291cmNlcw0KPj4gYWxsb2NhdGVkIGZvciB0
aGF0IGVudHJ5IGluY2x1ZGluZyBGQVVMVFEgb2JqZWN0IGFuZCBmYXVsdF9mZC4NCj4+DQo+PiBX
ZSBjYWxsIHFlbXVfc2V0X2ZkX2hhbmRsZXIoKSB0byBkZXRhY2ggZmF1bHRfZmQncyBpb19yZWFk
IGhhbmRsZXIgYW5kDQo+PiB3YWtlcyB1cCBtYWluIHRocmVhZCBmcm9tIHBvbGwoKSwgYnV0IHRo
ZXJlIGNvdWxkIHN0aWxsIGJlIGEgc21hbGwNCj4+IHdpbmRvdyB3ZSBjYWxsIGlvbW11ZmRfYmFj
a2VuZF9mcmVlX2lkKGZhdWx0X2lkKSBiZWZvcmUgcG9sbCgpIGV4aXQNCj4+IGFuZCByZWxlYXNl
IGZhdWx0X2lkIGZpbGUgcmVmZXJlbmNlLiBJbiB0aGlzIHJhcmUgY2FzZSwgRkFVTFRRIG9iamVj
dA0KPj4gZnJlZSByZXR1cm4gLUVCVVNZIGJlY2F1c2Ugb3BlbmVkIGZhdWx0X2lkIGZpbGUga2Vl
cHMgcmVmZXJlbmNlIG9mDQo+PiBGQVVMVFEgb2JqZWN0Lg0KPj4NCj4+IFRlYXJkb3duIEZBVUxU
USByZXNvdXJjZXMgaW4gYm90dG9tIGhhbGYgdG8gZW5zdXJlIHBvbGwoKSBoYXMgcmVsZWFzZWQN
Cj4+IGZhdWx0X2lkIGZpbGUgcmVmZXJlbmNlLg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogU2hhbWVl
ciBLb2xvdGh1bQ0KPjxbc2tvbG90aHVtdGhvQG52aWRpYS5jb21dKG1haWx0bzpza29sb3RodW10
aG9AbnZpZGlhLmNvbSk+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbg0KPjxbemhl
bnpob25nLmR1YW5AaW50ZWwuY29tXShtYWlsdG86emhlbnpob25nLmR1YW5AaW50ZWwuY29tKT4N
Cj4+IFRlc3RlZC1ieTogWHVkb25nIEhhbw0KPjxbeHVkb25nLmhhb0BpbnRlbC5jb21dKG1haWx0
bzp4dWRvbmcuaGFvQGludGVsLmNvbSk+DQo+PiAtLS0NCj4+IMKgaHcvaTM4Ni9pbnRlbF9pb21t
dV9hY2NlbC5jIHwgNDAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+LQ0K
Pj4gwqAxIGZpbGUgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jIGIvaHcvaTM4Ni9p
bnRlbF9pb21tdV9hY2NlbC5jDQo+PiBpbmRleCBjZDIyNzMxNWRhLi5jM2YzYzc0NDgyIDEwMDY0
NA0KPj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQo+PiArKysgYi9ody9pMzg2
L2ludGVsX2lvbW11X2FjY2VsLmMNCj4+IEBAIC0yNjgsMTcgKzI2OCw1MSBAQCBmcmVlX2ZhdWx0
cToNCj4+IMKgwqDCoMKgIHJldHVybiBmYWxzZTsNCj4+IMKgfQ0KPj4NCj4+ICt0eXBlZGVmIHN0
cnVjdCBJT01NVUZhdWx0UXVldWUgew0KPj4gK8KgwqDCoCBJT01NVUZEQmFja2VuZCAqaW9tbXVm
ZDsNCj4+ICvCoMKgwqAgdWludDMyX3QgaWQ7DQo+PiArwqDCoMKgIGludCBmZDsNCj4+ICvCoMKg
wqAgUUxJU1RfSEVBRCgsIFZURFBSUUVudHJ5KSB2dGRfcHJxX2xpc3Q7DQo+PiArfSBJT01NVUZh
dWx0UXVldWU7DQo+PiArDQo+PiArc3RhdGljIHZvaWQgZmF1bHRxX3RlYXJkb3duX2JoKHZvaWQg
Km9wYXF1ZSkNCj4+ICt7DQo+PiArwqDCoMKgIElPTU1VRmF1bHRRdWV1ZSAqZnEgPSBvcGFxdWU7
DQo+PiArwqDCoMKgIFZURFBSUUVudHJ5ICpwcnFlLCAqbmV4dDsNCj4+ICsNCj4+ICvCoMKgwqAg
UUxJU1RfRk9SRUFDSF9TQUZFKHBycWUsICZmcS0+dnRkX3BycV9saXN0LCBuZXh0LCBuZXh0KSB7
DQo+PiArwqDCoMKgwqDCoMKgwqAgUUxJU1RfUkVNT1ZFKHBycWUsIG5leHQpOw0KPj4gK8KgwqDC
oMKgwqDCoMKgIGdfZnJlZShwcnFlKTsNCj4+ICvCoMKgwqAgfQ0KPj4gKw0KPj4gK8KgwqDCoCBx
ZW11X3NldF9mZF9oYW5kbGVyKGZxLT5mZCwgTlVMTCwgTlVMTCwgTlVMTCk7DQo+PiArwqDCoMKg
IGNsb3NlKGZxLT5mZCk7DQo+PiArwqDCoMKgIGlvbW11ZmRfYmFja2VuZF9mcmVlX2lkKGZxLT5p
b21tdWZkLCBmcS0+aWQpOw0KPj4gKw0KPj4gK8KgwqDCoCBnX2ZyZWUoZnEpOw0KPj4gK30NCj4+
ICsNCj4+IMKgc3RhdGljIHZvaWQgdnRkX2Rlc3Ryb3lfb2xkX2ZzX2ZhdWx0cShWVERBY2NlbFBB
U0lEQ2FjaGVFbnRyeSAqdnRkX3BjZSkNCj4+IMKgew0KPj4gK8KgwqDCoCBIb3N0SU9NTVVEZXZp
Y2VJT01NVUZEICppZGV2ID0NCj4+ICvCoMKgwqDCoMKgwqDCoCBIT1NUX0lPTU1VX0RFVklDRV9J
T01NVUZEKHZ0ZF9wY2UtPnZ0ZF9oaW9kLT5oaW9kKTsNCj4+ICvCoMKgwqAgSU9NTVVGYXVsdFF1
ZXVlICpmcTsNCj4+ICsNCj4+IMKgwqDCoMKgIGlmICh2dGRfcGNlLT5mYXVsdF9mZCA8IDApIHsN
Cj4+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOw0KPj4gwqDCoMKgwqAgfQ0KPj4NCj4+IC3CoMKg
wqAgcWVtdV9zZXRfZmRfaGFuZGxlcih2dGRfcGNlLT5mYXVsdF9mZCwgTlVMTCwgTlVMTCwgTlVM
TCk7DQo+PiAtwqDCoMKgIHZ0ZF9kZXN0cm95X2ZzX2ZhdWx0cSh2dGRfcGNlLT52dGRfaGlvZCwg
dnRkX3BjZS0+ZmF1bHRfaWQsDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdnRkX3BjZS0+ZmF1bHRfZmQpOw0KPj4gK8KgwqDCoCBmcSA9IGdf
bWFsbG9jKHNpemVvZihJT01NVUZhdWx0UXVldWUpKTsNCj4NCj5zaXplb2YoKmZxKQ0KDQpTdXJl
Lg0KDQo+DQo+PiArwqDCoMKgIGZxLT5pb21tdWZkID0gaWRldi0+aW9tbXVmZDsNCj4+ICvCoMKg
wqAgZnEtPmZkID0gdnRkX3BjZS0+ZmF1bHRfZmQ7DQo+PiArwqDCoMKgIGZxLT5pZCA9IHZ0ZF9w
Y2UtPmZhdWx0X2lkOw0KPj4gwqDCoMKgwqAgdnRkX3BjZS0+ZmF1bHRfaWQgPSAwOw0KPj4gwqDC
oMKgwqAgdnRkX3BjZS0+ZmF1bHRfZmQgPSAtMTsNCj4+ICvCoMKgwqAgZnEtPnZ0ZF9wcnFfbGlz
dC5saF9maXJzdCA9IHZ0ZF9wY2UtPnZ0ZF9wcnFfbGlzdC5saF9maXJzdDsNCj4+ICvCoMKgwqAg
UUxJU1RfSU5JVCgmdnRkX3BjZS0+dnRkX3BycV9saXN0KTsNCj4NCj5hcmUgd2Ugc3VyZSB0aGF0
IHZ0ZF9wY2UtPnZ0ZF9wcnFfbGlzdCBpcyBub3QgdXBkYXRlZCBieSBhbm90aGVyIHRocmVhZA0K
PmNvbmN1cnJlbnRseSBhdCB0aGlzIHBvaW50Pw0KDQpZZXMsIHZ0ZF9wcnFfbGlzdCBpcyB1cGRh
dGVkIGluIGJlbG93IHBhdGhzOg0KDQoxLiBwb2xsKCkgZXhpdCAtPiB2dGRfcmVhZF9mc19mYXVs
dHEoKSAtPiB2dGRfcHJvcGFnYXRlX3JlY292ZXJhYmxlX2ZhdWx0cygpIC0+IHZ0ZF9wcnFfbGlz
dCBpbnNlcnQNCjIuIHBvbGwoKSBleGl0IC0+IGZhdWx0cV90ZWFyZG93bl9iaCgpIC0+IHZ0ZF9w
cnFfbGlzdCByZW1vdmUNCjMuIHZ0ZF9wcm9jZXNzX2ludl9kZXNjKCkgLT4gdnRkX3Byb2Nlc3Nf
cGFnZV9ncm91cF9yZXNwb25zZV9kZXNjKCkgLT4gdnRkX2FjY2VsX3Byb3BhZ2F0ZV9wYWdlX2dy
b3VwX3Jlc3BvbnNlKCkgLT4gdnRkX3BycV9oYW5kbGVfcGFzaWRfcmVzcG9uc2UoKSAtPiB2dGRf
cHJxX2xpc3QgcmVtb3ZlDQoNCjEgYW5kIDIgcnVucyBpbiBtYWluIHRocmVhZCB3aGljaCB0YWtl
cyBCUUwgYWZ0ZXIgcG9sbCgpIGV4aXQuDQozIHJ1bnMgaW4gdmNwdSB0aHJlYWQsIGJlZm9yZSB1
cGRhdGluZyBkZXZpY2Ugc3RhdGUsIEJRTCBzaG91bGQgaGFzIGJlZW4gdGFrZW4gaW4gcHJlcGFy
ZV9tbWlvX2FjY2VzcygpLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

