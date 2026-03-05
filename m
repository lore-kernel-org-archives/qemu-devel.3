Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74E1F30928
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy5bf-00045C-NG; Thu, 05 Mar 2026 05:06:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5bd-00044R-Ry
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:06:58 -0500
Received: from
 mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c213::5] helo=ZR1P278CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vy5bb-0007ST-5Y
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:06:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVov+nEbBXXpeILjYfhFBgeWRquXMhmuQASIAjkEMzkd2GAaTwGhpJGE+wrwDJTU1WSkpCVaz6JncwlT0xRXexu5rsl/bYvzVmlf+abtsKkncklb73CYkVgW1DikRDFYbh/kQioF1HgvqNrMcmI4OHwiiymotx1aQ0Xv1/0H3EKSDbT83Mh53d2lAkaxqxH2csqa9kWJzr1fQlw/muVsdsaTEgzO73sITA6vae4Nwu0soqyKsL34lcyfE1fc37we2pwRYgC9zy2KwSyAfmJuY2J+4SgWNAT7JzMeCwmkT+34EdBuaQg2r4niRBIYDQj4uWALenZfWIoakvmq0URbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Z/Lm0lXSmSM8Lyn6vk8UcCxEKVqA3qhgQe+ZedD6oA=;
 b=wfIoLr/IdwX/FwcoI8c7T9A1Wb1QmzOADTgy9izwhVnCEsvj7RR+Xd8g7Z3OqdcqVE5jCrHPJznZuKX+FON5hAiUJ9LwiQu79/Ox9tQS2oMJGOXBK0hhoFRWK9idNRUnZ7WN1JbFcx63nou5PwO4tc8LiNIW+v66XVFumi/Uk3HkudOObxxAvZAkaPbnKP5NRztk4JtBSAFXZBNP6EHbcfoPR30gBlDauWRv8DNE78Ix1nvQqrKFihshOzKluSywnvvLNQB8WUAsScd9eCmUaDzVfuUfCEQ6uvRg2oTxQ4cHYn3YbWvtQ3N7hQ9E+BvNugk4t4ZW8I+yz91siTJAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Z/Lm0lXSmSM8Lyn6vk8UcCxEKVqA3qhgQe+ZedD6oA=;
 b=laohhRHJCyQcFrVGX+vspukCTfOyhJhIvikNhhbzLK572DabfnODg9PiAjhVpYehsAonshmVwWGtvPMV3GDy5qgFsgPUNS4q+4hP2nklqqbNUlvIOIwGX1ghAX2+ydikEm1zx0KFkrilCWOtWR6ooXsmOaVKsJwVO8SYiR83E1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by GV0P278MB2042.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:70::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 10:06:43 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9678.016; Thu, 5 Mar 2026
 10:06:43 +0000
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
To: qemu-devel@nongnu.org
Cc: Florian Hofhammer <florian.hofhammer@epfl.ch>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 1/8] plugins/core: clamp syscall arguments if target is
 32-bit
