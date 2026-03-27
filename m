Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B7B10BA422
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 04:23:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5yjL-0002RI-6j; Fri, 27 Mar 2026 00:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w5yjE-0002Oa-Rr
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:23:24 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w5yjC-00059m-Ll
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 00:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774585402; x=1806121402;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=2GXHBu0gktj14Lbs6pvaS8hJXR9vI78o7wGdfLs4cco=;
 b=YZjlbrBUWr8su6svlaqTpReHcRXak5bK57v852d/tIo6Ztja3KmCQpq9
 ikWL1I5CelTzumfX5eml3QQLXO0AHcySLKg7wMIzF456qH/gUNF86CM4j
 jsYKcspmCq3Ak7w+N086DdQyTo8mpayuukb87dLJ+IlB0njrIwvG90tz/
 O+G7JEKs/rHP5RBHrDIIGYin0kAmaRyBgrRRmb0UM7SpfA0T9cLG1M10T
 OiyKpaOMU/DN3qflCj/N7r/XdmHAHuLoFD0zft6M2D0wwSor6sQjafJCd
 mAFTEge2elBjTG8NoibDXcYgWGjaf3OovFZyPQvsrH5eYWO8stGGJA4GQ g==;
X-CSE-ConnectionGUID: gM/SQ5ixTJGd5XlhSyP2+g==
X-CSE-MsgGUID: uysQH9gvQcya4kz/lDAeOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74838419"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="74838419"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:23:20 -0700
X-CSE-ConnectionGUID: E2WXw0O3TcS2EcuPFLn5Qw==
X-CSE-MsgGUID: a2y67MnNQ8abSMO03KYKGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="225215604"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 21:23:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:23:19 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 21:23:19 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 21:23:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPStjQajPLTd9LKwaqnr77LDqe+9RYS2TrUaJLir04HBM/+p74BpZ/szp0YrWojus070Thl8lTQ7qbGpbnpBdhMPVGbdeuva3h8O9BvJbcX+V68i3xYN3szuM+yqDqVjMZ6dkUWXtSQzbWJvJcKVm+0R4ayasIK7mEb5EjFevpBkuRIOxgU5N11J44ElkDnKYx1Xyl0HRvrtId/cN05oJU5ZsLdcRw0rxbxR0bkQTETLTIedrZa6vpunUeSzw1Tk+I90K1j/f2F/Ur0yFrRM+DooyOyFA1i2Hs1VZWsiRyIdiWE5yaq1pAmha46V0au6LfdwlwXA55VUiPojVQFy5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLmFjMJ64X+ZvC2zOpss8/W8xkRLVu8n4laRtti/eoE=;
 b=inmbgsfsH5ie0jyk5opvBVLvqXQI+nZ7S2dPahWMWJIJIGXEOI+xQjHKGca2eaJ8pyTdqNdvbiPYusavCxJm/UhVCrRkBqHUqWpmKWjh+rmmhie1a24bS+jwO1wbKN6JgtnmrPu/1gRGVfZOH4PSq37hLCHFuaV8UeD0NkIu+S/1JkXhvl6zaequbiIFdv/LcizsvM2A6jkt49dQ8W15b+ysdkb+rlITOAoIGdL5bGaRQoFvQopPLfhbn9ynvDDyuGEuS6QGu4CFgp24XPIjkpWoLNAWSZvd8wLYK+28u9JURNgwwjTib8RjsjiHBV4b3Kiy093auo/zjj/lhy2N3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by SA1PR11MB9614.namprd11.prod.outlook.com (2603:10b6:806:4c4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 04:23:16 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 04:23:16 +0000
Message-ID: <b133ead4-d871-4037-af7a-e7b534e20954@intel.com>
Date: Fri, 27 Mar 2026 12:31:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] intel_iommu_accel: Handle PASID entry removal
 for pc_inv_dsc request
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
 <20260326091130.321483-9-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260326091130.321483-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::15) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|SA1PR11MB9614:EE_
