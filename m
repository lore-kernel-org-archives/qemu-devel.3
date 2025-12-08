Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3787AD3B7E2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 16:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSeFk-0001vJ-GV; Mon, 08 Dec 2025 11:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSeFY-0001tJ-Jf
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 11:38:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vSeFV-0002bM-Kt
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 11:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765211888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IoPMT69hU7hgy+EBlQGMx7ULsNeZWjI7C3qwtY9/v0g=;
 b=bW2HSu6+OvcLbo/PtCv1nTy2a4ekKG/dBsaD7Tcm5zUTB7vrHgNdF1Cq8FG15TC7dZzlMg
 zURx0ldbLPPnO1ZUgQOk1zROdTpvLyJwOmAbsmq+vBqan7qvN5ccT785ixVGCthhiYbwM5
 Z8oK9H3NJbkwErS5alChFdHnzq7KvEI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-R3kM3kNlOH2eZWyggFSUYA-1; Mon,
 08 Dec 2025 11:38:05 -0500
X-MC-Unique: R3kM3kNlOH2eZWyggFSUYA-1
X-Mimecast-MFC-AGG-ID: R3kM3kNlOH2eZWyggFSUYA_1765211884
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65A5A18002C9; Mon,  8 Dec 2025 16:38:04 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.22.88.78])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C68B30001A5; Mon,  8 Dec 2025 16:38:01 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, cohuck@redhat.com, sebott@redhat.com
Cc: maz@kernel.org
Subject: [PATCH 1/3] scripts: introduce scripts/update-aarch64-sysreg-code.py
Date: Mon,  8 Dec 2025 17:37:03 +0100
Message-ID: <20251208163751.611186-2-eric.auger@redhat.com>
In-Reply-To: <20251208163751.611186-1-eric.auger@redhat.com>
References: <20251208163751.611186-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce a script that takes as input the Registers.json file
delivered in the AARCHMRS Features Model downloadable from the
Arm Developer A-Profile Architecture Exploration Tools page:
https://developer.arm.com/Architectures/A-Profile%20Architecture#Downloads
and outputs the list of ID regs in target/arm/cpu-sysregs.h.inc
under the form of DEF(<name>, <op0>, <op1>, <crn>, <crm>, <op2>).

We only care about IDregs with opcodes satisfying:
op0 = 3, op1 within [0, 3], crn = 0, crm within [0, 7], op2 within [0, 7]

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

This was tested with https://developer.arm.com/-/cdn-downloads/permalink/Exploration-Tools-OS-Machine-Readable-Data/AARCHMRS_BSD/AARCHMRS_OPENSOURCE_A_profile_FAT-2025-09_ASL0.tar.gz

Discussion about undesired generated regs can be found in
https://lore.kernel.org/all/CAFEAcA9OXi4v+hdBMamQv85HYp2EqxOA5=nfsdZ5E3nf8RP_pw@mail.gmail.com/
---
 scripts/update-aarch64-sysreg-code.py | 133 ++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100755 scripts/update-aarch64-sysreg-code.py

