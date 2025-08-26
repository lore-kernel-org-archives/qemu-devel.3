Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5B0CA0FE9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 19:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqza1-0001PA-C3; Tue, 26 Aug 2025 15:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uqzZn-0001M7-6J; Tue, 26 Aug 2025 15:43:27 -0400
Received: from mail-dm6nam12on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:2417::62d]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1uqzZh-000822-9b; Tue, 26 Aug 2025 15:43:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWe9CXjMtcv0RQne+B+QSpLNW3RTRd/v/1kRf/GQLla8kySCoLk0rshl0uj92wAlDzUdCoWT8/Ef8r1Sv379Ir/VCxRFRM+stA2bgTwDSLJgTDbdYz73H9YmQIJBC9lODixySbR2y/uvUS7nGyVLx3xwmGIDK5oqKbL5p6XTkEONaG0V5HQbEbhYjX4W/e5p3wuPGgcLhyRmHoVcgff4jtxfu/K7GuwJFArAwZKNxTt/WSR0GzdCU7n1jqqeFZ3+G57Ngqi1NlSfFbUCFyPKMM/8Vhd3ONp4F5vbmryclRkENBrFIWmO79lTkdtAeKC6RsNhenPD56P94Num0ymjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPLlDdIVwOkWNkY3K6U8IMiLNQmbjUD9LZ+rME+tDuI=;
 b=e+R7aQGFPumsIRbc6gecEHeYof+dzmebm5vch1kf+o1PfONa9V6gDEBeDyTY7cSCRWcqYOWDan6zGCAmMyBQOIz5NOroGriw6pyfJJ4FEvwIXpaL3JRTdtHtvTzH1JDx73yI0obwonib+a4kCOH/0Ik+xI+cQ8kdqZnC5jhVcenQc20YMMn7HTpfsIis6ammKJ6hR9ED3v8Eq5Syu92qB3iOOfzT/K6OjNIzDisku5OfOC4Mh4ZwHRj+G0a75yRojdBSdHNihTaH/cpf17q0njFsXpOpBD1f/UxxgEWHDhPqUhnjq47mKOqq7SGM03O3sIhsHvhAJ2UNSsSv5ORGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPLlDdIVwOkWNkY3K6U8IMiLNQmbjUD9LZ+rME+tDuI=;
 b=2ByOViyrr69Y1xWNP8hfYhGpnY0S1sW63WbBkSbLs2E0e7l1zqKT3vf3CBXSCSVpqq4MsJw7ZadgQadCVXVfIe4dQesjk0nXSyqa1Y5wB26+WREqoeTnBA3j/7h4e7+AEY+eKhwPudv7b9nbfvGIUC/t2LBQxu2MXm1eHhxwdP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 19:43:09 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.9052.017; Tue, 26 Aug 2025
 19:43:08 +0000
Date: Tue, 26 Aug 2025 21:43:03 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 1/2] hw/misc/xlnx-versal-cframe-reg: Free FIFO, g_tree on
 deinit
Message-ID: <aK4OR9xpuSbmJvlE@xse-figlesia-l2.amd.com>
References: <20250826174956.3010274-1-peter.maydell@linaro.org>
 <20250826174956.3010274-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250826174956.3010274-2-peter.maydell@linaro.org>
