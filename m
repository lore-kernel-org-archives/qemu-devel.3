Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A2DCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:50:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzWoI-0001Vk-V1; Fri, 19 Sep 2025 04:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uzWnf-0001EG-QR; Fri, 19 Sep 2025 04:49:12 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uzWna-0006HT-JT; Fri, 19 Sep 2025 04:49:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGUy48tqZRqmd7U07oYwFxt4i8MSYgXMEADFmBilVcCAPSvRwPVRQ23VYuHKjb0vZAJAfsaJ2XVvfO2OYFWSyklbaG/0S0g+p1qXrc9BSCvhU8+sTqZA4DluwNrLcjH5h0m2K+AJKiDFWRqmACS5OKIU8Oh/YOVRCg3EX9lmCGvlkQ0A+AiHCiwHBQI45Gg4B3oyDeV0CrYMJ0nmc0QFLtB+NS52XI3t334+JqFa/SgDGUZILZKUQ42pMVo5prkDYaL8MmGv8nZI3HYYy+Ol95/ZSrHQ8zC40plQLsGxDXFTUmD8Li2NVhmDlk7EbUfhbBJkIwds7enT1EWdRcL5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qS8zTRsdyoUN5QE358FghdNibx0jteFQKhmAD2wQviQ=;
 b=VSXsxh5aZLfNa6QW9yq3hruHNdBrd6zUBYuVa74espUNMrzyEh94NPGVseLacAonSdOJlg0L4hqhUkc1HlIBuphZoeB8s/ZHXoaC27J8W6AutrzrBbJTttblxIG7jlF8RhIECj7reo+tQLoeO+Tm1Quk0VexYfQoB+f24C2SXazJNR7nj82cp2NvnY1Smtm6l+9dpecxLM9n9FDsrqBwkI0e8eyWg945JlTyxiF4w7fr3z5uB8ntrUjbQViVnjTM4LzNwYy4WfKh39khgf1F2TWeyg3l5LWIj73slrJsaWHPqvtWeonnv019Id2p9LFC1Wlqz2anLqYgjgKBUsNB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qS8zTRsdyoUN5QE358FghdNibx0jteFQKhmAD2wQviQ=;
 b=ITg0fI7RWPRgaKStfK64k0rMms41WWmqfhQflwD0wXIvoDrocjK4p8ICsK+yqKZsnOsp4MBc12LxLM02vWxzOffO0kVWYT8czmHuntcl9gFilRvo4GpvZfnFK8bLYLsSFGnE8y/0F8dBVEiAO8jX+uvCAM7q3qDIH2BsFsdnjeA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 08:48:51 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%5]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 08:48:51 +0000
Date: Fri, 19 Sep 2025 10:48:44 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH 7/7] hw/net/can/xlnx-versal-canfd: remove register API
 usage for banked regs
