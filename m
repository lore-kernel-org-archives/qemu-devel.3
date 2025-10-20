Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E4BCCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 07:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAkNk-0008Jm-PK; Mon, 20 Oct 2025 03:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAkNd-0008JJ-Hi
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 03:32:34 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vAkNM-00010v-L6
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 03:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760945536; x=1792481536;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=sjeL8iPwAT4qct9oBCI+hAUvllDRItioqHjoj1yt7Gs=;
 b=nQ7cjrKOt8q7X3sCo+goxN9uQS7RNElAZhxGlw64Ed/+UkcsR8wPf4yq
 O+pyrra+xbjHly6/ndyb6ZFG54jinqxoU+1D5Dj5N0Lcl1XoEH/RDp4Kh
 rhdUWYF6SMgvaOIR1fv2wDnuzRZ4xgP90iLxhk5hZzuRc32OC2G0E/ew8
 UtSPUt8ytqAdxoQ4d0wW890QtYKZENRKxa2+VEzPQ6NPBvSuasUjp9D/J
 QeNgY2VRzC5G2cxY6S4Fy+1/YpGTBM2Zsml6cataSw5Ll8C14gEI79r5G
 lRp+8Jvg2O8PLF7FTKqGYAQx2nPjPo+hAte9mlTOfArmd38+n+opkigeT w==;
X-CSE-ConnectionGUID: 7gjlXiSTTYiwMfSEqILaFg==
X-CSE-MsgGUID: xWuStHTKSG6QPab/muQP/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11587"; a="65674056"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="65674056"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 00:32:11 -0700
X-CSE-ConnectionGUID: 4XnzGJbPRK+w3JrZqom8kg==
X-CSE-MsgGUID: fEoCcLS+SpejqOg/i9aR5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="183215517"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 00:32:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 00:32:10 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 20 Oct 2025 00:32:10 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 20 Oct 2025 00:32:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HwLek0f6E85ih2JNIMIeyw48Hh1/mkFYbbQaIFjFV6G51lWbK7wGASei3Jl9xhd9wIF5tqsVV2W1mEX8HELH+vCPu3wVdZkWZZaFt6HqmT8ts9jdkg3DvyMo3Zb1YMII+tSXjmcSPkz6hjXR6CGjr0+G0P2Qk1IULLqiC7SW/BoaIrXWqmRUD1jC227yJrTgmJPfeoVJqu9XTADndpBwsPnBNPg+hWhisAoNjZRAeTsSTNxtBi3+f93osv4oKI7nvvB6DIZ+pI4mwnYwxzJ+xMOl06CNUPsjzKitCiFvv5AyeMzeGuzLdNULgPB78gMgRtcqvYMvbKDp4LxzmoyRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kL2+C1Le21PQs00X37rFxMCaFG7dDPWFXMHmezTmhAc=;
 b=LSj1lVD65Ifai+UALfbPbOYcPgUqklzz0JjjY27E1LwEnidu+036W6XUX0zjdwElvW/nk6bLBSHrlrEZyPu9Hbeen+vAk6IeXEQ5qoGNsN7kJULke9VPhqlyob/kQxbD/5xGaWfBP2mYOV6/leZiq4KOFdyK9QOHkGxwJO8iiQqLXEonk6QdiHgmMWY7Jh3JFcY/pPMf8xa0kkgp/vxzoGg6ZHIjUWMEMAX/NzM/pxyUN65NqrcNvH935S0RxO6qwXTGPnkPKgfu8T3apMF0INkRPSSE2/7tMw5WoN+K4O1oOiV8eWUacqz1hrg8QtJCAY5XDt4UmK8CsGM/8UCNEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by MN0PR11MB6057.namprd11.prod.outlook.com (2603:10b6:208:375::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 07:32:08 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 07:32:08 +0000
Message-ID: <5cabe9ba-fad4-4f23-9d00-10f775f12f7d@intel.com>
Date: Mon, 20 Oct 2025 15:38:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] intel_iommu: Fix unmap_bitmap failure with legacy
 VFIO backend
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <clement.mathieu--drif@eviden.com>,
 <eric.auger@redhat.com>, <joao.m.martins@oracle.com>, <avihaih@nvidia.com>,
 <xudong.hao@intel.com>, <giovanni.cabiddu@intel.com>, <mark.gross@intel.com>, 
 <arjan.van.de.ven@intel.com>
