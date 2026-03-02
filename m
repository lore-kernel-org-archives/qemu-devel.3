Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59541EA4E25
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 15:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx5GA-0005FM-Ri; Mon, 02 Mar 2026 10:32:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx5Fs-0005CX-ST; Mon, 02 Mar 2026 10:32:21 -0500
Received: from
 mail-switzerlandnorthazon11020097.outbound.protection.outlook.com
 ([52.101.186.97] helo=ZRAP278CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <florian.hofhammer@epfl.ch>)
 id 1vx5Fh-00009t-Ou; Mon, 02 Mar 2026 10:32:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOneQn5rni7mwSWCSFO96V6fssxuqg3xhSLrj4mXglCs52Ke4BAr2wqwUuvi4K2D+GH6QWLdqLa4lXcjEDikCGI92AO7G1qxs4CK8JWe00f1hZTjVlaLFdTDy6RiZQPIB5p7aHUsteoxXm+FSRHAsLnf6G9L0Orr27x4YdMy7hq8temAzfrXn1vlT8pnDuqJUSRtd5uY2nje8jhBJuiSSsqiUPw7vx72uqdlevQzzH5qe5jdf0SycpAr81waDUCdXfEm5UtZRziATOGDhycIPCd0u35HblyDJE/enbQzMAaIu+SeOv/y5TGj/GUZWXrDmHNgdzdKedmnhKDinKrwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=994QZIh2XF9ItTcxYpNWAJvHU2wgx6k4XyFp5MXTWOQ=;
 b=kn4pt1cfl/CrZOk1+CBBB6ksD2tMYaFBW1kCHbQ82Mbu7tBVibflRlmEED75v8ZZJPLL9ldpsq6t2jyWEko9OuLvhaL+ZzkBbNAT10ZUejpau2dfKXQZLxUQ3AtuKIV6XkCilf/T7c2jxvvjKpT4Ef98JVYtRztyVGuBru1P89I9TtQ7FU94iSDUYwIqksTNLuCJVFm05YJ5EXf+lhUD8xrk3iyQIKk0x/hBKxKnPo4BA6s4CNRpZ+WLJ/KZKA7DGjdEZy5mmTo/vd4N9EngWHhqaNvszK5zAIHbOHT1jb04ab712RdbPH5SFfloere5HJqej6Jhl4G80JhPrWElTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epfl.ch; dmarc=pass action=none header.from=epfl.ch; dkim=pass
 header.d=epfl.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epfl.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=994QZIh2XF9ItTcxYpNWAJvHU2wgx6k4XyFp5MXTWOQ=;
 b=JfjEwbI1kxPF6wLTIppFtb9rrtI3Fe7XQaOM/apEAzDzx9XkzvoSB45VFmhUXu1Z3aOK9BjWfjJ+U3YCBNY0DSBrXvXdWxHoPzx9e+KPcfJ21mPhJllqg7Ze5G9EFJMacHv/KfczAhDrd0HtkV/NT4SfNIEWXsWgr4o22dt/QGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epfl.ch;
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM (2603:10a6:918::220)
 by ZR0P278MB1415.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 15:27:03 +0000
Received: from ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c]) by ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 ([fe80::80ea:3d03:40bf:998c%6]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 15:27:03 +0000
Message-ID: <c4ecefb4-8769-403f-8420-8bce42e43e13@epfl.ch>
Date: Mon, 2 Mar 2026 16:27:01 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Florian Hofhammer <florian.hofhammer@epfl.ch>
Subject: [PATCH trivial] plugins: add missing callbacks to version history
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org, qemu-trivial@nongnu.org
Autocrypt: addr=florian.hofhammer@epfl.ch; keydata=
 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
 5hMMZIzTI4AtIcgA3xe4Ew==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVAP278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:20::23) To ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::220)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRH2PFAD84B9AF9:EE_|ZR0P278MB1415:EE_
