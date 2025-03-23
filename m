Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E48C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPGU-0005nu-EJ; Sun, 23 Mar 2025 13:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGS-0005nA-KF
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:36 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twPGP-0002sY-Iw
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:37:34 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso55279645ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742751452; x=1743356252; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0CsTLV8c98Si7k0XcXe65xYgFmk/mGZL9wnBem+k0DA=;
 b=gRRCwdE4H4oCfNJw0zNmRbA/DKwcznWTBGXwypiI633iApx1o9BAn1E0AQYp3Y/5G0
 LM1EqClvE8YZFoIutbrwSS+xi/YNtztM2hRfkW3XNN5gjD3y0gCkZER9urLoOplvylXe
 a+MhgrV4gJ1hKkE5lvXt2Zj5dsCfZSSCXXNwtNe0X1H/vekUK9i3EAO9VPg9HesJ4XQY
 4ArjxEiA3XPpVwVC+5j71T4GwC+EtsSmasO/zpVdzzFmjUsxpeN0sA3h7Aoyam9KvDV+
 7CoRzhezTrAybe/QWy3ajW+f0mJZlOUqkwJA/pcsYzJNrmqJmW1+EYXhZZ3Ql6KHyA9w
 aa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742751452; x=1743356252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0CsTLV8c98Si7k0XcXe65xYgFmk/mGZL9wnBem+k0DA=;
 b=LFS958+q6jXqa0eYR80sCselJa2ilzy7GqcSdT+fZIbtyw03LglFVSRb3bftRIvfIn
 weyLPONDiQ78BlOfeM7sCP6KhchZG1Txt35mnfG5eRs914qUlDiCeBJtSCJBE5N+3E3o
 Zywfl5Gm3V6te5xI9IZBuf7a25rr01vXdts1lvYz/5t9C5w4xgSrEzwiOG1Ye11sJW1G
 2YnZGuakKWswn1rchzO5VDbCiF88qROgRZDtNCdna47gadppARxXD++PvHIH4yH0oy82
 WxUknSZdCyoOsTa7IerDGxRtJapPurWdswMn24QMegrVjzoyXSTVOuhLi3oQiXxlbobA
 1Dlg==
X-Gm-Message-State: AOJu0YyN00YLCOJkR+2cYFhKikolUfaBuDz/aGvdlerGW2zqbCpK0glZ
 xZboTuXH4IWEwSHHLYSMRhLp/2ac8cacnVV22agxrX1npTBoSfTw2qnh5qgpVAix3Mgl+KajJB7
 N
X-Gm-Gg: ASbGncs5XkSRwPQpw6owW8y5dLvb5MM2UcaNze/hJFxZZnakrT6M3959MboY+7SFVy7
 LT+b0gaAijNB2RvcE7HcWnOidw0BqNPQ5P6H11868j0CS8XTPWrM1vWcC8gEnyPMSS2tQGaDRvB
 VunoB8r9VTlwiIJ5Ybd2FmVWtQYdLw9FWW+E5SSGHlMPeveN9R2iCGrugeBr7rLJEjorH90h4+6
 iM6DZKgZGOpPHggFWfuCEfmEjuKJj1mlHSYEQaLdAxkYMt1ef/Cu9Wsy2EXUR/R2HyULA8YbKSz
 QI05mR06DHiVS7L1o5h6nY9iYL163Fe7WZrPgZrHgReNg3VwupGNfM502LYOCjigoI3J9m5n079
 p
X-Google-Smtp-Source: AGHT+IG2X95hsRawzwhbLQ3RGAlspim9GUHMC/QvXyscJbZmJqJzclYSgQ/xg2p+o2hn0Dh49W20wg==
X-Received: by 2002:a17:902:c949:b0:21f:2e:4e4e with SMTP id
 d9443c01a7336-2278067c0a6mr150255595ad.5.1742751451834; 
 Sun, 23 Mar 2025 10:37:31 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22781209ff3sm54075165ad.257.2025.03.23.10.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 10:37:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mrolnik@gmail.com,
	philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH 01/17] hw/core/cpu: Use size_t for memory_rw_debug len argument
Date: Sun, 23 Mar 2025 10:37:13 -0700
Message-ID: <20250323173730.3213964-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250323173730.3213964-1-richard.henderson@linaro.org>
References: <20250323173730.3213964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Match the prototype of cpu_memory_rw_debug().

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h     | 2 +-
 target/sparc/cpu.h        | 2 +-
 target/sparc/mmu_helper.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5d11d26556..abd8764e83 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -154,7 +154,7 @@ struct CPUClass {
 
     int (*mmu_index)(CPUState *cpu, bool ifetch);
     int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
-                           uint8_t *buf, int len, bool is_write);
+                           uint8_t *buf, size_t len, bool is_write);
     void (*dump_state)(CPUState *cpu, FILE *, int flags);
     void (*query_cpu_fast)(CPUState *cpu, CpuInfoFast *value);
     int64_t (*get_arch_id)(CPUState *cpu);
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 462bcb6c0e..68f8c21e7c 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -604,7 +604,7 @@ void dump_mmu(CPUSPARCState *env);
 
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
 int sparc_cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
-                              uint8_t *buf, int len, bool is_write);
+                              uint8_t *buf, size_t len, bool is_write);
 #endif
 
 /* translate.c */
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 7548d01777..3821cd91ec 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -389,7 +389,7 @@ void dump_mmu(CPUSPARCState *env)
  * that the sparc ABI is followed.
  */
 int sparc_cpu_memory_rw_debug(CPUState *cs, vaddr address,
-                              uint8_t *buf, int len, bool is_write)
+                              uint8_t *buf, size_t len, bool is_write)
 {
     CPUSPARCState *env = cpu_env(cs);
     target_ulong addr = address;
-- 
2.43.0


