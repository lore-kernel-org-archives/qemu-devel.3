Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D4CC5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yy-0004mw-DW; Thu, 20 Aug 2026 12:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yk-0004LE-W6
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yh-0005WL-W2
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vc6p2d2qQruEsDFEmVNNYwOdKQZR2T0jPEMA3rc8Oew=;
 b=IdS7AxFSGic7o1rWIfxxtQVhdsxokLr6hTEND7KUz5+VhISmkJjk2vrCCyZosZOiDHZqDC
 efjksqaE8FTdzw+HiOaTtBtqmW/isXDtLtxt9M/SGzvnfuGQvBXyCHT6TbNHNHJ54FWhnX
 +zta0zq5EV6WxNkSbL+oef++3NjDZUk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-ra5P0GmcPC-nzT1LZ4Ui2Q-1; Thu, 20 Aug 2026 12:50:49 -0400
X-MC-Unique: ra5P0GmcPC-nzT1LZ4Ui2Q-1
X-Mimecast-MFC-AGG-ID: ra5P0GmcPC-nzT1LZ4Ui2Q_1787244648
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490a767b782so265255e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244648; x=1787849448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vc6p2d2qQruEsDFEmVNNYwOdKQZR2T0jPEMA3rc8Oew=;
 b=cRGC/bHDZzRvYHJB4dhl8C6b7dFhV77MUuQuAY3cRELQdu0/7gvffCcucW5AUQZ9Tv
 krhyihBHdViwrSWPK5QHIdOpiQpQe06lsZ7tWkAbZRu8DIHVXRLunrpvxmq8zSjZUuzb
 Kxeq4domsI4rIFvVS4RihlVIMDAzKtCJfOn/Vs0oZmbWWsaAfdW/XlUu084bdtctQr6a
 2QsI33rEhi6Fin13BAd3nB3Mrwnm1LMTvXaHd81gITjGwCXMNtTGT8/0qB0I5/0oPgXl
 ckL/J/5krf7mGxh9ooijY09NRwNXs0itl/6iFnKY4C9PwzJ2UjIunCdyAJ7xbeRm7v9Q
 96/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244648; x=1787849448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vc6p2d2qQruEsDFEmVNNYwOdKQZR2T0jPEMA3rc8Oew=;
 b=WSB9ZHG0d1fNIvk9xW0zDWleWe3ofuySze4yLjDEAHgTbOvNVJIpyeoje+7+rtVGG4
 0J3FxkYr8V//lVPlkLup338yzyy9yihzjRhRfzyneUDaOjHiyNpm26c7W5JPdnBXPIT7
 3ClHrqK/53Y+tgJ8dSraBoKvL96l3xdj12VnGTS+HC8IrVWYKc48lNfwM2PT0PyjyWGE
 Jxky4XMmDMizKc+Q46fRGTquRJ6RSiCAl/y9JezCDaeFYGeR+XZSKzxKR2bPkGvJEE3K
 FFmTYNUZFngMDi5rsPj0Fq4rAE4cL9mWJJqAH5xM7PTGFzdB1ukHa7fzOOcW3fe72k0v
 0ukw==
X-Gm-Message-State: AOJu0YyezmubbeRzvGTEms0U13XOCxQlhbcqDHdqAjToOfQNTl8YY/3v
 JDVOPd0LgMHA89N8Lm8o1B67SAv2XM1zcidFRf9zrSch7s9uXgxiD5ABvWxlfls0Yq4OQ/mdit3
 MCeBbg5BtISH96HJ/k1OuhY9XvFIvOINMKyluLYn4O4WHXRa+CXkqPO5SggmeaVX1OVuxF1Dk6l
 6vg1jeHtNyOccMciW6Iz428UKNH8jdOroIes/+3J0c
