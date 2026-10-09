Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF1ECA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFBMf-0004dv-Fv; Fri, 09 Oct 2026 10:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1xFBH2-0003Ue-3U
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:08:41 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1xFBGv-0007zh-HW
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:08:33 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5ba35c0df4fso4283858e87.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 07:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791554907; x=1792159707; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4pGgxN+Tw3UJP0aDMKMF0q0oaqXAnf2qEf90fn7N98w=;
 b=d9Iye2ohst1q+TFj7BdgJ4P734DvXkJYPd9EAmWUVb9tVyyuwCl45icdmlZU6BRxji
 IyaM6ffIAK5Qab2/sPZ/QtD+HLK1XQuZOR3KsAYIl9noTjQL26xrpR6TbvsqPQ1+4L9Y
 SMrW+lzSnor9YHA7j9nmkpeyecgeU2GEoIrhj0SsgO14fE9dq0kb/0DXT6NSwmDSHlLy
 OdXY7hu+yz0Z8/CGAk3CUP1iBckHd+Ds5WZi6xolMCt79RaLbw5Yeeql8dyc5w0pb6x2
 iZP5PaOhpkTaww5FuoGRKxnYz0vfCMsGtuv2M9AuuUpOdMGr4tU+/x0iCunDiQG+sexc
 fe2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791554907; x=1792159707;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4pGgxN+Tw3UJP0aDMKMF0q0oaqXAnf2qEf90fn7N98w=;
 b=q42GpGSxt5bXpHmxYz9v4RiMbKzbfWlnC7ytX3xErPEP8TK7SXTpe7XhugMYJxRbf/
 PHtXbN5rcC/VRfzkOfexDGf4coId58E7c4llU9l2lARQmR8lBP7oK+hQs6eq/ULNMJvJ
 2+n1LMcRtV46PQ1u13iCYGl68VQOMi3Rd2+Vmh0eL5JgFYKVaVt9/ngLtBt9VxFaT7fX
 W6bDEB0lcL+XhWiSC+wzMPWUUkq0iwG/6lPEMtG5QODlHSUJwG4pmaVdp7hPJr7UwJe8
 kGt6bfUz25Vd8kXik4jsyEtH0TK6Fc938Sn3k7Dtgh6k6AHZ0jDKsEsoZBMWv6xQf/NW
 UZZQ==
X-Gm-Message-State: AFq9FYJyrzv7QQnwbna+vx2A1ZFb+aqPnyTsZpFrDreSsIxhUMTA5Ks3
 Zqo/Om1lokDeYVTKOYBW4Qb7j2ZfXAr26NQ7zcJtVEC6WSIWM7YZJdb7N5R6GiRzAgM=
X-Gm-Gg: AYBFou1JSeusfchtf0eEQbp3SFOxS3LFyihwoRlDlEhEmB0wTDbB6bPI7/lFzFiAoFE
 xqlpY1Fk+9fQmotoAcsGqTSLYFDC5Ioeki8O8+q5Qjt1K3YN4seqwxLcdzm85O8Igm4AEgbOU0d
 +fapaPTFLOae3fIt0KYVj4RK2sf+5NKISJJSYQm6mICrYkdQN6Zr4zjR5OrQLkO8AHU/E+mhjOu
 q9DGAhxGq6ubMB8uonSjH2KP10KiHOjHg5eCgDwwJ9c5ASGoDxEv44Yz8B77luvC1oIYTm5kWmy
 g3zjkDenl/3NUMM9boGsirypXGdNjBIHMfunaYgAsFpl4+ntsY3br2TZsCQ/dnayotQRES6fJcQ
 WMIcfOAECFRN/95ZFBfBz3kAuT+XInlljL55/UwVT7rmXXUecRU/qGkuwiZLaNmZUtP9wphtBJD
 +jdNxzL+0QaEzN8zY4dQy/h7idps5mRa/pnXyKcc68NjN3rxj7eQJSLYiT9tIQwFmB+QzpNHpWj
 1+Lz1h0jqWXixfEHnLjWo5/dolnlNQiwST0rg==
