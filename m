Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7877CC53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 08:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woGzD-00033l-Jq; Mon, 27 Jul 2026 04:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1woGz5-00032z-OD
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:46:52 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flosch@nutanix.com>)
 id 1woGz4-0006Bw-11
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:46:51 -0400
Received: from pps.filterd (m0127840.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R7TBZS3407994; Mon, 27 Jul 2026 01:46:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=oS8Il/aQ0wzzMJUuUpz7pYKjb995eTLdBUwh8HQ0v
 9w=; b=R0qYU2RyZ957U3xSE4uIbUFr8vqi46MW8VotMWIXuDpSo8z2cIpvjAGnJ
 CbHD+rkhSJEbEMiwuIMwwd6EmB3e1tiNJE/Z7qjSO4RXaO5GoxkDTf4mlV9j03eL
 rmnMPOVPH1mNvXtC+54sC/joyFZlTiQrw3EhvOk9URN32UtGrKh7UGhOWe0nkkrA
 tKrvTldX1tapRBUVdHcwotm9PM33iPQ4djoq378OwFqDzBepdl+GY78w67Fxd//y
 RSzaPjfx23K2qlACSxkgV3cLedICyIBl2w5G09j8YxGMy+c1EFaEDF+LCxMU/P5w
 Xy3W/sEAYVCtbZA7wgEG5BabgMzEg==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020099.outbound.protection.outlook.com [52.101.85.99])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4fmsft2yk9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 01:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ska9VcnwtOgYXNRZ0bXMfHsSEx7ahC3sECC3lVi+PaipxIvVk8xCAgmBOMUci88qOtnPfDFTiCfjABEjPxWRMFZLvvcOLRf6c61kHWIwaJr7ZL2b9FEa3XHY8JE9g5gZIqhLnKKTNuWxrYhaKhfrNXEAQZh63Wmfjfhv0Q2XBU6QL/PwP8YFFAeorSavhZAFv29ynK1+D6Z3vAJ+a3goZhyRIA9Bj90iz6oOW7SPwgtqQPJemp8qguVJ4eTleN0KCMaNaxJnUvS9WWFwURfDRrlzsam+KYrg0G04ZXBXplwpP/y7Iei0u5kq6kDjoSlffqwLkQPJ3UbANMJ3lwujkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oS8Il/aQ0wzzMJUuUpz7pYKjb995eTLdBUwh8HQ0v9w=;
 b=yCPpRKzwPu6bSeynoTeqOhTYIPkJa+7AxBM6mKKKKCKsMRIJv95qJpcGwXiWRW8/HnDydhY6L6Bpf+xPu0aWg3QEBGBJfd0rrfEytiPQ5q4JRm1kguIgPw/o/Nbi8hm7ykXMqcLxZfjyz+b+LywcfpdVJT/YQ0DusKI65VlUZSTSaCnEt+a8vCPYoGNqrJovPLQvhrtX214So36BK3gitS5SMF4P9v6pI7ssg5LU2oPZIk1MKQGdBVYm5bYEHbWZe3xaX7KKm6V0XWWHhdpGRsZFjTHWnm4ckvCoObT4ttDm+GuyHpFrQN8oL+rTMfyF0JqXeW5e5mY6EDsxV86k1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS8Il/aQ0wzzMJUuUpz7pYKjb995eTLdBUwh8HQ0v9w=;
 b=WRMmr3TYs2qLWpJT2JK61+X+2LY3Rmz3lvVYoeQbAj2SS9mwFXTnInomYsVGY5o8ifCIYAFO25ZfUFNRCFdsabHhsfvSVSbTqHFLf+dt/zknDPnsKFgdeGIeL/Ri0iirb+idhNMwEJ6dru/stWpNzsHG2cCSISeQkA7YJ/xRfMP9kl4ZmnHqh+9BNyWpnOC1vcbYZfdPXNb5iWmlrmQNKvYq+kRi0liMHtlJwQ0tVF3D/YdQFIjps6AKgN4ySTrQgMCwJRRJ2RtwoEy7yGN5qN7H0Zz+rmndBTEBYTLoM82z5mZxN28vTVKxp2a/M8ukA5TtyvO3O4Obhncqh7T1Mg==
