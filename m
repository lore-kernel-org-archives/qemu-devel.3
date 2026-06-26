Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F720CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd3ev-0002to-4p; Fri, 26 Jun 2026 06:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3er-0002ZM-D7
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wd3ep-0005Pg-H9
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 06:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782469174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3y6MpIRsqSm+hRQ0htHk7PXvzfcAGWEttHbyWAVRX6E=;
 b=MWotOpB/ddtmCUysJwyjndZV+eDXkvGxvqt8VFEpViVbWK2GJBXXxwwX1eRL+lUNSVLmav
 pj+OCmtKC8LO7shJZ4nRFfeaWVLBiGC3pjX+9DDzyEdK+WN6jIn5pDQcc/DPu/8p5iKGSu
 gaGWnmc5kFes8+cgpSsgxHEC0n8ZoPs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-q_L5pJ-gNJqAPhzwpvtDrQ-1; Fri, 26 Jun 2026 06:19:31 -0400
X-MC-Unique: q_L5pJ-gNJqAPhzwpvtDrQ-1
X-Mimecast-MFC-AGG-ID: q_L5pJ-gNJqAPhzwpvtDrQ_1782469170
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490afe64f26so4034825e9.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 03:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782469170; x=1783073970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3y6MpIRsqSm+hRQ0htHk7PXvzfcAGWEttHbyWAVRX6E=;
 b=gsjNBa6gyHhs9LW9TJn54xyXGMuRRLl78z7mBtzsbTEAb/C97KBbm6HipnQnd4qv/C
 UriQd1QwreXZ0CzHGXMkTsdiqKdOo+UMtvdyC7GNVeu+jjE2M3jB3Vbg5lh3HQTI8KvF
 BEzuMj/+YOjpN78irbLJl/euxKpGI2ajupNcJUcKN9OIOkgSu+hhHJr8wAfjzIEe0EML
 Xqj5nUS5RR/6uO7P95twqpuUTtJ2Xkl70eIwN0bf2ExHGUw90HY3CMhz4evnfcU7k50p
 0jkQ3QdZ9psX3uqJl2kYpyDJOBVey7koGpdV0LMGuhO+67SksAnip1IbKPyvPC09OOyy
 GxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782469170; x=1783073970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3y6MpIRsqSm+hRQ0htHk7PXvzfcAGWEttHbyWAVRX6E=;
 b=Ud9esy0bR+Ioh2uAq9t3pPAR3NBiztgvp3VINYZxwIddz2p3I6NvSb1oDwIAD91WdA
 Lk45wF6EksDPhDxZwjOtZ99mkKBgjLz6i+Zws2spkg7nxmWq82FdRbUIWpjFFeEypnPo
 fGJI7c3VULJ+r35qIHR+DojXYWHBg8BLM4SG+gXKzY85LGeyictviM/mhnb1xojGwsD1
 F+Zjer8dtSuK9bbwJTrCfTiFjhGCPr11sTWsX4KrxjHOpsjbEWTbm22rGlP2zZLNjFhA
 NIyu3w5NuuZlCm9Ptqs2vF5U9UfD1pULKw9nKOv1yVAFBPT3ULQ1J/1hjy4BlyeLrcUq
 ti9w==
X-Gm-Message-State: AOJu0YyN+ENOj7TKURGdWEEduUxX08x7+CWRE1+SpaE6hCg4VyR51nvQ
 RiTGvNh7LVjF3DYaFxm+gbsoeOYtwx9hkxQJP6Db+urgHdXcWY5rS6/fZBsRYQnMDaiCuOGag4y
 OvWE2vXfoPgLjTPqbu+OrZDswQk/uHZoZ5dXn/PYCBiM18vGurBRyA7CV016dkkvzJGUjTPBkki
 eecoMegEgG+o15Rtc4y/LWd1x4zgKur/xJODnDHkQR
