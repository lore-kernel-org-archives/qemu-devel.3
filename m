Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFF2CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4hut-0005QK-Hy; Fri, 03 Oct 2025 11:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4huG-0004yM-Om
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htZ-0007g4-7e
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1g2Sxok607Yo9JEcyhMVUtKx0gT/Ws32nxPb9ZfJE0g=;
 b=NjsMGLays84vOyyJgeVhFbo6sRFGNrTexsu/LDdN+NuihzxugrX4ixbaGd5IC2tXSJiOUH
 aQJ/xgGyj/yCtQWoxBfP6nE65N7vbtTgTpBBAJEuXYgp2yKGyFhVwz3RvCKIwyyD4HwTy2
 AUyJ/aKcmRFWIj+CjP5MldqLmB/bNlw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-Zy-8K654P0yJFo5zSG9rkw-1; Fri, 03 Oct 2025 11:40:27 -0400
X-MC-Unique: Zy-8K654P0yJFo5zSG9rkw-1
X-Mimecast-MFC-AGG-ID: Zy-8K654P0yJFo5zSG9rkw_1759506027
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8741223accfso49094316d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506027; x=1760110827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1g2Sxok607Yo9JEcyhMVUtKx0gT/Ws32nxPb9ZfJE0g=;
 b=JNwZ1UMq2foTBwWobAAwy+Nq5Q04eahw1QXeoMqUNivFRaU41SeagENrOhE+kHS0L+
 KnXYil+4CtQb1T1L/VfsJP1TI6H18Zj9NbRUTe91RmXTQuWigGy6NHHcI9p2GikVnfC4
 8PkQ1N7RXYmDi+OL7U7CjIYod1As85GG8Jmj3tn0qfM5n6ZXjIqd2pm6BhW96uqxerNP
 qEyX43jF1DSW5ewJVZwGunWUJOYaTCY5td0c8ds9rXW+OUeME3afY6ARbBxI5GOL0QI6
 hokglYSqCww/Ogo6GgyAxJXh13iqUj3/2ceGroJ6hhtu5Shsov9xkbcqS7vLkCdMt8Nk
 gC5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP2PdhiceLaD3X0TikpiKHJzOLbNaGBAeG3f/plYEH4hnfToqLWF5LTokQC+hw7qzTaueAj3EtuYIt@nongnu.org
X-Gm-Message-State: AOJu0YyDMH1gUv5vZ4xOZhUwMjrl2q7QEU8eCg8DpoiimoX6kCizei6h
 5iChWP/+p7GJzmywkkUfW4pEebYl8rCp53dsgV2PT8KzTFO/8nZPRonH0KFSyH7xfjNROgn+uDh
 nby7cZx/aeCfaRfpkiRba/k29pQQAaE7HDWt7RDZt0tocWZ1uD/c4IRNV
X-Gm-Gg: ASbGncuMQJvvizoe5A6h83NlaZKcJUy1PaW0NttBZTmOC1kyKH8zRWW6zj5y1cBRTKK
 vv4muRf/GdoTjDYjCo2YGYFfB3LNuNkwpGw+g7+mzLqS2d0qv0U7EiN0xFYdDn6lDj9g+CuT6UD
 eTW6n23A/we+TaH954QegxRemZsAZyvcvnFOvxhKxcEjoImNgDxOA+frz9x3h/j1CCfQMcsLBHp
 ixxEfEBmxPJ9NZnLINGMpcGy2Jj3N2OX47JGe+bz5vDqCdsa4GEO77Na2utB2EzsxuzUgo/8/Ds
 jyNjKwvVYH6uCabHhpxhYbu6wNP0Z0nDjkJOyg==
X-Received: by 2002:ad4:5d41:0:b0:78e:8e52:e5fd with SMTP id
 6a1803df08f44-879dc7c919dmr40954816d6.29.1759506026761; 
 Fri, 03 Oct 2025 08:40:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyiFrRbZo7sEPv1UsPZuY/IbBN8sWbNZJqwUmYe+9alux12/KVNojkRCbzhrgowBWHjJuhBw==
X-Received: by 2002:ad4:5d41:0:b0:78e:8e52:e5fd with SMTP id
 6a1803df08f44-879dc7c919dmr40954456d6.29.1759506026304; 
 Fri, 03 Oct 2025 08:40:26 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:25 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Arun Menon <armenon@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 23/45] migration: Capture error in postcopy_ram_listen_thread()
Date: Fri,  3 Oct 2025 11:39:26 -0400
Message-ID: <20251003153948.1304776-24-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Arun Menon <armenon@redhat.com>

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
to load the vm, and in case of a failure, it should set the error
in the migration object.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Link: https://lore.kernel.org/r/20250918-propagate_tpm_error-v14-23-36f11a6fb9d3@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 34b7a28d38..996673b679 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2095,6 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     QEMUFile *f = mis->from_src_file;
     int load_res;
     MigrationState *migr = migrate_get_current();
+    Error *local_err = NULL;
 
     object_ref(OBJECT(migr));
 
@@ -2111,7 +2112,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true, &error_fatal);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis, &error_fatal);
+    load_res = qemu_loadvm_state_main(f, mis, &local_err);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2137,7 +2138,10 @@ static void *postcopy_ram_listen_thread(void *opaque)
                          __func__, load_res);
             load_res = 0; /* prevent further exit() */
         } else {
-            error_report("%s: loadvm failed: %d", __func__, load_res);
+            error_prepend(&local_err,
+                          "loadvm failed during postcopy: %d: ", load_res);
+            migrate_set_error(migr, local_err);
+            error_report_err(local_err);
             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                            MIGRATION_STATUS_FAILED);
         }
-- 
2.50.1


