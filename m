Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5975ECA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoyV-0005ha-KU; Wed, 30 Sep 2026 03:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBoyQ-0005hF-SX; Wed, 30 Sep 2026 03:43:31 -0400
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xBoyP-0004Rv-40; Wed, 30 Sep 2026 03:43:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aU+PHMnBnm+Q1bCAjkNvpt5ut0WTQvWidpYI1EJPmCx6CK7Bnk5BMd/XBXFVXBwQsIYZExbA9dFVcn81g9D43L/VfXIigOmWqJj7G6Ulte++Cq/JJBE1ZdokLSKA77Pnx7rqaxkfu1PkOBzYqkn01Frdk4rWRIkJcLZCo1vP126Bz5MNDPDMJe9APxHWFtwDQYMhurx/LN7He0ZigqgJbLW0GrHQzNStwSxw/Lv0N3zHuH+jMf4f89N98DPjyiNc8IqDIlfxljvVf/mL9ZKGmPwJ/NtPvKzdIthXfP8xvAdooGs/lJ++x6u8eXl6grQyVMgkSviEYgtKJIIsNm039w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+QQpTvE1oajew97V+MXrz1UHL3eLnEr+31mMb6fAHnc=;
 b=HRZ9TXicfasIlfP0D3SHI6G6dRDNxNYo9agdYHmK/kJsjP9r8aTigxLujbefHNw7a2J/oRRbIV/wWeA2XP2WNYiUKT0z1bU9/LlSeXqG1IrO1gehK9oQDITD0eSGz9+hZ5pEypafhhznG9sagody2oQS1z56Rux2dpXF4Dn5DoAU6gA+cT+lOPnOnOXCyM8EuJzlqCdDLwBKIWsIso5s25osIzxW1Bp+OL4kiWAdBgLMgrh7knWdZHIWBjnQ+t4Gjh7adxK/yW3se5HRy9Ws5LF0TL5oCXKUqVENiNJLrXpx945X+gxFRUKe0OGmG5rfXY+8R7H4lW2KnEBrj7bzCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QQpTvE1oajew97V+MXrz1UHL3eLnEr+31mMb6fAHnc=;
 b=psdC3dSpZiHlYYS2pAkgFpGa/upDm8TOb151VEM2rZTH+NMEhoOC3L5PLHLWC3pahZc+K0+VpdpPiFbUG+s2iJPsqd0IKyOObmM1xzQStsZG2j3BYPFCvJYn/WKN2CHc9AnVshnyYqqjQ2lWIY1T7KGHHu8iCtAH3Xq3GJUjUMqsnibE+++xdMq7U3YQBllfTz1/Homr6NbGbaH4fHpj2Wt5f4+sHJuYuwzhKUzMApFPbtzXbId/z+vSK8Bf79g1jye9/z+qGgTFIH613j0N5prcZNUjw7pgvhjOvWSzlhDbSRfn+XQswNWux1wXANlDBXayp2FigKeXDPySmuiIhA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AMDPR08MB999918.eurprd08.prod.outlook.com
 (2603:10a6:20b:751::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Wed, 30 Sep
 2026 07:43:22 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Wed, 30 Sep 2026
 07:43:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 9/9] block/block-copy: coalesce write-zeroes tasks
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 John Snow <jsnow@redhat.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260929155125.3151111-10-den@openvz.org>
References: <20260929155125.3151111-1-den@openvz.org>
 <20260929155125.3151111-10-den@openvz.org>
