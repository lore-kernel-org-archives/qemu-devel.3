Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC37EC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 11:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udolU-0004yv-Eb; Mon, 21 Jul 2025 07:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udojq-0001it-RV
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1udojm-00011y-P4
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 07:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753097476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IMpQ36kOWIQTJO2jgUaDOO1ImiGekmVsPOUtQMcJ4QY=;
 b=AtClWmrrLl4coHHasR18qkl4EtBcsY+rGmOz3yH+t4H7Rz5D+OyLZOyJrk1xlkB/bItbgI
 SvY1SlnCPL8Q7Wgse/s4NRJRBYnLVbskjkkWB+kh/TvLsYTQL2qY7C+zWFQnY6JSr3Fh+K
 cYYOG7MmraZdXf5yupBftHGGGn4dV7c=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-3pXS2OEpM2ObSwIB-hTgyg-1; Mon, 21 Jul 2025 07:31:15 -0400
X-MC-Unique: 3pXS2OEpM2ObSwIB-hTgyg-1
X-Mimecast-MFC-AGG-ID: 3pXS2OEpM2ObSwIB-hTgyg_1753097474
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-235f77f86f6so40693105ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 04:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753097474; x=1753702274;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IMpQ36kOWIQTJO2jgUaDOO1ImiGekmVsPOUtQMcJ4QY=;
 b=GeUhWIXCSmK03JSZyRvoSd/vxuxvHMg/qnJWNhN7fPL893YPip2Wyzb+x7NulcQBuc
 anc2RAIGLdmVjyp7WEcKYjNHeWeGsVi166Kx/qUjNtXYUZGaCuBJipaIW2XqQnsKysWo
 O1tJ08gAQw3XuulH1Lmg4LFLCZhAbEjV1ULsRNTUuoCBKNB1E5nIpAZjBz0db9oFL2s6
 vI7I1x1+6go5cSF7eW/7t6cQAS85XtzR1dAK2fqsPGdNnQxCJTQCJNDS372gwRqlI//q
 pa7Q8zVwhovKc5B871OpHkEyWWqk840O29iRhSYDCe/f1lz4HHTtEqFzhRFQl4673C90
 pmUw==
X-Gm-Message-State: AOJu0YwWPAuZvs1gS4W0yLdfFpxcB2hxeVCe6YFAVp6fpH4VVc0CaDkj
 tzR6mpdtuInXKAGw+iA+IUvuIV9smImCNVyfAGOHzMHWS+Wcq0m08I9r1+UQ6HGyW006vQ147KY
 xABS6EAxltEf4lKD72GzExygL5XFnl7949uYSGLeL3SBkClPcCMvYAp5i
X-Gm-Gg: ASbGncsAcJdAZ5CZQyM89Og+5Oo12BxSBeRnoJlFNfuGe5PYDfnLV3wDUWqErlgP4lN
 R1jwHF5QKoVPV5pk8ZlXv8qRqqxpcg3V/7+joZwWUDq0aXv0Bm45E7oHqWlLDDASPYq3EhkgpHf
 hXXxjzxsvCRqJkV1dumovmK797WXQBKrD+MLdqouJsexEoUQCJIkMOTI+sjhwG19eZE0BSb8VXL
 Y9uN+H6yVMMXrHspEZ4vtSPYAfH/UxlcUCqoGA357dCIWQV+hkxo13CEz0EKY7bKDVc1ahBd3Y4
 HBlCZ/PeB8ME2k8dtFiSU5bpaz1jwMYE1MOoBWf+usB9Ao79LmIJ
X-Received: by 2002:a17:902:f64f:b0:22d:b243:2fee with SMTP id
 d9443c01a7336-23e256addf0mr223612185ad.13.1753097474220; 
 Mon, 21 Jul 2025 04:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD4Xf/gk8LJQ8NCMC6gFW8iNVwY55aKKulVSO16NvoO5yz2/P0G/kwyjqZu/hibwsutJypOg==
X-Received: by 2002:a17:902:f64f:b0:22d:b243:2fee with SMTP id
 d9443c01a7336-23e256addf0mr223611735ad.13.1753097473809; 
 Mon, 21 Jul 2025 04:31:13 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.21])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23e3b5e3c89sm56150465ad.18.2025.07.21.04.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 04:31:13 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Mon, 21 Jul 2025 16:59:17 +0530
Subject: [PATCH v6 12/24] migration: push Error **errp into
 loadvm_postcopy_handle_listen()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250721-propagate_tpm_error-v6-12-fef740e15e17@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2734; i=armenon@redhat.com;
 h=from:subject:message-id; bh=icfmsOZ00TKgvbj6eWaydnADKM4+jVfCr9cSUQQ3iak=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0adysR36/jDvj+aafplhY+y/eVT105Pv7csTtFCzHRlj
 /Z6O5MTHaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACYiuZmRYeJPmdawkz13DGZy
 HHy8bO4WLZvwmR8Ulv/+VbTkyLb6LD6G/25H18qoz2W22Hv8c7Bh4nSR6Htb0rMMLGzuro9ecEm
 VlQ0A
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
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
It is ensured that loadvm_postcopy_handle_listen() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 4a3db9498678a19597257e683029cd3f6c8d1a65..09d12dbcf59e2dedd529224f70003e6e673442ff 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2179,15 +2179,16 @@ static void *postcopy_ram_listen_thread(void *opaque)
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
@@ -2210,14 +2211,14 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
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


