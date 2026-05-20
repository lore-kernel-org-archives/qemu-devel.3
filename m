Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8AFCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoYY-00013F-Uz; Wed, 20 May 2026 17:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYX-000136-Qx
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoYW-0007Ch-C7
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jZmhb6PYUi43jWKl53BP4O8oa2TIqANv/QwFF8GvUG4=;
 b=gy92FxL7aUifPmi8RoOc6cOBbjsvQhRkOCDlWkrFO4Gm1fL4d3hCrCIUpXn857hTCZYAXx
 wKcblPLfGtv9Y7+5vJxzPxSazmCbhzzD9qiSon9PlaVumUM9gO9HKaQzYWTotST/as5ivs
 GCk1HoykV6Bf2ZjPxPzBbNsdwVyEna4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-RUuFPPOLMXOmnyUO_tnEjg-1; Wed, 20 May 2026 17:34:18 -0400
X-MC-Unique: RUuFPPOLMXOmnyUO_tnEjg-1
X-Mimecast-MFC-AGG-ID: RUuFPPOLMXOmnyUO_tnEjg_1779312858
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d5d1c2289so160541211cf.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312857; x=1779917657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZmhb6PYUi43jWKl53BP4O8oa2TIqANv/QwFF8GvUG4=;
 b=pULSRWRGkfzB8LXjrK717KuwO/K63AHPSL3DD6h8rOUqFD3UyjEAHrnyQgttvNNXc6
 GEhQYKXu2KcAFlnz5/Sutj5y58I2a4d3ws2/od6MaiufaOx96/kxtyIIlYUeh03lcq5w
 zsprzNfQ//cVSl02vTaMUSkXjB1GDhJMtBsjVINChPLigVh6qq9S8neinkeumHPmCCmn
 0eEYQeRnrNkmRlpM/17njeRQJstC2uaf3BDYRzz9vlGV1WxRfMenMxWn2wYvDfGAhzr/
 h+W04/68VApBEmpJbH+jFSK6wrLQEQPiqSE977QLND2L4PFDYQ28W305XlEZj9TYbpCZ
 kNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312857; x=1779917657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jZmhb6PYUi43jWKl53BP4O8oa2TIqANv/QwFF8GvUG4=;
 b=c1sWLnjgxu5DbwcaMeWkwB06bHfOoj7qTV5XzIpfQRNNJI+zcglfGGneaH/yUDWRFr
 LjSLB1DTE4pH7Hb62UHFhDDW7Mib2w8jNnenwPBKDy3yTKKtPUAJDo1rddnOtmZZHvJf
 qwN8Qrwr1Jmb7cWpgVoZIBhwBIFrW1kqlTm0uMMxMLKQTrFGc4kxeuq0jEip6TfPU4s1
 Dd2pQmqtd97Qt/ipGV0ml4ak2HMCHU40wluVfF9oyfP2YbnrEmncrvWzFyz1e77DotDK
 6bdrAhYdLilTuu/sHXF/ThnYbL9VtXhhSEtwiazbq+EeRMHi4NKW8kmH0S5r66a6BM+4
 OJ4w==
X-Gm-Message-State: AOJu0Yzsj3B0KuDMKcGpiiuyNkoOE2YgPSPGkROer/JLOvRwj2pzziCF
 nbb+Ble4rS7swiHDt55A6Cyu3pbIUPvqX8CIYCcop0yC+Y/Ejb3a0b+F4O7KdAGQ9RLOfTM1VtE
 Wu/O179Jb4Q5ZRHXQZh0TSmFl9qiYCMSt3uNydiX+8HGb1HvYwqwVunHWoisXpSZtC29WB+CEPl
 j8Q0J07Fz1hZdPzKKES0aCCyk5gl/p7mGu5QMbww==
X-Gm-Gg: Acq92OFpNiGqShgiaP6Sy2GrGNvNUaFAWtImd9tbneulK595XeacfyXAzaLEUDBnddI
 uBtq9oQEZclCqJO+DmJvwgJmUAY/o2JvM6num6j+dVN7dblMXcae3JDyv9vY0dlsDuuzzk8pk3Q
 U7JcmMDjvARqenXVZYIjrdUT0wWcMtcG20XTf/UYVmKoxrS+L8lcf+umc+FJTK21u6/ZEu2XT7q
 iPMWng2CJ0aybak6IGDuKXs4JJykgAIopPHxUlobY2kvTPJDFGAzVcA9Z/ssoFm0AtmL5ibmkie
 dTxT4vONJ3oj+RIkgybs1DNnSQ4vYwyNum6Y395ez/1vLVC4aZm2kNGzp9aRsLP2FZdu8Pbi4EH
 YtdT6d4ivuJesZDSc2OeXmYNlRFjHpIkTwNskRVk+3gKR
X-Received: by 2002:a05:622a:2511:b0:50f:ca25:fb48 with SMTP id
 d75a77b69052e-516c5611e72mr2843591cf.55.1779312856697; 
 Wed, 20 May 2026 14:34:16 -0700 (PDT)
X-Received: by 2002:a05:622a:2511:b0:50f:ca25:fb48 with SMTP id
 d75a77b69052e-516c5611e72mr2842771cf.55.1779312855717; 
 Wed, 20 May 2026 14:34:15 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:34:13 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PULL 05/29] migration: Replace current_migration with
 migrate_get_current()
Date: Wed, 20 May 2026 17:33:33 -0400
Message-ID: <20260520213357.40646-6-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Aadeshveer Singh <aadeshveer07@gmail.com>

Replaces the direct accesses to global variable `current_migration`
with `migrate_get_current()` to ensure consistency across systems.

Note: Following this only direct access to `current_migration` will be
* `migrate_get_current()` itself
* `migration_object_init()` initializes `current_migration`
* `migration_shutdown()` to pair up with initialization
* `migration_is_running()`, as there might be a case where this function
  is called by a thread before object initialization

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
Link: https://lore.kernel.org/r/20260513063513.250911-1-aadeshveer07@gmail.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 05f10e4576..074d3f2c69 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1030,7 +1030,7 @@ bool migration_is_running(void)
 
 static bool migration_is_active(void)
 {
-    MigrationState *s = current_migration;
+    MigrationState *s = migrate_get_current();
 
     return (s->state == MIGRATION_STATUS_ACTIVE ||
             s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
@@ -1657,7 +1657,7 @@ bool migration_in_bg_snapshot(void)
 
 bool migration_thread_is_self(void)
 {
-    MigrationState *s = current_migration;
+    MigrationState *s = migrate_get_current();
 
     return qemu_thread_is_self(&s->thread);
 }
@@ -3095,7 +3095,7 @@ static MigThrError postcopy_pause(MigrationState *s)
 
 void migration_file_set_error(int ret, Error *err)
 {
-    MigrationState *s = current_migration;
+    MigrationState *s = migrate_get_current();
 
     WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
         if (s->to_dst_file) {
-- 
2.53.0


