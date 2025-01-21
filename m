Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69E9C0218C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 14:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taFB5-0000az-07; Tue, 21 Jan 2025 09:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFAz-0000Xj-21
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:21 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taFAw-00035r-Rl
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 09:24:20 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3862f32a33eso2605101f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 06:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737469457; x=1738074257; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TsVY/fcRHeZXKk3a5d2Km1G2q9T8ML5TT9t31iGbzvY=;
 b=NfXod6/rdzemCPAe4mdDtTTVgoo7y7nMq/o094G+cJwnJVpmBIVRUmtN3/9cGuec6q
 F569eYFvRyOERouYEgHCZJWJWy8R7tV1bnzas6k7NU6C5NH6VTpEivlFkAoNypY4q90W
 wbHP3nMRf0hqL3pZR3sV6GnloQyuBIzykVVAM3ni1ncbsVOpAqnS2KtgU9gE21WD7rt+
 e4ihH6NFnbH+LxSOh/AtlrUwSLf9ITzyweCLpqJEtVI++sitzdu4YhzFegx4cCLdLirI
 UJ5aZzLty/1JmI1qt1aMgdsRH5IN1dVw9kidF/s9WZ9MrhDIs45BYqeSFKK9JlvJxIFm
 77sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737469457; x=1738074257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TsVY/fcRHeZXKk3a5d2Km1G2q9T8ML5TT9t31iGbzvY=;
 b=qdiEo1nI9GvWwYVVkCwvUZa5fPK4BHLIa/MGx2dgVfix58z9hqvRujyHOrRAajBzPl
 imhdQDIA5fY1ec6LHNpnWy76osfWzyqhqJhgemPPKVsFbur1ljTHK4mHypw5mxTBM6Rx
 PPX2hm3+8tRSEkG/2T9H2V7wY/iU/Tueewuxo6hgTGsqpjnayd8Z+VBTd0p8yAhSfDwf
 0/ZRZMt7yDOB8fD8xcY6C9jf6n71xF0NaBACf3kH5HwWcX+NciCe7D7Xfn0BIpO7ojaA
 U9npq+BbCWy6CREpsSCLLRdSj5B7qs1EnUsb0DedepuFzt187f/JGJ/9G1tO6UdbQc1n
 Bffw==
X-Gm-Message-State: AOJu0YyPFkZ0MFx8VsgnJs/3zaC8/9pP7aIVp1jUBkOpSLIwID0wQKjS
 MAgx+UEr1Booj0q5P/bAkkA/vXWQSqlBnp9mJT4uKmcyc5m/hngiFI/yopQJ8rMRA//ZiGFdB/u
 gtHI=
X-Gm-Gg: ASbGncsVS2jI2tgUpCzJrhbqv6tUZDmmEFzGzXsjmAI3ZfzqlLOUA1nhE0eo4nUxSdK
 GHMsYQKrcyezfmqL/chel3is/mJA71wFrcqKTcumiSRNdjsF1LXcbXp8gvvDRLjhJDK6oxP31NN
 ydq4HC3KPUNXWrXEvttDahpPc1JOiEvvoBESP3zH8ww/WVc23Hv6juWu7U57TiLUCkW0YTIKxIe
 Tc61BAqzHTOBdJzZCFg4ys7m7RoXVF/FqbohYUUUEp7YnD7U9Ky8LrjRygNn2TxEw3/tpnefnVm
 1J72JzYadd6JJYHgm7XYIet0jZ1C8hcl3QIvoDrHhiZY
X-Google-Smtp-Source: AGHT+IGTydqLNfzweZB411kRbV7hpURXpknMF7xt9dbj/T0lfmlVTsVP5DxJy6Q4H4Keq+8EUtkGcw==
X-Received: by 2002:a05:6000:2a9:b0:385:dea3:6059 with SMTP id
 ffacd0b85a97d-38bf57b64d5mr15824747f8f.49.1737469456865; 
 Tue, 21 Jan 2025 06:24:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf32755cesm13442420f8f.78.2025.01.21.06.24.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 06:24:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/28] cpus: Introduce SysemuCPUOps::has_work() handler
Date: Tue, 21 Jan 2025 15:23:20 +0100
Message-ID: <20250121142341.17001-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121142341.17001-1-philmd@linaro.org>
References: <20250121142341.17001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

SysemuCPUOps::has_work() is similar to CPUClass::has_work(),
but only exposed on system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h | 4 ++++
 hw/core/cpu-system.c             | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 0df5b058f50..dee8a62ca98 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -16,6 +16,10 @@
  * struct SysemuCPUOps: System operations specific to a CPU class
  */
 typedef struct SysemuCPUOps {
+    /**
+     * @has_work: Callback for checking if there is work to do.
+     */
+    bool (*has_work)(CPUState *cpu);
     /**
      * @get_memory_mapping: Callback for obtaining the memory mappings.
      */
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 16d5efee12d..7b16bda2250 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -25,6 +25,10 @@
 
 bool cpu_has_work(CPUState *cpu)
 {
+    if (cpu->cc->sysemu_ops->has_work) {
+        return cpu->cc->sysemu_ops->has_work(cpu);
+    }
+
     g_assert(cpu->cc->has_work);
     return cpu->cc->has_work(cpu);
 }
-- 
2.47.1


