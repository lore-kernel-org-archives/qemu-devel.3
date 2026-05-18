Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1276CD4F50
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 18:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP2m6-0006be-5b; Mon, 18 May 2026 14:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a0592741a918b7cbe751980ec7ec0c03f505924c@kylie.crudebyte.com>)
 id 1wP2l8-0006Kx-R5; Mon, 18 May 2026 14:32:21 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a0592741a918b7cbe751980ec7ec0c03f505924c@kylie.crudebyte.com>)
 id 1wP2l7-0002Oe-Gi; Mon, 18 May 2026 14:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=XKiX0XyHKyBgRAeITQtv9rXyqRpwst1PipAJNZmp62E=; b=FONjU
 UC6hFyoN+i8wR5v9ZRHYL4xuK0Agp9S/0vZ1S+GXEF++3p3FtM442pGuwHxRFIQTv8wGUeS5AL2qK
 YP8lTpgNj8cPs83fjH2UY9/TGZ3m9+HP6FzNbuIE2aDQx/876VERnD8l/Je0hAV9npgEp2Tv61dEF
 DFEqaypU8k/32FYLxihHvKfLuHr12+tlPZVZf+VLcnT3aZ4JUQy52Jfgg4qybPzZbT4K1fY/osqoA
 RakhbOrUW44hUj1n0vomWi532B+rd4Avw5PE6INXqhH/VjVpXNzLMHJ6jVdFZGJKzs9WvCOTyKRIl
 s2G66ORpIIHaP1T6eh9vlQ14W6m/lXtwThYLARsiZwQmhPQ7N+jQeZtnjMWpWVFr4PZO9Dzq1recw
 eAdDdi1c8H1868+ojTrn3YyAlUhCpyzVLih3yBWIScbWef6lQTgBQ42hATNR/cX8Ewt/xtxbKm2aI
 Sa6IhisSAkPoPqKcNLxGAszkLDl4TBKY4Kel5tlbqo44G0hfyAPUwb3nwlzkn4Zfq+D4ZOPNchOjK
 QMEhU0htKsQ7Fe9mVMtpabFLF9oqhlioaw/Nml287kd2WGyhjlhzlXzyDvVM1bDrpevrepatu8VGd
 b+8yf/wNnp9eet0oXWCrr58yHw4iCPVTAhnirNEEn9xqJndlMBlhiVZF5I5/xo=;
Message-ID: <a0592741a918b7cbe751980ec7ec0c03f505924c.1779126034.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1779126034.git.qemu_oss@crudebyte.com>
References: <cover.1779126034.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 18 May 2026 19:35:56 +0200
Subject: [PATCH 3/6] hw/9pfs: add error handling to v9fs_fix_path()
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Jia Jia <physicalmtea@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=a0592741a918b7cbe751980ec7ec0c03f505924c@kylie.crudebyte.com;
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

Update v9fs_fix_path() to return int and propagate errors from
v9fs_path_sprintf(). This allows callers to detect and handle
path formatting failures.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 88894ec9d2..d704de644f 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1417,13 +1417,15 @@ static void print_sg(struct iovec *sg, int cnt)
 }
 
 /* Will call this only for path name based fid */
-static void v9fs_fix_path(V9fsPath *dst, V9fsPath *src, int len)
+static int v9fs_fix_path(V9fsPath *dst, V9fsPath *src, int len)
 {
     V9fsPath str;
+    int ret;
     v9fs_path_init(&str);
     v9fs_path_copy(&str, dst);
-    v9fs_path_sprintf(dst, "%s%s", src->data, str.data + len);
+    ret = v9fs_path_sprintf(dst, "%s%s", src->data, str.data + len);
     v9fs_path_free(&str);
+    return ret;
 }
 
 static inline bool is_ro_export(FsContext *ctx)
-- 
2.47.3


