Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E6D606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GjiyjciJ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqUD-0003Nd-Ay; Thu, 22 Oct 2026 06:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUB-0003LD-Ad
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqU9-0001X4-Ec
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792666644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8uG857Yw/J+VrWeb5Of7T05X4Hrj8YcyeL79sHPpMTE=;
 b=GjiyjciJ2Sv6OhDP4+IUby8fjMnqHMTs42085IdiK+6JErtPUepj69D2IUbGUimaf0P30B
 RODR5VbqNsFMT5FMB3B2dCsu1BrHCk+2ZHzR49M87hie7/nW3YkyDrrACEloHC/No7loAm
 v2eyUPxq2W/CiCI4ZNOdHNk6D/YT2so=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-p5aL_ZWBOXatI-4064rRUA-1; Thu,
 22 Oct 2026 10:57:15 +0000
X-MC-Unique: p5aL_ZWBOXatI-4064rRUA-1
X-Mimecast-MFC-AGG-ID: p5aL_ZWBOXatI-4064rRUA_1792666632
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBBA11800624; Thu, 22 Oct 2026 10:57:11 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5D741803A4D; Thu, 22 Oct 2026 10:57:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 14:56:34 +0400
Subject: [PATCH v3 07/18] target/i386: fix FPU tag word in GDB register
 read
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-query-reg-v3-7-7ad902b9a7cf@redhat.com>
References: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
In-Reply-To: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4405;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=IM3+x1/S1cR2SCx9Nb2e/xZ/oIp/3k/WeRpDw1xL/D4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2evmlRDbgQuQFK16hGbI5Cs9c7c27oI7aalcF
 rQfokkslcaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatnr5gAKCRDa6OEJdZac
 5URbD/4hYlwK8ldW/oR3pvlyrijk3UR+OsnQAUt8DK8xofVF2MY15mQM432xftamXqx00l2Mx36
 9ro9blPGzkTT84IId5qWjoitYTxel9HqLEFpkoFmWChxsVORzP96fGP4sNOoRjBbAdm7YaYIyFl
 hs8JJI4dJqi7GCAT+q258Gaf4LVu6sT+s0GwF3Z1+nvCQ0Tyc9u6gAxHQ9lea0HIb3sEmeOeydi
 BWLrUulE6CFjoB0ytSUK7otxjSNAbCIvYhofTRUfsOBQ5E0LZFoX0dXxCtnjO2vMJWBUIK7jNPB
 21ruDYtbkAnM0POg9taRFJ7Db4Zsd1NWOd32yi3IL64+wl8dOX05pf+7CIdcFakjp+GrWF/Y+Zc
 FyDVQ/UDiLZPvdAtRm35caX+uafgSrRjg1EAigH6Sa5BLup4AsnLe2VGFxh/NSnA3LuK68owyPm
 A46/YMHGwpsCm7pruJPXt58hZYGO8a2Qo8sAxdliPd0W0ZnkDwQM7E0T3HPcU4DAPTXHnYZQrCU
 drkKo8HWlg4aOtsF8KNnbi1tGp91RGNk/GXRVQpbLQeQevcz/FdbmNSqD7y2y1EQxxTDkBgGXnh
 W87CBbmyrMHQKbf+gpd6LVQmNKmoKBKFa2hXC18I+eP5y7M8Gf/FuIZUW2jEcrj+LEO8KZuuwIu
 IHfTKFdNtr1YRYA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The GDB stub was returning a hardcoded 0 for the x87 FPU tag word
register (ftag). Factor out cpu_compute_fptag() helper. Simplify a
little bit the code by dropping unnecessary CPU_LDoubleU
reinterpretation, building the value 0..7, avoiding signed-shifting.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/cpu.c            | 28 ++++++++++++++++++++++++++++
 target/i386/cpu.h            |  9 +++++++++
 target/i386/gdbstub.c        |  2 +-
 target/i386/tcg/fpu_helper.c | 24 ++----------------------
 4 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 37732b65e408..2f5ea4e51715 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9372,6 +9372,34 @@ static bool cpuid_has_xsave_feature(CPUX86State *env, const ExtSaveArea *esa)
     return false;
 }
 
