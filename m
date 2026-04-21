Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0ADCF94CAC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHbJ-000112-MM; Tue, 21 Apr 2026 16:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHbH-00010q-LB
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHbF-0008Sv-St
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776802897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Af9JljxWi70ez3woHKeuds1zCU/ND/L9uxolesYJp+k=;
 b=XDXX8K8WY4l2YW45wcL2weFVrtwGBM9bXI+Mm85ZJRebOtmf4PQwqE20gi/oBbpSj2mHho
 xjGi4+Rlb+PDOphK5ITpwrZHS+1DK9HhOqOw3Il3xYqwwk7OBz8fLUEq+GinGZEeQz1MoF
 QAnqz35EQ/zFdzqd1ap+XukdbNujym4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-uvcKwInBO4OJaqQGzsai3A-1; Tue, 21 Apr 2026 16:21:35 -0400
X-MC-Unique: uvcKwInBO4OJaqQGzsai3A-1
X-Mimecast-MFC-AGG-ID: uvcKwInBO4OJaqQGzsai3A_1776802895
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8acdd800537so96006106d6.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776802895; x=1777407695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Af9JljxWi70ez3woHKeuds1zCU/ND/L9uxolesYJp+k=;
 b=Mbl90EQbQ00AU1rBmNPUn0xB2phP3VT1xj3CYHPpzUsUwK9q4teBzeCbd/ayjMgfqv
 ToWETRo8ozQL8z5Z1MKKXDrTozz54iqp3c0JeuRAEOI2/Yw8Tk4lberFcD3+I02tnWN3
 E8CXn5s7bhBSCu4T2+5sTMDdut5Ren5CvUKEGRKK7q5K1LMXTS/9ifL/uYwbCxuX1Qn9
 9J6NwLZTm3U/1VLdZdRQaA5nUdt/8erUCAky+RUVazglmJYwNa4Ezg114BrpA4KPOWYX
 5WIadpnz13CarzJZuIeuFLfS1YNaCcwFid6piNbJslP0iZ/OKzMNbTp7y+5+z4TwhXJR
 jimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802895; x=1777407695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Af9JljxWi70ez3woHKeuds1zCU/ND/L9uxolesYJp+k=;
 b=EeVQINiu36gVZbvvG9jKjd2UuLgxDc8wLKOC1RnznmiUfCobLX1tAZD3i/hGHKCBFj
 h8bYMjnlzXFcDEXm43QU+9RRH6V4wlH/oa4gG9+X2BgozXlPKp7rI9+J109HleiHWJNr
 qAHau9a0K0xfh7MGk/VQsMXGyF+gqfo4NDPbb5ewehdlcfbJ6UIDB5kvvwQfFTCUP01I
 jp1xzUtD1hQQ7iA/xwDet2DCrmrpMWvcQBI+OlfXnnI5myq+DItkK4FCb2pKOUTNgda+
 +600TWLnzAg7qhUbo9fiCcHF8oHMz+PzffSVPGWjzSW/2Cuxmr/hsD4mVgG1hbdj5UMT
 U6sw==
X-Gm-Message-State: AOJu0YwKdhjSN0iP9MzNhZBW6mh1voGwxN0tgnu1+q9mi5KtcCNVF2WB
 GC2UOAhy0RlAJLT2RFQMtyvbHGKq8lCdqBM6Y6DRYe+7zOw+IX2dXopN32QrIjiSz/rG6ZdEXIn
 XsHpDDMbsMJlkrIHutwx9QLiWPLNEpoZQ2ExUOA9UDlMmbjsDDcLJKt0PjeV/XXccyDi2FLpgrt
 2VpcMeKctKWerJPneiNkXTgf0HIoum1snLPobP4A==
X-Gm-Gg: AeBDieuF0Kgz+DLeoMkfcMOBSJ7o9qYfDSWfwZIRLWhlucZeFhgj2tJ+Hl5XOuWHIF5
 p5OGTQZ3q2GUyMY+1oDjhjCuVutl71nrX7U3Vz+p7GoOO+arqSnCOx6TxostDY4EJ/j+wuUMXKe
 p7CkKllTsiaNoWPLgQFj/WdIiX7SCFhcabcuhDfZR0iUn49T7c9k4N+zjxc2zI8TaEimx3eR0Sl
 NmqpgJSvzClcTLiq+bDpiZk039u9onv76OClfa1e23LYmF6FwuRBt1Tyqf5e9DRiEjtxM0+FzpO
 EzXx/A2HgMW1Rew/eD+DPgbSYgkg1+WaMjYvQtIbkg/vEMvCygNZ86L9fOQ02itW+IzNkxnynv7
 VwJBT/y9zCV7y9wu0wAvOhSUdSM4j99hbiutJvqTtLHxOqp23l593dTP5WA==
X-Received: by 2002:a05:6214:21e6:b0:8a1:88f7:d292 with SMTP id
 6a1803df08f44-8b0280135dbmr332386396d6.13.1776802894725; 
 Tue, 21 Apr 2026 13:21:34 -0700 (PDT)
X-Received: by 2002:a05:6214:21e6:b0:8a1:88f7:d292 with SMTP id
 6a1803df08f44-8b0280135dbmr332385816d6.13.1776802894193; 
 Tue, 21 Apr 2026 13:21:34 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c26csm114343556d6.31.2026.04.21.13.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:21:33 -0700 (PDT)
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
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 13/16] migration: Remember total dirty bytes in mig_stats
Date: Tue, 21 Apr 2026 16:21:07 -0400
Message-ID: <20260421202110.306051-14-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421202110.306051-1-peterx@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Introduce this new counter to remember the total dirty bytes for the whole
system.  It will be used for query-migrate command to fetch system-wise
remaining data.

A prior attempt was made to not use this counter but query directly from
all the modules in a QMP handler, but it exposed some complexity not only
on migration state machine race conditions (where the query may be invoked
anytime of the state machine), or on locking implications (where some of
the query hooks may take BQL, which is illegal at least in a QMP handler).
For more information, see:

https://lore.kernel.org/r/aeZMtxqrKWAMKzdN@x1.local

This oneliner will resolve everything, except that it is not as accurate.
The hope is it is a worthwhile trade-off solution, after knowing above
challenges.

Now, there is one more reason we should make each invocation of
save_live_iterate() to be lightweight, because this counter will only get
updated once for each loop over all save_live_iterate() hooks when present.
But that's always the goal.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-stats.h | 7 +++++++
 migration/savevm.c          | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index 1775b916df..9f9a8eb9eb 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -36,6 +36,13 @@ typedef struct {
      * best-effort estimation on expected downtime.
      */
     uint64_t dirty_bytes_last_sync;
+    /*
+     * Number of bytes that were reported dirty now.  This is an estimate
+     * value and will be updated every time migration thread queries from
+     * modules in an iteration loop.  It is used to provide best-effort
+     * estimation on total remaining data.
+     */
+    uint64_t dirty_bytes_total;
     /*
      * Number of pages dirtied per second.
      */
diff --git a/migration/savevm.c b/migration/savevm.c
index d221e2961b..b49a80f574 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1781,6 +1781,13 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
     pending->total_bytes = pending->precopy_bytes +
         pending->stopcopy_bytes + pending->postcopy_bytes;
 
+    /*
+     * Update system remaining dirty bytes whenever QEMU queries.  It will
+     * make the value to be not as accurate, but should still be pretty
+     * close to reality when this got invoked frequently while iterating.
+     */
+    mig_stats.dirty_bytes_total = pending->total_bytes;
+
     trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
                                     pending->stopcopy_bytes,
                                     pending->postcopy_bytes,
-- 
2.53.0


