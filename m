Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 798C0ECE57A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfLT-0002A9-DG; Mon, 09 Sep 2024 10:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfLO-0001tD-Iv
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:26:21 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfLK-0004US-LA
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:26:17 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-277e965305dso2335041fac.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725891973; x=1726496773;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDNjzZDuWCBsPbd7tcy7/yK9DFVnmavsqu74xEof5CQ=;
 b=gfSQZ3VcLIFV+/1XYmrXocIaohet6ol8UWwt3qXGDvRFn42AZJb/eeRNuf+zzyf49N
 lEr8Fyglgp5kF1JgdH2nWgRKHQ9FzIgJr/UI8Tls5V1yu3zt5sbirGeiiU1fgZ9c2xNc
 xD82SMp6kiHS69kV0s07aw3Cs/Z0fsprpEmbnmj1Rsba+dQj/sQE4YH2NRBUjRDSbA+Y
 eK/2HJZB6sfuFuAIxqXsE9J8n8I6Ly+BMxcSS8Wslz57ASxub50N0Rn6rJ6vfyX4zKj/
 GbSQZ9CdtqaFKld4LZCop6psF0wa+XkgOssU/9E6pIDCFPwMOf1OikZNilOq8j2LkEa1
 5qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725891973; x=1726496773;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDNjzZDuWCBsPbd7tcy7/yK9DFVnmavsqu74xEof5CQ=;
 b=S2tKW2pp1XE9/ywR5yYJoCBhfTgncqJ4KqDZyxdPLNYo7o/2/5TXxHwQlUKx/YtBj0
 JOzz+UopuVZZTtWbC2VoN4TLbtsRRfg+5l5wMWU7NLysINbbwnA+Daa0FZYGdnG0q6vZ
 iNhaeEpxgJFHZe0xgeicHXvf4c9ZPNTORrdlLEnbCz3DmihYDdXCMcgj5yub/E9jM7Zv
 GW1jrzmGIKfmdUkhGqmEp6xbNqaUfTbBeOIu8FMBH0btTPfBipElB+VHNhhafTK1yzBD
 N4Y1mhO2wjbz53L0EQw3YxDzHoyCf0PA2sGyPqbbnUzxA5dmvDUXNhcJn4jQ7WmGr52x
 ugng==
X-Gm-Message-State: AOJu0YwjyKkleaB5shfrQf+Dc/1kF3kc9s9wjF3l+P/CDeIF80YxgZJV
 uAFF6U2aDBN3Fx8wy8VI0xx9JPTmrErfihTC/c8Gwvucvjs+PZC49Xj57j7+ReywkE+cFk8HF+Z
 h6RiFoQ==
X-Google-Smtp-Source: AGHT+IHca8Om7eqk8602bCQnCxFF0qmMNz22RXBMDsEwvgw66/xxzlAccL+Fmk+XEvJqdv3GlK+yuA==
X-Received: by 2002:a05:6870:e391:b0:270:1b79:ccbc with SMTP id
 586e51a60fabf-27b82da186dmr8372667fac.5.1725891972415; 
 Mon, 09 Sep 2024 07:26:12 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e58b2a88sm3561164b3a.46.2024.09.09.07.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:26:12 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RESEND RFC 06/10] migration: Support periodic CPU throttle
Date: Mon,  9 Sep 2024 22:25:39 +0800
Message-Id: <c1ac9e22b0f087b2ddb2d3766171459a149b394e.1725891841.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1725891841.git.yong.huang@smartx.com>
References: <cover.1725891841.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When VM is configured with huge memory, the current throttle logic
doesn't look like to scale, because migration_trigger_throttle()
is only called for each iteration, so it won't be invoked for a long
time if one iteration can take a long time.

The periodic sync and throttle aims to fix the above issue by
synchronizing the remote dirty bitmap and triggering the throttle
periodically. This is a trade-off between synchronization overhead
and CPU throttle impact.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/migration.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 055d527ff6..fefd93b683 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1420,6 +1420,9 @@ static void migrate_fd_cleanup(MigrationState *s)
             qemu_thread_join(&s->thread);
             s->migration_thread_running = false;
         }
+        if (migrate_periodic_throttle()) {
+            periodic_throttle_stop();
+        }
         bql_lock();
 
         multifd_send_shutdown();
@@ -3263,6 +3266,9 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 
     if ((!pending_size || pending_size < s->threshold_size) && can_switchover) {
         trace_migration_thread_low_pending(pending_size);
+        if (migrate_periodic_throttle()) {
+            periodic_throttle_stop();
+        }
         migration_completion(s);
         return MIG_ITERATE_BREAK;
     }
@@ -3508,6 +3514,11 @@ static void *migration_thread(void *opaque)
     ret = qemu_savevm_state_setup(s->to_dst_file, &local_err);
     bql_unlock();
 
+    if (migrate_periodic_throttle()) {
+        periodic_throttle_setup(true);
+        periodic_throttle_start();
+    }
+
     qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
                                MIGRATION_STATUS_ACTIVE);
 
-- 
2.39.1


