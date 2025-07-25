Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B532EC87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 12:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufHTq-0005Sl-2U; Fri, 25 Jul 2025 08:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHRH-00028g-Pj
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ufHRF-0000eo-4R
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 08:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753446130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wa0g303nr2kLIRTVVkMvTl0mPrmuwUjfpO4DgJqaVk4=;
 b=TgWTzUvPVVP97ZU5Nz+HVcTYhUVm0B62HlTXlnFClBrIiuKdrxbL4DeITI7sI4qn3vPGtr
 MUrbCWhza15L+efW7jJfpC+R/tVODk5hb/JTIAyGJhDT9qLXq6384xkudxQhtvQQBFZB4v
 q442GkJpe7NlIFdEutv6GokLxd4VnNU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-0mrWFRHpNDqDIJ7NubSorg-1; Fri, 25 Jul 2025 08:22:09 -0400
X-MC-Unique: 0mrWFRHpNDqDIJ7NubSorg-1
X-Mimecast-MFC-AGG-ID: 0mrWFRHpNDqDIJ7NubSorg_1753446128
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-31e3fdf1906so2016420a91.0
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 05:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753446128; x=1754050928;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wa0g303nr2kLIRTVVkMvTl0mPrmuwUjfpO4DgJqaVk4=;
 b=eh/F/j7k0YZiZ52nErZmuGAW6+/lcM8mdDegrF/jUBeluhODyvXKhrSQfU9sFLt0AP
 s2E854PSCIsTK4lJyQUIqX22IpFfj8FRtEJyHjG41AQ4gkOnCZr/Mus+lHr3k6MnaiSN
 bxXTrEAO/HhsiyZh0U69HXyMof1N3Ao02jPeQqmR/5LPittimETZ2ElUO1FU6TsM5iXt
 VRE5qbcLmRYxa0n3n07198ngFTBBHASB/sYKpU24SgO04QRL+4Ojihi0NlDGDFEFZbqJ
 71ghL4jDruR3sZPYWvsO1d3vdzrl72FsvG+L98d5X02BTa/JZj1X3ODmB305C89Zm82e
 ZoBg==
X-Gm-Message-State: AOJu0YxYJnHjQVAsBSkz7soKdq7ZdjSpebH3AXHzBKJbYBb6zxcIWByq
 lX+nZrr9GSOSLzuXw12r6T1em0tWQankzu8vRt9JGbz6CGl0VfCghkkqmgnu/3TZ5nr7NQIEtFy
 2lEo9vRoaVRD6/HflASPHhTA1fExQzxtQA6L6R4FWLKNmgCSOepc4qSX/
X-Gm-Gg: ASbGncvCX1su3kjOiXb0dfsEs6Zd9OUpSvcx2kEV33cY+QmwdONNqMtTYU+pKUynm9j
 1w10uzm6sXAscP5pFmaISkbmAD+TPQxbmkxFu9PqMD5IOeFgh37omKJlV7dhze6Szj4hMUbAtDq
 +B8RN9Ozo/0/CCwfsPnxiZnJJcACg0m4vcTt1W9v3baSnmypBbGa4qGaWgF+hsOB7OwymUcIT/C
 +Dw4KfxfmlHhIYqhpauPLe0pQaezeoT6dVG2hxuKVsBAqCzlzJ8vSIXiJoBNpWQpyqvz6EMmu7M
 wsTYD5ylsA03s37yIVsBc4B5IrHWCl/CtCbKWWqHoGxzK4dpnTcCqQ==
X-Received: by 2002:a17:90b:3946:b0:313:283e:e87c with SMTP id
 98e67ed59e1d1-31e77841b33mr2513794a91.3.1753446128030; 
 Fri, 25 Jul 2025 05:22:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQw1AZ3b7nIs8vWteb/hEPwjabDOuSmaGFIysndTYKEuJpoNpr8blyNMG4fSb5qesm/XjNtQ==
X-Received: by 2002:a17:90b:3946:b0:313:283e:e87c with SMTP id
 98e67ed59e1d1-31e77841b33mr2513730a91.3.1753446127434; 
 Fri, 25 Jul 2025 05:22:07 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.103.239])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31e662df8dcsm3419352a91.25.2025.07.25.05.21.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 05:22:06 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 25 Jul 2025 17:49:00 +0530
Subject: [PATCH v7 21/24] migration: push Error **errp into
 qemu_load_device_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-propagate_tpm_error-v7-21-d52704443975@redhat.com>
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2661; i=armenon@redhat.com;
 h=from:subject:message-id; bh=MS0ku2z4FlNI7J2z6kkZ113Hs326QuZRIGEPk3M5DJk=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Zzma4tK5dwaicbf/OCHM0lL38wBf5NrbjPJWP8z6bLn
 n/2e7OOUhYGMS4GWTFFloavAbJNAYURkbYvr8PMYWUCGcLAxSkAE0layPC/eMkr0+e1E5+q6Rbx
 iS27Y6ievavrmVFqggZrxKla+UPLGP6HXPUTt7Fte5G1IvC/1vei7gWJzz/fPGT6cVcwh6ZqeyA
 nAA==
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
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
It is ensured that qemu_load_device_state() must report an error
in errp, in case of failure.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c   | 4 ++--
 migration/savevm.c | 6 +++---
 migration/savevm.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 5507dc25da24e0c6b030ac5563d663d70d013671..ec4ddc61d8ff7c4aebcd60a0d44286b0196adc34 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -729,9 +729,9 @@ static void colo_incoming_process_checkpoint(MigrationIncomingState *mis,
     bql_lock();
     vmstate_loading = true;
     colo_flush_ram_cache();
-    ret = qemu_load_device_state(fb);
+    ret = qemu_load_device_state(fb, errp);
     if (ret < 0) {
-        error_setg(errp, "COLO: load device state failed");
+        error_prepend(errp, "COLO: load device state failed: ");
         vmstate_loading = false;
         bql_unlock();
         return;
diff --git a/migration/savevm.c b/migration/savevm.c
index acdd32159bb303907af64b7970168112fcce2514..810bba9799246c8d57514be0927bb474edee8e9b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3243,15 +3243,15 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp)
     return ret;
 }
 
-int qemu_load_device_state(QEMUFile *f)
+int qemu_load_device_state(QEMUFile *f, Error **errp)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
     int ret;
 
     /* Load QEMU_VM_SECTION_FULL section */
-    ret = qemu_loadvm_state_main(f, mis, NULL);
+    ret = qemu_loadvm_state_main(f, mis, errp);
     if (ret < 0) {
-        error_report("Failed to load device state: %d", ret);
+        error_prepend(errp, "Failed to load device state: %d: ", ret);
         return ret;
     }
 
diff --git a/migration/savevm.h b/migration/savevm.h
index a6df5198f3fe1a39fc0e6ce3e79cf7a5d8e032db..c337e3e3d111a7f28a57b90f61e8f70b71803d4e 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -68,7 +68,7 @@ int qemu_loadvm_state(QEMUFile *f, Error **errp);
 void qemu_loadvm_state_cleanup(MigrationIncomingState *mis);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis,
                            Error **errp);
-int qemu_load_device_state(QEMUFile *f);
+int qemu_load_device_state(QEMUFile *f, Error **errp);
 int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy);

-- 
2.50.0


