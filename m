Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0325BE92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 18:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaIIv-0004cQ-F7; Mon, 29 Dec 2025 13:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHL-0003h9-Dk
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:41 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1vaIHH-0008Ez-3n
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 13:47:37 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BTAlCpe3850328
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=oQUTf/Hs/VR
 gHFLbCzhs/8sL2iD0zPZI5dImKNlBqZM=; b=Dr/I2Cg+jQKtHsXZ0txzgkWogeU
 0q1YtlJXWx+uLBpNJKqn4u6BjpVlYJry5fTWMYRfnhmlAQWe2fNTzCY6NwuoFrBV
 bMDtfLNWCeM/PIHu4Jk4x785zGqgHLpF1xhqyFo68YR4FiOWKYu0/CHGpGbuZyf5
 CThW1GyPNyB0vtNl4gSjJikzxbW8taSC6qS+/veSiq5Ac0GwhkeVMJMbLMpTJvdg
 CcGsrfOK1+WdGPPNPs4hrw5/Nz/drWhY36nmfTXSOImAd/7PmcRlmOeu8oz/WfyJ
 lYSF4vGZXlmvdZvUJ6YgvcGkMluqaDESFXQxzW/FA85ZACGr/BlhqvM8kJw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba6dr591b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 18:47:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a377e15716so62817095ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 10:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767034053; x=1767638853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQUTf/Hs/VRgHFLbCzhs/8sL2iD0zPZI5dImKNlBqZM=;
 b=R29aqzKKi7ACSr3GmkOMIA9Ypt3jlUA2QbE+bLMxVz6SriJG8XqS058k4+dlZEOebx
 JUs/D6sT03F2sIbmFUbgBrMocIQTb4AauUvBglYtjZLykKbylGSbVjDxukUY9SW7XCoW
 JpdIWEEgTTtD1w/rLF7ufFaiT+ZwmXyxLpX61V/enLUcvhDvDQvum/SHStIcUHLIujC/
 bRG19dLIT/SkhJyY/80SaCXpXrn6emv7u0KiKhZ0mGa+lSKA5IYW1GlZeHtRCfvboRR1
 FDgE10NnXJw/gLKilBhKK4hDZW0X5o4fdS5X+Gc5iUeydnTUo69KVTonXo3FZA20CGBH
 TIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767034053; x=1767638853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oQUTf/Hs/VRgHFLbCzhs/8sL2iD0zPZI5dImKNlBqZM=;
 b=JbwRJOmTYaG3m142rCUl2bYIU7oxKezBimzCRs7ngTQQqqFErEUhE6/fLwoLZiGZlC
 mTG9UPlh0V+D5BCHsWOG2VAy2hMf0JdM2QQ+j1uDtdUfxb/IDAGNmizsMj/kzhsLJbRt
 AflySQxwOh218uWj6o6CnsaycEgItirKBf3winXoa6ATOly1Mb5L7iHNwGy41S/93VLh
 0Wk3aNEYKNXya/WkNvqY3R3/JCuFfL/aDv9E2LvotVCPh+N2K4rRcDX/UCgjsSaOnw+Y
 SIM+M2LbksNPDXGu/tbCf7ldYSEvUrhRd6NyQmK+CnWzzgY/kFioYrKuzEpuWsdiinkj
 /tow==
X-Gm-Message-State: AOJu0Yx7BAQ1LMNXYtITWZEohNTwsAr9I40kvIi8lKAqcrR4N9LcPLw5
 V/KrjNOZdeGXqIPklTaQ841Jd0CKNqSgX7eJnH8/5Lj1MmnC5dnuUWIVmQW+dtghncecEUx8q2D
 0e8wGSCOulGUtUsF36g/faMsAoNFa4Tr1MoVtMDMEmzoKpTfAtbhzXkd87FJp/oB/ew==
X-Gm-Gg: AY/fxX7w12HEmclCNwO4ZiqGlmdZA8Q4ynk0H4fWjMREEV0eEIEIy/dH8f/60IlSYFi
 ARNUpbRLKgRTeRXwcVhXfeJ2fYjVOtw4MOWuCuSmyTqpgrAhBRHlilxU8PzqM8xpYoNNZ9ixb6p
 lNYugqQbQPq+jEO8jygEr21KT/FZm2Gfhh8N+aJqz9N1Qjp7xBGc8QpZT+fQ+VkRyw2lroyiEMr
 PziuQuqjbVpgHXQ5kp7ws252CbdlKeOYsrKgpUSpjFx5IqVyRoxBbZHO7wZ7LdFVIXHmhb4Qvty
 P60gCv9ru1dHgF07pltqzaRf6ZyFCKzQkLTOr+V5qyzdo/KL67bDE5h3KIz4tQFsdVHejsJsQge
 vukmR5b4yLHwQfIt5lzMTgV9ByaF4aDphl1gMTphO24RO45g=
