Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CD8C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmRYq-0005RS-F6; Wed, 22 Jul 2026 03:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wmRYi-0005PV-Ff
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 03:40:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wmRYg-0000Tk-OJ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 03:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784706002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GIx8SGAxd2EVHX3PLDEtKIS3/cXh7/KX8IzpBchdZxY=;
 b=ZmeV8skTBvZVVUGIt4r6r1PEyqbO+WKazF8qH6MjN57ykHzmpFtJx2KyripbO4x0jMF7oR
 okGNSHri5RpXTwuq1U4Y5nXQcvIC0Q7lrtNQYJoCQSdKxOrA0sYB6vt9jF5R8Gntqp+rHC
 cn/YfXKA3aKX7woDyb6MTB44E27ajoU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-SLajVKm1M5ujsiwSrbpjCg-1; Wed, 22 Jul 2026 03:40:00 -0400
X-MC-Unique: SLajVKm1M5ujsiwSrbpjCg-1
X-Mimecast-MFC-AGG-ID: SLajVKm1M5ujsiwSrbpjCg_1784706000
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f5a972b0eso5054169f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 00:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784705999; x=1785310799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GIx8SGAxd2EVHX3PLDEtKIS3/cXh7/KX8IzpBchdZxY=;
 b=N7ssuqbLgjtAHx81LtaQAdYujoi0qc2dMSzqB5ud3cUzfs2WBc6ZEQcl3WSHjVGwUV
 yXPBLLJ7JwC69s7DuMbu8KhMzcWACfqpnE3NdckABVNnv6AvcfGc0KV8pMjkvRmE/wOh
 3RwdiyEt2Bs2Lac5TNcfocz5X2+YrMP84+bkZlkrdsNun2vXUeV9V2IEBCZaxFXMRGhu
 6xBdtvLRqC92sz4vNoj1zHqL/PnJqYdbPHJA/X374vPMrE2EaT9uumlrOreQZbZiC9gA
 Wxh5Hv6o0yIi2a5zdUl/aK9vtwBipDIDpi4qmwJaAqjs8OZgP95MpwoDX2R6DtWToK5W
 r6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784705999; x=1785310799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GIx8SGAxd2EVHX3PLDEtKIS3/cXh7/KX8IzpBchdZxY=;
 b=lBa85xlKkeeAiCQOCXootJAXtdREkHsHm1sTQ45sKbA55HLdih5TL3oe83AGlWhOse
 XoGjHZpIypaJFjziBbj05oteTUnKlMnE7i5t/Z1S2urxyJ2qV3t5GV+mTJ8BauSXFckW
 meXF+oO3i0hW08Lqdzb0F8vzg5zCfIGGTLPvfmCIs28F6iGriRq5hEKqOGgntUCl3Uau
 x7n6H+mreysGeuFVg2rI3yVOF8Y3zpMnZZFReTmFgPQ8pvT3OlFHMzTg92C3I7ZRJ5oY
 k7cUSjB9xvmcWNlzH7ToCeOTGp4iNqb/pZwAOgROJ63e0zRgDbfGZ8IqQsUKTfKBEMf+
 M5og==
X-Gm-Message-State: AOJu0YziKe6bTz5CKhkXi38s4wHiVYO1qtmOfOMWn5kk8wmMKH4hI7dO
 YWOMrv2Pzq4oJkzJUD2G3IXLvqTIl+lCaIZo/QH7vzf2aqMWSzlStMipTY9z8mszUod2zZys9Bo
 9CbfXKLnWSlFelG3X8q0lZUmARxcQCQ8fcMyLpSyCguHdf5tXrRbEJ3Db0aH3XuxDVb887DRA95
 Gjl/iNjb94182khX6XNrtct1IXVpGWHyC8vBqzOCIb
X-Gm-Gg: AR+sD13HHXPJC1o8b96lwZCr/KZr2oHZzAljb7YPeWhpH4fVE8W85YHoRynM5O7NPpR
 X/9cCEFcWzbWB+LITaM2u9aZjlLLbvuPIIydeCbZkkyAj8JVk1DKoI/MkJ29Ocw7fIG6r6g6vSl
 F9r/nzVdMJSvIS3atyqjyJAYW9EQS+/rAM+N3Cv8DiBO0ehMBTa6/6+8gSgRJWkk2QTP9/n+Rc6
 sTdTZkha7FXvLkXa4gAyK9NgOHlD9xpRmQ6548fVxaFqtX21aXWwEDC16jppjyXK7HrZxiteIad
 OPlWXOQnYjby/WBC5HTqzEMQ/fTo97Y2DV1Px5NPhUhwuHUbdvSlugVDpXAqYXLsuFXUxL8WOEK
 dTfjGisnYNDNF2yAlQJ/pL/ArsZOM5HUcH86Q/PsgPuxbWqJpcv3nydhtSjG/x1xQF35JGjfohS
 5B6U1R
