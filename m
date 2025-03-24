Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68659C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twn0t-0000zW-S0; Mon, 24 Mar 2025 14:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn0s-0000yx-F8
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:59:06 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twn0q-0001PS-S8
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 14:59:06 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3914aba1ce4so4058563f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742842743; x=1743447543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H0dvd2P36winpZovlVz4NmarrWHHCldFw3mWW6dP9ow=;
 b=OI2G3Azk+a5sNtfMmME005iyAiRlNgl8HDiynHZ+DJItQVaRf9HOOXjhk1dEGqcHn3
 eOdkDDVmhX4bFL6L3i88+7bcXk1HOWr4/ZQ/1a2iPD/ajStz3JfaMGe3KDUJ85uxSeaj
 7QIeP6L3rghXwmjkpiuWd6yef6oV/CD5dBvL17Lvscmn/MS9hvgMYafKppAWwXlHoYF6
 7DbiJ5ENbZ5sC/Kdi6tLBavlMuzZnN9kNEVdNizInYjnni/HidsM7qhxVh578irw2SXb
 vkhuxsNoH9WN7mlrGJITUrPYk8utRWndQrBQteBxHuHAG2tC1mTEtfQHDsgUffIS+iTH
 lh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742842743; x=1743447543;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0dvd2P36winpZovlVz4NmarrWHHCldFw3mWW6dP9ow=;
 b=nPXrdUZGctRWhkzIXuDD0qLrMZzN2Yn7EF+F6jPle4pi6sdOJDj0lzYTx7iozZNIwH
 JMphrPQPpD7AKFFlf9q5Z3fGjvfk/We99jgQoyQL7+vC1EJce1hdEnOqXSfFuQkhpAgC
 3aIX3tmOa0MH0f457AKILR2HfN7ePevwTbkEmwWj80jff5gQ9iw+7pr3u7wZjdq7ZScf
 2YWUDXn6o3CHnJZU8nqzgu8mZnalb1nKlBtNefMOapZ6mli0Cjiy3jbANoJA95kEh+ic
 0h3RVo4rh5EqtokR1caIFClJVCXu4bgXbFR3FeGgn4clDLfrdGLWOvDAfKPeUIDY3hPn
 ZVJQ==
X-Gm-Message-State: AOJu0YxSeIA4uFwJxp22WDtvNHvYdf1mksFa4dyeLNujTWvIqaVgVi0h
 lngtaVd2TwrSaKp12YLkN4sibB0Ie/yS6m2AU1wVdvKJ6SqaaGFP+ma0aGWlq+d1BBTc44a9nqV
 y
X-Gm-Gg: ASbGncsqCclWy2fX7O7wwXmGGJAppIAE5XY1vUPcxcpoL/hGYLvy1c4pJrElBRrd88o
 BQqSx+4RW3e+23g9PeFy/J+USTlNoyDSIYd7kBwn8L+K13j6NNJXVEKVE3/GsZ2/Eo1X/copUPj
 dGtJOjzNrny7aVHuz82QdmFWebKpiPjWpcxCCfrOslWBznGLhWXrEJmgk33o9wjyyDpIR+gKnHH
 8RcCKEJltfzJwoAR1CDJtILoHYr8WnV2y79hkXw7l5ZhAArCky4KdVhKGed5z2Os5icXGi8RtkH
 R1+XS0F+wYY2CTcfPAjqPq7jfKmmtChvvLSDCgOISerj81H0JzVbMX5xPzAb7XQZi26HbZJK2WA
 YAHNWu34oQq8ugASO+0+LhTEj
X-Google-Smtp-Source: AGHT+IHC6tzIzk1XqaJZfNEoX4ga1xqBGGRmiZwnpZijmlQbX/ux/00M6PoWFd34rkDOxKwVmpkTEw==
X-Received: by 2002:a05:6000:2801:b0:391:139f:61af with SMTP id
 ffacd0b85a97d-3997f913a91mr9102368f8f.32.1742842742804; 
 Mon, 24 Mar 2025 11:59:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd18505sm127632185e9.11.2025.03.24.11.59.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Mar 2025 11:59:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eric Farman <farman@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v3 4/7] target/sparc: Register CPUClass:list_cpus
Date: Mon, 24 Mar 2025 19:58:34 +0100
Message-ID: <20250324185837.46506-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250324185837.46506-1-philmd@linaro.org>
References: <20250324185837.46506-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index 57161201173..635d5d81143 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -579,7 +579,7 @@ static void print_features(uint32_t features, const char *prefix)
     }
 }
 
-void sparc_cpu_list(void)
+static void sparc_cpu_list(void)
 {
     unsigned int i;
 
@@ -1031,6 +1031,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = sparc_cpu_class_by_name;
+    cc->list_cpus = sparc_cpu_list,
     cc->parse_features = sparc_cpu_parse_features;
     cc->mmu_index = sparc_cpu_mmu_index;
     cc->dump_state = sparc_cpu_dump_state;
-- 
2.47.1


