Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81B8108B8E7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 10:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Wg1-000820-Di; Fri, 20 Mar 2026 06:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w3WfF-00079l-AY
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:01:16 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w3WfD-00023F-58
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 06:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774000867; x=1805536867;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OmemL+9wCOs9kEr4HHbygI9OlRMoCo7ani0hbxKFjhs=;
 b=QkywibBEpwYHVMM+rKj9r+TOewAheb5/qo9h3LRLrNN0GRbudDgsm7m5
 XSv30R2ORt3EBpt/ojj+fMyHtfI4ZNgsvFlRGXl1IUHkfoSj2AXvNeH2v
 47eiok5Yl1Ilb5y/m5cfc6BEMrV1g+IorSZlZdmdrNoX7sdAqv21R6UoX
 beJqEJW0D2Q3p6sXZit9867O1tRA3nwPxL4IHC6GenXlINqxaoOF7Xqli
 UbLPoOaP8ViZINFr4cuFFwi2pzNU21wKDzdVnRr5CgCdnxAY9SQduGo3g
 i6lePhsiSUkpiQZvufTufomJgRJUv/egeZPFZcrPBD29pHCMevtRUEdGl Q==;
X-CSE-ConnectionGUID: xoCpBvmjQLKwOY+To+6ZDA==
X-CSE-MsgGUID: /CCLgi2fRUecoP3p3/vQlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86559334"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="86559334"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 03:01:03 -0700
X-CSE-ConnectionGUID: DJwaglROQmaqku7atwkSXw==
X-CSE-MsgGUID: FZfaglVjR3O9StJZ/ZpcWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; d="scan'208";a="223225127"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2026 03:01:03 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 03:01:02 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 20 Mar 2026 03:01:02 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 03:01:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCiVB4HCdbFl3iMxJQrj3H6DWm6bztr0Y/6HPJ/OKt+ey91uO++PjvdNAnG9CPOli45qI09dIfqBFYoC2llrGo6je8RPTqVv56qVTzH/tLmFDI/tkgI4AhL6btRQPm5o4Ssy3xGEftRAEMhnChOic3UM7Auu+0wnjdMK/JNjTg5/1n339jX1jm+V9vQgNkZBCSb8q5BrNXCsiBm/WQs0SAOIQTdCb1zmdrNi7e6chr8aR6lmwWNZNUco+GHbCmGNEPB2R0ZakVSBSNO8VtUrui6Qx5dHWV0b2eViLT9tkvgCjP0hsK3JAe+jbbf1lEo6M/zr2aO16KMKhn1YKrU4cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZWqXlPhlPbgrnLQapIRlLELhDZo5nKm/o21iD5GA8k=;
 b=Dr6JhoOXCeXE2Rd0V5kslEgKFZ0O1LYOztAb++pyFKh7vED7AaYmom32RZXQEfdmnQedKI589H5pErayiDEw/KldoSWCS9xQKeoziKB0oscsHcow7zjsWe/vUxPGKxzsMCxNXgOnX4XZMTJJ0sCX5SH1nXZT6bQlGrHmSLIgSC3UlyiqNaTS7LX0jKEcA2skXWsgduyhmtub8Od6DXuiIfkz+1h0DwQSZB2r74hj508epYK77R3krVTriiePidOAL8aT8J3/TXH4d/bNglOLk3+0Frrx1zjAzm4LncVeAVYjLCR9tnRCUJxMUvyTex2WRPWylXDkOMBUxdNLCyZ2tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SJ0PR11MB6766.namprd11.prod.outlook.com (2603:10b6:a03:47c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Fri, 20 Mar
 2026 10:00:58 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 10:00:58 +0000
Message-ID: <e642e31b-49d5-49c8-af7f-53cd5768e336@intel.com>
Date: Fri, 20 Mar 2026 18:08:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/13] intel_iommu: Handle PASID entry removal for
 pc_inv_dsc request
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-9-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260306034409.184873-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SJ0PR11MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 985b0b6b-fad7-4bcb-c639-08de86679592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|42112799006|366016|3613699012|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: j1W2UFb83qeK7DRia5DtSxU+qfYagNd1XBlSScsGSpTto9eKS8ladLCdbh4ILwDzPDxiaNh0tMSEc9P6u0BzUI6K7B0+V8cEU3LTIxaT5xsfDZGNK2DXXzi5zOltdGF9ex5qm6RbF/w58vAqikg/kXNDIkuBjKYKuSShnvNCGAL3DPKlGmqPfSgBAFJxfE7tvXE5K2vIyCyIll8r/cf4cVopQ1IadUWZ2UOLwX53t4ArNMbCCPH4Z3CFeQq0X8oI6xJed+GJjvqKJk//fFCL4VQ0oVEK1anrYSaK1Fde3zL5rzJgwz4PK/dH/f0ibPU4SNM1WJTEsiK4UXYO1Su4eCajKQE0nrQgxoVUMM2e/PdZjvK0IZWOb8dREebTHdfjPuMieW35iTheBgDTh3ugEHu9VWqBnjo7/P41c0T1yq27Nirp5e3HLwunytXMolBYKZ7qcdLRyAlezLa21A/T0kBwxQj0bvLWrLCODEoZVGv1ZzncM4jQBSVG9SeoT6652+RoMoWIsw/uaqiljkoUoWfhLe7dO74vuDcCP5/mKfVsfH6sbxfbb4C+Iku9gE6/eL8r7Ryq/FkaM/g5soajqZKgmC66nv1PUH6yApB+qpa64zt7UzURk9VL60mabR2FD7/hsgvY6SH9taMiKOk8rrDkmJauSBgPwJcJI6fn/MsBlFtaKahWalCpWEG0J0berlRAXet82uiHyYw60CJfBFIzNVW8ZL5MwnY94IGIYrFU8cQHFGF6/xfR+UYEKiZ5sJWFqNL1lSzyhoYXM/ft83a7W84xF6nNeGRPrZkXNYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(42112799006)(366016)(3613699012)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEM1ZUlwem9UWW5qUXBzb09ndjRHZWl2NUVtMFhSczAzaVVjVzFrMXNiNEg0?=
 =?utf-8?B?VlJscmZzNVBSU0poMVlPUUxUOE5mMG5CbHdSUFNqNlF2b0ZnSGtlb24rS2pB?=
 =?utf-8?B?QzhZWUNwaUtsUHJ5SFBNdHpmUDhSZk1ETXgyRllTKzBBR2hEQVk1WDlpbFRr?=
 =?utf-8?B?ZmRXZGpqUGVJTVM1cmxxSGxDSmxEc1UyM0dPY2h2NWlUQm9lczVmZGhseWp5?=
 =?utf-8?B?Q1NTRHhvV3M5UkVzZlhlenIxZENjZUhHU1RZemxORDJMdTZJbnF0UmNUQ0dE?=
 =?utf-8?B?Mkt3dmFmYkJmVVJyTXo1VzVER21OWnlpdU5jUmhTMVNEYmUwNDFaUXFFZlNl?=
 =?utf-8?B?RDhkcmFkZ2VYUjQzSVp5UmFOMGltdlROeC9jK09VcTZDTkRzQml2b0QyT3JT?=
 =?utf-8?B?amwwQmJGSmh3M1VReTM5RHQyUE4yWTlVR20vSDZtdUZhRTIxYmVNd01Vc2JV?=
 =?utf-8?B?Tld0SkJBTTJtSGxpOEVscTQvNUFNaXQ5QktPYW9sQllITHgycXlDOHpxc0lq?=
 =?utf-8?B?NXIrYnJiVFlLcGh3TmUrdjNoQUdwbHF6MHJwVlpmSDVIcUZ4ZUs2alNzdXh1?=
 =?utf-8?B?RlYzNGdBMS93WCs5ZGpxUmlQbHE5eDR1TlFPMEtWWnZuelBhSG13R0hGbkRw?=
 =?utf-8?B?UG9hVE9JY3Q5Snd4Q28wTUpDUmxDL0hUY0x5Qk5WL0J4MldRamZGOXIxcHBC?=
 =?utf-8?B?UEVRQkordzc4VXVBcUM0eVpseS9zbE9ZbUZmNE1qcDJXYTlWMXVteFdTYzRD?=
 =?utf-8?B?REdYZnFjc3h5eDd2bys3RnhJaXJMbXhTdWs0Vm81TFhOT2FVTHFoYVBhMDdL?=
 =?utf-8?B?cE5ob1p2T2pRQ3NkcElROS9nS2FVVXgzN2xQWHpPbS9XOEhUK2oyb3hqc0o0?=
 =?utf-8?B?cERyMDdabmN1WFNZS0wwWGNCR2Zkc1JGbG1SdlVBRVlJR1MrRkNsOCtnM2Z2?=
 =?utf-8?B?OGRwaWVka0hLRjY3bnJHcFA1cVpRcXZNSjROemJoOFpwYndVNHgxcytiNDQx?=
 =?utf-8?B?U2hqcDBscG9hTDF2SFBBVTJHeVJVRjBnWFR1b0hzZEUyb0h4dFdBcWVjNmZC?=
 =?utf-8?B?dlJTVkp3NlhYUUpma2xJSFAxYmdQTG9vOFZMNUJoVThSZGV6NFd6aDhqcHFW?=
 =?utf-8?B?VjFMa083WWo0K0x0V1k2cWx5VGkyZDE0VVdaWERqV2doamZ5YTlpOWlMeURK?=
 =?utf-8?B?THNHTUp4NVV1ZzF5UGZWczI5NnJmTThTU2wzenpUSzkyekd3Z0o5TkF1ZEJm?=
 =?utf-8?B?S3RDdE55L25VSjR1VjRvclRUaVZ3eFRuTFp3dzRvQ1dvbStqZ0V1dHdxV1RF?=
 =?utf-8?B?NHNORTRmUUhsYnRPYUZZamtkcmR5aHZ3dHdGUkJ2WUlEVGd1dzJUMmdxbUIy?=
 =?utf-8?B?clpDMnkzZzhYM1NCejVhYVNGSWJLbXdEQVZ5L2dBaStWMkVVcHo1TjRwOGxj?=
 =?utf-8?B?YmZQZldBS2dmbGgreGIvL052RDd3aXFoOTNXK2NySWhhaWVhUlhqMmUwY0Zs?=
 =?utf-8?B?bHNZc2Zvek82aGljUFJVLzdCTCtuQTZVOHJ4S2ZXUWJycnlqQnpMVEV2M2xr?=
 =?utf-8?B?THlGWFF1S2t5VmhpZTlKZDNzNFpyWktDRFRUZ2xuNC9SdFRPZ3lEbUxQZU44?=
 =?utf-8?B?MjRkQldsdjB6em41dzIxYkVCd1k4SnB5eVlCMmhwcTlRYTcrVEhZSHFDaTdS?=
 =?utf-8?B?ZHdtWCs2eCtudWtXY1U5WVJnOFFSMG9acks4YzkveURtb0xqZ1dSRjR2eTdH?=
 =?utf-8?B?V0VKU2sybDdjdFl1djBjYW9PbGh2aVB4ZHZjakQwYXdJZ2tLaTlEbDhNT2xY?=
 =?utf-8?B?dDExME1jc1U1Smg4MVVhNUxtV2o5a1cwQUR2YlpnK0YyRW1sTXRlbmR6NEZH?=
 =?utf-8?B?a0ZzNGFid1dKT3dtaWg0aDJJZUVyU2MwaU41WDROYlVLbnE1YjRlaC8xdnVP?=
 =?utf-8?B?ZTNUbzh4SURwTTVhaEhkT09VOTltWnlqZ3NTODNpcDJLQlRWRGtGM2hLQ21X?=
 =?utf-8?B?L0g0M2hjQzlwdFVTN2hZbTRrQzlSdVB5a0lYbWlyZmZYN1FSQ2t2MTV5dHo3?=
 =?utf-8?B?ZHNsK1IwQnhOaHM2TTg4SDFmV2UxMElJZ1RpM3VZN05ybjNrYXB2RTBoRVdk?=
 =?utf-8?B?UDBNanRwOVpVQWNwRkZBQmpFVmJ1V0VNTXBZT3l0aHZObGZUZ3RwVzFVamI4?=
 =?utf-8?B?VXBFeFBJUGVUbXlLcEh3ZWJwaXVrMXROZ214WnF6Ry9pbVlNSzhDOUVDUXZv?=
 =?utf-8?B?aDA4TW5nb0oyOWpZQ1RqaStOaWhRMW9xZjlHNFBkbnNDQkljOFZiWHMxYU1Z?=
 =?utf-8?B?YjhJbWxaS1NoR0RETjVnaWVOb1NSTEVBV2hFTTZDQWcyNCtxdDY0UT09?=
