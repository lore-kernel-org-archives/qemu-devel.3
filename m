Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831AFC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2tj-0000s0-Di; Tue, 12 Mar 2024 10:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2tH-0000cu-W3
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2t5-0002Bb-Ok
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710252831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FifKAvUbL64Bg1vJWQk8QWQL3zgV+zzzfE0KS8FRLG8=;
 b=Cw6ZPKSbGU2po7HCy/KuwUP4qmYIKZvjh27WKHsZYv4jnGV6iHOYXD6yFF9GEq5x7tnMWo
 NBQrwGhrCs81fCD+NFIU44ixy+UxZkPd/q/Iw5+oGIu47bGTSEI5y72ReJ5VSYqnHQbjXP
 RiVPw1ArUEVq4yTTcX/ylkBt8z2/Pxk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-y9WNXmlgMti35wH4wkYUvw-1; Tue,
 12 Mar 2024 10:13:46 -0400
X-MC-Unique: y9WNXmlgMti35wH4wkYUvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF37A3C0C898;
 Tue, 12 Mar 2024 14:13:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A3B340C6DAE;
 Tue, 12 Mar 2024 14:13:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3493221E6889; Tue, 12 Mar 2024 15:13:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	qemu-block@nongnu.org,
	philmd@linaro.org
Subject: [PATCH 05/10] qapi: Inline and remove QERR_INVALID_PARAMETER
 definition
Date: Tue, 12 Mar 2024 15:13:38 +0100
Message-ID: <20240312141343.3168265-6-armbru@redhat.com>
In-Reply-To: <20240312141343.3168265-1-armbru@redhat.com>
References: <20240312141343.3168265-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Address the comment added in commit 4629ed1e98
("qerror: Finally unused, clean up"), from 2015:

  /*
   * These macros will go away, please don't use
   * in new code, and do not add new ones!
   */

Mechanical transformation using:

  $ sed -i -e "s/QERR_INVALID_PARAMETER,/\"Invalid parameter '%s'\",/" \
    $(git grep -lw QERR_INVALID_PARAMETER)

Manually simplify qemu_opts_create(), and remove the macro definition
in include/qapi/qmp/qerror.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qerror.h |  3 ---
 qapi/opts-visitor.c       |  2 +-
 util/qemu-option.c        | 10 +++++-----
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index e93211085a..63ab775dc5 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_INVALID_PARAMETER \
-    "Invalid parameter '%s'"
-
 #define QERR_INVALID_PARAMETER_TYPE \
     "Invalid parameter type for '%s', expected: %s"
 
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 8f1efab8b9..3d1a28b419 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -184,7 +184,7 @@ opts_check_struct(Visitor *v, Error **errp)
         const QemuOpt *first;
 
         first = g_queue_peek_head(any);
-        error_setg(errp, QERR_INVALID_PARAMETER, first->name);
+        error_setg(errp, "Invalid parameter '%s'", first->name);
         return false;
     }
     return true;
diff --git a/util/qemu-option.c b/util/qemu-option.c
index eedd08929b..201f7a87f3 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -498,7 +498,7 @@ static bool opt_validate(QemuOpt *opt, Error **errp)
 
     desc = find_desc_by_name(list->desc, opt->name);
     if (!desc && !opts_accepts_any(list)) {
-        error_setg(errp, QERR_INVALID_PARAMETER, opt->name);
+        error_setg(errp, "Invalid parameter '%s'", opt->name);
         return false;
     }
 
@@ -531,7 +531,7 @@ bool qemu_opt_set_bool(QemuOpts *opts, const char *name, bool val,
 
     desc = find_desc_by_name(list->desc, name);
     if (!desc && !opts_accepts_any(list)) {
-        error_setg(errp, QERR_INVALID_PARAMETER, name);
+        error_setg(errp, "Invalid parameter '%s'", name);
         return false;
     }
 
@@ -554,7 +554,7 @@ bool qemu_opt_set_number(QemuOpts *opts, const char *name, int64_t val,
 
     desc = find_desc_by_name(list->desc, name);
     if (!desc && !opts_accepts_any(list)) {
-        error_setg(errp, QERR_INVALID_PARAMETER, name);
+        error_setg(errp, "Invalid parameter '%s'", name);
         return false;
     }
 
@@ -612,7 +612,7 @@ QemuOpts *qemu_opts_create(QemuOptsList *list, const char *id,
 
     if (list->merge_lists) {
         if (id) {
-            error_setg(errp, QERR_INVALID_PARAMETER, "id");
+            error_setg(errp, "Invalid parameter 'id'");
             return NULL;
         }
         opts = qemu_opts_find(list, NULL);
@@ -1103,7 +1103,7 @@ bool qemu_opts_validate(QemuOpts *opts, const QemuOptDesc *desc, Error **errp)
     QTAILQ_FOREACH(opt, &opts->head, next) {
         opt->desc = find_desc_by_name(desc, opt->name);
         if (!opt->desc) {
-            error_setg(errp, QERR_INVALID_PARAMETER, opt->name);
+            error_setg(errp, "Invalid parameter '%s'", opt->name);
             return false;
         }
 
-- 
2.44.0


