Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F700E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 16:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYRbk-0000yH-GZ; Wed, 24 Dec 2025 11:21:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRbi-0000wW-TZ
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:21:02 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYRbh-0002cv-2g
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 11:21:02 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47a80d4a065so31558455e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 08:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766593259; x=1767198059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=juT4/T0SEiEr/UyyLMB0enuCtj5pl2o78TXrIKmgVQY=;
 b=o1y1vgTsaZpziI8OzDhp0P0zdEyApCSGB47t3nhx5U/6qXJ/cV3F+EZjR3BwN6wWJS
 6NVyOXeHQKpULTU44dDfH/sgEWJ9vq1/AFqBy54fyzO8ubXl+nxaYqk3m9gby63i8WCW
 3OF6T0N0R8Dz28YtN8ptUJZVaaFrvxYJABKyFNNHqdYpNogZy+nTeaRBYI4ndtpzprYY
 7oOQE8VKLH2AwRaXt7hgOewyj0dcla22uWQAgzb5kMwFE6+uI/2M78KBFz7Q56GqxStK
 NxcBzvH+g8Jnw5n1a6VPNN2duWqpmuxzkn3GFAFuvUr6/wgmG9lORjupF8xgWRphPQtw
 tDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766593259; x=1767198059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=juT4/T0SEiEr/UyyLMB0enuCtj5pl2o78TXrIKmgVQY=;
 b=dJ0xivfFyU0P5FTJ0KL9CiYOa8MFpfSsFmngp3ps4i21Ei6IxrvaMtMAoYUcuFJ9he
 DllJ3GbM3ePXKl2MzvfDaBYEhXbhbmRg3SdI7FSfMGEbZWFbnsx0oIDLq4vFFV8FK4o4
 BTrQDjDJv/fjC3xAGZ80IGMZ+7RE+P54aQDjDVR/hL7QZ6siaoW6EbQWru+lts+hi0cb
 CHQxVJsGuk6Lba9SKRAGCQm96ZF2jrWMMJa/wKXVDd1Dpx1Kpqjw5V8TVKGIRWulBVZI
 9y3CP7fUYR4TybruhU1GgC2SPbo6FE7XBrKzHLigzwkubqpgIVrP+2PGtfOgAXz1y29P
 f/IQ==
X-Gm-Message-State: AOJu0YwA29mGR4nbCGjjUua5A0CKeqrPY9uR/YlZElHyXWzi2enQYKEM
 w5nNcGo0tNlVlXYXf1f1MWFLMMbXKKbZKnsTRSqt/3sJM4cm+OYYPYGd5z08YaqHDrwxxYxS63I
 4P4F/YdI=
X-Gm-Gg: AY/fxX6/duwzGG4zJ3FnXhAwzXf+3yCzX3Z7pbfXsw5EoZ38HWAvFB8TbmnJfAhio5D
 m+DSr610tpOXPdfu1LW+eUChE5G2kXhYNZ0KqJk8n2VAwyVrnisXkUvqLXIlFmqLMOy02/dWkEb
 sYPv3yU9qluwk1Pv5vYF/63eBhgEyZsGAWt0eV+aOBCAZgo7tl6VdSUocW6bJnZIDfupBJSacA1
 c7TbBzdjmN5Y1vIHOumjfVTP0O+Q0Yr1kYr7OKGTTYXquZiZgUvSHYPgg1Eo6gKAcI4EH1yAWu1
 aFdMGQfBKda34uLG3hkabCeQfyVOrm+c0efdPH4OuSsDuUsxuc9Ro/w9zDlEisWkxrFJ5E5etCS
 xwZwSWxJfWKV1kDxI2MZTQ2DE8gJO8K7RU9Gc7YkwuPs9+0Y54tKtw9xqPBSG/nGV/n35gO5WDD
 iRsGwz0PnP0kyw/yFgjU4EhiNgz62drYUsFB89KSNjgoNJqwMMux5QempcRjIFwJD7gw==
X-Google-Smtp-Source: AGHT+IEEdTjA6Yb8+O8T1c4JXcy4ofp6xvFqRANpSPTDtyIhru+yTeox/DsSknIT4hZrAWLuAnjqww==
X-Received: by 2002:a05:600c:3b15:b0:479:3a88:de5d with SMTP id
 5b1f17b1804b1-47d247132b8mr153306995e9.36.1766593259289; 
 Wed, 24 Dec 2025 08:20:59 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b36fsm34949704f8f.5.2025.12.24.08.20.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 08:20:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Anton Johansson <anjo@rev.ng>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/8] target/s390x: Use explicit big-endian LD/ST API
Date: Wed, 24 Dec 2025 17:20:29 +0100
Message-ID: <20251224162036.90404-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224162036.90404-1-philmd@linaro.org>
References: <20251224162036.90404-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The S390x architecture uses big endianness. Directly use
the big-endian LD/ST API.

