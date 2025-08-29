Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83049CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNdy-0002QI-4K; Sat, 30 Aug 2025 11:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5MT-00060i-AZ
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:06:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5MR-00055V-IQ
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756497970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Za1NNvSl7uFr3wDIymXqGWcBuLkcyiqwtqIRxvI2IEk=;
 b=BsqtvSMeTuAsEBI3iFuXXSa6fwb1vhNv8fQTcS/1CdKEyhS+DuTQrXG8ia6sxWCZDRVTUr
 O44FADbBXDPnH6Cg984i9gw7ECC1wMgqJIbxmRu5qp/91/rC2/gg0+jkiEhvDMsQhHBv1l
 VQeHUmneEOpcAeesyp2YOmwIu09PNOs=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-L_w5-HYUNiCrkCy4KqIoog-1; Fri, 29 Aug 2025 16:06:09 -0400
X-MC-Unique: L_w5-HYUNiCrkCy4KqIoog-1
X-Mimecast-MFC-AGG-ID: L_w5-HYUNiCrkCy4KqIoog_1756497968
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2445803f0cfso32569585ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756497968; x=1757102768;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Za1NNvSl7uFr3wDIymXqGWcBuLkcyiqwtqIRxvI2IEk=;
 b=ZyJ1hUat9Nt+/CwDPRVyN8u0ff7AF+90N8J2IIQnEnrU0qTES3j0GfkOnzUyJZjpCl
 H/0mYwXIf3FDG2EaqeZIdaE6doqheEgytaIAwQuQcA0qbFiKChVbIyunl5MLhqa6vlyK
 0zShvUCy0ldZERMs/BTPkKjwE7KKdEMUW1nXF34oz3vSYXm0HRiwlu4KlcbqgMcWBzZZ
 ORYl1ulWmep9nJP/zPVJsIkzLXqfPa3bLcipbFkLsiSTwW0Fh/7NCMYxXAv9UixP0Cjo
 SrgWJf3ZPDgK0l48kHyYFOxkqoh3ieZag9hJS69xbNaZcHYyu5oIZepGDyjtz0+eXUVr
 twmA==
X-Gm-Message-State: AOJu0Yx5Gv3yBv6OphR6jUY1mLybPYgUEUwVgJuvjwxwwGrDSP4hGqFJ
 UXQnJRXRaIBXzkVxGEFdeggXj1i0qY4padFtVx2mcGfmcgq6FMEtvNtFwwhlqKhRYUDWWCLGCIG
 jraYRg3HIYSSR4nglbJlY1UXRFXlPLWhlLb0mOh4km5hb7febpHcEXYqH
X-Gm-Gg: ASbGncu+FN9uyXe7HvXncurq06St+5qkEqHidkd4pzDnovJw7MKqMO9U3zoGPb/j/lF
 VszKn7MEcZB/zrAtqpAOAYwHIq0ekhmLCoG6JV1tXq1OOKmN2QW1iIkDyzCIBCiLcKIm3deFxW2
 MfoUKZywSGpXr02hOqzzWtlN78tNNARPAG73AJVoLzoaib/Q8cZDSqalf14PHiXxQtyWoAe7abT
 Rjo72aSogNIZZwcZYX3s9KCjZaI7KibNV+XXGXsElmBn99CiDQg8Q0aksj159yRZLQbgd5nmzFi
 s/l7NRaRLOu7G1qLZEgHyJPUlbwknq2N98/mt2cy8WPrJBOvYrECqg==
X-Received: by 2002:a17:902:f70a:b0:248:cd0b:3434 with SMTP id
 d9443c01a7336-248cd0b3913mr129256455ad.36.1756497968200; 
 Fri, 29 Aug 2025 13:06:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT7tKzYbbRW8J8wAF+R2djLZuIkTNdGT9d35QTNoUfyVKA94bY+WKbDKxn4qCNUkMWeLeCQg==
X-Received: by 2002:a17:902:f70a:b0:248:cd0b:3434 with SMTP id
 d9443c01a7336-248cd0b3913mr129256155ad.36.1756497967838; 
 Fri, 29 Aug 2025 13:06:07 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d8f66f16sm3570543a91.0.2025.08.29.13.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:06:07 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Sat, 30 Aug 2025 01:31:56 +0530
Subject: [PATCH v13 16/27] migration: push Error **errp into
 loadvm_postcopy_handle_listen()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250830-propagate_tpm_error-v13-16-a4e777b7eb2c@redhat.com>
References: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
In-Reply-To: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2751; i=armenon@redhat.com;
 h=from:subject:message-id; bh=BsaDnW57QysoXysSxJ9DH2reNuwbEbmWWZabpe2MJIE=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8Ymdt9JLwJUHvwKVtv0ROoTB8O2hbbNXMf//3c49zLV2
 bvMzO1URykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIl81GZkaOcK4qyx78sPf/nT
 ZMa/hMn3Pzyu7Zv4TYvvYJW6/7+YCQz/4+6tu7eiutVfNsZv3S1T7Z/nvz2YcPna7FXXKjZMvzz
 nFQcA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_listen() must report an error
in errp, in case of failure.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 680f6e1c4bbc979f779d9fde28ab71ae234b5891..c681d6d21af356a97645f2a0d36e7440e3bd95c6 100644
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
2.51.0