X-Exchange-RoutingPolicyChecked: MfOPCo+bnXpvcDul7KRdsY5vfXnRsCqvFgl3OcUzuGfXnVjdJx57iIAlsxC35NXYWm/spwywLXoLJRIvmuk9Vfyq0WgjuXgqVmtSnX1r8Lz3APnzUDHr0/VV6J26wvUkYmwHqFPkTDfSdXA9T+9w3dS+bEOKqJdb4Uq1SbV3jbTjXIx+Hy1VmTwyFbZQVB1ncdNl36SHDtrDc3Pm11PlDPfvOrNF6H2//aNQgnZrzEf22X0Uqqu01l87kOF43Py7dLuTdv6opUDpjfziBfSX5NvwLI4cmCKU9jLzKL9yrQmtMMKGVer+siF6dBdpq3knCPlp9qMwK2sW9r/vJWWWwA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 985b0b6b-fad7-4bcb-c639-08de86679592
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 10:00:58.4864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiotIPLBmGODz8FkbAoIgan84ZudWf9Yme6aZtUEVdC6RHFdk72Z3Deo6gg43eFB7zVo0/OEBDPrIn4iYNVqeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6766
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

On 3/6/26 11:44, Zhenzhong Duan wrote:
> When guest deletes PASID entries, QEMU will capture the pasid cache
> invalidation request, walk through pasid_cache_list in each passthrough
> device to find stale VTDACCELPASIDCacheEntry and delete them.

