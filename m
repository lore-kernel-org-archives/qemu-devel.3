Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EB2CA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 06:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utgww-0007gf-3V; Wed, 03 Sep 2025 02:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1utgwi-0007fK-GZ
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 02:26:16 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1utgwe-00072d-I0
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 02:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756880773; x=1788416773;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xoRyzw73XG7MJRuwst1Ve6KJw/08K3Zs7hes8kBT3ig=;
 b=TiopjeSJVkGuTYkn9+/aMjOqanvEjXSRSemuUIH5GLa3RBFv1+lgXAPP
 WiYun2hUkB9BMR7btKHPJEoa5V6zLQZL6g8XdPtnjN5989zseh8lZF2mM
 fEmTKn4RRbxWG91VzOn4McIiJsQ6dk+QBiu7/3qYQLqfl2Frekfy9z4o9
 2b8F5wmlxFdK2Y7A6flPyRXo66kSp4RvtqJQWyfUb1aFrsw/o6JZCd/Br
 QqLJLEG6K4v2D7fV18YVkhQEenJuLjrLb5vC2wxbIaPm242htxtHMQE+Q
 LL88A6CTlOI3KrepIqG5MjQwig0gksNoEijfJotkm1xNCyBDrROlLDvOO Q==;
X-CSE-ConnectionGUID: SRlN6raDQPCyOxdozUYQGA==
X-CSE-MsgGUID: uf+e9Ns6SrSS8a/YfMJuAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63017389"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="63017389"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 23:24:28 -0700
X-CSE-ConnectionGUID: QcLwJ6I4Rn6Wgsot3EwVCg==
X-CSE-MsgGUID: Hfq7T+fbTGShi5D67GCCIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="171463898"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 23:24:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 23:24:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 2 Sep 2025 23:24:10 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.62)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 2 Sep 2025 23:24:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfYfqL56bEFTZEle0WW3O+MDJykeHt7lSo+6YIRcpUTwI9pg2YPbTAzoC+YLf2hlFvTcS3lxMsQzQ3n8wSGt3cLlEjE27528bWZNZgjfb9Jg82CZeirR5hUT3EkMExweW2S3GxhB6YrSXJdiIdfBpJmnxaJ7anE6Uip97iI5r+97I9Vggi5Zwuytvgmdj2Y1257o2kFTUZ1OpkguQNGVpZVFsB5L579ByHAqsoKpzx+bBKV2rIdt75I3Zus34dwE/4tW7e+P1j3U3MZf0POvzY7Latj/eGuYMg1LAMQQa6NMfRO4zxAH3KYeDLwwb1u1mh+jjbhaSOXLu6/1dhZw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2zTq6t/CFP/qMD3eeKZ+eAez6wZa8eP9zieb5qUA8w=;
 b=rgma6OUWUR3ZyykB1IGs+69rzEN7v3DPnUBvQdZPp6Ml9ctx48UqTuBQu5EgPvhQdPU3cFxtltiqwBwjVCBjYlbiVvK8lCXE12OxlcAJ9m4PBY69m4KQT+EtW4Ro8FFBWKBwQEoAhSARpR+Yz7HFSMx3CYyu/vMtl4FvQFkpLCu8JyMyisUQXBlzs2w8ALQaM2O1UjOvIjUoD0hUB53v81BkUjVFDxvm5KK+KqoJw8R+jqahftld+wSNftRTngasAewjUnb5C+oPi+vZftSulpS7hF9+UzyZW+DBXXFuv+kM09WcqP1i9xNU85tpjpQiwF07+7r7IyQdazGAF32FmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by PH7PR11MB7480.namprd11.prod.outlook.com (2603:10b6:510:268::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 06:24:07 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.021; Wed, 3 Sep 2025
 06:24:07 +0000
Message-ID: <bff21f8a-3051-4c32-bf75-50dc0876a424@intel.com>
Date: Wed, 3 Sep 2025 14:30:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/21] intel_iommu: Introduce two helpers
 vtd_as_from/to_iommu_pasid_locked
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-11-zhenzhong.duan@intel.com>
 <a8e8ed01-8e37-467a-8e95-8afc2f6a16e3@intel.com>
 <IA3PR11MB913629651A0A69304F18FD719207A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB913629651A0A69304F18FD719207A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|PH7PR11MB7480:EE_
