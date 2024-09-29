Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDF8CF6499
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2024 12:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sutCa-0002MU-UV; Sun, 29 Sep 2024 08:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sutCW-0002Lm-I1
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 08:39:00 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sutCT-0000gI-Jm
 for qemu-devel@nongnu.org; Sun, 29 Sep 2024 08:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1727613537; x=1759149537;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+ucRZSqvQPmkbG17NRjRXwq/jK0FncZvqaFFKOO0hnc=;
 b=PaJVEtVINYUY2R2fDWYnwgKUVf8OE883wumhYOrAjtnI5pX/qY93Gfhi
 imakU6D0cxDT0Dx/1cfA55zzzAxBxW0nKhbqqMlp1Qvc060XuV8LIhVuz
 iK/wd9li55ezV7ZgVKxp/jA7GsazL5JOQKRcnTA94SoqYnw0TIXBEsHnn
 oqQ1inNeXCflohvFk+nMJTubNCw+XRrDHUYJoyqPx8EmWluSMyESri9D4
 aTGw3rMdJQcL0BvqGPURmXARCmWKvq0jh2rq7ALvlh5AN2bSQZFFL5cML
 DBzcal33fEusdg0rxWr2TXchj67xuFK6BVD5U+ZRsyE/7PXPFCcxI4UfJ Q==;