diff --git a/scripts/update-aarch64-sysreg-code.py b/scripts/update-aarch64-sysreg-code.py
new file mode 100755
index 0000000000..c7b31035d1
--- /dev/null
+++ b/scripts/update-aarch64-sysreg-code.py
@@ -0,0 +1,133 @@
+#!/usr/bin/env python3
+
+# This script takes as input the Registers.json file delivered in
+# the AARCHMRS Features Model downloadable from the Arm Developer
+# A-Profile Architecture Exploration Tools page:
+# https://developer.arm.com/Architectures/A-Profile%20Architecture#Downloads
+# and outputs the list of ID regs in target/arm/cpu-sysregs.h.inc
+# under the form of DEF(<name>, <op0>, <op1>, <crn>, <crm>, <op2>)
+#
+# Copyright (C) 2025 Red Hat, Inc.
+#
+# Authors: Eric Auger <eric.auger@redhat.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+
+import json
+import os
+import sys
+
+# returns the int value of a given @opcode for a reg @encoding
+def get_opcode(encoding, opcode):
+    fvalue = encoding.get(opcode)
+    if fvalue:
+        value = fvalue.get('value')
+        if isinstance(value, str):
+            value = value.strip("'")
+            value = int(value,2)
+            return value
+    return -1
+
+def extract_idregs_from_registers_json(filename):
+    """
+    Load a Registers.json file and extract all ID registers, decode their
+    opcode and dump the information in target/arm/cpu-sysregs.h.inc
+
+    Args:
+        filename (str): The path to the Registers.json
+    returns:
+        idregs: list of ID regs and their encoding
+    """
+    if not os.path.exists(filename):
+        print(f"Error: {filename} could not be found!")
+        return {}
+
+    try:
+        with open(filename, 'r') as f:
+            register_data = json.load(f)
+
+    except json.JSONDecodeError:
+        print(f"Could not decode json from '{filename}'!")
+        return {}
+    except Exception as e:
+        print(f"Unexpected error while reading {filename}: {e}")
+        return {}
+
+    registers = [r for r in register_data if isinstance(r, dict) and \
+                r.get('_type') == 'Register']
+
+    idregs = {}
+
+    # Some regs have op code values like 000x, 001x. Anyway we don't need
+    # them. Besides some regs are undesired in the generated file such as
+    # CCSIDR_EL1 and CCSIDR2_EL1 which are arrays of regs. Also exclude
+    # VMPIDR_EL2 and VPIDR_EL2 which are outside of the IDreg scope we
+    # are interested in and are tricky to decode as their system accessor
+    # refer to MPIDR_EL1/MIDR_EL1 respectively
+
+    skiplist = ['ALLINT', 'PM', 'S1_', 'S3_', 'SVCR', \
+                'CCSIDR_EL1', 'CCSIDR2_EL1', 'VMPIDR_EL2', 'VPIDR_EL2']
+
+    for register in registers:
+        reg_name = register.get('name')
+
+        is_skipped = any(term in (reg_name or "").upper() for term in skiplist)
+
+        if reg_name and not is_skipped:
+            accessors = register.get('accessors', [])
+
+            for accessor in accessors:
+                type = accessor.get('_type')
+                if type in ['Accessors.SystemAccessor']:
+                    encoding_list = accessor.get('encoding')
+
+                    if isinstance(encoding_list, list) and encoding_list and \
+                       isinstance(encoding_list[0], dict):
+                        encoding_wrapper = encoding_list[0]
+                        encoding_source = encoding_wrapper.get('encodings', \
+                                                               encoding_wrapper)
+
+                        if isinstance(encoding_source, dict):
+                                op0 = get_opcode(encoding_source, 'op0')
+                                op1 = get_opcode(encoding_source, 'op1')
+                                op2 = get_opcode(encoding_source, 'op2')
+                                crn = get_opcode(encoding_source, 'CRn')
+                                crm = get_opcode(encoding_source, 'CRm')
+                                encoding_str=f"{op0} {op1} {crn} {crm} {op2}"
+
+                # ID regs are assumed within this scope
+                if op0 == 3 and (op1 == 0 or op1 == 1 or op1 == 3) and \
+                   crn == 0 and (crm >= 0 and crm <= 7) and (op2 >= 0 and op2 <= 7):
+                    idregs[reg_name] = encoding_str
+
+    return idregs
+
+if __name__ == "__main__":
+    # Single arg expectedr: the path to the Registers.json file
+    if len(sys.argv) < 2:
+        print("Usage: scripts/update-aarch64-sysreg-code.py <path_to_registers_json>")
+        sys.exit(1)
+    else:
+        json_file_path = sys.argv[1]
+
+    extracted_registers = extract_idregs_from_registers_json(json_file_path)
+
+    if extracted_registers:
+        output_list = extracted_registers.items()
+
+        # Sort by register name
+        sorted_output = sorted(output_list, key=lambda item: item[0])
+
+        # format lines as DEF(<name>, <op0>, <op1>, <crn>, <crm>, <op2>)
+        final_output = ""
+        for reg_name, encoding in sorted_output:
+            reformatted_encoding = encoding.replace(" ", ", ")
+            final_output += f"DEF({reg_name}, {reformatted_encoding})\n"
+
+        with open("target/arm/cpu-sysregs.h.inc", 'w') as f:
+            f.write("/* SPDX-License-Identifier: BSD-3-Clause */\n\n")
+            f.write("/* This file is autogenerated by ")
+            f.write("scripts/update-aarch64-sysreg-code.py */\n\n")
+            f.write(final_output)
+        print(f"updated target/arm/cpu-sysregs.h.inc")
-- 
2.52.0