X-MS-Office365-Filtering-Correlation-Id: f83ebdbc-7fc4-490e-3641-08de8bb89169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|42112799006|366016|3613699012|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3dPvXq+orcKonCFlmzwubZ26K83WP3Fl51YD65IUhTpkeKQCVm4+OSSxiZXG+l10aUckTwKkqUJXYqGx0e7UEj5FeyZGJ9lnJacS5kO3X9uHF2xNYFPYUCLYC4cNDnxuZq9XaOiDHSJSCX1LoXh0SvwztPl0M1cRnUf7LAonn4IGiAoYtUZ5T1Vd4+xgvUsVWcGFcdhxMnLUhgzW2a62N6l2LQaXfcY58aywv1FL1YqTETtP99hdgv1tgV63AVSnI9q4HT0fbNaePdQWpBdK0SYvQU6a5A53McI4QrLuawXljMVbV/4Si7Q3N4Wo1vynUaBevYMsBJpcaHgrnSsosi9k5ekb8Zp35FY/6dX2v4M4SvTYHNter87V0l42u5pzQQT7VCcwxMInVg0MjIfxbEDEW6QkCNtbBrW9ekxo+9s60+hMU/FbcIWZDNBTba5pXx4hNLWdd0JfLylHU0QFV64e/Ncp8bnEQ2ahQ5t0fRh6QAlqmaF5BIzRAt+bIjY4nXcN4ywBP79BFoURrsqa9ROglpgBwPKzZ+YCUF1Auyc9QVSGKeo8XMq476NSD744wumQWHb/3JdvDUnbIk8T1p8uiXWzt4HM56FKFy9vluNMQ08j+x7m5uJobVL7zK2oLmNQ48gpUGnnMmOfGRYD7EfyNoVR01w/MNfcQ6zS7QJVxFVMrMx0k9Mf8DlzWxUvmd2UNR/oTE8GhKwnpDstHXu1vCgdDodGRbuycxG0mbUZFbnmxxJAOrcWZ+XUxjir/943ZJpyTl8XswFPEnMO+0bY7goLaaGWPQiEb6okkjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(42112799006)(366016)(3613699012)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHYvcHdXZG9qeTdrMHhvZXpWSlpxRHpPemtlNG1ObEV5SENSS1M4RHViWXJr?=
 =?utf-8?B?Slo5TXVXT1Uvd3RBOE92bENPRnZTT01Hb2hRenBUNU5SSlRwM0Nncnpsa2li?=
 =?utf-8?B?WVNtQzBmMHVvUVp1RHVybmg3bTh2ZmhuZEJnVkcyRjMxTGFmWEZYRDg5c0Vs?=
 =?utf-8?B?WWk0UE8yZnVxZXdVa0FPWGpvWmM3SE1SUFFXNXhHWVhvOWtqcDBwajNpTVMz?=
 =?utf-8?B?ditWUHJ3KzB2WWpjSk0rODZobHBVTzZsbFBVQjQ2L0VPaElyL21LOTg3YmM4?=
 =?utf-8?B?NzYxVFpBR1FHVTJMVlZSWFdERldYYmZBT1VLS2JZSkRxUHhLWERXbmVTVmRx?=
 =?utf-8?B?ZnRTSHJRaWo5eFgzMjY4ZloydjdJeHhaWHNzMWFsbW9jbTU2YnA4NGNQbW0r?=
 =?utf-8?B?bUZObTlad2w2MWVOVnRRWDBFRzk1TUZYdStqMkIxbWNhNFB1aWozTTd4Umwr?=
 =?utf-8?B?aHZRSEdxMENSM002dEZvcWpJeGowcUJsUDd0ZFNSempYRnYyeHU5eUozRjhX?=
 =?utf-8?B?V3NTZHk2NDlKTjRFWmEzMlYxTnZhazZiWFdHMENzcVB0RnZzOGJSMGtJeTJk?=
 =?utf-8?B?d3lUMXhtcnNjTjhxQ2FVNDhJOGRXVEV2eDZtanVLVGZDb3dJU0FnZVFVemI4?=
 =?utf-8?B?R2piRytIci9YaWhPU1JsbG01eWlTK2NBWEtzVHAvaFMwMDhveDRsaXdSVVp2?=
 =?utf-8?B?RHNwRzREcGNHQVRzTXc5cVBiVHJpN2NRV0ppMlZFOTcrN3EySzRLM0grRjdR?=
 =?utf-8?B?SFlxcld1Z2hQeldwRFZxc0ZZVjBWeWp2ejgxWGMzRElYR0huWmJTaDJLQVBL?=
 =?utf-8?B?czJwWXMxZ2pEUDMydXFBNEtMSjdOVVZXZzQ3UW8zWklyeStkc2dSU3BUaVRt?=
 =?utf-8?B?ZGZuNUtTbFZjbTdob2RqblFxYWdpWUs5OWo5Y1hJOWc0WWdsZkpzV2JBTFVq?=
 =?utf-8?B?bDlPYmRqdlFVYnNxUThWNlQ2L1ovU0NNREdiY0RDaXY4ck1qcWE3a1ZqbVJ5?=
 =?utf-8?B?NTJzS2JINlhuOVJoNG0vZVEyc1NGREU4Mlg4ak1Neml4VjFTRWxBY0EwdkQx?=
 =?utf-8?B?YVdna0xQUG44S1kzbjJTK0JGd0c2QXplL0xnd1drQTBtWmNxWng5eFk3ZGI0?=
 =?utf-8?B?ajI5MytmU0xLc0plUmtkeGVDSlhQTGtzeWh6Y1N6TFNVYTc2MFVpVEk5RXJz?=
 =?utf-8?B?dFdTQndUanN4elNhQ0tiTEhYY2V5bjM2SnVkV1dZV1Fjd2gvM1Y4dVdIWXl0?=
 =?utf-8?B?T0hXT2JqZEtYY0kyVG1yeHA4L1NiY3pRZ3RGUjhMRTN6RFU3SHNVV1d4c2Qw?=
 =?utf-8?B?Q3NzbjBldktGSkUrd2xzNWEzRjR0ZE9NOWgxSGVQMVJNbXJ4b3E1TkRRMnRK?=
 =?utf-8?B?Mk1BdDhlREpPejMrNC9WRFlJT0EvY1hOTThCSTlDMlNhazR3L1hBbGhFL0w4?=
 =?utf-8?B?Y09aWitxY2U4T3BRWDJncUUzZ1lkM2ZYZ0NteGJodnRFejZYTERQNWgrZFFj?=
 =?utf-8?B?cWZ4VzZxTzlmb3dJK2RMNGtsZk5KczB0eUNvci95bUszNlNZVjgxTTN3bDFF?=
 =?utf-8?B?L0VBQ3FHTjVlR3g2OUQzWjNSYkhkTUxqekExY2JSYWhMbUtsdXdSY2UwVzlx?=
 =?utf-8?B?RUpqRXdYa29xbUswekxHV2w2dHorNkVjaDc0ZVc4VVRIVm0wSXVXcENoWFR5?=
 =?utf-8?B?ckkxaUJHb1F5cm9qbng2eUtHdFJWdXJ1eVk2dU5Dd1h6ZFBIMlFZN0ZrSEto?=
 =?utf-8?B?dmtiRHRhelR4VEF5d0F2dVhqTjhUQ2U0WEZWcCtLeUhrQlBUWjYveElNQktN?=
 =?utf-8?B?SDZQMXV4QVBmR2pWOEJnNkc4TXFIUHpYaFAzTm5uaERYaUVXNXJRMjR3YVpU?=
 =?utf-8?B?YVFxTDgzOHdiNThSUWhUcUR3S3V2S2J6WkJPTnFtWHExQTB2UVdYNEE1MWp4?=
 =?utf-8?B?T2FJc1VsTG12cVgvTG1jYUxEaDFHR0l4RzJETHEzM21GUWNmU3hwR0Y3VEVH?=
 =?utf-8?B?U0IzQUFzZGtQUVZmNndUVndJOFZYNjZyWXhlTzJiSTljOWNJSXJSRjhIc2VU?=
 =?utf-8?B?VXM0T0Z4ZTFEcEpNbzhUcmVOUktyZUpKL29mZm1KbFp1b08rS0J1enFUQ21C?=
 =?utf-8?B?ci9kR3Y0QUNXeVJPYzdZZnFxd2t5WDFlQTZ2M2lPakc5aXZGaGxacjZIcUhm?=
 =?utf-8?B?ckNTekwwYnYwdVVGdzdRa1Q1MzdUQ3R2SHEzYWtVa08vRFp1QzdRdmx3Z2s4?=
 =?utf-8?B?UlRvc3l1UlpwYW9kUmMyRGJuYnB6bUM5dFNURGpCTjdIeklMajk0NXNoQUJS?=
 =?utf-8?B?NVV1bTVUQkl0UGJKcnJ6MDFNQXJwTHd1aDViYURPWlBIVUQ1djh2Zz09?=