Received: from CH2PR02MB6197.namprd02.prod.outlook.com (2603:10b6:610:4::25)
 by PH8PR02MB12141.namprd02.prod.outlook.com (2603:10b6:510:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 08:46:39 +0000
Received: from CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab]) by CH2PR02MB6197.namprd02.prod.outlook.com
 ([fe80::90e9:29cb:631d:9ab%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 08:46:39 +0000
Message-ID: <6c79c79f-1bff-4914-9e42-dc077885f718@nutanix.com>
Date: Mon, 27 Jul 2026 09:46:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add option to disable building tests
Content-Language: en-GB
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260724135413.1716872-1-flosch@nutanix.com>
 <708798a8-3d43-48d9-a4f6-210eb88a88cb@oss.qualcomm.com>
 <92358092-080b-4b1d-82e5-733d2531ff38@oss.qualcomm.com>
From: Florian Schmidt <flosch@nutanix.com>
In-Reply-To: <92358092-080b-4b1d-82e5-733d2531ff38@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::18) To CH2PR02MB6197.namprd02.prod.outlook.com
 (2603:10b6:610:4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6197:EE_|PH8PR02MB12141:EE_
X-MS-Office365-Filtering-Correlation-Id: 671529ae-4bad-4ede-dfe7-08deebbb9315
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YNv2V7cooAbgVQAiXnqf0+eWACU34hRJNEQnLY9bnM7PtTndT3gizigjL+4B752mgVjuqt5Rl/lv1n9cyQeeTmfxBWBahcv2Fjl330Mw601CFg4a09DAFKqQOBTDI22/KLoIUbtHLwy0Mu0TOAefEjPKiZU8cppnntM9/SPA6m5EoI+GlIayyCLXhhqXfJzXQ8SaPA7mlJ5EBDS9rI7AqRyHSArxJhXr/Hfh8wBrkoT2WrpuoN9wh6ulbr85SqGGj0pTUhx9gsbVJqa14VwBmMYmenFOuFjZAek6mxDnUU0oUUACCE8DMhbic+H+V2aN8ifdGWL0iOx9e+ABa30YQvvHcK6ZIWBY7XNGnp0YTnnAZW1xRWZlBC7ejWVCE2sd6EohguZ7TgIqWdF+VMeikeVBv1BscJQbIv8pcoq59zj+S8+YBOzgh4cg7QmFQyOxPluAMwt01/b7wPQBOYcEds6+F8FwR7BDSMLRQYFK4p6kMddqlyX75195qmTXntAIAR3WMDGe5bGCeb8A5/SKdUmuuVqlQ8PJphmMvGCDqkDsqFnXxj1iX5Bo/LikC+hFZoYw/OerZYo1hGVGXfTX3EEjZ5mNitzq3I/f/GeRqozqe0yKRFt6FKdg54HYffaenRqxTrdq9tvSvpgC1riVslnMJKsmdiwOhEfM5OHd3sc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6197.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTZBTWlFM3hUNmFyRTE1YU9RRlNoMTFqeWwzT3ZyN3pNWTMrV0NwYzhaR21y?=
 =?utf-8?B?NUpoSDJaRzlUQUltQXpyUFF0c1lQczI5SFJHTHR3RzRYaU5jeVZjOGN6M29J?=
 =?utf-8?B?blZnUmk3TGVZb3ZBQWZpbDBXakRZSWkzc0VWMW45ZGtJUVhIVjZKWE9jM1N5?=
 =?utf-8?B?TkE3WlVKQk42NWwvWENBVDR2TkNmNVZGM0YrbDZ1M21QazR6OHhHZEdEOFJk?=
 =?utf-8?B?bk85YklZZFRsQmptclFSM1Q5RWV0TlE0K2lQcU84bGo0bjJxSUpKNWF1WCtp?=
 =?utf-8?B?T2F0UUN4MndxUXdHVmg0ZkdKVDlkOXMzejNxbzdCeDhIQ0p6Y2h4UVdBUnRq?=
 =?utf-8?B?ODZWckdOanNsdHZGUnl4cjhEWDFFWFBqajNlOGlDTkM2UkF0WncrOVYxK1lw?=
 =?utf-8?B?Q3dDWUNYWHZOTVl3aW0yT3FJTzNLU3oxdkVKWWJHMjUwQWQzOFNXWVR3eEtX?=
 =?utf-8?B?L2dFa1ROR0tEUVp2aFZYRTYxeUdRTS9qTGtPb1BVMy9hMFJ4NUtkSm56bFh1?=
 =?utf-8?B?TzBlWHJNcXhNU25JV0F5Q043ZlowMk5mRGkyak1qMktDQWFQNlo4TzA3SWM2?=
 =?utf-8?B?VnBQKzdPWGdROUhyakQyYjRMNWtCemV0QU1HbVdvQUdOREVGWkE3SW1xT1Z4?=
 =?utf-8?B?WmlCSmNmaUx2YTcvWFNacnJPMkRWclErTHRPbUhRbFFkZnZHK3BRQklibTVQ?=
 =?utf-8?B?THFUOHR3cFNFc3pNcHdZZ1lLSjE3czBBQ2Y1eTl3eVd2YlhscnhqOVl6UWlo?=
 =?utf-8?B?WE1iaVZGWkxvZWN1TVdxVWpBVFYwRmhPQ01WNzJOSmV3L0hYMnFrZGRiTWlp?=
 =?utf-8?B?TDdRVTVHRnVIQWVGNWU5eEpCMGZEY1BQZUFraFJ6cFhHQ3dNbHVRUUpPNWJF?=
 =?utf-8?B?a3hqYks1SjYzdlc3dG4rYUZXU1lqY2NtUWpqUi91STdNM2Z3RWFKOEZlbGtH?=
 =?utf-8?B?YW9hOG9jVFNQYzVhakVSZTEwci9YY0F5NURHWHRhekFlbERCb21TOEVuV3Nm?=
 =?utf-8?B?b3Z3WFZJZmdaNFN2aUVYbGVBdW1ucGZ1MkpiZ3A2d2cvU3ZHVlhKdGRSRlNS?=
 =?utf-8?B?UnZIVTRJU2kwUHNTSmxjQnRRRFYwSUVhOWQvTGtuQ1JFejlHakwxcXZSTkUy?=
 =?utf-8?B?REI2TVhmbXFpYURrVjhjTWwvSmh0cW1kUzVmWlJoLytMalVoOGUwTXFrNFRF?=
 =?utf-8?B?NXVnUzJ6MjduS1BkdjBHcEpuNUtHYmxZdFpHN0k3NnpmWGNEdStMZlQ3T2tM?=
 =?utf-8?B?bE01YklheFM4M055RHduZ3l3eXVYRURxODlobjRXci9qT3RkajNQdmNiNGtr?=
 =?utf-8?B?bnJFaWxLY1IraFo3OVJ1S0ZnaXkwdWhUNWd2SCtEZDRqT0FtMEE5ZG5ZeTN2?=
 =?utf-8?B?SHpTenBjS3lReEZORktqRTdEdURQbGlEdWpHRTF3ZVBiTDZJOTdEM0pqR2lZ?=
 =?utf-8?B?QjcyMVMrMTRZNk44eHVwdDhJQlZ2QnZ4V0hiWk55MUtVVVhtVHYzWWlUUWsr?=
 =?utf-8?B?ZnRUYVo1dWp5QTl4WHBpN1pjK2Y0elRLamlUbXRDTGFqcm16bGVrUGJ2SFdi?=
 =?utf-8?B?NnhNMkhzbWRTUXJlTGhTb1pISlRqWE5GQytEOTNwTTI3QnYxYXMxSW5ubm80?=
 =?utf-8?B?VnRHVm1lWjkvZTZIaE8wQ1Y1a3ZzcDFVaGliakUxZjRmRGQva0UvUTNyUHli?=
 =?utf-8?B?ZlhaK3RJQ2hKaThXb3ZVQXVBbUQxRStFZ1pOTGt5eERPMXEwT2dUYUQveExo?=
 =?utf-8?B?ZVpmak5qL3J2djdnak9jMEZ2bkQ5b0FVZDlnRmhENXozeVN2M0U0NHBDcCtm?=
 =?utf-8?B?blB1Z2RMcWxCRUI5TjVTZ3YwTHljY0xuUGxNRnZrTGtUMnorMkZuaVg0anJG?=
 =?utf-8?B?eWx6WDgyS0U4MTQxQS8reS9maFVJTk9OSFlxOFpFb1JndWh2TjdOdWt2M3RP?=
 =?utf-8?B?U09KVkgzMTJSRWFBbEthVUs4SElKMWNCa3RWQXRCdzRiak9adUp3MXVPV3lr?=
 =?utf-8?B?SzlXa0hoUFBQdTRBVUVCWjhDeHRNK2JMUHh3NWhJMDVBa24vK2s1aFhnWHR5?=
 =?utf-8?B?ZWd3S0lwVXM3RXJ6UWVGZlRTY1U2cGJqQnFoQVU3dzFmeThpUlBwcFhId3dp?=
 =?utf-8?B?SFJTSG1sb0FJUWUwS3plYTlHM2N0UWo5aVB1WGVPaGd3RTIvNlFtMGRvbnU3?=
 =?utf-8?B?RWRuVWlYUEdDMHUvSlM1RVNTYjJ5SkYyOS9DUWdFUjBqYXVOYnFiY20rUDNX?=
 =?utf-8?B?WEtsRTBWVjQrVXAyV2VDU0UzNHhKdmhoaWtFZFE4VHNubXpHWFVNOEhuSTEz?=
 =?utf-8?B?Q1c0NHNqdDlRTXUrZFd6dm5TWHZjZ01ROXJhZlo3dXo0RUtORVdBM3dpblYx?=
 =?utf-8?Q?ZA9+ezRV4O10jTvs=3D?=
X-Exchange-RoutingPolicyChecked: peADJ9ke2M/GKrBcb+gnpUy1GqtA1UAEAnechb9XacnFOsl3m+YBG721Qdafta4sjQqWqqrJNxJoi+dDD2hHyFae82kt8vFjomJqpT0hgLE8IRl5qAAfwMAXygpHZTrXR0KK+uCSPXr5HyxjI/OuUYVqslvVZkxvauRNV40h5XqCbdws6OoPU6SPW/uy6ZT4j/FSkr7crSDXFZ6fC8n/Em/BifBfTp8Bg77jxGz16qupVh+Xzj8dvqnRzx9eg6bmujavYwg1ls62Q8Q+gww736GMrlCLFhvJKDkBP23AmFs+PgFPnwogMZ8mtH4bcK2e1BKoKGOks8etzz6ISj8eyg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671529ae-4bad-4ede-dfe7-08deebbb9315
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6197.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 08:46:39.4536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7Ip6yPnrBH87wVo7Lt6ZmJdstW59tPYoWRwSl2NlJAxX/tFwV+7/ZnNxhiV2YHhS6EV7FL62zfkYNA44bIwUi3nh8opehlhwQf/oi8LUoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR02MB12141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA4NiBTYWx0ZWRfXyBA/nJw+77ny
 OhltAay14+3NTeXUShmo2/IdBCxH1iTbmcS4sMjB70UrdjlMOppUQUDAyMCdZS+tIL+s4GfuPCH
 RXYkRYrOMkJkdMsPwcHeUStqmKcXlgbMTvRAICiopO8VSRm+aG4PFrEcptGl0+cp8SNowtzccrG
 HzqAXI4vxc8SwahZJv37oPRPSdYMjBLGMaBw1QKgy0qnEKIeTsAngHDiNpDMzEHEchb3jRD0F+q
 tr0aWxTcUoHQjG4vjVV40Jz0kYvxZk/Yz9Jb2K7T2xSujAkMmTvoZ+HFa0VvKgqbr4mJTO0FkxN
 CgTgye0k4/Cq1zVPk6Fy9TUPCqeERecWKCg4lTYxFyWHK54VI01PDwXBP39Q9vVQBzuXzh9jMi6
 vUc4jfndETB+7RKdAl640i9fgjWooP5XGqzRIRYgO/hQmL0YlJEEg+6KtaO+sv+lgg0CJx/1Vkf
 qbqK9nV/wduz8GZafLA==
X-Authority-Analysis: v=2.4 cv=R7wz39RX c=1 sm=1 tr=0 ts=6a671af1 cx=c_pps
 a=GGH+j3rhJf5zTl2H81NwCw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=_-M8LpHI31CeLmyZm6wg:22
 a=pZaoj2KTE0HK9D8d0lUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA4NiBTYWx0ZWRfX67aqJUga5+6N
 Fz/HwmM9x4a8Grn0DdEIar5mvEAf2T+2fEd+CgplIVpew8WbAzQGIcS+HOvBfPR9HLL8kOyG5Sg
 GlvbhWlvbH5dpF88DIbwXwJShpgqi90=
X-Proofpoint-GUID: NZgtiyeYyNgen_ItBb9c7hHx8eRTDfci
X-Proofpoint-ORIG-GUID: NZgtiyeYyNgen_ItBb9c7hHx8eRTDfci
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=flosch@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 2026-07-27 09:12, Philippe Mathieu-Daudé wrote:
> When is it useful to build without the provided test suite? When another
> one is better? Why not contribute it then?
> 
> Or is is just that you don't want to test your changes?

In our case, we have pipelines that rebuild/repackage QEMU after a full 
build+test, without running the test suite again. In those cases, 
building the tests is wasted effort, and considerably increases the 
overall build times.


> The problem might be we build the tests by default but don't run them by
> default.

That's fair, but I would argue that in that case, there should still be 
some way to build the binaries without building and running the tests.

Cheers,
Florian

