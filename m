Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02BAC5474E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 07:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjDXs-0003ZX-Rv; Wed, 28 Aug 2024 03:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sjDXs-0003WP-0w
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 03:56:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sjDXq-00062z-Cx
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 03:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724831805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19Zh4Zt/ZVNN5Ajo9sSQWEIPYsVM5bJD7k1vakhLQ/o=;
 b=MhYmjhv010YmAqOdtuZBh+yIscWMJonTqbY36dn1vSzwLzB9yxQNswh+Ml+0uTKGVYQEiV
 jOV3lNNhC0bbuPMykIwbVRHFKquaFYzARHJie/7TS7db1pMVyS/Gu0VsafPVuCKnEXHBse
 IHh+GuAIpfTSAHQYcFM9tTA1Kuiq4Ww=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-QUjmGGYVMUeqQvgCgYAPQw-1; Wed, 28 Aug 2024 03:56:43 -0400
X-MC-Unique: QUjmGGYVMUeqQvgCgYAPQw-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-7b696999c65so5398011a12.3
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 00:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724831802; x=1725436602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=19Zh4Zt/ZVNN5Ajo9sSQWEIPYsVM5bJD7k1vakhLQ/o=;
 b=p4RR/PfaeGZIsbYCENZHVhqaBzLgVGnERCP+ZrVwlBkv9CHoGJjuELvuD1wScILQEA
 FKxZNm5fU3sYx1JtANIAIpzoQJSFLuRgO4Wr5tMrknPaQimNcyaOLykglf3vVH2G66rV
 LiXRtpkTDKKGnI4ow/VqHKcBab+Nlml0nSfI5mg/XxTvrHGQ7843GTRXb+rdvvRgS76Q
 gj3zFYfcvL4fO9AsJPFi1syg9ailLBfHZYJSARxTvzb2mSat6x/harDDyCpWVtTHZiTi
 gXSCiY0UbUBPrqZDP5yN82KkNw5ne86yNNESWA1Ty5khVq17NC8oNWl5XsaORXfhVH4T
 dbbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAdLOprADfMHP3xLH9vcFcl1bVRQOqheuCysv2Z0NYLwD4DDo6+vjyZKqG6N5avyVapOEuuTcyUhap@nongnu.org
X-Gm-Message-State: AOJu0YxH1v8H+FuOl1m/SX0PTZpKpdBdOGoG+vRpfWgy8/f45DgSl5J3
 yBJ9xP5pnX/pBbC10VIOE5dZXMpfG3KH6I4BLoJhTzwSBoieJkDyz3O1v/Bsk4Dv/5OJFCt6Uk7
 hcKdrYWgoddiwcue4RQkw1tzrq5r1SKNf1q0ZaFbtwlj/D5x5bX0S
X-Received: by 2002:a05:6a21:3409:b0:1c4:d4b2:ffe6 with SMTP id
 adf61e73a8af0-1ccd288d5d0mr1009068637.19.1724831801978; 
 Wed, 28 Aug 2024 00:56:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/HVRKqcTrIT/WM260RBM0Z07SE8tr4atgSV/pWEwV/3FDxDJ6N7qyGLfHX0GADHsgfQ5siA==
X-Received: by 2002:a05:6a21:3409:b0:1c4:d4b2:ffe6 with SMTP id
 adf61e73a8af0-1ccd288d5d0mr1009052637.19.1724831801581; 
 Wed, 28 Aug 2024 00:56:41 -0700 (PDT)
Received: from localhost.localdomain ([115.96.157.236])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2d8445fbf0dsm1013534a91.19.2024.08.28.00.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 00:56:41 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org,
 zhao1.liu@intel.com, armbru@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v5 1/2] kvm: replace fprintf with error_report()/printf() in
 kvm_init()
Date: Wed, 28 Aug 2024 13:26:28 +0530
Message-ID: <20240828075630.7754-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240828075630.7754-1-anisinha@redhat.com>
References: <20240828075630.7754-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

