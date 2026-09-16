Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F064BC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:30:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6sW4-0007ZG-Ba; Wed, 16 Sep 2026 12:29:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6sVu-0007XS-B8; Wed, 16 Sep 2026 12:29:39 -0400
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1x6sVr-0005RC-FY; Wed, 16 Sep 2026 12:29:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IA+JktEwDgfYvwiSX5lHgNuQoDI0MTl+iLYWikNU0pUj/GBZpvN8NES/gObKeDo0jgzD8HLfXBlWmWGYj+dhs72lXZwjS0petdu/7j2Ix057Hu56OXqjjhWiIDUfK7e7I8sYkKWJeFnjLbagjiVwmYUeQJx/kqFRo5MN2JroF+7ndH7CxPFE+mTpPmIpDKieIRdVuyhQkQ2+oyUSX1R83iLRZdmNbzKZCYxCC5S2QrcU260tZe4OtmxwIJj+BMgv05awtuh8wHb/auz/pvj4S/DM029oPQ4ZAXFHbWodtZFp8isJhPDj2Ebw5ry+BIB5Pr6O91j4+GtYIch7nBWrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=px2EElz72Hk7ogQSQhLmUlp/xCTm45WwXanZed6gOes=;
 b=vAvZinjxZCKDUWkGYaZa5NWQ0vLfFcosI0wPbBUFm456sfzpERAkEkH15hNmxtadYGG7Xn5eZXScNS71oGeDQ9Nd5irXo/DAybN2S+3e/fj6oh2+KodYmO8y7jhbgkzZFzIRS6GT9V5rtb7LNZj7irji7wCeAGOAw4H5SzL3GS/wFQqy5QapMtUDbl1TA4bQOdCW06k3ygVocFEoCyxx954TonJ5czmc1SQrZfGwB9jITnDE5kYiUMBtiKxlzFvC8BmnL3pcN3q0+dyrqKlDxnou1BSP/WL+KS1OHmZKEYZMPzS3KOpco6LCDQpf3LmY1ZpVZRYCL1mvyrYtmMQZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=px2EElz72Hk7ogQSQhLmUlp/xCTm45WwXanZed6gOes=;
 b=tK12NQEjkqGrUWaArp0blQQGZXgWac+E2kNKZ7xMK1zKTeqjdPiTdqlQTWK/ynS82yyg7Oli6qzLMLwY47FUorbxm8ZlXrLoSGY7dL72aWovRQwxvuViqp09KF0WchAke6mxfrOHSqv2LlIEAZc4hYhUkkiyBUlUAiPoayPuvsfkw3/O60ykiVhVwBIwJIzuRUIwdaOP8emvcnZgoqSHiCh1/censvqca1ThVobwK1yne4HIbGaegBFcN08s97ScclKDcmagzlXCxPcjj5Ew4qQXVKRtKS8LXPEKw5LHJU0ZGui9Y8tlX7xP86c5wTAsffr8IfTzeLCYsUPdtpZdsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by BR0PR08MB801654.eurprd08.prod.outlook.com
 (2603:10a6:2c8:2a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 16:29:27 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 16:29:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/9] block/commit: batch block-status queries
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 John Snow <jsnow@redhat.com>, 
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20260914145250.2792879-4-den@openvz.org>
References: <20260914145250.2792879-1-den@openvz.org>
 <20260914145250.2792879-4-den@openvz.org>
