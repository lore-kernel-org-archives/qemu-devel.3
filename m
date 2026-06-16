Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CACCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZTpB-000632-SH; Tue, 16 Jun 2026 09:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wZTp6-00060X-Up
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:27:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wZTp4-0005tA-PK
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:27:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781616442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0MgtnSaVh9ax7ryBzZLi/K7BKaomljz1Cy0WeKLK4ak=;
 b=JAj9A5keCL9l8cHRniKj9HRfb0jfPh2c9+kDi/YB2CTkf5tcOMNcShnp7Eu0Q3P7+VbkHD
 58SEbM8Mhzfx0E+pssXM6DAm7E1gL8FEKOGzqsftePbZeb++9EsKTHwMIi5SyBt18tSXPP
 0EOlnMsqiOEGw2Scg7E12Y7ohlvXk04=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-170-Gp9KaIkuO3Ox10zTUViyNg-1; Tue,
 16 Jun 2026 09:27:19 -0400
X-MC-Unique: Gp9KaIkuO3Ox10zTUViyNg-1
X-Mimecast-MFC-AGG-ID: Gp9KaIkuO3Ox10zTUViyNg_1781616437
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2557218009DA; Tue, 16 Jun 2026 13:27:17 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.48.30])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E10103008B3B; Tue, 16 Jun 2026 13:27:10 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@linaro.org
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [RFC PATCH v6 06/17] scripts: Introduce
 scripts/update-aarch64-cpu-sysreg-properties.py
Date: Tue, 16 Jun 2026 15:16:53 +0200
Message-ID: <20260616132625.1732031-7-eric.auger@redhat.com>
In-Reply-To: <20260616132625.1732031-1-eric.auger@redhat.com>
References: <20260616132625.1732031-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Introduce a script that takes as input the Registers.json file
delivered in the AARCHMRS Features Model downloadable from the
Arm Developer A-Profile Architecture Exploration Tools page:
https://developer.arm.com/Architectures/A-Profile%20Architecture#Downloads
and automates the generation of system register properties definitions.

generates target/arm/cpu-idregs.h.inc containing definitions for
feature ID registers.

We only care about IDregs with opcodes satisfying:
op0 = 3, op1 = {0,1,3}, crn = 0, crm within [0, 7], op2 within [0, 7]

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v5 -> v6
- add ident
---
 .../update-aarch64-cpu-sysreg-properties.py   | 166 ++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 scripts/update-aarch64-cpu-sysreg-properties.py

