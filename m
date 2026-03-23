Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB24DFC72A8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 07:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4Zpc-0000Za-6g; Mon, 23 Mar 2026 03:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w4Zpa-0000Z0-1T
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 03:36:10 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w4ZpY-0002Y2-Cl
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 03:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774251368; x=1805787368;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=boKYWpPQvk2HNeFLmp4/tIbkmEoPkB3ykTS9pcHW3hE=;
 b=kbmNY/s9VWQs7ZFCeukUQEY7S0eAYm/v9VSx03/ATk+Ys5/fiAnFLq36
 IsNmqygo7BkvAKYpr6BA1qCu4bw/JxtLWJG/3+k6vQNhHQj2CJ8wAxsw8
 6QZIljKQWLBBXKfYBUmne0+9AK20XFnKX9fDdsIYB7WB+WjecJQ35es76
 n/fvlKXoi9tSRCO0vOknCQhb0j/qIfpfeZ4WQOfZCDJqiQ2ObxrAgppTW
 FlfgCDiQzX4WY3TJWtVB8PK4mqBBwMGoR7/XGuwAf7xHVFMLBMl+VpGtb
 qEC+lNXLhTD2jRZrL8Vp0w3S64QGq7/1/ayVMfMbcp4JnqD9snjEGqqyS g==;
X-CSE-ConnectionGUID: E0JaNSRjQ66706jIGicx1Q==
X-CSE-MsgGUID: cmdID7OwSBGk9VC3DxZwaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="85867709"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="85867709"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 00:36:06 -0700
X-CSE-ConnectionGUID: XzHsz7TzSFiDyy04fqxlpA==
X-CSE-MsgGUID: VeQIwiapSjumtaVh3ZZZKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="228668651"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 00:36:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 00:36:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 00:36:05 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 00:35:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4y30CVM4G7uItr2VHBdiMKHPzVE8fw18gHMyCr6pazHcO9k9m2BZr7PnrORSifug6sRlo3eWeQcKoG9jJezGdYXzlwCFOO1tfVpVoiYJeiwmpe3iqjPiyrMRsU38AZ3W4pmdC7NwIEIr5hnVDoxJY3wCOH5bcLFyy+BLwyniuIUPK5F2F59DvRnzz6+nBy36DBHtf31sf/IKoSn9tKekZDcPnqEZXvyBtk+3q9yisFl2542lMRDbaFFPBFaX0C8panwFs+I0cPSXVw5BjW8hARvocL4ZLMvRxd9xBJ3sxy362ltBQb9rzvoWZCPrLHTkecOPOAeoGaVp5DCjqNMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDVNSISj4MjK2ypxyRz5n/k/QhMGeSv74g5/5eNU5Ro=;
 b=kRlHROIsnKGdhtt31QhRdZ2a8hPG3uVIREWQkzG1+UF3gJz0T5jAwWwEyIy88hQs0LZi8Ka/jEcWp9rYNRffUka5c1kS8P5SCpmvhNJpELw4nmSL1u34GWPevVgmg2NIB8CJCI/dweEjwIApdYVI29Ef7jMRdGobDzs3kmRTGx9mywDLXiW+9ooyjcafGYWptyIv0OyXAZrckBCdUxv204fYNLTK9SqGune7PvrB6VtSO+XRJv/APPdiVXQnKmbEOjsz9pmnJVDlfAY6vjmHn2CDSnBkNRyYbpfMIBIHerxyWCn1RvJsuHD7w0bkCZkSANcvu+aDlELFmxzlIbD20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DS7PR11MB7740.namprd11.prod.outlook.com (2603:10b6:8:e0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 07:35:27 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 07:35:27 +0000
Message-ID: <4aca274a-9b96-4963-9b36-fd710815d053@intel.com>
Date: Mon, 23 Mar 2026 15:43:11 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/13] intel_iommu: Handle PASID entry removal for
 pc_inv_dsc request
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-9-zhenzhong.duan@intel.com>
 <e642e31b-49d5-49c8-af7f-53cd5768e336@intel.com>
 <IA3PR11MB9136E8022237A46CE1413042924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB9136E8022237A46CE1413042924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0018.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::19) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DS7PR11MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d5922f3-f236-4c43-4a02-08de88aec0b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|7416014|376014|366016|1800799024|56012099003|22082099003|18002099003|3613699012;
