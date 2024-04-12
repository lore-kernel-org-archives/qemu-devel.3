Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D57C46467
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 13:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvGtn-00034c-2s; Fri, 12 Apr 2024 09:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rvGtm-00034T-1J
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 09:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rvGtk-0007Bn-Dp
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 09:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712928295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bukNwZC7rZvo7S2js53Oz+UeTIHa5e8FrjdOFQeUiro=;
 b=K9QeUhtsr82urUDUWsB2Ogr9IGJ3zmgSt1j9+NONcQnFotOKI6vtbjVyj7u+qKexoYa9jh
 lg7gUgzvychlaSXtpNqpaXLbWR0nEbSERElMcIpGUs/PE8jp8lF+41JOAAaMbHXA+r6Ab3
 T38A1emExtQTqeS/lApk/J14i488AcY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-v7tJyE9XNsarqZn85akKRQ-1; Fri, 12 Apr 2024 09:24:54 -0400
X-MC-Unique: v7tJyE9XNsarqZn85akKRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91A8D881E60;
 Fri, 12 Apr 2024 13:24:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C93E2166B31;
 Fri, 12 Apr 2024 13:24:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@kamp.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 08/13] Remove glib compatibility code that is not required
 anymore
Date: Fri, 12 Apr 2024 15:24:10 +0200
Message-ID: <20240412132415.282354-9-thuth@redhat.com>
In-Reply-To: <20240412132415.282354-1-thuth@redhat.com>
References: <20240412132415.282354-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
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

Now that we bumped the minumum glib version to 2.66, we can drop
the old code.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qga/commands-posix-ssh.c |  8 --------
 util/error-report.c      | 10 ----------
 2 files changed, 18 deletions(-)

diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index b0e0b1d674..cc1f5a708e 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -288,7 +288,6 @@ qmp_guest_ssh_get_authorized_keys(const char *username, Error **errp)
 }
 
 #ifdef QGA_BUILD_UNIT_TEST
-#if GLIB_CHECK_VERSION(2, 60, 0)
 static const strList test_key2 = {
     .value = (char *)"algo key2 comments"
 };
@@ -484,11 +483,4 @@ int main(int argc, char *argv[])
 
     return g_test_run();
 }
-#else
-int main(int argc, char *argv[])
-{
-    g_test_message("test skipped, needs glib >= 2.60");
-    return 0;
-}
-#endif /* GLIB_2_60 */
 #endif /* BUILD_UNIT_TEST */
diff --git a/util/error-report.c b/util/error-report.c
index 6e44a55732..1b17c11de1 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -172,18 +172,8 @@ static void print_loc(void)
 static char *
 real_time_iso8601(void)
 {
-#if GLIB_CHECK_VERSION(2,62,0)
     g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
-    /* ignore deprecation warning, since GLIB_VERSION_MAX_ALLOWED is 2.56 */
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
     return g_date_time_format_iso8601(dt);
-#pragma GCC diagnostic pop
-#else
-    GTimeVal tv;
-    g_get_current_time(&tv);
-    return g_time_val_to_iso8601(&tv);
-#endif
 }
 
 /*
-- 
2.44.0


