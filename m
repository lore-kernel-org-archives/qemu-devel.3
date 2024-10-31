Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DDCD767D6
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 14:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6W3i-00056b-3l; Thu, 31 Oct 2024 10:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t6W3c-00056A-Ei
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 10:21:52 -0400
Received: from mail-dm6nam11on20622.outbound.protection.outlook.com
 ([2a01:111:f403:2415::622]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1t6W3a-0004KW-5I
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 10:21:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8Yl20u3C+WEquJNF0AJ6C4Yq8cXW7LWkT1f7PzOxUeEXoAnTNf1wjwjLoIO2l5mTMZoBkUIyD3XKp79JVg/IybGEyGYqJRJlrz/nfNMLC41ssWWtjxJdM+YWh+LYMv+A/OTYyi1CtKK+bFWUrQgMPG9ocDW+R1StxjkV5R/xwGADA7M9zryF1mzB5EHTFVmPa1jqBMlAXJRgeApaIhNfd6dOKPV2qD4JWwVoh5zsXPRUGHNnNcIFsiO7Gz/2E2dzUyWA7EsL9jUxDLxLbOi5bjc/qNOxC1z6KpZWOzJlqggo6uQjW+PagQ6CwDkKvPjgXjp2POQ61sH9gWy+rqatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGhSr0nvSZfAFzp31z4M/BGASUC/6TslzQgHUJnCBbU=;
 b=bEatIB129Hi+W4XvT1aBaUxnsNLoy/lfot8/8ewBYCdLbRIW7162EXbXrW5tmXV4RUP1/gzm+DJfFwcPQJqxENbIcn3m9fl6tl4fM4TSntx/abM3V7D62ZSXZo9dCXCLBSnIoLX9yMz9tQtKo3bIh6SeMowt8i12Kh3zdwnj4qgtsYC6rjg64lMr42SA5vK9ruQYgwsvPPRQIocwDkiFr+UiDxDygpqsoKG93zFJs3w3Wa/U41FWgV+sLs1VRvK/aUhQZPf60aefm4cfZNlAsfED7HIC0t7zaklhKDRnwJNGw6GVRL0B6jqAoazRNE5zQ0NYTBVNDqKDLuF4P4Te0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGhSr0nvSZfAFzp31z4M/BGASUC/6TslzQgHUJnCBbU=;
 b=tQKSWyRPLeMwclI2CJ/3PREtyldseG0llXPl+h06T/e2rM+DJfMO8MKOdjRLsjXduCjZlfHKuSeTcikMkNdlzmHP9wpE6WLUFkK0vsQ7gUsfcGh8MbWB7+J27Bt+xZmrE9/MguvwibEDeu3jnOPpAT3DFs9sKy9Xa8TjSUgKrds3oEFU/00+nmEyRb4HFwR2qN9qjlUk7Iv5mIO7x9yUVx+GubnUOqy91LiV945IkS1sWlkggP8Klh2ijLVXj0SCHMkcr4DGpq71seV22G1bYpCiaKdbSBEhcyioTD7cFOmJpfJ2QcWjtMwhhFZ1ukp2AobJXMngFSpe/BqzOeZgsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 14:21:40 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 14:21:40 +0000
Message-ID: <1eac2eb5-c154-438c-91a3-fb7ac7e3baef@nvidia.com>
Date: Thu, 31 Oct 2024 16:21:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] vfio/migration: Add
 save_{iterate,complete_precopy}_started trace events
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1730203967.git.maciej.szmigiero@oracle.com>
 <68f51cf0eb3daf448ae80219dded4b10984e32db.1730203967.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <68f51cf0eb3daf448ae80219dded4b10984e32db.1730203967.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0252.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::17) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eb62916-f011-4fa7-16e0-08dcf9b755f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDNkZ3ZFY09tYWRZRWY0WjlOMmlpVndEOVV3RTg0UkJjakdwQzhYSmJzUDRP?=
 =?utf-8?B?STAvUlVET2hTMnJtNWtNcHFXUXlqYUdXTXFraWJncE1TR3F4Z1VuZUpxN3ho?=
 =?utf-8?B?alprQjdjY1VITHJRMnB5UHRZbTc2TzFlUzJLSysrOFAvUHFTSFhaLzVjblNN?=
 =?utf-8?B?dFB2ZmM1dWhwN1lFa3ZtUnZHM3ltUUREVzNRdCt2RkhYaUlmV0htUktCWVJB?=
 =?utf-8?B?Skc2WnVwYUZKZi9JbWYwUGZDN3ZuZTg3NllLNGVRc0ZyUWNoTllqUkMrSzBB?=
 =?utf-8?B?UDM4ZUZ0UEU0cnVVaWpVa2xjQXhHMGVrNXk4Qmpra2xsVEhXS2Jyb3JqRjVi?=
 =?utf-8?B?TnFuRnNDTUdiVXo5NnF4ZHAzU1lwZnpqSlllYlNkZEpkYk9SbEdnTTcrYzhx?=
 =?utf-8?B?aWtXd3FzdEZPV2Znc1h4bHFoeWdSYTB3cW5tNmkxT21JNWlKQWhlWS9xek5W?=
 =?utf-8?B?OXlOQ3dqWmFzWGRjZ0xOUzFJdDVFcm80bVcyVldJQlk0MHd6TVd2Z3hOSGVk?=
 =?utf-8?B?TWdJTU5CbUk4VGtKT1Zma2hFTWRIKzFwMEhablRKSkZsTjVndUwyVDlNT1ZL?=
 =?utf-8?B?amcxMndaWHR0QlpkSkQyQ1hUdVFLL2hGTXVpQUhxbnpXY2RIdHdvMzJYNjBM?=
 =?utf-8?B?WWlkVHJLQmdYWGxjZDJvZlpncUxkN2tsZWE5R0krOVVjWDhpU1N4cUJsSTFh?=
 =?utf-8?B?SHYyZDdKd1BFZHBhbXNPbjBZWC9qanA2dXVqSEpqZzdoL0pzS0s3cytuakV4?=
 =?utf-8?B?N0tpZkpKQVRndUY0NlB2enVZQmYwWE1CMi9CajZrK0JUdHBpTHhBc0svRURx?=
 =?utf-8?B?WVVhRUtPT0FTaGU2N0tMc21FajFITGEvN2tCMEszcSs1QkYwZnFtNXZ6RmZ0?=
 =?utf-8?B?WWtUbVl3dEU5OWM5OWFOaXEyczZiS2t1UHVoZENCMUJDRHIra3MvRGZtOTZo?=
 =?utf-8?B?aVJEQi8rOVVxckNOaURJc2RvRWd0amM2OU8zWFJJcUJjYVlQNGhKL1ZFTTQv?=
 =?utf-8?B?amFvUXlmS0NRR2pnNTlwZVJNOVhscnZMK20zWS94UVhaMUk1dFhHVTFCOTQ5?=
 =?utf-8?B?WFdsN3pYeWhmRktaZ2U1M3l5ajNWMm1JdzI0djZtMnR0aUtQSkJTN0l5NzNR?=
 =?utf-8?B?UlBxM3UzQml3RU0yR2VrK2E5RDB1ZDZTUFA2T1lydkhFZUxQWTNBWGxNZVI2?=
 =?utf-8?B?a2ZCSHVPN2Jpend5ZUcwUVB3WjdkTW53TkpEeGlPNGZiaDkxS2FHSk9lckZw?=
 =?utf-8?B?dU5VVDVqUlJXMStJdHJUUDFRV01aMFZzdFZJQzEvUDVHZjJZLzc0UFh6Q2l1?=
 =?utf-8?B?eUoyN0dKRkkyZ2FlUWVMeExRS2dsckFQOFFOZ2FtT2sxeFR1aDM0Q0dZL0dY?=
 =?utf-8?B?V1NRekw0eGNOR1hiSlFKS2x6UGxNMjR0MDhwZ0NPNU1CeGt2MFBKcWlOZ1d6?=
 =?utf-8?B?Mjd2TnNYNUtJNTFVSGNUN3R4K3JZa1JFTU5iTzhxb05NTVNlc0h2Mk5RVUhO?=
 =?utf-8?B?UDJlSEhtSGlOSHp4bWsycTczYmpDa080QUdyQkV6Rko5UUEvWkppWlpvaFVj?=
 =?utf-8?B?Ry9NRnBuZmg5NzhaMjZhUk9lZkdMUHgzU1ZvUVRQOW1LRGt2UDFZRis5WlFC?=
 =?utf-8?B?TFVHLzkxM3p1bGc2Tno3eXJhNUFnSmd5RkI0bHd1K1VUM20wYzZSZ09BOW9p?=
 =?utf-8?B?dlJ1L2x3SU11UHBQSFFpREdsMlgxZWdnZWttcEdyV2JPWklkMTYrRlpQdkRW?=
 =?utf-8?Q?NyitPjEuU+3ZNIVcqzLEeJQ/swsk6NEd5y77T+L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVdlQk9KMGRKMjlpVm0xYVAxM1J2VkhPRkpxdy9JVTlTR2w2RDQ1SFlkaWNZ?=
 =?utf-8?B?YTdYNGI0TVQwdEd4ZS9tMktiSkdvaUhpUWVDbVN2UURJWThVU0MyKzloUElT?=
 =?utf-8?B?N1hPNHJEaE5UZlFXYm0zN3MxSXFwQnhxVm9uNzZzOHdCcTE3NTNxMmt1Q0Z5?=
 =?utf-8?B?TUIzUnBPNkUzZk5JbDIvVkpJVmtBOGpkZjB2Yk9SeDAzMFRRNHUyaDlsdDJm?=
 =?utf-8?B?NHlEN2x6c3laSGw3K0hLZFczUVdQZmFNbUpDeGRaUmdJU1R5TEFneEZZMGZT?=
 =?utf-8?B?N0pvakxtMlVxSkw5cWhMT1hyTlFzT1UvWWhvdzNiaWFhaHZtQTN5cndldE1O?=
 =?utf-8?B?T3ZndGduS1VnU2xhQ2VRRGs2d1hkLy9wYzZKUzkrS2dlVGpXVEUzUkRBd3VD?=
 =?utf-8?B?VmxaaEQ4MHMzQ2RLZk9FNGJPK202NHNRUUJ5S0REbk5WVmVqSVVML0UvN3o2?=
 =?utf-8?B?MjBoUStPN1JORVVOQUlnN3AxWlpYRC9aazhaNklFRDJVQVNLaldiY2E1VHFl?=
 =?utf-8?B?eFhPR2JPL1RTUHJsOTVKNG5TOTlJSU9jb0FSNzNLVm03STJjaVFKU2tHdUlF?=
 =?utf-8?B?bGxvRWw4UEpsMzI5TTkyeTQ4eHh6RHVpQWE5ZkU3a2IzQUdkMVJMVjVsNm9Y?=
 =?utf-8?B?WDQ1VS9jcjVWOWJtb3ZtTVNTVmg4cVFBaENmMXBzb3dZVjhTZW9POHAvbG5C?=
 =?utf-8?B?UlNWYTlvSnBvYk5qTldwZ2JlR0xKVk9BVm5uaXpxME0zbXBYdG1KWXljbDlr?=
 =?utf-8?B?aHZ6WktTa1YrRXJSWnJNV3NMbkgvVkQzU1FrM0dGT2VxRldlUHhSai93L0wv?=
 =?utf-8?B?Z0xVUDdkbEptL2hZK0JVaUFFN3QyL24xNjlNcG1lKzV3NXg4NDFTQkthYWtp?=
 =?utf-8?B?Q0RPSUxwSU02ZTY1djkwY0xKYkRkQmFGWE9aLytXUEdRbjBkdzArUTErU1Vn?=
 =?utf-8?B?QzNFcVlUcHY5a2QwSlVmYUcyT1ZSby80WVROUjM3TEdBWnpwN0RvY3JKZzdY?=
 =?utf-8?B?VjM1VmFTQTBMZ2Jia2JPREdoTHhpUVZUTlp2OEdhMGZuOFhzNzgyUzlBaUl6?=
 =?utf-8?B?cnRuaUpsWmVwY21LV0NmR3FYQ0dnTVU2dkVlOVIvZy9tRnQrb3JxNlB5bXpl?=
 =?utf-8?B?VDZYd2RLMjEzMVRMQ0Z6RTlsUTNvNEdGc2t4blZaMjlpejk5NUkyTWVWekRm?=
 =?utf-8?B?bCtNYTVnMStxZ2h0dGp3YldpRUVxMWY5WGJSUkllZWhZK3JFLytmNk52SFNn?=
 =?utf-8?B?ZW9tK3FvL2RNTWh3MFN0ZXZya0pneFZvejYvUmNtNG1MNUtiOUFrVjZmN3dX?=
 =?utf-8?B?QlNsVXlwMmg1WkV5VlJXZXN5TE93bHY4d2lwWnZIQmtxaDhuZjJqV0F1bnBB?=
 =?utf-8?B?eGFEUHZwR0NKZUtNSXhyOXFUVUgyVUU4TFFFVitPcTFHYi9XOHppV2VmRmh2?=
 =?utf-8?B?WVdOZ2hpMTJwSWhFU0VYcy84Nkg4eUpzZGZFWWFqdmFGNW1GMWxKOEdXcnFa?=
 =?utf-8?B?NTdiK2xTRUhiREpzeVUvdG1FM3NRaVVTQSs0YVJSSjNCK3FxUGlwZmF5cHhJ?=
 =?utf-8?B?TStET1RBa0VkcTc5SXJlWGFOTXIxSklNcUNKc3FtaldoY0dSWXJTKytSUERM?=
 =?utf-8?B?dnpMYitUUGIyTmlSMTRud0orK29hLyswNFZhang3Zmg3N3QzWmRkcTFqWWZm?=
 =?utf-8?B?b0NPczREMVhCRVpQRnRJRm9GZjdWMncwOTFVV254OGhUQkQ3WEptdWRGT0NV?=
 =?utf-8?B?U1FTai8wK2dCY3JuelBJR2JHV2F3cFdsTHVvTDJiQ21ZSW52N3BrL2ZVbGox?=
 =?utf-8?B?T2l2WGpJcEFaR1Ruai9mK3lJWUtzNWZLbCtmL1lFSkNweG85UjJJVHZpdGgr?=
 =?utf-8?B?K1RlWXptK3c3bEgvdFNTVGgydXhVeTJrZWxNczVZR0dGdW5KU2E5NzZmeU45?=
 =?utf-8?B?OHBmV0NmdUttMHZkNHNaMXVCVXNuT2wxOG12cGxLUlRYMjhuR1VuVzB1d1U4?=
 =?utf-8?B?eFFGZDF3UDVLSVp2OHNBMnZlMmxJREthdHAyVXRHSklpZVdSVTFucHBuWUJR?=
 =?utf-8?B?bFFQRnRabWk3UlN1NThid3FTV01ERnFYd3FkZzN0NDFzOGY1YkJSSmxLRUVp?=
 =?utf-8?Q?StgvOaPTuIVnM5E1FYZpxQpP7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb62916-f011-4fa7-16e0-08dcf9b755f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 14:21:39.8694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjkKJ0PBtZ0huEe/QkW4wLd52aLruKRRX62VBT10JxPJjMHP5tc2VxcSJ/R++OHtybuXw3TZ0Vuf8TTUUG0MUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
