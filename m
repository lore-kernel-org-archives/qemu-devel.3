Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8014EE6FE43
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 18:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smduQ-0003x6-Ew; Fri, 06 Sep 2024 14:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1smduO-0003vI-Gk; Fri, 06 Sep 2024 14:42:12 -0400
Received: from mail-mw2nam12on20625.outbound.protection.outlook.com
 ([2a01:111:f403:200a::625]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1smduM-0008Rn-F9; Fri, 06 Sep 2024 14:42:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4Sqm1SvaS/mwKk4SLtUXdaO9TIsdGing4zpK1k83AEoU5mXrdMPc/nCxthOy616MAENxRI1qzgF8XkEUXOFBMif1Reu6zCRDCn3qm5nMCmAvHyf89mQ+EhMQO645BqgfHl+UiOqWz31DjF45V3Wo/5FZxDMpxxh924ewG1VjttrvmnltLeO7XbRd1mwdCKJaKsTLLYYg6p+lczPmEFLLwzDCsG/k23RZvhC1j/S/4KbICUm9hfofHBgcACiBxZq2Z0Mz0BTp0vkZxY8EvTIPRq3uYSFXify4x/7x9dle69Jj4fzfQPZLCTltSTfYQ/9wKU4DFGPG0WiGp1kCdRycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIWx4sH7s9E9LQwT5BLC4svBBACoKvvDyI7IovgloVI=;
 b=p1uPmu0zfTQxdfRHNOM3Ivhw8M5SGZJGK72Puk9FdsKM5vZZffcFZzvB5z2imo2NrZsdzGqJrbiJtDGGnoYifrmdpWHtKueGD8eIOgszfn41/sbMsCPypDQjJ6aQLehIxMlQuUuKbA8H1FOrSme4v7XxI2RHhiEgPDy+GZwL+rqh6jsMqELWjWS2qywy3x6FUg0hdY+0/7PqYH72LNGxpFRDGQC2WZqFpI2x545Lv7+dMzQ5/U4897MlvkKXMJlX1R/9FlSvh549nGsnSSWIZoD6zIxcQeKxiuzgXu1e8XLRospTGzBp4XJ9Sp26pMOtpzn+t6SnJvrXVVZLbzSMhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIWx4sH7s9E9LQwT5BLC4svBBACoKvvDyI7IovgloVI=;
 b=ZyPCkgyGQoRmv3I0KNwNL+Ye3Qmo7y7KKrn+7On2CJe25XVJgVn4cwDYiaYU75jtSpso3dWfkgZ6zM9rIOSaZAOp0DQSUPfgssMvJtBhrRJCtOaSinEZ1EYQ49JuZ/BPYpusTDPVFGJpHOi72sCPLuQE0SWR9xv3bOMVWRnolas=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 18:42:04 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%6]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 18:42:04 +0000
Date: Fri, 6 Sep 2024 20:41:52 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Shiva sagar Myana <Shivasagar.Myana@amd.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, alistair@alistair23.me,
 peter.maydell@linaro.org, sai.pavan.boddu@amd.com
