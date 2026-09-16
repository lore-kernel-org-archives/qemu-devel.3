Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC3DC982D0
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 21:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6xJF-0000l6-A1; Wed, 16 Sep 2026 17:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6xIm-0000ij-6w
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 17:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6xIk-0007bC-Md
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 17:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789594582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ttb6FMU9RwrGZr7fYtOzbH5PPqnU2pzD/Mi+DK9ZenI=;
 b=RQcyTfRZn5BwtIJ7IKl6hlumCyA6ySN3g1CsEYzg0JjNh57yiRB/9wtmVuYBEaLVBiUDQJ
 bAY2Ovk4wYN1rrsAc2nNWSZvyhsRXwDckwMS9swSg9Zt08AW0vt4F2/MIu00Prqc1J0Mlw
 vxNtb4C+GWWwJVXnaEr0bPQyDt/hG88=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-oGXtUYw0Mda29jV-gj_VVw-1; Wed, 16 Sep 2026 17:36:20 -0400
X-MC-Unique: oGXtUYw0Mda29jV-gj_VVw-1
X-Mimecast-MFC-AGG-ID: oGXtUYw0Mda29jV-gj_VVw_1789594580
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-912054a1c29so2513706d6.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 14:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789594580; x=1790199380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ttb6FMU9RwrGZr7fYtOzbH5PPqnU2pzD/Mi+DK9ZenI=;
 b=YCaO6FpQXTbvouAo7bxMtCRlJ+jN6akNRk73g6ZOeQlIjeE4kMUJhoZVwjYWHzflgT
 ev9NPiEirU6sUOELiHb3Nux77Ba8XlzT4TsNalhV/eP883DeIIL1JPIpWCJrA2YVbyFX
 93qhSGPF5sQG9I6xzQUrxL0SSJ0/J2urRJ+ZT/zqliNRnEy8O+AVEyM2YTs56AwAZgs8
 4umtgqaXca97X3BPMatlA/KS3kHtFJ55UEjlMoRYEhy3r3q75t1R8EIgnebgybgJCYUp
 gNmDsV/hlOOTJ4m07UuqlO8gljby+OAS19L/0Xsgtp+Km4RwRo2utAHWbRMVUpi5tIDG
 iTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789594580; x=1790199380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ttb6FMU9RwrGZr7fYtOzbH5PPqnU2pzD/Mi+DK9ZenI=;
 b=jspfI9UXSLRDKJbSgEWnR2+iRZZC7IVjB765zDY4PPS7G/wsBRGGYPweIV6HEkLoWy
 abA9s1MQMVsGIuty0Ms2frYTYqf342ahCK7VqmQBNaiKsGGz7uV3s3I2BKgQS0JW3Ix9
 ZVz9B9h56Mpm+pOJDND+6LubKv+jmTlhd3mgKqay1bHucTzBr03IC0Pr5o3kNQ7rtJp+
 SByi0vptpnV2ksAbB3NC/mYbPqOv+Ep/3udaGWuzke0wv5WVgWyBOBvuYaW/X+ZBOZdq
 OinWshv80smaoGWbeT16eJkint6gmlwcq5p/aCo5ygi5UQYi8/Y9ROVjDxgK0m1uvEEM
 b+Kw==
X-Gm-Message-State: AFuF++lm3vbcyqnvJMINbJkX0ah8C7RuM9f6OxEJ8A2R64UJ+IVVFaQ8
 IjlEMFE2FFbF1kmBDNtkhxem2CLys8511N1kxGF3xz5mCTTZL8h7bpqVja4zXKLKapwKTrdpPOy
 uX6xzjn4h7ieLuGqOpeGyJX/s9eTqI1qxWgrVwVIOU6TrcT3dVwByDQFrySvtJwEQWbiYpWgZ50
 NSI9Kkwdr3JdCGySDO/zL7WZxQmBctgFPUCql0fYrm
