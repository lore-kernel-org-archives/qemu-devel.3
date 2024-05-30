Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0D0C27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCgqE-0006c7-Uk; Thu, 30 May 2024 10:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1sCgqD-0006bX-IC
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:33:17 -0400
Received: from mail-mw2nam04on2081.outbound.protection.outlook.com
 ([40.107.101.81] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1sCgqA-0006OX-0U
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:33:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frurGvDZmfrwLafw9LMcW9maBBe2370FMAmuB/vC3Iyf1jwsrHVyZUCgPoDPRFH4b1aC+DQ6SlRy4o8PQ5O9xFnc61UX16PkbbXL1DaV8mDVmDZtbaFv51zlkg3WRlQMTsg0b/W6Db1zeTHOHNbBuX2aFyraUnFYYSWhatdEZNqpBn6zwRp6UsZrdYc7QAMtld/rZKyRO4HLD7OVfijpwWD2RfySaxvla7uCLt1Rp+/Gm+xIETkw77RZj1gVxkkC3Gs0tli8qPIvBz30QKIo/YBWHn4/9y/R7lBuJCYB/tg2jYIKKf/ZVJAWElgSRqEMuGqOs7Wg0Vw/yUYcmU47fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amLrxZeLB/aYDJAjAIQtHJfc5TC0npQXkQTcvUrBiNg=;
 b=XTlYTDfljHmPtud2/ZX8fN4IHB9YFiEifvHz3xzIt+TfLpzHQygUa9f6/B/NxPPnOxKGbAYaNAlpzGFDX+ugtwUwkHTDkf+eql+Th6ZyM0s8aJYGkgpe6DBB+p1sgQBYAOREpHagt8fS4EKM3mf8HwDabDOWwODsPJQkj7eIWvC4WDLHe6UfPe8KunurMQ4W5oH+DeVaMgtu5ZA4on2gM5E/cIVK7yZEH0ZTHgdU6AfoNeOUzoyBz0Fnw9dqlwEVBd1oTrl05gmbcodescMVWEozu2RkZHwp+DC5N0X621kvdDgBm+g+5KvLAl5m+0oPWd1VBCnZEpjX95I/GAMyiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amLrxZeLB/aYDJAjAIQtHJfc5TC0npQXkQTcvUrBiNg=;
 b=ZEOfl7Lr8qB+AIEXxHf0RGcwHTgW6UHxD/Bedhkj5vI56l0dRrgnIL+gVqZBW41Fhh13s0RXpqbjBrYIU5CL9difQG/KTICPHRzf0+L25WClfWJZ6s9Wn+4Y7fxycr+9gq1wDW5fGtN7iGCs2W7n1JsIv3P3sPeHFO3jkHiWHk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.34; Thu, 30 May
 2024 14:28:06 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%5]) with mapi id 15.20.7633.017; Thu, 30 May 2024
 14:28:06 +0000
Date: Thu, 30 May 2024 16:27:52 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Shiva sagar Myana <Shivasagar.Myana@amd.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, pisa@cmp.felk.cvut.cz,
 sai.pavan.boddu@amd.com
