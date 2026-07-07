Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A96C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 08:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1H8-00045o-8D; Tue, 07 Jul 2026 04:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1H4-0003wz-FV
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:35:26 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bin.meng@processmission.com>)
 id 1wh1H0-0008Pe-NK
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 04:35:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhMwSajFC+cMxE1InYp6krmpUD/pEbq8naeYpY6F8L+OgYwnH1LaVbtKh3+YzrvOhhodLQ23AA2XxQrGg5U70vSRjVVL6YbO3ScdXmy/R43fi84T2YydkAPXGpStH6SbPvc2dF1SwmLbE2SUEQcPeiFD3p59avwg6etqygeTnM0odoY5NZpAGODGoSa1OhBodklJ5Llin2H01PTdoaQHnteG90w1m2iQbcS75X49nFvXXMMiRwXwsMXMLR/hLT1acv/6FILJMW2Uhmp+gE0Dzr/B0IgBWjXvHHQd7fYSaAbm18WHdt6GGUpyT9377ugklHU/Cz+HImyjk4dLhOgHrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86KgJ2qKJCxRSWCvwXT1qg8FQtRX7fmRFjYj1NIiPdE=;
 b=nY6nms0bmbdosNS/SY4u5DCaaAhjLr9jEPuSpGFxR5jMMb0gzQauUa+htFGGOgSWie9Rx6L0lgnMH1hTNFDMT2ki9JP8irHXkpv/2AsT5RTB5OXnlnO0mNbNT6PDp8WnDq6TperQLjeEi2ivi9vLIs8QEqOgCCMsXFkNrwVfxcBIMAJlUA0iGqZCN3uJyTGjSCS3nP0D7XMlmXMvoNFMhXT0JvUqQNJFq9wUtz4VO3oSAg01+KBZpaVGTrxIGrrDTwR2p7bXJS4vwdQ3ZkKWEuu5H/vB2sF3QsrIljCWQVSsfl+X2PLyMRWO8uxdbmEmvkHq1pd705ViiOJx489ECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86KgJ2qKJCxRSWCvwXT1qg8FQtRX7fmRFjYj1NIiPdE=;
 b=nPfIA51azPylMm4Lbvtg5LB8agTnBzhkYDseDS4zUewltSBVhrr6qCjlA9CeJNYbrVFAeCgJ6JnNeOTflR5C7RcEbFqQoKfHW2bZvpsMiZswEEuI9R+4+WiIE82/ln/8g4G7VYcA4bUpsdGkUyZ/BPcwaC6wMYv6AjLSIv6F8vSDtC8UOSR9sYLS4uB0+kbnXCddKxh6IfCjlgi8QCsd/xWYdjEa9P96jezNI/ijMzbflZfKF5kKHODZvOHboWjMXA8jQMO2xrJ0GUMOwOFWO6fn2kKksareUOsa9MrYRlFwQpkew18uCaiAg/vWRXK0nAF4ZqoCpau+zxo6q0Q1BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com (2603:1096:820:71::8)
 by TY1PPF1A8DB1DA4.apcprd02.prod.outlook.com (2603:1096:408::94b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:35:15 +0000
Received: from KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03]) by KL1PR02MB4977.apcprd02.prod.outlook.com
 ([fe80::9fdf:2557:8351:6c03%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:35:15 +0000
From: Bin Meng <bin.meng@processmission.com>
To: QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 10/10] docs/devel: Document SSI dummy-cycle ownership
Date: Tue,  7 Jul 2026 16:34:29 +0800
Message-ID: <20260707083431.219671-11-bin.meng@processmission.com>
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
X-MS-TrafficTypeDiagnostic: KL1PR02MB4977:EE_|TY1PPF1A8DB1DA4:EE_
X-MS-Office365-Filtering-Correlation-Id: de06abe0-490b-4ff2-e1e8-08dedc02ab0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|34096008|376014|1800799024|23010399003|6133799003|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hwoaNDyp9mnnyzB8F7qFGS5QE3EZ0PS2WncheeT4dzGAp+zUiLliO8qByx21Lf7J6XO1Q6HZhIRTgvDqR4Dwzjvov6Pb6bDcAAgYQ/DHHjeptj3/+woc5RX2I8A5yVjzjApbdDIVc1SZCepN1vY/v6P1E4hPVc/jYRcgLSmQi4aYLwOTyhr2f9temgl2yuzTam+aNUUocgfOwmBi6dPVXnkcaX5MVVKZvW9UmwF9JdxkPphUTxdARNIzeXuCtwt69e8lN6W7URkXwz86O724EkDAn4bpbRTnUkQPWrhWJIOuLgn1wSVputdvA5eQw519cmVbopg5IAefiISymkuVNch4GJiDzsb+V+ix3EqUfXeNDQvl0+baItmRwVTFCzcfXpPY31uhtZQ2UOLRKBcAbIVigtzyfmIPl7b9bR8nfZ5NCcs4+0kCFwQnx4jnUw7CYLtkpfJXrEoSQbD6HgcCNg9pwdKXEwtGuUWaK+wbCqcmapXcQpm+v2BoAACRP9CCwTJTDCRhWTo4QgAuWw8CfXfrqyCmsSJTvpt7NXUMBv3HtWsIhi17h33ZMm7MLmWUNNw+mTknJw7mSu+WR31zH0FIgd43rCnhkcqJVngNhL16xULiR4a/mQhLQ7+8gEtIKV/LYyx4WI0V/jhYrRmkJ/9zSKHRNeUsgtjzH4rAWKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR02MB4977.apcprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(34096008)(376014)(1800799024)(23010399003)(6133799003)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEtDL2ZWR053NE5rZjE5RWdmUHI3WjlyU09UbFRESVJVRGp2eC9oNEZ4SXpE?=
 =?utf-8?B?SjNham1MdzhCRWFGV3ZQTlFFbXZSMzlUd0krcWZwZWxmTjNnb1Yxd1ROVTBC?=
 =?utf-8?B?R2grcVl6U1ZDWTVZWkNqNFU5Ti90aU9iQ2hUUjU5NURVdndPVzlBWSs0Nllh?=
 =?utf-8?B?cEM2TFdSWFF4TG1uSUNKb2d2MC9KZWxGamJUTnpMcXFQUFhpNlVwUC9DU2JZ?=
 =?utf-8?B?eExYRkZQaTBDTEw1REpNLzJGNVBaRDFucklvOXRWMkFLeG9rRlNRaXpRSmhq?=
 =?utf-8?B?M096Rit2cUxuRk9pOWJ3bVJTV01JZC90ZzVxak05WkRqL3kwTXQ2TFoyL3Vr?=
 =?utf-8?B?QWZ4MmVhZXNMWXR5YTlDUmZlM1ZFVk9LZ2pTb0w1OUVFK29jTUd1UWxld2RT?=
 =?utf-8?B?bjdRNEZlcUpSdzZ5KzR6WnNwcmFuM1kzRjhRWUNrbm9OcjAxMkNKaEN1eGJZ?=
 =?utf-8?B?RGlFd3hkZjhLbFdhL1dVbGc3bGZJOWpmQlY4cFFSKzI4YnJRazRPdGxQZ2RB?=
 =?utf-8?B?ekVURkNCUUZWN2Z5aGRPaEJEdkhZcHZBeVVmdE5YQVhrSlh0VEwySVo3QTJR?=
 =?utf-8?B?YVpZMTFXajhJWThPZDl1S1JEQkdNSmt0U1BFSGpndXk5VzhhRFBNRTNYQnQ5?=
 =?utf-8?B?OVBYNlhzdWFjYzdsb21QUHlEc1AzbVg1MkVDeDdCT3UxOHF2Ym52bGZGRDg3?=
 =?utf-8?B?VWpLYzZUVnZqZEVxMmhDU0tJUzZXa2I4RkVtNUdMSEVpcHNQaHkzRjl0aTFs?=
 =?utf-8?B?TEw5RCtUL0x0bnJjVGhQZG5KWmgzL1dFY3QvcFAzd1RUcFdlVVRsZzBVTUlH?=
 =?utf-8?B?dC9JdzBQUHFUeEVKdjlOUmk4SzlvSytNMG9JbzJ6QktId2lXeUlpMWNWcTUy?=
 =?utf-8?B?cVErUVdTbkd4NjFjbzdkVlZKQjZXVWhiMThnOEJqSUlWaW5wZzZuNk45Tlht?=
 =?utf-8?B?WVdSalREYkpLRDNrVXFUL0IzNmlGd1JrYkdjVmdheHMxRnRTNkU4Qk5tV1Q2?=
 =?utf-8?B?QXZ6Vk5TN2x0eDhZMGVuNFpQam1KSXBDRitvVWFpUExFRWNVVTB5UzdXS0x4?=
 =?utf-8?B?emVGQWFYaVMzWTl1V0tlVXpacHJPR0puL2ZYbjBoZWFHNDh1QjlnOHJOeXM1?=
 =?utf-8?B?L2hjWlJGYW5BSkJkTTlmajUyTC9QcHBtT3VDcFJJK0pqM3R5RFowN1ZGdXh6?=
 =?utf-8?B?YzRtdzZCTFQrWmFKUktad2ZCOHU1d1ZuQ0F3U3QwUE92V3hsZUNIamx6VVJs?=
 =?utf-8?B?YVJicWF4NUt5eXRhTUtSWlJ3Z0lYN24yQWJtcEVNUWU5TDdBaldEc3FTb1Vp?=
 =?utf-8?B?VVhhMTd0UVdkcnEyL3phZjVabXNza2dqeHRaTWhxcjY0NUpHaTdPWGljU20v?=
 =?utf-8?B?aUFJR0FkQStnTUtMOG80SFhMRElObnZ4Z2E2emFKTVdwcHZSQ0VSeUVieVMr?=
 =?utf-8?B?TGo0SkRETnB1SmZ4RHN2bjY3Y2NkbHI2U2dTU2YySWVBQ0lzTlFNL2Jac3V5?=
 =?utf-8?B?VFQ0VFVBWGZhMmg2UjF1MDlNcnduUW9aN1dJbXp4bGNVY1lxSFZBc01EM3lQ?=
 =?utf-8?B?VXFyZ01sVlp5R1Jnb3dWamE4Zmp0aEJnUmppdnI0TXEwOWduSmR2S1Zkb2FO?=
 =?utf-8?B?OTl2alBkWVc1WTVrLzlrYVhrS1Q2eWdRRzBSRlhOamhpUkJHKzN5OG1hT0h5?=
 =?utf-8?B?ZDRMV1pRY1FUb0xRR3hzTlZtVWZ4K0xrSHNyNE9oc0g3YjhISmZSZzYwd2xl?=
 =?utf-8?B?bDkwS01XQm52d1p2NksyR0NOTkJ0WVY4K2UwdEQvd01ZY1NPR2YvYU1aamVw?=
 =?utf-8?B?ZzFac3BiTkdxcTEvVE9wT1hlVGRqMkF3S1lMQ3FVYUVsOWlXemsrMXcveW1v?=
 =?utf-8?B?YkhjWVVjN0VJdGxGQURKcWdpM1dSZWlKeXRsYnJpbmtRa1NpVFRlQ1I0cmMy?=
 =?utf-8?B?dEpya0kzMkpiQitlVzJsald1VEd0U1FRVXZReWhtK1VKaVk0WldwOWFhT2Vt?=
 =?utf-8?B?SGxmOEtKR2w3UXBTNysyT0NFeGRUSVptb2xPQ0ZhYktodHVZa0xJKzAwQk5M?=
 =?utf-8?B?bHlQRlZIeWtwTC9VVlJpOHpxSnV6RUcvY2R3NUVNWCtOWExVaEk1a1ZYeDMv?=
 =?utf-8?B?dVR6R1pTb1JtVW80MFMxK0h2bm4vcGl0ZUF5S1l2Q0Y1aXYvZ1BDMThRSmtM?=
 =?utf-8?B?bGNRUi9NbU13SnlldHpzSXo4Q1NBalBVZytzZTNtUkRONkdPWWtUeUV6bWlS?=
 =?utf-8?B?WVNzRjBIaThORmtkMElPNC9nTzRHUEJMSkdtLzEvQmxWMWtyMzJDVGJKSkdv?=
 =?utf-8?B?RXNoMnJOWURqM29UWDlzbms4Q0s5dC9sSFdnY3NjaTVBTzc0ZS9UdWR3TG5P?=
 =?utf-8?Q?PONTT00f4QRo2KFk=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de06abe0-490b-4ff2-e1e8-08dedc02ab0c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4977.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:35:15.1709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 92bFCWM7ESHF7UX7HRyRYohBujCqy9JAzdVgc+t4gStJZtZ5ygIN6UG1W6DcZLBc567A2BawdbaIpc+N+j6feWqIsN9MaiqyPYUwIcmfQww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF1A8DB1DA4
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=bin.meng@processmission.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Document the boundary between SPI/SSI controller models and SPI flash
models when representing fast-read dummy cycles. It explains that
flash models own command semantics, while controllers own
hardware-generated dummy transfers and cycle-to-byte conversion.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

---

(no changes since v1)

 docs/devel/index-internals.rst |   1 +
 docs/devel/ssi.rst             | 132 +++++++++++++++++++++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100644 docs/devel/ssi.rst

diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index b89bab9b30..a8f5e310df 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -20,6 +20,7 @@ Details about QEMU's various subsystems including how to add features to them.
    reset
    s390-cpu-topology
    s390-dasd-ipl
+   ssi
    tracing
    uefi-vars
    vfio-iommufd
diff --git a/docs/devel/ssi.rst b/docs/devel/ssi.rst
new file mode 100644
index 0000000000..864b5d9320
--- /dev/null
+++ b/docs/devel/ssi.rst
@@ -0,0 +1,132 @@
+================================
+SSI devices and SPI flash models
+================================
+
+QEMU's Synchronous Serial Interface (SSI) bus models the full-duplex transfer
+of words between a controller and one selected peripheral. Most SPI flash
+models, including ``m25p80``, are attached to controllers through this bus.
+
+This page documents the expected boundary between a controller model and a
+flash model for SPI fast-read dummy cycles. The boundary is important because
+many real controllers expose dummy-cycle configuration in registers, while the
+flash model observes only the byte stream delivered through ``ssi_transfer()``.
+
+SSI transfer granularity
+------------------------
+
+``ssi_transfer()`` transfers one SSI word. Flash models that implement common
+SPI NOR command streams usually consume one 8-bit word at a time:
+
+* command opcode;
+* address bytes;
+* optional mode or continuous-read bytes;
+* dummy bytes;
+* data bytes.
+
+The SSI core does not model individual clock edges or the number of active SPI
+data lines. If a real transaction has a dummy phase expressed in clock cycles,
+the device model that generates transfers on the SSI bus must represent that
+phase as a number of dummy byte transfers.
+
+Flash model responsibilities
+----------------------------
+
+A SPI flash model owns the command semantics for the flash device:
+
+* which opcodes are recognized;
+* how many address bytes are required;
+* whether a command has mode bytes;
+* how many dummy bytes must be consumed before data can be returned;
+* manufacturer-specific differences in fast-read command behavior.
+
+For the ``m25p80`` model, ``needed_bytes`` is a byte count. It must not store
+raw dummy cycles. When a flash datasheet describes the dummy phase in cycles,
+the flash model converts the cycles to bytes using the bus width used for the
+dummy phase::
+
+    dummy_bytes = DIV_ROUND_UP(dummy_cycles * dummy_bus_width, 8)
+
+For SPI NOR fast-read commands modeled by ``m25p80``, the dummy phase follows
+the address phase width. For example, output-only dual and quad read commands
+such as DOR and QOR use one line for command, address, and dummy phases, then
+use two or four lines only for the data phase. Dual I/O and Quad I/O commands
+such as DIOR and QIOR use the wider bus for both address and dummy phases.
+
+If the exact dummy phase cannot be represented as a whole number of SSI byte
+transfers, the model should round up and log the limitation instead of silently
+treating cycles as bytes.
+
+Controller model responsibilities
+---------------------------------
+
+A controller model owns the behavior of the controller hardware:
+
+* how guest-visible registers select command, address width, bus width, and
+  dummy-cycle count;
+* whether the guest supplies dummy bytes in a transmit FIFO;
+* whether the controller itself generates the dummy phase for a memory-mapped,
+  direct-read, or other automatic transfer mode;
+* how chip-select state changes around controller-generated transfers.
+
+When guest software writes dummy bytes into a transmit FIFO or manual transfer
+path, the controller should pass those bytes to ``ssi_transfer()`` like any
+other guest-provided byte. It should not add more dummy transfers on behalf of
+the flash.
+
+When hardware registers instruct the controller to generate a dummy phase, the
+controller must emit dummy byte transfers before data transfers reach the flash
+model. The controller should convert the configured cycle count using the bus
+width that the controller uses during the dummy phase. For example:
+
+* 8 dummy cycles on a single data line become 1 dummy byte;
+* 8 dummy cycles on two data lines become 2 dummy bytes;
+* 8 dummy cycles on four data lines become 4 dummy bytes.
+
+The controller should not duplicate flash-specific opcode tables merely to
+guess which commands need dummy cycles. In automatic modes the controller
+already has enough hardware configuration to know whether it must generate a
+dummy phase. In manual modes the guest-provided byte stream is authoritative.
+
+Avoiding double counting
+------------------------
+
+Exactly one side should generate each dummy byte transfer seen by the flash:
+
+* If the guest sends dummy bytes through the controller, the controller forwards
+  them and the flash consumes them.
+* If the guest programs a controller dummy-cycle register, the controller
+  converts those cycles to dummy byte transfers and the flash consumes them.
+* The flash may know that a command requires dummy bytes, but it does not create
+  transfers on the SSI bus.
+
+Do not implement controller-side snooping that watches manual-mode opcode
+streams and injects extra dummy transfers based on flash opcodes. That mixes
+flash command semantics into the controller and is fragile when flash models
+gain correct dummy-byte accounting.
+
+Examples in the tree
+--------------------
+
+The following models illustrate the boundary:
+
+* ``hw/block/m25p80.c`` keeps fast-read dummy requirements as byte counts in
+  ``needed_bytes``. Manufacturer-specific helpers convert datasheet dummy
+  cycles to the byte stream expected by the model.
+* ``hw/ssi/aspeed_smc.c`` generates dummy byte transfers for direct fast-read
+  mode from controller registers, but manual user-mode writes are forwarded as
+  guest-provided bytes.
+* ``hw/ssi/npcm7xx_fiu.c`` converts the direct-read dummy configuration to the
+  number of dummy byte transfers sent before reading data.
+
+Review checklist
+----------------
+
+When adding or changing a SPI flash controller or flash model, check:
+
+* Are dummy counts stored in byte units when they drive flash state machines?
+* If a hardware register stores cycles, is the conversion to bytes based on the
+  bus width of the dummy phase?
+* Are manual guest-provided dummy bytes forwarded without extra injection?
+* Are automatic controller-generated dummy phases modeled by the controller?
+* Is flash-specific opcode knowledge kept in the flash model rather than copied
+  into controller snooping paths?
-- 
2.53.0