Message-ID: <aM0Y7HRi7RdA8H0w@xse-figlesia-l2.amd.com>
References: <20250917114450.175892-1-luc.michel@amd.com>
 <20250917114450.175892-8-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917114450.175892-8-luc.michel@amd.com>
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 9225346d-a0df-4b58-42fb-08ddf7595afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SWY4R0xBSiswWm12bXdsRlF4T0JlalMvTVkzTlZIM0dNM01Iei9EMVB2OENw?=
 =?utf-8?B?cU9RMWNyQkhxL1RLcU1YbUhZMjI0eVA5T1dEWkVBdzFlaXN5dnRDSE9kMjVY?=
 =?utf-8?B?UjdXcjFhbW1rZFFXK21DR0F4Rk9hRVFXN0M5ZFROUlY4SGFGcCtmYlBPSmNW?=
 =?utf-8?B?ckJPQU9MSVFCU2k3YWJYaklDMEpQNTgzblpzbjFsbjMyd05wR0VFQ0JoL0U0?=
 =?utf-8?B?TVgrY3NIcVZLZ0FFUnQ1MHBWY2VqSFh5eStNN3k5akkvZm52SXRYelRLZnRj?=
 =?utf-8?B?OVBsbncrMFJLdzVIUHNEUUc4WVRYSXE0cEtTa3UrdDFvbmU5QVpVOWNza3lV?=
 =?utf-8?B?aTc0RUJPbHZhOEJUTzF0R094cG9yNWxXMGVnaFZ0d1NkSG9rbWRLMGRVdmhh?=
 =?utf-8?B?SWVVQmFJR2RnYjNLckVlVm1yMnNkNCtLWHc4Si9PanpjN1NvUXJ4SCtpQ0gz?=
 =?utf-8?B?MUROSXBpRnNwaXpqaFVhUnNEbWFqdEFqWmxSYVFud3E0NWZYV0EySTMzYWpz?=
 =?utf-8?B?ejNRRkFyOWVCWncvRnVnVDFyZnhheE1BMkZ1bkMxZGJXLzNDRUZ1Zy9mdGJy?=
 =?utf-8?B?SnNsQ084amVmQkovaVpIWURMVWFvTmZFM2xVRFZoYUY1UUNLeVlGNmg5RERw?=
 =?utf-8?B?YUZHNjJ2c3JMQ3ZmVUxqUXVNQm4zRGNncWtpT2srbTY1WXdJcSt3aTg1N3FG?=
 =?utf-8?B?YmNBSTN3WkVOMzlGTlhtVTd1d1o5dVJmTUFBQk00dzBxSEpMWVNoTnplaVMz?=
 =?utf-8?B?Z1pGUVUxUnpWcG9ndHZSYlE4QUtWeFQ3NVFpcGxQcHlkVjI3TG5GbEVWTEdZ?=
 =?utf-8?B?VXY2UmwrUmIrNERJaFBqeVd1bk11eWlzOXR3QklRd3c1cTE2Nkk1a0srV3pp?=
 =?utf-8?B?N29xMzYwSTZsRXFJZkFxK1RHS2cwN2Z3aWZ3RW1Nd2FnNXh5RWZyVExNVmpr?=
 =?utf-8?B?bnVlbzhPUXBFSWR0c3NGU25VQnhVR05oYUtRcHdKUjZPZVFaVnAvQlUydTY4?=
 =?utf-8?B?MG9tV0RDWUR6YSsxdXp6ZTRabFdBZ0k5R095ZDR5OWE1c2RMcHRrWmRYYTNl?=
 =?utf-8?B?VTNaOUhESmlaYUV3NjQ0VnRZMnVVVFp3bFlJUjFmWGw1aFF6LzRwaUxMLzMr?=
 =?utf-8?B?SnZDWnNaZDRTTU12allZa1kycldQQTJ6TExhOHhmTzZpUFhvMUR0U0xEYlor?=
 =?utf-8?B?M00yVk5yWHN4TVdHNFlGUTljOStXRnhxd2JrMFZFeUdpMFlsTnY3R2c2cHBW?=
 =?utf-8?B?djRjSnpFNm5NRHZvVlE0dFAwdGd0UXMzRlpWa24wSmFJRTVyWm9RcitHRkFj?=
 =?utf-8?B?d0lsVnRKRU5MdzBOU3BkeTlLVnFBZjZpSEpPd01Fd3RqUG1ydURwMHBzWXds?=
 =?utf-8?B?YzJ0YTFXUlJKdVJ1bmw3cU5MaXN4OWNhVmhsYnNUdytXalpnR3N2ZUJ6SkVq?=
 =?utf-8?B?SllnTFRjdFFuNnVxbllSK0l1VWVqblRESXdmSFluUXBVVWRlRURiTExuMm1q?=
 =?utf-8?B?VW0zMTA2WXhvdFhTU3Npd2c0RGpHUTd5NlRKNVBCSkNNNmNpSHFPRjU4bHR2?=
 =?utf-8?B?VVpteWtRbXgyL3k5T0t3UXhSbE9LQlBvbFNpRFRiTG9Pa0tLeFBBY2Q1dTdF?=
 =?utf-8?B?dXY2c2VBL0JCLyt3RjFlSXc2c2lOVndYaUhtV1diZjJCZGZWWmowRkFFS2hh?=
 =?utf-8?B?UHV1SFNNRm1kTjVya3NRc0lyTjhaRGF5UGlJQVdpcExJYVB4WThxV0FSTk9q?=
 =?utf-8?B?Y2Z0TnZWNFNqV0c3OThtOFZEZ1ZLOCtIZWw4L1QyRHB3SnVVRjJkRDQzQjVE?=
 =?utf-8?B?a0JRZms0ODBFdkhGMGtkM25RS1E4MXZyZDhNSDFJRFFrUGtLa29ZckpWNHJ2?=
 =?utf-8?B?MGp5ckpHYVY0RDJTSDkwS0EyeFB5dEJTMExxQ0JRNFBZUm92TEdydDFWek5N?=
 =?utf-8?Q?phbrSzJVV+k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFUwNmhRclkwZWVFcytHMTNSR2ZsdUd3MDQ0ZjdqM2plT0xmNFpQejZIbTRq?=
 =?utf-8?B?TDFLZXhPcWpJeTEvdWJhQmRkdndLRG5nWU5aWEJIV2RLaHRVQWU2R2ZhVEZ3?=
 =?utf-8?B?ekNQRjdKUFc5aWplSzlveFBXSFVNenE5NzZxMHVqdmdsakRuL1FPVmFnR2FS?=
 =?utf-8?B?YVV3NVNMbHpRN21jNEpQd01nVk1sNCtVZjRWR0QzbjNqMk12a092cWpWWkk1?=
 =?utf-8?B?TkVjRGZYb3RtVmJSaWsrblRramdMRWRPK1pBWUptaHRQdlcwbXhFaWlZNXpM?=
 =?utf-8?B?ZlBUeDI4WS9qRkFpeHk0SHdJWDNQcDRRMTRnVGdsS3BoV1FLeUprOENuVXB6?=
 =?utf-8?B?eFhsVG1lbDJ6cFlMb0hmdkh4NWh0WDk1Ti9SaEdJQnZ2aWEwdmRTL3g2TFRE?=
 =?utf-8?B?SmpDdUMzRkx1eWxqTzRha1NGU0hUNjgyV3NCTjJiTzA2N2hKSlk0RmZ3UXZu?=
 =?utf-8?B?S2FmbkFhd3ZObmk1ZisveXVwQVpOTXhWVC9mT0p3TFo2MDZUdWVWSGpvbHlR?=
 =?utf-8?B?dWF6eWVlS25xclduUU1ZTjcrdGxtYnIzWVBKSWh3bU9SR3k0UU16cDFJU3N1?=
 =?utf-8?B?cElLeHZVdCtWNUUyU3B6amVJUHpOSW1sRjRtNE5TeEZMK1VNbzY3bTIxTXZs?=
 =?utf-8?B?ZXpySktLRCtWY3BBSjU5SHpUYUFMQWpwNXdyWHVHUWI4TmxqblZ2NlpXLytJ?=
 =?utf-8?B?RG04RUhOYWFRaVB1VHB3eGtBUUZYanZxY3QweklIbFF6bFJCTEtsRS9JaE9T?=
 =?utf-8?B?d3ZSSDlsSThodlpvSEN2RWdnbS9NTWo1eklwTnJKTlpDQlNWdC8zek52aTJN?=
 =?utf-8?B?Rk9XK1JldGM1WnpUOU9uZ3lELzFWaWpPK3lmQkFHQUtzRkFEcThjSk1rS3ZB?=
 =?utf-8?B?SVBlK1RCUFNaWXBsb05uM1RtUVFQTU9kUlNtT1c4T210elpUNFQrWlluS0k0?=
 =?utf-8?B?OTNINGRoVFhVQXBrd3dhYjNwSUxpdk5MMmw1VVUxeTA1UFJrcmJDR0N1MDE4?=
 =?utf-8?B?anZWMzdmTDU5L0tYZWhwZ1BqV2wydFdOLzZoMlRlOFMrNHJsVEpDQXZScUlL?=
 =?utf-8?B?ejJBZFN1MU00NFlXWlZVR2ZVa21uLzhUMXhoaEpjcGZkVWdhS0NUOGt0ZklU?=
 =?utf-8?B?SlFXTnJoQ1c3SjNFSm9lVElkSWkrYzRYWEpqMWpLc3RPcThtb3FaQVl3ZERB?=
 =?utf-8?B?T0NNTHoxdDdSQ3JDZ3BMajR0Q2FqT1hXdVhVZ3NocTBjYlR4bmIrVm1XVXpG?=
 =?utf-8?B?d0l6QlYrVUZoTmRBMk5YTWhVdTFtRkdJdVJYWWw5QkZUa3pLQ2ZKK25UZXpz?=
 =?utf-8?B?dERzQ3VoWGhSQnNvSk42Rk9Lb3dnRzdrMGo4WTh3V0tCQlpGNUlFYmR5ZE9a?=
 =?utf-8?B?NGNWa3R5cnZ3UVZ5NHpnZHBIU3NrL21SSFZTTklBbXN0Ui9ZNDdjb0JuTDJC?=
 =?utf-8?B?c241OXFUd1BERlJraVgrNFhqcmJjUkZFc1kwTTVtU29qbnRDMWplbGxMYWV2?=
 =?utf-8?B?WVhPM0JFNUZqdVpLMDhPdlN1Um1WL25TMlFSOXU3UGpRT3hYUHZhRE9MMXFv?=
 =?utf-8?B?MEc0VGVHd0tPS0lqL0xzWkF3RzNuTnZYbHN1Tm1BMzdLbkFQY0RxYmN6bkdi?=
 =?utf-8?B?QU5ENnF2WFZJaWZLa21mS0p6VXcwQ21nRW16NDlzeHAzU09Bd1Q0dVhkaW1T?=
 =?utf-8?B?Sk9KeGp4TlAxeVREaVVabGdtTXdvbkZWem56TGVQbjlqMm80dXVxblRGbHE5?=
 =?utf-8?B?LzByc0k0NG5pK2I1U1JaYXFtb2JUMG12Ny8zU2tzcS9yMkxGUG4vRFZraHdB?=
 =?utf-8?B?VXpBTHZyWVVvMlBpaXB1SXIyL0ZWNG1ERXVTUVMreFUrM1FyY2p4dnRWQ0h0?=
 =?utf-8?B?Qk9yaW9paGdKajQxSEZuOFUxWURaVGYrZXllNWY5ZDBHQldhNm1NSS9Cck9F?=
 =?utf-8?B?emlSVUdIVjVUMGl3WFA3M3lrMWZTcWRFMUFzVEhqMG5tV1F6NkJ5YyszQWNx?=
 =?utf-8?B?RU8vSy9XTitOQy83YStjazBKdTRuZSs5MXMvUzhIR1NNeTczZFFjNFRJdHBz?=
 =?utf-8?B?SWtleHh2QU9LT0UxWmZrNXlMMDVGVlh4OW55MXRnZDV3MHNFNHlaNGlqYjR1?=
 =?utf-8?Q?KqjU1Dq3wQ7vHKNpThAVXUl0+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9225346d-a0df-4b58-42fb-08ddf7595afb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:48:51.0533 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfPWTyrJekml0vyg6KtJXyTbpEtMinGNAGE9DbaJoyEJ6WMgXBhcI2r8s6eSvqt/eqVMjUuOlqc9/QjCpIFFaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=francisco.iglesias@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Sep 17, 2025 at 01:44:48PM +0200, Luc Michel wrote:
