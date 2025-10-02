Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70012CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 09:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4FMc-0005sa-2o; Thu, 02 Oct 2025 05:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FMW-0005qZ-1i
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:12:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FM4-0002UU-JL
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:12:30 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e6674caa5so3856015e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 02:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759396318; x=1760001118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4azV78+9CNI4V89E8d/C+jzBa7BKVVr8xnNQua3VFg8=;
 b=EQKbfcottRzadCBehHUZxmjjmQXlLzYaCEkTnrfUsRsg34pntAtlAt1tS2OYHeA2d0
 eOV5BroZa4vDRPAn5XHbkp67MHauMNt01JD+tCOI+EliocFVVpL9yVbWtZKQkvt+HyWl
 UaxX3okxxC6f0jQRNLPJYG2teAvu61q1Djpqf/Vn93mFZpQ0xi0MH3HLAy4hggxHyKbh
 4TN4WIqdljRZqNeQjy7RRkYr2JVMdhUN/gOajNxEvrQcmeVqQEZs+Sf9MEN92Q0USt4+
 q92wpv54fhBCuchn5sUpJMVu2PhDNfx0MmMgKlLmfPiLMJi1+QB2C3cQvhy8jO50KZGU
 g9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759396318; x=1760001118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4azV78+9CNI4V89E8d/C+jzBa7BKVVr8xnNQua3VFg8=;
 b=kDbo6LmJx0aeOZdZo01FaWMYWg5X0oJPmry6mzDdol62dYqJC8oEffX0ox70hernvd
 i7eUq0HhTaO3ML3rs7UmrFjZgCbsEu17SVhGzeGOrlsGw08M2d5MeO3o3OB2KrE3oIWO
 0lRB2Idvxq+Beeb+sWRbjGl+vO2C+acnj6k9hmwY5r2QBzqwIT3Nj9ibWnDJZLQQeOca
 2hcv3X02ZvUmMzoYA0xdYCJzEXZI5yLr9enUyeEm3AfCCIc/JeAH/VVD+QSKTUroIrxP
 632UKQ3u88uaAYWya6bv8kUHRmVohDIiXyO37TohWp7GnmzvOMP64hP54TRhU0nGJ4lb
 9Z6w==
X-Gm-Message-State: AOJu0YyVknlrpinNe9W0H3gzn0znGAF/EjbPN9QSgqt4Oa5+/eOlofG9
 RW4qORZYSQTBkq/GSnvsg178fOL91bqt4ohH3rwzAyypg2eMOnZ5TEeCmAQSlnm6x/QtsXK5Fy+
 xehTvP0bW5Q==
X-Gm-Gg: ASbGncsvvm0PfCQL606HDUCG41rDcC5xmHaUFDnSeGOareiwc/BD74Fyg+bl7J/lCLd
 Z0shYjsfSX0CJ5/zZ7H6GjOzGA6xxZleXKpDgzgBBnGAaQh1n03jqSoAu2XsMgRp7qcSM6FE4sO
 hN/UIxmXPvXdrN+Kb8ESmMkuuNdtmPjzDDWS8qrqnSCzmegjkY3QxcTq27I1FIHOlE3T3bYHD/W
 EcwXVMF60+IWHJfnvlMj64S/sEF7ufidPfs4jlUawrrx63mK8RRxEbuv8cf01sYUSQPD0ZKhO8H
 EVfmtN89xRnsJnLrudbxsAiO14Cc3xKKupYeayqaX25RLKCyAMTMVu0H5ipGQ9Fm5472PXPFVXA
 OOBsLUhFB60b3O/RwsFZOr6jk7z24oNTEC29kTmpOdefhzXRn+uWaJ8jq6AGoSoCxBuI3vYyAuI
 9gbuDgSKqCOKhqdChpaDoDWb4TreuQFsiGX/DKarit
X-Google-Smtp-Source: AGHT+IG4YJ5aTDZRc7KfaS1o0nhdaaMJ3ZE1F0IiQ7fLBMGavVMPqT0d/xnDISO31BrE27isGmGH1Q==
X-Received: by 2002:a05:600c:5298:b0:458:b8b0:6338 with SMTP id
 5b1f17b1804b1-46e68bb9fccmr20112205e9.6.1759396318488; 
 Thu, 02 Oct 2025 02:11:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9890sm2814719f8f.32.2025.10.02.02.11.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 02:11:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/9] target/s390x: Propagate CPUS390XState to
 cpu_unmap_lowcore()
Date: Thu,  2 Oct 2025 11:11:28 +0200
Message-ID: <20251002091132.65703-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002091132.65703-1-philmd@linaro.org>
References: <20251002091132.65703-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

To be able to access the CPU state in cpu_unmap_lowcore()
in the next commit, propagate it as argument.
cpu_map_lowcore() already takes it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/s390x-internal.h  |  2 +-
 target/s390x/helper.c          |  4 ++--
 target/s390x/tcg/excp_helper.c | 10 +++++-----
 target/s390x/tcg/misc_helper.c |  4 ++--
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 56cce2e7f50..1fb752aa1d6 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -327,7 +327,7 @@ hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
 int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch);
 int s390_store_adtl_status(S390CPU *cpu, hwaddr addr, hwaddr len);
 LowCore *cpu_map_lowcore(CPUS390XState *env);