X-Gm-Gg: AR+sD13+J8YyLw2G7zGUSSlVWeZskVMy3gWs4NTav/YyinqFUVc8fl+d1l0jd3puevE
 3YMniXAD+7Yhzh69ZSjQi8OeuoB9gVnzzb08CiB3OCYXFxJyuwgRu5X/4qD2EeFEnVrtMXGXUP+
 BoXLmTgMd2dzRvCcJbf0MeckdEXjSoANulRvWnN1k9hGmfq8SSpqCiAPofncq5jqgfYj8uPyMos
 B/6ie1LuCiW4rJPlOe6tRIq1AsnrCFf9hZqXVPEz9BizoVb3gbXy+cnQVruq5kderqDHFw5UVEl
 xHlLVvwE0c4NlTpVJID5Nvy2tlL8I0A4sGSLePfpGm0pXZ/QOnK5pwseTrjs8DfzZUfB+UoKOg+
 wjS3O58RLqlGxXs7OchJK2qRG9yTUPrSL3/W64/e/NNW43y1SZxlqbWPWCcMo6z/6MpkVmSSACn
 kprxI=
X-Received: by 2002:a05:600c:4704:b0:499:9069:c2c9 with SMTP id
 5b1f17b1804b1-499b84613fcmr2687515e9.11.1787244647683; 
 Thu, 20 Aug 2026 09:50:47 -0700 (PDT)
X-Received: by 2002:a05:600c:4704:b0:499:9069:c2c9 with SMTP id
 5b1f17b1804b1-499b84613fcmr2686585e9.11.1787244647185; 
 Thu, 20 Aug 2026 09:50:47 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0fd7a9sm199550075e9.2.2026.08.20.09.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 16/53] target/i386/mshv: migrate STIMER state
Date: Thu, 20 Aug 2026 18:49:19 +0200
Message-ID: <20260820164957.1895963-17-pbonzini@redhat.com>
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

This part of Synic state is retrieved via a mem-aligned page. We declare
the required space (size reference: rust-vmm/mshv) as a buffer on the VM
state struct for inclusion in a migration.

Other than other SynIC features, STIMER doesn't depend on SCONTROL being
set.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260710101534.664604-9-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/mshv_int.h   |  2 ++
 target/i386/cpu.h           |  5 ++++
 target/i386/machine.c       | 20 +++++++++++++++
 target/i386/mshv/mshv-cpu.c | 12 +++++++++
 target/i386/mshv/synic.c    | 51 +++++++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+)

diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index bc023d35355..063852115eb 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -144,5 +144,7 @@ int mshv_set_simp(int cpu_fd, const uint8_t *page);
 int mshv_get_siefp(int cpu_fd, uint8_t *page);
 int mshv_set_siefp(int cpu_fd, const uint8_t *page);
 bool mshv_synic_enabled(const CPUState *cpu);
+int mshv_get_synthetic_timers(int cpu_fd, uint8_t *state);
+int mshv_set_synthetic_timers(int cpu_fd, const uint8_t *state);
 
 #endif
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fcde8956008..641f3ee5c2f 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -45,6 +45,10 @@
 #define ELF_MACHINE_UNAME "i686"
 #endif
 
