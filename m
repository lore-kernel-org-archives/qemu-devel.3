Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28287CD5BD2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 03:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS4ix-00069T-EL; Tue, 26 May 2026 23:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1wS4iv-00069I-IB
 for qemu-devel@nongnu.org; Tue, 26 May 2026 23:14:25 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1wS4it-0000ko-20
 for qemu-devel@nongnu.org; Tue, 26 May 2026 23:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779851663; x=1811387663;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5Iq9HK4Zc9CrgAYVGsg4Hw3n1PqK1X9TutbjBpF8tMU=;
 b=jLbkl75bLYOTYY1XztvpE/XC5lJGfA+zV37NonkxkzJfq/k3H1oovVht
 zgGchULRHLW1HeEtDa1FUKtCrm9eaGuT07v364+qSAM6HO97aXsxZJCFX
 GmI1Ycw9pMqfXduZecHVDtlBbkEMQqVPyVL1fg6rKPJ//NVE2rWl3N7kK
 +6JT0BgoxST/vsTjl2FSg4I+HyWAQsQdxSd0ofbFppW8jzwJ6jeuO1JES
 m6gOWUd4h6PSY5r7/thPqLXXFqUtOCylXhB+Lk29ci/YfWC6mRHzKKsUQ
 IYP328zDMOiLqdCEuqb1m1gKcR0yHWvB5GaP30MqvANz2CpwO9410v9zQ g==;
