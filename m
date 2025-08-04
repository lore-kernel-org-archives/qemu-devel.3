Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EECC87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 13:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uivQo-0000kX-5o; Mon, 04 Aug 2025 09:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1uisHj-00056Y-GM
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 06:19:18 -0400
Received: from mail-switzerlandwestazon11020100.outbound.protection.outlook.com
 ([52.101.188.100] helo=GVAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1uisHg-0007LJ-So
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 06:19:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4y+1oLK03yYLIbsM0Us1nKaRazrInwdCh5+WtV9iU1lZUDeyR+OgVolZthTpgedzRxF+u6y1vLMhNIUyBCRNigVe8SnXK4uzNHkW+7xGDtiZdyafa7Dwe1IsqxzuH4GYZgzlKKfN808pkMBJtOZO8vOJMfy0658h50fFXX81snIpt7gaX7Cf5AFEeMlN4AIkZMv7eHWIrExydVq6M7lbLZhyaZWLh9w2P0+hueARGVFSOiwqPn2izcGewTHYm2/Kzc25DWpxG/E70GllLkRPUIwgLJ4+Do14w0q9/ukZs17p1HhbVD2V7f/5akx3oRQS0Ksv/MDI6Dh8g5wmE2fBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+m5HJR4ISskbMwPDhjZGUyPGNMwUiyYMC5qTFDaGMc=;
 b=Cd/KU8VbPweF/SrpmS8atWsR6ipMMZasex2HGkxLqWMgooUwnfDYIeP0V/bRC0ltXxk9eriFQnlz9xfiYKnvZPMTgSCLrYlG3B/TVqxN794s5emyZuazcWVht8y/MCT4MYWfIdtKhjnXSWmDLod7H6pUs8KqJddUeOThjc8vIZEY8OuaEwbor/elumB5mIhcWGCHnotmYCJaD9wGX5xm2V+AWIyzKZSnn3DVK0BDBY9/YjJ8sVd6M0UUSESxBSm9NaCCeX5XmAWEZxH/sHnpwmz+qP1bXX80SmESJtzceQ9h5RT0Ln0+GFjVo+oETvQyDd3RqoBVsSK0hGxvnelMDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+m5HJR4ISskbMwPDhjZGUyPGNMwUiyYMC5qTFDaGMc=;
 b=bQixlUU4jogqYGmV6AKFwz47PAJPj8YmmWnSSeTp72eDlHCoRPBWvs4/vL2/4tb6alrEsRHE1O8U4wOtBblaPaWi0DRT/FzVaaKBqAkFt1hnj+G47f40d35wrOBLrqtfsH4G7ezfnQd00KLM2qzhuckPyAu8dQEWFGHMtAxNLB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB2076.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:6c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 10:14:07 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1461:a808:5787:602f]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1461:a808:5787:602f%5]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 10:14:07 +0000
