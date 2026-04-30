Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3983CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7l-0007cr-Bt; Thu, 30 Apr 2026 13:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7K-0005nJ-CH
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7I-0004m1-MR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zn8RRQ341S74sORTOTdO4e8NZ5+pj0NRoVRqFUU0850=;
 b=euMzv7dYjbyORWbrTrMNJZ8ywYw53NmoiL+hp7jR+fGVTJ8shQtP+/DKMKezJcy5oAKnAE
 NE2btNZYYT7vKu/8n6z2z0ZXTUTHAoogPDfQxKnJdzUuHowd48QH52byby/jv1OAt+i31r
 U2nXLeneid0P3cI2S6LZkQEgUFYnoK0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-_L6FT3GpORu67p3GxH1xPQ-1; Thu, 30 Apr 2026 13:23:58 -0400
X-MC-Unique: _L6FT3GpORu67p3GxH1xPQ-1
X-Mimecast-MFC-AGG-ID: _L6FT3GpORu67p3GxH1xPQ_1777569838
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8d60fca52b9so206909185a.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569837; x=1778174637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zn8RRQ341S74sORTOTdO4e8NZ5+pj0NRoVRqFUU0850=;
 b=VmwSLV68jTV2GWoaZef2AqGZ1T1Cp5TiyxySnrcf6N3R+P87mM2i5eSis0aLs6D9VL
 ujNJAQqN3MYNyuk988ZAMss6KbebI8O8LZg7ANaV2gj4nU1/FA+dv4/hQBCkls5Pp+kW
 ouQxptsbOx7V8HzmaaOmOhJYkdmiXf1TdO78EqFPPuACz0+o8Ykb+sfmZRDKV5x+0Gx3
 T8RfEc8/O0/65vC8wS/FBEl4PcNsNnmax8P1EKKuDaNZ8txT2rV0QrAbu8PuJzjX7Rum
 mEfl7xaRtbKXaurkLglGIWyj8THZvzaFRWTR/3Gsu9Ngng/uy9RHOrQU2DmfojKtrgae
 HKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569837; x=1778174637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zn8RRQ341S74sORTOTdO4e8NZ5+pj0NRoVRqFUU0850=;
 b=gH6rI/kEokaIv6IuJ5/YLWP+zn50n0mzUJGH8e591TRbz4qTxL7Z7e5QSZ1wRsPWH7
 RaKNaIVfNXKGVCbzA0hnALJacCKIwr4bQnvAMbF0I61sxmXvqNKy/jbChf35qvBo4Fkh
 qgojSaWwvT/lgaH78VY8f0eW45xjSKlQ2qyM7jfjVbLLskqCCWqdNbFdjVlDRaPcnuK4
 McDVH96rdjlMBxuwxVe4lrQY1HMvw2EeTZ24j2CZ3pbavIZUY48rn/0qqwWiNJjz8Rrw
 jD+AalLiTK+ZsW1DpqYAPPfHzXga4rZABi8lg6w28dXx1Bj2h5b4KAowTsFBNF81/DIy
 bjGw==
X-Gm-Message-State: AOJu0Yw74hE0kEwKeJA9Gi7XdoRWBu3WcQ7fJeOsKoHQCSlUSNQs138a
 8Uaf1RyXqQNX53DgoOG5mFnqq7F2byR0268mDwI2MV4NoPwmymZfws0VX1fpwu+ezCHnMys9meI
 uvB1yCyE5GRw5YEQ+7uHr54yUV0ZIOws44QrZDn4fXsYFp+sPV48IYouk1NNyoCjloY8Yt4vVGI
 GSGiKb9lbS0nUSB2CnpmqFCnjlhHM2QoNjlDM2CPtr
