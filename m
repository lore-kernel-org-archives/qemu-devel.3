Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D94D7103E168
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 12:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2pgY-00027p-4s; Wed, 18 Mar 2026 08:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2pgV-00027V-Sw; Wed, 18 Mar 2026 08:07:35 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w2pgS-00079B-9s; Wed, 18 Mar 2026 08:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773835652; x=1805371652;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=p3wl6R+m005uwEjAXYBva4FzbUpKzKrqG7V03moB9rg=;
 b=QvSf4UPWEO+HROVYJB5jezJEou734+QOn+zjOKWsuesbBx/tnwwvF5Pf
 E1scIbr7quJAWlxMYrufRFcfCcY099TUJma5+O4u0H9KitD3+i9Io5Sfb
 5PwyVZZfC/HY2tU1VAeYs5H9AwSipCT4pn+OQnrTdg8iGzZ62rEpSNrq9
 JmAdQ0E2k/gNHt8V2V/jYTbs82wEt41rcDk7x+9SXHo8UzyiYIRc3ymWZ
 0pxDL1RKhSnuRFB0j6yqGx/mCTXbx+Qr/lnIl3T8Pg7X7ZGPDGPQc9kTh
 vRAkGng15T11g3u7kTJrcgTGex5dDGtOjzPrzodlXD/gz1MvC4rhh2n8H Q==;
X-CSE-ConnectionGUID: KQ04lsKPRMiUQe1+c2q6sw==
X-CSE-MsgGUID: FXUjXB06R4uA15tSZlu7Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="86360124"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="86360124"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 05:07:28 -0700
X-CSE-ConnectionGUID: AKtPF2MuTLy7NWNppS0bjA==
X-CSE-MsgGUID: hyvE/8FMS/yDlYGwMwSIyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="218187994"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 05:07:28 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 05:07:27 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 18 Mar 2026 05:07:27 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.68) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 18 Mar 2026 05:07:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzrFyMMYoPGLCDKJ/EChc6/BDnC9SgHBGVucYmZzVRFErBgBq6q7SK38xelX8qn738v3YdnkoBuJ/lxflNdhA7EYh3hi1iy7kPaxv9jsR1fR//jnzlAq8h77dc5z41LdkJarvCfzqpMc7WhKIGYEJZGIEq3yWEbbyE7Xra1yC1ippFUx4VRSmiXmB1v6/uVf/JrPSQPHCpFyYb0OA5hDtRDNqgkEcIzptjC1UrX8bVb9gApMxLsn03cpW0y44dvovvT3da0IS2jsO2aAx7SR8RWNi5DE92pIyhmwUvi3A61p5BGCAXQP12LPlGzmM3gPExeZDfhXsI/3uonR8EWOhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBpTeCRCK2LAYn/z9TW5fXHcey7Z5TXiavB8lMoNwoU=;
 b=mxnJh44SjI2flwsdEO8wIl+esR8cUi3ZqrqLeTR5j8CUV2Di1CT3072yyS0+VQgGlGY2Yq/JRCcsve4zAGfdX1VaC9ez7o8R2I+KCIC2UalOfh9Lagju+dF+TfKF+ZBE7dEs4/4wNRhZ5sXM3hrtHLytu9GhdOjbwWPx1S5mUIJGhKdFw3Gc2O8O1O37yfweRDx/D/CCxIMfwrjz1UfmxVyV7ptryQ38Bc0hepQv7j8w7F+sRL6Dw2El3NBHLkk04gIPEyCB/2fifTrS3fcifadHLt+BPT4l0hpHswZwzVgqeqPTDKX34Kypy5O0QbtXAOAkKVP1NakpKowiDeHutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by PH0PR11MB5207.namprd11.prod.outlook.com (2603:10b6:510:32::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 12:07:23 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 12:07:23 +0000
Message-ID: <8954d521-64c5-4495-a3cd-dd2ceb4c26ad@intel.com>
Date: Wed, 18 Mar 2026 20:15:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/13] iommufd: Extend attach/detach_hwpt callbacks to
 support pasid
