Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32074C982D8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 15:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7afg-0006SQ-35; Fri, 18 Sep 2026 11:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1x7afe-0006S9-CG
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 11:38:38 -0400
Received: from mail-lf2-x11.google.com ([2a00:1450:4864:36::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antikostya2@gmail.com>)
 id 1x7afb-0003Dq-8A
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 11:38:37 -0400
Received: by mail-lf2-x11.google.com with SMTP id
 2adb3069b0e04-5b8c58fd069so402745e87.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 08:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789745911; x=1790350711; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YSjf2f/gOB65KFXRp3HsadUImFPA7gBnvrBCS70UBu8=;
 b=MO/ocZnwUbhNqewGLPgJurIfx3zuUOXLjNiJS/l22kz2kndM1TteEVndlSvlxh0v46
 aFZka/kmkzgiztxpTDMvuIlvqaQWiHFM2GqCChekXrzaSysmv5DPVuctiuZHOo2kD3vN
 MejQkI2x/NPzucYe1SAdPNxZhTmuZy9+CXbkcMCEyZ/ld4tYJNE6JwO//xxoGQDj9R1O
 y6W1lQ3F2TFsWqbgIZnSddUMq0/HYlelfXVw+lFhtVOhbw/3up4X1rvGT5UU47YMluLF
 AyS9WWa5p1bXTGurslPB4+UssvKreChBCb3x+9VDNaNWKsxduGNTKo5HrsnJ/I9VP4g3
 9P1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789745911; x=1790350711;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YSjf2f/gOB65KFXRp3HsadUImFPA7gBnvrBCS70UBu8=;
 b=K6mOf6WJYHmLxX4mfE+fRtSiH3menVhoPeG+g86U580HwuWaO66bR7moeDjuWl7VzX
 4/q4wLft9Fw+3Tmm7a+Y7xsG/hvkFzmQc9ZyWVzARNw+4W68NIAf2rG2cHLfv8S8jnul
 v4dRmw35oYSRe2wOP0c2mmlKi+WiEajSlxT5tnuDYtLJlQ91y95JXmRU4yVz+JxAGXXn
 /3J51QvTEO4bAIlVMRUSz3heWmY2EzwXYBumhtVDfUqi2l8N9+UkzGVjnFyWILOKGYUN
 j4Yr0UsY7gEHrrDHDrJZ5ZFbZMpKnJjRLp9Cp2lwEHy7yQyKobcqTS65rkwIpgn/AEdD
 5AsQ==
X-Gm-Message-State: AFuF++njtLZu1noU20qWHWKyE0aioVVDDj6V4X4iYTzAHK6cgX0B0FxZ
 lgFpXq6JhC+XYVqr3NmFuLx5Ib/Wc0zqqWYn4Ka0XsgThuGRKrdO5lxkwUQWl+Uu
X-Gm-Gg: AYBFou22K/e9h3XVj2Btfobs0cVV/wy0ajyi8tFQIPEf3Zlo8De5JIi/7u7mj6CZst1
 uoKS7NRIMXgvww+a3RviQLK30gYKFLKjUQ4FkSGjMLqNuqdInf+ltD11YwMdrv7FyUzy0u/rfhJ
 UmAbUlwKZ8qzeXpY2Cpx7S7y7YHXytZ2eC2b8i3wUBMhQTE2S/d1k6Q3Tnn/SqpPZKaFx6l8uA0
 816CFJwwUtEd+8XGkN7WK66cjVk+p/aZwNYe/kdZCyP38yyKv1wvS1LBzqC6pqvT0Cui7MUkYeT
 Mt7KATsCd+XgihN5C3Eqi2RiTXao64GyxA386z1I4dZhjsddevNeoOTRCbLku6afXHTsR5smdDW
 0Ts7506+REx3/tPKPEdqycBMqockETsyCumm5XcbyM6ridzzD5ue6RzFoZgrz6buakK1g09Lk3l
 2jKuPty1ZDGQuh5KQ3p3iXqOKrfQrqlaHjVUImcUnT0S2AcjnJjm0swXFoYAV00h/NNxGE
X-Received: by 2002:a05:6512:1384:b0:5b6:183b:d20d with SMTP id
 2adb3069b0e04-5b8c194e06emr1091047e87.52.1789745910496; 
 Fri, 18 Sep 2026 08:38:30 -0700 (PDT)
Received: from localhost ([213.79.119.14]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8c274ed00sm578432e87.19.2026.09.18.08.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 08:38:29 -0700 (PDT)
From: Konstantin Semichastnov <antikostya2@gmail.com>
Date: Fri, 18 Sep 2026 18:34:38 +0300
Subject: [PATCH 2/6] hw/riscv/trace-encoder.c: Support sync messages for
 N-trace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-upstream-ntrace_msg-v1-2-16a56ad8e0ef@gmail.com>
References: <20260918-upstream-ntrace_msg-v1-0-16a56ad8e0ef@gmail.com>
In-Reply-To: <20260918-upstream-ntrace_msg-v1-0-16a56ad8e0ef@gmail.com>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-riscv@nongnu.org, Alexei Filippov <halip0503@gmail.com>, 
 Arseniy Semenov <ar.semenov@outlook.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10698;
 i=antikostya2@gmail.com; h=from:subject:message-id;
 bh=VN2bbM0YE1ruvE0c02QgtVkI1IUhi2SCwlVI3u2+YQU=;
 b=owEBbQKS/ZANAwAKAUiKpW6lUN52AcsmYgBqrVoN5pi/CBm0iKgFwS4ja5hvJY6xx4k5iUfd8
 Br8kNAy0ASJAjMEAAEKAB0WIQRMBWLx2o+linEPEBhIiqVupVDedgUCaq1aDQAKCRBIiqVupVDe
 dnhtD/4zFxVVwmTD6s/jgL1V4aMgnwCuqXD5WC15CU6vq1iWyJzeTnT6ZHTIUU1KG2OJZNHKosF
 3rRrvKGwM9guFm9WZhHDqH2kKs75YB5zZoZ0PQ1X7HOTp8cG3JbeCg+3fnyziuygXEsvQRNt8ze
 NMPJp9dTE2DWym0TFaoE4/oC0+5DyXYKJYHWedE4bJV43j+YjGwsWRU/xiY+cjs3piDrVR6GFDB
 9SBY1BobYbq9i/Fx2qIEVrYPzURssLWbcwak5zgj7zYNEgngt4p/fZeLrYp+eLD3bJD3te/SuUC
 C4nXgZ1+c8OczS4++RruQ82FlNXREdyGYXXCXhzXIh8WtLtDO2fz4fMQ9RK3rC8fhcP9xTzOhbb
 foYS+f5JQOfqPbHUyLO+cgJrZiPr1eJlnlKCXm8/OWMPGrhgbBREkpR6arntlS72yhNbpH1JVna
 K9MteMphmSvxYxrDbc33WPwQZxt/SwHiyyUu2jnJJITAVFPNd8khw72jK4+XO+EMSno3zc8AsWB
 4JdctZqBjWon4GqLOjtzvuWhAq4DAUEHsWIoPGQa+RVjL2D+ybOP+gAjdKa7s3YvsplPG+PYvNh
 t7ZRDw2AQHh/L13Vrez8JlqbgumSFrHR8iWt3q1vwKA8QpfaixPspfV2TFJ1UI+0X6uK32lqINe
 ZBbe5OJnFZouDOQ==
X-Developer-Key: i=antikostya2@gmail.com; a=openpgp;
 fpr=4C0562F1DA8FA58A710F1018488AA56EA550DE76
Received-SPF: pass client-ip=2a00:1450:4864:36::11;
 envelope-from=antikostya2@gmail.com; helo=mail-lf2-x11.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

Add support of trTeInstSyncMode (with mods 0, 1 and 2) and trTeInstSyncMax

Signed-off-by: Alexei Filippov <halip0503@gmail.com>
---
 hw/riscv/rv-trace-messages.c | 28 ++++++++++++++---
 hw/riscv/rv-trace-messages.h |  3 ++
 hw/riscv/trace-encoder.c     | 75 ++++++++++++++++++++++++++++++++++++++++----
 hw/riscv/trace-encoder.h     |  9 ++++++
 4 files changed, 105 insertions(+), 10 deletions(-)

diff --git a/hw/riscv/rv-trace-messages.c b/hw/riscv/rv-trace-messages.c
index 708e48bbed..507c5fb7bf 100644
--- a/hw/riscv/rv-trace-messages.c
+++ b/hw/riscv/rv-trace-messages.c
@@ -365,10 +365,11 @@ typedef enum {
 } NTraceFieldWidth;
 
 typedef enum {
-    TCODE_PROG_TRACE_SYNC        = 0x9,
-    TCODE_PROG_TRACE_CORRELATION = 0x21,
-    TCODE_RESOURCE_FULL          = 0x1b,
-    TCODE_INDIRECT_BRANCH_HIST   = 0x1c,
+    TCODE_PROG_TRACE_SYNC           = 0x9,
+    TCODE_PROG_TRACE_CORRELATION    = 0x21,
+    TCODE_RESOURCE_FULL             = 0x1b,
+    TCODE_INDIRECT_BRANCH_HIST      = 0x1c,
+    TCODE_INDIRECT_BRANCH_HIST_SYNC = 0x1d,
 } NTraceTcodeFieldValues;
 
 typedef enum {
@@ -586,6 +587,25 @@ size_t rv_ntrace_gen_encoded_resource_full_msg(uint8_t *buf, uint32_t hist)
     return rv_ntrace_gen_encoded_msg(buf, msg_fields);
 }
 
+size_t rv_ntrace_gen_indirect_branch_hist_sync_msg(uint8_t *buf, uint8_t btype,
+                                                   uint32_t icnt, uint64_t faddr,
+                                                   uint32_t hist)
+{
+     const NTraceFieldPayload msg_fields[] = {
+        PAYLOAD_TCODE(TCODE_INDIRECT_BRANCH_HIST_SYNC),
+        /* SRC field is not supported for now */
+        PAYLOAD_SYNC(SYNC_PERIODIC),
+        PAYLOAD_BTYPE(btype),
+        PAYLOAD_ICNT(icnt),
+        PAYLOAD_FADDR(faddr),
+        PAYLOAD_HIST(hist),
+        /* TSTAMP field is not supported for now */
+        PAYLOAD_END(),
+    };
+
+    return rv_ntrace_gen_encoded_msg(buf, msg_fields);
+}
+
 size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t btype,
                                               uint32_t icnt, uint64_t uaddr,
                                               uint32_t hist)
diff --git a/hw/riscv/rv-trace-messages.h b/hw/riscv/rv-trace-messages.h
index a4d14de59a..c237e6b57c 100644
--- a/hw/riscv/rv-trace-messages.h
+++ b/hw/riscv/rv-trace-messages.h
@@ -43,6 +43,9 @@ size_t rv_ntrace_gen_encoded_prog_trace_correlation_msg(uint8_t *buf,
                                                         uint32_t icnt,
                                                         uint32_t hist);
 size_t rv_ntrace_gen_encoded_resource_full_msg(uint8_t *buf, uint32_t hist);
+size_t rv_ntrace_gen_indirect_branch_hist_sync_msg(uint8_t *buf, uint8_t btype,
+                                                   uint32_t icnt, uint64_t faddr,
+                                                   uint32_t hist);
 size_t rv_ntrace_gen_indirect_branch_hist_msg(uint8_t *buf, uint8_t btype,
                                               uint32_t icnt, uint64_t uaddr,
                                               uint32_t hist);
diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 41bb750043..dfe04781e2 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -34,9 +34,13 @@
 #define TRACE_MAX_BRANCHES 31
 
 static uint64_t rv_ntrace_encode_uaddr(TraceEncoder *trencoder, uint64_t target_pc);
+static uint64_t rv_ntrace_encode_faddr(uint64_t target_pc);
 static uint32_t rv_ntrace_encode_and_reset_branch_map(TraceEncoder *trencoder);
+static uint64_t rv_ntrace_get_sync_max_cnt(TraceEncoder *trencoder);
 static uint32_t rv_ntrace_get_and_reset_icnt(TraceEncoder *trencoder,
                                              uint64_t pc, uint32_t inst_len);
+static void rv_ntrace_update_sync_msg_cnt(TraceEncoder *trencoder);
+static void rv_ntrace_update_sync_icnt(TraceEncoder *trencoder, uint64_t icnt);
 
 static TracePrivLevel trencoder_get_curr_priv_level(TraceEncoder *te)
 {
@@ -181,10 +185,6 @@ static uint64_t trencoder_te_ctrl_set_hardwire_vals(uint64_t input)
     input = FIELD_DP32(input, TR_TE_CONTROL, INST_STALL_ENA, 0);
     input = FIELD_DP32(input, TR_TE_CONTROL, INHIBIT_SRC, 1);
 
-    /* SYNC_MODE and SYNC_MAX will be revisited */
-    input = FIELD_DP32(input, TR_TE_CONTROL, INST_SYNC_MODE, 0);
-    input = FIELD_DP32(input, TR_TE_CONTROL, INST_SYNC_MAX, 0);
-
     return input;
 }
 
@@ -196,6 +196,10 @@ static uint64_t trencoder_te_ctrl_prew(RegisterInfo *reg, uint64_t val)
     uint32_t trTeInstTracing = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL,
                                                 INST_TRACING);
     uint32_t trTeFormat = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL, FORMAT);
