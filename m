Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4034ECA5FF1
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJP4-0006DK-D2; Sun, 04 Oct 2026 06:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOh-000514-3x
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJOf-0002w2-4s
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cncY3n37MX0ZLXuZxssspxcUK/B5WnelkO8mjp8quDE=;
 b=axoGWGX9NuZNed9Pd5+WixMAm52QS3Er1jXhZog778mgWDaRo7PBHNaouyQ4QFuaKcodre
 gQxL1fslVG/IMmocusF3OdYECTGPj88dVuQDaWFebMDOnRXhFY7aveGkKSugsMg6ffanT5
 uWxUqW1Zs3+OTxPYciexOt4NBekmjR0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-biaMxj32PC25Yb5LQIjsWg-1; Sun,
 04 Oct 2026 06:24:43 -0400
X-MC-Unique: biaMxj32PC25Yb5LQIjsWg-1
X-Mimecast-MFC-AGG-ID: biaMxj32PC25Yb5LQIjsWg_1791109482
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14761195421B; Sun,  4 Oct 2026 10:24:42 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2DE9730000E5; Sun,  4 Oct 2026 10:24:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:32 +0400
Subject: [PATCH 18/63] ui/vnc-jobs: assert rect coordinates and dimensions
 in vnc_job_add_rect
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-18-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=771;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=4XWw63//K3Jg8uwM2Vm7MV83gBOSjIM0kTH9lCU6ysk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikiTT+a5LXK+kx3Wt9T97husfzmX4teG6bz0
 HrLleKWatmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIgAKCRDa6OEJdZac
 5XbAD/9lqIbvgUa9FHhAwmGflG4A0DCCTUyA7MMAP8+ePBLPtsiKP+WSm/Swi6tE+ILk9ZX/cuC
 bgu3cswFRxR3OiPXlj+AC6rJ0I8gXKy/SyJ6tVhGues+kQ6SjDXq6XEitUIl+fDz6dydTYeZE/P
 4ZdL7Tkeiy6P7shqWUbKiiuYJrVY1MPFD3EP20ncdrMJoXw2Bnbxr1l36JIL3pt3H7D8Cis4mB0
 3EupkwJo/P9R+teSAl7emlllFJhAuVL4h04QefDRvpExHzwM+0KELgl7Vol6kL81p3X0GDi/LWL
 4/D1gCvMWRPU4lz7SizPjH89E28ltNLgipbXvDw8qaQJ/BLq+L2Pk3PqDzvkAJK7p1RTmMaBn1O
 yvdJlZZVqWhqhgkS5xVq7yAFF5GDtqAea9pM79AmS+y8LnF0gL+CqQj7F8jCRTBWvaAlKK9HiMo
 mNZ6g4hk1wzwwFeIbXfz8qipQg/Ca9k+ZAAj9NlBsuv8F0euCVFnXPYm4aKlKgaMAERPtzkKeq+
 J2PqvNcy4F1lcbs/vLCq+XX3jIOfhFn3JyCKlAmEWAp+ZhCLHTH5KFJZngglspDILaIGONntzui
 bsE/czT6ma5GHJA7jkymBUc8qEvrj0TVF6MROXgZ6/qMha/c+Sl9sliwqFJvIKlbiz/kggouSOC
 d6B1WbSDttB7uIQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

All callers guarantee non-negative coordinates and positive
dimensions. Add an assert to document the invariant that
vnc_worker_clamp_rect relies on.

Reported-by: Pavee Hui <phui@google.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc-jobs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index 90b68bf4cb98..81c4fa5dbdbb 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -87,6 +87,7 @@ int vnc_job_add_rect(VncJob *job, int x, int y, int w, int h)
 
     trace_vnc_job_add_rect(job->vs, job, x, y, w, h);
     assert(!QTAILQ_IN_USE(job, next));
+    assert(x >= 0 && y >= 0 && w > 0 && h > 0);
 
     entry->rect.x = x;
     entry->rect.y = y;

-- 
2.56.0.rc0.29.g47ce80527c56