Message-ID: <205e6753-53a4-4739-99ed-26344403a437@epfl.ch>
Date: Mon, 4 Aug 2025 12:14:06 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
To: qemu-devel@nongnu.org
Subject: New capabilities for plugins
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV0P278CA0027.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:28::14) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB2076:EE_
X-MS-Office365-Filtering-Correlation-Id: fba2637a-d724-434b-1f61-08ddd33fa5c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|366016|376014|19092799006;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UG53UzJSSjBPTHc4Vzl1dTAycGM2MEltUm1wQTdSOCtUQk5OdU1nYWF0SVdY?=
 =?utf-8?B?OFhVNnVQVWtwM3ovY0JVWTBkTjlGYWo3SC90UWJFc0RSVjRIU0hDMXc3SHpR?=
 =?utf-8?B?THJQTkowNDFrVk5jMWxCNjg4Y0Q0YnMxUVN0bE9ZYmhyVHBiTzd4SzlRZHBB?=
 =?utf-8?B?TFBZMjBUQVd4YVR4MFJHQURRUTBRWXo1R3dXcnQ0ck1ISUlHNnFDNWZMdTZM?=
 =?utf-8?B?d2pPcGVGZHY0aXNGSk4wUHRjL2RpT1M2RndNbVBsbU9QNWEyajEzcnNoUG4v?=
 =?utf-8?B?WTVXYnlMOWtRWElVd3dwSlZNTzBLRWdnWmJEY1lQK0hxNnBwTTkvU1FXWnpa?=
 =?utf-8?B?QmVGdVIzdnhDNWxrMUFSSDNEYXlJUlE3ekt1b0ZJMThha2hJOVNqYXdpdlJM?=
 =?utf-8?B?OFlma0xpVXYzZ2dVcmR4RUdNNkNyRE9OeEdIME5lY3ZEVjNydmNDY20zVmN3?=
 =?utf-8?B?ZUhuOThkTTlUVVMzeWpLTm5NYlpWMHpEK3RCbWtKQUJndmsvYjZyTXBUVGVm?=
 =?utf-8?B?NDZ2OHRlYmZveCtYdkJoc3dKM3FoWHJOYUVWNjdQSmxwL01neUFkZVorOEZO?=
 =?utf-8?B?RGRnaCt6RWNnb3dwa1E1eUVQSTNxN2I5RERMSVpZczlpdnhiUE15TVNSc0pM?=
 =?utf-8?B?NG9XRThOVE9hTzB0R3N5TzBydzFKUHVRb08yVnZzcmpML09HRDVYM214S1lP?=
 =?utf-8?B?WTFJOGlrK3JWUk54SGpVZnVGVXlMZEtreFczNnliZWliUDNndTJtUERMQTFr?=
 =?utf-8?B?SUZFcStJOFJvYldjUEtCZG9KTUcwUTZMaHE2UmFGMzAwOE82VXFTc01nN2g2?=
 =?utf-8?B?R0FsTE95S09mR24wMU1JUlNLeGpaSW1jdStlRk0zVG94aHlqZzIwR2F4N1F1?=
 =?utf-8?B?UGpYS0ZVZDY2YlBWY2s1ejJFUllFcUlDSW9peEJ5S24xZXJyQSsyM2VFYkdW?=
 =?utf-8?B?eGcxcTRzcWVrd0R1RVRvZUpzRE1SYm5RR21vMWMvMS9ScjlTd0VWZk5ndHVh?=
 =?utf-8?B?NXpxWDVGazNxajRVTHZxVDRWNW9ibTl0VzlWK0tpKzdIb1ArNTlqVXVMMERV?=
 =?utf-8?B?eEFKenBNTHJkeU9UdCthV0crVjBpMGNvRVkwbGhxcDRMOStDRXkxNGphTExx?=
 =?utf-8?B?enFvZ0tLNENyNmRkU2RNY0tDVlJYTlhFTVpFZEU5REtMbVVhSXQ1Z2JybXhX?=
 =?utf-8?B?Zk95bFFTNVdyZG9maTB2UmFKS2JsSzVJRXFJZmlkbjVXRVM3SWRNK3ZWbGg5?=
 =?utf-8?B?SnJjZ0tBUC9CNGIxWnN5RHVaMWh6VGJud3RhYnVRT0FMNlJ3Y2JWNDZLVldM?=
 =?utf-8?B?alhZWkVKRUEvMUVCZUJkT05oUXB1emNPaE1yTXZTb0VTUkUrV3lDOUhjS3o2?=
 =?utf-8?B?TjJlOXkvQ290cHZ0SHJEUUtFNktvWTNUMUJzS0hvUDEvVnVjQmMydTZkYk9x?=
 =?utf-8?B?MFVBOWVQTnI5cmVBQTlqcVpqMFYvOTZCdi9wdlZiR1pJUkszV2wwN3k5UmNO?=
 =?utf-8?B?K3JTUVFEQ2F6Vml5QVlnb1pxZFEvK294dHdKeWZvVmpGeTduL0RlKzEwWXpV?=
 =?utf-8?B?SlpBd1VpeHIyZCtqamJod05QUUNFVWhxWDZKMHE0TjdNUzhMQkg5cmhIRjU3?=
 =?utf-8?B?NTdybXF1bEVBR3JrdnlJT0lMQ1JlaUhiRlduT1k1Y3ZHblE4S3ExRkIvcUFy?=
 =?utf-8?B?eGRaS1VmWlJXOHZuQm8zampOVE9XMjd1YlBTaWhTeUJENnhMbndyU3pJeGxP?=
 =?utf-8?B?V2ZyS2JUZFpjTXJCem95UHFZVXVmTmYvVFZIU0VpbkFxbGJGYVZmY3VURy9p?=
 =?utf-8?B?SHdOSEx4Wk5YcDBDbmVUQlo0c21Fa0tHR0tDd0tHZ3RHV2g5ZC9wOVZUbEVG?=
 =?utf-8?B?Ryt1bXJ0d3RzQTNTTjVhWkIrTG1rSUxkMnpJbjlCSmhnUy9ranhOdzM4Vjc4?=
 =?utf-8?Q?0gGVOqIF4os=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SzdBcnpnSFdMNE4wRm5vZTQwVE0yZlZKZENxZmtmbXo3NXNQcWxHM1VhRXRC?=
 =?utf-8?B?SzlrTHE3bWpkYmZDK3R4dEJ3bEVjR1puU3A3VlBXMDZnQkpyVWg1UXQwd0Zs?=
 =?utf-8?B?VmdkYVJ5RWMrdlF3M0xmemUzYy9LM2V4YU1laHFIUi9jZE5vUWhMSm9QT0ov?=
 =?utf-8?B?OXZ2Z0RuY0tjMHdPci9oWWQzbldBcTN3aU93M1NTeGM5L3BwVkllbjNrTUdK?=
 =?utf-8?B?NjZVbjg4U0U5K0dSOXZoSHQvb3d0b2RnWTI4QU04WllYaG1KL1B1V3ZZalpS?=
 =?utf-8?B?aGhBRGRIQU1oaERBOHVtVHdqU01rYlpKUURkNitwbHpiQWdaZTQrY2drYzY3?=
 =?utf-8?B?UjNxYWJuZUlmZ3VLMko3SkZKQWFLcXVVUURYN3lNenRmZVlTT0h3R3JndkVD?=
 =?utf-8?B?R1paWHA3YkU1M0lYaXpTbUZBdTBRUWtmSk01UzFwM3RXYWszbk1ibGhuR3ZC?=
 =?utf-8?B?K0R1QjNKMVRHcVJPYUhheHFmdGJVNTJxSUk3S2s3aEw3MkR5disxaGU0ajVa?=
 =?utf-8?B?WktDck9oSTVjK3dQTFpvaVZjcUFIMnh5L3VZdC9RdEJwc3MyZlV5V1g1LzZ3?=
 =?utf-8?B?WEtOWlkrRFYrSmNVUEZ6L2tnU0FwdkJtRkRhamtDYisremd6bmtkNXQ5WDRH?=
 =?utf-8?B?OFBFaDVwN01aNVBZRHhwc3VSMHpENFVsY0N5L1p3Y0NpWkZwdW5yOVY3ZWRw?=
 =?utf-8?B?WnBGS29jdUE3UWlxekJyVzB4c1IwMkdJQUpmUG1EUVo0RGxGOHBwdUhiSUxB?=
 =?utf-8?B?NFptaU5iZTZSczRYQkRkWnhlZ2V2a0N3L3BPekxKOGo2YTNkVFB0N1FhZ3VE?=
 =?utf-8?B?dXFWMS84Slc0R1pvOTI3VURYQUdpdGRWa3hsTCs0WWI1OGFGMklITDFLa1Nr?=
 =?utf-8?B?UzZuT21QZGE3YVJ6RHlOUHdZUllPZG1TV25oYjJjRVFaRWgyZmw0TGc0dWJ5?=
 =?utf-8?B?NWhXcUdJVDY2NVNub0FLcndMV1ExcGNRREF5d2JrRmtjUytQanpmNkdPUnA5?=
 =?utf-8?B?c3NmazVZUkJ5bGFjQXVESFhrbnd4VXg5RlpEUTdGQWJWWFBvOEN1c2VkRUFv?=
 =?utf-8?B?UnFtQkM4bGZzQ0pWREZZUjBocUMydzhhZVZYQUJFam9lRUpsQUg3dkJRTVZl?=
 =?utf-8?B?cVM0Q05GUHNwa2FnaWcwd3NuT0l4TEhjSFIvaEZwNVAwb3R4SHVkbVplaTdB?=
 =?utf-8?B?ZUlUMWFLejYrR0RqcGpFYWpRVGZjdHdDbDlqdjlScVdHUHJuTnlvSFJ2Y2VU?=
 =?utf-8?B?NFNySFg4cC9mZWhsN3ZqSHBrWGNxajdxR3FHUzl4ald4bEhuODd1V1grNnh0?=
 =?utf-8?B?L25IWmoxOHVZY1MrUThRQUxONWwzbWhnUmdrSHV6VUczNU9iVFlibFhPbS9q?=
 =?utf-8?B?d0JpQ0NnTFJnZkdILzRDODFNZ3FPdjZiUFVRcTVLZjhXVUN6YXlaMEN6RGpW?=
 =?utf-8?B?R1YrVGsrR0Q1ejdhMTNJMk9lOURROWFHWCtiRnc2SkxrcTdZeFZoQys5bjdm?=
 =?utf-8?B?aGtnbDBLQVlhMWQ5WnQzNFJ4RlVwYmxRdHhwRjlhbHk0RlJjSHR2MjU5VFBr?=
 =?utf-8?B?WEpvN0JTRERPRTJyNmcwYU9tQmZ1Ry9wZmozVVNEanNVNjhtZk5PclV6UGw2?=
 =?utf-8?B?UUN5TGE3NS9LaVZQWDlMcEN6QVJhbVNkYlpiRmFnTGhJUEtueDZVWHVQdkRm?=
 =?utf-8?B?cDhnclk0OXFZcThvY0Y2bGZKdnU5ZTVUWDFxaysrMXMyMk9hVFpWL3NSL0xR?=
 =?utf-8?B?c0QwcW5wNVR3VFNBZHRxU0JYa0cvUXBmZmhaQnhUVFRxUzNtNnQyeENBL1la?=
 =?utf-8?B?M3JRR000RkY4UEpxMW1SK3YrS3doaVVPUWc0Y01zZURybTZmQXJ6Ny9EWWJz?=
 =?utf-8?B?SmdJeURNRUhxOUJQS3BnNE1LNzZTZ1F1M1hqanc4VHNnWktzdkdXMlM2d3ZY?=
 =?utf-8?B?eTlHSi9MY0RPZ2ZuWExGUXB6YlI5WlA4VmxwdDJCZ2NFMzBxNUgzRVpLQ2la?=
 =?utf-8?B?NEI4UWVFZmt4alpyUEJKdXEvU1pHYSsybk9aVm01anl5NnZ1NzJsOEhnQTB2?=
 =?utf-8?B?RW9hRm0zREhoZ3o0a01nNUVsZE1LZWpGY1ZaMHA1ZmhETmhYeksrZDZtTHFU?=
 =?utf-8?B?U2YvaDlHUzFNQ3VJOWZLMS9zMDVSZnBuQ3pIbHJpTEVxQWxEQncvNkFvUnk5?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: fba2637a-d724-434b-1f61-08ddd33fa5c6
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 10:14:07.5399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /V9qV9UI/+bVa5MKHVhFKxBbeo+i3S8PXhoMYfI/RiQzhZArs0aBQWqQmhOlJXMoU2lulx6qzz1UiM53mb8ktvjQTZXlL4k4FtZspJfTI6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB2076
Received-SPF: pass client-ip=52.101.188.100;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=GVAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 04 Aug 2025 09:13:33 -0400
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

