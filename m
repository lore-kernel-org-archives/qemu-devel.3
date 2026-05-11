Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 202D8CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:20:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMSQq-00018n-Ps; Mon, 11 May 2026 11:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMSQo-00018O-FB
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:20:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMSQm-0004Kj-MG
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778512827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VRxghKnWfkWDk7S8qdIJvg/nO6kaqUnEIVUykPDtpoQ=;
 b=LDHQTPk97gVlGYelm+TkBNkulrfGY7stPaSc7khJPDYM+KJ97UGXuy55E41gFyehkjfnUz
 +aspC44YOvjZEgzvyq1x2f58u7pFDWCNMk1tjajEynKb8c1K16DLqLbj+Zyc0mZhhAU0+D
 KYLCa5mH0Y3wtCueswSspAal8douRV8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-07fxDKXkNWihe25BrzB6Ng-1; Mon, 11 May 2026 11:20:26 -0400
X-MC-Unique: 07fxDKXkNWihe25BrzB6Ng-1
X-Mimecast-MFC-AGG-ID: 07fxDKXkNWihe25BrzB6Ng_1778512823
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8b7e68098dcso103812476d6.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778512823; x=1779117623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VRxghKnWfkWDk7S8qdIJvg/nO6kaqUnEIVUykPDtpoQ=;
 b=lSbAZnOZrnxOChpNduRbtjoW9Bo5iSfACwSLQ6tZ/dorwEj7yYBCPg9BU0qXEjdOjs
 UIFZlLrpZt7NbxccRwwNSsgRQFgQ0mskz3DtW1YBi3wu2uYN+ONq2AO+8MH2WlEIy8Wk
 o17CTbHLQasgdmN3dPyIylUgDGaI1upQYQiwyZ3b88pzoreqiUT8UFCMy7U8qKvPyivZ
 e8Ls+PhvtpIkrFmP+7+lDG4ceb6lKC1lj/2uCVNUeLNkIeEWW5ebl5HSEhPuEkjZwTB0
 CRKeMIivdDO0xX4B7+qRVyeuasinGHlP0ef/rzmSmCiOOOFFNiRi32HLjw39hPE0JJ7x
 Gc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778512823; x=1779117623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRxghKnWfkWDk7S8qdIJvg/nO6kaqUnEIVUykPDtpoQ=;
 b=VfrroS96SS5aPV4ys9stDq9dzt0iCVNECqoksjdc9yl7/ocqeOc2i099sLULpotQSz
 8EvK+WeFmlMEKZpngwr8sLiAwg58IzfjStU26T0VuAcohcxKc29ok5ueRBcZZtO+Gqrd
 3QEhJ3gdk4OLbvPKCfN+SbxFy92dHMqJgkyK3asdJ2ym1tGr2btdIWFOQVTOg1WnN0Io
 l9V+0caIygL1HrexeTo6Ptf/k4X2EXmvz/OJJaNebxez7l7946OJuad4aVOn/zu+QTAg
 Kc/x7NO0wVPKo8tzZX7jxsHxKZ/c3UIjQMbVqScDQ5US1ccvP6gPTi/ej2VADvyRGi6n
 Qe3Q==
X-Gm-Message-State: AOJu0YwvQe0y1F7/M6+HqXXLIqhxhdzO63bajwo3Y35jFgFBU74l5rdB
 tsl1V3k81QS7AYUcOdFFZWIqLQ7SzoL0Ji8F2UMdkTqrXzu3dxgtLOqNtvqr87UcsRthf+dVMc5
 tmQgsBH8u+hkXcwVcV4M6T0EtYwD6JUAf1CSdgSXjVh/PP2YqZvap2Q9y+QqtKfFG7Q46uXbNJc
 x0C3kSbwC/tKO3lGa4V02Dff+8LATCzp3tKKaqcg==
X-Gm-Gg: Acq92OGD7MUFlGTSKCpUoNC4iRN+J/Kq3PLfjkitn86HHI1Dqvk534+NK4b81Bowo7U
 /38/LZLN2UXpcVy95tJtFtgpTQjhJUhBHh0J/l/GrTsRtEpLshwQFx7RRpMX+VOaw3geaPM2XTr
 rwa//RYL5fRSU71wu5cBu+YLzJdTjeCOcF93IfiwkRe8kO1NltoIDlwcX3HolRb/60nGRL9Vz79
 kwu0i52k48BwfnPkW1YD4AKODTqhiRMQy6sLojHL/z5WRmZx37/ig982tX1WX2gxZfHPnT6ajDp
 IHHZMADiPwejOfdNGc0PyLzAssj3SEf1nsxsv072U0sMVO0csolB2xdP+IbhlEeKaeUlPsnb52f
 n9Ik4P2hYs83o6n5vDQsG7IUnexv0ij9F1VdR2+/UFdwp
X-Received: by 2002:a05:6214:2c05:b0:8b4:a0be:4b50 with SMTP id
 6a1803df08f44-8c1af2eecd6mr153082416d6.33.1778512822471; 
 Mon, 11 May 2026 08:20:22 -0700 (PDT)
X-Received: by 2002:a05:6214:2c05:b0:8b4:a0be:4b50 with SMTP id
 6a1803df08f44-8c1af2eecd6mr153081546d6.33.1778512821684; 
 Mon, 11 May 2026 08:20:21 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf3a71aaa5sm96843316d6.18.2026.05.11.08.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 08:20:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2] migration: Fix possible division by zero on calc expected
 downtime
Date: Mon, 11 May 2026 11:20:19 -0400
Message-ID: <20260511152019.1316898-1-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Commit dd4fe8844b changed the reporting of expected downtime behavior, so
that the value will be calculated on-demand.  One side effect on the change
is QEMU will allow the calculation to happen anytime even if there's no
transfer happening for a short while.

PeterM reported an ubsan report from clang when running migration-test with
aarch64 binary on x86_64 hosts.  I can also reproduce if I run the test
concurrently so some of the src QEMU may not get chance to push any data,
causing mbps to be 0:

../migration/migration.c:1051:12: runtime error: -nan is outside the range of representable values of type 'long'

Fix it by properly handle both Inf and Nan.  One note is we can't use
">"/">=" check here otherwise we cannot cover Nan.

Link: https://lore.kernel.org/r/CAFEAcA-MYH6C39xO0OLx4-M5pKurJpurwRsMqZe9q=W-NShAbw@mail.gmail.com
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: dd4fe8844b ("migration: Calculate expected downtime on demand")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index b6f78eb3ac..e4103cd3f0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1044,12 +1044,28 @@ static bool migrate_show_downtime(MigrationState *s)
 /* Return expected downtime (unit: milliseconds) */
 int64_t migration_downtime_calc_expected(MigrationState *s)
 {
+    double expected_ms;
+
     if (mig_stats.dirty_sync_count <= 1) {
         return migrate_downtime_limit();
     }
 
-    return mig_stats.dirty_bytes_last_sync /
+    expected_ms = mig_stats.dirty_bytes_last_sync /
         migration_get_switchover_bw(s) * 1000;
+
+    /*
+     * This "<" check covers two cases where we want to fallback to
+     * INT64_MAX, the 1st case is obvious, but the 2nd is not:
+     *
+     * (1) when expected_ms is Inf, or anything too big for int64_t
+     * (2) when expected_ms is Nan (division by zero), evaluation of this
+     *     if clause will be FALSE
+     */
+    if (expected_ms < (double)INT64_MAX) {
+        return (int64_t) expected_ms;
+    }
+
+    return INT64_MAX;
 }
 
 static void populate_time_info(MigrationInfo *info, MigrationState *s)
-- 
2.53.0


