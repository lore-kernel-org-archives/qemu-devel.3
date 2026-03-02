Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2046C624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyss-0001W6-EX; Mon, 02 Mar 2026 03:44:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwysr-0001Ve-2J
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwysp-0001WK-EA
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LAHzhuiA9dV8ep+8a24XyrlRe7yv5/OefzsW5S9DsHM=;
 b=L25TaQwusk5IRKGFayLKxaQzAEdgDK2cIaR9R+KBNDk1wBklkFnLRF8NbAVniQAU2mpVJj
 hP09ZTyxUKdNxTIScthy41WTHJwzLimA0oIgMH9q5Pn9WtNrMwpzPocmp9xGbGFDXNvJQw
 XHMQO7XwvdYmmvXz3WYeiZBSI5Rk9Jg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-ty8dQ5pONHm98e2rErFw0Q-1; Mon, 02 Mar 2026 03:44:05 -0500
X-MC-Unique: ty8dQ5pONHm98e2rErFw0Q-1
X-Mimecast-MFC-AGG-ID: ty8dQ5pONHm98e2rErFw0Q_1772441044
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43997e095cdso2909861f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441043; x=1773045843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LAHzhuiA9dV8ep+8a24XyrlRe7yv5/OefzsW5S9DsHM=;
 b=tMRHJq6pGutp0cu5sLqlVNGdIWbQsyNPtqYwy2b9qdZsSeZMKecIq2Pzi6giQ8QS9q
 BP2FU4xRIxA6kjbH+xt8iWrk4YDOMmflcc/DZnNPAvo/yOO3UjeIMqBdLYw0jExcKPoZ
 rQmPtrb7yCvMlYhSZw0J7O0gheOQZUEv0oHqRntdPEoKa0w6BhJVllEKDcaG2Rz4vTDR
 lbn8ReAmKlTcohnq1lafBkwxkrWQ7WPTk/c6hcOqDVqRoZYwyawNED0hG9MrTY0+CFYE
 nkk45S0UF2vGZuAlrHkhD5SiTvj73x7l+CY3XmSUw5PW8bKcGGDPFr7PVWvxT9iHQ8vp
 bR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441043; x=1773045843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LAHzhuiA9dV8ep+8a24XyrlRe7yv5/OefzsW5S9DsHM=;
 b=EwuNrefKHlWQMO0u1DACKN0fn98XPSrgiCJd0Ao5g5NHo9ngZcA4U1yQS+BjUoShqo
 zsfa5dybh91/O7KUTRYlQnZYVJT+DY0nvednS5iC6VUpgd2aqZLe8dQ7C85W6LLiDAMi
 RTfW6vuy7sGsF9sjvbqhGc/e8D62v5ml0ZMElSiEyK549qWlup2cRDrA3WiGUHAZAd94
 D4sTFucraJJk2yvePXyPGmT+WMYLFF7OaQLeHGzlR4AJ7ZvkWxqSsKYUgR40hFpCSYew
 cmnw/K5YXQ91vgOo4Q7Igj+B+fEM/suquSic19+rnJrWgqDlwCqZ/1aYdjTzzyv2NqS2
 SI+g==
X-Gm-Message-State: AOJu0Yzm09nFGdgDcr1FGJs0MIMsAeURX+EeC66TIGGhT7euUzjW4V/M
 nB33JFCxtTFPAs5zK/OXJ0XVfCXZcFGZn9pA37+sPmnJ3NRn1ASwNNuxZ4UIie9jUmhA/fEHx5I
 5xQGzK+SUmBJfGvF4eGAPKcugpK5f4HAC3aKdr5e2zIuMsJ0xvpBSTqayewQ9TzFteB4ZnjY6+x
 XiDh0NLBZFUKCKtFVv56OUIP2tDHR5TZXR1fP7LeIC
X-Gm-Gg: ATEYQzxSUtRkIl2KOhkPR6Gy7f1UMAgjEIWgxpn/BJy2RTGsT6BoT0WrMUPlCRS50OT
 rK8qECnijIzSOx0oLaBqf50K6OsaCmIhP0j6t4W/ZJBcNW+q1CWAK4M84XpeHnMtV4OF0S6h5k1
 VC1uBY+8izF6PrRge/BvQuki2TfuO7kAUhudT9muXUqkuw4O7YfqhiTabzNq5MxTHZC3U41+eTX
 R9/B0axPgiC3G19k5QRp3mHDQxIE5/eY1YKsgA52Ph19jcCN82m8Lj+NFFz00Q8UxQzqowpnsBR
 xkqRLPt9BlAv0uxRm6mzv9PVXn3EZCxqNNEQgxR2TtMIMMilvxFqzkJc0LgW8GUxXwsg0ultSK6
 2a9Kpd8NBYWuGlh66FGVITCXU9fGYmt5tGGcpEnheIDmwER0nwenn0RfEY/bV/N/5XxNug823pw
 4mcsvUtg7CciZG/sAN2RD3kDgWFyE=
