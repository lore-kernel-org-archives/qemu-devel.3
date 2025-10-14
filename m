Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E523CCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 13:40:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8fE3-0005TI-8P; Tue, 14 Oct 2025 09:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDo-0005Rl-Im
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v8fDl-00013B-FL
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 09:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760449064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e32N7ZSB2saMjOPTEs5cXNXBo4U73cVipS9h91Ip8+Y=;
 b=i37sqciaIIBiDMlr1z5RYAKWFzkYATypExdqR8ZHhdjJ95lV+MM0NyYOAheCjAG5b9+L/E
 KBlggWYsMga6zRRHlwewBRpTLyCqiIZhIFH2TmaLp0Ayy/4zHh4ebaIa2917633vTCyBJn
 MZ4P2Z0nl0mdXh1O7+gpc0hKDihNrkM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-oFwZ6s8tOc2Y1EvSzKvKNQ-1; Tue, 14 Oct 2025 09:37:41 -0400
X-MC-Unique: oFwZ6s8tOc2Y1EvSzKvKNQ-1
X-Mimecast-MFC-AGG-ID: oFwZ6s8tOc2Y1EvSzKvKNQ_1760449061
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ee1365964cso5309381f8f.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 06:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760449059; x=1761053859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e32N7ZSB2saMjOPTEs5cXNXBo4U73cVipS9h91Ip8+Y=;
 b=PessiixYZH7s5QJv0+zZfnDOgu0qYFRQlB++wvMU+50TT827p0EAhJrukIOhZo4RAu
 kSO7VdzdbTbRAduf6JxgUOdzJpzgVUfhjoccM/WbGAvhcAgYuX7JtpA3cjb9EU83j8Bf
 oOlcIofprwtLVQvEdHJtAdgKQY/MTT/nRx+zuk0kewPAABPA6hvVRtYYlVI3H5SPAZ+1
 pFUIpkqKAJxNoZA+8ywYmIE4pMhd6OH2bp2SmfmUwGswV0mY1R/wTEfJqU35AgS0A57Q
 2+ydlVqSU/LALa8oFD0UV+04b/ksuhw7SWaDIiaSjwQPa1kF6eM+idzhF2WpySMiN2X7
 AjOQ==
X-Gm-Message-State: AOJu0YyHW8HCwarAR4Gb/M5C59noTRmwR5VsirK3s8q9LqPZa+oDbOTl
 MjPM7RXzQGK3Suc8zvqe2W7Dehxp9uwI2iHza58gWZ3VJd+1SMIdSOuNkJR+IqzGfsCxbCBra9g
 BhE8XtuXi20VqSFY70eWCQkimIyhHgbAqr4wyfxvMvQFs7ltD3dcd1T9IGXEFHqBc2E3cQaYgd2
 ce706pnMmBbAl6xJey5VOOwM/wX2ud8/njJsiy1UFs
X-Gm-Gg: ASbGncsy2v2UhkgryCRNBT3hal3jM6wmQKZqdt6Ao20A0505AGQYHhKxiWxxxJ67+Qf
 +HqOXE3tk3tFQC2OEoRqHS6GspGf8qGXyxGNBNZOsNVFrcd++pHRZI53k+dmzXgDB4AoqYwUVsr
 c9k9lFOJ7x+rg2v1o+NB2r68LtD4eHRJthkQfpsalFT/G8YwenGQ2Pn/VDbcPg6f03dkoYrgdDs
 /wGhuCkdQta31GXnovEeHMYpAdfgD5gthgz3UeMfenDQss67ithd9FqhCsJTWAjLPyvMohptwKU
 SUDCzgxAtKGYZVEtDw3lIqe8zrAm/s7uhsYhM74qOJ8POg+9mEFKYB4coaUK8zryzuzLZhcDSLm
 VCqngEneQPsb65qLzaVsEf3u/1leSMUemexizXRLM1Vo=
X-Received: by 2002:a05:6000:430e:b0:3e7:d199:7889 with SMTP id
 ffacd0b85a97d-4266e7c4ed5mr18807325f8f.27.1760449059399; 
 Tue, 14 Oct 2025 06:37:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEICUlNgOSBk2ILbWFjuCrM2q3JRkIPYPwMDYwrTG2ujJznQy0cE01VFRryWowL5W5l6DKqng==
