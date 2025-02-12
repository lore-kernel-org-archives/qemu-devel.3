Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F482C021A5
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGh7-0003BL-Uf; Wed, 12 Feb 2025 12:38:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiGh4-0003Aq-FO
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:38:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tiGh2-0005W1-K6
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739381915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jTIE1Iu45HYq5bqfd9NOaWNF+pRKE4Zg83arP4UdPQg=;
 b=ZtP4aB54aR4HPoVCCiNt9VV7g9lkG2dmrWun+CEbRb+39xighcEXoM1QE9kSZz91gETAnp
 smrvr64BTYNo5GJrWr3HxGNWDd7OlB2zMhWzlos6gqMLksesmg45Gp25hD8wGcpYtznGkt
 qtwY9NpEIjRrfLonPzdCFo4MSDudYzU=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-e7GD5stnM7aj307tDTc_Zg-1; Wed, 12 Feb 2025 12:38:32 -0500
X-MC-Unique: e7GD5stnM7aj307tDTc_Zg-1
X-Mimecast-MFC-AGG-ID: e7GD5stnM7aj307tDTc_Zg
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-726f2f788e0so760843a34.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 09:38:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739381911; x=1739986711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jTIE1Iu45HYq5bqfd9NOaWNF+pRKE4Zg83arP4UdPQg=;
 b=ba/AH348XBFdC+GfIebzvHE73LcRQBt8mad0PK29FKOVEapX1zVWngpV/qWzWPSbJK
 Um0JsKRcr6RKF9QEfRHflTjn/SPeuU2on4dPiYJdQRD6GO8jjHqNiNTTp79wKXmdNDE3
 40L30ACuMUXF/TOcSfjtfuclnrc8iDKF3joJl4NZdVPc4IIys6UKqWpZTRHyOmw+Eqxb
 NabGaMv4qO+LkG33o6FJ+mpDPmtQT6IXMzcFWyVDEkZO840mATzgTk/c7N/4+aD5nddr
 AXXybgLYE+HslZpXV1zPp/m/XdvHaGmxbJ80/h+BmabJ/Ai/4dtai8j6Xqpcb85jLGh9
 zecA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvo/uCOLucblpNzz4JPuvV5xGrpEZP/7rswmOyZh8RmCPbMOuDBhse3zXa/aC+iMwtK53QaIoawIVE@nongnu.org
X-Gm-Message-State: AOJu0YypsoFcB/iSbOLWm/e+xiZB/XUAGz/tkXCojR19wBPIM1FR/+gQ
 7DKjEr8bHWF26Mg9NFlQJtO4whlmsTUN0qbO9VAy/OZgqNgZ3Xqo7MFyEjRw9NQs64A+pMfG3uP
 6Ks7V0b2hNxytpeR9A1IUt+zxiSoGUf18YoOqj+0Y5a8n0bUp5EnM713OGVAZ
X-Gm-Gg: ASbGncu9Q1cQNPHx2pxkXUfMvZKVBJPP3xUlcE/o3dRxdiPQSnUzy/gljhN1ja1/tVv
 koTEVfUGFDvdAvmuMdFmYWcB77WCO6tqiGLyRba6qoxSC/c0PrUYlRObtLZfVCyuVNV1s/OH57T
 K6xvmBrgeA4zrDC7r+QaC0+eCQVD1sGx1/BSRhx+HlFXuY4IBz0nuTGOuEUM53uRE9D8cK4m0gp
 jZW1H1U4GpyQFIRuJziwGYjoh5zxy/jFDAkTp1hLNFPU6E8zScVlW2l
X-Received: by 2002:a05:6830:7199:b0:726:f0d7:d5f4 with SMTP id
 46e09a7af769-726f1c3739fmr2707307a34.4.1739381910767; 
 Wed, 12 Feb 2025 09:38:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNuyPtGlRqGsZ+9tq1GGJKLJM0CrE+MdyLDoVoSDBauI7L7PPaKU9VsvJm1iHRifAZdnVW+g==
X-Received: by 2002:a05:6830:7199:b0:726:f0d7:d5f4 with SMTP id
 46e09a7af769-726f1c3739fmr2707292a34.4.1739381910508; 
 Wed, 12 Feb 2025 09:38:30 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fc544b08d4sm4457194eaf.2.2025.02.12.09.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 09:38:29 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL v2 11/14] os: add an ability to lock memory on_fault
Date: Wed, 12 Feb 2025 12:38:23 -0500
Message-ID: <20250212173823.214429-3-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250212173823.214429-1-peterx@redhat.com>
References: <20250212173823.214429-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Link: https://lore.kernel.org/r/20250212143920.1269754-2-d-tatianin@yandex-team.ru
[peterx: fail os_mlock(on_fault=1) when not supported]
[peterx: use G_GNUC_UNUSED instead of "(void)on_fault", per Dan]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 meson.build               |  6 ++++++
 include/system/os-posix.h |  2 +-
 include/system/os-win32.h |  2 +-
 migration/postcopy-ram.c  |  2 +-
 os-posix.c                | 15 +++++++++++++--
 system/vl.c               |  2 +-
 6 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/meson.build b/meson.build
index 18cf9e2913..59953cbe6b 100644
--- a/meson.build
+++ b/meson.build
@@ -2885,6 +2885,12 @@ config_host_data.set('HAVE_MLOCKALL', cc.links(gnu_source_prefix + '''
     return mlockall(MCL_FUTURE);
   }'''))
 
+config_host_data.set('HAVE_MLOCK_ONFAULT', cc.links(gnu_source_prefix + '''
+  #include <sys/mman.h>
+  int main(void) {
+      return mlockall(MCL_FUTURE | MCL_ONFAULT);
+  }'''))
+
 have_l2tpv3 = false
 if get_option('l2tpv3').allowed() and have_system
   have_l2tpv3 = cc.has_type('struct mmsghdr',
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
index b82a5d3ad9..bc623061d8 100644
--- a/include/system/os-win32.h
+++ b/include/system/os-win32.h
@@ -123,7 +123,7 @@ static inline bool is_daemonized(void)
     return false;
 }
 
-static inline int os_mlock(void)
+static inline int os_mlock(bool on_fault G_GNUC_UNUSED)
 {
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
index 9cce55ff2f..52925c23d3 100644
--- a/os-posix.c
+++ b/os-posix.c
@@ -327,18 +327,29 @@ void os_set_line_buffering(void)
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
+#ifdef HAVE_MLOCK_ONFAULT
+        flags |= MCL_ONFAULT;
+#else
+        error_report("mlockall: on_fault not supported");
+        return -EINVAL;
+#endif
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


