Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC01C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 22:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thz66-0005dN-V2; Tue, 11 Feb 2025 17:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz62-0005bf-4C
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz5y-00052l-TP
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739314269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SE2z04Oi2z9AX9NwFPYt/K+wzNu5iFAB6c4IKl++UyY=;
 b=QXIqfUemfTIokNZR/S5KOhzWBNdpinrBw2cLzkbYwgM45qFZVgmJVlcoyRak4aQJ5/DzdL
 NyqltNpVT73ihYr7hNS+uDhLScoaVuJwMB5VIJrrj4WjYMH8tRqb5DBL6lqsudiZmv1sfc
 1yPeWMSfpnvruUzrhoMcR2N7YgJFpNk=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-8b5FgZqWOt6EggRAjm6unA-1; Tue, 11 Feb 2025 17:51:08 -0500
X-MC-Unique: 8b5FgZqWOt6EggRAjm6unA-1
X-Mimecast-MFC-AGG-ID: 8b5FgZqWOt6EggRAjm6unA
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5f6e3f02e27so1604475eaf.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:51:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739314267; x=1739919067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SE2z04Oi2z9AX9NwFPYt/K+wzNu5iFAB6c4IKl++UyY=;
 b=uAWaIzLDIW3HdjDiLRj87vLBaFcSAf86HvIX0mdGNU+iEDOJH6ozBW6MKwCuAZq9DU
 g81vguQJzAi6zdU6muxhFnvJrVg+Wmjej8VZV++sKbanfKCJ9Ow2ttlOxi9ol5qBpLwL
 SCtQ/Mnvqrxzg8eRBsFoW9VSFHZp2tTkzDWUwA7OA83yk4XVpfvoeD5woZpofS/r3TLC
 eKgEwve6roDgSZvwnGBDIAeRoU4N06remws6jM5OvaIzdjpHNojf6IWpB9N+j7I6oNcz
 9ubOFOPnptVzKhYsf44HW2UV1swDgdF4R/I0kc4dNur81mAl79m1L9rGCD9nJjVFyFBQ
 UhNw==
X-Gm-Message-State: AOJu0YwhpZNicUmku+XEiMX+dtwNtmyWxpOjNdem+yKe0kD/ky/+Tewx
 zdpnSkD+Bo5m7KQbFK8Mo+eTMK05ewfSiQ9pfb7+9IXlW/2tZDhJ2nv9FCG+BzADD06pq8rbQXh
 lyYG2t9ZxNObZfOvnijI0DK3E3jwzJfe2h1h+BG75aJMBF4ucPvZCGu6Pom39ukkyzMM6iUeptH
 p9KKsNQ5VbmQFsUAoow+ESBdATsu08NNKEkw==
X-Gm-Gg: ASbGncv69tS6mwi7cy1IByZusnyYXtEt4a1mi0rxWDKGCjmjGWUeNC6TiazmYcl/otg
 4/hS5/PekZJwGvYoMak7wGHcc1uls0HQK4k3ffM51K8Uy2/XOVdIp34Hhmvl+6/xGJba3PNYezn
 FmItzy+xD74dzj2Nco7J9VHpp22dujhO8LSOllw9mdnwr+gMLRmYDcC69cvuveBf0RPZ1fYhzA3
 NXS0FWm/UdOGf/iROR3myndpmfBTAU6m7/kqK/FfK8AofZJIRpBGW0m
X-Received: by 2002:a05:6820:c88:b0:5fc:9f93:4af0 with SMTP id
 006d021491bc7-5fca1452b9emr867449eaf.0.1739314267241; 
 Tue, 11 Feb 2025 14:51:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEb+1Dwwj/tSHWL3b54CbYtgo/vlaibQG224JBS+BkBQ4IRg8Q5VGFoVXeob98looMgi3hbPg==
X-Received: by 2002:a05:6820:c88:b0:5fc:9f93:4af0 with SMTP id
 006d021491bc7-5fca1452b9emr867434eaf.0.1739314266844; 
 Tue, 11 Feb 2025 14:51:06 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fca0992fd0sm482515eaf.34.2025.02.11.14.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:51:05 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 02/14] os: add an ability to lock memory on_fault
Date: Tue, 11 Feb 2025 17:50:46 -0500
Message-ID: <20250211225059.182533-3-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250211225059.182533-1-peterx@redhat.com>
References: <20250211225059.182533-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniil Tatianin <d-tatianin@yandex-team.ru>

This will be used in the following commits to make it possible to only
lock memory on fault instead of right away.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Link: https://lore.kernel.org/r/20250123131944.391886-2-d-tatianin@yandex-team.ru
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/os-posix.h |  2 +-
 include/system/os-win32.h |  3 ++-
 migration/postcopy-ram.c  |  2 +-
 os-posix.c                | 10 ++++++++--
 system/vl.c               |  2 +-
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/system/os-posix.h b/include/system/os-posix.h
index b881ac6c6f..ce5b3bccf8 100644
--- a/include/system/os-posix.h
+++ b/include/system/os-posix.h
@@ -53,7 +53,7 @@ bool os_set_runas(const char *user_id);
 void os_set_chroot(const char *path);
 void os_setup_limits(void);
 void os_setup_post(void);
-int os_mlock(void);
+int os_mlock(bool on_fault);
 
 /**
  * qemu_alloc_stack:
diff --git a/include/system/os-win32.h b/include/system/os-win32.h
index b82a5d3ad9..cd61d69e10 100644
--- a/include/system/os-win32.h
+++ b/include/system/os-win32.h
@@ -123,8 +123,9 @@ static inline bool is_daemonized(void)
     return false;
 }
 
-static inline int os_mlock(void)
+static inline int os_mlock(bool on_fault)
 {
+    (void)on_fault;
     return -ENOSYS;
 }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 6a6da6ba7f..fc4d8a10df 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -652,7 +652,7 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     }
 
     if (enable_mlock) {
-        if (os_mlock() < 0) {
+        if (os_mlock(false) < 0) {
             error_report("mlock: %s", strerror(errno));
             /*
              * It doesn't feel right to fail at this point, we have a valid
diff --git a/os-posix.c b/os-posix.c
index 9cce55ff2f..48afb2990d 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -327,18 +327,24 @@ void os_set_line_buffering(void)
     setvbuf(stdout, NULL, _IOLBF, 0);
 }
 
-int os_mlock(void)
+int os_mlock(bool on_fault)
 {
 #ifdef HAVE_MLOCKALL
     int ret = 0;
+    int flags = MCL_CURRENT | MCL_FUTURE;
 
-    ret = mlockall(MCL_CURRENT | MCL_FUTURE);
+    if (on_fault) {
+        flags |= MCL_ONFAULT;
+    }
+
+    ret = mlockall(flags);
     if (ret < 0) {
         error_report("mlockall: %s", strerror(errno));
     }
 
     return ret;
 #else
+    (void)on_fault;
     return -ENOSYS;
 #endif
 }
diff --git a/system/vl.c b/system/vl.c
index 9c6942c6cf..e94fc7ea35 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -797,7 +797,7 @@ static QemuOptsList qemu_run_with_opts = {
 static void realtime_init(void)
 {
     if (enable_mlock) {
-        if (os_mlock() < 0) {
+        if (os_mlock(false) < 0) {
             error_report("locking memory failed");
             exit(1);
         }
-- 
2.47.0


