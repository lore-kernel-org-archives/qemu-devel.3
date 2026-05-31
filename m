Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D374FCD5BD1
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2026 09:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTcWr-000252-RR; Sun, 31 May 2026 05:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcWd-00022X-BC
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:32:08 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parthiban@linumiz.com>)
 id 1wTcWb-0008Ra-1w
 for qemu-devel@nongnu.org; Sun, 31 May 2026 05:32:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpFhbnaAiId4bxSEt5jnQ8W0i9MvzkCC6gEHfZ887BCPgmaHh0PIJHYzpMJFzbAU3Lo5yeMXMtbIJJcdEe1NIbb/pZ0jVPVH9hKKw2+V0hrOxlzVVgjx6GEJ4KTgCfeiJ62Ws5vM4L93dEVj1uOTNvM+zIdF047mDTSRxGii87qSheoZy2kF/Lz8wIQKUZcpjtEBZhGZWpX0Vqv6QGomFOGofm4zgh2urSX/g2+f4geiPMiU7eTcmEkUaO7V0yB2XJ43TXgtw1P5SW3CRhkfpzjeEso/LsyAWw1CKzU4zQhtM2IVInzI1Q8EP89oaSmcvROCy+MP6kBwtPkVRcGuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMS+6Q54lcJQrB+zi+0CqwTCKKxLjS4AuzCNBQQV+Eo=;
 b=NzfqgYnGALRs4pJpv42WxS1eGKEu9QiJnOliwW07wX7Or4rFhL7U6y+x+u8yObl5X3O5Ti1vm8KcU7Knvej8/j/2Su2bPpOXdQHsZUrHHDbl1dbHO5mJxE6M64oYktcKVfJ2TNz+mrL7gq0OWasqhqH+XnWrPQGkpy2cuRbfcyzMQnfzOr0Mv/mjDEjDPxnAIYuwcylhUw2lgUuRzgqIVFJllFwcXxhiMcOzUH3TghvxQUnpfSCOKg8N6KkKugdoxwyS41LuibiisX1gwKuLp/bHQ0d1ene1Lde0uiXYeq+mrfkKTSL8whKJRTmY9NTwSTN/sWPQbfErtPiGASMp3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=linumiz.com; dmarc=pass action=none header.from=linumiz.com;
 dkim=pass header.d=linumiz.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=linumiz.com;
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com (2603:1096:405:3c::9)
 by TYSPR06MB6627.apcprd06.prod.outlook.com (2603:1096:400:474::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 09:31:48 +0000
Received: from TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01]) by TYZPR06MB6935.apcprd06.prod.outlook.com
 ([fe80::30b6:5b0d:1b00:5a01%5]) with mapi id 15.21.0071.014; Sun, 31 May 2026
 09:31:48 +0000
