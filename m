Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DDCD0EE25
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 20:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNzxB-0007kI-TX; Tue, 25 Nov 2025 15:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNzwF-0007CI-LF
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:47:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vNzwA-00030b-Bp
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 15:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764103617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TNOplzLLskodi+3D4AbE6U1qQ02Gi/Ef8JIPS+itajU=;
 b=KwY3tySa00ORA17G+OjCjzf83OqQTPwJXpqGkwaOKw16/hN/C2cxaS8L9nX76nrW9bUg82
 D/VInVEgCSLrmaYwvmmYWxW08Tvky6+WfQSy0DdyDnpbvvJK5Fmb0f5synPsX92kZds+S6
 chO3X8bUr+mJ75eNQ6S+Po0THpEzbq0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-BgVtlVlDMhCn6FADG_OfeQ-1; Tue, 25 Nov 2025 15:46:56 -0500
X-MC-Unique: BgVtlVlDMhCn6FADG_OfeQ-1
X-Mimecast-MFC-AGG-ID: BgVtlVlDMhCn6FADG_OfeQ_1764103615
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b17194d321so764969585a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 12:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764103615; x=1764708415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TNOplzLLskodi+3D4AbE6U1qQ02Gi/Ef8JIPS+itajU=;
 b=bMTXnQe1PJZ3vQp9umjAByOjZAHu5MXumqTuOeeBKv2B6pR3Ie05MGG8misiOi+wvE
 n+cg2H/AQHsRDgorjjvbxsmQV9xfpCNv/7HXaN8tx48rmXLBsoOc1ywtUBjhjTxHenIy
 PnqjAWmyGfzkBvCMrHL5g/cncUdvnW/UkZYH7mgrdypx5ilpG7Nd7zz0kVWMbBXYQZt7
 Iax1nGyaMzd4Pp1MZQjBUwD5rcw/5K3X/qG71cIA+x1DAfQUoTxwEOHiegO8Deu1/Gat
 dB8xeOWl/rDE5eGtTgboiH0PSn3tYqZ4jdnJDyWIzYwKNuvNYzwEXzonJ56ZzPBfdGqL
 dD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764103615; x=1764708415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TNOplzLLskodi+3D4AbE6U1qQ02Gi/Ef8JIPS+itajU=;
 b=Dvk+W3hbQVNpWSc6+zZ+Zk61/t+Nu56ebe3aHOqDydT5FdcA0vr3MzW8e7rYGbUOIc
 LGzE5kQLNUhULvvx1v5gd0EDVfg7CP+U8FiUjobAZzIvxE76htyw7whBVc0XXTZ9srTj
 F7gBX0i7PuIEhk+nAzsMsfFV7U3WT1790LmmWGmut38Lp+CBEb+gEcCAyqLMig/6DSNt
 2oSsy4kdTmZ33OO2BU9J/Tlw/bNDo34+bYoBJqm0y7yt/OE+8IGdPTzUP6CVasyHTcCV
 8AlR68M+VqrZcejJ0uuaYFw2IiNtWtEfGigAXZkpBWcJngPewnvLE7kjteVkFIY0GDSc
 vqcQ==
X-Gm-Message-State: AOJu0Yx+6h20+O5Zj4ZfQG8Fq/rWqEPI9YweZfrYVb5a7YWcvywOubOU
 5TgjAxjIhlW1bEu4ry3+ms79SFL7aQA7Eo/R8Q1KJHlEphxV4UvbLnmKLnbTDllMScYUQx2OxYn
 k0kGHj1o5l4d3VwiD6FOz1Omk28Z6L761jLBU4AhhxM6BsSmK9GoglmO7wRkkl2YfbTCj+//bjt
 ZpXKDENXYZs+E6XFBPt00kc34HnNYYnvelUbDlhg==
X-Gm-Gg: ASbGncvp6A7+9NjjjP1B/k2vZHcvD3f/M6QR+/HwKurTWwF+WDJYDVBYa+QS9kk0Mos
 AzBLOwGbQxeVRn46g1zDvBc/pMPEdFdE7OZLrD+u0aJe7Lo6RvuzoRADes7+gzLkhEEZIGkeU9V
 k2P/hMkxYG1SfGOYFpzRc5+v7sz9Q52bK591kbsMbUYbBnsMswrSPhuVqo0L0Ed70nraM3uWlnV
 WlgkvVpdYoUMb+KTuafk1iQPrMOYLrGBhwspCQWqHBCgVCvkw4o55ZOxc4wdhhHsUloAXLDy17D
 ViBoS0dy2mGNH/Y4k5ctmTgn+c23Dm6ApV0AAqvhzNniaKaodseiO5iE311coYPDSFir0aNuOLm
 nxbI=
X-Received: by 2002:a05:620a:1aaa:b0:8b2:de6a:e3 with SMTP id
 af79cd13be357-8b4ebdbd2c4mr539071685a.81.1764103615022; 
 Tue, 25 Nov 2025 12:46:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpg/hgzFrdvezmUoURAguTbZcH6DcyUkmldXa3Iq/0mu2EbofoizhaPSbcwV+yH8YXo2Gy+A==
X-Received: by 2002:a05:620a:1aaa:b0:8b2:de6a:e3 with SMTP id
 af79cd13be357-8b4ebdbd2c4mr539067085a.81.1764103614396; 
 Tue, 25 Nov 2025 12:46:54 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b3295c2276sm1250794085a.30.2025.11.25.12.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 12:46:53 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH for-11.0 3/6] migration: Make migration_connect_set_error()
 own the error
Date: Tue, 25 Nov 2025 15:46:45 -0500
Message-ID: <20251125204648.857018-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251125204648.857018-1-peterx@redhat.com>
References: <20251125204648.857018-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Make migration_connect_set_error() take ownership of the error always.
Paving way for making migrate_set_error() to take ownership.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/channel.c   | 1 -
 migration/migration.c | 7 ++++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 462cc183e1..92435fa7f7 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -95,7 +95,6 @@ void migration_channel_connect(MigrationState *s,
         }
     }
     migration_connect(s, error);
-    error_free(error);
 }
 
 
diff --git a/migration/migration.c b/migration/migration.c
index b316ee01ab..4fe69cc2ef 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1575,7 +1575,7 @@ static void migrate_error_free(MigrationState *s)
     }
 }
 
-static void migration_connect_set_error(MigrationState *s, const Error *error)
+static void migration_connect_set_error(MigrationState *s, Error *error)
 {
     MigrationStatus current = s->state;
     MigrationStatus next;
@@ -1602,6 +1602,7 @@ static void migration_connect_set_error(MigrationState *s, const Error *error)
 
     migrate_set_state(&s->state, current, next);
     migrate_set_error(s, error);
+    error_free(error);
 }
 
 void migration_cancel(void)
@@ -2292,7 +2293,7 @@ void qmp_migrate(const char *uri, bool has_channels,
 
 out:
     if (local_err) {
-        migration_connect_set_error(s, local_err);
+        migration_connect_set_error(s, error_copy(local_err));
         error_propagate(errp, local_err);
     }
 }
@@ -2337,7 +2338,7 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
         if (!resume_requested) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         }
-        migration_connect_set_error(s, local_err);
+        migration_connect_set_error(s, error_copy(local_err));
         error_propagate(errp, local_err);
         return;
     }
-- 
2.50.1


