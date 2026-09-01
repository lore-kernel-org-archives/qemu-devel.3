Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78127C624D5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Ofw-0000GC-7J; Tue, 01 Sep 2026 09:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x1Ofu-0000FY-Aw; Tue, 01 Sep 2026 09:37:18 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x1Ofs-0004If-N8; Tue, 01 Sep 2026 09:37:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxLIcUuNU0UMhec2Ldro9C+SMalh6cc1ITTbYGY7uUGc7b4RRD6O/+wx23ldsSLFVRFRfCmoJ8FizxaOY9AJorwQg5YOZlOHBR5LmA8g761KIfA35paBFhrOfMdCXtnwL3ccHw4nSUnaqXszkBUt32la4mIRpRQ0WpmK4yY5+kO2mih8K7jbLPOZ+P/wHi/pItLQlX5NomyXqWASwX7M9JhumRKGRF2B/y4NQiv2gdaK7hCAD1UZfyL15yjeJZYjKwb9B9P44rIozCy4yj/W+0+v2iC6aiLpDcYytidO3zb0GqvxF4Va9JV5xFDBt62RLkOPk1T52mSlAjCpjnXuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YOyTz+Jp+1velAiSVgF3BmHuyaj47qWxRh8r+xC0BM=;
 b=g0Rkm2MumUVka2IWRHUJJ+TXIlRmgaeHXaTafHgLPt+ZOjc4mVSYxEaEuVQu3tg5NfB76zDIdzU0SX5gJNz3BLLfImbgqlnxciKv5MHhAk15bA1es4Lw6nTYPpKo+YhyvofcCd6Zhw70+FQ61OFlmb2N+9JcMZNc9TQUi69XSS4f25p4+f125LuXbdBJy3Vp3EyjWjIt/noVz08G+bk0D3b0bgBKkO+oX/t/4cchTNt3t2CllXSB1dX2tWclOkvWnrBNLjZyWMImP1ca1jzJcZLv89WIxhBUqvEXsiVXnigBZsXKhdz2MiGmH6yaIz1zicKITqLFdD8TgBzXA4Q2bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YOyTz+Jp+1velAiSVgF3BmHuyaj47qWxRh8r+xC0BM=;
 b=e7kRfUEsf6PXVkvkt17uJtfzEzTLUplMiUXt/Ztq660BmM8pg1s82Q7Fm5ST60qlW58g5htxFAGZEDoDLtGG32vYdbDk89KoRlC5PyiQYSvUGV0EhWHr9q6Ov10yTO2gcGCQCZxr/R//acx67068wp7hh6QfHAAGLLbBY78kSCctupPGaaaiiEcF+W7xTsRXD+SsJ+Z+Ww0nS207p+4FI3c18dOhkIuwkVzanBehCgzzAWTru4TXlHYAuORJDHl4Bb+2T+h6kH4d6Z4+v5J+BecpnVwr5+I1vX0gGFCgNE0cPGDqqC/3trVC5fzM4QPts7XKSWgQnkmsdUmiakZTig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by FRRPR08MB11965.eurprd08.prod.outlook.com
 (2603:10a6:d10:1cd::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 13:37:09 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 13:37:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/9] block/commit: pass BDRV_WANT_PRECISE to block-status
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 John Snow <jsnow@redhat.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, 
 Eric Blake <eblake@redhat.com>
In-Reply-To: <20260828144554.1741910-2-den@openvz.org>
References: <20260828144554.1741910-1-den@openvz.org>
 <20260828144554.1741910-2-den@openvz.org>