X-ClientProxiedBy: LO3P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::19) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: d73ba5fa-bfca-45a7-a6a1-08dde4d8c89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUhPbUJjUDVlNks1d0N4c0dCQU5JUHNhajBncmdEbmZvVUJ6Q212Nlk2OFdF?=
 =?utf-8?B?cjF2dTBleE52dTR2YkVWU2lveUJnb0pxeWZXSnZwYjZrOFlJWCtIRUFFQVZh?=
 =?utf-8?B?bnNWY1J4ZGNEWnZ0L0tNY1FYelFWU3kxdjJuQ2taa1RnOEdpaVR2aTY1aTAx?=
 =?utf-8?B?Y3JQUm9IdnF3SDAwM05zelkzeHhWMXI3TUhqNkZPT2pHdkNUcVo0SCtsQWpJ?=
 =?utf-8?B?dnhvM2p1Vk92Y2Vndjc1ZzlIRGE4NWxySXJzWExiT1lIYXZGdWxoYk5FL3RU?=
 =?utf-8?B?Yjd4NldFeG5kUDR5NmlUWnZ3OWxmYTdiTlp2TlNpZ0FiQ2lONlUxZGdhalAw?=
 =?utf-8?B?dCs3eWNhTU9pWndkTWpsbDNucUlRSGN0cFpOdUQ4RXlXODRMbnRlbFgxTm15?=
 =?utf-8?B?VkxMRkFLc09pZFVUU0gzK0JiWGxJRzdWbm9zUytsc1drNnp1ejVDZUJUS1hT?=
 =?utf-8?B?MFVDdStRRG5HeDJEYU55dnZQck9QaXhpR012QTVvSmhmaUlGVE9IaUl6UFg3?=
 =?utf-8?B?UmVsT1B2TlRJREtJTlZ1MUJyZE1XQXZxalkyQWp6YjcxNUJmTmZZT2xJTXRn?=
 =?utf-8?B?MTkvVmRPNXBRRG5nOXI2NkNERktWa0hnUlduRk9KellpYXJrYzMyMCtybHB0?=
 =?utf-8?B?emJWMlNMck1uK29BU2l1bXk1T2E2WmN1VDRtekVlZlpHODQyNG9pcUhGdWI5?=
 =?utf-8?B?MXk5LzR6ZXU2YlA2cnh5bldTT1NCSkJUaUVzMTU1K2hKVDFVZXg3TFppdFA1?=
 =?utf-8?B?S05CR1dlYnBzWHl1WEk4bkhJeFFsYng0bjRFTHlqSWVaeUQ1aUNDYzFnYWIr?=
 =?utf-8?B?OU1nV1NwdDE1ZWxwQlhnNkI2eVdqelBHRWE2TlJmcm1XL3N6Nk9UQ0YwSTFL?=
 =?utf-8?B?aTNBWGJ5YjVDUU90WmVacFVMaHppVlYyUURFNWI0M25sczVMMTZoaVNuU1lv?=
 =?utf-8?B?aFhzVzZEM0hRbWN6bFZ3OTRNbk8veFJJd2tPY09GVHRLYkN5QzdwQ0VhOFIw?=
 =?utf-8?B?ZDFLWG5VUi93eTJKd2xPeVE1WHBWUEF5R0I3Vkp2aE1VbjlXUUprK2doUnJR?=
 =?utf-8?B?MUcwVmZYajU1am5yNkFqMWRISW5vYys4aWdCUE0zV0pnSHN1NnJTbDNaMTkv?=
 =?utf-8?B?VWxSZmxjRGlZY0wrTWxINWtCWnZMUk9WWkZpeU8zSm1kQ0ovNHRyNUw5UXpX?=
 =?utf-8?B?enU1dmlFa0xRZjM0aDdDTkJlZkFGczhJUDJodjRaN0VPeDR0Yy9yci9OTFpi?=
 =?utf-8?B?VXdpU1pEcHBXa0pCb1A2a3NnWGhPSjh2bnAyM2VtckN3ekFLV3oyVHRaTmdl?=
 =?utf-8?B?QStQUi9vbEdLN2Q4cUFUVFMzTnJSaWZobTRsUjNidERGdVNUNHg0NFVFTTdj?=
 =?utf-8?B?QkMrN0Y1Ti9vZVpITHFwT0RrYW1wY3I0RjF1cUswM1loK0hUeEtOTWVvR0Zl?=
 =?utf-8?B?amlzNWg0Mk1rK1VnYW1EaDNXRmV5Ym8rQkJCQkpHVTAxR25sSmRRQjdnV3dJ?=
 =?utf-8?B?VzhGSjVYN0REODJJQUwrRjBXcjJuV3h6azJaemlsRWg3b2t1TDNLRzRIU1Vv?=
 =?utf-8?B?NHRqd3N5QW1BWWtvV3ExUFVLQjRkRmJUVVdZUnZ0NEJ3UC9EZ0lxOGtKZXBr?=
 =?utf-8?B?aEpRdWlWMERFWDNTaFJtdndEUVl3Vlh2ZGFndCsrTmw0S3hKeTA2SzVVUmd1?=
 =?utf-8?B?WnZSemFJcUQ3TE83cmllY1hWL2ZBWHE1UnhDdm5KS3BXTWZUNTM0Q1FoRTJE?=
 =?utf-8?B?YWpzdVJDMmI5SGZBUUxmakdUKy9vaVV0VXh4UDhQemFNYmYyK1hSaU9aa2Vp?=
 =?utf-8?B?OWtYaHBaVFhadkdwa0d6Znl1eldTM2wzVFhyanhYWU1XRXl0Z3UrL0hnQTBr?=
 =?utf-8?B?QUUzaHhhL2x6ZkIrRWZzU3NoK0JHSDZHTXJBekdrTy95ZFB5a3BtZ3dRMWhU?=
 =?utf-8?Q?MezQc0FGUjQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3dndXVTT0NkdmR5Z3RKSEc2NGYvMkZnMXdrRDJONlMxMFJPZ3ByYXY2ZGp0?=
 =?utf-8?B?d0g4SHRhY0UzSzdoc2Q1T216WlJjR2c3R29PcTVCcWRlM1FaaE9sMUhOKzhB?=
 =?utf-8?B?NGkwNmQrTXFaWStzL1dmcEJVa2hsdUdtVENhd2tWM1k0ZFlDVWpja0g2Sldo?=
 =?utf-8?B?QVhYTVFpSHM2SU9iKzlvOTkyZFg3ZS9zUng3TTVmZEFQblhFN2o1UkNteFlw?=
 =?utf-8?B?Q0hUK1NnSzNPRVFIdGJYRFMyRG9rL2lOTkJCOW9yLzRzdFpXZXdlQ29OMFBh?=
 =?utf-8?B?clN3Q1dOYWMzNUU5YkIxT2ZxUnJkd3BSQTAza0hiRDUrQ0lKNjdtUGNDREJ1?=
 =?utf-8?B?UEhQZ2lVd1MzV0FsK2NjKzE2Z0tEOWpFanUzd2lVMHpvanJuRHVaYnRxVVBw?=
 =?utf-8?B?RE5PdDNRUXVFMVhFMkwvR2poT3VRK3docDZBMytFbGdXdldNTXpUeHoxUC95?=
 =?utf-8?B?Y2N6b3ZWSzUwMEZhVEJpaFJJT0ZCRjBSSThmYzhUeW85ODFlbTZ0UnJvM3Jn?=
 =?utf-8?B?SHVTeHovdTMwWm9CcG1tY2NNSVdSRnVsY2Q0RGxoVm5uNWJDTmdZdWxnUjYz?=
 =?utf-8?B?eW9YejBnNThoemZPMmNuSmFkTFliQSticGNQcGRucFoyLzVXdWY4UGtmeXNE?=
 =?utf-8?B?TG8yUjQyc3FCb0hQaWNSaWtUTXBPS0Fhb0xUUTRhVmFUV0ZVRk5VTXY4QURG?=
 =?utf-8?B?Qk00ZGcvM3V4V3ZzUUY3ZlBTdS9La24vdDYrMTNxdWVpZ3lxTWplYjVBRGZz?=
 =?utf-8?B?dHExVklIaVJRWm00c1Z4b1pSSHp0UWc5eGNINXRKODNCRjNqdXNPcjN5ck0r?=
 =?utf-8?B?RHNjVy9kSWpIdnRMNHlmeFo1LzgxcU5aSVBQMW5YMnJ5VlhicHVmU0RKOWRU?=
 =?utf-8?B?SG1xaUlnQXQ5VDByN3RGTFQwWmRUamh5Q2RSbkFSci9pZXVtL0M2dVlQdS8z?=
 =?utf-8?B?WGJKUmF5ZWtXelhpMTJUOHNJZFcxdjd6eGI3VnArUEswRlZFbFczZTlMcHZl?=
 =?utf-8?B?TVMxb1BvSVFERnhzSm9YdWxzWDZGRHdnTzFRMFY1R2w0SGpQTFY4ZUFzMEFm?=
 =?utf-8?B?SjBZL3YwbE9Ob0hIWmZrcWdyRW1VU0lrQnhELy9hOUFtV0RaaGdSS0VmOWNG?=
 =?utf-8?B?QTRoTUFvM3BTZ0szSUNVU0JFRElTRmFYNU10ZWRwN3pFbndQVWMxOVpWTXpB?=
 =?utf-8?B?YUgxcWhnUi81T08yUEhCS1RVM2tscWczTlNLU0NSVmtKZWdyK09LWXRqcTdx?=
 =?utf-8?B?SHdMUnRTR0IrVU9PL1VHcHNGTTdHWUdUWUQ2dEozM3pkb082MXVWOGI3UVJv?=
 =?utf-8?B?ZmxJVFBMWVMxd2tDN0hvWEYyQVlOVFNXUWNIb0xJY05TNW1sNURuMVBITWJR?=
 =?utf-8?B?MUFVZUUxQllPWWxaaFBiRm5DRURCRnZrYTAzaFg3bEF4aGppZUZSbmc0R3V3?=
 =?utf-8?B?KzArVDI0SGZEYkhkbDEzRkEvVTA5RnRkS1QwOFlSZzBVbFFOS3c3bXhNeEsv?=
 =?utf-8?B?ZUUzL1V2MkYxb3JUc2NwUDMrY0UwUmpFWFN4d3E2eEwvVFNaSWlZc0Z0bXFC?=
 =?utf-8?B?TUVjdDYwNFVHVk9mTzF6a2hKUlBSUUNSQURuUW1RTXlNWnRqZlY1Z3BMdkdZ?=
 =?utf-8?B?ZEtWVTdBaGczZjYxdHlucWV4bmJKT1kwY0lwKzFEZlFWUXM3YWN6SkYxVElI?=
 =?utf-8?B?NlU3YWN6VjFkMzV0c091S29oblZSeXhuTFhXeng5ZVFHSGd0RzVSQ3hoTGRl?=
 =?utf-8?B?NDg2QkFSRS9RWTB5OG9VcHB5WUJYcy9TSzU0bC82bERsRDJ5RzRVRkhWdTRN?=
 =?utf-8?B?RTVnVXZYT2FmSktUVU5aZFl0MTJDUUQyM0M1bktJd3F5c3JhWC95bkI4NkVt?=
 =?utf-8?B?NFoxZ2NiL2VXUTUveUd4Mzdpc2xKRlQ5RU5jdG1nSmt0eWhSM1VjRyt2TFBH?=
 =?utf-8?B?TFY1S2ljL0hyKy96YVZOV1BWUTg1OWRITEl1OWY4Z3A5YUd3ZkZjSFJUd2Y3?=
 =?utf-8?B?bUY2ZW45dmhrcTh4dFY0bE5YanNIVktBRzQzbFhZaXkwRStocVBCeVk5bStN?=
 =?utf-8?B?aW4ybWFzS2FDY0ZBbEpxaVVVQURxSTJ3NkhFekdUWXgzbEFMN29tbnhXYU82?=
 =?utf-8?Q?HQhBcigFhojWiBqX0fdB65uJt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73ba5fa-bfca-45a7-a6a1-08dde4d8c89c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 19:43:08.7772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyVyOrQ/5tfDRYM2oAVLdvCuMgcplhzTL1bA8xLgfExlzCnPs72BQKdRER9/Jo18COWRJOGD4ThfqA2ddgUtsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024