X-Gm-Gg: AYBFou1lyfvlEtqh8IDosRWxf2DVNwckvffP2zUAefjVe1fnvjpKGF755v8IfBNsshK
 lYx5bdKm0KzJP8UPzLKRcbqsBw5K0B2WysP8fe+8Q2u3pfEBjtH3rfgA3EFjrTGxKboWp9vgAx9
 vwMFHipCt8vccR7bTbmOlVWGUD2tzkGym0qzFXnHlOTcyVWcTv65YcQsEJe9Ca9wGEH8AHGQGsm
 cuzuDOuQFfvr1JQA1XWRAGyz9e7JA6YrHNpSV+ma+VfZltzJqm50kBpfrXn3y4K7xdvKzfmqBcV
 L7YQQTIMSqNwXJluw/BPo1mmrgUEY68bOJb2KySDTjrm5HoQGB4fSQaVvlpnDdFLLJPozTK7msW
 l1hJz1NsHTYFdjaYaHEZ5XLjVvJtF51dM9+UkJFiOgoHRgRkW1Dduo0FzpqU=
X-Received: by 2002:a05:6214:2506:b0:912:3b8b:3275 with SMTP id
 6a1803df08f44-9123d7916fbmr83636046d6.19.1789594580093; 
 Wed, 16 Sep 2026 14:36:20 -0700 (PDT)
X-Received: by 2002:a05:6214:2506:b0:912:3b8b:3275 with SMTP id
 6a1803df08f44-9123d7916fbmr83635316d6.19.1789594579432; 
 Wed, 16 Sep 2026 14:36:19 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9123be63bdfsm35193276d6.17.2026.09.16.14.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 14:36:18 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 5/7] migration: Dump type of channel in set_incoming_channel
 tracepoint
Date: Wed, 16 Sep 2026 17:35:56 -0400
Message-ID: <20260916213558.587304-6-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916213558.587304-1-peterx@redhat.com>
References: <20260916213558.587304-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Add this info to be crystal clear on what channel we're installing.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/channel.h    |  3 ++-
 migration/channel.c    | 10 +++++++++-
 migration/trace-events |  2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/migration/channel.h b/migration/channel.h
index a7d0d29058..678712f291 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -24,7 +24,8 @@ typedef enum {
     CH_NONE,
     CH_MAIN,
     CH_MULTIFD,
-    CH_POSTCOPY
+    CH_POSTCOPY,
+    CH_NUM,
 } MigChannelType;
 
 void migration_channel_process_incoming(QIOChannel *ioc);
diff --git a/migration/channel.c b/migration/channel.c
index 8407ea46cb..b9065efd03 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -34,6 +34,13 @@
 #include "trace.h"
 #include "yank_functions.h"
 
+static const char *const mig_channel_str[CH_NUM] = {
+    [CH_NONE] = "NONE",
+    [CH_MAIN] = "MAIN",
+    [CH_MULTIFD] = "MULTIFD",
+    [CH_POSTCOPY] = "PREEMPT",
+};
+
 void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
                                 Error **errp)
 {
@@ -219,7 +226,8 @@ static bool migration_incoming_channel_install(MigrationIncomingState *mis,
     }
 
     trace_migration_set_incoming_channel(ioc,
-                                         object_get_typename(OBJECT(ioc)));
+                                         object_get_typename(OBJECT(ioc)),
+                                         mig_channel_str[ch]);
     migration_ioc_register_yank(ioc);
 
     if (migration_incoming_setup(ioc, ch, errp)) {
diff --git a/migration/trace-events b/migration/trace-events
index c5fa88fe8f..9ef42f54d1 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -208,7 +208,7 @@ migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma)
 
 # channel.c
 migration_channel_process_incoming(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
-migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
+migration_set_incoming_channel(void *ioc, const char *ioctype, const char *type) "ioc=%p ioctype=%s type=%s"
 migration_set_outgoing_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
 
 # global_state.c
-- 
2.55.0


