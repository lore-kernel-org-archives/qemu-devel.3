Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D50CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV7d-0006dQ-1l; Thu, 30 Apr 2026 13:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7E-0005kc-GB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV7C-0004jx-Nd
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rdbdDUV8SBoKHBzZeDrdnJov3VN1o5NNOvVbJYBGDCI=;
 b=Orxt5E0V93SUAswGot5VY0gVfp6ZNdn3T8MGz2E7G+fQOPgI8/YFdLc9hL9/JQXxraM0pi
 3ybe0qKd/vd07QiychrT4u8dReM6zLpqHOCuwrel/FviC/z57zY1pl6Q/+I88xctEDi/Uf
 RCmXJXuYg9VJYb7/vAIb5o8cHrFESUA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-FrJr5b_RPl2q-W4NyFZtRw-1; Thu, 30 Apr 2026 13:23:52 -0400
X-MC-Unique: FrJr5b_RPl2q-W4NyFZtRw-1
X-Mimecast-MFC-AGG-ID: FrJr5b_RPl2q-W4NyFZtRw_1777569832
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8acb85a973cso18028496d6.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569831; x=1778174631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rdbdDUV8SBoKHBzZeDrdnJov3VN1o5NNOvVbJYBGDCI=;
 b=dX6hzX9rz/QQ8HS8mbN6+3fMX07bmEN/mmvxJFRBAilyh5yqaOY8CD+quPX5Ay2BK3
 dKjven47CPOcjk2ZDGvVIVdAD6W89Vqf2Z0SyR2YASLhPSK6Yq/7wPT/YkvPYGcBOkRt
 Gs7WLPvUpAwCfPfYkmylL83+BhpQMSRCvKCqwv7EUIBfmxTichZ5MhmwLnre6y4pczTy
 oup+rJZX02f2KLppgUTNg+irWNfyq5CBa0hLAwT4OEmZgoHtrud/6ma7xrxbQQe0MeBJ
 7JaF3xHOl7Kur+jcb0nSQfBv8vh3ux3XNRfAZRokIV7xhS7YERaeVEnug5IGl5DP9LZb
 gnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569831; x=1778174631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rdbdDUV8SBoKHBzZeDrdnJov3VN1o5NNOvVbJYBGDCI=;
 b=DNhSzoJwX+2kxbXl0alddNUTVnMIDgXE7XJBWZoSAicIx3lS4LoBT7zDCeu8JF3yoz
 tLCuydjhkna8RFBTLLGbLG8+Nwu7WIuxS5B2QxcSBvqx+Wrsi9TTdkPvPCODVtfc7o2O
 3bji2puikmhEVYv0IMgoVSIHEiiGfQ6zgMTxJpZjGF+o6R+WweQMJDwL+myMdJDhUDlc
 z/X8274mHmzPcIUSsM2UIkf+UWKpFQ1gE4Wu59EvSzEztW4xCsLzQ0SUKigY4gI0sRJz
 o5Mei261DGxjVUlMzjTRD4aBpzCcYyU0NtG5UMVdVZDXqJA4faRR3bUW3/m8MRm8Prsx
 IqXQ==
X-Gm-Message-State: AOJu0Yzi3GiUxsuEsU8ideFkW5mWiNEHNACPL7yCEnoBG2mXv9aO4j9O
 zJ807PS2s88q+zC5LEOY0mHrHW5yV4PjFN0MnYbyW2YZo7ec1SjWYhZ6YhIll1wLBtkcyK3Cp2i
 eRSHio2PI4z/DC3x4HJ/o3G1rIIA3DGhAtJmI7r9aA0WHpTI+mQYa+TlpGdm77hFmsEXPznMmrf
 cZ+YMvTmX62m8xxs/wL4vzCwaPFqDhISDVVEHyw1Ku