X-Exchange-RoutingPolicyChecked: uJ87JyYoQNgtCU1S+7k4N2M/czMW3YDjHcBH8PJb7fCKrFqRB/ctT8LVoxtX14wlkutZ0VKg5M9IZy/aiFjjhiSe1tazkTxCgaaB8W8knv5GjgzOlZPazQDYh0SB1T65xKuSGW0ogN723vR5dosxxIz5Hgnzakz9aIYbj10gAWso3EyYH26T/qO/VrUhVWXI9UHGryy3TG15R5khEUVR1HWaYs61kNgIKOL9FGnTFroEp+LBfzg7p0fE3j7z+Sl+CeBPDwMtp6SaKEAYurHjBO63RAPZ7Ns64aX0JWfDM3YC7mg+RpPmT01jPMHRqsvrs2YWJD2c294Sf2VN6QCHkw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f83ebdbc-7fc4-490e-3641-08de8bb89169
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 04:23:16.6108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZ9qAk/QmGmcnGyG4t7RxFSw7J8YDAEvrJUFE+ZDIt9yBrIEf2VCob8Sp3kLvoPqkpqYr0JewpBgAnb/WNFzSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9614
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18; envelope-from=yi.l.liu@intel.com;
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

On 3/26/26 17:11, Zhenzhong Duan wrote:
> When guest deletes PASID entries, QEMU will capture the pasid cache
> invalidation request, walk through pasid_cache_list in each passthrough
> device to find stale VTDAccelPASIDCacheEntry and delete them.

