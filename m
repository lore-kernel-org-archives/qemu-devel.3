Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596F8C83F27
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 00:40:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucCeh-0002fZ-6f; Wed, 16 Jul 2025 20:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCeg-0002ea-6x
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:39:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ucCee-0004Y6-K1
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 20:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752712759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EXyUbQoBNcXsENFuDMuS7Qrxn0mugpdK4PrcpSGb/kQ=;
 b=b7bYDcO61dpAVD0WKPlyjIPrHBJvH5AmZ3tQGG6COHxEts/i8snoPYhoxTxxVl+sjniR08
 ZAYDRZLZgiaKLTXZtrO9ZfQlUealTYwUSjBgITuQjaFMsnA8xPp3jCeHzCOkIiCFKvaYo8
 o4Zaa74iDyqDdy0j6eeKrG8xuuQNZZ4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-6NiZWt9QPqax3FGo2x_tGg-1; Wed, 16 Jul 2025 20:39:17 -0400
X-MC-Unique: 6NiZWt9QPqax3FGo2x_tGg-1
X-Mimecast-MFC-AGG-ID: 6NiZWt9QPqax3FGo2x_tGg_1752712757
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31218e2d5b0so532903a91.2
 for <qemu-devel@nongnu.org>; Wed, 16 Jul 2025 17:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752712757; x=1753317557;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EXyUbQoBNcXsENFuDMuS7Qrxn0mugpdK4PrcpSGb/kQ=;
 b=jPDFf6Gws4yKQNHBLZrqGNheCDeQEczfC5x5D2Fsjmf43XgWQI/2yiM/3i7b4IK4h+
 3CmzUeFTt5yijU3ix0WGR6tyZKtJac9LD5exnkGmnj6uO5kyA/GBJFAtvKesrpKKJ6Bu
 3q+7YOOMQDb9nQV4YwXJrYSLdjCdfMciX+6Ea3z6O9Y3TVyU5o2DcUl7UwywpntEN4Dr
 LLHsbjmTDHGgc9FLymWVcQEqYrdUI73ursdp0PVNjv65AHUWSjD1ELF6RFzVnQc/E/RW
 ClnN9xXfAVliDVxF5TuCQCoc6Q6gzXMsxEArqZQ/3+Ar/kSy+sC+etdfEHgG1ieOzFVp
 kc7Q==
X-Gm-Message-State: AOJu0YzbsxCHtKW0mLOLPLTGQ/SXtSgrFM0S5dZvjZH0azKJhivp/sBN
 GPX3fSsfG1fZSQeluV131YCspyIW0ffcUsG2oZ59sSUCiLS9VMzPAOiDVcLZfEoy8EnUvGYbHEH
 mvtDxU6Zu4oJSKNwRWaQX+5xCkqjHfHp7W0Zy+rWwJv68MNhNQQsHJw75
X-Gm-Gg: ASbGnctKSbiA8i92B2pKRB4p32oNf6g2EPkGzZs4Pg7mgxVupCUiGQnM/2UCbX9HF2m
 qQ61RUndKWi+5zRhFWCzffa6W756svBV4XIJwniGGoEyUXudrxjI9awsNonwaJWm5P0s5znajkU
 9C1EjpMCH3FztJtXMrbMUQgi00Ni+acNlPqy0gcT96hkY/qYzDABjBfmiXmOmO6vg8NFVN4J+uF
 Rxo1waNl9JrzVnxxy/x7eWKErzxDx83hSvtEf0RIPye73pTdNxMUbwYAMuCBnJNCuqDhaRXq9VL
 wUwRI8R9Dtg/P8wmxhs6u/8Ac1v4cxHA8y1/yTTEvr/pHpk6IJn+
X-Received: by 2002:a17:90b:270b:b0:311:ab20:159a with SMTP id
 98e67ed59e1d1-31c9f47ce74mr6134344a91.29.1752712756791; 
 Wed, 16 Jul 2025 17:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEs1+QxcPm9FrDoViLUUkeVA2kr0YIY05BgzumFtAUTs0fvqi76SJfqXkfgYQ9q9Rr+/iUVEQ==
X-Received: by 2002:a17:90b:270b:b0:311:ab20:159a with SMTP id
 98e67ed59e1d1-31c9f47ce74mr6134295a91.29.1752712756296; 
 Wed, 16 Jul 2025 17:39:16 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.97.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f287c19sm2214424a91.31.2025.07.16.17.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jul 2025 17:39:16 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 17 Jul 2025 06:07:24 +0530
Subject: [PATCH v5 01/23] migration: push Error **errp into
 vmstate_subsection_load()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-propagate_tpm_error-v5-1-1f406f88ee65@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2651; i=armenon@redhat.com;
 h=from:subject:message-id; bh=PPQSg2D/z7rxR30HP+zMBBa7rifIbjqJASAnbuzYPXw=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0aFm9z3qPS7F348EplyST0mxveOvv28JH0jK/UXqdv+X
 LotfvBURykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgImcKWBk+Phy0vOm7drf+0ot
 NoiEbZ2yovi0xoXAW3nPOP7uSIo8t5Lhr5T9606xTbcb25+a8EeenGGSImN2d/stJ7N3jdZFIXs
 XcgEA
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
It is ensured that vmstate_subsection_load() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/vmstate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 5feaa3244d259874f03048326b2497e7db32e47c..526668a020562f303d2ddf030b1c8466659b67be 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -25,7 +25,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque, JSONWriter *vmdesc,
                                    Error **errp);
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque);
+                                   void *opaque, Error **errp);
 
 /* Whether this field should exist for either save or load the VM? */
 static bool
@@ -225,7 +225,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         field++;
     }
     assert(field->flags == VMS_END);
-    ret = vmstate_subsection_load(f, vmsd, opaque);
+    ret = vmstate_subsection_load(f, vmsd, opaque, NULL);
     if (ret != 0) {
         qemu_file_set_error(f, ret);
         return ret;
@@ -566,7 +566,7 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
 }
 
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque)
+                                   void *opaque, Error **errp)
 {
     trace_vmstate_subsection_load(vmsd->name);
 
@@ -598,6 +598,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
         if (sub_vmsd == NULL) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
+            error_setg(errp, "VM subsection does not exist");
             return -ENOENT;
         }
         qemu_file_skip(f, 1); /* subsection */
@@ -608,6 +609,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         ret = vmstate_load_state(f, sub_vmsd, opaque, version_id);
         if (ret) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
+            error_setg(errp, "Loading VM subsection failed : %d", ret);
             return ret;
         }
     }

-- 
2.50.0


