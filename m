Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BE7CCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1le-00010q-2h; Mon, 03 Nov 2025 16:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lb-00010D-4m
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lT-0005Lg-Ha
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MhjJNzKPxpxd3gxFiz0Oy6+Fp9aW0Nvlu5a+NjuZlkc=;
 b=WVInKDA3ADSo1EecPNqSzDlMVbDXGKnSMHSwIRmJfpD6pNPMhS3X4sUYwNdKdpKpZBgCLV
 d3JUwcVRlrw0i8zkcJwOBr6QZaczgfvpXGIhJSKOj64p48GzCcKY5qzsRRXJHNlD0bgW3Y
 mo29aef2lFq3cwguyYdGg1BFBQ/i8Ao=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-atorPHfvOLCRZ0f3TN8CVw-1; Mon, 03 Nov 2025 16:06:56 -0500
X-MC-Unique: atorPHfvOLCRZ0f3TN8CVw-1
X-Mimecast-MFC-AGG-ID: atorPHfvOLCRZ0f3TN8CVw_1762204015
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4eb7853480dso142637911cf.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204015; x=1762808815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhjJNzKPxpxd3gxFiz0Oy6+Fp9aW0Nvlu5a+NjuZlkc=;
 b=qwJzE9u2RyjX7M4yeFgqGu2TXoTOPMQPI+rXhpn8/cK6nto8sC7vZV1qkAEYHrX5JN
 sOsKzf2Z79CUgipAJyL4vqLmAMHtrOH3OqnYeUSRXPeLIjd14r12uaMIlgmk81OWVEKx
 beZT63yNq4JRXnA1B1zA80NovujIwdASmgZ6lAAolPq3paRLDwY3+Iew5cR6DAUtkA76
 FL8cdRvFNjs1wY/+2wP4Fnefaa2AjZts6nd5vd8msbfrcb0cFK1l5l45boRUG8V6iqDR
 q6zqHxx1j1VUZ1e1gmQuBA+esOZFLwO7+ULIC8o3OueOoi4+3UiENlZpZD/hEfbz0jJE
 VWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204015; x=1762808815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhjJNzKPxpxd3gxFiz0Oy6+Fp9aW0Nvlu5a+NjuZlkc=;
 b=CGJL22aO0O2ySzCK5lDEkwAf5O7OES8YF7uvDl03HUwoUrL/RWXORpGAI/sIGv4k2Y
 qCvdcIHosI30DeKOu6xhiPnbjnX/TSRcqzxGViln72x7l+JUuYuy1E2E4jJdUd6Fx1GH
 cdIBhNPiIk5CQsjlEjZnvxtlog4ql1CLcDBG4ir89ku4dmENlW+ZncQG1YX5+oFnBLOy
 f/az9G25Ql7Wb4JlT2BRx5QQfajhdkUui/a7RWsc763LpWTsxbuiyBIqlGnPu2dIHtU0
 5NYnBMp7Zu/ZbEZQ6JwvXQVmaYfY49SvgRAvrR6JOlhPMGPpTpXE2q7NkdPEvsTvkCzR
 YYcw==
X-Gm-Message-State: AOJu0Yxp/kTCHQcE/q7Uevvy38Ofud7ISHwBrjHP1SNiIgtEwVTgQaPi
 kzlf04Okux7Tkw2GNjEjdZ8XmFVYaDF9qv+TuJf4Q+4n8sYhN1SHBW45d7GJDEEjpmSlCjQAqNo
 eB7eSJRt0hbSbgSaewdTyIA+QGkhgK7S3i/tiMJf2QrJ7Q8/j576imuwxdh/ky+ldpd6PMvECaF
 r3NJS1r/NQJybfMvt1kAZC7almf/Nc7GkoI/loFA==
