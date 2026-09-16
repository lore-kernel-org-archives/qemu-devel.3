Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6FCC982D0
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6sW2-0007YY-2U; Wed, 16 Sep 2026 12:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6sVq-0007WS-KN; Wed, 16 Sep 2026 12:29:35 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6sVn-0005RC-AJ; Wed, 16 Sep 2026 12:29:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2VWa5xCoQuFO0Pj2xq3kBjuCqolumibctbkpWJo9x9Dl+YSy3Fh/aDGpiYaDWUd2wIW/twCi8Jg42awXtUZz+B0zEi6CcAtCSI4mqZGWmtDSCd2J8H8PqEUcPialbZViKz+XqiS/Qx47rwgffccBAkdqXxZbqGqangUcsAvLSLuFo9R0pITHjIzpWPKlIUITYmsKGO992b4UNMRjYR+FCngW3YO1xbRRtQ7xyiw27I7GKe8jXtdwkbrKUlZAzCgvaQQl/eOQp8wb15N79JncIanTD4j+ei0XmYvLHlPD+PzJUZ0U7kMEAsOo2m7JFFE5zE89jqmK/vAuI/elh5Sxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkxdRgualRQyGijEZO3ID9ytQQFYBgmFZRe6kejEWOc=;
 b=y3lorpFK/01Gixk0icv3Twh0BHlAoZbtPRe5f5EG0uGtqr8L0JK0wUWXPSMSO7fmsDvWVD1zw/mfG3cx+BSpu76t5IGQ0wUxfWVOObq5ITEtby2wlSyrtAt92fwKXV802XmYJPnV/Q/+rqIDOvX52baVPAIUztD5Bg61bz3WetfWFOG3+yfOdvEltB1N0I3enMXFSfF88cTMb32y61Kv+L6z3TCGuRTA5VyyS1L2FNHW8Qjc1UeKkzdxWVfxojPxsMJGkOUB4na0/vttbE+rcHhWbevzZoxZlq0JbtznYUPUCcrjgmiNR7Ng9nGM0JE1vWUNDBokVs1UErsYFXnQEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkxdRgualRQyGijEZO3ID9ytQQFYBgmFZRe6kejEWOc=;
 b=qMMLGxz996i4w4CtpXPkFeIkT9BzPQEjDtqV1EXYoSwSExJBhmw8I3IX87JsUNEOOkCmmmwaWYvDLOJmuv4m+JevKfFdZp4J/GTSANZT8Cw2U8kVJ3P7Jilsiu6W01l4DJ6bH24guclAoy5q7vSA3U6VzIo7BN4Oh6KXu8A0vzpBpCuRXrBVEX8k1SkCHOGlmjWV6bJ0ZMpZE5ipFFb4qOKwGVKWv5JxuSzVCPnhRaXruBxACl2Rq3MX7ryJ5ETQ4DjrC+mBqx3BXAnJvj5I11r+tvkLGExaGDD7GladGG8M9rbPGYd8cgiu+D/ejTY+r4BqDXOwkID13w4xzBAzDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by BR0PR08MB801654.eurprd08.prod.outlook.com
 (2603:10a6:2c8:2a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 16:29:26 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 16:29:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/9] iotests/040: cover large and fragmented commit runs
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 John Snow <jsnow@redhat.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260914145250.2792879-3-den@openvz.org>
References: <20260914145250.2792879-1-den@openvz.org>
 <20260914145250.2792879-3-den@openvz.org>