X-Microsoft-Antispam-Message-Info: UAkek4b+jc35hx09SagDc8EFvUaJ9aokmDAx9OBXpmvlGZqHhV0RCFixVEcQberjvNPrq09cVpy9lCmzEIXh4mRaXzl0hilRcFxM4o34piFvCFVbFeAXCn+f9mMGH4Ure+z7OpnlxGiVzQLMhYwb9Npr4C1FBZ2QHsMCD2hLfniIgalrzv0ZrIecbXVkjrGq6z2XX5Jm07P1qZmDXqhUcP7cZ+jTMVPonygTS7dFzn76QUcaRUQ3Is7SaHd5ZiznQtV3zCxQegxlHgyTKS7HvweOvF9aofALG6M1PGCpaWo1frmdePz3hash/9V/xxaeXCHcR4xVthIXF4YApTNX0XwMbBMldWzNMBkGuGFPIQQ7iOdR6NFoH6FbbogZwC9i8HmGJUL81Os3xjQirZr8Qeq4tr+EwT1GwQ2BBubhqjJdyFAqtoMNSAe0Kt7IXrUuDVUjVoGEwO4GYjEGWRckelvQ8e0e1QBhwoQlos/kgqQB4PSdXez/gjrKZqUjymICEK+IsyzcUdyxeAQSvoEqM3EA9Ft8eMlDkfWD4u2JutxkXK+v3ytXKbPEZWOTba8bk+YePBbXTxOeNDqyJMvt88/nGyvM99/ZZO6nQcSB+F1B8WFTKq0GMwRO0iyZ6g47wmqlNgJgu+jyzSTFcIrflzbocGa/EWM/YDAdbC8zcHtMg+HxAHZ9TDMtWMnxqAKKa2bhA7aLJPzb1kirxeWAmTXBz+Zjdg52wEn/dpzc1DNq36uilY2zikZP0/MQHXBE3SBlu+ZkiRDoLtjziQIt6bImnA/pavqlpF1dwa/9fvg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(7416014)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(3613699012);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3M2SHR1Lzk2QUFpdVA3dTJMVFlTQUZ5M3RPRklrRU1tNUZJWE05TDNPSnhV?=
 =?utf-8?B?NkRJYkVaeUFVOGExcDFnOGRmb1o5MEJlMDA5NFIzbU4vbzhhUEljLzREUjY2?=
 =?utf-8?B?b1hMZnY5dVFmZElWN2FSUS9WSitmSUc4MEpER1FBV1BvNS9mTG5sZFUxbTlW?=
 =?utf-8?B?NWNwK3gwNGR0Q25uZk5BTGd2NjhsRmd3cXY1eFJzYTNldUpiSWxka0FDQlFw?=
 =?utf-8?B?V2kxZFBRNkVFRnlmT1dqWElaUUE4eFBoYStYb3RPV05IVWlJcFBLSDAzUEl2?=
 =?utf-8?B?VmJoWGRNWlBrc0JieUZ4YlFsVmUrcG9XWlRkMHp2LzQydFJJRzROZHZBNXZt?=
 =?utf-8?B?bldmYUxwVlp2M3FpMEJpNzB6eWhBK0ZKbXZNSFdXbFF6RmJxQUZrVGFaWkNU?=
 =?utf-8?B?dGJsd3BLYUJNSG5rb0JUeUI5M0JVY2E3WDc1QVBQMTZCeG53N2JNYlYrQlFB?=
 =?utf-8?B?MHlXaTNEMmNnaytKd2NZS0x2QVh0R3J5QmR1eUZrcGc4aDJGd1hTQmFZMWht?=
 =?utf-8?B?WjdXYUVOSGQrYW9uelQ3czBVVkFzcCs0VWg3ZWkvWDQwc0tzSCtRL3VzUEdQ?=
 =?utf-8?B?NlgzeTYwYjl6Z2tnMUl5VUJHZHE1VnhTRmZYVFdkQ0RXZVpFcUVnWm9HOXpZ?=
 =?utf-8?B?WHRwSzBZVUpHa1RGaGhOWE95cXRmU29wc1p3WGh5bmJyRGhrdldnUCtVTWdi?=
 =?utf-8?B?SG1iVlZqUVhnV0hMWElOZkZlVUh0bXZncDdyU2x4UnpodllZZEFibWwzbE1M?=
 =?utf-8?B?U3d2V1lUL0c2Ry9JYmVSQXZTNlFNV1k0a1pLbTJiVlFYWlBpeTUwc2N6VVJo?=
 =?utf-8?B?ZGdGWndvV09PTXZ5VFMwcGVNYTc1RVNudDlFU01laVRtSjVJejVpOGJSUUxI?=
 =?utf-8?B?UXFqZ1NPdDdMWlBJaWpPakZRazRUM3hMTE03elZSbWUwaS82N2c3ZGxMK25S?=
 =?utf-8?B?Q1E3aGQyYUtxNEl4ZE5FYlNsc1Y3bEpTOFF2OTNtU2xPdWFQc2ExalZlTkFW?=
 =?utf-8?B?NVBZY0hGRzdqZHRyRHc4akN3OXUvU0Vra0RoSWVZaUpPOUtEcHozK1h5dHdF?=
 =?utf-8?B?NHJtT0xMcTdJTmhNMHVaYzE2NFgrcVJtVVQrUHJQNGdCVkwzdXZ6YXVmekp4?=
 =?utf-8?B?NmVJQ0lxM2JmV1BwbDFHTmlGYWdpU0I4N2RvM2I1cHQ1S1NnMGdsR1V2UTAr?=
 =?utf-8?B?UTZOa2NhTzdQR1dPeDRjWlFZM1hkRTg4cUVUTmFySzF1V3pLUXp6K3RPV2Jx?=
 =?utf-8?B?YzN3dk81akg0a3ZRYjU4YjZDUFRoODZvRkw2WDNMMVFGcTVCQWFZdE95VC9Y?=
 =?utf-8?B?Y0Y0bVQrSFV2U28yajJkS2dyK3VNRGVvSHZMRm93eDZMRStWanNmUEgxYTFv?=
 =?utf-8?B?clgrWmcwclFDbjRPNWlJWlhXYlBnV2NXeS9IL2RVT3I1NGFadXQwZUJqTGRU?=
 =?utf-8?B?NnNtVlRQR2txeGdmSk5vbVpmcUs4S1VPQlgvd3ZuaHRXNlpCNi9wcmVHbHIx?=
 =?utf-8?B?ZFRqK0x5MXJsU1lKcWJMU1podjg1YVV5R3pzczcyRDNhS3dQVlpNYVEzU0do?=
 =?utf-8?B?U0VaVGhSTUgyaEJTRVUwTzVDbVpCc3NRZ0d4eFhrd3pzQUdSSUtXdmZYOGJ1?=
 =?utf-8?B?U3lLSkZyV01WZjhnalRueVd1Tm5ubzBHRjJnNjhGWkdIVitLV284YWdXejVr?=
 =?utf-8?B?MlEydU1uMnFhSnRqdklGMXM4V0RseW14eU0xVm4ybUlzbEF2V05aOGtiWVYv?=
 =?utf-8?B?QjcrQmMrZml5NENQRm9saGRJU0gwRmQwdmdmRlpTRVFDZFVTZCsvcFptaEUy?=
 =?utf-8?B?OTcvbW9EaXUzcjNIcEswTThncTdENGk1cXJLTjRpVmJmTTN2azhMc1g5Rnk3?=
 =?utf-8?B?VXJoTmRHQWhIblFlWlVzL0ZzWmpYbFlpNWt4ZEpOQ3diS3VSWXlzRUd2UjNL?=
 =?utf-8?B?Uml2UDV0YnR1SFBBZGNvaFFZb3p5SXJkNzk3akxVWm9WTlQrYnlTTUJTbXUv?=
 =?utf-8?B?NWtHVkFXSlpqUGZOMGlzdU5lTkZvbFNPZUJIT1FxRVFLNGZ1VmxXQncya2lu?=
 =?utf-8?B?TlNvamJtSUFoTEhZT1pzOGswT2YvYTB0UkJCOEV6UjhtTm5wTjFZRlhDaSti?=
 =?utf-8?B?RXE2emhWMk1MdTBGSnFDa1BBNlFLdUUvcXh4alljRjRUWVZmUlQ3SVU2Snpo?=
 =?utf-8?B?VGowdTVrZklEVUJVbTZXMGZESVpnQjFweGJUZ3o3ZXc3UW9rRjVDaU5rcDZN?=
 =?utf-8?B?M3QwQjJUNEtxQ0d4S2xxcEFIMkxETi8vdWhBL1AwZ000czd3ZGJtazNJN2k4?=
 =?utf-8?B?RGY0U0syaXRaSitxdXlUZmQrVEx3dTdMdWcrT1pheTdLTm8wb1V3dz09?=
