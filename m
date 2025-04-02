Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1025C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Fg-0004KE-70; Wed, 02 Apr 2025 17:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05FZ-0004HB-Rk
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:03:54 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05FT-00065Z-Lb
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:03:50 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3995ff6b066so128569f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627824; x=1744232624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P+MUq/qnqToy0WuQoMaMbA62PYJH1lfvYMdLSiGC/Fs=;
 b=hs6i5bsU5F/XgrUWLocqG3oHftNBEEKmps4yKnxB+lZcfykAPuLizdAJ53uc2vh1SJ
 kWT1EJ+cYFTe0g4aoIotJxincuI8jcERDb61+s9Q9oaemCx0SiFCL8+n00IPWasLPLk/
 LPmuRpWFqK/EI7bSd/corgz4tkGrGwyeTt3Q3o42dfpNaxFzgQCwy8UfxWXDpCpD8MbH
 seIh7eqYuT1kjYZGcV4iJ3tGbVVo/uOYcH1fpiNTOgaqx9owl00z3nKIzuIq1c7Cep/w
 Ygfrz9Qn5jukPt+M5DqJuqeupNg2H6U4B67/EhQYjA7R5zIUus4+0+H66BNLTC4naR9+
 0xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627824; x=1744232624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P+MUq/qnqToy0WuQoMaMbA62PYJH1lfvYMdLSiGC/Fs=;
 b=Dpy9jLak3fgPdfR1XewTNNo0xR/ACHq9IfU6GBHkBea4JMHIhoSqGn5CCTTHZ48y53
 Iq2+FDzBDiUwqdouo7gvgHyN+UPWKFBN/+kT2xqxtv+PlShFEO3CgYJD3K9QCOSk25F8
 pJz8Nvr4EqmK7qufquMafltvxvy359AQESx7Ri0hFItmQJbfENhJ0V8yIDI2lT5l4oBE
 LUOUjeDxUkeQ8LQA21v7+0uHfYzNuGgeXkIjbelmZ+Ud5Awnu2DyZDjqOoV3EWKUaQZ7
 QlKP8cSAXITtdNOm9VKPqJ7qYupWLF2YqTRLRPI6TJ7rBzWTM2WyVLqKeZGhdEX0ZLHS
 Hq9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHsHl5fP6PVsHjMCKS72WQi1U01IFLvnNiy+ELTD69QSvxpl5wrttednHs7OsscoSwsyFHtY0ryOnZ@nongnu.org
X-Gm-Message-State: AOJu0YzHtG8KvlP8yVbTzdSfGtImOe+kKT47+nkcBWsW/q/nYs0oHyrU
 HOynI5BCKKrYBA47t1HbDaNhTMfb0Jk5KTRSPY9Hzl7ftt6UZx++hC+WNkrx/jzqMW1u/mmEWLe
 o
X-Gm-Gg: ASbGncvfpw5mIhVr1Nr9S7NhqcBxctFm2ZPvahI4mJdLgg+Bblb97W+78xO27snyHFU
 My1Ji+RUyc5fg7DGN88+MAbZ/Ama3fivBMmmbelasrLxwXbTQZyNJVZqUCx0YqVfD7Ys49f4usR
 k6l5mdt5zpUv+ycU3Vq0D8EcokXXHClRVXpSEi6KablsKkAKLQ3iylBr/wrKPpIctUtHaXZGU2H
 +si6N7F5wpdQZPrrItqVcN/hrjahsKXRfU/7I1l6Q0ybJu0Mw2B3o+T1pjs/3t7E3dQnwL0PHTe
 +IWnUIlmOvRVb1zUmBtG8j6MUFq5w3yYgSE6vhMyiEthSczuzjL/xM6aIKoT6xiWmxnwWA7eQUe
 4AKcQGxz7HHwUGMZB63w=
X-Google-Smtp-Source: AGHT+IGotAT44/BNUkEpYm8ecSQFTlZUmldMNdH5g+8+c6/Bh9Rb9gK/bASssnLTqS8M9Xt/GqZuNQ==
X-Received: by 2002:a05:6000:184e:b0:390:d6ab:6c49 with SMTP id
 ffacd0b85a97d-39c2f8f64dcmr108628f8f.35.1743627824587; 
 Wed, 02 Apr 2025 14:03:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb6103a07sm31825805e9.29.2025.04.02.14.03.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:03:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 03/43] hw/core/cpu: Update CPUClass::mmu_index
 docstring
Date: Wed,  2 Apr 2025 23:02:48 +0200
Message-ID: <20250402210328.52897-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Since commits 32a8ea12fab..90b7022e698 (target: "Split out
TARGET_env_mmu_index"), target's memory_rw_debug() callbacks
use the target's TARGET_env_mmu_index(), not the generic
CPUClass::mmu_index() callback. Update the documentation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 84a71d8cf17..60b7abaf49b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -104,8 +104,7 @@ struct SysemuCPUOps;
  *                 instantiatable CPU type.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
- * @mmu_index: Callback for choosing softmmu mmu index;
- *       may be used internally by memory_rw_debug without TCG.
+ * @mmu_index: Callback for choosing softmmu mmu index.
  * @memory_rw_debug: Callback for GDB memory access.
  * @dump_state: Callback for dumping state.
  * @query_cpu_fast:
-- 
2.47.1


