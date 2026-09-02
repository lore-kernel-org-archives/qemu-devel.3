Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A49C624D3
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1kYC-00077R-C9; Wed, 02 Sep 2026 08:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1x1kY6-00076v-Ar
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:58:42 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1x1kY3-0003Q0-55
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 08:58:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788353919; x=1819889919;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fXIebj+ZaEf/9Iq4+HFIJ0q3B+pT8Td1hUyc6xRJbwE=;
 b=JskQE8wv+S5FDp8XIW+QndJZCEfwXfCeMiSs2POJBrByZryechF9nZfY
 ES4jI1xIDnLgS7IF+reBsD8ItbCCSJ1gS91bC4cUNPRuA/HeOledwT8wj
 KkMvsed/ZfBiYyiC3bpSdgzxc2hjA1EgDlXer/pg5cU6DnXfFGy+jZISM
 m/g5HkmyFnsYtJAiSE/blrVjRu475anrdPOaffwjijvGgwnPhSuuSjeHk
 egxsZtcnGooe0LrGkmEfGjE8AcVZ2K9I5AmE/y02GlcYzFkYm4H8OfAjW
 QQ5aemQ4pPENzF8fqUqVJR7XpbWXFg0BEm2GMkN6jsFI8cH9zCKtOlISP Q==;
X-CSE-ConnectionGUID: C+dmyahSQJeKXt2z0ueDwQ==
X-CSE-MsgGUID: H7o/ByxqR+elaZa7Sq2LhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="111579143"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="111579143"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 05:58:39 -0700
X-CSE-ConnectionGUID: 0ZI5IrexSASQT5J9RPzKBA==
X-CSE-MsgGUID: 5wMiCAVjQJuGSKK3vyJ9ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="266168494"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 05:58:38 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 05:58:37 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 05:58:37 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 05:58:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITes7wsbAcDxLrMkH4oTPaOZJAXlCwZMq5eQQNrLx9vzXvjN44eWuMFyw0/z61VGA8rNn2p4uaRC4T8LJzyONMvSNbWEGA3A9s5G2ycQFVxzbHRkmcqOw8VLBUDcEykE0LyhYDC4FmQuM6YHjkPHFJe4kLhDwHaAw4mqed5ydD9acjoIeiNRbUkif9IYLM+7u4MnmCOPB18LmCJyBGOsVZx1iaBSRprqQ5ikN8qsowVloxw28fmF6Ko7oPjO+WgXQNavdtgnAddiraGkO7kyS5JeM2rOVc2BcRlIiYc4rheULhEce163cr4yItSObFGdDpjYLR/O1GjpphIjveJ4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+h/PIZIjjmsg109uDZuthYQZ0mepgErH+FNePLJHy04=;
 b=eL0JEAoNKRYW2qR/AenGJGNpT4F2T1GBB97vITuqhblBtlrGvTl9LOxYrxzMJ++JXJSZROhDMSQYfKxHGXlO3t57+WE5z/szDRZbILJKLqWI6stJI8oyNcTPnwKmzel0XKkZxnwIeXJIe+JvdgwrmNKPmhbixCEwGaa88vO+TYSReWBPZE9ZfSMb+VjMTT37g1GSjiby7o8kFtEg2izsQ7tJGqxIAGhCbULZiW7lhEGQFaWioR+Lvv7PgJiOolSOnpV57DphF6tXdhBthRRKDPcscZ2d6qdfOYo1WVamFOehm31Oi1mcqC1z2Nsy+lNo9FfXdx+WkUkeDM7Qfgzu0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DS0PR11MB8666.namprd11.prod.outlook.com (2603:10b6:8:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 12:58:34 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 12:58:34 +0000
Message-ID: <26c49670-0918-45e1-b07e-199362081714@intel.com>
Date: Wed, 2 Sep 2026 21:06:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] intel_iommu_accel: Add PRQ injection for
 passthrough device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowangio@gmail.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260831095200.1279366-1-zhenzhong.duan@intel.com>
 <20260831095200.1279366-5-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260831095200.1279366-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::8) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DS0PR11MB8666:EE_
