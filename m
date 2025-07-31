Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9E6C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:23:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhU7T-0002PS-O5; Thu, 31 Jul 2025 10:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTEq-0004Ii-J5
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTEo-00084Q-Dg
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uikZn/s4wv+Bosyi+eWzU0VyruMTZ2EvxVsjZCQjpVw=;
 b=Q/0MoHItaIjuvF3HJKmJ701JZJuMSK8B4kYqBmPobtdTEosXsuU7Q4SwtxLJXj/LKHijl4
 vZB0Sw/x73iEEFEZVBEpnn8Zah67RRqHGw+IfgYNT/4eNpnhybf41Um+HpcwsfHz7Cqd1F
 NmCw8OLJXyHugMVlmGj4RvXs9VeH1F8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-mp_BCUVpPGKWqPigP7Hc9A-1; Thu, 31 Jul 2025 09:22:24 -0400
X-MC-Unique: mp_BCUVpPGKWqPigP7Hc9A-1
X-Mimecast-MFC-AGG-ID: mp_BCUVpPGKWqPigP7Hc9A_1753968143
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-23fe98c50daso9089185ad.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968143; x=1754572943;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uikZn/s4wv+Bosyi+eWzU0VyruMTZ2EvxVsjZCQjpVw=;
 b=w3Qhua3+7DxRU247lW2kGk9t1U78+PRFcNeToe/iLUJnGO/kYdvlGNGFPOwI0Lalqt
 6hQKzvL2Wh17lppRd7zGiJ6+PCXyWxRGJEtj1EqK7pT48JksU20AsTQg7qXDfXHffA6z
 AvUVy86zgCN9mjHD1vFhwt7eqNKWW/VZLytbuQxbEqFQT0rbRRSMlF+SQAmZwp0ahTwp
 ZytsYSCx5NRupOSIvsevVpaDzik5/QCU3nhlzyeAXPJMHAc5cJHkd1xAYY1Cx/AkxfhG
 ujnEOeXcjFhG660DSjw9ADstQhrUtVLfqddfVAiezJ7cbKrtzUGIS7JwK41BnRM9IjOM
 4upw==
X-Gm-Message-State: AOJu0Yy9XJwD3Zvz56hsz+sQHeZrOscMLHKw2zpnRgSJzySZTOJPU8UE
 5sHzNor5hQtow8/zVcBsm1+ZIEZ5KYH2op9b/BJAhliLdeG4bfnhXQaDF9gDT8SdrE68dIl5Ka8
 vG29r8FEJHMJG+srMMEik1jbiHrDmY146gN4RlP/x2CI6R7CxFjXnaUCeeW3G+PRBLOTi2KfnhG
 6E5GopJHA8cVbyrYG+1HZRGfIFFEv2PdPe7QnvbD5Prg==
X-Gm-Gg: ASbGncvY05avWdYJEWZWpgyDjq7AO+/LjrZJ9yj0g4K1gpQxtvRecYo275yn0RJlEQ8
 3I0dHdXRc7pxGjfBsU17+aKLjAlPpSrDik6tMr6nO0C2WiDdqVLRUotA7st9tJj04uPz2khQsoX
 P3kQWbIYQ1IdpPk65D3nxGmmj6C+kcUFMQmkSNY9kfi/c/GJ06n64r28ecOO7MXpQifUSJ8Z3Nk
 wMl0+WLGf1XpDdV5uKbIappxrQXp+ZnojxfJZZP3FFkmNgrUpVnA1aRmYN0lxBoxb/M30sePwz4
 Aqj//bLLXvllrLBv5rHSu2RxrBHii8PKF0aR4W2cIeiatTmzRtSF
X-Received: by 2002:a17:902:c9c4:b0:240:967a:fec3 with SMTP id
 d9443c01a7336-24096b039f9mr76706175ad.29.1753968142852; 
 Thu, 31 Jul 2025 06:22:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdkzv0UB8hZXAZNJSRx7fvrF+ghTAzkodbggF+7N8UOp1sMJVjt16NRYmz0GBc/Cz9C+ISqg==
X-Received: by 2002:a17:902:c9c4:b0:240:967a:fec3 with SMTP id
 d9443c01a7336-24096b039f9mr76705475ad.29.1753968142140; 
 Thu, 31 Jul 2025 06:22:22 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:22:21 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:50:43 +0530
Subject: [PATCH v8 03/27] migration: push Error **errp into
 qemu_loadvm_state_header()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-propagate_tpm_error-v8-3-28fd82fdfdb2@redhat.com>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
In-Reply-To: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2889; i=armenon@redhat.com;
 h=from:subject:message-id; bh=YBAjAcKtlsbciFxmGnkfeB1uVPx9vchbnxKKM6HF8XY=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37tPSbuNstgctzZpSO1f6u+12faQ+90rjv4+CPKavb
 5892d7aUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCKpygx/uP3+lG7f2hY5a463
 8XLD91KbTQ3rruVcnXgw6k/G55v1kxkZrm1ZtWjP24AMlu60jGlbE1zd96T9u38/5tap58LH7Nd
 zMwMA
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
It is ensured that qemu_loadvm_state_header() must report an error
in errp, in case of failure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index ab947620f724874f325fb9fb59bef50b7c16fb51..842ff3dc6d5ccb05f7d33cef9f7319b141419501 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2814,35 +2814,44 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     return 0;
 }
 
-static int qemu_loadvm_state_header(QEMUFile *f)
+static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
 {
     unsigned int v;
     int ret;
 
     v = qemu_get_be32(f);
     if (v != QEMU_VM_FILE_MAGIC) {
-        error_report("Not a migration stream");
+        error_setg(errp, "Not a migration stream, magic: %x != %x",
+                   v, QEMU_VM_FILE_MAGIC);
         return -EINVAL;
     }
 
     v = qemu_get_be32(f);
     if (v == QEMU_VM_FILE_VERSION_COMPAT) {
-        error_report("SaveVM v2 format is obsolete and don't work anymore");
+        error_setg(errp,
+                   "SaveVM v2 format is obsolete and no longer supported, "
+                   "file version %x != %x",
+                   v, QEMU_VM_FILE_VERSION_COMPAT);
+
         return -ENOTSUP;
     }
     if (v != QEMU_VM_FILE_VERSION) {
-        error_report("Unsupported migration stream version");
+        error_setg(errp, "Unsupported migration stream version, "
+                   "file version %x != %x",
+                   v, QEMU_VM_FILE_VERSION);
         return -ENOTSUP;
     }
 
     if (migrate_get_current()->send_configuration) {
-        if (qemu_get_byte(f) != QEMU_VM_CONFIGURATION) {
-            error_report("Configuration section missing");
+        v = qemu_get_byte(f);
+        if (v != QEMU_VM_CONFIGURATION) {
+            error_setg(errp, "Configuration section missing, %x != %x",
+                       v, QEMU_VM_CONFIGURATION);
             return -EINVAL;
         }
-        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
-                                 NULL);
 
+        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
+                                 errp);
         if (ret) {
             return ret;
         }
@@ -3119,7 +3128,7 @@ int qemu_loadvm_state(QEMUFile *f)
 
     qemu_loadvm_thread_pool_create(mis);
 
-    ret = qemu_loadvm_state_header(f);
+    ret = qemu_loadvm_state_header(f, NULL);
     if (ret) {
         return ret;
     }

-- 
2.50.0


