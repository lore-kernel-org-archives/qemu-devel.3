Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8706CE8FDD8
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQwe-0001OA-BJ; Sat, 27 Dec 2025 04:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwN-000126-4x
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQwH-0007LZ-Th
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766829021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GSAnya0ioVYFN8GbctSXaaX16HhFqXFP7TwvUwwLfLw=;
 b=EzIVMPCdqDDSAoFSkAlgxzzfbphkeNr1QOBeCvAcYZMvVQUWuFgVQSXfcCEWLQ0IwNUtqI
 wZo4rZ3/4UgXAG7SKFH6pmTRhhkFWZ7n0SE6PhUoEw3RNLTFQU7jhoDY7aYD8wqVRceio2
 5f8PQFRHz6hewPQdLuvHa+0bt97yZwg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-2B5RQh50OgKtDopyIUpmyA-1; Sat, 27 Dec 2025 04:50:19 -0500
X-MC-Unique: 2B5RQh50OgKtDopyIUpmyA-1
X-Mimecast-MFC-AGG-ID: 2B5RQh50OgKtDopyIUpmyA_1766829019
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fc83f58dso4353918f8f.2
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766829017; x=1767433817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GSAnya0ioVYFN8GbctSXaaX16HhFqXFP7TwvUwwLfLw=;
 b=D5R1P85VGALtJdQrqLqf0YnTaUnKVytOCurq/YMitWspC+xsRTb/tm9bNz4ooS/0hb
 Twmdx5Ffsfx38cvFC5n9qf7pf4H16XgpQmdz1hoh4+C+sbrhghBOIk2K2SEWxyFfPqGW
 Lagn+tz0AQJODgHshkR0oMqtto+B6NnpQPX7qlj3XImjdialgUi4owTn8idsZk02Y/Kf
 Ti9zdt+2W2/aMH47omMTLqCU4FbUxa6kFYqxGY0TfuLRxPY+ULXjFn2SM+2Pm9JOB98e
 w8TEp3EeEtGIZI2d/Qw3aeev/H3wJ9pxXGjl5fdYur6tDF4wknHx8ViledPZALsA9xGF
 k2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766829017; x=1767433817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GSAnya0ioVYFN8GbctSXaaX16HhFqXFP7TwvUwwLfLw=;
 b=mobsd3ew23A8gFQ+uRFAn16LkgfYCEOZC8oKpLq0jiqC7+4Nnw2+4hTNfUHf6PFh1K
 xUUYIccyMRadWHNoWAMzATy4Y9A8HjWM5qO3I+Z1Uamy9EzUU5P0CJaI+Oq4Qta48fbp
 sgrcWrWiM5n5lKrlwpt9/2/7mqLLDqXKbckENKeFMGAzYowZzrnW4DGxt8r9mI4vXHDX
 Xa9WGuAunZ0JMB5VYf4WMwV1WHp7o1Wc9yqY0CMhS8+9T3SP8Am8G7M3Iz3gASIoH/qg
 WU8NuiNVtQruEouQWeANb6zEWdVk/r400/zI32GYQAS6I+hZGeMfGUCdZdH8NpOjOL+j
 CLBQ==
X-Gm-Message-State: AOJu0YwICy8c+d5RrMASxMuhufWEcWQfNIdefp9oi+k5BcJUU2heVJ5t
 xCEOsKIwgLdjcrKbSDI0OeUMMah1nONlI/QZpCrM9QHyA74/PSZfurCHvlAhDCtxpwn3unE3JR1
 si7YYAVgJZwZ9EwcbhHHdUb04kY91tQxPN0fA+8fKN297VPJS3ZsTLHf2MjxsFVb2MVrK8PuLYo
 o3FB0eJB6e6ZFiFbZ8gOSpztuzMxdDKLFTGfwBUNxK