X-MS-Office365-Filtering-Correlation-Id: d515118e-b28d-4ce1-7bf3-08de7870277e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|786006|19092799006|1800799024|366016; 
X-Microsoft-Antispam-Message-Info: kqPxjuOW3z4oSdtJSV7FQgX4QrQC3CXXFyUvc0IGMqTYbLsxGNEwXsr8gI7alz8ILlX9MoXCiOYcUswYUThzEWZdE1W6T2WF6BCf6+3WYnEDdQxshmsbUuRQD5R1tdSDbF3Ub/dexQOTG0kOrS004kJXbRlW6B6P61YHrjbdePsX9yGAULiPG0Z20OD3vTeAsqdPcJwIsB9AbqD7xBAueCdKFsgCq/o6FS3r3PuwPO5FbRN8Mbl/ROq9NDMU0QjKSE4qIPPwJKg3YhgTrmgy9lWo9aMD5iQlyEW83lLpqec3qk4p50Vn4oJrwbNomwz20sdBaEiF8yEjkNGlXIPNfGxS0xSxTN+uqNf+qySnFEr1DcafBA17RoQ7L1XycdHOwyTEIKTyeFGZNRuiePPxE7GI2xq0I2Do9cxPVAgS5v3TNTxN0wR0oRcMghXg3ieFJRs9MlHhuqte7KSIYrWxSRc4r6/ejzddXT3B8SyW4gEtrDHEjxyVAAfeCbjy8hh+/lbFFWppRlYMhQw4jlebI9XKmB4weejj4XghCAE25abUMsKJQh1PMf1SE684ods3oMQGdYhrWf3JutyY8PPCVNE9R0ey06fZU6ojSChKatho6a7dKAa2etmuleME8LlY3x14vTMujTrPQu36A6TtsAj8UKhxCXJnGWTZ3WEA+5aRk4maQFWcYxDKGNCG8pPZb7hKgRTfowbaUCPMoLbZo5nwhWfKLKyfj6GyDukMjzk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(786006)(19092799006)(1800799024)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUxYQlpKbUcrbmdaamFlQ3pSZXBCRXhKSjIrcHNmRUlxakpKVmxxc1FxWWdX?=
 =?utf-8?B?eDdUTUNrVm1JdllNdzZsKy9VMkNTdk90MlZyTFlBOWxEVGhRazhBc2dlK2lr?=
 =?utf-8?B?TXU1M05BWkRsWW01KzNEUFF5VFNKaThPdmNIWU15OExjRnU2ZzFwc21NeGpR?=
 =?utf-8?B?YngrSE9BdDZxZVJoNG5BSnBEZlZ3UUo5UjFnenZ0S1VFcFpFVzAwaUoyTExV?=
 =?utf-8?B?RlkxeVZSN00vSFQrYXZEL1RZR3FZZElEZDBlWDNLRWV0SUFoV0JrTUlZaWRN?=
 =?utf-8?B?ZkVxcnJrb1hDQ3NKcEs0ZlBuaFdIbXdmNmNRV0huR2ZiY3lKOWZSMVhISVJr?=
 =?utf-8?B?ZHdlTVl5ZmQ1T2R1ekZ5SGowSnA1NGdVNUY2ZlQvN0pDdENGTUZvazZISTNj?=
 =?utf-8?B?TjJsQTZ0OU9QZkdlM0N4c3BiaGVCYjJYQzE4cWdzeVVwYWR3NjE1K0lHTUdq?=
 =?utf-8?B?WDVlM25OZkN1amhCNnVFT1hrdlNKa1Jza2F2eXptSVdPZDdiT0drM0I2RFdq?=
 =?utf-8?B?bEtmU042Tm1mTkg2TTQ2Zi9GNUFpWUhZcnpNcU1jWEt2UDVxNE9TUkh2QndY?=
 =?utf-8?B?T09VbmtYekhBcWFZSm5Gb0RFbmtmMmJjSVcyRVdOeUJqMEs2cmk0TUc0K0Za?=
 =?utf-8?B?VTBCdFBPaFhENERHTnlJWVhKS0VQK2gwNCtMWkdRcDNQQ25vZjA1M2t0NDE3?=
 =?utf-8?B?UTFGOWVualAyUStSWlBPUmRTVlhEVUtTaklGK250TGtPblUzL3VhNDNBRThy?=
 =?utf-8?B?c1dwZ1VkVHZ4K0RCY3dXLy81Z2h1bGdUbmpWQjdrd29WTWI3MjRQb2Rnb2lw?=
 =?utf-8?B?MHJMekdhNEhvWFhlR05LQnVQalJGclk1cHdPR24vNzFndk9TQmZPbHRGbWNJ?=
 =?utf-8?B?UGVSZnM1SUZYcGxCSThEcEF4QklqUXFMZWdybThTU1Nsd0dxOHNiNEUrVWpm?=
 =?utf-8?B?VEs3VUJ2QWdJeVAyMTZmalhsNGxYdWtmd2JrQzlha3o2SlBmUzlzZWttT283?=
 =?utf-8?B?MXNQTktIdExYSWRiWG5HSndlN3JWRk5IRFJhbzF3YlNpL0tmekxlRUx0NWJ2?=
 =?utf-8?B?YzFPeUNYa2dINFRtMXR5UmU5MkFUQ3QzdkMzQnI2Vk1vOGd6dGZJZ2h0SjZq?=
 =?utf-8?B?ekV4NWdudUFBL2I4NXlsZnF6a25LbmhZZWVJdUViTUF5dHEzNHY5VHpYRDlS?=
 =?utf-8?B?RmRDbFJBZzR5NE5jUUF0T0lQbkZLSDJodGkxeFpocjdxT1lqemRiQnNXUzVH?=
 =?utf-8?B?VE05WXBqc3FqbHNKK0hHN0cxM0tGWkozMm05MjlTMmxGNzlxOWk3L05vRity?=
 =?utf-8?B?S0lraDhpZy9CeDBTc2tqd0lNU2JZQ3o5WDlKb0hWM1diMHNQNXBPU28xaGZX?=
 =?utf-8?B?RWI3elIwS1RhVHIvWlVvQllUbzQwWGF5em1tTitma280Z1ppZXp0em5ubWV3?=
 =?utf-8?B?UWZhcWltUFRmVGRNODJncmM2eS9nQXFYWnY1d0F3VXdxSVVGUFdZa0p1N1pE?=
 =?utf-8?B?cU5tNGx2RTNSai9uSlJuSG5WVytZWUN1ZzMzS3pYdE8rNTI4R2xPZ2xQQ3Z1?=
 =?utf-8?B?SmVaNWV4VTcrYXgyajVuc3VtdFNPSUQ1TTF2Mk1YYjdJWERpL1cwa2xnblN6?=
 =?utf-8?B?OUhFMlVKOS80TXVTWWNIOC9hQlNjaWZpZXRHeCsxVkhmN09zTXd0N1RjNlhS?=
 =?utf-8?B?S3gzcFAvUkZuTzdKcVlYa1NRcFJyUCtMb21iVEh5WjJCTXIraWw0M2NCOEVI?=
 =?utf-8?B?cS92RzRsYUp1bWF5YkVtbHRnbGd5SEFOUUh5WkRJVWdjM1hDdys3QmRvSDlk?=
 =?utf-8?B?bCsvcWZLRjJrUC8vUnd3Y3lTODloRGxEVmJDS0lCR0hhZnlwdXNkcnlaMEFC?=
 =?utf-8?B?QVVVRkJPTDRuK0t6UkF3c0tldk5uNDZHdTA1c2dOR21tZzVqdDFCVC8rRlFT?=
 =?utf-8?B?M1o1UUFXd3ZpcFNDMjNheUlQVUZlaFhCY0VZZDhmT0xUTStTeS9tY1hVbUFY?=
 =?utf-8?B?b2xWMzJDNkE1K2Vza3VxbUtpcWZoRCttcWYxT1NwRi9mM0xROXdwN3JkSVU0?=
 =?utf-8?B?L0ZLMXp5czlQQzF2c2RUUGlvdjhJdkJlN0s4WE84ZHVCeDgvQ2FpbHZBbG9H?=
 =?utf-8?B?SjZFR1RNRTdLQkYzd2ZMOVpaYXZNVzB2ci9USit1NGpWbEUzR2FwVDk2cU9V?=
 =?utf-8?B?MEltZ2hQQ0VnQWUvbWQ4UlZSbk9kSWpqM1RSaldQWEJBeTY1eloyemZwb1kw?=
 =?utf-8?B?TzRHREgyL1ZpMjVxNUJ5d2RSK2s0eHI0RDNlK29kc3pKVjAzRCsrdTJkTFFS?=
 =?utf-8?B?dnE0Q3NyM2t5Rm1IV3dWa2RsaHZVaFdqUDZHcUFKclNWaVMzOGVOdz09?=
