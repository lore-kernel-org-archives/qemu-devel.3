Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE8CD10C0E
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 14:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7bPg-0005XO-M0; Sun, 03 Nov 2024 09:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7bPe-0005XF-VR
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 09:17:06 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7bPb-0008Hp-EZ
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 09:17:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730643424; x=1762179424;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kEuTeikvPOm/IWuoQrUaLu3Lgts40LWFbHU/4y28WE0=;
 b=UXHotPlrNBhojqXckgVa8JELf6vJvPEDYuD9aFAts6exXCMxmg3VJEtk
 qE2+DNYoBLE8jnvFKHrlpwHam3MY6LHE+7/Ooox9jTdYu3qfWzCYQV7vT
 XDj543UflFIV6lW964LhYL23AZfFsnjR7CMmYZDrlruUgfG4r0JKP+s+v
 1DID6OzLz4X7pT2h+uoTPpzKITOtzUY3+AF3kNSYcrxF62JNesgCWh2Yx
 xvlyQopHwlYNvJzDzpUdfEtFtcRE6ckJ8TBNt1bEjLvB81KD0tk1mOBVt
 NKnLGjIoXMjT6nc9AXjDExNJ45efVsjJa8EeqT2a9Zeor1Z5Vm0vbC2Tt Q==;
X-CSE-ConnectionGUID: fVP9YpPcQOC0CUXuO8g0Iw==
X-CSE-MsgGUID: pUwBtEc5S66Zt9IISkTQ0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30298312"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30298312"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 06:17:00 -0800
X-CSE-ConnectionGUID: OanJ3SzIQ/Gi+nqjFLCvsA==
X-CSE-MsgGUID: U2lQpOTpQ56cxjbuOIF1Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,255,1725346800"; d="scan'208";a="87928147"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 06:16:58 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 06:16:58 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 06:16:58 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 06:16:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTQ+Mr7Wmr58GwdKKoeIs9MlE+AN2Jz7Mt4VaXXlhEfsilq4TmbyzYGMhbN8f9tJLr0zET4fAUSwc+/dhHqDmxMPh5vCmQDTIxT+PfwUB4/XCRBxFTqcj2WT4ltL20X3Lh124+wRDHUI+MZQgHz/Ls6A4GXg9G1DlDZDRBTY1kZUzOpHMr/QkBE0kad5ePpsQ2Gcu4ooccK6ke/oIg/JToftT5lBE+a5LBZnsUNxhFYw4BJFbmTp5+dwB3cB+DLTrqAM4Vqf6jAdf+W/SXfpRtD0+xh26nxA1a8DB+oZcuh4KNO/r4llT/EPsitVZw2yvUBWlOtKTZ4j4nLhKYUC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qvm+BeERqWKJ6BUvfLw0A5QBBE9yK/f1+kg2TR1dlfU=;
 b=ka5gqpAF1a6K3ndVIQZGUpqKMqGesOye+8RZbxFlBNIarhD6PiP1gPKLPcQHx4Yp4Pqscr976otIxtaOElE7irvpfIj7C44hmBECFr20lg+QNER499eRc+nxE9NVmGkhrijnBAmZCqiXfJ7tsf1SSO8IDn/zP2xYEsdVqNK24GihZAOVP06qabOBPtaGx71hsWv8eHYs5Sr90A8ZmRjL35W/mX7fO1sRqsxGcQCfov+w2cEDY1TkXdVVEMrXVso/9jlbr2BxKQyrhNDvwjBWAOU8iwyXACp6UoJwrgB6liz77zf/8Iw5euuvvKPyGsyKxaMdTJiTbAsMjctpmdueTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CO1PR11MB5203.namprd11.prod.outlook.com (2603:10b6:303:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Sun, 3 Nov
 2024 14:16:34 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Sun, 3 Nov 2024
 14:16:33 +0000
Message-ID: <e5479621-6282-48d8-844f-458185306881@intel.com>
Date: Sun, 3 Nov 2024 22:21:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/17] intel_iommu: Add a placeholder variable for
 scalable modern mode
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-4-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240930092631.2997543-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CO1PR11MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ea30358-424f-4273-152d-08dcfc121e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MklKQ3Q0SS9ld3N5bFlmZlhXMUI4M1dLL252aWxweGFGaHVSWnQwY0dXa0Yz?=
 =?utf-8?B?RHFOQS83R0hlMXpoa0U2bHBWZ3Y0RXZCSE5qK0hrQTYxMnducnlxc2ptL1pv?=
 =?utf-8?B?U1gzMmpNTVp5T0N1RlFVSWRrL1Qxa3lHVTN1SUxmckM0NHB0TVB4d09QOFhD?=
 =?utf-8?B?QnpWWmRJOTN4cGdHYlNjWDZCYThrdmFTNE1nRnc5aUV3TlRCdm9mTlV4Tit6?=
 =?utf-8?B?N2JMbGxseTZtVHIzbnNtbzZMc0FXelQzWnF3aUlXOU5aYlB0VjBaeVNpOVhS?=
 =?utf-8?B?U2hZc0l5VGd1aG5qZ0JhN2NNNGFaL1IyQ05WV21pbi9KeFpZcXExVE1reWdU?=
 =?utf-8?B?K0pVSWIrVDU0YnMyWENTZzhibW1uQWZYRFl5R3pmTVI2ejBYMnJGUGdjQ2Zp?=
 =?utf-8?B?Rys4YjJ6M1BpTWpOSUFPcGpiYWRLcDRkZVFQZDl6UnF1QkhRa2pJSkZZdVZu?=
 =?utf-8?B?Y3V5alZSRHYrWDBXUzlaNW1oUERscGRXc29hTC9WcEkxVmY0KzYxcXpTWmxt?=
 =?utf-8?B?cmhtYjlEZ0E5MFkyKzBvUjFmT0F4bVNyakNtWWQwYzRoUDB5eW94RXY1akR2?=
 =?utf-8?B?K2V3bzQ3Si93QXU5alFQSFUvclBTSk9YdFpaWFJ1OUJJaUhYK1F5ZDdHS0FI?=
 =?utf-8?B?bTJMekZKdEc5SXdML3VmdXdCbEhmZzREczlrc1ZjN0F0Mk05M3lNQjhocmlN?=
 =?utf-8?B?OWVCOWNnYTdYc3FiVThPcXl3bDNseU1uRXMzcGtCUDhaWTUxODJUQ2hHSzYx?=
 =?utf-8?B?ajIvUk9UY1lscFY2OEtCcWhTdDZRNTNOUVU1S2htZzMrSmtRRFd5c2djWEJq?=
 =?utf-8?B?OHpCdnVkZmRvYllUM1R3TElBU2lZZG1CL3AxTDl4VWhiclpKN3VQMWZINFl2?=
 =?utf-8?B?OHlNQ01Dc2g1Rk81VnRBMU1WNGNFTzlUaHdmc1huaXV5dTlFclltazUrZ2Q1?=
 =?utf-8?B?eW5BWGRFaHZBbGVQb3hDbEdrWHFTUTMrUGptYTBXWlFFT1FETndtSEoxcG5L?=
 =?utf-8?B?ZndaTWJMT3k4K2NlajRxN0haZ2NGdlA4R0QxUXJWZUxFdGp3TG5nTU9EbFFB?=
 =?utf-8?B?RTNDVUVQMStNNXkzaTZ2OFhTNVFTRnVIczRnY0tMbXRCQnZrcEYwL1NBSDNF?=
 =?utf-8?B?bFV6dFdXemI3UXpXelh5MFFyNHdFNjZudFIxN0dSRUNkckRyTEVZbU5yQmRi?=
 =?utf-8?B?NUtDUWxoUE94MEhYU0pybXl2bnNRbC9yby9mUkxQQ3JxVzgvMXkyN05kVVlK?=
 =?utf-8?B?QjBIVENnL1RxTXc1T0hsQUVsampmcmlHQ0dXbSs0MnRwWVpDdXliZFY1eHJO?=
 =?utf-8?B?aTJSSlo4RVliQlR4ZUNwK1BYRVQwRDFCbUlSZ2hrME16OFhXZkp2Y09LZnFs?=
 =?utf-8?B?cXFmTjcvelNhMG4rek9rS0kyWHlkcDByQ2ZaOWlQUFRmN0FuRUNrR3FqV1Vx?=
 =?utf-8?B?NFQ2VFczazJDamV3RGlUaUNmM2JjOCswenFMdEtEZHNqQTRYY0NHZTZiLzEz?=
 =?utf-8?B?YnhuNDV6SCt4Wm5VRXZkV2dDTFB0dS9lU2JkSGQwQWFUR21JaEh1ZWxzc2pU?=
 =?utf-8?B?ODJ2eGlOTmVUQnYwUXpvS0x6T1ZXckVITExkNi9wakNRRjJDTHhpa0NIMU44?=
 =?utf-8?B?YlV1b2RnOUdlcERYb252c3FMZ2xPMmcvUWg5SGNFcjZOeGFLa3hJdjdvbldW?=
 =?utf-8?B?azl6R3k2SmRNTzZSVUErRDFhVHpXcFB0TTVPeEFneXRiWUhEN2RRRUh6S2lz?=
 =?utf-8?Q?CLFY77gAP7MaaNUiSrqxYBnERgfX0MF3elrOLE9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TSt1VG5qZnp6VG1DOGVwcytZVDVoNmliMjhwczQ4QXBtT3k5YzE4K0RQVUVl?=
 =?utf-8?B?QUVNdVdwcTN1cVhIdVd2bjhhVlk2SFA1SVp3cWVJd3BlUXVLMkxoanZRNEpy?=
 =?utf-8?B?WkhDeDhzbXdxc1ZYZzFmbk5wN0w1TDg4ekQrWVZ2UmNGbzh1V1VsYUhoSjVG?=
 =?utf-8?B?YmlmL3dCdnROWWlIWkV3TE90WSttN2JWUlF4dWtNNm9Qa29rWE5oOHMxNng5?=
 =?utf-8?B?Rm1lY0ltYmtEbDVTVlBiOUhPZVlsbUoyT05GY1dFcm1wc0UzUnNIdjFXWVRu?=
 =?utf-8?B?SnFMejVVN2s3L3Ewc3VKVWFHdVVjTlF3My9Fcy9UcWtJVUdMaTNWMmFmOVpC?=
 =?utf-8?B?eUJWZ0dVR1UydjVQcTdvV2tLVVl0WDVYSFZMVlRJYjRGZm0yTFVLT0NLM0E3?=
 =?utf-8?B?b2ZTbVVVSGJLN1BXckdtQiswUUF2SzZ5Zmw1SGc5Q0lrOGV6Y0dJam9wSEZy?=
 =?utf-8?B?eXNuSDBCbmZycmFqQnVpUEtqOHlnYitNRWdFL2FiLzBZb1lQeFpaZHZlZThr?=
 =?utf-8?B?L2tVcGhKMm5GeHJhL0xqMm1XWVA4WE41YjYvdWs5T0syNWNBY0ZNNGtndVhy?=
 =?utf-8?B?WVBDeDdLVStuQ3lPalk1QWVVa09ueFlnVHlYMXM5T3FRbUxMd09EcitXTUdQ?=
 =?utf-8?B?T2xIOE5nODJvY1pOVTlLSVBZbk9NNHd3V0dYWkpVSFI4M0RkU25MS093UWxC?=
 =?utf-8?B?OElqaVZwaTVHTHREVE1lcU1aaSt4RTBQM2lIU1lDZ0t2MnFVQlhid3gyc0pO?=
 =?utf-8?B?MlVNMzlXOWVXaDhtcWVBQzYwSSswUTI5SjU0REdwaVRVRkhLY1VhWk5uTXAv?=
 =?utf-8?B?NjMzaTNsdmhIdnl2Mjkwb3IzUjMzVTU0bG0yRmhJUUZOOHF1T09Xb2VRcHRs?=
 =?utf-8?B?aWNkVGhTM0x1Uy9xekpjOGJ5M1VpVmpJSHNmbXEwditkbUs2SitReVhDZHV1?=
 =?utf-8?B?Sng4QjZTQWRMbHZSTXZLT0dNOGxsWDVVOFF2Zmg3L2VzU09vN3J6M1p5cWJ1?=
 =?utf-8?B?NVU3MlExcFh2T3NaRmNBT1dLK1BFeUpOSkxIUHp5d0p1dlM2UGl5RmpQMEM1?=
 =?utf-8?B?SzNoVm9vVDRrUzB3MENaYktBU1BYbGtEbDh6dzlEUnlvQnlKdDh1NXpPaTZ5?=
 =?utf-8?B?UlNrRzNaY2t2WWQ5VjVUNHZFYllzajVjU1VrcWhtem55dUYwYXFlazJ4aHNS?=
 =?utf-8?B?L200YWNoQ0JlYVNxY2l1bmRSaTJlYzJEejh4TVVMeWVhVHpsWTlwMnJORXp4?=
 =?utf-8?B?eHdpR3lsb29abHVhUVFvMDNPTUtkNUQ0UFMwUEsrNXE4MVdyZVhZUER4a2xL?=
 =?utf-8?B?ZisrM1dYUTdFVVBOQUFSR3htcTlEUGpWOVZGNnRuRk14ZGFpeGJMU3ludjhL?=
 =?utf-8?B?T0o1Wk9SS2Q4WHlNc0xVZjBGU0VBdDhsaE9ETkkrOXErSDUyTkhpT1RIcGRM?=
 =?utf-8?B?d202bUoxL0x4SFVkeSs0UnNHZUk5dDh6a1hUTnVoc1RiK29CSXFyQmpCRnI3?=
 =?utf-8?B?RWRhSXV3OWZXaktKcVR6YzdwTktZK2tINVZGQ0ZkbEtFdWJNZkp5TFF4d05N?=
 =?utf-8?B?ckQ0elkzR05hMlZDdnJrTFlrUDVxL0I3N2lqYWo5RGVaWTBqMFB5cndSaUFQ?=
 =?utf-8?B?MjB3dXZNREFBUVpOV25EZUk1dkQ5WFBVMitzWktmNzQxeUdpVDFxL2Vab2JG?=
 =?utf-8?B?QnFweXNvZW52cU5jbklxOEF2cHlzS05mOEJkL09KTkVhdEdnVlUvRHlJWWhR?=
 =?utf-8?B?Tko1SWRxazhEbldERmFxdVdvTzYwMDVzd3hBZnh0L1gxNWRKcFhPckJVbXpu?=
 =?utf-8?B?dGRNdmZlZ0JJbTQzUkhCRVRWaDYxQUVMNTRMZGs5YW9rM0k5bVdaQ3ZyQjN0?=
 =?utf-8?B?bnVBQzh1bFZCd09tUGY4NXhta0ZrUlNCNHFnVGJ6ZnpSaHFVekpicnd1cTlm?=
 =?utf-8?B?VkxpTkhUaHlxcU05QU5QYUUraS9RQmlMREdmSndYZjRWS0ZnL2R2RGJyckJG?=
 =?utf-8?B?aWg5UUdkZEFHbVZiODJITVUxUkZxZHZaM1FaZ1V5VFZOMnR1OWQyRVVacVYy?=
 =?utf-8?B?M3gzNWpWbEYxcEFuMEUzdWRlSlNYOG9vSmtkSjN3VXk4ZEdyWjhzZjdwUTVj?=
 =?utf-8?Q?fQvifJV+pPd0Z7teZt1aATSKT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ea30358-424f-4273-152d-08dcfc121e9b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2024 14:16:33.6142 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7EQs1z9d9xrKb376PjvoO6S1MzWNrKsWjiYE/ZDv2xLppCsZXQCP8n7ub0KuVIqkjnR2LxYPx7xgybjdyPX2Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5203
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On 2024/9/30 17:26, Zhenzhong Duan wrote:
> Add an new element scalable_mode in IntelIOMMUState to mark scalable
> modern mode, this element will be exposed as an intel_iommu property
> finally.
> 
> For now, it's only a placehholder and used for address width
> compatibility check and block host device passthrough until nesting
> is supported.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>   include/hw/i386/intel_iommu.h |  1 +
>   hw/i386/intel_iommu.c         | 23 ++++++++++++++++++-----
>   2 files changed, 19 insertions(+), 5 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 1eb05c29fc..788ed42477 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -262,6 +262,7 @@ struct IntelIOMMUState {
>   
>       bool caching_mode;              /* RO - is cap CM enabled? */
>       bool scalable_mode;             /* RO - is Scalable Mode supported? */
> +    bool scalable_modern;           /* RO - is modern SM supported? */
>       bool snoop_control;             /* RO - is SNP filed supported? */
>   
>       dma_addr_t root;                /* Current root table pointer */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index be7c8a670b..9e6ef0cb99 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3872,7 +3872,13 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>           return false;
>       }
>   
> -    return true;
> +    if (!s->scalable_modern) {
> +        /* All checks requested by VTD non-modern mode pass */
> +        return true;
> +    }
> +
> +    error_setg(errp, "host device is unsupported in scalable modern mode yet");
> +    return false;
>   }
>   
>   static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> @@ -4257,14 +4263,21 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>           }
>       }
>   
> -    /* Currently only address widths supported are 39 and 48 bits */
> -    if ((s->aw_bits != VTD_HOST_AW_39BIT) &&
> -        (s->aw_bits != VTD_HOST_AW_48BIT)) {
> -        error_setg(errp, "Supported values for aw-bits are: %d, %d",
> +    if (!s->scalable_modern && s->aw_bits != VTD_HOST_AW_39BIT &&
> +        s->aw_bits != VTD_HOST_AW_48BIT) {
> +        error_setg(errp, "%s mode: supported values for aw-bits are: %d, %d",
> +                   s->scalable_mode ? "Scalable" : "Legacy",
>                      VTD_HOST_AW_39BIT, VTD_HOST_AW_48BIT);
>           return false;
>       }
>   
> +    if (s->scalable_modern && s->aw_bits != VTD_HOST_AW_48BIT) {
> +        error_setg(errp,
> +                   "Scalable modern mode: supported values for aw-bits is: %d",
> +                   VTD_HOST_AW_48BIT);
> +        return false;
> +    }
> +
>       if (s->scalable_mode && !s->dma_drain) {
>           error_setg(errp, "Need to set dma_drain for scalable mode");
>           return false;

-- 
Regards,
Yi Liu