Received-SPF: softfail client-ip=2a01:111:f403:2415::622;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Maciej,

On 29/10/2024 16:58, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> This way both the start and end points of migrating a particular VFIO
> device are known.
>
> Add also a vfio_save_iterate_empty_hit trace event so it is known when
> there's no more data to send for that device.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration.c           | 13 +++++++++++++
>   hw/vfio/trace-events          |  3 +++
>   include/hw/vfio/vfio-common.h |  3 +++
>   3 files changed, 19 insertions(+)
>
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 992dc3b10257..1b1ddf527d69 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -472,6 +472,9 @@ static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
>           return -ENOMEM;
>       }
>
> +    migration->save_iterate_started = false;
> +    migration->save_iterate_empty_hit = false;
> +
>       if (vfio_precopy_supported(vbasedev)) {
>           switch (migration->device_state) {
>           case VFIO_DEVICE_STATE_RUNNING:
> @@ -602,9 +605,17 @@ static int vfio_save_iterate(QEMUFile *f, void *opaque)
>       VFIOMigration *migration = vbasedev->migration;
>       ssize_t data_size;
>
> +    if (!migration->save_iterate_started) {
> +        trace_vfio_save_iterate_started(vbasedev->name);
> +        migration->save_iterate_started = true;
> +    }
> +
>       data_size = vfio_save_block(f, migration);
>       if (data_size < 0) {
>           return data_size;
> +    } else if (data_size == 0 && !migration->save_iterate_empty_hit) {
> +        trace_vfio_save_iterate_empty_hit(vbasedev->name);
> +        migration->save_iterate_empty_hit = true;
>       }

Can we instead use trace_vfio_save_iterate to understand if the device 
reached 0?

In any case, I think the above could fit better in vfio_save_block(), 
where ENOMSG indicates that the device has no more data to send during 
pre-copy phase:

...
if (data_size < 0) {
     /*
      * Pre-copy emptied all the device state for now. For more information,
      * please refer to the Linux kernel VFIO uAPI.
      */
     if (errno == ENOMSG) {
trace_vfio_save_iterate_empty_hit(vbasedev->name)              
<--------------- move it here
         return 0;
     }

     return -errno;
}
...

If you move the trace there, maybe renaming it to 
trace_vfio_precopy_empty_hit() will be more accurate?
And trying to avoid adding the extra 
VFIOMigration->save_iterate_empty_hit flag, can we simply trace it every 
time?

>
>       vfio_update_estimated_pending_data(migration, data_size);
> @@ -630,6 +641,8 @@ static int vfio_save_complete_precopy(QEMUFile *f, void *opaque)
>       int ret;
>       Error *local_err = NULL;
>
> +    trace_vfio_save_complete_precopy_started(vbasedev->name);

I assume this trace is used to measure how long it takes for 
vfio_save_complete_precopy() to run? If so, can we use 
trace_vmstate_downtime_save to achieve the same goal?

Thanks.

> +
>       /* We reach here with device state STOP or STOP_COPY only */
>       ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_STOP_COPY,
>                                      VFIO_DEVICE_STATE_STOP, &local_err);
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 29789e8d276d..e58deab232ed 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -159,8 +159,11 @@ vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
>   vfio_save_block(const char *name, int data_size) " (%s) data_size %d"
>   vfio_save_cleanup(const char *name) " (%s)"
>   vfio_save_complete_precopy(const char *name, int ret) " (%s) ret %d"
> +vfio_save_complete_precopy_started(const char *name) " (%s)"
>   vfio_save_device_config_state(const char *name) " (%s)"
>   vfio_save_iterate(const char *name, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy initial size %"PRIu64" precopy dirty size %"PRIu64
> +vfio_save_iterate_empty_hit(const char *name) " (%s)"
> +vfio_save_iterate_started(const char *name) " (%s)"
>   vfio_save_setup(const char *name, uint64_t data_buffer_size) " (%s) data buffer size %"PRIu64
>   vfio_state_pending_estimate(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
>   vfio_state_pending_exact(const char *name, uint64_t precopy, uint64_t postcopy, uint64_t stopcopy_size, uint64_t precopy_init_size, uint64_t precopy_dirty_size) " (%s) precopy %"PRIu64" postcopy %"PRIu64" stopcopy size %"PRIu64" precopy initial size %"PRIu64" precopy dirty size %"PRIu64
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index fed499b199f0..997ee5af2d5b 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -73,6 +73,9 @@ typedef struct VFIOMigration {
>       uint64_t precopy_init_size;
>       uint64_t precopy_dirty_size;
>       bool initial_data_sent;
> +
> +    bool save_iterate_started;
> +    bool save_iterate_empty_hit;
>   } VFIOMigration;
>
>   struct VFIOGroup;

