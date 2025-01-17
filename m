Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9EAC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5d-0004vb-Mx; Fri, 17 Jan 2025 13:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5V-0004NF-RE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:28:58 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5T-0000B4-KY
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:28:57 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ef714374c0so4069381a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138534; x=1737743334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfUBmqSQZyEtq+ZG7rFoErR6iukoMwH0uv4JfPR/g4E=;
 b=J4NQ9/48v6NCgYO/l1tp6Pq1S56bCCIhN83LE3haXGCNZtUyYf/NbN5tYXOEjowS+Y
 SAlhvhjLJ/1PlqtDTwOKlsVYPVuqriahfyWbh5gfKYJQ10yJ+8c/p8i5CBvmm3ktD7T7
 3mRPX+JY8MQppc7bQl2KXzH1MdJ77IgG02Nb/mkaE7F1Z4DXvE8T1dgHVLR1MU7JBnAD
 BLL1OyNeXdfvc3b6GUcWYdOCHx79plsNPFAPb9xWbcAfyVAKcJEhjLNQvUBvXRmq2PLP
 wrZDvSZTUyg4AFo15e0KEcacuaU0kjI65qb6z2rtLgz1snsuUOH/yPUqb2Ga/k0j5H2G
 ui4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138534; x=1737743334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZfUBmqSQZyEtq+ZG7rFoErR6iukoMwH0uv4JfPR/g4E=;
 b=rteFx3JgWdF2rCGLQMbQG4DGCuaVcmIkmvC+TKmCspR9WYHA/dzQSyiJqItivD/RC1
 2bN+lPDzGCPnj8I2jlILo3TQQIlkwHKI9bvJYB92f8Pj6oqw0Ay4xi4L+jDpLRvwuSal
 xvMdQk0dUyDKwpivzLeVjaF9DRJRpzDsLJVAt/0nALWZv+d9qQu8M4oKbOK9GP3bjDOR
 3+I0XQhzM+Vy83Ka/6w8mmWU5KhiYlFeRvSjsQSB3QSmqwOlf1xPVjU7GawmT8LRXux8
 dY+uS9aqbTa9Z7gcUMCnRu9iUPQZsxUtiOtnSTKkLLVshRsq6ryPeXLeBuU19QoSccMW
 zu+Q==
X-Gm-Message-State: AOJu0Yyaho5uxxqJvyXO92fDbl3u2Dfwq0wfIIfdEaQn09if7sXfPeyi
 Mp5fCk9SbziiwqoUBJa20779/tknTdfJ6qPz3JUUJAENolqpxByQnhxu+RtQYdsg86iOuh3BR+q
 Q
X-Gm-Gg: ASbGncty0my97G2yoQDjQ12xWDZRH6OVoINf67X3i0mYDkJ/RO+l2cy8umGLnmnrAEp
 bFrzOzU9eG2BXuf/9sdy4/+KdpAFF8a/Mgrf5B5wLUUuGxkINaf1urpNinlKxwyeSft7reSYAF/
 yn5fylwCUW+0jOA7eNDm2c1Vd1Wwz0zfRp6LPObf0ZKogofXqFQERjbYlgXMy1AAhL/eRl6oeN4
 7vchZnjUzKp0L79D0InEKzUq7hT3ZAP4AmAVDRUOHRusemoPFT2myA8jTba/zSIBc76/TQ0HVD0
 SiCuXS4/ID+LRg0=
X-Google-Smtp-Source: AGHT+IHTN7DnjteTggJs3TtSApxvJFGTGMqwXQpYsm6iJqTI+7ypor9bcHflFsicY5sQs93SBeGlBw==
X-Received: by 2002:a17:90b:3eca:b0:2ee:8253:9a9f with SMTP id
 98e67ed59e1d1-2f728e48411mr18662547a91.11.1737138533963; 
 Fri, 17 Jan 2025 10:28:53 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:28:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 45/68] tcg: Replace IMPLVEC with TCG_OPF_VECTOR
Date: Fri, 17 Jan 2025 10:24:33 -0800
Message-ID: <20250117182456.2077110-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

