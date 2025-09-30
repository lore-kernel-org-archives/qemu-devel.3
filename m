Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DAACAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rrt-0005WV-QC; Tue, 30 Sep 2025 00:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3Rri-0005Im-Ka
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:21:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1v3RrU-00030T-Gu
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759206069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7E2F8u5zs4Z+kJC5tufhEPMgIkmP19mb8At5AdWAENo=;
 b=EfFf+cer+zV99uyeEgEKF9+1i2DTH/J9cogl79XibmutCKx4KKS+6RUucXr5cef310z6jb
 Id3J4/lu/Gf2g8cTU+jH3y0ZB5bk1M1wu5XMZC1l4S+Eahz/Z83IQO+UJ1P7cQ1zEOuA+I
 R8cJRROEpMtnJOIK8SXlhJK4nktI7DA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-gfY5FFPCMOeTdZTnzja23w-1; Tue, 30 Sep 2025 00:21:02 -0400
X-MC-Unique: gfY5FFPCMOeTdZTnzja23w-1
X-Mimecast-MFC-AGG-ID: gfY5FFPCMOeTdZTnzja23w_1759206062
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-76e2e60221fso7549520b3a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759206061; x=1759810861;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7E2F8u5zs4Z+kJC5tufhEPMgIkmP19mb8At5AdWAENo=;
 b=ok5wRPRU2ywIZWz5eLr+XSyqse86aWY5SLkNSHyklAQeYgfHg69Kxd0ZcNH4EocoPt
 nRZSKVf1BjBwqmqIJlYArrkCh+kkSgU1FeukmfUq1K4JPf8Oe/Ojqdla2xFOlzI2WubD
 k+VHcpLvGVvXCnYD9KqCokIPmReMS+1sGW9aoUnTog8KjQTmkt8viGG1whbVz/xsIKcH
 caInLhckOAGhyrfwJ1G/IlVlPm6V6s2HjT3xECxvOXwEFyTQPwESm569dEaudmMz9xu6
 PcflBplvYVdR6TCPR9JHI2PI1Me3Shnzn+meuchr59EMvPEpyj7wL5f/PX5UnnJI7sCh
 axzw==
X-Gm-Message-State: AOJu0YymOMYhQdOzHzbTFVdiOSelGv6QWNNP4bwhQ6cxEb5NkE0AIoa9
 RjUcJhcek+go1A0XmFJOyv8ig/BegZ1MrFVvPWU1sd1jINA3VuNnZ+KcvVdJZGGp0yz9VJkUdIQ
 tChT17oht8gJC+vy3lUmAZaLjmbIXT9CoAcPF+nRvY4aKziKlt/AIma1L
X-Gm-Gg: ASbGncuiuIY8HCxDgSrI0rEQ+gEWtfMaL8mcLI2qzh9fP67ofcyhFcrSJFYbgAOuH/6
 s6q3+EVmEfrITne4g9FhPMb/bWYV5gskz/SVOdsGUA4NzY4C5Md/Uyk42FRpxb4dzVguO3QrBii
 yMrUi+jwxHsDIZEQxAXkXug3JJIoConVmkPGZV50N9of+DoZcJlLwHyH29lrQM8It7/na5GxUnP
 MB2/feYScVkWCVsLXdmeFG1AUFJydsLKuZOmMF1qmJB7QwRUcgYekZv3JNLc3RtHo9XI76efRrr
 K/6uMtC8fiX414NqHd56llNpQqQDosvUJuHDZwn78B/IhC6D7q7a8ngRcA==
X-Received: by 2002:a05:6a20:72a5:b0:262:cbbc:3125 with SMTP id
 adf61e73a8af0-2e7c7cb732dmr23278372637.20.1759206061517; 
 Mon, 29 Sep 2025 21:21:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzuLhFqfzWOq9+8KCmwfRz/a36+f60xyoxDLtFkXkgMKoF5WgWl6eYXVdLvfeo8MCYz3DDZQ==
X-Received: by 2002:a05:6a20:72a5:b0:262:cbbc:3125 with SMTP id
 adf61e73a8af0-2e7c7cb732dmr23278341637.20.1759206061151; 
 Mon, 29 Sep 2025 21:21:01 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c55a339dsm12534158a12.40.2025.09.29.21.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 21:21:00 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 30 Sep 2025 09:48:24 +0530
Subject: [PATCH v15 15/26] migration: push Error **errp into
 loadvm_postcopy_handle_advise()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250930-propagate_tpm_error-v15-15-84afd3af1e47@redhat.com>
References: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
In-Reply-To: <20250930-propagate_tpm_error-v15-0-84afd3af1e47@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4941; i=armenon@redhat.com;
 h=from:subject:message-id; bh=dlnvqnVI5qyckz6xAuPiLSswmd3ev/2I/vPXJaIrl9Y=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8btKMGHl0RXHN92/f0PxoRljbfqjqZ+1PzlIxG2xe+6y
 WWbIGWHjlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABMJc2Vk+PtgxpftEnxnlsuk
 VW44fXpZ0Ua7HZ2v+e6sK6xl2hWou4eRYYXIfVO+S7PyVvUUitwLn8G89PyV1r3dKl2Xuzc2byp
 ZwwsA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 338d1a9756a991ace0a54f80b1003df33f141264..38e22b435b6b486982e75aed592f54dbf7b313b6 100644
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
+        error_setg(errp, "CMD_POSTCOPY_ADVISE in wrong postcopy state (%d)",
+                   ps);
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
+            error_setg(errp,
+                       "RAM postcopy is disabled but have 16 byte advise");
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
@@ -1967,9 +1967,10 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
          *      also fails when passed to an older qemu that doesn't
          *      do huge pages.
          */
-        error_report("Postcopy needs matching RAM page sizes (s=%" PRIx64
-                                                             " d=%" PRIx64 ")",
-                     remote_pagesize_summary, local_pagesize_summary);
+        error_setg(errp,
+                   "Postcopy needs matching RAM page sizes "
+                   "(s=%" PRIx64 " d=%" PRIx64 ")",
+                   remote_pagesize_summary, local_pagesize_summary);
         return -1;
     }
 
@@ -1979,17 +1980,18 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
          * Again, some differences could be dealt with, but for now keep it
          * simple.
          */
-        error_report("Postcopy needs matching target page sizes (s=%d d=%zd)",
-                     (int)remote_tps, page_size);
+        error_setg(errp,
+                   "Postcopy needs matching target page sizes (s=%d d=%zd)",
+                   (int)remote_tps, page_size);
         return -1;
     }
 
-    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, &local_err)) {
-        error_report_err(local_err);
+    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_ADVISE, errp)) {
         return -1;
     }
 
-    if (ram_postcopy_incoming_init(mis, NULL) < 0) {
+    if (ram_postcopy_incoming_init(mis, errp) < 0) {
+        error_prepend(errp, "Postcopy RAM incoming init failed: ");
         return -1;
     }
 
@@ -2617,11 +2619,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_handle_cmd_packaged(mis, errp);
 
     case MIG_CMD_POSTCOPY_ADVISE:
-        ret = loadvm_postcopy_handle_advise(mis, len);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_advise(mis, len, errp);
 
     case MIG_CMD_POSTCOPY_LISTEN:
         ret = loadvm_postcopy_handle_listen(mis);

-- 
2.51.0


