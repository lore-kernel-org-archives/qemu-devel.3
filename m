Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46465C54731
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 15:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sixqK-0004aW-Vi; Tue, 27 Aug 2024 11:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sixqH-0004Wk-SJ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:10:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1sixqF-0000WC-Mm
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724771442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M8CF5R5awVwAxYxGrhoKMF7ffh+xm8TgWTdEgRArz0g=;
 b=WdkjtXgOnDx/To9u0MkqMDsVWwExtNhtyemI/7Q1kA3FdGDYYDKgqQSanb138a5vv9trgH
 AbTpRqgCy3tE8zZeo5jfYHlPvyx5rYxgaxtiAZB84jRUotXZv9jHkLaRvaVng3+0mi0mFj
 8VRFJaXktfpJaWSz9ix2I2njzNb7dUM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-dD1HQeZCOBubHhU7uRIlfw-1; Tue, 27 Aug 2024 11:10:37 -0400
X-MC-Unique: dD1HQeZCOBubHhU7uRIlfw-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-7143af9568bso4524950b3a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 08:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724771436; x=1725376236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M8CF5R5awVwAxYxGrhoKMF7ffh+xm8TgWTdEgRArz0g=;
 b=qcCNevJT9TKc7rq2m0hgbKkfsZVkv6Mr5fglRS7ypnQ9qkIHkc7UsJV1lDw9P8sSsI
 M1W1+MesY/XkTGVgez5lUhPjdNu4Q+yUOjluoVHCbHgOabG8DuIdp+0vfyy+C4TVc2sa
 /+q3B4XCacxSOwXJQYjTkMSQ8SRUoz3UnuM2AMi5hP0zGsjA1J2vuDqmOqLAD7d1zB4g
 Owrb2M+6UGZXwheFvKBuYge77vJk8YiwXwpn5jTYSwYwQMp2RlKqpHUmhncycx+qzylp
 Xsbshze7wFfK0ybS+5bI5krhomxtDR7E80viVSEsv6aYGC0qnUoZP6wtR/ym6ypItUHv
 lhhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhXpVvMZElp8nqruR/UU/sGbi8W8CPEiVATe5QjmYjNbxiGzWU9cVRR01m7Klw/d1f6CUE+wRN+WE4@nongnu.org
X-Gm-Message-State: AOJu0YwYPU7DRp8m83TiCZWSs5M0T/aqFhs3PhvZMN9h228r3eyjyZJU
 +IDKliNN0ibcBrNylt2ew9VpcRwcgrjldQRLl00YdgB3QsoT3UcOnDa0J7J+MsFZ7Ivm3gDp55A
 aYf2zYk2l/XJktDOMEQkZjWScfx2NcucdfSeYutS2joc2XA4bWHUJ
X-Received: by 2002:a05:6a00:4f94:b0:714:2d92:39db with SMTP id
 d2e1a72fcca58-715bfff985bmr3440382b3a.16.1724771436495; 
 Tue, 27 Aug 2024 08:10:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmiDJHM76Y13C5DYfMIOZ/jwgV5kOIAra5Gn0srPjDkXgH00hJlfr7+YaxSbfw7ucDvYkfqg==
X-Received: by 2002:a05:6a00:4f94:b0:714:2d92:39db with SMTP id
 d2e1a72fcca58-715bfff985bmr3440342b3a.16.1724771436112; 
 Tue, 27 Aug 2024 08:10:36 -0700 (PDT)
Received: from localhost.localdomain ([115.96.30.188])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-7143430636esm8679062b3a.165.2024.08.27.08.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 08:10:35 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org,
 zhao1.liu@intel.com, armbru@redhat.com, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v4 1/2] kvm: replace fprintf with error_report/printf() in
 kvm_init()
Date: Tue, 27 Aug 2024 20:40:21 +0530
Message-ID: <20240827151022.37992-2-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240827151022.37992-1-anisinha@redhat.com>
References: <20240827151022.37992-1-anisinha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
error_report. Cosmetic. No functional change.

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

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 75d11a07b2..d9f477bb06 100644
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
+        error_report("ioctl(KVM_CREATE_VM) failed: %d %s", -ret,
+                    strerror(-ret));
 
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
+            error_printf("Host kernel setup problem detected. Please verify:");
+            error_printf("\n- for kernels supporting the"
+                        " switch_amode or user_mode parameters, whether");
+            error_printf(" user space is running in primary address space\n");
+            error_printf("- for kernels supporting the vm.allocate_pgste "
+                         "sysctl, whether it is enabled\n");
         }
 #elif defined(TARGET_PPC)
         if (ret == -EINVAL) {
-            fprintf(stderr,
-                    "PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
-                    (type == 2) ? "pr" : "hv");
+            error_printf("PPC KVM module is not loaded. Try modprobe kvm_%s.\n",
+                        (type == 2) ? "pr" : "hv");
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
+        error_printf("kvm does not support %s\n%s",
+                     missing_cap->name, upgrade_note);
         goto err;
     }
 
-- 
2.42.0


