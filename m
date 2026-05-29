Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882DACD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 17:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT0g0-0006C0-W1; Fri, 29 May 2026 13:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <662333331d371c6c343c8091161de8eaa121880e@kylie.crudebyte.com>)
 id 1wT0fk-0006A6-Q3; Fri, 29 May 2026 13:07:03 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <662333331d371c6c343c8091161de8eaa121880e@kylie.crudebyte.com>)
 id 1wT0fi-0005yP-A3; Fri, 29 May 2026 13:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=VI1Vr5pQLC5ZGMOmjMtI/rZPEM24szP1EeBghlRj3pc=; b=IO5yo
 izLto9gTDhetfii8fgsPvvbkd7twDbXxBQHh3UqGSxlRbstFDruWpMWsn/fiRxHj6yDDJY4fRLULF
 o7szGtBNSWXcKnaefKi0gXc9/Q8bnxtw0PRLLpLuMT0t0+31HDlsRJfiKyJ+zXjc27Ey5gRnLvD9h
 rsYcmiJpfOvpz9j4WvPSfU9elKY9OzJJk//a/Xqfn9Z/TRrc1Bnaf2RYd0oD/ob7Q3qKOl6xPIXnB
 6wLGMza5A7fOkDJitvS6iCb3JxFDIwzXOETAOkEwsZshNfAty3reDmglzUqpDhMcHrduME5mC5EwP
 9CYjAMrHRVRIE1OJaWvUDORPLUajlwKZEFsAlDgej4bZNGvr/21hdm0eV+4vslf0qR4Xm2Os01FUg
 CCrOfMM3DmXjAcaij1VtD6IJmsBzKQxUQYK9QTpkmE+f8BqUkH7fLxPv1Ct0fkVYK1Cfd8PB0Cz5N
 I0peRdEDmqx5Zzc6Fm/ufSmqbK8kREsYYbfMQ9NYeFgYjdqWwf9gpeXIReRX6aS2EthvuuHH88wPx
 ZNPolzitbX4qA8357L0cB64npFrOQkUwo74xI/4CTm5M9cQwp9XFsdeFFEaOoti56jskw/6Hfb3Rs
 VoT7ym55L6g2mbx2spOwo63vPQuO+gPZWMAhlvv7nx4XzhX/kyrrtjXK4gOiYs=;
Message-ID: <662333331d371c6c343c8091161de8eaa121880e.1780072238.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780072238.git.qemu_oss@crudebyte.com>
References: <cover.1780072238.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 29 May 2026 18:29:40 +0200
Subject: [PATCH 2/3] hw/9pfs: reject . and .. in Twstat rename
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=662333331d371c6c343c8091161de8eaa121880e@kylie.crudebyte.com;
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

The other Trename and Trenameat handlers already reject "." and ".."
as new name on rename requests by returning -EISDIR in this case.

The legacy Twstat rename handler is missing this validation. While passing
"." or ".." does not trigger a crash as fixed by the previous patch (since
the fs backend driver's system calls handle these gracefully), it creates
a behavioral inconsistency, as it is semantically meaningless to rename a
file to a directory reference in the first place.

Fix this by rejecting "." and ".." in Twstat rename handler with -EISDIR
to match behavior of Trename and Trenameat handlers.

Fixes: 8cf89e007a ("virtio-9p: Add P9_TWSTAT support")
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 88fb28b318..a09f99537d 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3621,6 +3621,10 @@ static void coroutine_fn v9fs_wstat(void *opaque)
             err = -ENOENT;
             goto out;
         }
+        if (!strcmp(".", v9stat.name.data) || !strcmp("..", v9stat.name.data)) {
+            err = -EISDIR;
+            goto out;
+        }
 
         v9fs_path_write_lock(s);
         err = v9fs_complete_rename(pdu, fidp, -1, &v9stat.name);
-- 
2.47.3