X-Received: by 2002:a17:903:24d:b0:29b:5c78:8bea with SMTP id
 d9443c01a7336-2a2f2836c2fmr301113385ad.33.1767034052724; 
 Mon, 29 Dec 2025 10:47:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHy0CzSnOgDStZW+3Rg3+uJTcI4Lf5H0S+wcQdKu6x+q+dSrNTM8T2hLYFhAjDf7/5i6up59Q==
X-Received: by 2002:a17:903:24d:b0:29b:5c78:8bea with SMTP id
 d9443c01a7336-2a2f2836c2fmr301113225ad.33.1767034052195; 
 Mon, 29 Dec 2025 10:47:32 -0800 (PST)
Received: from grind.dc1.ventanamicro.com ([187.101.184.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82aa8sm282198705ad.31.2025.12.29.10.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 10:47:31 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v3 06/17] hw/riscv: add e-trace message helpers
Date: Mon, 29 Dec 2025 15:46:45 -0300
Message-ID: <20251229184656.2224369-7-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
References: <20251229184656.2224369-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MiBTYWx0ZWRfXxvSwINdKw1nQ
 KBEBXfEL46pXJ34e+CxaOUReTRcINJHkcuPbARZauK/lKuZDelGiaQz2ii5bcPWvt57i2+brga1
 SMiZfn7ad4m2Gwcd3NGi5O2OFMoeVVq2FsSORdS3SXxReDKYIdLBYgwQLrnhYQb0ToNvwe01iQs
 6dgdTYtBhDZwDJEL0j/+wAPeXMEtTTDl69TEa/REK2xE2MsQLrcZZ0yTzzUCSoq8yF4ozo9plJy
 2a5Go1PAylv3aReWfcLBYBfjCcT2IM3hwOyGu/dVgGBQB73W/s4IbIJd18r6S0uz0AndwXaoTy1
 b9QF+W6kPzfmtkFou6UcTpS6ayztVOw5a9AR7Dq2X8ykfuszoMbObFsekx5IcRwgiXjsmX2XsLL
 wdOt67N8GViFGmiRcAVBQNn7v0o8se6xWmm/rSBZCLh0U1kBCGJI6+v16u8vGStHBj5ZQBaGnN3
 re23QdxzEUuXwbaQfwQ==
X-Authority-Analysis: v=2.4 cv=VdP6/Vp9 c=1 sm=1 tr=0 ts=6952ccc5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=cW5wcbexNO3A0Ml9TiDm9w==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=XcTmqS6Bu3Dxs0I95lkA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: MYGm7efHUhxvTBvFqw0FKtwGKzuqKLHy
X-Proofpoint-ORIG-GUID: MYGm7efHUhxvTBvFqw0FKtwGKzuqKLHy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_06,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512290172
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Before making the trace encoder writing into the RAM sink we need a way
to encode the messages/packets. The encoding is LSB (least significant
bit) based. The doc "Efficient Trace for RISC-V", Chapter 7, mentions:

"The remainder of this section describes the contents of the payload
portion which should be independent of the infrastructure. In each
table, the fields are listed in transmission order: first field in
the table is transmitted first, and multi-bit fields are transmitted
LSB first."

The "RISC-V Trace Control Interface Specification" docs, Chapter 7,
states when talking about the Trace RAM Sink:

"Trace data is placed in memory in LSB order (first byte of trace
packet/data is placed on LSB)."

This means that the LSB encoding must be used to write into the RAM Sink
memory, which is our goal.

The design we're going for is to have all these encoder helpers, along
with the message formats, in a separated file. The trace encoder will
make use of these helpers to blindly write a byte array with the packet
desired, and then write it as is in the RAM Sink.

We'll start by modeling the synchronisation packet first, adding more
formats as we increment the Trace Encoder capabilities.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/meson.build         |  3 +-
 hw/riscv/rv-trace-messages.c | 97 ++++++++++++++++++++++++++++++++++++
 hw/riscv/rv-trace-messages.h | 25 ++++++++++
 3 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 hw/riscv/rv-trace-messages.c
 create mode 100644 hw/riscv/rv-trace-messages.h

diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index 2aadbe1e50..7d3576fcdf 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -14,6 +14,7 @@ riscv_ss.add(when: 'CONFIG_RISCV_IOMMU', if_true: files(
 	'riscv-iommu.c', 'riscv-iommu-pci.c', 'riscv-iommu-sys.c', 'riscv-iommu-hpm.c'))
 riscv_ss.add(when: 'CONFIG_MICROBLAZE_V', if_true: files('microblaze-v-generic.c'))
 riscv_ss.add(when: 'CONFIG_XIANGSHAN_KUNMINGHU', if_true: files('xiangshan_kmh.c'))
-riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c', 'trace-ram-sink.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_TRACE', if_true: files('trace-encoder.c',
+        'trace-ram-sink.c', 'rv-trace-messages.c'))
 
 hw_arch += {'riscv': riscv_ss}
diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
new file mode 100644
index 0000000000..668db0c772
--- /dev/null
+++ b/hw/riscv/rv-trace-messages.c
@@ -0,0 +1,97 @@
+/*
+ * Helpers for RISC-V Trace Messages
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+
+#include "rv-trace-messages.h"
+#include "qemu/bitops.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "trace.h"
+
+typedef enum {
+    HEADER_SIZE = 1,
+    SYNC_PAYLOAD_SIZE_64BITS = 9,
+} RVTraceMessagePayloadSize;
+
+typedef struct RVTraceMessageHeader {
+    uint8_t length:5;
+    uint8_t flow:2;
+    uint8_t extend:1;
+} RVTraceMessageHeader;
+
+/*
+ * Format 3 subformat 0 without 'time' and 'context' fields
+ */
+typedef struct RVTraceSyncPayload {
+    uint8_t format:2;
+    uint8_t subformat:2;
+    uint8_t branch:1;
+    uint8_t privilege:3;
+    uint32_t addressLow;
+    uint32_t addressHigh;
+} RVTraceSyncPayload;
+
+static uint8_t rv_etrace_write_bits(uint8_t *bytes, uint32_t bit_pos,
+                                    uint32_t num_bits, uint32_t val)
+{
+    uint32_t pos, byte_index, byte_pos, byte_bits = 0;
+    uint8_t chunk;
+
+    if (!num_bits || 32 < num_bits) {
+        return 0;
+    }
+
+    for (pos = 0; pos < num_bits; pos += byte_bits) {
+        byte_index = (bit_pos + pos) / 8;
+        byte_pos = (bit_pos + pos) % 8;
+        byte_bits = MIN(8 - byte_pos, num_bits - pos);
+
+        chunk = extract32(val, pos, byte_bits);
+        bytes[byte_index] = deposit32(bytes[byte_index], byte_pos,
+                                      byte_bits, chunk);
+    }
+
+    return num_bits;
+}
+
+static uint8_t rv_etrace_write_header(uint8_t *buf, RVTraceMessageHeader header)
+{
+    uint8_t bit_pos = 0;
+
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 5, header.length);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 2, header.flow);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 1, header.extend);
+
+    return bit_pos;
+}
+
+size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
+                                      TracePrivLevel priv_level)
+{
+    RVTraceSyncPayload payload = {.format = 0b11,
+                                  .subformat = 0b00,
+                                  .branch = 1,
+                                  .privilege = priv_level,
+                                  .addressLow = extract64(pc, 0, 32),
+                                  .addressHigh = extract64(pc, 32, 32)};
+    RVTraceMessageHeader header = {.flow = 0, .extend = 0,
+                                   .length = SYNC_PAYLOAD_SIZE_64BITS};
+    uint8_t bit_pos = 0;
+
+    bit_pos += rv_etrace_write_header(buf, header);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 2, payload.format);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 2, payload.subformat);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 1, payload.branch);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 3, payload.privilege);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 32, payload.addressLow);
+    bit_pos += rv_etrace_write_bits(buf, bit_pos, 32, payload.addressHigh);
+
+    return HEADER_SIZE + SYNC_PAYLOAD_SIZE_64BITS;
+}
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
new file mode 100644
index 0000000000..c7226b50a9
--- /dev/null
+++ b/hw/riscv/rv-trace-messages.h
@@ -0,0 +1,25 @@
+/*
+ * Helpers for RISC-V Trace Messages
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef RISCV_RV_TRACE_MESSAGES_H
+#define RISCV_RV_TRACE_MESSAGES_H
+
+typedef enum {
+    U = 0,
+    S_HS = 1,
+    RESERVED = 2,
+    M = 3,
+    D = 4,
+    VU = 5,
+    VS = 6,
+} TracePrivLevel;
+
+size_t rv_etrace_gen_encoded_sync_msg(uint8_t *buf, uint64_t pc,
+                                      TracePrivLevel priv_level);
+
+#endif
-- 
2.51.1


