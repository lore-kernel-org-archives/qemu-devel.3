Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF843CCD187
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 12:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7v3U-0001t0-Fo; Sun, 12 Oct 2025 08:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7v3R-0001sk-Ta
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 08:20:02 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v7v3I-0001NQ-Vx
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 08:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760271593; x=1791807593;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fse/rzeWC3qoCe/PuoK28s7Jid3golfrAnyQMvZqFdA=;
 b=hCZL8muQmaMbjw56xEq4R4x5XgNQrUY/s/QbxBY7HVKdowYBKO5PBhwk
 vW2gj9sIiVCq2SIDmT4zDnqoqll+1u58qxHUb03//LxsmIkXss8xKvEhO
 Roa9s61xCuhV0ovgV6zztOZ/OdxWBydsunXiT+LR25Bb+AMohSzIyqYeR
 ee2yeJ5eNPBhCE+h/XY50EJLlG+HhC9etCAXC1MBpYD+Ebl9Su7oUHmFO
 BdJwj79PZcn0shLHl6quo6rUrkDdvaDTaoUBZVeQyfhzyjkiCOJKAYf7f
 jKc+dh+POWRnoIQZQgRRxs4yIyh20KpMBxftO7mNJGd0hssHjWlhUDZcs w==;
X-CSE-ConnectionGUID: FeG/mWg6R0uT1Eha/anC4Q==
X-CSE-MsgGUID: r+GAWWltQZ+nyxHF0CZe2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="62461791"
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="62461791"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 05:19:47 -0700
X-CSE-ConnectionGUID: QulZt84yTbuKzACPy0REvA==
X-CSE-MsgGUID: tBzjJzTvQh6zQQ3DxLFrog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,223,1754982000"; d="scan'208";a="212331843"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2025 05:19:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 05:19:46 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Sun, 12 Oct 2025 05:19:46 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Sun, 12 Oct 2025 05:19:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7/avjeBXYm5A20j++vD1Wa+wbmU9TOIk3lP012Id7HuiZC5bwN0f7lJlTLy/+AecaSOPq2WSQVtFsBOL1ledINAICyD7Mq96Edmv1ceIpgWfT7p42SfjbMnGWLl/NMPOPEFO38VfX2yMtHv/XPnoAiqlV1MMQ8Qeh7/60Y2wXr4GROjy4fNqMpnRkiBxBHTBt1o/x56oRk3ZNGvXtkyIko9RmF0bbKVflcFSsUwYj82AF55f5tkq5pBZQRiTbpWUVhLzKU6PgmDJe9ONfpOaFCXVc6xxkxdukyiSE+KFWAdXbueUmkzas2ztTeP21Pvm6mn6T3o7L8Yg+huym7xLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kk4HLtRT2xoR6h+teg68fwa8x/XU0nLWwB4E7Av88GE=;
 b=Y0ooAZVaecx9LoZc96L8+K3bXMy6wFUATeBt4SMtUKuKnW/SqosxRVGHA7CLkINvguz6EAYYInlnOc7sksY7fVSt/0kRYatxQtpoXUQtY2IHsTiKvMbBVHzCdTlH8J2rMwMw4ib9XudXqrgdmB2cnDCpcksdl4qfQj3yj+tQvIHTjPo31lvcR0oEd3WbcAqM70MDMiXdGnobFJIGyv+rGld7Yqd33B7jx2yLIS4WwEv0aicJm/YrqY6i3pBKBpJxkP2M8rNOPUGfSY6skKtTApqOHx7BfPF5/m6xltAgBDjISpSKjRYYse9auxqmx8h074Tos7msdL6CuL00gzDgLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by BL1PR11MB6027.namprd11.prod.outlook.com (2603:10b6:208:392::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Sun, 12 Oct
 2025 12:19:43 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9203.009; Sun, 12 Oct 2025
 12:19:43 +0000
Message-ID: <9e48f6fd-a945-4a40-9ec0-e852280108c9@intel.com>
Date: Sun, 12 Oct 2025 20:26:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/22] hw/pci: Introduce pci_device_get_viommu_flags()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-6-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250918085803.796942-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0095.jpnprd01.prod.outlook.com
 (2603:1096:405:3::35) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|BL1PR11MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a7ae03-67c8-481a-1051-08de0989a008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|7416014|376014|366016|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dk5vaXBKdklPMVVZd1E5RFFZN1NXWFZqRlQ1RXBKS3h2OUxrMEZ5NmZLSWJ3?=
 =?utf-8?B?NDlrY0MyY2tPcWNYTWdKbk4yKzI0eGFYWjFXK0pRa2FyN2pHYVVyWDN3Mitx?=
 =?utf-8?B?bVpaREEvc3FXdEt5SUh1YW5kVXorck56RlNXM2g2MlFSTTI2WlBNMkdKaDhj?=
 =?utf-8?B?QUp2WUdiRTZuU3dPMzNXTlhsSjB3SDdqckIva1RaOXpxVytPTG1oSHdJT2RF?=
 =?utf-8?B?SlNjeW9IMENBWFc1L3dRSnRLbERRNXNPMDNySGNnWVBhZFovSjFFSFpLZzRU?=
 =?utf-8?B?VlVicWFHdU80UjFlei84a0ZWV0tWSmtkVEI2ZVd3Qk5XQ2JzQS92VFpkakFw?=
 =?utf-8?B?M3dLS3N3cU5TSHVJRFE4S0l4bm5aYVkvNi90VCtZOUhlbWgrZHpGcTJYL0dr?=
 =?utf-8?B?NFNHQlpNcW9ZMUxabTIvcnlkS0FNUFN6WDh2VUE0M2VYaDIxQjVsbG4yV1FF?=
 =?utf-8?B?KzR1WTJCZE14K2pJUnNoeFF3UGdoOG0yRngrY2E3VmhPQzd4SG5kcmtOaThW?=
 =?utf-8?B?cDJuWXdpMkpPem1JTHZndXFHRGlDTVFDcTE5eVlYSGhoaHgzRmY3bkgvZEhT?=
 =?utf-8?B?WWt6alFhVEJpc01lUEZoZDNMcS90RmN6dDBpNytQTWU0cFp2YWJESzFrajlz?=
 =?utf-8?B?SUkrM2FpV0tscEhDSGFlZmtYTWNTTmxwVXVQczc1Z1BKUjkraVNUVVp2emtF?=
 =?utf-8?B?VnovUGRUMHBEOEpmeCtHYUZHdTZOQlVMQi9iRmkxcUtScXV6dmU3WXJ6TmZV?=
 =?utf-8?B?QkVndTRHK1Jza2FiN1pMYnJXS214U3lhazVCRlFGVXNvWXNBTFA1aEI2Y0Fy?=
 =?utf-8?B?SDBSQWgwSjdMYXhuRFV0eHA3TkwrN2ZRSkFlVjN2ZUNLUndGSURLSzVQYi9z?=
 =?utf-8?B?aUFhbG1vRnFMbmRNQ0NabHRaMFl5Z2VnS2VkMVpBSEtZNnQrbVg4YUU3YTdK?=
 =?utf-8?B?WmJlMW1BL3l6Q1YxUEc1aFl0S2lZa0RLekVUdDlGUmxsSVl6SDV1NGwya2cz?=
 =?utf-8?B?cG85M2RueVIydmlxUCt4c2RiRHFjQ3BiRTJwNUdEQnUwZWE5TXBHSVczQUkz?=
 =?utf-8?B?WXNsWlZ3OXhiRnBLQitCRjFZL3k2SG1nQW1BeVpXdU9qZTBTa1Q1UDJsOWU4?=
 =?utf-8?B?MWpteDM4cllqM0x5Y1VJdE8yOERQODUyVFU5OU5oRndRRWV1VXhEQWZ6UnB1?=
 =?utf-8?B?dnlLdnZuYmd4RGsxWUNvbzUvMVgxV2NoNkpoTUxtTlhtL0tYZ2NNWkNHampi?=
 =?utf-8?B?NW9pTm5qWVJaNFJLVENLS3ZUdWtBNE5VZm01UStZcFdJQmdRN0ptL1g3M1Rn?=
 =?utf-8?B?ZmtzNTg2OUJjNmh3R1k3SXJ6bDBxMVhhOU43UkoxV1Z4YUQ4eGd0NFl2TURv?=
 =?utf-8?B?VkdLdTkrNDdUdDVtNkx2UU54QytSQWc1Tk51Q2FWQkg4QjlLbE1mYVMveHlu?=
 =?utf-8?B?NWUvZ2tJdDNUa0Jla3V3SDZ0Z1NudnRLczhoeXZRamdKMnpNTnp2Vnh2OGJ4?=
 =?utf-8?B?bXN4NkxGV0cyYWs5SGFqZnZ3Sm5pdG5uV29oYTVXL3RhWWFwWms4SUtnQTFS?=
 =?utf-8?B?NkdJNFp2VmF4cnRHWkd4ZFVoMkNvQmdpZWxTN3ljS21oVnFDOW5TSmFaZHVZ?=
 =?utf-8?B?QnBsMTZkV3hkNENyckNIN0xGSDRaemdmTTgrdHJUeGR3bTg1cDdicFlRQlov?=
 =?utf-8?B?cFBOSGk0WGt5blplaytlWlVBcksrZlpKd1dzcGpRNnQ1M3diajBBS1FRRmF3?=
 =?utf-8?B?NVJ1akdYQ0oxZ0dsR0Y4MTUrN1dwM0RWdVFSdkxHUXh2MVp3bHByQ29YeUZu?=
 =?utf-8?B?RTRGZUdwZ0crenJmcWVMN2pobGc2RzMrNFNTRVJsSjRJNysvaWFkQytuMkNK?=
 =?utf-8?B?dEJwR0RpczEyTUlCMWNaTldGQmZZQTNuYkFickFOWTJTTUpBVFJOWHdFckNX?=
 =?utf-8?Q?FHoHrHxrm4ussd4qZjGF2waCu+XkjTsj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(7416014)(376014)(366016)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGpscEp4QUQwUDR2dmkvYlJZdTFUQTdyMFNWS2Y3WXBSU25jOVQ5U2FTa3ZN?=
 =?utf-8?B?bG1vR05yY2k0eDFxY2Q0MFpqN0h3a0Rrd1B4SUdKR01xNllqYmEvVU9KRXQ2?=
 =?utf-8?B?Y3FsUlpDY2tTMDRPZVMvQzhJTnJsa3gwZkhWVStXSEE2Z284SXN1enlwZmhU?=
 =?utf-8?B?aGRqYmZtcFBjbEJVRVRaNkVSZUlLbFZaQnhkSnFFQ2RQUlVscElSbmlTaUNK?=
 =?utf-8?B?bXA1d2g0SVRzUnhDZCtwbGVBSGRiV0VFVUU3eTRzc3lPc1ZjbnBPdXU3aHIw?=
 =?utf-8?B?eSt3c3hVaVV0RDFiaHp4aUZpUDUxTWNDQlZ3M0pFS3ZaNm9KWC9HL0dRZUVv?=
 =?utf-8?B?NnNZSU9Xa09YK0N2WklCNWtvM2RnQWY4MWFSUmg3bEZ1QTJmZjlySElWYUFn?=
 =?utf-8?B?UFVoRHYwNC8vT1FpeGIvcTdyT0lJS2VBUkU2V0l2S1Fxdlc0bHJIV2tXQkNi?=
 =?utf-8?B?Wk9tdkY0dllBdjFsSG9VOGYzOW9vU2Y0d1c4VkhpVTB5UGRpMUc0bzhrM3RX?=
 =?utf-8?B?QkJIRy9rb0IwRkd4bFlkUytMSmpWdm8rdXZyQVFwc2lCT04wYi9mcjFvblBU?=
 =?utf-8?B?UVFtV3BTVTY1c3RNZ3VETVRuQ0hLVi80MHFvV1R6M1BSc1g2eDAreGhqMDEx?=
 =?utf-8?B?UDM2SHB0akpFdmNKN2hjVDZEWGFMdUlwZVlPSURTaGxHM0Nubjh1Uzl5dVkx?=
 =?utf-8?B?TTRWRkVvdHk0alNUVlRNUzhiSVBLWGtpdm8xZitSd3Fib2pYREh2cFg4MWNy?=
 =?utf-8?B?Z2RBTytQZGJaa2VEQ0xPWXNyUS9xUXYrRnl2QmkxQVBCZG9GSlEwUk1QTFo3?=
 =?utf-8?B?VzIxc1FuRmFKQnYrbUNSM3oySThlQkNHcHcxdCtzL3lnZWo1OC9KcVVLRmhS?=
 =?utf-8?B?ZGJ1Ym9KcFlVei9mY2g1WGpwYUpmZXVHM0FrRHRCY2RWQkhnaVdpdWlTVll3?=
 =?utf-8?B?eGhHdTJ1UmJGRTVqNXRhaGo0YmdIQ0w3bWV6QmdLN2oxNVN1NW9KTDczVC9D?=
 =?utf-8?B?eVFIMWFPNEwzYi8wUWxtZWZiYlNkVERDei9ySU50TXpsRUx1NGdXOE8vYVdF?=
 =?utf-8?B?QkFtbGZIQU5XVUdLR1Z2QkFPVHpOQzZVRkpGeUZHZmtrbkJnTVoxcXgzZHhh?=
 =?utf-8?B?OXMwem9WdVprVW1JLzRHbGZzdGlFMTdwZzlleEtOWWxYcksvYWRVc3k1UUdX?=
 =?utf-8?B?YWhOM3QxcUliblBPSE5wWDh4bEFlTlNUazkyY3IzNlBnOTNZSEVsWldqZHRS?=
 =?utf-8?B?V21Pc3JIczNPZzJwbXMzcmdNTHFaeko0cWVyOEs4WmoxaWl3UlFFQzhXODBm?=
 =?utf-8?B?VDJoTzdHNXd0Y2JiZHpFYitGdnFkKzNXOEFubjRHaTlRWExBSXQ2VjhMeThx?=
 =?utf-8?B?YXo0OFVnd29wN3FnUFBQOFJNWXd2SVlWUFQyZUdVQk1hWktOMVJSNTI3VExY?=
 =?utf-8?B?czFyMXdMK3JvaGN0ZmJ6clRqYjlseFNlM3pFL0hLU3UvTTZvR1F2VHBrNnBP?=
 =?utf-8?B?QWVvbVNoRGZDUHczNlV1R3dFOExrTTBXeFlVWTQ0dkZvMFBRRnYwU21xTVpu?=
 =?utf-8?B?UkZUTllOZlFKeW1wK3JEcHNUTHVuekpLYUprRDNnNjNSWU1uSUpPK1psZXhV?=
 =?utf-8?B?eWF3YkdkVkRUa3BxMHl1YzR1OEExTVhaMU1TaFlUMkhUd3JWMFQycmlvRllO?=
 =?utf-8?B?dU1vTkJndndQUEFZQU1Kb0kwVzh6NEIzMFVWMWFjWDFnYUZwc0tYekZzZytn?=
 =?utf-8?B?Y0tKMUFXZDdQRGw2cVdhbGtKMEpBU1VidEEwTWlqN1pWT3NSVk42Vkl4cHRB?=
 =?utf-8?B?Z3ZDa0d0Y1pmWmhYV0ZTMkVETGNHVmZmS2orRTVyRXR0Z0s2aHEyZWpjcEUz?=
 =?utf-8?B?eFVQWDlMZnpLeC9sbWdFY29XNlN5Sy83REN1Uk9EaXZOVno4ejA3NWRJNjZ5?=
 =?utf-8?B?eFpMdzR5eEttamNqUStiV1RvVndZOGZ6bUpZZE94YnV3OXVjNUVkM0VOS1cr?=
 =?utf-8?B?a1FpNWtTcjQySnE5TUZPZG1ueDdScmg2T0ZMT2dBcm11Zkl0OFc0b2VlTFNv?=
 =?utf-8?B?K1VVUDEvTzlJU0p0d1pETk53bkgvbThKenBNRlVKSEllRFh5QUVxMUgxcnM4?=
 =?utf-8?Q?OrySgGkG7ZbAFSs0RpJOXbe3j?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a7ae03-67c8-481a-1051-08de0989a008
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2025 12:19:43.5761 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kMLvotnY9J/v5U1TCtxpgy2eg5cuAfC7fwD1U6/FRldEYam5FOW5AHM5s0cAAPqeBRv7TuwoJJV5ptnrcWj8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6027
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14; envelope-from=yi.l.liu@intel.com;
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