X-MS-Office365-Filtering-Correlation-Id: 0acd172e-5684-4430-78a5-08ddeab27c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|42112799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1hxYU4rSE1NbG1rNEZQWUNwS3JWdlJnd0xuU242bW02ZE4vVitvY1NUOHBr?=
 =?utf-8?B?U1hHRG1RSm5oV0JQV3dCWS8zTURRdUx6QjMrc21yYURGY1R1R0M2RWl4RU83?=
 =?utf-8?B?V2QzWHZKVU0wbEpYaWFxSllqMWtjNVhtVlN2QkJnamtVQUhDTUZNZFplSWsy?=
 =?utf-8?B?Z2pkZE9NeTlDaDMybFRLdWs1dU15YzhQVzRJcnFuWHlJSFdQNDhSL1V4ZGZh?=
 =?utf-8?B?a1FuMkZQak5uRDY2Q2pwV3JKdjJxbGxMbFQ0YnNqd1AvaUVZbjBTdzd4SzJS?=
 =?utf-8?B?TkhZWW5iRk1XUmw4ZENqUFArR0tSTzE1cTVvUjRBOUFGcS9yYTJ1c3JBQVMz?=
 =?utf-8?B?aExIUHZOVFBFalVtNjJhd0krNU1PN2t0RmF4ZDdRWlVGWjI2eFcxWXlGZ2hh?=
 =?utf-8?B?WFVnNVhLcXI4RVV1cnlwMUlzVmpTaEFVb1p3aVhTUUs3cU5Ocm0wcXo3Zmo4?=
 =?utf-8?B?eGdaMnU2cFQ3OWFtYU5QcVpjbWNHYXBIeHhQUXJzUVF3QThOR0Jwc2hWVkdR?=
 =?utf-8?B?aWFJekd2dVkvQXVnTnZLN3hiV2RHdHJLNEhCb3hrQWcvSm0yeGlzZlVPQXNS?=
 =?utf-8?B?RURRYkNxR1Jld3VqenBjZXhGcUdZTWZxd3JiZnJpc2hlY3pzTzFjdXNZODdD?=
 =?utf-8?B?M2I5VTVyd3hWbDdCbjRDaXdSM0ZMWlNsQjRpQkVHOTRXUnhWdEgxVEFUbTdt?=
 =?utf-8?B?YzVZYXY3a2tQNzFLcEtseFhDZ1FQVmxWL1d4MnBENW1WbnB1THgzUTlXTTRE?=
 =?utf-8?B?U2Y0UVYyTEhUNUQxR1haNlV2SGNXeUxiT2R0T2tHMklkQk50TW9JWTRDUmdn?=
 =?utf-8?B?L1pTQWxjdGVyT1pUYTZlakMycHFjcUJscjNFRnd3YlRJcGZUeUdYUno0SGR0?=
 =?utf-8?B?VmtXUmxRcEhYVTFDbmt2bFMraVdJU0c1TlV0a1pYZDZwKytnNWNOQ0pEemNZ?=
 =?utf-8?B?NC9Wb3J1YTlHS21BdjkwbW54ZTVHUWw3VUkrYlBMaUhMazJKR01GcXczMWFP?=
 =?utf-8?B?NkdZYk5yV3NablZnb2xsakJ2MkZ4Y2toYnVFNFJBY2dFZHpQRHBsTXcxL2sy?=
 =?utf-8?B?MUhjTlVWc2dKVVkwaFp6YTI3ZU9GcjV1UXBCNXdjOCthQjVkYTNhWjk4aXpa?=
 =?utf-8?B?SzdESGlvbEMrZHFETmdORFIySTJHengzd2w3N3pwaDFUSHM3MTRjbjZPckhX?=
 =?utf-8?B?aGxMTzU3MHBVcWxvL2w4ODc0bFB5empERXZIMkdUT3g3Wi9YRDBMVW5URXhK?=
 =?utf-8?B?eVU5ZVNDcGwrMzdsMGkvNWxlMExmZWowcnhpOXdpMlpTS2NMcUZBK25oS3li?=
 =?utf-8?B?Syt2S3pJNnR3Z3hSKzJuNHlPVzlUY3JjaHVxMTRJWElNZDFqUHBsNmluMGhl?=
 =?utf-8?B?WkpYMVlzbFlKMS9wbnBUQVRWV0NrN0FCeUQ0TlcwMlYxd1h0TFo4Tk4rZDhw?=
 =?utf-8?B?Yy9veEc0MXpBVXpBejdRVXVCQVdlTjB2Q0NGSVVYMkovdVlSMFZNR3FZQlo5?=
 =?utf-8?B?NEdyc0tsTmw1NXhzQVpwejBPUk1BZWZNeW1IemZlNjJ3NnpzbnpUOWxyR2Nk?=
 =?utf-8?B?OGhkL1V4cW53VkhSdCtTeS96czhmVFMybmxZTE83a1kwOURhUmhDU3Vtc20z?=
 =?utf-8?B?RkczZEJYWmZ6ekliWGZlbzgydFpKdDhzbkVOZ1NaYTYzdUZsTUZCa2p2ODA2?=
 =?utf-8?B?QVdFd25waG5ybS9ZL1NWWkhOUzdWMUMzQllNYmMzVE1MYmNQVWFLK1dCOVBT?=
 =?utf-8?B?eFhuc2lOaE9rSW5keHdyN0o1M3NWdkRVclQzeFhtYnBnLzBsWFN5WG96YlZG?=
 =?utf-8?B?UEF6TlRzSDgvYnpIa05peFZvS3ZKRE4wMnJXWElpd3pDU1ErNkk5VTNsTmky?=
 =?utf-8?B?SnNyWEtEbXUwYUxNTmZvQkxmT1p2eU51aTBvY2wxVFFsa0k5NjVZbVVWN1dE?=
 =?utf-8?Q?GquZ7DmOcOA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(42112799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkcwMSsrMDdwV3ZiOHdoNmxya0ZLUXdiM1RvQ0ZCSEpkTlBBTzhqbnBoV1FP?=
 =?utf-8?B?bFdmMFhzOXZ5c0VLOTQ2UjJsY3F4RWVydkcvMGNndE9URVFHTDdSeU03K2RR?=
 =?utf-8?B?LzRRakFpOUh6RHE0dlRCNm9BZEFiaVhSdWR5T2MrS1diNVl2cTRIUzFqN0lQ?=
 =?utf-8?B?cU9hRW1SV0t5N2hqb1ZIZi9WUEdmUGU5bERtRTRvVm0zS3dkQjJiLzRnNzdo?=
 =?utf-8?B?dTViVjlOOWUvYkFEQ3I0enpiSXFlaEprNVh3aXV0dnpheDAyZ2tPU1haOFFE?=
 =?utf-8?B?OHFNZDRINlN3Q1VqVmMxZGJVOXN2Z1YyUlpObllSKzNONWM4ZGtqT251Zzkv?=
 =?utf-8?B?M0JrNng3Wit4a1FsUjBUUXJteHdEYVpLTlJCaFdOcmZqRUwrdHpDWENORTN6?=
 =?utf-8?B?dWRJblU5TDdseGZOc01jc2YxRTVxVGY0eGJtcnNTdURtd2lYTC81NUJiSWF1?=
 =?utf-8?B?MlJ5ZlhHVmdJNFFtMkc3b1lxKzJIYzdNMmhBZmhucTB0bDRiZ01YVTNPR2NU?=
 =?utf-8?B?TlppbEtERE9ueDh2THU4WUttbC94cDVSSWJRNU5JNGJiS3NXQUZMenJaeUFG?=
 =?utf-8?B?SHJYSGdMbDMwak12d0I4MWZxOVFlT1BqLzA1MnNxdlNUODJoTGRlQWZjSWZ2?=
 =?utf-8?B?cmQ1NzBCT2JkQ1R1U0NTQVFERzk1Tm1BRnBqQzI5MTdINTltYWNiNHBUKzkw?=
 =?utf-8?B?eUwwMWt4dUlkL3pSU1IxN1hSd3hTNGIxRVNSTWJWM0VQc1h5VnlIdStRekRv?=
 =?utf-8?B?U05PL09qcWs2Sk81dGgvZnFPb0hsNTkrbnZ5dDRqMk5FVjV2M3NCamZjcHVy?=
 =?utf-8?B?TjRRcGFQZ3l4VWZLSUJYalh1aHM5Zk9CKzlKZVdOWTd1OGlPd2l1V1R0OTFj?=
 =?utf-8?B?MkRFd1R0NUd2MTFZSjJzV3AydXVTQSt6QzUyc3ltVzdIUGcrcndlaWZsQ0tL?=
 =?utf-8?B?MWF3d2dEYzJRVUpPVG5NZC9EYzh2c3VjYzJKbzdHZDNWZmk2eW9UNGR2K1VN?=
 =?utf-8?B?Y2ZNMUZHR2RGQlM4bEhCOXlHNERkOXdhODNHUzQvendCUlBRREQxckxCcDc0?=
 =?utf-8?B?SmFXcDYwSVlJcU8xSURyVUJYbld5aEV4Tis4cWg5ZExBcUk5VVhmMExxTGRD?=
 =?utf-8?B?Yk5wbkJGcFZCa1d6Q3Qrc2tYWHEraXRwSEdwdFVxK2JiZWZWSnJKR3BLdVAz?=
 =?utf-8?B?cWlCTFFvR2tna1Y2MmYzNWlKZjliOCtZVktSc0ZvU1U1SjZRQkZnQWJDZ3pC?=
 =?utf-8?B?U0w0R0k4bnduYWFWWXV4TW1JekQ0Z1FmaEh1b2g5WGg5SUxZakZOclJYVXpP?=
 =?utf-8?B?R1pOM2ZUNWJRNnpXUFVmL29DQXdBeTk2emQ3TmdtYzUrTFdVZkp1QlNYdjVZ?=
 =?utf-8?B?ckZ4ZHZ3akx5aHNtZzlwZ25TTVZxTXFMTUYxZEhuQXgvUC9DOWxmTWlaUlZh?=
 =?utf-8?B?ejFqZUxiS0toZzdXYlAwRnliQWJvK083eTMvZU1oRUowdm9uWkYxQ0ZaaWQw?=
 =?utf-8?B?Q2hYV3FwOVdEZlRhLzhCLzFhMDFiSTkrMHBjZkFad2tFdjgvUGtYQm1VRjNW?=
 =?utf-8?B?SzNhMFRBdlBpQWMwRElkbVp5YWlxNzRRMGJXRmJLTDYwMXpGOWVubXYvVStH?=
 =?utf-8?B?bG9XbG1UVDA2YkUySzFIWllBZlRRZHlOQzJmckYxbkloTlhWaC8yZmo3RUlG?=
 =?utf-8?B?bmNpbUhPMUloNFQ4K1VQYTRBSStoK2pPSVJMaGc3WnBxM0hxbFgxQ0ZibTlR?=
 =?utf-8?B?cG5jMGE4a3I2bEEyN3ZQS042RFVKL3dyUXU1WXc1QlhreGpXeUJkNWROWkd1?=
 =?utf-8?B?aWY0RndCTDVRaUZyMXpyTkFUR0hNYkxEUUFCYzlITHVnemZpeXYrTVliTjlz?=
 =?utf-8?B?RjdNZ2lSOXkrYldsT0tjbzlWVUZoTDlEOHRkRkVSeWMwdU52MXBlNzZSdXpX?=
 =?utf-8?B?L3FZb3Z0Rzg5OXlwVk9BL3lvTXE3OU1xbkRyYko5czZmMkdKYUJiYVM3V2Na?=
 =?utf-8?B?TytjTHBRdkdqVmNuU0dWSHRUa0xsZnlPNG5rSTg5Vk5Zc01sd21mOWxMKzJj?=
 =?utf-8?B?TVpvU3p4K1dDMEloYjBqREh1RVFNaE5lL3gwcWFOdUlwOGEvdGtqK0Q0c0x6?=
 =?utf-8?Q?TqHS02t9AQfHJmmPMHWNKYb7t?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0acd172e-5684-4430-78a5-08ddeab27c93
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 06:24:07.5053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RB89bmJ9GsZYZJiV2vbwdKURqUgb/MbyhL7uSMeMiIBhwVPMHv6OMKd1ihRLURmqX7wBz9bJKkbDiE7eX91Pjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7480
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
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

On 2025/9/1 13:33, Duan, Zhenzhong wrote:

>>> +static int vtd_as_to_iommu_pasid_locked(VTDAddressSpace *vtd_as,
>>> +                                        uint32_t *pasid)
>>> +{
>>> +    VTDContextCacheEntry *cc_entry = &vtd_as->context_cache_entry;
>>> +    IntelIOMMUState *s = vtd_as->iommu_state;
>>> +    uint8_t bus_num = pci_bus_num(vtd_as->bus);
>>> +    uint8_t devfn = vtd_as->devfn;
>>> +    VTDContextEntry ce;
>>> +    int ret;
>>> +
>>> +    /* For Requests-with-PASID, its pasid value is used by vIOMMU
>> directly */
>>> +    if (vtd_as->pasid != PCI_NO_PASID) {
>>> +        *pasid = vtd_as->pasid;
>>> +        return 0;
>>> +    }
>>> +
>>> +    if (cc_entry->context_cache_gen == s->context_cache_gen) {
>>> +        ce = cc_entry->context_entry;

just realized, if you don't record the context_entry in the below
branch, then this flow will always go with the below branch for
passthrough device. is it?

>>> +    } else {
>>> +        ret = vtd_dev_to_context_entry(s, bus_num, devfn, &ce);
>>> +        if (ret) {
>>> +            return ret;
>>> +        }
>>> +    }
>>> +    *pasid = VTD_CE_GET_RID2PASID(&ce);
>>
>> looks like we have quite a few code get rid_pasid from the context
>> entry. I think we may simplify it by using PASID #0 since vIOMMU does
>> not report ECAP.RPS bit at all. It could be done as a separate cleanup.
> 
> Yes, but we already have all code supporting RPS capability though RPS
> isn't enabled in CAP register. In theory we can enable RPS easily by setting
> the bit in CAP register. So I would like to be consistent with this instead of
> dropping all the existing code about RPS cap.

right. The code is almost there. But I haven't seen the possibility to
report RPS==1 to guest. It's somehow aligned that pasid#0 would be used
as rid_pasid. You may have noticed Linux even does not check RPS bit. So
such a guest will ignore RPS. This means this reading rid_pasid from ce
entry is not necessary. This is not urgent task anyhow.


Regards,
Yi Liu