This is now a direct replacement.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h            | 89 +++++++++++++++-----------------
 tcg/aarch64/tcg-target-opc.h.inc |  4 +-
 tcg/arm/tcg-target-opc.h.inc     |  6 +--
 tcg/i386/tcg-target-opc.h.inc    | 22 ++++----
 tcg/ppc/tcg-target-opc.h.inc     | 12 ++---
 tcg/s390x/tcg-target-opc.h.inc   |  6 +--
 6 files changed, 68 insertions(+), 71 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 559f5971e6..9383e295f4 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -221,66 +221,63 @@ DEF(qemu_st_a64_i128, 0, 3, 1, TCG_OPF_CALL_CLOBBER | TCG_OPF_SIDE_EFFECTS)
 
 /* Host vector support.  */
 
-#define IMPLVEC  TCG_OPF_VECTOR
-
 DEF(mov_vec, 1, 1, 0, TCG_OPF_VECTOR | TCG_OPF_NOT_PRESENT)
 
-DEF(dup_vec, 1, 1, 0, IMPLVEC)
-DEF(dup2_vec, 1, 2, 0, IMPLVEC)
+DEF(dup_vec, 1, 1, 0, TCG_OPF_VECTOR)
+DEF(dup2_vec, 1, 2, 0, TCG_OPF_VECTOR)
 
-DEF(ld_vec, 1, 1, 1, IMPLVEC)
-DEF(st_vec, 0, 2, 1, IMPLVEC)
-DEF(dupm_vec, 1, 1, 1, IMPLVEC)
+DEF(ld_vec, 1, 1, 1, TCG_OPF_VECTOR)
+DEF(st_vec, 0, 2, 1, TCG_OPF_VECTOR)
+DEF(dupm_vec, 1, 1, 1, TCG_OPF_VECTOR)
 