On 2025/9/18 16:57, Zhenzhong Duan wrote:
> Introduce a new PCIIOMMUOps optional callback, get_viommu_flags() which
> allows to retrieve flags exposed by a vIOMMU. The first planned vIOMMU
> device flag is VIOMMU_FLAG_WANT_NESTING_PARENT that advertises the
> support of HW nested stage translation scheme and wants other sub-system
> like VFIO's cooperation to create nesting parent HWPT.
> 
> pci_device_get_viommu_flags() is a wrapper that can be called on a PCI
> device potentially protected by a vIOMMU.
> 
> get_viommu_flags() is designed to return 64bit bitmap of purely vIOMMU
> flags which are only determined by user's configuration, no host
> capabilities involved. Reasons are:
> 
> 1. host may has heterogeneous IOMMUs, each with different capabilities
> 2. this is migration friendly, return value is consistent between source
>     and target.
> 3. host IOMMU capabilities are passed to vIOMMU through set_iommu_device()
>     interface which have to be after attach_device(), when get_viommu_flags()
>     is called in attach_device(), there is no way for vIOMMU to get host
>     IOMMU capabilities yet, so only pure vIOMMU flags can be returned.
>     See below sequence:
> 
>       vfio_device_attach():
>           iommufd_cdev_attach():
>               pci_device_get_viommu_flags() for HW nesting cap
>               create a nesting parent HWPT
>               attach device to the HWPT
>               vfio_device_hiod_create_and_realize() creating hiod
>       ...
>       pci_device_set_iommu_device(hiod)
> 
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   MAINTAINERS          |  1 +
>   include/hw/iommu.h   | 19 +++++++++++++++++++
>   include/hw/pci/pci.h | 27 +++++++++++++++++++++++++++
>   hw/pci/pci.c         | 11 +++++++++++
>   4 files changed, 58 insertions(+)
>   create mode 100644 include/hw/iommu.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f8cd513d8b..71457e4cde 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2307,6 +2307,7 @@ F: include/system/iommufd.h
>   F: backends/host_iommu_device.c
>   F: include/system/host_iommu_device.h
>   F: include/qemu/chardev_open.h
> +F: include/hw/iommu.h
>   F: util/chardev_open.c
>   F: docs/devel/vfio-iommufd.rst
>   
> diff --git a/include/hw/iommu.h b/include/hw/iommu.h
> new file mode 100644
> index 0000000000..65d652950a
> --- /dev/null
> +++ b/include/hw/iommu.h
> @@ -0,0 +1,19 @@
> +/*
> + * General vIOMMU flags
> + *
> + * Copyright (C) 2025 Intel Corporation.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_IOMMU_H
> +#define HW_IOMMU_H
> +
> +#include "qemu/bitops.h"
> +
> +enum {
> +    /* Nesting parent HWPT will be reused by vIOMMU to create nested HWPT */

