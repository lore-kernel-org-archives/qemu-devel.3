Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E129EC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2CO-0004yX-Dk; Thu, 20 Aug 2026 08:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CL-0004wg-GZ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:45 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CH-0001a5-24
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:45 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-698ae09e356so3670886a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 05:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787230119; x=1787834919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=urGLEBLmWmSdOB/1Z1ToNd9X0Ug84q6TPohTolBDGbA=;
 b=rRP5+Mz5a/zIfYU/Wf0pwsdVqu9QF9mCIoqKS7z670d8jc2CWrXDpJK4PH1pVhzU65
 Ojm7VHdTpQV1+5L2zz6dTb4XbgAQBXXelqf9wG39Vt5+tw+mmIppKxiH3wTQBT02nZjK
 nuvkM+g/FR+V8ktzAkIwt6E1lQsPn/pAc3ZjH/Llij2vTULkh6noCh4qiohZUunFKiVl
 2NBwzBdVIpiKG9YtLzqrywjYFE4/nVSaNbb5uHIKqEuZKrA8MDDecLdllay+ccTDm4wo
 qZqrYovMqaHUzhXXT1oL7V11wX7xFpjRfLzWhY/J+VqYFT8KWTKXH0OWdGpMp0iht3zC
 EoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787230119; x=1787834919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=urGLEBLmWmSdOB/1Z1ToNd9X0Ug84q6TPohTolBDGbA=;
 b=QXR/VzO+xk1aPUzSeKk2kvGZqinhZpPNqWu7TCTUnZdU9hQrgGfs2nqSToXlLB6SYu
 dRrdMJsRSV6hhEa2SxMINMemswUhu/vBpM5aZQTM3mXOY7XGrH20ctWHY2nTMrhbDeO8
 S+s1Rl4wkW28M3JEv8V2vIZk29vS8jlRydHZtH+ArxtxfZw5Jhs+v2GCUEVg8yV8LdN9
 mLdBfhSXS9bVlxQEzdjKSTYfvnrA2xb5PSjTfw6OGnFlh2UFDs3nDongYtat92NeXlwS
 iPVrbkt50b2D3a/GoqVMnI9yfKHg00yq0nmc7hshkjo1w3e/teLJXvtReKZsWkXckrJC
 fyCQ==
X-Gm-Message-State: AFuF++lCkGwVSomeuNZWibgC6KICS/75zs6MU8WojMXRgp2LGoux+2QG
 3ECFLq/ABoSvtJ63g7bMAQC28Pckd0HD268De6euewEjf4jlM2Dhv379H7HyRXE/
X-Gm-Gg: AR+sD10E2ll6Oc/e5qIpw2f++BtMhhGAzBAgNOhJXDXl6KC5k93F+HOCAbMU2Px3aVu
 Z4JewFEEjgbCjcITugpJ5dAVlZWAVQKQ3FJjyb4OqzMVXNJ2gWpSslEU/HobU2I/k49Wm83+FJ8
 vxUzJ9JDsQOQuiMPOW/oG7EQKH9xfo/KR8kgCezK3KHJrCVqf6sO1lbIKYeI14BFpHnVRr9pxHt
 6nF9aI/STPFeVJjzH0Kzl1w8OkCCnoF059OLrMoREqX1dHoc/Hql/fp751u9Tqhtw+NJoe9Ov6j
 QfDCWM4FxCnpX7SAKTelelx+FKo9wHFYPr3Aq/Z406tOtsEAiPjniA2p+ccn1nYs6RlcCHFdyHs
 i7mN/qJ6BBlxVHCDCT3cV1VNORxzbPeSkQxcKR3IAc8Aya9nGJkPAATGhorljxw9J2ziJesGyzi
 g0od9uUcgFhBpEuIN0JAMvIXuVn/BH/4Ilnqcg5pBlebPbxq0B3TaOwBueq+S92cqwMCS9i/rod
 q1WcHDxzWU=
X-Received: by 2002:a05:6402:28cd:b0:6a3:ee5c:8800 with SMTP id
 4fb4d7f45d1cf-6a4032b1629mr9777366a12.8.1787230119238; 
 Thu, 20 Aug 2026 05:48:39 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1563c5sm2270449a12.14.2026.08.20.05.48.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 05:48:38 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Wadim Mueller <wafgo01@gmail.com>
