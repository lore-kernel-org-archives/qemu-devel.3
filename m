Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD29FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHgBh-0000CP-BL; Tue, 28 Apr 2026 07:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wHgBE-0008VB-2J; Tue, 28 Apr 2026 07:00:40 -0400
Received: from mail-westeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c201::1] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wHgBA-0004xi-Tv; Tue, 28 Apr 2026 07:00:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTkj87qip7I5cNUVk0elOHHzMqDiXShl/K6CzhQ1FFXzj3xHrCz/w+A0BkF1i64NMfA6WipwEe3G+fxal8iq9yyHllaZwDoYpKXh5DgV2+LQbICi5n7nWoun5EuYC1vxVZnXZ1HhwfXWcAc1V5qESbIi0SxOmzsw+JXhoIb/0RBX6dxJzybUs8yYHQ9Z+r38MXWQlc4cwnddQ34jKmsNpHaB1wDzcEwamD6M2iWuy3oTnEX9XiGGz48ycHUnFidOIXFNrWk0fuo3JFszoIsdO/dxZntyjSdIxZqNBk9u8A67G9HLVQnjyJGJsiD4gI+xJZjhCilPAPCv1qWo6bpqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1376a52wava/jW495jfW8Mn1YTOw2ClFwzWQMejG+mU=;
 b=JnG4RlXkiA2JEAOEe/156eIkuVFULSjYDz0yDklySnnNgxqB0RcsjSUW6xLd7IAtBFwLbqjagjvibCjwF9SQt3b9nk9BjU5vKmz5p93T5sNZQaZW9gOxaxDM8ggMlxs6gX79n6HJaQWYmEWk/s8ZgEI9mUOCZv+m9gkaZM6hVsCloI2pkCP5O6vA6cJOZVXa/28fxNsz1f4EgqLwMRBRm5vIcZ6j9re5Wy/Rj2Rnu9N3M0zvoGjloLBGKZIMb5PEsum7vYW0U8qHE8X/gKZWOBuV2IlpoXtQsDqaxqZcvg68YgHgNFHmwnToCz90b80jVIdUlS7BnDD2CFb94AhjEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1376a52wava/jW495jfW8Mn1YTOw2ClFwzWQMejG+mU=;
 b=jK35VFL/+KsTl7i91V5xdM12Bfz4FM33SfNzWkCaKII08o0EXW8cJNAgZIhEjoEEu3pYOGjkwr/1tLHlUa84EhFWrcp1e+aU2Z9eArGyw5Nr+CNQJFpysJkhAga4ZUGW+T1rOZuRGkE7SzGXx+Ar9Twds/Y5tNRU/Ik4cuQk9Lrdx/COz6bI2rlvtX47Se/RrbuJOlCkBxT0sZ66u17PO//bUCYcWMXTHcuH6lz7SZ67YtoO6k/sB/mfDFmMrO/XzZHIupGKk1FH855t629liJmL2VNghjbPdRSx0DoVj4fpooN/5nTdaRRrLfquu/dh+YVASDchyroR0/XdjdIWSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GVUPR08MB11930.eurprd08.prod.outlook.com (2603:10a6:150:347::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 11:00:31 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 11:00:30 +0000