vIOMMU needs nesting parent HWPT to create nested HWPT

> +     VIOMMU_FLAG_WANT_NESTING_PARENT = BIT_ULL(0),
> +};
> +
> +#endif /* HW_IOMMU_H */
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index bde9dca8e2..c54f2b53ae 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -462,6 +462,23 @@ typedef struct PCIIOMMUOps {
>        * @devfn: device and function number of the PCI device.
>        */
>       void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
> +    /**
> +     * @get_viommu_flags: get vIOMMU flags
> +     *
> +     * Optional callback, if not implemented, then vIOMMU doesn't support
> +     * exposing flags to other sub-system, e.g., VFIO. Each flag can be
> +     * an expectation or request to other sub-system or just a pure vIOMMU
> +     * capability. vIOMMU can choose which flags to expose.
> +     *
> +     * @opaque: the data passed to pci_setup_iommu().
> +     *
> +     * Returns: 64bit bitmap with each bit represents a flag that vIOMMU
> +     * wants to expose. See VIOMMU_FLAG_* in include/hw/iommu.h for all
> +     * possible flags currently used. These flags are theoretical which
> +     * are only determined by vIOMMU device properties and independent on
> +     * the actual host capabilities they may depend on.
> +     */
> +    uint64_t (*get_viommu_flags)(void *opaque);
>       /**
>        * @get_iotlb_info: get properties required to initialize a device IOTLB.
>        *
> @@ -644,6 +661,16 @@ bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
>                                    Error **errp);
>   void pci_device_unset_iommu_device(PCIDevice *dev);
>   
> +/**
> + * pci_device_get_viommu_flags: get vIOMMU flags.
> + *
> + * Returns a 64bit bitmap with each bit represents a vIOMMU exposed
> + * flags, 0 if vIOMMU doesn't support that.
> + *
> + * @dev: PCI device pointer.
> + */
> +uint64_t pci_device_get_viommu_flags(PCIDevice *dev);
> +
>   /**
>    * pci_iommu_get_iotlb_info: get properties required to initialize a
>    * device IOTLB.
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 4d4b9dda4d..1315ef13ea 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -3012,6 +3012,17 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
>       }
>   }
>   
> +uint64_t pci_device_get_viommu_flags(PCIDevice *dev)
> +{
> +    PCIBus *iommu_bus;
> +
> +    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, NULL, NULL);
> +    if (iommu_bus && iommu_bus->iommu_ops->get_viommu_flags) {
> +        return iommu_bus->iommu_ops->get_viommu_flags(iommu_bus->iommu_opaque);
> +    }
> +    return 0;
> +}
> +
>   int pci_pri_request_page(PCIDevice *dev, uint32_t pasid, bool priv_req,
>                            bool exec_req, hwaddr addr, bool lpig,
>                            uint16_t prgi, bool is_read, bool is_write)

The patch LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