X-Gm-Gg: AeBDietv5WbCgpHoI3iWNmj2ZA40VNXkIRxA2lvU0fCb1heeyXncKV3FxLKEKn0Yh7Y
 ZyRSAA7gt3lgj5QQMqMPWiHi87JcX67JdS/LzJxLLl+Tb6YOcfodBfroq/jFFkOUy6i9xMGYTi9
 JGJvUyZ2dpLLZwmn5k1kRNdL/FG1s0Un6Oxw7jWhu+3r7Ec0WiWIRiro2OZs0Tucx1i4LNVWkON
 EiEnPztkLrXM3scOhhcW5gMY8n2hQ5Aryuv+2c0pLGST5xpTqA1coXTKyG12gJPZIBN9wUXEnpW
 XrBeoIUConWSBcC+Ekuy4a/KkkFT2pc9nFAO2BtKhGH9mcjVg/BFgXljq9LYrSshJnvxr0BI4mJ
 FR0PPT9EaQ5zWj50D8cMlgMxSmdiqiLYwFda1bPcDg69rUQY2X62Q/mfgWoXgANY9TvHpKDZhZF
 EMe3szA/zt681CiBCQMNjAl4E6jBv0Bxnq+VA=
X-Received: by 2002:a05:620a:4627:b0:8d0:191:69b5 with SMTP id
 af79cd13be357-8fab2140c16mr480772585a.54.1777569837500; 
 Thu, 30 Apr 2026 10:23:57 -0700 (PDT)
X-Received: by 2002:a05:620a:4627:b0:8d0:191:69b5 with SMTP id
 af79cd13be357-8fab2140c16mr480763285a.54.1777569836657; 
 Thu, 30 Apr 2026 10:23:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fbb15ca74bsm24236585a.20.2026.04.30.10.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 35/58] whpx: i386: interrupt priority support
Date: Thu, 30 Apr 2026 19:21:41 +0200
Message-ID: <20260430172204.1006673-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Implement APIC IRR interrupt priorities.

Even with kernel-irqchip=off, Hyper-V is aware of interrupt priorities
and implements CR8/TPR, with the InterruptPriority field being followed.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-14-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index cbcf1de7ae4..012fa6d0216 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1673,6 +1673,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     UINT32 reg_count = 0;
     WHV_REGISTER_VALUE reg_values[3];
     WHV_REGISTER_NAME reg_names[3];
+    int irr = apic_get_highest_priority_irr(x86_cpu->apic_state);
 
     memset(&new_int, 0, sizeof(new_int));
     memset(reg_values, 0, sizeof(reg_values));
@@ -1708,10 +1709,20 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
         }
     }
 
+    if (irr == -1) {
+        if (isa_pic != NULL && pic_get_output(isa_pic)) {
+            /* In case it's a PIC interrupt */
+            irr = 0;
+        } else if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
+            abort();
+        }
+    }
+
     /* Get pending hard interruption or replay one that was overwritten */
     if (!whpx_irqchip_in_kernel()) {
         if (!vcpu->interruption_pending &&
-            vcpu->interruptable && (env->eflags & IF_MASK)) {
+            vcpu->interruptable && (env->eflags & IF_MASK)
+            && (vcpu->tpr < irr || irr == 0)) {
             assert(!new_int.InterruptionPending);
             if (cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
                 cpu_reset_interrupt(cpu, CPU_INTERRUPT_HARD);
@@ -1768,13 +1779,17 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     }
 
     /* Update the state of the interrupt delivery notification */
-    if (!vcpu->window_registered &&
+    if ((!vcpu->window_registered ||
+        (vcpu->window_priority < irr && vcpu->window_priority != 0) ||
+        (irr == 0 && vcpu->window_priority != 0)) &&
         cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD)) {
         reg_values[reg_count].DeliverabilityNotifications =
             (WHV_X64_DELIVERABILITY_NOTIFICATIONS_REGISTER) {
-                .InterruptNotification = 1
+                .InterruptNotification = 1,
+                .InterruptPriority = irr >> 4
             };
         vcpu->window_registered = 1;
+        vcpu->window_priority = irr;
         reg_names[reg_count] = WHvX64RegisterDeliverabilityNotifications;
         reg_count += 1;
     }
@@ -1788,7 +1803,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
             reg_names, reg_count, reg_values);
         if (FAILED(hr)) {
             error_report("WHPX: Failed to set interrupt state registers,"
-                         " hr=%08lx", hr);
+                         " hr=%08lx, InterruptPriority=%i", hr, irr >> 4);
         }
     }
 }
@@ -2004,6 +2019,7 @@ int whpx_vcpu_run(CPUState *cpu)
         case WHvRunVpExitReasonX64InterruptWindow:
             vcpu->ready_for_pic_interrupt = 1;
             vcpu->window_registered = 0;
+            vcpu->window_priority = 0;
             ret = 0;
             break;
 
-- 
2.54.0


