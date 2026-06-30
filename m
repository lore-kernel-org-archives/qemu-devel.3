Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B88DC43602
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaB4-0002fq-Fm; Tue, 30 Jun 2026 11:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaB2-0002bJ-4m
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:15:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1weaB0-00008I-Ml
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 11:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782832506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D9Q14PAE9pPdWglsxDRBhSOEwrj4jxBYYcicl1P2ux0=;
 b=E8D+ZWV9JHXY3hxS0UzxD+ptitFzfn2AsqYsxZzHAZKSYO5c2G3C73noKdpcCJH8or9wRI
 hmiLbbmXHdWFuDmD5bdMxhhiMh7hoKITHurEIsr0btg9E5PJrMqrSjvg/WCP46zl+kYRP1
 9nmJM2pY2ExREDH0HrpPnKh2Hi0pmOk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-g04iUS9cOo2XyzXYIt-wZQ-1; Tue,
 30 Jun 2026 11:15:03 -0400
X-MC-Unique: g04iUS9cOo2XyzXYIt-wZQ-1
X-Mimecast-MFC-AGG-ID: g04iUS9cOo2XyzXYIt-wZQ_1782832503
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8F871954B39
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:15:02 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE878180067F; Tue, 30 Jun 2026 15:15:01 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Jun 2026 19:13:17 +0400
Subject: [GIT PULL 2/8] dump: refuse dump-guest-memory while guest RAM is
 being migrated
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260630-dump-v1-2-7df3087dffc9@redhat.com>
References: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
In-Reply-To: <20260630-dump-v1-0-7df3087dffc9@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1723;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=A2r/x2MO5sa7tnjKrukI/PrYT92CuCLxO/f5hhMN720=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqQ91nRrpbSEvnaq6Fo3BKxXk4Ik+6SSRiD4PDs
 g/i3DzZpEGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakPdZwAKCRDa6OEJdZac
 5TliEACtckkzd87HA51rV9NlwgQEUGWChPyZ0qVpt9feAQ+40E6X40HNeUOklj0PRURrppzMYWQ
 AvoXWUeCYKfcuWCi0eBSWSaZ+4fyMWyFwSbyKopULfwojZVsBssGAHPILiYG3SPdhCNfqrETgBq
 dICRsu6C2WyLQ3WDVC7q38dZebb+7/2WfNmoRNkIGFWbBJWSHyP/ZMhRtZTqknRpqyYHs5YRjtf
 gUsa2S6Q9gwPlq1vIXgWN+OU0trlD4wToChItbqewIz9Hlm5+AGKEtz9aCGkOKTOECRLjMe5sj0
 uy1cJedW3LFCgEvO8NWUvw0+T/OZlzAI1GMzOBHDV3kOgce+wqG8R1mh/raq8LQrWaw3JLt+435
 06kUmPF5pfEYY27Q7gL4hD7FSMtocuOy4iFMGqrppNALGTQL60bu93nREkWbacADlsTAMS/ApKq
 fLOkZV94j17S70TjqN5MvmXGMrpKwBk06032l2uOY2bWuH1xJKHCn02VR41TnDw0+crn//zHzLb
 aRn3EawFr28I8fzj00VyGxapZNgxzymtG+UKOrr7wixxZCFWSiTBmr6wM4VSujzVAn/R+F/STnL
 OQrRO4QkZ12d8hXpJh2U7sjYnFNeoh14Bwd0lfXxK61XRPOl5WbS51j2jzymZdmusAQmaghLGbo
 69tb6U2cyLFE01A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: "Denis V. Lunev" <den@openvz.org>

dump-guest-memory reads all of guest RAM. The existing guard only rejects
the dump in RUN_STATE_INMIGRATE, i.e. the precopy load phase. On a
postcopy destination the guest already runs (RUN_STATE_RUNNING) while its
pages are pulled from the source on demand.

A non-detached dump reads that RAM on the main thread with the BQL held.
Touching a not-yet-received page blocks on the userfault, and because the
postcopy incoming path itself takes the BQL to install pages, the
transfer that would satisfy the fault cannot progress: the VM deadlocks.

Use migration_guest_ram_loading(), which also covers postcopy, so the
dump is refused for the whole time the destination is still receiving
guest RAM.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260619101834.228432-3-den@openvz.org>
---
 dump/dump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index eb2ee1c10df..7fa2d6f788c 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -30,6 +30,7 @@
 #include "qemu/main-loop.h"
 #include "hw/misc/vmcoreinfo.h"
 #include "migration/blocker.h"
+#include "migration/misc.h"
 #include "hw/core/cpu.h"
 #include "win_dump.h"
 #include "qemu/range.h"
@@ -2080,8 +2081,8 @@ void qmp_dump_guest_memory(bool paging, const char *protocol,
     bool detach_p = false;
     bool kdump_raw = false;
 
-    if (runstate_check(RUN_STATE_INMIGRATE)) {
-        error_setg(errp, "Dump not allowed during incoming migration.");
+    if (migration_guest_ram_loading()) {
+        error_setg(errp, "Dump not allowed during migration.");
         return;
     }
 

-- 
2.54.0


