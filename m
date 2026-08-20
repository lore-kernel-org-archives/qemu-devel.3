Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F678C5DF88
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2CP-0004zY-4L; Thu, 20 Aug 2026 08:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CM-0004xp-H4
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:46 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wx2CJ-0001b6-Qz
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:48:46 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so188512666b.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 05:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787230122; x=1787834922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xIPRtYnSQ22CzQekHMqw0G9VSwq1dsdbMgC5BbUJjuQ=;
 b=PpQufh4qAd8EWMKmkYytOdG1b1lQS9/qFa9TGKstMCamDZlWRFX6u3kXbUALSxGlIJ
 JZMkLhV1f9pUzxSJB55jPUwOyiYXwGFXNPzytjrfrQnNBE7qQW5iibuh9WvRKdig9MHI
 u6DsbqNts8grpBmCyafEGB3965hiij4k2hHdsFWPrDW1nhDe3Uh9EgWaoQnWEH7hJHb/
 kmQdT6jAEyiMlFreNAoQUgj/3oeB33/S+ImwVDXBAKyPn5UchI/zpusMRdnyEDZS8Ktb
 XuA8fizykWdY/Y+DmhanTLOgT60xq5emb1geQtcMrnCbLVh1l319pAkQDV/MdvLk6D4z
 pOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787230122; x=1787834922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xIPRtYnSQ22CzQekHMqw0G9VSwq1dsdbMgC5BbUJjuQ=;
 b=nWnHoZ0AGRUg0O7aREXuEiGJ6RQOtn+2GmWZVf48eZkZ/U4gEdnagp5Eb/hRxPogBD
 j2QaLAdj4r8mybc/QmNKetf/bmT4a9Az1Ys2JXxfzjbmn1XKFJxfknhwdK4QZw9qWEdO
 q/Zb80ewHeK8wt8GM+m0k7BGhxh/Ce4X2r6x9oezvbgJf78zAybCxN3Bt+8nDP/GZosj
 B2yXEKOQn7stqcqJV/glqtMqlTEWuDC3t7soHvZYQJVI2pJLqdbE8Z93p1x0blJ4HWd2
 fPRRx54KCnYdYJdhqMT5tqJcczrsguZQFOJYmBX5IOwEhr5rH+P37FlmDrkSXdJbaiZi
 +qRQ==
X-Gm-Message-State: AOJu0YymzF+Bbp4M6jf0IB5HeelpEztNYL7lss/GVK310JDHNeNwS9TJ
 Olzu6Ir5qYwyQW4CS+Tm++NiVMFbaAig/IiRru2P6MlWZexNMLPkfGjiC2qoDbHy
X-Gm-Gg: AR+sD107b/JRtoR0KeTvpBsmZ8DEAXh7R4iFaC19Jaj/ouGxvdsaJ8SrTtLqMn4hTvu
 H92+PKLnwa8WkzU3smJQe89YB9TkrgR4SvIKSYtEinwSeKnYU7ZY31L8zddaFhgkgAprbPm1vRO
 sKrrite4IhbbauNdHDiOlp8RTK97C61R7IpFknb6sugbnGs4Qx1N4MYr6nyo5RGrDooquVf58q3
 Hf2X8ch2XsvtaQ9VOfWuT2sjOHRp3hRWCCgVe4daRbuEq0c+utxikHLwZ4n2XUxHjYM8lQJAhn4
 dCHhxqPmUXstJwE2XrZKeEDfWNpHJFmeVRjYup3h1k2oMpg7sDTWI5d5w4fPoYAOPi7W7em1XKN
 FB+Z/b32mSZZs5/mnlQU8ucMeyOj4WqffXKLjJp5UdehbQvqtpmk+uhu/FH0HWlN+LdGKaOeCJg
 65ki4KOXIbh4JiD6AK2sKxzUbHLzVgVxZ97vknhwt9r+ksbK0cI5r6t/Ejxt3xFlGR6kk3XUcY8
 kc/kbAnhIuRW8Y3yZo82eU=