As the comment to the last patch, I think this patch should handle both 
update and removal of PASID entry.

> This happen before the PASID entry addition, because a new added entry
> should never be removed.

This is confusing. TBH. this order is not quite important as the current
implementation, we don't have multiple pasid entires share same cache
entry, so a given pasid entry, we either add new cache entry or 
update/delete cache entry. So I would just drop this line.

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_accel.c | 70 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 70 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index 0acf3ae77f..5a956af916 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -16,6 +16,28 @@
>   #include "hw/pci/pci_bus.h"
>   #include "trace.h"
>   
> +static inline int vtd_hiod_get_pe_from_pasid(VTDACCELPASIDCacheEntry *vtd_pce,
> +                                             VTDPASIDEntry *pe)
> +{
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
> +    IntelIOMMUState *s = vtd_hiod->iommu_state;
> +    uint32_t pasid = vtd_pce->pasid;
> +    VTDContextEntry ce;
> +    int ret;
> +
> +    if (!s->dmar_enabled || !s->root_scalable) {
> +        return -VTD_FR_RTADDR_INV_TTM;
> +    }
> +
> +    ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_hiod->bus),
> +                                   vtd_hiod->devfn, &ce);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
> +}
> +
>   bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                             Error **errp)
>   {
> @@ -257,6 +279,52 @@ void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
>                            vtd_flush_host_piotlb_locked, &piotlb_info);
>   }
>   
> +static void vtd_pasid_cache_invalidate_one(VTDACCELPASIDCacheEntry *vtd_pce,
> +                                           VTDPASIDCacheInfo *pc_info)
> +{
> +    VTDPASIDEntry pe;
> +    uint16_t did;
> +
> +    /*
> +     * VTD_INV_DESC_PASIDC_G_DSI and VTD_INV_DESC_PASIDC_G_PASID_SI require
> +     * DID check. If DID doesn't match the value in cache or memory, then
> +     * it's not a pasid entry we want to invalidate.
> +     */
> +    switch (pc_info->type) {
> +    case VTD_INV_DESC_PASIDC_G_PASID_SI:
> +        if (pc_info->pasid != vtd_pce->pasid) {
> +            return;
> +        }
> +        /* Fall through */
> +    case VTD_INV_DESC_PASIDC_G_DSI:
> +        did = VTD_SM_PASID_ENTRY_DID(&vtd_pce->pe);
> +        if (pc_info->did != did) {
> +            return;
> +        }
> +    }
> +
> +    if (vtd_hiod_get_pe_from_pasid(vtd_pce, &pe)) {
> +        /*
> +         * No valid pasid entry in guest memory. e.g. pasid entry was modified
> +         * to be either all-zero or non-present. Either case means existing
> +         * pasid cache should be invalidated.
> +         */
> +        QLIST_REMOVE(vtd_pce, next);
> +        g_free(vtd_pce);

call vtd_accel_update_pc() and vtd_accel_delete_pc() accordingly.

> +    }
> +}
> +
> +/* Delete invalid pasid cache entry from pasid_cache_list */
> +static void vtd_pasid_cache_invalidate(VTDHostIOMMUDevice *vtd_hiod,
> +                                       VTDPASIDCacheInfo *pc_info)
> +{
> +    VTDACCELPASIDCacheEntry *vtd_pce, *next;
> +
> +    QLIST_FOREACH_SAFE(vtd_pce, &vtd_hiod->pasid_cache_list, next, next) {
> +        vtd_pasid_cache_invalidate_one(vtd_pce, pc_info);
> +    }
> +}
> +
>   static void vtd_find_add_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
>                               VTDPASIDEntry *pe)
>   {
> @@ -423,6 +491,8 @@ void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
>                                    TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
>               continue;
>           }
> +
> +        vtd_pasid_cache_invalidate(vtd_hiod, pc_info);
>           vtd_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
>       }
>   }


