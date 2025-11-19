Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117C5CF397E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 17:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLm02-00038b-2B; Wed, 19 Nov 2025 12:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzq-00031c-IQ
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vLlzn-0004Pr-HS
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 12:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763573369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mT/ZTbTQ7j2oul5VXYz9qUwuJg/LSQ1GLNpf4vuAZng=;
 b=HVfWAERB+1fU93DK5c5rOgFn2qQWS4WqBu+50PXIs5rReQLDzoyBnHq4rou0mE2Uou3udI
 RYrbNQhGNQqNhYMub3r6JgvbWuN+gTnHaxAtcS8KBbwaj5G+VX+EYIDdjWnnx0tN8oABSE
 Qfm6yhTaDGPYCBL4AobAHIwgeoO+MTY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-BrrmIwpyM2OsbWX0rHj46A-1; Wed, 19 Nov 2025 12:29:28 -0500
X-MC-Unique: BrrmIwpyM2OsbWX0rHj46A-1
X-Mimecast-MFC-AGG-ID: BrrmIwpyM2OsbWX0rHj46A_1763573367
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b233e206ddso1878450285a.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 09:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763573366; x=1764178166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mT/ZTbTQ7j2oul5VXYz9qUwuJg/LSQ1GLNpf4vuAZng=;
 b=cfZe1wONhHXlD2sx/LKR5qF/wjFgMqohwCtjqSULpijFCoGF+cUTyegEqxsZ+UGwBD
 p2hKcVzoFx4cu3tPyu9sGFBgGTzHh9znHcM5mVqGgQgvzDt2smGHxgvprDNUG8lLJ+I3
 3W1haR0HZnm+oASAI7Ha0FrOOC8LtKL3G8kTN6iJcGQapUqH5woymrccJSND8bryw9JE
 3huF/Mf+y7wRG2xOmYLwKt816pOW0By+YsulWqD/pVVw2sPxVA/Q/LNJG5QYsLrQQ112
 mMtxDoMUtCnzdy9Oh+963UIiVhSSutEpTWjifjYctGXNddrY+21wuFIiiRNtzP48cjKg
 NXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763573366; x=1764178166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mT/ZTbTQ7j2oul5VXYz9qUwuJg/LSQ1GLNpf4vuAZng=;
 b=DffXNDbCC+06isqVLTDt1CLGRMIwQgOrM3Hi0UZkoKJdsTyXpxKChxHRvafpJlhcxH
 tBGSVQ6uifge1UnlQXlryMUUoeplFb6y+vYR20WX0lPPhk5TeZ9w/cbhBdLrm4Jt4Z/d
 rZQa8C51ZMn/sUQhWtzIGn8ItXt6Yhf6rHk/PMszOiAQpkeIVQU31811T7/XKlb1j7Vg
 z1pYvV3j65Ir6ko/Rr0XkwFndaLKzOe6jEKn+O+02LmxEgz3NKr7nqDxm9LGV4UDYegH
 XKzpOsC0X54XuyEaYoll7rXV7Jx4u3oV9Z8ai+sU9OXrUT5ipMkJGoMOnBtt+UweiiE5
 wljw==
X-Gm-Message-State: AOJu0Ywtb2RRaIOrjh2okG81FO1DiK/pqgOu2ADvRwhydsUiuSbhm6HC
 pjYN3rlf75IzAwelktaVKYCIkWzSCmn7imfdcUjGQzkjGh8RYTXwWf5FPiVifumVPTWBVOxuZxj
 Mqx8MLVnEtTPx/3OrCuqoDr7e5rBYAJgQ6NzE6CIT7vVaolt18j/XvjpUvm4wacgJQJfKHK63uW
 xLNsiRzBzUNaV5wJaVC54sHouPPFu0K2Wp9lMjoQ==
X-Gm-Gg: ASbGncsub2l/FhNSqeFdPvD2oPijPRUTnRYnKarru/YdsaE6JR5qPHa6gCN/+/39DIf
 rlYEYdIjGXTtlmskACzSreM5dI0OExM+4klMA+vMOjJWjpEdfcTzxAq2s6OPy13mDlpJ0UQzBDK
 txurlYoOKJr1xcfQWeFJLOUH4nAj18qWNFeqDVUZhdZENMDVaf770O3lZRV+OvVWDVckeuX4/Rw
 pxYLlyCacrNkLhcLHjMJienkP+AgAj3GwWUHCp+gjMixfnQfaR9acHrgjkMSSwH/9MjvK1bDGDq
 gYNzw15Z/dsLk+z39Vwqgv0SCs7DNzt5LPSSM5bGhKDqnJ+7pXbEAOjbyRl3rTPoSaqPT/T4RVn
 p
