Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA48FC97F3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 08:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w78DU-0006SM-GL; Mon, 30 Mar 2026 04:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w78DS-0006S5-Tg; Mon, 30 Mar 2026 04:43:22 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w78DP-0002FZ-IX; Mon, 30 Mar 2026 04:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774860200; x=1806396200;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=pZHymSJMS8C5lT+2IdNEbnDUioM5pV5wfGttO9MeRzA=;
 b=IA3R5yKzfV5/lXriumVVq1XnH5LKWXV34Nghe1Fyzl9pkSoSCO12cCmU
 mnuQ/2YV50c/Ai0XDDxLSc8GNF6wA7kvFVOOWJhyLhoY1CMFxyoF2mE2E
 hZ8BxGYGnIlbMZuN0hX3i+y5qxo7g0WOWpC5uAQOI0Prb0sbaqm6pP2B+
 Ynr5qEL8uH4dJa1k3qAqaau08/or3CdKslGbuqastcTe6ZlZioTS+wC8/
 yBBnHHDH8rn5I6AGu3B5UhUIadR1gw+2ASig/CpV8F+OSDIMKtqk9tULV
 Xt2S7y2Ub7ReDO/R9iOwc3CCTjz8ILId2h8IGTxM/ffmCa1eUx7Flkt9c g==;