X-Received: by 2002:a05:6000:430e:b0:3e7:d199:7889 with SMTP id
 ffacd0b85a97d-4266e7c4ed5mr18807300f8f.27.1760449058848; 
 Tue, 14 Oct 2025 06:37:38 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e8141sm23553472f8f.48.2025.10.14.06.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 06:37:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 YiFei Zhu <zhuyifei@google.com>, unvariant.winter@gmail.com,
 qemu-stable@nongnu.org
Subject: [PULL 10/28] i386/tcg/smm_helper: Properly apply DR values on SMM
 entry / exit
Date: Tue, 14 Oct 2025 15:36:55 +0200
Message-ID: <20251014133713.1103695-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014133540.1103268-1-pbonzini@redhat.com>
References: <20251014133540.1103268-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: YiFei Zhu <zhuyifei@google.com>

do_smm_enter and helper_rsm sets the env->dr, but does not sync the
values with cpu_x86_update_dr7. A malicious kernel may control the
instruction pointer in SMM by setting a breakpoint on the SMI
entry point, and after do_smm_enter cpu->breakpoints contains the
stale breakpoint; and because IDT is not reloaded upon SMI entry,
the debug exception handler controlled by the malicious kernel
is invoked.

Fixes: 01df040b5247 ("x86: Debug register emulation (Jan Kiszka)")
Reported-by: unvariant.winter@gmail.com
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
Link: https://lore.kernel.org/r/2bacb9b24e9d337dbe48791aa25d349eb9c52c3a.1758794468.git.zhuyifei@google.com
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/system/smm_helper.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/tcg/system/smm_helper.c b/target/i386/tcg/system/smm_helper.c
index 251eb7856ce..fb028a8272f 100644
--- a/target/i386/tcg/system/smm_helper.c
+++ b/target/i386/tcg/system/smm_helper.c
@@ -168,7 +168,7 @@ void do_smm_enter(X86CPU *cpu)
                        env->cr[0] & ~(CR0_PE_MASK | CR0_EM_MASK | CR0_TS_MASK |
                                       CR0_PG_MASK));
     cpu_x86_update_cr4(env, 0);
-    env->dr[7] = 0x00000400;
+    helper_set_dr(env, 7, 0x00000400);
 
     cpu_x86_load_seg_cache(env, R_CS, (env->smbase >> 4) & 0xffff, env->smbase,
                            0xffffffff,
@@ -233,8 +233,8 @@ void helper_rsm(CPUX86State *env)
     env->eip = x86_ldq_phys(cs, sm_state + 0x7f78);
     cpu_load_eflags(env, x86_ldl_phys(cs, sm_state + 0x7f70),
                     ~(CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C | DF_MASK));
-    env->dr[6] = x86_ldl_phys(cs, sm_state + 0x7f68);
-    env->dr[7] = x86_ldl_phys(cs, sm_state + 0x7f60);
+    helper_set_dr(env, 6, x86_ldl_phys(cs, sm_state + 0x7f68));
+    helper_set_dr(env, 7, x86_ldl_phys(cs, sm_state + 0x7f60));
 
     cpu_x86_update_cr4(env, x86_ldl_phys(cs, sm_state + 0x7f48));
     cpu_x86_update_cr3(env, x86_ldq_phys(cs, sm_state + 0x7f50));
@@ -268,8 +268,8 @@ void helper_rsm(CPUX86State *env)
     env->regs[R_EDX] = x86_ldl_phys(cs, sm_state + 0x7fd8);
     env->regs[R_ECX] = x86_ldl_phys(cs, sm_state + 0x7fd4);
     env->regs[R_EAX] = x86_ldl_phys(cs, sm_state + 0x7fd0);
-    env->dr[6] = x86_ldl_phys(cs, sm_state + 0x7fcc);
-    env->dr[7] = x86_ldl_phys(cs, sm_state + 0x7fc8);
+    helper_set_dr(env, 6, x86_ldl_phys(cs, sm_state + 0x7fcc));
+    helper_set_dr(env, 7, x86_ldl_phys(cs, sm_state + 0x7fc8));
 
     env->tr.selector = x86_ldl_phys(cs, sm_state + 0x7fc4) & 0xffff;
     env->tr.base = x86_ldl_phys(cs, sm_state + 0x7f64);
-- 
2.51.0