X-Received: by 2002:a05:620a:1724:b0:8b2:e1da:7532 with SMTP id
 af79cd13be357-8b327321202mr25676985a.34.1763573366362; 
 Wed, 19 Nov 2025 09:29:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdHSRxnSzvkY2AhBaph2YGKHOABMh41v1V1DQTAu5wWGg8/33DDdRSIXzXKE+omjl3bNwIQw==
X-Received: by 2002:a05:620a:1724:b0:8b2:e1da:7532 with SMTP id
 af79cd13be357-8b327321202mr25672385a.34.1763573365774; 
 Wed, 19 Nov 2025 09:29:25 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2af042c9csm1444759485a.46.2025.11.19.09.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 09:29:25 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Alexey Kardashevskiy <aik@amd.com>, peterx@redhat.com,
 Chenyi Qiang <chenyi.qiang@intel.com>, Juraj Marcin <jmarcin@redhat.com>,
 Li Xiaoyao <xiaoyao.li@intel.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 8/9] tests/migration-test: Support guest-memfd init shared
 mem type
Date: Wed, 19 Nov 2025 12:29:12 -0500
Message-ID: <20251119172913.577392-9-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119172913.577392-1-peterx@redhat.com>
References: <20251119172913.577392-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Support the guest-memfd type when the fd has init share enabled.  It means
the gmemfd can be used similarly to memfd.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.h |  4 +++
 tests/qtest/migration/framework.c | 60 +++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index ed85ed502d..b4c5edcad3 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -34,6 +34,10 @@ typedef enum {
      * but only anonymously allocated.
      */
     MEM_TYPE_MEMFD,
+    /*
+     * Use guest-memfd, shared mappings.
+     */
+    MEM_TYPE_GUEST_MEMFD,
     MEM_TYPE_NUM,
 } MemType;
 
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index 81eae09c92..73536c8f29 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -26,6 +26,10 @@
 #include "qemu/range.h"
 #include "qemu/sockets.h"
 
+#ifdef CONFIG_LINUX
+#include <linux/kvm.h>
+#include <sys/ioctl.h>
+#endif
 
 #define QEMU_VM_FILE_MAGIC 0x5145564d
 #define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
@@ -279,6 +283,9 @@ static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
     case MEM_TYPE_MEMFD:
         backend = g_strdup("-object memory-backend-memfd");
         break;
+    case MEM_TYPE_GUEST_MEMFD:
+        backend = g_strdup("-object memory-backend-memfd,guest-memfd=on");
+        break;
     case MEM_TYPE_ANON:
         backend = g_strdup("-object memory-backend-ram");
         share = false;
@@ -425,8 +432,55 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
     return 0;
 }
 
+static bool kvm_guest_memfd_init_shared_supported(const char **reason)
+{
+    assert(*reason == NULL);
+
+#ifdef CONFIG_LINUX
+    int ret, fd = -1;
+
+    if (!migration_get_env()->has_kvm) {
+        *reason = "KVM is not enabled in the current QEMU build";
+        goto out;
+    }
+
+    fd = open("/dev/kvm", O_RDWR);
+    if (fd < 0) {
+        *reason = "KVM module isn't available or missing permission";
+        goto out;
+    }
+
+    ret = ioctl(fd, KVM_CHECK_EXTENSION, KVM_CAP_GUEST_MEMFD);
+    if (!ret) {
+        *reason = "KVM module doesn't suport guest-memfd";
+        goto out;
+    }
+
+    ret = ioctl(fd, KVM_CHECK_EXTENSION, KVM_CAP_GUEST_MEMFD_FLAGS);
+    if (ret < 0) {
+        *reason = "KVM doesn't support KVM_CAP_GUEST_MEMFD_FLAGS";
+        goto out;
+    }
+
+    if (!(ret & GUEST_MEMFD_FLAG_INIT_SHARED)) {
+        *reason = "KVM doesn't support GUEST_MEMFD_FLAG_INIT_SHARED";
+        goto out;
+    }
+out:
+    if (fd >= 0) {
+        close(fd);
+    }
+#else
+    *reason = "KVM not supported on non-Linux OS";
+#endif
+
+    return !*reason;
+}
+
 static bool migrate_mem_type_prepare(MemType type)
 {
+    const char *reason = NULL;
+
     switch (type) {
     case MEM_TYPE_SHMEM:
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
@@ -434,6 +488,12 @@ static bool migrate_mem_type_prepare(MemType type)
             return false;
         }
         break;
+    case MEM_TYPE_GUEST_MEMFD:
+        if (!kvm_guest_memfd_init_shared_supported(&reason)) {
+            g_test_skip(reason);
+            return false;
+        }
+        break;
     default:
         break;
     }
-- 
2.50.1