+    uint32_t trTeInstSyncMode = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL,
+                                                 INST_SYNC_MODE);
+    uint32_t trTeInstSyncMax = ARRAY_FIELD_EX32(te->regs, TR_TE_CONTROL,
+                                                INST_SYNC_MAX);
     uint32_t temp;
 
     val = trencoder_te_ctrl_set_hardwire_vals(val);
@@ -245,6 +249,21 @@ static uint64_t trencoder_te_ctrl_prew(RegisterInfo *reg, uint64_t val)
         val = FIELD_DP32(val, TR_TE_CONTROL, INST_TRACING, 0);
     }
 
+    temp = FIELD_EX32(val, TR_TE_CONTROL, INST_SYNC_MODE);
+    if (temp != TR_TE_INST_SYNC_MODE_OFF &&
+        temp != TR_TE_INST_SYNC_MODE_MSG &&
+        temp != TR_TE_INST_SYNC_MODE_INST) {
+        /* Only sync mods 0, 1 and 3 are supported */
+        val = FIELD_DP32(val, TR_TE_CONTROL, INST_SYNC_MODE, trTeInstSyncMode);
+    } else if (temp != trTeInstSyncMode) {
+        te->sync_cnt = 0;
+    }
+
+    temp = FIELD_EX32(val, TR_TE_CONTROL, INST_SYNC_MAX);
+    if (temp != trTeInstSyncMax) {
+        te->sync_cnt = 0;
+    }
+
     return val;
 }
 
