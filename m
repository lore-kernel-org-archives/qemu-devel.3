Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974A3D5B86D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 20:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVFYr-0006hU-9l; Mon, 15 Dec 2025 15:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYT-0006NB-Hg
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVFYQ-0005rD-Ha
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 15:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765831945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LF7JnsCpnjxHRd2k7qGwgLD06GkanDYYSmy4s3TF9Ic=;
 b=eV+crgSOJysN0cOjOvnfTPH55Nutw2eIk3O2Rgl6PXVEAEaWCVN2rEYCXxjeyuYHt44MM2
 U6ozGKlV2nnyFptFRYHcP70SeGu9qN1QJu5m8LsZhLBHDD4jXidWxDJqFalK8zbCf+Bjoz
 cc+EW2qruzE9Ah/zg3UmACWo9b3FnPA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-qIY8hqqVPIy1vYPcsKaiEQ-1; Mon, 15 Dec 2025 15:52:23 -0500
X-MC-Unique: qIY8hqqVPIy1vYPcsKaiEQ-1
X-Mimecast-MFC-AGG-ID: qIY8hqqVPIy1vYPcsKaiEQ_1765831943
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-88a2d8b7ea5so25249176d6.0
 for <qemu-devel@nongnu.org>; Mon, 15 Dec 2025 12:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765831943; x=1766436743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LF7JnsCpnjxHRd2k7qGwgLD06GkanDYYSmy4s3TF9Ic=;
 b=ZTb7TEio9K+YysoxlmiHfxyjA2jAtsLNY/Q6YpFNomRLsQcHGaj3DwhD2gDI+SYhWB
 X89BaM3XzmN5VSU2Ok9UxZ6bxidfp1ek/Q8N+k7Pmi+DrbDEsXilg6eS6znMFppsWFdH
 sosfAnVBMzPNxS1YEuYcusMfEYYT2Hejsa7Wz48A7Ru0d4NIRdAeL/2RZBPNJE2iFc4p
 efzEId6GI7tsgpElgX3PGusEK9DEFIDNMyeg8heWmVYqF8l5bkHyOrBiGRrCDSRNTfci
 LVr+eqR6CsLngCsL83uGBCp4sEygCzDvgOV4Bm1xtZJG1wDqzs+hzeCXN9Y55LkRPEb7
 53tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765831943; x=1766436743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LF7JnsCpnjxHRd2k7qGwgLD06GkanDYYSmy4s3TF9Ic=;
 b=GGuGYBycSNRXl4iI/OtlH8XUXx0bqlMbHnwKyJKO8h2kQ/gdWRdeEH/tnGN7pS86C+
 j4TBirthlTFfUq37dsty3Jj7Yq1aQPgahfGK2H7v2AcJX52WVMdaX7iKlCyY6UrkFl7W
 kZ4MwEM8uppfWPQNZxNWF8lxSsiV9V5LYLn/iSRRwLviLEZMvWY9OzSWYmUdtwyk3AlZ
 EnKBB/APSF/+B4IT5EBHWFTk12bY+/DXeI/yxhCtbF51F9Cllo2/+t3ZrLdH72yGvXZQ
 XvDyB3mVwRTNIJ1M21AnEC6RlTvydH2p2z/D1svCLZmISDREt5WOFZ6o6TTMA5OunWeN
 0gaA==
X-Gm-Message-State: AOJu0YwSbCZNpCzif+m+Dq3JRTFhRX0aH8o8IbcapZaGV+DEVqwtCK77
 1KbbYubQHNOmhV2XzVBzQ8sA5WX+NZOxdz4EPkzJmGn1oIqB8lFrYL0/mIzoiCU5LHoCkWl2/vy
 EW/JQxnsimuSMrn9yfDdIgCpDLVYb3rRmb2Zglk0l22d7moYveCcCxRhquXdBy2850bgLyk9orV
 BIJolgXXwzQq1QKiNbRTmmvDrMeqYhYogT9HnWbQ==
X-Gm-Gg: AY/fxX4uSoAc0z/cfI2LIu+Lozx6XjbdlPB4/XVsUnIxPiZAKggXUYw3qsCkIKpOQrL
 XxAshCsAmxy08GvivzlCD/PAadJIDJJ13wOQePXXiwFf6cw67KpdLvibxNm9y8EyPWD9JFZnVT3
 bUTdJIzOUottASlERC4mfG1bBTX2r1T+LJuejl9XdfMzj1kZ9J6HQLQuVDEYmceUjzmG5hZZkds
 Q2LZVcygzwUY38Tpou8ejxt+Pe/XF+Rnil/kc8yctAH4PMskWsdMpj3u3vPulut6N3QH6P9nGo7
 c+1gWO2yQOheAfmT7+koBXcBLaK0gm0seygbYILDXTwUpwKj5a8ePt23mlCzC09+GWtKuiVZywJ
 Q
X-Received: by 2002:a05:6214:2608:b0:88a:35cf:8db3 with SMTP id
 6a1803df08f44-88a35cf91c7mr77365106d6.18.1765831942643; 
 Mon, 15 Dec 2025 12:52:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXvVvlLUuaI3CmDkGYxq2/j0XDR1RDPya0LwZRhuGWiIDckeBmdcsfCDNbJglmvpzeF3TgBw==
X-Received: by 2002:a05:6214:2608:b0:88a:35cf:8db3 with SMTP id
 6a1803df08f44-88a35cf91c7mr77364646d6.18.1765831942059; 
 Mon, 15 Dec 2025 12:52:22 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8899ea3621bsm58726236d6.36.2025.12.15.12.52.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Dec 2025 12:52:21 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Alexey Kardashevskiy <aik@amd.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: [PATCH v3 11/12] tests/migration-test: Support guest-memfd init
 shared mem type
Date: Mon, 15 Dec 2025 15:52:02 -0500
Message-ID: <20251215205203.1185099-12-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215205203.1185099-1-peterx@redhat.com>
References: <20251215205203.1185099-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
index e35839c95f..9aa353bac6 100644
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
@@ -283,6 +287,9 @@ static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
     case MEM_TYPE_MEMFD:
         backend = g_strdup("-object memory-backend-memfd");
         break;
+    case MEM_TYPE_GUEST_MEMFD:
+        backend = g_strdup("-object memory-backend-memfd,guest-memfd=on");
+        break;
     default:
         g_assert_not_reached();
         break;
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