References: <20251017082234.517827-1-zhenzhong.duan@intel.com>
 <20251017082234.517827-7-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20251017082234.517827-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PUZP153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:301:c2::12) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|MN0PR11MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5c37c6-2bab-4ffa-8ba4-08de0faac689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|376014|42112799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXprN3BRV2dZYjdzNmFIM1NXYmRoNnJxaXY2MENuYVlhWFZJdTR6cC8yWWV0?=
 =?utf-8?B?cjNGM1h6dFUyR2d0YzJkNG1udmtDVlQ2bVZXTTFSNVlhNG1xcGpCSVdiS0FY?=
 =?utf-8?B?eWF2M2l2d1o1Z0xNRXNZdm5MSGEzNUsydERzanF6akdHbXZHbEN0a2hKQ3pX?=
 =?utf-8?B?RTltZVlMaks5VE1SUDR5MHBRVnl2ZnpBRUw5MEFVZnlhU0pVVExFSlIrYjZB?=
 =?utf-8?B?SHdIV2JiSmc4dG9HWWJnM2VDenkzSlhnWk1aZ3FFTC9MYTBHSlFCSUxHNTND?=
 =?utf-8?B?dEIrRU0yQlZ0dk5EcnJ1THFKK0hTMnFZVlVvVzFEdk8wRTIwb0NDS2tlMk40?=
 =?utf-8?B?dkYvWllhZUJqRCtEZE5xallyQ2RidkxVa25WYURGUERxb3RNS0p0RC9iQmRN?=
 =?utf-8?B?K0NseFFhbkxlSzRTMG8zZEdGWGNNc0FjYUlCaW44cFg5dUdWbGxqRDRtSENr?=
 =?utf-8?B?c0trQlVodHEwR0dwL1I4cTd4QzNMSHI0bjNMOTN6RklCR1RhSjVwU2V5NmRX?=
 =?utf-8?B?NzAyNzczUUZDSmdBOWZwK0IwOGUwSG1VVHhESXNncHpzZ2FFTjliOC81THJZ?=
 =?utf-8?B?YXIxNFFrazQzb20vYW40eFJNZXdMM0Q4RlBzQ1ZJOUFRMEpva0ZIdStXOHY4?=
 =?utf-8?B?RW0wZUpCYklrQUU5aGdTbVoyQVdhQnJaMU5nZlpROEE0QnNxRHZtQWVzZTNk?=
 =?utf-8?B?cm1IZDErb0F2aVhIeG1PdkFDa0U4TWxsd3hYNXJKeG9WYnMwVUpaTGNLR2N4?=
 =?utf-8?B?V1l5cUhpYUhzR0JScEdSNXNvdTRnWGhMMkhWNTREMHJNTTlsaEZYS3FFS0tU?=
 =?utf-8?B?dE5pSW0wdkJMVzRTbWMrUmdMbWxJQk5ZZzByc0pOTjFWU2E3aHk0WmNucG90?=
 =?utf-8?B?MDhWZ0wyMDJmWXhoK1ZoWDMxY1R4RFFzZ1JFMitvNUoyc3Q5bVBSSzV6dlow?=
 =?utf-8?B?ektwRjhKNDdUcFVFa3pSbGNOT0xjWlFJOE5DOEZidjVYTkhuTkp6NFFXbnd4?=
 =?utf-8?B?NXQzU043R3dseHpEUnEwQ1NiVW11dk9VN3dMbkdMby9tb0ZVOUwxSStXSXFa?=
 =?utf-8?B?L3pySHlaMElZMFpLZkpqSXR1Z2ViSGF6K2o5RmFjN1lRbkJodWVvR0RwUzV0?=
 =?utf-8?B?c3VRb0t5WXVJSk92MlgybTdUZFc2dzVQTGV3R0xDc09iNzlHdUsxZUdneFh2?=
 =?utf-8?B?dEtnWnBoU3JNbVNwN1NlcWlNbzRWWmRoVHRyNDZKbDhLcllZWGg1N0Y4Q0ht?=
 =?utf-8?B?NWtOd2hjTktucm1xbjYxVjRGWmJRaVh1S3pWNnFPZC85MHFicW8wbFBVZlFk?=
 =?utf-8?B?YzRMZ1lwR28xeTdqekRsaGZqcXVER1MyUzBFZnRIWDc1UlBTRVYwY1kxcm1P?=
 =?utf-8?B?c1pKOFVmZlIwMWFzcThvd3ozYnc1SlQ3YitjOHpZVXBtSHdGb0N3dlhmRjRQ?=
 =?utf-8?B?Y0F1bklOSzJLSTlDNjNnRkxOeEorVTlGM0Z0Nmp3aUZDVzJyMGRPWWl5UXRG?=
 =?utf-8?B?WUhNWk1kVDVWRUc0R3ZZa29uWUMydjBIa3V3Q1B2SEF6YlorWkFCNGNEdEhx?=
 =?utf-8?B?YVRMS2tMSlpTclhHeVFISWZSSXpCRnNUbjZ4R21BYU9TYWFmM3N0a0djbjZn?=
 =?utf-8?B?NnpzMVpiSWIxRG5GWGtBRERYZlYyQWRqR2hWOCtONHplSlJpUFlvY1MvYXJL?=
 =?utf-8?B?KzhGWm4vK3dvSlBjTWRHSUYxM0dwNmJidHhtaU5BYWRZKzhMcm84eFljTllQ?=
 =?utf-8?B?bGhYVFVQQ2VTMTFvdzlRR3VTZFQ2cGs3bnFSUW9EOVhsNm8yRFR0dHg5L2pE?=
 =?utf-8?B?Z0NuRXpuWnhXY25PTk5VeUxXSEpoRU0waEFnRDkyNUV1Q3VURFEvWHlXT1Y2?=
 =?utf-8?B?bkx6R2IwYXhNNW9wbktYYVVVUVZUWCtUTW1LY0N0S3pVOHpaMDJKYlJidzNI?=
 =?utf-8?Q?lYtKKYSwPHK/VlLy4Q26EN80az31g6vv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(42112799006); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elFmNWZGWnErbS9GeFFZQ3pucGloanZwc21pb2FsMHhCdTdTYlN4Qmg3L3k1?=
 =?utf-8?B?VWFlNkUrZXJUWWZtd2xwS3ROb2ZyNkFGK284WCtCYWpvRnNocHU0UWhGK0x6?=
 =?utf-8?B?R0ZBbVBvSVJYTVNCMjBRWG0xbXo2Ykp4L3pnSXkzQzNkbW9wU2JOcHBXVjVE?=
 =?utf-8?B?SDRwYXd3cDF1RzFUcjRLb2pxdXBjS1RoN2dHTW9Ic3laTXVNbVdaQnJQOGt6?=
 =?utf-8?B?R0ZYMm53L0Y0eitQK0lOUThLNm55TjhXQUp5S2tsYnlMaFM0dVM4c055NWV4?=
 =?utf-8?B?MXdCbUowMW93bW02M3pudDNXblhuNHBmUThRME1HTFNnSVFNdnk0dm1Pb09a?=
 =?utf-8?B?eDJqeklmSDlzbWtidFRsQnA4cysvTHNzQUk1cmtBcU1mM1dkSUpjMWJaeHk3?=
 =?utf-8?B?cFovQjJUbkluUUd5WGFWdm55dldWZkxGV2FzOTlnZ1NOeWtlYVdybGZKd1RX?=
 =?utf-8?B?OFZkSUVFeTc4UjBLdExjekh1MS90T3NPT1VXdUIycU1SVUVDeFJqRURzeWhn?=
 =?utf-8?B?Z1JwZzIrV09LWnl1cS8vVU1iaWsyTmRnUW1sL09Wc1Q4aTZGM3U2YXAyUWR2?=
 =?utf-8?B?S2ZUU0xhZnB6b2hnQ2Vsa3FXWUJEVVF0RlBDZklnQWc1Mzd6TitPYnhUUEtQ?=
 =?utf-8?B?Q0RRSTVidU9nSytZMTRRUStWVEpPSTJ2SUdKVGcxanZSaCtLaVpSUUZmVElG?=
 =?utf-8?B?WFhTcFh6a01Bd2h4aTZJZ2lEVUVIb25SdXJLencrRTBqckFRNmtxRFJPTjlX?=
 =?utf-8?B?ZDZ3QmpqTlZEa1pTOTNHZWZmczZIdFBXRzBQZzhBOTNnb0lrN1VwSzV6YWcw?=
 =?utf-8?B?SGI5T2YxY1REWEk5Q2kzNTE0MTRLWUkzak5xT0grcHg1T3lERWxEbS94M0Fx?=
 =?utf-8?B?RXovV3oxRXYybm9YdFBES0FkZXpqdVdjWFlycmFkZnVlRmkvdU1HYkN4VEc2?=
 =?utf-8?B?VjhScDh5Z0V5b2xzZ1gyajdhVU5uWGp2UkdKZjNYaDNhVnVpK1RvV3NxS2x2?=
 =?utf-8?B?VFlwN1o3ZnV4TVgycW5YYnZhYlB5UVFlTjY5R1hhWE5nN0dSWG8vM2lvOW1X?=
 =?utf-8?B?cXNJSmZkN3p3SmZCeWxQTTZPUXEweERRNmFUNC9nQjVLMzhhaXc5bnN6Wk16?=
 =?utf-8?B?VDNSSXpVT3VlWkVZdlg2ZHkvY1FkR0YvSmk0RS9MZ29PQzBxQzJqQW02VSs4?=
 =?utf-8?B?bXptNFIrY3dPanJWditaWUc0RGp0d0N2enowbWcrQlBnay8rMU5nWFIvUHRC?=
 =?utf-8?B?SHpYTjJibXVVdXZKN0NkRzNMRFVaRk9VUWg2YkRWMDBoeStQK0xPNWtHNjFD?=
 =?utf-8?B?L1B6UHNvdnRpYmthSlJpc200ZW55eSsyMFVhNkxXd203a2MzRUZ6NHQwWjdR?=
 =?utf-8?B?WTV3UGZxRGNSVzZCOWphUUV1M1l6YWJQU0Nqa29UYjdrclRqcjZzK0tXRDNI?=
 =?utf-8?B?MDVJbmdINUk3YzJBbGZXdEZkVTRrQ3hiRGRvNjgxTnFJdGI1dTZhN1lXTkxp?=
 =?utf-8?B?bFdpeTE4aWRzL3ZpTDR6Wk5xYzB2QlpaV0YzWVRCa1RLQTRPM0VmTTZDZ3VJ?=
 =?utf-8?B?MTRKd2hJeEEvUmhJWDhYdVcxcmVzREdmaW80ZXI2QXVzT241VG1ndkNDM2Z4?=
 =?utf-8?B?MzlmR29XY3d2cFlWcXp0alI1R0phem42SEV1TXVaaUpuODlOZUpjVUVTQW4z?=
 =?utf-8?B?WVdQOEtwN3pJcUJnbzlrNzhoUUNyb28veWZmQlF5L1IwNUZlaDJqWDEzQmJW?=
 =?utf-8?B?WTcwZEtmRjdZYkQ2ZWNkblBWS21HOWZ0ZGJ6a3pnUUhxMi9vcGkraFR5U1JS?=
 =?utf-8?B?emtzdGJPeitkZmt0REhrR21ScnJIY2RkNVdVZXBmaHhvbUVVMUpFNjVLVXZ6?=
 =?utf-8?B?ODRRZ2pjTjh3dG5aVzVKbTEyTms5cEtVZXlpZ0xtSnNEYXh1SjFVakF3SzBj?=
 =?utf-8?B?NzVNVStLUnpHa2w3aFU0L0dSQzBPWmltQkJjSjMvdFhoNG0zVkNJMWpGS0hw?=
 =?utf-8?B?ZElkWVBCOFZyTXJyNjRIRnJTUEk3bzJzVmkvRXRSNnRudTIrZ1lCT2tLNzJG?=
 =?utf-8?B?a0wrc3JtLzM2a1VmRllZbnhWRFhEeGc4cTZ1QVgrcW5mdkFyMHpMMU82KzQw?=
 =?utf-8?Q?HVwlApspKFYsItUAQfmF8FZn9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5c37c6-2bab-4ffa-8ba4-08de0faac689
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 07:32:08.5562 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcVV5SVTpHiahztfEzBKuR18mCRmw8Dl/84paaO59YX7RjZbobZsTizNl5UpeWgUO3EFt3Zw7u35l/BW3szF9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6057
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yi.l.liu@intel.com;
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

