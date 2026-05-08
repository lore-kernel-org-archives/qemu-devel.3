Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8305FCD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 09:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLHUR-00053h-KM; Fri, 08 May 2026 05:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wLHUP-000537-9m
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:27:21 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wLHUN-0000VY-1K
 for qemu-devel@nongnu.org; Fri, 08 May 2026 05:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778232439; x=1809768439;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qf5/V/Fcs//slxHnf0TmZ/szwpCyeYp0Wm1edOzLQ04=;
 b=h7CQGqw3wwlGQU4TWWIUn9fS9W6uNlLXLCG6QTIwxXetFlq6UoR0sO+9
 naUS8XgIisvAFy7ncmRjEbm3IvbzzwADMBwPVUhKPnMI79zuubHMzBrnS
 /i8VbsCVkzYSeYQLurTcpQ8W7eURRWuPoD1SRHlr/jHbgEnGz5tnkuPJX
 CPB3Japa2Tbovn6kjvVHPGVk2yhpc0R6vxU6fk8llCpgmcSsrLEqOxX5t
 bHbD9TvJ1N9PTIIvOHEWauN/o45/nibU/PuhvUb5et1uCLIg8txkICIOb
 4mJOxjI0Lg0CfPbNpvWomduCaD27/6IZIYD6+Q9zVvLpywexa07zudgsQ w==;
