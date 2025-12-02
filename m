Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E508BD12687
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 23:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQZT5-0005RV-S8; Tue, 02 Dec 2025 18:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1vQZSy-0005Q8-Iu
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 18:07:30 -0500
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1vQZSw-0005aE-Ac
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 18:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QmTQx7yfPGhmuO07X/peGrpsG1Xz1dTipb7VhMHYbcw=; b=o+3JbMXj56FvJ84n72VDRgldH4
 k89NFG8ZfPN1qDzy42nHnP+bidZd6GBgnuavq4xCFz9bsQ2D/YronBCQpCmqvsHvSVZDcQb+ue2x1
 zCeHV5OdUI4gZdSAn9U1VARu6mHmwEekPQAjVzHdHU1QNnnY8Q6caMcCykxRbRMkwNSN8jmi0PBdr
 SF2xwtawayDnNggAtkV4bcb4RdfIqbzAg/FYB/0HoF4MSLhiMZL8PMgcoR6hfsYmpA1POHBQkvMqb
 +T28envGnJJQvf3HEvPKpOKmW0w7/IXQF5KUKCEFlg2CvnKEda9Z6bU1CDOSPYTqKYrw1THzABI9I
 voSCo5yg==;
Received: from 82-69-92-151.dsl.in-addr.zen.co.uk ([82.69.92.151]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vQZSt-0082ga-KD; Wed, 03 Dec 2025 00:07:23 +0100
From: Alex Bradbury <asb@igalia.com>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>, alex.bennee@linaro.org, erdnaxe@crans.org,
 ma.mandourr@gmail.com, pierrick.bouvier@linaro.org
Subject: [PATCH v2 5/5] contrib/plugins/hotblocks: Allow limit to be set as a
 command line argument
Date: Tue,  2 Dec 2025 23:05:58 +0000
Message-ID: <bf04947f9a694a4d3adf5f0775dbb8d5013fd8c9.1764716538.git.asb@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764716538.git.asb@igalia.com>
References: <cover.1764716538.git.asb@igalia.com>
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index 543efc4d7d..e8793b0f9c 100644
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
2.52.0


