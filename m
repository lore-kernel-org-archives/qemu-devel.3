Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C32C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Gl-0005ZP-Bs; Wed, 02 Apr 2025 17:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05GU-00057x-Vk
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05GT-0006EO-8I
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:04:50 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so1574445e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627886; x=1744232686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+b3Ca+6gzpW62zGfp9PPbz3auzMeAfNp1gslaeAJo10=;
 b=E26aBWHAcaAGKTVQ6x/Sp28TYi9afgeeoZxxckh4mdkPmqb+WlUNKenpkK5pNCvufr
 RLxanI6Bnt3yJILaoBgeyt16/M6+N3DiBfPMAoIpK6J9wuS465Rr92XLliN0x7sjRS7/
 68EGvo7OEQaLpyNcZN4UKcjokJdim2d6BOpe3cKLpHAjyf6utVsME9FF21VssGTabhl1
 iO3kZHn/nBaQAHKmXUwwX7H7FYF2jHqr9wjASKoTKxXdWZ6L3gpFWJJ2YYIMnedfJSr1
 aY+NQFeOH3x4AtAAMr94a6YHY8vcLVsNiQJDWXPHj7wnQq0KFQrYl7Hy4vF3CefBv5lD
 HbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627886; x=1744232686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+b3Ca+6gzpW62zGfp9PPbz3auzMeAfNp1gslaeAJo10=;
 b=rFu42yUp2akjx/wPPK0l5tzELyVoghnArXLOURQ8TEL8ewJhVH5SQkq2AquaOj3TmX
 xlbCmQj3o1JeBYdNTfWF7ulcACjE0y1FLpbQ4bF1HsekIP7ow1V2nWCTlz/mEBRwKkcx
 7dpnoWyTAvj8W5JhwCabNcRP658WlEazg2HYH8S8fw44Tla30NaPUogshFNAGzRAiTgE
 7t44PUa+omLYcYqeMl7ZzCTe6ZiGqDwRbfgJwHngwBaQdIA4D32ciPJHbAw4CxH2T/5x
 CRCKzXS0IBwHFQr4QmUhfjGZp56ZwIqa+bvHOoVi/FnkN5MwlyCKIntXJ/KZtBjp4Edc
 GCeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5VYJ12tadpuK+4WPMKImd15vvezpfV3z/DPI9mOvnkdjkM2BlTeJzz3Oa+mOI1oxqar+1jiKMo15L@nongnu.org
X-Gm-Message-State: AOJu0YwM8Kwblw+2V6EWpsh14ZLEYO5cXLr1UwxcHNRkpV2VDxOpsw5x
 JcuDIVag7JtCsvqtEIwVNKrdYQdESccnUl6ilnmx7W7jjE9TeJNex1PwdArI6UEK6YNSaeWrYhI
 X
X-Gm-Gg: ASbGncs31BAKlzhUOZh/p3s8/sUW5vvOWmp9nM8u1F6ZljrwxNQ7MeyLL/lmwLQxmrd
 BlQiBnWiTNGyzk9FG9pnb+yWzIb5sBNhFg7nQhAAJLYNl0OXwaN51LMULhZC+TFvVJIk/g2Lu10
 6zYTko5kCHAXjHiukRS+2J7+a3Dp425agFHeH4oiVgFqYSN1MUU7wuJWtllrQbJNaOP1oMC7oAj
 ku7tqUI5Pv7OWHlkUA6d30QO5tEiFJ/qkbI3NL3eJvUklWoPc1KBU8pqzydHTMc+QFOzAGg6Kxz
 L6xKchI37wRn0aFEByckR6/wJC121v7VLUlGz8PGaEbnejk0HigWHLWmUI3XhRKQgIpINoGtql+
 hk5laeK7AcXjpMeGCp0c=
X-Google-Smtp-Source: AGHT+IFCnw/GyWSmS0W/jyJqtVCqq+JU1k9u4/TingfpPBAaGcJtjcrNP4W5HXGjbvLWl/nSpUyXJw==
X-Received: by 2002:a05:600c:83ca:b0:43d:b85:1831 with SMTP id
 5b1f17b1804b1-43ec108a435mr3075005e9.0.1743627885994; 
 Wed, 02 Apr 2025 14:04:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec16602bbsm2063325e9.9.2025.04.02.14.04.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:04:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 16/43] target/openrisc: Restrict SoftMMU mmu_index()
 to TCG
Date: Wed,  2 Apr 2025 23:03:01 +0200
Message-ID: <20250402210328.52897-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index e8abf1f8b5c..dc55594a7de 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -247,6 +247,7 @@ static const TCGCPUOps openrisc_tcg_ops = {
     .translate_code = openrisc_translate_code,
     .synchronize_from_tb = openrisc_cpu_synchronize_from_tb,
     .restore_state_to_opc = openrisc_restore_state_to_opc,
+    .mmu_index = openrisc_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = openrisc_cpu_tlb_fill,
@@ -269,7 +270,6 @@ static void openrisc_cpu_class_init(ObjectClass *oc, void *data)
                                        &occ->parent_phases);
 
     cc->class_by_name = openrisc_cpu_class_by_name;
-    cc->mmu_index = openrisc_cpu_mmu_index;
     cc->dump_state = openrisc_cpu_dump_state;
     cc->set_pc = openrisc_cpu_set_pc;
     cc->get_pc = openrisc_cpu_get_pc;
-- 
2.47.1


