Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE88C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 12:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc2EN-0000zq-Tr; Thu, 08 Aug 2024 08:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sc2EL-0000nX-A3
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:26:57 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sc2EH-0005zU-7L
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 08:26:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id EA496CE13DC;
 Thu,  8 Aug 2024 12:26:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D747FC4AF14;
 Thu,  8 Aug 2024 12:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723120003;
 bh=VrnxR8mGPryNBo86QHHaBK1wabyi7xP05dt6BdPI+6A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mdj3IZuIkgSHJYJdssPFsysCwSaWdJo2I6NxtnIBdSMyRL2snFSBulg8G6CxP0k7T
 8sY9yb/+zxXoqvWzT0r9BpQGqM7/r0u+xL2boTn6/zEOEnnGkrU+n4Ym5EgagKXc+Q
 kTRIMhRohpI1RsFTiR27AZ011MQlHyVh28haPSCl0Tk1yUVXaehmQloUubnEc2iy3T
 GqGfkT2Ka7LYZ70EzNQYzFJhF5NvFhgXr8fpC9tUNz8ierpryhXXO0hqxDUGvRayVF
 xdv0wCD9F/NbQdYnZX4lslWipZlIjJu1IAA1jH+IgZ8DgVSrT+DCD5BJNKbxt85Y5Z
 giHsSYL+3/PPw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1sc2E5-00000000oDe-05Jp; Thu, 08 Aug 2024 14:26:41 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v6 08/10] scripts/ghes_inject: add a script to generate GHES
 error inject
Date: Thu,  8 Aug 2024 14:26:34 +0200
Message-ID: <e9f2011095facb566815ccac13c9c87be710fa5e.1723119423.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1723119423.git.mchehab+huawei@kernel.org>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Using the QMP GHESv2 API requires preparing a raw data array
containing a CPER record.

Add a helper script with subcommands to prepare such data.

Currently, only ARM Processor error CPER record is supported.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS                    |   3 +
 qapi/ghes-cper.json            |   4 +-
 scripts/arm_processor_error.py | 375 ++++++++++++++++++++++++++++
 scripts/ghes_inject.py         |  48 ++++
 scripts/qmp_helper.py          | 431 +++++++++++++++++++++++++++++++++
 5 files changed, 859 insertions(+), 2 deletions(-)
 create mode 100644 scripts/arm_processor_error.py
 create mode 100755 scripts/ghes_inject.py
 create mode 100644 scripts/qmp_helper.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a0c36f9b5d0c..9ad336381dbe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2083,6 +2083,9 @@ S: Maintained
 F: hw/arm/ghes_cper.c
 F: hw/acpi/ghes_cper_stub.c
 F: qapi/ghes-cper.json
+F: scripts/ghes_inject.py
+F: scripts/arm_processor_error.py
+F: scripts/qmp_helper.py
 
 ppc4xx
 L: qemu-ppc@nongnu.org
diff --git a/qapi/ghes-cper.json b/qapi/ghes-cper.json
index 3cc4f9f2aaa9..d650996a7150 100644
--- a/qapi/ghes-cper.json
+++ b/qapi/ghes-cper.json
@@ -36,8 +36,8 @@
 ##
 # @ghes-cper:
 #
-# Inject ARM Processor error with data to be filled according with
-# ACPI 6.2 GHESv2 spec.
+# Inject a CPER error data to be filled according with ACPI 6.2
+# spec via GHESv2.
 #
 # @cper: a single CPER record to be sent to the guest OS.
 #