-void cpu_unmap_lowcore(LowCore *lowcore);
+void cpu_unmap_lowcore(CPUS390XState *env, LowCore *lowcore);
 #endif /* CONFIG_USER_ONLY */
 
 
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 5c127da1a6a..a6d4a1ce05d 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -117,7 +117,7 @@ LowCore *cpu_map_lowcore(CPUS390XState *env)
     return lowcore;
 }
 
-void cpu_unmap_lowcore(LowCore *lowcore)
+void cpu_unmap_lowcore(CPUS390XState *env, LowCore *lowcore)
 {
     cpu_physical_memory_unmap(lowcore, sizeof(LowCore), 1, sizeof(LowCore));
 }
@@ -134,7 +134,7 @@ void do_restart_interrupt(CPUS390XState *env)
     mask = be64_to_cpu(lowcore->restart_new_psw.mask);
     addr = be64_to_cpu(lowcore->restart_new_psw.addr);
 
-    cpu_unmap_lowcore(lowcore);
+    cpu_unmap_lowcore(env, lowcore);
     env->pending_int &= ~INTERRUPT_RESTART;
 
     s390_cpu_set_psw(env, mask, addr);
diff --git a/target/s390x/tcg/excp_helper.c b/target/s390x/tcg/excp_helper.c
index 5e1d4dc9583..0ae4e266065 100644
--- a/target/s390x/tcg/excp_helper.c
+++ b/target/s390x/tcg/excp_helper.c
@@ -285,7 +285,7 @@ static void do_program_interrupt(CPUS390XState *env)
     addr = be64_to_cpu(lowcore->program_new_psw.addr);
     lowcore->per_breaking_event_addr = cpu_to_be64(env->gbea);
 
-    cpu_unmap_lowcore(lowcore);
+    cpu_unmap_lowcore(env, lowcore);
 
     s390_cpu_set_psw(env, mask, addr);
 }
@@ -304,7 +304,7 @@ static void do_svc_interrupt(CPUS390XState *env)
     mask = be64_to_cpu(lowcore->svc_new_psw.mask);
     addr = be64_to_cpu(lowcore->svc_new_psw.addr);
 
-    cpu_unmap_lowcore(lowcore);
+    cpu_unmap_lowcore(env, lowcore);
 
     s390_cpu_set_psw(env, mask, addr);
 
@@ -378,7 +378,7 @@ static void do_ext_interrupt(CPUS390XState *env)
     lowcore->external_old_psw.mask = cpu_to_be64(s390_cpu_get_psw_mask(env));
     lowcore->external_old_psw.addr = cpu_to_be64(env->psw.addr);
 
-    cpu_unmap_lowcore(lowcore);
+    cpu_unmap_lowcore(env, lowcore);
 
     s390_cpu_set_psw(env, mask, addr);
 }
@@ -405,7 +405,7 @@ static void do_io_interrupt(CPUS390XState *env)
     mask = be64_to_cpu(lowcore->io_new_psw.mask);
     addr = be64_to_cpu(lowcore->io_new_psw.addr);
 
-    cpu_unmap_lowcore(lowcore);
+    cpu_unmap_lowcore(env, lowcore);
     g_free(io);
 
     s390_cpu_set_psw(env, mask, addr);
@@ -491,7 +491,7 @@ static void do_mchk_interrupt(CPUS390XState *env)
     mask = be64_to_cpu(lowcore->mcck_new_psw.mask);
     addr = be64_to_cpu(lowcore->mcck_new_psw.addr);
 
-    cpu_unmap_lowcore(lowcore);
+    cpu_unmap_lowcore(env, lowcore);
 
     s390_cpu_set_psw(env, mask, addr);
 }
diff --git a/target/s390x/tcg/misc_helper.c b/target/s390x/tcg/misc_helper.c
index f7101be5745..6d9d601d29a 100644
--- a/target/s390x/tcg/misc_helper.c
+++ b/target/s390x/tcg/misc_helper.c
@@ -570,7 +570,7 @@ uint32_t HELPER(tpi)(CPUS390XState *env, uint64_t addr)
         lowcore->subchannel_nr = cpu_to_be16(io->nr);
         lowcore->io_int_parm = cpu_to_be32(io->parm);
         lowcore->io_int_word = cpu_to_be32(io->word);
-        cpu_unmap_lowcore(lowcore);
+        cpu_unmap_lowcore(env, lowcore);
     }
 
     g_free(io);
@@ -700,7 +700,7 @@ void HELPER(stfl)(CPUS390XState *env)
     lowcore = cpu_map_lowcore(env);
     prepare_stfl();
     memcpy(&lowcore->stfl_fac_list, stfl_bytes, sizeof(lowcore->stfl_fac_list));
-    cpu_unmap_lowcore(lowcore);
+    cpu_unmap_lowcore(env, lowcore);
 }
 #endif
 
-- 
2.51.0


