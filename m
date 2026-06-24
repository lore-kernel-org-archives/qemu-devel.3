Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E098ECDB471
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 11:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcM1C-0003no-4R; Wed, 24 Jun 2026 07:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0o-0003Kj-0w
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcM0m-000862-2w
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 07:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782301399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8oJhp2WWKN8NTZUBbifGfBwbYlJXpITBp+aYDMcfcZw=;
 b=NvF8ZETJOx/CY6tVtgyIuYvbmAdVez7htNUrtE4saFe6E4pS9k7narRBi6fOQsQDFKnXJy
 u8zOjVeul2nNtOyVvTzo8RfKaj3DGzfz+Yl+ttof8BZcAnXIEr3YF7SNpMBD4eBZLYEUCA
 BebtQO84AUScNOrlYuBlakCcnFQP+dM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-2y1kQSbzMHCvELb7o3qABw-1; Wed,
 24 Jun 2026 07:43:11 -0400
X-MC-Unique: 2y1kQSbzMHCvELb7o3qABw-1
X-Mimecast-MFC-AGG-ID: 2y1kQSbzMHCvELb7o3qABw_1782301390
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA5CF19540D0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 11:43:10 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 460A53691F; Wed, 24 Jun 2026 11:43:08 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 24 Jun 2026 15:41:40 +0400
Subject: [GIT PULL 18/35] ui/spice-app: implement display cleanup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-ui-v1-18-482147b0a7af@redhat.com>
References: <20260624-ui-v1-0-482147b0a7af@redhat.com>
In-Reply-To: <20260624-ui-v1-0-482147b0a7af@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rS34HvjOxWg+QK1nnNvoiwkDdDt+ESd4Q1XOuHlRJ9M=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqO8JnUCv3Lo5+1ma9e8BO6E9XURGJd5xMmyZE/
 M5ZdrEKy4uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajvCZwAKCRDa6OEJdZac
 5Y7uD/962H/eB8FYjhymQjcWHUO11wU0Bypr1NmtSIBkfnf7Pfyc2V6CGyttNwzaqgdWAlV943C
 kdHd99Y4WnmKUxAs0t2MV8+yYVw0r9f5x5qTEnAxmdYjiMOU0feyIZ6UvBHmyy4aq5x5J6hl/0O
 tkMluLo9tfWaxmCko2yZlF++vwj2Iz8jgeCwJkfEE+UeQoKumMo30BI35tVARYzQi14RHff8h5/
 ivmu4Yrj3/XEv3CQ5C+7nT3z5p17wKtd/0zhmM6K4q1tToUeD0e6WTxZRVtxvCCCbPAeCORjXFY
 c/uVYw2qrab6lkQF3zr6LdIIm6B7VgOJwDuRbW6TbOczXDFkwJXeDaWGncNs7wfS7hpXYWlFsME
 YW15kEFZp+9HhRjAL+MvXoRpZqOyQ+ys8NPvrhfFV6WBQIyyAPfDzLlemqPxEcL0zjUDVw0ylNX
 YsQ9RU0pmXfVqMZ+EECs+7pJafSTFvXSomDfSjgv3DElWWivFGHTnmQtuCic/bPmiPJ5Uw7qQYJ
 scZe8sIrYE5e4F6lt84EWcNbJJMlHkoLtY6qn9H8W86BS5SrGomfV3MfQp0Tcbt2nmBMBwT8RSr
 rAHEVpEtTzpfDzCk4gOHPgbBmGTPI+PeuzksfF5tOKEDRfZdRJqgA/Mkp2dnaBz7aCYY+VNFkig
 zOCil1jizb6ExcA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace the atexit() handler with the display cleanup callback,
reusing the existing spice_app_atexit() function.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260623-b4-ui-v4-18-4656aec3398d@redhat.com>
---
 ui/spice-app.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/ui/spice-app.c b/ui/spice-app.c
index 0df7325e679..fe3df62bfa5 100644
--- a/ui/spice-app.c
+++ b/ui/spice-app.c
@@ -119,16 +119,17 @@ static const TypeInfo char_vc_type_info = {
     .class_size = sizeof(VCChardevClass),
 };
 
-static void spice_app_atexit(void)
+static void spice_app_cleanup(void)
 {
     if (sock_path) {
         unlink(sock_path);
+        g_clear_pointer(&sock_path, g_free);
     }
     if (tmp_dir) {
         rmdir(tmp_dir);
+        tmp_dir = NULL;
     }
-    g_free(sock_path);
-    g_free(app_dir);
+    g_clear_pointer(&app_dir, g_free);
 }
 
 static void spice_app_display_early_init(DisplayOptions *opts)
@@ -146,8 +147,6 @@ static void spice_app_display_early_init(DisplayOptions *opts)
         exit(1);
     }
 
-    atexit(spice_app_atexit);
-
     if (qemu_name) {
         app_dir = g_build_filename(g_get_user_runtime_dir(),
                                    "qemu", qemu_name, NULL);
@@ -218,6 +217,7 @@ static QemuDisplay qemu_display_spice_app = {
     .type       = DISPLAY_TYPE_SPICE_APP,
     .early_init = spice_app_display_early_init,
     .init       = spice_app_display_init,
+    .cleanup    = spice_app_cleanup,
     .vc         = "vc",
 };
 

-- 
2.54.0