X-Exchange-RoutingPolicyChecked: fLeWdeSQP8jj5/rFMuorj+JzBQ6uQ18I4nXlq8qOGtDIaUf61FGgGOSAyUCt6cJpD693H6jJnMg+PuAEQdJ9GrBDw3HKzfTZ9tzP9dmXqHvrEfVPreSq0jcx33UMzcyZUqpX5pkDDEBF3SvDiVgvzdEUd0Bhz7lBLfd4o0bZvhfOl3HdgvLJAidYjNQ0zJkqU9eoCSRbJzbOCC2bXRzgLiV8V/93fekXoa8g+JpTWrbk62CXkAQkFky+tB4cKztAeGGAxcGkNrKDuVbBet+mEHwJ6Nt4NPQl39pQFey6NO8BFafjiGv3Go6Qs2Y0OxEFV9QgAoCKooO8W5DtFxd3Rg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d5922f3-f236-4c43-4a02-08de88aec0b2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 07:35:27.4842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rM8aeHhjsVFnlOkR1fFKU68S8I1A7yei7CRtLafegQ18pHgkYQenGqPzF7DNbk7+KzwJcjXSW+c9euDNwCyOVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7740
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
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

On 3/23/26 14:08, Duan, Zhenzhong wrote:

>>>    static void vtd_find_add_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
>>>                                VTDPASIDEntry *pe)
>>>    {
>>> @@ -423,6 +491,8 @@ void vtd_pasid_cache_sync_accel(IntelIOMMUState *s,
>> VTDPASIDCacheInfo *pc_info)
>>>                                     TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
>>>                continue;
>>>            }
>>> +
>>> +        vtd_pasid_cache_invalidate(vtd_hiod, pc_info);
>>>            vtd_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);

a minor optimization, for PASDI selective, if 
vtd_pasid_cache_invalidate() already handled the invalidation, then the
vtd_replay_pasid_bind_for_dev() can be skipped.