Subject: Re: [QEMU][PATCH 1/1] hw/net/can: Fix sorting of the tx queue
Message-ID: <ZliM6B46806qw4sv@xse-figlesia-l2.amd.com>
References: <20240529102458.557522-1-Shivasagar.Myana@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240529102458.557522-1-Shivasagar.Myana@amd.com>
X-ClientProxiedBy: FR3P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::14) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: 454ad283-bbf5-4975-f272-08dc80b4b87b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0VEYXlXTmhzejE0dGFUWnpHN01YUUJ4Yk5kWC9ZVEw0SmdIaXlHZ1lJVjUz?=
 =?utf-8?B?dW1KbERxMzdWOVlWNFc1N2xLRzd0NGpuM1ZBcTgwUXVQK1dYVlM3QUhLUFRS?=
 =?utf-8?B?ek4rSk1TazRYcEJMWE9vYy9yVWNQOW55TXNDbGtqQ0dDVC95djZON09MQ2lF?=
 =?utf-8?B?bTYrdjBKYkRnY0ViaTJTMk5FeFc4M0dyUm9jRS84VElFV3BjNUorQngyTVYz?=
 =?utf-8?B?Z2h5SVpwQlU4bVFJVzRlUFBJMm9HU0l3MisyV3VQMkdVWXlGWm5XY00zWG5v?=
 =?utf-8?B?ak1IVHludkN6VmptWnd6dU84bzhiN09XOSs0MitLdk5XcVJkV09uM0hobGV5?=
 =?utf-8?B?ajhjemltaGVId2lvOWNYMVRZQTJqLzdmOUEzTGNSWUszMmJwa0ZJT2t2bDc4?=
 =?utf-8?B?ZzVHUTg1QzVuVk5UNGRGai9JbFVzU0VPRjRuTUY1dHNyMFgyVnJaakQvVWFO?=
 =?utf-8?B?RDRZK1JXZnM0L2NQeEZKTFBWbGhEQUhrL0pCRGVkV2VTZVlrUmR0aXJJVHZ1?=
 =?utf-8?B?VHhCWjd0OE92My9Xd01DZGV4RXRkMDFwbjJWbHpIbml0UVBYSDZsN2VXbUJ5?=
 =?utf-8?B?WjhMc0RHU0ZoK0F4SEEvYlFSSno0RmVFYmFmOXFST1ljVUJtaEFyUGNnNEhy?=
 =?utf-8?B?cUN2MWRpa1J6TmMyRmV1bU05b2ZvbGZGVFc2NGpoWndGTE8zenlUZHNBM2hw?=
 =?utf-8?B?SWhDOVhoOEpGNHFnM3l4eTdwaVU3eFJVbnZ5VWtOMjBNOENxQzVzS3FDN1Rz?=
 =?utf-8?B?MVVVS01kSkZuTGx6WkxJMGh1eDJ2SHJwck1iWXNZdW9yczVaYkk0TURsWWhS?=
 =?utf-8?B?WHFEajRiY0pTdXlpNVp6a1NLTGwzaXF1T1ZMT0N0dWNMdjdJdXgvOCtnU21k?=
 =?utf-8?B?TWpzbGVXVDFueEl5YlhKMFBnU08wTU9BbS9TajVmbk1TSm5STTFwb09WWWFF?=
 =?utf-8?B?a3J3QjFRYXF1QVNqWE9XNE1PUmVUMWpsUWFrTEU1QjVoMVloWGxBaU4zb2xY?=
 =?utf-8?B?d2Vrak5yM2VMcnh3N0haRERNV1JqSks4dVZqZGcrUTVjdlpQM2Vvb2NWc2Jv?=
 =?utf-8?B?cllEdDJTS0diS1ZzLzhsclI5VlNYc0FMSXhLSUZMOG9XU1h1YmlySnRCYyts?=
 =?utf-8?B?VW52WjhicGlBblRlMDFERG9rdVBNZ0JncUF0MGZEYy9iSXh0ZzRlNUFiZHZB?=
 =?utf-8?B?dkdJYkVCODM5eEc5R3R2dk1EMWZGODR0QktBcDB3cE1MdWhYOUlvekwwNmRC?=
 =?utf-8?B?U1JRTm5yc2VoODdMMXlCekxkanp1b0pReGk2UlYwOEJRUGRJSkFhdFFQZGlP?=
 =?utf-8?B?anBpTzZGbEV4dytDRGpKUWZHajRkV2MwTTBKKy9hbHVuTUphQ2tKaVllNFlt?=
 =?utf-8?B?b0NFUmpiMkhqLytseUc0eEVhbWIveUg3QzdkUGZQTWJSUlIwb1lHOHlKc1Yr?=
 =?utf-8?B?b2VCeittcUEvOHZoQ0dKajlwMkFIcFNoOG9nQ0xRM2hPbnBIajhZczF3bkI3?=
 =?utf-8?B?RDJqa1BCbndRV3BiQmVTWUtDdGVoNHZhQ21xcGlVTUR2bVdaRkl3TkJsUlJ5?=
 =?utf-8?B?bzBjUnI5bFFWaitEbXhLZWhLbUlabEFtLzZzcnNRcFNBZVVHTjNnVG1hUUJt?=
 =?utf-8?B?U28vL21EL3loNE0xNFR5a05ZaDNpdkhKR293S0srK0ttbEFYYmF3a21yQytG?=
 =?utf-8?B?VmJkV2U2UjJCRFlDN3E1ODJZNmdSSUJja3c5ZzVkWE1udllWUVlxN3ZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE92dk14elA4S2hIN0xXQnVSbDFCWkR3STVReU10RExudmhyb2QxZkRPNmhJ?=
 =?utf-8?B?MHZoTkhYZmEyWlZUWnl3aTNieStMWHg3V0wwWHE4ZVRyMW5wV2hPNFNlOWdu?=
 =?utf-8?B?L3BYYUpOZm9hdkRDa1ZHb1ZFSGlhQ2ZIMjZ5V2picUo4UCtVMXM2ejVPdjlK?=
 =?utf-8?B?SjNzbG9vUCsvL0dUb2hUYkRlY3FnQ0d2V2RpSWpIVnZ3c3VkVzU0cTJvV3lt?=
 =?utf-8?B?V0o2UWNpWW1aelg3Ull3WTd6Mi92TzI0WEh2bThyeGxvNnpVNHRqVWxzb0du?=
 =?utf-8?B?MmZhUkhnRzdrM29PYSsxR3lwUkJvc1pKQUpKQmQzV1lRRjZ1VEVqb2x0cXdi?=
 =?utf-8?B?YWhvSjZqUUJyQjltbU15U1NSR3VZMDFtY2pETS80RDZiSEN5QmFzRG1KZ05o?=
 =?utf-8?B?MlhtMkNWbS9idkdMZXJWKzF1TFE5V0ZObVhyZHpQMm04M2xLSnh6M0cveEV4?=
 =?utf-8?B?eVo5OFN4TE10czJlc2haa3dyeXhIOGJydnlNRXRrc3BvRFk5TC96OUJkS21u?=
 =?utf-8?B?SnhIdkh2NUZqdHBJTnFJdzRyQ3RialRvQ011YS80YVhNNGJqdnd1d2lXekxQ?=
 =?utf-8?B?VDNwWHE0OEFXMGdEelpCRGJDS2hWRGtxbldGcE9SQWtsUTRjRXBjcDFmdlJ5?=
 =?utf-8?B?aTRnWTZyUUtORVpTWEZ5a2x3MmRiUDVwYk1xOUI3WVVlKzUxZ0N3NkNyc2tR?=
 =?utf-8?B?SDFyUkhwcTgvb0l5S1daVVBnN3NQVFk4L0xLMHJBTGloUmFNd1Y0NEM5WVhO?=
 =?utf-8?B?ZnprZmgzcUVjTTNQamNqbUU1STFjb040OHBpYTIvd3lSV2puUVpPQXVRK29Y?=
 =?utf-8?B?ZGV6OE8zdHIxYmRlNWhKZzBDVzFMV3k2bVhoU01BQVRWNCtxclI2UW1pQWNu?=
 =?utf-8?B?OUhUWEFrWVNPUkxSZVE1dnh5Y2dHaHcwRDU0b0lBaU53L1RCYzlNb096M2Ix?=
 =?utf-8?B?TXV4SWxCZ21kWlZwVk1Cb1RGZTFQSlEzT0xDOHozZkc2U0p0V1RCSFdLZ25k?=
 =?utf-8?B?QkV4MGN0alhOeTFxdlUvbTBvS2o3ZFZ1YTlObjl0VG9Ja1VwaEx0U055RnJE?=
 =?utf-8?B?TFJkdkxWZVYwVUJJMWlJYW9rUlNFQ1NRL1hVWENxQXh6UjFyNU00ZCt0cmM1?=
 =?utf-8?B?cFdpRUorcHAwRTkzUEhmYlNYdGlsa2tKNmNtMlErSmx4WmI1Y3JUZlRob2Zz?=
 =?utf-8?B?NG0vRjZVNjRqcVQwd1BKTFV2a2tPUGQzL3dEcUFjMmhzTEs2Rlp0NUpqVUdH?=
 =?utf-8?B?bTg2VzRXWWtYU3BRc1ZQRWJTVGJpdnpvcVRIeHhNaDZIY29LQjkvRzZ2ek8x?=
 =?utf-8?B?eWxoZG95S2QzS3VWSjA1eW12NklIdWlpMURmQjZtdWE4b2ZzYTZOeUhtVGFh?=
 =?utf-8?B?VEREQ2JELzQzUXc5S2x6NytDbDBOSHFnQVJ3c20wQU9qWVJ1dUk2VUN2K2ZY?=
 =?utf-8?B?cU5QeC9WOVl1YW55dzVBK1ZZdzNadm5yUTJET3l5UDl1c1VvbXJWM3o1elZv?=
 =?utf-8?B?ZzdTTS9Sc1k1RDVoY0hxRVRKWkN4Sy9nRWpjeVV4ZnhiOGZScG5Ldy9sdFZv?=
 =?utf-8?B?WVVFMHRiSTE4ajU5MG9wQ0FhVjNIM3NINWFIZU5nY1BNQ2xlaHVsT0FreDdY?=
 =?utf-8?B?K21IU1JlaDEraGUxVlVPWGNMUFNyWGppSkFnQTRXQnNLa0ZlYU0vOUhJaVBV?=
 =?utf-8?B?eVFhQk8ySGo1S0xjdXdpNHE2SGFVYS9lS2hMY3FPZWVXRnVCNGtSVm1pcHIr?=
 =?utf-8?B?N055MGxqTHV1WDNoS3NFZXZNQVltSk84TEJNMEdPQ2NKVEhUMGZwbzNwbTUz?=
 =?utf-8?B?RCtESytIT1ZnSVBMbVBaVmVjVHhha2J5RVBuYWV1Ly8wOGJ5cTAwK2MrZDY3?=
 =?utf-8?B?czlCT0R1eldtekRzSVdKL0dtcXZlbFpsMXREV0VoTmZ0TTJqWmMxRm40dE9G?=
 =?utf-8?B?S3h1T0luQmJKL01WYlhqd2JyWWxFUndtNzdjeXVudC9EVXdVbFlUbUJpTHNy?=
 =?utf-8?B?alJKM2pFZXIxejB1amdVZEtNVWE2YUlnUElkL0JsMnFITUwrcFNiQVlIQmN6?=
 =?utf-8?B?OFZtOFlGdmNpdFdYQWw1SEc2djlwMldBT2JKVUtxODEyWi84cDlOZ0dVcCta?=
 =?utf-8?Q?ZCiONCLDLlKPI05j/74CQQpdO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454ad283-bbf5-4975-f272-08dc80b4b87b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 14:28:06.0563 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urlTZvwWt0x6Etj+pIPkNRlsmBa++M24DdApuO+/WB4CsLqE9yO5duxerbeUARznfR6j+uXB6kkqFyNZ6QpAQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480
