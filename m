Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E369BC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 22:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twU09-00063Z-Ue; Sun, 23 Mar 2025 18:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twU07-000628-BQ
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:41:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1twU04-0006Bu-HX
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 18:41:03 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4394a823036so37961855e9.0
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742769659; x=1743374459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F3UrwbOIIaM8kGadwD98OC60MbBxsesgGxlGmJo4cKw=;
 b=kyGoI3dbmIEO5h4Z6lodldM1OVzo3hWQivogsOGviwoDqvKUz4/2iT8CRJc95+wsl5
 rZFbwG5ERpeFx54F1moNnSXfHG1xC/rdDF7//UGk93Iy4zhG075XzQxPJVpNm4fB9IqX
 5xH8KxVn0uHkJV5jRIwXS7NY2Q42oxGJgsyp7MRerWXx96zocqANnx/sPWD6PMs5r+cI
 uB7dA+BjRWLsUM2qLkZyOFWXRIb9BScDLEXnlqWlkh1EfBkbQV3BY7LdhSe5/Gs3l2MK
 SR+YW8B2jqtdO+/SJ32IBhAhnIYcn4ZSuAShASpyja9e/iAuhuWR4AdB+oo4PWJtqYjj
 mk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742769659; x=1743374459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F3UrwbOIIaM8kGadwD98OC60MbBxsesgGxlGmJo4cKw=;
 b=kpTLv+jotSUsNrBEzszQDF4Pw16J4ZMSKhqkqKfP/EB3O/J65YBkM7PZXCckqtf1sh
 s7JDQLU9dfYfM1vL3gNKQf+dhgg7YhjDUDbfK9F0Hf5jYNG4sqvbH3w2mNtno4pDfWsD
 Aw/4wTVXKN7dYMDFd39CsG6pVLfKijj6YPRXgmkyfgMFHAw4nel0GRDbmFXL9l+zGb9/
 utgBd1ga3NGVg+E4k8SDm0udT6MvgZZ8+AsANLPG4G3IzKPVkspfhl5uz6eq2Y+EAE9B
 25+N99p8GqLMl1zeJ7QGjMeZGuIx3rkap2GcielTMq4iqjy7v0hkkVQqkEwmPlP4qYGY
 KRsQ==
X-Gm-Message-State: AOJu0YyP8cMSxK0oHHEEvJk4YJq4j9Cgvq4AaGjUvTf+OVGAFV1D+ntS
 rYPOQ5MKrcfcKg8JpY3jMPvoJxutDkrOVe3U+8kOY2YyvvQ6GDhRNi84utHK2FjCbduKmWBhe7B
 6
X-Gm-Gg: ASbGnctrm6wmcgLCVQ04zd2BFS2TR5t94UKzwFTLy/lhIiPRPxWy+Gwqq9J+r/He4qa
 k7sMHWPuaKrOPkqSlZ6HAt9myp7FDKe4c3f40BzBdLrDdUmXDCmq2pEMexH1WLAi9il8AVu/Xgn
 gw0rg7WdNGAmMbfFRcchTzy6b64uQcIzTTefkb0JQLM23yxtGo0gpJqPnY4nXEWOzI/D2F0pRyl
 jLER1fhQgtZYsTCPbGgB6LaHnKnXRk+kuYW9slcZ7lSbFiFnjP3wtVHA7x0/5J52oAmauCJk2L/
 cKT8iWHCjpuQVxtTPAmO1kyJkkm/SmytIEnZAP25fzajcGc/1pKrgFVI/FB7OaR2/eWW1gWbZwC
 KiguYUbjKmcb0+JIMU/Gob36x
X-Google-Smtp-Source: AGHT+IGmoYGTMc2RrnredA98U8J6aihwrxlN1VEBWVgsFAoOSA+5fLhhzu4HgdCTkxWD1fAHXAZTgQ==
X-Received: by 2002:a05:6000:400a:b0:390:fe05:da85 with SMTP id
 ffacd0b85a97d-3997f8fc301mr10772575f8f.16.1742769658808; 
 Sun, 23 Mar 2025 15:40:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f47196sm150164465e9.16.2025.03.23.15.40.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 23 Mar 2025 15:40:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-s390x@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 4/6] target/sparc: Register CPUClass:list_cpus
Date: Sun, 23 Mar 2025 23:40:33 +0100
Message-ID: <20250323224035.34698-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250323224035.34698-1-philmd@linaro.org>
References: <20250323224035.34698-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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