From: Yi Liu <yi.l.liu@intel.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>, <qemu-arm@nongnu.org>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-3-zhenzhong.duan@intel.com>
 <5bd68a1d-ee61-4ef6-92b4-f893373250a0@intel.com>
Content-Language: en-US
In-Reply-To: <5bd68a1d-ee61-4ef6-92b4-f893373250a0@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0037.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::9)
 To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|PH0PR11MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: ffdb2321-682b-44bc-f353-08de84e6e98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|42112799006|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: HDuXeU2fhXYO9GlNdFMyV+rSq8SNhHohyQJxAgdN/I1I9vMjWSmRsxP6lE0rA7wqIk3pwGHxrMWUmfKuPNPkOdJuQugi6KzAKTY4S6uCpNK0ceakAVdtTdJ2x7m62Mt8zlfEstGKHBfBaSm0BoRFNHIqmiUvTS78pWdjwknODNQESZD+EmOayQxy9q0jZh7bv65D8HSiHaXn25XWvrXjLn3vj4fzJg7qeAJt1SxGyYTFZCtl2EPs5mFHXKl7y8uGQ4PCURlEnraIeMOabsaHQrLvdc3dJ4URWINww91An588dtPnTwnMLl3Nxaj5yzPOZl2yCpXxQzIRzP5cS6lRxDjHSX4FTLZtImSZd3YjMpkihDUJH/QZJDdBtHQOJehULUapzXSFOHnQHnl9JmXi8OqS5D+kYrLsq1pYGJpuaIhXx1B58eJmMcRLqsRdaY0gpuoe0wUYg58HJ8ka2cYNgRyAvSdzCRzuNON4rRUhBfZsrC0YGNnefn/oTl6A5EhhRbKHL5K2ZtinlBJsJR4KL7pI0GUz527n7QyKx4rPvpc0A6YOTOxTGDm1Ztz4q/ofRNalLoG65f0xVjSI150eFyViIAWgu5KTi+3JYxc0hSSsR02V/paX2VE+1zN3/1fJmwMsxE4G+xZBItewBaAcFxi7FLysUYVjJ5zwbeQL1ZcPTmbCQWosZG7wGd0JePjMuktZPWoRrgULYnZp3k0IQgeTmFzvwKWyXbDKW/at7GQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(42112799006)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHp1M0srRUtRQzArdkFiT3VVbXhnVG9jYVFOYmRiVzV4ekdQNUVXYWNnaGsw?=
 =?utf-8?B?b3haSm42bEVIL2pVQTZEWEt6M292aTF5c2xTNUI2Y0lEWkZlVk5TS0RqODQz?=
 =?utf-8?B?ZGhEZ3VyUjhVaExwS29vQjdDNTYwbHBVR2tHNEwrQnBvL3pEK0x2Ym5kOFFw?=
 =?utf-8?B?YW1jTmlQeWxSZjZEdlZUbHdkVEE3SGRKaHNXcUZPSndZMkptRGtIR3dwK0V4?=
 =?utf-8?B?eGJ1b1ZLT2xZNXRlK25EbWIydktONG1NL2NTVVkxOUZ4dEg0d0g0NmRjMzQy?=
 =?utf-8?B?anNXME1jcGl6aElDbSsvWWRtRk9mTHdnV3ZlZ1NZZTVQOXR1TFFJRFQzaiti?=
 =?utf-8?B?U2hBeHRIQ2REN01vcUpEMWZXQzExdnFPUXdXSXFoRWZmdkg1NHl1dVlUamts?=
 =?utf-8?B?Zml2a3N2aGtqYXZQWmxacElJclhxcklJSFhYaGxtMkRwbTNjWVYwWnhOL0hz?=
 =?utf-8?B?dHRmT3lIYzl2VzVaclc4bHg2UFd1NG1lbVFHTzhwMnUrc1VEc210VGo3MWd0?=
 =?utf-8?B?aVNiby9ucnVUTUFZbVZnUXNqS2RrazdENEZHc1htTlRnUExDTVl5WlRtOEdR?=
 =?utf-8?B?eWdsUWVRcTB1UzBFYjNFRHYreHNjeGxIV1dtK3hjM0dOOGU3aXdrbTlFUFBu?=
 =?utf-8?B?a3A3ZUNyUEtKS0FnaU1VV3VVbjBzSXl0YXhTSWcxdW1jQkg1RWtxVlVJZVZS?=
 =?utf-8?B?NXIxeW1Sam5YR01kWitDYTN3NkZzdmtlN0JFdllDdEFUalJ3VWxrb0xQL3NQ?=
 =?utf-8?B?OG9xL2N0VTNQY1JlQW90c0dCOGJaSG96cTcwZXdsMVBDbk1YTVZrUHhNRk1k?=
 =?utf-8?B?VHBjZTNNTkx3NmJFVDk4eStEMDE3L2JDRGpMSUNjeUoxeUxZOFNaL2xIZXZp?=
 =?utf-8?B?R0xGZmZSRjVhOGc5Y2NYYmZiZndHS2YvRm0xb2ZXcWN4OWQzNDYweERmcWJj?=
 =?utf-8?B?NlZUMlIzYzZxbUxNenkwK29qc1lkek1WZDBpbzdmaEFhYjJBci8yaUNBbFZt?=
 =?utf-8?B?TWhSZXdIUFp2SzRJazIvVzJ0NnBaUE8rUTJMOGIrZUpVT2J2UWtPT3EyOUZz?=
 =?utf-8?B?enFESDkwbkR5T0JWUUFjWmp6RDBPV0VqVk0rejVYWCsweEhHR1pRRDNlS3hK?=
 =?utf-8?B?MXdKTmVKYVVmS0tHM0Fmdlp1VVRXTlppVzFzOEFucFoyVitXNGVOQ0t4TFND?=
 =?utf-8?B?Z2V0UDkvMWZlYU0wMG1LdDB0WFVIdjhQYnhqQkNKY3BERkpMR0N0SlZ0SlBr?=
 =?utf-8?B?WUk1OTZGdWl1WlU0YkVLV2d5Qm1UQ092MlVVZlRxU3ZMcGVUQTVWWnUzQng0?=
 =?utf-8?B?bm4waEd0VTZWSzNsNE9rMklETlVrdDdWbGpVS3MydnFZbUVrNnJhbjNOUnVx?=
 =?utf-8?B?MWVHQlB6ZFR6ZDliNmxUMEpzbC8rSWdoblIvM2lDTlZKRlIwbFdEd1dJa2dR?=
 =?utf-8?B?aTRNZWVkTVpGZjRsNkI0V0p6dW5OQktTaGg5Z2IvNEduM2NnR1gxSkVMZml6?=
 =?utf-8?B?ZzMrSWJmdEtDY1JqZVdWamRNNzhGMUNQcDBldlJGQ2JHOFFyd2MvRkFqZXE4?=
 =?utf-8?B?WFZ6a2VqdDlmbkVKT2xEdzVzdlJ3bVpUQjFDaDdVcnFaV1hZQ0FnajFBd2lJ?=
 =?utf-8?B?SUt0dUgySVRDVW05ampHWlB4R3FoV21TUHZVK0lRWVRVSnovYnRFdzRYTU9h?=
 =?utf-8?B?UUQ2RnI0UGRHOFUxY0Nvb2hJb25aOUpFR01WZUZwYnhrbkxaQVhaWVFzRHlJ?=
 =?utf-8?B?bWlNWGxQQU1uMHR0TjJ0bUFPVzU4d0hHK2NKVmlENlU5VVBqVE5STnBkTk1G?=
 =?utf-8?B?Rit6MThSMmdHTE9zZHp5RjJNcUhoSHdwdktCV1EvRVZ6MG5yZGR6SFliTS9Z?=
 =?utf-8?B?M3Z2VGtUMlVjVCsvcTB5a200azh1S2FzYk5sbklsbkptRXZlQjBLRmZQZjVS?=
 =?utf-8?B?RUZieXNiMmlLUlhjaFc1MHBnazljZzJ6NVNuWmt5NS9TMzZqZFFsUnlpM1Bq?=
 =?utf-8?B?TnhJR1Q2YnRFYTgvSDZyaEdXS1RzckF4WHd2MzJOM04xdTduRk5ZekQ2aElI?=
 =?utf-8?B?c2ZMLytBUG9iZkVhajNnVGgxamVEZExzc3gzdmtZcEs2UTVpM2pDR2ZpVUht?=
 =?utf-8?B?L213U3pWdVRISHBxZjBnNVliV1hpbHpMVjJ6UHBwaGh3NGhuR3ZoM05EY0Vi?=
 =?utf-8?B?UkdrYTBKY2lram5yU0dsdUxwUCs0eVZnMmRCSXdZb29RWlI4NXpxMUh1SFpZ?=
 =?utf-8?B?NHdrUitIOG5GbE9BQ0ttUFVjRmVLbW5CVXk5TFYzSHJ6UXYrT1BGM0hRY1hv?=
 =?utf-8?B?TXBqT2N6bzJwZWdRM3NLekVqUFJHcGF2YzRLMW1PemtMQmkzLzh2dz09?=