+#ifdef CONFIG_MSHV
+#define MSHV_STIMERS_STATE_SIZE 200
+#endif
+
 enum {
     R_EAX = 0,
     R_ECX = 1,
@@ -2305,6 +2309,7 @@ typedef struct CPUArchState {
 #if defined(CONFIG_MSHV)
     uint8_t hv_simp_page[HV_HYP_PAGE_SIZE];
     uint8_t hv_siefp_page[HV_HYP_PAGE_SIZE];
+    uint8_t hv_synthetic_timers_state[MSHV_STIMERS_STATE_SIZE];
 #endif
 
     uint64_t mcg_cap;
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 023a397ab89..8d69d7e25ef 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -10,6 +10,7 @@
 #include "exec/watchpoint.h"
 #include "system/kvm.h"
 #include "system/kvm_xen.h"
+#include "system/mshv.h"
 #include "system/tcg.h"
 
 #include "qemu/error-report.h"
@@ -952,6 +953,24 @@ static const VMStateDescription vmstate_msr_hyperv_reenlightenment = {
 };
 
 #ifdef CONFIG_MSHV
+
+static bool mshv_synthetic_timers_needed(void *opaque)
+{
+    /* Always migrate synthetic timers */
+    return mshv_enabled();
+}
+
+static const VMStateDescription vmstate_mshv_synthetic_timers = {
+    .name = "cpu/mshv_synthetic_timers",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = mshv_synthetic_timers_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BUFFER(env.hv_synthetic_timers_state, X86CPU),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static bool mshv_synic_vp_state_needed(void *opaque)
 {
     X86CPU *cpu = opaque;
@@ -1941,6 +1960,7 @@ const VMStateDescription vmstate_x86_cpu = {
 #endif
 #ifdef CONFIG_MSHV
         &vmstate_mshv_synic_vp_state,
+        &vmstate_mshv_synthetic_timers,
 #endif
         NULL
     }
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index ea6a660d054..86d64c67fb2 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -118,6 +118,12 @@ static int get_synic_state(CPUState *cpu)
     int cpu_fd = mshv_vcpufd(cpu);
     int ret;
 
+    ret = mshv_get_synthetic_timers(cpu_fd, env->hv_synthetic_timers_state);
+    if (ret < 0) {
+        error_report("failed to get synthetic timers");
+        return -1;
+    }
+
     /* SIMP/SIEFP can only be read when SynIC is enabled */
     if (!mshv_synic_enabled(cpu)) {
         return 0;
@@ -1420,6 +1426,12 @@ static int set_synic_state(const CPUState *cpu)
     int cpu_fd = mshv_vcpufd(cpu);
     int ret;
 
+    ret = mshv_set_synthetic_timers(cpu_fd, env->hv_synthetic_timers_state);
+    if (ret < 0) {
+        error_report("failed to set synthetic timers state");
+        return -1;
+    }
+
     /* SIMP/SIEFP can only be written when SynIC is enabled */
     if (!mshv_synic_enabled(cpu)) {
         return 0;
diff --git a/target/i386/mshv/synic.c b/target/i386/mshv/synic.c
index 8f9fee6ed7e..4c629adc3a0 100644
--- a/target/i386/mshv/synic.c
+++ b/target/i386/mshv/synic.c
@@ -54,6 +54,57 @@ static int set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state)
     return 0;
 }
 
+int mshv_get_synthetic_timers(int cpu_fd, uint8_t *state)
+{
+    int ret;
+    void *buffer;
+    struct mshv_get_set_vp_state args = {0};
+
+    buffer = qemu_memalign(HV_HYP_PAGE_SIZE, HV_HYP_PAGE_SIZE);
+    args.buf_ptr = (uint64_t)buffer;
+    args.buf_sz = HV_HYP_PAGE_SIZE;
+    args.type = MSHV_VP_STATE_SYNTHETIC_TIMERS;
+
+    ret = get_vp_state(cpu_fd, &args);
+
+    if (ret < 0) {
+        qemu_vfree(buffer);
+        error_report("failed to get synthetic timers");
+        return -1;
+    }
+
+    memcpy(state, buffer, MSHV_STIMERS_STATE_SIZE);
+    qemu_vfree(buffer);
+
+    return 0;
+}
+
+int mshv_set_synthetic_timers(int cpu_fd, const uint8_t *state)
+{
+    int ret;
+    void *buffer;
+    struct mshv_get_set_vp_state args = {0};
+
+    buffer = qemu_memalign(HV_HYP_PAGE_SIZE, HV_HYP_PAGE_SIZE);
+    memset(buffer, 0, HV_HYP_PAGE_SIZE);
+    args.buf_ptr = (uint64_t)buffer;
+    args.buf_sz = HV_HYP_PAGE_SIZE;
+    args.type = MSHV_VP_STATE_SYNTHETIC_TIMERS;
+
+    assert(state);
+    memcpy(buffer, state, MSHV_STIMERS_STATE_SIZE);
+
+    ret = set_vp_state(cpu_fd, &args);
+    qemu_vfree(buffer);
+
+    if (ret < 0) {
+        error_report("failed to set synthetic timers");
+        return -1;
+    }
+
+    return 0;
+}
+
 int mshv_get_simp(int cpu_fd, uint8_t *page)
 {
     int ret;
-- 
2.55.0


