Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1608C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezSk-0004Oj-U4; Tue, 27 Feb 2024 10:33:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rezSb-0004IU-Ch
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:33:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rezSU-0005HU-Ka
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709048007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w97dCBrvpjqTDvUM76J/eMQk/Qlr2Rs024e5lcrEDOk=;
 b=f4G+iZzbK+Fhv28ohjec+KqScXSDEwzBQVPatdf0KksLm/8wcQQICulV9QGiPnFnmayrUW
 c2Bq8akefCmubxjYHTDnFwSOXN4dEzFBHmbUC6+ZTuzXKE0iT5nTopjdepJ1gNnjtLtAhZ
 bTn14DfsJyjLG9fNidm9WzUMIVc30HU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-urU1QP7AM8uBba1tM5y-2g-1; Tue,
 27 Feb 2024 10:33:23 -0500
X-MC-Unique: urU1QP7AM8uBba1tM5y-2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DE743C2E0A0;
 Tue, 27 Feb 2024 15:33:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09A6A20229A7;
 Tue, 27 Feb 2024 15:33:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0363F21E6682; Tue, 27 Feb 2024 16:33:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: steven.sistare@oracle.com, philmd@linaro.org, dave@treblig.org,
 jasowang@redhat.com, michael.roth@amd.com, peterx@redhat.com,
 farosas@suse.de,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v7 2/3] qapi: New strv_from_str_list()
Date: Tue, 27 Feb 2024 16:33:20 +0100
Message-ID: <20240227153321.467343-3-armbru@redhat.com>
In-Reply-To: <20240227153321.467343-1-armbru@redhat.com>
References: <20240227153321.467343-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/type-helpers.h |  8 ++++++++
 qapi/qapi-type-helpers.c    | 14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/qapi/type-helpers.h b/include/qapi/type-helpers.h
index be1f181526..fc8352cdec 100644
--- a/include/qapi/type-helpers.h
+++ b/include/qapi/type-helpers.h
@@ -12,3 +12,11 @@
 #include "qapi/qapi-types-common.h"
 
 HumanReadableText *human_readable_text_from_str(GString *str);
+
+/*
+ * Produce and return a NULL-terminated array of strings from @list.
+ * The result is g_malloc()'d and all strings are g_strdup()'d.  It
+ * can be freed with g_strfreev(), or by g_auto(GStrv) automatic
+ * cleanup.
+ */
+char **strv_from_str_list(const strList *list);
diff --git a/qapi/qapi-type-helpers.c b/qapi/qapi-type-helpers.c
index f76b34f647..266da013ad 100644
--- a/qapi/qapi-type-helpers.c
+++ b/qapi/qapi-type-helpers.c
@@ -21,3 +21,17 @@ HumanReadableText *human_readable_text_from_str(GString *str)
 
     return ret;
 }
+
+char **strv_from_str_list(const strList *list)
+{
+    const strList *tail;
+    int i = 0;
+    char **strv = g_new(char *, QAPI_LIST_LENGTH(list) + 1);
+
+    for (tail = list; tail != NULL; tail = tail->next) {
+        strv[i++] = g_strdup(tail->value);
+    }
+    strv[i] = NULL;
+
+    return strv;
+}
-- 
2.43.0


