Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD287E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:46:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDIT-00049v-VO; Mon, 16 Dec 2024 10:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tNDIR-00049b-FD
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:46:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tNDIO-0003Uk-MG
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:46:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734363966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sGVdRhsAAqkufRUOc9OCLWgQgP0nF121Id5FRTt+Gzo=;
 b=OusLFX2UFOaR8sgGZiRVdjgxyE39SCUQ6Aim4dv0PvI+0dJuWhOIhTd0OktUs508c8oEgQ
 3bqhqRF3SPgcqEwG3pglGcEUg1XepQsEILqwOCGVEy7TiI7gjdnLEdZLyQSr7BAHIv/0rs
 YXpsA6syEr4iOnXYaiDoMjERWXwS1zM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-K5kOSOUIO9-RQOC72EJ8ug-1; Mon,
 16 Dec 2024 10:46:02 -0500
X-MC-Unique: K5kOSOUIO9-RQOC72EJ8ug-1
X-Mimecast-MFC-AGG-ID: K5kOSOUIO9-RQOC72EJ8ug
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FBB61955D4A; Mon, 16 Dec 2024 15:46:01 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.75])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C10D1956052; Mon, 16 Dec 2024 15:45:58 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/1] qga: Add log to guest-fsfreeze-thaw command
Date: Mon, 16 Dec 2024 17:45:52 +0200
Message-ID: <20241216154552.213961-2-kkostiuk@redhat.com>
In-Reply-To: <20241216154552.213961-1-kkostiuk@redhat.com>
References: <20241216154552.213961-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-posix.c | 2 ++
 qga/commands-win32.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 636307bedf..359a56be81 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -805,8 +805,10 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
     int ret;
 
     ret = qmp_guest_fsfreeze_do_thaw(errp);
+
     if (ret >= 0) {
         ga_unset_frozen(ga_state);
+        slog("guest-fsthaw called");
         execute_fsfreeze_hook(FSFREEZE_HOOK_THAW, errp);
     } else {
         ret = 0;
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 038beb8cfa..7d8e260e1f 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1273,6 +1273,9 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
     qga_vss_fsfreeze(&i, false, NULL, errp);
 
     ga_unset_frozen(ga_state);
+
+    slog("guest-fsthaw called");
+
     return i;
 }
 
-- 
2.47.1


