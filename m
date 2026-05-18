Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50711CD4F50
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 18:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP2mM-0006t0-D0; Mon, 18 May 2026 14:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3348c4d683f061c23083bd45994d527be4fb7cbc@kylie.crudebyte.com>)
 id 1wP2ld-0006P2-67; Mon, 18 May 2026 14:32:56 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <3348c4d683f061c23083bd45994d527be4fb7cbc@kylie.crudebyte.com>)
 id 1wP2lb-0002cf-Po; Mon, 18 May 2026 14:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=7y4nYDRtPEbRAEWf7KeUH8jL/lEt8hJcinQokaixdsE=; b=K+vxQ
 TVeJl/jCSgJBEf+7ApRvpcdehuot9cE1686gpL3acNetJyMUu00l0/BjGxLq9RY7nsDxXdADGy/PQ
 lfVEwIkbYqtv4JT9YgvvLoUAJmXg+n/W+Wgtq1sLDvgodJHx3eeNLIn73TOQlT8d81NGJvQwRjkuV
 M5SW/q1bIcEIJ3k5pme9HAajg8kxSUquk27EPHKd2NkUB4Tq8ItfDhig+1PQe6Sbwxfg+FnWQRlYJ
 mdcZ1Q+B9sxWdprzKcMz3Axkz/RreL8AgOlUXOSpg6/OqGiKmJ5PTLQNTIHMtFMf6EEBEqmYnuXhd
 XWG3ZeVDrCwjzskfWP4/EJEj45qdWLSSkq9cIsYaAKw2VeU7M/XJ+7UB9kgGbY3c8mRKEhO4rPlm+
 rCZgn355neVwsA9swLkILyrymUzHoc0UsKiVnrdjHb/Ots+NbbYs8kjgnj5W/eIREPvTe3CodBsWZ
 3T7pasHDraalK0xAV2t8i/jWYyy0bXk+Qzgw7/iNnhZOjAgBnMeqKMCjGy7XHSww0R0l9xQu9VOK1
 ACarbm/1cmSP/FwvMrUh/bqGtxPWOnjWF8mIuz2kek9xQxj7iftNP+Ldb53Wrw/UHe86gW4Pzi67q
 rFN4R8ihWACryCeDzzBshFqaKRlnsaJy2N/olzLwnsMMlRm4fVWjBsdQ0RF4BM=;
Message-ID: <3348c4d683f061c23083bd45994d527be4fb7cbc.1779126034.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1779126034.git.qemu_oss@crudebyte.com>
References: <cover.1779126034.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 18 May 2026 19:35:36 +0200
Subject: [PATCH 1/6] hw/9pfs: add NULL check in v9fs_path_is_ancestor()
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Jia Jia <physicalmtea@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=3348c4d683f061c23083bd45994d527be4fb7cbc@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
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

Add NULL check for s1->data and s2->data before using them in
string operations. This prevents potential crashes when dealing
with uninitialized paths.

This is just a defensive measure. We are currently never passing
NULL to this function.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index e2713b9eee..e590c414ab 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -241,6 +241,9 @@ int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
  */
 static int v9fs_path_is_ancestor(V9fsPath *s1, V9fsPath *s2)
 {
+    if (!s1->data || !s2->data) {
+        return 0;
+    }
     if (!strncmp(s1->data, s2->data, s1->size - 1)) {
         if (s2->data[s1->size - 1] == '\0' || s2->data[s1->size - 1] == '/') {
             return 1;
-- 
2.47.3