X-Gm-Gg: AY/fxX6R6PTIZigQX32pSHcQkrG0DFwG7aHVyWN5q1GwoQS5Fdca6TlGz2wIMxcWh9k
 9/6UMnG/ciGiWuEr6Jf4kAmJIkd5D/JuRbE2AUHNz2l2lgO3XDUUHImiN1Ibc6G0olACQk+iT3e
 0vZSdO5h2BAojPteeZjFzDkBWb95zR/yQA6I/0/mUvXwdMUGhrZ3RwCj6VS48+PKCb46o807xBi
 5JoRFKcZvz57XjqD+mEFqQDGfstfOJROX/bRYz6xSpGRy6XnSNyYXs4IEsxQz1Sktsl2qO+Sh8E
 ILNZmNsMgdcMbFfGALJZRpzfyB/nFd5cNN8+EoDWPWztIkSplSV7NBRUp+trCS82tAs6XgBtzN+
 doa+k8cagZr2o2qZn4+kBct4p1iJ8ZpalBHsC+AZl1vFTH1JBG8KINVxBOxDeLPXbGw03vwRx+0
 2MKd4ljFPHnEjFzDQ=
X-Received: by 2002:a05:6000:22c4:b0:431:a50:6e9e with SMTP id
 ffacd0b85a97d-4324e4f926emr34551179f8f.38.1766829017431; 
 Sat, 27 Dec 2025 01:50:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IED/HsaTs/ujt1wyBH+IT2rjRVdAxMAP9NnKkuoNrQ2cmhch8zZQQqqe7hERJIr7Ng+0s7I5A==
X-Received: by 2002:a05:6000:22c4:b0:431:a50:6e9e with SMTP id
 ffacd0b85a97d-4324e4f926emr34551155f8f.38.1766829016949; 
 Sat, 27 Dec 2025 01:50:16 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea226d1sm50836418f8f.13.2025.12.27.01.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:50:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 123/153] target/i386/tcg: unnest switch statements in
 disas_insn_x87
Date: Sat, 27 Dec 2025 10:47:28 +0100
Message-ID: <20251227094759.35658-49-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 290 +++++++++++++++++-------------------
 1 file changed, 134 insertions(+), 156 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 20cc49a9742..68f41b37423 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2457,36 +2457,32 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
 
         switch (op) {
         case 0x00 ... 0x07: /* fxxxs */
-        case 0x10 ... 0x17: /* fixxxl */
-        case 0x20 ... 0x27: /* fxxxl */
-        case 0x30 ... 0x37: /* fixxx */
-            {
-                int op1;
-                op1 = op & 7;
+            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUL);
+            gen_helper_flds_FT0(tcg_env, s->tmp2_i32);
+            goto fp_arith_ST0_FT0;
 
-                switch (op >> 4) {
-                case 0:
-                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUL);
-                    gen_helper_flds_FT0(tcg_env, s->tmp2_i32);
-                    break;
-                case 1:
-                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUL);
-                    gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
-                    break;
-                case 2:
-                    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
-                                        s->mem_index, MO_LEUQ);
-                    gen_helper_fldl_FT0(tcg_env, s->tmp1_i64);
-                    break;
-                case 3:
-                default:
-                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LESW);
-                    gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
-                    break;
-                }
+        case 0x10 ... 0x17: /* fixxxl */
+            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUL);
+            gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
+            goto fp_arith_ST0_FT0;
+
+        case 0x20 ... 0x27: /* fxxxl */
+            tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
+                                s->mem_index, MO_LEUQ);
+            gen_helper_fldl_FT0(tcg_env, s->tmp1_i64);
+            goto fp_arith_ST0_FT0;
+
+        case 0x30 ... 0x37: /* fixxx */
+            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LESW);
+            gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
+            goto fp_arith_ST0_FT0;
+
+fp_arith_ST0_FT0:
+            {
+                int op1 = op & 7;
 
                 gen_helper_fp_arith_ST0_FT0(op1);
                 if (op1 == 3) {
@@ -2495,88 +2491,78 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
                 }
             }
             break;
+
         case 0x08: /* flds */
