Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFD4C56206
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtS7s-0005rg-Ux; Fri, 20 Feb 2026 10:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS2b-0008Su-LC; Fri, 20 Feb 2026 10:03:37 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS2X-0002MY-NM; Fri, 20 Feb 2026 10:03:36 -0500
DKIM-Signature: a=rsa-sha256; bh=rBS2TnP2vkOrMgY4ViNjdaynesZqm+FvW1XBTRD4iP8=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1771599792; v=1;
 b=oHlR8Dpfn5QNDn8gFtZinQQoBDvBgcmkTVj14/cC6oRIbFilDxFg+8pjSFOxGdg1zg/bGAXw
 bD60U26bvzrDRsa+X0gzVw5icKo6n6eioIZ+KX/4YaC2h4iTH7DIDW4J667baCTXG3zp5XOD3A5
 4PwqO4WTsIR7Y3k4Dz43oXAXzad+DAL9qyGauBfoaaZ46IbXz/v49F/NX8JfVcT3CNnBSkzh18u
 1o5EuriFxUFcJly7Kwd7n9wwOpHAkLOGnSClpDNFe+Yx8iZilFKWXAC+eSiklzOrCM83KonDk33
 uKo0SUF0dHwmVq6VKX5sd1fQBddtl7SU0teWkLo6E5AXw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 4A9AF25026;
 Fri, 20 Feb 2026 15:03:12 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Thu, 16 Feb 2023 17:11:22 +0100
Subject: [PATCH qemu 11/11] [ot] hw/riscv, hw/opentitan: add Opentitan Alert
 handler device
Message-ID: <177159976712.8279.7732381632410882915-11@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <177159976712.8279.7732381632410882915-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Daniel =?utf-8?q?P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 lowRISC <qemu-maintainers@lowrisc.org>, nabihestefan@google.com,
 Amit Kumar-Hermosillo <amitkh@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 20 Feb 2026 10:09:01 -0500
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
Reply-To: ~lexbaileylowrisc <lex.bailey@lowrisc.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Emmanuel Blot <eblot@rivosinc.com>

Signed-off-by: Lex Bailey <lex.bailey@lowrisc.org>

Includes existing MIT licenced code (already published elsewhere)
---
 hw/opentitan/Kconfig            |   2 +
 hw/opentitan/meson.build        |   1 +
 hw/opentitan/ot_alert.c         | 668 ++++++++++++++++++++++++++++++++
 hw/opentitan/trace-events       |   5 +
 hw/riscv/Kconfig                |   1 +
 hw/riscv/ibex_common.c          |   2 +-
 hw/riscv/ot_earlgrey.c          |  11 +-
 include/hw/opentitan/ot_alert.h |  23 ++
 include/hw/riscv/ibex_irq.h     |   6 +-
 9 files changed, 712 insertions(+), 7 deletions(-)
 create mode 100644 hw/opentitan/ot_alert.c
 create mode 100644 include/hw/opentitan/ot_alert.h

diff --git a/hw/opentitan/Kconfig b/hw/opentitan/Kconfig
index 6bd1855a84..6e9aa833b4 100644
--- a/hw/opentitan/Kconfig
+++ b/hw/opentitan/Kconfig
@@ -1,2 +1,4 @@
 # OpenTitan devices
=20
+config OT_ALERT
+    bool
diff --git a/hw/opentitan/meson.build b/hw/opentitan/meson.build
index 6bd1855a84..d24aae88fd 100644
--- a/hw/opentitan/meson.build
+++ b/hw/opentitan/meson.build
@@ -1,2 +1,3 @@
 # OpenTitan devices