+uint16_t cpu_compute_fptag(CPUX86State *env)
+{
+    uint16_t fptag = 0;
+
+    for (int i = 0; i < 8; i++) {
+        unsigned tag;
+
+        if (env->fptags[i]) {
+            tag = 3; /* empty */
+        } else {
+            floatx80 f = env->fpregs[i].d;
+            uint16_t exponent = f.high & 0x7fff;
+            uint64_t mantissa = f.low;
+
+            if (exponent == 0 && mantissa == 0) {
+                tag = 1; /* zero */
+            } else if (exponent == 0 || exponent == 0x7fff ||
+                       !(mantissa & (1ULL << 63))) {
+                tag = 2; /* NaNs, infinity, denormal */
+            } else {
+                tag = 0; /* valid */
+            }
+        }
+        fptag |= tag << (2 * i);
+    }
+    return fptag;
+}
+
 static void x86_cpu_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cs = CPU(obj);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e7a88074c071..116e28a59701 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2989,6 +2989,15 @@ static inline void cpu_set_mxcsr(CPUX86State *env, uint32_t mxcsr)
     }
 }
 
+/**
+ * cpu_compute_fptag - Compute the full 16-bit x87 FPU tag word.
+ *
+ * Reconstructs the 16-bit tag word from the fpregs and fptags arrays.
+ * Each of the 8 physical registers gets a 2-bit tag in bits [2*i+1 : 2*i]:
+ *   0 = valid, 1 = zero, 2 = special (NaN/Inf/denormal), 3 = empty.
+ */
+uint16_t cpu_compute_fptag(CPUX86State *env);
+
 static inline void cpu_set_fpuc(CPUX86State *env, uint16_t fpuc)
 {
      env->fpuc = fpuc;
diff --git a/target/i386/gdbstub.c b/target/i386/gdbstub.c
index c0cde26d978c..420ce845eeae 100644
--- a/target/i386/gdbstub.c
+++ b/target/i386/gdbstub.c
@@ -186,7 +186,7 @@ int x86_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
             return gdb_get_reg32(mem_buf, (env->fpus & ~0x3800) |
                                           (env->fpstt & 0x7) << 11);
         case IDX_FP_REGS + 10:
-            return gdb_get_reg32(mem_buf, 0); /* ftag */
+            return gdb_get_reg32(mem_buf, cpu_compute_fptag(env));
         case IDX_FP_REGS + 11:
             return gdb_get_reg32(mem_buf, 0); /* fiseg */
         case IDX_FP_REGS + 12:
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 4bbac996326e..81ae3d8f3d0f 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -2459,30 +2459,10 @@ void helper_fxam_ST0(CPUX86State *env)
 static void do_fstenv(X86Access *ac, target_ulong ptr, int data32)
 {
     CPUX86State *env = ac->env;
-    int fpus, fptag, exp, i;
-    uint64_t mant;
-    CPU_LDoubleU tmp;
+    int fpus, fptag;
 
     fpus = (env->fpus & ~0x3800) | (env->fpstt & 0x7) << 11;
-    fptag = 0;
-    for (i = 7; i >= 0; i--) {
-        fptag <<= 2;
-        if (env->fptags[i]) {
-            fptag |= 3;
-        } else {
-            tmp.d = env->fpregs[i].d;
-            exp = EXPD(tmp);
-            mant = MANTD(tmp);
-            if (exp == 0 && mant == 0) {
-                /* zero */
-                fptag |= 1;
-            } else if (exp == 0 || exp == MAXEXPD
-                       || (mant & (1LL << 63)) == 0) {
-                /* NaNs, infinity, denormal */
-                fptag |= 2;
-            }
-        }
-    }
+    fptag = cpu_compute_fptag(env);
     if (data32) {
         /* 32 bit */
         access_stl(ac, ptr, env->fpuc);

-- 
2.56.0.116.g6de20f6092dc


