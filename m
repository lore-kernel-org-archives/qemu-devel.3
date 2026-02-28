Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18FFFEE4C9
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 13:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwKpo-0003AJ-3E; Sat, 28 Feb 2026 08:58:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c96f6d2398a9dc068fa82088ea43020a52e2b26d@kylie.crudebyte.com>)
 id 1vwKpm-00039m-2X
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 08:58:18 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c96f6d2398a9dc068fa82088ea43020a52e2b26d@kylie.crudebyte.com>)
 id 1vwKpk-0003Mu-I3
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 08:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=i/Jg908mrivzRqiEPGYRuTaV6Lws96n4J+9fVnVFW2A=; b=pqUiy
 Jk2lPcOFUx7FYEmhajnz37zqBZs6ic5GLvrTGWGHuuOfz9FKmr/Mn0SfeUCsJzCs3v12pIl3NJ0Pr
 4YSNRPALCtBWvImCHQpLklahFTnU/gIP2K7fWn9CsPcaFg6S+hPUAN1WdifznBZBBVTFXAMOl3kBc
 uX8g3gbTlcylg0JF+oDJsl81NbqLIKDL580JoGHPovfAV1S+XvLAmFXQDoAyVEopOVZhRcuXtuDuL
 E5aRfxW6i+L/R87g/elANa7aU/IrVMqZIVKNT3fQrIHVxpkkr50cMCl8GG8XncNfbYGT+57QuBUj9
 BMxErBBKHS7FWM6VFC7S/W9EqBMc2nxt0u0b04DkpcCB7wbAotaIniHTX0fBcjTOpcrGI5Db/b0h3
 ggqt03I6j3tctI/HUr54sXX/3v9iZqfdGR2g544Cjv7Z+7clOmsaXbWPyA561wfSOnVb1eoJN5x0f
 XKp8noS7Gl4VLlteC4NF52Lv3HxXgyCTXRTdMtARa6jqrN/vfwBCbwoHoc2Rttrzg7otULWehcCtA
 JyiXUm8KKpHSyF+Ean8gDF3/i0Dp6ZYjJLQbXvq9J0us8SF549Ax63mwrp4349+wH2fqIBl+JvvvE
 v5GgUwi/heS2J/RfDY8/WfJbohGDZRfaUEaWSTwagmr6LlivV7xbuJrnJHwTuQ=;
Message-ID: <c96f6d2398a9dc068fa82088ea43020a52e2b26d.1772285406.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1772285406.git.qemu_oss@crudebyte.com>
References: <cover.1772285406.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 28 Feb 2026 14:30:06 +0100
Subject: [PULL 1/2] hw/9pfs: fix data race in v9fs_mark_fids_unreclaim()
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
    Richie Buturla <richie@linux.ibm.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=c96f6d2398a9dc068fa82088ea43020a52e2b26d@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.966, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.722,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Richie Buturla <richie@linux.ibm.com>

A data race between v9fs_mark_fids_unreclaim() and v9fs_path_copy()
causes an inconsistent read of fidp->path. In v9fs_path_copy(), the
path size is set before the data pointer is allocated, creating a
window where size is non-zero but data is NULL.

v9fs_co_open2() holds a write lock during path modifications,
but v9fs_mark_fids_unreclaim() was not acquiring a read
lock, allowing it to race.

Fix by holding the path read lock during FID table iteration.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3300
Signed-off-by: Richie Buturla <richie@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260211154450.254338-1-richie@linux.ibm.com/
Fixes: 7a46274529 ("hw/9pfs: Add file descriptor reclaim support")
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 6fbe604ce8..02366f43a8 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -560,6 +560,7 @@ static int coroutine_fn v9fs_mark_fids_unreclaim(V9fsPDU *pdu, V9fsPath *path)
             sizeof(V9fsFidState *), 1);
     gint i;
 
+    v9fs_path_read_lock(s);
     g_hash_table_iter_init(&iter, s->fids);
 
     /*
@@ -580,6 +581,7 @@ static int coroutine_fn v9fs_mark_fids_unreclaim(V9fsPDU *pdu, V9fsPath *path)
             g_array_append_val(to_reopen, fidp);
         }
     }
+    v9fs_path_unlock(s);
 
     for (i = 0; i < to_reopen->len; i++) {
         fidp = g_array_index(to_reopen, V9fsFidState*, i);
-- 
2.47.3


