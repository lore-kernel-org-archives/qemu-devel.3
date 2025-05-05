Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80760C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsXI-0003Vc-FV; Mon, 05 May 2025 05:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <610dc187e52605c8ea8d14c5e7d8e7384f8af290@kylie.crudebyte.com>)
 id 1uBsXC-0003Js-O0
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:50 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <610dc187e52605c8ea8d14c5e7d8e7384f8af290@kylie.crudebyte.com>)
 id 1uBsXB-0005IQ-3d
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=6RQo1Es8KUgQYat0BV6Qy/GmI5Or+2nzwgmjZh5cLPk=; b=XvMlx
 qKtzW2nXOyfgZvzCd7PFnpspGcGwhiY9y2vdx3jL+cOUy2s9PC1veY7QjbzXtfWBzZfUPnZioOhmQ
 tOyjUqusz2gmLXFTjhUi33d/HVEndk4VwvUft9gC34VRdsgWy+KA51wvP3NBJA/VW3AvYzhY3S6rx
 u+DVZHytHuuafQyo2cMUUGBUMRCKvyLu5J7FICpm3PG4KALHHhJVLXXfR7jAjq2V874lDZtkR0aJk
 2e+EZuAaTw3js4k0NaNG9fln7PTVtqYHvUIprh8shcz2r6ekQpA9X6/qDrm/gb6BsHuUBPIFDPqBK
 P7rdJKi2BbTqpOlkBcE6mfJb2bfuAYIGydPxC36LYYWkb5S5sty5ml8v2aTN7+ZjITBYktClqs3Rb
 9xUrCQqw8Ac7NRr267KnAemvTgzFF+Hl4ir6ySvnhthZXZ6/suqoTeCfO0EirK0onDUN6kA5RK6qv
 J3SudaiBxSuC1gloJ+l4UVthJ4IM16iu1KKy4eNFwGGo+Fdniln8wnbBzxqXVv6G8+R6To1cyzrL1
 /+3Yk5EcCZ+BN5LVlaC/Z1K1bKw679/ATVffWgpB5S/rNf9XvDmXUxndZgFTGYOZx0HtNXcs90ckI
 zEs8Ufm0F/C4xmY8WJqBND9CLdIT9w9Jb7ChgiF59x/4DTW0Ak44nxwRaze3dw=;
Message-Id: <610dc187e52605c8ea8d14c5e7d8e7384f8af290.1746438650.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1746438650.git.qemu_oss@crudebyte.com>
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 05 May 2025 11:50:51 +0200
Subject: [PULL 8/9] tests/9p: Test `Tsetattr` can truncate unlinked file
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=610dc187e52605c8ea8d14c5e7d8e7384f8af290@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Greg Kurz <groug@kaod.org>

Enhance the `use-after-unlink` test with a new check for the
case where the client wants to alter the size of an unlinked
file for which it still has an active fid.

Suggested-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-Id: <20250312152933.383967-7-groug@kaod.org>
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/virtio-9p-test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index f515a9bb15..ac38ccf595 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -736,6 +736,20 @@ static void fs_use_after_unlink(void *obj, void *data,
         .data = buf
     }).count;
     g_assert_cmpint(count, ==, write_count);
+
+    /* truncate file to (arbitrarily chosen) size 2001 */
+    tsetattr({
+        .client = v9p, .fid = fid_file, .attr = (v9fs_attr) {
+            .valid = P9_SETATTR_SIZE,
+            .size = 2001
+        }
+     });
+    /* truncate apparently succeeded, let's double-check the size */
+    tgetattr({
+        .client = v9p, .fid = fid_file, .request_mask = P9_GETATTR_BASIC,
+        .rgetattr.attr = &attr
+    });
+    g_assert_cmpint(attr.size, ==, 2001);
 }
 
 static void cleanup_9p_local_driver(void *data)
-- 
2.30.2