X-Gm-Gg: AeBDietKdEVqw3ySha/QbH+hQQ/WgiOTnbqDK2W9VB3npwfktqhllxf+x2s0ySQ7Ret
 SNXFHnWSfg/s/g939Rdzs03iWdSHrrib7qlEWarstAWSucvcIOzcayk0B1/HDNya4bs6fzj2k2N
 e3WJMvUUEpLISbbZKVLWIzF/q2GQX5uieNW/9zPTdhFN4cTRhbpC99eDe2BkiInrcDMlPcru2gP
 bR+/3IxWq0VBqpa2RtD6bRc7+83RNuo0dGwbqNjDB1w9hEQ+x/jqdZkbcGIIjZGGZd6ZhffdryL
 2gLPFO/HeLYm4pp4b2l9IVywholbdPzxiTBZFJtjNLk7AQhmtLtox3R8BMunCNDiJWLL3bjsGZr
 yzexzdGofSAPkwB8B6YV8katD6eiViVJOSsGS0s+HjznVi6S2IOz/zGjZeRQ5AEoOSMbaJKU77n
 AbGVy18mBfZSmM20rywpCvtlVHTG2Shn5QuLQ=
X-Received: by 2002:a05:6214:4e81:b0:8b3:f5ab:baea with SMTP id
 6a1803df08f44-8b3fe7e383fmr56142296d6.39.1777569831158; 
 Thu, 30 Apr 2026 10:23:51 -0700 (PDT)
X-Received: by 2002:a05:6214:4e81:b0:8b3:f5ab:baea with SMTP id
 6a1803df08f44-8b3fe7e383fmr56141406d6.39.1777569830347; 
 Thu, 30 Apr 2026 10:23:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff301dd3sm23226086d6.7.2026.04.30.10.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:23:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 33/58] whpx: i386: IO port fast path cleanup
Date: Thu, 30 Apr 2026 19:21:39 +0200
Message-ID: <20260430172204.1006673-34-pbonzini@redhat.com>
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

vmport calls synchronise_state within an I/O port read.
Support that properly.

What was there before worked because of a side effect of
whpx_get_reg synchronising context if cpu->vcpu_dirty.

Remove that whpx_get_reg call in whpx_bump_rip too as it's no longer
needed now.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-12-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index ab8e97787fe..75f0f062d44 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -881,7 +881,6 @@ static void handle_io(CPUState *env, uint16_t port, void *buffer,
 static void whpx_bump_rip(CPUState *cpu, WHV_RUN_VP_EXIT_CONTEXT *exit_ctx)
 {
     WHV_REGISTER_VALUE reg;
-    whpx_get_reg(cpu, WHvX64RegisterRip, &reg);
     reg.Reg64 = exit_ctx->VpContext.Rip + exit_ctx->VpContext.InstructionLength;
     whpx_set_reg(cpu, WHvX64RegisterRip, reg);
 }
@@ -909,13 +908,23 @@ static int whpx_handle_portio(CPUState *cpu,
         } else {
             reg.Reg64 = (uint64_t)val;
         }
-        whpx_bump_rip(cpu, exit_ctx);
-        whpx_set_reg(cpu, WHvX64RegisterRax, reg);
+        /* vmport calls cpu_synchronize_state on an I/O port read */
+        if (!cpu->vcpu_dirty) {
+            whpx_bump_rip(cpu, exit_ctx);
+            whpx_set_reg(cpu, WHvX64RegisterRax, reg);
+        } else {
+            env->eip = exit_ctx->VpContext.Rip + exit_ctx->VpContext.InstructionLength;
+            env->regs[R_EAX] = reg.Reg64;
+        }
         return 0;
     } else if (!ctx->AccessInfo.StringOp && ctx->AccessInfo.IsWrite) {
         RAX(env) = ctx->Rax;
         handle_io(cpu, ctx->PortNumber, &RAX(env), 1, ctx->AccessInfo.AccessSize, 1);
-        whpx_bump_rip(cpu, exit_ctx);
+        if (!cpu->vcpu_dirty) {
+            whpx_bump_rip(cpu, exit_ctx);
+        } else {
+            env->eip = exit_ctx->VpContext.Rip + exit_ctx->VpContext.InstructionLength;
+        }
         return 0;
     }
 
-- 
2.54.0


