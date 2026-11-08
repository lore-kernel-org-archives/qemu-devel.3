Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E6F606A321
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eifTJS5H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPyfn-0003AX-3B; Sun, 08 Nov 2026 03:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfi-00039j-03
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:42 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyff-0000wn-Uw
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:41 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 52E3844D0C;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115CA1F008AB;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794128075;
 bh=Mdj5Hi6KabLHisxENovGiiA3tDju9onZmLEwA1byQWY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eifTJS5HLO8vfGGKh4HJpO+yfGIEi3G8Zn7MKEU5GZHrEE4xKV+yNB1D32uiOYjyk
 2G6CwQWJv3DS8v5cHcGZUPKJs597E6wSH8IxbQOHKiBtzcFZANZMIbglLcc4zP0bfq
 ewdvEKu9F1ev2q+IjrXM2o/I8WKe7CXoh76z5Q32u4sxSclt6YtlDun013MRTuC3Rb
 d+i9MMB/fpfnpmbSZbW+WUwpB4lMhybH1xPBmOqsfTO7TtXe+br/Nac5CaOBi9QloB
 irrBgD84uwFqq+cgQFzcw0yyc+uexa6QkkaQkJZbpNMvI4FyUeVtczmU9Ii412robU
 BsTbsHBwzIbKA==
Received: from mchehab by mail.kernel.org with local (Exim 4.100.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfZ-00000005UjR-1Zhv; Sun, 08 Nov 2026 09:54:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH 08/13] scripts/ghes_inject: add a handler for PCI/PCI-X bus
 error
Date: Sun,  8 Nov 2026 09:54:21 +0100
Message-ID: <86671a72afbd3ed02287f337efb28d88bdb240a9.1794127710.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794127710.git.mchehab+huawei@kernel.org>
References: <cover.1794127710.git.mchehab+huawei@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 scripts/pci_bus_error.py | 151 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 scripts/pci_bus_error.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d817e8c4d65..75fbe5967c73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2386,6 +2386,7 @@ F: qapi/acpi-hest.json
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
index 000000000000..1d974c54685c
--- /dev/null
+++ b/scripts/pci_bus_error.py
@@ -0,0 +1,151 @@
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
+        arg = {key.replace("_", "-"): value for key, value in vars(args).items()
+               if value is not None}
+        self.data = bytearray()
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
+            if args.bus_command is not None:
+                cper["valid"] |= self.valid_bits["command"]
+
+            if args.error_status is not None:
+                cper["valid"] |= self.valid_bits["status"]
+
+            if args.error_type is not None:
+                cper["valid"] |= self.valid_bits["type"]
+
+            if args.bus_number is not None or args.segment_number is not None:
+                cper["valid"] |= self.valid_bits["bus-id"]
+
+            if args.bus_address is not None:
+                cper["valid"] |= self.valid_bits["bus-addr"]
+
+            if args.bus_data is not None:
+                cper["valid"] |= self.valid_bits["bus-data"]
+
+            if args.bus_requestor is not None:
+                cper["valid"] |= self.valid_bits["requestor-id"]
+
+            if args.bus_completer is not None:
+                cper["valid"] |= self.valid_bits["completer-id"]
+
+            if args.target_id is not None:
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
2.56.0


