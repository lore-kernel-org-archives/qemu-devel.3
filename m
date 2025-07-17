Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DDAC83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCij-0008DN-8C; Wed, 16 Jul 2025 20:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCg7-0004C1-MQ
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:40:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCg0-00053W-Nf
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+wTvA/7usbgasNF/ttkqJIAe4EVgQ2LmCMRyT5qNtjg=;
 b=LrqOUEIbIAxy7KRGaLI3wFsfNdVUyM46eHUcyiu3rPLpaRJhiO6e6wvXOsgBZN4O+yIwdi
 AxO4IyEu1EwAuqLYQdfCKo6pKIs3efsCQu9F/SENfKRW85zwnwbUKMaFZ+RmXok08hL7L1
 TJQlDD6j5TA9lq7LRT0JXVpaY1V8BoE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-WVIi5RyGOje2SrCIMrNmAw-1; Wed, 16 Jul 2025 20:40:40 -0400
X-MC-Unique: WVIi5RyGOje2SrCIMrNmAw-1
X-Mimecast-MFC-AGG-ID: WVIi5RyGOje2SrCIMrNmAw_1752712840
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3132c1942a1so526085a91.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712839; x=1753317639;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+wTvA/7usbgasNF/ttkqJIAe4EVgQ2LmCMRyT5qNtjg=;
 b=HtqWYJA4qoqeTxeg5QOTJCrVSH8Z/KK06LjYz2NYXOARJV2638yKPI1CDgalCdvH13
 Nqhb2UF4ceVsFKG9UzsPKj0r7L+m4hDMUqjaKqhhvfukjmbmldRGNl2TqiEb6EyY+0xV
 f9gM0qgjf/D36JGCrzAynY4G3hyKFF6+hTSHP4VezPljutK5ItHDxosvBPyv0xtD4Et3
 m4LF3O+zoHy/oYXAvbVeBVB9+FcR4/DsMhQvQgrCp0zmeK2/jisqjTABFNMgGD25TbjY
 kIiVwf9LD7Oz+GF0fwO1uy0FaLZI8egMG08eemuz0vMUJoA0xJl65qU9veuwqnEvabeY
 3flA==
X-Gm-Message-State: AOJu0Yz/NIFlwncklg0a0Ou2qsLDBAVs4TSTb+4fYL0+JQDtA/wMXPZj
 fsw0rePAAaDDQ0bqPNhjjce5SnrT+dZEhFVhxfhz3Nh9V3WRI+sMQ/05OFnZx71m6NNTAcXK10n
 7x68bxChLIWKTVrBCL5hp8PbfN4YhsC+nB6CgyKI81D5IGKUp6aMT6EclfIQBGeVrol8=
X-Gm-Gg: ASbGncscYWipORMwggTyVsqHjKRYGdlE3bOMKY+B2jqde8CvpCntsP/RV2ynEeq5ByD
 B7AEK5h5unKtL2OHQXBQhpxgyUGea7omasV2AMvQ4OWSwYe+/PtjGRt5JeMy/C0TYcvUezjcmE7
 gCXzWERX20PKQS9cJpxrbc4Po/4jOPNEiQ3ny26QxFlkZpvQ11y2iXhKZQouXBahIqT8bn4CPmz
 aRjOA3i805hR3NMOk9VKZoJSQbTCzao5qFdx/7zbafpDApl/L9P9A5YLZ39T4c8eKOQUr0NmBsQ
 ymtf5SHzdBkyLdUqClA/UlQjuD3jh83b1ofOhHzfbJQdRVkjfuzL
X-Received: by 2002:a17:90b:5252:b0:31c:3669:3bd8 with SMTP id
 98e67ed59e1d1-31c9f424a5fmr5294387a91.21.1752712839418; 
 Wed, 16 Jul 2025 17:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFargZkGZTy7Pszbtj1KBS2ZdptFvAavEVwIHRtZ7HryroP4gHSeK03dF0teIY2oaTbn16BOw==
X-Received: by 2002:a17:90b:5252:b0:31c:3669:3bd8 with SMTP id
 98e67ed59e1d1-31c9f424a5fmr5294359a91.21.1752712839010; 
 Wed, 16 Jul 2025 17:40:39 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.40.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:40:38 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:34 +0530
Subject: [PATCH v5 11/23] migration: push Error **errp into
 loadvm_postcopy_handle_listen()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-11-1f406f88ee65@redhat.com>
References: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
In-Reply-To: <20250717-propagate_tpm_error-v5-0-1f406f88ee65@redhat.com>
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
 h=from:subject:message-id; bh=uqQOArr5pW+vBy5T/LbQo/AfxHnsu2F8gE95SYm7aNQ=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm8Kc2yKndfkz56jwX978/5bWYT2Fpfvn7ZfXXh3KZ
 eJnsK2mo5SFQYyLQVZMkaXha4BsU0BhRKTty+swc1iZQIYwcHEKwETc/zEy7Hxy8sh7NWObqaW3
 jkgxF7Czsfh1PP0sPj/2brfOxMrfmYwMO2/sWbD2DLPOrR0ni03+vOu61vFqUeTB2w8mhZQn88r
 nMQAA
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

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 608560af35dc76813bf6e9b571df3bd343f0eeab..a5ecec94482dfd23403d5b24e8e0c82d4cb73cc7 100644
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
 
@@ -2619,12 +2620,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
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