Date: Thu,  5 Mar 2026 11:05:59 +0100
Message-ID: <20260305-setpc-v5-v7-1-4c3adba52403@epfl.ch>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
References: <20260305-setpc-v5-v7-0-4c3adba52403@epfl.ch>
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2067;
 i=florian.hofhammer@epfl.ch; h=from:subject:message-id;
 bh=VjBcjTaSiR+5eQjRoownJVqdRgCW89gCG5AYIewcoAk=;
 b=owEBbQKS/ZANAwAKAZbrJ7oxX8d8AcsmYgBpqVTB9QqSpePdLdrCJQOf2ITVIDXWok8Sxgaro
 /6O6raGfdqJAjMEAAEKAB0WIQSoIHw/Sr677ZtN+EmW6ye6MV/HfAUCaalUwQAKCRCW6ye6MV/H
 fDBND/4l3wcStQdbOVHce9C7jk7+7ah7C8raWqfzTezN/F6SX3b8V6KeWxKEIjln8FONwEdp2V9
 cnd5bIWC7dN+ZFIxx/i4qi7IVqvA+fyBghMFfUB2tGfuEJqFWcBZESPunKe3NbPrTEGWkT9YCdC
 zGIinOVXlNrPXW7g03nvrYcL7y8RtNTIXEgmSviHz3XqbNAZGsAcu0wWiQVLyn4pohgZKjEGTK0
 kDrUYqkoqeCQLYqZLL5k2DY/do0NR9vtCfOq7TrSNh0OGfxEqApGfKoq/j9HqVSiTnuKH/83s+3
 6KZFmNrlzwE7lqt5xLj1qrQeiG+JLmAau+XiJ2c2R71D/ThwTEyTphZ4HUNgNfIje3OSpkL+EUw
 5YQCuNsq8NipY7bf3FRPa8hXm5uf/cIHDWyFuOeQYub6nDkzLY0n7RZQc9J+KyzOlX4AjeDOqvq
 zTen9C5iJNxCPkgf5moQ+vLPZUe3fM8tzeL4lN0Bp4onQDJDaJD5dzHYQs/HyRK+1z1N4DhkYvC
 g55QtWqQZkYPy2Bkpq33a9+mwJRZBGSUQmCQx7gOwPr1EynMbv6oOKsPDnhCXxDcYGNCz23VTG/
 MdUC59ngEOKOus2rCnyd4yzCCgBpxGMJXe+aYjzQ70Z/21sRFdoJhXn6YFvJEhm6eqSKvKt9EhE
 KT/pZzulJYKwVzQ==
