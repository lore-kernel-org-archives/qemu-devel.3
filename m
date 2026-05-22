Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409D8CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 08:20:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQL7D-0007Ot-LM; Fri, 22 May 2026 04:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wQL79-0007Nj-I3
 for qemu-devel@nongnu.org; Fri, 22 May 2026 04:20:16 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wQL76-0000Tf-Bd
 for qemu-devel@nongnu.org; Fri, 22 May 2026 04:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779438013; x=1810974013;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QPdhrprY7o5WLpcO6HvIOx5bqJvdM+TJxYXP2mDXTHE=;
 b=ZI8BVXO7T21NyT5dXhnlbIy22JTKISFRDsf+mOsduxPeN9hoYhcrZMSE
 AMWfSYty/7al6HlKrVVjTNQb5nd/LKAFpZt1d1vSug5lGriMATPyOy50t
 Yi1Tedvi6g6lU8ILV61cGKUYRCZ1+KH1zjRr4FkkENeB2InJ1Xw+sve44
 FSafQCbb9h2G+SYQsQOc2b+oeC2LRMRc0ZPHr54mb8Z5d7Kj2IEOfm4jE
 lLbRqVu7l/s2rwx/rjCDGg0bOTX8lShYYCN7/LUHIfNcscEP4ZTCNMXGf
 j3fFidSJGB7e0FSxdsjZpJelkjj5mlaTeBV7WQj13Xml7Dc3rANQPKIjX g==;
X-CSE-ConnectionGUID: 5WO/8ggHSZqqP7vP+GrFRA==
X-CSE-MsgGUID: f6R+DCpoTX6ypAgU33l9Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80218626"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="80218626"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 01:20:09 -0700
X-CSE-ConnectionGUID: FSJ6/pNeSne6PN1solvWZQ==
X-CSE-MsgGUID: 8VqGmKteTF+afapniQp2JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="238250987"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 01:20:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 01:20:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 22 May 2026 01:20:07 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.17) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 22 May 2026 01:20:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3sY+QEa2J0ArshdsSPV41iWP/9qyZowxpexTe6H20R3DVdOo2+xaF6+plUB2gs94Tcov+sxbjlC0MnkUgdPPdoJOBL6OEybxLfe05ronk1iGlf7ysuVR0jaFstqUSFswyJm5o/jM+CyZvhOvDpU3P1bPT99KYKQPWadxiRHljRbK7wXoWszultpMH/KmgWtJJ4uNbyISGNAD3zsYYD8C/mN8I+TdzjBqXxF+9XljdoM1Cjq9JcsYS3F+Qh7uO4YORjLwdm4+i8ZkrF2xpkkXpQJ2gZhtAtvRks3MOo6YJJYtjw0htAiI++O1U9B+ZYWRut2hCQxfM0zT0rgoLmDIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPdhrprY7o5WLpcO6HvIOx5bqJvdM+TJxYXP2mDXTHE=;
 b=IfTMBLYbS8BuMYkYzCLnStLjH7nIkT1uWbSYGvYC4LYxbm4/yEkD0bExH4sy84YQqn8ADBqZGzKzlgH4ssmZ1METYiYahQROt7gXXO2NIjO8d7NzW6hX5MFilQe9T3h3GC4kubPbjzJfPPvCuDk3RpxbK3WZIABsP8q+78AWpkSmErd8hBwW+BqTOWBb7/AqxCYRE1cPltNUL+MTsjsrcZWlWc2Gt45WtszO5puOt1t9ZQW7a4o6ldtgSBa1RztTY55w3rBnSh8+QblFaQi0Sb0RTL0CfDu5FwJAsk4LRz+yVXcw+LnI1Mf4NznQIBQ2908QcSW4ZzsVE6pBo7T5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS0PR11MB6328.namprd11.prod.outlook.com (2603:10b6:8:cc::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.17; Fri, 22 May 2026 08:20:04 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9913.009; Fri, 22 May 2026
 08:20:04 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v5 09/15] intel_iommu_accel: Handle PASID entry addition
 for pc_inv_dsc request
