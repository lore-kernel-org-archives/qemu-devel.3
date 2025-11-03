Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E2FCCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1mE-0001Ak-Hu; Mon, 03 Nov 2025 16:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1mC-00019U-SI
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lp-0005TQ-Tq
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7JUxEIo0LRTKvG88sXg9U9GCAdj7XhcKAw4AkAelO9A=;
 b=OgBOZe0d4eZ08YacJIeFZgXd2yrWC4Yk6vdIxmOKD0r3M1LTmoZCP9H9H1Mio4J3FiFRU/
 gcfve2glQ48O55RZxPMGEpHoIP35WEr24nfu0FNr4ecHGr6EEr3ausAkZS6e6GcHEIhs1G
 jhXEhLjUjKGKi0SHJo1xOXClD6vU/0k=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-b18S-B_ePoOXyVw4vWqhxA-1; Mon, 03 Nov 2025 16:07:18 -0500
X-MC-Unique: b18S-B_ePoOXyVw4vWqhxA-1
X-Mimecast-MFC-AGG-ID: b18S-B_ePoOXyVw4vWqhxA_1762204037
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8910b0fb780so735411585a.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204037; x=1762808837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7JUxEIo0LRTKvG88sXg9U9GCAdj7XhcKAw4AkAelO9A=;
 b=gtB/gS/xFaHWRjJiOazjHWNqkk5AROXGgcio2fDCsxoTvObo0ahfEsu1xdzG7q4uE9
 CwVFiIt9uRz5vSYIPIkdAe8jKWfaM4gkoSMH3AHGbXZYr/TLKXFvfTgM9KhLMr9o2eff
 fFpKIvJv53Mmt64sVlaMh8MNFKMIX5XbRSNhpFdfUyALr/FCI9detNpelzPSbs6qDmF1
 ONcH10+7Fp/tJ0POAfWC5O44czA/yQUdqmBuDdxRGxU3xs2z8ZKPcPsWmAy41Lj17sbf
 9rqUqSjUf3jqn/8kgCY/JBphEf0wLjVbFfHpM3qxqaChhqJ/0NClI4eebASzyFtu8HTC
 OEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204037; x=1762808837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7JUxEIo0LRTKvG88sXg9U9GCAdj7XhcKAw4AkAelO9A=;
 b=mzsJUr1AT/GM25dyk3U0MFUaZfnx9l6nIJBiP/I2ZZm2BleYmncUEYVTVlUwZ1KcNg
 ajPHBkaNjzeH5TIaE2H+a/+z7DjeVQjTJ08jSQx6ITRBen4t1UMU2c/AnOppsp9/Ja9i
 kLJMjzb+srxJFXS6u9FmwiHuFSBT5Fn8QYOIuUuy6C+WRErJze7LkL62hZb/sV7JhUDt
 bNSfQXsClw3vj27GM+dnAc2d5rJWFF4wu7jKwcDKDOMx7M6ya+a1NdZZx2L/XLXQgQgJ
 wIZKUi1EvC+T86IjWGXAORNLTLwsDbeVtb1mFw6H2aPT3s5UVd3XsNqVsM7spqCQIWPh
 Wj8Q==
X-Gm-Message-State: AOJu0Yw5BAkh0/HYLXBWrPvbKFkbgd8pSz348w4oeIjlBcDFep7AWadO
 fFQbdTc6lL0uozrx2tJp6rZiVTXQbVyWInJpAWxpqgOyOETWcvikmUrE1Mp35G1CCJuIkPe3Psn
 z8rXke+xxPZf3Wir2/T+A7WjHPi8P0tphFp2MERph5rMmVlOWWZcPzgVNs2ytrTeV5w5IW1WHjV
 FMo2TZkWaSRzctDndyBQ6nmnzLhlZ1dTKIyAMrcQ==
X-Gm-Gg: ASbGnct2OvLsq8Jtz5jVG51SzbXNwdEKZiqJWs60Nk/yZzs7hTd0m5ZlF42HFP4P7+a
 cRMadcAdx1aMSQSEJLlI1dgfzllbm1qRWb4oZfSh71OPdBdpKtd+emil7qMlWCS0X6on+Ood4HQ
 GKuPQDK0EiAYSiY7Grp4ajYsxR71yKdlHqAyFHHfw7O/S5uJ2QpDfjfXhGggERbiz6XNv0uIdz2
 iJzSXn5H1beFhIJFRkaRdmoCJXQb1Wr+L4ybYntD1JjMc7uARep4qGHt6ZaduQYPlS5jrhE9mDu
 fPwYzuhoWNhduhtrie2vb2MOIafXVDJzo2FAj+8YUu2l1oDYMq+TLZhY65QHt68S
X-Received: by 2002:a05:620a:4507:b0:8a3:1b83:fd9 with SMTP id
 af79cd13be357-8ab99979159mr1824108085a.24.1762204037209; 
 Mon, 03 Nov 2025 13:07:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJnc+nmZcPQYPieMjLQJcnC1SSx3u4ZHlqZKQuZHk244jdzmbNWBHK1RWNlD0dYr0vsqQpug==
X-Received: by 2002:a05:620a:4507:b0:8a3:1b83:fd9 with SMTP id
 af79cd13be357-8ab99979159mr1824100685a.24.1762204036512; 
 Mon, 03 Nov 2025 13:07:16 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:07:16 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 35/36] migration: Make postcopy listen thread joinable
Date: Mon,  3 Nov 2025 16:06:24 -0500
Message-ID: <20251103210625.3689448-36-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Juraj Marcin <jmarcin@redhat.com>

This patch makes the listen thread joinable instead detached, and joins
it alongside other postcopy threads.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20251103183301.3840862-8-jmarcin@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 91431f02a4..8405cce7b4 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2181,7 +2181,6 @@ static void *postcopy_listen_thread(void *opaque)
 
 out:
     rcu_unregister_thread();
-    mis->have_listen_thread = false;
     postcopy_state_set(POSTCOPY_INCOMING_END);
 
     migration_bh_schedule(postcopy_listen_thread_bh, NULL);
@@ -2215,7 +2214,7 @@ int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp)
     mis->have_listen_thread = true;
     postcopy_thread_create(mis, &mis->listen_thread,
                            MIGRATION_THREAD_DST_LISTEN,
-                           postcopy_listen_thread, QEMU_THREAD_DETACHED);
+                           postcopy_listen_thread, QEMU_THREAD_JOINABLE);
 
     return 0;
 }
@@ -2224,6 +2223,11 @@ int postcopy_incoming_cleanup(MigrationIncomingState *mis)
 {
     int rc = 0;
 
+    if (mis->have_listen_thread) {
+        qemu_thread_join(&mis->listen_thread);
+        mis->have_listen_thread = false;
+    }
+
     if (migrate_postcopy_ram()) {
         rc = postcopy_ram_incoming_cleanup(mis);
     }
-- 
2.50.1