X-MS-Office365-Filtering-Correlation-Id: faa77390-c871-4d5d-16ca-08df08f1e5b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|42112799006|1800799024|23010399003|7416014|376014|10067099003|6133799003|18002099003|4143699003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: 1qfMGRecb9DTV9UHJVEom9BUblXpP608FyLNddZN6xY0TwEGj/CSH/AlHHFCTLtUFffurN6/xZD6BfHOBBCbaiasngLYKl55TEN2UyLaxe7ZmWh2BQrwupi/uSNYHSMC7s8dxSKypdafeqJSoySaL7qj5Z7+9uoycc2QrRT25L49I25yLOiN8HZ+B107ezYZ9CnA4DjaRlx/T40ixR34c0ZXr2B+CspjSnPKsXqoguvpFEvVSHyQRiuXpDCWyHs7Tg897Q2AJX2aTlji3o6e2ONUG1zYl7XfdY+Zy//jzNCFCpme2TxNfWu1frilLvX1FWIlb+6ZoD2hMOHhWeqlJYv+jjxlCXpfI1F3X1P7Ucr9icGKIMGmD72YMHdf3WkZja3lEIv4BGf1P15fZyodB5OUtQGHupGFKmB53TiNgPIOwTu24whiUQ22wOqjrJcvJQCAmsp3W6H+d+QarS/K5/iRNC+3i14sK/BpEzUtRXHNma3zU+rINAThfEqMdUZE80i7zl96xHPpLvmn0o9hRbRgQRlqWJ1AR6dhxI2jsU0AZcY+p4d08PrY2mfft3XkWzZxvGzfhZq+9IUPjKfK732LCXUr9cSURaSmXVTRFlP7oZ6xIVSiaaSKs96tuYEsCAPLP5JSRaUXFOhQM/20H9hWdafSFgGJN4lLeqRRrwk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(42112799006)(1800799024)(23010399003)(7416014)(376014)(10067099003)(6133799003)(18002099003)(4143699003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDYxT1BYLzl0ZGdsZ2ZMcGczeHVKZDNQVW1WTjQ2R0l3TGRjWmVXMnFOVWwy?=
 =?utf-8?B?SFNPOEtvZTh4ZDRTVytzdEt3VlZPdThheGM2bk9oMzQwNXYxQnVZTTAzSWV0?=
 =?utf-8?B?dEVIakl1MDViWEJTcnhnSkU5OFVlRTY4K1hRNzF4K2JUK2JjY1NsUVFLYkJ2?=
 =?utf-8?B?Rmt6RXFQa0FReEJZK0Y2RjJPaXEvUVZZN3RPYkZ2d2tmUVFKY3F2bEFwVjVC?=
 =?utf-8?B?dlNMRUQvYktUUkIzSG9WWWhaTG5tTFh1ZzE1TStZNmlNNkhENTJURVJSeVVC?=
 =?utf-8?B?aGxCdjJxUjVCejhNNFkwcENOc0dZTTdIbm81U3JrSFJpRXpVa0xMYk9DeEdZ?=
 =?utf-8?B?TzZVQUI1c3JnZWc0MXNaVE9uSitvUDFreE4rMjFEdzhPbENHTE9IL0pEeGxB?=
 =?utf-8?B?YXlxeG53RjA5Wld5ZEQrMG40VzNaYUVOWkhNTXFNWHNoVC9yUmlxSWJGY2s3?=
 =?utf-8?B?dTVobGVwUU4veDB1Ym5jY0JlQXJuV3U2REZHMG5uVDhxWklLTzFZRmtiRkEx?=
 =?utf-8?B?Y05QUGNaWlQxd3ROam0zQXlRY3BRSlJJRGt2NXF4R29pYTd2d0FrZ3NwTlZo?=
 =?utf-8?B?S3M2cnNqOGVQMSsxNjJya01Xa1lBeFN1bXhlT2tjdHkwNDQ3cU5ic2JBOXIx?=
 =?utf-8?B?aVJmVzRMQTNkc01iTndWc3l3cURrN1dRUEpLcGhmM2N5RDVOYzgyeFkwSUJj?=
 =?utf-8?B?d0c0RlNOZHNBUHZLdU1EdlJLRUlqUWd6d0NvWnhSN2NGQ0VadndOR3dSdDln?=
 =?utf-8?B?cDd2Z0s0b3d1cWhvZURBM2pENFJZVVZwTG1BUHNRMkpmOHRzdTZ0MXVHN3dW?=
 =?utf-8?B?MXg3WW92c1JQS1VMZmttTzk1aHdUVDJqMDdBL0tLck42U3F4Sy9xQThCM3h4?=
 =?utf-8?B?ZG0xWCt4MS84Y0M1c2JjUzhGcHlXS3Rhc1B4c0dieEJ1ekk0c0M0TXhuSFhv?=
 =?utf-8?B?Y1RDdkU3R3Z0QjJHSDB3RmpiS1lSbU5MNlZCOU44RmN2aEZsNXJ5TnJicTFN?=
 =?utf-8?B?YTUxaTFTcXJzWGF4TE02eUdWR0R3QlRsRzVxUW92U3NoSW9jdEJ5VEFiVkJD?=
 =?utf-8?B?d1UwcmU0ZGp6TGdpUVpKV0hPQng2ZGFMNTBuWHJWRk5OY0VDWURVMTJ5RXg4?=
 =?utf-8?B?c3ZmY3ordk1hZ0NmQmpzZG93L3czeXlLdmtYWVBNTmxqNXFEMXNoKzZ2VWQ5?=
 =?utf-8?B?NXBMVU4xVUN4bVhyZzVXckpKekhNUCt6Q1ljL1hZUVhkaHlzZkI3K0RLbHVS?=
 =?utf-8?B?a05GVU9Nb0gzWm1OeDl5UHg0bnEvdkVuSFpRT2s2MUFOR0tJRkRoVXdvU2Z4?=
 =?utf-8?B?MjRpU2RDY3hYdmxFNXVkRHNYelhZcXhxNnE4ajNTOEVoN1hud3NGbEF1M0dr?=
 =?utf-8?B?YklpblBJZEJwMmtFUitqOG9CZlJwTTlBQi9tYy9QNmJnMWhQYUtBVjdUbGVq?=
 =?utf-8?B?QzBMdldOY0tIU01sQVQxTGkrSzUzZnBkTEVHc0hmR25IeDhPZS9VdjdSbGxO?=
 =?utf-8?B?MXRlcm9UclcrcFVzUFlrdTlPaUdjd0N4KzhuYS9UbHRnYXBaKzVXcUl6eHlt?=
 =?utf-8?B?L2lYRGRFVUpabyt1eHJOL3ZIc0tBTmpvRitSOFlJWnpjYUhIeDVmaWw2ZlU0?=
 =?utf-8?B?ZkhPNXNkc3ZhVUQyODBNckRRcXlMdHFJVXNqK1pXazJPcUJxOXNPcnp3Q09m?=
 =?utf-8?B?ZjFsMWtVa0hKMFgvOEZ2NG9kN1V4NjJ1ek1LblNodlFpNjZBQi9YS2VMakNx?=
 =?utf-8?B?RlhjdlZ3djBsV0p4c09Qb1FrbTE5cVV0VGRTMGQxd2tYL0JrTm4vdjZiYmZs?=
 =?utf-8?B?Ukc1OFJnL08vRXhoWlZLTnk0OGQ3SmlLMlk3dXhCOHp3b3djc2ZsVFJBUHcr?=
 =?utf-8?B?Ujg5TkVtdE91Nnk3RmlZc3JwYW1IWnlkWGhlTTdkSjU0Q1pSM3IrQ2dOV3lt?=
 =?utf-8?B?cGptTThoVC80VVNzbTNxVHZ1MW55S1BDdjFwZWh2bEt6ZC9wOWFlN0x4VW1R?=
 =?utf-8?B?OTcrWWRibmlPcVd1UTJxTjE4MWtWN2crQnVWNno4M0N4d3NjVXZ3ZzVrRlJy?=
 =?utf-8?B?TzdPU1RFZUd0Yk9RSWIxVHJpWlo0UWZVa0E5enJySVpCN1loS1R3bGxxUkM3?=
 =?utf-8?B?RGRNazFhUjVlRjdVNy94czgzRTBNbEVvU2xzUHdlMmlJYlM2dHo0MGMySXRN?=
 =?utf-8?B?clNvY1JDL2xDOWQ1YUNxRm9TNk1weEJvRm5rd3J0UkFIWU05WXEzVHoxaEdJ?=
 =?utf-8?B?eklGWFhnWHRveE1sSHJEaHFnWDc1aVZDeVdDbGpPTVRONFVOaDI3ZHJ3VUZw?=
 =?utf-8?B?N0pJTlF2dUdHOVJNWUJZMjJmckxvRmtHaUZPR2czS3IzYnpma0NSUT09?=
