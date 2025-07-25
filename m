Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31287C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHQG-00071M-O0; Fri, 25 Jul 2025 08:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHQB-0006oi-Es
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHQ5-0000Qy-Lf
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753446060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lbnbr1fSdLHVLUP7ZrX5RcGm0ryxFZ24z547nw5skP4=;
 b=AX4CQSuP6N/SM/Z/3VVlzJk5OuOdeyqskOxCSZh15U/FcbiXmbyE8ttWOatFszWIccSwDt
 xAe5q/OZB/5PFrl5OeRiquqX1k/YFRDcnV1Kh/dgliiiZRPK6AkZQfIRnxe9Gfd1Iy9mXe
 1PJBFoniJHHxt3XBexWVPjLEDMPd5m4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-le1eESJQMrisn2Z1EXpINA-1; Fri, 25 Jul 2025 08:20:58 -0400
X-MC-Unique: le1eESJQMrisn2Z1EXpINA-1
X-Mimecast-MFC-AGG-ID: le1eESJQMrisn2Z1EXpINA_1753446057
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3132c1942a1so3296928a91.2
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753446057; x=1754050857;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lbnbr1fSdLHVLUP7ZrX5RcGm0ryxFZ24z547nw5skP4=;
 b=QKFAWe+Ni31TPq0vNZmjkA1MJUs5/vNylMbQ527M7J0Y2QCg5EKeO/qjeNmUcTiKAO
 JqGO33GLx9JbPRGICNoP8pQG6x2JWsgw3A7tiEcgCYbSGRpCxkE5u21zge43AdMy/O5l
 FCgB19S9PY02KsvaIHfQVObr8sO0jjvvaQDbxzf3H3iagBNERcYdFpS4GjOjgxkz8Qta
 o4aaSzdba8eWUYLSubWqH3sue8y7WDh83A9WQHKrU6ylZFyed0tPEBZ/zrAHvbr7YUHM
 QOo6EUj1IFa2khljPlEa8EFTB+ZdoGueDc3/1dd6CMxKPdyAGCXGCTltpovFC5S4hHyh
 cWhQ==
X-Gm-Message-State: AOJu0YyVznJ2PZNuR9RyVq4fAegcvXNxBN3muyOeXexgTHrjdf0OVplg
 wNOCBKjHP5BekGPTob4cLwtiri1L1lZKrVahE+SK3gd0mg8RXHxqBo0eNQ2TbN3GP1ghycFh6rx
 15mnIUrgNKjmCfHq6UJW1H4h9Obc/Ahw0qp2e/Qt7A/g+q7j4ni5feHXs
X-Gm-Gg: ASbGncukl6hjXy8Y8aNuJ5yuD/afp5pszRu1cXe9rrE07TtWhtOGu6k8d0mMup9SefS
 Vn1C02qNOnbuDNGxHzKLIOA2EYhX9shfZECRpEHiuegUq2BfyGfgXBS9es5+QACOosTTnYbkoBz
 sDtph2R5B9d40eoQDgEp6LBWtGNVuFIu8XeecE/TlGIBPNzt2aWr9EmWomc+NqSGzFLZ7bU9q91
 uu7kLmrZOWmU97Z4iB8HczhWMR6bP1rYh/YC/jjNeeHSqHbdoxpu8IZadhQXft2bd8r6Ih9obCf
 dnNPgUe0zAEJjHaK+cON36slBdtZHl0clmbPYbBQ3f4MJh4EeN9Z1A==
X-Received: by 2002:a17:90b:394b:b0:314:2840:8b21 with SMTP id
 98e67ed59e1d1-31e77b1ae45mr2071670a91.32.1753446056970; 
 Fri, 25 Jul 2025 05:20:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+EpEBShA0m7yNGlmMslnphQAzCITwfuJnYhCiff2C6Od0bRohiDFcLHdjISegPAFggtKhEA==
X-Received: by 2002:a17:90b:394b:b0:314:2840:8b21 with SMTP id
 98e67ed59e1d1-31e77b1ae45mr2071636a91.32.1753446056498; 
 Fri, 25 Jul 2025 05:20:56 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:20:56 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:52 +0530
Subject: [PATCH v7 13/24] migration: push Error **errp into
 loadvm_postcopy_handle_listen()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250725-propagate_tpm_error-v7-13-d52704443975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705; i=armenon@redhat.com;
 h=from:subject:message-id; bh=OJPEMQIflIZDjgD+FQd7HKYZ5HzgnH9dBK/vtFhB4L8=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Zzmc7DQMkzcwXuaCddC6hh1V9gYN9lEnMhcNm8G5ON3
 37OnyzcUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCIb7zP8M/W9zXQopkUmU6pq
 6w+3DWv1f7B2S1WzMH1cknRjqeGJGEaGOVwsatcsFDr+vm2T67q7Ymr1hHruj5N5F+9Zt0AssGI
 7LwA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
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
It is ensured that loadvm_postcopy_handle_listen() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index eb843f4869f7b49a17fe0fb1b0e36db993e4024e..5a7564f60d8a465f136d1fab50e887630e276871 100644
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
2.50.0


