Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776B1CD4F50
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 18:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP2l3-0006G5-Uq; Mon, 18 May 2026 14:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <2d2348d94ff43fbe4cc0aea24fb312c5c15ee809@kylie.crudebyte.com>)
 id 1wP2l2-0006FE-1T; Mon, 18 May 2026 14:32:04 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <2d2348d94ff43fbe4cc0aea24fb312c5c15ee809@kylie.crudebyte.com>)
 id 1wP2l0-0002NZ-HK; Mon, 18 May 2026 14:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=MfSrrNMocb/kKkoLsE778NJNnbAO0o0xLQ5wR9ZrXCw=; b=a29Kf
 LFtwF6sp7iPxpsuhECehrQtOjz+eIUZ3O1LgNLO2Bn3gGyyhW93froS3A+1DwobZbXThQ1atPBBpl
 xtx7DWP83i+4XyZRqaPOSIyMUnB8kRhn05PLjqmvPEUOBdQ/uUJ3Lwgj14QXRS6Ua+Fc7ESN5R48N
 uJglJMhWI+Kp9WvY8S1BPWAfsIq74Aak3EqZYKNGz6a5HgccbY4iDfW4GZB82cky9xUu+ZNan/QSH
 RKfHX+fdBhckgq02XGWsLMXIIn2BB72eIJZ1DbzbAp463Unk123j6KTFDFWvsYsSN67f1507pwPtl
 PGu5SgGyeulKqsi0lCtvrVy79GIYnQKZBBifzV8CzguS9KLkY5f7jUcWj8hpoGxxrnSR7wSR5yEEV
 wuMImoh54Ivs0GD1Dlco27TZJhsznffVaFzODs25MjEiw5ni01t7oaUMs0KdnzNXevrRjb3ijQ4Ah
 U9dIZ2eRhEtH/QghRAfwbRCQlu9A0z0Ncy45429KAdb8+vPo1NiabsCJ8Fwu1Dqwy1KfjgmhJ8nsr
 63hKvDxzb5rE9GHWpHg8PktVCiFeifQGbXposeRG5nvIwBWfcMvUkcHPLiXdz8YpnYp3vDN3Zz/Fs
 N6OTePMKChicg5ruR4PeDHakn1EFxZruIwJ4bFFQrEtZvqsYAMm2D5RXwAMd/A=;
Message-ID: <2d2348d94ff43fbe4cc0aea24fb312c5c15ee809.1779126034.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1779126034.git.qemu_oss@crudebyte.com>
References: <cover.1779126034.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 18 May 2026 19:35:53 +0200
Subject: [PATCH 2/6] hw/9pfs: change V9fsPath.size to size_t and
 v9fs_path_sprintf() return type
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Jia Jia <physicalmtea@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=2d2348d94ff43fbe4cc0aea24fb312c5c15ee809@kylie.crudebyte.com;
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

- Change V9fsPath.size from uint16_t to size_t to support paths larger
  than 65536 bytes.

- Change v9fs_path_sprintf() return type from void to int to allow error
  reporting.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 fsdev/file-op-9p.h |  2 +-
 hw/9pfs/9p.c       | 14 +++++++++++---
 hw/9pfs/9p.h       |  4 ++--
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index b85c9934de..e8d0661c4b 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -112,7 +112,7 @@ struct FsContext {
 };
 
 struct V9fsPath {
-    uint16_t size;
+    size_t size;
     char *data;
 };
 P9ARRAY_DECLARE_TYPE(V9fsPath);
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index e590c414ab..88894ec9d2 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -203,16 +203,24 @@ void v9fs_path_free(V9fsPath *path)
 }
 
 
-void v9fs_path_sprintf(V9fsPath *path, const char *fmt, ...)
+int v9fs_path_sprintf(V9fsPath *path, const char *fmt, ...)
 {
     va_list ap;
+    int ret;
 
     v9fs_path_free(path);
 
     va_start(ap, fmt);
-    /* Bump the size for including terminating NULL */
-    path->size = g_vasprintf(&path->data, fmt, ap) + 1;
+    ret = g_vasprintf(&path->data, fmt, ap);
     va_end(ap);
+    if (ret < 0) {
+        error_report_once("9pfs: unusual path formatting failure; "
+                         "invalidating associated FID");
+        return -1;
+    }
+    /* Bump the size for including terminating NULL */
+    path->size = ret + 1;
+    return 0;
 }
 
 void v9fs_path_copy(V9fsPath *dst, const V9fsPath *src)
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 65cc45e344..b2df659b0e 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -456,8 +456,8 @@ static inline uint8_t v9fs_request_cancelled(V9fsPDU *pdu)
 void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu);
 void v9fs_path_init(V9fsPath *path);
 void v9fs_path_free(V9fsPath *path);
-void G_GNUC_PRINTF(2, 3) v9fs_path_sprintf(V9fsPath *path, const char *fmt,
-                                           ...);
+int G_GNUC_PRINTF(2, 3) v9fs_path_sprintf(V9fsPath *path, const char *fmt,
+                                          ...);
 void v9fs_path_copy(V9fsPath *dst, const V9fsPath *src);
 size_t v9fs_readdir_response_size(V9fsString *name);
 int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
-- 
2.47.3


