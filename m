Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62ED9CEF14D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 10:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy7tr-0003Ry-Gx; Tue, 08 Oct 2024 06:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sy7t1-0001k5-2L
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:56:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sy7sz-0001kl-9G
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 06:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728384972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yPi+AZLrBrpcNAFLeYI6i11INU1VCx0iDUBL5LxkFmI=;
 b=IONg/yvkLkkU8964WKScgaqz2rgHHxhFhQGqDUxXYcTaDF61uxGsMumkF/5ke93yIawogQ
 bA/mHpJqvb+nGGfq5jyPZrw5YHcknTKrecBHv7aQHGX2U3nG6YpALOqTNe/C5TLnyrFuAo
 GceD5sErPBCH/u3Jg4bZhgmRA2aMgdo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-mU2F3o5DMHGzxaQC56f6DQ-1; Tue,
 08 Oct 2024 06:56:11 -0400
X-MC-Unique: mU2F3o5DMHGzxaQC56f6DQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DA891955D61; Tue,  8 Oct 2024 10:56:09 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.16.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F40319560A3; Tue,  8 Oct 2024 10:56:04 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 12/14] s390x: remember the maximum page size
Date: Tue,  8 Oct 2024 12:54:53 +0200
Message-ID: <20241008105455.2302628-13-david@redhat.com>
In-Reply-To: <20241008105455.2302628-1-david@redhat.com>
References: <20241008105455.2302628-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Let's remember the value (successfully) set via s390_set_max_pagesize().
This will be helpful to reject hotplugged memory devices that would exceed
this initially set page size.

Handle it just like how we handle s390_get_memory_limit(), storing it in
the machine, and moving the handling to machine code.

Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c         | 12 +++++++++++-
 include/hw/s390x/s390-virtio-ccw.h |  1 +
 target/s390x/cpu-sysemu.c          |  7 -------
 target/s390x/cpu.h                 |  1 -
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 2031c4cf29..65f266a78f 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -150,6 +150,16 @@ uint64_t s390_get_memory_limit(S390CcwMachineState *s390ms)
     return s390ms->memory_limit;
 }
 
+static void s390_set_max_pagesize(S390CcwMachineState *s390ms,
+                                  uint64_t pagesize)
+{
+    assert(!s390ms->max_pagesize && pagesize);
+    if (kvm_enabled()) {
+        kvm_s390_set_max_pagesize(pagesize, &error_fatal);
+    }
+    s390ms->max_pagesize = pagesize;
+}
+
 static void s390_memory_init(MachineState *machine)
 {
     S390CcwMachineState *s390ms = S390_CCW_MACHINE(machine);
@@ -198,7 +208,7 @@ static void s390_memory_init(MachineState *machine)
      * Configure the maximum page size. As no memory devices were created
      * yet, this is the page size of initial memory only.
      */
-    s390_set_max_pagesize(qemu_maxrampagesize(), &error_fatal);
+    s390_set_max_pagesize(s390ms, qemu_maxrampagesize());
     /* Initialize storage key device */
     s390_skeys_init();
     /* Initialize storage attributes device */
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index eb04542979..5a730f5d07 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -30,6 +30,7 @@ struct S390CcwMachineState {
     bool pv;
     uint8_t loadparm[8];
     uint64_t memory_limit;
+    uint64_t max_pagesize;
 
     SCLPDevice *sclp;
 };
diff --git a/target/s390x/cpu-sysemu.c b/target/s390x/cpu-sysemu.c
index 3118a25fee..706a5c53e2 100644
--- a/target/s390x/cpu-sysemu.c
+++ b/target/s390x/cpu-sysemu.c
@@ -255,13 +255,6 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
     return s390_count_running_cpus();
 }
 
-void s390_set_max_pagesize(uint64_t pagesize, Error **errp)
-{
-    if (kvm_enabled()) {
-        kvm_s390_set_max_pagesize(pagesize, errp);
-    }
-}
-
 void s390_cmma_reset(void)
 {
     if (kvm_enabled()) {
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index b4506539f0..5b7992deda 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -881,7 +881,6 @@ static inline void s390_do_cpu_load_normal(CPUState *cs, run_on_cpu_data arg)
 
 /* cpu.c */
 void s390_crypto_reset(void);
-void s390_set_max_pagesize(uint64_t pagesize, Error **errp);
 void s390_cmma_reset(void);
 void s390_enable_css_support(S390CPU *cpu);
 void s390_do_cpu_set_diag318(CPUState *cs, run_on_cpu_data arg);
-- 
2.46.1


