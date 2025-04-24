Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F5AC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kv6-0000h3-Gz; Wed, 23 Apr 2025 20:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktV-0005pS-2m
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:52 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktR-00055o-Vv
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:48 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so333888b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456203; x=1746061003; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XOzE7rPFSES9/s5906mqBQxSMctIAbl+hzNfrPQ2HWo=;
 b=qszmxAMDMNlS/K9Vpci50wFnFrQEizjAa2KrkDe3Lvgm0NKhs/ltmo7WpG9F82IDUC
 6MmmBYSl7nE3s6q9V4StrtWaT//GjsSr+uVr9IJ5/LfyDgvuKBZU0AEK9nQJn39R7kNg
 49Nx6zQxxppqsJv9gC83n9iXY/FDANgkFqCM5Gn/jBea5YOxEHLHV9yYeqgRzDiUZLig
 +oAya7+pXzuYNUgUgabScuZ33JRVB3s0rwqgpHPKRbatPCP4hT15iX930UTE4Zr2XD1I
 B0NMMblvO2f0wxLZDK9c1c9GePjLYsOn2l8OfXrtfWdrckTAZzHDWQ3sBDFRPMg6pbRK
 ppWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456203; x=1746061003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XOzE7rPFSES9/s5906mqBQxSMctIAbl+hzNfrPQ2HWo=;
 b=lX3m0M1gfGxUzfYAi/AcKdwQG/wWE16NmSNMtEzt5muC9FYEY91OAI2Q/EXwNTYMGE
 RhRI/kPpC7FcW5BB5P1dbzpMjDV3OiODO+odpQoKdyMNtNA+DMsVNolqoQn7ptDloT8H
 CeBWLX1cVSf/APIuxlGx7lNOUqNtAslcXaoNw94tkdubEhh0pEvEpM09ikykB9nxcI5v
 Z7IdIaJTNJKspsZ66mo/Up11bmhMUTLB1jK8IxlzYAL+082lkvPA08tJ98gtZTtDNtX8
 AzNW79GEG3dvM5pPzL+92+F8pEKlgiIua7S/gzorLCjXv74/dce2elWLwtMeUhdaabrv
 Uo8g==
X-Gm-Message-State: AOJu0YzRYKagSUs9tF85csEYmJlrpsfIAKYHt0aJ4nC9AK4WbCaUDhVI
 bfjBj6UmMMyuE4TIYsYYEeeMrZAqC8rgCH9NMTktENSB8PYdLe1d9mj4cuJ2C6ixd/Pihd/0ctm
 +
X-Gm-Gg: ASbGncvu+os0fa/18+hjHJxktnckmVjvg504HRvSJpEIRgd5f/rrgK01sj6e29WFf+9
 pMKzxrgDsyUJ6xHx6Ixe4hcmiwzx7vKmRwtyiY2HW098iaQjTdlO9LOzLxOS4Qdihtg/OfGwoav
 SYHTho4ekcl5Gt/S2fhorx9UtVUUAhvo2ZhPiNdmtQ5pBkOBo3GBOnj31/25Xo0xRWaDyR3O/EA
 BXn+H9xQ5YN/fo+4JSYuO8P7ARXrrL7bDjPB7MnBTUpxrq9u1OFs3AZ9T0NAxwuansJxWVwah23
 G8nz9YhqsrYlDc3TyG8bUqMJo5h+b4pIPP7+5cZ8NiO4Rup3Oo5HWCe/weuuHJFlsgmNOiqeUAw
 =
X-Google-Smtp-Source: AGHT+IHkGxa20/CW06+4ylPE95BPeiqRvRwuun32tf1nBojj2YTuwfQ8xEFqshKqFQLMmu+5mfFJdw==
X-Received: by 2002:a05:6a21:a4c4:b0:1f5:83bd:6cc1 with SMTP id
 adf61e73a8af0-20444d0defdmr1076413637.0.1745456203048; 
 Wed, 23 Apr 2025 17:56:43 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 093/148] target/xtensa: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:38 -0700
Message-ID: <20250424004934.598783-94-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-23-philmd@linaro.org>
---
 target/xtensa/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index ec6a0a8b66..51f9ee9e89 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -236,6 +236,7 @@ static const TCGCPUOps xtensa_tcg_ops = {
     .translate_code = xtensa_translate_code,
     .debug_excp_handler = xtensa_breakpoint_handler,
     .restore_state_to_opc = xtensa_restore_state_to_opc,
+    .mmu_index = xtensa_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = xtensa_cpu_tlb_fill,
@@ -262,7 +263,6 @@ static void xtensa_cpu_class_init(ObjectClass *oc, void *data)
                                        &xcc->parent_phases);
 
     cc->class_by_name = xtensa_cpu_class_by_name;
-    cc->mmu_index = xtensa_cpu_mmu_index;
     cc->dump_state = xtensa_cpu_dump_state;
     cc->set_pc = xtensa_cpu_set_pc;
     cc->get_pc = xtensa_cpu_get_pc;
-- 
2.43.0