X-Exchange-RoutingPolicyChecked: Y6iRHevHwVWPzoJjDMaHilnuKkyoa3/aHU/N1+IoY9E2gyChWeIbUt1DOl7eS5LGxjDcYvis6fJrJRSWMDe/Q/MEHLJNpST2TFjZfinyeir/LFRJoB/EoTUYSSV9zbqJkWhY2nz9aDPZdFGBsd08zYE5CjD0vBhgDys+F3EjBN4V6BhfaM9AHSsjJBetOES0AxiIzeyigNmT50tTLvGfTujc3eHH23cF9Thhz/tqJE5pF1t01ETgFpsqv3HptZtxmFmAaFDs1ugITuGLYWwT+E4Xjpeb6xuS3bEbJsS1W6CnGIPfFFbTBRl9MWy8aDUETdr7TAGt3bFr+L403iQ1Hg==
X-MS-Exchange-CrossTenant-Network-Message-Id: faa77390-c871-4d5d-16ca-08df08f1e5b7
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 12:58:34.5549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdUYpMSnY/2Yx1xe+C+V1tF+VpBwMuX106+I8LUP7eavKjB4Y6D0LutOXhvvDF+8WBBUZrmbWv0HyG3z4TRFIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8666
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 8/31/26 17:51, Zhenzhong Duan wrote:
> When the guest enables the PRQ in vIOMMU, allocate a FAULTQ object so that
> host-side recoverable fault events can be received and propagated back to
> the guest.