X-Received: by 2002:a17:907:7ba6:b0:c21:42af:4cb with SMTP id
 a640c23a62f3a-c244d63f5c8mr437717966b.6.1787230122102; 
 Thu, 20 Aug 2026 05:48:42 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff1563c5sm2270449a12.14.2026.08.20.05.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 05:48:41 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Wadim Mueller <wafgo01@gmail.com>
Subject: [RFC PATCH v2 11/14] hw/arm: add TI K3 combined boot image parser
Date: Thu, 20 Aug 2026 14:48:11 +0200
Message-ID: <20260820124824.618671-12-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820124824.618671-1-wafgo01@gmail.com>
References: <20260820124824.618671-1-wafgo01@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=wafgo01@gmail.com; helo=mail-ej1-x635.google.com
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

The K3 boot ROM consumes a "combined boot image" (tiboot3.bin): an X.509
certificate carrying a TI-specific boot extension that describes the
individual components (SYSFW, board config blobs, the R5 SPL), followed by
the component data.

Add a standalone parser for that container. It is deliberately free of any
device or machine state so it can be unit tested; the loader, which acts
on the result, comes with the SoC model.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 hw/arm/k3-bootrom-parse.c   | 250 ++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |   1 +
 include/hw/arm/k3-bootrom.h |  43 +++++++
 3 files changed, 294 insertions(+)
 create mode 100644 hw/arm/k3-bootrom-parse.c
 create mode 100644 include/hw/arm/k3-bootrom.h