=20
+system_ss.add(when: 'CONFIG_OT_ALERT', if_true: files('ot_alert.c'))
diff --git a/hw/opentitan/ot_alert.c b/hw/opentitan/ot_alert.c
new file mode 100644
index 0000000000..b864fda0fa
--- /dev/null
+++ b/hw/opentitan/ot_alert.c
@@ -0,0 +1,668 @@
+/*
+ * QEMU OpenTitan Alert handler device
+ *
+ * Copyright (c) 2023-2025 Rivos, Inc.
+ *
+ * Author(s):
+ *  Emmanuel Blot <eblot@rivosinc.com>
+ *
+ * SPDX-License-Identifier: MIT
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/guest-random.h"
+#include "qemu/log.h"
+#include "qemu/main-loop.h"
+#include "qemu/timer.h"
+#include "qemu/typedefs.h"
+#include "qapi/error.h"
+#include "hw/opentitan/ot_alert.h"
+#include "hw/core/qdev-properties-system.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/registerfields.h"
+#include "hw/riscv/ibex_common.h"
+#include "hw/riscv/ibex_irq.h"
+#include "hw/core/sysbus.h"
+#include "trace.h"
+
+#define PARAM_N_ALERTS    65u
+#define PARAM_N_LPG       24u
+#define PARAM_N_LPG_WIDTH 5u
+#define PARAM_ESC_CNT_DW  32u
+#define PARAM_ACCU_CNT_DW 16u
+#define PARAM_N_CLASSES   4u
+#define PARAM_N_ESC_SEV   4u
+#define PARAM_N_PHASES    4u
+#define PARAM_N_LOC_ALERT 7u
+#define PARAM_PING_CNT_DW 16u
+#define PARAM_PHASE_DW    2u
+#define PARAM_CLASS_DW    2u
+
+/* clang-format off */
+REG32(INTR_STATE, 0x0u)
+    SHARED_FIELD(INTR_STATE_CLASSA, 0u, 1u)
+    SHARED_FIELD(INTR_STATE_CLASSB, 1u, 1u)
+    SHARED_FIELD(INTR_STATE_CLASSC, 2u, 1u)
+    SHARED_FIELD(INTR_STATE_CLASSD, 3u, 1u)
+REG32(INTR_ENABLE, 0x4u)
+REG32(INTR_TEST, 0x8u)
+REG32(PING_TIMER_REGWEN, 0xcu)
+    FIELD(PING_TIMER_REGWEN, EN, 0u, 1u)
+REG32(PING_TIMEOUT_CYC_SHADOWED, 0x10u)
+    FIELD(PING_TIMEOUT_CYC_SHADOWED, VAL, 0u, 16u)
+REG32(PING_TIMER_EN_SHADOWED, 0x14u)
+    FIELD(PING_TIMER_EN_SHADOWED, EN, 0u, 1u)
+REG32(ALERT_REGWEN, 0x18u)
+    SHARED_FIELD(ALERT_REGWEN_EN, 0u, 1u)
+REG32(ALERT_EN_SHADOWED, 0x11cu)
+    SHARED_FIELD(ALERT_EN_SHADOWED_EN, 0u, 1u)
+REG32(ALERT_CLASS_SHADOWED, 0x220u)
+    SHARED_FIELD(ALERT_CLASS_SHADOWED_EN, 0u, 2u)
+REG32(ALERT_CAUSE, 0x324u)
+    SHARED_FIELD(ALERT_CAUSE_EN, 0u, 1u)
+REG32(LOC_ALERT_REGWEN, 0x428u)
+    SHARED_FIELD(LOC_ALERT_REGWEN_EN, 0u, 1u)
+REG32(LOC_ALERT_EN_SHADOWED, 0x444u)
+    SHARED_FIELD(LOC_ALERT_EN_SHADOWED_EN, 0u, 1u)
+REG32(LOC_ALERT_CLASS_SHADOWED, 0x460u)
+    SHARED_FIELD(LOC_ALERT_CLASS_SHADOWED_EN, 0u, 2u)
+REG32(LOC_ALERT_CAUSE, 0x47cu)
+    SHARED_FIELD(LOC_ALERT_CAUSE_EN, 0u, 1u)
+REG32(CLASS_REGWEN, 0x498u)
+    FIELD(CLASS_REGWEN, EN, 0u, 1u)
+REG32(CLASS_CTRL_SHADOWED, 0x49cu)
+    SHARED_FIELD(CLASS_CTRL_SHADOWED_EN, 0u, 1u)
+    SHARED_FIELD(CLASS_CTRL_SHADOWED_LOCK, 1u, 1u)
+    SHARED_FIELD(CLASS_CTRL_SHADOWED_EN_E0, 2u, 1u)
+    SHARED_FIELD(CLASS_CTRL_SHADOWED_EN_E1, 3u, 1u)
+    SHARED_FIELD(CLASS_CTRL_SHADOWED_EN_E2, 4u, 1u)
+    SHARED_FIELD(CLASS_CTRL_SHADOWED_EN_E3, 5u, 1u)
+    SHARED_FIELD(CLASS_CTRL_SHADOWED_MAP_E0, 6u, 2u)
+    SHARED_FIELD(CLASS_CTRL_SHADOWED_MAP_E1, 8u, 2u)
+    SHARED_FIELD(CLASS_CTRL_SHADOWED_MAP_E2, 10u, 2u)
+    SHARED_FIELD(CLASS_CTRL_SHADOWED_MAP_E3, 12u, 2u)
+REG32(CLASS_CLR_REGWEN, 0x4a0u)
+    SHARED_FIELD(CLASS_CLR_REGWEN_EN, 0u, 1u)
+REG32(CLASS_CLR_SHADOWED, 0x4a4u)
+    SHARED_FIELD(CLASS_CLR_SHADOWED_EN, 0u, 1u)
+REG32(CLASS_ACCUM_CNT, 0x4a8u)
+    SHARED_FIELD(CLASS_ACCUM_CNT, 0u, 16u)
+REG32(CLASS_ACCUM_THRESH_SHADOWED, 0x4acu)
+    SHARED_FIELD(CLASS_ACCUM_THRESH_SHADOWED, 0u, 16u)
+REG32(CLASS_TIMEOUT_CYC_SHADOWED, 0x4b0u)
+REG32(CLASS_CRASHDUMP_TRIGGER_SHADOWED, 0x4b4u)
+    SHARED_FIELD(CLASS_CRASHDUMP_TRIGGER_SHADOWED, 0u, 2u)
+REG32(CLASS_PHASE0_CYC_SHADOWED, 0x4b8u)
+REG32(CLASS_PHASE1_CYC_SHADOWED, 0x4bcu)
+REG32(CLASS_PHASE2_CYC_SHADOWED, 0x4c0u)
+REG32(CLASS_PHASE3_CYC_SHADOWED, 0x4c4u)
+REG32(CLASS_ESC_CNT, 0x4c8u)
+REG32(CLASS_STATE, 0x4ccu)
+    FIELD(CLASS_STATE, VAL, 0u, 3u)
+/* clang-format on */
+
+enum {
+    ALERT_ID_ALERT_PINGFAIL,
+    ALERT_ID_ESC_PINGFAIL,
+    ALERT_ID_ALERT_INTEGFAIL,
+    ALERT_ID_ESC_INTEGFAIL,
+    ALERT_ID_BUS_INTEGFAIL,
+    ALERT_ID_SHADOW_REG_UPDATE_ERROR,
+    ALERT_ID_SHADOW_REG_STORAGE_ERROR,
+};
+
+enum {
+    ALERT_CLASSA,
+    ALERT_CLASSB,
+    ALERT_CLASSC,
+    ALERT_CLASSD,
+};
+
+enum {
+    STATE_IDLE,
+    STATE_TIMEOUT,
+    STATE_FSMERROR,
+    STATE_TERMINAL,
+    STATE_PHASE0,
+    STATE_PHASE1,
+    STATE_PHASE2,
+    STATE_PHASE3,
+};
+
+#define INTR_MASK ((1u << PARAM_N_CLASSES) - 1u)
+#define CLASS_CTRL_SHADOWED_MASK \
+    (CLASS_CTRL_SHADOWED_EN_MASK | CLASS_CTRL_SHADOWED_LOCK_MASK | \
+     CLASS_CTRL_SHADOWED_EN_E0_MASK | CLASS_CTRL_SHADOWED_EN_E1_MASK | \
+     CLASS_CTRL_SHADOWED_EN_E2_MASK | CLASS_CTRL_SHADOWED_EN_E3_MASK | \
+     CLASS_CTRL_SHADOWED_MAP_E0_MASK | CLASS_CTRL_SHADOWED_MAP_E1_MASK | \
+     CLASS_CTRL_SHADOWED_MAP_E2_MASK | CLASS_CTRL_SHADOWED_MAP_E3_MASK)
+
+#define R32_OFF(_r_) ((_r_) / sizeof(uint32_t))
+
+#define R_LAST_REG R32_OFF(0x574u)
+#define REGS_COUNT (R_LAST_REG + 1u)
+#define REGS_SIZE  (REGS_COUNT * sizeof(uint32_t))
+
+#define ALERT_SLOT_SIZE           R32_OFF(sizeof(struct alerts))
+#define LOC_ALERT_SLOT_SIZE       R32_OFF(sizeof(struct loc_alerts))
+#define CLASS_SLOT_SIZE           R32_OFF(sizeof(struct classes))
+#define CASE_RANGE(_reg_, _cnt_)  (_reg_)...((_reg_) + (_cnt_) - (1u))
+#define CASE_STRIDE(_reg_, _cls_) ((_reg_) + (_cls_) * (CLASS_SLOT_SIZE))
+#define SLOT_OFFSET(_reg_, _base_, _kind_) \
+    (((_reg_) - (_base_)) / _kind_##_SLOT_SIZE)
+#define ALERT_SLOT(_reg_)     SLOT_OFFSET(_reg_, R_ALERT_REGWEN, ALERT)
+#define LOC_ALERT_SLOT(_reg_) SLOT_OFFSET(_reg_, R_LOC_ALERT_REGWEN, LOC_ALE=
RT)
+#define CLASS_SLOT(_reg_)     SLOT_OFFSET(_reg_, R_CLASS_REGWEN, CLASS)
+
+#define CHECK_REGWEN(_reg_, _cond_) \
+    ot_alert_check_regwen(__func__, (_reg_), (_cond_))
+
+struct intr {
+    uint32_t state;
+    uint32_t enable;
+    uint32_t test;
+};
+
+struct ping {
+    uint32_t timer_regwen;
+    uint32_t timeout_cyc_shadowed;
+    uint32_t timer_en_shadowed;
+};
+
+struct alerts {
+    uint32_t regwen;
+    uint32_t en_shadowed;
+    uint32_t class_shadowed;
+    uint32_t cause;
+};
+
+struct loc_alerts {
+    uint32_t regwen;
+    uint32_t en_shadowed;
+    uint32_t class_shadowed;
+    uint32_t cause;
+};
+
+struct classes {
+    uint32_t regwen;
+    uint32_t ctrl_shadowed;
+    uint32_t clr_regwen;
+    uint32_t clr_shadowed;
+    uint32_t accum_cnt;
+    uint32_t accum_thresh_shadowed;
+    uint32_t timeout_cyc_shadowed;
+    uint32_t crashdump_trigger_shadowed;
+    uint32_t phase0_cyc_shadowed;
+    uint32_t phase1_cyc_shadowed;
+    uint32_t phase2_cyc_shadowed;
+    uint32_t phase3_cyc_shadowed;
+    uint32_t esc_cnt;
+    uint32_t state;
+};
+
+typedef struct OtAlertRegs {
+    struct intr intr;
+    struct ping ping;
+    struct alerts alerts[PARAM_N_ALERTS];
+    struct loc_alerts loc_alerts[PARAM_N_LOC_ALERT];
+    struct classes classes[PARAM_N_CLASSES];
+} OtAlertRegs;
+
+struct OtAlertState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+    IbexIRQ irqs[PARAM_N_CLASSES];
+
+    OtAlertRegs *regs;
+};
+
+struct OtAlertClass {
+    SysBusDeviceClass parent_class;
+    ResettablePhases parent_phases;
+};
+
+static inline bool
+ot_alert_check_regwen(const char *func, unsigned reg, bool cond)
+{
+    if (!cond) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: reg 0x%04x is write-protected\n",
+                      func, (unsigned)(reg * sizeof(uint32_t)));
+        return false;
+    }
+    return true;
+}
+
+static void ot_alert_update_irqs(OtAlertState *s)
+{
+    uint32_t level =3D s->regs->intr.state & s->regs->intr.enable;
+
+    for (unsigned ix =3D 0; ix < ARRAY_SIZE(s->irqs); ix++) {
+        ibex_irq_set(&s->irqs[ix], (int)((level >> ix) & 0x1));
+    }
+}
+
+static uint64_t ot_alert_regs_read(void *opaque, hwaddr addr, unsigned size)
+{
+    OtAlertState *s =3D opaque;
+    OtAlertRegs *regs =3D s->regs;
+    uint32_t val32;
+
+    hwaddr reg =3D R32_OFF(addr);
+
+    switch (reg) {
+    case R_INTR_STATE:
+        val32 =3D regs->intr.state;
+        break;
+    case R_INTR_ENABLE:
+        val32 =3D regs->intr.enable;
+        break;
+    case R_PING_TIMER_REGWEN:
+        val32 =3D regs->ping.timer_regwen;
+        break;
+    case R_PING_TIMEOUT_CYC_SHADOWED:
+        val32 =3D regs->ping.timeout_cyc_shadowed;
+        break;
+    case R_PING_TIMER_EN_SHADOWED:
+        val32 =3D regs->ping.timer_en_shadowed;
+        break;
+    case R_INTR_TEST:
+        qemu_log_mask(LOG_GUEST_ERROR, "W/O register 0x02%" HWADDR_PRIx "\n",
+                      addr);
+        val32 =3D 0;
+        break;
+    case CASE_RANGE(R_ALERT_REGWEN, PARAM_N_ALERTS):
+        val32 =3D regs->alerts[ALERT_SLOT(reg)].regwen;
+        break;
+    case CASE_RANGE(R_ALERT_EN_SHADOWED, PARAM_N_ALERTS):
+        val32 =3D regs->alerts[ALERT_SLOT(reg)].en_shadowed;
+        break;
+    case CASE_RANGE(R_ALERT_CLASS_SHADOWED, PARAM_N_ALERTS):
+        val32 =3D regs->alerts[ALERT_SLOT(reg)].class_shadowed;
+        break;
+    case CASE_RANGE(R_ALERT_CAUSE, PARAM_N_ALERTS):
+        val32 =3D regs->alerts[ALERT_SLOT(reg)].cause;
+        break;
+    case CASE_RANGE(R_LOC_ALERT_REGWEN, PARAM_N_LOC_ALERT):
+        val32 =3D regs->loc_alerts[LOC_ALERT_SLOT(reg)].regwen;
+        break;
+    case CASE_RANGE(R_LOC_ALERT_EN_SHADOWED, PARAM_N_LOC_ALERT):
+        val32 =3D regs->loc_alerts[LOC_ALERT_SLOT(reg)].en_shadowed;
+        break;
+    case CASE_RANGE(R_LOC_ALERT_CLASS_SHADOWED, PARAM_N_LOC_ALERT):
+        val32 =3D regs->loc_alerts[LOC_ALERT_SLOT(reg)].class_shadowed;
+        break;
+    case CASE_RANGE(R_LOC_ALERT_CAUSE, PARAM_N_LOC_ALERT):
+        val32 =3D regs->loc_alerts[LOC_ALERT_SLOT(reg)].cause;
+        break;
+    case CASE_STRIDE(R_CLASS_REGWEN, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_REGWEN, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_REGWEN, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_REGWEN, ALERT_CLASSD):
+        val32 =3D regs->classes[CLASS_SLOT(reg)].regwen;
+        break;
+    case CASE_STRIDE(R_CLASS_CTRL_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_CTRL_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_CTRL_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_CTRL_SHADOWED, ALERT_CLASSD):
+        val32 =3D regs->classes[CLASS_SLOT(reg)].ctrl_shadowed;
+        break;
+    case CASE_STRIDE(R_CLASS_CLR_REGWEN, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_CLR_REGWEN, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_CLR_REGWEN, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_CLR_REGWEN, ALERT_CLASSD):
+        val32 =3D regs->classes[CLASS_SLOT(reg)].clr_regwen;
+        break;
+    case CASE_STRIDE(R_CLASS_CLR_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_CLR_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_CLR_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_CLR_SHADOWED, ALERT_CLASSD):
+        val32 =3D regs->classes[CLASS_SLOT(reg)].clr_shadowed;
+        break;
+    case CASE_STRIDE(R_CLASS_ACCUM_CNT, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_ACCUM_CNT, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_ACCUM_CNT, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_ACCUM_CNT, ALERT_CLASSD):
+        val32 =3D regs->classes[CLASS_SLOT(reg)].accum_cnt;
+        break;
+    case CASE_STRIDE(R_CLASS_ACCUM_THRESH_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_ACCUM_THRESH_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_ACCUM_THRESH_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_ACCUM_THRESH_SHADOWED, ALERT_CLASSD):
+        val32 =3D regs->classes[CLASS_SLOT(reg)].accum_thresh_shadowed;
+        break;
+    case CASE_STRIDE(R_CLASS_TIMEOUT_CYC_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_TIMEOUT_CYC_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_TIMEOUT_CYC_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_TIMEOUT_CYC_SHADOWED, ALERT_CLASSD):
+        val32 =3D regs->classes[CLASS_SLOT(reg)].timeout_cyc_shadowed;
+        break;
+    case CASE_STRIDE(R_CLASS_CRASHDUMP_TRIGGER_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_CRASHDUMP_TRIGGER_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_CRASHDUMP_TRIGGER_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_CRASHDUMP_TRIGGER_SHADOWED, ALERT_CLASSD):
+        val32 =3D regs->classes[CLASS_SLOT(reg)].crashdump_trigger_shadowed;
+        break;
+    case CASE_STRIDE(R_CLASS_PHASE0_CYC_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_PHASE0_CYC_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_PHASE0_CYC_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_PHASE0_CYC_SHADOWED, ALERT_CLASSD):
+        val32 =3D regs->classes[CLASS_SLOT(reg)].phase0_cyc_shadowed;
+        break;
+    case CASE_STRIDE(R_CLASS_PHASE1_CYC_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_PHASE1_CYC_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_PHASE1_CYC_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_PHASE1_CYC_SHADOWED, ALERT_CLASSD):
+        val32 =3D regs->classes[CLASS_SLOT(reg)].phase1_cyc_shadowed;
+        break;
+    case CASE_STRIDE(R_CLASS_PHASE2_CYC_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_PHASE2_CYC_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_PHASE2_CYC_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_PHASE2_CYC_SHADOWED, ALERT_CLASSD):
+        val32 =3D regs->classes[CLASS_SLOT(reg)].phase2_cyc_shadowed;
+        break;
+    case CASE_STRIDE(R_CLASS_PHASE3_CYC_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_PHASE3_CYC_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_PHASE3_CYC_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_PHASE3_CYC_SHADOWED, ALERT_CLASSD):
+        val32 =3D regs->classes[CLASS_SLOT(reg)].phase3_cyc_shadowed;
+        break;
+    case CASE_STRIDE(R_CLASS_ESC_CNT, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_ESC_CNT, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_ESC_CNT, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_ESC_CNT, ALERT_CLASSD):
+        val32 =3D regs->classes[CLASS_SLOT(reg)].esc_cnt;
+        break;
+    case CASE_STRIDE(R_CLASS_STATE, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_STATE, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_STATE, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_STATE, ALERT_CLASSD):
+        val32 =3D
+            regs->classes[reg - CASE_STRIDE(R_CLASS_STATE, ALERT_CLASSA)].st=
ate;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        val32 =3D 0;
+        break;
+    }
+
+    uint64_t pc =3D ibex_get_current_pc();
+    trace_ot_alert_io_read_out((unsigned)addr, (uint64_t)val32, pc);
+
+    return (uint64_t)val32;
+};
+
+static void ot_alert_regs_write(void *opaque, hwaddr addr, uint64_t val64,
+                                unsigned size)
+{
+    OtAlertState *s =3D opaque;
+    OtAlertRegs *regs =3D s->regs;
+    uint32_t val32 =3D (uint32_t)val64;
+
+    hwaddr reg =3D R32_OFF(addr);
+
+    uint64_t pc =3D ibex_get_current_pc();
+    trace_ot_alert_io_write((unsigned)addr, val64, pc);
+
+    switch (reg) {
+    case R_INTR_STATE:
+        val32 &=3D INTR_MASK;
+        regs->intr.state &=3D ~val32; /* RW1C */
+        ot_alert_update_irqs(s);
+        break;
+    case R_INTR_ENABLE:
+        val32 &=3D INTR_MASK;
+        regs->intr.enable =3D val32;
+        ot_alert_update_irqs(s);
+        break;
+    case R_INTR_TEST:
+        val32 &=3D INTR_MASK;
+        regs->intr.state |=3D val32;
+        ot_alert_update_irqs(s);
+        break;
+    case R_PING_TIMER_REGWEN:
+        val32 &=3D R_PING_TIMER_REGWEN_EN_MASK;
+        regs->ping.timer_regwen &=3D ~val32; /* RW1C */
+        break;
+    case R_PING_TIMEOUT_CYC_SHADOWED:
+        val32 &=3D R_PING_TIMEOUT_CYC_SHADOWED_VAL_MASK;
+        regs->ping.timeout_cyc_shadowed =3D val32;
+        break;
+    case R_PING_TIMER_EN_SHADOWED:
+        val32 =3D R_PING_TIMER_EN_SHADOWED_EN_MASK; /* RW1S */
+        regs->ping.timer_en_shadowed |=3D val32;
+        break;
+    case CASE_RANGE(R_ALERT_REGWEN, PARAM_N_ALERTS):
+        val32 &=3D ALERT_REGWEN_EN_MASK;
+        regs->alerts[ALERT_SLOT(reg)].regwen &=3D val32; /* RW0C */
+        break;
+    case CASE_RANGE(R_ALERT_EN_SHADOWED, PARAM_N_ALERTS):
+        if (CHECK_REGWEN(reg, regs->alerts[reg - R_ALERT_EN_SHADOWED].regwen=
)) {
+            val32 &=3D ALERT_EN_SHADOWED_EN_MASK;
+            regs->alerts[ALERT_SLOT(reg)].en_shadowed =3D val32;
+        }
+        break;
+    case CASE_RANGE(R_ALERT_CLASS_SHADOWED, PARAM_N_ALERTS):
+        if (CHECK_REGWEN(reg,
+                         regs->alerts[reg - R_ALERT_CLASS_SHADOWED].regwen))=
 {
+            val32 &=3D ALERT_CLASS_SHADOWED_EN_MASK;
+            regs->alerts[ALERT_SLOT(reg)].en_shadowed =3D val32;
+        }
+        break;
+    case CASE_RANGE(R_ALERT_CAUSE, PARAM_N_ALERTS):
+        val32 =3D ALERT_CAUSE_EN_MASK;
+        regs->alerts[ALERT_SLOT(reg)].cause &=3D ~val32; /* RW1C */
+        break;
+    case CASE_RANGE(R_LOC_ALERT_REGWEN, PARAM_N_LOC_ALERT):
+        val32 &=3D LOC_ALERT_REGWEN_EN_MASK;
+        regs->loc_alerts[LOC_ALERT_SLOT(reg)].regwen &=3D val32; /* RW0C */
+        break;
+    case CASE_RANGE(R_LOC_ALERT_EN_SHADOWED, PARAM_N_LOC_ALERT):
+        if (CHECK_REGWEN(reg, regs->loc_alerts[LOC_ALERT_SLOT(reg)].regwen))=
 {
+            val32 &=3D LOC_ALERT_EN_SHADOWED_EN_MASK;
+            regs->loc_alerts[LOC_ALERT_SLOT(reg)].en_shadowed =3D val32;
+        }
+        break;
+    case CASE_RANGE(R_LOC_ALERT_CLASS_SHADOWED, PARAM_N_LOC_ALERT):
+        if (CHECK_REGWEN(reg, regs->loc_alerts[LOC_ALERT_SLOT(reg)].regwen))=
 {
+            val32 &=3D LOC_ALERT_CLASS_SHADOWED_EN_MASK;
+            regs->loc_alerts[LOC_ALERT_SLOT(reg)].en_shadowed =3D val32;
+        }
+        break;
+    case CASE_RANGE(R_LOC_ALERT_CAUSE, PARAM_N_LOC_ALERT):
+        val32 =3D LOC_ALERT_CAUSE_EN_MASK;
+        regs->loc_alerts[LOC_ALERT_SLOT(reg)].cause &=3D ~val32; /* RW1C */
+        break;
+    case CASE_STRIDE(R_CLASS_REGWEN, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_REGWEN, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_REGWEN, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_REGWEN, ALERT_CLASSD):
+        val32 =3D R_CLASS_REGWEN_EN_MASK;
+        regs->classes[CLASS_SLOT(reg)].regwen &=3D val32; /* RW0C */
+        break;
+    case CASE_STRIDE(R_CLASS_CTRL_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_CTRL_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_CTRL_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_CTRL_SHADOWED, ALERT_CLASSD):
+        if (CHECK_REGWEN(reg, regs->classes[CLASS_SLOT(reg)].regwen)) {
+            val32 &=3D CLASS_CTRL_SHADOWED_MASK;
+            regs->classes[CLASS_SLOT(reg)].ctrl_shadowed =3D val32;
+        }
+        break;
+    case CASE_STRIDE(R_CLASS_CLR_REGWEN, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_CLR_REGWEN, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_CLR_REGWEN, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_CLR_REGWEN, ALERT_CLASSD):
+        val32 &=3D CLASS_CLR_REGWEN_EN_MASK;
+        regs->classes[CLASS_SLOT(reg)].clr_regwen &=3D val32; /* RW0C */
+        break;
+    case CASE_STRIDE(R_CLASS_CLR_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_CLR_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_CLR_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_CLR_SHADOWED, ALERT_CLASSD):
+        if (CHECK_REGWEN(reg, regs->classes[CLASS_SLOT(reg)].clr_regwen)) {
+            val32 &=3D CLASS_CLR_SHADOWED_EN_MASK;
+            regs->classes[CLASS_SLOT(reg)].clr_shadowed =3D val32;
+        }
+        break;
+    case CASE_STRIDE(R_CLASS_ACCUM_THRESH_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_ACCUM_THRESH_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_ACCUM_THRESH_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_ACCUM_THRESH_SHADOWED, ALERT_CLASSD):
+        if (CHECK_REGWEN(reg, regs->classes[CLASS_SLOT(reg)].regwen)) {
+            val32 &=3D CLASS_ACCUM_THRESH_SHADOWED_MASK;
+            regs->classes[CLASS_SLOT(reg)].accum_thresh_shadowed =3D val32;
+        }
+        break;
+    case CASE_STRIDE(R_CLASS_TIMEOUT_CYC_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_TIMEOUT_CYC_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_TIMEOUT_CYC_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_TIMEOUT_CYC_SHADOWED, ALERT_CLASSD):
+        if (CHECK_REGWEN(reg, regs->classes[CLASS_SLOT(reg)].regwen)) {
+            regs->classes[CLASS_SLOT(reg)].timeout_cyc_shadowed =3D val32;
+        }
+        break;
+    case CASE_STRIDE(R_CLASS_CRASHDUMP_TRIGGER_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_CRASHDUMP_TRIGGER_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_CRASHDUMP_TRIGGER_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_CRASHDUMP_TRIGGER_SHADOWED, ALERT_CLASSD):
+        if (CHECK_REGWEN(reg, regs->classes[CLASS_SLOT(reg)].regwen)) {
+            val32 &=3D CLASS_CRASHDUMP_TRIGGER_SHADOWED_MASK;
+            regs->classes[CLASS_SLOT(reg)].crashdump_trigger_shadowed =3D va=
l32;
+        }
+        break;
+    case CASE_STRIDE(R_CLASS_PHASE0_CYC_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_PHASE0_CYC_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_PHASE0_CYC_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_PHASE0_CYC_SHADOWED, ALERT_CLASSD):
+        if (CHECK_REGWEN(reg, regs->classes[CLASS_SLOT(reg)].regwen)) {
+            regs->classes[CLASS_SLOT(reg)].phase0_cyc_shadowed =3D val32;
+        }
+        break;
+    case CASE_STRIDE(R_CLASS_PHASE1_CYC_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_PHASE1_CYC_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_PHASE1_CYC_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_PHASE1_CYC_SHADOWED, ALERT_CLASSD):
+        if (CHECK_REGWEN(reg, regs->classes[CLASS_SLOT(reg)].regwen)) {
+            regs->classes[CLASS_SLOT(reg)].phase1_cyc_shadowed =3D val32;
+        }
+        break;
+    case CASE_STRIDE(R_CLASS_PHASE2_CYC_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_PHASE2_CYC_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_PHASE2_CYC_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_PHASE2_CYC_SHADOWED, ALERT_CLASSD):
+        if (CHECK_REGWEN(reg, regs->classes[CLASS_SLOT(reg)].regwen)) {
+            regs->classes[CLASS_SLOT(reg)].phase2_cyc_shadowed =3D val32;
+        }
+        break;
+    case CASE_STRIDE(R_CLASS_PHASE3_CYC_SHADOWED, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_PHASE3_CYC_SHADOWED, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_PHASE3_CYC_SHADOWED, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_PHASE3_CYC_SHADOWED, ALERT_CLASSD):
+        if (CHECK_REGWEN(reg, regs->classes[CLASS_SLOT(reg)].regwen)) {
+            regs->classes[CLASS_SLOT(reg)].phase3_cyc_shadowed =3D val32;
+        }
+        break;
+    case CASE_STRIDE(R_CLASS_ACCUM_CNT, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_ACCUM_CNT, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_ACCUM_CNT, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_ACCUM_CNT, ALERT_CLASSD):
+    case CASE_STRIDE(R_CLASS_ESC_CNT, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_ESC_CNT, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_ESC_CNT, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_ESC_CNT, ALERT_CLASSD):
+    case CASE_STRIDE(R_CLASS_STATE, ALERT_CLASSA):
+    case CASE_STRIDE(R_CLASS_STATE, ALERT_CLASSB):
+    case CASE_STRIDE(R_CLASS_STATE, ALERT_CLASSC):
+    case CASE_STRIDE(R_CLASS_STATE, ALERT_CLASSD):
+        qemu_log_mask(LOG_GUEST_ERROR, "R/O register 0x02%" HWADDR_PRIx "\n",
+                      addr);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        break;
+    }
+};
+
+static const MemoryRegionOps ot_alert_regs_ops =3D {
+    .read =3D &ot_alert_regs_read,
+    .write =3D &ot_alert_regs_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size =3D 4u,
+    .impl.max_access_size =3D 4u,
+};
+
+static void ot_alert_reset_enter(Object *obj, ResetType type)
+{
+    OtAlertClass *c =3D OT_ALERT_GET_CLASS(obj);
+    OtAlertState *s =3D OT_ALERT(obj);
+
+    if (c->parent_phases.enter) {
+        c->parent_phases.enter(obj, type);
+    }
+
+    OtAlertRegs *regs =3D s->regs;
+    memset(regs, 0, sizeof(*regs));
+
+    regs->ping.timer_regwen =3D 0x1u;
+    regs->ping.timeout_cyc_shadowed =3D 0x100u;
+    for (unsigned ix =3D 0; ix < PARAM_N_ALERTS; ix++) {
+        regs->alerts[ix].regwen =3D 0x1u;
+    }
+    for (unsigned ix =3D 0; ix < PARAM_N_LOC_ALERT; ix++) {
+        regs->loc_alerts[ix].regwen =3D 0x1u;
+    }
+    for (unsigned ix =3D 0; ix < PARAM_N_CLASSES; ix++) {
+        regs->classes[ix].regwen =3D 0x1u;
+        regs->classes[ix].ctrl_shadowed =3D 0x393cu;
+        regs->classes[ix].clr_regwen =3D 0x1u;
+    }
+
+    ot_alert_update_irqs(s);
+}
+
+static void ot_alert_init(Object *obj)
+{
+    OtAlertState *s =3D OT_ALERT(obj);
+
+    memory_region_init_io(&s->mmio, obj, &ot_alert_regs_ops, s, TYPE_OT_ALER=
T,
+                          REGS_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->mmio);
+
+    s->regs =3D g_new0(OtAlertRegs, 1);
+
+    for (unsigned ix =3D 0; ix < ARRAY_SIZE(s->irqs); ix++) {
+        ibex_sysbus_init_irq(obj, &s->irqs[ix]);
+    }
+}
+
+static void ot_alert_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+    OtAlertClass *ac =3D OT_ALERT_CLASS(klass);
+    resettable_class_set_parent_phases(rc, &ot_alert_reset_enter, NULL, NULL,
+                                       &ac->parent_phases);
+}
+
+static const TypeInfo ot_alert_info =3D {
+    .name =3D TYPE_OT_ALERT,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(OtAlertState),
+    .instance_init =3D &ot_alert_init,
+    .class_size =3D sizeof(OtAlertClass),
+    .class_init =3D &ot_alert_class_init,
+};
+
+static void ot_alert_register_types(void)
+{
+    type_register_static(&ot_alert_info);
+}
+
+type_init(ot_alert_register_types)
diff --git a/hw/opentitan/trace-events b/hw/opentitan/trace-events
index 695debd380..39dea92d2b 100644
--- a/hw/opentitan/trace-events
+++ b/hw/opentitan/trace-events
@@ -1 +1,6 @@
 # OpenTitan EarlGrey Trace Events