X-Exchange-RoutingPolicyChecked: liS0jV76XSrnpsW7CzyhcgRhWV3iUkrnLIpcM4rubrHXNCFH6nB2nniQDonJ3lJ1kvS7MloEqGQcJR2I1F0As6YtNqzuqWfmNsa1r/ZuBMImATqFT1Q8Y/8d5qqyUu9ICYTtKK5h8EKrR6KjizqMDaINUyg7fcFeV1aOV+oNNdM60ITls4rUVdZbIYv+67aoHoV0WN33JZa/3RbNK5dSqEcF0TaUo1huW5pL1UpCayxztbteqLMGAKEA8KgqFHuALqQYVrbhpjx70EmiDGMw6qMSkIVCANk94zAgDlciyC42Pi/dMB3i2tPzE47rQDg91f7wY+HaRZ7BpSTV+KSpag==
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdb2321-682b-44bc-f353-08de84e6e98b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 12:07:23.2667 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+EH3bXFYfg8SQ7fQUZhrwImrUiVWzx3CrkdVyQ34LI6WRLIgsudzJFVkucwYtXYQcBXjr2iO0oNHSd1xk81pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5207
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

On 3/18/26 20:03, Yi Liu wrote:
> On 3/6/26 11:43, Zhenzhong Duan wrote:
>> Same for the two wrappers and their call sites.
>>
>> Suggested-by: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
>> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   include/system/iommufd.h    | 16 +++++++++++-----
>>   backends/iommufd.c          |  9 +++++----
>>   hw/arm/smmuv3-accel.c       | 12 ++++++++----
>>   hw/i386/intel_iommu_accel.c |  8 +++++---
>>   hw/vfio/iommufd.c           | 10 +++++-----
>>   5 files changed, 34 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>> index 80d72469a9..80c8423654 100644
>> --- a/include/system/iommufd.h
>> +++ b/include/system/iommufd.h
>> @@ -124,14 +124,16 @@ struct HostIOMMUDeviceIOMMUFDClass {
>>        *
>>        * @idev: host IOMMU device backed by IOMMUFD backend.
>>        *
>> +     * @pasid: pasid of host IOMMU device.
> 
> this comment is a bit misleading although I know what you mean. Perhaps
> "pasid of AS" or "target pasid of attach". Other parts LGTM.
> 

Reviewed-by: Yi Liu <yi.l.liu@intel.com>