X-CSE-ConnectionGUID: 5q7AtET7QJSi6WGP/2yezw==
X-CSE-MsgGUID: ++3VNsmMRoGK/aHtnHshpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="98251711"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="98251711"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 20:14:18 -0700
X-CSE-ConnectionGUID: TvtCO5eEQfqDDRR29TE1oQ==
X-CSE-MsgGUID: dIfnOyMJT/OjwF70o+jmXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="272439895"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 20:14:18 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 20:14:17 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 20:14:17 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 20:14:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cnxAt/MzYte+yZzwHNDhXewoHmHEeGYZbfBo9vQb3WsXog9qaCWse06HSHMK+u62uFhGCq9nKClOGoRfcqX5yHttOZ4bUV+h39XdVGetzgdkjoq5PBs4I9nDUgjCcEb5ocBacmD3JzoAOZRtRiE7GjTFDWfky0zY/YyFzg5uElImpNAMJ3N6ETHdDatqTTBSwqcvZnidJ6eihoJfgBTZkdE7DEDugHp/xO/V2ggpjY9fmJsYQjEOJvunw6dm+GY/KmeC6ELKKnTYsvqotoy+B3iJGlFa/D9dlB558LUogklY2jdOo7AlIN9wo5y9W7Sqc9sRLNzJQAlmGObEWHcNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3uyYNNUn+muxF9pi7PGxuL0kM3cf0pnqm6KyZ+s/8g=;
 b=jOWXOjPpKByO9Rnp7SKGaiuGYOvcClrzAsBbwLhahkx6N8dCrPvc2TX8bt2OunwpJDFnd5jLx+2IUD1Zy2VB4BNMZyVuntA5tTeeYE7SlS/lWu//JbJdLZnL6502Azh9KxUyh9NA4ScdSJqXvJchRPN7nOSjOfZoKjbnansJA+y7NFlDbRs+ElEMIcWjgslGt/wL8j9fFg9lg4q5JK1qg0NNRepkDL54EG8X0gbvnwMQr31DWgHVZvQ4LSPBHXv5cAtbauZ3vhkmItTnruarBHKGYtYz0GLidIuiD9lfvbIvDWhb586TOKVIJjcjVUkCGaUcbd/6d97pO0jL8HJoTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM3PR11MB8735.namprd11.prod.outlook.com (2603:10b6:0:4b::20) by
 SJ0PR11MB7156.namprd11.prod.outlook.com (2603:10b6:a03:48d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.11; Wed, 27 May 2026 03:14:14 +0000
Received: from DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675]) by DM3PR11MB8735.namprd11.prod.outlook.com
 ([fe80::8f1e:49f4:122c:c675%7]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 03:14:14 +0000
Message-ID: <e2d56d20-1d58-42e9-8c6e-6d6b9167d7cb@intel.com>
Date: Wed, 27 May 2026 11:14:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: Restrict dma_map_file() to shared RAM
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, <qemu-devel@nongnu.org>
CC: Alex Williamson <alex@shazbot.org>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, Farrah Chen <farrah.chen@intel.com>
References: <20260519055756.70575-1-chenyi.qiang@intel.com>
 <03ca3a6a-5545-4410-9c0b-dbbc106bff98@redhat.com>
Content-Language: en-US
From: Chenyi Qiang <chenyi.qiang@intel.com>
In-Reply-To: <03ca3a6a-5545-4410-9c0b-dbbc106bff98@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0032.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::13) To DM3PR11MB8735.namprd11.prod.outlook.com
 (2603:10b6:0:4b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR11MB8735:EE_|SJ0PR11MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a8da52c-10e5-4ea4-911d-08debb9e07ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: jVqxeRgd18K509ZXpXnwai+n5tfQAcDGxDhry9NwbMmB4tAzNIwcBMgPnkKPh164aMxTq4zRZCJ6TAhIjPzyjFrsT9SititO9SDBY9xDtyRDSr3Ao7bWddqgXQxPekVD2SJdspAB+ru4gkhygrvro3saide9lOgl0BZx1rvEH6jHLgz8yl+cYRJDZEzS0+g52/x5Z5Vo6FH47BGmOtgdYqORiUJYdHQQHW5S6VK5aXU6XPsIjbNX8gHyTSIFD8P0MpAD2dt8Sp1IvjKvkHjn1OpRekoWBYXFMqKnENfg/2vNZ9YO/TE5oR3/TODu4vRkEym37iRJGvGTxMqtdcPJN2rmVnbHQzubZsp3hgQTDUCNX9S4lXCRdKK0+KU+prIfWoUB2UYALuuiLcdqbbjrYYVJvQWvTi9wdbQjpgOJ7U+6IkoSILqqLLdgfec2NZxU17hrNopUhTSi2iZ/6A4FZS/ZJXYFpwENpel+ZkdhFKLs0Wp6OE7Dsl7ArJ4zOufrG8M1Z5cJ8kz37Hwf0umBC0izfqyjOs9qYdebvNCEMlZIpvQOhuOVjFcw7oGBM/0LxaS/hPEqmcXBGvGQidfyLR0JrXoHhuak7DIiudoxknbVIxGzqvAoOsRQLskPEbk29PvO7E/8sIXpmbuI9rQShYodWQJqMnoc+ve+im8YTj8zXZJPrV90e3+hXlG133MW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR11MB8735.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG9NejlaS2pHYWhSOHNONWZMNFNhSFhyWEtQSFZ4Y2NnZHQ2US8vR09RN0RR?=
 =?utf-8?B?bytkRjkyUmErV0MrRGpvVW1ZR1BVMjZRMFlrVGpsODd5M2h1N1cwWmZnVXdY?=
 =?utf-8?B?aGFWU05vVjczSjBnL2p0RWxVWWFhZGtGd2l0LzVQYVprdmZyYWYvZDZlV21o?=
 =?utf-8?B?OFlnWUZIWVk4bDVsdjhBNVJlek8wTEkxVGplRHRtOHh1aGZ5LzZjZE44L2Yy?=
 =?utf-8?B?SWk2MmhmZHhwWjh2eFA5SWZuUHZTUnl2UyttTXJrclFwdDhqY1FaUVdSaVoy?=
 =?utf-8?B?bDc4MEdxZVhUdi90TjdJcnJEVG4xTTFZTXVXYTdTK2tERXNyeEF1Q3ovSDRC?=
 =?utf-8?B?ZEVIV1g5aXgyNUF4Uys3WU5RNUVHVGRBZWZubnpOTUV5YWdPMzV3eFZSUmNt?=
 =?utf-8?B?UTJZRzFNOWhibnpKWGxlK25sY3Q0YlpHNkZGMmxZYXVvdHFvd1U5WkorS1VN?=
 =?utf-8?B?S21PRVRPNEFkeEE0ZHozU3JRa0JvdCtYVjVZSGl3Q1RRZE9rUCtMVHNCREVB?=
 =?utf-8?B?YXV2dGhDcitLZExaeWpOOVI2ZXRxcHZtSFJ1MkVVNlpHSjJFUVRSQlBteEZs?=
 =?utf-8?B?M0FjM1IwcmpySTlNdEpWZkFHSHBmNVJxeFFkaitGV05rQm5oNUJEeXRURytL?=
 =?utf-8?B?KzNRNGY0eXR6Um55OHNnL0c2bzNxRkNKZmlBV2NsZzNKYWR2T0VkblRoNVNa?=
 =?utf-8?B?TFNmeEtnQkRlbXd2WWNQdGN6c0VTL1l5eGRzYWJ6ei9DSUFEcm9EZFRKdTVD?=
 =?utf-8?B?V3RXaWlpK28zQlY3b2ExeE1DcjRTWnN6U2pUVkFSVWpqVWFVcnZ4T0lJd3RK?=
 =?utf-8?B?K2hES1FNeGtNeU5UNmpoK0ZRMnF3a1BROURMM2FSSFc5SDk3Sno5dTI4SmY4?=
 =?utf-8?B?cDhTYzVVaDB0eTVBZWpXZndkL2c1STJKL25BMEJEdHpJUERFVWh3S1NVa2U5?=
 =?utf-8?B?R2YwVUkzSFF6M29tYlNZclA1MjI3SFkzWTRTNzI2ZWdhSjdNWjBNQ0Z2Rm9n?=
 =?utf-8?B?ZXhHSTFXektDY2YvNkJsQWIrQXljMUw5OVpabmN0TEE0aFZjSk4zNTExZk1D?=
 =?utf-8?B?LzZtQk5rcWp2dFNlRVREK2xQSE1NUnFPWlhlQzY4ejIxRXJyU1d0NXRpZk51?=
 =?utf-8?B?aFJwSGplOVp0eUNXUVgzNk9ZTkVBektESFB5RE5BZWJBdEJkTEx4UDdNaHc5?=
 =?utf-8?B?MS8wK0JEcnhoZ1c4U3lnUG5aSWdIM3lINXBRWFpQZnhPRG1UeEJXNENZMlpF?=
 =?utf-8?B?WEZDTmhmSU9ua2Z6NUlleTZ2aEFYQ2xUWXo2K1dHYnJpYlY5Sy80enRMayt6?=
 =?utf-8?B?OU41WUJuaktFdnlydXAvZEZLeG5aYkNYQUM4Y0ovYzc5clF0a0xWVWVZcisx?=
 =?utf-8?B?ZFpmT2t1dUxGS2NMbWZWcUwvWER6UmtiRDgwaHdwYWUrcU9lZW1aWEJ6OWJV?=
 =?utf-8?B?MzVzRmpId1JLMmtQYy9wcG83blE4eFdrMllHek0wam9pMXpKai9uS1pCVW9s?=
 =?utf-8?B?TmZLQ3lpZis2N2lIdjdYRkg2ZExIY3pZVlVyYlZ5NURYSVRwc1NFOEp6RjVD?=
 =?utf-8?B?UHB4M20rQ0c1OXZlNGRJRWZkZmFWS2Foenk0MFNCRXNpd2pOM0RrcTRZWStF?=
 =?utf-8?B?UWdwT0lONFVoVVVIbCtxc3BKQTZmaDdOQUFWYW1VLzJOdmdmc29jLzNIT2pC?=
 =?utf-8?B?OU8vVjdMVFhSVTV4ZnpqSXROS1A1bkFCY2s4KytrdE5Wd0czVmVCV09TMjlo?=
 =?utf-8?B?cnRrSkhDalIrZU13NWhockNuWlkvT1RzNEZYYTJRejJkYXhRV0VWaXcrNjZo?=
 =?utf-8?B?L2JFZWZGUFhZQ1RLL2VEWXpyTjQwSUpHRmZ0Y2lMdVM5bzJiT3o4RDdxeE5h?=
 =?utf-8?B?dVRObDA0UFZyZzdEMWVWR1FFUWNWd1pKZWNuQWdFa2hJc1RhNnExaERUMTJX?=
 =?utf-8?B?cnY3SE1UWnVZWTBkK05pazVFU012ZHFZZkNCWHY1emNNRVJFaXlVclltWllP?=
 =?utf-8?B?QXZ6NU5QbjlFUjVyaGFGUXlrMUk2ZnFJVkMzN0wzZ2R2QklhMWpRMklFSGFq?=
 =?utf-8?B?WnFDOWFTeTNzUnhWU2lYOHZJZ1dUTDRLU0oxT1hBTGpzQmlQaUxFU0M5NWxx?=
 =?utf-8?B?dHlHTHk1TG83VXQrb2o5NUl3ZmhTNzZGREhiN0thdy9JOGtyQksrSmthQ2tW?=
 =?utf-8?B?UnAxQXJjaStqS1FBbFp4bmZOZmxqNXlPV1NDRVV4eUd6UEFMNVlWNi9BV2pO?=
 =?utf-8?B?M3ZzYUdZNkx4QkxnVWtFc1hKYWxKL1BWc0hOSDdJVmhwYmg0SXB3VUh1aGZu?=
 =?utf-8?B?Ui9HUk5hN1VZNndMMys0bmJmbk16NHo3Rm8vZzdGWlFsQ2g2azlDZz09?=
X-Exchange-RoutingPolicyChecked: JOnyZ94N5kToM1DcEZ6bqmqBx8wCBv/+1P3Jlxse7wYj6ahK6eFwsfXD/CfdFv6Po9vTuFFapFxCVa4Qw7+3pO+Tp/alZsyg9yf8bn0rQL5dvOwzyIyP8C/MjkJRLOE4J6hUYrg88prSBmzVRVfNpL5s5c+l7n5++SvWNxICiGHlmYsPteJlM1ufYBC8tWodCWQv2dqdoJhX49/KbzaCv9E8eB4dofLLG1fDHbHLAwtzmJppEZKgMOpl2W/zh1AZFpkFKB7QcI6I9xTpSqivzfZUd3KjF2+HORn/gRNnYL5JE6okU00tlFGsElgiDliPp7TxbQumRmuj2JoOqFQ1EQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8da52c-10e5-4ea4-911d-08debb9e07ad
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8735.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 03:14:14.5645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwNqwfI924tCTz2yBh2a95X/NNY9u+g+SlnVSPvZjWT6h0ivtaazvO8mlCX1IRShhiM5T76VeiTlzvwSBVMs2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7156
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
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



On 5/27/2026 3:44 AM, Cédric Le Goater wrote:
> Hello Chenyi,
> 
> 
> On 5/19/26 07:57, Chenyi Qiang wrote:
>> vfio_container_dma_map() uses dma_map_file() whenever a RAMBlock has an
>> fd and the VFIO IOMMU backend supports file-based DMA mapping. That is
>> not correct for private file-backed RAM.
>>
>> dma_map_file() resolves PFNs from the backing file, but private
>> mappings can run on different PFNs than the file itself. As a result,
>> using dma_map_file() on a private RAMBlock can program DMA against pages
>> that do not back QEMU's actual guest memory.
>>
>> This was observed with hugetlbfs-backed guest memory and iommufd/VFIO:
>> share=on works, while share=off can fault because the file-backed PFNs
>> can diverge from the PFNs backing QEMU's private mapping.
>>
>> Fix this by using dma_map_file() only for shared RAMBlocks.
>>
>> Fixes: fb32965b6dd8 ("vfio/iommufd: use IOMMU_IOAS_MAP_FILE")
>> Reported-by: Farrah Chen <farrah.chen@intel.com>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220776
>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> ---
>>   hw/vfio/container.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 4c2816b574..c5a3c60a27 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -82,7 +82,7 @@ int vfio_container_dma_map(VFIOContainer *bcontainer,
>>       RAMBlock *rb = mr->ram_block;
>>       int mfd = rb ? qemu_ram_get_fd(rb) : -1;
>>   -    if (mfd >= 0 && vioc->dma_map_file) {
>> +    if (mfd >= 0 && vioc->dma_map_file && qemu_ram_is_shared(rb)) {
> 
> I think we should introduce an helper to check that the conditions
> for using the .dma_map_file() handler are met. Something like :
> 
>     if (vfio_container_can_dma_map_file(bcontainer, ...)) {
>           RAMBlock *rb = mr->ram_block;
>    
> and
> 
>  /*
>   * We can use IOMMU DMA mapping (IOMMU_IOAS_MAP_FILE) for :
>   *
>   * 1) Guest RAM blocks explicitly configured as shared (MAP_SHARED)
>   * 2) RAM device sub-regions (MMIO BARs)
>   *
>   * Private RAM mappings (MAP_PRIVATE) are strictly excluded. Because
>   * they are subject to copy-on-write (COW) anomalies, their
>   * underlying PFNs can permanently diverge from the backing file
>   */
>   bool vfio_container_can_dma_map_file(VFIOContainer *bcontainer, ...)
>   {
>      return ...
>   }
> 
> How's that ?
Thanks for the review. I'm fine with introducing the helper.

But I'm not sure if it's cleaner to include duplicated calculations in both the caller and helper.
 
+static bool vfio_container_can_dma_map_file(VFIOContainer *bcontainer, RAMBlock *rb)
+{
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+
+    return rb && qemu_ram_get_fd(rb) >= 0 && vioc->dma_map_file &&
+           qemu_ram_is_shared(rb);
+}
+

int vfio_container_dma_map(VFIOContainer *bcontainer, ...)
{
     ...
     RAMBlock *rb = mr->ram_block;
     int mfd = rb ? qemu_ram_get_fd(rb) : -1;
 
-    if (mfd >= 0 && vioc->dma_map_file && qemu_ram_is_shared(rb)) {
+    if (vfio_container_can_dma_map_file(bcontainer, rb)) {
         unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
         unsigned long offset = qemu_ram_get_fd_offset(rb);

Perhaps it can be simplified slightly.


