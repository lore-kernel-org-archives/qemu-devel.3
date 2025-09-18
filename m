Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C60CA1013
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 15:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzGXQ-0001le-Dr; Thu, 18 Sep 2025 11:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGXP-0001dB-3p
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uzGXN-0003LQ-3a
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 11:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758209227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ex70HvFHCA+0PjVijQlAjy4Lm+10k8XimyJ545WFrYo=;
 b=cXoP2JJOl7UwPCe2THd1XeQg73J6M6wIF58iCuR62bM2/BNCGQ83cMGCy1xOg4lra0Icnl
 imOWUDsfguBKBxrYasBjXmMRDrM4+CSauZ5DCn3XlR6YHPT+y/8QMkNohIg45sK07kStw3
 1NsXWifxFW32oreXHNKjmDNADzQArCE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-iheU-HeiOxKdHmT3d41tSA-1; Thu, 18 Sep 2025 11:27:06 -0400
X-MC-Unique: iheU-HeiOxKdHmT3d41tSA-1
X-Mimecast-MFC-AGG-ID: iheU-HeiOxKdHmT3d41tSA_1758209225
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-77df7f0d7a3so284170b3a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 08:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758209225; x=1758814025;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ex70HvFHCA+0PjVijQlAjy4Lm+10k8XimyJ545WFrYo=;
 b=Zh3cohye1vgKckyA/BtZsg8Mf+Wed1XaMis9ZwZbSthPo/rntzFRFuGuOc41SvNebR
 1bTeVK9e/vtFg1Ky1XtOIXHudTduVK7VO/sdK3etrXfrn33evGCpPhs2b0aJSPAYTmee
 BdmIXgdSi3cFtFJMm3FfYlMHgOF8EYaqMPl25mYUZlsjlTU+Ct+pVpLB560SwFqT79qL
 /+uxBjyMoM18e6aDxbgTnWz4tK0D65xc1VNq59Cu32JDTOubjM4ph/+GYodi0Fh2PPDN
 slFIs0ThzHAXoOgHZlsBi0rxH9RrXjAxGxIGJ6n2/oyIvsW7uxhCsjB1UiZ8tc2wYMsI
 ZyUQ==
X-Gm-Message-State: AOJu0YyZBCYGLMZ6PDrogFpxKKD8WuvwAdSHRL2okd8z/niL/uFfGljT
 xIo0i91wRQQmNI2IH4f4IjvLW3Lk8tl5y5Q6I+qHR05jc5JNDdDhQljTq4rWgTVd+PziMa66JK3
 wBTQ5rt3RC/UvdBtFchjA5n2FmNoBu3ohr9R9HT/8rjJ0Debu4rxDn9Ji
X-Gm-Gg: ASbGncsJVdQmSYOxMOc0V0F4GLIiD1oWN18TrggEtU8fsgKTjvR0/M3we3H2mz5ZG+8
 wYts0QXmq9PZY2ftxXmNgiMG1Hyp3OpkxZ39LQfSonF9ggG8uUEakm2KR/KTR+JTzGGho4qwqi5
 EakzN/JHab9RVbxru3yaA76M09IORoC+y9UC4z1DisrZ2U79KHsMwh/VTKVkByw/V+sgf6I+iln
 TSj5uflQRsyxgQzDwh3j+ZA10yPahG9Vy58/IaaFX7lWSvfWn7Le/L59pLMVWKTLW2lT0EQgK4b
 bShZUHMJfbJkJL/qADuI7q8IbKQOaWFDPYSCsT5HirxFnVEnR6kzxQ==
X-Received: by 2002:a05:6a00:3c95:b0:770:343b:5457 with SMTP id
 d2e1a72fcca58-77bf926836cmr6879150b3a.16.1758209225201; 
 Thu, 18 Sep 2025 08:27:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFptHNEH9tCswXZHG2989Rs4/bM38KSXM8njI1sTSjzTP5FFJDpvoHgN/7DxjhUWdGBd3ATxA==
X-Received: by 2002:a05:6a00:3c95:b0:770:343b:5457 with SMTP id
 d2e1a72fcca58-77bf926836cmr6879099b3a.16.1758209224779; 
 Thu, 18 Sep 2025 08:27:04 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.110.230])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77cfc2481d7sm2675512b3a.32.2025.09.18.08.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 08:27:04 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 18 Sep 2025 20:53:40 +0530
Subject: [PATCH v14 23/27] migration: Capture error in
 postcopy_ram_listen_thread()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250918-propagate_tpm_error-v14-23-36f11a6fb9d3@redhat.com>
References: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
In-Reply-To: <20250918-propagate_tpm_error-v14-0-36f11a6fb9d3@redhat.com>
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
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2083; i=armenon@redhat.com;
 h=from:subject:message-id; bh=dpJRFzd7gm8KScLE3AM8NwdARIO3OP6+DoU1jE8PGBM=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YZ5R+7/CLWHG3a2ZqctLtjyjUD7Vfaq7ea3X7F+m2yw
 k2/lPKzHaUsDGJcDLJiiiwNXwNkmwIKIyJtX16HmcPKBDKEgYtTACbiYcnwT3H+thUT+C4vP+QX
 Pyu/SnOhc6zFK+3fs59HeAsxrAn5sZWRYf+jHasnaa5uLmxb57vbc0XvoowGI6EJDeWTJN+p675
 VYwMA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
postcopy_ram_listen_thread() calls qemu_loadvm_state_main()
to load the vm, and in case of a failure, it should set the error
in the migration object.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index b0fd51d0f142c30ce21bdc02204ce947283fea49..71f4d8399349934134c2c02609d3ede6f61754f8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2095,6 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     QEMUFile *f = mis->from_src_file;
     int load_res;
     MigrationState *migr = migrate_get_current();
+    Error *local_err = NULL;
 
     object_ref(OBJECT(migr));
 
@@ -2111,7 +2112,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_file_set_blocking(f, true);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
-    load_res = qemu_loadvm_state_main(f, mis, &error_fatal);
+    load_res = qemu_loadvm_state_main(f, mis, &local_err);
 
     /*
      * This is tricky, but, mis->from_src_file can change after it
@@ -2137,7 +2138,10 @@ static void *postcopy_ram_listen_thread(void *opaque)
                          __func__, load_res);
             load_res = 0; /* prevent further exit() */
         } else {
-            error_report("%s: loadvm failed: %d", __func__, load_res);
+            error_prepend(&local_err,
+                          "loadvm failed during postcopy: %d: ", load_res);
+            migrate_set_error(migr, local_err);
+            error_report_err(local_err);
             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                            MIGRATION_STATUS_FAILED);
         }

-- 
2.51.0


