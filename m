Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D3BC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 07:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1hgZ-0000gX-Dr; Tue, 30 Apr 2024 03:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgX-0000ft-6y
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s1hgV-0008KN-Jb
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 03:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714461229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdLJtnnBUhlH4Hg2RgfhCtZNPihs/eo7ypmIUozuepg=;
 b=Dy9QWuNuUzE/JxjNu2JnnlCcHJljzGdm0x3BIv75bu/w9vpr6fuMOnawXaMN10A7WVscrL
 gq9eL5ExOQ66eSbsxt+DTNutJe/QW+jq6OjIRwAtUlWGoEbJJUabwjScw3schwGSNSP1Vb
 jk0oOgbT//i7AdoxbQqp3lUa6iWcJG4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-6XWsu6cyMW6uKGx_QtNOKQ-1; Tue, 30 Apr 2024 03:13:44 -0400
X-MC-Unique: 6XWsu6cyMW6uKGx_QtNOKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EA27800CA2;
 Tue, 30 Apr 2024 07:13:44 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5235440C6CC0;
 Tue, 30 Apr 2024 07:13:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 01/19] target/s390x/cpu_model: Make check_compatibility()
 return boolean
Date: Tue, 30 Apr 2024 09:13:22 +0200
Message-ID: <20240430071340.413305-2-thuth@redhat.com>
In-Reply-To: <20240430071340.413305-1-thuth@redhat.com>
References: <20240430071340.413305-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

From: Zhao Liu <zhao1.liu@intel.com>

As error.h suggested, the best practice for callee is to return
something to indicate success / failure.

With returned boolean, there's no need to check @err.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240425031232.1586401-2-zhao1.liu@intel.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_models.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 8ed3bb6a27..8cb47d905f 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -510,7 +510,7 @@ static void check_compat_model_failed(Error **errp,
     return;
 }
 
-static void check_compatibility(const S390CPUModel *max_model,
+static bool check_compatibility(const S390CPUModel *max_model,
                                 const S390CPUModel *model, Error **errp)
 {
     ERRP_GUARD();
@@ -518,11 +518,11 @@ static void check_compatibility(const S390CPUModel *max_model,
 
     if (model->def->gen > max_model->def->gen) {
         check_compat_model_failed(errp, max_model, "Selected CPU generation is too new");
-        return;
+        return false;
     } else if (model->def->gen == max_model->def->gen &&
                model->def->ec_ga > max_model->def->ec_ga) {
         check_compat_model_failed(errp, max_model, "Selected CPU GA level is too new");
-        return;
+        return false;
     }
 
 #ifndef CONFIG_USER_ONLY
@@ -530,14 +530,14 @@ static void check_compatibility(const S390CPUModel *max_model,
         error_setg(errp, "The unpack facility is not compatible with "
                    "the --only-migratable option. You must remove either "
                    "the 'unpack' facility or the --only-migratable option");
-        return;
+        return false;
     }
 #endif
 
     /* detect the missing features to properly report them */
     bitmap_andnot(missing, model->features, max_model->features, S390_FEAT_MAX);
     if (bitmap_empty(missing, S390_FEAT_MAX)) {
-        return;
+        return true;
     }
 
     error_setg(errp, " ");
@@ -546,6 +546,7 @@ static void check_compatibility(const S390CPUModel *max_model,
                   "available in the current configuration: ");
     error_append_hint(errp,
                       "Consider a different accelerator, QEMU, or kernel version\n");
+    return false;
 }
 
 S390CPUModel *get_max_cpu_model(Error **errp)
@@ -605,8 +606,7 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
     cpu->model->cpu_ver = max_model->cpu_ver;
 
     check_consistency(cpu->model);
-    check_compatibility(max_model, cpu->model, &err);
-    if (err) {
+    if (!check_compatibility(max_model, cpu->model, &err)) {
         error_propagate(errp, err);
         return;
     }
-- 
2.44.0


