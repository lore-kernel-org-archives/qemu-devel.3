Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55BCBC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHQ0-00061D-Qd; Fri, 25 Jul 2025 08:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHPz-0005tn-7w
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHPw-0000PK-O4
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:20:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753446050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eYCXjqKbzQhBCx+qwIREYr6YTNEf1TybMl8PW/ML5xs=;
 b=WcRo+bP+3HQSw7Xh00eTmwVDMWVmxhXrtEeV0HNpgL22GVt6fa2qrQUFpn091JiUzleSPU
 zKy4M3SHAA/rB7/ECdcgSefueis79ub5TNq2+g+HiKey9vR027V6OmHNetj09Y01TXKjOw
 jYKB47tX8B9LrlNhwWhHDLbrdb967+4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-CEgZ28NaNZCj0Bf2HNXotQ-1; Fri, 25 Jul 2025 08:20:49 -0400
X-MC-Unique: CEgZ28NaNZCj0Bf2HNXotQ-1
X-Mimecast-MFC-AGG-ID: CEgZ28NaNZCj0Bf2HNXotQ_1753446048
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3138c50d2a0so3193230a91.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753446048; x=1754050848;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eYCXjqKbzQhBCx+qwIREYr6YTNEf1TybMl8PW/ML5xs=;
 b=NNuKcAATVcpBXS1UBaCGkEoj+qNl8UkUoUS7KvG534yrlAPAf0FUWl087t1FKS/ZYZ
 zmCUok3Tjvao+Lul1nAZIbE9RXvUw43frJqV36QQgh0oCVYVucm6hMdc0Z9x3UQ6//z+
 o5uBc68xDf5hoeivqv/6J1GR3CKI0POzMXFMxy0FVifJZRDoiQD0TXYDg6oT09HKrt9Y
 7HTp5gHnsHy6B9vPkcGlO4kP0ts9NXX2GDsgmCuB9PKnTLmB6Ex0KOQAlfcpEMADSTww
 IzuDDZ4aaCJkXLKrkyupL9o4mv4dv9e2KMKwfMAXDrOtoemq96jrVxEeVQinEM7/yb3V
 uzvQ==
X-Gm-Message-State: AOJu0YxdEOvuwkcjqei7Qx2zw3EgnITkSHFx79MvxK3WJJCJyPz28Fry
 4J1kgMISc07DEibQ6SxOs4YK9t9THEyu+MUhetzY73pLGQ3RlFxFceucq4F6gZjHPuUjoOESqcs
 x9u3QMLipV/bRWLA4r71zYrXr6bK4TOmOw51KDi3Io3D+8h0SOVoLeyr/
X-Gm-Gg: ASbGnct1dX52J94Rb5PeKLyGo3Tw6Xm5TG7tjjW+09uhJRsE/g0RwPZ1B0OPXmcY6Dt
 6Oqq3DwgbE0teAZykkoi/wlcQX/Et+IEmPPD7gc7YYEOgLLW+YtENJqj4euHUBimG/0ui78DMYs
 dUpyv2i0G3ZYjh/asaMN3cjVt6gUMG/v22kX+ecwJ+qcwVlwwR5mBfUqJE73uqABL4CUqBWknLY
 2hm6Of0gFOcxv+BEP0Nj4CyCC4GgOUJnP+1jgCSySXBcRckVNc09h6qoScALGfl0PvI1LqCOogN
 vj1Be1g3kUpfCX7jIbOP5i7uXeuyEw0NEilFKFJwAe+b9PWzJWD8RA==
X-Received: by 2002:a17:90b:580f:b0:311:e8cc:4253 with SMTP id
 98e67ed59e1d1-31e777311ecmr2713378a91.2.1753446048111; 
 Fri, 25 Jul 2025 05:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyP016xVRhhTMLaObJR1NuVzvtgvqot27JGPJaeCTtUFxkKKoRJIcWKy1YdU9hqE9jFBPTlw==
X-Received: by 2002:a17:90b:580f:b0:311:e8cc:4253 with SMTP id
 98e67ed59e1d1-31e777311ecmr2713323a91.2.1753446047600; 
 Fri, 25 Jul 2025 05:20:47 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:20:47 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:51 +0530
Subject: [PATCH v7 12/24] migration: push Error **errp into
 loadvm_postcopy_handle_advise()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250725-propagate_tpm_error-v7-12-d52704443975@redhat.com>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
In-Reply-To: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4729; i=armenon@redhat.com;
 h=from:subject:message-id; bh=84WGABXCs2l6+smiYTyqOV5o0vuU+d8VFTg+EEJdDHw=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Zzmc5Wg/Ck96/XulvGLIhLdOWVFOGMyz/8qFSt7Xqx1
 /oDpww7SlkYxLgYZMUUWRq+Bsg2BRRGRNq+vA4zh5UJZAgDF6cATOSsGsM/PZ9F6lxeKvacp8/Z
 7PjyomplqfQyJm2hgFsPxV2ZI1asZ/gfNztPzG3C+pcH7mQsmqi3+XnFCf4XPKfNdFynW/0t2Xm
 NFwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 60a055f3e1f248b09e5e5d721f14d2eeafd0a7ad..eb843f4869f7b49a17fe0fb1b0e36db993e4024e 100644
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
2.50.0