Subject: Re: [PATCH v2 1/1] m25p80: Add SFDP table for mt35xu01g flash
Message-ID: <ZttM8FP06oTasA05@xse-figlesia-l2.amd.com>
References: <20240829120117.616861-1-Shivasagar.Myana@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240829120117.616861-1-Shivasagar.Myana@amd.com>
X-ClientProxiedBy: LO3P123CA0001.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::6) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|SJ1PR12MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: 431aaa53-b2c5-4179-f3b0-08dccea39a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1lZTUpKL2NHbHJTQjE4L2YwckRockFjMlR0WWM5TFlTeGduZmdkWkg2WE1D?=
 =?utf-8?B?ejVabmVMYXV1M3Q4V0VQN044NmtnbWZvTUpTbFdocjdCV1N3Snp2MG90aFpP?=
 =?utf-8?B?VHBPQXVaVGRZbjcwa3lQcGl5VFZ6dExhdGFJQ21OY2NKR3dsSXZzRWZweWRC?=
 =?utf-8?B?bzZDU2lUS1N4L3JmSVJ4NldBcVlxejZjMGNPeFhXUUJmMW02S1NRd1VrdURN?=
 =?utf-8?B?eGVuT3grTGNwQTVwMU5KT0tKemtEM1hqWTBseWNEbkYrRzI3U09tSHFzajl6?=
 =?utf-8?B?a3J1ZkxnaDd6S3B2SjBZZEJZeUsxck5pcWFRM1F1ZEZML2RJbHpBRWVVZEJU?=
 =?utf-8?B?ME9vYUhGd09DRWdBMWVnQTh4Tm03T2Yxald4M1lJanM1Mk1TWTNjWnY0ZXY1?=
 =?utf-8?B?aXFPNS80QTdJZVM0VlUybFUwYUgzNzB1V0l0S0ovZ0lKTGdYSFFGdFA4Qkxm?=
 =?utf-8?B?NTlOUEFMcjdMV3JvY0lTTTgxTUFkN2J0YnlRZVRLU0srOEVtNjlFV0dLYUdp?=
 =?utf-8?B?OHFkWHdpZjBDUmx5N2NNd3o1cEJtNENicEd4MWJrM0NYbHdkNnAwRzhXVWhE?=
 =?utf-8?B?QmdGQUdxc2dLWWFyQjJ1bE1DUDlPblNPZ2dKaWtqWGp1NHNWanZYM2V2R0ps?=
 =?utf-8?B?T2llcnB3M1duaHB5NTVwZkF5cEFCaVlBeFNjaG90cUU1M2ZpK0Rjd0p3SStW?=
 =?utf-8?B?a2pVdnIvenMwSVoxUHB2dXNvMmlvbkNxUVozSTZJdE9nbzhPQlRRMmJkNDZN?=
 =?utf-8?B?eWttREFMQnRhdXVXdksrZGFEM1loT05vdFZqTTBKNzJLQzFZRmVSNllYSFZ6?=
 =?utf-8?B?M083blRxMG9xVHFvdkUzWElHVTNzd0FVR1FTU3ZBNkE2QXhqemlRQUV5MXRR?=
 =?utf-8?B?ZWh0SjBoV0tHNlRzYjQxcFYxZFJxdUdlOGdISG1KSXlrZVh2TDdIcWtRWlh5?=
 =?utf-8?B?WENVNmxYeWw0amdxckFBYVpkRjhpTDR4NWx4ZGtKa2pMeW02cERWbzRYWlhy?=
 =?utf-8?B?RzVhbjg1SDVNRmdYRHg2YnpaQit1K0prb2U1ejJVU2VLUGZsdFY4aU9Qb1Bm?=
 =?utf-8?B?eW5mQzJFeGZQNktNRHQvL1pRUVNNUkVmenpHU3JpV1lMSzllalBhZmVMVWZs?=
 =?utf-8?B?WVNnRTZsT2pEY0JjN0NnbEJYaE1YUHpRQ0QvbE9QNUVYNFdqVEw3QmsxaURy?=
 =?utf-8?B?N0JkVU1abkZJSXFwOGMrbUg5SXEwWlo4Snd0T0hPNk9ieDFsMldyM3F4RVJw?=
 =?utf-8?B?SXk0UzFMdHQzdUFJUmhUMktTVi9DVElsOS9KNkFXNTlXSmF2ajlrMVo4bWRv?=
 =?utf-8?B?MzZoVks0Z2tpR1haOWNBSldWRkVxZ29Ba1U3MWF4MjY0QzNsbjdTeVhHVnQ3?=
 =?utf-8?B?citGS3dWalZsWllnNlJXU0lsVEpsZzhHR2FMN3cwWlkvM2NybmhRMnExY2xO?=
 =?utf-8?B?eFhFa3RXUXVTK0ZQUUkvSXNGZ1J2WkxtOEhJNU9TSUlXMHNnY3o3eUFLTmxP?=
 =?utf-8?B?OXRaUXJibEE0bGpIUFkzcU9VOUc4UTFhYTZwYXZodk5oUDUzNit0eGVUNlUx?=
 =?utf-8?B?bmZuOXhjdkZSZGFOclVDT1RiZ1hTWVBiQXR2dDVPQ013VlZTVmdCMit3VXA3?=
 =?utf-8?B?SG1kWUp6aGM4M0trQzk3dnR0dFRXNkRsa0dHQ0xhQ2N6M243enE3RFM2U2M5?=
 =?utf-8?B?WTFDbVR1L3Z1c2lrOXFYLzdBQnNuOFZmd3k0QTVQMnpJM3RTTWphY2MveFdt?=
 =?utf-8?B?K0h0MmJ5VmxXYTliK2tma3dSRmorbGRaeW4vV3hRaUNsc1ozY2hnczlDbkR0?=
 =?utf-8?B?TWFwUHNxaWtrZzFoSTl1UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGdoVEZUS2hVblpKZ3VtS2ZQcnhsSGMrUkd1S1JsT2s2MUxybU9rTGptWHI1?=
 =?utf-8?B?QUpvUlpldGNrNFlkdXFZNFVPbVNJdEtHVjl4N1g2NFZabmE5SU5DZ2VMK0tr?=
 =?utf-8?B?M3pSektrcEZOUDZKdDgzNUVDdHNYWGl2N0NqWm5KWXBwOFYzcm1CMHFXcFA1?=
 =?utf-8?B?U0pKVVYvN05udWlzcTBaMDJhTEZjMlJzS3pkSW9CM0hBRzd0UXlTNHhWdVMr?=
 =?utf-8?B?aUUyQllsZmRkaXZuSm5QcXQ1UVYrY2MyMC9QbC94blZWK2ZPZjk2bTZpcDBs?=
 =?utf-8?B?M1NmR0oyakY0aXF4QWtEUjZTTDFmVDMvUVFmSUlsOGhkL0ZMSVhHVW1CV3Jv?=
 =?utf-8?B?S25zOU1iSFdNZDE2SnlXV016NWZqYytVcWdvQmVLUEtScUVuKzJQdGl1ZHFW?=
 =?utf-8?B?N0dzNXhFMHhYNjQ1Z0xZMm1wRWFkTGxTMTFjU2ZYUUpDSUJhc3JvRkdEcktI?=
 =?utf-8?B?OWEyUmZPeTNNZWNuRGFoSldNbVB6bmlseTJxTkJhMlYxYitVOFlmNGp6TkpE?=
 =?utf-8?B?L3ZLYlZDUDNQUG1GeHdMUDBMNGNEQUUrNlBzYTlZaHVwUXc1V29naXBsUGN6?=
 =?utf-8?B?SFRaNUQxVkhjZUQzay9UNm1mS2x3dncyYWZsUVRXRVlwbVN4TFVSVkF4RUQv?=
 =?utf-8?B?eVVpR01PLzRuckY5NnZXUUZZaG0zTjFIVUlnZjJWdlFUYVloVVlhNURQNXA4?=
 =?utf-8?B?ajh1NW50M0VKUXBCVVZ6NFRTdTltTThVWkZWK04zVjI1Rm45RHllaGVyUFpQ?=
 =?utf-8?B?aHZqdzFvYzY4VmVIeThaUTVBTmd3eENJVjVnd09PdEdwQWp0cWJyNzdqS0Fo?=
 =?utf-8?B?WFNQYkRrUkVCTzhFak9uMXo2SDIrYStkb0tuZUFJVmtDb2xrbi9EZzN6Qndi?=
 =?utf-8?B?eFpWUC8zeURBemQvZzFTOEJxZEFVandRS25HMmRSMTlPQ0JBSUNHb3NML0hn?=
 =?utf-8?B?Vkd5NXBhb2NmQVh0TW1KTjhaVnJEZGRsU29YNllJM2hQUlJjNW1mNTZNTHUw?=
 =?utf-8?B?eTh0NjhSWmN6MWFIZzR2emI1MW1uTFNZUVhUQ2NnT3liYkQ2VThSeDBzclVJ?=
 =?utf-8?B?ZEFWV0FRU1hXYnQ4UWswMm5IM05lNFVaaEx5ZTdRUEJHeTRSclRMSU9xM3Yz?=
 =?utf-8?B?YVcxejNzVmVZMEd3UUk2a045MFNOQXBiWnZ6NGpaYzZobkpWRjVJVlZ2T1gx?=
 =?utf-8?B?dXl6dzVlZzhObzhaaVJ6SisyYXpQMlVLYm9XbW1YbUVXalBYU3RXSjFHNGhQ?=
 =?utf-8?B?dWV0aGp5NUNFTWh4WGhPUnA3MjZBOHo3MXRnWml1TDc1VmNwTzZaTUtyZGZX?=
 =?utf-8?B?aEZoR1hKZTdDa3RJbFhqc3RTYjd2YytuRUJwWlJWa1F1US9UYUYvVWhURTRj?=
 =?utf-8?B?ZCtDelM5QlRteDNFeUpTYjVrbHZxajRDVnNBa0Z4S3JCNWNackhPZ1BWcVZp?=
 =?utf-8?B?UEhWbHJYMng1T0xSOWJhZHZBYUw1N0xPRW12ZkpkVUt5YkFQaURvZjB5Ymx4?=
 =?utf-8?B?SDFFSVd1NHVQTUQxWEZBVkd3eHUxYzNBdGJnMHlJUDhJYlczbFp0Z3k0dFN1?=
 =?utf-8?B?b3hIV2tZRWRqcGZmdU54Zi9RaDZOREhOMDRWZmwwa2xPZXVaWGFUeWJTK0ZF?=
 =?utf-8?B?LzVjWWIxWHRQTDNwQ1JnV0dFRjdQb0xCRUFETno4bEcwTVZURUN0VHV4MEV0?=
 =?utf-8?B?ZU1hMjl1TU5ORmcrbDQvSEtnTE8raDFRQUsrcEk3azZETmpFSjcxWEt3alFw?=
 =?utf-8?B?QStWQ3dGM2s2SE9wL1d5RlJRZ3Z5QjVXdTRxUGRZdkV2TnRuZUVwREFMUUdP?=
 =?utf-8?B?ZGVTTldtZUdpNnYxWjF5LzFqcjdMdmMvWFVnUk5tVE1wT0VOdUVxeE96em84?=
 =?utf-8?B?Qk04MlhjMHpJZEc3aEF2S3JObXhWa1Nxa3FNYWwvQjJXS3ZHOHRxY1BOZVFE?=
 =?utf-8?B?ZndCcE1sdXREQVJrTlEzVkJML0JFd3ZXaGhYbkxEYkREVWJMRDNwenNMVWN1?=
 =?utf-8?B?QmxTOGdTNUM3cDZDek1DRFJPKzVQeXc5aVNONDBhaFhzT01WcDdHWWlOVllQ?=
 =?utf-8?B?eHFocHJIZkZRSEpzMnlaUE5YR0xIRFhxN1k1OVpoNHBXR3FXdWNkUVFvWXgy?=
 =?utf-8?Q?Dtml6L387ljYLQ4vA/c/aJ2OJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431aaa53-b2c5-4179-f3b0-08dccea39a4c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 18:42:04.6186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sr23kY4OSo9j2fBhl54z+7JjeJxr1vEfpoKfwfZyRqbb8tgg1xw7hfwKJOsUS225dKdg7XZ8CYvUrghwCY6bwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148
