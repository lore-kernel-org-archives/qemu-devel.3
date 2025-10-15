Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD24CCCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95pC-0003rk-Ap; Wed, 15 Oct 2025 14:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95oi-0003nq-4s
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:01:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95oX-0006EL-Fx
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:01:38 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-470ffbf2150so5472185e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551282; x=1761156082; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ucmd8j+eG32g5SXQ6QBL+cAm3PPY8er77ne5+2rIckk=;
 b=bm7HAem/1s/8/FYYce/W/TqxupQIDRpOqHL9dDUv+20OsaGYez6bp2LXAw6tnka6Oy
 kIW2RBm5zlauqFlS6EDGC+0b2rSOE2QWf9yl3zGPdOBfhJOqdB7Mxo1JBafYO4fbH/D3
 b/a0f8OJ/SooTNlAeScjvsbiSOlfiyvMGoWJxA4SW5RtRrDRgg3NMkNADCemvhDYUbFk
 SOul8ixUJV561YdmsJXVVZCL72Jw1GyJ8L+10a9xz9xf30fJJ4rukwa9Do743BYE3wtO
 8Dcm6dzeuSB3rgttXsLMdl3pud09su0AauLccf1B6uksXpkItQN7QGIaGXOSQZ6T/nPc
 RaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551282; x=1761156082;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ucmd8j+eG32g5SXQ6QBL+cAm3PPY8er77ne5+2rIckk=;
 b=TE7Dl5k6rUv0mYikTRLoMDFfzr7+PKpMsKUngnqmw40zQ0VeTEmmf/hZ6asORxrV3c
 dvGOZbAI6zoYcpRszVhDwIFlwUOP1a79+3BDxLu3RBVWz79s8PQkqDOBPx2Xa2D41zRu
 syI3o78dusyJouEzzylh0SE1w7q5GUoemqQCEuCzv5nTZf8QhPAuf/xCAkGKD3Zrs99r
 j2YMo2XhPojNsWVyn86P/YRu4iuhcXEhKGxNOme9aChzTTwF+e5hI9xnQQuTUZELXHQE
 JrU33DswfM2uTm3jNjb17sX4zzODtZG4MR2bZBRpouoLEzX6B7tqSl2kSNhMzgY2OOWT
 Rt+w==
X-Gm-Message-State: AOJu0YxGrBIYku+9U7wFUGlK3P0GGzKrZlB1OZK6CytUMZ8El7NohxD6
 QTIqjhDvDcvdf4UHmmNrx4ZCEQQKssjgZMvwZqsLaUsdw90o1kfbxXmgu2Y2gTFsXrbKKnn407T
 REEYfJukmag==
X-Gm-Gg: ASbGncuW4VQTmWzMvVZPyVE/LoyZQNi2jBOZOU1C5ur6ZDNkB72jTuS7YZSgCzQfu8i
 jJy2U+a53VJYRn14BFhXRtqtFt4LRI7KBuGoltAekEqyvTaTVASuDVkxaq4mca/2mnv21OV9+92
 eQJbr0LlGWeZT1BHfteLUzPHBQtYrfG55kt/NMyKhssosvijpRoCTkS39kGgClTG3xl6WGpUdne
 qsiKbBjjy+Uk+jTzAT3X420De6k82u1vDx9noSvvSqFUWqswVdc+8avkPJp5Cigyyb9IY5TDZu7
 AVxIPut64TEY7DhjeAVHmYDtCC3/SqIuxL2ZW0T3kovRulvwE67BsJTbBU+/PVMlHrusHf3A3Tj
 mmSrpHRhaGc8hNtYQdHEhToqvEqqwR9cFAUqaXoQHLvzKviCtTxfez0X4ZxHkLU15CxRwixSqrZ
 ZOzYyPkCcBlha87CbaKbw=
X-Google-Smtp-Source: AGHT+IHVZBxXqxecjdJMpdU/5agf8TLKb2ZHE9xB3DUsOXDWMLQE3PMNoJcRqEZrr7l7IEEAS93SGw==
X-Received: by 2002:a05:6000:1a85:b0:3ee:1494:27f5 with SMTP id
 ffacd0b85a97d-426fb6aea97mr891783f8f.13.1760551282374; 
 Wed, 15 Oct 2025 11:01:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5e0a03sm30635110f8f.37.2025.10.15.11.01.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 11:01:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/7] target/microblaze: Remove target_ulong use in
 cpu_handle_mmu_fault()
Date: Wed, 15 Oct 2025 20:01:09 +0200
Message-ID: <20251015180115.97493-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015180115.97493-1-philmd@linaro.org>
References: <20251015180115.97493-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

cpu_handle_mmu_fault() -- renamed in commit f429d607c71 -- expects
a vaddr type for its address argument since commit 7510454e3e7
("cpu: Turn cpu_handle_mmu_fault() into a CPUClass hook").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/microblaze/mmu.h | 2 +-
 target/microblaze/mmu.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
index 1068bd2d52b..2aca39c923b 100644
--- a/target/microblaze/mmu.h
+++ b/target/microblaze/mmu.h
@@ -86,7 +86,7 @@ typedef struct {
 } MicroBlazeMMULookup;
 
 unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
-                           target_ulong vaddr, MMUAccessType rw, int mmu_idx);
+                           vaddr vaddr, MMUAccessType rw, int mmu_idx);
 uint32_t mmu_read(CPUMBState *env, bool ea, uint32_t rn);
 void mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);
 void mmu_init(MicroBlazeMMU *mmu);
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
index 8703ff5c657..db24cb399ce 100644
--- a/target/microblaze/mmu.c
+++ b/target/microblaze/mmu.c
@@ -78,7 +78,7 @@ static void mmu_change_pid(CPUMBState *env, unsigned int newpid)
 
 /* rw - 0 = read, 1 = write, 2 = fetch.  */
 unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
-                           target_ulong vaddr, MMUAccessType rw, int mmu_idx)
+                           vaddr vaddr, MMUAccessType rw, int mmu_idx)
 {
     MicroBlazeMMU *mmu = &cpu->env.mmu;
     unsigned int i, hit = 0;
@@ -172,7 +172,7 @@ unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
     }
 done:
     qemu_log_mask(CPU_LOG_MMU,
-                  "MMU vaddr=0x" TARGET_FMT_lx
+                  "MMU vaddr=0x%" VADDR_PRIx
                   " rw=%d tlb_wr=%d tlb_ex=%d hit=%d\n",
                   vaddr, rw, tlb_wr, tlb_ex, hit);
     return hit;
-- 
2.51.0