Date: Tue, 01 Sep 2026 16:37:05 +0300
Message-Id: <178826982593.73810.15751196381599413010.b4-review@b4>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0114.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:350::18) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|FRRPR08MB11965:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a9714c-a7a1-4165-ac1e-08df082e1ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|23010399003|1800799024|366016|38350700014|10067099003|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: CCKIZ9ymmKOfdarmfm6+TTxySh8W0KmPep1eSuk0TSHfTPWOWAvyBssPFjbeqTFtG7AIZ5qQPq9bZTzRvGLpjq7IbAn6NYOFfKnC4OKOS7vba6bY/KvRy9HTBbRqz4+pAI3eBHNddG93y+ocBBDRbzDZHNPhw5sQuJ8cC1hejyuOuHtIxqtwzmHylRrBJsV4OUSH0dHciJL1+W+8TSvSC0WJlE49rGLM8mrPrhLlAVLE0kk+kQuRSNdGt/T1LIXoyihGzCLmV7n6WSoniNchwWE5Rj/HNV1Od0gJNdmB4LvEfYTfs+5ISWm5ejwnaML3VHSw9utJcdKawUWBLovS5Ui5QPUJMour+XfCLZ6MWeR6dJB/+U6/dJBLnCOxL5JvYGOCByAe3IXO5WWWCzIh6PVd4nT4IlTnhF396lU0UbqYb0VVWF4Xh4rSmzLv7nRffWt1iAmzbFg8SdXok4vVrWUkC3eVR7LL3CXIWHTGkiAWv3HTEP9RkAMzKPn5ImAZN6sG5E2cmuaOTYIakxX0x4fq6PDatkdjy7O20yLcMU3OkwWJaY6nb6HhBw2pj73OdgmL+On37tsvsgG7dmuFy+FjOLlciPbq8qjJnlSNeH9Uj1fgj3teADe7L8Isu41C7P6J4RqquxtCXLejOs/LeMBkLrUIwTQDb5qfdwd+tO7NxksHGDKbAY4QMVvpDl2uumzpct+BXoxkQwb06dNZ1xbTX6SxTCKHSOzajO85Zec=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(23010399003)(1800799024)(366016)(38350700014)(10067099003)(4143699003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnIzdHZxMGdQb2dCc1dpNFpyMXdNTWFobmw5bDBFNXc5VEpTNUE3UTY4MzIw?=
 =?utf-8?B?V2JKUHdiWnJheDNDN3NZdVdpc0RjZTRZZHpkU01YbzFqY1hwcmZRVmNyeWwy?=
 =?utf-8?B?VWZzR09IRVB6WTF6Nm5uN2JYSFd5eU5yeitLTXVQU1ZGUytWQldkS0ZEbHhn?=
 =?utf-8?B?RTltUEdhRmgvRHBaS0ZXUTVKYUR2K2Uwc2R5dzhDMkVjY3ppbXd4dy9sUmZQ?=
 =?utf-8?B?a2F0WWhMcnJTbXBXamhhR29kUzhPbk9ncUdWSjZPS2d1NUdqN09FWFlCcVQ3?=
 =?utf-8?B?bWpUSFpqQTlMVWRRTGZKcXU4TmdZNFVIWVNBMm9WUVBEbzYyYjBMWFpYSjY2?=
 =?utf-8?B?TWxnN3hjOGpxblBYRWh1RHdZUUdCY2VVbzNXWlc3QURyRW5QbDFpbHVoWCtU?=
 =?utf-8?B?SDJQNG5FcldTSENnUzFaMlBtcWhzTU5iTU5YTlNxaDEzTkFuYTA5QlhkK25J?=
 =?utf-8?B?QWd2d0g3TkVqVWxHZXJrWTBjQ0YzdlhtYkozTjZaUkdyVHRGK3V0b1JVVkVW?=
 =?utf-8?B?VFVscUxsbzk0WGNnVDZoYVNuclQ4c0pVQW5Nd3BwRXEwalovM25BUGg3UTFG?=
 =?utf-8?B?RWp0ZHFlL01lcC9kVjZ2MXVJMUNVRjBKWWFiMG1yNEFxVS9SQXhmNERKc3ln?=
 =?utf-8?B?QXJqc1Fpd3NPaHVFSUZkV2x1VXVwOUdwT24wcVZaK1J1SC9ySy9KekVQWkRj?=
 =?utf-8?B?Z0ZmUVU2d0YrOVZpeTgvb2s3Tnl0SVJmV21UV0xhVGVzRWIyaUVoNHd3dkEz?=
 =?utf-8?B?ZGJtRnQ0M2w5L0dWSnJWV1VMUU5Ha2Mrck1UeHFPNEd1b2RRUXI0bkttbm5t?=
 =?utf-8?B?bXZndGw1ci9mc09jbndLRmRXOG1XQUJ5YmZHdU45Q053T2JFNk40OEQ2SnVH?=
 =?utf-8?B?enp3eE1DZFoyTzdINEFUOCtZWk1IZzIvanBrd21MOHpKYjJ1Wnk4dzZWY3FE?=
 =?utf-8?B?ZUxvL2pHRzlXNE0zNVNSUTYwZWdPV3J3UGJEcGxuam1Wa0NHdWpTQXFkNVB1?=
 =?utf-8?B?c0ZzR0JIMVVKNFJ0SE1QTkQzdGZLUWRmUXdHUkJVa1lKMFZxd05BeDc2dTgy?=
 =?utf-8?B?ZEtSaW5YY3N5Snc1UEw0amhhY0xaZlplQmVOSnpVcG00RmVaRGdraGJRaXgr?=
 =?utf-8?B?T1QzK08xQ2JHNnBtTlNDbHR5eTRrMmloUTRWYTVrQjMvQmFaajIyVk10RVZL?=
 =?utf-8?B?aXZydTJpTFRIY2dnd1FyaWJxTmhZT2VuMnFWY3owd3kyMm5mQVVDa2V4TlU1?=
 =?utf-8?B?cmw2WkJ2Uy9kc3NabGc2NktsdS9tZlFmZGIzbEJaQ25UZTlpSDlJSTRMMFd4?=
 =?utf-8?B?dk15c2hqcXM1THJLN3NmZVNoOXVyZnU5MUVzalphNGNtL1ZTTHg4Y2NaSmk2?=
 =?utf-8?B?Rm4rYTdJYTI2d2liWkhIU05CWkJJNGRWSmNEZnVnUHVJRWZZRm5wQmFYS3Zj?=
 =?utf-8?B?UTFLODRPMHNiTW8xWmNaOHBucVZQVjlvbDBaQ3l3MzlQSDRSdVpqbmNaSEcv?=
 =?utf-8?B?a2daRkZzMDhpQVJaQVl4SXRZVmg0OEQ1cmFyZkE3L3pVREc0dHZTMWZtTVFM?=
 =?utf-8?B?YlV6YjFjSlBpYUJna1g1aFJWb05Ma2ZVdE1UeVF0Q29uTWR2T1NZeGRuRUx5?=
 =?utf-8?B?Y05KWjF6T1lQbGhMdUZsa0xzKzNFaUptQzBKa0xZL0VERW9UNEtJY2J5UFpV?=
 =?utf-8?B?QTc3RFFUMGdRS3EwZE1lZzgzcTAyNHpMYXI4eWNYTGZNVXd5UFVtd21CMW5q?=
 =?utf-8?B?MFA3Zmt2aEtZeGlRc2ZDbWlWQ3ZReFNqRThSMldlejFSSjljZzByb2ZBRWRH?=
 =?utf-8?B?K2R4N1NOQmo4VTVpVlZhb2hrRDdWb3V0NlF0b1l6UGJ2YSs4SG0zTnRhYklx?=
 =?utf-8?B?aUFsRFBSN0dWUHFNVFI2UWVmeXNOTWR1a0hhMzdTSXpKd2djTmhnNDFqU3hC?=
 =?utf-8?B?L2l2b2tnK1NpSEs1QVlJZkQwMDd1Y21WZDVEQXIvZ25LeHlZUmdXS1JYcU1F?=
 =?utf-8?B?UU5nakc1OG1YRmdIWGw0ZTdHK3RES2ZLamprS1VBUUdGS0lPN0NkMm1wZ0h4?=
 =?utf-8?B?SWZuU0YzYnA2UjhVekdiTzQrREdvZDh4aFlacncrYm1MUEFPRW9PYXZTUVpL?=
 =?utf-8?B?cWU1ZnNMNk9WTlhLNndmWW1WaWRYL005ZGVlMG9ud0VXdCs2Q242U1FOMEZm?=
 =?utf-8?B?eXVHakVVcGE1R1REUVc0VjR2TE1nQThDTWlrZGtvUDU3YTZleGx4WkJveHQv?=
 =?utf-8?B?SEpNR213NWQ2ZE9TOXVYMk5HSnNObVNGUUdicFoxenVSS3I0bTBkOTZ6ajVX?=
 =?utf-8?B?WnBVdkVWdjU4VmRuM2g3RmZNWWFFZHFQNUE3UU9VU20vTUNRRVM0TVVxVnly?=
 =?utf-8?Q?8CU/U46ZmXRuvr8w=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a9714c-a7a1-4165-ac1e-08df082e1ebd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 13:37:08.9334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwfhyfzXSpH9B3xmg77ndg4gYadqk7/EGItzGrGHBvhaZEg/8Nqxvy7+bIQFaZspudEPKwEz22Ot+ZFEz2Ko7iYrDGhv4sJeEK5Zbnjmlsg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR08MB11965
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
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

On Fri, 28 Aug 2026 16:45:46 +0200, Denis V. Lunev <den@openvz.org> wrote:
> c33159dec790 replaced the want_zero bool with a bitmask of BDRV_WANT_*
> flags. block/commit.c was missed and still passes "true", which is
> BDRV_BLOCK_DATA, not BDRV_WANT_PRECISE. Convert it like the other
> callers.

Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

