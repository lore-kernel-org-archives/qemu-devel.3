Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077B4EA4FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 11:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuUSg-0004Tk-Ge; Mon, 23 Feb 2026 06:50:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSb-0004RJ-1I
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:50:45 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSV-0004rl-Vf
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:50:43 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 37D6344566;
 Mon, 23 Feb 2026 11:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6518C2BCB4;
 Mon, 23 Feb 2026 11:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771847434;
 bh=rjmDNNlvZkwC92TC2LUA0XsfeJyHDjXh9KUhvuqW8gc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VIvUzmFobk640zvGPlGMFWRQQAHl/stm5rw+wqaQD+wsZudNTPfBmZ/57SN8DmGkq
 RwDAp4at5wcRN5Ewl5J+5+KXGXanu+vz66DG42ijWSI4t1zSaHFQFhcoT2bJ0Hw2MD
 wrpcV55zA2NWA6Ij4sbmEkvyNS38gGDiT8Zr43EpVMRFJiJP+T0UB+ZfVDt4LSehU0
 3vPCg++2i8rDnZZWi5C8N0h+LhZxEK6KewqrruQ/KQR7zVdrTvmEfK3hzJiPZ5aRm5
 yeurWEXP4xks2LhqqL1mx+WmpcXtD+0OWFly+7qhEjm7dqPswhUH9twVhlObaDVT4G
 z4qPBMftUU6Og==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSO-00000007Jok-0lkG; Mon, 23 Feb 2026 12:50:32 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v3 11/14] scripts/ghes_inject: add support for fuzzy logic
 testing
Date: Mon, 23 Feb 2026 12:50:27 +0100
Message-ID: <e6c0c3bcf5a32f1cdc955f2903f8c3a4b38f2a55.1771847176.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771847176.git.mchehab+huawei@kernel.org>
References: <cover.1771847176.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add a command to inject random errors for fuzzy logic testing.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS            |   1 +
 scripts/fuzzy_error.py | 206 +++++++++++++++++++++++++++++++++++++++++
 scripts/ghes_inject.py |   2 +
 3 files changed, 209 insertions(+)
 create mode 100644 scripts/fuzzy_error.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 48067a618523..e553f8252f14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2228,6 +2228,7 @@ F: qapi/acpi-hest.json
 F: scripts/ghes_decode.py
 F: scripts/ghes_inject.py
 F: scripts/arm_processor_error.py
+F: scripts/fuzzy_error.py
 F: scripts/pcie_bus_error.py
 F: scripts/qmp_helper.py
 