X-Received: by 2002:a05:6512:308b:b0:5bc:b0f3:8a40 with SMTP id
 2adb3069b0e04-5bcde6bf6a5mr700877e87.11.1791554907132; 
 Fri, 09 Oct 2026 07:08:27 -0700 (PDT)
Received: from localhost (broadband-5-228-114-10.ip.moscow.rt.ru.
 [5.228.114.10]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcddeb5136sm653616e87.61.2026.10.09.07.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 07:08:26 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Fri, 09 Oct 2026 17:03:05 +0300
Subject: [PATCH 4/6] hw/riscv/trace-encoder.c: add N-trace filtering
 definitions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-upstream-ntrace_filter-v1-4-8f061c9b24da@gmail.com>
References: <20261009-upstream-ntrace_filter-v1-0-8f061c9b24da@gmail.com>
In-Reply-To: <20261009-upstream-ntrace_filter-v1-0-8f061c9b24da@gmail.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Alexei Filippov <halip0503@gmail.com>, 
 Grigoriy Bereznyakov <gregoriy93.gb@gmail.com>, 
 Konstantin Semichastnov <antikostya2@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13030;
 i=antikostya2@gmail.com; h=from:subject:message-id;
 bh=otevDC+oicUZMI73k4N4L3NEd6TZrB4pu4+a+jRjCZU=;
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqyPQWTQA/XjuFlxBGGnlBPtSg+aD9qYe8Mix8o
 FUmv2bbkqWJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCasj0FgAKCRBIiqVupVDe
 drsmD/9cnR5RDit7xofW8iwvRKYwsomOEeIyAyY4g5wO66Xk4LLmxtQTKL0/NeihrSnsjlJzRdm
 1mVHsuIu3TWFgammvJHxk5hiPpXvQyKAG2luMiuTVEImYFJVJhS7ehag43ovZg7m9out7LtYwr5
 hXIvsfyjdgM0IRAG+8+IyiJHGuhqlCoePulh/hWl3FQESJ2iOt4BPWXfEXvfjeGK5J+BjVJ6tmh
 Je+xFp0HwS1jHyR+rTBwUjmVlI/II4sSSMSAooiNSNnBa0s2RL63uR2AxWHZ7kgT5Di+qtzjoPZ
 JPgz2r2o4R4vuA9HgCaKTr0Hjx/UPbimpPP6/w2un9NjUGXdrIqpzcCUyYBFQ6uLcBh8xqRvchE
 2a8kzThxQrRbUtJ2i5mLZCC5QdljvKq+/mauBJdGYH4UjAE2ki0fajlJOrPZerH/QlUy82ZRtew
 01G/dQ6V0YG4jEFR/Q9z845aK4ZG8sagrEpNdNAafGaEoA3YXMqMrRRyVEyScmd8pAs76MRMFnV
 ELg3uLuLldh1WtoD6S4lVEhMjp8S+fxAEc0DJNBaYF28tFBr0LtDLQlr2LTcjOJLHenfq4AZNq3
 PKVcBXDU2KAvGbsGKgO82gfHOi59NMWCp1cwazRy/Mefcr+kyooXVnw2ez7byBVzfTHk6wvLQZr
 tiUR6tF7VW0gMEg==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=antikostya2@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Implemented N-Trace filtering registers definitions:
  trTeInstFilters, trTeFilterEnable, trTeFilterMatchPrivilege,
  trTeFilterMatchEcause, trTeFilterMatchInterrupt,
  trTeFilterMatchChoicePrivilege, trTeFilterMatchValueInterrupt,
  trTeFilterMatchChoiceEcauseLow, trTeFilterMatchChoiceEcauseHigh.

Also implemented macroses to let life easier with filters because each
filter and comporator, which could be 16 of each of them, could exist.

Signed-off-by: Konstantin Semichastnov <antikostya2@gmail.com>
Signed-off-by: Alexei Filippov <halip0503@gmail.com>
---
 hw/riscv/trace-encoder.c | 232 ++++++++++++++++++++++++++++++++++++++++++++++-
 hw/riscv/trace-encoder.h |  38 ++++++++
 2 files changed, 269 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index cfe6d5f7c8..e3286400b0 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -147,6 +147,76 @@ REG32(TR_TE_INST_FEATURES, 0x8)
 #define R_TR_TE_INST_FEATURES_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
                                          R_TR_TE_INST_FEATURES_RSVP1_MASK)
 