From: Parthiban Nallathambi <parthiban@linumiz.com>
Date: Sun, 31 May 2026 15:00:57 +0530
Subject: [PATCH 06/10] hw/timer: add TriCore System Timer Module (STM)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-6-1c39053e5e95@linumiz.com>
References: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
In-Reply-To: <20260531-dev-ifx-tricore-upstream-rebase-minimal-v1-0-1c39053e5e95@linumiz.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Parthiban Nallathambi <parthiban@linumiz.com>, christoph.seitz@infineon.com
X-Mailer: b4 0.15.2
X-ClientProxiedBy: BM1P287CA0022.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::26) To TYZPR06MB6935.apcprd06.prod.outlook.com
 (2603:1096:405:3c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6935:EE_|TYSPR06MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf53f4a-d765-4f9b-c51c-08debef77082
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|18002099003|22082099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info: KDwgvqxMaeT6FvJ+QHO5JuFMkFpo+U1VEyhEU787T3ph/wfVhxPM9jYewFZ9xuTmMyJJ2keO84UjaAx+CO4tAbXqEbVP3TosIDePvQiSzogYuJc389gGLENgKHAFjFdJfnr+MwSri4g0kFc/E2W2iSxanVRvWOZeYNrJAoiHPY+mmzoVJsiQ8Ql+J4lITOxQm4HmaKLc+A2Ghi7VQNbkM+C/9rfFJTjLebdrof9NH6CTlucT/Ve65vaZ8JWoKejNcH1XV68Tzd9lGsDI+cRscNTBv91EJC/uD/z18FLr7N3JYo6JstMfbSdM0pdtNVnRdZNt8PluhGKp8m8XqR3ptjHKn0DXWy0bhzB99Rkdil90GP6ZmNBtsO6ddr2bNG7IFv08Dk2Ne/hzbPPP4iA2ghDXDvKkz+WC8v5G7/sY1ULIeAnN7CePZi5GH08m0bAK4xpIkbAt6hcaoTjuKTbrdgOGudbxc/0b9YBAj2ohEoa9kB/r+/80InveD4iLIRRSXPcKg6Tu0qREUGA2IZZqglea1Z2r8zK96CFO7uJPAt/887pkBeKVxKv/fEbS2cX5h48o2druSMm+gO0gTih3FTqYkhQBvGXiySGS3JunGpzO6sQKA80Kzffp8VIEUBJ6XDx07CLun8VadaFeMpQ5fWonwD0d2wBhWjB0FFyymfFfCf2u+ZkITRR55GHlEezQVXscFGXk26yOgAyhl3sjAUgQ9TtUFmryQha9mahaTHwYTR/FdUsJehL2Kko9BnKM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB6935.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(18002099003)(22082099003)(56012099006)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHhCaWNjUys3M2RWbUFLNUJoZTU5dWUxRmtoN3hUSnQrNlVQRGMyTUNtWmRr?=
 =?utf-8?B?OGgwNktQUU5lcUVTTTZ4REVGMDF6dkZIVEhtYjFreWtJMXFkclJSekVCRzdP?=
 =?utf-8?B?Z2tEa1dzUVlLMWFHSk9iYnZYTTNwQ2tOWE9qdnhjQ1V0ME51Zjh4akd4VDdv?=
 =?utf-8?B?am5LS1hMQ0Y2endJam5oOU5DTzVXU01kRURKMFl3Y3FNOEhkR2c4WWdlWVZH?=
 =?utf-8?B?Uy9NZUdISUgrcUhmKzQ0c1Z2YTUzWVZmci81bFdrYy9LeWNURm5qZXp3RVM0?=
 =?utf-8?B?TGxhSXRoWnBXVThlUTl3R0tsdHllaDcrbnVrZ3ljcUpMUEtaa1N6UktTMWhE?=
 =?utf-8?B?VHoxUzZ6UDQ3TTF3dnVlMktyYmVtTUFINERwOWRaYy80cHArM1FOa2tJRzV2?=
 =?utf-8?B?MEtIWFRoZHp5cjJLc3RQWmswRkhpWHBMR25Ld0xZWWNXeTlnd1lRQlhncU43?=
 =?utf-8?B?T1pJaDNNNWJjOFg5ZDByYnBObmpKaFBHWHZqcThOSmd4SXpTV0cxSmdwLzlT?=
 =?utf-8?B?elU1R3lzMGZuYXZMK3VhZms4SEhkQzFjV0dzWHV2NjI5blhyTk9vUVEvaEVt?=
 =?utf-8?B?dTVaeW4yNFoxZitBQktXRTUrQ1YwVXpJWHZHaEtBallmYWhiS0JrZG83RmhY?=
 =?utf-8?B?ejA0Uzdmd2lqeGgwTE1ldWJZVStkVVh5WWJIQkhQWEJ1dCttUTlaQXR3RTNr?=
 =?utf-8?B?c0xOZ3FNSmhmS08zeVRsUE5QeVJBa3hzZmZleU5mVG5CeXY4SmJ4RDZsSEYz?=
 =?utf-8?B?ZEZ6aTBTR1BMSEhMMDdrbFN3ZHF2bGdIUnVKYnlRd0l5N1pBVVJ2SnlSVkpE?=
 =?utf-8?B?N3M1YWFBWHVDdlBESTdJSUFFaHZhT0Y1WGVwSWplckgzVCs4MFFEV0k0RE1Y?=
 =?utf-8?B?QjE4ZXZnN0k3SnJZcDRLdDVRMHBWUWxYSUVINFN6UDJwZTB4cUg4dVJyN2Zi?=
 =?utf-8?B?aEc1SkNzN0tKcVljWDdsOWs0Z3Y0SlFIUkVFTWd0eXBzSHNFSU41cHBBMFRn?=
 =?utf-8?B?eWlFNkU0bzlwdVRXM2lwa3JFbk16dHlhbDRTR3oxTkI3K05lYTVRK1hlUVMr?=
 =?utf-8?B?UlM4NDdIQXQxVlI1aUF2bzRlM1o2R3Z4RDdJSmFNRXhRUWJSNGg5Q0FQdFJE?=
 =?utf-8?B?cEpjaFJBQmM0ZUZibGtDd29ybTJxNUhMQlIxREErdUJxQ0lBRmFIQVI4NEMv?=
 =?utf-8?B?NjR2RkVma01DMXRpM2NWbTJHWDNwKzNUbUV4WlV0SnBCUHZDY2tPc3pCQ3Zl?=
 =?utf-8?B?Y3gwT0RuRUVvc05lWjJxSnc1Tk9JMFUzUndmdGdVckIxRGV6RGNzczJqQW4r?=
 =?utf-8?B?dkk0ZVBWWjMrL2Z3QUFEWlJwbEp5b2JVZDRsd0RsRkt1b0crVkdtNVZzVDVo?=
 =?utf-8?B?T0Q5Y09pS29jSDFtNnNZcS9CTlpja0ZjSnV2ZVJORHNFRWEvS0x5NjZ5T3Nv?=
 =?utf-8?B?dTlYSW5DQ1NyalVEUDBqUzkwNEdibUFQaFc4SEoxSGxZZkNCMVhrWTJPalhS?=
 =?utf-8?B?ZVE1MXJXNWNRT2I3NjB3Q3FOMGNXN0pWUHRzMEEvS1RScjVFemRUcXNGYUpk?=
 =?utf-8?B?Sm9GV3JENUhJb3hxYVNrV3gxamgxYnZyWXFxTHRWVEsxVTE1NUtlSHBXdVJY?=
 =?utf-8?B?dHM1SDlNZSs4dEQ3T3RIeVltWkYyYTQwKzVMOFl6SE9HcG9KTXF2T2w3VS9r?=
 =?utf-8?B?a1BocnFNM3VxL1EzcVIvNEVEZis5ZHlqRlhmQWszeUx5b2JNd2ROSzdWTVpj?=
 =?utf-8?B?SjZ0UzJRK2F2cDlQUlNyU2NDdGphSlVtc2MrRW1ML2F4bzZQUlRrczliQ29p?=
 =?utf-8?B?SkhhdkE0d3dZTzY0WDY4VXJNU2lFRW1tYmF3c1NUOVo3ZEV6MlBBbVArVDRS?=
 =?utf-8?B?V3hKbFZwb25qQzRUbGdFcmlhUzNZcjhERDR0QzV2QkMvZExIc1k0bGtLdEhv?=
 =?utf-8?B?TXkycy9wTEVhZDRyNkJPZ2JZTHM1anBzU0ZhWXJCMU5BbU1wMytxY292T0xm?=
 =?utf-8?B?ZEViVC90QUkzTW4ycExBZ2RRemRpZVU3V2c3dysvV3c3YkNLOWdYNlNIcEhQ?=
 =?utf-8?B?aVBNUElCVXUrL1UzTWVWdHhZRFgyZzhNMkxpWnp3c3V5SlVKbXlYc2RxYjJJ?=
 =?utf-8?B?bXliVHR2QWRRTUpOV3V5cnQrSllnU1pqRlNMa1MvMVI5dWZHQVJRanIzMnhQ?=
 =?utf-8?B?TGFVWk5UQjJ1cUNGQTFHYVpscTNRZDZ4SFN5TkoyK0UzQmZkNGNYWWhrWnBr?=
 =?utf-8?B?MURMcWlmK0pvdjlpSGQxeFZOZ2NxVm5qZnZ3U0NvemNWd2tCcWJtanFVTnQ0?=
 =?utf-8?B?RWJiOEtDeW9sUXQrYWVUL0czQWk1UHdFVjVIdnJMandEdDh5T0N0UT09?=
X-OriginatorOrg: linumiz.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf53f4a-d765-4f9b-c51c-08debef77082
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6935.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 09:31:48.7711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 808466aa-232a-41f4-ac23-289e3a6840d4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8oQtdcV5EnbBc9GaebD8dt/c38cYuowqyUEgx23fOQ5R7NlFo0KEURUKTPhTW31KspGkDDh4sgDYDHaudITZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6627
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=parthiban@linumiz.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Free-running 64-bit counter with compare match interrupt.
TIM0..TIM6 give shifted views of the counter, CMP0 fires
when the masked counter matches the programmed value.

Originally-by: Christoph Seitz <christoph.seitz@infineon.com>
Signed-off-by: Parthiban Nallathambi <parthiban@linumiz.com>
---
 hw/timer/Kconfig               |   4 +
 hw/timer/meson.build           |   2 +
 hw/timer/tricore_stm.c         | 328 +++++++++++++++++++++++++++++++++++++++++
 include/hw/timer/tricore_stm.h |  76 ++++++++++
 4 files changed, 410 insertions(+)

diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index b3d823ce2c..250452b3fa 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -65,3 +65,7 @@ config STELLARIS_GPTM
 
 config AVR_TIMER16
     bool
+
+config TRICORE_STM
+    bool
+    select TRICORE_IRBUS
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 201b5d8316..78d67a7e69 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -34,3 +34,5 @@ specific_ss.add(when: 'CONFIG_IBEX', if_true: files('ibex_timer.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_PWM', if_true: files('sifive_pwm.c'))
 
 system_ss.add(when: 'CONFIG_AVR_TIMER16', if_true: files('avr_timer16.c'))
+
+system_ss.add(when: 'CONFIG_TRICORE_STM', if_true: files('tricore_stm.c'))
diff --git a/hw/timer/tricore_stm.c b/hw/timer/tricore_stm.c
new file mode 100644
index 0000000000..376e680bc7
--- /dev/null
+++ b/hw/timer/tricore_stm.c
@@ -0,0 +1,328 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU TriCore System Timer Module (STM)
+ *
+ * Copyright (c) 2024 Infineon Technologies AG
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/clock.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev-clock.h"
+#include "hw/timer/tricore_stm.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+
+enum {
+    R_CLC,
+    R_RESERVED1,
+    R_ID,
+    R_RESERVED2,
+    R_TIM0,
+    R_TIM1,
+    R_TIM2,
+    R_TIM3,
+    R_TIM4,
+    R_TIM5,
+    R_TIM6,
+    R_CAP,
+    R_CMP0,
+    R_CMP1,
+    R_CMCON,
+    R_ICR,
+    R_ISCR,
+    R_RESERVED3,
+    R_TIM0SV  = 0x50 / 4,
+    R_CAPSV,
+    R_RESERVED4,
+    R_OCS     = 0xE8 / 4,
+    R_KRSTCLR,
+    R_KRST1,
+    R_KRST0,
+    R_ACCEN1,
+    R_ACCEN0,
+};
+
+static void tricore_stm_tim_update(TriCoreSTMState *s)
+{
+    int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    s->tim_counter += clock_ns_to_ticks(s->fstm, now - s->tim_base_ns);
+    s->tim_base_ns = now;
+}
+
+static void tricore_stm_timer_update(TriCoreSTMState *s)
+{
+    uint32_t mstart = (s->regs[R_CMCON] & MASK_CMCON_MSTART0) >> 8;
+    uint32_t msize = s->regs[R_CMCON] & MASK_CMCON_MSIZE0;
+    uint32_t nbits = msize + 1;
+    uint64_t tim_target = s->tim_counter;
+
+    if (!(s->regs[R_ICR] & MASK_ICR_CMP0EN) &&
+        (s->regs[R_ICR] & MASK_ICR_CMP0IR)) {
+        return;
+    }
+
+    /* Calculate the target TIM value */
+    if (mstart) {
+        tim_target = deposit64(tim_target, 0, mstart, 0);
+    }
+    tim_target = deposit64(tim_target, mstart, nbits,
+                           (uint64_t)s->regs[R_CMP0]);
+
+    /* Wrap around if needed */
+    if (tim_target <= s->tim_counter) {
+        tim_target += (1ULL << (mstart + nbits));
+    }
+
+    timer_mod(s->timer,
+              s->tim_base_ns +
+              clock_ticks_to_ns(s->fstm, tim_target - s->tim_counter));
+}
+
+static void tricore_stm_clock_update(void *opaque, enum ClockEvent event)
+{
+    TriCoreSTMState *s = TRICORE_STM(opaque);
+
+    if (event == ClockPreUpdate) {
+        tricore_stm_tim_update(s);
+    } else {
+        tricore_stm_timer_update(s);
+    }
+}
+
+static void tricore_stm_write(void *opaque, hwaddr offset,
+                              uint64_t value, unsigned size)
+{
+    TriCoreSTMState *s = TRICORE_STM(opaque);
+    hwaddr reg_addr = offset >> 2;
+
+    switch (reg_addr) {
+    case R_CLC:
+    case R_ID:
+    case R_TIM0:
+    case R_TIM1:
+    case R_TIM2:
+    case R_TIM3:
+    case R_TIM4:
+    case R_TIM5:
+    case R_TIM6:
+    case R_CAP:
+        s->regs[reg_addr] = value;
+        break;
+    case R_CMP0:
+        s->regs[reg_addr] = value;
+        tricore_stm_tim_update(s);
+        tricore_stm_timer_update(s);
+        break;
+    case R_CMP1:
+    case R_ICR:
+        s->regs[reg_addr] = value;
+        tricore_stm_timer_update(s);
+        break;
+    case R_CMCON:
+        s->regs[reg_addr] = value;
+        tricore_stm_tim_update(s);
+        tricore_stm_timer_update(s);
+        break;
+    case R_ISCR:
+        if (value & MASK_ISCR_CMP0IRR) {
+            qatomic_and(&s->regs[R_ICR], ~MASK_ICR_CMP0IR);
+        }
+        if (value & MASK_ISCR_CMP1IRR) {
+            qatomic_and(&s->regs[R_ICR], ~MASK_ICR_CMP1IR);
+        }
+        if (value & MASK_ISCR_CMP0IRS) {
+            qatomic_or(&s->regs[R_ICR], MASK_ICR_CMP0IR);
+        }
+        if (value & MASK_ISCR_CMP1IRS) {
+            qatomic_or(&s->regs[R_ICR], MASK_ICR_CMP1IR);
+        }
+        tricore_stm_timer_update(s);
+        break;
+    case R_TIM0SV:
+    case R_CAPSV:
+    case R_OCS:
+    case R_KRSTCLR:
+    case R_KRST1:
+    case R_KRST0:
+    case R_ACCEN1:
+    case R_ACCEN0:
+        s->regs[reg_addr] = value;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "tricore_stm: write to unknown register 0x%"
+                      HWADDR_PRIx "\n", offset);
+        break;
+    }
+}
+
+static uint64_t tricore_stm_read(void *opaque, hwaddr offset,
+                                 unsigned size)
+{
+    TriCoreSTMState *s = TRICORE_STM(opaque);
+    uint64_t r = 0;
+    hwaddr reg_addr = offset >> 2;
+
+    if ((reg_addr >= R_TIM0 && reg_addr <= R_TIM6) ||
+        reg_addr == R_TIM0SV) {
+        tricore_stm_tim_update(s);
+        s->regs[R_CAP] = (uint32_t)(s->tim_counter >> 32);
+    }
+
+    switch (reg_addr) {
+    case R_CLC:
+    case R_ID:
+        r = s->regs[reg_addr];
+        break;
+    case R_TIM0:
+    case R_TIM1:
+    case R_TIM2:
+    case R_TIM3:
+    case R_TIM4:
+    case R_TIM5:
+    case R_TIM6:
+        r = s->tim_counter << (reg_addr - R_TIM0) * 4;
+        break;
+    case R_CAP:
+        r = s->regs[R_CAP];
+        break;
+    case R_ISCR:
+        r = 0;
+        break;
+    case R_CMP0:
+    case R_CMP1:
+    case R_CMCON:
+    case R_ICR:
+        r = s->regs[reg_addr];
+        break;
+    case R_TIM0SV:
+        r = s->tim_counter;
+        break;
+    case R_CAPSV:
+        r = s->regs[R_CAP];
+        break;
+    case R_OCS:
+    case R_KRSTCLR:
+    case R_KRST1:
+    case R_KRST0:
+    case R_ACCEN1:
+    case R_ACCEN0:
+        r = s->regs[reg_addr];
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "tricore_stm: read from unknown register 0x%"
+                      HWADDR_PRIx "\n", offset);
+        r = 0;
+        break;
+    }
+
+    return r;
+}
+
+static void tricore_stm_reset(DeviceState *dev)
+{
+    TriCoreSTMState *s = TRICORE_STM(dev);
+
+    s->regs[R_CLC] = RESET_TRICORE_STM_CLC;
+    s->regs[R_ID] = RESET_TRICORE_STM_ID;
+    s->regs[R_TIM0] = RESET_TRICORE_STM_TIM0;
+    s->regs[R_TIM1] = RESET_TRICORE_STM_TIM1;
+    s->regs[R_TIM2] = RESET_TRICORE_STM_TIM2;
+    s->regs[R_TIM3] = RESET_TRICORE_STM_TIM3;
+    s->regs[R_TIM4] = RESET_TRICORE_STM_TIM4;
+    s->regs[R_TIM5] = RESET_TRICORE_STM_TIM5;
+    s->regs[R_TIM6] = RESET_TRICORE_STM_TIM6;
+    s->regs[R_CAP] = RESET_TRICORE_STM_CAP;
+    s->regs[R_CMP0] = RESET_TRICORE_STM_CMP0;
+    s->regs[R_CMP1] = RESET_TRICORE_STM_CMP1;
+    s->regs[R_CMCON] = RESET_TRICORE_STM_CMCON;
+    s->regs[R_ICR] = RESET_TRICORE_STM_ICR;
+    s->regs[R_ISCR] = RESET_TRICORE_STM_ISCR;
+    s->regs[R_TIM0SV] = RESET_TRICORE_STM_TIM0SV;
+    s->regs[R_CAPSV] = RESET_TRICORE_STM_CAPSV;
+    s->regs[R_OCS] = RESET_TRICORE_STM_OCS;
+    s->regs[R_KRSTCLR] = RESET_TRICORE_STM_KRSTCLR;
+    s->regs[R_KRST1] = RESET_TRICORE_STM_KRST1;
+    s->regs[R_KRST0] = RESET_TRICORE_STM_KRST0;
+    s->regs[R_ACCEN1] = RESET_TRICORE_STM_ACCEN1;
+    s->regs[R_ACCEN0] = RESET_TRICORE_STM_ACCEN0;
+
+    s->tim_counter = 0;
+    s->tim_base_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+}
+
+static const MemoryRegionOps tricore_stm_ops = {
+    .read = tricore_stm_read,
+    .write = tricore_stm_write,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void tricore_stm_timer_hit(void *opaque)
+{
+    TriCoreSTMState *s = TRICORE_STM(opaque);
+
+    qatomic_or(&s->regs[R_ICR], MASK_ICR_CMP0IR);
+
+    if (s->regs[R_ICR] & MASK_ICR_CMP0EN) {
+        qemu_irq_pulse(s->irq);
+    }
+
+    tricore_stm_tim_update(s);
+    tricore_stm_timer_update(s);
+}
+
+static void tricore_stm_realize(DeviceState *dev, Error **errp)
+{
+    TriCoreSTMState *s = TRICORE_STM(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, tricore_stm_timer_hit, s);
+    s->tim_base_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    s->tim_counter = 0;
+
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+}
+
+static void tricore_stm_init(Object *obj)
+{
+    TriCoreSTMState *s = TRICORE_STM(obj);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &tricore_stm_ops, s,
+                          "tricore_stm", 0x100);
+    s->fstm = qdev_init_clock_in(DEVICE(s), "fstm",
+                                 tricore_stm_clock_update, s,
+                                 ClockPreUpdate | ClockUpdate);
+}
+
+static void tricore_stm_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->legacy_reset = tricore_stm_reset;
+    dc->realize = tricore_stm_realize;
+}
+
+static const TypeInfo tricore_stm_info = {
+    .name = TYPE_TRICORE_STM,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TriCoreSTMState),
+    .instance_init = tricore_stm_init,
+    .class_init = tricore_stm_class_init,
+};
+
+static void tricore_stm_register_types(void)
+{
+    type_register_static(&tricore_stm_info);
+}
+
+type_init(tricore_stm_register_types)
diff --git a/include/hw/timer/tricore_stm.h b/include/hw/timer/tricore_stm.h
new file mode 100644
index 0000000000..48345f5181
--- /dev/null
+++ b/include/hw/timer/tricore_stm.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU TriCore System Timer Module (STM)
+ *
+ * Copyright (c) 2024 Infineon Technologies AG
+ */
+
+#ifndef HW_TRICORE_STM_H
+#define HW_TRICORE_STM_H
+
+#include "hw/core/clock.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+#include "qemu/timer.h"
+
+#define TYPE_TRICORE_STM "tricore_stm"
+OBJECT_DECLARE_SIMPLE_TYPE(TriCoreSTMState, TRICORE_STM)
+
+#define MASK_ICR_CMP0EN     0x01
+#define MASK_ICR_CMP0IR     0x02
+#define MASK_ICR_CMP1EN     0x10
+#define MASK_ICR_CMP1IR     0x20
+
+#define MASK_ISCR_CMP0IRR   0x1
+#define MASK_ISCR_CMP0IRS   0x2
+#define MASK_ISCR_CMP1IRR   0x4
+#define MASK_ISCR_CMP1IRS   0x8
+
+#define MASK_CMCON_MSIZE0   0x1F
+#define MASK_CMCON_MSTART0  0x1F00
+#define MASK_CMCON_MSIZE1   0x1F0000
+#define MASK_CMCON_MSTART1  0x1F000000
+
+#define STM_R_MAX           (0x100 / 4)
+
+/* Reset values */
+#define RESET_TRICORE_STM_CLC       0x0
+#define RESET_TRICORE_STM_ID        0x0000C000
+#define RESET_TRICORE_STM_TIM0      0x0
+#define RESET_TRICORE_STM_TIM1      0x0
+#define RESET_TRICORE_STM_TIM2      0x0
+#define RESET_TRICORE_STM_TIM3      0x0
+#define RESET_TRICORE_STM_TIM4      0x0
+#define RESET_TRICORE_STM_TIM5      0x0
+#define RESET_TRICORE_STM_TIM6      0x0
+#define RESET_TRICORE_STM_CAP       0x0
+#define RESET_TRICORE_STM_CMP0      0x0
+#define RESET_TRICORE_STM_CMP1      0x0
+#define RESET_TRICORE_STM_CMCON     0x0
+#define RESET_TRICORE_STM_ICR       0x0
+#define RESET_TRICORE_STM_ISCR      0x0
+#define RESET_TRICORE_STM_TIM0SV    0x0
+#define RESET_TRICORE_STM_CAPSV     0x0
+#define RESET_TRICORE_STM_OCS       0x0
+#define RESET_TRICORE_STM_KRSTCLR   0x0
+#define RESET_TRICORE_STM_KRST1     0x0
+#define RESET_TRICORE_STM_KRST0     0x0
+#define RESET_TRICORE_STM_ACCEN1    0x0
+#define RESET_TRICORE_STM_ACCEN0    0xFFFFFFFF
+
+struct TriCoreSTMState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion iomem;
+    QEMUTimer *timer;
+    Clock *fstm;
+    qemu_irq irq;
+
+    uint32_t regs[STM_R_MAX];
+    uint64_t tim_counter;
+    int64_t tim_base_ns;
+};
+
+#endif /* HW_TRICORE_STM_H */

-- 
2.47.3