X-Received: by 2002:a05:6000:2404:b0:437:6e55:a736 with SMTP id
 ffacd0b85a97d-4399dde3046mr20698801f8f.7.1772441043430; 
 Mon, 02 Mar 2026 00:44:03 -0800 (PST)
X-Received: by 2002:a05:6000:2404:b0:437:6e55:a736 with SMTP id
 ffacd0b85a97d-4399dde3046mr20698756f8f.7.1772441042975; 
 Mon, 02 Mar 2026 00:44:02 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b1b97927sm11040692f8f.28.2026.03.02.00.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 007/102] whpx: i386: re-enable guest debug support
Date: Mon,  2 Mar 2026 09:42:02 +0100
Message-ID: <20260302084338.473368-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Fix what got broken several years ago by adding ops->supports_guest_debug
support as an architecture-specific function.

arm64 WHP doesn't currently provide support needed for this.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20260223233950.96076-7-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/system/whpx-all.h   | 4 ++++
 accel/whpx/whpx-accel-ops.c | 8 ++++++++
 target/arm/whpx/whpx-all.c  | 5 +++++
 target/i386/whpx/whpx-all.c | 5 +++++
 4 files changed, 22 insertions(+)

diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
index f13cdf7f660..3db074c38c5 100644
--- a/include/system/whpx-all.h
+++ b/include/system/whpx-all.h
@@ -17,4 +17,8 @@ void whpx_translate_cpu_breakpoints(
     struct whpx_breakpoints *breakpoints,
     CPUState *cpu,
     int cpu_breakpoint_count);
+
+/* called by whpx-accel-ops */
+bool whpx_arch_supports_guest_debug(void);
+
 #endif
diff --git a/accel/whpx/whpx-accel-ops.c b/accel/whpx/whpx-accel-ops.c
index 50fadea0fd6..b8f41544cbe 100644
--- a/accel/whpx/whpx-accel-ops.c
+++ b/accel/whpx/whpx-accel-ops.c
@@ -17,6 +17,7 @@
 
 #include "system/whpx.h"
 #include "system/whpx-internal.h"
+#include "system/whpx-all.h"
 #include "system/whpx-accel-ops.h"
 
 static void *whpx_cpu_thread_fn(void *arg)
@@ -81,6 +82,12 @@ static bool whpx_vcpu_thread_is_idle(CPUState *cpu)
     return !whpx_irqchip_in_kernel();
 }
 
+static bool whpx_supports_guest_debug(void)
+{
+    return whpx_arch_supports_guest_debug();
+}
+
+
 static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
 {
     AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
@@ -89,6 +96,7 @@ static void whpx_accel_ops_class_init(ObjectClass *oc, const void *data)
     ops->kick_vcpu_thread = whpx_kick_vcpu_thread;
     ops->cpu_thread_is_idle = whpx_vcpu_thread_is_idle;
     ops->handle_interrupt = generic_handle_interrupt;
+    ops->supports_guest_debug = whpx_supports_guest_debug;
 
     ops->synchronize_post_reset = whpx_cpu_synchronize_post_reset;
     ops->synchronize_post_init = whpx_cpu_synchronize_post_init;
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 40ada2d5b65..e01e6499ba4 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -303,6 +303,11 @@ void whpx_translate_cpu_breakpoints(
     /* Breakpoints aren’t supported on this platform */
 }
 
+bool whpx_arch_supports_guest_debug(void) 
+{
+    return false;
+}
+
 static void whpx_get_reg(CPUState *cpu, WHV_REGISTER_NAME reg, WHV_REGISTER_VALUE* val)
 {
     struct whpx_state *whpx = &whpx_global;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 8210250dc3b..e1f0fa5e770 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1272,6 +1272,11 @@ void whpx_apply_breakpoints(
     }
 }
 
+bool whpx_arch_supports_guest_debug(void) 
+{
+    return true;
+}
+
 /* Returns the address of the next instruction that is about to be executed. */
 static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
 {
-- 
2.53.0