Received-SPF: permerror client-ip=2a01:111:f403:2417::62d;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
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

On Tue, Aug 26, 2025 at 06:49:55PM +0100, Peter Maydell wrote:
> In the xlnx-versal-cframe-reg device we create a FIFO in
> instance_init but don't destroy it on deinit, causing ASAN
> to report a leak in the device-introspect-test:
> 
> Direct leak of 400 byte(s) in 1 object(s) allocated from:
>     #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c53fecd904ba5fc1f521d7da080a0e4103b)
>     #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>     #2 0x5aded850059d in fifo8_create /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../util/fifo8.c:27:18
>     #3 0x5aded582b9e4 in fifo32_create /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/fifo32.h:35:5
>     #4 0x5aded582b326 in cframe_reg_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/misc/xlnx-versal-cframe-reg.c:693:5
> 
> Similarly, we don't clean up the g_tree we create:
> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>     #0 0x5aded4d54e23 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-aarch64+0x24ffe23) (BuildId: 9f1e6c5
> 3fecd904ba5fc1f521d7da080a0e4103b)
>     #1 0x71fbfac9bb09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
>     #2 0x71fbfaccc799 in g_tree_new_full (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x93799) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d7
> 5)
>     #3 0x5aded582b21a in cframe_reg_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/misc/xlnx-versal-cframe-reg.c:691:18
> 
> Add an instance_finalize method to clean up what we
> allocated in instance_init.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  hw/misc/xlnx-versal-cframe-reg.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/hw/misc/xlnx-versal-cframe-reg.c b/hw/misc/xlnx-versal-cframe-reg.c
> index 1ce083e2409..95e167b9213 100644
> --- a/hw/misc/xlnx-versal-cframe-reg.c
> +++ b/hw/misc/xlnx-versal-cframe-reg.c
> @@ -693,6 +693,14 @@ static void cframe_reg_init(Object *obj)
>      fifo32_create(&s->new_f_data, FRAME_NUM_WORDS);
>  }
>  
> +static void cframe_reg_finalize(Object *obj)
> +{
> +    XlnxVersalCFrameReg *s = XLNX_VERSAL_CFRAME_REG(obj);
> +
> +    fifo32_destroy(&s->new_f_data);
> +    g_tree_destroy(s->cframes);
> +}
> +
>  static const VMStateDescription vmstate_cframe = {
>      .name = "cframe",
>      .version_id = 1,
> @@ -833,6 +841,7 @@ static const TypeInfo cframe_reg_info = {
>      .instance_size = sizeof(XlnxVersalCFrameReg),
>      .class_init    = cframe_reg_class_init,
>      .instance_init = cframe_reg_init,
> +    .instance_finalize = cframe_reg_finalize,
>      .interfaces = (const InterfaceInfo[]) {
>          { TYPE_XLNX_CFI_IF },
>          { }
> -- 
> 2.43.0
> 

