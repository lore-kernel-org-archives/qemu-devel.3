Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E9DCD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 16:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITs0-0000xE-AZ; Thu, 30 Apr 2026 12:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wITrN-0007d1-Np
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wITrH-00079p-QA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 12:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777565001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xRYLKOrmE7/oEuDtADR2OmYYnbN1a9jH/1mSe5dCafw=;
 b=At23GtMHrDQZeVwzahr8GA9GCqJQUEhEiuUI82v3kBMfnD1owbMWJHrqONK5A9u/m5TRQw
 6qyocV+YnXryaciYQrDDbImM5EfTaoWQH6BOG6b9DtacGN1KNhze1JghRMcriYL8ofOSYA
 s0Iyzu1OJSEV5h8CM31k5x0AYIqPPM4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-ysVl5qMaMWKfXlaZvHY3Jg-1; Thu,
 30 Apr 2026 12:03:16 -0400
X-MC-Unique: ysVl5qMaMWKfXlaZvHY3Jg-1
X-Mimecast-MFC-AGG-ID: ysVl5qMaMWKfXlaZvHY3Jg_1777564995
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 312E519560B4; Thu, 30 Apr 2026 16:03:15 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.50.47])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C31D18001ED; Thu, 30 Apr 2026 16:03:12 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PULL v2 01/11] target/s390x/kvm: Simplify the async pfault handling
 code
Date: Thu, 30 Apr 2026 18:02:57 +0200
Message-ID: <20260430160307.634093-2-cohuck@redhat.com>
In-Reply-To: <20260430160307.634093-1-cohuck@redhat.com>
References: <20260430160307.634093-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Since commit 126e7f78036 ("kvm: require KVM_CAP_IOEVENTFD and
KVM_CAP_IOEVENTFD_ANY_LENGTH") we require at least kernel v4.4 to
be able to use KVM. KVM_CAP_ASYNC_PF is available in the kernel
since v3.15 and KVM_SYNC_PFAULT is available since kernel v3.18,
so we can assume now that they are available in all supported
kernels. Thus simplify the code a little bit by removing the
checks for these features.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20260317134531.460141-1-thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/kvm/kvm.c | 52 +++++++++---------------------------------
 1 file changed, 11 insertions(+), 41 deletions(-)

diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 54d28e37d4dd..133e8c12fd4d 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -140,7 +140,6 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
 
-static int cap_async_pf;
 static int cap_mem_op;
 static int cap_mem_op_extension;
 static int cap_s390_irq;
@@ -333,6 +332,7 @@ int kvm_arch_get_default_type(MachineState *ms)
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     int required_caps[] = {
+        KVM_CAP_ASYNC_PF,
         KVM_CAP_DEVICE_CTRL,
         KVM_CAP_SYNC_REGS,
     };
@@ -340,7 +340,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     for (int i = 0; i < ARRAY_SIZE(required_caps); i++) {
         if (!kvm_check_extension(s, required_caps[i])) {
             error_report("KVM is missing capability #%d - "
-                         "please use kernel 3.15 or newer", required_caps[i]);
+                         "please use kernel 4.4 or newer", required_caps[i]);
             return -1;
         }
     }
@@ -354,7 +354,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return -1;
     }
 
-    cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
     cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
     cap_mem_op_extension = kvm_check_extension(s, KVM_CAP_S390_MEM_OP_EXTENSION);
     mem_op_storage_key_support = cap_mem_op_extension > 0;
@@ -466,7 +465,8 @@ static int can_sync_regs(CPUState *cs, int regs)
 }
 
 #define KVM_SYNC_REQUIRED_REGS (KVM_SYNC_GPRS | KVM_SYNC_ACRS | \
-                                KVM_SYNC_CRS | KVM_SYNC_PREFIX)
+                                KVM_SYNC_CRS | KVM_SYNC_PREFIX | \
+                                KVM_SYNC_PFAULT)
 
 int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
 {
@@ -550,25 +550,10 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
     }
 
     /* pfault parameters */
-    if (can_sync_regs(cs, KVM_SYNC_PFAULT)) {
-        cs->kvm_run->s.regs.pft = env->pfault_token;
-        cs->kvm_run->s.regs.pfs = env->pfault_select;
-        cs->kvm_run->s.regs.pfc = env->pfault_compare;
-        cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_PFAULT;
-    } else if (cap_async_pf) {
-        r = kvm_set_one_reg(cs, KVM_REG_S390_PFTOKEN, &env->pfault_token);
-        if (r < 0) {
-            return r;
-        }
-        r = kvm_set_one_reg(cs, KVM_REG_S390_PFCOMPARE, &env->pfault_compare);
-        if (r < 0) {
-            return r;
-        }
-        r = kvm_set_one_reg(cs, KVM_REG_S390_PFSELECT, &env->pfault_select);
-        if (r < 0) {
-            return r;
-        }
-    }
+    cs->kvm_run->s.regs.pft = env->pfault_token;
+    cs->kvm_run->s.regs.pfs = env->pfault_select;
+    cs->kvm_run->s.regs.pfc = env->pfault_compare;
+    cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_PFAULT;
 
     if (can_sync_regs(cs, KVM_SYNC_GSCB)) {
         memcpy(cs->kvm_run->s.regs.gscb, env->gscb, 32);
@@ -673,24 +658,9 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     }
 
     /* pfault parameters */
-    if (can_sync_regs(cs, KVM_SYNC_PFAULT)) {
-        env->pfault_token = cs->kvm_run->s.regs.pft;
-        env->pfault_select = cs->kvm_run->s.regs.pfs;
-        env->pfault_compare = cs->kvm_run->s.regs.pfc;
-    } else if (cap_async_pf) {
-        r = kvm_get_one_reg(cs, KVM_REG_S390_PFTOKEN, &env->pfault_token);
-        if (r < 0) {
-            return r;
-        }
-        r = kvm_get_one_reg(cs, KVM_REG_S390_PFCOMPARE, &env->pfault_compare);
-        if (r < 0) {
-            return r;
-        }
-        r = kvm_get_one_reg(cs, KVM_REG_S390_PFSELECT, &env->pfault_select);
-        if (r < 0) {
-            return r;
-        }
-    }
+    env->pfault_token = cs->kvm_run->s.regs.pft;
+    env->pfault_select = cs->kvm_run->s.regs.pfs;
+    env->pfault_compare = cs->kvm_run->s.regs.pfc;
 
     if (can_sync_regs(cs, KVM_SYNC_DIAG318)) {
         env->diag318_info = cs->kvm_run->s.regs.diag318;
-- 
2.53.0


