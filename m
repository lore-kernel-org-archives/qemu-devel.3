Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE26CAC5A7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 08:48:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzWmZ-0000bU-UN; Fri, 19 Sep 2025 04:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uzWmY-0000b8-CR; Fri, 19 Sep 2025 04:47:54 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uzWmT-0005c1-Ex; Fri, 19 Sep 2025 04:47:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHd9fWq6xBCMhFpO/4gGgPz9ADOzgVrdNvdQ8dDC8FCm9XQ5bRGUzBXYiYpgv6SZPIDnhU19RQgv2/xNvUIbyMWLd6p/9bXolKMIiZHKLwDvd4ajpRD11m9uM6YEfOHbCsWJYRvu5Hah0ZSZbMQBhxVBKNOZlVpD9UPNtYrhArZEeolub/IDu1QE+IGl3LY4fJ7j8kYZxuI4iyaFAKzRjwz3KDLAQMTEdUOrv5x1zFRPmz3J82ZJUVmHANO0mMrd4sNVf9kqYYktm0BvOi1ElfZaopprTgnSodoYtbyWCRMYM4JXgIINof0E/75SlxsMHapLM5E5o1oMKA8bzWLQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOsi7DgFrY6L0AITNV24NSDI23Vl+ln3L0cBYJTYbN8=;
 b=Z1z1HTdBTVGn3mzSvlA9F2ncztcneFIalx8iwXwpvDS0Tr3i1t3OicoVTfq1R3zYiGEMBm+B3Fz5MsyUWtJfmZfx990BmVmT7oUpudeSksZ4GJypx78pEZ+DRJhO8W47CGL7rg0aD2grm+TEbXKAY49qvRQkB1T8tFxd+IvqKWZS1BQEOnXseXm5sDVPV/nFHvmmosa7NuR2QAMp7ilCypgXN3OsQZa2llTmKMRx4ExpU5dYoWqXYdCgRa0bR6OkNWrGJC29WeeFE07BWwl+v8Ja3fLOQOjJtKV++UKPWoCakRzc1NMahjI3+vuncMc9RGu9WSNS9GDbJfbZrDhKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOsi7DgFrY6L0AITNV24NSDI23Vl+ln3L0cBYJTYbN8=;
 b=tR4T3L2TV4px+MIN8UF2jOfFQc/jDpb4WJBWaXc+AAKkTfyjhnuO/ADsz4xYTRzf4TOK/5v3psW0CBQdKoX9vmVjZEtobp0li/3LQxMp0qEgMU2fFZxL7T9upuCH+rrMNPKs72gwHTsh/+66gE9xBe0T42j5q9YHxCc+CG55mbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by CH3PR12MB8510.namprd12.prod.outlook.com (2603:10b6:610:15b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 08:47:40 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%5]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 08:47:39 +0000
Date: Fri, 19 Sep 2025 10:47:32 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH 5/7] hw/net/can/xlnx-versal-canfd: remove unused include
 directives
Message-ID: <aM0YpGAYD59Gz4Vg@xse-figlesia-l2.amd.com>
References: <20250917114450.175892-1-luc.michel@amd.com>
 <20250917114450.175892-6-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917114450.175892-6-luc.michel@amd.com>