diff --git a/scripts/update-aarch64-cpu-sysreg-properties.py b/scripts/update-aarch64-cpu-sysreg-properties.py
new file mode 100644
index 0000000000..6f5edb88d2
--- /dev/null
+++ b/scripts/update-aarch64-cpu-sysreg-properties.py
@@ -0,0 +1,166 @@
+#!/usr/bin/env python3
+
+# This script takes as input the Registers.json file delivered in
+# the AARCHMRS Features Model downloadable from the Arm Developer
+# A-Profile Architecture Exploration Tools page:
+# https://developer.arm.com/Architectures/A-Profile%20Architecture#Downloads
+# and outputs target/arm/cpu-idregs.h.inc content.
+# ID regs are defined using this pattern:
+#
+# IDREG_START(REG)
+#    IDREG_FIELD(REG, FIELD, SHIFT, LENGTH)
+# ...
+# IDREG_END(REG)
+#
+# Copyright (C) 2026 Red Hat, Inc.
+#
+# Authors: Eric Auger <eric.auger@redhat.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+
+import json
+import os
+import sys
+from aarch64_sysreg_helpers import extract_idregs_from_registers_json
+
+def collect_fields(item, bit_offset=0):
+    """
+    Recursively finds all field-like objects, handling Fields.Array,
+    Fields.ArrayField, and ConditionalField structures.
+    Applies bit_offset from containers to child fields.
+    """
+    fields = []
+    if not isinstance(item, dict):
+        return fields
+
+    _type = item.get('_type', '')
+
+    # Array types (for example CLIDR_EL1 Ctype<n>, Ttype<n>)
+    if _type == 'Fields.Array':
+        name_template = item.get('name') or item.get('label', '')
+        index_info = item.get('indexes', [{}])[0]
+        start_idx = index_info.get('start', 0)
+        count = index_info.get('width', 0)
+
+        full_range = item.get('rangeset', [{}])[0]
+        bit_start = full_range.get('start', 0) + bit_offset
+        elem_width = full_range.get('width', 0) // count if count else 0
+
+        for i in range(count):
+            idx = start_idx + i
+            # Correctly handle indexed names like Ctype1, Ctype2
+            field_name = name_template.replace('<n>', str(idx))
+            fields.append({
+                'name': field_name,
+                'rangeset': [{
+                    'start': bit_start + (i * elem_width),
+                    'width': elem_width
+                }],
+                '_type': 'Fields.Field'
+            })
+        return fields
+
+    # ConditionalFields
+    elif _type == 'Fields.ConditionalField':
+        inner_offset = bit_offset
+        if item.get('rangeset'):
+            # Parent container defines the absolute start bit
+            inner_offset = item['rangeset'][0].get('start', bit_offset)
+
+        for entry in item.get('fields', []):
+            inner = entry.get('field')
+            if inner:
+                fields.extend(collect_fields(inner, inner_offset))
+        return fields
+
+    # Normal Field Types
+    leaf_types = ['Fields.Field', 'Fields.ConstantField',
+                  'Fields.EnumeratedField', 'Fields.Bitfield']
+    if _type in leaf_types:
+        field_copy = item.copy()
+        if field_copy.get('rangeset'):
+            new_ranges = []
+            for r in field_copy['rangeset']:
+                nr = r.copy()
+                # Apply the cumulative offset to the field's start bit
+                nr['start'] = r.get('start', 0) + bit_offset
+                new_ranges.append(nr)
+            field_copy['rangeset'] = new_ranges
+        fields.append(field_copy)
+        return fields
+
+    # Traverse the hierarchy for other cases
+    for key in ['fields', 'values', 'fieldsets']:
+        for nested in item.get(key, []):
+            fields.extend(collect_fields(nested, bit_offset))
+
+    return fields
+
+
+def generate_sysreg_properties_from_registers_json(id_reg_names, raw_json_path):
+    with open(raw_json_path, 'r') as f:
+        register_data = json.load(f)
+
+    regs = {r.get('name'): r for r in register_data if r.get('_type') == 'Register'}
+
+    final_output = ""
+
+    for reg_name in id_reg_names:
+        register = regs.get(reg_name)
+        if not register:
+            continue
+
+        final_output += f"IDREG_START({reg_name})\n"
+
+        unique_fields = {}
+        for fieldset in register.get('fieldsets', []):
+            candidates = collect_fields(fieldset)
+            for val in candidates:
+                name = (val.get('name') or val.get('label', '')).strip()
+                if not name or "RESERVED" in name.upper():
+                    continue
+                for r in val.get('rangeset', []):
+                    lsb = int(r.get('start'))
+                    width = r.get('width')
+                    msb = lsb + int(width) - 1
+
+                    # Only keep the fields with the highest MSB
+                    # needed fir CCSIDR_EL1
+                    if name not in unique_fields or msb > unique_fields[name]['msb']:
+                        unique_fields[name] = {'lsb': lsb, 'msb': msb, 'width': width}
+
+        # Sort decreasing lsbs
+        sorted_fields = sorted(unique_fields.items(),
+                               key=lambda x: x[1]['lsb'], reverse=True)
+
+        for name, bits in sorted_fields:
+            line = (f"    IDREG_FIELD({reg_name}, "
+                    f"{name}, {bits['lsb']}, {bits['width']})\n")
+            final_output += line
+        final_output += f"IDREG_END({reg_name})\n"
+        final_output += "\n"
+
+    os.makedirs("target/arm", exist_ok=True)
+    with open("target/arm/cpu-idregs.h.inc", 'w') as f:
+        f.write("/* AUTOMATICALLY GENERATED, DO NOT MODIFY */\n\n")
+        f.write("/* SPDX-License-Identifier: GPL-2.0-or-later */\n\n")
+        f.write("/* IDREG_START(REG) */\n")
+        f.write("/*     IDREG_FIELD(REG, FIELD, SHIFT, LENGTH) */\n")
+        f.write("/* ... */\n")
+        f.write("/* IDREG_END(REG) */\n\n")
+        f.write(final_output)
+
+if __name__ == "__main__":
+    if len(sys.argv) < 2:
+        print("Usage: python scripts/update-aarch64-cpu-sysreg-properties.py "
+              "<path_to_registers_json>")
+    else:
+        json_path = sys.argv[1]
+
+        id_regs_dict = extract_idregs_from_registers_json(json_path)
+        sorted_names = sorted(id_regs_dict.keys())
+
+        if sorted_names:
+            generate_sysreg_properties_from_registers_json(sorted_names, json_path)
+            print("Generated target/arm/cpu-idregs.h.inc")
-- 
2.53.0