-        case 0x0a: /* fsts */
-        case 0x0b: /* fstps */
-        case 0x18 ... 0x1b: /* fildl, fisttpl, fistl, fistpl */
-        case 0x28 ... 0x2b: /* fldl, fisttpll, fstl, fstpl */
-        case 0x38 ... 0x3b: /* filds, fisttps, fists, fistps */
-            switch (op & 7) {
-            case 0:
-                switch (op >> 4) {
-                case 0:
-                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUL);
-                    gen_helper_flds_ST0(tcg_env, s->tmp2_i32);
-                    break;
-                case 1:
-                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUL);
-                    gen_helper_fildl_ST0(tcg_env, s->tmp2_i32);
-                    break;
-                case 2:
-                    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
-                                        s->mem_index, MO_LEUQ);
-                    gen_helper_fldl_ST0(tcg_env, s->tmp1_i64);
-                    break;
-                case 3:
-                default:
-                    tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LESW);
-                    gen_helper_fildl_ST0(tcg_env, s->tmp2_i32);
-                    break;
-                }
-                break;
-            case 1:
-                /* XXX: the corresponding CPUID bit must be tested ! */
-                switch (op >> 4) {
-                case 1:
-                    gen_helper_fisttl_ST0(s->tmp2_i32, tcg_env);
-                    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUL);
-                    break;
-                case 2:
-                    gen_helper_fisttll_ST0(s->tmp1_i64, tcg_env);
-                    tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
-                                        s->mem_index, MO_LEUQ);
-                    break;
-                case 3:
-                default:
-                    gen_helper_fistt_ST0(s->tmp2_i32, tcg_env);
-                    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUW);
-                    break;
-                }
+            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUL);
+            gen_helper_flds_ST0(tcg_env, s->tmp2_i32);
+            break;
+        case 0x18: /* fildl */
+            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUL);
+            gen_helper_fildl_ST0(tcg_env, s->tmp2_i32);
+            break;
+        case 0x28: /* fldl */
+            tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
+                                s->mem_index, MO_LEUQ);
+            gen_helper_fldl_ST0(tcg_env, s->tmp1_i64);
+            break;
+        case 0x38: /* filds */
+            tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LESW);
+            gen_helper_fildl_ST0(tcg_env, s->tmp2_i32);
+            break;
+
+        case 0x19: /* fisttpl */
+            gen_helper_fisttl_ST0(s->tmp2_i32, tcg_env);
+            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUL);
+            gen_helper_fpop(tcg_env);
+            break;
+        case 0x29: /* fisttpll */
+            gen_helper_fisttll_ST0(s->tmp1_i64, tcg_env);
+            tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
+                                s->mem_index, MO_LEUQ);
+            gen_helper_fpop(tcg_env);
+            break;
+        case 0x39: /* fisttps */
+            gen_helper_fistt_ST0(s->tmp2_i32, tcg_env);
+            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUW);
+            gen_helper_fpop(tcg_env);
+            break;
+
+        case 0x0a: case 0x0b: /* fsts, fstps */
+            gen_helper_fsts_ST0(s->tmp2_i32, tcg_env);
+            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUL);
+            if ((op & 7) == 3) {
+                gen_helper_fpop(tcg_env);
+            }
+            break;
+        case 0x1a: case 0x1b: /* fistl, fistpl */
+            gen_helper_fistl_ST0(s->tmp2_i32, tcg_env);
+            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUL);
+            if ((op & 7) == 3) {
+                gen_helper_fpop(tcg_env);
+            }
+            break;
+        case 0x2a: case 0x2b: /* fstl, fstpl */
+            gen_helper_fstl_ST0(s->tmp1_i64, tcg_env);
+            tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
+                                s->mem_index, MO_LEUQ);
+            if ((op & 7) == 3) {
+                gen_helper_fpop(tcg_env);
+            }
+            break;
+
+        case 0x3a: case 0x3b: /* fists, fistps */
+            gen_helper_fist_ST0(s->tmp2_i32, tcg_env);
+            tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
+                                s->mem_index, MO_LEUW);
+            if ((op & 7) == 3) {
                 gen_helper_fpop(tcg_env);
-                break;
-            default:
-                switch (op >> 4) {
-                case 0:
-                    gen_helper_fsts_ST0(s->tmp2_i32, tcg_env);
-                    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUL);
-                    break;
-                case 1:
-                    gen_helper_fistl_ST0(s->tmp2_i32, tcg_env);
-                    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUL);
-                    break;
-                case 2:
-                    gen_helper_fstl_ST0(s->tmp1_i64, tcg_env);
-                    tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
-                                        s->mem_index, MO_LEUQ);
-                    break;
-                case 3:
-                default:
-                    gen_helper_fist_ST0(s->tmp2_i32, tcg_env);
-                    tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
-                                        s->mem_index, MO_LEUW);
-                    break;
-                }
-                if ((op & 7) == 3) {
-                    gen_helper_fpop(tcg_env);
-                }
-                break;
             }
             break;
         case 0x0c: /* fldenv mem */
