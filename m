Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAE4C83F22
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzgd-00054w-Mn; Wed, 16 Jul 2025 06:48:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzd3-0007YC-Vh
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:44:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzd1-0000OC-QP
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RH4zQZiGob42B10sEjomhzjaGX20xtgTQZfiov8CeCc=;
 b=GQE36lAPEq82txFDqT5km5NDLoJiWUVDddKDZEB9+ogBn7stKwbFWbaNw/VWJvMtjDo5ZT
 WuU+/n56Yt1NvWUijdG+6kfy9BkTkw5uMUQAE5tAeBV7U0bkBfuuUgAMdUOK6mXxNaDncN
 0BmcP1zYAygzji5FxlhUb7ioIDeqt6w=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-jBClhl-7Ngmi0-t6mK-8PQ-1; Wed, 16 Jul 2025 06:44:45 -0400
X-MC-Unique: jBClhl-7Ngmi0-t6mK-8PQ-1
X-Mimecast-MFC-AGG-ID: jBClhl-7Ngmi0-t6mK-8PQ_1752662685
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-235e3f93687so93256835ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662685; x=1753267485;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RH4zQZiGob42B10sEjomhzjaGX20xtgTQZfiov8CeCc=;
 b=WCVQ81LKgU+FI9uYoce6Y7Nxj6X6tSjninHSr7nbRuENhtXdA8j5GOOXQltuJDOqH7
 I1vs+XuYfivZpPCZSrZI3c/gjIx4ePtp1n233Y0qj/S8uhoVhNgHQpqbFd4ihwnJPlt8
 a9o9tzZ+rYBS0PUfUK36p4Ps0jjX0bXXTWitE5AVG/kLd9vHlbSlK3lwpi5lXdawvX1u
 e/GqgCGkrGK4RfUVyi73qUiIi9DyEtpjX5qDSyTopm5wOzvbnSUv51luNuUkch/3QyC6
 B6qJhxABOoAJeyqmJad11jifwhdRRHEfTxaFibS9ZLoLhinPwux/LsSC1ZCSRHvzP6EV
 YJpw==
X-Gm-Message-State: AOJu0Yy/KRz2eSR0H3ltOImsf+DtFUlP8468Yu3ie6exAAuUFoxQU0mw
 Nk4GsD1P8wlTo+v8i1pxTz3YHhXU/ahOUi7XsX0Y4MyMk7aRNWHaBwzsVeKk1BwpUHyaBPzTLdC
 Y2rg+6qX3+SdW7ek6+yOWaL9nCpAS+tDqeagFPhsXTkgq3NrwxjF4MCfe
X-Gm-Gg: ASbGncur8p3xcMPUZDroo7ef2K4gBnwzv9ClAOnMJHThJasdudzYCXQsbm+9n4UYo3S
 5wzXlNFfhT6o23I+WqHrMxX3MujI6w0xL4GkWEssPS+zFCvvYWKuTffit0lkJje+kJjoMlxoOrA
 Yp5LMeVSaL1T31BFWob7hCGlEMEY8Hufl3ovgHTt5BzRKSQ8zqfj77Nnp4vyHjOVufJ7Z43dVP1
 jtHCHU+ls2wdOnuokrVdQysPY/S/w2wzvsmHVBJnHlIiVm1NkBUncfmMYYezpBwLt8ySwg6wQlI
 BKAhqlCxmFHharWCvXlsikbujLyLbba6sVVfEruI0USO3ykvVQ==
X-Received: by 2002:a17:903:238e:b0:236:9402:a622 with SMTP id
 d9443c01a7336-23e2572ab4amr35627175ad.34.1752662684558; 
 Wed, 16 Jul 2025 03:44:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSCKfLrM8lhiLTWa/HyEulMZZasYUmYtxG4re9rnFpl7UWkYOHSXd0Kcsm076mFtAE2daJuA==
X-Received: by 2002:a17:903:238e:b0:236:9402:a622 with SMTP id
 d9443c01a7336-23e2572ab4amr35626685ad.34.1752662684035; 
 Wed, 16 Jul 2025 03:44:44 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:44:43 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:13:00 +0530
Subject: [PATCH v4 10/23] migration: push Error **errp into
 loadvm_postcopy_handle_advise()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-10-7141902077c0@redhat.com>
