Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7652DE8FDD8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQx4-0002Dv-RP; Sat, 27 Dec 2025 04:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwY-0001OB-UJ
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwU-0007Mh-GX
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yAqc8N4nPFsDV6Po1paZbP4Wm2G773jg1VYzIMgqmbw=;
 b=DA2njfMXkJXdLdwYucsWi+OgCH0X4mYomjtg2b25CZYZqAf7zi1g+K5CWq5gX91F7jCipx
 0ZNtrQfs3OB/bcinkmDE8BhN5AmQHh7aVPcpDoyIXEj6+X0AheZcTejTPRtuHr44I3JVdg
 ouu3611KGLqfr6iPJZBH8BKMHAJcwu8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-2huq74y0OwuDk5YEctgDXA-1; Sat, 27 Dec 2025 04:50:32 -0500
X-MC-Unique: 2huq74y0OwuDk5YEctgDXA-1
X-Mimecast-MFC-AGG-ID: 2huq74y0OwuDk5YEctgDXA_1766829031
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47d1622509eso44630045e9.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829031; x=1767433831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yAqc8N4nPFsDV6Po1paZbP4Wm2G773jg1VYzIMgqmbw=;
 b=MTyg91ipE0JikJuWdgScoXcUAb4dHGQQpNz4iaIJc+64TrBUPxkrOsSNyeIlujs331
 8+3/H/nzYFts9ShFw1jAFBUz/0TE0uGdEuKgDyUl1BhfUZaqfjD9jLKwgZys5v1t485k
 R+lMyV+c31hk449TdEBt01B6eHP5qRM6E5/x21G18cT3w7HB14M+Ol39f2aXHb6TG4Sq
 bCVrhQvIQ7zRyvkhjv6kqu+iAuL0/oPIxj9KL+SpczaRs4G3SbKmhuCyz2LN7KMQbgDB
 kzX1a84sRJPFSzC6pM/J7A9u0iUpfmCH97JtSZyZoFE4KvrOqfjLne1vbklNqVWRhkVX
 sjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829031; x=1767433831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yAqc8N4nPFsDV6Po1paZbP4Wm2G773jg1VYzIMgqmbw=;
 b=Pvd7DqD6LY/5mvC1TDMaS4ewkaJnQPJ13XJvJ+8g/97UYzmXfIuVsp4/dNT/VKRX4L
 tfROVQOtl43wVmg+5ZwjgcVAhCZXimmVIdHj9lLfbXdCDwgruYZ8kyQ5F0TuKhcr0uAf
 wrFshg2nMJjX2bfkNZV60Wk1K7sS/O43KI1ircpIXY0qqS4OXpTvnf11cvtfalx5bNKK
 6+vGDr4ClLYUkY7wgTpkjn0sufUy2pnCmFExAk75mqWpAmusbJNOtJIIY6CJnQq57iwm
 qmCNhrsxQ4FzueU85wgn4EONmD6bo1qhOqHvFBaemY5mdl2Httv8tLkmOoqtuu0RABXT
 DOzA==
X-Gm-Message-State: AOJu0YyU3flsUjsqdTcK+v80LPTqH3dhsoG62Jq9bWn1wUCj4NEaRBB5
 Bxxp14ncKZbX+tUKG32ptkX9I/iK4lfeDVzCtVQFL5mDOnIQltANoMd7s5rZPBOcrDtVtqybCUY
 8KLOnai4Sg7+56t3C41hP4NxQF4U0qsfA5Ze4rX4xxRoG58wPYpfbZzEOW6VAmtgmm2OvViBWRH
 4bS5mcj43d0CZRB6pHjAXJRfCdapazaRLCGhLISEK9
X-Gm-Gg: AY/fxX6P2noQ3nJwEJA5WpB4Qng94LV63ysf9LXglQ+Mbq8DUMzAivTdXswnUylITry
 sQW0ChXP62EPjDXBOFbPrX+PMofhMhwTty1SpnJVHnNnWZjceYxAaXQo5ltP38P5n4Z2N7onyBs
 U+V5WduYacueJ8BF62O7rpDV8N0JNJr7RJGacHwRnSlOa3VgJLyBSEdyxKF4xXAzbHN9zEyD/VG
 XzGvTq0km7iUGBNmduiyhWquJ/Q07lg6BhRaYMAA6/p7DPXxepsarjVlQ3C9tSR0rdlS3hiGfzG
 HYp/1NzcjZCDRV9H7hM3L23ZFFUr1Bb4llnBu86dYUIVfqkg42JEZtMRH3MCLlGQxD9cmsDz2lo
 ULpBGLJGLCWEKEvStDco7COesvKkW9z4HUiNvzXnVLn0rXneuw74pHNxsC9RPa7PIpCMPJxcoNx
 5pRhU4y3BwYEUrbOs=
