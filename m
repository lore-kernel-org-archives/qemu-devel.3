Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBA7C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 11:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnaMT-0007Z2-Ve; Sat, 25 Jul 2026 07:16:10 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a0414545a212e27058fab7b057b018e75b8c4b13@kylie.crudebyte.com>)
 id 1wnaMJ-0007Wl-7T; Sat, 25 Jul 2026 07:16:00 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a0414545a212e27058fab7b057b018e75b8c4b13@kylie.crudebyte.com>)
 id 1wnaM7-0006RV-K1; Sat, 25 Jul 2026 07:15:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:References:In-Reply-To:Message-ID:Content-ID:
 Content-Description; bh=3V6OFWjKWMNdEgXvrT0O9LnloRaUB2VVmbg60TB5Eow=; b=vv1LZ
 QvOztaCd4bs1MkTl/HUR5s/pfhPsTENtMf/kC1ZzBJUQB6WALAWW0hu2dJCxI0HWUSYcHXoRo58Jz
 Q6jjBsVBoc6npD+M6qos5WE0NqSwHOnojbxQdY5dvsIdL9mDPlfAXfbg8KbXjNNrPjWTTMBWlL2re
 SaFAC4yITsKt1AGxFPjI01W4jSMDBhyT1HgIew5QpZTIL5lV/PSQp0ppJr9Dp5NA877Fax7d2/g+j
 dBr5VV9N9v8Qv2swRGBA8J7l3E+v2Hvsl0XAfG/pzd6CNLAh+I9Imt1Z6Mq1ZZ9JIVVp5AAeCvgHm
 wT/aXDVE28Uwywggk97mxdCofVgqnXY3Bpri9Y/eJeZRtf5gYibEL218ppkmveaUiUCyGdkeEKE5F
 /2H+kqLFoSMNhY65L5fZDSyLA7CqAwT0wqrjc1CiDeDK7vmUEjaFDbyi3CjFda87LeIEWQbL1Myy7
 f2LBU9LHAl9zocohcQMMvw5FPSftvzcBJlCnJxlc6zreBQzCuMpN2SQLMlNbBXAeofWrXsQ0r+AZh
 EMVZSt8rgfUzeAU0lkzy5BhqercD3Gyn+q88M5q+29mbrPvtqFy7FYnVXsHOlRBurHGi9Nmf9AguB
 yZHIHWfUimofx9dgttV4mfulIn6Ia1r7RKIH8LONooFFdPbQDIVqoMdTyRVZrs=;
Message-ID: <a0414545a212e27058fab7b057b018e75b8c4b13.1784977523.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1784977523.git.qemu_oss@crudebyte.com>
References: <cover.1784977523.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 25 Jul 2026 13:05:24 +0200
Subject: [PULL 3/5] hw/9pfs: fix O_TRUNC bypass on read-only export
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>,
    Peter Maydell <peter.maydell@linaro.org>,
    Daniel P. Berrangé <berrange@redhat.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=a0414545a212e27058fab7b057b018e75b8c4b13@kylie.crudebyte.com;
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

Guest 9p client opening a file with O_TRUNC on a read-only 9p file
system using 9p2000.u protocol version, allowed to bypass 9p
server's read-only check, eventually causing file(s) being
truncated to empty file(s) on host's read-only export.

Root cause is that 9p server's read-only check is using Linux open
flags like O_WRONLY, O_RDWR, O_TRUNC, but checking them against
the 9p Topen request's "mode" parameter, which has a different
encoding (Otrunc = 0x10 vs. O_TRUNC = 0x200).

Fix this by checking against the "flags" variable instead of the
protocol's "mode" option. Because the "flags" variable is already
converted to Linux encoding by omode_to_uflags() for 9p2000.u and
by get_dotl_openflags() for 9p2000.L protocol version.

Only 9p2000.u was affected by this bypass, 9p2000.L uses the Linux
format on protocol level already.

Fixes: 2c74c2cb4b ("hw/9pfs: Read-only support for 9p export")
Fixes: CVE-2026-63318
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4000
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/qemu-devel/E1wk2Dq-0019kY-JK@kylie.crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 3119f01117..474ac6cc40 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2181,8 +2181,8 @@ static void coroutine_fn v9fs_open(void *opaque)
             flags = omode_to_uflags(mode);
         }
         if (is_ro_export(&s->ctx)) {
-            if (mode & O_WRONLY || mode & O_RDWR ||
-                mode & O_APPEND || mode & O_TRUNC) {
+            if (flags & O_WRONLY || flags & O_RDWR ||
+                flags & O_APPEND || flags & O_TRUNC) {
                 err = -EROFS;
                 goto out;
             }
-- 
2.47.3


