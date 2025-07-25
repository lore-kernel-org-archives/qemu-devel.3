Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33816C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHQP-0007yF-SI; Fri, 25 Jul 2025 08:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHQM-0007gn-1H
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:21:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHQD-0000SF-Hc
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753446068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JUYo5KA31AQ2/iT2h5kgIZBH6xPXy9KVPDj3Zp7HpXE=;
 b=gNNFnVE+2mgSXgpHI96vDyviahMXmkjeiGNPLErAECdMrdNdRvvVD3kA2pgvrY0yMa33/b
 razHYkhXpmb3XsDLkn2mUHa/bnxESP4R56Kp5p0aP7Q//fGp9yP1HoJWU6VjtqfeAuS3zO
 ApZ7K8R92GZlQo095423j0feqUHbLkY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518--825TP0uMfSepM0eEE_BXQ-1; Fri, 25 Jul 2025 08:21:07 -0400
X-MC-Unique: -825TP0uMfSepM0eEE_BXQ-1
X-Mimecast-MFC-AGG-ID: -825TP0uMfSepM0eEE_BXQ_1753446066
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2369dd58602so21529925ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753446066; x=1754050866;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JUYo5KA31AQ2/iT2h5kgIZBH6xPXy9KVPDj3Zp7HpXE=;
 b=rtOuSyHyfFa4DpQCPEceA/OAH57XrgdHRlqV1CAgOKZ8Z+WHbN9jdN6RYzCPR80tjs
 rFdZnDzye988Y09a5Wx/CIYgbzMEg4I6pULCyeyGhWZS/VNnu11hAepL5eEFTnwfLjBX
 JhHPkhHwXBUVcBD9VRevUmfxq0wjvnKuv0Yu289DV87ytg9fjhN9Wtv5oVzC9ZAEfDzA
 a6jMmK12O0NQCsVzXBakTw6we/u0RV9Gn/u8v39QEBTHdqW95m3JPI3K5drlHTInaLVo
 q0QLKqzvkRgJCWOO9aYXgAdPjcwRLUAqOOLTmwEy+gufUXsSJLmvs3JkTq564LuwuoSf
 4dGA==
X-Gm-Message-State: AOJu0YyIvK3XF0PkHLOuTioJiGQfTssBQ6myrWmw1Vna+rmoBIJK+mxl
 ws22Aw3fETgrzNlkjvYhFDa2NxMtQ1ou2zBW6ayurlMqLALK0nSeTaAEmtlNaxolBxdHoamnU6N
 JV0Yl7K3WNaYD6qkz9erQcHqftHXCxjMJ8PMCZE9B1ySkYkrRPUsY/Kmp
X-Gm-Gg: ASbGncvl0NgsHVbFuOJyBUraTIR6CMT2uDBJhE13+XEGU7Z30FetxtE7RmH22/b8BUJ
 FnaxBZJgKntVjtM35kPdMZ+fSxdoW8NnhBqUBF7R920K61hz/L0CYtk9OwnT4Llsp4RR8y4JD5b
 FCehjc9mjkipxHiSDk31Q2xwoRdnlhtfLVPmbgncWiPBLI0DNoTneFAk9A2Q5mGuJBsOg4aj9w9
 TDQSKi2LKPSek3FEAC0iWAULKb7nVeWxqvXwOvxDIvU6gqN32SzzB2enMfHyj4OsE1JsSL7Pn+d
 UfU/wOBDpkdOmbp6CU34eLvgI5yUC1haFMY6gkiFY5cIBdOZJ8U+eg==
X-Received: by 2002:a17:90b:5848:b0:312:e731:5a6b with SMTP id
 98e67ed59e1d1-31e77a20050mr2377827a91.32.1753446066160; 
 Fri, 25 Jul 2025 05:21:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmCpZNIqCovxPsRGPJMWr3xuh/4bRsni3fdeInDUNa+/gLapPMo2B7zoPVoVu+2vyr7CiXQw==
X-Received: by 2002:a17:90b:5848:b0:312:e731:5a6b with SMTP id
 98e67ed59e1d1-31e77a20050mr2377784a91.32.1753446065646; 
 Fri, 25 Jul 2025 05:21:05 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:21:05 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:48:53 +0530
Subject: [PATCH v7 14/24] migration: push Error **errp into
 loadvm_postcopy_handle_run()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250725-propagate_tpm_error-v7-14-d52704443975@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842; i=armenon@redhat.com;
 h=from:subject:message-id; bh=PQikxdWyHXMnSaHHhBn1/YBexiFFXhThLBN//edFtV0=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Zzmc4S+Z+mD3dGxnwLLFbM6WGvrme4y33Pp3RT2IPEJ
 uXwGS4dpSwMYlwMsmKKLA1fA2SbAgojIm1fXoeZw8oEMoSBi1MAJnIom+EPZ691eL5Xy4w5r3nX
 57cnZirzvLwss9Zb7cU2LhX7OXuuMvxTjG6LdLz3tLS/4ONqS+fUrqjdnXtKtMunJKe85Pi36Dc
 DAA==
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
It is ensured that loadvm_postcopy_handle_run() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 5a7564f60d8a465f136d1fab50e887630e276871..3a1d218901472ff2d3de8a9a26b80fa8453c27de 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2273,13 +2273,13 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 }
 
 /* After all discards we can start running and asking for pages */
-static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
+static int loadvm_postcopy_handle_run(MigrationIncomingState *mis, Error **errp)
 {
     PostcopyState ps = postcopy_state_get();
 
     trace_loadvm_postcopy_handle_run();
     if (ps != POSTCOPY_INCOMING_LISTENING) {
-        error_report("CMD_POSTCOPY_RUN in wrong postcopy state (%d)", ps);
+        error_setg(errp, "CMD_POSTCOPY_RUN in wrong postcopy state (%d)", ps);
         return -1;
     }
 
@@ -2626,11 +2626,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_listen(mis, errp);
 
     case MIG_CMD_POSTCOPY_RUN:
-        ret = loadvm_postcopy_handle_run(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_run(mis, errp);
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
         ret = loadvm_postcopy_ram_handle_discard(mis, len);

-- 
2.50.0