X-Developer-Key: i=florian.hofhammer@epfl.ch; a=openpgp;
 fpr=A8207C3F4ABEBBED9B4DF84996EB27BA315FC77C
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV0P278CA0090.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|GV0P278MB2042:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2b6f6b-505a-4f61-f683-08de7a9ee705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|786006|376014|366016|19092799006|1800799024; 
X-Microsoft-Antispam-Message-Info: MZ7e2C2kl835j3RwaSjeHVtHeVprHe+CsUfKXDCGhYeooFAESiPL/GyCFCCjdQfdXJdu9DR1MURQLkp2cL2zs5UVMg1QN7sacG3Yo31DXOjHB+JI8N2U9uEmyWVPhEhuDS0VanTx+DFYZuC7RbzioUkDdboHZzAhk5IyXmFLvj01EAqMCo0XJ6kumyfS5VDkO7S5zsRYqcRwWIMKdNkQfdnpqB4Uti7QAzZfBc0JsSyk22TlADVpZ2y2ljlFNDfWpCgVyVlXn71o56DM4yjl+S8AICTYHeM+Dg8FgXpa4lObicbGzcyWtIpDP9LcX0d6Bqpal2w7kRw6wzNEJtgJoHQ1pYc80cdo8arkKzw9s7cEWqua499qcUQbso3oz9dH//4afPdk4Tf53wwYxMbDKtFjMLvJwmH1V1sgoLFrrSbU/Glh3CmpmwZQBzJ6DD8bSstHA9eNZmEklgmyY15t+Qubq98Fm37fkmzXCDScqAvAHjSA3zWdrC6rEFEBZPHm9GqyCAbjBObkRhRQoi1TmA+N1DHmhS57Os9JzcZ/e2LdcYuQh79yDX1dDY2SDPkaP97nR/xRZISG01IDOZ+KdTwG5IRsSust1fABePzHs+/N5530HM0Xuj9iUYMApSDvJI4coEUxhRUPZ/DtAdToaGwpUD7W5/OlMWu9nIyoazfJYEmRxcE2r0Gs3zZO+Oe1L2QkshKTEQA+lyyR96zL5Hws5MGz8/xRTsN7nMtJw2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(786006)(376014)(366016)(19092799006)(1800799024); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUdGNFBRVkhYREVycmhPckVaTVJRb3l2UlZGYWk5d2lIWTZQZk44Tnh2K09y?=
 =?utf-8?B?SWFhWmo1enpQaTR2TytUdXc4aXp1VEFGZERFMzBHOStiakdBaGluUFZ1bjJa?=
 =?utf-8?B?Q1IxOVQ3ek05L1BTc3d2ZlZld1RCQVVYekc3SDZ0UUlhQjZ4UG1yOENjaG9P?=
 =?utf-8?B?eDFQTkpGU2xCUnE3NFFIaHV0VTVkcCtZQllnZHBDSlF5Tk40UHI0djdWWm1J?=
 =?utf-8?B?MDc4TXdwNmY1cXlDVFlWcnR5OGMxcXkzRG9laHZ0ZEZjWTU1Z3ZHTzhQbTk2?=
 =?utf-8?B?SGlZbmVPcHFnM3p3cGlXUVo4Q1ZHVml3eG5VZFlQV3FveENtQWxWM0dJWmNW?=
 =?utf-8?B?cE1PR1dlSG1pOFB6Z1FTWjZMeGlBWnNZOVcvSW4zQStockdSZk45OTVRblAr?=
 =?utf-8?B?amMxcDZkU1B2T3VtTU56RjhwckphR0xtL2d4eGVlOUFHcDN0Q3M4QzFPT0Fj?=
 =?utf-8?B?dVFIRTdtSXFneUhBOFBXOFFIeUtTYjZiWEdFWHpMdmREQ2FucE5LRUJsdzNJ?=
 =?utf-8?B?MFh1ME5aVEN1c0k0U1RSL2sxMmlWNURzY2NTSTRnYXV2Wmw4TjdJdnhEeVFq?=
 =?utf-8?B?RndEZVB5TFRFSHltdndwdUNKanBvT0RZWi9hekQrOC8vR0V6MndKbmJadi9H?=
 =?utf-8?B?MUd3NUhoOGgwVkR3dFVjWXlPOFNqTDBLT3JrNS9vUGRlUThvN2xPaFIrZGk1?=
 =?utf-8?B?dWJ0cnMrR2FubjZSbEFPYzdlZFJRYjFwVVhPNG4yUG8ybUtFbzFoaGVyeHRu?=
 =?utf-8?B?anJ1NTdrejRrN0ZvamFpdWxSWG80UFU4T1ZLRHUrMmZvZVY1ZHlFSlZYY1V6?=
 =?utf-8?B?S1dqY28zM2kyOVpiYzl0dW9OMnJ2dm0wRnFvNUNYdnVlYkxWOXRxemhwNS9h?=
 =?utf-8?B?djduRXdmQ0VuSmFxZU1pQzduWkxEUGphRVZ1V2xBV3NnRjk3VUpFSTZiR1BT?=
 =?utf-8?B?UWJKWDdnNkkvdmFYSTEzVWY1ei9DZkcvVjYxZWkyMVdsL2F2STNGQnFzdlJS?=
 =?utf-8?B?bEEvVlJ2S3l4Q1A2dm9WQnFzNnFTK25WbmxYaWhiaEU0RHMwUVNOa2Nld290?=
 =?utf-8?B?VkRHVW5hZEVXb2NWeHJ2cVBrTzNrY3ZObVhXWi9nZUFOTWt0QUNYRmsrbU1L?=
 =?utf-8?B?OW1XSFAvTCszbkpjRVg0eGZ3R0l3OXl4S0RiVlV4Z3NDNFdHZ2FZVzdhN0pk?=
 =?utf-8?B?SU1MdVIyTG9XTTkyUkxFT3lXNzd4b3NaL0dVMmJrS1hTVi9OOUU0TWRYSW1P?=
 =?utf-8?B?anR6N0RJYms0WGxra3V4dlJlTGVHYmNPY3FIdXBGN0V0RlRsWi9lMEJGYldM?=
 =?utf-8?B?eVN0WThha3Q4QXFqS2ZrNTNFYTh2QUNyMVE1dzZnajhuYWZhZUJOYmVwWGlY?=
 =?utf-8?B?K1o4OHg1bFMxbFVudUdGSVE1VytlcEhWYll3UmlZTElDeHJCNGdoelovNHlY?=
 =?utf-8?B?VDFwcHdXazBhYms0Mmx6VWhiV3RCSjZsRmFUT1BINVhrcnFISElESE9PczRT?=
 =?utf-8?B?WDFwVUVGVGtIanU0UUwvSWJ6RjNvSDBiNnNKL0ZURDFPZ0VqNVhaWUg0MVVJ?=
 =?utf-8?B?QjJJZmNEK0pJUHo4SG5mWXZVSURSRkNTdXo5WkI4MmQ0c0t0bkEwTjB0dmxw?=
 =?utf-8?B?a1pONmNRV1ExcjArV2YzbWdJTVFORjYxQ25lcngwVlkyNVJEdFUxZU4vbTdt?=
 =?utf-8?B?MUIvaW1oUE5aejIwdzBuQVFjOVM0bGVyQXVOWmxoOGh5TDJLL2NrcGVFNGlK?=
 =?utf-8?B?ZUo3aGhmaTRxQlc4TlJRbWYwQjNqbGh6eXJmbXl4dmxRZUlhdlR3VXkvQzgv?=
 =?utf-8?B?OUhSY2ZhOXFTUFdNZjdXaFZtS2k4Q2gvZjRTWGk3bmlwZmxieU9OeHZnYnFt?=
 =?utf-8?B?VTRheG90cUpZYVYzaWpOcC9qRHhESmthTlZuNkE3Y05qa0tpNEtmMXQwSkN1?=
 =?utf-8?B?Z1FzdU9COHAxZlBEZE4wZUdJYWFqemJUbC9OMGRHcFpxdVBFMTQzZkJ3Zkdx?=
 =?utf-8?B?OW5yV2Z5NnV2cHlQeEJjdG5jeXN2VzQ3bmlxaHBCb2lrNHZOUXhMamZsUGFj?=
 =?utf-8?B?aTNoRU5qM0I5dVNWMkNQV20vek1VWnRCdGdheVRtZzVlbUJCOUltcTVkajJy?=
 =?utf-8?B?MEpYM2JXOU50cGFwcXFoYmMvNHpsMWJidzBVZHBYbk5zakNRYU5tTzV0Z2Mr?=
 =?utf-8?B?bmxqQStlc2ZDMVBESGJPbG1IVVdrU3hpSjlYeXk1TXExQ2tnOXEvcGhydzVQ?=
 =?utf-8?B?RVI0b0dTK2hwSll6cE1udlJLWStTNU5VZGhxRmkydmZheDZVanRoYStVcm9P?=
 =?utf-8?B?UU9GQVVINDlOaXhCMHhxZ1NFWmFSY0d2RXBFZXErV1JTaUptODQyWlMvMldH?=
 =?utf-8?Q?4ThC/18hVsIIL7EM=3D?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2b6f6b-505a-4f61-f683-08de7a9ee705
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 10:06:43.3749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTpJs5Usj28D8cEM1h15dIja3WWEWFCLp5Su4R3AHF2mdDn4hA8+ryUA+XBVAHJMiStXhCxVolItJDMHrpe/Z7E+aaeiHYcWQq28TVihE3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB2042
Received-SPF: pass client-ip=2a01:111:f403:c213::5;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZR1P278CU001.outbound.protection.outlook.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Syscall arguments are abi_long in user code, and plugin syscall
interface works with uint64_t only.