diff --git a/hw/arm/k3-bootrom-parse.c b/hw/arm/k3-bootrom-parse.c
new file mode 100644
index 0000000000..e3e428b6b1
--- /dev/null
+++ b/hw/arm/k3-bootrom-parse.c
@@ -0,0 +1,250 @@
+/*
+ * TI K3 boot-ROM emulation: X.509 combined boot image parser
+ *
+ * Parses the DER wrapper and ext_boot_info extension
+ * (OID 1.3.6.1.4.1.294.1.9) for payload type, destination and size.
+ * No signature verification, since QEMU models a GP device.
+ *
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/k3-bootrom.h"
+
+typedef struct DerSlice {
+    const uint8_t *p;
+    const uint8_t *end;
+} DerSlice;
+
+static bool der_read_tlv(DerSlice *s, uint8_t *tag, DerSlice *content,
+                         Error **errp)
+{
+    uint64_t len;
+
+    if (s->end - s->p < 2) {
+        error_setg(errp, "k3-bootrom: truncated DER structure");
+        return false;
+    }
+    *tag = *s->p++;
+    len = *s->p++;
+    if (len & 0x80) {
+        unsigned n = len & 0x7f;
+
+        if (n == 0 || n > 4 || (size_t)(s->end - s->p) < n) {
+            error_setg(errp, "k3-bootrom: bad DER length encoding");
+            return false;
+        }
+        len = 0;
+        while (n--) {
+            len = (len << 8) | *s->p++;
+        }
+    }
+    if ((uint64_t)(s->end - s->p) < len) {
+        error_setg(errp, "k3-bootrom: DER length exceeds buffer");
+        return false;
+    }
+    content->p = s->p;
+    content->end = s->p + len;
+    s->p += len;
+    return true;
+}
+
+static bool der_read_uint(DerSlice *s, uint64_t *out, Error **errp)
+{
+    DerSlice c;
+    uint8_t tag;
+    uint64_t v = 0;
+
+    if (!der_read_tlv(s, &tag, &c, errp)) {
+        return false;
+    }
+    if (tag != 0x02) {
+        error_setg(errp, "k3-bootrom: expected INTEGER, got tag 0x%02x",
+                   tag);
+        return false;
+    }
+    if (c.p == c.end) {
+        error_setg(errp, "k3-bootrom: empty INTEGER");
+        return false;
+    }
+    if (c.end - c.p > 9 || (c.end - c.p == 9 && c.p[0] != 0)) {
+        error_setg(errp, "k3-bootrom: INTEGER too large");
+        return false;
+    }
+    for (const uint8_t *q = c.p; q < c.end; q++) {
+        v = (v << 8) | *q;
+    }
+    *out = v;
+    return true;
+}
+
+static bool der_read_u32(DerSlice *s, uint32_t *out, Error **errp)
+{
+    uint64_t v;
+
+    if (!der_read_uint(s, &v, errp)) {
+        return false;
+    }
+    if (v > UINT32_MAX) {
+        error_setg(errp, "k3-bootrom: integer field %" PRIu64
+                   " exceeds 32 bits", v);
+        return false;
+    }
+    *out = v;
+    return true;
+}
+
+/* Big-endian OCTET STRING (<= 8 bytes), as uint64. */
+static bool der_read_addr(DerSlice *s, uint64_t *out, Error **errp)
+{
+    DerSlice c;
+    uint8_t tag;
+    uint64_t v = 0;
+
+    if (!der_read_tlv(s, &tag, &c, errp)) {
+        return false;
+    }
+    if (tag != 0x04 || c.end - c.p > 8) {
+        error_setg(errp, "k3-bootrom: bad destAddr field (tag 0x%02x)",
+                   tag);
+        return false;
+    }
+    for (const uint8_t *q = c.p; q < c.end; q++) {
+        v = (v << 8) | *q;
+    }
+    *out = v;
+    return true;
+}
+
+/* DER TLV for TI ext_boot_info OID 1.3.6.1.4.1.294.1.9. */
+static const uint8_t k3_ext_boot_oid[] = {
+    0x06, 0x09, 0x2b, 0x06, 0x01, 0x04, 0x01, 0x82, 0x26, 0x01, 0x09
+};
+
+static const uint8_t *find_bytes(const uint8_t *hay, size_t hay_len,
+                                 const uint8_t *needle, size_t needle_len)
+{
+    if (hay_len < needle_len) {
+        return NULL;
+    }
+    for (size_t i = 0; i + needle_len <= hay_len; i++) {
+        if (memcmp(hay + i, needle, needle_len) == 0) {
+            return hay + i;
+        }
+    }
+    return NULL;
+}
+
+bool k3_bootrom_parse(const uint8_t *buf, size_t len, K3BootImage *out,
+                      Error **errp)
+{
+    DerSlice top = { buf, buf + len };
+    DerSlice cert, rest, octets, info;
+    const uint8_t *oid;
+    uint8_t tag;
+    uint64_t v;
+    uint64_t payload_off;
+
+    memset(out, 0, sizeof(*out));
+
+    if (!der_read_tlv(&top, &tag, &cert, errp)) {
+        return false;
+    }
+    if (tag != 0x30) {
+        error_setg(errp,
+                   "k3-bootrom: not an X.509 boot image (tag 0x%02x)", tag);
+        return false;
+    }
+    out->cert_len = cert.end - buf;
+
+    oid = find_bytes(cert.p, cert.end - cert.p, k3_ext_boot_oid,
+                     sizeof(k3_ext_boot_oid));
+    if (!oid) {
+        error_setg(errp, "k3-bootrom: ext_boot_info extension "
+                   "(OID 1.3.6.1.4.1.294.1.9) not found");
+        return false;
+    }
+    rest.p = oid + sizeof(k3_ext_boot_oid);
+    rest.end = cert.end;
+
+    /* Optional BOOLEAN 'critical', between OID and extnValue. */
+    if (rest.p < rest.end && rest.p[0] == 0x01) {
+        DerSlice skip;
+
+        if (!der_read_tlv(&rest, &tag, &skip, errp)) {
+            return false;
+        }
+    }
+    if (!der_read_tlv(&rest, &tag, &octets, errp)) {
+        return false;
+    }
+    if (tag != 0x04) {
+        error_setg(errp, "k3-bootrom: extension value is not an "
+                   "OCTET STRING (tag 0x%02x)", tag);
+        return false;
+    }
+    if (!der_read_tlv(&octets, &tag, &info, errp)) {
+        return false;
+    }
+    if (tag != 0x30) {
+        error_setg(errp, "k3-bootrom: ext_boot_info is not a SEQUENCE");
+        return false;
+    }
+
+    if (!der_read_uint(&info, &out->ext_img_size, errp)) {
+        return false;
+    }
+    if (!der_read_uint(&info, &v, errp)) {
+        return false;
+    }
+    if (v == 0 || v > K3_BOOTROM_MAX_COMPS) {
+        error_setg(errp, "k3-bootrom: unsupported component count %"
+                   PRIu64, v);
+        return false;
+    }
+    out->num_comps = v;
+
+    payload_off = out->cert_len;
+    for (uint32_t i = 0; i < out->num_comps; i++) {
+        K3BootComponent *c = &out->comps[i];
+        DerSlice comp;
+
+        if (!der_read_tlv(&info, &tag, &comp, errp)) {
+            return false;
+        }
+        if (tag != 0x30) {
+            error_setg(errp, "k3-bootrom: component %u is not a SEQUENCE",
+                       i);
+            return false;
+        }
+        if (!der_read_u32(&comp, &c->comp_type, errp)) {
+            return false;
+        }
+        if (!der_read_u32(&comp, &c->boot_core, errp)) {
+            return false;
+        }
+        if (!der_read_u32(&comp, &c->comp_opts, errp)) {
+            return false;
+        }
+        if (!der_read_addr(&comp, &c->dest_addr, errp)) {
+            return false;
+        }
+        if (!der_read_u32(&comp, &c->comp_size, errp)) {
+            return false;
+        }
+        /* shaType / shaValue are not needed for the loading. */
+        /* payload_off is bounded by len below, so it fits into size_t. */
+        c->payload_offset = payload_off;
+        payload_off += c->comp_size;
+        if (payload_off > len) {
+            error_setg(errp, "k3-bootrom: image truncated (components "
+                       "need %" PRIu64 " bytes, file has %zu)",
+                       payload_off, len);
+            return false;
+        }
+    }
+    return true;
+}
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 8ee5307a91..22691afdd8 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -109,6 +109,7 @@ arm_common_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
 arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
