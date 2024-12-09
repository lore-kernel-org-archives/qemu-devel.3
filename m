Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E3EE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 11:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKbmb-0002Bo-1s; Mon, 09 Dec 2024 06:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tKbmZ-0002Bd-0T
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 06:18:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tKbmX-0004e6-L3
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 06:18:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733743107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qTxyGQ9mWZonxjhxRxO9UPcNwcedf7zfsyDn8yg6/eY=;
 b=XwFbZAeIXu7n4KCbTvpzJKWOq8e8KWd9dN5fh700n091zNOilmaAmN3sQ5+NjlFlhkGhw7
 o4CMk0Mf5+/CAxxmMSKyPdJc6xJWnXWdgEuU/gmFzzcYlgZzv2h+LUQaZT0gyIwMXw87EE
 F/uyXNo9nL44szstpEMbRBpJ+iUPfNs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-cbp-9Q2CNB-WlbWrvXbG_w-1; Mon,
 09 Dec 2024 06:18:24 -0500
X-MC-Unique: cbp-9Q2CNB-WlbWrvXbG_w-1
X-Mimecast-MFC-AGG-ID: cbp-9Q2CNB-WlbWrvXbG_w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CCC719560B6; Mon,  9 Dec 2024 11:18:23 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.61])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28BD019560A2; Mon,  9 Dec 2024 11:18:20 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] qga: Add log to guest-fsfreeze-thaw command
Date: Mon,  9 Dec 2024 13:18:17 +0200
Message-ID: <20241209111817.31307-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
 qga/commands-posix.c | 3 +++
 qga/commands-win32.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 636307bedf..ac8d150582 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -805,6 +805,9 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
     int ret;
 
     ret = qmp_guest_fsfreeze_do_thaw(errp);
+
+    slog("guest-fsthaw called");
+
     if (ret >= 0) {
         ga_unset_frozen(ga_state);
         execute_fsfreeze_hook(FSFREEZE_HOOK_THAW, errp);
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 038beb8cfa..3a6f3ac7c5 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -1272,6 +1272,8 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
 
     qga_vss_fsfreeze(&i, false, NULL, errp);
 
+    slog("guest-fsthaw called");
+
     ga_unset_frozen(ga_state);
     return i;
 }
-- 
2.47.1