Received-SPF: permerror client-ip=40.107.101.81;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Shiva,

On Wed, May 29, 2024 at 03:54:58PM +0530, Shiva sagar Myana wrote:
> Returning an uint32_t casted to a gint from g_cmp_ids causes the tx queue to
> become wrongly sorted when executing g_slist_sort. Fix this by always
> returning -1 or 1 from g_cmp_ids based on the ID comparison instead.
> Also, if two message IDs are the same, sort them by using their index and
> transmit the message at the lowest index first.
> 
> Signed-off-by: Shiva sagar Myana <Shivasagar.Myana@amd.com>

With the subject line modified to below (for clarity):

"hw/net/can/xlnx-versal-canfd: Fix sorting of the tx queue"

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

BR,
F

> ---
>  hw/net/can/xlnx-versal-canfd.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
> index 47a14cfe63..5f083c21e9 100644
> --- a/hw/net/can/xlnx-versal-canfd.c
> +++ b/hw/net/can/xlnx-versal-canfd.c
> @@ -1312,7 +1312,10 @@ static gint g_cmp_ids(gconstpointer data1, gconstpointer data2)
>      tx_ready_reg_info *tx_reg_1 = (tx_ready_reg_info *) data1;
>      tx_ready_reg_info *tx_reg_2 = (tx_ready_reg_info *) data2;
>  
> -    return tx_reg_1->can_id - tx_reg_2->can_id;
> +    if (tx_reg_1->can_id == tx_reg_2->can_id) {
> +        return (tx_reg_1->reg_num < tx_reg_2->reg_num) ? -1 : 1;
> +    }
> +    return (tx_reg_1->can_id < tx_reg_2->can_id) ? -1 : 1;
>  }
>  
>  static void free_list(GSList *list)
> -- 
> 2.34.1
> 

