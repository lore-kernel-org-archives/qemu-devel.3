Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F7ECCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 08:12:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBqPw-00074V-RK; Thu, 23 Oct 2025 04:11:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vBqPu-00072F-A0; Thu, 23 Oct 2025 04:11:26 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vBqPp-0005jX-5F; Thu, 23 Oct 2025 04:11:26 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59N8B470071845
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 23 Oct 2025 17:11:14 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=YI6AcWaknwGQjA/0MF5wdHYKtn9Hg1bdj98qn4IDn0A=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1761207074; v=1;
 b=OwlA73iGe/K3hEFtZ46pXIi+LjKZXIUI/mFWRGa368y0qUem3dfypprMgBndgxv+
 R4hRFbGvVqG0NweEXB7vbcYeIpB6NbHt9711jEJqrdrr6oa+Y+dFDYe3dlJ9m2mx
 i2J970XsZnJbw4Grs+o04urEKAdNI1yqQp8L5kDSU5E/xYdIlXXvXY3R0YyByvC1
 WJAh086/uh2eKl9QjUZtJBVfGx3853RxTAFN8zZ5XmErBLFLBFBBZFs2PHsBEihe
 PChZoOvoRp2d0SSCOFaCD76XV+DhWq6rDYjMhpiet57RGrlqWvAFmSufWGgtSju2
 LmZ0fCUpOkaFYUewcmEtoQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 23 Oct 2025 17:10:58 +0900
Subject: [PATCH 1/2] qemu-img: Fix amend option parse error handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-iotests-v1-1-fab143ca4c2f@rsg.ci.i.u-tokyo.ac.jp>
References: <20251023-iotests-v1-0-fab143ca4c2f@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251023-iotests-v1-0-fab143ca4c2f@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

qemu_opts_del(opts) dereferences opts->list, which is the old amend_opts
pointer that can be dangling after executing
qemu_opts_append(amend_opts, bs->drv->create_opts) and cause
use-after-free.

Fix the potential use-after-free by moving the qemu_opts_del() call
before the qemu_opts_append() call.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 qemu-img.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 7a162fdc08d3..63961e2b76f0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4571,9 +4571,9 @@ static int img_amend(const img_cmd_t *ccmd, int argc, char **argv)
     amend_opts = qemu_opts_append(amend_opts, bs->drv->amend_opts);
     opts = qemu_opts_create(amend_opts, NULL, 0, &error_abort);
     if (!qemu_opts_do_parse(opts, options, NULL, &err)) {
+        qemu_opts_del(opts);
         /* Try to parse options using the create options */
         amend_opts = qemu_opts_append(amend_opts, bs->drv->create_opts);
-        qemu_opts_del(opts);
         opts = qemu_opts_create(amend_opts, NULL, 0, &error_abort);
         if (qemu_opts_do_parse(opts, options, NULL, NULL)) {
             error_append_hint(&err,

-- 
2.51.0