@@ -389,6 +408,7 @@ static void trencoder_reset(DeviceState *dev)
 
     te->branch_map = 0;
     te->branches = 0;
+    te->sync_cnt = 0;
 }
 
 static void trencoder_realize(DeviceState *dev, Error **errp)
@@ -480,6 +500,7 @@ static void trencoder_send_message_smem(TraceEncoder *trencoder,
     cpu_physical_memory_write(dest, msg, msg_size);
     dest += msg_size;
 
+    rv_ntrace_update_sync_msg_cnt(trencoder);
     trencoder_update_ramsink_writep(trencoder, dest, wrapped);
 }
 
@@ -532,11 +553,21 @@ void trencoder_send_indirect_branch_hist(TraceEncoder *trencoder,
 
     uint32_t icnt = rv_ntrace_get_and_reset_icnt(trencoder, curr_pc, curr_inst_len);
     uint64_t uaddr = rv_ntrace_encode_uaddr(trencoder, target_pc);
+    uint64_t faddr = rv_ntrace_encode_faddr(target_pc);
     uint32_t hist = rv_ntrace_encode_and_reset_branch_map(trencoder);
+    uint64_t sync_max = rv_ntrace_get_sync_max_cnt(trencoder);
+    uint32_t sync = ARRAY_FIELD_EX32(trencoder->regs, TR_TE_CONTROL, INST_SYNC_MODE);
 
     g_assert(trencoder->ntrace);
 
-    msg_size = rv_ntrace_gen_indirect_branch_hist_msg(msg, btype, icnt, uaddr, hist);
+    if (sync && trencoder->sync_cnt >= sync_max) {
+        msg_size = rv_ntrace_gen_indirect_branch_hist_sync_msg(msg, btype, icnt,
+                                                               faddr, hist);
+        trencoder->sync_cnt = 0;
+    } else {
+        msg_size = rv_ntrace_gen_indirect_branch_hist_msg(msg, btype, icnt, uaddr,
+                                                          hist);
+    }
     trencoder->last_addr_reported = target_pc;
     trencoder->last_icnt_reset = target_pc;
 
@@ -621,6 +652,14 @@ static uint64_t rv_ntrace_encode_uaddr(TraceEncoder *trencoder, uint64_t target_
     return trencoder->last_addr_reported ^ target_pc;
 }
 
+static uint64_t rv_ntrace_get_sync_max_cnt(TraceEncoder *trencoder)
+{
+    uint32_t sync_max_f = ARRAY_FIELD_EX32(trencoder->regs, TR_TE_CONTROL,
+                                           INST_SYNC_MAX);
+
+    return 1 << (sync_max_f + 4);
+}
+
 static uint32_t rv_ntrace_encode_and_reset_branch_map(TraceEncoder *trencoder)
 {
     const uint32_t stop_bit = 1;
@@ -660,6 +699,26 @@ static uint32_t rv_ntrace_encode_and_reset_branch_map(TraceEncoder *trencoder)
     return hist;
 }
 
+static void rv_ntrace_update_sync_msg_cnt(TraceEncoder *trencoder)
+{
+    uint64_t sync_mode = ARRAY_FIELD_EX32(trencoder->regs, TR_TE_CONTROL,
+                                          INST_SYNC_MODE);
+
+    if (sync_mode == TR_TE_INST_SYNC_MODE_MSG) {
+        trencoder->sync_cnt++;
+    }
+}
+
+static void rv_ntrace_update_sync_icnt(TraceEncoder *trencoder, uint64_t icnt)
+{
+    uint64_t sync_mode = ARRAY_FIELD_EX32(trencoder->regs, TR_TE_CONTROL,
+                                          INST_SYNC_MODE);
+
+    if (sync_mode == TR_TE_INST_SYNC_MODE_INST) {
+        trencoder->sync_cnt += icnt;
+    }
+}
+
 static uint32_t rv_ntrace_get_and_reset_icnt(TraceEncoder *trencoder,
                                              uint64_t pc, uint32_t inst_len)
 {
@@ -674,6 +733,8 @@ static uint32_t rv_ntrace_get_and_reset_icnt(TraceEncoder *trencoder,
         error_setg(&error_fatal, "N-Trace icnt overflowed");
     }
 
+    rv_ntrace_update_sync_icnt(trencoder, icnt);
+
     return icnt;
 }
 
@@ -750,8 +811,10 @@ void trencoder_report_branch(Object *trencoder_obj, uint64_t pc,
     TraceEncoder *te = TRACE_ENCODER(trencoder_obj);
 
     if (te->ntrace && taken != BRANCH_NOT_TAKEN) {
-            te->icnt_accumulated += (pc + insn_len - te->last_icnt_reset) / 2;
+            uint64_t icnt = (pc + insn_len - te->last_icnt_reset) / 2;
+            te->icnt_accumulated += icnt;
             te->last_icnt_reset = pc + offset;
+            rv_ntrace_update_sync_icnt(te, icnt);
     }
 
     if (taken == BRANCH_TAKEN_UNCONDITIONAL) {
diff --git a/hw/riscv/trace-encoder.h b/hw/riscv/trace-encoder.h
index b3cdbf9374..4cfdb47ecf 100644
--- a/hw/riscv/trace-encoder.h
+++ b/hw/riscv/trace-encoder.h
@@ -50,6 +50,8 @@ struct TraceEncoder {
     uint64_t last_addr_reported;
     uint64_t last_icnt_reset;
     uint64_t icnt_accumulated;
+
+    uint64_t sync_cnt;
 };
 
 typedef enum {
@@ -68,6 +70,13 @@ typedef enum {
     CORRELATION_TRACE_DISABLED = 4,
 } TraceStopReason;
 
+typedef enum {
+    TR_TE_INST_SYNC_MODE_OFF    = 0,
+    TR_TE_INST_SYNC_MODE_MSG    = 1,
+    /* Mode 2(Count hart clock cycles) is not supported. */
+    TR_TE_INST_SYNC_MODE_INST   = 3,
+} TraceSyncMode;
+
 #define TYPE_TRACE_ENCODER "trace-encoder"
 
 OBJECT_DECLARE_SIMPLE_TYPE(TraceEncoder, TRACE_ENCODER)

-- 
2.43.0


