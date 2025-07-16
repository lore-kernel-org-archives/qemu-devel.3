Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1550BC83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubzhS-00008s-Ml; Wed, 16 Jul 2025 06:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzdC-0007pE-1p
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:44:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ubzdA-0000QE-8T
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 06:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752662695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLZjV2l4Wf6Q+/vW5gTpE8hB78QEhHll6lKCkmb6uA0=;
 b=Ow/ni6nFYAulPRAEURFtFuvNQfAl5ulue5ljVX0y8TiWOINM5xB55PNHd+tIJL5pCj3/6v
 078j963sM9bv/pTH/YiVdJHKhvQAR+IdRh22KG46pYNnlSwMlJYDF2++kvibs5lVGSkYzn
 4hCYM7HdA/UrYmUKTLBV3Pvcr3vm6mE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-Ps0okn4qOfqjhEt1ReZoHw-1; Wed, 16 Jul 2025 06:44:53 -0400
X-MC-Unique: Ps0okn4qOfqjhEt1ReZoHw-1
X-Mimecast-MFC-AGG-ID: Ps0okn4qOfqjhEt1ReZoHw_1752662693
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-234906c5e29so75166865ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 03:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752662693; x=1753267493;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XLZjV2l4Wf6Q+/vW5gTpE8hB78QEhHll6lKCkmb6uA0=;
 b=vua+LGIqw/mwVCx103WWRRBCVcjvJIWnlfwB2EsG3T7OQel3Qt14QN3axEYnUtkEfr
 4xBuBvo9JDsJHAKyQWEnEAlbUYjk37sP4Oax16iK1wsoJ74h+I3FLc12jhlspVH3QO42
 zfQl73+K+GXtzDb9kJYo78hMhPM0cCwI/KhXZwlTWIiX7+tNGba5kU5zKx+o2YMJzpCv
 aK5DcH3G4QE7YZfu7f+BEjCbT9wzTcYMTL1vAL8E/yt8N7BGHDSkf4bIyj8bQXw/Uvh0
 S6VbjPAiHJRfEdi+DO+KGdppXSxKMyXhI96BjyndNJsAYhJUUER3WwbC9AurS8bXv/9X
 doWw==
X-Gm-Message-State: AOJu0Yzroe6Fp7Zea3sQ+lE0gyb/sEjS+HyqLb6cKO3rUQDHSU0wa2MT
 GzFYtxIKD4Fe0tC/l4Hjo3Pdg+yUnmw6yOUyOX3oL4SEH85ca62ZemesoK4edSTI3PYrtWSb3z0
 KnZOFc8lf46lspdvgv+e3RF/JS1h/+AGrL4aUCCEq4Sr8+gTKvgGI6+Yk
X-Gm-Gg: ASbGncvBQd7BbyKRFdw18jn9cUBobRspe1cL9+y2Mtn3qrtTNLX8/GUrN7v3LN+IlAx
 P0ksX3NfpU/XzxHhwMeUEA0rLpTTU39pVlRhBfPFWN7YoBM5MzZGTwWR4M7rlSb+aICw+Sz3/9h
 V0fU+i4nsDkzSnLI1+X4M8AjmsweqwBKyGJGCz3hWwSyh6l7eN0yPGbbfvmh/0kUZT9DdwKYsgh
 QcW8W1noIQ0Gbb4knfEauOUEDTwTgxZOX3lB2Bkwx4xBXrxGkjOWf0fd6n07mBChllEm8XLoJsw
 AgcTNyQu3mgBcQhLJideEKBZyrKAtrYN8MmhkEolanY+DUjWgg==
X-Received: by 2002:a17:903:98b:b0:234:d292:be95 with SMTP id
 d9443c01a7336-23e2576c4e9mr30760355ad.42.1752662692773; 
 Wed, 16 Jul 2025 03:44:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiYgT4Wxv8DIavTSiOj+RgwwZ9a/uErDOyCKq5W1D4Pr1Mw0LCzNsT/wr9wQM/jPtX0tQq8Q==
X-Received: by 2002:a17:903:98b:b0:234:d292:be95 with SMTP id
 d9443c01a7336-23e2576c4e9mr30759925ad.42.1752662692414; 
 Wed, 16 Jul 2025 03:44:52 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.1])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de435baccsm123363265ad.227.2025.07.16.03.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 03:44:52 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Wed, 16 Jul 2025 16:13:01 +0530
Subject: [PATCH v4 11/23] migration: push Error **errp into
 loadvm_postcopy_handle_listen()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-propagate_tpm_error-v4-11-7141902077c0@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2678; i=armenon@redhat.com;
 h=from:subject:message-id; bh=WG0DbpcviFJH405z4bZzYpqg3DN3q2mpu37lt8PpHMo=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z5k728nqZn9/wz67pmZLv15Zx5cnbOXp7+fLnmTxbGD
 +KmMVZ3lLIwiHExyIopsjR8DZBtCiiMiLR9eR1mDisTyBAGLk4BmAhfNsNfeTuHXjP3Yqm9XJvs
 Y2dl8L94opBt8E9bR+UHt134rQ/nGRnus+QveB4d2jAvPbB1u7xPqMSSBZqMgre3mqherFRflsU
 IAA==
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

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 24ec721587564fa0432882d86bd5f71161f0aee9..3ed399267af7ebc9746d81920ec58277485206dc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2173,15 +2173,16 @@ static void *postcopy_ram_listen_thread(void *opaque)
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
+        error_setg(errp, "CMD_POSTCOPY_LISTEN in wrong postcopy "
+                   "state (%d)", ps);
         return -1;
     }
     if (ps == POSTCOPY_INCOMING_ADVISE) {
@@ -2204,14 +2205,14 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
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
 
@@ -2621,12 +2622,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_advise(mis, len, errp);
 
     case MIG_CMD_POSTCOPY_LISTEN:
-        ret = loadvm_postcopy_handle_listen(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        return loadvm_postcopy_handle_listen(mis, errp);
 
     case MIG_CMD_POSTCOPY_RUN:
         ret = loadvm_postcopy_handle_run(mis);

-- 
2.50.0