X-CSE-ConnectionGUID: LphJGG14RQKEgOiWglxOsA==
X-CSE-MsgGUID: s+4BXrt3REO6oeIpVaeZjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="101870226"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="101870226"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:27:17 -0700
X-CSE-ConnectionGUID: D0Vb0sxqTMyy2sg6XI+1Lg==
X-CSE-MsgGUID: vMr1fptZTRWMqwpceq5tgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="241724009"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 02:27:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:27:15 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 8 May 2026 02:27:15 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.62) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 8 May 2026 02:27:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bddpgwi3wGh47RxiZWKHYGYujYNXmArz5jzMhrk9xcJ5p54+uQt3WzmSkWr1KMeSRLDj9sntyUg9xyPxqZIbBA6cCnFGgL4ZXiDrkng60Z2wjyEqxuJJ0oIDw3VYb5XiakdB23rDkJE++v8Sy0wCkzidGLQ/v1Ft+gKcraRAFZ4ITcqX/BG1ldiv+hQTlSUYERY2nVjN30kmTSvd7dGkFAuaY6/tkpduEwBrtQSPDW758WXOP522w7btg0UxniNf6jY2M+2E1AyrPVfoFWnVobgfiiNilwKZn4y3tLRuFXLASfQ0/rREQjA8Y3EntpgT+LBiAUuIFVHVYp0lJ4xD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfjVgf6nSjhjM8sOJzGw616xkprNULGKijwYeZALaCI=;
 b=dxUee5oM0aKg1YRhsrSNToz08ZlM7r5vZDfq3qXEtDBxNxuET6YR+EkWcg3jPyfBHhWqfrY9NtaVidkK/1DtILxqP8cHaW7yXK35OTp4vTEBlNUEBO6LyCzJkbCHvF8OmE8EJs+MG1oN2gHRlMgMNcTeywzgID/0ckuzFAvV91wrq/CCv/rhMbhJhjUlG6qTs1gv/RPWuLim7brl06LU6dLAuKHKWwS+lMAF6AdtiRD/Q1wQINyN6P+777XiL9oxNMfZiMWO2l0heCO7OMuyeVhGbW7DRY7psl5UUzcgMNvnFQDVgQ1bWXps5p3CSpyP2N1YeaBFrHUUA5Lbch0EPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8492.namprd11.prod.outlook.com (2603:10b6:806:3a3::7)
 by PH7PR11MB6700.namprd11.prod.outlook.com (2603:10b6:510:1ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Fri, 8 May
 2026 09:27:08 +0000
Received: from SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c]) by SA1PR11MB8492.namprd11.prod.outlook.com
 ([fe80::cedf:12a3:5d80:af1c%4]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 09:27:08 +0000
Message-ID: <23957141-dc9e-415c-ae18-b0a0d2e5eb0e@intel.com>
Date: Fri, 8 May 2026 17:34:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/15] intel_iommu: Change pasid property from bool to
 uint8
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, <xudong.hao@intel.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
 <20260430071315.354333-6-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260430071315.354333-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0003.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::14) To SA1PR11MB8492.namprd11.prod.outlook.com
 (2603:10b6:806:3a3::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8492:EE_|PH7PR11MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: e6bb40a2-ee9c-4243-459b-08deace3f92f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|42112799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4Fmf18+p6nhOPfUxU6izo3bSygf1TfQhN5EF6tCF0Ts+BavPlUAxtfQ5VnBjrkxjh6j6/tA7B9ZY6OLitE/owxJLjhEd6n0HndwaT4p9m3BXf6uFkZcqCk6mLjq06N8IG2wZTJnJVyGJauHzJOc2/bxg/V8A3RCl3UXUlaeyl//y2SDtjOjoEDlqvmWSAbVZEle8heFOBpKtR4BnAPiAWlk0VyQCzifppGoWQU9B6MsCRIwDHDz24fZnVieHzEQVjjrqm21QUsTfQ/vbBUao1Z2Q2fgfqOuzELDxi0MuomNE6Bo9xIryXpXIa7EJRQCMncznWzMP6j0xlh/Skbk0MOvYS1SldRj9wgjRMgjFaQKTZc98o6t2/XmXqPoyUyie/yc3eaTBmRdaCYG/73nYpCyP7NV3Ohv1QEzStYHDOa0MWhj97qyZup22qc/8YqwEUaMW6w6E9Ur1j4kb6OAYoR8koGXOy2zDJcSB0ji5q28TE+VRqQtUHy6kUIXc59pSSLDPDGtxm3krVuFSVK2GqA5m/FMuHcVLRqBAnNYFFHYwFpz4vwjmrwHMupX1nGFqutIa/8Yzok5CvfIiB/eKYKj3AqoLUKEHwzz8m0ldJBaUylzD8S/yZlUYLzxSDJcSTWrC0g8zw9G/DOrrlJFi1uX88VkgGjDUcEPdJJNEd1jd1WHQHhhDG08TH+8p0LNR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8492.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(42112799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmNKemtUZXpYUjNUOVhURXkvV1A3aVQ4eHlZSkFrSkVDTXJUTGh5RVNzdURB?=
 =?utf-8?B?VElTRy9tMktBQllDeWp0b0hydUZyY3Q1YWorcXJaaU14aEhrbGFXZW9pcEhu?=
 =?utf-8?B?eS9PUlZ6VTB6YVJLT3lmUXcrcjdMR2NMbDVjRldHVExxMDN4TWFFSU83d0Js?=
 =?utf-8?B?UTlzRUlMcVEySy85dUp5WUxKUGhjVEtsMG03UTlIcFFxUnFVaFZCZXExM3ZT?=
 =?utf-8?B?QnJYTWxyVUk2TTJTaGRhMmJTanZmZElJVDNXc3RHSWhpbGxqWU5GT05sWWlE?=
 =?utf-8?B?b0lmODNuNkNaUk5GbVI1bGM0R1FxeTBLREJ5bzlET3hFNDhXbnZsVnltRlhM?=
 =?utf-8?B?QVg0Tnh6N3BFOFFxakM1M1NJMCs3WjFNbTcxVmZOc2dWQWhFNUhMWm5kcFhJ?=
 =?utf-8?B?VVBlcTNrTDgwdGtDd3lEZStIMExJM0hlNjhjVGlJd1RhNUhHUHBoSTVJeUNs?=
 =?utf-8?B?aTFlUUFjVDZQczd0UG1nSmpVdHlOOUlCYVFQbW9hdjNmODVReEIwOVplR3px?=
 =?utf-8?B?bEorM1BHVFhVaVdKM0dtVzROcDJSeWRpS0MrWjB2UTM2K2Z6bDBlYmhGK2Vy?=
 =?utf-8?B?LzBuYXF4MVRYOFJtekh3SWdHK0p2Z0plZXoxcUlBMnZGV3ZKWkpXK2I0SHM0?=
 =?utf-8?B?SDQ3WmxFTWFESEMwNi80VGdJRStiQjF4dDNxcmRyQndYM2ZHTFdNRlpDYXlZ?=
 =?utf-8?B?VFdqRWlIRTluSXlJODQzSC9nU3R6M1F2eEVXVk02UTBSTlFYcURVN0szZE9x?=
 =?utf-8?B?NW1IQ0ZaZTN6REVVcjhzaE8weWVQTEJ0RmMvbVVHNmhVV2ozWHRGbTN5enpp?=
 =?utf-8?B?U0ZzSXRTVnB4QVBzSmFTZGh0M1dvOUZZT0RaTDdmVUE4V2pxSzVPdnFjYStq?=
 =?utf-8?B?c29WSGJORmFnQ010Z3hKWEpBdVlmWDEwaGZ0RXEzaWgzRkpWeVdLenVFdWpH?=
 =?utf-8?B?RXJEaCs5MGp6SVFkU0Exc3hQYnV3NklCWEhrUGJqMlVzMnBEMjlqUmoyOG1l?=
 =?utf-8?B?ekp0STNyNWNFT1FZaVlNR1hNOFRSSUpBNE9CSzR5R3luTGk4aitkbkRaNC9o?=
 =?utf-8?B?K2ZtcDJqdk1sUCsycjJYN3pteG51MUN5Mk1NTGo2bzVTV2IxSkpmdFFjeks0?=
 =?utf-8?B?ZWMwTzFsZFNRbEZQb1BQRnpnRzhrK0o3K0FoSVFycGM0R29yUHArWHk5bkJk?=
 =?utf-8?B?Y2VWOVI4aUVuU0ZOYkJDaDdPc3M1bk55czlJcUFVeFlLenJSL0dPaERTbXRj?=
 =?utf-8?B?TmNiZVp2Mm5haVlrWXhiTjRQZ2h1MndSVmZwMzExRW1CZ0NyK1FNVXVJNTI0?=
 =?utf-8?B?cmNWaGtPWVpuRFNodmRGU3BxSlg3STBoOHlZNW5KdTNUMDhXTjVVOWtTK1c0?=
 =?utf-8?B?RDJJZHppOTI0SlNEa25wQ0p5SGpaRUxyZ3YrbDJCbzhBdWwxa2F4Qm52SEd3?=
 =?utf-8?B?U2g1eWxoQUg5cVBTK25RTytJWkMvbHdMMktCMHJJVFN2NG9PRUJNOXJldStx?=
 =?utf-8?B?V0NvWnZpb2krNm4xbGVSVUZWZ3M2c2pVMzR1Rjh2QmJoSFFkNWZ6dzBSdnR2?=
 =?utf-8?B?YktCdHlvY1B3cDdxd0lrSlU4QkE4U3lXd2M2ckJEemRFMVNvV3BqVnV1dVZG?=
 =?utf-8?B?QndFeWFVTnF2RWZqUE1CVU5kYVEycUF3bGNZbThwREFvMXVpVlpFTmd0cUll?=
 =?utf-8?B?SUtEcm0weTdac3RMRGcrbDhEb3dqU1VjRjhpdURzOWVScmlSdGdJUHUwS2p3?=
 =?utf-8?B?c3JaTU5kL0h4bWRDTDI2TXYwcWJ5SUpqM1diWkZtMENKNVVLZnQ3NDJhc2hH?=
 =?utf-8?B?NitjVTJkV3lIblE2WFY3MmNNYUM5ajdyRkMxV2YyZXZlSkZKOERxNnF2U2tW?=
 =?utf-8?B?dFoxWVFkVHgwd1J0YUpQeW9RcWdTb3NJREhBa2hiMEhmejFnWTBYaDBIYlp3?=
 =?utf-8?B?Q2VmdkY5cGd1VEZCYno0VEoxWHhncHdITW1aSURBeWZ4WThRZENpcjR2MlpF?=
 =?utf-8?B?UUE1SUxVNnRqQkVvMndHbjFqK01QWUtGZkxRR1M4cnpoUUlnUlJrSnpUd1RX?=
 =?utf-8?B?SDFITUpYeEMwdWpmK2pWaW5mSzNaQnJJVlBLdjdDMWM2ZVBCcVVhN0M1RkpB?=
 =?utf-8?B?d1ZCSERPeGFkdVFDOG40Y2NUeU11cXNDMWtMVVhZRzlxRW1mSVZHaXIzSGRv?=
 =?utf-8?B?TGtYWi9oZzZtY000WXVQMjlKSTNkZi8zcHZXN1paU2N0WWhQQXBlbTc2am16?=
 =?utf-8?B?ZVZVYVNzbGFGTHBuTjdZZ2YxRndWZmVTQkFJcTFDR0xuK2lUS3Jyb2NpQ1RQ?=
 =?utf-8?B?K0JlUFczcUxkUEg0SFJMaXN3cERvQXFUM2ZlSkEvQVlsZXdGN0JyZz09?=
X-Exchange-RoutingPolicyChecked: YvcV8GLn3wbILsBDAFxB0OHoolO2DgzRhb0eGiMfC4TFKoGGyGTNPIRC4PkZm5KnEYDWX62mlRy7KJRE2Uf1EQ8Zc9yEbX42A8SUdK+uktHZCU75hmjO77CpxzHzbyKrMX3M+S5n8cwnnVxux4GLfn5tJZYN5c1h9V2vuiaZFb7z5OSj1NCLT2yTw7FnVISBzUFBN/9lvADEtGyhPyPzH6dbKKqEE0Vi7k2LqBmUZVat3RSJvEYT/l/aosDP0NMoMzZzQT8tmf9zjYUxaowGYUTFZMxn5T9SBUgT+n9/iDDwZYcmIayO1hMYBBzNKeDinAoyJIvPpjci3CZec2A4JA==
X-MS-Exchange-CrossTenant-Network-Message-Id: e6bb40a2-ee9c-4243-459b-08deace3f92f
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8492.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 09:27:07.9380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: re5nKuD0c+APdjw7CVxIgIuz1Mfi6jywsZTwrPmxHjvXlJDjs971bnRn6uGMpQLxwZV+nQiJTqkuLnWqxx/BDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6700
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

On 4/30/26 15:13, Zhenzhong Duan wrote:
> 'x-pasid-mode' is a bool property, we need an extra 'pss' property to
> represent PASID size supported. Because there is no any device in QEMU
> supporting pasid capability yet, no guest could use the pasid feature
> until now, 'x-pasid-mode' takes no effect.
> 
> So instead of an extra 'pss' property we can use a single 'pasid'
> property of uint8 type to represent if pasid is supported and the PASID
> bits size. A value of N > 0 means pasid is supported and N - 1 is the
> value in PSS field in ECAP register.
> 
> PASID bits size should also be no more than 20 bits according to PCI spec.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  2 +-
>   include/hw/i386/intel_iommu.h  |  2 +-
>   hw/i386/intel_iommu.c          | 11 +++++++++--
>   3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 11a53aa369..db4f186a3e 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -195,7 +195,7 @@
>   #define VTD_ECAP_MHMV               (15ULL << 20)
>   #define VTD_ECAP_SRS                (1ULL << 31)
>   #define VTD_ECAP_NWFS               (1ULL << 33)
> -#define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid */
> +#define VTD_ECAP_SET_PSS(x, v)      ((x)->ecap = deposit64((x)->ecap, 35, 5, v))
>   #define VTD_ECAP_PASID              (1ULL << 40)
>   #define VTD_ECAP_PDS                (1ULL << 42)
>   #define VTD_ECAP_SMTS               (1ULL << 43)
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index e44ce31841..95c76015e4 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -314,7 +314,7 @@ struct IntelIOMMUState {
>       bool intr_eime;                 /* Extended interrupt mode enabled */
>       OnOffAuto intr_eim;             /* Toggle for EIM cabability */
>       uint8_t aw_bits;                /* Host/IOVA address width (in bits) */
> -    bool pasid;                     /* Whether to support PASID */
> +    uint8_t pasid;                  /* PASID supported in bits, 0 if not */
>       bool fs1gp;                     /* First Stage 1-GByte Page Support */
>   
>       /* Transient Mapping, Reserved(0) since VTD spec revision 3.2 */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index b784c5f10a..d1946e3a59 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4203,7 +4203,7 @@ static const Property vtd_properties[] = {
>       DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FALSE),
>       DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),
>       DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, false),
> -    DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
> +    DEFINE_PROP_UINT8("pasid", IntelIOMMUState, pasid, 0),

how about pasid-bits, it suits aw-bits as well.

>       DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
>       DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
>       DEFINE_PROP_BOOL("fs1gp", IntelIOMMUState, fs1gp, true),
> @@ -5045,7 +5045,8 @@ static void vtd_cap_init(IntelIOMMUState *s)
>       }
>   
>       if (s->pasid) {
> -        s->ecap |= VTD_ECAP_PASID | VTD_ECAP_PSS;
> +        VTD_ECAP_SET_PSS(s, s->pasid - 1);
> +        s->ecap |= VTD_ECAP_PASID;
>       }
>   }
>   
> @@ -5586,6 +5587,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>           return false;
>       }
>   
> +    if (s->pasid > PCI_EXT_CAP_PASID_MAX_WIDTH) {
> +        error_setg(errp, "PASID width %d exceeds Max PASID Width %d allowed "
> +                   "in PCI spec", s->pasid, PCI_EXT_CAP_PASID_MAX_WIDTH);
> +        return false;
> +    }
> +
>       if (s->svm) {
>           if (!x86_iommu->dt_supported) {
>               error_setg(errp, "Need to set device IOTLB for svm");


