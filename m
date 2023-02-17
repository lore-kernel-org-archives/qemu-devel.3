Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CA9C56201
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtS7s-0005rY-7G; Fri, 20 Feb 2026 10:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS2F-0008EZ-Gn; Fri, 20 Feb 2026 10:03:17 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1vtS2D-0002MO-FL; Fri, 20 Feb 2026 10:03:14 -0500
DKIM-Signature: a=rsa-sha256; bh=ly5RtxzJn0F2WP0BkUcyjhxWSvK+uULsMgUEDOP8Xb0=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1771599790; v=1;
 b=RxsXJdy+BJ8bSbC2/bjwxjL3mbZSSSKqveBgOouLkAp55UoX9WY9tHsq3Fv7wRmi6MH65foD
 e6feFAFLuaZxVkgR+zWyfoIZNhHPU5oug3cdAvqq6mq7F5zV4ADejLEU2JI6f4/Hno65oskAZ1D
 DuLZPmZGM68TP+avC74xPy9dH9JcU9+AgVajaT8+/uQVn3hAGQiLBs2KM7aQKNszK+amdpnhXrm
 bWEaHGXxc0jeNTHgJAKDpO7uzhzbKaKzlh+/GNLQ+Jbai6dSkvKqKI6A/hlvb1M/tn01H9kxcE2
 LFRmdJGTBivD4SMtaZytaRdiuV15IDfS9axqsqBbhzdlA==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 6A6D025021;
 Fri, 20 Feb 2026 15:03:10 +0000 (UTC)
From: ~lexbaileylowrisc <lexbaileylowrisc@git.sr.ht>
Date: Fri, 17 Feb 2023 16:10:15 +0100
Subject: [PATCH qemu 09/11] [ot] hw/opentitan: add OpenTitan shadow register
 helpers
MIME-Version: 1.0
Message-ID: <177159976712.8279.7732381632410882915-9@git.sr.ht>
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
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Lo=C3=AFc Lefort <loic@rivosinc.com>

Signed-off-by: Lo=C3=AFc Lefort <loic@rivosinc.com>
---
 include/hw/opentitan/ot_common.h | 93 ++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 include/hw/opentitan/ot_common.h

diff --git a/include/hw/opentitan/ot_common.h b/include/hw/opentitan/ot_commo=
n.h
new file mode 100644
index 0000000000..546a7d88a8
--- /dev/null
+++ b/include/hw/opentitan/ot_common.h
@@ -0,0 +1,93 @@
+/*
+ * QEMU RISC-V Helpers for OpenTitan EarlGrey
+ *
+ * Copyright (c) 2023 Rivos, Inc.
+ *
+ * Author(s):
+ *  Emmanuel Blot <eblot@rivosinc.com>
+ *  Lo=C3=AFc Lefort <loic@rivosinc.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_RISCV_OT_COMMON_H
+#define HW_RISCV_OT_COMMON_H
+
+#include "qemu/osdep.h"
+
+/* ------------------------------------------------------------------------ =
*/
+/* Shadow Registers */
+/* ------------------------------------------------------------------------ =
*/
+
+/*
+ * Shadow register, concept documented at:
+ * https://docs.opentitan.org/doc/rm/register_tool/#shadow-registers
+ */
+typedef struct OtShadowReg {
+    /* committed register value */
+    uint32_t committed;
+    /* staged register value */
+    uint32_t staged;
+    /* true if 'staged' holds a value */
+    bool staged_p;
+} OtShadowReg;
+
+enum {
+    OT_SHADOW_REG_ERROR =3D -1,
+    OT_SHADOW_REG_COMMITTED =3D 0,
+    OT_SHADOW_REG_STAGED =3D 1,
+};
+
+/**
+ * Initialize a shadow register with a committed value and no staged value
+ */
+static inline void ot_shadow_reg_init(OtShadowReg *sreg, uint32_t value)
+{
+    sreg->committed =3D value;
+    sreg->staged_p =3D false;
+}
+
+/**
+ * Write a new value to a shadow register.
+ * If no value was previously staged, the new value is only staged for next
+ * write and the function returns OT_SHADOW_REG_STAGED.
+ * If a value was previously staged and the new value is different, the func=
tion
+ * returns OT_SHADOW_REG_ERROR and the new value is ignored. Otherwise the v=
alue
+ * is committed, the staged value is discarded and the function returns
+ * OT_SHADOW_REG_COMMITTED.
+ */
+static inline int ot_shadow_reg_write(OtShadowReg *sreg, uint32_t value)
+{
+    if (sreg->staged_p) {
+        if (value !=3D sreg->staged) {
+            /* second write is different, return error status */
+            return OT_SHADOW_REG_ERROR;
+        }
+        sreg->committed =3D value;
+        sreg->staged_p =3D false;
+        return OT_SHADOW_REG_COMMITTED;
+    } else {
+        sreg->staged =3D value;
+        sreg->staged_p =3D true;
+        return OT_SHADOW_REG_STAGED;
+    }
+}
+
+/**
+ * Return the current committed register value
+ */
+static inline uint32_t ot_shadow_reg_peek(const OtShadowReg *sreg)
+{
+    return sreg->committed;
+}
+
+/**
+ * Discard the staged value and return the current committed register value
+ */
+static inline uint32_t ot_shadow_reg_read(OtShadowReg *sreg)
+{
+    sreg->staged_p =3D false;
+    return sreg->committed;
+}
+
+#endif /* HW_RISCV_OT_COMMON_H */
--=20
2.49.1


