Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B29EF587B
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 13:34:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrcFh-00026B-Vh; Sun, 15 Feb 2026 08:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d12f2196c3f6514f9e8668e308f825fb2622f3a1@kylie.crudebyte.com>)
 id 1vrcFf-00025U-8J
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 08:33:31 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d12f2196c3f6514f9e8668e308f825fb2622f3a1@kylie.crudebyte.com>)
 id 1vrcFd-0007cP-LO
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 08:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=/Whm1FxQDP01jjk6aPn6HrqaQpnWhinhSdK4CgTnjzc=; b=CVX3C
 i+osYvd38w5/98TmHSobAfxKI5bBPsGY6PTY4MtsBreZchenLfDXfR8/CuvXJTY9VAhIgn4HP+XJs
 EVcjCUGVpsgIQaWkJEZDhOmachOeHhCjhC2Ss+4RmJ+nYKAOuYTFxZrp+K7XIGo58V8EUgP/nJPvJ
 KSyfZ5tnzDGhave8GVhqmjfwwtCC9Z39WNxKYViehUBajR6KrgNmzQKtTzUPvnOggmVvGxXDK7/rX
 XGf2P32l/LzdqyaDXDI+8YB3ihx3g7+4Czq7wJOMSlBtc19QvLGxrs6gwoo4cu/bb4/PA12C4Ctu8
 AMakTuX5JAzmDxNB7aT75eaakeHCs3XhwzT7z9jo8U9FG/WPExPeWV/SULCQo0q8yJYql1U55tGvH
 WE3Ue3yXJYqAlp2mR6lsLFofND35b2SNghwEsz75L0H0727IuUiMGChVkq5HPksMETdqbmCo8MqR9
 yBaCfEvDU8oydNsNZCMiM4oy5Mnfaz7CubAJ3ixxIpv4IpI6WHlA/5eO3tg3ARSSXmuGmIBRP5V2q
 df306iNoRfrwVC1lcRrXUzgJIBSDDTBggQ+3POS8rFsnZTJxzMpvmvfqQkDN8utiaFKKGTeJSQYqC
 AsMcuW/JuWMgq9BLRLmmFqxLle3qQAYSW4ZNYIWEKrELCpAyYFWrhW8+b3Tmic=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 15 Feb 2026 13:44:50 +0100
Subject: [PATCH] hw/9pfs: fix missing EOPNOTSUPP on Twstat and Trenameat for
 fs synth driver
To: qemu-devel@nongnu.org
Cc: Oliver Chang <ochang@google.com>, Alexander Bulekov <alxndr@bu.edu>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Greg Kurz <groug@kaod.org>
Message-Id: <E1vrbaP-000Gqb-B3@kylie.crudebyte.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=d12f2196c3f6514f9e8668e308f825fb2622f3a1@kylie.crudebyte.com;
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

Renaming files/dirs is only supported by path-based fs drivers. EOPNOTSUPP
should be returned on any renaming attempt for not path-based fs drivers.
This was already the case for 9p "Trename" request type. However for 9p
request types "Trenameat" and "Twstat" this was yet missing.

So fix this by checking in Twstat and Trenameat request handlers whether
the fs driver in use is really path based, if not return EOPNOTSUPP and
abort further handling of the request.

This fixes a crash with the 9p "synth" fs driver which is not path-based.

The crash happened because the synth driver stores and expects a raw
V9fsSynthNode pointer instead of a C-string on V9fsPath.data. So the
C-string delivered by 9p server to synth fs driver was incorrectly
casted to a V9fsSynthNode pointer, eventually causing a segfault.

Reported-by: Oliver Chang <ochang@google.com>
Fixes: https://issues.oss-fuzz.com/issues/477990727
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3298
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 02366f43a8..e2713b9eee 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3516,6 +3516,12 @@ static void coroutine_fn v9fs_renameat(void *opaque)
         goto out_err;
     }
 
+    /* if fs driver is not path based, return EOPNOTSUPP */
+    if (!(s->ctx.export_flags & V9FS_PATHNAME_FSCONTEXT)) {
+        err = -EOPNOTSUPP;
+        goto out_err;
+    }
+
     v9fs_path_write_lock(s);
     err = v9fs_complete_renameat(pdu, olddirfid,
                                  &old_name, newdirfid, &new_name);
@@ -3606,6 +3612,11 @@ static void coroutine_fn v9fs_wstat(void *opaque)
         }
     }
     if (v9stat.name.size != 0) {
+        /* if fs driver is not path based, return EOPNOTSUPP */
+        if (!(s->ctx.export_flags & V9FS_PATHNAME_FSCONTEXT)) {
+            err = -EOPNOTSUPP;
+            goto out;
+        }
         v9fs_path_write_lock(s);
         err = v9fs_complete_rename(pdu, fidp, -1, &v9stat.name);
         v9fs_path_unlock(s);
-- 
2.47.3


