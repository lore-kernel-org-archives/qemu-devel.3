Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAD4E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNriI-0001iN-Mn; Wed, 18 Dec 2024 05:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrht-0000ot-EK
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhn-0006sF-Bj
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734519302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fNn4jmZMJMsNyzffi2yRwWE0r3jKftHosPoyBPI8w34=;
 b=I2g6lo5K6eZZ40iTzTo7dWcWQrV7AfBybB9dtqsMCAiI5kn6AeDO7ckxqrFJaa3gjdkGDN
 7wRLmJPxaa/XJURnic+3Br0+S7z0dgHdqDd7zNcUeN5dPeLcXzq7Jz/vrGiMV4rs8BO1Ll
 v5ZBvAUW8RIzx2kzSd3meRPr89LVKuQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-H7E0aACdNVi1z04EyX_jTw-1; Wed, 18 Dec 2024 05:53:26 -0500
X-MC-Unique: H7E0aACdNVi1z04EyX_jTw-1
X-Mimecast-MFC-AGG-ID: H7E0aACdNVi1z04EyX_jTw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3862b364578so316356f8f.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734519204; x=1735124004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fNn4jmZMJMsNyzffi2yRwWE0r3jKftHosPoyBPI8w34=;
 b=V0ku3J7y6a4N2jNnRzeodKFANbRTBqMqESzIS8/LMLW6rIq1pQtJ1rMa8rvI1RI8OP
 ua42M/B5Sftv9wZdBbnrbCMFE+uHHqDt9iy1wOGKVgf/gskUmw0JT0ZCfF8IplnJ+9Ci
 0nSjrQXr0fyMcpK5H3BiQ2da1LT0zAEU4zwmUca9Bq4ganGr5eK/7zVo5bqn12e9cTqt
 N8QmRnSQMy1eDDcETumXwmCfzXArnOev84LJSUkTtde7pGNwvZIaoqergbgNshgRC78f
 jpOE8i7bJQ017zSTOUITd1hqy0sFpzDje/+9AqoF2sdyY6WJP8Bd655gWkuQC1sLvCe5
 kyoQ==
X-Gm-Message-State: AOJu0Yxm5uYQ72EW8Z3abXItvEY6bGwhotYTMufcInK7MVaaYzq+Yils
 fyu+J4QmRILF6q3c6j34HAhXB1ZNCwhNVcTVmpnWwIt0k6+kbZh0n569DekrbW+w55YlgJBm/vC
 y9DVnWdtk0Z2xRfh69kxnzwD0ep45IBt7sxmMnAYI0jabk7FgWxH4PzxQm6Do/BwmqXWfzY+y9a
 OIxrRmPk3t991uP2kzukJvqs0iT+HIUiiARjA=
X-Gm-Gg: ASbGncttB00VipGbCOwNrgiuD+o46ZLJqu8529SMiBWzt/+TgwJzjBAiNY4mceyTbkF
 HngKpMHQOavPRyHI+Z3wxwaUoj+ihxCa3tHQ2mmgk3d6zmJvz8GIgYC4pm7tSnBw6C7c6+5WYnQ
 2b5KGxZQUeey4gPWpSy6ZIqNDG0plmNdI2+W8M8xW2jJLrTYqq/4DFq2l5tA1VtzVBOMM6O4mLi
 9tIkaKhPrj7pzoIgVfFpFgpNZA4rWfi+riU1+wwBp78FdjHeFXRvqGzJpXWw4r3ODd4x51gMh4h
 M6wN/yKayRJaUyLgzKYMnoeb61S29xaKpNINA1fOjg==
X-Received: by 2002:a05:600c:450a:b0:434:fc5d:179c with SMTP id
 5b1f17b1804b1-436553b6e3cmr19611275e9.13.1734519204382; 
 Wed, 18 Dec 2024 02:53:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvENqeBNlec5X1ks1+P7MEYQQLUvfc2KID3UehvJteQwbyHz4ImLZlYFoSoj1vYUQ1WL8sCQ==
X-Received: by 2002:a05:600c:450a:b0:434:fc5d:179c with SMTP id
 5b1f17b1804b1-436553b6e3cmr19610975e9.13.1734519203908; 
 Wed, 18 Dec 2024 02:53:23 -0800 (PST)
