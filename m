Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14427C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udolc-0005TN-BI; Mon, 21 Jul 2025 07:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udojj-0001Qs-HQ
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udoje-000113-4Z
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YNAFut7yfNqps0+AcxOkC9eFiWKbZwZH5geqoaKzyjg=;
 b=Em1VNweyuBiqhg1lDVKttOE28y5EyJ4MjTlcFq2XY57gVi6cNznz05jTyEcPloX6zJuDhh
 ILvvlLFnS8HFSZs8wMNbh13c1331vBQG+HRqfT059xJNvrhKG5CZ6cYqOLU5aToUyyKkn9
 YbV8EKKTxbzvEwiRkZCdhHYmoKikijs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-uN4lpQUyOCOyLTgXV55nlA-1; Mon, 21 Jul 2025 07:31:06 -0400
X-MC-Unique: uN4lpQUyOCOyLTgXV55nlA-1
X-Mimecast-MFC-AGG-ID: uN4lpQUyOCOyLTgXV55nlA_1753097466
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2382607509fso28891775ad.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097466; x=1753702266;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YNAFut7yfNqps0+AcxOkC9eFiWKbZwZH5geqoaKzyjg=;
 b=jsgzODc+IawYNJ1r4NsxIrh8SIKjZk5m0ziDgeD2HJ8gVMGZasQ1SbUXqQPzDq/3VM
 mGD0LB4ncV0O7NKUBuQm3LKj6rSC0KJ/KXFaxYpHKVYzGnYbBTAgJy797IoSgpbe672Y
 GY5RXpHPkGRdGViNS4wKZ+Kms3ZOtorKpZFolR/BhDrNlqAkjJpzK7Dc8SIPenKUV0d7
 ALhRCjjboB8lf0TFASuJXoOwxWWlWKLs/Al9HAqMzhcBJbjTtrKQQfz1CwROgp/h+L7h
 GBvMr1ovXc5VKNhPaqfQWxHi9fFwEk/arP9zr+MaiH1kEMzS8309wMYnhHej9/TEPWw0
 KajA==
X-Gm-Message-State: AOJu0Yxuf5Fku7XNbITZY730fXgsx6XH4IyKY1+hIgu0PYn3L/lqYi8N
 VRPvXWFVFWU8PoB12yaI2TwNgUUa/2ONBPN3BERvxBgM53q7MGxmdkF0BHwrkhXuyu7b2/xPwVX
 JOrWVuY/tXdfIds7bkxSkAfeXMHGmfI8I1rabEjz/vGYGjYQ8jxbQiebU
X-Gm-Gg: ASbGncuGg4lCvj7hipGCaQq8ZAeZ22a9/GG/MQf5y2bd/CFZ2brFWwwEZHx5Q59AcrT
 P841xCYUyS5f1GkX8SCDL0HxVbiie2AI8gxXqh7G6Jd/qMZDKx8R3Yd2Sk2rRVqyKEptE+14pUv
 po//tPD5IQiXTp1BfT2MLw290OnOlZQV7MM3NTdW/+Hdvuw+HvO3d8w33PjdQ1WlOEYeIL9Wabv
 hDqOBxp00ckZcUCcnTSLKPhgXcqOmc/4LQ3+wozf1mHD2z4Pn7MkPGlIHdcSn4VftrTgmS1K3xu
 k48ePN7ZeXuiRLRBTwcCArT8YBO+LIixfvp7PTBVUe39AF/PA/ks
X-Received: by 2002:a17:903:15cc:b0:236:93cb:48b with SMTP id
 d9443c01a7336-23e24f59db4mr317664225ad.44.1753097465558; 
 Mon, 21 Jul 2025 04:31:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY9kROTtd0hJCzwz1CZgjMQ4tc66qjE8Q1+uLGQ077NWlYkMfc7ESAgnK5BGrNzzp+hcB6kg==
X-Received: by 2002:a17:903:15cc:b0:236:93cb:48b with SMTP id
 d9443c01a7336-23e24f59db4mr317663785ad.44.1753097465098; 
 Mon, 21 Jul 2025 04:31:05 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:31:04 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:16 +0530
Subject: [PATCH v6 11/24] migration: push Error **errp into
 loadvm_postcopy_handle_advise()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250721-propagate_tpm_error-v6-11-fef740e15e17@redhat.com>
References: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
In-Reply-To: <20250721-propagate_tpm_error-v6-0-fef740e15e17@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4718; i=armenon@redhat.com;
 h=from:subject:message-id; bh=nhi7k9oAh5EbIvIrP4ZKuTJmCX5yAb6B9YERtNQPqxI=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adykTr/U2BIcLBP/pmmmT/snavmrC074BC6FKOxP9H9
 DZaJr3tKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMBE+BkaG3cced8wucFO+P8WF
 a4Gk+o2NiTemPfZNX7NmpUj5hjUXjBgZPn+aUuv6J7h+74sL7L0+51dF/GJ3jNZNrdh3zV7pxvI
 YfgA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 6b8c78bfb9bde2a8e7500b0342cd386b0d12db97..4a3db9498678a19597257e683029cd3f6c8d1a65 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1912,39 +1912,39 @@ enum LoadVMExitCodes {
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
@@ -1967,9 +1967,9 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
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
 
@@ -1979,17 +1979,17 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
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
 
-    if (ram_postcopy_incoming_init(mis, NULL) < 0) {
+    if (ram_postcopy_incoming_init(mis, errp) < 0) {
+        error_prepend(errp, "PostCopy RAM incoming init failed ");
         return -1;
     }
 
@@ -2618,12 +2618,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
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