Message-ID: <a4f09257-b598-4404-b34d-bf7f46015558@virtuozzo.com>
Date: Tue, 28 Apr 2026 13:00:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] qcow2: Fix corruption on discard during write with COW
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: hreitz@redhat.com, den@openvz.org, stefanha@redhat.com,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org
References: <20260427170520.101242-1-kwolf@redhat.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260427170520.101242-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::6) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GVUPR08MB11930:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7a7120-4c8d-4f28-b65b-08dea5155d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bWdOZS6FuxysWcAU1xM8A2oB/XfDeHCq5yJZ253hGo7Q3v6e9mgtqd5dW/3sdd36HP+dwgtcmJfRA3J5PauxHFs4PADL9hEOq2DMFWfb8NNBKAztvmOHSLdCSlWlyhSD5tI/HZSKbliq3a/Yf/SN87hwvGXMqiW5tm+6Df1eTTIq+ahi/cSV5GYo6rm2FeVtYGp19rxrY+fLN0oNGVElB+oXr1GI6YkzZCdzq3BN9PTqX0/leHA5ysE3DCBK/X8dERNAfRdz5LkOnOy3tO3qYzMBqxb3SE6oBi2tDLzXwD4Mw3AjU4GFupS8f3binQcBoEf9Esy8new9DCM1mWAXIi6jyYm7ExW3oOAsczdDSmAcHjRZBRFY21D8iPA5rjIH/8eCeA8SAG2kB68cE2AbvjgdoRlpsNJg8K/O0HuZEgyOcLwJNCf5f1hG6GZzCo3MbB3STRKuLIEQt6iuiKGhoZz4lF29WEp2OyIr7xft/kpXavYPKKGnB//vHkYENaTmTJmy/6/4CP04RYHO08TZoEL58e1yKATXZc0cqsauvd+RtEmRcdEDknUxWYUSdXEzE7ouFQM1MpaYF/NrJLg0+pi7lakpfNdpZwEEJva7Te7H/uvm3Abp7RmeQEVWmWckBZfBmjr0wwx3MU933i/GG+bYzSW7/PqkOIdkUXxPr0o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjVnSnNvK2hrN0t6dW1DL2dRcW0rLzllZEpzeUVFSWZDNGtjTWdwWEplT1lP?=
 =?utf-8?B?S2tpRjlYTTR1a3hoWFh2NVR6M3ZvUklGOUxqVmVublVqZ2RMNmd3dVV5OXF0?=
 =?utf-8?B?WmlhQWdabnIxaUNLT1dmaGNQRHJ3UFBndzk4MDFuRzZGeGhTdWRaSWdJTWk4?=
 =?utf-8?B?VHdIcVExc2llOXYxQWFNM2REUjBHUDltbkwrdWdPWjBMdXpuMDhXSjBXQ2ps?=
 =?utf-8?B?bXl0NFdwSHkxY2xEeExnUnk5STBUcjRsRkptRE1NdVpERjdpeXpQZ3BmVnJH?=
 =?utf-8?B?KytBMFRUYkpMM1MrbDBUaDRMQXk2c01aM3VQUUNUaEZTOERQeVVkWmtXYkRv?=
 =?utf-8?B?elRDbDhlTG80d1lIUFZnR2F6RDMrTDJvcXpOWXk4MFBFYlBrK1F0WHpIVUJi?=
 =?utf-8?B?d2hVWGg5eGpGdnRmbzFyY2x3cWhXdllnZytkMGNSc09yZ0wxekErdWU5ZWt5?=
 =?utf-8?B?VFpIb2FBL0lxSDlBRUF2NU9RdjZLbG5tSStqUkJ5N29lejF4bjBUQUFiY05L?=
 =?utf-8?B?S3ZzZytKN0FSc0M0SHowcWpoNC9WMm1KR3haY3B3b3RiU2Mxak9Iem4vOHJr?=
 =?utf-8?B?VTFkMEpncmlOSG03SGdMU1RBRUh4SUJZc3pkUDBzN1JuRG13N2ZjYlhDSlhw?=
 =?utf-8?B?a29aNy9ERlFqWmhPZFB1RVJZeDduNnpRVDQxTVMwSjA0bUptaE5SN2pBaFBH?=
 =?utf-8?B?OTB6a3d0N0YrblRpdks4bmlWYXQvcHdSTnp3RFdqTFVtdWdaVHoyelRqSnJX?=
 =?utf-8?B?d0kzdkdJN0NGUEkvbzE2eGt0ajN6SFhoNXRlbzhqMnFGRXd2RFZMTk9Ydmx4?=
 =?utf-8?B?UXdqdTl1NldMc2VjY0k2cmtVTFpsZlVHNzhpNDZqTWVWNUZ4WEFZOHFHc05k?=
 =?utf-8?B?WTBoUG05YXByTXhscTRxVzFtSm9KNVN6QnU1dUtkd2psamNrQi9BM1hJTHdx?=
 =?utf-8?B?aXppeEFDVDlGZkZMNERkc0MrekxSTENkM3NxdGhRNGRIYWwyYkU2SUh0NlpQ?=
 =?utf-8?B?SFQydUdoNWJVTFR3cDUwcGFmYktGSTA1YmxPRHJNR212MDlodVFTNXVXcFZX?=
 =?utf-8?B?SDdKUmxjWDdyanN3d29HOU9RRXJhMTE5WTFjRnY4SytnajZpVjJyMUR1dWtZ?=
 =?utf-8?B?U3gxTC9IcmFOeXUzcTh6bUJJY1Z2RGxqRDd2U2c3cy9HSDRhZ2R4dGY1MkI4?=
 =?utf-8?B?TDI4MGVqNjJ5VGVyRS9acENLSEdKalJsMCtwSSsvMzY3c1RnVUtEOGwxVklr?=
 =?utf-8?B?U1lrV2hhUzRMNVFPRWQyaC9OY0JBRjZWWldmc2Z4NElSMEMzSlVmUWZjYUQ4?=
 =?utf-8?B?MEFHZWFlYTZIMmZsd2RjV1R3dzZQcitRb2k1RWc2RFJjcmFWVk93Z0loTUl0?=
 =?utf-8?B?RjRzaE0wOEUzcTI4ZmNLNUVSMHZhVXlQYWxuR1hWVDBGb3FqZUgvVDZjNTJp?=
 =?utf-8?B?TlpTcThqM3ZZeGFMUWZNbFdGdHRsNHFxdGs2UEUyWjh2ZE1CQVZCSkkxZjhN?=
 =?utf-8?B?M3dLdHVJa1ZsakkzK0hUbUFhYnl2NHZ1aVdEY3BEQUpKeGNWUzdpYmFpK0dO?=
 =?utf-8?B?U0dGNGNoRWNwWElncjNicXo0TDdRNTlpeUhnZUJOR2hZY1U2NjVxZ1dPazZU?=
 =?utf-8?B?U0JpdllwUEN6OVczR004MFdxU1ZVb3dieDdRVWZiaEJjSEViMGFLL0hTMWN6?=
 =?utf-8?B?dVN6TFJGVTZZellkMUk1Q0xhSnFtaThmOC9aKzZuMUZaWTF0ejlRTjZ5UW4v?=
 =?utf-8?B?V2JoTFIzSTVzaHB5bVZZeWJyeWNiQmZVSGZqWjZnUHUzZnFNL1NDRjFtMi85?=
 =?utf-8?B?OXVWTFRYdW9pOTA4UW9BSlg4WUVMaVZoUnh2dzNhdlNEN2lZSU1oL1Z4WXB3?=
 =?utf-8?B?TDlocDNnTnVGSUVCeE5Sa3dFQU0ya2xRbUJlMXdPQkdnT3BmZ3hIb2dPQkhs?=
 =?utf-8?B?WHZieEFnWCs3MUdTb3B2emFGTjh1RUZ6ejF4ZkN5czd6ZDJZWjJsMnVqNWdi?=
 =?utf-8?B?MitUSzBubE84OFV3MjQrODV6RTdzTU10ZUFUZDJGeGJXYlFvOW5UTWVGeDJt?=
 =?utf-8?B?V2wweFdJMEpwcCtScFBrK3BuTUtYdFpnalNJeW00d0pQcWdYMFZCU1FQVFQv?=
 =?utf-8?B?Y3M2UEV0MmJDWm42NndXZFJjYjVNQnFOU294ZTlqLzVTdHQ3ZkVDUWowQjh0?=
 =?utf-8?B?bkk1YVltK3BNS3B2TENMTFZzMVZkenBvVjB1SUh4SGYzL1pLWk53K1U1dUxF?=
 =?utf-8?B?WDArYTZuM01sbUc2TCt3VWNoa1ZKVDhHb3pRdjhzUXljU2VMZUI5YkJGUDNC?=
 =?utf-8?B?N3I0MDVIay9HM1ZVMFpmak9YRnJ0K3p6Ym1NWnNSVEF1NHFYUGNaRStKUnlZ?=
 =?utf-8?Q?F9ox6Ln9eO+tQlIz3yu/tk2WQyzZ6WtTyvl85nxckiqFO?=