I thought FAULTQ object is allocated at the time when PRE bit is set. :) 
How about below?

When PRQ is enabled in guest, vIOMMU side allocates FAULTQ object for 
each s1_hwpt, so that host-side recoverable fault events can be received 
and propagated to guest.

> Install an event handler on the FAULTQ fd to read and propagate host
> generated recoverable fault events to the guest.
> 
> The handler runs in QEMU's main loop, using a non-blocking fd registered
> via qemu_set_fd_handler().
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   hw/i386/intel_iommu_accel.h    |   2 +
>   hw/i386/intel_iommu_internal.h |   3 +
>   hw/i386/intel_iommu.c          |   9 +-
>   hw/i386/intel_iommu_accel.c    | 160 +++++++++++++++++++++++++++++++--
>   hw/i386/trace-events           |   1 +
>   5 files changed, 164 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index 46c1a29409..e0319749a5 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -18,6 +18,8 @@ typedef struct VTDAccelPASIDCacheEntry {
>       VTDPASIDEntry pasid_entry;
>       uint32_t pasid;
>       uint32_t fs_hwpt_id;
> +    uint32_t fault_id;
> +    int fault_fd;
>       QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
>   } VTDAccelPASIDCacheEntry;
>   
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 924e91cb8a..5ebc204e9a 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -786,4 +786,7 @@ int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>   VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid);
>   int vtd_dev_get_pe_from_pasid(IntelIOMMUState *s, PCIBus *bus, uint8_t devfn,
>                                 uint32_t pasid, VTDPASIDEntry *pe);
> +int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn, uint32_t pasid,
> +                         bool priv_req, bool exec_req, hwaddr addr, bool lpig,
> +                         uint16_t prgi, bool is_read, bool is_write);
>   #endif
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 82c3c3b2c3..dcf23924ef 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -5369,11 +5369,10 @@ static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
>       return ret;
>   }
>   
> -/* Page Request Descriptor : 7.4.1.1 */
> -static int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn,
> -                                uint32_t pasid, bool priv_req, bool exec_req,
> -                                hwaddr addr, bool lpig, uint16_t prgi,
> -                                bool is_read, bool is_write)
> +/* Accept the PCI PASID as input. Page Request Descriptor : 7.4.1.1 */