-DEF(add_vec, 1, 2, 0, IMPLVEC)
-DEF(sub_vec, 1, 2, 0, IMPLVEC)
-DEF(mul_vec, 1, 2, 0, IMPLVEC)
-DEF(neg_vec, 1, 1, 0, IMPLVEC)
-DEF(abs_vec, 1, 1, 0, IMPLVEC)
-DEF(ssadd_vec, 1, 2, 0, IMPLVEC)
-DEF(usadd_vec, 1, 2, 0, IMPLVEC)
-DEF(sssub_vec, 1, 2, 0, IMPLVEC)
-DEF(ussub_vec, 1, 2, 0, IMPLVEC)
-DEF(smin_vec, 1, 2, 0, IMPLVEC)
-DEF(umin_vec, 1, 2, 0, IMPLVEC)
-DEF(smax_vec, 1, 2, 0, IMPLVEC)
-DEF(umax_vec, 1, 2, 0, IMPLVEC)
+DEF(add_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(sub_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(mul_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(neg_vec, 1, 1, 0, TCG_OPF_VECTOR)
+DEF(abs_vec, 1, 1, 0, TCG_OPF_VECTOR)
+DEF(ssadd_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(usadd_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(sssub_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(ussub_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(smin_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(umin_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(smax_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(umax_vec, 1, 2, 0, TCG_OPF_VECTOR)
 
-DEF(and_vec, 1, 2, 0, IMPLVEC)
-DEF(or_vec, 1, 2, 0, IMPLVEC)
-DEF(xor_vec, 1, 2, 0, IMPLVEC)
-DEF(andc_vec, 1, 2, 0, IMPLVEC)
-DEF(orc_vec, 1, 2, 0, IMPLVEC)
-DEF(nand_vec, 1, 2, 0, IMPLVEC)
-DEF(nor_vec, 1, 2, 0, IMPLVEC)
-DEF(eqv_vec, 1, 2, 0, IMPLVEC)
-DEF(not_vec, 1, 1, 0, IMPLVEC)
+DEF(and_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(or_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(xor_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(andc_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(orc_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(nand_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(nor_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(eqv_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(not_vec, 1, 1, 0, TCG_OPF_VECTOR)
 
-DEF(shli_vec, 1, 1, 1, IMPLVEC)
-DEF(shri_vec, 1, 1, 1, IMPLVEC)
-DEF(sari_vec, 1, 1, 1, IMPLVEC)
-DEF(rotli_vec, 1, 1, 1, IMPLVEC)
+DEF(shli_vec, 1, 1, 1, TCG_OPF_VECTOR)
+DEF(shri_vec, 1, 1, 1, TCG_OPF_VECTOR)
+DEF(sari_vec, 1, 1, 1, TCG_OPF_VECTOR)
+DEF(rotli_vec, 1, 1, 1, TCG_OPF_VECTOR)
 
-DEF(shls_vec, 1, 2, 0, IMPLVEC)
-DEF(shrs_vec, 1, 2, 0, IMPLVEC)
-DEF(sars_vec, 1, 2, 0, IMPLVEC)
-DEF(rotls_vec, 1, 2, 0, IMPLVEC)
+DEF(shls_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(shrs_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(sars_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(rotls_vec, 1, 2, 0, TCG_OPF_VECTOR)
 
-DEF(shlv_vec, 1, 2, 0, IMPLVEC)
-DEF(shrv_vec, 1, 2, 0, IMPLVEC)
-DEF(sarv_vec, 1, 2, 0, IMPLVEC)
-DEF(rotlv_vec, 1, 2, 0, IMPLVEC)
-DEF(rotrv_vec, 1, 2, 0, IMPLVEC)
+DEF(shlv_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(shrv_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(sarv_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(rotlv_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(rotrv_vec, 1, 2, 0, TCG_OPF_VECTOR)
 
-DEF(cmp_vec, 1, 2, 1, IMPLVEC)
+DEF(cmp_vec, 1, 2, 1, TCG_OPF_VECTOR)
 
-DEF(bitsel_vec, 1, 3, 0, IMPLVEC)
-DEF(cmpsel_vec, 1, 4, 1, IMPLVEC)
+DEF(bitsel_vec, 1, 3, 0, TCG_OPF_VECTOR)
+DEF(cmpsel_vec, 1, 4, 1, TCG_OPF_VECTOR)
 
 DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 #include "tcg-target-opc.h.inc"
 
 #undef DATA64_ARGS
-#undef IMPLVEC
 #undef DEF
diff --git a/tcg/aarch64/tcg-target-opc.h.inc b/tcg/aarch64/tcg-target-opc.h.inc
index bce30accd9..5382315c41 100644
--- a/tcg/aarch64/tcg-target-opc.h.inc
+++ b/tcg/aarch64/tcg-target-opc.h.inc
@@ -11,5 +11,5 @@
  * consider these to be UNSPEC with names.
  */
 
-DEF(aa64_sshl_vec, 1, 2, 0, IMPLVEC)
-DEF(aa64_sli_vec, 1, 2, 1, IMPLVEC)
+DEF(aa64_sshl_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(aa64_sli_vec, 1, 2, 1, TCG_OPF_VECTOR)
diff --git a/tcg/arm/tcg-target-opc.h.inc b/tcg/arm/tcg-target-opc.h.inc
index d38af9a808..70394e0282 100644
--- a/tcg/arm/tcg-target-opc.h.inc
+++ b/tcg/arm/tcg-target-opc.h.inc
@@ -11,6 +11,6 @@
  * consider these to be UNSPEC with names.
  */
 
-DEF(arm_sli_vec, 1, 2, 1, IMPLVEC)
-DEF(arm_sshl_vec, 1, 2, 0, IMPLVEC)
-DEF(arm_ushl_vec, 1, 2, 0, IMPLVEC)
+DEF(arm_sli_vec, 1, 2, 1, TCG_OPF_VECTOR)
+DEF(arm_sshl_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(arm_ushl_vec, 1, 2, 0, TCG_OPF_VECTOR)
diff --git a/tcg/i386/tcg-target-opc.h.inc b/tcg/i386/tcg-target-opc.h.inc
index 4ffc084bda..8cc0dbaeaf 100644
--- a/tcg/i386/tcg-target-opc.h.inc
+++ b/tcg/i386/tcg-target-opc.h.inc
@@ -24,14 +24,14 @@
  * consider these to be UNSPEC with names.
  */
 
-DEF(x86_shufps_vec, 1, 2, 1, IMPLVEC)
-DEF(x86_blend_vec, 1, 2, 1, IMPLVEC)
-DEF(x86_packss_vec, 1, 2, 0, IMPLVEC)
-DEF(x86_packus_vec, 1, 2, 0, IMPLVEC)
-DEF(x86_psrldq_vec, 1, 1, 1, IMPLVEC)
-DEF(x86_vperm2i128_vec, 1, 2, 1, IMPLVEC)
-DEF(x86_punpckl_vec, 1, 2, 0, IMPLVEC)
-DEF(x86_punpckh_vec, 1, 2, 0, IMPLVEC)
-DEF(x86_vpshldi_vec, 1, 2, 1, IMPLVEC)
-DEF(x86_vpshldv_vec, 1, 3, 0, IMPLVEC)
-DEF(x86_vpshrdv_vec, 1, 3, 0, IMPLVEC)
+DEF(x86_shufps_vec, 1, 2, 1, TCG_OPF_VECTOR)
+DEF(x86_blend_vec, 1, 2, 1, TCG_OPF_VECTOR)
+DEF(x86_packss_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(x86_packus_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(x86_psrldq_vec, 1, 1, 1, TCG_OPF_VECTOR)
+DEF(x86_vperm2i128_vec, 1, 2, 1, TCG_OPF_VECTOR)
+DEF(x86_punpckl_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(x86_punpckh_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(x86_vpshldi_vec, 1, 2, 1, TCG_OPF_VECTOR)
+DEF(x86_vpshldv_vec, 1, 3, 0, TCG_OPF_VECTOR)
+DEF(x86_vpshrdv_vec, 1, 3, 0, TCG_OPF_VECTOR)
diff --git a/tcg/ppc/tcg-target-opc.h.inc b/tcg/ppc/tcg-target-opc.h.inc
index db514403c3..c3635831b5 100644
--- a/tcg/ppc/tcg-target-opc.h.inc
+++ b/tcg/ppc/tcg-target-opc.h.inc
@@ -24,9 +24,9 @@
  * consider these to be UNSPEC with names.
  */
 
-DEF(ppc_mrgh_vec, 1, 2, 0, IMPLVEC)
-DEF(ppc_mrgl_vec, 1, 2, 0, IMPLVEC)
-DEF(ppc_msum_vec, 1, 3, 0, IMPLVEC)
-DEF(ppc_muleu_vec, 1, 2, 0, IMPLVEC)
-DEF(ppc_mulou_vec, 1, 2, 0, IMPLVEC)
-DEF(ppc_pkum_vec, 1, 2, 0, IMPLVEC)
+DEF(ppc_mrgh_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(ppc_mrgl_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(ppc_msum_vec, 1, 3, 0, TCG_OPF_VECTOR)
+DEF(ppc_muleu_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(ppc_mulou_vec, 1, 2, 0, TCG_OPF_VECTOR)
+DEF(ppc_pkum_vec, 1, 2, 0, TCG_OPF_VECTOR)
diff --git a/tcg/s390x/tcg-target-opc.h.inc b/tcg/s390x/tcg-target-opc.h.inc
index 0eb2350fb3..61237b39cd 100644
--- a/tcg/s390x/tcg-target-opc.h.inc
+++ b/tcg/s390x/tcg-target-opc.h.inc
@@ -10,6 +10,6 @@
  * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
  * consider these to be UNSPEC with names.
  */
-DEF(s390_vuph_vec, 1, 1, 0, IMPLVEC)
-DEF(s390_vupl_vec, 1, 1, 0, IMPLVEC)
-DEF(s390_vpks_vec, 1, 2, 0, IMPLVEC)
+DEF(s390_vuph_vec, 1, 1, 0, TCG_OPF_VECTOR)
+DEF(s390_vupl_vec, 1, 1, 0, TCG_OPF_VECTOR)
+DEF(s390_vpks_vec, 1, 2, 0, TCG_OPF_VECTOR)
-- 
2.43.0