Received-SPF: permerror client-ip=2a01:111:f403:200a::625;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 29, 2024 at 05:31:17PM +0530, Shiva sagar Myana wrote:
> Add the SFDP table for the Micron Xccela mt35xu01g flash.
> 
> Signed-off-by: Shiva sagar Myana <Shivasagar.Myana@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
> V1->V2: Change subject and commit message
> 
>  hw/block/m25p80.c      |  3 ++-
>  hw/block/m25p80_sfdp.c | 37 +++++++++++++++++++++++++++++++++++++
>  hw/block/m25p80_sfdp.h |  1 +
>  3 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 0b94af3653..23290edfe4 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -266,7 +266,8 @@ static const FlashPartInfo known_devices[] = {
>      { INFO("n25q512ax3",  0x20ba20,  0x1000,  64 << 10, 1024, ER_4K) },
>      { INFO("mt25ql512ab", 0x20ba20, 0x1044, 64 << 10, 1024, ER_4K | ER_32K) },
>      { INFO_STACKED("mt35xu01g", 0x2c5b1b, 0x104100, 128 << 10, 1024,
> -                   ER_4K | ER_32K, 2) },
> +                   ER_4K | ER_32K, 2),
> +                   .sfdp_read = m25p80_sfdp_mt35xu01g },
>      { INFO_STACKED("mt35xu02gbba", 0x2c5b1c, 0x104100, 128 << 10, 2048,
>                     ER_4K | ER_32K, 4),
>                     .sfdp_read = m25p80_sfdp_mt35xu02g },
> diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c
> index 6ee2cfaf11..82d84cc21f 100644
> --- a/hw/block/m25p80_sfdp.c
> +++ b/hw/block/m25p80_sfdp.c
> @@ -57,6 +57,43 @@ static const uint8_t sfdp_n25q256a[] = {
>  };
>  define_sfdp_read(n25q256a);
>  
> +static const uint8_t sfdp_mt35xu01g[] = {
> +    0x53, 0x46, 0x44, 0x50, 0x06, 0x01, 0x01, 0xff,
> +    0x00, 0x06, 0x01, 0x10, 0x30, 0x00, 0x00, 0xff,
> +    0x84, 0x00, 0x01, 0x02, 0x80, 0x00, 0x00, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xe5, 0x20, 0x8a, 0xff, 0xff, 0xff, 0xff, 0x3f,
> +    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +    0xee, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,
> +    0xff, 0xff, 0x00, 0x00, 0x0c, 0x20, 0x11, 0xd8,
> +    0x0f, 0x52, 0x00, 0x00, 0x24, 0x5a, 0x99, 0x00,
> +    0x8b, 0x8e, 0x03, 0xe1, 0xac, 0x01, 0x27, 0x38,
> +    0x7a, 0x75, 0x7a, 0x75, 0xfb, 0xbd, 0xd5, 0x5c,
> +    0x00, 0x00, 0x70, 0xff, 0x81, 0xb0, 0x38, 0x36,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0x43, 0x0e, 0xff, 0xff, 0x21, 0xdc, 0x5c, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
> +};
> +
> +define_sfdp_read(mt35xu01g);
> +
>  static const uint8_t sfdp_mt35xu02g[] = {
>      0x53, 0x46, 0x44, 0x50, 0x06, 0x01, 0x01, 0xff,
>      0x00, 0x06, 0x01, 0x10, 0x30, 0x00, 0x00, 0xff,
> diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h
> index 1733b56950..89c2d8f72d 100644
> --- a/hw/block/m25p80_sfdp.h
> +++ b/hw/block/m25p80_sfdp.h
> @@ -16,6 +16,7 @@
>  #define M25P80_SFDP_MAX_SIZE  (1 << 24)
>  
>  uint8_t m25p80_sfdp_n25q256a(uint32_t addr);
> +uint8_t m25p80_sfdp_mt35xu01g(uint32_t addr);
>  uint8_t m25p80_sfdp_mt35xu02g(uint32_t addr);
>  
>  uint8_t m25p80_sfdp_mx25l25635e(uint32_t addr);
> -- 
> 2.34.1
> 

