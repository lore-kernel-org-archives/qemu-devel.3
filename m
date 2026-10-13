Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FCDCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcXQ-00060Q-Sb; Tue, 13 Oct 2026 09:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVL-0002wV-3K
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcVJ-0004ok-Mh
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f2LdaYktGs82Qnmc7frP3S/xTyOU8jZtVkCT678YmWk=;
 b=EMvfve1stUUfg0h2WCoZLWrht9jHvzFdzOmlFgd2YcxJxGe5uV+C1wA2DXwcJJwbjCLkva
 KGoyijuCt/mUf+Ma6u9JLSoK2RGHEPR8H/hOAX3INGN5rRxn+CxS4K0//bzmc6nheAccr0
 jGo4bEWq62Jk0xpm6vrUiNNs2YsZpOw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-xM4qeP2XODOQ2uLfY7q4_Q-1; Tue,
 13 Oct 2026 13:25:15 +0000
X-MC-Unique: xM4qeP2XODOQ2uLfY7q4_Q-1
X-Mimecast-MFC-AGG-ID: xM4qeP2XODOQ2uLfY7q4_Q_1791897915
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0208193FAAB; Tue, 13 Oct 2026 13:25:14 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EBB0118002B7; Tue, 13 Oct 2026 13:25:13 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:28 +0400
Subject: [GIT PULL 31/40] ui/console: skip empty update regions in
 qemu_console_update
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-31-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3tCQ2v7+1zm9Aln9u+tppQw/EwNPJBSYIYhRmvi3dSA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDEm+4m/weHrxp1CoqKQK1pM9IjGUIZvZ9Tn
 Lv3JTQNd7OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wxAAKCRDa6OEJdZac
 5bWtD/9Oxc9XUtymxmlAduT3yqF/thrgJ7a7y4KrfFDSP9yjuqq/LApAElRPN/eyg+aLziOz06D
 g7z8aj/OebHFK0TzmHF+NN7F8kYUgqXCmlGIwVMROsU19L3abqIKjPSWPl0wB6IKL0iTiZxOeBB
 bl90uRZ6ReVqnR+owfeJMXNo0/ds+LjIzPZP0Evg6GsX76WQRURCQDATN0Zlmg41fNnvWkmBXyX
 GzRLic+V9pKVfJ9eF9b4hPlgnv8KDvK3uQBvEKh1LB5kMAZvfF2i/u2G/uJQCPG+DRMrN8Vr3bk
 +OPdyx17GULV9YtJHYsb/nEW3o/sZGYv0mODCllO1WU2UehKuhmVq9BMM7JbnaB8ynab/mWbzx0
 uH6AhHG3BeRsqHB0K/qdRdVNoUWfiFjBTLUTDYUsXkjlliNwQe0R+Fy9gg5J/czyFhckfvNVbyH
 aAdmoO2kxPx/lLRCUC7Yy3q/WaZHr2lTfhLjKyabCkQx8/eTTau0VoLSQgdeSGoLLRT5a6z3Caz
 ru7oZ5XYGQBqE6j/NQ94v5yHAp1FShnBtRdduLdxtaysRd4VvhRSUYPealewgTQEFcZWwun/hYJ
 gD6sTWsn8dh8/Rns0Vu7q4E9HDGfHYE+HFwlCTrKo0t8GEGCTeJpKcK7JzakwxkNlD2+urlXpuP
 RFhdekPHTdW0Naw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

After clamping coordinates to the surface dimensions, the resulting
width or height can be zero. Proceeding with such values would pass
degenerate rectangles to display listeners. Return early to avoid
useless work.

Fixes: 7c20b4a374d0 ("console: fix displaychangelisteners interface")
Reported-by: Hui Peng <benquike@gmail.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261004-issue-4560-v1-14-ccbef537cbeb@redhat.com>
---
 ui/console.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/console.c b/ui/console.c
index 14f148118e37..795c9857de82 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -740,6 +740,9 @@ void qemu_console_update(QemuConsole *con, int x, int y, int w, int h)
     y = MIN(y, height);
     w = MIN(w, width - x);
     h = MIN(h, height - y);
+    if (w <= 0 || h <= 0) {
+        return;
+    }
 
     dpy_gfx_update_texture(con, con->surface, x, y, w, h);
     QLIST_FOREACH(dcl, &s->listeners, next) {

-- 
2.56.0.116.g6de20f6092dc


