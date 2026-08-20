Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40073C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yz-0004oM-3x; Thu, 20 Aug 2026 12:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yp-0004OK-OX
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yn-0005YC-UR
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j3j6erah531s/cskJ0a1CwLNNVwS055cGoM9/4y/fw8=;
 b=TCbM6QqrwGcaFDCk/p1ImaWgd6NdLBuUhjRuDtoNrhuxBJJUR29Qhh7HuxwCmp2qnPi5ZF
 1U17E+rzDorkPL9aGRlvzjJbRfvh1DgAejSVo4VwiXhrUK3IagXbxcMloU9HBayM4CffGb
 0KjcEHHmPLqqVdvSlSAWRMCzsyFJA/U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-0Vypse2EMbSYb3S3e4wt9g-1; Thu, 20 Aug 2026 12:50:54 -0400
X-MC-Unique: 0Vypse2EMbSYb3S3e4wt9g-1
X-Mimecast-MFC-AGG-ID: 0Vypse2EMbSYb3S3e4wt9g_1787244653
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f6e8b5996so87707f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244653; x=1787849453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j3j6erah531s/cskJ0a1CwLNNVwS055cGoM9/4y/fw8=;
 b=V8ZCdXd7SMhZaa+bGBCLnZTgyVwpK7k0mkq1YUd+pfAXonSkEssJV08d1J3S9auPT4
 h+wWtUsSezLWq29jmjYES0Q0sdnpgdNIWMGBcXp4GWar/cplqOyTEpxKKieiYrZrlH2C
 +aC2X8P6AZ6YBs61ekdx695GKc4W/S32JLE7a4Jr+2zRrHxXWCfxDPzgw2sIW9+k2/cD
 /Rjb5msaQiWxScSvmjxcFplH4vMO8J4VlQlUocLQXxBkq0/9jUfQ0t9kssmkT33Offb1
 Ga1JzYs7jAJxwrXWp7Bk3rnr1WISg3Y42k/iQxwLrmMk06N5hNqpAhV23OkAwM9DyhJw
 XYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244653; x=1787849453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=j3j6erah531s/cskJ0a1CwLNNVwS055cGoM9/4y/fw8=;
 b=DflkXN1DheAX7UISD6oJPf1O5pBPtngAvdSWtwDoU0XxJWnZ9M1jx07yN3FYih3HGy
 vEHSb47zvbQ7I+K98o4Hg41KuZedvZMgBBSd3Ni15E2wmH/oCmSedGLN2RVjFZzOWNBc
 bbltoKt+TsA5kt+lsTbvRe/yNoR5l9i4iLACm1U5YImZbKEGv617t2iYOk7U0yhZO05M
 LfBUgEDfCi8PENO543ffYEaYg3THArBOwZyy3hXoLEVVGZ+h44wZJNrrCb2bFoyovLUZ
 fcUIlTcSXTevv9sYnUu1ZL4P4sDornmb4T2ehIYU8n6KGbjDffRqNYB8r2bQsn+maeDT
 ddcA==
X-Gm-Message-State: AFuF++kduTo3prs+AtkVVDfDkB8hNEwkyvmJTYoRCG4pX+4MxbpZCIGn
 esqM0jT6NEMF4oLiH+QSViOyPk8nj3XCIfL6235C09/F6W1IJdqSPoRuMXJfQ1U8N3+dyp9cAco
 dYQEosnl7qRFuZAN84Y/2ZRvt8bZQWi7phbn/9i4RN3Grpmh1fXX++mZDYuk8eKuCOwg0PkC5Ss
 hHAvnsAqZLFijHrI5UIT80c4P2FjMNmFYVw0VIxa02
X-Gm-Gg: AR+sD13rb6QUwGXif7nvflvv9/Insx9hlrQWEgYeQSXDsZexQ+A4S1wZKvMDN9fS3FT
 iKS3rny/ZGJdXi7cHHbDMFMS7gV3U7a+svxgqNefai7rLNIJEOAylqDo1mdx7gkFNCBWdkIPtW0
 vvap2xOsIZHMgV/U45WPdbuVMpfcDpYgzMKaeSxyqibQK5S5p/xMWr0zg4wdW2e7h8+/GAEc0Mv
 qyBjLIPGEEzCBPVxNDSehUhrK171Ir0qURGutflSEVoZdt7BsB/NfU9lUX+X/AM+0u+48FR+A82
 E+CNnlGKnP3KzBz6wUSPzAeMgtgajLJYp9uxy/g3oEIPbhMUpLYy8zShZKYitz55aViHgeu1PdV
 BgSIHmlivL1jEWi2lxpS6+6s6NFATu/mxg3RJPmPpjwd7ZeVr8wVcdtcNw4QcaNbsANrM49ZhGS
 A23cw=
X-Received: by 2002:a05:6000:1acb:b0:47f:71a6:970e with SMTP id
 ffacd0b85a97d-482c0b55d3fmr13488f8f.2.1787244652968; 
 Thu, 20 Aug 2026 09:50:52 -0700 (PDT)
X-Received: by 2002:a05:6000:1acb:b0:47f:71a6:970e with SMTP id
 ffacd0b85a97d-482c0b55d3fmr13374f8f.2.1787244652515; 
 Thu, 20 Aug 2026 09:50:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14c33b3sm13084069f8f.27.2026.08.20.09.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 18/53] target/i386/mshv: migrate MP_STATE
