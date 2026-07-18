Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F46C4451B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2026 22:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlDIb-0003Kx-IU; Sat, 18 Jul 2026 18:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDIZ-0003IN-Fz; Sat, 18 Jul 2026 18:14:19 -0400
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.35.192.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=65292d44c=graf@amazon.de>)
 id 1wlDIW-00075F-E8; Sat, 18 Jul 2026 18:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1784412856; x=1815948856;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vy1o3AJjcyfUw/oY+KjNrWsUY2TJlLRqRASFwP66+E0=;
 b=n0mvR4EglFN5ddsgIkJNEsY8dtu4BKHdAhZ31To5Y/uh06gxvc4c3xq1
 6ryZ286mhG//xyBQpEd0vWVfEkCMZDgDGQpGquoVUuto8DAb6YI7hyo3R
 /HvE8fzg+eJ5Jzj9M3UR55EaZIAGwMKWbnLGOaU9F9JWj2WKXK03qBmbm
 CB+IiGxLiMfUFgIh6FIT6EWm08W9pkbCvUCirhcnfpbKuoUM3wxCjJqkn
 wGo9kZVN1ST+sznFej/qzNRljN2SMAQ/bxvxCIkJvDs+Xn0cLYLbvTg3h
 Dksy751H0H8hDvMLp/9zYScLdfGvshF1t9OW1lJPnHO4En8yAeYLHKAqc Q==;
X-CSE-ConnectionGUID: LOyAV7piSf2oO3ap4Swb0A==
X-CSE-MsgGUID: HX2VoUxbTwuiHDUg0i+vpg==
X-IronPort-AV: E=Sophos;i="6.25,171,1779148800"; d="scan'208";a="23695342"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2026 22:14:11 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:9457]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.34:2525]
 with esmtp (Farcaster)
 id 4c37119c-f9b8-48a3-859b-f0c500c06906; Sat, 18 Jul 2026 22:14:11 +0000 (UTC)
X-Farcaster-Flow-ID: 4c37119c-f9b8-48a3-859b-f0c500c06906
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:14:11 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 18 Jul 2026 22:14:01 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Fabiano Rosas
 <farosas@suse.de>, Francisco Iglesias <francisco.iglesias@amd.com>, "Gaurav
 Sharma" <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, Laurent Vivier <laurent@vivier.eu>, "Manos
 Pitsidianakis" <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>, "Subbaraya
 Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth <th.huth+qemu@posteo.eu>, "Ran
 Wang" <wangran@bosc.ac.cn>, Hao Wu <wuhaotsh@google.com>
Subject: [RFC PATCH v2 133/137] docs, qapi, scripts,
 iotests: Update /machine/unattached path references
Date: Sat, 18 Jul 2026 21:36:48 +0000
Message-ID: <20260718213652.37673-134-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260718213652.37673-1-graf@amazon.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260718213652.37673-1-graf@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.35.192.45;
 envelope-from=prvs=65292d44c=graf@amazon.de;
 helo=pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Board-created devices no longer land in /machine/unattached and the
next commit removes the container entirely.  Update the in-tree
consumers of the old paths:

  scripts/arm_processor_error.py, scripts/qmp_helper.py
    Search for CPUs directly under /machine.
  docs/devel/s390-cpu-topology.rst, docs/system/cpu-hotplug.rst
  qapi/{block-core,block,machine,qom}.json
    Refresh example qom-path strings.
  tests/qemu-iotests/common.filter
    _filter_qom_path() now normalizes any /machine/... device path
    so the reference outputs are stable across board naming changes.
  tests/qemu-iotests/{172,186}.out
    Regenerated against the new filter.

AI-used-for: code (refactoring)
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 docs/devel/s390-cpu-topology.rst |  2 +-
 docs/system/cpu-hotplug.rst      |  4 +-
 qapi/block-core.json             | 12 +++---
 qapi/block.json                  |  2 +-
 qapi/machine.json                | 12 +++---
 qapi/qom.json                    |  4 +-
 scripts/arm_processor_error.py   |  3 +-
 scripts/qmp_helper.py            |  2 +-
 tests/qemu-iotests/172.out       | 72 ++++++++++++++++----------------
 tests/qemu-iotests/186.out       | 10 ++---
 tests/qemu-iotests/common.filter |  2 +-
 11 files changed, 62 insertions(+), 63 deletions(-)