According to C integer promotion rules, the value is sign extended
before becoming unsigned, thus setting high bits when only 32-bit lower
ones should have a significant value.

As a result, we need to clamp values we receive from user-code
accordingly.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 plugins/core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/plugins/core.c b/plugins/core.c
index 42fd986593..d6173422e9 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -513,6 +513,23 @@ void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
     }
 }
 
+static void clamp_syscall_arguments(uint64_t *a1, uint64_t *a2, uint64_t *a3,
+                                    uint64_t *a4, uint64_t *a5, uint64_t *a6,
+                                    uint64_t *a7, uint64_t *a8)
+{
+    if (target_long_bits() == 32) {
+        const uint64_t mask = UINT32_MAX;
+        *a1 &= mask;
+        *a2 &= mask;
+        *a3 &= mask;
+        *a4 &= mask;
+        *a5 &= mask;
+        *a6 &= mask;
+        *a7 &= mask;
+        *a8 &= mask;
+    }
+}
+
 /*
  * Disable CFI checks.
  * The callback function has been loaded from an external library so we do not
@@ -531,6 +548,8 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
         return;
     }
 
+    clamp_syscall_arguments(&a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8);
+
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_syscall_cb_t func = cb->f.vcpu_syscall;
 
@@ -584,6 +603,8 @@ qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
         return false;
     }
 
+    clamp_syscall_arguments(&a1, &a2, &a3, &a4, &a5, &a6, &a7, &a8);
+
     qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
 
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {

-- 
2.53.0


