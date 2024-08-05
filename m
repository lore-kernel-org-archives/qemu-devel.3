Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F67C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 08:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sasd1-0000FD-Cq; Mon, 05 Aug 2024 03:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sasd0-0000E6-4Z
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 03:59:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sascx-0005P4-Gn
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 03:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722844773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HSpIet5B0ReF8Cn59W+S8kCRPEbJtdYOgQKiYtmPygE=;
 b=AvRXNwEIIooWLOZGmSeN96WpLVfN0yb4kiIBd6Fm3TLtNdyH5dMTirI7/19j4jjK/bIemb
 4ulQQyphgVWP9XwNbqln07FW2RcSAEMgtYXMjSpd12cFgGPuDoqIrNy3gt6fbN6iQLs+5C
 TOn9mmTWj6n3ZTC9DnMPvgiFwJ1d8R0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-sJHOfHv_PFW9IX85WOaLxw-1; Mon,
 05 Aug 2024 03:59:29 -0400
X-MC-Unique: sJHOfHv_PFW9IX85WOaLxw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48C7B1955D47; Mon,  5 Aug 2024 07:59:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2C611955D44; Mon,  5 Aug 2024 07:59:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AC88021F4B8C; Mon,  5 Aug 2024 09:59:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Josh Junon <junon@oro.sh>
Subject: [PULL 2/2] qmp: Fix higher half vaddrs for [p]memsave
Date: Mon,  5 Aug 2024 09:59:25 +0200
Message-ID: <20240805075925.2062973-3-armbru@redhat.com>
In-Reply-To: <20240805075925.2062973-1-armbru@redhat.com>
References: <20240805075925.2062973-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Josh Junon <junon@oro.sh>

Fixes higher-half address parsing for QMP commands
`[p]memsave`.

Signed-off-by: Josh Junon <junon@oro.sh>
Message-ID: <20240802140704.13591-1-junon@oro.sh>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Subject tweaked, and one PRId64 updated to PRIu64]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine.json | 11 +++++++++--
 system/cpus.c     | 12 ++++++------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 4582e58f7d..d4317435e7 100644
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
index 5e3a988a0a..1c818ff682 100644
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
-    uint32_t l;
+    uint64_t l;
     CPUState *cpu;
     uint8_t buf[1024];
-    int64_t orig_addr = addr, orig_size = size;
+    uint64_t orig_addr = addr, orig_size = size;
 
     if (!has_cpu) {
         cpu_index = 0;
@@ -823,7 +823,7 @@ void qmp_memsave(int64_t addr, int64_t size, const char *filename,
         if (l > size)
             l = size;
         if (cpu_memory_rw_debug(cpu, addr, buf, l, 0) != 0) {
-            error_setg(errp, "Invalid addr 0x%016" PRIx64 "/size %" PRId64
+            error_setg(errp, "Invalid addr 0x%016" PRIx64 "/size %" PRIu64
                              " specified", orig_addr, orig_size);
             goto exit;
         }
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
2.45.0


