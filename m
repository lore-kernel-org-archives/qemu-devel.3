Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AF5D12689
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 23:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQZSu-0005P5-OH; Tue, 02 Dec 2025 18:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1vQZSs-0005Og-V5
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 18:07:22 -0500
Received: from fanzine2.igalia.com ([213.97.179.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asb@igalia.com>) id 1vQZSq-0005Za-Bx
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 18:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CN+1UZVLa45qQRicW1aM6nWsTAgOWP7zCStmqGa6D9Q=; b=hv4qrqWmSWtlXmKLYS0JfS2YMz
 tHuScacbRIOVNrepM1wVOPCUoLoe2ML+t0iluqz+gGpxfoc/efQlE1PeraP/kTzvYBaouFO9kcKlE
 WF67W0cLiU60J/TqRcKfAzJCiAGCEJ3OPI8hKPLQw15/l3aHiXY4pFLm+9GlLNjVKv7S7cYCIGSbv
 5Tsup9L7D/MDinC8QZGWe8pV/+7SQAHXPSKi6Vu0StfG+4ISUWi1PafLpivMytThSCAogrcIDvEzi
 Oc7Lbd1okdOAev+slnktnw5K8zzovX5/T7ErIWh8YAFgzUyYx2lfTLQdeRRazEMu7KWLLVHCktK2n
 I4L4EKIg==;
Received: from 82-69-92-151.dsl.in-addr.zen.co.uk ([82.69.92.151]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vQZSo-0082ga-OY; Wed, 03 Dec 2025 00:07:18 +0100
From: Alex Bradbury <asb@igalia.com>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>, alex.bennee@linaro.org, erdnaxe@crans.org,
 ma.mandourr@gmail.com, pierrick.bouvier@linaro.org
Subject: [PATCH v2 2/5] contrib/plugins/hotblocks: Fix off by one error in
 iteration of sorted blocks
Date: Tue,  2 Dec 2025 23:05:55 +0000
Message-ID: <2e1c404fd21d064610391ebb2ffe24d0c536f8dd.1764716538.git.asb@igalia.com>
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

The logic to iterate over the hottest blocks will never reach the last
item in the list, as it checks `it->next != NULL` before entering the
loop. It's hard to trigger this off-by-one error with the default
limit=20, but it is a bug and is problematic if that default is changed
to something larger.

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/hotblocks.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index d3dd23ed9f..cf4d6b8c36 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -82,10 +82,9 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     sorted_counts = g_list_sort_with_data(counts, cmp_exec_count, NULL);
 
     if (sorted_counts) {
-        it = sorted_counts;
         g_string_append_printf(report, "pc, tcount, icount, ecount\n");
 
-        for (i = 0; i < limit && it->next; i++, it = it->next) {
+        for (i = 0, it = sorted_counts; i < limit && it; i++, it = it->next) {
             ExecCount *rec = (ExecCount *) it->data;
             g_string_append_printf(
                 report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
-- 
2.52.0


