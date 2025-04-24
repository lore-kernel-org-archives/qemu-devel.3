Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6FAC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ktg-0005v8-5p; Wed, 23 Apr 2025 20:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktM-0005du-Q6
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:41 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktJ-00053u-B8
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:40 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so333572b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456195; x=1746060995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+vJSXjRAVXeTwmKub0ZXgQhIZDI7tyX9VxiyklcrIY=;
 b=fULYQO/pU+Tg4jDS/zih4ACm+yLtWO5zut5qJlD/k02oA4pCxtLoaYMkLwxly124zC
 Jw7eRaox1ewXljDdaKi0l8EJs1IkLo18xuR6Qf3Gf/o17udXOmhlvawU3u961vt+mukZ
 hOS8uHnlQICQaiXPvY4yBB+k7HiKptjfdopapM8TT+g4SYzzgmQ/IWXNIn+zUtWMtDnw
 /6k62f1knDJdVfLlqIC1QxQdEuJMhDvihEn+TaCKDYzXNWsqaP8oCagqgTiyC52NCJP7
 cChozm4tGUBjGF2fFpfs9YDPI+RQFeu3As2oOOtaYDxiwi5FKdiu5VRzQYk5EFgA+Qhp
 Q/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456195; x=1746060995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+vJSXjRAVXeTwmKub0ZXgQhIZDI7tyX9VxiyklcrIY=;
 b=TUOdckQ9shXWucqDyGKoZpDRr2mAtnutGntGDy5l7Uc/GHUYOchIpwDVayxMFQavVd
 ahubUfe/kSvIQzCIsi2KxEel/eu5JUoHbztiWzp4o/kqyeOZGsfXFA062bQbeq7pwv8U
 KBLMmstHjMLl/uMZR+JXYs/iGH6jc3FnkXkvG5UGCNY6lebGaKKMatBimV3OxcnEy2tU
 Rj9ISyct3a3m2z5l7ZVt5g+mQk0wtLAuQQPCt5nTELQFAznYde5I45vzr9zeGom4mLE4
 aDv/ruReo/MeeiJA3LLBkT9h8WQ/nFAl4VGNrtuYf5jDwlvw1TZIuNaQ74bh8iSUzgPw
 +Jqg==
X-Gm-Message-State: AOJu0Yw0lXiIEOlPuM5DWZJbWUV4XWp3KTHbjuprxWaeDYmfrmXLTHsr
 0BN8fJsVsZdeFfhyGpEUszMhhxrlHfiTKmqicMlD2gBgdyGv9wQIu9bd/63w1NGRzqLjPQ4Ifvz
 2
X-Gm-Gg: ASbGnct6AXLtyEKqRnFNWYTLafndxMzCGIgBFgpcS/RdEqrG6TVQIQoQS6j7THxb9YC
 lXC7uJ5yws5/zzQlgR9wTDDAdzU/C/xOyU2bNzzb9c/q82qeBsl3LW8qX06vRpFZqjTu3LShtv8
 eiCtElOfmmIBxmrW4LvjTn0EdIuiAmRONSI4aUFz4Ut3ZchIEuNgnf/mQciON5xWIgtPk3/nSZZ
 MbgfWD9plW+H/F1Q8XuFLY6+LYgo4/n8WN8Ardeif3XMtZsUKPKRZGRHC/GcmW/7xTwf8APnTRr
 OjANp92hQQHXSSFhLdLN9Q8JXJEOBNh9D5H7aFkZd4v82rd3yQP0ThJLcaebq9PajV9Gw59lUUg
 =
X-Google-Smtp-Source: AGHT+IG2kVFFnBRoTgGovRKktfP9wN0WYfAN4srPaMf8eBfVGimmTxmW7EHdRRGyWLEhiuvK+x8aGA==
X-Received: by 2002:a05:6a20:7493:b0:1fe:9537:84a0 with SMTP id
 adf61e73a8af0-20444e9b3f1mr931958637.15.1745456195354; 
 Wed, 23 Apr 2025 17:56:35 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 081/148] target/loongarch: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:26 -0700
Message-ID: <20250424004934.598783-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
Message-ID: <20250401080938.32278-11-philmd@linaro.org>
---
 target/loongarch/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index ea1665e270..cb96b17911 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -868,6 +868,7 @@ static const TCGCPUOps loongarch_tcg_ops = {
     .translate_code = loongarch_translate_code,
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
+    .mmu_index = loongarch_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = loongarch_cpu_tlb_fill,
@@ -919,7 +920,6 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
                                        &lacc->parent_phases);
 
     cc->class_by_name = loongarch_cpu_class_by_name;
-    cc->mmu_index = loongarch_cpu_mmu_index;
     cc->dump_state = loongarch_cpu_dump_state;
     cc->set_pc = loongarch_cpu_set_pc;
     cc->get_pc = loongarch_cpu_get_pc;
-- 
2.43.0


