Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A46DCA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCfxN-0007lN-PI; Fri, 02 Oct 2026 12:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCfx0-0007hU-Ig; Fri, 02 Oct 2026 12:17:34 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCfwu-00050E-Or; Fri, 02 Oct 2026 12:17:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZATHsBFVYRF1NXQUJsrqcej6tmPI2TUfm+8mU4SjQ46QdNkoqyAJJAyjfqefkLx0rzUqAycDJNRbeozu2ZaGGH0rYwAj/oyMRrWPbl4E8oLdu2OKRvJL2ldL94JDNENsz5ysDZHLf62efwvcyAeBuVavt/ojBRx7VpBw0WiZpd77zlqYcXly0/kdgYabxnabikOR9j7y9sRGMFDvawf7hXa/hnFV7BqdZA7F2S9fiOqEMPqROkydr089ryDeF99zdjjGZyYwjV6ybgWhM6Js6RXCfv2FwL3LgKv0AIkGPomug0I3PIVZ0vG5oziHxTzV+MSahDB1LaPl1x55JPByw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HsqdR8SUH1X3AWHhNAtMSBSNvWVaXMx5vPKT5dq1rO4=;
 b=FIk3d9MhscS/bnqSedeyLtaBn/vcs+U+hrei0ZaTbXFH3NJ5lmXug5pmug6rsYBdkrZ2VFf65M7b+ExlzGwLlLwkf0kyr9R39kGci5xTlQ9s5AKQ74R69RYxc8th8VcIdH+mfYFTwYtuIxh3dQ0Bnion/LZmZ3OHvfTJqlZn9MX1q4HsiPjagmg9ECJxnhLh7o3HukWKsdQOFCnz20ykpmW63qEgLjY5kgW+Fqod8Pi1tjbQc57gT9ttg165H6MtrHCjY2dXNrHG+2EkzUPJFWYgKzzbOSwe1UXnbDUa9kX/c6VowXrwuWedQ/ME+uPGXrSIWzvrwKtvCx0rmmUztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HsqdR8SUH1X3AWHhNAtMSBSNvWVaXMx5vPKT5dq1rO4=;
 b=w17qf+F4DZ3Ice0VLumnnbHdUc7HS1UovlDCU9K+zCpL4eiwrp1LKkmWdsMK2ee3nzRjtgtpANJxeGNG1e5BwJFWuaUvFJWqRmJRNMMhRnr3DhnyJ69cIvytbc0wDhDobFIDGGE6bIiio01EnL4wtLCr1pqwO0e6jqo3KO9aC1jAeD5F9dpilM44QgTpSMs8JXYeib1Hm9+tM0cpoHp0CMReH2l6DJO004FZigapvemtNTJS57USgJZAV0pcIa8KaOSV/zwcBbIKc0Aq879ZcqqjoN/SHjKtdXCa3oVA1E3xU04R5qlC3xfltAwXr4b4/dYI8L908Bh0uCAXU4lUUw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from GVXPR08MB10667.eurprd08.prod.outlook.com
 (2603:10a6:150:15a::13) by PAXPR08MB7396.eurprd08.prod.outlook.com
 (2603:10a6:102:2ba::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 16:17:17 +0000
Received: from GVXPR08MB10667.eurprd08.prod.outlook.com
 ([fe80::d70a:96e3:8888:668d]) by GVXPR08MB10667.eurprd08.prod.outlook.com
 ([fe80::d70a:96e3:8888:668d%5]) with mapi id 15.21.0496.010; Fri, 2 Oct 2026
 16:17:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/13] block/file-posix: drop the XFS workaround for
 post-EOF fallocate
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260930165000.303236-2-den@openvz.org>
References: <20260930165000.303236-1-den@openvz.org>
 <20260930165000.303236-2-den@openvz.org>
