Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4F7D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwytr-0003AJ-Lp; Mon, 02 Mar 2026 03:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytQ-0001w6-Hv
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytN-0001al-73
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rk5SULnMgDTQKKXSzTMen0TGNNIoLrqNZFPrXzrPfxI=;
 b=BdAYRsobMHOsl/zqFTMmc5Ip8OgotC7uMxBGfxwZ2RcQXTTk2G6xhnbYj5wGI+g4Z3C3Zb
 H/tiomRGrUSGgQDuRsJSUMV6xZJd2bYc8cTdwxvs05ZCsgueh+HpEidX0VEjAhuV6UE5Z+
 LLsMZaQyN4a3pkZOHPajvdHb7b80dLM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-VohWB_uANIWltlicy9U-eA-1; Mon, 02 Mar 2026 03:44:38 -0500
X-MC-Unique: VohWB_uANIWltlicy9U-eA-1
X-Mimecast-MFC-AGG-ID: VohWB_uANIWltlicy9U-eA_1772441077
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-483a2db68caso34653345e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441076; x=1773045876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rk5SULnMgDTQKKXSzTMen0TGNNIoLrqNZFPrXzrPfxI=;
 b=Zaf8biIBQ68JFQPvczJddJ7EFb0Ui/iuI/OXtlzBU5ipce/6gHskffI8fzEb9tCIgX
 nOsRi4BNeCkGFrabeL3t8oRo43CiCj18d8kMm48WYC6TqJjwtWyYiJI//j3fUWgHGPIh
 2z06CHxwQgN+yG8EVK4qGzrnycXxMbxzC101o0s6VqqFKZFepf5Uwylg+AgqlBiwyiGz
 PBxgYi2bUKB5PxRG0rRaI/++nba9YWKoPsseIdGcLNvEsepP7SauqPR/stuz57yl+iYS
 U6kLySrUe4vO8YAbC8ot6xcmuDzS/kBusG/Dion9GYUAD0+9NY53d3cwLT2GWC9n3UyW
 Zp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441076; x=1773045876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rk5SULnMgDTQKKXSzTMen0TGNNIoLrqNZFPrXzrPfxI=;
 b=fQzY2y96hsGg7JMUojyGZWRS5J97HH1GzbObV+A4PFZxaeYQr4g+8VmNa5sQ+VcuIp
 7QGrLWvav/5C2a3wCveYrOZxv+q4WmnZLbgYlQ8WkbrvTYHlF1Dl/7bOBJgwLEOHBt8v
 arCxFsF5E9uFkQtwXZ/iGh4vdBpyXcSr0KV4cKVE+y4vw+6HbfKk2t2pxGnZl11E1saQ
 d41hbo2SFzeK+wkreJbgRHP02c1NzerGSnqLzKy6WiBppWJqwU0bg5z/z9lHMz6L2fjt
 tb0Tc8+4Gm/fBUW2yj0yLRM+T8PvSVKGbEmQCXEd4j5efMbdRs9LVVd/CapSx0GscqyW
 +Uzw==
X-Gm-Message-State: AOJu0YyJo5/+Nj6CQ5nAWOLRLuGSklfoWp0fUxjUVL7rEh+9EVtE9Pq1
 UpYjNXYlbZWC23vBTyJ9FqoL8POvI+8A8VoKKiy4d3nrQNx7thMlNzfKBwtjjs3rULOseU0hwEq
 czHx4e1W2UvZAP87Tv7HqoEnuElpjjaD1eKpxk2zfEjOBTnrvk2HFtRUsQa0o+ACRDJgbfS5pEo
 QlgC0hsqHMgFN4MK0MnPVQzDmAVIROWLkFjrB5Ag7L
X-Gm-Gg: ATEYQzzJkIR0BqTeHLIuFHgG8Qa24JCeIRO1kjmKPx1x1fcIbhBO988Xe11xn52RvS+
 0vdgVzJsBc83Jt3V50hC7kmGHtwC+hkGIkdOF4QJPuPQ85886GYPRPOu361+2IqCqLhzZ7OL9k7
 U4rcNo9XB5Y5G36oHUQJ2bIwxR/h1DotvJCivU7ESqUdPircbt8oJc8y0xtGreA03Si7k4+2yjT
 Y988ogicLVHqP0WDpiOggaWWrC6UHuIF90zLoFOVvg+1EI324mZnn/dPJIhnHyLT1k7wAK39sRk
 alHnP1+qJesvVv9wPEWGGCOjSAoOjnmSAeUhiT7zj2m5e8EUWPPX8fq7ZQ0VIpBEmqhQ/ZWmeW9
 EDcAjiNw0behlN7AN8pdLkQajFPHcpmbLDADK52YaPYY9cih4ZHsdpkkaNSZW08h/iI1OtKDTM/
 7ktgr9KBPgDnIC8CcV10kU/oCfjlA=
X-Received: by 2002:a05:600c:470a:b0:477:abea:9028 with SMTP id
 5b1f17b1804b1-483c9ba68eemr183395665e9.6.1772441076551; 
 Mon, 02 Mar 2026 00:44:36 -0800 (PST)
X-Received: by 2002:a05:600c:470a:b0:477:abea:9028 with SMTP id
 5b1f17b1804b1-483c9ba68eemr183395185e9.6.1772441076064; 
 Mon, 02 Mar 2026 00:44:36 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfccb9f9sm132058095e9.23.2026.03.02.00.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 021/102] hvf: i386: save/restore CR0/2/3
Date: Mon,  2 Mar 2026 09:42:16 +0100
Message-ID: <20260302084338.473368-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

For symmetry, save/restore the same set of registers even when not needed.

CR2 save/restore needed as page faults injected to the guest imply modifying CR2.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260223233950.96076-21-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index fb039ff7bd5..a70f8461b04 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -477,7 +477,19 @@ static void hvf_load_crs(CPUState *cs)
 
     env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
     env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
+    env->cr[2] = rreg(cpu->accel->fd, HV_X86_CR2);
 }
+
+static void hvf_save_crs(CPUState *cs)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    wvmcs(cpu->accel->fd, VMCS_GUEST_CR0, env->cr[0]);
+    wvmcs(cpu->accel->fd, VMCS_GUEST_CR3, env->cr[3]);
+    wreg(cs->accel->fd, HV_X86_CR2, env->cr[2]);
+}
+
 void hvf_load_regs(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
@@ -794,6 +806,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
             decode_instruction(env, &decode);
             exec_instruction(env, &decode);
             hvf_store_regs(cpu);
+            hvf_save_crs(cpu);
             break;
         }
         break;
@@ -837,6 +850,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
         assert(ins_len == decode.len);
         exec_instruction(env, &decode);
         hvf_store_regs(cpu);
+        hvf_save_crs(cpu);
 
         break;
     }
@@ -942,6 +956,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
         decode_instruction(env, &decode);
         exec_instruction(env, &decode);
         hvf_store_regs(cpu);
+        hvf_save_crs(cpu);
         break;
     }
     case EXIT_REASON_TPR: {
-- 
2.53.0