X-Gm-Gg: AfdE7cmLFd0lglGjq4KFkeglXjBQ0O9VcJTVuO6krZi/TQ+9Sydr+vz1YCgrCDnJoLG
 Bgs8tr4o6+PUecd2mOr7TFZVHvQZW0jVvi5LTtE+/VBXpL1v4X35S+xAHjWkxLal3R9aVF5Ozx1
 ailW3M0DFvvXy2IJV+lCit60fvSwaZVFDseUCjoz5sBZ7QpV9o6tlF7lUZh3h5V24+rKSdCSPu+
 9RAxpOJbM7stwmULxjSl1IbjZCaWr7c8n+VscTSiDbc1DUBmOQsx+cbqvOanIy50Y6YEQr++p5/
 peHZRGUFAaiORO1RWDlt7DV1qNKypOSpd8JcKTJO5X+zsn6+ddaWv9R260b9WxjwtCtaEugcxMh
 dh0Yq0lP0IGVQKb6kY+0d6fn1ekGMv3FhbM0oyzcwhVY8kSTA9G1rCYHTrFDIx/uP2/OmOos/lX
 NcAXkYK50gGO7p3ZJL
X-Received: by 2002:a05:600c:a00f:b0:490:b26c:64ad with SMTP id
 5b1f17b1804b1-492663e185dmr85546795e9.5.1782469170367; 
 Fri, 26 Jun 2026 03:19:30 -0700 (PDT)
X-Received: by 2002:a05:600c:a00f:b0:490:b26c:64ad with SMTP id
 5b1f17b1804b1-492663e185dmr85546305e9.5.1782469169851; 
 Fri, 26 Jun 2026 03:19:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fef710sm119444625e9.7.2026.06.26.03.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 03:19:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 37/45] target/i386/mshv: use the register page to set registers
Date: Fri, 26 Jun 2026 12:17:40 +0200
Message-ID: <20260626101748.1728079-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626101748.1728079-1-pbonzini@redhat.com>
References: <20260626101748.1728079-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

Update mshv_store_regs to use the register page when it is mmapped and
valid to set registers.
Otherwise use the ioctls to set the registers.

Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
Reviewed-By: Magnus Kulke <magnuskulke@linux.microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260428135053.251200-7-dblanzeanu@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 44 +++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index ed78fa09934..126ca40b481 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -457,14 +457,50 @@ static int set_standard_regs(const CPUState *cpu)
     return 0;
 }
 
+static void mshv_set_standard_regs_vp_page(CPUState *cpu)
+{
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+
+    env->regs_page->rax = env->regs[R_EAX];
+    env->regs_page->rbx = env->regs[R_EBX];
+    env->regs_page->rcx = env->regs[R_ECX];
+    env->regs_page->rdx = env->regs[R_EDX];
+    env->regs_page->rsi = env->regs[R_ESI];
+    env->regs_page->rdi = env->regs[R_EDI];
+    env->regs_page->rsp = env->regs[R_ESP];
+    env->regs_page->rbp = env->regs[R_EBP];
+    env->regs_page->r8  = env->regs[R_R8];
+    env->regs_page->r9  = env->regs[R_R9];
+    env->regs_page->r10 = env->regs[R_R10];
+    env->regs_page->r11 = env->regs[R_R11];
+    env->regs_page->r12 = env->regs[R_R12];
+    env->regs_page->r13 = env->regs[R_R13];
+    env->regs_page->r14 = env->regs[R_R14];
+    env->regs_page->r15 = env->regs[R_R15];
+    env->regs_page->rip = env->eip;
+    lflags_to_rflags(env);
+    env->regs_page->rflags = env->eflags;
+
+    env->regs_page->dirty |= (1u << HV_X64_REGISTER_CLASS_GENERAL)
+                                | (1u << HV_X64_REGISTER_CLASS_IP)
+                                | (1u << HV_X64_REGISTER_CLASS_FLAGS);
+}
+
 static int store_regs(CPUState *cpu)
 {
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
     int ret;
 
-    ret = set_standard_regs(cpu);
-    if (ret < 0) {
-        error_report("Failed to store standard registers");
-        return -1;
+    /* Use register vp page to optimize registers access */
+    if (env->regs_page && env->regs_page->isvalid != 0) {
+        mshv_set_standard_regs_vp_page(cpu);
+    } else {
+        ret = set_standard_regs(cpu);
+        if (ret < 0) {
+            return ret;
+        }
     }
 
     ret = set_special_regs(cpu);
-- 
2.54.0