X-Gm-Gg: ASbGnctEO7vn5ZZ3RdRLBS5xTMh/3ufwQ0vRIpj9iPERoyV35RdZccixI7xyZgiRIFB
 nklrztwzu/I1QsDcm6527U6QXxV9PdmUbMKmyVUHs7IDJ76KFW9gcZ6F52s9D3Xag+0vLPqAQZY
 cO8xv9rAMGpIzjfLy+8cNfFbMce7TTn1WtC0U59QzzoPOcvEbj9Kl61eMB6H82t14TED58UyT4L
 tZpHwRX6PWRgJSvICWzJk3EOsxF4CaHS/ZgmoCdIr+EdipaeZbjm5i0b5qntFQfiKIr73UG5Zmr
 dSFR1qPOXFDZw4h8wbXdImJmcNpBHSTK0Gv/CoQtaGmo3JBW3N5pAteLeXAxXXCh
X-Received: by 2002:a05:622a:4d94:b0:4ec:fc9a:17d3 with SMTP id
 d75a77b69052e-4ed30d91ad7mr211347961cf.13.1762204015301; 
 Mon, 03 Nov 2025 13:06:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHX3enG7P2mKCzY+QkCJzqE0vvLwqOJhkUb3DEtF0cPyLIkcoVxB+vP1K8J4mxH4xHz6+nCmA==
X-Received: by 2002:a05:622a:4d94:b0:4ec:fc9a:17d3 with SMTP id
 d75a77b69052e-4ed30d91ad7mr211347161cf.13.1762204014687; 
 Mon, 03 Nov 2025 13:06:54 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:53 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 18/36] migration: Use unsigned instead of int for bit set of
 MigMode
Date: Mon,  3 Nov 2025 16:06:07 -0500
Message-ID: <20251103210625.3689448-19-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Markus Armbruster <armbru@redhat.com>

Signed operands in bitwise operations are unwise.  I believe they're
safe here, but avoiding them is easy, so let's do that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251027064503.1074255-2-armbru@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4ed2a2e881..478c76bc25 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1672,9 +1672,9 @@ void migration_cancel(void)
     }
 }
 
-static int get_modes(MigMode mode, va_list ap);
+static unsigned get_modes(MigMode mode, va_list ap);
 
-static void add_notifiers(NotifierWithReturn *notify, int modes)
+static void add_notifiers(NotifierWithReturn *notify, unsigned modes)
 {
     for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
         if (modes & BIT(mode)) {
@@ -1687,7 +1687,7 @@ static void add_notifiers(NotifierWithReturn *notify, int modes)
 void migration_add_notifier_modes(NotifierWithReturn *notify,
                                   MigrationNotifyFunc func, MigMode mode, ...)
 {
-    int modes;
+    unsigned modes;
     va_list ap;
 
     va_start(ap, mode);
@@ -1876,7 +1876,7 @@ static bool is_busy(Error **reasonp, Error **errp)
     return false;
 }
 
-static bool is_only_migratable(Error **reasonp, Error **errp, int modes)
+static bool is_only_migratable(Error **reasonp, Error **errp, unsigned modes)
 {
     ERRP_GUARD();
 
@@ -1890,9 +1890,9 @@ static bool is_only_migratable(Error **reasonp, Error **errp, int modes)
     return false;
 }
 
-static int get_modes(MigMode mode, va_list ap)
+static unsigned get_modes(MigMode mode, va_list ap)
 {
-    int modes = 0;
+    unsigned modes = 0;
 
     while (mode != -1 && mode != MIG_MODE_ALL) {
         assert(mode >= MIG_MODE_NORMAL && mode < MIG_MODE__MAX);
@@ -1905,7 +1905,7 @@ static int get_modes(MigMode mode, va_list ap)
     return modes;
 }
 
-static int add_blockers(Error **reasonp, Error **errp, int modes)
+static int add_blockers(Error **reasonp, Error **errp, unsigned modes)
 {
     for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
         if (modes & BIT(mode)) {
@@ -1928,7 +1928,7 @@ int migrate_add_blocker_normal(Error **reasonp, Error **errp)
 
 int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
 {
-    int modes;
+    unsigned modes;
     va_list ap;
 
     va_start(ap, mode);
@@ -1945,7 +1945,7 @@ int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
 
 int migrate_add_blocker_internal(Error **reasonp, Error **errp)
 {
-    int modes = BIT(MIG_MODE__MAX) - 1;
+    unsigned modes = BIT(MIG_MODE__MAX) - 1;
 
     if (is_busy(reasonp, errp)) {
         return -EBUSY;
-- 
2.50.1