On 2025/10/17 16:22, Zhenzhong Duan wrote:
> If a VFIO device in guest switches from IOMMU domain to block domain,
> vtd_address_space_unmap() is called to unmap whole address space.
> 
> If that happens during migration, migration fails with legacy VFIO
> backend as below:
> 
> Status: failed (vfio_container_dma_unmap(0x561bbbd92d90, 0x100000000000, 0x100000000000) = -7 (Argument list too long))
> 
> Because legacy VFIO limits maximum bitmap size to 256MB which maps to 8TB on
> 4K page system, when 16TB sized UNMAP notification is sent, unmap_bitmap
> ioctl fails.

It would be great to add some words to note why vIOMMU can trigger this.

> Fix it by iterating over DMAMap list to unmap each range with active mapping
> when migration is active. If migration is not active, unmapping the whole
> address space in one go is optimal.
> 
> There is no such limitation with iommufd backend, but it's still not optimal
> to allocate large bitmap, e.g., there may be large hole between IOVA ranges,
> allocating large bitmap and dirty tracking on the hole is time consuming and
> useless work.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
> ---
>   hw/i386/intel_iommu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)

with above comment, the patch LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 6a168d5107..f32d4f5a15 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -37,6 +37,7 @@
>   #include "system/system.h"
>   #include "hw/i386/apic_internal.h"
>   #include "kvm/kvm_i386.h"
> +#include "migration/misc.h"
>   #include "migration/vmstate.h"
>   #include "trace.h"
>   
> @@ -4533,6 +4534,42 @@ static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
>       vtd_iommu_unlock(s);
>   }
>   
> +/*
> + * Unmapping a large range in one go is not optimal during migration because
> + * a large dirty bitmap needs to be allocated while there may be only small
> + * mappings, iterate over DMAMap list to unmap each range with active mapping.
> + */
> +static void vtd_address_space_unmap_in_migration(VTDAddressSpace *as,
> +                                                 IOMMUNotifier *n)
> +{
> +    const DMAMap *map;
> +    const DMAMap target = {
> +        .iova = n->start,
> +        .size = n->end,
> +    };
> +    IOVATree *tree = as->iova_tree;
> +
> +    /*
> +     * DMAMap is created during IOMMU page table sync, it's either 4KB or huge
> +     * page size and always a power of 2 in size. So the range of DMAMap could
> +     * be used for UNMAP notification directly.
> +     */
> +    while ((map = iova_tree_find(tree, &target))) {
> +        IOMMUTLBEvent event;
> +
> +        event.type = IOMMU_NOTIFIER_UNMAP;
> +        event.entry.iova = map->iova;
> +        event.entry.addr_mask = map->size;
> +        event.entry.target_as = &address_space_memory;
> +        event.entry.perm = IOMMU_NONE;
> +        /* This field is meaningless for unmap */
> +        event.entry.translated_addr = 0;
> +        memory_region_notify_iommu_one(n, &event);
> +
> +        iova_tree_remove(tree, *map);
> +    }
> +}
> +
>   /* Unmap the whole range in the notifier's scope. */
>   static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>   {
> @@ -4542,6 +4579,11 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>       IntelIOMMUState *s = as->iommu_state;
>       DMAMap map;
>   
> +    if (migration_is_running()) {
> +        vtd_address_space_unmap_in_migration(as, n);
> +        return;
> +    }
> +
>       /*
>        * Note: all the codes in this function has a assumption that IOVA
>        * bits are no more than VTD_MGAW bits (which is restricted by

