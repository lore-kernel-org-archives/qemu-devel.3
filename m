Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5838BCD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMM7-0004QE-Lg; Tue, 05 May 2026 16:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMM3-0004Nm-4o
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:26:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMM1-0002ak-7J
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CmjHBJ8XbN1QfelMZFqFN+lYGBuxnVmoSMYFNc5rg38=;
 b=gDRB13V2MOs1Z1tqyDfFttU38GGHLGH7euRxNZEHRELkE1OZHCZr4jnaRIEJC7b3aAHmbY
 NsyuWRIkqor4eRjBbsVTtKuPCCWUrlz9l79ZxC8ALZhmObjiN0oubdhc7CBwmL3VdhYbjK
 ztxTEb5A3/sE15RBjZszrvIC0Kz2dRs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-HqivzLA_Pcy_nt-7xQ6muw-1; Tue, 05 May 2026 16:26:51 -0400
X-MC-Unique: HqivzLA_Pcy_nt-7xQ6muw-1
X-Mimecast-MFC-AGG-ID: HqivzLA_Pcy_nt-7xQ6muw_1778012811
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8acaea1ffe7so142713396d6.2
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012811; x=1778617611; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmjHBJ8XbN1QfelMZFqFN+lYGBuxnVmoSMYFNc5rg38=;
 b=k+jlNbvUx4UyBHFw0aeUBdgp0tLuaF2eFdDJJ3fh8jt+sM+715Rcs2ZkpBz6zUCGrj
 xMALEKskjcw4yhlCDib/kIZKS+IJ3FH0DtQYLLWVGvUErFE28d9RJkB5HbFfSHFyKgKC
 87R4xPnsZ0zA1oQ58T7iqLFV3ubdO4XTadnk1vBvoXIR9zeD3N1RhYbEIFxmq2CutQVk
 t6017VcWZknUh2mi0ah/C2sxCSLTFwPrGxEI/CdkQCEJgTzG2uVeRWeNxxtUQCm7Vwxj
 geF6BV50x0S4qHb1ZWiXg4rYSnSd6oCmlPN/WTUqtJBO/ICzRhETuadGJYtVJaQcjAyj
 2rOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012811; x=1778617611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CmjHBJ8XbN1QfelMZFqFN+lYGBuxnVmoSMYFNc5rg38=;
 b=Penf8UThmY7DXW8cbBajXiP0CllY+7FLmaCicMe+64Q1SGv0cM3TdyfAIVzpfGkKHM
 paeNmoywK269I/Gtol5RPtQbTwGD9oNn/84yMzuAw37u4ttheF2HO7tu6TO6FDV1BljB
 /4PZ5xYNVQjExh3V4BRHKKPoqvQ0BuvDFSeUVeg9RFqfApzdho9Aj39hAQicocpbXaRb
 dqiW+px3EwYCn+g8ivWGUEsqRNIqKKi54tvjLKWOjT1eWsGoEmoNUuYn+G6vhQqlh5LK
 ocEDFC4gO0nx76l1uVkNlz3mbpQ7AD4l0hqczIUoDouOn0RFaFYQyZu34K6HKeZKvC8l
 EGDg==
X-Gm-Message-State: AOJu0YwDMlUzd/gjjOQsPiW9d5z0KWaV1BvCL0yFmVpaEqlEAb7RQYQn
 Oi02FOzzzUSF3Ynzo2SWVrzKxbWApNPC7HP5lHFveS8CqzxRmDcWvVXQOIBAukbSpF190XRldcr
 ug3AQVL1CBnSOv2/3GQOtHeiqPtSp5W7baA8jCan5Oyu1JfqKpN6ruW2Zqnj/v4IiPU3tdHfayL
 UlFedCxQ/D7tI4EGf6Ayr9NcuNKern6okBpOuN1Q==
X-Gm-Gg: AeBDieuO4ARDlsyYkemkGFxiLRnQtdX4KS3elHBXMZylXYzlEmGOfAzXeToqjl3jEBo
 tNNkuw8M7Z1/FVPlwoTzLATcfNUwP9kif3mZxSTE3OyvQMOD83xHQozWgawT3bNyhMcDYRfGcOx
 xXg6njCCmGAikhAPdgp5tVsYLY7n3pH9zYIm3ie80rb0TXYa89VmAGoyvXSqbdPODSlYCsn4i0g
 NlyRZQO9blbPmo/gZqB5W/2QEw5drHOtg1C+uSBWWlwW/gwfqNt/r/B8GLrAOw5d+f89IEHR/9I
 J2P8o/BMSYNz+sryb4CkcMKecl9XPl8HnLgTHBNmUIkIObBJivWc7TKIV4p7xKmGc5/AuHpS1JU
 z0Lja7LUo1RgRxp3TOA4v59Fw3RBwoWndLYMvKG9kRhEVVffcEf6tyzg=
X-Received: by 2002:ad4:5de4:0:b0:8b8:726a:74d4 with SMTP id
 6a1803df08f44-8bc42b6c5d7mr4961986d6.16.1778012810535; 
 Tue, 05 May 2026 13:26:50 -0700 (PDT)
X-Received: by 2002:ad4:5de4:0:b0:8b8:726a:74d4 with SMTP id
 6a1803df08f44-8bc42b6c5d7mr4961096d6.16.1778012809818; 
 Tue, 05 May 2026 13:26:49 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:26:49 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, Michal Privoznik <mprivozn@redhat.com>
Subject: [PULL 05/23] migration/qapi: Rename MigrationStats to
 MigrationRAMStats
Date: Tue,  5 May 2026 16:26:22 -0400
Message-ID: <20260505202640.1011006-6-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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
Link: https://lore.kernel.org/r/20260421202110.306051-4-peterx@redhat.com
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
index 0db115ec5e..ed475e4261 100644
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