Subject: [RFC PATCH v2 08/14] hw/misc: add TI mailbox (IPC) model
Date: Thu, 20 Aug 2026 14:48:08 +0200
Message-ID: <20260820124824.618671-9-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820124824.618671-1-wafgo01@gmail.com>
References: <20260820124824.618671-1-wafgo01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=wafgo01@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add the K3 mailbox IP: per-mailbox message FIFOs and per-user interrupt
status/enable registers, used for inter-core IPC, for example between the
A53 cluster and the M4F.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 hw/misc/Kconfig              |   3 +
 hw/misc/meson.build          |   1 +
 hw/misc/ti-mailbox.c         | 566 +++++++++++++++++++++++++++++++++++
 hw/misc/trace-events         |  13 +
 include/hw/misc/ti-mailbox.h |  44 +++
 5 files changed, 627 insertions(+)
 create mode 100644 hw/misc/ti-mailbox.c
 create mode 100644 include/hw/misc/ti-mailbox.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index c176d6d6c7..e80fdc3214 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -161,6 +161,9 @@ config TI_K3_SDHCI_PHY
 config TI_K3_TRNG
     bool
 
+config TI_MAILBOX
+    bool
+
 config TZ_MPC
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 952b7b7c2f..d190d8608a 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -129,6 +129,7 @@ system_ss.add(when: 'CONFIG_TI_K3_GTC', if_true: files('ti-k3-gtc.c'))
 system_ss.add(when: 'CONFIG_TI_K3_DDRSS', if_true: files('ti-k3-ddrss.c'))
 system_ss.add(when: 'CONFIG_TI_K3_SDHCI_PHY', if_true: files('ti-k3-sdhci-phy.c'))
 system_ss.add(when: 'CONFIG_TI_K3_TRNG', if_true: files('ti-k3-trng.c'))
+system_ss.add(when: 'CONFIG_TI_MAILBOX', if_true: files('ti-mailbox.c'))
 system_ss.add(when: 'CONFIG_TZ_MPC', if_true: files('tz-mpc.c'))
 system_ss.add(when: 'CONFIG_TZ_MSC', if_true: files('tz-msc.c'))
 system_ss.add(when: 'CONFIG_TZ_PPC', if_true: files('tz-ppc.c'))
