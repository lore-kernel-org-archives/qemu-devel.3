Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87A7D6CFAD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 23:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj3iI-0004we-V8; Thu, 22 Jan 2026 18:03:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vj3iH-0004uc-BI
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 18:03:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vj3iF-0007Ri-Er
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 18:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769123018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLs6t3A6IE+MqhXfWLaJEfim6xwTwv87bwSTLxc8aBI=;
 b=TzJft8FneV4yOgtQ48qZVoWWzl7TlaBtF+UXNkkfXmF8CgUEliKuB/xxE9Flf4TFNXgawx
 CEu+EEeAMQ49kRc2IwWBh3oN0eLsdhO41lhbaYOczSeRASk+oUyljk4oAVHitPN6A1vY1E
 ZiNToAa/wq8QfHAyIbd70CTQ/22EK/g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-nP39GV2cMaWOvLf_Jg4iNg-1; Thu, 22 Jan 2026 18:03:36 -0500
X-MC-Unique: nP39GV2cMaWOvLf_Jg4iNg-1
X-Mimecast-MFC-AGG-ID: nP39GV2cMaWOvLf_Jg4iNg_1769123016
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c5311864d9so433404585a.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 15:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769123015; x=1769727815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kLs6t3A6IE+MqhXfWLaJEfim6xwTwv87bwSTLxc8aBI=;
 b=kwFRdfj6uMeMLdVpunY2QRKLqDJrEBgKqe3LkZ+1fICnMY97vN+ujnMjTiAyjWlM7R
 rZPEGassNEQDtYdLAdgecgbIq3LzeeflxcZi6ukhBBcmEbKit8jPC5J7I4rDs+6m/4Vj
 yVrr/rthKOyo7hHv0ZKelBTYuClnvQFOFOEkuBS2OE2rTI2Ytg9A0vtQCu51wkB6cjjA
 2bJQQXMhmhnJd6BelrC/LSApNZwEGQ1USGQcDk67EOL6DQH2l70ytPUxw7bUrWQPo49q
 WpE//ay3I9BI4823wFowq9rZuS9+rW8mDVw+fs0Z8v0+SGLp3JnbKuXPkm+ClLrqC3rY
 qe2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769123015; x=1769727815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kLs6t3A6IE+MqhXfWLaJEfim6xwTwv87bwSTLxc8aBI=;
 b=lBQbOyvDQmdke+LwPEVXNUGEgGlpwiRfyuZYiTfGB2Ei9CrwW+GTzNxry2dVsKJZEa
 H1feiE1Qi01DviG3vepnFqO1QcUh/HOo5ceqBXZ4NDaIo/YA6fD2lowCX7cw2DpXetHT
 anwWfHvv/rwif7swR2W0Shbncit1KgGN+Z+DU99T5JcyjR6UoI+cEeKeUmaPlX3fH/Fc
 CyaYnUsT8fxl1gNK5nYwyiZZGJ3dY/3uhHwZTqINRz+vKrAna7ySeTo3yPRnDYGG04zI
 YBKt45yaAWVPDQSpwD/CPMo7ekGz4C7Wrk8RKyeXvZw/EF4Aqs3bhE9U+0s3h8W/OK1c
 V/gw==
X-Gm-Message-State: AOJu0Ywkez+JCoGRlUQ/NRC0cS4a3jApfZXh7b5zrUMdX9T/hLS27L/o
 ChD0cHjrTCI+NcPHtwRZP56d23tmWCWensRBAiZX6IrXnacCU8TTyMP5SqTPeMWiM8r/ewoEMcg
 thNN9Mp1ee/Fojay0FfpQiHhujh7THu65dqryq+4nFse6G0Meb7fUd0mMJTrAjBuFegmV5rqWpF
 zi8HVbtIsMc6TR1O3hUx/BGw/657IoM8e4v0OZFA==
X-Gm-Gg: AZuq6aI6+bP4p0wmBHC9Bq7dH2lCS6AQrgwooHnLsDGW+nE5G/O95VSDibsVvqJGh9c
 qHUHEqDoInAF6fp5KalK2TkMnptFQxpgLWbABYM2YbWCOQBR1/7S3Vl2JKQ04xO5hZ5iWI8BWDU
 wgkPsumR69T8upeo7/zdB4QG7++i4tivirpdUFXkxPWmPE7h64SVIkrMrEdqnZocTeOzLghL148
 XFChXRpUrJK/XUmqLDPRJMCHT9uzLWU7RglSTxZkyCbkMJ0FEA1agVlA5ZK97OYDy0SlzKaJyJ0
 p8eAQjnQ10pAYQ5RcvN1TVTGmYj0qLwPp0rEQ6OKKi4qT2s4/memT+IyAc5Y0ud+yEXg6/nz1uh
 a
X-Received: by 2002:a05:620a:298e:b0:8c6:afa8:91de with SMTP id
 af79cd13be357-8c6e2e4b65emr150725685a.77.1769123015555; 
 Thu, 22 Jan 2026 15:03:35 -0800 (PST)
X-Received: by 2002:a05:620a:298e:b0:8c6:afa8:91de with SMTP id
 af79cd13be357-8c6e2e4b65emr150721885a.77.1769123015028; 
 Thu, 22 Jan 2026 15:03:35 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6e37d2a56sm41032785a.20.2026.01.22.15.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 15:03:34 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 1/5] migration: Add a tracepoint for invoking migration
 notifiers
Date: Thu, 22 Jan 2026 18:03:27 -0500
Message-ID: <20260122230331.3543312-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260122230331.3543312-1-peterx@redhat.com>
References: <20260122230331.3543312-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c  | 2 ++
 migration/trace-events | 1 +
 2 files changed, 3 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 1bcde301f7..47d9189aaf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1706,6 +1706,8 @@ int migration_call_notifiers(MigrationState *s, MigrationEventType type,
     GSList *elem, *next;
     int ret;
 
+    trace_migration_call_notifiers(type);
+
     e.type = type;
 
     for (elem = migration_state_notifiers[mode]; elem; elem = next) {
diff --git a/migration/trace-events b/migration/trace-events
index bf11b62b17..f437f0a784 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -198,6 +198,7 @@ process_incoming_migration_co_end(int ret) "ret=%d"
 process_incoming_migration_co_postcopy_end_main(void) ""
 postcopy_preempt_enabled(bool value) "%d"
 migration_precopy_complete(void) ""
+migration_call_notifiers(int type) "type=%d"
 
 # migration-stats
 migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma) "qemu_file %" PRIu64 " multifd %" PRIu64 " RDMA %" PRIu64
-- 
2.50.1


