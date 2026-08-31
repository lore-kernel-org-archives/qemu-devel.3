Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF07C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 11:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x10LW-0008P5-OZ; Mon, 31 Aug 2026 07:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x10LP-0008OG-82
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:38:32 -0400
Received: from mail-westeuropeazon11020090.outbound.protection.outlook.com
 ([52.101.69.90] helo=AM0PR83CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>) id 1x10LJ-00074m-SZ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 07:38:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gF72YZve/H0HcYEP666lnrxaRBv2BEfEomq1P/bg80NWVSdb2CJ/HJlz4QM+HMrmmOHq2t6tyl7l6gNhWd7xfSYz7dSZrDKN57UT9u6GdqeE7CdfZurpm9PqRCuRr/V4pS3h8N0FdmWZAZQXwwXbYWnkLY9pshNSteaqPwbPrwct1jdi0X7F0b1Q1vplKxb8wXr2OpIc8J0TENznySRzXn2yczNAHE6ECA5ry+EkO4XYs889rTX2kCtWfreo5qoa0Qpzz5kleiM3B4AIFoHijdNopsBw3oQ4Vd0ZDOGfNNvDFKPji4fdPRubcZsHV1mZL3FDBfmnn/3PTgrqVyo7Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9prJNVfhF3S+mt6p9mTcmtZkqn7gsHeIBYjWTMS5ds=;
 b=o3xPYFDm8Yrr8Mp1L09AG5GM7tlQ6gI3GHZ+j4LRkbsUaIdQ2r5iJ4Zj3zKtjaCMhnwK+PdlieHoYh1GjAlxArIW+8WJHTwF5ebLVNc52FvzR1/TR7WkGLdu8wEwT/UigfAn5dFbN4P2dM7QVT6hFOfxSGt0eHM3V7bmnc9SiCAZzjKIDdbQvFEQEb9OBzIBj7/HXzvdFQn2LuSOneItJ8WRphlbpgXQ7tjt9+sk9BEHb6xVIM99vrGDaHv5dFkxq2k1MQQPsFp5ZvJeIG+BDyHNTLEjBc74262wN5cm/7epdQiygUOahKLB4iEpyQ22rzKhvGA6R5I4ESXDf1LOOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9prJNVfhF3S+mt6p9mTcmtZkqn7gsHeIBYjWTMS5ds=;
 b=NxA39+x/xJXiqPRiap36SVfoRX30PbkzN/nQbK6CSf919sW+3uX56D8VUxYTC6T0IW+npNG+n3K+Wq/wy5F8T9nmGl03Tmula+QVOFCDsvU704R5BxxdXKZmu0+h8ZrlB552Fh+bOLUHzfB9Gs4gNklOx90Gm/MB9pxscOhm5uuSg2uZi7wsRdcLIfWipWD3evztRs0t5RXSI3FTEH3H+uDNSOZxD844MWJcbaNR72c32JCbo9mAllb3Vm6WotKkJ85Z0r0uHHAJk+bdiTKoHSggXwSYdbW/LQyD228jrMnqvGKBVOCitre5XIP8KwbX31Xzeiah65eI11LlCQnZXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by GV2PR08MB8391.eurprd08.prod.outlook.com (2603:10a6:150:ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 11:33:16 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 11:33:15 +0000
Message-ID: <41cebb76-bc3c-4f69-82b3-7517122ab2e5@virtuozzo.com>
Date: Mon, 31 Aug 2026 13:33:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] io/channel-websock: fix an unauthenticated crash in
 the handshake
