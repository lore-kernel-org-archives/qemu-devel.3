Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85185C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 17:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmHEU-0000U8-Lc; Mon, 18 Mar 2024 13:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmHET-0000Tr-Tn
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmHER-00077e-VJ
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 13:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710784627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pyDG1697yNmOLATZpCsmYF7vOjj017X+KxrJDV4ddsk=;
 b=LK1OM9LMSdoki4h6/YpiJX1QccmzUwzOlvuTJqaCjLoOE+GenU+/0cFcAPzdOJXlPI7PXc
 zpKGDTjMnk4ahCr5ksD19Fl8tFObWEazErF370DYfklczpPG9LbOEyGIMLqCl2oJ3tH+fE
 O9z6CwshrasB8Bln1Q0kwHb0ft0q6mU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-Kv3nalYPMsGJLiyH9nYbMw-1; Mon, 18 Mar 2024 13:57:05 -0400
X-MC-Unique: Kv3nalYPMsGJLiyH9nYbMw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51ACD800262;
 Mon, 18 Mar 2024 17:57:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 489172166B34;
 Mon, 18 Mar 2024 17:57:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PULL 2/4] target/s390x: improve cpu compatibility check error message
Date: Mon, 18 Mar 2024 18:56:53 +0100
Message-ID: <20240318175655.756084-3-thuth@redhat.com>
In-Reply-To: <20240318175655.756084-1-thuth@redhat.com>
References: <20240318175655.756084-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
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

From: Claudio Fontana <cfontana@suse.de>

some users were confused by this message showing under TCG:

 Selected CPU generation is too new. Maximum supported model
 in the configuration: 'xyz'

Clarify that the maximum can depend on the accel, and add a
hint to try a different one.

Also add a hint for features mismatch to suggest trying
different accel, QEMU and kernel versions.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
Message-ID: <20240314213746.27163-1-cfontana@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_models.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 1a1c096122..8ed3bb6a27 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -500,6 +500,16 @@ static void error_prepend_missing_feat(const char *name, void *opaque)
     error_prepend((Error **) opaque, "%s ", name);
 }
 
+static void check_compat_model_failed(Error **errp,
+                                      const S390CPUModel *max_model,
+                                      const char *msg)
+{
+    error_setg(errp, "%s. Maximum supported model in the current configuration: \'%s\'",
+               msg, max_model->def->name);
+    error_append_hint(errp, "Consider a different accelerator, try \"-accel help\"\n");
+    return;
+}
+
 static void check_compatibility(const S390CPUModel *max_model,
                                 const S390CPUModel *model, Error **errp)
 {
@@ -507,15 +517,11 @@ static void check_compatibility(const S390CPUModel *max_model,
     S390FeatBitmap missing;
 
     if (model->def->gen > max_model->def->gen) {
-        error_setg(errp, "Selected CPU generation is too new. Maximum "
-                   "supported model in the configuration: \'%s\'",
-                   max_model->def->name);
+        check_compat_model_failed(errp, max_model, "Selected CPU generation is too new");
         return;
     } else if (model->def->gen == max_model->def->gen &&
                model->def->ec_ga > max_model->def->ec_ga) {
-        error_setg(errp, "Selected CPU GA level is too new. Maximum "
-                   "supported model in the configuration: \'%s\'",
-                   max_model->def->name);
+        check_compat_model_failed(errp, max_model, "Selected CPU GA level is too new");
         return;
     }
 
@@ -537,7 +543,9 @@ static void check_compatibility(const S390CPUModel *max_model,
     error_setg(errp, " ");
     s390_feat_bitmap_to_ascii(missing, errp, error_prepend_missing_feat);
     error_prepend(errp, "Some features requested in the CPU model are not "
-                  "available in the configuration: ");
+                  "available in the current configuration: ");
+    error_append_hint(errp,
+                      "Consider a different accelerator, QEMU, or kernel version\n");
 }
 
 S390CPUModel *get_max_cpu_model(Error **errp)
-- 
2.44.0