can this "Accept the PCI PASID" be more accurate? Because it is facing
the emulated device models, so this should be PCI PASID instead of the
pasids used within vIOMMU.

> +int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn, uint32_t pasid,
> +                         bool priv_req, bool exec_req, hwaddr addr, bool lpig,
> +                         uint16_t prgi, bool is_read, bool is_write)
>   {
>       IntelIOMMUState *s = opaque;
>       VTDAddressSpace *vtd_as;
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index d2f41f18f1..3808112f79 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -9,6 +9,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "system/iommufd.h"
>   #include "intel_iommu_internal.h"
>   #include "intel_iommu_accel.h"
> @@ -77,14 +78,150 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
>       return NULL;
>   }
>   
> -static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
> -                               VTDPASIDEntry *pe, uint32_t *fs_hwpt_id,
> -                               Error **errp)
> +static void vtd_prq_report_fault(VTDAccelPASIDCacheEntry *vtd_pce,
> +                                 struct iommu_hwpt_pgfault *fault, unsigned cnt)

vtd_prq_report_fault is a bit confusing. seems like reporting a fault of 
PRQ. how about naming vtd_recoverable_fault_report? or any other name?

> +{
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
> +    uint32_t pasid =
> +        vtd_pce->pasid == IOMMU_NO_PASID ? PCI_NO_PASID : vtd_pce->pasid;
> +
> +    for (; cnt--; fault++) {
> +        bool last_page = fault->flags & IOMMU_PGFAULT_FLAGS_LAST_PAGE;
> +
> +        vtd_pri_request_page(vtd_hiod->bus, vtd_hiod->iommu_state,
> +                             vtd_hiod->devfn, pasid,
> +                             fault->perm & IOMMU_PGFAULT_PERM_PRIV,
> +                             fault->perm & IOMMU_PGFAULT_PERM_EXEC,
> +                             fault->addr, last_page, fault->grpid,
> +                             fault->perm & IOMMU_PGFAULT_PERM_READ,
> +                             fault->perm & IOMMU_PGFAULT_PERM_WRITE);
> +    }
> +}
> +
> +/* Batch size per read(); remaining faults trigger another callback */
> +#define FAULTQ_BUF_SIZE 100
> +

anyhow, we won't miss any fault. right?