Date: Thu, 20 Aug 2026 18:49:21 +0200
Message-ID: <20260820164957.1895963-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

MSHV's "internal activity state" roughly maps to QEMU's env->mp_state
and cpu->halted states that describe state of APs in a guest.

We don't invoke set_mp_state as part of store_vcpu_state() b/c we would
put all BSP + APs in a RUNNABLE (0) state immediately, breaking SMP boot

Instead we store the mp state as part of the load_cleanup() routine
after a migration.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260710101534.664604-11-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h   |  1 +
 accel/mshv/mshv-all.c       | 10 +++++
 target/i386/mshv/mshv-cpu.c | 80 +++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index cbfcb8611b4..3dffe3c5fbf 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -99,6 +99,7 @@ int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
 int mshv_arch_store_vcpu_state(const CPUState *cpu);
 int mshv_arch_load_vcpu_state(CPUState *cpu);
 int mshv_arch_set_partition_msrs(const CPUState *cpu);
+int mshv_arch_set_mp_state(const CPUState *cpu);
 void mshv_arch_init_vcpu(CPUState *cpu);
 void mshv_arch_destroy_vcpu(CPUState *cpu);
 void mshv_arch_amend_proc_features(
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 1ca1d4b54ff..5921ce693ee 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -62,6 +62,7 @@ static int init_mshv(int *mshv_fd)
 
 static int mshv_load_cleanup(void *opaque)
 {
+    CPUState *cpu;
     int ret;
 
     ret = mshv_arch_set_partition_msrs(first_cpu);
@@ -70,6 +71,15 @@ static int mshv_load_cleanup(void *opaque)
         return -1;
     }
 
+    CPU_FOREACH(cpu) {
+        ret = mshv_arch_set_mp_state(cpu);
+        if (ret < 0) {
+            error_report("Failed to set mp state for vCPU %d: %s",
+                         cpu->cpu_index, strerror(-ret));
+            return -1;
+        }
+    }
+
     return 0;
 }
 
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 6bb3045752c..f528dd2b9a2 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -35,6 +35,11 @@
 
 #include <sys/ioctl.h>
 
+#define MSHV_MP_STATE_RUNNABLE       0
+#define MSHV_MP_STATE_UNINITIALIZED  1
+#define MSHV_MP_STATE_INIT_RECEIVED  2
+#define MSHV_MP_STATE_HALTED         3
+
 #define MAX_REGISTER_COUNT (MAX_CONST(ARRAY_SIZE(STANDARD_REGISTER_NAMES), \
                             MAX_CONST(ARRAY_SIZE(SPECIAL_REGISTER_NAMES), \
                                       ARRAY_SIZE(FPU_REGISTER_NAMES))))
@@ -950,6 +955,76 @@ static int set_vcpu_events(const CPUState *cpu)
     return 0;
 }
 
+static int get_mp_state(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    struct hv_register_assoc assoc = {
+        .name = HV_REGISTER_INTERNAL_ACTIVITY_STATE,
+    };
+    union hv_internal_activity_register activity;
+    int ret;
+
+    ret = mshv_get_generic_regs(cpu, &assoc, 1);
+    if (ret < 0) {
+        error_report("failed to get internal activity state");
+        return -1;
+    }
+
+    activity.as_uint64 = assoc.value.reg64;
+
+    /*
+     * map MSHV activity state to KVM mp_state values, which are used as the
+     * shared representation in env->mp_state and serialized by vmstate_x86_cpu.
+     */
+
+    if (activity.startup_suspend) {
+        env->mp_state = MSHV_MP_STATE_UNINITIALIZED;
+    } else if (activity.halt_suspend) {
+        env->mp_state = MSHV_MP_STATE_HALTED;
+    } else {
+        env->mp_state = MSHV_MP_STATE_RUNNABLE;
+    }
+
+    cpu->halted = (env->mp_state == MSHV_MP_STATE_HALTED);
+
+    return 0;
+}
+
+int mshv_arch_set_mp_state(const CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    union hv_internal_activity_register activity = { 0 };
+    struct hv_register_assoc assoc = {
+        .name = HV_REGISTER_INTERNAL_ACTIVITY_STATE,
+    };
+    int ret;
+
+    switch (env->mp_state) {
+    case MSHV_MP_STATE_HALTED:
+        activity.halt_suspend = 1;
+        break;
+    case MSHV_MP_STATE_UNINITIALIZED:
+    case MSHV_MP_STATE_INIT_RECEIVED:
+        activity.startup_suspend = 1;
+        break;
+    case MSHV_MP_STATE_RUNNABLE:
+    default:
+        break;
+    }
+
+    assoc.value.reg64 = activity.as_uint64;
+
+    ret = mshv_set_generic_regs(cpu, &assoc, 1);
+    if (ret < 0) {
+        error_report("failed to set internal activity state");
+        return -1;
+    }
+
+    return 0;
+}
+
 static int update_hflags(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
@@ -1012,6 +1087,11 @@ int mshv_arch_load_vcpu_state(CPUState *cpu)
         return ret;
     }
 
+    ret = get_mp_state(cpu);
+    if (ret < 0) {
+        return ret;
+    }
+
     return 0;
 }
 
-- 
2.55.0