X-CSE-ConnectionGUID: /74NFZfUQfSruz27XIRqrg==
X-CSE-MsgGUID: 8OdsHyxVRxCn1D+ClX0sQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="63398975"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="63398975"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 01:43:15 -0700
X-CSE-ConnectionGUID: vVdMIPCrRkq52hR9gRYE4g==
X-CSE-MsgGUID: V2gaqMZxSxua95v3sJwbAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="225892463"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 01:43:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 01:43:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 01:43:14 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.33) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 01:43:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlqAJPjFjUxfdIsVW6HNhBg9DklrR+4DCKPASLOlzDiZxMX/lhynkX5SYfSlhWZ2OZ7H7BozO9CCzPgrAP/jZy9uvzilbw0GcXjx3ZyTAjAvJFlJMtmvH9+uJYjVUv6jy5/IEaRQSPA4UjfTLkfN/hETEf7XcIiosAdzNThc938xz0CkR9TG52KBVDY66RnRN8x/t25AstA4yOA4YRRnr9dBWHOZ664laRSsRSS1UvtPoscTzrOG5dbDy/WC0jDnyvkgI7eqJm0Ka3Hmilsmh0xz8PlVaBcJtzRpyMibTZr12m+PI8Pdzi5tzibXUTQY5Sn/W5JIhIsPZQbOX3MZiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjSzSzbdblij6kDOGqc+5g07Lh8sbI8AVnWBDlFN3Nc=;
 b=JgfU50Zli4RQ3ppPWNdBrdgIYXPMHM3/BcDiTDqcopwV512LhY9Nba9/u77ZgnDH07W+Rjo2Ex+TxUQkM/m5oP0cZvCNne0289YiBTtT3NrmTfG64NNKV2lNccA7FJSg0oL4Fnhq9jqztGSC1rOD9v8RQFfFiGex2c3e2aH2T1DKRXn/bqAxDXgjCSdVF5+052vTIXUEsIjXVthLnkNgVg6Aa2ubD+2t2DyBSu2lTuySskJww4ZNiL6bl/RHy3Zpuj7S7/O4PhB4NzCP6IX0oznzWg43HbX0rfenLV9mQ0pmWpVvbU/G7MmNFs7VYSpbyjwTCQtQtWd8qf+jClfilg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DS0PR11MB7902.namprd11.prod.outlook.com (2603:10b6:8:f6::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Mon, 30 Mar 2026 08:43:12 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9769.014; Mon, 30 Mar 2026
 08:43:12 +0000
Message-ID: <a741b304-7512-4281-b3fa-6ce8b4daffe2@intel.com>
Date: Mon, 30 Mar 2026 16:50:55 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
To: Nicolin Chen <nicolinc@nvidia.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
CC: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex@shazbot.org" <alex@shazbot.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "skolothumtho@nvidia.com"
 <skolothumtho@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@bull.com"
 <clement.mathieu--drif@bull.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-3-zhenzhong.duan@intel.com>
 <acWwwzfNEzBg4n96@nvidia.com>
 <IA3PR11MB9136FC71017C3B05CE3C881D9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <acX9/RjKaO0bBI/d@nvidia.com>
 <IA3PR11MB9136D9DAD0B8698841CEF4429257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <e97aec85-c9f0-449c-99e9-bc4b4f2d33d8@redhat.com>
 <acbt8FaZwzDaXtmT@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <acbt8FaZwzDaXtmT@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0010.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::19) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DS0PR11MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: 245b73b7-76a2-4542-f4e6-08de8e386064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|42112799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: MYwkyv5QLOQq7RCSOScvJxNnoelpNfNHEdRzs0hi8WtY4c6GITHcCSP2PaPFSy426GcqS2iCT9VWqotu+YZ0wI2PKGDHYdVnxY1y3ysQLLwxyVYYySCr1Z312jf4gcNDL8E9PTYcDfxoT6Bf4JG8bjOt/PWHRKdCNaERoB0l4cO4yhRDTDj/SVHtJkZeJzHCnRaeKFvkVd4naqHC4PtHjOaqq9h+X2sAdGzi5C9QzHQTmRMopD8f1I/YJWeikbeWtdDLQwlNbVvW47avxEYTz2FnEbAPj5qm1MHjruVCRz9dW57P09vbnWD0DXgeioBA1LgFSzfDZV2I61BK+GCtoV4vFvJQk/9gTTUVoVk20Sy6ivCtcUJFUju76weEf//TCQsFj5lbG8F8QUg9ISSliFsD4BPmvnsgIB3PkiwIAbkDCFx2plNahiGIzZCa5upa9svwxOTclGtdrZpXfLL86YtWe+JbjeD3wxDx92WgagK0ESP0q5dbEO9x/AsnUgpMCzorVUyQRXRovLkxU6YE/HJxfrlKbjjyneD4oL7HYvWtKw9pvYVMbKZPUMOs/IAFTsTcDNkLXBQVg+GvXBCRr1MChCjoRO+Mzq6tO052YGG0Phw8V1yHyvilhdvYizpSe/Viq1id2yR4X7+AknrrDYsBOCHiGKj6KOqOuDB90TAxhhDzBU3ij32Z0SPBflFLVJSrjSK+bqiY0kwvHg60+EH/xMpGkacRCMUDYRvJ+hI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(42112799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXZuRFUya2NBQXRWT1BGVVRrNFl0Yk5yV0J2amo1bUl0Tk5lZzZPSlpITkhr?=
 =?utf-8?B?TVBRc0F0QlpJeGF1a203K1h6QkRrWW5LL0lwNFptSUttN3JVT2pFVHJqYXk3?=
 =?utf-8?B?NkdpMGppQ0J6cnkwemxGVjUzMmQyTDdJcU9yekE5TmpBdm8xdU9GZTAwaWJa?=
 =?utf-8?B?Zm9Gd0FrMG5JWG90STFESi8zOHVXN0pjZkFCeUg1a0FiNzB6S1draWF3aVZV?=
 =?utf-8?B?Ri9QVWJDcElnTWVqV1hrdG1pNHd6elE3ekVhN0M2N3V1b2REVVE3Sy9OTU8y?=
 =?utf-8?B?bE9mcXFIQW5CbkFwN2RBeGR0cjN6cGNWQ01DZE90K01Icm5WSlhKNGZ0QlI5?=
 =?utf-8?B?QXdQSFpibzY2MW5pVS9WSHd1WW1xQjlKbmhQU3QxQVYyNDQya0xsdU0vTG1X?=
 =?utf-8?B?SGU5dnl1SS9IY2tKcVB4UlB5a2ZGWWNZVjF6dSt3NElsL0Z6L0xCRGJHN3po?=
 =?utf-8?B?Sjd1WTBYQmo2Ly96YVB0MWQzZ2lrYWkvd3lnNXF3VU12OCtGbHF3ZXJFZXZJ?=
 =?utf-8?B?TTVja0FpbVhwT1NjSkpYSW55MGFhaEJxMVZKaGdXR1hmZEJteW8xK0U4ck4r?=
 =?utf-8?B?d2pFc3RIckNxQXFRSHIzYStNMGh5eC9KWGFqdC9lTXBPNGovVXQ4ZHI5T1FJ?=
 =?utf-8?B?WTQ0dGhLbXdiWjBldlFsUkNsNHJob3A2c0VWdUlldGlaUkdPV0RhbmVKYVRu?=
 =?utf-8?B?S3pHeWtBRHpJaEViUnBLWHBGaFMybWFOd0Nqa0RNZXpQTGdodzlScThoWmRB?=
 =?utf-8?B?dG1NSnAzYnpRYWx3ZlptQ1FzdlNPSmJuVnNPSkY0VWlZcTdqOFZpZjF3akxr?=
 =?utf-8?B?d0F2WjF6eGxBdmdLcnBRMWlaRzVidCtXNFdRVVRuYitXMFFiNXE0dHVrekM3?=
 =?utf-8?B?dXk0S1FabWlRdHljR0k5NkR4OVJLeXQ5dUNoM0E3TXNaaFZ1eDJZZEp5Z3Zu?=
 =?utf-8?B?T3RZK0J4NnFaZUY1eit1ekdmUnEzVHpJeEsvMjNSSnBOR2ZPZkhzbWpIbDVk?=
 =?utf-8?B?V0VWNWRiMkZQT2htOWZpd1VaTkZMZVAzMnkyQk1nR29ZdWhOZlF6dm1nek1q?=
 =?utf-8?B?aGEzNFdadWNldlEvQVZuUEJNR0IrL29IYzR4cW16M2t3YjZjZkN4MnpGM2xB?=
 =?utf-8?B?RGx0UDU1elpGZDRNdVVpZUpZekpSSkFWd1dyem13Zk1WYWpTWFdVSURoVUhw?=
 =?utf-8?B?K2JVQlhNWWZZVlFNODR6TkhlN1k5RUhURHk0SzJpZmRucC9vdUxJeWVtNUZi?=
 =?utf-8?B?VXJ4djZOZU9WdW1JbUd0eEZ5RG5qaVFid1o0MEtmM0RzSjY5WGZ6UjIxeEdz?=
 =?utf-8?B?WWVNdjE5Rk0zSXBxM3VFU2Y2L3JQUU8vTGhPWHFvQm5TWHprNmY1WDliNVJG?=
 =?utf-8?B?VTBncE1yRTRXTnF6NGJtTjBXRklBaGZuTEhwaW1NUllwS0RObGh4bjNGVk8z?=
 =?utf-8?B?TS9mbGo5UTNCUG9nN1dxam1mL3BESi9SMXBOQ2Y4Mk13UjcxZXpTUlZtSElJ?=
 =?utf-8?B?YjZjUjNFNW01ZUF5bVhVTHorTUVKYUl0SXoyMGxjNnA4dkwxcHVQSzljYklN?=
 =?utf-8?B?SDllenRISVdEM0NYYndhTkxRQ2dGTU1XOUxma3VjWXhwUm9zWmRmSGVScHcr?=
 =?utf-8?B?cnUwUkVpRy8rUm1pVDBBUDBCeXFVL05ad0lXY3d1bG4vWlpNVTlQWmt0NEFN?=
 =?utf-8?B?YXJLdEhBNm52NVVBTW5pSGdnbmRDWjh2a05rQmd5TDZRc2dDSWovV2lHVUpR?=
 =?utf-8?B?MHFFTWU0Znk1Q200UTMrUGhQM29uUmhuQWlsRDJldWVjR0h2RlgxOVJXVzZp?=
 =?utf-8?B?UmJBa3pvMC96N1VGdE1SNkVpZkZvOEVKQm0rSlVxbFM5WEw3czZOREQ1WkVW?=
 =?utf-8?B?Z1dZWDdyRHQrd1FkMWlra2VVazlRaUh4V3hyR0V4RzZsZlp2NEgxYkwvNzM5?=
 =?utf-8?B?MFlra05pTXduWngrUkFtZEpHZ3IrRjZmcnhBSDV2OVNqZWxVZldBNUMwcy9V?=
 =?utf-8?B?UXhuMCsyb2dWeFJJZmxyT3VQTTZBSVZaZnhWazVHQmtscjNpbXNoS0lXRUVO?=
 =?utf-8?B?cWxxSnNUakZGbHF6R3hlcDhWU3hrS2dxWXBLS2RZM2U0WTVDVGkwQVZaSjN5?=
 =?utf-8?B?RDlsZWptVlJTWVlSRXJXbDVoSWYyZFArNTFOUGpQOE8ybnZieTFLZDZjYkdt?=
 =?utf-8?B?Qkp0YlFyTEZtVzY0bkRxQVJFWXdHTGtrMmU5NnpBRWdld0h6K2pBMGdNcDlv?=
 =?utf-8?B?eXhXdG5DNkhOcnRXSmJCY2hQWjQ2dmJHL0gzTUpScTEyU0hQUC9jcGFDOEcw?=
 =?utf-8?B?YXJKYWVsL0dMZzR5ZnpOeU8wMzVwcHVUTzJGeW5lOGRmc2ZuYitjdz09?=
