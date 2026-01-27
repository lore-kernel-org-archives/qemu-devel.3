Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D07D2F033
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkjgq-0007tH-Hc; Tue, 27 Jan 2026 09:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vkjgm-0007rO-7e
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:05:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vkjgk-0007BQ-76
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769522701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Rg3iQadC32mqph8pX7W1m8PM4HTN1EGy3Hw3m4jXNM=;
 b=QC3rTEYl4wgjWWmCLdIYxkPVfx2m6LIHUdCPjzDWq1vV8NUdCbGJ8De01QJpfzf91uE+/7
 GN0dhoQ6JICH6XVGcrMbRONFjMPqb8+BRvgRawF6LRmoRBGTnxOMVrU7IsAFE1RLSLbHGy
 Kfmp+rAmUQYp4WsUjrN7iAe8qL+drgo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-HOPFirinPvWZuHUq3JuBSw-1; Tue,
 27 Jan 2026 09:03:46 -0500
X-MC-Unique: HOPFirinPvWZuHUq3JuBSw-1
X-Mimecast-MFC-AGG-ID: HOPFirinPvWZuHUq3JuBSw_1769522624
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5186A19775DE; Tue, 27 Jan 2026 14:03:44 +0000 (UTC)
Received: from fedora (unknown [10.43.3.182])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 368F518008FF; Tue, 27 Jan 2026 14:03:41 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 1/4] migration/qemu-file: Add ability to clear error
Date: Tue, 27 Jan 2026 15:03:07 +0100
Message-ID: <20260127140316.4187221-2-jmarcin@redhat.com>
In-Reply-To: <20260127140316.4187221-1-jmarcin@redhat.com>
References: <20260127140316.4187221-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Juraj Marcin <jmarcin@redhat.com>

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 migration/qemu-file.c | 6 ++++++
 migration/qemu-file.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 9cf7dc3bd5..bdf6c73d3d 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -227,6 +227,12 @@ void qemu_file_set_error(QEMUFile *f, int ret)
     qemu_file_set_error_obj(f, ret, NULL);
 }
 
+void qemu_file_clear_error(QEMUFile *f)
+{
+    f->last_error = 0;
+    error_free(f->last_error_obj);
+}
+
 static bool qemu_file_is_writable(QEMUFile *f)
 {
     return f->is_writable;
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index a8e9bb2ccb..aa24196ffb 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -68,6 +68,7 @@ int qemu_file_get_error_obj_any(QEMUFile *f1, QEMUFile *f2, Error **errp);
 void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err);
 int qemu_file_get_error_obj(QEMUFile *f, Error **errp);
 void qemu_file_set_error(QEMUFile *f, int ret);
+void qemu_file_clear_error(QEMUFile *f);
 int qemu_file_shutdown(QEMUFile *f);
 QEMUFile *qemu_file_get_return_path(QEMUFile *f);
 int qemu_fflush(QEMUFile *f);
-- 
2.52.0


