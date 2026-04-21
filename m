Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EEBF94CA7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHbC-0000yA-Pz; Tue, 21 Apr 2026 16:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHb1-0000ve-Lk
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHaz-0008KU-Ol
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776802881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HK7r5yJsLvsvHCj6ZvcZQApu1fAXI4xH5O+3Iw5fIBI=;
 b=gLCfylLtYiqOlw5C1U0Dtcd+R+srCl0Q0xCX5VNWXl4NHalZ6bx9ZtRl/cNy+WPyoYhC6W
 sOqzpZhBBUts2soEFyWmQ9EqxNg/GC8dWbjBY6+4Q2bmt+HR06xbTPddRTCf7RshjByo/V
 EUWr7aLfGTaEaDM6ZVAekzONIu60nzA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-VcVydcd8PIWiwwOmTPCRoQ-1; Tue, 21 Apr 2026 16:21:19 -0400
X-MC-Unique: VcVydcd8PIWiwwOmTPCRoQ-1
X-Mimecast-MFC-AGG-ID: VcVydcd8PIWiwwOmTPCRoQ_1776802879
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8a275472d89so69875956d6.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776802879; x=1777407679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HK7r5yJsLvsvHCj6ZvcZQApu1fAXI4xH5O+3Iw5fIBI=;
 b=mZ7CvudRDgZAyWn5yo3gJqwJ+1kYCv492T+AgmW6jBmRG5vRmJL4JPQe77MCU5flba
 y9umrPXEsJa373ar9Ul+0KdJvPJnHcAOpDrweneY5TQ/qXpPw8ADfUYBADiXYNzYfp+J
 3sboQpQUg21jwp0zV1ICGu+e2CL3q+jlGYkSjpa0F6SeT0GKZJKabgVXsjZJDvEbwyDV
 J8fWyVQkBLQw1XvIspZobpcekHfwMI7rtOq7qT5h5EaSOxOnOMOqeXTpTFZjEO3/ZREv
 hymvRT4SiuUCbm4eTMnycJHdvciVYRfz8+eFzhxh37tCwoG/QadEV4fPd3po9BJbokMQ
 aUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802879; x=1777407679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HK7r5yJsLvsvHCj6ZvcZQApu1fAXI4xH5O+3Iw5fIBI=;
 b=h3juv0XuX2mpdsnltSAEbZANsWd0TetdXfZGgDttxZmQiN3Raz7zHgHdY56OBCmkNm
 QUqUUbryBfiMDbLVBtBLNa3ldKuEcuNCYPWoigLpn2enDDC81+8/cGzRDp8a0CChZcke
 GBjor4tV55VoNXUFcJbKLil+iGrmmZez4iPJMmhBa5PU6AHive9+kJk03DpVf0+7FObE
 DM8QFU6b575A5CSS09v3jR7sl+iMqgZpPw71ogc/MHd79lI1WrRn/Uyeqdz5IJrOXrBy
 ICp79U6ddoyzQ/NXbyR5mZZFvK21fgl+Ag8UplZxvJE15L4x4iDNGEKrvZRFPEUH1Jm6
 XRZw==
X-Gm-Message-State: AOJu0YyT3i7UZhEHaL+O/T9ToxS6xVLrMt6lwnsG8r+VOuGA146ZFzKx
 BzPKZ1xs0bI91vyGnkiI7mwEjBgcZCpdJhYk2f1clcgAQMv0xo6tWXfl45lVdFLG00LSmU2hgUw
 +E+njD62/QKMht1AqEruMiC7m22hfeWoP8fjhA52C945urXkm7WPyz2FlBCrPhpkgT/WspNPq/L
 7ZrA4xKevb0N7D9KQEXWcZE/JB5IDjWtUu5Dygbg==
X-Gm-Gg: AeBDieu/9qXOFKzz/4q4N2UHcK4Lnk3FdAVgnI0gyBpfxF4N/K4bmNxey/JOWU26Ws1
 BtLXaPnYxDtebUEcjaBg3G5DHM3U693QtXOoS8GrwOEWViY+XzqdVa5+AmrQ6sSrv/cLyqsUhn4
 0umPDjTy/Xf9hnPhh7yOvbtHlWyNkQwLcmDuFuOnINaGR3xkPG9atnmWVCv+FZQ3zvCv9NxAeRW
 GZzcK+FUK2O0EgaDZlfc4BhBQJzoZ9rCjEwkxl3FcdX97AuFpO5bZf26C88qNFl2k1wC1DHOZKZ
 FeBL0NM3HD2H0FELVX9aqruLJtZqHWIO1QyHtwxs5iWNPZ8oyMGMimlgXkuy6DX5LQFHzSyZQVZ
 JInKG+0ncHIsNPJZKXybWdlGoP3jz3+fL0Bay4rgpuvoehyJH0FBVW3wnrQ==