To: marcandre.lureau@redhat.com, "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260831100151.914178-1-den@openvz.org>
 <178817576852.2700790.2039576285438786814.b4-review@b4>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <178817576852.2700790.2039576285438786814.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VIUP296CA0142.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34c::9) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|GV2PR08MB8391:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f7a016-da3b-4cf9-ce92-08df0753a5fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|23010399003|10067099003|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dx4muGNA77G98OS1Vg2koMDGBZ8yS03NXQbMXWcsmjir+nDRQFF6EUItED5bEMzrEpixyRanKZOk6fRI6gThj0wUxFkWsikTxubUcxT8LvsrVJgxotYZGN0OHB3CDatwiOtiBALzPLYP9hauLa6IVluHtaAhFcqrnmxbFHkZJUedGRfKWdseD7+F53xYdHQdXvWuPT/zx/JMBrXBO7GYQP3YHUeXPfd5AkvfchmJeYfJKrsA3Ck+z8TIVmmuNCrW/tjgpW97AeFHr97JevNFyaTTQnZ7bi4HW0gBih7zUFbyA3LAhOar21vxDXInQdEt1sE+/PtE7UVh5mX3MuSyT2pHLuYes1ZXztVzfSJ53+lBHfiC7yuRr41BK9OgaGNSdyHM7XkWs6aIg2bgM/yga9qRrnFHiJaKTq96BSwyUeIqFExe555P7/ziBXySNngAvHrhFGRvlq/sVZFn4YEAxpiezywMlrpsTTbO+v68g7rddF1H1S+dSPKBSigR4H3GGADOYFH/9LJ/45DlM38VINs46gxHf3ay6UByyZLhA28XDHujf4+NDkMMwntch1AMre2KZ5Ci+I6x4yUu4eiAWm2yCx3jiJqs52D/umx4sxQOrJfv4hP+SO/qm58Z0gbYipr//ASIqO5F6idsZ/1x/2nxzXXlb63wqYZBYA49WnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUJEaHltVWdVVysvMUdJTkZ4QllxeXBhMjRwa0JPYUxhSWc4V2JLMlBEeHh3?=
 =?utf-8?B?QmpMSkJEQVRNT3RzQ2kvcm9MTEFEYmZkblVSeDNMbWpZWmZrdkg0SWI3L3dC?=
 =?utf-8?B?bFN5UndCZWkrZmRNZVVGTTlqT0NiN25kZTl4SGswcGJkTkU4Y2VjTENlQnJk?=
 =?utf-8?B?NmNGeGVvRFdkN0JxYTBEMjZWeGd3SnJ3alYwbGlBbWxxWkZCWTc1QWEyQ3pZ?=
 =?utf-8?B?bE1qUW1CdWplL1YyL2VvK2NFcnRHdXlKQjMvSjl2TjhPTHI3L3c1RGhWcVZk?=
 =?utf-8?B?MGZHbFVkK0hReFl3dERUcE5LeVJyNjFZRU94ZUlYMVNlOC9GK05xQStHSTFw?=
 =?utf-8?B?d3NBZFFPc1IyZWN0VVFLU3VsQjlZclFTa09uVzZ6cUFHd2svU3VaenZnMDlL?=
 =?utf-8?B?OFpBcVVFakttZDZ1SElwTEhGUDhzbitnZUVkR3ZqLzErTENFUkNtY0NoNVY4?=
 =?utf-8?B?Z05WNktuc04zQ2NKV0taQ3NHTFk3R1haZzBuZVNTdEhVN2FCd1NLckZ2Vk92?=
 =?utf-8?B?K1haV25ad0p3N2NSbC8zTkg0UTlxMllTazhoQUFDbCswV2dkVlVCRkpybldV?=
 =?utf-8?B?NE5KUDNmSG94QXVMdGFzbDhxUXU3TXVsOWt2M1lWSlF5RXFKdi9YN09pbmVN?=
 =?utf-8?B?NW1JbzAyazM2Zm16KzhyZkhiRjB4UHUzS2dUVG4rTk9ObWNJOGloU1VmcEcx?=
 =?utf-8?B?OU9xTnFlbTRtM3ljYkJGdjVmTVdQTHFRV24zNjdHcGVUS2JQTVFnekMwbVZI?=
 =?utf-8?B?NnRWaXhNbHhOQVlEa1BRSTJGQUVGbnh5b05SOVcyTG83K1NSRElzWmVGMjVH?=
 =?utf-8?B?MnhtajhuT1lpc0VyaHl3dnB1NG53QkZWaXpncTJlVVY0aHJOQ1V0TGMxSUt5?=
 =?utf-8?B?TWVyNzlVeXlRcUp0YkFZQkI0Y29VbTYyUWI5ajhIYnpNdXoyMGFzV292ZlE5?=
 =?utf-8?B?Wk52ZFRjNllYaUZNdmRoRWcwSCs3YjlzOGlnT3A5SGd5OVZiYjl3OUwvTVpK?=
 =?utf-8?B?Mi9rVkhLRXhVaWFYbktubWIzVC9NYlpUSGVOdkx6alh4SW5RcXJsa0sydnFl?=
 =?utf-8?B?d1gzbGVsTEpxeHVxZzRhcUU4RmU3QmNEVmZBR2wwakFDNW9QUlRIZkQ4cytW?=
 =?utf-8?B?aDZHdG9GaER1dnpmMlVVZlhNeEtxV1hlZE0wamlJVFdhRDlPMmloSGNjOHMw?=
 =?utf-8?B?VUFFNnQrYUlNd2trVi9FQytvaGI4b2VoZS80QVVvQmtaYjZYOGFHbEZQMXYr?=
 =?utf-8?B?endCZStOdStMQm1GR1ZuMVNPRjlMc0lROERJbmplQmo2QzQ3WnhrZ3BPOTRV?=
 =?utf-8?B?enVJZWpnRVp0bUx3KzhkWDdZd3Z2cXIxYk1MdDh2aVJZZW85VWRWRHZBMGNE?=
 =?utf-8?B?ZWk1NU4xT3FTUE4yYWxPMExUT0ZmL2VoSG5zWGtYbnB2UFgwYS8zNnJsMlZY?=
 =?utf-8?B?V09NTWZySS8zeko3UW04QmU1eTlPUEtXcXMzZkNvSVFRWGIrS2VtVTA2b0xC?=
 =?utf-8?B?VFY2R2k1VmJoVXNndGl5NlZUY2w0Z0dFYksxRnVreFpiSTErQmpOMU5mSVR0?=
 =?utf-8?B?QzV4RU1oa0F1QTdPV1ZZVXFhcDBhL3NPS1BkaTlsV2d0WkkyUlhrM2k0T1VE?=
 =?utf-8?B?d21hV2NnSjQyRmlZOG1tQkNSUDZ5YXFHT2k2MHAwSkoxVGhsVVYyMEN2cDRB?=
 =?utf-8?B?VkxFKy9HUm5VNUhqSy9MU3FHQ2NEWk1qZVFoalJneXhtZmFNd0RYS3RMbitT?=
 =?utf-8?B?OUpHWmMxV3N5TVV3K3RxVFcyVjBrM1c0dDdJVFkraHAyejhTenFEMzNNNlZJ?=
 =?utf-8?B?U1hUY0NmbFBYaXR4RE4wLzZadmZpTmFkYTUwMzlUM1RINWdKbkNMSDQ4ZFdH?=
 =?utf-8?B?VWFuTkJBUnduVGQ3UXdWWGNRc1VWZ2lOOGpBSHQwaEV2akY1dWhnTWtDZ3Vm?=
 =?utf-8?B?RHBDR1h3ajlRR2JCUmlEdG16cXc3ditZWGFiMTdUMDNHZzY3SVkybEZKV3Iz?=
 =?utf-8?B?Q2JVTlZibklQZjZvYWdkdTNNM2FrVWxzVTFOLzFac1ZzYTNPWDZGSHRTYkti?=
 =?utf-8?B?aGZtcGVWSkRzOXovbWxBY0lPaUNUeVFleDVHRUJOWS81UVV0NDhmMXU5YkYw?=
 =?utf-8?B?bWtNK1Bwb0M0YnRGNkJOV21QTkx1NUUvK1p0aGZxVFFEb2ZBV0toRVRtRDZy?=
 =?utf-8?B?OWkrc2Rac25uRWQxRlVWcHBvUGlXN3dkQUtDMk16bTMrbzdxOEtuNUt5bVpV?=
 =?utf-8?B?bVphZU1Ebm9DTUM1STlyTFZNRUNqSE5hdEE0RXdFVzc4KytXOS9wcXZaQ3pt?=
 =?utf-8?B?Rzhka05zZDNYc3VLanRVbDJITlNNTU4xU1hxTXpnZ01yaEZaQVJmT3BCWHlE?=
 =?utf-8?Q?XiAAXFOD5hnmUIFkDtMz9DCsNBsKPOX8O8Jt1mTRfi2ck?=
