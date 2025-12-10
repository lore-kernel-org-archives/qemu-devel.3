Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F90DD3C545
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK4o-00050U-Ry; Wed, 10 Dec 2025 08:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4M-0004rL-5V
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK4K-0003FI-IJ
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GKpMCAlv7ID015Tk0OkNs/f5DVZhlc+TdWNSgkE0ov8=;
 b=K7v59Z5tpmc+KnFfTLABde1JI9bcEvhWaq1VTgumFo+TjTcIZqfMUZ3seGLZ6RvIUK13ld
 sarYapnCe6MMy/9pFhNCGasSdKmHrFghKgpIjHIREJ6YPdLohaIWG3CQXMium87Zg2ZBPt
 7ATphO/i0XRpD5ff16UfKTb5b/DdyIg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259--O7sZKktP3S9dMEdfgYkpg-1; Wed, 10 Dec 2025 08:17:20 -0500
X-MC-Unique: -O7sZKktP3S9dMEdfgYkpg-1
X-Mimecast-MFC-AGG-ID: -O7sZKktP3S9dMEdfgYkpg_1765372639
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b3155274eso3345353f8f.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372639; x=1765977439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GKpMCAlv7ID015Tk0OkNs/f5DVZhlc+TdWNSgkE0ov8=;
 b=Mz5vt3moEAi9eNK1371zyTxl3O3yHpuF35wFcc5L2mmDaAiQp+8vWKTai2E+FAPdbD
 enkNxSKyqIJCWx5g6AJNUK7QLzfl65zuvnkkeOVdBkx7cvt83qds8zRgxwR+WQ4+0gmE
 wd+aOTS4tMHpYvOA3Z4xR5p0Ytsk3gOIjQ9HfkmkXxGbel2Hy5FtzP2QB5UDpYokVd/B
 7kVtOrWch27YX9u1zqr0q6aziDXP++dvYaMoQ4RlQwqzx/hhn7GbGVkFQIKHbvtmdYSg
 0Y/4UnqmXPJ0oObitt1AtLNiMgOFJ7h/7yT9JsuNgzyhbBwlCkl31np6tI1TplGuWeF5
 99LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372639; x=1765977439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GKpMCAlv7ID015Tk0OkNs/f5DVZhlc+TdWNSgkE0ov8=;
 b=m2jMp2UGQN6Ux0braACo6rl+xoQBDGbtdqhIdV0TxKkoHrzx2uyBolO0OQddVoJn+1
 Be/odYTIxb7UhR3RQpTIW/fjXH3NxLBpcqyQQI6GlpHvjDPgmKSt7ohvMEMBlYXoRQvs
 bjDhKUrqk64ZTYNXMa8GHUDCu9Dw4It09m5hw/7CL63uP1GEkKuef3bsmdnC6U29sdKM
 4qNnSlfaUEcYd+hzUxkXjnYGIiaY7bf+ARvE16X4z88sisu7UlQPNDiroEGyRaHbrLKk
 dj/YqZs10z1utZkzF5b2Sb8sUllWWquj1V6MNlNwK6IdKwoB70rpbACXWEVN6r7bSrmp
 geHA==
X-Gm-Message-State: AOJu0YyNx4TiCVMS9ZKMcLn6NDiDAyY0hkF/QXOmcrInobL8fr6Qqmoo
 wAh/0ozQFm/X5qvOkNVrtXunT5pQ9u6KPQYXQJY86QwIBEVCzXkLwrL5R3hVLSOa84DShRtRam2
 MGAK/Fy5Qe48KDbXBEfFTHqhGKnNQRUrDNODtvLQCXUGojm7/NSKbjcfQhU5mS40lnWiiEN4oad
 GTrZpsTCtTNqwvro5opJbeLM/hghhRBKU37pGWWiJ3
X-Gm-Gg: AY/fxX6f0XyU4X0c/vp8E4Ft3NE9iNBkqtA5S8wGlL6y+3AyMpxuIt6XDAJOaY1Q7I0
 QrlR//HGCG1Um2rWXe4SJ1FZyqRDRKy03F8khyVrOyOqrwrThMRXgSYpKjR/lcSk8Kt+F8NdOZf
 +9BE4uK/Mdgco9irQwS2Xd/Fk0Y3CusmaTfMDY2x+G4hTJ5bgDOyUgDLf2TUebai0Mqsy3umVn+
 h86GnAfEdJXu0JDQv3NmxP/T3MNVhPJ2PJt1RHh9Juj7sn1b8ETmjX2UlABSkXWxkoEdFD9J9ng
 ENOn8sOOFQDEoFm1fsWUkYbKH6Sk2pUI1OGxz8YasEKTtL9bUrIMR884QaN/hVvuW/p+bROTgPU
 GxfV42i0cawbcG/6Cn0aRTn21ONrFG03PS67c88L/k8n8P/0gx0OGzLJQO5+jrQ4lN0p7aLC537
 z6Cg7Ly9ROlVDr9Pk=
X-Received: by 2002:a5d:5f50:0:b0:427:6a3:e72f with SMTP id
 ffacd0b85a97d-42fa3af8c1dmr2179919f8f.34.1765372638435; 
 Wed, 10 Dec 2025 05:17:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHlc21DmntPpgnCrl9kK9EEN0pm0mlwEzOvSAgvcrmC/asDS98u2A3oklU0bM6n84QIjFRKQ==
X-Received: by 2002:a5d:5f50:0:b0:427:6a3:e72f with SMTP id
 ffacd0b85a97d-42fa3af8c1dmr2179890f8f.34.1765372637854; 
 Wed, 10 Dec 2025 05:17:17 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331df0sm39033279f8f.36.2025.12.10.05.17.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:17:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/18] target/i386/tcg: unify more pop/no-pop x87 instructions
Date: Wed, 10 Dec 2025 14:16:48 +0100
Message-ID: <20251210131653.852163-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210131653.852163-1-pbonzini@redhat.com>
References: <20251210131653.852163-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 49 ++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index f47bb5de8b3..8cd70456a51 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2828,44 +2828,55 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
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
             switch (rm) {
@@ -2879,10 +2890,6 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
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
@@ -2894,26 +2901,6 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
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