Date: Wed, 16 Sep 2026 19:29:16 +0300
Message-Id: <178957615604.653083.4057357915476268489.b4-review@b4>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIVP296CA0098.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35b::7) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|BR0PR08MB801654:EE_
X-MS-Office365-Filtering-Correlation-Id: c303593f-8044-43de-516e-08df140facdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|52116014|1800799024|366016|10067099003|56012099006|5023799004|4143699003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: EqYV8F+tWQgqlmDPfgymhUixWWctSHh3nquEGDE88IlBJN197kbiEC2z+8GvaR9ri0oBsCrNW8cwT45UrBKi/f4RTSavmYhN7qSD7ufY0MnVIcVw5mkGCkMj4UWAeDl8MGm0sxRZ/MMhRLUQXmTyQvvPWNs/E+qoGyS5x14CLSXgyZ+Ti2CyadomFDVHb5M90m+BofeitoP/VtAafr4TiWrIjtF8xI4N3bewyU4sfIVXIR2z2GxtD0ANpJtL8r0q6aMhuAck32ZI3334+F+FqiwgSkzy9sBsyKxs587v2HdpDFt5sjNR5StWAaS+pIqW/DtBowt6kuP24sqCBzWbqgl4dcjPVS2d2HpAKexUrBn+D1C6Wcap0HxReKbOHdfRBhtqqLTDE69T6oxDJ7R2q9tCbqvvUiv9v4ULh/cUgz228Wrz6iBvX6DJZQ24DcFsC26gPP+y/jCyfmneaPDzsP8br/K23/5rB8Xb0d+e48dNiiaMJvl5nUGtvLVrzmTgZAyh09Si8BeMOI6mgrDZ25sEiUg5kMhCGanNGVdL/2K9jsRkR4+0+gwXHZYahO1XGke//hoZDk7gfpB1InWY3qIMeXzWYOAnH3EMbMw/dy8gf1DiQQWzhp/jk/cLMCTWhAqw888V3CqW4DgmSkPhiCE1nxLtxWH/hCJSrYz0RgUxb2+Ur+xR+Ln6TcjLYpu2QoTBCSsShGBgBldIZNZps/NJamWjJfrJ4WnSb2KMOyg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(52116014)(1800799024)(366016)(10067099003)(56012099006)(5023799004)(4143699003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1RiVGYyOEx0a285YmZOWTAyRlJGbjBDMXBqUjZlYjZIeGkrT01oMXNnNW5v?=
 =?utf-8?B?MEpWWUxjNEVLTG84U1QxdnpoTy8rOW0vMzFNVmkxR0RPNlM3RHBKMjV3Rmpa?=
 =?utf-8?B?TWZFaTNVaktPeitoMVZCMytCRHU0bDhIc1AwcVlQYTlEV1M0ekdwMm5XRzJX?=
 =?utf-8?B?amNTSTRJZ0szZHpKaGw2ay80NFdtaUsxVW43VHFrOFoyUzh4VGszMUhRRW1z?=
 =?utf-8?B?cE1qUkViUGlqVEdwbnNFVVI1OGZVZW40akwxUTE2dVR6TTF5Um9oRVp1UGl1?=
 =?utf-8?B?QUVUd1B3NnIvWDBUeU5HcDNSQVBCWDBsUWxxc0RUanl3RHJUcW4vblNMU3lU?=
 =?utf-8?B?SXZiOGNzdkQ4TVhpQUJRMFpCVFFGRWhuNERKbGdoQW5BKzU3RGR2YmljYVJp?=
 =?utf-8?B?YUdtWHU3V1hpZTZCelJudGFIY1RWRkhtTXlhS3hPOXZXQjFDcE10MzlJRTNz?=
 =?utf-8?B?bDBaeEpwcDRQM2owUGZOa0dTMG9YaHhmS0wvV2JwdDJtaXJFTVZneG4rWEM3?=
 =?utf-8?B?N2swd1MvNHk1akppYXNOcEN5cks5QVVwSGQ4L2dGc016UHZsa1B6UXRYbjBU?=
 =?utf-8?B?TWVCa3NtbXBNYXkyRm5RY09ObFdpVWxQZ090a0R5MVA1NDdlY0FrWWJDVS84?=
 =?utf-8?B?ZGVVWU50YWZDdDd0WXVrZzczckhWYVI1a1piTHNEMWZjZTladjUraE9nMDVD?=
 =?utf-8?B?MDNnWE1qUFZ5UkFKU3dVL25YYWJWTFNROFlWdHBYVkNJVFpwY0hTS3NMMWpX?=
 =?utf-8?B?WUhHV3A0bFlXVlBuYk1FcTZ4WUtGNFFma1FMU3dvL253VDA4NlZzUktubnRT?=
 =?utf-8?B?M2lZbjZSQkpxamZqMWQwNy9OUjAyRUpXcXI3QnN6YU14WkJYaVNXVFRVZGo4?=
 =?utf-8?B?QmlSZHZ3UkxGOEZxcFA5VnFkZmJYYk45d3MzSzNrS3JSdU1yYW1uRHJhSk9V?=
 =?utf-8?B?WWJLT2tOUzJVNll1T2JhQklUdFpSVHVoelVUYlZyWHE3S0VRWTRrd0ZmUUtw?=
 =?utf-8?B?Y29FWnpEVjB5UEowN25ZTzJFTmlJYVFCOStJem1PQnY0Z3pzM1d2V0ZOSWVF?=
 =?utf-8?B?SjBOUTNOYWVUVjdJTG5pQW1DeXlqUXdoc0ZRNU02NThaMlpQd2dOd0p2WGtQ?=
 =?utf-8?B?US9TWkZuUUd5d3hOVmFHQklXZFdWdDFXVnBNSmFUdzVaMVBnbG1qdENpRllU?=
 =?utf-8?B?VzBGTzViNGxVZ2RZRk84d3lsbnF0Ylg2aU1SNFRIVHZjVHMyK1pqYWU0MGo0?=
 =?utf-8?B?VjBNQm9Nb0hvbllualV3RG9pWlNhSDlPMHBCcXhlZG9Wbk9FTno2dmxvM0w5?=
 =?utf-8?B?eVIzQmUrWjVmYjJnZEt4UHFydFc3eTBIL3RHdGFmVTNHeUs5ME9MenJoV2tk?=
 =?utf-8?B?NUFXYmhaL2hDWHd2OW52VURSeUJwMEk1V1B1dys2MWVSeGxsSWljZ1pPUDEx?=
 =?utf-8?B?cmxUaG1pdWdHTmZ4OVZudWxtd2c5M211M1RwOEw3eXErWWFFL3l5NkVPaFRi?=
 =?utf-8?B?OGJ0aktFZGJzYzhwNXFIR1hSVVdzK1o5YU43S0NGNUE0NkpZTGczSlJ4T0sv?=
 =?utf-8?B?TGVCRDc2Z1N0c0JsTWFXK2p1NXVpTmUrTW9jZWpTdkx2NEhCM0hHeDlaRk1I?=
 =?utf-8?B?UVdWdkpKOE9XOGQ1N3JhbWp2cmgwQkxSYmN5bjBnV0NhZTdpcHRnNklIeFpP?=
 =?utf-8?B?TmVLU09uUmpKMnJnc3N0c0x4NGsyUDZRVE1MYWM3RFpEWmFnRE1KMUg3cUdv?=
 =?utf-8?B?NzVudWlTWitkemNydVBSRzcvTXc2LzRnalhHOW5rbmFEWEZKeWU3VVliTVVI?=
 =?utf-8?B?ME9NWWcxeU9ROUQ0Wm4xNWRkU1ppOUYybVM1UGhtNzZ5MVZWWWQyRCs3S21a?=
 =?utf-8?B?UEtxM09GdmhRUkxYTVRiL1dya2J1OEd5dWVNSzR6dC84ZUV3NUExRzFzMXo2?=
 =?utf-8?B?bWF6OU9HTWxKUTZGb3pMR0RwSzJIdExjWTZuNG04Z1FEZnZkaWp1UVFPK09m?=
 =?utf-8?B?aWdRY09SWVErNTR6QnJPdHpnaVJhUFFwWktmS21RbDlCak5xNjBURFlxdUNH?=
 =?utf-8?B?U3UwRm9QRWpyREIwM0x6QUJTUkZmNTJwcFZ6SFhZa2ZWeGE1ek9Hb0ZrZWt0?=
 =?utf-8?B?TWIrTHcxTDJWWmhUbktWZ2FvSVJ6b2UxT1N5dCtLWnY0aDRtU1VSUlErTmVv?=
 =?utf-8?B?MTFTK0JoSXBVTFRaK0ZXTVhDUTg2emhKaWN3MnozV3JXZzRwandMTlpRQk53?=
 =?utf-8?B?RHhqTms5N2F5eW15UjVmb2RqYmNDbWNPdkg4YnA4SVB6MTIvOTVvZ0xoNkRY?=
 =?utf-8?B?OUNsZStNS0huY0xwNDQ1U1R1U0JseUxwVTB3Szhwb3NSVzVxUTNucU5pSm90?=
 =?utf-8?Q?H4M87LfoJKI66zHo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c303593f-8044-43de-516e-08df140facdf
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 16:29:26.9241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utTa4xQvlbNst/V3nDwFXnmPLzO7DEunM7SRE0pHj3kOdg/baSfyvU4kVd8sDgLvPLEGFMD+9qC2rsxpn81rurnIJVnr8Ycdr2o6OHkjK6M=
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

> commit_iteration() asks for block status COMMIT_BUFFER_SIZE (512K) at a
> time, so a long run above base pays one query per 512K for an answer
> the whole run shares.
> 
> Query the remainder of the image instead and keep the answer in a
> CommitStatus owned by commit_run(). Nothing can write top above
> base_overlay while the job runs: BLK_PERM_CONSISTENT_READ is shared
> only from filtered_base downwards, and the job writes below
> base_overlay.

Minor: IMO this permissions rationale is a bit obscure... IIUC actual
writers request WRITE|CONSISTENT_READ, and since we can't withhold
WRITE as we have to write to the base, we trick the potential writer by
withholding CONSISTENT_READ.  Might be worth explaining here.

Anyways, with or without:
Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

-- 
Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