diff --git a/docs/devel/s390-cpu-topology.rst b/docs/devel/s390-cpu-topology.rst
index 48313b92d4..26be230969 100644
--- a/docs/devel/s390-cpu-topology.rst
+++ b/docs/devel/s390-cpu-topology.rst
@@ -40,7 +40,7 @@ modifiers for all configured vCPUs.
       },
       "cpu-state": "operating",
       "entitlement": "medium",
-      "qom-path": "/machine/unattached/device[0]",
+      "qom-path": "/machine/cpu[0]",
       "cpu-index": 0,
       "target": "s390x"
     },
diff --git a/docs/system/cpu-hotplug.rst b/docs/system/cpu-hotplug.rst
index cc50937c36..f838faba6f 100644
--- a/docs/system/cpu-hotplug.rst
+++ b/docs/system/cpu-hotplug.rst
@@ -47,7 +47,7 @@ vCPU hotplug
                       "socket-id": 0,
                       "thread-id": 0
                   },
-                  "qom-path": "/machine/unattached/device[0]",
+                  "qom-path": "/machine/cpu[0]",
                   "type": "IvyBridge-IBRS-x86_64-cpu",
                   "vcpus-count": 1
               }
@@ -95,7 +95,7 @@ vCPU hotplug
                       "socket-id": 0,
                       "thread-id": 0
                   },
-                  "qom-path": "/machine/unattached/device[0]",
+                  "qom-path": "/machine/cpu[0]",
                   "target": "x86_64",
                   "thread-id": 28957
               },
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1f87b07850..28487f7cae 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -928,7 +928,7 @@
 #                 "device":"ide1-cd0",
 #                 "locked":false,
 #                 "removable":true,
-#                 "qdev": "/machine/unattached/device[23]",
+#                 "qdev": "/machine/ide[1]/ide.1/cd0",
 #                 "tray_open": false,
 #                 "type":"unknown"
 #              },
@@ -936,7 +936,7 @@
 #                 "device":"floppy0",
 #                 "locked":false,
 #                 "removable":true,
-#                 "qdev": "/machine/unattached/device[20]",
+#                 "qdev": "/machine/fdc/floppy[0]",
 #                 "type":"unknown"
 #              },
 #              {
@@ -1310,7 +1310,7 @@
 #                    "account_invalid":true,
 #                    "account_failed":false
 #                 },
-#                 "qdev": "/machine/unattached/device[23]"
+#                 "qdev": "/machine/ide[0]/ide.0/hd0"
 #              },
 #              {
 #                 "device":"ide1-cd0",
@@ -1329,7 +1329,7 @@
 #                    "account_invalid":false,
 #                    "account_failed":false
 #                 },
-#                 "qdev": "/machine/unattached/device[24]"
+#                 "qdev": "/machine/ide[1]/ide.1/cd0"
 #              },
 #              {
 #                 "device":"floppy0",
@@ -1348,7 +1348,7 @@
 #                    "account_invalid":false,
 #                    "account_failed":false
 #                 },
-#                 "qdev": "/machine/unattached/device[16]"
+#                 "qdev": "/machine/fdc/floppy[0]"
 #              },
 #              {
 #                 "device":"sd0",
@@ -5750,7 +5750,7 @@
 # .. qmp-example::
 #
 #     <- { "event": "BLOCK_IO_ERROR",
-#          "data": { "qom-path": "/machine/unattached/device[0]",
+#          "data": { "qom-path": "/machine/ide[0]/ide.0/hd1",
 #                    "device": "ide0-hd1",
 #                    "node-name": "#block212",
 #                    "operation": "write",
diff --git a/qapi/block.json b/qapi/block.json
index 46955bbb3e..cb177180e7 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -404,7 +404,7 @@
 #
 #     <- { "event": "DEVICE_TRAY_MOVED",
 #          "data": { "device": "ide1-cd0",
