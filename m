Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1ADC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 13:30:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh6sd-0007yK-V0; Wed, 30 Jul 2025 09:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1uh0We-0002ik-6U
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:42:56 -0400
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1uh0Wb-00043E-AP
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 02:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VBV50KAekGTBs5evzva+q0zkom0tIRNQMNKutedB2iI=; b=cCXUvimgrlXR97JBREe49148/d
 0XBVX0MQ1fpO7ILEHasMcyNWNAmUEhpj+FSEVAAFVRKWrv7ogOcmDSm+P3HRRmmhXCR+UNjcTT4KU
 UWlp6tQ96SnkANG5dI7ZF8PnNk5k3I3N2PGcNJMd1e77E59FMcDD305WrXBI/9g30BPm3Ex4ob7Pw
 WI5IGALVQWia+GOsKZ4LZFemw/HU8XNHNaQ5bbzuw3EyCT7Z8xx3K7AGx9LwcDpmF2/SXkyrddvCZ
 jz0+dYTqvsCi4NmP55syqquc5rbLPWEV8NTeqYfmHW/p6fMcOWWsK/MmR5TV/ykRJrM0ltPO/kHSM
 myGAGU3Q==;
Received: from 82-69-92-151.dsl.in-addr.zen.co.uk ([82.69.92.151]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uh0WQ-005nOk-HS; Wed, 30 Jul 2025 08:42:42 +0200
From: Alex Bradbury <asb@igalia.com>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>, alex.bennee@linaro.org, erdnaxe@crans.org,
 ma.mandourr@gmail.com, pierrick.bouvier@linaro.org
Subject: [PATCH 5/5] contrib/plugins/hotblocks: Allow limit to be set as a
 command line argument
Date: Wed, 30 Jul 2025 07:41:43 +0100
Message-ID: <58281d6e54bcad1802e8d3dc8d8501d54c2a971e.1753857212.git.asb@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753857212.git.asb@igalia.com>
References: <cover.1753857212.git.asb@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.97.179.56; envelope-from=asb@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 30 Jul 2025 09:05:40 -0400
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

Also add documentation for this argument. This allows the default of 20
to be overridden, and is helpful for using the hotblocks plugin for
analysis scripts that require collecting data on a larger number of
blocks (e.g. setting limit=0 to dump information on all blocks).

Signed-off-by: Alex Bradbury <asb@igalia.com>
---
 contrib/plugins/hotblocks.c | 10 +++++++++-
 docs/about/emulation.rst    |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 40d8dae1cd..8ecf033997 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -84,7 +84,8 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     if (sorted_counts) {
         g_string_append_printf(report, "pc, tcount, icount, ecount\n");
 
-        for (i = 0, it = sorted_counts; i < limit && it; i++, it = it->next) {
+        for (i = 0, it = sorted_counts; (limit == 0 || i < limit) && it;
+             i++, it = it->next) {
             ExecCount *rec = (ExecCount *) it->data;
             g_string_append_printf(
                 report, "0x%016"PRIx64", %d, %ld, %"PRIu64"\n",
@@ -170,6 +171,13 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
+        } else if (g_strcmp0(tokens[0], "limit") == 0) {
+            char *endptr = NULL;
+            limit = g_ascii_strtoull(tokens[1], &endptr, 10);
+            if (endptr == tokens[1] || *endptr != '\0') {
+                fprintf(stderr, "unsigned integer parsing failed: %s\n", opt);
+                return -1;
+            }
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 9c963f4705..185edb8ad7 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -473,6 +473,8 @@ Behaviour can be tweaked with the following arguments:
     - Description
   * - inline=true|false
     - Use faster inline addition of a single counter.
+  * - limit=N
+    - The number of blocks to be printed. (Default: N = 20, use 0 for no limit).
 
 Hot Pages
 .........
-- 
2.50.1