X-Received: by 2002:a05:6000:1867:b0:474:18d9:8371 with SMTP id
 ffacd0b85a97d-47f6232f892mr28676546f8f.28.1784705999580; 
 Wed, 22 Jul 2026 00:39:59 -0700 (PDT)
X-Received: by 2002:a05:6000:1867:b0:474:18d9:8371 with SMTP id
 ffacd0b85a97d-47f6232f892mr28676496f8f.28.1784705999079; 
 Wed, 22 Jul 2026 00:39:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.94.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6e9a2sm3534191f8f.35.2026.07.22.00.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:39:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Andrey Polivoda <apolivodaa433@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 3/5] target/i386: helper_sysret(): Check that RCX contains a
 canonical address when emulating an Intel CPU
Date: Wed, 22 Jul 2026 09:39:41 +0200
Message-ID: <20260722073943.396872-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260722073943.396872-1-pbonzini@redhat.com>
References: <20260722073943.396872-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=pbonzini@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

From: Andrey Polivoda <apolivodaa433@gmail.com>

Intel and AMD CPUs implement SYSRETQ instruction differently.
One of these differences is whether a canonicality check of the address that
will be loaded to RIP is performed: Intel CPUs do this check, AMD CPUs don't.

Currently, QEMU does not perform this check when emulating Intel CPUs.
This patch corrects this by implementing the canonlicality check on a new RIP
value from RCX and performing it only when emulating Intel CPUs.

Flags and segment registers' caches are updated only after checking the new RIP
value to ensure that CPU state is not modified in case the #GP(0) exception
is raised due to the check failure.

Cc: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Fixes: 14ce26e75513 ("x86_64 target support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3223
Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
Link: https://lore.kernel.org/r/20260608091815.31303-1-apolivodaa433@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 58aac720119..d5c174b7fd7 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -1096,17 +1096,22 @@ void helper_sysret(CPUX86State *env, int dflag)
     selector = (env->star >> 48) & 0xffff;
 #ifdef TARGET_X86_64
     if (env->hflags & HF_LMA_MASK) {
-        cpu_load_eflags(env, (uint32_t)(env->regs[11]), TF_MASK | AC_MASK
-                        | ID_MASK | IF_MASK | IOPL_MASK | VM_MASK | RF_MASK |
-                        NT_MASK);
         if (dflag == 2) {
+            uint64_t new_rip = env->regs[R_ECX];
+            if (IS_INTEL_CPU(env)) {
+                int shift = (get_pg_mode(env) & PG_MODE_LA57) ? 56 : 47;
+                int64_t sext = (int64_t)new_rip >> shift;
+                if (sext != 0 && sext != -1) {
+                    raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
+                }
+            }
             cpu_x86_load_seg_cache(env, R_CS, (selector + 16) | 3,
                                    0, 0xffffffff,
                                    DESC_G_MASK | DESC_P_MASK |
                                    DESC_S_MASK | (3 << DESC_DPL_SHIFT) |
                                    DESC_CS_MASK | DESC_R_MASK | DESC_A_MASK |
                                    DESC_L_MASK);
-            env->eip = env->regs[R_ECX];
+            env->eip = new_rip;
         } else {
             cpu_x86_load_seg_cache(env, R_CS, selector | 3,
                                    0, 0xffffffff,
@@ -1120,6 +1125,10 @@ void helper_sysret(CPUX86State *env, int dflag)
                                DESC_G_MASK | DESC_B_MASK | DESC_P_MASK |
                                DESC_S_MASK | (3 << DESC_DPL_SHIFT) |
                                DESC_W_MASK | DESC_A_MASK);
+
+        cpu_load_eflags(env, (uint32_t)(env->regs[11]), TF_MASK | AC_MASK
+                        | ID_MASK | IF_MASK | IOPL_MASK | VM_MASK | RF_MASK |
+                        NT_MASK);
     } else
 #endif
     {
-- 
2.55.0


