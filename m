Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68CACA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBw0X-0002ZQ-Si; Wed, 30 Sep 2026 11:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0V-0002XQ-Dp
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBw0S-0000k3-Ur
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 11:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790781244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EN6eRhCXMBdbbKqBU4HbeNBBeUVb05+KYNAQ+SJ/VMU=;
 b=EMb4w40c+TAh0pH4vlq5NxPuiu7LJSak9QJPUPx7JnuddROIhT5Qb4K5JmLQNSVRwQssGA
 QSqUQsGXh4b7nMLz1kSEpNGTOMPP6KF1fk4ewOnL64KMN010ykgunAmXPfqLrIyQVDfQFW
 WRqjEPkDpN1q0XZMHssUYaRin1p+DFQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-LPleVmQ-MxKfQ-kcsY08pw-1; Wed, 30 Sep 2026 11:14:02 -0400
X-MC-Unique: LPleVmQ-MxKfQ-kcsY08pw-1
X-Mimecast-MFC-AGG-ID: LPleVmQ-MxKfQ-kcsY08pw_1790781242
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91789a9107fso35426896d6.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790781242; x=1791386042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EN6eRhCXMBdbbKqBU4HbeNBBeUVb05+KYNAQ+SJ/VMU=;
 b=CCAjimzChW8lfSr4GFRlro+arDx0nYbLu2U2vswRSRPqL9oKw4Bl0KAQsWeXnIN/v9
 wz5Ig0w8vsAFe5cZ5otPtVR9d6M8/BuNtSh5aDv87kE0Y9OJ3lsx3hwvsFZ4Z0yryDca
 KZx0RywVMrX7ltvD4NJZksNI5QCjZ0baMKs9UX4OTpifM6Ff+jcFHbSYwnWVMe/8JNvR
 gfUy0GNfiemaOsjAZHPAaKEUTtR6VjA+/r0Tp2LbPyCOwWdcmHSEpqi+hMuX2cMM3pmF
 VMRpsjgy/MB2aHL81yvauCOHPStDxKHkmfO0c4mePOomDj0LrqzdNpGUoM0UZlo8Eytd
 gszw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790781242; x=1791386042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EN6eRhCXMBdbbKqBU4HbeNBBeUVb05+KYNAQ+SJ/VMU=;
 b=Numb5g4yIdZ/rJRcGL9sl2zqIcMQrdEA0FlRLMMFKpD0/ZXVrhmEPTS1q2ApcDIAn6
 kFr1pJFtSopXQrGN16dRaBztr1y6h3XxDIS7qVAQu8hjnz4iWwN+6nWl047+gsDLpFEr
 K0sniUrswGkjKj6hXdUbPWD0Ax6q4teryNqq0/b/T0XCy88FEVkibSVGjrinxQjCafWP
 hI0RP+/xjas+k2/ny3tY7Nd7lMkdq4eI9/3J6yu0GnnD9eDEHIpN5RYShjjor5YX9HnX
 JCAx5SUUuHQVe2Bs875NR3bL8m3juRixMjgWSzL71I8NbiLXB4ROwwFEAM8XV8RRRZdf
 HJ8g==
X-Gm-Message-State: AFuF++k4UdY7mNv4VOMwf5COg7Y17uFIZcbSIdQ2WTNrtS0eEZMq8LKB
 0EiYoNC7fNJEyC6O8tci8WO5XfwGzHiQcnUI2ibAmCMMhiqQuvmdwHvJ6jWG2HX6YwgkaPKi94x
 cm8ctobj4AwpsXftivhCtZgQY9kGRjyh64mZvcbDPbuhK5sh/7CZWsundx9MK+dNvXKK6tR+nJ/
 u2JG/xaXYJ+NI6nVup2RLaMDat2s03okoxtXqs+4b3
X-Gm-Gg: AYBFou3MaoUOZktJYdPeHDohWkDawSeHKlnfHfYmrIkaMv0AzCaiAt0CSk+z0i2wjkk
 VCQWaVzfYk/9uXaYGcs6xGpMR54/yes2RXJbHXJE8APSHttOO9Fk8cVCWp8izSKXBitYPTebQgP
 eaoLL4oKdviRX7g3ICAt0eKltqL45pUgLa6muAr9n2It5V2Pbg05lioPIC3F6lAby3xZ3FUELDO
 fLZTI7EFcUL3Cb37mdzfGMtpi3H9rhj/NLMHQx3REWgL14L+IfQ4AZkh+J9ilv6c8hM/C/ojWca
 UCVWI9T5I7ztd2B2N3aUQzFg+w2p8K6mu03HD/YgtbAruBDynKQYpfSpVcQueH+DJWaRots=
X-Received: by 2002:a05:620a:2793:b0:939:993e:bffb with SMTP id
 af79cd13be357-93ca97440b2mr293562185a.22.1790781241693; 
 Wed, 30 Sep 2026 08:14:01 -0700 (PDT)
X-Received: by 2002:a05:620a:2793:b0:939:993e:bffb with SMTP id
 af79cd13be357-93ca97440b2mr293555085a.22.1790781241081; 
 Wed, 30 Sep 2026 08:14:01 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93ca83283besm136888585a.40.2026.09.30.08.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:14:00 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PULL 11/12] tests/migration-test: Support guest-memfd init shared
 mem type
Date: Wed, 30 Sep 2026 11:13:39 -0400
Message-ID: <20260930151340.2817042-12-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930151340.2817042-1-peterx@redhat.com>
References: <20260930151340.2817042-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Support the guest-memfd type when the fd has init share enabled.  It
means the gmemfd can be used similarly to memfd.

Signed-off-by: Michael Roth <michael.roth@amd.com>
Link: https://lore.kernel.org/r/20260929235109.1398509-12-michael.roth@amd.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/framework.h |  4 +++
 tests/qtest/migration/framework.c | 60 +++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 941cbd7102..10761f6e28 100644
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
index a830b96f41..b7aef6b21c 100644
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
@@ -296,6 +300,9 @@ static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
     case MEM_TYPE_MEMFD:
         backend = g_strdup("-object memory-backend-memfd");
         break;
+    case MEM_TYPE_GUEST_MEMFD:
+        backend = g_strdup("-object memory-backend-memfd,guest-memfd=on");
+        break;
     default:
         g_assert_not_reached();
         break;
@@ -444,8 +451,55 @@ int migrate_args(char **from, char **to, MigrateStart *args)
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
+        *reason = "KVM module doesn't support guest-memfd";
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
@@ -453,6 +507,12 @@ static bool migrate_mem_type_prepare(MemType type)
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
2.55.0


