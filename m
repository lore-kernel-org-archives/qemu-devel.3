Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F40EC44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1Gk-0003hp-Ls; Tue, 07 Jul 2026 04:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Gj-0003hX-2P; Tue, 07 Jul 2026 04:35:05 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1Gh-0007zQ-FV; Tue, 07 Jul 2026 04:35:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4uimB3NQ+PwQoreDAwwyGvNXWdhjPQ2lmQSywMoJeKATljEhpsNVojOAi0iE8iPEecHFm2+lDfuIzJRP08Lg7K76zfLiBY/3LTpQDWwuQcbKNDM9AiMgoLoW51HVJ/+1V7VdxHPh5PEf4Rhs47QnHky1k4RL+xeF0loxwvQ/wVoNVY8RPTjylutNNyBpRjjtzgvi5EHt3ipTxh4ff66Zf3aluoJX5xOBMXMWuB1sK6lQhaM97uz3Psqtzi90HHMrodm6RBjXy6H7+CTdDNLjMjOph1iZrV0z1jvXgwQAa9nLDmHPmL9Q0CDfCj7Bq2JQJ7RePyJnN+vONQXodZ/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4a0KNC06bqzTkdXHU0DNoer/ulh3oxOCCv0N/CHZ65A=;
 b=ZH02AA2Uxu3JTbpdAwdKE64sbbtppANvrjYvn9ooMUTrZCefCdjHIDAf9EuRuVVpmVukYDYpJUb0rBWV6w0R2k8zRONU38uvtdlEmk6Q9nWaJoBLVfNWPP73t6wSoirWP+u096wRke2KXe3ExXCWKHBQ/+qwe98u79btJJugl6hljcARkw1VGdA6rllMzU2ShKo0k04h8xLtN4OtwEjcg9CKSorWm2/e4CJPGhU4g4R52+OznyrGoePczJFaoGb9JnYGu+J50o8kfwdYIypYarrrNLBIY7c1bGuT61+FURpVGGK2mtHA1XgvkCvfzPmEByTdPRwUWwwR+Syf8LRtvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4a0KNC06bqzTkdXHU0DNoer/ulh3oxOCCv0N/CHZ65A=;
 b=Cyh8jSkkvcRDBo7Xq5KPGcnbiQR7ZH3KHs3VBnlolCY3C1e3Rxx24cZqUb+szB9IOngovJT+i4g15rjEcyF/VE9zKMUeMaPn6qoe/hB35Y5gwEOdHII+FzbP6GXqUm7hzGWbwiY8xeMTawoYc79rlxp6UdMGU3OBjd40TUu8m5o03oNW8YFiBYPc+XgKF8V/iGdJOHNYtOlT0tfC41ygvdqpPc7H+isVkP8mWbO+wEe1v+Db4dsPbl3xGD4wZn3um0E07k7M8wym82MDRcz0DlhW+GdFSYR8/F4T2X3TbqsuUlz2nx5oThj0uqEoEE1MNFXqDAxAWK/XVtLuMMxbxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by SEYPR02MB5558.apcprd02.prod.outlook.com (2603:1096:101:53::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 08:34:52 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:34:52 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 01/10] hw/block: m25p80: Fix dummy byte handling for
 Winbond flash
