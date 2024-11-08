Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D457CD64072
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9Swo-00045g-Gj; Fri, 08 Nov 2024 12:39:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9Swn-00044v-11
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:39:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9Swk-0007f9-Jf
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731087537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OP2nCBlzAp28MzwtIpWuhyIp1c5H+X+20a82oeDpG08=;
 b=cJkGA8//Vn+8jwf+IVO1t9Jm/0ngtUkXks7TuNIXC06G6ACrtXh7+cmpAHcO2sWw2Ga5ke
 Qjkmoj/+NY3GeUh4NzHf890kD8RwS/B8a8DYBUd6t/E2D+ir/oInJSl9tXFa8JwG7vjhYL
 0RrS6IiwDeAFFGQxbzUcqJvDDCemsyo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-__ZOH7R4OBy6TGn3GraxCA-1; Fri, 08 Nov 2024 12:38:54 -0500
X-MC-Unique: __ZOH7R4OBy6TGn3GraxCA-1
X-Mimecast-MFC-AGG-ID: __ZOH7R4OBy6TGn3GraxCA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d5606250aso1088462f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731087533; x=1731692333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OP2nCBlzAp28MzwtIpWuhyIp1c5H+X+20a82oeDpG08=;
 b=T41ja+BOnw1S7hkzpnSrYfLkQPrPfiwNUR2iZiPcJdAO+KWLcBZAnKd4HA7hD9bnIC
 QzZxLltnvj6c2yhCelViZjEuHWWrY4hilDop3HSA8emsc8dBFHPxipD4uZ7qEUgx2VsQ
 lgpNAC3WXZkycPPKdZUHN8Hfgza64rBx/T7XhwQV9PHIXMd7AjMmNp9pU3Xdg0Oo3QGq
 ZNTFDNbH9kwwrilv1z6ADOyuw6IYBSg5ce0lLnVZc83llYyeXeP1sXMDG7I7DH87/1eI
 YpOzowZrsDyfq0zsL2OVwXtQ5QXCmNRrDKCvZC8plrNWOWJbxixX3N79NFlewY4vBpWa
 L8Uw==
X-Gm-Message-State: AOJu0YyPKIj/0tFYR9c6JwizF3IuLNshViIJpfD6uz59sR0QOUdrqvHb
 s8NJVxVzrYr+TSCAj4FYqnXyCXUz9k8s3Js2xVGz0TDXefUjULL1jfzji9nAMQDjuaK6jqZ8sSh
 JLjuOAZizatoGTKDdY5Xa/0aztDw9MG7Wh0ZohMUX80wDU3dISBG2/+ymk/IRyqZ5i4C2Bzfwg5
 M5uF9+jSPmXXkIVlllH+JKfFal9JIvf8ikk2UeT+E=
X-Received: by 2002:a05:6000:1866:b0:37c:c5be:1121 with SMTP id
 ffacd0b85a97d-381f18651cdmr3428441f8f.9.1731087533184; 
 Fri, 08 Nov 2024 09:38:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMSo00miP+VeX2xsrdldDXwTBzvhCmSBfWXJHK3wYJMRvdVYrK8uxcetakrvTeeWBywNzQ1Q==
X-Received: by 2002:a05:6000:1866:b0:37c:c5be:1121 with SMTP id
 ffacd0b85a97d-381f18651cdmr3428419f8f.9.1731087532712; 
 Fri, 08 Nov 2024 09:38:52 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed9707bdsm5666849f8f.4.2024.11.08.09.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 09:38:51 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <r.bolshakov@yadro.com>
Subject: [PULL 11/13] i386/hvf: Removes duplicate/shadowed variables in
 hvf_vcpu_exec
Date: Fri,  8 Nov 2024 18:38:26 +0100
Message-ID: <20241108173828.111454-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108173828.111454-1-pbonzini@redhat.com>
References: <20241108173828.111454-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

Pointers to the x86 CPU state already exist at the function scope,
no need to re-obtain them in individual exit reason cases.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Link: https://lore.kernel.org/r/20241105155800.5461-6-phil@philjordan.eu
Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/hvf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 8527bce6eef..c5d025d5576 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -586,8 +586,6 @@ int hvf_vcpu_exec(CPUState *cpu)
             break;
         }
         case EXIT_REASON_XSETBV: {
-            X86CPU *x86_cpu = X86_CPU(cpu);
-            CPUX86State *env = &x86_cpu->env;
             uint32_t eax = (uint32_t)rreg(cpu->accel->fd, HV_X86_RAX);
             uint32_t ecx = (uint32_t)rreg(cpu->accel->fd, HV_X86_RCX);
             uint32_t edx = (uint32_t)rreg(cpu->accel->fd, HV_X86_RDX);
@@ -644,7 +642,6 @@ int hvf_vcpu_exec(CPUState *cpu)
                 break;
             }
             case 8: {
-                X86CPU *x86_cpu = X86_CPU(cpu);
                 if (exit_qual & 0x10) {
                     RRX(env, reg) = cpu_get_apic_tpr(x86_cpu->apic_state);
                 } else {
-- 
2.47.0