+/*
+ * trTeInstFilters register fields
+ */
+REG32(TR_TE_INST_FILTERS, 0xc)
+    FIELD(TR_TE_INST_FILTERS, INST_FILTERS,  0, 16)
+    FIELD(TR_TE_INST_FILTERS, RSVP,         16, 16)
+
+#define R_TR_TE_INST_FILTERS_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
+                                        R_TR_TE_INST_FILTERS_RSVP_MASK)
+
+/*
+ * trTeFilterControl register fields
+ */
+REG32(TR_TE_FILTER_CONTROL, 0x400)
+    FIELD(TR_TE_FILTER_CONTROL, ENABLE,   0, 1)
+    FIELD(TR_TE_FILTER_CONTROL, MATCH_PRIVILEGE, 1, 1)
+    FIELD(TR_TE_FILTER_CONTROL, MATCH_ECAUSE,    2, 1)
+    FIELD(TR_TE_FILTER_CONTROL, MATCH_INTERRUPT, 3, 1)
+    FIELD(TR_TE_FILTER_CONTROL, MATCH_COMP1,     4, 1)
+    FIELD(TR_TE_FILTER_CONTROL, COMP1,           5, 3)
+    FIELD(TR_TE_FILTER_CONTROL, MATCH_COMP2,     8, 1)
+    FIELD(TR_TE_FILTER_CONTROL, COMP2,           9, 3)
+    FIELD(TR_TE_FILTER_CONTROL, MATCH_COMP3,    12, 1)
+    FIELD(TR_TE_FILTER_CONTROL, COMP3,          13, 3)
+    FIELD(TR_TE_FILTER_CONTROL, MATCH_IMPDEF,   16, 1)
+    FIELD(TR_TE_FILTER_CONTROL, RSVP1,          17, 7)
+    FIELD(TR_TE_FILTER_CONTROL, MATCH_DTYPE,    24, 1)
+    FIELD(TR_TE_FILTER_CONTROL, MATCH_DSIZE,    25, 1)
+    FIELD(TR_TE_FILTER_CONTROL, RSVP2,          26, 6)
+
+#define R_TR_TE_FILTER_CONTROL_RSVP_BITS (MAKE_64BIT_MASK(32, 32) |           \
+                                          R_TR_TE_FILTER_CONTROL_RSVP1_MASK | \
+                                          R_TR_TE_FILTER_CONTROL_RSVP2_MASK)
+
+/*
+ * trTeFilterMatchInst register fields
+ */
+REG32(TR_TE_FILTER_MATCH_INST, 0x404)
+    FIELD(TR_TE_FILTER_MATCH_INST, CHOICE_PRIVILEGE, 0, 8)
+    FIELD(TR_TE_FILTER_MATCH_INST, VALUE_INTERRUPT,  8, 1)
+    FIELD(TR_TE_FILTER_MATCH_INST, RSVP1,            9, 23)
+
+#define R_TR_TE_FILTER_MATCH_INST_RSVP_BITS (MAKE_64BIT_MASK(32, 32) | \
+                                             R_TR_TE_FILTER_MATCH_INST_RSVP1_MASK)
+
+/*
+ * trTeFilterMatchEcause register fields
+ */
+REG32(TR_TE_FILTER_MATCH_ECAUSE_LOW, 0x408)
+    FIELD(TR_TE_FILTER_MATCH_ECAUSE_LOW, CHOICE_ECAUSE_LOW,   0, 32)
+
+REG32(TR_TE_FILTER_MATCH_ECAUSE_HIGH, 0x40c)
+    FIELD(TR_TE_FILTER_MATCH_ECAUSE_HIGH, CHOICE_ECAUSE_HIGH, 0, 32)
+
+/*
+ * trace encoder filter register access macros
+ */
+#define FILTER_FIELD_EX32(value, filter, reg, field) ({         \
+    g_assert((filter) >= 0 && (filter) < TRACE_FILTERS_MAX);    \
+    FIELD_EX32(value + (filter) * 0x20, reg, field);            \
+})
+
+#define FILTER_FIELD_DP32(value, filter, reg, field) ({         \
+    g_assert((filter) >= 0 && (filter) < TRACE_FILTERS_MAX);    \
+    FIELD_DP32(value + (filter) * 0x20, reg, field);            \
+})
+
+#define GET_FILTER_IDX(addr, name) \
+    ((addr - A_ ## name) / 0x20)
+
 static uint32_t trencoder_read_reg(TraceEncoder *te, uint32_t reg_addr)
 {
     hwaddr addr = te->dest_baseaddr + reg_addr;
@@ -379,6 +449,119 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
     }
 }
 
+static uint64_t trencoder_te_inst_filters_prew(RegisterInfo *reg, uint64_t val)
+{
+    TraceEncoder *te = TRACE_ENCODER(reg->opaque);
+    te->inst_filters_mask = FIELD_EX32(val, TR_TE_INST_FILTERS, INST_FILTERS);
+
+    return te->inst_filters_mask;
+}
+
+static uint64_t trencoder_te_filters_control_hardwired_vals(uint64_t val,
+                                                            uint32_t reg_idx)
+{
+    val = FIELD_DP32(val, TR_TE_FILTER_CONTROL, MATCH_COMP1, 0);
+    val = FIELD_DP32(val, TR_TE_FILTER_CONTROL, COMP1, 0);
+    val = FIELD_DP32(val, TR_TE_FILTER_CONTROL, MATCH_COMP2, 0);
+    val = FIELD_DP32(val, TR_TE_FILTER_CONTROL, COMP2, 0);
+    val = FIELD_DP32(val, TR_TE_FILTER_CONTROL, MATCH_COMP3, 0);
+    val = FIELD_DP32(val, TR_TE_FILTER_CONTROL, COMP3, 0);
+    val = FIELD_DP32(val, TR_TE_FILTER_CONTROL, MATCH_IMPDEF, 0);
+    val = FIELD_DP32(val, TR_TE_FILTER_CONTROL, MATCH_DTYPE, 0);
+    val = FIELD_DP32(val, TR_TE_FILTER_CONTROL, MATCH_DSIZE, 0);
+
+    return val;
+}
+
+static uint64_t trencoder_te_filters_control_prew(RegisterInfo *reg,
+                                                  uint64_t val)
+{
+    TraceEncoder *te = TRACE_ENCODER(reg->opaque);
+    uint32_t idx = GET_FILTER_IDX(reg->access->addr, TR_TE_FILTER_CONTROL);
+
+    val = trencoder_te_filters_control_hardwired_vals(val, idx);
+
+    te->filters_info[idx].enabled = FIELD_EX32(val, TR_TE_FILTER_CONTROL, ENABLE);
+
+    te->filters_info[idx].match_priv = FIELD_EX32(val,
+                                                  TR_TE_FILTER_CONTROL,
+                                                  MATCH_PRIVILEGE);
+    te->filters_info[idx].match_ecause = FIELD_EX32(val,
+                                                    TR_TE_FILTER_CONTROL,
+                                                    MATCH_ECAUSE);
+    te->filters_info[idx].match_int = FIELD_EX32(val,
+                                                 TR_TE_FILTER_CONTROL,
+                                                 MATCH_INTERRUPT);
+
+    return val;
+}
+
+static uint64_t trencoder_te_filters_match_inst_prew(RegisterInfo *reg,
+                                                     uint64_t val)
+{
+    TraceEncoder *te = TRACE_ENCODER(reg->opaque);
+    uint32_t idx = GET_FILTER_IDX(reg->access->addr, TR_TE_FILTER_MATCH_INST);
+
+    te->filters_info[idx].match_choice_priv = FIELD_EX32(val,
+                                                         TR_TE_FILTER_MATCH_INST,
+                                                         CHOICE_PRIVILEGE);
+    te->filters_info[idx].match_value_int = FIELD_EX32(val,
+                                                       TR_TE_FILTER_MATCH_INST,
+                                                       VALUE_INTERRUPT);
+
+    return val;
+}
+
+static uint64_t trencoder_te_filters_match_ecause_low_prew(RegisterInfo *reg,
+                                                           uint64_t val)
+{
+    TraceEncoder *te = TRACE_ENCODER(reg->opaque);
+    uint32_t idx = GET_FILTER_IDX(reg->access->addr, TR_TE_FILTER_MATCH_ECAUSE_LOW);
+
+    te->filters_info[idx].match_choice_ecause =
+        deposit64(te->filters_info[idx].match_choice_ecause, 0, 32, val);
+
+    return val;
+}
+
+static uint64_t trencoder_te_filters_match_ecause_high_prew(RegisterInfo *reg,
+                                                            uint64_t val)
+{
+    TraceEncoder *te = TRACE_ENCODER(reg->opaque);
+    uint32_t idx = GET_FILTER_IDX(reg->access->addr, TR_TE_FILTER_MATCH_ECAUSE_HIGH);
+
+    te->filters_info[idx].match_choice_ecause =
+        deposit64(te->filters_info[idx].match_choice_ecause, 32, 32, val);
+
+    return val;
+}
+
+#define DEFINE_FILTER_RAI(_name, _filter, ...) \
+{ \
+    .name = # _name # _filter, \
+    .addr = A_ ## _name + 0x20 * (_filter), \
+    __VA_ARGS__ \
+}
+
+#define DEFINE_FILTER_ARRAY_RAI(_name, ...) \
+    DEFINE_FILTER_RAI(_name,  0, __VA_ARGS__), \
+    DEFINE_FILTER_RAI(_name,  1, __VA_ARGS__), \
+    DEFINE_FILTER_RAI(_name,  2, __VA_ARGS__), \
+    DEFINE_FILTER_RAI(_name,  3, __VA_ARGS__), \
+    DEFINE_FILTER_RAI(_name,  4, __VA_ARGS__), \
+    DEFINE_FILTER_RAI(_name,  5, __VA_ARGS__), \
+    DEFINE_FILTER_RAI(_name,  6, __VA_ARGS__), \
+    DEFINE_FILTER_RAI(_name,  7, __VA_ARGS__), \
+    DEFINE_FILTER_RAI(_name,  8, __VA_ARGS__), \
+    DEFINE_FILTER_RAI(_name,  9, __VA_ARGS__), \
+    DEFINE_FILTER_RAI(_name, 10, __VA_ARGS__), \
+    DEFINE_FILTER_RAI(_name, 11, __VA_ARGS__), \
+    DEFINE_FILTER_RAI(_name, 12, __VA_ARGS__), \
+    DEFINE_FILTER_RAI(_name, 13, __VA_ARGS__), \
+    DEFINE_FILTER_RAI(_name, 14, __VA_ARGS__), \
+    DEFINE_FILTER_RAI(_name, 15, __VA_ARGS__)
+
+
 static RegisterAccessInfo trencoder_regs_info[] = {
     {   .name = "TR_TE_CONTROL", .addr = A_TR_TE_CONTROL,
         .rsvd = R_TR_TE_CONTROL_RSVP_BITS,
@@ -395,8 +578,36 @@ static RegisterAccessInfo trencoder_regs_info[] = {
     {   .name = "TR_TE_INST_FEATURES", .addr = A_TR_TE_INST_FEATURES,
         .rsvd = R_TR_TE_INST_FEATURES_RSVP_BITS,
         .reset = R_TR_TE_INST_FEATURES_NO_ADDR_DIFF_MASK,
-        .pre_write = trencoder_te_inst_feature_prew,
+        .pre_write = &trencoder_te_inst_feature_prew,
+    },
+    {
+        .name = "TR_TE_INST_FILTERS", .addr = A_TR_TE_INST_FILTERS,
+        .rsvd = R_TR_TE_INST_FILTERS_RSVP_BITS,
+        .reset = 0x0,
+        .pre_write = &trencoder_te_inst_filters_prew,
     },
+    DEFINE_FILTER_ARRAY_RAI(
+        TR_TE_FILTER_CONTROL,
+        .rsvd = R_TR_TE_FILTER_CONTROL_RSVP_BITS,
+        .reset = 0x0,
+        .pre_write = &trencoder_te_filters_control_prew,
+    ),
+    DEFINE_FILTER_ARRAY_RAI(
+        TR_TE_FILTER_MATCH_INST,
+        .rsvd = R_TR_TE_FILTER_MATCH_INST_RSVP_BITS,
+        .reset = 0x0,
+        .pre_write = &trencoder_te_filters_match_inst_prew,
+    ),
+    DEFINE_FILTER_ARRAY_RAI(
+        TR_TE_FILTER_MATCH_ECAUSE_LOW,
+        .reset = 0x0,
+        .pre_write = &trencoder_te_filters_match_ecause_low_prew,
+    ),
+    DEFINE_FILTER_ARRAY_RAI(
+        TR_TE_FILTER_MATCH_ECAUSE_HIGH,
+        .reset = 0x0,
+        .pre_write = &trencoder_te_filters_match_ecause_high_prew,
+    ),
 };
 
 static uint64_t trencoder_read(void *opaque, hwaddr addr, unsigned size)
@@ -436,6 +647,17 @@ static const MemoryRegionOps trencoder_ops = {
     },
 };
 
+static void trencoder_reset_filter(FiltersInfo *filter)
+{
+    filter->enabled = 0;
+    filter->match_priv = 0;
+    filter->match_ecause = 0;
+    filter->match_int = 0;
+    filter->match_choice_priv = 0;
+    filter->match_value_int = 0;
+    filter->match_choice_ecause = 0;
+}
+
 static void trencoder_reset(DeviceState *dev)
 {
     TraceEncoder *te = TRACE_ENCODER(dev);
@@ -454,6 +676,14 @@ static void trencoder_reset(DeviceState *dev)
     te->branch_map = 0;
     te->branches = 0;
     te->sync_cnt = 0;
+    te->inst_filters_mask = 0;
+
+    te->filter_state = IDLE_FILTER;
+    te->exec_state = DEFAULT_EXEC;
+
+    for (int i = 0; i < ARRAY_SIZE(te->filters_info); i++) {
+        trencoder_reset_filter(&te->filters_info[i]);
+    }
 }
 
 static void trencoder_realize(DeviceState *dev, Error **errp)
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index cb792a6c46..f4196e7208 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -15,7 +15,35 @@
 #include "qom/object.h"
 #include "cpu.h"
 
+#include "rv-trace-messages.h"
+
+typedef enum {
+    DEFAULT_EXEC    = 0,
+    INTERRUPT_EXEC  = 1,
+    EXCPTION_EXEC   = 2,
+} FilterExecutionState;
+
+typedef enum {
+    IDLE_FILTER = 0,
+    PROG_TRACE_SYNC_PENDING = 1,
+    PROG_TRACE_CORRELATION_PENDING = 2,
+} FilterTracingState;
+
+typedef struct FiltersInfo {
+    bool enabled;
+    bool match_priv;
+    bool match_ecause;
+    bool match_int;
+
+    uint8_t match_choice_priv;
+    uint8_t match_value_int;
+
+    uint64_t match_choice_ecause;
+} FiltersInfo;
+
 #define TRACE_R_MAX (0xFFF / 4)
+#define TRACE_FILTERS_MAX (16)
+
 typedef enum {
     BTYPE_CONTROL_FLOW = 0,
     BTYPE_EXCEPTION    = 2,
@@ -64,8 +92,18 @@ struct TraceEncoder {
     NtraceIndirectBranch pending_branch_trace;
 
     uint64_t sync_cnt;
+    /* only instruction filters supported by now */
+    uint16_t inst_filters_mask;
+    FiltersInfo filters_info[TRACE_FILTERS_MAX];
+    FilterTracingState filter_state;
+    FilterExecutionState exec_state;
 };
 
+typedef enum {
+    INSTRUCTION_FILTERING   = 0,
+    DATA_FILTERING          = 1,
+} FilteringType;
+
 typedef enum {
     BRANCH_NOT_TAKEN           = 0,
     BRANCH_TAKEN_CONDITIONAL   = 1,

-- 
2.43.0


