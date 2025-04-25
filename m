Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0632C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 15:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8KzV-0000Cl-Jy; Fri, 25 Apr 2025 11:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KzS-0000BY-Nh
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:22 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8KzR-0003YG-0q
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 11:29:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c1efc4577so1371955f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 08:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745594959; x=1746199759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cvHtVKTPCuJjYvRo+LRk+N4VG3pSXMsEi84hzc30CwE=;
 b=gsVoJNODjbj9axakT9TQ+XdIysKmXAeHPPcyNjtR7rw/WJeGAj/eNs8R0uVqt7LvTZ
 DSCn8kLe6nN3ngvpSOJWyu80rbrg5cUjJwe/qRy/3MqFt7xz4Vf0xmGib2Txs1s7hANG
 lleUfdhV5ATphO6YMphDbTZzld79d0gAjslEONcWuaILorAebJaKEWb2Pk2lCu15HErt
 18s9tlZ1fWrdv7O+Qyd+ERBoC/fw6RAJLQGkcBzjmtA17yMy2lUZzKQQA6ndZwZheN9Y
 PLYKD5oAWH2FogQqL3HzKeQVcXrz6QEnlMwqY7n2Tb9qY/RsSdhTW4WOq9w0SWmlscZg
 hbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745594959; x=1746199759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cvHtVKTPCuJjYvRo+LRk+N4VG3pSXMsEi84hzc30CwE=;
 b=aodt2Nfw1sohgJ6srHq992nCeOzSjU8Rz4+RAM1I0w96Cfo3UwUETv25wsC3pGm0ir
 hGhGy/fKugh1vc6YkcCPH7C6H3JTqmjhAf1ZUdTYkFRG8oILmNFEmu1vGOvwW0bZHt1Z
 GLqe83YQ3gGeoKQItQ+Sc5oG6eHgZehi3htmQ+J6hktehzO3dv5mwo9UYAsZwDLqvtcB
 zcK8ZyNSM0lE01o8i+TYr/AyIXtIyWyN3pJ9FvKaUzTkCTOpVZ0NoaKoIKhhnaMnfa5Q
 hrqoe8OL2QEKrQnOop8AxBCm7Vrb+V5gglGBx0UW7tIzbq9IqAeMtr+Mibpu8mXmN7Ii
 cxCw==
X-Gm-Message-State: AOJu0YyNySO65KvMeSka4VUkjBVr6MNoLrwDAUuyAz7Kp48Gib66h0o2
 atsimE1V+rsLxi9sFpCxL8zpilPtjjxo8ucSzJAlhb0k5Aw+HYLGz8UEfwWlisUvRk+sRiwUTa4
 f
X-Gm-Gg: ASbGncth4d0rpYHHRWLTFMU/2S6QYXsHWZod56pMArxzTgDq8jW5u5aNj5yRY6j58e/
 L3F4PPXaeE3u9kD3+5+8IGxVQplaV9MFlcEwtTsantUvPH6cdawxQNVxSrqpUhmSKgdO0/o9Qe0
 KVNoTifgRcOKlT+Td1nLFjrHw0bVPme4xGUCSycgRRT0vRKHwOi0OG5XtqefCVksuREZMFxxx8k
 t2NEQE3roZ4aYIHyb85b4xjZqsiNyxttz7ygNlRIgWVz9pOnzpamkJypyM3EUvvjBvpYeF/N/OW
 ir3x+rqN/bYpcZ9XDtHJgNoQ4XxLBu9Zm6vjpaznPXayFW1zOhjUC9jofyr7NBW0D4NFo0EqVMU
 6WK+EjWEUdwY403c=
X-Google-Smtp-Source: AGHT+IFvdrsCdvWukzzJqRJuY+D7laTE3hmiyfnoEBZTkcRAoHVnK35mFczkaPpaUfVv77ZdgVAIOA==
X-Received: by 2002:a5d:5847:0:b0:38f:2b77:a9f3 with SMTP id
 ffacd0b85a97d-3a074f3ab30mr2365299f8f.43.1745594958933; 
 Fri, 25 Apr 2025 08:29:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46517sm2635094f8f.71.2025.04.25.08.29.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 08:29:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 07/58] target/sparc: Register CPUClass:list_cpus
Date: Fri, 25 Apr 2025 17:27:51 +0200
Message-ID: <20250425152843.69638-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425152843.69638-1-philmd@linaro.org>
References: <20250425152843.69638-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Register sparc_cpu_list() as CPUClass:list_cpus callback.
Reduce its scope and remove the cpu_list definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250324185837.46506-5-philmd@linaro.org>
---
 target/sparc/cpu.h | 3 ---
 target/sparc/cpu.c | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 83ac818933b..37fd1e066e9 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -595,7 +595,6 @@ G_NORETURN void cpu_raise_exception_ra(CPUSPARCState *, int, uintptr_t);
 
 /* cpu_init.c */
 void cpu_sparc_set_id(CPUSPARCState *env, unsigned int cpu);
-void sparc_cpu_list(void);
 /* mmu_helper.c */
 bool sparc_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                         MMUAccessType access_type, int mmu_idx,
@@ -666,8 +665,6 @@ hwaddr cpu_get_phys_page_nofault(CPUSPARCState *env, target_ulong addr,
 
 #define CPU_RESOLVING_TYPE TYPE_SPARC_CPU
 
-#define cpu_list sparc_cpu_list
-
 /* MMU modes definitions */
 #if defined (TARGET_SPARC64)
 #define MMU_USER_IDX   0
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index f7d231c6f8b..174b76f7624 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -580,7 +580,7 @@ static void print_features(uint32_t features, const char *prefix)
     }
 }
 
-void sparc_cpu_list(void)
+static void sparc_cpu_list(void)
 {
     unsigned int i;
 
@@ -1057,6 +1057,7 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = sparc_cpu_class_by_name;
+    cc->list_cpus = sparc_cpu_list,
     cc->parse_features = sparc_cpu_parse_features;
     cc->dump_state = sparc_cpu_dump_state;
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
-- 
2.47.1