Date: Fri, 02 Oct 2026 19:16:59 +0300
Message-Id: <179095781936.643598.18150676887613934143.b4-review@b4>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VI1PR09CA0091.eurprd09.prod.outlook.com
 (2603:10a6:803:78::14) To GVXPR08MB10667.eurprd08.prod.outlook.com
 (2603:10a6:150:15a::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR08MB10667:EE_|PAXPR08MB7396:EE_
X-MS-Office365-Filtering-Correlation-Id: 139715d2-d72e-4425-8e85-08df20a0986a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|52116014|366016|376014|56012099006|38350700014|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vy8MvKkaQ4ZI32IIr4VxxtwuU2T1kKhsX11JCiU1YgiMDZCCh9W6Zxa06ipYb974ZcigWga79rFJPJI47HzxdOMtb7Nl5kSZVCV7HsPgecfGg08X12NYLrM0b9BWYcBvseCkITxRqnL+4BueL/BVvkqYSF417QQ0ZwYY6OIlOmUUygpbOqdAGEAV8GlqJCUTA8MncJExztaztLyatuNVqPs7oKUX4fuMr6QDdW9pZ5E8qCkAOl81TNZylpCkMEj3znS/MqjuW/PTTMBtwhogjRFc6kNJn9inBVfbQYYrNp2ZBSahkLYy1LZrGmeFPqzAjoz3hX/p2sTV2fuy+nzfqgkqbo5s/dpxAcl6VhQMUJrM6T+zpwzkrN/Wb42dqWaXH/oj2ZKNtzNxuhNO8dIaw0LXALVpGeCKMT7S2xxv5lP6KEGn8VSdOpPNG4e71uzXo+ph1bLcZbkH+C37HYlYgals45LqSssecZ2Fj9mNtXF2fQ4Is6fQV7isfRJnB3D9O15/z8ROl8UlDKaJFprA0bAPNQooLvTvz5tVFo9fMZn5IR6mtIqRsOheCj1d/6dwEKUkOWjbGce/mfmYZevdEZQpILCmWMCkTCG9po85YLoIEdy7iR5GLetJAfPaUP27uxT1tkG3MkYVlRGfCgofZmjMRsmWFFZxTbYIHQhAvF1xVielmgxiz5yuNx6dw6gXPpNhHhkRZjmBXhSH9adUGe1nMp3ZwYsRo8/ipJ0HJ/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR08MB10667.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(52116014)(366016)(376014)(56012099006)(38350700014)(4143699003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MllvTHdRNTVEeEh3SW8yRjhJRVBoOHZaV1F6S1h2THNkK0ZBNGtpL01EVlo5?=
 =?utf-8?B?S0V0VXFYcC9HQ2NSNmJxWFRYR1BabnhnMit4RWNVSWI5cWhCRjBFVFUyYWh4?=
 =?utf-8?B?cjhiOXdIVEd1UXVWUTZneWNvY2RRZ1FHa0ZLSHZzQzcwOFJGMGt2S2IrZHZP?=
 =?utf-8?B?UFRBNEd1REVZQUtwNEhsVm9FZk9NWEo4SUoyNGFIY3QzbWpBeVo1Tm5IbDNs?=
 =?utf-8?B?RVd4MHFHR20yOGZwMjZ0YklmcnEzS1FlOWZEOTRlOEthb2o3dWVKNW1lNEhh?=
 =?utf-8?B?SWJqN0NpZnl0NmRCaWNyL2RoL3RWcXk0dlNEU212Um10S0ZQdWFNM1pQZHdC?=
 =?utf-8?B?ZmNZckhKNk1qNElPWU8xcnZrcGtjN1BFN0VqdEFEWkZGbnZ6R3EyOGNodXkw?=
 =?utf-8?B?ZUwzTnNFTis2dERCc1hodkRuZDU0K1NvUTE2S3V3bnIwMTJPVCtLdGdEQzdl?=
 =?utf-8?B?UlNxSk5vdEJXTzNySWtGTWc1TFVvMjhSUDZBMVZXU0wzYWJBUlZFY0RDT0Vr?=
 =?utf-8?B?ZzVTQjBXWXpRWUVOL01GWnZQTnh0VHA1b1FLUU0vQ01JVGxXS0RsTzAvL2ty?=
 =?utf-8?B?anBUNFpleGxwSjRnK2J4NzZtN2dTZUp3UGpHeitHQitjTERHNTlWS1MzOUd4?=
 =?utf-8?B?a3FXT3lkM0RDM2ZOTTczdHBSc0lqdHJWbG1HeDlBdzJwVmlteXBlZlpqQkRn?=
 =?utf-8?B?UDArcXlFOTVlWGtCOHJvVEUvbCtsQndkcGNQckRYbkRlb1czVlZnRDZ5WE5k?=
 =?utf-8?B?R3JLbXdRL081NWJUQWZNSnptV2dqUDJydS9CZHB6SlRLcDQwSGlzdTJQMTJN?=
 =?utf-8?B?TEpFbVNKMzgzZ3l1eW01M2NxMG9qSlI4MGFnSXR0ZStuc3ZjOGQwSisxbTV6?=
 =?utf-8?B?ODRQZFp4REdqaHlLUUVNZk53OSs5ZElVNXVVQWZRZmkycXhrMmtTdHgzWVdw?=
 =?utf-8?B?Q2s4RVNSMHZKaEhYOUJtcVlCdnhjRUpwb2xlWmU4Tit0MElVWjk0QlZFNDdr?=
 =?utf-8?B?TFB1eDFuYXpzSWtsTHE1aFBNZ3laMlhiTGtLOUxWT3Y1cjE1TE1BaUxwYUQ3?=
 =?utf-8?B?TnhBWkIyVE1EZW1FRXhXSTRIbXRKK3JWcnRnUnFnL2k2dzNEY1VzZUdTdU56?=
 =?utf-8?B?aE1lckgrakFLS0QvMzBMOTdVTlhFS1NObVNnNmc4WmpvRjF4dEtwZ3d4S2lp?=
 =?utf-8?B?b3QyS1h5Mmk1WStndHc0aG83N1dxai9Ec2lDZXF4QUlzeUNmSFQ0RmswVnNX?=
 =?utf-8?B?dFQzMjlGenJ2QVRhREpxRHBRSmRuOE81d0hLTWhnalFoYXhMelptNi9wMS9W?=
 =?utf-8?B?US9vUzBhRXdXdjZIYnp5MUlDUEJUQkZkR3djRmxXTGpzUHZzUys2QlB6NjlL?=
 =?utf-8?B?bThxVHMrN3ZNeEZxR0JlZXFTRitPUXV0WGNzdFlybXp4eWRxZjMyQjBlaGhm?=
 =?utf-8?B?VHIzR25yOWU4cy96bEtnL2VOcmFTTjJWcFJNSnp1Qy9xa2VTd0gzMGtLYTlS?=
 =?utf-8?B?Nnp1ZU5PMm50VFMxTW9PZFMyZG5QWFlaOXlDbExpcWdSUGlHcUx0ajczU2Jh?=
 =?utf-8?B?OGlrVVlyQnd2a3Q4RzFoQ2ZMMTlHVzJ2eisxd0ZMT24vandCbHRwWk5BV0lT?=
 =?utf-8?B?dWRvUUU3U1ppSkpXNnBzQkJwWVpaMG9sV0M1VkFGeU8rRHZUMU1JLzZVSnJN?=
 =?utf-8?B?dFZjeGRFSzRVQ1pDaXlTNkpUSUJaMHNDdnNrZVViVE41SXVja1VVSFpmdVFN?=
 =?utf-8?B?c0s0OHcrTmJiSU14aDl0T2RhNzdRaGNzSGh3VDhuOE1BTlZkd1BEUE1wRGlk?=
 =?utf-8?B?RjE4Z2N5WDZVQ3hhZjFvbGphZ2hUckdoblVtU1YxYVNkRk5uMlU2dFVGSGJh?=
 =?utf-8?B?dVNVR1diYUsxSm9kUy9QUmZNWVp0MDNqR3RKRXJBWktVaE9vaU1JZXpFMU04?=
 =?utf-8?B?ekNJTTFtemgrSTRrYnZaNzlQKzJscnlSNVJOV1o1L3ZGbDZNTmpRZ3JjSWFG?=
 =?utf-8?B?SjZYckVIVWZhbEF0Yklrc1FOSnQxUE90V0ZtYlpzdzRsQyt3R2JYSW9IMFVa?=
 =?utf-8?B?UWc3WTBhQktZRm9pY1JBTVY5a3ZyRVdCWlVlVFA4STVwRmZsY2JiemJiWnNu?=
 =?utf-8?B?NWJWa1JaTFoxUC9VTzJIc1hya2RySjZqVHhuMGFadHdFMm0yZHpqYmRsY20r?=
 =?utf-8?B?c0lidHVvQXBPamNZODVHdk9YWGxScjA1YVMwV01STi93cFNRTjZ4VEdQTTB0?=
 =?utf-8?B?MjlTeHVpUFhQYUJ6dHYxUmNJM0RDVUMvcDJrMlFobVJpUVY1RG4yUkJjZjJQ?=
 =?utf-8?B?TS9XUExjcGZTWEwyY24ySUZObVRiNWE1MXhOdXFJZjB0cElEMzdtMzl3NDB2?=
 =?utf-8?Q?IrQEEc1Hm6hW2iII=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139715d2-d72e-4425-8e85-08df20a0986a
X-MS-Exchange-CrossTenant-AuthSource: GVXPR08MB10667.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 16:17:03.5645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rELKXsZy52K9qeBzMH7a8Q7o6U74IZiiP2j9XxEHMobnTPg1Yi4IvILfMMwpD/2HneFsxnquWU2azgnjfeMunf2ceA6ivwDACuwXhDXhWT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7396
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

> 292d06b925b extended the tracked request of a post-EOF write zeroes to
> infinity and made it serialising, to work around an XFS bug where AIO
> writes past EOF were discarded by a concurrently extending fallocate().
> 
> The kernel bug was fixed by 249bd9087a52 ("xfs: properly serialise
> fallocate against AIO+DIO"), which moves inode_dio_wait() up under
> IOLOCK_EXCL so fallocate cannot run alongside in-flight AIO. That
> landed in v5.5, three days before the workaround was committed here,
> and predates every stable series still maintained.
> 
> [...]

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

One nit: looks like after this patch no more callers exist for
bdrv_co_get_self_request().  Maybe we can remove it from this or
subsequent patch?

Andrey

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