Date: Wed, 30 Sep 2026 10:43:16 +0300
Message-Id: <179075419694.959158.11640032175934547455.b4-review@b4>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIXP296CA0033.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:36e::12) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AMDPR08MB999918:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc032ad-b472-4d54-ea43-08df1ec680dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|23010399003|38350700014|10067099003|56012099006|5023799004|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: umozVgqjFx1V5vcZIf1h9yWXFN6PK9iuyyB1oQjknMbFVATrQTRvOynwRDuYLeIjDfyToGzKRNk9Ov0buFFsJagbjOS2rgDYMEoSR7LLcNwqyLi7SqM9tVs+Kojnj8Lht60Cn2eQLnN9hfpMjwFwmWOXcjLTO1YOV84VqjvYsp3T40d4gnUCpTOpgk3bZXajz1NpJBD9T0NcFlLgAvEz9esot2XmEgtBf63aK2JB2W2mVO/LuyLqige4xIHnKwFjxTpvHETGFx2fANx3nam2YvU4LzU3MUawPGUzUi88YqMTfC1s7aQkMXFv2kx97oHlnKgwip9cj6AL7uGR+W+/KD8uCpX6zr3I3weZDJiGIuAjyxCxvzuzEkyhz+vz2WCaT4e6K4oRorTB0nBzdiL47O3u7wDTE6B06/W8SkcaPjl9Bk1mk2/KKStaFHc+dqLtjhloVMimssLpc41n1SCGLOqi9X6Pny0HOdB2xbObfHFPaLyZqxV9/4/xHtLfkICkf+q3vvUm03JeAuff/Jl7iQePnf+yjYgPtDivJhEtsq80PCI057X5jlR2WCGwDlz70gNVwdJzLS4EdDBEj3HCA268vY8ioO66iLm30kdP3OP1Aly5HjoscjHTFQ6ryDc29eNveOT1qMB/QbD+lh/3Y83ydUV2VU5FRbIjsyJpSLzCitP/CZJ0GNUJH4bR8z2MQKaigspZfmdg/D0Vi77sow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(23010399003)(38350700014)(10067099003)(56012099006)(5023799004)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDlnQmJCbTMwSWFKeDBQMGJleUw5WWhocm5ob2x0VnVLZlFkdnhlQmFMeDEr?=
 =?utf-8?B?Sk1tcXRUZis0eDh1OWl1YThqZExPVHN5OUtpLzVrOS9mMkNCUUgxbHB4YzRj?=
 =?utf-8?B?a2V0b2ZSd05iU3lscnhMMU5XYVdwMHNEdTkzY00ycFNRaDdUajBJcHI1aDl6?=
 =?utf-8?B?S0UzTVFJMndadk1oUm1TYlBwdXdhMDNZZHU3aUZ5UEc2Y1VGek5GQVd5OHR4?=
 =?utf-8?B?VlkwQXQyTTUxMHc0RjUvaU81d092RER1TWl2ZkZ1Y29oRUcyZHZxRU85a1RU?=
 =?utf-8?B?UDg2LzRlcVd6aEV3aDkzdlVMd0RtYjMrTWR3NGpPRjZVVzBJaG5pOTVSclpG?=
 =?utf-8?B?Z1NzeElBZWgvOEdLSzczSUZ1eXFMY1pjZDIwNnQ3d3Z2cFJ6QkF4dzdmN1ZC?=
 =?utf-8?B?TjdqeDlXeHdUSkFqWDFQODNEd014aTljV04yTGtRNzByMXM5cm9WbytlVGF0?=
 =?utf-8?B?U3dPZW03KzZkSWZxTDEwb05KcHRWcXYvTzRISWl0eXQyajlVcnRmUmhLNFNO?=
 =?utf-8?B?RFcxZlUra3VJU3E4ODMwaEQxaFQzZGFBR0h0blpvVEMxQS9iSU9BRXJnSll0?=
 =?utf-8?B?dS95NWlwbGlZc3NyMHBBczRjL2MycTF0L1pEekthdngrN0xMREVmOHZPRnRJ?=
 =?utf-8?B?Q0Q5SjUzNHM1N25vYzJxdWJkdXpJM3ZuMDA5QUpmTjZaNjE5R2hXSVl3bzh5?=
 =?utf-8?B?bkNwVzkweHByaFM4dVgxWFZGM3NUeEV0NE82NjRGNHVDMjdYWGpvWnoxaElX?=
 =?utf-8?B?ZVZKSDBzSDlkWkN6ODg1R0NxbDhIc0ZtTUNzeXVJUTNLWjB5alZtU25PNWE3?=
 =?utf-8?B?bHl5Zm1SMEhJdmNzbXZodEw2bzk4TkZKTFEvYm1vRXZXMXhNeXRmcDBveWhh?=
 =?utf-8?B?eFQxZzZyRTV0VDZUVlRQTnovSUphRDFjd1BUVVFiZ2QzV2hwNnJqMWRCT3dp?=
 =?utf-8?B?Y0hPUUc4cTNyekpRcEVNKytqTHBkblFCbnpIQThzWk11MkJhNjF3V1Z4MUhp?=
 =?utf-8?B?eUF1VjZrSUo3aHBQL2EwK2hqWk1CenVhNUxOaUZ6VjJXYmxwVjdtcXgydWxC?=
 =?utf-8?B?SnQxUzBCaWRuNlVnRWg3OGNHdlNBeGF4ZHNYN0l0dmFvVW1IYXVzbHB1V1JC?=
 =?utf-8?B?bGJBSFBMVEJFdm03SDcrbjBveUplcmRYWVBSdWFmeFBxa29vdlpBeU8reWRI?=
 =?utf-8?B?Y1h0MXRCbTU1NG1NcGdPeTRkRHFmaVpUOU9wdllKWE5tV2xpMnRMV3JwZkhW?=
 =?utf-8?B?NkJVVzFFRnlBc0J4ZGxhbEtHOGVHelZoZ09NRU9BZjNqQitHbkRQZG01cTZh?=
 =?utf-8?B?TFpkVFJVNjNwMlZzNmRPaDBLRU1KdjVyRFlBdVJnSzR3RWw5RFFHRkJVcy85?=
 =?utf-8?B?SE1WQkZmWCt1QlFtckhDOWloU290N3ZvY0VXUkhLeHArU3dBUVBES0poNk5l?=
 =?utf-8?B?a0dCNTFGZ1hJcGdTNllrY2VMN1JybnN2V2JsNi9qZm4vK0JyYUdTc0ZkTUYr?=
 =?utf-8?B?MnczZHBjcFozOXpPdFV0MnBqbEZCSkt4enZqSW5GeDN4c3JET0FCTjZDREhV?=
 =?utf-8?B?ZENQczVJNzB0UXdXdjVTZTJ3NzNoaVZwZzgrZnJBRDVpdzk4YjhsV0JWeDd3?=
 =?utf-8?B?MVhLQkJNWERjaU9mNy93a1JMTFlzcFFpNXIyWG9zeHM2Q293a0FUTFRGb3V0?=
 =?utf-8?B?SEwyc1A3ZzBXTUxYblYyYnhwczc1eWNrN3VoazBPY0xidWJGZWZNbnA1YjJX?=
 =?utf-8?B?dWZ2amtFdHJ6T2g1alJOTm9YNWloU003OGRPZkZDNStWTkdtTjVnSFRJanht?=
 =?utf-8?B?NGJuWXJBVjBmeHUrV0YyUXZYWDF2dkliWiswQVRlbVlYT1V3a1NOUDYvdVlC?=
 =?utf-8?B?d3BBbTFiUUZXK0lLNEhKc0x2cmtNQi9KRUNtQXhVWkNwK3BnM2FHVWI0NnQ1?=
 =?utf-8?B?eDZPZVJQd21Ec0xCN1RuOERPSG5sZkFQejN6NTJHMjE1OGM2QkI0cklDSTV2?=
 =?utf-8?B?RmQwUFo4RTB1Ny9XQm95ZTFuVnV6RTlHNUxRU2lROGZJelJLNkVLeGVId1BR?=
 =?utf-8?B?M05KU2tFWXg5MDJZZjBLVHJlKzJZUGZ0eE1LMFc3TmczZjZBcVlnMTVEQmNq?=
 =?utf-8?B?SWxXV1VMR1NSeUFiQVBpRU9JUElkdFFGMjJrQlNpdVVMQXBiZWFHVGlMeUFw?=
 =?utf-8?B?Q3FpUisxSmhQYU1MdHVVMmI4S0IyZ1c3Wk9oNmsrS3d4alRNUC82OUJJc01J?=
 =?utf-8?B?ZjBIKzlIaVNZK3VWOVlnRFdrT0xQU29vSkw2NTA4d295TVBRUHpMeGxQemp0?=
 =?utf-8?B?QlRRVUNrdWtFVk9CN3BQakNIS0xuUXZQVG9aaFlJU3VLajZ6VUVQVEIweXNZ?=
 =?utf-8?Q?8VA/+eFq782sz5rc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc032ad-b472-4d54-ea43-08df1ec680dc
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 07:43:22.6199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F6+xmVhQGdqhO7b7h/aRHyT2v60w67KK/TmKAnUatfx0ve8F2O+VHUqX2do45M7FbUEi1dszHd3u9ZGGPjUZBKx8qj59fawENJ+QlSsWaFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR08MB999918
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Tue, 29 Sep 2026 17:51:25 +0200, Denis V. Lunev <den@openvz.org> wrote:
> Task size was capped to block_copy_chunk_size() regardless of method,
> which sizes a task by the copy buffer. A write-zeroes task carries no
> buffer, so that cap only splits one long known-zero run into a crowd of
> small COPY_WRITE_ZEROES tasks, each with its own request against the
> target.
> 
> block_copy_task_create() already decides from zero_bitmap how far a task
> may run, so add block_copy_widen_zero_area() to that decision: for a
> write-zeroes task, re-search the dirty area under BDRV_REQUEST_MAX_BYTES
> instead of the buffer chunk size, and let the existing clamp cut it back
> to where the zero run ends. That bound is INT_MAX rounded down to a
> sector, so nothing has aligned it to cluster_size and it is aligned down
> at the use site. Widening is safe: an overlapping caller waits on the
> task's BlockReq via reqlist_wait_one() rather than observing it
> mid-flight.
> 
> [...]

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

