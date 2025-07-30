Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEB6C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDSW-0006Xo-1S; Wed, 30 Jul 2025 16:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhCFJ-00044V-M7; Wed, 30 Jul 2025 15:13:49 -0400
Received: from mail-bn1nam02on20610.outbound.protection.outlook.com
 ([2a01:111:f403:2407::610]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uhCFG-0007zO-LH; Wed, 30 Jul 2025 15:13:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdRQQw91sHG2G4dOgOvayJI0Dx42xCnxONgY687E6P0tZtHSYUXkmA7hMZI5T5nLc0exjTpaIca5AstFu69CwzQrnc8pF7Tdd/+99rKgL9IMil/yFbOmsLfANqf3DHY5Vpe7kZhFpQ8AEiHZEpc0iBCCCaJ4+wwUyWWQhgWP7FGvdlx97a3Fb1zOxzvpYKB+NywWpS3BzO1q19SytYpoLjC+w1pnvH8cDyHQ5pXsePZ1/v5YuJ7VWojoI7zzzQXBeXmnW+IkbL2ivrM4K6Rm/UrVTDC5VqsmHTu57UooWGYQkqAfatprMK9R6u2S0Uwud2prBVOe5MIQPlgzU3i+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIE5a6S/KNdXQjvhe1otdfCGkveg3Mi70YeW86uINj4=;
 b=o6d80Jq8FscrLwaul/s9stZm51HVLv1vesf2D4U/SuoThSMGY1sYRJsQZfrRsMfcdCj4rqpY8l8P/IblX6EN9Hw9R4RUKudW8UK7kFjs7NK2kC29mhF6Z52ZQOANZyOUzBQww/r+Gj15hL1+H9jX4qyiOjPcLpPjFVLEMdRQDnBtwBI2n0eY9dXHfP4dqSJCUQrfp3lgjeVg/jrfGah05monIzv+JbVLztqyv3i9kWndkZQ63i0I8USXsVbWmG/bQsH/7Maf90PGBKq8XWLVoe4ro/AA/ILfMEDUdn+hKw2UicQfZmE9A1yaky6sQ6/UDj0DUMT2Mn8oaxWdMq3uLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIE5a6S/KNdXQjvhe1otdfCGkveg3Mi70YeW86uINj4=;
 b=mCpgNLibfaHn9V9iYlTu8AfDHkiszFANRHtD1dif+WO2L2yLL0R+VHDX3D5EIOII1ApfYL22LrFmisd5llNBI6jwjk2u5E3bmqCYiDrpXJNSOW3AT+nawXXWbuIhrASycoXlmLhqfjvTD7RQPFt1ibVOjWg1y9ItN9AHS5h2CvU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SA0PR12MB7074.namprd12.prod.outlook.com (2603:10b6:806:2d5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Wed, 30 Jul
 2025 19:13:42 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8989.010; Wed, 30 Jul 2025
 19:13:42 +0000
Date: Wed, 30 Jul 2025 21:13:35 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 30/48] hw/arm/xlnx-versal: add the versal_get_num_cpu
 accessor
Message-ID: <aIpu32Tb1TzRuFAG@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-31-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-31-luc.michel@amd.com>
X-ClientProxiedBy: LO4P123CA0039.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::8) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SA0PR12MB7074:EE_
X-MS-Office365-Filtering-Correlation-Id: 900f15e0-836a-4637-d8e3-08ddcf9d3241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L2JXczhQT21NdjBmbUw4YUJkaVcydkNuQlY4OHc0dkFkRVdnMHVDL2licmEy?=
 =?utf-8?B?bS9pRG1ocG1yenh3RGJHUTE4QkpLK2Y3V2hMS0g0c1ZaRlZHYXJNUjRIVUJE?=
 =?utf-8?B?Z3NualZKN3NqQndtZkZpWjVoMUQ2T1JsbFhIZEJhL2pFWFlsb01tR3lPSk5E?=
 =?utf-8?B?emh4Ky9BNnpnWFNEdDlIUHV1T2t0RjJJY3RyZXdzTkJpTzZDK1NFYytjWlBT?=
 =?utf-8?B?UTRoUUt6RjhhVmVFU1Rydllvc0FkckZuZ2xiRXlhS0lJNjh1OU9tQm1WS1Vx?=
 =?utf-8?B?UHpwcGtCNWtQbzhpTnFldFY4ZTY5cHphZ0JNV1ZybHVjNDRMZTB1QVJWTXRG?=
 =?utf-8?B?d0t4blRwQThkTWJHNjJ0ZEIyT0FRTzZQLzQrNGh0amxSM0VheUtBdHNWb3ZB?=
 =?utf-8?B?TkcvQTZzeFl1dXNTRzRlRVZGbnlEUVZzM3h1azkxeDRjcGo3ODJxQjNjT2tD?=
 =?utf-8?B?ZGhyRXN6dXovUU0xeG5LdlZUVzQ0RHBMVDR1TVFFU3M0Z3hlaDduVXBZWnVX?=
 =?utf-8?B?Mldaei9rSm5vSzNqbFZLanF0QXZZTlF5MGhCK0l0V3Z0MmdlZDJhWXdoNDIx?=
 =?utf-8?B?MWVqYlE5R2d2SGlUVmFYbTRVZ2VjNy8xR2NHVVlseU1PN2pyenExTzRzYSsy?=
 =?utf-8?B?N3h6K1AxNWlmRUdISFFwNmRuMGhrUnZsTjNIYmNwMDVRRzFXQkJ3YkI1a2sz?=
 =?utf-8?B?ZjU3bk5OcGV5OUIrVXpJMloyZTNocEhOUTFLT28zbVRCd21FQW1tYWhoSlBX?=
 =?utf-8?B?VDFQR21IRCtCYUZyZ0ZFUUVhSXJHOXRVclNCekNSS2FtcGRvcVlOdTliS3dn?=
 =?utf-8?B?U1hEbG5ZT05EZkx5RStqOWcxWndmQU1CK1NTTE1zS0FYWWUrMmhZcitxYnNl?=
 =?utf-8?B?NVFsVEVoTi82YjJNOGpsN080aVZrNVlJWTZZMW00NU80Wm5sVngxZUxuTDBB?=
 =?utf-8?B?TE10c0ZJZXFDTmF5ZFhkQkJZazBBandtQ2xSV28xM3g1bk11Q0JvRWFwbFQz?=
 =?utf-8?B?MER0NXRQdW1Zd1QvQVJQencveVBOSTc3V1BmbUtEMHA3djVjQmpYbTNzOGJ6?=
 =?utf-8?B?SUwyQnY4L3U3alR4SFNHckRQM21YWUdvSHdib0FqUW5mR3gya1JpVjJucjhn?=
 =?utf-8?B?WE12ZnhFaFVmdEhhMlQ0Qis3bEhabzNrdXd2NmJsK3hXR1BiTWV1K2pqa0pi?=
 =?utf-8?B?d3paTVI0ZHppOGpwckR5c0d4ZmVBc3RBYnpDR0FLY1dKdlBrdUlja2NXWjZh?=
 =?utf-8?B?SFhRUllLckdoQmdueWp3bXhNR3M2NlMvbVhNa1g2ZjA0SnBiZVlwMmdpSXFW?=
 =?utf-8?B?ZkVDTXZ1Zk5DWjhOVEZaTVJudFRoeFh4QnJRZStiSVRhTWJQTVhmZ2RVK3dv?=
 =?utf-8?B?b2RmdE40bUxJQlZXYkk2YWxZb0RUTnc4bWJVMGt3VWNmdW41S2swbVNIMmpo?=
 =?utf-8?B?YzdTZHBHbmNBeDczckl2ZC9KUDNYc1IwcHRlVWpEcGszRDl2ZG1ibmdwN1ZH?=
 =?utf-8?B?QzB5bUE4Q1phOVY3azBZdXIxSnh5RUVwcldGNkZhamxmd1FtbUNGMTV0a3Zj?=
 =?utf-8?B?R3I5TVUzb1FIV01HTFI3K1dmTWdmQ3JQSCs4Q2g3U0ZVeENEazVTZDFNbFM0?=
 =?utf-8?B?ZFlIakcwVnh1ejhScG4zSnNvSHFOK3IrTDBUUkZlazRyQStPOStWcW1CYVVZ?=
 =?utf-8?B?K3NiSkY0TG9FSU54cVZreWJ5ZThmUmMySXc0dmM5TG1QaTcxdW9rZW9MY0FU?=
 =?utf-8?B?alB5d3EvUXFGdWRXVmczaERzTlNNb0Y2MkJZWmZsYTR3WEdOanpZY2ZtMjRI?=
 =?utf-8?B?LzlqMWNPWGpzS1J1dTVTTkVMdUhlVDdtaVZrTyswMU5zeVMrMVBXa29CdzRp?=
 =?utf-8?B?Ulp6VHh3Z29PWkVrWmhMT1JkSUNxY1hpRnRSYXFSZ2N6L0pRdEw4RE42RUpW?=
 =?utf-8?Q?rj5hyUzKdCU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGxSdUVPNk9hbmVqL0pxTEdYM2VEcS9hNnhLMWhteVl5M0Y5dWR2cjhRWGU4?=
 =?utf-8?B?VjJpQlg3M1lJQ01pclBhWTQ5aTg2cGtjL0hBSmpoREVpV1d1d1FqdHlkeXIw?=
 =?utf-8?B?Y0dRdmRpNnNGaXdnMHE0RjJZa0MrWXFhNjZPbzlYT3prUHdNbS9PTEE3UGdQ?=
 =?utf-8?B?TG1ub3EyTUFXRkNJNndxK1F5Y2E0T2pwYWJ6STlCT1h3aVBIckNVY25FaEZm?=
 =?utf-8?B?YWI2WlpVYWh2VDAvQm9hZWJWdnZ5cEdzaE8zR1RtQ3BTVUwrc1pZWEtMQVY2?=
 =?utf-8?B?ckJXeWZqTFpJUGVjVHc1b244SU4yWThNV1l4TTRvenZKZld0R2w5KzlBKzNB?=
 =?utf-8?B?VEpaMElaU21LbHI0MnlEMHY4aDhEVXl4T0RHVGxocWhlRWhkZ082MWFpUHRG?=
 =?utf-8?B?d3R1TG5UdVk2LzhQVGNoL0QvTWl1allWdFFsb3RlQnUzeVRGT2RzTDN4bkNI?=
 =?utf-8?B?dzdGQlFVSVVWU3dyOVc2VGFqWUxvV0pVRWRyamlEVnJ1NnRTM2lUOC9MaEFq?=
 =?utf-8?B?NmZQTGlENFF3RkR1cU9xNmovWGwzV2FyVUZvTGphOTUrbzZoQTdVaWlMU3FZ?=
 =?utf-8?B?Q3hMa0d2b0dNTXNvT2ZHS1hSVTQ2MDg2REVtR2RGUXhMZlZBRWRKZmhZSk04?=
 =?utf-8?B?dTBhSlpUclBPZkU4YURlZ1ZuSFFDNFk3b3VNcG0vT1NtNVluUjRpODkxV2ZD?=
 =?utf-8?B?Zk1BcnZMWk5mc0xQaUs1UXlndHU4WlgyREFoWjNmbEZibk5HUmZBdWxlVGcy?=
 =?utf-8?B?bzlHVGhpMUtOS0lnRUtxaW1oT2JycUNSZ1M0SnFURFZqdXhDZ2dqTFU3QTJC?=
 =?utf-8?B?QUpUK0tndEV4MzJBbnJqWWtmM2x1WGRDM1M1VjkwNUMvWmovaWMxalpTbzBa?=
 =?utf-8?B?aWhXVlZBdWF1czBoLzUwRWJ4blBDYitKVlhaM2g3TldmNXg5SXdNT3dBbW9y?=
 =?utf-8?B?Q0tnOTF6ZGdMbVBndzNENys0YjkrejNVdmRvalZLMUpSYUZkZUlFZUU2Y2U5?=
 =?utf-8?B?S0JpQldzcG0vdytzZXZJUmhtZ3dRUVBFUURDOUxuVyt1aElOWUFYN3dpbkNm?=
 =?utf-8?B?dk0rOGtiTzdmMjUrNHFyWk81WFk2dDUzcEpIMitGN0pzdWVmVHlQdEpCNnNa?=
 =?utf-8?B?djAzalpMN0dTVlVkeWJSN3prN1A1S1RzT21JNmJCd1E5TXBBQjBpWmU4Nytk?=
 =?utf-8?B?QVVYbDREa0lETHpqWElYaFFROGEvejJQOWNlMnk0azZ5NmgxZXZzK0p4ZHJh?=
 =?utf-8?B?ckw2Qnc3VEJGRUxuWnMzcnJJazI0MWFHcUV4N21PNmNDcHVOWW9Jay9TT1pa?=
 =?utf-8?B?aUM0N0p4NG9Semh4RXFZR0s3VWZDSW1EcmgzUnZzbHlpYzhPbmZnWnd0SWVZ?=
 =?utf-8?B?VVp0ODB5SjlxeGllSHN5UmRQSlFJZmlKVnpFRkFrR3VXZW1VQmc0YTdrc01P?=
 =?utf-8?B?cm54L0J6dnJETHpWQnBRT091WVp2VEpxUXY3YkNPR1dLTVZ2KzdYaDJxRlVH?=
 =?utf-8?B?ckF3dFN6VWpoTXQrQk90bTFXS3FGaGVRd2ZxZk03Sy82VHZiVmJhMG5Bemg0?=
 =?utf-8?B?SmowQTVMSkxva0FtMEVmQW5xQXJIMkw5UWMzVmtKMFBoalJzMEY2MlJINjV2?=
 =?utf-8?B?YytUMmJqV2R6OUdhd1phRyt6NWhVazVEVVcrKzdRd3ltajlGN1JjVmorcVM0?=
 =?utf-8?B?enlrT3Zha0JuUGxJc3FOTEdtaGNTTWh0MWlXL3pINW5zZ1BsZElrcGRyNVVZ?=
 =?utf-8?B?TjNTeVpmWm92TEtSZ3c4REVtZCtLS0g0UitJUkZaZTEzbTZlY3ZlTXY0RGRD?=
 =?utf-8?B?SEtQSDBzSmdjOTI2a2ZNcjVWOUhxekh1ZGFoTURuNHNSbmFpQm5nNTFrYjBM?=
 =?utf-8?B?TXNyVStOSlBiNDhXSzBXTkVGVFd2TW1yU1UxQitCQ3dKek5LWUx5NUxVSHA4?=
 =?utf-8?B?WEFQTzh3VHJOWjZidVJKdCtaWmdsdFAyNmx3bGZRNXZweTQ2aXVVMmVaeWc0?=
 =?utf-8?B?bmsvb05RV0hCdWtGK0c3cmFjekhXdGtiOFljdkFRQlpNUlhPdklmNDQvY3BJ?=
 =?utf-8?B?cTI4MVVjbmZxNmpJVG1MQXVINkVLTU9WVlpvcjM5S1Q4dTU4b1VBaldPZkFt?=
 =?utf-8?Q?6N+TRJfnulqhlFVkb5KVlNPhL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900f15e0-836a-4637-d8e3-08ddcf9d3241
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:13:41.9501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBlvHfZT644rNOyvdzyKzfbhOO+U6AFrThwD3pn02mAdjpNp8HTuHvecXg1cFvJEiTC0cwo3kAHOoKh4yN8i0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7074
Received-SPF: permerror client-ip=2a01:111:f403:2407::610;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jul 16, 2025 at 11:54:12AM +0200, Luc Michel wrote:
> Add the versal_get_num_cpu accessor to the Versal SoC to retrieve the
> number of CPUs in the SoC. Use it in the xlnx-versal-virt machine.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h | 1 +
>  hw/arm/xlnx-versal-virt.c    | 7 ++++---
>  hw/arm/xlnx-versal.c         | 8 ++++++++
>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index a3bc967c352..ffa7801b30f 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -77,10 +77,11 @@ void versal_ospi_create_flash(Versal *s, int flash_idx, const char *flash_mdl,
>                                BlockBackend *blk);
>  
>  qemu_irq versal_get_reserved_irq(Versal *s, int idx, int *dtb_idx);
>  hwaddr versal_get_reserved_mmio_addr(Versal *s);
>  
> +int versal_get_num_cpu(VersalVersion version);
>  int versal_get_num_can(VersalVersion version);
>  int versal_get_num_sdhci(VersalVersion version);
>  
>  /* Memory-map and IRQ definitions. Copied a subset from
>   * auto-generated files.  */
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 7f40c197072..5e47a20922a 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -344,16 +344,17 @@ static void versal_virt_machine_finalize(Object *obj)
>  }
>  
>  static void versal_virt_machine_class_init(ObjectClass *oc, const void *data)
>  {
>      MachineClass *mc = MACHINE_CLASS(oc);
> +    int num_cpu = versal_get_num_cpu(VERSAL_VER_VERSAL);
>  
>      mc->desc = "Xilinx Versal Virtual development board";
>      mc->init = versal_virt_init;
> -    mc->min_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
> -    mc->max_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
> -    mc->default_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
> +    mc->min_cpus = num_cpu;
> +    mc->max_cpus = num_cpu;
> +    mc->default_cpus = num_cpu;
>      mc->no_cdrom = true;
>      mc->auto_create_sdcard = true;
>      mc->default_ram_id = "ddr";
>      object_class_property_add_str(oc, "ospi-flash", versal_get_ospi_model,
>                                     versal_set_ospi_model);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index bf680077e48..5151822ad56 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -1805,10 +1805,18 @@ hwaddr versal_get_reserved_mmio_addr(Versal *s)
>      const VersalMap *map = versal_get_map(s);
>  
>      return map->reserved.mmio_start;
>  }
>  
> +int versal_get_num_cpu(VersalVersion version)
> +{
> +    const VersalMap *map = VERSION_TO_MAP[version];
> +
> +    return map->apu.num_cluster * map->apu.num_core
> +        + map->rpu.num_cluster * map->rpu.num_core;
> +}
> +
>  int versal_get_num_can(VersalVersion version)
>  {
>      const VersalMap *map = VERSION_TO_MAP[version];
>  
>      return map->num_canfd;
> -- 
> 2.50.0
> 

