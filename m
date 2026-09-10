Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DB4C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 23:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nnj-0006il-G3; Thu, 10 Sep 2026 19:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWk-0006ak-1e
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:38:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lWQ-0004kc-8l
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789072566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dveBwypMxxlS0tHYi3KN/e1QMBIv6aayFrNW2TY0wNY=;
 b=ijft60zSJC4pExnrT6RDirM/EU/r2HDPTrFcu5g12V13hT8HOcSxFFzuHwHdbmohuEjjTM
 wX9mYZsQzTR/lKdc88e63zerIFX7LeO1FQjr3eZIVXkwgYXUAJ/x7dTeUzNfFj/44QqOkN
 6Wj06raM+0t5KS5I9DxsctCw0GEkIAo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-vrBAOIujM82xawktE87_Ig-1; Thu, 10 Sep 2026 16:12:33 -0400
X-MC-Unique: vrBAOIujM82xawktE87_Ig-1
X-Mimecast-MFC-AGG-ID: vrBAOIujM82xawktE87_Ig_1789071152
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49b7c1dcc82so1273655e9.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071152; x=1789675952; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dveBwypMxxlS0tHYi3KN/e1QMBIv6aayFrNW2TY0wNY=;
 b=SqwI09eFfnW50KEk/oTqrXw5mFYmDB95jE3X1INp2PGCLHt6OoBOk3huNlOxx7RGc7
 jhXBg7W5SFcmgSXcYucliS9hjQP10JRaNjui8Hw27WADW1FX3kPD2QBdUBG1LlvZiWEi
 PUWC2WlOV0A0+Y3ccwSmBDIAI31SP+ugLlWI8FtKIcAt6YaoAWm3b9tsf8xRL3cYd5Gl
 20CQpv9CBUpdxAQNG2sguyXToajQs+7qjFdDHwk8NSPBfa6JSVFKOuDW7jxzFYpREpA7
 iXUIb+3ezgHF2AZBahNI+lOtOvn0IbJzkK0CGOmk+ll+bBmTB+aSwq2DcEECZE8MTP6m
 Sdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071152; x=1789675952;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dveBwypMxxlS0tHYi3KN/e1QMBIv6aayFrNW2TY0wNY=;
 b=grKHyyZyHy7Jup9EBjFz4PGmA9idS+zpEt06LficJGwur4wwFmd+maoIh+4CVIQtsz
 RImAEO4YzbUm5xJ8tq5wEbLkWR4dYE2ZFZNkf5iSQMW2gRzALznytfVDFykdaOQ+ckZz
 AdZWNOBwvqmbWPq0txelAcJMXXy3Ne7kigLlJ9OAPjKzHMzjz5p14VTJ/4dZE2uTetIB
 mUndz5aRXTUrVYNXPUsvb2JSBmWRY/UllCoaBiuWwUsrSNpERlJNL67i/JB/yZJjlj33
 Yldl5rOSya5nRYWHRMXBaJXeFgttBLfzPe6KBWs/D2SA67uN+Nz9w8Yt64M/HxVYsJEC
 71CQ==
X-Gm-Message-State: AFuF++nMORGFJpwa9BCD08Yz4YmS9ow50O2wlqB77qY6dql4+va42kcm
 LwUwbewjEUbyqFHGRo5z5Qxm4h2LVv6gauZVu8I4CBIqemygDBHp3DiTmr7zwf6JopQSU+V3t37
 2s/hJJaGTzhdUdLSTBaXZxKFctCeVnZXJHo+9nz5WjrHyRLcGWOY59Y9DVDIhJRIDALlNK1k9HR
 0oF+2QGYWpGeU1UK2VE1C8GJnaOHBHn7v3wA==
X-Gm-Gg: AYBFou2Kxm9yWX4CefkmakdU1ZE37k5FDwqjh2xV7BcJBVv+CgQ+1DS/zzjLmu0YLeh
 aR4ZvAVrWjO1rqJ/uejGt9XVHHclu/Kzi4p4O3zt7e4eadf3JSWRZ49qrfCf8Pmfp73HwYYyuLl
 GwaEX03CDnThxpwFkkJy575Cr7y0Nej88yqV9d+5ABUGiEa7XZwUlx0xALIiaRWJRASIXDWMSzK
 V9M5w6AddL+T54UiHAYSUDWWXmPQ4QdpcTGNYikA3D/ajaNq7XvPkdqnAjKI54/2GTGVSUzdQOV
 Lgymy0yMX0daOoSWPOY9XVMGXTrCZHdiVs59LogxqBRckTWUKu7CsTEQoWBo4KCggzBoUbvFZet
 Z1GZdpdBNxYM/azvqouFIpd0=
X-Received: by 2002:a05:600c:34c2:b0:49c:fc6e:a3dc with SMTP id
 5b1f17b1804b1-49e619d87ecmr7677795e9.27.1789071151695; 
 Thu, 10 Sep 2026 13:12:31 -0700 (PDT)
X-Received: by 2002:a05:600c:34c2:b0:49c:fc6e:a3dc with SMTP id
 5b1f17b1804b1-49e619d87ecmr7677485e9.27.1789071151238; 
 Thu, 10 Sep 2026 13:12:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60aba026sm19917895e9.3.2026.09.10.13.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:12:30 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:12:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>