X-Exchange-RoutingPolicyChecked: MXIDyH8NyrHbVemgz2r1G/RN3iX0Q07uYueugGTrKt2LnVoX9MJYxsOOY6K8NTFor0xSx58qjWmAVgdBfiWJqWYceBUekyxhzqwFL3E/fe7EJjxzB4yosB7oocPfR/pxbfggGeQJC8ueyxIuP1OSPMpo23l4QOqaIo956Vs4qVb2WQDe11iZgpaTDXDlVU640hJgRS8VdwyfakAyq+dWZKRSoqpsLxhqx+pEawJNoVMxOTR8wgSeVVNiGWPto+dBS9Tpsl8e2nFcxSSwSl7QBYuj7HhMgQYKUESWqFjKbRRB5gwk89lqJqFRxY5l4wgZNoHAzkRox6KC8ldzDazMIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 245b73b7-76a2-4542-f4e6-08de8e386064
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:43:12.0852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOuO2sN6XOKh3TF3leqe5QcfNBPfbCv+Jt2sf2kosb5wuF1op1/ag32XWFZdVpQFlHZamzpd3w83pMAkPoDoxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7902
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

Hi Cédric, Zhenzhong,

On 3/28/26 04:52, Nicolin Chen wrote:
> On Fri, Mar 27, 2026 at 10:34:01AM +0100, Cédric Le Goater wrote:
>> On 3/27/26 07:44, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>> Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks to
>>>> support pasid
>>>>
>>>> On Fri, Mar 27, 2026 at 02:32:57AM +0000, Duan, Zhenzhong wrote:
>>>>>> -----Original Message-----
>>>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>>>> Subject: Re: [PATCH v2 02/14] iommufd: Extend attach/detach_hwpt callbacks
>>>> to
>>>>>> support pasid
>>>>>>
>>>>>> On Thu, Mar 26, 2026 at 05:11:16AM -0400, Zhenzhong Duan wrote:
>>>>>>> @@ -138,14 +138,16 @@ struct HostIOMMUDeviceIOMMUFDClass {
>>>>>>>         *
>>>>>>>         * @idev: host IOMMU device backed by IOMMUFD backend.
>>>>>>
>>>>>> Not commenting against this patch, but I just found the "host IOMMU
>>>>>> device" and the "HostIOMMUDeviceIOMMUFD" a bit ambiguous. It's not
>>>>>> an "IOMMU device" right? Perhaps somebody can help me understand :)
>>>>>
>>>>> A host device under host IOMMU?
>>>>
>>>> "host device" would make sense, not "host IOMMU device", right?
>>>
>>> We want to emphasize that it's a "host device" backed by "host IOMMU",
>>> "host device" is not enough, I think.
>> Yes. These are related to the Host IOMMU device backends :
>>
>>    - VFIO IOMMU Type1, a.k.a legacy backend
>>    - IOMMUFD,
>>
>> There are other implementations. VFIO IOMMU Type1 is versioned and
>> a ppc flavor exists.
> 
> But the @idev here is a passthrough device (VFIO/PCI)?
> 
> "IOMMU device" would be SMMU, VT-d...
> 
> Especially we are adding @pasid parameter. Relating it to SMMU or
> VT-d sounds weird.

how about "@idev: the iommufd-backed assigned device to xxx"? This
object is quite similar to the iommufd_device object of the kernel side,
kernel refers iommufd_device parameters as device.

1046 /**
1047  * iommufd_device_detach - Disconnect a device/device to an 
iommu_domain
1048  * @idev: device to detach
1049  * @pasid: pasid to detach