Date: Tue,  7 Jul 2026 16:34:20 +0800
Message-ID: <20260707083431.219671-2-bin.meng@processmission.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707083431.219671-1-bin.meng@processmission.com>
References: <20260707083431.219671-1-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SE2P216CA0106.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c4::6) To KL1PR02MB4977.apcprd02.prod.outlook.com
 (2603:1096:820:71::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|SEYPR02MB5558:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9a07fe-9f77-4e36-02b7-08dedc029d99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34096008|366016|376014|1800799024|23010399003|3023799007|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: FqnTj4V+zmMNoK1j9VeTjpXXmFovK9xRIR4GjBJvtJPe9b8SmYf6sQkp9oHzselkzqzThLKL01rZt0nakBYR72YQsVeHyqx/0pXiEW+SYLfgsCur6v0IdG/Upauc5ptBaROMgFwhoYA/XasOEVbY57eEpm8+Rf85XndOOyViqpKFmETXMO6XI5qqtFjgWKJgqSFYGnaE6TUi/5x3hf8lt06kNye5JNwLMempMGteuSKkh7xs/yfAexSMj7iG3XqTqCs9QcAlKi9KhybDW2Od417okFMPWHBjIrdeImdhrx6Xajk9Qf0KPhsmwPSqGFCwk1JuLXqA4JJ1lT/r8d0ya0n5qDYzwFc3lm4w08g1O4o2c2+aebUf640SzaDaUmWUsr616CdOcDCIkd9wZ1v8ajSLRfP+vgIkCEvavJfrI5W7qgAtwnJL1EibkvsFaBVMWgghM7c/abzfz0co2r8Z/mYnIyx2TSu1N4UJwACzMEPewSQbmJunOPTt0EeqiKpxL6IxoiP2wHxG0ewfrK56/kUSEW6afZrWolwO9OYeS61nfxyukcUZqn8djM+TesvP/owN61MO9B2UcPVQiMckl0gOTcAh/3dfHQA1TQr9A5DwvKOjMXwGA1KCc3zwo2s0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(34096008)(366016)(376014)(1800799024)(23010399003)(3023799007)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alZ0MnFCeFE1ZTBOUzJSRWFoZHNJWjFiS1FHQ3ZON0lMdGthUlNUWnBUSzR4?=
 =?utf-8?B?Yk9JMlRza0VHeTBjaDVzWE82U3o3RktLdmpCTDd6S09DYVk2ZkFLZ2NLWGFP?=
 =?utf-8?B?TEpHTk1sOU85R0hDMlNFb2hZSGUxV01zMVBBU1loYXhqZld3QU9Ob1RSL3A1?=
 =?utf-8?B?S0R0OHpIVUtXVVkwVjlKek8yT3NML3J2UmNHTFZMbzdQVzZ0ZDd3L2QwR01L?=
 =?utf-8?B?R0VtSFYwZWdieHlmN1RMV3BqQml4cFdBb1gzZDVMam16OEJPR2FjTmFQcm9Z?=
 =?utf-8?B?Z3NEZW1LOFV1Qmtsd09EaUU4VFJNZlh6MS9GWkJMWlBLMERmK0NuTzQ2RE9y?=
 =?utf-8?B?R0w5VXlSSERaUTlJMGR5Ri9KK2ZzTTZ5RGs2Mk9TZ3R4Y3ZYUXlpTVFFWjN5?=
 =?utf-8?B?Y3JDR3ZoaVpTYXBxVlFiaFpvU21WVjFLaGwzbmd2eXppZE5Ja1YrVlpWdm9T?=
 =?utf-8?B?QlhVLy9MYktmeEZhSHkrYzdZaU5SajA5UTBPTGFueXhmR3B5dVErTTVrSHRn?=
 =?utf-8?B?enhhamFMRkVhalQ4RFBLTUdYT0Z4QWlzUnh1VWI5ZS9Tbitib29sdEhOUmZF?=
 =?utf-8?B?cUhGS2V0VjBOZFNITnJVa3ViUyt4VlM4aXQ3dTRrVCtVLzlkT292Wk5lc2JF?=
 =?utf-8?B?Wm5idXk0R1JpTDk0b0lwTkc4RTg2dkdXblhCMVduNEFzSVpOaUN1QXRmeUpO?=
 =?utf-8?B?OE81a0Z3RCtRcWpMUzNjSHdwV0hxYWlPaDdGTy9hSU1ER0F3MFNqbVNWL013?=
 =?utf-8?B?V1NmNFlUMzRwVENoYUtlV0pkYzhYR1JudlA2aFVFY1FtSDJWOGxNWkV4RERj?=
 =?utf-8?B?RVROYXd2dnAyRUg1Ym44WUcvbElYdW5NbEpvdzFBZDdoUGpUbnVrZGRGWlRw?=
 =?utf-8?B?VkQ0MVZDVHNsVjVNQW0zdnd3SWhEaFMrUjJ2c1g2eVF2cVZvOUh2TW96S21l?=
 =?utf-8?B?WWtqRm9XdWEzdVZueTNpQXI4b2RINzl2ZWNncWlqMkd6QnQ4MkEyeURUc1hw?=
 =?utf-8?B?N3hYTW1QL2labHpUdU9IK3hCWnVZMk1USGhpMHNNN0puNDF0bnhpc2wzTWlv?=
 =?utf-8?B?SjlyTys5ZE5xZldWZmdSUUhHc0xxamxnalpKV0RIbXNFK1BnRVdWcmUzWHph?=
 =?utf-8?B?TllRSkJSVE83RlkycDArSm43dVZrMmtoTVZ0QjFwUjIzZitUV3lyUjJLTXBY?=
 =?utf-8?B?VUR6c1lTSE93OHJmNTl4RHBKN2NOVW80YWlpdkdCdWc2dkdMU0d2V2lKWXZu?=
 =?utf-8?B?UzJJQ3ZzNk9MWVIwSEl3MC93eStuTjU1Ullib1ZiOFRZdVlIVllpVEJKYUFP?=
 =?utf-8?B?ZEVVM1dWaWw5dUE1VkRaTW9QdktadU9hR0UrK0JXbW1XYUtFOW5Xa0JpeUVY?=
 =?utf-8?B?dG1CTVlJMU1sM0dMb0ZML3VvVGtQeitsQjZCa3R6NTZOb1A4aExoWVdHbmZ6?=
 =?utf-8?B?cVB2OXphTk5SM2RFejNrNm8wYVZBRCsrMUZNVC83elFiKzhxMnVxTjNIR1VI?=
 =?utf-8?B?bDE2d2lOWWdZNks4b3hDZjg1VVVyUE5KR0x6NUFoMENGeEJqWjBBRllaTi9K?=
 =?utf-8?B?bEV0WXRYQkczaXkzRzg4TWdoblloZzVDaFRVZ3pOenk4VUlsbTN2akdDRWN1?=
 =?utf-8?B?UTRmYnFBR3RVYXFsUndCckpUVFV3OEdxL1ZUSlZFS1RycG1CNk5BRVJPYjg4?=
 =?utf-8?B?c1RPT21NV0pLb0I0ZWxTYVhlWlZmcFpjVU93eVpGcExMUnN0Umxidi8yUFI1?=
 =?utf-8?B?QmY1eUdQUEZTMkRYV0NjTU9xSzN4ejh1UURhVEVRWFFTYlhkTGltUis2L0sx?=
 =?utf-8?B?QXpMVGdFWjk0dFg1WnplQVJ1a0FvdjcvZURianE0RTB3NVpKSUxGM0VJdnZP?=
 =?utf-8?B?NTAzY094TUcvMnBNTEJPS2ZHU200Y1RRbWNiQWE3VThWQjBBT3hNSC8vU25q?=
 =?utf-8?B?dXYwVHArakNZNGhpdU43UnJ6cWRRcWlBSVF0T3FsUU9NWnBMR0RrTUg2dlNs?=
 =?utf-8?B?Nnp5U080WHptWnphdHhpOFFNZkxmM0V3MWF2aXRUK2hPUGUwcUI1NzVDTkpZ?=
 =?utf-8?B?ajRScEJsbmc2SFJTdGY3dDYrYWh2NHFjV2ZXTXgyVGJvZnZFTU82amlPMmlG?=
 =?utf-8?B?ZjhrbkIxRitpNk84OStYTkEyK0cxVFFIS0xRbGRiZ2J3ZzR1bEdBWklydVFZ?=
 =?utf-8?B?MEZCZ0VSZUt3aTBmN3FzZWorTlp1TWpZRk5vUGprWEd0SktLQnFYZmJnV2dV?=
 =?utf-8?B?Y1BXMkt3bzV6YXlJdWt5dVVLUkZzanc2M1REZE4vZEVtWGljZmRPN20yWStz?=
 =?utf-8?B?aWZna1NZbWszUlhGSzYyS1Y5cVh5R29XOTBBVTZERlZza3dpL0p0SGk1bnN5?=
 =?utf-8?Q?i+MpjvTN97kbRVJc=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9a07fe-9f77-4e36-02b7-08dedc029d99
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:34:52.6279 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UqPD/6zZoN6pudDUKUyRFSsRe2m4dbyZKSASX5NVIOKAJriAVLTgZ1PdrkOg3GfN2pgenMGhVc0+btlqTkakRSzUtp6EPsZHI0HKokQmduw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB5558
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=bin.meng@processmission.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

The m25p80 model uses s->needed_bytes to track how many bytes a
controller must send after an opcode before the flash model can enter
the data phase. For address-bearing commands this includes the address
bytes. For fast-read commands it also includes the dummy phase.

The tricky part is that flash datasheets describe the dummy phase in
clock cycles, while the QEMU SSI interface advances the flash model one
transferred byte at a time. The dummy clock count therefore has to be
converted to the number of SSI bytes that the controller will actually
emit.

Some controllers have drivers that push these dummy bytes into a FIFO.
Other controllers are programmed with a dummy-cycle count and generate
the clocks themselves. The flash model still has to use the same byte
count that a FIFO-style controller or the Linux spi-mem layer would use,
otherwise the model waits too long and drops the first data bytes.

Let's fix the inconsistency from the flash side first. We start from an
easy one, the Winbond flashes.

Per the Windbond W25Q256JV datasheet [1] instruction set table
(chapter 8.1.2, 8.1.3, 8.1.4, 8.1.5), fix the wrong number of
dummy bytes needed for fast read commands.

[1] https://www.winbond.com/resource-files/w25q256jv%20spi%20revb%2009202016.pdf

Fixes: fe8477052831 ("m25p80: Fix QIOR/DIOR handling for Winbond")
Fixes: 3830c7a460b8 ("m25p80: Fix WINBOND fast read command handling")
Fixes: cf6f1efe0b57 ("m25p80: Fast read commands family changes")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Cédric Le Goater <clg@redhat.com>

---

Changes in v2:
- correct the typo in the commit message: instrunction => instruction

 hw/block/m25p80.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 4a4cda6602..59ecb32c0a 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1004,7 +1004,7 @@ static void decode_fast_read_cmd(Flash *s)
         s->needed_bytes += 1;
         break;
     case MAN_WINBOND:
-        s->needed_bytes += 8;
+        s->needed_bytes += 1;
         break;
     case MAN_NUMONYX:
         s->needed_bytes += numonyx_extract_cfg_num_dummies(s);
@@ -1099,7 +1099,7 @@ static void decode_qio_read_cmd(Flash *s)
     switch (get_man(s)) {
     case MAN_WINBOND:
         s->needed_bytes += WINBOND_CONTINUOUS_READ_MODE_CMD_LEN;
-        s->needed_bytes += 4;
+        s->needed_bytes += 2;
         break;
     case MAN_SPANSION:
         s->needed_bytes += SPANSION_CONTINUOUS_READ_MODE_CMD_LEN;
-- 
2.53.0