> +static void vtd_prq_read_fault(void *opaque)
> +{
perhapss s/vtd_prq_read_fault/vtd_fs_faultq_read/, then aligned with the
below create/destroy/setup helpers.

> +    VTDAccelPASIDCacheEntry *vtd_pce = opaque;
> +    struct iommu_hwpt_pgfault fault[FAULTQ_BUF_SIZE];
> +    uint32_t id = vtd_pce->fault_id;
> +    int fd = vtd_pce->fault_fd;
> +    ssize_t bytes, last_bytes;
> +
> +    bytes = read(fd, fault, sizeof(fault));
> +    trace_vtd_prq_read_fault(id, fd, bytes);
> +    if (bytes < 0) {
> +        if (errno != EAGAIN && errno != EINTR) {
> +            error_report_once("FAULTQ(id %u): read failed (%m)", id);
> +        }
> +        return;
> +    } else if (!bytes) {
> +        error_report_once("FAULTQ(id %u): fault group too big", id);
> +        return;
> +    }
> +
> +    last_bytes = bytes % sizeof(fault[0]);
> +    if (last_bytes) {
> +        error_report_once("FAULTQ(id %u): discard partial fault data: %zd/%zu",
> +                          id, last_bytes, sizeof(fault));
> +    }
> +
> +    vtd_prq_report_fault(vtd_pce, fault, bytes / sizeof(fault[0]));
> +}
> +
> +static void vtd_destroy_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
> +                                  uint32_t fault_id, int fault_fd)
> +{
> +    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +
> +    if (fault_fd < 0) {
> +        return;
> +    }
> +
> +    close(fault_fd);
> +    iommufd_backend_free_id(hiodi->iommufd, fault_id);
> +}
> +
> +static bool vtd_create_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
> +                                 uint32_t *fault_id_p, int *fault_fd_p,
> +                                 Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    IntelIOMMUState *s = vtd_hiod->iommu_state;
> +    uint8_t bus_n = pci_bus_num(vtd_hiod->bus);
> +    uint32_t fault_id, fault_fd;
> +    VTDContextEntry ce;
> +    int flags;
> +
> +    if (!s->svm ||
> +        vtd_dev_to_context_entry(s, bus_n, vtd_hiod->devfn, &ce) ||
> +        !VTD_CE_GET_PRE(&ce)) {
> +        *fault_id_p = 0;
> +        *fault_fd_p = -1;
> +        return true;
> +    }
> +

this PRE validation hunk better in the caller side. This helper would be
pure creation helper. BTW. is there any point that we can cach the CE
instead of fetching it here. It seems we won't come to this helper if no
CE.

