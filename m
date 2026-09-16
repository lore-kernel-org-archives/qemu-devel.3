Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1206C982C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6qvh-0006au-6X; Wed, 16 Sep 2026 10:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6qvf-0006a1-Gl
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:48:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x6qvd-0006QZ-Jd
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789570084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XmgKG6NMohjgsyNM/iCgqjlycA3hA6zWHQIfm95HhtQ=;
 b=bFIRZhd4FTMiW7dzFRBhCKKPgnZ/yLGCc4QQNq9JpZzwF2ydZhwIY5gv2qOIlMZ7Gtl3Ht
 t7TfESCe89uT6XtTBpwVcEj2KLrdXOx7tiHXQAXpGvCiaYELI4W8eM/3tucGMiErTn3Neu
 uFuoDLOJhgN6+3Gpt6+xxJxR5aXdZ+Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-xiHCEpJTOlq8hh9stq8jQg-1; Wed,
 16 Sep 2026 10:48:00 -0400
X-MC-Unique: xiHCEpJTOlq8hh9stq8jQg-1
X-Mimecast-MFC-AGG-ID: xiHCEpJTOlq8hh9stq8jQg_1789570078
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7167A1800655; Wed, 16 Sep 2026 14:47:58 +0000 (UTC)
Received: from laptop.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DBC271956053; Wed, 16 Sep 2026 14:47:53 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v9 05/26] scripts: Introduce scripts/aarch64_sysreg_helpers
 module
Date: Wed, 16 Sep 2026 16:45:28 +0200
Message-ID: <20260916144721.751810-6-eric.auger@redhat.com>
In-Reply-To: <20260916144721.751810-1-eric.auger@redhat.com>
References: <20260916144721.751810-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

We plan to reuse get_opcode() and extract_idregs_from_registers_json()
functions in another script. So let's move them into a module

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Khushit Shah <khushit.shah@nutanix.com>
---
 scripts/aarch64_sysreg_helpers.py            | 121 +++++++++++++++++++
 scripts/update-aarch64-cpu-sysregs-header.py |  97 +--------------
 2 files changed, 122 insertions(+), 96 deletions(-)
 create mode 100644 scripts/aarch64_sysreg_helpers.py

diff --git a/scripts/aarch64_sysreg_helpers.py b/scripts/aarch64_sysreg_helpers.py
new file mode 100644
index 0000000000..24bbc5bb3d
--- /dev/null
+++ b/scripts/aarch64_sysreg_helpers.py
@@ -0,0 +1,121 @@
+#!/usr/bin/env python3
+
+# Helpers used in aarch64 sysreg definition generation
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
+
+def is_demux_register(r):
+    name = r.get('name', '')
+
+    if name.startswith("CCSIDR"):
+        return True
+
+    return False
+
+# Some regs have op code values like 000x, 001x. Anyway we don't need
+# them. Besides some regs are undesired in the generated file such as
+# VMPIDR_EL2 and VPIDR_EL2 which are outside of the IDreg scope we
+# are interested in and are tricky to decode as their system accessor
+# refer to MPIDR_EL1/MIDR_EL1 respectively
+
+skiplist = ['ALLINT', 'PM', 'S1_', 'S3_', 'SVCR', \
+            'VMPIDR_EL2', 'VPIDR_EL2']
+
+# returns the int value of a given @opcode for a reg @encoding
+def get_opcode(encoding, opcode):
+    fvalue = encoding.get(opcode)
+    if fvalue:
+        value = fvalue.get('value')
+        if isinstance(value, str):
+            value = value.strip("'")
+            value = int(value, 2)
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
+    registers = [
+        r for r in register_data
+        if isinstance(r, dict)
+        and r.get('_type') == 'Register'
+        and not is_demux_register(r)
+    ]
+
+    idregs = {}
+
+    # Some regs have op code values like 000x, 001x. Anyway we don't need
+    # them. Besides some regs are undesired in the generated file such as
+    # VMPIDR_EL2 and VPIDR_EL2 which are outside of the IDreg scope we
+    # are interested in and are tricky to decode as their system accessor
+    # refer to MPIDR_EL1/MIDR_EL1 respectively
+
+    skiplist = ['ALLINT', 'PM', 'S1_', 'S3_', 'SVCR', \
+                'VMPIDR_EL2', 'VPIDR_EL2']
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
+
+
diff --git a/scripts/update-aarch64-cpu-sysregs-header.py b/scripts/update-aarch64-cpu-sysregs-header.py
index ef1471a197..43107264e9 100755
--- a/scripts/update-aarch64-cpu-sysregs-header.py
+++ b/scripts/update-aarch64-cpu-sysregs-header.py
@@ -17,102 +17,7 @@
 import json
 import os
 import sys
