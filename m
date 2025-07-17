Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6979CC83F22
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:43:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCiR-0006zk-7I; Wed, 16 Jul 2025 20:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCgB-0004HI-Rn
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:41:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCg7-00055k-BB
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ENJvZNWoyyM9iitIR9lwTNSIHc61x0qMxhQbhjr7N8=;
 b=X3lSMBjt21B44e/rLmxJnjLDYjF5wP8vSqzdTk8xq2QEMRc83SJR2vcPQ+mseooZPmKDXA
 JKKu1BTkoK8+8PB28FqaSDsG7C6Z0pcvVEv/+Rm193S2BZa9EnnlA6cfGZcYwocr7QEepJ
 O0TCUl5xlNrBoo9+u8y56nz/4cPcnrA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-U5cqH1-OMmud0hi10jDXIw-1; Wed, 16 Jul 2025 20:40:48 -0400
X-MC-Unique: U5cqH1-OMmud0hi10jDXIw-1
X-Mimecast-MFC-AGG-ID: U5cqH1-OMmud0hi10jDXIw_1752712848
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-311ef4fb5fdso485739a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712848; x=1753317648;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ENJvZNWoyyM9iitIR9lwTNSIHc61x0qMxhQbhjr7N8=;
 b=RiXl3T0cZ5+zcHQiaS8wAjcpapjpSMNReIuy++Je5hPC8woU5u23K+Eh1w8aID9oRT
 ks4EwuvZq97GAAkul1QgHEm+v8mY/WZRLtOzSVS+GSJOvcv068oeZWpfP7y/d/f1918z
 WMI3uXvw2SY4Vl8mssTey2rT51xuZQk5kKUUFuaclijQooUmW2uhGnlbR3J1oi6z23xN
 fpjaiMuZGvNNn5RLe20BU4nSF7/hDHo0QFMazl/g06VvoGVv+mlBA2J0j8+37H7yO6f5
 D4UYThoQbCRmv9jnPf5lWFv3EN3pHggJUONB1ODQ7oNiIeyIuql8SnLgK9G+MfIWGb2p
 4yEw==
X-Gm-Message-State: AOJu0YwbUEp/j7x3CMurWvzD9pnKb55JLKO7VwuP0X6OCKAtJ25wC8iI
 flK7RiLEjJ56uI4+XJD+2VqzP88sHLy4Oj5C0IX1Os4j6gSNR7mqWMeHhpcS0LSOoFeBbG+jyhC
 EsXjDu38/wiH0W0tsbbSattYViXrfTbaoNbZSJmoFc+3G79/qtiNxjpLf
X-Gm-Gg: ASbGncsN7cKmgQ0PPlTIimLhwrBJKvd85JvXCYOYcOuoW73UpKwjuRdbB34kPhhFs13
 c0O6oIkjVkTACkSuubAd6u4utZvg1Q51dyDTevzgmmYmIxMsG1D9VUtcS6VE6JfRw8tSxs1k8/u
 kmHrDCWLhjY0bM4U/geqFkRUX6TygQAPUzg7xHEflM+t2s3Mhuw6oIwWwDq8+fTxiYgxRl+BNq6
 7Z2gLhmF7DBRl1RRpqr8tM3cMCOfL97pq9qNMvYJ25f4q0X2eAzXPSYagBBzlxF9IySNHeyBETO
 X9uVsX2IJYuCoLA9FZw6PFAWqexxt+52JiixJZi8BEsox0W+N5wJ
X-Received: by 2002:a17:902:d603:b0:234:d292:be7f with SMTP id
 d9443c01a7336-23e24f4a936mr70881325ad.31.1752712847715; 
 Wed, 16 Jul 2025 17:40:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgafHvPAgsKcZvU/i2ibqwEhbukMvhJ5gXjxbwfOz9JwNcD27BTDpTezcw+n/5Bv2a1ABsbQ==
X-Received: by 2002:a17:902:d603:b0:234:d292:be7f with SMTP id
 d9443c01a7336-23e24f4a936mr70880665ad.31.1752712847132; 
 Wed, 16 Jul 2025 17:40:47 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:40:46 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:35 +0530
Subject: [PATCH v5 12/23] migration: push Error **errp into
 loadvm_postcopy_handle_run()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-12-1f406f88ee65@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; i=armenon@redhat.com;
 h=from:subject:message-id; bh=riI3Ss23FNIWWvkSSaMQsb/tz+VDxKH9jynbsXr0NkU=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm8KRVc4SJpEFWYd2nIspe/JtBsvFSS98Jux+fonPQ
 /t0M2tbRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIks5WVkWC9iuXrT0mnRzoYK
 TzPiZX5Ym/tO9O8MDDNWncrobPbwH8M/hfk+Pze25kRUuViUMJ8qC3zMfeWGZDt7T9nL6d4S1/R
 YAQ==
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
It is ensured that loadvm_postcopy_handle_run() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index a5ecec94482dfd23403d5b24e8e0c82d4cb73cc7..509b71dc2666617ee3e7b707f46187ee5287d201 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2265,13 +2265,14 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 }
 
 /* After all discards we can start running and asking for pages */
-static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
+static int loadvm_postcopy_handle_run(MigrationIncomingState *mis, Error **errp)
 {
     PostcopyState ps = postcopy_state_get();
 
     trace_loadvm_postcopy_handle_run();
     if (ps != POSTCOPY_INCOMING_LISTENING) {
-        error_report("CMD_POSTCOPY_RUN in wrong postcopy state (%d)", ps);
+        error_setg(errp, "CMD_POSTCOPY_RUN in wrong postcopy "
+                   "state (%d)", ps);
         return -1;
     }
 
@@ -2623,12 +2624,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_listen(mis, errp);
 
     case MIG_CMD_POSTCOPY_RUN:
-        ret = loadvm_postcopy_handle_run(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-            return -1;
-        }
-        return ret;
+        return loadvm_postcopy_handle_run(mis, errp);
 
     case MIG_CMD_POSTCOPY_RAM_DISCARD:
         ret = loadvm_postcopy_ram_handle_discard(mis, len);

-- 
2.50.0