diff --git a/hw/misc/ti-mailbox.c b/hw/misc/ti-mailbox.c
new file mode 100644
index 0000000000..ba4858a226
--- /dev/null
+++ b/hw/misc/ti-mailbox.c
@@ -0,0 +1,566 @@
+/*
+ * TI AM64x/OMAP mailbox
+ *
+ * Copyright (c) 2025 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/core/sysbus.h"
+#include "qemu/module.h"
+#include "qemu/bitops.h"
+#include "hw/core/cpu.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/misc/ti-mailbox.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "hw/core/irq.h"
+#include "qom/object.h"
+
+#define TI_MAILBOX_MMIO_SIZE 0x200
+
+#define MAILBOX_REVISION 0x00
+#define MAILBOX_SYSCONFIG 0x10
+#define MAILBOX_MESSAGE_BASE 0x40
+#define MAILBOX_FIFO_STATUS_BASE 0x80
+#define MAILBOX_MSG_STATUS_BASE 0xC0
+#define MAILBOX_IRQ_RAW_BASE 0x100
+#define MAILBOX_IRQ_CLR_BASE 0x104
+#define MAILBOX_IRQ_EN_SET_BASE 0x108
+#define MAILBOX_IRQ_EN_CLR_BASE 0x10C
+#define MAILBOX_IRQ_STRIDE 0x10
+#define MAILBOX_IRQ_EOI 0x140
+
+
+static uint32_t ti_mailbox_hw_raw_status(const TIMailboxState *s)
+{
+    uint32_t raw = 0;
+
+    for (int i = 0; i < TI_MAILBOX_NUM_MBOX; i++) {
+        const Fifo32 *f = &s->mbox[i];
+        uint32_t count = fifo32_num_used((Fifo32 *)f);
+
+        if (count > 0) {
+            raw |= BIT(i * 2);
+        }
+        if (count < s->fifo_depth) {
+            raw |= BIT(i * 2 + 1);
+        }
+    }
+
+    return raw;
+}
+
+static void ti_mailbox_update_irqs(TIMailboxState *s)
+{
+    uint32_t hw_raw = ti_mailbox_hw_raw_status(s);
+
+    for (int user = 0; user < s->num_users; user++) {
+        TIMailboxUser *u = &s->users[user];
+        uint32_t raw = (hw_raw & ~u->raw_clear_mask) | u->raw_set;
+        uint32_t masked = raw & u->irq_enable;
+        trace_ti_mailbox_irq_eval(s->mailbox_id, user, hw_raw, raw,
+                                  u->irq_enable, masked);
+        bool level = masked != 0;
+        if (level != u->irq_level) {
+            trace_ti_mailbox_irq(s->mailbox_id, user, level, raw, u->irq_enable,
+                                 masked);
+            u->irq_level = level;
+        }
+        qemu_set_irq(u->irq, level);
+    }
+}
+
+static bool ti_mailbox_fifo_push(TIMailboxState *s, int mb, uint32_t val)
+{
+    Fifo32 *f = &s->mbox[mb];
+    uint32_t used_before = fifo32_num_used(f);
+    bool ok = used_before < s->fifo_depth;
+
+    if (ok) {
+        fifo32_push(f, val);
+    }
+    trace_ti_mailbox_fifo_push(s->mailbox_id, mb, s->fifo_depth, used_before,
+                               val, ok);
+    return ok;
+}
+
+static bool ti_mailbox_fifo_pop(TIMailboxState *s, int mb, uint32_t *val)
+{
+    Fifo32 *f = &s->mbox[mb];
+    uint32_t used_before = fifo32_num_used(f);
+    bool ok = !fifo32_is_empty(f);
+    uint32_t out = 0;
+
+    if (ok) {
+        out = fifo32_pop(f);
+    }
+    if (val) {
+        *val = out;
+    }
+    trace_ti_mailbox_fifo_pop(s->mailbox_id, mb, s->fifo_depth, used_before,
+                              out, ok);
+    return ok;
+}
+
+static void ti_mailbox_fmt_opt_int(char *buf, size_t len, const char *key,
+                                   int value)
+{
+    if (value < 0) {
+        buf[0] = '\0';
+        return;
+    }
+
+    snprintf(buf, len, " %s=%d", key, value);
+}
+
+static void ti_mailbox_fmt_cpu(char *buf, size_t len)
+{
+    if (!current_cpu) {
+        snprintf(buf, len, " cpu=?");
+        return;
+    }
+
+    snprintf(buf, len, " cpu=%s:%d", object_get_typename(OBJECT(current_cpu)),
+             current_cpu->cpu_index);
+}
+
+static void ti_mailbox_irq_bits_to_str(uint32_t val, char *buf, size_t len)
+{
+    size_t pos = 0;
+    bool first = true;
+
+    for (int bit = 0; bit < TI_MAILBOX_NUM_MBOX * 2; bit++) {
+        if (!(val & BIT(bit))) {
+            continue;
+        }
+        if (pos < len) {
+            int mbox = bit / 2;
+            const char *event = (bit % 2 == 0) ? "newmsg" : "notfull";
+            int n = snprintf(buf + pos, len - pos, "%s%s:%d", first ? "" : ",",
+                             event, mbox);
+            if (n < 0 || (size_t)n >= len - pos) {
+                pos = len - 1;
+                break;
+            }
+            pos += n;
+            first = false;
+        }
+    }
+
+    if (first) {
+        g_strlcpy(buf, "-", len);
+    }
+}
+
+static const char *ti_mailbox_reg_name(hwaddr off, int *mbox, int *user)
+{
+    *mbox = -1;
+    *user = -1;
+
+    switch (off) {
+    case MAILBOX_REVISION:
+        return "MAILBOX_REVISION";
+    case MAILBOX_SYSCONFIG:
+        return "MAILBOX_SYSCONFIG";
+    case MAILBOX_IRQ_EOI:
+        return "MAILBOX_IRQ_EOI";
+    default:
+        break;
+    }
+
+    if (off >= MAILBOX_MESSAGE_BASE &&
+        off < MAILBOX_MESSAGE_BASE + TI_MAILBOX_NUM_MBOX * 4) {
+        *mbox = (off - MAILBOX_MESSAGE_BASE) / 4;
+        return "MAILBOX_MESSAGE_y";
+    }
+
+    if (off >= MAILBOX_FIFO_STATUS_BASE &&
+        off < MAILBOX_FIFO_STATUS_BASE + TI_MAILBOX_NUM_MBOX * 4) {
+        *mbox = (off - MAILBOX_FIFO_STATUS_BASE) / 4;
+        return "MAILBOX_FIFO_STATUS_y";
+    }
+
+    if (off >= MAILBOX_MSG_STATUS_BASE &&
+        off < MAILBOX_MSG_STATUS_BASE + TI_MAILBOX_NUM_MBOX * 4) {
+        *mbox = (off - MAILBOX_MSG_STATUS_BASE) / 4;
+        return "MAILBOX_MSG_STATUS_y";
+    }
+
+    if (off >= MAILBOX_IRQ_RAW_BASE &&
+        off < MAILBOX_IRQ_RAW_BASE +
+                  TI_MAILBOX_NUM_USERS_MAX * MAILBOX_IRQ_STRIDE) {
+        int rel;
+
+        *user = (off - MAILBOX_IRQ_RAW_BASE) / MAILBOX_IRQ_STRIDE;
+        rel = (off - MAILBOX_IRQ_RAW_BASE) % MAILBOX_IRQ_STRIDE;
+        switch (rel) {
+        case 0:
+            return "MAILBOX_IRQ_STATUS_RAW_j";
+        case 4:
+            return "MAILBOX_IRQ_STATUS_CLR_j";
+        case 8:
+            return "MAILBOX_IRQ_ENABLE_SET_j";
+        case 0x0C:
+            return "MAILBOX_IRQ_ENABLE_CLR_j";
+        default:
+            return "MAILBOX_IRQ_UNKNOWN";
+        }
+    }
+
+    return "UNKNOWN";
+}
+
+static uint64_t ti_mailbox_read(void *opaque, hwaddr off, unsigned size)
+{
+    TIMailboxState *s = opaque;
+    uint32_t hw_raw;
+    uint32_t raw;
+    uint32_t val;
+    int mb;
+    int user;
+
+    (void)size;
+
+#define TI_MAILBOX_TRACE_READ(_val)                                            \
+    do {                                                                       \
+        char irq_bits[64];                                                     \
+        char trace_cpu_str[64];                                                \
+        char trace_mbox_str[24];                                               \
+        char trace_user_str[24];                                               \
+        char trace_bits_str[96];                                               \
+        int trace_mbox;                                                        \
+        int trace_user;                                                        \
+        const char *trace_reg =                                                \
+            ti_mailbox_reg_name(off, &trace_mbox, &trace_user);                \
+        const char *trace_bits = "-";                                          \
+        const char *trace_bits_strp = "";                                      \
+        if (!strcmp(trace_reg, "MAILBOX_IRQ_STATUS_RAW_j") ||                  \
+            !strcmp(trace_reg, "MAILBOX_IRQ_STATUS_CLR_j") ||                  \
+            !strcmp(trace_reg, "MAILBOX_IRQ_ENABLE_SET_j") ||                  \
+            !strcmp(trace_reg, "MAILBOX_IRQ_ENABLE_CLR_j")) {                  \
+            ti_mailbox_irq_bits_to_str((uint32_t)(_val), irq_bits,             \
+                                       sizeof(irq_bits));                      \
+            trace_bits = irq_bits;                                             \
+            snprintf(trace_bits_str, sizeof(trace_bits_str), " irq_bits=%s",   \
+                     trace_bits);                                              \
+            trace_bits_strp = trace_bits_str;                                  \
+        }                                                                      \
+        ti_mailbox_fmt_cpu(trace_cpu_str, sizeof(trace_cpu_str));              \
+        ti_mailbox_fmt_opt_int(trace_mbox_str, sizeof(trace_mbox_str), "mbox", \
+                               trace_mbox);                                    \
+        ti_mailbox_fmt_opt_int(trace_user_str, sizeof(trace_user_str), "user", \
+                               trace_user);                                    \
+        trace_ti_mailbox_read(                                                 \
+            (uint64_t)off, (uint32_t)(_val), size, trace_reg, s->mailbox_id,   \
+            trace_cpu_str, trace_mbox_str, trace_user_str, trace_bits_strp);   \
+        return (_val);                                                         \
+    } while (0)
+
+    switch (off) {
+    case MAILBOX_REVISION:
+        TI_MAILBOX_TRACE_READ(0x66FC8900);
+    case MAILBOX_SYSCONFIG:
+        TI_MAILBOX_TRACE_READ(0);
+    case MAILBOX_IRQ_EOI:
+        TI_MAILBOX_TRACE_READ(0);
+    default:
+        break;
+    }
+
+    if (off >= MAILBOX_MESSAGE_BASE &&
+        off < MAILBOX_MESSAGE_BASE + TI_MAILBOX_NUM_MBOX * 4) {
+        mb = (off - MAILBOX_MESSAGE_BASE) / 4;
+        if (!ti_mailbox_fifo_pop(s, mb, &val)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: read empty mailbox %d\n",
+                          TYPE_TI_MAILBOX, mb);
+            TI_MAILBOX_TRACE_READ(0);
+        }
+        ti_mailbox_update_irqs(s);
+        TI_MAILBOX_TRACE_READ(val);
+    }
+
+    if (off >= MAILBOX_FIFO_STATUS_BASE &&
+        off < MAILBOX_FIFO_STATUS_BASE + TI_MAILBOX_NUM_MBOX * 4) {
+        mb = (off - MAILBOX_FIFO_STATUS_BASE) / 4;
+        TI_MAILBOX_TRACE_READ(
+            fifo32_num_used(&s->mbox[mb]) >= s->fifo_depth ? 1 : 0);
+    }
+
+    if (off >= MAILBOX_MSG_STATUS_BASE &&
+        off < MAILBOX_MSG_STATUS_BASE + TI_MAILBOX_NUM_MBOX * 4) {
+        mb = (off - MAILBOX_MSG_STATUS_BASE) / 4;
+        TI_MAILBOX_TRACE_READ(fifo32_num_used(&s->mbox[mb]) & 0x7);
+    }
+
+    if (off >= MAILBOX_IRQ_RAW_BASE &&
+        off < MAILBOX_IRQ_RAW_BASE +
+                  TI_MAILBOX_NUM_USERS_MAX * MAILBOX_IRQ_STRIDE) {
+        user = (off - MAILBOX_IRQ_RAW_BASE) / MAILBOX_IRQ_STRIDE;
+        if (user >= s->num_users) {
+            TI_MAILBOX_TRACE_READ(0);
+        }
+        hw_raw = ti_mailbox_hw_raw_status(s);
+        raw =
+            (hw_raw & ~s->users[user].raw_clear_mask) | s->users[user].raw_set;
+        if ((off - MAILBOX_IRQ_RAW_BASE) % MAILBOX_IRQ_STRIDE == 0) {
+            TI_MAILBOX_TRACE_READ(raw);
+        }
+        if ((off - MAILBOX_IRQ_RAW_BASE) % MAILBOX_IRQ_STRIDE == 4) {
+            TI_MAILBOX_TRACE_READ(raw & s->users[user].irq_enable);
+        }
+        if ((off - MAILBOX_IRQ_RAW_BASE) % MAILBOX_IRQ_STRIDE == 8) {
+            TI_MAILBOX_TRACE_READ(s->users[user].irq_enable);
+        }
+        if ((off - MAILBOX_IRQ_RAW_BASE) % MAILBOX_IRQ_STRIDE == 0x0C) {
+            TI_MAILBOX_TRACE_READ(s->users[user].irq_enable);
+        }
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: invalid read offset 0x%" HWADDR_PRIx "\n",
+                  TYPE_TI_MAILBOX, off);
+    TI_MAILBOX_TRACE_READ(0);
+
+#undef TI_MAILBOX_TRACE_READ
+}
+
+static void ti_mailbox_write(void *opaque, hwaddr off, uint64_t val,
+                             unsigned size)
+{
+    TIMailboxState *s = opaque;
+    int mb;
+    int user;
+    int rel;
+
+    (void)size;
+
+    {
+        char irq_bits[64];
+        char trace_cpu_str[64];
+        char trace_mbox_str[24];
+        char trace_user_str[24];
+        char trace_bits_str[96];
+        int trace_mbox;
+        int trace_user;
+        const char *trace_reg =
+            ti_mailbox_reg_name(off, &trace_mbox, &trace_user);
+        const char *trace_bits = "-";
+        const char *trace_bits_strp = "";
+
+        if (!strcmp(trace_reg, "MAILBOX_IRQ_STATUS_RAW_j") ||
+            !strcmp(trace_reg, "MAILBOX_IRQ_STATUS_CLR_j") ||
+            !strcmp(trace_reg, "MAILBOX_IRQ_ENABLE_SET_j") ||
+            !strcmp(trace_reg, "MAILBOX_IRQ_ENABLE_CLR_j")) {
+            ti_mailbox_irq_bits_to_str((uint32_t)val, irq_bits,
+                                       sizeof(irq_bits));
+            trace_bits = irq_bits;
+            snprintf(trace_bits_str, sizeof(trace_bits_str), " irq_bits=%s",
+                     trace_bits);
+            trace_bits_strp = trace_bits_str;
+        }
+
+        ti_mailbox_fmt_cpu(trace_cpu_str, sizeof(trace_cpu_str));
+        ti_mailbox_fmt_opt_int(trace_mbox_str, sizeof(trace_mbox_str), "mbox",
+                               trace_mbox);
+        ti_mailbox_fmt_opt_int(trace_user_str, sizeof(trace_user_str), "user",
+                               trace_user);
+        trace_ti_mailbox_write((uint64_t)off, (uint32_t)val, size, trace_reg,
+                               s->mailbox_id, trace_cpu_str, trace_mbox_str,
+                               trace_user_str, trace_bits_strp);
+    }
+
+    switch (off) {
+    case MAILBOX_SYSCONFIG:
+        if (val & 0x1) {
+            for (int i = 0; i < TI_MAILBOX_NUM_MBOX; i++) {
+                fifo32_reset(&s->mbox[i]);
+            }
+            for (int i = 0; i < s->num_users; i++) {
+                TIMailboxUser *u = &s->users[i];
+
+                u->irq_enable = 0;
+                u->raw_set = 0;
+                u->raw_clear_mask = 0;
+            }
+            ti_mailbox_update_irqs(s);
+        }
+        return;
+    case MAILBOX_IRQ_EOI:
+        return;
+    default:
+        break;
+    }
+
+    if (off >= MAILBOX_MESSAGE_BASE &&
+        off < MAILBOX_MESSAGE_BASE + TI_MAILBOX_NUM_MBOX * 4) {
+        mb = (off - MAILBOX_MESSAGE_BASE) / 4;
+        {
+            char trace_cpu_str[64];
+            uint64_t pc = current_cpu
+                              ? (uint64_t)current_cpu->cc->get_pc(current_cpu)
+                              : 0;
+
+            ti_mailbox_fmt_cpu(trace_cpu_str, sizeof(trace_cpu_str));
+            trace_ti_mailbox_msg_write_pc(s->mailbox_id, mb, pc, trace_cpu_str);
+        }
+        if (!ti_mailbox_fifo_push(s, mb, (uint32_t)val)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: mailbox %d full\n",
+                          TYPE_TI_MAILBOX, mb);
+            return;
+        }
+        ti_mailbox_update_irqs(s);
+        return;
+    }
+
+    if (off >= MAILBOX_IRQ_RAW_BASE &&
+        off < MAILBOX_IRQ_RAW_BASE +
+                  TI_MAILBOX_NUM_USERS_MAX * MAILBOX_IRQ_STRIDE) {
+        user = (off - MAILBOX_IRQ_RAW_BASE) / MAILBOX_IRQ_STRIDE;
+        if (user >= s->num_users) {
+            return;
+        }
+        rel = (off - MAILBOX_IRQ_RAW_BASE) % MAILBOX_IRQ_STRIDE;
+        uint32_t mask = (uint32_t)val;
+
+        if (rel == 0) {
+            if (mask == 0) {
+                return;
+            }
+            s->users[user].raw_set |= mask;
+            trace_ti_mailbox_raw_set(s->mailbox_id, user, mask,
+                                     s->users[user].raw_set);
+            ti_mailbox_update_irqs(s);
+            return;
+        }
+        if (rel == 4) {
+            if (mask == 0) {
+                return;
+            }
+            s->users[user].raw_set &= ~mask;
+            s->users[user].raw_clear_mask &= ~mask;
+            trace_ti_mailbox_raw_clear(s->mailbox_id, user, mask,
+                                       s->users[user].raw_set,
+                                       s->users[user].raw_clear_mask);
+            ti_mailbox_update_irqs(s);
+            return;
+        }
+        if (rel == 8) {
+            s->users[user].irq_enable |= mask;
+            trace_ti_mailbox_irq_enable(s->mailbox_id, user, 1, mask,
+                                        s->users[user].irq_enable);
+            ti_mailbox_update_irqs(s);
+            return;
+        }
+        if (rel == 0x0C) {
+            s->users[user].irq_enable &= ~mask;
+            trace_ti_mailbox_irq_enable(s->mailbox_id, user, 0, mask,
+                                        s->users[user].irq_enable);
+            ti_mailbox_update_irqs(s);
+            return;
+        }
+    }
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "%s: invalid write offset 0x%" HWADDR_PRIx "\n",
+                  TYPE_TI_MAILBOX, off);
+}
+
+static const MemoryRegionOps ti_mailbox_ops = {
+    .read = ti_mailbox_read,
+    .write = ti_mailbox_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static void ti_mailbox_reset(DeviceState *dev)
+{
+    TIMailboxState *s = TI_MAILBOX(dev);
+
+    trace_ti_mailbox_reset_state(s->mailbox_id);
+    for (int i = 0; i < TI_MAILBOX_NUM_MBOX; i++) {
+        fifo32_reset(&s->mbox[i]);
+    }
+    for (int i = 0; i < s->num_users; i++) {
+        TIMailboxUser *u = &s->users[i];
+
+        u->irq_enable = 0;
+        u->raw_set = 0;
+        u->raw_clear_mask = 0;
+        u->irq_level = false;
+    }
+
+    ti_mailbox_update_irqs(s);
+}
+
+static void ti_mailbox_realize(DeviceState *dev, Error **errp)
+{
+    TIMailboxState *s = TI_MAILBOX(dev);
+
+    if (s->num_users == 0 || s->num_users > TI_MAILBOX_NUM_USERS_MAX) {
+        error_setg(errp, "num-users must be between 1 and %u",
+                   TI_MAILBOX_NUM_USERS_MAX);
+        return;
+    }
+
+    if (s->fifo_depth == 0 || s->fifo_depth > TI_MAILBOX_FIFO_DEPTH_MAX) {
+        error_setg(errp, "fifo-depth must be between 1 and %u",
+                   TI_MAILBOX_FIFO_DEPTH_MAX);
+        return;
+    }
+
+    for (int i = 0; i < TI_MAILBOX_NUM_MBOX; i++) {
+        fifo32_create(&s->mbox[i], s->fifo_depth);
+    }
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &ti_mailbox_ops, s,
+                          TYPE_TI_MAILBOX, TI_MAILBOX_MMIO_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
+
+    for (int i = 0; i < s->num_users; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->users[i].irq);
+    }
+}
+
+static void ti_mailbox_finalize(Object *obj)
+{
+    TIMailboxState *s = TI_MAILBOX(obj);
+
+    for (int i = 0; i < TI_MAILBOX_NUM_MBOX; i++) {
+        fifo32_destroy(&s->mbox[i]);
+    }
+}
+
+static const Property ti_mailbox_properties[] = {
+    DEFINE_PROP_UINT8("num-users", TIMailboxState, num_users,
+                      TI_MAILBOX_NUM_USERS_DEFAULT),
+    DEFINE_PROP_UINT8("fifo-depth", TIMailboxState, fifo_depth,
+                      TI_MAILBOX_FIFO_DEPTH_DEFAULT),
+    DEFINE_PROP_UINT8("mailbox-id", TIMailboxState, mailbox_id, 0),
+};
+
+static void ti_mailbox_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_legacy_reset(dc, ti_mailbox_reset);
+    dc->realize = ti_mailbox_realize;
+    dc->user_creatable = false;
+    device_class_set_props(dc, ti_mailbox_properties);
+}
+
+static const TypeInfo ti_mailbox_types[] = {
+    {
+    .name = TYPE_TI_MAILBOX,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TIMailboxState),
+    .class_init = ti_mailbox_class_init,
+    .instance_finalize = ti_mailbox_finalize,
+    }
+};
+
+DEFINE_TYPES(ti_mailbox_types)
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index fae1f90ee2..ea7cde021e 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -69,6 +69,19 @@ ecc_diag_mem_readb(uint64_t addr, uint32_t ret) "Read diagnostic %"PRId64"= 0x%0
 # empty_slot.c
 empty_slot_write(uint64_t addr, unsigned width, uint64_t value, unsigned size, const char *name) "wr addr:0x%04"PRIx64" data:0x%0*"PRIx64" size %u [%s]"
 
+# ti-mailbox.c
+ti_mailbox_read(uint64_t offset, uint32_t value, unsigned size, const char *reg, uint8_t mailbox_id, const char *cpu_str, const char *mbox_str, const char *user_str, const char *irq_bits_str) "off=0x%" PRIx64 " value=0x%08x size=%u reg=%s mailbox_id=%u%s%s%s%s"
+ti_mailbox_write(uint64_t offset, uint32_t value, unsigned size, const char *reg, uint8_t mailbox_id, const char *cpu_str, const char *mbox_str, const char *user_str, const char *irq_bits_str) "off=0x%" PRIx64 " value=0x%08x size=%u reg=%s mailbox_id=%u%s%s%s%s"
+ti_mailbox_irq(uint8_t mailbox_id, uint8_t user, int level, uint32_t raw, uint32_t enable, uint32_t masked) "mailbox_id=%u user=%u level=%d raw=0x%08x enable=0x%08x masked=0x%08x"
+ti_mailbox_irq_eval(uint8_t mailbox_id, uint8_t user, uint32_t hw_raw, uint32_t raw, uint32_t enable, uint32_t masked) "mailbox_id=%u user=%u hw_raw=0x%08x raw=0x%08x enable=0x%08x masked=0x%08x"
+ti_mailbox_fifo_push(uint8_t mailbox_id, int mbox, uint8_t depth, uint32_t used_before, uint32_t val, int ok) "mailbox_id=%u mbox=%d depth=%u used_before=%u val=0x%08x ok=%d"
+ti_mailbox_fifo_pop(uint8_t mailbox_id, int mbox, uint8_t depth, uint32_t used_before, uint32_t val, int ok) "mailbox_id=%u mbox=%d depth=%u used_before=%u val=0x%08x ok=%d"
+ti_mailbox_reset_state(uint8_t mailbox_id) "mailbox_id=%u reset"
+ti_mailbox_raw_set(uint8_t mailbox_id, uint8_t user, uint32_t mask, uint32_t raw_set) "mailbox_id=%u user=%u mask=0x%08x raw_set=0x%08x"
+ti_mailbox_raw_clear(uint8_t mailbox_id, uint8_t user, uint32_t mask, uint32_t raw_set, uint32_t raw_clear_mask) "mailbox_id=%u user=%u mask=0x%08x raw_set=0x%08x raw_clear_mask=0x%08x"
+ti_mailbox_irq_enable(uint8_t mailbox_id, uint8_t user, int set, uint32_t mask, uint32_t irq_enable) "mailbox_id=%u user=%u set=%d mask=0x%08x irq_enable=0x%08x"
+ti_mailbox_msg_write_pc(uint8_t mailbox_id, int mbox, uint64_t pc, const char *cpu_str) "mailbox_id=%u mbox=%d pc=0x%" PRIx64 "%s"
+
 # slavio_misc.c
 slavio_misc_update_irq_raise(void) "Raise IRQ"
 slavio_misc_update_irq_lower(void) "Lower IRQ"
diff --git a/include/hw/misc/ti-mailbox.h b/include/hw/misc/ti-mailbox.h
new file mode 100644
index 0000000000..9cfc3b8fc2
--- /dev/null
+++ b/include/hw/misc/ti-mailbox.h
@@ -0,0 +1,44 @@
+/*
+ * TI mailbox (IPC)
+ *
+ * Copyright (c) 2025 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TI_MAILBOX_H
+#define TI_MAILBOX_H
+
+#include "qemu/fifo32.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_TI_MAILBOX "ti-mailbox"
+OBJECT_DECLARE_SIMPLE_TYPE(TIMailboxState, TI_MAILBOX)
+
+#define TI_MAILBOX_NUM_MBOX 16
+#define TI_MAILBOX_NUM_USERS_MAX 4
+#define TI_MAILBOX_NUM_USERS_DEFAULT 4
+#define TI_MAILBOX_FIFO_DEPTH_MAX 4
+#define TI_MAILBOX_FIFO_DEPTH_DEFAULT 4
+
+typedef struct TIMailboxUser {
+    uint32_t irq_enable;
+    uint32_t raw_set;
+    uint32_t raw_clear_mask;
+    bool irq_level;
+    qemu_irq irq;
+} TIMailboxUser;
+
+struct TIMailboxState {
+    SysBusDevice parent_obj;
+    MemoryRegion iomem;
+    Fifo32 mbox[TI_MAILBOX_NUM_MBOX];
+    TIMailboxUser users[TI_MAILBOX_NUM_USERS_MAX];
+    uint8_t num_users;
+    uint8_t fifo_depth;
+    uint8_t mailbox_id;
+};
+
+#endif
-- 
2.43.0