Thread-Topic: [PATCH v5 09/15] intel_iommu_accel: Handle PASID entry addition
 for pc_inv_dsc request
Thread-Index: AQHc32me4EElSM8k006ingDT7vUeurYNadwAgAv9ygCAADAPgIAALytA
Date: Fri, 22 May 2026 08:20:04 +0000
Message-ID: <IA3PR11MB913681991F0F6EDB3A9F274B920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <20260509040819.1044702-10-zhenzhong.duan@intel.com>
 <44c1dd56-a37a-42ca-b8f3-9ac69aa1f33b@intel.com>
 <IA3PR11MB9136BDEC87472A1BD0E93B09920F2@IA3PR11MB9136.namprd11.prod.outlook.com>
 <7bb33397-20a1-42a4-a2ee-3537295141f7@intel.com>
In-Reply-To: <7bb33397-20a1-42a4-a2ee-3537295141f7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS0PR11MB6328:EE_
x-ms-office365-filtering-correlation-id: 3fee39a7-e108-4484-5dcc-08deb7daed52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|22082099003|56012099003|18002099003|3613699012|38070700021|4143699003|11063799006;
x-microsoft-antispam-message-info: e597+7OtHb4MY9TqWJlOPZ3lEKWxBFDWSFFeXeKT503P62FlyknUsvJbP0cODBTE4LYPJhHJmOmIAjDrte1GX35aAGJ69dTciObMHCmUREAa4rfw08C5/7cVgrx9ma+hjsDI9gLI/waTnSsnX0bNYWI9E7422FFka9Wv9t8YmY7rBm8xR58KEEi+qlqsx9jMYnvNSwdWkK2sLd1tfu5zaymTNg8oDHYMfpkGtiGtLijMrdszbWYe7yigiqo1gu+e107lE8en3r5qkwtI2bFCPK0QfPNx6tZD/z38NE9egPx9eNgPgnPJSR7tW7ALm1KQTstON3MOoYiETWtH1cpAAE1u6jvoOPneuyt/Y+i8FdfEkL1bTRwprAT3WUDIdDgaoDtaP7PHCAZMEIc8fDPZ1+pvAbet6zp1gCiSNK2m2R0DgF5ae5AUkJrmzSzKEgYly/oLni3//2XehrfXq4MN5GB14rA6VH0eChtxC9uTKLyJ3lSKscD9hwb2uHpldrGKYDJg1vUk9LMHsTzdva/kfGApF5kKhINkRlklaOe5ROcBYMDi5veFoT8s1OSYrcSYa3BUk0T+uZj1bnM4wAPST5/Rv2AKEpiQd3/HyERDMuizjB6NsQqvr/wNlO+dhqhLynoNFMhaUgcX+eXHLtiqBYcW0n5A8kOYIljDwEeh2XxrKApfu8AMg0oYDbZX/rgnSkxMZScdoaMjzgm7+vJv1we2QpWBTkw/2zu1RnIt97h6rL9V4/hUwMGHV1sN0EaxwFht3VwaYX8l/PEWRP0mog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(56012099003)(18002099003)(3613699012)(38070700021)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkFXbmgwN2xmeU1hcEllblFmaWcwMVZaNTdBVlZiSjV0NUIrUyt1c3VGdFZr?=
 =?utf-8?B?RWxQQldrMm5GMGkzS3JXSURmRjRyclZkOTVGOXlHaFFoODRsWS9MSnhtdjF0?=
 =?utf-8?B?eDUwUEh5VEM3RkJDeitoK0JkZ0NVYVVYWkp0Wk92clM1dFFaQkRtdU5GNnFi?=
 =?utf-8?B?dHdsUjQ0RFQveE1JU2xvQUpEZ0ozMzFvYldHQXBzWTBLTVVaT0tyU1FoRlJC?=
 =?utf-8?B?cGIrei9pRU1IZCt1TzNObVh1dWg1bHYwR0EzdFRQSXNoejA1K1BNdFhudm1B?=
 =?utf-8?B?TjU5RzlGTEU0WFoyaktkUXFUbzZETkF2a3l3TlQ4R0w1T2FyY1k3a2d3QnRL?=
 =?utf-8?B?amo2NzcvUUJOckRmWG40YkNFaENkN09hZUNWTXc1UE1pT1dENTBjZThadm1Z?=
 =?utf-8?B?anpmZG4xb2Y2VmhHdlVhWG84a3FtLytONGQrSmU5TTJScUI5blBMcmJoVVp0?=
 =?utf-8?B?K3FiSnduWXNKd016YTJwaXZEMUNaMElHYkIzeG9KS0UzSHg4TmR2cmxFcVFI?=
 =?utf-8?B?V2hFUjQ5TEl5TG1MWk94VGErZEpZaWVJdnhaNjNRUFJROVZMcGJ6bENCclRq?=
 =?utf-8?B?QURENGJCSWphc093RDFHUlhocE8xNkV2MVcrMnlJa25qVUhzZ20wYU9XTlJH?=
 =?utf-8?B?SnY2aGF6ejIvWUhSRXRLS1BqdWJyamVBcmlXb1VsWGVkYjlWbWFvUFc0N3ND?=
 =?utf-8?B?OFFUb1BkMWhiRGN0SmY3UEV3cHlGNkdJek0ybUdUY0RjLzN6R1g0aHRKeHZO?=
 =?utf-8?B?M2NlV01KMzFCWjZyNFRCRHI5eWxZVTREbmxhWEZIWlZySm9rTExLTUJ5Zzlu?=
 =?utf-8?B?MlhoM2RaY2FyTHBBeGY1eVkzOWhzV2RuT2tjWmZyaFNnbkJNRmpVNTVjU2FC?=
 =?utf-8?B?Qm1mRXNPbHo1UWlFQW1rRVRicTZOd0lOME9lejZWVWorWDlmZ3d5eHZNNGlQ?=
 =?utf-8?B?ZCtKNHRJMFBmZGc4WWRGUVRwalRDUCtaWVpFQUVlRlRITEJtZHZMZm40V083?=
 =?utf-8?B?dm03bE0zZFRncjJqVGN3OVRRYWlWMGNkU2MyQ0MwL01UU0pYcWE3RlpydUhW?=
 =?utf-8?B?c2JEbFdoQTM1KzA4YlpSWW5lOGp6bGJoM3VvOEJsYmVRU1VXdFVaeEp5NjFW?=
 =?utf-8?B?RUIwWVgwWFA3LzAvRXhLOXBkbHpvSCtkWEFmdlo1MkxLZk55bFc1Sm9BaDYv?=
 =?utf-8?B?bmZNdnJ5Z3dySW5wbmE3V0QzV1N1TGdFNGhKbGtCNUdvaGNON1FNRml0QVNF?=
 =?utf-8?B?Q2xIaDR3NjBXVmVzaHdseW9uTjVKMEZkK2JBSE5neEkza05LWHR3WFJpM2tx?=
 =?utf-8?B?UmsxZkNaYmxwbEZ3M1d6Tm5IenpJNWI2YUx1ZlRvN0tac1JHMVN3d3dmTmFy?=
 =?utf-8?B?V0VKR1dNZ2c3a0dCdGJUV1RWNFgrU3lmRTkrTEo1V2tpajk4bXNiNHdMdzlV?=
 =?utf-8?B?OXZzbGxENE1VbE9kTktlQU1wWXI3NllCQklYczB5WmU0RytkeEszR0VER1VS?=
 =?utf-8?B?eFlqNkZtSGJkaEhUTkNKM1djOFN6cHNHZkw3akRJS3hobzBZdlliWjlxZTlw?=
 =?utf-8?B?bVNrb0pLN2RPTGVOTSt0bFZvMlI1REFlcldLSGorQS9VTnJLaFVnT1dMZ2Rk?=
 =?utf-8?B?MWdFNW0xRk5XdXJNcUxVYXdtV2VuZnZwSkFkTmtBSDRzNzJ0cXdTSTRRUkNF?=
 =?utf-8?B?MXk2ZHVvaFNrV3ZwMUFpUU1zMnN0bXliUkQzUGdyWHdlWmc4bEhGWEVheEpS?=
 =?utf-8?B?SzlSQS9obk92TXdUVGdNN3p2c3BWdWpJYU1rUDZrTDcvUFBqb0VzY0lOQUJR?=
 =?utf-8?B?Rjh0ZGhTd0FpSHFxekc0OWpidkVDYnFHbTlVeWVUdUp0ZVprU1B3YXhNUHZO?=
 =?utf-8?B?eGZIMnh5dCtqamQreWhYckdXZGc3bkFhOEdKVE0rSnFWbmJodEhFdXR3eDlD?=
 =?utf-8?B?YTRWRThwVVBYODdJM0g3MmRpTmtIR1lXdmtXclB3cFB3YXUrSnVGYXNOdm1Z?=
 =?utf-8?B?Vk9RQ0xCTzRGYTVsdFJBYVVabC9RWjNiT2tqaWk1Q1FSWWxkdi9RQi9Wdmd5?=
 =?utf-8?B?Y3o2VGpuamJta2drSnFseitCbjZFTE16T1Bqb1YvcXdVK1h0d29QWlg5MUVX?=
 =?utf-8?B?N0ZST2tmN2NlOTR4eE4vRUlJL0UxTnZBYzM2THJhMTJLa2cyaEZkUHdlbEda?=
 =?utf-8?B?dXFCZnkybS9TMFFkV09jODY2a28raUhxYWtFWVJ1bndCVEhvWTJLaFlzMzZV?=
 =?utf-8?B?ZmwrRlAyaFY0WVNxZmxZR0RCbHV4ZFBaYTRkVU9jU2hoMCt2dUhxNkxvTnZN?=
 =?utf-8?B?U2p5ME1YODBESXdMa3lPbTZSM1BEQWU2anlOOU5IRmpBVjh2UWlZZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: QlF/0l3/DAGR7uDjrr8/1arU6dZQE9qdEkNxf/SXchLvLVJCP0SeqADq0q45OHVbuUOjh8ejSvfahPJCKGZgdSGboMuhX5XmrV1d3TjcHRYyfNWsRsD2P28bquWOGZEEWoG8GvbKrjyBSGE5Jfyu0/7SBBk2cXA8DF4oLPDjEMeJdSa5ZGCRuU5cfomxr7wauJppQtRCB3Xpf1Rh8RxC3G07PWtS0JwPMC5Cfg8CRXiPpAa+uEUdTm7BWmGBtG1j/OzE/IA6ifCTjJPe1II+BVV1YSWHwNqXLMo6Y5Fa9gGRA7x0FZE6izSuKjFkTSAFDh4RypgssOoBa72j9Su0Pw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fee39a7-e108-4484-5dcc-08deb7daed52
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2026 08:20:04.5194 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0eIoE2BbD6XbXFUqHyXBfvF35i0Im3ovzleXvbi5OhadTixX9GkY4GllRZYKflQkwO6RBKP//kcBIZ6C8Q1UigU6E/jH5jD4Rs4aF8x1L7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6328
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDkvMTVdIGludGVsX2lvbW11
X2FjY2VsOiBIYW5kbGUgUEFTSUQgZW50cnkgYWRkaXRpb24gZm9yDQo+cGNfaW52X2RzYyByZXF1
ZXN0DQo+DQo+T24gNS8yMi8yNiAxMDo0NCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+
DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBMaXUsIFlpIEwgPHlp
LmwubGl1QGludGVsLmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDA5LzE1XSBpbnRl
bF9pb21tdV9hY2NlbDogSGFuZGxlIFBBU0lEIGVudHJ5IGFkZGl0aW9uDQo+Zm9yDQo+Pj4gcGNf
aW52X2RzYyByZXF1ZXN0DQo+Pj4NCj4+PiBPbiA1LzkvMjYgMTI6MDgsIFpoZW56aG9uZyBEdWFu
IHdyb3RlOg0KPj4+PiBTdHJ1Y3R1cmUgVlREQWRkcmVzc1NwYWNlIGluY2x1ZGVzIHNvbWUgZWxl
bWVudHMgc3VpdGFibGUgZm9yIGVtdWxhdGVkDQo+Pj4+IGRldmljZSBhbmQgcGFzc3Rocm91Z2gg
ZGV2aWNlIHdpdGhvdXQgUEFTSUQsIGUuZy4sIGFkZHJlc3Mgc3BhY2UsDQo+Pj4+IGRpZmZlcmVu
dCBtZW1vcnkgcmVnaW9ucywgZXRjLCBpdCBpcyBhbHNvIHByb3RlY3RlZCBieSB2dGQgaW9tbXUg
bG9jaywNCj4+Pj4gYWxsIHRoZXNlIGFyZSB1c2VsZXNzIGFuZCBiZWNvbWUgYSBidXJkZW4gZm9y
IHBhc3N0aHJvdWdoIGRldmljZSB3aXRoDQo+Pj4+IFBBU0lELg0KPj4+Pg0KPj4+PiBXaGVuIHRo
ZXJlIGFyZSBsb3RzIG9mIFBBU0lEcyB1c2VkIGluIG9uZSBkZXZpY2UsIHRoZSBBUyBhbmQgTVJz
IGFyZQ0KPj4+PiBhbGwgcmVnaXN0ZXJlZCB0byBtZW1vcnkgY29yZSBhbmQgaW1wYWN0IHRoZSB3
aG9sZSBzeXN0ZW0gcGVyZm9ybWFuY2UuDQo+Pj4+DQo+Pj4+IFNvIGluc3RlYWQgb2YgdXNpbmcg
VlREQWRkcmVzc1NwYWNlIHRvIGNhY2hlIHBhc2lkIGVudHJ5IGZvciBlYWNoIHBhc2lkDQo+Pj4+
IG9mIGEgcGFzc3Rocm91Z2ggZGV2aWNlLCB3ZSBkZWZpbmUgYSBsaWdodCB3ZWlnaHQgc3RydWN0
dXJlDQo+Pj4+IFZUREFjY2VsUEFTSURDYWNoZUVudHJ5IHdpdGggb25seSBuZWNlc3NhcnkgZWxl
bWVudHMgZm9yIGVhY2ggcGFzaWQuIFdlDQo+Pj4+IHdpbGwgdXNlIHRoaXMgc3RydWN0IGFzIGEg
cGFyYW1ldGVyIHRvIGNvbmR1Y3QgYmluZGluZy91bmJpbmRpbmcgdG8NCj4+Pj4gbmVzdGVkIGh3
cHQgYW5kIHRvIHJlY29yZCB0aGUgY3VycmVudCBib3VuZCBuZXN0ZWQgaHdwdC4gSXQncyBhbHNv
DQo+Pj4+IGRlc2lnbmVkIHRvIHN1cHBvcnQgSU9NTVVfTk9fUEFTSUQuDQo+Pj4+DQo+Pj4+IFZU
REFjY2VsUEFTSURDYWNoZUVudHJ5IGlzIGRlc2lnbmVkIHRvIG9ubHkgYmUgdXNlZCBpbg0KPmlu
dGVsX2lvbW11X2FjY2VsLmMsDQo+Pj4+IHNpbWlsYXJseSBWVERQQVNJRENhY2hlRW50cnkgc2hv
dWxkIG9ubHkgYmUgdXNlZCBpbiBody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4NCj4+Pj4gV2hl
biBndWVzdCBjcmVhdGVzIG5ldyBQQVNJRCBlbnRyaWVzLCBRRU1VIHdpbGwgY2FwdHVyZSB0aGUg
cGNfaW52X2RzYw0KPj4+PiAocGFzaWQgY2FjaGUgaW52YWxpZGF0aW9uKSByZXF1ZXN0LCB3YWxr
IHRocm91Z2ggZWFjaCBwYXNpZCBpbiBlYWNoDQo+Pj4+IHBhc3N0aHJvdWdoIGRldmljZSBmb3Ig
dmFsaWQgcGFzaWQgZW50cmllcywgY3JlYXRlIGEgbmV3DQo+Pj4+IFZUREFjY2VsUEFTSURDYWNo
ZUVudHJ5IGlmIG5vdCBleGlzdGluZyB5ZXQuDQo+Pj4+DQo+Pj4+IElPTU1VX05PX1BBU0lEIG9m
IHBhc3N0aHJvdWdoIGRldmljZSBzdGlsbCBuZWVkIHRvIHJlZ2lzdGVyIE1ScyBpbiBjYXNlDQo+
Pj4+IGd1ZXN0IGRvZXMgbm90IG9wZXJhdGUgaW4gc2NhbGFibGUgbW9kZS4gU28gZm9yIElPTU1V
X05PX1BBU0lELCB3ZSBoYXZlDQo+Pj4+IGJvdGggVlREQVBBU0lEQ2FjaGVFbnRyeSBhbmQgVlRE
QWNjZWxQQVNJRENhY2hlRW50cnkuDQo+Pj4NCj4+PiBUaGUgaW1wbGVtZW50YXRpb24gTEdUTS4g
QnV0IEkgZ290IGEgcXVlc3Rpb24gdG8gYXNrIGhlcmUuDQo+Pj4gVlREQVBBU0lEQ2FjaGVFbnRy
eSBpcyBjYWNoZWQgaW4gVlREQWRkcmVzc1NwYWNlLCB3aGlsZQ0KPj4+IFZUREFjY2VsUEFTSURD
YWNoZUVudHJ5IGlzIGNhY2hlZCBpbiBWVERIb3N0SU9NTVVEZXZpY2UuIEEgbmF0dXJhbA0KPj4+
IHF1ZXN0aW9uIGlzIHdoeSB1c2luZ1ZUREhvc3RJT01NVURldmljZSBpbnN0ZWFkIG9mIFZUREFk
ZHJlc3NTcGFjZS4gSQ0KPj4+IHRoaW5rIGl0IG1pZ2h0IGJlIHZhbHVhYmxlIHRvIG1hcmsgdGhl
IHJlYXNvbiBvZiB0aGlzIGNob2ljZS4gVGhpcw0KPj4+IHdvdWxkIGhlbHAgbWFpbnRhaW5pbmcg
aXQgaW4gZnV0dXJlIGFzIHdlIG1pZ2h0IGZvcmdvdCB0aGUgcmVhc29uLiA6KQ0KPj4NCj4+IEht
bSwgeW91IG1lYW4gd2h5IG5vdCBwdXR0aW5nIFZUREFjY2VsUEFTSURDYWNoZUVudHJ5IGxpc3Qg
aW4NCj5WVERBZGRyZXNzU3BhY2U/DQo+PiBUaGVyZSBpcyBleHBsYW5hdGlvbiBhYm92ZSwgcGFz
dGUgaGVyZToNCj4+DQo+PiAgICBWVERBY2NlbFBBU0lEQ2FjaGVFbnRyeSBpcyBkZXNpZ25lZCB0
byBvbmx5IGJlIHVzZWQgaW4gaW50ZWxfaW9tbXVfYWNjZWwuYywNCj4+ICAgIHNpbWlsYXJseSBW
VERQQVNJRENhY2hlRW50cnkgc2hvdWxkIG9ubHkgYmUgdXNlZCBpbiBody9pMzg2L2ludGVsX2lv
bW11LmMNCj4NCj4NCj5obW1tLiBjb2RlIGlzb2xhdGlvbiBpcyBhIGdvb2QgcmVhc29uLiBJcyB0
aGVyZSBhbnkgb3RoZXIgcmVhc29uPw0KDQpDb3VsZCB5b3UgaGludD86KQ0KVGhlIGZpcnN0IGZv
dXIgcGFyYWdyYXBocyBpbiBjb21taXQgbG9nIHNob3dlZCBhbGwgcmF0aW9uYWxlcyBJIGNhbiB0
aGluayBvZg0KYWJvdXQgbm90IHVzaW5nIFZUREFkZHJlc3NTcGFjZS4NCg0KVGhhbmtzDQpaaGVu
emhvbmcNCg==

