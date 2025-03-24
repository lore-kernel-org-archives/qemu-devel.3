Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52285C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 18:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twmou-0001IR-Is; Mon, 24 Mar 2025 14:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmoq-0001DI-TK
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:46:41 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twmoo-0008Qh-BP
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:46:40 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so3767706f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742841996; x=1743446796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rWkqddQkJvJSnAE7FQ33ooZJv8FPQjkwQkQsfmpvDnM=;
 b=quuNMyF4AvCKJqA3iMmSzMWmTFOk5ZlA088kSJsxbG1V7TPlh6/rVJTWVAHxqSX4iH
 5Zx0MJ5uHEYJLH6JX0cu+scFCooRW2aaC7gfVnt+cCT0BexTp9fE3/9qhBxGEP00UvtV
 XBHDDMGAhAvc92GgEPci7Y8Qjp5nWtopr+10/wRUSsprQao4JEUClbztunMjm4TwNqL7
 zzCGMoK0oG/NtjJiQo6dJfj6+qSA1LX5tUowayPEdWEHkIDQMtJ6o/361LdKcwQundmK
 875Qj98i249TLQqSQYVam393mou9cPxURPLShVLw/O9R5s5nxXoaKtJlGIzYP2cqzvC6
 wPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742841996; x=1743446796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rWkqddQkJvJSnAE7FQ33ooZJv8FPQjkwQkQsfmpvDnM=;
 b=qV3ZLujxq88SsgwlOq3iqQwrQyo+d92cWOi1KjoD8/hohUj1mv6tmH1OpLrszKLQol
 pcp/6Oy1a7nmMPsKxHVzN59HHNLhvKBvYa7iPRUEkMqgrs3ZWOQ/448n8dqN7tPKyN8G
 nqxAyhLurshDK10fKM5y+xp+k/eMlqB9akVqvIZyD6hsObe5fv5zsJgMbEfJ1n/NsF9+
 VfqBh/z9bYwdAGKOKpWuIQvShgth0RqfJvZ9dIZKnazEjlRkc8xtVaRcDJkOtVFHSOUl
 25feoY58iwLFiQPVWp23Qs30GBYnPasAyOImPGrPZbUrHLApr+yr2bWnSibAsXj6ubNE
 wMZQ==
X-Gm-Message-State: AOJu0YzOax7/MeXxksoer17Fpx9QwIpUGmHuGKWh/2cvuY9xvJZqCrGN
 JQl/O29/i/kB8CgnRTj1P1cR2/v1X+84nsvIn0rJT+5vTvYePhU3bqNQkb70rqRdy6ITw4Q+zob
 /
X-Gm-Gg: ASbGncsoOymSb3I+xqZ9c804Qmw9HxUAC+Sy8IExcxuzqL38LpZVI9KStn3jss2dGoQ
 udYouu21vg1yWNAbrtV/cuzEPHvoeyOX5DhGkaei83lMo8RIDnC+sRog5AWMenHnm3IivmjXXxb
 LS+33Ux3bqle746Hu+7e5dSCGz2+AqeN2up8WkPuRvU21Xj+EMsNMfrrynKL01/UJNfDPJxN3Ub
 PLQU1FjkWcV+Hs8UBJ3PLtV6LwSD5k2Jrc8xXSXs7UohwKtpXL7kGpxMnDx1QkZnb87WytUbO1P
 Z7NmbYoLqCZ1GzFLpdcVqioDhHdgNbqzGTNpjqOiSKFG/13hKVsuxNOcazsK8Lh5aK3Jd7dDiD4
 pa7rQJ5Wa/zq6M42aWZcHCGpT
X-Google-Smtp-Source: AGHT+IHN7POA1CcO1ai+awjJoESudwOrdt9B4xemBTOWFuU9n6uE5Ldh/7qSFBdGw6lq1KI5JtosMA==
X-Received: by 2002:a5d:5886:0:b0:391:3406:b4e2 with SMTP id
 ffacd0b85a97d-3997f940d74mr10501148f8f.49.1742841996038; 
 Mon, 24 Mar 2025 11:46:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b5536sm12003874f8f.54.2025.03.24.11.46.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Mar 2025 11:46:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v2 4/7] target/sparc: Register CPUClass:list_cpus
Date: Mon, 24 Mar 2025 19:46:08 +0100
Message-ID: <20250324184611.44031-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250324184611.44031-1-philmd@linaro.org>
References: <20250324184611.44031-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Register sparc_cpu_list() as CPUClass:list_cpus callback.
Reduce its scope and remove the cpu_list definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 target/sparc/cpu.h | 3 ---
 target/sparc/cpu.c | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 462bcb6c0e6..7c6296ae70e 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -594,7 +594,6 @@ G_NORETURN void cpu_raise_exception_ra(CPUSPARCState *, int, uintptr_t);
 
 /* cpu_init.c */
 void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu);
-void sparc_cpu_list(void);
 /* mmu_helper.c */
 bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
@@ -665,8 +664,6 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,
 
 #define CPU_RESOLVING_TYPE TYPE_SPARC_CPU
 
-#define cpu_list sparc_cpu_list
-
 /* MMU modes definitions */
 #if defined (TARGET_SPARC64)
 #define MMU_USER_IDX   0
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 2ae7173c0bc..6b2288c727d 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -579,7 +579,7 @@ static void print_features(uint32_t features, const char *prefix)
     }
 }
 
-void sparc_cpu_list(void)
+static void sparc_cpu_list(void)
 {
     unsigned int i;
 
@@ -1055,6 +1055,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = sparc_cpu_class_by_name;
+    cc->list_cpus = sparc_cpu_list,
     cc->parse_features = sparc_cpu_parse_features;
     cc->mmu_index = sparc_cpu_mmu_index;
     cc->dump_state = sparc_cpu_dump_state;
-- 
2.47.1