X-Received: by 2002:a05:600c:5249:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-47d1954a128mr286194275e9.13.1766829030424; 
 Sat, 27 Dec 2025 01:50:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfT+dEfD1BQJYQ3tYfI/0Xzcu6dnupwv6HNXXKDxnluPDvdhyrO0GUBqAMBoMzUhtkbkP0BA==
X-Received: by 2002:a05:600c:5249:b0:456:1a69:94fa with SMTP id
 5b1f17b1804b1-47d1954a128mr286194065e9.13.1766829029986; 
 Sat, 27 Dec 2025 01:50:29 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d192e88f5sm428352625e9.0.2025.12.27.01.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:50:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 127/153] target/i386/tcg: unify more pop/no-pop x87 instructions
Date: Sat, 27 Dec 2025 10:47:32 +0100
Message-ID: <20251227094759.35658-53-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 54 ++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index cf5e2c158cb..bdaa436feac 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2831,46 +2831,62 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             }
             break;
         case 0x1d: /* fucomi */
+        case 0x3d: /* fucomip */
             if (!(s->cpuid_features & CPUID_CMOV)) {
                 goto illegal_op;
             }
             gen_update_cc_op(s);
             gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
             gen_helper_fucomi_ST0_FT0(tcg_env);
+            if (op >= 0x30) {
+                gen_helper_fpop(tcg_env);
+            }
             assume_cc_op(s, CC_OP_EFLAGS);
             break;
         case 0x1e: /* fcomi */
+        case 0x3e: /* fcomip */
             if (!(s->cpuid_features & CPUID_CMOV)) {
                 goto illegal_op;
             }
             gen_update_cc_op(s);
             gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
             gen_helper_fcomi_ST0_FT0(tcg_env);
+            if (op >= 0x30) {
+                gen_helper_fpop(tcg_env);
+            }
             assume_cc_op(s, CC_OP_EFLAGS);
             break;
         case 0x28: /* ffree sti */
+        case 0x38: /* ffreep sti, undocumented op */
             gen_helper_ffree_STN(tcg_env, tcg_constant_i32(opreg));
+            if (op >= 0x30) {
+                gen_helper_fpop(tcg_env);
+            }
             break;
         case 0x2a: /* fst sti */
-            gen_helper_fmov_STN_ST0(tcg_env, tcg_constant_i32(opreg));
-            break;
         case 0x2b: /* fstp sti */
         case 0x0b: /* fstp1 sti, undocumented op */
         case 0x3a: /* fstp8 sti, undocumented op */
         case 0x3b: /* fstp9 sti, undocumented op */
             gen_helper_fmov_STN_ST0(tcg_env, tcg_constant_i32(opreg));
-            gen_helper_fpop(tcg_env);
+            if (op != 0x2a) {
+                gen_helper_fpop(tcg_env);
+            }
             break;
         case 0x2c: /* fucom st(i) */
-            gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
-            gen_helper_fucom_ST0_FT0(tcg_env);
-            break;
         case 0x2d: /* fucomp st(i) */
             gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
             gen_helper_fucom_ST0_FT0(tcg_env);
-            gen_helper_fpop(tcg_env);
+            if (op == 0x2d) {
+                gen_helper_fpop(tcg_env);
+            }
             break;
         case 0x33: /* de/3 */
+	    /*
+	     * TODO: does 0x32 also have the same limitation of requiring
+	     * rm == 1?  If so, worth bundling it here and switch the fcom
+	     * helper to gen_helper_fp_arith_ST0_FT0(op & 7).
+	     */
             switch (rm) {
             case 1: /* fcompp */
                 gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(1));
@@ -2882,10 +2898,6 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
                 goto illegal_op;
             }
             break;
-        case 0x38: /* ffreep sti, undocumented op */
-            gen_helper_ffree_STN(tcg_env, tcg_constant_i32(opreg));
-            gen_helper_fpop(tcg_env);
-            break;
         case 0x3c: /* df/4 */
             switch (rm) {
             case 0:
@@ -2897,26 +2909,6 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
                 goto illegal_op;
             }
             break;
-        case 0x3d: /* fucomip */
-            if (!(s->cpuid_features & CPUID_CMOV)) {
-                goto illegal_op;
-            }
-            gen_update_cc_op(s);
-            gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
-            gen_helper_fucomi_ST0_FT0(tcg_env);
-            gen_helper_fpop(tcg_env);
-            assume_cc_op(s, CC_OP_EFLAGS);
-            break;
-        case 0x3e: /* fcomip */
-            if (!(s->cpuid_features & CPUID_CMOV)) {
-                goto illegal_op;
-            }
-            gen_update_cc_op(s);
-            gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
-            gen_helper_fcomi_ST0_FT0(tcg_env);
-            gen_helper_fpop(tcg_env);
-            assume_cc_op(s, CC_OP_EFLAGS);
-            break;
         case 0x10 ... 0x13: /* fcmovxx */
         case 0x18 ... 0x1b:
             {
-- 
2.52.0


