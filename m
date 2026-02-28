Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D75CFEE4EF
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 13:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwKpq-0003AX-GJ; Sat, 28 Feb 2026 08:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b72d15f47cbd2fc93580f33fa86a7e23595a68dd@kylie.crudebyte.com>)
 id 1vwKpo-0003AO-Vx
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 08:58:21 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b72d15f47cbd2fc93580f33fa86a7e23595a68dd@kylie.crudebyte.com>)
 id 1vwKpn-0003NA-F1
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 08:58:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=cFd9n5rfW9WJFmXOWVXBIQCFB1oYPWrSUubyVp4X3+Q=; b=ogRFH
 DRAV136W+t2UOWynEm0vEj8utD8q1uBw8TUL2LiFHahvaDDPRSRDdY9Wdt9lW6RqOQUunEll+Z+s+
 CwhNU5GVAgYRbJv4EJwaFiT4okvLNHwr4o3SubokLEnGfG5G4UWwxi+Gq+PCqKanqjI9YldfqA56I
 sY87oG4YFLTt90DNFQLhSeL0XbZB7nc2MkzIFPYcwrErADmX4n5T8aoKIpncEjQcoMxIMzmcVTjEg
 I7H8ttdUp+cFUMJ/ui3xCY8ZK3coFqaULUXXXE4EPTC2a5lwQp7b6xz55HZ3h9ebxTM2DS1cv44B3
 76ui7S8no3Qkd8xdTdmn4rQJutN/37z3xHCx906sIAPI1nhVUiVeRD/qsgnf7gAlrtIWXbnct5v6y
 XjTC2GAPDDiQ0jGLzj/4o8GXpaCwwpu/5sFLx80o6uveVFgFf/80zic8CMYv29V1cFtNLG3NigBIT
 PPiXQDYBvdmeLci329jg7mO+H/ifrSeTLkQGZNdH6QVDGSs5V37u0NJtnu3UQycuUO6Ea0EB3EzrB
 dAi6P8qzDyJjYi1f3ZiqsgEmyud8bo07fjR13tQdjfaLpt93ra1RayMTQoO+BTPbSBsBeu83MZErV
 ezuMxXsGJjlOPYv1+W5m10Um7QQc1bqpBWyA1ES93KhZ/Tp+/ZV/bWWwe4AHQ0=;
Message-ID: <b72d15f47cbd2fc93580f33fa86a7e23595a68dd.1772285406.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1772285406.git.qemu_oss@crudebyte.com>
References: <cover.1772285406.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 28 Feb 2026 14:30:06 +0100
Subject: [PULL 2/2] hw/9pfs: fix missing EOPNOTSUPP on Twstat and Trenameat
 for fs synth driver
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
    Oliver Chang <ochang@google.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=b72d15f47cbd2fc93580f33fa86a7e23595a68dd@kylie.crudebyte.com;
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
Reviewed-by: Greg Kurz <groug@kaod.org>
Link: https://lore.kernel.org/qemu-devel/E1vrbaP-000Gqb-B3@kylie.crudebyte.com/
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


