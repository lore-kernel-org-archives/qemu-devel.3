Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606A9D74ECF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:38:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjHKl-0007q3-Uk; Fri, 23 Jan 2026 08:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHKV-0007fM-3b
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:36:06 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHKR-0004eG-43
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:36:02 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E1C5960010;
 Fri, 23 Jan 2026 13:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760F9C4CEF1;
 Fri, 23 Jan 2026 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769175357;
 bh=EmQeFY0Ph0iY+ei/fVP2lTzsVgetZHcMU/ameqRXywY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FknLJb34Jfz6cXQYDQPhyJTsZmbkWaPmqWu0TfwxOO7NNHx0h0vsiSBVeNagIIUft
 e6XyhmJCLGI+mIUI8Zvt+3OTioCI9lCeAJ3zhNDO5qg9PMSpZJS9OV4ze0VfJAIRNj
 l34hy84iwSn5JE6mwVLbJdsk/b3qG7r7gvOf8VAhaBeGqTMNqntTJ44qlOtwpDUHG/
 kGXiBshnfnmCebRYGxZuQYZ6OFXbH46bBRowyqyyMwAtYUMbVs9A257jc3l1WwflE2
 7ksa12GCya3Rvjr0mtsHjxhhGziyGIEUeiJy0X2BykQRvMj1FpD/cgiyMB9BoLorne
 MDBE1rVEOIfGw==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHKK-000000063K7-0NUl; Fri, 23 Jan 2026 14:35:55 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 09/13] scripts/ghes_inject: add a handler for PCI/PCI-X bus
 error
Date: Fri, 23 Jan 2026 14:35:23 +0100
Message-ID: <35c61dd959e8d2687fa282c44471a9de5ef50ad5.1769175070.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769175069.git.mchehab+huawei@kernel.org>
References: <cover.1769175069.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a logic to do PCIe BUS error injection.

On Linux Kernel, despite CPER_SEC_PCI_X_BUS macro is defined for such
event, ghes.c doesn't implement support for it yet:

[16950.077494] {26}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
[16950.077866] {26}[Hardware Error]: event severity: recoverable
[16950.078118] {26}[Hardware Error]:  Error 0, type: recoverable
[16950.078444] {26}[Hardware Error]:   section type: unknown, c5753963-3b84-4095-bf78-eddad3f9c9dd
[16950.078800] {26}[Hardware Error]:   section length: 0x48
[16950.079069] {26}[Hardware Error]:   00000000: 00000000 00000000 00000000 00000000  ................
[16950.079442] {26}[Hardware Error]:   00000010: 00000001 00000000 00000000 00000000  ................
[16950.079811] {26}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
[16950.080181] {26}[Hardware Error]:   00000030: 00000000 00000000 00000000 00000000  ................
[16950.080538] {26}[Hardware Error]:   00000040: 00000000 00000000                    ........

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 MAINTAINERS              |   1 +
 scripts/ghes_inject.py   |   2 +
 scripts/pci_bus_error.py | 146 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 scripts/pci_bus_error.py

diff --git a/MAINTAINERS b/MAINTAINERS
index a970c47dd089..1e62064a8672 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2228,6 +2228,7 @@ F: qapi/acpi-hest.json
 F: scripts/ghes_decode.py
 F: scripts/ghes_inject.py
 F: scripts/arm_processor_error.py
+F: scripts/pci_bus_error.py
 F: scripts/qmp_helper.py
 
 ppc4xx
diff --git a/scripts/ghes_inject.py b/scripts/ghes_inject.py
index 6ac917d0b5db..be2384a59b3e 100755
--- a/scripts/ghes_inject.py
+++ b/scripts/ghes_inject.py
@@ -12,6 +12,7 @@
 import sys
 
 from arm_processor_error import ArmProcessorEinj