Mechanical change running:

  $ for a in uw w l q; do \
      sed -i -e "s/ld${a}_p(/ld${a}_be_p(/" \
        $(git grep -wlE '(ld|st)u?[wlq]_p' target/s390x/);
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/cpu-system.c      |  2 +-
 target/s390x/kvm/kvm.c         |  8 ++++----
 target/s390x/mmu_helper.c      |  3 ++-
 target/s390x/tcg/excp_helper.c | 16 ++++++++--------
 target/s390x/tcg/mem_helper.c  |  5 +++--
 5 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index f3a9ffb2a27..b0c59b5676e 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -63,7 +63,7 @@ static void s390_cpu_load_normal(CPUState *s)
     uint64_t spsw;
 
     if (!s390_is_pv()) {
-        spsw = ldq_phys(s->as, 0);
+        spsw = ldq_be_phys(s->as, 0);
         cpu->env.psw.mask = spsw & PSW_MASK_SHORT_CTRL;
         /*
          * Invert short psw indication, so SIE will report a specification
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 916dac1f14e..89911f356e4 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -1667,10 +1667,10 @@ static int handle_oper_loop(S390CPU *cpu, struct kvm_run *run)
     CPUState *cs = CPU(cpu);
     PSW oldpsw, newpsw;
 
-    newpsw.mask = ldq_phys(cs->as, cpu->env.psa +
-                           offsetof(LowCore, program_new_psw));
-    newpsw.addr = ldq_phys(cs->as, cpu->env.psa +
-                           offsetof(LowCore, program_new_psw) + 8);
+    newpsw.mask = ldq_be_phys(cs->as, cpu->env.psa +
+                              offsetof(LowCore, program_new_psw));
+    newpsw.addr = ldq_be_phys(cs->as, cpu->env.psa +
+                              offsetof(LowCore, program_new_psw) + 8);
     oldpsw.mask  = run->psw_mask;
     oldpsw.addr  = run->psw_addr;
     /*
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 3b1e75f7833..8c87b30a8e3 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -44,7 +44,8 @@ static void trigger_access_exception(CPUS390XState *env, uint32_t type,
     } else {
         CPUState *cs = env_cpu(env);
         if (type != PGM_ADDRESSING) {
-            stq_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code), tec);
+            stq_be_phys(cs->as, env->psa + offsetof(LowCore, trans_exc_code),
+                        tec);
         }
         trigger_pgm_exception(env, type);
     }
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index c6641280bc6..868efca3221 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -55,8 +55,8 @@ G_NORETURN void tcg_s390_data_exception(CPUS390XState *env, uint32_t dxc,
     g_assert(dxc <= 0xff);
 #if !defined(CONFIG_USER_ONLY)
     /* Store the DXC into the lowcore */
-    stl_phys(env_cpu(env)->as,
-             env->psa + offsetof(LowCore, data_exc_code), dxc);
+    stl_be_phys(env_cpu(env)->as,
+                env->psa + offsetof(LowCore, data_exc_code), dxc);
 #endif
 
     /* Store the DXC into the FPC if AFP is enabled */
@@ -72,8 +72,8 @@ G_NORETURN void tcg_s390_vector_exception(CPUS390XState *env, uint32_t vxc,
     g_assert(vxc <= 0xff);
 #if !defined(CONFIG_USER_ONLY)
     /* Always store the VXC into the lowcore, without AFP it is undefined */
-    stl_phys(env_cpu(env)->as,
-             env->psa + offsetof(LowCore, data_exc_code), vxc);
+    stl_be_phys(env_cpu(env)->as,
+                env->psa + offsetof(LowCore, data_exc_code), vxc);
 #endif
 
     /* Always store the VXC into the FPC, without AFP it is undefined */
@@ -651,10 +651,10 @@ void monitor_event(CPUS390XState *env,
                    uint8_t monitor_class, uintptr_t ra)
 {
     /* Store the Monitor Code and the Monitor Class Number into the lowcore */
-    stq_phys(env_cpu(env)->as,
-             env->psa + offsetof(LowCore, monitor_code), monitor_code);
-    stw_phys(env_cpu(env)->as,
-             env->psa + offsetof(LowCore, mon_class_num), monitor_class);
+    stq_be_phys(env_cpu(env)->as,
+                env->psa + offsetof(LowCore, monitor_code), monitor_code);
+    stw_be_phys(env_cpu(env)->as,
+                env->psa + offsetof(LowCore, mon_class_num), monitor_class);
 
     tcg_s390_program_interrupt(env, PGM_MONITOR, ra);
 }
diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
index 24675fc818d..0c7e099df21 100644
--- a/target/s390x/tcg/mem_helper.c
+++ b/target/s390x/tcg/mem_helper.c
@@ -958,8 +958,9 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r0, uint32_t r1, uint32_t r2)
 inject_exc:
 #if !defined(CONFIG_USER_ONLY)
     if (exc != PGM_ADDRESSING) {
-        stq_phys(env_cpu(env)->as, env->psa + offsetof(LowCore, trans_exc_code),
-                 env->tlb_fill_tec);
+        stq_be_phys(env_cpu(env)->as,
+                    env->psa + offsetof(LowCore, trans_exc_code),
+                    env->tlb_fill_tec);
     }
     if (exc == PGM_PAGE_TRANS) {
         stb_phys(env_cpu(env)->as, env->psa + offsetof(LowCore, op_access_id),
-- 
2.52.0


