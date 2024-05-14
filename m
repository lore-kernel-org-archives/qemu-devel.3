Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13971C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 11:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6pwi-0001EE-1N; Tue, 14 May 2024 07:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6pwU-0001Ac-VY
 for qemu-devel@nongnu.org; Tue, 14 May 2024 07:03:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6pwS-0005an-R1
 for qemu-devel@nongnu.org; Tue, 14 May 2024 07:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715684611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gFQqcYb8BsKTfVtisz2nIw4RxvKVSo+7+L5B20PxGEw=;
 b=LWV/5sAj+g7jsjpIrWDuevfPh8OkG3RPoidanWYQ7ymaO/dFwnkyFpeX3QyaKrtI049BzF
 0+WN58YuhVA32KMYRvyapeK/FzrPsO8mlz9l2+RFWU4lmklQGzRN3BGkqbPLJ2gkkHyV9y
 SHuy6stv8Tx4mrjrDxFLL6HIFB8Whc0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-fn2q5OojNke7PR47HE0UoA-1; Tue, 14 May 2024 06:58:30 -0400
X-MC-Unique: fn2q5OojNke7PR47HE0UoA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 575F0184862F;
 Tue, 14 May 2024 10:58:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14DFB200A08E;
 Tue, 14 May 2024 10:58:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0A2AE21E5E73; Tue, 14 May 2024 12:58:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	kkostiuk@redhat.com,
	michael.roth@amd.com
Subject: [PATCH 1/3] qga-win32: Improve guest-set-user-password,
 guest-file-open errors
Date: Tue, 14 May 2024 12:58:26 +0200
Message-ID: <20240514105829.729342-2-armbru@redhat.com>
In-Reply-To: <20240514105829.729342-1-armbru@redhat.com>
References: <20240514105829.729342-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When guest-set-user-password's argument @password can't be converted
from UTF-8 to UTF-16, we report something like

    Guest agent command failed, error was 'Invalid sequence in conversion input'

Improve this to

    can't convert 'password' to UTF-16: Invalid sequence in conversion input

Likewise for argument @username, and guest-file-open argument @path,
even though I'm not sure you can actually get invalid input past the
QMP core there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qga/commands-win32.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 6fee0e1e6f..ed31077457 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -217,6 +217,9 @@ int64_t qmp_guest_file_open(const char *path, const char *mode, Error **errp)
 
     w_path = g_utf8_to_utf16(path, -1, NULL, NULL, &gerr);
     if (!w_path) {
+        error_setg(errp, "can't convert 'path' to UTF-16: %s",
+                   gerr->message);
+        g_error_free(gerr);
         goto done;
     }
 
@@ -244,10 +247,6 @@ int64_t qmp_guest_file_open(const char *path, const char *mode, Error **errp)
     slog("guest-file-open, handle: % " PRId64, fd);
 
 done:
-    if (gerr) {
-        error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr->message);
-        g_error_free(gerr);
-    }
     g_free(w_path);
     return fd;
 }
@@ -1946,11 +1945,17 @@ void qmp_guest_set_user_password(const char *username,
 
     user = g_utf8_to_utf16(username, -1, NULL, NULL, &gerr);
     if (!user) {
+        error_setg(errp, "can't convert 'username' to UTF-16: %s",
+                   gerr->message);
+        g_error_free(gerr);
         goto done;
     }
 
     wpass = g_utf8_to_utf16(rawpasswddata, -1, NULL, NULL, &gerr);
     if (!wpass) {
+        error_setg(errp, "can't convert 'password' to UTF-16: %s",
+                   gerr->message);
+        g_error_free(gerr);
         goto done;
     }
 
@@ -1966,10 +1971,6 @@ void qmp_guest_set_user_password(const char *username,
     }
 
 done:
-    if (gerr) {
-        error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr->message);
-        g_error_free(gerr);
-    }
     g_free(user);
     g_free(wpass);
     g_free(rawpasswddata);
-- 
2.45.0