@@ -2707,39 +2693,37 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             }
             break;
         case 0x0d: /* grp d9/5 */
-            {
-                switch (rm) {
-                case 0:
-                    gen_helper_fpush(tcg_env);
-                    gen_helper_fld1_ST0(tcg_env);
-                    break;
-                case 1:
-                    gen_helper_fpush(tcg_env);
-                    gen_helper_fldl2t_ST0(tcg_env);
-                    break;
-                case 2:
-                    gen_helper_fpush(tcg_env);
-                    gen_helper_fldl2e_ST0(tcg_env);
-                    break;
-                case 3:
-                    gen_helper_fpush(tcg_env);
-                    gen_helper_fldpi_ST0(tcg_env);
-                    break;
-                case 4:
-                    gen_helper_fpush(tcg_env);
-                    gen_helper_fldlg2_ST0(tcg_env);
-                    break;
-                case 5:
-                    gen_helper_fpush(tcg_env);
-                    gen_helper_fldln2_ST0(tcg_env);
-                    break;
-                case 6:
-                    gen_helper_fpush(tcg_env);
-                    gen_helper_fldz_ST0(tcg_env);
-                    break;
-                default:
-                    goto illegal_op;
-                }
+            switch (rm) {
+            case 0:
+                gen_helper_fpush(tcg_env);
+                gen_helper_fld1_ST0(tcg_env);
+                break;
+            case 1:
+                gen_helper_fpush(tcg_env);
+                gen_helper_fldl2t_ST0(tcg_env);
+                break;
+            case 2:
+                gen_helper_fpush(tcg_env);
+                gen_helper_fldl2e_ST0(tcg_env);
+                break;
+            case 3:
+                gen_helper_fpush(tcg_env);
+                gen_helper_fldpi_ST0(tcg_env);
+                break;
+            case 4:
+                gen_helper_fpush(tcg_env);
+                gen_helper_fldlg2_ST0(tcg_env);
+                break;
+            case 5:
+                gen_helper_fpush(tcg_env);
+                gen_helper_fldln2_ST0(tcg_env);
+                break;
+            case 6:
+                gen_helper_fpush(tcg_env);
+                gen_helper_fldz_ST0(tcg_env);
+                break;
+            default:
+                goto illegal_op;
             }
             break;
         case 0x0e: /* grp d9/6 */
@@ -2801,22 +2785,16 @@ static void gen_x87(DisasContext *s, X86DecodedInsn *decode)
             }
             break;
         case 0x00: case 0x01: case 0x04 ... 0x07: /* fxxx st, sti */
+            gen_helper_fmov_FT0_STN(tcg_env,
+                                    tcg_constant_i32(opreg));
+            gen_helper_fp_arith_ST0_FT0(op & 7);
+            break;
+
         case 0x20: case 0x21: case 0x24 ... 0x27: /* fxxx sti, st */
         case 0x30: case 0x31: case 0x34 ... 0x37: /* fxxxp sti, st */
-            {
-                int op1;
-
-                op1 = op & 7;
-                if (op >= 0x20) {
-                    gen_helper_fp_arith_STN_ST0(op1, opreg);
-                    if (op >= 0x30) {
-                        gen_helper_fpop(tcg_env);
-                    }
-                } else {
-                    gen_helper_fmov_FT0_STN(tcg_env,
-                                            tcg_constant_i32(opreg));
-                    gen_helper_fp_arith_ST0_FT0(op1);
-                }
+            gen_helper_fp_arith_STN_ST0(op & 7, opreg);
+            if (op >= 0x30) {
+                gen_helper_fpop(tcg_env);
             }
             break;
         case 0x02: /* fcom */
-- 
2.52.0


