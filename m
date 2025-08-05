Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFEDEC87FD1
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 18:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMUt-0003Qz-CF; Tue, 05 Aug 2025 14:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMQZ-0000Y5-Kl
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMQX-0004Vh-Mf
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BYCferYL09XuJja4blhgOJzGeanLOkm2Lm1whjttfNc=;
 b=CENNEj9KLXTKPjwMdbT97oTUgen/gtR2Ady47u3xo2CwtYQmF0h5kJkNeB8chldXqZMLsU
 LAeTRcsh5b2cxmScmTogcl0xf5Xehxv2BI5TpGc8MQMt36imQbLX7ZJxritPkdqSBVIosu
 sP+eSoh+eLGiqT6ns0FsGbm5sULdw4w=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-OAlkYuwmNtGa2QGNIPubeg-1; Tue, 05 Aug 2025 14:30:20 -0400
X-MC-Unique: OAlkYuwmNtGa2QGNIPubeg-1
X-Mimecast-MFC-AGG-ID: OAlkYuwmNtGa2QGNIPubeg_1754418619
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-23ff7d61fb7so1069465ad.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418619; x=1755023419;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYCferYL09XuJja4blhgOJzGeanLOkm2Lm1whjttfNc=;
 b=Gt7073sz3hDfPo7cNL7nGFduWEET0B6vE8IH1ro+nEokquTBj9JVbe5tH69aUPiQzp
 Yv6fnoKFg07M8OJjiX1/4ygIY+nYxfpWSfzzNzj5DaLDoH7wiOsvGKdNpVEthZHBiTzM
 +j6z2d5vnI1LYKeJBYt0pvvEfXq+sMQhIUSlz3n+s90TGUHo16pNQGMliHheu/gDWURF
 oIB6s5cHZdxZpjSFxrt4374agTLwJXJG1Xc7TInUn6oZzvxRIRRdvuuB61XKrC4CWFEY
 SpCWshdiBgGt3COO4MKZOIwxRqZrnD6hCgfNOquEaRLBYU52BQD2YfA7IfqM4jBcjaQs
 o2rw==
X-Gm-Message-State: AOJu0YxoOPYxw3yeAl0dnycvj20hk3eKHJfLYIXjysfzbuS5Od5o6ekD
 Fk7Nac8sSeMNSoV2z88huBhsfDPKy3BQDp3C+SkxMQjf75WIf1Sa9HwJ1GByJP95oKdYtd3nHb5
 CcsSVHEJc5FHwfHEnLeYBX+3sMNSuAoUL2AcPGjZh5B8gvWLSY3bzN8Hp
X-Gm-Gg: ASbGncvtRxnLzOt7fMo3SCBGftlfLnwDtKSUQ/08PASd7YwTsIZ7C+APWsS8ZynbOhT
 /J66wnZSIBUYwlZ1K8M2RKQeQakuAar+k4MmigvySvuovz1WpPxKHMpB59OO4cEGTzoxjf/MUnp
 DC8xyXSRvdwhNt21E3jUpwEOcb4bo9dBJQb9oBThPbyvnvcj1iysmLoPPXlZNrZy5WNxcMxEQ5l
 7I9TSPX12qH9EpUTtjS76ScVU/rq+yR2ycM/STVSRL1aiaWppYB7dnXkg9vicTS7XVmuuY8Kujr
 7k6NF+KbggDa2r8bhaJhrOUxC4Fyp5U9iGt/EcQkbx4qtwg0TA==
X-Received: by 2002:a17:902:dac8:b0:234:325:500b with SMTP id
 d9443c01a7336-24288d80885mr68800845ad.22.1754418618713; 
 Tue, 05 Aug 2025 11:30:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhNndj+wfBMyAGjFCSv3umrVj9yWadHo51Xgpct0Trd8bzyfBfoa4jAvB5Au4M6MnBklTy4w==
X-Received: by 2002:a17:902:dac8:b0:234:325:500b with SMTP id
 d9443c01a7336-24288d80885mr68800125ad.22.1754418618232; 
 Tue, 05 Aug 2025 11:30:18 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:30:17 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:23 +0530
Subject: [PATCH v9 16/27] migration: push Error **errp into
 loadvm_postcopy_handle_listen()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-propagate_tpm_error-v9-16-123450810db7@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705; i=armenon@redhat.com;
 h=from:subject:message-id; bh=5oWKBYenn0vD7FEJiTk64CwReR83CUuCjtL+Yg9mJQo=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkX5ngjENviqsW13D1njNLeaCyQrPV5JlSgt+GvZqHT
 mRJzW3rKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMJFn3xkZrs9f0l33UrNn5bGt
 C3m/Sb2welipzfBeoTTtjlLezLWH+BkZbka9feekmBcU43Za+sCVQ7KJNSutHlUq/1pl/uqkgyI
 LMwA=
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_listen() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 09b9da6c58dda6e062a9a22bafd3487d38295f22..be77da66d813392625c6d701b24d1bcffe26cdce 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2181,15 +2181,16 @@ static void *postcopy_ram_listen_thread(void *opaque)
 }
 
 /* After this message we must be able to immediately receive postcopy data */
-static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
+static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis,
+                                         Error **errp)
 {
     PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_LISTENING);
-    Error *local_err = NULL;
 
     trace_loadvm_postcopy_handle_listen("enter");
 
     if (ps != POSTCOPY_INCOMING_ADVISE && ps != POSTCOPY_INCOMING_DISCARD) {
-        error_report("CMD_POSTCOPY_LISTEN in wrong postcopy state (%d)", ps);
+        error_setg(errp,
+                   "CMD_POSTCOPY_LISTEN in wrong postcopy state (%d)", ps);
         return -1;
     }
     if (ps == POSTCOPY_INCOMING_ADVISE) {
@@ -2212,14 +2213,14 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     if (migrate_postcopy_ram()) {
         if (postcopy_ram_incoming_setup(mis)) {
             postcopy_ram_incoming_cleanup(mis);
+            error_setg(errp, "Failed to setup incoming postcopy RAM blocks");
             return -1;
         }
     }
 
     trace_loadvm_postcopy_handle_listen("after uffd");
 
-    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_LISTEN, &local_err)) {
-        error_report_err(local_err);
+    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_LISTEN, errp)) {
         return -1;
     }
 
@@ -2622,11 +2623,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_advise(mis, len, errp);
 
     case MIG_CMD_POSTCOPY_LISTEN:
-        ret = loadvm_postcopy_handle_listen(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_listen(mis, errp);
 
     case MIG_CMD_POSTCOPY_RUN:
         ret = loadvm_postcopy_handle_run(mis);

-- 
2.50.1


