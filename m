Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D455CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 07:40:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1serXA-000720-Pb; Fri, 16 Aug 2024 03:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1serX9-0006vv-Ny
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:38:03 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1serX7-0005w2-Hp
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 03:38:03 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 2F31BCE1EFE;
 Fri, 16 Aug 2024 07:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A306C4AF11;
 Fri, 16 Aug 2024 07:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1723793873;
 bh=1dC6qge5j6u0iMd7Y9iF2l9tSLTNhq/Z8HDaN5NFEKg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DXF2kbFOu/d0z+t1Ms+g5NWG//Ep0IG5elrFrqpzaQwKmFjK24inwdZMTckRHm7Dz
 ZR3SyNvp0Sl+GxTr4rmgvWYkdMVdoelD4KYiKyi+DkKmWOexSe6tz4HzaN4tYzUlN7
 Blbt8I3FgFnoUdTpooR3xBIiZ+6n8RqECQarWWVpkDzPwcbHMVead9+KQZKC5Zx640
 hmlPQAdkwwmI4j+doVKPmRLBxrU1mO31F4cz1MqHnOkKocome/JoIteJx/DkWGjz3G
 16PMdVYWFgiOtSRkUZACyWV8aRlE9rNVLnbR8lLHljvqq89UVyHNxyrf/fitwTVBiH
 ZsNHrSBB1BXUg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1serWx-000000055ez-2v1X; Fri, 16 Aug 2024 09:37:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org
Subject: [PATCH v8 11/13] scripts/arm_processor_error.py: retrieve mpidr if
 not filled
Date: Fri, 16 Aug 2024 09:37:43 +0200
Message-ID: <9fab07e7af3efaae9546ab2c7b12b2482ba02da5.1723793768.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1723793768.git.mchehab+huawei@kernel.org>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add support to retrieve mpidr value via qom-get.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/arm_processor_error.py | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/scripts/arm_processor_error.py b/scripts/arm_processor_error.py
index 62e0c5662232..0a16d4f0d8b1 100644
--- a/scripts/arm_processor_error.py
+++ b/scripts/arm_processor_error.py
@@ -5,12 +5,10 @@
 #
 # Copyright (C) 2024 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 
-# TODO: current implementation has dummy defaults.
-#
-# For a better implementation, a QMP addition/call is needed to
-# retrieve some data for ARM Processor Error injection:
-#
-#   - ARM registers: power_state, mpidr.
+# Note: currently it lacks a method to fill the ARM Processor Error CPER
+# psci field from emulation. On a real hardware, this is filled only
+# when a CPU is not running. Implementing support for it to simulate a
+# real hardware is not trivial.
 
 import argparse
 import re
@@ -174,11 +172,24 @@ def send_cper(self, args):
         else:
             cper["running-state"] = 0
 
+        if args.mpidr:
+            cper["mpidr-el1"] = arg["mpidr"]
+        elif cpus:
+            cmd_arg = {
+                'path': cpus[0],
+                'property': "x-mpidr"
+            }
+            ret = qmp_cmd.send_cmd("qom-get", cmd_arg, may_open=True)
+            if isinstance(ret, int):
+                cper["mpidr-el1"] = ret
+            else:
+                cper["mpidr-el1"] = 0
+
         if arm_valid_init:
             if args.affinity:
                 cper["valid"] |= self.arm_valid_bits["affinity"]
 
-            if args.mpidr:
+            if "mpidr-el1" in cper:
                 cper["valid"] |= self.arm_valid_bits["mpidr"]
 
             if "running-state" in cper:
@@ -362,7 +373,7 @@ def send_cper(self, args):
                 if isinstance(ret, int):
                     arg["midr-el1"] = ret
 
-        util.data_add(data, arg.get("mpidr-el1", 0), 8)
+        util.data_add(data, cper["mpidr-el1"], 8)
         util.data_add(data, arg.get("midr-el1", 0), 8)
         util.data_add(data, cper["running-state"], 4)
         util.data_add(data, arg.get("psci-state", 0), 4)
-- 
2.46.0


