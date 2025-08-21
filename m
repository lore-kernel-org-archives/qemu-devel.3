Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD27DCA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 08:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up0yM-0008Mm-L7; Thu, 21 Aug 2025 04:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0xR-0005lp-EI
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:47:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1up0xG-0001TQ-Al
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 04:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755766048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rmVCGkXBVlG9OmuJxAAdE/6RWrIvRLkbN6MrxJhMuAg=;
 b=PqTLT/poOr73cPCdPf3ihUJ6ZplaezYJ9pBiD8i7ZlkJSLrGV1qFvi7ucx4eaPhNfHdweB
 sEM1WkmOCbDIQhQoK21vufRKTX8ljWTQlgj7NX1TsuR0QEVRU8mQRPMe24JY4IXSDwSofb
 SzqrJMhh8F7JQqPorncJn6P6K5E0c/g=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-ZOq0oVGZNGGyXWLweVcbJA-1; Thu, 21 Aug 2025 04:47:25 -0400
X-MC-Unique: ZOq0oVGZNGGyXWLweVcbJA-1
X-Mimecast-MFC-AGG-ID: ZOq0oVGZNGGyXWLweVcbJA_1755766044
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b4716f9dad2so1282494a12.0
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 01:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755766044; x=1756370844;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rmVCGkXBVlG9OmuJxAAdE/6RWrIvRLkbN6MrxJhMuAg=;
 b=MX7/QkYVtgWPMxSUL9N1aAndq+1onIjtZ4eso1n37YTUbVy/pekCuuHHGXoH+06cry
 SD6K44bGA9lefUtehz1KPdCyn8fk1UjcOo9tOp7ck9dKnp+mZYOaJM8TSeEahwf15G8g
 0hLecjeBMbaZsUEaCtAWWJ50Aeb1u2xLKxqUJsAOCtj3NCXuHclkKsulZYBUyx9MNHBr
 lTSY6K5JFEBKwwxNxq6tNztNPQ994w33dZoamp9lWfhAAqQL+O2ptyDU0GGFvfeCKa9Z
 TVLgwURwCoC6HLnLwpNn8jxOwKiVk44/030BQwljgcYirdkTfrPiOnYtC1T9Mjm3iEyE
 w5Ig==
X-Gm-Message-State: AOJu0YxHjCYC9iJajx/KJQaISpR0KPnmUN7pTUJAGw3DoUVWkQRXKtiC
 nE1eH2GHqFeUAuGcfzeErGLigg9GbMGSMnR8/D6cJaWLBJoGHVAEWjDYDsvOMbn1lKlLCq/7sdT
 RYXN9UaC5stsCFE6YM7ibvI8rp6z7LNvoqDWTqA/bSLpzDHFiuRE4whGl
X-Gm-Gg: ASbGncsVGyU41J7y3uFXEdq2rF0q0AleEctqGbfuikOcpFElC2Sm/mrqb2mPOxqkBr7
 Ia38FtgKur5fe/dDIjggvtmCBpe4k8FQxFlkidlcLajcvxW2ZOBoy7cFcQ58OGco/G6tzlVdkxe
 gfbGIXDfV0047QHNiSRb9uJPqraZJR9qd0DWlouA0fSQdH3znd5GE4bMoNzD4y5g11/Oh3d3j09
 K3QtqUD2iKt/dG/mqzArtO8URbqfdkNRtXZPuc2BqSF3oSj9P/070TxscCzEUlXXNpKKzj1KmtS
 iR63J/hkGD7PHNwI+lGKqRzrXby9vrgkoJRZ4XcLa3eyaCNuoFXn
X-Received: by 2002:a17:902:ce88:b0:240:8cec:4823 with SMTP id
 d9443c01a7336-245fedd00e8mr20807035ad.41.1755766044010; 
 Thu, 21 Aug 2025 01:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXV8tsj8Cnir/gFie9u5roEibR2JMIWZ5n7DHuIasMdN+MD+2MR982/iWJyOPinIv4ACSN3Q==
X-Received: by 2002:a17:902:ce88:b0:240:8cec:4823 with SMTP id
 d9443c01a7336-245fedd00e8mr20806575ad.41.1755766043566; 
 Thu, 21 Aug 2025 01:47:23 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.192.65])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33e05dsm48789985ad.3.2025.08.21.01.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 01:47:23 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 21 Aug 2025 14:14:10 +0530
Subject: [PATCH v12 16/27] migration: push Error **errp into
 loadvm_postcopy_handle_listen()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-propagate_tpm_error-v12-16-72b803e707dc@redhat.com>
References: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
In-Reply-To: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
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
 h=from:subject:message-id; bh=LgacZZsvdvvq64aNDEPGzgt6VUFebPspAlkqDn4XxDM=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8ayOynPTf/tXspy48dx9fWr83onyF2r++Fpc6XHoyvQS
 MBzl/X2jlIWBjEuBlkxRZaGrwGyTQGFEZG2L6/DzGFlAhnCwMUpABOZ5crI0C182PjWF5W/Z13E
 1CLqzBoUl2fe6LFh/rU5u/TQrwkqdxgZXm6vO/x2922tSWzz+XfF7NifFVF4bd4P/Zo3vhdPZqV
 qcQIA
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index b4a33fe740a21d4133d01ae8da8b8fbf792fc034..6408257ef2148bdc4b753500194eaea8384cd120 100644
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


