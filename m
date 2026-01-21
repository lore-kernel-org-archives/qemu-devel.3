Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B274BC44500
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 22:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viglv-0007is-1M; Wed, 21 Jan 2026 17:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viglt-0007i1-Jk
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vigls-0003i0-0Z
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769034831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJr/v1k12nIBjKq07vpOQSzeaItwY+6aDw7MFBuDrBg=;
 b=HEPK+VZ8bX9lhN0Ul1IgrnoElwpXjHTq/vJsnddsLN09NJiBGUODyvjFRc0M3T2EjmGeJg
 DUV9rPiU8eCC8rDpLqsWvcoka2l+lw7FRFekErjYa3wPj1dZzE8q6+wrcZqtWSmdDQjYPK
 wcdBwQoZKUg5iKOebYm4RkQq2AsV9Ms=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-2VJAPOYCMj2mlXyTRI7DAA-1; Wed, 21 Jan 2026 17:33:48 -0500
X-MC-Unique: 2VJAPOYCMj2mlXyTRI7DAA-1
X-Mimecast-MFC-AGG-ID: 2VJAPOYCMj2mlXyTRI7DAA_1769034828
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89473f5a755so13185156d6.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 14:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769034828; x=1769639628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jJr/v1k12nIBjKq07vpOQSzeaItwY+6aDw7MFBuDrBg=;
 b=lXEHfv9Wq9p7ugUIiuc89rDSfWtZ/c2rW8m3T3FLscmd0u2zZG9hcCU/9kV58qkuqL
 UyzE2YcT4BzVddX2JwTFKdGELY/pug7MkQluboxyNZj7vWRMN4I6Dw5iM1s0PCVD6GHF
 B4ovwVd/vhiTNhn8hy/lDCKonH5xgHU0W8f7cMxOVrwft5kCkuO5WLRUKnH13Dql9o9P
 Wl12nUyf/aT0ZtXIdUSiHmzD+qe+/1LH/sXxIUOd4UYrzuux8fhWSXTDJ8D3277wGDKr
 LAC6kQ532/v2aShcO7xJ1xznCy9gyTVkJ5Gid40ftRJMBJdTwOUTEBCZjP9qcXG158aH
 tcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769034828; x=1769639628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jJr/v1k12nIBjKq07vpOQSzeaItwY+6aDw7MFBuDrBg=;
 b=TdFPS91HagbHqOmG6+8kA74Zyp9ExxqI1UCSEDaQGZscbqa4iEzuxVJxOFsWu8to+5
 C6FslJR2SAmUuf+GaLV34MLclkcaMZl3O0OJgrm2YUTFC1dVKKeSDQXsNY9vR7lg430M
 UCkpEOVsda5R/s/TyjYOAWLh1HsrNTVlHbkBx63vbfG5VOPkxhouEE2SIdjk9tRo/3fJ
 Vkkx6+qu8KHel0kb7PkCWl8S0VitEJGOc1MNTp9lrYU9uYoJXA/BG89nAefwBD9O3P8z
 a6Y+1DvR56hQczicTA10XkgzYuiu+GO8eidbCD2jUffIv8n/2/IqP6B8+J+b6c2gl4zC
 reVw==
X-Gm-Message-State: AOJu0YybK3Ukau3TnR++Ka7aiv+JenraIl+muquzlE7aiVNcAnIewI6N
 X/JhPIQgMKJjsfLLSuUeGIAWBtSysH0ttHISfcUSluXkERcACtStTd/J7NelJSIvXwS1V4OAh5B
 jbOVJK/Lo3sltO+KairwjSkhNRT1wqYMtc5O596EUqTLeNQMfbNcezdDDbaleLCw3icIZdERb/+
 QSJlPKFjeueqNAL6ueuhxFk4v1aSO5o2YaPhI/UA==
X-Gm-Gg: AZuq6aIPaNOcAwEC6F1eqzWYaJoU5mFVCENOzW3h6VxRDlgpeCylcpE4484OJR4Gmy6
 EVvcTwDeI0zKidyVb4rhrsjsyhdGV7XOSS8UIM15fZ9T/vrFtwYF+52z8vdAoNvc5M3dbkueyZM
 12djOQzcoXfK1MJosY3sUa+0c2Dt63fl+Z2Fd9i7+Um5YL4Wq0u38mFGmyD47OTE+fN1VX9PZ4r
 Fdg6iXbCNCuAZnZ5FoDV95Y6gssulVrzVtAAnQzS6fUjzl+kuWM9WWCluxSjKRVEvhNaubjDofE
 KFRYmVkpxTh4EdEXw6H5z72E95IFrRzKe/XBQWgqEtmN2KwZrldyDkjI4Mxaj/96ru5NoUJ5E3R
 j
X-Received: by 2002:ad4:5ae8:0:b0:894:6eea:709c with SMTP id
 6a1803df08f44-8946eea7214mr69174936d6.8.1769034827855; 
 Wed, 21 Jan 2026 14:33:47 -0800 (PST)
X-Received: by 2002:ad4:5ae8:0:b0:894:6eea:709c with SMTP id
 6a1803df08f44-8946eea7214mr69174566d6.8.1769034827306; 
 Wed, 21 Jan 2026 14:33:47 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89470b0ac3fsm25598306d6.25.2026.01.21.14.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 14:33:46 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 05/10] migration/colo: Unwrap qemu_savevm_live_state()
Date: Wed, 21 Jan 2026 17:33:30 -0500
Message-ID: <20260121223336.3381912-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121223336.3381912-1-peterx@redhat.com>
References: <20260121223336.3381912-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

It's only used in COLO path and only contains two calls.  Unwrap the
function.  It paves way for further reduce special COLO paths on sync.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h | 1 -
 migration/colo.c   | 3 ++-
 migration/savevm.c | 7 -------
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 5d815af742..528607f09e 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -64,7 +64,6 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
                                            uint64_t *start_list,
                                            uint64_t *length_list);
 void qemu_savevm_send_colo_enable(QEMUFile *f);
-void qemu_savevm_live_state(QEMUFile *f);
 int qemu_save_device_state(QEMUFile *f);
 
 int qemu_loadvm_state(QEMUFile *f, Error **errp);
diff --git a/migration/colo.c b/migration/colo.c
index db783f6fa7..e05736ecf0 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -471,7 +471,8 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
      * TODO: We may need a timeout mechanism to prevent COLO process
      * to be blocked here.
      */
-    qemu_savevm_live_state(s->to_dst_file);
+    qemu_savevm_state_complete_precopy(s->to_dst_file, true);
+    qemu_put_byte(s->to_dst_file, QEMU_VM_EOF);
 
     qemu_fflush(fb);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index f1cd8c913d..529cf310e0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1854,13 +1854,6 @@ cleanup:
     return ret;
 }
 
-void qemu_savevm_live_state(QEMUFile *f)
-{
-    /* save QEMU_VM_SECTION_END section */
-    qemu_savevm_state_complete_precopy(f, true);
-    qemu_put_byte(f, QEMU_VM_EOF);
-}
-
 /* Is a save state entry iterable (e.g. RAM)? */
 static bool qemu_savevm_se_iterable(SaveStateEntry *se)
 {
-- 
2.50.1