+arm_common_ss.add(when: 'CONFIG_TI_AM64X', if_true: files('k3-bootrom-parse.c'))
 
 arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
   'ax3000-soc.c'))
diff --git a/include/hw/arm/k3-bootrom.h b/include/hw/arm/k3-bootrom.h
new file mode 100644
index 0000000000..cf60efc047
--- /dev/null
+++ b/include/hw/arm/k3-bootrom.h
@@ -0,0 +1,43 @@
+/*
+ * TI K3 boot-ROM (RBL) emulation - X.509 combined image loading
+ *
+ * Copyright (c) 2026 CMBLU Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_ARM_K3_BOOTROM_H
+#define HW_ARM_K3_BOOTROM_H
+
+#include "qapi/error.h"
+
+#define K3_BOOTROM_MAX_COMPS 8
+
+/* comp_type values from TI combined-image certificate. */
+#define K3_COMP_TYPE_SBL        1
+#define K3_COMP_TYPE_SYSFW      2
+#define K3_COMP_TYPE_SYSFW_DATA 18
+
+typedef struct K3BootComponent {
+    uint32_t comp_type;
+    uint32_t boot_core;
+    uint32_t comp_opts;
+    uint64_t dest_addr;
+    uint32_t comp_size;
+    size_t payload_offset;
+} K3BootComponent;
+
+typedef struct K3BootImage {
+    uint32_t num_comps;
+    uint64_t ext_img_size;
+    size_t cert_len;
+    K3BootComponent comps[K3_BOOTROM_MAX_COMPS];
+} K3BootImage;
+
+bool k3_bootrom_parse(const uint8_t *buf, size_t len, K3BootImage *out,
+                      Error **errp);
+
+typedef struct TIAM64xState TIAM64xState;
+void k3_bootrom_load(TIAM64xState *soc, const char *filename, Error **errp);
+
+#endif
-- 
2.43.0