X-ClientProxiedBy: FR0P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::9) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|CH3PR12MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a9997d5-77b2-4cb3-164c-08ddf7593053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0ZIT1paTlVrUlFEV3lwbURPRjFWWUFGMjZiZWxRcUk3TmlWODVyRkYvSUVK?=
 =?utf-8?B?VThXMVFEMktKOXhQMk1VWC9WeE9DcTkzV3N4cmJzZERlb0gzVmozdnVaYXIx?=
 =?utf-8?B?VFVZZkJNWDZGTHZMeGw4Z3NTVUpnQ3lmcDZGOEwvQ0g3czFnNzZCUFV6UVZm?=
 =?utf-8?B?RzVkdjJQbE1BaVJ0UWJ1VSsxYi9ZSnlYUC9odzRLejkzRDZGVWZnWVZVbmJD?=
 =?utf-8?B?eWx1eXljajZ0UEk0MmZCdEJqZ3RxbDFjS3ExcWUvTzI0YTR3ZTFzVGRGQmpi?=
 =?utf-8?B?aWRUbXlHdUQrdlp6MlI4VzAxQS9jcklscWJYbFd5Z0JxZkI3WVh6bnRhcS80?=
 =?utf-8?B?bk8yM2wyTlRtQzYvL29EU2djaUxJd3NsaUJFZVFsVmgzVHdUcE1SNkh6WElq?=
 =?utf-8?B?ME5Xd3gxUHBkbnRCWng1LzhPMnc3UFg5OVdjZEs4TmFwNU1PMDFFTkQrOEor?=
 =?utf-8?B?U3ZhNWJYbnNnYTNLWTFHeVpqcG40M0pHMDR3b05qeTF4b0o1d2lnWmRQRDJN?=
 =?utf-8?B?ZFA5SDBLeVJIaFFiU3B2VWxqanhGRktDU0Y2YXdMZHpZRVFrRk1MeE5LanU4?=
 =?utf-8?B?SGVIZmVzZWZyM3hPVTJIellFUllaRDJ5TERWV3FrYVZtcGVKS0FGUm0va2NN?=
 =?utf-8?B?cCtyQlNuZ0lKK09BTXRCUVlRNFJabDZmWWdtT0ZNTTA5UU1qMDBSQkN3V1Vj?=
 =?utf-8?B?d0tDWmlORDB3eTFOV3R0SXJUT0R4LzZQOWg2dkNlVHNxeFEydXJleVVCRE4r?=
 =?utf-8?B?a0NJNzhQZ2dhNXFHL2RoZkdXWnZiVmkyVE9hSVNaQlp1c3hFWER4V0J2T0RG?=
 =?utf-8?B?T0dwaGhyeEpGcHpUWHJIdWhQMythc1J2eVBYVTdBWVlUbDhNd0pGZEM5UEJt?=
 =?utf-8?B?L1J4UG5qV2xCamxRUFNTUGV0Umc5QjJKRXBjVmxMMUc2Qkx6MnJBZG5Ya0ll?=
 =?utf-8?B?cERpNlVEaXNpWE5RdDhIeUVoblFMMDBmRXgvczR0MXc5ZjZhRUg0c0MrcWpa?=
 =?utf-8?B?YmppY2RHOFFxRzhURUsvb0xmMW95ZU13K1RndTQyVk95VEtHVWpEekZGcjJI?=
 =?utf-8?B?MXhWOWFuMDUzUytxZFJMczhKMlpNMmkybDFYa29JM3hWTk5aZmN5czBpUmdE?=
 =?utf-8?B?dGVwNVlnTVFIS2JTMnVlbWhaWERVUXVIZXhrb0NUMTlDRHFjaWdRNjVVa2s5?=
 =?utf-8?B?MzJDQkNNVEVQcTNtdzFUUUZoL0ZtYmdxSFFLakJlNVVyL1ByTFpkWnlKeTRV?=
 =?utf-8?B?cHFjQ1F3ME1RRWt1b0tmR3JMenNJSWFqdUM3ZEFkZnFOYlJsSHN1U3JVRHFT?=
 =?utf-8?B?R1FxZy83Z3B0Ulo0TWZQRTNQeHZrU0hVQzQ3QUF4Uk1OTkVzdEI1RlFWd2Qz?=
 =?utf-8?B?T2g5ODlGaFluWjFIM1UxMnpQazBMSC9NR1pnQWVmV1ZYVCtzcWd6RDc2VDdG?=
 =?utf-8?B?SmwzcEZYNHJxd2l1R3BDdGdFWmdBU0MwT3ZudzhDY2NCaEU0VW9JUVRiUVl1?=
 =?utf-8?B?MmdGeUVuclB6blRxbXJFRFVNM2tyRVRESXBVT0xHRmpQbUd1MzNRR0hXQ2J1?=
 =?utf-8?B?V2Q1WXNWOUQ3aVQyYmIwc0loWHhVSlovUXBSY2gvSE9Oc2Voa0ZPNXBncmc0?=
 =?utf-8?B?SHdGeXkrMGZ0cmNsRkxmTTdOL3ovZ0hwSjM5NGpxVWtxd0lSd1pOYUtmVG0r?=
 =?utf-8?B?cjBueFRKWGtDUHAwQ3lWQ0hlcEM2MG9QVExZVzl1M2VmbE5BS0N0a1BiNlVp?=
 =?utf-8?B?SzR1SFdUMnBXc0FiTExmV1FoTDZDL0pING1KWkJMcFhiM0h6aWxMNW1RRlJ0?=
 =?utf-8?B?Ry9jdzMwdStodXZFQ2VVcUVKS0ttL1dwYXlkR1daR3NqbjR4TFlxblRmbStK?=
 =?utf-8?B?dE9OK0V5Q3Q3bjV5Vmo0eWh0Qk1aQzI3ZXZxdFNLUmE0bUp5QWRFM242VmNa?=
 =?utf-8?Q?jXlhOSmcRXQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2wyRGZCRWV4VDNjQnRkalZmVmh6Ry85Zy8zQ3ZUVTBpZGxCV3JEKzZyWUUr?=
 =?utf-8?B?UDRwbHlJWTk5aGRlSFduUXA4NFovUnU3Q2VwYzA4MS85aFA2UWZncHNuTTBP?=
 =?utf-8?B?TEpEZlZnbC9NWThCVHZBSDQxSkZRb21laWdKc1h4ZHRxRmdNeCtRUFZjaHZJ?=
 =?utf-8?B?U2VDemZEbVgzQk93aTFPaXhuVStQSDFNMDB3enJCMkM3V2ticmpkMGNDak1D?=
 =?utf-8?B?RDY0cnMwTzR0QzRhZjNyclRsQmc4MVdUdDNQdHQ4U01tSzZrcnFnRnozbFEx?=
 =?utf-8?B?Wi9zSDFuR1h5VGF6aHMzRXNER0NheDNmOUxPbHdmS2NYSmpSY2diY2NVNjRE?=
 =?utf-8?B?dUFmcEFnNy9hcE05SlJsQnRmYURxcExlQTh6aHkvY0RCS2pubFdCaUEzUHRI?=
 =?utf-8?B?emVpNzlTbjQ0cVQ4RW90ZGNxL1l6U0FNS2Rsbm1kbTR1d2JQVjNxZXZJek1N?=
 =?utf-8?B?MEpza0RnNUZSSDZnSGFreVNpUy9BS2J4UjhhT0dEMndsME5vNkVFa1REMnNp?=
 =?utf-8?B?cXV0aXl6cisrMldYaEwyVllCTWE1V2dESzhubW1ETWprREdsamZ2a0J5Q0xl?=
 =?utf-8?B?MEZyTERQb0JpY1RUZi9ZYnZscllUTXVVTkNHWjJBMWZaU2tpZG5mTTVCUWZu?=
 =?utf-8?B?TFhMMWVsZjVSamhnZUZ0OUpyNXJQKzRvNnhHL3pFVlBOL1RiM2ZnRTJjV0JR?=
 =?utf-8?B?Ym5sV24wNCtsRHlTY0JkM0J6c2FHYkxPTDcvWGl4VU44VzNKNldmOHRSa3hj?=
 =?utf-8?B?S0xnQ1pIRWdvc0wzNlFIeGhjSzJUSzk2Q2xIaXJsNEZabkFJcnQzRm5rMjlW?=
 =?utf-8?B?a3FRNzFPR1FrSS85Q1EzMUUyRjV5dlFHZDBhQWhsT3ZxNGQvd3Z0bjZyalRL?=
 =?utf-8?B?Yk5zWnVpaURET3E0blFLVVRRVlJZYUd1WEFzRXA3ODBMQU5SN082ZnZPRDkz?=
 =?utf-8?B?WUx2aUxJYkw1a2FtRGRKZUtZUVFaeXpTREJxTEw3dVVIbTloTm5adXJmc1U4?=
 =?utf-8?B?U29iSVBpTnErS0pCM2o4UHRpSTF6TVJhYXlqUm4ySW5ST3hNK1VXaXFiQTF6?=
 =?utf-8?B?NXZnemdCemkyeVJ5OE9DMmcyeVVKcVRDdmdaeUdKQlp1S1BkQXZQK2VhOWcx?=
 =?utf-8?B?ZlB2S3BkMC94dWo5bmQrSWtkQ1ZHU2dqeCtka1l0dHkrcjcxSzlFWW44L1k1?=
 =?utf-8?B?bDVVWGZrMjlmQmZYc0RZblJxdVpnZHBWR0JNVlRpRjdDb2ZnZ3hkSjNKYXd5?=
 =?utf-8?B?a1VONThRTElCRWQ5dEVNRnhYbTg0b3gxanorYWx1UHU3RDJvOFFvN0lqc2gw?=
 =?utf-8?B?QVZTNFRzT0pibU9SbU9iRHp0WHpFNzZjQ1NKZ0I2WjNkSDlINGlEbTk5MmR1?=
 =?utf-8?B?cXd5bGo2eStyZDBKZk9jTHZydHpDYUhvR0pDdmxZcUFFMEE1WDZxMlZENkR0?=
 =?utf-8?B?MHJHWkUrNFNHRWV6TXEzcktZREVTbFAyYTgvTmdLRzJUekFFbnRDR2YrMzNk?=
 =?utf-8?B?UHIvdnlmTmQzbFBNcTlQZE9aR0d6eUd4RkdYSCt2YjRlU1UzZW1wdFo5S0Fj?=
 =?utf-8?B?cVBjaW1yTnFkUUNTNDFid1JjbTFMaG1iU0dnRllsSDdtR1BpQjAzMnNZR0VN?=
 =?utf-8?B?dkNjTXNQMXVWNXRoakx3eFZDdGhleVdJbEdBcE01YlRQcDVpd2J2SFRKRTVs?=
 =?utf-8?B?ZDJNSTU0T3UzRVM4aUE0VllCclNOUHAzVGhTTHp5d1NYNHdNRjNZQ3NyQ3J1?=
 =?utf-8?B?aXRSNWpHdWlIZDk2TWxTdmxpWkZXb2JFOCtZRzZqYWk2UnZDWHFDNXRURmFG?=
 =?utf-8?B?L0xaamZCTENLVFFSd3Z2WHRLcURGcWZYbGJ3YTIvT0V1Z3FKaEdMbCthRWRP?=
 =?utf-8?B?OEdWenhNRVBDczMrM2pRdWl6NU5obUViREpMckpKbXdoYU1JcFV1T2dtV3lx?=
 =?utf-8?B?Nk1ieC9Mck4wbkdEWDFQK0JZU2lsZjMxVWZaVjRHTnVqVmJyWS8vcDZTU0tw?=
 =?utf-8?B?V1FXWkVjR1pXWnNHVGsvamMwa2dUVVNDdXF0WEFpUGNEc2pUYTNmb2NuTWQx?=
 =?utf-8?B?QVk4WkNaK1Q1cVVLME5DVFJMNlFLMUYyVTVJYi9VKytKNUxvcTY4SXlEZjky?=
 =?utf-8?Q?Zc5dwL35+jJdpztdOgmATMk/W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a9997d5-77b2-4cb3-164c-08ddf7593053
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 08:47:39.3227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gKhebveF+PgPSCOrFC8LTExNXOFKQ5f14DNztOlbbZwtqCpGULMfYh3GUWlbIcxPMt3Blp+GgPwLGNYRIjWztw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8510
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=francisco.iglesias@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
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

On Wed, Sep 17, 2025 at 01:44:46PM +0200, Luc Michel wrote:
> Drop unecessary include directives in xlnx-versal-canfd.c.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

    Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  hw/net/can/xlnx-versal-canfd.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
> index 3eb111949f8..343348660b5 100644
> --- a/hw/net/can/xlnx-versal-canfd.c
> +++ b/hw/net/can/xlnx-versal-canfd.c
> @@ -33,16 +33,12 @@
>  #include "qemu/osdep.h"
>  #include "hw/sysbus.h"
>  #include "hw/irq.h"
>  #include "hw/register.h"
>  #include "qapi/error.h"
> -#include "qemu/bitops.h"
>  #include "qemu/log.h"
> -#include "qemu/cutils.h"
> -#include "qemu/event_notifier.h"
>  #include "hw/qdev-properties.h"
> -#include "qom/object_interfaces.h"
>  #include "migration/vmstate.h"
>  #include "hw/net/xlnx-versal-canfd.h"
>  #include "trace.h"
>  
>  REG32(SOFTWARE_RESET_REGISTER, 0x0)
> -- 
> 2.50.1
> 