X-OriginatorOrg: epfl.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: d515118e-b28d-4ce1-7bf3-08de7870277e
X-MS-Exchange-CrossTenant-AuthSource: ZRH2PFAD84B9AF9.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 15:27:02.9168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f6c2556a-c4fb-4ab1-a2c7-9e220df11c43
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eQlXQPUkZoMf4u5EVUct57MK73gQwzgJsh5fL61DqpsULYS7enGAeFOy/tcnunG84sI+XTgJcjYPw0Mtj0TPpDzGyrjHC/9drzgitBQJyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1415
Received-SPF: pass client-ip=52.101.186.97;
 envelope-from=florian.hofhammer@epfl.ch;
 helo=ZRAP278CU002.outbound.protection.outlook.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The discontinuity and system call filter callbacks were not reflected in
the versioning comments before. The callbacks have been introduced in
aac73d85d2d6f556dbcee6041a2898cb0ef9b0e6 and
5ed628d1d398b164053f5d5685541ea705275998, respectively.

Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
---
 include/plugins/qemu-plugin.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 17a834dca9..770a65249d 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -76,6 +76,9 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * version 6:
  * - changed return value of qemu_plugin_{read,write}_register from int to bool
+ * - added disconinuity callback API (for interrupts, exceptions, host calls)
+ * - added syscall filter callback API, which allows skipping syscalls and
+ *   setting custom syscall return values
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;

base-commit: ffcf1a7981793973ffbd8100a7c3c6042d02ae23
-- 
2.53.0