error_report() is more appropriate for error situations. Replace fprintf with
error_report() and error_printf() as appropriate. Cosmetic. No functional
change.

CC: qemu-trivial@nongnu.org
CC: zhao1.liu@intel.com
CC: armbru@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 accel/kvm/kvm-all.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

changelog:
v2: fix a bug.
v3: replace one instance of error_report() with error_printf(). added tags.
v4: changes suggested by Markus.
v5: more changes from Markus's comments on v4.

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 75d11a07b2..fcc157f0e6 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2427,7 +2427,7 @@ static int kvm_init(MachineState *ms)
     QLIST_INIT(&s->kvm_parked_vcpus);
     s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
     if (s->fd == -1) {
-        fprintf(stderr, "Could not access KVM kernel module: %m\n");
+        error_report("Could not access KVM kernel module: %m");
         ret = -errno;
         goto err;
     }
@@ -2437,13 +2437,13 @@ static int kvm_init(MachineState *ms)
         if (ret >= 0) {
             ret = -EINVAL;
         }
-        fprintf(stderr, "kvm version too old\n");
+        error_report("kvm version too old");
         goto err;
     }
 
     if (ret > KVM_API_VERSION) {
         ret = -EINVAL;
-        fprintf(stderr, "kvm version not supported\n");
+        error_report("kvm version not supported");
         goto err;
     }
 
@@ -2488,26 +2488,22 @@ static int kvm_init(MachineState *ms)
     } while (ret == -EINTR);
 
     if (ret < 0) {
-        fprintf(stderr, "ioctl(KVM_CREATE_VM) failed: %d %s\n", -ret,
-                strerror(-ret));
+        error_report("ioctl(KVM_CREATE_VM) failed: %s", strerror(-ret));
 
 #ifdef TARGET_S390X
         if (ret == -EINVAL) {
-            fprintf(stderr,
-                    "Host kernel setup problem detected. Please verify:\n");
-            fprintf(stderr, "- for kernels supporting the switch_amode or"
-                    " user_mode parameters, whether\n");
-            fprintf(stderr,
-                    "  user space is running in primary address space\n");
-            fprintf(stderr,
-                    "- for kernels supporting the vm.allocate_pgste sysctl, "
-                    "whether it is enabled\n");
+            error_printf("Host kernel setup problem detected."
+                         " Please verify:\n");
+            error_printf("- for kernels supporting the"
+                        " switch_amode or user_mode parameters, whether");
+            error_printf(" user space is running in primary address space\n");
+            error_printf("- for kernels supporting the vm.allocate_pgste"
+                         " sysctl, whether it is enabled\n");
         }
 #elif defined(TARGET_PPC)
         if (ret == -EINVAL) {
-            fprintf(stderr,
-                    "PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
-                    (type == 2) ? "pr" : "hv");
+            error_printf("PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
+                         (type == 2) ? "pr" : "hv");
         }
 #endif
         goto err;
@@ -2526,9 +2522,9 @@ static int kvm_init(MachineState *ms)
                         nc->name, nc->num, soft_vcpus_limit);
 
             if (nc->num > hard_vcpus_limit) {
-                fprintf(stderr, "Number of %s cpus requested (%d) exceeds "
-                        "the maximum cpus supported by KVM (%d)\n",
-                        nc->name, nc->num, hard_vcpus_limit);
+                error_report("Number of %s cpus requested (%d) exceeds "
+                             "the maximum cpus supported by KVM (%d)",
+                             nc->name, nc->num, hard_vcpus_limit);
                 exit(1);
             }
         }
@@ -2542,8 +2538,8 @@ static int kvm_init(MachineState *ms)
     }
     if (missing_cap) {
         ret = -EINVAL;
-        fprintf(stderr, "kvm does not support %s\n%s",
-                missing_cap->name, upgrade_note);
+        error_report("kvm does not support %s", missing_cap->name);
+        error_printf("%s", upgrade_note);
         goto err;
     }
 
-- 
2.42.0