X-MS-Exchange-AntiSpam-MessageData-1: EmtMBs4Z4r7BUw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7a7120-4c8d-4f28-b65b-08dea5155d1d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 11:00:30.9112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xbl1cAL+k+hZcdACkD7ikv4NDdbgClBHHeKZNZ20w5YGN8OFyigKIka4V2RVZ1IQwc7G2QMhnPH/I5bvEmeTKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR08MB11930
Received-SPF: pass client-ip=2a01:111:f403:c201::1;
 envelope-from=den@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 4/27/26 19:05, Kevin Wolf wrote:
> This is an alternative fix for the corruption problem reported by Denis:
> https://patchew.org/QEMU/20260421155628.3600671-1-den@openvz.org/
>
> I think it really is a qcow2 level bug and should be fixed on the qcow2
> level. The test is also more targeted than just doing random I/O for a
> while, and therefore runs faster and documents the problem better.
>
> Kevin Wolf (4):
>   commit: Drain nodes across all of bdrv_commit()
>   qemu-io: Add 'aio_discard' command
>   qcow2: Fix corruption on discard during write with COW
>   iotests/046: Test that discard/write_zeroes wait for dependencies
>
>  block/commit.c             |  10 +++-
>  block/qcow2-cluster.c      |  52 ++++++++++++++++-
>  qemu-io-cmds.c             | 113 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/046     |  46 +++++++++++++++
>  tests/qemu-iotests/046.out |  36 ++++++++++++
>  5 files changed, 252 insertions(+), 5 deletions(-)
>
with a 2 small nickpicks fixed

Reviewed-by: Denis V. Lunev <den@openvz.org>
Tested-by: Denis V. Lunev <den@openvz.org>

