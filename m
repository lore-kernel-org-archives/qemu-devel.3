Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091F606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oobKHG0O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPyfx-0003EW-57; Sun, 08 Nov 2026 03:54:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfq-0003As-Va
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:52 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfg-0000wo-18
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:42 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A15744D11;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1552E1F008BD;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794128075;
 bh=V+YrM732g6g1+Y72xvbSDsPOwg56CGO+x7ck3PY9PXM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oobKHG0OSZrnx3xlVm0xOHNAwagEAAv3WdBGWwN3czaibxqL9UXu48Vk1tADSijL+
 Gfz6aoaoSbymyyASh+dYOJVA7RYk4wRaGSeD9H1fkaA+sK7Upq+uKK9od1oKRD1+wr
 nzmDwnnfbgCCoV093QumcqrPE2G6fA3iJKb8bzLLtLQ8H41kjiwoe+LAKR3Mz32IY+
 E4D7oTC5RD176G4her+Bvpz9cCFDqM78i6lMIkEiUUUIGrY1dU8PCNbmOWi5FIR6cq
 Zz+Axc5+6wgnRWcbIn7MqNrMAWxNtecY0AKYOoWuFC8nKGI5Cg/rr2qprQy7kFGKUL
 wyLBPfbZ7Eiew==
Received: from mchehab by mail.kernel.org with local (Exim 4.100.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfZ-00000005UjV-1gKI; Sun, 08 Nov 2026 09:54:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 09/13] scripts/ghes_inject: add support for fuzzy logic testing
Date: Sun,  8 Nov 2026 09:54:22 +0100
Message-ID: <c1eb390b971ef3868e8afdea5e9b02a846b1c986.1794127710.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794127710.git.mchehab+huawei@kernel.org>
References: <cover.1794127710.git.mchehab+huawei@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
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

Add a command to inject random errors for fuzzy logic testing.

By default, it will generate a single test for a random valid
GUID with random bytes inside the CPER payload.

The command allows specifying:
- a single type of CPER;
- a range of minimum/maximum payload size;
- change its default to fill with zero instead of random;
- multiple CPERs with an specified count;
- ensure a delay between them;
- setup a timeout to retry if an attempt fails (useful when
  count > 1).

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS            |   1 +
 scripts/fuzzy_error.py | 206 +++++++++++++++++++++++++++++++++++++++++
 scripts/ghes_inject.py |   2 +
 3 files changed, 209 insertions(+)
 create mode 100644 scripts/fuzzy_error.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 75fbe5967c73..dae90bcc1250 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2386,6 +2386,7 @@ F: qapi/acpi-hest.json
 F: scripts/ghes_decode.py
 F: scripts/ghes_inject.py
 F: scripts/arm_processor_error.py
+F: scripts/fuzzy_error.py
 F: scripts/pci_bus_error.py
 F: scripts/qmp_helper.py
 
diff --git a/scripts/fuzzy_error.py b/scripts/fuzzy_error.py
new file mode 100644
index 000000000000..9f80abb72319
--- /dev/null
+++ b/scripts/fuzzy_error.py
@@ -0,0 +1,206 @@
+#!/usr/bin/env python3
+#
+# pylint: disable=C0114,R0903,R0912
+# SPDX-License-Identifier: GPL-2.0
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
index be2384a59b3e..bcbfffc586e1 100755
--- a/scripts/ghes_inject.py
+++ b/scripts/ghes_inject.py
@@ -13,6 +13,7 @@
 
 from arm_processor_error import ArmProcessorEinj
 from pci_bus_error import PciBusError
+from fuzzy_error import FuzzyError
 
 EINJ_DESC = """
 Handle ACPI GHESv2 error injection logic QEMU QMP interface.
@@ -42,6 +43,7 @@ def main():
 
     ArmProcessorEinj(subparsers)
     PciBusError(subparsers)
+    FuzzyError(subparsers)
 
     args = parser.parse_args()
     if "func" in args:
-- 
2.56.0