-#                    "id": "/machine/unattached/device[22]",
+#                    "id": "/machine/ide[1]/ide.1/cd0",
 #                    "tray-open": true
 #          },
 #          "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
diff --git a/qapi/machine.json b/qapi/machine.json
index 9b2248038f..2d39d650ce 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -121,7 +121,7 @@
 #                     "thread-id": 0,
 #                     "socket-id": 0
 #                 },
-#                 "qom-path": "/machine/unattached/device[0]",
+#                 "qom-path": "/machine/cpu[0]",
 #                 "target":"x86_64",
 #                 "cpu-index": 0
 #             },
@@ -132,7 +132,7 @@
 #                     "thread-id": 0,
 #                     "socket-id": 1
 #                 },
-#                 "qom-path": "/machine/unattached/device[2]",
+#                 "qom-path": "/machine/cpu[1]",
 #                 "target":"x86_64",
 #                 "cpu-index": 1
 #             }
@@ -1028,7 +1028,7 @@
 #          { "props": { "core-id": 8 }, "type": "POWER8-spapr-cpu-core",
 #            "vcpus-count": 1 },
 #          { "props": { "core-id": 0 }, "type": "POWER8-spapr-cpu-core",
-#            "vcpus-count": 1, "qom-path": "/machine/unattached/device[0]"}
+#            "vcpus-count": 1, "qom-path": "/machine/cpu[0]"}
 #        ]}
 #
 # .. qmp-example::
@@ -1043,7 +1043,7 @@
 #             "props": {"core-id": 0, "socket-id": 1, "thread-id": 0}
 #          },
 #          {
-#             "qom-path": "/machine/unattached/device[0]",
+#             "qom-path": "/machine/cpu[0]",
 #             "type": "qemu64-x86_64-cpu", "vcpus-count": 1,
 #             "props": {"core-id": 0, "socket-id": 0, "thread-id": 0}
 #          }
@@ -1062,7 +1062,7 @@
 #             "props": { "core-id": 1 }
 #          },
 #          {
-#             "qom-path": "/machine/unattached/device[0]",
+#             "qom-path": "/machine/cpu[0]",
 #             "type": "qemu-s390x-cpu", "vcpus-count": 1,
 #             "props": { "core-id": 0 }
 #          }
@@ -1617,7 +1617,7 @@
 #
 #     <- { "event": "MEMORY_DEVICE_SIZE_CHANGE",
 #          "data": { "id": "vm0", "size": 1073741824,
