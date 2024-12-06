Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192B3E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 23:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJhRO-00033J-2Q; Fri, 06 Dec 2024 18:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJhRM-00032Y-VZ
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 18:08:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJhRL-0005pl-Ey
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 18:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733526530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1QzNXwvN8FcYg5cJKrcMuUTC36P3aYUb4tIAI6qAx58=;
 b=g+mhfu12pllRmpVaE0QO5DvLzk+zQgaLws98WfEQyxbma84GOhy7G3aihtiGvIvabC1hNH
 QZTVmVVqGM0Cx8whkmNOgJ6K+3AY5t1kVXgI58RY1tVPKULpLQUD83jE9v7hc8WYnRc4PH
 oMpSLA5lYhIsk+S7Y7d7tfvSmlrdbPs=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-qJDFWSbgM7eowUFssCAiTg-1; Fri, 06 Dec 2024 18:08:49 -0500
X-MC-Unique: qJDFWSbgM7eowUFssCAiTg-1
X-Mimecast-MFC-AGG-ID: qJDFWSbgM7eowUFssCAiTg
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3a815ab079cso18592735ab.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 15:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733526528; x=1734131328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1QzNXwvN8FcYg5cJKrcMuUTC36P3aYUb4tIAI6qAx58=;
 b=iDh3KvF9f2yZIDM6oO231pCRvKRWd+4tDZY3RQSlY79EP//a8KbxWGFcEDnAQ1cB5+
 TBNML2LCRQYj1u/v4yvsxmXmfh9nedrskHriynSrZIRDcKAnsc8bYQdjK7OjrZgo56xY
 Mmm48b1ojE/6VnYcOGp6h4dWLWioI4HAj55XvtKjkTAY5dR/3MYDrs8W4j6kaIHYVEV+
 xp21LdLg20R+NJt9x4xEinDQfPHTBajwtczLelyclZ0tIzt91o/NxCsuMcPKtSm2v+ov
 MNLgkmoDP0Jq7yuF2Yn02nTodimVIj8gCzowsJwygEXtFrAgkZY81zrzTwV+zweDArZJ
 DMUA==
X-Gm-Message-State: AOJu0YzILb5d3QaTcT1P3ZMlH1dtGZ0cs8hVRS1t0E2xE99FGaL99K6u
 W5WF8Hw0nzUUiqEOJabcLImvlJc6CvABBlz7cOkHLWv1PyWgIfbYYmYhpEdnxrfEmMcZwx1i2gc
 m48iJC1xZWO4EgmFK9DlWo0FX3P6YK7PjRr6OZPVsOGCE2IA5tXYC/z0VQ7eILK4CcYeUeJFun+
 O9uyxH5PBAwTkAgPaTrk3bBY5RbZdu6ZNWvQ==
X-Gm-Gg: ASbGncvItxrK9Imj4uXlaGrKIZQLzgIs2W+M9/QvDsrUvtUDV7jU4LuWMFvpbWD5UC2
 ZjALS2m25Zl7n1PBeDTjgdSmYBniRwcRvLPORvv74xti0yxc4jqTTOkARg0v3i4UGrp7j3Ejsz7
 q9jf6l4NjHcBlfhCKlSN7Lns6BSktFAZDzVWfCDcJtmRq7T+uCae4Hp7f0ZTm3FQ0bLmHusoBH7
 wMtwAbnTzY+LXOf5m/DbZBzrGgsYxiSBwkJZ1H06Rg1BJ3nJLe9r/5xSW1EqNW8ind2UCXFwHJk
 cJFQWWNd3fKKw1WIF35pMPhTAQ==
X-Received: by 2002:a05:6e02:198f:b0:3a7:81a4:a557 with SMTP id
 e9e14a558f8ab-3a811e4c7cfmr54055035ab.24.1733526528225; 
 Fri, 06 Dec 2024 15:08:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqzzi7EnrSVeA07zTtFB2kdjmIihOv7I0bHFSYYg/pDqbw3SO8Idu6w5MSZ+popfsnQt9Vdw==
X-Received: by 2002:a05:6e02:198f:b0:3a7:81a4:a557 with SMTP id
 e9e14a558f8ab-3a811e4c7cfmr54054765ab.24.1733526527895; 
 Fri, 06 Dec 2024 15:08:47 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861d9a8dsm1038895173.86.2024.12.06.15.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 15:08:47 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 4/6] migration/block: Apply late-block-active behavior to
 postcopy
Date: Fri,  6 Dec 2024 18:08:36 -0500
Message-ID: <20241206230838.1111496-5-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206230838.1111496-1-peterx@redhat.com>
References: <20241206230838.1111496-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Postcopy never cared about late-block-active.  However there's no mention
in the capability that it doesn't apply to postcopy.

Considering that we _assumed_ late activation is always good, do that too
for postcopy unconditionally, just like precopy.  After this patch, we
should have unified the behavior across all.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 98821c8120..80726726fe 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2137,22 +2137,21 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 
     trace_vmstate_downtime_checkpoint("dst-postcopy-bh-announced");
 
-    /* Make sure all file formats throw away their mutable metadata.
-     * If we get an error here, just don't restart the VM yet. */
-    bdrv_activate_all(&local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        local_err = NULL;
-        autostart = false;
-    }
-
-    trace_vmstate_downtime_checkpoint("dst-postcopy-bh-cache-invalidated");
-
     dirty_bitmap_mig_before_vm_start();
 
     if (autostart) {
-        /* Hold onto your hats, starting the CPU */
-        vm_start();
+        /*
+         * Make sure all file formats throw away their mutable metadata.
+         * If we get an error here, just don't restart the VM yet.
+         */
+        bdrv_activate_all(&local_err);
+        trace_vmstate_downtime_checkpoint("dst-postcopy-bh-cache-invalidated");
+        if (local_err) {
+            error_report_err(local_err);
+            local_err = NULL;
+        } else {
+            vm_start();
+        }
     } else {
         /* leave it paused and let management decide when to start the CPU */
         runstate_set(RUN_STATE_PAUSED);
-- 
2.47.0


