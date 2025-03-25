Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2DBC3600D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 20:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txBKd-0002lK-Mt; Tue, 25 Mar 2025 16:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1txBKb-0002kv-U1; Tue, 25 Mar 2025 16:57:05 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1txBKZ-0002Xo-5n; Tue, 25 Mar 2025 16:57:05 -0400
DKIM-Signature: a=rsa-sha256; bh=KBHHJ0S1QqAA7VtLQx4RDhVtq5KSjFOfBkWMWlFPstk=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1742936219; v=1;
 b=ZetlacOIO/579+FF7XRFA3cnJfEzCtaVhJDZyQklNIWytKPYTtdeiD1DEVvxzO38JKqhpJIh
 9WgAgr+JLi4sPIfo6nZ3MuObayOoZlAMvhbIQa04xtPE++VG+imIlOHdfZ/NrPQyMtwuHyoi2+3
 F01DneFAQ8p2yvw1kT2udRjUzR5wXa5l9/4EylEedeGF5T9ou8ubCUSnTcHuOsgDHSQQ/Hoc+RK
 0CmSl1b64hQqS3hMbzxEZhGq6JyOqrVMq/nQa56So5bk0cWC8pxuRlLvdpGxHM//WK5ltzCoXU5
 qMNiMgY+0U5suoQncDC9+Dl3bbYS6ln+QdLwrD7/MZREg==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 4E4E52087D;
 Tue, 25 Mar 2025 20:56:59 +0000 (UTC)
From: ~h0lyalg0rithm <h0lyalg0rithm@git.sr.ht>
Date: Tue, 25 Mar 2025 21:49:38 +0100
Subject: [PATCH qemu 1/1] Add IOURING_SETUP_SINGLE_ISSUER flag to improve
 iouring performance
Message-ID: <174293621917.22751.11381319865102029969-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <174293621917.22751.11381319865102029969-0@git.sr.ht>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_REPLYTO=2.095,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~h0lyalg0rithm <surajshirvankar@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Suraj Shirvankar <surajshirvankar@gmail.com>

Signed-off-by: Suraj Shirvankar <surajshirvankar@gmail.com>
---
 util/fdmon-io_uring.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/util/fdmon-io_uring.c b/util/fdmon-io_uring.c
index b0d68bdc44..235837abcb 100644
--- a/util/fdmon-io_uring.c
+++ b/util/fdmon-io_uring.c
@@ -324,8 +324,14 @@ static const FDMonOps fdmon_io_uring_ops =3D {
 bool fdmon_io_uring_setup(AioContext *ctx)
 {
     int ret;
+    unsigned int flags =3D 0;
=20
-    ret =3D io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_uring=
, 0);
+    /* This improves performance but can be skipped on old hosts */
+#ifdef IORING_SETUP_SINGLE_ISSUER
+    flags |=3D IORING_SETUP_SINGLE_ISSUER
+#endif
+
+    ret =3D io_uring_queue_init(FDMON_IO_URING_ENTRIES, &ctx->fdmon_io_uring=
, flags);
     if (ret !=3D 0) {
         return false;
     }
--=20
2.45.3