-#                    "qom-path": "/machine/unattached/device[2]" },
+#                    "qom-path": "/machine/peripheral/vm0" },
 #          "timestamp": { "seconds": 1588168529, "microseconds": 201316 } }
 ##
 { 'event': 'MEMORY_DEVICE_SIZE_CHANGE',
diff --git a/qapi/qom.json b/qapi/qom.json
index d96cc5aa21..62f9fd5492 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -135,7 +135,7 @@
 #    :title: Use absolute path
 #
 #     -> { "execute": "qom-get",
-#          "arguments": { "path": "/machine/unattached/device[0]",
+#          "arguments": { "path": "/machine/cpu[0]",
 #                         "property": "hotplugged" } }
 #     <- { "return": false }
 #
@@ -143,7 +143,7 @@
 #    :title: Use partial path
 #
 #     -> { "execute": "qom-get",
-#          "arguments": { "path": "unattached/sysbus",
+#          "arguments": { "path": "machine/sysbus",
 #                         "property": "type" } }
 #     <- { "return": "System" }
 ##
diff --git a/scripts/arm_processor_error.py b/scripts/arm_processor_error.py
index 73d069f070..2636837ce3 100644
--- a/scripts/arm_processor_error.py
+++ b/scripts/arm_processor_error.py
@@ -244,8 +244,7 @@ def send_cper(self, args):
         qmp_cmd.set_args(args)
 
         is_cpu_type = re.compile(r"^([\w+]+\-)?arm\-cpu$")
-        cpus = qmp_cmd.search_qom("/machine/unattached/device",
-                                  "type", is_cpu_type)
+        cpus = qmp_cmd.search_qom("/machine/cpu", "type", is_cpu_type)
 
         cper = {}
         pei = {}
diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index 521612fb94..b7e9ad86b9 100755
--- a/scripts/qmp_helper.py
+++ b/scripts/qmp_helper.py
@@ -601,7 +601,7 @@ def search_qom(self, path, prop, regex):
         """
         Return a list of devices that match path array like:
 
-            /machine/unattached/device
+            /machine/cpu
             /machine/peripheral-anon/device
             ...
         """
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index a023cd407d..b2adec97c8 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -63,12 +63,12 @@ Testing: -fda TEST_DIR/t.qcow2
                 stats-intervals = <null>
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -115,16 +115,16 @@ Testing: -fdb TEST_DIR/t.qcow2
                 stats-intervals = <null>
                 drive-type = "288"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 
 floppy0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -171,17 +171,17 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
                 stats-intervals = <null>
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -258,12 +258,12 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2
                 stats-intervals = <null>
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -310,16 +310,16 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
                 stats-intervals = <null>
                 drive-type = "288"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 
 floppy0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -366,17 +366,17 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
                 stats-intervals = <null>
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -416,7 +416,7 @@ none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -453,7 +453,7 @@ none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -510,7 +510,7 @@ none1 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -566,7 +566,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 stats-intervals = <null>
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
@@ -576,7 +576,7 @@ none0 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -623,7 +623,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 stats-intervals = <null>
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
@@ -633,7 +633,7 @@ none0 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -680,7 +680,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 stats-intervals = <null>
                 drive-type = "144"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
@@ -690,7 +690,7 @@ none0 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -737,7 +737,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 stats-intervals = <null>
                 drive-type = "144"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
@@ -747,7 +747,7 @@ none0 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -803,7 +803,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 stats-intervals = <null>
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
@@ -813,7 +813,7 @@ none0 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -860,7 +860,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 stats-intervals = <null>
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 
@@ -870,7 +870,7 @@ none0 (NODE_NAME): TEST_DIR/t.qcow2.2 (qcow2)
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -913,7 +913,7 @@ none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -1091,7 +1091,7 @@ none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -1128,7 +1128,7 @@ none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -1168,7 +1168,7 @@ none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -1205,7 +1205,7 @@ none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Cache mode:       writeback
 
 ide1-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
diff --git a/tests/qemu-iotests/186.out b/tests/qemu-iotests/186.out
index 01530040e5..a2fdb0a915 100644
--- a/tests/qemu-iotests/186.out
+++ b/tests/qemu-iotests/186.out
@@ -404,7 +404,7 @@ Testing: -drive if=floppy
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 floppy0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -412,7 +412,7 @@ Testing: -drive if=floppy,driver=null-co,read-zeroes=on
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 floppy0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
@@ -421,7 +421,7 @@ Testing: -drive if=ide,driver=null-co,read-zeroes=on
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 ide0-hd0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co)
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Cache mode:       writeback
 (qemu) quit
 
@@ -429,7 +429,7 @@ Testing: -drive if=ide,media=cdrom
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 ide0-cd0: [not inserted]
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
 (qemu) quit
 
@@ -437,7 +437,7 @@ Testing: -drive if=ide,driver=null-co,read-zeroes=on,media=cdrom
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) info block
 ide0-cd0 (NODE_NAME): json:{"read-zeroes": "on", "driver": "null-co"} (null-co, read-only)
-    Attached to:      /machine/unattached/device[N]
+    Attached to:      PATH
     Removable device: not locked, tray closed
     Cache mode:       writeback
 (qemu) quit
diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index ce4213cb97..9a5994a3a5 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -37,7 +37,7 @@ _filter_generated_node_ids()
 
 _filter_qom_path()
 {
-    gsed -e '/Attached to:/s/\device[[0-9]\+\]/device[N]/g'
+    gsed -e '/Attached to:/s#/machine/.*#PATH#'
 }
 
 # replace occurrences of the actual TEST_DIR value with TEST_DIR
-- 
2.47.1