Subject: [PULL 27/90] qapi: add local migration parameter
Message-ID: <ca3c9253b00fb8ac3cf14a2bdce4dfb2d5d30073.1789071042.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We are going to implement local-migration feature: some devices will be
able to transfer open file descriptors through migration stream (which
must UNIX domain socket for that purpose).  This allows to transfer the
whole backend state without reconnecting and restarting the backend
service. For example, virtio-net will migrate its attached TAP netdev,
together with its connected file descriptors.

In this commit we introduce a migration parameter, which enables
the feature for devices that support it (none at the moment).

We can't simply auto-detect local migration by checking whether the
migration channel is a UNIX domain socket: the UNIX socket may be only
the first part of the transfer channel to a remote target.  Hence an
explicit parameter is needed. Moreover, "local" migration parameter
may be useful in cpr-exec mode, when FDs are passed through exec
instead of UNIX socket.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-10-vsementsov@yandex-team.ru>
---
 qapi/migration.json      | 21 +++++++++++++++++----
 include/migration/misc.h |  2 ++
 migration/options.c      | 18 +++++++++++++++++-
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index b1eaf7b054..f7628b55e9 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -830,7 +830,8 @@
            'zero-page-detection',
            'direct-io',
            { 'name': 'x-rdma-chunk-size', 'features': [ 'unstable' ] },
-           'cpr-exec-command'] }
+           'cpr-exec-command',
+           'local'] }
 
 ##
 # @migrate-set-parameters:
@@ -1012,10 +1013,20 @@
 #     Must be set to the same value on both source and destination
 #     before migration starts.  (Since 11.1)
 #
+# @local: Permit the use of optimizations for local migration.  This
+#     must only be set when either both the source and destination
+#     QEMU processes are directly connected with a UNIX domain socket
+#     as the migration channel (to enable use of file descriptor
+#     passing) or cpr-exec migration mode is enabled (this way file
+#     descriptors are inherited by new process).  Individual device
+#     backends may need additional configuration flags set to enable
+#     local migration optimizations.  This will be documented against
+#     the device backends where it applies.  (Since 11.2)
+#
 # Features:
 #
-# @unstable: Members @x-checkpoint-delay, @x-rdma-chunk-size, and
-#     @x-vcpu-dirty-limit-period are experimental.
+# @unstable: Members @local, @x-checkpoint-delay, @x-rdma-chunk-size,
+#     and @x-vcpu-dirty-limit-period are experimental.
 #
 # Since: 2.4
 ##
@@ -1053,7 +1064,9 @@
             '*direct-io': 'bool',
             '*x-rdma-chunk-size': { 'type': 'uint64',
                                     'features': [ 'unstable' ] },
-            '*cpr-exec-command': [ 'str' ]} }
+            '*cpr-exec-command': [ 'str' ],
+            '*local': { 'type': 'bool',
+                        'features': [ 'unstable' ] } } }
 
 ##
 # @query-migrate-parameters:
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 2b2fbb59a4..019717f4cd 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -161,4 +161,6 @@ bool multifd_join_device_state_save_threads(void);
 
 void migration_request_switchover_ack_legacy(const char *requester);
 
+bool migrate_local(void);
+
 #endif
diff --git a/migration/options.c b/migration/options.c
index d2575edb6c..05b026f4bf 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qemu/units.h"
+#include "qapi/util.h"
 #include "exec/target_page.h"
 #include "qapi/clone-visitor.h"
 #include "qapi/error.h"
@@ -25,6 +26,7 @@
 #include "migration/colo.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
+#include "migration/options.h"
 #include "migration.h"
 #include "migration-stats.h"
 #include "qemu-file.h"
@@ -350,6 +352,12 @@ bool migrate_mapped_ram(void)
     return s->capabilities[MIGRATION_CAPABILITY_MAPPED_RAM];
 }
 
+bool migrate_local(void)
+{
+    MigrationState *s = migrate_get_current();
+    return s->parameters.local;
+}
+
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
@@ -1101,7 +1109,7 @@ static void migrate_mark_all_params_present(MigrationParameters *p)
         &p->has_announce_step, &p->has_block_bitmap_mapping,
         &p->has_x_vcpu_dirty_limit_period, &p->has_vcpu_dirty_limit,
         &p->has_mode, &p->has_zero_page_detection, &p->has_direct_io,
-        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command,
+        &p->has_x_rdma_chunk_size, &p->has_cpr_exec_command, &p->has_local,
     };
 
     len = ARRAY_SIZE(has_fields);
@@ -1449,6 +1457,10 @@ static void migrate_params_test_apply(MigrationParameters *params,
         qapi_free_strList(dest->cpr_exec_command);
         dest->cpr_exec_command = QAPI_CLONE(strList, params->cpr_exec_command);
     }
+
+    if (params->has_local) {
+        dest->local = params->local;
+    }
 }
 
 static void migrate_params_apply(MigrationParameters *params)
@@ -1581,6 +1593,10 @@ static void migrate_params_apply(MigrationParameters *params)
         s->parameters.cpr_exec_command =
             QAPI_CLONE(strList, params->cpr_exec_command);
     }
+
+    if (params->has_local) {
+        s->parameters.local = params->local;
+    }
 }
 
 void qmp_migrate_set_parameters(MigrationParameters *params, Error **errp)
-- 
MST