+
+# ot_alert.c
+
+ot_alert_io_read_out(unsigned int addr, uint64_t val, uint64_t pc) "addr=3D0=
x%02x, val=3D0x%" PRIx64 ", pc=3D0x%" PRIx64
+ot_alert_io_write(unsigned int addr, uint64_t val, uint64_t pc) "addr=3D0x%0=
2x, val=3D0x%" PRIx64 ", pc=3D0x%" PRIx64
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 76588c43ae..8fdb048ea7 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -17,6 +17,7 @@ config OT_EARLGREY
     default y
     select IBEX
     select IBEX_COMMON
+    select OT_ALERT
     select SIFIVE_PLIC
=20
 config MICROCHIP_PFSOC
diff --git a/hw/riscv/ibex_common.c b/hw/riscv/ibex_common.c
index 6b53662a5b..dc0ae79777 100644
--- a/hw/riscv/ibex_common.c
+++ b/hw/riscv/ibex_common.c
@@ -1,5 +1,5 @@
 /*
- * QEMU RISC-V Helpers for LowRISC Ibex Demo System & OpenTitan EarlGrey
+ * QEMU RISC-V Helpers for LowRISC OpenTitan EarlGrey and related systems
  *
  * Copyright (c) 2022-2023 Rivos, Inc.
  *
diff --git a/hw/riscv/ot_earlgrey.c b/hw/riscv/ot_earlgrey.c
index 77fb1b207c..ccb9ad0e7e 100644
--- a/hw/riscv/ot_earlgrey.c
+++ b/hw/riscv/ot_earlgrey.c
@@ -24,6 +24,7 @@
 #include "hw/core/boards.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/misc/unimp.h"
+#include "hw/opentitan/ot_alert.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/riscv/ibex_common.h"
 #include "hw/riscv/ot_earlgrey.h"
@@ -261,12 +262,16 @@ static const IbexDeviceDef ot_earlgrey_soc_devices[] =
=3D {
         ),
     },
     [OT_EARLGREY_SOC_DEV_ALERT_HANDLER] =3D {
-        .type =3D TYPE_UNIMPLEMENTED_DEVICE,
-        .name =3D "ot-alert_handler",
-        .cfg =3D &ibex_unimp_configure,
+        .type =3D TYPE_OT_ALERT,
         .memmap =3D MEMMAPENTRIES(
             { 0x40150000u, 0x800u }
         ),
+        .gpio =3D IBEXGPIOCONNDEFS(
+            OT_EARLGREY_SOC_GPIO_SYSBUS_IRQ(0, PLIC, 127),
+            OT_EARLGREY_SOC_GPIO_SYSBUS_IRQ(0, PLIC, 128),
+            OT_EARLGREY_SOC_GPIO_SYSBUS_IRQ(0, PLIC, 129),
+            OT_EARLGREY_SOC_GPIO_SYSBUS_IRQ(1, PLIC, 130)
+        ),
     },
     [OT_EARLGREY_SOC_DEV_SPI_HOST0] =3D {
         .type =3D TYPE_UNIMPLEMENTED_DEVICE,
diff --git a/include/hw/opentitan/ot_alert.h b/include/hw/opentitan/ot_alert.h
new file mode 100644
index 0000000000..d68f4c9e6e
--- /dev/null
+++ b/include/hw/opentitan/ot_alert.h
@@ -0,0 +1,23 @@
+/*
+ * QEMU OpenTitan Alert handler device
+ *
+ * Copyright (c) 2022-2025 Rivos, Inc.
+ *
+ * Author(s):
+ *  Emmanuel Blot <eblot@rivosinc.com>
+ *  Lo=C3=AFc Lefort <loic@rivosinc.com>
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#ifndef HW_OPENTITAN_OT_ALERT
+#define HW_OPENTITAN_OT_ALERT
+
+#include "qom/object.h"
+
+#define OPENTITAN_DEVICE_ALERT "ot-alert"
+
+#define TYPE_OT_ALERT "ot-alert"
+OBJECT_DECLARE_TYPE(OtAlertState, OtAlertClass, OT_ALERT)
+
+#endif /* HW_OPENTITAN_OT_ALERT */
diff --git a/include/hw/riscv/ibex_irq.h b/include/hw/riscv/ibex_irq.h
index 22ccff6d5e..c1e11e20f6 100644
--- a/include/hw/riscv/ibex_irq.h
+++ b/include/hw/riscv/ibex_irq.h
@@ -12,9 +12,9 @@
=20
 #include "qemu/osdep.h"
 #include "qom/object.h"
-#include "hw/irq.h"
-#include "hw/qdev-core.h"
-#include "hw/sysbus.h"
+#include "hw/core/irq.h"
+#include "hw/core/qdev.h"
+#include "hw/core/sysbus.h"
=20
=20
 /** Simple IRQ wrapper to limit propagation of no-change calls */
--=20
2.49.1