X-Received: by 2002:a05:620a:4589:b0:8cd:827a:2ab3 with SMTP id
 af79cd13be357-8e792758976mr2733896485a.55.1776802878558; 
 Tue, 21 Apr 2026 13:21:18 -0700 (PDT)
X-Received: by 2002:a05:620a:4589:b0:8cd:827a:2ab3 with SMTP id
 af79cd13be357-8e792758976mr2733888685a.55.1776802877831; 
 Tue, 21 Apr 2026 13:21:17 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c26csm114343556d6.31.2026.04.21.13.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:21:17 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Zhiyi Guo <zhguo@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>, devel@lists.libvirt.org,
 Michal Privoznik <mprivozn@redhat.com>
Subject: [PATCH v2 03/16] migration/qapi: Rename MigrationStats to
 MigrationRAMStats
Date: Tue, 21 Apr 2026 16:20:57 -0400
Message-ID: <20260421202110.306051-4-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421202110.306051-1-peterx@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This stats is only about RAM, make it accurate.  This paves way for
statistics for all devices.

Thanks to Markus, who pointed out that docs/devel/qapi-code-gen.rst has a
section "Compatibility considerations" stated:

    Since type names are not visible in the Client JSON Protocol, types
    may be freely renamed.  Even certain refactorings are invisible, such
    as splitting members from one type into a common base type.

Hence this change is not ABI violation according to the document.

While at it, touch up the lines to make it read better, correct the
restriction on migration status being 'active' or 'completed': over time we
grew too many new status that will also report "ram" section.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: devel@lists.libvirt.org
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Michal Privoznik <mprivozn@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/about/removed-features.rst |  2 +-
 qapi/migration.json             | 10 +++++-----
 migration/migration-stats.h     |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index e75db08410..626162022a 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -699,7 +699,7 @@ was superseded by ``sections``.
 ``query-migrate`` return value member ``skipped`` (removed in 9.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
-Member ``skipped`` of the ``MigrationStats`` struct hasn't been used
+Member ``skipped`` of the ``MigrationRAMStats`` struct hasn't been used
 for more than 10 years. Removed with no replacement.
 
 ``migrate`` command option ``inc`` (removed in 9.1)
diff --git a/qapi/migration.json b/qapi/migration.json
index 7134d4ce47..e3ad3f0604 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -12,7 +12,7 @@
 { 'include': 'sockets.json' }
 
 ##
-# @MigrationStats:
+# @MigrationRAMStats:
 #
 # Detailed migration status.
 #
@@ -64,7 +64,7 @@
 #
 # Since: 0.14
 ##
-{ 'struct': 'MigrationStats',
+{ 'struct': 'MigrationRAMStats',
   'data': {'transferred': 'int', 'remaining': 'int', 'total': 'int' ,
            'duplicate': 'int',
            'normal': 'int',
@@ -209,8 +209,8 @@
 #     If this field is not returned, no migration process has been
 #     initiated
 #
-# @ram: `MigrationStats` containing detailed migration status, only
-#     returned if status is 'active' or 'completed'(since 1.2)
+# @ram: Detailed migration RAM statistics, only returned if migration
+#     is in progress or completed (since 1.2)
 #
 # @xbzrle-cache: `XBZRLECacheStats` containing detailed XBZRLE
 #     migration statistics, only returned if XBZRLE feature is on and
@@ -309,7 +309,7 @@
 # Since: 0.14
 ##
 { 'struct': 'MigrationInfo',
-  'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
+  'data': {'*status': 'MigrationStatus', '*ram': 'MigrationRAMStats',
            '*vfio': 'VfioStats',
            '*xbzrle-cache': 'XBZRLECacheStats',
            '*total-time': 'int',
diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index c0f50144c9..1153520f7a 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -27,7 +27,7 @@
 
 /*
  * These are the ram migration statistic counters.  It is loosely
- * based on MigrationStats.
+ * based on MigrationRAMStats.
  */
 typedef struct {
     /*
-- 
2.53.0