X-CSE-ConnectionGUID: 4mi1WYbtRp+azk01qROnVg==
X-CSE-MsgGUID: xKl6qabRQQiU7LPWsKOAWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="29587588"
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; d="scan'208";a="29587588"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2024 05:38:51 -0700
X-CSE-ConnectionGUID: 8s0b3ni8RvidAsJnaiVf9A==
X-CSE-MsgGUID: 6pbdfuUZTBeW+vvUD0qeLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,162,1725346800"; d="scan'208";a="77104269"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Sep 2024 05:38:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 05:38:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 05:38:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 05:38:43 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 05:38:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGg39BiqThtgro3iSTq6GbgS/BwSLXi5EShenMA4Omous7tFLsZATirufjTLdu1M8vSUenVv+O9q4kaEIdsIh4P2Zrg8WwWfyt4nVyH37ZuZtj4YzrvH3ia9tgQvBbohSCtWGUJN8oslf5/ZnTxu66Tj4DB+QwkvJ+YLB/5bgq5O31kbP/t0Obx98wCWio4J/Tk21nn0JcK7vBwA0NPjY7UR2hDRYxdaYgcfBp/1Hg8yQ/H9Wf4W+yWEQp7KcytzPDO0Ft7r3XjO0y6Cj+Yary9nWIFEwynbh4OUsyHsaYvatmepRStPi0t6Gkg9Yf6ZIIPfR8+yMCCBKfFKxvPu7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZU7ehB3nOWrNltRzKcyaJPezrwPpB2oNgbmERQ2zmi8=;
 b=L+2mn0AKJisliVPhhdxI/LRsdClJ0qQKCLn4vsQn2PBeywT1a0ZoMgqxGQ9ban2/ih+HM+q8DZ6QoQ2gsfT2Mx+Jzz40HkUDkNWl/c040SNVqw9k/KUsbCvUerA96YqgLkrkOtuBrWHgzBFrbhFE6G8Gi26wzray4YlffWR9EGkJ+wZr58T/E+STF8PHYwJ5tDd4ckl8g1UPojcnjJ/Bou+KXiH72JQiuhwDLqYsy8Qt3aXWl3MIXXUf/uiuFPBYP5mZcPZLD3CaQxS8CaYirYxENBQuXX9efnZF36gTvo51teSWP+2u7jd9ezs6Q0wqI9tYz3hXDssxcrdFnnilaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5213.namprd11.prod.outlook.com (2603:10b6:a03:2da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 12:38:38 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 12:38:38 +0000
Message-ID: <2832359e-9e9d-4407-a105-0a24cdf31e00@intel.com>
Date: Sun, 29 Sep 2024 20:43:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/17] intel_iommu: Rename slpte to pte
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240911052255.1294071-1-zhenzhong.duan@intel.com>
 <20240911052255.1294071-6-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240911052255.1294071-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0023.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::35)
 To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef6e984-737e-46e3-4836-08dce083a48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LzVjTmt4WjkzUitQd2pPT3FZREJxRWdsYUQ1cEkzUTlHU3Z0ZzZXaTNNZTRt?=
 =?utf-8?B?bFJFbzdXVUtqbEZlQTBZZEZSZEU0SGlOdVRqYkRQQ2dKTHdwdmh0NmZxRVAw?=
 =?utf-8?B?VU1wU0M4V0tlbkM0ZW8rWks4K0d2TEFnUmpvK1BRVlNhZUo3UnpVL3hiWmtG?=
 =?utf-8?B?TXUreGZJV1RrRmk0ZEtaTVpzMW9iUnU1ZzY4RitEL1gvamNpWmRSOTliWmo1?=
 =?utf-8?B?Y0t5cVp4NEx6TEJ3MnFjKytSbzhlVzhrZjhjT1BiZytGQ3p6Tm1KbXdoNnA3?=
 =?utf-8?B?U2JGT1M3WWhFWWRvR2Z2UDM0T2JiWG9VYUp3ekdCRHJjdW5UY0tSazRsZ292?=
 =?utf-8?B?SWVnQXY2K3hMN0NyRE8rWXREZUwyYnNmL04rckh6TmM1THo0SjNnNkVPbXFn?=
 =?utf-8?B?blpPeHFXRDBSTzgra201bktRV2VTL3BOSWphQUlKMUx1NHUxdkJnOHJ6eW43?=
 =?utf-8?B?UEJJSnZTWStnRjlzZkdHako4NVZVRGh6dCt4RHRRZS9JdnZUR0FnL3IvVnFl?=
 =?utf-8?B?aU9DbVpOTFRZQitKeXRqMnhRYjhVcXRoZklzRS90bDRrekxXKzBpRk1kZ3Qw?=
 =?utf-8?B?eDF5N0ZyRlZ1MTZndFdXUGlkNGNKaFJYNzNlZFJDMkFxbUg1MmNHcmd6OFd2?=
 =?utf-8?B?L05yOXIwai9SVlRONm9XZXdvVUlpa3lTWjJBS1pJdTh3OWVmMzQyRlkvclRS?=
 =?utf-8?B?dlRnTXFpY2JwTmhlSTlYcUlydldicCtpNUlyN0o4bE8zMHNsWnpkQjFRNlpZ?=
 =?utf-8?B?UnBPUHgvbmJpbnI3dVNxUVhldkhtaHRoajdXMzB3YjRtdGQzbUFvTW84TUZX?=
 =?utf-8?B?Y0VSYlZPYVlYWEVKYVJDclhkT0ZSZkZvRmlZSUhJNmE3b1N5dkw1MWdHclIw?=
 =?utf-8?B?ZDFPTHBqWlBCMllpN2I3aWhYQ2Y5cUZ2Vnc1WjJUVjVNYkJNMDJZeUdvQ3Fy?=
 =?utf-8?B?enRaWDdIeW9tUkw1VmVic1NKZ3JnV2NObEZESURpbE1Gd1hGZS9ENkpDbkVV?=
 =?utf-8?B?RmNBcnVrUnV4M09jckRFVEVKSmRaSlRVK3dndk05dFhhL3FvL2NFaEJ6Q04v?=
 =?utf-8?B?dXR6TmwxRzVQcXhJU3VjcTlIQ2w0MndQTVFwMWpnb1AxQW9VWGI4SWcray9s?=
 =?utf-8?B?Z0FHdzIrMlBZWTV2WnNRN0VxUlM3eENwQldaMllwZDBlai9zV3dDUFc0TUt6?=
 =?utf-8?B?ZUhWQU5BTkoxb081SkNoL3RROVhWSzg5ZHQzQ2VoNC8rallDVGt4cEUxQlAx?=
 =?utf-8?B?NUU4Y0R4NFFaOTRTbFI4MnhiUURHZGRrMDk1WFpiWW5pb3VHbWc0d0RsSzVQ?=
 =?utf-8?B?VmhsUStsbzRFUHpRWTFoZjMvQUVNdWhteThaUkNPV0p0UURhMEw5dW1uSERl?=
 =?utf-8?B?QTZoakg3ZUdERVdGTEhaZXQ4Tnc0T1RvdmphdHRpNHhNQ0UydFdTNEVSR1hH?=
 =?utf-8?B?R2IrS0VmU3JuTjRydXhZOG8wcnBBeFpGME9xT2RPY3RuOGpZSWdOaFJFRjdz?=
 =?utf-8?B?eGZDMit5K1RTWTIrLzVONkJacUhodDNsMjRhcWdwL2JKN09xL09zdGMwVk9I?=
 =?utf-8?B?MDZHU3FvanBUYWhCVk0zeEdOaGN4UGc2SzJNamNDMXVlRmVYRFoxaFlqSGc0?=
 =?utf-8?B?d2JPSUJuMmw2WWJTWnl2NTcwZ2k0QlpTM2E3QURKUXVPSWtyU3VLVThXd25E?=
 =?utf-8?B?MHlGcDlFaWtvTHJWVXRwY0RoZXl4cGUxRDhNc1FtUFFRTDFjaTVVSXJBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDhpRk5IU0FKeTMzYmRXYzNOU0dNalkvejYvK2NHejl3amgraDRhQWpMNTZz?=
 =?utf-8?B?czFZQm9GZ0NZSC94NjNVVmxpN09DSjVkdEhHTjZPdW1JQ29xR1p5K0xLR1Zr?=
 =?utf-8?B?aE5TWTdoUTJYSHFZVDJERlFBVW4ydDZQdUc1bC9rdTcwL25Zd25WMnZTUU9u?=
 =?utf-8?B?UzZXYlBHMHpwZ05ieGszQkI0SFYzRFg5VUExVjNxWlQ0ZGR6S20xZXVialNP?=
 =?utf-8?B?S3VZN3hVNHg1bWIvVjUyNmkvbmQvcDMxakgyRTY2UWZOWW1TeGVUc2RzRjJH?=
 =?utf-8?B?Z1JHbmRlUm43clZyUFY1SkRSRjdXTnJteXBTaTZGQWk4Q0tTcjlTZ0JRTlg5?=
 =?utf-8?B?YzBndjk5UTZyZ3J5dk9zeUdNbnFVaXowV0dEaTIxNmpSSnN6TlhmL1dxZ0d4?=
 =?utf-8?B?Rk4rRnl6TThkc1pXMXRCUTk2UEJWV3pNb2FXZ0RGd0pUckxpK0JMY3hETXZW?=
 =?utf-8?B?T3Btb0FFTXZVS2VQb1Zmd1ZQeVU0WktYYWFuRm1IaitXNDJlc08zUitHbDRL?=
 =?utf-8?B?WDRIdjRNeUtqQitJV0s3M05STVN0ZWVhK0Q3SlNyR2wvTkdjZG1pOGpGZ0tD?=
 =?utf-8?B?aWxwaVpGdkF5SDdXNjJ6RVpaRXMxOUh3RlhjY0g2bVJqaEJJRDVZWWF2c21q?=
 =?utf-8?B?czh6bVdGdlU4QS9qY2pFVXRrQ2Z2d1RZOUFJSG8yejBnUS9IVWhrYitXZVBw?=
 =?utf-8?B?aWJPNnRTWDFsa1NRWTJJRUs3dDRma2lVZDF1Nk04WEpnY2h2WWZGQXlUQ3li?=
 =?utf-8?B?MGlIMXlQRVVleEtaWkd6UlRzWFZxSG8xQ2VrSEVoMXQ0Z2RhMzNWQ0NJU2pv?=
 =?utf-8?B?S2pFNmVEY050VU5uQlFlZmNFUFh4RnFkRGxnV1M4bS9HSE1CeUcxMmZoQ05V?=
 =?utf-8?B?bC84WStTa0NEVWJoZlo5K3lmRWR4WHc5cEF6YmRpWXh3SlV2Q3A4M0RJUm9r?=
 =?utf-8?B?WGNSTFpWQlk1Rm5IOTU5aUtUbkRUM0QyU1NaUm85NWlFUWw3Y1FhM3Raekhx?=
 =?utf-8?B?aWdtQ1dCSHVjWXhpS2JNZEQzcmJxc1MwZUN4UWVFaTVMWWVzb2UxaTVUYjhh?=
 =?utf-8?B?L1I4OUd0K25Odm5CRGIyWVA2Wi9ENWZKZFMyUElIY2JVS05kd0hQeFdnNWJJ?=
 =?utf-8?B?VXBsVzRVUFMzWXE4dGttVHVGZ2FWb2JSUU5ZQ3YyM25ETDRzL3BQK1JuQjJK?=
 =?utf-8?B?ZmNkQWdlMDJxZDlTQUZqL25oOStzd3NLY0loMUFsNzZYa2N3VHg2cmtieHJj?=
 =?utf-8?B?ckwzSEozYkJlSnhkQU9yY21sMDdhSmtmL3RldEJyKzJmWE1qeWozVitvZDFH?=
 =?utf-8?B?YWdWMkFiQS9lZWFEQStzQXNEZ0I0bjRkUThVOThJM05hZUZiUnpjN2QzcWNp?=
 =?utf-8?B?cHB3SENQVzZ5OTNDMEhSVE9ONVd3QUdTd0RmaFVQRnBOT2g3TW9rUHdrUHRq?=
 =?utf-8?B?Z3YvZFc0TjBqb2EvTmh6aUlLSHRQaUhRTEhtbDFpdjBsNHFIMW9LMnplNWY1?=
 =?utf-8?B?Q3NiaC95TjdOblF1QWxIS2lkL2JvKzljZlV1b2t4Q3RqaUVkZnJOSzlXcDRt?=
 =?utf-8?B?ektZa2pPK2RPaWJjWGhOUk56TkUrY1MwMFRYZkRqUE1ETEdQQ2dFUjdORWpE?=
 =?utf-8?B?bWtMa1pCQTdmcS9CemVSZzBXSGh3ODVIRkJQVTFnRVhDTkpKdzUxQ0ZvOWRU?=
 =?utf-8?B?WktWb3RNTnh3MEx0Qk82OEZza2h1VXJaQVloODJsUGtaVnYzNFBsSWFDRjYy?=
 =?utf-8?B?L1JzQnF2T3YydjdZQnVQbk5LREFFZ0VvaTFnbFRaNVRKcm85RUdWaG42YjE2?=
 =?utf-8?B?M3UvL2pCMmdaTTVQbXdjdjZOa2tzZjNOWktwbjI5bTBFS3ZMWVFXSGxIRU9m?=
 =?utf-8?B?MTg4R05YU2JVOU5vVnlldlgzTjdPM0pTT3Z0Q3VBV3NtcTVsekJwUkpqV1ov?=
 =?utf-8?B?V2ZKOTlUQy84bHplMitZVmNzaDJkSGdSTEdDWGFJZHJ3VGJ5aG5yNENBY2xo?=
 =?utf-8?B?M1RjWHRJN0Uzak0vYzExdjJ5aldacklSQUI4WFE5ZkJNUHZjSTVraTljd0Zs?=
 =?utf-8?B?TTEzL3pOMDQyMGMvYmFQQnE0TnN4eTdDUUNocjJXSEgwWmRyMEYxN1hBaTNC?=
 =?utf-8?Q?rqT1fTmkzGguP4gqh8kfY2TjZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef6e984-737e-46e3-4836-08dce083a48e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 12:38:38.7083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUp543q8FlCc9uLM8GZFaOJllnGcQAqfc65ETDmMnm72eNFYMn+3WwClijHSEQbYKmdCRgi4RkFz/hiwaIyzyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5213
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2024/9/11 13:22, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
> 
> Because we will support both FST(a.k.a, FLT) and SST(a.k.a, SLT) translation,
> rename variable and functions from slpte to pte whenever possible.
> 
> But some are SST only, they are renamed with sl_ prefix.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Co-developed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  24 +++---
>   include/hw/i386/intel_iommu.h  |   2 +-
>   hw/i386/intel_iommu.c          | 129 +++++++++++++++++----------------
>   3 files changed, 78 insertions(+), 77 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 19e4ed52ca..1fa4add9e2 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -528,24 +528,24 @@ typedef struct VTDRootEntry VTDRootEntry;
>   /* Second Level Page Translation Pointer*/
>   #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
>   
> -/* Paging Structure common */
> -#define VTD_SL_PT_PAGE_SIZE_MASK    (1ULL << 7)
> -/* Bits to decide the offset for each level */
> -#define VTD_SL_LEVEL_BITS           9
> -
>   /* Second Level Paging Structure */
> -#define VTD_SL_PML4_LEVEL           4
> -#define VTD_SL_PDP_LEVEL            3
> -#define VTD_SL_PD_LEVEL             2
> -#define VTD_SL_PT_LEVEL             1
> -#define VTD_SL_PT_ENTRY_NR          512
> -
>   /* Masks for Second Level Paging Entry */
>   #define VTD_SL_RW_MASK              3ULL
>   #define VTD_SL_R                    1ULL
>   #define VTD_SL_W                    (1ULL << 1)
> -#define VTD_SL_PT_BASE_ADDR_MASK(aw) (~(VTD_PAGE_SIZE - 1) & VTD_HAW_MASK(aw))
>   #define VTD_SL_IGN_COM              0xbff0000000000000ULL
>   #define VTD_SL_TM                   (1ULL << 62)
>   
> +/* Common for both First Level and Second Level */
> +#define VTD_PML4_LEVEL           4
> +#define VTD_PDP_LEVEL            3
> +#define VTD_PD_LEVEL             2
> +#define VTD_PT_LEVEL             1
> +#define VTD_PT_ENTRY_NR          512
> +#define VTD_PT_PAGE_SIZE_MASK    (1ULL << 7)
> +#define VTD_PT_BASE_ADDR_MASK(aw) (~(VTD_PAGE_SIZE - 1) & VTD_HAW_MASK(aw))
> +
> +/* Bits to decide the offset for each level */
> +#define VTD_LEVEL_BITS           9
> +
>   #endif
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 788ed42477..fe9057c50d 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -152,7 +152,7 @@ struct VTDIOTLBEntry {
>       uint64_t gfn;
>       uint16_t domain_id;
>       uint32_t pasid;
> -    uint64_t slpte;
> +    uint64_t pte;
>       uint64_t mask;
>       uint8_t access_flags;
>   };
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index be30caef31..a22bd43b98 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -48,7 +48,8 @@
>   
>   /* pe operations */
>   #define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
> -#define VTD_PE_GET_LEVEL(pe) (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
> +#define VTD_PE_GET_SL_LEVEL(pe) \
> +    (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
>   
>   /*
>    * PCI bus number (or SID) is not reliable since the device is usaully
> @@ -284,15 +285,15 @@ static gboolean vtd_hash_remove_by_domain(gpointer key, gpointer value,
>   }
>   
>   /* The shift of an addr for a certain level of paging structure */
> -static inline uint32_t vtd_slpt_level_shift(uint32_t level)
> +static inline uint32_t vtd_pt_level_shift(uint32_t level)
>   {
>       assert(level != 0);
> -    return VTD_PAGE_SHIFT_4K + (level - 1) * VTD_SL_LEVEL_BITS;
> +    return VTD_PAGE_SHIFT_4K + (level - 1) * VTD_LEVEL_BITS;
>   }
>   
> -static inline uint64_t vtd_slpt_level_page_mask(uint32_t level)
> +static inline uint64_t vtd_pt_level_page_mask(uint32_t level)
>   {
> -    return ~((1ULL << vtd_slpt_level_shift(level)) - 1);
> +    return ~((1ULL << vtd_pt_level_shift(level)) - 1);
>   }
>   
>   static gboolean vtd_hash_remove_by_page(gpointer key, gpointer value,
> @@ -349,7 +350,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
>   
>   static uint64_t vtd_get_iotlb_gfn(hwaddr addr, uint32_t level)
>   {
> -    return (addr & vtd_slpt_level_page_mask(level)) >> VTD_PAGE_SHIFT_4K;
> +    return (addr & vtd_pt_level_page_mask(level)) >> VTD_PAGE_SHIFT_4K;
>   }
>   
>   /* Must be called with IOMMU lock held */
> @@ -360,7 +361,7 @@ static VTDIOTLBEntry *vtd_lookup_iotlb(IntelIOMMUState *s, uint16_t source_id,
>       VTDIOTLBEntry *entry;
>       unsigned level;
>   
> -    for (level = VTD_SL_PT_LEVEL; level < VTD_SL_PML4_LEVEL; level++) {
> +    for (level = VTD_PT_LEVEL; level < VTD_PML4_LEVEL; level++) {
>           key.gfn = vtd_get_iotlb_gfn(addr, level);
>           key.level = level;
>           key.sid = source_id;
> @@ -377,7 +378,7 @@ out:
>   
>   /* Must be with IOMMU lock held */
>   static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
> -                             uint16_t domain_id, hwaddr addr, uint64_t slpte,
> +                             uint16_t domain_id, hwaddr addr, uint64_t pte,
>                                uint8_t access_flags, uint32_t level,
>                                uint32_t pasid)
>   {
> @@ -385,7 +386,7 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
>       struct vtd_iotlb_key *key = g_malloc(sizeof(*key));
>       uint64_t gfn = vtd_get_iotlb_gfn(addr, level);
>   
> -    trace_vtd_iotlb_page_update(source_id, addr, slpte, domain_id);
> +    trace_vtd_iotlb_page_update(source_id, addr, pte, domain_id);
>       if (g_hash_table_size(s->iotlb) >= VTD_IOTLB_MAX_SIZE) {
>           trace_vtd_iotlb_reset("iotlb exceeds size limit");
>           vtd_reset_iotlb_locked(s);
> @@ -393,9 +394,9 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
>   
>       entry->gfn = gfn;
>       entry->domain_id = domain_id;
> -    entry->slpte = slpte;
> +    entry->pte = pte;
>       entry->access_flags = access_flags;
> -    entry->mask = vtd_slpt_level_page_mask(level);
> +    entry->mask = vtd_pt_level_page_mask(level);
>       entry->pasid = pasid;
>   
>       key->gfn = gfn;
> @@ -710,32 +711,32 @@ static inline dma_addr_t vtd_ce_get_slpt_base(VTDContextEntry *ce)
>       return ce->lo & VTD_CONTEXT_ENTRY_SLPTPTR;
>   }
>   
> -static inline uint64_t vtd_get_slpte_addr(uint64_t slpte, uint8_t aw)
> +static inline uint64_t vtd_get_pte_addr(uint64_t pte, uint8_t aw)
>   {
> -    return slpte & VTD_SL_PT_BASE_ADDR_MASK(aw);
> +    return pte & VTD_PT_BASE_ADDR_MASK(aw);
>   }
>   
>   /* Whether the pte indicates the address of the page frame */
> -static inline bool vtd_is_last_slpte(uint64_t slpte, uint32_t level)
> +static inline bool vtd_is_last_pte(uint64_t pte, uint32_t level)
>   {
> -    return level == VTD_SL_PT_LEVEL || (slpte & VTD_SL_PT_PAGE_SIZE_MASK);
> +    return level == VTD_PT_LEVEL || (pte & VTD_PT_PAGE_SIZE_MASK);
>   }
>   
> -/* Get the content of a spte located in @base_addr[@index] */
> -static uint64_t vtd_get_slpte(dma_addr_t base_addr, uint32_t index)
> +/* Get the content of a pte located in @base_addr[@index] */
> +static uint64_t vtd_get_pte(dma_addr_t base_addr, uint32_t index)
>   {
> -    uint64_t slpte;
> +    uint64_t pte;
>   
> -    assert(index < VTD_SL_PT_ENTRY_NR);
> +    assert(index < VTD_PT_ENTRY_NR);
>   
>       if (dma_memory_read(&address_space_memory,
> -                        base_addr + index * sizeof(slpte),
> -                        &slpte, sizeof(slpte), MEMTXATTRS_UNSPECIFIED)) {
> -        slpte = (uint64_t)-1;
> -        return slpte;
> +                        base_addr + index * sizeof(pte),
> +                        &pte, sizeof(pte), MEMTXATTRS_UNSPECIFIED)) {
> +        pte = (uint64_t)-1;
> +        return pte;
>       }
> -    slpte = le64_to_cpu(slpte);
> -    return slpte;
> +    pte = le64_to_cpu(pte);
> +    return pte;
>   }
>   
>   /* Given an iova and the level of paging structure, return the offset
> @@ -743,12 +744,12 @@ static uint64_t vtd_get_slpte(dma_addr_t base_addr, uint32_t index)
>    */
>   static inline uint32_t vtd_iova_level_offset(uint64_t iova, uint32_t level)
>   {
> -    return (iova >> vtd_slpt_level_shift(level)) &
> -            ((1ULL << VTD_SL_LEVEL_BITS) - 1);
> +    return (iova >> vtd_pt_level_shift(level)) &
> +            ((1ULL << VTD_LEVEL_BITS) - 1);
>   }
>   
>   /* Check Capability Register to see if the @level of page-table is supported */
> -static inline bool vtd_is_level_supported(IntelIOMMUState *s, uint32_t level)
> +static inline bool vtd_is_sl_level_supported(IntelIOMMUState *s, uint32_t level)
>   {
>       return VTD_CAP_SAGAW_MASK & s->cap &
>              (1ULL << (level - 2 + VTD_CAP_SAGAW_SHIFT));
> @@ -833,7 +834,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>   
>       pgtt = VTD_PE_GET_TYPE(pe);
>       if (pgtt == VTD_SM_PASID_ENTRY_SLT &&
> -        !vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe))) {
> +        !vtd_is_sl_level_supported(s, VTD_PE_GET_SL_LEVEL(pe))) {
>               return -VTD_FR_PASID_TABLE_ENTRY_INV;
>       }
>   
> @@ -972,7 +973,7 @@ static uint32_t vtd_get_iova_level(IntelIOMMUState *s,
>   
>       if (s->root_scalable) {
>           vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> -        return VTD_PE_GET_LEVEL(&pe);
> +        return VTD_PE_GET_SL_LEVEL(&pe);
>       }
>   
>       return vtd_ce_get_level(ce);
> @@ -1040,9 +1041,9 @@ static inline uint64_t vtd_iova_limit(IntelIOMMUState *s,
>   }
>   
>   /* Return true if IOVA passes range check, otherwise false. */
> -static inline bool vtd_iova_range_check(IntelIOMMUState *s,
> -                                        uint64_t iova, VTDContextEntry *ce,
> -                                        uint8_t aw, uint32_t pasid)
> +static inline bool vtd_iova_sl_range_check(IntelIOMMUState *s,
> +                                           uint64_t iova, VTDContextEntry *ce,
> +                                           uint8_t aw, uint32_t pasid)
>   {
>       /*
>        * Check if @iova is above 2^X-1, where X is the minimum of MGAW
> @@ -1083,17 +1084,17 @@ static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
>   
>       /*
>        * We should have caught a guest-mis-programmed level earlier,
> -     * via vtd_is_level_supported.
> +     * via vtd_is_sl_level_supported.
>        */
>       assert(level < VTD_SPTE_RSVD_LEN);
>       /*
> -     * Zero level doesn't exist. The smallest level is VTD_SL_PT_LEVEL=1 and
> -     * checked by vtd_is_last_slpte().
> +     * Zero level doesn't exist. The smallest level is VTD_PT_LEVEL=1 and
> +     * checked by vtd_is_last_pte().
>        */
>       assert(level);
>   
> -    if ((level == VTD_SL_PD_LEVEL || level == VTD_SL_PDP_LEVEL) &&
> -        (slpte & VTD_SL_PT_PAGE_SIZE_MASK)) {
> +    if ((level == VTD_PD_LEVEL || level == VTD_PDP_LEVEL) &&
> +        (slpte & VTD_PT_PAGE_SIZE_MASK)) {
>           /* large page */
>           rsvd_mask = vtd_spte_rsvd_large[level];
>       } else {
> @@ -1119,7 +1120,7 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
>       uint64_t access_right_check;
>       uint64_t xlat, size;
>   
> -    if (!vtd_iova_range_check(s, iova, ce, aw_bits, pasid)) {
> +    if (!vtd_iova_sl_range_check(s, iova, ce, aw_bits, pasid)) {
>           error_report_once("%s: detected IOVA overflow (iova=0x%" PRIx64 ","
>                             "pasid=0x%" PRIx32 ")", __func__, iova, pasid);
>           return -VTD_FR_ADDR_BEYOND_MGAW;
> @@ -1130,7 +1131,7 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
>   
>       while (true) {
>           offset = vtd_iova_level_offset(iova, level);
> -        slpte = vtd_get_slpte(addr, offset);
> +        slpte = vtd_get_pte(addr, offset);
>   
>           if (slpte == (uint64_t)-1) {
>               error_report_once("%s: detected read error on DMAR slpte "
> @@ -1161,17 +1162,17 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
>               return -VTD_FR_PAGING_ENTRY_RSVD;
>           }
>   
> -        if (vtd_is_last_slpte(slpte, level)) {
> +        if (vtd_is_last_pte(slpte, level)) {
>               *slptep = slpte;
>               *slpte_level = level;
>               break;
>           }
> -        addr = vtd_get_slpte_addr(slpte, aw_bits);
> +        addr = vtd_get_pte_addr(slpte, aw_bits);
>           level--;
>       }
>   
> -    xlat = vtd_get_slpte_addr(*slptep, aw_bits);
> -    size = ~vtd_slpt_level_page_mask(level) + 1;
> +    xlat = vtd_get_pte_addr(*slptep, aw_bits);
> +    size = ~vtd_pt_level_page_mask(level) + 1;
>   
>       /*
>        * From VT-d spec 3.14: Untranslated requests and translation
> @@ -1322,14 +1323,14 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
>   
>       trace_vtd_page_walk_level(addr, level, start, end);
>   
> -    subpage_size = 1ULL << vtd_slpt_level_shift(level);
> -    subpage_mask = vtd_slpt_level_page_mask(level);
> +    subpage_size = 1ULL << vtd_pt_level_shift(level);
> +    subpage_mask = vtd_pt_level_page_mask(level);
>   
>       while (iova < end) {
>           iova_next = (iova & subpage_mask) + subpage_size;
>   
>           offset = vtd_iova_level_offset(iova, level);
> -        slpte = vtd_get_slpte(addr, offset);
> +        slpte = vtd_get_pte(addr, offset);
>   
>           if (slpte == (uint64_t)-1) {
>               trace_vtd_page_walk_skip_read(iova, iova_next);
> @@ -1352,12 +1353,12 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
>            */
>           entry_valid = read_cur | write_cur;
>   
> -        if (!vtd_is_last_slpte(slpte, level) && entry_valid) {
> +        if (!vtd_is_last_pte(slpte, level) && entry_valid) {
>               /*
>                * This is a valid PDE (or even bigger than PDE).  We need
>                * to walk one further level.
>                */
> -            ret = vtd_page_walk_level(vtd_get_slpte_addr(slpte, info->aw),
> +            ret = vtd_page_walk_level(vtd_get_pte_addr(slpte, info->aw),
>                                         iova, MIN(iova_next, end), level - 1,
>                                         read_cur, write_cur, info);
>           } else {
> @@ -1374,7 +1375,7 @@ static int vtd_page_walk_level(dma_addr_t addr, uint64_t start,
>               event.entry.perm = IOMMU_ACCESS_FLAG(read_cur, write_cur);
>               event.entry.addr_mask = ~subpage_mask;
>               /* NOTE: this is only meaningful if entry_valid == true */
> -            event.entry.translated_addr = vtd_get_slpte_addr(slpte, info->aw);
> +            event.entry.translated_addr = vtd_get_pte_addr(slpte, info->aw);
>               event.type = event.entry.perm ? IOMMU_NOTIFIER_MAP :
>                                               IOMMU_NOTIFIER_UNMAP;
>               ret = vtd_page_walk_one(&event, info);
> @@ -1408,11 +1409,11 @@ static int vtd_page_walk(IntelIOMMUState *s, VTDContextEntry *ce,
>       dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
>       uint32_t level = vtd_get_iova_level(s, ce, pasid);
>   
> -    if (!vtd_iova_range_check(s, start, ce, info->aw, pasid)) {
> +    if (!vtd_iova_sl_range_check(s, start, ce, info->aw, pasid)) {
>           return -VTD_FR_ADDR_BEYOND_MGAW;
>       }
>   
> -    if (!vtd_iova_range_check(s, end, ce, info->aw, pasid)) {
> +    if (!vtd_iova_sl_range_check(s, end, ce, info->aw, pasid)) {
>           /* Fix end so that it reaches the maximum */
>           end = vtd_iova_limit(s, ce, info->aw, pasid);
>       }
> @@ -1527,7 +1528,7 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>   
>       /* Check if the programming of context-entry is valid */
>       if (!s->root_scalable &&
> -        !vtd_is_level_supported(s, vtd_ce_get_level(ce))) {
> +        !vtd_is_sl_level_supported(s, vtd_ce_get_level(ce))) {
>           error_report_once("%s: invalid context entry: hi=%"PRIx64
>                             ", lo=%"PRIx64" (level %d not supported)",
>                             __func__, ce->hi, ce->lo,
> @@ -1897,7 +1898,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>       VTDContextEntry ce;
>       uint8_t bus_num = pci_bus_num(bus);
>       VTDContextCacheEntry *cc_entry;
> -    uint64_t slpte, page_mask;
> +    uint64_t pte, page_mask;
>       uint32_t level, pasid = vtd_as->pasid;
>       uint16_t source_id = PCI_BUILD_BDF(bus_num, devfn);
>       int ret_fr;
> @@ -1918,13 +1919,13 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>   
>       cc_entry = &vtd_as->context_cache_entry;
>   
> -    /* Try to fetch slpte form IOTLB, we don't need RID2PASID logic */
> +    /* Try to fetch pte form IOTLB, we don't need RID2PASID logic */

s/form/from/

>       if (!rid2pasid) {
>           iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
>           if (iotlb_entry) {
> -            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->slpte,
> +            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
>                                        iotlb_entry->domain_id);
> -            slpte = iotlb_entry->slpte;
> +            pte = iotlb_entry->pte;
>               access_flags = iotlb_entry->access_flags;
>               page_mask = iotlb_entry->mask;
>               goto out;
> @@ -1996,20 +1997,20 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>           return true;
>       }
>   
> -    /* Try to fetch slpte form IOTLB for RID2PASID slow path */
> +    /* Try to fetch pte form IOTLB for RID2PASID slow path */

s/form/from/. otherwise, looks good to me.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

>       if (rid2pasid) {
>           iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
>           if (iotlb_entry) {
> -            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->slpte,
> +            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
>                                        iotlb_entry->domain_id);
> -            slpte = iotlb_entry->slpte;
> +            pte = iotlb_entry->pte;
>               access_flags = iotlb_entry->access_flags;
>               page_mask = iotlb_entry->mask;
>               goto out;
>           }
>       }
>   
> -    ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &slpte, &level,
> +    ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
>                                  &reads, &writes, s->aw_bits, pasid);
>       if (ret_fr) {
>           vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
> @@ -2017,14 +2018,14 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>           goto error;
>       }
>   
> -    page_mask = vtd_slpt_level_page_mask(level);
> +    page_mask = vtd_pt_level_page_mask(level);
>       access_flags = IOMMU_ACCESS_FLAG(reads, writes);
>       vtd_update_iotlb(s, source_id, vtd_get_domain_id(s, &ce, pasid),
> -                     addr, slpte, access_flags, level, pasid);
> +                     addr, pte, access_flags, level, pasid);
>   out:
>       vtd_iommu_unlock(s);
>       entry->iova = addr & page_mask;
> -    entry->translated_addr = vtd_get_slpte_addr(slpte, s->aw_bits) & page_mask;
> +    entry->translated_addr = vtd_get_pte_addr(pte, s->aw_bits) & page_mask;
>       entry->addr_mask = ~page_mask;
>       entry->perm = access_flags;
>       return true;

-- 
Regards,
Yi Liu

