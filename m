Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E722310F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYT0-0006H6-KM; Wed, 08 Apr 2026 15:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAY3z-0006Ex-5P
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:55:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAWCF-000278-Uk
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775667367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vMp79kTswNcI5IIMHrzT1aaIDuja5B+32QTFFePbYkM=;
 b=KpqbwZgRCnL0C17T4UJ5/8zyJkpRWz9LSWoS0JemA6Jtqv+bn+UsLW4Zm9OtT2zN0apEaT
 HSq29BGNtVQn0l2UMXBkfvshNmbUh7EJehvYnmjpaHoM24RrnwUNkXTDJhcFEzqxeFUzPb
 cHkRe0bJfbdhgSTzxrg+95DkL+Da5dw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-yOR6rZAsPhKyyTxY1sYEYQ-1; Wed, 08 Apr 2026 12:56:06 -0400
X-MC-Unique: yOR6rZAsPhKyyTxY1sYEYQ-1
X-Mimecast-MFC-AGG-ID: yOR6rZAsPhKyyTxY1sYEYQ_1775667365
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b44f7b7bbso32251cf.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775667365; x=1776272165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vMp79kTswNcI5IIMHrzT1aaIDuja5B+32QTFFePbYkM=;
 b=N2gMpHNTDZFqeg6LjYG0ymhxJcYhUj2VLHG5T/BSAAweYRIgW2VJSql+H22QgC7xi4
 dYi3m+4DVs3WLGA2+/WO+YR3u+GIMZf3UlRTrh40D2wnTy0a9hii1d8jdhFzf4RTH/dc
 KV8/pg5e1FUfCSsp3V3OOAKivzttLRghmDlxMJ7vCJj8Hmfdi8T6eiUE1HxHuyCQodTs
 MSntd69yV56bIqyykMnXOTFE+xC45roATS9Gmfl6VQOcgP5FbHQrTEHBBjtQ00DfSQdT
 6KPukb/aFTieGgLN4D+dinu2tC633u8iqmX3notmHS1/ClDH484EKO32qhyEmQQDWRMR
 qxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775667365; x=1776272165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vMp79kTswNcI5IIMHrzT1aaIDuja5B+32QTFFePbYkM=;
 b=cDrWJ91hPyzAmhXIv9WpMZi+BUtu8NW9QabjtXqs+4dUhWNdLXpjFLArqBAdgcyZQu
 T63HPBLmD1gHPHARnpYrKDaOjKMOCgKglRkcryGs5MLRphX49akbpKgax1xyaGpiomro
 5HBT5todWib50c06JDEmryqmbkxuIE9Io7a5L3rXg5UCfJ2RzadV8CDA8wLejX2p+g7o
 cEJrB7Iim8lKo3UcCYoyUeDW/miKMMqNBHcHgcdmJ1fO5dMhGau9oNB5xEfSTAw+senJ
 FX9lizuw0nTIDWVg5byNE+nhfjFYHe6EvrOosPuZGt/tXNrgppm4tdz1BUft/fElPuj7
 wOZg==
X-Gm-Message-State: AOJu0YzB7rmB5ZaeN+wHDZ+iSdIDkpQTny+L/ciFjt2NgPRrPRNyO9sn
 7yy66hD+r0hU9pobojLPizzg+maH3KXH7N5IVe6hsAnCt1MXUTxB8ijPriH0QF4bJQaUQ/7oq1g
 sU/edwfAw1NjTNPDpCYvJS7AMMWPdY1XcA4R2hFyH74xnAonZ92JL3sJ8T6UrQpNBqUu2seO3H/
 GV/n5+GquENRR71VoXJz0+lx3oOAiZpox4jYZadw==
X-Gm-Gg: AeBDies2MOTcVJql+ARHrkPmr9b+Xbxe9q1jsDbr6/BOf4VQBYnPi01SbBGs6eMEafV
 fIx3LZ/bMrXqWkEvIh0tKbsGvjl7vAkTGy3ERrjF+xs8LdGJDf/w5WoomZktdvHIKmRoFsFUqVB
 JZZkwQO8xJcO9U43kkCX3LsUcJzse3IoQGN3FknsixqiwI6k6iZJKh0IwiEdGml40CKF1n+wZE0
 Qcm9+8qNloQIygnzwub57Fajc5N4jEKlWO0pTYZsMFtwVdRjz18gC1B2EKy8xFG3qQjBc18Irp9
 J5L807qPzERNeVB/BgW0fqwLyAAQNMo6wiUyxjX7X2R/n1GjUHA7bJv6Ek9qNaBgGY+p8fNBJ8F
 hqK7B74A2VDpmC8cx1mNof/eGvbLtY2rDVvZT6oZiEgGr
X-Received: by 2002:ac8:5cd0:0:b0:50d:85c1:3616 with SMTP id
 d75a77b69052e-50dc2261277mr1108091cf.43.1775667364940; 
 Wed, 08 Apr 2026 09:56:04 -0700 (PDT)
X-Received: by 2002:ac8:5cd0:0:b0:50d:85c1:3616 with SMTP id
 d75a77b69052e-50dc2261277mr1107391cf.43.1775667364247; 
 Wed, 08 Apr 2026 09:56:04 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d712c2617sm130491901cf.31.2026.04.08.09.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:56:03 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>,
 devel@lists.libvirt.org
Subject: [PATCH 02/14] migration/qapi: Rename MigrationStats to
 MigrationRAMStats
Date: Wed,  8 Apr 2026 12:55:46 -0400
Message-ID: <20260408165559.157108-3-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408165559.157108-1-peterx@redhat.com>
References: <20260408165559.157108-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/about/removed-features.rst |  2 +-
 qapi/migration.json             | 10 +++++-----
 migration/migration-stats.h     |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 557a24679a..ccd49b5615 100644
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