Date: Wed, 16 Sep 2026 19:29:16 +0300
Message-Id: <178957615604.653083.13818296300629112251.b4-review@b4>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIVP296CA0098.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::7) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|BR0PR08MB801654:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd01f7e-b767-490d-60f0-08df140fac8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|52116014|1800799024|366016|10067099003|6133799003|56012099006|4143699003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: EYRZWO8cvaX05BTtYI2nBTmfnEU2JJ1Cdsce+sQg4LeYJx1F5tGIEzZ+J46kX8vnZlPP8eOGvqcIng/170Ct2n/O2k0TM1LRCZdbunhA4po02Y4W1AlS1FtifpnqK3q+Q2kNaKDhJrsw2ikOlQJqekLB2t4DTjo/2uguPsmPlEGWllLAgiTkXE8YtdhuscWA/VwTXeEjI941+kfwY386gxkI1ysFPGI0wmSk3PxZ0aD+9QwtdgeUq5vitBOYSIHJp1HB9pWMgZQ4dFxFFT4eIfd2eugEA7hiW56IVqurL74IRlp41H5b+S6qQUKZr07jpgYEDYVufDjHilZZiQg5vi+9BM/SDFQLbU5YUfCM2Gt0iz2NAoJwzFtonzKuDh5kEkPqqICMLUX6DoSpTsrMDSAcFzg2oMbyxtHUA30cEgQH5yOm6YONsi7chRfHLZ138gqvbesz971obz/Qg+fqPP9ujzTw8HRdDIYo4X5jT93+hIjKZRQkU0d53JyMQpbE4OOFfyEeppGlDxkoV4c1gMUvm/WIBSnAeU9eIxVY76rGIrJdLT6rzKYLEuaGKtOqAhpNP75I1qdvXoVZZYqu5QxnEITFN8UafLB+MjkZo0f8CQrIifuFyba7XpqdAZ5XN4QQQJjIUA4FnA3MImv/acZgZP6aXwFXhuCDGZStG7+L4nTS7RTPYNVHmgJe90TT+1/Gkx++yR95AOADKGP4NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(52116014)(1800799024)(366016)(10067099003)(6133799003)(56012099006)(4143699003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2E0Mkdpa0R2bXgyYlg5N0d1VFlwd2dZc3pzMGhTUzdmY1FGTzJsMmhuU0Ur?=
 =?utf-8?B?NnRlb0lQZngxY0JzOVJFVm1Henk2N1RsbWZFZklLMk4rSnovK1N0dFo1ejNv?=
 =?utf-8?B?c2dmZCt3Z2xKWU1lQWhEbXdhWlIxSCtVaW9rVmNKYnFQQ0ZTekJ1U3hrRDU5?=
 =?utf-8?B?VFRDeHVkNW5jWVlWVmJSMldRMG13NGJkWEp1dHY4SmhWYzRwSHQzZEdZYmVQ?=
 =?utf-8?B?OWpIeWdtbFY1UmR2bVprUWpOcmMrdTUzZk01aWo2USsycnlaV2VSMElqMEc5?=
 =?utf-8?B?aVpDeTdBL0JYcmp6cC9udk1BM3loOTdzSTR2eDI4NVVmZllJbFBtSVk2ck54?=
 =?utf-8?B?WXovRjJQcG5BMFdUeEJKeXFXWllxeW1ObWhPNDY5TVVkQ09FMUUzeTFDUStZ?=
 =?utf-8?B?NEJhb1RDNWY0ZkF1MmVFS0RLajNYdnJFVmNFYzdqcHAyd0dMSGtVQ0hCczky?=
 =?utf-8?B?dFhsMDRFSFRZQVV6cXBBTlR5eHcvUi9xMXpObDRBODNncVNlVG01OGNaQ0kw?=
 =?utf-8?B?ei9iQTJKMjd4NFdzb2J2YWV1dWQrb053OFd3ZlJ2Mkh0VnJmMytWMVhFeE4v?=
 =?utf-8?B?TWk1bVNkTmtodXNCNHc2TTcwN3hid2drelcvUE9zUlZpaTR0NXlEMzhGdnV2?=
 =?utf-8?B?VURCSWU2b3FBL09yaFZNQjhNY3ByRE1QVUlYNTVCMkpiNFhOc2ZiM3J4cllQ?=
 =?utf-8?B?WUJXUlRwUlNKQ1JGWklUblJEOUdyci9mK1lBTHZXNHcvN3JSUFU4L2szOXVy?=
 =?utf-8?B?eGRzQzdhd29BNDNFUjFsbEJ0Q1ZZc0pldFgxNzJaUFlWOU9aT3g1RXk5NUVC?=
 =?utf-8?B?Y2VZMlliOEdlNmxmQVAxYXl2Mi9FMDdhTVQxNzFpcmM1T3JKakVHOEltWDNs?=
 =?utf-8?B?Sk9uQXMrNVB3cmJZVGVQWk9vZVJtRStvN0RUYUVCSURoLzlER2huM25xK0FU?=
 =?utf-8?B?QW1YVlV2bVpOMU1vNjBPQVR0cmZma3Fpdk5vay9RQWtQVGtrMmxVUjlwMU02?=
 =?utf-8?B?bEV3eFRrK1BvTkZEdUdRR1FXTUwrNXJ2Z3poUm5aVmtUSG96RnhHZ2VVem94?=
 =?utf-8?B?Wit5UnZJYytmUW9MR0RvZ0x1L0p4RjUxYi8zb3FCOTNSMEgwVU9hOFdEMGdl?=
 =?utf-8?B?cFAyOTZ5enZUZkZMS3diTW0yL3V5c0FLTEdLVW1TUTlBVDlnNnZlRTA0ZExm?=
 =?utf-8?B?Y01COG9WakVYMkNMZTdvMzhRaXh1Q0xyUFFrelZ2SjVQVDlVZllVbDdiWU5X?=
 =?utf-8?B?WiswQWZoMDkwNDZvc2VJTE14MjcwTlh3a3o5U0hkZzFvVldhZCtCc1RLWGdy?=
 =?utf-8?B?ODlJR3grN3dPMmhMUjlYTUJoWnpFSDg3NG11VDRUUnlHZStibmRJMUxPS3do?=
 =?utf-8?B?dG55QXRpTGhBV1FWOEYxajNneWpIVW1DVDZqOHdiQXh4VU1ERHNGYkZzekJM?=
 =?utf-8?B?SjdJMERzV1lBTVprRVRVaU9xaHBHYUo2Wkd0Y0YvLzNDK004UnZRc2xFVE1J?=
 =?utf-8?B?aElSd2cwdndkaHRzZ2VyaGg3V1c1NFFyVWFzT3BnZlZ3WUR5ZUV4bVEzZ1l0?=
 =?utf-8?B?b2RHQUZaOUJXR2tZN1FFaEEwc2Vrb0FEM05lVUJMQmMxbHVyaFJldW1XTnJK?=
 =?utf-8?B?S3RjbWR1VmV1QWE0QVhRL3c2ZlNISWJ2YXUzK01QZjJkaEc5MmtyQ0ZWRUlI?=
 =?utf-8?B?clBKWXI5STZ1WnhZNkxpUTRGWSs0Q1hZUXhPZDRTbkxnRUVLZjlmd2xIbGRE?=
 =?utf-8?B?NlVrWXpkenMwRS93aFpMZzNvSm0rdTU0UXlwUlNKQXZ2RnYzS0NiRkJhd2pF?=
 =?utf-8?B?ME0vblpicWgyWmNDY1Z6Nk5HTyt4NEFRMzBwVUxsUmNIU0JlSGNDSmh0a2Fy?=
 =?utf-8?B?LzMrSWEvM3dQRHlyVHJ2QjROcVhPS2dLb0Y5eDdVbzNaWFFRRUxFbFh2WDN3?=
 =?utf-8?B?VGUzQ1ppTyt6L2xhcGdDSUhZRVJ4Kytza1lZWlh2TDBIcTEwcVd5aFJUdGg1?=
 =?utf-8?B?Y1IrVXkzY01MNktEajMvVkFBblhEMGZvYitMNnRBbU5VZDFWN295LzJ3Y2ls?=
 =?utf-8?B?WHJrc09weE9kcElUdkpiRktMbUZOVHVFS1JjQjNWSVBYVjIzRkxNNnVESlBv?=
 =?utf-8?B?enVDNG05bnBHNTd0QitlcDd2OFU4V0tFOFBhZkVEKytJano0RXR4Zi9tNVdl?=
 =?utf-8?B?NEpOSDZrQmpkekFBUTRIK0V2dVh1cHBtVEdiNndDODRyTGNKQWZSRktyMmxk?=
 =?utf-8?B?cXBON1JINDQzV0NNUjJIb09ablQxVyt6cEdScWJTMDRFRnd2dkhDZExZVHFX?=
 =?utf-8?B?WkNRQVBGaFJHeFR5VTQzc1VYRlA3UVoxRFNtN2dtcnZmeklGaTk3aFhrOGpU?=
 =?utf-8?Q?K68qr0zSIyCdlUuA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd01f7e-b767-490d-60f0-08df140fac8e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 16:29:26.3416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIpZNefOlqYzlVS3PtvppvTHz0HSYHfmH56daYIBqx/pSV2rJtt3CkDTKy+OQnR4oOhMBeVJWipPZ0hLONlUKWBerVy0N91gGpSvEZ5/cTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR08MB801654
Received-SPF: pass client-ip=2a01:111:f403:c201::6;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
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

On Mon, 14 Sep 2026 16:52:43 +0200, Denis V. Lunev <den@openvz.org> wrote:
> 040 never commits runs long enough to span more than one block-status
> query, so the answer that commit_iteration() is about to start caching
> goes untested.
> 
> Add two cases on a base <- mid <- active chain, committing mid so the
> job takes the regular commit path rather than active commit, and compare
> base against a snapshot of mid taken before the commit. One case mixes
> multi-megabyte data, zero and hole runs, the other fragments them down
> to single clusters with every transition off the 512K boundary.
> 
> [...]

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

