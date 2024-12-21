Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A39E7718E
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 19:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP53i-0002QZ-2e; Sat, 21 Dec 2024 14:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53g-0002Po-3J
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53e-0000Fh-I2
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734808958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WGu+ZgEzN6rOk3pd4wJ9ZrVZQ7N/0arOChZXYIBy5JE=;
 b=QNWRXC8s802hZY3I+MNCIyev4J6i8LkX36AonToHunU0OOJmpj5p90PTcE6Jymzcvl+ZQ1
 kzE4vkkKue+m9KETA3APX9DY6+U4pdk+PxYrUZILGduYl0czVtFyM2RJ/ovyfzuWqu0Tcu
 Dz279e74CI/p1oL4BTc6Q8sOXAuqWjM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-2CqSwec5PWSxhKUuhVQUmA-1; Sat, 21 Dec 2024 14:22:33 -0500
X-MC-Unique: 2CqSwec5PWSxhKUuhVQUmA-1
X-Mimecast-MFC-AGG-ID: 2CqSwec5PWSxhKUuhVQUmA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361d4e8359so24050805e9.3
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 11:22:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734808952; x=1735413752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WGu+ZgEzN6rOk3pd4wJ9ZrVZQ7N/0arOChZXYIBy5JE=;
 b=jzuVwf4p9sRQs/VFZKnTToQ1Le04FBuVgTs4gZc9h0GxofDgNYtWClMrP8uP8fLYXg
 R6XTHhCHDKTmGT/GA5mlNvTYHWKGC2o2uu6NzzOZT0CMItT4yIrQWebs9lG+gaUCAJhn
 V1prVhqPng2X7wXEwM6SpuKZ9hTWXk8jJ2U/rDGRu3p4ifh3wbVE+xJfdPjyu0q/oHyK
 TDdyAe7G2yshCMCwdSDpN77e6mH+pmUqPBsoActxZWGCk2LwtGk/pQSMCo0J9ki6RBs1
 6HKq9MC+Q2IYH5fhRYFYxycojxZcFAakpOjOCn7vdxm9SiST3Pu5+yitPb3SsfecymLc
 604g==
X-Gm-Message-State: AOJu0YyVpH4fyOXYjO6h8vEDez9Pqw3E/qFz0ljXcy05St7TgK81PAwA
 UxXpmgysFonExcHFdhAVIn/uOHJpJYuqZnaf7o0beJT0cU15GcaUBjMIt5baFJlLK+5odnE5Q9i
 X3E5LqKHCCU8TAvwWenPxnhSieC3rfM8GDNJ1ZFPAH75FV51bPzf3W+MFAbW7mTUZL1qpbKzk/7
 jcXSicCnU62xDZpCZZC+vYZLuvwt2ruwOH
X-Gm-Gg: ASbGnctMGZmNDPGmEP87/gCs/nvA8WPezyPz/SAw2+/hTpfbHDHnHQ7u5AoYO2+yjop
 1vaghclXx6fFO+CQhGmEHqHh7BXK3frlZNwfwWPEgH07HnwsSW2v7knI6rH+bNYgDkV4HSsNlgN
 /ZK2KO2Y5Qy5CHjV+iVyDREMI/BPmOh4qi9OpgmoPsdv3hSB93ZdJ5Dtvf2mNXeK5sANWSLoBlv
 UaZfX3Wyu6PMjI80Nl9yZxWOHEO4am49bytJRaPomYm+sOPrGgpU8XT1vqomBlYIeqKJTVanUw7
 ap9a1Y0EspwCEH86opHBnNnSI4uDBUrFCfkAf9o=
X-Received: by 2002:a05:600c:1c9f:b0:435:32e:8270 with SMTP id
 5b1f17b1804b1-43668642f9dmr64362115e9.14.1734808952329; 
 Sat, 21 Dec 2024 11:22:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbcpUo2QHaH1qNNe1W6Y0nGzocSMkcNLPSdOhbQKDjoS8NwH56ptqwQBRL5iaJo6gKThICug==
X-Received: by 2002:a05:600c:1c9f:b0:435:32e:8270 with SMTP id
 5b1f17b1804b1-43668642f9dmr64361995e9.14.1734808951918; 
 Sat, 21 Dec 2024 11:22:31 -0800 (PST)
Received: from localhost
 (p200300cbc7137800820d0e9f08ce52bd.dip0.t-ipconnect.de.
 [2003:cb:c713:7800:820d:e9f:8ce:52bd])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-43656b013e1sm116101925e9.12.2024.12.21.11.22.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 11:22:30 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL v2 07/15] s390x: introduce s390_get_memory_limit()
Date: Sat, 21 Dec 2024 20:22:01 +0100
Message-ID: <20241221192209.3979595-8-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221192209.3979595-1-david@redhat.com>
References: <20241221192209.3979595-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.177,
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

Message-ID: <20241219144115.2820241-7-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c         | 17 ++++++++++++-----
 include/hw/s390x/s390-virtio-ccw.h |  8 ++++++++
 target/s390x/cpu-sysemu.c          |  8 --------
 target/s390x/cpu.h                 |  1 -
 4 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index a28e615c5a..1c56b70dcd 100644
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
-    uint64_t hw_limit;
-    int ret;
+    uint64_t hw_limit = 0;
+    int ret = 0;
 
-    ret = s390_set_memory_limit(new_limit, &hw_limit);
+    assert(!s390ms->memory_limit && new_limit);
+    if (kvm_enabled()) {
+        ret = kvm_s390_set_mem_limit(new_limit, &hw_limit);
+    }
     if (ret == -E2BIG) {
         error_report("host supports a maximum of %" PRIu64 " GB",
                      hw_limit / GiB);
@@ -135,10 +140,12 @@ static void set_memory_limit(uint64_t new_limit)
         error_report("setting the guest size failed");
         exit(EXIT_FAILURE);
     }
+    s390ms->memory_limit = new_limit;
 }
 
 static void s390_memory_init(MachineState *machine)
 {
+    S390CcwMachineState *s390ms = S390_CCW_MACHINE(machine);
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ram = machine->ram;
     uint64_t ram_size = memory_region_size(ram);
@@ -154,7 +161,7 @@ static void s390_memory_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
 
-    set_memory_limit(ram_size);
+    s390_set_memory_limit(s390ms, ram_size);
 
     /* Map the initial memory. Must happen after setting the memory limit. */
     memory_region_add_subregion(sysmem, 0, ram);
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 996864a34e..de04336c5a 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -29,10 +29,18 @@ struct S390CcwMachineState {
     bool dea_key_wrap;
     bool pv;
     uint8_t loadparm[8];
+    uint64_t memory_limit;
 
     SCLPDevice *sclp;
 };
 
+static inline uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms)
+{
+    /* We expect to be called only after the limit was set. */
+    assert(s390ms->memory_limit);
+    return s390ms->memory_limit;
+}
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


