Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19176CD5BB0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 09:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPztY-0004Uo-2f; Thu, 21 May 2026 05:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wPztW-0004US-0m
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:40:46 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wPztT-0007ty-Ng
 for qemu-devel@nongnu.org; Thu, 21 May 2026 05:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779356444; x=1810892444;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=x9ttqtd9kevL7mo94mfklYtn2dQrjDdSNAoX6KmwfH8=;
 b=ZDlfpzkd1xW2cyUrvsF33Y69BLcjBhv1/g2cBjzXunxLyFCXQVtGQsy5
 MGh292Djdw4t/vAY/PaNKp4eBTP6Eq5YIPOtG0xuN7oig6S0h/X6NlaEU
 P+dQy5otK/J85wIYsyWBKaH3lyzepHxhEC5Shic7lXlwlr5590lvnRC9V
 bmnBbhWsnfHjFa3n67nEfndx/9HY2jpWStV2KPoR4hUkUJZP0t25vEXIQ
 H72Uvr58HbAfG3fdYNxI6vv2MzlrBVbhVppynNrztbvqXq4/g+HJaDqH1
 MhBHrYPdeJZA8k3LR6cLw+rppOquUkRy7vph0tSOi6FzNB1Zptw7LDFk7 A==;
X-CSE-ConnectionGUID: kHryMrW9Qg6/PJQQDDU+Fg==
X-CSE-MsgGUID: IfaagX0CSlKcF/SIlcpSPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="90963688"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="90963688"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 02:40:40 -0700
X-CSE-ConnectionGUID: MD+9pOfpR6GCH5Wcs5iCdQ==
X-CSE-MsgGUID: rP36w+3ESy6+kXWVm07F9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; d="scan'208";a="245469334"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 02:40:40 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 02:40:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 21 May 2026 02:40:39 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.32) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 21 May 2026 02:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDehWREzSXvnW/kvn/YAB4IMNgk/PJRxvb+N8Aj8sigdq5CFuTrZwc0j0zXTjo+e5YjrseUhTfcrQlo3jtxNhR/nFQVlQEZDeJJ2jnBcPN9wjEQdNAP0CdJmcXZjwreW6aCF0am8IcfUQNFqdHOCXasxPheQnzmbB8j1D7/W6J+Gf1buRZAiHTKJ5EuBtjIHv+LZldjjrHCvxTuaui3RJkriMab0X/97j7rtjEqU4kPduOedBNwa9w0npaVch1/jWKhrTakfRJoBa9diz78TSWgSzuzMfYYz7UO7jknBVg3nmVfTSD09Lp2mQgSbJ2y9WB8phVNqRKn1n5K2R8FSXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLreY95UGWR9IQbQpe9VxeRVAcJRLolz0zbFkIvr7Xo=;
 b=PY8AEfCh8Eg69UbjJDMJONYtIBx+OpQ4hbOltT2FhdUVpQqdgZ54qAst1t6OsRZVpSOwk1n6P+a5eu4FiFWPHfZsS/DHBaJ5YYD1KDfsutYUNQu8epO6J90mXSHgp6IQZw7C3e/N1oYRxFjcfZP/yhTVt2efDcfUHwB3xDjwx6Ug1uILfJ8NFI32qqFvZ4jRthi223JdWBeAmTkm5k9F+iWR/NloTYJ042ZODNheog+iFC1ohOdJZ1MGZckmNLaaue2gJsaPCaB4CnwYWYkPV4h1jEgqubI5/GqN2CA0lmQiu79bZPvNSvwr8ZEuhsu3QL4xwkPmLTH8d1G4o623NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by PH7PR11MB7431.namprd11.prod.outlook.com (2603:10b6:510:273::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Thu, 21 May
 2026 09:40:36 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 09:40:36 +0000
Message-ID: <c95ff720-d821-40d7-a091-a909394f58a2@intel.com>
Date: Thu, 21 May 2026 17:48:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] backends/iommufd: Introduce
 iommufd_backend_alloc_faultq
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260327025228.474257-1-zhenzhong.duan@intel.com>
 <20260327025228.474257-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260327025228.474257-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:295::16) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|PH7PR11MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e393223-78c9-46b6-6fd1-08deb71d02a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|42112799006|22082099003|18002099003|56012099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: vP+4ckjm6+clum3iM5TNMvBJPOF/QKsZTBR7dKa7DThn18SHgrd6BRkxG5StgTGxJBuDjPXLeSo45ywytmt30XzcAOnZWlroAyjauUt+H+TDtdzDs4X2PJYaL3jdkK8YBSiD/jsMBZZ1IywmcQ2V8xLK20idwZZzrMU5K/SfZ67vo0yd8gmw4phGLwtpXhyJoaNUPfH9PsAe6tKhz7JyeNL8GI5QSTvmbXB1srBWHImci6WYyiiLMEbeKJLRJ4m6QAWKiJoYWmKTfKaPLf+/fcHPpJPeY16wa138EqbcIFqUPNbgLA8dEsbjLDNtUToMp51sC9cx73B9PNwm9FrpmeJH4PKbRpvWLvIuOo8UdX4Af6qdhWPpuzvx4P9Y7OUj99Npe8hYpAuVKL7kwm1MyJ9KvD4W0LcqDKvhR8wyLNBAwI4+MP88K1tjUtf5abfiRVv6fIjMYFmROXb0m6sXGSvN78po9VRu0C2VH+u+njkc1ClnW+OSU7XQRykGevLDX9+woHfcsuOeMBEI2WNcov0ZC1YcKZw6Xa/qPC++mFp0qub/BmpABxThdZDxtYU0BB/fjMTo1F3vrD0m8WuRDYlecqO3GMQuAfbtoKMNtSTPqybsEPxTyg52bMsO+UcoQzEbdcvkMCMe1Yp5txnGQJJai+5eoPkz4bD6g0SiSh5xFx2ipzFj4iTOjvvMWreg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(42112799006)(22082099003)(18002099003)(56012099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUc2Z2xGNkc0KzdWdmF6NzM1dGxWK3EyWmcrRVBSTXhWaSsvY2wwTklUb3Qv?=
 =?utf-8?B?TWZyZEJLNUdaYkZwYlMzMjFFZjdIK1ZZVElXblBjLy9HMnR6Tng1d1YrTkJi?=
 =?utf-8?B?Y2RiMDFwMUFGZXVYa1ZpQjgrYXZoN1ZSL2U0UzlFVTQ3OGNNczBRM1VLOWUw?=
 =?utf-8?B?N2w2NDNYZGsybGNMSFc0WmJ5SjhiTnlKcVZUMkFndCtqZmNmTkg2MlFVQjA3?=
 =?utf-8?B?NWEvVkJ5aXpsUGp4elEyTnNsU1pRSkd2R2VjNUlGSGlDSzNDc3hpOTNUdnpS?=
 =?utf-8?B?Z2hpSy9TbkVMWGhkK1hrQllDVFgzYkNEU3RnWE14NTFrMnllUGpncmdvaFpE?=
 =?utf-8?B?dDJWR3ZBbWdhRlpIbVZjb1g0S0N1T2s4bEIvYS9aSFhIRGdrUmFzd21zcVI3?=
 =?utf-8?B?Qmh6ZWlDbnIxWjVTZFc5T1dNallvdnZoeTUvWXQ1bEJvZ3BvQ0dCWk9pSlVH?=
 =?utf-8?B?d2hvMmJzSEN1M0VHdE9QZnBKb3U3VmtDZ3F0UjBmVGNoYnNyZjVrcFppUmdN?=
 =?utf-8?B?NzJRM0FCa2trbnhQZFlObkRJNkxyK284SzAvYkhFb1dham9GNmpFV01BWjJD?=
 =?utf-8?B?T0ZqZVluL0EyNGFtTDV2MlkxaldzVXplaUJzbVlpOUt5aEU0WkZEemlXTFdG?=
 =?utf-8?B?RkF2RVl0RDByTlRKckd6MEt0UDlxa3pkYVZQRnp2cXpCMkVScDIzcmNKeHpX?=
 =?utf-8?B?TUdmWHRUR01VWExWcGlGMHpUd1dFbFpkSjZkeU9iZlh1MDRWemllY3NLMi9S?=
 =?utf-8?B?MWZQOURUbFdrSm5IQ0RGRStlOUNSeVoxN2Uvd3dCMzhoMGlONVpPQU9ReUJa?=
 =?utf-8?B?M094SmtPdStFSzNwcUE0UWF1Q1A2VjdvaFN1KzRrY3lydmptOU01UHlaQ3dZ?=
 =?utf-8?B?MHg5UlZ3ZkpvSHExWkNmMVowQ3NuRFBLN2hmMWJWVDJzTS8vSGd6MWM3VVFR?=
 =?utf-8?B?TC9sS2V6V2ZKRDJuMzhCbG5rRGpMMERzT3Qrcmo0QmVFWkVoUmphYVVLZVpa?=
 =?utf-8?B?TFQyYzJ4bU4wTFRhWDV5Rk0yTUJoM244UG5rWTNHVVIyMHhqbTlJS0s1QVhs?=
 =?utf-8?B?YzlGbmhHMUlKUFVkTVJGdjNqdjh6d0lmd1BDL09aOW1PNGdnZWx6RjJHMHhH?=
 =?utf-8?B?NXczV1EzZ002eEc2MDI0NWZhZHlFT0U0T1Yzb3h3TEZZaU5ZWUNsVyt2S0ll?=
 =?utf-8?B?dDZubmprVC9UTnRaMUNmY00rRTRUclpBK1pkV3d6K1Y0L2hYRTE5bGZ0VTNV?=
 =?utf-8?B?ODFYZ3haWlJlMHprd0I5OSt2aUhiSk1sdElSYUtCSGpiL1cxbEVvcGx1RmZ6?=
 =?utf-8?B?V0xqZ3lmSjRmZmduRXNOa3dxUW5aeGVHZUxxUFRYcFRkWTdSMGRWVHpuRDU2?=
 =?utf-8?B?K0l1TncyRCs4T2Jydk55QVo4U2xaZ09ZempaaEVKNFFFNXg0YkhNMUdQczhH?=
 =?utf-8?B?Tk9sclZzcmc3RHhPRUhsKzlPazFEUytBVXJDU3cvYXVQajVhdGFYSWFCdlg3?=
 =?utf-8?B?WUVPdzB6SE1vRkVvVWJPTE9DV0k1WlBXS3FDYW1Fb29Oak04bHdpeGZuaFRn?=
 =?utf-8?B?WXFvNThTKysrV203dW12TTNJYkxXUVFtQWx4aDJYYU1VYTc1dXV1aWdkSlU3?=
 =?utf-8?B?RllOL0xKTzNUelYzY1dpb0tRUWZhYzBNZ1RST09jdS9QTFQ5aWoxSUdBQUU4?=
 =?utf-8?B?eDgxRjZ6cHd6Um5rdmVjRGltdWQvK1BOb0ZJYjJwVFFvM1BWWHhmaDNTSUky?=
 =?utf-8?B?N3NBU0Jwa0xSRmJwUkRQdG5XSVlSNm5rTE1yQStNM3F3YjloaE9ORG5jVFBl?=
 =?utf-8?B?RTFPeStEQlhYaDZGbzA4MFN6VlpoOHRYS2xic0ZmdStxOFFWSXhLck9QanJP?=
 =?utf-8?B?aXlvVlFrd29kWHhlVDVuUXo3K0tsNGE4a1FXaGZJUU9TSjgyaFI4YnVsYS9j?=
 =?utf-8?B?blJWRGhyalJzQ292ZC9WUE1CMTZLMlZkd2p2RUM3WUpHV2VqOXlRUHQ4UGJ6?=
 =?utf-8?B?Sk9tTDRCdVl6MGtMSkJQc2VkRFNPcTFUbXZ5R1U2RDMrRFVCL1pBbkVvc2lh?=
 =?utf-8?B?TG81aEdtckJsTUNtZXdtd0hHVElDOTlTLy9JdjM4SHlLWWQxVkkycmYwcG4w?=
 =?utf-8?B?ZkdvZXo0Rm5DTW53UU9rQWZmczJzUHhwMENua2NMQ2lsOGtRZkZuZGlyd2lJ?=
 =?utf-8?B?dnVxbVZGTzZXM1NoZ0lpcm5EZFRzOTg5MGRPemx3OEprMEFKalY3ejdtZlJ6?=
 =?utf-8?B?eGZ0TDJ4TVdRS0RWWWVBRGRmZzB2Slg4YXJCZkM4cWIwZER3bDc4ODVtSzRa?=
 =?utf-8?B?TkZvVGY0QzlpL3ZaT0pSS2JRKzJZQ3htM3lUb09oZzZwalNZaHJGUT09?=
X-Exchange-RoutingPolicyChecked: b2AgiQ1eibBF+ACjz2e6SCpyfDABz4UtrfjjnbwxnxbJJK3NN54GflmrrkjJ9j74iggm1urQudYnqrnRutQolokDA7vLnvR0R5rJTSQN9Opsj7WHPciMOsW1shcMYBch5LssQNvQsNl32Nmod11F6eRZ5lD2xaxlvC5o7mUXMuxoocPp7L+qbL9Mydwd8HggGVxtZjE3zsJ8yO5sOs4yjQIJ2yv+qcciK96PCvNeXdgokR2Yhoo6qTpdF/xzLUS+3jfyqSgzeoV3bk//cs87GaRh6Mi51EjObdC4DS2K9L3tCZ9wlrJgKOxpq8GA2GpC07f46LbOe42ed4FOKfwpkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e393223-78c9-46b6-6fd1-08deb71d02a4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 09:40:36.2658 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/vi5IFoE5s8B9vdBXRZo5iI9fJqK4eveTMCFVPy51lHXHQxlwbTq1uVpoTzqOFF0Zx8O4UdwF305Ner9Mwmvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7431
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 3/27/26 10:52, Zhenzhong Duan wrote:
> Add a new helper for IOMMU_FAULT_QUEUE_ALLOC ioctl to allocate a fault
> handling object which will be used in hwpt allocation.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/system/iommufd.h |  3 +++
>   backends/iommufd.c       | 21 +++++++++++++++++++++
>   backends/trace-events    |  1 +
>   3 files changed, 25 insertions(+)
> 
> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
> index 45a9e87cb0..d4ba8434a5 100644
> --- a/include/system/iommufd.h
> +++ b/include/system/iommufd.h
> @@ -100,6 +100,9 @@ bool iommufd_backend_alloc_veventq(IOMMUFDBackend *be, uint32_t viommu_id,
>                                      uint32_t *out_veventq_id,
>                                      uint32_t *out_veventq_fd, Error **errp);
>   
> +bool iommufd_backend_alloc_faultq(IOMMUFDBackend *be, uint32_t *fault_id,
> +                                  uint32_t *fault_fd, Error **errp);
> +
>   bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>                                           bool start, Error **errp);
>   bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index ab612e4874..9496377a25 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -337,6 +337,27 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>       return true;
>   }
>   
> +bool iommufd_backend_alloc_faultq(IOMMUFDBackend *be, uint32_t *fault_id,
> +                                  uint32_t *fault_fd, Error **errp)