> +    if (!iommufd_backend_alloc_faultq(hiodi->iommufd, &fault_id, &fault_fd,
> +                                      errp)) {
> +        return false;
> +    }
> +
> +    flags = fcntl(fault_fd, F_GETFL);
> +    if (flags < 0) {
> +        error_setg_errno(errp, errno, "Failed to get flags for FAULTQ fd");
> +        goto free_faultq;
> +    }
> +
> +    if (fcntl(fault_fd, F_SETFL, flags | O_NONBLOCK) < 0) {
> +        error_setg_errno(errp, errno, "Failed to set O_NONBLOCK on FAULTQ fd");
> +        goto free_faultq;
> +    }
> +
> +    *fault_id_p = fault_id;
> +    *fault_fd_p = fault_fd;
> +    return true;
> +
> +free_faultq:
> +    vtd_destroy_fs_faultq(vtd_hiod, fault_id, fault_fd);
> +    return false;
> +}
> +
> +static void vtd_destroy_old_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce)
> +{
> +    if (vtd_pce->fault_fd < 0) {
> +        return;
> +    }
> +
> +    qemu_set_fd_handler(vtd_pce->fault_fd, NULL, NULL, NULL);
> +    vtd_destroy_fs_faultq(vtd_pce->vtd_hiod, vtd_pce->fault_id,
> +                          vtd_pce->fault_fd);
> +    vtd_pce->fault_id = 0;
> +    vtd_pce->fault_fd = -1;
> +}
> +
> +static void vtd_setup_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce,
> +                                uint32_t fault_id, int fault_fd)
> +{
> +    if (fault_fd < 0) {
> +        return;
> +    }
> +
> +    vtd_pce->fault_id = fault_id;
> +    vtd_pce->fault_fd = fault_fd;
> +    qemu_set_fd_handler(fault_fd, vtd_prq_read_fault, NULL, vtd_pce);
> +}
> +
> +static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod, VTDPASIDEntry *pe,
> +                               bool has_fault_id, uint32_t fault_id,
> +                               uint32_t *fs_hwpt_id, Error **errp)
>   {
>       HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>       struct iommu_hwpt_vtd_s1 vtd = {};
>       uint32_t flags = vtd_hiod->iommu_state->pasid ? IOMMU_HWPT_ALLOC_PASID : 0;
>   
> +    flags |= has_fault_id ? IOMMU_HWPT_FAULT_ID_VALID : 0;
> +
>       vtd.flags = (VTD_SM_PASID_ENTRY_SRE(pe) ? IOMMU_VTD_S1_SRE : 0) |
>                   (VTD_SM_PASID_ENTRY_WPE(pe) ? IOMMU_VTD_S1_WPE : 0) |
>                   (VTD_SM_PASID_ENTRY_EAFE(pe) ? IOMMU_VTD_S1_EAFE : 0);
> @@ -94,7 +231,7 @@ static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
>       return iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid,
>                                         hiodi->hwpt_id, flags,
>                                         IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd), &vtd,
> -                                      0, fs_hwpt_id, errp);
> +                                      fault_id, fs_hwpt_id, errp);
>   }
>   
>   static void vtd_destroy_old_fs_hwpt(VTDAccelPASIDCacheEntry *vtd_pce)
> @@ -115,7 +252,8 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
>       VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
>       HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>       VTDPASIDEntry *pe = &vtd_pce->pasid_entry;
> -    uint32_t hwpt_id = hiodi->hwpt_id, pasid = vtd_pce->pasid;
> +    uint32_t hwpt_id = hiodi->hwpt_id, pasid = vtd_pce->pasid, fault_id = 0;
> +    int fault_fd = -1;
>       bool ret;
>   
>       /*
> @@ -130,7 +268,12 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
>       }
>   
>       if (vtd_pe_pgtt_is_fst(pe)) {
> -        if (!vtd_create_fs_hwpt(vtd_hiod, pe, &hwpt_id, errp)) {
> +        if (!vtd_create_fs_faultq(vtd_hiod, &fault_id, &fault_fd, errp)) {
> +            return false;
> +        }
> +        if (!vtd_create_fs_hwpt(vtd_hiod, pe, fault_fd >= 0, fault_id,

this funciton call can reuse the PRE bit validation result instead of
checking fault_fd.

> +                                &hwpt_id, errp)) {
> +            vtd_destroy_fs_faultq(vtd_hiod, fault_id, fault_fd);
>               return false;
>           }
>       }
> @@ -140,11 +283,14 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
>       if (ret) {
>           /* Destroy old fs_hwpt if it's a replacement */
>           vtd_destroy_old_fs_hwpt(vtd_pce);
> +        vtd_destroy_old_fs_faultq(vtd_pce);
>           if (vtd_pe_pgtt_is_fst(pe)) {
>               vtd_pce->fs_hwpt_id = hwpt_id;
> +            vtd_setup_fs_faultq(vtd_pce, fault_id, fault_fd);
>           }
>       } else if (vtd_pe_pgtt_is_fst(pe)) {
>           iommufd_backend_free_id(hiodi->iommufd, hwpt_id);
> +        vtd_destroy_fs_faultq(vtd_hiod, fault_id, fault_fd);
>       }
>   
>       return ret;
> @@ -177,6 +323,7 @@ static bool vtd_device_detach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
>   
>       if (ret) {
>           vtd_destroy_old_fs_hwpt(vtd_pce);
> +        vtd_destroy_old_fs_faultq(vtd_pce);
>       }
>   
>       return ret;
> @@ -276,6 +423,7 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
>       vtd_pce->vtd_hiod = vtd_hiod;
>       vtd_pce->pasid = pasid;
>       vtd_pce->pasid_entry = *pe;
> +    vtd_pce->fault_fd = -1;
>       QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
>   
>       if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index a1a50d0910..dca726c9b8 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -77,6 +77,7 @@ vtd_reset_exit(void) ""
>   vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
>   vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
>   vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
> +vtd_prq_read_fault(uint32_t fault_id, uint32_t fault_fd, ssize_t bytes) "fault_id %d fault_fd %d ret: %zd"
>   
>   # amd_iommu.c
>   amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32