> This happen before the PASID entry addition, because a new added entry
> should never be removed.

drop above line.

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_accel.c | 75 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 75 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index 32d8ab0ef9..c1285ce331 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -16,6 +16,28 @@
>   #include "hw/pci/pci_bus.h"
>   #include "trace.h"
>   
> +static inline int vtd_hiod_get_pe_from_pasid(VTDAccelPASIDCacheEntry *vtd_pce,
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
> +static void vtd_pasid_cache_invalidate_one(VTDAccelPASIDCacheEntry *vtd_pce,
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
> +        did = VTD_SM_PASID_ENTRY_DID(&vtd_pce->pasid_entry);
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

could you wrap above two lines into a helper near to the
vtd_accel_fill_pc()? Although no other callers, just more readable. :)

> +    }
> +}
> +
> +/* Delete invalid pasid cache entry from pasid_cache_list */

above comment is not quite necessary.

> +static void vtd_pasid_cache_invalidate(VTDHostIOMMUDevice *vtd_hiod,
> +                                       VTDPASIDCacheInfo *pc_info)
> +{
> +    VTDAccelPASIDCacheEntry *vtd_pce, *next;
> +
> +    QLIST_FOREACH_SAFE(vtd_pce, &vtd_hiod->pasid_cache_list, next, next) {
> +        vtd_pasid_cache_invalidate_one(vtd_pce, pc_info);
> +    }
> +}
> +
>   static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
>                                 VTDPASIDEntry *pe)
>   {
> @@ -423,6 +491,13 @@ void vtd_pasid_cache_sync_accel(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
>                                    TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
>               continue;
>           }
> +
> +        /*
> +         * PASID entry removal is handled before addition intentionally,
> +         * because it's unnecessary to iterate on an entry that will be
> +         * removed.
> +         */
> +        vtd_pasid_cache_invalidate(vtd_hiod, pc_info);

s/vtd_pasid_cache_invalidate/vtd_accel_pasid_cache_invalidate/

>           vtd_replay_pasid_bind_for_dev(vtd_hiod, start, end, pc_info);
>       }
>   }