> Now that we have a simple decoding logic for all the banked registers,
> remove the register API usage for them. This restricts the register API
> usage to only the base registers (from 0x0 to 0xec).
> 
> This also removes all the custom code that was creating register
> descriptors for the register API and was leading to memory leaks when
> the device was finalized.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/net/xlnx-versal-canfd.h |   8 -
>  hw/net/can/xlnx-versal-canfd.c     | 295 +----------------------------
>  2 files changed, 5 insertions(+), 298 deletions(-)
> 
> diff --git a/include/hw/net/xlnx-versal-canfd.h b/include/hw/net/xlnx-versal-canfd.h
> index ad3104dd13f..396f90d6dc1 100644
> --- a/include/hw/net/xlnx-versal-canfd.h
> +++ b/include/hw/net/xlnx-versal-canfd.h
> @@ -52,18 +52,10 @@ typedef struct XlnxVersalCANFDState {
>  
>      qemu_irq                irq_canfd_int;
>      qemu_irq                irq_addr_err;
>  
>      RegisterInfo            reg_info[XLNX_VERSAL_CANFD_R_MAX];
> -    RegisterAccessInfo      *tx_regs;
> -    RegisterAccessInfo      *rx0_regs;
> -    RegisterAccessInfo      *rx1_regs;
> -    RegisterAccessInfo      *af_regs;
> -    RegisterAccessInfo      *txe_regs;
> -    RegisterAccessInfo      *rx_mailbox_regs;
> -    RegisterAccessInfo      *af_mask_regs_mailbox;
> -
>      uint32_t                regs[XLNX_VERSAL_CANFD_R_MAX];
>  
>      ptimer_state            *canfd_timer;
>  
>      CanBusClientState       bus_client;
> diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
> index 81615bc52a6..49f1b174b70 100644
> --- a/hw/net/can/xlnx-versal-canfd.c
> +++ b/hw/net/can/xlnx-versal-canfd.c
> @@ -1425,50 +1425,10 @@ static void filter_reg_write(XlnxVersalCANFDState *s, hwaddr addr,
>                        HWADDR_PRIx " changed while filter %zu enabled\n",
>                        path, addr, bank_idx + 1);
>      }
>  }
>  
> -static uint64_t filter_mask(RegisterInfo *reg, uint64_t val64)
> -{
> -    XlnxVersalCANFDState *s = XILINX_CANFD(reg->opaque);
> -    uint32_t reg_idx = (reg->access->addr) / 4;
> -    uint32_t val = val64;
> -    uint32_t filter_offset = (reg_idx - R_AFMR_REGISTER) / 2;
> -
> -    if (!(s->regs[R_ACCEPTANCE_FILTER_CONTROL_REGISTER] &
> -        (1 << filter_offset))) {
> -        s->regs[reg_idx] = val;
> -    } else {
> -        g_autofree char *path = object_get_canonical_path(OBJECT(s));
> -
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: Acceptance filter %d not enabled\n",
> -                      path, filter_offset + 1);
> -    }
> -
> -    return s->regs[reg_idx];
> -}
> -
> -static uint64_t filter_id(RegisterInfo *reg, uint64_t val64)
> -{
> -    XlnxVersalCANFDState *s = XILINX_CANFD(reg->opaque);
> -    hwaddr reg_idx = (reg->access->addr) / 4;
> -    uint32_t val = val64;
> -    uint32_t filter_offset = (reg_idx - R_AFIR_REGISTER) / 2;
> -
> -    if (!(s->regs[R_ACCEPTANCE_FILTER_CONTROL_REGISTER] &
> -        (1 << filter_offset))) {
> -        s->regs[reg_idx] = val;
> -    } else {
> -        g_autofree char *path = object_get_canonical_path(OBJECT(s));
> -
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: Acceptance filter %d not enabled\n",
> -                      path, filter_offset + 1);
> -    }
> -
> -    return s->regs[reg_idx];
> -}
> -
>  static uint64_t canfd_tx_fifo_status_prew(RegisterInfo *reg, uint64_t val64)
>  {
>      XlnxVersalCANFDState *s = XILINX_CANFD(reg->opaque);
>      uint32_t val = val64;
>      uint8_t read_ind = 0;
> @@ -1590,129 +1550,10 @@ static uint64_t canfd_write_check_prew(RegisterInfo *reg, uint64_t val64)
>          return val;
>      }
>      return 0;
>  }
>  
> -static const RegisterAccessInfo canfd_tx_regs[] = {
> -    {   .name = "TB_ID_REGISTER",  .addr = A_TB_ID_REGISTER,
> -    },{ .name = "TB0_DLC_REGISTER",  .addr = A_TB0_DLC_REGISTER,
> -    },{ .name = "TB_DW0_REGISTER",  .addr = A_TB_DW0_REGISTER,
> -    },{ .name = "TB_DW1_REGISTER",  .addr = A_TB_DW1_REGISTER,
> -    },{ .name = "TB_DW2_REGISTER",  .addr = A_TB_DW2_REGISTER,
> -    },{ .name = "TB_DW3_REGISTER",  .addr = A_TB_DW3_REGISTER,
> -    },{ .name = "TB_DW4_REGISTER",  .addr = A_TB_DW4_REGISTER,
> -    },{ .name = "TB_DW5_REGISTER",  .addr = A_TB_DW5_REGISTER,
> -    },{ .name = "TB_DW6_REGISTER",  .addr = A_TB_DW6_REGISTER,
> -    },{ .name = "TB_DW7_REGISTER",  .addr = A_TB_DW7_REGISTER,
> -    },{ .name = "TB_DW8_REGISTER",  .addr = A_TB_DW8_REGISTER,
> -    },{ .name = "TB_DW9_REGISTER",  .addr = A_TB_DW9_REGISTER,
> -    },{ .name = "TB_DW10_REGISTER",  .addr = A_TB_DW10_REGISTER,
> -    },{ .name = "TB_DW11_REGISTER",  .addr = A_TB_DW11_REGISTER,
> -    },{ .name = "TB_DW12_REGISTER",  .addr = A_TB_DW12_REGISTER,
> -    },{ .name = "TB_DW13_REGISTER",  .addr = A_TB_DW13_REGISTER,
> -    },{ .name = "TB_DW14_REGISTER",  .addr = A_TB_DW14_REGISTER,
> -    },{ .name = "TB_DW15_REGISTER",  .addr = A_TB_DW15_REGISTER,
> -    }
> -};
> -
> -static const RegisterAccessInfo canfd_rx0_regs[] = {
> -    {   .name = "RB_ID_REGISTER",  .addr = A_RB_ID_REGISTER,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DLC_REGISTER",  .addr = A_RB_DLC_REGISTER,
> -        .ro = 0xfe1fffff,
> -    },{ .name = "RB_DW0_REGISTER",  .addr = A_RB_DW0_REGISTER,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW1_REGISTER",  .addr = A_RB_DW1_REGISTER,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW2_REGISTER",  .addr = A_RB_DW2_REGISTER,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW3_REGISTER",  .addr = A_RB_DW3_REGISTER,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW4_REGISTER",  .addr = A_RB_DW4_REGISTER,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW5_REGISTER",  .addr = A_RB_DW5_REGISTER,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW6_REGISTER",  .addr = A_RB_DW6_REGISTER,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW7_REGISTER",  .addr = A_RB_DW7_REGISTER,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW8_REGISTER",  .addr = A_RB_DW8_REGISTER,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW9_REGISTER",  .addr = A_RB_DW9_REGISTER,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW10_REGISTER",  .addr = A_RB_DW10_REGISTER,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW11_REGISTER",  .addr = A_RB_DW11_REGISTER,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW12_REGISTER",  .addr = A_RB_DW12_REGISTER,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW13_REGISTER",  .addr = A_RB_DW13_REGISTER,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW14_REGISTER",  .addr = A_RB_DW14_REGISTER,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW15_REGISTER",  .addr = A_RB_DW15_REGISTER,
> -        .ro = 0xffffffff,
> -    }
> -};
> -
> -static const RegisterAccessInfo canfd_rx1_regs[] = {
> -    {   .name = "RB_ID_REGISTER_1",  .addr = A_RB_ID_REGISTER_1,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DLC_REGISTER_1",  .addr = A_RB_DLC_REGISTER_1,
> -        .ro = 0xfe1fffff,
> -    },{ .name = "RB0_DW0_REGISTER_1",  .addr = A_RB0_DW0_REGISTER_1,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW1_REGISTER_1",  .addr = A_RB_DW1_REGISTER_1,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW2_REGISTER_1",  .addr = A_RB_DW2_REGISTER_1,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW3_REGISTER_1",  .addr = A_RB_DW3_REGISTER_1,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW4_REGISTER_1",  .addr = A_RB_DW4_REGISTER_1,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW5_REGISTER_1",  .addr = A_RB_DW5_REGISTER_1,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW6_REGISTER_1",  .addr = A_RB_DW6_REGISTER_1,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW7_REGISTER_1",  .addr = A_RB_DW7_REGISTER_1,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW8_REGISTER_1",  .addr = A_RB_DW8_REGISTER_1,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW9_REGISTER_1",  .addr = A_RB_DW9_REGISTER_1,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW10_REGISTER_1",  .addr = A_RB_DW10_REGISTER_1,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW11_REGISTER_1",  .addr = A_RB_DW11_REGISTER_1,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW12_REGISTER_1",  .addr = A_RB_DW12_REGISTER_1,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW13_REGISTER_1",  .addr = A_RB_DW13_REGISTER_1,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW14_REGISTER_1",  .addr = A_RB_DW14_REGISTER_1,
> -        .ro = 0xffffffff,
> -    },{ .name = "RB_DW15_REGISTER_1",  .addr = A_RB_DW15_REGISTER_1,
> -        .ro = 0xffffffff,
> -    }
> -};
> -
> -/* Acceptance filter registers. */
> -static const RegisterAccessInfo canfd_af_regs[] = {
> -    {   .name = "AFMR_REGISTER",  .addr = A_AFMR_REGISTER,
> -        .pre_write = filter_mask,
> -    },{ .name = "AFIR_REGISTER",  .addr = A_AFIR_REGISTER,
> -        .pre_write = filter_id,
> -    }
> -};
> -
> -static const RegisterAccessInfo canfd_txe_regs[] = {
> -    {   .name = "TXE_FIFO_TB_ID_REGISTER",  .addr = A_TXE_FIFO_TB_ID_REGISTER,
> -        .ro = 0xffffffff,
> -    },{ .name = "TXE_FIFO_TB_DLC_REGISTER",  .addr = A_TXE_FIFO_TB_DLC_REGISTER,
> -        .ro = 0xffffffff,
> -    }
> -};
> -
>  static const RegisterAccessInfo canfd_regs_info[] = {
>      {   .name = "SOFTWARE_RESET_REGISTER",  .addr = A_SOFTWARE_RESET_REGISTER,
>          .pre_write = canfd_srr_pre_write,
>      },{ .name = "MODE_SELECT_REGISTER",  .addr = A_MODE_SELECT_REGISTER,
>          .pre_write = canfd_msr_pre_write,
> @@ -2001,146 +1842,20 @@ static int xlnx_canfd_connect_to_bus(XlnxVersalCANFDState *s,
>      s->bus_client.info = &canfd_xilinx_bus_client_info;
>  
>      return can_bus_insert_client(bus, &s->bus_client);
>  }
>  
> -#define NUM_REG_PER_AF      ARRAY_SIZE(canfd_af_regs)
> -#define NUM_AF              32
> -#define NUM_REG_PER_TXE     ARRAY_SIZE(canfd_txe_regs)
> -#define NUM_TXE             32
> -
> -static int canfd_populate_regarray(XlnxVersalCANFDState *s,
> -                                  RegisterInfoArray *r_array, int pos,
> -                                  const RegisterAccessInfo *rae,
> -                                  int num_rae)
> -{
> -    int i;
> -
> -    for (i = 0; i < num_rae; i++) {
> -        int index = rae[i].addr / 4;
> -        RegisterInfo *r = &s->reg_info[index];
> -
> -        object_initialize(r, sizeof(*r), TYPE_REGISTER);
> -
> -        *r = (RegisterInfo) {
> -            .data = &s->regs[index],
> -            .data_size = sizeof(uint32_t),
> -            .access = &rae[i],
> -            .opaque = OBJECT(s),
> -        };
> -
> -        r_array->r[i + pos] = r;
> -    }
> -    return i + pos;
> -}
> -
> -static void canfd_create_rai(RegisterAccessInfo *rai_array,
> -                                const RegisterAccessInfo *canfd_regs,
> -                                int template_rai_array_sz,
> -                                int num_template_to_copy)
> -{
> -    int i;
> -    int reg_num;
> -
> -    for (reg_num = 0; reg_num < num_template_to_copy; reg_num++) {
> -        int pos = reg_num * template_rai_array_sz;
> -
> -        memcpy(rai_array + pos, canfd_regs,
> -               template_rai_array_sz * sizeof(RegisterAccessInfo));
> -
> -        for (i = 0; i < template_rai_array_sz; i++) {
> -            const char *name = canfd_regs[i].name;
> -            uint64_t addr = canfd_regs[i].addr;
> -            rai_array[i + pos].name = g_strdup_printf("%s%d", name, reg_num);
> -            rai_array[i + pos].addr = addr + pos * 4;
> -        }
> -    }
> -}
> -
> -static RegisterInfoArray *canfd_create_regarray(XlnxVersalCANFDState *s)
> -{
> -    const char *device_prefix = object_get_typename(OBJECT(s));
> -    uint64_t memory_size = XLNX_VERSAL_CANFD_R_MAX * 4;
> -    int num_regs;
> -    int pos = 0;
> -    RegisterInfoArray *r_array;
> -
> -    num_regs = ARRAY_SIZE(canfd_regs_info) +
> -                s->cfg.tx_fifo * NUM_REGS_PER_MSG_SPACE +
> -                s->cfg.rx0_fifo * NUM_REGS_PER_MSG_SPACE +
> -                NUM_AF * NUM_REG_PER_AF +
> -                NUM_TXE * NUM_REG_PER_TXE;
> -
> -    s->tx_regs = g_new0(RegisterAccessInfo,
> -                        s->cfg.tx_fifo * ARRAY_SIZE(canfd_tx_regs));
> -
> -    canfd_create_rai(s->tx_regs, canfd_tx_regs,
> -                     ARRAY_SIZE(canfd_tx_regs), s->cfg.tx_fifo);
> -
> -    s->rx0_regs = g_new0(RegisterAccessInfo,
> -                         s->cfg.rx0_fifo * ARRAY_SIZE(canfd_rx0_regs));
> -
> -    canfd_create_rai(s->rx0_regs, canfd_rx0_regs,
> -                     ARRAY_SIZE(canfd_rx0_regs), s->cfg.rx0_fifo);
> -
> -    s->af_regs = g_new0(RegisterAccessInfo,
> -                        NUM_AF * ARRAY_SIZE(canfd_af_regs));
> -
> -    canfd_create_rai(s->af_regs, canfd_af_regs,
> -                     ARRAY_SIZE(canfd_af_regs), NUM_AF);
> -
> -    s->txe_regs = g_new0(RegisterAccessInfo,
> -                         NUM_TXE * ARRAY_SIZE(canfd_txe_regs));
> -
> -    canfd_create_rai(s->txe_regs, canfd_txe_regs,
> -                     ARRAY_SIZE(canfd_txe_regs), NUM_TXE);
> -
> -    if (s->cfg.enable_rx_fifo1) {
> -        num_regs += s->cfg.rx1_fifo * NUM_REGS_PER_MSG_SPACE;
> -
> -        s->rx1_regs = g_new0(RegisterAccessInfo,
> -                             s->cfg.rx1_fifo * ARRAY_SIZE(canfd_rx1_regs));
> -
> -        canfd_create_rai(s->rx1_regs, canfd_rx1_regs,
> -                         ARRAY_SIZE(canfd_rx1_regs), s->cfg.rx1_fifo);
> -    }
> -
> -    r_array = g_new0(RegisterInfoArray, 1);
> -    r_array->r = g_new0(RegisterInfo * , num_regs);
> -    r_array->num_elements = num_regs;
> -    r_array->prefix = device_prefix;
> -
> -    pos = canfd_populate_regarray(s, r_array, pos,
> -                                  canfd_regs_info,
> -                                  ARRAY_SIZE(canfd_regs_info));
> -    pos = canfd_populate_regarray(s, r_array, pos,
> -                                  s->tx_regs, s->cfg.tx_fifo *
> -                                  NUM_REGS_PER_MSG_SPACE);
> -    pos = canfd_populate_regarray(s, r_array, pos,
> -                                  s->rx0_regs, s->cfg.rx0_fifo *
> -                                  NUM_REGS_PER_MSG_SPACE);
> -    if (s->cfg.enable_rx_fifo1) {
> -        pos = canfd_populate_regarray(s, r_array, pos,
> -                                      s->rx1_regs, s->cfg.rx1_fifo *
> -                                      NUM_REGS_PER_MSG_SPACE);
> -    }
> -    pos = canfd_populate_regarray(s, r_array, pos,
> -                                  s->af_regs, NUM_AF * NUM_REG_PER_AF);
> -    pos = canfd_populate_regarray(s, r_array, pos,
> -                                  s->txe_regs, NUM_TXE * NUM_REG_PER_TXE);
> -
> -    memory_region_init_io(&r_array->mem, OBJECT(s), &canfd_ops, r_array,
> -                          device_prefix, memory_size);
> -    return r_array;
> -}
> -
>  static void canfd_realize(DeviceState *dev, Error **errp)
>  {
>      XlnxVersalCANFDState *s = XILINX_CANFD(dev);
>      RegisterInfoArray *reg_array;
>  
> -    reg_array = canfd_create_regarray(s);
> +    reg_array = register_init_block32(dev, canfd_regs_info,
> +                                      ARRAY_SIZE(canfd_regs_info), s->reg_info,
> +                                      s->regs, &canfd_regs_ops, false,
> +                                      A_RX_FIFO_WATERMARK_REGISTER
> +                                          + sizeof(uint32_t));
>      memory_region_add_subregion(&s->iomem, 0x00, &reg_array->mem);
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
>      sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq_canfd_int);
>  
>      if (s->canfdbus) {
> -- 
> 2.50.1
> 