+from pci_bus_error import PciBusError
 
 EINJ_DESC = """
 Handle ACPI GHESv2 error injection logic QEMU QMP interface.
@@ -40,6 +41,7 @@ def main():
     subparsers = parser.add_subparsers()
 
     ArmProcessorEinj(subparsers)
+    PciBusError(subparsers)
 
     args = parser.parse_args()
     if "func" in args:
diff --git a/scripts/pci_bus_error.py b/scripts/pci_bus_error.py
new file mode 100644
index 000000000000..5abfdf11c868
--- /dev/null
+++ b/scripts/pci_bus_error.py
@@ -0,0 +1,146 @@
+#!/usr/bin/env python3
+#
+# pylint: disable=C0114,R0903
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2024 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+from qmp_helper import qmp, util, cper_guid
+
+class PciBusError:
+    """
+    Implements PCI Express bus error injection via GHES
+    """
+
+    def __init__(self, subparsers):
+        """Initialize the error injection class and add subparser"""
+
+        # Valid values
+        self.valid_bits = {
+            "status": util.bit(0),
+            "type": util.bit(1),
+            "bus-id": util.bit(2),
+            "bus-addr": util.bit(3),
+            "bus-data": util.bit(4),
+            "command": util.bit(5),
+            "requestor-id": util.bit(6),
+            "completer-id": util.bit(7),
+            "target-id": util.bit(8),
+        }
+
+        self.bus_command_bits = {
+            "pci": 0,               # Bit 56 is zero
+            "pci-x": util.bit(56)
+        }
+
+        self.data = bytearray()
+
+        parser = subparsers.add_parser("pci-bus",
+                                       description="Generate PCI/PCI-X bus error CPER")
+        g_pci = parser.add_argument_group("PCI/PCI-X bus error")
+
+        valid_bits = ",".join(self.valid_bits.keys())
+        bus_command_bits = ",".join(self.bus_command_bits.keys())
+
+        g_pci.add_argument("-v", "--valid",
+                            help=f"Valid bits: {valid_bits}")
+        g_pci.add_argument("-s", "--error-status",
+                            type=lambda x: int(x, 0),
+                            help="Error Status")
+        g_pci.add_argument("-t", "--error-type",
+                            type=lambda x: int(x, 0),
+                            help="Error type")
+        g_pci.add_argument("-b", "--bus-number",
+                            type=lambda x: int(x, 0),
+                            help="Bus number")
+        g_pci.add_argument("-S", "--segment-number",
+                            type=lambda x: int(x, 0),
+                            help="Segment number")
+        g_pci.add_argument("-a", "--bus-address",
+                            type=lambda x: int(x, 0),
+                            help="Bus address")
+        g_pci.add_argument("-d", "--bus-data",
+                            type=lambda x: int(x, 0),
+                            help="Bus data")
+        g_pci.add_argument("-c", "--bus-command",
+                            help=f"bus-command: {bus_command_bits}")
+        g_pci.add_argument("-r", "--bus-requestor",
+                            type=lambda x: int(x, 0),
+                            help="Bus requestor ID")
+        g_pci.add_argument("-C", "--bus-completer",
+                            type=lambda x: int(x, 0),
+                            help="Bus completer ID")
+        g_pci.add_argument("-i", "--target-id",
+                            type=lambda x: int(x, 0),
+                            help="Target ID")
+
+        parser.set_defaults(func=self.send_cper)
+
+    def send_cper(self, args):
+        """Parse subcommand arguments and send a CPER via QMP"""
+
+        qmp_cmd = qmp(args.host, args.port, args.debug)
+
+        cper = {}
+        arg = vars(args)
+
+        # Handle global parameters
+        if args.valid:
+            valid_init = False
+            cper["valid"] = util.get_choice(name="valid",
+                                            value=args.valid,
+                                            choices=self.valid_bits)
+        else:
+            cper["valid"] = 0
+            valid_init = True
+
+        if args.bus_command:
+            cper["bus-command"] = util.get_choice(name="bus-command",
+                                                    value=args.bus_command,
+                                                    choices=self.bus_command_bits)
+        if valid_init:
+            if args.error_status:
+                cper["valid"] |= self.valid_bits["status"]
+
+            if args.error_type:
+                cper["valid"] |= self.valid_bits["type"]
+
+            if args.bus_number and args.bus_segment:
+                cper["valid"] |= self.valid_bits["bus-id"]
+
+            if args.bus_address:
+                cper["valid"] |= self.valid_bits["bus-address"]
+
+            if args.bus_data:
+                cper["valid"] |= self.valid_bits["bus-data"]
+
+            if args.bus_requestor:
+                cper["valid"] |= self.valid_bits["requestor-id"]
+
+            if args.bus_completer:
+                cper["valid"] |= self.valid_bits["completer-id"]
+
+            if args.target_id:
+                cper["valid"] |= self.valid_bits["target-id"]
+
+        util.data_add(self.data, cper["valid"], 8)
+        util.data_add(self.data, arg.get("error-status", 0), 8)
+        util.data_add(self.data, arg.get("error-type", util.bit(0)), 2)
+
+        # Bus ID
+        util.data_add(self.data, arg.get("bus-number", 0), 1)
+        util.data_add(self.data, arg.get("segment-number", 0), 1)
+
+        # Reserved
+        util.data_add(self.data, 0, 4)
+
+        util.data_add(self.data, arg.get("bus-address", 0), 8)
+        util.data_add(self.data, arg.get("bus-data", 0), 8)
+
+        util.data_add(self.data, cper.get("bus-command", 0), 8)
+
+        util.data_add(self.data, arg.get("bus-requestor", 0), 8)
+        util.data_add(self.data, arg.get("bus-completer", 0), 8)
+        util.data_add(self.data, arg.get("target-id", 0), 8)
+
+        return qmp_cmd.send_cper(cper_guid.CPER_PCI_BUS, self.data)
-- 
2.52.0