diff --git a/scripts/fuzzy_error.py b/scripts/fuzzy_error.py
new file mode 100644
index 000000000000..f816e47a5af8
--- /dev/null
+++ b/scripts/fuzzy_error.py
@@ -0,0 +1,206 @@
+#!/usr/bin/env python3
+#
+# pylint: disable=C0114,R0903,R0912
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2024 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+
+import argparse
+import sys
+
+from time import sleep
+from random import randrange
+from qmp_helper import qmp, util, cper_guid
+
+class FuzzyError:
+    """
+    Implements Fuzzy error injection via GHES
+    """
+
+    def __init__(self, subparsers):
+        """Initialize the error injection class and add subparser"""
+
+        # as defined at UEFI spec v2.10, section N.2.2
+        # Sizes here are just hints to have some default
+        self.types = {
+            "proc-generic": {
+                "guid": cper_guid.CPER_PROC_GENERIC,
+                "default_size": 192
+            },
+            "proc-x86": {
+                "guid": cper_guid.CPER_PROC_X86,
+                "default_size": 64
+            },
+            "proc-itanium": {
+                "guid": cper_guid.CPER_PROC_ITANIUM,
+                "default_size": 64
+            },
+            "proc-arm": {
+                "guid": cper_guid.CPER_PROC_ARM,
+                "default_size": 72
+            },
+            "platform-mem": {
+                "guid": cper_guid.CPER_PLATFORM_MEM,
+                "default_size": 80
+            },
+            "platform-mem2": {
+                "guid": cper_guid.CPER_PLATFORM_MEM2,
+                "default_size": 96
+            },
+            "pcie": {
+                "guid": cper_guid.CPER_PCIE,
+                "default_size": 208
+            },
+            "pci-bus": {
+                "guid": cper_guid.CPER_PCI_BUS,
+                "default_size": 72
+            },
+            "pci-dev": {
+                "guid": cper_guid.CPER_PCI_DEV,
+                "default_size": 56
+            },
+            "firmware-error": {
+                "guid": cper_guid.CPER_FW_ERROR,
+                "default_size": 32
+            },
+            "dma-generic": {
+                "guid": cper_guid.CPER_DMA_GENERIC,
+                "default_size": 32
+            },
+            "dma-vt": {
+                "guid": cper_guid.CPER_DMA_VT,
+                "default_size": 144
+            },
+            "dma-iommu": {
+                "guid": cper_guid.CPER_DMA_IOMMU,
+                "default_size": 144
+            },
+            "ccix-per": {
+                "guid": cper_guid.CPER_CCIX_PER,
+                "default_size": 36
+            },
+            "cxl-prot-err": {
+                "guid": cper_guid.CPER_CXL_PROT_ERR,
+                "default_size": 116
+            },
+            "cxl-evt-media": {
+                "guid": cper_guid.CPER_CXL_EVT_GEN_MEDIA,
+                "default_size": 32
+            },
+            "cxl-evt-dram": {
+                "guid": cper_guid.CPER_CXL_EVT_DRAM,
+                "default_size": 64
+            },
+            "cxl-evt-mem-module": {
+                "guid": cper_guid.CPER_CXL_EVT_MEM_MODULE,
+                "default_size": 64
+            },
+            "cxl-evt-mem-sparing": {
+                "guid": cper_guid.CPER_CXL_EVT_MEM_SPARING,
+                "default_size": 64
+            },
+            "cxl-evt-phy-sw": {
+                "guid": cper_guid.CPER_CXL_EVT_PHY_SW,
+                "default_size": 64
+            },
+            "cxl-evt-virt-sw": {
+                "guid": cper_guid.CPER_CXL_EVT_VIRT_SW,
+                "default_size": 64
+            },
+            "cxl-evt-mdl-port": {
+                "guid": cper_guid.CPER_CXL_EVT_MLD_PORT,
+                "default_size": 64
+            },
+            "cxl-evt-dyna-cap": {
+                "guid": cper_guid.CPER_CXL_EVT_DYNA_CAP,
+                "default_size": 64
+            },
+            "fru-mem-poison": {
+                "guid": cper_guid.CPER_FRU_MEM_POISON,
+                "default_size": 72
+            },
+        }
+
+        parser = subparsers.add_parser("fuzzy-test", aliases=['fuzzy'],
+                                       description="Inject a fuzzy test CPER",
+                                       formatter_class=argparse.RawTextHelpFormatter)
+        g_fuzzy = parser.add_argument_group("Fuzz testing error inject")
+
+
+        cper_types = ",".join(self.types.keys())
+
+        g_fuzzy.add_argument("-T", "--type",
+                            help=f"Type of the error: {cper_types}")
+        g_fuzzy.add_argument("--min-size",
+                    type=lambda x: int(x, 0),
+                    help="Minimal size of the CPER")
+        g_fuzzy.add_argument("--max-size",
+                    type=lambda x: int(x, 0),
+                    help="Maximal size of the CPER")
+        g_fuzzy.add_argument("-z", "--zero", action="store_true",
+                            help="Zero all bytes of the CPER payload (default: %(default)s)")
+        g_fuzzy.add_argument("-t", "--timeout", type=float,
+                    default=30.0,
+                    help="Specify timeout for CPER send retries (default: %(default)s seconds)")
+        g_fuzzy.add_argument("-d", "--delay", type=float,
+                    default=0,
+                    help="Specify a delay between multiple CPER (default: %(default)s)")
+        g_fuzzy.add_argument("-c", "--count", type=int,
+                    default=1,
+                    help="Specify the number of CPER records to be sent (default: %(default)s)")
+
+        parser.set_defaults(func=self.send_cper)
+
+    def send_cper(self, args):
+        """Parse subcommand arguments and send a CPER via QMP"""
+
+        qmp_cmd = qmp(args.host, args.port, args.debug)
+
+        args.count = max(args.count, 1)
+
+        for i in range(0, args.count):
+            if i:
+                if args.delay > 0:
+                    sleep(args.delay)
+
+            # Handle global parameters
+            if args.type:
+                if not args.type in self.types:
+                    sys.exit(f"Invalid type: {args.type}")
+
+                inj_type = args.type
+            else:
+                i = randrange(len(self.types))
+                keys = list(self.types.keys())
+                inj_type = keys[i]
+
+            inject = self.types[inj_type]
+
+            guid = inject["guid"]
+            min_size = inject["default_size"]
+            max_size = min_size
+
+            if args.min_size:
+                min_size = args.min_size
+
+            if args.max_size:
+                max_size = args.max_size
+
+            size = min_size
+
+            if min_size < max_size:
+                size += randrange(max_size - min_size)
+
+            data = bytearray()
+
+            if not args.zero:
+                for i in range(size):
+                    util.data_add(data, randrange(256), 1)
+            else:
+                for i in range(size):
+                    util.data_add(data, 0, 1)
+
+            print(f"Injecting {inj_type} with {size} bytes")
+            ret = qmp_cmd.send_cper(guid, data, timeout=args.timeout)
+            if ret and ret != "OK":
+                return ret
diff --git a/scripts/ghes_inject.py b/scripts/ghes_inject.py
index 29a6a57508cd..9b0a2443fc97 100755
--- a/scripts/ghes_inject.py
+++ b/scripts/ghes_inject.py
@@ -13,6 +13,7 @@
 
 from arm_processor_error import ArmProcessorEinj
 from pcie_bus_error import PcieBusError
+from fuzzy_error import FuzzyError
 
 EINJ_DESC = """
 Handle ACPI GHESv2 error injection logic QEMU QMP interface.
@@ -42,6 +43,7 @@ def main():
 
     ArmProcessorEinj(subparsers)
     PcieBusError(subparsers)
+    FuzzyError(subparsers)
 
     args = parser.parse_args()
     if "func" in args:
-- 
2.53.0