-
-def is_demux_register(r):
-    name = r.get('name', '')
-
-    if name.startswith("CCSIDR"):
-        return True
-
-    return False
-
-# Some regs have op code values like 000x, 001x. Anyway we don't need
-# them. Besides some regs are undesired in the generated file such as
-# VMPIDR_EL2 and VPIDR_EL2 which are outside of the IDreg scope we
-# are interested in and are tricky to decode as their system accessor
-# refer to MPIDR_EL1/MIDR_EL1 respectively
-
-skiplist = ['ALLINT', 'PM', 'S1_', 'S3_', 'SVCR', \
-            'VMPIDR_EL2', 'VPIDR_EL2']
-
-# returns the int value of a given @opcode for a reg @encoding
-def get_opcode(encoding, opcode):
-    fvalue = encoding.get(opcode)
-    if fvalue:
-        value = fvalue.get('value')
-        if isinstance(value, str):
-            value = value.strip("'")
-            value = int(value, 2)
-            return value
-    return -1
-
-def extract_idregs_from_registers_json(filename):
-    """
-    Load a Registers.json file and extract all ID registers, decode their
-    opcode and dump the information in target/arm/cpu-sysregs.h.inc
-
-    Args:
-        filename (str): The path to the Registers.json
-    returns:
-        idregs: list of ID regs and their encoding
-    """
-    if not os.path.exists(filename):
-        print(f"Error: {filename} could not be found!")
-        return {}
-
-    try:
-        with open(filename, 'r') as f:
-            register_data = json.load(f)
-
-    except json.JSONDecodeError:
-        print(f"Could not decode json from '{filename}'!")
-        return {}
-    except Exception as e:
-        print(f"Unexpected error while reading {filename}: {e}")
-        return {}
-
-    registers = [
-        r for r in register_data
-        if isinstance(r, dict)
-        and r.get('_type') == 'Register'
-        and not is_demux_register(r)
-    ]
-
-    idregs = {}
-
-    for register in registers:
-        reg_name = register.get('name')
-
-        is_skipped = any(term in (reg_name or "").upper() for term in skiplist)
-
-        if reg_name and not is_skipped:
-            accessors = register.get('accessors', [])
-
-            for accessor in accessors:
-                type = accessor.get('_type')
-                if type in ['Accessors.SystemAccessor']:
-                    encoding_list = accessor.get('encoding')
-
-                    if isinstance(encoding_list, list) and encoding_list and \
-                       isinstance(encoding_list[0], dict):
-                        encoding_wrapper = encoding_list[0]
-                        encoding_source = encoding_wrapper.get('encodings', \
-                                                               encoding_wrapper)
-
-                        if isinstance(encoding_source, dict):
-                                op0 = get_opcode(encoding_source, 'op0')
-                                op1 = get_opcode(encoding_source, 'op1')
-                                op2 = get_opcode(encoding_source, 'op2')
-                                crn = get_opcode(encoding_source, 'CRn')
-                                crm = get_opcode(encoding_source, 'CRm')
-                                encoding_str=f"{op0} {op1} {crn} {crm} {op2}"
-
-                # ID regs are assumed within this scope
-                if op0 == 3 and (op1 == 0 or op1 == 1 or op1 == 3) and \
-                   crn == 0 and (crm >= 0 and crm <= 7) and (op2 >= 0 and op2 <= 7):
-                    idregs[reg_name] = encoding_str
-
-    return idregs
+from aarch64_sysreg_helpers import extract_idregs_from_registers_json
 
 if __name__ == "__main__":
     # Single arg expected: the path to the Registers.json file
-- 
2.53.0