Received: from localhost
 (p200300cbc73f8300a5d5c21badd3cf50.dip0.t-ipconnect.de.
 [2003:cb:c73f:8300:a5d5:c21b:add3:cf50])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43656b11d1dsm16493355e9.25.2024.12.18.02.53.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:53:23 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 07/15] s390x: introduce s390_get_memory_limit()
Date: Wed, 18 Dec 2024 11:52:55 +0100
Message-ID: <20241218105303.1966303-8-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218105303.1966303-1-david@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

We'll remember the limit in the machine state. Move
s390_set_memory_limit() to machine code, merging it into
set_memory_limit(), because this really is a machine property.

Message-ID: <20241008105455.2302628-7-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c         | 22 ++++++++++++++++++----
 include/hw/s390x/s390-virtio-ccw.h |  3 +++
 target/s390x/cpu-sysemu.c          |  8 --------
 target/s390x/cpu.h                 |  1 -
 4 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index a28e615c5a..5a91e334f3 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -45,6 +45,7 @@
 #include "migration/blocker.h"
 #include "qapi/visitor.h"
 #include "hw/s390x/cpu-topology.h"
+#include "kvm/kvm_s390x.h"
 #include CONFIG_DEVICES
 
 static Error *pv_mig_blocker;
@@ -121,12 +122,16 @@ static void subsystem_reset(void)
     }
 }
 
-static void set_memory_limit(uint64_t new_limit)
+static void s390_set_memory_limit(S390CcwMachineState *s390ms,
+                                  uint64_t new_limit)
 {
     uint64_t hw_limit;
-    int ret;
+    int ret = 0;
 
-    ret = s390_set_memory_limit(new_limit, &hw_limit);
+    assert(!s390ms->memory_limit && new_limit);
+    if (kvm_enabled()) {
+        ret = kvm_s390_set_mem_limit(new_limit, &hw_limit);
+    }
     if (ret == -E2BIG) {
         error_report("host supports a maximum of %" PRIu64 " GB",
                      hw_limit / GiB);
@@ -135,10 +140,19 @@ static void set_memory_limit(uint64_t new_limit)
         error_report("setting the guest size failed");
         exit(EXIT_FAILURE);
     }
+    s390ms->memory_limit = new_limit;
+}
+
+uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms)
+{
+    /* We expect to be called only after the limit was set. */
+    assert(s390ms->memory_limit);
+    return s390ms->memory_limit;
 }
 
 static void s390_memory_init(MachineState *machine)
 {
+    S390CcwMachineState *s390ms = S390_CCW_MACHINE(machine);
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ram = machine->ram;
     uint64_t ram_size = memory_region_size(ram);
@@ -154,7 +168,7 @@ static void s390_memory_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    set_memory_limit(ram_size);
+    s390_set_memory_limit(s390ms, ram_size);
 
     /* Map the initial memory. Must happen after setting the memory limit. */
     memory_region_add_subregion(sysmem, 0, ram);
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 996864a34e..eb04542979 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -29,10 +29,13 @@ struct S390CcwMachineState {
     bool dea_key_wrap;
     bool pv;
     uint8_t loadparm[8];
+    uint64_t memory_limit;
 
     SCLPDevice *sclp;
 };
 
+uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms);
+
 #define S390_PTF_REASON_NONE (0x00 << 8)
 #define S390_PTF_REASON_DONE (0x01 << 8)
 #define S390_PTF_REASON_BUSY (0x02 << 8)
diff --git a/target/s390x/cpu-sysemu.c b/target/s390x/cpu-sysemu.c
index 1cd30c1d84..3118a25fee 100644
--- a/target/s390x/cpu-sysemu.c
+++ b/target/s390x/cpu-sysemu.c
@@ -255,14 +255,6 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
     return s390_count_running_cpus();
 }
 
-int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit)
-{
-    if (kvm_enabled()) {
-        return kvm_s390_set_mem_limit(new_limit, hw_limit);
-    }
-    return 0;
-}
-
 void s390_set_max_pagesize(uint64_t pagesize, Error **errp)
 {
     if (kvm_enabled()) {
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5ef61b1f75..b4506539f0 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -881,7 +881,6 @@ static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
 
 /* cpu.c */
 void s390_crypto_reset(void);
-int s390_set_memory_limit(uint64_t new_limit, uint64_t *hw_limit);
 void s390_set_max_pagesize(uint64_t pagesize, Error **errp);
 void s390_cmma_reset(void);
 void s390_enable_css_support(S390CPU *cpu);
-- 
2.47.1