how about using int *fault_fd? I know the uapi returns __u32, but we
anyhow need to have a conversion to int. If so, we may do it in this
helper.

> +{
> +    int ret, fd = be->fd;
> +    struct iommu_fault_alloc cmd = {
> +        .size = sizeof(cmd),
> +    };
> +
> +    ret = ioctl(fd, IOMMU_FAULT_QUEUE_ALLOC, &cmd);
> +    trace_iommufd_backend_alloc_faultq(fd, cmd.out_fault_id, cmd.out_fault_fd,
> +                                       ret);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "Failed to allocate fault queue");
> +        return false;
> +    }
> +
> +    *fault_id = cmd.out_fault_id;
> +    *fault_fd = cmd.out_fault_fd;
> +    return true;
> +}
> +
>   bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
>                                           uint32_t hwpt_id, bool start,
>                                           Error **errp)
> diff --git a/backends/trace-events b/backends/trace-events
> index b9365113e7..6820a9939e 100644
> --- a/backends/trace-events
> +++ b/backends/trace-events
> @@ -17,6 +17,7 @@ iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, u
>   iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>   iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
> +iommufd_backend_alloc_faultq(int iommufd, uint32_t fault_id, uint32_t fault_fd, int ret) " iommufd=%d fault_id=%d fault_fd=%d (%d)"
>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>   iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
>   iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"