Hello,

I'm currently working a lot with QEMU plugins for dynamic analysis of 
userspace binaries (i.e., running under qemu-user). While working on 
that, I found that the QEMU plugin API luckily has been getting more and 
more capabilities with recent versions but that I'm still lacking some 
functionality for my use cases.
More specifically, the "vcpu_syscall_cb" and "vcpu_syscall_ret" 
callbacks already allow me to instrument syscall translation entry and 
exit points. While the register read/write APIs also allow me to modify 
register contents in my syscall callback implementations, there is 
currently no good way to emulate a syscall myself in the plugin or 
explicitly set the syscall return value (as it will be overwritten with 
the original syscall's return value again, even if I set the 
corresponding guest register).

I was wondering whether the QEMU community would be open to extending 
the plugin API so that a plugin can fully emulate a syscall without the 
original syscall being executed by QEMU. I had multiple approaches for 
that in mind, with some working patches locally that I'd be happy to 
share and build such a feature on:

1. Change the API of the existing callbacks so that the syscall entry 
point callback returns "bool" instead of "void" and if any of the 
registered callbacks returns true, execution of the actual syscall is 
skipped.
2. Introduce a new API function that sets a flag for a specific syscall 
to be skipped:
2a. A function that's called once in the manner of "always skip the 
syscall with this specific syscall number" or
2b. a function that's called every time in the syscall entry point 
callback in the manner of "skip this specific instance of the syscall".

I'd be happy to get your opinion on those proposals and to 
develop/submit the corresponding patches!

Thanks in advance and best regards,
Florian


