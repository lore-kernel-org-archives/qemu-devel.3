Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB4BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 12:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZrlT-00084X-5U; Fri, 02 Aug 2024 08:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junon@oro.sh>) id 1sZrlR-00083q-Me
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 08:52:09 -0400
Received: from out-177.mta1.migadu.com ([2001:41d0:203:375::b1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <junon@oro.sh>) id 1sZrlN-0002fJ-N7
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 08:52:09 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oro.sh; s=key1;
 t=1722603122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yFCW6+JCo6EKvl12jXJZXQ1CcdpBm41NoW/x9AFHQQE=;
 b=OMGama4KNaHFqfMysNkvgiz53ckhqDJTcsqvS2tgVvleJPcp8XHxYCa/0rrjYvZebQzwlB
 CJhrG1XvhY+lHyWIEanPlvCj7dz267Z2LTXT+tdGH3vEoqNggK0kYZsc+yPUQJHcn1YimT
 /w6Oe3G1HBvJkAatNWwtKVqF1fI9dog=
From: Josh Junon <junon@oro.sh>
To: qemu-devel@nongnu.org
Cc: Josh Junon <junon@oro.sh>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2] qmp: Use unsigned integers for address parameters
Date: Fri,  2 Aug 2024 14:51:32 +0200
Message-Id: <20240802125132.19860-1-junon@oro.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:203:375::b1; envelope-from=junon@oro.sh;
 helo=out-177.mta1.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Fixes higher-half address parsing for QMP commands
`[p]memsave` and `dump-guest-memory`.

Signed-off-by: Josh Junon <junon@oro.sh>
---
 dump/dump.c       |  4 ++--
 qapi/dump.json    |  2 +-
 qapi/machine.json | 11 +++++++++--
 system/cpus.c     |  8 ++++----
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 45e84428ae..00a1323735 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -2063,8 +2063,8 @@ DumpQueryResult *qmp_query_dump(Error **errp)
 
 void qmp_dump_guest_memory(bool paging, const char *protocol,
                            bool has_detach, bool detach,
-                           bool has_begin, int64_t begin,
-                           bool has_length, int64_t length,
+                           bool has_begin, uint64_t begin,
+                           bool has_length, uint64_t length,
                            bool has_format, DumpGuestMemoryFormat format,
                            Error **errp)
 {
diff --git a/qapi/dump.json b/qapi/dump.json
index d8145dad97..3b751c0356 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -102,7 +102,7 @@
 ##
 { 'command': 'dump-guest-memory',
   'data': { 'paging': 'bool', 'protocol': 'str', '*detach': 'bool',
-            '*begin': 'int', '*length': 'int',
+            '*begin': 'uint64', '*length': 'size',
             '*format': 'DumpGuestMemoryFormat'} }
 
 ##
diff --git a/qapi/machine.json b/qapi/machine.json
index fcfd249e2d..fb618dc99f 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -852,7 +852,11 @@
 #     <- { "return": {} }
 ##
 { 'command': 'memsave',
-  'data': {'val': 'int', 'size': 'int', 'filename': 'str', '*cpu-index': 'int'} }
+  'data': {
+     'val': 'uint64',
+     'size': 'size',
+     'filename': 'str',
+     '*cpu-index': 'int' } }
 
 ##
 # @pmemsave:
@@ -878,7 +882,10 @@
 #     <- { "return": {} }
 ##
 { 'command': 'pmemsave',
-  'data': {'val': 'int', 'size': 'int', 'filename': 'str'} }
+  'data': {
+    'val': 'uint64',
+    'size': 'size',
+    'filename': 'str' } }
 
 ##
 # @Memdev:
diff --git a/system/cpus.c b/system/cpus.c
index 5e3a988a0a..128face42b 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -792,14 +792,14 @@ int vm_stop_force_state(RunState state)
     }
 }
 
-void qmp_memsave(int64_t addr, int64_t size, const char *filename,
+void qmp_memsave(uint64_t addr, uint64_t size, const char *filename,
                  bool has_cpu, int64_t cpu_index, Error **errp)
 {
     FILE *f;
     uint32_t l;
     CPUState *cpu;
     uint8_t buf[1024];
-    int64_t orig_addr = addr, orig_size = size;
+    uint64_t orig_addr = addr, orig_size = size;
 
     if (!has_cpu) {
         cpu_index = 0;
@@ -840,11 +840,11 @@ exit:
     fclose(f);
 }
 
-void qmp_pmemsave(int64_t addr, int64_t size, const char *filename,
+void qmp_pmemsave(uint64_t addr, uint64_t size, const char *filename,
                   Error **errp)
 {
     FILE *f;
-    uint32_t l;
+    uint64_t l;
     uint8_t buf[1024];
 
     f = fopen(filename, "wb");
-- 
2.34.1


