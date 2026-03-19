Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCF51091930
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MYI-0001MS-R9; Thu, 19 Mar 2026 19:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYG-0001LJ-Sp
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYE-0001Op-WE
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773961994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i/IRRC3VrN6zBxxQuScl2KCrKe2VxypUJ2dujj/8UDw=;
 b=BuKkQIZqfS/7gWb6Fqx0qIiC2QqmHVYNSMucMIFxXNy0WRYCLcZB7+pmsDBZ2Nu23kxvha
 NoxVN6agAOlG/nQaNg4E8aMLIkVYYcNTb3LjwmxxWU8rtnm2G8lpJyjj3GYhcN46od/Xjg
 ceTVZILsaR93ZH3D//Eov9F0CXbT5z8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-b1geWkosNPWp9Kv8OJdr9A-1; Thu, 19 Mar 2026 19:13:12 -0400
X-MC-Unique: b1geWkosNPWp9Kv8OJdr9A-1
X-Mimecast-MFC-AGG-ID: b1geWkosNPWp9Kv8OJdr9A_1773961992
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b323c43fdso41141131cf.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773961992; x=1774566792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/IRRC3VrN6zBxxQuScl2KCrKe2VxypUJ2dujj/8UDw=;
 b=l4iKYsi5U0IePAfnc3h4Ads/89I9t9RRH6PDI+R9A5OW4EHNqGsZWYSrXCwPVX1P1a
 zETsnWyygNXyNJjJgT41pQLLQcUnotzZ6AF4t3yMnFeMUw9/s1zTXF4qyxxt4vRajY7D
 HoTIjx+YGUsrVp9Wh11nvOxIautR3EMvZaq8sRibtxjzbAsUPFr2wZomL/crLifYxRSr
 TY3eGewMlUAkFo9qBw4qCFaCGPFmcnAZmiBkcmcyBuk9xlxJBPlbZYzLjzxLPJuI4u/I
 m9LCa8WxDWPG9J7Beuqi7HOIjn2wC0nW5z8B/ZLK4ywlZy4bLBkBYQqf+bRExOIxQwJi
 KEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773961992; x=1774566792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i/IRRC3VrN6zBxxQuScl2KCrKe2VxypUJ2dujj/8UDw=;
 b=E6pCpmWx427sWeOoQZrHcd/3ep+1rhPIePncFwbvzBf1MLDdxjr7hr5j8fQN/iXSnU
 S1tYW3eQiSCX5fqcfPZ7ibvyIGUd+4PLFDnXnfFAU5nC25VBH7JO9/XyuGWS1xE8MfEV
 tgCVDeBQLkjtGs4eeaoZuYnG5/s4CNEWq0vaLyFhlTTdFgPzN0eFRe0sHl+C8uwhvSYd
 2hb7bHl1veBITDTIhNJnD32fHnl7zhYse+6l3ENgF5pKCqMLjAnEbetm/pC/0cSKAYYJ
 9UWVYoDqCUHg/tvvcxgzhM2K+/Ui0mCnOc0+T8AOw8hTvja+e66o36X6AKFsDenxOERa
 J0KQ==
X-Gm-Message-State: AOJu0Yy5v2KxagFxFLZ3yvC+zXX3kl8X1AhUxbkFbErwobCahKg51EGa
 u4dP4TfQt0LNY8oFu8SRHAA3nlB9YkgEBP2Yfr82ofSZocotGk1BfU51X3aPsefdBXsLk3VoFeB
 ZRX2XBoMLVKe+qV3JmOcwz5d/iKBXN8iNm24aP7X3KrbU7B9PQyyekdyIFM0gOi/NRGPWIpANOn
 NWto2/wcS0M2FEquVSwRzcoOpWbKXDqRi/UqDqig==
X-Gm-Gg: ATEYQzz05FB60KmJJv8SYoZcqiCB7JL57/UIMnsrXFWj84v3u5lgUplBLQh4m0zkPSi
 nbVxU/6oOOzvZ/cvJzNxwJbIIiWye8z2/7EksMSzajNd1HEJUcjW3NXlOe1iO7kd+iUFG4094UT
 ltWxKSgI86aZyyGuPLKrRANfXBuRr4QTNTU4+PqnP1QghEA3p9gz197485IVIkZoVxyt9a1tAXm
 kgEXpmjlsuuz3oGJHjRCqt90A+q7DUeeNcNdudVqdZBFYOeXjmtM8BI/OnfXn5NCnOafgP1cgwE
 D+TT1C9xlCH6X2b5xjN/oOLkhr4TxhKA+GoOuIibTdtZaguAPEAP14wW+q/JZj1jE2g1srk9sDL
 U4BpgaDfleu8e3w==
X-Received: by 2002:ac8:7c43:0:b0:509:1339:3dbb with SMTP id
 d75a77b69052e-50b3751cd2fmr16096811cf.48.1773961991822; 
 Thu, 19 Mar 2026 16:13:11 -0700 (PDT)
X-Received: by 2002:ac8:7c43:0:b0:509:1339:3dbb with SMTP id
 d75a77b69052e-50b3751cd2fmr16096211cf.48.1773961991092; 
 Thu, 19 Mar 2026 16:13:11 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36e5bee3sm6717161cf.21.2026.03.19.16.13.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:13:10 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 peterx@redhat.com, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Libvirt Mailing List <libvir-list@redhat.com>
Subject: [PATCH RFC 02/12] migration/qapi: Rename MigrationStats to
 MigrationRAMStats
Date: Thu, 19 Mar 2026 19:12:52 -0400
Message-ID: <20260319231302.123135-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260319231302.123135-1-peterx@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This stats is only about RAM, so make it accurate.  This paves way for
statistics for all devices.

Note that even if this is part of qapi/, this should not be part of ABI of
at least query-migrate, because the structure is not changed, and this
stats is always reported only under the "ram" section.

Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Libvirt Mailing List <libvir-list@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/about/removed-features.rst | 2 +-
 qapi/migration.json             | 8 ++++----
 migration/migration-stats.h     | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 6f4447993c..7c4f4325f7 100644
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
index 7134d4ce47..cfc6ccee26 100644
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
@@ -209,7 +209,7 @@
 #     If this field is not returned, no migration process has been
 #     initiated
 #
-# @ram: `MigrationStats` containing detailed migration status, only
+# @ram: `MigrationRAMStats` containing detailed migration status, only
 #     returned if status is 'active' or 'completed'(since 1.2)
 #
 # @xbzrle-cache: `XBZRLECacheStats` containing detailed XBZRLE
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
2.50.1


