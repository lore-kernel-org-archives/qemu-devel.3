Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32062EDE9AD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so58j-0006FO-CM; Tue, 10 Sep 2024 13:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so58g-0005z8-Aq
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:58:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1so58e-0006Py-Qk
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:58:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725991132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W1o7RWjo2eKLI9AA0Cw5dV9rFqNRkMKq+jR+W5pV6tA=;
 b=fb4pCOZNgZO/HWgMGViddzcxu7q9q6bIpZ/sV44DdgUnQw3v/Kxhc5rMwRM3J7Wsw0hjX3
 8Hqvq8daH41ibyip7Vy2AfgwxVflSKWjBMK4z4/rPyVuAkRV3dHiHlcNoJEXNnbP7mPwaA
 f5gt1anvZkpOvxXXs1ML2pOU3I5q8/c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-UgMd9pHgNt6bA04nVOmajQ-1; Tue,
 10 Sep 2024 13:58:49 -0400
X-MC-Unique: UgMd9pHgNt6bA04nVOmajQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C21361956077; Tue, 10 Sep 2024 17:58:47 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.32.182])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0AD61195605A; Tue, 10 Sep 2024 17:58:42 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v1 06/14] s390x: introduce s390_get_memory_limit()
Date: Tue, 10 Sep 2024 19:58:01 +0200
Message-ID: <20240910175809.2135596-7-david@redhat.com>
In-Reply-To: <20240910175809.2135596-1-david@redhat.com>
References: <20240910175809.2135596-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Let's add s390_get_memory_limit(), to query what has been successfully
set via s390_set_memory_limit(). Allow setting the limit only once.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu-sysemu.c | 19 +++++++++++++++++--
 target/s390x/cpu.h        |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu-sysemu.c b/target/s390x/cpu-sysemu.c
index 1cd30c1d84..1915567b3a 100644
--- a/target/s390x/cpu-sysemu.c
+++ b/target/s390x/cpu-sysemu.c
@@ -255,12 +255,27 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
     return s390_count_running_cpus();
 }
 
+static uint64_t memory_limit;
+
 int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit)
 {
+    int ret = 0;
+
+    if (memory_limit) {
+        return -EBUSY;
+    }
     if (kvm_enabled()) {
-        return kvm_s390_set_mem_limit(new_limit, hw_limit);
+        ret = kvm_s390_set_mem_limit(new_limit, hw_limit);
+    }
+    if (!ret) {
+        memory_limit = new_limit;
     }
-    return 0;
+    return ret;
+}
+
+uint64_t s390_get_memory_limit(void)
+{
+    return memory_limit;
 }
 
 void s390_set_max_pagesize(uint64_t pagesize, Error **errp)
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index d6b75ad0e0..7a51b606ed 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -895,6 +895,7 @@ static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
 /* cpu.c */
 void s390_crypto_reset(void);
 int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
+uint64_t s390_get_memory_limit(void);
 void s390_set_max_pagesize(uint64_t pagesize, Error **errp);
 void s390_cmma_reset(void);
 void s390_enable_css_support(S390CPU *cpu);
-- 
2.46.0