diff --git a/scripts/arm_processor_error.py b/scripts/arm_processor_error.py
new file mode 100644
index 000000000000..b464254c8b7c
--- /dev/null
+++ b/scripts/arm_processor_error.py
@@ -0,0 +1,375 @@
+#!/usr/bin/env python3
+#
+# pylint: disable=C0301,C0114,R0903,R0912,R0913,R0914,R0915,W0511
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2024 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+# TODO: current implementation has dummy defaults.
+#
+# For a better implementation, a QMP addition/call is needed to
+# retrieve some data for ARM Processor Error injection:
+#
+#   - ARM registers: power_state, mpidr.
+
+import argparse
+import re
+
+from qmp_helper import qmp, util, cper_guid
+
+class ArmProcessorEinj:
+    """
+    Implements ARM Processor Error injection via GHES
+    """
+
+    DESC = """
+    Generates an ARM processor error CPER, compatible with
+    UEFI 2.9A Errata.
+    """
+
+    ACPI_GHES_ARM_CPER_LENGTH = 40
+    ACPI_GHES_ARM_CPER_PEI_LENGTH = 32
+
+    # Context types
+    CONTEXT_AARCH32_EL1 = 1
+    CONTEXT_AARCH64_EL1 = 5
+    CONTEXT_MISC_REG = 8
+
+    def __init__(self, subparsers):
+        """Initialize the error injection class and add subparser"""
+
+        # Valid choice values
+        self.arm_valid_bits = {
+            "mpidr":    util.bit(0),
+            "affinity": util.bit(1),
+            "running":  util.bit(2),
+            "vendor":   util.bit(3),
+        }
+
+        self.pei_flags = {
+            "first":        util.bit(0),
+            "last":         util.bit(1),
+            "propagated":   util.bit(2),
+            "overflow":     util.bit(3),
+        }
+
+        self.pei_error_types = {
+            "cache":        util.bit(1),
+            "tlb":          util.bit(2),
+            "bus":          util.bit(3),
+            "micro-arch":   util.bit(4),
+        }
+
+        self.pei_valid_bits = {
+            "multiple-error":   util.bit(0),
+            "flags":            util.bit(1),
+            "error-info":       util.bit(2),
+            "virt-addr":        util.bit(3),
+            "phy-addr":         util.bit(4),
+        }
+
+        self.data = bytearray()
+
+        parser = subparsers.add_parser("arm", description=self.DESC)
+
+        arm_valid_bits = ",".join(self.arm_valid_bits.keys())
+        flags = ",".join(self.pei_flags.keys())
+        error_types = ",".join(self.pei_error_types.keys())
+        pei_valid_bits = ",".join(self.pei_valid_bits.keys())
+
+        # UEFI N.16 ARM Validation bits
+        g_arm = parser.add_argument_group("ARM processor")
+        g_arm.add_argument("--arm", "--arm-valid",
+                           help=f"ARM valid bits: {arm_valid_bits}")
+        g_arm.add_argument("-a", "--affinity",  "--level", "--affinity-level",
+                           type=lambda x: int(x, 0),
+                           help="Affinity level (when multiple levels apply)")
+        g_arm.add_argument("-l", "--mpidr", type=lambda x: int(x, 0),
+                           help="Multiprocessor Affinity Register")
+        g_arm.add_argument("-i", "--midr", type=lambda x: int(x, 0),
+                           help="Main ID Register")
+        g_arm.add_argument("-r", "--running",
+                           action=argparse.BooleanOptionalAction,
+                           default=None,
+                           help="Indicates if the processor is running or not")
+        g_arm.add_argument("--psci", "--psci-state",
+                           type=lambda x: int(x, 0),
+                           help="Power State Coordination Interface - PSCI state")
+
+        # TODO: Add vendor-specific support
+
+        # UEFI N.17 bitmaps (type and flags)
+        g_pei = parser.add_argument_group("ARM Processor Error Info (PEI)")
+        g_pei.add_argument("-t", "--type", nargs="+",
+                        help=f"one or more error types: {error_types}")
+        g_pei.add_argument("-f", "--flags", nargs="*",
+                        help=f"zero or more error flags: {flags}")
+        g_pei.add_argument("-V", "--pei-valid", "--error-valid", nargs="*",
+                        help=f"zero or more PEI valid bits: {pei_valid_bits}")
+
+        # UEFI N.17 Integer values
+        g_pei.add_argument("-m", "--multiple-error", nargs="+",
+                        help="Number of errors: 0: Single error, 1: Multiple errors, 2-65535: Error count if known")
+        g_pei.add_argument("-e", "--error-info", nargs="+",
+                        help="Error information (UEFI 2.10 tables N.18 to N.20)")
+        g_pei.add_argument("-p", "--physical-address",  nargs="+",
+                        help="Physical address")
+        g_pei.add_argument("-v", "--virtual-address",  nargs="+",
+                        help="Virtual address")
+
+        # UEFI N.21 Context
+        g_ctx = parser.add_argument_group("Processor Context")
+        g_ctx.add_argument("--ctx-type", "--context-type", nargs="*",
+                        help="Type of the context (0=ARM32 GPR, 5=ARM64 EL1, other values supported)")
+        g_ctx.add_argument("--ctx-size", "--context-size", nargs="*",
+                        help="Minimal size of the context")
+        g_ctx.add_argument("--ctx-array", "--context-array", nargs="*",
+                        help="Comma-separated arrays for each context")
+
+        # Vendor-specific data
+        g_vendor = parser.add_argument_group("Vendor-specific data")
+        g_vendor.add_argument("--vendor", "--vendor-specific", nargs="+",
+                        help="Vendor-specific byte arrays of data")
+
+        parser.set_defaults(func=self.send_cper)
+
+    def send_cper(self, args):
+        """Parse subcommand arguments and send a CPER via QMP"""
+
+        qmp_cmd = qmp(args.host, args.port, args.debug)
+
+        is_cpu_type = re.compile(r"^([\w+]+\-)?arm\-cpu$")
+        cpus = qmp_cmd.search_qom("/machine/unattached/device",
+                                  "type", is_cpu_type)
+
+        cper = {}
+        pei = {}
+        ctx = {}
+        vendor = {}
+
+        arg = vars(args)
+
+        # Handle global parameters
+        if args.arm:
+            arm_valid_init = False
+            cper["valid"] = util.get_choice(name="valid",
+                                       value=args.arm,
+                                       choices=self.arm_valid_bits,
+                                       suffixes=["-error", "-err"])
+        else:
+            cper["valid"] = 0
+            arm_valid_init = True
+
+        if "running" in arg:
+            if args.running:
+                cper["running-state"] = util.bit(0)
+            else:
+                cper["running-state"] = 0
+        else:
+            cper["running-state"] = 0
+
+        if arm_valid_init:
+            if args.affinity:
+                cper["valid"] |= self.arm_valid_bits["affinity"]
+
+            if args.mpidr:
+                cper["valid"] |= self.arm_valid_bits["mpidr"]
+
+            if "running-state" in cper:
+                cper["valid"] |= self.arm_valid_bits["running"]
+
+            if args.psci:
+                cper["valid"] |= self.arm_valid_bits["running"]
+
+        # Handle PEI
+        if not args.type:
+            args.type = ["cache-error"]
+
+        util.get_mult_choices(
+            pei,
+            name="valid",
+            values=args.pei_valid,
+            choices=self.pei_valid_bits,
+            suffixes=["-valid", "--addr"],
+        )
+        util.get_mult_choices(
+            pei,
+            name="type",
+            values=args.type,
+            choices=self.pei_error_types,
+            suffixes=["-error", "-err"],
+        )
+        util.get_mult_choices(
+            pei,
+            name="flags",
+            values=args.flags,
+            choices=self.pei_flags,
+            suffixes=["-error", "-cap"],
+        )
+        util.get_mult_int(pei, "error-info", args.error_info)
+        util.get_mult_int(pei, "multiple-error", args.multiple_error)
+        util.get_mult_int(pei, "phy-addr", args.physical_address)
+        util.get_mult_int(pei, "virt-addr", args.virtual_address)
+
+        # Handle context
+        util.get_mult_int(ctx, "type", args.ctx_type, allow_zero=True)
+        util.get_mult_int(ctx, "minimal-size", args.ctx_size, allow_zero=True)
+        util.get_mult_array(ctx, "register", args.ctx_array, allow_zero=True)
+
+        util.get_mult_array(vendor, "bytes", args.vendor, max_val=255)
+
+        # Store PEI
+        pei_data = bytearray()
+        default_flags  = self.pei_flags["first"]
+        default_flags |= self.pei_flags["last"]
+
+        error_info_num = 0
+
+        for i, p in pei.items():        # pylint: disable=W0612
+            error_info_num += 1
+
+            # UEFI 2.10 doesn't define how to encode error information
+            # when multiple types are raised. So, provide a default only
+            # if a single type is there
+            if "error-info" not in p:
+                if p["type"] == util.bit(1):
+                    p["error-info"] = 0x0091000F
+                if p["type"] == util.bit(2):
+                    p["error-info"] = 0x0054007F
+                if p["type"] == util.bit(3):
+                    p["error-info"] = 0x80D6460FFF
+                if p["type"] == util.bit(4):
+                    p["error-info"] = 0x78DA03FF
+
+            if "valid" not in p:
+                p["valid"] = 0
+                if "multiple-error" in p:
+                    p["valid"] |= self.pei_valid_bits["multiple-error"]
+
+                if "flags" in p:
+                    p["valid"] |= self.pei_valid_bits["flags"]
+
+                if "error-info" in p:
+                    p["valid"] |= self.pei_valid_bits["error-info"]
+
+                if "phy-addr" in p:
+                    p["valid"] |= self.pei_valid_bits["phy-addr"]
+
+                if "virt-addr" in p:
+                    p["valid"] |= self.pei_valid_bits["virt-addr"]
+
+            # Version
+            util.data_add(pei_data, 0, 1)
+
+            util.data_add(pei_data,
+                         self.ACPI_GHES_ARM_CPER_PEI_LENGTH, 1)
+
+            util.data_add(pei_data, p["valid"], 2)
+            util.data_add(pei_data, p["type"], 1)
+            util.data_add(pei_data, p.get("multiple-error", 1), 2)
+            util.data_add(pei_data, p.get("flags", default_flags), 1)
+            util.data_add(pei_data, p.get("error-info", 0), 8)
+            util.data_add(pei_data, p.get("virt-addr", 0xDEADBEEF), 8)
+            util.data_add(pei_data, p.get("phy-addr", 0xABBA0BAD), 8)
+
+        # Store Context
+        ctx_data = bytearray()
+        context_info_num = 0
+
+        if ctx:
+            ret = qmp_cmd.send_cmd('{ "execute": "query-target" }',
+                                   may_open=True)
+
+            default_ctx = self.CONTEXT_MISC_REG
+
+            if "arch" in ret:
+                if ret["arch"] == "aarch64":
+                    default_ctx = self.CONTEXT_AARCH64_EL1
+                elif ret["arch"] == "arm":
+                    default_ctx = self.CONTEXT_AARCH32_EL1
+
+            for k in sorted(ctx.keys()):
+                context_info_num += 1
+
+                if "type" not in ctx[k]:
+                    ctx[k]["type"] = default_ctx
+
+                if "register" not in ctx[k]:
+                    ctx[k]["register"] = []
+
+                reg_size = len(ctx[k]["register"])
+                size = 0
+
+                if "minimal-size" in ctx:
+                    size = ctx[k]["minimal-size"]
+
+                size = max(size, reg_size)
+
+                size = (size + 1) % 0xFFFE
+
+                # Version
+                util.data_add(ctx_data, 0, 2)
+
+                util.data_add(ctx_data, ctx[k]["type"], 2)
+
+                util.data_add(ctx_data, 8 * size, 4)
+
+                for r in ctx[k]["register"]:
+                    util.data_add(ctx_data, r, 8)
+
+                for i in range(reg_size, size):   # pylint: disable=W0612
+                    util.data_add(ctx_data, 0, 8)
+
+        # Vendor-specific bytes are not grouped
+        vendor_data = bytearray()
+        if vendor:
+            for k in sorted(vendor.keys()):
+                for b in vendor[k]["bytes"]:
+                    util.data_add(vendor_data, b, 1)
+
+        # Encode ARM Processor Error
+        data = bytearray()
+
+        util.data_add(data, cper["valid"], 4)
+
+        util.data_add(data, error_info_num, 2)
+        util.data_add(data, context_info_num, 2)
+
+        # Calculate the length of the CPER data
+        cper_length = self.ACPI_GHES_ARM_CPER_LENGTH
+        cper_length += len(pei_data)
+        cper_length += len(vendor_data)
+        cper_length += len(ctx_data)
+        util.data_add(data, cper_length, 4)
+
+        util.data_add(data, arg.get("affinity-level", 0), 1)
+
+        # Reserved
+        util.data_add(data, 0, 3)
+
+        if "midr-el1" not in arg:
+            if cpus:
+                get_mpidr = {
+                    "execute": "qom-get",
+                    "arguments": {
+                        'path': cpus[0],
+                        'property': "midr"
+                    }
+                }
+                ret = qmp_cmd.send_cmd(get_mpidr, may_open=True)
+                if isinstance(ret, int):
+                    arg["midr-el1"] = ret
+
+        util.data_add(data, arg.get("mpidr-el1", 0), 8)
+        util.data_add(data, arg.get("midr-el1", 0), 8)
+        util.data_add(data, cper["running-state"], 4)
+        util.data_add(data, arg.get("psci-state", 0), 4)
+
+        # Add PEI
+        data.extend(pei_data)
+        data.extend(ctx_data)
+        data.extend(vendor_data)
+
+        self.data = data
+
+        qmp_cmd.send_cper(cper_guid.CPER_PROC_ARM, self.data)
diff --git a/scripts/ghes_inject.py b/scripts/ghes_inject.py
new file mode 100755
index 000000000000..16bd1462e847
--- /dev/null
+++ b/scripts/ghes_inject.py
@@ -0,0 +1,48 @@
+#!/usr/bin/env python3
+#
+# pylint: disable=C0301, C0114
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2024 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+import argparse
+import sys
+
+from arm_processor_error import ArmProcessorEinj
+
+EINJ_DESC = """
+Handle ACPI GHESv2 error injection logic QEMU QMP interface.
+
+It allows using UEFI BIOS EINJ features to generate GHES records.
+
+It helps testing CPER and GHES drivers at the guest OS and how
+userspace applications at the guest handle them.
+"""
+
+def main():
+    """Main program"""
+
+    # Main parser - handle generic args like QEMU QMP TCP socket options
+    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter,
+                                     usage="%(prog)s [options]",
+                                     description=EINJ_DESC)
+
+    g_options = parser.add_argument_group("QEMU QMP socket options")
+    g_options.add_argument("-H", "--host", default="localhost", type=str,
+                           help="host name")
+    g_options.add_argument("-P", "--port", default=4445, type=int,
+                           help="TCP port number")
+    g_options.add_argument('-d', '--debug', action='store_true')
+
+    subparsers = parser.add_subparsers()
+
+    ArmProcessorEinj(subparsers)
+
+    args = parser.parse_args()
+    if "func" in args:
+        args.func(args)
+    else:
+        sys.exit(f"Please specify a valid command for {sys.argv[0]}")
+
+if __name__ == "__main__":
+    main()
diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
new file mode 100644
index 000000000000..e9e9388bcb8b
--- /dev/null
+++ b/scripts/qmp_helper.py
@@ -0,0 +1,431 @@
+#!/usr/bin/env python3
+#
+# pylint: disable=C0103,C0301,C0114,R0912,R0913,R0915,E0213,E1135,E1136,E1137,R0903
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2024 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+import json
+import socket
+import sys
+
+from base64 import b64encode
+
+class qmp:
+    """
+    Opens a connection and send/receive QMP commands.
+    """
+
+    def send_cmd(self, command, may_open=False,return_error=True):
+        """Send a command to QMP, optinally opening a connection"""
+
+        if may_open:
+            self._connect()
+        elif not self.socket:
+            return None
+
+        if isinstance(command, dict):
+            data = json.dumps(command).encode("utf-8")
+        else:
+            data = command.encode("utf-8")
+
+        self.socket.sendall(data)
+        data = self.socket.recv(1024)
+        try:
+            obj = json.loads(data.decode("utf-8"))
+        except json.JSONDecodeError as e:
+            print(f"Invalid QMP answer: {e}")
+            self._close()
+            return None
+
+        if "return" in obj:
+            if isinstance(obj.get("return"), dict):
+                if obj["return"]:
+                    return obj["return"]
+                return "OK"
+            else:
+                return obj["return"]
+
+        elif isinstance(obj.get("error"), dict):
+            error = obj["error"]
+            if return_error:
+                print(f'{error["class"]}: {error["desc"]}')
+        else:
+            print(json.dumps(obj))
+
+        return None
+
+    def _close(self):
+        """Shutdown and close the socket, if opened"""
+        if not self.socket:
+            return
+
+        self.socket.shutdown(socket.SHUT_WR)
+        while 1:
+            data = self.socket.recv(1024)
+            if data == b"":
+                break
+            try:
+                obj = json.loads(data.decode("utf-8"))
+            except json.JSONDecodeError as e:
+                print(f"Invalid QMP answer: {e}")
+                self.socket.close()
+                self.socket = None
+                return
+
+            if isinstance(obj.get("return"), dict):
+                print(json.dumps(obj["return"]))
+            if isinstance(obj.get("error"), dict):
+                error = obj["error"]
+                print(f'{error["class"]}: {error["desc"]}')
+            else:
+                print(json.dumps(obj))
+
+        self.socket.close()
+        self.socket = None
+
+    def _connect(self):
+        """Connect to a QMP TCP/IP port, if not connected yet"""
+
+        if self.socket:
+            return True
+
+        self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+        try:
+            self.socket.connect((self.host, self.port))
+        except ConnectionRefusedError:
+            sys.exit(f"Can't connect to QMP host {self.host}:{self.port}")
+
+        data = self.socket.recv(1024)
+        try:
+            obj = json.loads(data.decode("utf-8"))
+        except json.JSONDecodeError as e:
+            print(f"Invalid QMP answer: {e}")
+            self._close()
+            return False
+
+        if "QMP" not in obj:
+            print(f"Invalid QMP answer: {data.decode('utf-8')}")
+            self._close()
+            return False
+
+        result = self.send_cmd('{ "execute": "qmp_capabilities" }')
+        if not result:
+            self._close()
+            return False
+
+        return True
+
+    def __init__(self, host, port, debug=False):
+        """Initialize variables used by the QMP send logic"""
+
+        self.socket = None
+        self.host = host
+        self.port = port
+        self.debug = debug
+
+    def __del__(self):
+        self._close()
+
+    #
+    # Socket QMP send command
+    #
+    def send_cper(self, guid, data):
+        """Send commands to QEMU though QMP TCP socket"""
+
+        base64_data = b64encode(bytes(data)).decode('ascii')
+
+        cmd_arg = {
+            'cper': {
+                'notification-type': guid,
+                "raw-data": base64_data
+            }
+        }
+
+        command = '{ "execute": "ghes-cper", '
+        command += '"arguments": ' + json.dumps(cmd_arg) + " }"
+
+        if self.debug:
+            print(f"GUID: {guid}")
+            print("CPER:")
+
+            for ln_start in range(0, len(data), 16):
+                ln_end = min(ln_start + 16, len(data))
+                print(f"      {ln_start:08x}  ", end="")
+                for i in range(ln_start, ln_end):
+                    print(f"{data[i]:02x} ", end="")
+                for i in range(ln_end, ln_start + 16):
+                    print("   ", end="")
+                print("  ", end="")
+                for i in range(ln_start, ln_end):
+                    if data[i] >= 32 and data[i] < 127:
+                        print(chr(data[i]), end="")
+                    else:
+                        print(".", end="")
+
+                print()
+            print()
+
+        self._connect()
+
+        if self.send_cmd(command):
+            print("Error injected.")
+
+    def search_qom(self, path, prop, regex):
+        """
+        Return a list of devices that match path array like:
+
+            /machine/unattached/device
+            /machine/peripheral-anon/device
+            ...
+        """
+
+        found = []
+
+        i = 0
+        while 1:
+            dev = f"{path}[{i}]"
+            cmd =  {
+                "execute": "qom-get",
+                "arguments": {
+                    'path': dev,
+                    'property': prop
+                }
+            }
+            ret = self.send_cmd(cmd, may_open=True, return_error=False)
+            if not ret:
+                break
+
+            if isinstance(ret, str):
+                if regex.search(ret):
+                    found.append(dev)
+
+            i += 1
+
+        return found
+
+class util:
+    """
+    Ancillary functions to deal with bitmaps, parse arguments,
+    generate GUID and encode data on a bytearray buffer.
+    """
+
+    #
+    # Helper routines to handle multiple choice arguments
+    #
+    def get_choice(name, value, choices, suffixes=None):
+        """Produce a list from multiple choice argument"""
+
+        new_values = 0
+
+        if not value:
+            return new_values
+
+        for val in value.split(","):
+            val = val.lower()
+
+            if suffixes:
+                for suffix in suffixes:
+                    val = val.removesuffix(suffix)
+
+            if val not in choices.keys():
+                if suffixes:
+                    for suffix in suffixes:
+                        if val + suffix in choices.keys():
+                            val += suffix
+                            break
+
+            if val not in choices.keys():
+                sys.exit(f"Error on '{name}': choice '{val}' is invalid.")
+
+            val = choices[val]
+
+            new_values |= val
+
+        return new_values
+
+
+    def get_mult_array(mult, name, values, allow_zero=False, max_val=None):
+        """Add numbered hashes from integer lists"""
+
+        if not allow_zero:
+            if not values:
+                return
+        else:
+            if values is None:
+                return
+
+            if not values:
+                i = 0
+                if i not in mult:
+                    mult[i] = {}
+
+                mult[i][name] = []
+                return
+
+        i = 0
+        for value in values:
+            for val in value.split(","):
+                try:
+                    val = int(val, 0)
+                except ValueError:
+                    sys.exit(f"Error on '{name}': {val} is not an integer")
+
+                if val < 0:
+                    sys.exit(f"Error on '{name}': {val} is not unsigned")
+
+                if max_val and val > max_val:
+                    sys.exit(f"Error on '{name}': {val} is too little")
+
+                if i not in mult:
+                    mult[i] = {}
+
+                if name not in mult[i]:
+                    mult[i][name] = []
+
+                mult[i][name].append(val)
+
+            i += 1
+
+
+    def get_mult_choices(mult, name, values, choices,
+                        suffixes=None, allow_zero=False):
+        """Add numbered hashes from multiple choice arguments"""
+
+        if not allow_zero:
+            if not values:
+                return
+        else:
+            if values is None:
+                return
+
+        i = 0
+        for val in values:
+            new_values = util.get_choice(name, val, choices, suffixes)
+
+            if i not in mult:
+                mult[i] = {}
+
+            mult[i][name] = new_values
+            i += 1
+
+
+    def get_mult_int(mult, name, values, allow_zero=False):
+        """Add numbered hashes from integer arguments"""
+        if not allow_zero:
+            if not values:
+                return
+        else:
+            if values is None:
+                return
+
+        i = 0
+        for val in values:
+            try:
+                val = int(val, 0)
+            except ValueError:
+                sys.exit(f"Error on '{name}': {val} is not an integer")
+
+            if val < 0:
+                sys.exit(f"Error on '{name}': {val} is not unsigned")
+
+            if i not in mult:
+                mult[i] = {}
+
+            mult[i][name] = val
+            i += 1
+
+
+    #
+    # Data encode helper functions
+    #
+    def bit(b):
+        """Simple macro to define a bit on a bitmask"""
+        return 1 << b
+
+
+    def data_add(data, value, num_bytes):
+        """Adds bytes from value inside a bitarray"""
+
+        data.extend(value.to_bytes(num_bytes, byteorder="little"))  # pylint: disable=E1101
+
+    def to_guid(time_low, time_mid, time_high, nodes):
+        """Create an GUID string"""
+
+        assert len(nodes) == 8
+
+        clock = nodes[0] << 8 | nodes[1]
+
+        node = 0
+        for i in range(2, len(nodes)):
+            node = node << 8 | nodes[i]
+
+        s = f"{time_low:08x}-{time_mid:04x}-"
+        s += f"{time_high:04x}-{clock:04x}-{node:012x}"
+        return s
+
+class cper_guid:
+    """
+    Contains CPER GUID, as per:
+    https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html
+    """
+
+    CPER_PROC_GENERIC =  util.to_guid(0x9876CCAD, 0x47B4, 0x4bdb,
+                                    [0xB6, 0x5E, 0x16, 0xF1,
+                                     0x93, 0xC4, 0xF3, 0xDB])
+
+    CPER_PROC_X86 = util.to_guid(0xDC3EA0B0, 0xA144, 0x4797,
+                                [0xB9, 0x5B, 0x53, 0xFA,
+                                 0x24, 0x2B, 0x6E, 0x1D])
+
+    CPER_PROC_ITANIUM = util.to_guid(0xe429faf1, 0x3cb7, 0x11d4,
+                                    [0xbc, 0xa7, 0x00, 0x80,
+                                     0xc7, 0x3c, 0x88, 0x81])
+
+    CPER_PROC_ARM = util.to_guid(0xE19E3D16, 0xBC11, 0x11E4,
+                                [0x9C, 0xAA, 0xC2, 0x05,
+                                 0x1D, 0x5D, 0x46, 0xB0])
+
+    CPER_PLATFORM_MEM = util.to_guid(0xA5BC1114, 0x6F64, 0x4EDE,
+                                    [0xB8, 0x63, 0x3E, 0x83,
+                                     0xED, 0x7C, 0x83, 0xB1])
+
+    CPER_PLATFORM_MEM2 = util.to_guid(0x61EC04FC, 0x48E6, 0xD813,
+                                     [0x25, 0xC9, 0x8D, 0xAA,
+                                      0x44, 0x75, 0x0B, 0x12])
+
+    CPER_PCIE = util.to_guid(0xD995E954, 0xBBC1, 0x430F,
+                            [0xAD, 0x91, 0xB4, 0x4D,
+                             0xCB, 0x3C, 0x6F, 0x35])
+
+    CPER_PCI_BUS = util.to_guid(0xC5753963, 0x3B84, 0x4095,
+                               [0xBF, 0x78, 0xED, 0xDA,
+                                0xD3, 0xF9, 0xC9, 0xDD])
+
+    CPER_PCI_DEV = util.to_guid(0xEB5E4685, 0xCA66, 0x4769,
+                               [0xB6, 0xA2, 0x26, 0x06,
+                                0x8B, 0x00, 0x13, 0x26])
+
+    CPER_FW_ERROR = util.to_guid(0x81212A96, 0x09ED, 0x4996,
+                                [0x94, 0x71, 0x8D, 0x72,
+                                 0x9C, 0x8E, 0x69, 0xED])
+
+    CPER_DMA_GENERIC = util.to_guid(0x5B51FEF7, 0xC79D, 0x4434,
+                                   [0x8F, 0x1B, 0xAA, 0x62,
+                                    0xDE, 0x3E, 0x2C, 0x64])
+
+    CPER_DMA_VT = util.to_guid(0x71761D37, 0x32B2, 0x45cd,
+                              [0xA7, 0xD0, 0xB0, 0xFE,
+                               0xDD, 0x93, 0xE8, 0xCF])
+
+    CPER_DMA_IOMMU = util.to_guid(0x036F84E1, 0x7F37, 0x428c,
+                                [0xA7, 0x9E, 0x57, 0x5F,
+                                 0xDF, 0xAA, 0x84, 0xEC])
+
+    CPER_CCIX_PER = util.to_guid(0x91335EF6, 0xEBFB, 0x4478,
+                                [0xA6, 0xA6, 0x88, 0xB7,
+                                 0x28, 0xCF, 0x75, 0xD7])
+
+    CPER_CXL_PROT_ERR = util.to_guid(0x80B9EFB4, 0x52B5, 0x4DE3,
+                                    [0xA7, 0x77, 0x68, 0x78,
+                                     0x4B, 0x77, 0x10, 0x48])
-- 
2.45.2


