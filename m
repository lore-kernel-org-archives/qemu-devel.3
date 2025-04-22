Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2FFC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JQu-0000yl-1H; Tue, 22 Apr 2025 15:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOu-00056Y-3a
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:29 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOr-00072B-2W
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:23 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2279915e06eso58644985ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350519; x=1745955319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XEXzmO/KCSQQZKkw02RCDXKV53yZWyTGZY0ovHpDmRg=;
 b=aKgJy241OMOBCwypdyFwjD4M/WmclH7C6wJdAP2HlTfhBO75COUEQhHtsEDyJW5chB
 BvZFBbbG8qKHG5jGVdxOZ/CXlayZ/J7A+p/DbQL45PUntQM6mR9T/TjnxZ0Gsf173jW2
 l4rvaQKlXprgIJzKU+K58OzXSMi2PLo3YmGj71Kp9bb81U/+jpHTS0cZkl/12sCDl8nt
 ifpYvontg0DC6s6Lfe/hB07h+YGSSXA+UBOMH1b8G8uAlpZ7q5D+X1Lkgjv0vYyiWnyg
 fmCZ5Neu1sLoFWXAMYNRfZpzHgoouI4HFFb+C826jOQTPn7F5ZyL9Fgt3rmkb9D/p2pW
 2xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350519; x=1745955319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XEXzmO/KCSQQZKkw02RCDXKV53yZWyTGZY0ovHpDmRg=;
 b=FR8GTkQUrrEKPhYcUVY/CZcRz0uwGpUOY9YEklHyqlw/DfHAf1EpTIL5ZOM5rHHJsk
 CAE+8W4eXWMUE9Buwq/J7IDzmkDxEgv29YhMOMwW7D56P0PcJQHIMSJUqpGgWhzvPRcQ
 pKGJeNXnpXEQU1Vf/y/NobAj3Nk9HS93i/zd+DVf0ETChigfYV9ofVoz6tiAr916fIsA
 C3oHEjKUf4xANB7iTIGW8fCVYUKfSbrV1Q56OiGkOUTHH1DjEGXa36R33TlWePpvE6cK
 XfdOo1GbStSxAnuLbuli59Pc/kf01q+1yRI3coAlAHV9BTZM4KKWeT+8yI1weqhVy4F6
 VcEQ==
X-Gm-Message-State: AOJu0YxZp46uNUdDpxei6UtiovWgXep20l9QK5H5bhiCZrEo0eRFH2Xa
 9BJ4/iGq4uHzvXeLn4nymbmbxoHZ9qMYDV0WLX9XNmfPo075UbV8tRUHaUe6pncq5UyppsCU7Tc
 t
X-Gm-Gg: ASbGncuSDrl1Rb1JxO3RVNnzxkDAd+d3GeY4Dw8oewXQQDhpcjf+q4x03EHzmjhxYHD
 aydGFIPEokghoxNBaZ+fByLRDZ+w6K63RcM+F+m8gFt2TcSWJEa3JfwQTeLF6qmF1pgGpr4SDW3
 Gye6rSdkFZs19817aIJW83Goc9tegwmz+eVQkCiJGaCBGoHI6MIyghvnLVlc2jkhidcB0CYD56o
 waqyBiaYUHLKjHeJ8ZTgM/1EdQoSMO1rXDZ+EsvgicgzRG+ifTBGiP+z+6JggVRUAvtwHZ+1dmZ
 HHzExy3IGgXMS7j5TpPfNgVOXCTCTsOtwUWX7pf3Ul6+8ZP7wU3gI+0QdgFm4BcdBcOeRwfWmdI
 =
X-Google-Smtp-Source: AGHT+IFUHeMVE/VHlrolxv2J1XJ73m8kejQTF9Y1ueHnpE1oQeLSGlU+X4m8uYPP40wg5GtM78APmw==
X-Received: by 2002:a17:902:f611:b0:220:d909:1734 with SMTP id
 d9443c01a7336-22c5359c1fdmr243158385ad.14.1745350519123; 
 Tue, 22 Apr 2025 12:35:19 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 089/147] target/s390x: Restrict SoftMMU mmu_index() to TCG
Date: Tue, 22 Apr 2025 12:27:18 -0700
Message-ID: <20250422192819.302784-90-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Convert CPUClass::mmu_index() to TCGCPUOps::mmu_index(),
restricting s390x_cpu_mmu_index() to TCG #ifdef.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-19-philmd@linaro.org>
---
 target/s390x/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 1f75629ddc..d15b1943e0 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -126,11 +126,6 @@ static vaddr s390_cpu_get_pc(CPUState *cs)
     return cpu->env.psw.addr;
 }
 
-static int s390x_cpu_mmu_index(CPUState *cs, bool ifetch)
-{
-    return s390x_env_mmu_index(cpu_env(cs), ifetch);
-}
-
 static void s390_query_cpu_fast(CPUState *cpu, CpuInfoFast *value)
 {
     S390CPU *s390_cpu = S390_CPU(cpu);
@@ -308,6 +303,11 @@ static const Property s390x_cpu_properties[] = {
 #ifdef CONFIG_TCG
 #include "accel/tcg/cpu-ops.h"
 
+static int s390x_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return s390x_env_mmu_index(cpu_env(cs), ifetch);
+}
+
 void cpu_get_tb_cpu_state(CPUS390XState *env, vaddr *pc,
                           uint64_t *cs_base, uint32_t *pflags)
 {
@@ -348,6 +348,7 @@ static const TCGCPUOps s390_tcg_ops = {
     .initialize = s390x_translate_init,
     .translate_code = s390x_translate_code,
     .restore_state_to_opc = s390x_restore_state_to_opc,
+    .mmu_index = s390x_cpu_mmu_index,
 
 #ifdef CONFIG_USER_ONLY
     .record_sigsegv = s390_cpu_record_sigsegv,
@@ -378,7 +379,6 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = s390_cpu_class_by_name;
-    cc->mmu_index = s390x_cpu_mmu_index;
     cc->dump_state = s390_cpu_dump_state;
     cc->query_cpu_fast = s390_query_cpu_fast;
     cc->set_pc = s390_cpu_set_pc;
-- 
2.43.0


