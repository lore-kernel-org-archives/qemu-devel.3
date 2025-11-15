Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0889DCEB2C7
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Nov 2025 09:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKCKO-0003uE-Ik; Sat, 15 Nov 2025 04:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vKCKL-0003nW-LY
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 04:12:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vKCKK-0005Td-3W
 for qemu-devel@nongnu.org; Sat, 15 Nov 2025 04:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763197930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CnTMv2Vgs6wep0eodIuffaCGNgdM5v53WzVNNDdbet0=;
 b=eLd+js5Jdk3wKsQDFxnUmPQW7Zp/izL6WJ3TzwjB7gjQC3N9v67tGUiISPfdPMIeGKqtaU
 ubhRFluDCR2ywuEgzFMJIeBWh+y95ns9DjU8EkL6eer79dHMdV52zfkYVbnCmJkolc6aZY
 xPAy1+0LEjnUJMI+vHp+enzI3kekfEc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-2CxIbapAOFSPs97B-7AQUA-1; Sat,
 15 Nov 2025 04:12:05 -0500
X-MC-Unique: 2CxIbapAOFSPs97B-7AQUA-1
X-Mimecast-MFC-AGG-ID: 2CxIbapAOFSPs97B-7AQUA_1763197924
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62ADC18A1AC4; Sat, 15 Nov 2025 08:35:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EAFE1956046; Sat, 15 Nov 2025 08:35:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 13C4921E6935; Sat, 15 Nov 2025 09:35:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de
Subject: [PATCH 1/3] migration: Plug memory leaks after migrate_set_error()
Date: Sat, 15 Nov 2025 09:34:58 +0100
Message-ID: <20251115083500.2753895-2-armbru@redhat.com>
In-Reply-To: <20251115083500.2753895-1-armbru@redhat.com>
References: <20251115083500.2753895-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

migrate_set_error(s, err) stores a copy of @err in @s.  The original
@err is not freed.  Most callers free it immediately.  Some callers
free it later, or pass it on.  And some leak it.  Fix those.

Perhaps migrate_set_error(s, err) should take ownership of @err.  The
callers that free it immediately would become simpler, and avoid a
copy and a deallocation.  The others would have to pass
error_copy(err).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/cpr-exec.c | 3 ++-
 migration/multifd.c  | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index d284f6e734..0b8344a86f 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -159,11 +159,12 @@ static void cpr_exec_cb(void *opaque)
     error_report_err(error_copy(err));
     migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
     migrate_set_error(s, err);
+    error_free(err);
+    err = NULL;
 
     /* Note, we can go from state COMPLETED to FAILED */
     migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
 
-    err = NULL;
     if (!migration_block_activate(&err)) {
         /* error was already reported */
         error_free(err);
diff --git a/migration/multifd.c b/migration/multifd.c
index 98873cee74..a529c399e4 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -964,6 +964,7 @@ bool multifd_send_setup(void)
 
         if (!multifd_new_send_channel_create(p, &local_err)) {
             migrate_set_error(s, local_err);
+            error_free(local_err);
             ret = -1;
         }
     }
@@ -988,6 +989,7 @@ bool multifd_send_setup(void)
         ret = multifd_send_state->ops->send_setup(p, &local_err);
         if (ret) {
             migrate_set_error(s, local_err);
+            error_free(local_err);
             goto err;
         }
         assert(p->iov);
-- 
2.49.0