References: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
In-Reply-To: <20250716-propagate_tpm_error-v4-0-7141902077c0@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4720; i=armenon@redhat.com;
 h=from:subject:message-id; bh=jbKi25fcp5mQkx8LZiyzURjPs2y0Xokq93tE8MZBNOY=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k73vy6ZyZcGDDKqPai907ndZNuPLY65nQstFpzz8H
 KWn1tXeUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCLy8gz/g09bixRdkN7+6Z+J
 TcPivPP/p2/ziylgneC6mu2lEsuUG4wM99+8P86Xc+Pns4jiJRJFC1nWBoWHSGwv5eKv4Nj8c6I
 mMwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_advise() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 4abb3d8c84ee29de60912b4d5890074a39e87704..24ec721587564fa0432882d86bd5f71161f0aee9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1906,39 +1906,39 @@ enum LoadVMExitCodes {
  * quickly.
  */
 static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
-                                         uint16_t len)
+                                         uint16_t len, Error **errp)
 {
     PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_ADVISE);
     uint64_t remote_pagesize_summary, local_pagesize_summary, remote_tps;
     size_t page_size = qemu_target_page_size();
-    Error *local_err = NULL;
 
     trace_loadvm_postcopy_handle_advise();
     if (ps != POSTCOPY_INCOMING_NONE) {
-        error_report("CMD_POSTCOPY_ADVISE in wrong postcopy state (%d)", ps);
+        error_setg(errp, "CMD_POSTCOPY_ADVISE in wrong postcopy "
+                   "state (%d)", ps);
         return -1;
     }
 
     switch (len) {
     case 0:
         if (migrate_postcopy_ram()) {
-            error_report("RAM postcopy is enabled but have 0 byte advise");
+            error_setg(errp, "RAM postcopy is enabled but have 0 byte advise");
             return -EINVAL;
         }
         return 0;
     case 8 + 8:
         if (!migrate_postcopy_ram()) {
-            error_report("RAM postcopy is disabled but have 16 byte advise");
+            error_setg(errp, "RAM postcopy is disabled but have 16 "
+                       "byte advise");
             return -EINVAL;
         }
         break;
     default:
-        error_report("CMD_POSTCOPY_ADVISE invalid length (%d)", len);
+        error_setg(errp, "CMD_POSTCOPY_ADVISE invalid length (%d)", len);
         return -EINVAL;
     }
 
-    if (!postcopy_ram_supported_by_host(mis, &local_err)) {
-        error_report_err(local_err);
+    if (!postcopy_ram_supported_by_host(mis, errp)) {
         postcopy_state_set(POSTCOPY_INCOMING_NONE);
         return -1;
     }
@@ -1961,9 +1961,9 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
          *      also fails when passed to an older qemu that doesn't
          *      do huge pages.
          */
-        error_report("Postcopy needs matching RAM page sizes (s=%" PRIx64
-                                                             " d=%" PRIx64 ")",
-                     remote_pagesize_summary, local_pagesize_summary);
+        error_setg(errp, "Postcopy needs matching RAM "
+                   "page sizes (s=%" PRIx64 " d=%" PRIx64 ")",
+                   remote_pagesize_summary, local_pagesize_summary);
         return -1;
     }
 
@@ -1973,18 +1973,17 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
          * Again, some differences could be dealt with, but for now keep it
          * simple.
          */
-        error_report("Postcopy needs matching target page sizes (s=%d d=%zd)",
-                     (int)remote_tps, page_size);
+        error_setg(errp, "Postcopy needs matching target "
+                   "page sizes (s=%d d=%zd)", (int)remote_tps, page_size);
         return -1;
     }
 
-    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, &local_err)) {
-        error_report_err(local_err);
+    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, errp)) {
         return -1;
     }
 
-    if (ram_postcopy_incoming_init(mis, NULL)) {
-        error_setg(errp, "PostCopy RAM incoming init failed");
+    if (ram_postcopy_incoming_init(mis, errp)) {
+        error_prepend(errp, "PostCopy RAM incoming init failed ");
         return -1;
     }
 
@@ -2619,12 +2618,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_handle_cmd_packaged(mis, errp);
 
     case MIG_CMD_POSTCOPY_ADVISE:
-        ret = loadvm_postcopy_handle_advise(mis, len);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        return loadvm_postcopy_handle_advise(mis, len, errp);
 
     case MIG_CMD_POSTCOPY_LISTEN:
         ret = loadvm_postcopy_handle_listen(mis);

-- 
2.50.0