X-MS-Exchange-AntiSpam-MessageData-1: qSUOU8LDSHFWDQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f7a016-da3b-4cf9-ce92-08df0753a5fb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:33:15.9342 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E06lZYSf+R0WSucOEOSKoIKkSuHx/QeeySkNbbG/AFN5GWLqVL4Tr8wW6j93LEcZ37bsS5PnNP8SnSKIPS5Ksg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8391
Received-SPF: pass client-ip=52.101.69.90; envelope-from=den@virtuozzo.com;
 helo=AM0PR83CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On 8/31/26 13:29, marcandre.lureau@redhat.com wrote:
>> A client which can reach a VNC websocket port crashes QEMU before it has
>> authenticated, by sending an HTTP greeting whose request line holds no
>> space:
>>
>>   printf 'stats\r\nx\r\n\r\n' | nc $host $port
>>
>> Three defects line up to produce it. The greeting is rejected without
>> queueing a response, so the handshake goes on to flush an empty buffer.
>> A zero length sendmsg() succeeds and returns 0, which
>> qio_channel_socket_writev() mistakes for failure and reports as
>> QIO_CHANNEL_ERR_BLOCK with errp left unset. The handshake treats every
>> negative return as fatal and hands that NULL Error to
>> error_get_pretty(). Patches 1 to 3 close the three links.
>>
>> Patch 5 is the same NULL Error on the read side of the handshake, where
>> ERR_BLOCK is folded into -1. It is reachable for a wss:// client, whose
>> master channel is then a TLS channel: a wakeup carrying only part of a
>> record makes gnutls report EAGAIN.
>>
>> The tests drive the handshake through a channel which reports ERR_BLOCK
>> on demand, covering both directions. No test reproduces the original
>> crash itself, which turns on a stale errno and is not reliably
>> reproducible in a unit test. What they pin is that a 400 is emitted and
>> that ERR_BLOCK no longer reaches error_get_pretty().
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Daniel P. Berrangé <berrange@redhat.com>
>> CC: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Denis V. Lunev (6):
>>   io/channel-socket: do not treat a zero length write as an error
>>   io/channel-websock: send an HTTP 400 when the greeting has no space
>>   io/channel-websock: handle a blocked write during the handshake
>>   tests/unit: add websock handshake test
>>   io/channel-websock: do not lose QIO_CHANNEL_ERR_BLOCK while reading
>>   tests/unit: cover blocked IO during the websock handshake
>>
>>  io/channel-socket.c                  |   2 +-
>>  io/channel-websock.c                 |  10 +-
>>  tests/unit/meson.build               |   1 +
>>  tests/unit/test-io-channel-websock.c | 249 +++++++++++++++++++++++++++
>>  4 files changed, 260 insertions(+), 2 deletions(-)
>>  create mode 100644 tests/unit/test-io-channel-websock.c
>>
> Patch series lgtm. You cc stable, why didn't you file a CVE?
>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>
I have calculated the scope and get around 6.2 which is
not looking too impressive to spend a time.

There are toooooo many CVEs circulating around :-)

If this is wrong approach - let me know. I'll change
the approach.

Thanks for review,
    Den

